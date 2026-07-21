/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\matchstats.gsc
***********************************************/

init() {
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

loadgamemodestatmap() {
  var_0 = tablelookuprownum("_encstr_83ED1A87D1B85A4948B145D589D0BDF2ED0F1BE7713733133A59C29B", 0, level.gametype);
  var_1 = level.matchstats;

  if(!isDefined(var_0) || var_0 < 0) {
    var_1.modestatsenabled = 0;
    return;
  }

  var_1.modestatsenabled = 1;
  var_1.modestatmap = [];

  for(var_2 = 1; var_2 < 7; var_2++) {
    var_3 = tablelookupbyrow("_encstr_83ED1A87D1B85A4948B145D589D0BDF2ED0F1BE7713733133A59C29B", var_0, var_2);

    if(!isDefined(var_3) || var_3 == "_encstr_B40101") {
      continue;
    }
    var_1.modestatmap[var_3] = var_2 - 1;
  }
}

watchplayerconnect() {
  for(;;) {
    level waittill("_encstr_AA940A6CB7DC9B2B6C3ACA91", var_0);

    if(isai(var_0)) {
      continue;
    }
    var_0 thread initplayer();
  }
}

initplayer() {
  if(isDefined(self.pers["_encstr_AA270B12190951B94384B87C6B"]))
    self.matchstats = self.pers["_encstr_AA270B12190951B94384B87C6B"];
  else {
    self.matchstats = spawnStruct();
    var_0 = self.matchstats;
    self.matchstats.values = [];
    self.matchstats.paths = [];
  }
}

watchgameend() {
  scripts\mp\flags::levelflagwait("_encstr_ACCF0A3B0BD6B2EBDB3BAC27");
  var_0 = level.players;

  foreach(var_2 in var_0) {
    if(!isDefined(var_2)) {
      continue;
    }
    var_2 writeplayerinfo();
    waitframe();
  }

  level.matchstats.datawritten = 1;
}

writeplayerinfo() {
  var_0 = self.matchstats;

  if(!isDefined(var_0)) {
    return;
  }
  foreach(var_4, var_2 in var_0.values) {
    var_3 = var_0.paths[var_4];

    switch (var_3.size) {
      case 1:
        self setplayerdata("_encstr_8C07031599", "_encstr_AA270B12190951B94784B87C6B", var_3[0], var_2);
        break;
      case 2:
        self setplayerdata("_encstr_8C07031599", "_encstr_AA270B12190951B94784B87C6B", var_3[0], var_3[1], var_2);
        break;
      case 3:
        self setplayerdata("_encstr_8C07031599", "_encstr_AA270B12190951B94784B87C6B", var_3[0], var_3[1], var_3[2], var_2);
        break;
      case 4:
        self setplayerdata("_encstr_8C07031599", "_encstr_AA270B12190951B94784B87C6B", var_3[0], var_3[1], var_3[2], var_3[3], var_2);
        break;
      case 5:
        self setplayerdata("_encstr_8C07031599", "_encstr_AA270B12190951B94784B87C6B", var_3[0], var_3[1], var_3[2], var_3[3], var_3[4], var_2);
        break;
    }
  }
}

getmatchstatpathkey(var_0) {
  var_1 = "_encstr_B40101";

  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    if(isDefined(var_0[var_2]))
      var_1 = var_1 + (var_0[var_2] + "_encstr_BD4C024E");
  }

  return var_1;
}

setmatchstat(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!arematchstatsenabled()) {
    return;
  }
  var_6 = [var_1];

  if(isDefined(var_2))
    var_6[var_6.size] = var_2;

  if(isDefined(var_3))
    var_6[var_6.size] = var_3;

  if(isDefined(var_4))
    var_6[var_6.size] = var_4;

  if(isDefined(var_5))
    var_6[var_6.size] = var_5;

  var_7 = getmatchstatpathkey(var_6);
  self.matchstats.values[var_7] = var_0;
  self.matchstats.paths[var_7] = var_6;
}

addtomatchstat(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!arematchstatsenabled()) {
    return;
  }
  if(!isDefined(var_0))
    var_0 = 1;

  var_6 = [var_1];

  if(isDefined(var_2))
    var_6[var_6.size] = var_2;

  if(isDefined(var_3))
    var_6[var_6.size] = var_3;

  if(isDefined(var_4))
    var_6[var_6.size] = var_4;

  if(isDefined(var_5))
    var_6[var_6.size] = var_5;

  var_7 = getmatchstatpathkey(var_6);

  if(!isDefined(self.matchstats.paths[var_7])) {
    self.matchstats.values[var_7] = var_0;
    self.matchstats.paths[var_7] = var_6;
  } else
    self.matchstats.values[var_7] = self.matchstats.values[var_7] + var_0;
}

getmatchstat(var_0, var_1, var_2, var_3, var_4) {
  if(!arematchstatsenabled())
    return undefined;

  var_5 = [var_0, var_1, var_2, var_3, var_4];
  var_6 = getmatchstatpathkey(var_5);

  if(!isDefined(self.matchstats.values[var_6]))
    return 0;

  return self.matchstats.values[var_6];
}

getmodestatindex(var_0) {
  var_1 = level.matchstats;

  if(!isDefined(var_1.modestatsenabled))
    return undefined;

  return var_1.modestatmap[var_0];
}

setgamemodestat(var_0, var_1) {
  if(!arematchstatsenabled()) {
    return;
  }
  var_2 = getmodestatindex(var_0);

  if(!isDefined(var_2)) {
    return;
  }
  setmatchstat(var_1, "_encstr_B4490A358778072F5D41334B", var_2);
}

addtogamemodestat(var_0, var_1) {
  if(!arematchstatsenabled()) {
    return;
  }
  var_2 = getmodestatindex(var_0);

  if(!isDefined(var_2)) {
    return;
  }
  addtomatchstat(var_1, "_encstr_B4490A358778072F5D41334B", var_2);
}

getgamemodestat(var_0) {
  if(!arematchstatsenabled()) {
    return;
  }
  var_1 = getmodestatindex(var_0);

  if(!isDefined(var_1)) {
    return;
  }
  return getmatchstat("_encstr_B4490A358778072F5D41334B", var_1);
}

arematchstatsenabled() {
  return isDefined(level.matchstats) && istrue(level.matchstats.enabled);
}