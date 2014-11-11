import processing.dxf.*;

boolean record;

void setup() {
  size(800, 800, P3D);
//  camera(70.0, 35.0, 120.0, 50.0, 50.0, 0.0, 0.0, 1.0, 0.0);
}

void draw() {
  if (record) {
    beginRaw(DXF, "output.dxf");
  }

  // Do all your drawing here
  
  cameraPos();
  app();
  
  if (record) {
    endRaw();
    record = false;
  }
}

void cameraPos(){
    lights();
  background(200);
  float cameraY = height/2.0;
  float fov = mouseX/float(width) * PI/2;
  float cameraZ = cameraY / tan(fov / 2.0);
  float aspect = float(width)/float(height);
  perspective(fov, aspect, cameraZ/10.0, cameraZ*10.0);
}

void app() {  
  drawSphere(width/2,height/2,0,20);
}

void drawSphere(float x, float y, float z, float diam) {
  pushMatrix();
  translate(x,y,z);
  sphere(diam);
  popMatrix();
  
  if (diam > 4){
    drawSphere(x-diam,y,z,diam*.5);
    drawSphere(x,y-diam,z,diam*.5);
  }
}

void keyPressed() {
  // Use a key press so that it doesn't make a million files
  if (key == 'r') {
    record = true;
  }
}
