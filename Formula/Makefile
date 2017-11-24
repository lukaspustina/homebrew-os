
all: checksums

checksums: *.rb
	@for i in $?; do \
		/bin/echo -n "$$i: "; \
		curl -sL $$(cat $$i | grep url | awk '{ print $$2 }' | tr -d '"') | shasum -a 256; \
	done

.PHONY: checksums

