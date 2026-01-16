/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\karma_dropdown.gsc
**************************************/

#include common_scripts\utility;
#include maps\_utility;
#include maps\_dialog;
#include maps\_glasses;
#include maps\_objectives;
#include maps\_scene;
#include maps\karma_util;
#include maps\karma_arrival;
#include maps\karma_anim;
#include maps\_vehicle;
#include maps\_spiderbot;

init_flags() {
  flag_init("setup_spiderbot");
  flag_init("ambush_attack");
  flag_init("dropdown_end");
  flag_init("harper_goto_vent");
  flag_init("dropdown_elevator_open");
  flag_init("dropdown_early_exit");
}

init_spawn_funcs() {
  add_global_spawn_function("axis", ::change_movemode, "cqb_run");
  add_spawn_function_group("dropdown_patrol", "targetname", ::ambush_guy_think);
}

skipto_dropdown2() {
  iprintln("elevator_1");

  cleanup_ents("cleanup_checkin");
  cleanup_ents("cleanup_tower");
  maps\karma_arrival::deconstruct_fxanims();
  level.ai_salazar = init_hero("salazar_pistol");
  bm_lift_left = setup_elevator("tower_lift_left", "tower_elevator_1", "cleanup_dropdown");
  s_dest = getstruct("tower_lift_left_bottom", "targetname");
  flag_set("elevator_reached_construction");
  wait 0.05;
  bm_lift_left.origin = s_dest.origin;
  flag_set("dropdown_elevator_open");
  skipto_teleport("skipto_dropdown");
}

main() {
  maps\karma_anim::dropdown_anims();
  level thread dropdown_objectives();
  trigger_off("construction_battle_color_triggers", "script_noteworthy");
  level.ai_salazar thread ally_dropdown_think(getnode("salazar_dropdown_goal", "targetname"));
  flag_wait("dropdown_elevator_open");
  bm_lift_left = getent("tower_lift_left", "targetname");
  bm_lift_left thread elevator_move_doors(1, 1.0, 0.2, 0.5);
  ambush_guy_head_init();
  level thread run_scene_and_delete("elevator_encounter1");
  level thread run_scene_and_delete("elevator_encounter2");

  foreach(guy in getentarray("dropdown_patrol_ai", "targetname")) {
    if(guy.animname == "dropdown_guard1")
      level.dropdown_guy = guy;
  }

  run_scene_and_delete("tower_elevator_open");
  clientnotify("construction_line");
  flag_wait_or_timeout("dropdown_early_exit", 5.0);

  if(flag("dropdown_early_exit")) {
    end_scene("elevator_encounter1");
    end_scene("elevator_encounter2");
  }

  level thread autosave_now("karma_dropdown");
  flag_set("draw_weapons");
  setsaveddvar("g_speed", level.default_run_speed);
  flag_set("player_act_normally");
  scene_wait("elevator_encounter1");
  wait 1.0;

  if(!flag("elevator_encounter2_done"))
    end_scene("elevator_encounter2");

  flag_set("ambush_attack");
  waittill_ai_group_ai_count("dropdown_patrol", 0);
  level thread farid_comm();
  level.ai_salazar thread salazar_vent_wait();
  flag_wait("salazar_go_inside_spiderbot_started");
  trigger_wait("t_setup_spiderbot");
  getent("clip_tower_lift_top", "targetname") solid();
  getent("tower_elevator_1", "targetname") notify("elevator_flashlight_off");
  bm_lift_left thread elevator_move_doors(0, 1.0, 0.2, 0.5);
  level thread run_scene_and_delete("tower_elevator_close");
  getent("duffle_bag", "targetname") delete();
  flag_set("setup_spiderbot");
  level.player playsound("evt_spiderbot_intro");
  level thread run_scene_and_delete("set_spiderbot_player");
  wait 1.0;
  level thread run_scene_and_delete("set_spiderbot_salazar");
  wait 11.0;
  level.vh_spiderbot = maps\_vehicle::spawn_vehicle_from_targetname("spiderbot");
  level.vh_spiderbot thread maps\_spiderbot::main();
  wait 3.0;
  cin_id = play_movie_on_surface_async("spider_bootup", 1, 0);
  scene_wait("set_spiderbot_player");
  end_scene("salazar_wait_vent_spiderbot");
  stop3dcinematic(cin_id);
  cleanup_ents("cleanup_dropdown");
  level thread autosave_now("karma_spiderbot");
}

hide_spiderbot_case(ent) {
  ent hide();
}

show_spiderbot_case(ent) {
  ent show();
  ent.script_noteworthy = "cleanup_construction";
}

spiderbot_pad_add_script_noteworthy(ent) {
  ent.script_noteworthy = "cleanup_construction";
  wait 17;
  screen_fade_out(0);
}

salazar_unholster_sidearm(ent) {
  level.ai_salazar gun_switchto("fiveseven_silencer_sp", "right");
}

ally_dropdown_think(nd_dest) {
  self change_movemode("cqb_run");
  self force_goal(nd_dest, 8, 0);
}

dropdown_objectives() {
  waittill_ai_group_ai_count("dropdown_patrol", 0);
  flag_wait("salazar_go_inside_spiderbot_started");
  set_objective(level.obj_find_crc, getstruct("s_setup_spiderbot", "targetname"));
  flag_wait("setup_spiderbot");
  set_objective(level.obj_find_crc, undefined, "delete");
  flag_set("dropdown_end");
}

pry_open_doors(ai_callback) {
  thread run_scene_and_delete("tower_elevator_open");
  e_fake_elevator = getent("construction_elevator", "targetname");
  e_fake_elevator thread elevator_move_doors(1, 1.0, 0.5, 0.0, 1);
  level clientnotify("audio_line_on");
  level notify("occlude_off");
}

ambush_guy_think() {
  self disable_react();
  self force_goal(getnode(self.target, "targetname"), 8, 0);
}

ambush_guy_head_init() {
  ai_guy = simple_spawn_single("dropdown_patrol1");

  if(ai_guy.headmodel != "c_mul_pmc_undercover_head1_a") {
    ai_guy detach(ai_guy.headmodel, "");
    ai_guy.headmodel = "c_mul_pmc_undercover_head1_a";
    ai_guy attach(ai_guy.headmodel, "", 1);
  }

  ai_guy = simple_spawn_single("dropdown_patrol2");

  if(ai_guy.headmodel != "c_mul_pmc_undercover_head2_ol") {
    ai_guy detach(ai_guy.headmodel, "");
    ai_guy.headmodel = "c_mul_pmc_undercover_head2_ol";
    ai_guy attach(ai_guy.headmodel, "", 1);
  }
}

#using_animtree("generic_human");

salazar_vent_wait() {
  s_align = getstruct("align_spiderbot_gear", "targetname");
  self set_goalradius(8);
  self setgoalpos(getstartorigin(s_align.origin, s_align.angles, % ch_karma_4_1_hotel_room_enter_harper), getstartangles(s_align.origin, s_align.angles, % ch_karma_4_1_hotel_room_enter_harper));
  self waittill("goal");
  flag_wait("salazar_goto_vent");
  level.ai_salazar set_blend_in_out_times(0.2);
  run_scene_and_delete("salazar_go_inside_spiderbot");

  if(!flag("set_spiderbot_player_started"))
    run_scene_and_delete("salazar_wait_vent_spiderbot");

  level.ai_salazar set_blend_in_out_times(0);
  level.ai_salazar thread run_scene_and_delete("salazar_wait");
  flag_wait("near_bombs");
  end_scene("salazar_wait");
  delete_hero(level.ai_salazar);
}

salazar_shoot(ent) {
  while(isalive(level.dropdown_guy)) {
    magicbullet("fiveseven_sp", level.ai_salazar gettagorigin("tag_flash"), level.dropdown_guy gettagorigin("j_head"));
    wait 0.25;
  }

  level.dropdown_guy = undefined;
  getent("clip_tower_lift_top", "targetname") notsolid();
}

we_have_id(ent) {
  level.player say_dialog("sala_we_have_union_id_0");
}

farid_comm() {
  level.player say_dialog("fari_section_i_m_in_0", 1.0);
  level.player say_dialog("sect_go_ahead_1", 0.5);
  level.player say_dialog("fari_al_jinan_recently_em_0", 0.5);
  level.player say_dialog("sect_no_shit_we_just_r_0", 0.5);
}