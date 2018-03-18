//all code used by this programm is intellectual property of Felix Möller, Maxim Schulze
//Based on Java and the Processing library

/* version history
 Alpha 1.0 - 912  lines of code - Base, Box, Inventory, Item, Map, Market, Player, UI, Utility                     - 9 classes
 Alpha 1.1 - 1074 lines of code - Base, Box, Inventory, Item, Map, Market, Player, UI, Utility, Marker             - 10 classes
 Alpha 1.2 - 1481 lines of code - Base, Animations, Box, Inventory, Item, Map, Marker, Market, Player, UI, Utility - 11 classes
 */

/*
What we want to change:
 - slim code, do more cleanup, even more cleanup
 - refine market
 - add more textures
 - add buildings
 - add other textures, change textures
 */

//--------------------------------------------------------------------------------------------------
//import statements
import static javax.swing.JOptionPane.*;
import javax.swing.*;
import java.awt.*;
import java.awt.Dimension;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import controlP5.*;

//--------------------------------------------------------------------------------------------------
//variables
private int tileSize = 10; //size of each maptile or box
private int cicle    = 300;
private int ccicle   = 0;

public int state = -1;

public float intRadius = 100;

private boolean fogOfWar    = true;
private boolean showMarkers = true;

public boolean selling   = false;
public boolean respawned = false;

private PVector startPos = new PVector(100, 100);
private PVector newDir = new PVector();

//istances of custom classes
public UI mainUI;
public Player player1;
public Map mainMap;
public Map underworld1;
public Map overworld;
public Utility util;
public Animations anim;
public Marker start;
public Market shop = new Market();

//tools for buttons etc in UI
ControlP5 sell;
ControlP5 nav;

//textures for the map
public PImage intro;

public PImage stone;
public PImage grass;
public PImage pavement;
public PImage iron_ore;
public PImage gold_ore;
public PImage diamond_ore;
public PImage forest;
public PImage water;
public PImage lava;

public PImage market;

//--------------------------------------------------------------------------------------------------
//main class body
void setup() {
  size(1000, 600);
  frameRate(60);
  colorMode(RGB);
  ellipseMode(CENTER);

  //setting up UI and Utilities
  mainUI = new UI();
  util = new Utility(mainUI.px, mainUI.py, mainUI.sx, mainUI.sy, mainUI.boff);

  sell   = new ControlP5(this);
  nav    = new ControlP5(this);

  sell.setAutoDraw(true);
  nav.setAutoDraw(true);

  util.importImages();
  util.initiateCP5();

  anim = new Animations();

  //startmarker
  start = new Marker(startPos.x, startPos.y, 10);

  //setting up player character
  player1 = new Player(startPos.x, startPos.y, 20, 100);

  //mainMap
  underworld1 = new Map(width, height, tileSize, tileSize, "../textures/maps/mainMap.png");

  //overworld
  overworld = new Map(width, height, tileSize, tileSize, "../textures/maps/overworld.png");

  //mainMap
  mainMap = overworld;

  //setting CP5 windows to hide
  sell.hide();
  nav.hide();
  
  //update UI
  mainUI.updateValues();
}


//--------------------------------------------------------------------------------------------------
// draw method, gets called every frame
void draw() {

  //reserved for print statements

  //
  if (state == -1) {
    background(0);
    image(intro, 0, 0, width, height);
    anim.introTimer();
  }

  //game starts
  else if (state == 0) {
    state = 1;
    if (mainMap == overworld) {
      mainMap.show(true);
    }
    return;
  }

  //if game is in main state
  else if (state == 1) {
    //playing respawn animation
    if (respawned) {
      anim.respawnTimer();

      if (anim.time >= 255) {
        //reset player position
        player1.pos.x = startPos.x;
        player1.pos.y = startPos.y;

        //reset map
        mainMap = overworld;

        respawned = false;
        mainMap.show(true);
      }
      return;
    }

    if (fogOfWar && mainMap == underworld1) {
      background(0);
    }

    //show map
    mainMap.show(false);

    //check if map can be changed
    util.checkRange(startPos);

    //markers
    if (showMarkers) {
      if (mainMap == underworld1 || mainMap == overworld) {
        start.show();
      }
    }

    resizeDir();
    //show Player
    player1.move(newDir);
    player1.checkDeath();
    player1.show();

    //show UI
    mainUI.show(player1, shop);

    //update market
    if (ccicle == cicle) {
      shop.updatePrizes();
      ccicle = 0;
    } else {
      ccicle++;
    }
  }
}
//--------------------------------------------------------------------------------------------------
//methods
void resizeDir() {
  if (newDir.x < 0) {
    newDir.x = -1;
  } else if (newDir.x > 0) {
    newDir.x = 1;
  } else {
    newDir.x = 0;
  }

  if (newDir.y < 0) {
    newDir.y = -1;
  } else if (newDir.y > 0) {
    newDir.y = 1;
  } else {
    newDir.y = 0;
  }
}

//--------------------------------------------------------------------------------------------------
//key registering methods
void keyPressed() {
  //detecting players movement
  if (keyCode == 38) {
    newDir.y = -1;
  }
  if (keyCode == 40) {  //down
    newDir.y = 1;
  }
  if (keyCode == 37 ) { //left
    newDir.x = -1;
  }
  if (keyCode == 39) { //right
    newDir.x = 1;
  }
  if (keyCode == 130) {
    mainUI.showDebug = !mainUI.showDebug;
  }
  if (keyCode == 10) {
    player1.respawn();
  }
  //println(keyCode); //print keyCode for easier key implementation
}

void keyReleased() {
  switch(keyCode) {
    //movement reset
  case 37:
    newDir.x = 0;
    break;
  case 38:
    newDir.y = 0;
    break;
  case 39:
    newDir.x = 0;
    break;
  case 40:
    newDir.y = 0;
    break;

    //default statement
  default:
    break;
  }
}

void mousePressed() {
  if (mouseButton == 37) {  //LMB
    util.interact(util.interacted(), "mine");
  }

  if (mouseButton == 38) {  //MMB
  }

  if (mouseButton == 39) {  //RMB
    util.interact(util.interacted(), "open");
  }
}

//--------------------------------------------------------------------------------------------------
//controlP5 events
void SellStone() {
  if (player1 != null) {
    player1.inv.sell("stone");
  }
}

void SellIron() {
  if (player1 != null) {
    player1.inv.sell("iron");
  }
}

void SellGold() {
  if (player1 != null) {
    player1.inv.sell("gold");
  }
}

void SellDiamond() {
  if (player1 != null) {
    player1.inv.sell("diamond");
  }
}

void ChangeMap() {
  if (player1 != null) {
    if (mainMap == overworld) {
      mainMap = underworld1;
    } else {
      mainMap = overworld;
      mainMap.show(true);
    }
    player1.pos.x = startPos.x;
    player1.pos.y = startPos.y;
  }
}