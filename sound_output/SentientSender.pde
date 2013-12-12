
class SentientSender
{
  String ip;
  String sessionName;

  boolean sessionStarted = false;
  
  ArrayList<SoundData> windowData;
  long windowStart;
  long windowLength;
  
  public SentientSender(String ip, long windowLength)
  {
    this.ip = ip;
    this.windowLength = windowLength;
  }
  
  public boolean startSession(String session)
  {
    sessionName = session;
    // post new session
    sessionStarted = 
      sendPost("Session/", "{ \"name\": \""+sessionName+"\" }");
    
    windowData = new ArrayList<SoundData>();
    
    return sessionStarted;
  }
  
  public boolean addNewData(int val)
  {
    if (!sessionStarted) {
      return false;
    }
    
    long time = System.currentTimeMillis();
    
    if (windowData.size() == 0) {
      windowStart = time;
    }
    windowData.add(new SoundData(time, val));
    
    if (time-windowStart > windowLength) {
      SoundData averageData = getWindowAverage();
      // post the average
      sendPost("Session/"+sessionName+"/Update", averageData.toJson());
      
      // clear the window
      windowData = new ArrayList<SoundData>();
    }
    
    return true;
  }
  
  private SoundData getWindowAverage()
  {
    long time=0;
    int value=0;
    
    for (SoundData sd : windowData)
    {
      time += sd.timeMS;
      value += sd.value;
    }
    time /= windowData.size();
    value /= windowData.size();
    
    return new SoundData(time, value);
  }
  
  private boolean sendPost(String urlPath, String data)
  {
    boolean success = true;
    StringBuilder response = new StringBuilder();

    HttpURLConnection conn = null;
    try {
      URL url = new URL("http://"+ip+":3000/"+urlPath);
      conn = (HttpURLConnection)url.openConnection();
      try {
        conn.setRequestMethod("POST");
        conn.setDoOutput(true);
        conn.setDoInput(true);
        conn.setUseCaches(false);
        conn.setAllowUserInteraction(false);
        conn.setRequestProperty("Content-Type", "application/json");
      }
      catch (Exception e) {
        println("exception with connection: " + e.toString());
        success = false;
      }
      
      // output data
      OutputStream out = conn.getOutputStream();
      OutputStreamWriter writer = null;
      try {
        writer = new OutputStreamWriter(out);
        writer.write(data);
      }
      catch (Exception e) {
        println("exception with sending: " + e.toString());
        success = false;
      }
      finally {
        if (writer != null) {
          writer.close();
        }
      }
      
      // read server response
      InputStream in = conn.getInputStream();
      BufferedReader reader = null;
      try {
        reader = new BufferedReader(new InputStreamReader(in));
        String responseLine = null;
        while ((responseLine = reader.readLine()) != null)
        {
          response.append(responseLine);
        }
      }
      catch (Exception e)
      {
        println("exception with reading: " + e.toString());
        success = false;
      }
      finally {
        if (reader != null) {
          reader.close();
        }
      }
    }
    catch (Exception e) {
      println("general exception: " + e.toString());
      success = false;
    }
    finally {
      if (conn != null) {
        conn.disconnect();
      }
    }
    
//    println(response.toString());
    return success;
  }
}
