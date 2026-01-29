/***************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\so_survival_mp_meteora.gsc
***************************************************/

main() {
  level.wave_table = "sp/so_survival/tier_dlc_1.csv";
  level.loadout_table = "sp/so_survival/tier_dlc_1.csv";
  maps\mp\mp_meteora_precache::main();
  maps\createart\mp_meteora_art::main();
  maps\mp\mp_meteora_fx::main();
  maps\createfx\mp_meteora_fx::main();
  maps\_so_survival::_id_3F65();
  maps\_load::main();
  ambientplay("ambient_mp_meteoradlc");
  maps\_utility::set_vision_set("mp_meteora", 0);
  maps\_so_survival::_id_3F66();
  maps\_compass::setupminimap("compass_map_mp_meteora");
  maps\_so_survival::_id_3F67();
}