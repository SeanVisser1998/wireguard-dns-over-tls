<div id="header" align="center">
  <img src="https://media.giphy.com/media/gjrYDwbjnK8x36xZIO/giphy.gif" width="150"/>

  # :lock: Wireguard DNS-over-TLS
</div>

> Note: This project currently only support IPv4 networking

### Use cases
This project was designed to cover the following use case:
- Protect clients from MITM attacks by bad actor on local network (e.g. public wifi)
- Protect clients from DNS poisining by bad actors on local and upstream networks
- Protect clients from DNS query interception by bad actors on local and upstream networks

### Technical information
- Unbound to setup local DNS server
- Use of DNS-over-TLS using Quad9 DNS resolvers
- Encrypted tunnel using WireGuard
- Uses 10.8.0.0/24 subnet
- Port 42069 for incoming WireGuard connections
- ens3 WAN interface (some systems might use eth0 for WAN interface)

### Requirements
#### Unbound
Unbound is used to setup a local DNS server in order to facilitate DNS-over-TLS.
```
sudo apt install unbound unbound -y
```

#### WireGuard
WireGuard is used to setup an encrypted tunnel between client and server
```
sudo apt install wireguard -y
```

### Configuration

#### Unbound
```
sudo cp -a /wireguard-dns-over-tls/unbound/unbound.conf.d/. /etc/unbound/unbound.conf.d/
```

#### WireGuard
```
sudo cp -a /wireguard-dns-over-tls/wireguard/. /etc/wireguard/ 
chmod +x /etc/wireguard/helper/apply-nat-routing.sh && chmod +x /etc/wireguard/helper/remove-nat-routing.sh 
wg genkey | (umask 077 && tee /etc/wireguard/keys/wg0.priv) | wg pubkey > /etc/wireguard/keys/wg0.pub
```

### Project improvements:
Looking back on the project, there are a couple of improvements that can be made to enhance this project. I intend to implement the following enhancements in the near future:

- ZeroConfig setup using cloud-init
- Supporting of IPv6
- Expanding DNS list to include more DNS providers

Other improvements include the use of DNSCrypt to enhance DNS privacy even further, however I currently see no use for this given the use case.
