# Wercker Deploy Step

This is a Wercker pipeline step that performs the following functions - 

- Checkout the infrastructure-terraform repo
- Run deploy.js in the infrastructure-terraform repo which updates the specified service's commit has in the service-versions.tf file
- Add, commit and push back to the infrastructure-terraform repo