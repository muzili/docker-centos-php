pre_start_action() {
    mkdir -p /etc/supervisor/conf.d
    cat > /etc/supervisor/conf.d/supervisord.conf <<-EOF
[supervisord]
nodaemon=true

[program:php5-fpm]
command=/usr/sbin/php-fpm --nodaemonize

[program:nginx]
command=/usr/sbin/nginx

EOF
    mkdir -p /var/log/php-fpm/
    mkdir -p /var/log/nginx
}

post_start_action() {
    rm /first_run
}
