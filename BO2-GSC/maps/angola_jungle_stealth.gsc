/******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\angola_jungle_stealth.gsc
******************************************/

#include common_scripts\utility;
#include maps\_utility;
#include maps\_dialog;
#include maps\_scene;
#include maps\_objectives;
#include maps\angola_2_util;
#include maps\_anim;
#include maps\angola_jungle_stealth_carry;
#include maps\_music;
#include maps\_stealth_logic;
#include maps\createart\angola_art;
#include maps\_audio;
#include maps\angola_2_beartrap;

skipto_jungle_stealth() {
  skipto_teleport_players("player_skipto_jungle_stealth");
  level.ai_woods = init_hero("woods");
  level.ai_hudson = init_hero("hudson");
  level.ai_hudson.non_wet_model = level.ai_hudson.model;
  level.ai_hudson setmodel("c_usa_angola_hudson_wet_fb");
  level.ai_hudson detach("c_usa_angola_hudson_glasses");
  level.ai_hudson detach("c_usa_angola_hudson_hat");
  level notify("fxanim_hind_crash_start");
  level.angola2_skipto = 1;
  level thread exploder_after_wait(250);
  flag_set("fxanim_grass_spawn");
}

skipto_jungle_stealth_log() {
  skipto_teleport_players("player_skipto_jungle_stealth_log");
  load_gump("angola_2_gump_village");
  init_flags();
  switch_off_angola_escape_triggers();
  level.player thread stealth_ai();
  level.player thread maps\createart\angola_art::jungle_stealth();
  level.player thread take_and_giveback_weapons("give_back_weapons");
  level.ai_woods = init_hero("woods");
  level.ai_hudson = init_hero("hudson");
  level.ai_hudson.non_wet_model = level.ai_hudson.model;
  level.ai_hudson setmodel("c_usa_angola_hudson_wet_fb");
  level.ai_hudson detach("c_usa_angola_hudson_glasses");
  level.ai_hudson detach("c_usa_angola_hudson_hat");
  level.ai_hudson unlink();
  level.ai_hudson setgoalpos(level.ai_hudson.origin);
  level.ai_hudson set_force_color("r");
  level.ai_hudson change_movemode("cqb_sprint");
  s_struct = getstruct("hudson_skipto_jungle_stealth_log", "targetname");
  level.ai_hudson forceteleport(s_struct.origin, s_struct.angles);
  m_radio_tower = getent("radio_tower", "targetname");
  m_radio_tower ignorecheapentityflag(1);
  m_radio_tower setscale(2);
  level thread maps\angola_jungle_stealth_carry::mason_carry_woods("player_prone_watches_1st_child_soldier_encounter");
  level thread fail_player_for_moving_to_escape_early();
  level thread enemy_detects_player_vo();
  level thread end_dialogue_when_stealth_breaks();
  flag_set("js_hudson_mason_rock_climb_complete");
  flag_set("village_antenna_spotted");
  battlechatter_off("axis");
  jungle_stealth_skipto_clean_up();
  jungle_stealth_spawn_funcs();
  jungle_stealth_fails();
  level.angola2_skipto = 1;
  level thread exploder_after_wait(250);
  flag_set("fxanim_grass_spawn");
}

init_flags() {
  flag_init("js_hudson_executes_hind_pilot");
  flag_init("village_antenna_spotted");
  flag_init("js_hudson_waiting_at_log_blockage");
  flag_init("js_hudson_mason_rock_climb_start");
  flag_init("js_hudson_mason_rock_climb_complete");
  flag_init("js_hudson_lookout_for_child_soldiers");
  flag_init("mason_run_to_log_cover");
  flag_init("js_mason_in_cover_behind_log");
  flag_init("js_child_soldier_scene_complete");
  flag_init("js_player_enters_stealth_house");
  flag_init("js_moving_to_stealth_house_enter");
  flag_init("js_mason_in_position_in_building");
  flag_init("js_hudson_in_position_in_building");
  flag_init("js_mason_ready_to_exit_house");
  flag_init("js_stealth_house_complete");
  flag_init("child_guards_alerted");
  flag_init("fail_after_log");
  flag_init("fail_before_log");
  flag_init("fail_beach");
  flag_init("player_failing_stealth");
  init_stealth_carry_flags();
  level.dontdropaiclips = undefined;
  setsaveddvar("ragdoll_max_life", "9000");
}

init_stealth_carry_flags() {
  flag_init("js_player_fails_stealth");
  flag_init("pause_woods_carry");
  flag_init("js_mason_is_carrying_woods");
  flag_init("woods_carry_cough");
  flag_init("player_obeys_stealth_command");
}

main() {
  init_flags();
  switch_off_angola_escape_triggers();
  level.player thread stealth_ai();
  level.player thread maps\createart\angola_art::jungle_stealth();
  level.player thread take_and_giveback_weapons("give_back_weapons");

  if(isDefined(level.woods)) {
    level.ai_woods = level.woods;
    level.woods = undefined;
  }

  if(isDefined(level.hudson)) {
    level.ai_hudson = level.hudson;
    level.hudson = undefined;
  }

  level.ai_hudson unlink();
  level.ai_hudson setgoalpos(level.ai_hudson.origin);
  level.ai_hudson set_force_color("r");
  level.ai_hudson change_movemode("cqb_sprint");
  m_radio_tower = getent("radio_tower", "targetname");
  m_radio_tower ignorecheapentityflag(1);
  m_radio_tower setscale(2);
  m_radio_tower set_force_no_cull();
  level thread angola_stealth_objectives();
  level thread jungle_stealth_spawn_funcs();
  level thread jungle_stealth_fails();
  level thread fail_player_for_moving_to_escape_early();
  level.ai_hudson thread hudson_jungle_stealth_logic();

  if(isDefined(level.m_player_rig))
    level.m_player_rig unlink();

  level.ai_woods unlink();
  level thread run_scene("j_stealth_player_picks_up_woods");
  set_player_rig("j_stealth_player_picks_up_woods");
  scene_wait("j_stealth_player_picks_up_woods");
  level thread maps\angola_jungle_stealth_carry::mason_carry_woods();
  level thread player_bird_fx_during_antenna_reveal();
  level thread enemy_detects_player_vo();
  level thread end_dialogue_when_stealth_breaks();

  if(isDefined(level.main_barge))
    level.main_barge delete();

  load_gump("angola_2_gump_village");
  battlechatter_off("axis");
  level notify("fxanim_vines_start");
}

jungle_stealth_log_main() {
  level thread angola_jungle_stealth_log_objectives();
  level.ai_hudson thread hudsun_approaches_child_solider_encounter();
  level thread waiting_for_stealth_move_to_house();
  level thread waiting_for_move_to_dense_foliage_area();
  level thread handle_child_soldiers();
  flag_wait("js_stealth_house_complete");
}

jungle_stealth_spawn_funcs() {
  a_fail_beach_enemies = getentarray("enemy_fail_beach", "targetname");
  array_thread(a_fail_beach_enemies, ::add_spawn_function, ::fail_beach_enemy_logic);
  a_fail_valley_enemies = getentarray("enemy_fail_valley", "targetname");
  array_thread(a_fail_valley_enemies, ::add_spawn_function, ::chase_after_target, level.player);
  a_fail_before_log_enemies = getentarray("enemy_fail_before_log", "targetname");
  array_thread(a_fail_before_log_enemies, ::add_spawn_function, ::chase_after_target, level.player);
  add_spawn_function_veh("radio_tower_heli", ::set_force_no_cull);
}

set_force_no_cull() {
  self setforcenocull();
}

hudson_jungle_stealth_logic() {
  t_climb_help = getent("hudson_rock_bockage_trigger", "targetname");
  t_climb_help trigger_off();
  self hudson_exits_water_and_climb();
  self thread check_out_poi_in_valley();
  self thread wait_to_start_log_encounter();
}

hudson_village_ahead_vo() {
  level endon("end_dialogue_broken_stealth");
  wait 4;
  level.ai_hudson say_dialog("huds_village_ahead_the_0");
  level.player say_dialog("maso_we_can_call_for_emer_0");
}

wait_to_start_log_encounter() {
  trigger_wait("trig_valley_heli");
  wait 2;
  flag_set("village_antenna_spotted");
}

player_bird_fx_during_antenna_reveal() {
  level.player endon("death");
  trigger_wait("trig_valley_heli");
  exploder_after_wait(351);
}

check_out_poi_in_valley() {
  self change_movemode("cqb_run");
  trigger_wait("trig_color_approach_from_beach_2");
  self change_movemode("cqb_sprint");
}

angola_stealth_objectives() {
  flag_wait("angola_2_gump_village");
  wait 0.25;
  autosave_by_name("mason_carrying_woods");
  flag_wait("js_hudson_executes_hind_pilot");
  wait 0.5;
  s_obj_escape_jungle_1 = getstruct("into_jungle_1", "targetname");
  set_objective(level.obj_escape_jungle, s_obj_escape_jungle_1, "breadcrumb");
  flag_wait("js_hudson_mason_rock_climb_start");
  s_obj_escape_jungle_2 = getstruct("into_jungle_2", "targetname");
  set_objective(level.obj_escape_jungle, s_obj_escape_jungle_2, "breadcrumb");
  maps\angola_jungle_stealth_carry::set_carry_crouch_speed(level.default_mason_carry_crouch_speed * 0.9);
}

angola_jungle_stealth_log_objectives() {
  flag_wait("js_hudson_mason_rock_climb_complete");
  autosave_by_name("js_hudson_mason_rock_climb_complete");
  wait 0.1;
  t_trigger = getent("objective_mason_hudson_see_child_soldiers_trigger", "targetname");
  str_struct_name = t_trigger.target;
  s_struct = getstruct(str_struct_name, "targetname");
  flag_wait("village_antenna_spotted");
  set_objective(level.obj_escape_jungle, undefined, "delete");
  set_objective(level.obj_radio_for_extraction, s_struct, "");
  flag_set("js_hudson_lookout_for_child_soldiers");
  flag_wait("mason_run_to_log_cover");
  flag_wait("hudson_child_soldier_intro_move_to_cover_started");

  if(stealth_safe_to_save())
    autosave_by_name("before_log_scene");

  wait 6;
  level notify("hudson_under_log");
  set_objective(level.obj_radio_for_extraction, undefined, "done");
  set_objective(level.obj_dont_get_discovered);
  t_trigger = getent("objective_mason_hide_under_log_cover_trigger", "targetname");

  if(isDefined(t_trigger)) {
    str_struct_name = t_trigger.target;
    s_struct = getstruct(str_struct_name, "targetname");
    set_objective(level.obj_dont_get_discovered, s_struct, "");
    t_trigger waittill("trigger");
    flag_set("js_mason_in_cover_behind_log");
  }

  maps\angola_jungle_stealth_carry::set_carry_crouch_speed(level.default_mason_carry_crouch_speed);
  set_objective(level.obj_dont_get_discovered);
  flag_wait("js_moving_to_stealth_house_enter");
  wait 0.1;
  t_trigger = getent("objective_mason_goto_stealth_building_trigger", "targetname");
  str_struct_name = t_trigger.target;
  s_struct = getstruct(str_struct_name, "targetname");
  set_objective(level.obj_dont_get_discovered, s_struct, "");
  t_trigger waittill("trigger");
  set_objective(level.obj_dont_get_discovered, undefined);
  flag_set("js_mason_in_position_in_building");

  if(stealth_safe_to_save())
    autosave_by_name("mason_at_stealth_house_enter");

  flag_wait("js_stealth_house_complete");
  wait 0.1;
}

chopper_dead_bodies() {
  level thread run_scene_and_delete("chopper_dead_body1");
  level thread run_scene_and_delete("chopper_dead_body2");
  level thread run_scene_and_delete("chopper_dead_body3");
  level thread run_scene_first_frame("pilot_execution_pilot");
  flag_wait("chopper_dead_body3_started");
  m_dead_body_1 = getent("chopper_dead_body1_drone", "targetname");
  m_dead_body_2 = getent("chopper_dead_body2_drone", "targetname");
  m_dead_body_3 = getent("chopper_dead_body3_drone", "targetname");
  flag_wait("js_mason_in_cover_behind_log");
  m_dead_body_1 delete();
  m_dead_body_2 delete();
  m_dead_body_3 delete();
  m_dead_pilot = getent("crashed_hind_pilot_drone", "targetname");
  m_dead_pilot delete();
  delete_scene("pilot_execution_pilot", 1);
  sp_enemy = getent("chopper_dead_body1", "targetname");
  sp_enemy delete();
  sp_enemy = getent("chopper_dead_body2", "targetname");
  sp_enemy delete();
  sp_enemy = getent("chopper_dead_body3", "targetname");
  sp_enemy delete();
  sp_enemy = getent("crashed_hind_pilot", "targetname");
  sp_enemy delete();
}

hudson_exits_water_and_climb() {
  str_scene_name = "j_stealth_player_picks_up_woods_hudson_watches";
  run_scene_and_delete(str_scene_name);
  level clientnotify("aS_off");
  flag_set("js_hudson_executes_hind_pilot");
  level thread play_hudson_rock_climb_anims();
  flag_set("js_hudson_waiting_at_log_blockage");
  t_climb_help = getent("hudson_rock_bockage_trigger", "targetname");
  t_climb_help trigger_on();
  t_climb_help waittill("trigger");
  flag_set("js_hudson_mason_rock_climb_start");
  hide_player_carry();
  level thread run_scene_and_delete("hudson_mantle_help");
  run_scene_and_delete("mason_woods_mantle_help");
  level.player startcameratween(0.25);
  unhide_player_carry();
  delete_scene("hudson_mantle_climb", 1);
  delete_scene("hudson_mantle_climb_loop", 1);
  trigger_use("trig_color_approach_from_beach_1");
  flag_set("js_hudson_mason_rock_climb_complete");
  flag_set("fxanim_grass_spawn");
  level thread hudson_village_ahead_vo();
}

play_hudson_rock_climb_anims() {
  level endon("js_hudson_mason_rock_climb_start");
  run_scene_and_delete("hudson_mantle_climb");
  level thread run_scene("hudson_mantle_climb_loop");
}

hudson_get_into_position_after_rock_blockage() {
  t_trigger = getent("color_hudson_1st_child_reveal_trigger", "targetname");
  t_trigger activate_trigger();
  wait 0.1;
  level.ai_hudson waittill("goal");
  wait 2.5;
}

#using_animtree("generic_human");

hudsun_approaches_child_solider_encounter() {
  level endon("fail_valley");
  flag_wait("js_hudson_lookout_for_child_soldiers");
  level thread enemy_activity_before_log_scene();
  level notify("stop_following_hudson_nag");
  level thread mason_run_to_log_cover();
  level thread run_scene_and_delete("hudson_child_soldier_intro_move_to_cover");
  self waittill("goal");
  trigger_use("color_hudson_waiting_for_house_move_trigger");
  time = getanimlength( % ch_ang_07_02_hiding_spot_hault_hudson);
  flag_wait_or_timeout("hudson_child_soldier_intro_move_to_cover_done", time);

  if(!flag("watch_1st_child_soldier_encounter_started"))
    level thread run_scene("hudson_waits_in_cover_for_player_to_take_cover");

  flag_wait("js_child_soldier_scene_complete");
  end_scene("hudson_waits_in_cover_for_player_to_take_cover");
  delete_scene("hudson_waits_in_cover_for_player_to_take_cover", 1);
}

enemy_activity_before_log_scene() {
  level thread hault_enemy_before_log_scene();
  trigger_wait("trig_log_started");
  s_bird_fx_org = getstruct("birds_fx_log", "targetname");
  level notify("fxanim_crow_up_start");
  playsoundatposition("evt_birds_fly_off_2", s_bird_fx_org.origin);
  ai_enemy = simple_spawn_single("stair_enemy");
  ai_enemy thread stair_enemy_for_log_scene_logic();
  scene_wait("going_down_stairs_8x16_2");
  ai_enemy = simple_spawn_single("stair_enemy");
  ai_enemy thread stair_enemy_for_log_scene_logic();
}

hault_enemy_before_log_scene() {
  level endon("fail_before_log");
  run_scene("hault_guy");

  if(!flag("js_mason_in_cover_behind_log"))
    level thread run_scene("wait_guy");
}

stair_enemy_for_log_scene_logic() {
  add_generic_ai_to_scene(self, "going_down_stairs_8x16_2");
  run_scene("going_down_stairs_8x16_2");
  self.goalradius = 16;
  s_dest = getstruct("stair_done_dest", "targetname");
  self setgoalpos(s_dest.origin);
  self waittill("goal");
  self delete();
}

mason_run_to_log_cover() {
  flag_set("mason_run_to_log_cover");
  flag_wait("js_mason_in_cover_behind_log");
  level thread clean_up_before_log_scene();
  level thread jungle_stealth_ent_clean_up();
  trigger_off("trig_fail_before_log");
  hide_player_carry();
  level notify("clean_up_barge_ents");
  level thread maps\_audio::switch_music_wait("ANGOLA_STEALTH_VILLAGE", 12);
  level thread run_scene_and_delete("watch_1st_child_soldier_encounter");
  run_scene_and_delete("player_prone_watches_1st_child_soldier_encounter");
  unhide_player_carry();
  flag_set("js_child_soldier_scene_complete");
}

clean_up_before_log_scene() {
  delete_scene("hault_guy", 1);
  delete_scene("wait_guy", 1);
  delete_scene("going_down_stairs_8x16_2", 1);
}

get_to_log_fail() {
  level endon("js_mason_in_cover_behind_log");
  wait 16;
  missionfailedwrapper(&"ANGOLA_2_MISSION_FAILED_LOST_CONTACT_WITH_HUDSON");
}

waiting_for_stealth_move_to_house() {
  flag_wait("js_child_soldier_scene_complete");
  level thread hudson_waiting_for_stealth_move_to_house();

  if(stealth_safe_to_save())
    autosave_by_name("child_soldier_reveal_started");

  level thread child_guards_after_log_scene("child_guards_a", "trig_child_guards_a");
  level thread child_guards_after_log_scene("child_guards_b", "trig_child_guards_b");
  level thread fail_child_guards();
  wait 0.5;

  if(is_mason_stealth_crouched()) {
    level.woods_carry_is_crouched = 0;
    level.__force_stand_up = 1;
  }

  str_crouch_flag = "player_obeys_stealth_command";
  flag_clear(str_crouch_flag);

  if(!level.console && !level.player gamepadusedlast())
    level thread helper_message(&"ANGOLA_2_STEALTH_MASON_USE_GRASS_AS_COVER_PC", 6, str_crouch_flag);
  else
    level thread helper_message(&"ANGOLA_2_STEALTH_MASON_USE_GRASS_AS_COVER", 6, str_crouch_flag);

  str_area_safe = "area_clear";
  level thread fail_mission_if_not_in_crouch_cover(str_area_safe, 7.0, 1.5, 3.5);
  level thread stealth_log_monitor_player_crouch();
  level thread fail_after_log("stealth_volume_by_log");
  flag_wait_or_timeout("player_obeys_stealth_command", 7);
  level thread stealth1_bad_dudes_wave3();
  level thread stealth1_bad_dudes_wave2(0.5);
  level thread stealth1_bad_dudes_wave1(3.6);
  level thread patrol_director();
  exploder_after_wait(251);
  flag_wait("js_moving_to_stealth_house_enter");
  level notify(str_area_safe);
  str_trigger = "player_enters_stealth_house_trigger";
  e_trigger = getent(str_trigger, "targetname");
  e_trigger waittill("trigger");
  flag_set("js_player_enters_stealth_house");
}

stealth_log_monitor_player_crouch() {
  level.player endon("death");
  level endon("missionfailed");
  level endon("stealth_log_stop_monitoring_crouch");
  level endon("js_player_enters_stealth_house");

  while(true) {
    if(is_mason_stealth_crouched() && !flag("player_obeys_stealth_command"))
      flag_set("player_obeys_stealth_command");

    wait 0.05;
  }
}

patrol_director() {
  wait 0.15;
  level delay_notify("patrol_director_vo", 1.0);
  level thread run_scene_and_delete("direct_patrol");
  flag_wait("direct_patrol_started");
  ai_director = getent("patrol_director_ai", "targetname");
  ai_director endon("death");
  ai_director.ignoreall = 1;
  ai_director thread patroller_logic("director_start", 1);

  if(isDefined(ai_director) && isalive(ai_director))
    level thread enemy_vo_post_log_pre_house(ai_director);

  level waittill("fail_after_log");
  ai_director.ignoreall = 0;
  ai_director change_movemode();
}

child_guards_after_log_scene(str_scene, str_trigger) {
  level endon("js_mason_in_position_in_building");
  level thread run_scene(str_scene);

  if(str_scene == "child_guards_c") {
    flag_wait("child_guards_c_started");
    ai_guard = getent("child_guard_c_2_ai", "targetname");
    ai_guard thread guard_c_logic(str_scene);
  }

  trigger_wait(str_trigger);
  end_scene(str_scene);
  level notify("child_guards_alerted");
  flag_set("child_guards_alerted");
}

guard_c_logic(str_scene) {
  self endon("death");
  self.ignoreall = 1;
  self thread patroller_logic("child_guard_c_start");
  trigger_wait("trig_ready_to_hide_in_house");
  end_scene(str_scene);
}

stealth1_bad_dudes_wave1(delay) {
  if(isDefined(delay))
    wait(delay);

  a_nodes = [];
  a_nodes[0] = "go_house_wave1_a1";
  a_nodes[1] = "go_house_wave1_a2";
  a_nodes[2] = "go_house_wave1_a3";
  level thread ai_run_along_node_array("go_house_wave1_a1_spawner", a_nodes, 1, 0, undefined);
  a_nodes = [];
  a_nodes[0] = "go_house_wave1_b1";
  a_nodes[1] = "go_house_wave1_b2";
  a_nodes[2] = "go_house_wave1_b3";
  level thread ai_run_along_node_array("go_house_wave1_b1_spawner", a_nodes, 1, 0, undefined);
  a_nodes = [];
  a_nodes[0] = "go_house_wave1_c1";
  a_nodes[1] = "go_house_wave1_c2";
  a_nodes[2] = "go_house_wave1_c3";
  level thread ai_run_along_node_array("go_house_wave1_c1_spawner", a_nodes, 1, 0, undefined);
}

stealth1_bad_dudes_wave2(delay) {
  if(isDefined(delay))
    wait(delay);

  a_nodes = [];
  a_nodes[0] = "go_house_wave2_a1";
  a_nodes[1] = "go_house_wave2_a2";
  a_nodes[2] = "go_house_wave2_a3";
  level thread ai_run_along_node_array("go_house_wave2_a1_spawner", a_nodes, 1, 0, undefined);
  a_nodes = [];
  a_nodes[0] = "go_house_wave2_b1";
  a_nodes[1] = "go_house_wave2_b2";
  a_nodes[2] = "go_house_wave2_a3";
  level thread ai_run_along_node_array("go_house_wave2_b1_spawner", a_nodes, 1, 0, undefined);
}

stealth1_bad_dudes_wave3(delay) {
  if(isDefined(delay))
    wait(delay);

  a_nodes = [];
  a_nodes[0] = "go_house_wave3_a1";
  a_nodes[1] = "go_house_wave3_a2";
  a_nodes[2] = "go_house_wave3_a3";
  level thread ai_run_along_node_array("go_house_wave3_a1_spawner", a_nodes, 1, 0, undefined);
  a_nodes = [];
  a_nodes[0] = "go_house_wave3_b1";
  a_nodes[1] = "go_house_wave3_b2";
  a_nodes[2] = "go_house_wave3_a3";
  level thread ai_run_along_node_array("go_house_wave3_b1_spawner", a_nodes, 1, 0, undefined);
  a_nodes = [];
  a_nodes[0] = "go_house_wave3_c1";
  a_nodes[1] = "go_house_wave3_c2";
  a_nodes[2] = "go_house_wave3_a3";
  level thread ai_run_along_node_array("go_house_wave3_c1_spawner", a_nodes, 1, 0, undefined);
}

hudson_waiting_for_stealth_move_to_house() {
  level.player endon("death");
  level endon("missionfailed");
  level.ai_hudson.ignoreall = 1;
  level.ai_hudson.ignoreme = 1;
  level.ai_hudson.goalradius = 48;
  level.ai_hudson force_goal(undefined, 48);
  level.ai_hudson waittill("goal");
  level thread hudson_after_log_anim_dialog();
  flag_wait("js_moving_to_stealth_house_enter");
  time_for_player_to_get_in_house = 12;
  level thread fail_player_if_not_in_house(time_for_player_to_get_in_house);
  wait 0.25;
  trigger_off("trig_color_house_wait");
  trigger_use("trig_color_enter_house");
  level thread enter_house_dialog(7);
  level thread child_guards_after_log_scene("child_guards_c", "trig_child_guards_c");
  trigger_wait("trig_hudson_in_house");
  trigger_on("trig_color_house_wait");
  level thread run_scene("hudson_church_loop");
  flag_set("js_hudson_in_position_in_building");
  wait 4;
  level.ai_hudson setmodel(level.ai_hudson.non_wet_model);
}

fail_player_if_not_in_house(delay) {
  level.player endon("death");
  level endon("js_player_enters_stealth_house");

  if(isDefined(delay))
    wait(delay);

  if(!flag("js_player_enters_stealth_house")) {
    spawners = getentarray("fail_player_outside_house_spawners", "targetname");
    array_thread(spawners, ::add_spawn_function, ::chase_after_target, level.player);
    trigger = getent("sm_fail_not_in_house", "targetname");
    trigger activate_trigger();
    trigger = getent("sm_fail_valley", "targetname");
    trigger activate_trigger();
    flag_set("_stealth_spotted");
    level.player s3_player_fail("outside_house", 6);
  }
}

hudson_after_log_anim_dialog(delay) {
  level endon("end_dialogue_broken_stealth");

  if(isDefined(delay) && delay > 0)
    wait(delay);

  level.ai_hudson say_dialog("huds_stay_low_keep_your_0");
  wait 3.5;
  run_scene_and_delete("hudson_rockhide_dont_move");
  wait 4;

  if(is_mason_stealth_crouched())
    run_scene_and_delete("hudson_rockhide_on_my_lead");

  wait 2;
  run_scene_and_delete("hudson_rockhide_now");
  flag_set("js_moving_to_stealth_house_enter");
}

enter_house_dialog(delay) {
  level endon("end_dialogue_broken_stealth");

  if(isDefined(delay) && delay > 0)
    wait(delay);
}

waiting_for_move_to_dense_foliage_area() {
  level endon("mason_failed_to_find_cover_in_house");
  flag_wait("js_player_enters_stealth_house");
  level thread fail_player_if_cover_not_taken_inside_house(10);
  flag_wait("js_hudson_in_position_in_building");
  flag_wait("js_mason_in_position_in_building");
  level thread clean_up_in_house();
  level thread in_house_dialog(0);
  wait 0.1;
  str_area_safe = "house_area_clear";
  str_crouch_flag = "player_obeys_stealth_command";
  flag_clear(str_crouch_flag);
  level thread begin_monitoring_stealth_house_failure(str_area_safe);
  level thread hudson_waiting_for_dense_foliage_move();

  while(true) {
    if(is_mason_stealth_crouched()) {
      flag_set("player_obeys_stealth_command");
      break;
    }

    wait 0.05;
  }

  wait 0.2;
  level thread stealth2_bad_dudes_wave1(0.1);
  level thread stealth2_bad_dudes_wave2(5);
  flag_wait("js_mason_ready_to_exit_house");
  level notify(str_area_safe);
  wait 0.1;
  flag_set("js_stealth_house_complete");
}

begin_monitoring_stealth_house_failure(str_area_safe) {
  level.player endon("death");
  level endon("mason_failed_to_find_cover_in_house");
  level waittill("begin_monitoring_stealth_house_failure");
  a_triggers = getentarray("trig_fail_stealth_in_house_if_running_around", "targetname");
  array_thread(a_triggers, ::house_fail_stealth_if_running_around, str_area_safe);
  child_spawner = getent("spawner_child_house_fail", "script_noteworthy");
  child_spawner add_spawn_function(::house_fail_retreat_after_reveal);
  level thread fail_mission_if_not_in_crouch_cover(str_area_safe, 0, 1.5, 3.5);
  level thread mission_fail_if_not_inside_info_volumes("stealth_containment_area_b", str_area_safe, 4, "js_player_fails_stealth", "player_failed_stealth_in_house", 1);
}

in_house_dialog(delay) {
  level endon("end_dialogue_broken_stealth");

  if(isDefined(delay) && delay > 0)
    wait(delay);

  wait 1;
  level.ai_hudson say_dialog("huds_don_t_move_more_pa_0");
  wait 2.5;

  if(is_mason_stealth_crouched())
    level.ai_hudson say_dialog("huds_i_ll_scout_ahead_w_0");
  else {
    level.ai_hudson say_dialog("huds_dammit_mason_keep_0");

    while(!is_mason_stealth_crouched())
      wait 0.05;

    wait 1.0;
    level.ai_hudson say_dialog("huds_i_ll_scout_ahead_w_0");
  }
}

fail_player_if_cover_not_taken_inside_house(mission_time_out) {
  wait(mission_time_out);

  if(flag("js_mason_in_position_in_building") == 0) {
    level notify("mason_failed_to_find_cover_in_house");
    level thread missionary_patroller();
    wait 4;
    flag_set("js_player_fails_stealth");
    wait 2;
    missionfailedwrapper(&"ANGOLA_2_PLAYER_COVER_BROKEN_SPOTTED");
  }
}

house_fail_stealth_if_running_around(str_area_safe) {
  level.player endon("death");
  level endon(str_area_safe);
  trigger_wait(self.targetname);
  flag_set("js_player_fails_stealth");
  wait 2;
  missionfailedwrapper(&"ANGOLA_2_PLAYER_COVER_BROKEN_SPOTTED");
}

hudson_waiting_for_dense_foliage_move() {
  level endon("mission failed");
  level endon("kill_in_cover_checks");
  level.ai_hudson.ignoreall = 1;
  level.ai_hudson.ignoreme = 1;
  str_crouch_flag = "player_obeys_stealth_command";

  if(!is_mason_stealth_crouched()) {
    if(!level.console && !level.player gamepadusedlast())
      level thread helper_message(&"ANGOLA_2_STEALTH_MASON_USE_GRASS_AS_COVER_PC", 4, str_crouch_flag);
    else
      level thread helper_message(&"ANGOLA_2_STEALTH_MASON_USE_GRASS_AS_COVER", 4, str_crouch_flag);
  }

  str_category = "dummy_category";
  level thread missionary_patroller();
  wait 7;
  level notify("begin_monitoring_stealth_house_failure");
  wait 9;
  wait 8;
  level.ai_hudson thread say_dialog("huds_okay_stay_low_in_0");
  flag_set("js_mason_ready_to_exit_house");
}

missionary_patroller() {
  str_scene = "missionary_patroller";
  level thread run_scene_and_delete(str_scene);
  wait 0.05;
  patroller = get_ais_from_scene(str_scene, "house_follow_path_and_die_spawner");
  level thread missionary_patroller_vo(patroller, str_scene);
  e_ent = getent("house_follow_path_and_die_spawner_ai", "targetname");
  scene_done_flag = str_scene + "_done";

  while(true) {
    if(flag(scene_done_flag)) {
      break;
    }

    if(flag("js_player_fails_stealth")) {
      end_scene(str_scene);
      e_ent.ignoreall = 1;
      e_ent.favoriteenemy = level.player;
      e_ent.script_ignore_suppression = 1;
      e_ent thread aim_at_target(level.player);
      e_ent thread shoot_at_target(level.player, undefined, 0.2, 3);
      return;
    }

    wait 0.01;
  }

  e_ent delete();
}

stealth2_bad_dudes_wave1(delay) {
  if(isDefined(delay) && delay > 0)
    wait(delay);

  a_nodes = [];
  a_nodes[0] = "go_bushes_wave1_a1_node";
  a_nodes[1] = "go_bushes_wave1_a2_node";
  a_nodes[2] = "go_bushes_wave1_a3_node";
  level thread ai_run_along_node_array("go_bushes_wave1_a1_spawner", a_nodes, 1, 0, undefined);
  a_nodes = [];
  a_nodes[0] = "go_bushes_wave1_b1_node";
  a_nodes[1] = "go_bushes_wave1_b2_node";
  a_nodes[2] = "go_bushes_wave1_b3_node";
  level thread ai_run_along_node_array("go_bushes_wave1_b1_spawner", a_nodes, 1, 0, undefined);
}

stealth2_bad_dudes_wave2(delay) {
  if(isDefined(delay) && delay > 0)
    wait(delay);

  a_nodes = [];
  a_nodes[0] = "go_bushes_wave2_a1_node";
  a_nodes[1] = "go_bushes_wave2_a2_node";
  a_nodes[2] = "go_bushes_wave2_a3_node";
  level thread ai_run_along_node_array("go_bushes_wave2_a1_spawner", a_nodes, 1, 0, undefined);
  a_nodes = [];
  a_nodes[0] = "go_bushes_wave2_b1_node";
  a_nodes[1] = "go_bushes_wave2_b2_node";
  a_nodes[2] = "go_bushes_wave2_b3_node";
  level thread ai_run_along_node_array("go_bushes_wave2_b1_spawner", a_nodes, 1, 0, undefined);
  a_nodes = [];
  a_nodes[0] = "go_bushes_wave2_c1_node";
  a_nodes[1] = "go_bushes_wave2_c2_node";
  a_nodes[2] = "go_bushes_wave2_c3_node";
  level thread ai_run_along_node_array("go_bushes_wave2_c1_spawner", a_nodes, 1, 0, undefined);
}

lock_breaker_perk() {
  run_scene_first_frame("lockbreaker_door");
  e_trigger = getent("open_toolshed_trigger", "targetname");
  e_trigger trigger_off();
  level.player waittill_player_has_lock_breaker_perk();
  s_lock_breaker = getstruct("intruder_use_pos", "targetname");
  set_objective(level.obj_interact, s_lock_breaker.origin, "interact");
  e_trigger trigger_on();
  e_trigger setcursorhint("HINT_NOICON");
  e_trigger sethintstring(&"SCRIPT_HINT_LOCK_BREAKER");
  e_trigger waittill("trigger");
  e_trigger delete();
  set_objective(level.obj_interact, s_lock_breaker, "remove");
  level thread run_scene("lockbreaker_door");
  run_scene_and_delete("lockbreaker");
  level thread give_beartraps_to_player_wrapper();
}

play_sound_on_trap_pickup(guy) {
  level.player playsound("evt_beartrap_pickup");
}

give_beartraps_to_player_wrapper() {
  level.player_beartrap_toolshed_pickup = 1;
  maps\angola_2_beartrap::give_player_beartrap();
}

switch_off_angola_escape_triggers() {
  level.a_angola_escape_triggers = [];
  e_trigger = getent("je_battle1_start_trigger", "targetname");
  level.a_angola_escape_triggers[level.a_angola_escape_triggers.size] = e_trigger;
  e_trigger = getent("objective_mason_exit_villiage_into_forest_trigger", "targetname");
  level.a_angola_escape_triggers[level.a_angola_escape_triggers.size] = e_trigger;

  for(i = 0; i < level.a_angola_escape_triggers.size; i++) {
    t_trigger = level.a_angola_escape_triggers[i];
    t_trigger trigger_off();
  }
}

switch_on_angola_escape_trigges() {
  if(isDefined(level.a_angola_escape_triggers)) {
    for(i = 0; i < level.a_angola_escape_triggers.size; i++) {
      t_trigger = level.a_angola_escape_triggers[i];
      t_trigger trigger_on();
    }
  }
}

jungle_stealth_fails() {
  level thread fail_beach();
  level thread fail_valley();
  level thread fail_before_log();
  level thread fail_before_log_timeout();
}

fail_beach() {
  level endon("js_hudson_mason_rock_climb_start");
  flag_wait("js_hudson_waiting_at_log_blockage");
  wait 15;
  level thread fail_beach_action();
}

fail_beach_action() {
  trigger_off("hudson_rock_bockage_trigger", "targetname");
  trigger_use("sm_fail_beach", "targetname");
  level.player thread s3_player_fail("beach", 5);
  wait 3;
  level.ai_hudson say_dialog("huds_shit_they_ve_spott_0");
  end_scene("hudson_mantle_climb_loop");
  flag_set("fail_beach");
  a_ledge_clips = getentarray("ledge_clip", "targetname");

  foreach(m_ledge_clip in a_ledge_clips)
  m_ledge_clip delete();

  set_objective(level.obj_escape_jungle, undefined, "delete");
}

fail_beach_enemy_logic() {
  self endon("death");
  self.goalradius = 16;

  if(isDefined(level.ai_hudson))
    level.ai_hudson.ignoreme = 1;

  e_target = level.player;

  if(!isDefined(self.script_noteworthy) && randomint(2) == 0)
    e_target = level.ai_hudson;

  if(!isDefined(self.script_noteworthy))
    self chase_after_target(e_target);
}

fail_valley() {
  level endon("js_hudson_lookout_for_child_soldiers");
  flag_wait("js_hudson_mason_rock_climb_complete");
  wait 26;
  level thread fail_valley_action();
}

fail_valley_action() {
  level notify("fail_valley");
  trigger_off("objective_mason_hudson_see_child_soldiers_trigger");
  trigger_use("sm_fail_beach");
  trigger_use("sm_fail_valley");
  flag_set("_stealth_spotted");
  level.player s3_player_fail("valley", 4);
  set_objective(level.obj_radio_for_extraction, undefined, "done");
}

fail_before_log() {
  level endon("js_mason_in_cover_behind_log");
  trigger_wait("trig_fail_before_log");
  level thread fail_before_log_action();
}

fail_before_log_timeout() {
  level endon("js_mason_in_cover_behind_log");
  level waittill("hudson_under_log");
  time_to_get_to_log = 10;
  wait(time_to_get_to_log);
  level thread fail_before_log_action();
}

fail_before_log_action() {
  level notify("fail_before_log");
  flag_set("fail_before_log");
  end_scene("hault_guy");
  end_scene("wait_guy");
  t_log_scene = getent("objective_mason_hide_under_log_cover_trigger", "targetname");
  t_log_scene delete();
  trigger_use("sm_fail_beach");
  level.player s3_player_fail(undefined, 4);
}

fail_child_guards() {
  level endon("js_mason_in_position_in_building");
  level waittill("child_guards_alerted");
  level notify("fail_after_log");
  flag_set("fail_after_log");
  trigger_use("trig_fail_before_log");
  trigger_use("sm_fail_valley");
  level.player s3_player_fail(undefined, 4);
}

fail_after_log(str_volume) {
  level endon("js_moving_to_stealth_house_enter");
  e_volume = getent(str_volume, "targetname");

  while(level.player istouching(e_volume) && !flag("js_player_fails_stealth"))
    wait 0.05;

  level thread fail_after_log_action();
}

fail_after_log_action() {
  level notify("fail_after_log");
  end_scene("child_guards_a");
  end_scene("child_guards_b");
  trigger_use("sm_fail_beach");
  trigger_use("trig_fail_before_log");
  level.player s3_player_fail("after_log");
}

fail_player_for_moving_to_escape_early() {
  level endon("a_village_complete");
  trigger_wait("early_escape_fail_trigger");
  missionfailedwrapper(&"SCRIPT_COMPROMISE_FAIL");
}

clean_up_fail_valley() {
  t_fail_valley = getent("sm_fail_valley", "targetname");
  t_fail_valley delete();
  a_spawners = getentarray("enemy_fail_valley", "targetname");

  foreach(sp_enemy in a_spawners)
  sp_enemy delete();
}

clean_up_in_house() {
  for(i = 1; i <= 4; i++) {
    ai_enemy = getent("go_house_ambient_child" + i + "_spawner_ai", "targetname");
    ai_enemy delete();
    sp_enemy = getent("go_house_ambient_child" + i + "_spawner", "targetname");
    sp_enemy delete();
  }

  t_child_guards = getent("trig_child_guards_a", "targetname");
  t_child_guards delete();
  t_child_guards = getent("trig_child_guards_b", "targetname");
  t_child_guards delete();
  t_child_guards = getent("trig_child_guards_c", "targetname");
  t_child_guards delete();
  e_to_be_deleted = getent("clip_house_for_hudson", "targetname");
  e_to_be_deleted connectpaths();
  e_to_be_deleted delete();
  t_fail_before_log = getent("trig_fail_before_log", "targetname");
  t_fail_before_log delete();
  a_spawners = getentarray("enemy_fail_before_log", "targetname");

  foreach(sp_enemy in a_spawners)
  sp_enemy delete();

  delete_scene("child_guards_a", 1);
  delete_scene("child_guards_b", 1);
  delete_scene("child_guards_c", 1);
}

handle_child_soldiers() {
  add_global_spawn_function("axis", ::find_child_soldiers);
}

find_child_soldiers() {
  if(!issubstr(self.classname, "child")) {
    return;
  }
  self thread child_soldier_do_not_shoot_player();
}

child_soldier_do_not_shoot_player() {
  self endon("death");
  level.player endon("death");
  level endon("missionfailed");
  level.ai_hudson endon("death");
  level endon("js_mason_in_position_in_woods_drop_off_area");
  self endon("delete");
  self set_pacifist(1);
  self.ignoreall = 1;
  self.ignoreme = 1;
  self.disablearrivals = 1;
  self.disableexits = 1;
  wait_for_stealth_to_break();
  level notify("stealth_broken");
  self notify("end_patrol");

  if(!self get_pacifist())
    self set_pacifist(1);

  if(!isDefined(self.ignoreall) || !self.ignoreall)
    self.ignoreall = 1;

  if(!isDefined(self.ignoreme) || !self.ignoreme)
    self.ignoreme = 1;

  if(!isDefined(self.disablearrivals) || !self.disablearrivals)
    self.disablearrivals = 1;

  if(!isDefined(self.disableexits) || !self.disableexits)
    self.disableexits = 1;

  self magic_bullet_shield();

  if(self.targetname != "player_failed_stealth_in_house_ai") {
    self set_goal_pos(self.origin);
    volume = getent("child_retreat_volume", "targetname");
    self force_goal(volume.origin, 64, 0);

    while(true) {
      if(self istouching(volume) && !level.player is_player_looking_at(self.origin, 0.75))
        self delete();

      wait 0.15;
    }
  }
}

wait_for_stealth_to_break() {
  failure_flags = [];
  failure_flags[0] = "child_guards_alerted";
  failure_flags[1] = "fail_after_log";
  failure_flags[2] = "fail_before_log";
  failure_flags[3] = "_stealth_spotted";
  failure_flags[4] = "js_player_fails_stealth";
  failure_flags[5] = "fail_beach";
  flag_wait_any_array(failure_flags);
}

house_fail_retreat_after_reveal() {
  self endon("death");
  level endon("missionfailed");
  self.goalradius = 8;
  org = getstruct("org_child_retreat_and_delete", "targetname");
  self waittill("goal");
  self thread force_goal(org.origin);
  self waittill("goal");
  self delete();
}

end_dialogue_when_stealth_breaks() {
  wait_for_stealth_to_break();
  level notify("end_dialogue_broken_stealth");
  level.ai_hudson anim_stopanimscripted();

  if(!flag("fail_beach"))
    level.ai_hudson stopsounds();
}

enemy_vo_post_log_pre_house(patrol_director) {
  level endon("end_dialogue_broken_stealth");
  flag_wait("direct_patrol_started");
  level thread child_search_party_vo();
  patrol_director say_dialog("cub0_spread_out_find_the_0");
  wait 1;
  patrol_director say_dialog("cub0_call_in_when_your_se_0");
}

child_search_party_vo() {
  level endon("end_dialogue_broken_stealth");
  wait 3;
  guys = getaiarray("axis");
  children = [];

  foreach(guy in guys) {
    if(issubstr(guy.classname, "child"))
      children[children.size] = guy;
  }

  lines = array("chi0_spread_out_0", "chi1_check_the_long_grass_0", "chi2_keep_looking_they_0", "chi3_they_may_be_long_gon_0", "chi0_nothing_over_here_0", "chi1_this_area_is_clear_0", "chi2_they_may_have_made_i_0", "chi3_shhh_listen_0", "chi0_they_could_be_anywhe_0");
  min_delay = 2;
  max_delay = 7;
  level thread play_battle_convo_from_array_until_flag(children, lines, min_delay, max_delay, "js_moving_to_stealth_house_enter");
}

missionary_patroller_vo(patroller, str_scene) {
  level endon("end_dialogue_broken_stealth");
  level endon(str_scene + "_done");
  patroller endon("death");
  patroller endon("delete");
  patroller say_dialog("cub3_attention_all_search_0");
  patroller say_dialog("cub2_sedric_report_over_0");
  wait 0.5;
  patroller say_dialog("cub3_last_sighting_was_by_0");
  wait 0.5;
  patroller say_dialog("cub0_begin_your_sweeps_at_0");
  wait 0.5;
  patroller say_dialog("cub3_if_we_don_t_find_the_0");
  patroller say_dialog("cub1_as_soon_as_you_find_0");
  patroller say_dialog("cub0_post_men_at_the_peri_0");
}

enemy_detects_player_vo() {
  level.player endon("death");
  level endon("tall_grass_stealth_done");
  wait_for_stealth_to_break();

  if(!flag("fail_beach"))
    level.ai_hudson say_dialog("huds_shit_they_ve_spott_0");

  adult_lines = array("cub0_over_here_0", "cub1_i_ve_found_them_0", "cub2_they_re_here_0", "cub3_i_ve_got_them_0");
  child_lines = array("chi0_over_here_0", "chi1_i_ve_found_them_0", "chi2_americans_0", "chi0_they_re_over_here_0", "chi1_here_here_0", "chi2_the_americans_are_he_0");

  for(guys = getaiarray("axis"); guys.size <= 1; guys = getaiarray("axis"))
    wait 0.05;

  counter = 0;
  arraysort(guys, level.player.origin, 1);

  while(counter < 2) {
    if(issubstr(guys[counter].classname, "child")) {
      if(isDefined(guys[counter]) && isalive(guys[counter]))
        guys[counter] say_dialog(child_lines[randomint(child_lines.size)]);
    } else if(isDefined(guys[counter]) && isalive(guys[counter]))
      guys[counter] say_dialog(adult_lines[randomint(adult_lines.size)]);

    counter++;
    wait 0.5;
  }
}