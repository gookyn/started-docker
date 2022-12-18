# syntax=docker/dockerfile:1

FROM node:14.15.4 as base

WORKDIR /code

COPY package.json package.json
COPY yarn.lock yarn.lock

FROM base as test
RUN yarn install --frozen-lockfile
COPY . .
RUN npm run test

FROM base as prod
RUN yarn install --frozen-lockfile --production
COPY . .
CMD [ "node", "server.js" ]
