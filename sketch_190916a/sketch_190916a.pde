// beats per minute of the song
int bpm;
int time = millis();

// a class representing squares that 
class beatSquare {
  color c;
  float x;
  float y;
  int len;
  int wid;
  
   beatSquare(color colorC, float Xpos, float Ypos, int lengt, int widt) {
   }
}

void setup() {
  fullScreen();
  background(102);
}

void draw() {
  fill(255);
  
  int passedMillis = millis() - time;
  if(passedMillis >= 215) {
    time = millis();
    fill(255, 0,0);
  }
  
  rect(50,50,50,50);
  
  fill(255);
  ellipse(150,150,50,50);
  fill(255, 0,0);
  arc(150,150,50,50, 0, TWO_PI / 215.0 * passedMillis, PIE);
}
