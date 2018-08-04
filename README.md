# Nvidia-driver

照這邊執行就可以了
===

https://gist.github.com/wangruohui/df039f0dc434d6486f5d4d098aa52d07#install-dependencies

Update date : 2018/07/03

Check GPU Device model
```shell=
lspci | grep -i nvidia
```

Install Nvidia-smi
Download the Driver for centos 7
Run version : http://us.download.nvidia.com/XFree86/Linux-x86_64/390.67/NVIDIA-Linux-x86_64-390.67.run

```shell=
https://bit.ly/2MlKCLz
```

Install Cuda
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

參考: https://docs.nvidia.com/cuda/cuda-installation-guide-linux/index.html#introduction

============= 下面請忽略 =============













Step 3 Nvidia docker
===
Refence by https://github.com/NVIDIA/nvidia-docker
```shell=
sudo apt-get purge -y nvidia-docker
sudo docker volume ls -q -f driver=nvidia-docker | xargs -r -I{} -n1 docker ps -q -a -f volume={} | xargs -r docker rm -f
sudo yum remove nvidia-docker
distribution=$(. /etc/os-release;echo $ID$VERSION_ID)
curl -s -L https://nvidia.github.io/nvidia-docker/$distribution/nvidia-docker.repo |    sudo tee /etc/yum.repos.d/nvidia-docker.repo
sudo yum install -y nvidia-docker2
sudo yum install -y nvidia-docker2 --skip-broken
sudo pkill -SIGHUP dockerd
docker run --runtime=nvidia --rm nvidia/cuda nvidia-smi
```


Step 5 K8S Master api feature gate open
===
```shell=
vim /etc/systemd/system/kubelet.service.d/10-kubelet.conf 
```
Add feature-gate setting into kubelet
```
...
[Service]
Environment="KUBELET_EXTRA_ARGS=--feature-gates=Accelerators=true"
...
```

```shell=
systemctl restart kubelet
kubectl get node
kubectl describe node {GPU_Node_Name}
```
Node will show gpu cnt
![](https://i.imgur.com/Bd9bB3j.png)


Step 6 K8S Minion(GPU) feature gate open
===
```shell=
vim /etc/systemd/system/kubelet.service.d/10-kubelet.conf 
```
Add feature-gate setting into kubelet
```
...
[Service]
Environment="KUBELET_EXTRA_ARGS=--feature-gates=Accelerators=true"
...
```

```shell=
systemctl restart kubelet
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

