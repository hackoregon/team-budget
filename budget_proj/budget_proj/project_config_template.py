'''
To connect to database, make a copy of this file as "project_config.py" and replace VALUES as noted.
'''

AWS = {
    'ENGINE': 'PUT_DATABASE_ENGINE_HERE', # e.g. django.db.backends.postgresql
    'NAME': 'PUT_DATABASE_NAME_HERE', # e.g. budget
    'HOST': 'PUT_HOST_FQDN_OR_IP_ADDRESS_HERE',
    'PORT': 'PUT_DATABASE_PORT_HERE', # e.g. 5432
    'USER': 'PUT_DATABASE_LOGIN_ID_HERE',
    'PASSWORD': 'PUT_DATABASE_PASSWORD_HERE'
}
DJANGO_SECRET = 'PUT_DJANGO_SECRET_HERE'

# Note: the 192.168.99.100 address is necessary to enable testing with Docker Toolbox for Mac and Windows
ALLOWED_HOSTS = ['127.0.0.1', 'localhost', '192.168.99.100']
