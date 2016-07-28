#!/bin/sh

# make sure input params are good
if [ "$#" == "0" ]; then
    echo "Usage: $0 file"
    exit
fi

cp $1 .tmp.new.txt
while ( grep INSERT_TEXT_FROM_FILE .tmp.new.txt >> /dev/null ); do
    i=`grep -n INSERT_TEXT_FROM_FILE .tmp.new.txt | head -1`
    linenum=`echo $i | sed 's/:.*//'`
    file=`echo $i | sed 's/.*(\(.*\))/\1/'`

    awk "NR<$linenum" .tmp.new.txt > .tmp.pre.txt
    awk "NR>$linenum" .tmp.new.txt > .tmp.post.txt

    cat .tmp.pre.txt $file .tmp.post.txt > .tmp.new.txt
done

cat .tmp.new.txt
rm .tmp.pre.txt .tmp.post.txt .tmp.new.txt


