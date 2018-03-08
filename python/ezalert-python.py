# https://ezalert.me

import requests


# apikey: your channel API Key
# text: alarm text
# test: use 1 to check API call without actually send the alert

params=(('apikey','YY-YYYYYYYYYYYY'), ('text','Huston, we have a problem!'), ('test',0))
rc=requests.get('https://ezalert.me/v1/sendAlert', params)
print(rc.text)

