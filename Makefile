run-prod:
	TARGET_ENVIRONMENT=prod ./run.sh
deploy:
	./build-and-deploy.sh
run-qa:
	TARGET_ENVIRONMENT=qa ./run.sh
	
run-prod-auto:
	TARGET_ENVIRONMENT=prod-auto ./run.sh
