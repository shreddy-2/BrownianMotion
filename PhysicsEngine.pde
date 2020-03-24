class PhysicsEngine{
  Sphere[] spheres = new Sphere[10];

  PhysicsEngine(){
    for(int i = 0; i < spheres.length; i++){
      spheres[i] = new Sphere();
      spheres[i].setRandomPosition();
      spheres[i].setRadius(20);
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
      s.setColour(color(150,150,150));
    }

    //Change colour of spheres if colliding
    for(Sphere s1 : spheres){
      for(Sphere s2 : spheres){
        if(s1 == s2) continue;

        if(spheresColliding(s1, s2)){
          s1.setColour(color(200,0,0));
        }
      }
    }

    for(Sphere s : spheres){
      s.updatePosition();
    }
  }

  boolean spheresColliding(Sphere _s1, Sphere _s2){
    if(PVector.dist(_s1.pos, _s2.pos) < _s1.radius + _s2.radius){
      return true;
    }else{
      return false;
    }
  }

  void boundaryCollisions(){
    for(Sphere s : spheres){
      //If off the edge of the screen, make sure moving towards center
      if(s.pos.x - s.radius <= 0){
        if(s.vel.x < 0){
          s.vel.x *= -1;
        }
      }
      if(s.pos.x + s.radius >= width){
        if(s.vel.x > 0){
          s.vel.x *= -1;
        }
      }

      //If off the edge of the screen, make sure moving towards center
      if(s.pos.y - s.radius <= 0){
        if(s.vel.y < 0){
          s.vel.y *= -1;
        }
      }
      if(s.pos.y + s.radius >= height){
        if(s.vel.y > 0){
          s.vel.y *= -1;
        }
      }
    }
  }
}