#!/bin/bash
set -e

echo "=== Installing dependencies ==="
sudo apt update -y
sudo apt install -y curl wget unzip

# ---------------------------------------------------------------------
# INSTALL KUBECTL (latest stable)
# ---------------------------------------------------------------------
echo "=== Installing kubectl ==="
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
chmod +x kubectl
sudo mv kubectl /usr/local/bin/kubectl

# Verify kubectl
echo "Kubectl version:"
kubectl version --client

# ---------------------------------------------------------------------
# INSTALL KOPS (v1.32.0)
# ---------------------------------------------------------------------
echo "=== Installing kops ==="
wget -q https://github.com/kubernetes/kops/releases/download/v1.32.0/kops-linux-amd64
chmod +x kops-linux-amd64
sudo mv kops-linux-amd64 /usr/local/bin/kops

# Verify kops
echo "Kops version:"
kops version

# ---------------------------------------------------------------------
# Final PATH check
# ---------------------------------------------------------------------
if ! echo $PATH | grep -q "/usr/local/bin"; then
  echo "export PATH=\$PATH:/usr/local/bin" >> ~/.bashrc
  source ~/.bashrc
fi

echo "✅ Installation complete!"
echo "Run to verify:"
echo "  kubectl version --client"
echo "  kops version"


