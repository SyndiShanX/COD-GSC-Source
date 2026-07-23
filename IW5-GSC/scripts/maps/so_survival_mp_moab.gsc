/************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\so_survival_mp_moab.gsc
************************************************/

main() {
  level.wave_table = "sp/so_survival/tier_2.csv";
  level.loadout_table = "sp/so_survival/tier_2.csv";
  maps/_so_survival_ai::ai_type_add_override_class("easy", "actor_enemy_so_easy_v2");
  maps\so_survival_mp_moab_precache::main();
  maps\mp\mp_moab_precache::main();
  maps\createart\mp_moab_art::main();
  maps\mp\mp_moab_fx::main();
  maps\createfx\mp_moab_fx::main();
  maps\_so_survival::survival_preload();
  maps\_load::main();
  maps\_utility::set_vision_set("mp_moab", 0);
  maps\_so_survival::survival_postload();
  maps\_compass::setupminimap("compass_map_mp_moab");
  maps\_so_survival::survival_init();
  level thread maps/_so_survival_code::break_glass();
  level thread moab_wheel();
}

moab_wheel() {
  var_0 = getEnt("wheel_model", "targetname");
  var_1 = getEntArray("animated_model", "targetname");

  if(!isDefined(var_0)) {
    return;
  }
  foreach(var_3 in var_1) {
    if(var_3.model == "generic_prop_raven") {
      var_0 linkTo(var_3, "J_prop_1");
      break;
    }
  }
}