#!/bin/sh
proxy_port=7892
lan_ip=192.168.50.1
ssh_port=22

# ports redirect for clash except port 22 for ssh connection
iptables -t nat -A PREROUTING -p tcp --dport $ssh_port -j ACCEPT

# new
iptables -t nat -N CLASH
iptables -t nat -A CLASH -d 192.168.0.0/16 -j RETURN
iptables -t nat -A CLASH -d 10.0.0.0/8 -j RETURN
iptables -t nat -A CLASH -d 127.0.0.0/8 -j RETURN
iptables -t nat -A CLASH -d 169.254.0.0/16 -j RETURN
iptables -t nat -A CLASH -d 172.16.0.0/12 -j RETURN
iptables -t nat -A CLASH -d 224.0.0.0/4 -j RETURN
iptables -t nat -A CLASH -d 240.0.0.0/4 -j RETURN

# redirect to Clash and except udp
iptables -t nat -A CLASH -p tcp -j REDIRECT --to-ports $proxy_port
iptables -t nat -A PREROUTING ! -p udp -j CLASH

# DNS
iptables -t nat -I PREROUTING -p udp -m udp -d $lan_ip --dport 53 -j DNAT --to-destination $lan_ip:55

