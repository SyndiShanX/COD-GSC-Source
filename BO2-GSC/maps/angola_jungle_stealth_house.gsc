/************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\angola_jungle_stealth_house.gsc
************************************************/

#include common_scripts\utility;
#include maps\_utility;
#include maps\_anim;
#include maps\_dialog;
#include maps\_objectives;
#include maps\_scene;
#include maps\_stealth_logic;
#include maps\angola_2_util;
#include maps\angola_jungle_stealth_carry;
#include maps\_music;
#include maps\angola_jungle_stealth;
#include maps\createart\angola_art;
#include maps\_patrol;
#include maps\_audio;

skipto_jungle_stealth_house() {
  skipto_teleport_players("player_skipto_jungle_stealth_house");
  load_gump("angola_2_gump_village");
  level.player thread stealth_ai();
  maps\angola_jungle_stealth::init_stealth_carry_flags();
  maps\angola_jungle_stealth::switch_off_angola_escape_triggers();
  level.player thread maps\createart\angola_art::jungle_stealth();
  level.ai_woods = init_hero("woods");
  level.ai_hudson = init_hero("hudson");
  level.ai_hudson.non_wet_model = level.ai_hudson.model;
  level.ai_hudson setmodel("c_usa_angola_hudson_wet_fb");
  level.ai_hudson detach("c_usa_angola_hudson_glasses");
  level.ai_hudson detach("c_usa_angola_hudson_hat");
  level.ai_hudson set_force_color("r");
  level.player thread take_and_giveback_weapons("give_back_weapons");
  level thread maps\angola_jungle_stealth_carry::mason_carry_woods("j_stealth_player_puts_down_woods");
  s_struct = getstruct("hudson_skipto_jungle_stealth_house", "targetname");
  level.ai_hudson forceteleport(s_struct.origin, s_struct.angles);
  level thread fail_player_for_moving_to_escape_early();
  level notify("fxanim_vines_start");
  jungle_stealth_skipto_clean_up();
  jungle_stealth_log_skipto_clean_up();
  jungle_stealth_ent_clean_up();
  level.angola2_skipto = 1;
  level thread exploder_after_wait(250);
  level thread maps\angola_jungle_stealth::handle_child_soldiers();
  flag_init("child_guards_alerted");
  flag_init("fail_after_log");
  flag_init("fail_before_log");
  flag_init("fail_beach");
  flag_init("player_failing_stealth");
  level thread end_dialogue_when_stealth_breaks();
  level thread enemy_detects_player_vo();
  battlechatter_off("axis");
  flag_set("fxanim_grass_spawn");
}

init_flags() {
  flag_init("js_moving_to_stealth_dense_foliage_area");
  flag_init("js_mason_in_position_in_dense_foliage_area");
  flag_init("js_hudson_in_position_in_dense_foliage_area");
  flag_init("js_moving_to_final_woods_drop_point");
  flag_init("js_mason_in_position_in_woods_drop_off_area");
  flag_init("js_hudson_in_position_in_woods_drop_off_area");
  flag_init("js_mason_ready_to_enter_village");
  flag_init("js_stealth_event_complete");
  flag_init("tall_grass_patroller_pass_1");
  flag_init("tall_grass_patroller_pass_2");
  flag_init("tall_grass_patroller_pass_3");
  flag_init("player_in_tall_grass");
  flag_init("player_out_of_tall_grass");
  flag_init("patrol_b_passed");
  flag_init("patrol_c_passed");
  flag_init("safe_to_go_to_hudson");
  flag_init("tall_grass_spot_nag");
  flag_init("tall_grass_moment_over");
}

main() {
  init_flags();
  stealth_settings();
  m_radio_tower = getent("radio_tower", "targetname");
  m_radio_tower ignorecheapentityflag(1);
  m_radio_tower setscale(1);
  level.ai_hudson set_ignoreall(1);
  level.ai_hudson set_ignoreme(1);
  level.ai_woods set_ignoreme(1);
  level thread jungle_stealth_house_spawn_func();
  level thread lock_breaker_perk();
  level thread angola_stealth_house_objectives();
  level thread setup_fxanim_grass_triggers();
  level thread hudson_moves_to_dense_foliage_cover3();
  level thread tall_grass_stealth();
  level thread hudson_drops_off_woods_and_hudson_at_village_enterance();
  level thread turn_off_jungle_escape_spawn_triggers();
  jungle_stealth_log_ent_clean_up();
  flag_wait("js_stealth_event_complete");
  level notify("end_house_fail");
}

jungle_stealth_house_spawn_func() {
  sp_patroller = getent("patroller_extra_0", "targetname");
  sp_patroller add_spawn_function(::patroller_logic, "patrol_extra_start_0");
  sp_patroller add_spawn_function(::delete_after_stealth);
  sp_patroller = getent("patroller_extra_1", "targetname");
  sp_patroller add_spawn_function(::patroller_logic, "patrol_extra_start_1");
  sp_patroller add_spawn_function(::delete_after_stealth);
  sp_patroller = getent("patroller_extra_2", "targetname");
  sp_patroller add_spawn_function(::patroller_logic, "patrol_extra_start_2");
  sp_patroller add_spawn_function(::delete_after_stealth);
  sp_patroller = getent("patroller_extra_3", "targetname");
  sp_patroller add_spawn_function(::patroller_logic, "patrol_extra_start_3");
  sp_patroller add_spawn_function(::delete_after_stealth);
  sp_patroller = getent("patroller_extra_4", "targetname");
  sp_patroller add_spawn_function(::patroller_logic, "patrol_extra_start_4", 0, 1);
  sp_patroller add_spawn_function(::delete_after_stealth);
  sp_patroller = getent("patroller_extra_5", "targetname");
  sp_patroller add_spawn_function(::patroller_logic, "patrol_extra_start_5");
  sp_patroller add_spawn_function(::delete_after_stealth);
  sp_patroller = getent("patroller_extra_6", "targetname");
  sp_patroller add_spawn_function(::patroller_logic, "patrol_extra_start_6", 0, 1);
  sp_patroller add_spawn_function(::delete_after_stealth);
  sp_patroller = getent("patroller_extra_7", "targetname");
  sp_patroller add_spawn_function(::patroller_logic, "patrol_extra_start_7", 1);
  sp_patroller add_spawn_function(::delete_after_stealth);
}

delete_after_stealth() {
  self endon("delete");
  self endon("death");
  level waittill("end_house_fail");

  if(isDefined(self))
    self delete();
}

tall_grass_stealth() {
  level thread fail_player_if_he_backtracks();
  level.player thread stealth_fail();
  level thread tall_grass_stealth_vo();
  level thread perimeter_patrols();
  level thread patrol_a_logic();
  level thread patrol_b_logic();
  level thread stop_tall_grass_stealth();
  level thread notify_at_certain_spot("trig_near_rock");
  level thread notify_after_patrol_b();
  level thread set_up_right_path_blockers();
  level thread tall_grass_enemy_clean_up();
}

fail_player_if_he_backtracks() {
  triggers = getentarray("trig_fail_backtrack_after_house", "targetname");

  foreach(trigger in triggers)
  trigger thread trig_fail_player_if_backtracks();
}

trig_fail_player_if_backtracks() {
  level.player endon("death");
  level endon("tall_grass_stealth_done");
  self trigger_wait();
  spawners = getentarray("fail_player_outside_house_spawners", "targetname");
  array_thread(spawners, ::add_spawn_function, ::chase_after_target, level.player);
  trigger = getent("sm_fail_not_in_house", "targetname");
  trigger activate_trigger();
  trigger = getent("sm_fail_valley", "targetname");
  trigger activate_trigger();
  flag_set("_stealth_spotted");
  level.player s3_player_fail("house_backtrack", 3);
}

tall_grass_enemy_clean_up() {
  level endon("tall_grass_stealth_done");

  while(true) {
    a_ai = getaiarray();

    if(a_ai.size > 12) {
      a_enemies = get_ai_group_ai("tall_grass_generic_patrollers");
      a_enemies = get_array_of_farthest(level.player.origin, a_enemies);
      n_enemies_to_delete = a_ai.size - 12;
      n_enemies_deleted = 0;

      foreach(ai_enemy in a_enemies) {
        if(!level.player is_player_looking_at(ai_enemy.origin, 0.05)) {
          ai_enemy maps\_patrol::release_claimed_node();
          ai_enemy delete();
          n_enemies_deleted++;

          if(n_enemies_deleted == n_enemies_to_delete) {
            break;
          }
        }
      }
    }

    wait 0.05;
  }
}

notify_after_patrol_b() {
  flag_wait("patrol_b_passed");
  level notify("at_certain_spot");
}

notify_at_certain_spot(str_trigger) {
  trigger_wait(str_trigger);
  exploder_after_wait(252);
  level notify("at_certain_spot");
}

stealth_fail() {
  level endon("end_house_fail");
  level endon("tall_grass_moment_over");
  flag_wait("_stealth_spotted");
  level.player s3_player_fail();
  stealth_detect_ranges_default();
}

stop_tall_grass_stealth() {
  trigger_wait("trig_stop_stealth");
  level notify("tall_grass_stealth_done");
  level thread clean_up_animated_grass();

  for(i = 0; i <= 6; i++) {
    a_enemies = getentarray("patroller_extra_" + i + "_ai", "targetname");

    foreach(ai_enemy in a_enemies)
    ai_enemy.ignoreall = 1;
  }

  for(i = 0; i <= 3; i++) {
    a_enemies = getentarray("perimeter_patroller_" + i + "_ai", "targetname");

    foreach(ai_enemy in a_enemies)
    ai_enemy delete();
  }

  end_scene("perimeter_patrol");
}

setup_fxanim_grass_triggers() {
  trigger_house = getent("trig_fxanim_grass_house", "targetname");
  trigger_house thread trigger_flag_set_touching();
  trigger_middle = getent("trig_fxanim_grass_middle", "targetname");
  trigger_middle thread trigger_flag_set_touching();
  trigger_end = getent("trig_fxanim_grass_end", "targetname");
  trigger_end thread trigger_flag_set_touching();
}

clean_up_animated_grass() {
  a_fxanim_grass = getentarray("fxanim_cattails", "targetname");

  foreach(grass in a_fxanim_grass) {
    grass notify("stop_grass_idle");
    grass anim_stopanimscripted();
    grass thread grass_delete_when_offscreen();
  }
}

grass_delete_when_offscreen() {
  level.player endon("death");
  angle = 45;
  cos_angle = cos(angle);
  forward = anglestoforward(level.player.angles);
  grass_to_player = vectornormalize(self.origin - level.player.origin);

  while(vectordot(forward, grass_to_player) >= cos_angle) {
    forward = anglestoforward(level.player.angles);
    grass_to_player = vectornormalize(self.origin - level.player.origin);
    wait 0.1;
  }

  self delete();
}

patrol_blocker_fail() {
  level endon("end_patrol_blocker_trigger_fail");
  trigger_wait("trig_patrol_blocker_attention");
  end_scene("patrol_blocker");
  flag_set("_stealth_spotted");
  self getperfectinfo(level.player);
  self shoot_and_kill(level.player);
}

perimeter_patrols() {
  trigger_off("trig_patroller_extra_0");
  trigger_off("trig_patroller_extra_1");
  trigger_off("trig_patroller_extra_2");
  trigger_off("trig_patroller_extra_3");
  level thread trigger_perimeter_patrol_watch("trig_perimeter_patrol_0", "spawn_patroller_extra_0");
  level thread trigger_perimeter_patrol_watch("trig_patroller_extra_0", "spawn_patroller_extra_0");
  level thread trigger_perimeter_patrol_watch("trig_patroller_extra_1", "spawn_patroller_extra_1");
  level thread trigger_perimeter_patrol_watch("trig_patroller_extra_2", "spawn_patroller_extra_2");
  level thread trigger_perimeter_patrol_watch("trig_patroller_extra_3", "spawn_patroller_extra_3");
  level thread trigger_perimeter_patrol_watch("trig_patroller_extra_6", "spawn_patroller_extra_6");
  level thread trigger_perimeter_patrol_watch("trig_patroller_extra_7", "spawn_patroller_extra_7");
  level thread perimeter_guard_logic("perimeter_patroller_2", "anim_perimeter_patrol_2", "trig_perimeter_patrol_2", 2);
  level thread perimeter_patroller_logic("trig_patroller_extra_0", "spawn_patroller_extra_0", "patroller_extra_0", 19);
  level thread perimeter_patroller_logic("trig_patroller_extra_1", "spawn_patroller_extra_1", "patroller_extra_1", 21);
  level thread perimeter_patroller_logic("trig_patroller_extra_2", "spawn_patroller_extra_2", "patroller_extra_2", 26);
  level thread perimeter_patroller_logic("trig_patroller_extra_3", "spawn_patroller_extra_3", "patroller_extra_3", 23);
  level thread perimeter_patroller_logic("trig_patroller_extra_6", "spawn_patroller_extra_6", "patroller_extra_6", 9);
  level thread perimeter_patroller_logic("trig_patroller_extra_7", "spawn_patroller_extra_7", "patroller_extra_7", 19);
}

trigger_perimeter_patrol_watch(str_trigger, str_notify) {
  level endon("tall_grass_stealth_done");
  t_perimeter_patrol = getent(str_trigger, "targetname");

  while(true) {
    t_perimeter_patrol waittill("trigger");
    level notify(str_notify);
    wait 0.05;
  }
}

perimeter_patroller_logic(str_trigger, str_waittill, str_spawner, n_wait) {
  level endon("tall_grass_stealth_done");
  t_perimeter_patrol = getent(str_trigger, "targetname");

  while(true) {
    if(!isDefined(t_perimeter_patrol.is_pause)) {
      level waittill(str_waittill);
      e_patroller = simple_spawn_single(str_spawner);

      if(!isDefined(e_patroller)) {
        continue;
      }
      if(issubstr(e_patroller.classname, "child"))
        e_patroller thread delete_child_soldiers_when_player_drops_down();

      wait(n_wait);
    }

    wait 0.05;
  }
}

set_up_right_path_blockers() {
  spawners = getentarray("stealth_right_path_blockers", "targetname");
  array_thread(spawners, ::add_spawn_function, ::right_path_blocker_stealth_logic);
  array_thread(spawners, ::add_spawn_function, ::cleanup_path_blockers);
  simple_spawn(spawners);
}

right_path_blocker_stealth_logic() {
  level.player endon("death");
  self endon("death");

  if(isDefined(self.script_parameters)) {
    switch (self.script_parameters) {
      case "smoke":
        anime = "patrol_smoke_loop";
        break;
      case "idle":
        anime = "patrol_idle_loop";
        break;
      default:
        anime = "patrol_idle_loop";
        break;
    }

    self thread anim_generic_loop(self, anime, "stealth_broken");
    trigger_wait("trig_break_stealth_path_blockers");
    self notify("stealth_broken");
    self anim_stopanimscripted();

    if(!flag("tall_grass_moment_over"))
      flag_set("_stealth_spotted");
    else
      level.player s3_player_fail(undefined, 3);
  }
}

cleanup_path_blockers() {
  self endon("death");
  level.player endon("death");
  level endon("_stealth_spotted");
  level waittill("tall_grass_stealth_done");
  self notify("stealth_broken");
  self delete();
}

delete_child_soldiers_when_player_drops_down() {
  self endon("death");
  level.player endon("death");
  trigger_wait("trig_safe_to_delete_child_patrollers");
  self delete();
}

perimeter_guard_logic(str_spawner, str_align, str_trigger, delay) {
  level endon("tall_grass_stealth_done");

  if(isDefined(delay))
    wait(delay);

  ai_patroller = simple_spawn_single(str_spawner);
  ai_patroller thread stealth_ai();
  add_generic_ai_to_scene(ai_patroller, "perimeter_patrol");
  add_scene_properties("perimeter_patrol", str_align);
  level thread run_scene("perimeter_patrol");
  wait 0.15;
  trigger_wait(str_trigger);
  end_scene("perimeter_patrol");
  flag_set("_stealth_spotted");
  ai_patroller getperfectinfo(level.player);
  ai_patroller shoot_and_kill(level.player);
}

debug_stealth_loop() {
  while(true) {
    if(flag("_stealth_hidden"))
      iprintlnbold("hidden " + self getstance());

    if(flag("_stealth_alert"))
      iprintlnbold("alert " + self getstance());

    if(flag("_stealth_spotted"))
      iprintlnbold("spotted " + self getstance());

    wait 1;
  }
}

tall_grass_general_nag() {
  while(true) {
    if(flag("tall_grass_spot_nag")) {
      level.ai_hudson say_dialog("huds_stay_with_me_0");
      wait 9;
    }

    wait 0.05;
  }
}

tall_grass_stealth_vo() {
  trigger_wait("trig_sneak_hint");
  str_crouch_flag = "player_obeys_stealth_command";
  flag_clear(str_crouch_flag);
  wait 0.5;
  level thread maps\angola_jungle_stealth::stealth_log_monitor_player_crouch();

  if(!is_mason_stealth_crouched()) {
    if(!level.console && !level.player gamepadusedlast())
      level thread helper_message(&"ANGOLA_2_STEALTH_MASON_USE_GRASS_AS_COVER_PC", 3, str_crouch_flag);
    else
      level thread helper_message(&"ANGOLA_2_STEALTH_MASON_USE_GRASS_AS_COVER", 3, str_crouch_flag);
  }

  wait 3;
  level notify("stealth_log_stop_monitoring_crouch");
  flag_set("tall_grass_spot_nag");
  level waittill("at_certain_spot");
  flag_clear("tall_grass_spot_nag");
  t_near_rock = getent("trig_near_rock", "targetname");

  if(level.player istouching(t_near_rock) && !flag("patrol_b_passed")) {
    flag_wait("hudson_grass_loop_started");
    end_scene("hudson_grass_loop");
    run_scene_and_delete("hudson_grass_facial");
    level thread run_scene("hudson_grass_loop");
  }

  flag_wait("patrol_b_passed");
  flag_set("tall_grass_moment_over");
  after_grass_stealth_settings();
  level thread turn_on_mission_fail_volumes();
  flag_set("safe_to_go_to_hudson");
}

turn_on_mission_fail_volumes() {
  volumes = getentarray("vol_fail_post_grass_moment", "targetname");

  foreach(volume in volumes)
  volume thread monitor_player_failure_after_stealth();
}

monitor_player_failure_after_stealth() {
  level.player endon("death");
  level endon("tall_grass_stealth_done");

  while(!level.player istouching(self))
    wait 0.05;

  level.player s3_player_fail("post_grass", 3);
}

tall_grass_hold_nag() {
  while(!flag("safe_to_go_to_hudson")) {
    iprintlnbold("Hold it...");
    wait 9;
  }
}

patrol_a_logic() {
  level thread run_scene("patrol_a_guy_1_loop");
  guy = get_ais_from_scene("patrol_a_guy_1_loop", "patrol_a_1");
  guy thread delete_patrol_a_when_stealth_is_done();
  trigger_wait("trig_break_stealth_on_patrol_idle");
  end_scene("patrol_a_guy_1_loop");
  delete_scene("patrol_a_guy_1_loop");

  if(!flag("tall_grass_moment_over")) {
    guy notify("stealth_broken");
    guy anim_stopanimscripted();
    flag_set("_stealth_spotted");
    level.player s3_player_fail(undefined, 4);
  } else
    level.player s3_player_fail(undefined, 3);
}

delete_patrol_a_when_stealth_is_done() {
  self endon("death");
  level.player endon("death");
  level endon("_stealth_spotted");
  level waittill("tall_grass_stealth_done");
  self delete();
}

patroller_a_logic() {
  self endon("death");
  self.moveplaybackrate = 0.35;
  level waittill("_stealth_spotted");
  self.moveplaybackrate = 1;
}

patrol_b_logic() {
  level endon("_stealth_spotted");
  trigger_wait("trig_patrol_b");
  ai_patroller_b = simple_spawn_single("patrol_b_leader");
  ai_patroller_b.ignoreall = 1;
  ai_patroller_b thread patroller_logic("patroller_b_start");
  ai_patroller_b thread fxanim_grass_enemy_logic();
  trigger_on("trig_patroller_extra_0");
  trigger_on("trig_patroller_extra_1");
  trigger_on("trig_patroller_extra_2");
  trigger_on("trig_patroller_extra_3");
  wait 0.05;
  ai_patroller_b.ignoreall = 0;
  s_bird_fx_org = getstruct("birds_fx_patrol_b", "targetname");
  playfx(level._effect["startled_birds"], s_bird_fx_org.origin);
  nd_patrol_b_special = getnode("patrol_b_special_anim", "targetname");
  nd_patrol_b_special waittill_notify_or_timeout("trigger", 9);
  ai_patroller_b1 = simple_spawn_single("patrol_b_1");
  ai_patroller_b1 thread patroller_logic("patroller_b1_start");
  ai_patroller_b1 thread fxanim_grass_enemy_logic();
  ai_patroller_b2 = simple_spawn_single("patrol_b_2");
  ai_patroller_b2 thread patroller_logic("patroller_b2_start");
  ai_patroller_b2 thread fxanim_grass_enemy_logic();
  level notify("patrol_b_started");
  level thread tall_grass_patrol_vo(ai_patroller_b, ai_patroller_b1, ai_patroller_b2);
  wait 13;
  flag_set("patrol_b_passed");

  if(!flag("_stealth_spotted") && stealth_safe_to_save())
    autosave_by_name("patrol_b_passed");
}

check_safe_to_move(str_enemy, str_volume) {
  level.n_safe_zones++;
  clean_up_enemies_in_safe_zone(str_enemy, str_volume, 1);
  e_safe_zone = getent(str_volume, "targetname");
  is_safe = 0;

  while(!is_safe) {
    a_enemies = getentarray(str_enemy, "targetname");
    is_touching = 0;

    foreach(ai_enemy in a_enemies) {
      if(ai_enemy istouching(e_safe_zone))
        is_touching = 1;
    }

    if(!is_touching) {
      is_safe = 1;
      level.n_safe_zone_pass++;
    }

    wait 0.05;
  }

  if(level.n_safe_zone_pass == level.n_safe_zones) {
    level.foliage_cover.sight_dist["no_cover"] = 512;
    stealth_settings();
    flag_set("safe_to_go_to_hudson");
  }
}

clean_up_enemies_in_safe_zone(str_enemy, str_volume, use_cqb_walk) {
  a_enemies = getentarray(str_enemy, "targetname");

  if(a_enemies.size > 0) {
    ai_enemy_closest = a_enemies[0];
    n_dist_closest = distance2dsquared(a_enemies[0].origin, level.player.origin);
  }

  foreach(ai_enemy in a_enemies) {
    if(isDefined(use_cqb_walk) && use_cqb_walk)
      ai_enemy change_movemode("cqb_walk");

    n_dist = distance2dsquared(ai_enemy.origin, level.player.origin);

    if(n_dist < n_dist_closest) {
      ai_enemy_closest = ai_enemy;
      n_dist_closest = n_dist;
    }
  }

  if(a_enemies.size > 1) {
    a_possible_enemies_to_delete = [];

    foreach(ai_enemy in a_enemies) {
      if(ai_enemy != ai_enemy_closest)
        a_possible_enemies_to_delete[a_possible_enemies_to_delete.size] = ai_enemy;
    }

    foreach(ai_enemy in a_possible_enemies_to_delete) {
      if(!level.player is_player_looking_at(ai_enemy.origin)) {
        ai_enemy maps\_patrol::release_claimed_node();
        ai_enemy delete();
      }
    }
  }
}

angola_stealth_house_objectives() {
  wait 0.1;
  follow_obj_loc = spawn_model("tag_origin", level.ai_hudson.origin + vectorscale((0, 0, 1), 32.0));
  follow_obj_loc linkto(level.ai_hudson);
  set_objective(level.obj_tall_grass_stealth, follow_obj_loc, "FOLLOW");
  wait 0.5;
  objective_setflag(level.obj_tall_grass_stealth, "fadeoutonscreen", 0);
  s_rock = getstruct("obj_rock", "targetname");
  clientnotify("chsr");
  level.player playrumbleonentity("damage_light");
  flag_set("js_mason_in_position_in_dense_foliage_area");

  if(stealth_safe_to_save())
    autosave_by_name("mason_reaches_stealth_event3");

  level waittill("at_certain_spot");
  set_objective(level.obj_tall_grass_stealth, s_rock, "remove");
  flag_wait("patrol_b_passed");
  s_nook = getstruct("obj_nook", "targetname");
  set_objective(level.obj_tall_grass_stealth, level.ai_hudson, "follow");
  follow_obj_loc unlink();
  follow_obj_loc delete();
  wait 0.5;
  objective_setflag(level.obj_tall_grass_stealth, "fadeoutonscreen", 0);
  t_trigger = getent("objective_mason_goto_woods_drop_off_trigger", "targetname");
  t_trigger waittill("trigger");
  set_objective(level.obj_dont_get_discovered, undefined, "delete");
  flag_set("js_mason_in_position_in_woods_drop_off_area");

  if(stealth_safe_to_save())
    autosave_by_name("js_mason_in_position_in_woods_drop_off_area");

  flag_wait("js_mason_ready_to_enter_village");
  t_trigger = getent("objective_mason_goto_village_enterance_trigger", "targetname");
  str_struct_name = t_trigger.target;
  s_struct = getstruct(str_struct_name, "targetname");
  set_objective(level.obj_tall_grass_stealth, undefined, "delete");
  set_objective(level.obj_find_radio, s_struct, "");
  level.ai_hudson set_ignoreall(0);
  wait 0.1;
  flag_set("js_stealth_event_complete");
}

hudson_moves_to_dense_foliage_cover3() {
  after_house_stealth_settings();
  level thread run_scene("hudson_head_to_stealth");
  flag_set("js_moving_to_stealth_dense_foliage_area");
  level thread fail_player_if_not_exit_house(20);
  level thread exit_church_dialog(3.5);
  wait 0.1;
  scene_wait("hudson_head_to_stealth");
  level thread run_scene("hudson_grass_loop");
  flag_wait("patrol_b_passed");
  hudson_node = getnode("hudson_stealth_node", "targetname");
  level.ai_hudson setgoalnode(hudson_node);
  end_scene("hudson_grass_loop");
  run_scene("hudson_leave_stealth");
}

fail_player_if_not_exit_house(delay) {
  level.player endon("death");
  level endon("trig_player_out_of_house");

  if(isDefined(delay))
    wait(delay);

  flag_set("_stealth_spotted");
  level.player s3_player_fail("leave_house", 4);
}

exit_church_dialog(delay) {
  if(isDefined(delay) && delay > 0)
    wait(delay);
}

has_reach_the_end_of_tall_grass() {
  trigger_wait("stealth_grass_complete_trigger");
  flag_set("player_out_of_tall_grass");
}

tall_grass_nag() {
  while(!flag("player_out_of_tall_grass")) {
    wait 8;
    iprintlnbold("Hudson: Stay low and keep moving forward, Mason.");
  }
}

stealth_search_for_player(delay, str_spawnername, view_dot, vis_dist, a_nodes, fail_delay_time) {
  if(isDefined(delay) & delay > 0)
    wait(delay);

  e_spawner = getent(str_spawnername, "targetname");
  e_ai = simple_spawn_single(e_spawner);
  e_ai.ignoreall = 1;
  e_ai.script_ignore_suppression = 1;
  e_ai.dontmelee = 1;
  e_ai change_movemode("cqb_walk");
  e_ai.moveplaybackrate = 0.3;
  e_ai thread fail_mission_if_player_visible(view_dot, vis_dist, fail_delay_time);
  e_ai thread notify_if_patroller_has_pass_player();

  for(i = 0; i < a_nodes.size; i++) {
    n_node = getnode(a_nodes[i], "targetname");
    e_ai setgoalnode(n_node);
    e_ai.goalradius = 64;
    e_ai waittill("goal");
  }

  e_ai delete();
}

notify_if_patroller_has_pass_player() {
  while(self.origin[1] > level.player.origin[1])
    wait 0.05;

  level.n_patroller_pass++;
  flag_set("tall_grass_patroller_pass_" + level.n_patroller_pass);
}

fail_mission_if_player_visible(view_dot, vis_dist, fail_delay_time) {
  self endon("death");

  while(true) {
    dist = distance(self.origin, level.player.origin);
    v_forward = anglestoforward(self.angles);
    v_dir = vectornormalize(level.player.origin - self.origin);
    dot = vectordot(v_forward, v_dir);

    if(dist < vis_dist && dot > view_dot) {
      v_forward = anglestoforward(level.player.angles);
      v_dir = vectornormalize(self.origin - level.player.origin);
      dot = vectordot(v_forward, v_dir);

      if(dot > 0.2) {
        self.favoriteenemy = level.player;
        self thread aim_at_target(level.player);
        self thread shoot_at_target(level.player, undefined, 0.2, fail_delay_time + 1);
        wait(fail_delay_time);
        missionfailedwrapper(&"ANGOLA_2_PLAYER_COVER_BROKEN_SPOTTED");
      } else {
      }
    }

    wait 0.01;
  }
}

hudson_drops_off_woods_and_hudson_at_village_enterance() {
  trigger_wait("trig_disable_stealth_carry_crouch");
  level.woods_carry_disable_crouch = 1;
  level.__force_stand_up = 1;
  flag_wait("js_mason_in_position_in_woods_drop_off_area");
  hack_stealth_settings();
  wait 0.05;
  level notify("_stealth_stop_stealth_logic");
  wait 0.25;
  kill_player_carry();
  wait 0.05;
  flag_clear("_stealth_spotted");
  level.player startcameratween(0.5);
  level thread run_scene("j_stealth_player_puts_down_woods", 0.5);
  level.player say_dialog("maso_you_ll_be_okay_fran_0");
  scene_wait("j_stealth_player_puts_down_woods");
  level thread vo_hudson_woods_putdown();
  level thread run_scene("j_stealth_hudson_woods_sit_down_loop");
  level.player notify("give_back_weapons");
  level.player show_hud();
  wait 0.1;
  flag_set("js_mason_ready_to_enter_village");
  level thread maps\_audio::switch_music_wait("ANGOLA_VILLAGE_APPROACH", 2);
  level thread fxanim_beach_grass_logic();
}

vo_hudson_woods_putdown() {
  while(distance2dsquared(level.player.origin, getent("hudson_ai", "targetname").origin) < 14400)
    wait 0.1;

  level.ai_hudson thread say_dialog("huds_keep_low_or_they_ll_0");
}

turn_off_jungle_escape_spawn_triggers() {
  triggers = getentarray("player_escaping_village_trigger", "targetname");

  foreach(trigger in triggers)
  trigger trigger_off();
}

tall_grass_patrol_vo(leader, guy_1, guy_2) {
  level endon("end_dialogue_broken_stealth");
  level endon("tall_grass_stealth_done");
  leader say_dialog("cub0_they_must_be_close_0");
  leader say_dialog("cub0_they_cold_not_have_g_0");
  guy_1 say_dialog("cub1_how_do_we_know_they_0");
  guy_2 say_dialog("cub3_we_need_to_find_them_0");
  wait 2;
  leader say_dialog("cub0_i_want_them_taken_al_0");
  wait 1;
  guy_1 say_dialog("cub2_you_may_as_well_come_0");
}