#
# Yulan UI System Makefile
# Inspired by @mdo and @fat's excellent Bootstrap Makefile
#

DATE=$(shell date +%I:%M%p)
CHECK=\033[32m✔\033[39m
HR=\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#

build: clean
	@echo "\n${HR}"
	@echo "Building Yulan..."
	@mkdir yulan
	@echo "${HR}\n"
	@jshint src/js/*.js --config src/js/.jshintrc
	@jshint tests/qunit-tests.js --config src/js/.jshintrc
	@echo "Running JSHint on javascript...             ${CHECK} Done"
	@lessc src/less/main.less yulan/yulan.tmp.css
	@cat yulan/yulan.tmp.css src/css/spin.css src/css/icons.css > yulan/yulan.css
	@rm yulan/yulan.tmp.css
	@lessc --compress yulan/yulan.css yulan/yulan.min.css
	@cp -R icons yulan/
	@cp -R type yulan/
	@echo "Compiling LESS...                           ${CHECK} Done"
	@cat src/js/sizzle.js src/js/main.js > yulan/yulan.js
	@uglifyjs yulan/yulan.js -nc > yulan/yulan.min.js
	@echo "Compiling and minifying javascript...       ${CHECK} Done"
	@echo "\n${HR}"
	@echo "Yulan successfully built at ${DATE}."
	@echo "${HR}\n"
	@echo "Thanks for trying Yulan <https://github.com/kmacrow/Yulan>"

test:
	@echo "\n${HR}"
	@echo "Testing Yulan..."
	@echo "\n${HR}"
	@echo "Tests complete.                             ${CHECK} Done"

clean:
	rm -rf yulan
