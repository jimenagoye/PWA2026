#!/bin/bash

if [ ! -f manage.py ]
    then
        django-admin startproject app .
fi

echo "Esperando a que PostgreSQL acepte conexiones..."
until python -c "import os, psycopg2; psycopg2.connect(dbname=os.environ.get('POSTGRES_DB','aulas_db'), user=os.environ.get('POSTGRES_USER','postgres'), password=os.environ.get('POSTGRES_PASSWORD','postgres'), host=os.environ.get('DB_HOST','postgres'), port=5432)" 2>/dev/null; do
    echo "PostgreSQL todavia no esta listo, reintentando en 2s..."
    sleep 2
done
echo "PostgreSQL listo."

python manage.py makemigrations 
python manage.py migrate --noinput

if [[ ! -z "${DJANGO_SU_NAME}" ]]
    then
    echo "from django.contrib.auth.models import User; User.objects.filter(username='${DJANGO_SU_NAME}').exists() or User.objects.create_superuser('${DJANGO_SU_NAME}', '${DJANGO_SU_EMAIL}', '${DJANGO_SU_PASSWORD}')" | python manage.py shell
fi  

python manage.py runserver 0.0.0.0:8000