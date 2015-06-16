/* NCDLogo.pde
 * -----------
 * Sets up the backdrop (with text and background gradient).
 * Sets up the basic size and location of the sphere in 3D.
 * Loops through and updates the rotation of the Spehere.
 * Feeds in mouse movements to the Control Point 
 * to adjust movement of the point and thence the Sphere.
 * Feeds in key presses that signal the need to change backdrop or icon display.
 *
 * Code by Gauden Galea, 12 September 2010
 * Released under CC-GNU GPL license v2.0 or later
 * The license is viewable here: http://creativecommons.org/licenses/GPL/2.0/
 */

import processing.opengl.*;

int cell = 10; // diameter of particles
float radius = 140; // radius of large sphere
int num = 1000; // number of spheres

color bg = color(212, 237, 244); // default background color
PImage[] backdrop = new PImage[2]; // array of background images
int backdropIndex = 0; // start with the first backdrop in the array

Sphere mySphere; // the main actor, container for all the little particles
float xPos, yPos, zPos; // coordinates of centre of large sphere

ControlPoint cp; // its position at any point determines position of the sphere
//   In LOOPING mode, the control point:
//   -- turns on a fixed circle
//   -- does not respond to mouse movements
//   In CONTROLLING mode, the control point:
//   -- works like a bouncing ball (reflecting off the sides of the frame)
//   -- responds to mouse movements
int LOOPING = 0;
int CONTROLLING = 1;

int movCounter = 1501;

void setup() {
  size(1024, 768, OPENGL);
  smooth();
  noStroke();

  backdrop[0] = loadImage("201011-tagline-00-1024x768.png");
  backdrop[1] = loadImage("20100920-1024x768.png");

  xPos = 550;
  yPos = 330;
  zPos = 370;
  mySphere = new Sphere(xPos, yPos, zPos, radius);
  for (int i = 0; i < num; i++) {
    mySphere.addSphereItem( cell );
  }
  
  cp = new ControlPoint();
}

void draw() {
  background(bg);
  image( backdrop[backdropIndex], 0, 0, backdrop[backdropIndex].width, backdrop[backdropIndex].height);
  cp.update();
// Uncomment the next line to visualise the control point as a black circle
//  cp.render();
  mySphere.render( cp.getX(), cp.getY() );
//  if (movCounter-- > 0) {
//    saveFrame("frames/logo-#####.png");
//  } else {
//    exit();
//  }
}

void mouseMoved() {
  cp.setTarget( (float) mouseX, (float) mouseY );
}

void keyPressed() {
  if (key == 'i' || key == 'I') {
    // toggles between displaying the two types of particle: 
    // plain circles or bitmaps of the logo
    mySphere.toggleMode();
  }
  if (key == 'b' || key == 'B') {
    // cycles between the backdrops in the backdrop array
    backdropIndex++;
    backdropIndex = backdropIndex % backdrop.length;
  }
  if (key == 'c' || key == 'C') {
    // toggles the control point between looping and mouse-controlled
    cp.toggleMode();
  }
}

