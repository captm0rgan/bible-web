#!/usr/bin/env python3

import sys

def write_metadata(line, filename):
    with open(filename, 'a') as file:
        file.write(line + "\n")

if __name__ == '__main__':
    filename = "".join(sys.argv[1])
    with open("kjv.tsv", 'r') as src_file:
        for l in src_file:
            line = l.split('\t')
            write_metadata(line[0] + '\t' + line[1] + '\t' + line[2], filename)
