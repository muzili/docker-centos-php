FROM muzili/centos-nginx

MAINTAINER Joshua Lee <muzili@gmail.com>

# Install PHP stuff
RUN yum -y install --enablerepo=remi,remi-php55 \
  php-fpm \
  php-cli \
  php-gd \
  php-ldap \
  php-mbstring \
  php-mcrypt \
  php-mysqlnd \
  php-pdo \
  php-pear \
  php-pecl-apc \
  php-pecl-imagick \
  php-soap \
  php-xml

# Clean up YUM when done.
RUN yum clean all

RUN echo "cgi.fix_pathinfo = 0;" >> /etc/php.ini && \
    sed -i -e's/;default_charset = "UTF-8"/default_charset = "UTF-8"/g' /etc/php.ini
ADD etc/fastcgi_params.conf /etc/nginx/conf/fastcgi_params.conf
RUN mv /etc/php-fpm.d/www.conf /etc/php-fpm.d/www.conf.default
ADD etc/www.conf /etc/php-fpm.d/www.conf

ADD etc/default.conf /etc/nginx/sites-available/default.conf
RUN rm -f /etc/nginx/sites-enabled/*
RUN ln -s /etc/nginx/sites-available/default.conf /etc/nginx/sites-enabled

# Add Composer
RUN curl -sS https://getcomposer.org/installer | php && mv composer.phar /usr/local/bin/composer && chmod +x /usr/local/bin/composer

ADD scripts /scripts
RUN chmod +x /scripts/start.sh
RUN touch /first_run

# Expose our web root and log directories log.
VOLUME ["/srv/www", "/var/log"]

# Kicking in
CMD ["/scripts/start.sh"]

