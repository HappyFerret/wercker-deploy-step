#!/usr/bin/env bash
set -e

URL="https://$$GITHUB_USERNAME:$API_TOKEN@github.com/$GITHUB_ACCOUNT/$TERRAFORM_REPOSITORY_NAME.git"

git clone $URL $TERRAFORM_REPOSITORY_NAME
git checkout $BRANCH
cd ./$TERRAFORM_REPOSITORY_NAME/_support
git pull

yarn
node deploy.js $SERVICE_TO_DEPLOY $TARGET_ENVIRONMENT $WERCKER_GIT_COMMIT

git config push.default simple
git config user.name $$GITHUB_USERNAME
git config user.email $GITHUB_EMAIL
git add ../$TARGET_ENVIRONMENT/service-versions.tf

git commit -m "Deploying $SERVICE_TO_DEPLOY to $TARGET_ENVIRONMENT ($WERCKER_GIT_COMMIT)"
git push "https://$GITHUB_USERNAME:$API_TOKEN@github.com/$GITHUB_ACCOUNT/$TERRAFORM_REPOSITORY_NAME.git"

cd ../../
rm -rf $TERRAFORM_REPOSITORY_NAME