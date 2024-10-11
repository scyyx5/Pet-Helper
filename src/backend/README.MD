You might have to install few things with cmd before running the backend:
pip install django
pip install djangorestframework
pip install physcopg2
pip install Pillow 
python -m pip install django-cors-headers
python -m pip install requests
pip install djangorestframework-simplejwt


To run back end server use this command in terminal:
python manage.py runserver

Remember if you are changing database or connecting to a different database or make any other changes remember to migrate:
python manage.py makemigrations
python manage.py migrate
