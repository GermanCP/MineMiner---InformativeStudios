class Animations {
  //variables
  public int time = 0;
  public int inc  = 5;
  
  public int inttime = 0;
  public int intshow = 255;
  public int intinc  = 10;
  public int introLimit = 1000;

  //--------------------------------------------------------------------------------------------------
  //constructor
  Animations() {
  }

  //--------------------------------------------------------------------------------------------------
  //methods
  void respawnTimer() {
    time += inc;

    if (mainMap == overworld) {
      mainMap.show(true);
    } else {
      background(0);
      mainMap.show(false);
    }

    player1.show();
    mainUI.deathScreen();

    fill(255, 255, 255, time);
    rect(0, 0, width, height);
  }
  
  void introTimer(){
   inttime += intinc;
   intshow -= intinc;
   
   if(intshow <= 0){
     intshow = 0;
   }
   fill(0, 0, 0, intshow);
   rect(0, 0, width, height);
   
   if(inttime >= introLimit){
     state = 0;
   }
  }
}