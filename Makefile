BASEURL=http://naacl-org.github.com/
LOCALDIR=$(PWD)/_local

# Build locally.
all:
	jekyll --base-url="$(BASEURL)"

# Build locally with the base-url set for testing. Don't copy to the live site from here.
local:
	jekyll --base-url="file://$(LOCALDIR)" "$(LOCALDIR)"

clean:
	rm -rf _site _local
