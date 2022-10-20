#!/bin/bash


docker network create vpn-net
mkdir -p /docker/openvpn/conf /docker/openvpn/userconf


docker-compose run --rm openvpn ovpn_genconfig -u udp://$(curl -4 ipinfo.io/ip)
docker-compose run --rm openvpn ovpn_initpki
docker-compose up -d openvpn
