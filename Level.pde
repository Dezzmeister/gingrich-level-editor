public class Level {
  String[] levdata;
  String[] txtdata;
  String levelname;
  int xSize;
  int ySize;
  String creator;
  
  Level() {
  
  }
  
  Level(String filename) {
    levdata = loadStrings(filename);
  }
  
  void loadlevel(String filename) {
    levdata = loadStrings(filename);
  }
  
  void setLevelSize(int x, int y) {
    xSize = x;
    ySize = y;
  }
  
  void setLevelName(String name) {
    levelname = name;
  }
  
  void setLevelCreator(String levelCreator) {
    creator = levelCreator;
  }
  
  void saveLevelStrings() {
    packversionlist = split(packVersionList,',');
    packnamelist = split(packNameList,',');
    txtdata = new String[7+packnamelist.length];
    levdata = new String[7+packnamelist.length];
    if (devMode) {
      creator = "Dezzy";
    }
    txtdata[0] = "The name of this level is "+levelname+".";
    txtdata[1] = "";
    txtdata[2] = levelname+" was created by "+creator+" and saved on "+ month() + "/" + day() + "/" + year() + ".";
    txtdata[3] = "";
    txtdata[4] = "This folder should have the same name as the level and contain a .gng, .pgn, and .dat file. All files should have the same name as the folder.";
    txtdata[5] = "";
    txtdata[6] = "This level depends upon the following packs:";
    if (packnamelist.length > 0) {
      for (int i = 0; i < packnamelist.length-1; i++) {
        txtdata[i+7] = packnamelist[i] + "  version  "+packversionlist[i];
      }
    }
    txtdata[txtdata.length-1] = "";
    
    levdata[0] = "Level info, usable in Gingrich by Dezzy. DO NOT MODIFY THIS FILE.";
    levdata[1] = "";
    levdata[2] = "name "+levelname;
    levdata[3] = "creator "+creator;
    levdata[4] = "width "+xSize;
    levdata[5] = "height "+ySize;
    levdata[6] = "dependencies: ";
    if (packnamelist.length > 0) {
      for (int i = 0; i < packnamelist.length-1; i++) {
        levdata[i+7] = packnamelist[i] + "  version  "+packversionlist[i];
      }
    }
    levdata[levdata.length-1] = "";
  }
  
  void loadlvldata() {
    for (int i = 0; i < levdata.length; i++) {
      if (true) {
      }
    }
  }
  
  String[] getTxtData() {
    return txtdata;
  }
  
  String[] getLvlData() {
    return levdata;
  }
}