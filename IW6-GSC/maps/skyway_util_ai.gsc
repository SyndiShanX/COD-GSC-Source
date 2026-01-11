/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\skyway_util_ai.gsc
*****************************************************/

ally_advance_watcher(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = [];

  if(isarray(self)) {
    var_6 = self;
  }
  else {
    var_6[0] = self;
  }

  level notify(var_0 + "kill");
  level endon(var_0 + "kill");

  if(!common_scripts\utility::flag_exist("flag_allies_moving")) {
    common_scripts\utility::flag_init("flag_allies_moving");
  }

  if(!common_scripts\utility::flag_exist("flag_allies_player_near")) {
    common_scripts\utility::flag_init("flag_allies_player_near");
  }

  var_7 = getent(var_0, "script_noteworthy");

  if(!isDefined(var_7)) {
    var_7 = getent(var_0, "targetname");
  }

  var_8 = 1;

  if(isDefined(var_5) && var_5) {
    var_8 = 0;
  }

  if(isDefined(var_2)) {}

  var_9 = [];

  for(;;) {
    if(isDefined(var_7.script_parameters)) {
      var_7._delay = float(var_7.script_parameters);
    }
    else {
      var_7._delay = 0;
    }

    if(isDefined(var_7.script_namenumber)) {
      var_7._enemy_num = int(var_7.script_namenumber);
    }

    var_7._linked_triggers = [];
    var_9 = common_scripts\utility::array_add(var_9, var_7);

    if(isDefined(var_2)) {
      var_7.flag_end = var_2;
    }

    if(isDefined(var_7.target)) {
      var_10 = getEntArray(var_7.target, "targetname");
      var_11 = undefined;

      foreach(var_13 in var_10) {
        if(var_13.classname == "trigger_multiple_friendly" && isDefined(var_11)) {
          continue;
        }
        if(var_13.classname == "trigger_multiple_friendly") {
          var_11 = var_13;
          continue;
        }

        if(issubstr(var_13.classname, "trigger")) {
          var_7._linked_triggers = common_scripts\utility::array_add(var_7._linked_triggers, var_13);
          continue;
        }
      }

      if(!isDefined(var_11)) {
        break;
      }

      var_7 = var_11;
      continue;
    }

    break;
  }

  if(!isDefined(level._ally_trigs)) {
    level._ally_trigs = [];
  }

  level._ally_trigs[var_0] = var_9;
  common_scripts\utility::flag_set("flag_allies_player_near");
  common_scripts\utility::flag_init(var_0);

  for(var_15 = 0; var_15 < var_9.size; var_15++) {
    var_7 = var_9[var_15];
    var_7._index = var_15;

    if(!isDefined(var_7.flag_end) || isDefined(var_7.flag_end) && !common_scripts\utility::flag(var_7.flag_end)) {
      var_6 ally_advance(var_7, var_1);
    }

    if(var_15 == 0) {
      common_scripts\utility::flag_set(var_0);
    }

    if(var_8 || isDefined(var_7.flag_end) && common_scripts\utility::flag(var_7.flag_end)) {
      if(isDefined(var_7._linked_triggers)) {
        foreach(var_17 in var_7._linked_triggers) {
          if(isDefined(var_17) && !issubstr(var_17.classname, "friendly")) {
            var_17 delete();
          }
        }
      }

      var_7 delete();
    }
  }

  if(isDefined(var_3)) {
    if(isDefined(var_4)) {
      self[[var_3]](var_4);
    }
    else {
      self[[var_3]]();
    }
  }
}

ally_advance(var_0, var_1) {
  if(isDefined(var_0.flag_end)) {
    level endon(var_0.flag_end);
  }

  var_0 thread waittill_trig_or_time_out();

  if(isDefined(var_1) && isDefined(var_0._enemy_num)) {
    var_0 thread waittill_enemy_num_remaining(var_1);
  }

  var_0 waittill("trigger");

  if(var_0._linked_triggers.size > 0) {
    foreach(var_3 in var_0._linked_triggers) {
    var_3 notify("trigger");
    }
  }

  var_0 thread waittill_allies_at_goal(self);
  wait 0.05;
}

waittill_trig_or_time_out() {
  if(isDefined(self.flag_end)) {
    level endon(self.flag_end);
  }

  waittill_time_out();
  common_scripts\utility::flag_wait("flag_allies_player_near");
  self notify("trigger");
}

waittill_time_out() {
  self endon("trigger");

  if(isDefined(self.flag_end)) {
    level endon(self.flag_end);
  }

  common_scripts\utility::flag_wait("flag_allies_player_near");

  if(self._delay == 0) {
    self waittill("trigger");
  }
  else {
    wait(maps\skyway_util::kt_time(self._delay));
  }
}

waittill_enemy_num_remaining(var_0) {
  self endon("trigger");

  if(isDefined(self.flag_end)) {
    level endon(self.flag_end);
  }

  common_scripts\utility::flag_wait("flag_allies_player_near");
  var_1 = [];

  if(isstring(var_0)) {
    if(isDefined(level._enemies[var_0])) {
      var_1 = level._enemies[var_0];
    }
  } else
    var_1 = var_0;

  var_2 = abs(self._enemy_num);
  var_3 = undefined;
  var_4 = 0;

  if(var_2 != self._enemy_num) {
    var_3 = level.player.stats["kills"];
  }

  for(;;) {
    if(isDefined(var_3)) {
      if(level.player.stats["kills"] - var_3 >= var_2) {
        break;
      }
    } else {
      var_1 = maps\_utility::remove_dead_from_array(var_1);

      if(var_1.size <= var_2) {
        break;
      }
    }

    wait 0.05;
  }

  self notify("trigger");
}

waittill_allies_at_goal(var_0) {
  level notify("notify_kill_allies_at_goal");
  level endon("notify_kill_allies_at_goal");

  if(isDefined(self.flag_end)) {
    level endon(self.flag_end);
  }

  common_scripts\utility::flag_set("flag_allies_moving");
  common_scripts\utility::flag_clear("flag_allies_player_near");
  var_1 = self._index;
  var_2 = spawnStruct();
  var_2.threads = 0;
  var_3 = [];

  if(isarray(var_0)) {
    var_3 = var_0;
  }
  else {
    var_3[0] = var_0;
  }

  foreach(var_5 in var_3) {
    var_5._old_goalradius = var_5.goalradius;
    var_5.goalradius = 16;
    var_5 thread common_scripts\utility::waittill_string("goal", var_2);
    var_2.threads++;
  }

  while(var_2.threads) {
    var_2 waittill("returned");
    var_2.threads--;
  }

  var_2 notify("die");

  foreach(var_5 in var_3) {
  var_5.goalradius = var_5._old_goalradius;
  }

  common_scripts\utility::flag_clear("flag_allies_moving");
  var_3 waittill_proximity();
  common_scripts\utility::flag_set("flag_allies_player_near");
}

waittill_proximity() {
  var_0 = 250;

  if(isDefined(level._ally_dist)) {
    var_0 = level._ally_dist;
  }

  var_1 = var_0 * var_0;

  for(;;) {
    foreach(var_3 in self) {
      var_4 = distancesquared(var_3.origin, level.player.origin);

      if(var_4 <= var_1) {
        return;
      }
    }

    wait 0.5;
  }
}

ally_killer_tracker_proc() {
  self endon("death");
  self notify("stop_killer_tracker");
  self endon("stop_killer_tracker");
  level.killer_tracker = 0;
  self.baseaccuracy_old = self.baseaccuracy;

  for(;;) {
    common_scripts\utility::flag_wait("flag_killer_tracker");

    while(common_scripts\utility::flag("flag_killer_tracker")) {
      level common_scripts\utility::waittill_any("killer_tracker_update", "flag_killer_tracker");
      var_0 = clamp(level.killer_tracker * 0.15, 0.0, 0.75);
      self.baseaccuracy = 1 - var_0;
    }

    self.baseaccuracy = self.baseaccuracy_old;
  }
}

add_to_group(var_0) {
  if(!isDefined(level._enemies)) {
    level._enemies = [];
  }

  if(!isDefined(level._enemies[var_0])) {
    level._enemies[var_0] = [];
  }

  level._enemies[var_0] = common_scripts\utility::array_add(level._enemies[var_0], self);
  self._current_index = var_0;
}

opfor_killer_tracker() {
  self waittill("death", var_0);

  if(isDefined(var_0) && isplayer(var_0)) {
    level.killer_tracker = 0;
  }
  else {
    level.killer_tracker = level.killer_tracker + 1;
  }

  level notify("killer_tracker_update");
}

ignore_everything() {
  if(!isDefined(self) || !isai(self)) {
    return;
  }
  if(isDefined(self._ignore_settings_old)) {
    unignore_everything();
  }

  self._ignore_settings_old = [];
  self.disableplayeradsloscheck = set_ignore_setting(self.disableplayeradsloscheck, "disableplayeradsloscheck", 1);
  self.ignoreall = set_ignore_setting(self.ignoreall, "ignoreall", 1);
  self.ignoreme = set_ignore_setting(self.ignoreme, "ignoreme", 1);
  self.grenadeawareness = set_ignore_setting(self.grenadeawareness, "grenadeawareness", 0);
  self.ignoreexplosionevents = set_ignore_setting(self.ignoreexplosionevents, "ignoreexplosionevents", 1);
  self.ignorerandombulletdamage = set_ignore_setting(self.ignorerandombulletdamage, "ignorerandombulletdamage", 1);
  self.ignoresuppression = set_ignore_setting(self.ignoresuppression, "ignoresuppression", 1);
  self.dontavoidplayer = set_ignore_setting(self.dontavoidplayer, "dontavoidplayer", 1);
  self.newenemyreactiondistsq = set_ignore_setting(self.newenemyreactiondistsq, "newEnemyReactionDistSq", 0);
  self.disablebulletwhizbyreaction = set_ignore_setting(self.disablebulletwhizbyreaction, "disableBulletWhizbyReaction", 1);
  self.disablefriendlyfirereaction = set_ignore_setting(self.disablefriendlyfirereaction, "disableFriendlyFireReaction", 1);
  self.dontmelee = set_ignore_setting(self.dontmelee, "dontMelee", 1);
  self.flashbangimmunity = set_ignore_setting(self.flashbangimmunity, "flashBangImmunity", 1);
  self.dodangerreact = set_ignore_setting(self.dodangerreact, "doDangerReact", 0);
  self.neversprintforvariation = set_ignore_setting(self.neversprintforvariation, "neverSprintForVariation", 1);
  self.a.disablepain = set_ignore_setting(self.a.disablepain, "a.disablePain", 1);
  self.allowpain = set_ignore_setting(self.allowpain, "allowPain", 0);
  self pushplayer(1);
}

set_ignore_setting(var_0, var_1, var_2) {
  if(isDefined(var_0)) {
    self._ignore_settings_old[var_1] = var_0;
  }
  else {
    self._ignore_settings_old[var_1] = "none";
  }

  return var_2;
}

unignore_everything(var_0) {
  if(!isDefined(self) || !isai(self)) {
    return;
  }
  if(isDefined(var_0) && var_0) {
    if(isDefined(self._ignore_settings_old)) {
      self._ignore_settings_old = undefined;
    }
  }

  self.disableplayeradsloscheck = restore_ignore_setting("disableplayeradsloscheck", 0);
  self.ignoreall = restore_ignore_setting("ignoreall", 0);
  self.ignoreme = restore_ignore_setting("ignoreme", 0);
  self.grenadeawareness = restore_ignore_setting("grenadeawareness", 1);
  self.ignoreexplosionevents = restore_ignore_setting("ignoreexplosionevents", 0);
  self.ignorerandombulletdamage = restore_ignore_setting("ignorerandombulletdamage", 0);
  self.ignoresuppression = restore_ignore_setting("ignoresuppression", 0);
  self.dontavoidplayer = restore_ignore_setting("dontavoidplayer", 0);
  self.newenemyreactiondistsq = restore_ignore_setting("newEnemyReactionDistSq", 262144);
  self.disablebulletwhizbyreaction = restore_ignore_setting("disableBulletWhizbyReaction", undefined);
  self.disablefriendlyfirereaction = restore_ignore_setting("disableFriendlyFireReaction", undefined);
  self.dontmelee = restore_ignore_setting("dontMelee", undefined);
  self.flashbangimmunity = restore_ignore_setting("flashBangImmunity", undefined);
  self.dodangerreact = restore_ignore_setting("doDangerReact", 1);
  self.neversprintforvariation = restore_ignore_setting("neverSprintForVariation", undefined);
  self.a.disablepain = restore_ignore_setting("a.disablePain", 0);
  self.allowpain = restore_ignore_setting("allowPain", 1);
  self._ignore_settings_old = undefined;
}

restore_ignore_setting(var_0, var_1) {
  if(isDefined(self._ignore_settings_old)) {
    if(isstring(self._ignore_settings_old[var_0]) && self._ignore_settings_old[var_0] == "none") {
      return var_1;
    }
    else {
      return self._ignore_settings_old[var_0];
    }
  }

  return var_1;
}

ignore_until_goal(var_0) {
  self endon("death");
  ignore_everything();

  if(!isDefined(var_0)) {
    var_0 = 0.05;
  }

  if(isDefined(self.script_parameters) && issubstr(self.script_parameters, "no_ignoreme")) {
    maps\_utility::delaythread(var_0, maps\_utility::set_ignoreme, 0);
  }

  self waittill("goal");
  unignore_everything();
}