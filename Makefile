APP=$(shell basename $(shell git remote get-url origin))
REGISTRY=ghcr.io/itka4yk
TARGETARCH=amd64
VERSION=$(shell git describe --tags --abbrev=0)-$(shell git rev-parse --short HEAD)

ifndef TARGETOS
override TARGETOS = linux
endif

ifndef TARGETARCH
override TARGETARCH = $(shell dpkg --print-architecture)
endif

all: format get build image push clean


.PHONY: format
format:
	gofmt -s -w ./

get:
	go get

lint:
	golint

test:
	go test -v

build: format get
	@echo "Build with:"
	@echo "\tTARGETOS = $(TARGETOS)"
	@echo "\tTARGETARCH = $(TARGETARCH)"
	CGO_ENABLED=0 GOOS=${TARGETOS} GOARCH=${TARGETARCH} go build -v -o kbot -ldflags "-X="github.com/IgorTkachuk/kbot/cmd.appVersion=${VERSION}

image:
	docker build . --build-arg TARGETOS=${TARGETOS} --build-arg TARGETARCH=${TARGETARCH} -t ${REGISTRY}/${APP}:${VERSION}-${TARGETARCH}

push:
	docker push ${REGISTRY}/${APP}:${VERSION}-${TARGETARCH}

clean:
	rm -rf kbot
	docker rmi ${REGISTRY}/${APP}:${VERSION}-${TARGETARCH}