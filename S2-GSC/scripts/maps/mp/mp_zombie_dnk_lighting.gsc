/******************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\mp_zombie_dnk_lighting.gsc
******************************************************/

main() {
  _id_84F8();

  if(level._id_01D4 && getDvar("2695") != "true")
    xbox_optimizations();
}

_id_84F8() {
  setDvar("2973", 0);
  setDvar("2664", 1);
  setDvar("5153", 1);
}

xbox_optimizations() {
  setDvar("5153", 0);
}