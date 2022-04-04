ARG METEOR
ARG NODE

FROM circleci/node:${NODE}-browsers

USER root

RUN true \
  apt-get update && \
  apt-get install -y git-crypt && \
  rm -rf /var/lib/apt/lists/* && \
  true

USER circleci

WORKDIR /home/circleci/meteor

RUN curl "https://install.meteor.com/?release=${METEOR}" | /bin/sh
RUN meteor --version
RUN meteor npm install --global yarn

WORKDIR /home/circleci

RUN \
  git-crypt --version && \
  google-chrome --version && \
  meteor --version && \
  meteor node --version && \
  meteor npm --version && \
  meteor yarn --version && \
  true
