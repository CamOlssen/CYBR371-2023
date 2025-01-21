#!/usr/bin/python
from scapy.all import *

target_ip = "192.168.231.52" #target ip address, change as necessary

packet = IP(dst=target_ip)/TCP()
packet[TCP].flags="UFP"

send(packet)