class Box {
  //variables
  private int type = 0;
  private int size;

  private float threshold = 150;

  private boolean mineable     = true;
  private boolean interactable = false;

  private PVector pos  = new PVector();
  private PVector posM = new PVector();

  //--------------------------------------------------------------------------------------------------
  //constructor
  Box(int type_, int size_, float x_, float y_) {
    this.type = type_;
    this.size = size_;

    this.pos.x = x_;
    this.pos.y = y_;

    this.posM.x = x_ + (size_ / 2);
    this.posM.y = y_ + (size_ / 2);

    if (type >= 100) {
      this.mineable = false;
      this.interactable = true;
    } else {
      this.mineable = true;
      this.interactable = false;
    }
    
    //unmineable objects
    switch(type_){
      case 7:  //water
      case 8:  //lava
      
      mineable = false;
      break;
      default:
      break;
    }
  }

  //--------------------------------------------------------------------------------------------------
  //show
  void show(boolean init) {
    if (nearPlayer() || init) {
      util.mapDebugTheme();
      if (type == 1) {
        //show different pavement when map changes
        if (mainMap == overworld) {
          image(grass, this.pos.x, this.pos.y, this.size, this.size);
        } else {
          image(pavement, this.pos.x, this.pos.y, this.size, this.size);
        }
      } else if (type == 2) {
        image(stone, this.pos.x, this.pos.y, this.size, this.size);
      } else if (type == 3) {
        image(iron_ore, this.pos.x, this.pos.y, this.size, this.size);
      } else if (type == 4) {
        image(gold_ore, this.pos.x, this.pos.y, this.size, this.size);
      } else if (type == 5) {
        image(diamond_ore, this.pos.x, this.pos.y, this.size, this.size);
      } else if (type == 6) {
        image(forest, this.pos.x, this.pos.y, this.size, this.size);
      } else if (type == 7) {
        image(water, this.pos.x, this.pos.y, this.size, this.size);
      } else if (type == 8) {
        image(lava, this.pos.x, this.pos.y, this.size, this.size);
        
        //buildings
      } else if (type == 100) {
        image(market, this.pos.x, this.pos.y, this.size, this.size);
      } else {
        rect(this.pos.x, this.pos.y, this.size, this.size);
      }
    }
  }

  //--------------------------------------------------------------------------------------------------
  //method body
  boolean nearPlayer() {
    if (this.pos.dist(player1.pos) <= threshold) {
      return true;
    }
    return false;
  }

  //--------------------------------------------------------------------------------------------------
  //get and set methods
  int getType() {
    return this.type;
  }

  void setType(int type_) {
    this.type = type_;
  }
}