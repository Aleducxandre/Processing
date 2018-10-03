 
float stepSize = 10;
float maxDepth = 200;
int b =(int)random(255);
int n =(int)random(255);
int m =(int)random(255);
int count;

void setup(){
  size(640, 640, P3D);
  noFill();
  stroke(0, 0, 255);
  strokeWeight(2);
  count = 0;
}
 
void draw(){
  count++;
  if(count == 10){
    b = (int)random(255);
    n = (int)random(255);
    m = (int)random(255);
    count=0;
  }
  stroke(b,n,m);
  background(32);
  for(float w = 0; w <= width; w += stepSize){
    beginShape();
    for(float h = -stepSize; h <= height + stepSize; h += stepSize){
      float d = maxDepth * map(noise(w * 0.01, h * 0.01, frameCount * 0.05), 0, 1, -1, 1);
      curveVertex(w, h, d + h * 2.0 - 300);
    }
    endShape();
  }
  for(float h = 0; h <= height; h += stepSize){
    beginShape();
    for(float w = -stepSize; w <= width + stepSize; w += stepSize){
      float d = maxDepth * map(noise(w * 0.01, h * 0.01, frameCount * 0.05), 0, 1, -1, 1);
      curveVertex(w, h, d + h * 2.0 - 300);
    }
    endShape();
  }
}
