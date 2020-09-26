#!/bin/bash
set -x


BASE_ES="http://localhost:9200"

for index in $(curl -s ${BASE_ES}/_cat/indices/restored_*?pretty=true | awk '{print $3}');do
  
  new_index=$(echo $index | sed -E 's/restored_(.*)restored_/\1/')

  curl -s -XPUT ${BASE_ES}/${new_index} -d '{"number_of_shards" : '1'}'
  #sleep 1

done

wait
exit

for index in $(curl -s ${BASE_ES}/_cat/indices/restored_*?pretty=true | awk '{print $3}');do
  curl -s -XPOST ${BASE_ES}/_reindex -d '{ 
  "source": {
    "index": "'${index}'"
  },
  "dest": {
    "index": "'${new_index}'"
  }
  }' &
  sleep 0.1

done

wait

IFS=$'\n'
for xalias in $(curl -s ${BASE_ES}/_cat/aliases?pretty=true);do

  name=$(echo $xalias | awk '{print $1}')
  old_alias=$(echo $xalias | awk '{print $2}')
  new_alias=$(echo $old_alias | sed -E 's/restored_(.*)restored_/\1/') 

  curl -s -XPOST ${BASE_ES}/_aliases -d '{
  "actions" : [
    { "remove": { "alias": "'$name'", "index": "'$old_alias'" } },
    { "add" : { "alias": "'$name'", "index": "'$new_alias'" } }
  ]
  }' &
  sleep 0.1

done

wait

