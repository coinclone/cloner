#!/usr/bin/python
from sys import argv

l = open(argv[1]).readlines()
s = ''

for i in l[l.index('pub: \n') + 1:l.index('ASN1 OID: secp256k1\n')]:
    s = s + i.strip().replace(':','')

print s

