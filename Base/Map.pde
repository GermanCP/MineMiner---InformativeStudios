class Map {
  //--------------------------------------------------------------------------------------------------
  //variables
  private int w;
  private int h;
  private int id;

  private int[] terrain = new int[(width/tileSize) * (height/tileSize)];

  private float tileW;
  private float tileH;
  
  public boolean left  = false;
  public boolean right = false;
  public boolean up    = false;
  public boolean down  = false;

  private String path;
  private String type;

  private PVector size = new PVector();

  private PImage map;

  private ArrayList<Box> boxes = new ArrayList<Box>();

  //--------------------------------------------------------------------------------------------------
  //constructor
  Map(int w_, int h_, float tileW_, float tileH_, String path_, int id_, PVector size_, String type_) {
    this.w = w_;
    this.h = h_;
    this.path = path_;
    this.tileW = tileW_;
    this.tileH = tileH_;
    this.id = id_;
    this.size = size_;
    this.type = type_;

    //initialise map
    loadMap();
    processMap();
    createBoxes();
    calculateNeighbors(size_);
    
    //println("id: " + this.id + " left: " + left + " right: " + right + " up: " + up + " down: " + down);
  }

  //--------------------------------------------------------------------------------------------------
  //show method
  void show(boolean init_) {
    for (Box b : boxes) {
      b.show(init_);
    }
  }

  //--------------------------------------------------------------------------------------------------
  //methods
  void loadMap() {      //loads image to create map
    map = loadImage(path);
  }

  void processMap() {   //processes map-image into array of integer values
    if (map != null) {
      map.loadPixels();

      //run through all pixels
      for (int i = 0; i < map.pixels.length; i++) {
        //getting color value of certain pixel
        int col = map.pixels[i];

        //setting terrain type corresponding to colour
        if (col == -1) {                      //white - walkable
          terrain[i] = 1;
        } else if (col == -16777216) {        //black - stone
          terrain[i] = 2;
        } else if (col == -1703810) {         //pink - iron
          terrain[i] = 3;
        } else if (col == -2661) {            //yellow - gold
          terrain[i] = 4;
        } else if (col == -16711681) {        //cyan - diamond
          terrain[i] = 5;
        } else if (col == -16755935) {         //dark green - forest
          terrain[i] = 6;
        } else if (col == -16749057) {         //light cyany blue - water
          terrain[i] = 7;
        } else if (col == -46592) {            //orange - lava
          terrain[i] = 8;
        } else if (col == -65536) {
          terrain[i] = 100;                   //red - sell point
        } else {
          terrain[i] = 0;
        }
      }
    } else {
      //showMessageDialog(null, "No Map has been selected, program is now exiting!", "Alert", ERROR_MESSAGE);
    }
  }

  void createBoxes() {  //creates boxes for the grid according to the integers given in the processMap method
    int t = 0; //counting pixel coordinate
    Box tmp = null;

    for (int j = 0; j < height; j = j +tileSize) {
      for (int i = 0; i < width; i = i + tileSize) {
        tmp = new Box(terrain[t], tileSize, i, j);

        boxes.add(tmp);
        tmp = null; //reset tmp variable
        t++;
      }
    }
  }

  void calculateNeighbors(PVector size) {
    int x = 0;
    PVector found = new PVector();

    for (int j = 0; j < size.y; j++) {
      for (int i = 0; i < size.x; i++) {
        if (x == this.id) {
          found.x = i;
          found.y = j;
        }
        x++;
      }
    }

    //use calculated position to set neighbor variables
    if (found.x > 0) {
      left = true;
    }
    if (found.x < size.x - 1) {
      right = true;
    }
    if (found.y > 0) {
      up = true;
    } 
    if (found.y < size.y - 1) {
      down = true;
    }
  }
}