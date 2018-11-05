#!/bin/sh

# Replace with your EZAlert.me api key:
APIKEY='YY-YYYYYYYYYY'

# URLENCODE parameter
str="${1}"
slen="${#str}"
out=''
i=1
while [ "${i}" -le "${slen}" ]; do
c=$(expr substr "$str" "$i" 1)
#echo "c: ${c}"
cc=$(printf '%%%02X' \'${c})
case "${c}" in
	[a-zA-Z0-9.~_-]) out="${out}${c}" ;;
            ' ') out="${out}+";;
            *) out="${out}${cc}"  ;;
        esac
	i=$((${i} + 1))
done

# EZALert.me call
wget -q -O - "https://ezalert.me/v1/sendAlert?apikey=${APIKEY}&text=${out}"

# Done
