
pyang -p ../ -f tree yang/ietf-twamp\@*.yang > yang/ietf-twamp-tree.txt.tmp

fold -w 71 yang/ietf-twamp-tree.txt.tmp > yang/ietf-twamp-tree.txt

rm yang/*-tree.txt.tmp
