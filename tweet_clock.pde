import org.joda.time.*;

//Declare Globals
int rSn; // randomSeed number. put into var so can be saved in file name. defaults to 47
final float PHI = 0.618033989;
PFont font;
Clock c;


void setup() {
  background(255);
  size(1100, 600);
  // rSn = 47;
  rSn = 29;
  // rSn = 18;
  randomSeed(rSn);
  font = createFont("Helvetica", 18);  //requires a font file in the data folder
  noLoop();

  c = new Clock();
  c.dataFileLoc = "tweets-hockeynight-apr-min.csv";
  c.loadData();
}


void draw() {
  background(255);
  c.update();
  c.render();
}


void keyPressed() {
  if (key == 'S') screenCap();
}


void mousePressed() {
}


void screenCap() {
  // save functionality in here
  String outputDir = "out/";
  String sketchName = "clock_Render_Test-";
  String randomSeedNum = "rS" + rSn + "-";
  String dateTimeStamp = "" + year() + nf(month(), 2) + nf(day(), 2) + nf(hour(), 2);
  String fileType = ".tif";
  String fileName = outputDir + sketchName + randomSeedNum + dateTimeStamp + fileType;
  save(fileName);
  println("Screen shot taken and saved to " + fileName);
}
