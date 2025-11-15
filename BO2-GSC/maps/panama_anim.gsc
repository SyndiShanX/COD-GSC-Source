/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\panama_anim.gsc
**************************************/

#include maps\_utility;
#include maps\_scene;
#include maps\voice\voice_panama;
#include maps\createart\panama_art;
#include maps\panama_house;
#include maps\panama_airfield;
#include maps\panama_amb;
#include maps\panama_motel;

main() {
  maps\voice\voice_panama::init_voice();
  setup_generic_anims();
  patroller_anims();
  house_anims();
  airfield_anims();
  motel_anims();
  precache_assets();
}

#using_animtree("generic_human");

setup_generic_anims() {
  level.scr_anim["generic"]["jump_down_174"] = % ai_jump_down_174;
  level.scr_anim["generic"]["mantle_over_36_across_56"] = % ai_mantle_over_36_across_56;
}

#using_animtree("animated_props");
#using_animtree("vehicles");
#using_animtree("player");
#using_animtree("generic_human");
#using_animtree("animated_props");
#using_animtree("generic_human");
#using_animtree("vehicles");
#using_animtree("generic_human");
#using_animtree("vehicles");
#using_animtree("animated_props");
#using_animtree("generic_human");
#using_animtree("animated_props");
#using_animtree("generic_human");
#using_animtree("animated_props");
#using_animtree("generic_human");
#using_animtree("animated_props");
#using_animtree("generic_human");
#using_animtree("animated_props");
#using_animtree("player");
#using_animtree("generic_human");
#using_animtree("animated_props");
#using_animtree("generic_human");
#using_animtree("animated_props");
#using_animtree("generic_human");
#using_animtree("animated_props");
#using_animtree("generic_human");
#using_animtree("animated_props");
#using_animtree("generic_human");
#using_animtree("animated_props");
#using_animtree("generic_human");
#using_animtree("animated_props");
#using_animtree("vehicles");
#using_animtree("player");
#using_animtree("animated_props");
#using_animtree("generic_human");
#using_animtree("vehicles");
#using_animtree("generic_human");
#using_animtree("animated_props");
#using_animtree("generic_human");
#using_animtree("animated_props");
#using_animtree("generic_human");
#using_animtree("animated_props");
#using_animtree("player");
#using_animtree("animated_props");
#using_animtree("generic_human");
#using_animtree("animated_props");

house_anims() {
  b_do_delete = 1;
  n_player_number = 0;
  str_tag = undefined;
  b_do_delta = 1;
  n_view_fraction = 0;
  n_right_arc = 30;
  n_left_arc = 30;
  n_top_arc = 15;
  n_bottom_arc = 15;
  b_use_tag_angles = 1;
  add_scene("civ_idle_1", "civ_1_idle_struct", 0, 0, 1);
  add_actor_anim("intro_civ_idle_1", % ch_karma_2_1_tarmac_worker_03_idle, 1, 0, 1);
  add_scene("civ_idle_2", undefined, 0, 0, 1, 1);
  add_actor_anim("intro_civ_idle_2", % ch_karma_2_cafe_window_guy01, 1, 0, 1);
  add_scene("civ_idle_3", undefined, 0, 0, 1, 1);
  add_actor_anim("intro_civ_idle_3", % ch_karma_2_cafe_window_girl03, 1, 0, 1);
  add_scene("civ_idle_4", undefined, 0, 0, 1, 1);
  add_actor_anim("intro_civ_idle_4", % ch_karma_2_cafe_window_girl01, 1, 0, 1);
  add_scene("civ_idle_5", undefined, 0, 0, 1, 1);
  add_actor_anim("intro_civ_idle_5", % ch_karma_2_cafe_window_girl03, 1, 0, 1);
  add_scene("gringo_driveby", "pan_truck");
  add_actor_anim("gringo_guy_1", % ch_pan_01_01_intro_truck_passenger_01, 1, 0, 1, 1, "tag_origin");
  add_actor_anim("gringo_guy_2", % ch_pan_01_01_intro_truck_passenger_02, 1, 0, 1, 1, "tag_origin");
  add_actor_anim("gringo_driver", % ch_pan_01_01_intro_truck_driver, 1, 0, 1, 1, "tag_origin");
  add_scene("player_exits_hummer", "front_yard_align");
  add_prop_anim("player_hat", % o_pan_01_01_intro_hat, "c_usa_milcas_woods_cap", 1);
  add_vehicle_anim("player_hummer", % v_pan_01_01_intro_out_of_hummer_hum1);
  add_player_anim("player_body", % p_pan_01_01_intro_grab_hat, 1);
  add_notetrack_custom_function("player_body", "DOF_intro", maps\createart\panama_art::dof_intro);
  add_notetrack_custom_function("player_body", "DOF_grabHat", maps\createart\panama_art::dof_grab_hat);
  add_notetrack_custom_function("player_body", "DOF_closeDoor", maps\createart\panama_art::dof_close_door);
  add_notetrack_custom_function("player_body", "DOF_reflection", maps\createart\panama_art::dof_reflection);
  add_scene("player_exits_hummer_xcam", "front_yard_align_extracam");
  add_actor_model_anim("reflection_woods", % p_pan_01_01_intro_grab_hat_reflection, "c_usa_milcas_woods_fb", 1);
  add_prop_anim("player_hat_xcam", % o_pan_01_01_intro_hat_reflection, "c_usa_milcas_woods_cap", 1);
  add_prop_anim("player_hummer_xcam", % v_pan_01_01_intro_out_of_hummer_hum1, "veh_iw_humvee_camo", 1);
  add_scene("mason_sits_hummer", "front_yard_align", 0, 0, 1);
  add_actor_anim("mason", % ch_pan_01_01_intro_frontyard_idle_mason, 1);
  add_vehicle_anim("mason_hummer", % v_pan_01_01_intro_frontyard_idle_humvee);
  add_scene("mason_greets_mcknight", "front_yard_align");
  add_actor_anim("mason", % ch_pan_01_01_intro_frontyard_mason);
  add_actor_anim("skinner", % ch_pan_01_01_intro_frontyard_mcknight, 1);
  add_notetrack_custom_function("skinner", "start_inside_house_vo", maps\panama_house::mcknight_close_the_door_argument_vo);
  add_vehicle_anim("mason_hummer", % v_pan_01_01_intro_frontyard_humvee);
  add_prop_anim("m_front_door", % o_pan_01_01_intro_frontyard_door, undefined, 0, 1);
  add_prop_anim("mason_hat", % o_pan_01_01_intro_frontyard_hat, "c_usa_milcas_mason_cap");
  add_notetrack_custom_function("mason", "attach_hat", ::attach_masons_hat);
  add_scene("mason_wait_gate", "front_yard_align", 0, 0, 1);
  add_actor_anim("mason", % ch_pan_01_02_intro_gate_wait_mason);
  add_scene("front_gate", "front_yard_align");
  add_prop_anim("m_front_gate", % o_pan_01_03_intro_backyard_enter_gate, undefined, 0, 1);
  add_scene("squad_to_backyard", "front_yard_align");
  add_actor_anim("mason", % ch_pan_01_03_intro_backyard_enter_mason);
  add_notetrack_custom_function("mason", "beer_fx", ::play_bear_fx);
  add_actor_anim("skinner", % ch_pan_01_03_intro_backyard_enter_mcknight);
  add_prop_anim("beer", % o_pan_01_03_intro_backyard_enter_beer, "p6_anim_beer_pack");
  add_scene("wait_table_nag", "front_yard_align");
  add_actor_anim("mason", % ch_pan_01_04_intro_backyard_wait_mason);
  add_actor_anim("skinner", % ch_pan_01_04_intro_backyard_wait_mcknight);
  add_prop_anim("beer", % o_pan_01_04_intro_backyard_wait_beer, "p6_anim_beer_pack");
  add_scene("wait_table", "front_yard_align", 0, 0, 1);
  add_actor_anim("mason", % ch_pan_01_04_intro_backyard_wait_mason);
  add_actor_anim("skinner", % ch_pan_01_04_intro_backyard_wait_mcknight_idle2);
  add_prop_anim("beer", % o_pan_01_04_intro_backyard_wait_beer, "p6_anim_beer_pack");
  add_scene("get_bag", "front_yard_align");
  add_player_anim("player_body", % ch_pan_01_05_intro_get_bag_player, 1, 0, undefined, 1, 0.5, 15, 15, 15, 15);
  add_notetrack_custom_function("player_body", "dof_shed_open", maps\createart\panama_art::dof_shed_open);
  add_notetrack_custom_function("player_body", "dof_mirror", maps\createart\panama_art::dof_mirror);
  add_notetrack_custom_function("player_body", "dof_look_at_guys1", maps\createart\panama_art::dof_look_at_guys1);
  add_notetrack_custom_function("player_body", "dof_look_at_bag1", maps\createart\panama_art::dof_look_at_bag1);
  add_notetrack_custom_function("player_body", "dof_look_at_guys2", maps\createart\panama_art::dof_look_at_guys2);
  add_actor_anim("mason", % ch_pan_01_05_intro_get_bag_mason);
  add_actor_anim("skinner", % ch_pan_01_05_intro_get_bag_mcknight);
  add_prop_anim("beer", % o_pan_01_05_intro_get_bag_beer, "p6_anim_beer_pack");
  add_prop_anim("bag", % o_pan_01_05_intro_get_bag_duffle, "p6_anim_duffle_bag", 1);
  add_prop_anim("pajamas", % o_pan_01_05_intro_get_bag_pajamas, "p6_anim_cloth_pajamas", 1);
  add_prop_anim("coke_1", % o_pan_01_05_intro_get_bag_coke01, "p6_anim_cocaine", 1);
  add_prop_anim("coke_2", % o_pan_01_05_intro_get_bag_cocaine02, "p6_anim_cocaine", 1);
  add_scene("get_bag_door", "front_yard_align");
  add_prop_anim("m_shed_door_right", % o_pan_01_05_intro_get_bag_door, undefined, 0, 1);
  add_scene("reflection_woods_grabs_bag", "front_yard_align_extracam");
  add_actor_model_anim("reflection_woods", % ch_pan_01_05_intro_get_bag_player_reflection, "c_usa_milcas_woods_fb", 1);
  add_prop_anim("reflection_bag", % o_pan_01_01_intro_get_bag_mirrorbag, "p6_anim_duffle_bag", 1);
  add_prop_anim("player_hat_xcam", % o_pan_01_05_intro_get_bag_hat_reflection, "c_usa_milcas_woods_cap", 1);
  add_scene("reflection_woods_grabs_bag_door", "front_yard_align_extracam");
  add_prop_anim("m_mirrored_shed_door", % o_pan_01_05_intro_get_bag_door_reflection, "p6_shed_door_right", 0, 1);
  add_scene("leave_table", "front_yard_align");
  add_actor_anim("mason", % ch_pan_01_06_intro_backyard_leave_mason);
  add_actor_anim("skinner", % ch_pan_01_06_intro_backyard_leave_mcknight);
  add_prop_anim("beer", % o_pan_01_06_intro_backyard_leave_beer, "p6_anim_beer_pack");
  add_scene("leave_table_wait", "front_yard_align", 0, 0, 1);
  add_actor_anim("mason", % ch_pan_01_07_intro_backyard_leave_wait_mason);
  add_actor_anim("skinner", % ch_pan_01_07_intro_backyard_leave_wait_mcknight_idle2);
  add_prop_anim("beer", % o_pan_01_07_intro_backyard_leave_wait_beer, "p6_anim_beer_pack");
  add_scene("leave_table_wait_VO", "front_yard_align");
  add_actor_anim("mason", % ch_pan_01_07_intro_backyard_leave_wait_mason);
  add_actor_anim("skinner", % ch_pan_01_07_intro_backyard_leave_wait_mcknight);
  add_prop_anim("beer", % o_pan_01_07_intro_backyard_leave_wait_beer, "p6_anim_beer_pack");
  add_scene("player_outro", "front_yard_align");
  add_actor_anim("mason", % ch_pan_01_07_gringos_mason, 1, 0, 1);
  add_actor_anim("skinner", % ch_pan_01_07_gringos_mcknight, 1, 0, 1);
  add_actor_anim("gringo_guy_1", % ch_pan_01_07_gringos_backguy1, 1, 0, 1);
  add_actor_anim("gringo_guy_2", % ch_pan_01_07_gringos_backguy2, 1, 0, 1);
  add_actor_anim("gringo_driver", % ch_pan_01_07_gringos_driver, 1, 0, 1);
  add_actor_anim("gringo_passenger", % ch_pan_01_07_gringos_passenger, 1, 0, 1);
  add_actor_anim("gringo_tagger", % ch_pan_01_07_gringos_tagger, 1, 0, 1);
  add_prop_anim("beer", % o_pan_01_07_gringos_beer, "p6_anim_beer_pack");
  add_prop_anim("mcknight_beer", % o_pan_01_07_gringos_beer_can, "p6_anim_beer_can");
  add_vehicle_anim("vh_panamanian_jeep", % v_pan_01_07_gringos_truck, 1, "tag_trunk");
  add_vehicle_anim("mason_hummer", % v_pan_01_07_gringos_humvee);
  add_player_anim("player_body", % ch_pan_01_07_gringos_player, 1, 0, undefined, 1, 1, 30, 30, 30, 30);
  add_notetrack_custom_function("skinner", "detach_beer_can", ::beer_can_notetrack);
  add_notetrack_custom_function("player_body", "dof_kid", maps\createart\panama_art::dof_kid);
  add_notetrack_custom_function("player_body", "dof_mkcnight_mason", maps\createart\panama_art::dof_mkcnight_mason);
  add_notetrack_custom_function("player_body", "dof_humvee", maps\createart\panama_art::dof_humvee);
  add_notetrack_level_notify("vh_panamanian_jeep", "start_flag", "start_flag");
  add_scene("masons_beer_loop", "front_yard_align", 0, 0, 1);
  add_prop_anim("mason_beer", % o_pan_01_06_intro_backyard_leave_beer_can01_loop, "p6_anim_beer_can");
  add_scene("outro_back_gate", "front_yard_align");
  add_prop_anim("m_back_gate", % o_pan_01_01_intro_end_gate_b, undefined, 0, 1);
  add_scene("house_end_flag", "vh_panamanian_jeep");
  add_prop_anim("truck_flag", % fxanim_panama_truck_flag_anim, "fxanim_panama_truck_flag_mod", 1, 0, undefined, "tag_origin");
  add_scene("mason_exits_hummer", "front_yard_align");
  add_actor_anim("mason", % ch_pan_01_01_intro_out_of_hummer_mason, 1);
  add_notetrack_custom_function("mason", "start_frontdoor_skinner", maps\panama_house::skinner_wave_us_back);
  add_scene("mason_hummer", "front_yard_align");
  add_vehicle_anim("mason_hummer", % v_pan_01_01_intro_out_of_hummer_hum2);
  add_scene("skinner_jane_argue_loop", "front_yard_align", 0, 0, 1);
  add_actor_anim("jane", % ch_pan_01_01_intro_argue_idle_jane, 1);
  add_actor_anim("skinner", % ch_pan_01_01_intro_argue_idle_skinner, 1);
  add_scene("skinner_waves_us_back", "front_yard_align");
  add_actor_anim("jane", % ch_pan_01_01_intro_frontdoor_jane, 1, 0, 1);
  add_actor_anim("skinner", % ch_pan_01_01_intro_frontdoor_skinner, 1);
  add_scene("house_front_door", "front_yard_align");
  add_prop_anim("m_front_door", % o_pan_01_01_intro_frontdoor_frontdoor, undefined, 0, 1);
  add_scene("mason_gate_loop", "front_yard_align", 0, 0, 1);
  add_actor_anim("mason", % ch_pan_01_01_intro_gate_idle_mason, 1);
  add_scene("backyard_walk", "front_yard_align");
  add_actor_anim("mason", % ch_pan_01_01_intro_tobackyard_mason, 1);
  add_actor_anim("skinner", % ch_pan_01_01_intro_tobackyard_skinner, 1);
  add_prop_anim("beer", % o_pan_01_01_intro_tobackyard_beer, "p6_anim_beer_pack");
  add_scene("house_front_gate", "front_yard_align");
  add_prop_anim("m_front_gate", % o_pan_01_01_intro_tobackyard_gate_a, undefined, 0, 1);
  add_scene("beer_loop", "front_yard_align", 0, 0, 1);
  add_actor_anim("mason", % ch_pan_01_01_intro_drinking_idle_mason, 1);
  add_actor_anim("skinner", % ch_pan_01_01_intro_drinking_idle_skinner, 1);
  add_prop_anim("beer", % o_pan_01_01_intro_drinking_idle_beer, "p6_anim_beer_pack");
  add_scene("player_grabs_bag", "front_yard_align");
  add_prop_anim("bag", % o_pan_01_01_intro_get_bag_bag, "p6_anim_duffle_bag", 1);
  add_prop_anim("pajamas", % o_pan_01_01_intro_get_bag_pajamas, "p6_anim_cloth_pajamas", 1);
  add_prop_anim("coke_1", % o_pan_01_01_intro_get_bag_coke1, "p6_anim_cocaine", 1);
  add_prop_anim("coke_2", % o_pan_01_01_intro_get_bag_coke2, "p6_anim_cocaine", 1);
  add_player_anim("player_body", % p_pan_01_01_intro_get_bag_player, 1);
  add_scene("shed_door", "front_yard_align");
  add_prop_anim("m_shed_door_right", % o_pan_01_01_intro_get_bag_shed_door, undefined, 0, 1);
  add_scene("bag_anim", "front_yard_align");
  add_actor_anim("mason", % ch_pan_01_01_intro_get_bag_mason, 1);
  add_actor_anim("skinner", % ch_pan_01_01_intro_get_bag_skinner, 1);
  add_prop_anim("beer", % o_pan_01_01_intro_get_bag_beer, "p6_anim_beer_pack");
}

beer_can_notetrack(guy) {
  level.mcknight detach("p6_anim_beer_can", "tag_weapon_left");
  beer_can = get_model_or_models_from_scene("player_outro", "beer");
  beer_can show();
}

play_bear_fx(guy) {
  bear_can_loc = level.mason gettagorigin("tag_weapon_left");
  bear_can_angles = level.mason gettagangles("tag_weapon_left");
  level.mason play_fx("fx_prop_beer_open", bear_can_loc, bear_can_angles, undefined, 1, "tag_weapon_left");
}

anim_seals_on_zodiac(player) {
  end_scene("zodiac_approach_seals");
  level thread run_scene("zodiac_approach_seals_turn");
  scene_wait("zodiac_approach_seals_turn");
  level thread run_scene("zodiac_approach_seals");
}

#using_animtree("generic_human");
#using_animtree("player");
#using_animtree("animated_props");
#using_animtree("generic_human");
#using_animtree("animated_props");
#using_animtree("generic_human");
#using_animtree("animated_props");
#using_animtree("generic_human");
#using_animtree("player");
#using_animtree("animated_props");
#using_animtree("player");
#using_animtree("generic_human");
#using_animtree("animated_props");
#using_animtree("generic_human");
#using_animtree("animated_props");
#using_animtree("generic_human");
#using_animtree("animated_props");
#using_animtree("generic_human");
#using_animtree("animated_props");
#using_animtree("generic_human");
#using_animtree("animated_props");
#using_animtree("generic_human");
#using_animtree("animated_props");
#using_animtree("generic_human");
#using_animtree("animated_props");
#using_animtree("generic_human");
#using_animtree("animated_props");
#using_animtree("generic_human");
#using_animtree("animated_props");
#using_animtree("player");
#using_animtree("animated_props");
#using_animtree("player");
#using_animtree("generic_human");
#using_animtree("animated_props");
#using_animtree("generic_human");
#using_animtree("animated_props");
#using_animtree("player");
#using_animtree("animated_props");
#using_animtree("vehicles");
#using_animtree("generic_human");

airfield_anims() {
  add_scene("zodiac_approach_boat", "boat_landing_align_temp");
  add_prop_anim("m_intro_zodiac_player", % o_pan_02_01_beach_approach_zodiac);
  add_notetrack_custom_function("m_intro_zodiac_player", "underwater_in", ::underwater_snapshot_on);
  add_notetrack_custom_function("m_intro_zodiac_player", "underwater_out", ::underwater_snapshot_off);
  add_scene("zodiac_leaves_beach", "boat_landing_align_temp");
  add_prop_anim("m_intro_zodiac_player", % v_pan_02_01_zodiac_leavesbeach_zodiac, undefined, 1);
  add_scene("zodiac_approach_seals", "m_intro_zodiac_player", 0, 0, 1);
  add_actor_model_anim("ai_zodiac_seal_1", % ch_pan_02_01_beach_approach_seal_1_cycle, undefined, 0, "origin_animate_jnt");
  add_actor_model_anim("ai_zodiac_seal_3", % ch_pan_02_01_beach_approach_seal_3_cycle, undefined, 0, "origin_animate_jnt");
  add_scene("zodiac_approach_seals2", "m_intro_zodiac_player", 0, 0, 1);
  add_actor_model_anim("ai_zodiac_seal_2", % ch_pan_02_01_beach_approach_seal_2_cycle, undefined, 0, "origin_animate_jnt");
  add_scene("zodiac_approach_seals_turn", "m_intro_zodiac_player");
  add_actor_model_anim("ai_zodiac_seal_1", % ch_pan_02_01_beach_approach_seal_1_turn, undefined, 0, "origin_animate_jnt");
  add_actor_model_anim("ai_zodiac_seal_3", % ch_pan_02_01_beach_approach_seal_3_turn, undefined, 0, "origin_animate_jnt");
  add_scene("zodiac_approach_mason", "m_intro_zodiac_player");
  add_actor_anim("mason", % ch_pan_02_01_beach_approach_mason, 1, 1, 0, 0, "origin_animate_jnt");
  add_scene("zodiac_dismount_mason", "boat_landing_align_temp");
  add_actor_anim("mason", % ch_pan_02_01_beach_approach_mason_dismount);
  add_scene("zodiac_approach_player", "m_intro_zodiac_player");
  b_do_delete = 1;
  n_player_number = 0;
  str_tag = "origin_animate_jnt";
  b_do_delta = 1;
  n_view_fraction = 0;
  n_right_arc = 80;
  n_left_arc = 50;
  n_top_arc = 15;
  n_bottom_arc = 10;
  b_use_tag_angles = 1;
  add_player_anim("player_body", % p_pan_02_01_beach_approach_player, b_do_delete, n_player_number, str_tag, b_do_delta, n_view_fraction, n_right_arc, n_left_arc, n_top_arc, n_bottom_arc, b_use_tag_angles);
  add_notetrack_custom_function("player_body", "start_turn", ::anim_seals_on_zodiac);
  add_scene("zodiac_dismount_player", "boat_landing_align_temp");
  add_player_anim("player_body", % p_pan_02_01_beach_approach_player_dismount, 1, n_player_number, undefined, b_do_delta, n_view_fraction, 30, 30, 30, 30);
  add_scene("zodiac_approach_seal_boat_1", "boat_landing_align_temp");
  add_prop_anim("m_intro_zodiac_1", % o_pan_02_01_beach_approach_zodiac_1);
  add_scene("zodiac_approach_seal_group_1", "m_intro_zodiac_1", 0, 0, 1);
  add_actor_anim("ai_zodiac_boat_1_seal_1", % ch_pan_02_01_zodiac_crew_idle_1, 1, 1, 1, 1, "origin_animate_jnt");
  add_actor_anim("ai_zodiac_boat_1_seal_2", % ch_pan_02_01_zodiac_crew_idle_2, 1, 1, 1, 1, "origin_animate_jnt");
  add_actor_anim("ai_zodiac_boat_1_seal_3", % ch_pan_02_01_zodiac_crew_idle_3, 1, 1, 1, 1, "origin_animate_jnt");
  add_actor_anim("ai_zodiac_boat_1_seal_4", % ch_pan_02_01_zodiac_crew_idle_4, 1, 1, 1, 1, "origin_animate_jnt");
  add_actor_anim("ai_zodiac_boat_1_seal_5", % ch_pan_02_01_zodiac_crew_idle_5, 1, 1, 1, 1, "origin_animate_jnt");
  add_actor_anim("ai_zodiac_boat_1_seal_6", % ch_pan_02_01_zodiac_crew_idle_6, 1, 1, 1, 1, "origin_animate_jnt");
  add_scene("zodiac_approach_seal_boat_2", "boat_landing_align_temp");
  add_prop_anim("m_intro_zodiac_2", % o_pan_02_01_beach_approach_zodiac_2);
  add_scene("zodiac_approach_seal_group_2", "m_intro_zodiac_2", 0, 0, 1);
  add_actor_anim("ai_zodiac_boat_2_seal_1", % ch_pan_02_01_zodiac_crew_idle_1, 1, 1, 1, 1, "origin_animate_jnt");
  add_actor_anim("ai_zodiac_boat_2_seal_2", % ch_pan_02_01_zodiac_crew_idle_2, 1, 1, 1, 1, "origin_animate_jnt");
  add_actor_anim("ai_zodiac_boat_2_seal_3", % ch_pan_02_01_zodiac_crew_idle_3, 1, 1, 1, 1, "origin_animate_jnt");
  add_actor_anim("ai_zodiac_boat_2_seal_4", % ch_pan_02_01_zodiac_crew_idle_4, 1, 1, 1, 1, "origin_animate_jnt");
  add_actor_anim("ai_zodiac_boat_2_seal_5", % ch_pan_02_01_zodiac_crew_idle_5, 1, 1, 1, 1, "origin_animate_jnt");
  add_actor_anim("ai_zodiac_boat_2_seal_6", % ch_pan_02_01_zodiac_crew_idle_6, 1, 1, 1, 1, "origin_animate_jnt");
  add_scene("zodiac_approach_seal_boat_3", "boat_landing_align_temp");
  add_prop_anim("m_intro_zodiac_3", % o_pan_02_01_beach_approach_zodiac_3);
  add_scene("zodiac_approach_seal_group_3", "m_intro_zodiac_3", 0, 0, 1);
  add_actor_anim("ai_zodiac_boat_3_seal_1", % ch_pan_02_01_zodiac_crew_idle_1, 1, 1, 1, 1, "origin_animate_jnt");
  add_actor_anim("ai_zodiac_boat_3_seal_2", % ch_pan_02_01_zodiac_crew_idle_2, 1, 1, 1, 1, "origin_animate_jnt");
  add_actor_anim("ai_zodiac_boat_3_seal_3", % ch_pan_02_01_zodiac_crew_idle_3, 1, 1, 1, 1, "origin_animate_jnt");
  add_actor_anim("ai_zodiac_boat_3_seal_4", % ch_pan_02_01_zodiac_crew_idle_4, 1, 1, 1, 1, "origin_animate_jnt");
  add_actor_anim("ai_zodiac_boat_3_seal_5", % ch_pan_02_01_zodiac_crew_idle_5, 1, 1, 1, 1, "origin_animate_jnt");
  add_actor_anim("ai_zodiac_boat_3_seal_6", % ch_pan_02_01_zodiac_crew_idle_6, 1, 1, 1, 1, "origin_animate_jnt");
  add_scene("player_climbs_up", "first_blood_align");
  b_do_delete = 0;
  n_player_number = 0;
  str_tag = undefined;
  b_do_delta = 1;
  n_view_fraction = 0;
  n_right_arc = 30;
  n_left_arc = 30;
  n_top_arc = 15;
  n_bottom_arc = 15;
  b_use_tag_angles = 1;
  add_player_anim("player_body", % p_pan_02_03_guards_player_in, b_do_delete, n_player_number, str_tag, b_do_delta, n_view_fraction, n_right_arc, n_left_arc, n_top_arc, n_bottom_arc, b_use_tag_angles);
  add_notetrack_attach("player_body", "start_player", "t5_weapon_sog_knife_viewmodel", "tag_weapon");
  add_scene("player_knife_kill", "first_blood_align");
  b_do_delete = 1;
  n_player_number = 0;
  str_tag = undefined;
  b_do_delta = 1;
  n_view_fraction = 0;
  n_right_arc = 30;
  n_left_arc = 30;
  n_top_arc = 15;
  n_bottom_arc = 15;
  b_use_tag_angles = 1;
  add_player_anim("player_body", % p_pan_02_03_guards_player_kills, b_do_delete, n_player_number, str_tag, b_do_delta, n_view_fraction, n_right_arc, n_left_arc, n_top_arc, n_bottom_arc, b_use_tag_angles);
  add_prop_anim("player_knife", % o_pan_02_03_guards_player_kills_knife, "t6_wpn_knife_sog_prop_view", 1);
  add_notetrack_custom_function("player_knife", "knife_hit", ::knife_throw_blood);
  add_scene("player_knife_no_kill", "first_blood_align");
  b_do_delete = 1;
  n_player_number = 0;
  str_tag = undefined;
  b_do_delta = 1;
  n_view_fraction = 0;
  n_right_arc = 30;
  n_left_arc = 30;
  n_top_arc = 15;
  n_bottom_arc = 15;
  b_use_tag_angles = 1;
  add_player_anim("player_body", % p_pan_02_03_guards_player_no_kill, b_do_delete, n_player_number, str_tag, b_do_delta, n_view_fraction, n_right_arc, n_left_arc, n_top_arc, n_bottom_arc, b_use_tag_angles);
  add_scene("player_melee_whistle", "first_blood_align");
  b_do_delete = 0;
  n_player_number = 0;
  str_tag = undefined;
  b_do_delta = 1;
  n_view_fraction = 0;
  n_right_arc = 30;
  n_left_arc = 30;
  n_top_arc = 15;
  n_bottom_arc = 15;
  b_use_tag_angles = 1;
  add_player_anim("player_body", % p_pan_02_03_guards_player_wistle, b_do_delete, n_player_number, str_tag, b_do_delta, n_view_fraction, n_right_arc, n_left_arc, n_top_arc, n_bottom_arc, b_use_tag_angles);
  add_scene("guard_03_in", "first_blood_align");
  add_actor_anim("guard_3", % ch_pan_02_03_guards_gaurd_in);
  add_scene("guard_03_kill", "first_blood_align");
  add_actor_anim("guard_3", % ch_pan_02_03_guards_gaurd_03_killed);
  add_notetrack_custom_function("guard_3", "stab_effect", ::mason_knife_blood);
  add_scene("flare_guy_walkout", "first_blood_align");
  add_actor_anim("flare_guy", % ch_pan_02_03_guards_flareguy_walkout, 1);
  add_prop_anim("flare_gun", % o_pan_02_03_guards_flaregun_walkout, "t6_wpn_flare_gun_prop");
  add_notetrack_custom_function("flare_guy", "show_prompt", maps\panama_airfield::knife_throw_prompt);
  add_scene("flare_guy_killed", "first_blood_align");
  add_actor_anim("flare_guy", % ch_pan_02_03_guards_flareguy_killed, 1);
  add_prop_anim("flare_gun", % o_pan_02_03_guards_flaregun_killed, "t6_wpn_flare_gun_prop", 1);
  add_notetrack_custom_function("flare_gun", "bang", maps\panama_airfield::flare_guy_killed_flare);
  add_scene("flare_guy_lives", "first_blood_align");
  add_actor_anim("flare_guy", % ch_pan_02_03_guards_flareguy_notkilled, 1, 1);
  add_prop_anim("flare_gun", % o_pan_02_03_guards_flaregun_not_killed, "t6_wpn_flare_gun_prop", 1);
  add_notetrack_custom_function("flare_gun", "bang", maps\panama_airfield::flare_guy_lives_flare);
  add_scene("mason_drain_approach", "first_blood_align", 1);
  add_actor_anim("mason", % ch_pan_02_03_guards_mason_approach_sewer);
  add_scene("mason_drain_walks2back", "first_blood_align");
  add_actor_anim("mason", % ch_pan_02_03_guards_mason_approach_sewer_walks2back);
  add_scene("mason_drain_loop", "first_blood_align", 0, 0, 1);
  add_actor_anim("mason", % ch_pan_02_03_guards_mason_approach_sewer_loop);
  add_scene("mason_melee_kill", "first_blood_align");
  add_actor_anim("mason", % ch_pan_02_03_guards_mason_kills);
  add_prop_anim("mason_knife", % o_pan_02_03_guards_mason_kills_knife, "t6_wpn_knife_sog_prop_view", 1);
  add_scene("car_slide", "car_slide_align");
  add_actor_anim("car_slide", % ai_slide_across_car);
  add_scene("dive_over", "dive_over_align");
  add_actor_anim("window_table_flip", % ai_dive_over_40);
  add_scene("window_mantle", "window_mantle_align");
  add_actor_anim("window_mantle", % ai_mantle_window_36_run);
  add_scene("window_dive", "window_dive_align");
  add_actor_anim("window_dive", % ai_mantle_window_dive_36);
  add_scene("table_flip_open_ai", "table_flip_open_align", 1);
  add_actor_anim("window_table_flip", % ch_la_06_02_plaza_table_flip_guy_02);
  add_scene("table_flip_open_table", "table_flip_open_align");
  add_prop_anim("window_table", % o_la_06_02_plaza_table_flip_table_02, "p6_patio_table_teak", 0, 1);
  add_scene("table_flip_hall_ai", "table_flip_hall_align", 1);
  add_actor_anim("window_table_flip", % ch_la_06_02_plaza_table_flip_guy_02);
  add_scene("table_flip_hall_table", "table_flip_hall_align");
  add_prop_anim("table_flip_table", % o_la_06_02_plaza_table_flip_table_02, "p6_patio_table_teak", 0, 1);
  add_scene("seal_encounter_mason", "mason_hangar", 1);
  add_actor_anim("mason", % ch_pan_02_07_seal_encounter_mason);
  add_notetrack_custom_function("mason", "flash_light", ::flashlight_mason);
  add_notetrack_custom_function("mason", "lock_break", ::lockbreak_mason);
  add_scene("seal_encounter_seals", "mason_hangar");
  add_actor_anim("seal_encounter_1", % ch_pan_02_07_seal_encounter_seal_01, 0, 0, 1);
  add_actor_anim("seal_encounter_2", % ch_pan_02_07_seal_encounter_seal_02, 0, 0, 1);
  add_notetrack_custom_function("seal_encounter_1", "flash_light", ::flashlight_seal);
  add_scene("seal_encounter_gate", "mason_hangar");
  add_prop_anim("hanger_gate", % o_pan_02_07_seal_encounter_door);
  add_scene("rooftop_slide_1", "hangar_roof", 1);
  add_actor_anim("slide_guy_1", % ch_pan_02_08_rooftop_slide_guy01);
  add_scene("rooftop_slide_2", "hangar_roof", 1);
  add_actor_anim("slide_guy_2", % ch_pan_02_08_rooftop_slide_guy02);
  add_scene("seal_standoff_loop", undefined, 0, 0, 1, 1);
  add_actor_anim("seal_1", % ch_pan_02_07_golf_team_guy_01);
  add_actor_anim("seal_2", % ch_pan_02_07_golf_team_guy_02);
  add_actor_anim("seal_3", % ch_pan_02_07_golf_team_guy_03);
  add_actor_anim("seal_4", % ch_pan_02_07_golf_team_guy_04);
  add_actor_anim("seal_5", % ch_pan_02_07_golf_team_guy_05);
  add_actor_anim("seal_6", % ch_pan_02_07_golf_team_guy_06);
  add_scene("mason_skylight_approach", "hangar_roof", 1);
  add_actor_anim("mason", % ch_pan_02_08_skylight_approach_mason);
  add_scene("mason_skylight_loop", "hangar_roof", 0, 0, 1);
  add_actor_anim("mason", % ch_pan_02_08_skylight_loop_mason);
  add_scene("mason_skylight_jump_in", "hangar_roof");
  add_actor_anim("mason", % ch_pan_02_08_skylight_entry_mason);
  add_prop_anim("skylight_door", % o_pan_02_08_skylight_entry_door);
  add_scene("mason_hangar_door_kick", "hangar_doorkick_align", 1);
  add_actor_anim("mason", % ch_pan_02_09_door_kick_mason);
  add_scene("hangar_door", "hangar_doorkick_align");
  add_prop_anim("hangar_door_mason", % ch_pan_02_09_door_kick_door, undefined, 0, 1);
  add_notetrack_level_notify("hangar_door_mason", "kick", "open_hangar_door");
  add_scene("lock_breaker", "control_room_door");
  add_prop_anim("lock_pick", % o_specialty_panama_lockbreaker_device, "t6_wpn_lock_pick_view", 1);
  add_player_anim("player_body", % int_specialty_panama_lockbreaker, 1);
  add_prop_anim("jacket", % o_specialty_panama_lockbreaker_vestgrab_vest, "p6_anim_flak_jacket", 1);
  add_notetrack_custom_function("player_body", "door_open", maps\panama_airfield::hangar_intruder_door_open);
  add_scene("lock_breaker_door", "control_room_door");
  add_prop_anim("control_room_door", % o_specialty_panama_lockbreaker_door_open);
  add_scene("intruder", "intruder_box");
  add_prop_anim("boltcutter", % o_specialty_panama_intruder_boltcutter, "t6_wpn_boltcutters_prop_view", 1);
  add_prop_anim("nightingale", % o_specialty_panama_intruder_grabbed_nightingale, "t5_weapon_nightingale_world", 1);
  add_prop_anim("nightingale_2", % o_specialty_panama_intruder_grabbed_nightingale_2, "t5_weapon_nightingale_world", 1);
  add_prop_anim("intruder_box", % o_specialty_panama_intruder_strongbox);
  add_player_anim("player_body", % int_specialty_panama_intruder, 1);
  add_scene("seal_group_1_hangar_entry", "seal_standoff");
  add_actor_anim("seal_guy_1", % ch_pan_02_11_seal_hangar_entry_seal01, 0, 1, 0, 1);
  add_actor_anim("seal_guy_2", % ch_pan_02_11_seal_hangar_entry_seal02, 0, 1, 0, 1);
  add_scene("seal_group_2_hangar_entry", "seal_standoff");
  add_actor_anim("seal_guy_3", % ch_pan_02_11_seal_hangar_entry_seal03, 0, 1, 0, 1);
  add_actor_anim("seal_guy_4", % ch_pan_02_11_seal_hangar_entry_seal04, 0, 1, 0, 1);
  add_scene("learjet_battle_pdf", "learjet_battle");
  add_actor_anim("lj_battle_pdf", % ch_pan_02_12_leerjet_battle_pdf);
  add_scene("learjet_battle_seal", "learjet_battle");
  add_actor_anim("lj_battle_seal", % ch_pan_02_12_leerjet_battle_seal, 0, 0, 1);
  add_scene("seal_rocket", "learjet_battle");
  add_actor_anim("lj_seal_rocket", % ch_pan_02_12_leerjet_battle_seal_rocket, 0, 0, 1, 1);
  add_scene("mason_shoulder_bash", "motel_path_bash", 1);
  add_actor_anim("mason", % ch_pan_02_12_door_bash_mason);
  add_scene("mason_shoulder_bash_door", "motel_path_bash");
  add_prop_anim("bash_door", % o_pan_02_12_door_bash_door, undefined, 0, 1);
  add_scene("pdf_shoulder_bash", "motel_path_bash");
  add_actor_anim("pdf_shoulder_bash", % ch_pan_02_12_door_close_pdf, 0, 0, 1, 1);
  add_prop_anim("bash_door", % o_pan_02_12_door_close_door, "p_rus_door_white_60", 0, 1);
  add_scene("player_door_kick", "player_door_kick_align");
  add_player_anim("player_body", % int_player_kick, 1);
  add_scene("player_door_kick_door", "motel_path_bash");
  add_prop_anim("bash_door", % o_panama_player_kick_door, undefined, 0, 1);
  add_scene("learjet_explosion", "vh_lear_jet");
  add_vehicle_anim("vh_lear_jet", % fxanim_panama_private_jet_anim);
  add_scene("pool_guy_1", "pool_death");
  add_actor_anim("pool_guy_1", % ch_pan_02_12_pool_death_guy_1, 0, 0, 0, 1);
  add_notetrack_custom_function("pool_guy_1", "fire", maps\panama_airfield::shoot_pool_guy_1);
  add_scene("pool_guy_2", "pool_death", 1);
  add_actor_anim("pool_guy_2", % ch_pan_02_12_pool_death_guy_2);
  add_notetrack_custom_function("pool_guy_2", "fire", maps\panama_airfield::shoot_pool_guy_2);
  add_scene("rolling_door_guy", "rollup_door");
  add_actor_anim("rolling_door_guy", % ch_pan_02_12_rolling_door_guy_1);
  add_scene("rolling_door_guy_2", "rollup_door");
  add_actor_anim("rolling_door_guy_2", % ch_pan_02_12_rolling_door_guy_2);
  add_scene("learjet_back_door_kick", "learjet_back_door_kick_align");
  add_actor_anim("learjet_back_door_kick_pdf", % ch_pan_02_09_door_kick_mason);
  add_notetrack_custom_function("learjet_back_door_kick_pdf", "door_hit", maps\panama_airfield::learjet_back_door_open);
  add_scene("seal_breach_1", "door_breach_align_1", 1);
  add_actor_anim("door_breach_a_1", % ch_pan_02_11_seals_breaching_guy01);
  add_actor_anim("door_breach_a_2", % ch_pan_02_11_seals_breaching_guy02);
  add_notetrack_custom_function("door_breach_a_1", "door_open", maps\panama_airfield::seal_breach_door_open);
}

play_scene_flare_guy_killed(guy) {
  run_scene("flare_guy_killed");
}

mason_knife_blood(guy) {
  guard = getent("mason_kill_guard_ai", "targetname");
  tag_origin = guard gettagorigin("J_neck");
  tag_angles = guard gettagangles("J_neck");
  guard play_fx("blood_knife_throw", tag_origin, tag_angles, undefined, 1, "J_neck");
}

knife_throw_blood(guy) {
  flare_guy = getent("flare_guy_ai", "targetname");
  tag_origin = flare_guy gettagorigin("J_spine4");
  tag_angles = flare_guy gettagangles("J_spine4");
  flare_guy play_fx("blood_knife_throw", tag_origin, tag_angles, undefined, 1, "J_spine4");
}

flashlight_mason(mason) {
  level.mason play_fx("mason_flashlight", level.mason.origin, undefined, 0.1, 1, "tag_weapon_left");
  wait 0.3;
  level.mason play_fx("mason_flashlight", level.mason.origin, undefined, 0.1, 1, "tag_weapon_left");
}

flashlight_seal(seal) {
  seal play_fx("mason_flashlight", seal.origin, undefined, 0.1, 1, "tag_weapon_left");
  wait 0.3;
  seal play_fx("mason_flashlight", seal.origin, undefined, 0.1, 1, "tag_weapon_left");
  wait 0.3;
  seal play_fx("mason_flashlight", seal.origin, undefined, 0.1, 1, "tag_weapon_left");
}

lockbreak_mason(mason) {
  exploder(251);
  lock = getent("pad_lock_mason", "targetname");
  lock delete();
}

patroller_anims() {
  level.scr_anim["generic"]["bored_idle"][0] = % patrol_bored_idle;
  level.scr_anim["generic"]["patrol_walk"] = % patrol_bored_patrolwalk;
  level.scr_anim["generic"]["smoke_idle"][0] = % patrol_bored_idle_smoke;
  level.scr_anim["generic"]["exchange_surprise_0"] = % exposed_idle_reacta;
  level.scr_anim["generic"]["exchange_surprise_1"] = % exposed_idle_reactb;
  level.scr_anim["generic"]["exchange_surprise_2"] = % exposed_idle_twitch;
  level.scr_anim["generic"]["exchange_surprise_3"] = % exposed_idle_twitch_v4;
  level.surprise_anims = 4;
}

#using_animtree("animated_props");
#using_animtree("generic_human");
#using_animtree("animated_props");
#using_animtree("player");
#using_animtree("generic_human");
#using_animtree("animated_props");
#using_animtree("player");

motel_anims() {
  add_scene("dead_civ_1", undefined, 0, 0, 0, 1);
  add_actor_model_anim("dead_civ_1", % ch_gen_m_floor_armup_legaskew_onfront_faceleft_deathpose);
  add_scene("dead_civ_2", undefined, 0, 0, 0, 1);
  add_actor_model_anim("dead_civ_2", % ch_gen_m_ledge_armhanging_faceright_onfront_deathpose);
  add_scene("dead_civ_3", undefined, 0, 0, 0, 1);
  add_actor_model_anim("dead_civ_3", % ch_gen_f_floor_onrightside_armstretched_legcurled_deathpose);
  add_scene("dead_civ_4", undefined, 0, 0, 0, 1);
  add_actor_model_anim("dead_civ_4", % ch_gen_f_floor_onfront_armup_legcurled_deathpose);
  add_scene("motel_approach", "motel_room", 1);
  add_actor_anim("mason", % ch_pan_03_01_noriegas_room_approach_mason);
  add_scene("motel_approach_loop", "motel_room", 0, 0, 1);
  add_actor_anim("mason", % ch_pan_03_01_noriegas_room_approach_mason_loop);
  add_scene("motel_door", "motel_room");
  add_prop_anim("hotel_door", % o_pan_03_01_noriegas_room_breach_door, undefined, 0, 1);
  add_scene("motel_chair", "motel_room");
  add_prop_anim("chair", % o_pan_03_01_noriegas_room_chair, "p6_chair_wood_hotel", 0, 1);
  add_scene("motel_breach", "motel_room");
  add_actor_anim("thug_1", % ch_pan_03_01_noriegas_room_breach_guy01, 1, 0, 0, 1);
  add_actor_anim("thug_2", % ch_pan_03_01_noriegas_room_breach_guy02, 1, 0, 0, 1);
  add_actor_anim("thug_3", % ch_pan_03_01_noriegas_room_breach_guy03, 1, 0, 0, 1);
  add_actor_anim("mason", % ch_pan_03_01_noriegas_room_breach_mason);
  add_actor_anim("noriega", % ch_pan_03_01_noriegas_room_breach_noriega, 1);
  add_prop_anim("flash_bang", % o_pan_03_01_noriegas_room_breach_flashbang, "t6_wpn_grenade_flash_prop_view");
  add_player_anim("player_body", % ch_pan_03_01_noriegas_room_breach_player, 0, 0, undefined, 1, 1, 15, 15, 20, 0);
  add_notetrack_custom_function("player_body", "dof_kill_men", maps\createart\panama_art::dof_kill_men);
  add_notetrack_custom_function("player_body", "dof_tv_smash", maps\createart\panama_art::dof_tv_smash);
  add_notetrack_custom_function("player_body", "sndChangeMusicState", maps\panama_amb::sndchangemotelmusicstate);
  add_notetrack_custom_function("thug_3", "tv_smash", maps\panama_motel::motel_tv_swap);
  add_notetrack_custom_function("thug_3", "blood", ::thug_3_blood);
  add_notetrack_exploder("thug_3", "tv_smash", 302);
  add_scene("motel_scene", "motel_room");
  add_actor_anim("mason", % ch_pan_03_01_noriegas_room_mason);
  add_actor_anim("noriega", % ch_pan_03_01_noriegas_room_noriega, 1);
  add_prop_anim("duffle_bag", % o_pan_03_01_noriegas_room_bag, "p6_anim_duffle_bag");
  add_prop_anim("cocaine_1", % o_pan_03_01_noriegas_room_cocaine01, "p6_anim_cocaine");
  add_prop_anim("cocaine_2", % o_pan_03_01_noriegas_room_cocaine02, "p6_anim_cocaine");
  add_prop_anim("pajamas", % o_pan_03_01_noriegas_room_pajamas, "p6_anim_cloth_pajamas");
  add_player_anim("player_body", % ch_pan_03_01_noriegas_room_player, 1, 0, undefined, 1, 1, 15, 15, 20, 0);
  add_notetrack_custom_function("player_body", "dof_throw_bag", maps\createart\panama_art::dof_throw_bag);
  add_notetrack_custom_function("player_body", "dof_point_gun", maps\createart\panama_art::dof_point_gun);
  add_notetrack_custom_function("player_body", "dof_mason_bag_empty", maps\createart\panama_art::dof_mason_bag_empty);
  add_notetrack_custom_function("player_body", "dof_hit_noriega", maps\createart\panama_art::dof_hit_noriega);
  add_notetrack_custom_function("player_body", "dof_grab_chair", maps\createart\panama_art::dof_grab_chair);
  add_notetrack_custom_function("player_body", "dof_grab_noriega", maps\createart\panama_art::dof_grab_noriega);
  add_notetrack_custom_function("player_body", "dof_shove_noriega", maps\createart\panama_art::dof_shove_noriega);
  add_notetrack_custom_function("player_body", "dof_mason_gun_at_noriega", maps\createart\panama_art::dof_mason_gun_at_noriega);
  add_notetrack_custom_function("player_body", "dof_walk_out", maps\createart\panama_art::dof_walk_out);
  add_notetrack_custom_function("mason", "condition_mason", maps\panama_motel::motel_vo_nicaragua);
  add_notetrack_custom_function("player_body", "gun_raise", maps\panama_motel::gun_raise);
  add_notetrack_custom_function("player_body", "gun_lower", maps\panama_motel::gun_lower);
  add_notetrack_custom_function("player_body", "condition_mason", maps\panama_motel::motel_vo_nicaragua);
  add_notetrack_custom_function("player_body", "condition_woods", maps\panama_motel::motel_vo_afghanistan);
  add_notetrack_custom_function("player_body", "fade_out_condition_all_intel", maps\panama_motel::next_mission);
  add_notetrack_custom_function("player_body", "fade_out_condition_woods", maps\panama_motel::fade_out_one_intel);
  add_notetrack_custom_function("player_body", "fade_out_condition_normal", maps\panama_motel::fade_out_no_intel);
  add_notetrack_custom_function("noriega", "blood", ::noriega_blood);
}

thug_3_blood(guy) {
  settimescale(0.4);
  thug_3 = getent("thug_3_ai", "targetname");
  tag_origin = thug_3 gettagorigin("J_Head");
  tag_angles = thug_3 gettagangles("J_Head");
  thug_3 play_fx("motel_blood_punch", tag_origin, tag_angles, undefined, 1, "J_Head");
  wait 0.5;
  settimescale(1.0);
}

noriega_blood(guy) {
  noriega = getent("noriega_ai", "targetname");
  tag_origin = noriega gettagorigin("J_head");
  tag_angles = noriega gettagangles("J_head");
  noriega play_fx("noriega_punched_blood", tag_origin, tag_angles, undefined, 1, "J_head");
}

attach_masons_hat() {
  mason = getent("ai_mason_casual_ai", "targetname");
  mason attach("c_usa_milcas_mason_cap");
  hat = get_model_or_models_from_scene("mason_greets_mcknight", "mason_hat");
  hat delete();
}

underwater_snapshot_on(bro) {
  clientnotify("underwater_on");
}

underwater_snapshot_off(bro) {
  clientnotify("underwater_off");
}