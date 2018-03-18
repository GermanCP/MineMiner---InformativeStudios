class Animations {
  //variables
  public int time = 0;
  public int inc  = 5;

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
}