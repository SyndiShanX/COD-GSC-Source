/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_6dee2410821c6c07.gsc
*************************************************/

#namespace namespace_7f78dd93ed16ea4f;

function init() {
  if(!isDefined(level.var_35a6c186c74a921b)) {
    level.var_35a6c186c74a921b = [];
  }

  level thread onplayerconnect();
}

function onplayerconnect() {
  for(;;) {
    level waittill("connected", player);
    player thread onplayerspawned();
  }
}

function function_60d43f6a3c2b5f1b(callback) {}

function onplayerspawned() {
  self endon("disconnect");

  for(;;) {
    self waittill("weapon_change");

    foreach(callback in level.var_35a6c186c74a921b) {
      self[[callback]]();
    }
  }
}