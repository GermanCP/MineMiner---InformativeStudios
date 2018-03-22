class Marker{
  //variables
  private PVector pos = new PVector();
  
  private float r;
  
  //--------------------------------------------------------------------------------------------------
  //constructor
  
  Marker(float x_, float y_, float r_){
    this.pos.x = x_;
    this.pos.y = y_;
    
    this.r = r_; 
  }
  
  //--------------------------------------------------------------------------------------------------
  //methods
  
  void show(){ //shows a blue circle at this.pos
    util.marker();
    ellipse(this.pos.x, this.pos.y, this.r, this.r);
  }
  
  //--------------------------------------------------------------------------------------------------
  //get methods
  
  PVector getPos(){
   return this.pos; 
  }
}