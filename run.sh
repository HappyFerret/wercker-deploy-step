# Testing
TERRAFORM_REPOSITORY_NAME="infrastructure-terraform"
GITHUB_USERNAME="localheroesbot"
GITHUB_ACCOUNT="HappyFerret"
SERVICE_TO_DEPLOY="martell"
TARGET_ENVIRONMENT="qa"
WERCKER_UPDATE_TERRAFORM_COMMIT_HASH="bbb22222b3eee3eeqqqrrr333bb444ssss43333bbbbbbccccccb"

set -e

# Environment variables
REPO="$TERRAFORM_REPOSITORY_NAME"
USER="$GITHUB_USERNAME"
SERVICE="$SERVICE_TO_DEPLOY"
ENVIRONMENT="$TARGET_ENVIRONMENT"
COMMIT_HASH="$WERCKER_UPDATE_TERRAFORM_COMMIT_HASH"

URL="https://$USER:$API_TOKEN@github.com/$GITHUB_ACCOUNT/$REPO.git"

git clone $URL $REPO
cd ./$REPO/_support

######
#Temporary step because master doesn't have deploy.js
git checkout feat/lh-799-auto-deploy
######

git pull

######
#Temporary step so we don't push directly to master
git checkout -f feat/lh-799-auto-deploy-update
git pull
######

npm install
node deploy.js $SERVICE $ENVIRONMENT $COMMIT_HASH

git config user.name "LocalHeroesBot"
git config user.email "devteam@localheroes.com"
git add ../$ENVIRONMENT/service-versions.tf

git commit -m "Deploying $SERVICE to $ENVIRONMENT ($COMMIT_HASH)" 
git push "https://$USER@github.com/$GITHUB_ACCOUNT/$REPO.git"

cd ../../
rm -rf $REPO