FROM python:3.6.5-stretch
ENV PYTHONUNBUFFERED 1
ENV DJANGO_SETTINGS_MODULE budget_proj.settings.production
# add required Debian packages
RUN apt-get update && apt-get install -qqy --no-install-recommends jq && apt-get clean
WORKDIR /code
ADD requirements/ /code/
RUN pip install -r prod.txt
ADD . /code/
ENTRYPOINT [ "/code/bin/docker-entrypoint.sh" ]