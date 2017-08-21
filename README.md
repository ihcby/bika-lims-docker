## Building container
```bash
docker build -t bika/lims:0.1 .
```

## Running container
```bash
docker run -d -p 8080:8080 --name bikalims bika/lims:0.1
```
## To get persistent storage
```bash
docker volume create --name <volume_name>
docker run -d -v <volume_name>:/usr/local/Plone/zeocluster/var bika/lims:0.1
```


## Development
For development purposes you can put tgz with install file next to this Dockerfile and replace line 
```
ADD https://launchpad.net/plone/4.3/4.3.7/+download/Plone-4.3.7-UnifiedInstaller.tgz /opt/bika/
```
with
```
COPY ./Plone-4.3.6-UnifiedInstaller.tgz /opt/bika/
```

## Open issues
* Avoid using `--password=adminpassword` in Dockerfile
* Using data directory
* Backups
* Version of the 

## Pull image directly from Docker Hub (998MB)
```bash
docker pull juangallostra/bika_lims
```
