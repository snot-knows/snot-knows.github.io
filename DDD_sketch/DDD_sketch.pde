PImage img;
float offset = 0;
float easing = 0.05;

void setup() {
  size(900, 900);
  img = loadImage("DDD.jpg");  // Load an image into the program 
}

void draw() { 
  image(img, 0, 0);  // Display at full opacity
  float dx = (mouseX-img.width/2) - offset;
  offset += dx * easing; 
  tint(#B3D6CB, mouseX/50);  // Display at half opacity
  image(img, offset, 0);
}