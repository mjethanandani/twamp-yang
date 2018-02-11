for i in yang/*\@$(date +%Y-%m-%d).yang
do
    name=$(echo $i | cut -f 1 -d '.')
    echo $name
    if test "${name#^example}" = "$name"; then
        pyang -p ../ -f tree --tree-line-length=69 $name.yang > $name-tree.txt.tmp
    else            
        pyang --ietf -p ../ -f tree --ietf --tree-line-length=69 $name.yang > $name-tree.txt.tmp
    fi
    fold -w 71 $name-tree.txt.tmp > $name-tree.txt
    yanglint -p ../../ $name.yang
done
rm yang/*-tree.txt.tmp
