#!/usr/bin/env bash

ruby $HOME/config/htpasswd.rb
erb $HOME/config/nginx.conf.erb > $HOME/config/nginx.conf

mkdir -p $HOME/logs/nginx
touch $HOME/logs/nginx/access.log $HOME/logs/nginx/error.log

(tail -f -n 0 $HOME/logs/nginx/*.log &)

export LD_LIBRARY_PATH=$HOME/vendor/openresty-1.9.15.1/build/luajit-root/app/vendor/openresty-heroku-build/luajit/lib:$LD_LIBRARY_PATH
exec $HOME/vendor/openresty-heroku-build/nginx/sbin/nginx -p $HOME -c $HOME/config/nginx.conf
