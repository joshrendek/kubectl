#!/bin/sh

set -e

echo "/usr/local/bin/kubectl" >> $GITHUB_PATH

if [ ! -d "$HOME/.kube" ]; then
    mkdir -p $HOME/.kube
fi


if [ -z "$dest" ]; then
    kubectl $*
else
    EOF=$(dd if=/dev/urandom bs=15 count=1 status=none | base64)
    echo "$dest<<$EOF" >> $GITHUB_ENV
    kubectl $* >> $GITHUB_ENV
    if [[ "${GITHUB_ENV: -1}" != $'\n' ]]; then
        echo >> $GITHUB_ENV
    fi
    echo "$EOF" >> $GITHUB_ENV

    echo "::add-mask::$dest"
fi
