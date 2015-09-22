#!/bin/bash

GH_REPO="@github.com/jaquerespeis/webespeis.git"

FULL_REPO="https://$GH_TOKEN$GH_REPO"

cd output

echo jaquerespeis.org > CNAME

git init
git config user.name "jaquerespeis-travis"
git config user.email "travis"

git add .
git commit -m "Deployed to github pages."
git push --force --quiet $FULL_REPO master:gh-pages
