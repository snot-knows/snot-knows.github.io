// Planets, by Andres Colubri
//
// Sun and mercury textures from http://planetpixelemporium.com
// Star field picture from http://www.galacticimages.com/

PImage starfield;

PImage img;
float offset = 0;
float easing = 0.05;

PShape sun;
PImage suntex;

PShape planet1;
PImage surftex1;
PImage cloudtex;

PShape planet2;
PImage surftex2;

PShape planet3;
PImage surftex3;

PFont f;

void setup() {
  size(1024, 768, P3D);
  
  img = loadImage("girl.jpg");
  
  f = createFont("Arial",16,true);
  
  starfield = loadImage("girl.jpg");
  suntex = loadImage("girl.jpg");  
  surftex1 = loadImage("girl.jpg");  
  surftex3 = loadImage("girl.jpg");
  
  // We need trilinear sampling for this texture so it looks good
  // even when rendered very small.
  //PTexture.Parameters params1 = PTexture.newParameters(ARGB, TRILINEAR);  
  surftex2 = loadImage("girl.jpg");  
  
  /*
  // The clouds texture will "move" having the values of its u
  // texture coordinates displaced by adding a constant increment
  // in each frame. This requires REPEAT wrapping mode so texture 
  // coordinates can be larger than 1.
  //PTexture.Parameters params2 = PTexture.newParameters();
  //params2.wrapU = REPEAT;
  cloudtex = createImage(512, 256);

  // Using 3D Perlin noise to generate a clouds texture that is seamless on
  // its edges so it can be applied on a sphere.
  cloudtex.loadPixels();
  Perlin perlin = new Perlin();
  for (int j = 0; j < cloudtex.height; j++) {
    for (int i = 0; i < cloudtex.width; i++) {
      // The angle values corresponding to each u,v pair:
      float u = float(i) / cloudtex.width;
      float v = float(j) / cloudtex.height;
      float phi = map(u, 0, 1, TWO_PI, 0); 
      float theta = map(v, 0, 1, -HALF_PI, HALF_PI);
      // The x, y, z point corresponding to these angles:
      float x = cos(phi) * cos(theta);
      float y = sin(theta);            
      float z = sin(phi) * cos(theta);      
      float n = perlin.noise3D(x, y, z, 1.2, 2, 8);
      cloudtex.pixels[j * cloudtex.width + i] = color(255, 255,  255, 255 * n * n);
    }
  }  
  cloudtex.updatePixels();
  */

  noStroke();
  fill(255);
  sphereDetail(40);

  sun = createShape(SPHERE, 150);
  sun.setTexture(suntex);  

  planet1 = createShape(SPHERE, 150);
  planet1.setTexture(surftex1);
  
  planet2 = createShape(SPHERE, 50);
  planet2.setTexture(surftex2);
  
  planet3 = createShape(SPHERE, 50);
  planet3.setTexture(surftex3);
}

void draw() {
  // Even we draw a full screen image after this, it is recommended to use
  // background to clear the screen anyways, otherwise A3D will think
  // you want to keep each drawn frame in the framebuffer, which results in 
  // slower rendering.
  background(0);
  
  stroke(0);
  translate(50, 50, 0);
  rotateX(mouseY * 0.05);
  rotateY(mouseX * 0.05);
  texture(img);
    for (int i = 0; i < 100; i++) {
    float x = random(mouseX*3);
    float y = random(20000);
    stroke(0);
    textFont(f,16);
    fill(215, 227, 218);
    text("capitalism is my favorite drug", x, y);
  }
  if (frameCount % 10 == 0) println(frameRate);
  //fill(255, 255, 255, mouseX/10);
  sphereDetail(mouseX / 4);
  sphere(200);
  
  // Disabling writing to the depth mask so the 
  // background image doesn't occludes any 3D object.
  hint(DISABLE_DEPTH_MASK);
  //image(starfield, 0, 0, width, height);
  hint(ENABLE_DEPTH_MASK);
  
  pushMatrix();
  translate(width/2, height/2, -300);  
  
  pushMatrix();
  rotateY(PI * frameCount / 500);
  shape(sun);
  popMatrix();

  pointLight(255,  255,  255,  0,  0,  0);  
  rotateY(PI * frameCount / 300);
  translate(0, 0, 300);

  shape(planet2);  
  
  popMatrix();
  
  noLights();
  pointLight(255,  255,  255,  0,  0,  -150); 
 
  
  translate(0.75 * width,  0.6 * height,  50);
  rotateY(PI * mouseX / 300);
  shape(planet1);
  
}