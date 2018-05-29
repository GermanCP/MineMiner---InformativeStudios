class Datamanagement {
  //variables
  JSONObject questingData;
  
  //--------------------------------------------------------------------------------------------------
  //constructor
  Datamanagement() {
    this.questingData = loadJSONObject("../json/data/questing.json");
    
    //getting all data from the file
    //int woodmined    = questingData.getInt("woodmined");
    
    //mined
    questingData.setInt("woodmined", 0);
    questingData.setInt("stonemined", 0);
    questingData.setInt("ironmined", 0);
    questingData.setInt("goldmined", 0);
    questingData.setInt("diamondmined", 0);
    
    //sold
    questingData.setInt("woodsold", 0);
    questingData.setInt("stonesold", 0);
    questingData.setInt("ironsold", 0);
    questingData.setInt("goldsold", 0);
    questingData.setInt("diamondsold", 0);
    
    //coins
    questingData.setFloat("coinsAquired", 0);
    
    update();
  }
  
  void update(){
    saveJSONObject(questingData, "../json/data/questing.json");
  }
}
