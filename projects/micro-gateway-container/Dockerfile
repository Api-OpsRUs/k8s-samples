FROM node:latest

RUN npm install edgemicro -g

ADD edgemicro-configure-start.sh /tmp/edgemicro-configure-start.sh

EXPOSE 8000

RUN ["chmod", "+x", "/tmp/edgemicro-configure-start.sh"]

ENTRYPOINT  ["/tmp/edgemicro-configure-start.sh" ]
