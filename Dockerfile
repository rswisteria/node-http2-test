FROM ubuntu:xenial

RUN apt-get -y update && \
    apt-get -y upgrade && \
    apt-get install -y curl && \

    curl -sL https://deb.nodesource.com/setup_6.x | bash - &&\

    apt-get install -y nodejs && \
    apt-get install -y build-essential && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \

    useradd -m -p password -s /bin/bash node && \
    mkdir -p /home/node/apps && \
    chown -R node:node /home/node/apps

USER node
WORKDIR /home/node/apps

COPY package.json package.json
RUN npm install
COPY . .

EXPOSE 8080
ENTRYPOINT ["npm"]
CMD ["start"]