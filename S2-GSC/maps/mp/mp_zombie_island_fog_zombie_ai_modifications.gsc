/********************************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\mp_zombie_island_fog_zombie_ai_modifications.gsc
********************************************************************/

init() {
  add_zombie_passive_behavior();
}

add_zombie_passive_behavior() {
  while(!isDefined(level.var_A41) || !isDefined(level.var_A41["zombie_exploder"])) {
    wait 0.05;
  }

  level.var_A41["zombie_exploder"]["get_action_params"] = ::func_AB91;
}

func_AB91() {
  var_00 = lib_054D::func_AC22();
  if(common_scripts\utility::func_562E(self.var_392C)) {
    if(self.var_3937.var_3F22 == 1) {
      var_00["script_var"] = "tick_bomb";
    } else {
      var_00["script_var"] = "held_bomb";
    }
  } else {
    var_00["script_var"] = "drop_bomb";
  }

  if(common_scripts\utility::func_3794("zombie_passive")) {
    var_00["move_style"] = "crippled";
    var_00["move_speed"] = "passive";
  } else {
    var_00["move_speed"] = self.vectortoangles;
  }

  return var_00;
}