#!/usr/bin/perl -w
# On FreeBSD use: 
#!/usr/local/bin/perl -w


# Shell script / Perl Program - by MEG
# Special thx to Phil for the sample perl code
# 2018-03-16    1.00   First Coding.

my $VERSION="1.00";
my $appname="monit-ezalert";


# Replace the following with your EZAlert.me channel API KEY:
my $APIKEY="YY-YYYYYYYYYYYY";


# LINUX use wget, FreeBSD: use fetch
my $COMMAND="/usr/bin/wget -s -O - ";
# my $COMMAND="/usr/bin/fetch -q -o - ";


# GET MONIT DATA FROM ENV
my $mhost=$ENV{'MONIT_HOST'};
my $mevent=$ENV{'MONIT_EVENT'};
my $mact =$ENV{'MONIT_ACTION'};
my $mserv=$ENV{'MONIT_SERVICE'};
my $mdesc=$ENV{'MONIT_DESCRIPTION'};

# Build alert text
my $ALERT="Monit Alert - $mhost: $mevent $mact $mserv $mdesc";


# Test mode: set to 1 to test thing withut actually send messages
my $TEST="0";

# Build the URL url-encoding alert text
my $EAL=url_encode($ALERT); 
$URL="https://ezalert.me/v1/sendAlert?apikey=$APIKEY&text=$EAL&test=$TEST";

# Run command
$cmd="$COMMAND '$URL'";
@res=`$cmd`;

# We are done
exit(0);


#############################################################
# URL_ENCODE
#############################################################
sub url_encode {
my $rv = shift;
$rv =~ s/([^a-z\d\Q.-_~ \E])/sprintf("%%%2.2X", ord($1))/geix;
$rv =~ tr/ /+/;
return $rv;
}
 
