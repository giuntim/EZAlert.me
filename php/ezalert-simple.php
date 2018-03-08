<?php
/**

    https://ezalert.me
    


**/

$apikey='YY-YYYYYYYYYYY'; // Your EZAlert.me API Key
$text='Huston, we have a problem!';
$test=false; // Test mode: use 1 to check API call without actually send the alert
$apiurl='https://ezalert.me/v1/sendAlert'; // API Endpoint

// Let's build a GET API call
$call=$apiurl.'?apikey='.$apikey.'&text='.urlencode($text);
if($test) { // Enable test mode
    $call.='&test=1';
}

$rc=file_get_contents($call);
echo "EZALert.me reply: $rc\n";


?>
