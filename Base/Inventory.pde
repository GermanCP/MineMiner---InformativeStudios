class Inventory {
  //--------------------------------------------------------------------------------------------------
  //variables
  private ArrayList<Item> stone   = new ArrayList<Item>();
  private ArrayList<Item> iron    = new ArrayList<Item>();
  private ArrayList<Item> gold    = new ArrayList<Item>();
  private ArrayList<Item> diamond = new ArrayList<Item>();
  private ArrayList<Item> wood    = new ArrayList<Item>();

  private float weightLimit = 100;

  //weights
  private float stoneWeight   = 1;
  private float ironWeight    = 1.5;
  private float goldWeight    = 4;
  private float diamondWeight = 1.2;
  private float woodWeight    = 0.75;

  //upgrades
  private boolean size1 = false;
  private boolean size2 = false;
  private boolean size3 = false;

  //--------------------------------------------------------------------------------------------------
  //constructor
  public Inventory() {
  }

  //--------------------------------------------------------------------------------------------------
  //main method body
  void add(Item tmp) {
    switch(tmp.type) {
    case 2:
      stone.add(tmp);
      break;
    case 3:
      iron.add(tmp);
      break;
    case 4:
      gold.add(tmp);
      break;
    case 5:
      diamond.add(tmp);
      break;
    case 6:
      wood.add(tmp);
      break;
    default:
    }
  }

  boolean checkWeight() {  //checks if the weightlimit is reached, true when full
    if (calcWeight() >= weightLimit) {
      return true;
    }
    return false;
  }

  float calcWeight() {  //calculate the weight of all objects held
    float weight = 0;
    weight += stone.size()   * stoneWeight;
    weight += iron.size()    * ironWeight;
    weight += gold.size()    * goldWeight;
    weight += diamond.size() * diamondWeight;
    weight += wood.size()    * woodWeight;

    return weight;
  }


  //--------------------------------------------------------------------------------------------------
  //sell functions
  void sell(String type) {  //sell the selected item for the current market prize
    switch(type) {
    case "stone":
      if (stone.size() > 0) {
        //selling 1 stone
        stone.remove(0);
        player1.addCoins(shop.stonePrize);
      }
      break;
    case "iron":
      if (iron.size() > 0) {
        //selling 1 iron
        iron.remove(0);
        player1.addCoins(shop.ironPrize);
      }
      break;
    case "gold":
      if (gold.size() > 0) {
        //selling 1 gold
        gold.remove(0);
        player1.addCoins(shop.goldPrize);
      }
      break;
    case "diamond":
      if (diamond.size() > 0) {
        //selling 1 diamond
        diamond.remove(0);
        player1.addCoins(shop.diamondPrize);
      }
      break;
    }
  }
}