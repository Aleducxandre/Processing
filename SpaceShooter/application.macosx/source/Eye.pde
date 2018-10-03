class Eye{
  float ex, ey;
  int size;
  float angle = 0.0;
  
  Eye(int x, int y, int s){
  ex=x;
  ey=y;
  size=s;
  }
    
    void update(float sx, float sy){
    angle = atan2(sy-ey, sx-ex);
  }
  
  void display(){
    pushMatrix();
    translate(ex, ey);
    fill(255);
    ellipse(0, 0, size, size);
    rotate(angle);
    fill(0);
    ellipse(size/4, 0, size/2, size/2);
    popMatrix();
  }
  
}