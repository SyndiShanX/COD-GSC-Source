/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: vehicle_scripts\agv.gsc
*****************************************************/

#using_animtree("vehicles");

main(var_0, var_1, var_2) {
  maps\_vehicle::build_template("agv", var_0, var_1, var_2);
  maps\_vehicle::build_localinit(::init_local);
  maps\_vehicle::build_deathmodel(var_0, var_0);
  maps\_vehicle::build_drive(%iveco_lynx_idle_driving_idle_forward, %iveco_lynx_idle_driving_idle_forward, 10);
  maps\_vehicle::build_treadfx(var_2, "default", undefined, 0);
  maps\_vehicle::build_life(999, 500, 1500);
  maps\_vehicle::build_team("axis");
  maps\_vehicle::build_light(var_2, "top_light", "tag_top_light", "vfx/ambient/lights/glow_blue_light_rect_150_blinker", "running", 0.1);
}

init_local() {
  maps\_vehicle::vehicle_lights_on("running");
}