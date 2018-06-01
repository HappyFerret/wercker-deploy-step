FROM node:8.11.2-alpine

RUN apk add --update bash git
ADD . .

CMD ["/bin/sh", "-c", "./run.sh"]