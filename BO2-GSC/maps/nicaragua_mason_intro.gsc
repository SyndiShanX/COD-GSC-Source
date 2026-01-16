/******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\nicaragua_mason_intro.gsc
******************************************/

#include common_scripts\utility;
#include maps\_utility;
#include maps\_dialog;
#include maps\_scene;
#include maps\_objectives;
#include maps\nicaragua_util;
#include maps\_anim;
#include maps\_music;
#include maps\_fxanim;
#include maps\nicaragua_mason_hill;
#include maps\_hud_util;

skipto_mason_intro() {
  skipto_teleport_players("player_skipto_mason_intro");
  screen_fade_out(0, "white");
  flag_set("movie_ended");
  battlechatter_on("axis");
}

init_flags() {
  flag_init("dichotomy_complete");
  flag_init("mason_gump_loaded");
  flag_init("mason_intro_window_view_fade_out");
}

main() {
  delete_menendez_scenes();
  menendez_spawners_clean_up();
  model_restore_area("mason_hill_1");
  model_restore_area("mason_hill_2");
  model_restore_area("mason_mission");
  load_gump("nicaragua_gump_josefina");
  autosave_by_name("mason_side_start");
  setsaveddvar("cg_aggressiveCullRadius", "500");
  rpc("clientscripts/nicaragua_amb", "hallwaySnap");
  wait 3.0;
  mason_intro_setup();
  flag_wait("movie_ended");
  transition_text();
  stop_exploder(20);
  exploder(10);
  rpc("clientscripts/nicaragua_amb", "masonIntroSnapAndLoop");
  level thread screen_fade_in(3.0, "white");
  init_flags();
  level thread nicaragua_mason_intro_objectives();
  mason_intro_cinematic();
  simple_spawn("mason_intro_pdf", ::intro_pdf_sprint);
  begin_mason_intro_mortars();
  spawn_mason_intro_snipers();
  level thread give_pdf_forcecolor();
  level thread mason_intro_cleanup();
  wait 0.1;
  flag_wait("nicaragua_mason_intro_complete");
  level notify("nicaragua_mason_intro_complete");
}

mason_intro_setup() {
  maps\_fxanim::fxanim_reconstruct("fxanim_watertower_river");
  maps\_fxanim::fxanim_reconstruct("fxanim_hut_river");
  maps\_fxanim::fxanim_reconstruct("fxanim_porch_explode");
  maps\_fxanim::fxanim_reconstruct("fxanim_hut_explode");
  maps\_fxanim::fxanim_reconstruct("fxanim_hut_explode_watertower");
  maps\_fxanim::fxanim_reconstruct("fxanim_trough_break_1");
  maps\_fxanim::fxanim_reconstruct("fxanim_trough_break_2");
  maps\_fxanim::fxanim_reconstruct("fxanim_truck_fence");
  maps\_fxanim::fxanim_reconstruct("fxanim_archway");
  maps\_fxanim::fxanim_reconstruct("fxanim_fountain");
  add_spawn_function_ai_group("mason_intro_pdf", ::make_friendlies_ignore_grenades);
}

nicaragua_mason_intro_objectives() {
  set_objective(level.obj_mason_observe_menendez);
  flag_wait("menendez_speed_run_challenge_updated");
  set_objective(level.obj_mason_observe_menendez, undefined, "done");
  set_objective(level.obj_mason_up_hill);
  level thread objective_breadcrumb(level.obj_mason_up_hill, "mason_intro_objective_breadcrumb");
  autosave_by_name("mason_intro_complete");
  flag_wait("nicaragua_mason_intro_complete");
  autosave_by_name("Join_PDF_complete");
}

mason_intro_cinematic() {
  level.hudson = init_hero("hudson");
  level.woods = init_hero("woods");
  level.noriega = init_hero("noriega");
  setmusicstate("NIC_INTRO_2");
  level.player allowcrouch(0);
  screen_fade_out(0.5, "white");
  run_scene_first_frame("mason_intro_window_view");
  run_scene_first_frame("fxanim_blanket_2nd");
  level.player setup_scope_view();
  level.player turn_on_scope_vision();
  screen_fade_in(0.5, "white");
  level notify("fade_in_complete");
  level thread play_bell_rings();
  level thread run_scene("fxanim_blanket_2nd");
  level thread run_scene("mason_intro_window_view");
  flag_wait("mason_intro_window_view_fade_out");
  screen_fade_out(0.25);
  load_gump("nicaragua_gump_mason");
  flag_set("mason_gump_loaded");
  level.player disable_scope_view();
  set_character_mason();
  level.player unlink();
  run_scene_first_frame("mason_intro_part2_player");
  run_scene_first_frame("mason_intro_part2_woods");
  run_scene_first_frame("mason_intro_part2_hudson");
  m_player_body = get_model_or_models_from_scene("mason_intro_part2_player", "player_body");
  m_player_body attach("p6_binoculars_anim", "tag_weapon1");
  level clientnotify("stopIntroSnap");
  n_znear_old = getdvar(#"r_znear");
  setdvar("r_znear", 1);
  level thread run_scene("mason_intro_part2_player");
  level thread run_scene("mason_intro_part2_woods");
  level thread run_scene("mason_intro_part2_hudson");
  level thread run_scene("mason_intro_part2_noriega");
  flag_wait("mason_intro_part2_player_started");
  level.player startcameratween(0.05);
  wait 0.15;
  level thread screen_fade_in(0.5);
  level thread noriega_moves_up_to_ledge();
  level thread move_squad_into_village();
  level thread mason_intro_end_vo();
  scene_wait("mason_intro_part2_player");
  setdvar("r_znear", n_znear_old);
  level thread mason_intro_rundown_vo();
  level.player show_hud(1);
  level.player notify("mason_intro_window_view_complete");
  level.player showviewmodel();
  level.player allowcrouch(1);
  level.player player_enable_weapons();
  m_scorch_marks = getent("josefina_hall_scorch", "targetname");
  m_scorch_marks show();
  flag_set("dichotomy_complete");
  setmusicstate("NIC_RAID_BATTLE");
}

mason_intro_window_view_fade_out(e_guy) {
  flag_set("mason_intro_window_view_fade_out");
}

intro_pdf_sprint() {
  self endon("death");
  self change_movemode("sprint");
  flag_wait("nicaragua_mason_intro_complete");
  self reset_movemode();
}

begin_mason_intro_mortars() {
  level thread maps\nicaragua_mason_hill::mason_intro_mortars();
}

move_squad_into_village() {
  level.woods change_movemode("sprint");
  level.hudson change_movemode("sprint");
  level.player setmovespeedscale(0.75);
  setsaveddvar("player_sprintUnlimited", 1);
  trigger_use("mason_hill_initial_color_trigger", "targetname");
}

spawn_mason_intro_snipers() {
  trigger_use("mortar_team");
  a_ai_pdf = simple_spawn("mason_intro_pdf_snipers");
  e_target = getent("mason_intro_pdf_snipers_target", "targetname");
  e_target.health = 100;

  foreach(guy in a_ai_pdf)
  guy thread wait_and_shoot_at(e_target);
}

wait_and_shoot_at(e_target) {
  self endon("death");
  self waittill("goal");
  self shoot_at_target_untill_dead(e_target);
}

give_pdf_forcecolor() {
  level waittill("mason_intro_move_pdf_down_hill");
  a_ai_pdf = get_ai_array("mason_intro_hill_runners", "script_noteworthy");

  foreach(guy in a_ai_pdf)
  guy set_force_color("p");

  level waittill("mason_intro_move_pdf_down_hill");
  a_ai_pdf = get_ai_array("mason_intro_hill_runners2", "script_noteworthy");

  foreach(guy in a_ai_pdf)
  guy set_force_color("p");
}

noriega_moves_up_to_ledge() {
  scene_wait("mason_intro_part2_noriega");
  nd_goal = getnode("noriega_ledge_spot", "targetname");
  level.noriega.goalradius = 32;
  level.noriega setgoalnode(nd_goal);
}

mason_intro_end_vo() {
  wait 1.0;

  if(is_mature())
    level.woods queue_dialog("wood_alright_about_fuck_0");
  else
    level.woods queue_dialog("wood_alright_about_time_0");
}

mason_intro_rundown_vo() {
  trigger_wait("begin_mason_hill_descent");
  wait 1.0;
  level.player queue_dialog("maso_heavy_fighting_up_ah_0");
  level.hudson queue_dialog("huds_noriega_s_men_are_pu_0", 2.0);

  if(is_mature())
    level.woods queue_dialog("wood_i_ain_t_keen_on_figh_0", 2.0);
  else
    level.woods queue_dialog("wood_i_ain_t_keen_on_figh_1", 2.0);

  level.hudson queue_dialog("huds_trust_me_woods_th_0", 2.0);
}

mason_intro_cleanup() {
  trigger_wait("end_mason_intro");
  o_windowview = getent("mason_intro_scope_view", "targetname");
  o_windowview delete();
  delete_scene("mason_intro");
  delete_scene("mason_intro_window_view");
  delete_scene("mason_intro_part2_player");
  delete_scene("mason_intro_part2_woods");
  delete_scene("mason_intro_part2_hudson");
  delete_scene_all("mason_intro_part2_noriega");
  array_delete(getentarray("mason_intro_window_spawners", "script_noteworthy"));
  kill_spawnernum(10);
}

mason_intro_rain_overlay(e_trigger) {
  level endon("nicaragua_mason_intro_complete");

  while(true) {
    e_trigger waittill("trigger");

    while(true) {
      if(self istouching(e_trigger))
        self setclientflag(14);
      else {
        self clearclientflag(14);
        break;
      }

      wait 0.05;
    }
  }
}

transition_text() {
  fade_time = 3;
  hud_string = maps\_hud_util::createfontstring("objective", 1.5);
  hud_string.sort = 3;
  hud_string.color = (0, 0, 0);
  hud_string.font = "objective";
  hud_string.horzalign = "center";
  hud_string.vertalign = "middle";
  hud_string.alignx = "center";
  hud_string.aligny = "middle";
  hud_string.y = -60;
  hud_string.foreground = 1;
  hud_string.fontscale = 1.8;
  hud_string.alpha = 0;
  hud_string settext(&"NICARAGUA_TRANSITION_TITLE");
  hud_string fadeovertime(fade_time);
  hud_string.alpha = 1;
  hud_string2 = maps\_hud_util::createfontstring("objective", 1.5);
  hud_string2.sort = 3;
  hud_string2.color = (0, 0, 0);
  hud_string2.font = "objective";
  hud_string2.horzalign = "center";
  hud_string2.vertalign = "middle";
  hud_string2.alignx = "center";
  hud_string2.aligny = "middle";
  hud_string2.y = -33;
  hud_string2.foreground = 1;
  hud_string2.fontscale = 1.8;
  hud_string2.alpha = 0;
  hud_string2 settext(&"NICARAGUA_TRANSITION_AGENTS");
  hud_string2 fadeovertime(fade_time);
  hud_string2.alpha = 1;
  hud_string3 = maps\_hud_util::createfontstring("objective", 1.5);
  hud_string3.sort = 3;
  hud_string3.color = (0, 0, 0);
  hud_string3.font = "objective";
  hud_string3.horzalign = "center";
  hud_string3.vertalign = "middle";
  hud_string3.alignx = "center";
  hud_string3.aligny = "middle";
  hud_string3.y = -6;
  hud_string3.foreground = 1;
  hud_string3.fontscale = 1.8;
  hud_string3.alpha = 0;
  hud_string3 settext(&"NICARAGUA_TRANSITION_BODY");
  hud_string3 fadeovertime(fade_time);
  hud_string3.alpha = 1;
  wait 4;
  hud_string destroy();
  hud_string2 destroy();
  hud_string3 destroy();
}

play_bell_rings() {
  wait 6;
  playsoundatposition("amb_bell_chime", (-3485, -9689, 2306));
  wait 2.9;
  playsoundatposition("amb_bell_chime", (-3485, -9689, 2306));
}