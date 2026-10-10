/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_5cb623572b271c34.gsc
*************************************************/

#using scripts\common\utility;
#using scripts\cp\utility;
#using scripts\engine\utility;
#namespace namespace_c8ac91d321f30090;

function function_962089c12b654934(player) {
  if(!isDefined(level.soldier_allies)) {
    return false;
  }

  foreach(soldier in level.soldier_allies) {
    if(isDefined(soldier.tracked_player) && soldier.tracked_player == player) {
      return true;
    }
  }

  return false;
}

function function_5c6c98e7d15b8d4a(player) {
  if(!isDefined(level.soldier_allies)) {
    return undefined;
  }

  var_14dc09926e8e1b2f = [];

  foreach(soldier in level.soldier_allies) {
    owner = soldier.owner;

    if(isDefined(soldier.tracked_player)) {
      owner = soldier.tracked_player;
    }

    if(isDefined(owner) && owner == player) {
      var_14dc09926e8e1b2f[var_14dc09926e8e1b2f.size] = soldier;
    }
  }

  if(var_14dc09926e8e1b2f.size > 0) {
    return var_14dc09926e8e1b2f;
  }

  return undefined;
}

function function_5bd736549f8d4441() {
  if(!isDefined(level.soldier_allies)) {
    return undefined;
  }

  var_14dc09926e8e1b2f = [];

  foreach(soldier in level.soldier_allies) {
    owner = soldier.owner;

    if(isDefined(soldier.tracked_player)) {
      owner = soldier.tracked_player;
    }

    if(isDefined(owner)) {
      var_14dc09926e8e1b2f[var_14dc09926e8e1b2f.size] = soldier;
    }
  }

  if(var_14dc09926e8e1b2f.size > 0) {
    return var_14dc09926e8e1b2f;
  }

  return undefined;
}

function total_allies() {
  if(!isDefined(level.soldier_allies)) {
    return 0;
  }

  return level.soldier_allies.size;
}

function function_87ac668a043af5dd() {
  if(isDefined(level.var_506605f16efce39a)) {
    return level.var_506605f16efce39a;
  }

  return 8;
}