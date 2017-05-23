# atlassian-confluence - A docker image containing version 6.2.0 based on alpine linux, with mysql / postgres support
Restartable, persistent docker image for atlassian confluence

Any feedback let me know - its all welcome!

# Pre-req

Before running this docker image, please [clone / download the repo](https://github.com/blofse/atlassian-confluence), inlcuding the script files.

# How to use this image
## (optional) build docker image

To build the local docker image, run the following command:

```
./optional/build_local.sh
```

## Initialise

Run the following command, replacing *** with your desired db password:
```
./initial_start.sh '***'
```
This will setup: 
* Two containers: 
	* atlassian-confluence-postgres - a container to store your confluence db data
	* atlassian-confluence - the container containing the confluence server
* Two Volumes:
	* atlassian-confluence-postgres-data - used for confluence db data
	* atlassian-confluence-home - used for confluence home directory.
* A network:
	* atlassian-confluence-network - a bridge network for confluence

Once setup, please use the following for DB connectivity:
* DB host: atlassian-confluence-postgres
* DB user: confluence
* DB database: confluence
* DB password: ****

Please note, using the initial start command will install two persistent docker volumes which will remain once the docker images are removed.
This allows upgrading but also solves curruption issues which can happen with the atlassian tools. Please remove these yourself should you want to delete everything (and/or restart from the beginning).

## (optional) setting up as a service

Once initialised and perhaps migrated, the docker container can then be run as a service. 
Included in the repo is the service for centos 7 based os's and to install run:
```
./optional/copy_install_and_start_as_service.sh
```

## (optional) remove all (for this image)

Running the command below will remove all trace of this docker image, services, containers, volumes and networks:

```
./optional/remove_all.sh
