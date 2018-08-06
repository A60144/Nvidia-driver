mkdir ~/nvidia_doc
cd ~/nvidia_doc
wget http://us.download.nvidia.com/XFree86/Linux-x86_64/390.67/NVIDIA-Linux-x86_64-390.67.run
chmod +x NVIDIA-Linux-x86_64-390.67.run
yum install epel-release -y
yum install dkms -y
echo -e "blacklist nouveau\noptions nouveau modeset=0" | sudo tee /etc/modprobe.d/blacklist-nouveau.conf
sudo systemctl stop lightdm
sudo dracut --force
yum install gcc kernal-devel-$(uname -r)
sudo ./NVIDIA-Linux-x86_64-384.69.run --dkms -s
nvidia-smi
