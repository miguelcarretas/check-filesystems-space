#!/bin/bash

# Destinatario del correo
destinatario="destinatario@example.com"

####### Cuerpo del script ########

df -h | awk '{print $6}' | egrep -v "Montado" > /tmp/filesystems.list

while read line
do

# Consultamos la ocupación del dispositivo

ocupacion=`df -h | grep $line$ | awk '{print $5}' | cut -d"%" -f1`


# Si la ocupación es mayor a un valor en %…
if [ $ocupacion -ge 80 ];
then
        # Preparación y envío del correo
        df -h | grep $line$ > storage.txt
        asunto=$(echo "Alerta de espacio en " `hostname` " – " $line)
        mailx -S from="emisor@example.com" -s "$asunto" $destinatario < storage.txt
fi

done < /tmp/filesystems.list

# 5 * * * * root sh /root/scripts/space_v2.sh >/dev/null 2>&1
