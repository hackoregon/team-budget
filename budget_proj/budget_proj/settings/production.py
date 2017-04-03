import requests

from .base import *
from .. import project_config


SECRET_KEY = project_config.DJANGO_SECRET_KEY

# Duplicated this line in this file in an attempt to fix the trouble we're having in AWS:
# "Invalid HTTP_HOST header: '10.180.34.248:50036'. You may need to add '10.180.34.248' to ALLOWED_HOSTS."
ALLOWED_HOSTS = ['127.0.0.1', 'localhost', '192.168.99.100', 'hacko-integration-658279555.us-west-2.elb.amazonaws.com']

# Get the IPV4 address we're working with on AWS
# The Loadbalancer uses this ip address for healthchecks
EC2_PRIVATE_IP = None
try:
    EC2_PRIVATE_IP = requests.get('http://169.254.169.254/latest/meta-data/local-ipv4', timeout=0.01).text
except requests.exceptions.RequestException:
    pass

if EC2_PRIVATE_IP:
    ALLOWED_HOSTS.append(EC2_PRIVATE_IP)

# Database
# https://docs.djangoproject.com/en/1.10/ref/settings/#databases
DATABASES = {
    'default': {
        'ENGINE': project_config.AWS['ENGINE'],
        'NAME': project_config.AWS['NAME'],
        'HOST': project_config.AWS['HOST'],
        'PORT': project_config.AWS['PORT'],
        'USER': project_config.AWS['USER'],
        'PASSWORD': project_config.AWS['PASSWORD'],
    }
}