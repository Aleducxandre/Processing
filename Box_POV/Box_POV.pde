int pos = 0;
int state = 0;
int count = 0;

void setup() {
  fullScreen(P3D);
}

void draw() {
  background(0);
  if (pos>width){state=0;}
  if (pos<0){state=1;}
    if(state == 1){
      pos+=10;
    }
    else if (state == 0){
      pos-=10;
    }
  camera(pos, height/2, (height/2) / tan(PI/6), width/2, height/2, 0, 0, 1, 0);
  translate(width/2, height/2);
  stroke(25);
  if(count>0&&count<=130){
    fill(255,0,0);
  }
  else if(count>130&&count<260){
    fill(0,255,0);
  }
  else if(count>=270&&count<405){
    fill(0,0,255);
  }
  else if(count>20){count=0;}
  count++;
  box(300);
}
