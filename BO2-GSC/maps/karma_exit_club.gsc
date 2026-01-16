/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\karma_exit_club.gsc
**************************************/

#include common_scripts\utility;
#include maps\_utility;
#include maps\karma_util;
#include maps\_scene;
#include maps\_objectives;
#include maps\_anim;
#include maps\_dialog;
#include maps\createart\karma_2_art;
#include maps\_vehicle;

init_flags() {
  flag_init("intro_explosion_dialog");
  flag_init("e7_armory_vo_triggered");
  flag_init("e7_armory_opened_vo_triggered");
  flag_init("exit_club_cleanup");
}

init_spawn_funcs() {
}

skipto_club_exit() {
  level.ai_harper = init_hero_startstruct("harper", "e7_harper_start");
  skipto_teleport("skipto_exit_club");
}

skipto_loading_movie_1() {
  karma2_hide_tower_and_shell();
}

loading_movie_1_main() {
  run_scene("loading_movie_cctv");
}

skipto_loading_movie_2() {
  karma2_hide_tower_and_shell();
}

loading_movie_2_main() {
  run_scene("loading_movie_cctv2");
}

init_loading_movie_cctv() {
  ai = getent("defalco_drone", "targetname");
  str_weapon_model = getweaponmodel("beretta93r_sp");
  ai attach(str_weapon_model, "tag_weapon_right");
  ai = getent("han_drone", "targetname");
  str_weapon_model = getweaponmodel("beretta93r_sp");
  ai attach(str_weapon_model, "tag_weapon_right");
  ai = getent("defalco_escort_left_drone", "targetname");
  str_weapon_model = getweaponmodel("sa58_sp");
  ai attach(str_weapon_model, "tag_weapon_right");
}

init_loading_movie_cctv2() {
  ai = getent("defalco_drone", "targetname");
  str_weapon_model = getweaponmodel("beretta93r_sp");
  ai attach(str_weapon_model, "tag_weapon_right");
  ai = getent("defalco_escort_left_drone", "targetname");
  str_weapon_model = getweaponmodel("sa58_sp");
  ai attach(str_weapon_model, "tag_weapon_right");
}

main() {
  iprintln("Exit Club");

  set_level_goal("ref_delete_club_exit");
  exploder(69);
  exploder(666);
  init_door_collision();
  init_han_head();
  spawn_funcs();
  level.ai_salazar = init_hero_startstruct("salazar", "e7_salazar_start");
  level.ai_harper set_force_color("g");
  level.ai_salazar set_force_color("g");
  level thread exit_club_dialog();
  flag_wait("karma_2_gump_mall");
  level notify("start_rescue_karma_timer");
  level.player thread maps\createart\karma_2_art::vision_set_change("sp_karma2_clubexit");
  level thread intro_explosion_aftermath();
  level thread e7_wave_spawning();
  level thread exit_club_deathposes();
  level thread exit_club_objectives();
  level thread intruder_perk();
  flag_wait("e7_pip_defalco_in_mall");
}

init_door_collision() {
  getent("armory_door_right_collision", "targetname") linkto(getent("armory_door_right", "targetname"), "tag_animate");
}

init_han_head() {
  ai_han = simple_spawn_single("han");

  if(ai_han.headmodel != "c_mul_jinan_guard_head1") {
    ai_han detach(ai_han.headmodel, "");
    ai_han.headmodel = "c_mul_jinan_guard_head1";
    ai_han attach(ai_han.headmodel, "", 1);
  }
}

exit_club_objectives() {
  t_trigger = getent("trigger_end_event7", "targetname");
  str_struct_name = t_trigger.target;
  s_struct = getstruct(str_struct_name, "targetname");
  scene_wait("intro_explosion_aftermath");
  set_objective(level.obj_stop_defalco, s_struct, "");
  t_trigger waittill("trigger");
  autosave_by_name("karma_exit_club");
}

exit_club_clean_up() {
  t_cleanup = getent("clean_up_exit_club", "targetname");

  while(true) {
    t_cleanup trigger_wait();

    if(level.ai_harper istouching(t_cleanup) && level.ai_salazar istouching(t_cleanup)) {
      break;
    }
  }

  t_cleanup delete();
  exploder(1);
  stop_exploder(69);
  stop_exploder(721);
  cleanup_kvp("han_ai", "targetname");
  cleanup_kvp("armory_door_right", "targetname");
  cleanup_kvp("intro_double_door_left", "targetname");
  flag_set("exit_club_cleanup");
}

intro_explosion_aftermath() {
  level endon("exit_club_cleanup");
  rpc("clientscripts/karma_2_amb", "sndPlayFakeCiv");
  level thread screen_fade_in(2);
  level thread run_scene("intro_explosion_aftermath");
  flag_wait("intro_explosion_aftermath_started");
  level.ai_harper = get_ais_from_scene("intro_explosion_aftermath", "harper");
  level.ai_salazar = get_ais_from_scene("intro_explosion_aftermath", "salazar");
  scene_wait("intro_explosion_aftermath");
  m_door = getent("security_door", "targetname");
  m_door_clip = getent(m_door.target, "targetname");
  m_door_clip linkto(m_door);
  m_door rotateyaw(88, 0.05);
  level thread aftermath_guard_walk_to_idle();
  getent("armory_door_right_collision", "targetname") connectpaths();
  flag_set("intro_explosion_dialog");
  level.ai_harper post_intro_position(0, "harper_exit_club_node");
  level.ai_salazar post_intro_position(0, "salazar_exit_club_node");
}

aftermath_guard_walk_to_idle() {
  level thread run_scene_and_delete("aftermath_guard_walktoradio");
  ai_han = get_ais_from_scene("aftermath_guard_walktoradio", "han_ai");
  ai_han endon("death");
  scene_wait("aftermath_guard_walktoradio");
  level thread run_scene_and_delete("aftermath_guard_idle");
}

post_intro_position(delay, node) {
  wait(delay);
  nd_target = getnode(node, "targetname");
  self.goalradius = 48;
  self setgoalnode(nd_target);
}

exit_club_deathposes() {
  level endon("exit_club_cleanup");
  run_scene_first_frame("deathpose1");
  run_scene_first_frame("deathpose2");
  run_scene_first_frame("deathpose3");
  run_scene_first_frame("deathpose4");
  run_scene_first_frame("deathpose5");
  run_scene_first_frame("deathpose6");
  run_scene_first_frame("deathpose7");
  run_scene_first_frame("deathpose8");
  run_scene_first_frame("deathpose9");
  run_scene_first_frame("deathpose10");
  run_scene_first_frame("deathpose11");
}

e7_wave_spawning() {
  level thread scene_e7_couple_run_to_titanic_area_anim();
  level thread scene_e7_couple_a_run_from_mall_to_titanic_anim();
  level thread scene_e7_couple_b_run_from_mall_to_titanic_anim();
  level thread doctor_and_nurse_anim();
  level thread wounded_group1_anim();
  level thread wounded_group2_anim();
  level thread couple_approach_window_anim();
  level thread single_civ_approach_window_anim();
  level thread titanic_event_animations();
  level thread titanic_event_shrimp();
  exploder(899);
  level thread e8_flanking_helicopters();
}

scene_e7_couple_run_to_titanic_area_anim() {
  run_scene_first_frame("scene_e7_couple_run_to_titanic_area");
  trigger_wait("intro_run_civs");
  run_scene_and_delete("scene_e7_couple_run_to_titanic_area");
  level thread run_scene_and_delete("scene_e7_couple_run_to_titanic_area_loop");
  level waittill("exit_club_cleanup");
  delete_scene("scene_e7_couple_run_to_titanic_area_loop");
}

scene_e7_couple_a_run_from_mall_to_titanic_anim(delay) {
  run_scene_first_frame("scene_e7_couple_a_run_from_mall_to_titanic");
  trigger_wait("intro_run_civs");
  run_scene_and_delete("scene_e7_couple_a_run_from_mall_to_titanic");
  level thread run_scene_and_delete("scene_e7_couple_a_run_from_mall_to_titanic_loop");
  level waittill("exit_club_cleanup");
  delete_scene("scene_e7_couple_a_run_from_mall_to_titanic_loop");
}

scene_e7_couple_b_run_from_mall_to_titanic_anim() {
  run_scene_first_frame("scene_e7_couple_b_run_from_mall_to_titanic");
  trigger_wait("intro_run_civs");
  run_scene_and_delete("scene_e7_couple_b_run_from_mall_to_titanic");
  level thread run_scene_and_delete("scene_e7_couple_b_run_from_mall_to_titanic_loop");
  level waittill("exit_club_cleanup");
  delete_scene("scene_e7_couple_b_run_from_mall_to_titanic_loop");
}

doctor_and_nurse_anim() {
  run_scene_first_frame("scene_e7_doctor_and_nurse_loop");
  trigger_wait("intro_run_civs");
  level thread run_scene_and_delete("scene_e7_doctor_and_nurse_loop");
  level waittill("exit_club_cleanup");
  end_scene("scene_e7_doctor_and_nurse_loop");
}

wounded_group1_anim() {
  level thread run_scene_and_delete("scene_e7_wounded_group1");
  level waittill("exit_club_cleanup");
  end_scene("scene_e7_wounded_group1");
}

wounded_group2_anim() {
  level thread run_scene_and_delete("scene_e7_wounded_group2");
  level waittill("exit_club_cleanup");
  end_scene("scene_e7_wounded_group2");
}

group4_civs_at_window_anim() {
  run_scene_first_frame("scene_e7_civs_at_window_loop");
  trigger_wait("intro_run_civs");
  level thread run_scene_and_delete("scene_e7_civs_at_window_loop");
  level waittill("exit_club_cleanup");
  wait 0.6;
  end_scene("scene_e7_civs_at_window_loop");
}

couple_approach_window_anim() {
  run_scene_first_frame("scene_e7_couple_approach_window_part1");
  trigger_wait("intro_run_civs");
  run_scene_and_delete("scene_e7_couple_approach_window_part1");
  level thread run_scene_and_delete("scene_e7_couple_approach_window_part2_loop");
  level waittill("exit_club_cleanup");
  delete_scene("scene_e7_couple_approach_window_part2_loop");
}

single_civ_approach_window_anim() {
  run_scene_first_frame("scene_e7_single_approach_window_part1");
  trigger_wait("intro_run_civs");
  run_scene_and_delete("scene_e7_single_approach_window_part1");
  level thread run_scene_and_delete("scene_e7_single_approach_window_part2_loop");
  level waittill("exit_club_cleanup");
  delete_scene("scene_e7_single_approach_window_part2_loop");
}

spawn_funcs() {
}

titanic_event_animations() {
  str_scene1_name = "scene_e7_titanic_moment_docka_loop";
  str_scene2_name = "scene_e7_titanic_moment_dockb_loop";
  trigger_wait("trigger_end_event7");
  level thread run_scene_and_delete(str_scene1_name);
  level thread run_scene_and_delete(str_scene2_name);
  trigger_wait("clean_up_exit_club1");
  end_scene(str_scene1_name);
  end_scene(str_scene2_name);
}

titanic_event_shrimp() {
  level endon("exit_club_cleanup");
  trigger_wait("exit_club_shrimp", "targetname");

  while(true) {
    exploder(721);
    wait 5;
  }
}

titanic_event_boat() {
  level endon("exit_club_cleanup");
  trigger_wait("exit_club_shrimp", "targetname");
  level thread setup_boat("karma_life_boat", "boat_goal");
  level thread setup_boat("karma_life_boat1", "boat_goal1");
}

setup_boat(m_boat, nd_goal) {
  m_boat = getent(m_boat, "targetname");
  nd_node = getstruct(nd_goal, "targetname");
  nd_node_org = nd_node.origin;
  m_boat moveto(nd_node_org, 7.5, 1.0, 0.05);
  m_boat play_fx("fx_kar_boat_wake1", undefined, undefined, undefined, 1, "tag_origin");
  m_boat waittill("movedone");
  m_boat delete();
}

boat_test() {
  level endon("exit_club_cleanup");
  trigger_wait("exit_club_shrimp", "targetname");

  while(true) {
    spawn_lift_boat("boat", randomintrange(6, 7));
    wait(randomintrange(2, 4));
  }
}

spawn_lift_boat(str_drone_pos, n_move_time) {
  level endon("exit_club_cleanup");
  a_drone_pos = getstructarray(str_drone_pos, "targetname");

  foreach(s_drone_pos in a_drone_pos) {
    m_drone = spawn("script_model", s_drone_pos.origin);
    m_drone.angles = vectorscale((0, -1, 0), 90.0);
    m_drone setmodel("p6_boat_small_closed");
    s_drone_target = getstruct(s_drone_pos.target, "targetname");
    playfxontag(level._effect["fx_kar_boat_wake1"], m_drone, "tag_origin");
    m_drone moveto(s_drone_target.origin, n_move_time);
    m_drone waittill("movedone");
    m_drone delete();
  }
}

exit_club_dialog() {
  dialog_start_convo("intro_explosion_dialog");
  level.player priority_dialog("fari_what_happened_0");
  level.ai_harper priority_dialog("harp_defalco_detonated_a_0");
  level.player priority_dialog("sect_patch_us_into_the_se_0");
  dialog_end_convo();
}

intruder_perk() {
  t_intruder_use = getent("t_intruder_use", "targetname");
  t_intruder_use trigger_off();
  run_scene_first_frame("intruder_knuckles");
  a_weapons = getentarray("intruder_weapons", "targetname");

  foreach(weapon in a_weapons)
  weapon makeunusable();

  if(level.player hasperk("specialty_intruder")) {
    s_intruder = getstruct("intruder_use_pos", "targetname");
    set_objective(level.obj_intruder, s_intruder.origin, "interact");
    t_intruder_use trigger_on();
    t_intruder_use sethintstring(&"SCRIPT_HINT_INTRUDER");
    t_intruder_use trigger_wait();
    intruder_blocker_clip = getent("intruder_blocker_clip", "targetname");
    intruder_blocker_clip delete();

    foreach(weapon in a_weapons)
    weapon makeusable();

    set_objective(level.obj_intruder, s_intruder, "remove");
    delay_thread(7.0, ::intruder_glow_hide);
    run_scene("intruder");
    level.player giveweapon("tazer_knuckles_sp");
  }

  level waittill("exit_club_cleanup");
  delete_scene_all("intruder", 1);
}

intruder_glow_hide() {
  e_armory_doors = getent("intruder_armory_door", "targetname");
  e_armory_doors hidepart("tag_glow_left");
  e_armory_doors hidepart("tag_glow_right");
}

intruder_zap_start(m_cutter) {
  m_cutter play_fx("cutter_spark", undefined, undefined, "stop_fx", 1, "tag_fx");
  m_door = getent("intruder_armory_door", "targetname");
  m_door play_fx("intruder_door_smoke_left", undefined, undefined, -1, 1, "tag_fx1");
  m_door play_fx("intruder_door_smoke_right", undefined, undefined, -1, 1, "tag_fx");
}

intruder_zap_end(m_cutter) {
  m_cutter notify("stop_fx");
  m_door = getent("intruder_armory_door", "targetname");
  m_door clearclientflag(12);
}

intruder_cutter_on(m_cutter) {
  m_cutter play_fx("cutter_on", undefined, undefined, undefined, 1, "tag_fx");
}

e8_flanking_helicopters() {
  trigger_wait("e7_pip_defalco_in_mall", "targetname");
  level thread setup_heli("e7_little_bird_1", "e7_little_bird_1_start");
  level thread setup_heli("e7_little_bird_2", "e7_little_bird_2_start");
  level thread setup_heli("e7_little_bird_3", "e7_little_bird_3_start");
  level thread setup_heli("e7_little_bird_4", "e7_little_bird_4_start");
}

setup_heli(v_heli_name, str_node) {
  e_heli = maps\_vehicle::spawn_vehicle_from_targetname(v_heli_name);
  e_heli thread follow_path(str_node);
  e_heli playsound("evt_club_heli_flyby", "sound_done");
}

karma2_hide_tower_and_shell() {
  e_shell = getent("shell_hide", "targetname");
  e_shell.script_convert = 0;
  e_shell hide();
}

karma2_show_tower_and_shell() {
  e_shell = getent("shell_hide", "targetname");
  e_shell show();
}