lib = ../../../../lib
sharedFolder = ../../../shared/
sharedFolderProd = ../../../../production/shared/

dockerfile: *.m4
	m4 -I $(lib) Dockerfile.m4 > ../Dockerfile

pre:
	rm -fr ../shared
	mkdir -p ../shared
	cp -fr $(sharedFolderProd)/ssh ../shared/

post:
	rm ../Dockerfile*
	rm -fr ../shared

compile:
	docker build --rm -t registry.kw.kontextwork.com/kw/ldapexample ../ -f ../Dockerfile

build: dockerfile pre compile post
