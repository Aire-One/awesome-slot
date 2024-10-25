install:
	luarocks install --local --only-deps awesome-slot-dev-1.rockspec

luacheck:
	luacheck .

stylua:
	stylua --check .

ldoc-dryrun:
	$(eval TMP := $(shell mktemp -d))
	ldoc --fatalwarnings --dir $(TMP) .
	rm -rf $(TMP)

cspell:
	cspell lint .

lint-rockspec:
	luarocks lint awesome-slot-dev-1.rockspec

lint: luacheck stylua ldoc-dryrun cspell lint-rockspec

ldoc:
	ldoc .
