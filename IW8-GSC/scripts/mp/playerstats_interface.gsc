/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\playerstats_interface.gsc
************************************************/

function setplayerstat(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!areplayerstatsenabled()) {
    return;
  }

  if(isai(self)) {
    return;
  }

  var_6 = scripts\mp\playerstats::getplayerstatpathkey(var_1, var_2, var_3, var_4, var_5);

  if(!scripts\mp\playerstats::isstatwritable_internal(var_6)) {
    return;
  }

  scripts\mp\playerstats::setplayerstat_internal(var_0, var_6, var_1, var_2, var_3, var_4, var_5);
  scripts\mp\playerstats::writeplayerstat(var_0, var_1, var_2, var_3, var_4, var_5);
  scripts\mp\playerstats::updateparentratiosbuffered(var_6);
}

function setplayerstatbuffered(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!areplayerstatsenabled()) {
    return;
  }

  if(isai(self)) {
    return;
  }

  var_6 = [var_1];
  GscBinSkip0(0x2e, var_6.size, var_2);
}

function addtoplayerstat(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!areplayerstatsenabled()) {
    return;
  }

  if(isai(self)) {
    return;
  }

  if(istrue(game["practiceRound"])) {
    return;
  }

  if(!isDefined(var_0)) {
    var_0 = 1;
  }

  var_6 = scripts\mp\playerstats::getplayerstatpathkey(var_1, var_2, var_3, var_4, var_5);

  if(!scripts\mp\playerstats::isstatwritable_internal(var_6)) {
    return;
  }

  scripts\mp\playerstats::addtoplayerstat_internal(var_0, var_6, var_1, var_2, var_3, var_4, var_5);
  scripts\mp\playerstats::writeplayerstat(self.playerstats.values[var_6], var_1, var_2, var_3, var_4, var_5);
  scripts\mp\playerstats::updateparentratios(var_6);
}

function addtoplayerstatbuffered(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!areplayerstatsenabled()) {
    return;
  }

  if(isai(self)) {
    return;
  }

  if(!isDefined(var_0)) {
    var_0 = 1;
  }

  var_6 = scripts\mp\playerstats::getplayerstatpathkey(var_1, var_2, var_3, var_4, var_5);

  if(!scripts\mp\playerstats::isstatwritable_internal(var_6)) {
    return;
  }

  scripts\mp\playerstats::addtoplayerstat_internal(var_0, var_6, var_1, var_2, var_3, var_4, var_5);
  scripts\mp\playerstats::flagstatforbufferedwrite(var_6);
  scripts\mp\playerstats::updateparentratiosbuffered(var_6);
}

function getplayerstat(var_0, var_1, var_2, var_3, var_4) {
  if(!areplayerstatsenabled()) {
    return undefined;
  }

  if(isai(self)) {
    return 0;
  }

  var_5 = scripts\mp\playerstats::getplayerstatpathkey(var_0, var_1, var_2, var_3, var_4);

  if(!isDefined(self.playerstats.values[var_5])) {
    self.playerstats.values[var_5] = scripts\mp\playerstats::readplayerstat(var_0, var_1, var_2, var_3, var_4);
  }

  return self.playerstats.values[var_5];
}

function areplayerstatsenabled() {
  return isDefined(level.playerstats) && istrue(level.playerstats.enabled);
}

function areplayerstatsreadonly() {
  return level.playerstats.readonly > 0;
}

function makeallplayerstatsreadonly() {
  level.playerstats.readonly++;
}

function makeallplayerstatswritable() {
  level.playerstats.readonly--;
}

function makeplayerstatreadonly(var_0, var_1, var_2, var_3, var_4) {
  var_5 = scripts\mp\playerstats::getplayerstatpathkey(var_0, var_1, var_2, var_3, var_4);
  return scripts\mp\playerstats::modifystatwritability(var_5, 0);
}

function makeplayerstatwritable(var_0, var_1, var_2, var_3, var_4) {
  var_5 = scripts\mp\playerstats::getplayerstatpathkey(var_0, var_1, var_2, var_3, var_4);
  return scripts\mp\playerstats::modifystatwritability(var_5, 1);
}

function isplayerstatwritable(var_0, var_1, var_2, var_3, var_4) {
  var_5 = scripts\mp\playerstats::getplayerstatpathkey(var_0, var_1, var_2, var_3, var_4);
  return scripts\mp\playerstats::isstatwritable_internal(var_5);
}

function makeplayerstatgroupreadonly(var_0) {
  scripts\mp\playerstats::modifystatgroupwritability(var_0, 0);
}

function makeplayerstatgroupwritable(var_0) {
  scripts\mp\playerstats::modifystatgroupwritability(var_0, 1);
}

function registerplayerstatratio(var_0, var_1, var_2) {
  var_3 = level.playerstats;
  var_4 = scripts\mp\playerstats::getplayerstatpathkey(var_0[0], var_0[1], var_0[2], var_0[3], var_0[4]);
  var_3.ratios[var_4] = [];
  var_3.ratios[var_4]["numerator"] = var_1;
  var_3.ratios[var_4]["denominator"] = var_2;
  var_5 = scripts\mp\playerstats::getplayerstatpathkey(var_1[0], var_1[1], var_1[2], var_1[3], var_1[4]);
  var_6 = scripts\mp\playerstats::getplayerstatpathkey(var_2[0], var_2[1], var_2[2], var_2[3], var_2[4]);

  if(!isDefined(var_3.ratiochildren[var_5])) {
    var_3.ratiochildren[var_5] = [var_0];
  } else {
    var_3.ratiochildren[var_5][var_3.ratiochildren[var_5].size] = var_0;
  }

  if(!isDefined(var_3.ratiochildren[var_6])) {
    var_3.ratiochildren[var_6] = [var_0];
    return;
  }

  var_3.ratiochildren[var_6][var_3.ratiochildren[var_6].size] = var_0;
}