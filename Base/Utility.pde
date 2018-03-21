class Utility {
  //this class contains any utility functions which experience frequent use from all other classes

  //variables
  private PVector sellButtons;
  private PVector buttonSize;

  private float off = 10;

  private boolean navShow = false;

  //--------------------------------------------------------------------------------------------------
  //constructor
  Utility(float px_, float py_, float sx_, float sy_, float boff_) {
    sellButtons = new PVector(px_, py_);
    buttonSize  = new PVector(sx_, sy_);
    off = boff_;
  }

  //--------------------------------------------------------------------------------------------------
  //general UI
  void mainThemeUI() {    //main colorscheme for the UI frames 
    fill(0, 0, 0, 255);   //color and transperance for UI frames
    stroke(255);          //stroke for UI frame
  }

  void mainTextUIressources() {  //main textparameter for resources for the UI
    textSize(12);
    fill(0, 255, 0);
  }

  void mainTextUImainStats() {  //main textparameter for current coins for the UI
    textSize(13);
    fill(0, 255, 0);
  }

  //lifebar
  void lifeBar() {
    fill(255, 0, 0);
    noStroke();
  }

  //--------------------------------------------------------------------------------------------------
  //market UI
  void mainThemeUIsellMarket() { //main colorscheme for temporary UI parts
    fill(100, 100, 100);
    stroke(255);
  }

  void mainTextUIsellMarket() { //main textparameter for temporary UI parts
    textSize(12);
    fill(255);
  }

  //--------------------------------------------------------------------------------------------------
  //debug UI
  void mainDebugTextUI() {  //main textparameter for debugtextfor the UI
    textSize(12);
    fill(255, 0, 0);
  }

  void mapDebugTheme() {  //theme for debug of map
    fill(50);
    stroke(60);
  }

  //--------------------------------------------------------------------------------------------------

  void marker() {            //theme for marker
    fill(0, 0, 200);
    stroke(255);
  }
  
  //--------------------------------------------------------------------------------------------------
  //death Theme
  void deathTheme() {
    fill(255, 0, 0, 100);
    stroke(0, 0, 0, 0);
  }

  void deathText() {
    fill(255);
    textSize(80);
  }



  //--------------------------------------------------------------------------------------------------
  //Windows to be opened
  void errorLoadingMap() {                    //opens small dialog showing the user thet no map could be loaded
    //JOptionPane pane = new JOptionPane();  
    JDialog dialog = new JDialog();

    JButton akn = new JButton("OK");
    JLabel text = new JLabel();

    text.setText("Error loading map! Program will exit!");
    akn.addActionListener(new ActionListener() {
      public void actionPerformed(ActionEvent e)
      {
        //Execute when button is pressed
        noLoop();
        exit();
      }
    }
    );

    Container pane = dialog.getContentPane();
    pane.setLayout(null);

    //JLabel error1 = new JLabel("Error loading map '" + mapid + "'! Program will exit!");

    //adding cmponents
    pane.add(text);
    pane.add(akn);
    text.setBounds(10, 10, 390, 30);
    akn.setBounds(100, 60, 200, 60);

    //dialog configuration
    dialog.setSize(400, 200);
    dialog.setModal(true);
    dialog.setTitle("Alert");
    dialog.setAlwaysOnTop(true);  

    dialog.setVisible(true);
  }

  //--------------------------------------------------------------------------------------------------
  //interaction
  Box interacted() {
    PVector mouse = new PVector(mouseX, mouseY);
    float minDist = width * height;
    float currDist = 0;
    Box curr = null;

    //check for box nearest to mouse
    for (Box b : mainMap.boxes) {
      currDist = mouse.dist(b.posM);

      if (currDist <= minDist && mouse.dist(player1.pos) <= intRadius) {
        minDist = currDist;
        curr = b;
      }
    }

    //return box nearest to mouse
    return curr;
  }

  void interact(Box b_, String arg) {  //makes the player able to interact with boxes, handles interaction
    if (b_ != null) {
      if (arg == "mine" && b_.mineable && player1.toolID == 1) {
        mine(b_);
      } else if (arg == "open" && b_.interactable) {
        open(b_);
      }
    }
  }

  //--------------------------------------------------------------------------------------------------
  //interaction childmethods
  void mine(Box b_) {
    if (b_ == null) {
      return;
    }
    if (player1.inv.checkWeight()) {
      return;
    }

    int tmpType = b_.getType();

    b_.setType(1);
    b_.show(true);

    if (tmpType != 1) {
      player1.inv.add(new Item(tmpType));
    }
  }

  void open(Box b_) {
    if (b_.type == 100) { //is selling point
      if (selling == false) {
        sell.show();
        selling = true;
        player1.setBox(b_);
      } else if (selling == true) {
        sell.hide();
        selling = false;
        mainMap.show(true);
      }
    }
  }

  void keepOpen(Box b_) {
    if (player1.pos.dist(b_.pos) <= intRadius) {
    } else if (selling == true) {
      sell.hide();
      selling = false;
      mainMap.show(true);
    }
  }

  //--------------------------------------------------------------------------------------------------
  //checkmethods
  void checkRange(PVector pos_) {
    if (player1.pos.dist(pos_) <= intRadius && navShow == false) {
      nav.show();
      navShow = true;
    } else if (player1.pos.dist(pos_) > intRadius && navShow == true) {
      nav.hide();
      mainMap.show(true);
      navShow = false;
    }
  }
  //--------------------------------------------------------------------------------------------------
  //controlP5
  void initiateCP5() {  //initialises ControlP5 utilities
    //buttons for selling resources
    sell.addButton("SellWood")   .setValue(0).setPosition(sellButtons.x + 0 * (buttonSize.x + off), sellButtons.y).setSize(parseInt(buttonSize.x), parseInt(buttonSize.y));
    sell.addButton("SellStone")  .setValue(0).setPosition(sellButtons.x + 1 * (buttonSize.x + off), sellButtons.y).setSize(parseInt(buttonSize.x), parseInt(buttonSize.y));
    sell.addButton("SellIron" )  .setValue(0).setPosition(sellButtons.x + 2 * (buttonSize.x + off), sellButtons.y).setSize(parseInt(buttonSize.x), parseInt(buttonSize.y));
    sell.addButton("SellGold" )  .setValue(0).setPosition(sellButtons.x + 3 * (buttonSize.x + off), sellButtons.y).setSize(parseInt(buttonSize.x), parseInt(buttonSize.y));
    sell.addButton("SellDiamond").setValue(0).setPosition(sellButtons.x + 4 * (buttonSize.x + off), sellButtons.y).setSize(parseInt(buttonSize.x), parseInt(buttonSize.y));

    nav.addButton("ChangeMap")   .setValue(0).setPosition(width - 100, height - 40).setSize(90, 30);
  }

  //--------------------------------------------------------------------------------------------------
  //import files
  void importImages() {
    intro       = loadImage("../textures/intro.png");

    stone       = loadImage("../textures/stone.png");
    grass       = loadImage("../textures/grass.png");
    pavement    = loadImage("../textures/pavement.png");
    iron_ore    = loadImage("../textures/iron_ore.png");
    gold_ore    = loadImage("../textures/gold_ore.png");
    diamond_ore = loadImage("../textures/diamond_ore.png");
    forest      = loadImage("../textures/forest.png");
    water       = loadImage("../textures/water.png");
    lava        = loadImage("../textures/lava.png");

    market      = loadImage("../textures/market.png");
  }
}