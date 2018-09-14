sudo systemctl stop kubelet
sudo systemctl stop docker
sudo apt-get install nvidia-container-runtime

#sudo mkdir -p /etc/systemd/system/docker.service.d
sudo systemctl daemon-reload
sudo systemctl restart docker
sudo tee /etc/docker/daemon.json <<EOF
{
    "default-runtime": "nvidia",
    "runtimes": {
        "nvidia": {
            "path": "/usr/bin/nvidia-container-runtime",
            "runtimeArgs": []
        }
    }
}
EOF
sudo pkill -SIGHUP dockerd
# docker run --runtime=nvidia --rm nvidia/cuda nvidia-smi
