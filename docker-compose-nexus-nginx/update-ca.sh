#!/bin/bash
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'
if [ $# -ne "2" ]; then
   echo -e "${RED}Please use ./update-ca.sh${NC} ${GREEN}DOMAIN_NAME NOTIFY_EMAIL ${NC}"
   exit 1
fi

echo -e "${GREEN} Start renew Job ${NC}"

set -x
docker run -it -v /var/lib/docker/nexus/entrypoint.sh:/tmp/entrypoint.sh -v /var/lib/docker/nexus/nginx/ssl/fullchain.pem:/tmp/fullchain.pem \
-v /var/lib/docker/nexus/nginx/ssl/privkey.pem:/tmp/privkey.pem  --entrypoint ash certbot/dns-route53 \
/tmp/entrypoint.sh $1 $2

# restart nginx
set +x
echo -e "${GREEN} Start to restart nginx${NC}"
docker-compose -f /var/lib/docker/nexus/docker-compose.yml restart nginx || echo -e "${RED}Resatrt Fail${NC}"

echo -e "${GREEN} Finish Job${NC}"