Ghost 
=====

a docker container for ghost with postgres db and gmail for email. based off of dockerfile/ghost - http://dockerfile.github.io/#/ghost

* create a /data folder at the root of your vm. used for postgres persistence
```
sudo mkdir /data
```

* create a /ghost-content folder at the root of your vm. used for ghost-content persistence
```
sudo mkdir /ghost-content
```

* add your configuration options to the Makefile
```
GMAIL ?= '<gmail_accont>'
GMAIL_PASSWORD ?= '<gmail_password>'
URL ?= '<hostname>' # ghost.example.com
REGISTRY ?= '<docker_username>/'
```

* build contianer
```
$ make container
```

* start container
```
$ make run
```

* once the container is started, then you are ready to setup your blog
```
http://<hostname>/ghost/
```

* enjoy!
