#!/bin/sh

version="$(node dist/package-property.js version)"
name="$(node dist/package-property.js name)"
repo="$CIRCLE_PROJECT_USERNAME/$CIRCLE_PROJECT_REPONAME"

node dist/version-has-changed.js
if [ $? -eq 0 ]; then
  cp README.md dist
  node dist/copy-package-file.js dist devDependencies scripts
  node dist/create-github-release.js $repo $version && echo "Release \"$version\" created on \"$repo\""
  npm publish dist && echo "\"$name@$version\" has been successfully published on NPM"
else
  echo "No need to publish package."
fi
