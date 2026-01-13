/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3031.gsc
**************************************/

init(var_0) {
  func_31A1(var_0);
}

#using_animtree("jackal");

func_31A1(var_0) {
  level.var_A065[var_0 + "_fly_to_hover"] = % jackal_ca_vehicle_strike_to_assault;
  level.var_A065[var_0 + "_hover_to_fly"] = % jackal_ca_vehicle_assault_to_strike;
  level.var_A065[var_0 + "_fly_to_hover_space"] = % jackal_ca_vehicle_strike_to_assault;
  level.var_A065[var_0 + "_hover_to_fly_space"] = % jackal_ca_vehicle_assault_to_strike;
  level.var_A065[var_0 + "_landed_to_fly"] = % jackal_ca_vehicle_landed_to_strike;
  level.var_A065[var_0 + "_landed_to_hover"] = % jackal_ca_vehicle_landed_to_assault;
  level.var_A065[var_0 + "_fly"] = % jackal_ca_vehicle_strike_state_idle;
  level.var_A065[var_0 + "_fly_motion"] = % jackal_ca_vehicle_strike_motion_idle;
  level.var_A065[var_0 + "_fly_space"] = % jackal_ca_vehicle_strike_state_idle;
  level.var_A065[var_0 + "_fly_motion_space"] = % jackal_ca_vehicle_space_strike_motion_idle;
  level.var_A065[var_0 + "_hover"] = % jackal_ca_vehicle_assault_state_idle;
  level.var_A065[var_0 + "_hover_motion"] = % jackal_ca_vehicle_assault_motion_idle;
  level.var_A065[var_0 + "_hover_space"] = % jackal_ca_vehicle_assault_state_idle;
  level.var_A065[var_0 + "_hover_motion_space"] = % jackal_ca_vehicle_space_assault_motion_idle;
  level.var_A065[var_0 + "_landed"] = % jackal_ca_vehicle_landed_state_idle;
  level.var_A065[var_0 + "_landed_motion"] = % jackal_vehicle_landed_motion_idle;
  level.var_A065[var_0 + "_reentry"] = % jackal_ca_vehicle_landed_state_idle;
  level.var_A065[var_0 + "_reentry_motion"] = % jackal_vehicle_landed_motion_idle;
}