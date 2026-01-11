/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\black_ice_util_ai.gsc
**************************************/

ally_advance_watcher(var_0, var_1, var_2, var_3) {
  var_4 = [];

  if(isarray(self)) {
    var_4 = self;
  } else {
    var_4[0] = self;
  }

  level notify(var_0 + "kill");
  level endon(var_0 + "kill");

  if(!common_scripts\utility::flag_exist("flag_allies_moving")) {
    common_scripts\utility::flag_init("flag_allies_moving");
  }

  if(!common_scripts\utility::flag_exist("flag_allies_player_near")) {
    common_scripts\utility::flag_init("flag_allies_player_near");
  }

  var_5 = getent(var_0, "script_noteworthy");

  if(!isDefined(var_5)) {
    var_5 = getent(var_0, "targetname");
  }

  var_6 = 1;

  if(isDefined(var_3) && var_3) {
    var_6 = 0;
  }

  if(isDefined(var_2)) {}

  var_7 = [];

  for(;;) {
    if(isDefined(var_5.script_parameters)) {
      var_5._delay = float(var_5.script_parameters);
    } else {
      var_5._delay = 0;
    }

    if(isDefined(var_5.script_namenumber)) {
      var_5._enemy_num = int(var_5.script_namenumber);
    }

    var_5._linked_triggers = [];
    var_7 = common_scripts\utility::array_add(var_7, var_5);

    if(isDefined(var_2)) {
      var_5.flag_end = var_2;
    }

    if(isDefined(var_5.target)) {
      var_8 = getEntArray(var_5.target, "targetname");
      var_9 = undefined;

      foreach(var_11 in var_8) {
        if(var_11.classname == "trigger_multiple_friendly" && isDefined(var_9)) {
          continue;
        }
        if(var_11.classname == "trigger_multiple_friendly") {
          var_9 = var_11;
          continue;
        }

        if(issubstr(var_11.classname, "trigger")) {
          var_5._linked_triggers = common_scripts\utility::array_add(var_5._linked_triggers, var_11);
          continue;
        }
      }

      if(!isDefined(var_9)) {
        break;
      }

      var_5 = var_9;
      continue;
    }

    break;
  }

  if(!isDefined(level._ally_trigs)) {
    level._ally_trigs = [];
  }

  level._ally_trigs[var_0] = var_7;
  common_scripts\utility::flag_set("flag_allies_player_near");
  common_scripts\utility::flag_init(var_0);

  for(var_13 = 0; var_13 < var_7.size; var_13++) {
    var_5 = var_7[var_13];
    var_5._index = var_13;

    if(!isDefined(var_5.flag_end) || isDefined(var_5.flag_end) && !common_scripts\utility::flag(var_5.flag_end)) {
      var_4 ally_advance(var_5, var_1);
    }

    if(var_13 == 0) {
      common_scripts\utility::flag_set(var_0);
    }

    if(var_6 || isDefined(var_5.flag_end) && common_scripts\utility::flag(var_5.flag_end)) {
      if(isDefined(var_5._linked_triggers)) {
        foreach(var_15 in var_5._linked_triggers) {
          if(isDefined(var_15) && !issubstr(var_15.classname, "friendly")) {
            var_15 delete();
          }
        }
      }

      var_5 delete();
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
  } else {
    wait(self._delay);
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
  } else {
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
  var_0 = 300;

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

add_to_group(var_0, var_1) {
  if(!isDefined(level._enemies)) {
    level._enemies = [];
  }

  if(!isDefined(level._enemies[var_0])) {
    level._enemies[var_0] = [];
  }

  level._enemies[var_0] = common_scripts\utility::array_add(level._enemies[var_0], self);
  self._current_index = var_0;

  if(!isDefined(self._current_goal_volume)) {
    self notify("stop_going_to_node");

    if(isDefined(var_1) && !isstring(var_1) && !var_1) {
      return;
    } else if(isstring(var_1)) {
      thread go_to_goal_vol(var_1);
    } else {
      var_2 = self getgoalvolume();

      if(isDefined(var_2)) {
        thread go_to_goal_vol(var_2);
      } else if(!isDefined(self.target) && isDefined(level._retreat_current_volumes) && isDefined(level._retreat_current_volumes[var_0]) && level._retreat_current_volumes[var_0].size > 0) {
        thread go_to_goal_vol();
      }
    }
  }
}

check_enemy_index(var_0) {}

retreat_watcher(var_0, var_1, var_2, var_3) {
  check_vol_index(var_2);
  level notify(var_0 + "kill");
  level endon(var_0 + "kill");

  if(!isDefined(level._retreat_volumes_list)) {
    level._retreat_volumes_list = [];
  }

  if(!isDefined(level._retreat_volumes_list[var_1])) {
    level._retreat_volumes_list[var_1] = [];
    level._retreat_volumes_list[var_1] = build_vol_list(var_2);
  }

  if(!isDefined(level._retreat_current_volumes)) {
    level._retreat_current_volumes = [];
  }

  if(!isDefined(level._retreat_current_volumes[var_1])) {
    level._retreat_current_volumes[var_1] = var_2;
  }

  var_4 = getEntArray(var_0, "script_noteworthy");

  if(var_4.size == 0) {
    var_4 = getEntArray(var_0, "targetname");
  }

  level._retreat_trigs[var_0] = var_4;
  common_scripts\utility::array_thread(var_4, ::trigger_wait_retreat, var_1, var_3);
}

trigger_wait_retreat(var_0, var_1) {
  level endon("notify_stop_retreat_all");
  self waittill("trigger");
  var_2 = [];

  if(isarray(var_0)) {
    var_2 = var_0;
  } else if(isstring(var_0)) {
    var_2[0] = var_0;
  } else {}

  foreach(var_4 in var_2) {
    enemy_retreat(var_0, undefined, var_1);
  }

  self delete();
}

enemy_retreat(var_0, var_1, var_2) {
  check_enemy_index(var_0);
  level notify("notify_kill_retreat" + var_0);
  level endon("notify_kill_retreat" + var_0);
  var_3 = maps\_utility::remove_dead_from_array(level._enemies[var_0]);
  var_3 = sortbydistance(var_3, level.player.origin);
  var_4 = 0.05;

  if(isDefined(var_2) && var_2 > var_4) {
    var_4 = var_2;
  }

  if(level._retreat_volumes_list[var_0].size > 0) {
    level._retreat_current_volumes[var_0] = level._retreat_volumes_list[var_0][0];
    level._retreat_volumes_list[var_0] = maps\_utility::array_remove_index(level._retreat_volumes_list[var_0], 0);
  }

  for(var_5 = var_3.size - 1; var_5 >= 0; var_5--) {
    var_3[var_5] thread go_to_goal_vol(var_1, var_4);
    var_4 = int(var_4 - var_4 / var_3.size);
  }
}

go_to_goal_vol(var_0, var_1) {
  if(self._current_index == "seek") {
    return 0;
  }

  self notify("stop_go_to_goal_vol");
  wait 0.05;
  self endon("death");
  self endon("stop_go_to_goal_vol");
  var_2 = choose_goal_vol(var_0);

  if(!isDefined(var_2)) {
    return 0;
  }

  if(isstring(var_2) && var_2 == "seek") {
    self notify("notify_stop_retreat");
    self._current_goal_volume = undefined;
    self cleargoalvolume();

    if(isDefined(self._current_index)) {
      level._enemies[self._current_index] = common_scripts\utility::array_remove(level._enemies[self._current_index], self);
      add_to_group("seek", 0);
      self._current_index = "seek";
    }

    thread maps\_utility::player_seek_enable();
  } else {
    var_3 = 0.05;

    if(isDefined(var_1)) {
      if(var_1 >= var_3) {
        wait(randomfloatrange(0, var_1));
      }
    } else
      wait(randomfloatrange(0, var_3));

    if(isDefined(self._current_index) && isDefined(level._retreat_current_volumes) && isDefined(level._retreat_current_volumes[self._current_index]) && !current_vol_acceptable()) {
      add_to_standby();
    } else {
      self._retreat_standby = undefined;
    }

    maps\_utility::set_fixednode_false();
    self._current_goal_volume = var_2;
    self setgoalvolumeauto(var_2);
  }

  return 1;
}

choose_goal_vol(var_0) {
  var_1 = undefined;

  if(isDefined(var_0)) {
    var_1 = choose_goal_vol_chain(var_0);
  } else if(isDefined(level._retreat_final)) {
    var_1 = choose_goal_vol_chain(level._retreat_final);
  } else if(isDefined(self._current_goal_volume)) {
    if(current_vol_acceptable()) {
      return;
    }
    if(isDefined(self._current_goal_volume._target_vols) && self._current_goal_volume._target_vols.size > 0) {
      var_2 = sortbydistance(self._current_goal_volume._target_vols, self.origin);

      foreach(var_4 in var_2) {
        var_1 = choose_goal_vol_chain(var_4);

        if(isDefined(var_1)) {
          break;
        }
      }
    }
  } else if(!isDefined(self._current_index)) {
    foreach(var_7 in level._vols) {
      foreach(var_9 in var_7) {
        if(self istouching(var_9)) {
          var_1 = choose_goal_vol_chain(var_9);
        }
      }
    }
  }

  if(!isDefined(var_1)) {
    if(isDefined(self._current_index) && isDefined(level._retreat_current_volumes) && isDefined(level._retreat_current_volumes[self._current_index])) {
      var_1 = choose_goal_vol_chain(level._retreat_current_volumes[self._current_index]);
    }
  }

  if(isDefined(var_1)) {
    if(isDefined(level._retreat_final)) {
      thread ignore_to_goal();
      var_12 = [self];
      thread maps\_utility::ai_delete_when_out_of_sight(var_12, 256);
      level notify("notify_stop_retreat_all");
    }

    if(isDefined(self._current_goal_volume) && var_1 == self._current_goal_volume) {
      return;
    }
    update_vol_node_count(var_1);
    return var_1;
  }

  if(isDefined(self._retreat_standby) && self._retreat_standby) {
    add_to_standby();
  } else {}
}

current_vol_acceptable() {
  if(isDefined(self._current_index)) {
    if(isDefined(level._retreat_current_volumes) && isDefined(level._retreat_current_volumes[self._current_index]) && level._retreat_current_volumes[self._current_index].size > 0) {
      if(self._current_goal_volume.script_noteworthy == level._retreat_current_volumes[self._current_index]) {
        return 1;
      }
    }

    if(isDefined(level._retreat_volumes_list[self._current_index])) {
      foreach(var_1 in level._retreat_volumes_list[self._current_index]) {
        if(self._current_goal_volume.script_noteworthy == var_1) {
          return 1;
        }
      }
    }
  }

  return 0;
}

choose_goal_vol_chain(var_0) {
  var_1 = [];

  if(!isstring(var_0)) {
    var_2 = var_0;

    if(isDefined(var_2._num_ai) && isDefined(var_2._max_ai)) {
      if(var_2._num_ai < var_2._max_ai) {
        return var_2;
      }
    }

    var_1[0] = var_2;
  } else {
    check_vol_index(var_0);
    var_1 = level._vols[var_0];
    var_1 = sortbydistance(var_1, self.origin);

    foreach(var_4 in var_1) {
      if(var_4._num_ai < var_4._max_ai) {
        return var_4;
      }
    }
  }

  foreach(var_4 in var_1) {
    if(isDefined(var_4._target_vols) && var_4._target_vols.size > 0) {
      var_1 = sortbydistance(var_4._target_vols, self.origin);

      foreach(var_8 in var_1) {
        var_2 = choose_goal_vol_chain(var_8);

        if(isDefined(var_2)) {
          return var_2;
        }
      }
    }
  }
}

update_vol_node_count(var_0) {
  if(isDefined(self._current_goal_volume)) {
    self._current_goal_volume._num_ai--;
  }

  self._current_goal_volume = var_0;
  var_0._num_ai++;
  thread deathfunc_vol_num_decrement(var_0);
}

deathfunc_vol_num_decrement(var_0) {
  self notify("notify_new_vol");
  self endon("notify_new_vol");
  common_scripts\utility::waittill_either("death", "notify_stop_retreat");
  var_0._num_ai--;
}

add_to_standby() {
  self._retreat_standby = 1;

  if(!isDefined(level._retreat_standby)) {
    level._retreat_standby = [];
  }

  if(!isDefined(level._retreat_standby[self._current_index])) {
    level._retreat_standby[self._current_index] = [];
  }

  level._retreat_standby[self._current_index] = common_scripts\utility::array_add(level._retreat_standby[self._current_index], self);
  thread standby_watcher(self._current_index);
}

standby_watcher(var_0) {
  level notify("notify_stop_standby_watcher_" + var_0);
  level endon("notify_stop_standby_watcher_" + var_0);
  level endon("notify_stop_retreat_all");

  for(;;) {
    wait 3;
    var_1 = maps\_utility::remove_dead_from_array(level._retreat_standby[var_0]);
    level._retreat_standby[var_0] = [];

    if(var_1.size == 0) {
      break;
    }

    if(isDefined(level._retreat_current_volumes[var_0])) {
      foreach(var_3 in var_1) {
        var_3 thread go_to_goal_vol(level._retreat_current_volumes[var_0]);
      }

      continue;
    }

    break;
  }
}

setup_retreat_vols() {
  var_0 = getallnodes();
  var_1 = getEntArray("info_volume", "classname");
  var_2 = [];
  var_3 = common_scripts\utility::spawn_tag_origin();

  foreach(var_5 in var_1) {
    if(isDefined(var_5.script_noteworthy)) {
      if(isDefined(var_5.script_parameters)) {
        var_5._max_ai = int(var_5.script_parameters);
      } else {
        if(!isDefined(var_5.nodes)) {
          var_5.nodes = [];
        }

        foreach(var_7 in var_0) {
          var_3.origin = var_7.origin;

          if(var_3 istouching(var_5)) {
            if(issubstr(var_7.type, "Cover") || issubstr(var_7.type, "Conceal") || issubstr(var_7.type, "Exposed")) {
              if(isDefined(var_7.script_parameters) && var_7.script_parameters == "no_axis") {
                continue;
              }
              var_5.nodes = common_scripts\utility::array_add(var_5.nodes, var_7);
            }
          }
        }

        if(!isDefined(var_5.nodes)) {
          iprintln("Warning - Volume '" + var_5.script_noteworthy + "' has no cover nodes!");
        }

        var_5._max_ai = var_5.nodes.size;
      }

      if(!isDefined(var_2[var_5.script_noteworthy])) {
        var_2[var_5.script_noteworthy] = [];
      }

      var_5._target_vols = [];

      if(isDefined(var_5.target)) {
        var_9 = getEntArray(var_5.target, "targetname");

        foreach(var_11 in var_9) {
          var_5._target_vols = common_scripts\utility::array_add(var_5._target_vols, var_11);
        }
      }

      var_2[var_5.script_noteworthy] = common_scripts\utility::array_add(var_2[var_5.script_noteworthy], var_5);
      var_5._num_ai = 0;
    }
  }

  var_3 delete();
  level._vols = var_2;
}

check_vol_index(var_0) {}

build_vol_list(var_0) {
  check_vol_index(var_0);
  var_1 = [];

  for(;;) {
    var_2 = undefined;

    foreach(var_4 in level._vols[var_0]) {
      if(isDefined(var_4._target_vols) && var_4._target_vols.size > 0) {
        var_2 = var_4._target_vols[0].script_noteworthy;
      }
    }

    if(isDefined(var_2)) {
      var_1 = common_scripts\utility::array_add(var_1, var_2);
    } else {
      break;
    }

    var_0 = var_2;
    var_2 = undefined;
  }

  return var_1;
}

ignore_to_goal(var_0) {
  self endon("death");
  self.old_goalradius = self.goalradius;
  self.goalradius = 16;
  self.ignoreall = 1;
  self waittill("goal");
  self.ignoreall = 0;
  self.goalradius = self.old_goalradius;

  if(isDefined(var_0)) {
    self[[var_0]]();
  }
}