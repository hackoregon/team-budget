# to connect to database, copy this file as project_config.py and replace values as specified
AWS = {
    'ENGINE': 'django.db.backends.postgresql',
    'NAME': 'PUT_DATABASE_NAME_HERE',
    'HOST': 'PUT_HOST_FQDN_OR_IP_ADDRESS_HERE',
    'USER': 'PUT_DATABASE_LOGIN_ID_HERE',
    'PASSWORD': 'PUT_DATABASE_PASSWORD_HERE'
    }
DJANGO_SECRET = 'PUT_DJANGO_SECRET_HERE'
