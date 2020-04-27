# docker-lumen-sqlsrv
docker image with lumen microframework and sql server driver

1- create a folder /src and place lumen source code there

2- type this on command line:
docker build -t lumen .  
docker run -ti -p 80:80 -v ${PWD}/src:/var/www/html  --rm --name lumen lumen:latest

3- run: 
composer install

4- access http://127.0.0.1

TO-DO:
run composer after docker build..
