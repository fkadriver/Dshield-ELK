#! /bin/bash

echo "Setting up environment variables"
export scriptdir='/usr/share/scripts'
echo $scriptdir
export curlcmd='curl --cacert /usr/share/config/certs/ca/ca.crt -u elastic:'$ELASTIC_PASSWORD
echo $curlcmd
#$curlcmd -H 'Content-Type: application/json' -XGET https://es01:9200/_cluster/health?pretty

echo "changing directory"
cd $scriptdir

# cowrie setup
echo "Setting up cowrie"
$curlcmd -s -H 'Content-Type: application/x-ndjson' -XPUT https://es01:9200/_ilm/policy/cowrie --data-binary @cowrie-policy.json; echo
$curlcmd -s -H 'Content-Type: application/x-ndjson' -XPUT https://es01:9200/_index_template/cowrie --data-binary @cowrie-index.json; echo

# cowrie-dshield setup
echo "Setting up cowrie.dshield"
$curlcmd -s -H 'Content-Type: application/x-ndjson' -XPUT https://es01:9200/_ilm/policy/cowrie.dshield  --data-binary @cowrie-dshield-policy.json; echo
$curlcmd -s -H 'Content-Type: application/x-ndjson' -XPUT https://es01:9200/_index_template/cowrie.dshield --data-binary @cowrie-dshield-index.json; echo

# cowrie-sqlite setup
echo "Setting up cowrie.sqlite"
$curlcmd -s -H 'Content-Type: application/x-ndjson' -XPUT https://es01:9200/_ilm/policy/cowrie.sqlite --data-binary @cowrie-sqlite-policy.json; echo
$curlcmd -s -H 'Content-Type: application/x-ndjson' -XPUT https://es01:9200/_index_template/cowrie.sqlite --data-binary @cowrie-sqlite-index.json; echo

# # dashboard setup
echo "Setting up dshield_sensor"
# #$curlcmd -H 'Content-Type: application/x-ndjson' -XPUT https://es01:9200/_bulk?pretty --data-binary @dshield_sensor_8.7.1.ndjson
curl -v --cacert /usr/share/config/certs/ca/ca.crt -u kibana_system:$KIBANA_PASSWORD -X POST https://es01:5601/api/saved_objects/_import -H "kbn-xsrf: true" --form file=@dshield_sensor_8.71.ndjson -H 'kbn-xsrf: true';echo
# curl -u kibana_system:changeme  -X POST localhost:5601/api/saved_objects/_import -H "kbn-xsrf: true" --form file=@dshield_sensor_8.71.ndjson -H 'kbn-xsrf: true'

