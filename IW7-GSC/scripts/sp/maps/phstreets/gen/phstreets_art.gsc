/***********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\maps\phstreets\gen\phstreets_art.gsc
***********************************************************/

main() {
  level.tweakfile = 1;
  level.player = getEntArray("player", "classname")[0];
  setsaveddvar("r_sdfShadowPenumbra", 0.1);
  thread _id_119AA();
}

_id_119AA() {
  setsaveddvar("r_tessellationOverride", 0);
}