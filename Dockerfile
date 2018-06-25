FROM node:8.11.2-alpine

RUN apk add --update bash git make
ADD . .

CMD ["make run"]