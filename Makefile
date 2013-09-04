# Build locally.
all:
	jekyll build

# Build locally with the base-url set for testing. Don't copy to the live site from here.
local:
	jekyll build --config=_localconfig.yml

clean:
	rm -rf _site _local
