/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\801.gsc
**************************************/

set_hudoutline(var_0, var_1) {
  var_2 = undefined;
  var_0 = _tolower(var_0);
  var_3["friendly"] = 3;
  var_3["enemy"] = 4;
  var_3["objective"] = 5;
  var_3["neutral"] = 0;
  var_2 = var_3[var_0];
  self hudoutlineenable(var_2, var_1);
}

is_coop() {
  if(_issplitscreen() || getDvar("4693") == "1") {
    return 1;
  }

  return 0;
}

is_coop_online() {
  if(_issplitscreen()) {
    return 0;
  }

  if(!is_coop()) {
    return 0;
  }

  return 1;
}

is_player_down(var_0) {
  if(var_0 common_scripts\utility::ent_flag_exist("laststand_downed")) {
    return var_0 common_scripts\utility::ent_flag("laststand_downed");
  }

  if(isDefined(var_0._id_00E8)) {
    return var_0._id_00E8;
  }

  return !isalive(var_0);
}

is_player_down_and_out(var_0) {
  if(!isDefined(var_0.down_part2_proc_ran)) {
    return 0;
  }

  return var_0.down_part2_proc_ran;
}

killing_will_down(var_0) {
  if(laststand_enabled()) {
    if(isDefined(level.laststand_kill_will_down_func)) {
      return var_0[[level.laststand_kill_will_down_func]]();
    }
  }

  return 0;
}

is_survival() {
  return is_specialop() && getdvarint("719") > 0;
}

laststand_enabled() {
  return isDefined(level._id_5BE7) && level._id_5BE7 > 0;
}

is_specialop() {
  return getdvarint("1996") >= 1;
}

convert_to_time_string(var_0, var_1) {
  var_2 = "";

  if(var_0 < 0) {
    var_2 = var_2 + "-";
  }

  var_0 = round_float(var_0, 1, 0);
  var_3 = var_0 * 100;
  var_3 = int(var_3);
  var_3 = _abs(var_3);
  var_4 = var_3 / 6000;
  var_4 = int(var_4);
  var_2 = var_2 + var_4;
  var_5 = var_3 / 100;
  var_5 = int(var_5);
  var_5 = var_5 - var_4 * 60;

  if(var_5 < 10) {
    var_2 = var_2 + (":0" + var_5);
  } else {
    var_2 = var_2 + (":" + var_5);
  }

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

  if(var_1 < 0 || var_1 > 4) {
    return var_0;
  }

  var_3 = 1;

  for(var_4 = 1; var_4 <= var_1; var_4++) {
    var_3 = var_3 * 10;
  }

  var_5 = var_0 * var_3;

  if(!isDefined(var_2) || var_2) {
    var_5 = _floor(var_5);
  } else {
    var_5 = _ceil(var_5);
  }

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
  if(_id_0322::init_vision_set(var_0)) {
    return;
  }
  if(!isDefined(var_1)) {
    var_1 = 1;
  }

  _visionsetnaked(var_0, var_1);
  setDvar("vision_set_current", var_0);
}

set_vision_set_player(var_0, var_1) {
  if(_id_0322::init_vision_set(var_0)) {
    return;
  }
  if(!isDefined(var_1)) {
    var_1 = 1;
  }

  self visionsetnakedforplayer(var_0, var_1);
}

sun_light_fade(var_0, var_1, var_2) {
  var_2 = int(var_2 * 20);
  var_3 = [];

  for(var_4 = 0; var_4 < 3; var_4++) {
    var_3[var_4] = (var_0[var_4] - var_1[var_4]) / var_2;
  }

  var_5 = [];

  for(var_4 = 0; var_4 < var_2; var_4++) {
    waitframe();

    for(var_6 = 0; var_6 < 3; var_6++) {
      var_5[var_6] = var_0[var_6] - var_3[var_6] * var_4;
    }

    _setsunlight(var_5[0], var_5[1], var_5[2]);
  }

  _setsunlight(var_1[0], var_1[1], var_1[2]);
}

get_closest_to_player_view(var_0, var_1, var_2, var_3) {
  if(!var_0.size) {
    return;
  }
  if(!isDefined(var_1)) {
    var_1 = level.player;
  }

  if(!isDefined(var_3)) {
    var_3 = -1;
  }

  var_4 = var_1.origin;

  if(isDefined(var_2) && var_2) {
    var_4 = var_1 getEye();
  }

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
  if(!isDefined(var_1)) {
    var_1 = level.player;
  }

  var_3 = var_1.origin;

  if(isDefined(var_2) && var_2) {
    var_3 = var_1 getEye();
  }

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

  if(!isDefined(var_2)) {
    var_2 = 0;
  }

  var_1 thread _id_0322::_id_0629(var_0, var_2);
  return var_1;
}

flag_triggers_init(var_0, var_1, var_2) {
  common_scripts\utility::flag_init(var_0);

  if(!isDefined(var_2)) {
    var_2 = 0;
  }

  for(var_3 = 0; var_3 < var_1.size; var_3++) {
    var_1[var_3] thread _id_0322::_id_0629(var_0, 0);
  }

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

level_end_save(var_0, var_1) {
  if(!isDefined(var_0)) {
    var_0 = 0;
  }

  if(_id_0F44() && !var_0) {
    return 0;
  }

  if(level.missionfailed && !var_0) {
    return 0;
  }

  if(common_scripts\utility::flag("game_saving")) {
    return 0;
  }

  if(!var_0) {
    for(var_2 = 0; var_2 < level.players.size; var_2++) {
      var_3 = level.players[var_2];

      if(!isalive(var_3)) {
        return 0;
      }
    }
  }

  common_scripts\utility::flag_set("game_saving");
  var_4 = "levelshots / autosave / autosave_" + level._id_015D + "end";
  var_5 = var_1;
  _savegame("levelend", &"AUTOSAVE_AUTOSAVE", var_4, 1, 1, var_5);
  common_scripts\utility::flag_clear("game_saving");
  return 1;
}

_id_0928(var_0, var_1, var_2) {
  level._id_0625[var_0] = [];
  level._id_0625[var_0]["func"] = var_1;
  level._id_0625[var_0]["msg"] = var_2;
}

remove_extra_autosave_check(var_0) {
  level._id_0625[var_0] = undefined;
}

_id_139B() {
  thread autosave_by_name_thread("autosave_stealth", 8, 1);
}

_id_139C() {
  thread autosave_by_name_thread("autosave_stealth", 8, 1, 1);
}

_id_139D() {
  _id_0322::autosave_tactical_setup();
  thread _id_0322::autosave_tactical_proc();
}

autosave_by_name(var_0) {
  thread autosave_by_name_thread(var_0);
}

autosave_by_name_silent(var_0) {
  thread autosave_by_name_thread(var_0, undefined, undefined, 1);
}

autosave_by_name_thread(var_0, var_1, var_2, var_3) {
  if(!isDefined(level.curautosave)) {
    level.curautosave = 1;
  }

  var_4 = "levelshots/autosave/autosave_" + level._id_015D + level.curautosave;
  var_5 = level _id_0299::_id_13A3(level.curautosave, var_4, var_1, undefined, var_2, var_3);

  if(isDefined(var_5) && var_5) {
    if(!isDefined(var_3) || var_3 == 0) {
      _id_031D::_id_7430("CHECKPOINT_REACHED");
    }

    level.curautosave++;
  }
}

autosave_or_timeout(var_0, var_1) {
  thread autosave_by_name_thread(var_0, var_1);
}

debug_message(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_2)) {
    var_2 = 5;
  }

  if(isDefined(var_3)) {
    var_3 endon("death");
    var_1 = var_3.origin;
  }

  for(var_4 = 0; var_4 < var_2 * 20; var_4++) {
    if(!isDefined(var_3)) {} else {}

    waitframe();
  }
}

debug_message_ai(var_0, var_1) {
  self notify("debug_message_ai");
  self endon("debug_message_ai");
  self endon("death");

  if(!isDefined(var_1)) {
    var_1 = 5;
  }

  for(var_2 = 0; var_2 < var_1 * 20; var_2++) {
    waitframe();
  }
}

debug_message_clear(var_0, var_1, var_2, var_3) {
  if(isDefined(var_3)) {
    level notify(var_0 + var_3);
    level endon(var_0 + var_3);
  } else {
    level notify(var_0);
    level endon(var_0);
  }

  if(!isDefined(var_2)) {
    var_2 = 5;
  }

  for(var_4 = 0; var_4 < var_2 * 20; var_4++) {
    waitframe();
  }
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
  return _id_0322::comparesizesfx(var_0, var_1, var_2, ::closerfunc);
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

  if(!isDefined(var_2) || var_4 <= var_2) {
    return var_3;
  }

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
    if(distance(var_1[var_4].origin, var_0) <= var_2) {
      var_3[var_3.size] = var_1[var_4];
    }
  }

  return var_3;
}

get_outside_range(var_0, var_1, var_2) {
  var_3 = [];

  for(var_4 = 0; var_4 < var_1.size; var_4++) {
    if(distance(var_1[var_4].origin, var_0) > var_2) {
      var_3[var_3.size] = var_1[var_4];
    }
  }

  return var_3;
}

get_closest_living(var_0, var_1, var_2) {
  if(!isDefined(var_2)) {
    var_2 = 9999999;
  }

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
  if(!isDefined(var_2)) {
    var_2 = 9999999;
  }

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
  if(!isDefined(var_1)) {
    return undefined;
  }

  var_3 = 0;

  if(isDefined(var_2) && var_2.size) {
    var_4 = [];

    for(var_5 = 0; var_5 < var_1.size; var_5++) {
      var_4[var_5] = 0;
    }

    for(var_5 = 0; var_5 < var_1.size; var_5++) {
      for(var_6 = 0; var_6 < var_2.size; var_6++) {
        if(var_1[var_5] == var_2[var_6]) {
          var_4[var_5] = 1;
        }
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

    if(!var_7) {
      return undefined;
    }
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
          if(var_1[var_5] == var_2[var_6]) {
            var_4 = 1;
          }
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

  if(isDefined(var_8)) {
    return var_1[var_8];
  } else {
    return undefined;
  }
}

get_closest_player(var_0) {
  if(level.players.size == 1) {
    return level.player;
  }

  var_1 = common_scripts\utility::getclosest(var_0, level.players);
  return var_1;
}

get_closest_player_healthy(var_0) {
  if(level.players.size == 1) {
    return level.player;
  }

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
  if(isDefined(var_1)) {
    var_3 = _getaiarray(var_1);
  } else {
    var_3 = _getaiarray();
  }

  if(var_3.size == 0) {
    return undefined;
  }

  if(isDefined(var_2)) {
    var_3 = common_scripts\utility::_id_0F94(var_3, var_2);
  }

  return common_scripts\utility::getclosest(var_0, var_3);
}

get_closest_ai_exclude(var_0, var_1, var_2) {
  if(isDefined(var_1)) {
    var_3 = _getaiarray(var_1);
  } else {
    var_3 = _getaiarray();
  }

  if(var_3.size == 0) {
    return undefined;
  }

  return get_closest_exclude(var_0, var_3, var_2);
}

get_progress(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_3)) {
    var_3 = distance(var_0, var_1);
  }

  var_3 = max(0.01, var_3);
  var_4 = vectorNormalize(var_1 - var_0);
  var_5 = var_2 - var_0;
  var_6 = vectordot(var_5, var_4);
  var_6 = var_6 / var_3;
  var_6 = clamp(var_6, 0, 1);
  return var_6;
}

can_see_origin(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = 1;
  }

  if(!point_in_fov(var_0)) {
    return 0;
  }

  if(!_sighttracepassed(self getEye(), var_0, var_1, self)) {
    return 0;
  }

  return 1;
}

_id_5577(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = 180;
  }

  var_2 = anglesToForward(self.angles);
  var_2 = vectorNormalize((var_2[0], var_2[1], 0));
  var_3 = vectorNormalize(var_0 - self.origin);
  var_3 = vectorNormalize((var_3[0], var_3[1], 0));
  var_4 = vectordot(var_2, var_3);
  var_5 = _cos(var_1 / 2.0);
  return var_4 > var_5;
}

point_in_fov(var_0) {
  var_1 = anglesToForward(self.angles);
  var_2 = vectorNormalize(var_0 - self.origin);
  var_3 = vectordot(var_1, var_2);
  return var_3 > 0.766;
}

stop_magic_bullet_shield() {
  self notify("stop_magic_bullet_shield");

  if(_isai(self)) {
    self._id_0022 = 1;
  }

  self.magic_bullet_shield = undefined;
  self._id_0068 = 0;
  self notify("internal_stop_magic_bullet_shield");
}

magic_bullet_death_detection() {}

magic_bullet_shield(var_0) {
  if(_isai(self)) {} else
    self.health = 100000;

  self endon("internal_stop_magic_bullet_shield");

  if(_isai(self)) {
    self._id_0022 = 0.1;
  }

  self notify("magic_bullet_shield");
  self.magic_bullet_shield = 1;
  self._id_0068 = 1;
}

disable_long_death() {
  self._id_0794.disablelongdeath = 1;
}

enable_long_death() {
  self._id_0794.disablelongdeath = 0;
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
  return self._id_00CE;
}

set_ignoreme(var_0) {
  self._id_00CE = var_0;
}

_id_84E2(var_0) {
  self._id_00CA = var_0;

  if(var_0) {
    self clearenemy();
  }
}

_id_41D7(var_0) {
  return self._id_00CA;
}

_id_8563(var_0) {
  self._id_0147 = var_0;
}

_id_42D2(var_0) {
  return self._id_0147;
}

set_ignoresonicaoe(var_0) {
  self.ignoresonicaoe = var_0;
}

isusinghandbrake(var_0) {
  self._id_0094 = var_0;
}

get_pacifist() {
  return self._id_0118;
}

agentsetfavoriteenemy(var_0) {
  self._id_0118 = var_0;
}

ignore_me_timer(var_0) {
  self notify("new_ignore_me_timer");
  self endon("new_ignore_me_timer");
  self endon("death");

  if(!isDefined(self.ignore_me_timer_prev_value)) {
    self.ignore_me_timer_prev_value = self._id_00CE;
  }

  var_1 = _getaiarray("bad_guys");

  foreach(var_3 in var_1) {
    if(!isalive(var_3._id_0088)) {
      continue;
    }
    if(var_3._id_0088 != self) {
      continue;
    }
    var_3 clearenemy();
  }

  self._id_00CE = 1;
  wait(var_0);
  self._id_00CE = self.ignore_me_timer_prev_value;
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
  _id_02FC::_id_3D83(var_0);
}

set_ambient_preh1(var_0, var_1) {
  _id_0362::azm_start_zone(var_0, var_1);
}

force_crawling_death(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_1)) {
    var_1 = 4;
  }

  thread force_crawling_death_proc(var_0, var_1, var_2, var_3);
}

override_crawl_death_anims() {}

force_crawling_death_proc(var_0, var_1, var_2, var_3) {
  self.forcelongdeath = 1;
  self._id_0794.force_num_crawls = var_1;
  self.noragdoll = 1;
  self.nofallanim = var_3;
  self._id_0794.custom_crawling_death_array = var_2;
  self.crawlingpainanimoverridefunc = ::override_crawl_death_anims;
  self.maxhealth = 100000;
  self.health = 100000;
  enable_long_death();

  if(!isDefined(var_3) || var_3 == 0) {
    self._id_0794.force_crawl_angle = var_0 + 181.02;
  } else {
    self._id_0794.force_crawl_angle = var_0;
    thread animscripts\notetracks::notetrackposecrawl();
  }
}

never_saw_it_coming() {
  self endon("death");

  for(;;) {
    var_0 = self ishighjumping();

    if(var_0) {
      var_1 = common_scripts\utility::waittill_any_return("exo_dodge", "player_boost_land", "disable_high_jump");

      if(!isDefined(var_1) || (var_1 == "player_boost_land" || var_1 == "disable_high_jump")) {
        continue;
      }
      if(!isDefined(self.never_saw_it_coming)) {
        self.never_saw_it_coming = 1;
      }

      common_scripts\utility::waittill_any("player_boost_land", "disable_high_jump");
      waitframe();
      self.never_saw_it_coming = undefined;
    }

    waitframe();
  }
}

shock_ondeath() {
  _precacheshellshock("default");
  self waittill("death");

  if(isDefined(self.specialdeath)) {
    return;
  }
  if(getDvar("r_texturebits") == "16") {
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
        if(isDefined(self.handle_unresolved_collision)) {
          self[[self.handle_unresolved_collision]]();
        } else {
          default_unresolved_collision_handler();
        }
      }
    } else
      reset_unresolved_collision_handler();

    waitframe();
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
  var_0 = _getnodesinradiussorted(self.origin, 300, 0, 200, "Path");

  if(var_0.size) {
    self cancelmantle();
    self dontinterpolate();
    self setOrigin(var_0[0].origin);
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
  common_scripts\utility::waittill_any("death", "sound_death");

  if(isDefined(var_0)) {
    if(var_0 iswaitingonsound()) {
      var_0 waittill(var_1);
    }

    var_0 delete();
  }
}

is_dead_sentient() {
  return _issentient(self) && !isalive(self);
}

_id_0692(var_0, var_1) {
  var_1 endon("sound_death");
  var_0 waittill("death");
  return 1;
}

play_sound_on_tag(var_0, var_1, var_2, var_3, var_4) {
  if(common_scripts\utility::_id_562E(var_2) && is_dead_sentient()) {
    return;
  }
  if(!_soundexists(var_0)) {
    return;
  }
  if(isDefined(var_1)) {
    var_1 = _tolower(var_1);

    if(self gettagindex(var_1) == -1) {
      var_1 = undefined;
    }
  }

  if(!isDefined(var_2) || !var_2) {
    var_5 = _id_0380::_id_6848(var_0, undefined, self, var_1);
  } else {
    var_5 = _id_0380::_id_684A(var_0, undefined, self, var_1);
  }

  if(isDefined(var_5)) {
    var_6 = _id_0692(var_5, self);

    if(!isDefined(var_6) && isDefined(var_5)) {
      _id_0380::_id_6850(var_5, 0.1);
      wait 0.1;
    }
  } else
    wait 0.1;

  if(isDefined(var_3) && isDefined(self)) {
    self notify(var_3);
  }
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

  if(!isDefined(var_2)) {
    var_2 = 1;
  }

  if(var_2) {
    thread common_scripts\utility::delete_on_death(var_4);
  }

  if(!isDefined(var_3)) {
    var_3 = 0;
  }

  if(var_3) {
    thread delete_on_removed(var_4);
  }

  if(isDefined(var_1)) {
    var_4 linkTo(self, var_1, (0, 0, 0), (0, 0, 0));
  } else {
    var_4.origin = self.origin;
    var_4.angles = self.angles;
    var_4 linkTo(self);
  }

  var_4 playLoopSound(var_0);
  self waittill("stop sound" + var_0);
  var_4 stoploopsound(var_0);
  var_4 delete();
}

delete_on_removed(var_0) {
  var_0 endon("death");

  while(isDefined(self)) {
    waitframe();
  }

  if(isDefined(var_0)) {
    var_0 delete();
  }
}

unlink() {
  var_0 = _getaiarray("allies");
  var_1 = 0;

  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    if(isDefined(var_0[var_2].getaimangle)) {
      continue;
    }
    game["character" + var_1] = var_0[var_2] codescripts\character::save();
    var_1++;
  }

  game["total characters"] = var_1;
}

spawn_failed(var_0) {
  if(!isalive(var_0)) {
    return 1;
  }

  if(!isDefined(var_0.finished_spawning)) {
    var_0 common_scripts\utility::waittill_either("finished spawning", "death");
  }

  if(isalive(var_0)) {
    return 0;
  }

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
  _iprintlnbold(var_0, var_1["key1"]);
}

view_tag(var_0) {
  self endon("death");

  for(;;) {
    _id_02A9::drawtag(var_0);
    waitframe();
  }
}

assign_animtree(var_0) {
  if(isDefined(var_0)) {
    self._id_0EC4 = var_0;
  }

  self useanimtree(level.setclock[self._id_0EC4]);
}

assign_model() {
  if(_isarray(level.setcursorhint[self._id_0EC4])) {
    var_0 = randomint(level.setcursorhint[self._id_0EC4].size);
    self setModel(level.setcursorhint[self._id_0EC4][var_0]);
  } else
    self setModel(level.setcursorhint[self._id_0EC4]);
}

spawn_anim_model(var_0, var_1, var_2) {
  if(!isDefined(var_1)) {
    var_1 = (0, 0, 0);
  }

  var_3 = spawn("script_model", var_1);
  var_3._id_0EC4 = var_0;
  var_3 assign_animtree();
  var_3 assign_model();

  if(isDefined(var_2)) {
    var_3.angles = var_2;
  }

  return var_3;
}

trigger_wait(var_0, var_1) {
  var_2 = _getEnt(var_0, var_1);

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
  thread agentclearscriptvars(var_0, var_1, ::waittill_dead, "set_flag_on_dead");
}

vehicle_jetbikesetthrustscale(var_0, var_1) {
  thread agentclearscriptvars(var_0, var_1, ::waittill_dead_or_dying, "set_flag_on_dead_or_dying");
}

drawfacingentity(var_0, var_1) {
  thread agentclearscriptvars(var_0, var_1, ::empty_func, "set_flag_on_spawned");
}

empty_func(var_0) {
  return;
}

allowdodge(var_0, var_1) {
  self waittill("spawned", var_2);

  if(spawn_failed(var_2)) {
    return;
  }
  var_0._id_9044[var_0._id_9044.size] = var_2;
  common_scripts\utility::ent_flag_set(var_1);
}

setcanspawnvehicleson(var_0, var_1) {
  self waittill("spawned", var_2);
  var_0._id_9044[var_0._id_9044.size] = var_2;
  common_scripts\utility::ent_flag_set(var_1);
}

agentclearscriptvars(var_0, var_1, var_2, var_3) {
  var_4 = spawnStruct();
  var_4._id_9044 = [];

  if(var_0.size == 0) {
    return;
  }
  var_5 = 0;
  var_6 = 0;

  foreach(var_9, var_8 in var_0) {
    if(_isspawner(var_8)) {
      var_5++;
      continue;
    }

    var_6++;
  }

  if(var_6 != var_0.size && var_5 != var_0.size) {}

  if(_isspawner(var_0[0])) {
    var_10 = var_0;

    foreach(var_9, var_12 in var_10) {
      var_12 common_scripts\utility::ent_flag_init(var_3);
    }

    if(var_10[0]._id_003B == "script_vehicle") {
      common_scripts\utility::_id_0FB2(var_10, ::setcanspawnvehicleson, var_4, var_3);
    } else {
      common_scripts\utility::_id_0FB2(var_10, ::allowdodge, var_4, var_3);
    }

    foreach(var_9, var_12 in var_10) {
      var_12 common_scripts\utility::ent_flag_wait(var_3);
    }
  } else
    var_4._id_9044 = var_0;

  [[var_2]](var_4._id_9044);
  common_scripts\utility::flag_set(var_1);
}

setclutforplayer(var_0, var_1) {
  if(!common_scripts\utility::flag(var_1)) {
    var_0 waittill("trigger", var_2);
    common_scripts\utility::flag_set(var_1);
    return var_2;
  }
}

vehicle_setminimapvisible(var_0) {
  if(common_scripts\utility::flag(var_0)) {
    return;
  }
  var_1 = _getEnt(var_0, "targetname");
  var_1 waittill("trigger");
  common_scripts\utility::flag_set(var_0);
}

is_in_array(var_0, var_1) {
  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    if(var_0[var_2] == var_1) {
      return 1;
    }
  }

  return 0;
}

waittill_dead(var_0, var_1, var_2) {
  var_10 = spawnStruct();

  if(isDefined(var_2)) {
    var_10 endon("thread_timed_out");
    var_10 thread waittill_dead_timeout(var_2);
  }

  var_10._id_005C = var_0.size;

  if(isDefined(var_1) && var_1 < var_10._id_005C) {
    var_10._id_005C = var_1;
  }

  common_scripts\utility::_id_0FB2(var_0, ::waittill_dead_thread, var_10);

  while(var_10._id_005C > 0) {
    var_10 waittill("waittill_dead guy died");
  }
}

waittill_dead_or_dying(var_0, var_1, var_2) {
  var_3 = [];

  foreach(var_5 in var_0) {
    if(isalive(var_5) && !var_5._id_00CD) {
      var_3[var_3.size] = var_5;
    }
  }

  var_0 = var_3;
  var_7 = spawnStruct();

  if(isDefined(var_2)) {
    var_7 endon("thread_timed_out");
    var_7 thread waittill_dead_timeout(var_2);
  }

  var_7._id_005C = var_0.size;

  if(isDefined(var_1) && var_1 < var_7._id_005C) {
    var_7._id_005C = var_1;
  }

  common_scripts\utility::_id_0FB2(var_0, ::waittill_dead_or_dying_thread, var_7);

  while(var_7._id_005C > 0) {
    var_7 waittill("waittill_dead_guy_dead_or_dying");
  }
}

waittill_dead_thread(var_0) {
  self waittill("death");
  var_0._id_005C--;
  var_0 notify("waittill_dead guy died");
}

waittill_dead_or_dying_thread(var_0) {
  common_scripts\utility::waittill_either("death", "pain_death");
  var_0._id_005C--;
  var_0 notify("waittill_dead_guy_dead_or_dying");
}

waittill_dead_timeout(var_0) {
  wait(var_0);
  self notify("thread_timed_out");
}

waittill_aigroupcleared(var_0) {
  while(level._id_0596[var_0]._id_905E.size >= 1 || level._id_0596[var_0]._id_0A62.size >= 1) {
    wait 0.25;
  }
}

_id_A707(var_0, var_1) {
  for(;;) {
    var_2 = _id_406F(var_0);
    var_2 = var_2 + _id_406D(var_0);

    if(var_2 <= var_1) {
      break;
    }

    wait 0.25;
  }
}

_id_A708(var_0, var_1) {
  for(;;) {
    var_2 = _id_406D(var_0);

    if(var_2 <= var_1) {
      break;
    }

    wait 0.25;
  }
}

_id_A709(var_0, var_1, var_2) {
  level endon(var_2);
  _id_A708(var_0, var_1);
}

_id_406C(var_0) {
  return _id_406F(var_0) + _id_406D(var_0);
}

_id_406F(var_0) {
  var_1 = 0;

  foreach(var_3 in level._id_0596[var_0]._id_905E) {
    var_1 = var_1 + var_3._id_005C;
  }

  return var_1;
}

_id_406D(var_0) {
  return level._id_0596[var_0]._id_0A62.size;
}

_id_406B(var_0) {
  return level._id_0596[var_0]._id_0A62;
}

_id_4070(var_0) {
  return level._id_0596[var_0]._id_905E;
}

waittill_notetrack_or_damage(var_0) {
  self endon("damage");
  self endon("death");
  self waittillmatch("single anim", var_0);
}

get_living_ai(var_0, var_1) {
  var_2 = get_living_ai_array(var_0, var_1);

  if(var_2.size > 1) {
    return undefined;
  }

  return var_2[0];
}

get_living_ai_array(var_0, var_1) {
  var_2 = _getaispeciesarray("all", "all");
  var_3 = [];

  foreach(var_5 in var_2) {
    if(!isalive(var_5)) {
      continue;
    }
    switch (var_1) {
      case "targetname":
        if(isDefined(var_5.targetname) && var_5.targetname == var_0) {
          var_3[var_3.size] = var_5;
        }

        break;
      case "script_noteworthy":
        if(isDefined(var_5._id_0165) && var_5._id_0165 == var_0) {
          var_3[var_3.size] = var_5;
        }

        break;
    }
  }

  return var_3;
}

get_vehicle(var_0, var_1) {
  var_2 = get_vehicle_array(var_0, var_1);

  if(!var_2.size) {
    return undefined;
  }

  return var_2[0];
}

get_vehicle_array(var_0, var_1) {
  var_2 = getEntArray(var_0, var_1);
  var_3 = [];
  var_4 = [];

  foreach(var_6 in var_2) {
    if(var_6._id_003B != "script_vehicle") {
      continue;
    }
    var_4[0] = var_6;

    if(_isspawner(var_6)) {
      if(isDefined(var_6.last_spawned_vehicle)) {
        var_4[0] = var_6.last_spawned_vehicle;
        var_3 = common_scripts\utility::_id_0F8C(var_3, var_4);
      }

      continue;
    }

    var_3 = common_scripts\utility::_id_0F8C(var_3, var_4);
  }

  return var_3;
}

get_living_aispecies(var_0, var_1, var_2) {
  var_3 = get_living_aispecies_array(var_0, var_1, var_2);

  if(var_3.size > 1) {
    return undefined;
  }

  return var_3[0];
}

get_living_aispecies_array(var_0, var_1, var_2) {
  if(!isDefined(var_2)) {
    var_2 = "all";
  }

  var_3 = _getaispeciesarray("allies", var_2);
  var_3 = common_scripts\utility::_id_0F73(var_3, _getaispeciesarray("axis", var_2));
  var_4 = [];

  for(var_5 = 0; var_5 < var_3.size; var_5++) {
    switch (var_1) {
      case "targetname":
        if(isDefined(var_3[var_5].targetname) && var_3[var_5].targetname == var_0) {
          var_4[var_4.size] = var_3[var_5];
        }

        break;
      case "script_noteworthy":
        if(isDefined(var_3[var_5]._id_0165) && var_3[var_5]._id_0165 == var_0) {
          var_4[var_4.size] = var_3[var_5];
        }

        break;
    }
  }

  return var_4;
}

gather_delay_proc(var_0, var_1) {
  if(isDefined(level.gather_delay[var_0])) {
    if(level.gather_delay[var_0]) {
      waitframe();

      if(isalive(self)) {
        self notify("gather_delay_finished" + var_0 + var_1);
      }

      return;
    }

    level waittill(var_0);

    if(isalive(self)) {
      self notify("gather_delay_finished" + var_0 + var_1);
    }

    return;
  }

  level.gather_delay[var_0] = 0;
  wait(var_1);
  level.gather_delay[var_0] = 1;
  level notify(var_0);

  if(isalive(self)) {
    self notify("gather_delay_finished" + var_0 + var_1);
  }
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
  if(var_0 == 0) {
    return "0";
  }

  if(var_0 == 1) {
    return "1";
  }

  if(var_0 == 2) {
    return "2";
  }

  if(var_0 == 3) {
    return "3";
  }

  if(var_0 == 4) {
    return "4";
  }

  if(var_0 == 5) {
    return "5";
  }

  if(var_0 == 6) {
    return "6";
  }

  if(var_0 == 7) {
    return "7";
  }

  if(var_0 == 8) {
    return "8";
  }

  if(var_0 == 9) {
    return "9";
  }
}

getlinks_array(var_0, var_1) {
  var_2 = [];

  for(var_3 = 0; var_3 < var_0.size; var_3++) {
    var_4 = var_0[var_3];
    var_5 = var_4._id_0164;

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

_id_0F8D(var_0, var_1) {
  if(!var_0.size) {
    return var_1;
  }

  if(!var_1.size) {
    return var_0;
  }

  var_2 = [];

  for(var_3 = 0; var_3 < var_0.size; var_3++) {
    var_4 = var_0[var_3];
    var_2[var_4._id_0164] = 1;
  }

  for(var_3 = 0; var_3 < var_1.size; var_3++) {
    var_4 = var_1[var_3];

    if(isDefined(var_2[var_4._id_0164])) {
      continue;
    }
    var_2[var_4._id_0164] = 1;
    var_0[var_0.size] = var_4;
  }

  return var_0;
}

getlinkedvehiclenodes() {
  var_0 = [];

  if(isDefined(self.script_exploder)) {
    var_1 = common_scripts\utility::get_links();

    foreach(var_3 in var_1) {
      var_4 = _getvehiclenodearray(var_3, "script_linkname");
      var_0 = common_scripts\utility::_id_0F73(var_0, var_4);
    }
  }

  return var_0;
}

draw_line(var_0, var_1, var_2, var_3, var_4) {
  for(;;) {
    waitframe();
  }
}

draw_line_to_ent_for_time(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_5 = gettime() + var_5 * 1000;

  while(gettime() < var_5) {
    waitframe();

    if(!isDefined(var_1) || !isDefined(var_1.origin)) {
      return;
    }
  }
}

draw_line_from_ent_for_time(var_0, var_1, var_2, var_3, var_4, var_5) {
  draw_line_to_ent_for_time(var_1, var_0, var_2, var_3, var_4, var_5);
}

draw_line_from_ent_to_ent_for_time(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_0 endon("death");
  var_1 endon("death");
  var_5 = gettime() + var_5 * 1000;

  while(gettime() < var_5) {
    waitframe();
  }
}

draw_line_from_ent_to_ent_until_notify(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_0 endon("death");
  var_1 endon("death");
  var_5 endon(var_6);

  for(;;) {
    waitframe();
  }
}

draw_line_until_notify(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_5 endon(var_6);
  var_7 = 1;

  for(;;) {
    common_scripts\utility::draw_line_for_time(var_0, var_1, var_2, var_3, var_4, var_7);
    wait(var_7);
  }
}

draw_line_from_ent_to_vec_for_time(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_6 = gettime() + var_6 * 1000;
  var_1 = var_1 * var_2;

  while(gettime() < var_6) {
    waitframe();

    if(!isDefined(var_0) || !isDefined(var_0.origin)) {
      return;
    }
  }
}

draw_circle_until_notify(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  if(isDefined(var_7)) {
    var_8 = var_7;
  } else {
    var_8 = 16;
  }

  var_9 = 360 / var_8;
  var_10 = [];

  for(var_11 = 0; var_11 < var_8; var_11++) {
    var_12 = var_9 * var_11;
    var_13 = _cos(var_12) * var_1;
    var_14 = _sin(var_12) * var_1;
    var_15 = var_0[0] + var_13;
    var_16 = var_0[1] + var_14;
    var_17 = var_0[2];
    var_10[var_10.size] = (var_15, var_16, var_17);
  }

  thread draw_circle_lines_until_notify(var_10, var_2, var_3, var_4, var_5, var_6);
}

draw_circle_lines_until_notify(var_0, var_1, var_2, var_3, var_4, var_5) {
  for(var_6 = 0; var_6 < var_0.size; var_6++) {
    var_7 = var_0[var_6];

    if(var_6 + 1 >= var_0.size) {
      var_8 = var_0[0];
    } else {
      var_8 = var_0[var_6 + 1];
    }

    thread draw_line_until_notify(var_7, var_8, var_1, var_2, var_3, var_4, var_5);
  }
}

clear_enemy_passthrough() {
  self notify("enemy");
  self clearenemy();
}

battlechatter_on(var_0) {
  _id_02A8::dds_disable(var_0);
}

_id_163E(var_0) {
  _id_02A8::dds_enable(var_0);
}

physicsgetangspeed(var_0) {
  dds_exclude_this_ai(!var_0);
}

flavorbursts_on(var_0) {
  thread setpainvisioneq(1, var_0);
}

flavorbursts_off(var_0) {
  thread setpainvisioneq(0, var_0);
}

setpainvisioneq(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = "allies";
  }

  if(!anim.chatinitialized) {
    return;
  }
  wait 1.5;
  level.flavorbursts[var_1] = var_0;
  var_2 = [];
  var_2 = _getaiarray(var_1);
  common_scripts\utility::_id_0FB2(var_2, ::setclutoverridedisableforplayer, var_0);
}

setclutoverridedisableforplayer(var_0) {
  self.flavorbursts = var_0;
}

friendlyfire_warnings_off() {
  var_0 = _getaiarray("allies");

  foreach(var_2 in var_0) {
    if(isalive(var_2)) {
      var_2 set_friendlyfire_warnings(0);
    }
  }

  level.friendlyfire_warnings = 0;
}

friendlyfire_warnings_on() {
  var_0 = _getaiarray("allies");

  foreach(var_2 in var_0) {
    if(isalive(var_2)) {
      var_2 set_friendlyfire_warnings(1);
    }
  }

  level.friendlyfire_warnings = 1;
}

set_friendlyfire_warnings(var_0) {
  if(var_0) {
    self.friendlyfire_warnings_disable = undefined;
  } else {
    self.friendlyfire_warnings_disable = 1;
  }
}

dds_set_player_character_name(var_0) {
  if(!isPlayer(self)) {
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
  if(_isai(self) && isalive(self)) {
    if(var_0) {
      self.dds_disable = 1;
    } else {
      self.dds_disable = 0;
    }
  } else {}
}

get_obj_origin(var_0) {
  var_1 = getEntArray("objective", "targetname");

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    if(var_1[var_2]._id_0165 == var_0) {
      return var_1[var_2].origin;
    }
  }
}

get_obj_event(var_0) {
  var_1 = getEntArray("objective_event", "targetname");

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    if(var_1[var_2]._id_0165 == var_0) {
      return var_1[var_2];
    }
  }
}

waittill_objective_event() {
  _id_0322::waittill_objective_event_proc(1);
}

waittill_objective_event_notrigger() {
  _id_0322::waittill_objective_event_proc(0);
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
    waitframe();
  }
}

get_last_ent_in_chain(var_0) {
  var_1 = self;

  while(isDefined(var_1.target)) {
    waitframe();

    if(isDefined(var_1.target)) {
      switch (var_0) {
        case "vehiclenode":
          var_1 = _getvehiclenode(var_1.target, "targetname");
          break;
        case "pathnode":
          var_1 = _getnode(var_1.target, "targetname");
          break;
        case "ent":
          var_1 = _getEnt(var_1.target, "targetname");
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

botclearbutton(var_0) {
  self endon("death");
  var_1 = _getaiarray("allies");
  var_1[var_1.size] = level.player;
  var_1 = _sortbydistance(var_1, self.origin, 3000);
  var_1 = common_scripts\utility::_id_0FA0(var_1);
  var_2 = var_1[_randomintrange(0, int(var_1.size / 2))];
  self setentitytarget(var_2, 1);

  if(isDefined(var_0)) {
    thread timeout(var_0);
  }

  self._id_00AE = 64;
  self setgoalentity(var_2);

  if(!isDefined(self.oldgoalradius)) {
    self.oldgoalradius = self._id_00AE;
  }

  common_scripts\utility::waittill_any("goal", "timeout");

  if(isDefined(self.oldgoalradius)) {
    self._id_00AE = self.oldgoalradius;
    self.oldgoalradius = undefined;
  }
}

player_seek(var_0) {
  if(isDefined(var_0)) {
    thread timeout(var_0);
  }

  self._id_00AE = 128;
  self setgoalentity(level.player);

  if(!isDefined(self.oldgoalradius)) {
    self.oldgoalradius = self._id_00AE;
  }

  common_scripts\utility::waittill_any("goal", "timeout");

  if(isDefined(self.oldgoalradius)) {
    self._id_00AE = self.oldgoalradius;
    self.oldgoalradius = undefined;
  }
}

timeout(var_0) {
  self endon("death");
  wait(var_0);
  self notify("timeout");
}

notifyonplayercommandremove() {
  if(isDefined(self.set_forcedgoal)) {
    return;
  }
  self.oldfightdist = self._id_011D;
  self.oldmaxdist = self._id_011E;
  self.oldmaxsight = self._id_0100;
  self._id_011D = 8;
  self._id_011E = 8;
  self._id_0100 = 1;
  self.set_forcedgoal = 1;
}

unset_forcegoal() {
  if(!isDefined(self.set_forcedgoal)) {
    return;
  }
  self._id_011D = self.oldfightdist;
  self._id_011E = self.oldmaxdist;
  self._id_0100 = self.oldmaxsight;
  self.set_forcedgoal = undefined;
}

_id_0F9D(var_0) {
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

_id_0F9C(var_0) {
  var_1 = [];

  foreach(var_3 in var_0) {
    if(!isalive(var_3)) {
      continue;
    }
    var_1[var_1.size] = var_3;
  }

  return var_1;
}

_id_0F9E(var_0) {
  var_1 = [];

  foreach(var_3 in var_0) {
    if(!isalive(var_3)) {
      continue;
    }
    if(_isai(var_3) && var_3 doinglongdeath()) {
      continue;
    }
    var_1[var_1.size] = var_3;
  }

  return var_1;
}

struct_arrayspawn() {
  var_0 = spawnStruct();
  var_0._id_0F6D = [];
  var_0.lastindex = 0;
  return var_0;
}

structarray_add(var_0, var_1) {
  var_0._id_0F6D[var_0.lastindex] = var_1;
  var_1.struct_array_index = var_0.lastindex;
  var_0.lastindex++;
}

structarray_remove(var_0, var_1) {
  structarray_swaptolast(var_0, var_1);
  var_0._id_0F6D[var_0.lastindex - 1] = undefined;
  var_0.lastindex--;
}

structarray_remove_index(var_0, var_1) {
  if(isDefined(var_0._id_0F6D[var_0.lastindex - 1])) {
    var_0._id_0F6D[var_1] = var_0._id_0F6D[var_0.lastindex - 1];
    var_0._id_0F6D[var_1].struct_array_index = var_1;
    var_0._id_0F6D[var_0.lastindex - 1] = undefined;
    var_0.lastindex = var_0._id_0F6D.size;
  } else {
    var_0._id_0F6D[var_1] = undefined;
    structarray_remove_undefined(var_0);
  }
}

structarray_remove_undefined(var_0) {
  var_1 = [];

  foreach(var_3 in var_0._id_0F6D) {
    if(!isDefined(var_3)) {
      continue;
    }
    var_1[var_1.size] = var_3;
  }

  var_0._id_0F6D = var_1;

  foreach(var_6, var_3 in var_0._id_0F6D) {
    var_3.struct_array_index = var_6;
  }

  var_0.lastindex = var_0._id_0F6D.size;
}

structarray_swaptolast(var_0, var_1) {
  var_0 _id_0322::structarray_swap(var_0._id_0F6D[var_0.lastindex - 1], var_1);
}

structarray_shuffle(var_0, var_1) {
  for(var_2 = 0; var_2 < var_1; var_2++) {
    var_0 _id_0322::structarray_swap(var_0._id_0F6D[var_2], var_0._id_0F6D[randomint(var_0.lastindex)]);
  }
}

get_use_key() {
  if(level.console) {
    return " + usereload";
  } else {
    return " + activate";
  }
}

_id_4350(var_0, var_1) {
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
  var_2._id_00C6 = "left";
  var_2._id_01CA = "middle";

  if(isDefined(var_1)) {
    var_3 = var_1;
  } else {
    var_3 = level.explosiveplanttime;
  }

  var_2 setclock(var_3, var_0, "hudStopwatch", 64, 64);
  return var_2;
}

objective_is_active(var_0) {
  var_1 = 0;

  for(var_2 = 0; var_2 < level._id_08C4.size; var_2++) {
    if(level._id_08C4[var_2] != var_0) {
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

scragentsetlateralcodemove(var_0) {
  var_1 = [];

  for(var_2 = 0; var_2 < level._id_08C4.size; var_2++) {
    if(level._id_08C4[var_2] == var_0) {
      continue;
    }
    var_1[var_1.size] = level._id_08C4[var_2];
  }

  level._id_08C4 = var_1;
  var_3 = 0;

  for(var_2 = 0; var_2 < level.inactive_objective.size; var_2++) {
    if(level.inactive_objective[var_2] != var_0) {
      continue;
    }
    var_3 = 1;
  }

  if(!var_3) {
    level.inactive_objective[level.inactive_objective.size] = var_0;
  }
}

scragentsetobstacleavoid(var_0) {
  var_1 = [];

  for(var_2 = 0; var_2 < level.inactive_objective.size; var_2++) {
    if(level.inactive_objective[var_2] == var_0) {
      continue;
    }
    var_1[var_1.size] = level.inactive_objective[var_2];
  }

  level.inactive_objective = var_1;
  var_3 = 0;

  for(var_2 = 0; var_2 < level._id_08C4.size; var_2++) {
    if(level._id_08C4[var_2] != var_0) {
      continue;
    }
    var_3 = 1;
  }

  if(!var_3) {
    level._id_08C4[level._id_08C4.size] = var_0;
  }
}

missionfailedwrapper() {
  if(level.missionfailed) {
    return;
  }
  if(isDefined(level.nextmission)) {
    return;
  }
  if(getDvar("failure_disabled") == "1") {
    return;
  }
  level.player _id_02FA::_id_4CFE();
  level.missionfailed = 1;
  common_scripts\utility::flag_set("missionfailed");

  if(_id_0F44()) {
    return;
  }
  if(isDefined(level.mission_fail_func)) {
    thread[[level.mission_fail_func]]();
    return;
  }

  _id_0322::mission_recon(0);
  missionfailed();
}

set_mission_failed_override(var_0) {
  level.mission_fail_func = var_0;
}

guy_enter_vehicle(var_0) {
  thread _id_0324::guy_enter(var_0);
}

_id_4923(var_0, var_1, var_2, var_3, var_4) {
  _id_0324::guy_runtovehicle(var_0, var_1, var_2, var_3, var_4);
}

_id_4916(var_0) {
  var_1 = self.ridingvehicle;

  if(!isDefined(var_1)) {
    return 0;
  }

  if(isDefined(var_0) && !var_0) {
    foreach(var_3 in var_1.unloadque) {
      if(isDefined(var_3) && var_3 == self) {
        return 0;
      }
    }
  }

  if(isDefined(self.vehicle_position)) {
    return 1;
  }

  return 0;
}

get_force_color_guys(var_0, var_1) {
  var_2 = _getaiarray(var_0);
  var_3 = [];

  for(var_4 = 0; var_4 < var_2.size; var_4++) {
    var_5 = var_2[var_4];

    if(!isDefined(var_5.getentityvelocity)) {
      continue;
    }
    if(var_5.getentityvelocity != var_1) {
      continue;
    }
    var_3[var_3.size] = var_5;
  }

  return var_3;
}

get_all_force_color_friendlies() {
  var_0 = _getaiarray("allies");
  var_1 = [];

  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    var_3 = var_0[var_2];

    if(!isDefined(var_3.getentityvelocity)) {
      continue;
    }
    var_1[var_1.size] = var_3;
  }

  return var_1;
}

get_all_target_ents(var_0) {
  if(!isDefined(var_0)) {
    var_0 = self.target;
  }

  var_1 = [];
  var_2 = getEntArray(var_0, "targetname");
  var_1 = common_scripts\utility::_id_0F73(var_1, var_2);
  var_2 = _getnodearray(var_0, "targetname");
  var_1 = common_scripts\utility::_id_0F73(var_1, var_2);
  var_2 = common_scripts\utility::getstructarray(var_0, "targetname");
  var_1 = common_scripts\utility::_id_0F73(var_1, var_2);
  var_2 = _getvehiclenodearray(var_0, "targetname");
  var_1 = common_scripts\utility::_id_0F73(var_1, var_2);
  return var_1;
}

enable_ai_color() {
  if(isDefined(self.getentityvelocity)) {
    return;
  }
  if(!isDefined(self.old_forcecolor)) {
    return;
  }
  getlightshadowstate(self.old_forcecolor);
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

  if(isDefined(self.freeentitysentient)) {
    _id_2F26(0);
  }

  self clearfixednodesafevolume();

  if(!isDefined(self.getentityvelocity)) {
    return;
  }
  self.old_forcecolor = self.getentityvelocity;
  _id_02A0::remove_ai_from_colors();
}

clear_force_color() {
  disable_ai_color();
}

check_force_color(var_0) {
  var_1 = level.colorchecklist[_tolower(var_0)];

  if(isDefined(self.getentityvelocity) && var_1 == self.getentityvelocity) {
    return 1;
  } else {
    return 0;
  }
}

get_force_color() {
  var_0 = self.getentityvelocity;
  return var_0;
}

getlightshadowstate(var_0) {
  var_1 = _id_02A0::_id_08F9(var_0);
}

_id_57EC(var_0, var_1) {
  _id_02A0::issue_color_orders_generic(var_0, var_1);
}

_id_23AC(var_0, var_1) {
  _id_02A0::clear_color_order_from_team(var_0, var_1);
}

clear_all_color_orders(var_0) {
  foreach(var_2 in level.colorlist) {
    _id_02A0::clear_color_order_from_team(var_2, var_0);
  }
}

replace_on_death() {
  thread _id_02A0::colornode_replace_on_death();
}

disable_replace_on_death() {
  self.replace_on_death = undefined;
  self notify("_disable_reinforcement");
}

stop_replace_on_death() {
  self notify("_disable_reinforcement");
}

_id_93B4(var_0, var_1) {
  thread _id_02A0::colornode_stop_replace_on_death_group(var_0, var_1);
}

spawn_reinforcement(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_3)) {
    var_3 = "allies";
  }

  thread _id_02A0::colornode_spawn_reinforcement(var_3, var_0, var_1, var_2);
}

_id_23C8(var_0) {
  _id_02A0::_id_24FE(var_0);
}

set_promotion_order(var_0, var_1, var_2) {
  _id_02A0::colornode_set_promotion_order(var_0, var_1, var_2);
}

_id_847F(var_0, var_1) {
  _id_02A0::colornode_set_empty_promotion_order(var_0, var_1);
}

has_color() {
  if(_id_02A0::get_team() == "axis") {
    return isDefined(self.stopanimscripted) || isDefined(self.getentityvelocity);
  }

  return isDefined(self.animrelative) || isDefined(self.getentityvelocity);
}

_id_4114() {
  return _id_02A0::get_color_volume_from_trigger_codes();
}

_id_4110() {
  return _id_02A0::get_color_nodes_from_trigger_codes();
}

flashrumbleloop(var_0) {
  var_1 = gettime() + var_0 * 1000;

  while(gettime() < var_1) {
    self playRumbleOnEntity("damage_heavy");
    waitframe();
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

    if(var_9 > var_2) {
      var_2 = var_9;
    }

    if(var_2 < 0.25) {
      var_2 = 0.25;
    }

    var_10 = 0.3;

    if(var_1 > 1 - var_10) {
      var_1 = 1.0;
    } else {
      var_1 = var_1 / (1 - var_10);
    }

    if(var_4 != self.team) {
      var_11 = var_1 * var_2 * 6.0;
    } else {
      var_11 = var_1 * var_2 * 3.0;
    }

    if(var_11 < 0.25) {
      continue;
    }
    var_11 = var_8 * var_11;

    if(isDefined(self.maxflashedseconds) && var_11 > self.maxflashedseconds) {
      var_11 = self.maxflashedseconds;
    }

    self.flashingteam = var_4;
    self notify("flashed");
    self.flashendtime = gettime() + var_11 * 1000;
    self shellshock("flashbang", var_11);
    common_scripts\utility::flag_set("player_flashed");

    if(var_1 * var_2 > 0.5) {
      thread flashmonitorenablehealthshield(var_11);
    }

    wait(var_5[var_12]);
  }

  thread _id_0322::unflash_flag(0.05);
}

flashmonitor() {
  self endon("death");

  for(;;) {
    self waittill("flashbang", var_0, var_1, var_2, var_3, var_4);

    if("1" == getDvar("noflash")) {
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

    if(var_7 > var_2) {
      var_2 = var_7;
    }

    if(var_2 < 0.25) {
      var_2 = 0.25;
    }

    var_8 = 0.3;

    if(var_1 > 1 - var_8) {
      var_1 = 1.0;
    } else {
      var_1 = var_1 / (1 - var_8);
    }

    if(var_4 != self.team) {
      var_9 = var_1 * var_2 * 6.0;
    } else {
      var_9 = var_1 * var_2 * 3.0;
    }

    if(var_9 < 0.25) {
      continue;
    }
    if(isDefined(self.maxflashedseconds) && var_9 > self.maxflashedseconds) {
      var_9 = self.maxflashedseconds;
    }

    self.flashingteam = var_4;
    self notify("flashed");
    self.flashendtime = gettime() + var_9 * 1000;
    self shellshock("flashbang", var_9);
    self lightsetoverrideenableforplayer("flashed", 0.1);
    common_scripts\utility::flag_set("player_flashed");
    thread _id_0322::unflash_flag(var_9);
    wait 0.1;
    self lightsetoverridedisableforplayer(var_9 - 0.1);

    if(var_1 * var_2 > 0.5) {
      thread flashmonitorenablehealthshield(var_9);
    }

    if(var_9 > 2) {
      thread flashrumbleloop(0.75);
    } else {
      thread flashrumbleloop(0.25);
    }

    if(var_4 != "allies") {
      thread flashnearbyallies(var_9, var_4);
    }
  }
}

flashnearbyallies(var_0, var_1) {
  waitframe();
  var_2 = _getaiarray("allies");

  for(var_3 = 0; var_3 < var_2.size; var_3++) {
    if(distancesquared(var_2[var_3].origin, self.origin) < 122500) {
      var_4 = var_0 + _randomfloatrange(-1000, 1500);

      if(var_4 > 4.5) {
        var_4 = 4.5;
      } else if(var_4 < 0.25) {
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
      foreach(var_3 in var_1) {
        var_3 common_scripts\utility::pauseeffect();
      }

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
      foreach(var_3 in var_1) {
        var_3 restarteffect();
      }

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

    if(isDefined(var_2)) {
      var_1 = var_2;
    }
  } else {
    for(var_3 = 0; var_3 < level.createfxent.size; var_3++) {
      if(level.createfxent[var_3].v["fxid"] == var_0) {
        var_1[var_1.size] = level.createfxent[var_3];
      }
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
    _createthreatbiasgroup("ignore_everybody");
    self setthreatbiasgroup("ignore_everybody");
    var_2 = [];
    var_2["axis"] = "allies";
    var_2["allies"] = "axis";
    var_3 = _getaiarray(var_2[self.team]);
    var_4 = [];

    for(var_5 = 0; var_5 < var_3.size; var_5++) {
      var_4[var_3[var_5] getthreatbiasgroup()] = 1;
    }

    var_6 = getarraykeys(var_4);

    for(var_5 = 0; var_5 < var_6.size; var_5++) {
      _setthreatbias(var_6[var_5], "ignore_everybody", 0);
    }
  } else {
    var_1 = undefined;

    if(self.old_threat_bias_group != "") {
      self setthreatbiasgroup(self.old_threat_bias_group);
    }

    self.old_threat_bias_group = undefined;
  }
}

vehicle_detachfrompath() {
  _id_032A::_id_A380();
}

vehicle_resumepath() {
  thread _id_032A::_id_A39B();
}

vehicle_land(var_0) {
  _id_032A::_id_A35A(var_0);
}

vehicle_liftoff(var_0) {
  _id_032A::_id_A361(var_0);
}

vehicle_dynamicpath(var_0, var_1) {
  _id_0323::vehicle_paths(var_0, var_1);
}

groundpos(var_0) {
  return bulletTrace(var_0, var_0 + (0, 0, -100000), 0, self)["position"];
}

change_player_health_packets(var_0) {
  self.player_health_packets = self.player_health_packets + var_0;
  self notify("update_health_packets");

  if(self.player_health_packets >= 3) {
    self.player_health_packets = 3;
  }
}

getvehiclespawner(var_0) {
  var_1 = getvehiclespawnerarray(var_0);
  return var_1[0];
}

getvehiclespawnerarray(var_0) {
  return _id_032A::_id_063F(var_0);
}

describe_start(var_0, var_1, var_2, var_3, var_4, var_5) {
  _id_0967();

  if(!isDefined(level.start_description)) {
    level.start_description = [];
  }

  level.start_description[var_0] = _id_0968(var_0, var_1, var_2, var_3, [var_4], var_5);
}

_id_0966(var_0, var_1, var_2, var_3, var_4, var_5) {
  _id_0967();
  var_0 = _tolower(var_0);

  if(isDefined(var_4)) {
    if(var_4.size > 2) {
      var_6 = [];
      var_6[0] = var_4[0];
      var_6[1] = var_4[1];
      var_4 = var_6;
    }

    if(!isDefined(level.start_transients)) {
      level.start_transients = [];
    }

    foreach(var_8 in var_4) {
      if(!common_scripts\utility::_id_0F79(level.start_transients, var_8)) {
        level.start_transients[level.start_transients.size] = var_8;
      }
    }
  }

  if(isDefined(level.start_description) && isDefined(level.start_description[var_0])) {
    var_11 = level.start_description[var_0];
  } else {
    var_11 = _id_0968(var_0, var_1, var_2, var_3, var_4, var_5);
  }

  if(!isDefined(var_1)) {
    if(!isDefined(level.start_description)) {} else if(!issubstr(var_0, "no_game")) {
      if(!isDefined(level.start_description[var_0])) {
        return;
      }
    }
  }

  level.start_functions[level.start_functions.size] = var_11;
  level.start_arrays[var_0] = var_11;
}

_id_096A(var_0, var_1, var_2, var_3) {
  if(isDefined(var_1)) {
    level.start_arrays[var_0]["visionset"] = var_1;
  }

  if(isDefined(var_2)) {
    level.start_arrays[var_0]["lightset"] = var_2;
  }

  if(isDefined(var_3)) {
    level.start_arrays[var_0]["clut"] = var_3;
  }
}

set_start_transients(var_0, var_1) {
  if(!isDefined(level.start_arrays)) {
    return;
  }
  if(!isDefined(level.start_arrays[var_0])) {
    return;
  }
  var_0 = _tolower(var_0);

  if(var_1.size > 2) {
    var_2 = [];
    var_2[0] = var_1[0];
    var_2[1] = var_1[1];
    var_1 = var_2;
  }

  if(!isDefined(level.start_transients)) {
    level.start_transients = [];
  }

  foreach(var_4 in var_1) {
    if(!common_scripts\utility::_id_0F79(level.start_transients, var_4)) {
      level.start_transients[level.start_transients.size] = var_4;
    }
  }

  level.start_arrays[var_0]["transients_to_load"] = var_1;
}

is_no_game_start() {
  return issubstr(level.start_point, "no_game");
}

_id_0968(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = [];
  var_6["name"] = var_0;
  var_6["start_func"] = var_1;
  var_6["start_loc_string"] = var_2;
  var_6["logic_func"] = var_3;
  var_6["transients_to_load"] = var_4;
  var_6["catchup_function"] = var_5;
  return var_6;
}

_id_0967() {
  if(!isDefined(level.start_functions)) {
    level.start_functions = [];
  }
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
  thread _id_0322::linetime_proc(var_0, var_1, var_2, var_3);
}

within_fov_2d(var_0, var_1, var_2, var_3) {
  var_4 = vectorNormalize((var_2[0], var_2[1], 0) - (var_0[0], var_0[1], 0));
  var_5 = anglesToForward((0, var_1[1], 0));
  return vectordot(var_5, var_4) >= var_3;
}

get_dot(var_0, var_1, var_2) {
  var_3 = vectorNormalize(var_2 - var_0);
  var_4 = anglesToForward(var_1);
  var_5 = vectordot(var_4, var_3);
  return var_5;
}

within_fov_of_players(var_0, var_1) {
  var_2 = undefined;

  for(var_3 = 0; var_3 < level.players.size; var_3++) {
    var_4 = level.players[var_3] getEye();
    var_2 = common_scripts\utility::within_fov(var_4, level.players[var_3] getplayerangles(), var_0, var_1);

    if(!var_2) {
      return 0;
    }
  }

  return 1;
}

wait_for_buffer_time_to_pass(var_0, var_1) {
  var_2 = var_1 * 1000 - (gettime() - var_0);
  var_2 = var_2 * 0.001;

  if(var_2 > 0) {
    wait(var_2);
  }
}

bcs_scripted_dialogue_start() {
  anim.hasweapon = gettime();
}

dialogue_queue(var_0) {
  if(!isDefined(level._id_6F46)) {
    level._id_6F46 = 0;
  }

  level._id_6F46++;

  if(self == level) {
    var_1 = level.player;
  } else {
    var_1 = self;
  }

  if(isDefined(var_1.dds_characterid) && _id_02A8::talker_is_talking_currently(var_1)) {
    level notify("dialogue started");
  }

  var_2 = _getsndaliasvalue(var_0, "squelchname");

  if(self == level || isDefined(var_2) && var_2 != "" || isDefined(level.player) && self == level.player) {
    if(isDefined(_id_037B::_id_77D8())) {
      _id_037B::_id_8DB8(1);
    }

    radio_dialogue(var_0, undefined, var_2);

    if(isDefined(_id_037B::_id_77D8())) {
      _id_037B::_id_8DB8(0);
    }

    level._id_6F46--;
    return;
  }

  bcs_scripted_dialogue_start();

  if(var_1 != level.player && (!isDefined(self._id_0EC4) || !isDefined(level.scr_sound[self._id_0EC4]) || !isDefined(level.scr_sound[self._id_0EC4][var_0]))) {
    animscripts\face::playfacethread("auto", var_0, 1, var_0);
    var_3 = 0;
  } else
    _id_0293::_id_0E76(self, var_0);

  level._id_6F46--;
}

_id_2EC7(var_0, var_1) {
  var_2 = _getsndaliasvalue(var_0, "squelchname");

  if(self == level || isDefined(var_2) && var_2 != "" || isDefined(level.player) && self == level.player) {
    if(isDefined(_id_037B::_id_77D8())) {
      _id_037B::_id_8DB8(1);
    }

    radio_dialogue(var_0, undefined, var_2);

    if(isDefined(_id_037B::_id_77D8())) {
      _id_037B::_id_8DB8(0);
    }

    return;
  }

  thread _id_0290::_id_0AD1(var_1, 1);
  bcs_scripted_dialogue_start();
  _id_0293::_id_0E76(self, var_0);
  thread _id_0290::_id_0AD1(var_1, 0);
}

generic_dialogue_queue(var_0, var_1) {
  bcs_scripted_dialogue_start();
  _id_0293::_id_0E0E(self, var_0, undefined, undefined, var_1);
}

radio_dialogue(var_0, var_1, var_2) {
  if(!isDefined(level.player_radio_emitter)) {
    var_3 = spawn("script_origin", (0, 0, 0));
    var_3 linkTo(level.player, "", (0, 0, 0), (0, 0, 0));
    level.player_radio_emitter = var_3;
  }

  bcs_scripted_dialogue_start();

  if(!isDefined(var_1)) {
    return level.player_radio_emitter function_stack(::radio_dialogue_play, var_0, var_2);
  } else {
    return level.player_radio_emitter function_stack_timeout(var_1, ::radio_dialogue_play, var_0, var_2);
  }
}

radio_dialogue_play(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = "none";
  }

  level.player_radio_squelch_out_queued = 0;

  if(var_1 != "none" && isDefined(level.forceusehintoff["squelches"][var_1])) {
    play_sound_on_tag(level.forceusehintoff["squelches"][var_1]["on"], undefined, 1);
  }

  var_2 = 0;
  level.player notify(var_0);

  if(isDefined(level.forceusehintoff[var_0])) {
    var_2 = play_sound_on_tag(level.forceusehintoff[var_0], undefined, 1);
  } else {
    var_2 = play_sound_on_tag(var_0, undefined, 1);
  }

  if(var_1 != "none" && isDefined(level.forceusehintoff["squelches"][var_1])) {
    thread radio_try_squelch_out(var_1);
  }

  return var_2;
}

radio_dialogue_overlap(var_0) {
  if(!isDefined(level.player_radio_emitter_overlap)) {
    level.player_radio_emitter_overlap = [];
  }

  var_1 = spawn("script_origin", (0, 0, 0));
  level.player_radio_emitter_overlap[level.player_radio_emitter_overlap.size] = var_1;
  var_1 endon("death");
  thread delete_on_death_wait_sound(var_1, "sounddone");
  var_1.origin = level.player_radio_emitter.origin;
  var_1.angles = level.player_radio_emitter.angles;
  var_1 linkTo(level.player_radio_emitter);
  var_1 playSound(level.forceusehintoff[var_0], "sounddone");

  if(!isDefined(_id_0322::wait_for_sounddone_or_death(var_1))) {
    var_1 stopsounds();
  }

  waitframe();
  level.player_radio_emitter_overlap = common_scripts\utility::_id_0F93(level.player_radio_emitter_overlap, var_1);
  var_1 delete();
}

radio_dialogue_stop() {
  if(!isDefined(level.player_radio_emitter)) {
    return;
  }
  level.player_radio_emitter delete();
}

radio_dialogue_overlap_stop() {
  if(!isDefined(level.player_radio_emitter_overlap)) {
    return;
  }
  foreach(var_1 in level.player_radio_emitter_overlap) {
    if(isDefined(var_1)) {
      var_1 stopsounds();
      waitframe();
      var_1 delete();
    }
  }

  level.player_radio_emitter_overlap = undefined;
}

radio_dialogue_clear_stack() {
  if(!isDefined(level.player_radio_emitter)) {
    return;
  }
  level.player_radio_emitter function_stack_clear();
}

radio_dialogue_remove_from_stack(var_0) {
  if(!isDefined(level.player_radio_emitter)) {
    return;
  }
  if(!isDefined(level.player_radio_emitter.function_stack)) {
    return;
  }
  var_1 = [];
  var_2 = 0;
  var_3 = level.player_radio_emitter.function_stack.size;

  for(var_4 = 0; var_4 < var_3; var_4++) {
    if(var_4 == 0 && isDefined(level.player_radio_emitter.function_stack[0].function_stack_func_begun) && isDefined(level.player_radio_emitter.function_stack[0].function_stack_func_begun)) {
      var_1[var_1.size] = level.player_radio_emitter.function_stack[var_4];
      continue;
    }

    if(isDefined(level.player_radio_emitter.function_stack[var_4].param1) && level.player_radio_emitter.function_stack[var_4].param1 == var_0) {
      level.player_radio_emitter.function_stack[var_4] notify("death");
      level.player_radio_emitter.function_stack[var_4] = undefined;
      var_2 = 1;
      continue;
    }

    var_1[var_1.size] = level.player_radio_emitter.function_stack[var_4];
  }

  if(var_2) {
    level.player_radio_emitter.function_stack = var_1;
  }
}

radio_dialogue_interupt(var_0) {
  if(!isDefined(level.player_radio_emitter)) {
    var_1 = spawn("script_origin", (0, 0, 0));
    var_1 linkTo(level.player, "", (0, 0, 0), (0, 0, 0));
    level.player_radio_emitter = var_1;
  }

  level.player_radio_emitter play_sound_on_tag(level.forceusehintoff[var_0], undefined, 1);
}

radio_dialogue_safe(var_0) {
  return radio_dialogue(var_0, 0.05);
}

smart_radio_dialogue(var_0, var_1) {
  var_2 = _getsndaliasvalue(var_0, "squelchname");
  _id_0322::_id_097A(var_0);
  radio_dialogue(var_0, var_1, var_2);
}

smart_radio_dialogue_interrupt(var_0) {
  _id_0322::_id_097A(var_0);
  radio_dialogue_stop();
  radio_dialogue_interupt(var_0);
}

smart_radio_dialogue_overlap(var_0) {
  _id_0322::_id_097A(var_0);
  radio_dialogue_overlap(var_0);
}

smart_dialogue(var_0) {
  _id_0322::_id_0977(var_0);
  dialogue_queue(var_0);
}

smart_dialogue_generic(var_0) {
  _id_0322::_id_0978(var_0);
  generic_dialogue_queue(var_0);
}

radio_try_squelch_out(var_0, var_1) {
  self endon("death");

  if(!isDefined(var_1)) {
    var_1 = 0.1;
  }

  level.player_radio_squelch_out_queued = 1;
  wait(var_1);

  if(isDefined(level.player_radio_emitter) && level.player_radio_squelch_out_queued == 1) {
    level.player_radio_emitter function_stack(::play_sound_on_tag, level.forceusehintoff["squelches"][var_0]["off"], undefined, 1);
  }
}

radio_dialogue_queue(var_0, var_1) {
  radio_dialogue(var_0, undefined, var_1);
}

hint_create(var_0, var_1, var_2) {
  var_3 = spawnStruct();

  if(isDefined(var_1) && var_1 == 1) {
    var_3.bg = newhudelem();
  }

  var_3.elm = newhudelem();
  var_3 hint_position_internal(var_2);
  var_3.elm settext(var_0);
  return var_3;
}

hint_delete() {
  self notify("death");

  if(isDefined(self.elm)) {
    self.elm destroy();
  }

  if(isDefined(self.bg)) {
    self.bg destroy();
  }
}

hint_position_internal(var_0) {
  if(level.console) {
    self.elm.fontscale = 2;
  } else {
    self.elm.fontscale = 1.6;
  }

  self.elm.x = 0;
  self.elm.y = -40;
  self.elm.alignx = "center";
  self.elm.aligny = "bottom";
  self.elm._id_00C6 = "center";
  self.elm._id_01CA = "middle";
  self.elm.sort = 1;
  self.elm.alpha = 0.8;

  if(!isDefined(self.bg)) {
    return;
  }
  self.bg.x = 0;
  self.bg.y = -40;
  self.bg.alignx = "center";
  self.bg.aligny = "middle";
  self.bg._id_00C6 = "center";
  self.bg._id_01CA = "middle";
  self.bg.sort = -1;

  if(level.console) {
    self.bg setshader("popmenu_bg", 650, 52);
  } else {
    self.bg setshader("popmenu_bg", 650, 42);
  }

  if(!isDefined(var_0)) {
    var_0 = 0.5;
  }

  self.bg.alpha = var_0;
}

string(var_0) {
  return "" + var_0;
}

is_string_a_number(var_0) {
  var_1 = _float(var_0);

  if(_func_2C6(var_0, " ")) {
    while(_func_2C6(var_0, " ")) {
      var_0 = getsubstr(var_0, 1, 9999);
    }
  }

  if(_func_2C6(var_0, "-.") || _func_2C6(var_0, ".")) {
    var_0 = "0" + string(var_0);
  }

  if(issubstr(var_0, ".")) {
    while(_isendstr(var_0, "0")) {
      var_0 = _func_2FF(var_0, "0");
    }
  } else
    var_0 = string(var_0);

  return string(var_1) == var_0;
}

ignoreeachother(var_0, var_1) {
  _setignoremegroup(var_0, var_1);
  _setignoremegroup(var_1, var_0);
}

_id_092D(var_0, var_1, var_2, var_3, var_4) {
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
    if(level.spawn_funcs[var_0][var_3]["function"] != var_1) {
      var_2[var_2.size] = level.spawn_funcs[var_0][var_3];
    }
  }

  level.spawn_funcs[var_0] = var_2;
}

exists_global_spawn_function(var_0, var_1) {
  if(!isDefined(level.spawn_funcs)) {
    return 0;
  }

  for(var_2 = 0; var_2 < level.spawn_funcs[var_0].size; var_2++) {
    if(level.spawn_funcs[var_0][var_2]["function"] == var_1) {
      return 1;
    }
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

_id_0961(var_0, var_1, var_2, var_3, var_4, var_5) {
  foreach(var_7 in self.spawn_functions) {
    if(var_7["function"] == var_0) {
      return;
    }
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

_id_091B(var_0, var_1, var_2, var_3, var_4, var_5) {
  foreach(var_7 in self._id_2A87) {
    if(var_7["function"] == var_0) {
      return;
    }
  }

  var_9 = [];
  var_9["function"] = var_0;
  var_9["param1"] = var_1;
  var_9["param2"] = var_2;
  var_9["param3"] = var_3;
  var_9["param4"] = var_4;
  var_9["param5"] = var_5;
  self._id_2A87[self._id_2A87.size] = var_9;
}

_id_0F7B(var_0) {
  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    var_0[var_1] delete();
  }
}

_id_0F87(var_0) {
  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    var_0[var_1] kill();
  }
}

ignore_triggers(var_0) {
  self endon("death");
  self._id_00D3 = 1;

  if(isDefined(var_0)) {
    wait(var_0);
  } else {
    wait 0.5;
  }

  self._id_00D3 = 0;
}

_id_08A3(var_0) {
  var_1 = _getEnt(var_0, "targetname");

  if(isDefined(var_1)) {
    var_1 _id_089F();
  }
}

_id_08A2(var_0) {
  var_1 = _getEnt(var_0, "script_noteworthy");

  if(isDefined(var_1)) {
    var_1 _id_089F();
  }
}

disable_trigger_with_targetname(var_0) {
  var_1 = _getEnt(var_0, "targetname");
  var_1 common_scripts\utility::trigger_off();
}

disable_trigger_with_noteworthy(var_0) {
  var_1 = _getEnt(var_0, "script_noteworthy");
  var_1 common_scripts\utility::trigger_off();
}

enable_trigger_with_targetname(var_0) {
  var_1 = _getEnt(var_0, "targetname");
  var_1 common_scripts\utility::trigger_on();
}

enable_trigger_with_noteworthy(var_0) {
  var_1 = _getEnt(var_0, "script_noteworthy");
  var_1 common_scripts\utility::trigger_on();
}

is_hero() {
  return isDefined(level.hero_list[get_ai_number()]);
}

get_ai_number() {
  if(!isDefined(self.unique_id)) {
    screenshakeonentity();
  }

  return self.unique_id;
}

screenshakeonentity() {
  self.unique_id = "ai" + level._id_0AB5;
  level._id_0AB5++;
}

make_hero() {
  level.hero_list[self.unique_id] = 1;
}

unmake_hero() {
  level.hero_list[self.unique_id] = undefined;
}

get_heroes() {
  var_0 = [];
  var_1 = _getaiarray("allies");

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    if(var_1[var_2] is_hero()) {
      var_0[var_0.size] = var_1[var_2];
    }
  }

  return var_0;
}

set_team_pacifist(var_0, var_1) {
  var_2 = _getaiarray(var_0);

  for(var_3 = 0; var_3 < var_2.size; var_3++) {
    var_2[var_3]._id_0118 = var_1;
  }
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

    if(!isDefined(var_4.getentityvelocity)) {
      continue;
    }
    if(var_4.getentityvelocity == var_1) {
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

    if(!isDefined(var_4._id_0165)) {
      continue;
    }
    if(var_4._id_0165 == var_1) {
      continue;
    }
    var_2[var_2.size] = var_4;
  }

  return var_2;
}

get_closest_colored_friendly(var_0, var_1) {
  var_2 = get_force_color_guys("allies", var_0);
  var_2 = remove_heroes_from_array(var_2);

  if(!isDefined(var_1)) {
    var_3 = level.player.origin;
  } else {
    var_3 = var_1;
  }

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

  if(!isDefined(var_2)) {
    var_4 = level.player.origin;
  } else {
    var_4 = var_2;
  }

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

    var_2 getlightshadowstate(var_1);
    return;
  }
}

instantly_promote_nearest_friendly(var_0, var_1) {
  for(;;) {
    var_2 = get_closest_colored_friendly(var_0);

    if(!isalive(var_2)) {
      return;
    }
    var_2 getlightshadowstate(var_1);
    return;
  }
}

instantly_promote_nearest_friendly_with_classname(var_0, var_1, var_2) {
  for(;;) {
    var_3 = get_closest_colored_friendly_with_classname(var_0, var_2);

    if(!isalive(var_3)) {
      return;
    }
    var_3 getlightshadowstate(var_1);
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

    var_3 getlightshadowstate(var_1);
    return;
  }
}

riotshield_lock_orientation(var_0) {
  self orientmode("face angle", var_0);
  self._id_00EE = 1;
}

riotshield_unlock_orientation() {
  self._id_00EE = 0;
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
    var_6 getlightshadowstate(var_1);
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
    var_5 getlightshadowstate(var_1);
  }

  return var_3;
}

wait_for_script_noteworthy_trigger(var_0) {
  _id_0322::wait_for_trigger(var_0, "script_noteworthy");
}

wait_for_targetname_trigger(var_0) {
  _id_0322::wait_for_trigger(var_0, "targetname");
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
  var_3 = common_scripts\utility::_id_0F73(var_3, getEntArray(var_0, "targetname"));
  var_3 = common_scripts\utility::_id_0F73(var_3, getEntArray(var_1, "targetname"));

  for(var_4 = 0; var_4 < var_3.size; var_4++) {
    var_2 thread _id_0322::ent_waits_for_trigger(var_3[var_4]);
  }

  var_2 waittill("done");
}

dronespawn_bodyonly(var_0) {
  var_1 = _id_02FC::spawner_dronespawn(var_0);
  return var_1;
}

dronespawn(var_0) {
  if(!isDefined(var_0)) {
    var_0 = self;
  }

  var_1 = _id_02FC::spawner_dronespawn(var_0);
  var_1[[level.drone_spawn_func]]();
  var_1.spawn_funcs = var_0.spawn_functions;
  var_1 thread _id_02FC::run_spawn_functions();
  var_1._id_0186 = var_0;
  return var_1;
}

swap_ai_to_drone(var_0) {
  return _id_02FC::_id_9056(var_0);
}

swap_drone_to_ai(var_0) {
  return _id_02FC::spawner_swap_drone_to_ai(var_0);
}

set_default_pathenemy_settings() {
  if(_id_0290::_id_0AAE() && self.type != "dog" && self.type != "civilian") {
    self._id_011E = animscripts\shg_asm\soldier\common\shared::_id_428A();
    self._id_011D = animscripts\shg_asm\soldier\common\shared::_id_4289();
  } else {
    self._id_011E = 192;
    self._id_011D = 192;
  }
}

cqb_walk(var_0) {
  if(var_0 == "on") {
    enable_cqbwalk();
  } else {
    disable_cqbwalk();
  }
}

enable_cqbwalk() {
  if(self.type == "dog" || self.type == "civilian") {
    return;
  }
  _id_0290::_id_0AD4("walk");
}

disable_cqbwalk() {
  _id_0290::_id_0AD4("none");
}

_id_3641() {
  enable_cqbwalk();
  var_0 = "sneak";

  if(animscripts\shg_asm\soldier\common\shared::_id_560C()) {
    var_0 = "smg_sneak";
  }

  _id_0290::_id_0AD3(var_0);
}

_id_2F5A() {
  disable_cqbwalk();
  _id_0290::_id_0AC3();
}

_id_3624() {
  if(self.type == "dog" || self.type == "civilian") {
    return;
  }
  _id_0290::_id_0ACF(1);
}

_id_2F3B() {
  if(self.type == "dog" || self.type == "civilian") {
    return;
  }
  _id_0290::_id_0ACF(0);
}

_id_3640() {
  if(self.type == "dog") {
    return;
  }
  _id_0290::_id_0A9E(1);
}

_id_2F59() {
  if(self.type == "dog") {
    return;
  }
  _id_0290::_id_0A9E(0);
}

enable_readystand() {
  self.busereadyidle = 1;
}

disable_readystand() {
  self.busereadyidle = undefined;
}

cqb_aim(var_0) {
  if(!isDefined(var_0)) {
    self.cqb_target = undefined;
  } else {
    self.cqb_target = var_0;

    if(!isDefined(var_0.origin)) {
      return;
    }
  }
}

forceviewmodelanimationclear(var_0) {
  if(isDefined(var_0) && var_0) {
    self.forcesuppression = 1;
  } else {
    self.forcesuppression = undefined;
  }
}

do_in_order(var_0, var_1, var_2, var_3) {
  if(isDefined(var_1)) {
    [[var_0]](var_1);
  } else {
    [[var_0]]();
  }

  if(isDefined(var_3)) {
    [[var_2]](var_3);
  } else {
    [[var_2]]();
  }
}

setanimstate(var_0, var_1) {
  if(isDefined(var_1)) {
    self notify(var_0, var_1);
  } else {
    self notify(var_0);
  }
}

waittill_match_or_timeout(var_0, var_1, var_2) {
  var_3 = spawnStruct();
  var_3 endon("complete");
  var_3 delaythread(var_2, ::setanimstate, "complete");
  self waittillmatch(var_0, var_1);
  return var_0;
}

deleteent(var_0) {
  var_0 notify("deleted");
  var_0 delete();
}

first_touch(var_0) {
  if(!isDefined(self.touched)) {
    self.touched = [];
  }

  if(isDefined(self.touched[var_0.unique_id])) {
    return 0;
  }

  self.touched[var_0.unique_id] = 1;
  return 1;
}

getanim(var_0) {
  return level.settenthstimer[self._id_0EC4][var_0];
}

hasanim(var_0) {
  return isDefined(level.settenthstimer[self._id_0EC4][var_0]);
}

getanim_from_animname(var_0, var_1) {
  return level.settenthstimer[var_1][var_0];
}

getanim_generic(var_0) {
  return level.settenthstimer["generic"][var_0];
}

_id_0930(var_0, var_1, var_2) {
  if(!isDefined(level.trigger_hint_string)) {
    level.trigger_hint_string = [];
    level.trigger_hint_func = [];
  }

  level.trigger_hint_string[var_0] = var_1;
  precachestring(var_1);

  if(isDefined(var_2)) {
    level.trigger_hint_func[var_0] = var_2;
  }
}

show_hint(var_0) {
  thread _id_0322::showhintprint_struct(var_0);
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
  _setthreatbias(var_0, var_1, 0);
  _setthreatbias(var_1, var_0, 0);
}

_id_99AA() {}

_id_0F74(var_0, var_1) {
  if(!var_0.size) {
    return var_1;
  }

  var_2 = getarraykeys(var_1);

  for(var_3 = 0; var_3 < var_2.size; var_3++) {
    var_0[var_2[var_3]] = var_1[var_2[var_3]];
  }

  return var_0;
}

set_ignoresuppression(var_0) {
  self._id_00D2 = var_0;
}

setadditiveviewmodelanim(var_0) {
  self._id_00AE = var_0;
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
  self._id_0013 = var_0;
}

set_run_anim(var_0, var_1, var_2) {
  if(_id_0290::_id_0AAE()) {
    _id_0290::_id_0AD5(var_0, var_1, var_2);
    return;
  }

  if(isDefined(var_1)) {
    self._id_0CB6 = var_1;
  } else {
    self._id_0CB6 = 1;
  }

  disable_turnanims();
  self.run_overrideanim = level.settenthstimer[self._id_0EC4][var_0];
  self.walk_overrideanim = self.run_overrideanim;
}

_id_8474() {
  self._id_0794.movement = "walk";
  _id_0290::_id_0ACD("arrivals", 0);
  _id_0290::_id_0ACD("exits", 0);
  self.sayteam = 1;
}

_id_8439(var_0, var_1, var_2, var_3) {}

_id_852F(var_0, var_1, var_2) {}

set_generic_idle_anim(var_0) {
  var_1 = level.settenthstimer["generic"][var_0];

  if(_isarray(var_1)) {
    self.specialidleanim = var_1;
  } else {
    self.specialidleanim[0] = var_1;
  }
}

set_idle_anim(var_0) {
  var_1 = level.settenthstimer[self._id_0EC4][var_0];

  if(_isarray(var_1)) {
    self.specialidleanim = var_1;
  } else {
    self.specialidleanim[0] = var_1;
  }
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

  if(!isDefined(var_2) || var_2) {
    self._id_0CB6 = 1;
  } else {
    self._id_0CB6 = undefined;
  }

  disable_turnanims();
  self.run_overrideanim = level.settenthstimer["generic"][var_0];
  self.walk_overrideanim = self.run_overrideanim;

  if(isDefined(var_1)) {
    self.run_override_weights = level.settenthstimer["generic"][var_1];
    self.walk_override_weights = self.run_override_weights;
  } else {
    self.run_override_weights = undefined;
    self.walk_override_weights = undefined;
  }
}

set_run_anim_array(var_0, var_1, var_2) {
  self notify("movemode");

  if(!isDefined(var_2) || var_2) {
    self._id_0CB6 = 1;
  } else {
    self._id_0CB6 = undefined;
  }

  disable_turnanims();
  self.run_overrideanim = level.settenthstimer[self._id_0EC4][var_0];
  self.walk_overrideanim = self.run_overrideanim;

  if(isDefined(var_1)) {
    self.run_override_weights = level.settenthstimer[self._id_0EC4][var_1];
    self.walk_override_weights = self.run_override_weights;
  } else {
    self.run_override_weights = undefined;
    self.walk_override_weights = undefined;
  }
}

clear_run_anim(var_0) {
  if(_id_0290::_id_0AAE()) {
    _id_0290::_id_0A79(var_0);
  } else {
    self notify("clear_run_anim");
    self notify("movemode");

    if(self.type == "dog") {
      self._id_0794.movement = "run";
      _id_0290::_id_0ACD("arrivals", 1);
      _id_0290::_id_0ACD("exits", 1);
      self.sayteam = undefined;
      return;
    }

    if(!isDefined(self.casual_killer)) {
      enable_turnanims();
    }

    self._id_0CB6 = undefined;
    self.run_overrideanim = undefined;
    self.walk_overrideanim = undefined;
    self.run_override_weights = undefined;
    self.walk_override_weights = undefined;
  }
}

debugvar(var_0, var_1) {
  setdvarifuninitialized(var_0, var_1);
  return getdvarfloat(var_0);
}

physicsjolt_proximity(var_0, var_1, var_2) {
  self endon("parked");
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

    if(self._id_003B == "script_vehicle") {
      var_6 = self vehicle_getspeed();

      if(var_6 < var_4) {
        var_7 = var_6 / var_4;
        var_2 = var_5 * var_7;
      }
    }

    var_8 = distancesquared(self.origin, level.player.origin);
    var_7 = var_3 / var_8;

    if(var_7 > 1) {
      var_7 = 1;
    }

    var_2 = var_2 * var_7;
    var_9 = var_2[0] + var_2[1] + var_2[2];

    if(var_9 > 0.025) {
      _physicsjitter(self.origin, var_0, var_1, var_2[2], var_2[2] * 2.0);
    }
  }
}

getbottomarc(var_0) {
  self setgoalentity(var_0);
}

_id_089F(var_0, var_1, var_2) {
  if(!isDefined(var_0)) {
    _id_08A1(var_2);
  } else {
    common_scripts\utility::_id_0FB2(getEntArray(var_0, var_1), ::_id_08A1, var_2);
  }
}

_id_08A1(var_0) {
  self notify("trigger", var_0);
}

getmodelfromentity() {
  self delete();
}

remove_nocolor_from_array(var_0) {
  var_1 = [];

  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    var_3 = var_0[var_2];

    if(var_3 has_color()) {
      var_1[var_1.size] = var_3;
    }
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

  if(var_1 > 0) {
    wait(var_1);
  }

  if(!isDefined(self)) {
    return;
  }
  self notify(var_0);
}

_id_48D9() {
  if(!isDefined(self._id_01D0) || self._id_01D0 == "none") {
    return;
  }
  if(_isai(self)) {
    animscripts\shared::placeweaponon(self._id_01D0, "none");
  } else if(!isDefined(self._id_48DA) && self._id_01D0 != "none") {
    self._id_48DA = 1;
    detach_attachments_from_weapon_model(self._id_01D0);
    self detach(_getweaponmodel(self._id_01D0), "tag_weapon_right");
  }
}

gun_recall() {
  if(_isai(self)) {
    if(isDefined(self.lastweapon) && self._id_01D0 != self.lastweapon) {
      self._id_01D0 = self.lastweapon;
    }

    animscripts\shared::placeweaponon(self._id_01D0, "right");
  } else if(isDefined(self._id_48DA)) {
    self._id_48DA = undefined;
    self attach(_getweaponmodel(self._id_01D0), "tag_weapon_right");
    update_weapon_tag_visibility(self._id_01D0);
  }
}

update_weapon_tag_visibility(var_0) {
  if(isDefined(var_0) && var_0 != "none") {
    var_1 = _getweaponandattachmentmodels(var_0);
    var_2 = common_scripts\utility::_id_0F9A(var_1, 0);

    foreach(var_4 in var_2) {
      self attach(var_4["worldModel"], var_4["worldAttachTag"]);
    }

    self hideweapontags(var_0);
  }
}

detach_attachments_from_weapon_model(var_0) {
  if(isDefined(var_0) && var_0 != "none") {
    var_1 = _getweaponandattachmentmodels(var_0);
    var_2 = common_scripts\utility::_id_0F9A(var_1, 0);

    foreach(var_4 in var_2) {
      self detach(var_4["worldModel"], var_4["worldAttachTag"], 0);
    }
  }
}

attach_player_current_weapon_to_rig(var_0) {
  var_1 = level.player getcurrentweapon();
  var_2 = _getweaponandattachmentmodels(var_1);
  var_3 = var_2[0]["weapon"];
  var_4 = common_scripts\utility::_id_0F9A(var_2, 0);
  var_0 attach(var_3, "TAG_WEAPON_RIGHT", 1);

  foreach(var_6 in var_4) {
    var_0 attach(var_6["attachment"], var_6["attachTag"]);
  }

  var_0 hideweapontags(var_1);
}

place_weapon_on(var_0, var_1) {
  if(!animscripts\shared::_id_0B59(var_0)) {
    animscripts\init::initweapon(var_0);
  }

  animscripts\shared::placeweaponon(var_0, var_1);
}

forceuseweapon(var_0, var_1, var_2) {
  if(!animscripts\init::isweaponinitialized(var_0)) {
    animscripts\init::initweapon(var_0);
  }

  var_3 = self._id_01D0 != "none";
  var_4 = 0;
  var_5 = var_1 == "sidearm";
  var_6 = var_1 == "secondary";

  if(var_3 && var_4 != var_5) {
    if(var_4) {
      var_7 = "none";
    } else if(var_6) {
      var_7 = "back";
    } else {
      var_7 = "chest";
    }

    animscripts\shared::placeweaponon(self._id_01D0, var_7);
    self.lastweapon = self._id_01D0;
  } else
    self.lastweapon = var_0;

  animscripts\shared::placeweaponon(var_0, "right");

  if(var_5) {
    self.sidearm = var_0;
  } else if(var_6) {
    self.botclearscriptenemy = var_0;
  } else {
    self.primaryweapon = var_0;
  }

  self._id_01D0 = var_0;
  self.bulletsinclip = _weaponclipsize(self._id_01D0);
  animscripts\shg_asm\asm_init::_id_1074(var_2);
  self notify("weapon_switch_done");
}

lerp_player_view_to_tag(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  _id_0322::lerp_player_view_to_tag_internal(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, 0);
}

lerp_player_view_to_tag_and_hit_geo(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  _id_0322::lerp_player_view_to_tag_internal(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, 1);
}

lerp_player_view_to_position(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  var_9 = get_player_from_self();
  var_10 = spawn("script_origin", (0, 0, 0));
  var_10.origin = var_9.origin;
  var_10.angles = var_9 getplayerangles();

  if(isDefined(var_8) && var_8) {
    var_9 playerlinkTo(var_10, "", var_3, var_4, var_5, var_6, var_7, var_8);
  } else if(isDefined(var_4)) {
    var_9 playerlinkTo(var_10, "", var_3, var_4, var_5, var_6, var_7);
  } else if(isDefined(var_3)) {
    var_9 playerlinkTo(var_10, "", var_3);
  } else {
    var_9 playerlinkTo(var_10);
  }

  var_10 moveTo(var_0, var_2, var_2 * 0.25);
  var_10 rotateTo(var_1, var_2, var_2 * 0.25);
  wait(var_2);
  var_10 delete();
}

lerp_player_view_to_tag_oldstyle(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  _id_0322::lerp_player_view_to_tag_oldstyle_internal(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, 0);
}

lerp_player_view_to_position_oldstyle(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  var_9 = get_player_from_self();
  var_10 = spawn("script_origin", (0, 0, 0));
  var_10.origin = var_9 get_player_feet_from_view();
  var_10.angles = var_9 getplayerangles();

  if(isDefined(var_8)) {
    var_9 playerlinktodelta(var_10, "", var_3, var_4, var_5, var_6, var_7, var_8);
  } else if(isDefined(var_4)) {
    var_9 playerlinktodelta(var_10, "", var_3, var_4, var_5, var_6, var_7);
  } else if(isDefined(var_3)) {
    var_9 playerlinktodelta(var_10, "", var_3);
  } else {
    var_9 playerlinktodelta(var_10);
  }

  var_10 moveTo(var_0, var_2, var_2 * 0.25);
  var_10 rotateTo(var_1, var_2, var_2 * 0.25);
  wait(var_2);
  var_10 delete();
}

_id_8FCD(var_0, var_1, var_2) {
  var_3 = common_scripts\utility::spawn_tag_origin();
  var_3.origin = self.origin;
  var_3.angles = self.angles;
  var_4 = self._id_01C9;

  if(isPlayer(self)) {
    var_3.angles = self getplayerangles();
    var_4 = self getvelocity();
  }

  var_3 thread _id_5C93(var_0, var_3.origin, var_4, var_1, var_2);
  return var_3;
}

_id_5C93(var_0, var_1, var_2, var_3, var_4) {
  var_3 endon("death");
  self endon("death");
  var_5 = 0.05;
  var_6 = gettime();
  var_7 = var_6 + var_0 * 1000.0;
  var_8 = var_3.angles;
  var_9 = var_3.origin;

  if(isDefined(var_4)) {
    var_9 = var_3 gettagorigin(var_4);
  }

  var_10 = var_1;

  while(isDefined(self) && isDefined(var_3) && gettime() < var_7) {
    var_11 = _float(gettime() - var_6) / _float(var_7 - var_6);
    var_11 = 0.5 - _cos(var_11 * 180) * 0.5;
    var_12 = var_3.origin;

    if(isDefined(var_4)) {
      var_12 = var_3 gettagorigin(var_4);
    }

    var_13 = (var_12 - var_9) / var_5;
    var_14 = _vectorlerp(var_2, var_13, var_11);
    var_10 = var_10 + var_14 * var_5;
    self.origin = _vectorlerp(var_10, var_12, var_11);

    if(isDefined(var_4)) {
      self.angles = _func_10B(var_8, var_3 gettagangles(var_4), var_11);
    }

    var_9 = var_12;
    wait(var_5);
  }

  if(isDefined(var_4)) {
    self linkTo(var_3, var_4, (0, 0, 0), (0, 0, 0));
  } else {
    self.origin = var_3.origin;
  }
}

player_moves(var_0) {
  var_1 = level.player.origin;

  for(;;) {
    if(distance(var_1, level.player.origin) > var_0) {
      break;
    }

    waitframe();
  }
}

waittill_either_function(var_0, var_1, var_2, var_3) {
  var_4 = spawnStruct();
  thread _id_0322::waittill_either_function_internal(var_4, var_0, var_1);
  thread _id_0322::waittill_either_function_internal(var_4, var_2, var_3);
  var_4 waittill("done");
}

waittill_msg(var_0) {
  self waittill(var_0);
}

display_hint(var_0, var_1, var_2, var_3, var_4) {
  var_5 = get_player_from_self();

  if(isDefined(level.trigger_hint_func[var_0])) {
    if(var_5[[level.trigger_hint_func[var_0]]]()) {
      return;
    }
    var_5 thread _id_0322::hintprint(level.trigger_hint_string[var_0], var_0, level.trigger_hint_func[var_0], var_1, var_2, var_3, undefined, undefined, var_4);
  } else
    var_5 thread _id_0322::hintprint(level.trigger_hint_string[var_0], var_0, undefined, undefined, undefined, undefined, undefined, undefined, var_4);
}

hintdisplayhandler(var_0, var_1, var_2, var_3, var_4, var_5) {
  _id_0322::hintdisplayhandlersetup(var_0);

  if(!isDefined(var_1)) {
    display_hint(var_0, var_2, var_3, var_4, var_5);
  } else {
    display_hint_timeout(var_0, var_1, var_2, var_3, var_4, var_5);
  }
}

hintdisplaymintimehandler(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = get_player_from_self();

  if(var_6[[level.trigger_hint_func[var_0]]]()) {
    return;
  }
  _id_0322::hintdisplayhandlersetup(var_0);
  var_6 thread _id_0322::hintprint(level.trigger_hint_string[var_0], var_0, level.trigger_hint_func[var_0], var_3, var_4, var_5, var_1, var_2);
}

_id_0911(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(level.trigger_hint_string)) {
    level.trigger_hint_string = [];
    level.trigger_hint_func = [];
  }

  level.trigger_hint_string[var_0] = var_1;
  level.hint_list[var_0]["gamepad"] = var_1;
  level.hint_list[var_0]["pc"] = var_3;
  level.hint_list[var_0]["southpaw"] = var_4;
  level.hint_list[var_0]["pcBindings"] = var_5;
  precachestring(var_1);

  if(isDefined(var_3)) {
    precachestring(var_3);
  }

  if(isDefined(var_4)) {
    precachestring(var_4);
  }

  if(isDefined(var_5)) {
    foreach(var_7 in var_5) {
      precachestring(var_7);
    }
  }

  if(isDefined(var_2)) {
    level.trigger_hint_func[var_0] = var_2;
  }
}

handletriggerhintinputtypetext() {
  if(!isDefined(level.hint_triggers)) {
    level.hint_triggers = [];
  }

  for(;;) {
    level.hint_triggers = common_scripts\utility::_id_0FA0(level.hint_triggers);

    if(isDefined(level.hint_triggers) && isDefined(level.player)) {
      foreach(var_1 in level.hint_triggers) {
        if(level.player common_scripts\utility::is_player_gamepad_enabled()) {
          var_1 setHintString(var_1.gp_hint_text);
          continue;
        }

        var_1 setHintString(var_1.pc_hint_text);
      }
    }

    wait 0.1;
  }
}

_id_09B2(var_0, var_1) {
  if(!isDefined(level.hint_triggers)) {
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
    level.hint_triggers = common_scripts\utility::_id_0F6F(level.hint_triggers, self);
  }
}

display_hint_timeout(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = get_player_from_self();
  var_6 thread _id_0322::hintprint(level.trigger_hint_string[var_0], var_0, level.trigger_hint_func[var_0], var_2, var_3, var_4, var_1, undefined, var_5);
}

display_hint_timeout_mintime(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = get_player_from_self();

  if(var_6[[level.trigger_hint_func[var_0]]]()) {
    return;
  }
  var_6 thread _id_0322::hintprint(level.trigger_hint_string[var_0], var_0, level.trigger_hint_func[var_0], var_3, var_4, var_5, var_1, var_2);
}

display_hint_stick(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(!isDefined(var_6)) {
    var_6 = 0;
  }

  var_10 = _id_0322::hint_stick_get_updated(var_0, var_1, var_2, var_3, var_4, var_5, var_6);
  thread display_hint(var_10, var_7, var_8, var_9);
  thread _id_0322::hint_stick_update(var_0, var_1, var_2, var_3, var_4, var_5, var_6);
}

display_hint_stick_timeout(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  if(!isDefined(var_7)) {
    var_7 = 0;
  }

  var_11 = _id_0322::hint_stick_get_updated(var_0, var_2, var_3, var_4, var_5, var_6, var_7);
  thread display_hint_timeout(var_11, var_1, var_8, var_9, var_10);
  thread _id_0322::hint_stick_update(var_0, var_2, var_3, var_4, var_5, var_6, var_7);
}

display_hint_stick_timeout_mintime(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11) {
  if(!isDefined(var_8)) {
    var_8 = 0;
  }

  var_12 = _id_0322::hint_stick_get_updated(var_0, var_3, var_4, var_5, var_6, var_7, var_8);
  thread display_hint_timeout_mintime(var_12, var_1, var_2, var_9, var_10, var_11);
  thread _id_0322::hint_stick_update(var_0, var_3, var_4, var_5, var_6, var_7, var_8);
}

check_hint_condition(var_0, var_1, var_2, var_3) {
  if(isDefined(var_3)) {
    return [[level.trigger_hint_func[var_0]]](var_1, var_2, var_3);
  }

  if(isDefined(var_2)) {
    return [[level.trigger_hint_func[var_0]]](var_1, var_2);
  }

  if(isDefined(var_1)) {
    return [[level.trigger_hint_func[var_0]]](var_1);
  }

  return [[level.trigger_hint_func[var_0]]]();
}

getgenericanim(var_0) {
  return level.settenthstimer["generic"][var_0];
}

enable_careful() {
  self.freeentitysentient = 1;
}

_id_2F26(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 1;
  }

  self.freeentitysentient = 0;
  self notify("stop_being_careful", var_0);
}

_id_3643(var_0) {
  if(_id_0290::_id_0AAE()) {
    _id_0290::_id_0A8D(1, var_0);
  } else {
    self.sprint = 1;
  }
}

_id_2F5B() {
  if(_id_0290::_id_0AAE()) {
    _id_0290::_id_0A8D(0);
  } else {
    self.sprint = undefined;
  }
}

_id_2F24() {
  self._id_2F73 = 1;
}

_id_360D() {
  self._id_2F73 = undefined;
}

_id_8C45(var_0, var_1, var_2) {
  var_3 = undefined;
  var_4 = -1;
  var_5 = [];

  foreach(var_7 in level._id_08C7) {
    if(isDefined(var_7) && isDefined(var_7.ent)) {
      var_8 = var_7.ent;
      var_9 = animscripts\shg_asm\soldier\common\shared::_id_4339();
      var_10 = undefined;

      if(isDefined(var_2)) {
        var_10 = var_2;
      }

      var_11 = undefined;

      if(_isvector(var_0)) {
        var_11 = var_0;
      } else if(_isai(var_0)) {
        var_11 = var_0 animscripts\shg_asm\soldier\common\aim_and_fire::_id_4327();
      } else {
        var_11 = var_0.origin;
      }

      var_12 = undefined;

      if(_isvector(var_1)) {
        var_12 = var_1;
      } else if(_isai(var_1)) {
        var_12 = var_1 getshootatpos();
      } else {
        var_12 = var_1.origin;
      }

      if(isDefined(var_10) && distancesquared(var_11, var_12) > var_10) {
        return [0, undefined];
      }

      [var_14, var_15, var_16] = _id_02FA::_id_4107(var_8.origin, var_11, var_12);

      if(var_15 > var_9) {
        continue;
      }
      var_17 = undefined;

      if(_isvector(var_0) && _isvector(var_1)) {
        var_17 = _sighttracepassed(var_11, var_12, 0, undefined);
      } else if(_isvector(var_0) && !_isvector(var_1)) {
        var_17 = _sighttracepassed(var_11, var_12, 0, undefined);
      } else if(!_isvector(var_0) && _isvector(var_1)) {
        if(_isai(var_0)) {
          var_17 = var_0 can_see_origin(var_12);
        } else {
          var_17 = _sighttracepassed(var_11, var_12, 0, undefined);
        }
      } else if(_isai(var_0))
        var_17 = var_0 cansee(var_1);
      else {
        var_17 = _sighttracepassed(var_11, var_12, 0, undefined);
      }

      if(!var_17) {
        return [0, undefined];
      }

      var_18 = vectorNormalize(var_8.origin - var_12);
      var_19 = vectorNormalize(var_8.origin - var_11);

      if(vectordot(var_18, var_19) < 0 || distancesquared(var_12, var_8.origin) < animscripts\shg_asm\soldier\common\shared::_id_4338()) {
        var_5[var_5.size] = var_7;
      }
    }
  }

  if(var_5.size == 0) {
    return [1, undefined];
  } else {
    foreach(var_22 in var_5) {
      if(var_22._id_23D1 - gettime() > var_4) {
        var_4 = var_22._id_23D1 - gettime();
        var_3 = var_22;
      }
    }

    return [0, var_3];
  }
}

clear_dvar(var_0) {
  setDvar(var_0, "");
}

despawnagent() {
  self._id_0098 = 1;
}

set_fixednode_false() {
  self._id_0098 = 0;
}

spawn_ai(var_0, var_1) {
  self endon("death");
  common_scripts\utility::script_delay();

  if(!isDefined(self)) {
    return undefined;
  }

  if(!issubstr(self.classname, "actor")) {
    return undefined;
  }

  var_2 = isDefined(self.script_stealth) && common_scripts\utility::flag("stealth_enabled");
  var_3 = undefined;

  if(isDefined(self.setthreatbiasgroup)) {
    var_3 = dronespawn(self);
  } else if(isDefined(self.stoplookat) || isDefined(var_0)) {
    var_3 = self stalingradspawn(var_2);
  } else {
    var_3 = self dospawn(var_2);
  }

  if(isDefined(var_1) && var_1 && isalive(var_3)) {
    var_3 magic_bullet_shield();
  }

  if(!isDefined(self.setthreatbiasgroup)) {
    spawn_failed(var_3);
  }

  return var_3;
}

function_stack(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = spawnStruct();
  var_7 thread _id_0322::function_stack_proc(self, var_0, var_1, var_2, var_3, var_4, var_5, var_6);
  return _id_0322::function_stack_wait_finish(var_7);
}

function_stack_timeout(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = spawnStruct();
  var_7 thread _id_0322::function_stack_proc(self, var_1, var_2, var_3, var_4, var_5, var_6);

  if(isDefined(var_7.function_stack_func_begun) || var_7 common_scripts\utility::waittill_any_timeout(var_0, "function_stack_func_begun") != "timeout") {
    return _id_0322::function_stack_wait_finish(var_7);
  } else {
    var_7 notify("death");
    return 0;
  }
}

function_stack_clear() {
  var_0 = [];

  if(isDefined(self.function_stack[0]) && isDefined(self.function_stack[0].function_stack_func_begun)) {
    var_0[0] = self.function_stack[0];
  }

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
  self moveTo(self.realorigin + (0, 0, -10000), 0.2);
  self.geo_off = 1;
}

geo_on() {
  if(!isDefined(self.geo_off)) {
    return;
  }
  self moveTo(self.realorigin, 0.2);
  self waittill("movedone");
  self.geo_off = undefined;
}

disable_exits() {
  if(_isai(self)) {
    _id_0290::_id_0ACD("exits", 0);
  }
}

enable_exits() {
  if(_isai(self)) {
    _id_0290::_id_0ACD("exits", 1);
  }
}

disable_turnanims() {
  self.noturnanims = 1;
}

enable_turnanims() {
  self.noturnanims = undefined;
}

disable_arrivals() {
  if(_isai(self)) {
    _id_0290::_id_0ACD("arrivals", 0);
  }
}

enable_arrivals() {
  self endon("death");
  waittillframeend;

  if(_isai(self)) {
    _id_0290::_id_0ACD("arrivals", 1);
  }
}

hudoutlinedisableforclients(var_0, var_1) {
  _setblur(var_0, var_1);
}

setviewmodelanimtime(var_0) {
  self._id_00AE = var_0;
}

setdemigod(var_0) {
  self.last_set_goalnode = var_0;
  self.last_set_goalpos = undefined;
  self.last_set_goalent = undefined;

  if(isDefined(var_0.type) && var_0.type == "Turret" && !isDefined(_func_306(var_0))) {
    return;
  }
  self setgoalnode(var_0);
}

set_goal_node_targetname(var_0) {
  var_1 = _getnode(var_0, "targetname");
  setdemigod(var_1);
}

setviewmodelanim(var_0) {
  self.last_set_goalnode = undefined;
  self.last_set_goalpos = var_0;
  self.last_set_goalent = undefined;
  self setgoalpos(var_0);
}

vehicle_gettopspeed(var_0) {
  setviewmodelanim(var_0.origin);
  self.last_set_goalent = var_0;
}

_id_41B0() {
  if(isDefined(self.last_set_goalpos)) {
    return self.last_set_goalpos;
  }

  if(isDefined(self.last_set_goalnode)) {
    return self.last_set_goalnode.origin;
  }

  if(isDefined(self.last_set_goalent)) {
    return self.last_set_goalent.origin;
  }

  if(isDefined(self._id_011F)) {
    return self._id_011F;
  }

  if(isDefined(self._id_00AD)) {
    return self._id_00AD;
  }

  return self.origin;
}

_id_41AD() {
  if(isDefined(self.last_set_goalnode)) {
    return self.last_set_goalnode.angles;
  }

  if(isDefined(self.last_set_goalent)) {
    return self.last_set_goalent.angles;
  }

  return self.angles;
}

_id_41AF() {
  var_0 = self._id_010D;

  if(!isDefined(var_0)) {
    if(isDefined(self._id_0139) && distancesquared(self._id_0139.origin, self._id_00AD) < 4) {
      return self._id_0139;
    }

    if(isDefined(self.last_set_goalent)) {
      return self.last_set_goalent;
    }

    if(isDefined(self.last_set_goalnode)) {
      return self.last_set_goalnode;
    }

    var_1 = _id_41B0();

    if(isDefined(var_1)) {
      var_2 = _id_41AD();
      var_0 = spawnStruct();
      var_0.origin = var_1;
      var_0.angles = var_2;
    }
  }

  return var_0;
}

objective_complete(var_0) {
  _id_0322::objective_recon(var_0);
  _objective_state(var_0, "done");
  level notify("objective_complete" + var_0);
}

handsignal(var_0, var_1, var_2, var_3) {}

_id_0FA6(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_2)) {
    var_2 = 0;
  }

  if(!isDefined(var_3)) {
    var_3 = 0;
  }

  var_4 = spawnStruct();
  var_4._id_4AB6 = 0;
  var_4._id_4AB5 = [];
  var_5 = [];

  foreach(var_8, var_7 in var_0) {
    var_7._id_005C = 1;

    if(var_3) {
      thread _id_0FAD(var_4, var_8, var_7, var_1, var_2);
      continue;
    }

    var_5[var_5.size] = _id_0FAD(var_4, var_8, var_7, var_1, var_2);
  }

  if(var_3) {
    for(;;) {
      waittillframeend;
      waittillframeend;
      waittillframeend;
      waittillframeend;

      if(var_4._id_4AB6 == var_0.size) {
        break;
      } else
        waitframe();
    }

    var_5 = common_scripts\utility::_id_0FA0(var_4._id_4AB5);
  }

  if(!var_2) {}

  return var_5;
}

_id_0FAD(var_0, var_1, var_2, var_3, var_4) {
  var_5 = undefined;

  if(getsubstr(var_2.classname, 7, 10) == "veh") {
    var_5 = var_2 spawn_vehicle();

    if(isDefined(var_5.target) && !isDefined(var_5.script_moveoverride)) {
      var_5 thread _id_0323::gopath();
    }
  } else {
    var_5 = var_2 spawn_ai(var_3);

    if(!var_4) {}
  }

  var_0._id_4AB6++;
  var_0._id_4AB5[var_1] = var_5;
  return var_5;
}

_id_0FA9(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_2)) {
    var_2 = 0;
  }

  var_4 = [];

  foreach(var_6 in var_0) {
    var_6._id_005C = 1;

    if(getsubstr(var_6.classname, 7, 10) == "veh") {
      var_7 = var_6 spawn_vehicle();

      if(isDefined(var_7.target) && !isDefined(var_7.script_moveoverride)) {
        var_7 thread _id_0323::gopath();
      }

      var_4[var_4.size] = var_7;
      continue;
    }

    var_7 = var_6 spawn_ai(1);
    var_4 = common_scripts\utility::_id_0F6F(var_4, var_7);

    if(isDefined(var_3)) {
      wait(var_3);
      continue;
    }

    waitframe();
  }

  if(!var_2) {}

  return var_4;
}

_id_0FAF(var_0, var_1, var_2, var_3, var_4) {
  var_5 = getEntArray(var_0, "targetname");
  return _id_0FA6(var_5, var_1, var_2, var_4);
}

_id_0FB0(var_0, var_1, var_2, var_3, var_4) {
  var_5 = getEntArray(var_0, "targetname");
  return _id_0FA9(var_5, var_1, var_3, var_2);
}

_id_0FAE(var_0, var_1, var_2, var_3, var_4) {
  var_5 = getEntArray(var_0, "script_noteworthy");
  return _id_0FA6(var_5, var_1, var_2, var_4);
}

spawn_script_noteworthy(var_0, var_1) {
  var_2 = _getEnt(var_0, "script_noteworthy");
  var_3 = var_2 spawn_ai(var_1);
  return var_3;
}

spawn_targetname(var_0, var_1) {
  var_2 = _getEnt(var_0, "targetname");
  var_3 = var_2 spawn_ai(var_1);
  return var_3;
}

_id_0920(var_0, var_1, var_2) {
  if(getdvarint("2853", 0)) {
    return;
  }
  if(!isDefined(level.dialogue_huds)) {
    level.dialogue_huds = [];
  }

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
      case "y":
      case "yellow":
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
      case "w":
      case "white":
        var_4 = "^7";
        break;
      case "bl":
      case "black":
        var_4 = "^8";
        break;
    }
  }

  level.dialogue_huds[var_3] = 1;
  var_5 = _id_02C6::createfontstring("default", 1.5);
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
    waitframe();
  }

  wait 4;
  var_5 destroy();
  level.dialogue_huds[var_3] = undefined;
}

destructible_disable_explosion() {
  _id_0286::disable_explosion();
}

destructible_force_explosion() {
  _id_0286::force_explosion();
}

set_grenadeammo(var_0) {
  self._id_00B2 = var_0;
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

physicsgetlinspeed(var_0) {
  _id_0290::_id_0ACC(var_0);
}

set_console_status() {
  if(!isDefined(level.console)) {
    level.console = getDvar("5554") == "true";
  } else {}

  if(!isDefined(level._id_01D4)) {
    level._id_01D4 = getDvar("3475") == "true";
  } else {}

  if(!isDefined(level._id_01D5)) {
    level._id_01D5 = getDvar("2695") == "true";
  } else {}

  if(!isDefined(level._id_0148)) {
    level._id_0148 = getDvar("3864") == "true";
  } else {}

  if(!isDefined(level._id_0149)) {
    level._id_0149 = getDvar("3957") == "true";
  } else {}

  if(!isDefined(level._id_0122)) {
    level._id_0122 = !level.console;
  } else {}

  if(!isDefined(level._id_010B)) {
    level._id_010B = level._id_0122 || level._id_0148 || level._id_01D4;
  } else {}
}

is_gen4() {
  return level._id_010B;
}

_id_1395(var_0) {
  var_1 = _id_0299::_id_13A3(undefined, undefined, undefined, 1, undefined, var_0);

  if(isDefined(var_1) && var_1) {
    if(!isDefined(var_0) || var_0 == 0) {
      _id_031D::_id_7430("CHECKPOINT_REACHED");
    }
  }

  return var_1;
}

_id_1396() {
  return _id_0299::_id_13A3(undefined, undefined, undefined, 1, undefined, 1);
}

batteryfullrecharge(var_0) {
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

  if(isDefined(var_0)) {
    self playSound(var_0);
  } else {
    self playSound("door_wood_slow_open");
  }

  self rotateTo(self.angles + (0, 70, 0), 2, 0.5, 0);
  self connectpaths();
  self waittill("rotatedone");
  self rotateTo(self.angles + (0, 40, 0), 2, 0, 2);
}

palm_style_door_open(var_0) {
  wait 1.35;

  if(isDefined(var_0)) {
    self playSound(var_0);
  } else {
    self playSound("door_wood_slow_open");
  }

  self rotateTo(self.angles + (0, 70, 0), 2, 0.5, 0);
  self connectpaths();
  self waittill("rotatedone");
  self rotateTo(self.angles + (0, 40, 0), 2, 0, 2);
}

lerp_fov_overtime(var_0, var_1) {
  foreach(var_3 in level.players) {
    var_3 lerpfov(var_1, var_0);
  }

  wait(var_0);
}

lerp_fovscale_overtime(var_0, var_1) {
  var_2 = getdvarfloat("3078");
  var_3 = int(var_0 / 0.05);
  var_4 = (var_1 - var_2) / var_3;
  var_5 = var_2;

  for(var_6 = 0; var_6 < var_3; var_6++) {
    var_5 = var_5 + var_4;
    _setsaveddvar("3078", var_5);
    waitframe();
  }

  _setsaveddvar("3078", var_1);
}

_id_77C5() {
  animscripts\shared::placeweaponon(self._id_01D0, "none");
  self._id_01D0 = "none";
}

_id_0F28() {
  _id_0298::setdamagecallbackon(0);
}

_id_0F27() {
  _id_0298::setdamagecallbackon(1);
}

_id_0E86() {
  self stopanimScripted();
  self notify("stop_loop");
  self notify("single anim", "end");
  self notify("looping anim", "end");
}

disable_pain() {
  self._id_0794.disablepain = 1;
  self._id_0016 = 0;
}

enable_pain() {
  self._id_0794.disablepain = 0;
  self._id_0016 = 1;
}

_id_05FB() {
  self delete();
}

_id_0669() {
  self kill();
}

kill_wrapper() {
  if(isPlayer(self)) {
    if(common_scripts\utility::flag_exist("special_op_terminated") && common_scripts\utility::flag("special_op_terminated")) {
      return 0;
    }

    if(is_player_down(self)) {
      self disableinvulnerability();
    }
  }

  self enabledeathshield(0);
  self kill();
  return 1;
}

_id_06D1(var_0) {
  self setentitytarget(var_0);
}

_id_05E2() {
  self clearentitytarget();
}

_id_0733() {
  self unlink();
}

disable_oneshotfx_with_noteworthy(var_0) {
  var_1 = getarraykeys(level._id_0643[var_0]);

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    level._id_0643[var_0][var_1[var_2]].looper delete();
    level._id_0643[var_0][var_1[var_2]] = undefined;
  }
}

_id_06D3(var_0) {
  self setlightintensity(var_0);
}

_id_0673(var_0, var_1, var_2, var_3) {
  if(isDefined(var_3)) {
    self linkTo(var_0, var_1, var_2, var_3);
    return;
  }

  if(isDefined(var_2)) {
    self linkTo(var_0, var_1, var_2);
    return;
  }

  if(isDefined(var_1)) {
    self linkTo(var_0, var_1);
    return;
  }

  self linkTo(var_0);
}

_id_0FBA(var_0, var_1, var_2) {
  var_3 = getarraykeys(var_0);
  var_4 = [];

  for(var_5 = 0; var_5 < var_3.size; var_5++) {
    var_6 = var_3[var_5];
  }

  for(var_5 = 0; var_5 < var_3.size; var_5++) {
    var_6 = var_3[var_5];
    var_4[var_6] = spawnStruct();
    var_4[var_6]._id_05A3 = 1;
    var_4[var_6] thread _id_0322::_id_0FBB(var_0[var_6], var_1, var_2);
  }

  for(var_5 = 0; var_5 < var_3.size; var_5++) {
    var_6 = var_3[var_5];

    if(isDefined(var_0[var_6]) && var_4[var_6]._id_05A3) {
      var_4[var_6] waittill("_array_wait");
    }
  }
}

die() {
  self kill((0, 0, 0));
}

getmodel(var_0) {
  return level.setcursorhint[var_0];
}

isads() {
  return self playerads() > 0.5;
}

waittill_player_lookat(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(var_5)) {
    var_5 = level.player;
  }

  var_6 = spawnStruct();

  if(isDefined(var_3)) {
    var_6 thread notify_delay("timeout", var_3);
  }

  var_6 endon("timeout");

  if(!isDefined(var_0)) {
    var_0 = 0.92;
  }

  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  var_7 = int(var_1 * 20);
  var_8 = var_7;
  self endon("death");
  var_9 = _isai(self);
  var_10 = undefined;

  for(;;) {
    if(var_9) {
      var_10 = self getEye();
    } else {
      var_10 = self.origin;
    }

    if(var_5 player_looking_at(var_10, var_0, var_2, var_4)) {
      var_8--;

      if(var_8 <= 0) {
        return 1;
      }
    } else
      var_8 = var_7;

    waitframe();
  }
}

waittill_player_lookat_for_time(var_0, var_1, var_2, var_3) {
  waittill_player_lookat(var_1, var_0, var_2, undefined, var_3);
}

player_looking_at(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_1)) {
    var_1 = 0.8;
  }

  var_4 = get_player_from_self();
  var_5 = var_4 getEye();
  var_6 = vectortoangles(var_0 - var_5);
  var_7 = anglesToForward(var_6);
  var_8 = var_4 getplayerangles();
  var_9 = anglesToForward(var_8);
  var_10 = vectordot(var_7, var_9);

  if(var_10 < var_1) {
    return 0;
  }

  if(isDefined(var_2)) {
    return 1;
  }

  var_11 = bulletTrace(var_0, var_5, 0, var_3);
  return var_11["fraction"] == 1;
}

either_player_looking_at(var_0, var_1, var_2, var_3) {
  for(var_4 = 0; var_4 < level.players.size; var_4++) {
    if(level.players[var_4] player_looking_at(var_0, var_1, var_2, var_3)) {
      return 1;
    }
  }

  return 0;
}

player_can_see_ai(var_0, var_1, var_2) {
  var_3 = gettime();

  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  var_4 = 0.766;

  if(isDefined(var_2)) {
    var_4 = _cos(var_2);
  }

  if(isDefined(var_0.playerseesmetime) && var_0.playerseesmetime + var_1 >= var_3) {
    return var_0.playerseesme;
  }

  var_0.playerseesmetime = var_3;

  if(!common_scripts\utility::within_fov(level.player.origin, level.player _meth_8566(), var_0.origin, var_4)) {
    var_0.playerseesme = 0;
    return 0;
  }

  var_5 = level.player getEye();
  var_6 = var_0.origin;

  if(_sighttracepassed(var_5, var_6, 1, level.player, var_0)) {
    var_0.playerseesme = 1;
    return 1;
  }

  var_7 = var_6 + (0, 0, 120);

  if(_sighttracepassed(var_5, var_7, 1, level.player, var_0)) {
    var_0.playerseesme = 1;
    return 1;
  }

  var_8 = (var_7 + var_6) * 0.5;

  if(_sighttracepassed(var_5, var_8, 1, level.player, var_0)) {
    var_0.playerseesme = 1;
    return 1;
  }

  var_0.playerseesme = 0;
  return 0;
}

players_within_distance(var_0, var_1) {
  var_2 = var_0 * var_0;

  for(var_3 = 0; var_3 < level.players.size; var_3++) {
    if(distancesquared(var_1, level.players[var_3].origin) < var_2) {
      return 1;
    }
  }

  return 0;
}

_id_0A7F(var_0, var_1) {
  if(!isDefined(var_0)) {
    return;
  }
  var_2 = 0.75;

  if(_issplitscreen()) {
    var_2 = 0.65;
  }

  while(var_0.size > 0) {
    wait 1;

    for(var_3 = 0; var_3 < var_0.size; var_3++) {
      if(!isDefined(var_0[var_3]) || !isalive(var_0[var_3])) {
        var_0 = common_scripts\utility::_id_0F93(var_0, var_0[var_3]);
        continue;
      }

      if(players_within_distance(var_1, var_0[var_3].origin)) {
        continue;
      }
      if(either_player_looking_at(var_0[var_3].origin + (0, 0, 48), var_2, 1)) {
        continue;
      }
      if(isDefined(var_0[var_3].magic_bullet_shield)) {
        var_0[var_3] stop_magic_bullet_shield();
      }

      var_0[var_3] delete();
      var_0 = common_scripts\utility::_id_0F93(var_0, var_0[var_3]);
    }
  }
}

_id_098B(var_0, var_1, var_2, var_3) {
  var_4 = spawnStruct();
  var_4.caller = self;
  var_4.func = var_0;
  var_4.parms = [];

  if(isDefined(var_1)) {
    var_4.parms[var_4.parms.size] = var_1;
  }

  if(isDefined(var_2)) {
    var_4.parms[var_4.parms.size] = var_2;
  }

  if(isDefined(var_3)) {
    var_4.parms[var_4.parms.size] = var_3;
  }

  level.wait_any_func_array[level.wait_any_func_array.size] = var_4;
}

_id_08F5(var_0, var_1, var_2, var_3) {
  var_4 = spawnStruct();
  var_4.caller = self;
  var_4.func = var_0;
  var_4.parms = [];

  if(isDefined(var_1)) {
    var_4.parms[var_4.parms.size] = var_1;
  }

  if(isDefined(var_2)) {
    var_4.parms[var_4.parms.size] = var_2;
  }

  if(isDefined(var_3)) {
    var_4.parms[var_4.parms.size] = var_3;
  }

  level._id_0846[level._id_0846.size] = var_4;
}

_id_092A(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = spawnStruct();
  var_6.caller = self;
  var_6.func = var_0;
  var_6.parms = [];

  if(isDefined(var_1)) {
    var_6.parms[var_6.parms.size] = var_1;
  }

  if(isDefined(var_2)) {
    var_6.parms[var_6.parms.size] = var_2;
  }

  if(isDefined(var_3)) {
    var_6.parms[var_6.parms.size] = var_3;
  }

  if(isDefined(var_4)) {
    var_6.parms[var_6.parms.size] = var_4;
  }

  if(isDefined(var_5)) {
    var_6.parms[var_6.parms.size] = var_5;
  }

  level.run_func_after_wait_array[level.run_func_after_wait_array.size] = var_6;
}

_id_0907(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = spawnStruct();
  var_6.caller = self;
  var_6.func = var_0;
  var_6.parms = [];

  if(isDefined(var_1)) {
    var_6.parms[var_6.parms.size] = var_1;
  }

  if(isDefined(var_2)) {
    var_6.parms[var_6.parms.size] = var_2;
  }

  if(isDefined(var_3)) {
    var_6.parms[var_6.parms.size] = var_3;
  }

  if(isDefined(var_4)) {
    var_6.parms[var_6.parms.size] = var_4;
  }

  if(isDefined(var_5)) {
    var_6.parms[var_6.parms.size] = var_5;
  }

  level.run_call_after_wait_array[level.run_call_after_wait_array.size] = var_6;
}

_id_094A(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = spawnStruct();
  var_6.func = var_0;
  var_6.parms = [];

  if(isDefined(var_1)) {
    var_6.parms[var_6.parms.size] = var_1;
  }

  if(isDefined(var_2)) {
    var_6.parms[var_6.parms.size] = var_2;
  }

  if(isDefined(var_3)) {
    var_6.parms[var_6.parms.size] = var_3;
  }

  if(isDefined(var_4)) {
    var_6.parms[var_6.parms.size] = var_4;
  }

  if(isDefined(var_5)) {
    var_6.parms[var_6.parms.size] = var_5;
  }

  level.run_noself_call_after_wait_array[level.run_noself_call_after_wait_array.size] = var_6;
}

_id_0924(var_0) {
  var_1 = spawnStruct();
  var_1.caller = self;
  var_1.ender = var_0;
  level.do_wait_endons_array[level.do_wait_endons_array.size] = var_1;
}

do_wait_any() {
  do_wait(level.wait_any_func_array.size - 1);
}

do_wait(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 0;
  }

  var_1 = spawnStruct();
  var_2 = level.wait_any_func_array;
  var_3 = level.do_wait_endons_array;
  var_4 = level.run_func_after_wait_array;
  var_5 = level.run_call_after_wait_array;
  var_6 = level.run_noself_call_after_wait_array;
  var_7 = level._id_0846;
  level.wait_any_func_array = [];
  level.run_func_after_wait_array = [];
  level.do_wait_endons_array = [];
  level._id_0846 = [];
  level.run_call_after_wait_array = [];
  level.run_noself_call_after_wait_array = [];
  var_1._id_005C = var_2.size;
  var_1 common_scripts\utility::_id_0F8A(var_2, _id_0322::waittill_func_ends, var_3);
  var_1 thread _id_0322::do_abort(var_7);
  var_1 endon("any_funcs_aborted");

  for(;;) {
    if(var_1._id_005C <= var_0) {
      break;
    }

    var_1 waittill("func_ended");
  }

  var_1 notify("all_funcs_ended");
  common_scripts\utility::_id_0F8A(var_4, _id_0322::exec_func, []);
  common_scripts\utility::_id_0F8A(var_5, _id_0322::exec_call);
  common_scripts\utility::_id_0F8A(var_6, _id_0322::exec_call_noself);
}

do_funcs() {
  var_0 = spawnStruct();
  var_1 = level.run_func_after_wait_array;
  level.run_func_after_wait_array = [];

  foreach(var_3 in var_1) {
    level _id_0322::exec_func(var_3, []);
  }

  var_0 notify("all_funcs_ended");
}

is_default_start() {
  if(isDefined(level.forced_start_catchup) && level.forced_start_catchup == 1) {
    return 0;
  }

  if(isDefined(level.default_start_override) && level.default_start_override == level.start_point) {
    return 1;
  }

  if(isDefined(level.default_start)) {
    return level.start_point == "default";
  }

  if(level_has_start_points()) {
    return level.start_point == level.start_functions[0]["name"];
  }

  return level.start_point == "default";
}

force_start_catchup() {
  level.forced_start_catchup = 1;
}

is_first_start() {
  if(!level_has_start_points()) {
    return 1;
  }

  return level.start_point == level.start_functions[0]["name"];
}

is_after_start(var_0) {
  var_1 = 0;

  if(level.start_point == var_0) {
    return 0;
  }

  for(var_2 = 0; var_2 < level.start_functions.size; var_2++) {
    if(level.start_functions[var_2]["name"] == var_0) {
      var_1 = 1;
      continue;
    }

    if(level.start_functions[var_2]["name"] == level.start_point) {
      return var_1;
    }
  }
}

_id_0610(var_0, var_1, var_2, var_3) {
  _earthquake(var_0, var_1, var_2, var_3);
}

waterfx(var_0, var_1) {
  self endon("death");
  var_2 = 0;

  if(isDefined(var_1)) {
    var_2 = 1;
  }

  if(isDefined(var_0)) {
    common_scripts\utility::flag_assert(var_0);
    level endon(var_0);
  }

  for(;;) {
    wait(_randomfloatrange(0.15, 0.3));
    var_3 = self.origin + (0, 0, 150);
    var_4 = self.origin - (0, 0, 150);
    var_5 = bulletTrace(var_3, var_4, 0, undefined);

    if(!issubstr(var_5["surfacetype"], "water")) {
      continue;
    }
    var_6 = "water_movement";

    if(isPlayer(self)) {
      if(distance(self getvelocity(), (0, 0, 0)) < 5) {
        var_6 = "water_stop";
      }
    } else if(isDefined(level._effect["water_" + self._id_0794.movement]))
      var_6 = "water_" + self._id_0794.movement;

    var_7 = common_scripts\utility::getfx(var_6);
    var_3 = var_5["position"];
    var_8 = (0, self.angles[1], 0);
    var_9 = anglesToForward(var_8);
    var_10 = anglestoup(var_8);
    playFX(var_7, var_3, var_10, var_9);

    if(var_6 != "water_stop" && var_2) {
      thread common_scripts\utility::play_sound_in_space(var_1, var_3);
    }
  }
}

playersnowfootsteps(var_0) {
  if(isDefined(var_0)) {
    common_scripts\utility::flag_assert(var_0);
    level endon(var_0);
  }

  for(;;) {
    wait(_randomfloatrange(0.25, 0.5));
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

    if(distance(self getvelocity(), (0, 0, 0)) <= 154) {
      playFX(common_scripts\utility::getfx("footstep_snow_small"), var_3["position"], var_3["normal"], var_4);
    }

    if(distance(self getvelocity(), (0, 0, 0)) > 154) {
      playFX(common_scripts\utility::getfx("footstep_snow"), var_3["position"], var_3["normal"], var_4);
    }
  }
}

mix_up(var_0) {
  var_1 = 60;

  for(var_2 = 0; var_2 < var_1; var_2++) {
    self setsoundblend(var_0, var_0 + "_off", (var_1 - var_2) / var_1);
    waitframe();
  }
}

mix_down(var_0) {
  var_1 = 60;

  for(var_2 = 0; var_2 < var_1; var_2++) {
    self setsoundblend(var_0, var_0 + "_off", var_2 / var_1);
    waitframe();
  }
}

manual_linkto(var_0, var_1) {
  var_0 endon("death");
  self endon("death");

  if(!isDefined(var_1)) {
    var_1 = (0, 0, 0);
  }

  for(;;) {
    self.origin = var_0.origin + var_1;
    self.angles = var_0.angles;
    waitframe();
  }
}

nextmission() {
  _id_0322::mission_recon();
  _id_02B3::_id_0682();
}

_id_47F7(var_0, var_1) {
  _id_02B3::_id_0644(var_0, var_1);
}

make_array(var_0, var_1, var_2, var_3, var_4) {
  var_5 = [];
  var_5[var_5.size] = var_0;

  if(isDefined(var_1)) {
    var_5[var_5.size] = var_1;
  }

  if(isDefined(var_2)) {
    var_5[var_5.size] = var_2;
  }

  if(isDefined(var_3)) {
    var_5[var_5.size] = var_3;
  }

  if(isDefined(var_4)) {
    var_5[var_5.size] = var_4;
  }

  return var_5;
}

fail_on_friendly_fire() {
  level.failonfriendlyfire = 1;
}

normal_friendly_fire_penalty() {
  level.failonfriendlyfire = 0;
}

getplayerclaymores() {
  var_0 = self getweaponlistall();
  var_1 = [];

  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    var_3 = var_0[var_2];
    var_1[var_3] = self getweaponammoclip(var_3);
  }

  var_4 = 0;

  if(isDefined(var_1["claymore"]) && var_1["claymore"] > 0) {
    var_4 = var_1["claymore"];
  }

  return var_4;
}

_id_076D(var_0) {
  wait(var_0);
}

_id_0770(var_0, var_1) {
  self waittillmatch(var_0, var_1);
}

_id_06D9(var_0, var_1) {
  _setsaveddvar(var_0, var_1);
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
    _setsaveddvar(var_0, var_3);
    wait(var_5);
  }

  _setsaveddvar(var_0, var_1);
}

lerp_saveddvar_cg_ng(var_0, var_1, var_2, var_3) {
  if(is_gen4()) {
    lerp_saveddvar(var_0, var_2, var_3);
  } else {
    lerp_saveddvar(var_0, var_1, var_3);
  }
}

giveachievement_wrapper(var_0) {
  if(is_demo() || getdvarint("3224")) {
    return;
  }
  foreach(var_2 in level.players) {
    var_2 giveachievement(var_0);
  }
}

player_giveachievement_wrapper(var_0) {
  if(is_demo()) {
    return;
  }
  self giveachievement(var_0);
}

_id_0937(var_0) {
  var_1 = spawn("script_model", (0, 0, 0));
  var_1 _meth_80B1();
  var_1 setModel("weapon_javelin_obj");
  var_1.origin = self.origin;
  var_1.angles = self.angles;
  _id_098B(::delete_on_not_defined);

  if(isDefined(var_0)) {
    common_scripts\utility::flag_assert(var_0);
    _id_098B(common_scripts\utility::flag_wait, var_0);
  }

  do_wait_any();
  var_1 delete();
}

_id_0906(var_0) {
  var_1 = spawn("script_model", (0, 0, 0));
  var_1 _meth_80B1();
  var_1 setModel("weapon_c4_obj");
  var_1.origin = self.origin;
  var_1.angles = self.angles;
  _id_098B(::delete_on_not_defined);

  if(isDefined(var_0)) {
    common_scripts\utility::flag_assert(var_0);
    _id_098B(common_scripts\utility::flag_wait, var_0);
  }

  do_wait_any();
  var_1 delete();
}

delete_on_not_defined() {
  for(;;) {
    if(!isDefined(self)) {
      return;
    }
    waitframe();
  }
}

_id_8CB5() {}

_id_8CAC() {}

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
  _setslowmotion(level.slowmo.speed_norm, level.slowmo.speed_slow, level.slowmo.lerp_time_in);
}

slowmo_lerp_out() {
  if(isDefined(level.no_slowmo) && level.no_slowmo) {
    return;
  }
  _setslowmotion(level.slowmo.speed_slow, level.slowmo.speed_norm, level.slowmo.lerp_time_out);
}

_id_0923(var_0, var_1, var_2, var_3) {
  level.earthquake[var_0]["magnitude"] = var_1;
  level.earthquake[var_0]["duration"] = var_2;
  level.earthquake[var_0]["radius"] = var_3;
}

_id_0F44() {
  return getDvar("2559") == "1";
}

_id_0F46() {
  if(!isDefined(level._id_0F45)) {
    return;
  }
  level notify("arcadeMode_remove_timer");
  level._id_0F47 = gettime();
  level._id_0F45 destroy();
  level._id_0F45 = undefined;
}

musicplaywrapper(var_0, var_1) {
  level._id_05A5.last_song = var_0;

  if(!isDefined(var_1)) {
    var_1 = 1;
  }

  _musicstop(0);
  _musicplay(var_0, 0, 1.0, 1);
}

music_loop(var_0, var_1, var_2, var_3) {
  thread _id_0322::music_loop_internal(var_0, var_1, var_2, var_3);
}

music_loop_stealth(var_0, var_1, var_2, var_3) {
  thread _id_0322::music_loop_internal(var_0, var_1, var_2, var_3);
}

music_play(var_0, var_1, var_2) {
  if(isDefined(var_1) && var_1 > 0) {
    thread _id_0322::music_play_internal_stop_with_fade_then_call(var_0, var_1, var_2);
    return;
  }

  music_stop();
  musicplaywrapper(var_0, var_2);
}

music_crossfade(var_0, var_1, var_2) {
  if(!isDefined(var_2)) {
    var_2 = 1;
  }

  if(isDefined(level._id_05A5.last_song)) {
    _musicstop(var_1, level._id_05A5.last_song);
  } else {
    _iprintln("^3WARNING!script music_crossfade(): No previous song was played - no previous song to crossfade from - not fading out anything");
  }

  level._id_05A5.last_song = var_0;
  _musicplay(var_0, var_1, var_2, 0);
  level endon("stop_music");
  wait(var_1);
  level notify("done_crossfading");
}

music_stop(var_0) {
  if(!isDefined(var_0) || var_0 <= 0) {
    _musicstop();
  } else {
    _musicstop(var_0);
  }

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

      if(distancesquared(var_2.origin, var_4.origin) < 75625) {
        return 1;
      }
    }
  }

  return 0;
}

player_died_recently() {
  return getdvarint("player_died_recently", "0") > 0;
}

_id_0BD2(var_0) {
  foreach(var_2 in level.players) {
    if(!var_2 istouching(var_0)) {
      return 0;
    }
  }

  return 1;
}

_id_0F0C(var_0) {
  foreach(var_2 in level.players) {
    if(var_2 istouching(var_0)) {
      return 1;
    }
  }

  return 0;
}

getdifficulty() {
  if(level.gameskill < 1) {
    return "easy";
  }

  if(level.gameskill < 2) {
    return "medium";
  }

  if(level.gameskill < 3) {
    return "hard";
  }

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

  foreach(var_3 in var_0) {
    var_1 = var_1 + var_3.origin;
  }

  return var_1 * (1.0 / var_0.size);
}

generic_damage_think() {
  self.damage_functions = [];
  self endon("entitydeleted");
  self endon("stop_generic_damage_think");

  for(;;) {
    self waittill("damage", var_0, var_1, var_2, var_3, var_4, var_5, var_6);

    foreach(var_8 in self.damage_functions) {
      thread[[var_8]](var_0, var_1, var_2, var_3, var_4, var_5, var_6);
    }
  }
}

_id_0913(var_0) {
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
    if(isDefined(var_5._id_0165) && var_5._id_0165 == "player1") {
      var_1 = var_5;
      continue;
    }

    if(isDefined(var_5._id_0165) && var_5._id_0165 == "player2") {
      var_2 = var_5;
      continue;
    }

    if(!isDefined(var_1)) {
      var_1 = var_5;
    }

    if(!isDefined(var_2)) {
      var_2 = var_5;
    }
  }

  foreach(var_8 in level.players) {
    if(var_8 == level.player) {
      var_3 = var_1;
    } else if(var_8 == level.player2) {
      var_3 = var_2;
    }

    var_8 setOrigin(var_3.origin);
    var_8 setplayerangles(var_3.angles);
  }
}

teleport_player(var_0) {
  level.player setOrigin(var_0.origin);

  if(isDefined(var_0.angles)) {
    level.player setplayerangles(var_0.angles);
  }
}

translate_local() {
  var_0 = [];

  if(isDefined(self.entities)) {
    var_0 = self.entities;
  }

  if(isDefined(self.entity)) {
    var_0[var_0.size] = self.entity;
  }

  common_scripts\utility::_id_0F8A(var_0, _id_0322::translate_local_on_ent);
}

open_up_fov(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  level.player endon("stop_opening_fov");
  wait(var_0);
  level.player playerlinktodelta(var_1, var_2, 1, var_3, var_4, var_5, var_6, 1);
}

get_ai_touching_volume(var_0, var_1, var_2) {
  if(!isDefined(var_0)) {
    var_0 = "all";
  }

  if(!isDefined(var_1)) {
    var_1 = "all";
  }

  var_3 = _getaispeciesarray(var_0, var_1);
  var_4 = [];

  foreach(var_6 in var_3) {
    if(var_6 istouching(self)) {
      var_4[var_4.size] = var_6;
    }
  }

  return var_4;
}

get_drones_touching_volume(var_0) {
  if(!isDefined(var_0)) {
    var_0 = "all";
  }

  var_1 = [];

  if(var_0 == "all") {
    var_1 = common_scripts\utility::_id_0F8C(level.drones["allies"]._id_0F6D, level.drones["axis"]._id_0F6D);
    var_1 = common_scripts\utility::_id_0F8C(var_1, level.drones["neutral"]._id_0F6D);
  } else
    var_1 = level.drones[var_0]._id_0F6D;

  var_2 = [];

  foreach(var_4 in var_1) {
    if(!isDefined(var_4)) {
      continue;
    }
    if(var_4 istouching(self)) {
      var_2[var_2.size] = var_4;
    }
  }

  return var_2;
}

get_drones_with_targetname(var_0) {
  var_1 = common_scripts\utility::_id_0F8C(level.drones["allies"]._id_0F6D, level.drones["axis"]._id_0F6D);
  var_1 = common_scripts\utility::_id_0F8C(var_1, level.drones["neutral"]._id_0F6D);
  var_2 = [];

  foreach(var_4 in var_1) {
    if(!isDefined(var_4)) {
      continue;
    }
    if(isDefined(var_4.targetname) && var_4.targetname == var_0) {
      var_2[var_2.size] = var_4;
    }
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

gettagindex(var_0) {
  self._id_005C = var_0;

  if(self._id_005C == 0) {
    self notify("spawner_emptied");
  }
}

follow_path(var_0) {
  self notify("_utility::follow_path");
  self endon("_utility::follow_path");
  self endon("death");
  var_1 = undefined;

  if(!isDefined(var_0.classname)) {
    if(!isDefined(var_0.type)) {
      var_1 = "struct";
    } else {
      var_1 = "node";
    }
  } else
    var_1 = "entity";

  var_2 = self.enableaimassist;
  self.enableaimassist = 1;
  _id_02FC::go_to_node(var_0, var_1);
  self.enableaimassist = var_2;
}

enable_dynamic_run_speed(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(var_0)) {
    var_0 = 250;
  }

  if(!isDefined(var_1)) {
    var_1 = 100;
  }

  if(!isDefined(var_2)) {
    var_2 = var_0 * 2;
  }

  if(!isDefined(var_3)) {
    var_3 = var_0 * 1.25;
  }

  if(!isDefined(var_5)) {
    var_5 = 0;
  }

  self.dontchangemoveplaybackrate = var_5;
  thread _id_0322::dynamic_run_speed_proc(var_0, var_1, var_2, var_3, var_4);
}

disable_dynamic_run_speed() {
  self notify("stop_dynamic_run_speed");
}

player_seek_enable() {
  self endon("death");
  self endon("stop_player_seek");
  var_0 = 1200;

  if(has_shotgun()) {
    var_0 = 250;
  }

  var_1 = distance(self.origin, level.player.origin);

  for(;;) {
    wait 2;
    self._id_00AE = var_1;
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

  if(!isDefined(var_2)) {
    var_2 = 5;
  }

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

  if(!isDefined(self._id_01D0)) {
    return 0;
  }

  if(weaponclass(self._id_01D0) == "spread") {
    return 1;
  }

  return 0;
}

isprimaryweapon(var_0) {
  if(var_0 == "none") {
    return 0;
  }

  if(weaponinventorytype(var_0) != "primary") {
    return 0;
  }

  switch (weaponclass(var_0)) {
    case "mg":
    case "pistol":
    case "smg":
    case "rocketlauncher":
    case "rifle":
    case "sniper":
    case "spread":
      return 1;
    default:
      return 0;
  }
}

player_has_thermal() {
  var_0 = self getweaponlistall();

  if(!isDefined(var_0)) {
    return 0;
  }

  foreach(var_2 in var_0) {
    if(issubstr(var_2, "thermal")) {
      return 1;
    }
  }

  return 0;
}

waittill_true_goal(var_0, var_1) {
  self endon("death");

  if(!isDefined(var_1)) {
    var_1 = self._id_00AE;
  }

  for(;;) {
    self waittill("goal");

    if(distance(self.origin, var_0) < var_1 + 10) {
      break;
    }
  }
}

player_speed_percent(var_0, var_1) {
  var_2 = int(getDvar("5502"));

  if(!isDefined(level.player.g_speed)) {
    level.player.g_speed = var_2;
  }

  var_3 = int(level.player.g_speed * var_0 * 0.01);
  level.player player_speed_set(var_3, var_1);
}

blend_movespeedscale_percent(var_0, var_1) {
  var_2 = self;

  if(!isPlayer(var_2)) {
    var_2 = level.player;
  }

  if(!isDefined(var_2.movespeedscale)) {
    var_2.movespeedscale = 1.0;
  }

  var_3 = var_0 * 0.01;
  var_2 blend_movespeedscale(var_3, var_1);
}

player_speed_set(var_0, var_1) {
  var_2 = int(getDvar("5502"));

  if(!isDefined(level.player.g_speed)) {
    level.player.g_speed = var_2;
  }

  var_3 = _id_0322::g_speed_get_func;
  var_4 = _id_0322::g_speed_set_func;
  level.player thread player_speed_proc(var_0, var_1, var_3, var_4, "player_speed_set");
}

player_bob_scale_set(var_0, var_1) {
  var_2 = _id_0322::g_bob_scale_get_func;
  var_3 = _id_0322::g_bob_scale_set_func;
  level.player thread player_speed_proc(var_0, var_1, var_2, var_3, "player_bob_scale_set");
}

blend_movespeedscale(var_0, var_1) {
  var_2 = self;

  if(!isPlayer(var_2)) {
    var_2 = level.player;
  }

  if(!isDefined(var_2.movespeedscale)) {
    var_2.movespeedscale = 1.0;
  }

  var_3 = _id_0322::movespeed_get_func;
  var_4 = _id_0322::movespeed_set_func;
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

    while(_abs(var_6 - var_5) > _abs(var_10 * 1.1)) {
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

  if(!isPlayer(var_1)) {
    var_1 = level.player;
  }

  if(!isDefined(var_1.movespeedscale)) {
    return;
  }
  var_1 blend_movespeedscale(1.0, var_0);
  waittillframeend;
  var_1.movespeedscale = undefined;
}

teleport_ent(var_0) {
  if(isPlayer(self)) {
    self setOrigin(var_0.origin);
    self setplayerangles(var_0.angles);
  } else
    self forceteleport(var_0.origin, var_0.angles);
}

teleport_to_ent_tag(var_0, var_1) {
  var_2 = var_0 gettagorigin(var_1);
  var_3 = var_0 gettagangles(var_1);
  self dontinterpolate();

  if(isPlayer(self)) {
    self setOrigin(var_2);
    self setplayerangles(var_3);
  } else if(_isai(self))
    self forceteleport(var_2, var_3);
  else {
    self.origin = var_2;
    self.angles = var_3;
  }
}

teleport_ai(var_0) {
  self forceteleport(var_0.origin, var_0.angles);
  self setgoalpos(var_0.origin);
  self setgoalnode(var_0);
}

move_all_fx(var_0) {
  foreach(var_2 in level.createfxent) {
    var_2.v["origin"] = var_2.v["origin"] + var_0;
  }
}

issliding() {
  return isDefined(self.slidemodel);
}

beginsliding(var_0, var_1, var_2) {
  var_3 = self;
  var_3 thread play_sound_on_entity("foot_slide_plr_start");

  if(_soundexists("foot_slide_plr_loop")) {
    var_3 thread play_loop_sound_on_tag("foot_slide_plr_loop");
  }

  var_4 = isDefined(level.custom_linkto_slide);

  if(!isDefined(var_0)) {
    var_0 = var_3 getvelocity() + (0, 0, -10);
  }

  if(!isDefined(var_1)) {
    var_1 = 10;
  }

  if(!isDefined(var_2)) {
    if(isDefined(level.slide_dampening)) {
      var_2 = level.slide_dampening;
    } else {
      var_2 = 0.035;
    }
  }

  var_5 = spawn("script_origin", var_3.origin);
  var_5.angles = var_3.angles;
  var_3.slidemodel = var_5;
  var_5 moveslide((0, 0, 15), 15, var_0);

  if(var_4) {
    var_3 playerlinktoblend(var_5, undefined, 1);
  } else {
    var_3 playerlinkTo(var_5);
  }

  var_3 disableweapons();
  var_3 allowprone(0);
  var_3 allowcrouch(1);
  var_3 allowstand(0);
  var_3 thread _id_0322::doslide(var_5, var_1, var_2);
}

endsliding() {
  var_0 = self;
  var_0 notify("stop soundfoot_slide_plr_loop");
  var_0 thread play_sound_on_entity("foot_slide_plr_end");
  var_0 unlink();
  var_0 setvelocity(var_0.slidemodel._id_0182);
  var_0.slidemodel delete();
  var_0 enableweapons();
  var_0 allowprone(1);
  var_0 allowcrouch(1);
  var_0 allowstand(1);
  var_0 notify("stop_sliding");
}

spawn_vehicle() {
  return _id_0323::vehicle_spawn(self);
}

_id_44CC(var_0) {
  var_1 = _id_0319::get_load_trigger_classes();
  var_2 = [];

  foreach(var_6, var_4 in var_1) {
    if(!issubstr(var_6, "flag")) {
      continue;
    }
    var_5 = getEntArray(var_6, "classname");
    var_2 = common_scripts\utility::_id_0F73(var_2, var_5);
  }

  var_7 = undefined;

  foreach(var_9 in var_2) {
    if(var_9.getnegotiationnextnode == var_0) {
      return var_9;
    }
  }
}

_id_44C4(var_0) {
  var_1 = _id_0319::get_load_trigger_classes();
  var_2 = [];

  foreach(var_6, var_4 in var_1) {
    if(!issubstr(var_6, "flag")) {
      continue;
    }
    var_5 = getEntArray(var_6, "classname");
    var_2 = common_scripts\utility::_id_0F73(var_2, var_5);
  }

  var_7 = [];

  foreach(var_9 in var_2) {
    if(var_9.getnegotiationnextnode == var_0) {
      var_7[var_7.size] = var_9;
    }
  }

  return var_7;
}

set_z(var_0, var_1) {
  return (var_0[0], var_0[1], var_1);
}

_id_098D(var_0, var_1) {
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

  if(!isDefined(var_0)) {
    return 0;
  }

  if(issubstr(_tolower(var_0), "rpg")) {
    return 1;
  }

  if(issubstr(_tolower(var_0), "stinger")) {
    return 1;
  }

  if(issubstr(_tolower(var_0), "javelin")) {
    return 1;
  }

  return 0;
}

doinglongdeath() {
  return isDefined(self._id_0794.doinglongdeath);
}

get_rumble_ent(var_0, var_1) {
  if(is_coop()) {}

  var_2 = get_player_from_self();

  if(!isDefined(var_0)) {
    var_0 = "steady_rumble";
  }

  var_3 = spawn("script_origin", var_2 getEye());

  if(!isDefined(var_1) || !_isnumber(var_1)) {
    var_3.intensity = 1;
  } else {
    var_3.intensity = var_1;
  }

  var_3 thread _id_0322::update_rumble_intensity(var_2, var_0);
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

  for(var_5 = 0; var_5 < var_2; var_5++) {
    self.intensity = self.intensity + var_4;
    waitframe();
  }

  self.intensity = var_0;
}

get_player_from_self() {
  if(isDefined(self)) {
    if(!is_in_array(level.players, self)) {
      return level.player;
    } else {
      return self;
    }
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

  if(!isDefined(var_0)) {
    var_0 = self.model + "_obj";
  }

  self setModel(var_0);
}

stopglow(var_0) {
  if(!isDefined(self.non_glow_model)) {
    return;
  }
  self setModel(self.non_glow_model);
  self.non_glow_model = undefined;
}

_id_0F7C(var_0, var_1, var_2) {
  var_3 = [];
  var_1 = var_2 - var_1;

  foreach(var_5 in var_0) {
    var_3[var_3.size] = var_5;

    if(var_3.size == var_2) {
      var_3 = common_scripts\utility::array_randomize(var_3);

      for(var_6 = var_1; var_6 < var_3.size; var_6++) {
        var_3[var_6] delete();
      }

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
  if(!isDefined(var_2)) {
    var_2 = 0.5;
  }

  self endon("death");

  while(isDefined(self)) {
    if(distance(var_0, self.origin) <= var_1) {
      break;
    }

    wait(var_2);
  }
}

_id_561A(var_0, var_1) {
  var_2 = _func_2E1(var_1, self);

  if(distancesquared(var_1, var_2) > 576) {
    return 0;
  }

  var_3 = _func_2E1(var_0, self);

  if(!_func_2DE(var_3, var_2, self) && _func_2DC(var_3, var_2, self)) {
    return 0;
  }

  return 1;
}

_id_097C(var_0) {
  var_1 = spawnStruct();
  var_1 thread _id_0322::_id_097D(var_0);
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

  if(!isDefined(level.trace_fx[var_0][var_6])) {
    var_6 = "default";
  }

  var_7 = level.trace_fx[var_0][var_6];

  if(isDefined(var_7["fx"])) {
    playFX(var_7["fx"], var_5["position"], var_5["normal"]);
  }

  if(isDefined(var_7["fx_array"])) {
    foreach(var_9 in var_7["fx_array"]) {
      playFX(var_9, var_5["position"], var_5["normal"]);
    }
  }

  if(isDefined(var_7["sound"])) {
    level thread common_scripts\utility::play_sound_in_space(var_7["sound"], var_5["position"]);
  }

  if(isDefined(var_7["rumble"])) {
    var_11 = get_player_from_self();
    var_11 playRumbleOnEntity(var_7["rumble"]);
  }
}

disable_surprise() {
  self.newenemyreactiondistsq = 0;
}

enable_surprise() {
  self.newenemyreactiondistsq = _squared(512);
}

_id_2F4F() {
  if(!isPlayer(self)) {
    return;
  }
  _id_02DC::_id_9A77(0);
}

_id_3635() {
  if(!isPlayer(self)) {
    return;
  }
  _id_02DC::_id_9A77(1);
}

_id_362A(var_0) {}

_id_2F41() {}

getvehiclearray() {
  return _vehicle_getarray();
}

hint(var_0, var_1, var_2) {
  if(!isDefined(var_2)) {
    var_2 = 0;
  }

  var_3 = 0.5;
  level endon("clearing_hints");

  if(isDefined(level.hintelement)) {
    level.hintelement _id_02C6::destroyelem();
  }

  level.hintelement = _id_02C6::createfontstring("default", 1.5);
  level.hintelement _id_02C6::setpoint("MIDDLE", undefined, 0, 30 + var_2);
  level.hintelement.color = (1, 1, 1);
  level.hintelement settext(var_0);
  level.hintelement.alpha = 0;
  level.hintelement fadeovertime(0.5);
  level.hintelement.alpha = 1;
  wait 0.5;
  level.hintelement endon("death");

  if(isDefined(var_1)) {
    wait(var_1);
  } else {
    return;
  }

  level.hintelement fadeovertime(var_3);
  level.hintelement.alpha = 0;
  wait(var_3);
  level.hintelement _id_02C6::destroyelem();
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

kill_deathflag(var_0, var_1, var_2) {
  if(!isDefined(level.flag[var_0])) {
    return;
  }
  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  foreach(var_4 in level._id_2AA2[var_0]) {
    foreach(var_6 in var_4) {
      if(isalive(var_6)) {
        var_6 thread _id_0322::kill_deathflag_proc(var_1, var_2);
        continue;
      }

      var_6 delete();
    }
  }
}

get_player_view_controller(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_3)) {
    var_3 = "player_view_controller";
  }

  if(!isDefined(var_2)) {
    var_2 = (0, 0, 0);
  }

  var_4 = var_0 gettagorigin(var_1);
  var_5 = _spawnturret("misc_turret", var_4, var_3);
  var_5.angles = var_0 gettagangles(var_1);
  var_5 setModel("tag_turret");
  var_5 linkTo(var_0, var_1, var_2, (0, 0, 0));
  var_5 makeunusable();
  var_5 hide();
  var_5 setmode("manual");
  return var_5;
}

create_blend(var_0, var_1, var_2, var_3) {
  var_4 = spawnStruct();
  var_4 childthread _id_0322::process_blend(var_0, self, var_1, var_2, var_3);
  return var_4;
}

set_unstorable_weapon(var_0, var_1) {
  if(!isDefined(self.unstorable_weapons)) {
    self.unstorable_weapons = [];
  }

  if(!isDefined(var_1) || var_1) {
    self.unstorable_weapons[var_0] = 1;
  } else {
    self.unstorable_weapons[var_0] = undefined;
  }
}

is_unstorable_weapon(var_0) {
  if(!isDefined(self.unstorable_weapons)) {
    return 0;
  }

  return isDefined(self.unstorable_weapons[var_0]);
}

store_players_weapons(var_0) {
  if(!isDefined(self.stored_weapons)) {
    self.stored_weapons = [];
  }

  if(!isDefined(self.unstorable_weapons)) {
    self.unstorable_weapons = [];
  }

  var_1 = [];
  var_2 = self getweaponlistall();
  var_3 = self getcurrentweapon();
  var_4 = self getlethalweapon();
  var_5 = self getoffhandsecondaryclass();

  foreach(var_7 in var_2) {
    if(isDefined(self.unstorable_weapons[var_7])) {
      continue;
    }
    var_1[var_7] = [];
    var_1[var_7]["clip_left"] = self getweaponammoclip(var_7, "left");
    var_1[var_7]["clip_right"] = self getweaponammoclip(var_7, "right");
    var_1[var_7]["stock"] = self getweaponammostock(var_7);
  }

  if(!isDefined(var_0)) {
    var_0 = "default";
  }

  self.stored_weapons[var_0] = [];

  if(isDefined(self.unstorable_weapons[var_3])) {
    var_9 = self getweaponlistprimaries();

    foreach(var_7 in var_9) {
      if(!isDefined(self.unstorable_weapons[var_7])) {
        var_3 = var_7;
        break;
      }
    }
  }

  self.stored_weapons[var_0]["current_weapon"] = var_3;
  self.stored_weapons[var_0]["inventory"] = var_1;
  self.stored_weapons[var_0]["lethal_offhand"] = var_4;
  self.stored_weapons[var_0]["tactical_offhand"] = var_5;
}

restore_players_weapons(var_0) {
  if(!isDefined(var_0)) {
    var_0 = "default";
  }

  if(!isDefined(self.stored_weapons) || !isDefined(self.stored_weapons[var_0])) {
    return;
  }
  self takeallweapons();

  foreach(var_3, var_2 in self.stored_weapons[var_0]["inventory"]) {
    if(weaponinventorytype(var_3) != "altmode") {
      self giveweapon(var_3);
    }

    self setweaponammoclip(var_3, var_2["clip_left"], "left");
    self setweaponammoclip(var_3, var_2["clip_right"], "right");
    self setweaponammostock(var_3, var_2["stock"]);
  }

  var_4 = self.stored_weapons[var_0]["current_weapon"];

  if(var_4 != "none") {
    self switchtoweapon(var_4);
  }

  self setlethalweapon(self.stored_weapons[var_0]["lethal_offhand"]);
  self setoffhandsecondaryclass(self.stored_weapons[var_0]["tactical_offhand"]);
}

_id_4353() {
  var_0 = self getweaponlistall();

  if(isDefined(self.unstorable_weapons)) {
    foreach(var_2 in var_0) {
      if(isDefined(self.unstorable_weapons[var_2])) {
        var_0 = common_scripts\utility::_id_0F93(var_0, var_2);
      }
    }
  }

  return var_0;
}

_id_4354() {
  var_0 = self getweaponlistprimaries();

  if(isDefined(self.unstorable_weapons)) {
    foreach(var_2 in var_0) {
      if(isDefined(self.unstorable_weapons[var_2])) {
        var_0 = common_scripts\utility::_id_0F93(var_0, var_2);
      }
    }
  }

  return var_0;
}

_id_4352() {
  var_0 = self getcurrentprimaryweapon();

  if(isDefined(self.unstorable_weapons) && isDefined(self.unstorable_weapons[var_0])) {
    var_0 = get_first_storable_weapon();
  }

  return var_0;
}

_id_4351() {
  var_0 = self getcurrentweapon();

  if(isDefined(self.unstorable_weapons) && isDefined(self.unstorable_weapons[var_0])) {
    var_0 = get_first_storable_weapon();
  }

  return var_0;
}

get_first_storable_weapon() {
  var_0 = _id_4354();

  if(var_0.size > 0) {
    var_1 = var_0[0];
  } else {
    var_1 = "none";
  }

  return var_1;
}

hide_entity() {
  switch (self._id_003B) {
    case "light_spot":
    case "script_vehicle":
    case "script_model":
      self hide();
      break;
    case "script_brushmodel":
      self hide();
      self notsolid();

      if(self.spawnflags & 1) {
        self connectpaths();
      }

      break;
    case "trigger_multiple_flag_looking":
    case "trigger_multiple_flag_lookat":
    case "trigger_multiple_breachIcon":
    case "trigger_multiple_flag_set":
    case "trigger_use":
    case "trigger_multiple":
    case "trigger_use_touch":
    case "trigger_radius":
      common_scripts\utility::trigger_off();
      break;
    default:
  }
}

show_entity() {
  switch (self._id_003B) {
    case "light_spot":
    case "script_vehicle":
    case "script_model":
      self show();
      break;
    case "script_brushmodel":
      self show();
      self solid();

      if(self.spawnflags & 1) {
        self disconnectPaths();
      }

      break;
    case "trigger_multiple_flag_looking":
    case "trigger_multiple_flag_lookat":
    case "trigger_multiple_breachIcon":
    case "trigger_multiple_flag_set":
    case "trigger_use":
    case "trigger_multiple":
    case "trigger_use_touch":
    case "trigger_radius":
      common_scripts\utility::trigger_on();
      break;
    default:
  }
}

_id_06B0(var_0, var_1, var_2, var_3) {
  if(isDefined(var_3)) {
    self rotateYaw(var_0, var_1, var_2, var_3);
  } else if(isDefined(var_2)) {
    self rotateYaw(var_0, var_1, var_2);
  } else {
    self rotateYaw(var_0, var_1);
  }
}

worldweaponsloaded(var_0, var_1, var_2) {
  self notify("set_moveplaybackrate");
  self endon("set_moveplaybackrate");

  if(isDefined(var_2) && var_2) {
    thread enablegrenadethrowback(var_0, var_1);
  }

  if(!isDefined(self.moveplaybackrate_orig)) {
    self.moveplaybackrate_orig = self.moveplaybackrate;
  }

  if(isDefined(var_1)) {
    var_3 = var_0 - self.moveplaybackrate;
    var_4 = 0.05;
    var_5 = var_1 / var_4;
    var_6 = var_3 / var_5;

    while(_abs(var_0 - self.moveplaybackrate) > _abs(var_6 * 1.1)) {
      self.moveplaybackrate = self.moveplaybackrate + var_6;
      wait(var_4);
    }
  }

  self.moveplaybackrate = var_0;
}

restore_moveplaybackrate(var_0, var_1) {
  self notify("set_moveplaybackrate");
  self endon("set_moveplaybackrate");

  if(isDefined(var_1) && var_1) {
    thread restore_movetransitionrate(var_0);
  }

  worldweaponsloaded(self.moveplaybackrate_orig, var_0, 0);
  self.moveplaybackrate_orig = undefined;
}

enablegrenadethrowback(var_0, var_1) {
  self notify("set_moveplaybackrate");
  self endon("set_moveplaybackrate");

  if(!isDefined(self.movetransitionrate_orig)) {
    self.movetransitionrate_orig = self.movetransitionrate;
  }

  if(isDefined(var_1)) {
    var_2 = var_0 - self.movetransitionrate;
    var_3 = 0.05;
    var_4 = var_1 / var_3;
    var_5 = var_2 / var_4;

    while(_abs(var_0 - self.movetransitionrate) > _abs(var_5 * 1.1)) {
      self.movetransitionrate = self.movetransitionrate + var_5;
      wait(var_3);
    }
  }

  self.movetransitionrate = var_0;
}

restore_movetransitionrate(var_0) {
  self notify("set_moveplaybackrate");
  self endon("set_moveplaybackrate");
  enablegrenadethrowback(self.movetransitionrate_orig, var_0);
  self.movetransitionrate_orig = undefined;
}

_id_0FAA(var_0, var_1, var_2, var_3, var_4, var_5) {
  foreach(var_7 in var_0) {
    var_7 thread _id_0961(var_1, var_2, var_3, var_4, var_5);
  }
}

_id_0FAC(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = getEntArray(var_0, "targetname");
  _id_0FAA(var_6, var_1, var_2, var_3, var_4, var_5);
}

_id_0FAB(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = getEntArray(var_0, "script_noteworthy");
  _id_0FAA(var_6, var_1, var_2, var_3, var_4, var_5);
}

_id_3619() {
  if(_id_0290::_id_0AAE()) {
    _id_0290::_id_0A83(1);
    return;
  }

  self._id_3247 = 1;
}

_id_2F32() {
  if(_id_0290::_id_0AAE()) {
    _id_0290::_id_0A83(0);
    return;
  }

  self._id_3247 = undefined;
}

create_sunflare_setting(var_0) {
  if(!isDefined(level.sunflare_settings)) {
    level.sunflare_settings = [];
  }

  var_1 = spawnStruct();
  var_1.name = var_0;
  level.sunflare_settings[var_0] = var_1;
  return var_1;
}

create_vision_set_fog(var_0) {
  if(!isDefined(level.vision_set_fog)) {
    level.vision_set_fog = [];
  }

  var_1 = spawnStruct();
  var_1.name = var_0;
  var_1.atmosfogextinctiondesaturation = 0.0;
  var_1.atmosfogheightfogmaximumoffset = 0.0;
  var_1.atmosfogheightfogstrengthofdepthfog = 0.0;
  var_1.atmosfogentityscale = 1.0;
  var_1.atmosfogairlightcapacity = 0;
  var_1.atmosfogairlightdensityscalar = 1.0;
  var_1.atmosfogairlightvertexinnermutedradius = 0.0;
  var_1.atmosfogsplineenabled = 0;
  var_1.atmosfogsplinecustomdistance1 = 0.0;
  var_1.atmosfogsplinecustomdistance2 = 0.0;
  var_1.atmosfogsplinecustomdistance3 = 0.0;
  var_1.atmosfogsplinemaxdistance = 0.0;
  var_1.atmosfogsplinecustomvisibility1 = 0.0;
  var_1.atmosfogsplinecustomvisibility2 = 0.0;
  var_1.atmosfogsplinecustomvisibility3 = 0.0;
  var_1.atmosfogsplinemaxdistancevisibility = 0.0;
  var_1.atmosfogsplineusemaxdistancevisibilityoverride = 0;
  var_1.atmosfogsplinemaxdistancevisibilityoverride = (0, 0, 0);
  var_1.atmosfogsplinecustomtangentsenabled = 0;
  var_1.atmosfogsplinestartingtangentangle = 0.0;
  var_1.atmosfogsplinecustomtangentangle1 = 0.0;
  var_1.atmosfogsplinecustomtangentangle2 = 0.0;
  var_1.atmosfogsplinecustomtangentangle3 = 0.0;
  var_1.atmosfogsplinemaxdistancetangentangle = 0.0;
  level.vision_set_fog[_tolower(var_0)] = var_1;
  return var_1;
}

get_vision_set_fog(var_0) {
  if(!isDefined(level.vision_set_fog)) {
    level.vision_set_fog = [];
  }

  var_1 = level.vision_set_fog[_tolower(var_0)];

  if(using_hdr_fog() && isDefined(var_1) && isDefined(var_1.hdroverride)) {
    var_1 = level.vision_set_fog[_tolower(var_1.hdroverride)];
  }

  return var_1;
}

create_fog(var_0) {
  if(!isDefined(level.fog_set)) {
    level.fog_set = [];
  }

  var_1 = spawnStruct();
  var_1.name = var_0;
  level.fog_set[_tolower(var_0)] = var_1;
  return var_1;
}

get_fog(var_0) {
  if(!isDefined(level.fog_set)) {
    level.fog_set = [];
  }

  var_1 = level.fog_set[_tolower(var_0)];
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
  if(!isDefined(level.console)) {
    set_console_status();
  }

  return is_gen4();
}

fog_set_changes(var_0, var_1) {
  if(!isPlayer(self)) {
    _id_0298::init_fog_transition();
  } else {
    init_self_fog_transition();
  }

  if(!isDefined(level.fog_set)) {
    level.fog_set = [];
  }

  var_2 = level.fog_set[_tolower(var_0)];

  if(!isDefined(var_2)) {
    var_2 = level.vision_set_fog[_tolower(var_0)];
  }

  if(isDefined(var_2) && isDefined(var_2.hdroverride) && using_hdr_fog()) {
    if(isDefined(level.fog_set[_tolower(var_2.hdroverride)])) {
      var_2 = level.fog_set[_tolower(var_2.hdroverride)];
    } else if(isDefined(level.vision_set_fog)) {
      var_2 = level.vision_set_fog[_tolower(var_2.hdroverride)];
    }
  }

  if(!isDefined(var_1)) {
    var_1 = var_2.transitiontime;
  }

  if(!isPlayer(self)) {
    common_scripts\utility::finishentitydamage(var_2, var_1);
    level.fog_transition_ent.fogset = var_0;
    level.fog_transition_ent.time = var_1;
  } else {
    if(var_0 != "" && self.fog_transition_ent.fogset == var_0 && self.fog_transition_ent.time == var_1) {
      return;
    }
    common_scripts\utility::finishentitydamage(var_2, var_1);
    self.fog_transition_ent.fogset = var_0;
    self.fog_transition_ent.time = var_1;
  }
}

vision_set_fog_changes(var_0, var_1) {
  var_2 = vision_set_changes(var_0, var_1);

  if(var_2) {
    if(isDefined(get_vision_set_fog(var_0))) {
      fog_set_changes(var_0, var_1);
    } else {
      _clearfog(var_1);
    }
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
  if(!isPlayer(self)) {
    var_2 = 1;

    if(!isDefined(level.vision_set_transition_ent)) {
      level.vision_set_transition_ent = spawnStruct();
      level.vision_set_transition_ent.vision_set = "";
      level.vision_set_transition_ent.time = 0;
      var_2 = 0;
    }

    if(var_0 != "" && level.vision_set_transition_ent.vision_set == var_0 && level.vision_set_transition_ent.time == var_1) {
      return 0;
    }

    level.vision_set_transition_ent.vision_set = var_0;
    level.vision_set_transition_ent.time = var_1;

    if(var_2 && getdvarint("scr_art_tweak") != 0) {} else
      _visionsetnaked(var_0, var_1);

    level.lvl_visionset = var_0;
    setDvar("vision_set_current", var_0);
  } else {
    init_self_visionset();

    if(var_0 != "" && self.vision_set_transition_ent.vision_set == var_0 && self.vision_set_transition_ent.time == var_1) {
      return 0;
    }

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
    waitframe();
  }
}

disable_teamflashbangimmunity() {
  self.teamflashbangimmunity = undefined;
}

_id_06A4(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_4)) {
    radiusdamage(var_0, var_1, var_2, var_3);
  } else {
    radiusdamage(var_0, var_1, var_2, var_3, var_4);
  }
}

mask_destructibles_in_volumes(var_0) {
  var_1 = getEntArray("destructible_toy", "targetname");
  var_2 = getEntArray("destructible_vehicle", "targetname");
  var_3 = common_scripts\utility::_id_0F73(var_1, var_2);

  foreach(var_5 in var_0) {
    var_5._id_2E27 = [];
  }

  foreach(var_8 in var_3) {
    foreach(var_5 in var_0) {
      if(!var_5 istouching(var_8)) {
        continue;
      }
      var_5 _id_0322::_id_77C4(var_8);
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
    var_2 = common_scripts\utility::_id_0F73(var_2, var_5);
  }

  foreach(var_8 in var_2) {
    if(!isDefined(level._id_065F[var_8.interactive_type].setmode)) {
      continue;
    }
    foreach(var_11 in var_0) {
      if(!var_11 istouching(var_8)) {
        continue;
      }
      if(!isDefined(var_11.interactives)) {
        var_11.interactives = [];
      }

      var_11.interactives[var_11.interactives.size] = var_8[[level._id_065F[var_8.interactive_type].setmode]]();
    }
  }
}

_id_0896() {
  if(!isDefined(self.interactives)) {
    return;
  }
  foreach(var_1 in self.interactives) {
    var_1[[level._id_065F[var_1.interactive_type].loadfromstructfn]]();
  }

  self.interactives = undefined;
}

delete_interactives_in_volumes(var_0) {
  mask_interactives_in_volumes(var_0);

  foreach(var_2 in var_0) {
    var_2.interactives = undefined;
  }
}

mask_exploders_in_volume(var_0) {
  if(getDvar("1459") != "") {
    return;
  }
  var_1 = getEntArray("script_brushmodel", "classname");
  var_2 = getEntArray("script_model", "classname");

  for(var_3 = 0; var_3 < var_2.size; var_3++) {
    var_1[var_1.size] = var_2[var_3];
  }

  foreach(var_5 in var_0) {
    foreach(var_7 in var_1) {
      if(isDefined(var_7.physicslaunchserver)) {
        var_7.setdepthoffield = var_7.physicslaunchserver;
      }

      if(!isDefined(var_7.setdepthoffield)) {
        continue;
      }
      if(!isDefined(var_7.model)) {
        continue;
      }
      if(var_7._id_003B != "script_model") {
        continue;
      }
      if(!var_7 istouching(var_5)) {
        continue;
      }
      var_7.masked_exploder = 1;
    }
  }
}

_id_0892() {
  foreach(var_1 in level.createfxent) {
    if(!isDefined(var_1.v["masked_exploder"])) {
      continue;
    }
    if(!self _meth_858B(var_1.v["origin"])) {
      continue;
    }
    var_2 = var_1.v["masked_exploder"];
    var_3 = var_1.v["masked_exploder_spawnflags"];
    var_4 = var_1.v["masked_exploder_script_disconnectpaths"];
    var_5 = spawn("script_model", (0, 0, 0), var_3);
    var_5 setModel(var_2);
    var_5.origin = var_1.v["origin"];
    var_5.angles = var_1.v["angles"];
    var_1.v["masked_exploder"] = undefined;
    var_1.v["masked_exploder_spawnflags"] = undefined;
    var_1.v["masked_exploder_script_disconnectpaths"] = undefined;
    var_5.disconnect_paths = var_4;
    var_5.setdepthoffield = var_1.v["exploder"];
    common_scripts\_exploder::setup_individual_exploder(var_5);
    var_1.model = var_5;
  }
}

precache_destructible(var_0) {
  var_1 = _id_0286::destructible_getinfoindex(var_0);

  if(var_1 != -1) {
    return;
  }
  if(!isDefined(level.destructible_functions)) {
    level.destructible_functions = [];
  }

  var_2 = spawnStruct();
  var_2.destuctableinfo = _id_0286::destructible_gettype(var_0);
  var_2 thread _id_0286::precache_destructibles();
  var_2 thread _id_0286::_id_091C();
}

delete_destructibles_in_volumes(var_0, var_1) {
  foreach(var_3 in var_0) {
    var_3._id_2E27 = [];
  }

  var_5 = ["destructible_toy", "destructible_vehicle"];
  var_6 = 0;

  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  foreach(var_8 in var_5) {
    var_9 = getEntArray(var_8, "targetname");

    foreach(var_11 in var_9) {
      foreach(var_3 in var_0) {
        if(var_1) {
          var_6++;
          var_6 = var_6 % 5;

          if(var_6 == 1) {
            waitframe();
          }
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

  for(var_4 = 0; var_4 < var_3.size; var_4++) {
    var_2[var_2.size] = var_3[var_4];
  }

  var_5 = [];
  var_6 = spawn("script_origin", (0, 0, 0));
  var_7 = 0;

  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  foreach(var_9 in var_0) {
    foreach(var_11 in var_2) {
      if(!isDefined(var_11.setdepthoffield)) {
        continue;
      }
      var_6.origin = var_11 getorigin();

      if(!var_9 istouching(var_6)) {
        continue;
      }
      var_5[var_5.size] = var_11;
    }
  }

  _id_0F7B(var_5);
  var_6 delete();
}

_id_0890() {
  if(!isDefined(self._id_2E27)) {
    return;
  }
  foreach(var_1 in self._id_2E27) {
    var_2 = spawn("script_model", (0, 0, 0));
    var_2 setModel(var_1.toy_model);
    var_2.origin = var_1.origin;
    var_2.angles = var_1.angles;
    var_2._id_0165 = var_1._id_0165;
    var_2.targetname = var_1.targetname;
    var_2.target = var_1.target;
    var_2.script_exploder = var_1.script_exploder;
    var_2._id_0075 = var_1._id_0075;
    var_2.setjitterparams = var_1.setjitterparams;
    var_2 _id_0286::setup_destructibles(1);
  }

  self._id_2E27 = [];
}

setflashbangimmunity(var_0) {
  self.flashbangimmunity = var_0;
}

flashbanggettimeleftsec() {
  var_0 = self.flashendtime - gettime();

  if(var_0 < 0) {
    return 0;
  }

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

  if(isDefined(self.flashendtime)) {
    self.flashendtime = max(self.flashendtime, var_1);
  } else {
    self.flashendtime = var_1;
  }

  self notify("flashed");
  self setflashbanged(1);
}

waittill_volume_dead() {
  for(;;) {
    var_0 = _getaispeciesarray("axis", "all");
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

    waitframe();
  }
}

waittill_volume_dead_or_dying() {
  var_0 = 0;

  for(;;) {
    var_1 = _getaispeciesarray("axis", "all");
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

    waitframe();
  }

  return var_0;
}

waittill_volume_dead_then_set_flag(var_0) {
  waittill_volume_dead();
  common_scripts\utility::flag_set(var_0);
}

waittill_targetname_volume_dead_then_set_flag(var_0, var_1) {
  var_2 = _getEnt(var_0, "targetname");
  var_2 waittill_volume_dead_then_set_flag(var_1);
}

player_can_be_shot() {
  level.player common_scripts\utility::ent_flag_clear("player_zero_attacker_accuracy");
  level.player._id_00D1 = 0;
  level.player _id_02BA::update_player_attacker_accuracy();
}

player_cant_be_shot() {
  level.player common_scripts\utility::ent_flag_set("player_zero_attacker_accuracy");
  level.player._id_0022 = 0;
  level.player._id_00D1 = 1;
}

isnoclip(var_0) {
  var_1 = get_player_from_self();
  var_1.gs.player_attacker_accuracy = var_0;
  var_1 _id_02BA::update_player_attacker_accuracy();
}

_id_0F84(var_0) {
  var_1 = [];

  foreach(var_3 in var_0) {
    var_1[var_3.setlookatent] = var_3;
  }

  return var_1;
}

_id_0F83(var_0) {
  var_1 = [];

  foreach(var_3 in var_0) {
    var_1[var_3.classname] = var_3;
  }

  return var_1;
}

_id_0F85(var_0) {
  var_1 = [];

  foreach(var_3 in var_0) {
    var_4 = var_3.setmovespeedscale;

    if(isDefined(var_4)) {
      var_1[var_4] = var_3;
    }
  }

  return var_1;
}

_id_096D(var_0) {
  if(isDefined(var_0)) {
    self.pivot = var_0;
  } else {
    self.pivot = _getEnt(self.target, "targetname");
  }

  self linkTo(self.pivot);
}

flashbangstop() {
  self.flashendtime = undefined;
  self setflashbanged(0);
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
  _playrumbleonposition("grenade_rumble", var_0);
  _earthquake(0.3, 0.5, var_0, 400);

  foreach(var_2 in level.players) {
    if(distance(var_0, var_2.origin) > 600) {
      continue;
    }
    if(var_2 damageconetrace(var_0)) {
      var_2 thread dirteffect(var_0);
    }
  }
}

player_rides_shotgun_in_humvee(var_0, var_1, var_2, var_3) {
  return player_rides_in_humvee("shotgun", level.player, var_0, var_1, var_2, var_3);
}

player_rides_in_humvee(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(var_1)) {
    var_1 = level.player;
  }

  var_1 allowcrouch(0);
  var_1 allowprone(0);
  var_1 disableweapons();
  var_6 = common_scripts\utility::spawn_tag_origin();
  var_6 linkTo(self, "tag_passenger", player_rides_in_humvee_offset(var_0), (0, 0, 0));
  var_6.player_dismount = common_scripts\utility::spawn_tag_origin();
  var_6.player_dismount linkTo(self, "tag_body", player_rides_humvee_offset_dismount(var_0), (0, 0, 0));

  if(!isDefined(var_2)) {
    var_2 = 90;
  }

  if(!isDefined(var_3)) {
    var_3 = 90;
  }

  if(!isDefined(var_4)) {
    var_4 = 40;
  }

  if(!isDefined(var_5)) {
    var_5 = 40;
  }

  var_1 disableweapons();
  var_1 playerlinkTo(var_6, "tag_origin", 0.8, var_2, var_3, var_4, var_5);
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
  if(!isDefined(var_0)) {
    var_0 = 0;
  }

  var_1 = self;
  var_2 = level.player;

  if(isPlayer(self)) {
    var_2 = self;
    var_1 = var_2.humvee_org;
  }

  var_1 unlink();

  if(!var_0) {
    var_3 = 0.6;
    var_1 moveTo(var_1.player_dismount.origin, var_3, var_3 * 0.5, var_3 * 0.5);
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
  var_2 = enablebreaching(var_0);

  foreach(var_5, var_4 in var_2) {
    thread _id_02BA::grenade_dirt_on_screen(var_5);
  }
}

bloodsplateffect(var_0) {
  if(!isDefined(self._id_0063)) {
    return;
  }
  var_1 = enablebreaching(self._id_0063.origin);

  foreach(var_4, var_3 in var_1) {
    thread _id_02BA::blood_splat_on_screen(var_4);
  }
}

enablebreaching(var_0) {
  var_1 = vectorNormalize(anglesToForward(self.angles));
  var_2 = vectorNormalize(anglestoright(self.angles));
  var_3 = vectorNormalize(var_0 - self.origin);
  var_4 = vectordot(var_3, var_1);
  var_5 = vectordot(var_3, var_2);
  var_6 = [];
  var_7 = self getcurrentweapon();

  if(var_4 > 0 && var_4 > 0.5 && _weapontype(var_7) != "riotshield") {
    var_6["bottom"] = 1;
  }

  if(_abs(var_4) < 0.866) {
    if(var_5 > 0) {
      var_6["right"] = 1;
    } else {
      var_6["left"] = 1;
    }
  }

  return var_6;
}

pathrandompercent_set(var_0) {
  if(!isDefined(self.old_pathrandompercent)) {
    self.old_pathrandompercent = self._id_0121;
  }

  self._id_0121 = var_0;
}

pathrandompercent_zero() {
  if(isDefined(self.old_pathrandompercent)) {
    return;
  }
  self.old_pathrandompercent = self._id_0121;
  self._id_0121 = 0;
}

pathrandompercent_reset() {
  self._id_0121 = self.old_pathrandompercent;
  self.old_pathrandompercent = undefined;
}

walkdist_zero() {
  if(isDefined(self.old_walkdistfacingmotion)) {
    return;
  }
  self.old_walkdist = self._id_01CE;
  self.old_walkdistfacingmotion = self._id_01CF;
  self._id_01CE = 0;
  self._id_01CF = 0;
}

walkdist_force_walk() {
  if(!isDefined(self.old_walkdistfacingmotion)) {
    self.old_walkdist = self._id_01CE;
    self.old_walkdistfacingmotion = self._id_01CF;
  }

  self._id_01CE = 999999999;
  self._id_01CF = 999999999;
}

is_walkdist_override() {
  return isDefined(self.old_walkdistfacingmotion) || isDefined(self.old_walkdist);
}

walkdist_reset() {
  self._id_01CE = self.old_walkdist;
  self._id_01CF = self.old_walkdistfacingmotion;
  self.old_walkdist = undefined;
  self.old_walkdistfacingmotion = undefined;
}

enable_ignorerandombulletdamage_drone() {
  thread ignorerandombulletdamage_drone_proc();
}

ignorerandombulletdamage_drone_proc() {
  self endon("disable_ignorerandombulletdamage_drone");
  self endon("death");
  self._id_00D1 = 1;
  self.fakehealth = self.health;
  self.health = 1000000;

  for(;;) {
    self waittill("damage", var_0, var_1);

    if(!isPlayer(var_1) && _issentient(var_1)) {
      if(isDefined(var_1._id_0088) && var_1._id_0088 != self) {
        continue;
      }
    }

    self.fakehealth = self.fakehealth - var_0;

    if(self.fakehealth <= 0) {
      break;
    }
  }

  self kill();
}

turretsetbarrelspinenabled(var_0) {
  self._id_01C0 = var_0;
}

disable_ignorerandombulletdamage_drone() {
  if(!isalive(self)) {
    return;
  }
  if(!isDefined(self._id_00D1)) {
    return;
  }
  self notify("disable_ignorerandombulletdamage_drone");
  self._id_00D1 = undefined;
  self.health = self.fakehealth;
}

timeoutent(var_0) {
  var_1 = spawnStruct();
  var_1 delaythread(var_0, ::setanimstate, "timeout");
  return var_1;
}

delaythread(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  thread _id_0322::delaythread_proc(var_1, var_0, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
}

delaychildthread(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  childthread _id_0322::delaychildthread_proc(var_1, var_0, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
}

flagwaitthread(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  self endon("death");

  if(!_isarray(var_0)) {
    var_0 = [var_0, 0];
  }

  thread _id_0322::flagwaitthread_proc(var_1, var_0, var_2, var_3, var_4, var_5, var_6, var_7);
}

waittillthread(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  self endon("death");

  if(!_isarray(var_0)) {
    var_0 = [var_0, 0];
  }

  thread _id_0322::waittillthread_proc(var_1, var_0, var_2, var_3, var_4, var_5, var_6, var_7);
}

enable_danger_react(var_0) {
  var_0 = var_0 * 1000;
  self._id_007C = 1;
  self._id_006E = var_0;
  self.neversprintforvariation = undefined;
}

disable_danger_react() {
  self._id_007C = 0;
  self.neversprintforvariation = 1;
}

vehicle_getcurrentnode(var_0, var_1) {
  level._id_0A19 = var_0;
  level._id_0A18 = var_1;
}

reset_group_advance_to_enemy_timer(var_0) {
  level.lastadvancetoenemytime[var_0] = gettime();
}

set_custom_gameskill_func(var_0) {
  level.custom_gameskill_func = var_0;
  thread _id_02BA::resetskill();
}

clear_custom_gameskill_func() {
  level.custom_gameskill_func = undefined;
  thread _id_02BA::resetskill();
}

set_wind(var_0, var_1, var_2) {
  _id_0295::init_wind_if_uninitialized();

  if(isDefined(var_2)) {
    level.wind.variance = var_2;
  }

  level.wind.rate = var_1;
  level.wind.weight = var_0;
  level notify("windchange", "strong");
}

string_is_single_digit_integer(var_0) {
  if(var_0.size > 1) {
    return 0;
  }

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

  if(isDefined(var_1[var_0])) {
    return 1;
  }

  return 0;
}

disablemissileboosting(var_0, var_1) {
  level.battlechatter[var_0] = var_1;
  _id_0322::update_battlechatter_hud();
}

objective_clearadditionalpositions(var_0) {
  for(var_1 = 0; var_1 < 8; var_1++) {
    _objective_additionalposition(var_0, var_1, (0, 0, 0));
  }
}

_id_6909(var_0, var_1) {
  _objective_additionalposition(var_0, var_1, (0, 0, 0));
}

get_minutes_and_seconds(var_0) {
  var_1 = [];
  var_1["minutes"] = 0;

  for(var_1["seconds"] = int(var_0 / 1000); var_1["seconds"] >= 60; var_1["seconds"] = var_1["seconds"] - 60) {
    var_1["minutes"]++;
  }

  if(var_1["seconds"] < 10) {
    var_1["seconds"] = "0" + var_1["seconds"];
  }

  return var_1;
}

player_has_weapon(var_0) {
  var_1 = level.player getweaponlistprimaries();

  foreach(var_3 in var_1) {
    if(var_3 == var_0) {
      return 1;
    }
  }

  return 0;
}

obj(var_0) {
  if(var_0 == "main") {
    return 31;
  }

  if(!isDefined(level.obj_array)) {
    level.obj_array = [];
  }

  if(!isDefined(level.obj_array[var_0])) {
    level.obj_array[var_0] = level.obj_array.size + 1;
  }

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
  var_1 = tablelookup("sound/soundlength.csv", 0, var_0, 1);

  if(!isDefined(var_1) || var_1 == "") {
    return -1;
  }

  var_1 = int(var_1);
  var_1 = var_1 * 0.001;
  return var_1;
}

is_command_bound(var_0) {
  var_1 = _getkeybinding(var_0);
  return var_1["count"];
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
  var_2 = _getEnt(var_0, "script_noteworthy");
  var_2 notify("new_volume_command");
  var_2 endon("new_volume_command");
  waitframe();
  fx_volume_pause(var_2, var_1);
}

fx_volume_pause(var_0, var_1) {
  var_0.fx_paused = 1;

  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  if(var_1) {
    _id_0FB3(var_0.fx, common_scripts\utility::pauseeffect);
  } else {
    common_scripts\utility::_id_0FB2(var_0.fx, common_scripts\utility::pauseeffect);
  }
}

_id_0FB3(var_0, var_1, var_2) {
  var_3 = 0;

  if(!isDefined(var_2)) {
    var_2 = 5;
  }

  var_4 = [];

  foreach(var_6 in var_0) {
    var_4[var_4.size] = var_6;
    var_3++;
    var_3 = var_3 % var_2;

    if(var_2 == 0) {
      common_scripts\utility::_id_0FB2(var_4, var_1);
      waitframe();
      var_4 = [];
    }
  }
}

fx_volume_restart_noteworthy(var_0) {
  thread fx_volume_restart_noteworthy_thread(var_0);
}

fx_volume_restart_noteworthy_thread(var_0) {
  var_1 = _getEnt(var_0, "script_noteworthy");
  var_1 notify("new_volume_command");
  var_1 endon("new_volume_command");
  waitframe();

  if(!isDefined(var_1.fx_paused)) {
    return;
  }
  var_1.fx_paused = undefined;
  fx_volume_restart(var_1);
}

fx_volume_restart(var_0) {
  common_scripts\utility::_id_0FB2(var_0.fx, ::restarteffect);
}

flag_count_increment(var_0) {
  if(!isDefined(level.flag_count)) {
    level.flag_count = [];
  }

  if(!isDefined(level.flag_count[var_0])) {
    level.flag_count[var_0] = 1;
  } else {
    level.flag_count[var_0]++;
  }
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

_id_090C(var_0, var_1) {
  if(!isDefined(level.cleanup_ents)) {
    level.cleanup_ents = [];
  }

  if(!isDefined(level.cleanup_ents[var_1])) {
    level.cleanup_ents[var_1] = [];
  }

  level.cleanup_ents[var_1][level.cleanup_ents[var_1].size] = var_0;
}

cleanup_ents(var_0) {
  var_1 = level.cleanup_ents[var_0];
  var_1 = common_scripts\utility::_id_0FA0(var_1);
  _id_0F7B(var_1);
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
  var_1 = common_scripts\utility::_id_0FA0(var_1);

  foreach(var_3 in var_1) {
    if(!_isai(var_3)) {
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

  _id_0F7B(var_1);
  level.cleanup_ents[var_0] = undefined;
}

_id_0980(var_0) {
  if(!isDefined(self.trigger_functions)) {
    thread _id_0322::_id_097F();
  }

  self.trigger_functions[self.trigger_functions.size] = var_0;
}

getallweapons() {
  var_0 = [];
  var_1 = getEntArray();

  foreach(var_3 in var_1) {
    if(!isDefined(var_3.classname)) {
      continue;
    }
    if(issubstr(var_3.classname, "weapon_")) {
      var_0[var_0.size] = var_3;
    }
  }

  return var_0;
}

radio_add(var_0) {
  level.forceusehintoff[var_0] = var_0;
}

move_with_rate(var_0, var_1, var_2) {
  self notify("newmove");
  self endon("newmove");

  if(!isDefined(var_2)) {
    var_2 = 200;
  }

  var_3 = distance(self.origin, var_0);
  var_4 = var_3 / var_2;
  var_5 = vectorNormalize(var_0 - self.origin);
  self moveTo(var_0, var_4, 0, 0);
  self rotateTo(var_1, var_4, 0, 0);
  wait(var_4);

  if(!isDefined(self)) {
    return;
  }
  self._id_01C9 = var_5 * (var_3 / var_4);
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
  return isDefined(level.damagefeedbackhud) && level.damagefeedbackhud && getdifficulty() != "fu";
}

enable_damagefeedback_snd() {
  level.damagefeedbacksnd = 1;
}

disable_damagefeedback_snd() {
  level.damagefeedbacksnd = 0;
}

is_damagefeedback_snd_enabled() {
  return isDefined(level.damagefeedbacksnd) && level.damagefeedbacksnd && getdifficulty() != "fu";
}

_id_0915() {
  _id_02A7::monitordamage();
}

remove_damagefeedback() {
  _id_02A7::stopmonitordamage();
}

is_demo() {
  if(getDvar("2803") == "1") {
    return 1;
  }

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
  var_1 = var_0._id_0164;

  if(isDefined(var_1) && isDefined(level.struct_class_names["script_linkname"]) && isDefined(level.struct_class_names["script_linkname"][var_1])) {
    foreach(var_4, var_3 in level.struct_class_names["script_linkname"][var_1]) {
      if(isDefined(var_3) && var_0 == var_3) {
        level.struct_class_names["script_linkname"][var_1][var_4] = undefined;
      }
    }

    if(level.struct_class_names["script_linkname"][var_1].size == 0) {
      level.struct_class_names["script_linkname"][var_1] = undefined;
    }
  }

  var_1 = var_0._id_0165;

  if(isDefined(var_1) && isDefined(level.struct_class_names["script_noteworthy"]) && isDefined(level.struct_class_names["script_noteworthy"][var_1])) {
    foreach(var_4, var_3 in level.struct_class_names["script_noteworthy"][var_1]) {
      if(isDefined(var_3) && var_0 == var_3) {
        level.struct_class_names["script_noteworthy"][var_1][var_4] = undefined;
      }
    }

    if(level.struct_class_names["script_noteworthy"][var_1].size == 0) {
      level.struct_class_names["script_noteworthy"][var_1] = undefined;
    }
  }

  var_1 = var_0.target;

  if(isDefined(var_1) && isDefined(level.struct_class_names["target"]) && isDefined(level.struct_class_names["target"][var_1])) {
    foreach(var_4, var_3 in level.struct_class_names["target"][var_1]) {
      if(isDefined(var_3) && var_0 == var_3) {
        level.struct_class_names["target"][var_1][var_4] = undefined;
      }
    }

    if(level.struct_class_names["target"][var_1].size == 0) {
      level.struct_class_names["target"][var_1] = undefined;
    }
  }

  var_1 = var_0.targetname;

  if(isDefined(var_1) && isDefined(level.struct_class_names["targetname"]) && isDefined(level.struct_class_names["targetname"][var_1])) {
    foreach(var_4, var_3 in level.struct_class_names["targetname"][var_1]) {
      if(isDefined(var_3) && var_0 == var_3) {
        level.struct_class_names["targetname"][var_1][var_4] = undefined;
      }
    }

    if(level.struct_class_names["targetname"][var_1].size == 0) {
      level.struct_class_names["targetname"][var_1] = undefined;
    }
  }

  if(isDefined(level.struct)) {
    foreach(var_4, var_3 in level.struct) {
      if(var_0 == var_3) {
        level.struct[var_4] = undefined;
      }
    }
  }
}

deletestructarray_ref(var_0, var_1) {
  if(!isDefined(var_0) || !_isarray(var_0) || var_0.size == 0) {
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
    foreach(var_3 in var_0) {
      deletestruct_ref(var_3);
    }
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

setentityheadicon(var_0, var_1, var_2, var_3, var_4) {
  if(isDefined(var_3)) {
    self.entityheadiconoffset = var_3;
  } else {
    self.entityheadiconoffset = (0, 0, 0);
  }

  if(isDefined(var_4)) {
    self.entityheadiconreferencefunc = var_4;
  }

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

    waitframe();
  }
}

updateentityheadiconorigin() {
  if(isDefined(self.entityheadiconreferencefunc)) {
    var_0 = self[[self.entityheadiconreferencefunc]]();

    if(isDefined(var_0)) {
      self.entityheadicon.x = self.entityheadiconoffset[0] + var_0[0];
      self.entityheadicon.y = self.entityheadiconoffset[1] + var_0[1];
      self.entityheadicon._id_01D9 = self.entityheadiconoffset[2] + var_0[2];
      return;
    }
  }

  self.entityheadicon.x = self.origin[0] + self.entityheadiconoffset[0];
  self.entityheadicon.y = self.origin[1] + self.entityheadiconoffset[1];
  self.entityheadicon._id_01D9 = self.origin[2] + self.entityheadiconoffset[2];
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

intro_screen_create(var_0, var_1, var_2, var_3, var_4) {
  level.introscreen = spawnStruct();
  level.introscreen.completed_delay = 3;
  level.introscreen.fade_out_time = 1.5;
  level.introscreen.fade_in_time = undefined;

  if(isDefined(var_3)) {
    level.introscreen.lines = [var_0, var_1, var_2, var_3];
  } else {
    level.introscreen.lines = [var_0, var_1, var_2];
  }

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

finishagentdamage_impactfx(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(isDefined(var_1)) {
    self.run_overrideanim = var_1;
  }

  if(isDefined(var_2)) {
    self.walk_overrideanim = var_2;
  }

  if(isDefined(var_3)) {
    self.specialidleanim = var_3;
  }

  self._id_0E94 = var_0;
  var_10 = [];

  if(isDefined(var_4) && isDefined(var_5)) {
    var_11 = [];

    foreach(var_13 in var_6) {
      var_11[var_13] = var_4;
    }

    var_10["cover_trans"] = var_11;
    var_15 = [];

    foreach(var_13 in var_6) {
      var_15[var_13] = var_5;
    }

    var_10["cover_exit"] = var_15;
  } else if(isDefined(var_4) || isDefined(var_5)) {}

  if(isDefined(var_7)) {
    if(isDefined(var_8)) {}

    var_10["run_turn"] = var_7;
    var_10["walk_turn"] = var_8;
    self.noturnanims = undefined;
  } else if(isDefined(var_8)) {} else
    self.noturnanims = 1;

  if(isDefined(var_9)) {
    var_18 = [];
    var_18["stairs_up"] = var_9["stairs_up"];
    var_18["stairs_down"] = var_9["stairs_down"];
    var_18["stairs_up_in"] = var_9["stairs_up_in"];
    var_18["stairs_down_in"] = var_9["stairs_down_in"];
    var_18["stairs_up_out"] = var_9["stairs_up_out"];
    var_18["stairs_down_out"] = var_9["stairs_down_out"];
    var_10["walk"] = var_18;
    var_10["run"] = var_18;
    self.run_overrideanim_hasstairanimarray = 1;
  } else
    self.run_overrideanim_hasstairanimarray = undefined;

  anim._id_0F4A[var_0] = var_10;
}

clear_npc_anims(var_0) {
  self._id_0E94 = undefined;
  anim._id_0F4A[var_0] = undefined;
  self.run_overrideanim = undefined;
  self.run_overrideanim_hasstairanimarray = undefined;
  self.walk_overrideanim = undefined;
  self.specialidleanim = undefined;
}

_id_7B9B(var_0, var_1, var_2) {}

_id_0F49(var_0) {}

_id_8417(var_0) {}

clear_archetype() {
  if(isDefined(self._id_0E94) && self._id_0E94 == "creepwalk") {
    self._id_017C = 30;
  }

  self._id_0E94 = undefined;
  self notify("move_loop_restart");
}

shot_endangers_any_player(var_0, var_1) {
  foreach(var_3 in level.players) {
    if(var_3 shot_endangers_player(var_0, var_1)) {
      return 1;
    }
  }

  return 0;
}

shot_endangers_player(var_0, var_1, var_2) {
  if(!isDefined(var_2)) {
    var_2 = 60;
  }

  var_3 = self getpointinbounds(0, 0, 0);
  var_4 = var_3 - var_0;
  var_5 = length(var_4);
  var_6 = _asin(clamp(var_2 / var_5, 0, 1));

  if(vectordot(vectorNormalize(var_4), vectorNormalize(var_1 - var_0)) > _cos(var_6)) {
    return 1;
  }

  return 0;
}

transient_load(var_0) {
  _loadtransient(var_0);

  while(!_istransientloaded(var_0)) {
    wait 0.1;
  }

  common_scripts\utility::flag_set(var_0 + "_loaded");
}

transient_unload(var_0) {
  _unloadtransient(var_0);

  while(_istransientloaded(var_0)) {
    wait 0.1;
  }

  common_scripts\utility::flag_clear(var_0 + "_loaded");
}

transient_init(var_0) {
  common_scripts\utility::flag_init(var_0 + "_loaded");
}

transient_switch(var_0, var_1) {
  if(common_scripts\utility::flag(var_0 + "_loaded")) {
    transient_unload(var_0);
  }

  if(!common_scripts\utility::flag(var_1 + "_loaded")) {
    transient_load(var_1);
  }
}

transient_unloadall_and_load(var_0) {
  _unloadalltransients();
  transient_load(var_0);
}

deep_array_call(var_0, var_1, var_2) {
  if(!isDefined(var_2)) {
    foreach(var_4 in var_0) {
      if(isDefined(var_4)) {
        if(_isarray(var_4)) {
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
            if(_isarray(var_4)) {
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
            if(_isarray(var_4)) {
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
            if(_isarray(var_4)) {
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
            if(_isarray(var_4)) {
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
            if(_isarray(var_4)) {
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
            if(_isarray(var_4)) {
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
        if(_isarray(var_4)) {
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
            if(_isarray(var_4)) {
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
            if(_isarray(var_4)) {
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
            if(_isarray(var_4)) {
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
            if(_isarray(var_4)) {
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
            if(_isarray(var_4)) {
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
            if(_isarray(var_4)) {
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
  if(!isDefined(level.console)) {
    set_console_status();
  }

  if(is_gen4()) {
    setDvar(var_0, var_2);
  } else {
    setDvar(var_0, var_1);
  }
}

setsaveddvar_cg_ng(var_0, var_1, var_2) {
  if(!isDefined(level.console)) {
    set_console_status();
  }

  if(is_gen4()) {
    _setsaveddvar(var_0, var_2);
  } else {
    _setsaveddvar(var_0, var_1);
  }
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

  if(!isDefined(var_1)) {
    var_1 = 300;
  }

  self.current_follow_path = var_2;
  var_2 common_scripts\utility::script_delay();

  while(isDefined(var_2)) {
    self.current_follow_path = var_2;

    if(isDefined(var_2._id_00F0)) {
      break;
    }

    if(isDefined(level.struct_class_names["targetname"][var_2.targetname])) {
      var_4 = ::follow_path_animate_set_struct;
    } else if(isDefined(var_2.classname)) {
      var_4 = ::follow_path_animate_set_ent;
    } else {
      var_4 = ::follow_path_animate_set_node;
    }

    if(isDefined(var_2.radius) && var_2.radius != 0) {
      self._id_00AE = var_2.radius;
    }

    if(self._id_00AE < 16) {
      self._id_00AE = 16;
    }

    if(isDefined(var_2._id_00BD) && var_2._id_00BD != 0) {
      self._id_00AC = var_2._id_00BD;
    }

    var_5 = self._id_00AE;
    self childthread[[var_4]](var_2);

    if(isDefined(var_2.animation)) {
      var_2 waittill(var_2.animation);
    } else {
      for(;;) {
        self waittill("goal");

        if(distance(var_2.origin, self.origin) < var_5 + 10 || self.team != "allies") {
          break;
        }
      }
    }

    var_2 notify("trigger", self);

    if(isDefined(var_2.script_flag_set)) {
      common_scripts\utility::flag_set(var_2.script_flag_set);
    }

    if(isDefined(var_2.setlookatent)) {
      var_6 = strtok(var_2.setlookatent, " ");

      for(var_7 = 0; var_7 < var_6.size; var_7++) {
        if(isDefined(level.custom_followpath_parameter_func)) {
          self[[level.custom_followpath_parameter_func]](var_6[var_7], var_2);
        }

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

    if(!isDefined(var_2.vehicle_teleport) && var_1 > 0 && self.team == "allies") {
      while(isalive(level.player)) {
        if(follow_path_wait_for_player(var_2, var_1)) {
          break;
        }

        if(isDefined(var_2.animation)) {
          self._id_00AE = var_5;
          self setgoalpos(self.origin);
        }

        waitframe();
      }
    }

    if(!isDefined(var_2.target)) {
      break;
    }

    if(isDefined(var_2.setgoalentity)) {
      common_scripts\utility::flag_wait(var_2.setgoalentity);
    }

    var_2 common_scripts\utility::script_delay();
    var_2 = var_2 common_scripts\utility::get_target_ent();
  }

  self notify("path_end_reached");
}

follow_path_wait_for_player(var_0, var_1) {
  if(distance(level.player.origin, var_0.origin) < distance(self.origin, var_0.origin)) {
    return 1;
  }

  var_2 = undefined;
  var_2 = anglesToForward(self.angles);
  var_3 = vectorNormalize(level.player.origin - self.origin);

  if(isDefined(var_0.target)) {
    var_4 = common_scripts\utility::get_target_ent(var_0.target);
    var_2 = vectorNormalize(var_4.origin - var_0.origin);
  } else if(isDefined(var_0.angles))
    var_2 = anglesToForward(var_0.angles);
  else {
    var_2 = anglesToForward(self.angles);
  }

  if(vectordot(var_2, var_3) > 0) {
    return 1;
  }

  if(distance(level.player.origin, self.origin) < var_1) {
    return 1;
  }

  return 0;
}

follow_path_animate_set_node(var_0) {
  self notify("follow_path_new_goal");

  if(isDefined(var_0.animation)) {
    var_0 _id_0293::_id_0E0F(self, var_0.animation);
    self notify("starting_anim", var_0.animation);

    if(isDefined(var_0.setlookatent) && issubstr(var_0.setlookatent, "gravity")) {
      var_0 _id_0293::_id_0E0B(self, var_0.animation);
    } else {
      var_0 _id_0293::_id_0E11(self, var_0.animation);
    }

    self setgoalpos(self.origin);
  } else
    setdemigod(var_0);
}

follow_path_animate_set_ent(var_0) {
  self notify("follow_path_new_goal");

  if(isDefined(var_0.animation)) {
    var_0 _id_0293::_id_0E0F(self, var_0.animation);
    self notify("starting_anim", var_0.animation);

    if(isDefined(var_0.setlookatent) && issubstr(var_0.setlookatent, "gravity")) {
      var_0 _id_0293::_id_0E0B(self, var_0.animation);
    } else {
      var_0 _id_0293::_id_0E11(self, var_0.animation);
    }

    self setgoalpos(self.origin);
  } else
    vehicle_gettopspeed(var_0);
}

follow_path_animate_set_struct(var_0) {
  self notify("follow_path_new_goal");

  if(isDefined(var_0.animation)) {
    var_0 _id_0293::_id_0E0F(self, var_0.animation);
    self notify("starting_anim", var_0.animation);
    disable_exits();

    if(isDefined(var_0.setlookatent) && issubstr(var_0.setlookatent, "gravity")) {
      var_0 _id_0293::_id_0E0B(self, var_0.animation);
    } else {
      var_0 _id_0293::_id_0E11(self, var_0.animation);
    }

    delaythread(0.05, ::enable_exits);
    self setgoalpos(self.origin);
  } else
    setviewmodelanim(var_0.origin);
}

post_load_precache(var_0) {
  if(!isDefined(level.post_load_funcs)) {
    level.post_load_funcs = [];
  }

  level.post_load_funcs = common_scripts\utility::_id_0F6F(level.post_load_funcs, var_0);
}

lerpfov_saved(var_0, var_1) {
  thread lerpfov_saved_thread(var_0, var_1);
}

lerpfov_saved_thread(var_0, var_1) {
  self notify("new_lerp_Fov_Saved");
  self endon("new_lerp_Fov_Saved");
  self lerpfov(var_0, var_1);
  wait(var_1);
  _setsaveddvar("cg_fov", var_0);
}

getdvarfloatdefault(var_0, var_1) {
  var_2 = getDvar(var_0);

  if(var_2 != "") {
    return _float(var_2);
  }

  return var_1;
}

getdvarintdefault(var_0, var_1) {
  var_2 = getDvar(var_0);

  if(var_2 != "") {
    return int(var_2);
  }

  return var_1;
}

ui_action_slot_force_active_on(var_0) {
  var_1 = "ui_actionslot_" + var_0 + "_forceActive";
  setDvar(var_1, "on");
}

ui_action_slot_force_active_off(var_0) {
  var_1 = "ui_actionslot_" + var_0 + "_forceActive";
  setDvar(var_1, "turn_off");
}

ui_action_slot_force_active_one_time(var_0) {
  var_1 = "ui_actionslot_" + var_0 + "_forceActive";
  setDvar(var_1, "onetime");
}

stylized_center_text(var_0, var_1, var_2, var_3) {
  if(!_isarray(var_0)) {
    var_0 = [var_0];
  }

  var_4 = 320;
  var_5 = 200;
  var_6 = [];

  foreach(var_10, var_8 in var_0) {
    var_9 = _id_02CB::stylized_line(var_8, var_1, var_4, var_5 + var_10 * 20, "center", var_2, var_3);
    var_6 = common_scripts\utility::_id_0F73(var_9, var_6);
  }

  wait(var_1);
  _id_02CB::stylized_fadeout(var_6, var_4, var_5, var_0.size);
}

_id_2076(var_0) {
  thread _id_02CB::center_screen_lines(var_0);
}

enable_s1_motionset(var_0) {
  if(!clientclaimtrigger()) {
    return;
  }
  if(isDefined(self.mech) && self.mech) {
    return;
  }
  if(!level._id_010B) {
    return;
  }
  if(isDefined(var_0) && var_0) {
    if(!isDefined(self._id_0E94) || self._id_0E94 == "soldier") {
      self._id_0E94 = "s1_soldier";
    }
  } else if(!isDefined(self._id_0E94) || self._id_0E94 == "s1_soldier")
    self._id_0E94 = "soldier";
}

clientclaimtrigger() {
  return 0;
}

_id_0AAA() {
  if(isDefined(self.setthreatbiasgroup)) {
    return;
  }
  if(isDefined(self._id_0651)) {
    _id_0B20();
  }

  self._id_0651 = [];
  self._id_0078 = _id_0322::_id_0AC9(self._id_0078, "disableplayeradsloscheck", 1);
  self._id_00CA = _id_0322::_id_0AC9(self._id_00CA, "ignoreall", 1);
  self._id_00CE = _id_0322::_id_0AC9(self._id_00CE, "ignoreme", 1);
  self._id_00B3 = _id_0322::_id_0AC9(self._id_00B3, "grenadeawareness", 0);
  self._id_0028 = _id_0322::_id_0AC9(self._id_0028, "badplaceawareness", 0);
  self._id_00CC = _id_0322::_id_0AC9(self._id_00CC, "ignoreexplosionevents", 1);
  self._id_00D1 = _id_0322::_id_0AC9(self._id_00D1, "ignorerandombulletdamage", 1);
  self._id_00D2 = _id_0322::_id_0AC9(self._id_00D2, "ignoresuppression", 1);
  self._id_007F = _id_0322::_id_0AC9(self._id_007F, "dontavoidplayer", 1);
  self.newenemyreactiondistsq = _id_0322::_id_0AC9(self.newenemyreactiondistsq, "newEnemyReactionDistSq", 0);
  self._id_2F73 = _id_0322::_id_0AC9(self._id_2F73, "disableBulletWhizbyReaction", 1);
  self.disablefriendlyfirereaction = _id_0322::_id_0AC9(self.disablefriendlyfirereaction, "disableFriendlyFireReaction", 1);
  self.dontmelee = _id_0322::_id_0AC9(self.dontmelee, "dontMelee", 1);
  self.flashbangimmunity = _id_0322::_id_0AC9(self.flashbangimmunity, "flashBangImmunity", 1);
  self._id_007C = _id_0322::_id_0AC9(self._id_007C, "doDangerReact", 0);
  self.neversprintforvariation = _id_0322::_id_0AC9(self.neversprintforvariation, "neverSprintForVariation", 1);
  self._id_0794.disablepain = _id_0322::_id_0AC9(self._id_0794.disablepain, "a.disablePain", 1);
  self._id_0016 = _id_0322::_id_0AC9(self._id_0016, "allowPain", 0);
  self._id_0098 = _id_0322::_id_0AC9(self._id_0098, "fixedNode", 1);
  self.enableaimassist = _id_0322::_id_0AC9(self.enableaimassist, "script_forcegoal", 1);
  self._id_00AE = _id_0322::_id_0AC9(self._id_00AE, "goalradius", 5);
  disable_ai_color();
}

_id_0B20(var_0) {
  if(isDefined(self.setthreatbiasgroup)) {
    return;
  }
  if(isDefined(var_0) && var_0) {
    if(isDefined(self._id_0651)) {
      self._id_0651 = undefined;
    }
  }

  self._id_0078 = _id_0322::_id_0AC7("disableplayeradsloscheck", 0);
  self._id_00CA = _id_0322::_id_0AC7("ignoreall", 0);
  self._id_00CE = _id_0322::_id_0AC7("ignoreme", 0);
  self._id_00B3 = _id_0322::_id_0AC7("grenadeawareness", 1);
  self._id_0028 = _id_0322::_id_0AC7("badplaceawareness", 1);
  self._id_00CC = _id_0322::_id_0AC7("ignoreexplosionevents", 0);
  self._id_00D1 = _id_0322::_id_0AC7("ignorerandombulletdamage", 0);
  self._id_00D2 = _id_0322::_id_0AC7("ignoresuppression", 0);
  self._id_007F = _id_0322::_id_0AC7("dontavoidplayer", 0);
  self.newenemyreactiondistsq = _id_0322::_id_0AC7("newEnemyReactionDistSq", 262144);
  self._id_2F73 = _id_0322::_id_0AC7("disableBulletWhizbyReaction", undefined);
  self.disablefriendlyfirereaction = _id_0322::_id_0AC7("disableFriendlyFireReaction", undefined);
  self.dontmelee = _id_0322::_id_0AC7("dontMelee", undefined);
  self.flashbangimmunity = _id_0322::_id_0AC7("flashBangImmunity", undefined);
  self._id_007C = _id_0322::_id_0AC7("doDangerReact", 1);
  self.neversprintforvariation = _id_0322::_id_0AC7("neverSprintForVariation", undefined);
  self._id_0794.disablepain = _id_0322::_id_0AC7("a.disablePain", 0);
  self._id_0016 = _id_0322::_id_0AC7("allowPain", 1);
  self._id_0098 = _id_0322::_id_0AC7("fixedNode", 0);
  self.enableaimassist = _id_0322::_id_0AC7("script_forcegoal", 0);
  self._id_00AE = _id_0322::_id_0AC7("goalradius", 100);
  enable_ai_color();
  self._id_0651 = undefined;
}

attach_player_current_weapon_to_anim_tag(var_0) {
  var_1 = level.player getcurrentweapon();
  var_2 = _getweaponandattachmentmodels(var_1);
  var_3 = var_2[0]["weapon"];
  var_4 = common_scripts\utility::_id_0F9A(var_2, 0);
  self attach(var_3, var_0, 1);

  foreach(var_6 in var_4) {
    self attach(var_6["attachment"], var_6["attachTag"]);
  }

  self hideweapontags(var_1);
}

_id_113B(var_0, var_1, var_2) {
  var_3 = self;
  var_4 = _getweaponandattachmentmodels(var_0);

  if(!isDefined(var_2) || var_2 == 0) {
    var_5 = var_4[0]["weapon"];
  } else {
    var_5 = var_4[0]["worldModel"];
  }

  var_6 = common_scripts\utility::_id_0F9A(var_4, 0);
  var_3 attach(var_5, var_1, 1);

  foreach(var_9, var_8 in var_6) {
    if(!isDefined(var_2) || var_2 == 0) {
      var_3 attach(var_8["attachment"], var_8["attachTag"]);
      continue;
    }

    var_3 attach(var_8["worldModel"], var_8["attachTag"]);
  }
}

playerallowweaponpickup(var_0, var_1) {
  _id_0693("weaponPickup", var_0, var_1, ::_id_0599, 0);
}

_id_0599(var_0) {
  if(var_0) {
    self enableweaponpickup();
  } else {
    self disableweaponpickup();
  }
}

_id_0693(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(self.playerdisableabilitytypes)) {
    self.playerdisableabilitytypes = [];
  }

  if(!isDefined(self.playerdisableabilitytypes[var_0])) {
    self.playerdisableabilitytypes[var_0] = [];
  }

  if(!isDefined(var_2)) {
    var_2 = "default";
  }

  if(var_1) {
    self.playerdisableabilitytypes[var_0] = common_scripts\utility::_id_0F93(self.playerdisableabilitytypes[var_0], var_2);

    if(!self.playerdisableabilitytypes[var_0].size) {
      if(!isDefined(var_4) || var_4) {
        self call[[var_3]](1);
      } else {
        self[[var_3]](1);
      }
    }
  } else {
    if(!isDefined(common_scripts\utility::_id_0F7E(self.playerdisableabilitytypes[var_0], var_2))) {
      self.playerdisableabilitytypes[var_0] = common_scripts\utility::_id_0F6F(self.playerdisableabilitytypes[var_0], var_2);
    }

    if(!isDefined(var_4) || var_4) {
      self call[[var_3]](0);
    } else {
      self[[var_3]](0);
    }
  }
}

pretend_to_be_dead() {
  if(!isalive(self)) {
    return;
  }
  self.pretending_to_be_dead = 1;
  self setthreatdetection("disable");
  self disableaimassist();
  self._id_00CE = 1;
  self.ignoresonicaoe = 1;
}

tff_sync_setup() {
  _precacheshader("loading_animation");
  common_scripts\utility::flag_init("tff_sync_complete");
  _id_0322::_id_072D();
}

tff_sync(var_0) {
  if(isDefined(var_0)) {
    wait(var_0);
  }

  if(_aretransientsbusy()) {
    common_scripts\utility::flag_clear("tff_sync_complete");
    _synctransients();

    while(_aretransientsbusy()) {
      waitframe();
    }

    common_scripts\utility::flag_set("tff_sync_complete");
  }
}

tff_sync_notetrack(var_0, var_1) {
  tff_sync(var_1);
}

logbreadcrumbdatasp() {
  level.player endon("death");

  for(;;) {
    var_0 = _getspcheckpointdata();
    var_1 = var_0[4];
    var_2 = gettime();
    _recordbreadcrumbdataforplayersp(level.player, var_1, var_2);
    wait 2;
  }
}

_id_44C6(var_0) {
  if(!isDefined(var_0)) {
    return undefined;
  }

  return _getEnt(var_0, "targetname");
}

_id_45B3(var_0) {
  if(!isDefined(var_0)) {
    return undefined;
  }

  return _getnode(var_0, "targetname");
}

_id_45B2(var_0) {
  if(!isDefined(var_0)) {
    return undefined;
  }

  return _getnode(var_0, "script_noteworthy");
}

_id_44C3(var_0) {
  if(!isDefined(var_0)) {
    return undefined;
  }

  return getEntArray(var_0, "targetname");
}

_id_44C5(var_0) {
  if(!isDefined(var_0)) {
    return undefined;
  }

  return _getEnt(var_0, "script_noteworthy");
}

_id_44C2(var_0) {
  if(!isDefined(var_0)) {
    return undefined;
  }

  return getEntArray(var_0, "script_noteworthy");
}

_id_4677(var_0) {
  if(!isDefined(var_0)) {
    return undefined;
  }

  var_1 = _getscriptablearray(var_0, "targetname");
  return var_1[0];
}

_id_4676(var_0) {
  if(!isDefined(var_0)) {
    return undefined;
  }

  var_1 = _getscriptablearray(var_0, "script_noteworthy");
  return var_1[0];
}

_id_9437(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  level endon("end_story_mode");
  var_8 = 0;

  if(!isDefined(var_1)) {
    var_1 = 150;
  }

  if(var_1 == 0) {
    var_8 = 1;
  }

  if(!isDefined(var_6)) {
    var_6 = 0;
  }

  if(!isDefined(var_7)) {
    var_7 = 0;
  }

  if(!var_8) {
    while(distance(level.player.origin, var_0) > var_1) {
      waitframe();
    }
  }

  if(!isDefined(var_3)) {
    var_3 = 0.3;
  }

  if(!isDefined(var_2)) {
    var_2 = 0.01;
  }

  if(!isDefined(var_4)) {
    var_4 = 0.3;
  }

  if(!isDefined(var_5)) {
    var_5 = 0.3;
  }

  level.player enableslowaim(var_4, var_5);
  level.player blend_movespeedscale(var_3, 0.5);
  _id_727E(1);
  level.player allowsprint(var_6);
  level.player allowdodge(var_6);
  level.player allowjump(var_6);
  level.player allowprone(var_6);
  level.player allowmelee(var_7);
  level.player allowfire(var_7);
  level.player allowads(var_7);

  if(isDefined(var_7) || var_7 != 1) {
    level.player disableoffhandweapons();
  }

  wait 0.5;

  if(!var_8) {
    var_9 = distance(level.player.origin, var_0) - var_1;
    var_10 = 0;
    var_11 = 1;
    var_12 = 0;

    for(;;) {
      if(distance(level.player.origin, var_0) > var_1) {
        var_13 = distance(level.player.origin, var_0);
        var_13 = var_13 - var_1;

        if(var_13 < var_9) {
          var_10 = 0;
          level.player blend_movespeedscale(var_3, 0.5);
        } else if(!var_10) {
          var_10 = 1;
          blend_movespeedscale(var_2, 0.5);
        }

        var_9 = var_13;
      } else {
        level.player setmovespeedscale(var_3);
        var_9 = distance(level.player.origin, var_0) - var_1;
      }

      waitframe();
    }
  }
}

_id_9436(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_0)) {
    var_0 = 1;
  }

  if(!isDefined(var_1)) {
    var_1 = 1;
  }

  if(!isDefined(var_2)) {
    var_2 = 1;
  }

  if(!isDefined(var_3)) {
    var_3 = 0;
  }

  level notify("end_story_mode");
  level.player enableslowaim(var_1, var_2);
  level.player blend_movespeedscale(var_0, 2);
  _id_727E(var_3);
  level.player allowsprint(1);
  level.player allowdodge(1);
  level.player allowjump(1);
  level.player allowprone(1);
  level.player allowmelee(1);
  level.player allowfire(1);
  level.player allowads(1);
  level.player enableoffhandweapons();
}

_id_727E(var_0) {
  if(!isDefined(var_0) || !var_0) {
    _setsaveddvar("414", -1);
  } else {
    _setsaveddvar("414", 0);
  }
}

_id_9438(var_0, var_1, var_2, var_3, var_4, var_5) {
  level endon("end_speed_control");
  level thread _id_4981(var_2);
  level thread _id_9437(level.player.origin, 0, 0.23, 0.24, 0.7, 0.7, var_4, var_5);
  var_0 thread _id_90E5();
  wait 0.1;
  var_6 = 0.01;

  if(!isDefined(var_3)) {
    var_3 = 0.8;
  }

  var_7 = 0;
  var_8 = 220;
  var_9 = 130;
  var_10 = 20;
  var_11 = 200;
  level.player setmovespeedscale(0.3);

  if(!isDefined(var_4)) {
    var_4 = 0;
  }

  level.player allowsprint(var_4);
  level._id_3DD2 = getEntArray(var_1, "script_noteworthy");

  for(;;) {
    if(var_4) {
      if(distancesquared(level.player.origin, var_0.origin) > var_9 * var_9) {
        level.player allowsprint(1);
      } else {
        level.player allowsprint(0);
      }
    }

    if(level._id_3DD0 || level._id_3DD1 || level._id_3DCF) {
      var_12 = vectorNormalize(anglesToForward(_sortbydistance(level._id_3DD2, var_0._id_00AD)[0].angles) + vectorNormalize(var_0.origin - level.player.origin));
      var_13 = 0 - _id_8C51(var_0.origin, var_12, level.player.origin);
      wait 0.1;
    } else {
      var_12 = vectorNormalize(anglesToForward(var_0.angles) + vectorNormalize(var_0.origin - level.player.origin));
      var_13 = 0 - _id_8C51(var_0.origin, var_12, level.player.origin);
    }

    var_14 = common_scripts\utility::linear_map_clamp(var_13, var_7, var_8, var_6, var_3);
    waittillframeend;
    level.player setmovespeedscale(var_14);
    waitframe();
  }

  level.player setmovespeedscale(1);
}

_id_4981(var_0) {
  common_scripts\utility::flag_wait(var_0);
  _id_9436();
  level notify("end_speed_control");
}

_id_90E5() {
  var_0 = 20;
  var_1 = var_0 * var_0;
  level endon("end_speed_control");
  level._id_3DD0 = 0;
  childthread _id_90E7();
  childthread _id_90E6();
  wait 0.2;

  for(;;) {
    self waittill("goal");
    level._id_3DD0 = 1;
    self waittill("goal_changed");
    level._id_3DD0 = 0;
    wait 3;
  }
}

_id_90E6() {
  level endon("end_speed_control");
  level._id_3DD1 = 0;

  for(;;) {
    common_scripts\utility::waittill_either("goal_changed", "goal");
    level._id_3DD1 = 1;
    wait 3;
    level._id_3DD1 = 0;
  }
}

_id_90E7() {
  level endon("end_speed_control");
  var_0 = 0;
  var_1 = 150;
  var_2 = var_1 * var_1;
  level._id_3DCF = 0;

  for(;;) {
    self waittill("goal_changed");
    level._id_3DCF = 0;
    var_0 = 1;

    while(var_0) {
      if(distancesquared(self.origin, self._id_00AD) < var_2) {
        var_0 = 0;
      }

      waitframe();
    }

    level._id_3DCF = 1;
  }
}

_id_8C51(var_0, var_1, var_2) {
  return vectordot(var_2 - var_0, var_1);
}

_id_2312(var_0, var_1) {
  var_2 = 15;

  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  var_3 = 70;

  if(self getstance() == "crouch") {
    var_3 = 50;
  } else if(self getstance() == "prone") {
    var_3 = 30;
  }

  var_4 = var_3 * 0.5;
  return _id_2311(var_0, self.origin + (0, 0, var_4), var_2 - var_1, var_4);
}

_id_2311(var_0, var_1, var_2, var_3) {
  var_4 = var_0 - var_1;

  if(_abs(var_4[2]) <= var_3 - var_2) {
    var_5 = (var_4[0], var_4[1], 0);

    if(_lengthsquared(var_5) > var_2 * var_2) {
      var_0 = var_1 + vectorNormalize(var_5) * var_2;
      var_0 = (var_0[0], var_0[1], var_1[2] + var_4[2]);
    }
  } else if(var_4[2] > 0) {
    var_6 = var_1 + (0, 0, var_3 - var_2);
    var_4 = var_0 - var_6;

    if(_lengthsquared(var_4) > var_2 * var_2) {
      var_0 = var_6 + vectorNormalize(var_4) * var_2;
    }
  } else {
    var_6 = var_1 - (0, 0, var_3 - var_2);
    var_4 = var_0 - var_6;

    if(_lengthsquared(var_4) > var_2 * var_2) {
      var_0 = var_6 + vectorNormalize(var_4) * var_2;
    }
  }

  return var_0;
}

_id_1E36(var_0, var_1, var_2, var_3) {
  var_4 = var_3 - var_1;
  var_5 = var_4[2];
  var_4 = (var_4[0], var_4[1], 0);
  var_6 = _lengthsquared(var_4);

  if(var_6 <= 0) {
    if(var_5 < 0.1) {
      return (0, 0, 0);
    }

    return undefined;
  }

  var_7 = _sqrt(var_6);

  if(var_0 > 0) {
    var_0 = var_0 * -1.0;
  }

  var_8 = _squared(_cos(var_2 * -1.0));
  var_9 = _tan(var_2 * -1.0);
  var_10 = _sqrt(var_0 * var_6 / (2 * var_8 * (var_5 - var_7 * var_9)));

  if(common_scripts\utility::_id_55BF(var_10)) {
    return undefined;
  }

  var_11 = _rotatevector((1, 0, 0), (var_2, _vectortoyaw(var_4), 0));
  var_11 = var_11 * var_10;
  return var_11;
}

_id_9A7D(var_0) {
  _id_031E::_id_9A74(var_0);
}

_id_5670(var_0) {
  if(var_0 == "none") {
    return 0;
  }

  return weaponinventorytype(var_0) == "altmode";
}

_id_1801(var_0, var_1, var_2) {
  self endon("death");

  if(!isDefined(var_2)) {
    var_2 = 1;
  }

  if(!_issentient(self) || !isalive(self)) {
    return;
  }
  if(isDefined(self._id_1801) && self._id_1801) {
    return;
  }
  self._id_1801 = 1;

  if(isDefined(var_0)) {
    wait(_randomfloat(var_0));
  }

  var_3 = [];
  var_3[0] = "j_hip_le";
  var_3[1] = "j_hip_ri";
  var_3[2] = "j_head";
  var_3[3] = "j_spine4";
  var_3[4] = "j_elbow_le";
  var_3[5] = "j_elbow_ri";
  var_3[6] = "j_clavicle_le";
  var_3[7] = "j_clavicle_ri";
  var_4 = getdvarint("cg_fov");
  thread _id_1802(common_scripts\utility::random(var_3), undefined);

  if(isDefined(var_1) && _isai(var_1) && isalive(var_1)) {
    if(!level.player worldpointinreticle_circle(var_1.origin, var_4, 500)) {
      var_1 shootblank();
    }
  } else if(var_2) {
    var_5 = "allies";

    if(isDefined(self.team)) {
      if(self.team == "allies" || self.team == "neutral") {
        var_5 = "axis";
      }
    }

    var_6 = _getaiarray(var_5);
    var_6 = _sortbydistance(var_6, level.player.origin, 2000);
    var_6 = common_scripts\utility::array_randomize(var_6);

    foreach(var_8 in var_6) {
      if(!level.player worldpointinreticle_circle(var_8.origin + (0, 0, 50), var_4, 500)) {
        if(isDefined(var_8._id_01D0) && _weapontype(var_8._id_01D0) == "bullet") {
          var_8 shootblank();
          break;
        }
      }
    }
  }

  self dodamage(self.health + 50, self.origin);
}

_id_1802(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = level._effect["bloody_death_impact"];
  }

  _playFXOnTag(var_1, self, var_0);
}

_id_A24C() {
  return getDvar("sm_sunShadowBitDepth") == 16;
}

_id_A24B() {
  return getDvar("sm_spotShadowBitDepth") == 16;
}

sethealth_notmaxhealth(var_0) {
  var_1 = self.maxhealth;
  self.health = var_0;
  self.maxhealth = var_1;
}