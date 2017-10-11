#!/bin/bash
echo "Starting deployment"
echo "Target: gh-pages branch"

DIST_DIRECTORY="src/"
CURRENT_COMMIT=`git rev-parse HEAD`
ORIGIN_URL=`git config --get remote.origin.url`
echo "$ORIGIN_URL"

ls $DIST_DIRECTORY

ORIGIN_URL_WITH_CREDENTIALS=${ORIGIN_URL/\/\/github.com/\/\/$GITHUB_TOKEN@github.com}

echo "$ORIGIN_URL_WITH_CREDENTIALS"

cp .gitignore $DIST_DIRECTORY || exit 1

echo "Checking out gh-pages branch"
git checkout -B gh-pages || exit 1

echo "Removing old content"
git rm -rf . || exit 1

echo "Copy dist content to root folder"
cp -r $DIST_DIRECTORY/* . || exit 1

echo "Push new content to $ORIGIN_URL"
git config user.name "Ponni Priyadharshni" || exit 1
git config user.email "priyaponni@gmail.com" || exit 1

git add -A . || exit 1
git commit --allow-empty -m "Retrieve content from $CURRENT_COMMIT" || exit 1
git push --force --quiet "$ORIGIN_URL_WITH_CREDENTIALS" gh-pages > /dev/null 2>&1

echo "Cleanup temp files"
rm -Rf $DIST_DIRECTORY

echo "Deployed"
exit 0


