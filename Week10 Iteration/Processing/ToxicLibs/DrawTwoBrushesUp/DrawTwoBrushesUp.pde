/**
A 3D item based on <a href="http://www.local-guru.net/">guru</a>
*/
import toxi.geom.*;
import toxi.geom.mesh.*;
import toxi.volume.*;
import toxi.processing.*;

// prepare toxiclibs stuff
ToxiclibsSupport gfx;
TriangleMesh mesh;

void setup() {
  
  size(300,300,P3D);
  
  // startup toxiclibs
  gfx = new ToxiclibsSupport(this);
  
  // create a volumetric space made up of an array of 100 X 100 X 100 voxels
  VolumetricSpace volume = new VolumetricSpaceArray( new Vec3D(100,200,100), 100, 100, 100 );  
  IsoSurface surface = new ArrayIsoSurface( volume );
  
  // add a triangle mesh to display and for later export as STL
  mesh = new TriangleMesh();
    
  // draw 8 brushes going up.
  VolumetricBrush brush = new RoundBrush( volume, 10 );
  brush.setSize( 8 );
  for(int i = 0; i < 8; i++){
    brush.drawAtAbsolutePos( new Vec3D(0,0-i*8,0), 1 );
  }
  
  // draw 8 brushes going up, arcing to one side.
//  VolumetricBrush brush = new RoundBrush( volume, 10 );
  int brushSize = 8;
  brush.setSize( brushSize );
  for(int i = 0; i < brushSize; i++){
    brush.drawAtAbsolutePos( new Vec3D(i*(brushSize/2),0-i*brushSize,0), 1 );
  }
    
//  // this draws a spiral up.
//  VolumetricBrush brush = new RoundBrush( volume, 10 );
//  for ( int i=0; i < 20; i ++) {
//    brush.setSize( i*1.2 + 6 );
//    float x = cos( i * TWO_PI / 20 ) * 10;
//    float y = sin( i * TWO_PI / 20 ) * 10;  
//    brush.drawAtAbsolutePos( new Vec3D(x,-25+i * 7,y), 1 );
//  }
//  
//  // this draws the suckers on the spiral
//  for ( int i=4; i < 20; i+=4) {
//    brush.setSize( i/1.5+4 );
//    
//    float x = cos( i * TWO_PI / 20 ) * (i*1.2+16);
//    float y = sin( i * TWO_PI / 20 ) * (i*1.2+16);  
//    
//    brush.drawAtAbsolutePos( new Vec3D(x,-25+i * 7,y), 1 );
//
//   brush.setSize( i/2+2 );    
//    float x2 = cos( i * TWO_PI / 20  ) * (i*1.2+18);
//    float y2 = sin( i * TWO_PI / 20  ) * (i*1.2+18);  
//    brush.drawAtAbsolutePos( new Vec3D(x2,-25+i * 7,y2), -1.4 );
//  }
  
  // make the mesh from the volume
  volume.closeSides();
  surface.reset();
  surface.computeSurfaceMesh( mesh, .5 );
}

void draw() {
    background(0);
    lights();
    translate( width/2, height/2, 0);
    rotateY( frameCount * 0.05 );
    scale(1.5);
    fill(255);
    noStroke();
    beginShape(TRIANGLES);
    gfx.mesh( mesh );
    endShape();
}

void keyPressed() {
  if (key=='s') {
    mesh.saveAsSTL( sketchPath( "file.stl" ));
  }
}
