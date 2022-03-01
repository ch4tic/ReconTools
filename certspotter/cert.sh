curl -s https://api.certspotter.com/v1/issuances\?domain\=$1\&expand\=dns_names\&expand\=issuer | jq '.[].dns_names[]' | tr -d '"' | sort -u
