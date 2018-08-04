echo "Environment=\"KUBELET_EXTRA_ARGS=--feature-gates=DevicePlugins=true\"">> /etc/systemd/system/kubelet.service.d/10-kubelet.conf
sudo systemctl daemon-reload
sudo systemctl restart kubelet
