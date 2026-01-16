/*****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\angola_jungle_escape.gsc
*****************************************/

#include common_scripts\utility;
#include maps\_utility;
#include maps\_dialog;
#include maps\_scene;
#include maps\_objectives;
#include maps\angola_2_util;
#include maps\_drones;
#include maps\_music;
#include maps\_turret;
#include maps\createart\angola_art;
#include maps\angola_jungle_stealth;
#include maps\_vehicle;
#include maps\_mortar;
#include maps\angola_stealth;
#include maps\angola_jungle_ending;

skipto_jungle_escape() {
  skipto_teleport_players("player_skipto_jungle_escape");
  load_gump("angola_2_gump_village");
  level.ai_woods = init_hero("woods");
  level.ai_hudson = init_hero("hudson");
  level.ai_hudson detach("c_usa_angola_hudson_glasses");
  level.ai_hudson detach("c_usa_angola_hudson_hat");
  flag_init("player_has_beartraps");
  m_radio_tower = getent("radio_tower", "targetname");
  m_radio_tower ignorecheapentityflag(1);
  m_radio_tower setscale(1);
  level.player thread maps\createart\angola_art::jungle_escape();
  level thread maps\angola_jungle_stealth::lock_breaker_perk();
  level notify("fxanim_vines_start");
  level thread fxanim_beach_grass_logic();
  level thread exploder_after_wait(250);
}

init_flags() {
  flag_init("je_mason_meets_woods_at_village_exit");
  flag_init("je_mason_drops_down_from_village");
  flag_init("je_hudson_heads_to_battle_1");
  flag_init("je_hudson_in_position_for_battle_1");
  flag_init("je_battle_1_wave3_started");
  flag_init("je_force_squad_to_move_to_battle_2");
  flag_init("je_hudson_in_position_for_battle_2");
  flag_init("je_battle_2_wave1_started");
  flag_init("je_battle_2_wave2_started");
  flag_init("je_force_squad_to_move_to_battle_3");
  flag_init("je_hudson_in_position_for_battle_3");
  flag_init("je_battle_3_wave2_started");
  flag_init("je_hudson_heads_to_beach");
  flag_init("je_woods_takes_damage");
  flag_init("jungle_escape_defend_complete");
  flag_init("player_off_sniper_tree");
  flag_init("kill_player_hut_enabled");
  flag_init("kill_player_wave1_enabled");
  flag_init("kill_player_wave2_enabled");
  flag_init("jungle_ending_do_not_save");
  flag_init("enemy_smoke_vo_1");
  flag_init("enemy_smoke_vo_2");
  flag_init("waterfall_mg_truck_destroyed");
  flag_init("enemy_vo_final_retreat");
}

angola_init_rusher_distances() {
  level.player_rusher_jumper_dist = 252;
  level.player_rusher_vclose_dist = 294;
  level.player_rusher_fight_dist = 504;
  level.player_rusher_medium_dist = 630;
  level.player_rusher_player_busy_dist = 924;
}

main() {
  level.jungle_escape_accuracy = 0.2;
  level.player.dogs_dont_instant_kill = 1;
  level.je_skip_battle1 = 0;
  level.je_skip_battle2 = 0;
  level.je_skip_battle3 = 0;
  level.disable_nags = 0;
  level.ai_hudson.overrideactordamage = ::hudson_damage_override;
  level.player.overrideplayerdamage = ::player_damage_override;
  jungle_escape_spawn_func();
  tree_sniper_initialization();
  level thread jungle_escape_enemy_vo();
  level thread jungle_escape_begins_vo(1);
  level thread jungle_escape_wave_2_vo();
  level thread jungle_escape_wave_3_vo();
  level.player swap_to_primary_weapon("m16_sp");
  battlechatter_on("axis");
  init_flags();
  level thread fail_player_for_going_back_to_village();
  level thread angola_jungle_objectives();
  level thread angola_jungle_wave_spawning();
  level thread angola_jungle_animations();
  setdvar("footstep_sounds_cutoff", 3000);
  level thread fail_player_for_leaving_hudson_and_woods_wave_1();
  level thread fail_player_for_leaving_hudson_and_woods_wave_2();
  flag_wait("jungle_escape_defend_complete");
}

fail_player_for_leaving_hudson_and_woods_wave_1() {
  level endon("je_hudson_heads_to_battle_2");
  trigger_wait("fail_player_for_abandon_1");
  missionfailedwrapper_nodeath(&"SCRIPT_COMPROMISE_FAIL");
}

fail_player_for_leaving_hudson_and_woods_wave_2() {
  level endon("je_hudson_heads_to_battle_3");
  trigger_wait("fail_player_for_abandon_2");
  missionfailedwrapper_nodeath(&"SCRIPT_COMPROMISE_FAIL");
}

jungle_escape_spawn_func() {
  a_escape_rpg_enemies = getentarray("escape_rpg_enemy", "script_noteworthy");
  array_thread(a_escape_rpg_enemies, ::add_spawn_function, ::escape_rpg_enemy_logic);
  add_spawn_function_veh("truck_0", ::truck_spawn_func);
  add_spawn_function_veh("truck_1", ::truck01_spawn_func);
}

escape_rpg_enemy_logic() {
  self.script_accuracy = 0.4;
}

truck_spawn_func() {
  self enable_turret(1);
  self set_turret_burst_parameters(1, 2, 1, 2, 1);
  self.overridevehicledamage = ::truck_damage_override;
  self.health = 500;
  self maps\_vehicle::lights_off();
  ai_gunner = getent("truck_0_gunner_ai", "targetname");
  ai_gunner thread truck_0_gunner_logic();
  self playsound("evt_turret_truck_arrive");
  self thread truck_mortar_death();
  self thread delete_truck_riders_when_end_scene_starts();
}

truck01_spawn_func() {
  self enable_turret(1);
  self set_turret_burst_parameters(1, 2, 1, 2, 1);
  self.health = 500;
  self maps\_vehicle::lights_off();
  self playsound("evt_turret_truck_arrive");
  self thread delete_truck_riders_when_end_scene_starts();
}

truck_0_gunner_logic() {
  level endon("play_truck_death");
  self waittill("death");
  self startragdoll(1);
  level notify("play_truck_death");
}

truck_mortar_death() {
  level waittill("play_truck_death");
  wait 0.5;
  flag_set("waterfall_mg_truck_destroyed");
  m_truck = spawn("script_model", self.origin);
  m_truck.angles = self.angles;
  m_truck setmodel("veh_iw_pickup_technical");
  m_truck.animname = "truck_0_model";
  self.delete_on_death = 1;
  self notify("death");

  if(!isalive(self))
    self delete();

  m_truck maps\_mortar::activate_mortar(512, 400, 100, 0.15, 2, 850, 0, level._effect["mortar_fx"], 0);
  m_truck play_fx("housing_missile_explosion", m_truck.origin);
  m_truck play_fx("truck_explosion_waterfall", m_truck.origin, m_truck.angles, undefined, 1, "body_animate_jnt");
  level thread run_scene("fxanim_truck_explosion");
}

hudson_damage_override(e_inflictor, e_attacker, n_damage, n_dflags, str_means_of_death, str_weapon, v_point, v_dir, str_hit_loc, psoffsettime, b_damage_from_underneath, n_model_index, str_part_name) {
  return false;
}

player_damage_override(e_inflictor, e_attacker, n_damage, n_dflags, str_means_of_death, str_weapon, v_point, v_dir, str_hit_loc, psoffsettime, b_damage_from_underneath, n_model_index, str_part_name) {
  n_damage = n_damage * 0.7;
  n_damage = abs(int(n_damage));

  if(n_damage <= 1)
    n_damage = 1;

  if(isDefined(e_attacker) && isDefined(e_attacker.team) && e_attacker.team == "axis") {
    if((str_means_of_death == "MOD_GRENADE" || str_means_of_death == "MOD_GRENADE_SPLASH") && isDefined(level.player.just_used_dtp) && level.player.just_used_dtp) {
      if(level.player hasperk("specialty_flakjacket"))
        n_damage = 10;
    }
  }

  return n_damage;
}

truck_damage_override(e_inflictor, e_attacker, n_damage, n_dflags, str_means_of_death, str_weapon, v_point, v_dir, str_hit_loc, psoffsettime, b_damage_from_underneath, n_model_index, str_part_name) {
  if(self.health - n_damage < 100) {
    level notify("play_truck_death");
    n_damage = 0;
  }

  return n_damage;
}

jungle_escape_begins_vo(delay) {
  level.player endon("death");

  if(isDefined(delay) && delay > 0)
    wait(delay);

  level.player say_dialog("maso_hudson_we_re_movin_0");
  wait 0.5;
  level.ai_hudson say_dialog("huds_did_you_secure_evac_0");
  level.player say_dialog("maso_negative_we_re_on_0");
  level.player say_dialog("maso_head_for_the_river_0");
  wait 2;
  level.ai_hudson say_dialog("huds_we_got_cuban_regular_0");
  level.ai_hudson say_dialog("huds_looks_like_half_a_da_0");
  level.player say_dialog("maso_can_it_hudson_0");
  wait 2;
  level.ai_hudson say_dialog("huds_woods_is_under_fire_0");
  level.player say_dialog("maso_we_gotta_protect_woo_0z");
  flag_wait("je_hudson_in_position_for_battle_1");
  wait 2;

  if(!flag("player_on_sniper_tree")) {
    level.ai_hudson say_dialog("huds_use_the_poachers_pl_0");
    level.ai_hudson say_dialog("huds_get_up_high_and_prov_0");
  }
}

friendly_vo_retreat_1() {
  level.player endon("death");
  level endon("je_hudson_heads_to_battle_3");
  level.player say_dialog("maso_grab_woods_0");
  flag_wait("hudson_and_woods_jungle_escape_move_defend_2_started");
  wait 2;
  level.ai_hudson say_dialog("huds_i_got_him_let_s_go_0");
  wait 6;
  level.ai_hudson say_dialog("huds_they_re_right_on_us_0");
  wait 3;
  level.ai_hudson say_dialog("huds_too_many_of_them_w_0");
  level.player say_dialog("maso_get_woods_in_cover_0");
  wait 3;

  if(flag("player_has_beartraps"))
    level.ai_hudson say_dialog("huds_rig_some_booby_traps_1");

  flag_wait("je_battle_2_wave2_started");
  level.player say_dialog("maso_they_re_still_coming_0");
  wait 5;
  level.player say_dialog("maso_now_hudson_0");
}

jungle_escape_wave_2_vo(delay) {
  trigger_wait("defend2_chaser_spawners_trigger");

  if(isDefined(delay) && delay > 0)
    wait(delay);

  level notify("stop_hudson_nag");
}

friendly_vo_retreat_2() {
  level.player endon("death");
  wait 2;
  level.player say_dialog("maso_we_gotta_move_1");
  flag_wait("hudson_and_woods_jungle_escape_move_defend_3_started");
  wait 1;
  level.ai_hudson say_dialog("huds_come_on_woods_we_0");
  wait 1;
  level.ai_hudson say_dialog("huds_i_got_you_brother_0");
  wait 5;
  level.player say_dialog("maso_keep_moving_1");
}

jungle_escape_wave_3_vo(delay) {
  level.player endon("death");
  trigger_wait("defend3_player_arrives_trigger");

  if(isDefined(delay) && delay > 0)
    wait(delay);

  level notify("stop_hudson_nag");
  level.ai_hudson say_dialog("huds_dammit_0");
  wait 2;
  level.ai_hudson say_dialog("huds_mg_truck_on_the_wa_0");
  wait 0.5;
  level.player say_dialog("maso_i_ll_deal_with_it_1");
  wait 15;
  level.ai_hudson say_dialog("huds_there_s_too_many_of_0");
  flag_wait("jungle_escape_defend_complete");
  flag_wait("evac_to_beach_hudson_started");
  level.player say_dialog("maso_grab_woods_0");
  wait 5;
  level.ai_hudson say_dialog("huds_there_s_a_boat_on_th_0");
}

activate_the_wrong_exit_from_village_trigger() {
  a_volumes = getentarray("exit_village_wrong_way_info_volume", "targetname");

  while(true) {
    for(i = 0; i < a_volumes.size; i++) {
      if(level.player istouching(a_volumes[i])) {
        missionfailedwrapper_nodeath(&"SCRIPT_COMPROMISE_FAIL");
        return;
      }
    }

    wait 0.05;
  }
}

fail_player_for_going_back_to_village() {
  level.player endon("death");
  level endon("je_end_scene_started");
  flag_wait("je_hudson_in_position_for_battle_1");
  trigger_wait("trig_fail_player_for_going_to_village");
  level.player kill();
}

angola_jungle_objectives() {
  wait 0.25;
  flag_set("je_mason_meets_woods_at_village_exit");
  set_objective(level.obj_protect_hudson_and_woods_on_way_to_beach, level.ai_hudson, "follow");

  while(true) {
    if(flag("je_hudson_heads_to_battle_1")) {
      break;
    }

    wait 0.01;
  }

  wait 1;

  while(true) {
    if(flag("je_hudson_in_position_for_battle_1")) {
      break;
    }

    wait 0.01;
  }

  set_objective(level.obj_protect_hudson_and_woods_on_way_to_beach, undefined, "deactivate");
  set_objective(level.obj_battle_forest_1, level.ai_woods.origin + vectorscale((0, 0, 1), 40.0), "defend");
  wait 0.5;
  objective_setflag(level.obj_battle_forest_1, "fadeoutonscreen", 0);
  wait_for_1st_battle_to_complete();
  set_objective(level.obj_battle_forest_1, undefined, "delete");
  flag_wait("je_hudson_heads_to_battle_2");
  flag_wait("hudson_and_woods_jungle_escape_move_defend_2_started");
  level thread hudson_nag_lines(6);
  wait 0.5;
  set_objective(level.obj_protect_hudson_and_woods_on_way_to_beach, undefined, "reactivate");
  set_objective(level.obj_protect_hudson_and_woods_on_way_to_beach, level.ai_hudson, "follow");

  if(jungle_escape_can_do_autosave())
    autosave_by_name("move_to_battle_2_start");

  flag_wait("je_hudson_in_position_for_battle_2");
  set_objective(level.obj_protect_hudson_and_woods_on_way_to_beach, undefined, "deactivate");
  set_objective(level.obj_battle_forest_2, level.ai_woods.origin + vectorscale((0, 0, 1), 40.0), "defend");
  wait 0.5;
  objective_setflag(level.obj_battle_forest_2, "fadeoutonscreen", 0);

  if(jungle_escape_can_do_autosave())
    autosave_by_name("je_battle_2_starting");

  wait_for_2nd_battle_to_complete();
  set_objective(level.obj_battle_forest_2, undefined, "delete");
  flag_wait("je_hudson_heads_to_battle_3");
  wait 0.5;
  set_objective(level.obj_protect_hudson_and_woods_on_way_to_beach, undefined, "reactivate");
  set_objective(level.obj_protect_hudson_and_woods_on_way_to_beach, level.ai_hudson, "follow");
  level thread hudson_nag_lines(11);

  if(jungle_escape_can_do_autosave(0))
    autosave_by_name("move_to_battle_3_start");

  wait 1;
  flag_wait("je_hudson_in_position_for_battle_3");
  set_objective(level.obj_protect_hudson_and_woods_on_way_to_beach, undefined, "deactivate");

  if(jungle_escape_can_do_autosave())
    autosave_by_name("je_battle_3_starting");

  set_objective(level.obj_battle_forest_3, level.ai_woods.origin + vectorscale((0, 0, 1), 40.0), "defend");
  wait 0.5;
  objective_setflag(level.obj_battle_forest_3, "fadeoutonscreen", 0);
  wait_for_3rd_battle_to_complete();
  set_objective(level.obj_battle_forest_3, undefined, "delete");
  wait 0.1;
  flag_set("jungle_escape_defend_complete");
}

wait_for_1st_battle_to_complete() {
  if(level.je_skip_battle1 == 0) {
    flag_wait("je_battle_1_wave3_started");

    if(level.disable_nags == 0)
      level thread je_1st_battle_advance_nag_lines();

    wait 1;

    while(true) {
      if(getaiarray("axis").size <= 2) {
        break;
      }

      if(flag("je_hudson_heads_to_battle_2")) {
        break;
      }

      if(flag("je_force_squad_to_move_to_battle_2")) {
        break;
      }

      wait 0.01;
    }
  }

  level.ai_hudson notify("hudson_move_with_woods");
  flag_set("je_hudson_heads_to_battle_2");
  level thread force_player_to_battle_2();
  make_all_enemy_aggressive(1);
}

wait_for_2nd_battle_to_complete() {
  if(level.je_skip_battle2 == 0) {
    flag_wait("je_battle_2_wave1_started");
    flag_wait("je_battle_2_wave2_started");
    wait 5;
    start_time = gettime();

    while(true) {
      time = gettime();
      dt = (time - start_time) / 1000;

      if(dt > 10) {
        break;
      }

      if(getaiarray("axis").size <= 4) {
        break;
      }

      wait 0.05;
    }

    if(level.disable_nags == 0) {
      lines = array("huds_we_gotta_keep_moving_0", "huds_we_have_to_move_now_0", "huds_we_can_t_stay_here_0", "huds_come_on_mason_mov_0", "huds_we_can_t_stay_here_1", "huds_they_re_closing_fast_0", "huds_keep_running_mason_0", "huds_he_s_a_sitting_duck_0", "huds_woods_is_under_fire_1");
      lines = array_randomize(lines);
      level thread mason_protect_nag_think(level.ai_hudson, 1000, 2, 8, 15, lines);
    }

    wait 3;
  }

  level.ai_hudson notify("hudson_move_with_woods");
  flag_set("je_hudson_heads_to_battle_3");
  make_all_enemy_aggressive(1);
}

wait_for_3rd_battle_to_complete() {
  if(level.je_skip_battle3 == 0) {
    flag_wait("je_battle_3_wave2_started");
    wait 21;
    start_time = gettime();

    while(true) {
      time = gettime();
      dt = (time - start_time) / 1000;

      if(dt > 10) {
        break;
      }

      if(getaiarray("axis").size <= 3) {
        break;
      }

      wait 0.01;
    }

    flag_set("je_hudson_heads_to_beach");
    level.ai_hudson notify("hudson_move_with_woods");
    wait 1;
  }

  level.ai_hudson notify("hudson_move_with_woods");
}

angola_jungle_wave_spawning() {
  triggers = getentarray("player_escaping_village_trigger", "targetname");

  foreach(trigger in triggers)
  trigger trigger_on();

  angola_init_rusher_distances();

  if(level.disable_nags == 0) {
    lines = array("huds_we_gotta_keep_moving_0", "huds_we_have_to_move_now_0", "huds_we_can_t_stay_here_0", "huds_come_on_mason_mov_0", "huds_we_can_t_stay_here_1", "huds_they_re_closing_fast_0", "huds_keep_running_mason_0", "huds_he_s_a_sitting_duck_0", "huds_woods_is_under_fire_1");
    lines = array_randomize(lines);
    level thread mason_protect_nag_think(level.ai_hudson, 1500, 4, 15, 25, lines);
  }

  str_category = "jungle_battle_1";

  if(level.je_skip_battle1 == 0) {
    level thread kill_player_hut_for_not_advancing();
    level thread je_battle1_jungle_chasers(str_category);
    level thread je_battle1_start_trigger(str_category);
    level thread kill_player_battle_1_for_not_advancing();
  }

  str_category = "jungle_battle_2";

  if(level.je_skip_battle2 == 0) {
    level thread je_battle2_chasers(str_category);
    level thread je_battle2_wave1_trigger(str_category);
    level thread je_battle2_wave2_trigger(str_category);
    level thread kill_player_battle_2_for_not_advancing();
  }

  str_category = "jungle_battle_3";

  if(level.je_skip_battle3 == 0) {
    level thread je_battle3_chasers(str_category);
    level thread je_battle3_wave1_trigger(str_category);
    level thread je_battle3_wave2_trigger(str_category);
    level thread je_battle3_wave3_trigger(str_category);
    level thread je_battle3_wave4_trigger(str_category);
    level thread je_battle3_mortar_attack();
  }
}

je_battle1_jungle_chasers(str_category) {
  trigger_wait_or_time("start_the_ai_chase", 15.0);
  a_spawners = getentarray("je_village_chasers_wave1_regular_spawner", "targetname");

  if(isDefined(a_spawners))
    simple_spawn_script_delay(a_spawners, ::spawn_fn_ai_run_to_target, 1, str_category, 1, 0, 0);

  level thread push_chasers_forward_as_defend1_develops();
  start_time = gettime();
  wave2_wait_time = 7;

  while(true) {
    time = gettime();
    dt = (time - start_time) / 1000;

    if(dt > wave2_wait_time) {
      a_spawners = getentarray("je_village_chasers_wave2_regular_spawner", "targetname");

      if(isDefined(a_spawners))
        simple_spawn_script_delay(a_spawners, ::spawn_fn_ai_run_to_target, 1, str_category, 1, 0, 0);

      return;
    }

    wait 0.01;
  }
}

push_chasers_forward_as_defend1_develops() {
  flag_wait("je_mason_drops_down_from_village");
  wait 12;
  e_volume = getent("village_exit_volume", "targetname");
  a_enemies = getaispeciesarray("axis", "all");
  a_ai_targets = [];

  for(i = 0; i < a_enemies.size; i++) {
    e_ai = a_enemies[i];

    if(e_ai istouching(e_volume))
      a_ai_targets[a_ai_targets.size] = e_ai;
  }

  for(i = 0; i < a_ai_targets.size; i++) {
    e_ai = a_ai_targets[i];
    e_ai.pathenemyfightdist = 892;
    e_ai setgoalentity(level.player);
  }
}

kill_player_hut_for_not_advancing(b_wait_time) {
  if(!isDefined(b_wait_time))
    b_wait_time = 1;

  flag_set("kill_player_hut_enabled");

  if(!isDefined(level.reenable_hut_running))
    level thread reenable_kill_player_hut();

  a_trigger_strings = [];
  a_trigger_strings[0] = "trigger_turn_off_hut_kill";

  foreach(trigger_string in a_trigger_strings) {
    level thread disable_flag_for_hut_when_trigger_hit(trigger_string);
    e_trigger = getent(trigger_string, "targetname");
    e_trigger endon("trigger");
  }

  if(b_wait_time) {
    level thread hut_kill_triggers_hit_first_time();
    wait 30;
    level notify("timer_reached");
  }

  level.player.overrideplayerdamage = ::hut_kill_player_override;

  foreach(trigger_string in a_trigger_strings)
  level thread disable_flag_for_hut_when_trigger_hit(trigger_string);

  ai_array = simple_spawn("je_village_hut_kill_player", ::kill_player_regular_logic, "je_village_hut_kill_player", a_trigger_strings);
}

hut_kill_player_override(e_inflictor, e_attacker, n_damage, n_flags, str_means_of_death, str_weapon, v_point, v_dir, str_hit_loc, n_model_index, psoffsettime) {
  return n_damage * 2;
}

hut_kill_triggers_hit_first_time() {
  level endon("timer_reached");
  level endon("kill_player_hut_enabled");
  trigger_wait("trigger_kill_player_with_hut");
  level notify("stop_disabling_the_hut_function");
  trigger = getent("trigger_turn_off_hut_kill", "targetname");
  trigger activate_trigger();
  wait 0.1;
  level thread kill_player_hut_for_not_advancing(0);
}

kill_player_battle_1_for_not_advancing(b_wait_time) {
  if(!isDefined(b_wait_time))
    b_wait_time = 1;

  flag_wait("je_hudson_heads_to_battle_2");
  flag_set("kill_player_wave1_enabled");

  if(!isDefined(level.reenable_battle_1_running))
    level thread reenable_kill_player_battle_1();

  a_trigger_strings = [];
  a_trigger_strings[0] = "defend2_chaser_spawners_trigger";

  foreach(trigger_string in a_trigger_strings) {
    level thread disable_flag_for_wave1_when_trigger_hit(trigger_string);
    e_trigger = getent(trigger_string, "targetname");
    e_trigger endon("trigger");
  }

  if(b_wait_time)
    wait 30;

  foreach(trigger_string in a_trigger_strings)
  level thread disable_flag_for_wave1_when_trigger_hit(trigger_string);

  ai = simple_spawn_single("je_battle1_kill_player_launcher", ::kill_player_rpg_logic, "je_battle1_kill_player_launcher", a_trigger_strings);
  ai_array = simple_spawn("je_village_chasers_wave2_regular_spawner", ::kill_player_regular_logic, "je_village_chasers_wave2_regular_spawner", a_trigger_strings);
}

force_player_to_battle_2() {
  a_spawners = getentarray("je_battle1_force_player_back_spawners", "targetname");
  array_thread(a_spawners, ::add_spawn_function, ::je_retreat_and_delete);
  trigger_use("trig_je_battle1_force_player_back", "script_noteworthy");
}

je_retreat_and_delete() {
  self endon("death");
  trigger_wait("defend2_chaser_spawners_trigger", "targetname");
  a_volumes = getentarray("vol_battle_1_retreat_and_delete", "targetname");
  wait(randomfloatrange(0.5, 3.0));
  self set_goal_pos(self.origin);
  self setgoalvolumeauto(a_volumes[randomint(a_volumes.size)]);
  self waittill("goal");

  while(level.player is_player_looking_at(self.origin + vectorscale((0, 0, 1), 48.0), 0.75, 1))
    wait(randomfloatrange(0.1, 2.5));

  self delete();
}

kill_player_battle_2_for_not_advancing(b_wait_time) {
  if(!isDefined(b_wait_time))
    b_wait_time = 1;

  flag_wait("je_hudson_heads_to_battle_3");
  flag_set("kill_player_wave2_enabled");

  if(!isDefined(level.reenable_battle_2_running))
    level thread reenable_kill_player_battle_2();

  a_trigger_strings = [];
  a_trigger_strings[0] = "trigger_kill_player_with_wave_1";
  a_trigger_strings[1] = "defend3_player_arrives_trigger";

  foreach(trigger_string in a_trigger_strings) {
    level thread disable_flag_for_wave2_when_trigger_hit(trigger_string);
    e_trigger = getent(trigger_string, "targetname");
    e_trigger endon("trigger");
  }

  if(b_wait_time)
    wait 30;

  ai = simple_spawn_single("je_battle2_kill_player_launcher", ::kill_player_rpg_logic, "je_battle2_kill_player_launcher", a_trigger_strings);
  ai_array = simple_spawn("je_defend3_chaser_spawner", ::kill_player_regular_logic, "je_defend3_chaser_spawner", a_trigger_strings);
}

reenable_kill_player_hut() {
  level.reenable_hut_running = 1;

  while(true) {
    trigger_wait("trigger_kill_player_with_hut");

    if(!flag("kill_player_hut_enabled"))
      level thread kill_player_hut_for_not_advancing(0);
  }
}

reenable_kill_player_battle_1() {
  level.reenable_battle_1_running = 1;

  while(true) {
    trigger_wait("trigger_kill_player_with_wave_1");

    if(!flag("kill_player_wave1_enabled"))
      level thread kill_player_battle_1_for_not_advancing(0);
  }
}

reenable_kill_player_battle_2() {
  level.reenable_battle_2_running = 1;

  while(true) {
    trigger_wait("trigger_kill_player_with_wave_2");

    if(!flag("kill_player_wave2_enabled"))
      level thread kill_player_battle_2_for_not_advancing(0);
  }
}

disable_flag_for_hut_when_trigger_hit(s_trigger) {
  level endon("stop_disabling_the_hut_function");
  level endon("kill_player_hut_enabled");
  trigger_wait(s_trigger);
  level.player.overrideplayerdamage = ::player_damage_override;
  flag_clear("kill_player_hut_enabled");
}

disable_flag_for_wave1_when_trigger_hit(s_trigger) {
  level endon("kill_player_wave1_enabled");
  trigger_wait(s_trigger);
  flag_clear("kill_player_wave1_enabled");
}

disable_flag_for_wave2_when_trigger_hit(s_trigger) {
  level endon("kill_player_wave2_enabled");
  trigger_wait(s_trigger);
  flag_clear("kill_player_wave2_enabled");
}

kill_player_rpg_logic(s_spawner, a_s_trigger) {
  foreach(trigger_string in a_s_trigger) {
    e_trigger = getent(trigger_string, "targetname");
    e_trigger endon("trigger");
    self thread kill_ai_if_not_in_view_and_player_hit_trigger(trigger_string);
  }

  self waittill("goal");
  self set_goalradius(2048);
  self thread shoot_and_kill(level.player);
  self waittill("death");
  ai = simple_spawn_single(s_spawner, ::kill_player_rpg_logic, s_spawner, a_s_trigger);
}

kill_player_regular_logic(s_spawner, a_s_trigger) {
  if(isDefined(a_s_trigger)) {
    foreach(trigger_string in a_s_trigger) {
      e_trigger = getent(trigger_string, "targetname");
      e_trigger endon("trigger");
      self thread kill_ai_if_not_in_view_and_player_hit_trigger(trigger_string);
    }
  }

  self waittill("goal");
  self set_goalradius(2048);
  self thread shoot_and_kill(level.player);
  self waittill("death");
  spawn_array = getentarray(s_spawner, "targetname");
  ai = spawn_array[0] spawn_ai(1);
  ai thread kill_player_regular_logic(s_spawner, a_s_trigger);
}

kill_ai_if_not_in_view_and_player_hit_trigger(trigger) {
  self endon("delete");
  self endon("death");

  while(true) {
    trigger_wait(trigger);

    if(!level.player is_player_looking_at(self.origin, 0.6, 0))
      self bloody_death();
  }
}

je_battle1_start_trigger(str_category) {
  str_notify = "je_battle1_start_notify";
  multiple_trigger_waits("player_escaping_village_trigger", str_notify);
  level waittill(str_notify);
  flag_set("je_mason_drops_down_from_village");

  if(jungle_escape_can_do_autosave())
    autosave_by_name("player_enters_1st_defend_area");

  wait 4;
  a_spawners = getentarray("je_battle1_start_regular_spawner", "targetname");

  if(isDefined(a_spawners))
    simple_spawn_script_delay(a_spawners, ::spawn_fn_ai_run_to_target, 1, str_category, 0, 0, 0);

  wait 3;
  level thread simple_spawn_rusher_single("je_battle1_wave1_rusher_spawner", str_category, level.player_rusher_medium_dist);
  level thread je_battle1_wave2_trigger(str_category);
}

je_battle1_wave2_trigger(str_category) {
  min_wait_time = 6;
  max_wait_time = 15;
  min_axis_left = 3;
  battle1_start_time = gettime();
  wait(min_wait_time);

  while(true) {
    time = gettime();
    dt = (time - battle1_start_time) / 1000;

    if(dt >= max_wait_time) {
      break;
    }

    num_axis = getaiarray("axis").size;

    if(num_axis <= min_axis_left) {
      break;
    }

    wait 0.01;
  }

  level thread je_battle1_wave3_trigger(str_category);
  wait 0.1;
  flag_set("je_battle_1_wave3_started");
}

je_battle1_wave3_trigger(str_category) {
  if(jungle_escape_can_do_autosave())
    autosave_by_name("battle_1_wave_3");

  a_spawners = getentarray("je_battle1_wave3_regular_launcher_spawner", "targetname");

  if(isDefined(a_spawners))
    simple_spawn_script_delay(a_spawners, ::spawn_fn_ai_run_to_target, 1, str_category, 0, 0, 0);

  level thread defend1_set_ai_pathing_distances(2);
}

defend1_set_ai_pathing_distances(delay) {
  if(isDefined(delay))
    wait(delay);

  enemy_left_4 = 0;
  enemy_left_2 = 0;
  enemy_left_1 = 0;
  path_distance = 2048;

  while(true) {
    ai = getaiarray("axis");

    if(enemy_left_4 == 0 && ai.size <= 4) {
      path_distance = 1500;
      ai_set_enemy_fight_distance(level.player, path_distance, 1);
      enemy_left_4 = 1;
    }

    if(enemy_left_2 == 0 && ai.size <= 2) {
      path_distance = 1250;
      ai_set_enemy_fight_distance(level.player, path_distance, 1);
      enemy_left_2 = 1;
    }

    if(enemy_left_1 == 0 && ai.size <= 1) {
      path_distance = 1000;
      ai_set_enemy_fight_distance(level.player, path_distance, 1);
      enemy_left_1 = 1;
      return;
    }

    if(is_player_climbing_tree()) {
      ai_set_enemy_fight_distance(undefined, 2048, 1);

      while(true) {
        if(!is_player_climbing_tree()) {
          ai_set_enemy_fight_distance(level.player, path_distance, 1);
          break;
        }

        wait 0.01;
      }
    }

    if(flag("je_hudson_in_position_for_battle_2")) {
      ai_set_enemy_fight_distance(undefined, 2048, 1);
      return;
    }

    wait 0.1;
  }
}

je_battle2_chasers(str_category) {
  e_trigger = getent("defend2_chaser_spawners_trigger", "targetname");
  e_trigger waittill("trigger");
  a_spawners = getentarray("je_defend2_chaser_spawner", "targetname");

  if(isDefined(a_spawners))
    simple_spawn_script_delay(a_spawners, ::spawn_fn_ai_run_to_target, 1, str_category, 1, 0, 0);
}

je_battle2_stealth_patrol_setup(str_category) {
  flag_wait("je_hudson_in_position_for_battle_2");
  wait 1;
  level thread maps\angola_stealth::setup_stealth_event(undefined, "je_battle2_patrol_spawner", str_category, 0, 0);
  level thread maps\angola_stealth::player_stealth_override_spotted_params(0.3, 0.4);
  level thread patrol_set_ground_visibility_distance(2000);
}

je_battle2_dog_attack_trigger() {
  flag_wait("je_hudson_in_position_for_battle_2");
  wait 0.1;
  level thread temp_defend2_dogs_text();
  wait 1;
  a_nodes = [];
  a_nodes[a_nodes.size] = "je_defend2_dog1_node1";
  a_nodes[a_nodes.size] = "je_defend2_dog1_node2";
  a_nodes[a_nodes.size] = "je_defend2_dog1_node3";
  a_nodes[a_nodes.size] = "je_defend2_dog1_node4";
}

temp_defend2_dogs_text() {
  iprintlnbold("There using dogs to track us down, cover us");
  wait 2;
  iprintlnbold("MASON: Take up a defensive Position in the area ahead");
}

je_battle2_wave1_trigger(str_category) {
  flag_wait("je_hudson_heads_to_battle_2");
  e_trigger = getent("defend2_chaser_spawners_trigger", "targetname");
  e_trigger waittill("trigger");
  min_start_time = 4;
  max_start_time = 8;
  min_enemies = 1;
  str_start_notify = "mike_is_cool_2";
  level thread maps\angola_2_util::wait_time_and_enemies(min_start_time, max_start_time, min_enemies, str_start_notify);
  level waittill(str_start_notify);
  a_spawners = getentarray("je_battle2_wave1_regular_spawner", "targetname");

  if(isDefined(a_spawners))
    simple_spawn_script_delay(a_spawners, ::spawn_fn_ai_run_to_target, 1, str_category, 0, 1, 0);

  a_spawners = getentarray("je_battle2_wave1_launcher_spawner", "targetname");

  if(isDefined(a_spawners))
    simple_spawn_script_delay(a_spawners, ::spawn_fn_ai_run_to_target, 1, str_category, 0, 1, 1);

  level thread simple_spawn_rusher_single("je_battle2_wave1_rusher_spawner", str_category, level.player_rusher_medium_dist);
  flag_set("je_battle_2_wave1_started");
}

battle2_wave1_dialog() {
  wait 3;
  level.ai_hudson say_dialog("huds_you_secured_the_evac_0");
  level.player say_dialog("maso_can_it_hudson_0");
}

je_battle2_wave2_trigger(str_category) {
  flag_wait("je_hudson_in_position_for_battle_2");
  min_start_time = 10;
  max_start_time = 12;
  min_enemies = 4;
  str_start_notify = "mike_is_cool";
  level thread maps\angola_2_util::wait_time_and_enemies(min_start_time, max_start_time, min_enemies, str_start_notify);
  level waittill(str_start_notify);
  flag_set("je_battle_2_wave2_started");
  flag_set("je_force_squad_to_move_to_battle_3");
  a_spawners = getentarray("je_battle2_wave2_regular_spawner", "targetname");

  if(isDefined(a_spawners))
    simple_spawn_script_delay(a_spawners, ::spawn_fn_ai_run_to_target, 1, str_category, 0, 0, 0);

  level thread simple_spawn_rusher("je_battle2_wave3_rusher_spawner", str_category, level.player_rusher_medium_dist);
  level thread je_battle2_wave3_trigger(str_category, 3);
}

je_battle2_wave3_trigger(str_category, delay) {
  if(isDefined(delay))
    wait(delay);

  a_spawners = getentarray("je_battle2_wave3_regular_spawner", "targetname");

  if(isDefined(a_spawners))
    simple_spawn_script_delay(a_spawners, ::spawn_fn_ai_run_to_target, 1, str_category, 0, 0, 0);

  level thread simple_spawn_rusher("je_battle2_wave3_rusher_spawner", str_category, level.player_rusher_medium_dist);
}

behind_us_vo_node() {
  nd_node = getnode("behind_us_vo_node", "targetname");
  v_forward = anglestoforward(nd_node.angles);

  while(true) {
    v_dir = vectornormalize(level.player.origin - nd_node.origin);
    dot = vectordot(v_forward, v_dir);

    if(dot > 0.3) {
      break;
    }

    wait 0.01;
  }
}

je_battle3_chasers(str_category) {
  flag_wait("je_hudson_heads_to_battle_3");
  wait 1;
  a_spawners = getentarray("je_defend3_chaser_spawner", "targetname");

  if(isDefined(a_spawners))
    simple_spawn_script_delay(a_spawners, ::spawn_fn_ai_run_to_target, 1, str_category, 1, 0, 0);
}

je_battle3_wave1_trigger(str_category) {
  flag_wait("je_hudson_in_position_for_battle_3");

  if(jungle_escape_can_do_autosave())
    autosave_by_name("battle_3_wave_1");

  a_spawners = getentarray("je_battle3_wave1_regular_spawner", "targetname");

  if(isDefined(a_spawners))
    simple_spawn_script_delay(a_spawners, ::spawn_fn_ai_run_to_target, 1, str_category, 0, 0, 0);
}

je_battle3_wave2_trigger(str_category) {
  flag_wait("je_hudson_in_position_for_battle_3");
  min_start_time = 2;
  max_start_time = 5;
  min_enemies = 4;
  str_start_notify = "mike_is_cool_3_2";
  level thread maps\angola_2_util::wait_time_and_enemies(min_start_time, max_start_time, min_enemies, str_start_notify);
  level waittill(str_start_notify);

  if(jungle_escape_can_do_autosave())
    autosave_by_name("battle_3_wave_2");

  flag_set("je_battle_3_wave2_started");
  a_spawners = getentarray("je_battle3_wave2_regular_spawner", "targetname");

  if(isDefined(a_spawners))
    simple_spawn_script_delay(a_spawners, ::spawn_fn_ai_run_to_target, 1, str_category, 0, 0, 0);

  level.ai_hudson thread say_dialog("huds_they_re_all_over_w_0", 2);
  trigger = getent("spawn_truck_wave_2", "targetname");
  trigger activate_trigger();
}

je_battle3_wave3_trigger(str_category) {
  flag_wait("je_hudson_heads_to_beach");
  flag_wait("evac_to_beach_hudson_started");

  if(jungle_escape_can_do_autosave())
    autosave_by_name("battle_3_wave_3");

  a_spawners = getentarray("je_battle3_wave3_regular_spawner", "targetname");

  if(isDefined(a_spawners)) {
    array_thread(a_spawners, ::add_spawn_function, ::spawn_fn_ai_run_to_target, 1, str_category, 0, 0, 0);
    trigger_use("trig_battle3_wave3", "script_noteworthy");
  }

  wait 10;
  level thread maps\angola_jungle_ending::kill_player_if_linger(20);
}

je_battle3_wave4_trigger(str_category) {
  flag_wait("je_hudson_heads_to_beach");
  wait 8;
  a_spawners = getentarray("je_battle3_wave4_regular_spawner", "targetname");

  if(isDefined(a_spawners)) {
    array_thread(a_spawners, ::add_spawn_function, ::spawn_fn_ai_run_to_target, 1, str_category, 0, 0, 0);
    trigger_use("trig_battle3_wave4", "script_noteworthy");
  }
}

je_battle3_wave_drones_trigger(str_category) {
  flag_wait("je_hudson_heads_to_beach");
  wait 8;
  sp_drone = getent("je_drone1_spawner", "targetname");
  drones_assign_spawner("drone1_end_level_trigger", sp_drone);
  drones_speed_modifier("drone1_end_level_trigger", -0.3, -0.1);
  drones_start("drone1_end_level_trigger");
  wait 25;
  drones_delete("drone1_end_level_trigger");
}

je_battle3_mortar_attack() {
  level thread rock_attack_mortar();
  flag_wait("je_battle_3_wave2_started");
  wait 10;
  v_start = (-23583, -1116, 372);
  speed_scale = 0.18;
  height_scale = 0.75;
  v_end = (-26200, 971, 85);
  level thread fire_angola_mortar(v_start, v_end, speed_scale, height_scale, 1.0);
  level waittill("angola_mortar_impact");
  wait 0.5;
  wait 3;
  v_end = (-26328, 922, 85);
  level thread fire_angola_mortar(v_start, v_end, speed_scale, height_scale, 1.0);

  while(true) {
    delay = randomfloatrange(6, 10);
    wait(delay);

    if(isDefined(level.hudson_at_beach_evauation_point) && level.hudson_at_beach_evauation_point == 1) {
      break;
    }

    v_end = level.player.origin;
    v_dir = vectornormalize(v_start - v_end);
    r_dist = randomfloatrange(252, 924);
    v_end = v_end + v_dir * r_dist;
    level thread fire_angola_mortar(v_start, v_end, speed_scale, height_scale, 84);
  }
}

rock_attack_mortar() {
  flag_wait("je_hudson_in_position_for_battle_3");
  wait 5;
  v_start = (-23583, -1116, 372);
  speed_scale = 0.18;
  height_scale = 0.75;
  v_end = (-25701, 1515, 160);
  level thread fire_angola_mortar(v_start, v_end, speed_scale, height_scale, 1.0);
  level waittill("angola_mortar_impact");
  level.ai_hudson thread say_dialog("huds_incoming_mortars_0", 0.1);
  wait 0.3;
  level notify("fxanim_mortar_rocks_start");
  wait 2;
}

angola_jungle_animations() {
  level thread mason_woods_goto_jungle_fight1_anim();
  level thread mason_woods_goto_jungle_fight2_anim();
  level thread mason_woods_goto_jungle_fight3_anim();
}

mason_woods_goto_jungle_fight1_anim() {
  level thread run_scene("hudson_woods_jungle_escape_begin_loop");

  while(true) {
    if(flag("je_mason_meets_woods_at_village_exit")) {
      break;
    }

    wait 0.1;
  }

  level.ai_woods.ignoreme = 1;
  str_scene_name = "mason_meets_hudson_and_woods_at_start";
  level thread run_scene(str_scene_name);
  wait 0.1;
  flag_set("je_hudson_heads_to_battle_1");
  level.ai_hudson.ignoreme = 1;
  level.ai_woods.ignoreme = 1;
  scene_wait(str_scene_name);
  flag_set("je_hudson_in_position_for_battle_1");
  level.ai_hudson.badplaceawareness = 0;
  badplace_cylinder("badplace_woods", 0, level.ai_woods.origin, 256, 128, "axis");
  level thread run_scene("hudson_woods_jungle_escape_stop_01_loop");
  level.ai_hudson.ignoreall = 1;
  level.ai_hudson.ignoreme = 1;
  a_nodes = [];
  a_nodes[a_nodes.size] = getnode("hudson_defend1_node1", "targetname");
  a_nodes[a_nodes.size] = getnode("hudson_defend1_node2", "targetname");
  a_nodes[a_nodes.size] = getnode("hudson_defend1_node3", "targetname");
  a_nodes[a_nodes.size] = getnode("hudson_defend1_node4", "targetname");
  level.ai_hudson thread hudson_join_battle(a_nodes, 10, 18);
}

mason_woods_goto_jungle_fight2_anim() {
  flag_wait("je_hudson_heads_to_battle_2");
  level thread hudson_throwing_smoke_grenade_vo_wave_1();
  struct_grenade = getstruct("smoke_grenade_throw_pos_exit_wave_2", "targetname");
  badplace_delete("badplace_woods");
  level.ai_hudson.badplaceawareness = 1;
  level.ai_hudson hudson_throw_smoke_grenade("org_hudson_smoke_grenade_1", struct_grenade.origin);
  level thread friendly_vo_retreat_1();
  delete_scene("hudson_woods_jungle_escape_stop_01_loop");
  level.ai_woods.ignoreme = 1;
  run_scene("hudson_and_woods_jungle_escape_move_defend_2");
  flag_set("je_hudson_in_position_for_battle_2");
  level.ai_hudson.badplaceawareness = 0;
  badplace_cylinder("badplace_woods", 0, level.ai_woods.origin, 256, 128, "axis");
  level thread run_scene("hudson_woods_jungle_escape_stop_02_loop");
  a_nodes = [];
  a_nodes[a_nodes.size] = getnode("hudson_defend2_node1", "targetname");
  a_nodes[a_nodes.size] = getnode("hudson_defend2_node2", "targetname");
  level.ai_hudson thread hudson_join_battle(a_nodes, 20, 30);
}

hudson_throwing_smoke_grenade_vo_wave_1() {
  level.player say_dialog("maso_we_gotta_get_moving_0");
  level flag_set_delayed("enemy_smoke_vo_1", 1);
  level.ai_hudson say_dialog("huds_smoke_out_0");
}

mason_woods_goto_jungle_fight3_anim() {
  flag_wait("je_hudson_heads_to_battle_3");
  level thread hudson_throwing_smoke_grenade_vo_wave_2();
  struct_grenade = getstruct("smoke_grenade_throw_pos_exit_wave_3", "targetname");
  badplace_delete("badplace_woods");
  level.ai_hudson.badplaceawareness = 1;
  level.ai_hudson hudson_throw_smoke_grenade("org_hudson_smoke_grenade_2", struct_grenade.origin);
  delete_scene("hudson_woods_jungle_escape_stop_02_loop");
  level.ai_woods.ignoreme = 1;
  run_scene("hudson_and_woods_jungle_escape_move_defend_3");
  level.ai_hudson.badplaceawareness = 0;
  badplace_cylinder("badplace_woods", 0, level.ai_woods.origin, 400, 128, "axis");
  flag_set("je_hudson_in_position_for_battle_3");
  level thread run_scene("hudson_woods_jungle_escape_stop_03_loop");
  a_nodes = [];
  a_nodes[a_nodes.size] = getnode("hudson_defend3_node1", "targetname");
  a_nodes[a_nodes.size] = getnode("hudson_defend3_node2", "targetname");
  level.ai_hudson thread hudson_join_battle(a_nodes, 20, 30);
}

hudson_throwing_smoke_grenade_vo_wave_2() {
  level.player say_dialog("maso_we_gotta_make_a_run_0");
  level.ai_hudson waittill("hudson_throwing_smoke");
  flag_set("enemy_smoke_vo_2");
  level.ai_hudson say_dialog("huds_throwing_smoke_0");
  level thread friendly_vo_retreat_2();
}

hudson_join_battle(a_nodes, min_wait, max_wait) {
  self endon("death");
  self endon("hudson_move_with_woods");
  nd_node = a_nodes[0];
  self setgoalnode(nd_node);
  self.goalradius = 48;
  self.ignoreall = 1;
  self.ignoreme = 1;
  self.attackeraccuracy = 0.1;
  self waittill("goal");

  while(true) {
    if(!is_player_in_stealth_mode()) {
      break;
    }

    wait 0.01;
  }

  self.ignoreme = 0;
  self.ignoreall = 0;
  self.accuracy = 0.1;

  if(a_nodes.size > 1) {
    start_time = gettime();
    node_index = 0;

    while(true) {
      delay = randomfloatrange(min_wait, max_wait);
      wait(delay);
      node_index++;

      if(node_index >= a_nodes.size)
        node_index = 0;

      nd_node = a_nodes[node_index];
      self setgoalnode(nd_node);
      self.goalradius = 48;
      self waittill("goal");
      self.fixednode = 1;
    }
  }
}

je_1st_battle_advance_nag_lines() {
  nag1_done = 1;
  nag1_time = 1;
  nag2_done = 0;
  nag2_time = 7;
  nag3_done = 0;
  nag3_time = 15;
  start_time = gettime();

  while(true) {
    if(flag("je_hudson_heads_to_battle_2")) {
      return;
    }
    time = gettime();
    dt = (time - start_time) / 1000;

    if(!nag1_done) {
      if(dt >= nag1_time)
        nag1_done = 1;
    } else if(!nag2_done) {
      if(dt >= nag2_time)
        nag2_done = 1;
    } else if(dt >= nag3_time) {
      nag3_done = 1;
      flag_set("je_force_squad_to_move_to_battle_2");
      return;
    }

    wait 0.01;
  }
}

tree_sniper_initialization() {
  level.player thread sniper_tree_logic();
  a_sniper_tree_triggers = getentarray("trig_sniper_tree", "targetname");

  foreach(t_sniper_tree in a_sniper_tree_triggers)
  t_sniper_tree thread is_player_on_sniper_tree_logic();
}

is_player_on_sniper_tree_logic() {
  while(true) {
    self waittill("trigger");
    level.player.t_current_tree = self;
    flag_clear("player_off_sniper_tree");
    flag_set("player_on_sniper_tree");

    while(level.player istouching(self))
      wait 0.05;

    flag_clear("player_on_sniper_tree");
    flag_set("player_off_sniper_tree");
  }
}

sniper_tree_logic() {
  while(true) {
    flag_wait("player_on_sniper_tree");
    level thread sniper_tree_enemy_update();
    self thread sniper_tree_player_discovered_logic();
    flag_wait("player_off_sniper_tree");
    wait 0.05;
  }
}

sniper_tree_player_discovered_logic() {
  level endon("player_off_sniper_tree");
  level notify("clear_another_player_discover_thread");
  level endon("clear_another_player_discover_thread");
  self waittill_any("weapon_fired");
  self.ignoreme = 0;
  self.t_previous_alerted_tree = self.t_current_tree;
}

sniper_tree_enemy_update() {
  while(!flag("player_off_sniper_tree")) {
    enemy_ai_disable_grenades(1);
    wait 0.05;
  }
}

is_player_climbing_tree() {
  if(isDefined(level.player.climbing_tree) && level.player.climbing_tree == 1)
    return true;

  return false;
}

woods_damage_fail_condition() {
  flag_wait("je_hudson_in_position_for_battle_1");
  level.ai_woods.ignoreme = 0;
  level.ai_woods.overrideactordamage = ::woods_damage_override;
  num_warnings = 0;
  time_last_hit = undefined;
  nag = 0;

  while(true) {
    if(flag("je_hudson_heads_to_beach")) {
      return;
    }
    if(flag("je_woods_takes_damage")) {
      num_warnings++;
      time_last_hit = gettime();

      if(num_warnings >= 4)
        missionfailedwrapper(&"ANGOLA_2_WOODS_KILLED");

      if(nag == 0) {
        level.player say_dialog("maso_we_gotta_protect_woo_0");
        nag = 1;
      } else {
        level.ai_hudson say_dialog("huds_dammit_mason_we_g_0");
        nag = 0;
      }

      wait 3;
      flag_clear("je_woods_takes_damage");
    }

    if(num_warnings > 2) {
      if(isDefined(time_last_hit)) {
        time = gettime();
        dt = (time - time_last_hit) / 1000;

        if(dt > 60) {
          num_warnings = num_warnings - 1;
          time_last_hit = time;
        }
      }
    }

    wait 0.01;
  }
}

woods_damage_override(e_inflictor, e_attacker, n_damage, n_flags, str_means_of_death, str_weapon, v_point, v_dir, str_hit_loc, n_model_index, psoffsettime, str_bone_name) {
  n_damage = 0;
  flag_set("je_woods_takes_damage");
  return n_damage;
}

hudson_nag_lines(n_wait) {
  level endon("stop_hudson_nag");
  wait(n_wait);
  level.ai_hudson say_dialog("huds_fall_back_fall_back_0");
}

jungle_escape_enemy_vo() {
  level thread sniper_deaths_vo();
  level thread beartrap_deaths_vo();
  level thread ammo_refill_vo();
  level thread jungle_escape_enemy_chatter_battle_1();
  level thread jungle_escape_enemy_chatter_retreat_1();
  level thread jungle_escape_enemy_chatter_battle_2();
  level thread jungle_escape_enemy_chatter_retreat_2();
  level thread jungle_escape_enemy_chatter_mg_truck();
  level thread jungle_escape_enemy_chatter_battle_3_part_1();
  level thread jungle_escape_enemy_chatter_battle_3_part_2();
  level thread jungle_escape_enemy_chatter_retreat_3();
}

sniper_deaths_vo() {
  lines = array("cub2_keep_up_your_fire_h_0", "cub3_sniper_0", "cub0_slow_down_and_use_co_0", "cub0_taking_sniper_fire_0", "cub1_in_the_trees_0", "cub2_keep_moving_don_t_l_0", "cub0_sniper_in_the_trees_0", "cub1_get_down_shooter_in_0", "cub2_shooter_on_the_platf_0");
  exclusion_timer = 8;
  level thread play_specific_vo_on_notify(lines, "sniper_tree_kill", exclusion_timer, "end_of_jungle_escape");
}

beartrap_deaths_vo() {
  lines = array("cub3_watch_your_step_the_0", "cub0_aagggghhhh_my_leg_0", "cub1_stay_off_the_main_pa_0");
  exclusion_timer = 8;
  level thread play_specific_vo_on_notify(lines, "beartrap_triggered", exclusion_timer, "end_of_jungle_escape");
}

ammo_refill_vo() {
  lines = array("cub2_they_re_low_on_ammo_0", "cub3_they_have_discovered_0");
  exclusion_timer = 10;
  level.player thread play_specific_vo_on_notify(lines, "ammo_refilled", exclusion_timer, "end_of_jungle_escape");
}

jungle_escape_enemy_chatter_battle_1() {
  level.player endon("death");
  flag_wait("je_hudson_in_position_for_battle_1");
  lines = array("cub0_they_are_in_cover_0", "cub0_they_have_wounded_0", "cub1_behind_the_rock_0", "cub2_concentrate_your_fir_0", "cub1_we_are_losing_men_0", "cub2_send_for_more_reinfo_0", "cub3_radio_back_we_are_ta_0");
  min_delay = 3;
  max_delay = 10;
  level thread play_battle_convo_until_flag("axis", lines, min_delay, max_delay, "je_hudson_heads_to_battle_2");
}

jungle_escape_enemy_chatter_retreat_1() {
  level.player endon("death");
  flag_wait("enemy_smoke_vo_1");
  lines = array("cub0_smoke_grenade_0", "cub1_i_can_t_see_them_thr_0", "cub2_fire_their_wounded_0");
  min_delay = 3;
  max_delay = 8;
  level thread play_battle_convo_until_flag("axis", lines, min_delay, max_delay, "je_hudson_in_position_for_battle_2", 1);
}

jungle_escape_enemy_chatter_battle_2() {
  level.player endon("death");
  flag_wait("je_hudson_in_position_for_battle_2");
  wait 1;
  lines = array("cub3_target_them_move_fr_0", "cub2_shoot_on_sight_0", "cub3_their_wounded_man_is_0", "cub0_they_are_using_the_l_0", "cub0_they_are_using_the_l_0");
  min_delay = 3;
  max_delay = 8;
  level thread play_battle_convo_until_flag("axis", lines, min_delay, max_delay, "je_hudson_heads_to_battle_3");
}

jungle_escape_enemy_chatter_retreat_2() {
  level.player endon("death");
  flag_wait("enemy_smoke_vo_2");
  lines = array("cub0_shoot_into_the_smoke_0", "cub3_stay_on_them_men_0", "cub0_i_see_them_this_way_0", "cub1_we_are_gaining_on_th_0", "cub3_don_t_lose_them_0", "cub3_our_vehicle_support_0", "cub0_get_it_to_the_waterf_0", "cub1_our_machine_gun_will_0", "cub1_they_are_moving_agai_0", "cub0_hurry_we_are_losin_0", "cub1_if_they_escape_menen_0");
  min_delay = 3;
  max_delay = 10;
  level thread play_battle_convo_until_flag("axis", lines, min_delay, max_delay, "je_hudson_in_position_for_battle_3");
}

jungle_escape_enemy_chatter_mg_truck() {
  level.player endon("death");
  flag_wait("waterfall_mg_truck_destroyed");
  lines = array("cub2_we_have_lost_our_mg_0", "cub3_where_is_our_other_t_0");
  guys = getaiarray("axis");
  counter = 0;

  while(guys.size == 0) {
    wait 0.25;
    counter = counter + 0.25;

    if(counter >= 2) {
      return;
    }
    guys = getaiarray("axis");
  }

  guys = arraysort(guys, level.player.origin, 1);
  guys[0] say_dialog(lines[0]);
  wait 1;

  if(isDefined(guys[1]) && isalive(guys[1]))
    guys[1] say_dialog(lines[1]);
}

jungle_escape_enemy_chatter_battle_3_part_1() {
  level.player endon("death");
  flag_wait("je_hudson_in_position_for_battle_3");
  wait 1;
  lines = array("cub0_surround_them_0", "cub1_quickly_men_they_ar_0", "cub2_we_have_you_now_ame_0");
  min_delay = 3;
  max_delay = 8;
  level thread play_battle_convo_until_flag("axis", lines, min_delay, max_delay, "je_battle_3_wave2_started");
}

jungle_escape_enemy_chatter_battle_3_part_2() {
  level.player endon("death");
  flag_wait("je_battle_3_wave2_started");
  wait 1;
  lines = array("cub1_fire_the_mortars_0", "cub2_add_50_to_the_distan_0", "cub3_use_the_mortars_to_p_0", "cub0_open_fire_0", "cub3_i_have_them_iver_h_0");
  wait 3;
  min_delay = 3;
  max_delay = 10;
  level thread play_battle_convo_until_flag("axis", lines, min_delay, max_delay, "enemy_vo_final_retreat");
}

jungle_escape_enemy_chatter_retreat_3() {
  level.player endon("death");
  flag_wait("enemy_vo_final_retreat");
  wait 1;
  lines = array("cub0_they_re_moving_again_0", "cub1_do_not_let_them_reac_0", "cub2_this_is_our_last_cha_0", "cub0_get_into_position_0", "cub3_we_need_more_men_0");
  min_delay = 5;
  max_delay = 10;
  level thread play_battle_convo_until_flag("axis", lines, min_delay, max_delay, "je_end_scene_started");
}

jungle_escape_can_do_autosave(b_check_flags) {
  max_dist_from_hudson = 1024;
  wave1_kill_flag = "kill_player_wave1_enabled";
  wave2_kill_flag = "kill_player_wave2_enabled";

  if(isDefined(b_check_flags) && !b_check_flags)
    return distance2d(level.player.origin, level.ai_hudson.origin) <= max_dist_from_hudson;

  if(distance2d(level.player.origin, level.ai_hudson.origin) > max_dist_from_hudson || flag("kill_player_wave1_enabled") || flag("kill_player_wave2_enabled") || flag("jungle_ending_do_not_save"))
    return false;

  return true;
}

delete_truck_riders_when_end_scene_starts() {
  level.player endon("death");
  self endon("death");
  level waittill("je_end_scene_started");

  foreach(guy in self.riders)
  guy delete();
}