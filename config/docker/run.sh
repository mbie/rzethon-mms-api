#!/bin/bash

service redis-server start
rm -rf tmp/pids/server${HOSTNAME}.pid
sleep 2
bundle exec rake db:migrate
bundle exec rails s -b '0.0.0.0' -P tmp/pids/server${HOSTNAME}.pid &
sleep 2
bundle exec sidekiq -P tmp/pids/sidekiq${HOSTNAME}.pid
