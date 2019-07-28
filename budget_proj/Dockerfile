FROM python:3.5
ENV PYTHONUNBUFFERED 1
ENV DJANGO_SETTINGS_MODULE budget_proj.settings.production
# add required Debian packages
RUN apt-get update \
  && apt-get install -qqy --no-install-recommends \
    # binutils \
    jq \
  && apt-get clean
WORKDIR /code
ADD requirements/ /code/
RUN pip install -r prod.txt
ADD . /code/
ENTRYPOINT [ "/code/bin/docker-entrypoint.sh" ]
