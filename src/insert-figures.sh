#!/bin/bash

# make sure input params are good
if [ "$#" == "0" ]; then
    echo "Usage: $0 file[,fold-length]"
    exit
fi

cp $1 .tmp.new.txt
while ( grep INSERT_TEXT_FROM_FILE .tmp.new.txt >> /dev/null ); do
    i=`grep -n INSERT_TEXT_FROM_FILE .tmp.new.txt | head -1`
    linenum=`echo $i | sed 's/:.*//'`
    file=`echo $i | sed 's/.*(\(.*\))/\1/'`

    awk "NR<$linenum" .tmp.new.txt > .tmp.pre.txt
    awk "NR>$linenum" .tmp.new.txt > .tmp.post.txt

    if [ `echo $file | grep ","` ]; then
      col=`echo $file | sed 's/.*,//'`
      file=`echo $file | sed 's/,.*//'`
      file2=$file.2
      echo "[note: '\' line wrapping is for formatting only]" > $file2
      echo "" >> $file2
      gsed "s/\(.\{$col\}\)/\1\\\\\n/" < $file >> $file2
      cat .tmp.pre.txt $file2 .tmp.post.txt > .tmp.new.txt
      rm $file2
    else
      cat .tmp.pre.txt $file .tmp.post.txt > .tmp.new.txt
    fi
done

cat .tmp.new.txt
rm .tmp.pre.txt .tmp.post.txt .tmp.new.txt


