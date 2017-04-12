# zotero-server

One-click Zotero 5.0 server setup based on Docker.

zotero-server currently uses a special dataserver fork until all required capabilities will be merged into the main repository.

zotero-server includes are required packages to run fully fledged Zotero server:

- dataserver
- tinymce cleaner
- stream-server
- ...

# Setup

```
git clone ..
cd ..
./configure
```

# Run

```
make up
```

# Test

```
make test
```

Some Zotero functions depend on Amazon services but they aren't mandatory

- S3 - file uploads
- SNS - file uploads, updated items notifications
- SQS - updated items notifications


Fully working Zotero server needs https


# Configuring Amazon services






