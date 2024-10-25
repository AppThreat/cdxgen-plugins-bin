#!/usr/bin/env bash

rm -rf plugins/trivy
rm -rf plugins/osquery
rm -rf plugins/dosai
rm -rf plugins/sourcekitten
mkdir -p plugins/osquery plugins/dosai plugins/sourcekitten

oras pull ghcr.io/cyclonedx/cdxgen-plugins-bin:darwin-amd64 -o plugins/sourcekitten/

wget https://github.com/osquery/osquery/releases/download/5.13.1/osquery-5.13.1_1.macos_x86_64.tar.gz
tar -xvf osquery-5.13.1_1.macos_x86_64.tar.gz
cp -rf opt/osquery/lib/osquery.app plugins/osquery/osqueryi-darwin-amd64.app
rm -rf etc usr var opt
rm osquery-5.13.1_1.macos_x86_64.tar.gz

curl -L https://github.com/owasp-dep-scan/dosai/releases/latest/download/Dosai-osx-x64 -o plugins/dosai/dosai-darwin-amd64
chmod +x plugins/dosai/dosai-darwin-amd64
sha256sum plugins/dosai/dosai-darwin-amd64 > plugins/dosai/dosai-darwin-amd64.sha256

for plug in trivy
do
    mkdir -p plugins/$plug
    mv ../../plugins/$plug/*darwin-amd64* plugins/$plug/
done

