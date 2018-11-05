
/**

    https://ezalert.me
    

**/


import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;

class EZAlertMeTest {
    
 public static void main(String[] args)  {
     
  try {
    // Put here your real API key:
    String apiKey="YY-YYYYYYYYYYYY"; 
    
    // Alert text:
    String alert="This is my alert";
    
      
    // Send alert via EZALert.me Rest API    
    URL url = new URL("https://ezalert.me/v1/sendAlert?apikey="+apiKey+"&text="+java.net.URLEncoder.encode(alert,"UTF-8"));       
    BufferedReader reader = null;
    StringBuilder stringBuilder;

    // create the HttpURLConnection    
    HttpURLConnection connection = (HttpURLConnection) url.openConnection();
      
    // just want to do an HTTP GET here
    connection.setRequestMethod("GET");

     
    // give it 15 seconds to respond
    connection.setReadTimeout(15*1000);

    // Connect
    connection.connect();

    // read the output from the server
    reader = new BufferedReader(new InputStreamReader(connection.getInputStream()));
    stringBuilder = new StringBuilder();

      String line = null;
      while ((line = reader.readLine()) != null)
      {
        stringBuilder.append(line + "\n");
      }
       System.out.println( stringBuilder.toString() );
      
      reader.close();
    }
    catch(Exception e) {
        // Handle here connection error
        e.printStackTrace();
    }
      
 }
 
}

