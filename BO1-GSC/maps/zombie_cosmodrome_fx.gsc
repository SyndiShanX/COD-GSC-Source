/*****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\zombie_cosmodrome_fx.gsc
*****************************************/

#include maps\_utility;
#include common_scripts\utility;
#include maps\_anim;
#using_animtree("fxanim_props");
main() {
  precache_createfx_fx();
  precache_scripted_fx();
  maps\createart\zombie_cosmodrome_art::main();
  maps\createfx\zombie_cosmodrome_fx::main();
  wind_initial_setting();
}
wind_initial_setting() {
  SetSavedDvar("wind_global_vector", "140 120 0");
  SetSavedDvar("wind_global_low_altitude", -250);
  SetSavedDvar("wind_global_hi_altitude", 6000);
  SetSavedDvar("wind_global_low_strength_percent", 0.3);
}
precache_util_fx() {}
precache_scripted_fx() {
  level._effect["zombie_power_switch"] = loadfx("maps/zombie/fx_zombie_power_switch");
  level._effect["lunar_lander_dust"] = loadfx("maps/zombie/fx_zombie_lunar_lander_dust");
  level._effect["lunar_lander_thruster_bellow"] = loadfx("maps/zombie/fx_zombie_lunar_lander_thruster_bellow");
  level._effect["lunar_lander_thruster_leg"] = loadfx("maps/zombie/fx_zombie_lunar_lander_thruster_leg");
  level._effect["rocket_blast_trail"] = loadfx("maps/zombie/fx_russian_rocket_exhaust_zmb");
  level._effect["rocket_exp_1"] = loadfx("maps/zombie/fx_zmb_csm_rocket_exp");
  level._effect["debris_trail"] = loadfx("maps/flashpoint/fx_exp_rocket_debris_trail");
  level._effect["debris_hit"] = loadfx("maps/zombie/fx_zombie_ape_spawn_dust");
  level._effect["mig_trail"] = loadfx("trail/fx_geotrail_jet_contrail");
  level._effect["large_ceiling_dust"] = loadfx("maps/zombie/fx_dust_ceiling_impact_lg_mdbrown");
  level._effect["poltergeist"] = loadfx("misc/fx_zombie_couch_effect");
  level._effect["gasfire"] = loadfx("destructibles/fx_dest_fire_vert");
  level._effect["switch_sparks"] = loadfx("env/electrical/fx_elec_wire_spark_burst");
  level._effect["wire_sparks_oneshot"] = loadfx("env/electrical/fx_elec_wire_spark_dl_oneshot");
  level._effect["gersh_spark"] = loadfx("maps/zombie/fx_mp_light_corona_bulb_ceiling");
  level._effect["wire_spark"] = loadfx("maps/zombie/fx_zombie_wire_spark");
  level._effect["soul_spark"] = loadfx("maps/zombie/fx_zmb_blackhole_zombie_death");
  level._effect["electric_current"] = loadfx("misc/fx_zombie_elec_trail");
  level._effect["zapper_fx"] = loadfx("misc/fx_zombie_zapper_powerbox_on");
  level._effect["zapper"] = loadfx("misc/fx_zombie_electric_trap");
  level._effect["zapper_wall"] = loadfx("misc/fx_zombie_zapper_wall_control_on");
  level._effect["zapper_light_ready"] = loadfx("misc/fx_zombie_zapper_light_green");
  level._effect["zapper_light_notready"] = loadfx("misc/fx_zombie_zapper_light_red");
  level._effect["dangling_wire"] = loadfx("maps/zombie/fx_zmb_elec_burst_heavy_os_int");
  level._effect["elec_md"] = loadfx("maps/zombie/fx_elec_player_md");
  level._effect["elec_sm"] = loadfx("maps/zombie/fx_elec_player_sm");
  level._effect["elec_torso"] = loadfx("maps/zombie/fx_elec_player_torso");
  level._effect["fire_trap_cosmo"] = loadfx("maps/zombie/fx_zmb_cosmo_trap_fire_md");
  level._effect["lght_marker"] = loadfx("maps/zombie/fx_zombie_coast_marker");
  level._effect["lght_marker_flare"] = loadfx("maps/zombie/fx_zombie_coast_marker_fl");
  level._effect["powercell"] = loadfx("maps/zombie/fx_zombie_pack_a_punch_battery_glow");
  level._effect["rocket_spotlight"] = loadFX("maps/zombie/fx_mp_ray_spotlight_xlg");
  level._effect["centrifuge_warning_light"] = LoadFX("maps/zombie/fx_zmb_light_centrifuge_top");
  level._effect["centrifuge_light_spark"] = LoadFX("maps/zombie/fx_zombie_centrifuge_spark");
  level._effect["centrifuge_start_steam"] = LoadFX("maps/zombie/fx_zmb_csm_centrifuge_steam_blst");
  level._effect["panel_green"] = LoadFX("maps/zombie/fx_zmb_csm_lander_panel_green");
  level._effect["panel_red"] = LoadFX("maps/zombie/fx_zmb_csm_lander_panel_red");
  level._effect["lander_green_left"] = loadfx("maps/zombie/fx_zmb_csm_lander_pad_green_lft");
  level._effect["lander_green_right"] = loadfx("maps/zombie/fx_zmb_csm_lander_pad_green");
  level._effect["lander_red_left"] = loadfx("maps/zombie/fx_zmb_csm_lander_pad_red_lft");
  level._effect["lander_red_right"] = loadfx("maps/zombie/fx_zmb_csm_lander_pad_red");
  level._effect["lander_green"] = loadfx("maps/zombie/fx_zmb_csm_lander_post_green");
  level._effect["lander_red"] = loadfx("maps/zombie/fx_zmb_csm_lander_post_red");
  level._effect["auto_turret_light"] = loadfx("maps/zombie/fx_zombie_auto_turret_light");
  level._effect["zomb_gib"] = Loadfx("maps/zombie/fx_zombie_dog_explosion");
  level._effect["test_spin_fx"] = LoadFX("env/light/fx_light_warning");
}
precache_createfx_fx() {
  level._effect["fx_tower_light_glow"] = loadfx("maps/flashpoint/fx_tower_light_glow");
  level._effect["fx_zombie_rocket_trap_heat_glow"] = loadfx("maps/zombie/fx_zombie_rocket_trap_heat_glow");
  level._effect["fx_zombie_nuke_distant"] = loadfx("maps/zombie/fx_zombie_nuke_distant");
  level._effect["fx_zmb_water_spray_leak_sm"] = loadfx("maps/zombie/fx_zmb_water_spray_leak_sm");
  level._effect["fx_zmb_pipe_steam_md"] = loadfx("maps/zombie/fx_zmb_pipe_steam_md");
  level._effect["fx_zmb_pipe_steam_md_runner"] = loadfx("maps/zombie/fx_zmb_pipe_steam_md_runner");
  level._effect["fx_zmb_steam_hallway_md"] = loadfx("maps/zombie/fx_zmb_steam_hallway_md");
  level._effect["fx_zmb_fog_lit_overhead_amber"] = loadfx("maps/zombie/fx_zmb_fog_lit_overhead_amber");
  level._effect["fx_zmb_fog_thick_300x300"] = loadfx("maps/zombie/fx_zmb_fog_thick_300x300");
  level._effect["fx_zmb_fog_thick_600x600"] = loadfx("maps/zombie/fx_zmb_fog_thick_600x600");
  level._effect["fx_zmb_fog_thick_1200x1200"] = loadfx("maps/zombie/fx_zmb_fog_thick_1200x1200");
  level._effect["fx_zmb_fog_dropdown"] = loadfx("maps/zombie/fx_zmb_fog_dropdown");
  level._effect["fx_zmb_fog_interior_md"] = loadfx("maps/zombie/fx_zmb_fog_interior_md");
  level._effect["fx_zmb_fog_lit_overhead"] = loadfx("maps/zombie/fx_zmb_fog_lit_overhead");
  level._effect["fx_zmb_light_floodlight_bright"] = loadfx("maps/zombie/fx_zmb_light_floodlight_bright");
  level._effect["fx_zmb_light_fluorescent_tube"] = loadfx("maps/zombie/fx_zmb_light_fluorescent_tube");
  level._effect["fx_zmb_light_incandescent"] = loadfx("maps/zombie/fx_zmb_light_incandescent");
  level._effect["fx_zmb_light_square_white"] = loadfx("maps/zombie/fx_zmb_light_square_white");
  level._effect["fx_zmb_light_cagelight01"] = loadfx("maps/zombie/fx_zmb_csm_light_cagelight01");
  level._effect["fx_zmb_light_flashlight"] = loadfx("maps/zombie/fx_zmb_light_flashlight");
  level._effect["fx_light_dust_motes_xsm"] = loadfx("env/light/fx_light_dust_motes_xsm");
  level._effect["fx_zmb_booster_condensation"] = loadfx("maps/zombie/fx_zmb_booster_condensation");
  level._effect["fx_zmb_elec_spark_burst_loop"] = loadfx("maps/zombie/fx_zmb_elec_spark_burst_loop");
  level._effect["fx_zmb_fire_sm_smolder"] = loadfx("maps/zombie/fx_zmb_fire_sm_smolder");
  level._effect["fx_fire_line_xsm"] = loadfx("env/fire/fx_fire_line_xsm");
  level._effect["fx_fire_line_sm"] = loadfx("env/fire/fx_fire_line_sm");
  level._effect["fx_fire_wall_back_sm"] = loadfx("env/fire/fx_fire_wall_back_sm");
  level._effect["fx_fire_destruction_lg"] = loadfx("env/fire/fx_fire_destruction_lg");
  level._effect["fx_zmb_smk_linger_lit"] = loadfx("maps/zombie/fx_zmb_smk_linger_lit");
  level._effect["fx_zmb_smk_plume_md_wht_wispy"] = loadfx("maps/zombie/fx_zmb_smk_plume_md_wht_wispy");
  level._effect["fx_smk_fire_md_black"] = loadfx("env/smoke/fx_smk_fire_md_black");
  level._effect["fx_ship_smk_fire_xlg_black"] = loadfx("maps/underwaterbase/fx_ship_smk_fire_xlg_black");
  level._effect["fx_zmb_pad_light"] = loadfx("maps/zombie/fx_zmb_csm_rocket_pad_light");
  level._effect["fx_zmb_gantry_coolant_md"] = loadfx("maps/zombie/fx_zmb_gantry_coolant_md");
  level._effect["fx_elec_terminal"] = loadfx("maps/zombie/fx_zmb_elec_terminal_arc");
  level._effect["fx_zmb_elec_terminal_bridge"] = loadfx("maps/zombie/fx_zmb_elec_terminal_bridge");
  level._effect["fx_zmb_russian_rocket_smk"] = loadfx("maps/zombie/fx_zmb_russian_rocket_smk");
}
initModelAnims() {
  level.scr_anim["fxanim_props"]["a_wirespark_long"][0] = % fxanim_gp_wirespark_long_anim;
  level.scr_anim["fxanim_props"]["a_wirespark_med"][0] = % fxanim_gp_wirespark_med_anim;
  addNotetrack_customFunction("fxanim_props", "long_spark_wire", ::wirespark_fx_1, "a_wirespark_long");
  addNotetrack_customFunction("fxanim_props", "med_spark_wire", ::wirespark_fx_2, "a_wirespark_med");
  enta_wirespark_long = getEntArray("fxanim_gp_wirespark_long_mod", "targetname");
  enta_wirespark_med = getEntArray("fxanim_gp_wirespark_med_mod", "targetname");
  for(i = 0; i < enta_wirespark_long.size; i++) {
    enta_wirespark_long[i] thread wirespark_long(1, 5);
    PrintLn("************* FX: wirespark_long*************");
  }
  for(i = 0; i < enta_wirespark_med.size; i++) {
    enta_wirespark_med[i] thread wirespark_med(1, 5);
    println("************* FX: wirespark_med*************");
  }
}
wirespark_long(delay_min, delay_max) {
  wait(3);
  wait(delay_min);
  wait(randomfloat(delay_max - delay_min));
  self UseAnimTree(#animtree);
  self.animname = "fxanim_props";
  level thread anim_loop(self, "a_wirespark_long");
}
wirespark_med(delay_min, delay_max) {
  wait(3);
  wait(delay_min);
  wait(randomfloat(delay_max - delay_min));
  self UseAnimTree(#animtree);
  self.animname = "fxanim_props";
  level thread anim_loop(self, "a_wirespark_med");
}
wirespark_fx_1(guy) {
  wire_model = spawn("script_model", guy.origin);
  wire_model setModel("tag_origin");
  wire_model LinkTo(guy, "long_spark_06_jnt", (0, 0, 0), (0, 0, 0));
  playFXOnTag(level._effect["dangling_wire"], wire_model, "tag_origin");
  playsoundatposition("amb_spark_special", wire_model.origin);
  wait(0.5);
  wire_model Delete();
}
wirespark_fx_2(guy) {
  wire_model = spawn("script_model", guy.origin);
  wire_model setModel("tag_origin");
  wire_model LinkTo(guy, "med_spark_06_jnt", (0, 0, 0), (0, 0, 0));
  playFXOnTag(level._effect["dangling_wire"], wire_model, "tag_origin");
  playsoundatposition("amb_spark_special", wire_model.origin);
  wait(0.5);
  wire_model Delete();
}