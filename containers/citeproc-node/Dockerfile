FROM node:6

RUN apt-get install -y git \
	&& mkdir /data \
	&& cd /data \
	&& git clone --recursive https://github.com/zotero/citeproc-node.git \
	&& cd citeproc-node \
	&& npm install

WORKDIR /data/citeproc-node/

ENTRYPOINT ["node", "lib/citeServer.js"]
