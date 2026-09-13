/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_6dee2410821c6c07.gsc
***********************************************/

init() {
  if(!isDefined(level._id_35A6C186C74A921B))
    level._id_35A6C186C74A921B = [];

  level thread onplayerconnect();
}

onplayerconnect() {
  for(;;) {
    level waittill("connected", player);
    player thread onplayerspawned();
  }
}

_id_60D43F6A3C2B5F1B(callback) {}

onplayerspawned() {
  self endon("disconnect");

  for(;;) {
    self waittill("weapon_change");

    foreach(callback in level._id_35A6C186C74A921B)
    self[[callback]]();
  }
}