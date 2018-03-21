class Experience{
  //variables
  int level  = 0;
  
  float exp    = 0;
  float target = 0;
  float increment = 0.4;
  
  //--------------------------------------------------------------------------------------------------
  //constructor
  Experience(){
    
  }
  
  //--------------------------------------------------------------------------------------------------
  //methods
  void checkExperience(){
   if(exp >= target){
     exp -= target;
     target = newTarget();
     level++;
   }
  }
  
  float newTarget(){
    return target + target * increment;
  }
}