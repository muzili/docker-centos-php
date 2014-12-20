pre_start_action() {
    mkdir -p /etc/supervisor/conf.d
    cat > /etc/supervisor/conf.d/supervisord.conf <<-EOF
[supervisord]
nodaemon=true

[program:php5-fpm]
command=/usr/sbin/php5-fpm --nodaemonize

[program:nginx]
command=/usr/sbin/nginx

EOF
}

post_start_action() {
    rm /first_run
}
