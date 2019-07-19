#!/bin/sh

# copy the plaintext files, number the lines, and rename to an easier filename
for i in plaintext/*.txt
do
	booknum=$(echo $i | cut -d "_" -f 2 | cut -c 2-)
	book=$(echo $i | cut -d "_" -f 3)
	chapternum=$(echo $i | cut -d "_" -f 4)
	filename="$booknum"_"$book"_"$chapternum".txt
	nl -v -1 -nln "$i" > out/"$filename"
done

cd out

# get the book name and chapter number from the second chapter of every book
# The first chapter has more text (The Book of $book), so second was easier
# Replace all book names and numbers in that book with these
for i in *02.txt
do
	bookname=$(head -n 1 $i | rev | cut -c 2- | rev | cut -f 2-)
	booknum=$(echo $i | cut -d "_" -f 1)
	for i in "$booknum"_*_*.txt
	do
		sed -i "1s/.*/$bookname/" $i
		chapter=$(head -n 2 $i | tail -n 1 | cut -f 2 | cut -d " " -f 2 | rev | cut -c 2- | rev)
		sed -i "2s/.*/$chapter/" $i
		sed -i "1s/^\xEF\xBB\xBF//" $i
	done
done

# replace "Psalm" with "Psalms" for the book of Psalms to match metadata
for i in 20*.txt
do
	sed -i "1s/.*/Psalms/" $i
	sed -i "1s/^\xEF\xBB\xBF//" $i
done

# replace "Acts" with "The Acts" for the book of Acts to match metadata
for i in 74*.txt
do
	sed -i "1s/.*/The Acts/" $i
	sed -i "1s/^\xEF\xBB\xBF//" $i
done

# fix bookname and chapter like above for books with only one chapter
# Obadiah
sed -i "1s/.*/Obadiah/" 32_OBA_01.txt
sed -i "2s/.*/1/" 32_OBA_01.txt 
sed -i "1s/^\xEF\xBB\xBF//" 32_OBA_01.txt 

# Philemon
sed -i "1s/.*/Philemon/" 87_PHM_01.txt
sed -i "2s/.*/1/" 87_PHM_01.txt
sed -i "1s/^\xEF\xBB\xBF//" 87_PHM_01.txt 

# 2nd John
sed -i "1s/.*/2 John/" 93_2JN_01.txt
sed -i "2s/.*/1/" 93_2JN_01.txt
sed -i "1s/^\xEF\xBB\xBF//" 93_2JN_01.txt 

# 3rd John
sed -i "1s/.*/3 John/" 94_3JN_01.txt
sed -i "2s/.*/1/" 94_3JN_01.txt
sed -i "1s/^\xEF\xBB\xBF//" 94_3JN_01.txt 

# Jude
sed -i "1s/.*/Jude/" 95_JUD_01.txt
sed -i "2s/.*/1/" 95_JUD_01.txt
sed -i "1s/^\xEF\xBB\xBF//" 95_JUD_01.txt 

