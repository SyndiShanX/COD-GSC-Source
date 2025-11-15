/**************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: vehicle_scripts\mobile_railgun_cab.gsc
**************************************************/

#using_animtree("vehicles");

main(var_0, var_1, var_2) {
  maps\_vehicle::build_template("mobile_railgun_cab", var_0, var_1, var_2);
  maps\_vehicle::build_localinit(::init_local);
  maps\_vehicle::build_drive( % mobile_railgun_cab_movement, % mobile_railgun_cab_movement, 25);
  maps\_vehicle::build_treadfx();
  maps\_vehicle::build_life(999, 500, 1500);
  maps\_vehicle::build_team("allies");
  maps\_vehicle::build_light(var_2, "headlight_beam_l_01", "tag_headlight_beam_l_01", "vfx/moments/factory/factory_het_cab_headlight_beam", "headlights", 0.0);
  maps\_vehicle::build_light(var_2, "headlight_beam_l_02", "tag_headlight_beam_l_02", "vfx/moments/factory/factory_het_cab_headlight_beam", "headlights", 0.0);
  maps\_vehicle::build_light(var_2, "headlight_beam_r_01", "tag_headlight_beam_r_01", "vfx/moments/factory/factory_het_cab_headlight_beam", "headlights", 0.0);
  maps\_vehicle::build_light(var_2, "headlight_beam_r_02", "tag_headlight_beam_r_02", "vfx/moments/factory/factory_het_cab_headlight_beam", "headlights", 0.0);
  maps\_vehicle::build_light(var_2, "headlight_lens_l_01", "tag_headlight_lens_l_01", "vfx/moments/factory/factory_het_cab_headlight_lens", "headlights", 0.0);
  maps\_vehicle::build_light(var_2, "headlight_lens_l_02", "tag_headlight_lens_l_02", "vfx/moments/factory/factory_het_cab_headlight_lens", "headlights", 0.0);
  maps\_vehicle::build_light(var_2, "headlight_lens_r_01", "tag_headlight_lens_r_01", "vfx/moments/factory/factory_het_cab_headlight_lens", "headlights", 0.0);
  maps\_vehicle::build_light(var_2, "headlight_lens_r_02", "tag_headlight_lens_r_02", "vfx/moments/factory/factory_het_cab_headlight_lens", "headlights", 0.0);
  maps\_vehicle::build_light(var_2, "back_running_light_l", "tag_back_running_light_l", "vfx/ambient/lights/amber_light_running_8_nolight", "running", 0.0);
  maps\_vehicle::build_light(var_2, "back_running_light_r", "tag_back_running_light_r", "vfx/ambient/lights/amber_light_running_8_nolight", "running", 0.0);
  maps\_vehicle::build_light(var_2, "bumper_light_l_01", "tag_bumper_light_l_01", "vfx/ambient/lights/amber_light_running_4_nolight", "running", 0.0);
  maps\_vehicle::build_light(var_2, "bumper_light_l_02", "tag_bumper_light_l_02", "vfx/ambient/lights/amber_light_running_4_nolight", "running", 0.0);
  maps\_vehicle::build_light(var_2, "bumper_light_r_01", "tag_bumper_light_r_01", "vfx/ambient/lights/amber_light_running_4_nolight", "running", 0.0);
  maps\_vehicle::build_light(var_2, "bumper_light_r_02", "tag_bumper_light_r_02", "vfx/ambient/lights/amber_light_running_4_nolight", "running", 0.0);
  maps\_vehicle::build_light(var_2, "top_light", "tag_top_light", "vfx/ambient/lights/amber_light_100_blinker_nolight", "top", 0.0);
  maps\_vehicle::build_light(var_2, "step_light_l", "tag_step_light_l", "vfx/ambient/lights/amber_light_running_4_nolight", "running", 0.0);
  maps\_vehicle::build_light(var_2, "step_light_r", "tag_step_light_r", "vfx/ambient/lights/amber_light_running_4_nolight", "running", 0.0);
  maps\_vehicle::build_light(var_2, "windshield_light_01", "tag_windshield_light_01", "vfx/ambient/lights/amber_light_running_3_nolight", "windshield", 0.0);
  maps\_vehicle::build_light(var_2, "windshield_light_02", "tag_windshield_light_02", "vfx/ambient/lights/amber_light_running_3_nolight", "windshield", 0.0);
  maps\_vehicle::build_light(var_2, "windshield_light_03", "tag_windshield_light_03", "vfx/ambient/lights/amber_light_running_3_nolight", "windshield", 0.0);
  maps\_vehicle::build_light(var_2, "windshield_light_04", "tag_windshield_light_04", "vfx/ambient/lights/amber_light_running_3_nolight", "windshield", 0.0);
  maps\_vehicle::build_light(var_2, "windshield_light_05", "tag_windshield_light_05", "vfx/ambient/lights/amber_light_running_3_nolight", "windshield", 0.0);
  maps\_vehicle::build_light(var_2, "windshield_light_06", "tag_windshield_light_06", "vfx/ambient/lights/amber_light_running_3_nolight", "windshield", 0.0);
}