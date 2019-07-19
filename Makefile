# bible-web
# See LICENSE file for copyright and license details.

include config.mk

all: bible-web

bible-web: bible-web.sh web.awk web.tsv
	cat bible-web.sh > $@

	echo 'exit 0' >> $@

	echo '#EOF' >> $@
	tar cz web.awk web.tsv >> $@

	chmod +x $@

clean: bible-web
	rm -f bible-web

test: web.sh
	shellcheck -s sh web.sh

install: bible-web
	mkdir -p $(DESTDIR)$(PREFIX)/bin
	cp bible-web $(DESTDIR)$(PREFIX)/bin
	chmod 755 $(DESTDIR)$(PREFIX)/bin/bible-web

uninstall:
	rm -f ${DESTDIR}${PREFIX}/bin/bible-web
	
.PHONY: all clean install uninstall
