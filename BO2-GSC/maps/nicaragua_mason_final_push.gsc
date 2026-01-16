/***********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\nicaragua_mason_final_push.gsc
***********************************************/

#include common_scripts\utility;
#include maps\_utility;
#include maps\_dialog;
#include maps\_scene;
#include maps\_objectives;
#include maps\nicaragua_util;
#include maps\_anim;
#include maps\_vehicle;

skipto_mason_final_push() {
  level.woods = init_hero("woods");
  skipto_teleport("player_skipto_mason_final_push", get_heroes());
  exploder(101);
  exploder(10);
  model_removal_through_model_convert_system("mason_hill_1");
  model_removal_through_model_convert_system("mason_hill_2");
  model_removal_through_model_convert_system("mason_mission");
  model_restore_area("mason_bunker");
  model_restore_area("mason_final_push");
  maps\_vehicle::spawn_vehicle_from_targetname("mason_finalpush_truck");
  battlechatter_on("axis");
}

init_flags() {
  flag_init("nicaragua_final_push_complete");
  flag_init("ready_to_end_final_push");
  flag_init("bunker_exit_door_closed");
  flag_init("woods_backbreaker_scene_complete");
  flag_init("backbreaker_player_anim_complete");
  flag_init("final_push_enemies_killed");
  flag_init("woods_backbreaker_mature_content_fade_out");
  flag_init("woods_backbreaker_mature_content_fade_in");
  flag_init("josefina_gump_loaded");
}

main() {
  init_flags();
  level thread nicaragua_final_push_objectives();
  mason_final_push_setup();
  level thread unload_bunker_gump();
  level thread close_bunker_hatch();
  level thread woods_backbreaker_factionfight();
  woods_backbreaker();
  level thread end_mason_final_push_checker();
  flag_wait("nicaragua_final_push_complete");
  final_push_cleanup();
}

nicaragua_final_push_objectives() {
  set_objective(level.obj_mason_find_menendez);
}

mason_final_push_setup() {
  exploder(590);
  createthreatbiasgroup("mason_finalpush_factionfight_cartel");
  createthreatbiasgroup("mason_finalpush_factionfight_pdf");
  createthreatbiasgroup("player_squad");
  add_spawn_function_ai_group("mason_finalpush_factionfight_cartel", ::cartel_add_to_threatbiasgroup);
  add_spawn_function_ai_group("mason_finalpush_factionfight_pdf", ::pdf_add_to_threatbiasgroup);
  level.player setthreatbiasgroup("player_squad");
  level.woods setthreatbiasgroup("player_squad");
  spawn_manager_enable("mason_finalpush_mission_cartel_spawnmanager");
  spawn_manager_enable("mason_finalpush_pdf_lower_spawnmanager");
  setthreatbias("mason_finalpush_factionfight_cartel", "mason_finalpush_factionfight_pdf", 100);
  setthreatbias("mason_finalpush_factionfight_pdf", "mason_finalpush_factionfight_cartel", 100);
  setthreatbias("player_squad", "mason_finalpush_factionfight_cartel", 0);
  run_scene_first_frame("door_preshattered");
}

cartel_add_to_threatbiasgroup() {
  self setthreatbiasgroup("mason_finalpush_factionfight_cartel");
}

pdf_add_to_threatbiasgroup() {
  self setthreatbiasgroup("mason_finalpush_factionfight_pdf");
}

unload_bunker_gump() {
  flag_wait("bunker_exit_door_closed");
  clearallcorpses();
  flag_wait("woods_backbreaker_scene_complete");
  a_e_coke = getentarray("destructible_cocaine_bundles", "script_noteworthy");

  foreach(coke_bundle in a_e_coke)
  coke_bundle delete();

  wait 1.0;
  load_gump("nicaragua_gump_josefina");
  flag_set("josefina_gump_loaded");
  autosave_by_name("mason_woods_backbreaker_complete");
}

close_bunker_hatch() {
  flag_wait("backbreaker_player_anim_complete");
  e_hatch = getent("bunker_exit_hatch", "targetname");
  s_hinge = getstruct("bunker_hatch_exit_hinge", "targetname");
  e_hatch.origin = s_hinge.origin;
  e_hatch.angles = s_hinge.angles;
  level thread mason_final_push_point_of_no_return_cleanup();
  flag_set("bunker_exit_door_closed");
  level clientnotify("fr_on");
}

woods_backbreaker_factionfight() {
  simple_spawn("woods_backbreaker_factionfight_cartel1", ::wakeup_woods_backbreaker_factionfight_cartel1);
  simple_spawn("woods_backbreaker_factionfight_cartel2", ::wakeup_woods_backbreaker_factionfight_cartel2);
}

wakeup_woods_backbreaker_factionfight_cartel1() {
  self endon("death");
  self.takedamage = 0;
  level waittill("player_left_bunker");
  self set_ignoreme(0);
  self set_ignoreall(0);
  flag_wait("backbreaker_player_anim_complete");
  self.takedamage = 1;
  wait(randomfloatrange(0.25, 1.0));
  self change_movemode("sprint");
  nd_goal = getnode("finalpush_cartel1", "script_noteworthy");
  self setgoalnode(nd_goal);
  self waittill("goal");
  self reset_movemode();
}

wakeup_woods_backbreaker_factionfight_cartel2() {
  self endon("death");
  self.takedamage = 0;
  level waittill("player_left_bunker");
  self set_ignoreme(0);
  self set_ignoreall(0);
  flag_wait("backbreaker_player_anim_complete");
  self.takedamage = 1;
  wait(randomfloatrange(1.5, 2.5));
  nd_goal = getnode("finalpush_cartel1", "script_noteworthy");
  self setgoalnode(nd_goal);
  wait 1.5;
  self change_movemode("sprint");
  self waittill("goal");
  self reset_movemode();
}

woods_backbreaker() {
  level thread final_push_start_vo();
  run_scene("woods_bunker_exit_approach");
  level thread run_scene("woods_bunker_exit_wait");
  s_struct = getstruct("bunker_exit_struct", "targetname");
  set_objective(level.obj_mason_bunker_exit, s_struct, "");
  trigger_wait("begin_woods_backbreaker");
  level thread bunker_exit_vo();
  set_objective(level.obj_mason_bunker_exit, undefined, "delete");
  e_clip = getent("woods_backbreaker_clip", "targetname");
  e_clip linkto(level.woods, "tag_origin", (0, 0, 0), (0, 0, 0));
  level thread run_scene("woods_bunker_exit");
  level.woods playsound("evt_mtl_door_kick");
  level.woods thread woods_backbreaker_idle();
  trigger_wait("woods_backbreaker_player");
  level notify("player_left_bunker");

  if(!is_mature())
    level.player thread woods_backbreaker_mature_content_filter();

  run_scene("woods_backbreaker_player");
  flag_set("backbreaker_player_anim_complete");
  trigger_use("mason_final_courtyard");
  scene_wait("woods_backbreaker");
  flag_set("woods_backbreaker_scene_complete");
  level thread final_push_vo();
  set_objective(level.obj_mason_find_menendez, level.woods, "follow");
  level.woods change_movemode("sprint");
  level.woods woods_rampage(1);
  e_clip delete();
  level.woods thread wait_for_woods_to_reach_door();
  level thread check_for_final_push_enemies_dead();
}

woods_backbreaker_mature_content_filter() {
  flag_wait("woods_backbreaker_mature_content_fade_out");
  self enableinvulnerability();
  self freezecontrols(1);
  screen_fade_out(1);
  flag_wait("woods_backbreaker_mature_content_fade_in");
  screen_fade_in(1);
  self disableinvulnerability();
  self freezecontrols(0);
}

woods_backbreaker_idle() {
  level endon("player_left_bunker");
  scene_wait("woods_bunker_exit");
  nd_goal = getnode("woods_backbreaker_moveforward", "targetname");
  self.goalradius = 32;
  self setgoalnode(nd_goal);
  self waittill("goal");
  level thread run_scene("woods_backbreaker_idle");
}

woods_backbreaker_door_kick(e_woods) {
  exploder(667);
}

woods_backbreaker_door_fully_open(e_woods) {
  e_clip = getent("bunker_exit_door_clip", "targetname");
  e_clip delete();
}

start_backbreaker(m_player_body) {
  level thread run_scene("woods_backbreaker");
}

woods_backbreaker_start_scuffle(e_cartel) {
  flag_set("woods_backbreaker_mature_content_fade_out");
}

woods_backbreaker_head_slam(e_cartel) {
  exploder(671);
  level thread backbreaker_vo();
}

woods_backbreaker_neck_snap(e_cartel) {
  exploder(670);
}

woods_backbreaker_become_corpse(e_cartel) {
  flag_set("woods_backbreaker_mature_content_fade_in");
}

woods_rampage(b_on) {
  if(b_on) {
    self.oldgrenadeawareness = self.grenadeawareness;
    self.grenadeawareness = 0;
    self.ignoresuppression = 1;
    self disable_react();
    self disable_careful();
    self.perfectaim = 1;
    self disable_pain();
  } else {
    if(isDefined(self.oldgrenadeawareness)) {
      self.grenadeawareness = self.oldgrenadeawareness;
      self.oldgrenadeawareness = undefined;
    }

    self.ignoresuppression = 0;
    self enable_react();
    self enable_careful();
    self.perfectaim = 0;
    self enable_pain();
  }
}

wait_for_woods_to_reach_door() {
  self waittill("goal");
  flag_set("ready_to_end_final_push");
}

check_for_final_push_enemies_dead() {
  a_ai_cartel = get_ai_group_ai("mason_finalpush_cartel");
  waittill_dead_or_dying(a_ai_cartel);
  flag_set("final_push_enemies_killed");
}

end_mason_final_push_checker() {
  flag_wait_all("ready_to_end_final_push", "final_push_enemies_killed", "josefina_gump_loaded");
  run_scene("mason_preshattered");
  level thread run_scene("mason_preshattered_idle");
  trigger_wait("end_mason_final_push_trigger");
  flag_set("nicaragua_final_push_complete");
  level.woods woods_rampage(0);
  level.woods reset_movemode();
  level.player setmovespeedscale(1.0);
  set_objective(level.obj_mason_follow_woods, undefined, "remove");
}

final_push_start_vo() {
  level.woods queue_dialog("wood_come_on_mason_1");
}

bunker_exit_vo() {
  if(is_mature()) {
    level.woods queue_dialog("wood_fucking_junkies_0");
    level.woods queue_dialog("wood_hudson_you_scoped_0", 1);
  } else {
    level.woods queue_dialog("wood_we_re_fighting_junki_0");
    level.woods queue_dialog("wood_hudson_you_scoped_1", 1);
  }

  level.player queue_dialog("huds_he_s_inside_the_hous_0", 1);
  level.woods queue_dialog("wood_on_my_way_0", 1);
  level.player queue_dialog("huds_negative_woods_we_0", 1);
  level.player queue_dialog("huds_woods_2", 1);
}

backbreaker_vo() {
  if(is_mature())
    level.player queue_dialog("maso_damn_woods_0", 0.5);
  else
    level.player queue_dialog("maso_temper_woods_0", 0.5);
}

final_push_vo() {
  if(is_mature())
    level.woods queue_dialog("wood_hustle_mason_up_t_0");
  else
    level.woods queue_dialog("wood_hustle_mason_i_m_0");

  level.player queue_dialog("maso_slow_down_woods_0", 0.5);
  wait 2;
  level.b_screamed = 0;
  level.woods thread woods_scream_melee();
  level.woods thread woods_scream_approach();
}

woods_scream_melee() {
  level endon("ready_to_end_final_push");

  while(true) {
    if(isDefined(self.melee)) {
      level.b_screamed = 1;
      self queue_dialog("wood_woods_screaming_stor_0", 1);
    }

    wait 0.1;
  }
}

woods_scream_approach() {
  level endon("ready_to_end_final_push");
  nd_door = getnode("mason_final_push_exit", "targetname");

  while(true) {
    if(distance2dsquared(self.origin, nd_door.origin) <= 122500) {
      if(!level.b_screamed) {
        level.b_screamed = 1;
        self queue_dialog("wood_woods_screaming_stor_0", 0);
      }
    }

    wait 0.1;
  }
}

mason_final_push_point_of_no_return_cleanup() {
  a_t_firetriggers = getentarray("fire_damage_trigger", "script_noteworthy");

  foreach(trigger in a_t_firetriggers) {
    if(isDefined(trigger))
      trigger delete();
  }

  clientnotify("bunker_lightflares_off");
  delete_exploder(660);
  delete_exploder(665);
  delete_exploder(666);
  delete_exploder(668);
  delete_exploder(669);
  model_delete_area("mason_bunker");
}

final_push_cleanup() {
  delete_scene("woods_bunker_exit_approach", 1);
  delete_scene("woods_bunker_exit_wait", 1);
  delete_scene("woods_bunker_exit", 1);
  delete_scene("woods_backbreaker_idle", 1);
  delete_scene("woods_backbreaker", 1);
  delete_scene("woods_backbreaker_player", 1);
  delete_exploder(671);
  delete_exploder(667);
  delete_exploder(670);
  spawn_manager_disable("mason_finalpush_mission_cartel_spawnmanager");
  spawn_manager_disable("mason_finalpush_pdf_lower_spawnmanager");
  kill_spawnernum(17);
}