/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\1318.gsc
**************************************/

_id_52F6() {
  _id_5306();
}

_id_73DD() {
  self setclientomnvar("ui_streak_overlay_state", 1);
}

_id_73D5() {
  self setclientomnvar("ui_streak_overlay_state", 0);
}

_id_745C() {
  self setclientomnvar("ui_streak_overlay_state", 7);
}

_id_8A61(var_0, var_1, var_2) {
  self endon("missile_strike_complete");

  if(isDefined(level._id_6F9D) && isDefined(level._id_6F9D["dofScripting"]))
    self disablephysicaldepthoffieldscripting();

  wait(var_0);

  if(isDefined(var_1))
    self setclienttriggervisionset(var_1, 0);

  if(isDefined(var_2))
    self lightsetforplayer(var_2);

  self _meth_834B(1);
}

_id_7D04(var_0) {
  if(isDefined(level._id_6F9D) && isDefined(level._id_6F9D["dofScripting"]))
    self enablephysicaldepthoffieldscripting(level._id_6F9D["dofScripting"]);

  self setclienttriggervisionset("", var_0);
  self lightsetforplayer("");
  self _meth_834B(0);
}

_id_A232(var_0) {
  var_1 = getEntArray("scorestreakclosed", "targetname");

  if(var_1.size > 0) {
    foreach(var_3 in var_1)
    var_3 enableportalgroup(!var_0, self);
  }

  var_5 = getEntArray("scorestreakopen", "targetname");

  if(var_5.size > 0) {
    foreach(var_3 in var_5)
    var_3 enableportalgroup(var_0, self);
  }
}

_id_5306() {
  level.makeglobalusable = [];
  setdvarifuninitialized("scr_scorestreakDangerDebug", 0);
}

_id_280E(var_0, var_1, var_2, var_3) {
  var_4 = spawnStruct();
  var_4.origin = var_0;
  var_4._id_3E3E = anglesToForward((0, var_1, 0));
  var_4._id_944C = var_2;
  var_4.team = var_3;
  level.makeglobalusable[level.makeglobalusable.size] = var_4;
}

_id_5FCB(var_0, var_1) {
  wait(level.makeglobalunusable[var_1]);
  var_6 = 0;
  var_7 = [];

  for(var_8 = 0; var_8 < level.makeglobalusable.size; var_8++) {
    if(!var_6 && level.makeglobalusable[var_8].origin == var_0) {
      var_6 = 1;
      continue;
    }

    var_7[var_7.size] = level.makeglobalusable[var_8];
  }

  level.makeglobalusable = var_7;
}

_id_4675(var_0) {
  var_1 = 0;

  for(var_2 = 0; var_2 < level.makeglobalusable.size; var_2++) {
    var_3 = level.makeglobalusable[var_2].origin;
    var_4 = level.makeglobalusable[var_2]._id_3E3E;
    var_5 = level.makeglobalusable[var_2]._id_944C;
    var_1 = var_1 + _id_4684(var_0, var_3, var_4, var_5);
  }

  return var_1;
}

_id_4684(var_0, var_1, var_2, var_3) {
  if(level.setwhizbyprobabilities[var_3] != 0) {
    var_4 = var_1 + level.setwhizbyprobabilities[var_3] * level._id_80B7[var_3] * var_2;
    var_5 = var_0 - var_4;
    var_5 = (var_5[0], var_5[1], 0);
    var_6 = vectordot(var_5, var_2) * var_2;
    var_7 = var_5 - var_6;
    var_8 = var_7 + var_6 / level._id_80B9[var_3];
  } else {
    var_8 = var_0 - var_1;
    var_8 = (var_8[0], var_8[1], 0);
  }

  var_9 = _lengthsquared(var_8);

  if(var_9 > level._id_80B7[var_3] * level._id_80B7[var_3])
    return 0;

  if(var_9 < level._id_80B8[var_3] * level._id_80B8[var_3])
    return 1;

  var_10 = _sqrt(var_9);
  var_11 = (var_10 - level._id_80B8[var_3]) / (level._id_80B7[var_3] - level._id_80B8[var_3]);
  return 1 - var_11;
}