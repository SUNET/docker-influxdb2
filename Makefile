VERSION:=2.0.0
NAME:=docker-influxdb2

all: build push

build:
	docker build --no-cache=true -t $(NAME):$(VERSION) .
	docker tag $(NAME):$(VERSION) docker.sunet.se/$(NAME):$(VERSION)

update:
	docker build -t $(NAME):$(VERSION) .
	docker tag $(NAME):$(VERSION) docker.sunet.se/$(NAME):$(VERSION)

run:
	docker run -p 8086:8086 -v /var/lib/influxdb:/var/lib/influxdb -v /etc/passwd:/etc/passwd:ro -v /etc/group:/etc/group:ro docker.sunet.se/$(NAME):$(VERSION) 

push:
	docker push docker.sunet.se/$(NAME):$(VERSION)
