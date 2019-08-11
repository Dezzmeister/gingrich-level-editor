public class Tile {
  float xCoor = 0;
  float yCoor = 0;
  
  PImage icon;
  
  int localVal = 0; //Empty space
  
  Tile() {
  
  }
  
  Tile(float x, float y) {
    xCoor = x;
    yCoor = y;
  }
  
  void setPos(float x, float y) {
    xCoor = x;
    yCoor = y;
  }
  
  int getLocalVal() {
    return localVal;
  }
  
  void setLocalVal(int val) {
    localVal = val;
  }
  
  float getX() {
    return xCoor;
  }
  
  void setX(float x) {
    xCoor = x;
  }
  
  float getY() {
    return yCoor;
  }
  
  void setY(float y) {
    yCoor = y;
  }
  
  void drawTile() {
    for (int i = 0; i < scriptedButtons.length; i++) {
      if (scriptedButtons[i].getLocalVal()==localVal) {
        icon = scriptedButtons[i].getImg();
        drawBG();
        imageMode(CORNER);
        image(icon,xCoor,yCoor);
      }
    }
    switch (localVal) {
      case 0: //Empty space
        drawBG();
        break;
      case 1: //Wall
        fill(0);
        drawRect();
        break;
      case 2: //Player destination
        fill(0,255,0);
        drawRect();
        break;
      case 3: //Player spawn
        fill(0,0,255);
        drawRect();
        break;
      case 4:
        drawBG();
        imageMode(CORNER);
        image(enemy.getImg(),xCoor,yCoor);
        break;
        /*
      case 4: //Enemy
        fill(170);
        drawRect();
        strokeWeight(1);
        stroke(255,0,0);
        drawX();
        stroke(0);
        break;
        */
    }
  }
  
  void drawX() {
    line(xCoor+1,yCoor+1,(xCoor+40)-1,(yCoor+40)-1);
    line((xCoor+40)-1,yCoor+1,xCoor+1,(yCoor+40)-1);
  }
  
  void drawBG() {
    fill(170);
    strokeWeight(1);
    rect(xCoor,yCoor,40,40,0,0,0,0);
  }
  
  void drawRect() {
    rect(xCoor,yCoor,40,40,0,0,0,0);
  }
}