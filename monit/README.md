# Monit Script to send alerts via EZAlert.me

`monit-ezalert.pl` script allows monit to use EZAlert.me service to send alerts via Istant Messages like Telegram, Skype and Facebook Messenger.

**How to setup things:**

1. Copy `monit-ezalert.pl` script somewhere on your server, let's say in `/opt/ezalert`
1. Edit the script replacing API Key variable with the actual API Key of your EZAlert.me channel and fixing it for your environment
1. Add exec commands in `monitrc` file. Usually you want to replace all the `then alert` statements in your monitrc file to `then exec "/usr/bin/perl /opt/ezalert/monit-ezalert.pl"` as in the following sample:

```
check host db.local with address 10.0.0.1
 if failed port 3306 protocol mysql with timeout 15 seconds then exec "/usr/bin/perl /opt/ezalert/monit-ezalert.pl"
 else if succeeded then exec "/usr/bin/perl /opt/ezalert/monit-ezalert.pl"
```


- Get more info about Monit at: https://mmonit.com/monit/
- Get more info about EZAlert.me at: https://ezalert.me

