# cf-ddns.sh
## Background:
This repo intends to update a DNS entry through Cloudflare's API through a simple bash script and accompanying systemd timer & unit file.

## Requirements:
- Cloudflare account & domain.
- Something running Linux that you want DDNS for.

## First time setup:
1. Find your account [zone ID](https://developers.cloudflare.com/fundamentals/setup/find-account-and-zone-ids/).
2. [Create an API token](https://developers.cloudflare.com/fundamentals/api/get-started/create-token/).
3. Get your DNS record ID by entering the following command:
    - `curl https://api.cloudflare.com/client/v4/zones/$ZONE_ID/dns_records?name=subdomain.example.com -H "Authorization: Bearer $CLOUDFLARE_API_TOKEN"`
4. Enter the above information into the cf-ddns.sh file.
5. Edit the service file so the WorkingDirectory & ExecStart point to where this directory is.
5. Install the systemd service and timer files with these commands:
    1. `sudo cp ./{cf-ddns.timer,cf-ddns.service} /etc/systemd/system/`
    2. `sudo systemctl enable cf-ddns.service cf-ddns.timer`
    3. `sudo systemctl start cf-ddns.timer`

## Resources Used:
 - [Cloudflare's DNS API documentation](https://developers.cloudflare.com/api/resources/dns/subresources/records/methods/scan/)
 - [Systemd timer documentation](https://documentation.suse.com/smart/systems-management/html/systemd-working-with-timers/index.html)