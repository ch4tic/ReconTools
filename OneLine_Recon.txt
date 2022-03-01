# Grab from crt.sh
echo "targetdomain.com" | xargs -I testdomain curl -s "https://crt.sh/?q=%.testdomain&output=json" |  jq '.name_value' | sed 's/\"//g' | sed 's/\*\.//g' | sort -u


# Grab from certspotter.com
echo "targetdomain.com" | xargs -I testdomain curl -s https://certspotter.com/api/v0/certs\?domain\=testdomain | jq '.[].dns_names[]' | sed 's/\"//g' | sed 's/\*\.//g' | sort -u


# Enumerate hosts from SSL Certificate
echo | openssl s_client -connect https://targetdomain.com:443  | openssl x509 -noout -text | grep DNS


# Google DNS via HTTPS
echo "targetdomain.com" | xargs -I domain proxychains curl -s "https://dns.google.com/resolve?name=domain&type=A" | jq .


# Use CommonCrawl to find endpoints on a site
echo "targetdomain.com" | xargs -I domain curl -s "http://index.commoncrawl.org/CC-MAIN-2018-22-index?url=*.domain&output=json" | jq -r .url | sort -u 


# NMAP scanning via Shodan (unfinished, needs xargs)
nmap --script shodan-api --script-args 'http://shodan-api.target =$IP,shodan-api.apikey=API_KEY'
