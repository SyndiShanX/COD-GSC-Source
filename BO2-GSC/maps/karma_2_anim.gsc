/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\karma_2_anim.gsc
**************************************/

#include maps\_utility;
#include maps\_dialog;
#include maps\_scene;
#include maps\_anim;
#include maps\karma_util;
#include maps\voice\voice_karma_2;
#include maps\karma_exit_club;
#include maps\createart\karma_2_art;
#include maps\karma_the_end;
#using_animtree("generic_human");

main() {
  maps\voice\voice_karma_2::init_voice();
  fx_anims();
  traversal_anims();
  level.scr_anim["karma"]["defalco_escape_run"] = % ch_karma_11_ending_karma_walk_loop;
  level.scr_anim["defalco"]["defalco_escape_run"] = % ch_karma_11_ending_defalco_walk_loop;
  level.scr_anim["defalco_escort_left"]["defalco_escape_run"] = % ch_karma_11_ending_pmc_walk_loop;
  level.scr_anim["defalco_escort_right"]["defalco_escape_run"] = % ch_karma_11_ending_pmc_walk_loop;
  perk_anims();
  exit_club_anims();
  mall_precache_anims();
  mall_anims();
  the_end_anims();
  precache_assets();
}

#using_animtree("fxanim_props");

fx_anims() {
  level.scr_anim["fxanim_props"]["coco02_tree_a"] = % fxanim_gp_tree_palm_coco02_dest01_sm_anim;
  level.scr_anim["fxanim_props"]["coco02_tree_b"] = % fxanim_gp_tree_palm_coco02_dest02_sm_anim;
}

#using_animtree("animated_props");
#using_animtree("player");
#using_animtree("animated_props");
#using_animtree("player");
#using_animtree("animated_props");

perk_anims() {
  add_scene("intruder", "align_armory_door");
  add_prop_anim("intruder_cutter", % o_specialty_karma_intruder_cutter, "t6_wpn_laser_cutter_prop", 1);
  add_prop_anim("intruder_armory_door", % o_specialty_karma_intruder_door, undefined, 0);
  add_player_anim("player_body", % int_specialty_karma_intruder, 1, 0, undefined, 0);
  add_prop_anim("knuckles", % o_specialty_karma_intruder_knuckles, "t6_wpn_taser_knuckles_prop_view", 1);
  add_prop_anim("filler_knuckles1", % o_specialty_karma_intruder_fillerknuckles1, "t6_wpn_taser_knuckles_prop_view", 0);
  add_prop_anim("filler_knuckles2", % o_specialty_karma_intruder_fillerknuckles2, "t6_wpn_taser_knuckles_prop_view", 0);
  add_prop_anim("filler_knuckles3", % o_specialty_karma_intruder_fillerknuckles3, "t6_wpn_taser_knuckles_prop_view", 0);
  add_prop_anim("filler_knuckles4", % o_specialty_karma_intruder_fillerknuckles4, "t6_wpn_taser_knuckles_prop_view", 0);
  add_notetrack_fx_on_tag("knuckles", "spark_fx", "taser_knuckles", "tag_fx");
  add_notetrack_fx_on_tag("intruder_armory_door", undefined, "intruder_door_sparks_left", "tag_fx1");
  add_notetrack_fx_on_tag("intruder_armory_door", undefined, "intruder_door_sparks_right", "tag_fx");
  add_notetrack_custom_function("intruder_cutter", "zap_start", maps\karma_exit_club::intruder_zap_start);
  add_notetrack_custom_function("intruder_cutter", "zap_end", maps\karma_exit_club::intruder_zap_end);
  add_notetrack_custom_function("intruder_cutter", "start", maps\karma_exit_club::intruder_cutter_on);
  add_scene("intruder_knuckles", "align_armory_door");
  add_prop_anim("knuckles", % o_specialty_karma_intruder_knuckles, "t6_wpn_taser_knuckles_prop_view", 1);
  add_prop_anim("filler_knuckles1", % o_specialty_karma_intruder_fillerknuckles1, "t6_wpn_taser_knuckles_prop_view", 0);
  add_prop_anim("filler_knuckles2", % o_specialty_karma_intruder_fillerknuckles2, "t6_wpn_taser_knuckles_prop_view", 0);
  add_prop_anim("filler_knuckles3", % o_specialty_karma_intruder_fillerknuckles3, "t6_wpn_taser_knuckles_prop_view", 0);
  add_prop_anim("filler_knuckles4", % o_specialty_karma_intruder_fillerknuckles4, "t6_wpn_taser_knuckles_prop_view", 0);
  add_scene("brute", "anim_bruteforce_leftdoor");
  add_prop_anim("bruteforce_jaws", % o_specialty_karma_bruteforce_jaws, "t6_wpn_jaws_of_life_prop", 1, 0, undefined, "tag_origin");
  add_player_anim("player_body", % int_specialty_karma_bruteforce, 1, 0, "tag_origin", 0);
  add_prop_anim("anim_bruteforce_rightdoor", % o_specialty_karma_bruteforce_rightdoor, undefined, 0, 0, undefined, "tag_origin");
  add_prop_anim("anim_bruteforce_leftdoor", % o_specialty_karma_bruteforce_leftdoor, undefined, 0, 0, undefined, "tag_origin");
  add_scene("brute_doors", "anim_bruteforce_leftdoor");
  add_prop_anim("anim_bruteforce_rightdoor", % o_specialty_karma_bruteforce_rightdoor, undefined, 0, 0, undefined, "tag_origin");
  add_prop_anim("anim_bruteforce_leftdoor", % o_specialty_karma_bruteforce_leftdoor, undefined, 0, 0, undefined, "tag_origin");
}

#using_animtree("generic_human");

traversal_anims() {
  level.scr_anim["generic"]["ai_roll_over_84_down_40_l"] = % ai_roll_over_84_down_40_l;
  level.scr_anim["generic"]["ai_roll_over_84_down_40_r"] = % ai_roll_over_84_down_40_r;
  level.scr_anim["generic"]["ai_mantle_over_36_down_154"] = % ai_mantle_over_36_down_154;
  level.scr_anim["generic"]["ai_mantle_over_36_down_154_roll"] = % ai_mantle_over_36_down_154_roll;
  level.scr_anim["generic"]["ai_crawl_under_door"] = % ai_crawl_under_door;
  level.scr_anim["generic"]["ai_roll_under_door"] = % ai_roll_under_door;
  level.scr_anim["generic"]["ai_mantle_over_42_down_74_01"] = % ai_mantle_over_42_down_74_01;
  level.scr_anim["generic"]["ai_mantle_over_42_down_74_02"] = % ai_mantle_over_42_down_74_02;
}

#using_animtree("player");
#using_animtree("generic_human");
#using_animtree("animated_props");
#using_animtree("generic_human");

exit_club_anims() {
  add_scene("intro_explosion_aftermath", "align_door_shove");
  add_player_anim("player_body", % p_karma_7_explosion_aftermath_player, 1, 0, undefined, 1, 1, 20, 20, 10, 10, 1);
  add_notetrack_custom_function("player_body", "dof_salazar_1", maps\createart\karma_2_art::dof_salazar_1);
  add_notetrack_custom_function("player_body", "dof_rubble_2", maps\createart\karma_2_art::dof_rubble_2);
  add_notetrack_custom_function("player_body", "dof_civilian_3", maps\createart\karma_2_art::dof_civilian_3);
  add_notetrack_custom_function("player_body", "dof_guard_4", maps\createart\karma_2_art::dof_guard_4);
  add_actor_anim("harper", % ch_karma_7_explosion_aftermath_harper, 0, 1, 0);
  add_actor_anim("salazar", % ch_karma_7_explosion_aftermath_salazar, 0, 1, 0);
  add_actor_anim("han_ai", % ch_karma_7_explosion_aftermath_guard, 1, 0);
  add_prop_anim("armory_door_right", % o_karma_7_explosion_aftermath_armorydoor, undefined, 0);
  add_prop_anim("intro_double_door_left", % o_karma_7_explosion_aftermath_doubledoor_left, undefined, 0);
  add_scene("aftermath_guard_walktoradio", "align_door_shove");
  add_actor_anim("han_ai", % ch_karma_7_explosion_aftermath_guard_walktoradio, 1, 0);
  add_scene("aftermath_guard_idle", "align_door_shove", 0, 0, 1);
  add_actor_anim("han_ai", % ch_karma_7_explosion_aftermath_guard_idle, 1, 0);
  add_scene("scene_e7_couple_run_to_titanic_area", "boat_escape");
  add_actor_model_anim("e7_couple_run_to_titanic_area_1", % ch_karma_7_2_civs_watch_escape_08a, undefined, undefined, undefined, undefined, "mall_female_dress", 1, 0, 0);
  add_actor_model_anim("e7_couple_run_to_titanic_area_2", % ch_karma_7_2_civs_watch_escape_08b, undefined, undefined, undefined, undefined, "rich_male_1", 1, 0, 0);
  add_scene("scene_e7_couple_run_to_titanic_area_loop", "boat_escape", 0, 0, 1);
  add_actor_model_anim("e7_couple_run_to_titanic_area_1", % ch_karma_7_2_civs_watch_escape_08a_idle, undefined, 1, undefined, undefined, "mall_female_dress", 1, 0, 0);
  add_actor_model_anim("e7_couple_run_to_titanic_area_2", % ch_karma_7_2_civs_watch_escape_08b_idle, undefined, 1, undefined, undefined, "rich_male_1", 1, 0, 0);
  add_scene("scene_e7_couple_a_run_from_mall_to_titanic", "boat_escape");
  add_actor_model_anim("e7_couple_a1_run_from_mall_to_titaic", % ch_karma_7_2_civs_watch_escape_10a, undefined, undefined, undefined, undefined, "mall_female_dress", 1, 0, 0);
  add_actor_model_anim("e7_couple_a2_run_from_mall_to_titaic", % ch_karma_7_2_civs_watch_escape_10b, undefined, undefined, undefined, undefined, "rich_male_2", 1, 0, 0);
  add_scene("scene_e7_couple_a_run_from_mall_to_titanic_loop", "boat_escape", 0, 0, 1);
  add_actor_model_anim("e7_couple_a1_run_from_mall_to_titaic", % ch_karma_7_2_civs_watch_escape_10a_idle, undefined, 1, undefined, undefined, "mall_female_dress", 1, 0, 0);
  add_actor_model_anim("e7_couple_a2_run_from_mall_to_titaic", % ch_karma_7_2_civs_watch_escape_10b_idle, undefined, 1, undefined, undefined, "rich_male_2", 1, 0, 0);
  add_scene("scene_e7_couple_b_run_from_mall_to_titanic", "boat_escape");
  add_actor_model_anim("e7_couple_b1_run_from_mall_to_titaic", % ch_karma_7_2_civs_watch_escape_11a, undefined, undefined, undefined, undefined, "rich_female_1", 1, 0, 0);
  add_actor_model_anim("e7_couple_b2_run_from_mall_to_titaic", % ch_karma_7_2_civs_watch_escape_11b, undefined, undefined, undefined, undefined, "rich_female_1", 1, 0, 0);
  add_scene("scene_e7_couple_b_run_from_mall_to_titanic_loop", "boat_escape", 0, 0, 1);
  add_actor_model_anim("e7_couple_b1_run_from_mall_to_titaic", % ch_karma_7_2_civs_watch_escape_11a_idle, undefined, 1, undefined, undefined, "rich_female_1", 1, 0, 0);
  add_actor_model_anim("e7_couple_b2_run_from_mall_to_titaic", % ch_karma_7_2_civs_watch_escape_11b_idle, undefined, 1, undefined, undefined, "rich_female_1", 1, 0, 0);
  add_scene("scene_e7_wounded_group1", "wounded_civs", 0, 0, 1);
  add_actor_model_anim("e7_wounded_man_1", % ch_karma_7_1_civs_treated_01, undefined, 1, undefined, undefined, "rich_male_2", 1, 0, 0);
  add_actor_model_anim("e7_wounded_woman_1", % ch_karma_7_1_civs_treated_02, undefined, 1, undefined, undefined, "rich_female_shot", 0, 0, 0);
  add_actor_model_anim("e7_wounded_man_2_1", % ch_karma_7_1_civs_treated_03, undefined, 1, undefined, undefined, "rich_male_1", 1, 0, 0);
  add_actor_model_anim("e7_wounded_man_2_2", % ch_karma_7_1_civs_treated_04, undefined, 1, undefined, undefined, "rich_male_shot", 0, 0, 0);
  add_actor_model_anim("e7_wounded_man_3", % ch_karma_7_1_civs_treated_05, undefined, 1, undefined, undefined, "rich_male_shot", 0, 0, 0);
  add_actor_model_anim("e7_wounded_woman_3", % ch_karma_7_1_civs_treated_06, undefined, 1, undefined, undefined, "rich_male_shot", 0, 0, 0);
  add_actor_model_anim("e7_wounded_man_4", % ch_karma_7_1_civs_treated_07, undefined, 1, undefined, undefined, "rich_male_2", 1, 0, 0);
  add_scene("scene_e7_wounded_group2", "wounded_civs", 0, 0, 1);
  add_actor_model_anim("e7_wounded_woman_4", % ch_karma_7_1_civs_treated_08, undefined, 1, undefined, undefined, "rich_female_shot", 0, 1);
  add_actor_model_anim("e7_wounded_man_7", % ch_karma_7_1_civs_treated_13, undefined, 1, undefined, undefined, "rich_male_shot", 1, 0, 0);
  add_actor_model_anim("e7_wounded_woman_7", % ch_karma_7_1_civs_treated_14, undefined, 1, undefined, undefined, "rich_female_1", 1, 0, 0);
  add_scene("scene_e7_doctor_and_nurse_loop", "wounded_civs", 0, 0, 1);
  add_actor_model_anim("e7_doctor", % ch_karma_7_1_civs_treated_doctor, undefined, 1, undefined, undefined, "rich_female_1", 1, 0, 0);
  add_scene("scene_e7_couple_approach_window_part1", "boat_escape");
  add_actor_model_anim("e7_civ1_watch_escape", % ch_karma_7_2_civs_watch_escape_05, undefined, undefined, undefined, undefined, "rich_female_1", 1, 0, 0);
  add_actor_model_anim("e7_civ2_watch_escape", % ch_karma_7_2_civs_watch_escape_06, undefined, undefined, undefined, undefined, "rich_male_shot", 1, 0, 0);
  add_scene("scene_e7_couple_approach_window_part2_loop", "boat_escape", 0, 0, 1);
  add_actor_model_anim("e7_civ1_watch_escape", % ch_karma_7_2_civs_watch_escape_05_idle, undefined, 1, undefined, undefined, "rich_female_1", 1, 0, 0);
  add_actor_model_anim("e7_civ2_watch_escape", % ch_karma_7_2_civs_watch_escape_06_idle, undefined, 1, undefined, undefined, "rich_male_1", 1, 0, 0);
  add_scene("scene_e7_single_approach_window_part1", "boat_escape");
  add_actor_model_anim("e7_civ_approach_window", % ch_karma_7_2_civs_watch_escape_07, undefined, undefined, undefined, undefined, "mall_female_dress", 1, 0, 0);
  add_scene("scene_e7_single_approach_window_part2_loop", "boat_escape", 0, 0, 1);
  add_actor_model_anim("e7_civ_approach_window", % ch_karma_7_2_civs_watch_escape_07_idle, undefined, 1, undefined, undefined, "mall_female_dress", 1, 0, 0);
  add_scene("scene_e7_titanic_moment_docka_loop", "titanic_moment", 0, 0, 1);
  add_cheap_actor_model_anim("evac_docka_civ01", % ch_karma_7_1_evac_docka_civ01, undefined, 1, undefined, undefined, "rich_male_1");
  add_cheap_actor_model_anim("evac_docka_civ02", % ch_karma_7_1_evac_docka_civ02, undefined, 1, undefined, undefined, "rich_male_2");
  add_cheap_actor_model_anim("evac_docka_civ03", % ch_karma_7_1_evac_docka_civ03, undefined, 1, undefined, undefined, "mall_female_dress");
  add_cheap_actor_model_anim("evac_docka_civ04", % ch_karma_7_1_evac_docka_civ04, undefined, 1, undefined, undefined, "rich_female_1");
  add_cheap_actor_model_anim("evac_docka_civ05", % ch_karma_7_1_evac_docka_civ05, undefined, 1, undefined, undefined, "mall_female_dress");
  add_cheap_actor_model_anim("evac_docka_civ06", % ch_karma_7_1_evac_docka_civ06, undefined, 1, undefined, undefined, "rich_male_2");
  add_cheap_actor_model_anim("evac_docka_civ07", % ch_karma_7_1_evac_docka_civ07, undefined, 1, undefined, undefined, "rich_female_2");
  add_cheap_actor_model_anim("evac_docka_civ08", % ch_karma_7_1_evac_docka_civ08, undefined, 1, undefined, undefined, "rich_male_2");
  add_cheap_actor_model_anim("evac_docka_civ09", % ch_karma_7_1_evac_docka_civ09, undefined, 1, undefined, undefined, "rich_female_1");
  add_cheap_actor_model_anim("evac_docka_securityguard", % ch_karma_7_1_evac_docka_securityguard, undefined, 1, undefined, undefined, "han");
  add_scene_custom_function(::dont_auto_delete_scene, "scene_e7_titanic_moment_docka_loop");
  add_scene("scene_e7_titanic_moment_dockb_loop", "titanic_moment", 0, 0, 1);
  add_cheap_actor_model_anim("evac_dockb_civ01", % ch_karma_7_1_civ_evac_dockb_civ_01, undefined, 1, undefined, undefined, "rich_male_1");
  add_cheap_actor_model_anim("evac_dockb_civ02", % ch_karma_7_1_civ_evac_dockb_civ_02, undefined, 1, undefined, undefined, "rich_male_2");
  add_cheap_actor_model_anim("evac_dockb_civ03", % ch_karma_7_1_civ_evac_dockb_civ_03, undefined, 1, undefined, undefined, "mall_female_dress");
  add_cheap_actor_model_anim("evac_dockb_civ04", % ch_karma_7_1_civ_evac_dockb_civ_04, undefined, 1, undefined, undefined, "rich_female_1");
  add_cheap_actor_model_anim("evac_dockb_civ05", % ch_karma_7_1_civ_evac_dockb_civ_05, undefined, 1, undefined, undefined, "rich_male_1");
  add_cheap_actor_model_anim("evac_dockb_civ06", % ch_karma_7_1_civ_evac_dockb_civ_06, undefined, 1, undefined, undefined, "rich_female_2");
  add_cheap_actor_model_anim("evac_dockb_securityguard1", % ch_karma_7_1_civ_evac_dockb_securityguard, undefined, 1, undefined, undefined, "han");
  add_scene_custom_function(::dont_auto_delete_scene, "scene_e7_titanic_moment_dockb_loop");
  add_scene("deathpose1", "deadguy1");
  add_actor_model_anim("deadguy1", % ch_gen_m_floor_armdown_legspread_onback_deathpose, undefined, 0, undefined, undefined, "rich_male_soot", 0, 1);
  add_scene("deathpose2", "deadguy2");
  add_actor_model_anim("deadguy2", % ch_gen_f_floor_onfront_armdown_legstraight_deathpose, undefined, 0, undefined, undefined, "rich_female_soot", 0, 1);
  add_scene("deathpose3", "deadguy3");
  add_actor_model_anim("deadguy3", % ch_gen_m_floor_armstomach_onrightside_deathpose, undefined, 0, undefined, undefined, "rich_male_soot", 0, 1);
  add_scene("deathpose4", "deadguy4");
  add_actor_model_anim("deadguy4", % ch_gen_f_wall_leanleft_armstomach_legstraight_deathpose, undefined, 0, undefined, undefined, "rich_female_soot", 0, 1);
  add_scene("deathpose5", "deadguy5");
  add_actor_model_anim("deadguy5", % ch_gen_m_floor_armdown_onfront_deathpose, undefined, 0, undefined, undefined, "rich_female_soot", 0, 1);
  add_scene("deathpose6", "deadguy6");
  add_actor_model_anim("deadguy6", % ch_gen_m_floor_armover_onrightside_deathpose, undefined, 0, undefined, undefined, "rich_female_soot", 0, 1);
  add_scene("deathpose7", "deadguy7");
  add_actor_model_anim("deadguy7", % ch_gen_m_floor_armover_onrightside_deathpose, undefined, 0, undefined, undefined, "rich_female_soot", 0, 1);
  add_scene("deathpose8", "deadguy8");
  add_actor_model_anim("deadguy8", % ch_gen_m_floor_armdown_onfront_deathpose, undefined, 0, undefined, undefined, "rich_female_soot", 0, 1);
  add_scene("deathpose9", "deadguy9");
  add_actor_model_anim("deadguy9", % ch_gen_m_floor_armover_onrightside_deathpose, undefined, 0, undefined, undefined, "rich_female_soot", 0, 1);
  add_scene("deathpose10", "deadguy10");
  add_actor_model_anim("deadguy10", % ch_gen_m_floor_armdown_onfront_deathpose, undefined, 0, undefined, undefined, "rich_male_shot", 0, 1);
  add_scene("deathpose11", "deadguy11");
  add_actor_model_anim("deadguy11", % ch_gen_m_floor_armover_onrightside_deathpose, undefined, 0, undefined, undefined, "rich_male_soot", 0, 1);
  add_scene_loop("loading_movie_cctv", "align_cctv");
  add_actor_model_anim("karma", % ch_karma_cctv_shoot_guard_karma, undefined, 0, undefined, undefined, undefined, 0, 1);
  add_actor_model_anim("han", % ch_karma_cctv_shoot_guard_guard, undefined, 0, undefined, undefined, undefined, 0, 1);
  add_actor_model_anim("defalco", % ch_karma_cctv_shoot_guard_defalco, undefined, 0, undefined, undefined, undefined, 0, 1);
  add_actor_model_anim("defalco_escort_left", % ch_karma_cctv_shoot_guard_pmc01, undefined, 0, undefined, undefined, undefined, 0, 1);
  add_scene_custom_function(maps\karma_exit_club::init_loading_movie_cctv);
  add_scene_loop("loading_movie_cctv2", "align_cctv2");
  add_actor_model_anim("defalco", % ch_karma_8_pip_exiting_the_mall_defalco, undefined, 0, undefined, undefined, undefined, 0, 1);
  add_actor_model_anim("karma", % ch_karma_8_pip_exiting_the_mall_karma, undefined, 0, undefined, undefined, undefined, 0, 1);
  add_actor_model_anim("defalco_escort_left", % ch_karma_8_pip_exiting_the_mall_pmc01, undefined, 0, undefined, undefined, undefined, 0, 1);
  add_scene_custom_function(maps\karma_exit_club::init_loading_movie_cctv2);
}

#using_animtree("animated_props");
#using_animtree("generic_human");
#using_animtree("animated_props");

mall_precache_anims() {
  add_scene("scene_e8_intro_civ_couple_1", "mall_intro");
  add_actor_model_anim("e7_wounded_man_1", % ch_karma_8_1_upper_level_escape_01, undefined, 1, undefined, undefined, "rich_male", 1, 0, 0);
  add_actor_model_anim("e7_wounded_woman_1", % ch_karma_8_1_upper_level_escape_02, undefined, 1, undefined, undefined, "rich_female", 1, 0, 0);
  add_scene("scene_e8_intro_civ_couple_2", "mall_intro");
  add_actor_model_anim("e7_wounded_man_2", % ch_karma_8_1_upper_level_escape_03, undefined, 1, undefined, undefined, "rich_male", 1, 0, 0);
  add_actor_model_anim("e7_wounded_woman_2", % ch_karma_8_1_upper_level_escape_04, undefined, 1, undefined, undefined, "rich_female", 1, 0, 0);
  add_scene("scene_e8_intro_civ_single_1", "mall_intro");
  add_actor_model_anim("e7_wounded_man_3", % ch_karma_8_1_upper_level_escape_05, undefined, 1, undefined, undefined, "rich_male", 1, 0, 0);
  add_scene("scene_e8_intro_civ_single_2", "mall_intro");
  add_actor_model_anim("e7_wounded_woman_4", % ch_karma_8_1_upper_level_escape_06, undefined, 1, undefined, undefined, "rich_female", 1, 0, 0);
  add_scene("scene_e8_intro_civ_single_3", "mall_intro");
  add_actor_model_anim("e7_wounded_man_4", % ch_karma_8_1_upper_level_escape_07, undefined, 1, undefined, undefined, "rich_male", 1, 0, 0);
  add_scene("terrorist_rappel_left1", "bridge_rappel1", 1);
  add_actor_anim("terrorist_rappel_left1", % ai_rappel_karma_02);
  add_prop_anim("terrorist_rappel_rope_left1", % o_ai_rappel_rope02, "iw_prague_rope_rappel_building");
  add_notetrack_custom_function("terrorist_rappel_left1", "start", ::start_rappel_scene);
  add_notetrack_custom_function("terrorist_rappel_left1", "end", ::end_rappel_scene);
  add_scene("terrorist_rappel_left2", "bridge_rappel2", 1);
  add_actor_anim("terrorist_rappel_left2", % ai_rappel_karma_01);
  add_prop_anim("terrorist_rappel_rope_left4", % o_ai_rappel_rope02, "iw_prague_rope_rappel_building");
  add_notetrack_custom_function("terrorist_rappel_left2", "start", ::start_rappel_scene);
  add_notetrack_custom_function("terrorist_rappel_left2", "end", ::end_rappel_scene);
}

start_rappel_scene(ent) {
  ent.b_rappelling = 1;
}

end_rappel_scene(ent) {
  ent.b_rappelling = undefined;
}

#using_animtree("generic_human");
#using_animtree("player");
#using_animtree("animated_props");
#using_animtree("generic_human");

mall_anims() {
  add_scene("scene_e8_intro_guard1", "mall_intro");
  add_actor_anim("e8_start_anim_guard1", % ch_karma_8_1_karma_dragged_guard1);
  add_scene("scene_e8_intro_guard2", "mall_intro");
  add_actor_anim("e8_start_anim_guard2", % ch_karma_8_1_karma_dragged_guard2);
  add_scene("scene_e8_intro_guard3", "mall_intro");
  add_actor_anim("e8_start_anim_guard3", % ch_karma_8_1_karma_dragged_guard3);
  add_scene("scene_e8_intro_guard4", "mall_intro");
  add_actor_anim("e8_start_anim_guard4", % ch_karma_8_1_karma_dragged_guard4);
  add_scene("scene_event8_door_breach", "gate_lift");
  add_player_anim("player_body", % p_karma_9_1_gate_lift, 1, 0, undefined, 1, 1, 20, 20, 20, 20, 1, 1);
  add_notetrack_custom_function("player_body", "DOF_gatepull", maps\createart\karma_2_art::dof_gatepull);
  add_notetrack_custom_function("player_body", "DOF_civs", maps\createart\karma_2_art::dof_civs);
  add_notetrack_flag("player_body", "start_gatepull", "start_gatepull");
  add_prop_anim("security_gate", % o_karma_9_1_gate_lift, undefined, 0);
  add_scene("scene_event8_door_breach_harper", "gate_lift");
  add_actor_anim("harper", % ch_karma_9_1_gate_lift_harper);
  add_scene("scene_event8_door_breach_salazar", "gate_lift", 1);
  add_actor_anim("salazar", % ch_karma_9_1_gate_lift_salazar_intro);
  add_notetrack_flag("salazar", "start_pull", "scene_event8_door_breach_ready");
  add_scene("scene_event8_door_breach_salazar_idle", "gate_lift", 0, 0, 1);
  add_actor_anim("salazar", % ch_karma_9_1_gate_lift_salazar_idle);
  add_scene("scene_event8_door_breach_salazar_end", "gate_lift");
  add_actor_anim("salazar", % ch_karma_9_1_gate_lift_salazar);
  add_scene("scene_event8_civ_escape1", "gate_lift");
  add_actor_anim("stair_rush_girl_a", % ch_karma_9_1_gate_lift_civ_01, 1, 0, 0, 0, undefined, "rich_female_1");
  add_scene("scene_event8_civ_escape2", "gate_lift");
  add_actor_anim("stair_rush_guy1_a", % ch_karma_9_1_gate_lift_civ_02, 1, 0, 0, 0, undefined, "rich_male_3");
  add_scene("scene_event8_civ_escape3", "gate_lift");
  add_actor_anim("stair_rush_girl_b", % ch_karma_9_1_gate_lift_civ_03, 1, 0, 0, 0, undefined, "rich_female_1");
  add_scene("scene_event8_civ_escape4", "gate_lift");
  add_actor_anim("stair_rush_guy1_b", % ch_karma_9_1_gate_lift_civ_04, 1, 0, 0, 0, undefined, "rich_male_2");
  add_scene("scene_event8_civ_escape5", "gate_lift");
  add_actor_anim("stair_rush_girl_extra1", % ch_karma_9_1_gate_lift_civ_05, 1, 0, 0, 0, undefined, "rich_female_1");
  add_scene("scene_event8_civ_escape6", "gate_lift");
  add_actor_anim("stair_rush_guy2_a", % ch_karma_9_1_gate_lift_civ_06, 1, 0, 0, 0, undefined, "rich_male_1");
  add_scene("scene_event8_civ_escape7", "gate_lift");
  add_actor_anim("stair_rush_guy_extra1", % ch_karma_9_1_gate_lift_civ_07, 1, 0, 0, 0, undefined, "rich_male_2");
  add_scene("scene_event8_civ_escape8", "gate_lift");
  add_actor_anim("stair_rush_guy2_b", % ch_karma_9_1_gate_lift_civ_08, 1, 0, 0, 0, undefined, "rich_male_3");
  add_scene("scene_event8_civ_escape9", "gate_lift");
  add_actor_anim("stair_rush_guy3_b", % ch_karma_9_1_gate_lift_civ_09, 1, 0, 0, 0, undefined, "rich_male");
}

sundeck_anims() {
  add_scene("sundeck_civ_injured_and_helper", "event9_civ_ambient");
  add_actor_anim("civ_female_rich", % ch_karma_9_1_civcouple_helper, 0, 0, 0, 0, undefined, "rich_female_1");
  add_actor_anim("civ_male_rich", % ch_karma_9_1_civcouple_injured, 0, 0, 0, 0, undefined, "rich_male");
  add_scene("sundeck_civ_injured_and_helper_idle", "event9_civ_ambient", 0, 0, 1);
  add_actor_model_anim("civ_female_rich", % ch_karma_9_1_civcouple_helper_idle, undefined, 1, undefined, undefined, "rich_female", 1, 0, 0);
  add_actor_model_anim("civ_male_rich", % ch_karma_9_1_civcouple_injured_idle, undefined, 1, undefined, undefined, "rich_male", 1, 0, 0);
  add_scene("sundeck_rocks_execution", "event9_civ_ambient");
  add_actor_anim("guard_rocks_executioner", % ch_karma_9_1_rockdeath_civ, 0, 0, 0, 0, undefined, "pmc_sniper");
  add_actor_anim("civ_executed_on_rocks", % ch_karma_9_1_rockdeath_enemy, 1, 0, 0, 0, undefined, "security_guard");
  add_scene("scene_civilian_group4_escape_begin_loop", "civi_escape_1", 0, 0, 1);
  add_actor_model_anim("civ_escape_1", % ch_karma_9_1_civ_helper_idle, undefined, 0, undefined, undefined, "rich_male_1", 1, 0, 0);
  add_actor_model_anim("civ_escape_2", % ch_karma_9_1_civ_hurryup_idle, undefined, 0, undefined, undefined, "rich_female_1", 1, 0, 0);
  add_actor_model_anim("civ_escape_3", % ch_karma_9_1_civ_injured_idle, undefined, 0, undefined, undefined, "rich_male_2", 1, 0, 0);
  add_actor_model_anim("civ_escape_4", % ch_karma_9_1_civ_labored_idle, undefined, 0, undefined, undefined, "rich_female_2", 1, 0, 0);
  add_scene("scene_civilian_group4_escape_running", "civi_escape_1");
  add_actor_model_anim("civ_escape_1", % ch_karma_9_1_civ_helper_escape, undefined, 0, undefined, undefined, "rich_male_1", 1, 0, 0);
  add_actor_model_anim("civ_escape_2", % ch_karma_9_1_civ_hurryup_escape, undefined, 0, undefined, undefined, "rich_female_1", 1, 0, 0);
  add_actor_model_anim("civ_escape_3", % ch_karma_9_1_civ_injured_escape, undefined, 0, undefined, undefined, "rich_male_2", 1, 0, 0);
  add_actor_model_anim("civ_escape_4", % ch_karma_9_1_civ_labored_escape, undefined, 0, undefined, undefined, "rich_female_2", 1, 0, 0);
  add_scene("scene_civilian_group4_escape_end_loop", "civi_escape_1", 0, 0, 1);
  add_actor_model_anim("civ_escape_1", % ch_karma_9_1_civ_helper_escape_idle, undefined, 1, undefined, undefined, "rich_male_1", 1, 0, 0);
  add_actor_model_anim("civ_escape_2", % ch_karma_9_1_civ_hurryup_escape_idle, undefined, 1, undefined, undefined, "rich_female_1", 1, 0, 0);
  add_actor_model_anim("civ_escape_3", % ch_karma_9_1_civ_injured_escape_idle, undefined, 1, undefined, undefined, "rich_male_2", 1, 0, 0);
  add_actor_model_anim("civ_escape_4", % ch_karma_9_1_civ_labored_escape_idle, undefined, 1, undefined, undefined, "rich_female_2", 1, 0, 0);
  add_scene("scene_civilian_left_stairs_group1_begin_loop", "crazed_civilians", 0, 0, 1);
  add_optional_actor_anim("civ_left_stairs_male_1", % ch_karma_9_2_escalator_civ_a1_start_idl);
  add_optional_actor_anim("civ_left_stairs_female_1", % ch_karma_9_2_escalator_civ_a2_start_idl);
  add_notetrack_custom_function("civ_left_stairs_male_1", undefined, ::auto_delete_anim_func);
  add_notetrack_custom_function("civ_left_stairs_female_1", undefined, ::auto_delete_anim_func);
  add_notetrack_custom_function("civ_left_stairs_male_1", undefined, ::take_player_damage_only_anim_func);
  add_notetrack_custom_function("civ_left_stairs_female_1", undefined, ::take_player_damage_only_anim_func);
  add_scene("scene_civilian_left_stairs_group1_run", "crazed_civilians");
  add_optional_actor_anim("civ_left_stairs_male_1", % ch_karma_9_2_escalator_civ_a1_run2base);
  add_optional_actor_anim("civ_left_stairs_female_1", % ch_karma_9_2_escalator_civ_a2_run2base);
  add_scene("scene_civilian_left_stairs_group1_begin_loop_mid", "crazed_civilians", 0, 0, 1);
  add_optional_actor_anim("civ_left_stairs_male_1", % ch_karma_9_2_escalator_civ_a1_base_idl);
  add_optional_actor_anim("civ_left_stairs_female_1", % ch_karma_9_2_escalator_civ_a2_base_idl);
  add_scene("scene_civilian_left_stairs_group1_run_and_exit", "crazed_civilians");
  add_optional_actor_anim("civ_left_stairs_male_1", % ch_karma_9_2_escalator_civ_a1_run_escalator);
  add_optional_actor_anim("civ_left_stairs_female_1", % ch_karma_9_2_escalator_civ_a2_run_escalator);
  add_scene("scene_civilian_left_stairs_group2_begin_loop", "crazed_civilians", 0, 0, 1);
  add_optional_actor_anim("civ_left_stairs_male_2", % ch_karma_9_2_escalator_civ_b1_start_idl);
  add_optional_actor_anim("civ_left_stairs_female_2", % ch_karma_9_2_escalator_civ_b2_start_idl);
  add_notetrack_custom_function("civ_left_stairs_male_2", undefined, ::auto_delete_anim_func);
  add_notetrack_custom_function("civ_left_stairs_female_2", undefined, ::auto_delete_anim_func);
  add_notetrack_custom_function("civ_left_stairs_male_2", undefined, ::take_player_damage_only_anim_func);
  add_notetrack_custom_function("civ_left_stairs_female_2", undefined, ::take_player_damage_only_anim_func);
  add_scene("scene_civilian_left_stairs_group2_run", "crazed_civilians");
  add_optional_actor_anim("civ_left_stairs_male_2", % ch_karma_9_2_escalator_civ_b1_run2base);
  add_optional_actor_anim("civ_left_stairs_female_2", % ch_karma_9_2_escalator_civ_b2_run2base);
  add_scene("scene_civilian_left_stairs_group2_begin_loop_mid", "crazed_civilians", 0, 0, 1);
  add_optional_actor_anim("civ_left_stairs_male_2", % ch_karma_9_2_escalator_civ_b1_base_idl);
  add_optional_actor_anim("civ_left_stairs_female_2", % ch_karma_9_2_escalator_civ_b2_base_idl);
  add_scene("scene_civilian_left_stairs_group2_run_and_exit", "crazed_civilians");
  add_optional_actor_anim("civ_left_stairs_male_2", % ch_karma_9_2_escalator_civ_b1_run_escalator);
  add_optional_actor_anim("civ_left_stairs_female_2", % ch_karma_9_2_escalator_civ_b2_run_escalator);
  add_scene("scene_e9_start_balcony_fling", "courtyard_civ_escape_mall");
  add_actor_anim("balcony_fight_fling_enemy", % ch_karma_9_1_balcony_fling_enemy, 0, 0, 0, 0, undefined, "pmc_shotgun");
  add_actor_model_anim("balcony_fight_fling_friendly", % ch_karma_9_1_balcony_fling_security, undefined, 0, undefined, undefined, "security_guard");
  add_scene_custom_function(::add_effect_to_ent_when_stops_falling, 1, "balcony_fight_fling_friendly_drone", level._effect["balcony_death_blood_splat"], 2);
  add_scene("scene_e9_balcony_blowup_stairs_stumble", "event9_corner_bldg");
  add_actor_anim("civ_left_balcony_blowup_stairs_stumble_1", % ch_karma_9_2_helicopter_balcony_b_guard01, undefined, undefined, undefined, undefined, undefined, "pmc_shotgun");
  add_actor_anim("civ_left_balcony_blowup_stairs_stumble_2", % ch_karma_9_2_helicopter_balcony_b_guard02, undefined, undefined, undefined, undefined, undefined, "pmc_assault");
  precache_assets(1);
}

#using_animtree("player");
#using_animtree("vehicles");
#using_animtree("generic_human");
#using_animtree("player");
#using_animtree("generic_human");

the_end_anims() {
  add_scene("defalco_escape_cower_karma", undefined, 0, 0, 1, 1);
  add_actor_anim("karma", % ch_karma_11_ending_karma_cower_loop, 1);
  add_scene("defalco_dead_ending", "new_ending");
  add_actor_model_anim("defalco", % ch_karma_10_3_defalco_dead_ending_defalco);
  add_actor_model_anim("karma", % ch_karma_10_3_defalco_dead_ending_karma);
  add_actor_anim("harper", % ch_karma_10_3_defalco_dead_ending_harper);
  add_actor_anim("salazar", % ch_karma_10_3_defalco_dead_ending_salazar);
  add_player_anim("player_body", % p_karma_10_3_defalco_dead_ending_player, 1, 0, undefined, 1, 1, 30, 30, 30, 30, 1, 1, 0);
  add_vehicle_anim("defalco_osprey", % v_karma_10_3_defalco_dead_ending_vtol);
  add_notetrack_level_notify("player_body", "fade_out", "start_fadeout");
  add_scene("escape_ending", "defalco_osprey");
  add_vehicle_anim("defalco_osprey", % v_karma_10_3_escape_ending_vtol_doors, 0, undefined, undefined, 0);
  add_actor_anim("defalco", % ch_karma_10_3_escape_ending_defalco, 0, 0, 1, 1, "tag_body");
  add_actor_anim("karma", % ch_karma_10_3_escape_ending_karma, 0, 0, 1, 1, "tag_body");
  add_actor_anim("defalco_escort_left2", % ch_karma_10_3_escape_ending_pmc01, 0, 0, 1, 1, "tag_body", "defalco_escort_left");
  add_scene_custom_function(maps\karma_the_end::do_vtol_escape);
  add_scene("escape_ending_player", "new_ending");
  add_player_anim("player_body", % p_karma_10_3_escape_ending_player, 1, 0, undefined, 1, 1, 30, 30, 30, 30, 1, 1, 0);
  add_actor_anim("harper", % ch_karma_10_3_escape_ending_harper);
  add_actor_anim("salazar", % ch_karma_10_3_escape_ending_salazar);
  add_notetrack_custom_function("player_body", "start_fade", maps\karma_the_end::defalco_escape_end_mission);
}

vo_escape_start_player() {
  e_farid = level.player;
  e_harper = get_ent("harper_ai", "targetname", 1);
  e_player = level.player;
  e_farid say_dialog("fari_whatever_attack_cord_0");
  e_harper say_dialog("harp_he_s_right_section_0");
  e_player say_dialog("sect_you_take_the_guards_0", 0.5);
  e_harper say_dialog("harp_just_try_not_to_kill_0", 0.5);
}