#!/bin/bash
gunicorn budget_proj.wsgi:application -b :8000