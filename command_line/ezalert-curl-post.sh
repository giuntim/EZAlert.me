#!/bin/bash

# Replace YY-YYYYYYYYYYYY with your channel API Key
# Remember: text parameter must be urlencoded 
# (or at least do not use : & ? = / + and replace spaces with + )
curl -s "https://ezalert.me/v1/sendAlert" -d "apikey=YY-YYYYYYYYYYYY" -d "text=Huston,+we+have+a+problem!"

