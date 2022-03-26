#!/bin/bash

SERVER_HOST=0.0.0.0 // need to change to your server host
SSH_CMD="sudo ssh -tt -o StrictHostKeyChecking=no -i /home/ubuntu/.ssh/id_rsa ubuntu"
SCP_CMD="sudo scp -o StrictHostKeyChecking=no -i /home/ubuntu/.ssh/id_rsa docker-install.sh ubuntu0@$SERVER_HOST:"

touch ./docker-install.sh
sudo chmod 777 ./docker-install.sh

echo "#!/bin/bash

sudo apt update && sudo apt install apt-transport-https ca-certificates curl software-properties-common zip -y
sudo rm /usr/share/keyrings/docker-archive-keyring.gpg | true
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt update && sudo apt install docker-ce docker-ce-cli containerd.io -y
sudo docker --version

sudo apt update
sudo curl -L "https://github.com/docker/compose/releases/download/v2.3.4/docker-compose-linux-x86_64" -o /usr/local/bin/docker-compose
sudo sudo chmod +x /usr/local/bin/docker-compose
sudo docker-compose --version" >> ./docker-install.sh

$SCP_CMD
$SSH_CMD@$SERVER_HOST sudo sh ./docker-install.sh