// variables
PVector[] points = new PVector[12];
float[][] cars = new float[2][12];
float t = 0.0;
int selected, curve = 1;
float size = 10; 
Boolean locked = false;
// setting up the interface
void setup() {
  size(1100, 700);
  smooth();
  // creating the 12 points on the curve at random places on the screen and saving them as PVectors
  for (int i = 0; i < 12; i++) {
    points[i] = new PVector(random(50, 1050), random(50, 650));
  }
  // creating 12 cars and saving their states to an array 
  for (int rows  = 0; rows < 12; rows++) {
    cars[0][rows] = random(1);
    cars[1][rows] = (int)random(1, 12);
  }
}

void draw() { 
  noFill();
  background(255);
  stroke(0, 0, 128);
  strokeWeight(20);
  // drawing the curves as curve vertex's
  beginShape();
  curveVertex(points[10].x, points[10].y);
  curveVertex(points[0].x, points[0].y);
  curveVertex(points[1].x, points[1].y);
  curveVertex(points[2].x, points[2].y);
  curveVertex(points[3].x, points[3].y);
  curveVertex(points[4].x, points[4].y);
  curveVertex(points[5].x, points[5].y);
  curveVertex(points[6].x, points[6].y);
  curveVertex(points[7].x, points[7].y);
  curveVertex(points[8].x, points[8].y);
  curveVertex(points[9].x, points[9].y);
  curveVertex(points[10].x, points[10].y);
  curveVertex(points[11].x, points[11].y);
  curveVertex(points[0].x, points[0].y);
  curveVertex(points[1].x, points[1].y);
  endShape();

  stroke(255, 127, 80);
  strokeWeight(1);
  // drawing the orange rectangles making it easy to spot the points on the curve
  rect(points[0].x, points[0].y, size, size);
  rect(points[1].x, points[1].y, size, size);
  rect(points[2].x, points[2].y, size, size);
  rect(points[3].x, points[3].y, size, size);
  rect(points[4].x, points[4].y, size, size);
  rect(points[5].x, points[5].y, size, size);
  rect(points[6].x, points[6].y, size, size);
  rect(points[7].x, points[7].y, size, size);
  rect(points[8].x, points[8].y, size, size);
  rect(points[9].x, points[9].y, size, size);
  rect(points[10].x, points[10].y, size, size);
  rect(points[11].x, points[11].y, size, size);
  // drawing the lines connecting all the points showing motion of curve
  line(points[0].x+5, points[0].y+5, points[1].x+5, points[1].y+5);
  line(points[1].x+5, points[1].y+5, points[2].x+5, points[2].y+5);
  line(points[2].x+5, points[2].y+5, points[3].x+5, points[3].y+5);
  line(points[3].x+5, points[3].y+5, points[4].x+5, points[4].y+5);
  line(points[4].x+5, points[4].y+5, points[5].x+5, points[5].y+5);
  line(points[5].x+5, points[5].y+5, points[6].x+5, points[6].y+5);
  line(points[6].x+5, points[6].y+5, points[7].x+5, points[7].y+5);
  line(points[7].x+5, points[7].y+5, points[8].x+5, points[8].y+5);
  line(points[8].x+5, points[8].y+5, points[9].x+5, points[9].y+5);
  line(points[9].x+5, points[9].y+5, points[10].x+5, points[10].y+5);
  line(points[10].x+5, points[10].y+5, points[11].x+5, points[11].y+5);
  line(points[11].x+5, points[11].y+5, points[0].x+5, points[0].y+5);

  //  checks if mouse is over a point when it presses mouse
  if (mousePressed) {
    for (int i = 0; i < 12; i++) {
      if (mouseX > points[i].x && mouseX < points[i].x+10) {
        if (mouseY > points[i].y && mouseY < points[i].y+10) {
          selected = i;
          locked = true;
        }
      }
    }
  }
  // calls the car method
  cars();
}


void mouseDragged() {
  // if the mouse is over a square when pressed then change that squares position to new mouse value
  if (locked) {
    int j = selected;
    points[j].x = mouseX;
    points[j].y = mouseY;
  }
}

// change of this variable helps knowing when mouse is over a square
void mouseReleased() {
  locked =false;
}


// THIS CODE REPEATS FOR 12 TIMES FOR EACH OF THE 12 CURVES SO I HAVE COMMENTED THE FIRST INSTANCE VERY WELL THEN LEFT THE OTHERS
void cars() {
  // for each car in the array
  for (int row = 0; row < 12; row++) {
    // popMatrix and pushMatrix work together to reset translate and rotate functions
    pushMatrix();
    // if the car is on first loop
    if (cars[1][row] == 1) {
      // if the t position is within 0 and 1 then do this
      if (cars[0][row] <=1.0) {
        // figures out position and orientation of each of the cars
        fill(255, 0, 0);
        //finds point on the curve from t position in array
        float x = curvePoint(points[10].x, points[0].x, points[1].x, points[2].x, cars[0][row]);
        float y = curvePoint(points[10].y, points[0].y, points[1].y, points[2].y, cars[0][row]);
        // translates position of the cars
        translate(x, y);
        // finds tangent from point on the curve (orientation of travel)
        float xTangent = curveTangent(points[10].x, points[0].x, points[1].x, points[2].x, cars[0][row]);
        float yTangent = curveTangent(points[10].y, points[0].y, points[1].y, points[2].y, cars[0][row]);
        stroke(255, 0, 0);
        strokeWeight(3);
        // shortens the tangent(not nessasary anymore)
        xTangent/=6;
        yTangent/=6;
        // finding angle that the car is needed to be rotated
        float angle = atan2(yTangent, xTangent);
        // rotates the cars the required angle
        rotate(angle);
        //draws the cars, made of a triangle and a circle
        triangle(0, -10, 0, 10, 25, 0);
        ellipse(0, 0, 10, 10);
        // increments the t value in array for that car
        cars[0][row]+=0.01;
        // else set the curve to next curve and t position back to the start
      } else {
        cars[1][row] = 2;
        cars[0][row] = 0.0;
      }
      // REPEAT
    } else if (cars[1][row] == 2) {
      if (cars[0][row] <=1.0) {
        fill(255, 0, 0);
        float x = curvePoint(points[0].x, points[1].x, points[2].x, points[3].x, cars[0][row]);
        float y = curvePoint(points[0].y, points[1].y, points[2].y, points[3].y, cars[0][row]);
        translate(x, y);
        float xTangent = curveTangent(points[0].x, points[1].x, points[2].x, points[3].x, cars[0][row]);
        float yTangent = curveTangent(points[0].y, points[1].y, points[2].y, points[3].y, cars[0][row]);
        stroke(255, 0, 0);
        strokeWeight(3);
        xTangent/=6;
        yTangent/=6;
        float angle = atan2(yTangent, xTangent);
        rotate(angle);
        triangle(0, -10, 0, 10, 25, 0);        
        ellipse(0, 0, 10, 10);
        cars[0][row]+=0.01;
      } else {
        cars[1][row] = 3;
        cars[0][row] = 0.0;
      }
    } else if (cars[1][row] == 3) {
      if (cars[0][row] <=1.0) {
        fill(255, 0, 0);
        float x = curvePoint(points[1].x, points[2].x, points[3].x, points[4].x, cars[0][row]);
        float y = curvePoint(points[1].y, points[2].y, points[3].y, points[4].y, cars[0][row]);
        translate(x, y);
        float xTangent = curveTangent(points[1].x, points[2].x, points[3].x, points[4].x, cars[0][row]);
        float yTangent = curveTangent(points[1].y, points[2].y, points[3].y, points[4].y, cars[0][row]);
        stroke(255, 0, 0);
        strokeWeight(3);
        xTangent/=6;
        yTangent/=6;
        float angle = atan2(yTangent, xTangent);
        rotate(angle);
        triangle(0, -10, 0, 10, 25, 0);        
        ellipse(0, 0, 10, 10);
        cars[0][row]+=0.01;
      } else {
        cars[1][row] = 4;
        cars[0][row] = 0.0;
      }
    } else if (cars[1][row] == 4) {
      if (cars[0][row] <=1.0) {
        fill(255, 0, 0);
        float x = curvePoint(points[2].x, points[3].x, points[4].x, points[5].x, cars[0][row]);
        float y = curvePoint(points[2].y, points[3].y, points[4].y, points[5].y, cars[0][row]);
        translate(x, y);
        float xTangent = curveTangent(points[2].x, points[3].x, points[4].x, points[5].x, cars[0][row]);
        float yTangent = curveTangent(points[2].y, points[3].y, points[4].y, points[5].y, cars[0][row]);
        stroke(255, 0, 0);
        strokeWeight(3);
        xTangent/=6;
        yTangent/=6;
        float angle = atan2(yTangent, xTangent);
        rotate(angle);
        triangle(0, -10, 0, 10, 25, 0);        
        ellipse(0, 0, 10, 10);
        cars[0][row]+=0.01;
      } else {
        cars[1][row] = 5;
        cars[0][row] = 0.0;
      }
    } else if (cars[1][row] == 5) {
      if (cars[0][row] <=1.0) {
        fill(255, 0, 0);
        float x = curvePoint(points[3].x, points[4].x, points[5].x, points[6].x, cars[0][row]);
        float y = curvePoint(points[3].y, points[4].y, points[5].y, points[6].y, cars[0][row]);
        translate(x, y);
        float xTangent = curveTangent(points[3].x, points[4].x, points[5].x, points[6].x, cars[0][row]);
        float yTangent = curveTangent(points[3].y, points[4].y, points[5].y, points[6].y, cars[0][row]);
        stroke(255, 0, 0);
        strokeWeight(3);
        xTangent/=6;
        yTangent/=6;
        float angle = atan2(yTangent, xTangent);
        rotate(angle);
        triangle(0, -10, 0, 10, 25, 0);        
        ellipse(0, 0, 10, 10);
        cars[0][row]+=0.01;
      } else {
        cars[1][row] = 6;
        cars[0][row] = 0.0;
      }
    } else if (cars[1][row] == 6) {
      if (cars[0][row] <=1.0) {
        fill(255, 0, 0);
        float x = curvePoint(points[4].x, points[5].x, points[6].x, points[7].x, cars[0][row]);
        float y = curvePoint(points[4].y, points[5].y, points[6].y, points[7].y, cars[0][row]);
        translate(x, y);
        float xTangent = curveTangent(points[4].x, points[5].x, points[6].x, points[7].x, cars[0][row]);
        float yTangent = curveTangent(points[4].y, points[5].y, points[6].y, points[7].y, cars[0][row]);
        stroke(255, 0, 0);
        strokeWeight(3);
        xTangent/=6;
        yTangent/=6;
        float angle = atan2(yTangent, xTangent);
        rotate(angle);
        triangle(0, -10, 0, 10, 25, 0);        
        ellipse(0, 0, 10, 10);
        cars[0][row]+=0.01;
      } else {
        cars[1][row] = 7;
        cars[0][row] = 0.0;
      }
    } else if (cars[1][row] == 7) {
      if (cars[0][row] <=1.0) {
        fill(255, 0, 0);
        float x = curvePoint(points[5].x, points[6].x, points[7].x, points[8].x, cars[0][row]);
        float y = curvePoint(points[5].y, points[6].y, points[7].y, points[8].y, cars[0][row]);
        translate(x, y);
        float xTangent = curveTangent(points[5].x, points[6].x, points[7].x, points[8].x, cars[0][row]);
        float yTangent = curveTangent(points[5].y, points[6].y, points[7].y, points[8].y, cars[0][row]);
        stroke(255, 0, 0);
        strokeWeight(3);
        xTangent/=6;
        yTangent/=6;
        float angle = atan2(yTangent, xTangent);
        rotate(angle);
        triangle(0, -10, 0, 10, 25, 0);        
        ellipse(0, 0, 10, 10);
        cars[0][row]+=0.01;
      } else {
        cars[1][row] = 8;
        cars[0][row] = 0.0;
      }
    } else if (cars[1][row] == 8) {
      if (cars[0][row] <=1.0) {
        fill(255, 0, 0);
        float x = curvePoint(points[6].x, points[7].x, points[8].x, points[9].x, cars[0][row]);
        float y = curvePoint(points[6].y, points[7].y, points[8].y, points[9].y, cars[0][row]);
        translate(x, y);
        float xTangent = curveTangent(points[6].x, points[7].x, points[8].x, points[9].x, cars[0][row]);
        float yTangent = curveTangent(points[6].y, points[7].y, points[8].y, points[9].y, cars[0][row]);
        stroke(255, 0, 0);
        strokeWeight(3);
        xTangent/=6;
        yTangent/=6;
        float angle = atan2(yTangent, xTangent);
        rotate(angle);
        triangle(0, -10, 0, 10, 25, 0);        
        ellipse(0, 0, 10, 10);
        cars[0][row]+=0.01;
      } else {
        cars[1][row] = 9;
        cars[0][row] = 0.0;
      }
    } else if (cars[1][row] == 9) {
      if (cars[0][row] <=1.0) {
        fill(255, 0, 0);
        float x = curvePoint(points[7].x, points[8].x, points[9].x, points[10].x, cars[0][row]);
        float y = curvePoint(points[7].y, points[8].y, points[9].y, points[10].y, cars[0][row]);
        translate(x, y);
        float xTangent = curveTangent(points[7].x, points[8].x, points[9].x, points[10].x, cars[0][row]);
        float yTangent = curveTangent(points[7].y, points[8].y, points[9].y, points[10].y, cars[0][row]);
        stroke(255, 0, 0);
        strokeWeight(3);
        xTangent/=6;
        yTangent/=6;
        float angle = atan2(yTangent, xTangent);
        rotate(angle);
        triangle(0, -10, 0, 10, 25, 0);        
        ellipse(0, 0, 10, 10);
        cars[0][row]+=0.01;
      } else {
        cars[1][row] = 10;
        cars[0][row] = 0.0;
      }
    } else if (cars[1][row] == 10) {
      if (cars[0][row] <=1.0) {
        fill(255, 0, 0);
        float x = curvePoint(points[8].x, points[9].x, points[10].x, points[11].x, cars[0][row]);
        float y = curvePoint(points[8].y, points[9].y, points[10].y, points[11].y, cars[0][row]);
        translate(x, y);
        float xTangent = curveTangent(points[8].x, points[9].x, points[10].x, points[11].x, cars[0][row]);
        float yTangent = curveTangent(points[8].y, points[9].y, points[10].y, points[11].y, cars[0][row]);
        stroke(255, 0, 0);
        strokeWeight(3);
        xTangent/=6;
        yTangent/=6;
        float angle = atan2(yTangent, xTangent);
        rotate(angle);
        triangle(0, -10, 0, 10, 25, 0);        
        ellipse(0, 0, 10, 10);
        cars[0][row]+=0.01;
      } else {
        cars[1][row] = 11;
        cars[0][row] = 0.0;
      }
    } else if (cars[1][row] == 11) {
      if (cars[0][row] <=1.0) {
        fill(255, 0, 0);
        float x = curvePoint(points[9].x, points[10].x, points[11].x, points[0].x, cars[0][row]);
        float y = curvePoint(points[9].y, points[10].y, points[11].y, points[0].y, cars[0][row]);
        translate(x, y);
        float xTangent = curveTangent(points[9].x, points[10].x, points[11].x, points[0].x, cars[0][row]);
        float yTangent = curveTangent(points[9].y, points[10].y, points[11].y, points[0].y, cars[0][row]);
        stroke(255, 0, 0);
        strokeWeight(3);
        xTangent/=6;
        yTangent/=6;
        float angle = atan2(yTangent, xTangent);
        rotate(angle);
        triangle(0, -10, 0, 10, 25, 0);        
        ellipse(0, 0, 10, 10);
        cars[0][row]+=0.01;
      } else {
        cars[1][row] = 12;
        cars[0][row] = 0.0;
      }
    } else if (cars[1][row] == 12) {
      if (cars[0][row] <=1.0) {
        fill(255, 0, 0);
        float x = curvePoint(points[10].x, points[11].x, points[0].x, points[1].x, cars[0][row]);
        float y = curvePoint(points[10].y, points[11].y, points[0].y, points[1].y, cars[0][row]);
        translate(x, y);
        float xTangent = curveTangent(points[10].x, points[11].x, points[0].x, points[1].x, cars[0][row]);
        float yTangent = curveTangent(points[10].y, points[11].y, points[0].y, points[1].y, cars[0][row]);
        stroke(255, 0, 0);
        strokeWeight(3);
        xTangent/=6;
        yTangent/=6;
        float angle = atan2(yTangent, xTangent);
        rotate(angle);
        triangle(0, -10, 0, 10, 25, 0);        
        ellipse(0, 0, 10, 10);
        cars[0][row]+=0.01;
      } else {
        cars[1][row] = 1;
        cars[0][row] = 0.0;
      }
    }
    // popMatrix and pushMatrix work together to reset translate and rotate functions
    popMatrix();
    noFill();
  }
}