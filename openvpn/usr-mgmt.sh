#!/bin/bash

echo ""
echo "ca key: MyCaKeyMadeOn_initpki"
echo ""

ACTION="$1"
CLIENTNAME="$2"
USERCONF="/docker/openvpn/userconf"

function CREATE {
docker-compose exec openvpn easyrsa build-client-full $CLIENTNAME nopass
docker-compose exec openvpn ovpn_getclient $CLIENTNAME > $USERCONF/$CLIENTNAME.ovpn
}

function REMOVE {
docker-compose exec openvpn ovpn_revokeclient $CLIENTNAME remove
rm $USERCONF/$CLIENTNAME
}

function LIST {
# list active users
docker-compose exec openvpn ovpn_listclients
}

function USAGE {
echo ""
echo "how to use it:"

echo "list users:"
echo $0 -l

echo "create user:"
echo $0 -c username

echo "delete user:"
echo $0 -r username

echo ""
exit 1
}

case $ACTION in
        "-l")
        LIST
        ;;

        "-r"|"-d")
        [ "$CLIENTNAME" == "" ]  && USAGE
        REMOVE
        ;;

        "-c"|"-a")
        [ "$CLIENTNAME" == "" ]  && USAGE
        CREATE
        ;;

        *)
        echo "usage"
        USAGE
        ;;
esac


