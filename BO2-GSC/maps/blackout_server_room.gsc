/*****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\blackout_server_room.gsc
*****************************************/

#include common_scripts\utility;
#include maps\_utility;
#include maps\_scene;
#include maps\_objectives;
#include maps\_glasses;
#include maps\_dialog;
#include maps\blackout_anim;
#include maps\_music;
#include maps\blackout_util;
#include maps\createart\blackout_art;
#include maps\_dds;
#include maps\_audio;
#include maps\_fxanim;

init_flags() {
  flag_init("mason_vent_start");
  flag_init("mason_vent_done");
  flag_init("player_weapon_disabled");
  flag_init("mason_server_room_start");
}

skipto_mason_vent() {
  skipto_teleport_players("player_skipto_mason_vent");
  menendez_animations();
  level.ai_redshirt1 = init_hero_startstruct("redshirt1", "redshirt1_skipto_mason_vent");
  level.ai_redshirt2 = init_hero_startstruct("redshirt2", "redshirt2_skipto_mason_vent");
  level.betrayal_scene_label = get_branching_scene_label();
  set_post_branching_scene_stats();
  screen_fade_out(0);
}

skipto_mason_server_room() {
  flag_set("mason_vent_done");
  flag_set("mason_server_room_start");
  maps\blackout_anim::menendez_animations();
  level.betrayal_scene_label = get_branching_scene_label();
  set_post_branching_scene_stats();
  mason_part_2_animations();
  skipto_teleport_players("player_skipto_mason_server_room");
  level.ai_redshirt1 = init_hero_startstruct("redshirt1", "redshirt1_skipto_mason_server_room");
  level.ai_redshirt2 = init_hero_startstruct("redshirt2", "redshirt2_skipto_mason_server_room");
  level.ai_redshirt1 set_ignoreall(1);
  level.ai_redshirt2 set_ignoreall(1);
  flag_set("player_kicks_vent_to_server_room_started");
  flag_set("player_kicks_vent_to_server_room_done");
  level thread setup_aftermath_scene();
}

run_mason_vent() {
  maps\_dds::dds_enable();
  flag_set("distant_explosions_on");
  maps\blackout_anim::salazar_kill_animations();
  maps\blackout_anim::scene_cctv_exit();
  delete_gumped_deadpose_characters();
  wait 0.25;
  load_gump("blackout_gump_mason_after");
  mason_part_2_animations();
  run_scene_first_frame("console_chair_karma_sit_loop");
  run_scene_first_frame("panel_knockdown");
  run_scene_first_frame("salazar_kill_victims");
  run_scene_first_frame("salazar_kill");
  cctv_door_fix();
  a_bodies = hide_super_kill_bodies();
  level thread mason_objectives_show();
  set_light_flicker_fx_area(70800);
  level thread cctv_console_play_cctv_2();
  vision_set_vent();
  set_player_mason(0);

  if(isDefined(level.player.has_menendez_weapons) && level.player.has_menendez_weapons) {
    level.player takeallweapons();
    level.player notify("give_mason_weapons");
    level.player.has_menendez_weapons = undefined;
    level.player allowpickupweapons(1);
    level.player setlowready(0);
  }

  flag_set("mason_vent_start");
  level thread maps\_audio::switch_music_wait("BLACKOUT_ACTION_DISCOVERY", 10);
  level.ai_redshirt1 = init_hero("redshirt1", ::redshirt1_vent_think);
  level.ai_redshirt2 = init_hero("redshirt2", ::redshirt2_vent_think);
  level thread mason_exits_server_terminal();
  cctv_room_guys_toggle_headlook(1);
  origin = getstruct("cctv_salazar_kill", "targetname");
  sm_cam_ent = spawn_model("tag_origin", origin.origin, origin.angles);
  sm_cam_ent setclientflag(11);
  level.salazar = init_hero("salazar");
  wait 0.05;
  wait 0.5;
  screen_fade_in(1.5);
  delay_thread(14, ::autosave_now);
  level.extra_cam_surfaces["cctv_salazar"] show();
  level.player thread say_dialog("sect_salazar_0", 3);
  level thread run_scene_and_delete("salazar_kill_victims");
  run_scene_and_delete("salazar_kill");
  show_super_kill_bodies(a_bodies);
  sm_cam_ent clearclientflag(11);
  level.extra_cam_surfaces["cctv_salazar"] hide();
  level thread run_scene_and_delete("tele_sal");
  array_delete(get_ais_from_scene("salazar_kill_victims"));
  level thread run_scene_and_delete("salazar_kill_victims_dead");
  level thread computer_guy_goes_back_to_work();
  flag_wait("mason_objectives_restored");
  set_objective(level.obj_server, get_ent("vent_objective_trigger", "targetname"), "breadcrumb");
  level thread setup_aftermath_scene();
  level thread player_kick_grate();
  level thread menendez_pip();
  level.player thread player_slow_speed_in_vent();
  trigger_wait("vent_objective_trigger");
  set_objective(level.obj_server, get_ent("vent_kick_trig", "targetname"), "breadcrumb");
}

cctv_console_play_cctv_2() {
  m_console_bink = get_ent("khan_screen_bink", "targetname", 1);
  m_console = get_ent("khan_screen_blank", "targetname", 1);
  m_console_bink show();
  m_console hide();
  play_movie_on_surface("blackout_cctv_2", 0, 0);
  level notify("blackout_cctv_2_done");
  m_console_bink hide();
  m_console show();
}

mason_exits_server_terminal() {
  run_scene_and_delete("cctv_mason_after_exit");
  level.player say_dialog("sect_hurry_the_fuck_up_0", 0.5);

  if(level.is_harper_alive)
    level.player say_dialog("sect_harper_get_to_the_0", 2);

  wait 5;
  level.player queue_dialog("sect_attention_all_securi_0");
  playsoundatposition("vox_bla_13_01_017b_sect", (2458, -328, -224));
  playsoundatposition("vox_bla_13_01_017b_sect", (2879, -383, -210));
  playsoundatposition("vox_bla_13_01_017b_sect", (2468, -611, -255));
  level.player queue_dialog("sect_i_want_him_taken_him_0");
  playsoundatposition("vox_bla_13_01_018b_sect", (2458, -328, -224));
  playsoundatposition("vox_bla_13_01_018b_sect", (2879, -383, -210));
  playsoundatposition("vox_bla_13_01_018b_sect", (2468, -611, -255));
}

cctv_door_fix() {
  m_door = get_ent("cctv_door", "targetname", 1);

  if(isDefined(m_door.v_original_position)) {
    m_door unlink();
    m_door.origin = m_door.v_original_position;
    m_door.angles = m_door.v_original_angles;
  }
}

cctv_room_guys_toggle_headlook(b_use_headlook) {
  if(!isDefined(b_use_headlook))
    b_use_headlook = 0;

  a_guys = [];
  a_guys[a_guys.size] = level.ai_redshirt1;

  foreach(guy in a_guys) {
    if(b_use_headlook) {
      guy headtracking_on();
      continue;
    }

    guy headtracking_off();
  }
}

hide_super_kill_bodies() {
  a_guys = _get_all_super_kill_actors();

  foreach(guy in a_guys)
  guy hide();
}

show_super_kill_bodies(a_guys) {
  a_guys = _get_all_super_kill_actors();

  foreach(guy in a_guys)
  guy show();
}

_get_all_super_kill_actors() {
  a_guys = [];

  if(isDefined(level.betrayal_scene_label)) {
    str_scene = "super_kill_" + level.betrayal_scene_label + "_deadpose";

    if(flag(str_scene + "_started")) {
      a_ai = get_ais_from_scene(str_scene);
      a_models = get_model_or_models_from_scene(str_scene);
      a_guards = get_model_or_models_from_scene("salazar_kill_victims_dead");
      a_guys = arraycombine(a_ai, a_models, 1, 0);
      a_guys = arraycombine(a_guys, a_guards, 1, 0);
    }
  }

  return a_guys;
}

computer_guy_goes_back_to_work() {
  scene_wait("cctv_mason_after_exit");
  run_scene_and_delete("cctv_access_computer_guy_loop");
}

player_slow_speed_in_vent() {
  t_in_vent = getent("trigger_crawl_space", "targetname");

  while(!flag("mason_vent_done")) {
    t_in_vent waittill("trigger");
    level.player setmovespeedscale(0.7);

    while(level.player istouching(t_in_vent) && !flag("mason_vent_done"))
      wait 0.05;

    level.player setmovespeedscale(1.0);
  }

  t_in_vent delete();
}

menendez_pip() {
  level waittill("blackout_cctv_2_done");
  scene_wait("cctv_mason_after_exit");
  play_pip("blackout_eye_chip", 1);
}

redshirt1_vent_think() {
  self allowedstances("crouch");
  self.pushable = 0;
  self set_ignoreall(1);
  nd_redshirt1_vent_node = getnode("redshirt1_vent_node", "targetname");
  self thread force_goal(nd_redshirt1_vent_node, 20);
}

redshirt2_vent_think() {
  self allowedstances("crouch");
  self.pushable = 0;
  self set_ignoreall(1);
  nd_redshirt2_vent_node = getnode("redshirt2_vent_node", "targetname");
  self thread force_goal(nd_redshirt2_vent_node, 20);
}

notetrack_play_vent_anim(m_player_body) {
  level thread run_scene_and_delete("panel_removed_for_vent_access");
}

notetrack_torch_guy_torch_on(ai_torch_guy) {
  m_torch = get_model_or_models_from_scene("panel_removed_for_vent_access", "torch");
  m_torch play_fx("laser_cutter_sparking", undefined, undefined, "stop_torch_fx", 1, "tag_fx");
  m_torch play_fx("fx_laser_cutter_on", undefined, undefined, "stop_torch_fx", 1, "tag_fx");
  m_torch playsound("evt_vent_cutter_start");
  wait 0.2;
  m_torch playloopsound("evt_vent_cutter_loop");
}

notetrack_torch_guy_torch_off(ai_torch_guy) {
  m_torch = get_model_or_models_from_scene("panel_removed_for_vent_access", "torch");
  m_torch notify("stop_torch_fx");
  m_torch stoploopsound(0.1);
  m_torch playsound("evt_vent_cutter_end");
}

torch_guy_cutting_wall() {
  run_scene_first_frame("torch_wall_panel_first_frame");
  run_scene_first_frame("panel_knockdown");
  torch_guy = simple_spawn_single("torch_guy");
  torch_guy set_ignoreall(1);
  torch_guy attach("t6_wpn_laser_cutter_prop", "TAG_WEAPON_LEFT");
  torch_guy thread welding_fx("cctv_mason_after_exit");
  level thread run_scene_and_delete("torch_wall_loop");
  scene_wait("cctv_mason_after_exit");
  wait 4;
  delay_thread(4, ::remove_vent_collision);
  run_scene_and_delete("torch_wall_open");
  level thread run_scene_and_delete("torch_wall_panel_idle");
  torch_guy detach("t6_wpn_laser_cutter_prop", "TAG_WEAPON_LEFT");
  flag_wait("mason_vent_done");
  torch_guy delete();
}

notetrack_torch_guy_takes_cover(ai_torch_guy) {
  ai_torch_guy endon("death");
  scene_wait("panel_removed_for_vent_access");
  nd_cover = getnode("torch_guy_vent_node", "targetname");

  if(isDefined(nd_cover))
    ai_torch_guy set_goal_node(nd_cover);
}

remove_vent_collision(ai_torch_guy) {
  m_wall = getent("crawl_space", "targetname");
  m_wall notsolid();
  m_wall connectpaths();
  m_wall delete();
}

player_kick_grate() {
  trigger_on("vent_kick_trig");
  trigger_wait("vent_kick_trig");
  autosave_by_name("server_room");
  obj_struct = getstruct("server_room_objective_struct", "targetname");
  set_objective(level.obj_server, obj_struct.origin, "breadcrumb");
  cctv_room_guys_toggle_headlook(0);
  level thread run_scene_and_delete("panel_knockdown");
  level thread run_scene_and_delete("panel_knockdown_redshirts");
  run_scene_and_delete("player_kicks_vent_to_server_room");
  level.player thread say_dialog("sect_check_the_wounded_0", 1);
  level.player allowstand(1);
  level.player setstance("stand");
  m_player_clip = getent("vent_clip_brushmodel", "targetname");
  m_player_clip delete();
  flag_set("mason_vent_done");
}

setup_aftermath_scene() {
  if(level.is_briggs_alive)
    run_scene_first_frame("briggs_alive_first_frame");
  else
    run_scene_first_frame("briggs_dead_pose");

  flag_wait("player_kicks_vent_to_server_room_started");
  run_scene_first_frame("console_chair_karma_sit_loop");
  set_dead_poses_from_betrayal_anim();
  level thread briggs_alive_or_not();
}

set_dead_poses_from_betrayal_anim() {
  if(isDefined(level.betrayal_scene_label) && level scene_exists("super_kill_" + level.betrayal_scene_label + "_deadpose"))
    level thread run_scene("super_kill_" + level.betrayal_scene_label + "_deadpose");

  super_kill_exploder_restore_all();
}

run_mason_server_room() {
  autosave_by_name("mason_inside_vent");
  maps\_fxanim::fxanim_delete("sensitive_room_pipes");
  level thread server_room_virus_bink();
  trigger_on("computer_server_use", "targetname");
  vision_set_mason_serverroom();
  flag_wait("mason_vent_done");
  flag_set("mason_server_room_start");
  set_light_flicker_fx_area(70900);
  level.ai_redshirt1 allowedstances("stand");
  level.ai_redshirt2 allowedstances("stand");
  level thread run_scene_then_loop("aftermath_redshirt_1_checks_room", "aftermath_redshirt_1_checks_room_loop");
  obj_struct = getstruct("server_room_objective_struct", "targetname");
  set_objective(level.obj_server, obj_struct.origin, "breadcrumb");
  level thread computer_server_use();
  level thread harper_alive_or_not();
  add_posed_corpses("control_room_corpses", "mason_elevator_started");
  aftermath_player();
}

computer_server_use() {
  computer_server_use = getent("computer_server_use", "targetname");
  computer_server_use setcursorhint("HINT_NOICON");
  trigger_wait("computer_server_use");
  setmusicstate("BLACKOUT_ACTION_REALIZATION");
  wait 0.1;
  computer_server_use delete();
}

harper_alive_or_not() {
  if(level.is_harper_alive) {
    scene_wait("aftermath_harper_alive");
    level.harper = init_hero("harper");
    level.harper set_ignoreall(1);
    level.harper set_goalradius(64);
  }
}

briggs_alive_or_not() {
  if(level.is_briggs_alive) {
    level.briggs = init_hero("briggs");
    level.briggs set_ignoreall(1);
    level.briggs setteam("allies");
  } else
    level thread run_scene_first_frame("briggs_dead_pose");

  scene_wait("player_kicks_vent_to_server_room");
  level thread redshirt_checks_on_briggs();
}

karma_alive_or_not() {
  if(level.is_karma_alive) {
    scene_wait("player_kicks_vent_to_server_room");
    flag_wait("aftermath_karma_uses_computer_started");
    level.player giveachievement_wrapper("SP_STORY_CHLOE_LIVES");
  }
}

redshirt_checks_on_briggs() {
  if(level.is_briggs_alive)
    run_scene_then_loop("aftermath_briggs_enter", "aftermath_briggs_wait");
  else
    run_scene_then_loop("redshirt_02_briggs_dead_enter", "redshirt_02_briggs_dead_loop");
}

aftermath_player() {
  trigger_wait("computer_server_use");
  set_objective(level.obj_server, undefined, "done");
  level.briggs_loop_aftermath = 0;
  level.karma_loop_aftermath = 0;
  delay_thread(1, ::server_room_exit_door_open);
  level.player startcameratween(0.3);

  if(level.is_karma_alive)
    run_scene_and_delete("aftermath_karma_alive", 0.3);
  else
    run_scene_and_delete("aftermath_karma_dead", 0.3);

  if(level.is_briggs_alive)
    run_scene_and_delete("aftermath_briggs_alive");
  else {
    level.player startcameratween(0.1);
    level thread run_scene("aftermath_console_look_loop");
    ai_briggs_redshirt = get_ent("redshirt2_ai", "targetname");
    ai_briggs_redshirt say_dialog("reds_briggs_is_dead_1");
    wait 1;
    level.player startcameratween(0.1);
  }

  if(!level.is_karma_alive) {
    level thread run_scene("aftermath_console_look_loop");
    level.player say_dialog("sect_we_ll_need_our_tech_1", 0.5);
  }

  if(level.is_harper_alive)
    run_scene_and_delete("aftermath_harper_alive");
  else {
    level thread run_scene("aftermath_console_look_loop");
    delay_thread(4, ::run_scene_and_delete, "aftermath_harper_dead");
  }

  setmusicstate("BLACKOUT_ACTION_POST_DISCOVERY");
  level delay_notify("mason_enters_control_room", 5);
}

server_room_virus_bink() {
  onsaverestored_callback(::save_restored_mason_server_room_bink);
  scene_wait("player_kicks_vent_to_server_room");
  m_console_dark = get_ent("server_room_console_dark", "targetname", 1);
  m_console_bink = get_ent("server_room_console_bink", "targetname", 1);
  m_console_bink show();
  m_console_dark hide();
  m_console_bink.n_bink_id = play_movie_on_surface_async("blackout_virus_mason", 1, 0);
  level waittill("nuke_server_room");
  stop3dcinematic(m_console_bink.n_bink_id);
  m_console_bink hide();
  m_console_dark show();
  onsaverestored_callbackremove(::save_restored_mason_server_room_bink);
}

save_restored_mason_server_room_bink() {
  if(!isDefined(level.streaming_binks_restored))
    level.streaming_binks_restored = 0;

  if(!level.streaming_binks_restored) {
    level.streaming_binks_restored = 1;
    m_console_dark = get_ent("server_room_console_dark", "targetname", 1);
    m_console_bink = get_ent("server_room_console_bink", "targetname", 1);
    m_console_bink show();
    m_console_dark hide();

    if(isDefined(m_console_bink.n_bink_id))
      stop3dcinematic(m_console_bink.n_bink_id);

    m_console_bink.n_bink_id = play_movie_on_surface_async("blackout_virus_mason", 1, 0);
    wait 2;
    level.streaming_binks_restored = undefined;
  }
}

notetrack_aftermath_karma_uses_computer(e_player_body) {
  run_scene_then_loop("aftermath_karma_walks_to_computer", "aftermath_karma_uses_computer");
}

notetrack_briggs_exits(e_player_body) {
  if(level.is_briggs_alive)
    run_scene_and_delete("aftermath_briggs_exit");
}