/******************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\zquests\zmb_secret_challenges_util.gsc
******************************************************************/

init_challenges_utility() {
  if(!isDefined(level.zmb_zombie_killed_responses))
    level.zmb_zombie_killed_responses = [];

  level.zmb_challenges_on_entered_laststand_funcs = [];
  level.zmb_challenges_on_dmg_funcs = [];
  level.zmb_events_purchase_notify = "player_purchase_challenge_";
  level.zmb_events_consumables_notify = "player_challenges_consumable_use";
  _id_0547::_id_7BA9(::secret_challenges_get_zombie_killed_feedback);
  level thread maps\mp\_utility::_id_6F74(::report_player_entered_last_stand);
  level thread maps\mp\_utility::_id_6F74(::get_next_player_weapon);
  level.zmb_teamwork_required_challenges = [];
}

report_player_damaged(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  foreach(var_11 in level.zmb_challenges_on_dmg_funcs) {
    if(isDefined(var_11.check) && ![[var_11.check]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9)) {
      continue;
    }
    level thread[[var_11._id_3F02]](var_11.param);
  }
}

agent_is_zombie(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  return isDefined(var_1) && !isPlayer(var_1) && isDefined(var_1._id_0A4B);
}

register_on_player_down_func(var_0, var_1) {
  var_2 = spawnStruct();
  var_2._id_3F02 = var_0;
  var_2.param = var_1;
  level.zmb_challenges_on_entered_laststand_funcs = common_scripts\utility::_id_0F6F(level.zmb_challenges_on_entered_laststand_funcs, var_2);
}

report_player_entered_last_stand() {
  for(;;) {
    var_0 = self;
    var_0 common_scripts\utility::_id_A70A("enter_last_stand");

    foreach(var_2 in level.zmb_challenges_on_entered_laststand_funcs)
    level thread[[var_2._id_3F02]](var_2.param);
  }
}

register_on_player_dmg_func(var_0, var_1, var_2) {
  var_3 = spawnStruct();
  var_3._id_3F02 = var_0;
  var_3.param = var_1;
  var_3.check = var_2;
  level.zmb_challenges_on_dmg_funcs = common_scripts\utility::_id_0F6F(level.zmb_challenges_on_dmg_funcs, var_3);
}

register_on_flag_set_func(var_0, var_1, var_2) {
  common_scripts\utility::_id_3CA3(var_2);
  level thread[[var_0]](var_1);
}

register_on_notify_set_func(var_0, var_1, var_2) {
  for(var_3 = 0; var_3 < var_2.size - 1; var_3 = var_3 + 2)
    var_2[var_3] childthread run_func_on_notify(var_0, var_1, var_2[var_3 + 1]);
}

register_on_zombie_dmg_func(var_0, var_1, var_2) {
  if(!isDefined(level.zmb_challenges_on_zombie_dmg_funcs))
    level.zmb_challenges_on_zombie_dmg_funcs = [];

  var_3 = spawnStruct();
  var_3._id_3F02 = var_0;
  var_3.param = var_1;
  var_3._id_67E9 = var_2;
  level.zmb_challenges_on_zombie_dmg_funcs = common_scripts\utility::_id_0F6F(level.zmb_challenges_on_zombie_dmg_funcs, var_3);
}

run_func_on_notify(var_0, var_1, var_2) {
  self waittill(var_2);
  level thread[[var_0]](var_1);
}

register_on_minute_reached_func(var_0, var_1, var_2) {
  wait(60 * var_2);
  level thread[[var_0]](var_1);
}

get_next_player_weapon() {
  var_0 = self;
  var_0 endon("disconnect");

  for(;;) {
    var_0 waittill("weapons_used", var_1, var_2);

    if(!isDefined(level.zmb_challenges_on_zombie_dmg_funcs)) {
      continue;
    }
    foreach(var_4 in level.zmb_challenges_on_zombie_dmg_funcs) {
      if([[var_4._id_3F02]](var_4.param, var_1, var_2)) {
        if(_func_031(var_4._id_67E9)) {
          level notify(var_4._id_67E9);
          continue;
        }

        level thread[[var_4._id_67E9]]();
      }
    }
  }
}

is_lethal_or_tactical(var_0, var_1, var_2) {
  var_3 = self;

  if(!_func_0C0(var_1))
    var_1 = [var_1];

  foreach(var_9, var_5 in var_2) {
    var_6 = var_5[0];
    var_7 = var_5[1];
    var_6 = var_3 maps\mp\_events_z::set_last_checked_weapon(var_6);
    var_8 = 0;

    if(_id_0547::_id_585C(var_6))
      var_8 = 1;

    if(!var_8)
      return 1;
  }

  return 0;
}

is_headshot_class_exclusive(var_0, var_1, var_2) {
  var_3 = self;

  if(!_func_0C0(var_1))
    var_1 = [var_1];

  foreach(var_10, var_5 in var_2) {
    var_6 = var_5[0];
    var_7 = var_5[1];
    var_6 = var_3 maps\mp\_events_z::set_last_checked_weapon(var_6);
    var_8 = 0;
    var_9 = _id_0547::zm_get_weapon_class(var_6);

    if(is_challenge_headshot(var_3, var_6, var_7) && _id_0547::_id_5565(var_9, var_0))
      var_8 = 1;

    if(!var_8)
      return 1;
  }

  return 0;
}

wait_for_consecutive_waves_with_condition(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  var_9 = self;

  if(!isDefined(var_9.consecutive_wave_tracking_array))
    var_9.consecutive_wave_tracking_array = [];

  var_9 endon("disconnect");
  level endon(var_1);
  var_10 = spawnStruct();

  if(isDefined(var_2))
    register_zombie_killed_response(var_2, undefined, ::clear_player_wave_progress, var_1, var_3, var_4);

  var_10._id_005C = 0;
  var_10._id_4800 = var_0;
  var_10._id_502A = var_1;
  var_10.success_notification = var_1;
  var_10._id_2566 = 0;
  var_10.name = var_7;
  var_10.conditions_check_func = [::no_check_on_wave_break];
  var_10.add_player_progress_func = ::add_one_wave_survived;

  if(isDefined(var_3))
    var_10.valid_weapons = var_3;
  else
    var_10.valid_weapons = [];

  var_9.consecutive_wave_tracking_array[var_1] = var_10;

  if(isDefined(var_4))
    var_9 childthread try_clear_progress_with_conditions(var_4, var_1, var_8);

  while(var_9.consecutive_wave_tracking_array[var_1]._id_005C < var_0) {
    level waittill("round complete");
    try_add_progress_with_conditions([var_10], var_9 getcurrentweapon(), var_9, 1);
  }

  var_9.consecutive_wave_tracking_array[var_1]._id_2566 = 1;
  return challenge_completed(var_10, var_1);
}

wait_for_required_zombie_kills(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = self;
  var_7 endon("disconnect");

  if(!isDefined(var_7.special_zombie_kills_tracking_array))
    var_7.special_zombie_kills_tracking_array = [];

  var_8 = register_zombie_killed_response(var_2, ::add_one_zombie_kill, var_6, var_1, var_4, var_3);
  var_9 = spawnStruct();
  var_9._id_005C = 0;
  var_9._id_4800 = var_0;
  var_9._id_502A = var_1;
  var_9._id_7DB9 = var_8;
  var_9._id_2566 = 0;
  var_9.name = var_5;
  var_7.special_zombie_kills_tracking_array[var_1] = var_9;

  while(var_7.special_zombie_kills_tracking_array[var_1]._id_005C < var_0)
    wait 0.125;

  var_7.special_zombie_kills_tracking_array[var_1]._id_2566 = 1;
  return var_7 challenge_completed(var_9, var_1);
}

wait_for_gekocht_stage_challenge(var_0) {
  var_1 = common_scripts\utility::_id_46B5("stage_check_struct", "targetname");
  var_2 = _func_18E(var_1.target, "targetname");
  var_3 = 0;
  var_4 = 0.5;

  for(;;) {
    var_5 = _id_0547::_id_4090("zombie_sizzler");

    foreach(var_7 in var_5) {
      if(var_7 is_agent_on_stage(var_2)) {
        if(!isDefined(var_7.trophy_challenge_5_progress))
          var_7.trophy_challenge_5_progress = 0;
        else {
          var_7.trophy_challenge_5_progress = var_7.trophy_challenge_5_progress + var_4;

          if(var_7.trophy_challenge_5_progress >= var_0)
            return 1;
        }
      } else
        var_7.trophy_challenge_5_progress = 0;
    }

    wait(var_4);
  }
}

wait_for_players_zombie_geistkraft_challenge(var_0) {
  var_1 = self;
  var_1 endon("disconnect");

  if(!isDefined(var_1.zombie_geistkraft_challenge_array))
    var_1.zombie_geistkraft_challenge_array = [];

  while(var_1.zombie_geistkraft_challenge_array.size < var_0.size)
    wait 0.5;

  return 1;
}

add_zombie_type_to_geistkraft_challenge(var_0, var_1, var_2) {
  if(!isDefined(var_1) && isDefined(var_2) && isDefined(var_2.secondaryzombiecheck))
    var_1 = var_2.secondaryzombiecheck;

  if(!isDefined(var_1)) {
    return;
  }
  if(!common_scripts\utility::_id_0F79(var_0.zombie_geistkraft_challenge_array, var_1))
    var_0.zombie_geistkraft_challenge_array = common_scripts\utility::_id_0F6F(var_0.zombie_geistkraft_challenge_array, var_1);
}

is_agent_on_stage(var_0) {
  return self istouching(var_0);
}

challenge_completed(var_0, var_1, var_2) {
  var_3 = self;
  var_0._id_2566 = 1;
  return 1;
}

register_zombie_killed_response(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(!isDefined(level.zmb_zombie_killed_responses))
    level.zmb_zombie_killed_responses = [];

  if(isDefined(level.zmb_zombie_killed_responses[var_3])) {
    return;
  }
  if(!isDefined(var_4))
    var_4 = [];

  var_7 = _id_0547::_id_5565(var_4[0], "trap_zm_mp");

  foreach(var_9 in var_4) {
    var_10 = undefined;

    if(!var_7)
      var_10 = _id_0586::_id_078B(var_9);

    if((var_7 || isDefined(var_10)) && !_id_0547::_id_5565(var_9, "trap_zm_mp")) {
      if(!var_7)
        var_11 = maps\mp\_utility::_id_4431(var_10);
      else
        var_11 = var_9;

      var_4 = common_scripts\utility::_id_0F6F(var_4, var_11);
    }
  }

  var_13 = spawnStruct();

  if(_func_0C0(var_0))
    var_13.conditions_check_func = var_0;
  else
    var_13.conditions_check_func = [var_0];

  var_13.add_player_progress_func = var_1;
  var_13.clear_player_progress_func = var_2;
  var_13.success_notification = var_3;
  var_13.valid_weapons = var_4;
  var_13.valid_zombie_types = var_5;
  var_13._id_39D8 = 0;
  level.zmb_zombie_killed_responses[var_3] = var_13;
  return var_13;
}

try_clear_progress_with_conditions(var_0, var_1, var_2) {
  var_3 = self;
  var_4 = undefined;

  for(;;) {
    var_5 = 0;
    _id_0547::_id_A6F6();

    if(!isDefined(level.player) || !isDefined(level.players))
      waitframe();

    if(common_scripts\utility::_id_0F79(var_0, "all_players_in_common_zone")) {
      var_6 = _id_055A::_id_4562(level.players[0].origin);

      if(!isDefined(var_6)) {
        continue;
      }
      var_5 = should_reset_progress(var_3, var_4, var_2, var_6);
      var_4 = var_6;
    } else if(!var_3 _id_0547::player_validate_is_in_zones(var_0))
      var_5 = 1;

    if(var_5)
      clear_player_wave_progress(var_1, var_3);
  }
}

should_reset_progress(var_0, var_1, var_2, var_3) {
  if(!is_a_select_zone(var_2, var_3))
    return 1;

  if(!_id_0547::_id_5565(var_1, var_3))
    return 1;

  if(!var_0 _id_0547::player_validate_is_in_zones([var_3]))
    return 1;

  return 0;
}

is_a_select_zone(var_0, var_1) {
  return !isDefined(var_0) || common_scripts\utility::_id_0F79(var_0, var_1);
}

secret_challenges_get_zombie_killed_feedback(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  try_add_progress_with_conditions(level.zmb_zombie_killed_responses, var_4, var_1, undefined, self, var_6, var_0);
}

clear_player_wave_progress(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  foreach(var_1 in get_players_to_reset(var_0, var_1)) {
    if(isDefined(var_1.consecutive_wave_tracking_array[var_0]))
      var_1.consecutive_wave_tracking_array[var_0]._id_005C = 0;
  }
}

get_players_to_reset(var_0, var_1) {
  if(clear_everyones_progress(var_0))
    var_2 = level.players;
  else
    var_2 = [var_1];

  return var_2;
}

reset_progress_when_off_stage(var_0) {
  var_1 = self;
  var_2 = common_scripts\utility::_id_46B5("stage_check_struct", "targetname");
  var_3 = _func_18E(var_2.target, "targetname");

  for(;;) {
    _id_0547::_id_A6F6();

    if(!var_1 is_agent_on_stage(var_3))
      clear_player_wave_progress(var_0, var_1);
  }
}

clear_everyones_progress(var_0) {
  return common_scripts\utility::_id_562E(level.zmb_teamwork_required_challenges[var_0]);
}

player_using_valid_weapons_no_mercy(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  if(valid_attacker(var_4) && failed_to_use_correct_weapons(var_4, var_2, var_3)) {
    level notify(var_1);
    return 0;
  } else
    return 1;
}

player_using_valid_weapons(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  if(valid_attacker(var_4) && failed_to_use_correct_weapons(var_4, var_2, var_3))
    return 0;
  else
    return 1;
}

player_using_sniper_weapons(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  return isDefined(var_0) && common_scripts\utility::_id_0F79(var_5, var_0._id_0A4B) && _id_0547::zm_get_weapon_class(var_3) == "weapon_sniper" && is_challenge_headshot(var_4, var_3, var_7);
}

players_using_berlin_melee_weapons(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  var_2 = level.berlin_melee_weapons;

  if(valid_attacker(var_4) && failed_to_use_correct_weapons(var_4, var_2, var_3))
    clear_player_wave_progress(var_1, var_4);
}

player_killed_correct_zombie_type(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  var_8 = var_4;

  if(!isDefined(var_0))
    return 0;

  if(valid_attacker(var_4) && !failed_to_use_correct_weapons(var_4, var_2, var_3) && correct_zombie_type(var_5, var_0._id_0A4B))
    return 1;
  else
    return 0;
}

no_check_on_wave_break(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  return 1;
}

player_killed_zombie_in_zones(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  var_8 = var_4;

  if(!isDefined(var_0))
    return 0;

  return valid_attacker(var_4) && var_4 _id_0547::player_validate_is_in_zones(var_5);
}

valid_zombie_and_no_duplicate_melee_weapons(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  if(!isDefined(var_0))
    return 0;

  if(valid_attacker(var_4) && correct_zombie_type(var_5, var_0._id_0A4B) && is_new_melee_weapon(_func_337(_func_337(var_3, "_zm"), "hc"), var_2)) {
    level.wustling_melee_kill_types = common_scripts\utility::_id_0F6F(level.wustling_melee_kill_types, var_3);
    var_4.special_zombie_kills_tracking_array[var_1]._id_005C = level.wustling_melee_kill_types.size;
  }

  return 0;
}

is_new_melee_weapon(var_0, var_1) {
  if(!array_contains_subtring(var_1, var_0))
    return 0;

  if(!array_contains_subtring(level.wustling_melee_kill_types, var_0))
    return 1;

  return 0;
}

array_contains_subtring(var_0, var_1) {
  var_2 = 0;

  foreach(var_4 in var_0) {
    if(issubstr(var_4, var_1)) {
      var_2 = 1;
      break;
    }
  }

  return var_2;
}

correct_zombie_type(var_0, var_1) {
  return !isDefined(var_0) || common_scripts\utility::_id_0F79(var_0, var_1);
}

failed_to_use_correct_weapons(var_0, var_1, var_2) {
  return !var_0 is_using_correct_weapon(var_1, var_2);
}

valid_attacker(var_0) {
  return isDefined(var_0) && isPlayer(var_0);
}

is_using_correct_weapon(var_0, var_1) {
  if(issubstr(var_1, "shovel"))
    var_1 = "shovel_zm";

  return isDefined(var_1) && common_scripts\utility::_id_0F79(var_0, var_1);
}

try_add_progress_with_conditions(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(isDefined(var_6) && isDefined(var_6._id_9C92))
    var_2 = var_6._id_9C92._id_0117;

  if(!isPlayer(var_2)) {
    return;
  }
  var_7 = var_2;

  foreach(var_9 in var_0) {
    if(!isDefined(var_9.conditions_check_func) || common_scripts\utility::_id_562E(var_3) && skip_equipment_check_on_wave_break(var_9)) {
      continue;
    }
    var_10 = undefined;

    if(var_1 == "trap_zm_mp")
      var_10 = var_6._id_9CBB;

    var_11 = maps\mp\_utility::_id_4431(var_1);
    var_12 = [];

    foreach(var_14 in var_9.conditions_check_func) {
      var_15 = [[var_14]](var_4, var_9.success_notification, var_9.valid_weapons, maps\mp\_utility::_id_4431(var_1), var_2, var_9.valid_zombie_types, var_10, var_5);
      var_12 = common_scripts\utility::_id_0F6F(var_12, var_15);
    }

    var_17 = 1;

    foreach(var_19 in var_12) {
      if(_func_031(var_19)) {
        if(!isDefined(var_19))
          var_17 = 0;

        break;
      } else if(!common_scripts\utility::_id_562E(var_19)) {
        var_17 = 0;
        break;
      }
    }

    if(var_17) {
      if(isDefined(var_9.add_player_progress_func))
        [[var_9.add_player_progress_func]](var_7, var_9, var_12);

      continue;
    }

    if(isDefined(var_9.clear_player_progress_func))
      level thread[[var_9.clear_player_progress_func]](var_9.success_notification, var_7, var_0, var_1, var_2, var_3, var_4, var_5, var_6);
  }
}

add_one_zombie_kill(var_0, var_1, var_2) {
  var_0.special_zombie_kills_tracking_array[var_1.success_notification]._id_005C++;
}

add_one_wave_survived(var_0, var_1, var_2) {
  var_0.consecutive_wave_tracking_array[var_1.success_notification]._id_005C++;
}

skip_equipment_check_on_wave_break(var_0) {
  foreach(var_2 in var_0.valid_weapons) {
    if(_id_0547::_id_585C(maps\mp\_utility::_id_4431(var_2)) || _id_0547::_id_5565(var_2, "trap_zm_mp"))
      return 1;
  }

  return 0;
}

run_trophy_challenge(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  var_9 = spawnStruct();
  var_9._id_3F02 = var_1;
  var_9.successfunc = var_2;
  var_9.trophyflag = var_5;
  var_9._id_4800 = var_3;
  var_9._id_6E5C = var_4;
  var_9._id_6E55 = var_6;
  var_9.param2 = var_7;
  var_9.param3 = var_8;
  var_9.requiresteamwork = var_0;
  level thread maps\mp\_utility::_id_6F74(var_1, var_9, var_5);
}

run_trophy_challenge_internal(var_0, var_1, var_2) {
  level endon(var_2);
  level childthread[[var_0]](var_1);
  level waittill("forever");
}

monitor_players_using_melee_weapons(var_0) {
  var_1 = self;
  var_1 endon("disconnect");
  var_2 = var_1 wait_for_consecutive_waves_with_condition(var_0._id_4800, var_0.trophyflag, var_0._id_6E55, var_0._id_6E5C, undefined, 0, 1, var_0.trophyflag);
  var_0 handle_result(var_2, var_1);
}

monitor_players_zombie_kills(var_0) {
  var_1 = self;
  var_1 endon("disconnect");
  var_2 = var_0._id_6E5C[0];
  var_3 = var_0._id_6E5C[1];
  var_4 = var_1 wait_for_required_zombie_kills(var_0._id_4800, var_0.trophyflag, var_0._id_6E55, var_2, var_3, var_0.trophyflag);
  var_0 handle_result(var_4, var_1);
}

monitor_players_zombie_wustling_melee_kills(var_0) {
  var_1 = self;
  var_1 endon("disconnect");
  var_2 = var_0._id_6E5C[0];
  var_3 = var_0._id_6E5C[1];
  level.wustling_melee_kill_types = [];
  var_4 = var_1 wait_for_required_zombie_kills(var_0._id_4800, var_0.trophyflag, var_0._id_6E55, var_2, var_3, var_0.trophyflag);
  var_0 handle_result(var_4, var_1);
}

gekocht_stage_challenge(var_0) {
  var_1 = self;
  var_1 endon("disconnect");
  var_2 = wait_for_gekocht_stage_challenge(var_0._id_4800);
  var_0 handle_result(var_2, var_1);
}

monitor_players_zombie_geistkraft_collections(var_0) {
  var_1 = self;
  var_1 endon("disconnect");
  var_2 = wait_for_players_zombie_geistkraft_challenge(var_0._id_6E5C);
  var_0 handle_result(var_2, var_1);
}

monitor_players_survival_in_zone(var_0) {
  if(common_scripts\utility::_id_562E(var_0.requiresteamwork))
    level.zmb_teamwork_required_challenges[var_0.trophyflag] = 1;

  var_1 = self;
  var_1 endon("disconnect");
  var_2 = var_1 wait_for_consecutive_waves_with_condition(var_0._id_4800, var_0.trophyflag, var_0._id_6E55, undefined, var_0._id_6E5C, 0, 1, var_0.trophyflag, var_0.param2);
  var_0 handle_result(var_2, var_1);
  return var_2;
}

clear_player_zombie_progress_on_sizzler_no_headshot(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  if(_id_0547::_id_5565(var_6._id_0A4B, "zombie_sizzler"))
    clear_player_zombie_progress(var_0, var_1);
}

clear_player_zombie_progress(var_0, var_1) {
  foreach(var_1 in get_players_to_reset(var_0, var_1)) {
    if(isDefined(var_1.special_zombie_kills_tracking_array[var_0]))
      var_1.special_zombie_kills_tracking_array[var_0]._id_005C = 0;
  }
}

handle_result(var_0, var_1) {
  var_2 = self;

  if(common_scripts\utility::_id_562E(var_0)) {
    if(isDefined(var_2.successfunc))
      [[var_2.successfunc]](var_1);
  }
}

wait_for_round(var_0) {
  while(!isDefined(level._id_A980))
    waitframe();

  while(level._id_A980 < var_0)
    level waittill("round complete");
}

players_are_on_stage() {}

return_trap_name(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  if(!isDefined(var_6))
    return 0;
  else
    return var_6;
}

add_zombie_kill_to_trap_kill_array(var_0, var_1, var_2) {
  var_3 = level.trap_kill_trackers[var_1.success_notification].trap_progress_tracker[var_2[0]];

  if(isDefined(var_3))
    var_3._id_005C++;
}

enforce_zombie_headshots(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  return is_challenge_headshot(var_4, var_3, var_7);
}

is_challenge_headshot(var_0, var_1, var_2) {
  if(!isDefined(var_0) || !isPlayer(var_0))
    return 1;

  if(!isDefined(var_1))
    return 1;

  if(!isDefined(var_2) || var_2 == "none")
    return 1;

  if(_id_0586::_id_AB31(var_2))
    return 1;

  return 0;
}

reset_trap_kill_array(var_0) {
  foreach(var_2 in level.trap_kill_trackers[var_0].trap_progress_tracker)
  var_2._id_005C = 0;
}

all_traps_full(var_0, var_1) {
  foreach(var_3 in var_0.trap_progress_tracker) {
    if(var_3.name == "trap_zm_mp") {
      continue;
    }
    if(var_3._id_005C < var_1)
      return 0;
  }

  return 1;
}

kill_hidden_challenge(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  level notify(var_0);
}

fail_on_another_player_joined(var_0, var_1, var_2) {
  var_3 = undefined;

  while(!isDefined(var_3) || _id_0547::_id_5565(var_3, var_0))
    level waittill("connected", var_3);

  level notify(var_1 + var_2);
}