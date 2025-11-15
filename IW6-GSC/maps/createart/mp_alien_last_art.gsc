/************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\createart\mp_alien_last_art.gsc
************************************************/

main() {
  level.tweakfile = 1;
  level.parse_fog_func = maps\createart\mp_alien_last_fog::main;
}