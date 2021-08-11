.PHONY: build tools test test-junit coverage vet errors lint fmt help

default: build

BUILD_TIME=`date +%FT%T%z`
GIT_REVISION=`git rev-parse --short HEAD`
GIT_REPO=`git remote get-url --push origin`

LDFLAGS=-ldflags "-s -X main.Buildtime=${BUILD_TIME} -X main.Commit=${GIT_REVISION} -X main.Repo=${GIT_REPO}"

build:
    ifdef GITHUB_RUN_ID
	go build -o app-build-${GITHUB_RUN_ID} ${LDFLAGS}
    else
	go build -o app ${LDFLAGS}
    endif

tools:
	go get github.com/kisielk/errcheck
	go get golang.org/x/lint/golint
	go get github.com/axw/gocov/gocov
	go get github.com/matm/gocov-html
	go get github.com/jstemmer/go-junit-report

test:
	go test -v ./...

test-junit:
	mkdir $(CURDIR)/test-results/
	go test -v ./... 2>&1 | go-junit-report > $(CURDIR)/test-results/report.xml

coverage:
	gocov test ./... > $(CURDIR)/coverage.out 2>/dev/null
	gocov report $(CURDIR)/coverage.out
	gocov-html $(CURDIR)/coverage.out > $(CURDIR)/coverage.html

vet:
	go vet -v ./...

errors:
	errcheck -ignoretests -blank ./...

lint:
    ifdef CI
	./bin/golangci-lint run
    else
	golint ./...
    endif

fmt:
	go fmt ./...

help:
	@echo 'Usage: make <OPTIONS> ... <TARGETS>'
	@echo ''
	@echo 'Available targets are:'
	@echo ''
	@echo '    help               Show this help screen.'
	@echo '    tools              Install tools needed by the project.'
	@echo '    test               Run unit tests.'
	@echo '    test-junit         Run unit tests and convert to jUnit.'
	@echo '    coverage           Report code tests coverage.'
	@echo '    vet                Run go vet.'
	@echo '    errors             Run errcheck.'
	@echo '    lint               Run golint.'
	@echo '    fmt                Run go fmt.'
	@echo '    build              Build project for current platform.'
	@echo ''
