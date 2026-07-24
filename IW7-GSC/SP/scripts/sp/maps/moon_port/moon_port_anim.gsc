/********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\maps\moon_port\moon_port_anim.gsc
********************************************************/

main() {
  player();
  _id_13267();
  _id_91DC();
  _id_3353();
  _id_341D();
  script_model();
  _id_A056();
  _id_7747();
  _id_42E5();
}

#using_animtree("player");

player() {
  level._id_EC87["player_rig"] = #animtree;
  level._id_EC8C["player_rig"] = "vm_hero_protagonist_arms";
  level._id_EC85["player_rig"]["infil_ride"] = % moon_infil_drive_plr;
  scripts\sp\anim::_id_17FC("player_rig", "visor_lower_plr", "infil_player_visor_down", "infil_ride");
  scripts\sp\anim::_id_17FC("player_rig", "cam_shake_explode", "infil_cam_shake_explode", "infil_ride");
  scripts\sp\anim::_id_17F6("player_rig", "farren_pip", scripts\sp\maps\moon_port\moon_port_intro::_id_9455, "infil_ride");
  scripts\sp\anim::_id_17F6("player_rig", "ridein_crash_audio_zone", scripts\sp\maps\moon_port\moon_port_intro::_id_3C4C, "infil_ride");
  scripts\sp\anim::_id_17F6("player_rig", "ridein_music_start_drive", scripts\sp\maps\moon_port\moon_port_intro::ridein_music_start_drive, "infil_ride");
  scripts\sp\anim::_id_17F6("player_rig", "camera_lock", scripts\sp\maps\moon_port\moon_port_intro::_id_943C, "infil_ride");
  scripts\sp\anim::_id_17F6("player_rig", "gun_up", scripts\sp\maps\moon_port\moon_port_intro::_id_9450, "infil_ride");
  scripts\sp\anim::_id_17F6("player_rig", "gun_down", scripts\sp\maps\moon_port\moon_port_intro::_id_9448, "infil_ride");
  scripts\sp\anim::_id_17F6("player_rig", "camera_angles_on", scripts\sp\maps\moon_port\moon_port_intro::_id_9438, "infil_ride");
  scripts\sp\anim::_id_17F6("player_rig", "camera_angles_off", scripts\sp\maps\moon_port\moon_port_intro::_id_9439, "infil_ride");
  scripts\sp\anim::_id_17F6("player_rig", "stick_control_off", scripts\sp\maps\moon_port\moon_port_intro::_id_943A, "infil_ride");
  scripts\sp\anim::_id_17F6("player_rig", "stick_control_on", scripts\sp\maps\moon_port\moon_port_intro::_id_943B, "infil_ride");
  scripts\sp\anim::_id_17F6("player_rig", "start_slomo", scripts\sp\maps\moon_port\moon_port_intro::_id_9486, "infil_ride");
  scripts\sp\anim::_id_17FC("player_rig", "end_slomo", "infil_slowmo_end", "infil_ride");
  scripts\sp\anim::_id_17F6("player_rig", "ar_on", scripts\sp\maps\moon_port\moon_port_intro::_id_942C, "infil_ride");
  scripts\sp\anim::_id_17FC("player_rig", "ar_off", "infil_apc_ar_off", "infil_ride");
  scripts\sp\anim::_id_17FC("player_rig", "shutter_close", "infil_shutter_close", "infil_ride");
  level._id_EC85["player_rig"]["infil_getup"] = % moon_infil_crash_plr;
  scripts\sp\anim::_id_17F6("player_rig", "stick_control_off", scripts\sp\maps\moon_port\moon_port_intro::_id_943A, "infil_getup");
  scripts\sp\anim::_id_17F6("player_rig", "stick_control_on", scripts\sp\maps\moon_port\moon_port_intro::_id_943B, "infil_getup");
  scripts\sp\anim::_id_17F6("player_rig", "mayhem_start", scripts\sp\maps\moon_port\moon_port_intro::_id_9460, "infil_ride");
  scripts\sp\anim::_id_17FC("player_rig", "mayhem_end", "infil_getup_mayhem_end", "infil_ride");
  level._id_EC85["player_rig"]["knockback"] = % moon_skyway_drag_player;
  level._id_EC85["player_rig"]["decompressing"] = % moon_harass_getup_player;
  level._id_EC85["player_rig"]["open_airlock"] = % airlock_open_player;
  level._id_EC85["player_rig"]["buddy_door_open"] = % moon_buddy_door_plr_opendoor;
  scripts\sp\anim::_id_17FC("player_rig", "dof_salter", "c8_buddy_door_dof_salter", "buddy_door_open");
  scripts\sp\anim::_id_17FC("player_rig", "dof_mco", "c8_buddy_door_dof_mco", "buddy_door_open");
  scripts\sp\anim::_id_17FC("player_rig", "dof_off", "c8_buddy_door_dof_off", "buddy_door_open");
  level._id_EC85["player_rig"]["shield_intro"] = % moon_shield_intro_shield_player;
  level._id_EC85["player_rig"]["broken_airlock_push"] = % moon_team_airlock_plr_push;
  scripts\sp\anim::_id_17F6("player_rig", "helmet_off_immediate", ::_id_8E0C, "broken_airlock_push");
  scripts\sp\anim::_id_17F6("player_rig", "pvo_moon_plr_efforts1", ::_id_F2E2, "broken_airlock_push");
  level._id_EC85["player_rig"]["decomp_knockback_relative"] = % moon_suckout_knockback_plr;
  scripts\sp\anim::_id_17F6("player_rig", "visor_lower", ::_id_4F8B, "decomp_knockback_relative");
  level._id_EC85["player_rig"]["decomp_scene_a"] = % moon_suckout_plr_suck_start;
  level._id_EC85["player_rig"]["decomp_scene_b"] = % moon_suckout_suck_scene_plr;
  scripts\sp\anim::_id_17FC("player_rig", "crack1", "crack_1", "decomp_scene_b");
  scripts\sp\anim::_id_17FC("player_rig", "crack2", "crack_2", "decomp_scene_b");
  scripts\sp\anim::_id_17F6("player_rig", "crack2", ::_id_479E, "decomp_scene_b");
  scripts\sp\anim::_id_17FC("player_rig", "player_landed", "player_landed", "decomp_scene_b");
  scripts\sp\anim::_id_17FC("player_rig", "player_stands", "player_stands", "decomp_scene_b");
  level._id_EC85["player_rig"]["decomp_death"] = % moon_suckout_plr_suck_death;
}

#using_animtree("generic_human");

_id_91DC() {
  level._id_EC85["salter"]["infil_ride"] = % moon_infil_drive_xo;
  scripts\sp\anim::_id_17F6("salter", "start_firing", scripts\sp\maps\moon_port\moon_port_intro::_id_947A, "infil_ride");
  scripts\sp\anim::_id_17FC("salter", "stop_firing", "salter_stop_shoot", "infil_ride");
  level._id_EC85["eth3n"]["infil_ride"] = % moon_infil_drive_eth;
  level._id_EC85["marineCO"]["infil_ride"] = % moon_infil_drive_mco;
  level._id_EC85["atv1_marine0"]["infil_ride"] = % moon_infil_drive_jp2_ally1;
  level._id_EC85["atv1_marine1"]["infil_ride"] = % moon_infil_drive_jp2_ally2;
  level._id_EC85["atv1_marine2"]["infil_ride"] = % moon_infil_drive_jp2_ally3;
  level._id_EC85["atv1_marine3"]["infil_ride"] = % moon_infil_drive_jp2_ally4;
  level._id_EC85["atv1_marine4"]["infil_ride"] = % moon_infil_drive_jp2_ally5;
  level._id_EC85["atv2_marine0"]["infil_ride"] = % moon_infil_drive_jp3_ally1;
  level._id_EC85["atv2_marine1"]["infil_ride"] = % moon_infil_drive_jp3_ally2;
  level._id_EC85["atv2_marine2"]["infil_ride"] = % moon_infil_drive_jp3_ally3;
  level._id_EC85["atv2_marine3"]["infil_ride"] = % moon_infil_drive_jp3_ally4;
  level._id_EC85["atv2_marine4"]["infil_ride"] = % moon_infil_drive_jp3_ally5;
  level._id_EC85["atv3_marine4"]["infil_ride"] = % moon_infil_drive_jp4_ally5;
  level._id_EC85["crewman0"]["infil_ride"] = % moon_infil_drive_crew_1;
  level._id_EC85["crewman1"]["infil_ride"] = % moon_infil_drive_crew_2;
  level._id_EC85["apc_enemy"]["infil_ride"] = % moon_infil_drive_enemy_a;
  level._id_EC85["apc_enemy"]["apc_enemy_death"] = % moon_infil_drive_enemy_a_death;
  level._id_EC85["welldeck_crew"]["infil_welldeck_balcony"] = % shipcribgrav_upper_catwalk_seca_3_guyb;
  level._id_EC85["welldeck_crew"]["infil_welldeck_sledcheck"] = % shipcribgrav_jackal_serv_frantic_a_guy_01;
  level._id_EC89["welldeck_crew"]["infil_welldeck_jog"] = 1.75;
  level._id_EC85["welldeck_crew"]["infil_welldeck_jog"] = % shipcrib_red_jog_straight_01;
  level._id_EC85["salter"]["infil_getup"] = % moon_infil_crash_xo;
  level._id_EC85["eth3n"]["infil_getup"] = % moon_infil_crash_eth;
  level._id_EC85["marineCO"]["infil_getup"] = % moon_infil_crash_mco;
  level._id_EC85["marine1"]["infil_getup"] = % moon_infil_crash_goodwin;
  level._id_EC85["marine2"]["infil_getup"] = % moon_infil_crash_pvt;
  scripts\sp\anim::_id_17FA("marine2", "inside_airlock", "flag_allies_in_tutorial_airlock", "infil_getup");
  level._id_EC85["salter"]["infil_airlock_idle_1"][0] = % moon_crash_airlock_xo_idle_1;
  level._id_EC85["salter"]["infil_airlock_idle_2"][0] = % moon_crash_airlock_xo_idle_2;
  level._id_EC88["salter"]["moon_slt_moveout"] = % moon_slt_moveout_face;
  level._id_EC85["marineCO"]["infil_airlock_idle_1"][0] = % moon_crash_airlock_mco_idle_1;
  level._id_EC85["marineCO"]["infil_airlock_idle_2"][0] = % moon_crash_airlock_mco_idle_2;
  level._id_EC85["eth3n"]["infil_airlock_idle_1"][0] = % moon_crash_airlock_ethan_idle_1;
  level._id_EC85["eth3n"]["infil_airlock_idle_2"][0] = % moon_crash_airlock_ethan_idle_2;
  level._id_EC85["marine1"]["infil_airlock_idle_1"][0] = % moon_crash_airlock_goodwin_idle_1;
  level._id_EC85["marine1"]["infil_airlock_idle_2"][0] = % moon_crash_airlock_goodwin_idle_2;
  level._id_EC85["marine2"]["infil_airlock_idle_1"][0] = % moon_crash_airlock_pvt_idle_1;
  level._id_EC85["marine2"]["infil_airlock_idle_2"][0] = % moon_crash_airlock_pvt_idle_2;
  level._id_EC85["marineCO"]["infil_airlock_scene"] = % moon_crash_airlock_mco_scene;
  scripts\sp\anim::_id_17FA("marineCO", "mask_up", "flag_infil_airlock_complete", "infil_airlock_scene");
  scripts\sp\anim::_id_17F6("marineCO", "vo_moon_omr_surfaceforceact", scripts\sp\maps\moon_port\moon_port_intro::_id_942B, "infil_airlock_scene");
  level._id_EC85["salter"]["infil_airlock_scene"] = % moon_crash_airlock_xo_scene;
  scripts\sp\anim::_id_17FC("salter", "gravity_on", "airlock_gravity_on", "infil_airlock_scene");
  level._id_EC85["eth3n"]["infil_airlock_scene"] = % moon_crash_airlock_ethan_scene;
  level._id_EC85["marine1"]["infil_airlock_close"] = % moon_crash_airlock_goodwin_door_close;
  scripts\sp\anim::_id_17FA("marine1", "door_closed", "flag_airlock_door_closed", "infil_airlock_close");
  level._id_EC85["marine1"]["infil_airlock_scene_a"] = % moon_crash_airlock_goodwin_scene_a;
  level._id_EC85["marine1"]["infil_airlock_scene_b"] = % moon_crash_airlock_goodwin_scene_b;
  level._id_EC85["marine2"]["infil_airlock_scene"] = % moon_crash_airlock_pvt_scene;
  level._id_EC85["sdf_0"]["tut_shutter_scene"] = % moon_window_start_sdf_1;
  scripts\sp\anim::_id_17F6("sdf_0", "shutter_enemy_alert", ::_id_1018B, "tut_shutter_scene");
  level._id_EC85["sdf_1"]["tut_shutter_scene"] = % moon_window_start_sdf_2;
  level._id_EC85["generic"]["wave"] = % stand_exposed_wave_move_out;
  level._id_EC85["salter"]["tut_wallrun"] = % moon_wall_run_xo;
  level._id_EC85["eth3n"]["tut_wallrun"] = % moon_wall_run_ethan;
  level._id_EC85["marineCO"]["tut_wallrun"] = % moon_wall_run_mco;
  level._id_EC85["marine1"]["tut_wallrun"] = % moon_wall_run_xo;
  level._id_EC85["marine2"]["tut_wallrun"] = % moon_wall_run_ethan;
  level._id_EC85["marineCO"]["tut_high_run"] = % moon_curved_wallrun_high;
  level._id_EC85["eth3n"]["tut_high_run"] = % moon_curved_wallrun_high;
  level._id_EC85["salter"]["tut_high_run"] = % moon_curved_wallrun_high;
  level._id_EC85["marine1"]["tut_high_run"] = % moon_curved_wallrun_high;
  level._id_EC85["marine2"]["tut_high_run"] = % moon_curved_wallrun_high;
  level._id_EC85["marineCO"]["tut_low_run"] = % moon_curved_wallrun_low;
  level._id_EC85["eth3n"]["tut_low_run"] = % moon_curved_wallrun_low;
  level._id_EC85["salter"]["tut_low_run"] = % moon_curved_wallrun_low;
  level._id_EC85["marine1"]["tut_low_run"] = % moon_curved_wallrun_low;
  level._id_EC85["marine2"]["tut_low_run"] = % moon_curved_wallrun_low;
  level._id_EC85["tut_decomp_corpse_0"]["cap_ship_explo_decomp"] = % moon_bodies_suckout_corpse_1;
  level._id_EC85["tut_decomp_corpse_1"]["cap_ship_explo_decomp"] = % moon_bodies_suckout_corpse_2;
  level._id_EC85["tut_decomp_corpse_2"]["cap_ship_explo_decomp"] = % moon_bodies_suckout_corpse_3;
  level._id_EC85["tut_decomp_corpse_3"]["cap_ship_explo_decomp"] = % moon_bodies_suckout_corpse_4;
  level._id_EC85["tut_decomp_corpse_4"]["cap_ship_explo_decomp"] = % moon_bodies_suckout_corpse_5;
  level._id_EC85["tut_decomp_corpse_5"]["cap_ship_explo_decomp"] = % moon_bodies_suckout_corpse_6;
  level._id_EC85["tut_decomp_corpse_6"]["cap_ship_explo_decomp"] = % moon_bodies_suckout_corpse_7;
  level._id_EC85["suckout_guy_1"]["destroyer_suckout"] = % moon_window_tut_enemy1;
  level._id_EC85["suckout_guy_2"]["destroyer_suckout"] = % moon_window_tut_enemy2;
  level._id_EC85["suckout_guy_3"]["destroyer_suckout"] = % moon_window_tut_enemy3;
  level._id_EC85["suckout_guy_4"]["destroyer_suckout"] = % moon_window_tut_enemy4;
  level._id_EC85["suckout_guy_5"]["destroyer_suckout"] = % moon_window_tut_enemy5;
  level._id_EC85["marineCO"]["casual_walk"] = % hm_grnd_yel_casual_walk_forward01_ar;
  level._id_EC85["salter"]["casual_walk"] = % hm_grnd_yel_casual_walk_forward01_ar;
  level._id_EC85["major"]["casual_walk"] = % hm_grnd_grn_walk_casual_forward01;
  level._id_EC85["generic"]["hm_grnd_yel_casual_walk_forward01_ar"][0] = % hm_grnd_yel_casual_walk_forward01_ar;
  level._id_EC85["marineCO"]["moon_2_4_bodies"] = % moon_2_4_bodies_mco;
  level._id_EC85["eth3n"]["moon_2_4_bodies"] = % moon_2_4_bodies_c6i;
  level._id_EC85["salter"]["moon_2_4_bodies"] = % moon_2_4_bodies_xo;
  level._id_EC85["marine1"]["moon_2_4_bodies"] = % moon_2_4_bodies_goodwin;
  level._id_EC85["marine2"]["moon_2_4_bodies"] = % moon_2_4_bodies_private;
  level._id_EC85["corpse1"]["moon_2_4_bodies"] = % moon_2_4_bodies_corpse01;
  level._id_EC85["corpse2"]["moon_2_4_bodies"] = % moon_2_4_bodies_corpse02;
  level._id_EC85["corpse3"]["moon_2_4_bodies"] = % moon_2_4_bodies_corpse03;
  level._id_EC85["corpse4"]["moon_2_4_bodies"] = % moon_2_4_bodies_corpse04;
  level._id_EC85["corpse5"]["moon_2_4_bodies"] = % moon_2_4_bodies_corpse05;
  level._id_EC85["generic"]["curved_wallrun_1"] = % moon_curved_wallrun_1;
  level._id_EC85["generic"]["curved_wallrun_2"] = % moon_curved_wallrun_2;
  level._id_EC85["shooter1"]["execution_scene"] = % moon_execution_1_soldier;
  level._id_EC85["civ1"]["execution_scene"] = % moon_execution_1_civ;
  level._id_EC85["shooter2"]["execution_scene"] = % moon_execution_2_soldier;
  level._id_EC85["civ2"]["execution_scene"] = % moon_execution_2_civ;
  level._id_EC85["shooter3"]["execution_scene"] = % ph_streets_civis_execution_grpb_sdf;
  level._id_EC85["civ3"]["execution_scene"] = % ph_streets_civis_execution_grpb_civ01;
  level._id_EC85["civ4"]["execution_scene"] = % ph_streets_civis_execution_grpb_civ02;
  level._id_EC85["civ5"]["execution_scene"] = % ph_streets_civis_execution_grpb_civ03;
  level._id_EC85["civ6"]["execution_scene"] = % ph_streets_civis_execution_grpb_civ04;
  level._id_EC85["generic"]["dead_civ_01"] = % moon_dead_civ_01;
  level._id_EC85["generic"]["dead_civ_02"] = % moon_dead_civ_02;
  level._id_EC85["generic"]["dead_civ_03"] = % moon_dead_civ_03;
  level._id_EC85["generic"]["dead_civ_04"] = % moon_dead_civ_04;
  level._id_EC85["generic"]["dead_civ_05"] = % moon_dead_civ_05;
  level._id_EC85["generic"]["dead_civ_06"] = % moon_dead_civ_06;
  level._id_EC85["generic"]["dead_civ_07"] = % moon_dead_civ_07;
  level._id_EC85["c8_intro_marine"]["c8_intro"] = % moon_c8_intro_ally1;
  scripts\sp\anim::_id_17F6("c8_intro_marine", "start_death", ::_id_C0C7, "c8_intro");
  level._id_EC85["salter"]["shield_intro"] = % moon_shield_intro_xo;
  level._id_EC88["marineCO"]["moon_omr_marinesmakeduew"] = % moon_omr_marinesmakeduew_face;
  level._id_EC88["marineCO"]["moon_omr_letsgettheguard"] = % moon_omr_letsgettheguard_face;
  level._id_EC85["salter"]["buddy_door_enter"] = % moon_buddy_door_xo_enter;
  level._id_EC85["marineCO"]["buddy_door_enter"] = % moon_buddy_door_mco_enter;
  level._id_EC85["eth3n"]["buddy_door_enter"] = % moon_buddy_door_c6i_enter;
  level._id_EC85["marine1"]["buddy_door_enter"] = % moon_buddy_door_gw_enter;
  level._id_EC85["salter"]["buddy_door_idle"][0] = % moon_buddy_door_xo_idle;
  level._id_EC85["marineCO"]["buddy_door_idle"][0] = % moon_buddy_door_mco_idle;
  level._id_EC85["eth3n"]["buddy_door_idle"][0] = % moon_buddy_door_c6i_idle;
  level._id_EC85["marine1"]["buddy_door_idle"][0] = % moon_buddy_door_gw_idle;
  level._id_EC85["salter"]["buddy_door_open"] = % moon_buddy_door_xo_opendoor;
  scripts\sp\anim::_id_17FC("salter", "show_shield", "salter_show_shield", "buddy_door_open");
  scripts\sp\anim::_id_17FC("salter", "hide_shield", "salter_hide_shield", "buddy_door_open");
  level._id_EC85["marineCO"]["buddy_door_open"] = % moon_buddy_door_mco_opendoor;
  level._id_EC85["eth3n"]["buddy_door_open"] = % moon_buddy_door_c6i_opendoor;
  level._id_EC85["marine1"]["buddy_door_open"] = % moon_buddy_door_gw_opendoor;
  level._id_EC85["salter"]["buddy_door_nag"] = % moon_buddy_door_xo_nag;
  level._id_EC85["enemya"]["buddy_door_open"] = % moon_buddy_door_enemya_opendoor;
  scripts\sp\anim::_id_17F6("enemya", "start_death", ::_id_C0C7, "buddy_door_open");
  level._id_EC85["enemyb"]["buddy_door_open"] = % moon_buddy_door_enemyb_opendoor;
  scripts\sp\anim::_id_17F6("enemyb", "start_death", ::_id_C0C7, "buddy_door_open");
  level._id_EC85["mdf0"]["coastguard_c8_intro"] = % moon_coastguard_c8_death_guard1;
  scripts\sp\anim::_id_17F6("mdf0", "start_death", ::_id_C0C7, "coastguard_c8_intro");
  level._id_EC85["mdf1"]["coastguard_c8_intro"] = % moon_coastguard_c8_death_guard2;
  scripts\sp\anim::_id_17F6("mdf1", "start_death", ::_id_C0C7, "coastguard_c8_intro");
  level._id_EC85["mdf2"]["coastguard_c8_intro"] = % moon_coastguard_c8_death_guard3;
  scripts\sp\anim::_id_17F6("mdf2", "start_death", ::_id_C0C7, "coastguard_c8_intro");
  level._id_EC85["mdf3"]["coastguard_c8_intro"] = % moon_coastguard_c8_death_guard4;
  scripts\sp\anim::_id_17F6("mdf3", "start_death", ::_id_C0C7, "coastguard_c8_intro");
  level._id_EC85["marineCO"]["fob_halls_scope"] = % moon_fob_halls_mco_scope;
  level._id_EC85["salter"]["fob_halls_scope"] = % moon_fob_halls_xo_scope;
  level._id_EC85["eth3n"]["fob_halls_scope"] = % moon_fob_halls_c6i_scope;
  level._id_EC85["fob_redshirt1"]["fob_redshirt_idle1"][0] = % moon_fob_ally01_idle;
  level._id_EC85["fob_redshirt2"]["fob_redshirt_idle2"][0] = % moon_fob_ally02_idle;
  level._id_EC85["marineCO"]["fob_scene_unlock"] = % moon_fob_mco_unlock;
  level._id_EC85["fob_redshirt1"]["fob_scene_unlock"] = % moon_fob_ally01_unlock;
  level._id_EC85["fob_redshirt2"]["fob_scene_unlock"] = % moon_fob_ally02_unlock;
  level._id_EC85["generic"]["FoB_help_1_A_hit"] = % moon_outerfob_help_1_a_hit;
  level._id_EC85["generic"]["FoB_help_1_A_hit_idle"][0] = % moon_outerfob_help_1_a_hit_idle;
  level._id_EC85["generic"]["FoB_help_1_A_rescue"] = % moon_outerfob_help_1_a_rescue;
  level._id_EC85["generic"]["FoB_help_1_A_rescue_idle"][0] = % moon_outerfob_help_1_a_rescue_idle;
  level._id_EC85["generic"]["FoB_help_1_B_rescue"] = % moon_outerfob_help_1_b_rescue;
  level._id_EC85["generic"]["FoB_help_1_B_rescue_idle"][0] = % moon_outerfob_help_1_b_rescue_idle;
  level._id_EC85["generic"]["FoB_help_2_A_getup"] = % moon_outerfob_help_2_a_getup;
  level._id_EC85["generic"]["FoB_help_2_A_getup_idle"][0] = % moon_outerfob_help_2_a_getup_idle;
  level._id_EC85["generic"]["FoB_help_2_B_getup"] = % moon_outerfob_help_2_b_getup;
  level._id_EC85["generic"]["FoB_help_2_B_getup_idle"][0] = % moon_outerfob_help_2_b_getup_idle;
  level._id_EC85["generic"]["wounded_loop_01"][0] = % moon_wounded_loop_01;
  level._id_EC85["generic"]["wounded_loop_02"][0] = % moon_wounded_loop_02;
  level._id_EC85["generic"]["wounded_twitch_01"] = % moon_wounded_twitch_01;
  level._id_EC85["generic"]["wounded_twitch_02"] = % moon_wounded_twitch_02;
  level._id_EC85["generic"]["control_panel_1_intro"] = % moon_control_panel_1_intro;
  level._id_EC85["generic"]["control_panel_1_loop"][0] = % moon_control_panel_1_loop;
  level._id_EC85["generic"]["control_panel_2_intro"] = % moon_control_panel_2_intro;
  level._id_EC85["generic"]["control_panel_2_loop"][0] = % moon_control_panel_2_loop;
  level._id_EC85["generic"]["control_panel_3_intro"] = % moon_control_panel_3_intro;
  level._id_EC85["generic"]["control_panel_3_loop"][0] = % moon_control_panel_3_loop;
  level._id_EC85["corpse_0"]["decomp_knockback"] = % moon_suckout_knockback_corpse1;
  level._id_EC85["corpse_1"]["decomp_knockback"] = % moon_suckout_knockback_corpse2;
  level._id_EC85["corpse_2"]["decomp_knockback"] = % moon_suckout_knockback_corpse3;
  level._id_EC85["salter"]["decomp_knockback"] = % moon_suckout_knockback_xo;
  level._id_EC85["corpse_0"]["decomp_scene"] = % moon_suckout_scene_corpse1;
  level._id_EC85["corpse_1"]["decomp_scene"] = % moon_suckout_scene_corpse2;
  scripts\sp\anim::_id_17F6("corpse_1", "hit_floor", ::_id_4685, "decomp_scene");
  level._id_EC85["corpse_2"]["decomp_scene"] = % moon_suckout_scene_corpse3;
  level._id_EC85["marineCO"]["decomp_scene"] = % moon_suckout_scene_mco;
  level._id_EC85["eth3n"]["decomp_scene"] = % moon_suckout_scene_eth;
  scripts\sp\anim::_id_17FC("eth3n", "forklift_catch", "forklift_catch", "decomp_scene");
  scripts\sp\anim::_id_17FC("eth3n", "ethen_reachout", "ethen_reachout", "decomp_scene");
  scripts\sp\anim::_id_17FC("eth3n", "end_slide", "stop_slide_fx", "decomp_scene");
  level._id_EC85["salter"]["decomp_scene"] = % moon_suckout_scene_xo;
  scripts\sp\anim::_id_17F6("salter", "x_button_prompt", scripts\sp\maps\moon_port\moon_port_harass::_id_4F83, "decomp_scene");
  level._id_EC85["salter"]["harass_run"] = % moon_suckout_run_xo;
  scripts\sp\anim::_id_17FA("salter", "harrass_run_complete", "harras_run_complete", "harass_run");
  level._id_EC85["eth3n"]["harass_run"] = % moon_suckout_run_eth;
  level._id_EC85["marineCO"]["harass_run"] = % moon_suckout_run_mco;
  level._id_EC85["mdf1"]["harass_run"] = % moon_suckout_run_mdf1;
  level._id_EC85["mdf1"]["harass_run_idle"][0] = % moon_suckout_airlock_idle_mdf1;
  level._id_EC85["mdf2"]["harass_run"] = % moon_suckout_run_mdf2;
  scripts\sp\anim::_id_17FA("mdf2", "target_redshirt", "target_redshirt_2", "harass_run");
  level._id_EC85["mdf3"]["harass_run"] = % moon_suckout_run_mdf3;
  scripts\sp\anim::_id_17FA("mdf3", "target_redshirt", "target_redshirt_1", "harass_run");
  level._id_EC85["salter"]["decompressing"] = % moon_harass_getup_salter;
  level._id_EC85["marineCO"]["decompressing"] = % moon_harass_getup_ally02;
  level._id_EC85["eth3n"]["decompressing"] = % moon_harass_getup_ally03;
  level._id_EC85["salter"]["broken_airlock_xo_enter"] = % moon_team_airlock_xo_enter;
  level._id_EC85["salter"]["broken_airlock_xo_push_loop"][0] = % moon_team_airlock_xo_push_loop;
  level._id_EC85["salter"]["broken_airlock_push"] = % moon_team_airlock_xo_push;
  level._id_EC85["marineCO"]["broken_airlock_mco_push_loop"][0] = % moon_team_airlock_mco_push_loop;
  level._id_EC85["marineCO"]["broken_airlock_push"] = % moon_team_airlock_mco_push;
  level._id_EC85["eth3n"]["broken_airlock_c6i_push_loop"][0] = % moon_team_airlock_c6i_push_loop;
  level._id_EC85["eth3n"]["broken_airlock_push"] = % moon_team_airlock_c6i_push;
  level._id_EC85["mdf1"]["broken_airlock_push"] = % moon_team_airlock_ally01_push;
  level._id_EC85["marineCO"]["armory_mco_grenade_nag"] = % mn_2_25_armory_mco_grenade_nag;
  level._id_EC85["marineCO"]["armory_mco_grenade_interact"] = % mn_2_25_armory_mco_grenade_interact;
  level._id_EC85["marineCO"]["armory_mco_idle"][0] = % mn_2_25_armory_mco_idle;
  level._id_EC85["marineCO"]["armory_enter"] = % mn_2_25_armory_mco_enter;
  level._id_EC85["marineCO"]["armory_mco_exit"] = % mn_2_25_armory_mco_exit;
  level._id_EC85["marineCO"]["armory_mco_exit_idle"][0] = % mn_2_25_armory_mco_exit_idle;
  level._id_EC85["salter"]["armory_xo_gun_nag"] = % mn_2_25_armory_xo_gun_nag;
  level._id_EC85["salter"]["armory_xo_nothing_nag_face"] = % mn_2_25_armory_xo_nothing_nag_face;
  level._id_EC85["salter"]["armory_xo_idle"][0] = % mn_2_25_armory_xo_idle;
  level._id_EC85["salter"]["armory_enter"] = % mn_2_25_armory_xo_enter;
  level._id_EC85["eth3n"]["armory_c6i_terminal_nag"] = % mn_2_25_armory_c6i_terminal_nag;
  level._id_EC85["eth3n"]["armory_c6i_terminal_response"] = % mn_2_25_armory_c6i_terminal_response;
  level._id_EC85["eth3n"]["armory_c6i_idle"][0] = % mn_2_25_armory_c6i_idle;
  level._id_EC85["eth3n"]["armory_enter"] = % mn_2_25_armory_c6i_enter;
  level._id_EC85["eth3n"]["armory_c6i_exit"] = % mn_2_25_armory_c6i_exit;
  level._id_EC85["mdf1"]["armory_guard_grenade_nag"] = % mn_2_25_armory_guard_grenade_nag;
  level._id_EC85["mdf1"]["armory_guard_terminal_nag"] = % mn_2_25_armory_guard_terminal_nag;
  level._id_EC85["mdf1"]["armory_enter"] = % mn_2_25_armory_guard_enter;
  level._id_EC85["mdf1"]["armory_guard_nothing_nag"] = % mn_2_25_armory_guard_nothing_nag;
  level._id_EC85["mdf1"]["armory_guard_exit"] = % mn_2_25_armory_guard_exit;
  level._id_EC89["mdf1"]["armory_guard_exit"] = 2;
  level._id_EC85["mdf1"]["armory_guard_idle"][0] = % mn_2_25_armory_guard_idle;
  level._id_EC85["salter"]["secure_enter"] = % moon_2_30_secure_xo_enter;
  level._id_EC85["salter"]["secure_xo_loop"][0] = % moon_2_30_secure_xo_loop;
  level._id_EC85["salter"]["secure_xo_on_me"] = % moon_2_30_secure_xo_onme;
  level._id_EC85["salter"]["secure_xo_unlock"] = % moon_2_30_secure_xo_unlock;
  level._id_EC85["salter"]["secure_xo_nag"] = % moon_2_30_secure_xo_nag;
  level._id_EC85["mdf1"]["secure_guard_unlock"] = % moon_2_30_secure_ally01_unlock;
  level._id_EC89["mdf1"]["secure_guard_unlock"] = 2;
  level._id_EC85["marineCO"]["secure_enter"] = % moon_2_30_secure_mco;
  level._id_EC85["salter"]["secure_room_xo"] = % moon_2_31_secure_hangar_xo;
  level._id_EC85["eth3n"]["secure_room_c6i"] = % moon_2_31_secure_hangar_c6i;
  level._id_EC85["marineCO"]["secure_room_mco_enter"] = % moon_2_31_secure_hangar_mco;
  level._id_EC85["mdf1"]["secure_room_guard"] = % moon_2_31_secure_hangar_trooper;
  level._id_EC85["mdf1"]["secure_room_guard_loop"][0] = % moon_2_31_secure_hangar_trooper_loop;
  level._id_EC85["salter"]["secure_elev"] = % moon_2_32_elev_xo;
  level._id_EC85["salter"]["secure_elev_idle"][0] = % moon_2_32_elev_idle_xo;
  level._id_EC85["salter"]["secure_elev_nag"] = % moon_2_32_elev_xo_nag;
  level._id_EC85["eth3n"]["secure_elev"] = % moon_2_32_elev_eth3n;
  level._id_EC85["eth3n"]["secure_elev_idle"][0] = % moon_2_32_elev_idle_c6i;
  level._id_EC85["marineCO"]["secure_elev"] = % moon_2_32_elev_mco;
  level._id_EC85["marineCO"]["secure_elev_idle"][0] = % moon_2_32_elev_idle_mco;
  level._id_EC88["marineCO"]["moon_mco_wereonthemove"] = % moon_mco_wereonthemove_face;
  level._id_EC88["marineCO"]["moon_omr_brookskashima"] = % moon_omr_brookskashima_face;
  level._id_EC88["mdf1"]["moon_ms3_heresthearmoryc"] = % moon_ms3_heresthearmoryc_face;
  level._id_EC88["mdf1"]["moon_ms3_afteryousir"] = % moon_ms3_afteryousir_face;
  level._id_EC88["salter"]["moon_slt_badassarmorshou"] = % moon_slt_badassarmorshou_face;
  level._id_EC88["cg_door_opener"]["moon_un2_ourpeoplearejust"] = % moon_un2_16_32_i2;
  level._id_EC88["cg_door_opener"]["moon_grd_werecutofffrom"] = % moon_un5_17_25_i2;
}

#using_animtree("c6");

_id_3353() {
  level._id_EC85["corpse"]["exposed_death_c6"] = % c6_grnd_red_exposed_death_falls_2_ar;
  level._id_EC87["decomp_corpse"] = #animtree;
  level._id_EC8C["decomp_corpse"] = "robot_c6";
  level._id_EC85["decomp_corpse"]["decomp_scene"] = % moon_suckout_scene_c6;
}

#using_animtree("c8");

_id_341D() {
  level._id_EC85["c8"]["c8_intro"] = % moon_c8_intro_c8;
  scripts\sp\anim::_id_17F6("c8", "open_shield_bottom", _id_0A04::_id_3488, "c8_intro");
  scripts\sp\anim::_id_17F6("c8", "open_shield_top", _id_0A04::_id_3489, "c8_intro");
  scripts\sp\anim::_id_17FC("c8", "start_ally1", "c8_intro_marine_start", "c8_intro");
  scripts\sp\anim::_id_17F6("c8", "glass_break", scripts\sp\maps\moon_port\moon_port_concourse::_id_44AD, "c8_intro");
  scripts\sp\anim::_id_17FC("c8", "second_land", "c8_intro_second_land", "c8_intro");
  level._id_EC85["c8"]["coastguard_c8_intro"] = % moon_coastguard_c8_death_c8;
}

#using_animtree("script_model");

script_model() {
  level._id_EC87["generic"] = #animtree;
  level._id_EC85["generic"]["astronaut_pose"] = % moon_space_suit_idle;
  level._id_EC87["welldeck"] = #animtree;
  level._id_EC8C["welldeck"] = "tag_origin";
  level._id_EC85["welldeck"]["infil_ride"] = % moon_infil_drive_welldeck;
  level._id_EC85["welldeck_doors_top"]["infil_ride"] = % moon_infil_drive_door_top;
  level._id_EC85["welldeck_doors_btm"]["infil_ride"] = % moon_infil_drive_door_btm;
  scripts\sp\anim::_id_17FC("welldeck_doors_btm", "lower_start", "welldeck_doors_start", "infil_ride");
  scripts\sp\anim::_id_17FC("welldeck_doors_btm", "lower_end", "welldeck_doors_stop", "infil_ride");
  scripts\sp\anim::_id_17FA("welldeck_doors_btm", "lower_start", "welldeck_doors_start", "infil_ride");
  level._id_EC87["infil_missile"] = #animtree;
  level._id_EC8C["infil_missile"] = "tag_origin";
  level._id_EC85["infil_missile"]["infil_ride"] = % moon_infil_drive_missile;
  scripts\sp\anim::_id_17FC("infil_missile", "missile_explode", "infil_welldeck_missile_explode", "infil_ride");
  scripts\sp\anim::_id_17F6("infil_missile", "missile_explode", scripts\sp\maps\moon_port\moon_port_intro::_id_946D, "infil_ride");
  level._id_EC87["atv_sled"] = #animtree;
  level._id_EC8C["atv_sled"] = "lapes_drop_rcs_thruster_seld_02";
  level._id_EC85["atv0_sled"]["infil_ride"] = % moon_infil_drive_jp1_sled;
  scripts\sp\anim::_id_17FC("atv0_sled", "sled_launch", "infil_jeep_welldeck_launch", "infil_ride");
  level._id_EC85["atv1_sled"]["infil_ride"] = % moon_infil_drive_jp2_sled;
  scripts\sp\anim::_id_17FC("atv1_sled", "thrust_left_front_on", "atv1_sled_thruster_front_le", "infil_ride");
  scripts\sp\anim::_id_17FC("atv1_sled", "thrust_left_front_off", "atv1_sled_thruster_front_le_stop", "infil_ride");
  scripts\sp\anim::_id_17FC("atv1_sled", "thrust_left_rear_on", "atv1_sled_thruster_rear_le", "infil_ride");
  scripts\sp\anim::_id_17FC("atv1_sled", "thrust_left_rear_off", "atv1_sled_thruster_rear_le_stop", "infil_ride");
  scripts\sp\anim::_id_17FC("atv1_sled", "thrust_right_front_on", "atv1_sled_thruster_front_ri", "infil_ride");
  scripts\sp\anim::_id_17FC("atv1_sled", "thrust_right_front_off", "atv1_sled_thruster_front_ri_stop", "infil_ride");
  scripts\sp\anim::_id_17FC("atv1_sled", "thrust_right_rear_on", "atv1_sled_thruster_rear_ri", "infil_ride");
  scripts\sp\anim::_id_17FC("atv1_sled", "thrust_right_rear_off", "atv1_sled_thruster_rear_ri_stop", "infil_ride");
  scripts\sp\anim::_id_17FC("atv1_sled", "retrorockets_on", "atv1_sled_retrorockets", "infil_ride");
  scripts\sp\anim::_id_17FC("atv1_sled", "retrorockets_off", "atv1_sled_retrorockets_off", "infil_ride");
  scripts\sp\anim::_id_17F6("atv1_sled", "sled_launch", scripts\sp\maps\moon_port\moon_port_intro::_id_9482, "infil_ride");
  level._id_EC85["atv2_sled"]["infil_ride"] = % moon_infil_drive_jp3_sled;
  scripts\sp\anim::_id_17FC("atv2_sled", "thrust_left_front_on", "atv2_sled_thruster_front_le", "infil_ride");
  scripts\sp\anim::_id_17FC("atv2_sled", "thrust_left_front_off", "atv2_sled_thruster_front_le_stop", "infil_ride");
  scripts\sp\anim::_id_17FC("atv2_sled", "thrust_left_rear_on", "atv2_sled_thruster_rear_le", "infil_ride");
  scripts\sp\anim::_id_17FC("atv2_sled", "thrust_left_rear_off", "atv2_sled_thruster_rear_le_stop", "infil_ride");
  scripts\sp\anim::_id_17FC("atv2_sled", "thrust_right_front_on", "atv2_sled_thruster_front_ri", "infil_ride");
  scripts\sp\anim::_id_17FC("atv2_sled", "thrust_right_front_off", "atv2_sled_thruster_front_ri_stop", "infil_ride");
  scripts\sp\anim::_id_17FC("atv2_sled", "thrust_right_rear_on", "atv2_sled_thruster_rear_ri", "infil_ride");
  scripts\sp\anim::_id_17FC("atv2_sled", "thrust_right_rear_off", "atv2_sled_thruster_rear_ri_stop", "infil_ride");
  scripts\sp\anim::_id_17FC("atv2_sled", "retrorockets_on", "atv2_sled_retrorockets", "infil_ride");
  scripts\sp\anim::_id_17FC("atv2_sled", "retrorockets_off", "atv2_sled_retrorockets_off", "infil_ride");
  scripts\sp\anim::_id_1800("atv2_sled", "sled_separate", "infil_ride", "vfx_rcs_sled_jettison", "tag_origin");
  scripts\sp\anim::_id_17F6("atv2_sled", "sled_launch", scripts\sp\maps\moon_port\moon_port_intro::_id_9482, "infil_ride");
  level._id_EC85["atv3_sled"]["infil_ride"] = % moon_infil_drive_jp4_sled;
  scripts\sp\anim::_id_17FC("atv3_sled", "thrust_left_front_on", "atv3_sled_thruster_front_le", "infil_ride");
  scripts\sp\anim::_id_17FC("atv3_sled", "thrust_left_front_off", "atv3_sled_thruster_front_le_stop", "infil_ride");
  scripts\sp\anim::_id_17FC("atv3_sled", "thrust_left_rear_on", "atv3_sled_thruster_rear_le", "infil_ride");
  scripts\sp\anim::_id_17FC("atv3_sled", "thrust_left_rear_off", "atv3_sled_thruster_rear_le_stop", "infil_ride");
  scripts\sp\anim::_id_17FC("atv3_sled", "thrust_right_front_on", "atv3_sled_thruster_front_ri", "infil_ride");
  scripts\sp\anim::_id_17FC("atv3_sled", "thrust_right_front_off", "atv3_sled_thruster_front_ri_stop", "infil_ride");
  scripts\sp\anim::_id_17FC("atv3_sled", "thrust_right_rear_on", "atv3_sled_thruster_rear_ri", "infil_ride");
  scripts\sp\anim::_id_17FC("atv3_sled", "thrust_right_rear_off", "atv3_sled_thruster_rear_ri_stop", "infil_ride");
  scripts\sp\anim::_id_17FC("atv3_sled", "retrorockets_on", "atv3_sled_retrorockets", "infil_ride");
  scripts\sp\anim::_id_17FC("atv3_sled", "retrorockets_off", "atv3_sled_retrorockets_off", "infil_ride");
  scripts\sp\anim::_id_1800("atv3_sled", "sled_separate", "infil_ride", "vfx_rcs_sled_jettison", "tag_origin");
  level._id_EC87["infil_crate"] = #animtree;
  level._id_EC8C["infil_crate"] = "ref_space_crate_b";
  level._id_EC85["infil_crate0"]["infil_ride"] = % moon_infil_shuttle_explosion_crate_1;
  level._id_EC85["infil_crate1"]["infil_ride"] = % moon_infil_shuttle_explosion_crate_2;
  level._id_EC85["infil_crate2"]["infil_ride"] = % moon_infil_shuttle_explosion_crate_3;
  level._id_EC87["shuttle_trailer"] = #animtree;
  level._id_EC8C["shuttle_trailer"] = "veh_civ_lnd_tarmac_vehicle_trailer";
  level._id_EC85["shuttle_trailer0"]["infil_ride"] = % moon_infil_shuttle_explosion_trailer_1;
  level._id_EC85["shuttle_trailer1"]["infil_ride"] = % moon_infil_shuttle_explosion_trailer_2;
  level._id_EC85["shuttle_trailer2"]["infil_ride"] = % moon_infil_shuttle_explosion_trailer_3;
  level._id_EC85["shuttle_trailer3"]["infil_ride"] = % moon_infil_shuttle_explosion_trailer_4;
  level._id_EC85["shuttle_trailer4"]["infil_ride"] = % moon_infil_shuttle_explosion_trailer_5;
  level._id_EC87["infil_barrel"] = #animtree;
  level._id_EC8C["infil_barrel"] = "veh_civ_lnd_tarmac_vehicle_trailer";
  level._id_EC85["infil_barrel0"]["infil_ride"] = % moon_infil_shuttle_explosion_barrel_1;
  level._id_EC85["infil_barrel1"]["infil_ride"] = % moon_infil_shuttle_explosion_barrel_2;
  level._id_EC85["infil_barrel2"]["infil_ride"] = % moon_infil_shuttle_explosion_barrel_3;
  level._id_EC85["infil_barrel3"]["infil_ride"] = % moon_infil_shuttle_explosion_barrel_4;
  level._id_EC85["infil_barrel4"]["infil_ride"] = % moon_infil_shuttle_explosion_barrel_5;
  level._id_EC85["infil_barrel5"]["infil_ride"] = % moon_infil_shuttle_explosion_barrel_6;
  level._id_EC87["infil_sofa"] = #animtree;
  level._id_EC8C["infil_sofa"] = "sofa_sectional_1_seater_corner_end";
  level._id_EC85["infil_sofa0"]["infil_ride"] = % moon_crash_suckout_seat_1;
  level._id_EC85["infil_sofa1"]["infil_ride"] = % moon_crash_suckout_seat_2;
  level._id_EC87["infil_sofa_2"] = #animtree;
  level._id_EC8C["infil_sofa_2"] = "sofa_sectional_1_seater_corner_end_flip";
  level._id_EC85["infil_sofa_2"]["infil_ride"] = % moon_crash_suckout_seat_3;
  level._id_EC87["infil_sofa_3_"] = #animtree;
  level._id_EC8C["infil_sofa_3_"] = "sofa_sectional_3_seater";
  level._id_EC85["infil_sofa_3_0"]["infil_ride"] = % moon_crash_suckout_table_1;
  level._id_EC85["infil_sofa_3_1"]["infil_ride"] = % moon_crash_suckout_table_2;
  level._id_EC87["infil_table"] = #animtree;
  level._id_EC8C["infil_table"] = "p7_zur_table_outdoor";
  level._id_EC85["infil_table"]["infil_ride"] = % moon_crash_suckout_couch_1;
  level._id_EC87["shuttle"] = #animtree;
  level._id_EC8C["shuttle"] = "veh_civ_air_spacetransport_shuttle_01";
  level._id_EC85["shuttle"]["infil_ride"] = % moon_infil_shuttle_explosion_shuttle_1;
  scripts\sp\anim::_id_17FC("shuttle", "explode", "infil_shuttle_explode", "infil_ride");
  level._id_EC87["ramp"] = #animtree;
  level._id_EC8C["ramp"] = "fence_industrial_blast_deflector_01";
  level._id_EC85["ramp"]["infil_ride"] = % moon_infil_drive_ramp;
  level._id_EC87["shutters"] = #animtree;
  level._id_EC8C["shutters"] = "machinery_mn_shutters_anim";
  level._id_EC85["shutters"]["infil_ride"] = % moon_infil_ride_shutters;
  level._id_EC85["shutters"]["shutters_close"] = % mn_shutters_close;
  level._id_EC85["shutters"]["shutters_open"] = % mn_shutters_open_1_frame;
  level._id_EC87["airlock_door"] = #animtree;
  level._id_EC85["airlock_door"]["infil_airlock_close"] = % moon_crash_airlock_door_close;
  level._id_EC85["airlock_door"]["open_airlock"] = % airlock_open_door;

  for(var_0 = 0; var_0 < 17; var_0++)
    level._id_EC87["tut_decomp_prop_" + var_0] = #animtree;

  level._id_EC87["tut_decomp_prop_charger"] = #animtree;
  level._id_EC87["tut_decomp_prop_table_0"] = #animtree;
  level._id_EC87["tut_decomp_prop_table_1"] = #animtree;
  level._id_EC87["tut_decomp_prop_sign"] = #animtree;
  level._id_EC85["tut_decomp_prop_0"]["cap_ship_explo_decomp"] = % moon_bodies_suckout_couch_1;
  level._id_EC85["tut_decomp_prop_1"]["cap_ship_explo_decomp"] = % moon_bodies_suckout_couch_2;
  level._id_EC85["tut_decomp_prop_2"]["cap_ship_explo_decomp"] = % moon_bodies_suckout_couch_3;
  level._id_EC85["tut_decomp_prop_3"]["cap_ship_explo_decomp"] = % moon_bodies_suckout_couch_4;
  level._id_EC85["tut_decomp_prop_4"]["cap_ship_explo_decomp"] = % moon_bodies_suckout_couch_5;
  level._id_EC85["tut_decomp_prop_5"]["cap_ship_explo_decomp"] = % moon_bodies_suckout_couch_6;
  level._id_EC85["tut_decomp_prop_6"]["cap_ship_explo_decomp"] = % moon_bodies_suckout_couch_7;
  level._id_EC85["tut_decomp_prop_7"]["cap_ship_explo_decomp"] = % moon_bodies_suckout_couch_8;
  level._id_EC85["tut_decomp_prop_8"]["cap_ship_explo_decomp"] = % moon_bodies_suckout_couch_9;
  level._id_EC85["tut_decomp_prop_9"]["cap_ship_explo_decomp"] = % moon_bodies_suckout_couch_10;
  level._id_EC85["tut_decomp_prop_10"]["cap_ship_explo_decomp"] = % moon_bodies_suckout_couch_11;
  level._id_EC85["tut_decomp_prop_11"]["cap_ship_explo_decomp"] = % moon_bodies_suckout_couch_12;
  level._id_EC85["tut_decomp_prop_12"]["cap_ship_explo_decomp"] = % moon_bodies_suckout_couch_13;
  level._id_EC85["tut_decomp_prop_13"]["cap_ship_explo_decomp"] = % moon_bodies_suckout_couch_14;
  level._id_EC85["tut_decomp_prop_14"]["cap_ship_explo_decomp"] = % moon_bodies_suckout_couch_15;
  level._id_EC85["tut_decomp_prop_15"]["cap_ship_explo_decomp"] = % moon_bodies_suckout_couch_16;
  level._id_EC85["tut_decomp_prop_16"]["cap_ship_explo_decomp"] = % moon_bodies_suckout_couch_17;
  level._id_EC85["tut_decomp_prop_charger"]["cap_ship_explo_decomp"] = % moon_bodies_suckout_charging_station_1;
  level._id_EC85["tut_decomp_prop_table_0"]["cap_ship_explo_decomp"] = % moon_bodies_suckout_coffee_table_1;
  level._id_EC85["tut_decomp_prop_table_1"]["cap_ship_explo_decomp"] = % moon_bodies_suckout_coffee_table_2;
  level._id_EC85["tut_decomp_prop_sign"]["cap_ship_explo_decomp"] = % moon_bodies_suckout_sign_1;
  level._id_EC87["c8_intro_droppod"] = #animtree;
  level._id_EC8C["c8_intro_droppod"] = "veh_mil_lnd_ca_droppod_c8";
  level._id_EC85["c8_intro_droppod"]["c8_intro"] = % moon_c8_intro_pod;
  level._id_EC87["retract_shield"] = #animtree;
  level._id_EC8C["retract_shield"] = "weapon_retract_shield_wm";
  level._id_EC85["retract_shield"]["buddy_door_open"] = % moon_buddy_door_shield_opendoor;
  level._id_EC87["buddy_door_door"] = #animtree;
  level._id_EC8C["buddy_door_door"] = "door_metal_concourse_01_white";
  level._id_EC85["buddy_door_door"]["buddy_door_open"] = % moon_buddy_door_door_opendoor;
  level._id_EC87["c8_shutter"] = #animtree;
  level._id_EC8C["c8_shutter"] = "window_spaceport_shutter_a";
  level._id_EC85["retract_shield"]["shield_intro"] = % moon_shield_intro_shield;
  level._id_EC87["retract_shield_folded_vm"] = #animtree;
  level._id_EC8C["retract_shield_folded_vm"] = "weapon_retract_shield_folded_vm";
  level._id_EC85["retract_shield_folded_vm"]["shield_intro"] = % moon_shield_intro_shield_closed;
  level._id_EC87["retract_shield_vm"] = #animtree;
  level._id_EC8C["retract_shield_vm"] = "weapon_retract_shield_vm";
  level._id_EC85["retract_shield_vm"]["shield_intro"] = % moon_shield_intro_shield_open;
  level._id_EC87["broken_airlock_door"] = #animtree;
  level._id_EC8C["broken_airlock_door"] = "door_airlock_01_door";
  level._id_EC85["broken_airlock_door"]["broken_airlock_push"] = % moon_team_airlock_door_push;
  level._id_EC87["broken_airlock_helmet"] = #animtree;
  level._id_EC8C["broken_airlock_helmet"] = "helmet_hero_protagonist_crack";
  level._id_EC85["broken_airlock_helmet"]["broken_airlock_push"] = % moon_team_airlock_helm_push;
  level._id_EC87["decomp_prop_0"] = #animtree;
  level._id_EC87["decomp_prop_1"] = #animtree;
  level._id_EC87["decomp_prop_2"] = #animtree;
  level._id_EC87["decomp_prop_3"] = #animtree;
  level._id_EC87["decomp_prop_4"] = #animtree;
  level._id_EC87["decomp_prop_5"] = #animtree;
  level._id_EC87["decomp_prop_6"] = #animtree;
  level._id_EC87["decomp_prop_7"] = #animtree;
  level._id_EC87["decomp_prop_8"] = #animtree;
  level._id_EC87["decomp_prop_9"] = #animtree;
  level._id_EC87["decomp_prop_10"] = #animtree;
  level._id_EC8C["decomp_prop_0"] = "sz_crate_federation_long";
  level._id_EC8C["decomp_prop_1"] = "sz_crate_federation_long";
  level._id_EC8C["decomp_prop_2"] = "furniture_spaceport_chair_02_triple_armrest";
  level._id_EC8C["decomp_prop_3"] = "chair_lounge_brn_01";
  level._id_EC8C["decomp_prop_4"] = "civ_luggage_03";
  level._id_EC8C["decomp_prop_5"] = "space_aluminum_case";
  level._id_EC8C["decomp_prop_6"] = "ap_luggage01";
  level._id_EC8C["decomp_prop_7"] = "ap_luggage01";
  level._id_EC8C["decomp_prop_8"] = "ap_luggage01";
  level._id_EC8C["decomp_prop_9"] = "luggage_softbody_01_a";
  level._id_EC8C["decomp_prop_10"] = "luggage_softbody_01_a";
  level._id_EC87["decomp_beam"] = #animtree;
  level._id_EC8C["decomp_beam"] = "building_support_frame_vertical";
  level._id_EC87["window_crate"] = #animtree;
  level._id_EC8C["window_crate"] = "container_ammo_crate";
  level._id_EC85["window_crate"]["destroyer_suckout"] = % moon_window_tut_window_crate;
  level._id_EC87["cover_crate"] = #animtree;
  level._id_EC8C["cover_crate"] = "dns_tact_crate";
  level._id_EC85["cover_crate"]["destroyer_suckout"] = % moon_window_tut_cover_crate;
  level._id_EC85["decomp_prop_0"]["decomp_knockback"] = % moon_suckout_knockback_prop1;
  level._id_EC85["decomp_prop_1"]["decomp_knockback"] = % moon_suckout_knockback_prop2;
  level._id_EC85["decomp_prop_2"]["decomp_knockback"] = % moon_suckout_knockback_prop3;
  level._id_EC85["decomp_prop_3"]["decomp_knockback"] = % moon_suckout_knockback_prop4;
  level._id_EC85["decomp_prop_4"]["decomp_knockback"] = % moon_suckout_knockback_prop5;
  level._id_EC85["decomp_prop_5"]["decomp_knockback"] = % moon_suckout_knockback_prop6;
  level._id_EC85["decomp_prop_6"]["decomp_knockback"] = % moon_suckout_knockback_prop7;
  level._id_EC85["decomp_prop_7"]["decomp_knockback"] = % moon_suckout_knockback_prop8;
  level._id_EC85["decomp_prop_8"]["decomp_knockback"] = % moon_suckout_knockback_prop9;
  level._id_EC85["decomp_prop_9"]["decomp_knockback"] = % moon_suckout_knockback_prop10;
  level._id_EC85["decomp_prop_10"]["decomp_knockback"] = % moon_suckout_knockback_prop11;
  level._id_EC85["decomp_beam"]["decomp_knockback"] = % moon_suckout_knockback_metal_beam;
  level._id_EC85["decomp_prop_0"]["decomp_scene"] = % moon_suckout_scene_prop1;
  level._id_EC85["decomp_prop_1"]["decomp_scene"] = % moon_suckout_scene_prop2;
  level._id_EC85["decomp_prop_2"]["decomp_scene"] = % moon_suckout_scene_prop3;
  level._id_EC85["decomp_prop_3"]["decomp_scene"] = % moon_suckout_scene_prop4;
  level._id_EC85["decomp_prop_4"]["decomp_scene"] = % moon_suckout_scene_prop5;
  level._id_EC85["decomp_prop_5"]["decomp_scene"] = % moon_suckout_scene_prop6;
  level._id_EC85["decomp_prop_6"]["decomp_scene"] = % moon_suckout_scene_prop7;
  level._id_EC85["decomp_prop_7"]["decomp_scene"] = % moon_suckout_scene_prop8;
  level._id_EC85["decomp_prop_8"]["decomp_scene"] = % moon_suckout_scene_prop9;
  level._id_EC85["decomp_prop_9"]["decomp_scene"] = % moon_suckout_scene_prop10;
  level._id_EC85["decomp_prop_10"]["decomp_scene"] = % moon_suckout_scene_prop11;
  level._id_EC85["decomp_beam"]["decomp_scene"] = % moon_suckout_scene_metal_beam;
  level._id_EC87["vault_obj"] = #animtree;
  level._id_EC85["vault_obj"]["mco_vault_obj"] = % moon_suckout_run_crate1;
  level._id_EC87["monorail"] = #animtree;
  level._id_EC85["monorail"]["monorail_buckle"] = % vfx_moon_monorail_buckle;
  level._id_EC8C["monorail"] = "vfx_moon_monorail_buckle";
  level._id_EC87["decomp_missile"] = #animtree;
  level._id_EC8C["decomp_missile"] = "tag_origin";
  level._id_EC85["decomp_missile"]["decomp_intro1"] = % moon_suckout_hallway_missile1;
  scripts\sp\anim::_id_17F6("decomp_missile", "fire_missile", ::_id_CD99, "decomp_intro1");
  level._id_EC85["decomp_missile"]["decomp_intro2"] = % moon_suckout_hallway_missile2;
  scripts\sp\anim::_id_17F6("decomp_missile", "fire_missile", ::_id_CD99, "decomp_intro2");
  var_1 = getweaponmodel("iw7_m4");
  level._id_EC87["armory_lmg"] = #animtree;
  level._id_EC8C["armory_lmg"] = var_1;
  level._id_EC85["armory_lmg"]["armory_xo_lmg"] = % mn_2_25_armory_xo_enter_lmg;
  level._id_EC87["armory_shotgun"] = #animtree;
  level._id_EC8C["armory_shotgun"] = "weapon_devastator_wm";
  level._id_EC85["armory_shotgun"]["armory_xo_shotgun"] = % mn_2_25_armory_xo_enter_shotgun;
  level._id_EC87["armory_emp"] = #animtree;
  level._id_EC8C["armory_emp"] = "emp_grenade_wm";
  level._id_EC85["armory_emp"]["armory_mco_emp"] = % mn_2_25_armory_mco_enter_emp;
  level._id_EC87["secure_chair"] = #animtree;
  level._id_EC8C["secure_chair"] = "cnd_office_chair_01";
  level._id_EC85["secure_chair"]["secure_room_chair"] = % moon_2_31_secure_hangar_chair;
  level._id_EC87["launch_jackal_periph"] = #animtree;
  level._id_EC8C["launch_jackal_periph"] = "veh_mil_air_un_jackal_drone_atmos_periph";
  level._id_EC85["launch_jackal_periph"]["jackal_lift_1"] = % moon_2_32_jackal_raise_1;
  level._id_EC85["launch_jackal_periph"]["jackal_lift_2"] = % moon_2_32_jackal_raise_2;
  level._id_EC85["launch_jackal_periph"]["jackal_lift_3"] = % moon_2_32_jackal_raise_3;
  level._id_EC85["launch_jackal_periph"]["jackal_lift_4"] = % moon_2_32_jackal_raise_4;
}

#using_animtree("vehicles");

_id_13267() {
  level._id_EC85["atv0"]["infil_ride"] = % moon_infil_drive_jp1;
  scripts\sp\anim::_id_17F6("atv0", "hit_ground", scripts\sp\maps\moon_port\moon_port_intro::_id_9430, "infil_ride");
  scripts\sp\anim::_id_17FC("atv0", "hit_by_corpse", "infil_jeep_hit_by_corpse", "infil_ride");
  scripts\sp\anim::_id_17FC("atv0", "hit_window", "infil_jeep_hit_window", "infil_ride");
  scripts\sp\anim::_id_17FC("atv0", "hit_airlock_ground", "infil_jeep_hit_airlock_ground", "infil_ride");
  level._id_EC85["atv1"]["infil_ride"] = % moon_infil_drive_jp2;
  scripts\sp\anim::_id_1800("atv1", "jeep_explode", "infil_ride", "vfx_moon_infil_jeep_explosion_air", "tag_origin");
  scripts\sp\anim::_id_17FC("atv1", "jeep_explode", "infil_jeep_explosion_1", "infil_ride");
  level._id_EC85["atv2"]["infil_ride"] = % moon_infil_drive_jp3;
  scripts\sp\anim::_id_17F6("atv2", "dust_kickup_on", scripts\sp\maps\moon_port\moon_port_intro::_id_9492, "infil_ride");
  scripts\sp\anim::_id_17FC("atv2", "dust_kickup_off", "atv2_stop_infil_treads", "infil_ride");
  scripts\sp\anim::_id_1800("atv2", "jeep_explode", "infil_ride", "vfx_moon_infil_jeep_explosion", "tag_origin");
  scripts\sp\anim::_id_17FC("atv2", "jeep_explode", "infil_jeep_explosion_2", "infil_ride");
  scripts\sp\anim::_id_17F6("atv2", "jeep_explode", ::_id_9454, "infil_ride");
  level._id_EC85["atv3"]["infil_ride"] = % moon_infil_drive_jp4;
  scripts\sp\anim::_id_17F6("atv3", "dust_kickup_on", scripts\sp\maps\moon_port\moon_port_intro::_id_9492, "infil_ride");
  scripts\sp\anim::_id_17FC("atv3", "dust_kickup_off", "atv3_stop_infil_treads", "infil_ride");
  level._id_EC85["ret"]["infil_ride"] = % moon_infil_drive_ret;
  level._id_EC85["tigris"]["infil_ride"] = % moon_infil_drive_tigris;
  level._id_EC85["sdf_destroyer"]["infil_ride"] = % moon_infil_drive_sdf_destroyer;
  scripts\sp\anim::_id_17FC("sdf_destroyer", "start_missile_fire", "destroyer_fire_at_ground", "infil_ride");
  level._id_EC87["ca_apc"] = #animtree;
  level._id_EC8C["ca_apc"] = "veh_mil_lnd_ca_apc_offearth_rim";
  level._id_EC85["ca_apc"]["infil_ride"] = % moon_infil_drive_ca_apc;
  scripts\sp\anim::_id_17FC("ca_apc", "attack_start", "infil_apc_enemy_attack", "infil_ride");
  scripts\sp\anim::_id_17FC("ca_apc", "hit_player_jeep", "infil_apc_hit_player_jeep", "infil_ride");
  scripts\sp\anim::_id_17FA("ca_apc", "start_flip", "infil_apc_crash_start", "infil_ride");
  level._id_EC85["atv0"]["infil_getup"][0] = % moon_infil_crash_jp1;
  level._id_EC87["decomp_forklift"] = #animtree;
  level._id_EC8C["decomp_forklift"] = "veh_ind_lnd_traditional_forklift_sml";
  level._id_EC85["decomp_forklift"]["decomp_scene"] = % moon_suckout_scene_forklift;
  scripts\sp\anim::_id_17F6("decomp_forklift", "change_light_intensity", ::_id_730F, "decomp_scene");
  level._id_EC87["decomp_capship"] = #animtree;
  level._id_EC85["decomp_capship"]["decomp_scene"] = % moon_suckout_scene_sdf_destroyer;
  level._id_EC87["decomp_cart"] = #animtree;
  level._id_EC8C["decomp_cart"] = "veh_ind_lnd_tow_cart";
  level._id_EC85["decomp_cart"]["decomp_knockback"] = % moon_suckout_knockback_cart;
  level._id_EC85["decomp_cart"]["decomp_scene"] = % moon_suckout_scene_cart;
}

#using_animtree("jackal");

_id_A056() {
  level._id_EC85["generic"]["death_roll_right"] = % jackal_death_01;
  level._id_EC85["generic"]["death_roll_left"] = % jackal_death_02;
  level._id_EC85["generic"]["death_roll_center"] = % jackal_death_04;
  level._id_EC85["jackal0"]["infil_ride"] = % moon_infil_drive_jack1;
  scripts\sp\anim::_id_17F6("jackal0", "start_fire", ::_id_A1C4, "infil_ride");
  scripts\sp\anim::_id_17FC("jackal0", "stop_fire", "stop_firing_turrets_jackal0", "infil_ride");
  level._id_EC85["jackal1"]["infil_ride"] = % moon_infil_drive_jack2;
  scripts\sp\anim::_id_17F6("jackal1", "start_fire", ::_id_A1C4, "infil_ride");
  scripts\sp\anim::_id_17FC("jackal1", "stop_fire", "stop_firing_turrets_jackal1", "infil_ride");
  level._id_EC85["jackal2"]["infil_ride"] = % moon_infil_drive_jack3;
  scripts\sp\anim::_id_17F6("jackal2", "start_fire", ::_id_A1C4, "infil_ride");
  scripts\sp\anim::_id_17FC("jackal2", "stop_fire", "stop_firing_turrets_jackal2", "infil_ride");
  level._id_EC85["jackal3"]["infil_ride"] = % moon_infil_drive_jack4;
  scripts\sp\anim::_id_17F6("jackal3", "start_fire", ::_id_A1C4, "infil_ride");
  scripts\sp\anim::_id_17FC("jackal3", "stop_fire", "stop_firing_turrets_jackal3", "infil_ride");
  level._id_EC85["jackal4"]["infil_ride"] = % moon_infil_drive_jack5;
  scripts\sp\anim::_id_17F6("jackal4", "start_fire", ::_id_A1C4, "infil_ride");
  scripts\sp\anim::_id_17FC("jackal4", "stop_fire", "stop_firing_turrets_jackal4", "infil_ride");
  level._id_EC85["jackal5"]["infil_ride"] = % moon_infil_drive_jack6;
  scripts\sp\anim::_id_17F6("jackal5", "start_fire", ::_id_A1C4, "infil_ride");
  scripts\sp\anim::_id_17FC("jackal5", "stop_fire", "stop_firing_turrets_jackal5", "infil_ride");
  level._id_EC87["decomp_jackal"] = #animtree;
  level._id_EC85["decomp_jackal"]["decomp_intro"] = % moon_suckout_hallway_jackal;
  scripts\sp\anim::_id_17FC("decomp_jackal", "fire_on", "start_jackal_fire", "decomp_intro");
  scripts\sp\anim::_id_17FC("decomp_jackal", "fire_off", "stop_jackal_fire", "decomp_intro");
  scripts\sp\anim::_id_17FC("decomp_jackal", "fire_jack_missile", "fire_jack_missile", "decomp_intro");
  scripts\sp\anim::_id_17FC("decomp_jackal", "glass_break", "glass_break", "decomp_intro");
  level._id_EC85["decomp_jackal"]["decomp_knockback"] = % moon_suckout_knockback_jackal;
  level._id_EC85["decomp_jackal"]["decomp_scene"] = % moon_suckout_scene_jackal;
  level._id_EC85["decomp_jackal"]["harass"] = % moon_suckout_run_jackal;
  scripts\sp\anim::_id_17FA("decomp_jackal", "break_pillar_1", "break_pillar_1", "harass");
  scripts\sp\anim::_id_17FA("decomp_jackal", "break_pillar_2", "break_pillar_2", "harass");
  scripts\sp\anim::_id_17FA("decomp_jackal", "break_pillar_3", "break_pillar_3", "harass");
  level._id_EC87["skelter"] = #animtree;
  level._id_EC8C["skelter"] = "veh_mil_air_ca_jackal_01";
  level._id_EC85["skelter"]["moon_window_tutorial_jackal"] = % moon_window_tutorial_jackal;
  level._id_EC85["skelter"]["flyby_1_enter"] = % moon_jackal_flyby_1_enter;
  level._id_EC85["skelter"]["flyby_1_idle"][0] = % moon_jackal_flyby_1_idle;
  level._id_EC85["skelter"]["flyby_1_exit"] = % moon_jackal_flyby_1_exit;
  level._id_EC85["skelter"]["flyby_2_enter"] = % moon_jackal_flyby_2_enter;
  level._id_EC85["skelter"]["flyby_2_idle"][0] = % moon_jackal_flyby_2_idle;
  level._id_EC85["skelter"]["flyby_2_exit"] = % moon_jackal_flyby_2_exit;
  level._id_EC87["launch_jackal"] = #animtree;
  level._id_EC85["launch_jackal"]["jackal_lift_1"] = % moon_2_32_jackal_raise_1;
  level._id_EC85["launch_jackal"]["jackal_lift_2"] = % moon_2_32_jackal_raise_2;
  level._id_EC85["launch_jackal"]["jackal_lift_3"] = % moon_2_32_jackal_raise_3;
  level._id_EC85["launch_jackal"]["jackal_lift_4"] = % moon_2_32_jackal_raise_4;
  level._id_EC85["launch_jackal"]["jackal_lift_1_idle"][0] = % moon_2_32_jackal_raise_1_idle;
  level._id_EC85["launch_jackal"]["jackal_lift_2_idle"][0] = % moon_2_32_jackal_raise_2_idle;
  level._id_EC85["launch_jackal"]["jackal_lift_3_idle"][0] = % moon_2_32_jackal_raise_3_idle;
  level._id_EC85["launch_jackal"]["jackal_lift_4_idle"][0] = % moon_2_32_jackal_raise_4_idle;
}

_id_A1C4(var_0) {
  var_0 endon("death");
  level endon("stop_firing_turrets_" + var_0._id_1FBB);

  for(;;) {
    if(isDefined(level._id_9463))
      var_0 _id_0C1B::_id_6D30(level._id_9463);

    wait 0.1;
  }
}

_id_A1BF(var_0) {
  var_0 _id_0B76::_id_1992("tag_flash", level._id_9463, 1, undefined, 200);
}

_id_9AC0() {
  var_0 = getdvarint("jeep_crash_anim", 1);
  var_1 = "a";

  if(var_0 == 2)
    var_1 = "b";

  level thread _id_9AC2(var_1);
  level.allies["marineCO"] thread _id_9AC1(var_1);
  level.allies["salter"] thread _id_9AC3(var_1);
}

_id_9454(var_0) {
  var_1 = getEntArray("explosion_infil_02", "targetname");

  foreach(var_3 in var_1)
  var_3 setlightintensity(var_3._id_C3C2);
}

_id_9AC2(var_0) {
  var_1 = scripts\sp\utility::_id_10639("player_rig");
  level.player scripts\sp\anim::_id_1EC3(var_1, "infil_jeep_crash_" + var_0);
  level.player _meth_823C(var_1, "tag_player", 0.5, 0.5, 0);
  wait 0.5;
  level.player playerlinktodelta(var_1, "tag_player", 1, 0, 0, 0, 0, 1);
  var_1 show();
  level.player scripts\sp\anim::_id_1F35(var_1, "infil_jeep_crash_" + var_0);
  level.player unlink();
  var_1 delete();
  level.player enableweapons();
  level.player setstance("stand");
  level.player scripts\engine\utility::allow_jump(1);
  level.player scripts\engine\utility::allow_crouch(1);
  level.player scripts\engine\utility::allow_prone(1);
  level.player scripts\engine\utility::allow_doublejump(1);
}

_id_9AC1(var_0) {
  level.allies["marineCO"] thread scripts\sp\anim::_id_1F35(level.allies["marineCO"], "infil_jeep_crash_" + var_0);
}

_id_9AC3(var_0) {
  level.allies["salter"] thread scripts\sp\anim::_id_1F35(level.allies["salter"], "infil_jeep_crash_" + var_0);
}

_id_71F0() {
  scripts\engine\utility::flag_wait("fob_guards_spawned");
  wait 0.2;
  var_0 = scripts\sp\utility::_id_77DA("fob_guard_anim_wounded_1");
  level._id_720B = var_0[0];
  level._id_720B._id_1FBB = "generic";
  var_1 = getEnt("fob_wounded_1", "targetname");
  var_1 thread scripts\sp\anim::_id_1EEA(level._id_720B, "wounded_loop_01", "stop_loop");
}

_id_71F1() {
  scripts\engine\utility::flag_wait("fob_guards_spawned");
  wait 0.2;
  var_0 = scripts\sp\utility::_id_77DA("fob_guard_anim_wounded_2");
  level._id_720C = var_0[0];
  level._id_720C._id_1FBB = "generic";
  var_1 = getEnt("fob_wounded_2", "targetname");
  var_1 thread scripts\sp\anim::_id_1EEA(level._id_720C, "wounded_loop_02", "stop_loop");
}

_id_71EE() {
  var_0 = getEnt("fob_help_1_a_hit", "targetname");
  var_1 = getEnt("fob_help_1_a", "targetname");
  var_2 = getEnt("fob_help_1_b", "targetname");
  scripts\engine\utility::flag_wait("fob_guards_spawned");
  wait 0.2;
  var_3 = scripts\sp\utility::_id_77DA("fob_guard_anim_1_a");
  level._id_71F4 = var_3[0];
  var_3 = scripts\sp\utility::_id_77DA("fob_guard_anim_1_b");
  level._id_71F5 = var_3[0];
  level._id_71F4._id_1FBB = "generic";
  level._id_71F5._id_1FBB = "generic";

  while(scripts\sp\utility::_id_77DB("fob_cafe_enemies") + scripts\sp\utility::_id_77DB("fob_cafe_enemy_bots") > 4)
    wait 0.1;

  var_0 scripts\sp\anim::_id_1F35(level._id_71F4, "FoB_help_1_A_hit");
  var_0 thread scripts\sp\anim::_id_1EEA(level._id_71F4, "FoB_help_1_A_hit_idle", "stop_loop");
  scripts\engine\utility::flag_wait("fob_halls_cafe_enemies_clear");
  wait 0.8;
  var_2 scripts\sp\anim::_id_1F17(level._id_71F5, "FoB_help_1_B_rescue");
  var_0 notify("stop_loop");
  var_1 thread scripts\sp\anim::_id_1F35(level._id_71F4, "FoB_help_1_A_rescue");
  var_2 scripts\sp\anim::_id_1F35(level._id_71F5, "FoB_help_1_B_rescue");
  var_1 thread scripts\sp\anim::_id_1EEA(level._id_71F4, "FoB_help_1_A_rescue_idle", "stop_loop");
  var_2 thread scripts\sp\anim::_id_1EEA(level._id_71F5, "FoB_help_1_B_rescue_idle", "stop_loop");
}

_id_71EF() {
  var_0 = getEnt("fob_help_2_a", "targetname");
  var_1 = getEnt("fob_help_2_b", "targetname");
  scripts\engine\utility::flag_wait("fob_guards_spawned");
  wait 0.2;
  var_2 = scripts\sp\utility::_id_77DA("fob_guard_anim_2_a");
  level._id_71F6 = var_2[0];
  var_2 = scripts\sp\utility::_id_77DA("fob_guard_anim_2_b");
  level._id_71F7 = var_2[0];
  level._id_71F6._id_1FBB = "generic";
  level._id_71F7._id_1FBB = "generic";
  scripts\engine\utility::flag_wait("fob_halls_cafe_enemies_clear");
  var_0 thread scripts\sp\anim::_id_1F35(level._id_71F6, "FoB_help_2_A_getup");
  var_1 scripts\sp\anim::_id_1F35(level._id_71F7, "FoB_help_2_B_getup");
  var_0 thread scripts\sp\anim::_id_1EEA(level._id_71F6, "FoB_help_2_A_getup_idle", "stop_loop");
  var_1 thread scripts\sp\anim::_id_1EEA(level._id_71F7, "FoB_help_2_B_getup_idle", "stop_loop");
}

_id_7205() {
  var_0 = getEnt("fob_typer_1", "targetname");
  var_1 = getEnt("fob_typer_1_node", "targetname");
  level._id_7205 = var_0 scripts\sp\utility::_id_10619(1, 1);
  wait 0.1;
  level._id_7205._id_1FBB = "generic";
  var_1 scripts\sp\anim::_id_1EEA(level._id_7205, "control_panel_3_loop", "stop_loop");
}

_id_7206() {
  var_0 = getEnt("fob_typer_2", "targetname");
  var_1 = getEnt("fob_typer_2_node", "targetname");
  level._id_7206 = var_0 scripts\sp\utility::_id_10619(1, 1);
  wait 0.1;
  level._id_7206._id_1FBB = "generic";
  var_1 scripts\sp\anim::_id_1EEA(level._id_7206, "control_panel_3_loop", "stop_loop");
}

_id_71FE() {
  var_0 = getEnt("fob_redshirt_1", "targetname");
  var_1 = scripts\engine\utility::getStruct("moon_fob_animnode", "targetname");
  level._id_71FC = var_0 scripts\sp\utility::_id_10619(1, 1);
  wait 0.1;
  level._id_71FC._id_1FBB = "fob_redshirt1";
  var_1 thread scripts\sp\anim::_id_1EEA(level._id_71FC, "fob_redshirt_idle1", "stop_loop");
  scripts\engine\utility::flag_wait("flag_mco_at_fob_start");
  var_1 notify("stop_loop");
  var_1 scripts\sp\anim::_id_1F35(level._id_71FC, "fob_scene_unlock");
}

_id_71FF() {
  var_0 = getEnt("fob_redshirt_2", "targetname");
  var_1 = scripts\engine\utility::getStruct("moon_fob_animnode", "targetname");
  level._id_71FD = var_0 scripts\sp\utility::_id_10619(1, 1);
  wait 0.1;
  level._id_71FD._id_1FBB = "fob_redshirt2";
  var_1 thread scripts\sp\anim::_id_1EEA(level._id_71FD, "fob_redshirt_idle2", "stop_loop");
  scripts\engine\utility::flag_wait("flag_mco_at_fob_start");
  var_1 notify("stop_loop");
  var_1 scripts\sp\anim::_id_1F35(level._id_71FD, "fob_scene_unlock");
}

_id_7201(var_0) {
  var_1 = scripts\engine\utility::getStruct("moon_fob_animnode", "targetname");
  var_1 scripts\sp\anim::_id_1F17(var_0, "fob_scene_unlock");
  scripts\engine\utility::flag_set("flag_mco_at_fob_start");
  var_1 thread scripts\sp\anim::_id_1F35(var_0, "fob_scene_unlock");
}

_id_730F(var_0) {
  var_1 = getEntArray("explosion_harass_01", "targetname");

  foreach(var_3 in var_1)
  var_3 setlightintensity(10000);

  level waittill("explo_lights_off");

  foreach(var_3 in var_1)
  var_3 setlightintensity(0);
}

_id_4685(var_0) {
  playFXOnTag(level._effect["vfx_mr_hard_landing_allies"], var_0, "tag_origin");
}

_id_CD99(var_0) {
  playFXOnTag(level._effect["missile_flare_generic"], var_0, "tag_origin");
}

_id_C0C7(var_0) {
  if(isDefined(var_0._id_B14F))
    var_0 scripts\sp\utility::_id_1101B();

  if(!isDefined(var_0._id_EE5F) || !var_0._id_EE5F)
    var_0.forceragdollimmediate = 1;

  var_0 scripts\sp\utility::_id_F2A8(1);
  var_0._id_10265 = 1;
  var_0._id_4E46 = _id_0C60::_id_58CB;
  var_0 scripts\sp\utility::_id_54C6();
}

_id_F2E2(var_0) {
  wait 1;
  scripts\engine\utility::flag_set("player_removed_harass_helmet");
}

_id_479E(var_0) {
  if(scripts\sp\utility::_id_93A6()) {
    if(!scripts\sp\specialist_MAYBE::_id_2C95()) {
      return;
    }
    level.player.helmet = level._id_10964.helmet;
  }

  thread _id_CFE9();
  thread scripts\sp\hud::_id_8DF9("suit", 1);
  wait 0.3;
  level.player.helmet attach("vm_hero_protagonist_helmet_glass_crack_01", "tag_origin");
  setomnvar("ui_helmet_meter_forceVisible", 1);
  thread _id_CFEA();
  thread scripts\sp\hud::_id_8DFB("oxygen", 50, 1);
  wait 2.5;
  thread _id_CFE9();
  wait 2;
  thread _id_CFE9();
  wait 3.5;
  thread _id_CFE9();
  wait 0.3;
  level.player.helmet detach("vm_hero_protagonist_helmet_glass_crack_01", "tag_origin");
  level.player.helmet attach("vm_hero_protagonist_helmet_glass_crack_02", "tag_origin");
  wait 7;
  thread _id_CFE9();
  wait 5;
  thread _id_CFE9();
  wait 4;
  thread _id_CFE9();
  wait 3;
  thread _id_CFE9();
  scripts\engine\utility::flag_wait("harass_end_chase");
  wait 2;
  thread _id_CFE9();
  wait 0.3;
  level.player.helmet detach("vm_hero_protagonist_helmet_glass_crack_02", "tag_origin");
  level.player.helmet attach("vm_hero_protagonist_helmet_glass_crack_03", "tag_origin");
  level.player playSound("scn_moon_suck_helmet_glass_worsen_02");
}

_id_8E0C(var_0) {
  wait 1;
  _id_0E4B::helmethud_off();

  if(isDefined(level.player._id_8DDB))
    level.player._id_8DDB show();
}

_id_CFEA() {
  var_0 = spawn("script_model", (0, 0, 0));
  var_0 setModel("tag_origin");
  var_0 _meth_81E2(level.player, "tag_origin", (0, 0, 0), (0, 0, 0), 1);
  playFXOnTag(level._effect["vfx_cracked_mask_air"], var_0, "tag_origin");
  scripts\engine\utility::flag_wait("hangar_player_used_airlock");
  killfxontag(level._effect["vfx_cracked_mask_air"], var_0, "tag_origin");
}

_id_CFE9() {
  var_0 = randomfloatrange(0.5, 0.8);
  var_1 = scripts\sp\hud_util::_id_48B7("black", 0, level.player);
  var_2 = randomfloatrange(0.2, 0.4);
  var_1 fadeovertime(var_2);
  var_1.alpha = randomfloatrange(0.9, 1.0);
  wait(var_0);
  var_2 = randomfloatrange(0.4, 0.7);
  var_1 fadeovertime(var_2);
  var_1.alpha = 0.0;
  wait(var_2);
  var_1 destroy();
}

_id_1018B(var_0) {
  level.player notify("shutter_alerted");
}

_id_4F8B(var_0) {}

#using_animtree("generic_human");

_id_7747() {
  level._id_EC85["generic"]["moon_2_4_bodies_corpse_row_m1"][0] = % moon_2_4_bodies_corpse_row_m1;
  level._id_EC85["generic"]["moon_2_4_bodies_corpse_row_f1"][0] = % moon_2_4_bodies_corpse_row_f1;
  level._id_EC85["generic"]["moon_2_4_bodies_corpse_row_m2"][0] = % moon_2_4_bodies_corpse_row_m2;
  level._id_EC85["generic"]["moon_2_4_bodies_corpse_row_m3"][0] = % moon_2_4_bodies_corpse_row_m3;
  level._id_EC85["generic"]["moon_2_4_bodies_corpse_row_f2"][0] = % moon_2_4_bodies_corpse_row_f2;
  level._id_EC85["generic"]["moon_2_4_bodies_corpse_row_m4"][0] = % moon_2_4_bodies_corpse_row_m4;
  level._id_EC85["generic"]["moon_2_4_bodies_pile_m1"][0] = % moon_2_4_bodies_pile_m1;
  level._id_EC85["generic"]["moon_2_4_bodies_pile_m2"][0] = % moon_2_4_bodies_pile_m2;
  level._id_EC85["generic"]["moon_2_4_bodies_pile_m3"][0] = % moon_2_4_bodies_pile_m3;
  level._id_EC85["generic"]["moon_2_4_bodies_lean1_m1"][0] = % moon_2_4_bodies_lean1_m1;
  level._id_EC85["generic"]["moon_2_4_bodies_lean1_f1"][0] = % moon_2_4_bodies_lean1_f1;
  level._id_EC85["generic"]["moon_2_4_bodies_lean2_m1"][0] = % moon_2_4_bodies_lean2_m1;
  level._id_EC85["generic"]["moon_2_4_bodies_lean2_f1"][0] = % moon_2_4_bodies_lean2_f1;
  level._id_EC85["generic"]["moon_2_4_bodies_lean3_m1"][0] = % moon_2_4_bodies_lean3_m1;
  level._id_EC85["generic"]["moon_2_4_bodies_lean3_m2"][0] = % moon_2_4_bodies_lean3_m2;
  level._id_EC85["generic"]["moon_2_4_bodies_lean3_f1"][0] = % moon_2_4_bodies_lean3_f1;
  level._id_EC85["generic"]["generic_dead_wall_lean_civ_01"][0] = % generic_dead_wall_lean_civ_01;
  level._id_EC85["generic"]["generic_dead_wall_lean_civ_02"][0] = % generic_dead_wall_lean_civ_02;
  level._id_EC85["generic"]["generic_dead_wall_lean_civ_03"][0] = % generic_dead_wall_lean_civ_03;
  level._id_EC85["generic"]["generic_dead_civ_01"][0] = % generic_dead_civ_01;
  level._id_EC85["generic"]["generic_dead_civ_02"][0] = % generic_dead_civ_02;
  level._id_EC85["generic"]["generic_dead_civ_03"][0] = % generic_dead_civ_03;
  level._id_EC85["generic"]["generic_dead_civ_04"][0] = % generic_dead_civ_04;
  level._id_EC85["generic"]["generic_dead_civ_05"][0] = % generic_dead_civ_05;
  level._id_EC85["generic"]["generic_dead_civ_06"][0] = % generic_dead_civ_06;
  level._id_EC85["generic"]["generic_dead_civ_07"][0] = % generic_dead_civ_07;
  level._id_EC85["generic"]["generic_dead_civ_fem_01"][0] = % generic_dead_civ_fem_01;
  level._id_EC85["generic"]["generic_dead_civ_fem_02"][0] = % generic_dead_civ_fem_02;
  level._id_EC85["generic"]["generic_dead_civ_fem_03"][0] = % generic_dead_civ_fem_03;
  level._id_EC85["generic"]["generic_dead_civ_fem_04"][0] = % generic_dead_civ_fem_04;
  level._id_EC85["generic"]["generic_dead_civ_fem_05"][0] = % generic_dead_civ_fem_05;
  level._id_EC85["generic"]["generic_dead_civ_fem_06"][0] = % generic_dead_civ_fem_06;
  level._id_EC85["generic"]["generic_dead_civ_fem_07"][0] = % generic_dead_civ_fem_07;
}

_id_42E5() {
  level._id_EC85["cg_door_opener"]["moon_coastguard_door"] = % moon_coastguard_door;
  scripts\sp\anim::_id_17FC("cg_door_opener", "door_open", "cg_door_open", "moon_coastguard_door");
  level._id_EC85["cg_stairs_waver"]["moon_coastguard_stairs"] = % moon_coastguard_stairs_wave_guard;
  scripts\sp\anim::_id_17FC("cg_stairs_waver", "get_cg_attention", "get_cg_attention", "moon_coastguard_stairs");
  level._id_EC85["cg_stairs_guy_0"]["moon_coastguard_idle"][0] = % moon_coastguard_idle_guard1;
  level._id_EC85["cg_stairs_guy_0"]["moon_coastguard_getup"] = % moon_coastguard_getup_guard1;
  level._id_EC85["cg_stairs_guy_1"]["moon_coastguard_idle"][0] = % moon_coastguard_idle_guard2;
  level._id_EC85["cg_stairs_guy_1"]["moon_coastguard_getup"] = % moon_coastguard_getup_guard2;
  level._id_EC85["cg_fireman_0"]["moon_fireman_idle"][0] = % moon_coastguard_firemancarry_idle_guard1;
  level._id_EC85["cg_fireman_0"]["moon_fireman_guard"] = % moon_coastguard_firemancarry_guard1;
  level._id_EC85["cg_fireman_1"]["moon_fireman_idle"][0] = % moon_coastguard_firemancarry_idle_guard2;
  level._id_EC85["cg_fireman_1"]["moon_fireman_guard"] = % moon_coastguard_firemancarry_guard2;
  level._id_EC85["generic"]["shipcribmoon_elevator_injured_loop_01"][0] = % shipcribmoon_elevator_injured_loop_01;
  level._id_EC85["generic"]["shipcribmoon_elevator_injured_loop_02"][0] = % shipcribmoon_elevator_injured_loop_02;
  level._id_EC85["generic"]["shipcribmoon_elevator_injured_loop_03"][0] = % shipcribmoon_elevator_injured_loop_03;
  level._id_EC85["generic"]["shipcribmoon_elevator_injured_loop_04"][0] = % shipcribmoon_elevator_injured_loop_04;
  level._id_EC85["generic"]["shipcribmoon_elevator_injured_loop_05"][0] = % shipcribmoon_elevator_injured_loop_05;
  level._id_EC85["generic"]["shipcrib_moon_coughing"][0] = % shipcrib_moon_coughing;
  level._id_EC85["generic"]["shipcrib_moon_wall_wounded01"][0] = % shipcrib_moon_wall_wounded01;
  level._id_EC85["generic"]["shipcrib_moon_wall_wounded02"][0] = % shipcrib_moon_wall_wounded02;
  level._id_EC85["generic"]["shipcrib_moon_wall_wounded04"][0] = % shipcrib_moon_wall_wounded04;
  level._id_EC85["generic"]["shipcrib_prisoner_wounded_guyA_set01_idle_01"][0] = % shipcrib_prisoner_wounded_guya_set01_idle_01;
  level._id_EC85["generic"]["shipcrib_prisoner_wounded_guyB_set01_idle_01"][0] = % shipcrib_prisoner_wounded_guyb_set01_idle_01;
  level._id_EC85["generic"]["shipcrib_prisoner_wounded_guyA_set01_idle_02"][0] = % shipcrib_prisoner_wounded_guya_set01_idle_02;
  level._id_EC85["generic"]["shipcrib_prisoner_wounded_guyB_set01_idle_02"][0] = % shipcrib_prisoner_wounded_guyb_set01_idle_02;
  level._id_EC85["generic"]["shipcrib_prisoner_wounded_guyA_set02_idle_01"][0] = % shipcrib_prisoner_wounded_guya_set02_idle_01;
  level._id_EC85["generic"]["shipcrib_prisoner_wounded_guyB_set02_idle_01"][0] = % shipcrib_prisoner_wounded_guyb_set02_idle_01;
  level._id_EC85["generic"]["shipcrib_prisoner_wounded_guyA_set02_idle_02"][0] = % shipcrib_prisoner_wounded_guya_set02_idle_02;
  level._id_EC85["generic"]["shipcrib_prisoner_wounded_guyB_set02_idle_02"][0] = % shipcrib_prisoner_wounded_guyb_set02_idle_02;
  level._id_EC85["generic"]["shipcrib_prisoner_wounded_guyA_set03_idle_01"][0] = % shipcrib_prisoner_wounded_guya_set03_idle_01;
  level._id_EC85["generic"]["shipcrib_prisoner_wounded_guyB_set03_idle_01"][0] = % shipcrib_prisoner_wounded_guyb_set03_idle_01;
  level._id_EC85["generic"]["shipcrib_prisoner_wounded_guyA_set02_idle_02_civ"][0] = % shipcrib_prisoner_wounded_guya_set02_idle_02_civ;
  level._id_EC85["generic"]["shipcrib_prisoner_wounded_guyB_set03_idle_02"][0] = % shipcrib_prisoner_wounded_guyb_set03_idle_02;
  level._id_EC85["generic"]["shipcrib_moon_injured_grnd_01_idle_injured_B_civ"][0] = % shipcrib_moon_injured_grnd_01_idle_injured_b_civ;
  level._id_EC85["generic"]["shipcrib_moon_injured_drag01_guyC_idle_01"][0] = % shipcrib_moon_injured_drag01_guyc_idle_01;
  level._id_EC85["generic"]["shipcrib_moon_injured_drag01_guyB_idle_02"][0] = % shipcrib_moon_injured_drag01_guyb_idle_02;
  level._id_EC85["generic"]["shipcrib_moon_injured_drag01_guyC_idle_02"][0] = % shipcrib_moon_injured_drag01_guyc_idle_02;
  level._id_EC85["generic"]["shipcrib_moon_injured_drag02_guyB_idle_01"][0] = % shipcrib_moon_injured_drag02_guyb_idle_01;
  level._id_EC85["generic"]["shipcrib_moon_injured_drag02_guyC_idle_01"][0] = % shipcrib_moon_injured_drag02_guyc_idle_01;
  level._id_EC85["generic"]["shipcrib_moon_injured_drag02_guyB_idle_02"][0] = % shipcrib_moon_injured_drag02_guyb_idle_02;
  level._id_EC85["generic"]["shipcrib_moon_injured_grnd_01_idle_injured_A_civ"][0] = % shipcrib_moon_injured_grnd_01_idle_injured_a_civ;
  level._id_EC85["generic"]["shipcrib_moon_injured_drag03_guyB_idle_01"][0] = % shipcrib_moon_injured_drag03_guyb_idle_01;
  level._id_EC85["generic"]["shipcrib_moon_injured_drag03_guyC_idle_01"][0] = % shipcrib_moon_injured_drag03_guyc_idle_01;
  level._id_EC85["generic"]["Moon_coastguard_sad_civ_f"][0] = % moon_coastguard_sad_civ_f;
  level._id_EC85["generic"]["Moon_coastguard_sad_civ_m"][0] = % moon_coastguard_sad_civ_m;
  level._id_EC85["generic"]["shipcrib_moon_injured_drag01_guyB_idle_01"][0] = % shipcrib_moon_injured_drag01_guyb_idle_01;
  level._id_EC85["generic"]["shipcrib_moon_injured_drag02_guyC_idle_02"][0] = % shipcrib_moon_injured_drag02_guyc_idle_02;
  level._id_EC85["tv_watcher"]["shipcrib_stand_stationary_talk_idle_01"][0] = % shipcrib_stand_stationary_talk_idle_01;
  level._id_EC85["tv_watcher"]["shipcrib_stand_stationary_talk_idle_02"][0] = % shipcrib_stand_stationary_talk_idle_02;
  level._id_EC85["tv_watcher"]["shipcrib_stand_stationary_talk_idle_03"][0] = % shipcrib_stand_stationary_talk_idle_03;
  level._id_EC85["tv_watcher"]["shipcrib_stand_stationary_talk_idle_04"][0] = % shipcrib_stand_stationary_talk_idle_04;
}