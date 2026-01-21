/******************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: vehicle_scripts\mobile_railgun_trailer.gsc
******************************************************/

#using_animtree("vehicles");

main(var_0, var_1, var_2) {
  maps\_vehicle::build_template("mobile_railgun_trailer", var_0, var_1, var_2);
  maps\_vehicle::build_localinit(::init_local);
  maps\_vehicle::build_drive(%mobile_railgun_trailer_movement, %mobile_railgun_trailer_movement, 25);
  maps\_vehicle::build_treadfx();
  maps\_vehicle::build_life(999, 500, 1500);
  maps\_vehicle::build_team("allies");
  maps\_vehicle::build_light(var_2, "running_light_01", "tag_running_light_01", "vfx/ambient/lights/amber_light_running_4_nolight", "running", 0.0);
  maps\_vehicle::build_light(var_2, "running_light_02", "tag_running_light_02", "vfx/ambient/lights/amber_light_running_4_nolight", "running", 0.0);
  maps\_vehicle::build_light(var_2, "running_light_03", "tag_running_light_03", "vfx/ambient/lights/amber_light_running_4_nolight", "running", 0.0);
  maps\_vehicle::build_light(var_2, "running_light_04", "tag_running_light_04", "vfx/ambient/lights/amber_light_running_4_orient", "running", 0.0);
  maps\_vehicle::build_light(var_2, "running_light_05", "tag_running_light_05", "vfx/ambient/lights/amber_light_running_4_orient", "running", 0.0);
  maps\_vehicle::build_light(var_2, "running_light_06", "tag_running_light_06", "vfx/ambient/lights/amber_light_running_4_orient", "running", 0.0);
  maps\_vehicle::build_light(var_2, "running_light_07", "tag_running_light_07", "vfx/ambient/lights/amber_light_running_4_orient", "running", 0.0);
  maps\_vehicle::build_light(var_2, "running_light_08", "tag_running_light_08", "vfx/ambient/lights/amber_light_running_4_nolight", "running", 0.0);
  maps\_vehicle::build_light(var_2, "running_light_09", "tag_running_light_09", "vfx/ambient/lights/amber_light_running_4_nolight", "running", 0.0);
  maps\_vehicle::build_light(var_2, "running_light_10", "tag_running_light_10", "vfx/ambient/lights/amber_light_running_4_nolight", "running", 0.0);
}