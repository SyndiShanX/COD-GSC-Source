/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\matchstats.gsc
***********************************************/

#using scripts\common\utility;
#using scripts\engine\utility;
#using scripts\mp\flags;
#namespace matchstats;

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
  row = tablelookuprownum("mp/gameModeMatchStats.csv", 0, level.gametype);
  var_fb34a58676a70b9c = level.matchstats;

  if(!isDefined(row) || row < 0) {
    println("<dev string:x1c>");
    var_fb34a58676a70b9c.modestatsenabled = 0;
    return;
  }

  var_fb34a58676a70b9c.modestatsenabled = 1;
  var_fb34a58676a70b9c.modestatmap = [];

  for(columnindex = 1; columnindex < 7; columnindex++) {
    statname = tablelookupbyrow("mp/gameModeMatchStats.csv", row, columnindex);

    if(!isDefined(statname) || statname == "") {
      continue;
    }

    var_fb34a58676a70b9c.modestatmap[statname] = columnindex - 1;
  }
}

function watchplayerconnect() {
  while(true) {
    level waittill("connected", player);

    if(isai(player)) {
      continue;
    }

    player thread initplayer();
  }
}

function initplayer() {
  if(isDefined(self.pers["matchstats"])) {
    self.matchstats = self.pers["matchstats"];
    return;
  }

  self.matchstats = spawnStruct();
  var_e2f408cda8155ac = self.matchstats;
  self.matchstats.values = [];
  self.matchstats.paths = [];
}

function watchgameend() {
  scripts\mp\flags::levelflagwait("game_over");
  players = level.players;

  foreach(player in players) {
    if(!isDefined(player)) {
      continue;
    }

    player writeplayerinfo();
    waitframe();
  }

  level.matchstats.datawritten = 1;
}

function writeplayerinfo() {
  var_e2f408cda8155ac = self.matchstats;

  if(!isDefined(var_e2f408cda8155ac)) {
    return;
  }

  assert(var_e2f408cda8155ac.paths.size == var_e2f408cda8155ac.values.size);

  foreach(statkey, value in var_e2f408cda8155ac.values) {
    patharray = var_e2f408cda8155ac.paths[statkey];

    switch (patharray.size) {
      case 1:
        self setplayerdata(level.progressiongroup, "matchStats", patharray[0], value);
        break;
      case 2:
        self setplayerdata(level.progressiongroup, "matchStats", patharray[0], patharray[1], value);
        break;
      case 3:
        self setplayerdata(level.progressiongroup, "matchStats", patharray[0], patharray[1], patharray[2], value);
        break;
      case 4:
        self setplayerdata(level.progressiongroup, "matchStats", patharray[0], patharray[1], patharray[2], patharray[3], value);
        break;
      case 5:
        self setplayerdata(level.progressiongroup, "matchStats", patharray[0], patharray[1], patharray[2], patharray[3], patharray[4], value);
        break;
    }
  }
}

function getmatchstatpathkey(patharray) {
  pathstring = "";

  for(i = 0; i < patharray.size; i++) {
    if(isDefined(patharray[i])) {
      pathstring += patharray[i] + ".";
    }
  }

  return pathstring;
}

function setmatchstat(value, path1, path2, path3, path4, path5) {
  if(!arematchstatsenabled()) {
    return;
  }

  assertex(!level.matchstats.datawritten, "<dev string:x69>");
  patharray = [path1];

  if(isDefined(path2)) {
    patharray[patharray.size] = path2;
  }

  if(isDefined(path3)) {
    patharray[patharray.size] = path3;
  }

  if(isDefined(path4)) {
    patharray[patharray.size] = path4;
  }

  if(isDefined(path5)) {
    patharray[patharray.size] = path5;
  }

  pathkey = getmatchstatpathkey(patharray);
  self.matchstats.values[pathkey] = value;
  self.matchstats.paths[pathkey] = patharray;
}

function addtomatchstat(var_930290d7f474a0ae, path1, path2, path3, path4, path5) {
  if(!arematchstatsenabled()) {
    return;
  }

  assertex(!level.matchstats.datawritten, "<dev string:x69>");

  if(!isDefined(var_930290d7f474a0ae)) {
    var_930290d7f474a0ae = 1;
  }

  patharray = [path1];

  if(isDefined(path2)) {
    patharray[patharray.size] = path2;
  }

  if(isDefined(path3)) {
    patharray[patharray.size] = path3;
  }

  if(isDefined(path4)) {
    patharray[patharray.size] = path4;
  }

  if(isDefined(path5)) {
    patharray[patharray.size] = path5;
  }

  pathkey = getmatchstatpathkey(patharray);

  if(!isDefined(self.matchstats.paths[pathkey])) {
    self.matchstats.values[pathkey] = var_930290d7f474a0ae;
    self.matchstats.paths[pathkey] = patharray;
    return;
  }

  self.matchstats.values[pathkey] += var_930290d7f474a0ae;
}

function getmatchstat(path1, path2, path3, path4, path5) {
  if(!arematchstatsenabled()) {
    return undefined;
  }

  patharray = [path1, path2, path3, path4, path5];
  pathkey = getmatchstatpathkey(patharray);

  if(!isDefined(self.matchstats.values[pathkey])) {
    return 0;
  }

  return self.matchstats.values[pathkey];
}

function getmodestatindex(statname) {
  var_fb34a58676a70b9c = level.matchstats;

  if(!isDefined(var_fb34a58676a70b9c.modestatsenabled)) {
    return undefined;
  }

  return var_fb34a58676a70b9c.modestatmap[statname];
}

function setgamemodestat(statname, newvalue) {
  if(!arematchstatsenabled()) {
    return;
  }

  statindex = getmodestatindex(statname);

  if(!isDefined(statindex)) {
    assertmsg("<dev string:xb5>" + statname + "<dev string:xd7>");
    return;
  }

  setmatchstat(newvalue, "modeStats", statindex);
}

function addtogamemodestat(statname, var_930290d7f474a0ae) {
  if(!arematchstatsenabled()) {
    return;
  }

  statindex = getmodestatindex(statname);

  if(!isDefined(statindex)) {
    assertmsg("<dev string:x116>" + statname + "<dev string:xd7>");
    return;
  }

  addtomatchstat(var_930290d7f474a0ae, "modeStats", statindex);
}

function getgamemodestat(statname) {
  if(!arematchstatsenabled()) {
    return;
  }

  statindex = getmodestatindex(statname);

  if(!isDefined(statindex)) {
    assertmsg("<dev string:x116>" + statname + "<dev string:xd7>");
    return;
  }

  return getmatchstat("modeStats", statindex);
}

function arematchstatsenabled() {
  return isDefined(level.matchstats) && istrue(level.matchstats.enabled);
}