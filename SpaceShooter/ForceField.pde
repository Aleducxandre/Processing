class ForceField {
  String state = "Full";
  float x=width/2, y=height/2;
  int r = 200;

  ForceField() {
  }

  Enemies collisionDetection(Enemies e) {
    stroke(255);
    if (dist(width/2, height/2, e.xPos, e.yPos) < 115) {
      return e;
    }
    return null;
  }

  void drawShield() {
    if (state.equals("Full")) {
      pushMatrix();
      noFill();
      stroke(0, 255, 0);
      strokeWeight(2);
      ellipseMode(CENTER);
      translate(width/2, height/2);
      ellipse(0, 0, r, r);
      popMatrix();
    } else if (state.equals("Damaged")) {
      pushMatrix();
      noFill();
      strokeWeight(2);
      stroke(150, 69, 0);
      ellipseMode(CENTER);
      translate(width/2, height/2);
      ellipse(0, 0, r, r);
      popMatrix();
    } else if (state.equals("Failing")) {
      pushMatrix();
      noFill();
      strokeWeight(2);
      stroke(255, 0, 0);
      ellipseMode(CENTER);
      translate(width/2, height/2);
      ellipse(0, 0, r, r);
      popMatrix();
    } else {
      //do nada
    }
  }

  void healthUp() {
    if (state.equals("Failing")) {
      state = "Damaged";
    } else if (state.equals("Damaged")) {
      state = "Full";
    } else if (state.equals("Nill")) {
      state = "Failing";
    }
  }

  void collision() {
    if (state.equals("Full")) {
      state = "Damaged";
    } else if (state.equals("Damaged")) {
      state = "Failing";
    } else if (state.equals("Failing")) {
      state = "Nill";
    }
  }
}