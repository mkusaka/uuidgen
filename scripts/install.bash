#!/bin/bash

set -e -o pipefail

version="${1:-0.0.1}"

if [[ ! "$version" =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
    echo "Given version '${version}' does not match to regex" '^[0-9]+\.[0-9]+\.[0-9]+$' >&2
    exit 1
fi

echo "Start downloading uuidgen v${version}"

case "$OSTYPE" in
    linux-*)
        os=linux
        ext=tar.gz
    ;;
    darwin*)
        os=Darwin
        ext=tar.gz
    ;;
    *)
        echo "OS '${OSTYPE}' is not supported." >&2
        exit 1
    ;;
esac

machine="$(uname -m)"
case "$machine" in
    x86_64) arch=x86_64 ;;
    i?86) arch=i386 ;;
    aarch64|arm64) arch=arm64 ;;
    *)
        echo "Could not determine arch from machine hardware name '${machine}'"
        exit 1
    ;;
esac

echo "Detected OS=${os} ext=${ext} arch=${arch}"

file="uuidgen_${version}_${os}_${arch}.${ext}"
url="https://github.com/mkusaka/uuidgen/releases/download/${version}/${file}"

echo "Downloading ${url} with curl"

curl -L "${url}" | tar xvz uuidgen
exe="$(pwd)/uuidgen"

echo "Downloaded and unarchived executable: ${exe}"

echo "Done: $("${exe}" -version)"
