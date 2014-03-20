ALL_JS = js/kaleidoverse.js js/jemplate.js

all: $(ALL_JS)

js/kaleidoverse.js: coffee/kaleidoverse.coffee
	coffee -c -o js coffee

js/jemplate.js: template
	jemplate --runtime --compile $< > $@
