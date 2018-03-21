class Player {

  //movement via mouse has been removed!
  //movement via arrow-keys, mouse for interactions with UI etc.

  //variables for movement
  private PVector dir     = new PVector(0, 0);
  private PVector newPos  = new PVector();
  private PVector pos     = new PVector();
  private PVector gridPos = new PVector();

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
  
  private Box cBox   = null;

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
    if (checkBorders()) {
      return true;
    } else if (checkBoxes() == 1) {
      return true;
    } else if (checkBoxes() == 2) { //player is in water
      this.speed = this.slow;
      return false;
    } else if (checkBoxes() == 3) {
      this.speed = this.slow;
      this.health -= this.lavaDamage;
      return false;
    } else {
      this.speed = this.normal;
      return false;
    }
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
  int checkBoxes() {    //detect whether any box is too close to the player and he is colliding
    for (Box b : mainMap.boxes) {
      if (this.newPos.dist(b.posM) <= r * 0.75 && b.type != 1 && b.type != 7 && b.type != 8) { //solid block
        return 1;
      } else if (this.newPos.dist(b.posM) <= r * 0.5 && b.type == 7) {  //water
        return 2;
      } else if (this.newPos.dist(b.posM) <= r * 0.5 && b.type == 8) {  //lava
        return 3;
      }
    }
    return 0;
  }

  boolean checkBorders() {  //checking whether the player has reached the border of the screen, if so, pause movement in a certain direction
    if (this.newPos.x <= 0) {
      //left border reached 
      return true;
    }
    if (this.newPos.x >= width) {
      //right border reached
      return true;
    }
    if (this.newPos.y <= mainUI.y_UI_botStroke + player1.r / 2) {
      //upper border reached
      return true;
    }
    if (this.newPos.y >= mainUI.y_UI_debug_topStroke - player1.r / 2) {
      //lower border reached
      return true;
    }
    return false;
  }

  void calcGridPos() {
    this.gridPos.x = this.pos.x / tileSize;
    this.gridPos.y = this.pos.y / tileSize;
  }

  //--------------------------------------------------------------------------------------------------
  //tool methods
  void changeTool(int id){
    toolID = id;
    
    hand    = false;
    pickaxe = false;
    wrench  = false;
    
    switch(toolID){
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

    //show player
    fill(255, 0, 0);
    stroke(0);
    ellipse(this.pos.x, this.pos.y, r, r);

    //check distance to open interactable
    if (cBox != null) {
      util.keepOpen(cBox);
    }
  }
}