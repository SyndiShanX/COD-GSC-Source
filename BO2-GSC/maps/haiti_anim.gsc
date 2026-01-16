/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\haiti_anim.gsc
**************************************/

#include maps\_utility;
#include maps\_dialog;
#include maps\_scene;
#include maps\_anim;
#include common_scripts\utility;
#include maps\voice\voice_haiti;
#include maps\haiti_amb;
#include maps\haiti_intro;
#include maps\haiti_util;
#include maps\haiti_transmission;
#include maps\haiti_endings;
#include maps\createart\haiti_art;

main() {
  maps\voice\voice_haiti::init_voice();
  precache_perk_anims();
  precache_intro_anims();
  precahce_front_door_anims();
  precahce_interior_anims();
  precache_endings_anims();
  generic_anims();
}

#using_animtree("generic_human");

generic_anims() {
  level.scr_anim["floor01"] = % ch_gen_m_floor_armdown_legspread_onback_deathpose;
  level.scr_anim["floor02"] = % ch_gen_m_floor_armdown_onback_deathpose;
  level.scr_anim["floor03"] = % ch_gen_m_floor_armdown_onfront_deathpose;
  level.scr_anim["floor04"] = % ch_gen_m_floor_armover_onrightside_deathpose;
  level.scr_anim["floor05"] = % ch_gen_m_floor_armrelaxed_onleftside_deathpose;
  level.scr_anim["floor06"] = % ch_gen_m_floor_armsopen_onback_deathpose;
  level.scr_anim["floor07"] = % ch_gen_m_floor_armspread_legaskew_onback_deathpose;
  level.scr_anim["floor08"] = % ch_gen_m_floor_armspread_legspread_onback_deathpose;
  level.scr_anim["floor09"] = % ch_gen_m_floor_armspreadwide_legspread_onback_deathpose;
  level.scr_anim["floor10"] = % ch_gen_m_floor_armstomach_onback_deathpose;
  level.scr_anim["floor11"] = % ch_gen_m_floor_armstomach_onrightside_deathpose;
  level.scr_anim["floor12"] = % ch_gen_m_floor_armstretched_onleftside_deathpose;
  level.scr_anim["floor13"] = % ch_gen_m_floor_armstretched_onrightside_deathpose;
  level.scr_anim["floor14"] = % ch_gen_m_floor_armup_legaskew_onfront_faceleft_deathpose;
  level.scr_anim["floor15"] = % ch_gen_m_floor_armup_legaskew_onfront_faceright_deathpose;
  level.scr_anim["floor16"] = % ch_gen_m_floor_armup_onfront_deathpose;
  level.scr_anim["ledge01"] = % ch_gen_m_ledge_armhanging_facedown_onfront_deathpose;
  level.scr_anim["ledge02"] = % ch_gen_m_ledge_armhanging_faceright_onfront_deathpose;
  level.scr_anim["ledge03"] = % ch_gen_m_ledge_armspread_faceleft_onfront_deathpose;
  level.scr_anim["ledge04"] = % ch_gen_m_ledge_armspread_faceright_onfront_deathpose;
  level.scr_anim["ramp01"] = % ch_gen_m_ramp_armup_onfront_deathpose;
  level.scr_anim["wall01"] = % ch_gen_m_wall_armcraddle_leanleft_deathpose;
  level.scr_anim["wall02"] = % ch_gen_m_wall_armopen_leanright_deathpose;
  level.scr_anim["wall03"] = % ch_gen_m_wall_headonly_leanleft_deathpose;
  level.scr_anim["wall04"] = % ch_gen_m_wall_legin_armcraddle_hunchright_deathpose;
  level.scr_anim["wall05"] = % ch_gen_m_wall_legspread_armdown_leanleft_deathpose;
  level.scr_anim["wall06"] = % ch_gen_m_wall_legspread_armdown_leanright_deathpose;
  level.scr_anim["wall07"] = % ch_gen_m_wall_legspread_armonleg_leanright_deathpose;
  level.scr_anim["wall08"] = % ch_gen_m_wall_low_armstomach_leanleft_deathpose;
  level.scr_anim["floor01_loop"] = % ch_gen_m_floor_back_wounded;
  level.scr_anim["floor02_loop"] = % ch_gen_m_floor_chest_wounded;
  level.scr_anim["floor03_loop"] = % ch_gen_m_floor_dullpain_wounded;
  level.scr_anim["floor04_loop"] = % ch_gen_m_floor_head_wounded;
  level.scr_anim["floor05_loop"] = % ch_gen_m_floor_leftleg_wounded;
  level.scr_anim["floor06_loop"] = % ch_gen_m_floor_shellshock_wounded;
  level.scr_anim["floor07_loop"] = % ch_gen_m_wall_rightleg_wounded;
  level.scr_anim["casual_idle"] = % casual_stand_idle;
  level.scr_anim["pillar_idle"] = % ai_pillar2_stand_idle;
  level.scr_anim["patrol_idle"] = % patrolstand_idle;
}

#using_animtree("player");
#using_animtree("animated_props");
#using_animtree("fxanim_props");
#using_animtree("player");
#using_animtree("animated_props");
#using_animtree("player");
#using_animtree("animated_props");

precache_perk_anims() {
  add_scene("bruteforce", "align_bruteforce");
  add_player_anim("player_body", % int_specialty_haiti_bruteforce, 1, 0, undefined, 0, undefined, undefined, undefined, undefined, undefined, 0, 0, 1);
  add_prop_anim("jaws", % o_specialty_haiti_bruteforce_jaws, "t6_wpn_jaws_of_life_prop");
  add_prop_anim("tablet", % o_specialty_haiti_bruteforce_tablet, "p6_gods_rod_tablet_offline", 1);
  level.scr_anim["fxanim_props"]["bruteforce_vtol"] = % o_specialty_haiti_bruteforce_vtol;
  add_notetrack_custom_function("tablet", "online", ::swap_tablet);
  add_scene("lockbreaker", "align_lockbreaker");
  add_player_anim("player_body", % int_specialty_haiti_lockbreaker, 1, 0, undefined, 0, undefined, undefined, undefined, undefined, undefined, 0, 0, 1);
  add_prop_anim("dongle", % o_specialty_haiti_lockbreaker_dongle, "t6_wpn_hacking_dongle_prop");
  add_scene("intruder", "intruder_crate", 0, 0, 0, 0);
  add_player_anim("player_body", % int_specialty_haiti_intruder, 1, 0, "tag_origin");
  add_prop_anim("intruder_crate", % o_specialty_haiti_intruder_crate, undefined, 0, 0, undefined, "tag_origin");
  add_prop_anim("cutter", % o_specialty_haiti_intruder_cutter, "t6_wpn_laser_cutter_prop", 1, 0, undefined, "tag_origin");
  add_notetrack_custom_function("player_body", "start", ::quadrotor_glove_on);
  add_notetrack_custom_function("cutter", "zap_start", ::intruder_fx);
  precache_assets();
}

swap_tablet(m_prop) {
  m_prop setmodel("p6_gods_rod_tablet_online");
}

quadrotor_glove_on(m_player_body) {
  e_hint = createstreamerhint(m_player_body.origin, 1.0);
  e_hint linkto(m_player_body, "tag_origin", vectorscale((0, 0, 1), 8.0));
  m_player_body attach("c_usa_cia_quad_viewbody_vson", "J_WristTwist_LE");
  wait 10;
  e_hint delete();
}

intruder_fx(m_prop) {
  m_prop play_fx("cutter_spark", undefined, undefined, 1.2, 1, "tag_fx");
  m_prop play_fx("cutter_on", undefined, undefined, 1.3, 1, "tag_fx");
}

precache_intro_anims() {
}

#using_animtree("generic_human");
#using_animtree("animated_props");
#using_animtree("player");
#using_animtree("generic_human");
#using_animtree("animated_props");
#using_animtree("player");
#using_animtree("generic_human");
#using_animtree("animated_props");
#using_animtree("vehicles");
#using_animtree("animated_props");
#using_animtree("generic_human");
#using_animtree("vehicles");
#using_animtree("generic_human");
#using_animtree("animated_props");
#using_animtree("player");
#using_animtree("generic_human");
#using_animtree("animated_props");
#using_animtree("generic_human");
#using_animtree("vehicles");

intro_anims() {
  add_scene("intro", "intro_align_v78");
  add_actor_anim("intro_redshirt1", % ch_ht_01_01_intro_redshirt1, 1, 0, 1);
  add_actor_anim("intro_redshirt2", % ch_ht_01_01_intro_redshirt2, 1, 0, 1);
  add_actor_anim("intro_pilot1", % ch_ht_01_01_intro_pilot1, 1, 0, 1);
  add_actor_anim("intro_pilot2", % ch_ht_01_01_intro_pilot2, 1, 0, 1);
  add_prop_anim("intro_v78_player", % v_ht_01_01_intro_playervtol, undefined, 1);
  add_notetrack_exploder("intro_v78_player", "hatch_open", 105);
  add_notetrack_level_notify("intro_v78_player", "hatch_open", "fxanim_vtol_int_open_start");
  add_notetrack_custom_function("intro_v78_player", "hatch_open_notify", maps\haiti_amb::vtol_hatch_wind);
  add_notetrack_flag("intro_v78_player", "hatch_open", "hatch_open");
  add_prop_anim("intro_jetwing_2", % v_ht_01_01_intro_wingsuit_2, "veh_t6_air_jetpack", 1);
  add_prop_anim("intro_jetwing_3", % v_ht_01_01_intro_wingsuit_3, "veh_t6_air_jetpack", 1);
  add_prop_anim("intro_jetwing_4", % v_ht_01_01_intro_wingsuit_4, "veh_t6_air_jetpack", 1);
  add_scene("intro_player", "intro_align_v78");
  add_player_anim("player_body", % p_ht_01_01_intro_player, 1, 0, undefined, 1, 1.0, 10, 10, 10, 10);
  add_notetrack_level_notify("player_body", "vox#sect_shut_down_the_transm_0", "first_objective");
  add_notetrack_exploder("player_body", "explosion_1", 110);
  add_notetrack_exploder("player_body", "explosion_2", 120);
  add_notetrack_custom_function("player_body", "explosion_1", ::intro_flak_knockdown);
  add_notetrack_custom_function("player_body", "swap_vtol", ::swap_vtol);
  add_notetrack_level_notify("player_body", "explosion_1", "fxanim_vtol_int_hit_start");
  add_notetrack_custom_function("player_body", "start_vtol_anims", ::start_planes);
  add_notetrack_custom_function("player_body", "jetwing_open", ::jetwing_audio);
  add_actor_anim("harper", % ch_ht_01_01_intro_harper, 1, 0, 1);
  add_actor_anim("intro_crew", % ch_ht_01_01_intro_crew, 1, 0, 1);
  add_prop_anim("harper_helmet", % o_ht_01_01_intro_harper_helmet, "c_usa_seal6_flight_helmet_prop", 1, 1);
  add_prop_anim("intro_jetwing_1", % v_ht_01_01_intro_wingsuit_1, "veh_t6_air_jetpack", 1);
  add_scene("intro_player_harperdead", "intro_align_v78");
  add_player_anim("player_body", % p_ht_01_01_intro_player, 1, 0, undefined, 1, 1.0, 10, 10, 10, 10);
  add_notetrack_level_notify("player_body", "vox#sect_shut_down_the_transm_0", "first_objective");
  add_notetrack_exploder("player_body", "explosion_1", 110);
  add_notetrack_exploder("player_body", "explosion_2", 120);
  add_notetrack_custom_function("player_body", "explosion_1", ::intro_flak_knockdown);
  add_notetrack_custom_function("player_body", "swap_vtol", ::swap_vtol);
  add_notetrack_level_notify("player_body", "explosion_1", "fxanim_vtol_int_hit_start");
  add_notetrack_custom_function("player_body", "start_vtol_anims", ::start_planes);
  add_notetrack_custom_function("player_body", "jetwing_open", ::jetwing_audio);
  add_actor_anim("harper", % ch_ht_01_01_intro_redshirt_harperdead, 1, 0, 1);
  add_actor_anim("intro_crew", % ch_ht_01_01_intro_crew_harperdead, 1, 0, 1);
  add_prop_anim("intro_jetwing_1", % v_ht_01_01_intro_wingsuit_1_harperdead, "veh_t6_air_jetpack", 1);
  add_scene("intro_planes", "intro_align_v78");
  add_prop_anim("intro_v78_exterior", % v_ht_01_01_intro_playervtol_exterior, undefined, 1);
  add_prop_anim("intro_v78_1", % v_ht_01_01_intro_rearvtol1, "veh_t6_air_v78_vtol", 1);
  add_prop_anim("intro_v78_2", % v_ht_01_01_intro_rearvtol2, "veh_t6_air_v78_vtol", 1);
  add_prop_anim("intro_v78_3", % v_ht_01_01_intro_rearvtol3, "veh_t6_air_v78_vtol", 1);
  add_vehicle_anim("vtol_explode", % v_ht_01_01_intro_explodingvtol, 1);
  add_notetrack_fx_on_tag("vtol_explode", "explosion_vtol", "vtol_explode_intro", "tag_origin");
  add_notetrack_fx_on_tag("vtol_explode", "explosion_vtol", "vtol_trail_cheap", "tag_engine_left");
  add_notetrack_level_notify("vtol_explode", "explosion_vtol", "vtol_explode");
  add_notetrack_custom_function("vtol_explode", "explosion_vtol", ::vtol_explode_trail);
  add_vehicle_anim("intro_f38_1", % v_ht_01_01_intro_f38_1, 1);
  add_vehicle_anim("intro_f38_2", % v_ht_01_01_intro_f38_2, 1);
  add_vehicle_anim("intro_f38_3", % v_ht_01_01_intro_f38_3, 1);
  add_vehicle_anim("intro_f38_7", % v_ht_01_01_intro_f38_7, 1);
  add_prop_anim("intro_v78_6", % v_ht_01_01_intro_bg_vtol3, "veh_t6_air_v78_vtol", 1);
  add_prop_anim("intro_v78_8", % v_ht_01_01_intro_bg_vtol5, "veh_t6_air_v78_vtol", 1);
  add_prop_anim("intro_v78_10", % v_ht_01_01_intro_bg_vtol7, "veh_t6_air_v78_vtol", 1);
  add_prop_anim("intro_v78_16", % v_ht_01_01_intro_bg_vtol13, "veh_t6_air_v78_vtol", 1);
  add_prop_anim("intro_v78_23", % v_ht_01_01_intro_bg_vtol20, "veh_t6_air_v78_vtol", 1);
  level.scr_anim["halo_guy_1"]["halo_jump"] = % ai_crew_vtol_1_launch;
  level.scr_anim["halo_guy_2"]["halo_jump"] = % ai_crew_vtol_2_launch;
  level.scr_anim["halo_guy_3"]["halo_jump"] = % ai_crew_vtol_3_launch;
  level.scr_anim["halo_guy_4"]["halo_jump"] = % ai_crew_vtol_4_launch;
  level.scr_anim["halo_guy_5"]["halo_jump"] = % ai_crew_vtol_5_launch;
  level.scr_anim["halo_guy_6"]["halo_jump"] = % ai_crew_vtol_6_launch;
  level.scr_anim["halo_jetwing_1"]["halo_jump"] = % v_crew_vtol_1_jetpack;
  level.scr_anim["halo_jetwing_2"]["halo_jump"] = % v_crew_vtol_2_jetpack;
  level.scr_anim["halo_jetwing_3"]["halo_jump"] = % v_crew_vtol_3_jetpack;
  level.scr_anim["halo_jetwing_4"]["halo_jump"] = % v_crew_vtol_4_jetpack;
  level.scr_anim["halo_jetwing_5"]["halo_jump"] = % v_crew_vtol_5_jetpack;
  level.scr_anim["halo_jetwing_6"]["halo_jump"] = % v_crew_vtol_6_jetpack;
  add_scene("intro_dummy", "intro_v78_dummy");
  add_actor_anim("intro_harper_dummy", % ch_ht_01_01_intro_harper, 1, 0, 1);
  add_actor_anim("intro_redshirt1_dummy", % ch_ht_01_01_intro_redshirt1, 1, 0, 1);
  add_actor_anim("intro_redshirt2_dummy", % ch_ht_01_01_intro_redshirt2, 1, 0, 1);
  add_actor_anim("intro_pilot1_dummy", % ch_ht_01_01_intro_pilot1, 1, 0, 1);
  add_actor_anim("intro_pilot2_dummy", % ch_ht_01_01_intro_pilot2, 1, 0, 1);
  add_actor_anim("intro_crew_dummy", % ch_ht_01_01_intro_crew, 1, 0, 1);
  add_scene("jetwing_land", "align_jetwing_landing");
  add_actor_anim("intro_redshirt1_landing", % ch_ht_01_05_coming_in_hot_soldier1, 1, 0, 1);
  add_actor_anim("intro_redshirt2_landing", % ch_ht_01_05_coming_in_hot_soldier2, 1, 0, 1);
  add_actor_anim("intro_redshirt3_landing", % ch_ht_01_05_coming_in_hot_soldier3, 1, 0, 1);
  add_actor_anim("intro_redshirt4_landing", % ch_ht_01_05_coming_in_hot_soldier4, 1, 0, 1);
  add_actor_model_anim("intro_redshirt6_landing", % ch_ht_01_05_coming_in_hot_soldier6, undefined, 1);
  add_actor_model_anim("intro_redshirt7_landing", % ch_ht_01_05_coming_in_hot_soldier7, undefined, 1);
  add_actor_model_anim("intro_redshirt8_landing", % ch_ht_01_05_coming_in_hot_soldier8, undefined, 1);
  add_actor_model_anim("intro_redshirt9_landing", % ch_ht_01_05_coming_in_hot_soldier9, undefined, 1);
  add_actor_model_anim("intro_redshirt10_landing", % ch_ht_01_05_coming_in_hot_soldier10, undefined, 1);
  add_actor_model_anim("intro_redshirt11_landing", % ch_ht_01_05_coming_in_hot_soldier11, undefined, 1);
  add_actor_model_anim("intro_redshirt12_landing", % ch_ht_01_05_coming_in_hot_soldier12, undefined, 1);
  add_actor_model_anim("intro_redshirt13_landing", % ch_ht_01_05_coming_in_hot_soldier13, undefined, 1);
  add_actor_model_anim("intro_redshirt14_landing", % ch_ht_01_05_coming_in_hot_soldier14, undefined, 1);
  add_actor_model_anim("intro_redshirt15_landing", % ch_ht_01_05_coming_in_hot_soldier15, undefined, 1);
  add_actor_model_anim("intro_redshirt16_landing", % ch_ht_01_05_coming_in_hot_soldier16, undefined, 1);
  add_actor_model_anim("intro_redshirt17_landing", % ch_ht_01_05_coming_in_hot_soldier17, undefined, 1);
  add_prop_anim("intro_jetwing1_landing", % v_ht_01_05_coming_in_hot_soldier1_pack, "veh_t6_air_jetpack", 1);
  add_prop_anim("intro_jetwing2_landing", % v_ht_01_05_coming_in_hot_soldier2_pack, "veh_t6_air_jetpack", 1);
  add_prop_anim("intro_jetwing3_landing", % v_ht_01_05_coming_in_hot_soldier3_pack, "veh_t6_air_jetpack", 1);
  add_prop_anim("intro_jetwing4_landing", % v_ht_01_05_coming_in_hot_soldier4_pack, "veh_t6_air_jetpack", 1);
  add_prop_anim("intro_jetwing6_landing", % v_ht_01_05_coming_in_hot_soldier6_pack, "veh_t6_air_jetpack", 1);
  add_prop_anim("intro_jetwing7_landing", % v_ht_01_05_coming_in_hot_soldier7_pack, "veh_t6_air_jetpack", 1);
  add_prop_anim("intro_jetwing8_landing", % v_ht_01_05_coming_in_hot_soldier8_pack, "veh_t6_air_jetpack", 1);
  add_prop_anim("intro_jetwing9_landing", % v_ht_01_05_coming_in_hot_soldier9_pack, "veh_t6_air_jetpack", 1);
  add_prop_anim("intro_jetwing10_landing", % v_ht_01_05_coming_in_hot_soldier10_pack, "veh_t6_air_jetpack", 1);
  add_prop_anim("intro_jetwing11_landing", % v_ht_01_05_coming_in_hot_soldier11_pack, "veh_t6_air_jetpack", 1);
  add_prop_anim("intro_jetwing12_landing", % v_ht_01_05_coming_in_hot_soldier12_pack, "veh_t6_air_jetpack", 1);
  add_prop_anim("intro_jetwing13_landing", % v_ht_01_05_coming_in_hot_soldier13_pack, "veh_t6_air_jetpack", 1);
  add_prop_anim("intro_jetwing14_landing", % v_ht_01_05_coming_in_hot_soldier14_pack, "veh_t6_air_jetpack", 1);
  add_prop_anim("intro_jetwing15_landing", % v_ht_01_05_coming_in_hot_soldier15_pack, "veh_t6_air_jetpack", 1);
  add_prop_anim("intro_jetwing16_landing", % v_ht_01_05_coming_in_hot_soldier16_pack, "veh_t6_air_jetpack", 1);
  add_prop_anim("intro_jetwing17_landing", % v_ht_01_05_coming_in_hot_soldier17_pack, "veh_t6_air_jetpack", 1);
  add_scene("jetwing_land_player", "align_jetwing_landing");
  add_player_anim("player_body", % p_ht_01_05_coming_in_hot_player, 1, 0, undefined, 1, 1.0, 15, 15, 15, 15);
  add_notetrack_custom_function("player_body", "take_off_helmet", ::take_off_mask);
  add_notetrack_custom_function("player_body", "jetwing_fade", ::jetwing_audio_fade);
  add_scene("jetwing_land_player_alt", "align_jetwing_landing");
  add_player_anim("player_body", % p_ht_01_05_coming_in_hot_player_harperdead, 1, 0, undefined, 1, 1.0, 15, 15, 15, 15);
  add_notetrack_custom_function("player_body", "take_off_helmet", ::take_off_mask);
  add_notetrack_custom_function("player_body", "jetwing_fade", ::jetwing_audio_fade);
  add_scene("jetwing_land_crash", "align_jetwing_landing");
  add_actor_anim("intro_redshirt5_landing", % ch_ht_01_05_coming_in_hot_soldier5, 1, 0, 1);
  add_prop_anim("intro_jetwing5_landing", % v_ht_01_05_coming_in_hot_soldier5_pack, "veh_t6_air_jetpack", 1);
  add_scene("jetwing_land_alt", "align_jetwing_landing");
  add_actor_anim("harper", % ch_ht_01_05_coming_in_hot_harper);
  add_vehicle_anim("intro_quadrotor1_landing", % v_ht_01_05_coming_in_hot_qr1, 0);
  add_notetrack_fx_on_tag("intro_quadrotor1_landing", "explode", "quadrotor_death", "tag_origin");
  precache_assets(1);
}

start_planes(ent) {
  level thread run_scene("intro_planes");
  flag_wait("intro_planes_started");
  level thread show_numbers();
  level thread play_vtol_exhaust();
  level thread spawn_moving_cloud("moving_cloud_struct", "swap_vtol", "right");
  level thread spawn_moving_cloud("moving_cloud_2_struct", "swap_vtol", "left");
  vtol_1 = getent("vtol_explode", "targetname");
  wait 1;
  vtol_10 = getent("intro_v78_10", "targetname");
  playfxontag(level._effect["vtol_chaff"], vtol_10, "tag_origin");
  vtol_23 = getent("intro_v78_23", "targetname");
  playfxontag(level._effect["vtol_chaff"], vtol_23, "tag_origin");
  vtol_1 thread do_vtol_halo_jump();
  vtol_1 waittill("halo_jump_go");
  wait 4;
  vtol_10 = getent("intro_v78_10", "targetname");
  playfxontag(level._effect["vtol_chaff"], vtol_10, "tag_origin");
  vtol_16 = getent("intro_v78_16", "targetname");
  vtol_16 thread do_vtol_halo_jump();
  wait 2;
}

jetwing_audio(ent) {
  level.jetwing_sound_ent = spawn("script_origin", ent.origin);
  level.jetwing_sound_ent playloopsound("veh_jetwing_wing_loop", 1);
}

jetwing_audio_fade(ent) {
  level.jetwing_sound_ent stoploopsound(2);
}

vtol_explode_trail(ent) {
  ent playsound("exp_intro_vtol_explo");
  ent hide();
}

show_numbers() {
  while(true) {
    for(i = 0; i < 26; i++) {
      vtol = getent("intro_v78_" + (i + 1), "targetname");

      if(isDefined(vtol)) {
        print3d(vtol.origin, i + 1, (0, 1, 0), 1, 10, 1);

      }
    }

    wait 0.05;
  }
}

play_vtol_exhaust() {
  vtol_explode = getent("vtol_explode", "targetname");
  vtol_explode thread play_vtol_lights();
  playfxontag(level._effect["vtol_exhaust"], vtol_explode, "tag_engine_left");

  for(i = 0; i < 26; i++) {
    vtol = getent("intro_v78_" + (i + 1), "targetname");

    if(isDefined(vtol)) {
      vtol thread play_vtol_lights();
      playfxontag(level._effect["vtol_exhaust"], vtol, "tag_engine_left");
    }
  }
}

play_vtol_lights() {
  wait(randomfloatrange(0.1, 0.5));
  playfxontag(level._effect["vtol_lights"], self, "tag_origin");
}

take_off_mask(ent) {
  level notify("end_expl_manager_landing");
  stop_exploder(191);
  rpc("clientscripts/haiti", "take_off_oxygen_mask");
  luinotifyevent(&"hud_update_vehicle_custom", 1, 0);
}

swap_vtol(ent) {
  exploder(125);
  spawn_clouds("intro_cloud_struct", "avoid_missiles", getvehiclenode("path_jetwing", "targetname").angles);
  harper_intro_jetwing = getent("intro_jetwing_1", "targetname");
  playfxontag(level._effect["jetwing_hero_exhaust"], harper_intro_jetwing, "tag_engine_left");
  redshirt_intro_jetwing = getent("intro_jetwing_3", "targetname");
  playfxontag(level._effect["jetwing_hero_exhaust"], redshirt_intro_jetwing, "tag_engine_left");
  level.player freezecontrols(1);
  level thread vtol_swap();
  level thread vtol_explosion();
  wait 1.5;
  level thread set_cloud_fog();
  wait 2;
  level thread set_intro_fog();
  wait 1;
  level.player freezecontrols(0);
}

vtol_explosion() {
  wait 1;
  level notify("vtol_exterior_explosion");
  exploder(121);
  stop_exploder(105);
}

vtol_swap() {
  vtol = getent("intro_v78_player", "targetname");
  vtol hide();
  vtol_exterior = getent("intro_v78_exterior", "targetname");
  vtol_exterior show();
  level.player setclientdvar("cg_fov", 75);
  level notify("swap_vtol");
  level thread maps\haiti_intro::player_intro_rumble();
  clear_lighting_pair("player_body");
  clear_lighting_pair("intro_jetwing_1");
  clear_lighting_pair("harper_ai");
  clear_lighting_pair("intro_jetwing_3");
  clear_lighting_pair("intro_redshirt2");
  wait 7;
  level.player thread rumble_loop(5, 0.1);
  wait 1;
  level.player thread rumble_loop(20, 0.1);
}

intro_flak(ent) {
  level endon("fxanim_vtol_int_open_start");
  level endon("end_intro_flak");
  level thread delay_notify(55, "end_intro_flak");
  level thread intro_impact_missile();
  level thread intro_vtol_pieces();
  level thread intro_flak_hatch_open();
  structs = getstructarray("intro_flak_struct", "script_noteworthy");
  index = 0;

  while(true) {
    playfx(level._effect["flak_explode"], structs[index].origin);
    earthquake(0.35, 1, structs[index].origin, 1500, level.player);
    level.player playsound("exp_flak_on_plane");
    level.player thread rumble_loop(3, 0.1);
    wait(randomfloatrange(3, 4));
    index++;

    if(index == structs.size)
      index = 0;
  }
}

intro_flak_hatch_open() {
  level endon("end_intro_flak");
  level waittill("fxanim_vtol_int_open_start");
  structs = getstructarray("intro_flak_struct", "script_noteworthy");
  index = 0;
  playfx(level._effect["flak_explode"], structs[index].origin);
  earthquake(0.35, 1, structs[index].origin, 1500, level.player);
  level.player playsound("exp_flak_on_plane");
  level.player playsound("exp_intro_flak");
  level.player thread rumble_loop(3, 0.1);
  index++;

  if(index == structs.size)
    index = 0;

  wait 3;
  playfx(level._effect["flak_explode"], structs[index].origin);
  earthquake(0.35, 1, structs[index].origin, 1500, level.player);
  level.player playsound("exp_flak_on_plane");
  level.player playsound("exp_intro_flak");
  level.player thread rumble_loop(3, 0.1);
  index++;

  if(index == structs.size)
    index = 0;

  wait 1;
  playfx(level._effect["flak_explode"], structs[index].origin);
  earthquake(0.35, 1, structs[index].origin, 1500, level.player);
  level.player playsound("exp_flak_on_plane");
  level.player playsound("exp_intro_flak");
  level.player thread rumble_loop(3, 0.1);
  index++;

  if(index == structs.size)
    index = 0;

  wait 2;
  playfx(level._effect["flak_explode"], structs[index].origin);
  earthquake(0.35, 1, structs[index].origin, 1500, level.player);
  level.player playsound("exp_flak_on_plane");
  level.player playsound("exp_intro_flak");
  level.player thread rumble_loop(3, 0.1);
  index++;

  if(index == structs.size)
    index = 0;

  level waittill("vtol_explode");
  wait 5;

  while(true) {
    playfx(level._effect["flak_explode"], structs[index].origin);
    earthquake(0.35, 1, structs[index].origin, 1500, level.player);
    level.player playsound("exp_flak_on_plane");
    level.player thread rumble_loop(3, 0.1);
    wait(randomfloatrange(3, 4));
    index++;

    if(index == structs.size)
      index = 0;
  }
}

delay_notify(time, str_notify) {
  wait(time);
  level notify(str_notify);
}

intro_flak_knockdown(ent) {
  stop_exploder(102);
  level.player playsound("exp_vtol_imp");
  vtol_interior = getent("fxanim_vtol_interior", "targetname");
  playfxontag(level._effect["wire_sparks"], vtol_interior, "tag_fx_wire1");
  playfxontag(level._effect["wire_sparks"], vtol_interior, "tag_fx_wire2");
  struct = getstruct("intro_flak_struct_knockdown", "targetname");
  playfx(level._effect["flak_explode"], struct.origin);
  earthquake(1.5, 1, struct.origin, 512, level.player);
  level.player thread rumble_loop(10, 0.1);
  wait 3;
  struct = getstruct("intro_flak_struct_window", "script_noteworthy");
  playfx(level._effect["flak_explode"], struct.origin);
  level.player playrumbleonentity("damage_heavy");
}

intro_impact_missile() {
  level waittill("fxanim_vtol_int_hit_start");
  wait 12.2;
  missile = getent("intro_impact_missile", "targetname");
  end = getstruct("intro_impact_end", "targetname");
  playfxontag(level._effect["missile_trail"], missile, "tag_origin");
  missile moveto(end.origin, 0.5, 0.05);
  missile waittill("movedone");
  earthquake(0.5, 2, level.player.origin, 512);
  level.player thread rumble_loop(10, 0.1);
  missile delete();
}

intro_vtol_pieces() {
  wait 48;
  cockpit = setup_vtol_pieces("intro_vtol_piece_cockpit", "intro_vtol_piece_cockpit");
  cockpit thread vtol_piece_think("intro_vtol_piece_cockpit_end", 2, 0.05, "tag_cockpit_link_jnt");
  wait 2;
  wing = setup_vtol_pieces("intro_vtol_piece_wing", "intro_vtol_piece_wing");
  wing thread vtol_piece_think("intro_vtol_piece_wing_end", 2, 0.05, "tag_engine_l_link_jnt");
  wait 1;
  body = setup_vtol_pieces("intro_vtol_piece_body", "intro_vtol_piece_body");
  body thread vtol_piece_think("intro_vtol_piece_body_end", 1.5, 0.05, "tag_engine_r_link_jnt");
}

setup_vtol_pieces(str_pieces, str_parent) {
  pieces = getentarray(str_pieces, "script_noteworthy");
  parent = getent(str_parent, "targetname");
  parent.pieces = [];
  parent maps\haiti_util::add_cleanup_ent("cleanup_intro");

  foreach(piece in pieces) {
    piece linkto(parent, piece.script_string, (0, 0, 0), (0, 0, 0));
    piece maps\haiti_util::add_cleanup_ent("cleanup_intro");
    parent.pieces[parent.pieces.size] = piece;
  }

  return parent;
}

vtol_piece_think(str_end, time, accel, fx_tag) {
  end_point = getstruct(str_end, "targetname");
  playfxontag(level._effect["vtol_trail_cheap"], self, fx_tag);
  self moveto(end_point.origin, time, accel);
  self waittill("movedone");
  wait 3;
  array_delete(self.pieces);
  self delete();
}

precahce_front_door_anims() {
}

#using_animtree("animated_props");

front_door_anims() {
  level.scr_anim["laser_turret_scan"][0] = % fxanim_war_laser_turret_search_01_anim;
  level.scr_anim["laser_turret_scan"][1] = % fxanim_war_laser_turret_search_02_anim;
  level.scr_anim["laser_turret_scan"][2] = % fxanim_war_laser_turret_search_03_anim;
  level.scr_anim["laser_turret_scan"][3] = % fxanim_war_laser_turret_search_04_anim;
  precache_assets(1);
}

precahce_interior_anims() {
}

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
#using_animtree("player");
#using_animtree("generic_human");
#using_animtree("animated_props");
#using_animtree("generic_human");
#using_animtree("player");
#using_animtree("generic_human");

interior_anims() {
  add_scene("general_speech", "media_control_room");
  add_actor_model_anim("seal_assault", % ch_ht_03_01_general_brief_drones_general, undefined, 1);
  add_scene("guy_at_computer_idle", "media_control_room", 0, 0, 1);
  add_actor_anim("computer_guy", % ch_ht_04_02_stop_transmission_computerguy_cycle, 0, 1, 0);
  add_prop_anim("control_chair_01", % o_ht_04_02_stop_transmission_computerguy_chair_cycle, undefined, 0);
  add_scene("guy_at_computer_stand", "media_control_room");
  add_actor_anim("computer_guy", % ch_ht_04_02_stop_transmission_computerguy_transitiontoai, 0, 1, 0);
  add_prop_anim("control_chair_01", % o_ht_04_02_stop_transmission_computerguy_chair_transitiontoai, undefined, 0);
  add_scene("guy_at_computer_die", "media_control_room");
  add_actor_anim("computer_guy", % ch_ht_04_02_stop_transmission_computerguy_death, 0, 1, 0);
  add_prop_anim("control_chair_01", % o_ht_04_02_stop_transmission_computerguy_chair_death, undefined, 0);
  add_scene("harper_transmission_enter", "media_control_room");
  add_actor_anim("harper", % ch_ht_04_02_stop_transmission_harper_entry);
  add_scene("harper_transmission_shoot", "media_control_room");
  add_actor_anim("harper", % ch_ht_04_02_stop_transmission_harper_shootsenemy);
  add_scene("harper_transmission_transition", "media_control_room");
  add_actor_anim("harper", % ch_ht_04_02_stop_transmission_harper_transitiontoai);
  add_scene("stop_transmission_chair_2", "media_control_room");
  add_prop_anim("control_chair_02", % o_ht_04_02_boobytrap_soldier03_chair, undefined, 0);
  add_scene("stop_transmission_1", "media_control_room");
  add_player_anim("player_body", % p_ht_04_02_boobytrap_01_player, 0, 0, undefined, 1, 1.0, 15, 15, 15, 15);
  add_actor_anim("soldier2", % ch_ht_04_02_boobytrap_soldier02_01, 0, undefined, 0, undefined, undefined, "seal_assault");
  add_actor_anim("soldier3", % ch_ht_04_02_boobytrap_soldier03_01, 0, undefined, 0, undefined, undefined, "seal_assault");
  add_notetrack_custom_function("player_body", "movie start", maps\haiti_transmission::menendez_movie);
  add_notetrack_custom_function("player_body", "red_light_on", maps\haiti_transmission::theater_light, 0, 1);
  add_scene("stop_transmission_1_harper", "media_control_room");
  add_actor_anim("harper", % ch_ht_04_02_boobytrap_harper_01, 0, undefined, 0);
  add_scene("stop_transmission_2", "media_control_room");
  add_player_anim("player_body", % p_ht_04_02_boobytrap_02_player, 0, 0, undefined, 1, 1.0, 15, 15, 15, 15);
  add_notetrack_custom_function("player_body", "soldiers enter right", maps\haiti_transmission::fill_theater_right);
  add_notetrack_custom_function("player_body", "soldiers enter left", maps\haiti_transmission::fill_theater_left);
  add_notetrack_custom_function("player_body", "white_light_on", maps\haiti_transmission::theater_light, 0, 1);
  add_actor_anim("soldier2", % ch_ht_04_02_boobytrap_soldier02_02, 0, undefined, 0, undefined, undefined, "seal_assault");
  add_actor_anim("soldier3", % ch_ht_04_02_boobytrap_soldier03_02, 0, undefined, 0, undefined, undefined, "seal_assault");
  add_prop_anim("control_chair_03", % o_ht_04_02_boobytrap_soldier02_02_chair, undefined, 0);
  add_scene("stop_transmission_2_harper", "media_control_room");
  add_actor_anim("harper", % ch_ht_04_02_boobytrap_harper_02, 0, undefined, 0);
  add_scene("stop_transmission_3", "media_control_room");
  add_player_anim("player_body", % p_ht_04_02_boobytrap_03_player, 1, 0, undefined, 1, 1.0, 15, 15, 15, 15);
  add_actor_anim("soldier2", % ch_ht_04_02_boobytrap_soldier02_03, 0, undefined, 0, undefined, undefined, "seal_assault");
  add_actor_anim("soldier3", % ch_ht_04_02_boobytrap_soldier03_03, 0, undefined, 0, undefined, undefined, "seal_assault");
  add_actor_anim("booby_trap", % ch_ht_04_02_boobytrap_deadguy_04, 1, undefined, 1, undefined, undefined, "booby_trap");
  add_notetrack_custom_function("player_body", "red_light_on_2", maps\haiti_transmission::theater_light, 0, 1);
  add_notetrack_custom_function("player_body", "white_light_on_2", maps\haiti_transmission::theater_light, 0, 1);
  add_notetrack_custom_function("player_body", "white_light_off", maps\haiti_transmission::theater_light, 0, 1);
  add_notetrack_custom_function("player_body", "viewmodel arms up", maps\haiti_transmission::viewmodel_arms_up);
  add_notetrack_custom_function("player_body", "viewmodel arms down", maps\haiti_transmission::viewmodel_arms_down);
  add_notetrack_custom_function("player_body", "explosion", maps\haiti_transmission::booby_trap_explode);
  add_scene("stop_transmission_3_harper", "media_control_room");
  add_actor_anim("harper", % ch_ht_04_02_boobytrap_harper_03, 0, undefined, 0, undefined, undefined, "harper");
  precache_assets(1);
}

precache_endings_anims() {
}

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
#using_animtree("generic_human");
#using_animtree("animated_props");
#using_animtree("generic_human");
#using_animtree("player");
#using_animtree("vehicles");
#using_animtree("generic_human");
#using_animtree("vehicles");
#using_animtree("generic_human");
#using_animtree("animated_props");
#using_animtree("player");
#using_animtree("vehicles");
#using_animtree("generic_human");
#using_animtree("animated_props");
#using_animtree("generic_human");
#using_animtree("animated_props");
#using_animtree("generic_human");
#using_animtree("animated_props");
#using_animtree("player");
#using_animtree("vehicles");
#using_animtree("generic_human");
#using_animtree("animated_props");
#using_animtree("generic_human");
#using_animtree("player");
#using_animtree("vehicles");
#using_animtree("generic_human");
#using_animtree("animated_props");
#using_animtree("generic_human");
#using_animtree("player");
#using_animtree("vehicles");
#using_animtree("generic_human");
#using_animtree("animated_props");
#using_animtree("generic_human");

endings_anims() {
  add_scene("harper_slide_door_fall", "player_hanging");
  add_actor_anim("harper", % ch_ht_06_01_floor_collapse_harper, 0, 0, 0, 1);
  add_scene("player_slide_door_fall", "player_hanging");
  add_player_anim("player_body", % p_ht_06_01_entry_floor_collapse_player, 1, 0, undefined, 0);
  add_actor_anim("ending_camo", % ch_ht_06_01_floor_collapse_pmc, 0, 0, 0, 1);
  add_notetrack_custom_function("ending_camo", undefined, maps\haiti_endings::notetrack_set_blend_times);
  add_notetrack_custom_function("player_body", undefined, maps\haiti_endings::notetrack_set_blend_times);
  add_notetrack_custom_function("player_body", undefined, maps\haiti_endings::turn_off_spot_light);
  add_notetrack_custom_function("player_body", "explosions_go_off", maps\haiti_endings::explosions_go_off, 0);
  add_notetrack_custom_function("player_body", "floor_falls", maps\haiti_endings::floor_falls, 0);
  add_notetrack_custom_function("player_body", "timescale_off", maps\haiti_endings::show_ceiling, 0);
  add_notetrack_custom_function("player_body", "sndDuckAmb", ::sndduckamb);
  add_notetrack_custom_function("player_body", "DOF_focus_on_hands", maps\createart\haiti_art::dof_focus_on_hands);
  add_scene("deathpose_gun", "player_hanging");
  add_cheap_actor_model_anim("deadguy", % ch_ht_06_01_slide_01_success_deadguy, undefined, 1, undefined, undefined, "pmc_assault");
  add_scene("scene_0_v1", "player_hanging");
  add_actor_anim("menendez", % ch_ht_06_01_slide_01_success_menedez_finds_harper, 1, 0, 0, 1);
  add_actor_anim("defalco", % ch_ht_06_01_slide_01_success_delfalco_finds_harper, 0, 0, 0, 1);
  add_actor_anim("ending_camo", % ch_ht_06_01_slide_01_success_pmc_finds_harper, 0);
  add_actor_anim("harper", % ch_ht_06_01_slide_01_success_harper, 0);
  add_prop_anim("player_body_model", % p_ht_06_01_slide_01_success_grabs_gun, undefined, 0, 0, undefined);
  add_notetrack_custom_function("ending_camo", "camo_fail", maps\haiti_endings::camo_fail, 0);
  add_notetrack_custom_function("harper", undefined, maps\haiti_endings::scene_0_v1_rebar);
  add_notetrack_custom_function("player_body_model", "FOV_58.90_stop_a", maps\haiti_endings::start_fov, 0);
  add_notetrack_custom_function("player_body_model", "FOV_19.15_stop_a", maps\haiti_endings::fov_change_1, 0);
  add_notetrack_custom_function("player_body_model", "FOV_38.73_start", maps\haiti_endings::delete_floor, 0);
  add_notetrack_custom_function("player_body_model", "FOV_38.73_stop", maps\haiti_endings::fov_change_2, 0);
  add_notetrack_custom_function("player_body_model", "start_slowmo", maps\haiti_endings::player_start_slowmo, 0);
  add_notetrack_custom_function("player_body_model", "grab_gun", maps\haiti_endings::grab_gun, 0);
  add_notetrack_custom_function("player_body_model", "exposure flash", maps\haiti_endings::notetrack_flash_on_camera_cut);
  add_notetrack_custom_function("player_body_model", "sndSnapStart", ::startlookyloosnap);
  add_notetrack_custom_function("player_body_model", "sndSnapEnd", ::endlookyloosnap);
  add_notetrack_custom_function("player_body_model", "DOF_back_to_hanging", maps\haiti_endings::save_the_game);
  add_notetrack_custom_function("player_body_model", "DOF_look_down", maps\createart\haiti_art::dof_look_down);
  add_notetrack_custom_function("player_body_model", "DOF_menendez_closeup", maps\createart\haiti_art::dof_menendez_closeup);
  add_notetrack_custom_function("player_body_model", "DOF_defalco_closeup", maps\createart\haiti_art::dof_defalco_closeup);
  add_notetrack_custom_function("player_body_model", "DOF_harper_closeup", maps\createart\haiti_art::dof_harper_closeup);
  add_notetrack_custom_function("player_body_model", "DOF_gun_closeup", maps\createart\haiti_art::dof_gun_closeup);
  add_notetrack_custom_function("player_body_model", "DOF_back_to_hanging", maps\createart\haiti_art::dof_back_to_hanging);
  add_notetrack_custom_function("player_body_model", "DOF_land", maps\createart\haiti_art::dof_land);
  add_scene("scene_0_v2", "player_hanging");
  add_actor_anim("menendez", % ch_ht_06_01_slide_01_success_menedez_finds_harper, 1, 0, 0, 1);
  add_actor_anim("defalco", % ch_ht_06_01_slide_01_success_delfalco_harper_dead, 0, 0, 0, 1);
  add_actor_anim("ending_camo", % ch_ht_06_01_slide_01_success_pmc_finds_harper, 0);
  add_prop_anim("player_body_model", % p_ht_06_01_slide_01_success_grabs_gun_harper_dead, undefined, 0, 0, undefined);
  add_notetrack_custom_function("ending_camo", "camo_fail", maps\haiti_endings::camo_fail, 0);
  add_notetrack_custom_function("player_body_model", "FOV_58.90_stop_a", maps\haiti_endings::start_fov, 0);
  add_notetrack_custom_function("player_body_model", "FOV_19.15_stop_a", maps\haiti_endings::fov_change_1, 0);
  add_notetrack_custom_function("player_body_model", "FOV_38.73_start", maps\haiti_endings::delete_floor, 0);
  add_notetrack_custom_function("player_body_model", "FOV_38.73_stop", maps\haiti_endings::fov_change_2, 0);
  add_notetrack_custom_function("player_body_model", "start_slowmo", maps\haiti_endings::player_start_slowmo, 0);
  add_notetrack_custom_function("player_body_model", "grab_gun", maps\haiti_endings::grab_gun, 0);
  add_notetrack_custom_function("player_body_model", "sndSnapStart", ::startlookyloosnap);
  add_notetrack_custom_function("player_body_model", "sndSnapEnd", ::endlookyloosnap);
  add_notetrack_custom_function("player_body_model", "exposure flash", maps\haiti_endings::notetrack_flash_on_camera_cut);
  add_notetrack_custom_function("player_body_model", "DOF_back_to_hanging", maps\haiti_endings::save_the_game);
  add_notetrack_custom_function("player_body_model", "DOF_look_down", maps\createart\haiti_art::dof_look_down);
  add_notetrack_custom_function("player_body_model", "DOF_menendez_closeup", maps\createart\haiti_art::dof_menendez_closeup);
  add_notetrack_custom_function("player_body_model", "DOF_pmc2_closeup", maps\createart\haiti_art::dof_pmc2_closeup);
  add_notetrack_custom_function("player_body_model", "DOF_pmc1_closeup", maps\createart\haiti_art::dof_pmc1_closeup);
  add_notetrack_custom_function("player_body_model", "DOF_gun_closeup", maps\createart\haiti_art::dof_gun_closeup);
  add_notetrack_custom_function("player_body_model", "DOF_back_to_hanging", maps\createart\haiti_art::dof_back_to_hanging);
  add_notetrack_custom_function("player_body_model", "DOF_land", maps\createart\haiti_art::dof_land);
  add_scene("scene_0_v3", "player_hanging");
  add_actor_anim("menendez", % ch_ht_06_01_slide_01_success_menedez_finds_harper, 1, 0, 0, 1);
  add_actor_anim("defalco", % ch_ht_06_01_slide_01_success_pmc2_harper_dead, 0, 0, 0, 1);
  add_actor_anim("ending_camo", % ch_ht_06_01_slide_01_success_pmc_finds_harper, 0);
  add_actor_anim("harper", % ch_ht_06_01_slide_01_success_harper, 0);
  add_prop_anim("player_body_model", % p_ht_06_01_slide_01_success_grabs_gun, undefined, 0, 0, undefined);
  add_notetrack_custom_function("ending_camo", "camo_fail", maps\haiti_endings::camo_fail, 0);
  add_notetrack_custom_function("harper", undefined, maps\haiti_endings::scene_0_v3_rebar);
  add_notetrack_custom_function("player_body_model", "FOV_58.90_stop_a", maps\haiti_endings::start_fov, 0);
  add_notetrack_custom_function("player_body_model", "FOV_19.15_stop_a", maps\haiti_endings::fov_change_1, 0);
  add_notetrack_custom_function("player_body_model", "FOV_38.73_start", maps\haiti_endings::delete_floor, 0);
  add_notetrack_custom_function("player_body_model", "FOV_38.73_stop", maps\haiti_endings::fov_change_2, 0);
  add_notetrack_custom_function("player_body_model", "start_slowmo", maps\haiti_endings::player_start_slowmo, 0);
  add_notetrack_custom_function("player_body_model", "grab_gun", maps\haiti_endings::grab_gun, 0);
  add_notetrack_custom_function("player_body_model", "sndSnapStart", ::startlookyloosnap);
  add_notetrack_custom_function("player_body_model", "sndSnapEnd", ::endlookyloosnap);
  add_notetrack_custom_function("player_body_model", "exposure flash", maps\haiti_endings::notetrack_flash_on_camera_cut);
  add_notetrack_custom_function("player_body_model", "DOF_back_to_hanging", maps\haiti_endings::save_the_game);
  add_notetrack_custom_function("player_body_model", "DOF_look_down", maps\createart\haiti_art::dof_look_down);
  add_notetrack_custom_function("player_body_model", "DOF_menendez_closeup", maps\createart\haiti_art::dof_menendez_closeup);
  add_notetrack_custom_function("player_body_model", "DOF_defalco_closeup", maps\createart\haiti_art::dof_defalco_closeup);
  add_notetrack_custom_function("player_body_model", "DOF_harper_closeup", maps\createart\haiti_art::dof_harper_closeup);
  add_notetrack_custom_function("player_body_model", "DOF_gun_closeup", maps\createart\haiti_art::dof_gun_closeup);
  add_notetrack_custom_function("player_body_model", "DOF_back_to_hanging", maps\createart\haiti_art::dof_back_to_hanging);
  add_notetrack_custom_function("player_body_model", "DOF_land", maps\createart\haiti_art::dof_land);
  add_scene("scene_0_v4", "player_hanging");
  add_actor_anim("menendez", % ch_ht_06_01_slide_01_success_menedez_finds_harper, 1, 0, 0, 1);
  add_actor_anim("defalco", % ch_ht_06_01_slide_01_success_pmc2_harper_dead, 0, 0, 0, 1);
  add_actor_anim("ending_camo", % ch_ht_06_01_slide_01_success_pmc_finds_harper, 0);
  add_prop_anim("player_body_model", % p_ht_06_01_slide_01_success_grabs_gun_harper_dead, undefined, 0, 0, undefined);
  add_notetrack_custom_function("ending_camo", "camo_fail", maps\haiti_endings::camo_fail, 0);
  add_notetrack_custom_function("player_body_model", "FOV_58.90_stop_a", maps\haiti_endings::start_fov, 0);
  add_notetrack_custom_function("player_body_model", "FOV_19.15_stop_a", maps\haiti_endings::fov_change_1, 0);
  add_notetrack_custom_function("player_body_model", "FOV_38.73_start", maps\haiti_endings::delete_floor, 0);
  add_notetrack_custom_function("player_body_model", "FOV_38.73_stop", maps\haiti_endings::fov_change_2, 0);
  add_notetrack_custom_function("player_body_model", "start_slowmo", maps\haiti_endings::player_start_slowmo, 0);
  add_notetrack_custom_function("player_body_model", "grab_gun", maps\haiti_endings::grab_gun, 0);
  add_notetrack_custom_function("player_body_model", "sndSnapStart", ::startlookyloosnap);
  add_notetrack_custom_function("player_body_model", "sndSnapEnd", ::endlookyloosnap);
  add_notetrack_custom_function("player_body_model", "exposure flash", maps\haiti_endings::notetrack_flash_on_camera_cut);
  add_notetrack_custom_function("player_body_model", "DOF_back_to_hanging", maps\haiti_endings::save_the_game);
  add_notetrack_custom_function("player_body_model", "DOF_look_down", maps\createart\haiti_art::dof_look_down);
  add_notetrack_custom_function("player_body_model", "DOF_menendez_closeup", maps\createart\haiti_art::dof_menendez_closeup);
  add_notetrack_custom_function("player_body_model", "DOF_pmc2_closeup", maps\createart\haiti_art::dof_pmc2_closeup);
  add_notetrack_custom_function("player_body_model", "DOF_pmc1_closeup", maps\createart\haiti_art::dof_pmc1_closeup);
  add_notetrack_custom_function("player_body_model", "DOF_gun_closeup", maps\createart\haiti_art::dof_gun_closeup);
  add_notetrack_custom_function("player_body_model", "DOF_back_to_hanging", maps\createart\haiti_art::dof_back_to_hanging);
  add_notetrack_custom_function("player_body_model", "DOF_land", maps\createart\haiti_art::dof_land);
  add_scene("scene_1_v1", "player_hanging");
  add_actor_anim("menendez", % ch_ht_06_01_slide_01_success_menedez_slides01, 1, 0, 0, 1);
  add_actor_anim("defalco", % ch_ht_06_01_slide_01_success_delfalco_slide01, 0, 0, 0, 1);
  add_actor_anim("ending_camo", % ch_ht_06_01_slide_01_success_pmc_slide_01, 0);
  add_actor_anim("harper", % ch_ht_06_01_slide_01_success_harper_slide01, 0);
  add_prop_anim("player_body_model", % p_ht_06_01_slide_01_success_slide01, undefined, 0, 0, undefined);
  add_notetrack_custom_function("player_body_model", "start_raise_gun", maps\haiti_endings::player_start_raise_gun, 0);
  add_notetrack_flag("player_body_model", "event_01_fail", "event_01_fail");
  add_notetrack_custom_function("ending_camo", undefined, maps\haiti_endings::notetrack_camo_shoot);
  add_scene("scene_1_v2", "player_hanging");
  add_actor_anim("menendez", % ch_ht_06_01_slide_01_success_menedez_slides01, 1, 0, 0, 1);
  add_actor_anim("defalco", % ch_ht_06_01_slide_01_success_delfalco_slide01, 0, 0, 0, 1);
  add_actor_anim("ending_camo", % ch_ht_06_01_slide_01_success_pmc_slide_01, 0);
  add_prop_anim("player_body_model", % p_ht_06_01_slide_01_success_slide01, undefined, 0, 0, undefined);
  add_notetrack_custom_function("player_body_model", "start_raise_gun", maps\haiti_endings::player_start_raise_gun, 0);
  add_notetrack_flag("player_body_model", "event_01_fail", "event_01_fail");
  add_notetrack_custom_function("ending_camo", undefined, maps\haiti_endings::notetrack_camo_shoot);
  add_scene("scene_1_v3", "player_hanging");
  add_actor_anim("menendez", % ch_ht_06_01_slide_01_success_menedez_slides01, 1, 0, 0, 1);
  add_actor_anim("defalco", % ch_ht_06_01_slide_01_success_pmc2_slide01, 0, 0, 0, 1);
  add_actor_anim("ending_camo", % ch_ht_06_01_slide_01_success_pmc_slide_01, 0);
  add_actor_anim("harper", % ch_ht_06_01_slide_01_success_harper_slide01, 0);
  add_prop_anim("player_body_model", % p_ht_06_01_slide_01_success_slide01, undefined, 0, 0, undefined);
  add_notetrack_custom_function("player_body_model", "start_raise_gun", maps\haiti_endings::player_start_raise_gun, 0);
  add_notetrack_flag("player_body_model", "event_01_fail", "event_01_fail");
  add_notetrack_custom_function("ending_camo", undefined, maps\haiti_endings::notetrack_camo_shoot);
  add_scene("scene_1_v4", "player_hanging");
  add_actor_anim("menendez", % ch_ht_06_01_slide_01_success_menedez_slides01, 1, 0, 0, 1);
  add_actor_anim("defalco", % ch_ht_06_01_slide_01_success_pmc2_slide01, 0, 0, 0, 1);
  add_actor_anim("ending_camo", % ch_ht_06_01_slide_01_success_pmc_slide_01, 0);
  add_prop_anim("player_body_model", % p_ht_06_01_slide_01_success_slide01, undefined, 0, 0, undefined);
  add_notetrack_custom_function("player_body_model", "start_raise_gun", maps\haiti_endings::player_start_raise_gun, 0);
  add_notetrack_flag("player_body_model", "event_01_fail", "event_01_fail");
  add_notetrack_custom_function("ending_camo", undefined, maps\haiti_endings::notetrack_camo_shoot);
  add_scene("scene_1_v1_fail", "player_hanging");
  add_actor_anim("menendez", % ch_ht_06_01_slide_01_fail01_menendez, 1);
  add_actor_anim("defalco", % ch_ht_06_01_slide_01_fail01_defalco, 0);
  add_actor_anim("harper", % ch_ht_06_01_slide_01_fail01_harper, 0, 0, 1);
  add_prop_anim("player_body_model", % p_ht_06_01_slide_01_fail01_pmc, undefined, 0, 0, undefined);
  add_notetrack_custom_function("player_body_model", "end_slowmo", maps\haiti_endings::player_end_slowmo, 0);
  add_notetrack_flag("player_body_model", "fade_out", "fail_to_shoot");
  add_scene("scene_1_v2_fail", "player_hanging");
  add_actor_anim("menendez", % ch_ht_06_01_slide_01_fail01_menendez, 1);
  add_actor_anim("defalco", % ch_ht_06_01_slide_01_fail01_defalco, 0);
  add_prop_anim("player_body_model", % p_ht_06_01_slide_01_fail01_pmc, undefined, 0, 0, undefined);
  add_notetrack_custom_function("player_body_model", "end_slowmo", maps\haiti_endings::player_end_slowmo, 0);
  add_notetrack_flag("player_body_model", "fade_out", "fail_to_shoot");
  add_scene("scene_2_v1", "player_hanging");
  add_actor_anim("menendez", % ch_ht_06_01_slide_01_success_menedez_slides02, 1);
  add_actor_anim("defalco", % ch_ht_06_01_slide_01_success_delfalco_slides02, 0);
  add_actor_anim("harper", % ch_ht_06_01_slide_01_success_harper_slide02, 0, 0, 1);
  add_prop_anim("player_body_model", % p_ht_06_01_slide_01_success_slide02, undefined, 0, 0, undefined);
  add_notetrack_custom_function("player_body_model", "FOV_19.15_stop_b", maps\haiti_endings::fov_change_3, 0);
  add_notetrack_flag("player_body_model", "event_02_fail", "event_02_fail");
  add_notetrack_custom_function("defalco", undefined, maps\haiti_endings::notetrack_defalco_shoot);
  add_scene("scene_2_v2", "player_hanging");
  add_actor_anim("menendez", % ch_ht_06_01_slide_01_success_menedez_slides02, 1);
  add_actor_anim("defalco", % ch_ht_06_01_slide_01_success_delfalco_slides02, 0);
  add_prop_anim("player_body_model", % p_ht_06_01_slide_01_success_slide02, undefined, 0, 0, undefined);
  add_notetrack_custom_function("player_body_model", "FOV_19.15_stop_b", maps\haiti_endings::fov_change_3, 0);
  add_notetrack_flag("player_body_model", "event_02_fail", "event_02_fail");
  add_notetrack_custom_function("defalco", undefined, maps\haiti_endings::notetrack_defalco_shoot);
  add_scene("scene_2_v3", "player_hanging");
  add_actor_anim("menendez", % ch_ht_06_01_slide_01_success_menedez_slides02, 1);
  add_actor_anim("defalco", % ch_ht_06_01_slide_01_success_pmc2_slide02, 0);
  add_actor_anim("harper", % ch_ht_06_01_slide_01_success_harper_slide02, 0, 0, 1);
  add_prop_anim("player_body_model", % p_ht_06_01_slide_01_success_slide02, undefined, 0, 0, undefined);
  add_notetrack_custom_function("player_body_model", "FOV_19.15_stop_b", maps\haiti_endings::fov_change_3, 0);
  add_notetrack_flag("player_body_model", "event_02_fail", "event_02_fail");
  add_notetrack_custom_function("defalco", undefined, maps\haiti_endings::notetrack_pmc_shoot);
  add_scene("scene_2_v4", "player_hanging");
  add_actor_anim("menendez", % ch_ht_06_01_slide_01_success_menedez_slides02, 1);
  add_actor_anim("defalco", % ch_ht_06_01_slide_01_success_pmc2_slide02, 0);
  add_prop_anim("player_body_model", % p_ht_06_01_slide_01_success_slide02, undefined, 0, 0, undefined);
  add_notetrack_custom_function("player_body_model", "FOV_19.15_stop_b", maps\haiti_endings::fov_change_3, 0);
  add_notetrack_flag("player_body_model", "event_02_fail", "event_02_fail");
  add_notetrack_custom_function("defalco", undefined, maps\haiti_endings::notetrack_pmc_shoot);
  add_scene("scene_2_v1_fail", "player_hanging");
  add_actor_anim("menendez", % ch_ht_06_01_slide_01_fail01_menendez02, 1);
  add_actor_anim("defalco", % ch_ht_06_01_slide_01_fail01_defalco02, 0);
  add_prop_anim("player_body_model", % p_ht_06_01_slide_01_fail01_defalco, undefined, 0, 0, undefined);
  add_notetrack_custom_function("player_body_model", "end_slowmo", maps\haiti_endings::player_end_slowmo, 0);
  add_notetrack_custom_function("player_body_model", "fade_out", maps\haiti_endings::fade_out, 0);
  add_scene("scene_2_v2_fail", "player_hanging");
  add_actor_anim("menendez", % ch_ht_06_01_slide_01_fail01_menendez02, 1);
  add_prop_anim("player_body_model", % p_ht_06_01_slide_01_fail01_defalco, undefined, 0, 0, undefined);
  add_notetrack_custom_function("player_body_model", "end_slowmo", maps\haiti_endings::player_end_slowmo, 0);
  add_notetrack_custom_function("player_body_model", "fade_out", maps\haiti_endings::fade_out, 0);
  add_scene("moral_choice", "player_hanging");
  add_actor_anim("menendez", % ch_ht_06_01_slide_01_success_menedez_gets_stabbed_success, 1);
  add_prop_anim("player_body_model", % p_ht_06_01_slide_01_success_stab_menedez_success, undefined, 0, 0, undefined);
  add_notetrack_flag("player_body_model", "moral_event_start", "start_choice");
  add_notetrack_flag("player_body_model", "kill_menendez", "kill_menendez");
  add_notetrack_custom_function("menendez", "start_choice", maps\haiti_endings::moral_event_start, 0);
  add_notetrack_custom_function("player_body_model", "end_slowmo", maps\haiti_endings::player_end_slowmo, 0);
  add_notetrack_custom_function("player_body_model", "stab_leg", maps\haiti_endings::stab_leg, 0);
  add_notetrack_custom_function("player_body_model", "stab_shoulder", maps\haiti_endings::stab_shoulder, 0);
  add_notetrack_custom_function("player_body_model", undefined, maps\haiti_endings::player_no_headlook);
  add_notetrack_custom_function("player_body_model", "DOF_stab_menendez", maps\createart\haiti_art::dof_stab_menendez);
  add_scene("shoot_menendez", "player_hanging");
  add_actor_anim("menendez", % ch_ht_06_01_slide_01_success_menendez_killmenendez, 1, 0, 1);
  add_prop_anim("player_body_model", % p_ht_06_01_slide_01_success_killmenendez, undefined, 0, 0, undefined);
  add_notetrack_flag("player_body_model", "fade_out", "kill_menendez_fadeout");
  add_notetrack_custom_function("player_body_model", undefined, maps\haiti_endings::player_no_headlook);
  add_notetrack_custom_function("player_body_model", "fire", maps\haiti_endings::menendez_headshot, 0);
  add_scene("end05_inside_harper", "scene_1_fail");
  add_player_anim("player_body", % p_ht_06_02_end05_inside_player, 0, 0, undefined, 0);
  add_actor_anim("harper", % ch_ht_06_02_end05_inside_harper, 0);
  add_prop_anim("rebar", % o_ht_06_02_end05_inside_rebar, "rebar_anim_haiti");
  add_notetrack_flag("player_body", "fade_out", "end05_harper_fadeout");
  add_notetrack_custom_function("player_body", "fade_in", maps\haiti_endings::fade_in, 0);
  add_notetrack_custom_function("player_body", "dof_faraway", maps\createart\haiti_art::dof_faraway);
  add_notetrack_custom_function("player_body", "dof_harper_4", maps\createart\haiti_art::dof_harper_4);
  add_scene("menendez_corpse", "player_hanging", 0, 0, 1);
  add_actor_model_anim("menendez_corpse", % ch_ht_06_01_slide_01_success_menendez_kill_deadmenendez0, undefined, 1, undefined, undefined, "menendez");
  add_scene("end05_outside_player", "team_america_scene");
  add_player_anim("player_body", % p_ht_06_03_end05_outside_part_1_player, 0, 0, undefined, 1, 1, 10, 10, 10, 10, 1, 1);
  add_notetrack_custom_function("player_body", "sndPlayDoorBell", ::sndplaydoorbell);
  add_notetrack_custom_function("player_body", "sndPlayVtolLand", ::sndplayvtolland5);
  add_notetrack_custom_function("player_body", "sndPlayVtolTakeoff", ::sndplayvtoltakeoff);
  add_notetrack_custom_function("player_body", undefined, maps\haiti_endings::open_end05_gate);
  add_notetrack_custom_function("player_body", "start_drag", maps\haiti_endings::end05_start_drag, 0);
  add_notetrack_custom_function("player_body", "play_kids", maps\haiti_endings::end05_start_kids, 0);
  add_notetrack_custom_function("player_body", "stop_flash", maps\haiti_endings::turn_off_sun_flash_fx);
  add_notetrack_custom_function("player_body", "dof_quadrotor", maps\createart\haiti_art::dof_quadrotor);
  add_notetrack_custom_function("player_body", "dof_harper_1", maps\createart\haiti_art::dof_harper_1);
  add_notetrack_custom_function("player_body", "dof_vtol_1", maps\createart\haiti_art::dof_vtol_1);
  add_notetrack_custom_function("player_body", "dof_harper_2", maps\createart\haiti_art::dof_harper_2);
  add_notetrack_custom_function("player_body", "dof_vtol_2", maps\createart\haiti_art::dof_vtol_2);
  add_notetrack_custom_function("player_body", "dof_harper_track_3", maps\createart\haiti_art::dof_harper_track_3);
  add_notetrack_custom_function("player_body", "dof_harper_4", maps\createart\haiti_art::dof_harper_4);
  add_notetrack_custom_function("player_body", "dof_passing_gaurd", maps\createart\haiti_art::dof_passing_gaurd);
  add_notetrack_custom_function("player_body", "dof_drag_guy_1", maps\createart\haiti_art::dof_drag_guy_1);
  add_notetrack_custom_function("player_body", "dof_drag_guy_2", maps\createart\haiti_art::dof_drag_guy_2);
  add_notetrack_custom_function("player_body", "dof_kid_helper", maps\createart\haiti_art::dof_kid_helper);
  add_notetrack_custom_function("player_body", "dof_kids", maps\createart\haiti_art::dof_kids);
  add_notetrack_custom_function("player_body", "dof_vtol_liftoff", maps\createart\haiti_art::dof_vtol_liftoff);
  add_notetrack_custom_function("player_body", "dof_vtol_flight", maps\createart\haiti_art::dof_vtol_flight);
  add_notetrack_custom_function("player_body", undefined, maps\haiti_endings::end05_fade_out_black, 0);
  add_scene("end05_outside_quad", "team_america_scene");
  add_vehicle_anim("end_quadrotor_1", % v_ht_06_03_end05_outside_part_1_quadrotor, 1);
  add_scene("end05_outside_harper", "team_america_scene");
  add_actor_anim("harper", % ch_ht_06_03_end05_outside_part_1_harper, 0, 0);
  add_cheap_actor_model_anim("harper_doctor", % ch_ht_06_03_end05_outside_part_1_medic, undefined, 1, undefined, undefined, "ally_ending");
  add_scene("end05_outside_vtol", "team_america_scene");
  add_vehicle_anim("menendez_vtol", % v_ht_06_03_end05_outside_part_1_menendez_vtol, 0, undefined, undefined, undefined);
  add_notetrack_custom_function("menendez_vtol", undefined, maps\haiti_endings::menendez_vtol_engines_on);
  add_notetrack_custom_function("menendez_vtol", "engine_off", maps\haiti_endings::menendez_vtol_engines_off);
  add_notetrack_custom_function("menendez_vtol", "engine_on", maps\haiti_endings::menendez_vtol_engines_on_final);
  add_scene("end05_outside_officers", "menendez_vtol");
  add_cheap_actor_model_anim("end05_officer3", % ch_ht_06_03_end05_outside_part_1_officer_3, undefined, 1, "tag_origin", undefined, "ally_ending");
  add_cheap_actor_model_anim("end05_officer4", % ch_ht_06_03_end05_outside_part_1_officer_4, undefined, 1, "tag_origin", undefined, "ally_ending");
  add_cheap_actor_model_anim("end05_officer5", % ch_ht_06_03_end05_outside_part_1_officer_5, undefined, 1, "tag_origin", undefined, "ally_ending");
  add_notetrack_attach("end05_officer3", undefined, "t6_wpn_lmg_mk48_world", "tag_weapon_right");
  add_notetrack_attach("end05_officer4", undefined, "t6_wpn_lmg_mk48_world", "tag_weapon_right");
  add_notetrack_attach("end05_officer5", undefined, "t6_wpn_lmg_mk48_world", "tag_weapon_right");
  add_scene("end05_civ_helper_loop", "team_america_scene", 0, 0, 1);
  add_cheap_actor_model_anim("end05_medic", % ch_ht_06_03_end05_outside_part_1_kids_helper_loop, undefined, 0, undefined, undefined, "ally_ending");
  add_scene("end05_civ_kids", "team_america_scene");
  add_cheap_actor_model_anim("end05_boy", % ch_ht_06_03_end05_outside_part_1_boy, undefined, 0, undefined, undefined, "ending_boy");
  add_cheap_actor_model_anim("end05_girl", % ch_ht_06_03_end05_outside_part_1_girl, undefined, 0, undefined, undefined, "ending_girl");
  add_cheap_actor_model_anim("end05_medic", % ch_ht_06_03_end05_outside_part_1_kids_helper, undefined, 0, undefined, undefined, "ally_ending");
  add_notetrack_attach("end05_medic", undefined, "t6_wpn_lmg_mk48_world", "tag_weapon_right");
  add_scene("end05_drag_body", "team_america_scene");
  add_cheap_actor_model_anim("end05_drag_body_01", % ch_ht_06_03_end05_outside_part_1_drag_body_guy_01, undefined, 1, undefined, undefined, "pmc_assault");
  add_cheap_actor_model_anim("end05_drag_body_02", % ch_ht_06_03_end05_outside_part_1_drag_body_guy_02, undefined, 1, undefined, undefined, "ally_ending");
  add_cheap_actor_model_anim("end05_drag_body_03", % ch_ht_06_03_end05_outside_part_1_drag_body_guy_03, undefined, 1, undefined, undefined, "ally_ending");
  add_scene("end05_civ_vtol", "team_america_scene2");
  add_prop_anim("ending_vtol1", % v_ht_06_03_end05_civ_vtol, "veh_t6_air_v78_vtol");
  add_scene("end06_outside_player", "team_america_scene");
  add_player_anim("player_body", % p_ht_06_03_end06_outside_part_1_player, 0, 0, undefined, 1, 1, 10, 10, 10, 10, 1, 1);
  add_notetrack_custom_function("player_body", "sndPlayDoorBell", ::sndplaydoorbell);
  add_notetrack_custom_function("player_body", "sndPlayVtolLand", ::sndplayvtolland6);
  add_notetrack_custom_function("player_body", "sndPlayVtolTakeoff", ::sndplayvtoltakeoff);
  add_notetrack_custom_function("player_body", undefined, maps\haiti_endings::open_gate);
  add_notetrack_custom_function("player_body", "open_doors", maps\haiti_endings::notetrack_eye_candy01);
  add_notetrack_custom_function("player_body", "start_drag", maps\haiti_endings::end06_start_drag, 0);
  add_notetrack_custom_function("player_body", "start_kids", maps\haiti_endings::end06_start_kids, 0);
  add_notetrack_custom_function("player_body", "stop_flash", maps\haiti_endings::turn_off_sun_flash_fx);
  add_notetrack_custom_function("player_body", "dof_vtol_1", maps\createart\haiti_art::dof_vtol_1);
  add_notetrack_custom_function("player_body", "dof_quadrotor", maps\createart\haiti_art::dof_quadrotor);
  add_notetrack_custom_function("player_body", "dof_vtol_2", maps\createart\haiti_art::dof_vtol_2);
  add_notetrack_custom_function("player_body", "dof_drag_guy_1", maps\createart\haiti_art::dof_drag_guy_1);
  add_notetrack_custom_function("player_body", "dof_drag_guy_2", maps\createart\haiti_art::dof_drag_guy_2);
  add_notetrack_custom_function("player_body", "dof_kid_helper", maps\createart\haiti_art::dof_kid_helper);
  add_notetrack_custom_function("player_body", "dof_kids", maps\createart\haiti_art::dof_kids);
  add_notetrack_custom_function("player_body", "dof_vtol_liftoff", maps\createart\haiti_art::dof_vtol_liftoff);
  add_notetrack_custom_function("player_body", "dof_vtol_flight", maps\createart\haiti_art::dof_vtol_flight);
  add_notetrack_custom_function("player_body", "dof_sunset", maps\createart\haiti_art::dof_sunset);
  add_notetrack_custom_function("player_body", undefined, maps\haiti_endings::end06_fade_out_black, 0);
  add_scene("end06_outside_quad", "team_america_scene");
  add_vehicle_anim("end_quadrotor_1", % v_ht_06_03_end06_outside_part_1_quadrotor, 1);
  add_scene("end06_outside_vtol", "team_america_scene");
  add_vehicle_anim("menendez_vtol", % v_ht_06_03_end06_outside_part_1_menendez_vtol, 0, undefined, undefined, undefined);
  add_notetrack_custom_function("menendez_vtol", undefined, maps\haiti_endings::menendez_vtol_engines_on);
  add_notetrack_custom_function("menendez_vtol", "engine_off", maps\haiti_endings::menendez_vtol_engines_off);
  add_notetrack_custom_function("menendez_vtol", "engine on", maps\haiti_endings::menendez_vtol_engines_on_final);
  add_scene("end06_outside_officers", "menendez_vtol");
  add_cheap_actor_model_anim("end06_officer3", % ch_ht_06_03_end06_outside_part_1_officer_3, undefined, 1, "tag_origin", undefined, "ally_ending");
  add_cheap_actor_model_anim("end06_officer4", % ch_ht_06_03_end06_outside_part_1_officer_4, undefined, 1, "tag_origin", undefined, "ally_ending");
  add_cheap_actor_model_anim("end06_officer5", % ch_ht_06_03_end06_outside_part_1_officer_5, undefined, 1, "tag_origin", undefined, "ally_ending");
  add_notetrack_attach("end06_officer3", undefined, "t6_wpn_lmg_mk48_world", "tag_weapon_right");
  add_notetrack_attach("end06_officer4", undefined, "t6_wpn_lmg_mk48_world", "tag_weapon_right");
  add_notetrack_attach("end06_officer5", undefined, "t6_wpn_lmg_mk48_world", "tag_weapon_right");
  add_scene("end06_civ_helper_loop", "team_america_scene", 0, 0, 1);
  add_cheap_actor_model_anim("end06_medic", % ch_ht_06_03_end06_outside_part_1_kids_helper_loop, undefined, 1, undefined, undefined, "ally_ending");
  add_scene("end06_civ_kids", "team_america_scene");
  add_cheap_actor_model_anim("end06_boy", % ch_ht_06_03_end06_outside_part_1_boy, undefined, 0, undefined, undefined, "ending_boy");
  add_cheap_actor_model_anim("end06_girl", % ch_ht_06_03_end06_outside_part_1_girl, undefined, 0, undefined, undefined, "ending_girl");
  add_cheap_actor_model_anim("end06_medic", % ch_ht_06_03_end06_outside_part_1_kids_helper, undefined, 0, undefined, undefined, "ally_ending");
  add_notetrack_attach("end06_medic", undefined, "t6_wpn_lmg_mk48_world", "tag_weapon_right");
  add_scene("end06_drag_body", "team_america_scene");
  add_cheap_actor_model_anim("end06_drag_body_01", % ch_ht_06_03_end06_outside_part_1_drag_body_guy_01, undefined, 1, undefined, undefined, "pmc_assault");
  add_cheap_actor_model_anim("end06_drag_body_02", % ch_ht_06_03_end06_outside_part_1_drag_body_guy_02, undefined, 1, undefined, undefined, "ally_ending");
  add_cheap_actor_model_anim("end06_drag_body_03", % ch_ht_06_03_end06_outside_part_1_drag_body_guy_03, undefined, 1, undefined, undefined, "ally_ending");
  add_scene("end06_civ_vtol", "team_america_scene2");
  add_prop_anim("ending_vtol1", % v_ht_06_03_end06_civ_vtol, "veh_t6_air_v78_vtol");
  add_scene("end03_harperalive", "player_hanging");
  add_prop_anim("player_body_model", % p_ht_06_02_end03_inside_player, undefined, 1, 0, undefined);
  add_actor_anim("harper", % ch_ht_06_02_end03_inside_harper, 1, 0, 1);
  add_actor_anim("menendez", % ch_ht_06_02_end03_inside_menendez, 1, 0, 1, 1);
  add_prop_anim("rebar", % o_ht_06_02_end03_inside_rebar, "rebar_anim_haiti");
  add_notetrack_flag("player_body_model", "fade_out", "end03_harperalive_fadeout");
  add_notetrack_custom_function("harper", "blood_fx", maps\haiti_endings::rebar_blood_fx, 0);
  add_notetrack_custom_function("player_body_model", "dof_menendez", maps\createart\haiti_art::dof_menendez_capture);
  add_notetrack_custom_function("player_body_model", "dof_harper", maps\createart\haiti_art::dof_harper_capture);
  add_scene("end04_harperdead", "player_hanging");
  add_actor_anim("menendez", % ch_ht_06_02_end04_inside_menendez, 1, 0, 1, 1);
  add_prop_anim("player_body_model", % p_ht_06_02_end04_inside_player, undefined, 1, 0, undefined);
  add_notetrack_flag("player_body_model", "fade_out", "end04_harperdead_fadeout");
  add_notetrack_custom_function("player_body_model", "dof_menendez", maps\createart\haiti_art::dof_menendez_capture);
  add_scene("capture_menendez1_1", "team_america_scene");
  add_player_anim("player_body", % p_ht_06_03_end04_outside_part_1_player, 0, 0, undefined, 1, 1, 10, 10, 10, 10, 1, 1);
  add_vehicle_anim("end_quadrotor_1", % v_ht_06_03_end04_outside_part_1_quadrotor, 1);
  add_vehicle_anim("menendez_vtol", % v_ht_06_03_end04_outside_part_1_menendez_vtol, 0, undefined, undefined, undefined);
  add_actor_anim("menendez", % ch_ht_06_03_end04_outside_part_1_menendez, 1, 0, 0, 1);
  add_prop_anim("gun", % o_ht_06_03_end04_outside_part_1_player_gun, "t6_wpn_pistol_fnp45_view");
  add_notetrack_custom_function("gun", undefined, maps\haiti_endings::notetrack_set_blend_times);
  add_notetrack_custom_function("player_body", "sndPlayDoorBell", ::sndplaydoorbell);
  add_notetrack_custom_function("player_body", "sndPlayVtolLand", ::sndplayvtolland);
  add_notetrack_custom_function("end_quadrotor_1", undefined, maps\haiti_endings::notetrack_set_blend_times);
  add_notetrack_custom_function("menendez_vtol", undefined, maps\haiti_endings::notetrack_set_blend_times);
  add_notetrack_custom_function("menendez", undefined, maps\haiti_endings::notetrack_set_blend_times);
  add_notetrack_custom_function("menendez_vtol", undefined, maps\haiti_endings::menendez_vtol_engines_on);
  add_notetrack_custom_function("menendez_vtol", "engines_off", maps\haiti_endings::menendez_vtol_engines_off);
  add_notetrack_custom_function("player_body", undefined, maps\haiti_endings::open_gate);
  add_notetrack_custom_function("player_body", undefined, maps\haiti_endings::notetrack_set_blend_times);
  add_notetrack_custom_function("player_body", "start_drag", maps\haiti_endings::end04_start_drag, 0);
  add_notetrack_custom_function("player_body", "dof_start", maps\createart\haiti_art::dof_start);
  add_notetrack_custom_function("player_body", "dof_walk_out", maps\createart\haiti_art::dof_walk_out);
  add_notetrack_custom_function("player_body", "dof_walk_menendez", maps\createart\haiti_art::dof_walk_menendez);
  add_notetrack_custom_function("player_body", "stop_flash", maps\haiti_endings::turn_off_sun_flash_fx);
  add_notetrack_custom_function("player_body", undefined, maps\haiti_endings::end04_fade_out_black, 0);
  add_notetrack_custom_function("player_body", "open_doors", maps\haiti_endings::notetrack_eye_candy01);
  add_scene("capture_menendez1_2", "menendez_vtol");
  add_cheap_actor_model_anim("officer_1", % ch_ht_06_03_end04_outside_part_1_officer_1, undefined, 0, "tag_origin", undefined, "ally_ending");
  add_cheap_actor_model_anim("officer_2", % ch_ht_06_03_end04_outside_part_1_officer_2, undefined, 0, "tag_origin", undefined, "ally_ending");
  add_notetrack_custom_function("officer_1", undefined, maps\haiti_endings::notetrack_set_blend_times);
  add_notetrack_custom_function("officer_2", undefined, maps\haiti_endings::notetrack_set_blend_times);
  add_scene("capture_menendez1_3", "team_america_scene");
  add_cheap_actor_model_anim("end04_drag_body_01", % ch_ht_06_03_end04_outside_part_1_drag_body_guy_01, undefined, 1, undefined, undefined, "pmc_assault");
  add_cheap_actor_model_anim("end04_drag_body_02", % ch_ht_06_03_end04_outside_part_1_drag_body_guy_02, undefined, 1, undefined, undefined, "ally_ending");
  add_cheap_actor_model_anim("end04_drag_body_03", % ch_ht_06_03_end04_outside_part_1_drag_body_guy_03, undefined, 1, undefined, undefined, "ally_ending");
  add_scene("capture_harper_medic", "team_america_scene");
  add_actor_anim("harper", % ch_ht_06_03_end04_outside_part_1_harper, 0, 0);
  add_cheap_actor_model_anim("harper_doctor", % ch_ht_06_03_end04_outside_part_1_medic, undefined, 1, undefined, undefined, "ally_ending");
  add_notetrack_custom_function("harper_doctor", undefined, maps\haiti_endings::notetrack_set_blend_times);
  add_scene("capture_menendez2_1", "team_america_scene");
  add_player_anim("player_body", % p_ht_06_03_end04_outside_part_2_player, 0, 0, undefined, 1, 1, 10, 10, 10, 10, 1, 1);
  add_vehicle_anim("menendez_vtol", % v_ht_06_03_end04_outside_part_2_menendez_vtol, 0, undefined, undefined, undefined);
  add_actor_anim("menendez", % ch_ht_06_03_end04_outside_part_2_menendez, 1, 0, 0, 1);
  add_prop_anim("gun", % o_ht_06_03_end04_outside_part_2_player_gun, "t6_wpn_pistol_fnp45_view");
  add_prop_anim("bandana", % o_ht_06_03_end04_outside_part_2_bandana, "bandana_anim_haiti");
  add_notetrack_flag("player_body", "Show_medic_area", "Show_medic_area");
  add_notetrack_custom_function("player_body", "sndPlayVtolTakeoff", ::sndplayvtoltakeoff);
  add_notetrack_custom_function("bandana", "bandana_show", maps\haiti_endings::notetrack_bandana_show);
  add_notetrack_custom_function("bandana", "bandana_hide", maps\haiti_endings::notetrack_bandana_hide);
  add_notetrack_custom_function("menendez_vtol", "engines_on", maps\haiti_endings::menendez_vtol_engines_on_final);
  add_scene("capture_menendez2_2", "menendez_vtol");
  add_cheap_actor_model_anim("officer_1", % ch_ht_06_03_end04_outside_part_2_officer_1, undefined, 0, "tag_origin", undefined, "ally_ending");
  add_cheap_actor_model_anim("officer_2", % ch_ht_06_03_end04_outside_part_2_officer_2, undefined, 0, "tag_origin", undefined, "ally_ending");
  add_scene("capture_menendez3_1", "team_america_scene");
  add_player_anim("player_body", % p_ht_06_03_end04_outside_part_3_player, 0, 0, undefined, 1, 1, 10, 10, 10, 10, 1, 1);
  add_vehicle_anim("menendez_vtol", % v_ht_06_03_end04_outside_part_3_menendez_vtol, 0, undefined, undefined, undefined);
  add_notetrack_custom_function("player_body", "dof_vtol_leave", maps\createart\haiti_art::dof_vtol_leave);
  add_scene("capture_menendez3_2", "menendez_vtol");
  add_cheap_actor_model_anim("officer_1", % ch_ht_06_03_end04_outside_part_3_officer_1, undefined, 0, "tag_origin", undefined, "ally_ending");
  add_cheap_actor_model_anim("officer_2", % ch_ht_06_03_end04_outside_part_3_officer_2, undefined, 0, "tag_origin", undefined, "ally_ending");
  add_scene("capture_menendez3_3", "team_america_scene");
  add_actor_anim("menendez", % ch_ht_06_03_end04_outside_part_3_menendez, 1, 0, 1, 1);
  add_scene("end04_civ_vtol", "team_america_scene2");
  add_prop_anim("ending_vtol1", % v_ht_06_03_end04_civ_vtol, "veh_t6_air_v78_vtol");
  add_scene("end_right_vtol", "team_america_scene");
  add_prop_anim("ending_vtol2", % v_ht_06_03_end04_harper_vtol, "veh_t6_air_v78_vtol");
  add_scene("vtol_group1", "ending_vtol1");
  add_cheap_actor_model_anim("line_up_soldier_3", % ch_ht_06_03_civ_vtol_civ_3, undefined, 0, "tag_origin", undefined, "pmc_assault");
  add_cheap_actor_model_anim("line_up_clipboardguy", % ch_ht_06_03_civ_vtol_clipboardguy, undefined, 0, "tag_origin", undefined, "ally_ending");
  add_notetrack_attach("line_up_clipboardguy", undefined, "p_glo_clipboard_wpaper", "tag_weapon_left");
  add_scene("vtol_civ4_idle", "ending_vtol1", 0, 0, 1);
  add_cheap_actor_model_anim("line_up_soldier_4", % ch_ht_06_03_civ_vtol_civ_4, undefined, undefined, "tag_origin", undefined, "pmc_assault");
  add_scene("vtol_civ5_idle", "ending_vtol1", 0, 0, 1);
  add_cheap_actor_model_anim("line_up_soldier_5", % ch_ht_06_03_civ_vtol_civ_5, undefined, undefined, "tag_origin", undefined, "pmc_assault");
  add_scene("vtol_civ6_idle", "ending_vtol1", 0, 0, 1);
  add_cheap_actor_model_anim("line_up_soldier_6", % ch_ht_06_03_civ_vtol_civ_6, undefined, undefined, "tag_origin", undefined, "pmc_assault");
  add_scene("vtol_civ7_idle", "ending_vtol1", 0, 0, 1);
  add_cheap_actor_model_anim("line_up_soldier_7", % ch_ht_06_03_civ_vtol_civ_7, undefined, undefined, "tag_origin", undefined, "ally_ending");
  add_scene("medic_group1_loop", "medic_group1", 0, 0, 1);
  add_cheap_actor_model_anim("medic_group1_1", % ch_ht_06_03_medicsection_grp01_doctor01, undefined, undefined, undefined, undefined, "ally_ending");
  add_cheap_actor_model_anim("medic_group1_2", % ch_ht_06_03_medicsection_grp01_doctor02, undefined, undefined, undefined, undefined, "ally_ending");
  add_cheap_actor_model_anim("medic_group1_3", % ch_ht_06_03_medicsection_grp01_injured01, undefined, undefined, undefined, undefined, "ally_ending");
  add_scene("medic_group1_1_loop", "medic_group1_1", 0, 0, 1);
  add_cheap_actor_model_anim("medic_group1_1_1", % ch_ht_06_03_medicsection_grp01_doctor01, undefined, undefined, undefined, undefined, "ally_ending");
  add_cheap_actor_model_anim("medic_group1_1_2", % ch_ht_06_03_medicsection_grp01_doctor02, undefined, undefined, undefined, undefined, "ally_ending");
  add_cheap_actor_model_anim("medic_group1_1_3", % ch_ht_06_03_medicsection_grp01_injured01, undefined, undefined, undefined, undefined, "ally_ending");
  add_scene("medic_group2_loop", "medic_group2", 0, 0, 1);
  add_cheap_actor_model_anim("medic_group2_1", % ch_ht_06_03_medicsection_grp02_doctor03, undefined, 1, undefined, undefined, "ally_ending");
  add_cheap_actor_model_anim("medic_group2_2", % ch_ht_06_03_medicsection_grp02_injured02, undefined, 1, undefined, undefined, "ally_ending");
  add_scene("medic_group3_loop", "medic_group1", 0, 0, 1);
  add_cheap_actor_model_anim("medic_group3_1", % ch_ht_06_03_medicsection_grp03_doctor04, undefined, 1, undefined, undefined, "ally_ending");
  add_cheap_actor_model_anim("medic_group3_2", % ch_ht_06_03_medicsection_grp03_injured03, undefined, 1, undefined, undefined, "pmc_assault");
  add_scene("medic_group4_loop", "medic_group4", 0, 0, 1);
  add_cheap_actor_model_anim("medic_group4_1", % ch_ht_06_03_medicsection_grp04_doctor05, undefined, 1, undefined, undefined, "ally_ending");
  add_cheap_actor_model_anim("medic_group4_2", % ch_ht_06_03_medicsection_grp04_injured04, undefined, 1, undefined, undefined, "pmc_assault");
  add_scene("medic_group5_loop", "medic_group5", 0, 0, 1);
  add_cheap_actor_model_anim("medic_group5_1", % ch_ht_06_03_medicsection_grp05_doctor06, undefined, 1, undefined, undefined, "ally_ending");
  add_cheap_actor_model_anim("medic_group5_2", % ch_ht_06_03_medicsection_grp05_injured05, undefined, 1, undefined, undefined, "pmc_assault");
  add_scene("grp01_guard01_loop", "prisoner_group1", 0, 0, 1);
  add_cheap_actor_model_anim("grp01_guard01", % ch_ht_06_03_prisoner_vignettes_grp01_guard01_cycle, undefined, 1, undefined, undefined, "ally_ending");
  add_scene("grp01_guard02", "prisoner_group1");
  add_cheap_actor_model_anim("grp01_guard02", % ch_ht_06_03_prisoner_vignettes_grp01_guard02, undefined, undefined, undefined, undefined, "ally_ending");
  add_scene("grp01_guard02_loop", "prisoner_group1", 0, 0, 1);
  add_cheap_actor_model_anim("grp01_guard02", % ch_ht_06_03_prisoner_vignettes_grp01_guard02_cycle, undefined, 1, undefined, undefined, "ally_ending");
  add_scene("grp01_guard03", "prisoner_group1");
  add_cheap_actor_model_anim("grp01_guard03", % ch_ht_06_03_prisoner_vignettes_grp01_guard03, undefined, undefined, undefined, undefined, "ally_ending");
  add_scene("grp01_guard03_loop", "prisoner_group1", 0, 0, 1);
  add_cheap_actor_model_anim("grp01_guard03", % ch_ht_06_03_prisoner_vignettes_grp01_guard03_cycle, undefined, 1, undefined, undefined, "ally_ending");
  add_scene("grp01_prisoner1_loop", "prisoner_group1", 0, 0, 1);
  add_cheap_actor_model_anim("grp01_prisoner01", % ch_ht_06_03_prisoner_vignettes_grp01_prisoner01_cycle, undefined, 1, undefined, undefined, "pmc_assault");
  add_cheap_actor_model_anim("grp01_prisoner02", % ch_ht_06_03_prisoner_vignettes_grp01_prisoner02_cycle, undefined, 1, undefined, undefined, "pmc_assault");
  add_scene("grp01_prisoner2_loop", "prisoner_group1", 0, 0, 1);
  add_cheap_actor_model_anim("grp01_prisoner03", % ch_ht_06_03_prisoner_vignettes_grp01_prisoner03_cycle, undefined, 1, undefined, undefined, "pmc_assault");
  add_cheap_actor_model_anim("grp01_prisoner04", % ch_ht_06_03_prisoner_vignettes_grp01_prisoner04_cycle, undefined, 1, undefined, undefined, "pmc_assault");
  add_scene("grp01_prisoner05", "prisoner_group1");
  add_cheap_actor_model_anim("grp01_prisoner05", % ch_ht_06_03_prisoner_vignettes_grp01_prisoner05, undefined, undefined, undefined, undefined, "pmc_assault");
  add_scene("grp01_prisoner05_loop", "prisoner_group1", 0, 0, 1);
  add_cheap_actor_model_anim("grp01_prisoner05", % ch_ht_06_03_prisoner_vignettes_grp01_prisoner05_cycle, undefined, 1, undefined, undefined, "pmc_assault");
  add_scene("grp01_guard01_1_loop", "prisoner_group1_1", 0, 0, 1);
  add_cheap_actor_model_anim("grp01_guard01_1", % ch_ht_06_03_prisoner_vignettes_grp01_guard01_cycle, undefined, 1, undefined, undefined, "ally_ending");
  add_scene("grp01_guard02_1", "prisoner_group1_1");
  add_cheap_actor_model_anim("grp01_guard02_1", % ch_ht_06_03_prisoner_vignettes_grp01_guard02, undefined, undefined, undefined, undefined, "ally_ending");
  add_scene("grp01_guard02_1_loop", "prisoner_group1_1", 0, 0, 1);
  add_cheap_actor_model_anim("grp01_guard02_1", % ch_ht_06_03_prisoner_vignettes_grp01_guard02_cycle, undefined, 1, undefined, undefined, "ally_ending");
  add_scene("grp01_guard03_1", "prisoner_group1_1");
  add_cheap_actor_model_anim("grp01_guard03_1", % ch_ht_06_03_prisoner_vignettes_grp01_guard03, undefined, undefined, undefined, undefined, "ally_ending");
  add_scene("grp01_guard03_1_loop", "prisoner_group1_1", 0, 0, 1);
  add_cheap_actor_model_anim("grp01_guard03_1", % ch_ht_06_03_prisoner_vignettes_grp01_guard03_cycle, undefined, 1, undefined, undefined, "ally_ending");
  add_scene("grp01_prisoner1_1_loop", "prisoner_group1_1", 0, 0, 1);
  add_cheap_actor_model_anim("grp01_prisoner01_1", % ch_ht_06_03_prisoner_vignettes_grp01_prisoner01_cycle, undefined, 1, undefined, undefined, "pmc_assault");
  add_cheap_actor_model_anim("grp01_prisoner02_1", % ch_ht_06_03_prisoner_vignettes_grp01_prisoner02_cycle, undefined, 1, undefined, undefined, "pmc_assault");
  add_scene("grp01_prisoner2_1_loop", "prisoner_group1_1", 0, 0, 1);
  add_cheap_actor_model_anim("grp01_prisoner04_1", % ch_ht_06_03_prisoner_vignettes_grp01_prisoner04_cycle, undefined, 1, undefined, undefined, "pmc_assault");
  add_scene("grp01_prisoner05_1", "prisoner_group1_1");
  add_cheap_actor_model_anim("grp01_prisoner05_1", % ch_ht_06_03_prisoner_vignettes_grp01_prisoner05, undefined, undefined, undefined, undefined, "pmc_assault");
  add_scene("grp01_prisoner05_1_loop", "prisoner_group1_1", 0, 0, 1);
  add_cheap_actor_model_anim("grp01_prisoner05_1", % ch_ht_06_03_prisoner_vignettes_grp01_prisoner05_cycle, undefined, 1, undefined, undefined, "pmc_assault");
  add_scene("grp02_guard04", "prisoner_group2");
  add_cheap_actor_model_anim("grp02_guard04", % ch_ht_06_03_prisoner_vignettes_grp02_guard04, undefined, undefined, undefined, undefined, "ally_ending");
  add_scene("grp02_guard04_loop", "prisoner_group2", 0, 0, 1);
  add_cheap_actor_model_anim("grp02_guard04", % ch_ht_06_03_prisoner_vignettes_grp02_guard04_cycle, undefined, 1, undefined, undefined, "ally_ending");
  add_scene("grp02_guard05", "prisoner_group2");
  add_cheap_actor_model_anim("grp02_guard05", % ch_ht_06_03_prisoner_vignettes_grp02_guard05, undefined, undefined, undefined, undefined, "ally_ending");
  add_scene("grp02_guard05_loop", "prisoner_group2", 0, 0, 1);
  add_cheap_actor_model_anim("grp02_guard05", % ch_ht_06_03_prisoner_vignettes_grp02_guard05_cycle, undefined, 1, undefined, undefined, "ally_ending");
  add_scene("grp02_prisoner06", "prisoner_group2");
  add_cheap_actor_model_anim("grp02_prisoner06", % ch_ht_06_03_prisoner_vignettes_grp02_prisoner06, undefined, undefined, undefined, undefined, "pmc_assault");
  add_scene("grp02_prisoner06_loop", "prisoner_group2", 0, 0, 1);
  add_cheap_actor_model_anim("grp02_prisoner06", % ch_ht_06_03_prisoner_vignettes_grp02_prisoner06_cycle, undefined, 1, undefined, undefined, "pmc_assault");
  add_scene("grp02_prisoner07", "prisoner_group2");
  add_cheap_actor_model_anim("grp02_prisoner07", % ch_ht_06_03_prisoner_vignettes_grp02_prisoner07, undefined, undefined, undefined, undefined, "pmc_assault");
  add_scene("grp02_prisoner07_loop", "prisoner_group2", 0, 0, 1);
  add_cheap_actor_model_anim("grp02_prisoner07", % ch_ht_06_03_prisoner_vignettes_grp02_prisoner07_cycle, undefined, 1, undefined, undefined, "pmc_assault");
  add_scene("grp02_prisoner08", "prisoner_group2");
  add_cheap_actor_model_anim("grp02_prisoner08", % ch_ht_06_03_prisoner_vignettes_grp02_prisoner08, undefined, undefined, undefined, undefined, "pmc_assault");
  add_scene("grp02_prisoner08_loop", "prisoner_group2", 0, 0, 1);
  add_cheap_actor_model_anim("grp02_prisoner08", % ch_ht_06_03_prisoner_vignettes_grp02_prisoner08_cycle, undefined, 1, undefined, undefined, "pmc_assault");
  add_scene("grp02_prisoner09", "prisoner_group2");
  add_cheap_actor_model_anim("grp02_prisoner09", % ch_ht_06_03_prisoner_vignettes_grp02_prisoner09, undefined, undefined, undefined, undefined, "pmc_assault");
  add_scene("grp02_prisoner09_loop", "prisoner_group2", 0, 0, 1);
  add_cheap_actor_model_anim("grp02_prisoner09", % ch_ht_06_03_prisoner_vignettes_grp02_prisoner09_cycle, undefined, 1, undefined, undefined, "pmc_assault");
  add_scene("grp02_guard04_1", "prisoner_group2_1");
  add_cheap_actor_model_anim("grp02_guard04_1", % ch_ht_06_03_prisoner_vignettes_grp02_guard04, undefined, undefined, undefined, undefined, "ally_ending");
  add_scene("grp02_guard04_1_loop", "prisoner_group2_1", 0, 0, 1);
  add_cheap_actor_model_anim("grp02_guard04_1", % ch_ht_06_03_prisoner_vignettes_grp02_guard04_cycle, undefined, 1, undefined, undefined, "ally_ending");
  add_scene("grp02_guard05_1", "prisoner_group2_1");
  add_cheap_actor_model_anim("grp02_guard05_1", % ch_ht_06_03_prisoner_vignettes_grp02_guard05, undefined, undefined, undefined, undefined, "ally_ending");
  add_scene("grp02_guard05_1_loop", "prisoner_group2_1", 0, 0, 1);
  add_cheap_actor_model_anim("grp02_guard05_1", % ch_ht_06_03_prisoner_vignettes_grp02_guard05_cycle, undefined, 1, undefined, undefined, "ally_ending");
  add_scene("grp02_prisoner06_1", "prisoner_group2_1");
  add_cheap_actor_model_anim("grp02_prisoner06_1", % ch_ht_06_03_prisoner_vignettes_grp02_prisoner06, undefined, undefined, undefined, undefined, "pmc_assault");
  add_scene("grp02_prisoner06_1_loop", "prisoner_group2_1", 0, 0, 1);
  add_cheap_actor_model_anim("grp02_prisoner06_1", % ch_ht_06_03_prisoner_vignettes_grp02_prisoner06_cycle, undefined, 1, undefined, undefined, "pmc_assault");
  add_scene("grp02_prisoner07_1", "prisoner_group2_1");
  add_cheap_actor_model_anim("grp02_prisoner07_1", % ch_ht_06_03_prisoner_vignettes_grp02_prisoner07, undefined, undefined, undefined, undefined, "pmc_assault");
  add_scene("grp02_prisoner07_1_loop", "prisoner_group2_1", 0, 0, 1);
  add_cheap_actor_model_anim("grp02_prisoner07_1", % ch_ht_06_03_prisoner_vignettes_grp02_prisoner07_cycle, undefined, 1, undefined, undefined, "pmc_assault");
  add_scene("grp02_prisoner08_1", "prisoner_group2_1");
  add_cheap_actor_model_anim("grp02_prisoner08_1", % ch_ht_06_03_prisoner_vignettes_grp02_prisoner08, undefined, undefined, undefined, undefined, "pmc_assault");
  add_scene("grp02_prisoner08_1_loop", "prisoner_group2_1", 0, 0, 1);
  add_cheap_actor_model_anim("grp02_prisoner08_1", % ch_ht_06_03_prisoner_vignettes_grp02_prisoner08_cycle, undefined, 1, undefined, undefined, "pmc_assault");
  add_scene("grp02_prisoner09_1", "prisoner_group2_1");
  add_cheap_actor_model_anim("grp02_prisoner09_1", % ch_ht_06_03_prisoner_vignettes_grp02_prisoner09, undefined, undefined, undefined, undefined, "pmc_assault");
  add_scene("grp02_prisoner09_1_loop", "prisoner_group2_1", 0, 0, 1);
  add_cheap_actor_model_anim("grp02_prisoner09_1", % ch_ht_06_03_prisoner_vignettes_grp02_prisoner09_cycle, undefined, 1, undefined, undefined, "pmc_assault");
  add_scene("landing_guy", "landing_guy");
  add_cheap_actor_model_anim("landing_guy", % ch_ht_06_01_vtol_landing_guy2, undefined, 1, undefined, undefined, "ally_ending");
  add_scene("reactions_grp01_1_intro", "reaction_group1");
  add_cheap_actor_model_anim("react1_soldier01", % ch_ht_06_03_reactions_grp01_soldier01_intro, undefined, 1, undefined, undefined, "ally_ending");
  add_scene("reactions_grp01_1_mid", "reaction_group1");
  add_cheap_actor_model_anim("react1_soldier01", % ch_ht_06_03_reactions_grp01_soldier01_reaction, undefined, undefined, undefined, undefined, "ally_ending");
  add_scene("reactions_grp01_1_loop", "reaction_group1", 0, 0, 1);
  add_cheap_actor_model_anim("react1_soldier01", % ch_ht_06_03_reactions_grp01_soldier01_cycle, undefined, 1, undefined, undefined, "ally_ending");
  add_scene("reactions_grp01_2_intro", "reaction_group1");
  add_cheap_actor_model_anim("react1_soldier02", % ch_ht_06_03_reactions_grp01_soldier02_intro, undefined, 1, undefined, undefined, "ally_ending");
  add_scene("reactions_grp01_2_mid", "reaction_group1");
  add_cheap_actor_model_anim("react1_soldier02", % ch_ht_06_03_reactions_grp01_soldier02_reaction, undefined, undefined, undefined, undefined, "ally_ending");
  add_scene("reactions_grp01_2_loop", "reaction_group1", 0, 0, 1);
  add_cheap_actor_model_anim("react1_soldier02", % ch_ht_06_03_reactions_grp01_soldier02_cyle, undefined, 1, undefined, undefined, "ally_ending");
  add_scene("reactions_grp01_3_intro", "reaction_group1");
  add_cheap_actor_model_anim("react1_soldier03", % ch_ht_06_03_reactions_grp01_soldier03_intro, undefined, 1, undefined, undefined, "ally_ending");
  add_scene("reactions_grp01_3_mid", "reaction_group1");
  add_cheap_actor_model_anim("react1_soldier03", % ch_ht_06_03_reactions_grp01_soldier03_reaction, undefined, undefined, undefined, undefined, "ally_ending");
  add_scene("reactions_grp01_3_loop", "reaction_group1", 0, 0, 1);
  add_cheap_actor_model_anim("react1_soldier03", % ch_ht_06_03_reactions_grp01_soldier03_cycle, undefined, 1, undefined, undefined, "ally_ending");
  add_scene("reactions_grp02_1", "reaction_group2");
  add_cheap_actor_model_anim("react2_soldier01", % ch_ht_06_03_reactions_grp02_soldier04_intro, undefined, undefined, undefined, undefined, "ally_ending");
  add_scene("reactions_grp02_1_loop", "reaction_group2", 0, 0, 1);
  add_cheap_actor_model_anim("react2_soldier01", % ch_ht_06_03_reactions_grp02_soldier04_cycle, undefined, 1, undefined, undefined, "ally_ending");
  add_scene("reactions_grp02_2", "reaction_group2");
  add_cheap_actor_model_anim("react2_soldier02", % ch_ht_06_03_reactions_grp02_soldier05_intro, undefined, undefined, undefined, undefined, "ally_ending");
  add_scene("reactions_grp02_2_loop", "reaction_group2", 0, 0, 1);
  add_cheap_actor_model_anim("react2_soldier02", % ch_ht_06_03_reactions_grp02_soldier05_cycle, undefined, 1, undefined, undefined, "ally_ending");
  add_scene("reactions_grp02_3", "reaction_group2");
  add_cheap_actor_model_anim("react2_soldier03", % ch_ht_06_03_reactions_grp02_soldier06_intro, undefined, undefined, undefined, undefined, "ally_ending");
  add_scene("reactions_grp02_3_loop", "reaction_group2", 0, 0, 1);
  add_cheap_actor_model_anim("react2_soldier03", % ch_ht_06_03_reactions_grp02_soldier06_cycle, undefined, 1, undefined, undefined, "ally_ending");
  precache_assets(1);
}

set_blend_in_out_times(time) {
  self anim_set_blend_in_time(time);
  self anim_set_blend_out_time(time);
}

sndduckamb(guy) {
  rpc("clientscripts/haiti_amb", "sndDuckAmbEndIntro");
}

startlookyloosnap(guy) {
  rpc("clientscripts/haiti_amb", "sndDuckLookyLoo");
}

endlookyloosnap(guy) {
  level clientnotify("looky_loo_end");
}

sndplaydoorbell(guy) {
  playsoundatposition("evt_endout04_door_bell", (-21050, 4279, 32));
}

sndplaydoorleft(guy) {
  wait 0.15;
  playsoundatposition("evt_endout04_door_left", (-21146, 4180, -35));
}

sndplaydoorright(guy) {
  wait 0.15;
  playsoundatposition("evt_endout04_door_right", (-21135, 4350, -58));
}

sndplayvtolland(guy) {
  playsoundatposition("evt_endout04_vtol_land", (-21507, 4309, -56));
}

sndplayvtolland5(guy) {
  playsoundatposition("evt_endout05_vtol_land", (-21507, 4309, -56));
}

sndplayvtolland6(guy) {
  playsoundatposition("evt_endout06_vtol_land", (-21507, 4309, -56));
}

sndplayvtoltakeoff(guy) {
  playsoundatposition("evt_endout04_vtol_takeoff", (-21507, 4309, -56));
}