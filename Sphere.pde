class Sphere{
  PVector pos = new PVector();
  PVector vel = new PVector();
  int radius;
  color colour = color(150, 150, 150);

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

//-------------SETTERS--------------------
  void setPosition(PVector _pos){
    pos = _pos;
  }

  void setRandomPosition(){
    pos.x = random(1.5*radius, width);
    pos.y = random(1.5*radius, height);
  }

  void setVelocity(PVector _vel){
    vel = _vel;
  }

  void setRandomVelocity(){
    vel = PVector.random2D();
    vel.mult(3);
  }

  void setRadius(int _radius){
    radius = _radius;
  }

  void setColour(color _colour){
    colour = _colour;
  }
}