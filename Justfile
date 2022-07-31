set export

NEW_VERSION := `curl -sS https://redbean.dev/latest.txt`
DOCKER_IMAGE := "kissgyorgy/redbean-onbuild"
DOCKER_IMAGE_WITH_TAG := "kissgyorgy/redbean-onbuild:" + NEW_VERSION

update-version:
    #!/usr/bin/env bash
    sed -i -E "/ARG DOWNLOAD_FILENAME/s/(.*-).*(\.com)/\1${NEW_VERSION}\2/" Dockerfile-*
    HAS_CHANGES=$(git status --porcelain Dockerfile-*)
    if [[ -n "$HAS_CHANGES" ]]; then
        git add Dockerfile-*
        git commit -m "Updated redbean to ${NEW_VERSION}"
    else
        echo "No new Redbean version found"
    fi

build: update-version
    podman build --format docker \
        -f Dockerfile-onbuild \
        -t "docker.io/${DOCKER_IMAGE}" \
        -t "docker.io/${DOCKER_IMAGE_WITH_TAG}" \
        .

release: build
    podman push "docker.io/${DOCKER_IMAGE}"
    podman push "docker.io/${DOCKER_IMAGE_WITH_TAG}"
