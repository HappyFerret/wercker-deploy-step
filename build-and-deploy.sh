#!/bin/sh

docker build -t deploy-terraform .
aws ecr get-login --no-include-email --region eu-west-1 --profile lh_global | /bin/sh
docker tag deploy-terraform:latest 611461148299.dkr.ecr.eu-west-1.amazonaws.com/wercker-base-images:deploy-terraform
docker push 611461148299.dkr.ecr.eu-west-1.amazonaws.com/wercker-base-images:deploy-terraform