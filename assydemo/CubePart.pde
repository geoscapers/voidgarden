
class CubePart extends PlantPart {
  
  void doInit(RandomSequence random) {
  }
  
  void drawPart(PlantContext context, RandomSequence random) {
    float size =context.age+0.2;
    fill(200, 0, 70);
    translate(0, -size/2,0);
    box(size,size,size);
  }
  
  
  void drawCylinder(){
  
  }

}
