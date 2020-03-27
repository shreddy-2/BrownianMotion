class PhysicsEngine{
  Sphere[] spheres;

  PhysicsEngine(){
    int num = 50;
    
    initialiseSpheres(num);
    
    //Adds big sphere
    /*
    spheres[num] = new Sphere();
    spheres[num].setPosition(new PVector(400,400));
    spheres[num].setVelocity(new PVector(0,0));
    spheres[num].setMass(50);
    spheres[num].setRadius(40);
    spheres[num].setColour(color(200,0,0));
    */
  }

  void show(){
    for(Sphere s : spheres){
      s.show();
    }
  }

  void update(){
    boundaryCollisions();

    
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
    float e = 1;
    float m1 = _s1.mass;
    float m2 = _s2.mass;

    //a is alpha
    float a = atan((_s2.pos.y - _s1.pos.y)/(_s2.pos.x - _s1.pos.x));
    if(a < 0) a += PI;

    //Perpendicular and parallel components of initial velocity
    float uPerp1 = (_s1.vel.x*cos(a)) + (_s1.vel.y*sin(a));
    float uPara1 = (_s1.vel.x*sin(a)) - (_s1.vel.y*cos(a));

    float uPerp2 = (_s2.vel.x*cos(a)) + (_s2.vel.y*sin(a));
    float uPara2 = (_s2.vel.x*sin(a)) - (_s2.vel.y*cos(a));

    //Perpendicular component of final velocity, without masses or e
    float vPerp1 = (((1+e)*m1*uPerp2)+((m1-(e*m2))*uPerp1))/(m1+m2);
    float vPerp2 = (((1+e)*m2*uPerp1)+((m2-(e*m1))*uPerp2))/(m1+m2);;

    //Final velocities
    //If already moving away from each other, no need to change their velocities
    if(_s1.pos.y < _s2.pos.y && _s1.vel.y < 0){        //above and moving up
    }else if(_s1.pos.y > _s2.pos.y && _s1.vel.y > 0){  //below and moving down
    }else if(_s1.pos.x < _s2.pos.x && _s1.vel.x < 0){  //to the left and moving left
    }else if(_s1.pos.x > _s2.pos.x && _s1.vel.x > 0){  //to the right and moving right
    }else{                                             //If none of the above is true, change velocity
      _s1.vel.x = (uPara1*sin(a)) + (vPerp1*cos(a));
      _s1.vel.y = (vPerp1*sin(a)) - (uPara1*cos(a));
    }

    if(_s2.pos.y < _s1.pos.y && _s2.vel.y < 0){        //above and moving up
    }else if(_s2.pos.y > _s1.pos.y && _s2.vel.y > 0){  //below and moving down
    }else if(_s2.pos.x < _s1.pos.x && _s2.vel.x < 0){  //to the left and moving left
    }else if(_s2.pos.x > _s1.pos.x && _s2.vel.x > 0){  //to the right and moving right
    }else{                                             //If none of the above is true, change velocity
      _s2.vel.x = (uPara2*sin(a)) + (vPerp2*cos(a));
      _s2.vel.y = (vPerp2*sin(a)) - (uPara2*cos(a));
    }
  }

  boolean spheresColliding(Sphere _s1, Sphere _s2){
    if(PVector.dist(_s1.pos, _s2.pos) < _s1.radius + _s2.radius){
      return true;
    }else{
      return false;
    }
  }

  void initialiseSpheres(int _num){
    //Starts spheres in a grid

    //This is if you want a big sphere
    //spheres = new Sphere[_num + 1];
    //This is if you don't
    spheres = new Sphere[_num];

    int spacing = 50;
    int cols = width / spacing;
    int rows = height / spacing;

    int counter = 0;
    for(int x = 0; x < cols; x++){ //<>//
      for(int y = 0; y < rows; y++){
        if(counter >= _num) break;

        spheres[counter] = new Sphere();
        spheres[counter].setPosition(new PVector(x*spacing, y*spacing));
        spheres[counter].setRandomVelocity();
        spheres[counter].setRadius(10);
        spheres[counter].setMass(1);

        counter++;
      }
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
