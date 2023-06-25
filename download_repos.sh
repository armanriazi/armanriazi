#!/usr/bin/env bash

function download_repo {
  local REPO=$1
  local BRANCH=$2
  local TAG=$3 # TAG is optional and can be an empty string

  local FOLDER_NAME
  FOLDER_NAME="$(basename "${REPO}")"

  git clone "${REPO}" --branch "${BRANCH}"
  (
    cd "${FOLDER_NAME}"
    git fetch
    if [ -n "${TAG}" ]; then
      git checkout "tags/${TAG}"
    fi
  )
}

cd ..

if [ ! -f ../.branches.env ]; then
  set -o allexport
  source ./.branches.env
  set +o allexport

  #env -0 | sort -z | tr '\0' '\n'
else
  echo "NO branches.env FILE FOUND"
  exit;
fi

download_repo "$API_REPO" "$API_BRANCH" "$API_TAG"
download_repo "$ESCROW_REPO" "$ESCROW_BRANCH" "$ESCROW_TAG"
download_repo "$ESCROWKUSAMA_REPO" "$ESCROWKUSAMA_BRANCH" "$ESCROWKUSAMA_TAG"
download_repo "$FRONT_REPO" "$FRONT_BRANCH" "$FRONT_TAG"
