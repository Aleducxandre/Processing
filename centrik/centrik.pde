//INITIALISING VARIABLES
int x, y, circleRadius=1, r, g, b;
int position = 300;
float angle = 10;
int spinRadius = 300;
float speed = 8;

void setup(){
  //SETTING UP INTERFACE AND BACKGROUND
  size(600, 600);
  background(20);
  fill(255);
  rect(505, 535, 70, 50);
  rect(500, 530, 70, 50);
  fill(0);
  text("Reset", 520,560);
}

void draw(){
  //IF STATEMENT MAKES IT STOP WHEN THE CIRCLES REACH MIDDLE
  if (spinRadius != 0){
    stroke(255);
    if(!mousePressed){
    //IF MOUSEPRESSED IS FALSE CIRCLES HAVE NOFILL
    noFill();}
    //MATHS TO FIND WHERE CIRCLES SHOULD BE USING SINE AND COSINE
      x = (int)(position + sin(angle) * spinRadius);
      y = (int)(position + cos(angle) * spinRadius);
      //DRAWING CIRCLES EACH TIME     
      strokeWeight(1);
      ellipse(x,y, circleRadius, circleRadius);  
      
      //CHANGING ANGLE FOR WHERE CIRCLE IS ON THE OUTER CIRCLE
      angle = angle + speed;  
      //DECREASING THE RADIUS OF THE OUTERCIRCLE CREATING SPIRAL EFFECT
      spinRadius = spinRadius-1;
      circleRadius= circleRadius-1;
  }
  if(mousePressed){
    //WHEN MOUSE PRESSES BUTTON THE PROGRAM RESTARTS
    if(mouseX >= 500 && mouseX <= 570 && mouseY >=530 && mouseY <=580){
    fill(255, 0, 120);
    rect(500, 530, 70, 50);
    background(0);
    stroke(0);
    strokeWeight(1);
    fill(255);
    rect(505, 535, 70, 50);
    rect(500, 530, 70, 50);
    fill(0);
    text("Reset", 720,760);
    //RESETTING VARIABLES
    angle = 10;
    spinRadius = 300;
    speed = 8;
    circleRadius = 1;
    //REDRAWING BUTTON LABEL
    fill(0);
    text("Reset", 520,560);  

  }
  else{
  circleRadius = 10;
      //CHANGES COLOUR OF INSIDE CIRCLES WHEN MOUSEPRESSED
      r = (int)random(255);
      g = (int)random(255);
      b = (int)random(255);
      fill(r, g, b);
      //DRAWING AND CHOOSING RANDOM COLOURS FOR THE STROKE OF THE LINES
      r = (int)random(255);
      g = (int)random(255);
      b = (int)random(255);
      stroke(r,g,b);
      strokeWeight(3);
      line(x,y,300, 300);
  }
}
}
  