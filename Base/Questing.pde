//will be reworked with new JSON-files

class Questing {
  //variables
  int questID = 0;

  private String currentQuest = null;
  
  private String[] quests  = {"Go into the mine by walking to the market and pressing change world", "Mine 10 iron and 10 stone","Go to the market and sell 20 stone and 20 iron"};
  private String[] rewards = {"20 exp points", "25 exp points"};
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
<<<<<<< HEAD

/* give for UI:
number of questDiscribtions
quest difficulty
number of tasks (in UI, define whats a task)
rewards (coins, xp, [item?]);
=======
>>>>>>> b9641a7c765da32cd0093d77b504ee436468a245
