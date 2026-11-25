#!/bin/bash

curl -X POST "https://caixaesmhmp.service-now.com/oauth_token.do" \
 -H "Content-Type: application/x-www-form-urlencoded" \
 -H "Accept: application/json" \
 -d "client_id=ae7147c725f04ddc8969b5f68166445e" \
 -d "client_secret=z~G.!qC:eCGG.K|rie<HGcZ;G,1nWPNz" \
 -d "grant_type=urn:ietf:params:oauth:grant-type:jwt-bearer" \
 -d "assertion=HOA4TVtlIQ7esywELDeayAnmyVGu9DYFMVZ0sms6N8BtkQIg8kALEbqj3YZyBCxQuzbBfTH9RLJy_wdI2azl5w"
