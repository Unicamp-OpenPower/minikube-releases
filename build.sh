    version=$(cat current_version.txt)
    export PATH=$PATH:/usr/local/go/bin
    export GOPATH=/home/ubuntu/go;
    export PATH=$PATH:$GOPATH/bin;
    sudo rm -r /home/ubuntu/go/src/k8s.io/
    sudo mkdir /home/ubuntu/go/src/k8s.io
    sudo wget -P /home/ubuntu/go/src/k8s.io https://github.com/kubernetes/minikube/archive/v$version.zip
    sudo unzip /home/ubuntu/go/src/k8s.io/v$version.zip -d /home/ubuntu/go/src/k8s.io/
    sudo rm /home/ubuntu/go/src/k8s.io/v$version.zip
    sudo mv /home/ubuntu/go/src/k8s.io/minikube-$version /home/ubuntu/go/src/k8s.io/minikube
    sudo chmod -R 777 /home/ubuntu/go/src/k8s.io/minikube
    make -C /home/ubuntu/go/src/k8s.io/minikube
    make test -C /home/ubuntu/go/src/k8s.io/minikube
    sudo mv /home/ubuntu/go/src/k8s.io/minikube/out/minikube /home/ubuntu/go/src/k8s.io/minikube/out/minikube_$version
    sudo lftp -c "open -u gustavosalibi,wfa@7l?rx?xI3NO1 ftp://oplab9.parqtec.unicamp.br; put -O /ppc64el/minikube/ /home/ubuntu/go/src/k8s.io/minikube/out/minikube_$version" 
    del_version=$(cat delete_version.txt)
