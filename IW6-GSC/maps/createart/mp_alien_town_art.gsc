/************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\createart\mp_alien_town_art.gsc
************************************************/

main() {
  level.tweakfile = true;
  level.parse_fog_func = maps\createart\mp_alien_town_fog::main;

  setDevDvar("scr_fog_disable", "0");
}