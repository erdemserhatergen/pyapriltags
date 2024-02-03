ROOT=$(dir $(abspath $(firstword $(MAKEFILE_LIST))))

.PHONY: build upload clean release-all

build:
	# create build environment
	docker build \
		-t pyapriltags:wheel-python3 \
		${ROOT}
	# create wheel destination directory
	mkdir -p ${ROOT}/dist
	# build wheel
	docker run --rm \
    		-v /home/runner/work/pyapriltags/pyapriltags/:/apriltag \
    		-v /home/runner/work/pyapriltags/pyapriltags//dist:/out \
    		pyapriltags:wheel-python3

upload:
	twine upload ${ROOT}/dist/*

clean:
	rm -rf ${ROOT}/dist/*

release-all:
	# build wheels
	make build
	# push wheels
	make upload
