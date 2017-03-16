#!/bin/bash

echo  Running docker-entrypoint.sh...

# Fire up a lightweight frontend to host the DRF endpoints - gunicorn is convenient but other engines can be considered
gunicorn budget_proj.wsgi:application -b :8000
