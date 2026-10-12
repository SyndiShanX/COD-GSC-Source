/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\playerstats_interface.gsc
************************************************/

#using scripts\common\utility;
#using scripts\engine\utility;
#using scripts\mp\playerstats;
#namespace playerstats_interface;

function setplayerstat(value, path1, path2, path3, path4, path5) {
  if(!areplayerstatsenabled()) {
    return;
  }

  if(isai(self)) {
    return;
  }

  pathkey = getplayerstatpathkey(path1, path2, path3, path4, path5);

  if(!isstatwritable_internal(pathkey)) {
    return;
  }

  setplayerstat_internal(value, pathkey, path1, path2, path3, path4, path5);
  writeplayerstat(value, path1, path2, path3, path4, path5);
  updateparentratiosbuffered(pathkey);
}

function setplayerstatbuffered(value, path1, path2, path3, path4, path5) {
  if(!areplayerstatsenabled()) {
    return;
  }

  if(isai(self)) {
    return;
  }

  patharray = [path1];
  patharray[patharray.size] = path2;
  patharray[patharray.size] = path3;
  patharray[patharray.size] = path4;
  patharray[patharray.size] = path5;
  pathkey = getplayerstatpathkey(path1, path2, path3, path4, path5);

  if(!isstatwritable_internal(pathkey)) {
    return;
  }

  setplayerstat_internal(value, pathkey, path1, path2, path3, path4, path5);
  flagstatforbufferedwrite(pathkey);
  updateparentratiosbuffered(pathkey);
}

function addtoplayerstat(var_930290d7f474a0ae, path1, path2, path3, path4, path5) {
  if(!areplayerstatsenabled()) {
    return;
  }

  if(isai(self)) {
    return;
  }

  if(istrue(game["practiceRound"])) {
    return;
  }

  if(!isDefined(var_930290d7f474a0ae)) {
    var_930290d7f474a0ae = 1;
  }

  pathkey = getplayerstatpathkey(path1, path2, path3, path4, path5);

  if(!isstatwritable_internal(pathkey)) {
    return;
  }

  addtoplayerstat_internal(var_930290d7f474a0ae, pathkey, path1, path2, path3, path4, path5);
  writeplayerstat(self.playerstats.values[pathkey], path1, path2, path3, path4, path5);
  updateparentratios(pathkey);
}

function addtoplayerstatbuffered(var_930290d7f474a0ae, path1, path2, path3, path4, path5) {
  if(!areplayerstatsenabled()) {
    return;
  }

  if(isai(self)) {
    return;
  }

  if(!isDefined(var_930290d7f474a0ae)) {
    var_930290d7f474a0ae = 1;
  }

  pathkey = getplayerstatpathkey(path1, path2, path3, path4, path5);

  if(!isstatwritable_internal(pathkey)) {
    return;
  }

  addtoplayerstat_internal(var_930290d7f474a0ae, pathkey, path1, path2, path3, path4, path5);
  flagstatforbufferedwrite(pathkey);
  updateparentratiosbuffered(pathkey);
}

function getplayerstat(path1, path2, path3, path4, path5) {
  if(!areplayerstatsenabled()) {
    return undefined;
  }

  if(isai(self)) {
    return 0;
  }

  if(!isDefined(self.playerstats)) {
    return;
  }

  if(!isDefined(self.playerstats.values)) {
    return;
  }

  pathkey = getplayerstatpathkey(path1, path2, path3, path4, path5);

  if(!isDefined(self.playerstats.values[pathkey])) {
    self.playerstats.values[pathkey] = readplayerstat(path1, path2, path3, path4, path5);
  }

  return self.playerstats.values[pathkey];
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
  assertex(level.playerstats.readonly > 0, "<dev string:x1c>");
  level.playerstats.readonly--;
}

function makeplayerstatreadonly(path1, path2, path3, path4, path5) {
  pathkey = getplayerstatpathkey(path1, path2, path3, path4, path5);
  return modifystatwritability(pathkey, 0);
}

function makeplayerstatwritable(path1, path2, path3, path4, path5) {
  pathkey = getplayerstatpathkey(path1, path2, path3, path4, path5);
  return modifystatwritability(pathkey, 1);
}

function isplayerstatwritable(path1, path2, path3, path4, path5) {
  pathkey = getplayerstatpathkey(path1, path2, path3, path4, path5);
  return isstatwritable_internal(pathkey);
}

function makeplayerstatgroupreadonly(statgroup) {
  assertex(isDefined(level.playerstats.statgroups[statgroup]), "<dev string:x78>" + statgroup + "<dev string:xb6>");
  modifystatgroupwritability(statgroup, 0);
}

function makeplayerstatgroupwritable(statgroup) {
  assertex(isDefined(level.playerstats.statgroups[statgroup]), "<dev string:xbb>" + statgroup + "<dev string:xb6>");
  modifystatgroupwritability(statgroup, 1);
}

function registerplayerstatratio(var_8c83072b0421282c, var_59381b551181653c, var_de2ad9f399ec5304) {
  globals = level.playerstats;
  var_75af64168ade09b6 = getplayerstatpathkey(var_8c83072b0421282c[0], var_8c83072b0421282c[1], var_8c83072b0421282c[2], var_8c83072b0421282c[3], var_8c83072b0421282c[4]);
  globals.ratios[var_75af64168ade09b6] = [];
  globals.ratios[var_75af64168ade09b6]["numerator"] = var_59381b551181653c;
  globals.ratios[var_75af64168ade09b6]["denominator"] = var_de2ad9f399ec5304;
  var_9239b0ae7e345446 = getplayerstatpathkey(var_59381b551181653c[0], var_59381b551181653c[1], var_59381b551181653c[2], var_59381b551181653c[3], var_59381b551181653c[4]);
  var_c265966ffd9818be = getplayerstatpathkey(var_de2ad9f399ec5304[0], var_de2ad9f399ec5304[1], var_de2ad9f399ec5304[2], var_de2ad9f399ec5304[3], var_de2ad9f399ec5304[4]);

  if(!isDefined(globals.ratiochildren[var_9239b0ae7e345446])) {
    globals.ratiochildren[var_9239b0ae7e345446] = [var_8c83072b0421282c];
  } else {
    globals.ratiochildren[var_9239b0ae7e345446][globals.ratiochildren[var_9239b0ae7e345446].size] = var_8c83072b0421282c;
  }

  if(!isDefined(globals.ratiochildren[var_c265966ffd9818be])) {
    globals.ratiochildren[var_c265966ffd9818be] = [var_8c83072b0421282c];
    return;
  }

  globals.ratiochildren[var_c265966ffd9818be][globals.ratiochildren[var_c265966ffd9818be].size] = var_8c83072b0421282c;
}