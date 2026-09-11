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
  var0 = tablelookuprownum("mp/gameModeMatchStats.csv", 0, level.gametype);
  var1 = level.matchstats;

  if(!isDefined(var0) || var0 < 0) {
    var1.modestatsenabled = 0;
    return;
  }

  var1.modestatsenabled = 1;
  var1.modestatmap = [];

  for(var2 = 1; var2 < 7; var2++) {
    var3 = tablelookupbyrow("mp/gameModeMatchStats.csv", var0, var2);

    if(!isDefined(var3) || var3 == "") {
      continue;
    }

    var1.modestatmap[var3] = var2 - 1;
  }
}

function watchplayerconnect() {
  for(;;) {
    level waittill("connected", var0);

    if(isai(var0)) {
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
  var0 = self.matchstats;
  self.matchstats.values = [];
  self.matchstats.paths = [];
}

function watchgameend() {
  scripts\mp\flags::levelflagwait("game_over");
  var0 = level.players;

  foreach(var2 in var0) {
    if(!isDefined(var2)) {
      continue;
    }

    writeplayerinfo(var2);
    waitframe();
  }

  level.matchstats.datawritten = 1;
}

function writeplayerinfo() {
  var0 = self.matchstats;

  if(!isDefined(var0)) {
    return;
  }

  foreach(var2 in var0.values) {
    var3 = var0.paths[var4];

    switch (var3.size) {
      case 1:
        self setplayerdata("mp", "matchStats", var3[0], var2);
        break;
      case 2:
        self setplayerdata("mp", "matchStats", var3[0], var3[1], var2);
        break;
      case 3:
        self setplayerdata("mp", "matchStats", var3[0], var3[1], var3[2], var2);
        break;
      case 4:
        self setplayerdata("mp", "matchStats", var3[0], var3[1], var3[2], var3[3], var2);
        break;
      case 5:
        self setplayerdata("mp", "matchStats", var3[0], var3[1], var3[2], var3[3], var3[4], var2);
        break;
    }
  }
}

function getmatchstatpathkey(var0) {
  var1 = "";

  for(var2 = 0; var2 < var0.size; var2++) {
    if(isDefined(var0[var2])) {
      var1 += var0[var2] + ".";
    }
  }

  return var1;
}

function setmatchstat(var0, var1, var2, var3, var4, var5) {
  if(!arematchstatsenabled()) {
    return;
  }

  var6 = [var1];

  if(isDefined(var2)) {
    GscBinSkip0(0x2e, var6.size, var2);
  }

  if(isDefined(var3)) {
    GscBinSkip0(0x2e, var6.size, var3);
  }

  if(isDefined(var4)) {
    GscBinSkip0(0x2e, var6.size, var4);
  }

  if(isDefined(var5)) {
    GscBinSkip0(0x2e, var6.size, var5);
  }

  var7 = getmatchstatpathkey(var6);
  self.matchstats.values[var7] = var0;
  self.matchstats.paths[var7] = var6;
}

function addtomatchstat(var0, var1, var2, var3, var4, var5) {
  if(!arematchstatsenabled()) {
    return;
  }

  if(!isDefined(var0)) {
    var0 = 1;
  }

  var6 = [var1];

  if(isDefined(var2)) {
    GscBinSkip0(0x2e, var6.size, var2);
  }

  if(isDefined(var3)) {
    GscBinSkip0(0x2e, var6.size, var3);
  }

  if(isDefined(var4)) {
    GscBinSkip0(0x2e, var6.size, var4);
  }

  if(isDefined(var5)) {
    GscBinSkip0(0x2e, var6.size, var5);
  }

  var7 = getmatchstatpathkey(var6);

  if(!isDefined(self.matchstats.paths[var7])) {
    self.matchstats.values[var7] = var0;
    self.matchstats.paths[var7] = var6;
    return;
  }

  self.matchstats.values[var7] += var0;
}

function getmatchstat(var0, var1, var2, var3, var4) {
  if(!arematchstatsenabled()) {
    return undefined;
  }

  var5 = [var0, var1, var2, var3, var4];
  var6 = getmatchstatpathkey(var5);

  if(!isDefined(self.matchstats.values[var6])) {
    return 0;
  }

  return self.matchstats.values[var6];
}

function getmodestatindex(var0) {
  var1 = level.matchstats;

  if(!isDefined(var1.modestatsenabled)) {
    return undefined;
  }

  return var1.modestatmap[var0];
}

function setgamemodestat(var0, var1) {
  if(!arematchstatsenabled()) {
    return;
  }

  var2 = getmodestatindex(var0);

  if(!isDefined(var2)) {
    return;
  }

  setmatchstat(var1, "modeStats", var2);
}

function addtogamemodestat(var0, var1) {
  if(!arematchstatsenabled()) {
    return;
  }

  var2 = getmodestatindex(var0);

  if(!isDefined(var2)) {
    return;
  }

  addtomatchstat(var1, "modeStats", var2);
}

function getgamemodestat(var0) {
  if(!arematchstatsenabled()) {
    return;
  }

  var1 = getmodestatindex(var0);

  if(!isDefined(var1)) {
    return;
  }

  return getmatchstat("modeStats", var1);
}

function arematchstatsenabled() {
  return isDefined(level.matchstats) && istrue(level.matchstats.enabled);
}