#!/bin/ash
DOMAIN_NAME=$1
MAIL=$2
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'

echo -e "${GREEN}start to renew cert from route53${NC}"
certbot certonly --agree-tos \
--dns-route53 \
--dns-route53-propagation-seconds 30 \
-d *.${DOMAIN_NAME} -m ${MAIL} --eff-email

sleep 30

echo -e "${GREEN}start to cp cert to fullchain.pem${NC}"
cat /etc/letsencrypt/live/cathayins-dev.com/fullchain.pem > /tmp/fullchain.pem || echo -e "copy fullchain.pem ${RED}fail${NC}"
echo -e "${GREEN}start to cp cert to privkey.pem${NC}"
cat /etc/letsencrypt/live/cathayins-dev.com/privkey.pem > /tmp/privkey.pem || echo -e "copy privkey.pem ${RED}fail${NC}"