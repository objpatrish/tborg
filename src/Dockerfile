FROM alpine:latest

RUN apk update && apk add borgbackup

RUN mkdir -p /app

COPY ./tborg.sh /app/tborg.sh
COPY ./crontab.txt /app/crontab.txt
COPY ./entrypoint.sh /app/entrypoint.sh

RUN chmod +x /app/tborg.sh /app/entrypoint.sh

RUN /usr/bin/crontab /app/crontab.txt

VOLUME [ "/repo" ]
VOLUME [ "/archive" ]

ENTRYPOINT [ "/app/entrypoint.sh" ]