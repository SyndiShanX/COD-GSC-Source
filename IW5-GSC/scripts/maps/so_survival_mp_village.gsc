/***************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\so_survival_mp_village.gsc
***************************************************/

main() {
  level.wave_table = "sp/so_survival/tier_1.csv";
  level.loadout_table = "sp/so_survival/tier_1.csv";
  maps\mp\mp_village_precache::main();
  maps\createart\mp_village_art::main();
  maps\mp\mp_village_fx::main();
  maps\createfx\mp_village_fx::main();
  maps\_so_survival::_id_3F65();
  maps\_load::main();

  if(!level.console) {
    setsaveddvar("r_ssaoStrength", 0);
  }
  ambientplay("ambient_mp_village");
  maps\_utility::set_vision_set("mp_village", 0);
  maps\_so_survival::_id_3F66();
  maps\_compass::setupminimap("compass_map_mp_village");
  maps\_so_survival::_id_3F67();
}