class Inventory {
  //--------------------------------------------------------------------------------------------------
  //variables
  private ArrayList<Item> stone   = new ArrayList<Item>();
  private ArrayList<Item> iron    = new ArrayList<Item>();
  private ArrayList<Item> gold    = new ArrayList<Item>();
  private ArrayList<Item> diamond = new ArrayList<Item>();
  private ArrayList<Item> wood    = new ArrayList<Item>();

  private ArrayList<ArrayList> arrays = new ArrayList<ArrayList>();

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
    arrays.add(stone);
    arrays.add(iron);
    arrays.add(gold);
    arrays.add(diamond);
    arrays.add(wood);
  }

  //--------------------------------------------------------------------------------------------------
  //main method body
  void add(Item tmp) {
    switch(tmp.type) {
    case 2:
      stone.add(tmp);

      //updating stats
      data.questingData.setInt("stonemined", data.questingData.getInt("stonemined") + 1);
      data.update();
      break;
    case 3:
      iron.add(tmp);

      //updating stats
      data.questingData.setInt("ironmined", data.questingData.getInt("ironmined") + 1);
      data.update();
      break;
    case 4:
      gold.add(tmp);

      //updating stats
      data.questingData.setInt("goldmined", data.questingData.getInt("goldmined") + 1);
      data.update();
      break;
    case 5:
      diamond.add(tmp);

      //updating stats
      data.questingData.setInt("diamondmined", data.questingData.getInt("diamondmined") + 1);
      data.update();
      break;
    case 6:
      wood.add(tmp);

      //updating stats
      data.questingData.setInt("woodmined", data.questingData.getInt("woodmined") + 1);
      data.update();
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

  void clear() {
    for (ArrayList a : arrays) {
      while (a.size() > 0) {
        a.remove(0);
      }
    }
  }

  //--------------------------------------------------------------------------------------------------
  //sell functions
  void sell(String type) {  //sell the selected item for the current market prize
    switch(type) {
    case "wood" :
      if (wood.size() > 0) {
        wood.remove(0);
        player1.addCoins(shop.woodPrize);

        //updating stats
        data.questingData.setInt("woodsold", data.questingData.getInt("woodsold") + 1);
        data.update();
      }
      break;
    case "stone":
      if (stone.size() > 0) {
        //selling 1 stone
        stone.remove(0);
        player1.addCoins(shop.stonePrize);

        //updating stats
        data.questingData.setInt("stonesold", data.questingData.getInt("stonesold") + 1);
        data.update();
      }
      break;
    case "iron":
      if (iron.size() > 0) {
        //selling 1 iron
        iron.remove(0);
        player1.addCoins(shop.ironPrize);

        //updating stats
        data.questingData.setInt("ironsold", data.questingData.getInt("ironsold") + 1);
        data.update();
      }
      break;
    case "gold":
      if (gold.size() > 0) {
        //selling 1 gold
        gold.remove(0);
        player1.addCoins(shop.goldPrize);

        //updating stats
        data.questingData.setInt("goldsold", data.questingData.getInt("goldsold") + 1);
        data.update();
      }
      break;
    case "diamond":
      if (diamond.size() > 0) {
        //selling 1 diamond
        diamond.remove(0);
        player1.addCoins(shop.diamondPrize);

        //updating stats
        data.questingData.setInt("diamondsold", data.questingData.getInt("diamondsold") + 1);
        data.update();
      }
      break;
    }
  }
}
