FROM node:6

RUN apt-get install -y git \
	&& mkdir /data \
	&& cd /data \
	&& git clone https://github.com/zotero/stream-server \
	&& cd stream-server \
	&& npm install

WORKDIR /data/stream-server/

ENTRYPOINT ["node", "index.js"]
