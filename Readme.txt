This is a tutorial on using mysql+nginx+uwsgi to quickly build a django server, using docker for one-click deployment, and say goodbye to the difficulty of environment construction

1. Just run the command: [docker-compose up] in the root directory
2. Description of parameters related to the .env file in the root directory:
    a. COMPOSE_PROFILES has two values, release and debug, release will run uwsgi --ini uwsgi.ini, and debug will run python manage.py runserver
    b. DJANGO_PORT is the external port for debug, and NGINX_PORT is the external port for release
    c. NGINX_SERVER_NAME is the server name, such as domain name or ip address
3. The data of mysql is generated in data. If you need to clear the data, just delete the folder, but you need to be careful.
