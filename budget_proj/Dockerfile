FROM python:3.5
ENV PYTHONUNBUFFERED 1
ENV DJANGO_SETTINGS_MODULE budget_proj.settings.production
WORKDIR /code
ADD requirements/ /code/
RUN pip install -r prod.txt
ADD . /code/
ENTRYPOINT [ "/code/bin/docker-entrypoint.sh" ]
