FROM python:3.5
ENV PYTHONUNBUFFERED 1
RUN mkdir /code
WORKDIR /code
ADD requirements.txt /code/
RUN pip install -r requirements.txt
ADD . /code/
RUN mkdir /Data
WORKDIR /Data
RUN wget \
    -O /Data/Budget_in_Brief_KPM_data_All_Years.csv \
    https://raw.githubusercontent.com/hackoregon/team-budget/master/Data/Budget_in_Brief_KPM_data_All_Years.csv
RUN wget \
    -O /Data/Budget_in_Brief_OCRB_data_All_Years.csv \
    https://raw.githubusercontent.com/hackoregon/team-budget/master/Data/Budget_in_Brief_OCRB_data_All_Years.csv
WORKDIR /code
ENTRYPOINT [ "/code/bin/docker-entrypoint.sh" ]
