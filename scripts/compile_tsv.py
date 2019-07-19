#!/usr/bin/env python3

import os

def build_dictionary():
    dictionary = {}
    with open('metadata.tsv', 'r') as src_file:
        for i in src_file:
            i = i.rstrip('\n')
            line = i.split('\t')
            dictionary[line[0]] = line
        return dictionary

def build_tsv(metadata):
    chapter_files = os.listdir('out')
    chapter_files.sort()
    for filename in chapter_files:
        with open("out/"+filename, 'r') as src_file:
            book = src_file.readline().rstrip('\n')
            chapter = src_file.readline().rstrip('\n')
            for l in src_file:
                file_line = l.split('\t')
                file_line[0] = file_line[0].rstrip(' ')
                line = metadata[book][0] + '\t' + metadata[book][1] + '\t'
                line += metadata[book][2] + '\t' + chapter + '\t' + file_line[0] + '\t' + file_line[1]
                write_tsv(line)

def write_tsv(line):
    with open('web.tsv', 'a') as out_file:
        out_file.write(line)

if __name__ == '__main__':
    metadata = build_dictionary()
    build_tsv(metadata)

