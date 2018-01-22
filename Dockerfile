FROM circleci/node:8.9-browsers

RUN curl https://install.meteor.com | /bin/sh
RUN echo "Meteor version:";meteor --version;which meteor;echo "Meteor node version:";meteor node -v;echo "Meteor npm version:";meteor npm -v;echo "Java version:";java -version

USER root
RUN git clone https://www.agwa.name/git/git-crypt.git
RUN cd git-crypt && make && make install

USER circleci
