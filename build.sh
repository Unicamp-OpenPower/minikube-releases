go_import_path: k8s.io/minikube

cd ..
sudo mkdir k8s.io
cd k8s.io
sudo wget https://github.com/kubernetes/minikube/archive/v0.34.0.zip
sudo unzip v0.34.0.zip
sudo mv minikube-0.34.0 minikube
sudo chmod -R 777 minikube
cd minikube
sudo make
sudo make test
sudo mv /out/minikube /out/minikube_0.34.0
sudo lftp -c "open -u $USER,$PASS ftp://oplab9.parqtec.unicamp.br; put -O /ppc64el/minikube/ /home/ubuntu/go/src/k8s.io/minikube/out/minikube_0.34.0" 
