/**************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\so_survival_mp_qadeem.gsc
**************************************************/

main() {
  level.wave_table = "sp/so_survival/tier_dlc_1.csv";
  level.loadout_table = "sp/so_survival/tier_dlc_1.csv";
  maps\so_survival_mp_qadeem_precache::main();
  maps\mp\mp_qadeem_precache::main();
  maps\createart\mp_qadeem_art::main();
  maps\mp\mp_qadeem_fx::main();
  maps\createfx\mp_qadeem_fx::main();
  maps\_so_survival::_id_3F65();
  maps\_load::main();
  ambientplay("ambient_mp_qadeem");
  maps\_utility::set_vision_set("mp_qadeem", 0);
  maps\_so_survival::_id_3F66();
  maps\_compass::setupminimap("compass_map_mp_qadeem");
  maps\_so_survival::_id_3F67();
  thread spawn_blocker_collision((1464, 2004, 428), (0, 0, 0));
  thread spawn_blocker_collision((1464, 2004, 458), (0, 0, 0));
  thread spawn_blocker_collision((1464, 2004, 488), (0, 0, 0));
  thread spawn_blocker_collision((1464, 2037, 428), (0, 0, 0));
  thread spawn_blocker_collision((1464, 2037, 458), (0, 0, 0));
  thread spawn_blocker_collision((1464, 2037, 488), (0, 0, 0));
  thread spawn_blocker_collision((1464, 2070, 428), (0, 0, 0));
  thread spawn_blocker_collision((1464, 2070, 458), (0, 0, 0));
  thread spawn_blocker_collision((1464, 2070, 488), (0, 0, 0));
  thread spawn_blocker_collision((1464, 2103, 428), (0, 0, 0));
  thread spawn_blocker_collision((1464, 2103, 458), (0, 0, 0));
  thread spawn_blocker_collision((1464, 2103, 488), (0, 0, 0));
  level._id_1456._id_16FD = 1;
}

spawn_blocker_collision(var_0, var_1) {
  var_2 = spawn("script_model", (0, 0, 0));
  var_2 setModel("tag_origin");
  var_2.origin = var_0;
  var_2.angles = var_1 + (0, 90, 0);
  var_2 clonebrushmodeltoscriptmodel(level._id_3BB1[0]);
}