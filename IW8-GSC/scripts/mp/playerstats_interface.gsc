/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\playerstats_interface.gsc
************************************************/

function setplayerstat(var0, var1, var2, var3, var4, var5) {
  if(!areplayerstatsenabled()) {
    return;
  }

  if(isai(self)) {
    return;
  }

  var6 = scripts\mp\playerstats::getplayerstatpathkey(var1, var2, var3, var4, var5);

  if(!scripts\mp\playerstats::isstatwritable_internal(var6)) {
    return;
  }

  scripts\mp\playerstats::setplayerstat_internal(var0, var6, var1, var2, var3, var4, var5);
  scripts\mp\playerstats::writeplayerstat(var0, var1, var2, var3, var4, var5);
  scripts\mp\playerstats::updateparentratiosbuffered(var6);
}

function setplayerstatbuffered(var0, var1, var2, var3, var4, var5) {
  if(!areplayerstatsenabled()) {
    return;
  }

  if(isai(self)) {
    return;
  }

  var6 = [var1];
  GscBinSkip0(0x2e, var6.size, var2);
}

function addtoplayerstat(var0, var1, var2, var3, var4, var5) {
  if(!areplayerstatsenabled()) {
    return;
  }

  if(isai(self)) {
    return;
  }

  if(istrue(game["practiceRound"])) {
    return;
  }

  if(!isDefined(var0)) {
    var0 = 1;
  }

  var6 = scripts\mp\playerstats::getplayerstatpathkey(var1, var2, var3, var4, var5);

  if(!scripts\mp\playerstats::isstatwritable_internal(var6)) {
    return;
  }

  scripts\mp\playerstats::addtoplayerstat_internal(var0, var6, var1, var2, var3, var4, var5);
  scripts\mp\playerstats::writeplayerstat(self.playerstats.values[var6], var1, var2, var3, var4, var5);
  scripts\mp\playerstats::updateparentratios(var6);
}

function addtoplayerstatbuffered(var0, var1, var2, var3, var4, var5) {
  if(!areplayerstatsenabled()) {
    return;
  }

  if(isai(self)) {
    return;
  }

  if(!isDefined(var0)) {
    var0 = 1;
  }

  var6 = scripts\mp\playerstats::getplayerstatpathkey(var1, var2, var3, var4, var5);

  if(!scripts\mp\playerstats::isstatwritable_internal(var6)) {
    return;
  }

  scripts\mp\playerstats::addtoplayerstat_internal(var0, var6, var1, var2, var3, var4, var5);
  scripts\mp\playerstats::flagstatforbufferedwrite(var6);
  scripts\mp\playerstats::updateparentratiosbuffered(var6);
}

function getplayerstat(var0, var1, var2, var3, var4) {
  if(!areplayerstatsenabled()) {
    return undefined;
  }

  if(isai(self)) {
    return 0;
  }

  var5 = scripts\mp\playerstats::getplayerstatpathkey(var0, var1, var2, var3, var4);

  if(!isDefined(self.playerstats.values[var5])) {
    self.playerstats.values[var5] = scripts\mp\playerstats::readplayerstat(var0, var1, var2, var3, var4);
  }

  return self.playerstats.values[var5];
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

function makeplayerstatreadonly(var0, var1, var2, var3, var4) {
  var5 = scripts\mp\playerstats::getplayerstatpathkey(var0, var1, var2, var3, var4);
  return scripts\mp\playerstats::modifystatwritability(var5, 0);
}

function makeplayerstatwritable(var0, var1, var2, var3, var4) {
  var5 = scripts\mp\playerstats::getplayerstatpathkey(var0, var1, var2, var3, var4);
  return scripts\mp\playerstats::modifystatwritability(var5, 1);
}

function isplayerstatwritable(var0, var1, var2, var3, var4) {
  var5 = scripts\mp\playerstats::getplayerstatpathkey(var0, var1, var2, var3, var4);
  return scripts\mp\playerstats::isstatwritable_internal(var5);
}

function makeplayerstatgroupreadonly(var0) {
  scripts\mp\playerstats::modifystatgroupwritability(var0, 0);
}

function makeplayerstatgroupwritable(var0) {
  scripts\mp\playerstats::modifystatgroupwritability(var0, 1);
}

function registerplayerstatratio(var0, var1, var2) {
  var3 = level.playerstats;
  var4 = scripts\mp\playerstats::getplayerstatpathkey(var0[0], var0[1], var0[2], var0[3], var0[4]);
  var3.ratios[var4] = [];
  var3.ratios[var4]["numerator"] = var1;
  var3.ratios[var4]["denominator"] = var2;
  var5 = scripts\mp\playerstats::getplayerstatpathkey(var1[0], var1[1], var1[2], var1[3], var1[4]);
  var6 = scripts\mp\playerstats::getplayerstatpathkey(var2[0], var2[1], var2[2], var2[3], var2[4]);

  if(!isDefined(var3.ratiochildren[var5])) {
    var3.ratiochildren[var5] = [var0];
  } else {
    var3.ratiochildren[var5][var3.ratiochildren[var5].size] = var0;
  }

  if(!isDefined(var3.ratiochildren[var6])) {
    var3.ratiochildren[var6] = [var0];
    return;
  }

  var3.ratiochildren[var6][var3.ratiochildren[var6].size] = var0;
}