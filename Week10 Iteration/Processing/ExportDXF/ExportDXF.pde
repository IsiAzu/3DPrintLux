import processing.dxf.*;

boolean record;

void setup() {
  size(500, 500, P2D);
}

void draw() {
  if (record) {
    beginRaw(DXF, "output.dxf");
  }

  // Do all your drawing here
  
  ellipse(width/2,height/2,width/25,width/25);
  if (record) {
    endRaw();
    record = false;
  }
}

void keyPressed() {
  // Use a key press so that it doesn't make a million files
  if (key == 'r') {
    record = true;
  }
}
