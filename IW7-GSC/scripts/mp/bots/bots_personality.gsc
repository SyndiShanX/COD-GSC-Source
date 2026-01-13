/************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\mp\bots\bots_personality.gsc
************************************************/

setup_personalities() {
  level.bot_personality = [];
  level.bot_personality_list = [];
  level.bot_personality["active"][0] = "default";
  level.bot_personality["active"][1] = "run_and_gun";
  level.bot_personality["active"][2] = "cqb";
  level.bot_personality["stationary"][0] = "camper";
  level.bot_personality_type = [];
  foreach(var_5, var_1 in level.bot_personality) {
    foreach(var_3 in var_1) {
      level.bot_personality_type[var_3] = var_5;
      level.bot_personality_list[level.bot_personality_list.size] = var_3;
    }
  }

  level.bot_personality_types_desired = [];
  level.bot_personality_types_desired["active"] = 2;
  level.bot_personality_types_desired["stationary"] = 1;
  level.bot_pers_init = [];
  level.bot_pers_init["default"] = ::init_personality_default;
  level.bot_pers_init["camper"] = ::init_personality_camper;
  level.bot_pers_update["default"] = ::update_personality_default;
  level.bot_pers_update["camper"] = ::update_personality_camper;
}

bot_assign_personality_functions() {
  self.personality = self botgetpersonality();
  self.personality_init_function = level.bot_pers_init[self.personality];
  if(!isDefined(self.personality_init_function)) {
    self.personality_init_function = level.bot_pers_init["default"];
  }

  self[[self.personality_init_function]]();
  self.personality_update_function = level.bot_pers_update[self.personality];
  if(!isDefined(self.personality_update_function)) {
    self.personality_update_function = level.bot_pers_update["default"];
  }
}

bot_balance_personality() {
  if(isDefined(self.personalitymanuallyset) && self.personalitymanuallyset) {
    return;
  }

  if(scripts\mp\utility::bot_is_fireteam_mode()) {
    return;
  }

  var_0 = [];
  var_1 = [];
  foreach(var_7, var_3 in level.bot_personality) {
    var_1[var_7] = 0;
    foreach(var_5 in var_3) {
      var_0[var_5] = 0;
    }
  }

  foreach(var_9 in level.players) {
    if(isbot(var_9) && isDefined(var_9.team) && var_9.team == self.team && var_9 != self && isDefined(var_9.has_balanced_personality)) {
      var_5 = var_9 botgetpersonality();
      var_7 = level.bot_personality_type[var_5];
      var_0[var_5] = var_0[var_5] + 1;
      var_1[var_7] = var_1[var_7] + 1;
    }
  }

  var_0B = undefined;
  while(!isDefined(var_0B)) {
    for(var_0C = level.bot_personality_types_desired; var_0C.size > 0; var_0C[var_0D] = undefined) {
      var_0D = scripts\mp\bots\_bots_util::bot_get_string_index_for_integer(var_0C, randomint(var_0C.size));
      var_1[var_0D] = var_1[var_0D] - level.bot_personality_types_desired[var_0D];
      if(var_1[var_0D] < 0) {
        var_0B = var_0D;
        break;
      }
    }
  }

  var_0E = undefined;
  var_0F = undefined;
  var_10 = 9999;
  var_11 = undefined;
  var_12 = -9999;
  var_13 = scripts\engine\utility::array_randomize(level.bot_personality[var_0B]);
  foreach(var_5 in var_13) {
    if(var_0[var_5] < var_10) {
      var_0F = var_5;
      var_10 = var_0[var_5];
    }

    if(var_0[var_5] > var_12) {
      var_11 = var_5;
      var_12 = var_0[var_5];
    }
  }

  if(var_12 - var_10 >= 2) {
    var_0E = var_0F;
  } else {
    var_0E = scripts\engine\utility::random(level.bot_personality[var_0B]);
  }

  if(self botgetpersonality() != var_0E) {
    self botsetpersonality(var_0E);
  }

  self.has_balanced_personality = 1;
}

init_personality_camper() {
  clear_camper_data();
}

init_personality_default() {
  clear_camper_data();
}

update_personality_camper() {
  if(should_select_new_ambush_point() && !scripts\mp\bots\_bots_util::bot_is_defending() && !scripts\mp\bots\_bots_util::bot_is_remote_or_linked()) {
    var_0 = self botgetscriptgoaltype();
    var_1 = 0;
    if(!isDefined(self.camper_time_started_hunting)) {
      self.camper_time_started_hunting = 0;
    }

    var_2 = var_0 == "hunt";
    var_3 = gettime() > self.camper_time_started_hunting + 10000;
    if((!var_2 || var_3) && !scripts\mp\bots\_bots_util::bot_out_of_ammo()) {
      if(!self bothasscriptgoal()) {
        bot_random_path();
      }

      var_1 = find_camp_node();
      if(!var_1) {
        self.camper_time_started_hunting = gettime();
      }
    }

    if(isDefined(var_1) && var_1) {
      self.ambush_entrances = scripts\mp\bots\_bots_util::bot_queued_process("bot_find_ambush_entrances", ::bot_find_ambush_entrances, self.node_ambushing_from, 1);
      var_4 = scripts\mp\bots\_bots_strategy::bot_get_ambush_trap_item("trap_directional", "trap", "c4");
      if(isDefined(var_4)) {
        var_5 = gettime();
        scripts\mp\bots\_bots_strategy::bot_set_ambush_trap(var_4, self.ambush_entrances, self.node_ambushing_from, self.ambush_yaw);
        var_5 = gettime() - var_5;
        if(var_5 > 0 && isDefined(self.ambush_end) && isDefined(self.node_ambushing_from)) {
          self.ambush_end = self.ambush_end + var_5;
          self.node_ambushing_from.bot_ambush_end = self.ambush_end + 10000;
        }
      }

      if(!scripts\mp\bots\_bots_strategy::bot_has_tactical_goal() && !scripts\mp\bots\_bots_util::bot_is_defending() && isDefined(self.node_ambushing_from)) {
        self botsetscriptgoalnode(self.node_ambushing_from, "camp", self.ambush_yaw);
        thread clear_script_goal_on("bad_path", "node_relinquished", "out_of_ammo");
        thread watch_out_of_ammo();
        thread bot_add_ambush_time_delayed("clear_camper_data", "goal");
        thread bot_watch_entrances_delayed("clear_camper_data", "bot_add_ambush_time_delayed", self.ambush_entrances, self.ambush_yaw);
        return;
      }

      return;
    }

    if(var_0 == "camp") {
      self botclearscriptgoal();
    }

    update_personality_default();
  }
}

update_personality_default() {
  var_0 = undefined;
  var_1 = self bothasscriptgoal();
  if(var_1) {
    var_0 = self botgetscriptgoal();
  }

  if(!scripts\mp\bots\_bots_strategy::bot_has_tactical_goal() && !scripts\mp\bots\_bots_util::bot_is_remote_or_linked()) {
    var_2 = undefined;
    var_3 = undefined;
    if(var_1) {
      var_2 = distancesquared(self.origin, var_0);
      var_3 = self botgetscriptgoalradius();
      var_4 = var_3 * 2;
      if(isDefined(self.bot_memory_goal) && var_2 < var_4 * var_4) {
        var_5 = botmemoryflags("investigated");
        botflagmemoryevents(0, gettime() - self.bot_memory_goal_time, 1, self.bot_memory_goal, var_4, "kill", var_5, self);
        botflagmemoryevents(0, gettime() - self.bot_memory_goal_time, 1, self.bot_memory_goal, var_4, "death", var_5, self);
        self.bot_memory_goal = undefined;
        self.bot_memory_goal_time = undefined;
      }
    }

    if(!var_1 || var_2 < var_3 * var_3) {
      var_6 = bot_random_path();
      if(var_6 && randomfloat(100) < 25) {
        var_7 = scripts\mp\bots\_bots_strategy::bot_get_ambush_trap_item("trap_directional", "trap");
        if(isDefined(var_7)) {
          var_8 = self botgetscriptgoal();
          if(isDefined(var_8)) {
            var_9 = getclosestnodeinsight(var_8);
            if(isDefined(var_9)) {
              var_0A = scripts\mp\bots\_bots_util::bot_queued_process("bot_find_ambush_entrances", ::bot_find_ambush_entrances, var_9, 0);
              var_0B = scripts\mp\bots\_bots_strategy::bot_set_ambush_trap(var_7, var_0A, var_9);
              if(!isDefined(var_0B) || var_0B) {
                self botclearscriptgoal();
                var_6 = bot_random_path();
              }
            }
          }
        }
      }

      if(var_6) {
        thread clear_script_goal_on("enemy", "bad_path", "goal", "node_relinquished", "search_end");
        return;
      }
    }
  }
}

clear_script_goal_on(var_0, var_1, var_2, var_3, var_4) {
  self notify("clear_script_goal_on");
  self endon("clear_script_goal_on");
  self endon("death");
  self endon("disconnect");
  self endon("start_tactical_goal");
  var_5 = self botgetscriptgoal();
  var_6 = 1;
  while(var_6) {
    var_7 = scripts\engine\utility::waittill_any_return(var_0, var_1, var_2, var_3, var_4, "script_goal_changed");
    var_6 = 0;
    var_8 = 1;
    if(var_7 == "node_relinquished" || var_7 == "goal" || var_7 == "script_goal_changed") {
      if(!self bothasscriptgoal()) {
        var_8 = 0;
      } else {
        var_9 = self botgetscriptgoal();
        var_8 = scripts\mp\bots\_bots_util::bot_vectors_are_equal(var_5, var_9);
      }
    }

    if(var_7 == "enemy" && isDefined(self.isnodeoccupied)) {
      var_8 = 0;
      var_6 = 1;
    }

    if(var_8) {
      self botclearscriptgoal();
    }
  }
}

watch_out_of_ammo() {
  self notify("watch_out_of_ammo");
  self endon("watch_out_of_ammo");
  self endon("death");
  self endon("disconnect");
  while(!scripts\mp\bots\_bots_util::bot_out_of_ammo()) {
    wait(0.5);
  }

  self notify("out_of_ammo");
}

bot_add_ambush_time_delayed(var_0, var_1) {
  self notify("bot_add_ambush_time_delayed");
  self endon("bot_add_ambush_time_delayed");
  self endon("death");
  self endon("disconnect");
  if(isDefined(var_0)) {
    self endon(var_0);
  }

  self endon("node_relinquished");
  self endon("bad_path");
  var_2 = gettime();
  if(isDefined(var_1)) {
    self waittill(var_1);
  }

  if(isDefined(self.ambush_end) && isDefined(self.node_ambushing_from)) {
    self.ambush_end = self.ambush_end + gettime() - var_2;
    self.node_ambushing_from.bot_ambush_end = self.ambush_end + 10000;
  }

  self notify("bot_add_ambush_time_delayed");
}

bot_watch_entrances_delayed(var_0, var_1, var_2, var_3) {
  self notify("bot_watch_entrances_delayed");
  if(var_2.size > 0) {
    self endon("bot_watch_entrances_delayed");
    self endon("death");
    self endon("disconnect");
    self endon(var_0);
    self endon("node_relinquished");
    self endon("bad_path");
    if(isDefined(var_1)) {
      self waittill(var_1);
    }

    self endon("path_enemy");
    childthread scripts\mp\bots\_bots_util::bot_watch_nodes(var_2, var_3, 0, self.ambush_end);
    childthread bot_monitor_watch_entrances_camp();
  }
}

bot_monitor_watch_entrances_camp() {
  self notify("bot_monitor_watch_entrances_camp");
  self endon("bot_monitor_watch_entrances_camp");
  self notify("bot_monitor_watch_entrances");
  self endon("bot_monitor_watch_entrances");
  self endon("disconnect");
  self endon("death");
  while(!isDefined(self.watch_nodes)) {
    wait(0.05);
  }

  while(isDefined(self.watch_nodes)) {
    foreach(var_1 in self.watch_nodes) {
      var_1.watch_node_chance[self.entity_number] = 1;
    }

    scripts\mp\bots\_bots_strategy::prioritize_watch_nodes_toward_enemies(0.5);
    wait(randomfloatrange(0.5, 0.75));
  }
}

bot_find_ambush_entrances(var_0, var_1) {
  self endon("disconnect");
  var_2 = [];
  var_3 = findentrances(var_0.origin);
  if(isDefined(var_3) && var_3.size > 0) {
    wait(0.05);
    var_4 = var_0.type != "Cover Stand" && var_0.type != "Conceal Stand";
    if(var_4 && var_1) {
      var_3 = self getparent(var_3, "node_exposure_vis", var_0.origin, "crouch");
    }

    foreach(var_6 in var_3) {
      if(distancesquared(self.origin, var_6.origin) < 90000) {
        continue;
      }

      if(var_4 && var_1) {
        wait(0.05);
        if(!scripts\mp\bots\_bots_util::entrance_visible_from(var_6.origin, var_0.origin, "crouch")) {
          continue;
        }
      }

      var_2[var_2.size] = var_6;
    }
  }

  return var_2;
}

bot_filter_ambush_inuse(var_0) {
  var_1 = [];
  var_2 = gettime();
  var_3 = var_0.size;
  for(var_4 = 0; var_4 < var_3; var_4++) {
    var_5 = var_0[var_4];
    if(!isDefined(var_5.bot_ambush_end) || var_2 > var_5.bot_ambush_end) {
      var_1[var_1.size] = var_5;
    }
  }

  return var_1;
}

bot_filter_ambush_vicinity(var_0, var_1, var_2) {
  var_3 = [];
  var_4 = [];
  var_5 = var_2 * var_2;
  if(level.teambased) {
    foreach(var_7 in level.participants) {
      if(!scripts\mp\utility::isreallyalive(var_7)) {
        continue;
      }

      if(!isDefined(var_7.team)) {
        continue;
      }

      if(var_7.team == var_1.team && var_7 != var_1 && isDefined(var_7.node_ambushing_from)) {
        var_4[var_4.size] = var_7.node_ambushing_from.origin;
      }
    }
  }

  var_9 = var_4.size;
  var_0A = var_0.size;
  for(var_0B = 0; var_0B < var_0A; var_0B++) {
    var_0C = 0;
    var_0D = var_0[var_0B];
    for(var_0E = 0; !var_0C && var_0E < var_9; var_0E++) {
      var_0F = distancesquared(var_4[var_0E], var_0D.origin);
      var_0C = var_0F < var_5;
    }

    if(!var_0C) {
      var_3[var_3.size] = var_0D;
    }
  }

  return var_3;
}

clear_camper_data() {
  self notify("clear_camper_data");
  if(isDefined(self.node_ambushing_from) && isDefined(self.node_ambushing_from.bot_ambush_end)) {
    self.node_ambushing_from.bot_ambush_end = undefined;
  }

  self.node_ambushing_from = undefined;
  self.point_to_ambush = undefined;
  self.ambush_yaw = undefined;
  self.ambush_entrances = undefined;
  self.ambush_duration = randomintrange(20000, 30000);
  self.ambush_end = -1;
}

should_select_new_ambush_point() {
  if(scripts\mp\bots\_bots_strategy::bot_has_tactical_goal()) {
    return 0;
  }

  if(gettime() > self.ambush_end) {
    return 1;
  }

  if(!self bothasscriptgoal()) {
    return 1;
  }

  return 0;
}

find_camp_node() {
  self notify("find_camp_node");
  self endon("find_camp_node");
  return scripts\mp\bots\_bots_util::bot_queued_process("find_camp_node_worker", ::find_camp_node_worker);
}

find_camp_node_worker() {
  self notify("find_camp_node_worker");
  self endon("find_camp_node_worker");
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  clear_camper_data();
  if(level.zonecount <= 0) {
    return 0;
  }

  var_0 = getzonenearest(self.origin);
  var_1 = undefined;
  var_2 = undefined;
  var_3 = self.angles;
  if(isDefined(var_0)) {
    var_4 = botzonenearestcount(var_0, self.team, -1, "enemy_predict", ">", 0, "ally", "<", 1);
    if(!isDefined(var_4)) {
      var_4 = botzonenearestcount(var_0, self.team, -1, "enemy_predict", ">", 0);
    }

    if(!isDefined(var_4)) {
      var_5 = -1;
      var_6 = -1;
      for(var_7 = 0; var_7 < level.zonecount; var_7++) {
        var_8 = distance2dsquared(getzoneorigin(var_7), self.origin);
        if(var_8 > var_5) {
          var_5 = var_8;
          var_6 = var_7;
        }
      }

      var_4 = var_6;
    }

    var_9 = getzonepath(var_0, var_4);
    if(isDefined(var_9) && var_9.size > 0) {
      for(var_0A = 0; var_0A <= int(var_9.size / 2); var_0A++) {
        var_1 = var_9[var_0A];
        var_2 = var_9[int(min(var_0A + 1, var_9.size - 1))];
        if(botzonegetcount(var_2, self.team, "enemy_predict") != 0) {
          break;
        }
      }

      if(isDefined(var_1) && isDefined(var_2) && var_1 != var_2) {
        var_3 = getzoneorigin(var_2) - getzoneorigin(var_1);
        var_3 = vectortoangles(var_3);
      }
    }
  }

  var_0B = undefined;
  if(isDefined(var_1)) {
    var_0C = 1;
    var_0D = 1;
    var_0E = 0;
    while(var_0C) {
      var_0F = getzonenodesbydist(var_1, 800 * var_0D, 1);
      if(var_0F.size > 1024) {
        var_0F = getzonenodes(var_1, 0);
      }

      wait(0.05);
      var_10 = randomint(100);
      if(var_10 < 66 && var_10 >= 33) {
        var_3 = (var_3[0], var_3[1] + 45, 0);
      } else if(var_10 < 33) {
        var_3 = (var_3[0], var_3[1] - 45, 0);
      }

      if(var_0F.size > 0) {
        var_11 = int(min(max(1, var_0F.size * 0.15), 5));
        if(var_0E) {
          var_0F = self botnodepickmultiple(var_0F, var_11, var_11, "node_camp", anglesToForward(var_3), "lenient");
        } else {
          var_0F = self botnodepickmultiple(var_0F, var_11, var_11, "node_camp", anglesToForward(var_3));
        }

        var_0F = bot_filter_ambush_inuse(var_0F);
        if(!isDefined(self.can_camp_near_others) || !self.can_camp_near_others) {
          var_12 = 800;
          var_0F = bot_filter_ambush_vicinity(var_0F, self, var_12);
        }

        if(var_0F.size > 0) {
          var_0B = scripts\engine\utility::random_weight_sorted(var_0F);
        }
      }

      if(isDefined(var_0B)) {
        var_0C = 0;
        continue;
      }

      if(isDefined(self.camping_needs_fallback_camp_location)) {
        if(var_0D == 1 && !var_0E) {
          var_0D = 3;
        } else if(var_0D == 3 && !var_0E) {
          var_0E = 1;
        } else if(var_0D == 3 && var_0E) {
          var_0C = 0;
        }

        continue;
      }

      var_0C = 0;
      if(var_0C) {
        wait(0.05);
      }
    }
  }

  if(!isDefined(var_0B) || !self botnodeavailable(var_0B)) {
    return 0;
  }

  self.node_ambushing_from = var_0B;
  self.ambush_end = gettime() + self.ambush_duration;
  self.node_ambushing_from.bot_ambush_end = self.ambush_end;
  self.ambush_yaw = var_3[1];
  return 1;
}

find_ambush_node(var_0, var_1) {
  clear_camper_data();
  if(isDefined(var_0)) {
    self.point_to_ambush = var_0;
  } else {
    var_2 = undefined;
    var_3 = getnodesinradius(self.origin, 5000, 0, 2000);
    if(var_3.size > 0) {
      var_2 = self botnodepick(var_3, var_3.size * 0.25, "node_traffic");
    }

    if(isDefined(var_2)) {
      self.point_to_ambush = var_2.origin;
    } else {
      return 0;
    }
  }

  var_4 = 2000;
  if(isDefined(var_1)) {
    var_4 = var_1;
  }

  var_5 = getnodesinradius(self.point_to_ambush, var_4, 0, 1000);
  var_6 = undefined;
  if(var_5.size > 0) {
    var_7 = int(max(1, int(var_5.size * 0.15)));
    var_5 = self botnodepickmultiple(var_5, var_7, var_7, "node_ambush", self.point_to_ambush);
  }

  var_5 = bot_filter_ambush_inuse(var_5);
  if(var_5.size > 0) {
    var_6 = scripts\engine\utility::random_weight_sorted(var_5);
  }

  if(!isDefined(var_6) || !self botnodeavailable(var_6)) {
    return 0;
  }

  self.node_ambushing_from = var_6;
  self.ambush_end = gettime() + self.ambush_duration;
  self.node_ambushing_from.bot_ambush_end = self.ambush_end;
  var_8 = vectornormalize(self.point_to_ambush - self.node_ambushing_from.origin);
  var_9 = vectortoangles(var_8);
  self.ambush_yaw = var_9[1];
  return 1;
}

bot_random_path() {
  if(scripts\mp\bots\_bots_util::bot_is_remote_or_linked()) {
    return 0;
  }

  var_0 = level.bot_random_path_function[self.team];
  return self[[var_0]]();
}

bot_random_path_default() {
  var_0 = 0;
  var_1 = 50;
  if(self.personality == "camper") {
    var_1 = 0;
  }

  var_2 = undefined;
  if(randomint(100) < var_1) {
    var_2 = scripts\mp\bots\_bots_util::bot_recent_point_of_interest();
  }

  if(!isDefined(var_2)) {
    var_3 = self botfindnoderandom();
    if(isDefined(var_3)) {
      var_2 = var_3.origin;
    }
  }

  if(isDefined(var_2)) {
    var_0 = self botsetscriptgoal(var_2, 128, "hunt");
  }

  return var_0;
}

bot_setup_callback_class() {
  if(scripts\mp\bots\_bots_loadout::bot_setup_loadout_callback()) {
    return "callback";
  }

  return "class0";
}