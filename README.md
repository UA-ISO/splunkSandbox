# Splunk Sandbox

## Installation Steps
1. Install [Docker](https://www.docker.com) if it is not already installed.
2. Clone this repository or download the "Dockerfile" and "entrypoint.sh" files.
3. In a command prompt or terminal, navigate to the directory that has the two files mentioned in step 2.
4. Create the container image by running the following command, substituting "rpm" for the URL of the Splunk RPM and "password" for the password you would like to use for the Splunk UI admin account: `docker image build . --file Dockerfile --build-arg splunkRPMURL="rpm" --build-arg splunkAdminPassword=password --tag splunksandbox`
5. Start the Splunk container for the first time: `docker container run --detach --tty --publish 8000:8000 --name splunksandbox splunksandbox`
6. Open a web browser, navigate to `http://localhost:8000`, and log in with the username of `admin` and password that was st in step 4.
7. When finished, stop the container by running `docker container stop splunksandbox`


## Common Commands
- Remove old image: `docker image rm splunksandbox`
- Create Docker iamge: `docker image build . --file Dockerfile --build-arg splunkRPMURL="rpm" --build-arg splunkAdminPassword=password --tag splunksandbox`
- Start new Splunk container: `docker container run --detach --tty --publish 8000:8000 --name splunk splunksandbox`
- Start existing Splunk container: `docker container start splunksandbox`
- Stop Splunk container: `docker container stop splunksandbox`
- Delete existing Splunk container: `docker container rm splunksandbox`
- Enter shell within the container: `docker container exec --tty --interactive splunksandbox /bin/bash`


## Notes
- We chose not to provide a built Splunk container so that a custom password can be set.
- An additional flag of `-v $localPath:/opt/splunk/etc/apps/splunkSandbox-workspace/` can be added to the run command so that a Splunk app is mounted locally.
