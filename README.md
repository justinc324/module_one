# Becton Café Display

[Link to my art in action!](https://www.youtube.com/channel/UCS3HBdbbz4U99ov7CeJ6lqw?view_as=subscriber) 

Thanks for checking out my repo!  My goal here was to visualize music - primarily the rhythm and melody, inspired by an Intro 
Music class I’m taking this semester. No two pieces from the program are the same, which is one of the coolest parts about this!

Upon boot of the Raspberry Pi, the program randomly assigns:
- A BPM between 40 - 60
- Colors to represent the beat/rhythm and colors to represent the seven different notes of a standard scale
- Note values for each of the seven notes

Additionally, the note values are reassigned every two measures - we wouldn't want it to get too boring now.

The gigantic screen inside the cafe has two parts. The part on the wall has the seven colors representing
the seven notes of the scale, blended together in a gradient. The top ceiling additionally has the seven colors in a gradient from
the color representing the rhythm.

# Installation
Here's some instructions on how to replicate my generative art piece in the Becton Café.
In order to display this on boot of the Raspberry Pi, we're going to need to a few things beforehand:

### Ensure Processing 3.x is installed on the Rapsberry Pi

`curl https://processing.org/download/install-arm.sh | sudo sh`

### Modify the HDMI settings

This program requires a 1280 x 800 resolution to properly display (16:10). 

Navigate to `/boot/config.txt`. Inside that file, find the following line and uncomment it:

 `disable_overscan=1`
 
 Add the following lines anywhere you like inside of `config.txt`:
 
 ```
# 1280x800 output
hdmi_ignore_edid=0xa5000080
hdmi_drive=2
hdmi_group=2
hdmi_mode=28
```
### Git clone the repository

Copy the repo, via HTTPS or whatever you prefer.

### Setup to start on boot
We want this to be plug n' play, so we need to set up the program to boot on run.

Let's modify the start file:

`sudo nano ~/.config/lxsession/LXDE-pi/autostart`

You may need to create the `lxsession` and `LXDE-pi` folders.

Insert this line:

`{PATH TO YOUR PROCESSING APP} --sketch={PATH THE WHERE YOU CLONED THE FOLDER}/module_one/sketch_190916a --run`

for example, my command looks like this on my Pi:

`/usr/local/bin/processing-java --sketch=home/pi/dev/module_one/sketch_190916a`

### Run it!

Hit `sudo reboot` in the terminal. Plug in your pi, and you should see the generative art display go!


