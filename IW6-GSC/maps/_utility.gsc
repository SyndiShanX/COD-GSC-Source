/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_utility.gsc
*****************************************************/

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

  if(isDefined(var_0.laststand))
    return var_0.laststand;

  return !isalive(var_0);
}

is_player_down_and_out(var_0) {
  if(!isDefined(var_0.down_part2_proc_ran))
    return 0;

  return var_0.down_part2_proc_ran;
}

killing_will_down(var_0) {
  if(laststand_enabled()) {
    if(isDefined(level.laststand_kill_will_down_func))
      return var_0[[level.laststand_kill_will_down_func]]();
  }

  return 0;
}

is_survival() {
  return is_specialop() && getdvarint("so_survival") > 0;
}

laststand_enabled() {
  return isDefined(level.laststand_type) && level.laststand_type > 0;
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

  if(isDefined(var_1) && var_1) {
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

  for(var_4 = 1; var_4 <= var_1; var_4++)
    var_3 = var_3 * 10;

  var_5 = var_0 * var_3;

  if(!isDefined(var_2) || var_2)
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

set_vision_set(var_0, var_1) {
  if(maps\_utility_code::init_vision_set(var_0)) {
    return;
  }
  if(!isDefined(var_1))
    var_1 = 1;

  visionsetnaked(var_0, var_1);
  setdvar("vision_set_current", var_0);
}

set_vision_set_player(var_0, var_1) {
  if(maps\_utility_code::init_vision_set(var_0)) {
    return;
  }
  if(!isDefined(var_1))
    var_1 = 1;

  self visionsetnakedforplayer(var_0, var_1);
}

sun_light_fade(var_0, var_1, var_2) {
  var_2 = int(var_2 * 20);
  var_3 = [];

  for(var_4 = 0; var_4 < 3; var_4++)
    var_3[var_4] = (var_0[var_4] - var_1[var_4]) / var_2;

  var_5 = [];

  for(var_4 = 0; var_4 < var_2; var_4++) {
    wait 0.05;

    for(var_6 = 0; var_6 < 3; var_6++)
      var_5[var_6] = var_0[var_6] - var_3[var_6] * var_4;

    setsunlight(var_5[0], var_5[1], var_5[2]);
  }

  setsunlight(var_1[0], var_1[1], var_1[2]);
}

ent_flag_wait(var_0) {
  while(isDefined(self) && !self.ent_flag[var_0])
    self waittill(var_0);
}

ent_flag_wait_vehicle_node(var_0) {
  while(isDefined(self) && !self.ent_flag[var_0])
    self waittill(var_0);
}

ent_flag_wait_either(var_0, var_1) {
  while(isDefined(self)) {
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

  while(isDefined(self)) {
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
  while(isDefined(self) && self.ent_flag[var_0])
    self waittill(var_0);
}

ent_flag_assert(var_0) {}

ent_flag_waitopen_either(var_0, var_1) {
  while(isDefined(self)) {
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
  if(!isDefined(self.ent_flag)) {
    self.ent_flag = [];
    self.ent_flags_lock = [];
  }

  self.ent_flag[var_0] = 0;
}

ent_flag_exist(var_0) {
  if(isDefined(self.ent_flag) && isDefined(self.ent_flag[var_0]))
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

  if(isDefined(var_1) && var_1)
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
  if(!isDefined(var_1))
    var_1 = level.player;

  if(!isDefined(var_3))
    var_3 = -1;

  var_4 = var_1.origin;

  if(isDefined(var_2) && var_2)
    var_4 = var_1 getEye();

  var_5 = undefined;
  var_6 = var_1 getplayerangles();
  var_7 = anglesToForward(var_6);
  var_8 = -1;

  foreach(var_10 in var_0) {
    var_11 = vectortoangles(var_10.origin - var_4);
    var_12 = anglesToForward(var_11);
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
  if(!isDefined(var_1))
    var_1 = level.player;

  var_3 = var_1.origin;

  if(isDefined(var_2) && var_2)
    var_3 = var_1 getEye();

  var_4 = undefined;
  var_5 = var_1 getplayerangles();
  var_6 = anglesToForward(var_5);
  var_7 = -1;

  for(var_8 = 0; var_8 < var_0.size; var_8++) {
    var_9 = vectortoangles(var_0[var_8].origin - var_3);
    var_10 = anglesToForward(var_9);
    var_11 = vectordot(var_6, var_10);

    if(var_11 < var_7) {
      continue;
    }
    var_7 = var_11;
    var_4 = var_8;
  }

  return var_4;
}

flag_trigger_init(var_0, var_1, var_2) {
  common_scripts\utility::flag_init(var_0);

  if(!isDefined(var_2))
    var_2 = 0;

  var_1 thread maps\_utility_code::_flag_wait_trigger(var_0, var_2);
  return var_1;
}

flag_triggers_init(var_0, var_1, var_2) {
  common_scripts\utility::flag_init(var_0);

  if(!isDefined(var_2))
    var_2 = 0;

  for(var_3 = 0; var_3 < var_1.size; var_3++)
    var_1[var_3] thread maps\_utility_code::_flag_wait_trigger(var_0, 0);

  return var_1;
}

flag_clear_delayed(var_0, var_1) {
  wait(var_1);
  common_scripts\utility::flag_clear(var_0);
}

level_end_save() {
  if(arcademode()) {
    return;
  }
  if(level.missionfailed) {
    return;
  }
  if(common_scripts\utility::flag("game_saving")) {
    return;
  }
  for(var_0 = 0; var_0 < level.players.size; var_0++) {
    var_1 = level.players[var_0];

    if(!isalive(var_1))
      return;
  }

  common_scripts\utility::flag_set("game_saving");
  var_2 = "levelshots / autosave / autosave_" + level.script + "end";
  savegame("levelend", &"AUTOSAVE_AUTOSAVE", var_2, 1);
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

autosave_stealth() {
  thread autosave_by_name_thread("autosave_stealth", 8, 1);
}

autosave_stealth_silent() {
  thread autosave_by_name_thread("autosave_stealth", 8, 1, 1);
}

autosave_tactical() {
  maps\_utility_code::autosave_tactical_setup();
  thread maps\_utility_code::autosave_tactical_proc();
}

autosave_by_name(var_0) {
  thread autosave_by_name_thread(var_0);
}

autosave_by_name_silent(var_0) {
  thread autosave_by_name_thread(var_0, undefined, undefined, 1);
}

autosave_by_name_thread(var_0, var_1, var_2, var_3) {
  if(!isDefined(level.curautosave))
    level.curautosave = 1;

  var_4 = "levelshots/autosave/autosave_" + level.script + level.curautosave;
  var_5 = level maps\_autosave::tryautosave(level.curautosave, "autosave", var_4, var_1, var_2, var_3);

  if(isDefined(var_5) && var_5)
    level.curautosave++;
}

autosave_or_timeout(var_0, var_1) {
  thread autosave_by_name_thread(var_0, var_1);
}

debug_message(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_2))
    var_2 = 5;

  if(isDefined(var_3)) {
    var_3 endon("death");
    var_1 = var_3.origin;
  }

  for(var_4 = 0; var_4 < var_2 * 20; var_4++) {
    if(!isDefined(var_3)) {} else {}

    wait 0.05;
  }
}

debug_message_ai(var_0, var_1) {
  self notify("debug_message_ai");
  self endon("debug_message_ai");
  self endon("death");

  if(!isDefined(var_1))
    var_1 = 5;

  for(var_2 = 0; var_2 < var_1 * 20; var_2++)
    wait 0.05;
}

debug_message_clear(var_0, var_1, var_2, var_3) {
  if(isDefined(var_3)) {
    level notify(var_0 + var_3);
    level endon(var_0 + var_3);
  } else {
    level notify(var_0);
    level endon(var_0);
  }

  if(!isDefined(var_2))
    var_2 = 5;

  for(var_4 = 0; var_4 < var_2 * 20; var_4++)
    wait 0.05;
}

precache(var_0) {
  var_1 = spawn("script_model", (0, 0, 0));
  var_1.origin = level.player getorigin();
  var_1 setModel(var_0);
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

  for(var_5 = 0; var_5 < var_1.size; var_5++) {
    var_6 = distance(var_0, var_1[var_5]);

    if(var_6 >= var_4) {
      continue;
    }
    var_4 = var_6;
    var_3 = var_1[var_5];
  }

  if(!isDefined(var_2) || var_4 <= var_2)
    return var_3;

  return undefined;
}

get_farthest_ent(var_0, var_1) {
  if(var_1.size < 1) {
    return;
  }
  var_2 = distance(var_1[0] getorigin(), var_0);
  var_3 = var_1[0];

  for(var_4 = 0; var_4 < var_1.size; var_4++) {
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

  for(var_4 = 0; var_4 < var_1.size; var_4++) {
    if(distance(var_1[var_4].origin, var_0) <= var_2)
      var_3[var_3.size] = var_1[var_4];
  }

  return var_3;
}

get_outside_range(var_0, var_1, var_2) {
  var_3 = [];

  for(var_4 = 0; var_4 < var_1.size; var_4++) {
    if(distance(var_1[var_4].origin, var_0) > var_2)
      var_3[var_3.size] = var_1[var_4];
  }

  return var_3;
}

get_closest_living(var_0, var_1, var_2) {
  if(!isDefined(var_2))
    var_2 = 9999999;

  if(var_1.size < 1) {
    return;
  }
  var_3 = undefined;

  for(var_4 = 0; var_4 < var_1.size; var_4++) {
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
  var_5 = anglesToForward(var_4);
  var_6 = -1;

  foreach(var_8 in var_2) {
    var_4 = vectortoangles(var_8.origin - var_0);
    var_9 = anglesToForward(var_4);
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
  if(!isDefined(var_2))
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
  if(!isDefined(var_1))
    return undefined;

  var_3 = 0;

  if(isDefined(var_2) && var_2.size) {
    var_4 = [];

    for(var_5 = 0; var_5 < var_1.size; var_5++)
      var_4[var_5] = 0;

    for(var_5 = 0; var_5 < var_1.size; var_5++) {
      for(var_6 = 0; var_6 < var_2.size; var_6++) {
        if(var_1[var_5] == var_2[var_6])
          var_4[var_5] = 1;
      }
    }

    var_7 = 0;

    for(var_5 = 0; var_5 < var_1.size; var_5++) {
      if(!var_4[var_5] && isDefined(var_1[var_5])) {
        var_7 = 1;
        var_3 = distance(var_0, var_1[var_5].origin);
        var_8 = var_5;
        var_5 = var_1.size + 1;
      }
    }

    if(!var_7)
      return undefined;
  } else {
    for(var_5 = 0; var_5 < var_1.size; var_5++) {
      if(isDefined(var_1[var_5])) {
        var_3 = distance(var_0, var_1[0].origin);
        var_8 = var_5;
        var_5 = var_1.size + 1;
      }
    }
  }

  var_8 = undefined;

  for(var_5 = 0; var_5 < var_1.size; var_5++) {
    if(isDefined(var_1[var_5])) {
      var_4 = 0;

      if(isDefined(var_2)) {
        for(var_6 = 0; var_6 < var_2.size; var_6++) {
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

  if(isDefined(var_8))
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
  if(isDefined(var_1))
    var_3 = getaiarray(var_1);
  else
    var_3 = getaiarray();

  if(var_3.size == 0)
    return undefined;

  if(isDefined(var_2))
    var_3 = common_scripts\utility::array_remove_array(var_3, var_2);

  return common_scripts\utility::getclosest(var_0, var_3);
}

get_closest_ai_exclude(var_0, var_1, var_2) {
  if(isDefined(var_1))
    var_3 = getaiarray(var_1);
  else
    var_3 = getaiarray();

  if(var_3.size == 0)
    return undefined;

  return get_closest_exclude(var_0, var_3, var_2);
}

get_progress(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_3))
    var_3 = distance(var_0, var_1);

  var_3 = max(0.01, var_3);
  var_4 = vectornormalize(var_1 - var_0);
  var_5 = var_2 - var_0;
  var_6 = vectordot(var_5, var_4);
  var_6 = var_6 / var_3;
  var_6 = clamp(var_6, 0, 1);
  return var_6;
}

can_see_origin(var_0, var_1) {
  if(!isDefined(var_1))
    var_1 = 1;

  if(!point_in_fov(var_0))
    return 0;

  if(!sighttracepassed(self getEye(), var_0, var_1, self))
    return 0;

  return 1;
}

point_in_fov(var_0) {
  var_1 = anglesToForward(self.angles);
  var_2 = vectornormalize(var_0 - self.origin);
  var_3 = vectordot(var_1, var_2);
  return var_3 > 0.766;
}

stop_magic_bullet_shield() {
  self notify("stop_magic_bullet_shield");

  if(isai(self))
    self.attackeraccuracy = 1;

  self.magic_bullet_shield = undefined;
  self.damageshield = 0;
  self notify("internal_stop_magic_bullet_shield");
}

magic_bullet_death_detection() {}

magic_bullet_shield(var_0) {
  if(isai(self)) {} else
    self.health = 100000;

  self endon("internal_stop_magic_bullet_shield");

  if(isai(self))
    self.attackeraccuracy = 0.1;

  self notify("magic_bullet_shield");
  self.magic_bullet_shield = 1;
  self.damageshield = 1;
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

  if(!isDefined(self.ignore_me_timer_prev_value))
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

force_crawling_death(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_1))
    var_1 = 4;

  thread force_crawling_death_proc(var_0, var_1, var_2, var_3);
}

#using_animtree("generic_human");

override_crawl_death_anims() {
  if(isDefined(self.a.custom_crawling_death_array)) {
    self.a.array["crawl"] = self.a.custom_crawling_death_array["crawl"];
    self.a.array["death"] = self.a.custom_crawling_death_array["death"];
    self.a.crawl_fx_rate = self.a.custom_crawling_death_array["blood_fx_rate"];

    if(isDefined(self.a.custom_crawling_death_array["blood_fx"]))
      self.a.crawl_fx = self.a.custom_crawling_death_array["blood_fx"];
  }

  self.a.array["stand_2_crawl"] = [];
  self.a.array["stand_2_crawl"][0] = % dying_stand_2_crawl_v3;

  if(isDefined(self.nofallanim))
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

  if(!isDefined(var_3) || var_3 == 0)
    self.a.force_crawl_angle = var_0 + 181.02;
  else {
    self.a.force_crawl_angle = var_0;
    thread animscripts\notetracks::notetrackposecrawl();
  }
}

shock_ondeath() {
  precacheshellshock("default");
  self waittill("death");

  if(isDefined(self.specialdeath)) {
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

  for(;;) {
    if(self.unresolved_collision) {
      self.unresolved_collision = 0;

      if(self.unresolved_collision_count >= 20) {
        if(isDefined(self.handle_unresolved_collision))
          self[[self.handle_unresolved_collision]]();
        else
          default_unresolved_collision_handler();
      }
    } else
      reset_unresolved_collision_handler();

    wait 0.05;
  }
}

playerwatch_unresolved_collision_count() {
  for(;;) {
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

  if(isDefined(var_0)) {
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
  var_5 = spawn("script_origin", (0, 0, 0));
  var_5 endon("death");
  thread delete_on_death_wait_sound(var_5, "sounddone");

  if(isDefined(var_1))
    var_5 linkto(self, var_1, (0, 0, 0), (0, 0, 0));
  else {
    var_5.origin = self.origin;
    var_5.angles = self.angles;
    var_5 linkto(self);
  }

  var_5 playSound(var_0, "sounddone");

  if(isDefined(var_2)) {
    if(!isDefined(maps\_utility_code::wait_for_sounddone_or_death(var_5)))
      var_5 stopsounds();

    wait 0.05;
  } else
    var_5 waittill("sounddone");

  if(isDefined(var_3))
    self notify(var_3);

  var_5 delete();
}

play_sound_on_tag_endon_death(var_0, var_1) {
  play_sound_on_tag(var_0, var_1, 1);
}

play_sound_on_entity(var_0, var_1) {
  play_sound_on_tag(var_0, undefined, undefined, var_1);
}

play_loop_sound_on_tag(var_0, var_1, var_2, var_3) {
  var_4 = spawn("script_origin", (0, 0, 0));
  var_4 endon("death");

  if(!isDefined(var_2))
    var_2 = 1;

  if(var_2)
    thread common_scripts\utility::delete_on_death(var_4);

  if(!isDefined(var_3))
    var_3 = 0;

  if(var_3)
    thread delete_on_removed(var_4);

  if(isDefined(var_1))
    var_4 linkto(self, var_1, (0, 0, 0), (0, 0, 0));
  else {
    var_4.origin = self.origin;
    var_4.angles = self.angles;
    var_4 linkto(self);
  }

  var_4 playLoopSound(var_0);
  self waittill("stop sound" + var_0);
  var_4 stoploopsound(var_0);
  var_4 delete();
}

delete_on_removed(var_0) {
  var_0 endon("death");

  while(isDefined(self))
    wait 0.05;

  if(isDefined(var_0))
    var_0 delete();
}

save_friendlies() {
  var_0 = getaiarray("allies");
  var_1 = 0;

  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    if(isDefined(var_0[var_2].script_friendname)) {
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

  if(!isDefined(var_0.finished_spawning))
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

  for(;;) {
    maps\_debug::drawtag(var_0);
    wait 0.05;
  }
}

assign_animtree(var_0) {
  if(isDefined(var_0))
    self.animname = var_0;

  self useanimtree(level.scr_animtree[self.animname]);
}

assign_model() {
  if(isarray(level.scr_model[self.animname])) {
    var_0 = randomint(level.scr_model[self.animname].size);
    self setModel(level.scr_model[self.animname][var_0]);
  } else
    self setModel(level.scr_model[self.animname]);
}

spawn_anim_model(var_0, var_1, var_2) {
  if(!isDefined(var_1))
    var_1 = (0, 0, 0);

  var_3 = spawn("script_model", var_1);
  var_3.animname = var_0;
  var_3 assign_animtree();
  var_3 assign_model();

  if(isDefined(var_2))
    var_3.angles = var_2;

  return var_3;
}

trigger_wait(var_0, var_1) {
  var_2 = getent(var_0, var_1);

  if(!isDefined(var_2)) {
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
  var_4 = spawnStruct();
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
  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    if(var_0[var_2] == var_1)
      return 1;
  }

  return 0;
}

waittill_dead(var_0, var_1, var_2) {
  var_10 = spawnStruct();

  if(isDefined(var_2)) {
    var_10 endon("thread_timed_out");
    var_10 thread waittill_dead_timeout(var_2);
  }

  var_10.count = var_0.size;

  if(isDefined(var_1) && var_1 < var_10.count)
    var_10.count = var_1;

  common_scripts\utility::array_thread(var_0, ::waittill_dead_thread, var_10);

  while(var_10.count > 0)
    var_10 waittill("waittill_dead guy died");
}

waittill_dead_or_dying(var_0, var_1, var_2) {
  var_3 = [];

  foreach(var_5 in var_0) {
    if(isalive(var_5) && !var_5.ignoreforfixednodesafecheck)
      var_3[var_3.size] = var_5;
  }

  var_0 = var_3;
  var_7 = spawnStruct();

  if(isDefined(var_2)) {
    var_7 endon("thread_timed_out");
    var_7 thread waittill_dead_timeout(var_2);
  }

  var_7.count = var_0.size;

  if(isDefined(var_1) && var_1 < var_7.count)
    var_7.count = var_1;

  common_scripts\utility::array_thread(var_0, ::waittill_dead_or_dying_thread, var_7);

  while(var_7.count > 0)
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
  while(level._ai_group[var_0].spawnercount || level._ai_group[var_0].aicount)
    wait 0.25;
}

waittill_aigroupcount(var_0, var_1) {
  while(level._ai_group[var_0].spawnercount + level._ai_group[var_0].aicount > var_1)
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

  for(var_2 = 0; var_2 < level._ai_group[var_0].ai.size; var_2++) {
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
        if(isDefined(var_5.targetname) && var_5.targetname == var_0)
          var_3[var_3.size] = var_5;

        break;
      case "script_noteworthy":
        if(isDefined(var_5.script_noteworthy) && var_5.script_noteworthy == var_0)
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
  var_2 = getEntArray(var_0, var_1);
  var_3 = [];
  var_4 = [];

  foreach(var_6 in var_2) {
    if(var_6.code_classname != "script_vehicle") {
      continue;
    }
    var_4[0] = var_6;

    if(isspawner(var_6)) {
      if(isDefined(var_6.last_spawned_vehicle)) {
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
  if(!isDefined(var_2))
    var_2 = "all";

  var_3 = getaispeciesarray("allies", var_2);
  var_3 = common_scripts\utility::array_combine(var_3, getaispeciesarray("axis", var_2));
  var_4 = [];

  for(var_5 = 0; var_5 < var_3.size; var_5++) {
    switch (var_1) {
      case "targetname":
        if(isDefined(var_3[var_5].targetname) && var_3[var_5].targetname == var_0)
          var_4[var_4.size] = var_3[var_5];

        break;
      case "script_noteworthy":
        if(isDefined(var_3[var_5].script_noteworthy) && var_3[var_5].script_noteworthy == var_0)
          var_4[var_4.size] = var_3[var_5];

        break;
    }
  }

  return var_4;
}

gather_delay_proc(var_0, var_1) {
  if(isDefined(level.gather_delay[var_0])) {
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

  for(var_3 = 0; var_3 < var_0.size; var_3++) {
    var_4 = var_0[var_3];
    var_5 = var_4.script_linkname;

    if(!isDefined(var_5)) {
      continue;
    }
    if(!isDefined(var_1[var_5])) {
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

  for(var_3 = 0; var_3 < var_0.size; var_3++) {
    var_4 = var_0[var_3];
    var_2[var_4.script_linkname] = 1;
  }

  for(var_3 = 0; var_3 < var_1.size; var_3++) {
    var_4 = var_1[var_3];

    if(isDefined(var_2[var_4.script_linkname])) {
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

  for(var_3 = 0; var_3 < var_1.size; var_3++) {
    if(is_in_array(var_0, var_1[var_3]))
      var_2 = common_scripts\utility::array_remove(var_2, var_1[var_3]);
  }

  return var_2;
}

array_compare(var_0, var_1) {
  if(var_0.size != var_1.size)
    return 0;

  foreach(var_5, var_3 in var_0) {
    if(!isDefined(var_1[var_5]))
      return 0;

    var_4 = var_1[var_5];

    if(var_4 != var_3)
      return 0;
  }

  return 1;
}

getlinkedvehiclenodes() {
  var_0 = [];

  if(isDefined(self.script_linkto)) {
    var_1 = common_scripts\utility::get_links();

    foreach(var_3 in var_1) {
      var_4 = getvehiclenodearray(var_3, "script_linkname");
      var_0 = common_scripts\utility::array_combine(var_0, var_4);
    }
  }

  return var_0;
}

draw_line(var_0, var_1, var_2, var_3, var_4) {
  for(;;)
    wait 0.05;
}

draw_line_to_ent_for_time(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_5 = gettime() + var_5 * 1000;

  while(gettime() < var_5) {
    wait 0.05;

    if(!isDefined(var_1) || !isDefined(var_1.origin))
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

  while(gettime() < var_5)
    wait 0.05;
}

draw_line_from_ent_to_ent_until_notify(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_0 endon("death");
  var_1 endon("death");
  var_5 endon(var_6);

  for(;;)
    wait 0.05;
}

draw_line_until_notify(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_5 endon(var_6);

  for(;;)
    common_scripts\utility::draw_line_for_time(var_0, var_1, var_2, var_3, var_4, 0.05);
}

draw_line_from_ent_to_vec_for_time(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_6 = gettime() + var_6 * 1000;
  var_1 = var_1 * var_2;

  while(gettime() < var_6) {
    wait 0.05;

    if(!isDefined(var_0) || !isDefined(var_0.origin))
      return;
  }
}

draw_circle_until_notify(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = 16;
  var_8 = 360 / var_7;
  var_9 = [];

  for(var_10 = 0; var_10 < var_7; var_10++) {
    var_11 = var_8 * var_10;
    var_12 = cos(var_11) * var_1;
    var_13 = sin(var_11) * var_1;
    var_14 = var_0[0] + var_12;
    var_15 = var_0[1] + var_13;
    var_16 = var_0[2];
    var_9[var_9.size] = (var_14, var_15, var_16);
  }

  thread draw_circle_lines_until_notify(var_9, var_2, var_3, var_4, var_5, var_6);
}

draw_circle_lines_until_notify(var_0, var_1, var_2, var_3, var_4, var_5) {
  for(var_6 = 0; var_6 < var_0.size; var_6++) {
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
  level notify("battlechatter_off_thread");
  animscripts\battlechatter::bcs_setup_chatter_toggle_array();

  if(isDefined(var_0)) {
    set_battlechatter_variable(var_0, 0);
    var_1 = getaiarray(var_0);
  } else {
    foreach(var_0 in anim.teams)
    set_battlechatter_variable(var_0, 0);

    var_1 = getaiarray();
  }

  if(!isDefined(anim.chatinitialized) || !anim.chatinitialized) {
    return;
  }
  for(var_4 = 0; var_4 < var_1.size; var_4++)
    var_1[var_4].battlechatter = 0;

  for(var_4 = 0; var_4 < var_1.size; var_4++) {
    var_5 = var_1[var_4];

    if(!isalive(var_5)) {
      continue;
    }
    if(!var_5.chatinitialized) {
      continue;
    }
    if(!var_5.isspeaking) {
      continue;
    }
    var_5 maps\_utility_code::wait_until_done_speaking();
  }

  var_6 = gettime() - anim.lastteamspeaktime["allies"];

  if(var_6 < 1500)
    wait(var_6 / 1000);

  if(isDefined(var_0))
    level notify(var_0 + " done speaking");
  else
    level notify("done speaking");
}

battlechatter_on(var_0) {
  thread battlechatter_on_thread(var_0);
}

battlechatter_on_thread(var_0) {
  level endon("battlechatter_off_thread");
  animscripts\battlechatter::bcs_setup_chatter_toggle_array();

  while(!isDefined(anim.chatinitialized))
    wait 0.05;

  common_scripts\utility::flag_set("battlechatter_on_thread_waiting");
  wait 1.5;
  common_scripts\utility::flag_clear("battlechatter_on_thread_waiting");

  if(isDefined(var_0)) {
    set_battlechatter_variable(var_0, 1);
    var_1 = getaiarray(var_0);
  } else {
    foreach(var_0 in anim.teams)
    set_battlechatter_variable(var_0, 1);

    var_1 = getaiarray();
  }

  for(var_4 = 0; var_4 < var_1.size; var_4++)
    var_1[var_4] set_battlechatter(1);
}

set_battlechatter(var_0) {
  if(!anim.chatinitialized) {
    return;
  }
  if(self.type == "dog") {
    return;
  }
  if(var_0) {
    if(isDefined(self.script_bcdialog) && !self.script_bcdialog)
      self.battlechatter = 0;
    else
      self.battlechatter = 1;
  } else {
    self.battlechatter = 0;

    if(isDefined(self.isspeaking) && self.isspeaking)
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
    common_scripts\utility::waitframe();
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
  if(isDefined(self.isspeaking) && self.isspeaking) {
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
  if(!isDefined(var_1))
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

get_obj_origin(var_0) {
  var_1 = getEntArray("objective", "targetname");

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    if(var_1[var_2].script_noteworthy == var_0)
      return var_1[var_2].origin;
  }
}

get_obj_event(var_0) {
  var_1 = getEntArray("objective_event", "targetname");

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
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

  for(;;) {
    var_0 = anglesToForward(self.angles);
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

  if(isDefined(self.script_linkto)) {
    var_1 = common_scripts\utility::get_links();

    for(var_2 = 0; var_2 < var_1.size; var_2++) {
      var_3 = common_scripts\utility::getstruct(var_1[var_2], "script_linkname");

      if(isDefined(var_3))
        var_0[var_0.size] = var_3;
    }
  }

  return var_0;
}

get_last_ent_in_chain(var_0) {
  var_1 = self;

  while(isDefined(var_1.target)) {
    wait 0.05;

    if(isDefined(var_1.target)) {
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

  if(isDefined(var_0))
    thread timeout(var_0);

  self setgoalentity(var_1);

  if(!isDefined(self.oldgoalradius))
    self.oldgoalradius = self.goalradius;

  self.goalradius = 300;
  common_scripts\utility::waittill_any("goal", "timeout");

  if(isDefined(self.oldgoalradius)) {
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
  if(isDefined(self.set_forcedgoal)) {
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
  if(!isDefined(self.set_forcedgoal)) {
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

  for(var_3 = 0; var_3 < var_2.size; var_3++) {
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

  for(var_3 = 0; var_3 < var_0.size; var_3++) {
    if(var_0[var_3] != var_1)
      var_2[var_2.size] = var_0[var_3];
  }

  return var_2;
}

array_remove_index(var_0, var_1) {
  for(var_2 = 0; var_2 < var_0.size - 1; var_2++) {
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
  var_0 = spawnStruct();
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
  if(isDefined(var_0.array[var_0.lastindex - 1])) {
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
    if(!isDefined(var_3)) {
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
  for(var_2 = 0; var_2 < var_1; var_2++)
    var_0 maps\_utility_code::structarray_swap(var_0.array[var_2], var_0.array[randomint(var_0.lastindex)]);
}

get_use_key() {
  if(level.console)
    return " + usereload";
  else
    return " + activate";
}

custom_battlechatter(var_0) {
  return animscripts\battlechatter_ai::custom_battlechatter_internal(var_0);
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

  if(isDefined(var_1))
    var_3 = var_1;
  else
    var_3 = level.explosiveplanttime;

  var_2 setclock(var_3, var_0, "hudStopwatch", 64, 64);
  return var_2;
}

objective_is_active(var_0) {
  var_1 = 0;

  for(var_2 = 0; var_2 < level.active_objective.size; var_2++) {
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

  for(var_2 = 0; var_2 < level.inactive_objective.size; var_2++) {
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

  for(var_2 = 0; var_2 < level.active_objective.size; var_2++) {
    if(level.active_objective[var_2] == var_0) {
      continue;
    }
    var_1[var_1.size] = level.active_objective[var_2];
  }

  level.active_objective = var_1;
  var_3 = 0;

  for(var_2 = 0; var_2 < level.inactive_objective.size; var_2++) {
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

  for(var_2 = 0; var_2 < level.inactive_objective.size; var_2++) {
    if(level.inactive_objective[var_2] == var_0) {
      continue;
    }
    var_1[var_1.size] = level.inactive_objective[var_2];
  }

  level.inactive_objective = var_1;
  var_3 = 0;

  for(var_2 = 0; var_2 < level.active_objective.size; var_2++) {
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
  if(isDefined(level.nextmission)) {
    return;
  }
  level.missionfailed = 1;
  common_scripts\utility::flag_set("missionfailed");

  if(arcademode()) {
    return;
  }
  if(getdvar("failure_disabled") == "1") {
    return;
  }
  if(isDefined(level.mission_fail_func)) {
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
  if(isDefined(self.script_delay)) {
    wait(self.script_delay);
    return 1;
  } else if(isDefined(self.script_delay_min) && isDefined(self.script_delay_max)) {
    wait(randomfloatrange(self.script_delay_min, self.script_delay_max));
    return 1;
  }

  return 0;
}

script_wait() {
  var_0 = gettime();

  if(isDefined(self.script_wait)) {
    wait(self.script_wait);

    if(isDefined(self.script_wait_add))
      self.script_wait = self.script_wait + self.script_wait_add;
  } else if(isDefined(self.script_wait_min) && isDefined(self.script_wait_max)) {
    wait(randomfloatrange(self.script_wait_min, self.script_wait_max));

    if(isDefined(self.script_wait_add)) {
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

  for(var_4 = 0; var_4 < var_2.size; var_4++) {
    var_5 = var_2[var_4];

    if(!isDefined(var_5.script_forcecolor)) {
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

  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    var_3 = var_0[var_2];

    if(!isDefined(var_3.script_forcecolor)) {
      continue;
    }
    var_1[var_1.size] = var_3;
  }

  return var_1;
}

get_all_target_ents(var_0) {
  if(!isDefined(var_0))
    var_0 = self.target;

  var_1 = [];
  var_2 = getEntArray(var_0, "targetname");
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
  if(isDefined(self.script_forcecolor)) {
    return;
  }
  if(!isDefined(self.old_forcecolor)) {
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
  if(isDefined(self.new_force_color_being_set)) {
    self endon("death");
    self waittill("done_setting_new_color");
  }

  self clearfixednodesafevolume();

  if(!isDefined(self.script_forcecolor)) {
    return;
  }
  self.old_forcecolor = self.script_forcecolor;
  level.arrays_of_colorforced_ai[maps\_colors::get_team()][self.script_forcecolor] = common_scripts\utility::array_remove(level.arrays_of_colorforced_ai[maps\_colors::get_team()][self.script_forcecolor], self);
  maps\_colors::left_color_node();
  self.script_forcecolor = undefined;
  self.currentcolorcode = undefined;
}

clear_force_color() {
  disable_ai_color();
}

check_force_color(var_0) {
  var_1 = level.colorchecklist[tolower(var_0)];

  if(isDefined(self.script_forcecolor) && var_1 == self.script_forcecolor)
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
  var_2 = maps\_colors::get_team();

  if(isDefined(self.script_forcecolor))
    level.arrays_of_colorforced_ai[var_2][self.script_forcecolor] = common_scripts\utility::array_remove(level.arrays_of_colorforced_ai[var_2][self.script_forcecolor], self);

  self.script_forcecolor = var_1;
  level.arrays_of_colorforced_ai[var_2][var_1] = array_removedead(level.arrays_of_colorforced_ai[var_2][var_1]);
  level.arrays_of_colorforced_ai[var_2][self.script_forcecolor] = common_scripts\utility::array_add(level.arrays_of_colorforced_ai[var_2][self.script_forcecolor], self);
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

  for(var_5 = 0; var_5 < var_2.size; var_5++) {
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
    else {}

    var_4[var_6] = var_2[var_5];
    var_3[var_3.size] = var_6;
  }

  for(var_5 = 0; var_5 < var_2.size; var_5++) {
    level.arrays_of_colorcoded_spawners[var_1][var_2[var_5]] = common_scripts\utility::array_removeundefined(level.arrays_of_colorcoded_spawners[var_1][var_2[var_5]]);

    for(var_7 = 0; var_7 < level.arrays_of_colorcoded_spawners[var_1][var_2[var_5]].size; var_7++)
      level.arrays_of_colorcoded_spawners[var_1][var_2[var_5]][var_7].currentcolorcode = var_2[var_5];
  }

  for(var_5 = 0; var_5 < var_3.size; var_5++) {
    level.arrays_of_colorforced_ai[var_1][var_3[var_5]] = array_removedead(level.arrays_of_colorforced_ai[var_1][var_3[var_5]]);
    level.currentcolorforced[var_1][var_3[var_5]] = var_4[var_3[var_5]];
  }

  for(var_5 = 0; var_5 < var_2.size; var_5++)
    thread maps\_colors::issue_color_order_to_ai(var_2[var_5], var_3[var_5], var_1);
}

flashrumbleloop(var_0) {
  var_1 = gettime() + var_0 * 1000;

  while(gettime() < var_1) {
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

    if(isDefined(self.maxflashedseconds) && var_11 > self.maxflashedseconds)
      var_11 = self.maxflashedseconds;

    self.flashingteam = var_4;
    self notify("flashed");
    self.flashendtime = gettime() + var_11 * 1000;
    self shellshock("flashbang", var_11);
    common_scripts\utility::flag_set("player_flashed");

    if(var_1 * var_2 > 0.5)
      thread flashmonitorenablehealthshield(var_11);

    wait(var_5[var_12]);
  }

  thread maps\_utility_code::unflash_flag(0.05);
}

flashmonitor() {
  self endon("death");

  for(;;) {
    self waittill("flashbang", var_0, var_1, var_2, var_3, var_4);

    if("1" == getdvar("noflash")) {
      continue;
    }
    if(is_player_down(self)) {
      continue;
    }
    if(isDefined(self.threw_ninebang)) {
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
    if(isDefined(self.maxflashedseconds) && var_9 > self.maxflashedseconds)
      var_9 = self.maxflashedseconds;

    self.flashingteam = var_4;
    self notify("flashed");
    self.flashendtime = gettime() + var_9 * 1000;
    self shellshock("flashbang", var_9);
    common_scripts\utility::flag_set("player_flashed");
    thread maps\_utility_code::unflash_flag(var_9);

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

  for(var_3 = 0; var_3 < var_2.size; var_3++) {
    if(distancesquared(var_2[var_3].origin, self.origin) < 122500) {
      var_4 = var_0 + randomfloatrange(-1000, 1500);

      if(var_4 > 4.5)
        var_4 = 4.5;
      else if(var_4 < 0.25) {
        continue;
      }
      var_5 = gettime() + var_4 * 1000;

      if(!isDefined(var_2[var_3].flashendtime) || var_2[var_3].flashendtime < var_5) {
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

  if(isDefined(level.createfxexploders)) {
    var_1 = level.createfxexploders[var_0];

    if(isDefined(var_1)) {
      foreach(var_3 in var_1)
      var_3 common_scripts\utility::pauseeffect();

      return;
    }
  } else {
    foreach(var_6 in level.createfxent) {
      if(!isDefined(var_6.v["exploder"])) {
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

  if(isDefined(level.createfxexploders)) {
    var_1 = level.createfxexploders[var_0];

    if(isDefined(var_1)) {
      foreach(var_3 in var_1)
      var_3 restarteffect();

      return;
    }
  } else {
    foreach(var_6 in level.createfxent) {
      if(!isDefined(var_6.v["exploder"])) {
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

  if(isDefined(level.createfxbyfxid)) {
    var_2 = level.createfxbyfxid[var_0];

    if(isDefined(var_2))
      var_1 = var_2;
  } else {
    for(var_3 = 0; var_3 < level.createfxent.size; var_3++) {
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

    for(var_5 = 0; var_5 < var_3.size; var_5++)
      var_4[var_3[var_5] getthreatbiasgroup()] = 1;

    var_6 = getarraykeys(var_4);

    for(var_5 = 0; var_5 < var_6.size; var_5++)
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
  return bulletTrace(var_0, var_0 + (0, 0, -100000), 0, self)["position"];
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

  if(!isDefined(level.start_description))
    level.start_description = [];

  level.start_description[var_0] = add_start_construct(var_0, var_1, var_2, var_3, var_4, var_5);
}

add_start(var_0, var_1, var_2, var_3, var_4, var_5) {
  add_start_assert();
  var_0 = tolower(var_0);

  if(isDefined(level.start_description) && isDefined(level.start_description[var_0]))
    var_7 = level.start_description[var_0];
  else
    var_7 = add_start_construct(var_0, var_1, var_2, var_3, var_4, var_5);

  if(!isDefined(var_1)) {
    if(!isDefined(level.start_description)) {} else if(!issubstr(var_0, "no_game")) {
      if(!isDefined(level.start_description[var_0]))
        return;
    }
  }

  level.start_functions[level.start_functions.size] = var_7;
  level.start_arrays[var_0] = var_7;
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
  var_6["transient"] = var_4;
  var_6["catchup_function"] = var_5;
  return var_6;
}

add_start_assert() {
  if(!isDefined(level.start_functions))
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
  var_5 = anglesToForward((0, var_1[1], 0));
  return vectordot(var_5, var_4) >= var_3;
}

get_dot(var_0, var_1, var_2) {
  var_3 = vectornormalize(var_2 - var_0);
  var_4 = anglesToForward(var_1);
  var_5 = vectordot(var_4, var_3);
  return var_5;
}

within_fov_of_players(var_0, var_1) {
  var_2 = undefined;

  for(var_3 = 0; var_3 < level.players.size; var_3++) {
    var_4 = level.players[var_3] getEye();
    var_2 = common_scripts\utility::within_fov(var_4, level.players[var_3] getplayerangles(), var_0, var_1);

    if(!var_2)
      return 0;
  }

  return 1;
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
  bcs_scripted_dialogue_start();
  maps\_anim::anim_single_queue(self, var_0);
}

generic_dialogue_queue(var_0, var_1) {
  bcs_scripted_dialogue_start();
  maps\_anim::anim_generic_queue(self, var_0, undefined, undefined, var_1);
}

radio_dialogue(var_0, var_1) {
  if(!isDefined(level.player_radio_emitter)) {
    var_2 = spawn("script_origin", (0, 0, 0));
    var_2 linkto(level.player, "", (0, 0, 0), (0, 0, 0));
    level.player_radio_emitter = var_2;
  }

  bcs_scripted_dialogue_start();
  var_3 = 0;

  if(!isDefined(var_1))
    var_3 = level.player_radio_emitter function_stack(::play_sound_on_tag, level.scr_radio[var_0], undefined, 1);
  else
    var_3 = level.player_radio_emitter function_stack_timeout(var_1, ::play_sound_on_tag, level.scr_radio[var_0], undefined, 1);

  return var_3;
}

radio_dialogue_overlap(var_0) {
  level.player_radio_emitter play_sound_on_tag(level.scr_radio[var_0], undefined, 1);
}

radio_dialogue_stop() {
  if(!isDefined(level.player_radio_emitter)) {
    return;
  }
  level.player_radio_emitter delete();
}

radio_dialogue_clear_stack() {
  if(!isDefined(level.player_radio_emitter)) {
    return;
  }
  level.player_radio_emitter function_stack_clear();
}

radio_dialogue_interupt(var_0) {
  if(!isDefined(level.player_radio_emitter)) {
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
  maps\_utility_code::add_to_radio(var_0);
  radio_dialogue(var_0, var_1);
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

radio_dialogue_queue(var_0) {
  radio_dialogue(var_0);
}

hint_create(var_0, var_1, var_2) {
  var_3 = spawnStruct();

  if(isDefined(var_1) && var_1 == 1)
    var_3.bg = newhudelem();

  var_3.elm = newhudelem();
  var_3 hint_position_internal(var_2);
  var_3.elm settext(var_0);
  return var_3;
}

hint_delete() {
  self notify("death");

  if(isDefined(self.elm))
    self.elm destroy();

  if(isDefined(self.bg))
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

  if(!isDefined(self.bg)) {
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

  if(!isDefined(var_0))
    var_0 = 0.5;

  self.bg.alpha = var_0;
}

string(var_0) {
  return "" + var_0;
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

  for(var_3 = 0; var_3 < level.spawn_funcs[var_0].size; var_3++) {
    if(level.spawn_funcs[var_0][var_3]["function"] != var_1)
      var_2[var_2.size] = level.spawn_funcs[var_0][var_3];
  }

  level.spawn_funcs[var_0] = var_2;
}

exists_global_spawn_function(var_0, var_1) {
  if(!isDefined(level.spawn_funcs))
    return 0;

  for(var_2 = 0; var_2 < level.spawn_funcs[var_0].size; var_2++) {
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
  for(var_1 = 0; var_1 < var_0.size; var_1++)
    var_0[var_1] delete();
}

array_kill(var_0) {
  for(var_1 = 0; var_1 < var_0.size; var_1++)
    var_0[var_1] kill();
}

ignore_triggers(var_0) {
  self endon("death");
  self.ignoretriggers = 1;

  if(isDefined(var_0))
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
  return isDefined(level.hero_list[get_ai_number()]);
}

get_ai_number() {
  if(!isDefined(self.unique_id))
    set_ai_number();

  return self.unique_id;
}

set_ai_number() {
  self.unique_id = "ai" + level.ai_number;
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

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    if(var_1[var_2] is_hero())
      var_0[var_0.size] = var_1[var_2];
  }

  return var_0;
}

set_team_pacifist(var_0, var_1) {
  var_2 = getaiarray(var_0);

  for(var_3 = 0; var_3 < var_2.size; var_3++)
    var_2[var_3].pacifist = var_1;
}

replace_on_death() {
  maps\_colors::colornode_replace_on_death();
}

spawn_reinforcement(var_0, var_1) {
  maps\_colors::colornode_spawn_reinforcement(var_0, var_1);
}

clear_promotion_order() {
  level.current_color_order = [];
}

set_promotion_order(var_0, var_1) {
  if(!isDefined(level.current_color_order))
    level.current_color_order = [];

  var_0 = shortencolor(var_0);
  var_1 = shortencolor(var_1);
  level.current_color_order[var_0] = var_1;

  if(!isDefined(level.current_color_order[var_1]))
    set_empty_promotion_order(var_1);
}

set_empty_promotion_order(var_0) {
  if(!isDefined(level.current_color_order))
    level.current_color_order = [];

  level.current_color_order[var_0] = "none";
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

  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    if(var_0[var_2] is_hero()) {
      continue;
    }
    var_1[var_1.size] = var_0[var_2];
  }

  return var_1;
}

remove_color_from_array(var_0, var_1) {
  var_2 = [];

  for(var_3 = 0; var_3 < var_0.size; var_3++) {
    var_4 = var_0[var_3];

    if(!isDefined(var_4.script_forcecolor)) {
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

  for(var_3 = 0; var_3 < var_0.size; var_3++) {
    var_4 = var_0[var_3];

    if(!isDefined(var_4.script_noteworthy)) {
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

  if(!isDefined(var_1))
    var_3 = level.player.origin;
  else
    var_3 = var_1;

  return common_scripts\utility::getclosest(var_3, var_2);
}

remove_without_classname(var_0, var_1) {
  var_2 = [];

  for(var_3 = 0; var_3 < var_0.size; var_3++) {
    if(!issubstr(var_0[var_3].classname, var_1)) {
      continue;
    }
    var_2[var_2.size] = var_0[var_3];
  }

  return var_2;
}

remove_without_model(var_0, var_1) {
  var_2 = [];

  for(var_3 = 0; var_3 < var_0.size; var_3++) {
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

  if(!isDefined(var_2))
    var_4 = level.player.origin;
  else
    var_4 = var_2;

  var_3 = remove_without_classname(var_3, var_1);
  return common_scripts\utility::getclosest(var_4, var_3);
}

promote_nearest_friendly(var_0, var_1) {
  for(;;) {
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
  for(;;) {
    var_2 = get_closest_colored_friendly(var_0);

    if(!isalive(var_2)) {
      return;
    }
    var_2 set_force_color(var_1);
    return;
  }
}

instantly_promote_nearest_friendly_with_classname(var_0, var_1, var_2) {
  for(;;) {
    var_3 = get_closest_colored_friendly_with_classname(var_0, var_2);

    if(!isalive(var_3)) {
      return;
    }
    var_3 set_force_color(var_1);
    return;
  }
}

promote_nearest_friendly_with_classname(var_0, var_1, var_2) {
  for(;;) {
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

  for(var_5 = 0; var_5 < var_0.size; var_5++) {
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

  for(var_4 = 0; var_4 < var_0.size; var_4++) {
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
  var_2 = spawnStruct();
  var_3 = [];
  var_3 = common_scripts\utility::array_combine(var_3, getEntArray(var_0, "targetname"));
  var_3 = common_scripts\utility::array_combine(var_3, getEntArray(var_1, "targetname"));

  for(var_4 = 0; var_4 < var_3.size; var_4++)
    var_2 thread maps\_utility_code::ent_waits_for_trigger(var_3[var_4]);

  var_2 waittill("done");
}

dronespawn_bodyonly(var_0) {
  var_1 = maps\_spawner::spawner_dronespawn(var_0);
  return var_1;
}

dronespawn(var_0) {
  if(!isDefined(var_0))
    var_0 = self;

  var_1 = maps\_spawner::spawner_dronespawn(var_0);
  var_1[[level.drone_spawn_func]]();
  var_1.spawn_funcs = var_0.spawn_functions;
  var_1 thread maps\_spawner::run_spawn_functions();
  return var_1;
}

makerealai(var_0) {
  return maps\_spawner::spawner_makerealai(var_0);
}

get_trigger_flag() {
  if(isDefined(self.script_flag))
    return self.script_flag;

  if(isDefined(self.script_noteworthy))
    return self.script_noteworthy;
}

set_default_pathenemy_settings() {
  self.pathenemylookahead = 192;
  self.pathenemyfightdist = 192;
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
  if(!isDefined(var_0))
    self.cqbenabled = 1;

  self.cqbwalking = 1;
  self.turnrate = 0.2;
  level thread animscripts\cqb::findcqbpointsofinterest();
}

disable_cqbwalk() {
  if(self.type == "dog") {
    return;
  }
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
  if(!isDefined(var_0))
    self.cqb_target = undefined;
  else {
    self.cqb_target = var_0;

    if(!isDefined(var_0.origin))
      return;
  }
}

set_force_cover(var_0) {
  if(isDefined(var_0) && var_0)
    self.forcesuppression = 1;
  else
    self.forcesuppression = undefined;
}

do_in_order(var_0, var_1, var_2, var_3) {
  if(isDefined(var_1))
    [[var_0]](var_1);
  else
    [[var_0]]();

  if(isDefined(var_3))
    [[var_2]](var_3);
  else
    [[var_2]]();
}

send_notify(var_0, var_1) {
  if(isDefined(var_1))
    self notify(var_0, var_1);
  else
    self notify(var_0);
}

waittill_match_or_timeout(var_0, var_1, var_2) {
  var_3 = spawnStruct();
  var_3 endon("complete");
  var_3 delaythread(var_2, ::send_notify, "complete");
  self waittillmatch(var_0, var_1);
}

deleteent(var_0) {
  var_0 notify("deleted");
  var_0 delete();
}

first_touch(var_0) {
  if(!isDefined(self.touched))
    self.touched = [];

  if(isDefined(self.touched[var_0.unique_id]))
    return 0;

  self.touched[var_0.unique_id] = 1;
  return 1;
}

getanim(var_0) {
  return level.scr_anim[self.animname][var_0];
}

hasanim(var_0) {
  return isDefined(level.scr_anim[self.animname][var_0]);
}

getanim_from_animname(var_0, var_1) {
  return level.scr_anim[var_1][var_0];
}

getanim_generic(var_0) {
  return level.scr_anim["generic"][var_0];
}

add_hint_string(var_0, var_1, var_2) {
  if(!isDefined(level.trigger_hint_string)) {
    level.trigger_hint_string = [];
    level.trigger_hint_func = [];
  }

  level.trigger_hint_string[var_0] = var_1;
  precachestring(var_1);

  if(isDefined(var_2))
    level.trigger_hint_func[var_0] = var_2;
}

show_hint(var_0) {
  thread maps\_utility_code::showhintprint_struct(var_0);
}

hide_hint(var_0) {
  var_0.timeout = 1;
}

fire_radius(var_0, var_1) {
  var_2 = spawn("trigger_radius", var_0, 0, var_1, 48);

  for(;;) {
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

  for(var_3 = 0; var_3 < var_2.size; var_3++)
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

  for(;;) {
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

set_run_anim(var_0, var_1) {
  if(isDefined(var_1))
    self.alwaysrunforward = var_1;
  else
    self.alwaysrunforward = 1;

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

  if(isDefined(var_2))
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

set_generic_run_anim(var_0, var_1) {
  set_generic_run_anim_array(var_0, undefined, var_1);
}

clear_generic_run_anim() {
  self notify("movemode");
  enable_turnanims();
  self.run_overrideanim = undefined;
  self.walk_overrideanim = undefined;
}

set_generic_run_anim_array(var_0, var_1, var_2) {
  self notify("movemode");

  if(!isDefined(var_2) || var_2)
    self.alwaysrunforward = 1;
  else
    self.alwaysrunforward = undefined;

  disable_turnanims();
  self.run_overrideanim = level.scr_anim["generic"][var_0];
  self.walk_overrideanim = self.run_overrideanim;

  if(isDefined(var_1)) {
    self.run_override_weights = level.scr_anim["generic"][var_1];
    self.walk_override_weights = self.run_override_weights;
  } else {
    self.run_override_weights = undefined;
    self.walk_override_weights = undefined;
  }
}

set_run_anim_array(var_0, var_1, var_2) {
  self notify("movemode");

  if(!isDefined(var_2) || var_2)
    self.alwaysrunforward = 1;
  else
    self.alwaysrunforward = undefined;

  disable_turnanims();
  self.run_overrideanim = level.scr_anim[self.animname][var_0];
  self.walk_overrideanim = self.run_overrideanim;

  if(isDefined(var_1)) {
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

  if(!isDefined(self.casual_killer))
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

  if(!isDefined(var_0) || !isDefined(var_1) || !isDefined(var_2)) {
    var_0 = 400;
    var_1 = 256;
    var_2 = (0, 0, 0.075);
  }

  var_3 = var_0 * var_0;
  var_4 = 3;
  var_5 = var_2;

  for(;;) {
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
  if(!isDefined(var_0))
    activate_trigger_process(var_2);
  else
    common_scripts\utility::array_thread(getEntArray(var_0, var_1), ::activate_trigger_process, var_2);
}

activate_trigger_process(var_0) {
  if(isDefined(self.script_color_allies)) {
    self.activated_color_trigger = 1;
    maps\_colors::activate_color_trigger("allies");
  }

  if(isDefined(self.script_color_axis)) {
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

  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    var_3 = var_0[var_2];

    if(var_3 has_color())
      var_1[var_1.size] = var_3;
  }

  return var_1;
}

has_color() {
  if(maps\_colors::get_team() == "axis")
    return isDefined(self.script_color_axis) || isDefined(self.script_forcecolor);

  return isDefined(self.script_color_allies) || isDefined(self.script_forcecolor);
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
  return var_0;
}

notify_delay(var_0, var_1) {
  self endon("death");

  if(var_1 > 0)
    wait(var_1);

  if(!isDefined(self)) {
    return;
  }
  self notify(var_0);
}

gun_remove() {
  if(isai(self))
    animscripts\shared::placeweaponon(self.weapon, "none");
  else
    self detach(getweaponmodel(self.weapon), "tag_weapon_right");
}

gun_recall() {
  if(isai(self))
    animscripts\shared::placeweaponon(self.weapon, "right");
  else
    self attach(getweaponmodel(self.weapon), "tag_weapon_right");
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

lerp_player_view_to_tag(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
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

  if(isDefined(var_8) && var_8)
    var_9 playerlinkto(var_10, "", var_3, var_4, var_5, var_6, var_7, var_8);
  else if(isDefined(var_4))
    var_9 playerlinkto(var_10, "", var_3, var_4, var_5, var_6, var_7);
  else if(isDefined(var_3))
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

  if(isDefined(var_8))
    var_9 playerlinktodelta(var_10, "", var_3, var_4, var_5, var_6, var_7, var_8);
  else if(isDefined(var_4))
    var_9 playerlinktodelta(var_10, "", var_3, var_4, var_5, var_6, var_7);
  else if(isDefined(var_3))
    var_9 playerlinktodelta(var_10, "", var_3);
  else
    var_9 playerlinktodelta(var_10);

  var_10 moveto(var_0, var_2, var_2 * 0.25);
  var_10 rotateto(var_1, var_2, var_2 * 0.25);
  wait(var_2);
  var_10 delete();
}

player_moves(var_0) {
  var_1 = level.player.origin;

  for(;;) {
    if(distance(var_1, level.player.origin) > var_0) {
      break;
    }

    wait 0.05;
  }
}

waittill_either_function(var_0, var_1, var_2, var_3) {
  var_4 = spawnStruct();
  thread maps\_utility_code::waittill_either_function_internal(var_4, var_0, var_1);
  thread maps\_utility_code::waittill_either_function_internal(var_4, var_2, var_3);
  var_4 waittill("done");
}

waittill_msg(var_0) {
  self waittill(var_0);
}

display_hint(var_0, var_1, var_2, var_3) {
  var_4 = get_player_from_self();

  if(isDefined(level.trigger_hint_func[var_0])) {
    if(var_4[[level.trigger_hint_func[var_0]]]()) {
      return;
    }
    var_4 thread maps\_utility_code::hintprint(level.trigger_hint_string[var_0], level.trigger_hint_func[var_0], var_1, var_2, var_3, 30);
  } else
    var_4 thread maps\_utility_code::hintprint(level.trigger_hint_string[var_0], undefined, undefined, undefined, undefined, 30);
}

display_hint_timeout(var_0, var_1, var_2, var_3, var_4) {
  var_5 = get_player_from_self();

  if(var_5[[level.trigger_hint_func[var_0]]]()) {
    return;
  }
  var_5 thread maps\_utility_code::hintprint(level.trigger_hint_string[var_0], level.trigger_hint_func[var_0], var_2, var_3, var_4, var_1);
}

display_hint_timeout_mintime(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = get_player_from_self();

  if(var_6[[level.trigger_hint_func[var_0]]]()) {
    return;
  }
  var_6 thread maps\_utility_code::hintprint(level.trigger_hint_string[var_0], level.trigger_hint_func[var_0], var_3, var_4, var_5, var_1, var_2);
}

display_hint_stick(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(!isDefined(var_6))
    var_6 = 0;

  var_10 = maps\_utility_code::hint_stick_get_updated(var_0, var_1, var_2, var_3, var_4, var_5, var_6);
  thread display_hint(var_10, var_7, var_8, var_9);
  thread maps\_utility_code::hint_stick_update(var_0, var_1, var_2, var_3, var_4, var_5, var_6);
}

display_hint_stick_timeout(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  if(!isDefined(var_7))
    var_7 = 0;

  var_11 = maps\_utility_code::hint_stick_get_updated(var_0, var_2, var_3, var_4, var_5, var_6, var_7);
  thread display_hint_timeout(var_11, var_1, var_8, var_9, var_10);
  thread maps\_utility_code::hint_stick_update(var_0, var_2, var_3, var_4, var_5, var_6, var_7);
}

display_hint_stick_timeout_mintime(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11) {
  if(!isDefined(var_8))
    var_8 = 0;

  var_12 = maps\_utility_code::hint_stick_get_updated(var_0, var_3, var_4, var_5, var_6, var_7, var_8);
  thread display_hint_timeout_mintime(var_12, var_1, var_2, var_9, var_10, var_11);
  thread maps\_utility_code::hint_stick_update(var_0, var_3, var_4, var_5, var_6, var_7, var_8);
}

check_hint_condition(var_0, var_1, var_2, var_3) {
  if(isDefined(var_3))
    return [[level.trigger_hint_func[var_0]]](var_1, var_2, var_3);

  if(isDefined(var_2))
    return [[level.trigger_hint_func[var_0]]](var_1, var_2);

  if(isDefined(var_1))
    return [[level.trigger_hint_func[var_0]]](var_1);

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
  if(isDefined(self.script_delay_spawn)) {
    self endon("death");
    wait(self.script_delay_spawn);
  }

  var_2 = undefined;
  var_3 = isDefined(self.script_stealth) && common_scripts\utility::flag("_stealth_enabled") && !common_scripts\utility::flag("_stealth_spotted");

  if(isDefined(self.script_forcespawn) || isDefined(var_0)) {
    if(!isDefined(self.script_drone))
      var_2 = self stalingradspawn(var_3);
    else
      var_2 = dronespawn(self);
  } else if(!isDefined(self.script_drone))
    var_2 = self dospawn(var_3);
  else
    var_2 = dronespawn(self);

  if(isDefined(var_1) && var_1 && isalive(var_2))
    var_2 magic_bullet_shield();

  if(!isDefined(self.script_drone))
    spawn_failed(var_2);

  if(isDefined(self.script_spawn_once))
    self delete();

  return var_2;
}

function_stack(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = spawnStruct();
  var_6 thread maps\_utility_code::function_stack_proc(self, var_0, var_1, var_2, var_3, var_4, var_5);
  return maps\_utility_code::function_stack_wait_finish(var_6);
}

function_stack_timeout(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = spawnStruct();
  var_7 thread maps\_utility_code::function_stack_proc(self, var_1, var_2, var_3, var_4, var_5, var_6);

  if(isDefined(var_7.function_stack_func_begun) || var_7 common_scripts\utility::waittill_any_timeout(var_0, "function_stack_func_begun") != "timeout")
    return maps\_utility_code::function_stack_wait_finish(var_7);
  else {
    var_7 notify("death");
    return 0;
  }
}

function_stack_clear() {
  var_0 = [];

  if(isDefined(self.function_stack[0]) && isDefined(self.function_stack[0].function_stack_func_begun))
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
  if(isDefined(self.geo_off)) {
    return;
  }
  self.realorigin = self getorigin();
  self moveto(self.realorigin + (0, 0, -10000), 0.2);
  self.geo_off = 1;
}

geo_on() {
  if(!isDefined(self.geo_off)) {
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

  if(isDefined(var_1))
    var_4 = !var_1;

  if(isDefined(var_2))
    level endon(var_2);

  if(isDefined(var_3))
    level waittill(var_3);

  var_5 = "signal_" + var_0;

  if(self.a.pose == "crouch")
    var_5 = var_5 + "_crouch";
  else if(self.script == "cover_right" || self.script == "cover_multi" && self.cover.state == "right")
    var_5 = var_5 + "_coverR";
  else if(animscripts\utility::iscqbwalking())
    var_5 = var_5 + "_cqb";

  if(var_4)
    self setanimrestart(getgenericanim(var_5), 1, 0, 1.1);
  else
    maps\_anim::anim_generic(self, var_5);
}

array_spawn(var_0, var_1, var_2) {
  if(!isDefined(var_2))
    var_2 = 0;

  var_3 = [];

  foreach(var_5 in var_0) {
    var_5.count = 1;

    if(getsubstr(var_5.classname, 7, 10) == "veh") {
      var_6 = var_5 spawn_vehicle();

      if(isDefined(var_6.target) && !isDefined(var_6.script_moveoverride))
        var_6 thread maps\_vehicle::gopath();

      var_3[var_3.size] = var_6;
      continue;
    }

    var_6 = var_5 spawn_ai(var_1);

    if(!var_2) {}

    var_3[var_3.size] = var_6;
  }

  if(!var_2) {}

  return var_3;
}

array_spawn_targetname(var_0, var_1, var_2, var_3) {
  var_4 = getEntArray(var_0, "targetname");

  if(isDefined(level.spawn_pool_enabled)) {
    var_5 = common_scripts\utility::getstructarray(var_0, "targetname");

    if(isDefined(var_3) && var_3)
      deletestructarray_ref(var_5);

    var_6 = maps\_spawner::get_pool_spawners_from_structarray(var_5);
    var_4 = common_scripts\utility::array_combine(var_4, var_6);
  }

  return array_spawn(var_4, var_1, var_2);
}

array_spawn_noteworthy(var_0, var_1, var_2, var_3) {
  var_4 = getEntArray(var_0, "script_noteworthy");

  if(isDefined(level.spawn_pool_enabled)) {
    var_5 = common_scripts\utility::getstructarray(var_0, "script_noteworthy");

    if(isDefined(var_3) && var_3)
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
  if(!isDefined(level.dialogue_huds))
    level.dialogue_huds = [];

  var_3 = 0;

  for(;;) {
    if(!isDefined(level.dialogue_huds[var_3])) {
      break;
    }

    var_3++;
  }

  var_4 = "^3";

  if(isDefined(var_2)) {
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

  for(var_7 = 0; var_7 < var_6; var_7++) {
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
  if(!isDefined(level.console))
    level.console = getdvar("consoleGame") == "true";
  else {}

  if(!isDefined(level.xenon))
    level.xenon = getdvar("xenonGame") == "true";
  else {}

  if(!isDefined(level.ps3))
    level.ps3 = getdvar("ps3Game") == "true";
  else {}

  if(!isDefined(level.xb3))
    level.xb3 = getdvar("xb3Game") == "true";
  else {}

  if(!isDefined(level.ps4))
    level.ps4 = getdvar("ps4Game") == "true";
  else {}
}

is_gen4() {
  if(level.xb3 || level.ps4 || !level.console)
    return 1;
  else
    return 0;
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
  wait 1.75;

  if(isDefined(var_0))
    self playSound(var_0);
  else
    self playSound("door_wood_slow_open");

  self rotateto(self.angles + (0, 70, 0), 2, 0.5, 0);
  self connectpaths();
  self waittill("rotatedone");
  self rotateto(self.angles + (0, 40, 0), 2, 0, 2);
}

palm_style_door_open(var_0) {
  wait 1.35;

  if(isDefined(var_0))
    self playSound(var_0);
  else
    self playSound("door_wood_slow_open");

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

  for(var_6 = 0; var_6 < var_3; var_6++) {
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

disable_oneshotfx_with_noteworthy(var_0) {
  var_1 = getarraykeys(level._global_fx_ents[var_0]);

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    level._global_fx_ents[var_0][var_1[var_2]].looper delete();
    level._global_fx_ents[var_0][var_1[var_2]] = undefined;
  }
}

array_wait(var_0, var_1, var_2) {
  var_3 = getarraykeys(var_0);
  var_4 = [];

  for(var_5 = 0; var_5 < var_3.size; var_5++)
    var_6 = var_3[var_5];

  for(var_5 = 0; var_5 < var_3.size; var_5++) {
    var_6 = var_3[var_5];
    var_4[var_6] = spawnStruct();
    var_4[var_6]._array_wait = 1;
    var_4[var_6] thread maps\_utility_code::array_waitlogic1(var_0[var_6], var_1, var_2);
  }

  for(var_5 = 0; var_5 < var_3.size; var_5++) {
    var_6 = var_3[var_5];

    if(isDefined(var_0[var_6]) && var_4[var_6]._array_wait)
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

disable_replace_on_death() {
  self.replace_on_death = undefined;
  self notify("_disable_reinforcement");
}

waittill_player_lookat(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(var_5))
    var_5 = level.player;

  var_6 = spawnStruct();

  if(isDefined(var_3))
    var_6 thread notify_delay("timeout", var_3);

  var_6 endon("timeout");

  if(!isDefined(var_0))
    var_0 = 0.92;

  if(!isDefined(var_1))
    var_1 = 0;

  var_7 = int(var_1 * 20);
  var_8 = var_7;
  self endon("death");
  var_9 = isai(self);
  var_10 = undefined;

  for(;;) {
    if(var_9)
      var_10 = self getEye();
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
  if(!isDefined(var_1))
    var_1 = 0.8;

  var_4 = get_player_from_self();
  var_5 = var_4 getEye();
  var_6 = vectortoangles(var_0 - var_5);
  var_7 = anglesToForward(var_6);
  var_8 = var_4 getplayerangles();
  var_9 = anglesToForward(var_8);
  var_10 = vectordot(var_7, var_9);

  if(var_10 < var_1)
    return 0;

  if(isDefined(var_2))
    return 1;

  var_11 = bulletTrace(var_0, var_5, 0, var_3);
  return var_11["fraction"] == 1;
}

either_player_looking_at(var_0, var_1, var_2, var_3) {
  for(var_4 = 0; var_4 < level.players.size; var_4++) {
    if(level.players[var_4] player_looking_at(var_0, var_1, var_2, var_3))
      return 1;
  }

  return 0;
}

player_can_see_ai(var_0, var_1) {
  var_2 = gettime();

  if(!isDefined(var_1))
    var_1 = 0;

  if(isDefined(var_0.playerseesmetime) && var_0.playerseesmetime + var_1 >= var_2)
    return var_0.playerseesme;

  var_0.playerseesmetime = var_2;

  if(!common_scripts\utility::within_fov(level.player.origin, level.player.angles, var_0.origin, 0.766)) {
    var_0.playerseesme = 0;
    return 0;
  }

  var_3 = level.player getEye();
  var_4 = var_0.origin;

  if(sighttracepassed(var_3, var_4, 1, level.player, var_0)) {
    var_0.playerseesme = 1;
    return 1;
  }

  var_5 = var_0 getEye();

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

  for(var_3 = 0; var_3 < level.players.size; var_3++) {
    if(distancesquared(var_1, level.players[var_3].origin) < var_2)
      return 1;
  }

  return 0;
}

ai_delete_when_out_of_sight(var_0, var_1) {
  if(!isDefined(var_0)) {
    return;
  }
  var_2 = 0.75;

  if(issplitscreen())
    var_2 = 0.65;

  while(var_0.size > 0) {
    wait 1;

    for(var_3 = 0; var_3 < var_0.size; var_3++) {
      if(!isDefined(var_0[var_3]) || !isalive(var_0[var_3])) {
        var_0 = common_scripts\utility::array_remove(var_0, var_0[var_3]);
        continue;
      }

      if(players_within_distance(var_1, var_0[var_3].origin)) {
        continue;
      }
      if(either_player_looking_at(var_0[var_3].origin + (0, 0, 48), var_2, 1)) {
        continue;
      }
      if(isDefined(var_0[var_3].magic_bullet_shield))
        var_0[var_3] stop_magic_bullet_shield();

      var_0[var_3] delete();
      var_0 = common_scripts\utility::array_remove(var_0, var_0[var_3]);
    }
  }
}

add_wait(var_0, var_1, var_2, var_3) {
  var_4 = spawnStruct();
  var_4.caller = self;
  var_4.func = var_0;
  var_4.parms = [];

  if(isDefined(var_1))
    var_4.parms[var_4.parms.size] = var_1;

  if(isDefined(var_2))
    var_4.parms[var_4.parms.size] = var_2;

  if(isDefined(var_3))
    var_4.parms[var_4.parms.size] = var_3;

  level.wait_any_func_array[level.wait_any_func_array.size] = var_4;
}

add_abort(var_0, var_1, var_2, var_3) {
  var_4 = spawnStruct();
  var_4.caller = self;
  var_4.func = var_0;
  var_4.parms = [];

  if(isDefined(var_1))
    var_4.parms[var_4.parms.size] = var_1;

  if(isDefined(var_2))
    var_4.parms[var_4.parms.size] = var_2;

  if(isDefined(var_3))
    var_4.parms[var_4.parms.size] = var_3;

  level.abort_wait_any_func_array[level.abort_wait_any_func_array.size] = var_4;
}

add_func(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = spawnStruct();
  var_6.caller = self;
  var_6.func = var_0;
  var_6.parms = [];

  if(isDefined(var_1))
    var_6.parms[var_6.parms.size] = var_1;

  if(isDefined(var_2))
    var_6.parms[var_6.parms.size] = var_2;

  if(isDefined(var_3))
    var_6.parms[var_6.parms.size] = var_3;

  if(isDefined(var_4))
    var_6.parms[var_6.parms.size] = var_4;

  if(isDefined(var_5))
    var_6.parms[var_6.parms.size] = var_5;

  level.run_func_after_wait_array[level.run_func_after_wait_array.size] = var_6;
}

add_call(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = spawnStruct();
  var_6.caller = self;
  var_6.func = var_0;
  var_6.parms = [];

  if(isDefined(var_1))
    var_6.parms[var_6.parms.size] = var_1;

  if(isDefined(var_2))
    var_6.parms[var_6.parms.size] = var_2;

  if(isDefined(var_3))
    var_6.parms[var_6.parms.size] = var_3;

  if(isDefined(var_4))
    var_6.parms[var_6.parms.size] = var_4;

  if(isDefined(var_5))
    var_6.parms[var_6.parms.size] = var_5;

  level.run_call_after_wait_array[level.run_call_after_wait_array.size] = var_6;
}

add_noself_call(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = spawnStruct();
  var_6.func = var_0;
  var_6.parms = [];

  if(isDefined(var_1))
    var_6.parms[var_6.parms.size] = var_1;

  if(isDefined(var_2))
    var_6.parms[var_6.parms.size] = var_2;

  if(isDefined(var_3))
    var_6.parms[var_6.parms.size] = var_3;

  if(isDefined(var_4))
    var_6.parms[var_6.parms.size] = var_4;

  if(isDefined(var_5))
    var_6.parms[var_6.parms.size] = var_5;

  level.run_noself_call_after_wait_array[level.run_noself_call_after_wait_array.size] = var_6;
}

add_endon(var_0) {
  var_1 = spawnStruct();
  var_1.caller = self;
  var_1.ender = var_0;
  level.do_wait_endons_array[level.do_wait_endons_array.size] = var_1;
}

do_wait_any() {
  do_wait(level.wait_any_func_array.size - 1);
}

do_wait(var_0) {
  if(!isDefined(var_0))
    var_0 = 0;

  var_1 = spawnStruct();
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

  for(;;) {
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
  var_0 = spawnStruct();
  var_1 = level.run_func_after_wait_array;
  level.run_func_after_wait_array = [];

  foreach(var_3 in var_1)
  level maps\_utility_code::exec_func(var_3, []);

  var_0 notify("all_funcs_ended");
}

is_default_start() {
  if(isDefined(level.forced_start_catchup) && level.forced_start_catchup == 1)
    return 0;

  if(isDefined(level.default_start_override) && level.default_start_override == level.start_point)
    return 1;

  if(isDefined(level.default_start))
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

  for(var_2 = 0; var_2 < level.start_functions.size; var_2++) {
    if(level.start_functions[var_2]["name"] == var_0) {
      var_1 = 1;
      continue;
    }

    if(level.start_functions[var_2]["name"] == level.start_point)
      return var_1;
  }
}

waterfx(var_0, var_1) {
  self endon("death");
  var_2 = 0;

  if(isDefined(var_1))
    var_2 = 1;

  if(isDefined(var_0)) {
    common_scripts\utility::flag_assert(var_0);
    level endon(var_0);
  }

  for(;;) {
    wait(randomfloatrange(0.15, 0.3));
    var_3 = self.origin + (0, 0, 150);
    var_4 = self.origin - (0, 0, 150);
    var_5 = bulletTrace(var_3, var_4, 0, undefined);

    if(var_5["surfacetype"] != "water") {
      continue;
    }
    var_6 = "water_movement";

    if(isplayer(self)) {
      if(distance(self getvelocity(), (0, 0, 0)) < 5)
        var_6 = "water_stop";
    } else if(isDefined(level._effect["water_" + self.a.movement]))
      var_6 = "water_" + self.a.movement;

    var_7 = common_scripts\utility::getfx(var_6);
    var_3 = var_5["position"];
    var_8 = (0, self.angles[1], 0);
    var_9 = anglesToForward(var_8);
    var_10 = anglestoup(var_8);
    playFX(var_7, var_3, var_10, var_9);

    if(var_6 != "water_stop" && var_2)
      thread common_scripts\utility::play_sound_in_space(var_1, var_3);
  }
}

playersnowfootsteps(var_0) {
  if(isDefined(var_0)) {
    common_scripts\utility::flag_assert(var_0);
    level endon(var_0);
  }

  for(;;) {
    wait(randomfloatrange(0.25, 0.5));
    var_1 = self.origin + (0, 0, 0);
    var_2 = self.origin - (0, 0, 5);
    var_3 = bulletTrace(var_1, var_2, 0, undefined);
    var_4 = anglesToForward(self.angles);
    var_5 = distance(self getvelocity(), (0, 0, 0));

    if(isDefined(self.vehicle)) {
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
      playFX(common_scripts\utility::getfx("footstep_snow_small"), var_3["position"], var_3["normal"], var_4);

    if(distance(self getvelocity(), (0, 0, 0)) > 154)
      playFX(common_scripts\utility::getfx("footstep_snow"), var_3["position"], var_3["normal"], var_4);
  }
}

mix_up(var_0) {
  var_1 = 60;

  for(var_2 = 0; var_2 < var_1; var_2++) {
    self setsoundblend(var_0, var_0 + "_off", (var_1 - var_2) / var_1);
    wait 0.05;
  }
}

mix_down(var_0) {
  var_1 = 60;

  for(var_2 = 0; var_2 < var_1; var_2++) {
    self setsoundblend(var_0, var_0 + "_off", var_2 / var_1);
    wait 0.05;
  }
}

manual_linkto(var_0, var_1) {
  var_0 endon("death");
  self endon("death");

  if(!isDefined(var_1))
    var_1 = (0, 0, 0);

  for(;;) {
    self.origin = var_0.origin + var_1;
    self.angles = var_0.angles;
    wait 0.05;
  }
}

nextmission() {
  maps\_utility_code::mission_recon();
  maps\_endmission::_nextmission();
}

make_array(var_0, var_1, var_2, var_3, var_4) {
  var_5 = [];
  var_5[var_5.size] = var_0;

  if(isDefined(var_1))
    var_5[var_5.size] = var_1;

  if(isDefined(var_2))
    var_5[var_5.size] = var_2;

  if(isDefined(var_3))
    var_5[var_5.size] = var_3;

  if(isDefined(var_4))
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

  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    var_3 = var_0[var_2];
    var_1[var_3] = self getweaponammoclip(var_3);
  }

  var_4 = 0;

  if(isDefined(var_1["claymore"]) && var_1["claymore"] > 0)
    var_4 = var_1["claymore"];

  return var_4;
}

_wait(var_0) {
  wait(var_0);
}

lerp_saveddvar(var_0, var_1, var_2) {
  var_3 = getdvarfloat(var_0);
  level notify(var_0 + "_lerp_savedDvar");
  level endon(var_0 + "_lerp_savedDvar");
  var_4 = var_1 - var_3;
  var_5 = 0.05;
  var_6 = int(var_2 / var_5);

  for(var_7 = var_4 / var_6; var_6; var_6--) {
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
  if(is_demo()) {
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
  var_1 setModel("weapon_javelin_obj");
  var_1.origin = self.origin;
  var_1.angles = self.angles;
  add_wait(::delete_on_not_defined);

  if(isDefined(var_0)) {
    common_scripts\utility::flag_assert(var_0);
    add_wait(common_scripts\utility::flag_wait, var_0);
  }

  do_wait_any();
  var_1 delete();
}

add_c4_glow(var_0) {
  var_1 = spawn("script_model", (0, 0, 0));
  var_1 setcontents(0);
  var_1 setModel("weapon_c4_obj");
  var_1.origin = self.origin;
  var_1.angles = self.angles;
  add_wait(::delete_on_not_defined);

  if(isDefined(var_0)) {
    common_scripts\utility::flag_assert(var_0);
    add_wait(common_scripts\utility::flag_wait, var_0);
  }

  do_wait_any();
  var_1 delete();
}

delete_on_not_defined() {
  for(;;) {
    if(!isDefined(self)) {
      return;
    }
    wait 0.05;
  }
}

slowmo_start() {}

slowmo_end() {}

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
  if(isDefined(level.no_slowmo) && level.no_slowmo) {
    return;
  }
  setslowmotion(level.slowmo.speed_norm, level.slowmo.speed_slow, level.slowmo.lerp_time_in);
}

slowmo_lerp_out() {
  if(isDefined(level.no_slowmo) && level.no_slowmo) {
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

arcademode_stop_timer() {
  if(!isDefined(level.arcademode_hud_timer)) {
    return;
  }
  level notify("arcadeMode_remove_timer");
  level.arcademode_stoptime = gettime();
  level.arcademode_hud_timer destroy();
  level.arcademode_hud_timer = undefined;
}

musicplaywrapper(var_0, var_1, var_2) {
  level._audio.last_song = var_0;

  if(!isDefined(var_1))
    var_1 = 1;

  if(!isDefined(var_2))
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
  if(isDefined(var_1) && var_1 > 0) {
    thread maps\_utility_code::music_play_internal_stop_with_fade_then_call(var_0, var_1, var_2, var_3);
    return;
  }

  music_stop();
  musicplaywrapper(var_0, var_2, var_3);
}

music_crossfade(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_2))
    var_2 = 1;

  if(!isDefined(var_3))
    var_3 = 0;

  if(isDefined(level._audio.last_song))
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
  if(!isDefined(var_0) || var_0 <= 0)
    musicstop();
  else
    musicstop(var_0);

  level notify("stop_music");
}

player_is_near_live_grenade() {
  var_0 = getEntArray("grenade", "classname");

  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    var_2 = var_0[var_1];

    if(var_2.model == "weapon_claymore") {
      continue;
    }
    for(var_3 = 0; var_3 < level.players.size; var_3++) {
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

  for(;;) {
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
  if(isDefined(level.xp_enable) && level.xp_enable && isDefined(level.xp_give_func))
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
    if(isDefined(var_5.script_noteworthy) && var_5.script_noteworthy == "player1") {
      var_1 = var_5;
      continue;
    }

    if(isDefined(var_5.script_noteworthy) && var_5.script_noteworthy == "player2") {
      var_2 = var_5;
      continue;
    }

    if(!isDefined(var_1))
      var_1 = var_5;

    if(!isDefined(var_2))
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

  if(isDefined(var_0.angles))
    level.player setplayerangles(var_0.angles);
}

translate_local() {
  var_0 = [];

  if(isDefined(self.entities))
    var_0 = self.entities;

  if(isDefined(self.entity))
    var_0[var_0.size] = self.entity;

  common_scripts\utility::array_levelthread(var_0, maps\_utility_code::translate_local_on_ent);
}

open_up_fov(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  level.player endon("stop_opening_fov");
  wait(var_0);
  level.player playerlinktodelta(var_1, var_2, 1, var_3, var_4, var_5, var_6, 1);
}

get_ai_touching_volume(var_0, var_1, var_2) {
  if(!isDefined(var_0))
    var_0 = "all";

  if(!isDefined(var_1))
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
  if(!isDefined(var_0))
    var_0 = "all";

  var_1 = [];

  if(var_0 == "all") {
    var_1 = array_merge(level.drones["allies"].array, level.drones["axis"].array);
    var_1 = array_merge(var_1, level.drones["neutral"].array);
  } else
    var_1 = level.drones[var_0].array;

  var_2 = [];

  foreach(var_4 in var_1) {
    if(!isDefined(var_4)) {
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
    if(!isDefined(var_4)) {
      continue;
    }
    if(isDefined(var_4.targetname) && var_4.targetname == var_0)
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

  if(!isDefined(var_0.classname)) {
    if(!isDefined(var_0.type))
      var_4 = "struct";
    else
      var_4 = "node";
  } else
    var_4 = "entity";

  if(!isDefined(var_1))
    var_1 = 300;

  var_5 = self.script_forcegoal;
  self.script_forcegoal = 1;
  maps\_spawner::go_to_node(var_0, var_4, var_2, var_1, var_3);
  self.script_forcegoal = var_5;
}

enable_dynamic_run_speed(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(var_0))
    var_0 = 250;

  if(!isDefined(var_1))
    var_1 = 100;

  if(!isDefined(var_2))
    var_2 = var_0 * 2;

  if(!isDefined(var_3))
    var_3 = var_0 * 1.25;

  if(!isDefined(var_5))
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

  for(;;) {
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

  if(!isDefined(var_2))
    var_2 = 5;

  var_3 = gettime() + var_2 * 1000;

  while(isDefined(var_0)) {
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

  while(isDefined(var_0)) {
    if(distance(var_0.origin, self.origin) <= var_1) {
      break;
    }

    wait 0.1;
  }
}

waittill_entity_out_of_range(var_0, var_1) {
  self endon("death");
  var_0 endon("death");

  while(isDefined(var_0)) {
    if(distance(var_0.origin, self.origin) > var_1) {
      break;
    }

    wait 0.1;
  }
}

has_shotgun() {
  self endon("death");

  if(!isDefined(self.weapon))
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

  if(!isDefined(var_0))
    return 0;

  foreach(var_2 in var_0) {
    if(issubstr(var_2, "thermal"))
      return 1;
  }

  return 0;
}

waittill_true_goal(var_0, var_1) {
  self endon("death");

  if(!isDefined(var_1))
    var_1 = self.goalradius;

  for(;;) {
    self waittill("goal");

    if(distance(self.origin, var_0) < var_1 + 10) {
      break;
    }
  }
}

player_speed_percent(var_0, var_1) {
  var_2 = int(getdvar("g_speed"));

  if(!isDefined(level.player.g_speed))
    level.player.g_speed = var_2;

  var_3 = int(level.player.g_speed * var_0 * 0.01);
  level.player player_speed_set(var_3, var_1);
}

blend_movespeedscale_percent(var_0, var_1) {
  var_2 = self;

  if(!isplayer(var_2))
    var_2 = level.player;

  if(!isDefined(var_2.movespeedscale))
    var_2.movespeedscale = 1.0;

  var_3 = var_0 * 0.01;
  var_2 blend_movespeedscale(var_3, var_1);
}

player_speed_set(var_0, var_1) {
  var_2 = int(getdvar("g_speed"));

  if(!isDefined(level.player.g_speed))
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

  if(!isDefined(var_2.movespeedscale))
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

  if(isDefined(var_1)) {
    var_7 = var_6 - var_5;
    var_8 = 0.05;
    var_9 = var_1 / var_8;
    var_10 = var_7 / var_9;

    while(abs(var_6 - var_5) > abs(var_10 * 1.1)) {
      var_5 = var_5 + var_10;
      [[var_3]](var_5);
      wait(var_8);
    }
  }

  [[var_3]](var_6);
}

player_speed_default(var_0) {
  if(!isDefined(level.player.g_speed)) {
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

  if(!isDefined(var_1.movespeedscale)) {
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
  return isDefined(self.slidemodel);
}

beginsliding(var_0, var_1, var_2) {
  var_3 = self;
  var_3 thread play_sound_on_entity("foot_slide_plr_start");
  var_3 thread play_loop_sound_on_tag("foot_slide_plr_loop");
  var_4 = isDefined(level.custom_linkto_slide);

  if(!isDefined(var_0))
    var_0 = var_3 getvelocity() + (0, 0, -10);

  if(!isDefined(var_1))
    var_1 = 10;

  if(!isDefined(var_2))
    var_2 = 0.035;

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
    var_5 = getEntArray(var_6, "classname");
    var_2 = common_scripts\utility::array_combine(var_2, var_5);
  }

  var_7 = maps\_trigger::get_load_trigger_funcs();

  foreach(var_9, var_4 in var_7) {
    if(!issubstr(var_9, "flag")) {
      continue;
    }
    var_5 = getEntArray(var_9, "targetname");
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
    var_5 = getEntArray(var_6, "classname");
    var_2 = common_scripts\utility::array_combine(var_2, var_5);
  }

  var_7 = maps\_trigger::get_load_trigger_funcs();

  foreach(var_9, var_4 in var_7) {
    if(!issubstr(var_9, "flag")) {
      continue;
    }
    var_5 = getEntArray(var_9, "targetname");
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

  if(!isDefined(var_0))
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
  return isDefined(self.a.doinglongdeath);
}

get_rumble_ent(var_0) {
  if(is_coop()) {}

  var_1 = get_player_from_self();

  if(!isDefined(var_0))
    var_0 = "steady_rumble";

  var_2 = spawn("script_origin", var_1 getEye());
  var_2.intensity = 1;
  var_2 thread maps\_utility_code::update_rumble_intensity(var_1, var_0);
  return var_2;
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

  for(var_5 = 0; var_5 < var_2; var_5++) {
    self.intensity = self.intensity + var_4;
    wait 0.05;
  }

  self.intensity = var_0;
}

get_player_from_self() {
  if(isDefined(self)) {
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
  if(isDefined(self.non_glow_model)) {
    return;
  }
  self.non_glow_model = self.model;

  if(!isDefined(var_0))
    var_0 = self.model + "_obj";

  self setModel(var_0);
}

stopglow(var_0) {
  if(!isDefined(self.non_glow_model)) {
    return;
  }
  self setModel(self.non_glow_model);
  self.non_glow_model = undefined;
}

array_delete_evenly(var_0, var_1, var_2) {
  var_3 = [];
  var_1 = var_2 - var_1;

  foreach(var_5 in var_0) {
    var_3[var_3.size] = var_5;

    if(var_3.size == var_2) {
      var_3 = common_scripts\utility::array_randomize(var_3);

      for(var_6 = var_1; var_6 < var_3.size; var_6++)
        var_3[var_6] delete();

      var_3 = [];
    }
  }

  var_8 = [];

  foreach(var_5 in var_0) {
    if(!isDefined(var_5)) {
      continue;
    }
    var_8[var_8.size] = var_5;
  }

  return var_8;
}

waittill_in_range(var_0, var_1, var_2) {
  if(!isDefined(var_2))
    var_2 = 0.5;

  self endon("death");

  while(isDefined(self)) {
    if(distance(var_0, self.origin) <= var_1) {
      break;
    }

    wait(var_2);
  }
}

add_trace_fx(var_0) {
  var_1 = spawnStruct();
  var_1 thread maps\_utility_code::add_trace_fx_proc(var_0);
  return var_1;
}

tracefx_on_tag(var_0, var_1, var_2) {
  var_3 = self gettagorigin(var_1);
  var_4 = self gettagangles(var_1);
  tracefx(var_0, var_3, var_4, var_2);
}

tracefx(var_0, var_1, var_2, var_3) {
  var_4 = anglesToForward(var_2);
  var_5 = bulletTrace(var_1, var_1 + var_4 * var_3, 0, undefined);

  if(var_5["fraction"] >= 1) {
    return;
  }
  var_6 = var_5["surfacetype"];

  if(!isDefined(level.trace_fx[var_0][var_6]))
    var_6 = "default";

  var_7 = level.trace_fx[var_0][var_6];

  if(isDefined(var_7["fx"]))
    playFX(var_7["fx"], var_5["position"], var_5["normal"]);

  if(isDefined(var_7["fx_array"])) {
    foreach(var_9 in var_7["fx_array"])
    playFX(var_9, var_5["position"], var_5["normal"]);
  }

  if(isDefined(var_7["sound"]))
    level thread common_scripts\utility::play_sound_in_space(var_7["sound"], var_5["position"]);

  if(isDefined(var_7["rumble"])) {
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

  if(!isDefined(var_0) || !var_0) {
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
  self.maxfaceenemydist = 512;
  self.specialreloadanimfunc = undefined;
  self.custommoveanimset = undefined;
}

getvehiclearray() {
  return vehicle_getarray();
}

hint(var_0, var_1, var_2) {
  if(!isDefined(var_2))
    var_2 = 0;

  var_3 = 0.5;
  level endon("clearing_hints");

  if(isDefined(level.hintelement))
    level.hintelement maps\_hud_util::destroyelem();

  level.hintelement = maps\_hud_util::createfontstring("default", 1.5);
  level.hintelement maps\_hud_util::setpoint("MIDDLE", undefined, 0, 30 + var_2);
  level.hintelement.color = (1, 1, 1);
  level.hintelement settext(var_0);
  level.hintelement.alpha = 0;
  level.hintelement fadeovertime(0.5);
  level.hintelement.alpha = 1;
  wait 0.5;
  level.hintelement endon("death");

  if(isDefined(var_1))
    wait(var_1);
  else
    return;

  level.hintelement fadeovertime(var_3);
  level.hintelement.alpha = 0;
  wait(var_3);
  level.hintelement maps\_hud_util::destroyelem();
}

hint_fade() {
  var_0 = 1;

  if(isDefined(level.hintelement)) {
    level notify("clearing_hints");
    level.hintelement fadeovertime(var_0);
    level.hintelement.alpha = 0;
    wait(var_0);
  }
}

kill_deathflag(var_0, var_1) {
  if(!isDefined(level.flag[var_0])) {
    return;
  }
  if(!isDefined(var_1))
    var_1 = 0;

  foreach(var_3 in level.deathflags[var_0]) {
    foreach(var_5 in var_3) {
      if(isalive(var_5)) {
        var_5 thread maps\_utility_code::kill_deathflag_proc(var_1);
        continue;
      }

      var_5 delete();
    }
  }
}

get_player_view_controller(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_3))
    var_3 = "player_view_controller";

  if(!isDefined(var_2))
    var_2 = (0, 0, 0);

  var_4 = var_0 gettagorigin(var_1);
  var_5 = spawnturret("misc_turret", var_4, var_3);
  var_5.angles = var_0 gettagangles(var_1);
  var_5 setModel("tag_turret");
  var_5 linkto(var_0, var_1, var_2, (0, 0, 0));
  var_5 makeunusable();
  var_5 hide();
  var_5 setmode("manual");
  return var_5;
}

create_blend(var_0, var_1, var_2, var_3) {
  var_4 = spawnStruct();
  var_4 childthread maps\_utility_code::process_blend(var_0, self, var_1, var_2, var_3);
  return var_4;
}

store_players_weapons(var_0) {
  if(!isDefined(self.stored_weapons))
    self.stored_weapons = [];

  var_1 = [];
  var_2 = self getweaponslistall();

  foreach(var_4 in var_2) {
    var_1[var_4] = [];
    var_1[var_4]["clip_left"] = self getweaponammoclip(var_4, "left");
    var_1[var_4]["clip_right"] = self getweaponammoclip(var_4, "right");
    var_1[var_4]["stock"] = self getweaponammostock(var_4);
  }

  if(!isDefined(var_0))
    var_0 = "default";

  self.stored_weapons[var_0] = [];
  self.stored_weapons[var_0]["current_weapon"] = self getcurrentweapon();
  self.stored_weapons[var_0]["inventory"] = var_1;
}

restore_players_weapons(var_0) {
  if(!isDefined(var_0))
    var_0 = "default";

  if(!isDefined(self.stored_weapons) || !isDefined(self.stored_weapons[var_0])) {
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

set_moveplaybackrate(var_0, var_1) {
  self notify("set_moveplaybackrate");
  self endon("set_moveplaybackrate");

  if(isDefined(var_1)) {
    var_2 = var_0 - self.moveplaybackrate;
    var_3 = 0.05;
    var_4 = var_1 / var_3;
    var_5 = var_2 / var_4;

    while(abs(var_0 - self.moveplaybackrate) > abs(var_5 * 1.1)) {
      self.moveplaybackrate = self.moveplaybackrate + var_5;
      wait(var_3);
    }
  }

  self.moveplaybackrate = var_0;
}

array_spawn_function(var_0, var_1, var_2, var_3, var_4, var_5) {
  foreach(var_7 in var_0)
  var_7 thread add_spawn_function(var_1, var_2, var_3, var_4, var_5);
}

array_spawn_function_targetname(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = getEntArray(var_0, "targetname");
  array_spawn_function(var_6, var_1, var_2, var_3, var_4, var_5);
}

array_spawn_function_noteworthy(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = getEntArray(var_0, "script_noteworthy");
  array_spawn_function(var_6, var_1, var_2, var_3, var_4, var_5);
}

enable_dontevershoot() {
  self.dontevershoot = 1;
}

disable_dontevershoot() {
  self.dontevershoot = undefined;
}

create_sunflare_setting(var_0) {
  if(!isDefined(level.sunflare_settings))
    level.sunflare_settings = [];

  var_1 = spawnStruct();
  var_1.name = var_0;
  level.sunflare_settings[var_0] = var_1;
  return var_1;
}

create_vision_set_fog(var_0) {
  if(!isDefined(level.vision_set_fog))
    level.vision_set_fog = [];

  var_1 = spawnStruct();
  var_1.name = var_0;
  var_1.hdrcolorintensity = 1;
  var_1.hdrsuncolorintensity = 1;
  var_1.skyfogintensity = 0;
  var_1.skyfogminangle = 0;
  var_1.skyfogmaxangle = 0;
  level.vision_set_fog[tolower(var_0)] = var_1;
  return var_1;
}

get_vision_set_fog(var_0) {
  if(!isDefined(level.vision_set_fog))
    level.vision_set_fog = [];

  var_1 = level.vision_set_fog[tolower(var_0)];

  if(using_hdr_fog() && isDefined(var_1) && isDefined(var_1.hdroverride))
    var_1 = level.vision_set_fog[tolower(var_1.hdroverride)];

  return var_1;
}

create_fog(var_0) {
  if(!isDefined(level.fog_set))
    level.fog_set = [];

  var_1 = spawnStruct();
  var_1.name = var_0;
  level.fog_set[tolower(var_0)] = var_1;
  return var_1;
}

get_fog(var_0) {
  if(!isDefined(level.fog_set))
    level.fog_set = [];

  var_1 = level.fog_set[tolower(var_0)];
  return var_1;
}

init_self_fog_transition() {
  if(!isDefined(self.fog_transition_ent)) {
    self.fog_transition_ent = spawnStruct();
    self.fog_transition_ent.fogset = "";
    self.fog_transition_ent.time = 0;
  }
}

using_hdr_fog() {
  if(!isDefined(level.console))
    set_console_status();

  return is_gen4();
}

fog_set_changes(var_0, var_1) {
  if(!isplayer(self))
    maps\_art::init_fog_transition();
  else
    init_self_fog_transition();

  if(!isDefined(level.fog_set))
    level.fog_set = [];

  var_2 = level.fog_set[tolower(var_0)];

  if(!isDefined(var_2))
    var_2 = level.vision_set_fog[tolower(var_0)];

  if(isDefined(var_2) && isDefined(var_2.hdroverride) && using_hdr_fog()) {
    if(isDefined(level.fog_set[tolower(var_2.hdroverride)]))
      var_2 = level.fog_set[tolower(var_2.hdroverride)];
    else if(isDefined(level.vision_set_fog))
      var_2 = level.vision_set_fog[tolower(var_2.hdroverride)];
  }

  if(!isDefined(var_1))
    var_1 = var_2.transitiontime;

  if(!isplayer(self)) {
    set_fog_to_ent_values(var_2, var_1);
    level.fog_transition_ent.fogset = var_0;
    level.fog_transition_ent.time = var_1;
  } else {
    if(var_0 != "" && self.fog_transition_ent.fogset == var_0 && self.fog_transition_ent.time == var_1) {
      return;
    }
    set_fog_to_ent_values(var_2, var_1);
    self.fog_transition_ent.fogset = var_0;
    self.fog_transition_ent.time = var_1;
  }
}

set_fog_to_ent_values(var_0, var_1) {
  if(isDefined(var_0.sunfogenabled) && var_0.sunfogenabled) {
    if(!isplayer(self))
      setexpfog(var_0.startdist, var_0.halfwaydist, var_0.red, var_0.green, var_0.blue, var_0.hdrcolorintensity, var_0.maxopacity, var_1, var_0.sunred, var_0.sungreen, var_0.sunblue, var_0.hdrsuncolorintensity, var_0.sundir, var_0.sunbeginfadeangle, var_0.sunendfadeangle, var_0.normalfogscale, var_0.skyfogintensity, var_0.skyfogminangle, var_0.skyfogmaxangle);
    else
      self playersetexpfog(var_0.startdist, var_0.halfwaydist, var_0.red, var_0.green, var_0.blue, var_0.hdrcolorintensity, var_0.maxopacity, var_1, var_0.sunred, var_0.sungreen, var_0.sunblue, var_0.hdrsuncolorintensity, var_0.sundir, var_0.sunbeginfadeangle, var_0.sunendfadeangle, var_0.normalfogscale, var_0.skyfogintensity, var_0.skyfogminangle, var_0.skyfogmaxangle);
  } else if(!isplayer(self))
    setexpfog(var_0.startdist, var_0.halfwaydist, var_0.red, var_0.green, var_0.blue, var_0.hdrcolorintensity, var_0.maxopacity, var_1, var_0.skyfogintensity, var_0.skyfogminangle, var_0.skyfogmaxangle);
  else
    self playersetexpfog(var_0.startdist, var_0.halfwaydist, var_0.red, var_0.green, var_0.blue, var_0.hdrcolorintensity, var_0.maxopacity, var_1, var_0.skyfogintensity, var_0.skyfogminangle, var_0.skyfogmaxangle);
}

vision_set_fog_changes(var_0, var_1) {
  var_2 = vision_set_changes(var_0, var_1);

  if(var_2) {
    if(isDefined(get_vision_set_fog(var_0)))
      fog_set_changes(var_0, var_1);
    else
      clearfog(var_1);
  }
}

init_self_visionset() {
  if(!isDefined(self.vision_set_transition_ent)) {
    self.vision_set_transition_ent = spawnStruct();
    self.vision_set_transition_ent.vision_set = "";
    self.vision_set_transition_ent.time = 0;
  }
}

vision_set_changes(var_0, var_1) {
  if(!isplayer(self)) {
    var_2 = 1;

    if(!isDefined(level.vision_set_transition_ent)) {
      level.vision_set_transition_ent = spawnStruct();
      level.vision_set_transition_ent.vision_set = "";
      level.vision_set_transition_ent.time = 0;
      var_2 = 0;
    }

    if(var_0 != "" && level.vision_set_transition_ent.vision_set == var_0 && level.vision_set_transition_ent.time == var_1)
      return 0;

    level.vision_set_transition_ent.vision_set = var_0;
    level.vision_set_transition_ent.time = var_1;

    if(var_2 && getdvarint("scr_art_tweak") != 0) {} else
      visionsetnaked(var_0, var_1);

    level.lvl_visionset = var_0;
    setdvar("vision_set_current", var_0);
  } else {
    init_self_visionset();

    if(var_0 != "" && self.vision_set_transition_ent.vision_set == var_0 && self.vision_set_transition_ent.time == var_1)
      return 0;

    self.vision_set_transition_ent.vision_set = var_0;
    self.vision_set_transition_ent.time = var_1;
    self visionsetnakedforplayer(var_0, var_1);
  }

  return 1;
}

enable_teamflashbangimmunity() {
  thread enable_teamflashbangimmunity_proc();
}

enable_teamflashbangimmunity_proc() {
  self endon("death");

  for(;;) {
    self.teamflashbangimmunity = 1;
    wait 0.05;
  }
}

disable_teamflashbangimmunity() {
  self.teamflashbangimmunity = undefined;
}

mask_destructibles_in_volumes(var_0) {
  var_1 = getEntArray("destructible_toy", "targetname");
  var_2 = getEntArray("destructible_vehicle", "targetname");
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
    var_5 = getEntArray(var_4[0], var_4[1]);
    var_2 = common_scripts\utility::array_combine(var_2, var_5);
  }

  foreach(var_8 in var_2) {
    if(!isDefined(level._interactive[var_8.interactive_type].savetostructfn)) {
      continue;
    }
    foreach(var_11 in var_0) {
      if(!var_11 istouching(var_8)) {
        continue;
      }
      if(!isDefined(var_11.interactives))
        var_11.interactives = [];

      var_11.interactives[var_11.interactives.size] = var_8[[level._interactive[var_8.interactive_type].savetostructfn]]();
    }
  }
}

activate_interactives_in_volume() {
  if(!isDefined(self.interactives)) {
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
  var_1 = getEntArray("script_brushmodel", "classname");
  var_2 = getEntArray("script_model", "classname");

  for(var_3 = 0; var_3 < var_2.size; var_3++)
    var_1[var_1.size] = var_2[var_3];

  foreach(var_5 in var_0) {
    foreach(var_7 in var_1) {
      if(isDefined(var_7.script_prefab_exploder))
        var_7.script_exploder = var_7.script_prefab_exploder;

      if(!isDefined(var_7.script_exploder)) {
        continue;
      }
      if(!isDefined(var_7.model)) {
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
    if(!isDefined(var_2.v["masked_exploder"])) {
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
    var_6 setModel(var_3);
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
  var_1 = common_scripts\_destructible::destructible_getinfoindex(var_0);

  if(var_1 != -1) {
    return;
  }
  if(!isDefined(level.destructible_functions))
    level.destructible_functions = [];

  var_2 = spawnStruct();
  var_2.destructibleinfo = common_scripts\_destructible::destructible_gettype(var_0);
  var_2 thread common_scripts\_destructible::precache_destructibles();
  var_2 thread common_scripts\_destructible::add_destructible_fx();
}

delete_destructibles_in_volumes(var_0, var_1) {
  foreach(var_3 in var_0)
  var_3.destructibles = [];

  var_5 = ["destructible_toy", "destructible_vehicle"];
  var_6 = 0;

  if(!isDefined(var_1))
    var_1 = 0;

  foreach(var_8 in var_5) {
    var_9 = getEntArray(var_8, "targetname");

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
  var_2 = getEntArray("script_brushmodel", "classname");
  var_3 = getEntArray("script_model", "classname");

  for(var_4 = 0; var_4 < var_3.size; var_4++)
    var_2[var_2.size] = var_3[var_4];

  var_5 = [];
  var_6 = spawn("script_origin", (0, 0, 0));
  var_7 = 0;

  if(!isDefined(var_1))
    var_1 = 0;

  foreach(var_9 in var_0) {
    foreach(var_11 in var_2) {
      if(!isDefined(var_11.script_exploder)) {
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
  if(!isDefined(self.destructibles)) {
    return;
  }
  foreach(var_1 in self.destructibles) {
    var_2 = spawn("script_model", (0, 0, 0));
    var_2 setModel(var_1.toy_model);
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
  if(isDefined(self.flashbangimmunity) && self.flashbangimmunity) {
    return;
  }
  var_1 = gettime() + var_0 * 1000.0;

  if(isDefined(self.flashendtime))
    self.flashendtime = max(self.flashendtime, var_1);
  else
    self.flashendtime = var_1;

  self notify("flashed");
  self setflashbanged(1);
}

waittill_volume_dead() {
  for(;;) {
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

  for(;;) {
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

    if(isDefined(var_4))
      var_1[var_4] = var_3;
  }

  return var_1;
}

add_target_pivot(var_0) {
  if(isDefined(var_0))
    self.pivot = var_0;
  else
    self.pivot = getent(self.target, "targetname");

  self linkto(self.pivot);
}

get_color_volume_from_trigger() {
  var_0 = maps\_utility_code::get_color_info_from_trigger();
  var_1 = var_0["team"];

  foreach(var_3 in var_0["codes"]) {
    var_4 = level.arrays_of_colorcoded_volumes[var_1][var_3];

    if(isDefined(var_4))
      return var_4;
  }

  return undefined;
}

get_color_nodes_from_trigger() {
  var_0 = maps\_utility_code::get_color_info_from_trigger();
  var_1 = var_0["team"];

  foreach(var_3 in var_0["codes"]) {
    var_4 = level.arrays_of_colorcoded_nodes[var_1][var_3];

    if(isDefined(var_4))
      return var_4;
  }

  return undefined;
}

flashbangstop() {
  self.flashendtime = undefined;
  self setflashbanged(0);
}

getent_or_struct(var_0, var_1) {
  var_2 = getent(var_0, var_1);

  if(isDefined(var_2))
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
  if(!isDefined(var_1))
    var_1 = level.player;

  var_1 allowcrouch(0);
  var_1 allowprone(0);
  var_1 disableweapons();
  var_6 = common_scripts\utility::spawn_tag_origin();
  var_6 linkto(self, "tag_passenger", player_rides_in_humvee_offset(var_0), (0, 0, 0));
  var_6.player_dismount = common_scripts\utility::spawn_tag_origin();
  var_6.player_dismount linkto(self, "tag_body", player_rides_humvee_offset_dismount(var_0), (0, 0, 0));

  if(!isDefined(var_2))
    var_2 = 90;

  if(!isDefined(var_3))
    var_3 = 90;

  if(!isDefined(var_4))
    var_4 = 40;

  if(!isDefined(var_5))
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
  if(!isDefined(var_0))
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
  if(!isDefined(self.damageattacker)) {
    return;
  }
  var_1 = screen_effect_sides(self.damageattacker.origin);

  foreach(var_4, var_3 in var_1)
  thread maps\_gameskill::blood_splat_on_screen(var_4);
}

screen_effect_sides(var_0) {
  var_1 = vectornormalize(anglesToForward(self.angles));
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
  if(!isDefined(self.old_pathrandompercent))
    self.old_pathrandompercent = self.pathrandompercent;

  self.pathrandompercent = var_0;
}

pathrandompercent_zero() {
  if(isDefined(self.old_pathrandompercent)) {
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
  if(isDefined(self.old_walkdistfacingmotion)) {
    return;
  }
  self.old_walkdist = self.walkdist;
  self.old_walkdistfacingmotion = self.walkdistfacingmotion;
  self.walkdist = 0;
  self.walkdistfacingmotion = 0;
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

  for(;;) {
    self waittill("damage", var_0, var_1);

    if(!isplayer(var_1) && issentient(var_1)) {
      if(isDefined(var_1.enemy) && var_1.enemy != self)
        continue;
    }

    self.fakehealth = self.fakehealth - var_0;

    if(self.fakehealth <= 0) {
      break;
    }
  }

  self kill();
}

hide_notsolid() {
  if(!isDefined(self.oldcontents))
    self.oldcontents = self setcontents(0);

  self hide();
}

show_solid() {
  if(!isai(self))
    self solid();

  if(isDefined(self.oldcontents))
    self setcontents(self.oldcontents);

  self show();
}

set_brakes(var_0) {
  self.veh_brake = var_0;
}

disable_ignorerandombulletdamage_drone() {
  if(!isalive(self)) {
    return;
  }
  if(!isDefined(self.ignorerandombulletdamage)) {
    return;
  }
  self notify("disable_ignorerandombulletdamage_drone");
  self.ignorerandombulletdamage = undefined;
  self.health = self.fakehealth;
}

timeoutent(var_0) {
  var_1 = spawnStruct();
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

  if(isDefined(var_2))
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

  if(isDefined(var_1[var_0]))
    return 1;

  return 0;
}

set_battlechatter_variable(var_0, var_1) {
  level.battlechatter[var_0] = var_1;
  maps\_utility_code::update_battlechatter_hud();
}

objective_clearadditionalpositions(var_0) {
  for(var_1 = 0; var_1 < 8; var_1++)
    objective_additionalposition(var_0, var_1, (0, 0, 0));
}

get_minutes_and_seconds(var_0) {
  var_1 = [];
  var_1["minutes"] = 0;

  for(var_1["seconds"] = int(var_0 / 1000); var_1["seconds"] >= 60; var_1["seconds"] = var_1["seconds"] - 60)
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
  if(!isDefined(level.obj_array))
    level.obj_array = [];

  if(!isDefined(level.obj_array[var_0]))
    level.obj_array[var_0] = level.obj_array.size + 1;

  return level.obj_array[var_0];
}

obj_exists(var_0) {
  return isDefined(level.obj_array) && isDefined(level.obj_array[var_0]);
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

musiclength(var_0) {
  var_1 = lookupsoundlength(var_0);
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

  if(!isDefined(var_1))
    var_1 = 0;

  if(var_1)
    array_thread_mod_delayed(var_0.fx, common_scripts\utility::pauseeffect);
  else
    common_scripts\utility::array_thread(var_0.fx, common_scripts\utility::pauseeffect);
}

array_thread_mod_delayed(var_0, var_1, var_2) {
  var_3 = 0;

  if(!isDefined(var_2))
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

  if(!isDefined(var_1.fx_paused)) {
    return;
  }
  var_1.fx_paused = undefined;
  fx_volume_restart(var_1);
}

fx_volume_restart(var_0) {
  common_scripts\utility::array_thread(var_0.fx, ::restarteffect);
}

flag_count_increment(var_0) {
  if(!isDefined(level.flag_count))
    level.flag_count = [];

  if(!isDefined(level.flag_count[var_0]))
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
  if(!isDefined(level.cleanup_ents))
    level.cleanup_ents = [];

  if(!isDefined(level.cleanup_ents[var_1]))
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
  if(!isDefined(level.cleanup_ents)) {
    return;
  }
  if(!isDefined(level.cleanup_ents[var_0])) {
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
    if(!isDefined(var_3.magic_bullet_shield)) {
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
  if(!isDefined(self.trigger_functions))
    thread maps\_utility_code::add_trigger_func_thread();

  self.trigger_functions[self.trigger_functions.size] = var_0;
}

getallweapons() {
  var_0 = [];
  var_1 = getEntArray();

  foreach(var_3 in var_1) {
    if(!isDefined(var_3.classname)) {
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

  if(!isDefined(var_2))
    var_2 = 200;

  var_3 = distance(self.origin, var_0);
  var_4 = var_3 / var_2;
  var_5 = vectornormalize(var_0 - self.origin);
  self moveto(var_0, var_4, 0, 0);
  self rotateto(var_1, var_4, 0, 0);
  wait(var_4);

  if(!isDefined(self)) {
    return;
  }
  self.velocity = var_5 * (var_3 / var_4);
}

flag_on_death(var_0) {
  level endon(var_0);
  self waittill("death");
  common_scripts\utility::flag_set(var_0);
}

enable_damagefeedback() {
  level.damagefeedback = 1;
}

disable_damagefeedback() {
  level.damagefeedback = 0;
}

is_damagefeedback_enabled() {
  return isDefined(level.damagefeedback) && level.damagefeedback;
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
  if(!isDefined(var_0)) {
    return;
  }
  var_1 = var_0.script_linkname;

  if(isDefined(var_1) && isDefined(level.struct_class_names["script_linkname"]) && isDefined(level.struct_class_names["script_linkname"][var_1])) {
    foreach(var_4, var_3 in level.struct_class_names["script_linkname"][var_1]) {
      if(isDefined(var_3) && var_0 == var_3)
        level.struct_class_names["script_linkname"][var_1][var_4] = undefined;
    }

    if(level.struct_class_names["script_linkname"][var_1].size == 0)
      level.struct_class_names["script_linkname"][var_1] = undefined;
  }

  var_1 = var_0.script_noteworthy;

  if(isDefined(var_1) && isDefined(level.struct_class_names["script_noteworthy"]) && isDefined(level.struct_class_names["script_noteworthy"][var_1])) {
    foreach(var_4, var_3 in level.struct_class_names["script_noteworthy"][var_1]) {
      if(isDefined(var_3) && var_0 == var_3)
        level.struct_class_names["script_noteworthy"][var_1][var_4] = undefined;
    }

    if(level.struct_class_names["script_noteworthy"][var_1].size == 0)
      level.struct_class_names["script_noteworthy"][var_1] = undefined;
  }

  var_1 = var_0.target;

  if(isDefined(var_1) && isDefined(level.struct_class_names["target"]) && isDefined(level.struct_class_names["target"][var_1])) {
    foreach(var_4, var_3 in level.struct_class_names["target"][var_1]) {
      if(isDefined(var_3) && var_0 == var_3)
        level.struct_class_names["target"][var_1][var_4] = undefined;
    }

    if(level.struct_class_names["target"][var_1].size == 0)
      level.struct_class_names["target"][var_1] = undefined;
  }

  var_1 = var_0.targetname;

  if(isDefined(var_1) && isDefined(level.struct_class_names["targetname"]) && isDefined(level.struct_class_names["targetname"][var_1])) {
    foreach(var_4, var_3 in level.struct_class_names["targetname"][var_1]) {
      if(isDefined(var_3) && var_0 == var_3)
        level.struct_class_names["targetname"][var_1][var_4] = undefined;
    }

    if(level.struct_class_names["targetname"][var_1].size == 0)
      level.struct_class_names["targetname"][var_1] = undefined;
  }

  if(isDefined(level.struct)) {
    foreach(var_4, var_3 in level.struct) {
      if(var_0 == var_3)
        level.struct[var_4] = undefined;
    }
  }
}

deletestructarray_ref(var_0, var_1) {
  if(!isDefined(var_0) || !isarray(var_0) || var_0.size == 0) {
    return;
  }
  var_1 = common_scripts\utility::ter_op(isDefined(var_1), var_1, 0);
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

  if(!isDefined(var_2))
    var_2 = getnode(var_0, var_1);

  if(!isDefined(var_2))
    var_2 = getvehiclenode(var_0, var_1);

  return var_2;
}

setentityheadicon(var_0, var_1, var_2, var_3, var_4) {
  if(isDefined(var_3))
    self.entityheadiconoffset = var_3;
  else
    self.entityheadiconoffset = (0, 0, 0);

  if(isDefined(var_4))
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
  if(!isDefined(self.entityheadicon)) {
    return;
  }
  self.entityheadicon destroy();
}

updateentityheadicon() {
  self endon("new_head_icon");
  self endon("death");
  var_0 = self.origin;

  for(;;) {
    if(var_0 != self.origin) {
      updateentityheadiconorigin();
      var_0 = self.origin;
    }

    wait 0.05;
  }
}

updateentityheadiconorigin() {
  if(isDefined(self.entityheadiconreferencefunc)) {
    var_0 = self[[self.entityheadiconreferencefunc]]();

    if(isDefined(var_0)) {
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

  if(!isDefined(self.entityheadicon)) {
    return;
  }
  self.entityheadicon destroy();
}

worldtolocalcoords(var_0) {
  var_1 = var_0 - self.origin;
  return (vectordot(var_1, anglesToForward(self.angles)), -1.0 * vectordot(var_1, anglestoright(self.angles)), vectordot(var_1, anglestoup(self.angles)));
}

set_audio_zone(var_0, var_1) {
  maps\_audio::set_zone(var_0, var_1);
}

stop_audio_zones(var_0) {
  maps\_audio::stop_zones(var_0);
}

get_audio_zone() {
  return level._audio.zone.current_zone;
}

set_audio_filter(var_0, var_1) {
  maps\_audio::set_filter(var_0, var_1);
}

clear_audio_filter(var_0) {
  maps\_audio::clear_filter(var_0);
}

set_audio_occlusion(var_0) {
  maps\_audio::set_occlusion(var_0);
}

clear_audio_occlusion() {
  maps\_audio::deactivate_occlusion();
}

sound_fade_and_delete(var_0) {
  self scalevolume(0, var_0);
  common_scripts\utility::delaycall(var_0 + 0.05, ::stopsounds);
  common_scripts\utility::delaycall(var_0 + 0.1, ::delete);
}

sound_fade_in(var_0, var_1, var_2, var_3) {
  var_1 = clamp(var_1, 0, 1);
  var_2 = max(0.05, var_2);

  if(isDefined(var_3))
    self playLoopSound(var_0);
  else
    self playSound(var_0);

  self scalevolume(0.0);
  common_scripts\utility::delaycall(0.05, ::scalevolume, var_1, var_2);
}

delete_on_sounddone() {
  self waittill("sounddone");
  self delete();
}

set_level_fadein_time(var_0) {
  level._audio.level_fade_time = var_0;
}

set_audio_mix(var_0) {
  maps\_audio::set_mix(var_0);
}

clear_audio_mix(var_0) {
  maps\_audio::clear_mix(var_0);
}

previous_audio_mix() {}

intro_screen_create(var_0, var_1, var_2, var_3, var_4) {
  level.introscreen = spawnStruct();
  level.introscreen.completed_delay = 3;
  level.introscreen.fade_out_time = 1.5;
  level.introscreen.fade_in_time = undefined;

  if(isDefined(var_3))
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
  if(isDefined(self.animarchetype) && self.animarchetype == "creepwalk")
    self.sharpturnlookaheaddist = 30;

  self.animarchetype = undefined;
  self notify("move_loop_restart");
}

in_alien_mode() {
  if(isDefined(level.alien_mode) && level.alien_mode == 1)
    return 1;
  else
    return 0;
}

transient_load(var_0) {
  loadtransient(var_0);

  while(!istransientloaded(var_0))
    wait 0.1;

  common_scripts\utility::flag_set(var_0 + "_loaded");
}

transient_unload(var_0) {
  unloadtransient(var_0);

  while(istransientloaded(var_0))
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
  if(!isDefined(var_2)) {
    foreach(var_4 in var_0) {
      if(isDefined(var_4)) {
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
          if(isDefined(var_4)) {
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
          if(isDefined(var_4)) {
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
          if(isDefined(var_4)) {
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
          if(isDefined(var_4)) {
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
          if(isDefined(var_4)) {
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
          if(isDefined(var_4)) {
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
  if(!isDefined(var_2)) {
    foreach(var_4 in var_0) {
      if(isDefined(var_4)) {
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
          if(isDefined(var_4)) {
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
          if(isDefined(var_4)) {
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
          if(isDefined(var_4)) {
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
          if(isDefined(var_4)) {
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
          if(isDefined(var_4)) {
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
          if(isDefined(var_4)) {
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
  if(!isDefined(level.console))
    set_console_status();

  if(is_gen4())
    setdvar(var_0, var_2);
  else
    setdvar(var_0, var_1);
}

setsaveddvar_cg_ng(var_0, var_1, var_2) {
  if(!isDefined(level.console))
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

  if(!isDefined(var_1))
    var_1 = 300;

  self.current_follow_path = var_2;
  var_2 script_delay();

  while(isDefined(var_2)) {
    self.current_follow_path = var_2;

    if(isDefined(var_2.lookahead)) {
      break;
    }

    if(isDefined(level.struct_class_names["targetname"][var_2.targetname]))
      var_4 = ::follow_path_animate_set_struct;
    else if(isDefined(var_2.classname))
      var_4 = ::follow_path_animate_set_ent;
    else
      var_4 = ::follow_path_animate_set_node;

    if(isDefined(var_2.radius) && var_2.radius != 0)
      self.goalradius = var_2.radius;

    if(self.goalradius < 16)
      self.goalradius = 16;

    if(isDefined(var_2.height) && var_2.height != 0)
      self.goalheight = var_2.height;

    var_5 = self.goalradius;
    self childthread[[var_4]](var_2);

    if(isDefined(var_2.animation))
      var_2 waittill(var_2.animation);
    else {
      for(;;) {
        self waittill("goal");

        if(distance(var_2.origin, self.origin) < var_5 + 10 || self.team != "allies") {
          break;
        }
      }
    }

    var_2 notify("trigger", self);

    if(isDefined(var_2.script_flag_set))
      common_scripts\utility::flag_set(var_2.script_flag_set);

    if(isDefined(var_2.script_parameters)) {
      var_6 = strtok(var_2.script_parameters, " ");

      for(var_7 = 0; var_7 < var_6.size; var_7++) {
        if(isDefined(level.custom_followpath_parameter_func))
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

    if(!isDefined(var_2.script_requires_player) && var_1 > 0 && self.team == "allies") {
      while(isalive(level.player)) {
        if(follow_path_wait_for_player(var_2, var_1)) {
          break;
        }

        if(isDefined(var_2.animation)) {
          self.goalradius = var_5;
          self setgoalpos(self.origin);
        }

        wait 0.05;
      }
    }

    if(!isDefined(var_2.target)) {
      break;
    }

    if(isDefined(var_2.script_flag_wait))
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
  var_2 = anglesToForward(self.angles);
  var_3 = vectornormalize(level.player.origin - self.origin);

  if(isDefined(var_0.target)) {
    var_4 = common_scripts\utility::get_target_ent(var_0.target);
    var_2 = vectornormalize(var_4.origin - var_0.origin);
  } else if(isDefined(var_0.angles))
    var_2 = anglesToForward(var_0.angles);
  else
    var_2 = anglesToForward(self.angles);

  if(vectordot(var_2, var_3) > 0)
    return 1;

  if(distance(level.player.origin, self.origin) < var_1)
    return 1;

  return 0;
}

follow_path_animate_set_node(var_0) {
  self notify("follow_path_new_goal");

  if(isDefined(var_0.animation)) {
    var_0 maps\_anim::anim_generic_reach(self, var_0.animation);
    self notify("starting_anim", var_0.animation);

    if(isDefined(var_0.script_parameters) && issubstr(var_0.script_parameters, "gravity"))
      var_0 maps\_anim::anim_generic_gravity(self, var_0.animation);
    else
      var_0 maps\_anim::anim_generic_run(self, var_0.animation);

    self setgoalpos(self.origin);
  } else
    set_goal_node(var_0);
}

follow_path_animate_set_ent(var_0) {
  self notify("follow_path_new_goal");

  if(isDefined(var_0.animation)) {
    var_0 maps\_anim::anim_generic_reach(self, var_0.animation);
    self notify("starting_anim", var_0.animation);

    if(isDefined(var_0.script_parameters) && issubstr(var_0.script_parameters, "gravity"))
      var_0 maps\_anim::anim_generic_gravity(self, var_0.animation);
    else
      var_0 maps\_anim::anim_generic_run(self, var_0.animation);

    self setgoalpos(self.origin);
  } else
    set_goal_ent(var_0);
}

follow_path_animate_set_struct(var_0) {
  self notify("follow_path_new_goal");

  if(isDefined(var_0.animation)) {
    var_0 maps\_anim::anim_generic_reach(self, var_0.animation);
    self notify("starting_anim", var_0.animation);
    disable_exits();

    if(isDefined(var_0.script_parameters) && issubstr(var_0.script_parameters, "gravity"))
      var_0 maps\_anim::anim_generic_gravity(self, var_0.animation);
    else
      var_0 maps\_anim::anim_generic_run(self, var_0.animation);

    delaythread(0.05, ::enable_exits);
    self setgoalpos(self.origin);
  } else
    set_goal_pos(var_0.origin);
}

post_load_precache(var_0) {
  if(!isDefined(level.post_load_funcs))
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

  for(var_3 = 0; var_3 < var_2; var_3++) {
    if(tolower(getpartname(var_0, var_3)) == tolower(var_1))
      return 1;
  }

  return 0;
}

stylized_center_text(var_0, var_1, var_2, var_3) {
  if(!isarray(var_0))
    var_0 = [var_0];

  var_4 = 320;
  var_5 = 200;
  var_6 = [];

  foreach(var_10, var_8 in var_0) {
    var_9 = maps\_introscreen::stylized_line(var_8, var_1, var_4, var_5 + var_10 * 20, "center", var_2, var_3);
    var_6 = common_scripts\utility::array_combine(var_9, var_6);
  }

  wait(var_1);
  maps\_introscreen::stylized_fadeout(var_6, var_4, var_5, var_0.size);
}