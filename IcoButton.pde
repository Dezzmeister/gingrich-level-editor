public class IcoButton {  
  float buttonWidth;
  float buttonHeight;
  float xCoor;
  float yCoor;
  
  float buttonTextSize = 10;
  String buttonText = "";
  
  int buttonMode = CORNER;
  
  boolean enabled = true;
  
  PImage icon;
  
  int imgMode = CENTER;
  
  boolean noImg = true;
  
  int localVal = -1;
  
  String name = "";
  String desc = "";
  String localName = "";
  String localpackname = "core";
  String localpackversion = "";
  
  boolean initialized = false;
  
  IcoButton() {
    xCoor = width/2;
    yCoor = height/2;
    buttonWidth = 40;
    buttonHeight = 40;
  }
  
  IcoButton(float bWidth, float bHeight) {
    buttonWidth = bWidth;
    buttonHeight = bHeight;
  }
  
  IcoButton(float x, float y, float bWidth, float bHeight) {
    xCoor = x;
    yCoor = y;
    buttonWidth = bWidth;
    buttonHeight = bHeight;
  }
  
  void setPackName(String pack) {
    localpackname = pack;
  }
  
  String getPackName() {
    return localpackname;
  }
  
  void setPackVersion(String packVersion) {
    localpackversion = packVersion;
  }
  
  String getPackVersion() {
    return localpackversion;
  }
  
  void setLocalName(String lName) {
    localName = lName;
  }
  
  String getLocalName() {
    return localName;
  }
  
  boolean isInitialized() {
    return initialized;
  }
  
  void initialize() {
    initialized = true;
  }
  
  void loadImg(String filename) {
    icon = loadImage(filename);
    noImg = false;
  }
  
  PImage getImg() {
    return icon;
  }
  
  void setButtonName(String buttonName) {
    name = buttonName;
  }
  
  void setButtonDesc(String buttonDesc) {
    desc = buttonDesc;
  }
  
  String getButtonName() {
    return name;
  }
  
  String getButtonDesc() {
    return desc;
  }
  
  void register(String buttonName, String buttonDesc) {
    name = buttonName;
    desc = buttonDesc;
  }
  void register(String buttonName, String buttonDesc, int val) {
    name = buttonName;
    desc = buttonDesc;
    localVal = val;
  }
  
  void setLocalVal(int val) {
    localVal = val;
  }
  
  int getLocalVal() {
    return localVal;
  }
  
  void setImgMode(int mode) {
    if (mode == CORNER) {
      imgMode = CORNER;
    } else {
      imgMode = CENTER;
    }
  }
  
  void disableImg() {
    noImg = true;
  }
  
  void enableImg() {
    noImg = false;
  }
  
  void setLocation(float x, float y) {
    if (buttonMode == CENTER) {
      xCoor = x;
      yCoor = y;
    } else {
      xCoor = x+(buttonWidth/2);
      yCoor = y+(buttonHeight/2);
    }
  }
  
  void setSize(float bWidth, float bHeight) {
    buttonWidth = bWidth;
    buttonHeight = bHeight;
  }
  
  void buttonMode(int mode) {
    if (mode == CENTER) {
      buttonMode = CENTER;
    } else {
      buttonMode = CORNER;
    }
  }
  
  void setButton(float x, float y, float bWidth, float bHeight) {
    if (buttonMode == CENTER) {
      xCoor = x;
      yCoor = y;
    } else {
      xCoor = x+(bWidth/2);
      yCoor = y+(bHeight/2);
    }
    buttonWidth = bWidth;
    buttonHeight = bHeight;
  }
  
  void setTextSize(float size) {
    buttonTextSize = size;
  }
  
  void setText(String text) {
    buttonText = text;
  }
  
  void enableButton() {
    enabled = true;
  }
  
  void disableButton() {
    enabled = false;
  }
  
  void drawButton() {
    if (icon.width > buttonWidth || icon.height > buttonHeight) {
      exit();
    }
    if (isHovering() || (localVal == globalVal)) {
      noStroke();
    } else {
      strokeWeight(2);
      stroke(0);
    }
    fill(170);
    rectMode(CENTER);
    rect(xCoor,yCoor,buttonWidth,buttonHeight,0,0,0,0);
    rectMode(CORNER);
    strokeWeight(1);
    
    if (!noImg) {
      switch (imgMode) {
        case CENTER:
          imageMode(CENTER);
          image(icon,xCoor,yCoor);
          break;
        case CORNER:
          imageMode(CORNER);
          image(icon,xCoor-(buttonWidth/2),yCoor-(buttonHeight/2));
          break;
      }
    }
  }
      
  boolean isHovering() {
    if (enabled) {
      return (mouseX >= xCoor-(buttonWidth/2) && mouseX <= xCoor+(buttonWidth/2) && mouseY >= yCoor-(buttonHeight/2) && mouseY <= yCoor+(buttonHeight/2));
    }
    return false;
  }
   
}