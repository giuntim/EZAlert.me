#!/usr/bin/perl

#
# https://ezalert.me
#

use strict;

# Replace the following with your param
my $apikey="yy-yyyyyyyyyyy";
my $msgstring="Huston, we have a problem!";


############################################################
my @res;
my $text=url_encode($msgstring);
@res=`curl -s "https://ezalert.me/v1/sendAlert?" -d "apikey=$apikey" -d "text=$text"`;

print @res;

#############################################################
# URL_ENCODE
#############################################################
sub url_encode {
my $rv = shift;
$rv =~ s/([^a-z\d\Q.-_~ \E])/sprintf("%%%2.2X", ord($1))/geix;
$rv =~ tr/ /+/;
return $rv;
}


#############################################################
# URL_DECODE
#############################################################
sub url_decode {
my $rv = shift;
$rv =~ tr/+/ /;
$rv =~ s/\%([a-f\d]{2})/ pack 'C', hex $1 /geix;
return $rv;
}
