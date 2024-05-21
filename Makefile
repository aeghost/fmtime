# copyright None
# author Matthieu GOSSET
# maintainers Matthieu GOSSET <matthieu.gosset.dev@chapsvision.com>
# purpose make targets

DUNE=dune
CC=$(DUNE)
BUILD=$(CC) build
EXEC=$(CC) exec --profile=release
RUN=_build/default/
TEST_FIFO?=tests/test_fifo

PATH_TEST=tests
TEST_BIN=tests.exe

.PHONY: all tests

all:
	$(BUILD)

$(PATH_TEST)/$(TEST_BIN):
	$(BUILD) $@

tests: $(PATH_TEST)/$(TEST_BIN)
	$(EXEC) $<

help:
	cat README.md