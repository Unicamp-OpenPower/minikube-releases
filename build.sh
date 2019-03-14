cd $GOPATH/src
sudo mkdir k8s.io
cd k8s.io
sudo wget https://github.com/kubernetes/minikube/archive/v0.34.0.zip
sudo unzip v0.34.0.zip
sudo mv minikube-0.34.0 minikube
sudo chmod -R 777 minikube
sudo make
sudo make test
