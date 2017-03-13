'''
To connect to database, make a copy of this file as "project_config.py" and replace VALUES as noted.
'''

AWS = {
    'ENGINE': 'django.db.backends.postgresql',
    'NAME': 'PUT_DATABASE_NAME_HERE',
    'HOST': 'PUT_HOST_FQDN_OR_IP_ADDRESS_HERE',
    'PORT': 'PUT_PORT_HERE',
    'USER': 'PUT_DATABASE_LOGIN_ID_HERE',
    'PASSWORD': 'PUT_DATABASE_PASSWORD_HERE'
}
DJANGO_SECRET = 'PUT_DJANGO_SECRET_HERE'
