if [ $(cat current_version.txt) != $(cat ftp_version.txt) ]
then
    version=$(cat current_version.txt)
    del_version=$(cat delete_version.txt)
    old_version=$(cat ftp_version.txt)
    cd /home/travis/gopath/src
    mkdir k8s.io
    cd k8s.io
    sudo wget https://github.com/kubernetes/minikube/archive/v$version.zip
    sudo unzip v$version.zip
    sudo mv minikube-$version minikube
    sudo chmod -R 777 minikube
    cd minikube
    make
    make test
    sudo mv /home/travis/gopath/src/k8s.io/minikube/out/minikube /home/travis/gopath/src/k8s.io/minikube/out/minikube_$version
    if [[ $version > $old_version ]]
    then
        sudo lftp -c "open -u $USER,$PASS ftp://oplab9.parqtec.unicamp.br; put -O /ppc64el/minikube/latest/ /home/travis/gopath/src/k8s.io/minikube/out/minikube_$version"
        sudo lftp -c "open -u $USER,$PASS ftp://oplab9.parqtec.unicamp.br; rm /ppc64el/minikube/latest/minikube_$old_version" 
    fi
    sudo lftp -c "open -u $USER,$PASS ftp://oplab9.parqtec.unicamp.br; put -O /ppc64el/minikube/ /home/travis/gopath/src/k8s.io/minikube/out/minikube_$version" 
#    sudo lftp -c "open -u $USER,$PASS ftp://oplab9.parqtec.unicamp.br; rm /ppc64el/minikube/minikube_$del_version" 
fi
