/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\so_survival_mp_roughneck.gsc
*****************************************************/

main() {
  level.wave_table = "sp/so_survival/tier_dlc_2.csv";
  level.loadout_table = "sp/so_survival/tier_dlc_2.csv";
  _id_061C::_id_3D56("easy", "actor_enemy_so_easy_v2");
  maps\so_survival_mp_roughneck_precache::main();
  maps\mp\mp_roughneck_precache::main();
  maps\createart\mp_roughneck_art::main();
  maps\mp\mp_roughneck_fx::main();
  maps\createfx\mp_roughneck_fx::main();
  maps\_so_survival::_id_3F65();
  maps\_load::main();
  ambientplay("ambient_mp_roughneck");
  maps\_utility::set_vision_set("mp_roughneck", 0);
  maps\_so_survival::_id_3F66();
  maps\_compass::setupminimap("compass_map_mp_roughneck");
  maps\_so_survival::_id_3F67();
  level thread _id_0618::_id_6F52();
  level thread bridge_blocker();
}

bridge_blocker() {
  level endon("special_op_terminated");
  var_0 = getent("trigger_bridge_blocker", "targetname");
  var_1 = getent("bridge_blocker", "targetname");
  var_1 maps\_utility::_id_27C5();
  var_1 connectpaths();

  for(;;) {
    if(maps\_utility::_id_277B(var_0)) {
      var_1 maps\_utility::_id_27C6();
      var_1 disconnectpaths();
    } else {
      var_1 maps\_utility::_id_27C5();
      var_1 connectpaths();
    }

    wait 0.5;
  }
}