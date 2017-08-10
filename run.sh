set -e

# Environment variables
REPO="$TERRAFORM_REPOSITORY_NAME"
USER="$GITHUB_USERNAME"
USER_EMAIL="$GITHUB_EMAIL"
SERVICE="$SERVICE_TO_DEPLOY"
ENVIRONMENT="$TARGET_ENVIRONMENT"
COMMIT_HASH="$WERCKER_UPDATE_TERRAFORM_COMMIT_HASH"

URL="https://$USER:$API_TOKEN@github.com/$GITHUB_ACCOUNT/$REPO.git"

git clone $URL $REPO
cd ./$REPO/_support
git pull

######
#Temporary step so we don't push directly to master
git checkout feat/lh-799-auto-deploy-update
git pull
######

yarn
node deploy.js $SERVICE $ENVIRONMENT $COMMIT_HASH

git config push.default simple
git config user.name $USER
git config user.email $USER_EMAIL
git add ../$ENVIRONMENT/service-versions.tf

git commit -m "Deploying $SERVICE to $ENVIRONMENT ($COMMIT_HASH)" 
git push "https://$USER@github.com/$GITHUB_ACCOUNT/$REPO.git"

cd ../../
rm -rf $REPO