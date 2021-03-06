class Branch extends PlantPart {
  PlantPart tip = null;
  PlantPart branch = null;
  
  PVector endPos;
  int sideAmount = 12;
  float maxBrancHeight = 70;
  float branchMaxWidth = 0.8;
  float minWidth = 0.05;
  float branchChange = branchMaxWidth-minWidth;
  float maxOfset = 0.4;
  color branchColor = color(222,184,135);
  int brancHeight = 0;
  float branchStep = 1;
  PVector branchEndPos = new PVector(0,0,0);
  int numberOfBranches = 10;


  float branchesInGrowDirection = 0.3;
  
  
  Branch(PlantPart tip, PlantPart branch){
    this(tip, branch, 0.3f, 20f, 70f);
  }
  
  Branch(PlantPart tip, PlantPart branch, float branchesInGrowDirection, float numBranches, float branchLength){
    this.tip = tip;
    this.branch = branch;
    this.branchesInGrowDirection = branchesInGrowDirection;
    this.maxBrancHeight = branchLength;
    this.numberOfBranches = max(0, (int)numBranches);
  }  
  
   Branch(float branchLength, color branchColor, float maxWidth, float minWidth){
    this.maxBrancHeight = branchLength;
    this.numberOfBranches = 0;
    this.branchColor = branchColor;
    this.branchMaxWidth = branchMaxWidth;
    this.minWidth = minWidth;
    float branchChange = branchMaxWidth-minWidth;
    
  }  
  
  void doInit(RandomSequence random) {
  }
  
  void drawPart(PlantContext context, RandomSequence random) {
    noStroke();
    drawBranch(context,random);
    pushMatrix();
    translate(branchEndPos.x, branchEndPos.y, branchEndPos.z);
    scale(-0.1*context.age);
    
    if (tip != null) tip.drawPart(context,random.nextRandom());
    popMatrix();
    
    
  }  
  
  void drawBranch(PlantContext context, RandomSequence random) {
    float xofset = 0;
    float yofset = 0;
    brancHeight = (int) mapClamp(context.age, 0f, 0.5f, 0f, maxBrancHeight);
    float prevR = context.age*(pow(1, 1.2)*(branchChange))*(brancHeight/maxBrancHeight)+ minWidth;
    float prevOfsetx = 0;
    float prevOfsety = 0;
    float prevY  = 0;
    
    float branchingAngle = random.nextFloat(2*PI);
    final float PHI = 2.3999632f;
    
    
    PlantContext branchContext = context.copy();
    
    int stepsBetweenBranch = numberOfBranches <= 0 ? MAX_INT : (int)maxBrancHeight/numberOfBranches;
    int stepsUntilNext = stepsBetweenBranch+((int)random.nextFloat(4));
    
    for (int i = 1; i <= brancHeight; i += 1){     
      float branchToTop = ((float)(brancHeight-i)/brancHeight);
      float r =  context.age*(pow((((float)brancHeight-i)/brancHeight), 1.2)*(branchChange))*pow(branchToTop, 1.5)+ minWidth;
      xofset += (random.nextFloat(2*maxOfset)-maxOfset)*pow(context.age, 2)*branchToTop*branchToTop;
      yofset += (random.nextFloat(2*maxOfset)-maxOfset)*pow(context.age, 2)*branchToTop*branchToTop;
      float ystep = branchStep*context.age*pow(branchToTop,2);
      float y = prevY-ystep;
      drawLayer(prevY, y,prevR*context.age,r*context.age, prevOfsetx, prevOfsety,xofset, yofset );
      prevR = r;
      prevOfsetx = xofset;
      prevOfsety = yofset;
      
      // Add side branch
      float minAgeForChildBranches = 0.1;
      if (stepsUntilNext <= 0 && branch != null && context.age >= minAgeForChildBranches) {
          pushMatrix();
          translate(branchEndPos.x, branchEndPos.y, branchEndPos.z);
          scale(0.9);
          
          // Rotate around tree
          //rotateY(random.nextFloat(2*PI));
          rotateY(branchingAngle);
          branchingAngle += PHI;
          
          // Rotate out from tree
          rotateX((branchesInGrowDirection)*PI+random.nextGaussishFloat(0f, 0.4f));
          
          branchContext.age = mapClamp(context.age, 0.3, 1f, 0.2, 0.8) * (pow(branchToTop, 1.5));
          branch.drawPart(branchContext, random.nextRandom());
          stepsUntilNext = stepsBetweenBranch + random.nextInt(0, 3);
          popMatrix();
      }
      
      stepsUntilNext --;
      
      
      prevY = y;
      
    }  
    
  }
  
  
  
  
  void drawLayer(float prevY, float y, float prevR, float r, float prevOfsetx, float prevOfsety, float xofset, float yofset){
    beginShape(TRIANGLE_STRIP);
    fill(branchColor);
    for(int i = 0; i < sideAmount+1; i +=1){
      drawVertex(i,y,r,xofset,yofset);
      drawVertex(i,prevY,prevR,prevOfsetx,prevOfsety);
    }  
    
    endShape(TRIANGLE_STRIP);
  }  
  
  void drawVertex(float i, float y,  float r, float xofset, float yofset){
      float a = i*1/(sideAmount+0.001);
      float x = cos(2*PI*a)*r+ xofset;
      float z = sin(2*PI*a)*r + yofset;
      
      vertex(x, y, z);     
      branchEndPos.x = x;
      branchEndPos.y = y;
      branchEndPos.z = z;
      
  }
  
  
}
