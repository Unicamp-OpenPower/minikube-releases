FTP_HOST='oplab9.parqtec.unicamp.br'
LOCALPATH=$GOPATH/src
REMOTEPATH='/ppc64el/minikube'
ROOTPATH="~/rpmbuild/RPMS/ppc64le"
REPO1="/repository/debian/ppc64el/minikube"
REPO2="/repository/rpm/ppc64le/minikube"
github_version=$(cat github_version.txt)
ftp_version=$(cat ftp_version.txt)
del_version=$(cat delete_version.txt)

if [ $github_version != $ftp_version ]
then
    cd $LOCALPATH
    mkdir k8s.io
    cd k8s.io
    sudo wget https://github.com/kubernetes/minikube/archive/v$github_version.zip
    sudo unzip v$github_version.zip
    sudo mv minikube-$github_version minikube
    sudo chmod -R 777 minikube
    cd minikube
    make
    make test
    sudo mv $LOCALPATH/k8s.io/minikube/out/minikube $LOCALPATH/k8s.io/minikube/out/minikube_$github_version
    git clone https://$USERNAME:$TOKEN@github.com/Unicamp-OpenPower/repository-scrips.git
    cd repository-scrips/
    chmod +x empacotar-deb.sh
    chmod +x empacotar-rpm.sh
    sudo mv empacotar-deb.sh $LOCALPATH/k8s.io/minikube/out/
    sudo mv empacotar-rpm.sh $LOCALPATH/k8s.io/minikube/out/
    cd $LOCALPATH/k8s.io/minikube/out/
    sudo ./empacotar-deb.sh minikube minikube_$github_version $github_version " "
    sudo ./empacotar-rpm.sh minikube minikube_$github_version $github_version " " "minikube implements a local Kubernetes cluster on macOS, Linux, and Windows"
    if [[ $github_version > $ftp_version ]]
    then
        sudo lftp -c "open -u $USER,$PASS ftp://oplab9.parqtec.unicamp.br; put -O /ppc64el/minikube/latest/ $LOCALPATH/k8s.io/minikube/out/minikube_$github_version"
        sudo lftp -c "open -u $USER,$PASS ftp://oplab9.parqtec.unicamp.br; rm /ppc64el/minikube/latest/minikube_$del_version"
        lftp -c "open -u $USER,$PASS ftp://oplab9.parqtec.unicamp.br; put -O $REPO1 $LOCALPATH/k8s.io/minikube/out/minikube-$github_version-ppc64le.deb"
        sudo lftp -c "open -u $USER,$PASS ftp://oplab9.parqtec.unicamp.br; put -O $REPO2 $ROOTPATH/minikube-$github_version-1.ppc64le.rpm"
    fi
    sudo lftp -c "open -u $USER,$PASS ftp://oplab9.parqtec.unicamp.br; put -O /ppc64el/minikube/ $LOCALPATH/k8s.io/minikube/out/minikube_$github_version"
    sudo lftp -c "open -u $USER,$PASS ftp://oplab9.parqtec.unicamp.br; rm /ppc64el/minikube/minikube_$del_version"
fi
