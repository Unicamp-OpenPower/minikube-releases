import requests

# find and save the current Minikube release
html = str(
    requests.get('https://github.com/kubernetes/minikube/releases/latest').content)
index = html.find('Release ')
current_version = html[index + 9:index + 15]
file = open('github_version.txt', 'w')
file.writelines(current_version.strip(" "))
file.close()

# find and save the current Minikube version on FTP server
html = str(
    requests.get(
        'https://oplab9.parqtec.unicamp.br/pub/ppc64el/minikube/'
    ).content)
index = html.rfind('minikube_')
ftp_version = html[index + 9:index + 15]
file = open('ftp_version.txt', 'w')
file.writelines(ftp_version.strip(" "))
file.close()

# find and save the oldest Minikube version on FTP server
index = html.find('minikube_')
delete = html[index + 9:index + 15]
file = open('delete_version.txt', 'w')
file.writelines(delete.strip(" "))
file.close()
