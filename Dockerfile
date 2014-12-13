# ghost dockerfile with postgres db
#
# based on https://github.com/dockerfile/ghost

# pull base image
FROM dockerfile/nodejs

# install postgres
RUN apt-get update
RUN apt-get install -y postgresql postgresql-contrib libpq-dev

# install ghost
RUN cd /tmp && wget https://ghost.org/zip/ghost-latest.zip
RUN unzip /tmp/ghost-latest.zip -d /ghost
RUN rm -f /tmp/ghost-latest.zip
RUN cd /ghost && npm install --production   
RUN useradd ghost --home /ghost

# add files
ADD ./casper /casper
ADD ./start.sh /start.sh
ADD ./config.js /ghost/config.js
RUN chmod u+x /start.sh

# set environment variables
ENV NODE_ENV production

# define mountable directories.
VOLUME ["/data", "/ghost-content"]

# define default command
CMD /start.sh && /bin/bash -l

# expose ports
EXPOSE 2368
EXPOSE 5432
