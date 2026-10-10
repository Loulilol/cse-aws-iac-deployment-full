#!/bin/bash
set -euo pipefail

LOG_FILE="/var/log/ec2-init.log"

log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" | tee -a "$LOG_FILE"
}

trap 'log "ERROR: script failed at line $LINENO"' ERR

NICKNAME="${nickname}"

MYSQL_HOST="${db_host}"
MYSQL_DATABASE="${db_name}"
MYSQL_USER="${db_user}"
MYSQL_PASSWORD="${db_password}"

log "Starting CSE AWS deployment"

#Update the list of packages
log "Updating packages"
dnf update -y

# Install required dependencies
log "Installing dependencies"
dnf install -y \
    httpd \
    php \
    php-mysqlnd \
    php-fpm \
    git \
    mariadb105

systemctl enable httpd
systemctl enable php-fpm

systemctl start httpd
systemctl start php-fpm

# Remove default Apache2 webpage
log "Removing default web content"
rm -rf /var/www/html/picturegallery

# Clone the website repository from GitHub.
log "Cloning website repository"
git clone "https://github.com/csdso-wavestone/picturegallery" /tmp/site/picturegallery || {
    log "ERROR: Git clone failed"
    exit 1
}
cp -R /tmp/site/* /var/www/html/

# Setting up Apache2 and restart it
log "Setting permissions"
chown -R apache:apache /var/www/html/picturegallery
find /var/www/html/picturegallery -type d -exec chmod 755 {} \;
find /var/www/html/picturegallery -type f -exec chmod 644 {} \;
chown apache:apache /var/www/html/picturegallery/uploads

# Wait until MySQL is available
MAX_RETRIES=60
RETRY_COUNT=0

log "Waiting for MySQL availability"

while ! mysql \
    -h "$MYSQL_HOST" \
    -u "$MYSQL_USER" \
    -p"$MYSQL_PASSWORD" \
    -e "SELECT 1" >/dev/null 2>&1
do
    RETRY_COUNT=$((RETRY_COUNT + 1))

    log "MySQL unavailable, attempt $RETRY_COUNT/$MAX_RETRIES"

    if [ "$RETRY_COUNT" -ge "$MAX_RETRIES" ]; then
        log "Unable to connect to RDS"
        exit 1
    fi

    sleep 10
done


# Initialize database
log "Initializing database"
mysql \
    -h "$MYSQL_HOST" \
    -u "$MYSQL_USER" \
    -p"$MYSQL_PASSWORD" \
    --force \
    "$MYSQL_DATABASE" \
    < /var/www/html/picturegallery/sql.sql || {
        log "ERROR: Database initialization failed"
        exit 1
    }
log "Database initialized"


# Replace hardcoded credentials
log "Updating mysqli_connect.php"
sed -i "s|\$db_user = .*;|\$db_user = getenv('DB_USER');|g" /var/www/html/picturegallery/mysqli_connect.php
sed -i "s|\$db_password = .*;|\$db_password = getenv('DB_PASSWORD');|g" /var/www/html/picturegallery/mysqli_connect.php
sed -i "s|\$db_host = .*;|\$db_host = getenv('DB_HOST');|g" /var/www/html/picturegallery/mysqli_connect.php
log "Database connection file updated"


# Configure PHP-FPM
PHP_FPM_CONF="/etc/php-fpm.d/www.conf"

log "Configuring PHP-FPM"
grep -q "^clear_env = no" "$PHP_FPM_CONF" || \
sed -i 's/^;* *clear_env *= *.*/clear_env = no/' "$PHP_FPM_CONF"

cat << EOF >> "$PHP_FPM_CONF"
env[DB_HOST] = "$${MYSQL_HOST}"
env[DB_USER] = "$${MYSQL_USER}"
env[DB_PASSWORD] = "$${MYSQL_PASSWORD}"
EOF


# Upload directory permissions
log "Updating uploads permissions"
chown apache "/var/www/html/picturegallery/uploads"

# Restart web services
log "Restarting services"
systemctl restart php-fpm && systemctl restart httpd

log "Deployment completed successfully"