"""
WSGI config for budget_proj project.

It exposes the WSGI callable as a module-level variable named ``application``.

For more information on this file, see
https://docs.djangoproject.com/en/1.10/howto/deployment/wsgi/
"""

import os
from django.core.wsgi import get_wsgi_application

# Monkey patching the application to help stabilize the Docker container deploy
# Deploying Docker containers to ECS often timed out and the new container would get killed by ALB
# That problem disappeared completely once this monkey patching was implemented
# https://github.com/hackoregon/devops-17/issues/49
from psycogreen.gevent import patch_psycopg
# thread=False used to address https://github.com/hackoregon/team-budget/issues/128
from gevent import monkey; monkey.patch_all(thread=False)

patch_psycopg()

from whitenoise.django import DjangoWhiteNoise

os.environ.setdefault("DJANGO_SETTINGS_MODULE", "budget_proj.settings.dev")

application = get_wsgi_application()

# WhiteNoise allows us to serve the Swagger static files directly from Django even when settings.py:DEBUG=False
# This saves us the trouble of having to build a static files web server, though that would be a great long-term solution
application = DjangoWhiteNoise(application)
