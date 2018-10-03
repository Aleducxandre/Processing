class Pause {
  Boolean overMenu = false;
  Boolean overRestart = false;
  Boolean overContinue = false;
  Boolean overEasy = false;
  Boolean overMedium = false;
  Boolean overHard = false;
  String difficulty;
  PImage arrow; 

  Pause() {
    arrow = loadImage("arrow.jpg");
    arrow.resize(40, 35);
  }

  void pause(String d) {
    difficulty = d;
    background(205, 133, 63);      
    stroke(150);
    fill(195);
    rect(width/2-350, height/2-175, 700, 350);
    textSize(90);
    fill(135, 206, 235);
    text("Paused", width/2-135, height/2-250);
    textSize(50);
    fill(0, 150);
    text("Menu", width/2-245, height/2-90);
    text("Restart", width/2-260, height/2);
    text("Continue", width/2-279, height/2+90);
    fill(0);
    textSize(30);
    text("Change Difficulty", width/2+25, height/2-100);
    textSize(40);
    if (difficulty.equals("Easy")) {
      fill(0, 255, 0);
      text("Easy", width/2+100, height/2-30);
      fill(0, 150);
      text("Medium", width/2+75, height/2+30);
      text("Hard", width/2+95, height/2+90);
    } else  if (difficulty.equals("Medium")) {
      fill(255, 140, 0);
      text("Medium", width/2+75, height/2+30);
      fill(0, 150);
      text("Easy", width/2+100, height/2-30);
      text("Hard", width/2+95, height/2+90);
    } else {
      fill(255, 0, 0);
      text("Hard", width/2+95, height/2+90);
      fill(0, 150);
      text("Easy", width/2+100, height/2-30);
      text("Medium", width/2+75, height/2+30);
    }
  }

  void checkPause(int mx, int my) {
    if (mx>width/2-245 && mx<width/2-115 && my>height/2-125 && my<height/2-85) {
      textSize(50);
      fill(0);
      text("Menu", width/2-245, height/2-90);
      image(arrow, width/2-270, height/2-110);
      overEasy = false;
      overMedium = false;
      overHard = false;
      overRestart = false;
      overMenu = true;
      overContinue = false;
    } else if (mx>width/2-255 && mx<width/2-85 && my>height/2-30 && my<height/2+5) {
      textSize(50);
      fill(0);
      text("Restart", width/2-260, height/2);
      image(arrow, width/2-285, height/2-20);
      overEasy = false;
      overMedium = false;
      overHard = false;
      overRestart = true;
      overMenu = false;
      overContinue = false;
    } else if (mx>width/2-275 && mx<width/2-65 && my>height/2+49 && my<height/2+95) {
      textSize(50);
      fill(0);
      text("Continue", width/2-279, height/2+90);
      image(arrow, width/2-305, height/2+70);
      overEasy = false;
      overMedium = false;
      overHard = false;
      overRestart = false;
      overMenu = false;
      overContinue = true;
    } else if (mx>width/2+77 && mx<width/2+228 && my>height/2+3 && my<height/2+33) {
      textSize(40);
      fill(255, 140, 0);
      text("Medium", width/2+75, height/2+30);
      image(arrow, width/2+50, height/2+15);
      overEasy = false;
      overMedium = true;
      overHard = false;
      overRestart = false;
      overMenu = false;
      overContinue = false;
    } else if (mx>width/2+103 && mx<width/2+185 && my>height/2-60 && my<height/2-30) {
      textSize(40);
      fill(0, 255, 0);
      text("Easy", width/2+100, height/2-30);
      image(arrow, width/2+75, height/2-45);
      overEasy = true;
      overMedium = false;
      overHard = false;
      overRestart = false;
      overMenu = false;
      overContinue = false;
    } else if (mx>width/2+97 && mx<width/2+187 && my>height/2+63 && my<height/2+93) {
      textSize(40);
      fill(255, 0, 0);
      text("Hard", width/2+95, height/2+90);
      image(arrow, width/2+70, height/2+75);
      overEasy = false;
      overMedium = false;
      overHard = true;
      overRestart = false;
      overMenu = false;
      overContinue = false;
    } else {
      overEasy = false;
      overMedium = false;
      overHard = false;
      overRestart = false;
      overMenu = false;
      overContinue = false;
    }
  }
}