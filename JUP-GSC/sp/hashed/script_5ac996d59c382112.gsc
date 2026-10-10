/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_5ac996d59c382112.gsc
*************************************************/

#using script_3a8f9ace195c9da9;
#using script_5e60754c97311cd;
#using scripts\common\basic_wind;
#using scripts\common\exploder;
#using scripts\common\utility;
#using scripts\cp\utility;
#using scripts\engine\utility;
#namespace namespace_5a392b20161842fe;

function main() {
  level._effect["vfx_ranch_exfil_jltv_light"] = loadfx("vfx/jup/level/cp_jup_ranch/vfx_ranch_exfil_jltv_light.vfx");
  level._effect["vfx_ranch_exfill_bike_screenfx"] = loadfx("vfx/jup/level/cp_jup_ranch/vfx_ranch_exfill_bike_screenfx.vfx");
  level._effect["vfx_ranch_lensflare_headlight_mc"] = loadfx("vfx/jup/level/cp_jup_ranch/vfx_ranch_lensflare_headlight_mc.vfx");
  level._effect["vfx_lensflare_circular_red"] = loadfx("vfx/jup/lensflares/vfx_lensflare_circular_red.vfx");
  level._effect["vfx_lensflare_headlight_cold"] = loadfx("vfx/jup/lensflares/vfx_lensflare_headlight_cold.vfx");
  level._effect["vfx_ranch_infil_bush_vf"] = loadfx("vfx/jup/level/cp_jup_ranch/vfx_ranch_infil_bush_vf.vfx");
  level._effect["vfx_ranch_infil_bike_treadfx"] = loadfx("vfx/jup/level/cp_jup_ranch/vfx_ranch_infil_bike_treadfx.vfx");
  level._effect["smoke_fire_column_dark_distance"] = loadfx("vfx/jup/level/cp_jup_ranch/smoke_fire_column_dark_distance.vfx");
  level._effect["vfx_bldg_smoke_column"] = loadfx("vfx/jup/level/cp_jup_ranch/vfx_bldg_smoke_column.vfx");
  level._effect["smoke_column_dark_distance"] = loadfx("vfx/jup/level/cp_jup_ranch/smoke_column_dark_distance.vfx");
  level._effect["vfx_estate_fire_wall_01"] = loadfx("vfx/jup/level/cp_jup_ranch/vfx_estate_fire_wall_01.vfx");
  level._effect["vfx_estate_fire_ground_spot_med"] = loadfx("vfx/jup/level/cp_jup_ranch/vfx_estate_fire_ground_spot_med.vfx");
  level._effect["vfx_vwb_volumetrics_particles"] = loadfx("vfx/iw9/test/vfx_vwb_volumetrics_particles.vfx");
  level._effect["vfx_lensflare_streetlight_warm"] = loadfx("vfx/jup/lensflares/vfx_lensflare_streetlight_warm.vfx");
  level._effect["vfx_exec_axe_hit_standing_back"] = loadfx("vfx/iw8_mp/executions/vfx_exec_axe_hit_standing_back.vfx");
  level._effect["vfx_nvg_light_player_nightwar_proto"] = loadfx("vfx/iw9/level/nightwar/vfx_nvg_light_player_nightwar_proto.vfx");
  level._effect["vfx_nvg_light_player_nightwar"] = loadfx("vfx/iw8/veh/light/vfx_nvg_light_player_nightwar.vfx");
  level._effect["vfx_test_aws_trigger"] = loadfx("vfx/test/vfx_test_aws_trigger.vfx");

  if(getdvarint(@ "hash_e6afce2cf5cf7515")) {}

  level._effect["fx_test_script_origin"] = loadfx("vfx/iw9/test/fx_test_script_origin.vfx");
  level._effect["vfx_test_sandstorm_tile"] = loadfx("vfx/iw9/test/vfx_test_sandstorm_tile.vfx");
  level._effect["vfx_test_clutter_debug_4"] = loadfx("vfx/iw9/test/vfx_test_clutter_debug_4.vfx");
  level._effect["vfx_test_clutter_debug_3"] = loadfx("vfx/iw9/test/vfx_test_clutter_debug_3.vfx");
  level._effect["vfx_test_clutter_debug_2"] = loadfx("vfx/iw9/test/vfx_test_clutter_debug_2.vfx");
  level._effect["vfx_test_clutter_debug_1"] = loadfx("vfx/iw9/test/vfx_test_clutter_debug_1.vfx");
  level._effect["vfx_global_gnat_cam_far"] = loadfx("vfx/iw9/level/_global/vfx_global_gnat_cam_far.vfx");
  level._effect["vfx_global_dust_move_slow_4"] = loadfx("vfx/iw9/level/_global/vfx_global_dust_move_slow_4.vfx");
  level._effect["vfx_hway_amb_birds"] = loadfx("vfx/iw8/level/highway/vfx_hway_amb_birds.vfx");
  level._effect["vfx_br_birds_sparrows_circling"] = loadfx("vfx/iw8_br/gen_amb/vfx_br_birds_sparrows_circling.vfx");
  level._effect["vfx_birds_curve"] = loadfx("vfx/iw8/level/marines/vfx_birds_curve.vfx");
  level._effect["vfx_global_birds_circling_seagulls"] = loadfx("vfx/iw9/level/_global/vfx_global_birds_circling_seagulls.vfx");
  level._effect["vfx_br_clutter_birds_sparrow_burst_01"] = loadfx("vfx/iw8_br/clutter/vfx_br_clutter_birds_sparrow_burst_01.vfx");
  level._effect["vfx_global_gnat_swarm"] = loadfx("vfx/iw9/level/_global/vfx_global_gnat_swarm.vfx");
  level._effect["vfx_global_moths_1"] = loadfx("vfx/iw9/level/_global/vfx_global_moths_1.vfx");
  level._effect["vfx_global_amb_bugs_01"] = loadfx("vfx/iw9/level/_global/vfx_global_amb_bugs_01.vfx");
  level._effect["vfx_global_gnat_swarm"] = loadfx("vfx/iw9/level/_global/vfx_global_gnat_swarm.vfx");
  level._effect["vfx_global_dust_move_slow"] = loadfx("vfx/iw9/level/_global/vfx_global_dust_move_slow.vfx");
  level._effect["vfx_global_dust_blow"] = loadfx("vfx/iw9/level/_global/vfx_global_dust_blow.vfx");
  level._effect["vfx_global_dragonflies"] = loadfx("vfx/iw9/level/_global/vfx_global_dragonflies.vfx");
  level._effect["vfx_global_butterflies"] = loadfx("vfx/iw9/level/_global/vfx_global_butterflies.vfx");
  level._effect["vfx_global_blowing_sand_ledge"] = loadfx("vfx/iw9/level/_global/vfx_global_blowing_sand_ledge.vfx");
  level._effect["vfx_global_bee_swarm_sm"] = loadfx("vfx/iw9/level/_global/vfx_global_bee_swarm_sm.vfx");
  level._effect["vfx_global_blowing_sand_low"] = loadfx("vfx/iw9/level/_global/vfx_global_blowing_sand_low.vfx");
  level._effect["vfx_global_dust_devil_sm"] = loadfx("vfx/iw9/level/_global/vfx_global_dust_devil_sm.vfx");
  level._effect["vfx_global_tumbleweed"] = loadfx("vfx/iw9/level/_global/vfx_global_tumbleweed.vfx");
  level._effect["vfx_global_falling_pine_needles"] = loadfx("vfx/iw9/level/_global/vfx_global_falling_pine_needles.vfx");
  level._effect["vfx_global_tumbleweed"] = loadfx("vfx/iw9/level/_global/vfx_global_tumbleweed.vfx");
  level._effect["vfx_global_dust_devil_sm"] = loadfx("vfx/iw9/level/_global/vfx_global_dust_devil_sm.vfx");
  level._effect["vfx_global_dust_devil_sm_ch"] = loadfx("vfx/iw9/level/_global/vfx_global_dust_devil_sm_ch.vfx");
  level._effect["vfx_global_dust_pocket_lrg"] = loadfx("vfx/iw9/level/_global/vfx_global_dust_pocket_lrg.vfx");
  level._effect["vfx_global_leaves_falling_olive"] = loadfx("vfx/iw9/level/_global/vfx_global_leaves_falling_olive.vfx");
  level._effect["vfx_flashlight_npc"] = loadfx("vfx/jup/lighting/vfx_flashlight_npc.vfx");
  level._effect["vfx_flashlight_npc_perf"] = loadfx("vfx/jup/lighting/vfx_flashlight_npc_perf.vfx");
  level._effect["vfx_flashlight_npc_perf_short"] = loadfx("vfx/jup/lighting/vfx_flashlight_npc_perf_short.vfx");
  level._effect["human_gib_head"] = loadfx("vfx/iw9/executions/vfx_exec_blood_splatter.vfx");
  level._effect["vfx_laser_pointer"] = loadfx("vfx/iw9/core/laser_flashlight_bright/vfx_laser_flashlight_bright_red_laser.vfx");
  level._effect["vfx_laser_pointer_thermal"] = loadfx("vfx/iw8_cp/vfx_red_laser_cp_thermalonly.vfx");
  level._effect["alex_tracer"] = loadfx("vfx/iw9/core/weapons/tracer/vfx_tracer_lrg_w_beam.vfx");
  function_a520347b8e7b8543();

  if(getDvar(@ "clientsideeffects") != "<dev string:x1c>") {}
}

function function_a520347b8e7b8543() {
  if(!getdvarint(@ "hash_e6afce2cf5cf7515")) {
    scripts\common\basic_wind::load_wind("north", 2);
    level.wind_ent = scripts\common\basic_wind::init_wind("north", 2, 0);
  }
}