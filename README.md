# Dockerized Mule4 Runtime

*This is an evolution of dockerization of Mule4 ee standalone.*

## Steps
- Download Mul4 ee standalone from here(http://s3.amazonaws.com/new-mule-artifacts/mule-ee-distribution-standalone-4.1.2.zip)
- Put your own Mule app jar in the same folder
- Name your Mule4 license as mule-ee-license.lic and put it in the same folder
- Build it

## Build

- docker build -t mule4-docker:v1 .
- docker tag mule4-docker:v1  yixiugg/mule4-docker
- docker push yixiugg/mule4-docker