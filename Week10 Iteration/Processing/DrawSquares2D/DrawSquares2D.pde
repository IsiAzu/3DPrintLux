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
  
  app();
  
  if (record) {
    endRaw();
    record = false;
  }
}

void app() {
  background(0);
  rectMode(CENTER);
  float angle = map(mouseX,0,width,-360,360*2);  
  pushMatrix();
  translate(width/2, height/2);
  rotate(radians(angle));
  float s = map(angle,-360,360*2,1.,10.);
  scale(s);
  
  // draw primitives here
  drawSquare(0, 0, 300);
  
  popMatrix();
}

void drawSquare(float x, float y, float diam) {
  noFill();
  stroke(255);
  rect(x, y, diam, diam);

  if (diam>8) { // exit condition
    drawSquare(x+diam*.5, y, diam*0.5);
        drawSquare(x-diam*.5, y, diam*0.5);
//    drawSquare(x, y+diam*.5, diam*0.5);
                drawSquare(x, y-diam*.5, diam*0.5);
  }
}

void keyPressed() {
  // Use a key press so that it doesn't make a million files
  if (key == 'r') {
    record = true;
  }
}
