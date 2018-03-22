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
  void determineClass(int type_){  //this method determines what class the item belongs to according to the type variable
    switch(type_){
      //basic materials
      case 2:
      case 6:
      itemClass = "basic";
      break;
      
      //metals
      case 3:
      case 4:
      itemClass = "metals";
      break;
      
      //gems
      case 5:
      itemClass = "gems";
      break;
      default:
      break;
    }
  }

  //--------------------------------------------------------------------------------------------------
  //get methods
}