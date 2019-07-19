#!/bin/sh
./create_metadata.py
./format_text_files.sh
./compile_tsv.py
