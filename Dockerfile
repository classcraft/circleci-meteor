ARG NODE
FROM --platform=linux/amd64 cimg/node:${NODE}

USER root

RUN \
  add-apt-repository universe && \
  apt-get update && \
  apt-get install -y \
  git-crypt \
  libgtk2.0-0 \
  libgtk-3-0 \
  libgbm-dev \
  libnotify-dev \
  libgconf-2-4 \
  libnss3 \
  libxss1 \
  libasound2 \
  libxtst6 \
  xauth \
  xvfb \
  && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/*

ARG MONGODB_TOOLS
RUN \
  curl "https://fastdl.mongodb.org/tools/db/mongodb-database-tools-ubuntu2204-x86_64-${MONGODB_TOOLS}.deb" > "./mongodb-database-tools.deb" && \
  apt install "./mongodb-database-tools.deb" && \
  rm -f "./mongodb-database-tools.deb" && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/*

USER circleci

WORKDIR /home/circleci/meteor

ARG METEOR
RUN curl "https://install.meteor.com/?release=${METEOR}" | /bin/sh
RUN meteor --version
RUN meteor npm install --global yarn

WORKDIR /home/circleci

ARG CYPRESS
RUN npx cypress@${CYPRESS} install --force

RUN date +%Y-%m-%d-%s > image-epoch.txt

RUN \
  git-crypt --version && \
  meteor --version && \
  meteor node --version && \
  meteor npm --version && \
  meteor yarn --version && \
  mongorestore --version && \
  cat /home/circleci/image-epoch.txt && \
  true
