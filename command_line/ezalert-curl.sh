#!/bin/bash

# Replace YY-YYYYYYYYYYYY with your channel API Key
# Remember: text parameter must be urlencoded 
# (or at least do not use : & ? = / + and replace spaces with + )
curl "https://ezalert.me/v1/sendAlert?apikey=YY-YYYYYYYYYYYY&text=Huston,+we+have+a+problem!"

