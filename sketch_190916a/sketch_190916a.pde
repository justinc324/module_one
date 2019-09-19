import java.util.List;
import java.util.Arrays;
import java.util.ArrayList;
import java.util.Random;
Random rand = new Random(); 

// =================GENERAL DECLARATIONS===============================

// important; this is the color that we'll use as the background
color background = color(0,0,0);

// beats per minute of the song
double BPM = 60.0;

// max/min BPM (dont want it too flashy)
int MAX_BPM = 60;
int MIN_BPM = 40;

// general colors 
color blue = color(0, 0, 255);
color red = color(255, 0, 0);
color yellow = color(255, 255, 0);
color green = color(51, 255, 0);
color purple = color(102, 0, 255);
color pink = color(255, 0, 255);
color orange = color(255, 153, 0);
color aqua = color(0, 255, 255);

// colors for the squares
color pulseColor = red; 
color tonic_color = blue;
color supertonic_color = yellow;
color mediant_color = green; 
color subdominant_color = purple;
color dominant_color = pink;
color submediant_color = orange;
color leading_tone_color = aqua;

// square to declare
beatSquares pulse; // the main beat for the song
noteSquare tonic; // note # 1 (i.e. C for the C major scale)
noteSquare supertonic; // note # 2
noteSquare mediant; // note # 3
noteSquare subdominant; // note # 4
noteSquare dominant; // note # 5
noteSquare submediant; // note # 6
noteSquare leading_tone; // note # 7 

// notes we are going to play
List<Integer> assigned_notes = new ArrayList();

// colors to assign
List<Integer> assigned_colors = new ArrayList();

// =================HELPER FUNCTIONS===============================

// converts the given BPM into a format we can use for lerpColor
// 60 --> 500 ms
// 120 --> 250 ms
double convertBPM(double bpm) {
    return (60.0/bpm) * 500.0;
}

// randomly assigns a BPM value between 40 and 80
void assignBPM() {
  BPM = (rand.nextInt((MAX_BPM-MIN_BPM) + 1) + MIN_BPM);
} 

// randomly assigns notes (whole, half, quarter, or eighth) to assigned_notes
void assignNotes() {
  
  // clear list of prev entries
  assigned_notes.clear();
  
  List<Integer> notes = Arrays.asList(0, 1,2,4,8);
  
  int len = 7; // seven notes to assign
  
  for (int i = 0; i < len; i++) {
    int randomIndex = rand.nextInt(notes.size());
    int rand = (notes.get(randomIndex));
    assigned_notes.add(rand);
  }
}

// randomly assigns colors (non-repeating) to assigned_notes and the rhythm
void assignColors() {
  
  // clear the list just in case
  assigned_colors.clear();
  
  List<Integer> colors = new ArrayList<Integer>(
                                  Arrays.asList(
                                  red, blue, yellow, green, purple, pink, orange, aqua));
  
  int len = 8; // seven notes + one beat to assign colors
  
  for (int i = 0; i < len; i++) {
    int randomIndex = rand.nextInt(colors.size());
    int rand = colors.get(randomIndex);
    assigned_colors.add(rand);
    colors.remove(randomIndex);
  }
  
  // assign the colors
  pulseColor = assigned_colors.get(0); 
  tonic_color = assigned_colors.get(1); 
  supertonic_color = assigned_colors.get(2); 
  mediant_color = assigned_colors.get(3); 
  subdominant_color = assigned_colors.get(4); 
  dominant_color = assigned_colors.get(5); 
  submediant_color = assigned_colors.get(6); 
  leading_tone_color = assigned_colors.get(7); 
}

// =================CLASSES==============================================

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
   * adapted from this thread:
   * https://forum.processing.org/two/discussion/20861/change-between-colors-over-time */
   if ((time/bpm)%2==0) {
     fill(lerpColor(background, c, count));
   }
   else {
      fill(background);
      count = 1;
   }
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
     rect(width*0.66041666,  height*0, 651, 635);
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
  int scale_num;
  
  // constructor
  noteSquare(color colorC, int num,
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
    scale_num = num;
    
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
    
    // if it's empty, leave it white (or whatever color is the background)
    if (conv_bpm == 0) {
      fill(background);
    }
    else {
      fill(lerpColor(background, c, ((time/conv_bpm)%2==0)?time:conv_bpm-time));
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
  void playNote(){
    flash(assigned_notes.get(scale_num));
    draw_rec();
  }
}

// =================MAIN CODE===============================================

void setup() {
  fullScreen();
  background(background);
  
  /* RANDOM FUN!!
  * Let's do fun things like assigning colors, BPM, and note
  * values for us. */
  assignBPM();
  assignNotes();
  assignColors();
  
  // set up our squares with colors
  pulse = new beatSquares(pulseColor);
  tonic = new noteSquare(tonic_color, 0,
                           width*0.06302083, height*0.7972222, 29, 43,
                           width*0.17916666, height*0.7972222, 29, 44,
                           width*0.3875, height*0.7962963, 29, 44);
  supertonic = new noteSquare(supertonic_color, 1,
                           0, 0, 0, 0,
                           0, 0, 0, 0,
                           width*0.41041666, height*0.7962963, 29, 44);
  mediant = new noteSquare(mediant_color, 2,
                           0, 0, 0, 0,
                           width*0.2765625, height*0.7685185, 29, 44,
                           width*0.43385416, height*0.7685185, 29, 44);
  subdominant = new noteSquare(subdominant_color, 3,
                           0,0,0,0,
                           0,0,0,0,
                           width*0.4609375, height*0.8851852, 30, 45);
  dominant = new noteSquare(dominant_color, 4,
                           width*0.08645833, height*0.7712963, 29, 43,
                           width*0.29895833, height*0.7425926, 29, 44,
                           width*0.48645833, height*0.7425926, 29, 44);
  submediant = new noteSquare(submediant_color, 5,
                           0,0,0,0,
                           0,0,0,0,
                           width*0.50885415, height*0.7685185, 29, 44);
  leading_tone = new noteSquare(leading_tone_color, 6,
                           0,0,0,0,
                           0,0,0,0,
                           width*0.5640625, height*0.85925925, 34, 49);
}
int count = 1;
void draw() {
  
  // set up the pulsing squares
  pulse.flash();
  pulse.draw_rec();
  
  // play!
  tonic.playNote();
  supertonic.playNote();
  mediant.playNote();
  subdominant.playNote();
  dominant.playNote();
  submediant.playNote();
  leading_tone.playNote();
  
  if (millis() / 8000 > count) {
    assignNotes();
    count++;
  }
}
