.PHONY: build

build:
	docker build --no-cache -t mauroveron/php7-nginx .

run:
	docker run --rm --name test -p 8080:80 -t mauroveron/php7-nginx

exec:
	docker exec -it test /bin/sh
