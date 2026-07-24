/************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\maps\heist\heist_anim.gsc
************************************************/

main() {
  _id_91DC();
  _id_3353();
  _id_3508();
  player();
  _id_13267();
  _id_A056();
  _id_EE25();
}

#using_animtree("generic_human");

_id_91DC() {
  level._id_EC85["generic"]["exposed_flashbang_v1"] = % exposed_flashbang_v1;
  level._id_EC85["generic"]["exposed_flashbang_v3"] = % exposed_flashbang_v3;
  level._id_EC85["generic"]["exposed_flashbang_v4"] = % exposed_flashbang_v4;
  level._id_EC85["generic"]["exposed_flashbang_v5"] = % exposed_flashbang_v5;
  level._id_EC85["generic"]["rcs_wall_run"] = % heist_steeldragon_xo_wallrun;
  level._id_EC85["generic"]["emp_crouch_pain_01"] = % emp_crouch_pain_01;
  level._id_EC85["hvt"]["churchfall_door_open"] = % pnr_churchfall_hvt_door_open;
  level._id_EC85["hvt"]["churchfall_fall_a"] = % pnr_churchfall_hvt_fall_a;
  level._id_EC85["hvt"]["churchfall_fall_b"] = % pnr_churchfall_hvt_fall_b;
  level._id_EC85["hvt"]["churchfall_grab_all"] = % pnr_churchfall_hvt_grab_all;
  level._id_EC85["hvt"]["churchfall_death_a"] = % pnr_churchfall_hvt_death_a_hvt;
  level._id_EC85["hvt"]["churchfall_death_b"] = % pnr_churchfall_hvt_death_b_hvt;
  scripts\sp\anim::_id_17FC("hvt", "vo_prisoner_ria_thisistheend", "vo_prisoner_ria_thisistheend");
  scripts\sp\anim::_id_17FC("hvt", "stab_self", "churchfall_stab_self", "churchfall_death_a");
  scripts\sp\anim::_id_17FC("hvt", "stab_transponder", "churchfall_stab_transponder", "churchfall_death_b");
  scripts\sp\anim::_id_17FC("hvt", "punch_heist_start", "punch_heist_start", "churchfall_door_open");
  scripts\sp\anim::_id_17FC("hvt", "boom_tower", "churchfall_boom_tower", "churchfall_door_open");
  scripts\sp\anim::_id_17FC("hvt", "dof_intro_hand", "dof_intro_hand", "churchfall_door_open");
  scripts\sp\anim::_id_17FC("hvt", "dof_intro_det", "dof_intro_det", "churchfall_door_open");
  scripts\sp\anim::_id_17FC("hvt", "dof_knife_start", "dof_knife_start", "churchfall_death_a");
  scripts\sp\anim::_id_17FC("hvt", "dof_knees_start", "dof_knees_start", "churchfall_death_a");
  scripts\sp\anim::_id_17FC("hvt", "stab_transponder", "dof_stab_transponder", "churchfall_death_b");
  scripts\sp\anim::_id_17FC("hvt", "mayhem_start", "hvt_mayhem_start", "churchfall_death_a");
  scripts\sp\anim::_id_17FC("hvt", "mayhem_end", "hvt_mayhem_end", "churchfall_death_a");
  scripts\sp\anim::_id_17FC("hvt", "mayhem_start", "hvt_mayhem_start", "churchfall_death_b");
  scripts\sp\anim::_id_17FC("hvt", "mayhem_end", "hvt_mayhem_end", "churchfall_death_b");
  level._id_EC85["ethan"]["elevator_panel"] = % moon_coastguard_door;
  level._id_EC85["ethan"]["elevator_open_approach"] = % hm_grnd_yel_casual_stand_arrival_l_ar_8;
  level._id_EC85["ethan"]["elevator_open_idle"][0] = % hm_grnd_yel_casual_idle_ar;
  level._id_EC85["ethan"]["elevator_open"] = % hei_9_10_elev_c6i_arrive;
  level._id_EC85["ethan"]["elevator"] = % hei_9_10_elev_c6i;
  level._id_EC85["salter"]["elevator"] = % hei_9_10_elev_xo;
  level._id_EC85["brooks"]["elevator"] = % hei_9_10_elev_mr1;
  level._id_EC85["kashima"]["elevator"] = % hei_9_10_elev_mr2;
  level._id_EC85["ethan"]["elevator_idle"][0] = % hei_9_10_elev_c6i_idle;
  level._id_EC85["salter"]["elevator_idle"][0] = % hei_9_10_elev_xo_idle;
  level._id_EC85["brooks"]["elevator_idle"][0] = % hei_9_10_elev_mr1_idle;
  level._id_EC85["kashima"]["elevator_idle"][0] = % hei_9_10_elev_mr2_idle;
  level._id_EC85["brooks"]["elevator_nag"] = % hei_9_10_elev_mr1_nag;
  level._id_EC85["salter"]["elevator_nag"] = % hei_9_10_elev_xo_nag;
  scripts\sp\anim::_id_17FC("salter", "shake", "shake", "elevator");
  scripts\sp\anim::_id_17FC("salter", "bank_left", "bank_left", "elevator");
  scripts\sp\anim::_id_17FC("salter", "bank_right", "bank_right", "elevator");
  level._id_EC85["kashima"]["kash_slide"] = % heist_mons_slide_fall_mr2;
  level._id_EC85["kashima"]["kash_hang"] = % heist_mons_slide_hang_mr2;
  level._id_EC85["kashima"]["mons_run"] = % heist_mons_slide_run_mr2;
  level._id_EC85["salter"]["mons_run"] = % heist_mons_slide_run_xo;
  level._id_EC85["brooks"]["mons_run"] = % heist_mons_slide_run_mr1;
  level._id_EC85["ethan"]["mons_run"] = % heist_mons_slide_run_eth;
  level._id_EC85["kashima"]["mons_dropoff"] = % heist_mons_attack_kash;
  level._id_EC85["salter"]["mons_dropoff"] = % heist_mons_attack_xo;
  level._id_EC85["brooks"]["mons_dropoff"] = % heist_mons_attack_brooks;
  level._id_EC85["ethan"]["mons_dropoff"] = % heist_mons_attack_c6i;
  scripts\sp\anim::_id_17F6("salter", "show_shield", ::_id_FC92, "mons_dropoff");
  scripts\sp\anim::_id_17F6("salter", "hide_shield", ::_id_FC75, "mons_dropoff");
  level._id_EC85["ethan"]["prebreach_idle"][0] = % heist_mons_breach_idle_eth3n;
  level._id_EC85["salter"]["prebreach_idle"][0] = % heist_mons_breach_idle_xo;
  level._id_EC85["brooks"]["prebreach_idle"][0] = % heist_mons_breach_idle_mr1;
  level._id_EC85["kashima"]["prebreach_idle"][0] = % heist_mons_breach_idle_mr2;
  level._id_EC85["salter"]["plant_breach"] = % heist_mons_breach_react_xo;
  level._id_EC85["brooks"]["plant_breach"] = % heist_mons_breach_react_mr1;
  level._id_EC85["ethan"]["breach_entry"] = % heist_mons_breach_scene_eth3n;
  level._id_EC85["salter"]["breach_entry"] = % heist_mons_breach_scene_xo;
  level._id_EC85["brooks"]["breach_entry"] = % heist_mons_breach_scene_mr1;
  level._id_EC85["kashima"]["breach_entry"] = % heist_mons_breach_scene_mr2;
  level._id_EC85["ethan"]["postbreach_idle"][0] = % heist_mons_breach_idle_2_eth3n;
  level._id_EC85["salter"]["postbreach_idle"][0] = % heist_mons_breach_idle_2_xo;
  level._id_EC85["brooks"]["postbreach_idle"][0] = % heist_mons_breach_idle_2_mr1;
  level._id_EC85["kashima"]["postbreach_idle"][0] = % heist_mons_breach_idle_2_mr2;
  level._id_EC85["generic"]["deck_runner_slide"] = % moon_shield_slide_xo;
  level._id_EC85["generic"]["explode_b_01"] = % death_explosion_stand_b_v2;
  level._id_EC88["brooks"]["heist_brk_weremadeifwebre"] = % heist_brk_weremadeifwebre_face;
  level._id_EC88["salter"]["heist_slt_helmsgotmechsan"] = % heist_slt_helmsgotmechsan_face;
  level._id_EC88["brooks"]["heist_brk_setdefhackedthe"] = % heist_brk_setdefhackedthe_face;
  level._id_EC88["salter"]["heist_slt_sergeantsrightr"] = % heist_slt_sergeantsrightr_face;
  level._id_EC88["salter"]["heist_slt_takeitraider"] = % heist_slt_takeitraider_face;
  level._id_EC88["salter"]["heist_slt_plantyourcharge"] = % heist_slt_plantyourcharge_face;
  level._id_EC88["salter"]["heist_slt_copygetinthere"] = % heist_slt_copygetinthere_face;
  level._id_EC85["bridge_guy_main"]["roundhouse_punch_idle"][0] = % titan_stealth_street_sdf_radio_idle;
  level._id_EC85["bridge_guy_main"]["opsmap_slam_idle"][0] = % shipcrib_bridge_opsmap_officer_idle_03;
  level._id_EC85["bridge_guy_main"]["roundhouse_punch"] = % heist_bridge_c6_attack_hooktohead_soldier;
  level._id_EC85["bridge_guy_main"]["opsmap_slam"] = % heist_bridge_c6_attack_opsmap_soldier;
  scripts\sp\anim::_id_17F6("bridge_guy_main", "opsmap_break", scripts\sp\maps\heist\heist_hack::_id_B5A6, "opsmap_slam");
  level._id_EC85["bridge_guy_main"]["ramp_kick"] = % heist_bridge_c6_attack_rampguy_soldier;
  level._id_EC85["bridge_guy_main"]["shove"] = % heist_bridge_c6_attack_shove_soldier;
  level._id_EC85["bridge_guy_extra"]["shove"] = % heist_bridge_c6_attack_shove_soldier_pushedinto;
  level._id_EC85["crawler"]["dying_crawl_death_v2"] = % hm_grnd_org_long_death_crawl_death01;
  level._id_EC85["generic"]["alert_react"] = % hm_grnd_yel_patrol_react_to_combat_2_ar;
  level._id_EC88["kotch"]["heist_kch_bot"] = % heist_kch_bot_face;
  level._id_EC88["kotch"]["heist_kch_detonationimme"] = % heist_kch_detonationimme_face;
  level._id_EC88["kotch"]["heist_kch_killthebot"] = % heist_kch_killthebot_face;
  level._id_EC88["kotch"]["heist_kch_5secondskillhim"] = % heist_kch_5secondskillhim_face;
  level._id_EC85["kotch"]["kotch_draw_pistol"] = % heist_bridge_kotch_draw_pistol;
  level._id_EC85["kotch"]["kotch_shoot_pistol"][0] = % heist_bridge_kotch_shoot_pistol;
  level._id_EC85["kotch"]["kotch_attack"] = % heist_bridge_kotch_kotch_attack;
  scripts\sp\anim::_id_17F6("kotch", "impact_head", scripts\sp\maps\heist\heist_hack::_id_8819, "kotch_attack");
  scripts\sp\anim::_id_17F6("kotch", "kick", scripts\sp\maps\heist\heist_hack::_id_881A, "kotch_attack");
  level._id_EC85["kotch"]["kotch_attack_idle"][0] = % heist_bridge_kotch_console_idle;
  level._id_EC85["kotch"]["kotch_kill_idle"][0] = % heist_bridge_kotch_hurt_idle;
  level._id_EC85["kotch"]["kotch_grab"] = % heist_bridge_kotch_grab_kotch;
  scripts\sp\anim::_id_17FC("kotch", "start_flight", "start_flight", "kotch_grab");
  scripts\sp\anim::_id_17FC("kotch", "can_kill", "can_kill", "kotch_grab");
  scripts\sp\anim::_id_17FC("kotch", "start_flight", "can_kill_timeout", "kotch_grab");
  scripts\sp\anim::_id_17F6("kotch", "mayhem_start", scripts\sp\maps\heist\heist_bridge::_id_A716, "kotch_grab");
  scripts\sp\anim::_id_17FC("kotch", "mayhem_end", "kotch_grab_mayhem_stop", "kotch_grab");
  level._id_EC85["kotch"]["kotch_kill"] = % heist_bridge_kotch_kill_kotch;
  scripts\sp\anim::_id_17FC("kotch", "start_flight", "start_flight", "kotch_kill");
  scripts\sp\anim::_id_17FC("kotch", "mayhem_end", "kotch_kill_mayhem_stop", "kotch_kill");
  level._id_EC85["salter"]["mons_launch"] = % hei_9_18_flight_scene_xo;
  level._id_EC85["ethan"]["mons_launch"] = % hei_9_18_flight_scene_eth3n;
  level._id_EC85["brooks"]["mons_launch"] = % hei_9_18_flight_scene_mr1;
  level._id_EC85["kashima"]["mons_launch"] = % hei_9_18_flight_scene_mr2;
  level._id_EC85["salter"]["mons_launch_idle"][0] = % hei_9_18_flight_scene_xo_idle;
  level._id_EC85["ethan"]["mons_launch_idle"][0] = % hei_9_18_flight_scene_eth3n_idle;
  level._id_EC85["brooks"]["mons_launch_idle"][0] = % hei_9_18_flight_scene_mr1_idle;
  level._id_EC85["kashima"]["mons_launch_idle"][0] = % hei_9_18_flight_scene_mr2_idle;
}

_id_D7C3(var_0) {}

#using_animtree("c6");

_id_3353() {
  level._id_EC85["c6"]["locker_deploy"] = % c6_grnd_red_exposed_rack_arm_spawn_ar;
  level._id_EC85["c6"]["crate_kick"] = % door_kick_in;
  level._id_EC85["generic"]["c6_walk"] = % c6_grnd_red_walk_forward_ar;
  level._id_EC85["c6bridge"]["c6bridge_sit_idle"][0] = % hei_c6_bridge_sit_idle;
  level._id_EC85["c6bridge"]["c6bridge_idle"][0] = % hei_c6_bridge_stand_idle;
  level._id_EC85["c6bridge"]["c6bridge_salute"] = % hei_c6_bridge_turn_salute;
  level._id_EC85["c6bridge"]["c6bridge_salute_idle"][0] = % hei_c6_bridge_turn_salute_idle;
  level._id_EC85["c6bridge"]["kotch_attack"] = % heist_bridge_c6_kotch_attack;
  level._id_EC85["c6worker_hack_0"]["robothack_idle"][0] = % heist_bridge_work_robot_01_idle;
  level._id_EC85["c6worker_hack_1"]["robothack_idle"][0] = % heist_bridge_work_robot_02_idle;
}

#using_animtree("c12");

_id_3508() {
  level._id_EC85["c12"]["c12_reveal"] = % europa_armory_c12_c12_reveal_turn_on;
}

#using_animtree("player");

player() {
  level._id_EC87["player_rig"] = #animtree;
  level._id_EC8C["player_rig"] = "viewmodel_base_viewhands_iw7";
  level._id_EC85["player_rig"]["churchfall_door_open"] = % pnr_churchfall_plr_door_open;
  level._id_EC85["player_rig"]["churchfall_crawl"] = % pnr_churchfall_plr_crawl;
  level._id_EC85["player_rig"]["churchfall_fall_a"] = % pnr_churchfall_plr_fall_a;
  level._id_EC85["player_rig"]["churchfall_fall_b"] = % pnr_churchfall_plr_fall_b;
  level._id_EC85["player_rig"]["churchfall_grab_all"] = % pnr_churchfall_plr_grab_all;
  level._id_EC85["player_rig"]["churchfall_death_a"] = % pnr_churchfall_plr_death_a_hvt;
  level._id_EC85["player_rig"]["churchfall_death_b"] = % pnr_churchfall_plr_death_b_hvt;
  scripts\sp\anim::_id_17FC("player_rig", "small_shake", "small_shake", "churchfall_death_b");
  scripts\sp\anim::_id_17FC("player_rig", "start_shake", "start_shake", "churchfall_death_b");
  scripts\sp\anim::_id_17FC("player_rig", "start_mons", "start_mons", "churchfall_death_b");
  scripts\sp\anim::_id_17FC("player_rig", "stop", "stop", "churchfall_crawl");
  scripts\sp\anim::_id_17FC("player_rig", "grab_start", "churchfall_grab_start", "churchfall_fall_a");
  scripts\sp\anim::_id_17FC("player_rig", "grab_end", "churchfall_grab_end", "churchfall_fall_a");
  scripts\sp\anim::_id_17FC("player_rig", "grab_start", "churchfall_grab_start", "churchfall_fall_b");
  scripts\sp\anim::_id_17FC("player_rig", "grab_end", "churchfall_grab_end", "churchfall_fall_b");
  scripts\sp\anim::_id_17FC("player_rig", "gator_pip", "gator_pip", "churchfall_death_b");
  scripts\sp\anim::_id_17FC("player_rig", "admiral_pip", "admiral_pip", "churchfall_death_b");
  scripts\sp\anim::_id_17FC("player_rig", "black_out", "churchfall_black_out", "churchfall_door_open");
  scripts\sp\anim::_id_17FC("player_rig", "black_out", "churchfall_black_out", "churchfall_death_a");
  scripts\sp\anim::_id_17FC("player_rig", "fade_out", "churchfall_fade_out", "churchfall_door_open");
  scripts\sp\anim::_id_17FC("player_rig", "fade_out", "churchfall_fade_out", "churchfall_death_a");
  scripts\sp\anim::_id_17FC("player_rig", "fade_in_stab", "churchfall_fade_in_stab", "churchfall_death_b");
  scripts\sp\anim::_id_17FC("player_rig", "fade_out_stab", "churchfall_fade_out_stab", "churchfall_death_a");
  scripts\sp\anim::_id_17FC("player_rig", "black_out_kick", "churchfall_black_out_kick", "churchfall_death_a");
  scripts\sp\anim::_id_17FC("player_rig", "fade_in_kick", "churchfall_fade_in_kick", "churchfall_death_a");
  scripts\sp\anim::_id_17FC("player_rig", "fade_out_wall", "churchfall_fade_out_wall", "churchfall_door_open");
  scripts\sp\anim::_id_17FC("player_rig", "fade_in_wall", "churchfall_fade_in_wall", "churchfall_door_open");
  level._id_EC85["player_rig"]["idle_before_launch"][0] = % heist_mons_attack_plr_hoverbeforelaunch;
  level._id_EC85["player_rig"]["fly_to_mons"] = % heist_mons_attack_plr_flight;
  level._id_EC85["player_rig"]["fly_to_mons_eject"] = % heist_mons_attack_plr_flight_land;
  scripts\sp\anim::_id_17F6("player_rig", "fade_out", ::_id_6AB8, "fly_to_mons_eject");
  scripts\sp\anim::_id_17F6("player_rig", "shelshock", ::_id_2CB0, "fly_to_mons_eject");
  level._id_EC85["player_rig"]["fly_to_mons_eject_getup"] = % heist_mons_attack_plr_flight_getup;
  level._id_EC85["player_rig"]["fly_to_mons_eject_fail"] = % heist_mons_attack_plr_flight_failtoeject;
  level._id_EC85["player_rig"]["player_slide"] = % heist_mons_slide_fall_plr;
  level._id_EC85["player_rig"]["player_hang"] = % heist_mons_slide_hang_plr;
  level._id_EC85["player_rig"]["player_boost"] = % heist_mons_slide_run_plr;
  level._id_EC85["player_rig"]["plant_breach"] = % heist_wallbreach_plant_plr;
  level._id_EC87["player_rig_c6"] = #animtree;
  level._id_EC87["player_rig_c6_legs"] = #animtree;
  level._id_EC8C["player_rig_c6"] = "viewmodel_robot_c6";
  level._id_EC8C["player_rig_c6_legs"] = "viewmodel_robot_c6_legs_sp";
  level._id_EC85["player_rig_c6"]["bootup_stand"] = % hei_c6_hack_bootup_stand;
  level._id_EC85["player_rig_c6"]["bootup_kneel"] = % hei_c6_hack_bootup_kneel;
  level._id_EC85["player_rig_c6"]["roundhouse_punch"] = % heist_bridge_c6_attack_hooktohead;
  level._id_EC85["player_rig_c6"]["opsmap_slam"] = % heist_bridge_c6_attack_opsmap_slam;
  scripts\sp\anim::_id_17F6("player_rig_c6", "impact_map", scripts\sp\maps\heist\heist_hack::_id_881B, "opsmap_slam");
  level._id_EC85["player_rig_c6"]["ramp_kick"] = % heist_bridge_c6_attack_rampguy;
  scripts\sp\anim::_id_17F6("player_rig_c6", "impact", scripts\sp\maps\heist\heist_hack::_id_881E, "ramp_kick");
  level._id_EC85["player_rig_c6"]["shove"] = % heist_bridge_c6_attack_shove;
  level._id_EC85["player_rig_c6_legs"]["shove"] = % heist_bridge_c6_attack_shove_robotlegs;
  level._id_EC85["player_rig_c6"]["kotch_attack"] = % heist_bridge_c6_kotch_attack;
  scripts\sp\anim::_id_17F6("player_rig_c6_legs", "impact", scripts\sp\maps\heist\heist_hack::_id_881E, "shove");
  level._id_EC85["player_rig"]["kotch_grab"] = % heist_bridge_plr_grab_kotch;
  level._id_EC85["player_rig"]["kotch_kill"] = % heist_bridge_plr_kill_kotch;
}

_id_6AB8(var_0) {
  if(scripts\engine\utility::flag("mons_boost_failed")) {
    return;
  }
  setomnvar("ui_hide_hud", 1);
  scripts\sp\hud_util::_id_6AA3(0.1, "black");
  wait 0.1;
  visionsetnaked("", 0.05);
}

_id_2CB0(var_0) {
  if(!scripts\engine\utility::flag("mons_boost")) {
    scripts\engine\utility::flag_set("mons_boost_failed");
    setomnvar("ui_hide_hud", 0);
    level.player playRumbleOnEntity("heavy_1s");
    thread scripts\sp\maps\heist\heist_flytomons::_id_6138();
    wait 0.2;
    _id_0B60::_id_F32D("HEIST_BOOST_DEATH_HINT");
    level.player thread _id_0B60::_id_2BC7();
    scripts\sp\utility::_id_B8D1();
    level waittill("forever");
  }

  setomnvar("ui_hide_hud", 1);
  level.player playSound("scn_heist_mons_land");
  level.player shellshock("flashbang", 1.0, undefined, 0);
}

#using_animtree("vehicles");

_id_13267() {
  level._id_EC87["dropship"] = #animtree;
  level._id_EC85["dropship"]["mons_dropoff"] = % heist_mons_attack_dropship;
  level._id_EC87["olympus_mons"] = #animtree;
  level._id_EC85["olympus_mons"]["mons_entrance"] = % heist_mons_entrance;
  level._id_EC85["olympus_mons"]["fly_to_mons"] = % heist_mons_attack_mons;
  level._id_EC87["retribution"] = #animtree;
  level._id_EC85["retribution"]["fly_to_mons"] = % heist_mons_attack_ret;
  scripts\sp\anim::_id_17FA("retribution", "emp_start", "ret_emp", "fly_to_mons");
  level._id_EC87["slide_frigate"] = #animtree;
  level._id_EC8C["slide_frigate"] = "veh_mil_air_ca_destroyer";
  level._id_EC85["slide_frigate"]["heist_mons_slide_fall_frigate"] = % heist_mons_slide_fall_frigate;
  level._id_EC87["ret_smash_dropship_1"] = #animtree;
  level._id_EC8C["ret_smash_dropship_1"] = "veh_mil_air_un_dropship_hero";
  level._id_EC85["ret_smash_dropship_1"]["ret_smash"] = % heist_mons_attack_flight_dropship;
}

#using_animtree("jackal");

_id_A056() {
  level._id_EC87["player_jackal"] = #animtree;
  level._id_EC85["player_jackal"]["church_jackal_idle"][0] = % heist_mons_attack_jackal_idle;
  level._id_EC85["player_jackal"]["church_jackal_arrive"] = % heist_mons_attack_jackal_arrival;
  scripts\sp\anim::_id_17F6("player_jackal", "hover", ::_id_F431);
  level._id_EC85["player_jackal"]["idle_before_launch"][0] = % heist_mons_attack_jackal_idle_hoverbeforelaunch;
  level._id_EC85["player_jackal"]["fly_to_mons"] = % heist_mons_attack_jackal_flight;
  level._id_EC85["player_jackal"]["fly_to_mons_eject"] = % heist_mons_attack_jackal_flight_land;
  level._id_EC85["player_jackal"]["fly_to_mons_eject_fail"] = % heist_mons_attack_jackal_flight_failtoeject;
  level._id_EC87["ret_smash_jackal_1"] = #animtree;
  level._id_EC87["ret_smash_jackal_2"] = #animtree;
  level._id_EC87["ret_smash_jackal_3"] = #animtree;
  level._id_EC8C["ret_smash_jackal_1"] = "veh_mil_air_ca_jackal_01";
  level._id_EC8C["ret_smash_jackal_2"] = "veh_mil_air_ca_jackal_01";
  level._id_EC8C["ret_smash_jackal_3"] = "veh_mil_air_ca_jackal_01";
  level._id_EC85["ret_smash_jackal_1"]["ret_smash"] = % heist_mons_attack_flight_sdf_jack_01;
  level._id_EC85["ret_smash_jackal_2"]["ret_smash"] = % heist_mons_attack_flight_sdf_jack_02;
  level._id_EC85["ret_smash_jackal_3"]["ret_smash"] = % heist_mons_attack_flight_sdf_jack_03;
  level._id_EC87["ret_fall_jackal_1"] = #animtree;
  level._id_EC8C["ret_fall_jackal_1"] = "veh_mil_air_ca_jackal_01";
  level._id_EC85["ret_fall_jackal_1"]["ret_fall"] = % heist_mons_attack_land_sdf_jack_01;
}

_id_F431(var_0) {
  var_0 thread _id_0C1A::_id_A3B6("hover", 1.0);
  var_0 thread _id_0C20::_id_A3B7("hover");
}

#using_animtree("script_model");

_id_EE25() {
  level._id_EC87["rooftop_rubble"] = #animtree;
  level._id_EC87["rooftop_bucket"] = #animtree;
  level._id_EC8C["rooftop_rubble"] = "balcony_rumble";
  level._id_EC8C["rooftop_bucket"] = "bucket_plastic";
  level._id_EC85["rooftop_rubble"]["mons_rumble"] = % pnr_churchfall_rumbles;
  level._id_EC85["rooftop_bucket"]["mons_rumble"] = % pnr_churchfall_bucket;
  level._id_EC87["jackal_sled"] = #animtree;
  level._id_EC8C["jackal_sled"] = "tag_origin";
  level._id_EC85["jackal_sled"]["church_jackal_mount"] = % heist_mons_attack_jackal_overmount_sled;
  level._id_EC85["jackal_sled"]["idle_before_launch"][0] = % heist_mons_attack_jackal_idle_hoverbeforelaunch;
  level._id_EC85["jackal_sled"]["fly_to_mons"] = % heist_mons_attack_jackal_flight;
  level._id_EC85["jackal_sled"]["fly_to_mons_eject"] = % heist_mons_attack_jackal_flight_eject;
  level._id_EC85["jackal_sled"]["fly_to_mons_eject_fail"] = % heist_mons_attack_jackal_flight_failtoeject;
  scripts\sp\anim::_id_17FC("jackal_sled", "hit_by_emp", "hit_by_emp", "fly_to_mons");
  level._id_EC87["transponder"] = #animtree;
  level._id_EC8C["transponder"] = "equipment_sp_transponder";
  level._id_EC85["transponder"]["churchfall_death_b"] = % pnr_churchfall_transponder;
  level._id_EC87["transponder_broken"] = #animtree;
  level._id_EC8C["transponder_broken"] = "equipment_sp_transponder_broken";
  level._id_EC85["transponder_broken"]["churchfall_death_b"] = % pnr_churchfall_transponder;
  level._id_EC87["laptop"] = #animtree;
  level._id_EC85["laptop"]["churchfall_death_b"] = % pnr_churchfall_laptop;
  level._id_EC87["churchfall_door"] = #animtree;
  level._id_EC8C["churchfall_door"] = "door_wood_01_door";
  level._id_EC85["churchfall_door"]["churchfall_door_open"] = % pnr_churchfall_door_door_open;
  level._id_EC87["un_building"] = #animtree;
  level._id_EC85["un_building"]["un_building_destruction"] = % heist_un_building_destruction;
  level._id_EC87["la_building_06_ygb_dest_full_animate"] = #animtree;
  level._id_EC85["la_building_06_ygb_dest_full_animate"]["collapse"] = % heist_bldg_06_ygb_collapse;
  level._id_EC87["building_periph_geneva_01_light_dest_full_animate"] = #animtree;
  level._id_EC85["building_periph_geneva_01_light_dest_full_animate"]["collapse"] = % heist_bldg_geneva_01_light_collapse;
  level._id_EC87["building_periph_geneva_06_light_dest_full_animate"] = #animtree;
  level._id_EC85["building_periph_geneva_06_light_dest_full_animate"]["collapse"] = % heist_bldg_geneva_06_light_collapse;
  level._id_EC87["un_building"] = #animtree;
  level._id_EC85["un_building"]["un_building_destruction"] = % heist_un_building_destruction;
  level._id_EC87["aatis_gun_0"] = #animtree;
  level._id_EC87["aatis_gun_1"] = #animtree;
  level._id_EC87["aatis_gun_2"] = #animtree;
  level._id_EC85["aatis_gun_0"]["aatis_destroy"] = % heist_aatis_gun_explode;
  level._id_EC85["aatis_gun_1"]["aatis_destroy"] = % heist_aatis_gun_explode2;
  level._id_EC85["aatis_gun_2"]["aatis_destroy"] = % heist_aatis_gun_explode3;
  scripts\sp\anim::_id_17F6("aatis_gun_0", "explode", ::_id_1509);
  scripts\sp\anim::_id_17F6("aatis_gun_1", "explode", ::_id_1508);
  scripts\sp\anim::_id_17F6("aatis_gun_2", "explode", ::_id_1507);
  level._id_EC87["hangar_crane_gun"] = #animtree;
  level._id_EC8C["hangar_crane_gun"] = "crane_hangar_sdf_05";
  level._id_EC87["hangar_crane"] = #animtree;
  level._id_EC8C["hangar_crane"] = "crane_hangar_01_animate";
  level._id_EC85["hangar_crane"]["crane_left"] = % hei_crane_left;
  level._id_EC89["hangar_crane"]["crane_left"] = 1;
  level._id_EC85["hangar_crane"]["crane_right"] = % hei_crane_right;
  level._id_EC89["hangar_crane"]["crane_right"] = 1;
  level._id_EC85["hangar_crane"]["crane_left_hard_10"] = % hei_crane_left_10_degree_swing;
  level._id_EC89["hangar_crane"]["crane_left_hard_10"] = 1;
  level._id_EC85["hangar_crane"]["crane_left_hard_20"] = % hei_crane_left_20_degree_swing;
  level._id_EC89["hangar_crane"]["crane_left_hard_20"] = 1;
  level._id_EC85["hangar_crane"]["crane_right_hard_10"] = % hei_crane_right_10_degree_swing;
  level._id_EC89["hangar_crane"]["crane_right_hard_10"] = 1;
  level._id_EC85["hangar_crane"]["crane_right_hard_20"] = % hei_crane_right_20_degree_swing;
  level._id_EC89["hangar_crane"]["crane_right_hard_20"] = 1;
  level._id_EC87["charge"] = #animtree;
  level._id_EC85["charge"]["plant_breach"] = % heist_wallbreach_plant_charge;
  level._id_EC8C["charge"] = "weapon_wallbreachcharge_wm";
  level._id_EC87["knife"] = #animtree;
  level._id_EC8C["knife"] = "tactical_knife_iw7_wm";
  level._id_EC87["knife_bloody"] = #animtree;
  level._id_EC8C["knife_bloody"] = "tactical_knife_iw7_wm_bloody";
  level._id_EC85["knife_bloody"]["churchfall_death_b"] = % pnr_churchfall_knife;
  level._id_EC87["locker_arm"] = #animtree;
  level._id_EC8C["locker_arm"] = "veh_mil_air_ca_drop_pod_arm";
  level._id_EC85["locker_arm"]["locker_deploy"] = % c6_grnd_red_exposed_rack_arm_spawn_arm;
  level._id_EC87["debris1"] = #animtree;
  level._id_EC85["debris1"]["frigate_slide_debris"] = % heist_mons_slide_run_debris1;
  level._id_EC8C["debris1"] = "debris_exterior_metal_panels_thick_04";
  level._id_EC87["debris1_kill"] = #animtree;
  level._id_EC85["debris1_kill"]["frigate_slide_debris_kill"] = % heist_mons_slide_run_killerdebris;
  level._id_EC8C["debris1_kill"] = "debris_concrete_rubble_lg_03";
  level._id_EC87["debris2"] = #animtree;
  level._id_EC85["debris2"]["frigate_slide_debris"] = % heist_mons_slide_run_debris2;
  level._id_EC8C["debris2"] = "debris_concrete_rubble_lg_01";
  level._id_EC87["debris3"] = #animtree;
  level._id_EC85["debris3"]["frigate_slide_debris"] = % heist_mons_slide_run_debris3;
  level._id_EC8C["debris3"] = "debris_concrete_rubble_lg_02";
  level._id_EC87["debris4"] = #animtree;
  level._id_EC85["debris4"]["frigate_slide_debris"] = % heist_mons_slide_run_debris4;
  level._id_EC8C["debris4"] = "debris_concrete_rubble_lg_03";
  level._id_EC87["debris5"] = #animtree;
  level._id_EC85["debris5"]["frigate_slide_debris"] = % heist_mons_slide_run_debris5;
  level._id_EC8C["debris5"] = "wasteland_space_trash_large_04";
  level._id_EC87["shield"] = #animtree;
  level._id_EC8C["shield"] = "weapon_retract_shield_wm";
  level._id_EC85["shield"]["mons_run"] = % heist_mons_slide_run_shield;
  level._id_EC85["shield"]["mons_dropoff"] = % heist_mons_attack_xo_shield;
  level._id_EC87["blowtorch"] = #animtree;
  level._id_EC8C["blowtorch"] = "engineer_blowtorch";
  level._id_EC85["blowtorch"]["bootup_stand"] = % hei_c6_hack_bootup_stand_torch;
  level._id_EC85["blowtorch"]["bootup_kneel"] = % hei_c6_hack_bootup_kneel_torch;
  level._id_EC87["bridge_chair"] = #animtree;
  level._id_EC8C["bridge_chair"] = "sdf_captains_chair_01_anim";
  level._id_EC85["bridge_chair"]["kotch_attack"] = % heist_bridge_chair_kotch_attack;
  level._id_EC85["bridge_chair"]["kotch_grab"] = % heist_bridge_chair_grab_kotch;
  level._id_EC85["bridge_chair"]["kotch_kill"] = % heist_bridge_chair_kill_kotch;
  level._id_EC85["bridge_chair"]["kotch_kill_idle"] = % heist_bridge_chair_hurt_idle;
  level._id_EC87["bridge_window_shields"] = #animtree;
  level._id_EC8C["bridge_window_shields"] = "sdf_bridge_windows_rig";
  level._id_EC85["bridge_window_shields"]["shields_open"] = % sa_moon_bridge_breach_react_shades;
  level._id_EC87["airlock_door"] = #animtree;
  level._id_EC85["airlock_door"]["frigate_slide_debris"] = % heist_mons_slide_run_airlock;
}

_id_1507(var_0) {
  scripts\engine\utility::exploder("powersurge1");
  level.player playSound("scn_heist_aatis_explo_01");
  wait 5;
  scripts\sp\utility::_id_10FEC("powersurge1");
  scripts\engine\utility::exploder("powersurge1_smoulder");
}

_id_1508(var_0) {
  scripts\engine\utility::exploder("powersurge2");
  level.player playSound("scn_heist_aatis_explo_02");
  wait 5;
  scripts\sp\utility::_id_10FEC("powersurge2");
  scripts\engine\utility::exploder("powersurge2_smoulder");
}

_id_1509(var_0) {
  scripts\engine\utility::exploder("powersurge3");
  level.player playSound("scn_heist_aatis_explo_03");
  wait 5;
  scripts\sp\utility::_id_10FEC("powersurge3");
  scripts\engine\utility::exploder("powersurge3_smoulder");
}

_id_FC92(var_0) {
  var_0._id_FC6C show();
}

_id_FC75(var_0) {
  var_0._id_FC6C hide();
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

_id_C0DC(var_0) {
  var_0.ignoreme = 1;
  var_0.ignoreall = 1;
  var_0 scripts\sp\utility::_id_F2DA(0);
  var_0 startragdoll();
}