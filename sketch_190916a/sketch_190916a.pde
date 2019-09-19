// beats per minute of the song
double BPM = 60.0;

// colors for the squares
color pulseColor; 
color tonic_color;
color supertonic_color;
color mediant_color; 
color subdominant_color;
color dominant_color;
color submediant_color;
color leading_tone_color;

// converts the given BPM into a format we can use for lerpColor
// 60 --> 500
// 120 --> 250
double convertBPM(double bpm) {
    return (60.0/bpm) * 500.0;
}

// a class representing squares that pulse at  the BPM
class beatSquares {
  color c;
  int bpm;
  
  // constructor
  beatSquares(color colorC) {
     c = colorC;
     
     // convert the bpm into a format we can use
     bpm = (int) (convertBPM(BPM));
  }
  
  void flash() {
     /* determines often we will "flash" the beat, switching between white and the color
     * taken from this thread:
     * https://forum.processing.org/two/discussion/20861/change-between-colors-over-time */
     fill(lerpColor(255, c, ((millis()/bpm)%2==0)?millis():bpm-millis()));
  }
  
  // draw our rectangles in the appropriate areas
  void draw_rec() {
    
     // Wall 1: xratio= 0.0, yratio= 0.7462963, len= 29, wid=43
     rect(width*0, height*0.7462963, 29, 43);
     
     // Wall 2: xratio= 0.122395836, yratio= 0.7712963, len= 29, wid=43
     rect(width*0.122395836, height*0.7712963, 29, 43);
     
     // Wall 3: xratio= 0.35364583, yratio= 0.7425926, len= 29, wid=44
     rect(width*0.35364583, height*0.7425926, 29, 44);
     
     // Wall 4: xratio= 0.66041666, yratio= 0.0, len= 635, wid=651
     rect(width*0.66041666,  height*0, 365, 651);
  }
}

class noteSquare {
  
  color c;
  int bpm;
  
  float Xpos1;
  float Ypos1;
  int len1;
  int wid1;
  
  float Xpos2;
  float Ypos2;
  int len2;
  int wid2;
  
  float Xpos3;
  float Ypos3;
  int len3;
  int wid3;
  
  noteSquare(color colorC) {
    c = colorC;
    bpm = (int) convertBPM(BPM);
  }
  
  // draws the sqaures in the given areas
  void draw_rec() {
    rect(Xpos1, Ypos1, len1, wid1);
    rect(Xpos2, Ypos2, len2, wid2);
    rect(Xpos3, Ypos3, len3, wid3);
  }
  
  /* flashes a note for the specified duration
  * 1 == whole note
  * 2 == half
  * 4 == quarter
  * 8 == eigth
  */
  void flash(int note) {
    
    int conv_bpm = 1;
    
    // convert bpm based on the note
    if (note == 1) {
      conv_bpm = bpm * 4;
    }
    else if (note == 2) {
      conv_bpm = bpm * 2;
    }
    else if (note == 4) {
      conv_bpm = bpm;
    }
    else if (note == 8) {
      conv_bpm = bpm/2;
    }
    
    
    fill(lerpColor(255, c, ((millis()/conv_bpm)%2==0)?millis():conv_bpm-millis()));
  }
  
  
}

// square to declare
beatSquares pulse; // the main beat for the song
noteSquare tonic; // note # 1 (i.e. C for the C major scale)
noteSquare supertonic; // note # 2
noteSquare mediant; // note # 3
noteSquare subdominant; // note # 4
noteSquare dominant; // note # 5
noteSquare submediant; // note # 6
noteSquare leading_tone; // note # 7 

void setup() {
  fullScreen();
  background(255);
  pulseColor = color(255, 0, 0);
  pulse = new beatSquares(pulseColor);
  tonic = new noteSquare(0);
  supertonic = new noteSquare(0);
  mediant = new noteSquare(0);
  subdominant = new noteSquare(0);
  dominant = new noteSquare(0);
  submediant = new noteSquare(0);
  leading_tone = new noteSquare(0);
}

void draw() {
  
  // set up the pulsing squares
  pulse.flash();
  pulse.draw_rec();
  
  // set up the tonic square
  tonic.flash(8);
  
  // Wall #1: xratio= 0.06302083, yratio= 0.7972222, len= 29, wid=43
  tonic.draw_rec(width*0.06302083, height*0.7972222, 29, 43);
  
  // Wall # 2: xratio= 0.17916666, yratio= 0.7972222, len= 29, wid=44
  tonic.draw_rec(width*0.17916666, height*0.7972222, 29, 44);
   
  // Wall # 3: xratio= 0.3875, yratio= 0.7962963, len= 29, wid=44
  tonic.draw_rec(width*0.3875, height*0.7962963, 29, 44);
}
