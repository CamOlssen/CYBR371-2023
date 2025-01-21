#!/usr/bin/python
from scapy.all import *

def monitor_icmp(packet):
    if packet[ICMP].type == 8: #is it an icmp echo request?
        print("ICMP Echo Request recieved.")
    	response = IP(src=packet[IP].dst, dst=packet[IP].src, ttl=128) #ttl of a windows packet
    	icmp = ICMP(type=0, id=packet[ICMP].id, seq=packet[ICMP].seq) #icmp reply packet
    	response_packet = response/icmp
    	send(response_packet, verbose=0)
    	print("Packet sent")

sniff(filter="icmp", prn=(monitor_icmp))
