float x=500, y=500, vx=4, vy=6, radius=20;
float batWidth=100, batHeight=20;
PVector[] bricks = new PVector[20];
int i = 0;
int xPos=10;
int yPos=20;
int state=0;
int rectW=100, rectH=15;

//Setting up interface and calling the brickInitiate() class
void setup() {
  size(600, 600);
  brickInitiate();
}


void draw() {
  background(0);
  //Going through values of array and saving the parameters to variables
  for (int j = 0; j < bricks.length; j++) {
    if (bricks[j]!=null) {
      PVector currentBrick = bricks[j];
      int xPosition = (int)currentBrick.x;
      int yPosition = (int)currentBrick.y;
      int brickState = (int)currentBrick.z;

      //Colour of brick depending on state
      if (brickState==0) {
        fill(0, 255, 0);
      } else if (brickState==1) {
        fill(255, 150, 0);
      } else if (brickState==2) {
        fill(255, 0, 0);
      } else {
        fill(0);
      }
      //Drawing all of the bricks from the array
      rect(xPosition, yPosition, rectW, rectH);
    }
  }
  //Drawing the ball
  fill(255);
  ellipse(x, y, radius*2, radius*2);
  noFill();   
  //Adding the velocities
  x+=vx;
  y+=vy;
  //If ball goes out of bounds change direction of velocity
  if (x+radius > width || x-radius < 0 ) {
    vx= -vx;
  }
  if (y+radius > height || y-radius < 0 ) {
    vy= -vy;
  }
  if (y + radius >height) {
    y=(height-radius);
  }
  //Drawing the bat
  fill(255);
  rect(mouseX, mouseY, batWidth, batHeight);  

  //Checking if ball hits bat
  if (x > mouseX && x < mouseX+batWidth) {
    if (y+radius > mouseY && y+radius < mouseY+batHeight) {  
      y = mouseY-radius;
      vy= -vy;
    } else if (y-radius < mouseY+batHeight && y-radius > mouseY) {
      y = mouseY+batHeight+radius;
      vy= -vy;
    }
  } 
  if (y > mouseY && y < mouseY+batHeight) {
    if (x+radius > mouseX && x+radius < mouseX+20) {
      x= mouseX-radius;
      vx = -vx;
    }
    if (x-radius < mouseX+batWidth && x-radius > mouseX+batWidth-20) {
      x = mouseX+radius+batWidth ;
      vx = -vx;
    }
  }
  if (vx>0 && vy>0) {
    if (y < mouseY && y+radius > mouseY) {
      if (x<mouseX && x+radius > mouseX) {
        vx=-vx;
        vy=-vy;
      }
    }
  }

  if (vx>0 && vy<0) {
    if (y > mouseY+batHeight && y-radius < mouseY+batHeight) {
      if (x<mouseX && x+radius > mouseX) {
        vx=-vx;
        vy=-vy;
      }
    }
  }

  if (vx<0 && vy>0) {
    if (y < mouseY && y+radius > mouseY) {
      if (x>mouseX+batWidth && x-radius < mouseX+batWidth) {
        vx=-vx;
        vy=-vy;
      }
    }
  }

  if (vx<0 && vy<0) {
    if (y > mouseY+batHeight && y-radius < mouseY+batHeight) {
      if (x>mouseX+batWidth && x-radius < mouseX+batWidth) {
        vx=-vx;
        vy=-vy;
      }
    }
  }
  //CHecking if ball hits bricks
  for (int j = 0; j < bricks.length; j++) {
    if (bricks[j]!=null) {
      PVector currentBrick = bricks[j];
      float xPosition = currentBrick.x;
      float yPosition = currentBrick.y;
      float brickState = currentBrick.z;

      if (brickState<3) {
        if (x>xPosition && x < xPosition+rectW ) {
          if (y-radius<yPosition+rectH && y-radius>yPosition) {
            brickState++;
            bricks[j] = new PVector(xPosition, yPosition, brickState);
            y = yPosition+rectH+radius;
            vy=-vy;
          }
        }

        if (y > yPosition && y < yPosition+rectH) {
          if (x+radius > xPosition && x+radius < xPosition+20) {
            x= xPosition-radius;
            vx = -vx;
            brickState++;
            bricks[j] = new PVector(xPosition, yPosition, brickState);
          } else if (x-radius < xPosition+rectW && x-radius > rectW+xPosition-20) {
            x = xPosition+radius+rectW ;
            vx = -vx;
            brickState++;
            bricks[j] = new PVector(xPosition, yPosition, brickState);
          }
        }

        if (vx>0 && vy>0) {
          if (y < yPosition && y+radius > yPosition) {
            if (x<xPosition && x+radius > xPosition) {
              brickState++;
              bricks[j] = new PVector(xPosition, yPosition, brickState);
              vx=-vx;
              vy=-vy;
            }
          }
        }
        if (vx>0 && vy<0) {
          if (y > yPosition+rectH && y-radius < yPosition+rectH) {
            if (x<xPosition && x+radius > xPosition) {
              brickState++;
              bricks[j] = new PVector(xPosition, yPosition, brickState);
              vx=-vx;
              vy=-vy;
            }
          }
        }

        if (vx<0 && vy>0) {
          if (y < yPosition && y+radius > yPosition) {
            if (x<xPosition && x+radius > xPosition) {
              brickState++;
              bricks[j] = new PVector(xPosition, yPosition, brickState);
              vx=-vx;
              vy=-vy;
            }
          }
        }

        if (vx<0 && vy<0) {
          if (y > yPosition+rectH && y-radius < yPosition+rectH) {
            if (x<xPosition && x+radius > xPosition) {
              brickState++;
              bricks[j] = new PVector(xPosition, yPosition, brickState);
              vx=-vx;
              vy=-vy;
            }
          }
        }
      }
    }
  }
}

//Creating and filling in the brick array
void brickInitiate() {
  for (int row = 0; row < 4; row++) {
    xPos = 10;
    for (int col = 0; col < 5; col++) {
      bricks[i] = new PVector(xPos, yPos, state);
      i++;
      xPos = xPos + 120;
    }
    yPos = yPos + 20;
  }
}