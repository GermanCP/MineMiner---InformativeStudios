//all code used by this programm is intellectual property of Felix Möller, Maxim Schulze
//Based on Java and the Processing library

/* version history
 Alpha 1.0 - 912  lines of code - Base, Box, Inventory, Item, Map, Market, Player, UI, Utility                     - 9 classes
 Alpha 1.1 - 1074 lines of code - Base, Box, Inventory, Item, Map, Market, Player, UI, Utility, Marker             - 10 classes
 Alpha 1.2 - 1481 lines of code - Base, Animations, Box, Inventory, Item, Map, Marker, Market, Player, UI, Utility - 11 classes
 Alpha 1.3 - 1937 lines of code - Base, Animations, Box, Experience, Inventory, Item, Map, Marker, Market, Mob, Player, Questing, UI, Utility - 14 classes
 */

/*
What we want to change:
 - slim code, do more cleanup, even more cleanup
 - refine market
 - add tools in item class
 - add weapons (ranged)
 - add crafting system
 - add upgrade system (new tools, recipies, buildings)
 - add more textures
 - add buildings
 - add other textures, change textures
 - add more maps
 - add ability to walk from one map to the other
 - add tool class and functionality such as buying them
 - add JSON files such as config for cleaner code
 - be able to refine materials
 - more materials
 - even more materials
 - underwater map
 - get to underwater map when diving (map level depends on oxygen system level)
 - oxygen bar (only shown when under water)
 - oxygen system for diving
 - diving equipment for longer dives
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

public float intRadius = 50;

private boolean fogOfWar    = true;
private boolean showMarkers = true;

public boolean selling   = false;
public boolean respawned = false;

private PVector startPos = new PVector(100, 100);
private PVector newDir = new PVector();

//map sizes
private PVector overworldSize  = new PVector(1, 1);
private PVector underworldSize = new PVector(3, 3);

//istances of custom classes
public UI mainUI;
public Player player1;
public Map mainMap;

//Maps
public Map overworld;

public Map[] underworld = new Map[9];

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

public PImage player;

//tools
public PImage pickaxeImg;
public PImage wrenchImg;

//icons
public PImage handIcon;
public PImage pickaxeIcon;
public PImage wrenchIcon;

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
  for(int i = 0; i < underworld.length; i++){
  underworld[i] = new Map(width, height, tileSize, tileSize, "../textures/maps/underworld" + i + ".png", i, underworldSize, "underworld");
  }

  //overworld
  overworld = new Map(width, height, tileSize, tileSize, "../textures/maps/overworld.png", 0, overworldSize, "overworld");

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
    if (mainMap.type == "overworld") {
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

    if (fogOfWar && mainMap.type == "underworld") {
      background(0);
    }

    //show map
    mainMap.show(false);

    //check if map can be changed
    util.checkRange(startPos);

    //markers
    if (showMarkers) {
      if (mainMap == underworld[0] || mainMap == overworld) {
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
    mainUI.updateValues();

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
void resizeDir() {  //calculating the direction the player should move
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
  if (keyCode == 38 || keyCode == 87) {  //up
    newDir.y = -1;
  }
  if (keyCode == 40 || keyCode == 83) {  //down
    newDir.y = 1;
  }
  if (keyCode == 37 || keyCode == 65) { //left
    newDir.x = -1;
  }
  if (keyCode == 39 || keyCode == 68) { //right
    newDir.x = 1;
  }
  if (keyCode == 130) {
    mainUI.showDebug = !mainUI.showDebug;
  }
  if (keyCode == 10) {
    player1.respawn();
  }
  if (keyCode == 49) { //1
    player1.changeTool(0);
  }
  if (keyCode == 50) { //2
    player1.changeTool(1);
  }
  if (keyCode == 51) { //3
    player1.changeTool(2);
  }
  if (keyCode == 84) { //T for tooolchange
    player1.changeTool(player1.toolID + 1);
  }
  if (keyCode == 129) {
    if (state == -1) {
      state = 0;
    }
  }
  //println(keyCode); //print keyCode for easier key implementation
}

void keyReleased() {
  switch(keyCode) {
    //movement reset
  case 37:
  case 65:
    newDir.x = 0;
    break;
  case 38:
  case 83:
    newDir.y = 0;
    break;
  case 39:
  case 68:
    newDir.x = 0;
    break;
  case 40:
  case 87:
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
void SellWood() {
  if (player1 != null) {
    player1.inv.sell("wood");
  }
}

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
      mainMap = underworld[0];
    } else {
      mainMap = overworld;
      mainMap.show(true);
    }
    player1.pos.x = startPos.x;
    player1.pos.y = startPos.y;
  }
}