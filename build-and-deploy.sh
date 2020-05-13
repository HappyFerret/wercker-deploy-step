#!/bin/sh

docker build -t deploy-terraform .
#aws ecr get-login --no-include-email --region eu-west-1 --profile lh_global | /bin/sh
aws ecr get-login-password --region eu-west-1 --profile ecr_admin | docker login --username AWS --password-stdin 611461148299.dkr.ecr.eu-west-1.amazonaws.com
docker tag deploy-terraform:latest 611461148299.dkr.ecr.eu-west-1.amazonaws.com/base-images:deploy-terraform
docker push 611461148299.dkr.ecr.eu-west-1.amazonaws.com/base-images:deploy-terraform
