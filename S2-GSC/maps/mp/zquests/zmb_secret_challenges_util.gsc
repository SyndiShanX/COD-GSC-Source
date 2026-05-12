/**********************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\zquests\zmb_secret_challenges_util.gsc
**********************************************************/

init_challenges_utility() {
  if(!isDefined(level.zmb_zombie_killed_responses)) {
    level.zmb_zombie_killed_responses = [];
  }

  level.zmb_challenges_on_entered_laststand_funcs = [];
  level.zmb_challenges_on_dmg_funcs = [];
  level.zmb_events_purchase_notify = "player_purchase_challenge_";
  level.zmb_events_consumables_notify = "player_challenges_consumable_use";
  lib_0547::func_7BA9(::secret_challenges_get_zombie_killed_feedback);
  level thread maps\mp\_utility::func_6F74(::report_player_entered_last_stand);
  level thread maps\mp\_utility::func_6F74(::get_next_player_weapon);
  level.zmb_teamwork_required_challenges = [];
}

report_player_damaged(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09) {
  foreach(var_0B in level.zmb_challenges_on_dmg_funcs) {
    if(isDefined(var_0B.check) && ![[var_0B.check]](param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09)) {
      continue;
    }

    level thread[[var_0B.var_3F02]](var_0B.param);
  }
}

agent_is_zombie(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09) {
  return isDefined(param_01) && !isPlayer(param_01) && isDefined(param_01.var_A4B);
}

register_on_player_down_func(param_00, param_01) {
  var_02 = spawnStruct();
  var_02.var_3F02 = param_00;
  var_02.param = param_01;
  level.zmb_challenges_on_entered_laststand_funcs = common_scripts\utility::func_F6F(level.zmb_challenges_on_entered_laststand_funcs, var_02);
}

report_player_entered_last_stand() {
  for(;;) {
    var_00 = self;
    var_00 common_scripts\utility::knock_off_battery("enter_last_stand");
    foreach(var_02 in level.zmb_challenges_on_entered_laststand_funcs) {
      level thread[[var_02.var_3F02]](var_02.param);
    }
  }
}

register_on_player_dmg_func(param_00, param_01, param_02) {
  var_03 = spawnStruct();
  var_03.var_3F02 = param_00;
  var_03.param = param_01;
  var_03.check = param_02;
  level.zmb_challenges_on_dmg_funcs = common_scripts\utility::func_F6F(level.zmb_challenges_on_dmg_funcs, var_03);
}

register_on_flag_set_func(param_00, param_01, param_02) {
  common_scripts\utility::func_3CA3(param_02);
  level thread[[param_00]](param_01);
}

register_on_notify_set_func(param_00, param_01, param_02) {
  for(var_03 = 0; var_03 < param_02.size - 1; var_03 = var_03 + 2) {
    param_02[var_03] childthread run_func_on_notify(param_00, param_01, param_02[var_03 + 1]);
  }
}

register_on_zombie_dmg_func(param_00, param_01, param_02) {
  if(!isDefined(level.zmb_challenges_on_zombie_dmg_funcs)) {
    level.zmb_challenges_on_zombie_dmg_funcs = [];
  }

  var_03 = spawnStruct();
  var_03.var_3F02 = param_00;
  var_03.param = param_01;
  var_03.var_67E9 = param_02;
  level.zmb_challenges_on_zombie_dmg_funcs = common_scripts\utility::func_F6F(level.zmb_challenges_on_zombie_dmg_funcs, var_03);
}

run_func_on_notify(param_00, param_01, param_02) {
  self waittill(param_02);
  level thread[[param_00]](param_01);
}

register_on_minute_reached_func(param_00, param_01, param_02) {
  wait(60 * param_02);
  level thread[[param_00]](param_01);
}

get_next_player_weapon() {
  var_00 = self;
  var_00 endon("disconnect");
  for(;;) {
    var_00 waittill("weapons_used", var_01, var_02);
    if(!isDefined(level.zmb_challenges_on_zombie_dmg_funcs)) {
      continue;
    }

    foreach(var_04 in level.zmb_challenges_on_zombie_dmg_funcs) {
      if([[var_04.var_3F02]](var_04.param, var_01, var_02)) {
        if(isstring(var_04.var_67E9)) {
          level notify(var_04.var_67E9);
          continue;
        }

        level thread[[var_04.var_67E9]]();
      }
    }
  }
}

is_lethal_or_tactical(param_00, param_01, param_02) {
  var_03 = self;
  if(!isarray(param_01)) {
    param_01 = [param_01];
  }

  foreach(var_05 in param_02) {
    var_06 = var_05[0];
    var_07 = var_05[1];
    var_06 = var_03 maps\mp\_events_z::set_last_checked_weapon(var_06);
    var_08 = 0;
    if(lib_0547::func_585C(var_06)) {
      var_08 = 1;
    }

    if(!var_08) {
      return 1;
    }
  }

  return 0;
}

is_headshot_class_exclusive(param_00, param_01, param_02) {
  var_03 = self;
  if(!isarray(param_01)) {
    param_01 = [param_01];
  }

  foreach(var_05 in param_02) {
    var_06 = var_05[0];
    var_07 = var_05[1];
    var_06 = var_03 maps\mp\_events_z::set_last_checked_weapon(var_06);
    var_08 = 0;
    var_09 = lib_0547::zm_get_weapon_class(var_06);
    if(is_challenge_headshot(var_03, var_06, var_07) && lib_0547::func_5565(var_09, param_00)) {
      var_08 = 1;
    }

    if(!var_08) {
      return 1;
    }
  }

  return 0;
}

wait_for_consecutive_waves_with_condition(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08) {
  var_09 = self;
  if(!isDefined(var_09.consecutive_wave_tracking_array)) {
    var_09.consecutive_wave_tracking_array = [];
  }

  var_09 endon("disconnect");
  level endon(param_01);
  var_0A = spawnStruct();
  if(isDefined(param_02)) {
    register_zombie_killed_response(param_02, undefined, ::clear_player_wave_progress, param_01, param_03, param_04);
  }

  var_0A.var_5C = 0;
  var_0A.var_4800 = param_00;
  var_0A.var_502A = param_01;
  var_0A.success_notification = param_01;
  var_0A.var_2566 = 0;
  var_0A.var_109 = param_07;
  var_0A.conditions_check_func = [::no_check_on_wave_break];
  var_0A.add_player_progress_func = ::add_one_wave_survived;
  if(isDefined(param_03)) {
    var_0A.valid_weapons = param_03;
  } else {
    var_0A.valid_weapons = [];
  }

  var_09.consecutive_wave_tracking_array[param_01] = var_0A;
  if(isDefined(param_04)) {
    var_09 childthread try_clear_progress_with_conditions(param_04, param_01, param_08);
  }

  while(var_09.consecutive_wave_tracking_array[param_01].var_5C < param_00) {
    level waittill("round complete");
    try_add_progress_with_conditions([var_0A], var_09 getcurrentweapon(), var_09, 1);
  }

  var_09.consecutive_wave_tracking_array[param_01].var_2566 = 1;
  return challenge_completed(var_0A, param_01);
}

wait_for_required_zombie_kills(param_00, param_01, param_02, param_03, param_04, param_05, param_06) {
  var_07 = self;
  var_07 endon("disconnect");
  if(!isDefined(var_07.special_zombie_kills_tracking_array)) {
    var_07.special_zombie_kills_tracking_array = [];
  }

  var_08 = register_zombie_killed_response(param_02, ::add_one_zombie_kill, param_06, param_01, param_04, param_03);
  var_09 = spawnStruct();
  var_09.var_5C = 0;
  var_09.var_4800 = param_00;
  var_09.var_502A = param_01;
  var_09.var_7DB9 = var_08;
  var_09.var_2566 = 0;
  var_09.var_109 = param_05;
  var_07.special_zombie_kills_tracking_array[param_01] = var_09;
  while(var_07.special_zombie_kills_tracking_array[param_01].var_5C < param_00) {
    wait(0.125);
  }

  var_07.special_zombie_kills_tracking_array[param_01].var_2566 = 1;
  return var_07 challenge_completed(var_09, param_01);
}

wait_for_gekocht_stage_challenge(param_00) {
  var_01 = common_scripts\utility::func_46B5("stage_check_struct", "targetname");
  var_02 = getent(var_01.var_1A2, "targetname");
  var_03 = 0;
  var_04 = 0.5;
  for(;;) {
    var_05 = lib_0547::func_4090("zombie_sizzler");
    foreach(var_07 in var_05) {
      if(var_07 is_agent_on_stage(var_02)) {
        if(!isDefined(var_07.trophy_challenge_5_progress)) {
          var_07.trophy_challenge_5_progress = 0;
        } else {
          var_07.trophy_challenge_5_progress = var_07.trophy_challenge_5_progress + var_04;
          if(var_07.trophy_challenge_5_progress >= param_00) {
            return 1;
          }
        }

        continue;
      }

      var_07.trophy_challenge_5_progress = 0;
    }

    wait(var_04);
  }
}

wait_for_players_zombie_geistkraft_challenge(param_00) {
  var_01 = self;
  var_01 endon("disconnect");
  if(!isDefined(var_01.zombie_geistkraft_challenge_array)) {
    var_01.zombie_geistkraft_challenge_array = [];
  }

  while(var_01.zombie_geistkraft_challenge_array.size < param_00.size) {
    wait(0.5);
  }

  return 1;
}

add_zombie_type_to_geistkraft_challenge(param_00, param_01, param_02) {
  if(!isDefined(param_01) && isDefined(param_02) && isDefined(param_02.secondaryzombiecheck)) {
    param_01 = param_02.secondaryzombiecheck;
  }

  if(!isDefined(param_01)) {
    return;
  }

  if(!common_scripts\utility::func_F79(param_00.zombie_geistkraft_challenge_array, param_01)) {
    param_00.zombie_geistkraft_challenge_array = common_scripts\utility::func_F6F(param_00.zombie_geistkraft_challenge_array, param_01);
  }
}

is_agent_on_stage(param_00) {
  return self istouching(param_00);
}

challenge_completed(param_00, param_01, param_02) {
  var_03 = self;
  param_00.var_2566 = 1;
  return 1;
}

register_zombie_killed_response(param_00, param_01, param_02, param_03, param_04, param_05, param_06) {
  if(!isDefined(level.zmb_zombie_killed_responses)) {
    level.zmb_zombie_killed_responses = [];
  }

  if(isDefined(level.zmb_zombie_killed_responses[param_03])) {
    return;
  }

  if(!isDefined(param_04)) {
    param_04 = [];
  }

  var_07 = lib_0547::func_5565(param_04[0], "trap_zm_mp");
  foreach(var_09 in param_04) {
    var_0A = undefined;
    if(!var_07) {
      var_0A = lib_0586::func_78B(var_09);
    }

    if((var_07 || isDefined(var_0A)) && !lib_0547::func_5565(var_09, "trap_zm_mp")) {
      if(!var_07) {
        var_0B = maps\mp\_utility::func_4431(var_0A);
      } else {
        var_0B = var_0A;
      }

      param_04 = common_scripts\utility::func_F6F(param_04, var_0B);
    }
  }

  var_0D = spawnStruct();
  if(isarray(param_00)) {
    var_0D.conditions_check_func = param_00;
  } else {
    var_0D.conditions_check_func = [param_00];
  }

  var_0D.add_player_progress_func = param_01;
  var_0D.clear_player_progress_func = param_02;
  var_0D.success_notification = param_03;
  var_0D.valid_weapons = param_04;
  var_0D.valid_zombie_types = param_05;
  var_0D.var_39D8 = 0;
  level.zmb_zombie_killed_responses[param_03] = var_0D;
  return var_0D;
}

try_clear_progress_with_conditions(param_00, param_01, param_02) {
  var_03 = self;
  var_04 = undefined;
  for(;;) {
    var_05 = 0;
    lib_0547::func_A6F6();
    if(!isDefined(level.var_721C) || !isDefined(level.var_744A)) {
      wait 0.05;
    }

    if(common_scripts\utility::func_F79(param_00, "all_players_in_common_zone")) {
      var_06 = lib_055A::func_4562(level.var_744A[0].var_116);
      if(!isDefined(var_06)) {
        continue;
      }

      var_05 = should_reset_progress(var_03, var_04, param_02, var_06);
      var_04 = var_06;
    } else if(!var_03 lib_0547::player_validate_is_in_zones(param_00)) {
      var_05 = 1;
    }

    if(var_05) {
      clear_player_wave_progress(param_01, var_03);
    }
  }
}

should_reset_progress(param_00, param_01, param_02, param_03) {
  if(!is_a_select_zone(param_02, param_03)) {
    return 1;
  }

  if(!lib_0547::func_5565(param_01, param_03)) {
    return 1;
  }

  if(!param_00 lib_0547::player_validate_is_in_zones([param_03])) {
    return 1;
  }

  return 0;
}

is_a_select_zone(param_00, param_01) {
  return !isDefined(param_00) || common_scripts\utility::func_F79(param_00, param_01);
}

secret_challenges_get_zombie_killed_feedback(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08) {
  try_add_progress_with_conditions(level.zmb_zombie_killed_responses, param_04, param_01, undefined, self, param_06, param_00);
}

clear_player_wave_progress(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08) {
  foreach(param_01 in get_players_to_reset(param_00, param_01)) {
    if(isDefined(param_01.consecutive_wave_tracking_array[param_00])) {
      param_01.consecutive_wave_tracking_array[param_00].var_5C = 0;
    }
  }
}

get_players_to_reset(param_00, param_01) {
  if(clear_everyones_progress(param_00)) {
    var_02 = level.var_744A;
  } else {
    var_02 = [var_02];
  }

  return var_02;
}

reset_progress_when_off_stage(param_00) {
  var_01 = self;
  var_02 = common_scripts\utility::func_46B5("stage_check_struct", "targetname");
  var_03 = getent(var_02.var_1A2, "targetname");
  for(;;) {
    lib_0547::func_A6F6();
    if(!var_01 is_agent_on_stage(var_03)) {
      clear_player_wave_progress(param_00, var_01);
    }
  }
}

clear_everyones_progress(param_00) {
  return common_scripts\utility::func_562E(level.zmb_teamwork_required_challenges[param_00]);
}

player_using_valid_weapons_no_mercy(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07) {
  if(valid_attacker(param_04) && failed_to_use_correct_weapons(param_04, param_02, param_03)) {
    level notify(param_01);
    return 0;
  }

  return 1;
}

player_using_valid_weapons(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07) {
  if(valid_attacker(param_04) && failed_to_use_correct_weapons(param_04, param_02, param_03)) {
    return 0;
  }

  return 1;
}

player_using_sniper_weapons(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07) {
  return isDefined(param_00) && common_scripts\utility::func_F79(param_05, param_00.var_A4B) && lib_0547::zm_get_weapon_class(param_03) == "weapon_sniper" && is_challenge_headshot(param_04, param_03, param_07);
}

players_using_berlin_melee_weapons(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07) {
  param_02 = level.berlin_melee_weapons;
  if(valid_attacker(param_04) && failed_to_use_correct_weapons(param_04, param_02, param_03)) {
    clear_player_wave_progress(param_01, param_04);
  }
}

player_killed_correct_zombie_type(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07) {
  var_08 = param_04;
  if(!isDefined(param_00)) {
    return 0;
  }

  if(valid_attacker(param_04) && !failed_to_use_correct_weapons(param_04, param_02, param_03) && correct_zombie_type(param_05, param_00.var_A4B)) {
    return 1;
  }

  return 0;
}

no_check_on_wave_break(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07) {
  return 1;
}

player_killed_zombie_in_zones(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07) {
  var_08 = param_04;
  if(!isDefined(param_00)) {
    return 0;
  }

  return valid_attacker(param_04) && param_04 lib_0547::player_validate_is_in_zones(param_05);
}

valid_zombie_and_no_duplicate_melee_weapons(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07) {
  if(!isDefined(param_00)) {
    return 0;
  }

  if(valid_attacker(param_04) && correct_zombie_type(param_05, param_00.var_A4B) && is_new_melee_weapon(function_0337(function_0337(param_03, "_zm"), "hc"), param_02)) {
    level.wustling_melee_kill_types = common_scripts\utility::func_F6F(level.wustling_melee_kill_types, param_03);
    param_04.special_zombie_kills_tracking_array[param_01].var_5C = level.wustling_melee_kill_types.size;
  }

  return 0;
}

is_new_melee_weapon(param_00, param_01) {
  if(!array_contains_subtring(param_01, param_00)) {
    return 0;
  }

  if(!array_contains_subtring(level.wustling_melee_kill_types, param_00)) {
    return 1;
  }

  return 0;
}

array_contains_subtring(param_00, param_01) {
  var_02 = 0;
  foreach(var_04 in param_00) {
    if(issubstr(var_04, param_01)) {
      var_02 = 1;
      break;
    }
  }

  return var_02;
}

correct_zombie_type(param_00, param_01) {
  return !isDefined(param_00) || common_scripts\utility::func_F79(param_00, param_01);
}

failed_to_use_correct_weapons(param_00, param_01, param_02) {
  return !param_00 is_using_correct_weapon(param_01, param_02);
}

valid_attacker(param_00) {
  return isDefined(param_00) && isPlayer(param_00);
}

is_using_correct_weapon(param_00, param_01) {
  if(issubstr(param_01, "shovel")) {
    param_01 = "shovel_zm";
  }

  return isDefined(param_01) && common_scripts\utility::func_F79(param_00, param_01);
}

try_add_progress_with_conditions(param_00, param_01, param_02, param_03, param_04, param_05, param_06) {
  if(isDefined(param_06) && isDefined(param_06.var_9C92)) {
    param_02 = param_06.var_9C92.var_117;
  }

  if(!isPlayer(param_02)) {
    return;
  }

  var_07 = param_02;
  foreach(var_09 in param_00) {
    if(!isDefined(var_09.conditions_check_func) || common_scripts\utility::func_562E(param_03) && skip_equipment_check_on_wave_break(var_09)) {
      continue;
    }

    var_0A = undefined;
    if(param_01 == "trap_zm_mp") {
      var_0A = param_06.var_9CBB;
    }

    var_0B = maps\mp\_utility::func_4431(param_01);
    var_0C = [];
    foreach(var_0E in var_09.conditions_check_func) {
      var_0F = [[var_0E]](param_04, var_09.success_notification, var_09.valid_weapons, maps\mp\_utility::func_4431(param_01), param_02, var_09.valid_zombie_types, var_0A, param_05);
      var_0C = common_scripts\utility::func_F6F(var_0C, var_0F);
    }

    var_11 = 1;
    foreach(var_13 in var_0C) {
      if(isstring(var_13)) {
        if(!isDefined(var_13)) {
          var_11 = 0;
        }

        break;
      } else if(!common_scripts\utility::func_562E(var_13)) {
        var_11 = 0;
        break;
      }
    }

    if(var_11) {
      if(isDefined(var_09.add_player_progress_func)) {
        [[var_09.add_player_progress_func]](var_07, var_09, var_0C);
      }

      continue;
    }

    if(isDefined(var_09.clear_player_progress_func)) {
      level thread[[var_09.clear_player_progress_func]](var_09.success_notification, var_07, param_00, param_01, param_02, param_03, param_04, param_05, param_06);
    }
  }
}

add_one_zombie_kill(param_00, param_01, param_02) {
  param_00.special_zombie_kills_tracking_array[param_01.success_notification].var_5C++;
}

add_one_wave_survived(param_00, param_01, param_02) {
  param_00.consecutive_wave_tracking_array[param_01.success_notification].var_5C++;
}

skip_equipment_check_on_wave_break(param_00) {
  foreach(var_02 in param_00.valid_weapons) {
    if(lib_0547::func_585C(maps\mp\_utility::func_4431(var_02)) || lib_0547::func_5565(var_02, "trap_zm_mp")) {
      return 1;
    }
  }

  return 0;
}

run_trophy_challenge(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08) {
  var_09 = spawnStruct();
  var_09.var_3F02 = param_01;
  var_09.successfunc = param_02;
  var_09.trophyflag = param_05;
  var_09.var_4800 = param_03;
  var_09.var_6E5C = param_04;
  var_09.var_6E55 = param_06;
  var_09.param2 = param_07;
  var_09.param3 = param_08;
  var_09.requiresteamwork = param_00;
  level thread maps\mp\_utility::func_6F74(param_01, var_09, param_05);
}

run_trophy_challenge_internal(param_00, param_01, param_02) {
  level endon(param_02);
  level childthread[[param_00]](param_01);
  level waittill("forever");
}

monitor_players_using_melee_weapons(param_00) {
  var_01 = self;
  var_01 endon("disconnect");
  var_02 = var_01 wait_for_consecutive_waves_with_condition(param_00.var_4800, param_00.trophyflag, param_00.var_6E55, param_00.var_6E5C, undefined, 0, 1, param_00.trophyflag);
  param_00 handle_result(var_02, var_01);
}

monitor_players_zombie_kills(param_00) {
  var_01 = self;
  var_01 endon("disconnect");
  var_02 = param_00.var_6E5C[0];
  var_03 = param_00.var_6E5C[1];
  var_04 = var_01 wait_for_required_zombie_kills(param_00.var_4800, param_00.trophyflag, param_00.var_6E55, var_02, var_03, param_00.trophyflag);
  param_00 handle_result(var_04, var_01);
}

monitor_players_zombie_wustling_melee_kills(param_00) {
  var_01 = self;
  var_01 endon("disconnect");
  var_02 = param_00.var_6E5C[0];
  var_03 = param_00.var_6E5C[1];
  level.wustling_melee_kill_types = [];
  var_04 = var_01 wait_for_required_zombie_kills(param_00.var_4800, param_00.trophyflag, param_00.var_6E55, var_02, var_03, param_00.trophyflag);
  param_00 handle_result(var_04, var_01);
}

gekocht_stage_challenge(param_00) {
  var_01 = self;
  var_01 endon("disconnect");
  var_02 = wait_for_gekocht_stage_challenge(param_00.var_4800);
  param_00 handle_result(var_02, var_01);
}

monitor_players_zombie_geistkraft_collections(param_00) {
  var_01 = self;
  var_01 endon("disconnect");
  var_02 = wait_for_players_zombie_geistkraft_challenge(param_00.var_6E5C);
  param_00 handle_result(var_02, var_01);
}

monitor_players_survival_in_zone(param_00) {
  if(common_scripts\utility::func_562E(param_00.requiresteamwork)) {
    level.zmb_teamwork_required_challenges[param_00.trophyflag] = 1;
  }

  var_01 = self;
  var_01 endon("disconnect");
  var_02 = var_01 wait_for_consecutive_waves_with_condition(param_00.var_4800, param_00.trophyflag, param_00.var_6E55, undefined, param_00.var_6E5C, 0, 1, param_00.trophyflag, param_00.param2);
  param_00 handle_result(var_02, var_01);
  return var_02;
}

clear_player_zombie_progress_on_sizzler_no_headshot(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08) {
  if(lib_0547::func_5565(param_06.var_A4B, "zombie_sizzler")) {
    clear_player_zombie_progress(param_00, param_01);
  }
}

clear_player_zombie_progress(param_00, param_01) {
  foreach(param_01 in get_players_to_reset(param_00, param_01)) {
    if(isDefined(param_01.special_zombie_kills_tracking_array[param_00])) {
      param_01.special_zombie_kills_tracking_array[param_00].var_5C = 0;
    }
  }
}

handle_result(param_00, param_01) {
  var_02 = self;
  if(common_scripts\utility::func_562E(param_00)) {
    if(isDefined(var_02.successfunc)) {
      [[var_02.successfunc]](param_01);
    }
  }
}

wait_for_round(param_00) {
  while(!isDefined(level.var_A980)) {
    wait 0.05;
  }

  while(level.var_A980 < param_00) {
    level waittill("round complete");
  }
}

players_are_on_stage() {}

return_trap_name(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07) {
  if(!isDefined(param_06)) {
    return 0;
  }

  return param_06;
}

add_zombie_kill_to_trap_kill_array(param_00, param_01, param_02) {
  var_03 = level.trap_kill_trackers[param_01.success_notification].trap_progress_tracker[param_02[0]];
  if(isDefined(var_03)) {
    var_03.var_5C++;
  }
}

enforce_zombie_headshots(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07) {
  return is_challenge_headshot(param_04, param_03, param_07);
}

is_challenge_headshot(param_00, param_01, param_02) {
  if(!isDefined(param_00) || !isPlayer(param_00)) {
    return 1;
  }

  if(!isDefined(param_01)) {
    return 1;
  }

  if(!isDefined(param_02) || param_02 == "none") {
    return 1;
  }

  if(lib_0586::func_AB31(param_02)) {
    return 1;
  }

  return 0;
}

reset_trap_kill_array(param_00) {
  foreach(var_02 in level.trap_kill_trackers[param_00].trap_progress_tracker) {
    var_02.var_5C = 0;
  }
}

all_traps_full(param_00, param_01) {
  foreach(var_03 in param_00.trap_progress_tracker) {
    if(var_03.var_109 == "trap_zm_mp") {
      continue;
    }

    if(var_03.var_5C < param_01) {
      return 0;
    }
  }

  return 1;
}

kill_hidden_challenge(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08) {
  level notify(param_00);
}

fail_on_another_player_joined(param_00, param_01, param_02) {
  var_03 = undefined;
  while(!isDefined(var_03) || lib_0547::func_5565(var_03, param_00)) {
    level waittill("connected", var_03);
  }

  level notify(param_01 + param_02);
}