<?php
/**

    https://ezalert.me
    


**/

$apikey='YY-YYYYYYYYYYY'; // Your EZAlert.me channel API Key
$text='Huston, we have a problem!';
$test=false; // Test mode: use 1 to check API call without actually send the alert
$apiurl='https://ezalert.me/v1/sendAlert'; // API Endpoint

// Let's build param string
$call='apikey='.$apikey.'&text='.urlencode($text);
if($test) { // Enable test mode
    $call.='&test=1';
}

                                                                                                                     
$ch = curl_init($apiurl);                                                                      
curl_setopt($ch, CURLOPT_CUSTOMREQUEST, 'POST');                                                                     
curl_setopt($ch, CURLOPT_POSTFIELDS, $call);                                                                  
curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);                                                                      
curl_setopt($ch, CURLOPT_HTTPHEADER, array(                                                                          
    'Content-Length: ' . strlen($call))                                 
);                                                                                                                   
                                                                                                                     
$result = curl_exec($ch);
curl_close($ch);


echo "EZALert.me reply: $result\n";


?>
