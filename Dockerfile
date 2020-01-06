FROM python:latest

MAINTAINER InnovativeInventor

WORKDIR /usr/src/app

RUN apt-get update && apt-get upgrade -y && apt-get install git -y
RUN git clone https://github.com/InnovativeInventor/timestamps-api /usr/src/app
RUN pip3 install gunicorn flask Flask-Caching
RUN apt-get update && apt-get install -y \
    npm \
    && rm -rf /var/lib/apt/lists/*
RUN npm install -g opentimestamps && pip install opentimestamps-client && rm Dockerfile

EXPOSE 8000
CMD [ "gunicorn", "app:app", "-w", "4", "--bind", ":8000" ]
