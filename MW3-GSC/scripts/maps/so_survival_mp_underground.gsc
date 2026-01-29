/*******************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\so_survival_mp_underground.gsc
*******************************************************/

main() {
  level.wave_table = "sp/so_survival/tier_1.csv";
  level.loadout_table = "sp/so_survival/tier_1.csv";
  _id_061C::_id_3D56("easy", "actor_enemy_so_easy_v2");
  maps\mp\mp_underground_precache::main();
  maps\createart\mp_underground_art::main();
  maps\mp\mp_underground_fx::main();
  maps\createfx\mp_underground_fx::main();
  maps\_so_survival::_id_3F65();
  maps\_load::main();
  ambientplay("ambient_mp_underground");
  maps\_utility::set_vision_set("mp_underground", 0);
  maps\_so_survival::_id_3F66();
  maps\_compass::setupminimap("compass_map_mp_underground");
  _id_0618::_id_6F52();
  maps\_so_survival::_id_3F67();
}