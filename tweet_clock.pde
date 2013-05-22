//Declare Globals
int rSn; // randomSeed number. put into var so can be saved in file name. defaults to 47
final float PHI = 0.618033989;
PFont font;
 
void setup() {
  background(255);
  size(600, 600);
  rSn = 47;
  // rSn = 29;
  // rSn = 18;
  randomSeed(rSn);
  font = createFont("Helvetica", 18);  //requires a font file in the data folder
  noLoop();
}
 
void draw() {
  background(255);
  fill(0);
  textFont(font);
//  text("sspboyd", 10,100);

int tIntvl = 10; // time interval is 10 mins
int tScale = 1 * 60 * 24; // 1 min * mins / hr * hrs / day

for(int i=0; i < tScale; i += tIntvl){
  pushMatrix();
    translate(width/2, height/2);
    float rot = map(i, 0, tScale, 0, TWO_PI*2);
    float rad = map(i, 0, tScale, 200, 100);
    rotate(rot-HALF_PI);
    float clr = map(i, 0 , tScale, 255, 0);
    fill(clr);
    // stroke(0.5);
    if(i<tScale*.5){
      rect(rad-50, 0, 50, 5);
    }else{
      rect(rad, 0, -50, 5);
    }
  popMatrix();

fill(0);
text("AM", width/2-35, 115);
text("PM", width/2 +5, 250);
}


}
 
void keyPressed() {
  if (key == 'S') screenCap();
}
 
void mousePressed(){}
 
void screenCap() {
  // save functionality in here
  String outputDir = "out/";
  String sketchName = "template-";
  String randomSeedNum = "rS" + rSn + "-";
  String dateTime = "" + year() + month() + day() + hour() + minute() + second();
  String fileType = ".tif";
  String fileName = outputDir + sketchName + randomSeedNum + dateTime + fileType;
  save(fileName);
  println("Screen shot taken and saved to " + fileName);
}