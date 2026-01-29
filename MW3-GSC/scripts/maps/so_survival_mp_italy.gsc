/*************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\so_survival_mp_italy.gsc
*************************************************/

main() {
  level.wave_table = "sp/so_survival/tier_2.csv";
  level.loadout_table = "sp/so_survival/tier_2.csv";
  maps\mp\mp_italy_precache::main();
  maps\createart\mp_italy_art::main();
  maps\mp\mp_italy_fx::main();
  maps\createfx\mp_italy_fx::main();
  maps\_so_survival::_id_3F65();
  maps\_load::main();
  maps\_utility::set_vision_set("mp_italy", 0);
  maps\_so_survival::_id_3F66();
  maps\_compass::setupminimap("compass_map_mp_italy");
  maps\_so_survival::_id_3F67();
  delete_stupid_curtains();
}

delete_stupid_curtains() {
  var_0 = getent("stage_curtain", "targetname");
  var_0 delete();
  var_1 = getent("stage_curtain_clip", "targetname");
  var_1 delete();
}