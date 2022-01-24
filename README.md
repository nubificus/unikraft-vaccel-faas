# unikraft-vaccel-faas

This repo hosts an image classification unikernel example for OpenFaaS.

### Input

a binary image via `STDIN`

### Output

The output is the stdout of the unikernel execution (showing the classification tag).

### Build

To build we use the dockerfile. 

```
docker build -t user/unikraft-vaccel-faas:latest -f Dockerfile .
```
then push to the dockerhub:

```
docker push user/unikraft-vaccel-faas:latest
```

and use the stack-classify-unikraft.yml to deploy to your openfaas installation:

```
faas-cli deploy -f stack-classify-unikraft.yml
```

Make sure to use your own gateway param, as well as your own openfaas profile
annotation.
