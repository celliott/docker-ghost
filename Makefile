# Makefile for docker-ghost

# ghost settings
GMAIL ?= '<gmail_account>' # required. 
GMAIL_PASSWORD ?= '<gmail_pass>' # required. 
HOSTNAME ?= '<hostname>'	# required. just hostname leave off http://


# docker settings
REPOSITORY ?= '<docker_username>/'	# required. notice the trailing slash
ENVS = -e GMAIL=$(GMAIL) -e GMAIL_PASSWORD=$(GMAIL_PASSWORD) -e HOSTNAME=$(HOSTNAME)
PORTS = -p 80:2368
CONTAINER = ghost
VOLUMES = -v /data:/data -v /ghost-content:/ghost-content


.PHONY: container run

container :
	docker build -t $(REPOSITORY)$(CONTAINER) .

run :
	docker run --restart=always --name $(CONTAINER) -i -d $(PORTS) $(ENVS) $(VOLUMES) -t $(REPOSITORY)$(CONTAINER)
stop :
	docker stop $(CONTAINER)
	docker rm $(CONTAINER)
kill :
	docker kill $(CONTAINER)
	docker rm $(CONTAINER)
restart :
	docker kill $(CONTAINER)
	docker rm $(CONTAINER)
	docker run --name $(CONTAINER) -i -d $(PORTS) $(ENVS) $(VOLUMES) -t $(REPOSITORY)$(CONTAINER)
attach:
	docker attach $(CONTAINER)

tail:
	docker logs -f $(CONTAINER)	
