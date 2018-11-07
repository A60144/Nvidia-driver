Update date : 2018/07/03

Check GPU Device model
```shell=
lspci | grep -i nvidia
```

* Install Nvidia-smi
* Download the Driver for centos 7
* Run version : http://us.download.nvidia.com/XFree86/Linux-x86_64/390.67/NVIDIA-Linux-x86_64-390.67.run

```shell=
https://bit.ly/2MlKCLz
```
參考: https://docs.nvidia.com/cuda/cuda-installation-guide-linux/index.html#introduction

* Nvidia docker
* nvidia-container-runtime : 
https://github.com/NVIDIA/nvidia-container-runtime#centos-distributions
* nvidia-docker: 
https://github.com/NVIDIA/nvidia-docker
```shell=
# Just for GPU Node

# Install nvidia-container-runtime
# shell https://bit.ly/2vAv4Mt
wget -O - https://bit.ly/2vAv4Mt|sh
# Install nvidia-docker
# shell https://bit.ly/2vjZUK0
wget -O - https://bit.ly/2vjZUK0|sh
```

* K8S Master api feature gate open
* K8S Device-plugin :
https://github.com/NVIDIA/k8s-device-plugin#running-gpu-jobs
```shell=
# Just for Master Node ,Version older than v1.11
# Device-plugin setting for all master
# shell https://bit.ly/2LYyPpq
wget -O - https://bit.ly/2LYyPpq|sh

# Download sample gpu yml
wget -O gpu-sample.yml https://bit.ly/2AN3u4O
kubectl create -f gpu-sample.yml
```
Node will show gpu cnt
![](https://i.imgur.com/Bd9bB3j.png)


============= 下面請忽略 =============
* Install Cuda
```shell=
wget https://developer.download.nvidia.com/compute/cuda/repos/rhel7/x86_64/cuda-repo-rhel7-9.2.88-1.x86_64.rpm
sudo rpm -i cuda-repo-rhel7-9.2.88-1.x86_64.rpm
yum install cuda -y
cd /usr/local/cuda-9.2/bin/
export PATH=/usr/local/cuda-9.2/bin${PATH:+:${PATH}}
export LD_LIBRARY_PATH=/usr/local/cuda-9.2/lib64\
export LD_LIBRARY_PATH=/usr/local/cuda-9.2/lib                         ${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}
nvcc -V
# 這邊做完nvidia-smi功能回不見
# 只好在run 一次
sudo ./NVIDIA-Linux-x86_64-384.69.run --dkms -s
nvidia-smi
```

Issue Fix
===
1. GCC Error
Q: unable to find the development tool cc in your path
A: 
```shell=
yum update kernel -y

yum install gcc kernel-devel kernel-headers
```

2. Kernal header error
yum install gcc kernel-devel-$(uname -r)


![](https://i.imgur.com/ZIBjwgJ.png)


# Refence
* NV Docker :https://github.com/NVIDIA/nvidia-docker/tree/master#centos-7docker-ce-rhel-7475-docker-ce-amazon-linux-12
* nvidia-container-runtime : 
https://github.com/NVIDIA/nvidia-container-runtime#centos-distributions
* K8S Device-plugin :
https://github.com/NVIDIA/k8s-device-plugin#running-gpu-jobs
* ansible install nvidia driver : https://github.com/LIP-Computing/ansible-role-nvidia

