#!/usr/bin/perl

# Shell script / Perl Program - made by Phil
# 11/03/2018    1.00    (yesterday Ralf Waldmann died) First Coding.
# 13/03/2018    1.10    added url_encode and trimmed leading blanks.
# 14/03/2018    1.20    added retry on CURL failure.

my $VERSION="1.20";
my $appname="ezalertator";

use strict;
use Getopt::Std;
use Sys::Hostname;
use Data::Dumper qw(Dumper); 
#use URL::Encode;

#############################################################
# Define the ENVIRONMENT
#############################################################
#our $ENV="TEST";
our $ENV="PROD";

#############################################################
# Initializing variables
#############################################################
my $USAGE="Usage: $appname [-t -k key-string] (-h for more help)";
my $BANNER="[$appname ver $VERSION  by Phil (-h for parameters)]";

#
# switches
#
my $gok=0;
my %options;
my $ftest=0;
my $fkey=0;
my $keystring="";
my $fmsg=0;
my $msgstring="";

#
# variables
#
my $logfile=">>/tmp/ezalertator.log";
my $dt = "";
my $i=0;
my $ipu=1;
my @res = 0;

#############################################################
# Environment parametrization
#############################################################
if ($ENV eq "TEST") {
    print "TEST Env\n";
    $logfile=">>./tmp/ezalertator.log";
} elsif ($ENV eq "PROD") {
    $logfile=">>/var/log/zabbix/ezalertator.log";
} else {
    print "Non conosco questo environment($ENV)\nExiting...\n";
    exit(1);
}


#############################################################
# Retrieving switches
#############################################################
if ( $#ARGV < 0)
{   # No switches passed. Assume video print
    $ftest=0;
} else
{
    %options=();
    $gok=getopts("tk:x:h",\%options);
    $ftest=1 if defined $options{t};
    $fkey=1 if defined $options{k};
    $keystring=$options{k} if defined $options{k};
    $fmsg=1 if defined $options{x};
    $msgstring=$options{x} if defined $options{x};
    Help() if defined $options{h};
    if (! $gok )
    {
        print "$USAGE\n";
        exit(1);
    }
}

#############################################################
# Printout Banner only if invoked without MAIL switch
#############################################################
Banner($BANNER) if($ftest);


#############################################################
# send alert and log action
#############################################################

$keystring =~ s/^\s+//;
$msgstring =~ s/^\s+//;

PrintIT("START of alert");

PrintIT("ORIGINAL  : curl \"https://ezalert.me/v1/sendAlert?\" -d \"apikey=$keystring\" -D \"text=$msgstring\"");
$msgstring = url_encode($msgstring);

PrintIT("URLENCODED: curl \"https://ezalert.me/v1/sendAlert?\" -d \"apikey=$keystring\" -D \"text=$msgstring\"");

while(1 eq 1) {

    PrintIT("Attempt no. $ipu");

    @res=`curl "https://ezalert.me/v1/sendAlert?" -d "apikey=$keystring" -d "text=$msgstring"`;

    PrintIT(@res);

    if($res[0] =~ /OK/) {
        PrintIT("Success! Alert sent.");
        last;
    };

    PrintIT("FAILURE! Try again.");

    $i++; $ipu++;

    if($i eq 3) {
        PrintIT("Give up. Too many errors.");
        exit 1;
    }
}

PrintIT("END of alert");

##################################################################
# GO and do it!
##################################################################

exit (0);


#############################################################
#                       Functions
#############################################################

#############################################################
# PRINTIT print log message
#############################################################
sub PrintIT
{
    open(DATA, $logfile) or DieNice("Couldn't open file \"$logfile\", $!");

    $dt = `date "+%b %d %Y %H:%M%S"`;
    chomp($dt);
    print DATA "$dt @_\n";

    close(DATA) or DieNIce("Couldn't close file properly");
}

#############################################################
# BANNER Print out
#############################################################
sub Banner
{
    print "\n@_\n\n";
}


#############################################################
# Die in a nice way (??)
#############################################################
sub DieNice
{
    my($msg) = @_;
    print "Error ",$msg,"\n";
    exit(1);
}


#############################################################
# Print out help details
#############################################################
sub Help
{
    print "Generate digest of blocked mail.\n";
    print "\t-t :\tTest only and not send files\n";
    print "\t-k :\tKEY String of telegram channel\n";
    print "\t-x :\tMSG to send\n";
    print "\t-h :\tThis help\n";
    exit(0);
}


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
