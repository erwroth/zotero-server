FROM node:6

RUN apt-get install -y git \
	&& mkdir /data \
	&& cd /data \
	&& git clone https://github.com/zotero/tinymce-clean-server \
	&& cd tinymce-clean-server \
	&& npm install

WORKDIR /data/tinymce-clean-server/

ENTRYPOINT ["node", "server.js"]
