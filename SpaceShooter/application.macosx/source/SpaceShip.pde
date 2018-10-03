class SpaceShip {
  PImage ship;
  float angle, bulletAngle;
  ArrayList<PVector> bullets = new ArrayList<PVector>(); 

  SpaceShip() {
  }

  void drawSpaceShip() {
    pushMatrix();
    ship = loadImage("spaceShip.jpg");
    ship.resize(50, 50);
    float x = width/2;
    float y = height/2;
    translate(x, y);
    angle = atan2(x-mouseX, y-mouseY);
    bulletAngle = atan2(x-mouseX, y-mouseY);
    rotate(-angle);
    imageMode(CENTER);
    image(ship, 0, 0);
    popMatrix();
  }
  
  void shoot(){
    bullets.add(new PVector(mouseX, mouseY));
  }
  
}