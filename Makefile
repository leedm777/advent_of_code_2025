export MIX_ENV ?= dev

all: test
.PHONY: all

test:
	mix test
.PHONY: test

start start_iex restart stop pid:
	@env | grep ^MIX_ENV=
	mix release --overwrite --quiet
	_build/$(MIX_ENV)/rel/aoc/bin/aoc $@
.PHONY: start
