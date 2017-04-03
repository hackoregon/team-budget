import requests

from .base import *
from .. import project_config


SECRET_KEY = project_config.DJANGO_SECRET_KEY

AWS_LOAD_BALANCER='hacko-integration-658279555.us-west-2.elb.amazonaws.com'

ALLOWED_HOSTS.append(AWS_LOAD_BALANCER)

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