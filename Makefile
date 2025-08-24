.PHONY: publish increment-version clean

publish: increment-version
	@echo "Building and publishing packages..."
	@cd python && python -m build --wheel --sdist
	@cd python && python -m twine upload dist/*
	@cd javascript && npm publish
	@echo "Published successfully!"

increment-version:
	@echo "Incrementing version..."
	@python3 -c "import json; \
	with open('version.json', 'r') as f: data = json.load(f); \
	version_parts = data['version'].split('.'); \
	version_parts[2] = str(int(version_parts[2]) + 1); \
	new_version = '.'.join(version_parts); \
	data['version'] = new_version; \
	with open('version.json', 'w') as f: json.dump(data, f, indent=2); \
	print(f'Version updated to {new_version}')"
	@python3 -c "import json; \
	with open('version.json', 'r') as f: version_data = json.load(f); \
	new_version = version_data['version']; \
	with open('python/pyproject.toml', 'r') as f: content = f.read(); \
	import re; \
	content = re.sub(r'version = \"[^\"]+\"', f'version = \"{new_version}\"', content); \
	with open('python/pyproject.toml', 'w') as f: f.write(content)"
	@python3 -c "import json; \
	with open('version.json', 'r') as f: version_data = json.load(f); \
	new_version = version_data['version']; \
	with open('javascript/package.json', 'r') as f: pkg = json.load(f); \
	pkg['version'] = new_version; \
	with open('javascript/package.json', 'w') as f: json.dump(pkg, f, indent=2)"
	@python3 -c "import json; \
	with open('version.json', 'r') as f: version_data = json.load(f); \
	new_version = version_data['version']; \
	with open('python/prompt_roulette/__init__.py', 'r') as f: content = f.read(); \
	import re; \
	content = re.sub(r'__version__ = \"[^\"]+\"', f'__version__ = \"{new_version}\"', content); \
	with open('python/prompt_roulette/__init__.py', 'w') as f: f.write(content)"

clean:
	@rm -rf python/dist python/build python/*.egg-info
	@echo "Cleaned build artifacts"