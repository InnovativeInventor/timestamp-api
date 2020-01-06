FROM python:latest

MAINTAINER InnovativeInventor

WORKDIR /usr/src/app

RUN apt-get update && apt-get install -y \
    npm git \
    && npm install npm@latest -g && rm -rf /var/lib/apt/lists/*

RUN git clone https://github.com/InnovativeInventor/timestamp-api /usr/src/app
RUN pip install waitress flask Flask-Caching apscheduler opentimestamps-client
RUN npm install -g opentimestamps 

#RUN mkdir -p /usr/src/app/hash
COPY app.py /usr/src/app/app.py

EXPOSE 8000
ENTRYPOINT [ "waitress-serve", "app:app" ]
