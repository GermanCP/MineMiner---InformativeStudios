class Market{
  //variables
    float woodPrize  = 0.5;  //only prize which does not get simulated
  float stonePrize;
  float ironPrize;
  float goldPrize;
  float diamondPrize;
  
  float stoneRange   = 10;
  float ironRange    = 10;
  float goldRange    = 10;
  float diamondRange = 10;
  
  float stoneBase    = 1;
  float ironBase     = 3;
  float goldBase     = 8;
  float diamondBase  = 15;
  
  float[] xoff   = {0, 0, 0, 0}; //offsets
  float[] change = {.05, .1, .04, .01};
  
  //--------------------------------------------------------------------------------------------------
  //constructor
 Market(){
   
 }
 
 //--------------------------------------------------------------------------------------------------
 //method body
 void show(){
   
 }
 
 //--------------------------------------------------------------------------------------------------
 //calculate prizes
 void updatePrizes(){
   for(int i = 0; i < xoff.length; i++){
     xoff[i] = xoff[i] + change[i];
   }
   
   //calculating marketprizes based on perlin noise
   stonePrize   = round( noise(xoff[0]) * stoneRange   + stoneBase);
   ironPrize    = round( noise(xoff[1]) * ironRange    + ironBase);
   goldPrize    = round( noise(xoff[2]) * goldRange    + goldBase);
   diamondPrize = round( noise(xoff[3]) * diamondRange + diamondBase);
   
   //limiting xoff values
   if(xoff[0] == 20){
    for(int i = 0; i < xoff.length; i++){
      xoff[i] = 0;
    }
   }
 }
}