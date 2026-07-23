/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\so_survival_mp_roughneck.gsc
*****************************************************/

main() {
  level.wave_table = "sp/so_survival/tier_dlc_2.csv";
  level.loadout_table = "sp/so_survival/tier_dlc_2.csv";
  maps/_so_survival_ai::ai_type_add_override_class("easy", "actor_enemy_so_easy_v2");
  maps\so_survival_mp_roughneck_precache::main();
  maps\mp\mp_roughneck_precache::main();
  maps\createart\mp_roughneck_art::main();
  maps\mp\mp_roughneck_fx::main();
  maps\createfx\mp_roughneck_fx::main();
  maps\_so_survival::survival_preload();
  maps\_load::main();
  ambientplay("ambient_mp_roughneck");
  maps\_utility::set_vision_set("mp_roughneck", 0);
  maps\_so_survival::survival_postload();
  maps\_compass::setupminimap("compass_map_mp_roughneck");
  maps\_so_survival::survival_init();
  level thread maps/_so_survival_code::break_glass();
  level thread bridge_blocker();
}

bridge_blocker() {
  level endon("special_op_terminated");
  var_0 = getEnt("trigger_bridge_blocker", "targetname");
  var_1 = getEnt("bridge_blocker", "targetname");
  var_1 maps\_utility::hide_entity();
  var_1 connectpaths();

  for(;;) {
    if(maps\_utility::all_players_istouching(var_0)) {
      var_1 maps\_utility::show_entity();
      var_1 disconnectPaths();
    } else {
      var_1 maps\_utility::hide_entity();
      var_1 connectpaths();
    }

    wait 0.5;
  }
}