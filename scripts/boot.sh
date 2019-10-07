openvpn --config /app/keys/docker.ovpn --daemon
echo "nameserver 9.9.9.9" >> /etc/resolv.conf
sudo su panel
amber watch