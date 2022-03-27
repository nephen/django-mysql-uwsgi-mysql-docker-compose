# Django
This is a tutorial on using mysql+nginx+uwsgi to quickly build a django server, using docker for one-click deployment, and say goodbye to the difficulty of environment construction

## Settings
Description of parameters related to the .env file in the root directory:
- COMPOSE_PROFILES has two values, release and debug, release will run uwsgi --ini uwsgi.ini, and debug will run python manage.py runserver
- DJANGO_PORT is the external port for debug, and NGINX_PORT is the external port for release
- NGINX_SERVER_NAME is the server name, such as domain name or ip address

## Get Started
Just run the command: [docker-compose up] in the root directory
```
$ git clone https://github.com/nephen/django-mysql-uwsgi-mysql-docker-compose.git
$ cd django-mysql-uwsgi-mysql-docker-compose
$ docker-compose up #If you need to run in the background, add the -d parameter
```
After waiting for the startup to complete, you can visit Django's initialization webpage, the address is NGINX_SERVER_NAME in the .env file, similar to http://127.0.0.1

Set the admin administrator to log in to the web background interface
```
$ docker ps
$ docker exec -ti django python manage.py createsuperuser
```
You can now log in to Django's admin page at NGINX_SERVER_NAME/admin, similar to http://127.0.0.1/admin

## How to use your own project?
For related knowledge of docker-compose, please refer to: https://docs.docker.com/samples/django/
Django tutorial reference: https://docs.djangoproject.com/zh-hans/2.0/intro/tutorial01/
```
$ cd django-mysql-uwsgi-mysql-docker-compose
$ mv project project.bak
$ cp -r your-existing-project .
$ cp -r your-existing-app .
```
Note: If your project name is not project, you need to modify the DJANGO_PROJECT_NAME in the .env file in the root directory to be your project name

In your project directory, edit the your-existing-project/settings.py file.
Replace the DATABASES = ... with the following:
```
# settings.py
   
import os
   
DEBUG = True

ALLOWED_HOSTS = ['*']

[...]

DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.mysql',
        'NAME': os.environ.get('MYSQL_NAME'),
        'USER': os.environ.get('MYSQL_USER'),
        'PASSWORD': os.environ.get('MYSQL_PASSWORD'),
        'HOST': os.environ.get('MYSQL_HOST'),
        'PORT': os.environ.get('MYSQL_PORT'),
        'OPTIONS': {
            "init_command": "SET foreign_key_checks = 0;",
            'charset': 'utf8mb4' #utf8mb4
        },
    }
}

STATIC_ROOT = os.path.join(BASE_DIR, 'static').replace('\\', '/')
DEFAULT_AUTO_FIELD = 'django.db.models.BigAutoField'
```

Then start to start. If you find that there are no dependent files, you need to update the requirements.txt file and rebuild until the dependencies are resolved and start normally.
```
$ docker-compose up
$ vi requirements.txt // Install dependencies if needed
$ docker-compose build
```

## Troubleshooting
### How to ensure that django starts working after mysql starts normally?
Refer to the wait-for scheme given by this website: https://docs.docker.com/compose/startup-order/, The github address is https://github.com/eficode/wait-for, It will wait for mysql to start normally before starting django

### How to modify or increase the nginx configuration file？
You can modify or add the template file in the conf/templates directory. The shell environment variable can be used in this file.

### What should I do if the startup fails?
Try restarting to see if it works, otherwise you can help to raise issues

## Warnings
The data of mysql is generated in data. If you need to clear the data, just delete the folder, but you need to be careful.
