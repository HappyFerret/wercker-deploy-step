#!/usr/bin/env bash
set -e

URL="https://$GITHUB_USERNAME:$GITHUB_TOKEN@github.com/$GITHUB_ACCOUNT/$TERRAFORM_REPOSITORY_NAME.git"

git clone $URL $TERRAFORM_REPOSITORY_NAME
cd ./$TERRAFORM_REPOSITORY_NAME/_support
git pull

yarn
node deploy.js $SERVICE_TO_DEPLOY $TARGET_ENVIRONMENT $CI_COMMIT_ID

git config push.default simple
git config user.name $GITHUB_USERNAME
git config user.email $GITHUB_EMAIL
git add ../$TARGET_ENVIRONMENT/service-versions.tf

git commit -m "Deploying $SERVICE_TO_DEPLOY to $TARGET_ENVIRONMENT ($CI_COMMIT_ID)"
git push $URL

cd ../../
rm -rf $TERRAFORM_REPOSITORY_NAME
