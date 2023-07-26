#! /bin/bash

export pwd=elastic:changeme
export curlcmd='curl --cacert /usr/share/elasticsearch/config/certs/ca/ca.crt -u elastic:changeme'
#$curlcmd -H 'Content-Type: application/json' -XGET https://es01:9200/_cluster/health?pretty

$curlcmd -XGET https://es01:9200/cowrie-*/_ilm/explain?pretty
#$curlcmd -H 'Content-Type: application/x-ndjson' -XPUT https://es01:9200/_ilm/policy/cowrie --data-binary @cowrie-policy.json