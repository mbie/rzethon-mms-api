# MMS API

Rzethon hackathon project, server side implementation simulating distributed relay system for passing messages and reporting on delivery status.

Done with rails, with sidekiq as async worker, redis queue/cache and postgres/sqlite3 as database.

## run instructions

* get docker-compose
* run docker-compose up
* the 'main' node is available as localhost:3000 - the others are visible with their own ip address :3000
* you can view the list simply under localhost:3000/nodes
* if you want to simulate more than 2 nodes, just 'docker-compose scale slave_node=x' where x is node amount
* nodes keep their databases locally on the container, this allows for quick 'clean slate' run, just:
  * docker-compose down && docker-compose up  --  this removes the containers so you get an empty env on the 'up' action
  * docker-compose up --force-recreate -- this does the same in one command
* keep in mind that you do not rebuild the image itself - so recreating containers is relatively simple
* if you change a gem in the Gemfile or otherwise modify the machine setup, you need to 'docker-compose build' - compose doesn't build by default
* any change in code should be visible after page refresh
