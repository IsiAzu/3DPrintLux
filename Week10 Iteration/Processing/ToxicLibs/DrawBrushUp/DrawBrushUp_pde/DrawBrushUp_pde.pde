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
    
  // set up our brushes
  VolumetricBrush brush = new RoundBrush( volume, 10 );
  int brushSize = 8;
  brush.setSize( 8 );
  
  // draw multiple brushes going up.
  for(int h = 0; h < 360; h ++){
    for(int i = 0; i < 8; i++){
      brush.drawAtAbsolutePos( new Vec3D((i*brushSize)/2,0-i*brushSize,0), h );
    }
  }

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
