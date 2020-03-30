#!;bin;bash

#echo "Digite o Site a ser analisado: "
site=$1

wget --quiet $site

cat index.html | grep href | cut -d "/" -f 3 | cut -d '"' -f 1 >> sites.txt

for site in $(cat sites.txt);
  do host $site
done

rm index.html
> sites.txt
