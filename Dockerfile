########## STAGE BASE ###################
FROM node:21-bullseye-slim AS base
ENV DIR /usr/app
WORKDIR $DIR
RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y --no-install-recommends dumb-init
COPY --chown=node:node . .
ARG NPM_TOKEN

########## STAGE LOCAL ###################
FROM base as local
ENV NODE_ENV=development

ARG AUTH_TOKEN
ARG REPOSITORY_URL
ARG REPOSITORY_URI

RUN echo $AUTH_TOKEN
RUN echo $REPOSITORY_URL
RUN echo $REPOSITORY_URI

# Login al repositorio de codeartifact
RUN npm config set registry=$REPOSITORY_URL
RUN npm config set //$REPOSITORY_URI:_authToken=$AUTH_TOKEN

COPY package*.json $DIR
RUN echo //$REPOSITORY_URI:_authToken=$AUTH_TOKEN > $DIR/.npmrc && \
    npm install && \
    rm -f .npmrc
COPY tsconfig*.json $DIR
COPY src $DIR/src
EXPOSE $PORT
USER node
CMD ["npm", "run", "start:dev"]
########## STAGE BUILD ###################
FROM base AS build

ARG AUTH_TOKEN
ARG REPOSITORY_URL
ARG REPOSITORY_URI

RUN echo $AUTH_TOKEN
RUN echo $REPOSITORY_URL
RUN echo $REPOSITORY_URI

# Login al repositorio de codeartifact
RUN npm config set registry=$REPOSITORY_URL
RUN npm config set //$REPOSITORY_URI:_authToken=$AUTH_TOKEN

WORKDIR $DIR
COPY package*.json $DIR
RUN echo //$REPOSITORY_URI:_authToken=$AUTH_TOKEN > $DIR/.npmrc && \
    npm ci --only=production --ignore-scripts && \
    rm -f .npmrc
RUN cp -R node_modules prod_node_modules
RUN echo //$REPOSITORY_URI:_authToken=$AUTH_TOKEN > $DIR/.npmrc && \
    npm ci --only=development --ignore-scripts && \
    rm -f .npmrc
COPY . .
RUN npm run build
########## STAGE DEV ###################
FROM base as development
USER node
WORKDIR $DIR
ENV NODE_ENV development
COPY --chown=node:node --from=build $DIR/prod_node_modules ./node_modules
COPY --chown=node:node --from=build $DIR/dist ./dist
CMD [ "dumb-init", "node", "dist/main.js" ]
########## STAGE TEST ###################
FROM base as testing
USER node
WORKDIR $DIR
ENV NODE_ENV testing
COPY --chown=node:node --from=build $DIR/prod_node_modules ./node_modules
COPY --chown=node:node --from=build $DIR/dist ./dist
CMD [ "dumb-init", "node", "dist/main.js" ]
########## STAGE PROD ###################
FROM base as master
USER node
WORKDIR $DIR
ENV NODE_ENV production
COPY --chown=node:node --from=build $DIR/prod_node_modules ./node_modules
COPY --chown=node:node --from=build $DIR/dist ./dist
CMD [ "dumb-init", "node", "dist/main.js" ]
########## STAGE SONAR ###################
FROM sonarsource/sonar-scanner-cli:4.7 as test

ARG SERVER_SONAR
ARG ACCESS_TOKEN_SONAR

RUN echo $ACCESS_TOKEN_SONAR
RUN rm -r /usr/bin/node
RUN apk update
RUN apk add --update nodejs npm
RUN apk add --update nodejs-current npm
RUN node -v

# Create app directory
WORKDIR $DIR
COPY package*.json ./
COPY tsconfig*.json ./
COPY . .
RUN npm install

RUN npm run test
RUN pwd
RUN ls -lha coverage
#ejecutar sonarqube
RUN sonar-scanner -Dsonar.host.url=$SERVER_SONAR -Dsonar.login=$ACCESS_TOKEN_SONAR

RUN echo "build stage completed"
