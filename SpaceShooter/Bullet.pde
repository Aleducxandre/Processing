class Bullet {
  float mousex, mousey;
  float bulletX, bulletY;
  float m, yLeft, yRight, xTop, xBot;
  float angle;
  float xPos, yPos;
  int c =0;

  Bullet(float x, float y) {
    bulletX = width/2;
    bulletY = height/2;
    mousex = x;
    mousey = y;
  }

  void drawBullet() {
    angle = atan2(width/2-mousex, height/2-mousey);
    angle = angle+PI/2;
    float xMovement = 15*cos(angle);
    float yMovement = 15*sin(-angle);
    bulletX = bulletX + xMovement;
    bulletY = bulletY + yMovement;
    strokeWeight(3);
    if (c==0) {
      stroke(255, 0, 0);
      c=1;
    } else if (c==1) {
      stroke(0, 255, 0);
      c=2;
    } else {
      stroke(0, 0, 255);
      c=0;
    }
    point(bulletX, bulletY);
  }
}