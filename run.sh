set -e

COMMIT_HASH="$WERCKER_UPDATE_TERRAFORM_COMMIT_HASH"

URL="https://$$GITHUB_USERNAME:$API_TOKEN@github.com/$GITHUB_ACCOUNT/$TERRAFORM_REPOSITORY_NAME.git"

git clone $URL $TERRAFORM_REPOSITORY_NAME
cd ./$TERRAFORM_REPOSITORY_NAME/_support
git pull

######
#Temporary step so we don't push directly to master
git checkout feat/lh-799-auto-deploy-update
git pull
######

yarn
node deploy.js $SERVICE_TO_DEPLOY $TARGET_ENVIRONMENT $COMMIT_HASH

git config push.default simple
git config user.name $$GITHUB_USERNAME
git config user.email $GITHUB_EMAIL
git add ../$TARGET_ENVIRONMENT/service-versions.tf

git commit -m "Deploying $SERVICE_TO_DEPLOY to $TARGET_ENVIRONMENT ($COMMIT_HASH)"
git push "https://$$GITHUB_USERNAME:$API_TOKEN@github.com/$GITHUB_ACCOUNT/$TERRAFORM_REPOSITORY_NAME.git"

cd ../../
rm -rf $TERRAFORM_REPOSITORY_NAME