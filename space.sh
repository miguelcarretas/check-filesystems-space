#!/bin/bash

# Sistemas de ficheros a chequear
device=/mnt/dir1/subdir1

# Destinatario del correo
destinatario="destinatario@example.com"

####### Cuerpo del script ########

# Consultamos la ocupación del dispositivo
ocupacion=$(df -h | grep $device$ | expand | tr -s " " | cut -d " " -f5 | cut -d "%" -f1)

# Si la ocupación es mayor al 85%…
if [ $ocupacion -ge 85 ];
then
        # Preparación y envío del correo
        df -h > storage.txt
        asunto=$(echo "Alerta de espacio en " `hostname` " – " $device)
        mailx -S from="emisor@example.com" -s "$asunto" $destinatario < storage.txt
fi

# 5 * * * * root sh /root/scripts/space.sh >/dev/null 2>&1
