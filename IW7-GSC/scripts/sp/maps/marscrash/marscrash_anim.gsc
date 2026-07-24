/********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\maps\marscrash\marscrash_anim.gsc
********************************************************/

main() {
  _id_91DC();
  _id_EE25();
  _id_13267();
  jackals();
  player();
}

#using_animtree("generic_human");

_id_91DC() {
  level._id_EC85["medic"]["triage_idle"][0] = % mars_10_2a_kash_dies_ally01_idle;
  level._id_EC85["injured"]["triage_idle"][0] = % mars_10_2a_kash_dies_ally02_idle;
  level._id_EC85["medic"]["triage_call"] = % mars_10_2a_kash_dies_ally01_calls_plr;
  level._id_EC85["injured"]["triage_call"] = % mars_10_2a_kash_dies_ally02_calls_plr;
  level._id_EC85["medic"]["triage_point"] = % mars_10_2a_kash_dies_ally01_points;
  level._id_EC85["injured"]["triage_point"] = % mars_10_2a_kash_dies_ally02_points;
  level._id_EC89["medic"]["triage_point"] = 1.0;
  level._id_EC89["injured"]["triage_point"] = 1.0;
  level._id_EC85["brooks"]["kash_death_idle"][0] = % mars_10_2b_kash_dies_mr1_comfort_idle;
  level._id_EC85["kashima"]["kash_death_idle"][0] = % mars_10_2b_kash_dies_mr2_comfort_idle;
  level._id_EC85["brooks"]["kash_death_kneel"] = % mars_10_2b_kash_dies_mr1_scene1_kneels_down;
  level._id_EC85["brooks"]["kash_death_call"] = % mars_10_2b_kash_dies_mr1_scene1_calls_plr;
  level._id_EC85["brooks"]["kash_death_lift_start"] = % mars_10_2b_kash_dies_mr1_grab_door_intro;
  level._id_EC85["kashima"]["kash_death_lift_start"] = % mars_10_2b_kash_dies_mr2_grab_door_intro;
  level._id_EC89["kashima"]["kash_death_lift_start"] = 0.0;
  level._id_EC85["brooks"]["kash_death_lift_idle"][0] = % mars_10_2b_kash_dies_mr1_grab_door_idle;
  level._id_EC85["kashima"]["kash_death_lift_idle"][0] = % mars_10_2b_kash_dies_mr2_grab_door_idle;
  level._id_EC85["brooks"]["kash_death_lift"] = % mars_10_2b_kash_dies_mr1_door_lift;
  level._id_EC85["kashima"]["kash_death_lift"] = % mars_10_2b_kash_dies_mr2_door_lift;
  level._id_EC89["kashima"]["kash_death_lift"] = 0.0;
  level._id_EC85["brooks"]["kash_death_lift_finish"] = % mars_10_2b_kash_dies_mr1_scene2_hold_to_exit;
  scripts\sp\anim::_id_17F6("brooks", "mayhem_start", ::_id_30FF, "kash_death_lift_finish");
  level._id_EC85["kashima"]["kash_death_lift_finish"] = % mars_10_2b_kash_dies_mr2_scene2_held_down;
  level._id_EC85["brooks"]["kash_death_pressure_wait"][0] = % mars_10_2b_kash_dies_mr1_scene2_hold_kash_idle;
  level._id_EC85["kashima"]["kash_death_pressure_wait"][0] = % mars_10_2b_kash_dies_mr2_scene2_held_down_idle;
  level._id_EC85["brooks"]["kash_death_pressure_wait_nag"] = % mars_10_2b_kash_dies_mr1_scene2_hold_kash_nag;
  level._id_EC85["brooks"]["kash_death_pressure_wait_exit"] = % mars_10_2b_kash_dies_mr1_scene3_exit;
  scripts\sp\anim::_id_17F6("brooks", "mayhem_end", ::_id_30FE, "kash_death_pressure_wait_exit");
  level._id_EC85["kashima"]["kash_death_pressure_intro"] = % mars_10_2b_kash_dies_mr2_scene3_pressure_held;
  level._id_EC85["kashima"]["kash_death_pressure_1_a"] = % mars_10_2b_kash_dies_mr2_scene4_and_5_pain_a;
  scripts\sp\anim::_id_17F6("kashima", "mayhem_start", ::_id_A559, "kash_death_pressure_1_a");
  level._id_EC85["kashima"]["kash_death_pressure_3_a"] = % mars_10_2b_kash_dies_mr2_scene6_pain_a;
  level._id_EC85["kashima"]["kash_death"] = % mars_10_2b_kash_dies_mr2_death;
  level._id_EC85["brooks"]["kash_death_start_idle"][0] = % mars_10_2b_kash_dies_mr1_scene1_pulling_idle;
  level._id_EC85["kashima"]["kash_death_start_idle"][0] = % mars_10_2b_kash_dies_mr2_start_idle;
  level._id_EC85["dead_body"]["generic_dead_civ_01"][0] = % generic_dead_civ_01;
  level._id_EC85["dead_body"]["generic_dead_civ_02"][0] = % generic_dead_civ_02;
  level._id_EC85["dead_body"]["generic_dead_civ_03"][0] = % generic_dead_civ_03;
  level._id_EC85["dead_body"]["generic_dead_civ_04"][0] = % generic_dead_civ_04;
  level._id_EC85["dead_body"]["generic_dead_civ_05"][0] = % generic_dead_civ_05;
  level._id_EC85["dead_body"]["generic_dead_civ_06"][0] = % generic_dead_civ_06;
  level._id_EC85["dead_body"]["generic_dead_civ_07"][0] = % generic_dead_civ_07;
  level._id_EC85["dead_body"]["generic_dead_wall_lean_civ_01"][0] = % generic_dead_wall_lean_civ_01;
  level._id_EC85["dead_body"]["generic_dead_wall_lean_civ_02"][0] = % generic_dead_wall_lean_civ_02;
  level._id_EC85["dead_body"]["generic_dead_wall_lean_civ_03"][0] = % generic_dead_wall_lean_civ_03;
  level._id_EC85["hanging_body"]["kash_death_hanging_body"][0] = % mars_10_2b_kash_dies_hanging_body;
  level._id_EC85["hanging_body"]["kash_death_hanging_body_02"][0] = % mars_10_2b_kash_dies_hanging_body_02;
  level._id_EC85["hanging_body"]["kash_death_hanging_body_03"][0] = % mars_10_2b_kash_dies_hanging_body_03;
  level._id_EC85["collapser_guy"]["crash_site_collapser"] = % mars_crash_dropship_crash_collapser;
  level._id_EC85["crawler_guy"]["crash_site_crawler"] = % mars_crash_dropship_crash_crawler;
  scripts\sp\anim::_id_17FC("collapser_guy", "landing", "collapser_guy_landed", "crash_site_collapser");
  scripts\sp\anim::_id_17FC("kashima", "mayhem_start", "kashima_mayhem_start_a", "kash_death_pressure_1_a");
  scripts\sp\anim::_id_17FC("kashima", "mayhem_end", "kashima_mayhem_end_a", "kash_death_pressure_2_a");
  scripts\sp\anim::_id_17FC("kashima", "mayhem_start", "kashima_mayhem_start_b", "kash_death_pressure_3_a");
  scripts\sp\anim::_id_17FC("kashima", "mayhem_end", "kashima_mayhem_end_b", "kash_death");
  scripts\sp\anim::_id_17FC("kashima", "mayhem_start", "kashima_mayhem_start_c", "kash_death");
  level._id_EC88["brooks"]["marscrash_brk_captain"] = % marscrash_brk_captain_face;
  level._id_EC88["brooks"]["marscrash_brk_hangintherebuddy"] = % marscrash_brk_hangintherebuddy_face;
  level._id_EC88["kashima"]["marscrash_ksh_noproblemsir"] = % marscrash_ksh_noproblemsir_face;
  level._id_EC88["brooks"]["marscrash_brk_youreokaykashimayoure"] = % marscrash_brk_youreokaykashimayoure_face;
}

#using_animtree("player");

player() {
  level._id_EC87["player_rig"] = #animtree;
  level._id_EC8C["player_rig"] = "vm_hero_protagonist_arms_blood";
  level._id_EC87["player_rig_bloody"] = #animtree;
  level._id_EC8C["player_rig_bloody"] = "vm_hero_protagonist_arms_blood";
  level._id_EC85["player_rig"]["intro_climbout_start"] = % mars_intro_plr_climbout_start;
  level._id_EC85["player_rig"]["intro_climbout_idle"][0] = % mars_intro_plr_climbout_idle;
  level._id_EC85["player_rig"]["intro_climbout_exit"] = % mars_intro_plr_climbout;
  level._id_EC85["player_rig"]["intro_climbout_canopy"] = % mars_intro_plr_climbout_hands_on_canopy;
  level._id_EC85["player_rig"]["intro_climbout_canopy_idle"][0] = % mars_intro_plr_climbout_hands_on_canopy_idle;
  level._id_EC85["player_rig"]["intro_climbout_canopy_push"][0] = % mars_intro_plr_climbout_hands_on_canopy_push;
  level._id_EC85["player_rig"]["intro_climbout_canopy_death"] = % mars_intro_plr_climbout_hands_on_canopy_death;
  level._id_EC89["player_rig"]["intro_climbout_canopy_push"] = 1.0;
  level._id_EC89["player_rig"]["kash_death_lift_start"] = 1.0;
  level._id_EC85["player_rig"]["kash_death_lift_start"] = % mars_10_2b_kash_dies_plr_grab_door_intro;
  level._id_EC85["player_rig"]["kash_death_lift_idle"][0] = % mars_10_2b_kash_dies_plr_grab_door_idle;
  level._id_EC85["player_rig"]["kash_death_lift"] = % mars_10_2b_kash_dies_plr_door_lift;
  level._id_EC85["player_rig"]["kash_death_lift_finish"] = % mars_10_2b_kash_dies_plr_scene2_hold_kash;
  level._id_EC85["player_rig"]["kash_death_pressure_wait"][0] = % mars_10_2b_kash_dies_plr_scene2_hold_kash_idle;
  level._id_EC85["player_rig_bloody"]["kash_death_pressure_wait"][0] = % mars_10_2b_kash_dies_plr_scene2_hold_kash_idle;
  level._id_EC85["player_rig"]["kash_death_pressure_intro"] = % mars_10_2b_kash_dies_plr_scene3_hold_pressure_intro;
  scripts\sp\anim::_id_17FC("player_rig", "plr_look_up", "player_looks_up", "kash_death_pressure_intro");
  level._id_EC85["player_rig"]["kash_death_pressure_apply"] = % mars_10_2b_kash_dies_plr_hold_pressure_intro;
  level._id_EC85["player_rig"]["kash_death_pressure_on"][0] = % mars_10_2b_kash_dies_plr_hold_pressure_idle;
  level._id_EC85["player_rig_bloody"]["kash_death_pressure_on"][0] = % mars_10_2b_kash_dies_plr_hold_pressure_idle;
  level._id_EC85["player_rig"]["kash_death_pressure_1_a"] = % mars_10_2b_kash_dies_plr_scene4_pain_a;
  level._id_EC85["player_rig"]["kash_death_pressure_2_a"] = % mars_10_2b_kash_dies_plr_scene5_pain_a;
  scripts\sp\anim::_id_17FC("player_rig", "plr_look_up", "player_looks_up", "kash_death_pressure_2_a");
  level._id_EC85["player_rig"]["kash_death_pressure_3_a"] = % mars_10_2b_kash_dies_plr_scene6_pain_a;
  scripts\sp\anim::_id_17FC("player_rig", "grab_arm", "kash_grabs_arm", "kash_death_pressure_3_a");
  level._id_EC85["player_rig"]["kash_death_pressure_release"] = % mars_10_2b_kash_dies_plr_release_pressure;
  level._id_EC85["player_rig"]["kash_death_pressure_off"][0] = % mars_10_2b_kash_dies_plr_release_pressure_idle;
  level._id_EC85["player_rig"]["kash_death"] = % mars_10_2b_kash_dies_plr_kash_death;
  scripts\sp\anim::_id_17FC("player_rig", "plr_look_up", "player_looks_up", "kash_death");
}

#using_animtree("script_model");

_id_EE25() {
  level._id_EC87["wires"] = #animtree;
  level._id_EC85["wires"]["wires_hanging"][0] = % iw7_fxanim_gp_wires_hanging_01_s3_anim;
  level._id_EC85["wires"]["wires_ground"][0] = % iw7_fxanim_gp_wire_sparking_ground_01_anim;
  level._id_EC85["wires"]["wires_small"][0] = % iw7_fxanim_gp_wire_sparking_sml_anim;
  level._id_EC85["wires"]["wires_thick"][0] = % iw7_fxanim_gp_wire_sparking_med_thick_anim;
  level._id_EC85["wires"]["wires_crash_site"][0] = % iw7_fxanim_sp_mars_wires_crash_site_anim;
  scripts\sp\anim::_id_1800("wires", "wire_spark", "wires_ground", "vfx_mars_sparks_burst_wire_runner", "spark_fx_01_jnt");
  scripts\sp\anim::_id_1800("wires", "wire_spark", "wires_small", "vfx_mars_sparks_burst_wire_runner", "spark_fx_01_jnt");
  scripts\sp\anim::_id_1800("wires", "wire_spark", "wires_thick", "vfx_mars_sparks_burst_wire_runner", "spark_fx_01_jnt");
  level._id_EC87["wing"] = #animtree;
  level._id_EC8C["wing"] = "iw7_fxanim_sp_mars_dropship_debris_mod";
  level._id_EC85["wing"]["hanging_wing"] = % iw7_fxanim_sp_mars_dropship_debris_anim;
  level._id_EC87["mdl_rockslide"] = #animtree;
  level._id_EC85["mdl_rockslide"]["fxanim_rockslide"] = % iw7_fxanim_sp_mars_rockslide_crash_anim;
  level._id_EC87["cockpit_rocks"] = #animtree;
  level._id_EC85["cockpit_rocks"]["fxanim_cockpit_rocks"] = % iw7_fxanim_sp_mars_rock_debris_cockpit_anim;
  level._id_EC87["door"] = #animtree;
  level._id_EC8C["door"] = "airplane_debris_destroyed_03";
  level._id_EC85["door"]["kash_death_lift"] = % mars_10_2b_kash_dies_door_lift;
  level._id_EC85["door"]["kash_death_lift_idle"][0] = % mars_10_2b_kash_dies_door_idle;
  level._id_EC85["door"]["kash_death_lift_finish"] = % mars_10_2b_kash_dies_door_throw;
}

_id_13267() {}

#using_animtree("jackal");

jackals() {
  level._id_EC87["player_crashed_jackal"] = #animtree;
  level._id_EC8C["player_crashed_jackal"] = "veh_mil_air_un_jackal_01_dst_player";
  level._id_EC85["player_crashed_jackal"]["intro_climbout_exit"] = % mars_intro_jackal_climbout;
}

#using_animtree("generic_human");

_id_30FF(var_0) {
  level._id_30F6 _meth_82A2(%mayhem_mars_10_2b_kash_dies_mr1_scene2_hold_kash, 1.0, 0.0, 1.0);
  level._id_30F6 detach(level._id_30F6.headmodel);
  level._id_30F6 detach(level._id_30F6.hatmodel);
}

_id_30FE(var_0) {
  wait 2;
  level._id_30F6 clearanim(%mayhem_mars_10_2b_kash_dies_mr1_scene2_hold_kash, 0.0);
  level._id_30F6 attach(level._id_30F6.headmodel);
  level._id_30F6 attach(level._id_30F6.hatmodel);
}

_id_A559(var_0) {
  level._id_A54E clearanim(%mayhem_mars_10_2b_kash_dies_mr2_scene2_held_down, 0.0);
  level._id_A54E _meth_82A2(%mayhem_mars_10_2b_kash_dies_mr2_scene2_held_down, 1.0, 0.0, 1.0);
}

_id_A558(var_0) {
  wait 2;
  level._id_30F6 clearanim(%mayhem_mars_10_2b_kash_dies_mr1_scene2_hold_kash, 0.0);
  level._id_30F6 attach(level._id_30F6.headmodel);
  level._id_30F6 attach(level._id_30F6.hatmodel);
}