/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\playerstats.gsc
***********************************************/

function init() {
  if(!level.onlinestatsenabled) {
    return;
  }

  level.playerstats = spawnStruct();
  var0 = level.playerstats;
  var0.statgroups = [];
  var0.disabledstats = [];
  var0.enabled = 1;
  var0.readonly = 0;
  var0.ratios = [];
  var0.ratiochildren = [];
  var0.disabledpaths = [];
  scripts\mp\playerstats_interface::registerplayerstatratio(["combatStats", "kdRatio"], ["combatStats", "kills"], ["combatStats", "deaths"]);
  scripts\mp\playerstats_interface::registerplayerstatratio(["combatStats", "accuracy"], ["combatStats", "hits"], ["combatStats", "totalShots"]);
  scripts\mp\playerstats_interface::registerplayerstatratio(["matchStats", "winLossRatio"], ["matchStats", "wins"], ["matchStats", "losses"]);
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
    var0 = self.playerstats;
    self.playerstats.values = [];
    self.playerstats.paths = [];
    self.playerstats.bufferedstats = [];
  }

  if(!scripts\mp\utility\game::runleanthreadmode()) {
    thread bufferedstatwritethink();
    return;
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

  foreach(var1 in self.playerstats.bufferedstats) {
    var2 = self.playerstats.paths[var4];
    var3 = self.playerstats.values[var4];
    writeplayerstat(var3, var2[0], var2[1], var2[2], var2[3], var2[4]);
  }

  self.playerstats.bufferedstats = [];
}

function getplayerstatpathkey(var0, var1, var2, var3, var4) {
  var5 = "";

  if(isDefined(var4)) {
    var5 = var0 + "." + var1 + "." + var2 + "." + var3 + "." + var4;
  } else if(isDefined(var3)) {
    var5 = var0 + "." + var1 + "." + var2 + "." + var3;
  } else if(isDefined(var2)) {
    var5 = var0 + "." + var1 + "." + var2;
  } else if(isDefined(var1)) {
    var5 = var0 + "." + var1;
  } else if(isDefined(var0)) {
    var5 = var0;
  }

  return var5;
}

function writeplayerstat(var0, var1, var2, var3, var4, var5) {
  if(isDefined(var5)) {
    self setplayerdata("mp", "playerStats", var1, var2, var3, var4, var5, var0);
    return;
  }

  if(isDefined(var4)) {
    self setplayerdata("mp", "playerStats", var1, var2, var3, var4, var0);
    return;
  }

  if(isDefined(var3)) {
    self setplayerdata("mp", "playerStats", var1, var2, var3, var0);
    return;
  }

  if(isDefined(var2)) {
    self setplayerdata("mp", "playerStats", var1, var2, var0);
    return;
  }

  if(isDefined(var1)) {
    self setplayerdata("mp", "playerStats", var1, var0);
    return;
  }
}

function readplayerstat(var0, var1, var2, var3, var4) {
  if(isDefined(var4)) {
    return self getplayerdata("mp", "playerStats", var0, var1, var2, var3, var4);
  }

  if(isDefined(var3)) {
    return self getplayerdata("mp", "playerStats", var0, var1, var2, var3);
  }

  if(isDefined(var2)) {
    return self getplayerdata("mp", "playerStats", var0, var1, var2);
  }

  if(isDefined(var1)) {
    return self getplayerdata("mp", "playerStats", var0, var1);
  }

  if(isDefined(var0)) {
    return self getplayerdata("mp", "playerStats", var0);
  }
}

function flagstatforbufferedwrite(var0) {
  var1 = level.playerstats;

  if(scripts\mp\flags::levelflag("game_over")) {
    var2 = self.playerstats.paths[var0];
    var3 = self.playerstats.values[var0];
    writeplayerstat(var3, var2[0], var2[1], var2[2], var2[3], var2[4]);
    return;
  }

  self.playerstats.bufferedstats[var2] = 1;
}

function setplayerstat_internal(var0, var1, var2, var3, var4, var5, var6) {
  var7 = [var2];
  GscBinSkip0(0x2e, var7.size, var3);
}

function addtoplayerstat_internal(var0, var1, var2, var3, var4, var5, var6) {
  var7 = [var2];
  GscBinSkip0(0x2e, var7.size, var3);
}

function modifystatwritability(var0, var1) {
  var2 = level.playerstats;

  if(var1) {
    var2.disabledstats[var0]--;

    if(var2.disabledstats[var0] <= 0) {
      var2.disabledstats[var0] = undefined;
      return;
    }

    return;
  }

  if(!isDefined(var2.disabledstats[var0])) {
    var2.disabledstats[var0] = 1;
    return;
  }

  var2.disabledstats[var0]++;
}

function isstatwritable_internal(var0) {
  return !scripts\mp\playerstats_interface::areplayerstatsreadonly() && !isDefined(level.playerstats.disabledstats[var0]);
}

function addtostatgroup(var0, var1, var2, var3, var4, var5) {
  var6 = level.playerstats;
  var7 = getplayerstatpathkey(var1, var2, var3, var4, var5);

  if(!isDefined(var6.statgroups[var0])) {
    var6.statgroups[var0] = [];
  }

  var6.statgroups[var0][var6.statgroups[var0].size] = var7;
}

function modifystatgroupwritability(var0, var1) {
  var2 = level.playerstats;

  foreach(var4 in var2.statgroups[var0]) {
    modifystatwritability(var4, var1);
  }
}

function calculateplayerstatratio(var0, var1, var2, var3, var4) {
  if(!scripts\mp\playerstats_interface::areplayerstatsenabled()) {
    return undefined;
  }

  var5 = level.playerstats;
  var6 = getplayerstatpathkey(var0, var1, var2, var3, var4);

  if(isDefined(var5.ratios[var6])) {}

  if(!isstatwritable_internal(var6)) {
    return;
  }

  var7 = var5.ratios[var6]["numerator"];
  var8 = var5.ratios[var6]["denominator"];
  var9 = scripts\mp\playerstats_interface::getplayerstat(var7[0], var7[1], var7[2], var7[3], var7[4]);
  var10 = scripts\mp\playerstats_interface::getplayerstat(var8[0], var8[1], var8[2], var8[3], var8[4]);

  if(var10 == 0) {
    var10 = 1;
  }

  return var9 / var10;
}

function updateplayerstatratio(var0, var1, var2, var3, var4) {
  var5 = calculateplayerstatratio(var0, var1, var2, var3, var4);
  scripts\mp\playerstats_interface::setplayerstat(var5, var0, var1, var2, var3, var4);
}

function updateplayerstatratiobuffered(var0, var1, var2, var3, var4) {
  var5 = calculateplayerstatratio(var0, var1, var2, var3, var4);
  scripts\mp\playerstats_interface::setplayerstatbuffered(var5, var0, var1, var2, var3, var4);
}

function updateparentratios(var0) {
  var1 = level.playerstats;

  if(!isDefined(var1.ratiochildren[var0])) {
    return;
  }

  foreach(var3 in var1.ratiochildren[var0]) {
    updateplayerstatratio(var3[0], var3[1], var3[2], var3[3], var3[4]);
  }
}

function updateparentratiosbuffered(var0) {
  var1 = level.playerstats;

  if(!isDefined(var1.ratiochildren[var0])) {
    return;
  }

  foreach(var3 in var1.ratiochildren[var0]) {
    updateplayerstatratiobuffered(var3[0], var3[1], var3[2], var3[3], var3[4]);
  }
}