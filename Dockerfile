FROM node:21-alpine3.18 AS base

ENV DIR /usr/app
WORKDIR $DIR
ARG NPM_TOKEN

FROM base as local

ENV NODE_ENV=development

COPY package*.json $DIR

RUN echo "//registry.npmjs.org/:_authToken=$NPM_TOKEN" > $DIR/.npmrc && \
    npm install && \
    rm -f .npmrc

COPY tsconfig*.json $DIR
COPY src $DIR/src

EXPOSE $PORT
CMD ["npm", "run", "start:dev"]

FROM base AS build

RUN apk update && apk add --no-cache dumb-init

COPY package*.json $DIR
RUN echo "//registry.npmjs.org/:_authToken=$NPM_TOKEN" > $DIR/.npmrc && \
    npm ci && \
    rm -f .npmrc

COPY tsconfig*.json $DIR
COPY src $DIR/src

RUN npm run build && \
    npm prune --production


