FROM python:3.5
ENV PYTHONUNBUFFERED 1
ENV DJANGO_SETTINGS_MODULE budget_proj.settings.production
WORKDIR /code
ADD requirements/ /code/
RUN pip install -r prod.txt
ADD . /code/
RUN ls -la /code/
RUN ls -la /code/budget_proj/
ENTRYPOINT [ "/code/bin/docker-entrypoint.sh" ]
