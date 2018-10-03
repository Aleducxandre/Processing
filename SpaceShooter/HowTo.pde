class HowTo {
  PImage apoint;
  PImage spoint;
  PImage health;  

  HowTo() {
    apoint = loadImage("moonRock.png");
    apoint.resize(40, 40);
    spoint = loadImage("enemyShip.png");
    spoint.resize(40, 40);
    health = loadImage("glowingOrb.png");
    health.resize(40, 40);
  }

  void display() {    
    fill(0, 155);
    textSize(50);
    text("Key", width/2-180, height/2+95);
    image(apoint, width/2-45, height/2+85);
    image(spoint, width/2-45, height/2+135);
    image(health, width/2-45, height/2+185);
    textSize(20);
    text("Enemy: 1 Point", width/2-10, height/2+90);
    text("Enemy: 2 Points", width/2-10, height/2+140);
    text("Shoot for Health", width/2-10, height/2+190);
  }
}