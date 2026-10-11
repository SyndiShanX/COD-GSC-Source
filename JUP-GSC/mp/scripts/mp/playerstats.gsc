/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\playerstats.gsc
***********************************************/

#using scripts\common\utility;
#using scripts\engine\utility;
#using scripts\mp\flags;
#using scripts\mp\playerstats_interface;
#using scripts\mp\utility\game;
#namespace playerstats;

function init() {
  if(!level.onlinestatsenabled) {
    return;
  }

  level.playerstats = spawnStruct();
  globals = level.playerstats;
  globals.statgroups = [];
  globals.disabledstats = [];
  globals.enabled = 1;
  globals.readonly = 0;
  globals.ratios = [];
  globals.ratiochildren = [];
  globals.disabledpaths = [];
  registerplayerstatratio(["combatStats", "kdRatio"], ["combatStats", "kills"], ["combatStats", "deaths"]);
  registerplayerstatratio(["combatStats", "accuracy"], ["combatStats", "hits"], ["combatStats", "totalShots"]);
  registerplayerstatratio(["matchStats", "winLossRatio"], ["matchStats", "wins"], ["matchStats", "losses"]);
  addtostatgroup("kdr", "combatStats", "kills");
  addtostatgroup("kdr", "combatStats", "deaths");
  addtostatgroup("kdr", "combatStats", "kdRatio");
  addtostatgroup("winLoss", "matchStats", "wins");
  addtostatgroup("winLoss", "matchStats", "losses");
  addtostatgroup("winLoss", "matchStats", "winLossRatio");
  addtostatgroup("winLoss", "matchStats", "winStreak");
  addtostatgroup("winLoss", "matchStats", "ties");
  addtostatgroup("losses", "matchStats", "losses");
}

function initplayer() {
  if(!level.onlinestatsenabled) {
    return;
  }

  if(isDefined(self.pers["playerstats"])) {
    self.playerstats = self.pers["playerstats"];
  } else {
    self.playerstats = spawnStruct();
    playerplayerstats = self.playerstats;
    self.playerstats.values = [];
    self.playerstats.paths = [];
    self.playerstats.bufferedstats = [];
  }

  if(!scripts\mp\utility\game::runleanthreadmode()) {
    thread bufferedstatwritethink();
  }
}

function bufferedstatwritethink() {
  self endon("disconnect");

  while(!scripts\mp\flags::levelflag("game_over")) {
    writebufferedstats();
    wait 2;
  }

  writebufferedstats();
}

function writebufferedstats() {
  if(isai(self)) {
    return;
  }

  foreach(pathkey, unused in self.playerstats.bufferedstats) {
    patharray = self.playerstats.paths[pathkey];
    value = self.playerstats.values[pathkey];
    writeplayerstat(value, patharray[0], patharray[1], patharray[2], patharray[3], patharray[4]);
  }

  self.playerstats.bufferedstats = [];
}

function getplayerstatpathkey(path1, path2, path3, path4, path5) {
  pathstring = "";

  if(isDefined(path5)) {
    pathstring = path1 + "." + path2 + "." + path3 + "." + path4 + "." + path5;
  } else if(isDefined(path4)) {
    pathstring = path1 + "." + path2 + "." + path3 + "." + path4;
  } else if(isDefined(path3)) {
    pathstring = path1 + "." + path2 + "." + path3;
  } else if(isDefined(path2)) {
    pathstring = path1 + "." + path2;
  } else if(isDefined(path1)) {
    pathstring = path1;
  }

  return pathstring;
}

function writeplayerstat(value, path1, path2, path3, path4, path5) {
  if(isDefined(path5)) {
    self setplayerdata(level.progressiongroup, "playerStats", path1, path2, path3, path4, path5, value);
    return;
  }

  if(isDefined(path4)) {
    self setplayerdata(level.progressiongroup, "playerStats", path1, path2, path3, path4, value);
    return;
  }

  if(isDefined(path3)) {
    self setplayerdata(level.progressiongroup, "playerStats", path1, path2, path3, value);
    return;
  }

  if(isDefined(path2)) {
    self setplayerdata(level.progressiongroup, "playerStats", path1, path2, value);
    return;
  }

  if(isDefined(path1)) {
    self setplayerdata(level.progressiongroup, "playerStats", path1, value);
  }
}

function readplayerstat(path1, path2, path3, path4, path5) {
  if(isDefined(path5)) {
    return self getplayerdata(level.progressiongroup, "playerStats", path1, path2, path3, path4, path5);
  }

  if(isDefined(path4)) {
    return self getplayerdata(level.progressiongroup, "playerStats", path1, path2, path3, path4);
  }

  if(isDefined(path3)) {
    return self getplayerdata(level.progressiongroup, "playerStats", path1, path2, path3);
  }

  if(isDefined(path2)) {
    return self getplayerdata(level.progressiongroup, "playerStats", path1, path2);
  }

  if(isDefined(path1)) {
    return self getplayerdata(level.progressiongroup, "playerStats", path1);
  }
}

function flagstatforbufferedwrite(pathkey) {
  globals = level.playerstats;

  if(scripts\mp\flags::levelflag("game_over")) {
    patharray = self.playerstats.paths[pathkey];
    value = self.playerstats.values[pathkey];
    writeplayerstat(value, patharray[0], patharray[1], patharray[2], patharray[3], patharray[4]);
    return;
  }

  self.playerstats.bufferedstats[pathkey] = 1;
}

function setplayerstat_internal(value, pathkey, path1, path2, path3, path4, path5) {
  patharray = [path1];
  patharray[patharray.size] = path2;
  patharray[patharray.size] = path3;
  patharray[patharray.size] = path4;
  patharray[patharray.size] = path5;
  self.playerstats.values[pathkey] = value;
  self.playerstats.paths[pathkey] = patharray;
}

function addtoplayerstat_internal(var_930290d7f474a0ae, pathkey, path1, path2, path3, path4, path5) {
  patharray = [path1];
  patharray[patharray.size] = path2;
  patharray[patharray.size] = path3;
  patharray[patharray.size] = path4;
  patharray[patharray.size] = path5;

  if(!isDefined(self.playerstats.paths[pathkey])) {
    playerdatavalue = readplayerstat(path1, path2, path3, path4, path5);
    self.playerstats.values[pathkey] = playerdatavalue + var_930290d7f474a0ae;
    self.playerstats.paths[pathkey] = patharray;
    return;
  }

  self.playerstats.values[pathkey] += var_930290d7f474a0ae;
}

function modifystatwritability(pathkey, writable) {
  globals = level.playerstats;

  if(writable) {
    assertex(isDefined(globals.disabledstats[pathkey]) && globals.disabledstats[pathkey] > 0, "<dev string:x1c>");
    globals.disabledstats[pathkey]--;

    if(globals.disabledstats[pathkey] <= 0) {
      globals.disabledstats[pathkey] = undefined;
    }

    return;
  }

  if(!isDefined(globals.disabledstats[pathkey])) {
    globals.disabledstats[pathkey] = 1;
    return;
  }

  globals.disabledstats[pathkey]++;
}

function isstatwritable_internal(pathkey) {
  return !areplayerstatsreadonly() && !isDefined(level.playerstats.disabledstats[pathkey]);
}

function addtostatgroup(statgroup, path1, path2, path3, path4, path5) {
  globals = level.playerstats;
  pathkey = getplayerstatpathkey(path1, path2, path3, path4, path5);

  if(!isDefined(globals.statgroups[statgroup])) {
    globals.statgroups[statgroup] = [];
  }

  globals.statgroups[statgroup][globals.statgroups[statgroup].size] = pathkey;
}

function modifystatgroupwritability(statgroup, writable) {
  globals = level.playerstats;

  foreach(pathkey in globals.statgroups[statgroup]) {
    modifystatwritability(pathkey, writable);
  }
}

function calculateplayerstatratio(path1, path2, path3, path4, path5) {
  if(!areplayerstatsenabled()) {
    return undefined;
  }

  globals = level.playerstats;
  pathkey = getplayerstatpathkey(path1, path2, path3, path4, path5);

  if(!isDefined(globals.ratios[pathkey])) {
    assertmsg("<dev string:x6d>" + pathkey + "<dev string:xa0>");
  }

  if(!isstatwritable_internal(pathkey)) {
    return;
  }

  var_998d185046c07e5c = globals.ratios[pathkey]["numerator"];
  var_85468554d750c31d = globals.ratios[pathkey]["denominator"];
  numerator = getplayerstat(var_998d185046c07e5c[0], var_998d185046c07e5c[1], var_998d185046c07e5c[2], var_998d185046c07e5c[3], var_998d185046c07e5c[4]);
  denominator = getplayerstat(var_85468554d750c31d[0], var_85468554d750c31d[1], var_85468554d750c31d[2], var_85468554d750c31d[3], var_85468554d750c31d[4]);

  if(denominator == 0) {
    denominator = 1;
  }

  return numerator / denominator;
}

function updateplayerstatratio(path1, path2, path3, path4, path5) {
  value = calculateplayerstatratio(path1, path2, path3, path4, path5);
  setplayerstat(value, path1, path2, path3, path4, path5);
}

function updateplayerstatratiobuffered(path1, path2, path3, path4, path5) {
  value = calculateplayerstatratio(path1, path2, path3, path4, path5);
  setplayerstatbuffered(value, path1, path2, path3, path4, path5);
}

function updateparentratios(var_795f8fa71513ebce) {
  globals = level.playerstats;

  if(!isDefined(globals.ratiochildren[var_795f8fa71513ebce])) {
    return;
  }

  foreach(var_558824b1025d74ab in globals.ratiochildren[var_795f8fa71513ebce]) {
    updateplayerstatratio(var_558824b1025d74ab[0], var_558824b1025d74ab[1], var_558824b1025d74ab[2], var_558824b1025d74ab[3], var_558824b1025d74ab[4]);
  }
}

function updateparentratiosbuffered(var_795f8fa71513ebce) {
  globals = level.playerstats;

  if(!isDefined(globals.ratiochildren[var_795f8fa71513ebce])) {
    return;
  }

  foreach(var_558824b1025d74ab in globals.ratiochildren[var_795f8fa71513ebce]) {
    updateplayerstatratiobuffered(var_558824b1025d74ab[0], var_558824b1025d74ab[1], var_558824b1025d74ab[2], var_558824b1025d74ab[3], var_558824b1025d74ab[4]);
  }
}