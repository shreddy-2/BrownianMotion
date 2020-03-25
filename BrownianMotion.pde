PhysicsEngine engine;


void setup(){
  size(500, 500);
  
  engine  = new PhysicsEngine();
}

void draw(){
  background(200);

  engine.update();
  engine.show();
}
