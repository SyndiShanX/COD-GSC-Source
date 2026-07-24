/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 4178.gsc
**************************************/

main() {
  level._effect["vfx_phparade_lake_mist_flat"] = loadfx("vfx/iw7/levels/pearl_harbor/vfx_phparade_lake_mist_flat.vfx");
  level._effect["vfx_ph_parade_firework_exp_01_lrg"] = loadfx("vfx/iw7/levels/pearl_harbor/vfx_ph_parade_firework_exp_01_lrg.vfx");
  level._effect["vfx_ph_parade_firework_exp_01_run"] = loadfx("vfx/iw7/levels/pearl_harbor/vfx_ph_parade_firework_exp_01_run.vfx");
  level._effect["vfx_parade_horizon_haze"] = loadfx("vfx/iw7/levels/pearl_harbor/vfx_parade_horizon_haze.vfx");
  level._effect["vfx_ph_clouds_a_faint_sml"] = loadfx("vfx/iw7/levels/pearl_harbor/vfx_ph_clouds_a_faint_sml.vfx");
  level._effect["vfx_ph_clouds_a_faint"] = loadfx("vfx/iw7/levels/pearl_harbor/vfx_ph_clouds_a_faint.vfx");
  level._effect["vfx_ph_flare_sun_02"] = loadfx("vfx/iw7/levels/pearl_harbor/vfx_ph_flare_sun_02.vfx");
  level._effect["vfx_ph_cruiser_thruster_low"] = loadfx("vfx/iw7/levels/pearl_harbor/vfx_ph_cruiser_thruster_low.vfx");
  level._effect["vfx_ph_destroyer_thruster_low"] = loadfx("vfx/iw7/levels/pearl_harbor/vfx_ph_destroyer_thruster_low.vfx");
  level._effect["vfx_ph_dropship_thruster_low"] = loadfx("vfx/iw7/levels/pearl_harbor/vfx_ph_dropship_thruster_low.vfx");
  level._effect["vfx_ph_parade_firework_smoke_drift"] = loadfx("vfx/iw7/levels/pearl_harbor/vfx_ph_parade_firework_smoke_drift.vfx");
  level._effect["vfx_ph_parade_security_scan_01"] = loadfx("vfx/iw7/levels/pearl_harbor/vfx_ph_parade_security_scan_01.vfx");
  level._effect["vfx_ph_parade_ship_sml_clouds_01"] = loadfx("vfx/iw7/levels/pearl_harbor/vfx_ph_parade_ship_sml_clouds_01.vfx");
  level._effect["vfx_ph_parade_firework_blue_01_run"] = loadfx("vfx/iw7/levels/pearl_harbor/vfx_ph_parade_firework_blue_01_run.vfx");
  level._effect["vfx_ph_parade_firework_line_blue_01_run"] = loadfx("vfx/iw7/levels/pearl_harbor/vfx_ph_parade_firework_line_blue_01_run.vfx");
  level._effect["vfx_ph_parade_firework_line_red_01_run"] = loadfx("vfx/iw7/levels/pearl_harbor/vfx_ph_parade_firework_line_red_01_run.vfx");
  level._effect["vfx_ph_parade_firework_line_red_01"] = loadfx("vfx/iw7/levels/pearl_harbor/vfx_ph_parade_firework_line_red_01.vfx");
  level._effect["vfx_ph_parade_firework_line_01"] = loadfx("vfx/iw7/levels/pearl_harbor/vfx_ph_parade_firework_line_01.vfx");
  level._effect["vfx_ph_parade_firework_01"] = loadfx("vfx/iw7/levels/pearl_harbor/vfx_ph_parade_firework_01.vfx");
  level._effect["vfx_ph_parade_balloons_bunch_02"] = loadfx("vfx/iw7/levels/pearl_harbor/vfx_ph_parade_balloons_bunch_02.vfx");
  level._effect["vfx_ph_parade_balloons_bunch_01"] = loadfx("vfx/iw7/levels/pearl_harbor/vfx_ph_parade_balloons_bunch_01.vfx");
  level._effect["vfx_ph_parade_balloons_01"] = loadfx("vfx/iw7/levels/pearl_harbor/vfx_ph_parade_balloons_01.vfx");
  level._effect["vfx_ph_parade_ship_clouds_01"] = loadfx("vfx/iw7/levels/pearl_harbor/vfx_ph_parade_ship_clouds_01.vfx");
  level._effect["vfx_crowd_female_walk_run_02"] = loadfx("vfx/iw7/levels/pearl_harbor/crowd/vfx_crowd_female_walk_run_02.vfx");
  level._effect["vfx_crowd_mass_cards_large_sparse_01"] = loadfx("vfx/iw7/levels/pearl_harbor/crowd/vfx_crowd_mass_cards_large_sparse_01.vfx");
  level._effect["vfx_crowd_mass_cards_01"] = loadfx("vfx/iw7/levels/pearl_harbor/crowd/vfx_crowd_mass_cards_01.vfx");
  level._effect["vfx_crowd_mass_test_02"] = loadfx("vfx/test/vfx_crowd_mass_test_02.vfx");
  level._effect["vfx_crowd_mass_sidewalks_01"] = loadfx("vfx/test/vfx_crowd_mass_sidewalks_01.vfx");
  level._effect["vfx_crowd_mass_sparse_01"] = loadfx("vfx/iw7/levels/pearl_harbor/crowd/vfx_crowd_mass_sparse_01.vfx");
  level._effect["vfx_crowd_mass_dense_01"] = loadfx("vfx/iw7/levels/pearl_harbor/crowd/vfx_crowd_mass_dense_01.vfx");
  level._effect["vfx_jackal_rear_show_trail_white_01"] = loadfx("vfx/iw7/core/vehicle/jackal/vfx_jackal_rear_show_trail_white_01.vfx");
  level._effect["vfx_jackal_rear_show_trail_blue_01"] = loadfx("vfx/iw7/core/vehicle/jackal/vfx_jackal_rear_show_trail_blue_01.vfx");
  level._effect["vfx_jackal_rear_show_trail_red_01"] = loadfx("vfx/iw7/core/vehicle/jackal/vfx_jackal_rear_show_trail_red_01.vfx");
  level._effect["security_scan"] = loadfx("vfx/iw7/levels/pearl_harbor/vfx_ph_parade_security_scan_01.vfx");

  if(!getdvarint("r_reflectionProbeGenerate")) {
    scripts\sp\maps\phparade\gen\phparade_fx::main();
    scripts\sp\maps\phparade\gen\phparade_sound::main();
  }
}