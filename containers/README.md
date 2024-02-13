## Run ECpred through containers
Thsi is particularly handy when running on HPC environments. You may encounter some issues using the installation so a container environment works better.

## Requirements

* Docker >=24.0 (sudo privileges)     
* Singularity >3.6.3    

## Create singularity image

### 1. Build container Docker image

The following command generates the image. 
```
sudo docker build \
	--build-arg ECPRED_TAR=https://goo.gl/g2tMJ4 \
	--build-arg LIBIDN_UBUNTU=http://mirrors.kernel.org/ubuntu/pool/main/libi/libidn/libidn11_1.33-2.2ubuntu2_amd64.deb \
	-f ecpred.Dockerfile -t ecpred_wrapper .
```
Alternatively, use the ```Runeme.sh``` script to directly call the function.

### 2. Save to singularity image

Create the sigularity image
```
singularity build ecpred_wrapper.sif docker-daemon://ecpred_wrapper:latest
```

In case you are using Docker >25.x, use the following trick.
```
docker image save ecpred_wrapper -o ecpred_wrapper.tar.gz
singularity build ecpred_wrapper.sif docker-archive:ecpred_wrapper.tar.gz
```
You can now transfer ```ecpred_wrapper.sif``` to the HPC cluster, ready to run it.    

## Run the wrapper file using singularity
Call the following
```
singularity run ecpred_wrapper.sif wrapper.sh <method> <input.fasta> <prefix_name>
```
Based on the prefix_name the output can also be redirected to another directory. Ex. ```results/name``` will create a file in the the results directory. Make sure the directory exist before running the wrapper.       
