/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3032.gsc
***************************************/

init(var_00) {
  func_31A1(var_00);
}

#using_animtree("jackal");

func_31A1(var_00) {
  level.func_A065[var_00 + "_fly_to_hover"] = % jackal_vehicle_strike_to_assault;
  level.func_A065[var_00 + "_hover_to_fly"] = % jackal_vehicle_assault_to_strike;
  level.func_A065[var_00 + "_fly_to_hover_space"] = % jackal_vehicle_space_strike_to_assault;
  level.func_A065[var_00 + "_hover_to_fly_space"] = % jackal_vehicle_space_assault_to_strike;
  level.func_A065[var_00 + "_landed_to_fly"] = % jackal_vehicle_landed_to_strike;
  level.func_A065[var_00 + "_landed_to_hover"] = % jackal_vehicle_landed_to_assault;
  level.func_A065[var_00 + "_fly"] = % jackal_vehicle_strike_state_idle;
  level.func_A065[var_00 + "_fly_motion"] = % jackal_vehicle_strike_motion_idle;
  level.func_A065[var_00 + "_fly_space"] = % jackal_vehicle_space_strike_state_idle;
  level.func_A065[var_00 + "_fly_motion_space"] = % jackal_vehicle_space_strike_motion_idle;
  level.func_A065[var_00 + "_hover"] = % jackal_vehicle_assault_state_idle;
  level.func_A065[var_00 + "_hover_motion"] = % jackal_vehicle_assault_motion_idle;
  level.func_A065[var_00 + "_hover_space"] = % jackal_vehicle_space_assault_state_idle;
  level.func_A065[var_00 + "_hover_motion_space"] = % jackal_vehicle_space_assault_motion_idle;
  level.func_A065[var_00 + "_landed"] = % jackal_vehicle_landed_state_idle;
  level.func_A065[var_00 + "_landed_motion"] = % jackal_vehicle_landed_motion_idle;
  level.func_A065[var_00 + "_reentry"] = % jackal_vehicle_landed_state_idle;
  level.func_A065[var_00 + "_reentry_motion"] = % jackal_vehicle_landed_motion_idle;
}