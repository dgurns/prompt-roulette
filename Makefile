.PHONY: publish-pypi publish-npm

publish-pypi:
	@cd python && uv build
	@cd python && uv publish

publish-npm:
	@cd javascript && npm publish
