#! /bin/bash

echo "Setting up environment variables"
export scriptdir='/usr/share/elasticsearch/scripts'
echo $scriptdir
export curlcmd='curl --cacert /usr/share/elasticsearch/config/certs/ca/ca.crt -u elastic:'$ELASTIC_PASSWORD
echo $curlcmd
#$curlcmd -H 'Content-Type: application/json' -XGET https://es01:9200/_cluster/health?pretty

echo "changing directory"
cd $scriptdir

# # cowrie setup
echo "Setting up cowrie"
$curlcmd -H 'Content-Type: application/x-ndjson' -XPUT https://es01:9200/_ilm/policy/cowrie --data-binary @cowrie-policy.json
$curlcmd -H 'Content-Type: application/x-ndjson' -XPUT https://es01:9200/_index_template/cowrie --data-binary @cowrie-index.json

# # cowrie-dshield setup
echo "Setting up cowrie.dshield"
$curlcmd -H 'Content-Type: application/x-ndjson' -XPUT https://es01:9200/_ilm/policy/cowrie.dshield  --data-binary @cowrie-dshield-policy.json
$curlcmd -H 'Content-Type: application/x-ndjson' -XPUT https://es01:9200/_index_template/cowrie.dshield --data-binary @cowrie-dshield-index.json

# cowrie-sqlite setup
echo "Setting up cowrie.sqlite"
$curlcmd -H 'Content-Type: application/x-ndjson' -XPUT https://es01:9200/_ilm/policy/cowrie.sqlite --data-binary @cowrie-sqlite-policy.json
$curlcmd -H 'Content-Type: application/x-ndjson' -XPUT https://es01:9200/_index_template/cowrie.sqlite --data-binary @cowrie-sqlite-index.json



