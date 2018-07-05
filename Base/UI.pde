class UI { 
  //variables
  boolean showDebug = false;
  
  //window option UI
  float x_UI_barrier_0  = 0;     //UI start stroke
  float x_UI_barrier_1  = 250;   //1st UI barrier
  float x_UI_barrier_2  = 500;   //2nd UI barrier
  float x_UI_barrier_3  = 1000;  //3rd UI barrier
  float y_UI_topStroke = 0;      //y_UI_botStroke - y_UI_topStroke = UI hight
  float y_UI_botStroke = 45;
  float x_UI_borderSide  = 10;
  //window option DebugUI
  float x_UI_debug_barrier_1   = 70;
  float x_UI_debug_barrier_2   = 140;
  float x_UI_debug_barrier_3   = 210;
  float x_UI_debug_barrier_4   = 280;
  float y_UI_debug_topStroke;
  float y_UI_debug_botStroke;
  //window options text pos
  float y_UI_textPos_coins  = 38;
  float y_UI_textPos_ressource = 18;
  float y_UI_textPos_debug = 12;
  //healthBar parameter
  float x_UI_lifeBar_borderRight = x_UI_barrier_1 - x_UI_borderSide;
  float x_UI_lifeBar_sizedLife;
  float y_UI_lifeBar_topStroke = 8; //position of top stroke of lifeBar
  float y_UI_lifeBar_botStroke = 12; //height of lifeBar
  //expBar parameter
  float x_UI_expBar_borderRight = x_UI_barrier_1 - x_UI_borderSide;
  float x_UI_expBar_borderLeft  = x_UI_barrier_1 /2;
  float x_UI_expBar_sizedExp;
  float y_UI_expBar_topStroke = y_UI_textPos_coins - 11;
  float y_UI_expBar_botStroke = y_UI_textPos_coins + 1;
  //toolBar parameter
  float x_UI_toolBar_frameDistance = 10;
  float y_UI_toolBar_topStroke = 10;
  float y_UI_toolBar_botStroke = 35;
  float x_UI_toolBar_wide = y_UI_toolBar_botStroke - y_UI_toolBar_topStroke;



  //controlP5 button parameters market
  public float px = 100;
  public float py = 100;
  public float sx = 100;
  public float sy = 30;
  public float boff = 10;





  //----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  //constructor
  UI() {    
    y_UI_debug_topStroke = height - 40;
    y_UI_debug_botStroke = height;
  }

  void updateValues() {
    x_UI_lifeBar_sizedLife = (x_UI_lifeBar_borderRight - x_UI_borderSide) * (player1.health / 100) + x_UI_borderSide;
    x_UI_expBar_sizedExp = 1 + x_UI_expBar_borderLeft + x_UI_expBar_borderRight * (player1.expSys.getXPPercent()) - x_UI_expBar_borderLeft * (player1.expSys.getXPPercent());
  }

  //----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  //methodes -> UI windows

  //showing the players amount of currency and health
  void showMainStats(int coins_, int level_) {

    //coordinates frame
    float x1 = x_UI_barrier_0;
    float x2 = x_UI_barrier_1;
    float y1 = y_UI_topStroke;
    float y2 = y_UI_botStroke;
    //coordinates text
    float tx = x_UI_borderSide;
    float ty = y_UI_textPos_coins;
    //coordinates lifebar frame
    float x3 = x_UI_borderSide;
    float x4 = x_UI_lifeBar_borderRight;
    float y3 = y_UI_lifeBar_topStroke;
    float y4 = y_UI_lifeBar_topStroke + y_UI_lifeBar_botStroke;
    //coordinates red life bar frame
    float x5 = x_UI_borderSide + 1;
    float x6 = x_UI_lifeBar_sizedLife;
    float y5 = y_UI_lifeBar_topStroke + 1;
    float y6 = y_UI_lifeBar_topStroke + y_UI_lifeBar_botStroke;
    //coordinates exp bar frame
    float x7 = x_UI_expBar_borderLeft;
    float x8 = x_UI_expBar_borderRight;
    float y7 = y_UI_expBar_topStroke;
    float y8 = y_UI_expBar_botStroke;
    //coordinates blue exp bar 
    float x9  = x_UI_expBar_borderLeft + 1;
    float x10 = x_UI_expBar_sizedExp;
    float y9  = y_UI_expBar_topStroke + 1;
    float y10 = y_UI_expBar_botStroke;    

    //frames
    util.mainThemeUI();
    quad(x1, y1, x2, y1, x2, y2, x1, y2);  //Position 1st main Frame
    quad(x3, y3, x4, y3, x4, y4, x3, y4);  //Position lifeBar Frame
    quad(x7, y7, x8, y7, x8, y8, x7, y8);  //Position expBar Frame

    //show text
    util.mainTextUImainStats();
    text("Coins: " + coins_, tx, ty);
    text(level_, x_UI_expBar_borderLeft - x_UI_borderSide*2, ty);

    //lifeBar of player
    util.lifeBar();
    quad(x5, y5, x6, y5, x6, y6, x5, y6); //Position red life bar
    
    //expBar of player
    util.expBar();
    quad(x9, y9, x10, y9, x10, y10, x9, y10); //Position blue exp bar
  }

  //window show inventory content
  void showInv(int stone_, int iron_, int gold_, int diamond_, int wood_) {

    //coordinates frame
    float x1 = x_UI_barrier_1;
    float x2 = x_UI_barrier_2;
    float y1 = y_UI_topStroke;
    float y2 = y_UI_botStroke;
    //coordinates text
    float tx0 = x1 + x_UI_borderSide;    //1st text fields, wood_ and iron_
    float tx1 = 50;                      //1st number of items, wood_ and iron_
    float tx2 = 75;                      //2nd text fields, stone_ and gold_
    float tx3 = 120;                     //2nd number of items, stone_ and gold_
    float tx4 = 145;                     //3rd text fields, diamond_
    float tx5 = 215;                     //3rd number of items, diamond_
    float ty  = y_UI_textPos_ressource;  //top border distance

    //frames
    util.mainThemeUI();
    quad(x1, y1, x2, y1, x2, y2, x1, y2);  //position 2nd main Frame


    //show text
    util.mainTextUIressources();
    text("Wood:", tx0, ty);
    text(wood_, tx0 + tx1, ty);
    text("Stone:", tx0 + tx2, ty);
    text(stone_, tx0 + tx3, ty);
    text("Iron:", tx0, ty*2);
    text(iron_, tx0 + tx1, ty*2);
    text("Gold:", tx0 + tx2, ty*2);
    text(gold_, tx0 + tx3, ty*2);
    text("Diamond:", tx0 + tx4, ty*2);
    text(diamond_, tx0 + tx5, ty*2);
  }

  void showRestOfUI(int toolID) {

    //coordinates frame
    float x1 = x_UI_barrier_2;
    float x2 = x_UI_barrier_3;
    float y1 = y_UI_topStroke;
    float y2 = y_UI_botStroke;
    //coordinates tool bar frame
    float nToolBarFrame = 3;
    float y3 = y_UI_toolBar_topStroke;
    float y4 = y_UI_toolBar_botStroke;
    float x3 = x_UI_barrier_2 + x_UI_toolBar_frameDistance + x_UI_toolBar_wide * ((0*nToolBarFrame)/nToolBarFrame) + (1*x_UI_toolBar_frameDistance - x_UI_toolBar_frameDistance);
    float x4 = x3 + x_UI_toolBar_wide;
    float x5 = x_UI_barrier_2 + x_UI_toolBar_frameDistance + x_UI_toolBar_wide * ((1*nToolBarFrame)/nToolBarFrame) + (2*x_UI_toolBar_frameDistance - x_UI_toolBar_frameDistance);
    float x6 = x5 + x_UI_toolBar_wide;
    float x7 = x_UI_barrier_2 + x_UI_toolBar_frameDistance + x_UI_toolBar_wide * ((2*nToolBarFrame)/nToolBarFrame) + (3*x_UI_toolBar_frameDistance - x_UI_toolBar_frameDistance);
    float x8 = x7 + x_UI_toolBar_wide;



    //frames
    util.mainThemeUI();
    quad(x1, y1, x2, y1, x2, y2, x1, y2);  //Position 3rd main Frame

    //Position 1st tool Frame
    fill(0, 0, 0, 0);
    if (toolID == 0) {
      stroke(0, 255, 0);
    } else {
      stroke(255);
    }
    image(handIcon, x3 , y3, -(x3 - x4), -(y3 - y4));
    quad(x3, y3, x4, y3, x4, y4, x3, y4); 
    
    //Position 2nd tool Frame
    if (toolID == 1) {
      stroke(0, 255, 0);
    } else {
      stroke(255);
    }
    image(pickaxeIcon, x5 , y3, -(x5 - x6), -(y3 - y4));
    quad(x5, y3, x6, y3, x6, y4, x5, y4);

    //Position 3rd tool Frame
    if (toolID == 2) {
      stroke(0, 255, 0);
    } else {
      stroke(255);
    }
    image(wrenchIcon, x7 , y3, -(x7 - x8), -(y3 - y4));
    quad(x7, y3, x8, y3, x8, y4, x7, y4);
  }


  //----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  //Debug windows

  //showing players position as coordinates
  void playerPos(float x_, float y_) {

    //coordinates frame
    float x1 = x_UI_barrier_0;
    float x2 = x_UI_debug_barrier_1;
    float y1 = y_UI_debug_topStroke;
    float y2 = y_UI_debug_botStroke;
    //coordinates text
    float tx = x_UI_borderSide;      // distance from left side stroke
    float ty = y_UI_textPos_debug;   //distance from top stroke

    //frames
    util.mainThemeUI();
    quad(x1, y1, x2, y1, x2, y2, x1, y2);

    //show text
    util.mainDebugTextUI();
    text("pos", tx, y1 + ty);
    text("x: " + x_, tx, y1 + ty*2);
    text("y: " + y_, tx, y1 + ty*3);
  }

  //showing players direction
  void playerDir(float x_, float y_) {

    //coordinates window
    float x1 = x_UI_debug_barrier_1;
    float x2 = x_UI_debug_barrier_2;
    float y1 = y_UI_debug_topStroke;
    float y2 = y_UI_debug_botStroke;
    //coordinates text
    float tx = x_UI_debug_barrier_1 + x_UI_borderSide;  // distance from left side stroke
    float ty = y_UI_textPos_debug;                      //distance from top stroke

    //frames
    util.mainThemeUI();
    quad(x1, y1, x2, y1, x2, y2, x1, y2);

    //show text
    util.mainDebugTextUI();
    text("dir", tx, y1 + ty);
    text(x_, tx, y1 + ty*2);
    text(y_, tx, y1 + ty*3);
  }

  //showing players inventory space
  void invSpace(float invSpace_, float maxSpace_) {

    //coordinates window
    float x1 = x_UI_debug_barrier_2;
    float x2 = x_UI_debug_barrier_3;
    float y1 = y_UI_debug_topStroke;
    float y2 = y_UI_debug_botStroke;
    //coordinates text
    float tx = x_UI_debug_barrier_2 + x_UI_borderSide;  // distance from left side stroke
    float ty = y_UI_textPos_debug;  //distance from top stroke

    //frames
    util.mainThemeUI();
    quad(x1, y1, x2, y1, x2, y2, x1, y2);

    //show text
    util.mainDebugTextUI();
    text("InvSpace", tx, y1 + ty);
    text(invSpace_, tx, y1 + ty*2);
    text(maxSpace_, tx, y1 + ty*3);
  }

  //show check boxes
  void checkBox(int checkBox_) {

    //coordinates window
    float x1 = x_UI_debug_barrier_3;
    float x2 = x_UI_debug_barrier_4;
    float y1 = y_UI_debug_topStroke;
    float y2 = y_UI_debug_botStroke;
    //coordinates text
    float tx = x_UI_debug_barrier_3 + x_UI_borderSide;
    float ty = y_UI_textPos_debug;

    //frames
    util.mainThemeUI();
    quad(x1, y1, x2, y1, x2, y2, x1, y2);

    util.mainDebugTextUI();

    //show text
    text("checkBox:", tx, y1 + ty);
    text(checkBox_, tx, y1 + ty*2);
  }


  //----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  //temporary frames

  //frame for buttons on market when sell
  void buttonFrameMarket(float woodPrize_, float stonePrize_, float ironPrize_, float goldPrize_, float diamondPrize_) {

    util.mainThemeUIsellMarket();

    //coordinates window
    float nButton = 5; //number of buttons
    float nDistanceButtons = nButton - 1; //number of distances between buttons
    float prizePos = 0.75;
    float buttonDistance = 3; //border distance
    float x1 = px - buttonDistance;
    float x2 = px + nButton*sx + nDistanceButtons*boff + buttonDistance;
    float y1 = py - 16;
    float y2 = py + sy + buttonDistance;
    //coordinates text
    //button sell wood
    float tx1 = (px + buttonDistance) + (sx * ((1*nButton)/nButton)) + ((((1*nButton)/nButton)-1)*boff) - (prizePos*sx); //just dont ask
    float ty1 = py - buttonDistance;
    //button sell stone
    float tx2 = (px + buttonDistance) + (sx * ((2*nButton)/nButton)) + ((((2*nButton)/nButton)-1)*boff) - (prizePos*sx);    
    float ty2 = py - buttonDistance;   
    //button sell iron
    float tx3 = (px + buttonDistance) + (sx * ((3*nButton)/nButton)) + ((((3*nButton)/nButton)-1)*boff) - (prizePos*sx);
    float ty3 = py - buttonDistance;
    //button sell gold
    float tx4 = (px + buttonDistance) + (sx * ((4*nButton)/nButton)) + ((((4*nButton)/nButton)-1)*boff) - (prizePos*sx);
    float ty4 = py - buttonDistance;
    //button sell diamonds
    float tx5 = (px + buttonDistance) + (sx * ((5*nButton)/nButton)) + ((((5*nButton)/nButton)-1)*boff) - (prizePos*sx);
    float ty5 = py - buttonDistance;

    quad(x1, y1, x2, y1, x2, y2, x1, y2);

    util.mainTextUIsellMarket();

    //show text
    text(woodPrize_, tx1, ty1);
    text(stonePrize_, tx2, ty2);
    text(ironPrize_, tx3, ty3);
    text(goldPrize_, tx4, ty4);
    text(diamondPrize_, tx5, ty5);
  }
  
  //questing frame
  void questingFrame(String questDiscribtion_[], int nQuestTask_[][], int nQuestReward_, String questReward) {
    
    /* what to do:
    - get reward button below quest ditails
    - top frame for quest discribtion
    - bot frame for quest ditails
    - reward frame 
    */
    
    //coordinates main frame
    float x1;  //.-.
    float x2;  //| | <- quest discribtion
    float y1;  //.-. 
    float y2;  //| | <- quest ditails
    float y3 = y2 + ty3_1 + ((y_UI_textPos_debug + textSize) * nQuestTask_[0][length]);  //.-.
    
  }
    
  
  //----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
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

  //----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  //showing HUD via this method
  void show(Player p_, Market m_) {
    //usual
    showMainStats(p_.coins, p_.expSys.getLevel());
    showInv(p_.inv.stone.size(), p_.inv.iron.size(), p_.inv.gold.size(), p_.inv.diamond.size(), p_.inv.wood.size());
    showRestOfUI(p_.toolID);

    //debug
    if (showDebug == true) {
      playerPos(parseInt(p_.pos.x), parseInt(p_.pos.y));
      playerDir(p_.dir.x, p_.dir.y);
      invSpace(parseInt(p_.inv.calcWeight()), parseInt(p_.inv.weightLimit));
      checkBox(p_.checkBoxes(p_.newPos, mainMap));
    }

    if (selling == true) {
      buttonFrameMarket(m_.woodPrize, m_.stonePrize, m_.ironPrize, m_.goldPrize, m_.diamondPrize);
    }
  }
}
