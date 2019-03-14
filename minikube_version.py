import requests

# find and save the current Minikube release
html = str(
    requests.get('https://github.com/kubernetes/minikube/releases').content)
index = html.find('tree/')
current_version = html[index + 6:index + 12]
file = open('current_version.txt', 'w')
file.writelines(current_version)
file.close()

# find and save the current Minikube version on FTP server
html = str(
    requests.get(
        'https://oplab9.parqtec.unicamp.br/pub/ppc64el/minikube/'
    ).content)
index = html.find('/ta')
ftp_version = html[index - 145:index - 139]
file = open('ftp_version.txt', 'w')
file.writelines(ftp_version)
file.close()

# find and save the last Minikube version on FTP server
index = html.find('_')
delete = html[index + 1:index + 7]
file = open('delete_version.txt', 'w')
file.writelines(delete)
file.close()
