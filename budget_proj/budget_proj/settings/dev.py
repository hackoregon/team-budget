from .base import *

SECRET_KEY = 'Anything will do for local dev'
DEBUG = True

# Database
# https://docs.djangoproject.com/en/1.10/ref/settings/#databases
DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.sqlite3',
        'NAME': 'budget_db.sqlite3',
    },
}

# Try running with debug toolbar if installed
# https://django-debug-toolbar.readthedocs.io/en/stable/
try:
    import debug_toolbar

    INSTALLED_APPS += ['debug_toolbar']
    INTERNAL_IPS = ['127.0.0.1']
    MIDDLEWARE.insert(2, 'debug_toolbar.middleware.DebugToolbarMiddleware')
except ImportError:
    pass
