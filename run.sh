# Testing
TERRAFORM_REPOSITORY_NAME="infrastructure-terraform"
GITHUB_USERNAME="localheroesbot"
GITHUB_ACCOUNT="HappyFerret"
SERVICE_TO_DEPLOY="martell"
TARGET_ENVIRONMENT="qa"
WERCKER_UPDATE_TERRAFORM_COMMIT_HASH="DDDDDDDDDDDDD"
API_TOKEN="1c02fcfaf0ce779d3adb8dbfa364d46464008264"

# Environment variables
REPO="$TERRAFORM_REPOSITORY_NAME"
USER="$GITHUB_USERNAME"
SERVICE="$SERVICE_TO_DEPLOY"
ENVIRONMENT="$TARGET_ENVIRONMENT"
COMMIT_HASH="$WERCKER_UPDATE_TERRAFORM_COMMIT_HASH"

URL="https://$USER:$API_TOKEN@github.com/$GITHUB_ACCOUNT/$REPO.git"
echo $URL


git clone $URL
#expect "password: "
#send "$API_TOKEN"

cd ./$REPO
git pull

npm install
node deploy.js $SERVICE $ENVIRONMENT $COMMIT_HASH

git add ./$ENVIRONMENT/service-versions.tf
git commit -m "Deploying $SERVICE to $ENVIRONMENT ($COMMIT_HASH)"
#git push
