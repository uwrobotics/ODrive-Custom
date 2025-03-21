DATE=$(date +"%Y%m%d%H%M")
BUILD_FOLDER=$DATE"_build"

#!/usr/bin/env bash
function cleanup {
    echo "Removing previous build artifacts"
    docker rm odrive-build-cont
}

function gc {
    cleanup
    docker rmi odrive-build-img
    docker image prune
}

function copy {
    cleanup

    echo "Generating Build Folder"
    docker build -t odrive-build-img .

    echo "Copy Build Folder to Local"
    # Copy files from the container to your host
    docker create --name odrive-build-cont odrive-build-img
    docker cp odrive-build-cont:/home/Firmware/build $BUILD_FOLDER/
}

function build {
    cleanup

    echo "Building the build-environment image"
    docker build -t odrive-build-img .

    echo "Build in container"
    docker run -it --name odrive-build-cont odrive-build-img:latest 
}

function usage {
    echo "usage: $0 (build | cleanup | gc | copy)"
    echo
    echo "copy   -- Generating Build Folder."
    echo "build   -- build in docker and extract the artifacts."
    echo "cleanup -- remove build artifacts from previous build"
    echo "gc      -- remove all build images and containers"
}

case $1 in
    build)
	build
	;;
    copy)
	copy
	;;
    cleanup)
	cleanup
	;;
    gc)
	gc
	;;
    *)
	usage
	;;
esac
