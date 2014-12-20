#!/bin/bash
# Starts up Nginx and PHP-FPM within the container.

# Stop on error
set -e

if [[ -e /first_run ]]; then
  source /scripts/first_run.sh
else
  source /scripts/normal_run.sh
fi

pre_start_action
post_start_action

exec supervisord -c /etc/supervisor/conf.d/supervisord.conf
