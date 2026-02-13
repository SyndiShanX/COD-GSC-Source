/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2001.gsc
*************************************************/

_id_819E() {
  if(!isDefined(game["flags"])) {
    game["flags"] = [];
  }
}

_id_60C0(var_0, var_1) {
  game["flags"][var_0] = var_1;
}

_id_60BE(var_0) {
  return game["flags"][var_0];
}

_id_60C1(var_0) {
  game["flags"][var_0] = 1;
  level notify(var_0);
}

_id_60BF(var_0) {
  game["flags"][var_0] = 0;
}

_id_60C2(var_0) {
  while(!_id_60BE(var_0)) {
    level waittill(var_0);
  }
}

_id_820E() {
  if(!isDefined(level._id_9354)) {
    level._id_9354 = [];
  }
}

_id_9353(var_0, var_1) {
  level._id_9354[var_0] = var_1;
}

_id_9351(var_0) {
  return level._id_9354[var_0];
}

_id_9355(var_0) {
  level._id_9354[var_0] = 1;
  level notify(var_0);
}

_id_9352(var_0) {
  level._id_9354[var_0] = 0;
  level notify(var_0);
}

_id_9356(var_0) {
  while(!_id_9351(var_0)) {
    level waittill(var_0);
  }
}

_id_9357(var_0) {
  while(_id_9351(var_0)) {
    level waittill(var_0);
  }
}