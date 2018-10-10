#!/usr/bin/env bash

curl -Lo kubectl https://storage.googleapis.com/kubernetes-release/release/v1.10.0/bin/linux/amd64/kubectl && chmod +x kubectl && sudo cp kubectl /usr/local/bin/ && rm kubectl

curl -Lo /usr/local/bin/minikube https://github.com/kubernetes/minikube/releases/download/v0.30.0/minikube-linux-amd64 && chmod +x /usr/local/bin/minikube

apt update && apt install -y docker.io python-minimal
