import processing.video.*;
import gab.opencv.*;
import java.awt.*;
Capture video;
OpenCV opencv;



PImage img;


void setup() {
  size(900, 900, P3D);
  img = loadImage("cat2.jpg");
  img.resize(900,900);
  String[] cameras = Capture.list();
  if (cameras.length == 0) 
  {
    println("There are no cameras available for capture.");
      //exit();
  } 
  else 
  {
    println("Available cameras:");
    for (int i = 0; i < cameras.length; i++) 
     {
      println(cameras[i]);
    }
    video = new Capture(this, cameras[0]);
    video.start();
    opencv = new OpenCV(this, 640, 480);
    opencv.loadCascade(OpenCV.CASCADE_FRONTALFACE);  
     
  }
}



void draw() {
  background(#f1f1f1);
  
  video.read();
  opencv.loadImage(video);
  image(video, 0, 0 );
  
  fill(0);
  noStroke();
  sphereDetail(3);
  //ellipse(mouseX,mouseY,40,40);
  
  float tiles = 100;
  float tileSize = width/tiles;
  
  push();
  translate(width/2,height/2);
  rotateY(radians(frameCount));
  
  for (int x = 0; x < tiles; x++) {
     for (int y = 0; y < tiles; y++) {
       color c = img.get(int(x*tileSize),int(y*tileSize));
       float b = map(brightness(c),0,255,1,0);
       
       float z = map(b,0,1,-100,100);
       
       
       push();
       translate(x*tileSize -width/2,y*tileSize - height/2, z);
       sphere(tileSize*b*0.8);
       pop();
      //ellipse(x * tileSize,y*tileSize,10,10);
     }
  }
  pop();
}
