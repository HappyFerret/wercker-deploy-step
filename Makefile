run-prod:
	TARGET_ENVIRONMENT=prod ./run.sh
deploy:
	./build-and-deploy.sh
run-qa:
	TARGET_ENVIRONMENT=qa ./run.sh