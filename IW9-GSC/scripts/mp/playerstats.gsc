/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\playerstats.gsc
***********************************************/

init() {
  if(!level.onlinestatsenabled) {
    return;
  }
  level.playerstats = spawnStruct();
  _id_584994FAB4A8712B = level.playerstats;
  _id_584994FAB4A8712B.statgroups = [];
  _id_584994FAB4A8712B.disabledstats = [];
  _id_584994FAB4A8712B.enabled = 1;
  _id_584994FAB4A8712B.readonly = 0;
  _id_584994FAB4A8712B.ratios = [];
  _id_584994FAB4A8712B.ratiochildren = [];
  _id_584994FAB4A8712B.disabledpaths = [];
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

initplayer() {
  if(!level.onlinestatsenabled) {
    return;
  }
  if(isDefined(self.pers["playerstats"]))
    self.playerstats = self.pers["playerstats"];
  else {
    self.playerstats = spawnStruct();
    _id_5571A07135BA6940 = self.playerstats;
    self.playerstats.values = [];
    self.playerstats.paths = [];
    self.playerstats.bufferedstats = [];
  }

  if(!scripts\mp\utility\game::runleanthreadmode())
    thread bufferedstatwritethink();
}

bufferedstatwritethink() {
  self endon("disconnect");

  while(!scripts\mp\flags::levelflag("game_over")) {
    writebufferedstats();
    wait 2.0;
  }

  writebufferedstats();
}

writebufferedstats() {
  if(isai(self)) {
    return;
  }
  foreach(_id_BE5D99E3162A7241, _id_97282C14346A7FCF in self.playerstats.bufferedstats) {
    patharray = self.playerstats.paths[_id_BE5D99E3162A7241];
    value = self.playerstats.values[_id_BE5D99E3162A7241];
    writeplayerstat(value, patharray[0], patharray[1], patharray[2], patharray[3], patharray[4]);
  }

  self.playerstats.bufferedstats = [];
}

getplayerstatpathkey(_id_59BE945B7442F9C1, _id_59BE915B7442F328, _id_59BE925B7442F55B, _id_59BE975B7443005A, _id_59BE985B7443028D) {
  _id_BA170AE7DA09E6A3 = "";

  if(isDefined(_id_59BE985B7443028D))
    _id_BA170AE7DA09E6A3 = _id_59BE945B7442F9C1 + "." + _id_59BE915B7442F328 + "." + _id_59BE925B7442F55B + "." + _id_59BE975B7443005A + "." + _id_59BE985B7443028D;
  else if(isDefined(_id_59BE975B7443005A))
    _id_BA170AE7DA09E6A3 = _id_59BE945B7442F9C1 + "." + _id_59BE915B7442F328 + "." + _id_59BE925B7442F55B + "." + _id_59BE975B7443005A;
  else if(isDefined(_id_59BE925B7442F55B))
    _id_BA170AE7DA09E6A3 = _id_59BE945B7442F9C1 + "." + _id_59BE915B7442F328 + "." + _id_59BE925B7442F55B;
  else if(isDefined(_id_59BE915B7442F328))
    _id_BA170AE7DA09E6A3 = _id_59BE945B7442F9C1 + "." + _id_59BE915B7442F328;
  else if(isDefined(_id_59BE945B7442F9C1))
    _id_BA170AE7DA09E6A3 = _id_59BE945B7442F9C1;

  return _id_BA170AE7DA09E6A3;
}

writeplayerstat(value, _id_59BE945B7442F9C1, _id_59BE915B7442F328, _id_59BE925B7442F55B, _id_59BE975B7443005A, _id_59BE985B7443028D) {
  if(isDefined(_id_59BE985B7443028D))
    self setplayerdata(level._id_5D69837CF4DB0407, "playerStats", _id_59BE945B7442F9C1, _id_59BE915B7442F328, _id_59BE925B7442F55B, _id_59BE975B7443005A, _id_59BE985B7443028D, value);
  else if(isDefined(_id_59BE975B7443005A))
    self setplayerdata(level._id_5D69837CF4DB0407, "playerStats", _id_59BE945B7442F9C1, _id_59BE915B7442F328, _id_59BE925B7442F55B, _id_59BE975B7443005A, value);
  else if(isDefined(_id_59BE925B7442F55B))
    self setplayerdata(level._id_5D69837CF4DB0407, "playerStats", _id_59BE945B7442F9C1, _id_59BE915B7442F328, _id_59BE925B7442F55B, value);
  else if(isDefined(_id_59BE915B7442F328))
    self setplayerdata(level._id_5D69837CF4DB0407, "playerStats", _id_59BE945B7442F9C1, _id_59BE915B7442F328, value);
  else if(isDefined(_id_59BE945B7442F9C1))
    self setplayerdata(level._id_5D69837CF4DB0407, "playerStats", _id_59BE945B7442F9C1, value);
}

readplayerstat(_id_59BE945B7442F9C1, _id_59BE915B7442F328, _id_59BE925B7442F55B, _id_59BE975B7443005A, _id_59BE985B7443028D) {
  if(isDefined(_id_59BE985B7443028D))
    return self getplayerdata(level._id_5D69837CF4DB0407, "playerStats", _id_59BE945B7442F9C1, _id_59BE915B7442F328, _id_59BE925B7442F55B, _id_59BE975B7443005A, _id_59BE985B7443028D);
  else if(isDefined(_id_59BE975B7443005A))
    return self getplayerdata(level._id_5D69837CF4DB0407, "playerStats", _id_59BE945B7442F9C1, _id_59BE915B7442F328, _id_59BE925B7442F55B, _id_59BE975B7443005A);
  else if(isDefined(_id_59BE925B7442F55B))
    return self getplayerdata(level._id_5D69837CF4DB0407, "playerStats", _id_59BE945B7442F9C1, _id_59BE915B7442F328, _id_59BE925B7442F55B);
  else if(isDefined(_id_59BE915B7442F328))
    return self getplayerdata(level._id_5D69837CF4DB0407, "playerStats", _id_59BE945B7442F9C1, _id_59BE915B7442F328);
  else if(isDefined(_id_59BE945B7442F9C1))
    return self getplayerdata(level._id_5D69837CF4DB0407, "playerStats", _id_59BE945B7442F9C1);
}

flagstatforbufferedwrite(_id_BE5D99E3162A7241) {
  _id_584994FAB4A8712B = level.playerstats;

  if(scripts\mp\flags::levelflag("game_over")) {
    patharray = self.playerstats.paths[_id_BE5D99E3162A7241];
    value = self.playerstats.values[_id_BE5D99E3162A7241];
    writeplayerstat(value, patharray[0], patharray[1], patharray[2], patharray[3], patharray[4]);
    return;
  }

  self.playerstats.bufferedstats[_id_BE5D99E3162A7241] = 1;
}

setplayerstat_internal(value, _id_BE5D99E3162A7241, _id_59BE945B7442F9C1, _id_59BE915B7442F328, _id_59BE925B7442F55B, _id_59BE975B7443005A, _id_59BE985B7443028D) {
  patharray = [_id_59BE945B7442F9C1];
  patharray[patharray.size] = _id_59BE915B7442F328;
  patharray[patharray.size] = _id_59BE925B7442F55B;
  patharray[patharray.size] = _id_59BE975B7443005A;
  patharray[patharray.size] = _id_59BE985B7443028D;
  self.playerstats.values[_id_BE5D99E3162A7241] = value;
  self.playerstats.paths[_id_BE5D99E3162A7241] = patharray;
}

addtoplayerstat_internal(_id_930290D7F474A0AE, _id_BE5D99E3162A7241, _id_59BE945B7442F9C1, _id_59BE915B7442F328, _id_59BE925B7442F55B, _id_59BE975B7443005A, _id_59BE985B7443028D) {
  patharray = [_id_59BE945B7442F9C1];
  patharray[patharray.size] = _id_59BE915B7442F328;
  patharray[patharray.size] = _id_59BE925B7442F55B;
  patharray[patharray.size] = _id_59BE975B7443005A;
  patharray[patharray.size] = _id_59BE985B7443028D;

  if(!isDefined(self.playerstats.paths[_id_BE5D99E3162A7241])) {
    _id_10DC579C373A93DD = readplayerstat(_id_59BE945B7442F9C1, _id_59BE915B7442F328, _id_59BE925B7442F55B, _id_59BE975B7443005A, _id_59BE985B7443028D);
    self.playerstats.values[_id_BE5D99E3162A7241] = _id_10DC579C373A93DD + _id_930290D7F474A0AE;
    self.playerstats.paths[_id_BE5D99E3162A7241] = patharray;
  } else
    self.playerstats.values[_id_BE5D99E3162A7241] = self.playerstats.values[_id_BE5D99E3162A7241] + _id_930290D7F474A0AE;
}

modifystatwritability(_id_BE5D99E3162A7241, _id_FA0AB025B91D42CD) {
  _id_584994FAB4A8712B = level.playerstats;

  if(_id_FA0AB025B91D42CD) {
    _id_584994FAB4A8712B.disabledstats[_id_BE5D99E3162A7241]--;

    if(_id_584994FAB4A8712B.disabledstats[_id_BE5D99E3162A7241] <= 0)
      _id_584994FAB4A8712B.disabledstats[_id_BE5D99E3162A7241] = undefined;
  } else if(!isDefined(_id_584994FAB4A8712B.disabledstats[_id_BE5D99E3162A7241]))
    _id_584994FAB4A8712B.disabledstats[_id_BE5D99E3162A7241] = 1;
  else
    _id_584994FAB4A8712B.disabledstats[_id_BE5D99E3162A7241]++;
}

isstatwritable_internal(_id_BE5D99E3162A7241) {
  return !scripts\mp\playerstats_interface::areplayerstatsreadonly() && !isDefined(level.playerstats.disabledstats[_id_BE5D99E3162A7241]);
}

addtostatgroup(_id_14E8C48563B7348A, _id_59BE945B7442F9C1, _id_59BE915B7442F328, _id_59BE925B7442F55B, _id_59BE975B7443005A, _id_59BE985B7443028D) {
  _id_584994FAB4A8712B = level.playerstats;
  _id_BE5D99E3162A7241 = getplayerstatpathkey(_id_59BE945B7442F9C1, _id_59BE915B7442F328, _id_59BE925B7442F55B, _id_59BE975B7443005A, _id_59BE985B7443028D);

  if(!isDefined(_id_584994FAB4A8712B.statgroups[_id_14E8C48563B7348A]))
    _id_584994FAB4A8712B.statgroups[_id_14E8C48563B7348A] = [];

  _id_584994FAB4A8712B.statgroups[_id_14E8C48563B7348A][_id_584994FAB4A8712B.statgroups[_id_14E8C48563B7348A].size] = _id_BE5D99E3162A7241;
}

modifystatgroupwritability(_id_14E8C48563B7348A, _id_FA0AB025B91D42CD) {
  _id_584994FAB4A8712B = level.playerstats;

  foreach(_id_BE5D99E3162A7241 in _id_584994FAB4A8712B.statgroups[_id_14E8C48563B7348A])
  modifystatwritability(_id_BE5D99E3162A7241, _id_FA0AB025B91D42CD);
}

calculateplayerstatratio(_id_59BE945B7442F9C1, _id_59BE915B7442F328, _id_59BE925B7442F55B, _id_59BE975B7443005A, _id_59BE985B7443028D) {
  if(!scripts\mp\playerstats_interface::areplayerstatsenabled())
    return undefined;

  _id_584994FAB4A8712B = level.playerstats;
  _id_BE5D99E3162A7241 = getplayerstatpathkey(_id_59BE945B7442F9C1, _id_59BE915B7442F328, _id_59BE925B7442F55B, _id_59BE975B7443005A, _id_59BE985B7443028D);

  if(!isDefined(_id_584994FAB4A8712B.ratios[_id_BE5D99E3162A7241])) {}

  if(!isstatwritable_internal(_id_BE5D99E3162A7241)) {
    return;
  }
  _id_998D185046C07E5C = _id_584994FAB4A8712B.ratios[_id_BE5D99E3162A7241]["numerator"];
  _id_85468554D750C31D = _id_584994FAB4A8712B.ratios[_id_BE5D99E3162A7241]["denominator"];
  _id_5EE2AA890B5FBE48 = scripts\mp\playerstats_interface::getplayerstat(_id_998D185046C07E5C[0], _id_998D185046C07E5C[1], _id_998D185046C07E5C[2], _id_998D185046C07E5C[3], _id_998D185046C07E5C[4]);
  _id_EC940180FF00F497 = scripts\mp\playerstats_interface::getplayerstat(_id_85468554D750C31D[0], _id_85468554D750C31D[1], _id_85468554D750C31D[2], _id_85468554D750C31D[3], _id_85468554D750C31D[4]);

  if(_id_EC940180FF00F497 == 0)
    _id_EC940180FF00F497 = 1;

  return _id_5EE2AA890B5FBE48 / _id_EC940180FF00F497;
}

updateplayerstatratio(_id_59BE945B7442F9C1, _id_59BE915B7442F328, _id_59BE925B7442F55B, _id_59BE975B7443005A, _id_59BE985B7443028D) {
  value = calculateplayerstatratio(_id_59BE945B7442F9C1, _id_59BE915B7442F328, _id_59BE925B7442F55B, _id_59BE975B7443005A, _id_59BE985B7443028D);
  scripts\mp\playerstats_interface::setplayerstat(value, _id_59BE945B7442F9C1, _id_59BE915B7442F328, _id_59BE925B7442F55B, _id_59BE975B7443005A, _id_59BE985B7443028D);
}

updateplayerstatratiobuffered(_id_59BE945B7442F9C1, _id_59BE915B7442F328, _id_59BE925B7442F55B, _id_59BE975B7443005A, _id_59BE985B7443028D) {
  value = calculateplayerstatratio(_id_59BE945B7442F9C1, _id_59BE915B7442F328, _id_59BE925B7442F55B, _id_59BE975B7443005A, _id_59BE985B7443028D);
  scripts\mp\playerstats_interface::setplayerstatbuffered(value, _id_59BE945B7442F9C1, _id_59BE915B7442F328, _id_59BE925B7442F55B, _id_59BE975B7443005A, _id_59BE985B7443028D);
}

updateparentratios(_id_795F8FA71513EBCE) {
  _id_584994FAB4A8712B = level.playerstats;

  if(!isDefined(_id_584994FAB4A8712B.ratiochildren[_id_795F8FA71513EBCE])) {
    return;
  }
  foreach(_id_558824B1025D74AB in _id_584994FAB4A8712B.ratiochildren[_id_795F8FA71513EBCE])
  updateplayerstatratio(_id_558824B1025D74AB[0], _id_558824B1025D74AB[1], _id_558824B1025D74AB[2], _id_558824B1025D74AB[3], _id_558824B1025D74AB[4]);
}

updateparentratiosbuffered(_id_795F8FA71513EBCE) {
  _id_584994FAB4A8712B = level.playerstats;

  if(!isDefined(_id_584994FAB4A8712B.ratiochildren[_id_795F8FA71513EBCE])) {
    return;
  }
  foreach(_id_558824B1025D74AB in _id_584994FAB4A8712B.ratiochildren[_id_795F8FA71513EBCE])
  updateplayerstatratiobuffered(_id_558824B1025D74AB[0], _id_558824B1025D74AB[1], _id_558824B1025D74AB[2], _id_558824B1025D74AB[3], _id_558824B1025D74AB[4]);
}