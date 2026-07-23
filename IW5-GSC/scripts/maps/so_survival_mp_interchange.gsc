/*******************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\so_survival_mp_interchange.gsc
*******************************************************/

main() {
  level.wave_table = "sp/so_survival/tier_1.csv";
  level.loadout_table = "sp/so_survival/tier_1.csv";
  _id_061C::_id_3D56("easy", "actor_enemy_so_easy_v2");
  maps\mp\mp_interchange_precache::main();
  maps\createart\mp_interchange_art::main();
  maps\mp\mp_interchange_fx::main();
  maps\createfx\mp_interchange_fx::main();
  maps\_so_survival::_id_3F65();
  maps\_load::main();
  ambientplay("ambient_mp_interchange");
  maps\_utility::set_vision_set("mp_interchange", 0);
  maps\_so_survival::_id_3F66();
  maps\_compass::setupminimap("compass_map_mp_interchange");
  maps\_so_survival::_id_3F67();
}