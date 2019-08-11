//Level editor for Gingrich (by Dezzy)
//Gingrich is unfinished and so is this level editor.


PGraphics toolbar;
PGraphics menu;
PGraphics newLvlMenu;
PGraphics exitDialogue;

PGraphics itemMenu;
PGraphics itemInfo;

boolean done = false;

String itemInfoName = "";
String itemInfoDesc = "";

PFont menuFontL;
PFont menuFontS;
PFont menuFontButton;
PFont harambe175;
PFont harambe130;
PFont harambe20;
PFont harambe50;
PFont harambe30;
PFont harambe15;

boolean ranOnce = false;
boolean textCheckerRan = false;

boolean inMenu = true;
boolean inApp = false;
boolean inNewLvl = false;
boolean inExitDialogue = false;
boolean exitOnNextFrame = false;
boolean inItemMenu = false;

boolean[] keys;

float xTr = 0;
float yTr = 0;

String[] mapData;
String[] ids;

String[] loadscripts;
String[] loadpacks;

String packNameList = "";
String packVersionList = "";
String[] packnamelist;
String[] packversionlist;

IcoButton[] scriptedButtons;
ItemScript[] scripts;

Button loadLvl;
Button newLvl;
Button exitEditor;
Button saveLvl;
Button yesSave;
Button noSave;

//GUI IcoButtons
IcoButton wall;
IcoButton end;
IcoButton start;
IcoButton enemy;
IcoButton chest;

//Item Menu IcoButtons (not used anymore)
IcoButton shortsword;
IcoButton longsword;
IcoButton goldsword;
IcoButton pistol;
IcoButton bomb;

InteractiveTextField newLevel;

String levelName = "";

int xTiles = 50;
int yTiles = 50;
Tile[][] tiles;

String[][] map;
String current = "core.1";

PGraphics tileMap;

int globalVal = 1;

boolean arrayCopyMode = true;
boolean devMode = true;

int scriptCount = 0;

Level leveldata;

void setup() {
  size(800,850);
  
  loadpacks = loadStrings("/data/scripts/loadpacks.txt");
  
  //loadscripts = loadStrings("/data/scripts/loadscripts.txt");
  
  menuFontL = loadFont("/fonts/menuFontL.vlw");
  menuFontS = loadFont("/fonts/menuFontS.vlw");
  menuFontButton = loadFont("/fonts/menuFontButton.vlw");
  harambe175 = createFont("/fonts/harambe8/harambe8.ttf",175,false);
  harambe130 = createFont("/fonts/harambe8/harambe8.ttf",130,false);
  harambe20 = createFont("/fonts/harambe9/harambe8.ttf",20,false);
  harambe50 = createFont("/fonts/harambe9/harambe8.ttf",50,false);
  harambe30 = createFont("/fonts/harambe8/harambe8.ttf",30,false);
  harambe15 = createFont("/fonts/harambe8/harambe8.ttf",15,false);
  
  newLvl = new Button(width/2,(height/2)+50,175,40);
  newLvl.buttonMode(CENTER);
  newLvl.setTextSize(30);
  newLvl.setFont(harambe30);
  newLvl.setText("New Level");
  
  loadLvl = new Button(width/2,(height/2)+150,175,40);
  loadLvl.buttonMode(CENTER);
  loadLvl.setTextSize(30);
  loadLvl.setFont(harambe30);
  loadLvl.setText("Load Level");
  
  saveLvl = new Button(750,12,65,18);
  saveLvl.buttonMode(CENTER);
  saveLvl.setFill(150);
  saveLvl.setTextSize(15);
  saveLvl.setFont(harambe15);
  saveLvl.setText("Save");
  
  yesSave = new Button(360,500,65,18);
  yesSave.buttonMode(CENTER);
  yesSave.setFill(150);
  yesSave.setTextSize(15);
  yesSave.setFont(harambe15);
  yesSave.setText("Yes");
  
  noSave = new Button(440,500,65,18);
  noSave.buttonMode(CENTER);
  noSave.setFill(150);
  noSave.setTextSize(15);
  noSave.setFont(harambe15);
  noSave.setText("No");
  
  exitEditor = new Button(750,36,65,18);
  exitEditor.buttonMode(CENTER);
  exitEditor.setFill(150);
  exitEditor.setTextSize(15);
  exitEditor.setFont(harambe15);
  exitEditor.setText("Exit");
  
  toolbar = createGraphics(width,50,JAVA2D);
  toolbar.beginDraw();
  toolbar.strokeWeight(2);
  toolbar.background(150);
  toolbar.endDraw();
  
  exitDialogue = createGraphics(300,200,JAVA2D);
  exitDialogue.beginDraw();
  exitDialogue.strokeWeight(2);
  exitDialogue.fill(120);
  exitDialogue.rect(0,0,exitDialogue.width,exitDialogue.height);
  exitDialogue.endDraw();
  
  menu = createGraphics(width,height);
  menu.beginDraw();
  menu.strokeWeight(1);
  menu.background(120);
  menu.endDraw();
  
  newLvlMenu = createGraphics(width,height);
  newLvlMenu.beginDraw();
  newLvlMenu.strokeWeight(1);
  newLvlMenu.background(120);
  newLvlMenu.endDraw();
  
  itemMenu = createGraphics(500,600);
  itemMenu.beginDraw();
  itemMenu.strokeWeight(1);
  itemMenu.background(120);
  itemMenu.endDraw();
  
  itemInfo = createGraphics(500,175);
  itemInfo.beginDraw();
  itemInfo.strokeWeight(1);
  itemInfo.background(120);
  itemInfo.endDraw();
  
  tiles = new Tile[xTiles][yTiles];
  mapData = new String[yTiles];
  map = new String[xTiles][yTiles];
  
  wall = new IcoButton(30,25,40,40);
  wall.buttonMode(CENTER);
  wall.loadImg("/data/icons/wall.png");
  wall.setLocalVal(1);
  
  end = new IcoButton(90,25,40,40);
  end.buttonMode(CENTER);
  end.loadImg("/data/icons/end.png");
  end.setLocalVal(2);
  
  start = new IcoButton(150,25,40,40);
  start.buttonMode(CENTER);
  start.loadImg("/data/icons/start.png");
  start.setLocalVal(3);
  
  enemy = new IcoButton(210,25,40,40);
  enemy.buttonMode(CENTER);
  enemy.loadImg("/data/icons/enemy.png");
  enemy.setLocalVal(4);
  
  chest = new IcoButton(270,25,40,40);
  chest.buttonMode(CENTER);
  chest.loadImg("/data/icons/chest.png");
  chest.setLocalVal(5);
  
  shortsword = new IcoButton(40,40);
  shortsword.buttonMode(CORNER);
  shortsword.setLocation(160,60);
  shortsword.loadImg("/data/icons/shortsword.png");
  shortsword.register("Shortsword","Classic weapon for the questing warrior",6);
  
  longsword = new IcoButton(40,40);
  longsword.buttonMode(CORNER);
  longsword.setLocation(220,60);
  longsword.loadImg("/data/icons/longsword.png");
  longsword.register("Longsword","More range and damage, less speed",7);
  
  goldsword = new IcoButton(40,40);
  goldsword.buttonMode(CORNER);
  goldsword.setLocation(280,60);
  goldsword.loadImg("/data/icons/goldsword.png");
  goldsword.register("Golden Sword","A warrior's ultimate killing machine",8);
  
  pistol = new IcoButton(40,40);
  pistol.buttonMode(CORNER);
  pistol.setLocation(340,60);
  pistol.loadImg("/data/icons/pistol.png");
  pistol.register("Semi Pistol","Why is this even in the game",9);
  
  bomb = new IcoButton(40,40);
  bomb.buttonMode(CORNER);
  bomb.setLocation(400,60);
  bomb.loadImg("/data/icons/bomb.png");
  bomb.register("Bomb","Allahu Akbar",10);
  
  newLevel = new InteractiveTextField(450,40,FieldType.BASIC);
  newLevel.setTextFieldLocation(width/2,height/2);
  newLevel.setMaxChars(24);
  
  keys = new boolean[14];
  
  surface.setTitle("Gingrich Level Editor");
}

void initLevelData() {
  leveldata = new Level();
  leveldata.setLevelName(levelName);
  leveldata.setLevelSize(xTiles,yTiles);
}

void loadScriptData() {
  float xLoc = 160;
  float yLoc = 60;
  String packname;
  String packversion = "";
  String[] packinfo;
  for (int k = 0; k < loadpacks.length; k++) {
    packname = loadpacks[k];
    if (loadpacks[k].length() > 0) {
      loadscripts = loadStrings("/data/scripts/"+packname+"/loadscripts.txt");
      scriptCount += loadscripts.length;
    }
  }
  scriptedButtons = new IcoButton[scriptCount];
  scripts = new ItemScript[scriptCount];
  ids = new String[scriptCount+3];
  for (int i = 0; i < scriptedButtons.length; i++) {
    scriptedButtons[i] = new IcoButton(40,40);
    scriptedButtons[i].setLocation(xLoc,yLoc);
    xLoc += 60;
    if (xLoc > 580) {
      yLoc += 60;
      xLoc = 160;
    }
  }
  int passcount = 0;
  for (int k = 0; k < loadpacks.length; k++) {
    packname = loadpacks[k];
    if (loadpacks[k].length() > 0) {
      loadscripts = loadStrings("/data/scripts/"+packname+"/loadscripts.txt");
      packinfo = loadStrings("/data/scripts/"+packname+"/"+packname+".info");
      for (int l = 0; l < packinfo.length; l++) {
        if (packinfo[l].length() > 8 && packinfo[l].indexOf("version") != -1) {
          packversion = packinfo[l].substring(8);
        }
      }
    }
    for (int i = 0; i < loadscripts.length; i++) {
      String fileName = loadscripts[i];
      String[] file = loadStrings("/data/scripts/"+packname+"/"+fileName);
      for (int j = 0; j < file.length; j++) {
        if (file[0].substring(0,8).equals("ItemIcon")) {
          scriptedButtons[passcount].initialize();
          scriptedButtons[passcount].setPackName(packname);
          scriptedButtons[passcount].setPackVersion(packversion);
          if (file[j].length() > 5 && file[j].substring(0,4).equals("name")) {
            scriptedButtons[passcount].setButtonName(file[j].substring(file[j].indexOf(" ")+1));
          }
          if (file[j].length() > 12 && file[j].substring(0,11).equals("description")) {
            scriptedButtons[passcount].setButtonDesc(file[j].substring(file[j].indexOf(" ")+1));
          }
          if (file[j].length() > 3 && file[j].substring(0,2).equals("id")) {
            scriptedButtons[passcount].setLocalVal(int(file[j].substring(file[j].indexOf(" ")+1)));
          }
          if (file[j].length() > 5 && file[j].substring(0,7).equals("imgpath")) {
            scriptedButtons[passcount].loadImg(file[j].substring(file[j].indexOf(" ")+1));
          }
          if (file[j].length() > 9 && file[j].substring(0,9).equals("invisible")) {
            scriptedButtons[passcount].loadImg("/data/icons/empty.png");
          }
          ids[0] = "=======AUTO-GENERATED ID LIST=======";
          ids[1] = "THIS FILE LISTS EVERY SCRIPTED ITEM AVAILABLE IN THE EDITOR";
          ids[2] = "";
          ids[passcount+3] = "PACK:    "+packname+"    NAME: "+scriptedButtons[i].getButtonName() + "    ID: "+scriptedButtons[i].getLocalVal();
        }  
      }
      passcount++;
    }
  }
  saveStrings("/data/scripts/idlist.txt",ids);
}

void drawScriptedButtons() {
  for (int i = 0; i < scriptedButtons.length; i++) {
    if (scriptedButtons[i].isInitialized()) {
      scriptedButtons[i].drawButton();
    }
  }
}

void drawItemButtons() {
  drawScriptedButtons();
  
  /*
  shortsword.drawButton();
  longsword.drawButton();
  goldsword.drawButton();
  pistol.drawButton();
  bomb.drawButton();
  */
}

void draw() {
  resetFrame();
  //debug();
  handleMenus();
  if (inApp) {
    runOnce();
    translate(xTr,yTr);
    drawTiles();
    translate(-xTr,-yTr);
    drawToolbar();
    drawButtons();
    translateAction();
    if (inExitDialogue) {
      displayExitDialogue();
    }
    if (inItemMenu) {
      drawItemMenu();
    }
  }
  endOfFrame();
}

void drawItemMenu() {
  itemMenu.beginDraw();
  itemMenu.background(120);
  itemMenu.rectMode(CORNER);
  itemMenu.strokeWeight(2);
  itemMenu.fill(120);
  itemMenu.rect(0,0,itemMenu.width-1,itemMenu.height-1);
  itemMenu.endDraw();
  
  itemInfo.beginDraw();
  itemInfo.background(120);
  itemInfo.rectMode(CORNER);
  itemInfo.strokeWeight(1);
  itemInfo.fill(120);
  itemInfo.rect(0,0,itemInfo.width-1,itemInfo.height-1);
  itemInfo.fill(0);
  itemInfo.textAlign(LEFT,CENTER);
  itemInfo.textFont(harambe50);
  itemInfo.text(itemInfoName,10,30);
  itemInfo.textAlign(LEFT);
  itemInfo.textFont(harambe20);
  itemInfo.text(itemInfoDesc,10,90,(itemInfo.width)-20,(itemInfo.height)-100);
  itemInfo.endDraw();
  
  imageMode(CENTER);
  image(itemMenu,width/2,(height/2)-75);
  imageMode(CORNER);
  image(itemInfo,150,650);
  
  drawItemButtons();
  
  itemMenuAction();
}

void endOfFrame() {
  if (exitOnNextFrame) {
    saveMap();
    exit();
  }
}

void displayExitDialogue() {
  exitDialogue.beginDraw();
  exitDialogue.strokeWeight(2);
  exitDialogue.fill(120);
  exitDialogue.rect(0,0,exitDialogue.width,exitDialogue.height);
  exitDialogue.fill(0);
  exitDialogue.textAlign(CENTER,CENTER);
  exitDialogue.textFont(harambe50);
  exitDialogue.text("Save?",exitDialogue.width/2,25);
  exitDialogue.endDraw();
  imageMode(CENTER);
  image(exitDialogue,width/2,height/2);
  yesSave.drawButton();
  noSave.drawButton();
}

void handleMenus() {
  if (inMenu) {
    drawMenu();
  }
  if (inNewLvl) {
    drawLvlMenu();
  }
}

void drawLvlMenu() {
  newLvlMenu.beginDraw();
  newLvlMenu.background(150);
  newLvlMenu.strokeWeight(1);
  newLvlMenu.fill(0);
  //newLvlMenu.textSize(50);
  newLvlMenu.textFont(harambe50);
  newLvlMenu.textAlign(CENTER,CENTER);
  newLvlMenu.text("Name your level (no caps).",width/2,100);
  newLvlMenu.endDraw();
  imageMode(CORNER);
  image(newLvlMenu,0,0);
  newLevel.updateTextField();
  newLvlTextChecker();
}

void drawMenu() {
  menu.beginDraw();
  menu.stroke(0);
  menu.strokeWeight(1);
  menu.background(150);
  menu.textAlign(CENTER,CENTER);
  menu.fill(255);
  menu.textFont(harambe175);
  menu.text("Gingrich",(width/2)+15,100);
  menu.textFont(harambe130);
  menu.text("Level Editor",(width/2)+15,290);
  menu.endDraw();
  imageMode(CORNER);
  image(menu,0,0);
  newLvl.drawButton();
  loadLvl.drawButton();
}

void initTileMap() {
  tileMap = createGraphics(40*xTiles,40*yTiles);
  tileMap.beginDraw();
  tileMap.background(170);
  tileMap.stroke(0);
  for (int i = 0; i < xTiles; i++) {
    tileMap.line(40*i,0,40*i,tileMap.height);
  }
  for (int i = 0; i < yTiles; i++) {
    tileMap.line(0,40*i,tileMap.width,40*i);
  }
  tileMap.endDraw();
}

void drawTileMap() {
  tileMap.beginDraw();
  for (int y = 0; y < yTiles; y++) {
    for (int x = 0; x < xTiles; x++) {
      tileMap.rectMode(CORNER);
      int lVal = tiles[x][y].getLocalVal();
      if (lVal == 1) {
        tileMap.fill(0);
        tileMap.rect(40*x,40*y,40,40);
      }
      if (lVal == 2) {
        tileMap.fill(0,255,0);
        tileMap.rect(40*x,40*y,40,40);
      }
      if (lVal == 3) {
        tileMap.fill(0,0,255);
        tileMap.rect(40*x,40*y,40,40);
      }
      if (lVal == 4) {
        tileMap.imageMode(CORNER);
        tileMap.image(enemy.getImg(),40*x,40*y);
      }
      if (lVal != 0 && lVal != 1 && lVal != 2 && lVal != 3 && lVal != 4) {
        for (int i = 0; i < scriptedButtons.length; i++) {
          if (scriptedButtons[i].getLocalVal() == lVal) {
            tileMap.imageMode(CORNER);
            tileMap.image(scriptedButtons[i].getImg(),40*x,40*y);
          }
        }
      }
    }
  }
  tileMap.endDraw();
}

String nameFixer(String input) {
  String output = "";
  if (input.length() < 1) {
    return "empty";
  }
  for (int i = 0; i < input.length(); i++) {
    char c = input.charAt(i);
    if (c == '#' || c == '%' || c == '&' || c == '{' || c == '}' || c == '\\' || c == '<' || c == '>' || c == '*' || c == '?' || c == '/' || c == ' ' || c == '$' || c == '!' || c == '\'' || c == '\"' || c == ':' || c == '@') {
      output = output + "";
    } else {
      output = output + c;
    }
  }
  if (output.length() < 1) {
    return "invalidname";
  }
  return output;
}

void newLvlTextChecker() {
  if (newLevel.isSubmitted() && !textCheckerRan) {
    textCheckerRan = true;
    levelName = newLevel.receiveInput();
    levelName = nameFixer(levelName);
    surface.setTitle("Gingrich Level Editor - "+levelName);
    inMenu = false;
    inNewLvl = false;
    inApp = true;
  }
}

void menuAction() {
  if (newLvl.isHovering()) {
    inMenu = false;
    inNewLvl = true;
  }
}

void mouseReleased() {
  if (inApp && !inItemMenu) {
    if (wall.isHovering()) {
      globalVal = 1;
      current = "core.1";
    }
    if (end.isHovering()) {
      globalVal = 2;
      current = "core.2";
    }
    if (start.isHovering()) {
      globalVal = 3;
      current = "core.3";
    }
    if (enemy.isHovering()) {
      globalVal = 4;
      current = "core.4";
    }
  
    if (saveLvl.isHovering()) {
      saveMap();
    }
    if (exitEditor.isHovering()) {
      inExitDialogue = true;
    }
  
    if (inExitDialogue) {
      if (yesSave.isHovering()) {
        inExitDialogue = false;
        inItemMenu = false;
        exitOnNextFrame = true;
      }
      if (noSave.isHovering()) {
        exit();
      }
    }
  }
  if (inApp) {
    if (chest.isHovering()) {
      inItemMenu = !inItemMenu;
    }
  }
  if (inItemMenu) {
    for (int i = 0; i < scriptedButtons.length; i++) {
      if (scriptedButtons[i].isHovering()) {
        if (packNameList.indexOf(scriptedButtons[i].getPackName()) == -1) {
          packNameList = packNameList + scriptedButtons[i].getPackName() + ",";
          packVersionList = packVersionList + scriptedButtons[i].getPackVersion() + ",";
        }
        globalVal = scriptedButtons[i].getLocalVal();
        current = scriptedButtons[i].getPackName() + "." + globalVal;
        inItemMenu = false;
      }
    }
  }
  if (inMenu) {
    menuAction();
  }
}

void itemMenuAction() {
  scriptedButtonAction();
  
  /*
  if (shortsword.isHovering()) {
    displayInfo(shortsword.getButtonName(),shortsword.getButtonDesc());
    done();
  }
  if (longsword.isHovering()) {
    displayInfo(longsword.getButtonName(),longsword.getButtonDesc());
    done();
  }
  if (goldsword.isHovering()) {
    displayInfo(goldsword.getButtonName(),goldsword.getButtonDesc());
    done();
  }
  if (pistol.isHovering()) {
    displayInfo(pistol.getButtonName(),pistol.getButtonDesc());
    done();
  }
  if (bomb.isHovering()) {
    displayInfo(bomb.getButtonName(),bomb.getButtonDesc());
    done();
  }
  */
  if (!done) {
    displayInfo("","");
  }
  done = false;
}

void scriptedButtonAction() {
  for (int i = 0; i < scriptedButtons.length; i++) {
    if (scriptedButtons[i].isInitialized() && scriptedButtons[i].isHovering()) {
      displayInfo(scriptedButtons[i].getButtonName(),scriptedButtons[i].getButtonDesc());
      done();
    }
  }
}

void done() {
  done = true;
}

void displayInfo(String name, String desc) {
  itemInfoName = name;
  itemInfoDesc = desc;
}
  

void keyPressed() {
  if (keyCode == SHIFT) {
    keys[11] = true;
  }
  if (keyCode == BACKSPACE) {
    keys[12] = true;
  }
  if (keyCode == ENTER) {
    keys[13] = true;
  }
  
  switch (keyCode) {
    case 65:
    case LEFT:
      keys[0] = true;
      break;
    case 87:
    case UP:
      keys[1] = true;
      break;
    case 68:
    case RIGHT:
      keys[2] = true;
      break;
    case 83:
    case DOWN:
      keys[3] = true;
      break;
  }
}

void keyReleased() {
  if (keyCode == SHIFT) {
    keys[11] = false;
  }
  if (keyCode == BACKSPACE) {
    keys[12] = false;
  }
  if (keyCode == ENTER) {
    keys[13] = true;
  }
  
  switch (keyCode) {
    case 65:
    case LEFT:
      keys[0] = false;
      break;
    case 87:
    case UP:
      keys[1] = false;
      break;
    case 68:
    case RIGHT:
      keys[2] = false;
      break;
    case 83:
    case DOWN:
      keys[3] = false;
      break;
  }
}

void translateAction() {
  float trInterval = 10;
  if (inApp && !inExitDialogue && !inItemMenu) {
    if (keys[0]) {
      xTr += trInterval;
    }
    if (keys[1]) {
      yTr += trInterval;
    }
    if (keys[2]) {
      xTr -= trInterval;
    }
    if (keys[3]) {
      yTr -= trInterval;
    }
  }
  xTr = constrain(xTr,-((40*xTiles)-800),0);
  yTr = constrain(yTr,-((40*yTiles)-800),0);
}

void drawButtons() {
  wall.drawButton();
  end.drawButton();
  start.drawButton();
  enemy.drawButton();
  chest.drawButton();
  
  saveLvl.drawButton();
  exitEditor.drawButton();
}

void debug() {
  inMenu = false;
  inApp = true;
}

void resetFrame() {
  background(120);
}

void initTiles() {
  tiles[0][0] = new Tile(0,50);
  float yInc = 50;
  float xInc = 0;
  for (int y = 0; y < yTiles; y++) {
    for (int x = 0; x < xTiles; x++) {
      tiles[x][y] = new Tile(xInc,yInc);
      map[x][y] = "core.0";
      xInc += 40;
    }
    yInc += 40;
    xInc = 0;
  }
}

void drawTiles() {
  rectMode(CORNER);
  strokeWeight(1);
  stroke(0);
  for (int y = 0; y < yTiles; y++) {
    for (int x = 0; x < xTiles; x++) {
      tiles[x][y].drawTile();
      clickHandler(x,y);
    }
  }
  
  //Outer wall
  for (int i = 0; i < xTiles; i++) {
    tiles[i][0].setLocalVal(1);
    map[i][0] = "core.1";
    tiles[i][yTiles-1].setLocalVal(1);
    map[i][yTiles-1] = "core.1";
  }
  for (int i = 0; i < yTiles; i++) {
    tiles[0][i].setLocalVal(1);
    map[0][i] = "core.1";
    tiles[xTiles-1][i].setLocalVal(1);
    map[xTiles-1][i] = "core.1";
  }
  
}

void saveMap() {
  String[] stringMap = new String[yTiles];
  
  for (int i = 0; i < yTiles; i++) {
    if (arrayCopyMode) {
      mapData[i] = "{";
      stringMap[i] = "";
    } else {
      mapData[i] = "";
      stringMap[i] = "";
    }
  }
  for (int y = 0; y < yTiles; y++) {
    for (int x = 0; x < xTiles; x++) {
      mapData[y] = mapData[y] + tiles[x][y].getLocalVal();
      stringMap[y] = stringMap[y] + map[x][y];
      mapData[y] = mapData[y] + tiles[x][y].getLocalVal();
      if (x != (xTiles-1)) {
        mapData[y] = mapData[y] + ",";
        stringMap[y] = stringMap[y] + ",";
      }
      if (arrayCopyMode) {
        if (x == xTiles-1 && y != yTiles-1) {
          mapData[y] = mapData[y] + "},";
        }
        if (x == xTiles-1 && y == yTiles-1) {
          mapData[y] = mapData[y] + "}";
        }
      }
    }
  }
  leveldata.saveLevelStrings();
  saveStrings("/data/levels/"+levelName+"/"+levelName+".pgn",mapData);
  saveStrings("/data/levels/"+levelName+"/"+levelName+".gng",stringMap);
  saveStrings("data/levels/"+levelName+"/"+levelName+".dat",leveldata.getLvlData());
  saveStrings("data/levels/"+levelName+"/"+levelName+".txt",leveldata.getTxtData());
  drawTileMap();
  tileMap.save("/data/levels/"+levelName+"/"+levelName+".png");
}

void clickHandler(int xVal, int yVal) {
  boolean inBounds = mouseX > tiles[xVal][yVal].getX()+xTr && mouseX < (tiles[xVal][yVal].getX()+xTr + 40) && mouseY > tiles[xVal][yVal].getY()+yTr && mouseY < (tiles[xVal][yVal].getY()+yTr + (40));
  if (mousePressed && !inExitDialogue && !inItemMenu) {
    if (inBounds && mouseY >= 50) {
      if (mouseButton == LEFT) {
        tiles[xVal][yVal].setLocalVal(globalVal);
        map[xVal][yVal] = current;
      }
      if (mouseButton == RIGHT) {
        tiles[xVal][yVal].setLocalVal(0);
        map[xVal][yVal] = "core.0";
      }
    }
  }
}

void drawToolbar() {
  imageMode(CORNER);
  image(toolbar,0,0);
  toolbar.beginDraw();
  toolbar.strokeWeight(2);
  toolbar.background(120);
  toolbar.endDraw();
}

void runOnce() {
  if (!ranOnce) {
    initTiles();
    loadScriptData();
    initTileMap();
    initLevelData();
    
    ranOnce = true;
  }
}