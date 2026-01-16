/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\nicaragua_intro.gsc
**************************************/

#include common_scripts\utility;
#include maps\_utility;
#include maps\_dialog;
#include maps\_scene;
#include maps\_objectives;
#include maps\nicaragua_util;
#include maps\_anim;
#include maps\nicaragua_menendez_rage;
#include maps\_music;
#include maps\_audio;
#include maps\_fxanim;
#include maps\nicaragua_menendez_hill;

skipto_mason_intro_briefing() {
  skipto_teleport_players("player_skipto_mason_intro");
}

skipto_menendez_intro() {
  screen_fade_out(0, "white");
  skipto_teleport_players("player_skipto_menendez_intro");
  level.player setclientdvar("cg_aggressiveCullRadius", 495);
}

skipto_menendez_sees_noriega() {
  skipto_teleport_players("player_skipto_mason_intro");
  level.player startfadingblur(9, 6);
  level.player setclientdvar("cg_aggressiveCullRadius", 495);
}

init_flags() {
}

mason_intro() {
  convert_mason_models();
  screen_fade_out(0);
  set_character_mason(0);
  set_objective(level.obj_menendez_observe_menendez);
  level thread run_scene("mason_intro");
  flag_wait("mason_intro_started");
  exploder(25);
  setmusicstate("NIC_INTRO");
  ai_hudson = getent("hudson_ai", "targetname");
  ai_hudson attach("p6_binoculars_anim", "tag_weapon_left");
  level.player setclientdvar("cg_aggressiveCullRadius", 495);
  delay_thread(0.25, ::screen_fade_in, 2);
  flag_set("mason_introscreen");
  ai_noriega = getent("noriega_ai", "targetname");
  ai_noriega attach("com_hand_radio", "tag_weapon_right");
  ai_noriega attach("t6_wpn_shotty_spas_world", "tag_weapon_left");
  rpc("clientscripts/nicaragua_amb", "levelIntroSnapAndLoop");
  level waittill("recon_1_done");
  level thread binocular_scene_1_vo();
  screen_fade_out(0.35);
  wait 0.05;
  m_player = get_model_or_models_from_scene("mason_intro", "player_body");
  m_player detach("p6_binoculars_anim", "tag_weapon1");
  ai_noriega detach("com_hand_radio", "tag_weapon_right");
  ai_noriega detach("t6_wpn_shotty_spas_world", "tag_weapon_left");
  level.player allowcrouch(0);
  load_gump("nicaragua_gump_josefina");
  stop_exploder(25);
  binocular_scene_1();
}

binocular_scene_1() {
  run_scene_first_frame("mason_intro_switch_to_menendez");
  level.player setup_scope_view();
  level.player turn_on_scope_vision_quick();
  level thread run_scene("mason_intro_switch_to_menendez");
  screen_fade_in(0.5);
  level waittill("fade_to_menendez");
  level.player playsound("evt_transition_mend_start");
  level clientnotify("stopLevelIntroSnap");
  screen_fade_out(0.5, "white");
  level.player disable_scope_view();
  end_scene("mason_intro_switch_to_menendez");
  set_objective(level.obj_menendez_observe_menendez, undefined, "delete");
  level.player allowcrouch(1);
  a_cleanup = [];
  a_cleanup[a_cleanup.size] = get_model_or_models_from_scene("mason_intro_switch_to_menendez", "menendez");
  a_cleanup[a_cleanup.size] = get_model_or_models_from_scene("mason_intro", "mason_intro_binoculars");
  a_cleanup[a_cleanup.size] = get_ent("woods_ai", "targetname");
  a_cleanup[a_cleanup.size] = get_ent("hudson_ai", "targetname");
  a_cleanup[a_cleanup.size] = get_ent("noriega_ai", "targetname");
  array_delete(a_cleanup);
}

binocular_scene_1_vo() {
  wait 0.35;
  level.player say_dialog("huds_that_s_not_the_missi_0");
}

recon_1_notify_done(m_player) {
  level notify("recon_1_done");
}

mason_intro_window_view_fade_to_menendez(e_menendez) {
  level notify("fade_to_menendez");
}

menendez_intro() {
  rpc("clientscripts/nicaragua", "set_lut_bank", 2);
  init_flags();
  set_character_menendez();
  level thread maps\_audio::switch_music_wait("NIC_MENENDEZ_SINGS", 1);
  delay_thread(0.5, ::screen_fade_in, 2, "white");
  menendez_intro_scene();
  load_gump("nicaragua_gump_lower_village");
  run_scene_first_frame("noriega_arrives");
  flag_wait("play_noriega_arrives");
}

menendez_intro_scene() {
  m_scorch_marks = getent("josefina_hall_scorch", "targetname");
  m_scorch_marks hide();
  m_shards = getent("picture_frame_shards", "targetname");
  m_shards hide();
  level notify("fxanim_blanket_start");
  run_scene_first_frame("menendez_intro_part2_picture");
  run_scene_first_frame("menendez_intro_part1");
  m_player_body = get_model_or_models_from_scene("menendez_intro_part1", "player_body");
  m_player_body.targetname = "mi_player_body";
  level thread run_scene("menendez_intro_part1");
  level thread run_scene("menedez_intro_1_pendant");
  scene_wait("menendez_intro_part1");
  level thread maps\_audio::switch_music_wait("NIC_MENENDEZ_ATTACKED", 6);
  level thread run_scene("menendez_intro_part2_picture");
  run_scene("menendez_intro_part2");
  m_scorch_marks show();
  m_shards delete();
}

noriega_arrives_scene() {
  exploder(20);
  exploder(101);
  level thread menendez_hill_civ_fleeing();
  level thread run_scene("noriega_arrives_cuffs");
  level thread run_scene("noriega_arrives_pdf_1");
  level thread run_scene("noriega_arrives_pdf_2");
  level thread run_scene("noriega_arrives");
  spas = get_model_or_models_from_scene("noriega_arrives", "spas");
  spas hide();
  flag_wait("noriega_arrives_started");

  if(is_mature()) {
    m_player_body = get_model_or_models_from_scene("noriega_arrives", "player_body");
    m_player_body setmodel("c_mul_menendez_nicaragua_d_viewbody");
  }

  ai_noriega = getent("noriega_ai", "targetname");
  ai_noriega attach("p_anim_rus_key", "tag_weapon_left");
  ai_noriega bloodimpact("none");
  model_restore_area("menendez_lower_village");
  destructibles_in_area("menendez_lower_village");
  maps\_fxanim::fxanim_reconstruct("fxanim_bridge_drop");
  scene_wait("noriega_arrives");

  if(isalive(ai_noriega))
    ai_noriega detach("p_anim_rus_key", "tag_weapon_left");

  autosave_by_name("noriega_arrives_done");
  level.player.ignoreme = 0;
  level.player thread rage_high_logic("mh_intro", 1);
  level.player thread menendez_cleanup_after_anim();
  flag_set("nicaragua_intro_complete");
}

noriega_arrives_cuffs_logic() {
  run_scene("noriega_arrives_cuffs");
}

mud_overlay() {
  exploder(102);
  h_mud_overlay = get_fade_hud("overlay_mud_spatter");
  h_mud_overlay.alpha = 1;
  h_mud_overlay fadeovertime(0.95);
  h_mud_overlay.alpha = 0;
  wait 0.95;
  h_mud_overlay destroy();
}

menendez_hill_civ_fleeing() {
  maps\nicaragua_menendez_hill::menendez_hill_spawn_funcs();
}

village_reveal_scenes_start(e_player_body) {
  wait 3;
  level.player rage_medium();
}

menendez_intro_part2_rage_start(m_player_body) {
  rpc("clientscripts/nicaragua", "rage_toggle", 0);
  level.player rage_low();
}

menendez_title_card(m_player_body) {
  text_color = 0;
  level_prefix = "NICARAGUA_MENENDEZ";
  nicaragua_custom_introscreen(istring(level_prefix), 2, 14, text_color);
}

menendez_intro_not_mature_black_screen(m_player_body) {
  if(!is_mature())
    screen_fade_out(0.05);
}

menendez_intro_part1_rage_notetrack(guy) {
  level.player rage_high();
  m_shards = getent("picture_frame_shards", "targetname");
  m_shards ignorecheapentityflag(1);
  m_shards setscale(0.2);
  m_shards show();
}

intro_guard_fx(ai_pdf_4) {
  ai_cartel_guard = getent("intro_cartel_guard_ai", "targetname");
  playfxontag(getfx("intro_cartel_blood"), ai_cartel_guard, "j_head");
  exploder(59);
}

menendez_intro_glass_stab(m_player_body) {
  m_glass_shard = get_model_or_models_from_scene("menendez_intro_part2", "intro_shard");
  playfxontag(getfx("neck_stab_glass"), m_glass_shard, "tag_origin");
  ai_intro_pdf_1 = getent("intro_pdf01_ai", "targetname");
  playfxontag(getfx("neck_stab_blood"), ai_intro_pdf_1, "j_neck");
}

menendez_intro_bloody_viewbody(m_player_body) {
  if(is_mature())
    m_player_body setmodel("c_mul_menendez_nicaragua_b_viewbody");
}

menendez_intro_blur(m_player_body) {
  level.player rage_reset();
  level.player lerp_dof_over_time_pass_out(0.15);
}

menendez_intro_part1_fade_notetrack(guy) {
  if(is_mature())
    screen_fade_out(0.5);

  level.player reset_dof();
  wait 9;
  flag_set("play_noriega_arrives");
  level.player startfadingblur(9, 6);
  screen_fade_in(1.5);
}

noriega_arrives_low_rage(m_player_body) {
  level.player rage_low();
}

noriega_arrives_high_rage(m_player_body) {
  level.player rage_high(1);
}

noriega_arrives_menendez_vo() {
  rage_mode_important_vo("jose_scream_0");
  wait 1;
  rage_mode_important_vo("mene_josefina_5");
}

player_no_headlook_during_scene(m_player_body) {
  level.player playerlinktodelta(level.player.m_scene_model, "tag_player", 0, 0, 0, 0, 0, 0, 0);
  level.player setplayerviewratescale(1);
}

give_player_headlook_during_scene(m_player_body) {
  level.player switch_player_scene_to_delta();
}

noriega_arrives_muddy_viewbody(m_player_body) {
  if(is_mature()) {
    m_player_body setmodel("c_mul_menendez_nicaragua_m_viewbody");
    update_player_model("c_mul_menendez_nicaragua_m_viewhands", "c_mul_menendez_nicaragua_m_viewbody");
  }
}

noriega_arrives_head_switch(m_player_body) {
  if(is_mature()) {
    ai_noriega = getent("noriega_ai", "targetname");
    ai_noriega detach(ai_noriega.headmodel, "", 1);
    ai_noriega.headmodel = "c_pan_noriega_military_head_wnded";
    ai_noriega attach(ai_noriega.headmodel, "", 1);
  }
}

noriega_arrives_spas_swap(m_player_body) {
  ai_noriega = getent("noriega_ai", "targetname");
  ai_noriega gun_remove();
  m_player_body attach("t6_wpn_shotty_spas_world", "tag_weapon");
}

noriega_arrives_look_at_mission(m_player_body) {
  level.player thread noriega_arrives_menendez_vo();
  wait 2;
  simple_spawn("mh_intro");
}

noriega_arrives_pdf_blood(ai_noriega) {
  if(!isDefined(ai_noriega.n_pdf_killed))
    ai_noriega.n_pdf_killed = 0;

  if(ai_noriega.n_pdf_killed == 0) {
    ai_pdf = get_ais_from_scene("noriega_arrives_pdf_2", "noriega_arrives_pdf_2");
    wait 0.05;
    playfxontag(getfx("flesh_hit_shotgun_chest"), ai_pdf, "j_SpineUpper");
    ai_noriega.n_pdf_killed++;
  } else {
    ai_pdf = get_ais_from_scene("noriega_arrives_pdf_1", "noriega_arrives_pdf_1");
    wait 0.05;
    playfxontag(getfx("flesh_hit_shotgun_chest"), ai_pdf, "j_SpineUpper");
    ai_noriega.n_pdf_killed++;
  }
}