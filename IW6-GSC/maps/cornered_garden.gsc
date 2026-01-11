/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\cornered_garden.gsc
*****************************************************/

cornered_garden_pre_load() {
  common_scripts\utility::flag_init("garden_finished");
  common_scripts\utility::flag_init("garden_spawn_first_enemies");
  common_scripts\utility::flag_init("garden_player_in_garden");
  common_scripts\utility::flag_init("FLAG_garden_vo1");
  common_scripts\utility::flag_init("FLAG_garden_wave1");
  common_scripts\utility::flag_init("FLAG_garden_wave2");
  common_scripts\utility::flag_init("FLAG_garden_wave3");
  common_scripts\utility::flag_init("FLAG_garden_wave4");
  common_scripts\utility::flag_init("FLAG_garden_wave5");
  common_scripts\utility::flag_init("FLAG_garden_done");
  common_scripts\utility::flag_init("FLAG_garden_enemy_shiftback_2");
  common_scripts\utility::flag_init("FLAG_garden_last_stand");
  common_scripts\utility::flag_init("garden_platform_go");
  common_scripts\utility::flag_init("FLAG_grdn_player_close_to_allies");
  thread check_trigger_flagset("TRIG_garden_vo1");
  thread check_trigger_flagset("TRIG_garden_wave1");
  thread check_trigger_flagset("TRIG_garden_wave2");
  thread check_trigger_flagset("TRIG_garden_enemy_shiftback_2");
  thread check_trigger_flagset("TRIG_garden_wave_final");
  precacheitem("mts255");
  precacheitem("l115a3");
  level.garden_idf_yellow_needed = 0;
  level.garden_idf_orange_needed = 0;
  level.garden_idf_guys_yellow = [];
  level.garden_idf_guys_orange = [];
  level.garden_enemies_cyan_needed = 0;
  level.garden_enemies_yellow_needed = 0;
  level.garden_enemy_guys_yellow = [];
  level.garden_enemy_guys_cyan = [];
  level.yellow_enemy_replenishers = [];
  level.current_yellow_enemy_replenisher = undefined;
}

setup_garden() {
  if(maps\cornered_code::is_e3()) {
    thread maps\cornered::e3_transition_start();
    return;
  }

  maps\cornered_code::setup_player();
  maps\cornered_code::spawn_allies();
  thread maps\cornered_code::handle_intro_fx();
  thread maps\cornered_audio::aud_check("garden");
  maps\cornered_lighting::do_specular_sun_lerp(1);
  level.player switchtoweapon("kriss+eotechsmg_sp+silencer_sp");
  maps\cornered_code::delete_building_glow();
  thread maps\cornered_code::cleanup_outside_ents_on_entry();
  maps\cornered_rappel::setup_garden_entry();
  maps\cornered_rappel::combat_rappel_spawn_garden_entry_enemies();
  common_scripts\utility::waitframe();
  maps\cornered_rappel::combat_rappel_garden_entry();
}

begin_garden() {
  if(maps\cornered_code::is_e3()) {
    return;
  }
  maps\cornered_code::take_away_offhands();
  thread garden_transient_sync();
  thread garden_entity_cleanup();
  thread fireworks_garden();
  thread maps\cornered_destruct::hvt_office_door_block_up();
  thread handle_garden();
  common_scripts\utility::flag_wait("garden_finished");
}

fireworks_garden() {
  var_0 = getent("TRIG_garden_setup", "targetname");
  var_0 waittill("trigger");
  thread maps\cornered_lighting::fireworks_start("garden");
  common_scripts\utility::flag_wait("go_to_stairwell");
  maps\cornered_lighting::fireworks_stop();
}

garden_transient_sync() {
  common_scripts\utility::flag_wait("garden_transient_sync");

  while(!synctransients()) {
    wait 0.01;
  }
}

garden_entity_cleanup() {
  get_verify_and_delete_ent("office_a_chopper", "targetname");
  get_verify_and_delete_ent("courtyard_reception_office_a_chopper", "targetname");
  get_verify_and_delete_ent_array("stealth_broken_backup", "targetname");
  get_verify_and_delete_ent_array("courtyard_intro_guys", "targetname");
  get_verify_and_delete_ent_array("courtyard_panel_fix_guys", "targetname");
  get_verify_and_delete_ent_array("courtyard_catwalk_background_guys", "targetname");
  get_verify_and_delete_ent("cr_rorke_side", "targetname");
  get_verify_and_delete_ent("cr_baker_side", "targetname");
  get_verify_and_delete_ent("p1_junction_volume", "targetname");
  get_verify_and_delete_ent("baker_out_combat", "targetname");
  get_verify_and_delete_ent("baker_center_combat", "targetname");
  get_verify_and_delete_ent("baker_in_combat", "targetname");
  get_verify_and_delete_ent("rorke_out_combat", "targetname");
  get_verify_and_delete_ent("rorke_center_combat", "targetname");
  get_verify_and_delete_ent("rorke_in_combat", "targetname");
  get_verify_and_delete_ent("p1_upper_volume", "targetname");
  get_verify_and_delete_ent("p1_lower_volume", "targetname");
  get_verify_and_delete_ent("copymachine_window_event_volume", "targetname");
  get_verify_and_delete_ent("rappel_combat_two_volume_downstairs", "targetname");
  get_verify_and_delete_ent("rappel_combat_two_volume_upstairs", "targetname");
  get_verify_and_delete_ent("grenade_volume", "targetname");
  get_verify_and_delete_ent("copier_dude", "targetname");
  get_verify_and_delete_ent("copymachine_clip", "targetname");
  get_verify_and_delete_ent("lower_drone", "targetname");
  get_verify_and_delete_ent("p2_second_wave_upstairs", "targetname");
  get_verify_and_delete_ent("player_rappel_angles_combat", "targetname");
  get_verify_and_delete_ent("player_rappel_ground_ref_combat", "targetname");
  get_verify_and_delete_ent("player_rappel_ground_ref_upside_down", "targetname");
  get_verify_and_delete_ent("player_rappel_trigger", "targetname");
  get_verify_and_delete_ent_array("p1_ahead_volume", "targetname");
  get_verify_and_delete_ent_array("enemies_above_junction_floor", "targetname");
  get_verify_and_delete_ent_array("enemies_above_upper_floor", "targetname");
  get_verify_and_delete_ent_array("enemies_above_lower_floor", "targetname");
  get_verify_and_delete_ent_array("enemies_above_ahead_floor", "targetname");
  get_verify_and_delete_ent_array("hallway_talker_drone", "targetname");
  get_verify_and_delete_ent_array("hallway_runner_drone", "targetname");
  get_verify_and_delete_ent_array("lower_drone_runners", "targetname");
  get_verify_and_delete_ent_array("p2_first_wave_upstairs", "targetname");
  get_verify_and_delete_ent_array("p2_first_wave_downstairs", "targetname");
  get_verify_and_delete_ent_array("p2_second_wave_downstairs", "targetname");
}

get_verify_and_delete_ent(var_0, var_1) {
  var_2 = getent(var_0, var_1);

  if(isDefined(var_2)) {
    var_2 delete();
  }
}

get_verify_and_delete_ent_array(var_0, var_1) {
  var_2 = getEntArray(var_0, var_1);

  if(isDefined(var_2)) {
    foreach(var_4 in var_2) {
    var_4 delete();
    }
  }
}

check_trigger_flagset(var_0) {
  var_1 = getent(var_0, "targetname");
  var_1 waittill("trigger");

  if(isDefined(var_1.script_flag_set)) {
    common_scripts\utility::flag_set(var_1.script_flag_set);
  }
}

handle_garden() {
  maps\_utility::set_team_bcvoice("allies", "taskforce");
  thread maps\_utility::battlechatter_on("allies");
  thread maps\_utility::battlechatter_on("axis");
  thread garden_gameplay();
  common_scripts\utility::flag_wait("garden_finished");
  thread garden_enemies_delete();
}

garden_gameplay() {
  common_scripts\utility::flag_wait("garden_spawn_first_enemies");
  var_0 = getaiarray("axis");
  pre_garden_spawn();
  level.allies[level.const_rorke] maps\_utility::enable_ai_color();
  level.allies[level.const_baker] maps\_utility::enable_ai_color();
  common_scripts\utility::flag_wait("garden_player_in_garden");

  foreach(var_2 in var_0) {
    if(isDefined(var_2) && isalive(var_2) && !isDefined(var_2.entry)) {
      var_2 delete();
    }
  }

  level thread garden_vo();
  maps\cornered_lighting::do_specular_sun_lerp(0);
}

pre_garden_spawn() {
  var_0 = maps\_utility::array_spawn_targetname("pre_garden_spawners_enemies", 1);
  thread maps\_utility::autosave_by_name_silent();
  thread garden_wave1();
  thread maps\cornered_code::ai_array_killcount_flag_set(var_0, int(var_0.size - 3), "FLAG_garden_wave1");
}

garden_wave1() {
  common_scripts\utility::flag_wait("FLAG_garden_wave1");
  var_0 = maps\_utility::array_spawn_targetname("garden_wave1", 1);
  thread maps\_utility::autosave_by_name_silent();
  thread garden_wave2();
  thread garden_enemy_shiftback_2();
  thread maps\cornered_code::ai_array_killcount_flag_set(var_0, int(var_0.size - 2), "FLAG_garden_wave2");
  thread retreat_from_vol_to_vol("vol_garden_right_stairs", "vol_garden_path_right", 0.3, 0.5);
  thread retreat_from_vol_to_vol("vol_garden_left_stairs", "vol_garden_path_left", 0.3, 0.5);
  maps\_utility::smart_radio_dialogue("cornered_mrk_pushthrough");
}

garden_wave2() {
  common_scripts\utility::flag_wait("FLAG_garden_wave2");
  var_0 = maps\_utility::array_spawn_targetname("garden_wave2", 1);
  thread maps\_utility::autosave_tactical();
  thread garden_wave_final();
  thread maps\cornered_code::ai_array_killcount_flag_set(var_0, int(var_0.size - 2), "FLAG_garden_wave_final");
  maps\_utility::smart_radio_dialogue("cornered_mrk_keeppushing");
}

garden_enemy_shiftback_2() {
  common_scripts\utility::flag_wait("FLAG_garden_enemy_shiftback_2");
  thread retreat_from_vol_to_vol("vol_garden_path_right", "vol_garden_back_right", 0.3, 0.5);
  thread retreat_from_vol_to_vol("vol_garden_path_left", "vol_garden_back_left", 0.3, 0.5);
}

garden_wave_final() {
  common_scripts\utility::flag_wait("FLAG_garden_wave_final");
  var_0 = maps\_utility::array_spawn_targetname("garden_wave_final", 1);
  level thread garden_window_break();
  thread maps\_utility::autosave_by_name_silent();
  maps\_utility::delaythread(5.75, ::close_hvt_office_doors, 1.25);
  thread garden_move_allies_to_end();
  thread garden_last_stand();
  thread maps\_utility::autosave_tactical();
  thread retreat_from_vol_to_vol("vol_garden_back_left", "vol_garden_last_stand_2", 0.3, 0.5);
  thread retreat_from_vol_to_vol("vol_garden_back_right", "vol_garden_back_movement", 0.3, 0.5);
}

garden_last_stand() {
  level notify("end_garden_vo");
  var_0 = getaiarray("axis");
  thread maps\cornered_code::ai_array_killcount_flag_set(var_0, int(var_0.size - 2), "FLAG_garden_last_stand");
  common_scripts\utility::flag_wait("FLAG_garden_last_stand");
  thread maps\_utility::autosave_tactical();
  thread retreat_from_vol_to_vol("vol_garden_back_movement", "vol_garden_last_stand", 0.3, 0.5);
  thread retreat_from_vol_to_vol("vol_garden_last_stand_2", "vol_garden_last_stand", 0.3, 0.5);
  var_1 = getaiarray("axis");
  thread maps\cornered_code::ai_array_killcount_flag_set(var_1, int(var_1.size), "FLAG_garden_done", 10);
  wait 1;
  maps\_utility::activate_trigger_with_targetname("TRIG_last_stand_colors");
}

close_hvt_office_doors(var_0) {
  var_1 = getent("hvt_office_entry_door_left", "targetname");
  var_2 = getent("hvt_office_entry_door_right", "targetname");
  var_3 = common_scripts\utility::getstruct("hvt_office_entry_door_left_dest", "targetname");
  var_4 = common_scripts\utility::getstruct("hvt_office_entry_door_right_dest", "targetname");
  var_1 moveto(var_3.origin, var_0);
  var_2 moveto(var_4.origin, var_0);
  wait 0.5;
  var_1 disconnectpaths();
  var_2 disconnectpaths();
}

delayed_setgoalvolumeauto(var_0) {
  self setgoalvolumeauto(var_0);
}

garden_move_allies_to_end() {
  level endon("garden_finished");
  common_scripts\utility::flag_wait("FLAG_garden_done");
  wait 0.1;
  var_0 = getnode("rorke_cover_hvt", "targetname");
  var_1 = getnode("baker_cover_hvt", "targetname");
  level.allies[level.const_rorke] setgoalnode(var_1);
  level.allies[level.const_baker] setgoalnode(var_0);
  waittill_ally_goals(30);
  common_scripts\utility::flag_wait("FLAG_grdn_player_close_to_allies");
  thread maps\_utility::autosave_tactical();
  common_scripts\utility::flag_set("garden_finished");
}

waittill_ally_goals(var_0) {
  var_1 = level.allies[level.const_baker];
  var_2 = level.allies[level.const_rorke];
  var_1 thread ally_goal_mark();
  var_2 thread ally_goal_mark();
  var_3 = gettime() + var_0 * 1000;

  while(gettime() < var_3) {
    var_4 = isDefined(var_1.at_goal_node) && var_1.at_goal_node;
    var_5 = isDefined(var_2.at_goal_node) && var_2.at_goal_node;

    if(var_4 && var_5) {
      break;
    }

    common_scripts\utility::waitframe();
  }

  var_1.at_goal_node = undefined;
  var_2.at_goal_node = undefined;
}

ally_goal_mark() {
  self waittill("goal");
  self.at_goal_node = 1;
}

garden_window_break() {
  var_0 = getent("garden_glass", "targetname");
  maps\_utility::array_spawn_function_targetname("garden_glass_breaker_spawners", ::garden_glass_room_guy_spawnfunc);
  maps\_utility::array_spawn_targetname("garden_glass_breaker_spawners", 1);
  wait 1.5;
  var_1 = common_scripts\utility::getstructarray("garden_glass_breaker_struct", "targetname");

  foreach(var_3 in var_1) {
    glassradiusdamage(var_3.origin, 40, 100, 100);
    var_4 = randomfloatrange(0.1, 0.3);
    wait(var_4);
  }
}

garden_glass_room_guy_spawnfunc() {
  self endon("death");
  self.ignoreall = 1;
  wait 3.0;
  self.ignoreall = 0;
}

garden_enemies_delete() {
  wait 2;
  var_0 = getEntArray("garden_enemies", "script_noteworthy");
  var_1 = [];

  if(isDefined(var_0) && var_0.size > 0) {
    var_1 = maps\_utility::array_removedead_or_dying(var_0);
  }

  if(var_1.size > 0) {
    foreach(var_3 in var_1) {
    var_3 kill();
    }
  }
}

garden_vo() {
  level endon("end_garden_vo");

  for(;;) {
    wait(randomintrange(6, 10));
    maps\_utility::smart_radio_dialogue("cornered_mrk_wehavetoget");
    wait(randomintrange(6, 10));
    maps\_utility::smart_radio_dialogue("cornered_mrk_movemove");
    wait(randomintrange(6, 10));
    maps\_utility::smart_radio_dialogue("cornered_mrk_wecantletramos");
    wait(randomintrange(6, 10));
    maps\_utility::smart_radio_dialogue("cornered_mrk_dontstopkeepmoving");
    wait(randomintrange(6, 10));
    maps\_utility::smart_radio_dialogue("cornered_mrk_comeongo");
    wait(randomintrange(6, 10));
    maps\_utility::smart_radio_dialogue("cornered_mrk_keeppushing");
    wait(randomintrange(6, 10));
    maps\_utility::smart_radio_dialogue("cornered_mrk_pushthrough");
  }
}

retreat_from_vol_to_vol(var_0, var_1, var_2, var_3) {
  var_4 = getent(var_0, "targetname");
  var_5 = var_4 maps\_utility::get_ai_touching_volume("axis");
  var_6 = getent(var_1, "targetname");
  var_7 = getnode(var_6.target, "targetname");

  foreach(var_9 in var_5) {
    if(isDefined(var_9) && isalive(var_9)) {
      var_9.forcegoal = 0;
      var_9.fixednode = 0;
      var_9.pathrandompercent = randomintrange(75, 100);
      var_9 setgoalnode(var_7);
      var_9 setgoalvolumeauto(var_6);
    }
  }
}