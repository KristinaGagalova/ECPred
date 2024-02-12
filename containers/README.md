## Build container Docker image to use ECPred on Cluster environment

```
sudo docker build \
	--build-arg ECPRED_TAR=https://goo.gl/g2tMJ4 \
	--build-arg LIBIDN_UBUNTU= http://mirrors.kernel.org/ubuntu/pool/main/libi/libidn/libidn11_1.33-2.2ubuntu2_amd64.deb \
	-f ecpred.Dockerfile -t ecpred_wrapper .
```
Alternatively, use the ```Runeme.sh``` script.

## Save to singularity image - incompatibility with Docker >25.x
```
docker image save ecpred_wrapper -o ecpred_wrapper.tar.gz
singularity build ecpred_wrapper.sif docker-archive:ecpred_wrapper.tar.gz
```
