/***************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\maps\rogue\gen\rogue_art.gsc
***************************************************/

main() {
  level.tweakfile = 1;
  level.player = getEntArray("player", "classname")[0];
  thread _id_119AA();
}

_id_119AA() {
  setsaveddvar("r_tessellationOverride", 0);
}