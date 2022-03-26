#!/bin/sh

python manage.py makemigrations
python manage.py migrate
python manage.py collectstatic --no-input

mkdir -p /code/log

while [ $# != 0 ]
do
    case $1 in
    "debug")
        python manage.py runserver 0.0.0.0:${DJANGO_PORT}
        ;;
    "release")
        uwsgi --ini /code/conf/uwsgi.ini
        ;;
    *)
        ;;
    esac
    shift
done
