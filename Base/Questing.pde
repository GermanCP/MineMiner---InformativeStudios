class Questing {
  //variables
  int questID = 0;

  private String currentQuest = null;
  
  private String[][] quests  = {{"Go into the mine by walking to the market and pressing change world", "Mine 10 iron and 10 stone"},{"Go to the market and sell 20 stone and 20 iron"},{}};
  private String[] rewards   = {"20 exp points", "25 exp points"};
  //--------------------------------------------------------------------------------------------------
  //constructor
  Questing() {
  }

  //--------------------------------------------------------------------------------------------------
  //methods
  String returnQuest() {
    return currentQuest;
  }
}