/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\matchstats.gsc
***********************************************/

function init() {
  if(!level.rankedmatch) {
    return;
  }

  level.matchstats = spawnStruct();
  level.matchstats.datawritten = 0;
  loadgamemodestatmap();
  thread watchplayerconnect();
  thread watchgameend();
  level.matchstats.enabled = 1;
}

function loadgamemodestatmap() {
  var_0 = tablelookuprownum("mp/gameModeMatchStats.csv", 0, level.gametype);
  var_1 = level.matchstats;

  if(!isDefined(var_0) || var_0 < 0) {
    var_1.modestatsenabled = 0;
    return;
  }

  var_1.modestatsenabled = 1;
  var_1.modestatmap = [];

  for(var_2 = 1; var_2 < 7; var_2++) {
    var_3 = tablelookupbyrow("mp/gameModeMatchStats.csv", var_0, var_2);

    if(!isDefined(var_3) || var_3 == "") {
      continue;
    }

    var_1.modestatmap[var_3] = var_2 - 1;
  }
}

function watchplayerconnect() {
  for(;;) {
    level waittill("connected", var_0);

    if(isai(var_0)) {
      continue;
    }

    thread initplayer();
  }
}

function initplayer() {
  if(isDefined(self.pers["matchstats"])) {
    self.matchstats = self.pers["matchstats"];
    return;
  }

  self.matchstats = spawnStruct();
  var_0 = self.matchstats;
  self.matchstats.values = [];
  self.matchstats.paths = [];
}

function watchgameend() {
  scripts\mp\flags::levelflagwait("game_over");
  var_0 = level.players;

  foreach(var_2 in var_0) {
    if(!isDefined(var_2)) {
      continue;
    }

    writeplayerinfo(var_2);
    waitframe();
  }

  level.matchstats.datawritten = 1;
}

function writeplayerinfo() {
  var_0 = self.matchstats;

  if(!isDefined(var_0)) {
    return;
  }

  foreach(var_2 in var_0.values) {
    var_3 = var_0.paths[var_4];

    switch (var_3.size) {
      case 1:
        self setplayerdata("mp", "matchStats", var_3[0], var_2);
        break;
      case 2:
        self setplayerdata("mp", "matchStats", var_3[0], var_3[1], var_2);
        break;
      case 3:
        self setplayerdata("mp", "matchStats", var_3[0], var_3[1], var_3[2], var_2);
        break;
      case 4:
        self setplayerdata("mp", "matchStats", var_3[0], var_3[1], var_3[2], var_3[3], var_2);
        break;
      case 5:
        self setplayerdata("mp", "matchStats", var_3[0], var_3[1], var_3[2], var_3[3], var_3[4], var_2);
        break;
    }
  }
}

function getmatchstatpathkey(var_0) {
  var_1 = "";

  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    if(isDefined(var_0[var_2])) {
      var_1 += var_0[var_2] + ".";
    }
  }

  return var_1;
}

function setmatchstat(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!arematchstatsenabled()) {
    return;
  }

  var_6 = [var_1];

  if(isDefined(var_2)) {
    GscBinSkip0(0x2e, var_6.size, var_2);
  }

  if(isDefined(var_3)) {
    GscBinSkip0(0x2e, var_6.size, var_3);
  }

  if(isDefined(var_4)) {
    GscBinSkip0(0x2e, var_6.size, var_4);
  }

  if(isDefined(var_5)) {
    GscBinSkip0(0x2e, var_6.size, var_5);
  }

  var_7 = getmatchstatpathkey(var_6);
  self.matchstats.values[var_7] = var_0;
  self.matchstats.paths[var_7] = var_6;
}

function addtomatchstat(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!arematchstatsenabled()) {
    return;
  }

  if(!isDefined(var_0)) {
    var_0 = 1;
  }

  var_6 = [var_1];

  if(isDefined(var_2)) {
    GscBinSkip0(0x2e, var_6.size, var_2);
  }

  if(isDefined(var_3)) {
    GscBinSkip0(0x2e, var_6.size, var_3);
  }

  if(isDefined(var_4)) {
    GscBinSkip0(0x2e, var_6.size, var_4);
  }

  if(isDefined(var_5)) {
    GscBinSkip0(0x2e, var_6.size, var_5);
  }

  var_7 = getmatchstatpathkey(var_6);

  if(!isDefined(self.matchstats.paths[var_7])) {
    self.matchstats.values[var_7] = var_0;
    self.matchstats.paths[var_7] = var_6;
    return;
  }

  self.matchstats.values[var_7] += var_0;
}

function getmatchstat(var_0, var_1, var_2, var_3, var_4) {
  if(!arematchstatsenabled()) {
    return undefined;
  }

  var_5 = [var_0, var_1, var_2, var_3, var_4];
  var_6 = getmatchstatpathkey(var_5);

  if(!isDefined(self.matchstats.values[var_6])) {
    return 0;
  }

  return self.matchstats.values[var_6];
}

function getmodestatindex(var_0) {
  var_1 = level.matchstats;

  if(!isDefined(var_1.modestatsenabled)) {
    return undefined;
  }

  return var_1.modestatmap[var_0];
}

function setgamemodestat(var_0, var_1) {
  if(!arematchstatsenabled()) {
    return;
  }

  var_2 = getmodestatindex(var_0);

  if(!isDefined(var_2)) {
    return;
  }

  setmatchstat(var_1, "modeStats", var_2);
}

function addtogamemodestat(var_0, var_1) {
  if(!arematchstatsenabled()) {
    return;
  }

  var_2 = getmodestatindex(var_0);

  if(!isDefined(var_2)) {
    return;
  }

  addtomatchstat(var_1, "modeStats", var_2);
}

function getgamemodestat(var_0) {
  if(!arematchstatsenabled()) {
    return;
  }

  var_1 = getmodestatindex(var_0);

  if(!isDefined(var_1)) {
    return;
  }

  return getmatchstat("modeStats", var_1);
}

function arematchstatsenabled() {
  return isDefined(level.matchstats) && istrue(level.matchstats.enabled);
}