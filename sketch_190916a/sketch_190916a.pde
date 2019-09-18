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
  
  noteSquare(color colorC) {
    c = colorC;
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
  pulse.flash();
  pulse.draw_rec();
}
