#!/bin/bash
echo "meshmsg send: type your message and press enter"
while true; do
read SEND
echo "sending message..."
meshtastic --sendtext "$SEND" 2> send.output
clear
while grep "unavailable" send.output > /dev/null;
do
    echo "working..."
meshtastic --sendtext "$SEND" > send.output 2>/dev/null
clear
done

echo "$SEND" > send.tmp;done
