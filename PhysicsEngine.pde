class PhysicsEngine{
  Sphere[] spheres = new Sphere[4];

  PhysicsEngine(){
    spheres[0] = new Sphere();
    spheres[0].setPosition(new PVector(100,400));
    spheres[0].setVelocity(new PVector(1,-1));
    spheres[0].setRadius(35);
    
    spheres[1] = new Sphere();
    spheres[1].setPosition(new PVector(400,400));
    spheres[1].setVelocity(new PVector(-1,-1));
    spheres[1].setRadius(35);
    
    spheres[0].setColour(color(150,0,0));
    spheres[1].setColour(color(0,0,150)); 
    
    spheres[2] = new Sphere();
    spheres[2].setPosition(new PVector(100,100));
    spheres[2].setVelocity(new PVector(3,-0.5));
    spheres[2].setRadius(35);
    
    spheres[3] = new Sphere();
    spheres[3].setPosition(new PVector(400,100));
    spheres[3].setVelocity(new PVector(-2,1));
    spheres[3].setRadius(35);
    
    spheres[2].setColour(color(150,0,0));
    spheres[3].setColour(color(0,0,150));
  }

  void show(){
    for(Sphere s : spheres){
      s.show();
    }
  }

  void update(){
    boundaryCollisions();

    //Change colour of spheres if colliding
    for(int i = 0; i < spheres.length; i++){
      Sphere s1 = spheres[i];
      for(int j = i+1; j < spheres.length; j++){
        Sphere s2 = spheres[j];

        if(spheresColliding(s1, s2)){
          collideSpheres(s1, s2);
        }
      }
    }

    for(Sphere s : spheres){
      s.updatePosition();
    }
  }
  
  void collideSpheres(Sphere _s1, Sphere _s2){
    //a is alpha
    float a = atan((_s2.pos.y - _s1.pos.y)/(_s2.pos.x - _s1.pos.x));
    //(a < 0) a += PI;

    //Perpendicular and parallel components of initial velocity
    float uPerp1 = (_s1.vel.x*cos(a)) + (_s1.vel.y*sin(a));
    float uPara1 = (_s1.vel.x*sin(a)) - (_s1.vel.y*cos(a));

    float uPerp2 = (_s2.vel.x*cos(a)) + (_s2.vel.y*sin(a));
    float uPara2 = (_s2.vel.x*sin(a)) - (_s2.vel.y*cos(a));

    //Perpendicular component of final velocity, without masses or e
    float vPerp1 = ((2*uPerp2)+(0*uPerp1))/(2);
    float vPerp2 = ((2*uPerp1)+(0*uPerp2))/(2);

    //Final velocities
    _s1.vel.x = (uPara1*sin(a)) + (vPerp1*cos(a));
    _s1.vel.y = (vPerp1*sin(a)) - (uPara1*cos(a));

    _s2.vel.x = (uPara2*sin(a)) + (vPerp2*cos(a));
    _s2.vel.y = (vPerp2*sin(a)) - (uPara2*cos(a));
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
