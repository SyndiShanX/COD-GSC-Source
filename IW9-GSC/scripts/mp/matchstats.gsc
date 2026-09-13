/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\matchstats.gsc
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
  _id_CB89110314447B2F = tablelookuprownum("mp/gameModeMatchStats.csv", 0, level.gametype);
  _id_FB34A58676A70B9C = level.matchstats;

  if(!isDefined(_id_CB89110314447B2F) || _id_CB89110314447B2F < 0) {
    _id_FB34A58676A70B9C.modestatsenabled = 0;
    return;
  }

  _id_FB34A58676A70B9C.modestatsenabled = 1;
  _id_FB34A58676A70B9C.modestatmap = [];

  for(_id_4E1C45C2B343B551 = 1; _id_4E1C45C2B343B551 < 7; _id_4E1C45C2B343B551++) {
    _id_629757F5C9E770D8 = tablelookupbyrow("mp/gameModeMatchStats.csv", _id_CB89110314447B2F, _id_4E1C45C2B343B551);

    if(!isDefined(_id_629757F5C9E770D8) || _id_629757F5C9E770D8 == "") {
      continue;
    }
    _id_FB34A58676A70B9C.modestatmap[_id_629757F5C9E770D8] = _id_4E1C45C2B343B551 - 1;
  }
}

watchplayerconnect() {
  for(;;) {
    level waittill("connected", player);

    if(isai(player)) {
      continue;
    }
    player thread initplayer();
  }
}

initplayer() {
  if(isDefined(self.pers["matchstats"]))
    self.matchstats = self.pers["matchstats"];
  else {
    self.matchstats = spawnStruct();
    _id_0E2F408CDA8155AC = self.matchstats;
    self.matchstats.values = [];
    self.matchstats.paths = [];
  }
}

watchgameend() {
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

writeplayerinfo() {
  _id_0E2F408CDA8155AC = self.matchstats;

  if(!isDefined(_id_0E2F408CDA8155AC)) {
    return;
  }
  foreach(_id_C6D773A549B2D82A, value in _id_0E2F408CDA8155AC.values) {
    patharray = _id_0E2F408CDA8155AC.paths[_id_C6D773A549B2D82A];

    switch (patharray.size) {
      case 1:
        self setplayerdata(level._id_5D69837CF4DB0407, "matchStats", patharray[0], value);
        break;
      case 2:
        self setplayerdata(level._id_5D69837CF4DB0407, "matchStats", patharray[0], patharray[1], value);
        break;
      case 3:
        self setplayerdata(level._id_5D69837CF4DB0407, "matchStats", patharray[0], patharray[1], patharray[2], value);
        break;
      case 4:
        self setplayerdata(level._id_5D69837CF4DB0407, "matchStats", patharray[0], patharray[1], patharray[2], patharray[3], value);
        break;
      case 5:
        self setplayerdata(level._id_5D69837CF4DB0407, "matchStats", patharray[0], patharray[1], patharray[2], patharray[3], patharray[4], value);
        break;
    }
  }
}

getmatchstatpathkey(patharray) {
  _id_BA170AE7DA09E6A3 = "";

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < patharray.size; _id_AC0E594AC96AA3A8++) {
    if(isDefined(patharray[_id_AC0E594AC96AA3A8]))
      _id_BA170AE7DA09E6A3 = _id_BA170AE7DA09E6A3 + (patharray[_id_AC0E594AC96AA3A8] + ".");
  }

  return _id_BA170AE7DA09E6A3;
}

setmatchstat(value, _id_59BE945B7442F9C1, _id_59BE915B7442F328, _id_59BE925B7442F55B, _id_59BE975B7443005A, _id_59BE985B7443028D) {
  if(!arematchstatsenabled()) {
    return;
  }
  patharray = [_id_59BE945B7442F9C1];

  if(isDefined(_id_59BE915B7442F328))
    patharray[patharray.size] = _id_59BE915B7442F328;

  if(isDefined(_id_59BE925B7442F55B))
    patharray[patharray.size] = _id_59BE925B7442F55B;

  if(isDefined(_id_59BE975B7443005A))
    patharray[patharray.size] = _id_59BE975B7443005A;

  if(isDefined(_id_59BE985B7443028D))
    patharray[patharray.size] = _id_59BE985B7443028D;

  _id_BE5D99E3162A7241 = getmatchstatpathkey(patharray);
  self.matchstats.values[_id_BE5D99E3162A7241] = value;
  self.matchstats.paths[_id_BE5D99E3162A7241] = patharray;
}

addtomatchstat(_id_930290D7F474A0AE, _id_59BE945B7442F9C1, _id_59BE915B7442F328, _id_59BE925B7442F55B, _id_59BE975B7443005A, _id_59BE985B7443028D) {
  if(!arematchstatsenabled()) {
    return;
  }
  if(!isDefined(_id_930290D7F474A0AE))
    _id_930290D7F474A0AE = 1;

  patharray = [_id_59BE945B7442F9C1];

  if(isDefined(_id_59BE915B7442F328))
    patharray[patharray.size] = _id_59BE915B7442F328;

  if(isDefined(_id_59BE925B7442F55B))
    patharray[patharray.size] = _id_59BE925B7442F55B;

  if(isDefined(_id_59BE975B7443005A))
    patharray[patharray.size] = _id_59BE975B7443005A;

  if(isDefined(_id_59BE985B7443028D))
    patharray[patharray.size] = _id_59BE985B7443028D;

  _id_BE5D99E3162A7241 = getmatchstatpathkey(patharray);

  if(!isDefined(self.matchstats.paths[_id_BE5D99E3162A7241])) {
    self.matchstats.values[_id_BE5D99E3162A7241] = _id_930290D7F474A0AE;
    self.matchstats.paths[_id_BE5D99E3162A7241] = patharray;
  } else
    self.matchstats.values[_id_BE5D99E3162A7241] = self.matchstats.values[_id_BE5D99E3162A7241] + _id_930290D7F474A0AE;
}

getmatchstat(_id_59BE945B7442F9C1, _id_59BE915B7442F328, _id_59BE925B7442F55B, _id_59BE975B7443005A, _id_59BE985B7443028D) {
  if(!arematchstatsenabled())
    return undefined;

  patharray = [_id_59BE945B7442F9C1, _id_59BE915B7442F328, _id_59BE925B7442F55B, _id_59BE975B7443005A, _id_59BE985B7443028D];
  _id_BE5D99E3162A7241 = getmatchstatpathkey(patharray);

  if(!isDefined(self.matchstats.values[_id_BE5D99E3162A7241]))
    return 0;

  return self.matchstats.values[_id_BE5D99E3162A7241];
}

getmodestatindex(_id_629757F5C9E770D8) {
  _id_FB34A58676A70B9C = level.matchstats;

  if(!isDefined(_id_FB34A58676A70B9C.modestatsenabled))
    return undefined;

  return _id_FB34A58676A70B9C.modestatmap[_id_629757F5C9E770D8];
}

setgamemodestat(_id_629757F5C9E770D8, _id_8F617FFD000EB682) {
  if(!arematchstatsenabled()) {
    return;
  }
  _id_C26B99E352B50C49 = getmodestatindex(_id_629757F5C9E770D8);

  if(!isDefined(_id_C26B99E352B50C49)) {
    return;
  }
  setmatchstat(_id_8F617FFD000EB682, "modeStats", _id_C26B99E352B50C49);
}

addtogamemodestat(_id_629757F5C9E770D8, _id_930290D7F474A0AE) {
  if(!arematchstatsenabled()) {
    return;
  }
  _id_C26B99E352B50C49 = getmodestatindex(_id_629757F5C9E770D8);

  if(!isDefined(_id_C26B99E352B50C49)) {
    return;
  }
  addtomatchstat(_id_930290D7F474A0AE, "modeStats", _id_C26B99E352B50C49);
}

getgamemodestat(_id_629757F5C9E770D8) {
  if(!arematchstatsenabled()) {
    return;
  }
  _id_C26B99E352B50C49 = getmodestatindex(_id_629757F5C9E770D8);

  if(!isDefined(_id_C26B99E352B50C49)) {
    return;
  }
  return getmatchstat("modeStats", _id_C26B99E352B50C49);
}

arematchstatsenabled() {
  return isDefined(level.matchstats) && istrue(level.matchstats.enabled);
}