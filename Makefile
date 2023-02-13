all:

change-version:
	bin/change-version.sh $(version)

package:
	bin/package.sh $(version)

deploy:
	bin/deploy.sh $(version)

.PHONY: build
build:
	bin/package.sh
	bin/docker-build.sh $(name) $(file)
	bin/clean.sh


build-debug:
	bin/package-debug.sh
	bin/docker-build.sh stratio/ingress-nginx-debug Dockerfile.debug
	bin/clean.sh

chart:
	bin/chart.sh $(version)
