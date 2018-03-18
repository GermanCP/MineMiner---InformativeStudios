class UI { 
  //variables
  boolean showDebug = false;

  //window option UI
  float x_UI = 0;
  float x_UI_w1  = 250;   //w1 = end of first window, start of second window
  float x_UI_w2  = 480;   //w2 = look above
  float y_UI_top = 0;     //differenz between y_UI_bot and y_UI_top = window height
  float y_UI_bot = 45;
  //window option DebugUI
  float x_debug_UI_w1   = 70;
  float x_debug_UI_w2   = 140;
  float x_debug_UI_w3   = 210;
  float x_debug_UI_w4   = 280;
  float y_debug_UI_top;
  float y_debug_UI_bot;
  //window options text pos
  float x_UI_text       = 10;
  float y_UI_text_mainStats  = 38;
  float y_debug_UI_text = 12;

  //controlP5 button parameters market
  public float px = 100;
  public float py = 100;
  public float sx = 100;
  public float sy = 30;
  public float boff = 10;





  //--------------------------------------------------------------------------------------------------
  //constructor
  UI() {    
    y_debug_UI_top = height - 40;
    y_debug_UI_bot = height;
  }

  //--------------------------------------------------------------------------------------------------
  //methodes -> UI windows

  //showing the players amount of currency and health
  void mainStats(int coins_) {

    util.mainThemeUI();

    //coordinates window
    float x1 = x_UI;
    float x2 = x_UI_w1;
    float y1 = y_UI_top;
    float y2 = y_UI_bot;
    //coordinates text
    float tx = x_UI_text;
    float ty = y_UI_text_mainStats;
    //coordinates lifebar
    float barHeight = 8;
    float y3 = 7;
    float y4 = y3 + barHeight;


    quad(x1, y1, x2, y1, x2, y2, x1, y2);


    util.mainTextUImainStats();

    //show text
    text("Coins: " + coins_, tx, ty);

    //life of the player
    float maxSize = x_UI_w1 - tx * 2;
    float sizedLife = maxSize * (player1.health / 100);

    util.lifeBar();
    rect(tx, y3, sizedLife, y4); //rect(x,y,x,y) topleft, botright
    //
  }

  //window show inventory content
  void showInv(int stone_, int iron_, int gold_, int diamond_, int wood_) {

    util.mainThemeUI();

    //coordinates window
    float x1 = x_UI_w1;
    float x2 = x_UI_w2;
    float y1 = y_UI_top;
    float y2 = y_UI_bot;
    //coordinates text
    float tx0 =  x1 + x_UI_text;  //1st text fields, iron_ and diamond_
    float tx1 = 70;   //1st number of items, stone_ and diamond_
    float tx2 = 95;   //2nd text fields, iron_ and wood_
    float tx3 = 140;  //2nd number of items, iron_ and wood_
    float tx4 = 165;  //3rd text fields, gold_
    float tx5 = 205;  //3rd number of items, gold_
    float ty = y_debug_UI_text + 6;  //top border distance

    quad(x1, y1, x2, y1, x2, y2, x1, y2);


    util.mainTextUIinv();

    //show text
    text("Stone:", tx0, ty);
    text(stone_, tx0 + tx1, ty);
    text("Iron:", tx0 + tx2, ty);
    text(iron_, tx0 + tx3, ty);
    text("Gold:", tx0 + tx4, ty);
    text(gold_, tx0 + tx5, ty);
    text("Diamond:", tx0, ty*2);
    text(diamond_, tx0 + tx1, ty*2);
    text("Wood:", tx0 + tx2, ty*2);
    text(wood_, tx0 + tx3, ty*2);
  }


  //--------------------------------------------------------------------------------------------------
  //Debug windows

  //showing the players position coordinates
  void playerPos(float x_, float y_) {

    util.mainThemeUI();

    //coordinates window
    float x1 = x_UI;
    float x2 = x_debug_UI_w1;
    float y1 = y_debug_UI_top;
    float y2 = y_debug_UI_bot;
    //coordinates text
    float tx = x_UI_text;  // distance from left side stroke
    float ty = y_debug_UI_text;  //distance from top stroke

    quad(x1, y1, x2, y1, x2, y2, x1, y2);

    util.mainDebugTextUI();

    //show text
    text("pos", tx, y1 + ty);
    text("x: " + x_, tx, y1 + ty*2);
    text("y: " + y_, tx, y1 + ty*3);
  }

  //showing players direction
  void playerDir(float x_, float y_) {

    util.mainThemeUI();

    //coordinates window
    float x1 = x_debug_UI_w1;
    float x2 = x_debug_UI_w2;
    float y1 = y_debug_UI_top;
    float y2 = y_debug_UI_bot;
    //coordinates text
    float tx = x_debug_UI_w1 + x_UI_text;  // distance from left side stroke
    float ty = y_debug_UI_text;  //distance from top stroke

    quad(x1, y1, x2, y1, x2, y2, x1, y2);

    util.mainDebugTextUI();

    //show text
    text("dir", tx, y1 + ty);
    text(x_, tx, y1 + ty*2);
    text(y_, tx, y1 + ty*3);
  }

  //showing players inventory space
  void invSpace(float invSpace_, float maxSpace_) {

    util.mainThemeUI();

    //coordinates window
    float x1 = x_debug_UI_w2;
    float x2 = x_debug_UI_w3;
    float y1 = y_debug_UI_top;
    float y2 = y_debug_UI_bot;
    //coordinates text
    float tx = x_debug_UI_w2 + x_UI_text;  // distance from left side stroke
    float ty = y_debug_UI_text;  //distance from top stroke

    quad(x1, y1, x2, y1, x2, y2, x1, y2);

    util.mainDebugTextUI();

    //show text
    text("InvSpace", tx, y1 + ty);
    text(invSpace_, tx, y1 + ty*2);
    text(maxSpace_, tx, y1 + ty*3);
  }

  //show check boxes
  void checkBox(int checkBox_) {

    util.mainThemeUI();

    //coordinates window
    float x1 = x_debug_UI_w3;
    float x2 = x_debug_UI_w4;
    float y1 = y_debug_UI_top;
    float y2 = y_debug_UI_bot;
    //coordinates text
    float tx = x_debug_UI_w3 + x_UI_text;
    float ty = y_debug_UI_text;

    quad(x1, y1, x2, y1, x2, y2, x1, y2);

    util.mainDebugTextUI();

    //show text
    text("checkBox:", tx, y1 + ty);
    text(checkBox_, tx, y1 + ty*2);
  }


  //--------------------------------------------------------------------------------------------------
  //temporary windows

  //frame for buttons on market when sell
  void buttonFrameMarket(float stonePrize_, float ironPrize_, float goldPrize_, float diamondPrize_) {

    util.mainThemeUIinventorys();

    //coordinates window
    float nButton = 4; //number of buttons
    float nDistanceButtons = nButton - 1; //number of distances between buttons
    float prizePos = 0.6;
    float b1 = 3; //border distance
    float x1 = px - b1;
    float x2 = px + nButton*sx + nDistanceButtons*boff + b1;
    float y1 = py - 16;
    float y2 = py + sy + b1;
    //coordinates text
    //text Value
    float tx0 = px;
    float ty0 = py - b1;
    //button sell stone
    float tx1 = (px + b1) + (sx * ((1*nButton)/nButton)) + ((((1*nButton)/nButton)-1)*boff) - (prizePos*sx); //just dont ask
    float ty1 = py - b1;
    //button sell iron
    float tx2 = (px + b1) + (sx * ((2*nButton)/nButton)) + ((((2*nButton)/nButton)-1)*boff) - (prizePos*sx);    
    float ty2 = py - b1;   
    //button sell gold
    float tx3 = (px + b1) + (sx * ((3*nButton)/nButton)) + ((((3*nButton)/nButton)-1)*boff) - (prizePos*sx);
    float ty3 = py - b1;
    //button sell diamonds
    float tx4 = (px + b1) + (sx * ((4*nButton)/nButton)) + ((((4*nButton)/nButton)-1)*boff) - (prizePos*sx);
    float ty4 = py - b1;

    quad(x1, y1, x2, y1, x2, y2, x1, y2);

    util.mainTextUIinventorys();

    //show text
    text("Value:", tx0, ty0);
    text(stonePrize_, tx1, ty1);
    text(ironPrize_, tx2, ty2);
    text(goldPrize_, tx3, ty3);
    text(diamondPrize_, tx4, ty4);
  }

  //--------------------------------------------------------------------------------------------------
  //death
  void deathScreen() {
    //tint screen red
    util.deathTheme();

    rect(0, 0, width, height);

    //draw "YOU DIED" text
    textAlign(CENTER, CENTER);
    util.deathText();
    text("YOU DIED!", width /2, height / 2);

    //draw respwan hint
    textSize(20);
    text("Press ENTER to respawn!", width / 2, height / 2 + 50);
    textAlign(LEFT);
  }

  //--------------------------------------------------------------------------------------------------
  //showing HUD via this method
  void show(Player p_, Market m_) {
    //usual
    mainStats(p_.coins);
    showInv(p_.inv.stone.size(), p_.inv.iron.size(), p_.inv.gold.size(), p_.inv.diamond.size(), p_.inv.wood.size());


    //debug
    if (showDebug == true) {
      playerPos(parseInt(p_.pos.x), parseInt(p_.pos.y));
      playerDir(parseInt(p_.dir.x), parseInt(p_.dir.y));
      invSpace(parseInt(p_.inv.calcWeight()), parseInt(p_.inv.weightLimit));
      checkBox(p_.checkBoxes());
    }

    if (selling == true) {
      buttonFrameMarket(m_.stonePrize, m_.ironPrize, m_.goldPrize, m_.diamondPrize);
    }
  }
}