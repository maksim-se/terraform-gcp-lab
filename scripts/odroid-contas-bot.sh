#!/bin/bash

project_name="odroid-contas"
git_clone_url="https://github.com/dodopontocom/${project_name}.git"

# Exporting variables, retrieved from Metadata
export TELEGRAM_TOKEN=$(curl -H "Metadata-Flavor: Google" http://metadata/computeMetadata/v1/instance/attributes/TELEGRAM_TOKEN)
export NOTIFICATION_IDS=$(curl -H "Metadata-Flavor: Google" http://metadata/computeMetadata/v1/instance/attributes/NOTIFICATION_IDS)

#install docker
sudo apt-get update
sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

sudo apt-get update
sudo apt-get install -y docker-ce

#clone repository for hadoop lab sample
git clone ${git_clone_url}
cd ${project_name}
echo "-=-"
echo -e 'export PENDING_PEDIDO="/tmp/pedido.pending"; export TMP_PEDIDO="/tmp/pedido_cadastro.log"; export BOT_BKP_PATH="/mnt/sdcard/telegram_bots_bkp"; export CHAT_SIMPLE_REPLY="${BASEDIR}/texts/words.txt"; export CENTRAL_OF_MESSAGES_FILE="${BASEDIR}/texts/central_of_messages.txt"; export BOT_COMMANDS_LIST="${BASEDIR}/texts/commands_list.txt"; export TRANSFER_FOLDER="odroid-bot"; export DODRONES_MOUNT_PATH="/mnt/hd1"; export DODRONES_DJI_PATH="${DODRONES_MOUNT_PATH}/DJI"; export DODRONES_DJI_DEST_PATH="${DODRONES_DJI_PATH}/${TRANSFER_FOLDER}"; export DODRONES_HOST="rodolfo@192.168.0.105"; export DODRONES_HOST_PATH="/home/rodolfo/Desktop/${TRANSFER_FOLDER}"; export API_GIT_URL="https://github.com/shellscriptx/shellbot.git"; export API_VERSION_RAW_URL="https://raw.githubusercontent.com/shellscriptx/shellbot/master/ShellBot.sh"; export LOTOMANIA_API_URL="https://www.lotodicas.com.br/api"; export TIMEZONE_API_URL="http://worldtimeapi.org/api/timezone"; export MOTION_DETECTED_PATH="/mnt/sdcard/motion/detect"; export MOTION_NOTIFICATION_IDS=(11504381 449542698); export TRIP_CHECKLIST_FILE="${BASEDIR}/texts/trip_checklist.csv"; export GNU_PLOT_ORIGINAL_SCRIPT="${BASEDIR}/configs/original_plot.gp"; export GNU_PLOT_SCRIPT="${BASEDIR}/configs/plot.gp"; export GNU_PLOT_IMAGE_OUTPUT="/tmp/temp_plot_image.png"; export GNU_PLOT_DAT="${BASEDIR}/configs/test.dat"; export STATS_LOG_PATH="/home/odroid/telegram_bots_logs/contas_"' > .definitions.sh
echo "=-="

sudo docker build -t bot .
sudo docker run -i --name bot bot
