
class SentientReceiver extends Thread
{
  String ip;
  String session = "galtest2";
  String measure = "Sound";
  String entity = "J-Room";
  boolean isRunning;
  String currentEmotion;
  
  public SentientReceiver(String ip, String session)
  {
    this.ip = ip;
    this.session = session;
    currentEmotion = "none";
  }
  
  public void run()
  {
    isRunning = true;
    
    while (isRunning)
    {
      if (fakeEmotion) {
        currentEmotion = "Nervous";
      }
      else {
        currentEmotion = requestLastEmotion();
      }
      
      try {
        Thread.sleep(5000);
      }
      catch (Exception e) {}
    }
  }
  
  public String getCurrentEmotion() 
  {
    return currentEmotion;
  }
  
  private String requestLastEmotion()
  {
    long time = System.currentTimeMillis()-20000;
    JSONObject json = loadJSONObject("http://"+ip+":3000/SessionResult/?"+
      "session="+session+
      "&measure="+measure+
      "&entity="+entity+
      "&starttime="+time+
      "&resolution=0");
    
    JSONArray responseArray = json.getJSONArray("entityResponse");
    JSONObject lastUpdate = responseArray.getJSONObject(responseArray.size()-1);
    
    // last update looks like this
    //{
    //  "position": "SLIGHTLY BELOW",
    //  "reaction": "Slightly Below Steady",
    //  "pace": "SLOW",
    //  "time": 1385312666910,
    //  "trend": "STEADY",
    //  "runVal": 0.03412109749960379,
    //  "lastUpdate": 1,
    //  "direction": -30.034121097499604,
    //  "emotion": "Bored"
    //}
    String emotion = lastUpdate.getString("emotion");
    println("last emotion: " + emotion);
    
    return emotion;
  }
  
}
