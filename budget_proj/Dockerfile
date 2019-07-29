FROM python:3.6.5-stretch
ENV PYTHONUNBUFFERED 1
ENV DEBUG=True
ENV DJANGO_SETTINGS_MODULE budget_proj.settings.production
# add required Debian packages
RUN apt-get update && apt-get install -qqy --no-install-recommends jq && apt-get clean
WORKDIR /code
ADD requirements/ /code/
RUN pip install -r prod.txt
RUN pip install awscli
ADD . /code/
ENTRYPOINT [ "/code/bin/docker-entrypoint.sh" ]