version=$(shell cat VERSION)
image_name=marcosschroh/rocksdb:${version}

build:
	docker build . -t ${image_name}

publish:
	./scripts/publish.sh

# Removes old containers, free's up some space
remove:
	docker rm -f $(docker ps -a -q)

remove-image:
	docker rmi ${image_name}

