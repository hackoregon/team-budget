'''
To connect to database, make a copy of this file as "project_config.py" and replace VALUES as noted
'''

AWS = {
    'ENGINE': 'django.db.backends.postgresql',
    'NAME': 'PUT_DATABASE_NAME_HERE',
    'HOST': 'PUT_DATABASE_HOST_HERE',
    'USER': 'PUT_DATABASE_USERNAME_HERE',
    'PASSWORD': 'PUT_DATABASE_PASSWORD_HERE'
    }

DJANGO_SECRET = 'PUT_DJANGO_SECRET_HERE'
