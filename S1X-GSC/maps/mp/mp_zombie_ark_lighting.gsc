/**********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\mp_zombie_ark_lighting.gsc
**********************************************/

main() {
  set_level_lighting_values();
}

set_level_lighting_values() {
  if(isusinghdr()) {
    setdvar("r_disablelightsets", 0);
  }
}