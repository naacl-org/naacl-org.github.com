#!/bin/sh

for FILE in `find . -name "*.textile"`
do
    MD=`dirname $FILE`/`basename $FILE ".textile"`.md
    echo "$FILE --> $MD"
    pandoc --from=textile --to=markdown_github -o $MD $FILE
    sed -i '' 's/------------------------------------------------------------------------/---/' $MD
    sed -i '' 's/\\_/_/g' $MD
    sed -i '' 's/({{)\(.*\)$/({{\1)/g' $MD
    sed -i '' 's/| "\(.*\)":\(.*\) |/| [\1](\2) |/g' $MD
    perl -i -pe 's/-->/-->\n/g' $MD
    perl -i -pe 's|</p>|</p>\n|g' $MD
    rm $FILE
done
