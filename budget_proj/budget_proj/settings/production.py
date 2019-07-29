import requests

import os
from .base import *
# from .. import project_config
print("This is from within production.py...")
# print("POSTGRES_NAME: " + os.environ.get('POSTGRES_NAME'))


SECRET_KEY = os.environ.get('DJANGO_SECRET_KEY')

# ALLOWED_HOSTS = project_config.ALLOWED_HOSTS
ALLOWED_HOSTS = ['*']

# Get the IPV4 address we're working with on AWS
# The Loadbalancer uses this ip address for healthchecks
# EC2_PRIVATE_IP = None
# try:
#     EC2_PRIVATE_IP = requests.get('http://169.254.169.254/latest/meta-data/local-ipv4', timeout=0.01).text
# except requests.exceptions.RequestException:
#     pass

# if EC2_PRIVATE_IP:
#     ALLOWED_HOSTS.append(EC2_PRIVATE_IP)

# Database
# https://docs.djangoproject.com/en/1.10/ref/settings/#databases
DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.postgresql',
        'PASSWORD': os.environ.get('POSTGRES_PASSWORD'),
        'NAME': os.environ.get('POSTGRES_NAME'),
        'USER': os.environ.get('POSTGRES_USER'),
        'HOST': os.environ.get('POSTGRES_HOST'),
        'PORT': os.environ.get('POSTGRES_PORT'),    }
}
