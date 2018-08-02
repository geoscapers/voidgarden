
Plant testPlant;


void setupPlanz(){
  testPlant = new Plant();
  
} 


void drawPlannz(){
  testPlant.drawPlant();  
  
}
  
  
class Plant{
  PVector groundPos;
  
  
  Plant(){
     groundPos = new PVector(100, 100, 0);
  }  
  
  
  void drawPlant(){
    pushMatrix();
    translate(groundPos.x, groundPos.y, groundPos.z);
    noFill();
    stroke(255);
    sphere(5);
    popMatrix();
    
  }  
  
  
}

class Branch{
  PVector startPos;
  ArrayList<PVector> pointList;
  PVector growDirection;
  
  Branch(PVector startPos, ArrayList<PVector> pointList, PVector growDirection){
    this.startPos = startPos;
    this.pointList = pointList;
    this.growDirection = growDirection;
  }  
  
  
  
  
}  
