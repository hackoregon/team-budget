'''
To connect to a database, make a copy of this file as 'project_config.py' 
and replace the VALUES as noted. The default is set up for development with
an embedded database, which only requires a couple of properties.

If you need to connect to an external database, you should comment out
the dev values and uncomment the full set of connection parameters for
the database that you are using.

The properties defined in 'project_config.py' are imported by './settings'
files, such as './settings/dev.py' and './settings/production.py'.

The reason you need to copy this file to 'project_config.py', rather than
setting values directly in this file is that 'project_config.py' is listed
in '.gitignore'. Therefore, you can put your password safely in 
'project_config.py', because it will never be committed to the source code 
repository.
'''

AWS = {
    # Specify parameters for either SQLite or an external database, but not both!

    # If you are using Django's 'runserver' tool to run locally,
    # then use the embedded database, which works well for development:
    'ENGINE': 'django.db.backends.sqlite3',
    'NAME': 'budget_db.sqlite3',
    'HOST': 'NOT_NEEDED_FOR_SQLITE',
    'PORT': 'NOT_NEEDED_FOR_SQLITE',
    'USER': 'NOT_NEEDED_FOR_SQLITE',
    'PASSWORD': 'NOT_NEEDED_FOR_SQLITE'

    # If your are building a Docker image to run locally or to deploy remotely,
    # then use an external database, such as a PostgreSQL database running
    # locally. Also, use these connection parameters if you are using
    # the integration or production database, both of which are hosted on
    # AWS EC2 instances.
    # 'ENGINE': 'PUT_DATABASE_ENGINE_HERE', # e.g. django.db.backends.postgresql
    # 'NAME': 'PUT_DATABASE_NAME_HERE', # e.g. budget
    # 'HOST': 'PUT_HOST_FQDN_OR_IP_ADDRESS_HERE',
    # 'PORT': 'PUT_DATABASE_PORT_HERE', # e.g. 5432
    # 'USER': 'PUT_DATABASE_LOGIN_ID_HERE',
    # 'PASSWORD': 'PUT_DATABASE_PASSWORD_HERE'
}
DJANGO_SECRET_KEY = 'PUT_DJANGO_SECRET_HERE'

# Note: the 192.168.99.100 address is necessary to enable testing with Docker Toolbox for Mac and Windows
ALLOWED_HOSTS = ['127.0.0.1', 'localhost', '192.168.99.100']
