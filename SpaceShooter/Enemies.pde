class Enemies {
  String shapeType;
  PImage enemy;
  float xPos, yPos;
  float angle;
  float userX=width/2, userY=height/2;
  int imageSize;
  Boolean damaged = false;
  float speedR = 2.9;
  float speedS = 3.5;
  int speedO = 4;
  
  Enemies(String shape) {
    shapeType = shape;
    if (shapeType.equals("rock")) {
      enemy = loadImage("moonRock.png");
      enemy.resize(30, 30);
      imageSize = 30;
    } else if (shapeType.equals("ship")) {
      enemy = loadImage("enemyShip.png");
      enemy.resize(30, 30);
      imageSize = 30;
      } else if (shapeType.equals("diamond")) {
      enemy = loadImage("enemyShip.png");
      enemy.resize(30, 30);
      imageSize = 30;
    } else {
      enemy = loadImage("glowingOrb.png");
      enemy.resize(30, 30);
      imageSize = 30;
    }
    int chance = (int)(random(0, 4));
    if (chance==0) {  //comes from the top of the screen
      xPos = random(width);
      yPos = 0;
    } else if (chance==1) {  //comes from the right hand side of the screen
      xPos = width;
      yPos = random(height);
    } else if (chance==2) {  //comes from the bottom of the screen
      xPos = random(width);
      yPos = height;
    } else {  //comes from the left hand side of the screen
      xPos = 0;
      yPos = random(height);
    }
  }

  void drawEnemy() {

    if (shapeType.equals("rock")) {
      angle = atan2(xPos-userX, yPos-userY);
      angle = angle+PI/2;
      float xMovement = speedR*cos(angle);
      float yMovement = speedR*sin(-angle);
      xPos = xPos + xMovement;
      yPos = yPos + yMovement;
      image(enemy, xPos, yPos);
    } else if (shapeType.equals("ship")) {
      pushMatrix();
      angle = atan2(xPos-userX, yPos-userY);
      angle = angle+PI/2;
      float xMovement = speedS*cos(angle);
      float yMovement = speedS*sin(-angle);
      xPos = xPos + xMovement;
      yPos = yPos + yMovement;
      float angleRotate = atan2(userX-xPos, userY-yPos);
      angleRotate = angleRotate + PI;
      translate(xPos, yPos);
      rotate(-angleRotate);
      image(enemy, 0, 0);
      popMatrix();
    } else {
      angle = atan2(xPos-userX, yPos-userY);
      angle = angle+PI/2;
      float xMovement = speedO*cos(angle);
      float yMovement = speedO*sin(-angle);
      xPos = xPos + xMovement;
      yPos = yPos + yMovement;
      image(enemy, xPos, yPos);
    }
  }
  
  Boolean collisionDetection(ArrayList<Bullet> bullet){
    for(Bullet pellet: bullet){
        if(pellet.bulletX > xPos-15 && pellet.bulletX < xPos+15 && pellet.bulletY > yPos-15 && pellet.bulletY < yPos+15){
          return true;
        }
    }
    return false;
  }
  
  int score(){
    if(shapeType.equals("rock")){
      return 1;
    }
    else if (shapeType.equals("ship")){
      return 2;
    }
    else{
      return 0;
    }
  }
    Boolean checkLose() {
    if (!enemy.equals("orb")) {
      if (xPos>width/2-5 && xPos<width/2+5 && yPos>height/2-5 && yPos<height/2+5) {
        return true;
      }
      return false;
    } else {
      return false;
    }
  }

}