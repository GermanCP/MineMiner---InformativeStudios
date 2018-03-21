class Item {
  //--------------------------------------------------------------------------------------------------
  //variables
  private int type;
  
  public String itemClass = null;

  //--------------------------------------------------------------------------------------------------
  //constructor
  Item(int type_) {
    this.type = type_;
    
    determineClass(type_);
  }

  //--------------------------------------------------------------------------------------------------
  //main method body
  void determineClass(int type_){
    switch(type_){
      case 2:
      case 6:
      //basic materials
      itemClass = "basic";
      break;
      case 3:
      case 4:
      //metals
      itemClass = "metals";
      break;
      case 5:
      //gems
      itemClass = "gems";
      break;
      default:
      break;
    }
  }

  //--------------------------------------------------------------------------------------------------
  //get methods
}