class Sphere{
  PVector pos = new PVector();
  PVector vel = new PVector();
  int radius;
  color colour = color(150, 150, 150);
  float mass;

  Sphere(){

  }

  void updatePosition(){
    pos.add(vel);
  }

  void show(){
    fill(colour);
    stroke(0);
    strokeWeight(1);
    ellipseMode(RADIUS);
    ellipse(pos.x, pos.y, radius, radius);
  }

  void showVelocity(){
    int x1 = int(pos.x); //<>//
    int y1 = int(pos.y);
    int x2 = int(pos.x + (vel.x*15));
    int y2 = int(pos.y + (vel.y*15));

    stroke(200,0,0);
    line(x1, y1, x2, y2);
    pushMatrix();
    translate(x2, y2);
    float a = atan2(x1-x2, y2-y1);
    rotate(a);
    line(0, 0, -5, -5);
    line(0, 0, 5, -5);
    popMatrix();
  }

//-------------SETTERS--------------------
  void setPosition(PVector _pos){
    pos = _pos;
  }

  void setRandomPosition(){
    pos.x = random(radius, width-radius);
    pos.y = random(radius, height-radius);
  }

  void setVelocity(PVector _vel){
    vel = _vel;
  }

  void setRandomVelocity(){
    vel = PVector.random2D();
    vel.mult(2);
  }

  void setRadius(int _radius){
    radius = _radius;
  }

  void setColour(color _colour){
    colour = _colour;
  }

  void setMass(float _mass){
    mass = _mass;
  }
}
