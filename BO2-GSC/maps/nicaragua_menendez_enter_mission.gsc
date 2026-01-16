/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\nicaragua_menendez_enter_mission.gsc
*****************************************************/

#include common_scripts\utility;
#include maps\_utility;
#include maps\_dialog;
#include maps\_scene;
#include maps\_objectives;
#include maps\nicaragua_util;
#include maps\_anim;
#include maps\_turret;
#include maps\nicaragua_menendez_rage;
#include maps\_fxanim;
#include maps\_rusher;

skipto_menendez_enter_mission() {
  skipto_teleport_players("player_skipto_menendez_enter_mission");
  exploder(20);
  exploder(101);
  battlechatter_on("axis");
  level.a_e_cleanup["menendez_to_mission"] = [];
  add_spawn_function_veh("cartel_courtyard_truck", ::courtyard_truck_spawn_func);
  sp_truck_gunner = get_ent("cartel_courtyard_truck_gunner", "targetname", 1);
  sp_truck_gunner add_spawn_function(::func_spawn_truck_gunner);
  sp_truck_driver = get_ent("cartel_courtyard_truck_driver", "targetname", 1);
  sp_truck_driver add_spawn_function(::func_spawn_truck_driver);
  e_trigger = getent("objective_to_mission_part2_trigger", "targetname");
  str_struct_name = e_trigger.target;
  s_struct = getstruct(str_struct_name, "targetname");
  set_objective(level.obj_menendez_save_josefina, s_struct, "");
  level.player setclientdvar("cg_aggressiveCullRadius", 495);
  model_removal_through_model_convert_system("menendez_lower_village");
  model_restore_area("menendez_execution");
  model_restore_area("menendez_stables_and_upper_village");
  model_convert("destructible_cocaine_bundles", "script_noteworthy");
  maps\_fxanim::fxanim_reconstruct("fxanim_gate_crash");
  destructibles_in_area("menendez_execution");
  destructibles_in_area("menendez_stables_and_upper_village");
}

main() {
  debug_print_line("Nicaragua Enter Mission");
  init_flags();
  init_spawn_functions();
  event_global_setup();
  level thread nicaragua_enter_mission_objectives();
  level.player.b_in_courtyard = 1;
  add_spawn_function_group("actor_Enemy_PDF_Nicaragua_Assault_Base", "classname", ::check_for_blood_splat);
  add_spawn_function_group("actor_Enemy_PDF_Nicaragua_Launcher_Base", "classname", ::check_for_blood_splat);
  add_spawn_function_group("actor_Enemy_PDF_Nicaragua_LMG_Base", "classname", ::check_for_blood_splat);
  add_spawn_function_group("actor_Enemy_PDF_Nicaragua_Shotgun_Base", "classname", ::check_for_blood_splat);
  add_spawn_function_group("actor_Enemy_PDF_Nicaragua_SMG_Base", "classname", ::check_for_blood_splat);
  add_spawn_function_group("actor_Enemy_PDF_Nicaragua_Sniper_Base", "classname", ::check_for_blood_splat);
  rpc("clientscripts/nicaragua", "blood_splat_life_change", 128);
  level thread menendez_enter_mission_fail();
  flag_wait("truck_in_town");
  flag_wait("truck_drives_through_gate");
  cleanup_ents("menendez_to_mission");
  spawn_manager_enable("sm_mem_truck_target_left");
  vh_truck = getent("cartel_courtyard_truck", "targetname");
  vh_truck thread truck_speed_logic();
  vh_truck truck_bashes_gate();
  level thread nicaragua_enter_mission_vo();
  level thread mem_courtyard_enemies();
  trigger_wait("menendez_reaches_mission_trigger");
  event_cleanup();
}

menendez_enter_mission_fail() {
  level thread mem_truck_road_warning();
  trigger_wait("trig_menendez_truck_road_fail");
  screen_message_delete();
  missionfailedwrapper_nodeath(&"NICARAGUA_MENENDEZ_TRUCK_ROAD_FAIL");
}

mem_truck_road_warning() {
  trigger_wait("trig_menendez_truck_road_warning");
  screen_message_create(&"NICARAGUA_MENENDEZ_TRUCK_ROAD_WARNING");
  wait 3;
  screen_message_delete();
}

truck_speed_logic() {
  self thread waittill_player_near_courtyard();
  self waittill("wait_in_courtyard");
  self setspeed(0);
  self setbrake(1);

  while(!(isDefined(self.b_player_near_courtyard) && self.b_player_near_courtyard))
    wait 0.05;

  self setbrake(0);
  self resumespeed(1);
}

waittill_player_near_courtyard() {
  trigger_wait("trig_truck_courtyard_move");
  self.b_player_near_courtyard = 1;
}

check_for_blood_splat() {
  ent_flag_init("rage_extra_gore");
}

event_cleanup() {
  kill_spawnernum(5);
}

init_flags() {
  flag_init("courtyard_gate_breached");
  flag_init("player_enters_inner_courtyard");
  flag_init("nicaragua_enter_mission_complete");
}

init_spawn_functions() {
  add_spawn_function_group("mem_courtyard_0", "targetname", ::force_goal, undefined, 16);
  add_spawn_function_group("mem_courtyard_1", "targetname", ::force_goal, undefined, 16);
  add_spawn_function_group("mem_courtyard_left_0", "targetname", ::force_goal, undefined, 16);
  add_spawn_function_group("mem_courtyard_left_1", "targetname", ::force_goal, undefined, 16);
  add_spawn_function_group("mem_truck_target_left", "targetname", ::force_goal, undefined, 16);
  add_spawn_function_group("mem_truck_target_left", "targetname", ::mem_truck_target_logic);
  add_spawn_function_group("mem_truck_target_center", "targetname", ::force_goal, undefined, 16);
  add_spawn_function_group("mem_truck_target_center", "targetname", ::mem_truck_target_logic);
  add_spawn_function_group("mem_courtyard_right_0", "targetname", ::force_goal, undefined, 16);
  add_spawn_function_group("mem_courtyard_center_0", "targetname", ::force_goal, undefined, 16);
}

mem_truck_target_logic() {
  wait 0.05;
  self waittill("goal");
  vh_truck = getent("cartel_courtyard_truck", "targetname");
  vh_truck add_turret_priority_target(self, 1);
}

mem_courtyard_enemies() {
  simple_spawn("mem_courtyard_0");
  simple_spawn_single("mem_courtyard_1");
  level thread meme_courtyard_spawn_truck_target_center_early();
  level thread mem_courtyard_kill_optional_spawns();
}

meme_courtyard_spawn_truck_target_center_early() {
  trigger_wait("sm_mem_courtyard_left_0");
  spawn_manager_enable("sm_truck_target_center");
}

mem_courtyard_kill_optional_spawns() {
  trigger_wait("sm_mem_courtyard_center_0");
  t_spawn_manager = getent("sm_mem_courtyard_right_0", "targetname");

  if(isDefined(t_spawn_manager))
    t_spawn_manager delete();

  t_spawn_manager = getent("sm_mem_courtyard_left_1", "targetname");

  if(isDefined(t_spawn_manager))
    t_spawn_manager delete();
}

event_global_setup() {
  add_trigger_function("menendez_reaches_mission_trigger", ::flag_set, "nicaragua_enter_mission_complete");
}

nicaragua_enter_mission_objectives() {
  e_trigger = getent("objective_to_mission_part2_trigger", "targetname");
  e_trigger waittill("trigger");
  set_objective(level.obj_menendez_save_josefina, undefined, "remove");
  autosave_by_name("to_misssion_part2");
  level clientnotify("chc_bls");
  e_trigger = getent("menendez_reaches_mission_trigger", "targetname");
  str_struct_name = e_trigger.target;
  s_struct = getstruct(str_struct_name, "targetname");
  set_objective(level.obj_menendez_save_josefina, s_struct, "");
  e_trigger waittill("trigger");
  set_objective(level.obj_menendez_save_josefina, undefined, "remove");
  autosave_by_name("to_misssion_part3");
  flag_set("nicaragua_enter_mission_complete");
}

nicaragua_enter_mission_vo() {
  level thread courtyard_friendly_vo();
  level thread menendez_near_mission_vo();
}

courtyard_friendly_vo() {
  n_array_counter = 0;
  a_courtyard_cartel_vo = array("crt0_come_on_take_the_0", "crt1_kill_them_all_0", "crt2_protect_menendez_0");

  while(!flag("nicaragua_enter_mission_complete")) {
    ai_cartel = get_closest_living(level.player.origin, getaiarray("allies"));

    if(isalive(ai_cartel)) {
      ai_cartel say_dialog(a_courtyard_cartel_vo[n_array_counter]);
      n_array_counter++;

      if(n_array_counter == a_courtyard_cartel_vo.size) {
        a_courtyard_cartel_vo = random_shuffle(a_courtyard_cartel_vo);
        n_array_counter = 0;
      }

      wait 55;
    }

    wait 0.05;
  }
}

menendez_near_mission_vo() {
  level endon("shattered_1_started");
  level.player stop_rage_vo();
  wait 0.05;
  rage_mode_important_vo("jose_where_are_you_0");
  wait 0.5;
  rage_mode_important_vo("mene_josefina_hold_on_i_0");
  wait 0.5;
  rage_mode_important_vo("jose_noooo_0");
  wait 0.5;
  rage_mode_important_vo("mene_i_m_coming_0");
}

courtyard_pdf_wave_1_fallback() {
  a_guys = get_ai_group_ai("menendez_courtyard_wave_1");
  e_volume = get_ent("mission_fallback_volume", "targetname", 1);
  debug_print_line("wave 1 falling back. count = " + a_guys.size);

  if(a_guys.size > 2) {
    a_guys = sort_by_distance(a_guys, level.player.origin);
    n_half_count = int(a_guys.size * 0.5);

    for(i = 0; i < a_guys.size; i++) {
      if(isDefined(a_guys[i])) {
        if(i < n_half_count) {
          a_guys[i] thread _trigger_fallback(e_volume, 1, randomfloatrange(0.25, 1));
          continue;
        }

        a_guys[i] thread _trigger_fallback(e_volume, 0, randomfloatrange(6, 8));
      }
    }
  } else if(a_guys.size > 0) {
    for(i = 0; i < a_guys.size; i++)
      a_guys[i] thread _trigger_fallback(e_volume);
  }
}

_trigger_fallback(e_volume, b_sprint, n_delay) {
  if(!isDefined(b_sprint))
    b_sprint = 1;

  if(!isDefined(n_delay))
    n_delay = 0;

  self endon("death");

  if(n_delay > 0)
    wait(n_delay);

  self notify("goal");
  self cleargoalvolume();
  n_time_started = gettime();
  n_old_radius = self.goalradius;
  self set_goalradius(64);

  if(isDefined(self.rusher) && self.rusher)
    self maps\_rusher::rusher_go_back_to_normal(undefined, undefined, 1);

  waittillframeend;

  if(b_sprint) {
    self set_ignoreall(1);
    self change_movemode("sprint");
  }

  self waittill("goal");
  debug_print_line("guy took " + (gettime() - n_time_started) * 0.001 + " seconds to fall back");
  self set_goalradius(n_old_radius);

  if(b_sprint) {
    self set_ignoreall(0);
    self reset_movemode();
  }
}

courtyard_cartel_truck_gunner_dies() {
  ai_gunner = get_ent("cartel_courtyard_truck_gunner_ai", "targetname");

  if(isDefined(ai_gunner)) {
    debug_print_line("killing truck gunner");
    ai_gunner dodamage(ai_gunner.health, ai_gunner.origin);
  }
}

turret_waits_for_player_use() {
  b_player_using_turret = 0;

  while(!b_player_using_turret) {
    self waittill("enter_vehicle", e_user);

    if(isplayer(e_user))
      b_player_using_turret = 1;
  }
}

turret_waits_for_player_exit() {
  b_player_using_turret = 1;

  while(b_player_using_turret) {
    self waittill("exit_vehicle", e_user);

    if(isplayer(e_user))
      b_player_using_turret = 0;
  }
}

truck_arrives_outside_mission_courtyard() {
  self thread truck_turret_think();
  self waittill("wait_in_town");
  self setspeed(0);
  self setbrake(1);
}

truck_bashes_gate() {
  level.player thread say_dialog("mene_smash_the_gate_0");
  self setbrake(0);
  self resumespeed(1);
  self playsound("evt_gate_truck");
  self waittill("vehicle_hits_gate");
  level notify("fxanim_gate_crash_start");
  exploder(450);
  earthquake(0.45, 1.0, self.origin, 3000);
  bm_clip = get_ent("menendez_courtyard_gate_clip", "targetname", 1);
  bm_clip connectpaths();
  bm_clip playsound("evt_gate_hit");
  flag_set("courtyard_gate_breached");
  flag_clear("rage_weapon_fire_audio_on");
  level thread _truck_bashes_gate_aftermath(bm_clip);
}

_truck_bashes_gate_aftermath(m_gate_clip) {
  wait 0.15;
  m_gate_clip delete();
  rage_mode_important_vo("jose_raul_help_me_0");
  wait 2;
  rage_mode_important_vo("mene_josefina_hold_on_0");
  level thread rage_weapon_fire_vo_on();
}

truck_continue_rail_after_wave1_cleared() {
  waittill_spawn_manager_complete("courtyard_battle_start");

  if(!self.player_using_turret)
    level waittill("player_using_truck_turret");

  a_allies = getaiarray("allies");
  ai_driver = getclosest(self gettagorigin("tag_driver"), a_allies);
  ai_driver thread magic_bullet_shield();
  ai_driver thread _debug_driver_run(self);
}

_debug_driver_run(vh_truck) {
  self endon("death");
  self endon("goal");

  while(true)
    wait 0.05;
}

func_spawn_veh_truck_courtyard() {
  self makevehicleusable();
  self.takedamage = 0;
  self thread maps\_turret::enable_turret(1);
}

truck_turret_think() {
  level endon("menendez_section_done");
  self.player_using_turret = 0;

  while(true) {
    self turret_waits_for_player_use();
    self.player_using_turret = 1;
    flag_set("truck_drives_through_gate");
    level notify("player_using_truck_turret");
    self turret_waits_for_player_exit();
    level notify("player_exited_truck_turret");
    self.player_using_turret = 0;
  }
}