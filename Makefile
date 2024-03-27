SHELL = /bin/bash

define HELP

  Tulsa Public Schools PowerSchool Plugin for Avela Enroll

  For your convenience:

    help       This message
    clean      Clear idempotent files
    release    Package the src/ directory as a zip file into dist/
    console    Get an interactive REPL prompt for experimenting with PowerQueries

endef
export HELP

.PHONY: default
default: help

.PHONY: help
help:
	@ echo "$$HELP"

.PHONY: clean
clean:
	rm -rf dist

.PHONY: release
release: _bundle
	bin/release

.PHONY: console
console: _bundle
	bin/console

.PHONY: _bundle
_bundle:
	@ bundle check > /dev/null || bundle install
