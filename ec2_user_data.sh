#!/usr/bin/env bash

curl -Lo kubectl https://storage.googleapis.com/kubernetes-release/release/v1.13.2/bin/linux/amd64/kubectl && chmod +x kubectl && sudo cp kubectl /usr/local/bin/ && rm kubectl

curl -Lo /usr/local/bin/minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64 && chmod +x /usr/local/bin/minikube

apt update && apt install -y docker.io python-minimal socat
