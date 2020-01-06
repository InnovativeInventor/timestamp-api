FROM python:latest

MAINTAINER InnovativeInventor

WORKDIR /usr/src/app

RUN apt-get update && apt-get install -y \
    npm git \
    && npm install npm@latest -g && rm -rf /var/lib/apt/lists/*
RUN git clone https://github.com/InnovativeInventor/timestamp-api /usr/src/app
RUN pip install gunicorn flask Flask-Caching apscheduler opentimestamps-client
RUN npm install -g opentimestamps 

RUN mkdir -p /usr/src/app/hash

EXPOSE 8000
CMD [ "gunicorn", "app:app", "-w", "4", "--bind", ":8000" ]
