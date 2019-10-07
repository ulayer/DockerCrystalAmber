Our configuration for running Crystal & Amber inside Docker in Production ❤️

## Production Notes
We recommend updating `boot.sh` on production to skip the OpenVPN connection and use local IP Addresses instead. We also recommend removing the following from docker-compose.yml, while it's helpful for allowing OpenVPN in our development environment, running a privileged container in production poses a security risk and should be avoided where possible.
```
privileged: true
cap_add:
  - NET_ADMIN
devices:
  - /dev/net/tun
```
