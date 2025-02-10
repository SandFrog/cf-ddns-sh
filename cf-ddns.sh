#!/bin/bash
ip=$(curl -s -4 icanhazip.com)
ipfile=$(< ip)
subdomain=
ZONE_ID=
DNS_RECORD_ID=
CLOUDFLARE_API_KEY=

if [[ $ip != $ipfile ]] && [[ $ip ]]; then
  curl -sS https://api.cloudflare.com/client/v4/zones/$ZONE_ID/dns_records/$DNS_RECORD_ID \
    -X PUT \
    -H 'Content-Type: application/json' \
    -H "Authorization: Bearer $CLOUDFLARE_API_KEY" \
    -d @- << EOF
      {
        "comment": "DDNS handled by script.",
        "content": "$ip",
        "name": "$subdomain",
        "proxied": false,
        "ttl": 300,
        "type": "A"
      }
EOF
  
  echo $ip > ip
fi
