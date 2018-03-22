class Player {

  //movement via mouse has been removed!
  //movement via arrow-keys, mouse for interactions with UI etc.

  //variables for movement
  private PVector dir     = new PVector(0, 0);
  private PVector newPos  = new PVector();
  private PVector pos     = new PVector();
  private PVector gridPos = new PVector();
  private PVector look    = new PVector();

  private Inventory inv;

  private int coins;

  public int toolID = 0;

  private float r;
  private float lavaDamage = 0.25; //damage per tick
  private float slow       = 1;
  private float normal     = 3;
  private float fast       = 4;
  private float speed;

  public  float health     = 100;

  private boolean pickaxe = false;
  private boolean wrench  = false;
  private boolean hand    = true;

  //upgrades
  private boolean divingLv1 = false;
  private boolean divingLv2 = false;  

  private Box cBox         = null;
  public Experience expSys = new Experience();

  //---------------------------------------------------------------------------
  //constructor  
  Player(float x_, float y_, float r_, int coins_) {
    this.pos.x = x_;
    this.pos.y = y_;

    this.inv = new Inventory();

    this.coins = coins_;
    this.r = r_;

    this.speed = this.normal;
  }

  //---------------------------------------------------------------------------
  //main method body
  void move(PVector arg) { //updating the players movement
    this.dir = arg;

    //update rotation of player graphic
    if (dir.x != 0 || dir.y != 0) {
      this.look.x = dir.x;
      this.look.y = dir.y;
    }

    this.newPos.x = this.pos.x;
    this.newPos.y = this.pos.y;

    this.dir.setMag(speed);
    this.newPos.add(dir);

    if (checkCollision()) {
      //collision
    } else {
      //no collision
      this.pos.x = this.newPos.x;
      this.pos.y = this.newPos.y;
    }

    calcGridPos();
  }

  private boolean checkCollision() { //checks if player is colliding with anything
    String border = checkBorders();
    if (border != "none") { //border check
      if (border == "left" && mainMap.left) {
        //move to next map to the left
        return this.moveMap("left");
      } else if (border == "right" && mainMap.right) {
        //move to next Map to the right
        return this.moveMap("right");
      } else if (border == "up" && mainMap.up) {
        //move to next Map up
        return this.moveMap("up");
      } else if (border == "down" && mainMap.down) {
        //move to the next Map down
        return this.moveMap("down");
      } else {
        return true;
      }
      //------------------------------------------------
      //other checks
    } else if (checkBoxes(newPos, mainMap) == 1) {
      return true;
    } else if (checkBoxes(newPos, mainMap) == 2) { //player is in water
      this.speed = this.slow;
      return false;
    } else if (checkBoxes(newPos, mainMap) == 3) {
      this.speed = this.slow;
      this.health -= this.lavaDamage;
      return false;
    } else {
      this.speed = this.normal;
      return false;
    }
  }

  //--------------------------------------------------------------------------------------------------
  //move between maps
  boolean moveMap(String arg) {  //moves the player to an adjacent map
    int index;
    index = mainMap.id;

    switch(arg) {
    case "left":
      index--;
      this.newPos.x += width - r / 2;
      break;

    case "right":
      index++;
      this.newPos.x -= width - r / 2;
      break;

    case "up":
      index -= mainMap.size.x;
      this.newPos.y += height - (r / 2 + mainUI.y_UI_botStroke);
      break;

    case "down":
      index += mainMap.size.x;
      this.newPos.y -= height - ((r / 2) + mainUI.y_UI_botStroke);
      break;

    default:
      return false;
    }

    changeMaptoIndex(index);
    return true;
  }


  void changeMaptoIndex(int index_) {  //changes the mainMap to a map with the given index
    if (mainMap.type == "underworld" && checkBoxes(newPos, underworld[index_]) != 1) {
      mainMap = underworld[index_];
    } else {
      return;
    }

    //update position
    this.pos.x = this.newPos.x;
    this.pos.y = this.newPos.y;
  }

  //--------------------------------------------------------------------------------------------------
  //death
  void checkDeath() {
    if (this.health <= 0) {
      noLoop();
      inv.clear();
      mainUI.deathScreen();
      this.coins = this.coins / 2;
    }
  }

  void respawn() {      //respawn
    //revive and start program
    this.health = 100;
    respawned = true;
    anim.time = 0;
    loop();
  }

  //--------------------------------------------------------------------------------------------------
  //collision checking
  int checkBoxes(PVector tmp_, Map map) {    //detect whether any box is too close to the player and he is colliding
    for (Box b : map.boxes) {
      if (tmp_.dist(b.posM) <= r * 0.75 && b.type != 1 && b.type != 7 && b.type != 8) { //solid block
        return 1;
      } else if (tmp_.dist(b.posM) <= r * 0.5 && b.type == 7) {  //water
        return 2;
      } else if (tmp_.dist(b.posM) <= r * 0.5 && b.type == 8) {  //lava
        return 3;
      }
    }
    return 0;
  }

  String checkBorders() {  //checking whether the player has reached the border of the screen, if so, pause movement in a certain direction
    if (this.newPos.x <= 0) {
      //left border reached 
      return "left";
    }
    if (this.newPos.x >= width) {
      //right border reached
      return "right";
    }
    if (this.newPos.y <= mainUI.y_UI_botStroke + player1.r / 2) {
      //upper border reached
      return "up";
    }
    if (this.newPos.y >= mainUI.y_UI_debug_topStroke - player1.r / 2 && mainUI.showDebug) {
      //lower border reached
      return "down";
    } else if (this.newPos.y >= height - player1.r / 2) {
      return "down";
    }
    return "none";
  }

  void calcGridPos() {
    this.gridPos.x = this.pos.x / tileSize;
    this.gridPos.y = this.pos.y / tileSize;
  }

  //--------------------------------------------------------------------------------------------------
  //tool methods
  void changeTool(int id) {
    toolID = id;

    hand    = false;
    pickaxe = false;
    wrench  = false;

    switch(toolID) {
    case 0:
      hand = true;
      break;
    case 1:
      pickaxe = true;
      break;
    case 2:
      wrench = true;
      break;
    default:
      toolID = 0;
    }
  }  

  //--------------------------------------------------------------------------------------------------
  //get and set methods
  void addCoins(float arg) {
    this.coins += arg;
  }

  void setBox(Box b_) {
    this.cBox = b_;
  }

  //---------------------------------------------------------------------------
  //shows player on screen
  void show() {  
    //show interaction radius
    fill(255, 255, 255, 0);
    stroke(255, 255, 255, 100);
    ellipse(this.pos.x, this.pos.y, intRadius * 2, intRadius * 2);

    float angle = calcLook();

    //show player
    pushMatrix();
    //pushing matrix for later use
    
    imageMode(CENTER);
    translate(this.pos.x, this.pos.y);
    rotate(angle);
    
    //drawing player
    drawTools();
    image(player, 0, 0, this.r, this.r);
    
    //returning to main state
    popMatrix();
    imageMode(CORNER);

    //check distance to open interactable
    if (cBox != null) {
      util.keepOpen(cBox);
    }
  }

//--------------------------------------------------------------------------------------------------
//underlieing drawing methods
  void drawTools(){
   if(hand){
     return;
   } else if (pickaxe){
     image(pickaxeImg, 0, 0, this.r, this.r);
   } else if (wrench){
     image(wrenchImg, 0, 0, this.r, this.r);
   }
  }

  float calcLook() {  //calculate were the player is supposed to look
    if (look.x == 0 && look.y == 0) {
      //none
    } else if (look.x == 1 && look.y == 0) {
      //right
      return  PI / 2;
    } else if (look.x == -1 && look.y == 0) {
      //left
      return - PI / 2;
    } else if (look.x == 0 && look.y == 1) {
      //down
      return PI;
    } else if (look.x == 1 && look.y == 1) {
      //down right
      return (PI / 4) * 3;
    } else if (look.x == -1 && look.y == 1) {
      //down left
      return -(PI / 4) * 3;
    } else if (look.x == 0 && look.y == -1) {
      //up
      return 0;
    } else if (look.x == 1 && look.y == -1) {
      //up right
      return (PI / 4);
    } else if (look.x == -1 && look.y == -1) {
      //up left
      return -(PI / 4);
    }
    return 0;
  }
}