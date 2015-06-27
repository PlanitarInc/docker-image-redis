IMAGE_NAME=planitar/redis

ifneq ($(NOCACHE),)
  NOCACHEFLAG=--no-cache
endif

.PHONY: build push clean test

build: bin/redis-server
	docker build ${NOCACHEFLAG} -t ${IMAGE_NAME} .

push:
ifneq (${IMAGE_TAG},)
	docker tag -f ${IMAGE_NAME} ${IMAGE_NAME}:${IMAGE_TAG}
	docker push ${IMAGE_NAME}:${IMAGE_TAG}
else
	docker push ${IMAGE_NAME}
endif

clean:
	rm -rf ./bin
	docker rmi -f ${IMAGE_NAME} || true

bin/redis-server: 
	docker run -t --rm \
	  -v `pwd`/bin:/opt/redis/bin \
	  -v `pwd`/script:/tmp/script \
	  planitar/dev-base /tmp/script/build.sh

test:
	docker run -t --rm planitar/redis bash -c ' \
	  set -ex; \
	  redis-cli -v; \
	  redis-server -v; \
	  redis-sentinel -v; \
	'
