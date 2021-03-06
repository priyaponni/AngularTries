#!/bin/bash
echo "Starting deployment"
echo "Target: gh-pages branch"

DIST_DIRECTORY="dist/"
CURRENT_COMMIT=`git rev-parse HEAD`
ORIGIN_URL=`git config --get remote.origin.url`
echo "$ORIGIN_URL"

ls

ORIGIN_URL_WITH_CREDENTIALS=${ORIGIN_URL/\/\/github.com/\/\/$GITHUB_TOKEN@github.com}

echo "$ORIGIN_URL_WITH_CREDENTIALS"

cp .gitignore $DIST_DIRECTORY || exit 1

echo "Checking out gh-pages branch"
git checkout -B gh-pages || exit 1

ls

echo "Removing old content"
git rm -rf . || exit 1

ls

echo "Copy dist content to root folder"
cp -R $DIST_DIRECTORY/.??* . || exit 1
cp -R $DIST_DIRECTORY/* . || exit 1

ls

echo "Push new content to $ORIGIN_URL"
git config user.name "Ponni Priyadharshni" || exit 1
git config user.email "priyaponni@gmail.com" || exit 1

echo "Adding files"
git add -A . || exit 1

echo "Commit"
git commit --allow-empty -m "Retrieve content from $CURRENT_COMMIT" || exit 1

echo "Git push happening"
git push --force --quiet "$ORIGIN_URL_WITH_CREDENTIALS" gh-pages > /dev/null 2>&1

echo "Cleanup temp files"
rm -Rf $DIST_DIRECTORY

echo "Deployed"
exit 0


