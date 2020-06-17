VERSION:=2.0.0
NAME:=influxdb

all: build push

build:
	docker build --no-cache=true -t $(NAME):$(VERSION) .
	docker tag $(NAME):$(VERSION) docker.sunet.se/$(NAME):$(VERSION)

update:
	docker build -t $(NAME):$(VERSION) .
	docker tag $(NAME):$(VERSION) docker.sunet.se/$(NAME):$(VERSION)

run:
	docker run -p 9999:9999 -v /var/lib/influxdb:/home/influxdb -v /etc/passwd:/etc/passwd:ro -v /etc/group:/etc/group:ro docker.sunet.se/$(NAME):$(VERSION) 

push:
	docker push docker.sunet.se/$(NAME):$(VERSION)
