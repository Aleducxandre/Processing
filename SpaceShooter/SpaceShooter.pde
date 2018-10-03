PVector[] stars = new PVector[250];
SpaceShip user = new SpaceShip();
Boolean state = false;
Boolean overText = false;
PFont helveticaNeue;
ArrayList<Bullet> bullets = new ArrayList<Bullet>();
ArrayList<Enemies> enemies = new ArrayList<Enemies>();
int bulletCount = 0;
ForceField shield = new ForceField();
int s, c, h;
int napTime = 3000;
String playerState = "Welcome";
int score;
String difficulty = "Easy";
Boolean overEasy = false;
Boolean overMedium = false;
Boolean overHard = false;
float angle = 1.15;
float angle1 = 0.99;
float angle2 = 0.89;
float angle3 = 0.79;
float angle4 = 0.69;
float speed = 0.030;
int constant = 450;
int scalar = 300;
float xPlane = width/2;
float yPlane = height/2;
PImage shipPic, jupiter;
PImage smoke1, smoke2, smoke3, smoke4;
float xSmoke1, ySmoke1, xSmoke2, ySmoke2, xSmoke3, ySmoke3, xSmoke4, ySmoke4;
Eye eye1, eye2;
HowTo how;
Boolean overPause = false;
Boolean pause = false;
Pause call;



void setup() {
  fullScreen();
  how = new HowTo();
  background(0);
  fill(255);
  call = new Pause();
  for (int i = 0; i < 250; i++) {
    stars[i] = new PVector(random(width), random(height));
  }
  textSize(25);
  smooth();
  text("Difficulty", width-150, 90);
  text("Easy", width-120, 125);
  text("Medium", width-120, 160);
  text("Hard", width-120, 195);
  shipPic = loadImage("spaceShipMenu.jpg");
  smoke1 = loadImage("smoke1.jpg");
  smoke1.resize(30, 30);
  smoke2 = loadImage("smoke2.jpg");
  smoke2.resize(30, 30);
  smoke3 = loadImage("smoke3.jpg");
  smoke3.resize(30, 30);
  smoke4 = loadImage("smoke4.jpg");
  smoke4.resize(30, 30);
  jupiter = loadImage("Jupiter.jpg");
  eye1 = new Eye(70, 120, 120);
  eye2 = new Eye(200, 90, 90);
}

void draw() {
  //Gameplay state
  if (state) {
    if (pause) {
      call.pause(difficulty);
      call.checkPause(mouseX, mouseY);
    } else {
      noStroke();
      background(RGB);
      textSize(40);
      fill(205, 133, 63);
      text("Score: " + score, 100, 100);
      text("Shield state: " + shield.state, 100, 150);
      int winScore = 50;
      int scoreToWin = winScore - score;
      text("To win: " + scoreToWin, 100, 200 );
      stroke(255);
      strokeWeight(1);
      for (int i = 0; i < 250; i++) {
        point(stars[i].x, stars[i].y);
      }
      stroke(205, 133, 63);
      strokeWeight(7);
      line(width-80, 80, width-80, 100);
      line(width-90, 80, width-90, 100);
      strokeWeight(1);
      if (mouseX>width-94 && mouseX<width-73 && mouseY>80 && mouseY<106) {
        overPause = true;
        stroke(0, 133, 63);
        strokeWeight(7);
        line(width-80, 80, width-80, 100);
        line(width-90, 80, width-90, 100);
        strokeWeight(1);
      } else {
        overPause=false;
      }
      for (Enemies enemy : enemies) {
        Boolean n = enemy.checkLose();
        if (n) {
          delay(500);
          playerState = "You Lose";
          state = false;
          score = 0;
          bullets = new ArrayList<Bullet>();
          enemies = new ArrayList<Enemies>();
          shield = new ForceField();
        }
      }
      for (int i = enemies.size()-1; i>=0; i--) {
        Boolean collide = enemies.get(i).collisionDetection(bullets);
        if (collide) {
          int sc = enemies.get(i).score();
          if (sc==1) {
            score++;
          }
          if (sc==2) {
            score=score+2;
          }
          if (sc==0) {
            shield.healthUp();
          }
          enemies.remove(i);
        }
      }
      if (difficulty.equals("Easy")) {
        c = (int)random(250);
        s = (int)random(125);
        h = (int)random(800);
      } else if (difficulty.equals("Medium")) {
        c = (int)random(200);
        s = (int)random(90);
        h = (int)random(900);
      } else if (difficulty.equals("Hard")) {
        c = (int)random(80);
        s = (int)random(40);
        h = (int)random(1000);
      }

      //Creating enemies at random instances
      if (s==1)enemies.add(new Enemies("rock"));
      if (c==1)enemies.add(new Enemies("ship"));
      if (h==1)enemies.add(new Enemies("orb"));
      user.drawSpaceShip();
      shield.drawShield();
      for (Bullet bullet : bullets) bullet.drawBullet();  //drawing bullets
      for (Enemies enemy : enemies) enemy.drawEnemy();  //drawing enemies

      if (!shield.state.equals("Nill")) {              //checking for shield collision
        for (int i = enemies.size()-1; i>=0; i--) {
          Enemies e = shield.collisionDetection(enemies.get(i));
          if (e!=null) {
            if (enemies.get(i).shapeType.equals("rock")||enemies.get(i).shapeType.equals("ship")) {
              shield.collision();
            }
            enemies.remove(e);
          }
        }
      }
      if (score>=winScore) {
        this.win();
      }
    }
  }





  //Menu state
  else if (!state) {
    if (mouseX > width/2-195 && mouseX < width/2+210 && mouseY > height/2-75 && mouseY < height/2+30) {
      overText = true;
      background(205, 133, 63);
      how.display();
      xPlane = width/2+ sin(angle)*scalar;
      yPlane = height/2 + cos(angle)*scalar;
      xSmoke1 = width/2+ sin(angle1)*scalar;
      ySmoke1 = height/2 + cos(angle1)*scalar;
      xSmoke2 = width/2+ sin(angle2)*scalar;
      ySmoke2 = height/2 + cos(angle2)*scalar;
      xSmoke3 = width/2+ sin(angle3)*scalar;
      ySmoke3 = height/2 + cos(angle3)*scalar;
      xSmoke4 = width/2+ sin(angle4)*scalar;
      ySmoke4 = height/2 + cos(angle4)*scalar;
      angle= angle + speed;
      angle1 = angle1 + speed;
      angle2 = angle2 + speed;
      angle3 = angle3 + speed;
      angle4 = angle4 + speed;
      shipPic.resize(75, 75);
      float x = width/2;
      float y = height/2;
      pushMatrix();
      translate(xPlane, yPlane);
      float Rotangle = atan2(x-xPlane, y-yPlane);
      Rotangle = Rotangle+PI/2;
      rotate(-Rotangle);
      imageMode(CENTER);
      image(shipPic, 0, 0);
      popMatrix();
      pushMatrix();
      translate(xSmoke1, ySmoke1);
      float sAngle1 = atan2(x-xSmoke1, y-ySmoke1);
      sAngle1 = sAngle1+PI/2;
      rotate(-sAngle1);
      imageMode(CENTER);
      image(smoke1, 0, 0);
      popMatrix();
      pushMatrix();
      translate(xSmoke2, ySmoke2);
      float sAngle2 = atan2(x-xSmoke2, y-ySmoke2);
      sAngle2 = sAngle2+PI/2;
      rotate(-sAngle2);
      imageMode(CENTER);
      image(smoke2, 0, 0);
      popMatrix();
      pushMatrix();
      translate(xSmoke3, ySmoke3);
      float sAngle3 = atan2(x-xSmoke3, y-ySmoke3);
      sAngle3 = sAngle3+PI/2;
      rotate(-sAngle3);
      imageMode(CENTER);
      image(smoke3, 0, 0);
      popMatrix();
      pushMatrix();
      translate(xSmoke4, ySmoke4);
      float sAngle4 = atan2(x-xSmoke4, y-ySmoke4);
      sAngle4 = sAngle4+PI/2;
      rotate(-sAngle4);
      imageMode(CENTER);
      image(smoke4, 0, 0);
      popMatrix();
      helveticaNeue = createFont("cursive", 130);
      textFont(helveticaNeue);
      fill(0, 0, 255);
      text("START", width/2-200, height/2+25);
      fill(255, 0, 0);
      text("START", width/2-195, height/2+25);
      fill(0, 255, 0);
      text("START", width/2-190, height/2+25);
      textSize(30);
      fill(255);

      text("Difficulty", width-170, 90);
      if (difficulty.equals("Easy")) {
        fill(0, 255, 0);
        text("Easy", width-150, 125);
      } else if (difficulty.equals("Medium")) {
        fill(255, 140, 0);
        text("Medium", width-150, 160);
      } else {
        fill(255, 0, 0);
        text("Hard", width-150, 195);
      }

      if (playerState.equals("Welcome")) {
        textSize(70);  
        fill(255);
        text(playerState, width/2-150, height/2-115);
      } else if (playerState.equals("You Lose")) {
        textSize(70);
        fill(0, 0, 255);  
        text(playerState, width/2-145, height/2-115);
        fill(255, 0, 0);
        text(playerState, width/2-150, height/2-115);
      } else if (playerState.equals("You Win")) {
        textSize(70);
        fill(0, 0, 255);
        text(playerState, width/2-145, height/2-115);
        fill(0, 255, 0);
        text(playerState, width/2-150, height/2-115);
      }
    } else {
      background(205, 133, 63);
      how.display();
      xPlane = width/2+ sin(angle)*scalar;
      yPlane = height/2 + cos(angle)*scalar;
      xSmoke1 = width/2+ sin(angle1)*scalar;
      ySmoke1 = height/2 + cos(angle1)*scalar;
      xSmoke2 = width/2+ sin(angle2)*scalar;
      ySmoke2 = height/2 + cos(angle2)*scalar;
      xSmoke3 = width/2+ sin(angle3)*scalar;
      ySmoke3 = height/2 + cos(angle3)*scalar;
      xSmoke4 = width/2+ sin(angle4)*scalar;
      ySmoke4 = height/2 + cos(angle4)*scalar;
      angle= angle + speed;
      angle1 = angle1 + speed;
      angle2 = angle2 + speed;
      angle3 = angle3 + speed;
      angle4 = angle4 + speed;
      shipPic.resize(75, 75);
      float x = width/2;
      float y = height/2;
      pushMatrix();
      translate(xPlane, yPlane);
      float Rotangle = atan2(x-xPlane, y-yPlane);
      Rotangle = Rotangle+PI/2;
      rotate(-Rotangle);
      imageMode(CENTER);
      image(shipPic, 0, 0);
      popMatrix();
      pushMatrix();
      translate(xSmoke1, ySmoke1);
      float sAngle1 = atan2(x-xSmoke1, y-ySmoke1);
      sAngle1 = sAngle1+PI/2;
      rotate(-sAngle1);
      imageMode(CENTER);
      image(smoke1, 0, 0);
      popMatrix();
      pushMatrix();
      translate(xSmoke2, ySmoke2);
      float sAngle2 = atan2(x-xSmoke2, y-ySmoke2);
      sAngle2 = sAngle2+PI/2;
      rotate(-sAngle2);
      imageMode(CENTER);
      image(smoke2, 0, 0);
      popMatrix();
      pushMatrix();
      translate(xSmoke3, ySmoke3);
      float sAngle3 = atan2(x-xSmoke3, y-ySmoke3);
      sAngle3 = sAngle3+PI/2;
      rotate(-sAngle3);
      imageMode(CENTER);
      image(smoke3, 0, 0);
      popMatrix();
      pushMatrix();
      translate(xSmoke4, ySmoke4);
      float sAngle4 = atan2(x-xSmoke4, y-ySmoke4);
      sAngle4 = sAngle4+PI/2;
      rotate(-sAngle4);
      imageMode(CENTER);
      image(smoke4, 0, 0);
      popMatrix();
      overText = false;
      textSize(600);
      helveticaNeue = createFont("cursive", 130);
      fill(255);
      stroke(255);
      textFont(helveticaNeue);
      text("START", width/2-200, height/2+25);
      textSize(30);      
      text("Difficulty", width-170, 90);
      fill(255);
      if (overEasy||difficulty.equals("Easy")) {
        fill(0, 255, 0);
      }
      text("Easy", width-150, 125);
      fill(255);
      if (overMedium||difficulty.equals("Medium")) {
        fill(255, 140, 0);
      }
      text("Medium", width-150, 160);
      fill(255);
      if (overHard||difficulty.equals("Hard")) {
        fill(255, 0, 0);
      }
      text("Hard", width-150, 195);
      fill(255);
    }
    if (mouseX>width-150 && mouseX< width-40) {
      if (mouseY > 100 && mouseY < 125) {
        overEasy = true;
      } else if (mouseY > 135 && mouseY < 160) {
        overMedium = true;
      } else if (mouseY > 170 && mouseY < 195) {
        overHard = true;
      } else {
        overEasy = false;
        overMedium = false;
        overHard = false;
      }
    } else {
      overEasy = false;
      overMedium = false;
      overHard = false;
    }

    jupiter.resize(500, 500);
    image(jupiter, 50, 150);
    eye1.update(xPlane, yPlane);
    eye2.update(xPlane, yPlane);
    eye1.display();
    eye2.display();
    if (playerState.equals("Welcome")) {
      textSize(70);  
      fill(255);
      text(playerState, width/2-150, height/2-115);
    } else if (playerState.equals("You Lose")) {
      textSize(70);
      fill(0, 0, 255);  
      text(playerState, width/2-145, height/2-115);
      fill(255, 0, 0);
      text(playerState, width/2-150, height/2-115);
    } else if (playerState.equals("You Win")) {
      textSize(70);
      fill(0, 0, 255);
      text(playerState, width/2-145, height/2-115);
      fill(0, 255, 0);
      text(playerState, width/2-150, height/2-115);
    }
  }
}

//Check for button press and bullet shoot 
void mousePressed() {
  if (!state) {
    if (overEasy) {
      difficulty="Easy";
    }
    if (overMedium) {
      difficulty="Medium";
    }
    if (overHard) {
      difficulty="Hard";
    }
    if (overText) {
      state = true;
    } else {
      state = false;
    }
  } else if (pause) {
    if (call.overMenu) {
      playerState = "Welcome";
      state=false;
      pause = false;
      score = 0;
      bullets = new ArrayList<Bullet>();
      enemies = new ArrayList<Enemies>();
      shield = new ForceField();
    } else if (call.overRestart) {
      score = 0;
      bullets = new ArrayList<Bullet>();
      enemies = new ArrayList<Enemies>();
      shield = new ForceField();
      pause = false;
    } else if (call.overContinue) {
      pause = false;
      state = true;
    } else if (call.overEasy) {
      difficulty = "Easy";
    } else if (call.overMedium) {
      difficulty = "Medium";
    } else if (call.overHard) {
      difficulty = "Hard";
    }
  } else if (state) {
    if (overPause) {
      pause = true;
    } else {
      bullets.add(new Bullet(mouseX, mouseY));
    }
  }
}

void win() {
  delay(500);
  playerState = "You Win";
  state=false;
  score = 0;
  bullets = new ArrayList<Bullet>();
  enemies = new ArrayList<Enemies>();
  shield = new ForceField();
}