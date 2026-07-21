/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\maps\estate\estate_anim.gsc
***********************************************/

main() {
  level.player.animname = "player";
  player();
  humans();
  script_models();
  vehicles();
  scriptables();
  level.scr_model["price_nvgs_on"] = "hat_hero_price_helmet";
}

#using_animtree("player");

player() {
  level.scr_animtree["player_rig"] = #animtree;
  level.scr_model["player_rig"] = "viewmodel_fullbody_kyle_woodland";
  level.scr_anim["player_rig"]["intro"] = % est_li_000_infil_plr;
  scripts\common\anim::addnotetrack_customfunction("player_rig", "fovlerp_begin", ::intro_fovlerp, "intro");
  scripts\common\anim::addnotetrack_customfunction("player_rig", "hide_head", ::intro_hidehead, "intro");
  scripts\common\anim::addnotetrack_customfunction("player_rig", "swap_player", ::intro_hidebody, "intro");
  scripts\common\anim::addnotetrack_customfunction("player_rig", "dof_near", ::intro_dofnear, "intro");
  scripts\common\anim::addnotetrack_customfunction("player_rig", "dof_truck", ::intro_doftruck, "intro");
  scripts\common\anim::addnotetrack_customfunction("player_rig", "dof_car", ::intro_dofcar, "intro");
  level.scr_anim["player_rig"]["fusebox_interact"] = % est_li_050_fusebox_tuto_plr;
  level.scr_anim["player_rig"]["player_rappel_start"] = % est_li_060_fwd_rappel_plr;
  scripts\common\anim::addnotetrack_customfunction("player_rig", "removeFOV", ::remove_fov_of_player_during_rappel, "player_rappel_start");
  scripts\common\anim::addnotetrack_customfunction("player_rig", "restoreFOV", ::restore_fov_of_player_during_rappel, "player_rappel_start");
  level.scr_anim["player_rig"]["player_rappel"] = % est_li_060_fwd_rappel_plr_outro;
  level.scr_anim["player_rig"]["church_interact"] = % est_cy_052_interrogation_knees_player_interact;
  scripts\common\anim::addnotetrack_customfunction("player_rig", "removeFOV", ::remove_fov_of_player_during_hvt_interact, "church_interact");
  scripts\common\anim::addnotetrack_customfunction("player_rig", "restoreFOV", ::restore_fov_of_player_during_hvt_interact, "church_interact");
  level.scr_anim["player_rig"]["church_interact_final"] = % est_cy_052_interrogation_knees_player_interact;
  scripts\common\anim::addnotetrack_customfunction("player_rig", "removeFOV", ::remove_fov_of_player_during_hvt_interact, "church_interact_final");
  scripts\common\anim::addnotetrack_customfunction("player_rig", "restoreFOV", ::restore_fov_of_player_during_hvt_interact, "church_interact_final");
  level.scr_anim["player_rig"]["pool_interact"] = % est_cy_053_interrogation_poi_pool_player_interact;
  scripts\common\anim::addnotetrack_customfunction("player_rig", "removeFOV", ::remove_fov_of_player_during_hvt_interact, "pool_interact");
  scripts\common\anim::addnotetrack_customfunction("player_rig", "restoreFOV", ::restore_fov_of_player_during_hvt_interact, "pool_interact");
  level.scr_anim["player_rig"]["pool_interact_final"] = % est_cy_053_interrogation_poi_pool_player_interact;
  scripts\common\anim::addnotetrack_customfunction("player_rig", "removeFOV", ::remove_fov_of_player_during_hvt_interact, "pool_interact_final");
  scripts\common\anim::addnotetrack_customfunction("player_rig", "restoreFOV", ::restore_fov_of_player_during_hvt_interact, "pool_interact_final");
  level.scr_anim["player_rig"]["courtyard_interact"] = % est_cy_051_interrogation_chair_player_interact;
  scripts\common\anim::addnotetrack_customfunction("player_rig", "removeFOV", ::remove_fov_of_player_during_hvt_interact, "courtyard_interact");
  scripts\common\anim::addnotetrack_customfunction("player_rig", "restoreFOV", ::restore_fov_of_player_during_hvt_interact, "courtyard_interact");
  level.scr_anim["player_rig"]["courtyard_interact_final"] = % est_cy_051_interrogation_chair_player_interact;
  scripts\common\anim::addnotetrack_customfunction("player_rig", "removeFOV", ::remove_fov_of_player_during_hvt_interact, "courtyard_interact_final");
  scripts\common\anim::addnotetrack_customfunction("player_rig", "restoreFOV", ::restore_fov_of_player_during_hvt_interact, "courtyard_interact_final");
  scripts\common\anim::addnotetrack_customfunction("player_rig", "allow_weapons", scripts\sp\player_rig::player_rig_allow_weapon, "church_interact");
  scripts\common\anim::addnotetrack_customfunction("player_rig", "allow_weapons", scripts\sp\player_rig::player_rig_allow_weapon, "church_interact_final");
  scripts\common\anim::addnotetrack_customfunction("player_rig", "allow_weapons", scripts\sp\player_rig::player_rig_allow_weapon, "courtyard_interact");
  scripts\common\anim::addnotetrack_customfunction("player_rig", "allow_weapons", scripts\sp\player_rig::player_rig_allow_weapon, "courtyard_interact_final");
  scripts\common\anim::addnotetrack_customfunction("player_rig", "allow_weapons", scripts\sp\player_rig::player_rig_allow_weapon, "pool_interact");
  scripts\common\anim::addnotetrack_customfunction("player_rig", "allow_weapons", scripts\sp\player_rig::player_rig_allow_weapon, "pool_interact_final");
  level.scr_anim["player_rig"]["door_keypad"] = % est_tf_010_meet_hadir_keypad_plr;
  level.scr_goaltime["player_rig"]["door_keypad"] = 0.2;
  level.scr_anim["player_rig"]["door_push"] = % est_tf_010_meet_hadir_outro_plr;
  scripts\common\anim::addnotetrack_flag("player_rig", "door_opened", "door_opened", "door_keypad");
  level.scr_anim["player_rig"]["explosion_intro"] = % est_tf_030_stairs_explosion_intro_plr;
  level.scr_anim["player_rig"]["explosion_main"] = % est_tf_030_stairs_explosion_fall_plr;
  level.scr_anim["player_rig"]["escape_getup"] = % est_esc_020_pickup_plr;
  scripts\common\anim::addnotetrack_customfunction("player_rig", "returnPlayerFOVtoNormal", ::player_rig_standup_fov_user_scale, "escape_getup");
  level.scr_anim["player_rig"]["tunnel_collapse"] = % est_hf_090_culvert_intro_scenec_plr;
  level.scr_anim["player_rig"]["arrest_hadir"] = % est_culvert_exfil_plr;
  scripts\common\anim::addnotetrack_customfunction("player_rig", "lerp_start", ::arrest_lerpstart, "arrest_hadir");
  scripts\common\anim::addnotetrack_customfunction("player_rig", "lerp_end", ::arrest_lerpend, "arrest_hadir");
  level.scr_model["context_melee_player_rig"] = "viewmodel_arms_kyle_woodland";
}

intro_fovlerp(var_0) {
  level.player lerpfovscalefactor(1, 1);
}

intro_hidehead(var_0) {
  var_0.body hidepart("j_head");
  var_0.body hidepart("j_helmet");
  getrandomnodedestination(0.75, 0);
  level.player scripts\engine\utility::delaythread(0.75, scripts\common\utility::allow_cinematic_motion, 1);
}

intro_hidebody(var_0) {
  var_0.body hide();
  var_0 show();
}

intro_dofnear(var_0) {
  level scripts\engine\sp\utility::dof_enable(1.8, 100);
}

intro_doftruck(var_0) {
  level.intro_technical scripts\engine\sp\utility::dof_enable_autofocus(1.8, 2);
}

intro_dofcar(var_0) {
  level.price scripts\engine\sp\utility::dof_enable_autofocus(2, 2, undefined, undefined, "tag_eye");
}

player_rig_standup_fov_user_scale(var_0) {
  level.player lerpfovscalefactor(1, 2);

  if(level.player ispcplayer())
    setsaveddvar("OMNONNMOTP", "0.1 500 4 10000");
}

remove_fov_of_player_during_rappel(var_0) {
  level.player lerpfovscalefactor(0, 1);
}

restore_fov_of_player_during_rappel(var_0) {
  level.player lerpfovscalefactor(1, 2);
}

remove_fov_of_player_during_hvt_interact(var_0) {
  level.player lerpfovscalefactor(0, 1);
}

restore_fov_of_player_during_hvt_interact(var_0) {
  level.player lerpfovscalefactor(1, 1);
}

arrest_lerpstart(var_0) {
  level.player lerpviewangleclamp(0.2, 0.1, 0.1, 0, 0, 0, 0);
}

arrest_lerpend(var_0) {}

#using_animtree("generic_human");

humans() {
  level.scr_anim["price"]["intro"] = % est_li_000_infil_price;
  level.scr_anim["kyle"]["intro"] = % est_li_000_infil_kyle;
  level.scr_anim["gunner"]["intro"] = % est_li_000_infil_aq01;
  level.scr_anim["price"]["infil_gate_arrival"] = % est_li_030_woods_price_e;
  level.scr_anim["price"]["infil_gate_idle"][0] = % est_li_040_chain_price_arrival_idle;
  level.scr_anim["price"]["infil_gate_idle"][1] = % est_li_040_chain_price_arrival_idle;
  level.scr_anim["price"]["infil_gate_idle_nags"][0] = % est_li_040_chain_price_arrival_nag;
  level.scr_anim["price"]["infil_gate_idle_nags"][1] = % est_li_040_chain_price_arrival_nag;
  level.scr_anim["price"]["infil_gate_cut"] = % est_li_040_chain_price;
  level.scr_anim["price"]["infil_gate_halfway_idle"][0] = % est_li_040_chain_price_idle;
  level.scr_anim["price"]["infil_gate_halway_moveup"] = % est_li_040_chain_price_walk_out;
  scripts\common\anim::addnotetrack_notify("price", "nag", "nag", "infil_gate_idle_nags");
  scripts\common\anim::addnotetrack_notify("price", "nag", "nag", "fusebox_tut_idle_nags");
  level.scr_anim["price"]["infil_bush_idle"][0] = % est_li_040_chain_price_alert_idle;
  level.scr_anim["price"]["infil_bush_alert"] = % est_li_040_chain_price_alert;
  level.scr_anim["price"]["dumpster_walkby"] = % est_li_045_strafe_b_price;
  level.scr_face["price"]["dx_vom_pri_woods_traverse_90"] = % dx_vom_pri_woods_traverse_90_face;
  level.scr_face["price"]["dx_vom_pri_woods_traverse_100"] = % dx_vom_pri_woods_traverse_100_face;
  level.scr_face["price"]["dx_vom_pri_woods_traverse_110"] = % dx_vom_pri_woods_traverse_110_face;
  level.scr_face["price"]["dx_vom_pri_woods_traverse_120"] = % dx_vom_pri_woods_traverse_120_face;
  level.scr_face["price"]["dx_vom_pri_woods_traverse_220"] = % dx_vom_pri_woods_traverse_220_face;
  level.scr_anim["price"]["fusebox_tut_arrive"] = % est_li_050_fusebox_tuto_price_entrance;
  level.scr_anim["price"]["fusebox_tut_idle"][0] = % est_li_050_fusebox_tuto_price_idle;
  level.scr_anim["price"]["fusebox_tut_idle_nags"][0] = % est_li_050_fusebox_tuto_price_nag;
  scripts\common\anim::addnotetrack_flag("price", "ready", "fusebox_price_ready", "fusebox_tut_arrive");
  level.scr_anim["price"]["fusebox_tut_owned"] = % est_li_050_fusebox_tuto_price;
  level.scr_anim["price"]["fusebox_tut_breakout"] = % est_li_050_fusebox_tuto_branch_price;
  level.scr_anim["wrecked"]["fusebox_tut_owned"] = % est_li_050_fusebox_tuto_alq01;
  level.scr_anim["wrecked"]["fusebox_tut_breakout"] = % sdr_com_exposed_stand_death04_head_md_2;
  scripts\common\anim::addnotetrack_customfunction("price", "fire_pistol", ::price_pistol_fire, "fusebox_tut_owned");
  scripts\common\anim::addnotetrack_customfunction("wrecked", "gun_drop", ::throwgun, "fusebox_tut_owned");
  scripts\common\anim::addnotetrack_customfunction("wrecked", "first_pain", ::no_more_pain, "fusebox_tut_owned");
  scripts\common\anim::addnotetrack_notify("price", "committed", "fusebox_price_committed", "fusebox_tut_owned");
  level.scr_face["price"]["dx_vom_pri_fusebox_tutorial_10"] = % dx_vom_pri_fusebox_tutorial_10_face;
  level.scr_face["price"]["dx_vom_pri_fusebox_tutorial_20"] = % dx_vom_pri_fusebox_tutorial_20_face;
  level.scr_face["price"]["dx_vom_pri_fusebox_tutorial_21"] = % dx_vom_pri_fusebox_tutorial_21_face;
  level.scr_face["price"]["dx_vom_pri_fusebox_tutorial_30"] = % dx_vom_pri_fusebox_tutorial_30_face;
  level.scr_face["price"]["dx_vom_pri_stealth_doublekill_10"] = % dx_vom_pri_stealth_doublekill_10_face;
  level.scr_face["price"]["dx_vom_pri_estate_stealth_60"] = % dx_vom_pri_estate_stealth_60_face;
  level.scr_anim["price"]["melee_exit"] = % est_li_050_light_entrance_price;
  level.scr_anim["price"]["melee_exit_end_idle"][0] = % est_li_050_light_entrance_price_knee_idle;
  level.scr_anim["price"]["melee_exit_end"] = % est_li_050_light_entrance_price_outro;
  level.scr_face["price"]["dx_vom_pri_tut_lights_10"] = % dx_vom_pri_tut_lights_10_face;
  level.scr_face["price"]["dx_vom_pri_tut_lights_20"] = % dx_vom_pri_tut_lights_20_face;
  level.scr_face["price"]["dx_vom_pri_tut_lights_25"] = % dx_vom_pri_tut_lights_25_face;
  level.scr_face["price"]["dx_vom_pri_tut_lights_30"] = % dx_vom_pri_tut_lights_30_face;
  level.scr_face["price"]["dx_vom_pri_tut_lights_40"] = % dx_vom_pri_tut_lights_40_face;
  level.scr_face["price"]["dx_vom_pri_tut_lights_50"] = % dx_vom_pri_tut_lights_50_face;
  level.scr_face["price"]["dx_vom_pri_tut_lights_51"] = % dx_vom_pri_tut_lights_51_face;
  level.scr_face["price"]["dx_vom_pri_tut_lights_52"] = % dx_vom_pri_tut_lights_52_face;
  level.scr_face["price"]["dx_vom_pri_tut_lights_60"] = % dx_vom_pri_tut_lights_60_face;
  level.scr_face["price"]["dx_vom_pri_tut_lights_80"] = % dx_vom_pri_tut_lights_80_face;
  level.scr_face["price"]["dx_vom_pri_woods_traverse_91"] = % dx_vom_pri_woods_traverse_91_face;
  level.scr_anim["price"]["fwd_rappel_price_enter"] = % est_li_060_fwd_rappel_price_enter;
  level.scr_anim["price"]["fwd_rappel_price_enter_idle"][0] = % est_li_060_fwd_rappel_price_enter_idle;
  level.scr_anim["price"]["fwd_rappel_price_enter_idle_nags"][0] = % est_li_060_fwd_rappel_price_enter_nag;
  level.scr_anim["price"]["fwd_rappel_price_go"] = % est_li_060_fwd_rappel_price;
  level.scr_anim["price"]["fwd_rappel_price_idle"][0] = % est_li_060_fwd_rappel_price_idle;
  level.scr_anim["price"]["fwd_rappel_price_idle_nags"][0] = % est_li_060_fwd_rappel_price_nag;
  level.scr_anim["price"]["fwd_rappel_price_outro"] = % est_li_060_fwd_rappel_price_outro;
  level.scr_anim["price"]["fwd_rappel_price_outro_idle"][0] = % est_li_060_fwd_rappel_price_outro_idle;
  scripts\common\anim::addnotetrack_notify("price", "overlook_vo", "price_overlook_vo", "fwd_rappel_price_enter");
  scripts\common\anim::addnotetrack_notify("price", "nag", "nag", "fwd_rappel_price_enter_idle_nags");
  scripts\common\anim::addnotetrack_notify("price", "nag", "nag", "fwd_rappel_price_idle_nags");
  level.scr_face["price"]["dx_vom_pri_rappel_sitrep_20"] = % dx_vom_pri_rappel_sitrep_20_face;
  level.scr_face["price"]["dx_vom_pri_rappel_sitrep_30"] = % dx_vom_pri_rappel_sitrep_30_face;
  level.scr_face["price"]["dx_vom_pri_rappel_sitrep_40"] = % dx_vom_pri_rappel_sitrep_40_face;
  level.scr_face["price"]["dx_vom_pri_rappel_rope_40"] = % dx_vom_pri_rappel_rope_40_face;
  level.scr_face["price"]["dx_vom_pri_rappel_rope_50"] = % dx_vom_pri_rappel_rope_50_face;
  level.scr_face["price"]["dx_vom_pri_rappel_rope_60"] = % dx_vom_pri_rappel_rope_60_face;
  level.scr_anim["alq05"]["fwd_rappel_ground"] = % est_li_060_fwd_rappel_execution_alq01;
  level.scr_anim["alq06"]["fwd_rappel_ground"] = % est_li_060_fwd_rappel_execution_alq02;
  level.scr_anim["russ01"]["fwd_rappel_ground"] = % est_li_060_fwd_rappel_execution_victime01;
  level.scr_anim["russ02"]["fwd_rappel_ground"] = % est_li_060_fwd_rappel_execution_victime02;
  level.scr_animtree["hvt"] = #animtree;
  level.scr_anim["hvt"]["church_interrogation"][0] = % est_cy_052_hostage_church_victim01;
  level.scr_anim["hvt"]["church_interrogation_getup"] = % est_cy_052_hostage_church_victim01_getup;
  level.scr_anim["hvt"]["church_idle"][0] = % est_cy_052_interrogation_knees_hostage_idle;
  level.scr_anim["hvt"]["church_death_forward"] = % est_cy_052_hostage_church_victim01_death01;
  level.scr_anim["hvt"]["church_death_backward"] = % est_cy_052_hostage_church_victim01_death03;
  level.scr_anim["hvt"]["church_interact"] = % est_cy_052_interrogation_knees_hostage_interact;
  level.scr_anim["hvt"]["church_interact_final"] = % est_cy_052_interrogation_knees_hostage_interact;
  level.scr_anim["hvt"]["church_yelling"][0] = % est_cy_052_interrogation_knees_hostage_idle_yelling;
  level.scr_anim["hvt"]["church_interact_mayhem"] = % est_cy_052_interrogation_knees_hostage_interact_face;
  level.scr_anim["hvt"]["church_interact_final_mayhem"] = % est_cy_052_interrogation_knees_hostage_interact_final;
  scripts\common\anim::addnotetrack_mayhemstart("hvt", "mayhem_start", %est_cy_052_interrogation_knees_hostage_interact_face, "church_interact");
  scripts\common\anim::addnotetrack_mayhemend("hvt", "mayhem_end", %est_cy_052_interrogation_knees_hostage_interact_face, "church_interact");
  scripts\common\anim::addnotetrack_mayhemstart("hvt", "mayhem_start", %est_cy_052_interrogation_knees_hostage_interact_final, "church_interact_final");
  scripts\common\anim::addnotetrack_mayhemend("hvt", "mayhem_end", %est_cy_052_interrogation_knees_hostage_interact_final, "church_interact_final");
  level.scr_anim["hvt"]["pool_interrogation"][0] = % est_cy_053_hostage_pool_victim03;
  level.scr_anim["hvt"]["pool_interrogation_getup"] = % est_cy_053_hostage_pool_getupa_victim03;
  level.scr_anim["hvt"]["pool_breakout_1"] = % est_cy_053_hostage_pool_breakout1_victim03;
  level.scr_anim["hvt"]["pool_breakout_2"] = % est_cy_053_hostage_pool_breakout2_victim03;
  level.scr_anim["hvt"]["pool_breakout_3"] = % est_cy_053_hostage_pool_breakout3_victim03;
  level.scr_anim["hvt"]["pool_breakout_4"] = % est_cy_053_hostage_pool_breakout4_victim03;
  level.scr_anim["hvt"]["pool_breakout_5"] = % est_cy_053_hostage_pool_breakout5_victim03;
  level.scr_anim["hvt"]["pool_breakout_6"] = % est_cy_053_hostage_pool_breakout6_victim03;
  level.scr_anim["hvt"]["pool_idle"][0] = % est_cy_052_interrogation_knees_hostage_idle_pool;
  level.scr_anim["hvt"]["pool_death_forward"] = % est_cy_053_hostage_pool_victim03_death01;
  level.scr_anim["hvt"]["pool_death_backward"] = % est_cy_053_hostage_pool_victim03_death03;
  level.scr_anim["hvt"]["pool_interact"] = % est_cy_053_interrogation_poi_pool_hostage_interact;
  level.scr_anim["hvt"]["pool_interact_final"] = % est_cy_053_interrogation_poi_pool_hostage_interact;
  level.scr_anim["hvt"]["pool_yelling"][0] = % est_cy_053_hostage_pool_yelling_victim03;
  level.scr_goaltime["hvt"]["pool_interrogation_getup"] = 1;
  level.scr_anim["hvt"]["pool_interact_mayhem"] = % est_cy_053_interrogation_poi_pool_hostage_interact_face;
  level.scr_anim["hvt"]["pool_interact_final_mayhem"] = % est_cy_053_interrogation_poi_pool_hostage_interact_final;
  scripts\common\anim::addnotetrack_mayhemstart("hvt", "mayhem_start", %est_cy_053_interrogation_poi_pool_hostage_interact_face, "pool_interact");
  scripts\common\anim::addnotetrack_mayhemend("hvt", "mayhem_end", %est_cy_053_interrogation_poi_pool_hostage_interact_face, "pool_interact");
  scripts\common\anim::addnotetrack_mayhemstart("hvt", "mayhem_start", %est_cy_053_interrogation_poi_pool_hostage_interact_final, "pool_interact_final");
  scripts\common\anim::addnotetrack_mayhemend("hvt", "mayhem_end", %est_cy_053_interrogation_poi_pool_hostage_interact_final, "pool_interact_final");
  level.scr_anim["hvt"]["courtyard_interrogation"][0] = % est_cy_051_interrogation_chair_hostage;
  level.scr_anim["hvt"]["courtyard_interrogation_getup"] = % est_cy_051_interrogation_chair_hostage_settle;
  level.scr_anim["hvt"]["courtyard_idle"][0] = % est_cy_051_interrogation_chair_hostage_idle;
  level.scr_anim["hvt"]["courtyard_death_forward"] = % est_cy_051_interrogation_chair_hostage_death_forwards;
  level.scr_anim["hvt"]["courtyard_death_backward"] = % est_cy_051_interrogation_chair_hostage_death_backwards;
  level.scr_anim["hvt"]["courtyard_interact"] = % est_cy_051_interrogation_chair_hostage_interact;
  level.scr_anim["hvt"]["courtyard_interact_final"] = % est_cy_051_interrogation_chair_hostage_interact;
  level.scr_anim["hvt"]["courtyard_yelling"][0] = % est_cy_051_interrogation_chair_hostage_yelling;
  level.scr_anim["hvt"]["courtyard_interact_mayhem"] = % est_cy_051_interrogation_chair_hostage_interact_face;
  level.scr_anim["hvt"]["courtyard_interact_final_mayhem"] = % est_cy_051_interrogation_chair_hostage_interact_final;
  scripts\common\anim::addnotetrack_mayhemstart("hvt", "mayhem_start", %est_cy_051_interrogation_chair_hostage_interact_face, "courtyard_interact");
  scripts\common\anim::addnotetrack_mayhemend("hvt", "mayhem_end", %est_cy_051_interrogation_chair_hostage_interact_face, "courtyard_interact");
  scripts\common\anim::addnotetrack_mayhemstart("hvt", "mayhem_start", %est_cy_051_interrogation_chair_hostage_interact_final, "courtyard_interact_final");
  scripts\common\anim::addnotetrack_mayhemend("hvt", "mayhem_end", %est_cy_051_interrogation_chair_hostage_interact_final, "courtyard_interact_final");
  level.scr_anim["interrogator"]["church_interrogation"][0] = % est_cy_052_hostage_church_interrogator01;
  level.scr_anim["interrogator"]["pool_interrogation"][0] = % est_cy_053_hostage_pool_enemy03;
  level.scr_anim["interrogator"]["courtyard_interrogation"][0] = % est_cy_051_interrogation_chair_terrorist;
  level.scr_animtree["body1"] = #animtree;
  level.scr_animtree["body2"] = #animtree;
  level.scr_anim["alq1"]["body_drag_door_idle_enter"] = % est_ma_020_body_drag_enmy_idle_enter;
  level.scr_anim["alq1"]["body_drag_door_idle"][0] = % est_ma_020_body_drag_enmy_idle;
  level.scr_anim["alq1"]["body_drag_door"] = % est_ma_020_body_drag_enmy;
  level.scr_anim["alq1"]["body_drag_door_death"] = % est_ma_020_body_drag_enmy_death;
  level.scr_anim["alq1"]["body_drag_door_react_investigate"] = % est_ma_020_body_drag_enmy_react01;
  level.scr_anim["alq1"]["body_drag_door_react_combat"] = % est_ma_020_body_drag_enmy_react02;
  level.scr_goaltime["alq1"]["body_drag_door_react_investigate"] = 0.2;
  level.scr_goaltime["alq1"]["body_drag_door_react_combat"] = 0.2;
  level.scr_anim["body1"]["body_drag_door_idle"][0] = % est_ma_020_body_drag_body01_idle;
  level.scr_anim["body1"]["body_drag_door"] = % est_ma_020_body_drag_body01;
  level.scr_anim["body1"]["body_drag_door_death"] = % est_ma_020_body_drag_body01_death;
  level.scr_anim["body2"]["body_drag_door"] = % est_ma_020_body_drag_body02;
  level.scr_anim["alq1"]["body_drag_dumpster_idle"][0] = % est_ma_021_body_drag_b_enmy01_idle;
  level.scr_anim["alq1"]["body_drag_dumpster"] = % est_ma_021_body_drag_b_enmy01;
  level.scr_anim["alq1"]["body_drag_dumpster_death"] = % est_ma_021_body_drag_b_enmy01_death;
  level.scr_anim["alq1"]["body_drag_dumpster_react_investigate"] = % est_ma_021_body_drag_b_enmy01_react02;
  level.scr_anim["alq1"]["body_drag_dumpster_react_combat"] = % est_ma_021_body_drag_b_enmy01_react01;
  level.scr_anim["alq1"]["body_drag_dumpster_react_pain"] = % est_ma_021_body_drag_b_enmy01_painreact01;
  level.scr_goaltime["alq1"]["body_drag_dumpster_react_investigate"] = 0.2;
  level.scr_goaltime["alq1"]["body_drag_dumpster_react_combat"] = 0.2;
  level.scr_goaltime["alq1"]["body_drag_dumpster_react_pain"] = 0.2;
  level.scr_anim["alq2"]["body_drag_dumpster_idle"][0] = % est_ma_021_body_drag_b_enmy02_idle;
  level.scr_anim["alq2"]["body_drag_dumpster"] = % est_ma_021_body_drag_b_enmy02;
  level.scr_anim["alq2"]["body_drag_dumpster_death"] = % est_ma_021_body_drag_b_enmy02_death;
  level.scr_anim["alq2"]["body_drag_dumpster_react_investigate"] = % est_ma_021_body_drag_b_enmy02_react02;
  level.scr_anim["alq2"]["body_drag_dumpster_react_combat"] = % est_ma_021_body_drag_b_enmy02_react01;
  level.scr_anim["alq2"]["body_drag_dumpster_react_pain"] = % est_ma_021_body_drag_b_enmy02_painreact01;
  level.scr_goaltime["alq2"]["body_drag_dumpster_react_investigate"] = 0.2;
  level.scr_goaltime["alq2"]["body_drag_dumpster_react_combat"] = 0.2;
  level.scr_goaltime["alq2"]["body_drag_dumpster_react_pain"] = 0.2;
  level.scr_anim["body1"]["body_drag_dumpster_idle"][0] = % est_ma_021_body_drag_b_body01_idle;
  level.scr_anim["body1"]["body_drag_dumpster"] = % est_ma_021_body_drag_b_body01;
  level.scr_anim["body1"]["body_drag_dumpster_death"] = % est_ma_021_body_drag_b_body01_death;
  level.scr_anim["body1"]["body_drag_dumpster_react_investigate"] = % est_ma_021_body_drag_b_body01_react02;
  level.scr_anim["body1"]["body_drag_dumpster_react_combat"] = % est_ma_021_body_drag_b_body01_react01;
  level.scr_anim["body1"]["body_drag_dumpster_react_pain"] = % est_ma_021_body_drag_b_body01_painreact01;
  level.scr_anim["body2"]["body_drag_dumpster"] = % est_ma_021_body_drag_b_body02;
  level.scr_anim["alq1"]["car_rummage_l_intro"] = % car_interaction_withbody_l_intro_enemy;
  level.scr_anim["alq1"]["car_rummage_l_idle"][0] = % car_interaction_withbody_l_idle_enemy;
  level.scr_anim["alq1"]["car_rummage_l_react"] = % car_interaction_withbody_l_reaction_enemy;
  level.scr_anim["alq1"]["car_rummage_l_death"] = % car_interaction_withbody_l_death_enemy;
  level.scr_goaltime["alq1"]["car_rummage_l_react"] = 0.2;
  level.scr_anim["body1"]["car_rummage_l_intro"] = % car_interaction_withbody_l_intro_civ;
  level.scr_anim["body1"]["car_rummage_l_idle"][0] = % car_interaction_withbody_l_idle_civ;
  level.scr_anim["body1"]["car_rummage_l_react"] = % car_interaction_withbody_l_reaction_civ;
  level.scr_anim["body1"]["car_rummage_l_death"] = % car_interaction_withbody_l_death_civ;
  level.scr_goaltime["body1"]["car_rummage_l_react"] = 0.2;
  level.scr_anim["alq1"]["car_rummage_r_intro"] = % car_interaction_withbody_r_intro_enemy;
  level.scr_anim["alq1"]["car_rummage_r_idle"][0] = % car_interaction_withbody_r_idle_enemy;
  level.scr_anim["alq1"]["car_rummage_r_react"] = % car_interaction_withbody_r_reaction_enemy;
  level.scr_anim["alq1"]["car_rummage_r_death"] = % car_interaction_withbody_r_death_enemy;
  level.scr_goaltime["alq1"]["car_rummage_r_react"] = 0.2;
  level.scr_anim["body1"]["car_rummage_r_intro"] = % car_interaction_withbody_r_intro_civ;
  level.scr_anim["body1"]["car_rummage_r_idle"][0] = % car_interaction_withbody_r_idle_civ;
  level.scr_anim["body1"]["car_rummage_r_react"] = % car_interaction_withbody_r_reaction_civ;
  level.scr_anim["body1"]["car_rummage_r_death"] = % car_interaction_withbody_r_death_civ;
  level.scr_goaltime["body1"]["car_rummage_r_react"] = 0.2;
  level.scr_anim["alq1"]["body_poke_floor_1"] = % est_cy_031_dead_bodies_a_enmy01;
  level.scr_anim["alq1"]["body_poke_floor_2"] = % est_cy_031_dead_bodies_b_enmy01;
  level.scr_anim["alq1"]["body_poke_floor_3"] = % est_cy_031_dead_bodies_e_enmy01;
  level.scr_anim["alq1"]["body_poke_wall_1"] = % est_cy_031_dead_bodies_c_enmy01;
  level.scr_anim["alq1"]["body_poke_wall_2"] = % est_cy_031_dead_bodies_d_enmy01;
  level.scr_anim["body1"]["body_poke_floor_1"] = % est_cy_031_dead_bodies_a_dead01;
  level.scr_anim["body1"]["body_poke_floor_2"] = % est_cy_031_dead_bodies_b_dead01;
  level.scr_anim["body1"]["body_poke_floor_3"] = % est_cy_031_dead_bodies_e_dead01;
  level.scr_anim["body1"]["body_poke_wall_1"] = % est_cy_031_dead_bodies_c_dead01;
  level.scr_anim["body1"]["body_poke_wall_2"] = % est_cy_031_dead_bodies_d_dead01;
  level.scr_anim["alq1"]["search_desk_intro"] = % est_search_desk_terry_arrival;
  level.scr_anim["alq1"]["search_desk_loop"][0] = % est_search_desk_terry_idle;
  level.scr_anim["alq1"]["search_desk_outro"] = % est_search_desk_terry_exit;
  level.scr_anim["alq1"]["search_desk_react_investigate"] = % est_search_desk_terry_react01;
  level.scr_anim["alq1"]["search_desk_react_combat"] = % est_search_desk_terry_react02;
  level.scr_anim["alq1"]["search_desk_pain"] = % est_search_desk_terry_pain;
  level.scr_anim["alq1"]["search_desk_death_front"] = % est_search_desk_terry_death_front;
  level.scr_anim["alq1"]["search_desk_death_back"] = % est_search_desk_terry_death_back;
  level.scr_goaltime["alq1"]["search_desk_react_investigate"] = 0.2;
  level.scr_goaltime["alq1"]["search_desk_react_combat"] = 0.2;
  level.scr_goaltime["alq1"]["search_desk_pain"] = 0.2;
  level.scr_anim["alq1"]["search_cabinet_intro"] = % est_search_cabinet_terry_arrival;
  level.scr_anim["alq1"]["search_cabinet_loop"][0] = % est_search_cabinet_terry_idle;
  level.scr_goaltime["alq1"]["search_cabinet_loop"] = 0.0;
  level.scr_anim["alq1"]["search_cabinet_outro"] = % est_search_cabinet_terry_exit;
  level.scr_anim["alq1"]["search_cabinet_react_investigate"] = % est_search_cabinet_terry_react01;
  level.scr_anim["alq1"]["search_cabinet_react_combat"] = % est_search_cabinet_terry_react02;
  level.scr_anim["alq1"]["search_cabinet_pain"] = % est_search_cabinet_terry_pain;
  level.scr_anim["alq1"]["search_cabinet_death"] = % est_search_cabinet_terry_death;
  level.scr_goaltime["alq1"]["search_cabinet_react_investigate"] = 0.2;
  level.scr_goaltime["alq1"]["search_cabinet_react_combat"] = 0.2;
  level.scr_goaltime["alq1"]["search_cabinet_pain"] = 0.2;
  level.scr_anim["alq1"]["search_locker_intro"] = % est_search_locker_terry_arrival;
  level.scr_anim["alq1"]["search_locker_loop"][0] = % est_search_locker_terry_idle;
  level.scr_anim["alq1"]["search_locker_outro"] = % est_search_locker_terry_exit;
  level.scr_anim["alq1"]["search_locker_react_investigate"] = % est_search_locker_terry_react01;
  level.scr_anim["alq1"]["search_locker_react_combat"] = % est_search_locker_terry_react02;
  level.scr_anim["alq1"]["search_locker_pain"] = % est_search_locker_terry_pain;
  level.scr_anim["alq1"]["search_locker_death"] = % est_search_locker_terry_death;
  level.scr_goaltime["alq1"]["search_locker_react_investigate"] = 0.2;
  level.scr_goaltime["alq1"]["search_locker_react_combat"] = 0.2;
  level.scr_goaltime["alq1"]["search_locker_pain"] = 0.2;
  level.scr_anim["price"]["obj_idle_no_nags"][0] = % est_3f_idle_price;
  level.scr_anim["price"]["obj_idle"][0] = % est_3f_idle_price;
  level.scr_anim["price"]["obj_idle_nags"][0] = % est_3f_nag_price;
  scripts\common\anim::addnotetrack_notify("price", "nag", "nag", "obj_idle_nags");
  level.scr_anim["price"]["obj_scene"] = % est_tf_010_meet_hadir_scene_price;
  level.scr_anim["price"]["heli_idle"][0] = % est_tf_010_meet_hadir_heli_idle_price;
  level.scr_anim["price"]["obj_scene_b"] = % est_tf_010_meet_hadir_scene_b_price;
  level.scr_anim["price"]["door_push_idle"][0] = % est_tf_010_meet_hadir_idle_price;
  level.scr_anim["price"]["door_push"] = % est_tf_010_meet_hadir_outro_price;
  scripts\common\anim::addnotetrack_flag("price", "door_push_start", "door_push_start", "obj_scene_b");
  level.scr_anim["ally1"]["obj_scene"] = % est_tf_010_meet_hadir_scene_hadir;
  level.scr_anim["ally1"]["heli_idle"][0] = % est_tf_010_meet_hadir_heli_idle_hadir;
  level.scr_anim["ally1"]["obj_scene_b"] = % est_tf_010_meet_hadir_scene_b_hadir;
  level.scr_anim["ally1"]["door_push_idle"][0] = % est_tf_010_meet_hadir_idle_hadir;
  level.scr_anim["ally1"]["door_push"] = % est_tf_010_meet_hadir_outro_hadir;
  scripts\common\anim::addnotetrack_flag("ally1", "spawn_heli", "spawn_escape_heli", "obj_scene");
  level.scr_face["price"]["dx_vom_pri_objroom_exterior_10"] = % dx_vom_pri_objroom_exterior_10_face;
  level.scr_face["price"]["dx_vom_pri_objroom_exterior_20"] = % dx_vom_pri_objroom_exterior_20_face;
  level.scr_face["price"]["dx_vom_pri_objroom_exterior_30"] = % dx_vom_pri_objroom_exterior_30_face;
  level.scr_face["price"]["dx_vom_pri_obj_room_plans_295"] = % dx_vom_pri_obj_room_plans_295_face;
  level.scr_anim["ally1"]["hallway_exit"] = % est_tf_010_hallway_hadir;
  level.scr_anim["price"]["hallway_exit"] = % est_tf_010_hallway_price;
  level.scr_anim["ally1"]["explosion_main"] = % est_tf_030_explosion_explode_hadir;
  level.scr_anim["ally1"]["explosion_idle"][0] = % est_tf_030_explosion_idle_hadir;
  level.scr_anim["price"]["explosion_idle"][0] = % est_tf_030_explosion_idle_price;
  level.scr_anim["price"]["explosion_idle_nags"][0] = % est_tf_030_explosion_nag_price;
  scripts\common\anim::addnotetrack_notify("price", "nag", "nag", "explosion_idle_nags");
  level.scr_anim["price"]["explosion_fire"] = % est_tf_030_explosion_fire_price;
  level.scr_anim["price"]["explosion_main"] = % est_tf_030_explosion_explode_price;
  level.scr_anim["price"]["escape_getup"] = % est_esc_020_pickup_price;
  level.scr_anim["ally1"]["escape_getup"] = % est_esc_020_pickup_hadir;
  level.scr_anim["enemy1"]["escape_getup"] = % est_esc_020_pickup_enemy1;
  level.scr_anim["aq1"]["escape_getup"] = % est_esc_020_pickup_aq1;
  scripts\common\anim::addnotetrack_mayhemstart("price", "mayhem_start", %est_esc_020_pickup_price_face, "escape_getup");
  scripts\common\anim::addnotetrack_mayhemend("price", "mayhem_end", %est_esc_020_pickup_price_face, "escape_getup");
  scripts\common\anim::addnotetrack_mayhemstart("ally1", "mayhem_partA_start", %est_esc_020_pickup_hadir_parta_face, "escape_getup");
  scripts\common\anim::addnotetrack_mayhemend("ally1", "mayhem_partA_end", %est_esc_020_pickup_hadir_parta_face, "escape_getup");
  scripts\common\anim::addnotetrack_mayhemstart("ally1", "mayhem_partB_start", %est_esc_020_pickup_hadir_partb_face, "escape_getup");
  scripts\common\anim::addnotetrack_mayhemend("ally1", "mayhem_partB_end", %est_esc_020_pickup_hadir_partb_face, "escape_getup");
  scripts\common\anim::addnotetrack_mayhemstart("ally1", "mayhem_partC_start", %est_esc_020_pickup_hadir_partc_face, "escape_getup");
  scripts\common\anim::addnotetrack_mayhemend("ally1", "mayhem_C_end", %est_esc_020_pickup_hadir_partc_face, "escape_getup");
  level.scr_anim["ally1"]["tunnel_approach"] = % est_hf_090_culvert_intro_enter_hadir;
  level.scr_anim["ally1"]["tunnel_approach_idle"][0] = % est_hf_090_culvert_intro_enter_idle_hadir;
  level.scr_anim["ally1"]["tunnel_open"] = % est_hf_090_culvert_intro_scenea_hadir;
  level.scr_anim["ally1"]["tunnel_open_idle"][0] = % est_hf_090_culvert_intro_idlea_hadir;
  level.scr_anim["ally1"]["tunnel_open_idle_nags"][0] = % est_hf_090_culvert_intro_naga_hadir;
  level.scr_anim["price"]["tunnel_open"] = % est_hf_090_culvert_intro_scenea_price;
  level.scr_anim["price"]["tunnel_open_idle"][0] = % est_hf_090_culvert_intro_idlea_price;
  level.scr_anim["price"]["tunnel_open_idle_nags"][0] = % est_hf_090_culvert_intro_naga_price;
  scripts\common\anim::addnotetrack_customfunction("ally1", "tunnel_open", ::tunnel_open, "tunnel_open");
  level.scr_anim["ally1"]["tunnel_enter"] = % est_hf_090_culvert_intro_sceneb_hadir;
  level.scr_anim["ally1"]["tunnel_enter_idle"][0] = % est_hf_090_culvert_intro_idleb_hadir;
  level.scr_anim["ally1"]["tunnel_enter_idle_nags"][0] = % est_hf_090_culvert_intro_nagb_hadir;
  level.scr_anim["price"]["tunnel_enter"] = % est_hf_090_culvert_intro_sceneb_price;
  level.scr_anim["price"]["tunnel_enter_idle"][0] = % est_hf_090_culvert_intro_idleb_price;
  level.scr_anim["price"]["tunnel_enter_idle_nags"][0] = % est_hf_090_culvert_intro_nagb_price;
  scripts\common\anim::addnotetrack_notify("price", "nag", "price_nag", "tunnel_open_idle_nags");
  scripts\common\anim::addnotetrack_notify("price", "nag", "price_nag", "tunnel_enter_idle_nags");
  level.scr_anim["ally1"]["tunnel_collapse"] = % est_hf_090_culvert_intro_scenec_hadir;
  level.scr_anim["price"]["tunnel_collapse"] = % est_hf_090_culvert_intro_scenec_price;
  level.scr_face["ally1"]["dx_vom_had_tunnel_spotted_51"] = % dx_vom_had_tunnel_spotted_51_face;
  level.scr_anim["price"]["arrest_hadir"] = % est_culvert_exfil_price;
  level.scr_anim["ally1"]["arrest_hadir"] = % est_culvert_exfil_hadir;
  scripts\common\anim::addnotetrack_mayhemstart("price", "mayhem_A_start", %est_culvert_exfil_price_a_face, "arrest_hadir");
  scripts\common\anim::addnotetrack_mayhemend("price", "mayhem_A_end", %est_culvert_exfil_price_a_face, "arrest_hadir");
  scripts\common\anim::addnotetrack_mayhemstart("price", "mayhem_B_start", %est_culvert_exfil_price_b_face, "arrest_hadir");
  scripts\common\anim::addnotetrack_mayhemend("price", "mayhem_B_end", %est_culvert_exfil_price_b_face, "arrest_hadir");
  scripts\common\anim::addnotetrack_mayhemstart("ally1", "mayhem_A_start", %est_culvert_exfil_hadir_a_face, "arrest_hadir");
  scripts\common\anim::addnotetrack_mayhemend("ally1", "mayhem_A_end", %est_culvert_exfil_hadir_a_face, "arrest_hadir");
  scripts\common\anim::addnotetrack_mayhemstart("ally1", "mayhem_B_start", %est_culvert_exfil_hadir_b_face, "arrest_hadir");
  scripts\common\anim::addnotetrack_mayhemend("ally1", "mayhem_B_end", %est_culvert_exfil_hadir_b_face, "arrest_hadir");
  level.scr_traverse["traverse_window_in"] = % sdr_com_traverse_jog_vault_over_sm_in_estate;
  level.scr_traverse["traverse_window_out"] = % sdr_com_traverse_jog_vault_over_sm_out_estate;
  level.scr_face["hvt"]["dx_vom_hvt_hvt_bag_85"] = % dx_vom_hvt_hvt_bag_85_face;
  level.scr_face["hvt"]["dx_vom_hvt_hvt_bag_95"] = % dx_vom_hvt_hvt_bag_95_face;
  level.scr_face["hvt"]["dx_vom_hvt_hvt_bag_100"] = % dx_vom_hvt_hvt_bag_100_face;
  level.scr_face["hvt"]["dx_vom_hvt_hvt_bag_120"] = % dx_vom_hvt_hvt_bag_120_face;
  level.scr_face["hvt"]["dx_vom_hvt_hvt_bag_140"] = % dx_vom_hvt_hvt_bag_140_face;
  level.scr_face["hvt"]["dx_vom_hvt_hvt_bag_150"] = % dx_vom_hvt_hvt_bag_150_face;
  level.scr_face["hvt"]["dx_vom_hvt_hvt_bag_160"] = % dx_vom_hvt_hvt_bag_160_face;
  level.scr_face["hvt"]["dx_vom_hvt_hvt_bag_170"] = % dx_vom_hvt_hvt_bag_170_face;
  level.scr_face["hvt"]["dx_vom_hvt_hvt_bag_180"] = % dx_vom_hvt_hvt_bag_180_face;
  level.scr_face["hvt"]["dx_vom_hvt_hvt_bag_190"] = % dx_vom_hvt_hvt_bag_190_face;
  level.scr_face["hvt"]["dx_vom_hvt_hvt_bag_20"] = % dx_vom_hvt_hvt_bag_20_face;
  level.scr_face["hvt"]["dx_vom_hvt_hvt_bag_30"] = % dx_vom_hvt_hvt_bag_30_face;
  level.scr_face["hvt"]["dx_vom_hvt2_hvt_bag_85"] = % dx_vom_hvt2_hvt_bag_85_face;
  level.scr_face["hvt"]["dx_vom_hvt2_hvt_bag_95"] = % dx_vom_hvt2_hvt_bag_95_face;
  level.scr_face["hvt"]["dx_vom_hvt3_hvt_bag_30"] = % dx_vom_hvt3_hvt_bag_30_face;
  level.scr_face["hvt"]["dx_vom_hvt3_hvt_bag_20"] = % dx_vom_hvt3_hvt_bag_20_face;
  level.scr_face["hvt"]["dx_vom_hvt3_hvt_bag_190"] = % dx_vom_hvt3_hvt_bag_190_face;
  level.scr_face["hvt"]["dx_vom_hvt3_hvt_bag_180"] = % dx_vom_hvt3_hvt_bag_180_face;
  level.scr_face["hvt"]["dx_vom_hvt3_hvt_bag_170"] = % dx_vom_hvt3_hvt_bag_170_face;
  level.scr_face["hvt"]["dx_vom_hvt3_hvt_bag_160"] = % dx_vom_hvt3_hvt_bag_160_face;
  level.scr_face["hvt"]["dx_vom_hvt3_hvt_bag_150"] = % dx_vom_hvt3_hvt_bag_150_face;
  level.scr_face["hvt"]["dx_vom_hvt3_hvt_bag_140"] = % dx_vom_hvt3_hvt_bag_140_face;
  level.scr_face["hvt"]["dx_vom_hvt3_hvt_bag_120"] = % dx_vom_hvt3_hvt_bag_120_face;
  level.scr_face["hvt"]["dx_vom_hvt3_hvt_bag_100"] = % dx_vom_hvt3_hvt_bag_100_face;
  level.scr_face["hvt"]["dx_vom_hvt3_hvt_bag_95"] = % dx_vom_hvt3_hvt_bag_95_face;
  level.scr_face["hvt"]["dx_vom_hvt3_hvt_bag_85"] = % dx_vom_hvt3_hvt_bag_85_face;
  level.scr_face["hvt"]["dx_vom_hvt2_hvt_bag_30"] = % dx_vom_hvt2_hvt_bag_30_face;
  level.scr_face["hvt"]["dx_vom_hvt2_hvt_bag_20"] = % dx_vom_hvt2_hvt_bag_20_face;
  level.scr_face["hvt"]["dx_vom_hvt2_hvt_bag_190"] = % dx_vom_hvt2_hvt_bag_190_face;
  level.scr_face["hvt"]["dx_vom_hvt2_hvt_bag_180"] = % dx_vom_hvt2_hvt_bag_180_face;
  level.scr_face["hvt"]["dx_vom_hvt2_hvt_bag_170"] = % dx_vom_hvt2_hvt_bag_170_face;
  level.scr_face["hvt"]["dx_vom_hvt2_hvt_bag_160"] = % dx_vom_hvt2_hvt_bag_160_face;
  level.scr_face["hvt"]["dx_vom_hvt2_hvt_bag_150"] = % dx_vom_hvt2_hvt_bag_150_face;
  level.scr_face["hvt"]["dx_vom_hvt2_hvt_bag_140"] = % dx_vom_hvt2_hvt_bag_140_face;
  level.scr_face["hvt"]["dx_vom_hvt2_hvt_bag_120"] = % dx_vom_hvt2_hvt_bag_120_face;
  level.scr_face["hvt"]["dx_vom_hvt2_hvt_bag_100"] = % dx_vom_hvt2_hvt_bag_100_face;
  level.scr_face["price"]["dx_vom_pri_woods_gate_10"] = % dx_vom_pri_woods_gate_10_face;
  level.scr_face["price"]["dx_vom_pri_woods_gate_20"] = % dx_vom_pri_woods_gate_20_face;
  level.scr_face["price"]["dx_vom_pri_woods_gate_30"] = % dx_vom_pri_woods_gate_30_face;
  level.scr_face["price"]["dx_vom_pri_objroom_exterior_50"] = % dx_vom_pri_objroom_exterior_50_face;
}

no_more_pain(var_0) {
  var_0 scripts\engine\utility::ent_flag_set("first_pain");
}

throwgun(var_0) {
  var_0 thread scripts\common\ai::gun_remove();
  var_1 = self gettagorigin("tag_weapon_right");
  var_2 = self gettagangles("tag_weapon_right");
  var_3 = spawn("weapon_" + createheadicon(self.weapon), var_1);
  var_3.angles = var_2;
  var_4 = anglesToForward(var_0.angles);
  var_4 = var_4 * randomfloatrange(300, 350);
  var_5 = var_4[0];
  var_6 = var_4[1];
  var_7 = randomfloatrange(400, 600);
  var_3 scripts\engine\utility::delaycall(0.1, ::playsound, "est_li_050_fusebox_tuto_price_gundrop_01");
  var_3 physicslaunchserveritem(var_3.origin, (var_5, var_6, var_7));
}

price_use_pistol(var_0) {
  var_0 thread scripts\anim\notetracks.gsc::notetrackguntochest();
  var_0[[var_0.fnplaceweaponon]](var_0.silenced_pistol, "right");
}

price_stop_use_pistol(var_0) {
  var_0 thread scripts\anim\notetracks.gsc::notetrackpistolputaway();
  var_0 thread scripts\anim\notetracks_sp.gsc::notetrackgunhand("right");
}

price_pistol_fire(var_0) {
  level.fusebox_victim.shotsfired++;

  if(level.fusebox_victim.shotsfired < 3)
    level.fusebox_victim playSound("generic_death_enemy_1");

  playFXOnTag(scripts\engine\utility::getfx("vfx_muz_si_pis_w"), level.price, "tag_flash_silenced");
  var_0 thread scripts\anim\notetracks.gsc::notetrackfire();
}

tunnel_open(var_0) {
  var_1 = getEnt("tunnel_clip", "targetname");
  var_1 connectpaths();
  var_1 delete();
  scripts\engine\utility::flag_set("tunnel_open");
}

#using_animtree("script_model");

script_models() {
  level.scr_animtree["gate_chain"] = #animtree;
  level.scr_model["gate_chain"] = "metal_chain_01_locked_animated";
  level.scr_anim["gate_chain"]["infil_gate_cut"] = % est_li_040_chain_chain;
  level.scr_animtree["gate_door"] = #animtree;
  level.scr_model["gate_door"] = "tag_origin";
  level.scr_anim["gate_door"]["infil_gate_cut"] = % est_li_040_chain_gate;
  level.scr_animtree["bolt_cutters"] = #animtree;
  level.scr_model["bolt_cutters"] = "misc_wm_boltcutter";
  level.scr_anim["bolt_cutters"]["infil_gate_arrival"] = % est_li_030_woods_cutters_e;
  level.scr_anim["bolt_cutters"]["infil_gate_idle"][0] = % est_li_040_chain_price_arrival_idle_cutter;
  level.scr_anim["bolt_cutters"]["infil_gate_idle"][1] = % est_li_040_chain_price_arrival_idle_cutter;
  level.scr_anim["bolt_cutters"]["infil_gate_idle_nags"][0] = % est_li_040_chain_price_arrival_nag_cutter;
  level.scr_anim["bolt_cutters"]["infil_gate_idle_nags"][1] = % est_li_040_chain_price_arrival_nag_cutter;
  level.scr_anim["bolt_cutters"]["infil_gate_cut"] = % est_li_040_chain_price_cutter;
  level.scr_anim["gate_door"]["fusebox_tut_owned"] = % est_li_050_fusebox_tuto_door;
  scripts\common\anim::addnotetrack_flag("gate_door", "open", "fusebox_tut_door_open", "fusebox_tut_owned");
  level.scr_animtree["fusebox"] = #animtree;
  level.scr_anim["fusebox"]["fusebox_interact"] = % est_li_050_fusebox_tuto_handle;
  scripts\common\anim::addnotetrack_customfunction("fusebox", "handle_down", scripts\sp\maps\estate\estate_util.gsc::fusebox_handle_down, "fusebox_interact");
  level.scr_animtree["rope"] = #animtree;
  level.scr_model["rope"] = "misc_coiled_rope";
  level.scr_anim["rope"]["fwd_rappel_price_enter"] = % est_li_060_fwd_rappel_price_enter_rope;
  level.scr_anim["rope"]["fwd_rappel_price_enter_idle"][0] = % est_li_060_fwd_rappel_price_enter_idle_rope;
  level.scr_anim["rope"]["fwd_rappel_price_enter_idle_nags"][0] = % est_li_060_fwd_rappel_price_enter_nag_rope;
  level.scr_anim["rope"]["fwd_rappel_price_go"] = % est_li_060_fwd_rappel_price_rope;
  level.scr_anim["rope"]["player_rappel_start"] = % est_li_060_fwd_rappel_coiled_rope;
  level.scr_animtree["player_rope"] = #animtree;
  level.scr_model["player_rope"] = "misc_vm_rapelling_rope";
  level.scr_anim["player_rope"]["player_rappel_start"] = % est_li_060_fwd_rappel_rope;
  level.scr_anim["player_rope"]["player_rappel"] = % est_li_060_fwd_rappel_rope_plr_outro;
  level.scr_animtree["player_rope_throw"] = #animtree;
  level.scr_model["player_rope_throw"] = "misc_vm_rapelling_rope_estate";
  level.scr_anim["player_rope_throw"]["player_rappel_start"] = % misc_vm_rapelling_rope_estate;
  level.scr_animtree["chair"] = #animtree;
  level.scr_model["chair"] = "com_folding_chair";
  level.scr_anim["chair"]["courtyard_interrogation"][0] = % est_cy_051_interrogation_chair_chair;
  level.scr_anim["chair"]["courtyard_interrogation_getup"] = % est_cy_051_interrogation_chair_chair_settle;
  level.scr_anim["chair"]["courtyard_death_backward"] = % est_cy_051_interrogation_chair_chair_death_backwards;
  level.scr_animtree["door"] = #animtree;
  level.scr_anim["door"]["body_drag_door"] = % est_ma_020_body_drag_door;
  level.scr_animtree["dead_guy"] = #animtree;
  level.scr_anim["dead_guy"]["car_rummage_l_death"] = % car_interaction_withbody_l_death_enemy;
  level.scr_anim["dead_guy"]["car_rummage_r_death"] = % car_interaction_withbody_r_death_enemy;
  level.scr_animtree["desk"] = #animtree;
  level.scr_anim["desk"]["search_desk_loop"][0] = % est_search_desk_desk_idle;
  level.scr_animtree["cabinet"] = #animtree;
  level.scr_anim["cabinet"]["search_cabinet_loop"][0] = % est_search_cabinet_cabinet_idle;
  level.scr_animtree["locker"] = #animtree;
  level.scr_anim["locker"]["search_locker_intro"] = % est_search_locker_locker_arrival;
  level.scr_anim["locker"]["search_locker_loop"][0] = % est_search_locker_locker_idle;
  level.scr_anim["locker"]["search_locker_outro"] = % est_search_locker_locker_exit;
  level.scr_animtree["obj_door"] = #animtree;
  level.scr_model["obj_door"] = "tag_origin";
  level.scr_anim["obj_door"]["obj_scene"] = % est_tf_010_meet_hadir_scene_door;
  level.scr_anim["obj_door"]["door_push"] = % est_tf_010_meet_hadir_outro_door;
  level.scr_animtree["obj_plans"] = #animtree;
  level.scr_model["obj_plans"] = "accessory_containertube_mesh_01";
  level.scr_anim["obj_plans"]["obj_scene"] = % est_tf_010_meet_hadir_scene_plans;
  level.scr_animtree["missile"] = #animtree;
  level.scr_model["missile"] = "tag_origin";
  level.scr_anim["missile"]["explosion_fire"] = % est_tf_030_stairs_explosion_missile;
  scripts\common\anim::addnotetrack_notify("missile", "launch", "missile_launch", "explosion_fire");
  level.scr_animtree["stairs_debris_1"] = #animtree;
  level.scr_model["stairs_debris_1"] = "ee_mansion_int_staircase_main_top_dst_p1";
  level.scr_anim["stairs_debris_1"]["explosion_main"] = % est_tf_030_stairs_explosion_debris01;
  level.scr_animtree["stairs_debris_2"] = #animtree;
  level.scr_model["stairs_debris_2"] = "ee_mansion_int_staircase_main_top_dst_p2";
  level.scr_anim["stairs_debris_2"]["explosion_main"] = % est_tf_030_stairs_explosion_debris02;
  level.scr_animtree["stairs_debris_3"] = #animtree;
  level.scr_model["stairs_debris_3"] = "ee_mansion_int_staircase_main_top_dst_p3";
  level.scr_anim["stairs_debris_3"]["explosion_main"] = % est_tf_030_stairs_explosion_debris03;
  level.scr_animtree["stairs_debris_4"] = #animtree;
  level.scr_model["stairs_debris_4"] = "ee_mansion_int_staircase_main_top_dst_p4";
  level.scr_anim["stairs_debris_4"]["explosion_main"] = % est_tf_030_stairs_explosion_debris04;
  level.scr_animtree["stairs_debris_5"] = #animtree;
  level.scr_model["stairs_debris_5"] = "ee_mansion_int_staircase_main_top_dst_p5";
  level.scr_anim["stairs_debris_5"]["explosion_main"] = % est_tf_030_stairs_explosion_debris05;
  level.scr_animtree["stairs_debris_6"] = #animtree;
  level.scr_model["stairs_debris_6"] = "ee_mansion_int_staircase_main_top_dst_p6";
  level.scr_anim["stairs_debris_6"]["explosion_main"] = % est_tf_030_stairs_explosion_debris06;
  level.scr_animtree["stairs_debris_7"] = #animtree;
  level.scr_model["stairs_debris_7"] = "ee_mansion_int_staircase_main_top_dst_p7";
  level.scr_anim["stairs_debris_7"]["explosion_main"] = % est_tf_030_stairs_explosion_debris07;
  level.scr_animtree["stairs_debris_8"] = #animtree;
  level.scr_model["stairs_debris_8"] = "ee_mansion_int_staircase_main_top_dst_p8";
  level.scr_anim["stairs_debris_8"]["explosion_main"] = % est_tf_030_stairs_explosion_debris08;
  level.scr_animtree["stairs_debris_9"] = #animtree;
  level.scr_model["stairs_debris_9"] = "ee_mansion_int_staircase_main_bottom_dst_p1";
  level.scr_anim["stairs_debris_9"]["explosion_main"] = % est_tf_030_stairs_explosion_debris09;
  level.scr_animtree["stairs_debris_10"] = #animtree;
  level.scr_model["stairs_debris_10"] = "ee_mansion_int_staircase_main_bottom_dst_p2";
  level.scr_anim["stairs_debris_10"]["explosion_main"] = % est_tf_030_stairs_explosion_debris10;
  level.scr_animtree["stairs_debris_11"] = #animtree;
  level.scr_model["stairs_debris_11"] = "ee_mansion_int_staircase_main_bottom_dst_p3";
  level.scr_anim["stairs_debris_11"]["explosion_main"] = % est_tf_030_stairs_explosion_debris11;
  level.scr_animtree["stairs_debris_12"] = #animtree;
  level.scr_model["stairs_debris_12"] = "ee_mansion_int_staircase_main_bottom_dst_p4";
  level.scr_anim["stairs_debris_12"]["explosion_main"] = % est_tf_030_stairs_explosion_debris12;
  level.scr_animtree["stairs_debris_13"] = #animtree;
  level.scr_model["stairs_debris_13"] = "ee_mansion_int_staircase_main_bottom_dst_p5";
  level.scr_anim["stairs_debris_13"]["explosion_main"] = % est_tf_030_stairs_explosion_debris13;
  level.scr_animtree["stairs_debris_14"] = #animtree;
  level.scr_model["stairs_debris_14"] = "ee_mansion_int_staircase_main_bottom_dst_p6";
  level.scr_anim["stairs_debris_14"]["explosion_main"] = % est_tf_030_stairs_explosion_debris14;
  level.scr_animtree["getup_debris"] = #animtree;
  level.scr_model["getup_debris"] = "ee_mansion_int_staircase_player_piece_dst_01";
  level.scr_anim["getup_debris"]["escape_getup"] = % est_esc_020_pickup_debris;
  level.scr_animtree["getup_board"] = #animtree;
  level.scr_model["getup_board"] = "ee_mansion_int_staircase_melee_weapon";
  level.scr_anim["getup_board"]["escape_getup"] = % est_esc_020_pickup_board;
  level.scr_animtree["tunnel_gate"] = #animtree;
  level.scr_model["tunnel_gate"] = "tag_origin";
  level.scr_anim["tunnel_gate"]["tunnel_open"] = % est_hf_090_culvert_intro_scenea_door;
  level.scr_anim["bolt_cutters"]["tunnel_open"] = % est_hf_090_culvert_intro_scenea_cutters;
  level.scr_anim["gate_chain"]["tunnel_open"] = % est_hf_090_culvert_intro_scenea_chain;
}

laser_on_then_delete(var_0) {}

#using_animtree("vehicles");

vehicles() {
  level.scr_animtree["technical"] = #animtree;
  level.scr_animtree["turret"] = #animtree;
  level.scr_anim["technical"]["intro"] = % est_li_000_infil_decko;
  level.scr_anim["turret"]["intro"] = % est_li_000_infil_decko_turret;
  level.scr_anim["hind"]["explosion_fire"] = % est_tf_030_stairs_explosion_mindia;
  level.scr_animtree["car"] = #animtree;
  level.scr_anim["car"]["car_rummage_l_intro"] = % car_interaction_withbody_l_intro_car;
  level.scr_anim["car"]["car_rummage_l_idle"][0] = % car_interaction_withbody_l_idle_car;
  level.scr_anim["car"]["car_rummage_l_react"] = % car_interaction_withbody_l_reaction_car;
  level.scr_anim["car"]["car_rummage_l_death"] = % car_interaction_withbody_l_death_car;
  level.scr_goaltime["car"]["car_rummage_l_react"] = 0.2;
  level.scr_anim["car"]["car_rummage_r_intro"] = % car_interaction_withbody_r_intro_car;
  level.scr_anim["car"]["car_rummage_r_idle"][0] = % car_interaction_withbody_r_idle_car;
  level.scr_anim["car"]["car_rummage_r_react"] = % car_interaction_withbody_r_reaction_car;
  level.scr_anim["car"]["car_rummage_r_death"] = % car_interaction_withbody_r_death_car;
  level.scr_goaltime["car"]["car_rummage_r_react"] = 0.2;
}

#using_animtree("scriptables");

scriptables() {
  level.scr_animtree["police_car"] = #animtree;
  level.scr_anim["police_car"]["intro"] = % est_li_000_infil_car;
}