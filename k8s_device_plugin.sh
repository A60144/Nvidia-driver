echo "Environment=\"KUBELET_EXTRA_ARGS=--feature-gates=DevicePlugins=true\"">> /etc/systemd/system/kubelet.service.d/10-kubelet.conf
sudo systemctl daemon-reload
sudo systemctl restart kubelet
kubectl create -f https://raw.githubusercontent.com/NVIDIA/k8s-device-plugin/v1.11/nvidia-device-plugin.yml
