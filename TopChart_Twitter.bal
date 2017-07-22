import ballerina.lang.messages;
import ballerina.lang.strings;
import ballerina.lang.system;
import ballerina.lang.xmls;
import ballerina.net.http;
import ballerina.net.uri;
import ballerina.utils;
function main(string[] args) {
    http:ClientConnector tweeterEP = create http:ClientConnector("https://api.twitter.com");
    http:ClientConnector mediumEP = create http:ClientConnector("http://www.billboard.com");
        string consumerKey="GC96MT67rqPfnHDNfmYNKWFoU";
        string consumerSecret = "fLBnfLAMPXCDyrYhE97oQQXOnz8EhLjClIAgMMsga9gP0zAD7M";
        string accessToken = "fLBnfLAMPXCDyrYhE97oQQXOnz8EhLjClIAgMMsga9gP0zAD7M";
        string accessTokenSecret = "ZA74fNv0JarDoIwNl4XJ3sGfstSjJyPWlNrpCX88XsEY2";
        
        
        message request = {};
        message mediumResponse = http:ClientConnector.get(mediumEP, "/biz/rss.xml", request);
        xml feedXML = messages:getXmlPayload(mediumResponse);
        string title = xmls:getString(feedXML, "/rss/channel/item[1]/title/text()");
        //string title ="A";
        string oauthHeader = constructOAuthHeader(consumerKey, consumerSecret, accessToken, accessTokenSecret, title);
        messages:setHeader(request, "Authorization", oauthHeader);
        string tweetPath = "/1.1/statuses/update.json?status=" + uri:encode(title);
        message response = http:ClientConnector.post(tweeterEP, tweetPath, request);
        system:println("Successfully tweeted: '" + title + "'");
      
        
         http:ClientConnector tweeterEP1 = create http:ClientConnector("http://ws.audioscrobbler.com/2.0/");

      
        string authKey = "a91d28076d3151e761f5ae52d143c51d";
        string tweetPath1 = "?method=chart.gettoptracks&api_key="+authKey+"&format=json";
        message request1 = {};
     
        message response1 = http:ClientConnector.post(tweeterEP1, tweetPath1, request1);
          json jsonRequest = messages:getJsonPayload(response1);
          // system:println(jsonRequest.tracks.track[0].name);
         // string respoentract= getStringValue(message response, string tracks{tract}) (string ) ;
        system:println("' Top chart of last.fm '");
       int i=0;
          while (i<50) {
              
               system:println(jsonRequest.tracks.track[i].name);
              i=i+1;
          }
        int y=0;
        int xx=1;
        system:println("Top chart of last.fm -Top 3 ");
        while(y<3){
               var songtweet1,_=(string)jsonRequest.tracks.track[y].name;
               var songtweet2,_=(string)jsonRequest.tracks.track[y].playcount;
               var songtweet3,_=(string)jsonRequest.tracks.track[y].listeners;
               var songtweet="No :"+ xx + " Song Name:"+songtweet1+"   Playcount:"+songtweet2+"  Listeners:"+songtweet3;
               //jsonRequest.tracks.track[y].playcount+" "+jsonRequest.tracks.track[y].listeners);
            //  string songtweet= (string)songtweetAA;
            string oauthHeader1 = constructOAuthHeader(consumerKey, consumerSecret, accessToken, accessTokenSecret, songtweet);
            messages:setHeader(request, "Authorization", oauthHeader1);
             message request2 = {};
           string tweetPath2 = "/1.1/statuses/update.json?status=" + uri:encode(songtweet);
           message response2 = http:ClientConnector.post(tweeterEP, tweetPath2, request2);
           system:println("Successfully tweeted: '" + songtweet + "'");
           y=y+1;
           xx=xx+1;
        }
    
}

function constructOAuthHeader(string consumerKey, string consumerSecret, string accessToken, string accessTokenSecret, string tweetMessage)(string ) {
    string timeStamp = strings:valueOf(system:epochTime());
    string nonceString = utils:getRandomString();
    string paramStr = "oauth_consumer_key=" + consumerKey + "&oauth_nonce=" + nonceString + "&oauth_signature_method=HMAC-SHA1&oauth_timestamp=" + timeStamp + "&oauth_token=" + accessToken + "&oauth_version=1.0&status=" + uri:encode(tweetMessage);
    string baseString = "POST&" + uri:encode("https://api.twitter.com/1.1/statuses/update.json") + "&" + uri:encode(paramStr);
    string keyStr = uri:encode(consumerSecret) + "&" + uri:encode(accessTokenSecret);
    string signature = utils:getHmac(baseString, keyStr, "SHA1");
    string oauthHeader = "OAuth oauth_consumer_key=\"" + consumerKey + "\",oauth_signature_method=\"HMAC-SHA1\",oauth_timestamp=\"" + timeStamp + "\",oauth_nonce=\"" + nonceString + "\",oauth_version=\"1.0\",oauth_signature=\"" + uri:encode(signature) + "\",oauth_token=\"" + uri:encode(accessToken) + "\"";
    return strings:unescape(oauthHeader);
    
}
