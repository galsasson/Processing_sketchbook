
class SoundData
{
  long timeMS;
  int value;
  
  public SoundData(long t, int v)
  {
    timeMS = t;
    value = v;
  }
  
  public String toJson()
  {
    return "{ \"updates\" : [ { "+
      "\"measureName\": \"Sound\", "+
      "\"value\": "+value+", "+
      "\"timeStamp\" : "+timeMS+", "+
      " \"description\" : \"d\" } ] }";
  }
}
