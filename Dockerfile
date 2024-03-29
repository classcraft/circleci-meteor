ARG NODE
FROM --platform=linux/amd64 cimg/node:${NODE}-browsers

USER root

RUN true \
  add-apt-repository universe && \
  apt-get update && \
  apt-get install -y git-crypt && \
  rm -rf /var/lib/apt/lists/* && \
  true

USER circleci

WORKDIR /home/circleci/meteor

ARG METEOR
RUN curl "https://install.meteor.com/?release=${METEOR}" | /bin/sh
RUN meteor --version
RUN meteor npm install --global yarn

WORKDIR /home/circleci

RUN date +%Y-%m-%d-%s > image-epoch.txt

RUN \
  git-crypt --version && \
  meteor --version && \
  meteor node --version && \
  meteor npm --version && \
  meteor yarn --version && \
  cat /home/circleci/image-epoch.txt && \
  true
