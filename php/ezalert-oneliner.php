<?php
/**

    https://ezalert.me
    


**/

// Replace YY-YYYYYYYYYYYY with your API key
echo file_get_contents('https://ezalert.me/v1/sendAlert?apikey=YY-YYYYYYYYYYYY&text='.urlencode('Huston, we have a problem!'));
echo "\n";


?>
