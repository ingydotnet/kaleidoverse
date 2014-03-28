ALL_JS = js/kaleidoverse.js js/jemplate.js

all: $(ALL_JS)

js/kaleidoverse.js: lib/kaleidoverse.coffee
	coffee -c -o js lib

js/jemplate.js: html
	jemplate --runtime --compile $< > $@
