FROM circleci/node:14

RUN curl "https://install.meteor.com/?release=2.6" | /bin/sh
RUN echo "Meteor version:";meteor --version;which meteor;echo "Meteor node version:";meteor node -v;echo "Meteor npm version:";meteor npm -v;echo
RUN meteor npm install --global yarn

USER root
RUN git clone https://www.agwa.name/git/git-crypt.git
RUN cd git-crypt && make && make install

USER circleci
