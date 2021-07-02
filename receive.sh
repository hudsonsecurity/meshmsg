#!/bin/bash
sleep 2
echo "meshmsg v0.1 terminal"
rm mesh.tmp 2>/dev/null
#get the owner info once and print it once
meshtastic --info 2>/dev/null > mesh.tmp
OWNER=`cat mesh.tmp | grep Owner | awk '{print $2}'`
echo "joining the session as $OWNER"
while true; do 
#look for incoming messages
meshtastic --info 2>/dev/null > mesh.tmp
#extracts message payload
MSG=`cat mesh.tmp | grep text | sed 's/^.*text/text/' | cut -f1 -d"}" | cut -c8- | tr -d "'" && sleep 3`
SEND=`cat send.tmp 2>/dev/null`
if [ -z "$MSG" ]
then
export fail=true
else
#get mesg info
#USER=`meshtastic --nodes | grep "f2469f38" | sed 's/f2469f38.*//' | tr -d '│' | awk '{print $2}'`
USER=`cat mesh.tmp | grep text | sed 's/^.*longName/longName/' | awk '{print $2}' | tr -d "',"`
DATE=`date "+%D %T"`
echo "[$DATE]" "$USER:" "$MSG" "(RECV)"
fi
if [ -z "$SEND" ]
then
export fail=true
else
DATE=`date "+%D %T"`
echo "[$DATE]" "$OWNER:" "$SEND" "(SENT)"
fi
rm send.tmp 2>/dev/null
rm mesh.tmp; done
