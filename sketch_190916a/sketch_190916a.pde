// beats per minute of the song
double BPM = 60.0;

// colors for the squares
color pulseColor; 
color tonic_color = color(0, 0, 255);
color supertonic_color;
color mediant_color; 
color subdominant_color;
color dominant_color;
color submediant_color;
color leading_tone_color;

// converts the given BPM into a format we can use for lerpColor
// 60 --> 500 ms
// 120 --> 250 ms
double convertBPM(double bpm) {
    return (60.0/bpm) * 500.0;
}

// a class representing squares that pulse at  the BPM
class beatSquares {
  color c;
  int bpm;
  float count;
  
  // constructor
  beatSquares(color colorC) {
     c = colorC;
     count = 1;
     
     // convert the bpm into a format we can use
     bpm = (int) (convertBPM(BPM));
  }
  
  void flash() {
   int time = millis();
   /* determines often we will "flash" the beat, switching between white and the color
   * taken from this thread:
   * https://forum.processing.org/two/discussion/20861/change-between-colors-over-time */
   if ((time/bpm)%2==0) {
     fill(lerpColor(255, c, count));
   }
   else {
      fill(255);
      count = 1;
   }
   //fill(lerpColor(255, c, ((time/bpm)%2==0)?time:bpm-time));
  }
  
  // draw our rectangles in the appropriate areas
  void draw_rec() {
    
     // Wall 1: xratio= 0.0, yratio= 0.7462963, len= 29, wid=43
     rect(width*0, height*0.7462963, 43, 29);
     
     // Wall 2: xratio= 0.122395836, yratio= 0.7712963, len= 29, wid=43
     rect(width*0.122395836, height*0.7712963, 43, 29);
     
     // Wall 3: xratio= 0.35364583, yratio= 0.7425926, len= 29, wid=44
     rect(width*0.35364583, height*0.7425926, 44, 29);
     
     // Wall 4: xratio= 0.66041666, yratio= 0.0, len= 635, wid=651
     rect(width*0.66041666,  height*0, 651, 365);
  }
}

class noteSquare {
  
  color c;
  int bpm;
  int[] notes; // an array of note durations - basically our sheet music!
  
  // wall 1
  float Xpos1;
  float Ypos1;
  int len1;
  int wid1;
  
  // wall 2
  float Xpos2;
  float Ypos2;
  int len2;
  int wid2;
  
  // wall 3
  float Xpos3;
  float Ypos3;
  int len3;
  int wid3;
  
  // for playing notes
  int i;
  int len;
  int curr_note_length;
  
  // constructor
  noteSquare(color colorC,
             float x1, float y1, int leng1, int widt1,
             float x2, float y2, int leng2, int widt2,
             float x3, float y3, int leng3, int widt3
             ) {
               
    c = colorC;
    bpm = (int) convertBPM(BPM);
    notes = new int[]{ 1,4,4,4,4 };
    
    i = 0;
    len = notes.length;
    curr_note_length = calculate_duration(notes[i]);
    
    Xpos1 = x1;
    Ypos1 = y1;
    len1 = leng1;
    wid1 = widt1;
    
    Xpos2 = x2;
    Ypos2 = y2;
    len2 = leng2;
    wid2 = widt2;
    
    Xpos3 = x3;
    Ypos3 = y3;
    len3 = leng3;
    wid3 = widt3;
  }
  
  // draws the sqaures in the given areas
  void draw_rec() {
    rect(Xpos1, Ypos1, wid1, len1);
    rect(Xpos2, Ypos2, wid2, len2);
    rect(Xpos3, Ypos3, wid3, len3);
  }
  
  /* fills white or the note color, depending on the time
  * 1 == whole note
  * 2 == half
  * 4 == quarter
  * 8 == eigth
  */
  void flash(int note) {
    
    int time = millis();
    int conv_bpm = 0;
    
    // convert bpm based on the note
    if (note == 1) {
      conv_bpm = bpm * 8;
    }
    else if (note == 2) {
      conv_bpm = bpm * 4;
    }
    else if (note == 4) {
      conv_bpm = bpm;
    }
    else if (note == 8) {
      conv_bpm = bpm/2;
    }
    
    // if it's empty, leave it white
    if (conv_bpm == 0) {
      fill(255);
    }
    else {
      fill(lerpColor(255, c, ((time/conv_bpm)%2==0)?time:conv_bpm-time));
    }
}
  
  // calculates the duration of a given note in milliseconds
  int calculate_duration(int note) {
    double mult_factor;
    
    if (note == 1) {
      mult_factor = 4.0;
    }
    else if (note == 2) {
      mult_factor = 2.0;
    }
    else if (note == 4) {
      mult_factor = 1.0;
    }
    else {
      mult_factor = .5;
    }
    
    double duration = (mult_factor * 1000.0) / (BPM/60.0);
    
    return (int) duration;
  }
  
  // calls the fill function and draws the rectangles so the note plays
  void playNote(int b){
    flash(b);
    draw_rec();
  }
  

  
  void playNotes() {
    int time = millis();
    playNote(notes[i]);
    
    
    
    if (((time%curr_note_length+1000)!=0)) {
      i++;
      i = i % len; // allows us to loop through the note array endlessly
      curr_note_length = calculate_duration(notes[i]);
    }
    
    //int conv_bpm = 0;
    
    //// convert bpm based on the note
    //if (notes[i] == 1) {
    //  conv_bpm = bpm * 8;
    //}
    //else if (notes[i] == 2) {
    //  conv_bpm = bpm * 4;
    //}
    //else if (notes[i] == 4) {
    //  conv_bpm = bpm;
    //}
    //else if (notes[i] == 8) {
    //  conv_bpm = bpm/2;
    //}
    
    
   

    
    System.out.print(i);
    System.out.print(" - ");
    System.out.print(curr_note_length);
     System.out.print("\n");
     System.out.print(time);
      System.out.print("\n");
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
  tonic = new noteSquare(tonic_color, 
                           width*0.06302083, height*0.7972222, 29, 43,
                           width*0.17916666, height*0.7972222, 29, 44,
                           width*0.3875, height*0.7962963, 29, 44);
  supertonic = new noteSquare(supertonic_color,
                           0, 0, 0, 0,
                           0, 0, 0, 0,
                           width*0.41041666, height*0.7962963, 29, 44);
  mediant = new noteSquare(mediant_color,
                           0, 0, 0, 0,
                           width*0.2765625, height*0.7685185, 29, 44,
                           width*0.43385416, height*0.7685185, 29, 44);
  subdominant = new noteSquare(subdominant_color,
                           0,0,0,0,
                           0,0,0,0,
                           width*0.4609375, height*0.8851852, 30, 45);
  dominant = new noteSquare(dominant_color,
                           width*0.08645833, height*0.7712963, 29, 43,
                           width*0.29895833, height*0.7425926, 29, 44,
                           width*0.48645833, height*0.48645833, 29, 44);
  submediant = new noteSquare(submediant_color,
                           0,0,0,0,
                           0,0,0,0,
                           width*0.50885415, height*0.7685185, 29, 44);
  leading_tone = new noteSquare(leading_tone_color,
                           0,0,0,0,
                           0,0,0,0,
                           width*0.5640625, height*0.85925925, 34, 49);
}

void draw() {
  
  // set up the pulsing squares
  pulse.flash();
  pulse.draw_rec();
  
  // set up the tonic square
  tonic.playNote(2);
  
  supertonic.playNote(1);
  
  mediant.playNote(1);
  
  subdominant.playNote(2);
  
  dominant.playNote(4);
  
  submediant.playNote(1);
  
  leading_tone.playNote(4);
}
