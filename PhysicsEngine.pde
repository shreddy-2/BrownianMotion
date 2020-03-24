class PhysicsEngine{
  Sphere[] spheres = new Sphere[5];

  PhysicsEngine(){
    for(int i = 0; i < spheres.length; i++){
      spheres[i] = new Sphere();
      spheres[i].setRandomPosition();
      spheres[i].setRadius(35);
      spheres[i].setRandomVelocity();
    }
  }

  void show(){
    for(Sphere s : spheres){
      s.show();
    }
  }

  void update(){
    boundaryCollisions();

    for(Sphere s : spheres){
      s.updatePosition();
    }
  }

  void boundaryCollisions(){
    for(Sphere s : spheres){
      //If off the edge of the screen, swap x direction
      if(s.pos.x - s.radius <= 0 || s.pos.x + s.radius >= width){
        s.vel.x *= -1;
      }

      //If off the edge of the screen, swap y direction
      if(s.pos.y - s.radius <= 0 || s.pos.y + s.radius >= height){
        s.vel.y *= -1;
      }
    }
  }
}