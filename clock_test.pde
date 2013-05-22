import processing.opengl.*;

//Declare Globals
int rSn; // randomSeed number. put into var so can be saved in file name. defaults to 47
final float PHI = 0.618033989;
PFont font;
PVector clkLoc = new PVector(300,300);
PVector clkTargLoc = new PVector(300,300);
PVector clkDiam = new PVector(300,0);
color day = color(218,229,0);
color night = color(49,13,255);

void setup() {
  background(200);
  size(600, 600);
  // rSn = 47;
   rSn = 29;
  // rSn = 18;
  randomSeed(rSn);
  // noiseDetail(8);
  font = createFont("HelveticaNeue-Bold", 28);  //requires a font file in the data folder
   // noLoop();
}

void draw() {
  background(255);
  render();
}

void render(){
  textFont(font);
  // String name = "sspboyd";
  // text(name, width-textWidth(name)-5,height-25);
// draw simple circle and add arms
noFill();
strokeWeight(.5);

float clkMaxArmLen = (width - 150 - clkDiam.x) * .5;
// ellipse(clkLoc.x, clkLoc.y, clkDiam.x, clkDiam.x);
rectMode(CORNER);
// stroke(day);
// noStroke();
fill(0);
for (int i = 0; i<12*10; i++){
  float armLen = noise(i) * clkMaxArmLen;
  pushMatrix();
  translate(clkLoc.x, clkLoc.y);
  rotate(map(i, 0, 120, 0, TWO_PI));
  translate(clkDiam.x/2+25, 0);
  rect(0,0,armLen, 2);
  popMatrix();
}

clkNumbers();

// stroke(0);
fill(150);
for (int i = 120; i<120*2; i++){
  float armLen = noise(i)*clkMaxArmLen;
  pushMatrix();
  translate(clkLoc.x, clkLoc.y);
  rotate(map(i, 0, 120, 0, TWO_PI));
    translate(clkDiam.x/2, 0);
  rect(0,0,-armLen, 2);
  popMatrix();
}


noStroke();
fill(255,150);
String filterStr = "#hockeynight";
float labelCircDiam = textWidth(filterStr) * 1.1;
ellipse(clkLoc.x,clkLoc.y,labelCircDiam,labelCircDiam);
fill(0);
pushMatrix();
translate(clkLoc.x, clkLoc.y);

text(filterStr, -textWidth(filterStr)/2,12);
popMatrix();

}


void clkNumbers(){
  fill(100);
pushMatrix();
translate(clkLoc.x-(textWidth("12")/2), clkLoc.y - clkDiam.x/2);
text("12",0,0);
popMatrix();

pushMatrix();
translate(clkLoc.x + (textWidth("3")*.25) + (clkDiam.x/2), clkLoc.y+12);
text("3",0,0);
popMatrix();

pushMatrix();
translate(clkLoc.x-(textWidth("6")/2), clkLoc.y + clkDiam.x/2+24);
text("6",0,0);
popMatrix();

pushMatrix();
translate(clkLoc.x - (textWidth("9")*1.25) - (clkDiam.x/2), clkLoc.y+12);
text("9",0,0);
popMatrix();
}












void keyPressed() {
  if (key == 'S') screenCap();
}

void mousePressed(){
clkLoc.x = mouseX;
clkLoc.y= mouseY;
render();
}

void screenCap() {
  // save functionality in here
  String outputDir = "out/";
  String sketchName = "clock_test-";
  String randomSeedNum = "rS" + rSn + "-";
  String dateTime = "" + year() + nf(month(),2) + nf(day(),2) + nf(hour(),2) + nf(minute(),2) + nf(second(),2);
  String fileType = ".tif";
  String fileName = outputDir + sketchName + randomSeedNum + dateTime + fileType;
  save(fileName);
  println("Screen shot taken and saved to " + fileName);
}
