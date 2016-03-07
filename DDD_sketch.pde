PImage img;
float offset = 0;
float easing = 0.05;

void setup() {
  size(600, 600);
  img = loadImage("3d.jpg");  // Load an image into the program 
}

void draw() { 
  image(img, 0, 0);  // Display at full opacity
  float dx = (mouseX-img.width/2) - offset;
  offset += dx * easing; 
  tint(#FFFFFF, mouseX/50);  // Display at half opacity
  image(img, offset, 0);
}