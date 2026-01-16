/***************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\nicaragua_mason_woods_freakout.gsc
***************************************************/

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

skipto_mason_woods_freakout() {
  level.hudson = init_hero("hudson");
  level.woods = init_hero("woods");
  skipto_teleport("player_skipto_mason_woods_freakout", get_heroes());
  trigger_use("donkeykong_into_house_colortrigger");
  set_objective(level.obj_mason_up_hill);
  exploder(10);
  setsaveddvar("cg_aggressiveCullRadius", "500");
  model_restore_area("mason_hill_1");
  model_restore_area("mason_hill_2");
  model_restore_area("mason_mission");
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
  level thread run_scene("woods_freakout_doors");
  battlechatter_on("axis");
}

init_flags() {
  flag_init("mason_woods_freakout_complete");
  flag_init("start_woods_freakout_menendez");
  flag_init("WOODS_FREAKOUT_SCENE_BEGIN");
  flag_init("menendez_scene_complete");
}

main() {
  init_flags();
  level thread mason_woods_freakout_objectives();
  mason_woods_freakout_precleanup();
  mason_woods_freakout_setup();
  level.player thread mason_woods_freakout_begin();
  flag_wait("WOODS_FREAKOUT_SCENE_BEGIN");
  setmusicstate("NIC_WOODS_FREAKS");
  level clientnotify("wfo");
}

mason_woods_freakout_objectives() {
  set_objective(level.obj_mason_up_hill, getstruct("woodsfreakout_objective_1"), "");
  trigger_wait("woods_freakout_balcony_trigger");
  set_objective(level.obj_mason_up_hill, undefined, "done");
}

mason_woods_freakout_precleanup() {
  array_delete(getaiarray("axis"));
  array_delete(get_ai_group_ai("mason_side_pdf"));
  array_delete(get_ai_group_ai("mason_truck_turret_targets"));
}

mason_woods_freakout_setup() {
  nd_goal = getnode("woods_freakout_goalnode", "targetname");
  sp_pdf = getent("woods_freakout_pdf", "targetname");
  sp_pdf add_spawn_function(::woods_freakout_pdf_run_to_mission, nd_goal);
  e_stables_clip = getent("clip_barn_door", "targetname");

  if(isDefined(e_stables_clip))
    e_stables_clip delete();
}

mason_woods_freakout_begin() {
  level.woods change_movemode("cqb");
  level.hudson change_movemode("cqb");
  level thread donkeykong_end_vo();
  level thread woods_freakout_woods_intro_scenes();
  level thread woods_freakout_hudson_intro_scenes();
  flag_wait("woods_freakout_idle_WOODS_started");
  flag_wait("woods_freakout_idle_HUDSON_started");
  level thread donkeykong_end_nag_vo();
  trigger_wait("donkeykong_house_upstairs_trigger");
  flag_set("WOODS_FREAKOUT_SCENE_BEGIN");
  level notify("woods_freakout_scene_begin");
  self enableinvulnerability();
  self setlowready(1);
  self thread wait_for_player_to_drop_off_balcony();
  level.player thread woods_freakout_remove_set_low_ready();
  run_scene_first_frame("woods_freakout_menendez");
  level thread run_scene("woods_freakout");
  level thread spawn_woods_freakout_pdf();
  flag_wait("start_woods_freakout_menendez");
  level thread woods_freakout_menendez_scene();
  level.woods change_movemode("run");
  level.hudson change_movemode("run");
  scene_wait("woods_freakout");
  flag_set("mason_woods_freakout_complete");

  if(!flag("player_entered_mission_precourtyard"))
    trigger_use("mason_post_woods_freakout_colortrigger");

  woods_freakout_cleanup();
  autosave_by_name("mason_woods_freakout_complete");
}

woods_freakout_woods_intro_scenes() {
  run_scene("woods_freakout_intro_WOODS");
  level thread run_scene("woods_freakout_idle_WOODS");
}

woods_freakout_hudson_intro_scenes() {
  wait 1.0;
  run_scene("woods_freakout_intro_HUDSON");
  level thread run_scene("woods_freakout_idle_HUDSON");
}

wait_for_player_to_drop_off_balcony() {
  trigger_wait("mason_dropped_off_balcony");
  mason_point_of_no_return_cleanup();
  wait 0.1;
  self disableinvulnerability();
}

woods_freakout_remove_set_low_ready() {
  e_trigger = getent("mason_near_woods_freakout", "targetname");

  while(!flag("menendez_scene_complete")) {
    if(self istouching(e_trigger))
      self setlowready(1);
    else
      self setlowready(0);

    wait 1.0;
  }

  self setlowready(0);
}

woods_freakout_menendez_scene() {
  run_scene("woods_freakout_menendez");
  flag_set("menendez_scene_complete");
}

spawn_woods_freakout_pdf() {
  wait 5;
  spawn_manager_enable("woods_freakout_pdf_sm");
}

woods_freakout_pdf_run_to_mission(nd_goal) {
  self endon("death");
  self change_movemode("sprint");
  self.goalradius = 16;
  self thread timebomb(15, 20);
}

woods_freakout_menendez(e_woods) {
  flag_set("start_woods_freakout_menendez");
}

balcony_door_open(e_woods) {
  e_clip = getent("woods_freakout_door_clip", "targetname");
  e_clip delete();
}

menendez_opens_stables_door(e_menendez) {
  level thread start_charging_horse("stables_charging_horse2_spawner", "horse2_charging_path_start_node", 1.0, 25);
  level thread start_charging_horse("stables_charging_horse3_spawner", "horse3_charging_path_start_node", 0.75, 20);
  level thread start_charging_horse("stables_charging_horse4_spawner", "horse4_charging_path_start_node", 0.25, 20);
  level thread start_charging_horse("stables_charging_horse5_spawner", "horse4_charging_path_start_node", 2.0, 20);
}

menendez_stables_explosion(e_menendez) {
  exploder(10326);
  playsoundatposition("evt_barn_explo_woods", (-3802, 2784, 1823));
}

donkeykong_end_vo() {
  level.hudson queue_dialog("huds_on_me_0");
}

donkeykong_end_nag_vo() {
  level endon("woods_freakout_scene_begin");
  wait 1.0;
  level.hudson queue_dialog("huds_we_re_waiting_on_you_0", 0, undefined, "WOODS_FREAKOUT_SCENE_BEGIN");
  wait(randomfloatrange(10.0, 15.0));
  level.hudson queue_dialog("huds_come_on_mason_get_1", 0, undefined, "WOODS_FREAKOUT_SCENE_BEGIN");
}

mason_point_of_no_return_cleanup() {
  fxanim_deconstructions_for_mason_side1();
  vh_truck = getent("mason_truck", "targetname");

  if(isDefined(vh_truck))
    vh_truck delete();

  maps\nicaragua_mason_hill::mason_hill_stop_exploders();
  delete_scene_all("mason_truck_pdf_corpse");
}

woods_freakout_cleanup() {
  delete_scene("woods_freakout_doors", 1);
  delete_scene("woods_freakout_intro_HUDSON", 1);
  delete_scene("woods_freakout_intro_WOODS", 1);
  delete_scene("woods_freakout_idle_HUDSON", 1);
  delete_scene("woods_freakout_idle_WOODS", 1);
  delete_scene("woods_freakout", 1);
  delete_scene("woods_freakout_menendez", 1);
  wait 1.0;
  level.woods reset_movemode();
  level.hudson reset_movemode();
  setmusicstate("NIC_RAID_BATTLE_2");
  level clientnotify("wdfo");
}