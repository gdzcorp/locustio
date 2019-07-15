Use [locust.io](http://locust.io/) in docker, for great portability!

Base on https://github.com/christian-blades-cb/locustio-docker

## Usage

Assuming you have a `locustfile.py` in the root of your project, make a Dockerfile like this:

```dockerfile
FROM gdzcorp/locustio
```

Then build and run the docker image:

```shell
$ docker build -t mylocust .
$ docker run --rm -P mylocust
```

Any requirements you have listed in your `requirements.txt` will be installed during the build, and locust runs `locustfile.py` by default!

### Run without building your own image

Alternatively, if you don't have a `requirements.txt` file, you can run a temporary, anonymous container by sharing your `locustfile.py` into it. Assuming you have a `locustfile.py` file in the current folder you're in, you can run with this command:

```
docker run --rm -v `pwd`:/locust -e TARGET_HOST=http://mysite -p 8089:8089 gdzcorp/locustio
```

You will also be able to access the web interface at http://localhost:8089
## Master/Worker

If you want to run in master/slave mode, specify a different file to run, etc, you can pass the appropriate vars to the container.

```shell
$ docker run -d -e TARGET_HOST=http://mysite  -e LOCUST_MODE=master --name master -P mylocust
$ docker run -d -e TARGET_HOST=http://mysite  -e LOCUST_MODE=slave -e LOCUST_MASTER=master --name worker -P mylocust
```
### docker-compose

To use this container with your docker-compose setup as standalone:

```
version: '3.5'
services:
  locustio:
    image: "gdzcorp/locustio"
    environment:
        TARGET_HOST: "http://mysite"
    ports:
      - "8089:8089"
```

or with master/worker setup: 
```
version: '3.5'
services:
  locustio-master:
    image: "mylocust"
    environment:
        TARGET_HOST: "http://mysite"
        LOCUST_MODE: "master"
    ports:
      - "8089:8089"
  locustio-worker:
    image: "mylocust"
    environment:
        TARGET_HOST: "http://mysite"
        LOCUST_MODE: "worker"
        LOCUST_MASTER: "locustio-master"
    ports:
      - "8089:8089"
```