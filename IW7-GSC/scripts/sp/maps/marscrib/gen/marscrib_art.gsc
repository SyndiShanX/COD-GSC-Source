/*********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\maps\marscrib\gen\marscrib_art.gsc
*********************************************************/

main() {
  level.tweakfile = 1;
  level.player = getEntArray("player", "classname")[0];
  setsaveddvar("r_tessellationFactor", 40);
}