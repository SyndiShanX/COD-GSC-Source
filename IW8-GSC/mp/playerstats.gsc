/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\playerstats.gsc
***********************************************/

init() {
  if(!level.onlinestatsenabled) {
    return;
  }
  level.playerstats = spawnStruct();
  var_0 = level.playerstats;
  var_0.statgroups = [];
  var_0.disabledstats = [];
  var_0.enabled = 1;
  var_0.readonly = 0;
  var_0.ratios = [];
  var_0.ratiochildren = [];
  var_0.disabledpaths = [];
  scripts\mp\playerstats_interface::registerplayerstatratio(["_encstr_9BBC0C0BB76BF6F74D17C39A1B26", "_encstr_A283083FB0DFF9DB7310"], ["_encstr_9BBC0C0BB76BF6F74D17C39A1B26", "_encstr_8E8D0697EB01F243"], ["_encstr_9BBC0C0BB76BF6F74D17C39A1B26", "_encstr_8E0607055DBFB3919A"]);
  scripts\mp\playerstats_interface::registerplayerstatratio(["_encstr_9BBC0C0BB76BF6F74D17C39A1B26", "_encstr_82DD09CFCB90B55651A6EB"], ["_encstr_9BBC0C0BB76BF6F74D17C39A1B26", "_encstr_88CC0521F3A13B"], ["_encstr_9BBC0C0BB76BF6F74D17C39A1B26", "_encstr_972C0B3AF63A8563A6D07B3ADC"]);
  scripts\mp\playerstats_interface::registerplayerstatratio(["_encstr_AA270B12190951B94784B87C6B", "_encstr_A34B0D730A23B1E852FB25BB043C20"], ["_encstr_AA270B12190951B94784B87C6B", "_encstr_A9F6058464DADF"], ["_encstr_AA270B12190951B94784B87C6B", "_encstr_956807294FC34ED073"]);
  addtostatgroup("_encstr_931904C47403", "_encstr_9BBC0C0BB76BF6F74D17C39A1B26", "_encstr_8E8D0697EB01F243");
  addtostatgroup("_encstr_931904C47403", "_encstr_9BBC0C0BB76BF6F74D17C39A1B26", "_encstr_8E0607055DBFB3919A");
  addtostatgroup("_encstr_931904C47403", "_encstr_9BBC0C0BB76BF6F74D17C39A1B26", "_encstr_A283083FB0DFF9DB7310");
  addtostatgroup("_encstr_95FF08BB2D73137BDCE6", "_encstr_AA270B12190951B94784B87C6B", "_encstr_A9F6058464DADF");
  addtostatgroup("_encstr_95FF08BB2D73137BDCE6", "_encstr_AA270B12190951B94784B87C6B", "_encstr_956807294FC34ED073");
  addtostatgroup("_encstr_95FF08BB2D73137BDCE6", "_encstr_AA270B12190951B94784B87C6B", "_encstr_A34B0D730A23B1E852FB25BB043C20");
  addtostatgroup("_encstr_95FF08BB2D73137BDCE6", "_encstr_AA270B12190951B94784B87C6B", "_encstr_BE290ADF7BD87A638E11D27A");
  addtostatgroup("_encstr_95FF08BB2D73137BDCE6", "_encstr_AA270B12190951B94784B87C6B", "_encstr_8CEF0531B18F48");
  addtostatgroup("_encstr_956807294FC34ED073", "_encstr_AA270B12190951B94784B87C6B", "_encstr_956807294FC34ED073");
}

initplayer() {
  if(!level.onlinestatsenabled) {
    return;
  }
  if(isDefined(self.pers["_encstr_A7A20CC1D8585EAC4E9BE80B1D9B"]))
    self.playerstats = self.pers["_encstr_A7A20CC1D8585EAC4E9BE80B1D9B"];
  else {
    self.playerstats = spawnStruct();
    var_0 = self.playerstats;
    self.playerstats.values = [];
    self.playerstats.paths = [];
    self.playerstats.bufferedstats = [];
  }

  if(!scripts\mp\utility\game::runleanthreadmode())
    thread bufferedstatwritethink();
}

bufferedstatwritethink() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");

  while(!scripts\mp\flags::levelflag("_encstr_ACCF0A3B0BD6B2EBDB3BAC27")) {
    writebufferedstats();
    wait 2.0;
  }

  writebufferedstats();
}

writebufferedstats() {
  if(isai(self)) {
    return;
  }
  foreach(var_4, var_1 in self.playerstats.bufferedstats) {
    var_2 = self.playerstats.paths[var_4];
    var_3 = self.playerstats.values[var_4];
    writeplayerstat(var_3, var_2[0], var_2[1], var_2[2], var_2[3], var_2[4]);
  }

  self.playerstats.bufferedstats = [];
}

getplayerstatpathkey(var_0, var_1, var_2, var_3, var_4) {
  var_5 = "_encstr_B40101";

  if(isDefined(var_4))
    var_5 = var_0 + "_encstr_BD4C024E" + var_1 + "_encstr_BD4C024E" + var_2 + "_encstr_BD4C024E" + var_3 + "_encstr_BD4C024E" + var_4;
  else if(isDefined(var_3))
    var_5 = var_0 + "_encstr_BD4C024E" + var_1 + "_encstr_BD4C024E" + var_2 + "_encstr_BD4C024E" + var_3;
  else if(isDefined(var_2))
    var_5 = var_0 + "_encstr_BD4C024E" + var_1 + "_encstr_BD4C024E" + var_2;
  else if(isDefined(var_1))
    var_5 = var_0 + "_encstr_BD4C024E" + var_1;
  else if(isDefined(var_0))
    var_5 = var_0;

  return var_5;
}

writeplayerstat(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(isDefined(var_5))
    self setplayerdata("_encstr_8C07031599", "_encstr_A7A20CC1D8585EAC4E9AE80B1D9B", var_1, var_2, var_3, var_4, var_5, var_0);
  else if(isDefined(var_4))
    self setplayerdata("_encstr_8C07031599", "_encstr_A7A20CC1D8585EAC4E9AE80B1D9B", var_1, var_2, var_3, var_4, var_0);
  else if(isDefined(var_3))
    self setplayerdata("_encstr_8C07031599", "_encstr_A7A20CC1D8585EAC4E9AE80B1D9B", var_1, var_2, var_3, var_0);
  else if(isDefined(var_2))
    self setplayerdata("_encstr_8C07031599", "_encstr_A7A20CC1D8585EAC4E9AE80B1D9B", var_1, var_2, var_0);
  else if(isDefined(var_1))
    self setplayerdata("_encstr_8C07031599", "_encstr_A7A20CC1D8585EAC4E9AE80B1D9B", var_1, var_0);
}

readplayerstat(var_0, var_1, var_2, var_3, var_4) {
  if(isDefined(var_4))
    return self getplayerdata("_encstr_8C07031599", "_encstr_A7A20CC1D8585EAC4E9AE80B1D9B", var_0, var_1, var_2, var_3, var_4);
  else if(isDefined(var_3))
    return self getplayerdata("_encstr_8C07031599", "_encstr_A7A20CC1D8585EAC4E9AE80B1D9B", var_0, var_1, var_2, var_3);
  else if(isDefined(var_2))
    return self getplayerdata("_encstr_8C07031599", "_encstr_A7A20CC1D8585EAC4E9AE80B1D9B", var_0, var_1, var_2);
  else if(isDefined(var_1))
    return self getplayerdata("_encstr_8C07031599", "_encstr_A7A20CC1D8585EAC4E9AE80B1D9B", var_0, var_1);
  else if(isDefined(var_0))
    return self getplayerdata("_encstr_8C07031599", "_encstr_A7A20CC1D8585EAC4E9AE80B1D9B", var_0);
}

flagstatforbufferedwrite(var_0) {
  var_1 = level.playerstats;

  if(scripts\mp\flags::levelflag("_encstr_ACCF0A3B0BD6B2EBDB3BAC27")) {
    var_2 = self.playerstats.paths[var_0];
    var_3 = self.playerstats.values[var_0];
    writeplayerstat(var_3, var_2[0], var_2[1], var_2[2], var_2[3], var_2[4]);
    return;
  }

  self.playerstats.bufferedstats[var_0] = 1;
}

setplayerstat_internal(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = [var_2];
  var_7[var_7.size] = var_3;
  var_7[var_7.size] = var_4;
  var_7[var_7.size] = var_5;
  var_7[var_7.size] = var_6;
  self.playerstats.values[var_1] = var_0;
  self.playerstats.paths[var_1] = var_7;
}

addtoplayerstat_internal(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = [var_2];
  var_7[var_7.size] = var_3;
  var_7[var_7.size] = var_4;
  var_7[var_7.size] = var_5;
  var_7[var_7.size] = var_6;

  if(!isDefined(self.playerstats.paths[var_1])) {
    var_8 = readplayerstat(var_2, var_3, var_4, var_5, var_6);
    self.playerstats.values[var_1] = var_8 + var_0;
    self.playerstats.paths[var_1] = var_7;
  } else
    self.playerstats.values[var_1] = self.playerstats.values[var_1] + var_0;
}

modifystatwritability(var_0, var_1) {
  var_2 = level.playerstats;

  if(var_1) {
    var_2.disabledstats[var_0]--;

    if(var_2.disabledstats[var_0] <= 0)
      var_2.disabledstats[var_0] = undefined;
  } else if(!isDefined(var_2.disabledstats[var_0]))
    var_2.disabledstats[var_0] = 1;
  else
    var_2.disabledstats[var_0]++;
}

isstatwritable_internal(var_0) {
  return !scripts\mp\playerstats_interface::areplayerstatsreadonly() && !isDefined(level.playerstats.disabledstats[var_0]);
}

addtostatgroup(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = level.playerstats;
  var_7 = getplayerstatpathkey(var_1, var_2, var_3, var_4, var_5);

  if(!isDefined(var_6.statgroups[var_0]))
    var_6.statgroups[var_0] = [];

  var_6.statgroups[var_0][var_6.statgroups[var_0].size] = var_7;
}

modifystatgroupwritability(var_0, var_1) {
  var_2 = level.playerstats;

  foreach(var_4 in var_2.statgroups[var_0])
  modifystatwritability(var_4, var_1);
}

calculateplayerstatratio(var_0, var_1, var_2, var_3, var_4) {
  if(!scripts\mp\playerstats_interface::areplayerstatsenabled())
    return undefined;

  var_5 = level.playerstats;
  var_6 = getplayerstatpathkey(var_0, var_1, var_2, var_3, var_4);

  if(!isDefined(var_5.ratios[var_6])) {}

  if(!isstatwritable_internal(var_6)) {
    return;
  }
  var_7 = var_5.ratios[var_6]["_encstr_92F90A70056ADFE207DDF2F3"];
  var_8 = var_5.ratios[var_6]["_encstr_A68A0CC85937EDDA2DDC2C1D7BC9"];
  var_9 = scripts\mp\playerstats_interface::getplayerstat(var_7[0], var_7[1], var_7[2], var_7[3], var_7[4]);
  var_10 = scripts\mp\playerstats_interface::getplayerstat(var_8[0], var_8[1], var_8[2], var_8[3], var_8[4]);

  if(var_10 == 0)
    var_10 = 1;

  return var_9 / var_10;
}

updateplayerstatratio(var_0, var_1, var_2, var_3, var_4) {
  var_5 = calculateplayerstatratio(var_0, var_1, var_2, var_3, var_4);
  scripts\mp\playerstats_interface::setplayerstat(var_5, var_0, var_1, var_2, var_3, var_4);
}

updateplayerstatratiobuffered(var_0, var_1, var_2, var_3, var_4) {
  var_5 = calculateplayerstatratio(var_0, var_1, var_2, var_3, var_4);
  scripts\mp\playerstats_interface::setplayerstatbuffered(var_5, var_0, var_1, var_2, var_3, var_4);
}

updateparentratios(var_0) {
  var_1 = level.playerstats;

  if(!isDefined(var_1.ratiochildren[var_0])) {
    return;
  }
  foreach(var_3 in var_1.ratiochildren[var_0])
  updateplayerstatratio(var_3[0], var_3[1], var_3[2], var_3[3], var_3[4]);
}

updateparentratiosbuffered(var_0) {
  var_1 = level.playerstats;

  if(!isDefined(var_1.ratiochildren[var_0])) {
    return;
  }
  foreach(var_3 in var_1.ratiochildren[var_0])
  updateplayerstatratiobuffered(var_3[0], var_3[1], var_3[2], var_3[3], var_3[4]);
}