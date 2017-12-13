.PHONY: build

build:
	docker build --no-cache -t test .

run:
	docker run --rm --name test -p 8080:80 -t test

exec:
	docker exec -it test /bin/sh
