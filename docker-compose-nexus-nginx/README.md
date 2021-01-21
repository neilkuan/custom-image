### To use:

I put my `docker-compose.yml` at `/var/lib/docker/nexus/docker-compose.yml`,
and launch `./update-ca.sh ${your-domain-hosted-on-route53} ${yourmail@mail.com}` at `/var/lib/docker/nexus/`

* [ ] :You need have a [domain hosted](https://docs.aws.amazon.com/zh_tw/Route53/latest/DeveloperGuide/CreatingHostedZone.html) on route53 at your account

* [ ] :You need your an email account.

```bash
./update-ca.sh ${your-domain-hosted-on-route53} ${yourmail@mail.com}

--- output
 Start renew Job 
+ docker run -it -v /var/lib/docker/nexus/entrypoint.sh:/tmp/entrypoint.sh -v /var/lib/docker/nexus/nginx/ssl/fullchain.pem:/tmp/fullchain.pem -v /var/lib/docker/nexus/nginx/ssl/privkey.pem:/tmp/privkey.pem --entrypoint ash certbot/dns-route53 /tmp/entrypoint.sh ${your-domain-hosted-on-route53} ${yourmail@mail.com}
start to renew cert from route53
Saving debug log to /var/log/letsencrypt/letsencrypt.log
Plugins selected: Authenticator dns-route53, Installer None
Obtaining a new certificate
Performing the following challenges:
dns-01 challenge for ${your-domain-hosted-on-route53}
Waiting for verification...
Cleaning up challenges

IMPORTANT NOTES:
 - Congratulations! Your certificate and chain have been saved at:
   /etc/letsencrypt/live/${your-domain-hosted-on-route53}/fullchain.pem
   Your key file has been saved at:
   /etc/letsencrypt/live/${your-domain-hosted-on-route53}/privkey.pem
   Your cert will expire on 2021-04-21. To obtain a new or tweaked
   version of this certificate in the future, simply run certbot
   again. To non-interactively renew *all* of your certificates, run
   "certbot renew"
 - Your account credentials have been saved in your Certbot
   configuration directory at /etc/letsencrypt. You should make a
   secure backup of this folder now. This configuration directory will
   also contain certificates and private keys obtained by Certbot so
   making regular backups of this folder is ideal.
 - If you like Certbot, please consider supporting our work by:

   Donating to ISRG / Let's Encrypt:   https://letsencrypt.org/donate
   Donating to EFF:                    https://eff.org/donate-le

 - We were unable to subscribe you the EFF mailing list because your
   e-mail address appears to be invalid. You can try again later by
   visiting https://act.eff.org.

start to cp cert to fullchain.pem
start to cp cert to privkey.pem
+ set +x
 Start to restart nginx
Restarting nginx ... done
 Finish Job

```

After script you will get new CA for `*.${your-domain-hosted-on-route53}` in `/var/lib/docker/nexus/nginx/ssl/`

Idea for here: https://blog.neilkuan.dev/2020/certbot_lets_encrypt_create_ca_aws_route53/