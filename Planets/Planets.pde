// Planets, by Andres Colubri
//
// Sun and mercury textures from http://planetpixelemporium.com
// Star field picture from http://www.galacticimages.com/

PImage starfield;
PImage dino;
PShape sun;
PImage suntex;

PShape planet1;
PImage surftex1;
PImage cloudtex;

PShape planet2;
PImage surftex2;

float offset = 0;
float easing = 0.05;

void setup() {
  size(1024, 768, P3D);
  
  starfield = loadImage("dino.jpg");
  suntex = loadImage("dino.jpg");  
  surftex1 = loadImage("dino.jpg");
  dino = loadImage("dino.jpg");  // Load an image into the program 
   
  // We need trilinear sampling for this texture so it looks good
  // even when rendered very small.
  //PTexture.Parameters params1 = PTexture.newParameters(ARGB, TRILINEAR);  
  surftex2 = loadImage("dino.jpg");  
  
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

  sun = beginShape();
    for(int i = 0; i <= nbPts; i++) {
      PVector v = pts[i];
      vertex(v.x, v.y, v.z);
    }
    endShape();
  sun.setTexture(suntex);  

  planet1 = beginShape();
    for(int i = 0; i <= nbPts; i++) {
      PVector v = pts[i];
      vertex(v.x, v.y, v.z);
    }
    endShape();
  planet1.setTexture(surftex1);
  
  planet2 = beginShape();
    for(int i = 0; i <= nbPts; i++) {
      PVector v = pts[i];
      vertex(v.x, v.y, v.z);
    }
    endShape();
  planet2.setTexture(surftex2);*/
}

void draw() {
  // Even we draw a full screen image after this, it is recommended to use
  // background to clear the screen anyways, otherwise A3D will think
  // you want to keep each drawn frame in the framebuffer, which results in 
  // slower rendering.
  //image(dino, 0, 0);  // Display at full opacity
  
  // Disabling writing to the depth mask so the 
  // background image doesn't occludes any 3D object.
  hint(DISABLE_DEPTH_MASK);
  image(dino, 0, 0, width, height);
  hint(ENABLE_DEPTH_MASK);
  
  pushMatrix();
  translate(width/2, height/2, -300);  
  
  pushMatrix();
  rotateY(PI * frameCount / 500);
  shape(sun);
  popMatrix();
  
  tint (100, mouseX/5);  // Display at half opacity
  image(dino, offset, 0);
  

  pointLight(255,  255,  255,  0,  0,  0);  
  rotateY(PI * frameCount / 300);
  translate(0, 0, 300);

  shape(planet2);  
  
  popMatrix();
  
  noLights();
  pointLight(255,  255,  255,  0,  0,  -150); 
  
  
  translate(0.75 * width,  0.6 * height,  50);
  shape(planet1);
  
  float dx = (mouseX-dino.width/2) - offset;
  offset += dx * easing; 
}