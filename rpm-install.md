
REF: https://developer.nvidia.com/cuda-90-download-archive?target_os=Linux&target_arch=x86_64&target_distro=CentOS&target_version=7&target_type=rpmnetwork

```
wget https://developer.nvidia.com/compute/cuda/9.0/Prod/local_installers/cuda-repo-rhel7-9-0-local-9.0.176-1.x86_64-rpm

sudo rpm -i cuda-repo-rhel7-9-0-local-9.0.176-1.x86_64.rpm
sudo yum clean all
sudo yum install cuda
```
如果有少epel pkg

```
yum install epel-release
```
