class Clock {
  //Clock vars
  String dataFileLoc;

  int maxTwCount;
  float maxBarHeight;
  float barWidth;
  int tIntvl; // time interval is x mins
  int tScale; // time scale, eg 1 min * mins / hr * hrs / day
  int innerMargin, outerMargin;
  String renderType;

  HashMap<String, ArrayList<String>> tweetsByMin;


  Clock() {
    barWidth = 3;
    tIntvl = 10; 
    tScale = 1 * 60 * 24; // 1 min * mins / hr * hrs / day
    innerMargin = 10;
    outerMargin = 5;
    renderType = "line";
  }

  void loadData() {
    /* get the data...
    tweet_id  created_at
    318576422715273216  2013-04-01 00:11:52
    */

    Table dataTable = loadTable(dataFileLoc, "header, tsv");
    tweetsByMin  = new HashMap<String, ArrayList<String>>();

    int y,mon,d,h,m,s; // used to parse out date string
    String mod; // mod is 'minute of day' as a string bc I'm using it as a HashMap key

    for (TableRow row : dataTable.rows()) {
      String dateStr = row.getString("created_at");
      String tid = row.getString("tweet_id");

      y =   int(dateStr.substring(0,4));
      mon = int(dateStr.substring(5,7));
      d =   int(dateStr.substring(8,10));
      h =   int(dateStr.substring(11,13));
      m =   int(dateStr.substring(14,16));
      s =   int(dateStr.substring(17,19));
      
      DateTime dt = new DateTime(y, mon, d, h, m, s);
      mod = dt.minuteOfDay().getAsText();

      if(tweetsByMin.containsKey(mod)){
        /* not sure how to correctly add to the arraylist here
        two possible ways listed below 
        */
        /* ArrayList<String> tweet_ids = tweetsByMin.get(mod);
        tweet_ids.add(row.getString("tweet_id"));
        */
        tweetsByMin.get(mod).add(tid);
        // println(mod + ": " + tweetsByMin.get(mod).size() + " " + tweetsByMin.get(mod));

      } else{
        ArrayList<String> tweet_ids = new ArrayList<String>();
        tweet_ids.add(tid);
        tweetsByMin.put(mod, tweet_ids);
      }
    }
  }


  void update() {
    // set size and location variables
    //maxBarHeight = getMaxBarHeight()/1.75;
    maxTwCount = getmaxTwCount();
    maxBarHeight = getMaxBarHeight();

    println("maxBarHeight, maxTwCount: " + maxBarHeight + ", " + maxTwCount);
  }


  void render() {
    // display data
if(renderType == "line"){
    for (int i=0; i < tScale; i += tIntvl) {
      float x = map(i, 0, tScale, 0, width);
      float y = height/2;
      // float barWidth = 2;
      // float maxBarHeight = height/2;

      pushMatrix();
      fill(0);
      noStroke();

      int twIntvlCount = getTweetCount(i);
      // println("twIntvlCount, maxTwCount: " + twIntvlCount+", "+maxTwCount);
      float barHeight = map(twIntvlCount, 0, maxTwCount, 1, maxBarHeight);
      println(twIntvlCount + ", " + maxTwCount + ", " + maxBarHeight);
      // println("barHeight, maxBarHeight: " + barHeight + ", " + maxBarHeight);
      rect(x, y, barWidth, -barHeight);

      popMatrix();
}
}

if(renderType == "spiral"){
    for (int i=0; i < tScale; i += tIntvl) {
      pushMatrix();
      translate(width/2, height/2);
      float rot = map(i, 0, tScale, 0, TWO_PI*2);
      float rad = map(i, 0, tScale, innerMargin, (maxBarHeight+outerMargin)*3-maxBarHeight); // this isn't right yet
      rotate(rot-HALF_PI);
      float clr = map(i, 0, tScale, 225, 0);
      clr = 47;

      fill(clr);
      noStroke();

      int twIntvlCount = getTweetCount(i);
      println("twIntvlCount: " + twIntvlCount);
      float barHeight = map(twIntvlCount, 0, maxTwCount, 1, maxBarHeight);
      rect(rad, barWidth, barHeight, barWidth);
      popMatrix();

      fill(0);
      textFont(font);
      text("AM", width/2 - 35, height/2-5);
      text("PM", width/2 + 5, 96);

      println("mod: twIntvlCount = " + i + ": " + twIntvlCount);
    }
  }
  }


  float getMaxBarHeight(){
     // figure out max height of a line based on contraints of the 'pane' the clock sits in
    // int currMaxBH = ((width/2) - innerMargin - (3 * outerMargin)) / 3;
    float currMaxBH = height/2.0;
    // println("base width calc: " + ((width/2) - innerMargin - (3 * outerMargin)));
    // println(currMaxBH);
    return currMaxBH;
  }

    
  /*
  write out the results of 
  getBarHeight to a Data object 
  or is this premature optimization?
  */

  int getmaxTwCount(){ 
    // get the max number of tweets in a minute 'bucket'
    int currMaxTC = 0;
        for (int i=0; i < tScale; i += tIntvl) {
          int twIntvlCount = getTweetCount(i);
          if(twIntvlCount > currMaxTC) currMaxTC = twIntvlCount;
        }
    return currMaxTC;
  }

  int getTweetCount(int m) {
    int tCount = 0;
    for (int i = m; i < (m + tIntvl); i++) { // loop through each minute in the interval
      String si = str(i);
      if(tweetsByMin.containsKey(si)){
        tCount += tweetsByMin.get(si).size(); 
        // gets the array list length/size
      }
    }
    println("m: tCount = " + m + ", " + tCount);
    return tCount;
  }

}
