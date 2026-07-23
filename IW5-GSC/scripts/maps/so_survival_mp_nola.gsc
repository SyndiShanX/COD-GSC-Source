/************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\so_survival_mp_nola.gsc
************************************************/

main() {
  level.wave_table = "sp/so_survival/tier_dlc_1.csv";
  level.loadout_table = "sp/so_survival/tier_dlc_1.csv";
  _id_061C::_id_3D56("easy", "actor_enemy_so_easy_v2");
  maps\so_survival_mp_nola_precache::main();
  maps\mp\mp_nola_precache::main();
  maps\createart\mp_nola_art::main();
  maps\mp\mp_nola_fx::main();
  maps\createfx\mp_nola_fx::main();
  maps\_so_survival::_id_3F65();
  maps\_load::main();
  ambientplay("ambient_mp_nola");
  maps\_utility::set_vision_set("mp_nola", 0);
  maps\_so_survival::_id_3F66();
  maps\_compass::setupminimap("compass_map_mp_nola");
  maps\_so_survival::_id_3F67();
  level thread _id_0618::_id_6F52();
}