//Declare Globals
int rSn; // randomSeed number. put into var so can be saved in file name. defaults to 47
final float PHI = 0.618033989;
PFont font;

Clock c;


void setup() {
  background(255);
  size(600, 600);
  // rSn = 47;
  rSn = 29;
  // rSn = 18;
  randomSeed(rSn);
  font = createFont("Helvetica", 18);  //requires a font file in the data folder
  noLoop();

  c = new Clock();
  c.dataFileLoc = "tweets-hockeynight-apr-min.csv";
  c.loadData();
  c.update();
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
  String dateTime = "" + year() + month() + day() + hour() + minute() + second();
  String fileType = ".tif";
  String fileName = outputDir + sketchName + randomSeedNum + dateTime + fileType;
  save(fileName);
  println("Screen shot taken and saved to " + fileName);
}
