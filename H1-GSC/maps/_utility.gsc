/********************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\_utility.gsc
********************************/

set_hudoutline(var_0, var_1) {
  var_2 = undefined;
  var_0 = tolower(var_0);
  var_3["friendly"] = 3;
  var_3["enemy"] = 4;
  var_3["objective"] = 5;
  var_3["neutral"] = 0;
  var_2 = var_3[var_0];
  self hudoutlineenable(var_2, var_1);
}

is_coop() {
  if(issplitscreen() || getdvar("coop") == "1")
    return 1;

  return 0;
}

is_coop_online() {
  if(issplitscreen())
    return 0;

  if(!is_coop())
    return 0;

  return 1;
}

is_player_down(var_0) {
  if(var_0 ent_flag_exist("laststand_downed"))
    return var_0 ent_flag("laststand_downed");

  if(isdefined(var_0.laststand))
    return var_0.laststand;

  return !isalive(var_0);
}

is_player_down_and_out(var_0) {
  if(!isdefined(var_0.down_part2_proc_ran))
    return 0;

  return var_0.down_part2_proc_ran;
}

killing_will_down(var_0) {
  if(laststand_enabled()) {
    if(isdefined(level.laststand_kill_will_down_func))
      return var_0[[level.laststand_kill_will_down_func]]();
  }

  return 0;
}

is_survival() {
  return is_specialop() && getdvarint("so_survival") > 0;
}

laststand_enabled() {
  return isdefined(level.laststand_type) && level.laststand_type > 0;
}

is_specialop() {
  return getdvarint("specialops") >= 1;
}

convert_to_time_string(var_0, var_1) {
  var_2 = "";

  if(var_0 < 0)
    var_2 = var_2 + "-";

  var_0 = round_float(var_0, 1, 0);
  var_3 = var_0 * 100;
  var_3 = int(var_3);
  var_3 = abs(var_3);
  var_4 = var_3 / 6000;
  var_4 = int(var_4);
  var_2 = var_2 + var_4;
  var_5 = var_3 / 100;
  var_5 = int(var_5);
  var_5 = var_5 - var_4 * 60;

  if(var_5 < 10)
    var_2 = var_2 + (":0" + var_5);
  else
    var_2 = var_2 + (":" + var_5);

  if(isdefined(var_1) && var_1) {
    var_6 = var_3;
    var_6 = var_6 - var_4 * 6000;
    var_6 = var_6 - var_5 * 100;
    var_6 = int(var_6 / 10);
    var_2 = var_2 + ("." + var_6);
  }

  return var_2;
}

round_float(var_0, var_1, var_2) {
  var_1 = int(var_1);

  if(var_1 < 0 || var_1 > 4)
    return var_0;

  var_3 = 1;

  for (var_4 = 1; var_4 <= var_1; var_4++)
    var_3 = var_3 * 10;

  var_5 = var_0 * var_3;

  if(!isdefined(var_2) || var_2)
    var_5 = floor(var_5);
  else
    var_5 = ceil(var_5);

  var_0 = var_5 / var_3;
  return var_0;
}

round_millisec_on_sec(var_0, var_1, var_2) {
  var_3 = var_0 / 1000;
  var_3 = round_float(var_3, var_1, var_2);
  var_0 = var_3 * 1000;
  return int(var_0);
}

can_set_vision_set(var_0) {
  return !isdefined(level.can_change_vision_set_function) || [[level.can_change_vision_set_function]](var_0);
}

set_vision_set(var_0, var_1, var_2) {
  if(isdefined(level.pre_set_vision_set_function))
    [[level.pre_set_vision_set_function]](var_0);

  if(!isdefined(var_2))
    var_2 = 0;

  if(!var_2 && !can_set_vision_set(var_0)) {
    return;
  }
  if(maps\_utility_code::init_vision_set(var_0)) {
    return;
  }
  if(!isdefined(var_1))
    var_1 = 1;

  if(isplayer(self))
    self visionsetnakedforplayer(var_0, var_1);
  else {
    visionsetnaked(var_0, var_1);
    setdvar("vision_set_current", var_0);
  }
}

set_vision_set_player(var_0, var_1) {
  set_vision_set(var_0, var_1);
}

can_set_light_set(var_0) {
  return !isdefined(level.can_change_light_set_function) || [[level.can_change_light_set_function]](var_0);
}

set_light_set_player(var_0, var_1) {
  if(isdefined(level.pre_set_light_set_function))
    [[level.pre_set_light_set_function]](var_0);

  if(!isdefined(var_1))
    var_1 = 0;

  if(!var_1 && !can_set_light_set(var_0)) {
    return;
  }
  level.player.current_lightset = var_0;
  self lightsetforplayer(level.player.current_lightset);
}

sun_light_fade(var_0, var_1, var_2) {
  var_2 = int(var_2 * 20);
  var_3 = [];

  for (var_4 = 0; var_4 < 3; var_4++)
    var_3[var_4] = (var_0[var_4] - var_1[var_4]) / var_2;

  var_5 = [];

  for (var_4 = 0; var_4 < var_2; var_4++) {
    wait 0.05;

    for (var_6 = 0; var_6 < 3; var_6++)
      var_5[var_6] = var_0[var_6] - var_3[var_6] * var_4;

    setsunlight(var_5[0], var_5[1], var_5[2]);
  }

  setsunlight(var_1[0], var_1[1], var_1[2]);
}

ent_flag_wait(var_0) {
  while (isdefined(self) && !self.ent_flag[var_0])
    self waittill(var_0);
}

ent_flag_wait_vehicle_node(var_0) {
  while (isdefined(self) && !self.ent_flag[var_0])
    self waittill(var_0);
}

ent_flag_wait_either(var_0, var_1) {
  while (isdefined(self)) {
    if(ent_flag(var_0)) {
      return;
    }
    if(ent_flag(var_1)) {
      return;
    }
    common_scripts\utility::waittill_either(var_0, var_1);
  }
}

ent_flag_wait_or_timeout(var_0, var_1) {
  var_2 = gettime();

  while (isdefined(self)) {
    if(self.ent_flag[var_0]) {
      break;
    }

    if(gettime() >= var_2 + var_1 * 1000) {
      break;
    }

    maps\_utility_code::ent_wait_for_flag_or_time_elapses(var_0, var_1);
  }
}

ent_flag_waitopen(var_0) {
  while (isdefined(self) && self.ent_flag[var_0])
    self waittill(var_0);
}

ent_flag_waitopen_or_timeout(var_0, var_1) {
  var_2 = gettime();

  while (isdefined(self) && self.ent_flag[var_0]) {
    if(gettime() >= var_2 + var_1 * 1000) {
      break;
    }

    maps\_utility_code::ent_wait_for_flag_or_time_elapses(var_0, var_1);
  }
}

ent_flag_assert(var_0) {}

ent_flag_waitopen_either(var_0, var_1) {
  while (isdefined(self)) {
    if(!ent_flag(var_0)) {
      return;
    }
    if(!ent_flag(var_1)) {
      return;
    }
    common_scripts\utility::waittill_either(var_0, var_1);
  }
}

ent_flag_init(var_0) {
  if(!isdefined(self.ent_flag)) {
    self.ent_flag = [];
    self.ent_flags_lock = [];
  }

  self.ent_flag[var_0] = 0;
}

ent_flag_exist(var_0) {
  if(isdefined(self.ent_flag) && isdefined(self.ent_flag[var_0]))
    return 1;

  return 0;
}

ent_flag_set_delayed(var_0, var_1) {
  self endon("death");
  wait(var_1);
  ent_flag_set(var_0);
}

ent_flag_set(var_0) {
  self.ent_flag[var_0] = 1;
  self notify(var_0);
}

ent_flag_clear(var_0, var_1) {
  if(self.ent_flag[var_0]) {
    self.ent_flag[var_0] = 0;
    self notify(var_0);
  }

  if(isdefined(var_1) && var_1)
    self.ent_flag[var_0] = undefined;
}

ent_flag_clear_delayed(var_0, var_1) {
  wait(var_1);
  ent_flag_clear(var_0);
}

ent_flag(var_0) {
  return self.ent_flag[var_0];
}

get_closest_to_player_view(var_0, var_1, var_2, var_3) {
  if(!var_0.size) {
    return;
  }
  if(!isdefined(var_1))
    var_1 = level.player;

  if(!isdefined(var_3))
    var_3 = -1;

  var_4 = var_1.origin;

  if(isdefined(var_2) && var_2)
    var_4 = var_1 geteye();

  var_5 = undefined;
  var_6 = var_1 getplayerangles();
  var_7 = anglestoforward(var_6);
  var_8 = -1;

  foreach(var_10 in var_0) {
    var_11 = vectortoangles(var_10.origin - var_4);
    var_12 = anglestoforward(var_11);
    var_13 = vectordot(var_7, var_12);

    if(var_13 < var_8) {
      continue;
    }
    if(var_13 < var_3) {
      continue;
    }
    var_8 = var_13;
    var_5 = var_10;
  }

  return var_5;
}

get_closest_index_to_player_view(var_0, var_1, var_2) {
  if(!var_0.size) {
    return;
  }
  if(!isdefined(var_1))
    var_1 = level.player;

  var_3 = var_1.origin;

  if(isdefined(var_2) && var_2)
    var_3 = var_1 geteye();

  var_4 = undefined;
  var_5 = var_1 getplayerangles();
  var_6 = anglestoforward(var_5);
  var_7 = -1;

  for (var_8 = 0; var_8 < var_0.size; var_8++) {
    var_9 = vectortoangles(var_0[var_8].origin - var_3);
    var_10 = anglestoforward(var_9);
    var_11 = vectordot(var_6, var_10);

    if(var_11 < var_7) {
      continue;
    }
    var_7 = var_11;
    var_4 = var_8;
  }

  return var_4;
}

flag_wait_trigger(var_0, var_1) {
  maps\_utility_code::_flag_wait_trigger(var_0, var_1);
}

flag_trigger_init(var_0, var_1, var_2) {
  common_scripts\utility::flag_init(var_0);

  if(!isdefined(var_2))
    var_2 = 0;

  var_1 thread maps\_utility_code::_flag_wait_trigger(var_0, var_2);
  return var_1;
}

flag_triggers_init(var_0, var_1, var_2) {
  common_scripts\utility::flag_init(var_0);

  if(!isdefined(var_2))
    var_2 = 0;

  for (var_3 = 0; var_3 < var_1.size; var_3++)
    var_1[var_3] thread maps\_utility_code::_flag_wait_trigger(var_0, 0);

  return var_1;
}

flag_set_delayed(var_0, var_1) {
  wait(var_1);
  common_scripts\utility::flag_set(var_0);
}

flag_clear_delayed(var_0, var_1) {
  wait(var_1);
  common_scripts\utility::flag_clear(var_0);
}

save_time_played() {
  var_0 = level.player getplayerdata(common_scripts\utility::getstatsgroup_sp(), "career", "duration_total_seconds");

  if(isdefined(var_0)) {
    var_0 = var_0 + int((gettime() - level.lasttimeplayedregister) / 1000);
    level.player setplayerdata(common_scripts\utility::getstatsgroup_sp(), "career", "duration_total_seconds", var_0);
  }
}

level_end_save() {
  save_time_played();

  if(arcademode()) {
    return;
  }
  if(level.missionfailed) {
    return;
  }
  if(common_scripts\utility::flag("game_saving")) {
    return;
  }
  for (var_0 = 0; var_0 < level.players.size; var_0++) {
    var_1 = level.players[var_0];

    if(!isalive(var_1))
      return;
  }

  common_scripts\utility::flag_set("game_saving");
  var_2 = level.player getplayerdata(common_scripts\utility::getstatsgroup_sp(), "career", "levels", level.script, "level_complete");

  if(isdefined(var_2)) {
    if(!var_2) {
      level.player setplayerdata(common_scripts\utility::getstatsgroup_sp(), "career", "levels", level.script, "level_complete", 1);
      level.player setplayerdata(common_scripts\utility::getstatsgroup_sp(), "career", "levels", level.script, "level_difficulty", level.gameskill);
      level.player setplayerdata(common_scripts\utility::getstatsgroup_sp(), "career", "levels", level.script, "level_completion_timestamp", gettimeutc());
    } else {
      var_3 = level.player getplayerdata(common_scripts\utility::getstatsgroup_sp(), "career", "levels", level.script, "level_difficulty");

      if(level.gameskill > var_3)
        level.player setplayerdata(common_scripts\utility::getstatsgroup_sp(), "career", "levels", level.script, "level_difficulty", level.gameskill);
    }
  }

  var_4 = "levelshots / autosave / autosave_" + level.script + "end";
  savegame("levelend", & "AUTOSAVE_AUTOSAVE", var_4, 1, 1);
  common_scripts\utility::flag_clear("game_saving");
}

add_extra_autosave_check(var_0, var_1, var_2) {
  level._extra_autosave_checks[var_0] = [];
  level._extra_autosave_checks[var_0]["func"] = var_1;
  level._extra_autosave_checks[var_0]["msg"] = var_2;
}

remove_extra_autosave_check(var_0) {
  level._extra_autosave_checks[var_0] = undefined;
}

autosave_stealth() {}

autosave_stealth_silent() {}

autosave_tactical() {}

autosave_by_name(var_0) {
  thread autosave_by_name_thread(var_0);
}

autosave_by_name_silent(var_0) {
  thread autosave_by_name_thread(var_0, undefined, undefined, 1);
}

autosave_by_name_thread(var_0, var_1, var_2, var_3) {
  if(!isdefined(level.curautosave))
    level.curautosave = 1;

  var_4 = "levelshots\autosave\autosave_" + level.script + level.curautosave;
  var_5 = level maps\_autosave::tryautosave(level.curautosave, "autosave", var_4, var_1, var_2, var_3, var_0);

  if(isdefined(var_5) && var_5)
    level.curautosave++;
}

autosave_or_timeout(var_0, var_1) {
  thread autosave_by_name_thread(var_0, var_1);
}

debug_message(var_0, var_1, var_2, var_3) {
  if(!isdefined(var_2))
    var_2 = 5;

  if(isdefined(var_3)) {
    var_3 endon("death");
    var_1 = var_3.origin;
  }

  for (var_4 = 0; var_4 < var_2 * 20; var_4++) {
    if(!isdefined(var_3)) {

    } else {

    }

    wait 0.05;
  }
}

debug_message_ai(var_0, var_1) {
  self notify("debug_message_ai");
  self endon("debug_message_ai");
  self endon("death");

  if(!isdefined(var_1))
    var_1 = 5;

  for (var_2 = 0; var_2 < var_1 * 20; var_2++)
    wait 0.05;
}

debug_message_clear(var_0, var_1, var_2, var_3) {
  if(isdefined(var_3)) {
    level notify(var_0 + var_3);
    level endon(var_0 + var_3);
  } else {
    level notify(var_0);
    level endon(var_0);
  }

  if(!isdefined(var_2))
    var_2 = 5;

  for (var_4 = 0; var_4 < var_2 * 20; var_4++)
    wait 0.05;
}

precache(var_0) {
  var_1 = spawn("script_model", (0, 0, 0));
  var_1.origin = level.player getorigin();
  var_1 setmodel(var_0);
  var_1 delete();
}

closerfunc(var_0, var_1) {
  return var_0 >= var_1;
}

fartherfunc(var_0, var_1) {
  return var_0 <= var_1;
}

getclosestfx(var_0, var_1, var_2) {
  return maps\_utility_code::comparesizesfx(var_0, var_1, var_2, ::closerfunc);
}

get_closest_point(var_0, var_1, var_2) {
  var_3 = var_1[0];
  var_4 = distance(var_0, var_3);

  for (var_5 = 0; var_5 < var_1.size; var_5++) {
    var_6 = distance(var_0, var_1[var_5]);

    if(var_6 >= var_4) {
      continue;
    }
    var_4 = var_6;
    var_3 = var_1[var_5];
  }

  if(!isdefined(var_2) || var_4 <= var_2)
    return var_3;

  return undefined;
}

get_farthest_ent(var_0, var_1) {
  if(var_1.size < 1) {
    return;
  }
  var_2 = distance(var_1[0] getorigin(), var_0);
  var_3 = var_1[0];

  for (var_4 = 0; var_4 < var_1.size; var_4++) {
    var_5 = distance(var_1[var_4] getorigin(), var_0);

    if(var_5 < var_2) {
      continue;
    }
    var_2 = var_5;
    var_3 = var_1[var_4];
  }

  return var_3;
}

get_within_range(var_0, var_1, var_2) {
  var_3 = [];

  for (var_4 = 0; var_4 < var_1.size; var_4++) {
    if(distance(var_1[var_4].origin, var_0) <= var_2)
      var_3[var_3.size] = var_1[var_4];
  }

  return var_3;
}

get_outside_range(var_0, var_1, var_2) {
  var_3 = [];

  for (var_4 = 0; var_4 < var_1.size; var_4++) {
    if(distance(var_1[var_4].origin, var_0) > var_2)
      var_3[var_3.size] = var_1[var_4];
  }

  return var_3;
}

get_closest_living(var_0, var_1, var_2) {
  if(!isdefined(var_2))
    var_2 = 9999999;

  if(var_1.size < 1) {
    return;
  }
  var_3 = undefined;

  for (var_4 = 0; var_4 < var_1.size; var_4++) {
    if(!isalive(var_1[var_4])) {
      continue;
    }
    var_5 = distance(var_1[var_4].origin, var_0);

    if(var_5 >= var_2) {
      continue;
    }
    var_2 = var_5;
    var_3 = var_1[var_4];
  }

  return var_3;
}

get_highest_dot(var_0, var_1, var_2) {
  if(!var_2.size) {
    return;
  }
  var_3 = undefined;
  var_4 = vectortoangles(var_1 - var_0);
  var_5 = anglestoforward(var_4);
  var_6 = -1;

  foreach(var_8 in var_2) {
    var_4 = vectortoangles(var_8.origin - var_0);
    var_9 = anglestoforward(var_4);
    var_10 = vectordot(var_5, var_9);

    if(var_10 < var_6) {
      continue;
    }
    var_6 = var_10;
    var_3 = var_8;
  }

  return var_3;
}

get_closest_index(var_0, var_1, var_2) {
  if(!isdefined(var_2))
    var_2 = 9999999;

  if(var_1.size < 1) {
    return;
  }
  var_3 = undefined;

  foreach(var_7, var_5 in var_1) {
    var_6 = distance(var_5.origin, var_0);

    if(var_6 >= var_2) {
      continue;
    }
    var_2 = var_6;
    var_3 = var_7;
  }

  return var_3;
}

get_closest_exclude(var_0, var_1, var_2) {
  if(!isdefined(var_1))
    return undefined;

  var_3 = 0;

  if(isdefined(var_2) && var_2.size) {
    var_4 = [];

    for (var_5 = 0; var_5 < var_1.size; var_5++)
      var_4[var_5] = 0;

    for (var_5 = 0; var_5 < var_1.size; var_5++) {
      for (var_6 = 0; var_6 < var_2.size; var_6++) {
        if(var_1[var_5] == var_2[var_6])
          var_4[var_5] = 1;
      }
    }

    var_7 = 0;

    for (var_5 = 0; var_5 < var_1.size; var_5++) {
      if(!var_4[var_5] && isdefined(var_1[var_5])) {
        var_7 = 1;
        var_3 = distance(var_0, var_1[var_5].origin);
        var_8 = var_5;
        var_5 = var_1.size + 1;
      }
    }

    if(!var_7)
      return undefined;
  } else {
    for (var_5 = 0; var_5 < var_1.size; var_5++) {
      if(isdefined(var_1[var_5])) {
        var_3 = distance(var_0, var_1[0].origin);
        var_8 = var_5;
        var_5 = var_1.size + 1;
      }
    }
  }

  var_8 = undefined;

  for (var_5 = 0; var_5 < var_1.size; var_5++) {
    if(isdefined(var_1[var_5])) {
      var_4 = 0;

      if(isdefined(var_2)) {
        for (var_6 = 0; var_6 < var_2.size; var_6++) {
          if(var_1[var_5] == var_2[var_6])
            var_4 = 1;
        }
      }

      if(!var_4) {
        var_9 = distance(var_0, var_1[var_5].origin);

        if(var_9 <= var_3) {
          var_3 = var_9;
          var_8 = var_5;
        }
      }
    }
  }

  if(isdefined(var_8))
    return var_1[var_8];
  else
    return undefined;
}

get_closest_player(var_0) {
  if(level.players.size == 1)
    return level.player;

  var_1 = common_scripts\utility::getclosest(var_0, level.players);
  return var_1;
}

get_closest_player_healthy(var_0) {
  if(level.players.size == 1)
    return level.player;

  var_1 = get_players_healthy();
  var_2 = common_scripts\utility::getclosest(var_0, var_1);
  return var_2;
}

get_players_healthy() {
  var_0 = [];

  foreach(var_2 in level.players) {
    if(is_player_down(var_2)) {
      continue;
    }
    var_0[var_0.size] = var_2;
  }

  return var_0;
}

get_closest_ai(var_0, var_1, var_2) {
  if(isdefined(var_1))
    var_3 = getaiarray(var_1);
  else
    var_3 = getaiarray();

  if(var_3.size == 0)
    return undefined;

  if(isdefined(var_2))
    var_3 = common_scripts\utility::array_remove_array(var_3, var_2);

  return common_scripts\utility::getclosest(var_0, var_3);
}

get_closest_ai_exclude(var_0, var_1, var_2) {
  if(isdefined(var_1))
    var_3 = getaiarray(var_1);
  else
    var_3 = getaiarray();

  if(var_3.size == 0)
    return undefined;

  return get_closest_exclude(var_0, var_3, var_2);
}

get_progress(var_0, var_1, var_2, var_3) {
  if(!isdefined(var_3))
    var_3 = distance(var_0, var_1);

  var_3 = max(0.01, distance(var_0, var_1));
  var_4 = vectornormalize(var_1 - var_0);
  var_5 = var_2 - var_0;
  var_6 = vectordot(var_5, var_4);
  var_6 = var_6 / var_3;
  var_6 = clamp(var_6, 0, 1);
  return var_6;
}

can_see_origin(var_0, var_1) {
  if(!isdefined(var_1))
    var_1 = 1;

  if(!point_in_fov(var_0))
    return 0;

  if(!sighttracepassed(self geteye(), var_0, var_1, self))
    return 0;

  return 1;
}

point_in_fov(var_0) {
  var_1 = anglestoforward(self.angles);
  var_2 = vectornormalize(var_0 - self.origin);
  var_3 = vectordot(var_1, var_2);
  return var_3 > 0.766;
}

stop_magic_bullet_shield() {
  self notify("stop_magic_bullet_shield");

  if(self.health > self.mbs_oldhealth)
    self.health = self.mbs_oldhealth;

  self.a.nextstandinghitdying = self.mbs_anim_nextstandinghitdying;

  if(isai(self))
    self.attackeraccuracy = 1;

  self.mbs_oldhealth = undefined;
  self.mbs_anim_nextstandinghitdying = undefined;
  self.magic_bullet_shield = undefined;
  self notify("internal_stop_magic_bullet_shield");
}

magic_bullet_death_detection() {}

magic_bullet_shield(var_0, var_1, var_2, var_3, var_4) {
  if(isai(self)) {} else
    self.health = 100000;

  self endon("internal_stop_magic_bullet_shield");

  if(!isdefined(var_4))
    var_4 = 1;

  if(!isdefined(var_3))
    var_3 = self.health;

  self.mbs_oldhealth = var_3;

  if(isai(self)) {
    self.mbs_anim_nextstandinghitdying = self.a.nextstandinghitdying;
    self.attackeraccuracy = 0;
    self.a.disablelongdeath = 1;
    self.a.nextstandinghitdying = 0;
  }

  self notify("magic_bullet_shield");
  self.magic_bullet_shield = 1;
  self.noragdoll = 1;

  if(!isdefined(var_2))
    var_2 = 0;

  if(!isdefined(var_1))
    var_1 = 100000000;

  for (;;) {
    self.health = var_1;
    self.maxhealth = self.health * var_4;
    var_3 = self.health;
    self waittill("pain");

    if(var_3 == self.health) {
      continue;
    }
    if(var_2 > 0)
      thread ignore_me_timer(var_2);

    thread turret_ignore_me_timer(5);
  }
}

disable_long_death() {
  self.a.disablelongdeath = 1;
}

enable_long_death() {
  self.a.disablelongdeath = 0;
}

enable_blood_pool() {
  self.skipbloodpool = undefined;
}

disable_blood_pool() {
  self.skipbloodpool = 1;
}

deletable_magic_bullet_shield() {
  magic_bullet_shield(1);
}

get_ignoreme() {
  return self.ignoreme;
}

set_ignoreme(var_0) {
  self.ignoreme = var_0;
}

set_ignoreall(var_0) {
  self.ignoreall = var_0;
}

set_ignoresonicaoe(var_0) {
  self.ignoresonicaoe = var_0;
}

set_favoriteenemy(var_0) {
  self.favoriteenemy = var_0;
}

get_pacifist() {
  return self.pacifist;
}

set_pacifist(var_0) {
  self.pacifist = var_0;
}

ignore_me_timer(var_0) {
  self notify("new_ignore_me_timer");
  self endon("new_ignore_me_timer");
  self endon("death");
  self endon("pain");

  if(!isdefined(self.ignore_me_timer_prev_value))
    self.ignore_me_timer_prev_value = self.ignoreme;

  var_1 = getaiarray("bad_guys");

  foreach(var_3 in var_1) {
    if(!isalive(var_3.enemy)) {
      continue;
    }
    if(var_3.enemy != self) {
      continue;
    }
    var_3 clearenemy();
  }

  self.ignoreme = 1;
  wait(var_0);
  self.ignoreme = self.ignore_me_timer_prev_value;
  self.ignore_me_timer_prev_value = undefined;
}

turret_ignore_me_timer(var_0) {
  self endon("death");
  self endon("pain");
  self.turretinvulnerability = 1;
  wait(var_0);
  self.turretinvulnerability = 0;
}

delete_exploder(var_0) {
  common_scripts\_exploder::delete_exploder_proc(var_0);
}

hide_exploder_models(var_0) {
  common_scripts\_exploder::hide_exploder_models_proc(var_0);
}

show_exploder_models(var_0) {
  common_scripts\_exploder::show_exploder_models_proc(var_0);
}

stop_exploder(var_0) {
  common_scripts\_exploder::stop_exploder_proc(var_0);
}

get_exploder_array(var_0) {
  return common_scripts\_exploder::get_exploder_array_proc(var_0);
}

flood_spawn(var_0) {
  maps\_spawner::flood_spawner_scripted(var_0);
}

set_ambient(var_0, var_1) {
  if(!isdefined(var_1))
    var_1 = 2.0;

  level.ambient = var_0;

  if(isdefined(level.ambient_track) && isdefined(level.ambient_track[var_0]))
    ambientplay(level.ambient_track[var_0], var_1);
}

set_ambient_preh1(var_0, var_1) {
  soundscripts\_audio_zone_manager::azm_start_zone(var_0, var_1);
}

force_crawling_death(var_0, var_1, var_2, var_3) {
  if(!isdefined(var_1))
    var_1 = 4;

  thread force_crawling_death_proc(var_0, var_1, var_2, var_3);
}

#using_animtree("generic_human");

override_crawl_death_anims() {
  if(isdefined(self.a.custom_crawling_death_array)) {
    self.a.array["crawl"] = self.a.custom_crawling_death_array["crawl"];
    self.a.array["death"] = self.a.custom_crawling_death_array["death"];
    self.a.crawl_fx_rate = self.a.custom_crawling_death_array["blood_fx_rate"];

    if(isdefined(self.a.custom_crawling_death_array["blood_fx"]))
      self.a.crawl_fx = self.a.custom_crawling_death_array["blood_fx"];
  }

  self.a.array["stand_2_crawl"] = [];
  self.a.array["stand_2_crawl"][0] = % dying_stand_2_crawl_v3;

  if(isdefined(self.nofallanim))
    self.a.pose = "prone";

  self orientmode("face angle", self.a.force_crawl_angle);
  self.a.force_crawl_angle = undefined;
}

force_crawling_death_proc(var_0, var_1, var_2, var_3) {
  self.forcelongdeath = 1;
  self.a.force_num_crawls = var_1;
  self.noragdoll = 1;
  self.nofallanim = var_3;
  self.a.custom_crawling_death_array = var_2;
  self.crawlingpainanimoverridefunc = ::override_crawl_death_anims;
  self.maxhealth = 100000;
  self.health = 100000;
  enable_long_death();

  if(!isdefined(var_3) || var_3 == 0)
    self.a.force_crawl_angle = var_0 + 181.02;
  else {
    self.a.force_crawl_angle = var_0;
    thread animscripts\notetracks::notetrackposecrawl();
  }
}

never_saw_it_coming() {
  self endon("death");

  for (;;) {
    var_0 = self ishighjumping();

    if(var_0) {
      var_1 = common_scripts\utility::waittill_any_return("exo_dodge", "player_boost_land", "disable_high_jump");

      if(!isdefined(var_1) || (var_1 == "player_boost_land" || var_1 == "disable_high_jump")) {
        continue;
      }
      if(!isdefined(self.never_saw_it_coming))
        self.never_saw_it_coming = 1;

      common_scripts\utility::waittill_any("player_boost_land", "disable_high_jump");
      waitframe();
      self.never_saw_it_coming = undefined;
    }

    waitframe();
  }
}

check_man_overboard() {
  if(getdvar("mapname", "undefined") != "sanfran_b") {
    return;
  }
  if(!isdefined(level.player.man_overboard) || !level.player.man_overboard)
    level.player.man_overboard = 1;

  wait 2.0;
  level.player.man_overboard = undefined;
}

monitor_genius_achievement(var_0, var_1, var_2) {
  if(var_1 != "MOD_GRENADE") {
    var_0.genius_achievement = undefined;
    return;
  }

  if(!isdefined(var_0.genius_achievement))
    var_0.genius_achievement = 1;
  else
    var_0.genius_achievement++;

  if(var_0.genius_achievement == 4)
    giveachievement_wrapper("SMART_GRENADE_KILL");

  wait 0.1;
  var_0.genius_achievement = undefined;
}

start_monitor_escape_artist() {
  add_global_spawn_function("axis", ::monitor_escape_artist);
  common_scripts\utility::array_thread(getaiarray("axis"), ::monitor_escape_artist);
  level.grenade_id = 0;
  level.player.escape_artist = [];
}

monitor_escape_artist() {
  for (;;) {
    var_0 = undefined;
    self waittill("grenade_fire", var_0, var_1);
    var_0.unique_id = level.grenade_id;
    level.grenade_id++;
    var_0.owner = self.unique_id;
    var_0 thread escape_artist_distance();
    var_0 thread escape_artist();
  }
}

escape_artist_distance() {
  var_0 = level.player;
  var_1 = self.unique_id;

  while (isdefined(self)) {
    var_2 = var_0.origin - self.origin;
    var_3 = getweaponexplosionradius("fraggrenade") + 23;
    var_4 = squared(var_3);
    var_5 = lengthsquared(var_2);

    if(var_5 > var_4) {
      if(isdefined(var_0.escape_artist[self.unique_id]))
        var_0.escape_artist[self.unique_id] = undefined;
    } else if(!isdefined(var_0.escape_artist[self.unique_id])) {
      if(isdefined(self.owner))
        var_0.escape_artist[self.unique_id] = 1;
    }

    waitframe();
  }

  if(isdefined(var_0.escape_artist[var_1]))
    var_0.escape_artist[var_1] = undefined;
}

escape_artist() {
  var_0 = level.player;

  while (isdefined(self)) {
    if(isdefined(var_0.escape_artist[self.unique_id])) {
      var_1 = level.player common_scripts\utility::waittill_any_timeout(4, "exo_dodge");

      if(isdefined(var_1) && var_1 == "exo_dodge")
        thread check_grenade_dmg();

      continue;
    }

    waitframe();
  }
}

check_grenade_dmg() {
  level.player endon("death");

  while (isdefined(self)) {
    var_0 = level.player waittill_dmg_timeout(1, "damage");

    if(isdefined(var_0) && isarray(var_0)) {
      if(var_0[5] == "MOD_GRENADE_SPLASH" && !isdefined(level.player.escape_artist_failure)) {
        if(var_0[2].unique_id == self.owner && isdefined(level.player.escape_artist[self.unique_id]))
          level.player.escape_artist_failure = 1;
      }

      continue;
    }

    waitframe();
  }
}

escape_artist_success() {
  var_0 = self getlocalplayerprofiledata("ach_escapeArtist") + 1;

  if(var_0 == 20)
    giveachievement_wrapper("GRENADE_DODGE");

  self setlocalplayerprofiledata("ach_escapeArtist", var_0);
}

waittill_dmg_timeout(var_0, var_1) {
  if(!isdefined(var_1) || var_1 != "death")
    self endon("death");

  var_2 = spawnstruct();

  if(isdefined(var_1))
    childthread common_scripts\utility::waittill_string_parms(var_1, var_2);

  var_2 childthread common_scripts\utility::_timeout(var_0);
  var_2 waittill("returned", var_3);
  var_2 notify("die");
  return var_3;
}

shock_ondeath() {
  precacheshellshock("default");
  self waittill("death");

  if(isdefined(self.specialdeath)) {
    return;
  }
  if(getdvar("r_texturebits") == "16") {
    return;
  }
  self shellshock("default", 3);
}

playerwatch_unresolved_collision() {
  self endon("death");
  self endon("stop_unresolved_collision_script");
  reset_unresolved_collision_handler();
  childthread playerwatch_unresolved_collision_count();

  for (;;) {
    if(self.unresolved_collision) {
      self.unresolved_collision = 0;

      if(self.unresolved_collision_count >= 20) {
        if(isdefined(self.handle_unresolved_collision))
          self[[self.handle_unresolved_collision]]();
        else
          default_unresolved_collision_handler();
      }
    } else
      reset_unresolved_collision_handler();

    wait 0.05;
  }
}

playerwatch_register_crusher(var_0) {
  if(!isdefined(level.player.crushers)) {
    level.player thread playerwatch_unresolved_crusher_collision();
    level.player.crushers = [];
  }

  level.player.crushers[level.player.crushers.size] = var_0;
}

playerwatch_unregister_crusher(var_0) {
  if(isdefined(level.player.crushers) && is_in_array(level.player.crushers, var_0))
    level.player.crushers = common_scripts\utility::array_remove(level.player.crushers, var_0);
}

playerwatch_unresolved_crusher_collision() {
  self endon("death");

  for (;;) {
    self waittill("unresolved_collision", var_0);

    if(isdefined(level.player.crushers)) {
      if(common_scripts\utility::array_contains(level.player.crushers, var_0))
        self dodamage(10000, self.origin, self, self, "MOD_CRUSH");
    }

    wait 0.05;
  }
}

playerwatch_unresolved_collision_count() {
  for (;;) {
    self waittill("unresolved_collision");
    self.unresolved_collision = 1;
    self.unresolved_collision_count++;
  }
}

reset_unresolved_collision_handler() {
  self.unresolved_collision = 0;
  self.unresolved_collision_count = 0;
}

default_unresolved_collision_handler() {
  var_0 = getnodesinradiussorted(self.origin, 300, 0, 200, "Path");

  if(var_0.size) {
    self cancelmantle();
    self dontinterpolate();
    self setorigin(var_0[0].origin);
    reset_unresolved_collision_handler();
  } else
    self kill();
}

stop_playerwatch_unresolved_collision() {
  self notify("stop_unresolved_collision_script");
  reset_unresolved_collision_handler();
}

delete_on_death_wait_sound(var_0, var_1) {
  var_0 endon("death");
  self waittill("death");

  if(isdefined(var_0)) {
    if(var_0 iswaitingonsound())
      var_0 waittill(var_1);

    var_0 delete();
  }
}

is_dead_sentient() {
  return issentient(self) && !isalive(self);
}

play_sound_on_tag(var_0, var_1, var_2, var_3, var_4) {
  if(is_dead_sentient()) {
    return;
  }
  if(!soundexists(var_0)) {
    return;
  }
  var_5 = spawn("script_origin", (0, 0, 0));
  var_5 endon("death");
  thread delete_on_death_wait_sound(var_5, "sounddone");

  if(isdefined(var_1))
    var_5 linkto(self, var_1, (0, 0, 0), (0, 0, 0));
  else {
    var_5.origin = self.origin;
    var_5.angles = self.angles;
    var_5 linkto(self);
  }

  var_5 playsound(var_0, "sounddone");

  if(isdefined(var_2)) {
    if(!isdefined(maps\_utility_code::wait_for_sounddone_or_death(var_5)))
      var_5 stopsounds();

    wait 0.05;
  } else
    var_5 waittill("sounddone");

  if(isdefined(var_3))
    self notify(var_3);

  var_5 delete();
}

play_sound_on_tag_endon_death(var_0, var_1) {
  play_sound_on_tag(var_0, var_1, 1);
}

play_sound_on_entity(var_0, var_1) {
  play_sound_on_tag(var_0, undefined, undefined, var_1);
}

play_loop_sound_on_tag(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isdefined(var_0)) {
    return;
  }
  var_6 = spawn("script_origin", (0, 0, 0));
  var_6 endon("death");

  if(!isdefined(var_2))
    var_2 = 1;

  if(var_2)
    thread common_scripts\utility::delete_on_death(var_6);

  if(!isdefined(var_3))
    var_3 = 0;

  if(var_3)
    thread delete_on_removed(var_6);

  if(isdefined(var_1))
    var_6 linkto(self, var_1, (0, 0, 0), (0, 0, 0));
  else {
    var_6.origin = self.origin;
    var_6.angles = self.angles;
    var_6 linkto(self);
  }

  if(isdefined(var_4) && var_4 > 0)
    var_6 setvolume(0);

  var_6 playloopsound(var_0);

  if(isdefined(var_4) && var_4 > 0)
    var_6 scalevolume(1, var_4);

  self waittill("stop sound" + var_0);

  if(isdefined(var_5) && var_5 > 0) {
    var_6 scalevolume(0, var_5);
    wait(var_5 + 0.05);
  }

  var_6 stoploopsound(var_0);
  var_6 delete();
}

delete_on_removed(var_0) {
  var_0 endon("death");

  while (isdefined(self))
    wait 0.05;

  if(isdefined(var_0))
    var_0 delete();
}

save_friendlies() {
  var_0 = getaiarray("allies");
  var_1 = 0;

  for (var_2 = 0; var_2 < var_0.size; var_2++) {
    if(isdefined(var_0[var_2].script_friendname)) {
      continue;
    }
    game["character" + var_1] = var_0[var_2] codescripts\character::save();
    var_1++;
  }

  game["total characters"] = var_1;
}

spawn_failed(var_0) {
  if(!isalive(var_0))
    return 1;

  if(!isdefined(var_0.finished_spawning))
    var_0 common_scripts\utility::waittill_either("finished spawning", "death");

  if(isalive(var_0))
    return 0;

  return 1;
}

spawn_setcharacter(var_0) {
  codescripts\character::precache(var_0);
  self waittill("spawned", var_1);

  if(spawn_failed(var_1)) {
    return;
  }
  var_1 codescripts\character::new();
  var_1 codescripts\character::load(var_0);
}

key_hint_print(var_0, var_1) {
  iprintlnbold(var_0, var_1["key1"]);
}

view_tag(var_0) {
  self endon("death");

  for (;;) {
    maps\_debug::drawtag(var_0);
    wait 0.05;
  }
}

assign_animtree(var_0) {
  if(isdefined(var_0))
    self.animname = var_0;

  self useanimtree(level.scr_animtree[self.animname]);
}

assign_model() {
  if(isarray(level.scr_model[self.animname])) {
    var_0 = randomint(level.scr_model[self.animname].size);
    self setmodel(level.scr_model[self.animname][var_0]);
  } else
    self setmodel(level.scr_model[self.animname]);
}

spawn_anim_model(var_0, var_1, var_2) {
  if(!isdefined(var_1))
    var_1 = (0, 0, 0);

  var_3 = spawn("script_model", var_1);
  var_3.animname = var_0;
  var_3 assign_animtree();
  var_3 assign_model();

  if(isdefined(var_2))
    var_3.angles = var_2;

  return var_3;
}

trigger_wait(var_0, var_1) {
  var_2 = getent(var_0, var_1);

  if(!isdefined(var_2)) {
    return;
  }
  var_2 waittill("trigger", var_3);
  level notify(var_0, var_3);
  return var_3;
}

trigger_wait_targetname(var_0) {
  return trigger_wait(var_0, "targetname");
}

set_flag_on_dead(var_0, var_1) {
  thread set_flag_on_func_wait_proc(var_0, var_1, ::waittill_dead, "set_flag_on_dead");
}

set_flag_on_dead_or_dying(var_0, var_1) {
  thread set_flag_on_func_wait_proc(var_0, var_1, ::waittill_dead_or_dying, "set_flag_on_dead_or_dying");
}

set_flag_on_spawned(var_0, var_1) {
  thread set_flag_on_func_wait_proc(var_0, var_1, ::empty_func, "set_flag_on_spawned");
}

empty_func(var_0) {
  return;
}

set_flag_on_spawned_ai_proc(var_0, var_1) {
  self waittill("spawned", var_2);

  if(spawn_failed(var_2)) {
    return;
  }
  var_0.ai[var_0.ai.size] = var_2;
  ent_flag_set(var_1);
}

set_flag_on_func_wait_proc(var_0, var_1, var_2, var_3) {
  var_4 = spawnstruct();
  var_4.ai = [];

  foreach(var_7, var_6 in var_0)
  var_6 ent_flag_init(var_3);

  common_scripts\utility::array_thread(var_0, ::set_flag_on_spawned_ai_proc, var_4, var_3);

  foreach(var_7, var_6 in var_0)
  var_6 ent_flag_wait(var_3);

  [[var_2]](var_4.ai);
  common_scripts\utility::flag_set(var_1);
}

set_flag_on_trigger(var_0, var_1) {
  if(!common_scripts\utility::flag(var_1)) {
    var_0 waittill("trigger", var_2);
    common_scripts\utility::flag_set(var_1);
    return var_2;
  }
}

set_flag_on_targetname_trigger(var_0) {
  if(common_scripts\utility::flag(var_0)) {
    return;
  }
  var_1 = getent(var_0, "targetname");
  var_1 waittill("trigger");
  common_scripts\utility::flag_set(var_0);
}

is_in_array(var_0, var_1) {
  for (var_2 = 0; var_2 < var_0.size; var_2++) {
    if(var_0[var_2] == var_1)
      return 1;
  }

  return 0;
}

waittill_dead(var_0, var_1, var_2) {
  var_10 = spawnstruct();

  if(isdefined(var_2)) {
    var_10 endon("thread_timed_out");
    var_10 thread waittill_dead_timeout(var_2);
  }

  var_10.count = var_0.size;

  if(isdefined(var_1) && var_1 < var_10.count)
    var_10.count = var_1;

  common_scripts\utility::array_thread(var_0, ::waittill_dead_thread, var_10);

  while (var_10.count > 0)
    var_10 waittill("waittill_dead guy died");
}

waittill_dead_or_dying(var_0, var_1, var_2) {
  var_3 = [];

  foreach(var_5 in var_0) {
    if(isalive(var_5) && !var_5.ignoreforfixednodesafecheck)
      var_3[var_3.size] = var_5;
  }

  var_0 = var_3;
  var_7 = spawnstruct();

  if(isdefined(var_2)) {
    var_7 endon("thread_timed_out");
    var_7 thread waittill_dead_timeout(var_2);
  }

  var_7.count = var_0.size;

  if(isdefined(var_1) && var_1 < var_7.count)
    var_7.count = var_1;

  common_scripts\utility::array_thread(var_0, ::waittill_dead_or_dying_thread, var_7);

  while (var_7.count > 0)
    var_7 waittill("waittill_dead_guy_dead_or_dying");
}

waittill_dead_thread(var_0) {
  self waittill("death");
  var_0.count--;
  var_0 notify("waittill_dead guy died");
}

waittill_dead_or_dying_thread(var_0) {
  common_scripts\utility::waittill_either("death", "pain_death");
  var_0.count--;
  var_0 notify("waittill_dead_guy_dead_or_dying");
}

waittill_dead_timeout(var_0) {
  wait(var_0);
  self notify("thread_timed_out");
}

waittill_aigroupcleared(var_0) {
  while (level._ai_group[var_0].spawnercount || level._ai_group[var_0].aicount)
    wait 0.25;
}

waittill_aigroupcount(var_0, var_1) {
  while (level._ai_group[var_0].spawnercount + level._ai_group[var_0].aicount > var_1)
    wait 0.25;
}

get_ai_group_count(var_0) {
  return level._ai_group[var_0].spawnercount + level._ai_group[var_0].aicount;
}

get_ai_group_sentient_count(var_0) {
  return level._ai_group[var_0].aicount;
}

get_ai_group_ai(var_0) {
  var_1 = [];

  for (var_2 = 0; var_2 < level._ai_group[var_0].ai.size; var_2++) {
    if(!isalive(level._ai_group[var_0].ai[var_2])) {
      continue;
    }
    var_1[var_1.size] = level._ai_group[var_0].ai[var_2];
  }

  return var_1;
}

waittill_notetrack_or_damage(var_0) {
  self endon("damage");
  self endon("death");
  self waittillmatch("single anim", var_0);
}

get_living_ai(var_0, var_1) {
  var_2 = get_living_ai_array(var_0, var_1);

  if(var_2.size > 1)
    return undefined;

  return var_2[0];
}

get_living_ai_array(var_0, var_1) {
  var_2 = getaispeciesarray("all", "all");
  var_3 = [];

  foreach(var_5 in var_2) {
    if(!isalive(var_5)) {
      continue;
    }
    switch (var_1) {
      case "targetname":
        if(isdefined(var_5.targetname) && var_5.targetname == var_0)
          var_3[var_3.size] = var_5;

        break;
      case "script_noteworthy":
        if(isdefined(var_5.script_noteworthy) && var_5.script_noteworthy == var_0)
          var_3[var_3.size] = var_5;

        break;
    }
  }

  return var_3;
}

get_vehicle(var_0, var_1) {
  var_2 = get_vehicle_array(var_0, var_1);

  if(!var_2.size)
    return undefined;

  return var_2[0];
}

get_vehicle_array(var_0, var_1) {
  var_2 = getentarray(var_0, var_1);
  var_3 = [];
  var_4 = [];

  foreach(var_6 in var_2) {
    if(var_6.code_classname != "script_vehicle") {
      continue;
    }
    var_4[0] = var_6;

    if(isspawner(var_6)) {
      if(isdefined(var_6.last_spawned_vehicle)) {
        var_4[0] = var_6.last_spawned_vehicle;
        var_3 = array_merge(var_3, var_4);
      }

      continue;
    }

    var_3 = array_merge(var_3, var_4);
  }

  return var_3;
}

get_living_aispecies(var_0, var_1, var_2) {
  var_3 = get_living_aispecies_array(var_0, var_1, var_2);

  if(var_3.size > 1)
    return undefined;

  return var_3[0];
}

get_living_aispecies_array(var_0, var_1, var_2) {
  if(!isdefined(var_2))
    var_2 = "all";

  var_3 = getaispeciesarray("allies", var_2);
  var_3 = common_scripts\utility::array_combine(var_3, getaispeciesarray("axis", var_2));
  var_4 = [];

  for (var_5 = 0; var_5 < var_3.size; var_5++) {
    switch (var_1) {
      case "targetname":
        if(isdefined(var_3[var_5].targetname) && var_3[var_5].targetname == var_0)
          var_4[var_4.size] = var_3[var_5];

        break;
      case "script_noteworthy":
        if(isdefined(var_3[var_5].script_noteworthy) && var_3[var_5].script_noteworthy == var_0)
          var_4[var_4.size] = var_3[var_5];

        break;
    }
  }

  return var_4;
}

gather_delay_proc(var_0, var_1) {
  if(isdefined(level.gather_delay[var_0])) {
    if(level.gather_delay[var_0]) {
      wait 0.05;

      if(isalive(self))
        self notify("gather_delay_finished" + var_0 + var_1);

      return;
    }

    level waittill(var_0);

    if(isalive(self))
      self notify("gather_delay_finished" + var_0 + var_1);

    return;
  }

  level.gather_delay[var_0] = 0;
  wait(var_1);
  level.gather_delay[var_0] = 1;
  level notify(var_0);

  if(isalive(self))
    self notify("gather_delay_finished" + var_0 + var_1);
}

gather_delay(var_0, var_1) {
  thread gather_delay_proc(var_0, var_1);
  self waittill("gather_delay_finished" + var_0 + var_1);
}

death_waiter(var_0) {
  self waittill("death");
  level notify(var_0);
}

getchar(var_0) {
  if(var_0 == 0)
    return "0";

  if(var_0 == 1)
    return "1";

  if(var_0 == 2)
    return "2";

  if(var_0 == 3)
    return "3";

  if(var_0 == 4)
    return "4";

  if(var_0 == 5)
    return "5";

  if(var_0 == 6)
    return "6";

  if(var_0 == 7)
    return "7";

  if(var_0 == 8)
    return "8";

  if(var_0 == 9)
    return "9";
}

getlinks_array(var_0, var_1) {
  var_2 = [];

  for (var_3 = 0; var_3 < var_0.size; var_3++) {
    var_4 = var_0[var_3];
    var_5 = var_4.script_linkname;

    if(!isdefined(var_5)) {
      continue;
    }
    if(!isdefined(var_1[var_5])) {
      continue;
    }
    var_2[var_2.size] = var_4;
  }

  return var_2;
}

array_merge_links(var_0, var_1) {
  if(!var_0.size)
    return var_1;

  if(!var_1.size)
    return var_0;

  var_2 = [];

  for (var_3 = 0; var_3 < var_0.size; var_3++) {
    var_4 = var_0[var_3];
    var_2[var_4.script_linkname] = 1;
  }

  for (var_3 = 0; var_3 < var_1.size; var_3++) {
    var_4 = var_1[var_3];

    if(isdefined(var_2[var_4.script_linkname])) {
      continue;
    }
    var_2[var_4.script_linkname] = 1;
    var_0[var_0.size] = var_4;
  }

  return var_0;
}

array_merge(var_0, var_1) {
  if(var_0.size == 0)
    return var_1;

  if(var_1.size == 0)
    return var_0;

  var_2 = var_0;

  foreach(var_4 in var_1) {
    var_5 = 0;

    foreach(var_7 in var_0) {
      if(var_7 == var_4) {
        var_5 = 1;
        break;
      }
    }

    if(var_5)
      continue;
    else
      var_2[var_2.size] = var_4;
  }

  return var_2;
}

array_exclude(var_0, var_1) {
  var_2 = var_0;

  for (var_3 = 0; var_3 < var_1.size; var_3++) {
    if(is_in_array(var_0, var_1[var_3]))
      var_2 = common_scripts\utility::array_remove(var_2, var_1[var_3]);
  }

  return var_2;
}

array_compare(var_0, var_1) {
  if(var_0.size != var_1.size)
    return 0;

  foreach(var_5, var_3 in var_0) {
    if(!isdefined(var_1[var_5]))
      return 0;

    var_4 = var_1[var_5];

    if(var_4 != var_3)
      return 0;
  }

  return 1;
}

getlinkedvehiclenodes() {
  var_0 = [];

  if(isdefined(self.script_linkto)) {
    var_1 = common_scripts\utility::get_links();

    foreach(var_3 in var_1) {
      var_4 = getvehiclenodearray(var_3, "script_linkname");
      var_0 = common_scripts\utility::array_combine(var_0, var_4);
    }
  }

  return var_0;
}

draw_line(var_0, var_1, var_2, var_3, var_4) {
  for (;;)
    wait 0.05;
}

draw_line_to_ent_for_time(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_5 = gettime() + var_5 * 1000;

  while (gettime() < var_5) {
    wait 0.05;

    if(!isdefined(var_1) || !isdefined(var_1.origin))
      return;
  }
}

draw_line_from_ent_for_time(var_0, var_1, var_2, var_3, var_4, var_5) {
  draw_line_to_ent_for_time(var_1, var_0, var_2, var_3, var_4, var_5);
}

draw_line_from_ent_to_ent_for_time(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_0 endon("death");
  var_1 endon("death");
  var_5 = gettime() + var_5 * 1000;

  while (gettime() < var_5)
    wait 0.05;
}

draw_line_from_ent_to_ent_until_notify(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_0 endon("death");
  var_1 endon("death");
  var_5 endon(var_6);

  for (;;)
    wait 0.05;
}

draw_line_until_notify(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_5 endon(var_6);

  for (;;)
    common_scripts\utility::draw_line_for_time(var_0, var_1, var_2, var_3, var_4, 0.05);
}

draw_line_from_ent_to_vec_for_time(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_6 = gettime() + var_6 * 1000;
  var_1 = var_1 * var_2;

  while (gettime() < var_6) {
    wait 0.05;

    if(!isdefined(var_0) || !isdefined(var_0.origin))
      return;
  }
}

draw_circle_until_notify(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  if(isdefined(var_7))
    var_8 = var_7;
  else
    var_8 = 16;

  var_9 = 360 / var_8;
  var_10 = [];

  for (var_11 = 0; var_11 < var_8; var_11++) {
    var_12 = var_9 * var_11;
    var_13 = cos(var_12) * var_1;
    var_14 = sin(var_12) * var_1;
    var_15 = var_0[0] + var_13;
    var_16 = var_0[1] + var_14;
    var_17 = var_0[2];
    var_10[var_10.size] = (var_15, var_16, var_17);
  }

  thread draw_circle_lines_until_notify(var_10, var_2, var_3, var_4, var_5, var_6);
}

draw_circle_for_time(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = 16;
  var_7 = 360 / var_6;
  var_8 = [];

  for (var_9 = 0; var_9 < var_6; var_9++) {
    var_10 = var_7 * var_9;
    var_11 = cos(var_10) * var_1;
    var_12 = sin(var_10) * var_1;
    var_13 = var_0[0] + var_11;
    var_14 = var_0[1] + var_12;
    var_15 = var_0[2];
    var_8[var_8.size] = (var_13, var_14, var_15);
  }

  thread draw_circle_lines_for_time(var_8, var_2, var_3, var_4, var_5);
}

draw_circle_lines_for_time(var_0, var_1, var_2, var_3, var_4) {
  for (var_5 = 0; var_5 < var_0.size; var_5++) {
    var_6 = var_0[var_5];

    if(var_5 + 1 >= var_0.size)
      var_7 = var_0[0];
    else
      var_7 = var_0[var_5 + 1];

    thread common_scripts\utility::draw_line_for_time(var_6, var_7, var_1, var_2, var_3, var_4);
  }
}

draw_circle_lines_until_notify(var_0, var_1, var_2, var_3, var_4, var_5) {
  for (var_6 = 0; var_6 < var_0.size; var_6++) {
    var_7 = var_0[var_6];

    if(var_6 + 1 >= var_0.size)
      var_8 = var_0[0];
    else
      var_8 = var_0[var_6 + 1];

    thread draw_line_until_notify(var_7, var_8, var_1, var_2, var_3, var_4, var_5);
  }
}

clear_enemy_passthrough() {
  self notify("enemy");
  self clearenemy();
}

battlechatter_off(var_0) {
  if(!isdefined(level.battlechatter)) {
    level.battlechatter = [];
    level.battlechatter["axis"] = 1;
    level.battlechatter["allies"] = 1;
    level.battlechatter["neutral"] = 1;
  }

  if(isdefined(var_0)) {
    level.battlechatter[var_0] = 0;
    var_1 = getaiarray(var_0);
  } else {
    level.battlechatter["axis"] = 0;
    level.battlechatter["allies"] = 0;
    level.battlechatter["neutral"] = 0;
    var_1 = getaiarray();
  }

  if(!isdefined(anim.chatinitialized) || !anim.chatinitialized) {
    return;
  }
  for (var_2 = 0; var_2 < var_1.size; var_2++)
    var_1[var_2].battlechatter = 0;

  for (var_2 = 0; var_2 < var_1.size; var_2++) {
    var_3 = var_1[var_2];

    if(!isalive(var_3)) {
      continue;
    }
    if(!var_3.chatinitialized) {
      continue;
    }
    if(!var_3.isspeaking) {
      continue;
    }
    var_3 maps\_utility_code::wait_until_done_speaking();
  }

  var_4 = gettime() - anim.lastteamspeaktime["allies"];

  if(var_4 < 1500)
    wait(var_4 / 1000);

  if(isdefined(var_0))
    level notify(var_0 + " done speaking");
  else
    level notify("done speaking");
}

battlechatter_on(var_0) {
  thread battlechatter_on_thread(var_0);
}

battlechatter_on_thread(var_0) {
  if(!isdefined(level.battlechatter)) {
    level.battlechatter = [];
    level.battlechatter["axis"] = 1;
    level.battlechatter["allies"] = 1;
    level.battlechatter["neutral"] = 1;
  }

  if(!anim.chatinitialized) {
    return;
  }
  wait 1.5;

  if(isdefined(var_0)) {
    level.battlechatter[var_0] = 1;
    var_1 = getaiarray(var_0);
  } else {
    level.battlechatter["axis"] = 1;
    level.battlechatter["allies"] = 1;
    level.battlechatter["neutral"] = 1;
    var_1 = getaiarray();
  }

  for (var_2 = 0; var_2 < var_1.size; var_2++)
    var_1[var_2] set_battlechatter(1);
}

set_battlechatter(var_0) {
  if(!isdefined(anim.chatinitialized) || !anim.chatinitialized) {
    return;
  }
  if(self.type == "dog") {
    return;
  }
  if(var_0) {
    if(isdefined(self.script_bcdialog) && !self.script_bcdialog)
      self.battlechatter = 0;
    else
      self.battlechatter = 1;
  } else {
    self.battlechatter = 0;

    if(isdefined(self.isspeaking) && self.isspeaking)
      self waittill("done speaking");
  }
}

set_team_bcvoice(var_0, var_1) {
  if(!anim.chatinitialized) {
    return;
  }
  var_2 = getarraykeys(anim.countryids);
  var_3 = common_scripts\utility::array_contains(var_2, var_1);

  if(!var_3) {
    return;
  }
  var_4 = getaiarray(var_0);

  foreach(var_6 in var_4) {
    var_6 set_ai_bcvoice(var_1);
    waitframe();
  }
}

set_ai_bcvoice(var_0) {
  if(!anim.chatinitialized) {
    return;
  }
  var_1 = getarraykeys(anim.countryids);
  var_2 = common_scripts\utility::array_contains(var_1, var_0);

  if(!var_2) {
    return;
  }
  if(self.type == "dog") {
    return;
  }
  if(isdefined(self.isspeaking) && self.isspeaking) {
    self waittill("done speaking");
    wait 0.1;
  }

  animscripts\battlechatter_ai::removefromsystem();
  waittillframeend;
  self.voice = var_0;
  animscripts\battlechatter_ai::addtosystem();
}

flavorbursts_on(var_0) {
  thread set_flavorbursts_team_state(1, var_0);
}

flavorbursts_off(var_0) {
  thread set_flavorbursts_team_state(0, var_0);
}

set_flavorbursts_team_state(var_0, var_1) {
  if(!isdefined(var_1))
    var_1 = "allies";

  if(!anim.chatinitialized) {
    return;
  }
  wait 1.5;
  level.flavorbursts[var_1] = var_0;
  var_2 = [];
  var_2 = getaiarray(var_1);
  common_scripts\utility::array_thread(var_2, ::set_flavorbursts, var_0);
}

set_flavorbursts(var_0) {
  self.flavorbursts = var_0;
}

friendlyfire_warnings_off() {
  var_0 = getaiarray("allies");

  foreach(var_2 in var_0) {
    if(isalive(var_2))
      var_2 set_friendlyfire_warnings(0);
  }

  level.friendlyfire_warnings = 0;
}

friendlyfire_warnings_on() {
  var_0 = getaiarray("allies");

  foreach(var_2 in var_0) {
    if(isalive(var_2))
      var_2 set_friendlyfire_warnings(1);
  }

  level.friendlyfire_warnings = 1;
}

set_friendlyfire_warnings(var_0) {
  if(var_0)
    self.friendlyfire_warnings_disable = undefined;
  else
    self.friendlyfire_warnings_disable = 1;
}

dds_set_player_character_name(var_0) {
  if(!isplayer(self)) {
    return;
  }
  switch (var_0) {
    case "reznov":
    case "hudson":
    case "mason":
      level.dds.player_character_name = getsubstr(var_0, 0, 3);
      break;
    default:
      level.dds.player_character_name = "mas";
      break;
  }

  self.dds_characterid = level.dds.player_character_name;
}

dds_exclude_this_ai(var_0) {
  if(isai(self) && isalive(self)) {
    if(var_0)
      self.dds_disable = 1;
    else
      self.dds_disable = 0;
  } else {}
}

get_obj_origin(var_0) {
  var_1 = getentarray("objective", "targetname");

  for (var_2 = 0; var_2 < var_1.size; var_2++) {
    if(var_1[var_2].script_noteworthy == var_0)
      return var_1[var_2].origin;
  }
}

get_obj_event(var_0) {
  var_1 = getentarray("objective_event", "targetname");

  for (var_2 = 0; var_2 < var_1.size; var_2++) {
    if(var_1[var_2].script_noteworthy == var_0)
      return var_1[var_2];
  }
}

waittill_objective_event() {
  maps\_utility_code::waittill_objective_event_proc(1);
}

waittill_objective_event_notrigger() {
  maps\_utility_code::waittill_objective_event_proc(0);
}

debugorigin() {
  self notify("Debug origin");
  self endon("Debug origin");
  self endon("death");

  for (;;) {
    var_0 = anglestoforward(self.angles);
    var_1 = var_0 * 30;
    var_2 = var_0 * 20;
    var_3 = anglestoright(self.angles);
    var_4 = var_3 * -10;
    var_3 = var_3 * 10;
    wait 0.05;
  }
}

get_linked_structs() {
  var_0 = [];

  if(isdefined(self.script_linkto)) {
    var_1 = common_scripts\utility::get_links();

    for (var_2 = 0; var_2 < var_1.size; var_2++) {
      var_3 = common_scripts\utility::getstruct(var_1[var_2], "script_linkname");

      if(isdefined(var_3))
        var_0[var_0.size] = var_3;
    }
  }

  return var_0;
}

get_last_ent_in_chain(var_0) {
  var_1 = self;

  while (isdefined(var_1.target)) {
    wait 0.05;

    if(isdefined(var_1.target)) {
      switch (var_0) {
        case "vehiclenode":
          var_1 = getvehiclenode(var_1.target, "targetname");
          break;
        case "pathnode":
          var_1 = getnode(var_1.target, "targetname");
          break;
        case "ent":
          var_1 = getent(var_1.target, "targetname");
          break;
        case "struct":
          var_1 = common_scripts\utility::getstruct(var_1.target, "targetname");
          break;
        default:
      }

      continue;
    }

    break;
  }

  var_2 = var_1;
  return var_2;
}

player_seek(var_0) {
  var_1 = spawn("script_origin", level.player.origin);
  var_1 linkto(level.player);

  if(isdefined(var_0))
    thread timeout(var_0);

  self setgoalentity(var_1);

  if(!isdefined(self.oldgoalradius))
    self.oldgoalradius = self.goalradius;

  self.goalradius = 300;
  common_scripts\utility::waittill_any("goal", "timeout");

  if(isdefined(self.oldgoalradius)) {
    self.goalradius = self.oldgoalradius;
    self.oldgoalradius = undefined;
  }

  var_1 delete();
}

timeout(var_0) {
  self endon("death");
  wait(var_0);
  self notify("timeout");
}

set_forcegoal() {
  if(isdefined(self.set_forcedgoal)) {
    return;
  }
  self.oldfightdist = self.pathenemyfightdist;
  self.oldmaxdist = self.pathenemylookahead;
  self.oldmaxsight = self.maxsightdistsqrd;
  self.pathenemyfightdist = 8;
  self.pathenemylookahead = 8;
  self.maxsightdistsqrd = 1;
  self.set_forcedgoal = 1;
}

unset_forcegoal() {
  if(!isdefined(self.set_forcedgoal)) {
    return;
  }
  self.pathenemyfightdist = self.oldfightdist;
  self.pathenemylookahead = self.oldmaxdist;
  self.maxsightdistsqrd = self.oldmaxsight;
  self.set_forcedgoal = undefined;
}

array_removedead_keepkeys(var_0) {
  var_1 = [];
  var_2 = getarraykeys(var_0);

  for (var_3 = 0; var_3 < var_2.size; var_3++) {
    var_4 = var_2[var_3];

    if(!isalive(var_0[var_4])) {
      continue;
    }
    var_1[var_4] = var_0[var_4];
  }

  return var_1;
}

array_removedead(var_0) {
  var_1 = [];

  foreach(var_3 in var_0) {
    if(!isalive(var_3)) {
      continue;
    }
    var_1[var_1.size] = var_3;
  }

  return var_1;
}

array_removedead_or_dying(var_0) {
  var_1 = [];

  foreach(var_3 in var_0) {
    if(!isalive(var_3)) {
      continue;
    }
    if(var_3 doinglongdeath()) {
      continue;
    }
    var_1[var_1.size] = var_3;
  }

  return var_1;
}

array_remove_nokeys(var_0, var_1) {
  var_2 = [];

  for (var_3 = 0; var_3 < var_0.size; var_3++) {
    if(var_0[var_3] != var_1)
      var_2[var_2.size] = var_0[var_3];
  }

  return var_2;
}

array_remove_index(var_0, var_1) {
  for (var_2 = 0; var_2 < var_0.size - 1; var_2++) {
    if(var_2 == var_1) {
      var_0[var_2] = var_0[var_2 + 1];
      var_1++;
    }
  }

  var_0[var_0.size - 1] = undefined;
  return var_0;
}

array_notify(var_0, var_1, var_2) {
  foreach(var_5, var_4 in var_0)
  var_4 notify(var_1, var_2);
}

struct_arrayspawn() {
  var_0 = spawnstruct();
  var_0.array = [];
  var_0.lastindex = 0;
  return var_0;
}

structarray_add(var_0, var_1) {
  var_0.array[var_0.lastindex] = var_1;
  var_1.struct_array_index = var_0.lastindex;
  var_0.lastindex++;
}

structarray_remove(var_0, var_1) {
  structarray_swaptolast(var_0, var_1);
  var_0.array[var_0.lastindex - 1] = undefined;
  var_0.lastindex--;
}

structarray_remove_index(var_0, var_1) {
  if(isdefined(var_0.array[var_0.lastindex - 1])) {
    var_0.array[var_1] = var_0.array[var_0.lastindex - 1];
    var_0.array[var_1].struct_array_index = var_1;
    var_0.array[var_0.lastindex - 1] = undefined;
    var_0.lastindex = var_0.array.size;
  } else {
    var_0.array[var_1] = undefined;
    structarray_remove_undefined(var_0);
  }
}

structarray_remove_undefined(var_0) {
  var_1 = [];

  foreach(var_3 in var_0.array) {
    if(!isdefined(var_3)) {
      continue;
    }
    var_1[var_1.size] = var_3;
  }

  var_0.array = var_1;

  foreach(var_6, var_3 in var_0.array)
  var_3.struct_array_index = var_6;

  var_0.lastindex = var_0.array.size;
}

structarray_swaptolast(var_0, var_1) {
  var_0 maps\_utility_code::structarray_swap(var_0.array[var_0.lastindex - 1], var_1);
}

structarray_shuffle(var_0, var_1) {
  for (var_2 = 0; var_2 < var_1; var_2++)
    var_0 maps\_utility_code::structarray_swap(var_0.array[var_2], var_0.array[randomint(var_0.lastindex)]);
}

get_use_key() {
  if(level.console)
    return " + usereload";
  else
    return " + activate";
}

custom_battlechatter(var_0) {
  var_1 = [];
  var_1[0] = self;
  var_2 = get_closest_ai_exclude(self.origin, self.team, var_1);

  if(isdefined(var_2) && distance(var_2.origin, self.origin) > 384)
    var_2 = undefined;

  animscripts\battlechatter_ai::begincustomevent();
  var_3 = strtok(var_0, "_");

  if(!var_3.size) {
    return;
  }
  if(var_3[0] == "move") {
    if(var_3.size > 1)
      var_4 = var_3[1];
    else
      var_4 = "generic";

    animscripts\battlechatter_ai::addgenericaliasex("order", "move", var_4);
  } else if(var_3[0] == "infantry") {
    animscripts\battlechatter_ai::addgenericaliasex("threat", "infantry", var_3[1]);

    if(var_3.size > 2 && var_3[2] != "inbound")
      animscripts\battlechatter_ai::addgenericaliasex("direction", "relative", var_3[2]);
    else if(var_3.size > 2)
      animscripts\battlechatter_ai::addgenericaliasex("direction", "inbound", var_3[3]);
  } else if(var_3[0] == "vehicle") {
    animscripts\battlechatter_ai::addgenericaliasex("threat", "vehicle", var_3[1]);

    if(var_3.size > 2 && var_3[2] != "inbound")
      animscripts\battlechatter_ai::addgenericaliasex("direction", "relative", var_3[2]);
    else if(var_3.size > 2)
      animscripts\battlechatter_ai::addgenericaliasex("direction", "inbound", var_3[3]);
  }

  animscripts\battlechatter_ai::endcustomevent(2000);
}

get_stop_watch(var_0, var_1) {
  var_2 = newhudelem();

  if(level.console) {
    var_2.x = 68;
    var_2.y = 35;
  } else {
    var_2.x = 58;
    var_2.y = 95;
  }

  var_2.alignx = "center";
  var_2.aligny = "middle";
  var_2.horzalign = "left";
  var_2.vertalign = "middle";

  if(isdefined(var_1))
    var_3 = var_1;
  else
    var_3 = level.explosiveplanttime;

  var_2 setclock(var_3, var_0, "hudStopwatch", 64, 64);
  return var_2;
}

objective_is_active(var_0) {
  var_1 = 0;

  for (var_2 = 0; var_2 < level.active_objective.size; var_2++) {
    if(level.active_objective[var_2] != var_0) {
      continue;
    }
    var_1 = 1;
    break;
  }

  return var_1;
}

objective_is_inactive(var_0) {
  var_1 = 0;

  for (var_2 = 0; var_2 < level.inactive_objective.size; var_2++) {
    if(level.inactive_objective[var_2] != var_0) {
      continue;
    }
    var_1 = 1;
    break;
  }

  return var_1;
}

set_objective_inactive(var_0) {
  var_1 = [];

  for (var_2 = 0; var_2 < level.active_objective.size; var_2++) {
    if(level.active_objective[var_2] == var_0) {
      continue;
    }
    var_1[var_1.size] = level.active_objective[var_2];
  }

  level.active_objective = var_1;
  var_3 = 0;

  for (var_2 = 0; var_2 < level.inactive_objective.size; var_2++) {
    if(level.inactive_objective[var_2] != var_0) {
      continue;
    }
    var_3 = 1;
  }

  if(!var_3)
    level.inactive_objective[level.inactive_objective.size] = var_0;
}

set_objective_active(var_0) {
  var_1 = [];

  for (var_2 = 0; var_2 < level.inactive_objective.size; var_2++) {
    if(level.inactive_objective[var_2] == var_0) {
      continue;
    }
    var_1[var_1.size] = level.inactive_objective[var_2];
  }

  level.inactive_objective = var_1;
  var_3 = 0;

  for (var_2 = 0; var_2 < level.active_objective.size; var_2++) {
    if(level.active_objective[var_2] != var_0) {
      continue;
    }
    var_3 = 1;
  }

  if(!var_3)
    level.active_objective[level.active_objective.size] = var_0;
}

missionfailedwrapper() {
  if(level.missionfailed) {
    return;
  }
  if(isdefined(level.nextmission)) {
    return;
  }
  save_time_played();
  setsaveddvar("ammoCounterHide", 1);
  level.missionfailed = 1;
  common_scripts\utility::flag_set("missionfailed");

  if(arcademode()) {
    return;
  }
  if(getdvar("failure_disabled") == "1") {
    return;
  }
  if(isdefined(level.mission_fail_func)) {
    thread[[level.mission_fail_func]]();
    return;
  }

  maps\_utility_code::mission_recon(0);
  missionfailed();
}

set_mission_failed_override(var_0) {
  level.mission_fail_func = var_0;
}

script_delay() {
  if(isdefined(self.script_delay)) {
    wait(self.script_delay);
    return 1;
  } else if(isdefined(self.script_delay_min) && isdefined(self.script_delay_max)) {
    wait(randomfloatrange(self.script_delay_min, self.script_delay_max));
    return 1;
  }

  return 0;
}

script_wait() {
  var_0 = gettime();

  if(isdefined(self.script_wait)) {
    wait(self.script_wait);

    if(isdefined(self.script_wait_add))
      self.script_wait = self.script_wait + self.script_wait_add;
  } else if(isdefined(self.script_wait_min) && isdefined(self.script_wait_max)) {
    wait(randomfloatrange(self.script_wait_min, self.script_wait_max));

    if(isdefined(self.script_wait_add)) {
      self.script_wait_min = self.script_wait_min + self.script_wait_add;
      self.script_wait_max = self.script_wait_max + self.script_wait_add;
    }
  }

  return gettime() - var_0;
}

guy_enter_vehicle(var_0) {
  maps\_vehicle_aianim::guy_enter(var_0);
}

guy_runtovehicle_load(var_0, var_1) {
  maps\_vehicle_aianim::guy_runtovehicle(var_0, var_1);
}

get_force_color_guys(var_0, var_1) {
  var_2 = getaiarray(var_0);
  var_3 = [];

  for (var_4 = 0; var_4 < var_2.size; var_4++) {
    var_5 = var_2[var_4];

    if(!isdefined(var_5.script_forcecolor)) {
      continue;
    }
    if(var_5.script_forcecolor != var_1) {
      continue;
    }
    var_3[var_3.size] = var_5;
  }

  return var_3;
}

get_all_force_color_friendlies() {
  var_0 = getaiarray("allies");
  var_1 = [];

  for (var_2 = 0; var_2 < var_0.size; var_2++) {
    var_3 = var_0[var_2];

    if(!isdefined(var_3.script_forcecolor)) {
      continue;
    }
    var_1[var_1.size] = var_3;
  }

  return var_1;
}

get_all_target_ents(var_0) {
  if(!isdefined(var_0))
    var_0 = self.target;

  var_1 = [];
  var_2 = getentarray(var_0, "targetname");
  var_1 = common_scripts\utility::array_combine(var_1, var_2);
  var_2 = getnodearray(var_0, "targetname");
  var_1 = common_scripts\utility::array_combine(var_1, var_2);
  var_2 = common_scripts\utility::getstructarray(var_0, "targetname");
  var_1 = common_scripts\utility::array_combine(var_1, var_2);
  var_2 = getvehiclenodearray(var_0, "targetname");
  var_1 = common_scripts\utility::array_combine(var_1, var_2);
  return var_1;
}

enable_ai_color() {
  if(isdefined(self.script_forcecolor)) {
    return;
  }
  if(!isdefined(self.old_forcecolor)) {
    return;
  }
  set_force_color(self.old_forcecolor);
  self.old_forcecolor = undefined;
}

enable_ai_color_dontmove() {
  self.dontcolormove = 1;
  enable_ai_color();
}

disable_ai_color() {
  if(isdefined(self.new_force_color_being_set)) {
    self endon("death");
    self waittill("done_setting_new_color");
  }

  self clearfixednodesafevolume();

  if(!isdefined(self.script_forcecolor)) {
    return;
  }
  self.old_forcecolor = self.script_forcecolor;
  level.arrays_of_colorforced_ai[self.team][self.script_forcecolor] = common_scripts\utility::array_remove(level.arrays_of_colorforced_ai[self.team][self.script_forcecolor], self);
  maps\_colors::left_color_node();
  self.script_forcecolor = undefined;
  self.currentcolorcode = undefined;
}

clear_force_color() {
  disable_ai_color();
}

check_force_color(var_0) {
  var_1 = level.colorchecklist[tolower(var_0)];

  if(isdefined(self.script_forcecolor) && var_1 == self.script_forcecolor)
    return 1;
  else
    return 0;
}

get_force_color() {
  var_0 = self.script_forcecolor;
  return var_0;
}

shortencolor(var_0) {
  return level.colorchecklist[tolower(var_0)];
}

set_force_color(var_0) {
  var_1 = shortencolor(var_0);

  if(!isai(self)) {
    set_force_color_spawner(var_1);
    return;
  }

  if(self.team == "allies") {
    self.fixednode = 1;
    self.fixednodesaferadius = 64;
    self.pathenemyfightdist = 0;
    self.pathenemylookahead = 0;
  }

  self.script_color_axis = undefined;
  self.script_color_allies = undefined;
  self.old_forcecolor = undefined;

  if(isdefined(self.script_forcecolor))
    level.arrays_of_colorforced_ai[self.team][self.script_forcecolor] = common_scripts\utility::array_remove(level.arrays_of_colorforced_ai[self.team][self.script_forcecolor], self);

  self.script_forcecolor = var_1;
  level.arrays_of_colorforced_ai[self.team][self.script_forcecolor] = common_scripts\utility::array_add(level.arrays_of_colorforced_ai[self.team][self.script_forcecolor], self);
  thread maps\_utility_code::new_color_being_set(var_1);
}

set_force_color_spawner(var_0) {
  self.script_forcecolor = var_0;
  self.old_forcecolor = undefined;
}

issue_color_orders(var_0, var_1) {
  var_2 = strtok(var_0, " ");
  var_3 = [];
  var_4 = [];

  for (var_5 = 0; var_5 < var_2.size; var_5++) {
    var_6 = undefined;

    if(issubstr(var_2[var_5], "r"))
      var_6 = "r";
    else if(issubstr(var_2[var_5], "b"))
      var_6 = "b";
    else if(issubstr(var_2[var_5], "y"))
      var_6 = "y";
    else if(issubstr(var_2[var_5], "c"))
      var_6 = "c";
    else if(issubstr(var_2[var_5], "g"))
      var_6 = "g";
    else if(issubstr(var_2[var_5], "p"))
      var_6 = "p";
    else if(issubstr(var_2[var_5], "o"))
      var_6 = "o";
    else if(issubstr(var_2[var_5], "w"))
      var_6 = "w";
    else if(issubstr(var_2[var_5], "a"))
      var_6 = "a";
    else if(issubstr(var_2[var_5], "l"))
      var_6 = "l";
    else {

    }

    var_4[var_6] = var_2[var_5];
    var_3[var_3.size] = var_6;
  }

  for (var_5 = 0; var_5 < var_2.size; var_5++) {
    level.arrays_of_colorcoded_spawners[var_1][var_2[var_5]] = common_scripts\utility::array_removeundefined(level.arrays_of_colorcoded_spawners[var_1][var_2[var_5]]);

    for (var_7 = 0; var_7 < level.arrays_of_colorcoded_spawners[var_1][var_2[var_5]].size; var_7++)
      level.arrays_of_colorcoded_spawners[var_1][var_2[var_5]][var_7].currentcolorcode = var_2[var_5];
  }

  for (var_5 = 0; var_5 < var_3.size; var_5++) {
    level.arrays_of_colorforced_ai[var_1][var_3[var_5]] = array_removedead(level.arrays_of_colorforced_ai[var_1][var_3[var_5]]);
    level.currentcolorforced[var_1][var_3[var_5]] = var_4[var_3[var_5]];
  }

  for (var_5 = 0; var_5 < var_2.size; var_5++)
    thread maps\_colors::issue_color_order_to_ai(var_2[var_5], var_3[var_5], var_1);
}

clear_color_order(var_0, var_1) {}

clear_all_color_orders(var_0) {}

replace_on_death() {
  thread maps\_colors::colornode_replace_on_death();
}

disable_replace_on_death() {
  self.replace_on_death = undefined;
  self notify("_disable_reinforcement");
}

stop_replace_on_death() {
  self notify("_disable_reinforcement");
}

stop_all_replace_on_death(var_0, var_1) {}

spawn_reinforcement(var_0, var_1, var_2, var_3) {
  if(!isdefined(var_3))
    var_3 = "allies";

  thread maps\_colors::colornode_spawn_reinforcement(var_0, var_1);
}

clear_promotion_order() {
  level.current_color_order = [];
}

set_promotion_order(var_0, var_1) {
  if(!isdefined(level.current_color_order))
    level.current_color_order = [];

  var_0 = shortencolor(var_0);
  var_1 = shortencolor(var_1);
  level.current_color_order[var_0] = var_1;

  if(!isdefined(level.current_color_order[var_1]))
    set_empty_promotion_order(var_1);
}

set_promotion_order_preh1(var_0, var_1) {}

set_empty_promotion_order(var_0) {
  if(!isdefined(level.current_color_order))
    level.current_color_order = [];

  level.current_color_order[var_0] = "none";
}

set_empty_promotion_order_preh1(var_0) {}

has_color() {
  if(self.team == "axis")
    return isdefined(self.script_color_axis) || isdefined(self.script_forcecolor);

  return isdefined(self.script_color_allies) || isdefined(self.script_forcecolor);
}

get_color_volume_from_trigger() {}

get_color_nodes_from_trigger() {}

flashrumbleloop(var_0) {
  var_1 = gettime() + var_0 * 1000;

  while (gettime() < var_1) {
    self playrumbleonentity("damage_heavy");
    wait 0.05;
  }
}

flashmonitorenablehealthshield(var_0) {
  self endon("death");
  self endon("flashed");
  wait 0.2;
  self enablehealthshield(0);
  wait(var_0 + 2);
  self enablehealthshield(1);
}

ninebanghandler(var_0, var_1, var_2, var_3, var_4) {
  var_5 = [0.8, 0.7, 0.7, 0.6];
  var_6 = [1.0, 0.8, 0.6, 0.6];

  foreach(var_12, var_8 in var_6) {
    var_9 = (var_1 - 0.85) / 0.15;

    if(var_9 > var_2)
      var_2 = var_9;

    if(var_2 < 0.25)
      var_2 = 0.25;

    var_10 = 0.3;

    if(var_1 > 1 - var_10)
      var_1 = 1.0;
    else
      var_1 = var_1 / (1 - var_10);

    if(var_4 != self.team)
      var_11 = var_1 * var_2 * 6.0;
    else
      var_11 = var_1 * var_2 * 3.0;

    if(var_11 < 0.25) {
      continue;
    }
    var_11 = var_8 * var_11;

    if(isdefined(self.maxflashedseconds) && var_11 > self.maxflashedseconds)
      var_11 = self.maxflashedseconds;

    self.flashingteam = var_4;
    self notify("flashed");
    self.flashendtime = gettime() + var_11 * 1000;
    self shellshock("flashbang", var_11);
    thread soundscripts\_audio::aud_set_flashbang();
    common_scripts\utility::flag_set("player_flashed");

    if(var_1 * var_2 > 0.5)
      thread flashmonitorenablehealthshield(var_11);

    wait(var_5[var_12]);
  }

  thread maps\_utility_code::unflash_flag(0.05);
}

flashmonitor() {
  self endon("death");

  for (;;) {
    self waittill("flashbang", var_0, var_1, var_2, var_3, var_4);

    if("1" == getdvar("noflash")) {
      continue;
    }
    if(is_player_down(self)) {
      continue;
    }
    if(isdefined(self.threw_ninebang)) {
      var_5 = 0.8;
      var_6 = 1.0 - var_5;
      self.threw_ninebang = undefined;

      if(var_1 < var_6) {
        continue;
      }
      var_1 = (var_1 - var_6) / var_5;
    }

    var_7 = (var_1 - 0.85) / 0.15;

    if(var_7 > var_2)
      var_2 = var_7;

    if(var_2 < 0.25)
      var_2 = 0.25;

    var_8 = 0.3;

    if(var_1 > 1 - var_8)
      var_1 = 1.0;
    else
      var_1 = var_1 / (1 - var_8);

    if(var_4 != self.team)
      var_9 = var_1 * var_2 * 6.0;
    else
      var_9 = var_1 * var_2 * 3.0;

    if(var_9 < 0.25) {
      continue;
    }
    if(isdefined(self.maxflashedseconds) && var_9 > self.maxflashedseconds)
      var_9 = self.maxflashedseconds;

    self.flashingteam = var_4;
    self notify("flashed");
    self.flashendtime = gettime() + var_9 * 1000;
    self shellshock("flashbang", var_9);
    thread soundscripts\_audio::aud_set_flashbang();
    self lightsetoverrideenableforplayer("flashed", 0.1);
    common_scripts\utility::flag_set("player_flashed");
    thread maps\_utility_code::unflash_flag(var_9);
    wait 0.1;

    if(isdefined(level.player.nightvision_enabled) && level.player.nightvision_enabled)
      level.player lightsetoverrideenableforplayer(level.nightvisionlightset, 0.1);
    else
      self lightsetoverridedisableforplayer(0.1);

    if(var_1 * var_2 > 0.5)
      thread flashmonitorenablehealthshield(var_9);

    if(var_9 > 2)
      thread flashrumbleloop(0.75);
    else
      thread flashrumbleloop(0.25);

    if(var_4 != "allies")
      thread flashnearbyallies(var_9, var_4);
  }
}

flashnearbyallies(var_0, var_1) {
  wait 0.05;
  var_2 = getaiarray("allies");

  for (var_3 = 0; var_3 < var_2.size; var_3++) {
    if(distancesquared(var_2[var_3].origin, self.origin) < 122500) {
      var_4 = var_0 + randomfloatrange(-1000, 1500);

      if(var_4 > 4.5)
        var_4 = 4.5;
      else if(var_4 < 0.25) {
        continue;
      }
      var_5 = gettime() + var_4 * 1000;

      if(!isdefined(var_2[var_3].flashendtime) || var_2[var_3].flashendtime < var_5) {
        var_2[var_3].flashingteam = var_1;
        var_2[var_3] flashbangstart(var_4);
      }
    }
  }
}

restarteffect() {
  common_scripts\_createfx::restart_fx_looper();
}

pauseexploder(var_0) {
  var_0 = var_0 + "";

  if(isdefined(level.createfxexploders)) {
    var_1 = level.createfxexploders[var_0];

    if(isdefined(var_1)) {
      foreach(var_3 in var_1)
      var_3 common_scripts\utility::pauseeffect();

      return;
    }
  } else {
    foreach(var_6 in level.createfxent) {
      if(!isdefined(var_6.v["exploder"])) {
        continue;
      }
      if(var_6.v["exploder"] != var_0) {
        continue;
      }
      var_6 common_scripts\utility::pauseeffect();
    }
  }
}

restartexploder(var_0) {
  var_0 = var_0 + "";

  if(isdefined(level.createfxexploders)) {
    var_1 = level.createfxexploders[var_0];

    if(isdefined(var_1)) {
      foreach(var_3 in var_1)
      var_3 restarteffect();

      return;
    }
  } else {
    foreach(var_6 in level.createfxent) {
      if(!isdefined(var_6.v["exploder"])) {
        continue;
      }
      if(var_6.v["exploder"] != var_0) {
        continue;
      }
      var_6 restarteffect();
    }
  }
}

getfxarraybyid(var_0) {
  var_1 = [];

  if(isdefined(level.createfxbyfxid)) {
    var_2 = level.createfxbyfxid[var_0];

    if(isdefined(var_2))
      var_1 = var_2;
  } else {
    for (var_3 = 0; var_3 < level.createfxent.size; var_3++) {
      if(level.createfxent[var_3].v["fxid"] == var_0)
        var_1[var_1.size] = level.createfxent[var_3];
    }
  }

  return var_1;
}

ignoreallenemies(var_0) {
  self notify("ignoreAllEnemies_threaded");
  self endon("ignoreAllEnemies_threaded");

  if(var_0) {
    self.old_threat_bias_group = self getthreatbiasgroup();
    var_1 = undefined;
    createthreatbiasgroup("ignore_everybody");
    self setthreatbiasgroup("ignore_everybody");
    var_2 = [];
    var_2["axis"] = "allies";
    var_2["allies"] = "axis";
    var_3 = getaiarray(var_2[self.team]);
    var_4 = [];

    for (var_5 = 0; var_5 < var_3.size; var_5++)
      var_4[var_3[var_5] getthreatbiasgroup()] = 1;

    var_6 = getarraykeys(var_4);

    for (var_5 = 0; var_5 < var_6.size; var_5++)
      setthreatbias(var_6[var_5], "ignore_everybody", 0);
  } else {
    var_1 = undefined;

    if(self.old_threat_bias_group != "")
      self setthreatbiasgroup(self.old_threat_bias_group);

    self.old_threat_bias_group = undefined;
  }
}

vehicle_detachfrompath() {
  maps\_vehicle_code::vehicle_pathdetach();
}

vehicle_resumepath() {
  thread maps\_vehicle_code::vehicle_resumepathvehicle();
}

vehicle_land(var_0) {
  maps\_vehicle_code::vehicle_landvehicle(var_0);
}

vehicle_liftoff(var_0) {
  maps\_vehicle_code::vehicle_liftoffvehicle(var_0);
}

vehicle_dynamicpath(var_0, var_1) {
  maps\_vehicle::vehicle_paths(var_0, var_1);
}

groundpos(var_0) {
  return bullettrace(var_0, var_0 + (0, 0, -100000), 0, self, 0, 0, 0, 0, 0, 1, 0, 1)["position"];
}

change_player_health_packets(var_0) {
  self.player_health_packets = self.player_health_packets + var_0;
  self notify("update_health_packets");

  if(self.player_health_packets >= 3)
    self.player_health_packets = 3;
}

getvehiclespawner(var_0) {
  var_1 = getvehiclespawnerarray(var_0);
  return var_1[0];
}

getvehiclespawnerarray(var_0) {
  return maps\_vehicle_code::_getvehiclespawnerarray(var_0);
}

describe_start(var_0, var_1, var_2, var_3, var_4, var_5) {
  add_start_assert();

  if(!isdefined(level.start_description))
    level.start_description = [];

  level.start_description[var_0] = add_start_construct(var_0, var_1, var_2, var_3, [var_4], var_5);
}

player_fudge_moveto(var_0, var_1) {
  if(!isdefined(var_1))
    var_1 = 200;

  var_2 = spawn("script_origin", level.player.origin);
  var_2.origin = level.player.origin;
  level.player playerlinkto(var_2);
  var_3 = distance(level.player.origin, var_0);
  var_4 = var_3 / var_1;
  var_2 moveto(var_0, var_3 / var_1, 0.05, 0.05);
  wait(var_4);
  level.player unlink();
}

add_start(var_0, var_1, var_2, var_3, var_4, var_5) {
  add_start_assert();
  var_0 = tolower(var_0);

  if(isdefined(var_4)) {
    if(var_4.size > 2) {
      var_6 = [];
      var_6[0] = var_4[0];
      var_6[1] = var_4[1];
      var_4 = var_6;
    }

    if(!isdefined(level.start_transients))
      level.start_transients = [];

    foreach(var_8 in var_4) {
      if(!common_scripts\utility::array_contains(level.start_transients, var_8))
        level.start_transients[level.start_transients.size] = var_8;
    }
  }

  if(isdefined(level.start_description) && isdefined(level.start_description[var_0]))
    var_11 = level.start_description[var_0];
  else
    var_11 = add_start_construct(var_0, var_1, var_2, var_3, var_4, var_5);

  if(!isdefined(var_1)) {
    if(!isdefined(level.start_description)) {

    } else if(!issubstr(var_0, "no_game")) {
      if(!isdefined(level.start_description[var_0]))
        return;
    }
  }

  level.start_functions[level.start_functions.size] = var_11;
  level.start_arrays[var_0] = var_11;
}

set_start_transients(var_0, var_1) {
  if(!isdefined(level.start_arrays)) {
    return;
  }
  if(!isdefined(level.start_arrays[var_0])) {
    return;
  }
  var_0 = tolower(var_0);

  if(var_1.size > 2) {
    var_2 = [];
    var_2[0] = var_1[0];
    var_2[1] = var_1[1];
    var_1 = var_2;
  }

  if(!isdefined(level.start_transients))
    level.start_transients = [];

  foreach(var_4 in var_1) {
    if(!common_scripts\utility::array_contains(level.start_transients, var_4))
      level.start_transients[level.start_transients.size] = var_4;
  }

  level.start_arrays[var_0]["transients_to_load"] = var_1;
}

is_no_game_start() {
  return issubstr(level.start_point, "no_game");
}

add_start_construct(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = [];
  var_6["name"] = var_0;
  var_6["start_func"] = var_1;
  var_6["start_loc_string"] = var_2;
  var_6["logic_func"] = var_3;
  var_6["transients_to_load"] = var_4;
  var_6["catchup_function"] = var_5;
  return var_6;
}

add_start_assert() {
  if(!isdefined(level.start_functions))
    level.start_functions = [];
}

level_has_start_points() {
  return level.start_functions.size > 1;
}

set_default_start(var_0) {
  level.default_start_override = var_0;
}

default_start(var_0) {
  level.default_start = var_0;
}

linetime(var_0, var_1, var_2, var_3) {
  thread maps\_utility_code::linetime_proc(var_0, var_1, var_2, var_3);
}

within_fov_2d(var_0, var_1, var_2, var_3) {
  var_4 = vectornormalize((var_2[0], var_2[1], 0) - (var_0[0], var_0[1], 0));
  var_5 = anglestoforward((0, var_1[1], 0));
  return vectordot(var_5, var_4) >= var_3;
}

get_dot(var_0, var_1, var_2) {
  var_3 = vectornormalize(var_2 - var_0);
  var_4 = anglestoforward(var_1);
  var_5 = vectordot(var_4, var_3);
  return var_5;
}

within_fov_of_players(var_0, var_1) {
  var_2 = undefined;

  for (var_3 = 0; var_3 < level.players.size; var_3++) {
    var_4 = level.players[var_3] geteye();
    var_2 = common_scripts\utility::within_fov(var_4, level.players[var_3] getplayerangles(), var_0, var_1);

    if(!var_2)
      return 0;
  }

  return 1;
}

waitspread(var_0, var_1) {
  if(!isdefined(var_1)) {
    var_1 = var_0;
    var_0 = 0;
  }

  wait(randomfloatrange(var_0, var_1));

  if(1) {
    return;
  }
  var_2 = undefined;

  if(!isdefined(level.active_wait_spread)) {
    level.active_wait_spread = 1;
    level.wait_spreaders = 0;
    var_2 = level.wait_spreaders;
    level.wait_spreaders++;
    thread maps\_utility_code::waitspread_code(var_0, var_1);
  } else {
    var_2 = level.wait_spreaders;
    level.wait_spreaders++;
    waittillframeend;
  }

  waittillframeend;
  wait(level.wait_spreader_allotment[var_2]);
}

wait_for_buffer_time_to_pass(var_0, var_1) {
  var_2 = var_1 * 1000 - (gettime() - var_0);
  var_2 = var_2 * 0.001;

  if(var_2 > 0)
    wait(var_2);
}

bcs_scripted_dialogue_start() {
  anim.scripteddialoguestarttime = gettime();
}

dialogue_queue(var_0) {
  var_1 = getsndaliasvalue(var_0, "squelchname");

  if(self == level || var_1 != "") {
    radio_dialogue(var_0, undefined, var_1);
    return;
  }

  bcs_scripted_dialogue_start();
  maps\_anim::anim_single_queue(self, var_0);
}

generic_dialogue_queue(var_0, var_1) {
  bcs_scripted_dialogue_start();
  maps\_anim::anim_generic_queue(self, var_0, undefined, undefined, var_1);
}

radio_dialogue(var_0, var_1, var_2) {
  if(!isdefined(level.player_radio_emitter)) {
    var_3 = spawn("script_origin", (0, 0, 0));
    var_3 linkto(level.player, "", (0, 0, 0), (0, 0, 0));
    level.player_radio_emitter = var_3;
  }

  bcs_scripted_dialogue_start();

  if(!isdefined(var_1))
    return level.player_radio_emitter function_stack(::radio_dialogue_play, var_0, var_2);
  else
    return level.player_radio_emitter function_stack_timeout(var_1, ::radio_dialogue_play, var_0, var_2);
}

radio_dialogue_play(var_0, var_1) {
  if(!isdefined(var_1))
    var_1 = "none";

  level.player_radio_squelch_out_queued = 0;

  if(var_1 != "none" && isdefined(level.scr_radio["squelches"][var_1]))
    play_sound_on_tag(level.scr_radio["squelches"][var_1]["on"], undefined, 1);

  var_2 = 0;

  if(isdefined(level.scr_radio[var_0]))
    var_2 = play_sound_on_tag(level.scr_radio[var_0], undefined, 1);
  else
    var_2 = play_sound_on_tag(var_0, undefined, 1);

  if(var_1 != "none" && isdefined(level.scr_radio["squelches"][var_1]))
    thread radio_try_squelch_out(var_1);

  return var_2;
}

radio_dialogue_overlap(var_0) {
  if(!isdefined(level.player_radio_emitter_overlap))
    level.player_radio_emitter_overlap = [];

  var_1 = spawn("script_origin", (0, 0, 0));
  level.player_radio_emitter_overlap[level.player_radio_emitter_overlap.size] = var_1;
  var_1 endon("death");
  thread delete_on_death_wait_sound(var_1, "sounddone");
  var_1.origin = level.player_radio_emitter.origin;
  var_1.angles = level.player_radio_emitter.angles;
  var_1 linkto(level.player_radio_emitter);
  var_1 playsound(level.scr_radio[var_0], "sounddone");

  if(!isdefined(maps\_utility_code::wait_for_sounddone_or_death(var_1)))
    var_1 stopsounds();

  wait 0.05;
  level.player_radio_emitter_overlap = common_scripts\utility::array_remove(level.player_radio_emitter_overlap, var_1);
  var_1 delete();
}

radio_dialogue_stop() {
  if(!isdefined(level.player_radio_emitter)) {
    return;
  }
  level.player_radio_emitter delete();
}

radio_dialogue_overlap_stop() {
  if(!isdefined(level.player_radio_emitter_overlap)) {
    return;
  }
  foreach(var_1 in level.player_radio_emitter_overlap) {
    if(isdefined(var_1)) {
      var_1 stopsounds();
      wait 0.05;
      var_1 delete();
    }
  }

  level.player_radio_emitter_overlap = undefined;
}

radio_dialogue_clear_stack() {
  if(!isdefined(level.player_radio_emitter)) {
    return;
  }
  level.player_radio_emitter function_stack_clear();
}

radio_dialogue_remove_from_stack(var_0) {
  if(!isdefined(level.player_radio_emitter)) {
    return;
  }
  if(!isdefined(level.player_radio_emitter.function_stack)) {
    return;
  }
  var_1 = [];
  var_2 = 0;
  var_3 = level.player_radio_emitter.function_stack.size;

  for (var_4 = 0; var_4 < var_3; var_4++) {
    if(var_4 == 0 && isdefined(level.player_radio_emitter.function_stack[0].function_stack_func_begun) && isdefined(level.player_radio_emitter.function_stack[0].function_stack_func_begun)) {
      var_1[var_1.size] = level.player_radio_emitter.function_stack[var_4];
      continue;
    }

    if(isdefined(level.player_radio_emitter.function_stack[var_4].param1) && level.player_radio_emitter.function_stack[var_4].param1 == var_0) {
      level.player_radio_emitter.function_stack[var_4] notify("death");
      level.player_radio_emitter.function_stack[var_4] = undefined;
      var_2 = 1;
      continue;
    }

    var_1[var_1.size] = level.player_radio_emitter.function_stack[var_4];
  }

  if(var_2)
    level.player_radio_emitter.function_stack = var_1;
}

radio_dialogue_interupt(var_0) {
  if(!isdefined(level.player_radio_emitter)) {
    var_1 = spawn("script_origin", (0, 0, 0));
    var_1 linkto(level.player, "", (0, 0, 0), (0, 0, 0));
    level.player_radio_emitter = var_1;
  }

  level.player_radio_emitter play_sound_on_tag(level.scr_radio[var_0], undefined, 1);
}

radio_dialogue_safe(var_0) {
  return radio_dialogue(var_0, 0.05);
}

smart_radio_dialogue(var_0, var_1) {
  var_2 = getsndaliasvalue(var_0, "squelchname");
  maps\_utility_code::add_to_radio(var_0);
  radio_dialogue(var_0, var_1, var_2);
}

smart_radio_dialogue_interrupt(var_0) {
  maps\_utility_code::add_to_radio(var_0);
  radio_dialogue_stop();
  radio_dialogue_interupt(var_0);
}

smart_radio_dialogue_overlap(var_0) {
  maps\_utility_code::add_to_radio(var_0);
  radio_dialogue_overlap(var_0);
}

smart_dialogue(var_0) {
  maps\_utility_code::add_to_dialogue(var_0);
  dialogue_queue(var_0);
}

smart_dialogue_generic(var_0) {
  maps\_utility_code::add_to_dialogue_generic(var_0);
  generic_dialogue_queue(var_0);
}

radio_try_squelch_out(var_0, var_1) {
  self endon("death");

  if(!isdefined(var_1))
    var_1 = 0.1;

  level.player_radio_squelch_out_queued = 1;
  wait(var_1);

  if(isdefined(level.player_radio_emitter) && level.player_radio_squelch_out_queued == 1)
    level.player_radio_emitter function_stack(::play_sound_on_tag, level.scr_radio["squelches"][var_0]["off"], undefined, 1);
}

radio_dialogue_queue(var_0, var_1) {
  radio_dialogue(var_0, undefined, var_1);
}

hint_create(var_0, var_1, var_2) {
  var_3 = spawnstruct();

  if(isdefined(var_1) && var_1 == 1)
    var_3.bg = newhudelem();

  var_3.elm = newhudelem();
  var_3 hint_position_internal(var_2);
  var_3.elm settext(var_0);
  return var_3;
}

hint_delete() {
  self notify("death");

  if(isdefined(self.elm))
    self.elm destroy();

  if(isdefined(self.bg))
    self.bg destroy();
}

hint_position_internal(var_0) {
  if(level.console)
    self.elm.fontscale = 2;
  else
    self.elm.fontscale = 1.6;

  self.elm.x = 0;
  self.elm.y = -40;
  self.elm.alignx = "center";
  self.elm.aligny = "bottom";
  self.elm.horzalign = "center";
  self.elm.vertalign = "middle";
  self.elm.sort = 1;
  self.elm.alpha = 0.8;

  if(!isdefined(self.bg)) {
    return;
  }
  self.bg.x = 0;
  self.bg.y = -40;
  self.bg.alignx = "center";
  self.bg.aligny = "middle";
  self.bg.horzalign = "center";
  self.bg.vertalign = "middle";
  self.bg.sort = -1;

  if(level.console)
    self.bg setshader("popmenu_bg", 650, 52);
  else
    self.bg setshader("popmenu_bg", 650, 42);

  if(!isdefined(var_0))
    var_0 = 0.5;

  self.bg.alpha = var_0;
}

string(var_0) {
  return "" + var_0;
}

is_string_a_number(var_0) {
  var_1 = float(var_0);
  return string(var_1) == var_0;
}

ignoreeachother(var_0, var_1) {
  setignoremegroup(var_0, var_1);
  setignoremegroup(var_1, var_0);
}

add_global_spawn_function(var_0, var_1, var_2, var_3, var_4) {
  var_5 = [];
  var_5["function"] = var_1;
  var_5["param1"] = var_2;
  var_5["param2"] = var_3;
  var_5["param3"] = var_4;
  level.spawn_funcs[var_0][level.spawn_funcs[var_0].size] = var_5;
}

remove_global_spawn_function(var_0, var_1) {
  var_2 = [];

  for (var_3 = 0; var_3 < level.spawn_funcs[var_0].size; var_3++) {
    if(level.spawn_funcs[var_0][var_3]["function"] != var_1)
      var_2[var_2.size] = level.spawn_funcs[var_0][var_3];
  }

  level.spawn_funcs[var_0] = var_2;
}

exists_global_spawn_function(var_0, var_1) {
  if(!isdefined(level.spawn_funcs))
    return 0;

  for (var_2 = 0; var_2 < level.spawn_funcs[var_0].size; var_2++) {
    if(level.spawn_funcs[var_0][var_2]["function"] == var_1)
      return 1;
  }

  return 0;
}

remove_spawn_function(var_0) {
  var_1 = [];

  foreach(var_3 in self.spawn_functions) {
    if(var_3["function"] == var_0) {
      continue;
    }
    var_1[var_1.size] = var_3;
  }

  self.spawn_functions = var_1;
}

add_spawn_function(var_0, var_1, var_2, var_3, var_4, var_5) {
  foreach(var_7 in self.spawn_functions) {
    if(var_7["function"] == var_0)
      return;
  }

  var_9 = [];
  var_9["function"] = var_0;
  var_9["param1"] = var_1;
  var_9["param2"] = var_2;
  var_9["param3"] = var_3;
  var_9["param4"] = var_4;
  var_9["param5"] = var_5;
  self.spawn_functions[self.spawn_functions.size] = var_9;
}

array_delete(var_0) {
  for (var_1 = 0; var_1 < var_0.size; var_1++)
    var_0[var_1] delete();
}

array_kill(var_0) {
  for (var_1 = 0; var_1 < var_0.size; var_1++)
    var_0[var_1] kill();
}

ignore_triggers(var_0) {
  self endon("death");
  self.ignoretriggers = 1;

  if(isdefined(var_0))
    wait(var_0);
  else
    wait 0.5;

  self.ignoretriggers = 0;
}

activate_trigger_with_targetname(var_0) {
  var_1 = getent(var_0, "targetname");
  var_1 activate_trigger();
}

activate_trigger_with_noteworthy(var_0) {
  var_1 = getent(var_0, "script_noteworthy");
  var_1 activate_trigger();
}

disable_trigger_with_targetname(var_0) {
  var_1 = getent(var_0, "targetname");
  var_1 common_scripts\utility::trigger_off();
}

disable_trigger_with_noteworthy(var_0) {
  var_1 = getent(var_0, "script_noteworthy");
  var_1 common_scripts\utility::trigger_off();
}

enable_trigger_with_targetname(var_0) {
  var_1 = getent(var_0, "targetname");
  var_1 common_scripts\utility::trigger_on();
}

enable_trigger_with_noteworthy(var_0) {
  var_1 = getent(var_0, "script_noteworthy");
  var_1 common_scripts\utility::trigger_on();
}

is_hero() {
  return isdefined(level.hero_list[get_ai_number()]);
}

get_ai_number() {
  if(!isdefined(self.unique_id))
    set_ai_number();

  return self.unique_id;
}

set_ai_number() {
  self.unique_id = "ai" + level.ai_number;
  self.ai_number = level.ai_number;
  level.ai_number++;
}

make_hero() {
  level.hero_list[self.unique_id] = 1;
}

unmake_hero() {
  level.hero_list[self.unique_id] = undefined;
}

get_heroes() {
  var_0 = [];
  var_1 = getaiarray("allies");

  for (var_2 = 0; var_2 < var_1.size; var_2++) {
    if(var_1[var_2] is_hero())
      var_0[var_0.size] = var_1[var_2];
  }

  return var_0;
}

set_team_pacifist(var_0, var_1) {
  var_2 = getaiarray(var_0);

  for (var_3 = 0; var_3 < var_2.size; var_3++)
    var_2[var_3].pacifist = var_1;
}

remove_dead_from_array(var_0) {
  var_1 = [];

  foreach(var_3 in var_0) {
    if(!isalive(var_3)) {
      continue;
    }
    var_1[var_1.size] = var_3;
  }

  return var_1;
}

remove_heroes_from_array(var_0) {
  var_1 = [];

  for (var_2 = 0; var_2 < var_0.size; var_2++) {
    if(var_0[var_2] is_hero()) {
      continue;
    }
    var_1[var_1.size] = var_0[var_2];
  }

  return var_1;
}

remove_all_animnamed_guys_from_array(var_0) {
  var_1 = [];

  for (var_2 = 0; var_2 < var_0.size; var_2++) {
    if(isdefined(var_0[var_2].animname)) {
      continue;
    }
    var_1[var_1.size] = var_0[var_2];
  }

  return var_1;
}

remove_color_from_array(var_0, var_1) {
  var_2 = [];

  for (var_3 = 0; var_3 < var_0.size; var_3++) {
    var_4 = var_0[var_3];

    if(!isdefined(var_4.script_forcecolor)) {
      continue;
    }
    if(var_4.script_forcecolor == var_1) {
      continue;
    }
    var_2[var_2.size] = var_4;
  }

  return var_2;
}

remove_noteworthy_from_array(var_0, var_1) {
  var_2 = [];

  for (var_3 = 0; var_3 < var_0.size; var_3++) {
    var_4 = var_0[var_3];

    if(!isdefined(var_4.script_noteworthy)) {
      continue;
    }
    if(var_4.script_noteworthy == var_1) {
      continue;
    }
    var_2[var_2.size] = var_4;
  }

  return var_2;
}

get_closest_colored_friendly(var_0, var_1) {
  var_2 = get_force_color_guys("allies", var_0);
  var_2 = remove_heroes_from_array(var_2);

  if(!isdefined(var_1))
    var_3 = level.player.origin;
  else
    var_3 = var_1;

  return common_scripts\utility::getclosest(var_3, var_2);
}

remove_without_classname(var_0, var_1) {
  var_2 = [];

  for (var_3 = 0; var_3 < var_0.size; var_3++) {
    if(!issubstr(var_0[var_3].classname, var_1)) {
      continue;
    }
    var_2[var_2.size] = var_0[var_3];
  }

  return var_2;
}

remove_without_model(var_0, var_1) {
  var_2 = [];

  for (var_3 = 0; var_3 < var_0.size; var_3++) {
    if(!issubstr(var_0[var_3].model, var_1)) {
      continue;
    }
    var_2[var_2.size] = var_0[var_3];
  }

  return var_2;
}

get_closest_colored_friendly_with_classname(var_0, var_1, var_2) {
  var_3 = get_force_color_guys("allies", var_0);
  var_3 = remove_heroes_from_array(var_3);

  if(!isdefined(var_2))
    var_4 = level.player.origin;
  else
    var_4 = var_2;

  var_3 = remove_without_classname(var_3, var_1);
  return common_scripts\utility::getclosest(var_4, var_3);
}

promote_nearest_friendly(var_0, var_1) {
  for (;;) {
    var_2 = get_closest_colored_friendly(var_0);

    if(!isalive(var_2)) {
      wait 1;
      continue;
    }

    var_2 set_force_color(var_1);
    return;
  }
}

instantly_promote_nearest_friendly(var_0, var_1) {
  for (;;) {
    var_2 = get_closest_colored_friendly(var_0);

    if(!isalive(var_2)) {
      return;
    }
    var_2 set_force_color(var_1);
    return;
  }
}

instantly_promote_nearest_friendly_with_classname(var_0, var_1, var_2) {
  for (;;) {
    var_3 = get_closest_colored_friendly_with_classname(var_0, var_2);

    if(!isalive(var_3)) {
      return;
    }
    var_3 set_force_color(var_1);
    return;
  }
}

promote_nearest_friendly_with_classname(var_0, var_1, var_2) {
  for (;;) {
    var_3 = get_closest_colored_friendly_with_classname(var_0, var_2);

    if(!isalive(var_3)) {
      wait 1;
      continue;
    }

    var_3 set_force_color(var_1);
    return;
  }
}

riotshield_lock_orientation(var_0) {
  self orientmode("face angle", var_0);
  self.lockorientation = 1;
}

riotshield_unlock_orientation() {
  self.lockorientation = 0;
}

instantly_set_color_from_array_with_classname(var_0, var_1, var_2) {
  var_3 = 0;
  var_4 = [];

  for (var_5 = 0; var_5 < var_0.size; var_5++) {
    var_6 = var_0[var_5];

    if(var_3 || !issubstr(var_6.classname, var_2)) {
      var_4[var_4.size] = var_6;
      continue;
    }

    var_3 = 1;
    var_6 set_force_color(var_1);
  }

  return var_4;
}

instantly_set_color_from_array(var_0, var_1) {
  var_2 = 0;
  var_3 = [];

  for (var_4 = 0; var_4 < var_0.size; var_4++) {
    var_5 = var_0[var_4];

    if(var_2) {
      var_3[var_3.size] = var_5;
      continue;
    }

    var_2 = 1;
    var_5 set_force_color(var_1);
  }

  return var_3;
}

wait_for_script_noteworthy_trigger(var_0) {
  maps\_utility_code::wait_for_trigger(var_0, "script_noteworthy");
}

wait_for_targetname_trigger(var_0) {
  maps\_utility_code::wait_for_trigger(var_0, "targetname");
}

wait_for_flag_or_timeout(var_0, var_1) {
  if(common_scripts\utility::flag(var_0)) {
    return;
  }
  level endon(var_0);
  wait(var_1);
}

wait_for_notify_or_timeout(var_0, var_1) {
  self endon(var_0);
  wait(var_1);
}

wait_for_trigger_or_timeout(var_0) {
  self endon("trigger");
  wait(var_0);
}

wait_for_either_trigger(var_0, var_1) {
  var_2 = spawnstruct();
  var_3 = [];
  var_3 = common_scripts\utility::array_combine(var_3, getentarray(var_0, "targetname"));
  var_3 = common_scripts\utility::array_combine(var_3, getentarray(var_1, "targetname"));

  for (var_4 = 0; var_4 < var_3.size; var_4++)
    var_2 thread maps\_utility_code::ent_waits_for_trigger(var_3[var_4]);

  var_2 waittill("done");
}

dronespawn_bodyonly(var_0) {
  var_1 = maps\_spawner::spawner_dronespawn(var_0);
  return var_1;
}

dronespawn(var_0, var_1) {
  if(!isdefined(var_0))
    var_0 = self;

  var_2 = maps\_spawner::spawner_dronespawn(var_0);

  if(isdefined(var_1) && var_1)
    var_2[[level.drone_spawn_func]]();

  var_2.spawn_funcs = var_0.spawn_functions;
  var_2 thread maps\_spawner::run_spawn_functions();
  var_2.spawner = var_0;
  return var_2;
}

swap_ai_to_drone(var_0) {
  return maps\_spawner::spawner_swap_ai_to_drone(var_0);
}

swap_drone_to_ai(var_0) {
  return maps\_spawner::spawner_swap_drone_to_ai(var_0);
}

get_trigger_flag() {
  if(isdefined(self.script_flag))
    return self.script_flag;

  if(isdefined(self.script_noteworthy))
    return self.script_noteworthy;
}

set_default_pathenemy_settings() {
  self.pathenemylookahead = 350;
  self.pathenemyfightdist = 350;
}

cqb_walk(var_0) {
  if(var_0 == "on")
    enable_cqbwalk();
  else
    disable_cqbwalk();
}

enable_cqbwalk(var_0) {
  if(self.type == "dog") {
    return;
  }
  if(!isdefined(var_0))
    self.cqbenabled = 1;

  self.cqbwalking = 1;
  self.turnrate = 0.2;
  level thread animscripts\cqb::findcqbpointsofinterest();
}

disable_cqbwalk() {
  if(self.type == "dog") {
    return;
  }
  if(isdefined(self.cqbenabled))
    self.cqbdisabledtime = gettime();

  self.cqbwalking = undefined;
  self.cqbenabled = undefined;
  self.turnrate = 0.3;
  self.cqb_point_of_interest = undefined;
}

enable_readystand() {
  self.busereadyidle = 1;
}

disable_readystand() {
  self.busereadyidle = undefined;
}

cqb_aim(var_0) {
  if(!isdefined(var_0))
    self.cqb_target = undefined;
  else {
    self.cqb_target = var_0;

    if(!isdefined(var_0.origin))
      return;
  }
}

set_force_cover(var_0) {
  if(isdefined(var_0) && var_0)
    self.forcesuppression = 1;
  else
    self.forcesuppression = undefined;
}

do_in_order(var_0, var_1, var_2, var_3) {
  if(isdefined(var_1))
    [[var_0]](var_1);
  else
    [
      [var_0]
    ]();

  if(isdefined(var_3))
    [[var_2]](var_3);
  else
    [
      [var_2]
    ]();
}

scrub() {
  maps\_spawner::scrub_guy();
}

send_notify(var_0, var_1) {
  if(isdefined(var_1))
    self notify(var_0, var_1);
  else
    self notify(var_0);
}

waittill_match_or_timeout(var_0, var_1, var_2) {
  var_3 = spawnstruct();
  var_3 endon("complete");
  var_3 delaythread(var_2, ::send_notify, "complete");
  self waittillmatch(var_0, var_1);
}

deleteent(var_0) {
  var_0 notify("deleted");
  var_0 delete();
}

first_touch(var_0) {
  if(!isdefined(self.touched))
    self.touched = [];

  if(isdefined(self.touched[var_0.unique_id]))
    return 0;

  self.touched[var_0.unique_id] = 1;
  return 1;
}

getanim(var_0) {
  return level.scr_anim[self.animname][var_0];
}

hasanim(var_0) {
  return isdefined(level.scr_anim[self.animname][var_0]);
}

getanim_from_animname(var_0, var_1) {
  return level.scr_anim[var_1][var_0];
}

getanim_generic(var_0) {
  return level.scr_anim["generic"][var_0];
}

add_hint_string(var_0, var_1, var_2, var_3) {
  if(!isdefined(level.trigger_hint_string)) {
    level.trigger_hint_string = [];
    level.trigger_hint_func = [];
    level.trigger_hint_doubleline = [];
  }

  if(isdefined(level.trigger_hint_string[var_0])) {}

  level.trigger_hint_string[var_0] = var_1;
  precachestring(var_1);

  if(isdefined(var_2))
    level.trigger_hint_func[var_0] = var_2;

  if(isdefined(var_3))
    level.trigger_hint_doubleline[var_0] = var_3;
}

show_hint(var_0) {
  thread maps\_utility_code::showhintprint_struct(var_0);
}

hide_hint(var_0) {
  var_0.timeout = 1;
}

fire_radius(var_0, var_1) {
  var_2 = spawn("trigger_radius", var_0, 0, var_1, 48);

  for (;;) {
    var_2 waittill("trigger", var_3);
    level.player dodamage(5, var_0);
  }
}

clearthreatbias(var_0, var_1) {
  setthreatbias(var_0, var_1, 0);
  setthreatbias(var_1, var_0, 0);
}

throwgrenadeatplayerasap() {
  animscripts\combat_utility::throwgrenadeatplayerasap_combat_utility();
}

array_combine_keys(var_0, var_1) {
  if(!var_0.size)
    return var_1;

  var_2 = getarraykeys(var_1);

  for (var_3 = 0; var_3 < var_2.size; var_3++)
    var_0[var_2[var_3]] = var_1[var_2[var_3]];

  return var_0;
}

set_ignoresuppression(var_0) {
  self.ignoresuppression = var_0;
}

set_goalradius(var_0) {
  self.goalradius = var_0;
}

try_forever_spawn() {
  var_0 = self.export;

  for (;;) {
    var_1 = self dospawn();

    if(spawn_failed(var_1)) {
      wait 1;
      continue;
    }

    return var_1;
  }
}

set_allowdeath(var_0) {
  self.allowdeath = var_0;
}

set_run_anim(var_0, var_1, var_2) {
  if(isdefined(var_1))
    self.alwaysrunforward = var_1;
  else
    self.alwaysrunforward = 1;

  if(!isdefined(var_2) || var_2)
    disable_turnanims();

  self.run_overrideanim = level.scr_anim[self.animname][var_0];
  self.walk_overrideanim = self.run_overrideanim;
}

set_dog_walk_anim() {
  self.a.movement = "walk";
  self.disablearrivals = 1;
  self.disableexits = 1;
  self.script_nobark = 1;
}

set_combat_stand_animset(var_0, var_1, var_2, var_3) {
  animscripts\animset::init_animset_custom_stand(var_0, var_1, var_2, var_3);
}

set_move_animset(var_0, var_1, var_2) {
  var_3 = animscripts\utility::lookupanimarray(var_0);

  if(isarray(var_1)) {
    var_3["straight"] = var_1[0];
    var_3["move_f"] = var_1[0];
    var_3["move_l"] = var_1[1];
    var_3["move_r"] = var_1[2];
    var_3["move_b"] = var_1[3];
  } else {
    var_3["straight"] = var_1;
    var_3["move_f"] = var_1;
  }

  if(isdefined(var_2))
    var_3["sprint"] = var_2;

  self.custommoveanimset[var_0] = var_3;
}

set_generic_idle_anim(var_0) {
  var_1 = level.scr_anim["generic"][var_0];

  if(isarray(var_1))
    self.specialidleanim = var_1;
  else
    self.specialidleanim[0] = var_1;
}

set_idle_anim(var_0) {
  var_1 = level.scr_anim[self.animname][var_0];

  if(isarray(var_1))
    self.specialidleanim = var_1;
  else
    self.specialidleanim[0] = var_1;
}

clear_generic_idle_anim() {
  self.specialidleanim = undefined;
  self notify("stop_specialidle");
}

set_generic_run_anim(var_0, var_1, var_2) {
  set_generic_run_anim_array(var_0, undefined, var_1, var_2);
}

clear_generic_run_anim() {
  self notify("movemode");
  enable_turnanims();
  self.run_overrideanim = undefined;
  self.walk_overrideanim = undefined;
}

set_generic_run_anim_array(var_0, var_1, var_2, var_3) {
  self notify("movemode");

  if(!isdefined(var_2) || var_2)
    self.alwaysrunforward = 1;
  else
    self.alwaysrunforward = undefined;

  if(!isdefined(var_3) || var_3)
    disable_turnanims();

  self.run_overrideanim = level.scr_anim["generic"][var_0];
  self.walk_overrideanim = self.run_overrideanim;

  if(isdefined(var_1)) {
    self.run_override_weights = level.scr_anim["generic"][var_1];
    self.walk_override_weights = self.run_override_weights;
  } else {
    self.run_override_weights = undefined;
    self.walk_override_weights = undefined;
  }
}

set_run_anim_array(var_0, var_1, var_2, var_3) {
  self notify("movemode");

  if(!isdefined(var_2) || var_2)
    self.alwaysrunforward = 1;
  else
    self.alwaysrunforward = undefined;

  if(!isdefined(var_3) || var_3)
    disable_turnanims();

  self.run_overrideanim = level.scr_anim[self.animname][var_0];
  self.walk_overrideanim = self.run_overrideanim;

  if(isdefined(var_1)) {
    self.run_override_weights = level.scr_anim[self.animname][var_1];
    self.walk_override_weights = self.run_override_weights;
  } else {
    self.run_override_weights = undefined;
    self.walk_override_weights = undefined;
  }
}

clear_run_anim() {
  self notify("clear_run_anim");
  self notify("movemode");

  if(self.type == "dog") {
    self.a.movement = "run";
    self.disablearrivals = 0;
    self.disableexits = 0;
    self.script_nobark = undefined;
    return;
  }

  if(!isdefined(self.casual_killer))
    enable_turnanims();

  self.alwaysrunforward = undefined;
  self.run_overrideanim = undefined;
  self.walk_overrideanim = undefined;
  self.run_override_weights = undefined;
  self.walk_override_weights = undefined;
}

debugvar(var_0, var_1) {
  setdvarifuninitialized(var_0, var_1);
  return getdvarfloat(var_0);
}

physicsjolt_proximity(var_0, var_1, var_2) {
  self endon("death");
  self endon("stop_physicsjolt");

  if(!isdefined(var_0) || !isdefined(var_1) || !isdefined(var_2)) {
    var_0 = 400;
    var_1 = 256;
    var_2 = (0, 0, 0.075);
  }

  var_3 = var_0 * var_0;
  var_4 = 3;
  var_5 = var_2;

  for (;;) {
    wait 0.1;
    var_2 = var_5;

    if(self.code_classname == "script_vehicle") {
      var_6 = self vehicle_getspeed();

      if(var_6 < var_4) {
        var_7 = var_6 / var_4;
        var_2 = var_5 * var_7;
      }
    }

    var_8 = distancesquared(self.origin, level.player.origin);
    var_7 = var_3 / var_8;

    if(var_7 > 1)
      var_7 = 1;

    var_2 = var_2 * var_7;
    var_9 = var_2[0] + var_2[1] + var_2[2];

    if(var_9 > 0.025)
      physicsjitter(self.origin, var_0, var_1, var_2[2], var_2[2] * 2.0);
  }
}

set_goal_entity(var_0) {
  self setgoalentity(var_0);
}

activate_trigger(var_0, var_1, var_2) {
  if(!isdefined(var_0))
    activate_trigger_process(var_2);
  else
    common_scripts\utility::array_thread(getentarray(var_0, var_1), ::activate_trigger_process, var_2);
}

activate_trigger_process(var_0) {
  if(isdefined(self.script_color_allies)) {
    self.activated_color_trigger = 1;
    maps\_colors::activate_color_trigger("allies");
  }

  if(isdefined(self.script_color_axis)) {
    self.activated_color_trigger = 1;
    maps\_colors::activate_color_trigger("axis");
  }

  self notify("trigger", var_0);
}

self_delete() {
  self delete();
}

remove_nocolor_from_array(var_0) {
  var_1 = [];

  for (var_2 = 0; var_2 < var_0.size; var_2++) {
    var_3 = var_0[var_2];

    if(var_3 has_color())
      var_1[var_1.size] = var_3;
  }

  return var_1;
}

clear_colors() {
  clear_team_colors("axis");
  clear_team_colors("allies");
}

clear_team_colors(var_0) {
  level.currentcolorforced[var_0]["r"] = undefined;
  level.currentcolorforced[var_0]["b"] = undefined;
  level.currentcolorforced[var_0]["c"] = undefined;
  level.currentcolorforced[var_0]["y"] = undefined;
  level.currentcolorforced[var_0]["p"] = undefined;
  level.currentcolorforced[var_0]["o"] = undefined;
  level.currentcolorforced[var_0]["g"] = undefined;
  level.currentcolorforced[var_0]["w"] = undefined;
  level.currentcolorforced[var_0]["a"] = undefined;
  level.currentcolorforced[var_0]["l"] = undefined;
}

get_script_palette() {
  var_0 = [];
  var_0["r"] = (1, 0, 0);
  var_0["o"] = (1, 0.5, 0);
  var_0["y"] = (1, 1, 0);
  var_0["g"] = (0, 1, 0);
  var_0["c"] = (0, 1, 1);
  var_0["b"] = (0, 0, 1);
  var_0["p"] = (1, 0, 1);
  var_0["w"] = (1, 1, 1);
  var_0["a"] = (0, 0.9, 1);
  var_0["l"] = (0.8, 1, 0);
  return var_0;
}

notify_delay(var_0, var_1) {
  self endon("death");

  if(var_1 > 0)
    wait(var_1);

  if(!isdefined(self)) {
    return;
  }
  self notify(var_0);
}

gun_remove() {
  if(isai(self))
    animscripts\shared::placeweaponon(self.weapon, "none");
  else {
    detach_attachments_from_weapon_model(self.weapon);
    self detach(getweaponmodel(self.weapon), "tag_weapon_right");
  }
}

gun_recall() {
  if(isai(self))
    animscripts\shared::placeweaponon(self.weapon, "right");
  else {
    self attach(getweaponmodel(self.weapon), "tag_weapon_right");
    update_weapon_tag_visibility(self.weapon);
  }
}

update_weapon_tag_visibility(var_0) {
  if(isdefined(var_0) && var_0 != "none") {
    var_1 = getweaponandattachmentmodels(var_0);
    var_2 = array_remove_index(var_1, 0);

    foreach(var_4 in var_2)
    self attach(var_4["worldModel"], var_4["attachTag"]);

    self hideweapontags(var_0);
  }
}

detach_attachments_from_weapon_model(var_0) {
  if(isdefined(var_0) && var_0 != "none") {
    var_1 = getweaponandattachmentmodels(var_0);
    var_2 = array_remove_index(var_1, 0);

    foreach(var_4 in var_2)
    self detach(var_4["worldModel"], var_4["attachTag"], 0);
  }
}

attach_player_current_weapon_to_rig(var_0) {
  var_1 = level.player getcurrentweapon();
  var_2 = getweaponandattachmentmodels(var_1);
  var_3 = var_2[0]["weapon"];
  var_4 = array_remove_index(var_2, 0);
  var_0 attach(var_3, "TAG_WEAPON_RIGHT", 1);

  foreach(var_6 in var_4)
  var_0 attach(var_6["attachment"], var_6["attachTag"]);

  var_0 hideweapontags(var_1);
}

place_weapon_on(var_0, var_1) {
  if(!animscripts\utility::aihasweapon(var_0))
    animscripts\init::initweapon(var_0);

  animscripts\shared::placeweaponon(var_0, var_1);
}

forceuseweapon(var_0, var_1) {
  if(!animscripts\init::isweaponinitialized(var_0))
    animscripts\init::initweapon(var_0);

  var_2 = self.weapon != "none";
  var_3 = animscripts\utility::usingsidearm();
  var_4 = var_1 == "sidearm";
  var_5 = var_1 == "secondary";

  if(var_2 && var_3 != var_4) {
    if(var_3)
      var_6 = "none";
    else if(var_5)
      var_6 = "back";
    else
      var_6 = "chest";

    animscripts\shared::placeweaponon(self.weapon, var_6);
    self.lastweapon = self.weapon;
  } else
    self.lastweapon = var_0;

  animscripts\shared::placeweaponon(var_0, "right");

  if(var_4)
    self.sidearm = var_0;
  else if(var_5)
    self.secondaryweapon = var_0;
  else
    self.primaryweapon = var_0;

  self.weapon = var_0;
  self.bulletsinclip = weaponclipsize(self.weapon);
  self notify("weapon_switch_done");
}

lerp_player_view_to_tag(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  maps\_utility_code::lerp_player_view_to_tag_internal(level.player, var_0, var_1, var_2, var_3, var_4, var_5, var_6, 0);
}

lerp_player_view_to_tag_smoothly(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  maps\_utility_code::lerp_player_view_to_tag_smoothly_internal(level.player, var_0, var_1, var_2, var_3, var_4, var_5, var_6);
}

lerp_player_view_to_tag_preh1(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  maps\_utility_code::lerp_player_view_to_tag_internal(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, 0);
}

lerp_player_view_to_tag_and_hit_geo(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  maps\_utility_code::lerp_player_view_to_tag_internal(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, 1);
}

lerp_player_view_to_position(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  var_9 = get_player_from_self();
  var_10 = spawn("script_origin", (0, 0, 0));
  var_10.origin = var_9.origin;
  var_10.angles = var_9 getplayerangles();

  if(isdefined(var_8) && var_8)
    var_9 playerlinkto(var_10, "", var_3, var_4, var_5, var_6, var_7, var_8);
  else if(isdefined(var_4))
    var_9 playerlinkto(var_10, "", var_3, var_4, var_5, var_6, var_7);
  else if(isdefined(var_3))
    var_9 playerlinkto(var_10, "", var_3);
  else
    var_9 playerlinkto(var_10);

  var_10 moveto(var_0, var_2, var_2 * 0.25);
  var_10 rotateto(var_1, var_2, var_2 * 0.25);
  wait(var_2);
  var_10 delete();
}

lerp_player_view_to_tag_oldstyle(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  maps\_utility_code::lerp_player_view_to_tag_oldstyle_internal(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, 0);
}

lerp_player_view_to_position_oldstyle(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  var_9 = get_player_from_self();
  var_10 = spawn("script_origin", (0, 0, 0));
  var_10.origin = var_9 get_player_feet_from_view();
  var_10.angles = var_9 getplayerangles();

  if(isdefined(var_8))
    var_9 playerlinktodelta(var_10, "", var_3, var_4, var_5, var_6, var_7, var_8);
  else if(isdefined(var_4))
    var_9 playerlinktodelta(var_10, "", var_3, var_4, var_5, var_6, var_7);
  else if(isdefined(var_3))
    var_9 playerlinktodelta(var_10, "", var_3);
  else
    var_9 playerlinktodelta(var_10);

  var_10 moveto(var_0, var_2, var_2 * 0.25);
  var_10 rotateto(var_1, var_2, var_2 * 0.25);
  wait(var_2);
  var_10 delete();
}

lerp_player_view_to_position_leave_linked(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  var_8 = get_player_from_self();
  var_9 = spawn("script_origin", (0, 0, 0));
  var_9.origin = level.player get_player_feet_from_view();
  var_9.angles = var_8 getplayerangles();

  if(isdefined(var_4))
    var_8 playerlinktodelta(var_9, "", var_3, var_4, var_5, var_6, var_7);
  else if(isdefined(var_3))
    var_8 playerlinktodelta(var_9, "", var_3);
  else
    var_8 playerlinktodelta(var_9);

  var_9 moveto(var_0, var_2, var_2 * 0.25);
  var_9 rotateto(var_1, var_2, var_2 * 0.25);
  wait(var_2);
  return var_9;
}

timer(var_0) {
  wait(var_0);
}

player_moves(var_0) {
  var_1 = level.player.origin;

  for (;;) {
    if(distance(var_1, level.player.origin) > var_0) {
      break;
    }

    wait 0.05;
  }
}

waittill_either_function(var_0, var_1, var_2, var_3) {
  var_4 = spawnstruct();
  thread maps\_utility_code::waittill_either_function_internal(var_4, var_0, var_1);
  thread maps\_utility_code::waittill_either_function_internal(var_4, var_2, var_3);
  var_4 waittill("done");
}

waittill_msg(var_0) {
  self waittill(var_0);
}

display_hint(var_0, var_1, var_2, var_3, var_4) {
  var_5 = get_player_from_self();

  if(isdefined(level.trigger_hint_func[var_0])) {
    if(var_5[[level.trigger_hint_func[var_0]]]()) {
      return;
    }
    var_5 thread maps\_utility_code::hintprint(level.trigger_hint_string[var_0], level.trigger_hint_func[var_0], var_1, var_2, var_3, undefined, undefined, var_4, level.trigger_hint_doubleline[var_0]);
  } else
    var_5 thread maps\_utility_code::hintprint(level.trigger_hint_string[var_0], undefined, undefined, undefined, undefined, undefined, undefined, var_4, level.trigger_hint_doubleline[var_0]);
}

hintdisplayhandler(var_0, var_1, var_2, var_3, var_4, var_5) {
  maps\_utility_code::hintdisplayhandlersetup(var_0);

  if(!isdefined(var_1))
    display_hint(var_0, var_2, var_3, var_4, var_5);
  else
    display_hint_timeout(var_0, var_1, var_2, var_3, var_4, var_5);
}

hintdisplaymintimehandler(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = get_player_from_self();

  if(var_6[[level.trigger_hint_func[var_0]]]()) {
    return;
  }
  maps\_utility_code::hintdisplayhandlersetup(var_0);
  var_6 thread maps\_utility_code::hintprint(level.trigger_hint_string[var_0], level.trigger_hint_func[var_0], var_3, var_4, var_5, var_1, var_2, undefined, level.trigger_hint_doubleline[var_0]);
}

add_control_based_hint_strings(var_0, var_1, var_2, var_3, var_4) {
  if(!isdefined(level.trigger_hint_string)) {
    level.trigger_hint_string = [];
    level.trigger_hint_func = [];
  }

  level.trigger_hint_string[var_0] = var_1;
  level.hint_list[var_0]["gamepad"] = var_1;
  level.hint_list[var_0]["pc"] = var_3;
  level.hint_list[var_0]["southpaw"] = var_4;
  precachestring(var_1);

  if(isdefined(var_3))
    precachestring(var_3);

  if(isdefined(var_4))
    precachestring(var_4);

  if(isdefined(var_2))
    level.trigger_hint_func[var_0] = var_2;
}

handletriggerhintinputtypetext() {
  if(!isdefined(level.hint_triggers))
    level.hint_triggers = [];

  for (;;) {
    level.hint_triggers = common_scripts\utility::array_removeundefined(level.hint_triggers);

    if(isdefined(level.hint_triggers) && isdefined(level.player)) {
      foreach(var_1 in level.hint_triggers) {
        if(level.player common_scripts\utility::is_player_gamepad_enabled()) {
          var_1 sethintstring(var_1.gp_hint_text);
          continue;
        }

        var_1 sethintstring(var_1.pc_hint_text);
      }
    }

    wait 0.1;
  }
}

addhinttrigger(var_0, var_1) {
  if(!isdefined(level.hint_triggers)) {
    thread handletriggerhintinputtypetext();
    level.hint_triggers = [];
  }

  var_2 = 0;

  foreach(var_4 in level.hint_triggers) {
    if(self == var_4) {
      var_4.gp_hint_text = var_0;
      var_4.pc_hint_text = var_1;
      var_2 = 1;
      break;
    }
  }

  if(!var_2) {
    self.gp_hint_text = var_0;
    self.pc_hint_text = var_1;
    level.hint_triggers = common_scripts\utility::array_add(level.hint_triggers, self);
  }
}

display_hint_timeout(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = get_player_from_self();

  if(var_6[[level.trigger_hint_func[var_0]]]()) {
    return;
  }
  var_6 thread maps\_utility_code::hintprint(level.trigger_hint_string[var_0], level.trigger_hint_func[var_0], var_2, var_3, var_4, var_1, undefined, var_5, level.trigger_hint_doubleline[var_0]);
}

display_hint_timeout_mintime(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = get_player_from_self();

  if(var_6[[level.trigger_hint_func[var_0]]]()) {
    return;
  }
  var_6 thread maps\_utility_code::hintprint(level.trigger_hint_string[var_0], level.trigger_hint_func[var_0], var_3, var_4, var_5, var_1, var_2, undefined, level.trigger_hint_doubleline[var_0]);
}

display_hint_stick(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(!isdefined(var_6))
    var_6 = 0;

  var_10 = maps\_utility_code::hint_stick_get_updated(var_0, var_1, var_2, var_3, var_4, var_5, var_6);
  thread display_hint(var_10, var_7, var_8, var_9);
  thread maps\_utility_code::hint_stick_update(var_0, var_1, var_2, var_3, var_4, var_5, var_6);
}

display_hint_stick_timeout(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  if(!isdefined(var_7))
    var_7 = 0;

  var_11 = maps\_utility_code::hint_stick_get_updated(var_0, var_2, var_3, var_4, var_5, var_6, var_7);
  thread display_hint_timeout(var_11, var_1, var_8, var_9, var_10);
  thread maps\_utility_code::hint_stick_update(var_0, var_2, var_3, var_4, var_5, var_6, var_7);
}

display_hint_stick_timeout_mintime(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11) {
  if(!isdefined(var_8))
    var_8 = 0;

  var_12 = maps\_utility_code::hint_stick_get_updated(var_0, var_3, var_4, var_5, var_6, var_7, var_8);
  thread display_hint_timeout_mintime(var_12, var_1, var_2, var_9, var_10, var_11);
  thread maps\_utility_code::hint_stick_update(var_0, var_3, var_4, var_5, var_6, var_7, var_8);
}

check_hint_condition(var_0, var_1, var_2, var_3) {
  if(isdefined(var_3))
    return [
      [level.trigger_hint_func[var_0]]
    ](var_1, var_2, var_3);

  if(isdefined(var_2))
    return [
      [level.trigger_hint_func[var_0]]
    ](var_1, var_2);

  if(isdefined(var_1))
    return [
      [level.trigger_hint_func[var_0]]
    ](var_1);

  return [[level.trigger_hint_func[var_0]]]();
}

getgenericanim(var_0) {
  return level.scr_anim["generic"][var_0];
}

enable_careful() {
  self.script_careful = 1;
}

disable_careful() {
  self.script_careful = 0;
  self notify("stop_being_careful");
}

enable_sprint() {
  self.sprint = 1;
}

disable_sprint() {
  self.sprint = undefined;
}

disable_bulletwhizbyreaction() {
  self.disablebulletwhizbyreaction = 1;
}

enable_bulletwhizbyreaction() {
  self.disablebulletwhizbyreaction = undefined;
}

clear_dvar(var_0) {
  setdvar(var_0, "");
}

set_fixednode_true() {
  self.fixednode = 1;
}

set_fixednode_false() {
  self.fixednode = 0;
}

spawn_ai(var_0, var_1) {
  if(isdefined(self.script_delay_spawn)) {
    self endon("death");
    wait(self.script_delay_spawn);
  }

  var_2 = undefined;
  var_3 = isdefined(self.script_stealth) && common_scripts\utility::flag("_stealth_enabled") && !common_scripts\utility::flag("_stealth_spotted");

  if(isdefined(self.script_forcespawn) || isdefined(var_0)) {
    if(!isdefined(self.script_drone))
      var_2 = self stalingradspawn(var_3);
    else
      var_2 = dronespawn(self);
  } else if(!isdefined(self.script_drone))
    var_2 = self dospawn(var_3);
  else
    var_2 = dronespawn(self);

  if(isdefined(var_1) && var_1 && isalive(var_2))
    var_2 magic_bullet_shield();

  if(!isdefined(self.script_drone))
    spawn_failed(var_2);

  if(isdefined(self.script_spawn_once))
    self delete();

  if(isdefined(var_2))
    var_2.spawner = self;

  if(isdefined(var_2) && !isdefined(var_2.targetname)) {
    if(isdefined(self.targetname))
      var_2.targetname = self.targetname + "_AI";
  }

  return var_2;
}

function_stack(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = spawnstruct();
  var_6 thread maps\_utility_code::function_stack_proc(self, var_0, var_1, var_2, var_3, var_4, var_5);
  return maps\_utility_code::function_stack_wait_finish(var_6);
}

function_stack_timeout(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = spawnstruct();
  var_7 thread maps\_utility_code::function_stack_proc(self, var_1, var_2, var_3, var_4, var_5, var_6);

  if(isdefined(var_7.function_stack_func_begun) || var_7 common_scripts\utility::waittill_any_timeout(var_0, "function_stack_func_begun") != "timeout")
    return maps\_utility_code::function_stack_wait_finish(var_7);
  else {
    var_7 notify("death");
    return 0;
  }
}

function_stack_clear() {
  var_0 = [];

  if(isdefined(self.function_stack[0]) && isdefined(self.function_stack[0].function_stack_func_begun))
    var_0[0] = self.function_stack[0];

  self.function_stack = undefined;
  self notify("clear_function_stack");
  waittillframeend;

  if(!var_0.size) {
    return;
  }
  if(!var_0[0].function_stack_func_begun) {
    return;
  }
  self.function_stack = var_0;
}

geo_off() {
  if(isdefined(self.geo_off)) {
    return;
  }
  self.realorigin = self getorigin();
  self moveto(self.realorigin + (0, 0, -10000), 0.2);
  self.geo_off = 1;
}

geo_on() {
  if(!isdefined(self.geo_off)) {
    return;
  }
  self moveto(self.realorigin, 0.2);
  self waittill("movedone");
  self.geo_off = undefined;
}

disable_exits() {
  self.disableexits = 1;
}

enable_exits() {
  self.disableexits = undefined;
}

disable_turnanims() {
  self.noturnanims = 1;
}

enable_turnanims() {
  self.noturnanims = undefined;
}

disable_arrivals() {
  self.disablearrivals = 1;
}

enable_arrivals() {
  self endon("death");
  waittillframeend;
  self.disablearrivals = undefined;
}

set_blur(var_0, var_1) {
  setblur(var_0, var_1);
}

set_goal_radius(var_0) {
  self.goalradius = var_0;
}

set_goal_node(var_0) {
  self.last_set_goalnode = var_0;
  self.last_set_goalpos = undefined;
  self.last_set_goalent = undefined;
  self setgoalnode(var_0);
}

set_goal_node_targetname(var_0) {
  var_1 = getnode(var_0, "targetname");
  set_goal_node(var_1);
}

set_goal_pos(var_0) {
  self.last_set_goalnode = undefined;
  self.last_set_goalpos = var_0;
  self.last_set_goalent = undefined;
  self setgoalpos(var_0);
}

set_goal_ent(var_0) {
  set_goal_pos(var_0.origin);
  self.last_set_goalent = var_0;
}

objective_complete(var_0) {
  maps\_utility_code::objective_recon(var_0);
  objective_state(var_0, "done");
  level notify("objective_complete" + var_0);
}

handsignal(var_0, var_1, var_2, var_3) {
  var_4 = 1;

  if(isdefined(var_1))
    var_4 = !var_1;

  if(isdefined(var_2))
    level endon(var_2);

  if(isdefined(var_3))
    level waittill(var_3);

  var_5 = "signal_" + var_0;

  if(var_4)
    self setanimrestart(getgenericanim(var_5), 1, 0, 1.1);
  else
    maps\_anim::anim_generic(self, var_5);
}

array_spawn(var_0, var_1, var_2) {
  if(!isdefined(var_2))
    var_2 = 0;

  var_3 = [];

  foreach(var_5 in var_0) {
    var_5.count = 1;

    if(getsubstr(var_5.classname, 7, 10) == "veh") {
      var_6 = var_5 spawn_vehicle();

      if(isdefined(var_6.target) && !isdefined(var_6.script_moveoverride))
        var_6 thread maps\_vehicle::gopath();

      var_3[var_3.size] = var_6;
      continue;
    }

    var_6 = var_5 spawn_ai(var_1);

    if(!var_2) {

    }

    var_3[var_3.size] = var_6;
  }

  if(!var_2) {}

  return var_3;
}

array_spawn_cg(var_0, var_1, var_2, var_3) {
  if(!isdefined(var_2))
    var_2 = 0;

  var_4 = [];

  foreach(var_6 in var_0) {
    var_6.count = 1;

    if(getsubstr(var_6.classname, 7, 10) == "veh") {
      var_7 = var_6 spawn_vehicle();

      if(isdefined(var_7.target) && !isdefined(var_7.script_moveoverride))
        var_7 thread maps\_vehicle::gopath();

      var_4[var_4.size] = var_7;
      continue;
    }

    var_7 = var_6 spawn_ai(1);
    var_4 = common_scripts\utility::array_add(var_4, var_7);

    if(isdefined(var_3)) {
      wait(var_3);
      continue;
    }

    waitframe();
  }

  if(!var_2) {}

  return var_4;
}

array_spawn_targetname(var_0, var_1, var_2, var_3) {
  var_4 = getentarray(var_0, "targetname");

  if(isdefined(level.spawn_pool_enabled)) {
    var_5 = common_scripts\utility::getstructarray(var_0, "targetname");

    if(isdefined(var_3) && var_3)
      deletestructarray_ref(var_5);

    var_6 = maps\_spawner::get_pool_spawners_from_structarray(var_5);
    var_4 = common_scripts\utility::array_combine(var_4, var_6);
  }

  return array_spawn(var_4, var_1, var_2);
}

array_spawn_targetname_cg(var_0, var_1, var_2, var_3, var_4) {
  var_5 = getentarray(var_0, "targetname");

  if(isdefined(level.spawn_pool_enabled)) {
    var_6 = common_scripts\utility::getstructarray(var_0, "targetname");

    if(isdefined(var_4) && var_4)
      deletestructarray_ref(var_6);

    var_7 = maps\_spawner::get_pool_spawners_from_structarray(var_6);
    var_5 = common_scripts\utility::array_combine(var_5, var_7);
  }

  return array_spawn_cg(var_5, var_1, var_3, var_2);
}

get_guy_with_script_noteworthy_from_spawner(var_0) {
  var_1 = getentarray(var_0, "script_noteworthy");
  var_2 = array_spawn(var_1);
  return var_2[0];
}

get_guy_with_targetname_from_spawner(var_0) {
  var_1 = getentarray(var_0, "targetname");
  var_2 = array_spawn(var_1);
  return var_2[0];
}

get_guys_with_targetname_from_spawner(var_0) {
  var_1 = getentarray(var_0, "targetname");
  return array_spawn(var_1);
}

array_spawn_noteworthy(var_0, var_1, var_2, var_3) {
  var_4 = getentarray(var_0, "script_noteworthy");

  if(isdefined(level.spawn_pool_enabled)) {
    var_5 = common_scripts\utility::getstructarray(var_0, "script_noteworthy");

    if(isdefined(var_3) && var_3)
      deletestructarray_ref(var_5);

    var_6 = maps\_spawner::get_pool_spawners_from_structarray(var_5);
    var_4 = common_scripts\utility::array_combine(var_4, var_6);
  }

  return array_spawn(var_4, var_1, var_2);
}

spawn_script_noteworthy(var_0, var_1) {
  var_2 = getent(var_0, "script_noteworthy");
  var_3 = var_2 spawn_ai(var_1);
  return var_3;
}

spawn_targetname(var_0, var_1) {
  var_2 = getent(var_0, "targetname");
  var_3 = var_2 spawn_ai(var_1);
  return var_3;
}

add_dialogue_line(var_0, var_1, var_2) {
  if(getdvarint("loc_warnings", 0)) {
    return;
  }
  if(!isdefined(level.dialogue_huds))
    level.dialogue_huds = [];

  var_3 = 0;

  for (;;) {
    if(!isdefined(level.dialogue_huds[var_3])) {
      break;
    }

    var_3++;
  }

  var_4 = "^3";

  if(isdefined(var_2)) {
    switch (var_2) {
      case "red":
      case "r":
        var_4 = "^1";
        break;
      case "green":
      case "g":
        var_4 = "^2";
        break;
      case "yellow":
      case "y":
        var_4 = "^3";
        break;
      case "blue":
      case "b":
        var_4 = "^4";
        break;
      case "cyan":
      case "c":
        var_4 = "^5";
        break;
      case "purple":
      case "p":
        var_4 = "^6";
        break;
      case "white":
      case "w":
        var_4 = "^7";
        break;
      case "black":
      case "bl":
        var_4 = "^8";
        break;
    }
  }

  level.dialogue_huds[var_3] = 1;
  var_5 = maps\_hud_util::createfontstring("default", 1.5);
  var_5.location = 0;
  var_5.alignx = "left";
  var_5.aligny = "top";
  var_5.foreground = 1;
  var_5.sort = 20;
  var_5.alpha = 0;
  var_5 fadeovertime(0.5);
  var_5.alpha = 1;
  var_5.x = 40;
  var_5.y = 260 + var_3 * 18;
  var_5.label = " " + var_4 + "< " + var_0 + " > ^7" + var_1;
  var_5.color = (1, 1, 1);
  wait 2;
  var_6 = 40;
  var_5 fadeovertime(6);
  var_5.alpha = 0;

  for (var_7 = 0; var_7 < var_6; var_7++) {
    var_5.color = (1, 1, 0 / (var_6 - var_7));
    wait 0.05;
  }

  wait 4;
  var_5 destroy();
  level.dialogue_huds[var_3] = undefined;
}

destructible_disable_explosion() {
  common_scripts\_destructible::disable_explosion();
}

destructible_force_explosion() {
  common_scripts\_destructible::force_explosion();
}

set_grenadeammo(var_0) {
  self.grenadeammo = var_0;
}

get_player_feet_from_view() {
  var_0 = self.origin;
  var_1 = anglestoup(self getplayerangles());
  var_2 = self getplayerviewheight();
  var_3 = var_0 + (0, 0, var_2);
  var_4 = var_0 + var_1 * var_2;
  var_5 = var_3 - var_4;
  var_6 = var_0 + var_5;
  return var_6;
}

set_baseaccuracy(var_0) {
  self.baseaccuracy = var_0;
}

set_console_status() {
  if(!isdefined(level.console))
    level.console = getdvar("consoleGame") == "true";
  else {}

  if(!isdefined(level.xenon))
    level.xenon = getdvar("xenonGame") == "true";
  else {}

  if(!isdefined(level.ps3))
    level.ps3 = getdvar("ps3Game") == "true";
  else {}

  if(!isdefined(level.pccg))
    level.pccg = getdvar("pccgGame") == "true";
  else {}

  if(!isdefined(level.xb3))
    level.xb3 = getdvar("xb3Game") == "true";
  else {}

  if(!isdefined(level.ps4))
    level.ps4 = getdvar("ps4Game") == "true";
  else {}

  if(!isdefined(level.pc))
    level.pc = !level.console && !level.pccg;
  else {}

  if(!isdefined(level.pcuwp))
    level.pcuwp = getdvar("pcUWPGame") == "true";
  else {}

  if(!isdefined(level.currentgen))
    level.currentgen = level.ps3 || level.pccg || level.xenon;
  else {}

  if(!isdefined(level.nextgen))
    level.nextgen = level.pc || level.ps4 || level.xb3;
  else {}
}

is_gen4() {
  return level.nextgen;
}

autosave_now(var_0) {
  return maps\_autosave::_autosave_game_now(var_0);
}

autosave_now_silent() {
  return maps\_autosave::_autosave_game_now(1);
}

set_generic_deathanim(var_0) {
  self.deathanim = getgenericanim(var_0);
}

set_deathanim(var_0) {
  self.deathanim = getanim(var_0);
}

clear_deathanim() {
  self.deathanim = undefined;
}

hunted_style_door_open(var_0) {
  wait 0.75;

  if(isdefined(var_0))
    self playsound(var_0);
  else
    self playsound("door_wood_slow_open");

  wait 1;
  self rotateto(self.angles + (0, 70, 0), 2, 0.5, 0);

  if(self.classname == "script_brushmodel")
    self connectpaths();

  self waittill("rotatedone");
  self rotateto(self.angles + (0, 40, 0), 2, 0, 2);
}

palm_style_door_open(var_0) {
  wait 1.35;

  if(isdefined(var_0))
    self playsound(var_0);
  else
    self playsound("door_wood_slow_open");

  self rotateto(self.angles + (0, 70, 0), 2, 0.5, 0);
  self connectpaths();
  self waittill("rotatedone");
  self rotateto(self.angles + (0, 40, 0), 2, 0, 2);
}

lerp_fov_overtime(var_0, var_1) {
  foreach(var_3 in level.players)
  var_3 lerpfov(var_1, var_0);

  wait(var_0);
}

lerp_fovscale_overtime(var_0, var_1) {
  var_2 = getdvarfloat("cg_fovscale");
  var_3 = int(var_0 / 0.05);
  var_4 = (var_1 - var_2) / var_3;
  var_5 = var_2;

  for (var_6 = 0; var_6 < var_3; var_6++) {
    var_5 = var_5 + var_4;
    setsaveddvar("cg_fovscale", var_5);
    wait 0.05;
  }

  setsaveddvar("cg_fovscale", var_1);
}

putgunaway() {
  animscripts\shared::placeweaponon(self.weapon, "none");
  self.weapon = "none";
}

apply_fog() {
  maps\_art::set_fog_progress(0);
}

apply_end_fog() {
  maps\_art::set_fog_progress(1);
}

anim_stopanimscripted() {
  self stopanimscripted();
  self notify("stop_loop");
  self notify("single anim", "end");
  self notify("looping anim", "end");
}

disable_pain() {
  self.a.disablepain = 1;
  self.allowpain = 0;
}

enable_pain() {
  self.a.disablepain = 0;
  self.allowpain = 1;
}

_delete() {
  self delete();
}

_kill() {
  self kill();
}

kill_wrapper() {
  if(isplayer(self)) {
    if(common_scripts\utility::flag_exist("special_op_terminated") && common_scripts\utility::flag("special_op_terminated"))
      return 0;

    if(is_player_down(self))
      self disableinvulnerability();
  }

  self enabledeathshield(0);
  self kill();
  return 1;
}

_setentitytarget(var_0) {
  self setentitytarget(var_0);
}

_clearentitytarget() {
  self clearentitytarget();
}

_unlink() {
  self unlink();
}

disable_oneshotfx_with_noteworthy(var_0) {
  var_1 = getarraykeys(level._global_fx_ents[var_0]);

  for (var_2 = 0; var_2 < var_1.size; var_2++) {
    level._global_fx_ents[var_0][var_1[var_2]].looper delete();
    level._global_fx_ents[var_0][var_1[var_2]] = undefined;
  }
}

_setlightintensity(var_0) {
  self setlightintensity(var_0);
}

_linkto(var_0, var_1, var_2, var_3) {
  if(isdefined(var_3)) {
    self linkto(var_0, var_1, var_2, var_3);
    return;
  }

  if(isdefined(var_2)) {
    self linkto(var_0, var_1, var_2);
    return;
  }

  if(isdefined(var_1)) {
    self linkto(var_0, var_1);
    return;
  }

  self linkto(var_0);
}

array_wait(var_0, var_1, var_2) {
  var_3 = getarraykeys(var_0);
  var_4 = [];

  for (var_5 = 0; var_5 < var_3.size; var_5++)
    var_6 = var_3[var_5];

  for (var_5 = 0; var_5 < var_3.size; var_5++) {
    var_6 = var_3[var_5];
    var_4[var_6] = spawnstruct();
    var_4[var_6]._array_wait = 1;
    var_4[var_6] thread maps\_utility_code::array_waitlogic1(var_0[var_6], var_1, var_2);
  }

  for (var_5 = 0; var_5 < var_3.size; var_5++) {
    var_6 = var_3[var_5];

    if(isdefined(var_0[var_6]) && var_4[var_6]._array_wait)
      var_4[var_6] waittill("_array_wait");
  }
}

die() {
  self kill((0, 0, 0));
}

getmodel(var_0) {
  return level.scr_model[var_0];
}

isads() {
  return self playerads() > 0.5;
}

reset_threatbias() {
  level.player.threatbias = int(maps\_gameskill::get_locked_difficulty_val_player("threatbias", 1));
}

waittill_player_lookat(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isdefined(var_5))
    var_5 = level.player;

  var_6 = spawnstruct();

  if(isdefined(var_3))
    var_6 thread notify_delay("timeout", var_3);

  var_6 endon("timeout");

  if(!isdefined(var_0))
    var_0 = 0.92;

  if(!isdefined(var_1))
    var_1 = 0;

  var_7 = int(var_1 * 20);
  var_8 = var_7;
  self endon("death");
  var_9 = isai(self);
  var_10 = undefined;

  for (;;) {
    if(var_9)
      var_10 = self geteye();
    else
      var_10 = self.origin;

    if(var_5 player_looking_at(var_10, var_0, var_2, var_4)) {
      var_8--;

      if(var_8 <= 0)
        return 1;
    } else
      var_8 = var_7;

    wait 0.05;
  }
}

waittill_player_lookat_for_time(var_0, var_1, var_2, var_3) {
  waittill_player_lookat(var_1, var_0, var_2, undefined, var_3);
}

player_looking_at(var_0, var_1, var_2, var_3) {
  if(!isdefined(var_1))
    var_1 = 0.8;

  var_4 = get_player_from_self();
  var_5 = var_4 geteye();
  var_6 = vectortoangles(var_0 - var_5);
  var_7 = anglestoforward(var_6);
  var_8 = var_4 getplayerangles();
  var_9 = anglestoforward(var_8);
  var_10 = vectordot(var_7, var_9);

  if(var_10 < var_1)
    return 0;

  if(isdefined(var_2))
    return 1;

  var_11 = bullettrace(var_0, var_5, 0, var_3);
  return var_11["fraction"] == 1;
}

either_player_looking_at(var_0, var_1, var_2, var_3) {
  for (var_4 = 0; var_4 < level.players.size; var_4++) {
    if(level.players[var_4] player_looking_at(var_0, var_1, var_2, var_3))
      return 1;
  }

  return 0;
}

player_can_see_ai(var_0, var_1) {
  var_2 = gettime();

  if(!isdefined(var_1))
    var_1 = 0;

  if(isdefined(var_0.playerseesmetime) && var_0.playerseesmetime + var_1 >= var_2)
    return var_0.playerseesme;

  var_0.playerseesmetime = var_2;

  if(!common_scripts\utility::within_fov(level.player.origin, level.player.angles, var_0.origin, 0.766)) {
    var_0.playerseesme = 0;
    return 0;
  }

  var_3 = level.player geteye();
  var_4 = var_0.origin;

  if(sighttracepassed(var_3, var_4, 1, level.player, var_0)) {
    var_0.playerseesme = 1;
    return 1;
  }

  var_5 = var_0 geteye();

  if(sighttracepassed(var_3, var_5, 1, level.player, var_0)) {
    var_0.playerseesme = 1;
    return 1;
  }

  var_6 = (var_5 + var_4) * 0.5;

  if(sighttracepassed(var_3, var_6, 1, level.player, var_0)) {
    var_0.playerseesme = 1;
    return 1;
  }

  var_0.playerseesme = 0;
  return 0;
}

players_within_distance(var_0, var_1) {
  var_2 = var_0 * var_0;

  for (var_3 = 0; var_3 < level.players.size; var_3++) {
    if(distancesquared(var_1, level.players[var_3].origin) < var_2)
      return 1;
  }

  return 0;
}

ai_delete_when_out_of_sight(var_0, var_1) {
  if(!isdefined(var_0)) {
    return;
  }
  var_2 = 0.75;

  if(issplitscreen())
    var_2 = 0.65;

  while (var_0.size > 0) {
    wait 1;

    for (var_3 = 0; var_3 < var_0.size; var_3++) {
      if(!isdefined(var_0[var_3]) || !isalive(var_0[var_3])) {
        var_0 = common_scripts\utility::array_remove(var_0, var_0[var_3]);
        continue;
      }

      if(players_within_distance(var_1, var_0[var_3].origin)) {
        continue;
      }
      if(either_player_looking_at(var_0[var_3].origin + (0, 0, 48), var_2, 1)) {
        continue;
      }
      if(isdefined(var_0[var_3].magic_bullet_shield))
        var_0[var_3] stop_magic_bullet_shield();

      var_0[var_3] delete();
      var_0 = common_scripts\utility::array_remove(var_0, var_0[var_3]);
    }
  }
}

add_wait(var_0, var_1, var_2, var_3) {
  var_4 = spawnstruct();
  var_4.caller = self;
  var_4.func = var_0;
  var_4.parms = [];

  if(isdefined(var_1))
    var_4.parms[var_4.parms.size] = var_1;

  if(isdefined(var_2))
    var_4.parms[var_4.parms.size] = var_2;

  if(isdefined(var_3))
    var_4.parms[var_4.parms.size] = var_3;

  level.wait_any_func_array[level.wait_any_func_array.size] = var_4;
}

add_abort(var_0, var_1, var_2, var_3) {
  var_4 = spawnstruct();
  var_4.caller = self;
  var_4.func = var_0;
  var_4.parms = [];

  if(isdefined(var_1))
    var_4.parms[var_4.parms.size] = var_1;

  if(isdefined(var_2))
    var_4.parms[var_4.parms.size] = var_2;

  if(isdefined(var_3))
    var_4.parms[var_4.parms.size] = var_3;

  level.abort_wait_any_func_array[level.abort_wait_any_func_array.size] = var_4;
}

add_func(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = spawnstruct();
  var_6.caller = self;
  var_6.func = var_0;
  var_6.parms = [];

  if(isdefined(var_1))
    var_6.parms[var_6.parms.size] = var_1;

  if(isdefined(var_2))
    var_6.parms[var_6.parms.size] = var_2;

  if(isdefined(var_3))
    var_6.parms[var_6.parms.size] = var_3;

  if(isdefined(var_4))
    var_6.parms[var_6.parms.size] = var_4;

  if(isdefined(var_5))
    var_6.parms[var_6.parms.size] = var_5;

  level.run_func_after_wait_array[level.run_func_after_wait_array.size] = var_6;
}

add_call(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = spawnstruct();
  var_6.caller = self;
  var_6.func = var_0;
  var_6.parms = [];

  if(isdefined(var_1))
    var_6.parms[var_6.parms.size] = var_1;

  if(isdefined(var_2))
    var_6.parms[var_6.parms.size] = var_2;

  if(isdefined(var_3))
    var_6.parms[var_6.parms.size] = var_3;

  if(isdefined(var_4))
    var_6.parms[var_6.parms.size] = var_4;

  if(isdefined(var_5))
    var_6.parms[var_6.parms.size] = var_5;

  level.run_call_after_wait_array[level.run_call_after_wait_array.size] = var_6;
}

add_noself_call(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = spawnstruct();
  var_6.func = var_0;
  var_6.parms = [];

  if(isdefined(var_1))
    var_6.parms[var_6.parms.size] = var_1;

  if(isdefined(var_2))
    var_6.parms[var_6.parms.size] = var_2;

  if(isdefined(var_3))
    var_6.parms[var_6.parms.size] = var_3;

  if(isdefined(var_4))
    var_6.parms[var_6.parms.size] = var_4;

  if(isdefined(var_5))
    var_6.parms[var_6.parms.size] = var_5;

  level.run_noself_call_after_wait_array[level.run_noself_call_after_wait_array.size] = var_6;
}

add_endon(var_0) {
  var_1 = spawnstruct();
  var_1.caller = self;
  var_1.ender = var_0;
  level.do_wait_endons_array[level.do_wait_endons_array.size] = var_1;
}

do_wait_any() {
  do_wait(level.wait_any_func_array.size - 1);
}

do_wait(var_0) {
  if(!isdefined(var_0))
    var_0 = 0;

  var_1 = spawnstruct();
  var_2 = level.wait_any_func_array;
  var_3 = level.do_wait_endons_array;
  var_4 = level.run_func_after_wait_array;
  var_5 = level.run_call_after_wait_array;
  var_6 = level.run_noself_call_after_wait_array;
  var_7 = level.abort_wait_any_func_array;
  level.wait_any_func_array = [];
  level.run_func_after_wait_array = [];
  level.do_wait_endons_array = [];
  level.abort_wait_any_func_array = [];
  level.run_call_after_wait_array = [];
  level.run_noself_call_after_wait_array = [];
  var_1.count = var_2.size;
  var_1 common_scripts\utility::array_levelthread(var_2, maps\_utility_code::waittill_func_ends, var_3);
  var_1 thread maps\_utility_code::do_abort(var_7);
  var_1 endon("any_funcs_aborted");

  for (;;) {
    if(var_1.count <= var_0) {
      break;
    }

    var_1 waittill("func_ended");
  }

  var_1 notify("all_funcs_ended");
  common_scripts\utility::array_levelthread(var_4, maps\_utility_code::exec_func, []);
  common_scripts\utility::array_levelthread(var_5, maps\_utility_code::exec_call);
  common_scripts\utility::array_levelthread(var_6, maps\_utility_code::exec_call_noself);
}

do_funcs() {
  var_0 = spawnstruct();
  var_1 = level.run_func_after_wait_array;
  level.run_func_after_wait_array = [];

  foreach(var_3 in var_1)
  level maps\_utility_code::exec_func(var_3, []);

  var_0 notify("all_funcs_ended");
}

is_default_start() {
  if(isdefined(level.forced_start_catchup) && level.forced_start_catchup == 1)
    return 0;

  if(isdefined(level.default_start_override) && level.default_start_override == level.start_point)
    return 1;

  if(isdefined(level.default_start))
    return level.start_point == "default";

  if(level_has_start_points())
    return level.start_point == level.start_functions[0]["name"];

  return level.start_point == "default";
}

force_start_catchup() {
  level.forced_start_catchup = 1;
}

is_first_start() {
  if(!level_has_start_points())
    return 1;

  return level.start_point == level.start_functions[0]["name"];
}

is_after_start(var_0) {
  var_1 = 0;

  if(level.start_point == var_0)
    return 0;

  if(level.start_point == "default")
    return 0;

  for (var_2 = 0; var_2 < level.start_functions.size; var_2++) {
    if(level.start_functions[var_2]["name"] == var_0) {
      var_1 = 1;
      continue;
    }

    if(level.start_functions[var_2]["name"] == level.start_point)
      return var_1;
  }
}

is_start_or_after_start(var_0) {
  if(level.start_point == var_0)
    return 1;

  if(is_after_start(var_0))
    return 1;

  return 0;
}

_earthquake(var_0, var_1, var_2, var_3) {
  earthquake(var_0, var_1, var_2, var_3);
}

waterfx(var_0, var_1) {
  self endon("death");
  var_2 = 0;

  if(isdefined(var_1))
    var_2 = 1;

  if(isdefined(var_0)) {
    common_scripts\utility::flag_assert(var_0);
    level endon(var_0);
  }

  for (;;) {
    wait(randomfloatrange(0.15, 0.3));
    var_3 = self.origin + (0, 0, 150);
    var_4 = self.origin - (0, 0, 150);
    var_5 = bullettrace(var_3, var_4, 0, undefined);

    if(!issubstr(var_5["surfacetype"], "water")) {
      continue;
    }
    var_6 = "water_movement";

    if(isplayer(self)) {
      if(distance(self getvelocity(), (0, 0, 0)) < 5)
        var_6 = "water_stop";
    } else if(isdefined(level._effect["water_" + self.a.movement]))
      var_6 = "water_" + self.a.movement;

    var_7 = common_scripts\utility::getfx(var_6);
    var_3 = var_5["position"];
    var_8 = (0, self.angles[1], 0);
    var_9 = anglestoforward(var_8);
    var_10 = anglestoup(var_8);
    playfx(var_7, var_3, var_10, var_9);

    if(var_6 != "water_stop" && var_2)
      thread common_scripts\utility::play_sound_in_space(var_1, var_3);
  }
}

playersnowfootsteps(var_0) {
  if(isdefined(var_0)) {
    common_scripts\utility::flag_assert(var_0);
    level endon(var_0);
  }

  for (;;) {
    wait(randomfloatrange(0.25, 0.5));
    var_1 = self.origin + (0, 0, 0);
    var_2 = self.origin - (0, 0, 5);
    var_3 = bullettrace(var_1, var_2, 0, undefined);
    var_4 = anglestoforward(self.angles);
    var_5 = distance(self getvelocity(), (0, 0, 0));

    if(isdefined(self.vehicle)) {
      continue;
    }
    if(var_3["surfacetype"] != "snow") {
      continue;
    }
    if(var_5 <= 10) {
      continue;
    }
    var_6 = "snow_movement";

    if(distance(self getvelocity(), (0, 0, 0)) <= 154)
      playfx(common_scripts\utility::getfx("footstep_snow_small"), var_3["position"], var_3["normal"], var_4);

    if(distance(self getvelocity(), (0, 0, 0)) > 154)
      playfx(common_scripts\utility::getfx("footstep_snow"), var_3["position"], var_3["normal"], var_4);
  }
}

mix_up(var_0) {
  var_1 = 60;

  for (var_2 = 0; var_2 < var_1; var_2++) {
    self setsoundblend(var_0, var_0 + "_off", (var_1 - var_2) / var_1);
    wait 0.05;
  }
}

mix_down(var_0) {
  var_1 = 60;

  for (var_2 = 0; var_2 < var_1; var_2++) {
    self setsoundblend(var_0, var_0 + "_off", var_2 / var_1);
    wait 0.05;
  }
}

manual_linkto(var_0, var_1) {
  var_0 endon("death");
  self endon("death");

  if(!isdefined(var_1))
    var_1 = (0, 0, 0);

  for (;;) {
    self.origin = var_0.origin + var_1;
    self.angles = var_0.angles;
    wait 0.05;
  }
}

nextmission() {
  maps\_endmission::_nextmission();
}

make_array(var_0, var_1, var_2, var_3, var_4) {
  var_5 = [];
  var_5[var_5.size] = var_0;

  if(isdefined(var_1))
    var_5[var_5.size] = var_1;

  if(isdefined(var_2))
    var_5[var_5.size] = var_2;

  if(isdefined(var_3))
    var_5[var_5.size] = var_3;

  if(isdefined(var_4))
    var_5[var_5.size] = var_4;

  return var_5;
}

fail_on_friendly_fire() {
  level.failonfriendlyfire = 1;
}

normal_friendly_fire_penalty() {
  level.failonfriendlyfire = 0;
}

getplayerclaymores() {
  var_0 = self getweaponslistall();
  var_1 = [];

  for (var_2 = 0; var_2 < var_0.size; var_2++) {
    var_3 = var_0[var_2];
    var_1[var_3] = self getweaponammoclip(var_3);
  }

  var_4 = 0;

  if(isdefined(var_1["claymore"]) && var_1["claymore"] > 0)
    var_4 = var_1["claymore"];

  return var_4;
}

_wait(var_0) {
  wait(var_0);
}

_waittillmatch(var_0, var_1) {
  self waittillmatch(var_0, var_1);
}

_setsaveddvar(var_0, var_1) {
  setsaveddvar(var_0, var_1);
}

lerp_saveddvar(var_0, var_1, var_2) {
  var_3 = getdvarfloat(var_0);
  level notify(var_0 + "_lerp_savedDvar");
  level endon(var_0 + "_lerp_savedDvar");
  var_4 = var_1 - var_3;
  var_5 = 0.05;
  var_6 = int(var_2 / var_5);

  for (var_7 = var_4 / var_6; var_6; var_6--) {
    var_3 = var_3 + var_7;
    setsaveddvar(var_0, var_3);
    wait(var_5);
  }

  setsaveddvar(var_0, var_1);
}

lerp_saveddvar_cg_ng(var_0, var_1, var_2, var_3) {
  if(is_gen4())
    lerp_saveddvar(var_0, var_2, var_3);
  else
    lerp_saveddvar(var_0, var_1, var_3);
}

giveachievement_wrapper(var_0) {
  if((is_demo() || common_scripts\utility::flag("has_cheated") || maps\_cheat::is_cheating()) && !(var_0 == "LOOK_SHARP" || var_0 == "EYES_AND_EARS")) {
    return;
  }
  foreach(var_2 in level.players)
  var_2 giveachievement(var_0);
}

player_giveachievement_wrapper(var_0) {
  if(is_demo()) {
    return;
  }
  self giveachievement(var_0);
}

add_jav_glow(var_0) {
  var_1 = spawn("script_model", (0, 0, 0));
  var_1 setcontents(0);
  var_1 setmodel("weapon_javelin_obj");
  var_1.origin = self.origin;
  var_1.angles = self.angles;
  add_wait(::delete_on_not_defined);

  if(isdefined(var_0)) {
    common_scripts\utility::flag_assert(var_0);
    add_wait(common_scripts\utility::flag_wait, var_0);
  }

  do_wait_any();
  var_1 delete();
}

add_c4_glow(var_0) {
  var_1 = spawn("script_model", (0, 0, 0));
  var_1 setcontents(0);
  var_1 setmodel("weapon_c4_obj");
  var_1.origin = self.origin;
  var_1.angles = self.angles;
  add_wait(::delete_on_not_defined);

  if(isdefined(var_0)) {
    common_scripts\utility::flag_assert(var_0);
    add_wait(common_scripts\utility::flag_wait, var_0);
  }

  do_wait_any();
  var_1 delete();
}

delete_on_not_defined() {
  for (;;) {
    if(!isdefined(self)) {
      return;
    }
    wait 0.05;
  }
}

slowmo_start() {
  common_scripts\utility::flag_set("disable_slowmo_cheat");
}

slowmo_end() {
  common_scripts\utility::flag_clear("disable_slowmo_cheat");
}

slowmo_setspeed_slow(var_0) {
  level.slowmo.speed_slow = var_0;
}

slowmo_setspeed_norm(var_0) {
  level.slowmo.speed_norm = var_0;
}

slowmo_setlerptime_in(var_0) {
  level.slowmo.lerp_time_in = var_0;
}

slowmo_setlerptime_out(var_0) {
  level.slowmo.lerp_time_out = var_0;
}

slowmo_lerp_in() {
  if(isdefined(level.no_slowmo) && level.no_slowmo) {
    return;
  }
  setslowmotion(level.slowmo.speed_norm, level.slowmo.speed_slow, level.slowmo.lerp_time_in);
}

slowmo_lerp_out() {
  if(isdefined(level.no_slowmo) && level.no_slowmo) {
    return;
  }
  setslowmotion(level.slowmo.speed_slow, level.slowmo.speed_norm, level.slowmo.lerp_time_out);
}

add_earthquake(var_0, var_1, var_2, var_3) {
  level.earthquake[var_0]["magnitude"] = var_1;
  level.earthquake[var_0]["duration"] = var_2;
  level.earthquake[var_0]["radius"] = var_3;
}

arcademode() {
  return getdvar("arcademode") == "1";
}

arcademode_checkpoint(var_0, var_1) {}

arcademode_kill(var_0, var_1, var_2) {
  if(getdvar("arcademode") != "1") {
    return;
  }
  thread maps\_arcademode::arcademode_add_points(var_0, 1, var_1, var_2);
}

arcademode_damage(var_0, var_1, var_2) {}

arcademode_stop_timer() {
  if(!isdefined(level.arcademode_hud_timer)) {
    return;
  }
  level notify("arcadeMode_remove_timer");
  level.arcademode_stoptime = gettime();
  level.arcademode_hud_timer destroy();
  level.arcademode_hud_timer = undefined;
}

musicplaywrapper(var_0, var_1, var_2) {
  level._audio.last_song = var_0;

  if(!isdefined(var_1))
    var_1 = 1;

  if(!isdefined(var_2))
    var_2 = 0;

  musicstop(0);
  musicplay(var_0, 0, 1.0, 1, var_2);
}

music_loop(var_0, var_1, var_2, var_3, var_4) {
  thread maps\_utility_code::music_loop_internal(var_0, var_1, var_2, var_3, var_4);
}

music_loop_stealth(var_0, var_1, var_2, var_3, var_4) {
  thread maps\_utility_code::music_loop_internal(var_0, var_1, var_2, var_3, var_4, 1);
}

music_play(var_0, var_1, var_2, var_3) {
  if(isdefined(var_1) && var_1 > 0) {
    thread maps\_utility_code::music_play_internal_stop_with_fade_then_call(var_0, var_1, var_2, var_3);
    return;
  }

  music_stop();
  musicplaywrapper(var_0, var_2, var_3);
}

music_crossfade(var_0, var_1, var_2, var_3) {
  if(!isdefined(var_2))
    var_2 = 1;

  if(!isdefined(var_3))
    var_3 = 0;

  if(isdefined(level._audio.last_song))
    musicstop(var_1, level._audio.last_song, var_3);
  else
    iprintln("^3WARNING!script music_crossfade(): No previous song was played - no previous song to crossfade from - not fading out anything");

  level._audio.last_song = var_0;
  musicplay(var_0, var_1, var_2, 0, var_3);
  level endon("stop_music");
  wait(var_1);
  level notify("done_crossfading");
}

music_stop(var_0) {
  if(!isdefined(var_0) || var_0 <= 0)
    musicstop();
  else
    musicstop(var_0);

  level notify("stop_music");
}

player_is_near_live_grenade() {
  var_0 = getentarray("grenade", "classname");

  for (var_1 = 0; var_1 < var_0.size; var_1++) {
    var_2 = var_0[var_1];

    if(var_2.model == "weapon_claymore") {
      continue;
    }
    for (var_3 = 0; var_3 < level.players.size; var_3++) {
      var_4 = level.players[var_3];

      if(distancesquared(var_2.origin, var_4.origin) < 75625)
        return 1;
    }
  }

  return 0;
}

player_died_recently() {
  return getdvarint("player_died_recently", "0") > 0;
}

all_players_istouching(var_0) {
  foreach(var_2 in level.players) {
    if(!var_2 istouching(var_0))
      return 0;
  }

  return 1;
}

any_players_istouching(var_0) {
  foreach(var_2 in level.players) {
    if(var_2 istouching(var_0))
      return 1;
  }

  return 0;
}

getdifficulty() {
  if(level.gameskill < 1)
    return "easy";

  if(level.gameskill < 2)
    return "medium";

  if(level.gameskill < 3)
    return "hard";

  return "fu";
}

getaverageplayerorigin() {
  var_0 = 0;
  var_1 = 0;
  var_2 = 0;

  foreach(var_4 in level.players) {
    var_0 = var_0 + var_4.origin[0];
    var_1 = var_1 + var_4.origin[1];
    var_2 = var_2 + var_4.origin[2];
  }

  var_0 = var_0 / level.players.size;
  var_1 = var_1 / level.players.size;
  var_2 = var_2 / level.players.size;
  return (var_0, var_1, var_2);
}

get_average_origin(var_0) {
  var_1 = (0, 0, 0);

  foreach(var_3 in var_0)
  var_1 = var_1 + var_3.origin;

  return var_1 * (1.0 / var_0.size);
}

generic_damage_think() {
  self.damage_functions = [];
  self endon("entitydeleted");
  self endon("stop_generic_damage_think");

  for (;;) {
    self waittill("damage", var_0, var_1, var_2, var_3, var_4, var_5, var_6);

    foreach(var_8 in self.damage_functions)
    thread[[var_8]](var_0, var_1, var_2, var_3, var_4, var_5, var_6);
  }
}

add_damage_function(var_0) {
  self.damage_functions[self.damage_functions.size] = var_0;
}

remove_damage_function(var_0) {
  var_1 = [];

  foreach(var_3 in self.damage_functions) {
    if(var_3 == var_0) {
      continue;
    }
    var_1[var_1.size] = var_3;
  }

  self.damage_functions = var_1;
}

givexp(var_0, var_1) {
  if(isdefined(level.xp_enable) && level.xp_enable && isdefined(level.xp_give_func))
    self[[level.xp_give_func]](var_0, var_1);
}

playlocalsoundwrapper(var_0) {
  self playlocalsound(var_0);
}

enableplayerweapons(var_0) {
  if(level.players.size < 1) {
    return;
  }
  foreach(var_2 in level.players) {
    if(var_0 == 1) {
      var_2 enableweapons();
      continue;
    }

    var_2 disableweapons();
  }
}

teleport_players(var_0) {
  var_1 = undefined;
  var_2 = undefined;
  var_3 = undefined;

  foreach(var_5 in var_0) {
    if(isdefined(var_5.script_noteworthy) && var_5.script_noteworthy == "player1") {
      var_1 = var_5;
      continue;
    }

    if(isdefined(var_5.script_noteworthy) && var_5.script_noteworthy == "player2") {
      var_2 = var_5;
      continue;
    }

    if(!isdefined(var_1))
      var_1 = var_5;

    if(!isdefined(var_2))
      var_2 = var_5;
  }

  foreach(var_8 in level.players) {
    if(var_8 == level.player)
      var_3 = var_1;
    else if(var_8 == level.player2)
      var_3 = var_2;

    var_8 setorigin(var_3.origin);
    var_8 setplayerangles(var_3.angles);
  }
}

teleport_player(var_0) {
  level.player setorigin(var_0.origin);

  if(isdefined(var_0.angles))
    level.player setplayerangles(var_0.angles);
}

translate_local() {
  var_0 = [];

  if(isdefined(self.entities))
    var_0 = self.entities;

  if(isdefined(self.entity))
    var_0[var_0.size] = self.entity;

  common_scripts\utility::array_levelthread(var_0, maps\_utility_code::translate_local_on_ent);
}

open_up_fov(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  level.player endon("stop_opening_fov");
  wait(var_0);
  level.player playerlinktodelta(var_1, var_2, 1, var_3, var_4, var_5, var_6, 1);
}

get_ai_touching_volume(var_0, var_1, var_2) {
  if(!isdefined(var_0))
    var_0 = "all";

  if(!isdefined(var_1))
    var_1 = "all";

  var_3 = getaispeciesarray(var_0, var_1);
  var_4 = [];

  foreach(var_6 in var_3) {
    if(var_6 istouching(self))
      var_4[var_4.size] = var_6;
  }

  return var_4;
}

get_drones_touching_volume(var_0) {
  if(!isdefined(var_0))
    var_0 = "all";

  var_1 = [];

  if(var_0 == "all") {
    var_1 = array_merge(level.drones["allies"].array, level.drones["axis"].array);
    var_1 = array_merge(var_1, level.drones["neutral"].array);
  } else
    var_1 = level.drones[var_0].array;

  var_2 = [];

  foreach(var_4 in var_1) {
    if(!isdefined(var_4)) {
      continue;
    }
    if(var_4 istouching(self))
      var_2[var_2.size] = var_4;
  }

  return var_2;
}

get_drones_with_targetname(var_0) {
  var_1 = array_merge(level.drones["allies"].array, level.drones["axis"].array);
  var_1 = array_merge(var_1, level.drones["neutral"].array);
  var_2 = [];

  foreach(var_4 in var_1) {
    if(!isdefined(var_4)) {
      continue;
    }
    if(isdefined(var_4.targetname) && var_4.targetname == var_0)
      var_2[var_2.size] = var_4;
  }

  return var_2;
}

get_other_player(var_0) {
  foreach(var_2 in level.players) {
    if(var_0 == var_2) {
      continue;
    }
    return var_2;
  }
}

set_count(var_0) {
  self.count = var_0;
}

follow_path(var_0, var_1, var_2, var_3) {
  self notify("_utility::follow_path");
  self endon("_utility::follow_path");
  self endon("death");
  var_4 = undefined;

  if(!isdefined(var_0.classname)) {
    if(!isdefined(var_0.type))
      var_4 = "struct";
    else
      var_4 = "node";
  } else
    var_4 = "entity";

  if(!isdefined(var_1))
    var_1 = 300;

  var_5 = self.script_forcegoal;
  self.script_forcegoal = 1;
  maps\_spawner::go_to_node(var_0, var_4, var_2, var_1, var_3);
  self.script_forcegoal = var_5;
}

enable_dynamic_run_speed(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isdefined(var_0))
    var_0 = 250;

  if(!isdefined(var_1))
    var_1 = 100;

  if(!isdefined(var_2))
    var_2 = var_0 * 2;

  if(!isdefined(var_3))
    var_3 = var_0 * 1.25;

  if(!isdefined(var_5))
    var_5 = 0;

  self.dontchangemoveplaybackrate = var_5;
  thread maps\_utility_code::dynamic_run_speed_proc(var_0, var_1, var_2, var_3, var_4);
}

disable_dynamic_run_speed() {
  self notify("stop_dynamic_run_speed");
}

player_seek_enable() {
  self endon("death");
  self endon("stop_player_seek");
  var_0 = 1200;

  if(has_shotgun())
    var_0 = 250;

  var_1 = distance(self.origin, level.player.origin);

  for (;;) {
    wait 2;
    self.goalradius = var_1;
    var_2 = get_closest_player(self.origin);
    self setgoalentity(var_2);
    var_1 = var_1 - 175;

    if(var_1 < var_0) {
      var_1 = var_0;
      return;
    }
  }
}

player_seek_disable() {
  self notify("stop_player_seek");
}

waittill_entity_in_range_or_timeout(var_0, var_1, var_2) {
  self endon("death");
  var_0 endon("death");

  if(!isdefined(var_2))
    var_2 = 5;

  var_3 = gettime() + var_2 * 1000;

  while (isdefined(var_0)) {
    if(distance(var_0.origin, self.origin) <= var_1) {
      break;
    }

    if(gettime() > var_3) {
      break;
    }

    wait 0.1;
  }
}

waittill_entity_in_range(var_0, var_1) {
  self endon("death");
  var_0 endon("death");

  while (isdefined(var_0)) {
    if(distance(var_0.origin, self.origin) <= var_1) {
      break;
    }

    wait 0.1;
  }
}

waittill_entity_out_of_range(var_0, var_1) {
  self endon("death");
  var_0 endon("death");

  while (isdefined(var_0)) {
    if(distance(var_0.origin, self.origin) > var_1) {
      break;
    }

    wait 0.1;
  }
}

has_shotgun() {
  self endon("death");

  if(!isdefined(self.weapon))
    return 0;

  if(weaponclass(self.weapon) == "spread")
    return 1;

  return 0;
}

isprimaryweapon(var_0) {
  if(var_0 == "none")
    return 0;

  if(weaponinventorytype(var_0) != "primary")
    return 0;

  switch (weaponclass(var_0)) {
    case "rifle":
    case "sniper":
    case "smg":
    case "spread":
    case "rocketlauncher":
    case "pistol":
    case "mg":
      return 1;
    default:
      return 0;
  }
}

player_has_thermal() {
  var_0 = self getweaponslistall();

  if(!isdefined(var_0))
    return 0;

  foreach(var_2 in var_0) {
    if(issubstr(var_2, "thermal"))
      return 1;
  }

  return 0;
}

waittill_true_goal(var_0, var_1) {
  self endon("death");

  if(!isdefined(var_1))
    var_1 = self.goalradius;

  for (;;) {
    self waittill("goal");

    if(distance(self.origin, var_0) < var_1 + 10) {
      break;
    }
  }
}

player_speed_percent(var_0, var_1) {
  var_2 = int(getdvar("g_speed"));

  if(!isdefined(level.player.g_speed))
    level.player.g_speed = var_2;

  var_3 = int(level.player.g_speed * var_0 * 0.01);
  level.player player_speed_set(var_3, var_1);
}

blend_movespeedscale_percent(var_0, var_1) {
  var_2 = self;

  if(!isplayer(var_2))
    var_2 = level.player;

  if(!isdefined(var_2.movespeedscale))
    var_2.movespeedscale = 1.0;

  var_3 = var_0 * 0.01;
  var_2 blend_movespeedscale(var_3, var_1);
}

player_speed_set(var_0, var_1) {
  var_2 = int(getdvar("g_speed"));

  if(!isdefined(level.player.g_speed))
    level.player.g_speed = var_2;

  var_3 = maps\_utility_code::g_speed_get_func;
  var_4 = maps\_utility_code::g_speed_set_func;
  level.player thread player_speed_proc(var_0, var_1, var_3, var_4, "player_speed_set");
}

player_bob_scale_set(var_0, var_1) {
  var_2 = maps\_utility_code::g_bob_scale_get_func;
  var_3 = maps\_utility_code::g_bob_scale_set_func;
  level.player thread player_speed_proc(var_0, var_1, var_2, var_3, "player_bob_scale_set");
}

blend_movespeedscale(var_0, var_1) {
  var_2 = self;

  if(!isplayer(var_2))
    var_2 = level.player;

  if(!isdefined(var_2.movespeedscale))
    var_2.movespeedscale = 1.0;

  var_3 = maps\_utility_code::movespeed_get_func;
  var_4 = maps\_utility_code::movespeed_set_func;
  var_2 thread player_speed_proc(var_0, var_1, var_3, var_4, "blend_movespeedscale");
}

player_speed_proc(var_0, var_1, var_2, var_3, var_4) {
  self notify(var_4);
  self endon(var_4);
  var_5 = [[var_2]]();
  var_6 = var_0;

  if(isdefined(var_1)) {
    var_7 = var_6 - var_5;
    var_8 = 0.05;
    var_9 = var_1 / var_8;
    var_10 = var_7 / var_9;

    while (abs(var_6 - var_5) > abs(var_10 * 1.1)) {
      var_5 = var_5 + var_10;
      [
        [var_3]
      ](var_5);
      wait(var_8);
    }
  }

  [[var_3]](var_6);
}

player_speed_default(var_0) {
  if(!isdefined(level.player.g_speed)) {
    return;
  }
  level.player player_speed_set(level.player.g_speed, var_0);
  waittillframeend;
  level.player.g_speed = undefined;
}

blend_movespeedscale_default(var_0) {
  var_1 = self;

  if(!isplayer(var_1))
    var_1 = level.player;

  if(!isdefined(var_1.movespeedscale)) {
    return;
  }
  var_1 blend_movespeedscale(1.0, var_0);
  waittillframeend;
  var_1.movespeedscale = undefined;
}

teleport_ent(var_0) {
  if(isplayer(self)) {
    self setorigin(var_0.origin);
    self setplayerangles(var_0.angles);
  } else
    self forceteleport(var_0.origin, var_0.angles);
}

teleport_to_ent_tag(var_0, var_1) {
  var_2 = var_0 gettagorigin(var_1);
  var_3 = var_0 gettagangles(var_1);
  self dontinterpolate();

  if(isplayer(self)) {
    self setorigin(var_2);
    self setplayerangles(var_3);
  } else if(isai(self))
    self forceteleport(var_2, var_3);
  else {
    self.origin = var_2;
    self.angles = var_3;
  }
}

teleport_ai(var_0) {
  self forceteleport(var_0.origin, var_0.angles);
  self setgoalpos(self.origin);
  self setgoalnode(var_0);
}

move_all_fx(var_0) {
  foreach(var_2 in level.createfxent)
  var_2.v["origin"] = var_2.v["origin"] + var_0;
}

issliding() {
  return isdefined(self.slidemodel);
}

beginsliding(var_0, var_1, var_2) {
  var_3 = self;
  var_3 thread play_sound_on_entity("foot_slide_plr_start");

  if(soundexists("foot_slide_plr_loop"))
    var_3 thread play_loop_sound_on_tag("foot_slide_plr_loop");

  var_4 = isdefined(level.custom_linkto_slide);

  if(!isdefined(var_0))
    var_0 = var_3 getvelocity() + (0, 0, -10);

  if(!isdefined(var_1))
    var_1 = 10;

  if(!isdefined(var_2)) {
    if(isdefined(level.slide_dampening))
      var_2 = level.slide_dampening;
    else
      var_2 = 0.035;
  }

  var_5 = spawn("script_origin", var_3.origin);
  var_5.angles = var_3.angles;
  var_3.slidemodel = var_5;
  var_5 moveslide((0, 0, 15), 15, var_0);

  if(var_4)
    var_3 playerlinktoblend(var_5, undefined, 1);
  else
    var_3 playerlinkto(var_5);

  var_3 disableweapons();
  var_3 allowprone(0);
  var_3 allowcrouch(1);
  var_3 allowstand(0);
  var_3 thread maps\_utility_code::doslide(var_5, var_1, var_2);
}

endsliding() {
  var_0 = self;
  var_0 notify("stop soundfoot_slide_plr_loop");
  var_0 thread play_sound_on_entity("foot_slide_plr_end");
  var_0 unlink();
  var_0 setvelocity(var_0.slidemodel.slidevelocity);
  var_0.slidemodel delete();
  var_0 enableweapons();
  var_0 allowprone(1);
  var_0 allowcrouch(1);
  var_0 allowstand(1);
  var_0 notify("stop_sliding");
}

spawn_vehicle() {
  return maps\_vehicle::vehicle_spawn(self);
}

getentwithflag(var_0) {
  var_1 = maps\_trigger::get_load_trigger_classes();
  var_2 = [];

  foreach(var_6, var_4 in var_1) {
    if(!issubstr(var_6, "flag")) {
      continue;
    }
    var_5 = getentarray(var_6, "classname");
    var_2 = common_scripts\utility::array_combine(var_2, var_5);
  }

  var_7 = maps\_trigger::get_load_trigger_funcs();

  foreach(var_9, var_4 in var_7) {
    if(!issubstr(var_9, "flag")) {
      continue;
    }
    var_5 = getentarray(var_9, "targetname");
    var_2 = common_scripts\utility::array_combine(var_2, var_5);
  }

  var_10 = undefined;

  foreach(var_12 in var_2) {
    if(var_12.script_flag == var_0)
      return var_12;
  }
}

getentarraywithflag(var_0) {
  var_1 = maps\_trigger::get_load_trigger_classes();
  var_2 = [];

  foreach(var_6, var_4 in var_1) {
    if(!issubstr(var_6, "flag")) {
      continue;
    }
    var_5 = getentarray(var_6, "classname");
    var_2 = common_scripts\utility::array_combine(var_2, var_5);
  }

  var_7 = maps\_trigger::get_load_trigger_funcs();

  foreach(var_9, var_4 in var_7) {
    if(!issubstr(var_9, "flag")) {
      continue;
    }
    var_5 = getentarray(var_9, "targetname");
    var_2 = common_scripts\utility::array_combine(var_2, var_5);
  }

  var_10 = [];

  foreach(var_12 in var_2) {
    if(var_12.script_flag == var_0)
      var_10[var_10.size] = var_12;
  }

  return var_10;
}

set_z(var_0, var_1) {
  return (var_0[0], var_0[1], var_1);
}

add_z(var_0, var_1) {
  return (var_0[0], var_0[1], var_0[2] + var_1);
}

set_y(var_0, var_1) {
  return (var_0[0], var_1, var_0[2]);
}

set_x(var_0, var_1) {
  return (var_1, var_0[1], var_0[2]);
}

player_using_missile() {
  var_0 = self getcurrentweapon();

  if(!isdefined(var_0))
    return 0;

  if(issubstr(tolower(var_0), "rpg"))
    return 1;

  if(issubstr(tolower(var_0), "stinger"))
    return 1;

  if(issubstr(tolower(var_0), "at4"))
    return 1;

  if(issubstr(tolower(var_0), "javelin"))
    return 1;

  return 0;
}

doinglongdeath() {
  return isdefined(self.a.doinglongdeath);
}

get_rumble_ent(var_0, var_1) {
  if(is_coop()) {}

  var_2 = get_player_from_self();

  if(!isdefined(var_0))
    var_0 = "steady_rumble";

  var_3 = spawn("script_origin", var_2 geteye());

  if(!isdefined(var_1) || !isnumber(var_1))
    var_3.intensity = 1;
  else
    var_3.intensity = var_1;

  var_3 thread maps\_utility_code::update_rumble_intensity(var_2, var_0);
  return var_3;
}

set_rumble_intensity(var_0) {
  self.intensity = var_0;
}

rumble_ramp_on(var_0) {
  thread rumble_ramp_to(1, var_0);
}

rumble_ramp_off(var_0) {
  thread rumble_ramp_to(0, var_0);
}

rumble_ramp_to(var_0, var_1) {
  self notify("new_ramp");
  self endon("new_ramp");
  self endon("death");
  var_2 = var_1 * 20;
  var_3 = var_0 - self.intensity;
  var_4 = var_3 / var_2;

  for (var_5 = 0; var_5 < var_2; var_5++) {
    self.intensity = self.intensity + var_4;
    wait 0.05;
  }

  self.intensity = var_0;
}

get_player_from_self() {
  if(isdefined(self)) {
    if(!is_in_array(level.players, self))
      return level.player;
    else
      return self;
  } else
    return level.player;
}

get_player_gameskill() {
  return int(self getplayersetting("gameskill"));
}

glow(var_0) {
  if(isdefined(self.non_glow_model)) {
    return;
  }
  self.non_glow_model = self.model;

  if(!isdefined(var_0))
    var_0 = self.model + "_obj";

  self setmodel(var_0);
}

stopglow(var_0) {
  if(!isdefined(self.non_glow_model)) {
    return;
  }
  self setmodel(self.non_glow_model);
  self.non_glow_model = undefined;
}

array_delete_evenly(var_0, var_1, var_2) {
  var_3 = [];
  var_1 = var_2 - var_1;

  foreach(var_5 in var_0) {
    var_3[var_3.size] = var_5;

    if(var_3.size == var_2) {
      var_3 = common_scripts\utility::array_randomize(var_3);

      for (var_6 = var_1; var_6 < var_3.size; var_6++)
        var_3[var_6] delete();

      var_3 = [];
    }
  }

  var_8 = [];

  foreach(var_5 in var_0) {
    if(!isdefined(var_5)) {
      continue;
    }
    var_8[var_8.size] = var_5;
  }

  return var_8;
}

waittill_in_range(var_0, var_1, var_2) {
  if(!isdefined(var_2))
    var_2 = 0.5;

  self endon("death");

  while (isdefined(self)) {
    if(distance(var_0, self.origin) <= var_1) {
      break;
    }

    wait(var_2);
  }
}

add_trace_fx(var_0) {
  var_1 = spawnstruct();
  var_1 thread maps\_utility_code::add_trace_fx_proc(var_0);
  return var_1;
}

tracefx_on_tag(var_0, var_1, var_2) {
  var_3 = self gettagorigin(var_1);
  var_4 = self gettagangles(var_1);
  tracefx(var_0, var_3, var_4, var_2);
}

tracefx(var_0, var_1, var_2, var_3) {
  var_4 = anglestoforward(var_2);
  var_5 = bullettrace(var_1, var_1 + var_4 * var_3, 0, undefined);

  if(var_5["fraction"] >= 1) {
    return;
  }
  var_6 = var_5["surfacetype"];

  if(!isdefined(level.trace_fx[var_0][var_6]))
    var_6 = "default";

  var_7 = level.trace_fx[var_0][var_6];

  if(isdefined(var_7["fx"]))
    playfx(var_7["fx"], var_5["position"], var_5["normal"]);

  if(isdefined(var_7["fx_array"])) {
    foreach(var_9 in var_7["fx_array"])
    playfx(var_9, var_5["position"], var_5["normal"]);
  }

  if(isdefined(var_7["sound"]))
    level thread common_scripts\utility::play_sound_in_space(var_7["sound"], var_5["position"]);

  if(isdefined(var_7["rumble"])) {
    var_11 = get_player_from_self();
    var_11 playrumbleonentity(var_7["rumble"]);
  }
}

disable_surprise() {
  self.newenemyreactiondistsq = 0;
}

enable_surprise() {
  self.newenemyreactiondistsq = squared(512);
}

enable_heat_behavior(var_0) {
  self.heat = 1;
  self.no_pistol_switch = 1;
  self.usecombatscriptatcover = 1;

  if(!isdefined(var_0) || !var_0) {
    self.dontshootwhilemoving = 1;
    self.maxfaceenemydist = 64;
    self.pathenemylookahead = 2048;
    disable_surprise();
  }

  self.specialreloadanimfunc = animscripts\animset::heat_reload_anim;
  self.custommoveanimset["run"] = animscripts\utility::lookupanimarray("heat_run");
}

disable_heat_behavior() {
  self.heat = undefined;
  self.no_pistol_switch = undefined;
  self.dontshootwhilemoving = undefined;
  self.usecombatscriptatcover = 0;
  self.maxfaceenemydist = getdefaultmaxfaceenemydistance();
  self.specialreloadanimfunc = undefined;
  self.custommoveanimset = undefined;
}

getvehiclearray() {
  return vehicle_getarray();
}

hint(var_0, var_1, var_2, var_3) {
  if(!isdefined(var_2))
    var_2 = 0;

  if(isdefined(var_3))
    var_2 = var_2 - 14;

  var_4 = var_2;

  if(level.console)
    var_4 = var_4 - 1;

  var_5 = 0.5;
  level endon("clearing_hints");

  if(isdefined(level.hintelement))
    level.hintelement maps\_hud_util::destroyelem();

  maps\_hud_util::add_hint_background(var_3, var_2, 0.5);
  level.hintelement = maps\_hud_util::createfontstring("timer", 0.5);
  level.hintelement maps\_hud_util::setpoint("TOP", undefined, 0, 127 + var_4);
  level.hintelement.hidewheninmenu = 1;
  level.hintelement.hidewhendead = 1;
  level.hintelement.color = (1, 1, 1);
  level.hintelement settext(var_0);
  level.hintelement.alpha = 0;
  level.hintelement fadeovertime(0.5);
  level.hintelement.alpha = 1;
  wait 0.5;
  level.hintelement endon("death");

  if(isdefined(var_1))
    wait(var_1);
  else
    return;

  level.hintelement fadeovertime(var_5);
  level.hintelement.alpha = 0;
  maps\_hud_util::fade_hint_background(var_5);
  wait(var_5);
  maps\_hud_util::clear_hint_background();
  level.hintelement maps\_hud_util::destroyelem();
}

hint_fade(var_0) {
  if(!isdefined(var_0))
    var_0 = 1;

  if(isdefined(level.hintelement)) {
    if(var_0 > 0)
      level.hintelement fadeovertime(var_0);

    level.hintelement.alpha = 0;
    maps\_hud_util::fade_hint_background(var_0);

    if(var_0 > 0)
      wait(var_0);
  }

  level notify("clearing_hints");
}

kill_deathflag(var_0, var_1, var_2) {
  if(!isdefined(level.flag[var_0])) {
    return;
  }
  if(!isdefined(var_1))
    var_1 = 0;

  foreach(var_4 in level.deathflags[var_0]) {
    foreach(var_6 in var_4) {
      if(isalive(var_6)) {
        var_6 thread maps\_utility_code::kill_deathflag_proc(var_1, var_2);
        continue;
      }

      var_6 delete();
    }
  }
}

get_player_view_controller(var_0, var_1, var_2, var_3) {
  if(!isdefined(var_3))
    var_3 = "player_view_controller";

  if(!isdefined(var_2))
    var_2 = (0, 0, 0);

  var_4 = var_0 gettagorigin(var_1);
  var_5 = spawnturret("misc_turret", var_4, var_3);
  var_5.angles = var_0 gettagangles(var_1);
  var_5 setmodel("tag_turret");
  var_5 linkto(var_0, var_1, var_2, (0, 0, 0));
  var_5 makeunusable();
  var_5 hide();
  var_5 setmode("manual");
  return var_5;
}

create_blend(var_0, var_1, var_2, var_3) {
  var_4 = spawnstruct();
  var_4 childthread maps\_utility_code::process_blend(var_0, self, var_1, var_2, var_3);
  return var_4;
}

set_unstorable_weapon(var_0, var_1) {
  if(isdefined(self.unstorable_weapons))
    self.unstorable_weapons = [];

  if(!isdefined(var_1) || var_1)
    self.unstorable_weapons[var_0] = 1;
  else
    self.unstorable_weapons[var_0] = undefined;
}

is_unstorable_weapon(var_0) {
  if(!isdefined(self.unstorable_weapons))
    return 0;

  return isdefined(self.unstorable_weapons[var_0]);
}

store_players_weapons(var_0) {
  if(!isdefined(self.stored_weapons))
    self.stored_weapons = [];

  if(!isdefined(self.unstorable_weapons))
    self.unstorable_weapons = [];

  var_1 = [];
  var_2 = self getweaponslistall();
  var_3 = self getcurrentweapon();

  foreach(var_5 in var_2) {
    if(isdefined(self.unstorable_weapons[var_5])) {
      continue;
    }
    var_1[var_5] = [];
    var_1[var_5]["clip_left"] = self getweaponammoclip(var_5, "left");
    var_1[var_5]["clip_right"] = self getweaponammoclip(var_5, "right");
    var_1[var_5]["stock"] = self getweaponammostock(var_5);
  }

  if(!isdefined(var_0))
    var_0 = "default";

  self.stored_weapons[var_0] = [];

  if(isdefined(self.unstorable_weapons[var_3])) {
    var_7 = self getweaponslistprimaries();

    foreach(var_5 in var_7) {
      if(!isdefined(self.unstorable_weapons[var_5])) {
        var_3 = var_5;
        break;
      }
    }
  }

  self.stored_weapons[var_0]["current_weapon"] = var_3;
  self.stored_weapons[var_0]["inventory"] = var_1;
}

restore_players_weapons(var_0) {
  if(!isdefined(var_0))
    var_0 = "default";

  if(!isdefined(self.stored_weapons) || !isdefined(self.stored_weapons[var_0])) {
    return;
  }
  self takeallweapons();

  foreach(var_3, var_2 in self.stored_weapons[var_0]["inventory"]) {
    if(weaponinventorytype(var_3) != "altmode")
      self giveweapon(var_3);

    self setweaponammoclip(var_3, var_2["clip_left"], "left");
    self setweaponammoclip(var_3, var_2["clip_right"], "right");
    self setweaponammostock(var_3, var_2["stock"]);
  }

  var_4 = self.stored_weapons[var_0]["current_weapon"];

  if(var_4 != "none")
    self switchtoweapon(var_4);
}

get_storable_weapons_list_all() {
  var_0 = self getweaponslistall();

  if(isdefined(self.unstorable_weapons)) {
    foreach(var_2 in var_0) {
      if(isdefined(self.unstorable_weapons[var_2]))
        var_0 = common_scripts\utility::array_remove(var_0, var_2);
    }
  }

  return var_0;
}

get_storable_weapons_list_primaries() {
  var_0 = self getweaponslistprimaries();

  if(isdefined(self.unstorable_weapons)) {
    foreach(var_2 in var_0) {
      if(isdefined(self.unstorable_weapons[var_2]))
        var_0 = common_scripts\utility::array_remove(var_0, var_2);
    }
  }

  return var_0;
}

get_storable_current_weapon_primary() {
  var_0 = self getcurrentprimaryweapon();

  if(isdefined(self.unstorable_weapons) && isdefined(self.unstorable_weapons[var_0]))
    var_0 = get_first_storable_weapon();

  return var_0;
}

get_storable_current_weapon() {
  var_0 = self getcurrentweapon();

  if(isdefined(self.unstorable_weapons) && isdefined(self.unstorable_weapons[var_0]))
    var_0 = get_first_storable_weapon();

  return var_0;
}

get_first_storable_weapon() {
  var_0 = get_storable_weapons_list_primaries();

  if(var_0.size > 0)
    var_1 = var_0[0];
  else
    var_1 = "none";

  return var_1;
}

hide_entity() {
  switch (self.code_classname) {
    case "light_spot":
    case "script_vehicle":
    case "script_model":
      self hide();
      break;
    case "script_brushmodel":
      self hide();
      self notsolid();

      if(self.spawnflags & 1)
        self connectpaths();

      break;
    case "trigger_multiple_flag_looking":
    case "trigger_multiple_flag_lookat":
    case "trigger_multiple_breachIcon":
    case "trigger_multiple_flag_set":
    case "trigger_use_touch":
    case "trigger_use":
    case "trigger_multiple":
    case "trigger_radius":
      common_scripts\utility::trigger_off();
      break;
    default:
  }
}

show_entity() {
  switch (self.code_classname) {
    case "light_spot":
    case "script_vehicle":
    case "script_model":
      self show();
      break;
    case "script_brushmodel":
      self show();
      self solid();

      if(self.spawnflags & 1)
        self disconnectpaths();

      break;
    case "trigger_multiple_flag_looking":
    case "trigger_multiple_flag_lookat":
    case "trigger_multiple_breachIcon":
    case "trigger_multiple_flag_set":
    case "trigger_use_touch":
    case "trigger_use":
    case "trigger_multiple":
    case "trigger_radius":
      common_scripts\utility::trigger_on();
      break;
    default:
  }
}

_rotateyaw(var_0, var_1, var_2, var_3) {
  if(isdefined(var_3))
    self rotateyaw(var_0, var_1, var_2, var_3);
  else if(isdefined(var_2))
    self rotateyaw(var_0, var_1, var_2);
  else
    self rotateyaw(var_0, var_1);
}

set_moveplaybackrate(var_0, var_1, var_2) {
  self notify("set_moveplaybackrate");
  self endon("set_moveplaybackrate");

  if(isdefined(var_2) && var_2)
    thread set_movetransitionrate(var_0, var_1);

  if(!isdefined(self.moveplaybackrate_orig))
    self.moveplaybackrate_orig = self.moveplaybackrate;

  if(isdefined(var_1)) {
    var_3 = var_0 - self.moveplaybackrate;
    var_4 = 0.05;
    var_5 = var_1 / var_4;
    var_6 = var_3 / var_5;

    while (abs(var_0 - self.moveplaybackrate) > abs(var_6 * 1.1)) {
      self.moveplaybackrate = self.moveplaybackrate + var_6;
      wait(var_4);
    }
  }

  self.moveplaybackrate = var_0;
}

restore_moveplaybackrate(var_0, var_1) {
  self notify("set_moveplaybackrate");
  self endon("set_moveplaybackrate");

  if(isdefined(var_1) && var_1)
    thread restore_movetransitionrate(var_0);

  set_moveplaybackrate(self.moveplaybackrate_orig, var_0, 0);
  self.moveplaybackrate_orig = undefined;
}

set_movetransitionrate(var_0, var_1) {
  self notify("set_moveplaybackrate");
  self endon("set_moveplaybackrate");

  if(!isdefined(self.movetransitionrate_orig))
    self.movetransitionrate_orig = self.movetransitionrate;

  if(isdefined(var_1)) {
    var_2 = var_0 - self.movetransitionrate;
    var_3 = 0.05;
    var_4 = var_1 / var_3;
    var_5 = var_2 / var_4;

    while (abs(var_0 - self.movetransitionrate) > abs(var_5 * 1.1)) {
      self.movetransitionrate = self.movetransitionrate + var_5;
      wait(var_3);
    }
  }

  self.movetransitionrate = var_0;
}

restore_movetransitionrate(var_0) {
  self notify("set_moveplaybackrate");
  self endon("set_moveplaybackrate");
  set_movetransitionrate(self.movetransitionrate_orig, var_0);
  self.movetransitionrate_orig = undefined;
}

array_spawn_function(var_0, var_1, var_2, var_3, var_4, var_5) {
  foreach(var_7 in var_0)
  var_7 thread add_spawn_function(var_1, var_2, var_3, var_4, var_5);
}

array_spawn_function_targetname(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = getentarray(var_0, "targetname");
  array_spawn_function(var_6, var_1, var_2, var_3, var_4, var_5);
}

array_spawn_function_noteworthy(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = getentarray(var_0, "script_noteworthy");
  array_spawn_function(var_6, var_1, var_2, var_3, var_4, var_5);
}

enable_dontevershoot() {
  self.dontevershoot = 1;
}

disable_dontevershoot() {
  self.dontevershoot = undefined;
}

create_sunflare_setting(var_0) {
  if(!isdefined(level.sunflare_settings))
    level.sunflare_settings = [];

  var_1 = spawnstruct();
  var_1.name = var_0;
  level.sunflare_settings[var_0] = var_1;
  return var_1;
}

create_vision_set_fog(var_0) {
  if(!isdefined(level.vision_set_fog))
    level.vision_set_fog = [];

  var_1 = spawnstruct();
  var_1.name = var_0;
  var_1.skyfogintensity = 0;
  var_1.skyfogminangle = 0;
  var_1.skyfogmaxangle = 0;
  var_1.heightfogenabled = 0;
  var_1.heightfogbaseheight = 0;
  var_1.heightfoghalfplanedistance = 1000;
  level.vision_set_fog[tolower(var_0)] = var_1;
  return var_1;
}

get_vision_set_fog(var_0) {
  if(!isdefined(level.vision_set_fog))
    level.vision_set_fog = [];

  var_1 = level.vision_set_fog[tolower(var_0)];

  if(using_hdr_fog() && isdefined(var_1) && isdefined(var_1.hdroverride))
    var_1 = level.vision_set_fog[tolower(var_1.hdroverride)];

  return var_1;
}

create_fog(var_0) {
  if(!isdefined(level.fog_set))
    level.fog_set = [];

  var_1 = spawnstruct();
  var_1.name = var_0;
  level.fog_set[tolower(var_0)] = var_1;
  return var_1;
}

get_fog(var_0) {
  if(!isdefined(level.fog_set))
    level.fog_set = [];

  var_1 = level.fog_set[tolower(var_0)];
  return var_1;
}

init_self_fog_transition() {
  if(!isdefined(self.fog_transition_ent)) {
    self.fog_transition_ent = spawnstruct();
    self.fog_transition_ent.fogset = "";
    self.fog_transition_ent.time = 0;
  }
}

using_hdr_fog() {
  if(!isdefined(level.console))
    set_console_status();

  return is_gen4();
}

fog_set_changes(var_0, var_1) {
  if(!isplayer(self))
    maps\_art::init_fog_transition();
  else
    init_self_fog_transition();

  if(!isdefined(level.fog_set))
    level.fog_set = [];

  var_2 = level.fog_set[tolower(var_0)];

  if(!isdefined(var_2))
    var_2 = level.vision_set_fog[tolower(var_0)];

  if(isdefined(var_2) && isdefined(var_2.hdroverride) && using_hdr_fog()) {
    if(isdefined(level.fog_set[tolower(var_2.hdroverride)]))
      var_2 = level.fog_set[tolower(var_2.hdroverride)];
    else if(isdefined(level.vision_set_fog))
      var_2 = level.vision_set_fog[tolower(var_2.hdroverride)];
  }

  if(!isdefined(var_1))
    var_1 = var_2.transitiontime;

  if(!isplayer(self)) {
    common_scripts\utility::set_fog_to_ent_values(var_2, var_1);
    level.fog_transition_ent.fogset = var_0;
    level.fog_transition_ent.time = var_1;
  } else {
    if(var_0 != "" && self.fog_transition_ent.fogset == var_0 && self.fog_transition_ent.time == var_1) {
      return;
    }
    common_scripts\utility::set_fog_to_ent_values(var_2, var_1);
    self.fog_transition_ent.fogset = var_0;
    self.fog_transition_ent.time = var_1;
  }
}

vision_set_fog_changes(var_0, var_1) {
  var_2 = vision_set_changes(var_0, var_1);

  if(var_2) {
    if(level.currentgen && isdefined(get_vision_set_fog(var_0 + "_cg")))
      fog_set_changes(var_0 + "_cg", var_1);
    else if(isdefined(get_vision_set_fog(var_0)))
      fog_set_changes(var_0, var_1);
    else
      clearfog(var_1);
  }
}

init_self_visionset() {
  if(!isdefined(self.vision_set_transition_ent)) {
    self.vision_set_transition_ent = spawnstruct();
    self.vision_set_transition_ent.vision_set = "";
    self.vision_set_transition_ent.time = 0;
  }
}

vision_set_changes(var_0, var_1) {
  if(!isplayer(self)) {
    var_2 = 1;

    if(!isdefined(level.vision_set_transition_ent)) {
      level.vision_set_transition_ent = spawnstruct();
      level.vision_set_transition_ent.vision_set = "";
      level.vision_set_transition_ent.time = 0;
      var_2 = 0;
    }

    if(var_0 != "" && level.vision_set_transition_ent.vision_set == var_0 && level.vision_set_transition_ent.time == var_1)
      return 0;

    level.vision_set_transition_ent.vision_set = var_0;
    level.vision_set_transition_ent.time = var_1;

    if(var_2 && getdvarint("scr_art_tweak") != 0) {

    } else
      set_vision_set(var_0, var_1);

    level.lvl_visionset = var_0;
    setdvar("vision_set_current", var_0);
  } else {
    init_self_visionset();

    if(var_0 != "" && self.vision_set_transition_ent.vision_set == var_0 && self.vision_set_transition_ent.time == var_1)
      return 0;

    self.vision_set_transition_ent.vision_set = var_0;
    self.vision_set_transition_ent.time = var_1;
    set_vision_set_player(var_0, var_1);
  }

  return 1;
}

enable_teamflashbangimmunity() {
  thread enable_teamflashbangimmunity_proc();
}

enable_teamflashbangimmunity_proc() {
  self endon("death");

  for (;;) {
    self.teamflashbangimmunity = 1;
    wait 0.05;
  }
}

disable_teamflashbangimmunity() {
  self.teamflashbangimmunity = undefined;
}

_radiusdamage(var_0, var_1, var_2, var_3, var_4) {
  if(!isdefined(var_4))
    radiusdamage(var_0, var_1, var_2, var_3);
  else
    radiusdamage(var_0, var_1, var_2, var_3, var_4);
}

mask_destructibles_in_volumes(var_0) {
  var_1 = getentarray("destructible_toy", "targetname");
  var_2 = getentarray("destructible_vehicle", "targetname");
  var_3 = common_scripts\utility::array_combine(var_1, var_2);

  foreach(var_5 in var_0)
  var_5.destructibles = [];

  foreach(var_8 in var_3) {
    foreach(var_5 in var_0) {
      if(!var_5 istouching(var_8)) {
        continue;
      }
      var_5 maps\_utility_code::put_toy_in_volume(var_8);
      break;
    }
  }
}

interactivekeypairs() {
  var_0 = [];
  var_0[0] = ["interactive_birds", "targetname"];
  var_0[1] = ["interactive_vulture", "targetname"];
  var_0[2] = ["interactive_fish", "script_noteworthy"];
  return var_0;
}

mask_interactives_in_volumes(var_0) {
  var_1 = interactivekeypairs();
  var_2 = [];

  foreach(var_4 in var_1) {
    var_5 = getentarray(var_4[0], var_4[1]);
    var_2 = common_scripts\utility::array_combine(var_2, var_5);
  }

  foreach(var_8 in var_2) {
    if(!isdefined(level._interactive[var_8.interactive_type].savetostructfn)) {
      continue;
    }
    foreach(var_11 in var_0) {
      if(!var_11 istouching(var_8)) {
        continue;
      }
      if(!isdefined(var_11.interactives))
        var_11.interactives = [];

      var_11.interactives[var_11.interactives.size] = var_8[[level._interactive[var_8.interactive_type].savetostructfn]]();
    }
  }
}

activate_interactives_in_volume() {
  if(!isdefined(self.interactives)) {
    return;
  }
  foreach(var_1 in self.interactives)
  var_1[[level._interactive[var_1.interactive_type].loadfromstructfn]]();

  self.interactives = undefined;
}

delete_interactives_in_volumes(var_0) {
  mask_interactives_in_volumes(var_0);

  foreach(var_2 in var_0)
  var_2.interactives = undefined;
}

mask_exploders_in_volume(var_0) {
  if(getdvar("createfx") != "") {
    return;
  }
  var_1 = getentarray("script_brushmodel", "classname");
  var_2 = getentarray("script_model", "classname");

  for (var_3 = 0; var_3 < var_2.size; var_3++)
    var_1[var_1.size] = var_2[var_3];

  foreach(var_5 in var_0) {
    foreach(var_7 in var_1) {
      if(isdefined(var_7.script_prefab_exploder))
        var_7.script_exploder = var_7.script_prefab_exploder;

      if(!isdefined(var_7.script_exploder)) {
        continue;
      }
      if(!isdefined(var_7.model)) {
        continue;
      }
      if(var_7.code_classname != "script_model") {
        continue;
      }
      if(!var_7 istouching(var_5)) {
        continue;
      }
      var_7.masked_exploder = 1;
    }
  }
}

activate_exploders_in_volume() {
  var_0 = spawn("script_origin", (0, 0, 0));

  foreach(var_2 in level.createfxent) {
    if(!isdefined(var_2.v["masked_exploder"])) {
      continue;
    }
    var_0.origin = var_2.v["origin"];
    var_0.angles = var_2.v["angles"];

    if(!var_0 istouching(self)) {
      continue;
    }
    var_3 = var_2.v["masked_exploder"];
    var_4 = var_2.v["masked_exploder_spawnflags"];
    var_5 = var_2.v["masked_exploder_script_disconnectpaths"];
    var_6 = spawn("script_model", (0, 0, 0), var_4);
    var_6 setmodel(var_3);
    var_6.origin = var_2.v["origin"];
    var_6.angles = var_2.v["angles"];
    var_2.v["masked_exploder"] = undefined;
    var_2.v["masked_exploder_spawnflags"] = undefined;
    var_2.v["masked_exploder_script_disconnectpaths"] = undefined;
    var_6.disconnect_paths = var_5;
    var_6.script_exploder = var_2.v["exploder"];
    common_scripts\_exploder::setup_individual_exploder(var_6);
    var_2.model = var_6;
  }

  var_0 delete();
}

precache_destructible(var_0) {
  var_1 = common_scripts\_destructible_types::getinfoindex(var_0);

  if(var_1 != -1) {
    return;
  }
  if(!isdefined(level.destructible_functions))
    level.destructible_functions = [];

  var_2 = spawnstruct();
  var_2.destuctableinfo = common_scripts\_destructible_types::maketype(var_0);
  var_2 thread common_scripts\_destructible::precache_destructibles();
}

delete_destructibles_in_volumes(var_0, var_1) {
  foreach(var_3 in var_0)
  var_3.destructibles = [];

  var_5 = ["destructible_toy", "destructible_vehicle"];
  var_6 = 0;

  if(!isdefined(var_1))
    var_1 = 0;

  foreach(var_8 in var_5) {
    var_9 = getentarray(var_8, "targetname");

    foreach(var_11 in var_9) {
      foreach(var_3 in var_0) {
        if(var_1) {
          var_6++;
          var_6 = var_6 % 5;

          if(var_6 == 1)
            wait 0.05;
        }

        if(!var_3 istouching(var_11)) {
          continue;
        }
        var_11 delete();
        break;
      }
    }
  }
}

delete_exploders_in_volumes(var_0, var_1) {
  var_2 = getentarray("script_brushmodel", "classname");
  var_3 = getentarray("script_model", "classname");

  for (var_4 = 0; var_4 < var_3.size; var_4++)
    var_2[var_2.size] = var_3[var_4];

  var_5 = [];
  var_6 = spawn("script_origin", (0, 0, 0));
  var_7 = 0;

  if(!isdefined(var_1))
    var_1 = 0;

  foreach(var_9 in var_0) {
    foreach(var_11 in var_2) {
      if(!isdefined(var_11.script_exploder)) {
        continue;
      }
      var_6.origin = var_11 getorigin();

      if(!var_9 istouching(var_6)) {
        continue;
      }
      var_5[var_5.size] = var_11;
    }
  }

  array_delete(var_5);
  var_6 delete();
}

activate_destructibles_in_volume() {
  if(!isdefined(self.destructibles)) {
    return;
  }
  foreach(var_1 in self.destructibles) {
    var_2 = spawn("script_model", (0, 0, 0));
    var_2 setmodel(var_1.toy_model);
    var_2.origin = var_1.origin;
    var_2.angles = var_1.angles;
    var_2.script_noteworthy = var_1.script_noteworthy;
    var_2.targetname = var_1.targetname;
    var_2.target = var_1.target;
    var_2.script_linkto = var_1.script_linkto;
    var_2.destructible_type = var_1.destructible_type;
    var_2.script_noflip = var_1.script_noflip;
    var_2 common_scripts\_destructible::setup_destructibles(1);
  }

  self.destructibles = [];
}

setflashbangimmunity(var_0) {
  self.flashbangimmunity = var_0;
}

flashbanggettimeleftsec() {
  var_0 = self.flashendtime - gettime();

  if(var_0 < 0)
    return 0;

  return var_0 * 0.001;
}

flashbangisactive() {
  return flashbanggettimeleftsec() > 0;
}

flashbangstart(var_0) {
  if(isdefined(self.flashbangimmunity) && self.flashbangimmunity) {
    return;
  }
  var_1 = gettime() + var_0 * 1000.0;

  if(isdefined(self.flashendtime))
    self.flashendtime = max(self.flashendtime, var_1);
  else
    self.flashendtime = var_1;

  self notify("flashed");
  self setflashbanged(1);
}

waittill_volume_dead() {
  for (;;) {
    var_0 = getaispeciesarray("axis", "all");
    var_1 = 0;

    foreach(var_3 in var_0) {
      if(!isalive(var_3)) {
        continue;
      }
      if(var_3 istouching(self)) {
        var_1 = 1;
        break;
      }

      wait 0.0125;
    }

    if(!var_1) {
      var_5 = get_ai_touching_volume("axis");

      if(!var_5.size) {
        break;
      }
    }

    wait 0.05;
  }
}

waittill_volume_dead_or_dying() {
  var_0 = 0;

  for (;;) {
    var_1 = getaispeciesarray("axis", "all");
    var_2 = 0;

    foreach(var_4 in var_1) {
      if(!isalive(var_4)) {
        continue;
      }
      if(var_4 istouching(self)) {
        if(var_4 doinglongdeath()) {
          continue;
        }
        var_2 = 1;
        var_0 = 1;
        break;
      }

      wait 0.0125;
    }

    if(!var_2) {
      var_6 = get_ai_touching_volume("axis");

      if(!var_6.size) {
        break;
      } else
        var_0 = 1;
    }

    wait 0.05;
  }

  return var_0;
}

waittill_volume_dead_then_set_flag(var_0) {
  waittill_volume_dead();
  common_scripts\utility::flag_set(var_0);
}

waittill_targetname_volume_dead_then_set_flag(var_0, var_1) {
  var_2 = getent(var_0, "targetname");
  var_2 waittill_volume_dead_then_set_flag(var_1);
}

player_can_be_shot() {
  level.player ent_flag_clear("player_zero_attacker_accuracy");
  level.player.ignorerandombulletdamage = 0;
  level.player maps\_gameskill::update_player_attacker_accuracy();
}

player_cant_be_shot() {
  level.player ent_flag_set("player_zero_attacker_accuracy");
  level.player.attackeraccuracy = 0;
  level.player.ignorerandombulletdamage = 1;
}

set_player_attacker_accuracy(var_0) {
  var_1 = get_player_from_self();
  var_1.gs.player_attacker_accuracy = var_0;
  var_1 maps\_gameskill::update_player_attacker_accuracy();
}

array_index_by_parameters(var_0) {
  var_1 = [];

  foreach(var_3 in var_0)
  var_1[var_3.script_parameters] = var_3;

  return var_1;
}

array_index_by_classname(var_0) {
  var_1 = [];

  foreach(var_3 in var_0)
  var_1[var_3.classname] = var_3;

  return var_1;
}

array_index_by_script_index(var_0) {
  var_1 = [];

  foreach(var_3 in var_0) {
    var_4 = var_3.script_index;

    if(isdefined(var_4))
      var_1[var_4] = var_3;
  }

  return var_1;
}

add_target_pivot(var_0) {
  if(isdefined(var_0))
    self.pivot = var_0;
  else
    self.pivot = getent(self.target, "targetname");

  self linkto(self.pivot);
}

flashbangstop() {
  self.flashendtime = undefined;
  self setflashbanged(0);
}

getent_or_struct(var_0, var_1) {
  var_2 = getent(var_0, var_1);

  if(isdefined(var_2))
    return var_2;

  return common_scripts\utility::getstruct(var_0, var_1);
}

grenade_earthquake() {
  thread endondeath();
  self endon("end_explode");
  self waittill("explode", var_0);
  dirt_on_screen_from_position(var_0);
}

endondeath() {
  self waittill("death");
  waittillframeend;
  self notify("end_explode");
}

dirt_on_screen_from_position(var_0) {
  playrumbleonposition("grenade_rumble", var_0);
  earthquake(0.3, 0.5, var_0, 400);

  foreach(var_2 in level.players) {
    if(distance(var_0, var_2.origin) > 600) {
      continue;
    }
    if(var_2 damageconetrace(var_0))
      var_2 thread dirteffect(var_0);
  }
}

player_rides_shotgun_in_humvee(var_0, var_1, var_2, var_3) {
  return player_rides_in_humvee("shotgun", level.player, var_0, var_1, var_2, var_3);
}

player_rides_in_humvee(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isdefined(var_1))
    var_1 = level.player;

  var_1 allowcrouch(0);
  var_1 allowprone(0);
  var_1 disableweapons();
  var_6 = common_scripts\utility::spawn_tag_origin();
  var_6 linkto(self, "tag_passenger", player_rides_in_humvee_offset(var_0), (0, 0, 0));
  var_6.player_dismount = common_scripts\utility::spawn_tag_origin();
  var_6.player_dismount linkto(self, "tag_body", player_rides_humvee_offset_dismount(var_0), (0, 0, 0));

  if(!isdefined(var_2))
    var_2 = 90;

  if(!isdefined(var_3))
    var_3 = 90;

  if(!isdefined(var_4))
    var_4 = 40;

  if(!isdefined(var_5))
    var_5 = 40;

  var_1 disableweapons();
  var_1 playerlinkto(var_6, "tag_origin", 0.8, var_2, var_3, var_4, var_5);
  var_1.humvee_org = var_6;
  return var_6;
}

player_rides_in_humvee_offset(var_0) {
  switch (var_0) {
    case "shotgun":
      return (-5, 10, -34);
    case "backleft":
      return (-45, 45, -34);
    case "backright":
      return (-45, 5, -34);
  }
}

player_rides_humvee_offset_dismount(var_0) {
  switch (var_0) {
    case "shotgun":
      return (-8, -90, -12.6);
    case "backleft":
      return (-58, 85, -12.6);
    case "backright":
      return (-58, -95, -12.6);
  }
}

player_leaves_humvee(var_0) {
  if(!isdefined(var_0))
    var_0 = 0;

  var_1 = self;
  var_2 = level.player;

  if(isplayer(self)) {
    var_2 = self;
    var_1 = var_2.humvee_org;
  }

  var_1 unlink();

  if(!var_0) {
    var_3 = 0.6;
    var_1 moveto(var_1.player_dismount.origin, var_3, var_3 * 0.5, var_3 * 0.5);
    wait(var_3);
  }

  var_2 unlink();
  var_2 enableweapons();
  var_2 allowcrouch(1);
  var_2 allowprone(1);
  var_2.humvee_org = undefined;
  var_1.player_dismount delete();
  var_1 delete();
}

dirteffect(var_0, var_1) {
  var_2 = screen_effect_sides(var_0);

  foreach(var_5, var_4 in var_2)
  thread maps\_gameskill::grenade_dirt_on_screen(var_5);
}

bloodsplateffect(var_0) {
  if(!isdefined(self.damageattacker)) {
    return;
  }
  var_1 = screen_effect_sides(self.damageattacker.origin);

  foreach(var_4, var_3 in var_1)
  thread maps\_gameskill::blood_splat_on_screen(var_4);
}

screen_effect_sides(var_0) {
  var_1 = vectornormalize(anglestoforward(self.angles));
  var_2 = vectornormalize(anglestoright(self.angles));
  var_3 = vectornormalize(var_0 - self.origin);
  var_4 = vectordot(var_3, var_1);
  var_5 = vectordot(var_3, var_2);
  var_6 = [];
  var_7 = self getcurrentweapon();

  if(var_4 > 0 && var_4 > 0.5 && weapontype(var_7) != "riotshield")
    var_6["bottom"] = 1;

  if(abs(var_4) < 0.866) {
    if(var_5 > 0)
      var_6["right"] = 1;
    else
      var_6["left"] = 1;
  }

  return var_6;
}

pathrandompercent_set(var_0) {
  if(!isdefined(self.old_pathrandompercent))
    self.old_pathrandompercent = self.pathrandompercent;

  self.pathrandompercent = var_0;
}

pathrandompercent_zero() {
  if(isdefined(self.old_pathrandompercent)) {
    return;
  }
  self.old_pathrandompercent = self.pathrandompercent;
  self.pathrandompercent = 0;
}

pathrandompercent_reset() {
  self.pathrandompercent = self.old_pathrandompercent;
  self.old_pathrandompercent = undefined;
}

walkdist_zero() {
  if(isdefined(self.old_walkdistfacingmotion)) {
    return;
  }
  self.old_walkdist = self.walkdist;
  self.old_walkdistfacingmotion = self.walkdistfacingmotion;
  self.walkdist = 0;
  self.walkdistfacingmotion = 0;
}

walkdist_force_walk() {
  if(!isdefined(self.old_walkdistfacingmotion)) {
    self.old_walkdist = self.walkdist;
    self.old_walkdistfacingmotion = self.walkdistfacingmotion;
  }

  self.walkdist = 999999999;
  self.walkdistfacingmotion = 999999999;
}

is_walkdist_override() {
  return isdefined(self.old_walkdistfacingmotion) || isdefined(self.old_walkdist);
}

walkdist_reset() {
  self.walkdist = self.old_walkdist;
  self.walkdistfacingmotion = self.old_walkdistfacingmotion;
  self.old_walkdist = undefined;
  self.old_walkdistfacingmotion = undefined;
}

enable_ignorerandombulletdamage_drone() {
  thread ignorerandombulletdamage_drone_proc();
}

ignorerandombulletdamage_drone_proc() {
  self endon("disable_ignorerandombulletdamage_drone");
  self endon("death");
  self.ignorerandombulletdamage = 1;
  self.fakehealth = self.health;
  self.health = 1000000;

  for (;;) {
    self waittill("damage", var_0, var_1);

    if(!isplayer(var_1) && issentient(var_1)) {
      if(isdefined(var_1.enemy) && var_1.enemy != self)
        continue;
    }

    self.fakehealth = self.fakehealth - var_0;

    if(self.fakehealth <= 0) {
      break;
    }
  }

  self kill();
}

set_brakes(var_0) {
  self.veh_brake = var_0;
}

disable_ignorerandombulletdamage_drone() {
  if(!isalive(self)) {
    return;
  }
  if(!isdefined(self.ignorerandombulletdamage)) {
    return;
  }
  self notify("disable_ignorerandombulletdamage_drone");
  self.ignorerandombulletdamage = undefined;
  self.health = self.fakehealth;
}

timeoutent(var_0) {
  var_1 = spawnstruct();
  var_1 delaythread(var_0, ::send_notify, "timeout");
  return var_1;
}

delaythread(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  thread maps\_utility_code::delaythread_proc(var_1, var_0, var_2, var_3, var_4, var_5, var_6, var_7);
}

delaychildthread(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  childthread maps\_utility_code::delaychildthread_proc(var_1, var_0, var_2, var_3, var_4, var_5, var_6, var_7);
}

flagwaitthread(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  self endon("death");

  if(!isarray(var_0))
    var_0 = [var_0, 0];

  thread maps\_utility_code::flagwaitthread_proc(var_1, var_0, var_2, var_3, var_4, var_5, var_6, var_7);
}

waittillthread(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  self endon("death");

  if(!isarray(var_0))
    var_0 = [var_0, 0];

  thread maps\_utility_code::waittillthread_proc(var_1, var_0, var_2, var_3, var_4, var_5, var_6, var_7);
}

enable_danger_react(var_0) {
  var_0 = var_0 * 1000;
  self.dodangerreact = 1;
  self.dangerreactduration = var_0;
  self.neversprintforvariation = undefined;
}

disable_danger_react() {
  self.dodangerreact = 0;
  self.neversprintforvariation = 1;
}

set_group_advance_to_enemy_parameters(var_0, var_1) {
  level.advancetoenemyinterval = var_0;
  level.advancetoenemygroupmax = var_1;
}

reset_group_advance_to_enemy_timer(var_0) {
  level.lastadvancetoenemytime[var_0] = gettime();
}

set_custom_gameskill_func(var_0) {
  level.custom_gameskill_func = var_0;
  thread maps\_gameskill::resetskill();
}

clear_custom_gameskill_func() {
  level.custom_gameskill_func = undefined;
  thread maps\_gameskill::resetskill();
}

set_wind(var_0, var_1, var_2) {
  maps\_animatedmodels::init_wind_if_uninitialized();

  if(isdefined(var_2))
    level.wind.variance = var_2;

  level.wind.rate = var_1;
  level.wind.weight = var_0;
  level notify("windchange", "strong");
}

string_is_single_digit_integer(var_0) {
  if(var_0.size > 1)
    return 0;

  var_1 = [];
  var_1["0"] = 1;
  var_1["1"] = 1;
  var_1["2"] = 1;
  var_1["3"] = 1;
  var_1["4"] = 1;
  var_1["5"] = 1;
  var_1["6"] = 1;
  var_1["7"] = 1;
  var_1["8"] = 1;
  var_1["9"] = 1;

  if(isdefined(var_1[var_0]))
    return 1;

  return 0;
}

set_battlechatter_variable(var_0, var_1) {
  level.battlechatter[var_0] = var_1;
  maps\_utility_code::update_battlechatter_hud();
}

objective_clearadditionalpositions(var_0) {
  for (var_1 = 0; var_1 < 8; var_1++)
    objective_additionalposition(var_0, var_1, (0, 0, 0));
}

get_minutes_and_seconds(var_0) {
  var_1 = [];
  var_1["minutes"] = 0;

  for (var_1["seconds"] = int(var_0 / 1000); var_1["seconds"] >= 60; var_1["seconds"] = var_1["seconds"] - 60)
    var_1["minutes"]++;

  if(var_1["seconds"] < 10)
    var_1["seconds"] = "0" + var_1["seconds"];

  return var_1;
}

player_has_weapon(var_0) {
  var_1 = level.player getweaponslistprimaries();

  foreach(var_3 in var_1) {
    if(var_3 == var_0)
      return 1;
  }

  return 0;
}

obj(var_0) {
  if(!isdefined(level.obj_array))
    level.obj_array = [];

  if(!isdefined(level.obj_array[var_0]))
    level.obj_array[var_0] = level.obj_array.size + 1;

  return level.obj_array[var_0];
}

obj_exists(var_0) {
  return isdefined(level.obj_array) && isdefined(level.obj_array[var_0]);
}

player_mount_vehicle(var_0) {
  self mountvehicle(var_0);
  self.drivingvehicle = var_0;
}

player_dismount_vehicle() {
  self dismountvehicle();
  self.drivingvehicle = undefined;
}

graph_position(var_0, var_1, var_2, var_3, var_4) {
  var_5 = var_4 - var_2;
  var_6 = var_3 - var_1;
  var_7 = var_5 / var_6;
  var_0 = var_0 - var_3;
  var_0 = var_7 * var_0;
  var_0 = var_0 + var_4;
  return var_0;
}

enable_achievement_harder_they_fall() {
  self.rappeller = 1;
}

disable_achievement_harder_they_fall() {
  self.rappeller = undefined;
}

enable_achievement_harder_they_fall_guy(var_0) {
  var_0 enable_achievement_harder_they_fall();
}

disable_achievement_harder_they_fall_guy(var_0) {
  var_0 disable_achievement_harder_they_fall();
}

enable_achievement_reinforcement_denied(var_0, var_1) {
  self.h1_achieve_reinforce_denied_heli = var_0;
  self.h1_achieve_reinforce_denied_rig = var_1;
  thread h1_achievement_reinforcement_denied_watch();
}

disable_achievement_reinforcement_denied() {
  self notify("stop_reinforce_denied_watch");
}

h1_achievement_reinforcement_denied_watch() {
  self endon("stop_reinforce_denied_watch");
  self waittill("rope_death", var_0);

  if(var_0 == level.player) {
    var_1 = self.h1_achieve_reinforce_denied_heli;
    var_2 = self.h1_achieve_reinforce_denied_rig;

    if(!isdefined(var_1.h1_achieve_reinforce_denied_count) || !isdefined(var_1.h1_achieve_reinforce_denied_count[var_2]))
      var_1.h1_achieve_reinforce_denied_count[var_2] = 0;

    var_1.h1_achieve_reinforce_denied_count[var_2]++;

    if(var_1.h1_achieve_reinforce_denied_count[var_2] == 3)
      giveachievement_wrapper("REINFORCEMENT_DENIED");
  }
}

musiclength(var_0) {
  var_1 = tablelookup("sound\soundlength.csv", 0, var_0, 1);

  if(!isdefined(var_1) || var_1 == "")
    return -1;

  var_1 = int(var_1);
  var_1 = var_1 * 0.001;
  return var_1;
}

is_command_bound(var_0) {
  var_1 = getkeybinding(var_0);
  return var_1["count"];
}

linear_interpolate(var_0, var_1, var_2) {
  var_3 = var_2 - var_1;
  var_4 = var_0 * var_3;
  var_5 = var_1 + var_4;
  return var_5;
}

define_loadout(var_0) {
  level.loadout = var_0;
}

template_level(var_0) {
  define_loadout(var_0);
  level.template_script = var_0;
}

template_so_level(var_0) {
  level.audio_stringtable_mapname = var_0;
}

fx_volume_pause_noteworthy(var_0, var_1) {
  thread fx_volume_pause_noteworthy_thread(var_0, var_1);
}

fx_volume_pause_noteworthy_thread(var_0, var_1) {
  var_2 = getent(var_0, "script_noteworthy");
  var_2 notify("new_volume_command");
  var_2 endon("new_volume_command");
  wait 0.05;
  fx_volume_pause(var_2, var_1);
}

fx_volume_pause(var_0, var_1) {
  var_0.fx_paused = 1;

  if(!isdefined(var_1))
    var_1 = 0;

  if(var_1)
    array_thread_mod_delayed(var_0.fx, common_scripts\utility::pauseeffect);
  else
    common_scripts\utility::array_thread(var_0.fx, common_scripts\utility::pauseeffect);
}

array_thread_mod_delayed(var_0, var_1, var_2) {
  var_3 = 0;

  if(!isdefined(var_2))
    var_2 = 5;

  var_4 = [];

  foreach(var_6 in var_0) {
    var_4[var_4.size] = var_6;
    var_3++;
    var_3 = var_3 % var_2;

    if(var_2 == 0) {
      common_scripts\utility::array_thread(var_4, var_1);
      wait 0.05;
      var_4 = [];
    }
  }
}

fx_volume_restart_noteworthy(var_0) {
  thread fx_volume_restart_noteworthy_thread(var_0);
}

fx_volume_restart_noteworthy_thread(var_0) {
  var_1 = getent(var_0, "script_noteworthy");
  var_1 notify("new_volume_command");
  var_1 endon("new_volume_command");
  wait 0.05;

  if(!isdefined(var_1.fx_paused)) {
    return;
  }
  var_1.fx_paused = undefined;
  fx_volume_restart(var_1);
}

fx_volume_restart(var_0) {
  common_scripts\utility::array_thread(var_0.fx, ::restarteffect);
}

flag_count_increment(var_0) {
  if(!isdefined(level.flag_count))
    level.flag_count = [];

  if(!isdefined(level.flag_count[var_0]))
    level.flag_count[var_0] = 1;
  else
    level.flag_count[var_0]++;
}

flag_count_decrement(var_0) {
  level.flag_count[var_0]--;
  level.flag_count[var_0] = int(max(0, level.flag_count[var_0]));

  if(level.flag_count[var_0]) {
    return;
  }
  common_scripts\utility::flag_set(var_0);
}

flag_count_set(var_0, var_1) {
  level.flag_count[var_0] = var_1;
}

add_cleanup_ent(var_0, var_1) {
  if(!isdefined(level.cleanup_ents))
    level.cleanup_ents = [];

  if(!isdefined(level.cleanup_ents[var_1]))
    level.cleanup_ents[var_1] = [];

  level.cleanup_ents[var_1][level.cleanup_ents[var_1].size] = var_0;
}

cleanup_ents(var_0) {
  var_1 = level.cleanup_ents[var_0];
  var_1 = common_scripts\utility::array_removeundefined(var_1);
  array_delete(var_1);
  level.cleanup_ents[var_0] = undefined;
}

cleanup_ents_removing_bullet_shield(var_0) {
  if(!isdefined(level.cleanup_ents)) {
    return;
  }
  if(!isdefined(level.cleanup_ents[var_0])) {
    return;
  }
  var_1 = level.cleanup_ents[var_0];
  var_1 = common_scripts\utility::array_removeundefined(var_1);

  foreach(var_3 in var_1) {
    if(!isai(var_3)) {
      continue;
    }
    if(!isalive(var_3)) {
      continue;
    }
    if(!isdefined(var_3.magic_bullet_shield)) {
      continue;
    }
    if(!var_3.magic_bullet_shield) {
      continue;
    }
    var_3 stop_magic_bullet_shield();
  }

  array_delete(var_1);
  level.cleanup_ents[var_0] = undefined;
}

add_trigger_function(var_0) {
  if(!isdefined(self.trigger_functions))
    thread maps\_utility_code::add_trigger_func_thread();

  self.trigger_functions[self.trigger_functions.size] = var_0;
}

getallweapons() {
  var_0 = [];
  var_1 = getentarray();

  foreach(var_3 in var_1) {
    if(!isdefined(var_3.classname)) {
      continue;
    }
    if(issubstr(var_3.classname, "weapon_"))
      var_0[var_0.size] = var_3;
  }

  return var_0;
}

radio_add(var_0) {
  level.scr_radio[var_0] = var_0;
}

move_with_rate(var_0, var_1, var_2) {
  self notify("newmove");
  self endon("newmove");

  if(!isdefined(var_2))
    var_2 = 200;

  var_3 = distance(self.origin, var_0);
  var_4 = var_3 / var_2;
  var_5 = vectornormalize(var_0 - self.origin);
  self moveto(var_0, var_4, 0, 0);
  self rotateto(var_1, var_4, 0, 0);
  wait(var_4);

  if(!isdefined(self)) {
    return;
  }
  self.velocity = var_5 * (var_3 / var_4);
}

flag_on_death(var_0) {
  level endon(var_0);
  self waittill("death");
  common_scripts\utility::flag_set(var_0);
}

enable_damagefeedback_hud() {
  level.damagefeedbackhud = 1;
}

disable_damagefeedback_hud() {
  level.damagefeedbackhud = 0;
}

is_damagefeedback_hud_enabled() {
  if(!getdvarint("cg_drawDamageFeedbackOption"))
    return 0;

  return isdefined(level.damagefeedbackhud) && level.damagefeedbackhud;
}

enable_damagefeedback_snd() {
  level.damagefeedbacksnd = 1;
}

disable_damagefeedback_snd() {
  level.damagefeedbacksnd = 0;
}

is_damagefeedback_snd_enabled() {
  return isdefined(level.damagefeedbacksnd) && level.damagefeedbacksnd;
}

add_damagefeedback() {
  maps\_damagefeedback::monitordamage();
}

remove_damagefeedback() {
  maps\_damagefeedback::stopmonitordamage();
}

is_demo() {
  if(getdvar("e3demo") == "1")
    return 1;

  return 0;
}

deletestructarray(var_0, var_1, var_2) {
  var_3 = common_scripts\utility::getstructarray(var_0, var_1);
  deletestructarray_ref(var_3, var_2);
}

deletestruct_ref(var_0) {
  if(!isdefined(var_0)) {
    return;
  }
  var_1 = var_0.script_linkname;

  if(isdefined(var_1) && isdefined(level.struct_class_names["script_linkname"]) && isdefined(level.struct_class_names["script_linkname"][var_1])) {
    foreach(var_4, var_3 in level.struct_class_names["script_linkname"][var_1]) {
      if(isdefined(var_3) && var_0 == var_3)
        level.struct_class_names["script_linkname"][var_1][var_4] = undefined;
    }

    if(level.struct_class_names["script_linkname"][var_1].size == 0)
      level.struct_class_names["script_linkname"][var_1] = undefined;
  }

  var_1 = var_0.script_noteworthy;

  if(isdefined(var_1) && isdefined(level.struct_class_names["script_noteworthy"]) && isdefined(level.struct_class_names["script_noteworthy"][var_1])) {
    foreach(var_4, var_3 in level.struct_class_names["script_noteworthy"][var_1]) {
      if(isdefined(var_3) && var_0 == var_3)
        level.struct_class_names["script_noteworthy"][var_1][var_4] = undefined;
    }

    if(level.struct_class_names["script_noteworthy"][var_1].size == 0)
      level.struct_class_names["script_noteworthy"][var_1] = undefined;
  }

  var_1 = var_0.target;

  if(isdefined(var_1) && isdefined(level.struct_class_names["target"]) && isdefined(level.struct_class_names["target"][var_1])) {
    foreach(var_4, var_3 in level.struct_class_names["target"][var_1]) {
      if(isdefined(var_3) && var_0 == var_3)
        level.struct_class_names["target"][var_1][var_4] = undefined;
    }

    if(level.struct_class_names["target"][var_1].size == 0)
      level.struct_class_names["target"][var_1] = undefined;
  }

  var_1 = var_0.targetname;

  if(isdefined(var_1) && isdefined(level.struct_class_names["targetname"]) && isdefined(level.struct_class_names["targetname"][var_1])) {
    foreach(var_4, var_3 in level.struct_class_names["targetname"][var_1]) {
      if(isdefined(var_3) && var_0 == var_3)
        level.struct_class_names["targetname"][var_1][var_4] = undefined;
    }

    if(level.struct_class_names["targetname"][var_1].size == 0)
      level.struct_class_names["targetname"][var_1] = undefined;
  }

  if(isdefined(level.struct)) {
    foreach(var_4, var_3 in level.struct) {
      if(var_0 == var_3)
        level.struct[var_4] = undefined;
    }
  }
}

deletestructarray_ref(var_0, var_1) {
  if(!isdefined(var_0) || !isarray(var_0) || var_0.size == 0) {
    return;
  }
  var_1 = common_scripts\utility::ter_op(isdefined(var_1), var_1, 0);
  var_1 = common_scripts\utility::ter_op(var_1 > 0, var_1, 0);

  if(var_1 > 0) {
    foreach(var_3 in var_0) {
      deletestruct_ref(var_3);
      wait(var_1);
    }
  } else {
    foreach(var_3 in var_0)
    deletestruct_ref(var_3);
  }
}

getstruct_delete(var_0, var_1) {
  var_2 = common_scripts\utility::getstruct(var_0, var_1);
  deletestruct_ref(var_2);
  return var_2;
}

getstructarray_delete(var_0, var_1, var_2) {
  var_3 = common_scripts\utility::getstructarray(var_0, var_1);
  deletestructarray_ref(var_3, var_2);
  return var_3;
}

getent_or_struct_or_node(var_0, var_1) {
  var_2 = getent_or_struct(var_0, var_1);

  if(!isdefined(var_2))
    var_2 = getnode(var_0, var_1);

  if(!isdefined(var_2))
    var_2 = getvehiclenode(var_0, var_1);

  return var_2;
}

setentityheadicon(var_0, var_1, var_2, var_3, var_4) {
  if(isdefined(var_3))
    self.entityheadiconoffset = var_3;
  else
    self.entityheadiconoffset = (0, 0, 0);

  if(isdefined(var_4))
    self.entityheadiconreferencefunc = var_4;

  self notify("new_head_icon");
  var_5 = newhudelem();
  var_5.archived = 1;
  var_5.alpha = 0.8;
  var_5 setshader(var_0, var_1, var_2);
  var_5 setwaypoint(0, 0, 0, 1);
  self.entityheadicon = var_5;
  updateentityheadiconorigin();
  thread updateentityheadicon();
  thread destroyentityheadiconondeath();
}

removeentityheadicon() {
  if(!isdefined(self.entityheadicon)) {
    return;
  }
  self.entityheadicon destroy();
}

updateentityheadicon() {
  self endon("new_head_icon");
  self endon("death");
  var_0 = self.origin;

  for (;;) {
    if(var_0 != self.origin) {
      updateentityheadiconorigin();
      var_0 = self.origin;
    }

    wait 0.05;
  }
}

updateentityheadiconorigin() {
  if(isdefined(self.entityheadiconreferencefunc)) {
    var_0 = self[[self.entityheadiconreferencefunc]]();

    if(isdefined(var_0)) {
      self.entityheadicon.x = self.entityheadiconoffset[0] + var_0[0];
      self.entityheadicon.y = self.entityheadiconoffset[1] + var_0[1];
      self.entityheadicon.z = self.entityheadiconoffset[2] + var_0[2];
      return;
    }
  }

  self.entityheadicon.x = self.origin[0] + self.entityheadiconoffset[0];
  self.entityheadicon.y = self.origin[1] + self.entityheadiconoffset[1];
  self.entityheadicon.z = self.origin[2] + self.entityheadiconoffset[2];
}

destroyentityheadiconondeath() {
  self endon("new_head_icon");
  self waittill("death");

  if(!isdefined(self.entityheadicon)) {
    return;
  }
  self.entityheadicon destroy();
}

worldtolocalcoords(var_0) {
  var_1 = var_0 - self.origin;
  return (vectordot(var_1, anglestoforward(self.angles)), -1.0 * vectordot(var_1, anglestoright(self.angles)), vectordot(var_1, anglestoup(self.angles)));
}

intro_screen_create(var_0, var_1, var_2, var_3, var_4) {
  level.introscreen = spawnstruct();
  level.introscreen.completed_delay = 3;
  level.introscreen.fade_out_time = 1.5;
  level.introscreen.fade_in_time = undefined;

  if(isdefined(var_3))
    level.introscreen.lines = [var_0, var_1, var_2, var_3];
  else
    level.introscreen.lines = [var_0, var_1, var_2];

  common_scripts\utility::noself_array_call(level.introscreen.lines, ::precachestring);
}

intro_screen_custom_func(var_0) {
  level.introscreen.customfunc = var_0;
}

intro_screen_custom_timing(var_0, var_1, var_2) {
  level.introscreen.completed_delay = var_0;
  level.introscreen.fade_out_time = var_1;
  level.introscreen.fade_in_time = var_2;
}

set_npc_anims(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(isdefined(var_1))
    self.run_overrideanim = var_1;

  if(isdefined(var_2))
    self.walk_overrideanim = var_2;

  if(isdefined(var_3))
    self.specialidleanim = var_3;

  self.animarchetype = var_0;
  var_10 = [];

  if(isdefined(var_4) && isdefined(var_5)) {
    var_11 = [];

    foreach(var_13 in var_6)
    var_11[var_13] = var_4;

    var_10["cover_trans"] = var_11;
    var_15 = [];

    foreach(var_13 in var_6)
    var_15[var_13] = var_5;

    var_10["cover_exit"] = var_15;
  } else if(isdefined(var_4) || isdefined(var_5)) {}

  if(isdefined(var_7)) {
    if(isdefined(var_8)) {

    }

    var_10["run_turn"] = var_7;
    var_10["walk_turn"] = var_8;
    self.noturnanims = undefined;
  } else if(isdefined(var_8)) {} else
    self.noturnanims = 1;

  if(isdefined(var_9)) {
    var_18 = [];
    var_19 = ["6x8", "8x8", "10x8", "12x6", "12x8", "16x8"];

    for (var_20 = 0; var_20 < var_19.size; var_20++) {
      var_18["stairs_up_" + var_19[var_20]] = var_9["stairs_up_" + var_19[var_20]];
      var_18["stairs_down_" + var_19[var_20]] = var_9["stairs_down_" + var_19[var_20]];
      var_18["stairs_up_in_" + var_19[var_20]] = var_9["stairs_up_in_" + var_19[var_20]];
      var_18["stairs_down_in_" + var_19[var_20]] = var_9["stairs_down_in_" + var_19[var_20]];
      var_18["stairs_up_out_" + var_19[var_20]] = var_9["stairs_up_out_" + var_19[var_20]];
      var_18["stairs_down_out_" + var_19[var_20]] = var_9["stairs_down_out_" + var_19[var_20]];
    }

    var_10["walk"] = var_18;
    var_10["run"] = var_18;
    self.run_overrideanim_hasstairanimarray = 1;
  } else
    self.run_overrideanim_hasstairanimarray = undefined;

  anim.archetypes[var_0] = var_10;
  animscripts\init_move_transitions::inittransdistandanglesforarchetype(var_0);
}

clear_npc_anims(var_0) {
  self.animarchetype = undefined;
  anim.archetypes[var_0] = undefined;
  self.run_overrideanim = undefined;
  self.run_overrideanim_hasstairanimarray = undefined;
  self.walk_overrideanim = undefined;
  self.specialidleanim = undefined;
}

register_archetype(var_0, var_1, var_2) {
  animscripts\animset::registerarchetype(var_0, var_1, var_2);
}

archetype_exists(var_0) {
  return animscripts\animset::archetypeexists(var_0);
}

set_archetype(var_0) {
  self.animarchetype = var_0;
  self notify("move_loop_restart");

  if(var_0 == "creepwalk")
    self.sharpturnlookaheaddist = 72;
}

clear_archetype() {
  if(isdefined(self.animarchetype) && self.animarchetype == "creepwalk")
    self.sharpturnlookaheaddist = 30;

  self.animarchetype = undefined;
  self notify("move_loop_restart");
}

shot_endangers_any_player(var_0, var_1) {
  foreach(var_3 in level.players) {
    if(var_3 shot_endangers_player(var_0, var_1))
      return 1;
  }

  return 0;
}

shot_endangers_player(var_0, var_1) {
  var_2 = self getpointinbounds(0, 0, 0);
  var_3 = var_2 - var_0;
  var_4 = length(var_3);
  var_5 = asin(clamp(60 / var_4, 0, 1));

  if(vectordot(vectornormalize(var_3), vectornormalize(var_1 - var_0)) > cos(var_5))
    return 1;

  return 0;
}

transient_load(var_0) {
  loadtransient(var_0);

  while (!istransientloaded(var_0))
    wait 0.1;

  common_scripts\utility::flag_set(var_0 + "_loaded");
}

transient_unload(var_0) {
  unloadtransient(var_0);

  while (istransientloaded(var_0))
    wait 0.1;

  common_scripts\utility::flag_clear(var_0 + "_loaded");
}

transient_init(var_0) {
  common_scripts\utility::flag_init(var_0 + "_loaded");
}

transient_switch(var_0, var_1) {
  if(common_scripts\utility::flag(var_0 + "_loaded"))
    transient_unload(var_0);

  if(!common_scripts\utility::flag(var_1 + "_loaded"))
    transient_load(var_1);
}

transient_unloadall_and_load(var_0) {
  unloadalltransients();
  transient_load(var_0);
}

deep_array_call(var_0, var_1, var_2) {
  if(!isdefined(var_2)) {
    foreach(var_4 in var_0) {
      if(isdefined(var_4)) {
        if(isarray(var_4)) {
          deep_array_call(var_4, var_1);
          continue;
        }

        var_4 call[[var_1]]();
      }
    }
  } else {
    switch (var_2.size) {
      case 0:
        foreach(var_4 in var_0) {
          if(isdefined(var_4)) {
            if(isarray(var_4)) {
              deep_array_call(var_4, var_1, var_2);
              continue;
            }

            var_4 call[[var_1]]();
          }
        }

        break;
      case 1:
        foreach(var_4 in var_0) {
          if(isdefined(var_4)) {
            if(isarray(var_4)) {
              deep_array_call(var_4, var_1, var_2);
              continue;
            }

            var_4 call[[var_1]](var_2[0]);
          }
        }

        break;
      case 2:
        foreach(var_4 in var_0) {
          if(isdefined(var_4)) {
            if(isarray(var_4)) {
              deep_array_call(var_4, var_1, var_2);
              continue;
            }

            var_4 call[[var_1]](var_2[0], var_2[1]);
          }
        }

        break;
      case 3:
        foreach(var_4 in var_0) {
          if(isdefined(var_4)) {
            if(isarray(var_4)) {
              deep_array_call(var_4, var_1, var_2);
              continue;
            }

            var_4 call[[var_1]](var_2[0], var_2[1], var_2[2]);
          }
        }

        break;
      case 4:
        foreach(var_4 in var_0) {
          if(isdefined(var_4)) {
            if(isarray(var_4)) {
              deep_array_call(var_4, var_1, var_2);
              continue;
            }

            var_4 call[[var_1]](var_2[0], var_2[1], var_2[2], var_2[3]);
          }
        }

        break;
      case 5:
        foreach(var_4 in var_0) {
          if(isdefined(var_4)) {
            if(isarray(var_4)) {
              deep_array_call(var_4, var_1, var_2);
              continue;
            }

            var_4 call[[var_1]](var_2[0], var_2[1], var_2[2], var_2[3], var_2[4]);
          }
        }

        break;
    }
  }
}

deep_array_thread(var_0, var_1, var_2) {
  if(!isdefined(var_2)) {
    foreach(var_4 in var_0) {
      if(isdefined(var_4)) {
        if(isarray(var_4)) {
          deep_array_thread(var_4, var_1, var_2);
          continue;
        }

        var_4 thread[[var_1]]();
      }
    }
  } else {
    switch (var_2.size) {
      case 0:
        foreach(var_4 in var_0) {
          if(isdefined(var_4)) {
            if(isarray(var_4)) {
              deep_array_thread(var_4, var_1, var_2);
              continue;
            }

            var_4 thread[[var_1]]();
          }
        }

        break;
      case 1:
        foreach(var_4 in var_0) {
          if(isdefined(var_4)) {
            if(isarray(var_4)) {
              deep_array_thread(var_4, var_1, var_2);
              continue;
            }

            var_4 thread[[var_1]](var_2[0]);
          }
        }

        break;
      case 2:
        foreach(var_4 in var_0) {
          if(isdefined(var_4)) {
            if(isarray(var_4)) {
              deep_array_thread(var_4, var_1, var_2);
              continue;
            }

            var_4 thread[[var_1]](var_2[0], var_2[1]);
          }
        }

        break;
      case 3:
        foreach(var_4 in var_0) {
          if(isdefined(var_4)) {
            if(isarray(var_4)) {
              deep_array_thread(var_4, var_1, var_2);
              continue;
            }

            var_4 thread[[var_1]](var_2[0], var_2[1], var_2[2]);
          }
        }

        break;
      case 4:
        foreach(var_4 in var_0) {
          if(isdefined(var_4)) {
            if(isarray(var_4)) {
              deep_array_thread(var_4, var_1, var_2);
              continue;
            }

            var_4 thread[[var_1]](var_2[0], var_2[1], var_2[2], var_2[3]);
          }
        }

        break;
      case 5:
        foreach(var_4 in var_0) {
          if(isdefined(var_4)) {
            if(isarray(var_4)) {
              deep_array_thread(var_4, var_1, var_2);
              continue;
            }

            var_4 thread[[var_1]](var_2[0], var_2[1], var_2[2], var_2[3], var_2[4]);
          }
        }

        break;
    }
  }
}

setdvar_cg_ng(var_0, var_1, var_2) {
  if(!isdefined(level.console))
    set_console_status();

  if(is_gen4())
    setdvar(var_0, var_2);
  else
    setdvar(var_0, var_1);
}

setsaveddvar_cg_ng(var_0, var_1, var_2) {
  if(!isdefined(level.console))
    set_console_status();

  if(is_gen4())
    setsaveddvar(var_0, var_2);
  else
    setsaveddvar(var_0, var_1);
}

follow_path_and_animate(var_0, var_1) {
  self endon("death");
  self endon("stop_path");
  self notify("stop_going_to_node");
  self notify("follow_path");
  self endon("follow_path");
  wait 0.1;
  var_2 = var_0;
  var_3 = undefined;
  var_4 = undefined;

  if(!isdefined(var_1))
    var_1 = 300;

  self.current_follow_path = var_2;
  var_2 script_delay();

  while (isdefined(var_2)) {
    self.current_follow_path = var_2;

    if(isdefined(var_2.lookahead)) {
      break;
    }

    if(isdefined(level.struct_class_names["targetname"][var_2.targetname]))
      var_4 = ::follow_path_animate_set_struct;
    else if(isdefined(var_2.classname))
      var_4 = ::follow_path_animate_set_ent;
    else
      var_4 = ::follow_path_animate_set_node;

    if(isdefined(var_2.radius) && var_2.radius != 0)
      self.goalradius = var_2.radius;

    if(self.goalradius < 16)
      self.goalradius = 16;

    if(isdefined(var_2.height) && var_2.height != 0)
      self.goalheight = var_2.height;

    var_5 = self.goalradius;
    self childthread[[var_4]](var_2);

    if(isdefined(var_2.animation))
      var_2 waittill(var_2.animation);
    else {
      for (;;) {
        self waittill("goal");

        if(distance(var_2.origin, self.origin) < var_5 + 10 || self.team != "allies") {
          break;
        }
      }
    }

    var_2 notify("trigger", self);

    if(isdefined(var_2.script_flag_set))
      common_scripts\utility::flag_set(var_2.script_flag_set);

    if(isdefined(var_2.script_parameters)) {
      var_6 = strtok(var_2.script_parameters, " ");

      for (var_7 = 0; var_7 < var_6.size; var_7++) {
        if(isdefined(level.custom_followpath_parameter_func))
          self[[level.custom_followpath_parameter_func]](var_6[var_7], var_2);

        if(self.type == "dog") {
          continue;
        }
        switch (var_6[var_7]) {
          case "enable_cqb":
            enable_cqbwalk();
            break;
          case "disable_cqb":
            disable_cqbwalk();
            break;
          case "deleteme":
            self delete();
            return;
        }
      }
    }

    if(!isdefined(var_2.script_requires_player) && var_1 > 0 && self.team == "allies") {
      while (isalive(level.player)) {
        if(follow_path_wait_for_player(var_2, var_1)) {
          break;
        }

        if(isdefined(var_2.animation)) {
          self.goalradius = var_5;
          self setgoalpos(self.origin);
        }

        wait 0.05;
      }
    }

    if(!isdefined(var_2.target)) {
      break;
    }

    if(isdefined(var_2.script_flag_wait))
      common_scripts\utility::flag_wait(var_2.script_flag_wait);

    var_2 script_delay();
    var_2 = var_2 common_scripts\utility::get_target_ent();
  }

  self notify("path_end_reached");
}

follow_path_wait_for_player(var_0, var_1) {
  if(distance(level.player.origin, var_0.origin) < distance(self.origin, var_0.origin))
    return 1;

  var_2 = undefined;
  var_2 = anglestoforward(self.angles);
  var_3 = vectornormalize(level.player.origin - self.origin);

  if(isdefined(var_0.target)) {
    var_4 = common_scripts\utility::get_target_ent(var_0.target);
    var_2 = vectornormalize(var_4.origin - var_0.origin);
  } else if(isdefined(var_0.angles))
    var_2 = anglestoforward(var_0.angles);
  else
    var_2 = anglestoforward(self.angles);

  if(vectordot(var_2, var_3) > 0)
    return 1;

  if(distance(level.player.origin, self.origin) < var_1)
    return 1;

  return 0;
}

follow_path_animate_set_node(var_0) {
  self notify("follow_path_new_goal");

  if(isdefined(var_0.animation)) {
    var_0 maps\_anim::anim_generic_reach(self, var_0.animation);
    self notify("starting_anim", var_0.animation);

    if(isdefined(var_0.script_parameters) && issubstr(var_0.script_parameters, "gravity"))
      var_0 maps\_anim::anim_generic_gravity(self, var_0.animation);
    else
      var_0 maps\_anim::anim_generic_run(self, var_0.animation);

    self setgoalpos(self.origin);
  } else
    set_goal_node(var_0);
}

follow_path_animate_set_ent(var_0) {
  self notify("follow_path_new_goal");

  if(isdefined(var_0.animation)) {
    var_0 maps\_anim::anim_generic_reach(self, var_0.animation);
    self notify("starting_anim", var_0.animation);

    if(isdefined(var_0.script_parameters) && issubstr(var_0.script_parameters, "gravity"))
      var_0 maps\_anim::anim_generic_gravity(self, var_0.animation);
    else
      var_0 maps\_anim::anim_generic_run(self, var_0.animation);

    self setgoalpos(self.origin);
  } else
    set_goal_ent(var_0);
}

follow_path_animate_set_struct(var_0) {
  self notify("follow_path_new_goal");

  if(isdefined(var_0.animation)) {
    var_0 maps\_anim::anim_generic_reach(self, var_0.animation);
    self notify("starting_anim", var_0.animation);
    disable_exits();

    if(isdefined(var_0.script_parameters) && issubstr(var_0.script_parameters, "gravity"))
      var_0 maps\_anim::anim_generic_gravity(self, var_0.animation);
    else
      var_0 maps\_anim::anim_generic_run(self, var_0.animation);

    delaythread(0.05, ::enable_exits);
    self setgoalpos(self.origin);
  } else
    set_goal_pos(var_0.origin);
}

post_load_precache(var_0) {
  if(!isdefined(level.post_load_funcs))
    level.post_load_funcs = [];

  level.post_load_funcs = common_scripts\utility::array_add(level.post_load_funcs, var_0);
}

game_is_current_gen() {
  if(level.xenon)
    return 1;

  if(level.ps3)
    return 1;

  return 0;
}

lerpfov_saved(var_0, var_1) {
  thread lerpfov_saved_thread(var_0, var_1);
}

lerpfov_saved_thread(var_0, var_1) {
  self notify("new_lerp_Fov_Saved");
  self endon("new_lerp_Fov_Saved");
  self lerpfov(var_0, var_1);
  wait(var_1);
  setsaveddvar("cg_fov", var_0);
}

getdvarfloatdefault(var_0, var_1) {
  var_2 = getdvar(var_0);

  if(var_2 != "")
    return float(var_2);

  return var_1;
}

getdvarintdefault(var_0, var_1) {
  var_2 = getdvar(var_0);

  if(var_2 != "")
    return int(var_2);

  return var_1;
}

ui_action_slot_force_active_on(var_0) {
  var_1 = "ui_actionslot_" + var_0 + "_forceActive";
  setdvar(var_1, "on");
}

ui_action_slot_force_active_off(var_0) {
  var_1 = "ui_actionslot_" + var_0 + "_forceActive";
  setdvar(var_1, "turn_off");
}

ui_action_slot_force_active_one_time(var_0) {
  var_1 = "ui_actionslot_" + var_0 + "_forceActive";
  setdvar(var_1, "onetime");
}

hastag(var_0, var_1) {
  var_2 = getnumparts(var_0);

  for (var_3 = 0; var_3 < var_2; var_3++) {
    if(tolower(getpartname(var_0, var_3)) == tolower(var_1))
      return 1;
  }

  return 0;
}

stylized_center_text(var_0, var_1, var_2, var_3) {}

center_screen_text(var_0) {}

enable_s1_motionset(var_0) {
  if(!s1_motionset_avaliable()) {
    return;
  }
  if(isdefined(self.mech) && self.mech) {
    return;
  }
  if(!level.nextgen) {
    return;
  }
  if(isdefined(var_0) && var_0) {
    if(!isdefined(self.animarchetype) || self.animarchetype == "soldier")
      self.animarchetype = "s1_soldier";
  } else if(!isdefined(self.animarchetype) || self.animarchetype == "s1_soldier")
    self.animarchetype = "soldier";
}

s1_motionset_avaliable() {
  if(level.nextgen)
    return 1;

  return 0;
}

ai_ignore_everything() {
  if(isdefined(self.script_drone)) {
    return;
  }
  if(isdefined(self._ignore_settings_old))
    ai_unignore_everything();

  self._ignore_settings_old = [];
  self.disableplayeradsloscheck = maps\_utility_code::ai_save_ignore_setting(self.disableplayeradsloscheck, "disableplayeradsloscheck", 1);
  self.ignoreall = maps\_utility_code::ai_save_ignore_setting(self.ignoreall, "ignoreall", 1);
  self.ignoreme = maps\_utility_code::ai_save_ignore_setting(self.ignoreme, "ignoreme", 1);
  self.grenadeawareness = maps\_utility_code::ai_save_ignore_setting(self.grenadeawareness, "grenadeawareness", 0);
  self.badplaceawareness = maps\_utility_code::ai_save_ignore_setting(self.badplaceawareness, "badplaceawareness", 0);
  self.ignoreexplosionevents = maps\_utility_code::ai_save_ignore_setting(self.ignoreexplosionevents, "ignoreexplosionevents", 1);
  self.ignorerandombulletdamage = maps\_utility_code::ai_save_ignore_setting(self.ignorerandombulletdamage, "ignorerandombulletdamage", 1);
  self.ignoresuppression = maps\_utility_code::ai_save_ignore_setting(self.ignoresuppression, "ignoresuppression", 1);
  self.dontavoidplayer = maps\_utility_code::ai_save_ignore_setting(self.dontavoidplayer, "dontavoidplayer", 1);
  self.newenemyreactiondistsq = maps\_utility_code::ai_save_ignore_setting(self.newenemyreactiondistsq, "newEnemyReactionDistSq", 0);
  self.disablebulletwhizbyreaction = maps\_utility_code::ai_save_ignore_setting(self.disablebulletwhizbyreaction, "disableBulletWhizbyReaction", 1);
  self.disablefriendlyfirereaction = maps\_utility_code::ai_save_ignore_setting(self.disablefriendlyfirereaction, "disableFriendlyFireReaction", 1);
  self.dontmelee = maps\_utility_code::ai_save_ignore_setting(self.dontmelee, "dontMelee", 1);
  self.flashbangimmunity = maps\_utility_code::ai_save_ignore_setting(self.flashbangimmunity, "flashBangImmunity", 1);
  self.dodangerreact = maps\_utility_code::ai_save_ignore_setting(self.dodangerreact, "doDangerReact", 0);
  self.neversprintforvariation = maps\_utility_code::ai_save_ignore_setting(self.neversprintforvariation, "neverSprintForVariation", 1);
  self.a.disablepain = maps\_utility_code::ai_save_ignore_setting(self.a.disablepain, "a.disablePain", 1);
  self.allowpain = maps\_utility_code::ai_save_ignore_setting(self.allowpain, "allowPain", 0);
  self.fixednode = maps\_utility_code::ai_save_ignore_setting(self.fixednode, "fixedNode", 1);
  self.script_forcegoal = maps\_utility_code::ai_save_ignore_setting(self.script_forcegoal, "script_forcegoal", 1);
  self.goalradius = maps\_utility_code::ai_save_ignore_setting(self.goalradius, "goalradius", 5);
  disable_ai_color();
}

ai_unignore_everything(var_0, var_1) {
  if(isdefined(self.script_drone)) {
    return;
  }
  if(isdefined(var_0) && var_0) {
    if(isdefined(self._ignore_settings_old))
      self._ignore_settings_old = undefined;
  }

  self.disableplayeradsloscheck = maps\_utility_code::ai_restore_ignore_setting("disableplayeradsloscheck", 0);
  self.ignoreall = maps\_utility_code::ai_restore_ignore_setting("ignoreall", 0);
  self.ignoreme = maps\_utility_code::ai_restore_ignore_setting("ignoreme", 0);
  self.grenadeawareness = maps\_utility_code::ai_restore_ignore_setting("grenadeawareness", 1);
  self.badplaceawareness = maps\_utility_code::ai_restore_ignore_setting("badplaceawareness", 1);
  self.ignoreexplosionevents = maps\_utility_code::ai_restore_ignore_setting("ignoreexplosionevents", 0);
  self.ignorerandombulletdamage = maps\_utility_code::ai_restore_ignore_setting("ignorerandombulletdamage", 0);
  self.ignoresuppression = maps\_utility_code::ai_restore_ignore_setting("ignoresuppression", 0);
  self.dontavoidplayer = maps\_utility_code::ai_restore_ignore_setting("dontavoidplayer", 0);
  self.newenemyreactiondistsq = maps\_utility_code::ai_restore_ignore_setting("newEnemyReactionDistSq", 262144);
  self.disablebulletwhizbyreaction = maps\_utility_code::ai_restore_ignore_setting("disableBulletWhizbyReaction", undefined);
  self.disablefriendlyfirereaction = maps\_utility_code::ai_restore_ignore_setting("disableFriendlyFireReaction", undefined);
  self.dontmelee = maps\_utility_code::ai_restore_ignore_setting("dontMelee", undefined);
  self.flashbangimmunity = maps\_utility_code::ai_restore_ignore_setting("flashBangImmunity", undefined);
  self.dodangerreact = maps\_utility_code::ai_restore_ignore_setting("doDangerReact", 1);
  self.neversprintforvariation = maps\_utility_code::ai_restore_ignore_setting("neverSprintForVariation", undefined);
  self.a.disablepain = maps\_utility_code::ai_restore_ignore_setting("a.disablePain", 0);
  self.allowpain = maps\_utility_code::ai_restore_ignore_setting("allowPain", 1);
  self.fixednode = maps\_utility_code::ai_restore_ignore_setting("fixedNode", 0);
  self.script_forcegoal = maps\_utility_code::ai_restore_ignore_setting("script_forcegoal", 0);
  self.goalradius = maps\_utility_code::ai_restore_ignore_setting("goalradius", 100);

  if(!(isdefined(var_1) && var_1))
    enable_ai_color();

  self._ignore_settings_old = undefined;
}

attach_player_current_weapon_to_anim_tag(var_0) {
  var_1 = level.player getcurrentweapon();
  var_2 = getweaponandattachmentmodels(var_1);
  var_3 = var_2[0]["weapon"];
  var_4 = array_remove_index(var_2, 0);
  self attach(var_3, var_0, 1);

  foreach(var_6 in var_4)
  self attach(var_6["attachment"], var_6["attachTag"]);

  self hideweapontags(var_1);
}

playerallowalternatemelee(var_0, var_1) {
  _playerallow("altmelee", var_0, var_1, ::_allowalternatemelee, 0);
}

_allowalternatemelee(var_0) {
  if(var_0)
    self enablealternatemelee();
  else
    self disablealternatemelee();
}

playerallowweaponpickup(var_0, var_1) {
  _playerallow("weaponPickup", var_0, var_1, ::_allowweaponpickup, 0);
}

_allowweaponpickup(var_0) {
  if(var_0)
    self enableweaponpickup();
  else
    self disableweaponpickup();
}

_playerallow(var_0, var_1, var_2, var_3, var_4) {
  if(!isdefined(self.playerdisableabilitytypes))
    self.playerdisableabilitytypes = [];

  if(!isdefined(self.playerdisableabilitytypes[var_0]))
    self.playerdisableabilitytypes[var_0] = [];

  if(!isdefined(var_2))
    var_2 = "default";

  if(var_1) {
    self.playerdisableabilitytypes[var_0] = common_scripts\utility::array_remove(self.playerdisableabilitytypes[var_0], var_2);

    if(!self.playerdisableabilitytypes[var_0].size) {
      if(!isdefined(var_4) || var_4)
        self call[[var_3]](1);
      else
        self[[var_3]](1);
    }
  } else {
    if(!isdefined(common_scripts\utility::array_find(self.playerdisableabilitytypes[var_0], var_2)))
      self.playerdisableabilitytypes[var_0] = common_scripts\utility::array_add(self.playerdisableabilitytypes[var_0], var_2);

    if(!isdefined(var_4) || var_4)
      self call[[var_3]](0);
    else
      self[[var_3]](0);
  }
}

pretend_to_be_dead() {
  if(!isalive(self)) {
    return;
  }
  self.pretending_to_be_dead = 1;
  self setthreatdetection("disable");
  self disableaimassist();
  self.ignoreme = 1;
  self.ignoresonicaoe = 1;
}

tff_sync_setup() {
  precacheshader("loading_animation");
  common_scripts\utility::flag_init("tff_sync_complete");
  maps\_utility_code::_tff_sync_triggers();
}

tff_sync(var_0) {
  if(isdefined(var_0))
    wait(var_0);

  if(aretransientsbusy()) {
    common_scripts\utility::flag_clear("tff_sync_complete");
    synctransients();

    while (aretransientsbusy())
      wait 0.05;

    common_scripts\utility::flag_set("tff_sync_complete");
  }
}

tff_sync_notetrack(var_0, var_1) {
  tff_sync(var_1);
}

logbreadcrumbdatasp() {
  level.player endon("death");

  for (;;) {
    var_0 = getspcheckpointdata();

    if(var_0 != undefined) {
      var_1 = var_0[4];
      var_2 = gettime();
      recordbreadcrumbdataforplayersp(level.player, var_1, var_2);
    }

    wait 2;
  }
}

vector_multiply(var_0, var_1) {
  var_0 = (var_0[0] * var_1, var_0[1] * var_1, var_0[2] * var_1);
  return var_0;
}

is_h1_level() {
  switch (level.script) {
    case "simplecredits":
    case "village_defend":
    case "village_assault":
    case "sniperescape":
    case "scoutsniper":
    case "launchfacility_b":
    case "launchfacility_a":
    case "killhouse":
    case "jeepride":
    case "icbm":
    case "hunted":
    case "coup":
    case "cargoship":
    case "bog_b":
    case "bog_a":
    case "blackout":
    case "ambush":
    case "airplane":
    case "aftermath":
    case "ac130":
    case "airlift":
    case "armada":
      return 1;
  }

  return 0;
}

yaw_ent_by_linked(var_0) {
  self enablequatinterpolationrotation(1);

  for (;;) {
    self rotatebylinked((0, 360, 0), var_0);
    wait(var_0);
  }
}

rotate_ent_with_ent(var_0) {
  if(!isdefined(var_0)) {
    return;
  }
  for (;;) {
    self.angles = var_0.angles;
    wait 0.05;
  }
}

enable_scuff_footsteps_sound(var_0) {
  if(!isdefined(var_0))
    var_0 = 1;

  setsaveddvar("bg_allowScuffFootsteps", var_0);
}

ai_team_run_twitch_think(var_0, var_1, var_2, var_3, var_4) {
  if(isdefined(var_4) && is_start_or_after_start(var_4)) {
    return;
  }
  if(!isdefined(var_3) || !is_start_or_after_start(var_3))
    common_scripts\utility::flag_wait(var_1);

  animscripts\utility::set_team_run_twitch_animation(var_0, 1);

  if(isdefined(var_2)) {
    common_scripts\utility::flag_wait(var_2);
    animscripts\utility::set_team_run_twitch_animation(var_0, 0);
  }
}

get_anim_reach_unique_id() {
  if(isdefined(level.anim_reach_id))
    level.anim_reach_id++;
  else
    level.anim_reach_id = 0;

  return level.anim_reach_id;
}

keep_distance(var_0, var_1) {
  foreach(var_3 in var_0) {
    var_4 = common_scripts\utility::array_remove(var_0, var_3);
    var_3 thread keep_distance_from_others(var_4, var_1);
  }
}

stop_keep_distance(var_0) {
  foreach(var_2 in var_0) {
    if(isalive(var_2))
      var_2 ent_flag_set("stop_keep_distance");
  }
}

keep_distance_from_others(var_0, var_1) {
  self notify("start_keep_distance");
  self endon("death");
  self endon("start_keep_distance");

  if(!ent_flag_exist("stop_keep_distance"))
    ent_flag_init("stop_keep_distance");

  if(!isdefined(var_1))
    var_2 = spawnstruct();
  else
    var_2 = var_1;

  if(!isdefined(var_2.range))
    var_2.range = 100;

  if(!isdefined(var_2.slow_rate))
    var_2.slow_rate = 0.8;

  if(!isdefined(var_2.speed_min))
    var_2.speed_min = 0.5;

  if(!isdefined(var_2.slow_duration))
    var_2.slow_duration = 1.0;

  if(!isdefined(var_2.front_angle))
    var_2.front_angle = 60;

  self.old_distance_moverate = self.moveplaybackrate;

  for (;;) {
    if(ent_flag("stop_keep_distance")) {
      break;
    }

    var_3 = common_scripts\utility::getclosest(self.origin, var_0, var_2.range);

    if(isdefined(var_3) && common_scripts\utility::within_fov(self.origin, self.angles, var_3.origin, cos(var_2.front_angle))) {
      if(self.moveplaybackrate > var_3.moveplaybackrate)
        self.moveplaybackrate = clamp(var_3.moveplaybackrate * var_2.slow_rate, var_2.speed_min, var_3.moveplaybackrate);
      else
        self.moveplaybackrate = clamp(self.old_distance_moverate * var_2.slow_rate, var_2.speed_min, self.old_distance_moverate);

      wait(var_2.slow_duration);
    } else
      self.moveplaybackrate = self.old_distance_moverate;

    wait 0.05;
  }

  self.moveplaybackrate = self.old_distance_moverate;
  self.old_distance_moverate = undefined;
  ent_flag_clear("stop_keep_distance");
}

rumble_sequence_play(var_0, var_1) {
  for (var_2 = 0; var_2 < var_0.size; var_2++) {
    common_scripts\utility::delaycall(var_0[var_2].delay, ::playrumbleonentity, var_0[var_2].rumble);

    if(isdefined(var_1) && var_1)
      common_scripts\utility::noself_delaycall(var_0[var_2].delay, ::iprintln, "" + var_0[var_2].rumble + " with delay of " + var_0[var_2].delay);
  }

  if(isdefined(var_1) && var_1) {
    for (var_2 = 0; var_2 < var_0.size; var_2++) {

    }
  }
}

rumble_sequence_add_key(var_0, var_1, var_2) {
  var_3 = spawnstruct();
  var_3.delay = var_1;
  var_3.rumble = var_2;
  return common_scripts\utility::array_add(var_0, var_3);
}