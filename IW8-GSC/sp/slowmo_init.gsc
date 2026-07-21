/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\slowmo_init.gsc
***********************************************/

slowmo_system_init() {
  if(!scripts\engine\utility::add_init_script("slowmo", ::slowmo_system_init)) {
    return;
  }
  level.slowmo = spawnStruct();
  slowmo_system_defaults();
  notifyoncommand("_cheat_player_press_slowmo", "+melee");
  notifyoncommand("_cheat_player_press_slowmo", "+melee_breath");
  notifyoncommand("_cheat_player_press_slowmo", "+melee_zoom");
}

slowmo_system_defaults() {
  level.slowmo.lerp_time_in = 0.0;
  level.slowmo.lerp_time_out = 0.25;
  level.slowmo.speed_slow = 0.4;
  level.slowmo.speed_norm = 1.0;
}