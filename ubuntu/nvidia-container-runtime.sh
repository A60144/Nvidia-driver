sudo systemctl stop kubelet
sudo systemctl stop docker
sudo apt-get install nvidia-container-runtime -y

#sudo mkdir -p /etc/systemd/system/docker.service.d

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

sudo systemctl daemon-reload
sudo systemctl restart docker
sudo pkill -SIGHUP dockerd
# docker run --runtime=nvidia --rm nvidia/cuda nvidia-smi
