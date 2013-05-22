Clock {
  //Clock vars

  String dataFileLoc;
  Table dataTable;
  int maxTwCount;
  float maxBarHeight;
  int tIntvl = 5; 
  // time interval is x mins

  int tScale = 1 * 60 * 24; // 1 min * mins / hr * hrs / day
  // create array to hold tweet count for each minute
  // 
  int minutesPerDay = 1 * 60 * 24;

  // ArrayList[] tweetsByMin = new ArrayList<String>();

  HashMap<String, ArrayList<String>> tweetsByMin  = new HashMap<String, ArrayList<String>>();


  Clock() {
  }

  void loadData() {

    // get the data...

    dataTable = loadTable(dataFileLoc, "header, tsv");

    DateFormat df;
    df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss"); 
    // double check the date format rules here

    Date date = new Date();  


    for (TableRow row : table.rows()) {
      String dateStr = row.getString("created_at");
      date = df.parse(dateStr);
      int minuteOfDay = (HOUR * 60) + MINUTE;
      tweetsByMin[minuteOfDay].add(row.getString("tweet_id"));
    }
  }


  void update() {

    // set size and location variables
  }

  void render() {

    // display data

    fill(0);
    textFont(font);

    //  text("sspboyd", 10,100);


    for (int i=0; i < tScale; i += tIntvl) {
      pushMatrix();
      translate(width/2, height/2);
      float rot = map(i, 0, tScale, 0, TWO_PI*2);
      float rad = map(i, 0, tScale, 100, 300);
      rotate(rot-HALF_PI);
      float clr = map(i, 0, tScale, 225, 0);
      fill(clr);

      // fill(0);

      noStroke();
      //    
      if (i<tScale*.5) {
        int twIntvlCount = getTweetCount(i);
        float barHeight = map(twIntvlCount, 0, maxBarHeight, 1, maxTwCount);
        rect(rad-100, 0, noise(i)*75+25, 3);
        //
      }
      else {
        //      
        rect(rad, 0, -100*noise(i), 7);
        //
      }
      popMatrix();

      fill(0);
      text("AM", width/2 - 35, height/2-5);

      text("PM", width/2 + 5, 96);
    }
  }


  int getTweetCount(int m) {
    int tCount = 0;
    for (int i = m; i < m + tIntvl; i++) {
      tCount += tweetsByMin[i].size(); 
      // gets the array list length/size
    }
    return tCount;
  }
}
