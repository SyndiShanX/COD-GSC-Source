/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\so_survival_mp_overwatch.gsc
*****************************************************/

main() {
  level.wave_table = "sp/so_survival/tier_dlc_1.csv";
  level.loadout_table = "sp/so_survival/tier_dlc_1.csv";
  _id_061C::_id_3D56("easy", "actor_enemy_so_easy_v2");
  maps\mp\mp_overwatch_precache::main();
  maps\createart\mp_overwatch_art::main();
  maps\mp\mp_overwatch_fx::main();
  maps\createfx\mp_overwatch_fx::main();
  maps\_so_survival::_id_3F65();
  maps\_load::main();
  ambientplay("ambient_mp_overwatch");
  maps\_utility::set_vision_set("mp_overwatch", 0);
  maps\_so_survival::_id_3F66();
  maps\_compass::setupminimap("compass_map_mp_overwatch");
  maps\_so_survival::_id_3F67();
  move_up_ac130_by(3000);
}

move_up_ac130_by(var_0) {
  wait 0.05;
  level.ac130.origin = level.ac130.origin + (0, 0, var_0);
}