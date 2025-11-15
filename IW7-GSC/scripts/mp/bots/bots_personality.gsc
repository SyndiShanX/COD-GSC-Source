/************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
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
  foreach(var_05, var_01 in level.bot_personality) {
    foreach(var_03 in var_01) {
      level.bot_personality_type[var_03] = var_05;
      level.bot_personality_list[level.bot_personality_list.size] = var_03;
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

  var_00 = [];
  var_01 = [];
  foreach(var_07, var_03 in level.bot_personality) {
    var_01[var_07] = 0;
    foreach(var_05 in var_03) {
      var_00[var_05] = 0;
    }
  }

  foreach(var_09 in level.players) {
    if(isbot(var_09) && isDefined(var_09.team) && var_09.team == self.team && var_09 != self && isDefined(var_09.has_balanced_personality)) {
      var_05 = var_09 botgetpersonality();
      var_07 = level.bot_personality_type[var_05];
      var_00[var_05] = var_00[var_05] + 1;
      var_01[var_07] = var_01[var_07] + 1;
    }
  }

  var_0B = undefined;
  while(!isDefined(var_0B)) {
    for(var_0C = level.bot_personality_types_desired; var_0C.size > 0; var_0C[var_0D] = undefined) {
      var_0D = scripts\mp\bots\_bots_util::bot_get_string_index_for_integer(var_0C, randomint(var_0C.size));
      var_01[var_0D] = var_01[var_0D] - level.bot_personality_types_desired[var_0D];
      if(var_01[var_0D] < 0) {
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
  foreach(var_05 in var_13) {
    if(var_00[var_05] < var_10) {
      var_0F = var_05;
      var_10 = var_00[var_05];
    }

    if(var_00[var_05] > var_12) {
      var_11 = var_05;
      var_12 = var_00[var_05];
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
    var_00 = self botgetscriptgoaltype();
    var_01 = 0;
    if(!isDefined(self.camper_time_started_hunting)) {
      self.camper_time_started_hunting = 0;
    }

    var_02 = var_00 == "hunt";
    var_03 = gettime() > self.camper_time_started_hunting + 10000;
    if((!var_02 || var_03) && !scripts\mp\bots\_bots_util::bot_out_of_ammo()) {
      if(!self bothasscriptgoal()) {
        bot_random_path();
      }

      var_01 = find_camp_node();
      if(!var_01) {
        self.camper_time_started_hunting = gettime();
      }
    }

    if(isDefined(var_01) && var_01) {
      self.ambush_entrances = scripts\mp\bots\_bots_util::bot_queued_process("bot_find_ambush_entrances", ::bot_find_ambush_entrances, self.node_ambushing_from, 1);
      var_04 = scripts\mp\bots\_bots_strategy::bot_get_ambush_trap_item("trap_directional", "trap", "c4");
      if(isDefined(var_04)) {
        var_05 = gettime();
        scripts\mp\bots\_bots_strategy::bot_set_ambush_trap(var_04, self.ambush_entrances, self.node_ambushing_from, self.ambush_yaw);
        var_05 = gettime() - var_05;
        if(var_05 > 0 && isDefined(self.ambush_end) && isDefined(self.node_ambushing_from)) {
          self.ambush_end = self.ambush_end + var_05;
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

    if(var_00 == "camp") {
      self botclearscriptgoal();
    }

    update_personality_default();
  }
}

update_personality_default() {
  var_00 = undefined;
  var_01 = self bothasscriptgoal();
  if(var_01) {
    var_00 = self botgetscriptgoal();
  }

  if(!scripts\mp\bots\_bots_strategy::bot_has_tactical_goal() && !scripts\mp\bots\_bots_util::bot_is_remote_or_linked()) {
    var_02 = undefined;
    var_03 = undefined;
    if(var_01) {
      var_02 = distancesquared(self.origin, var_00);
      var_03 = self botgetscriptgoalradius();
      var_04 = var_03 * 2;
      if(isDefined(self.bot_memory_goal) && var_02 < var_04 * var_04) {
        var_05 = botmemoryflags("investigated");
        botflagmemoryevents(0, gettime() - self.bot_memory_goal_time, 1, self.bot_memory_goal, var_04, "kill", var_05, self);
        botflagmemoryevents(0, gettime() - self.bot_memory_goal_time, 1, self.bot_memory_goal, var_04, "death", var_05, self);
        self.bot_memory_goal = undefined;
        self.bot_memory_goal_time = undefined;
      }
    }

    if(!var_01 || var_02 < var_03 * var_03) {
      var_06 = bot_random_path();
      if(var_06 && randomfloat(100) < 25) {
        var_07 = scripts\mp\bots\_bots_strategy::bot_get_ambush_trap_item("trap_directional", "trap");
        if(isDefined(var_07)) {
          var_08 = self botgetscriptgoal();
          if(isDefined(var_08)) {
            var_09 = getclosestnodeinsight(var_08);
            if(isDefined(var_09)) {
              var_0A = scripts\mp\bots\_bots_util::bot_queued_process("bot_find_ambush_entrances", ::bot_find_ambush_entrances, var_09, 0);
              var_0B = scripts\mp\bots\_bots_strategy::bot_set_ambush_trap(var_07, var_0A, var_09);
              if(!isDefined(var_0B) || var_0B) {
                self botclearscriptgoal();
                var_06 = bot_random_path();
              }
            }
          }
        }
      }

      if(var_06) {
        thread clear_script_goal_on("enemy", "bad_path", "goal", "node_relinquished", "search_end");
        return;
      }
    }
  }
}

clear_script_goal_on(param_00, param_01, param_02, param_03, param_04) {
  self notify("clear_script_goal_on");
  self endon("clear_script_goal_on");
  self endon("death");
  self endon("disconnect");
  self endon("start_tactical_goal");
  var_05 = self botgetscriptgoal();
  var_06 = 1;
  while(var_06) {
    var_07 = scripts\engine\utility::waittill_any_return(param_00, param_01, param_02, param_03, param_04, "script_goal_changed");
    var_06 = 0;
    var_08 = 1;
    if(var_07 == "node_relinquished" || var_07 == "goal" || var_07 == "script_goal_changed") {
      if(!self bothasscriptgoal()) {
        var_08 = 0;
      } else {
        var_09 = self botgetscriptgoal();
        var_08 = scripts\mp\bots\_bots_util::bot_vectors_are_equal(var_05, var_09);
      }
    }

    if(var_07 == "enemy" && isDefined(self.isnodeoccupied)) {
      var_08 = 0;
      var_06 = 1;
    }

    if(var_08) {
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

bot_add_ambush_time_delayed(param_00, param_01) {
  self notify("bot_add_ambush_time_delayed");
  self endon("bot_add_ambush_time_delayed");
  self endon("death");
  self endon("disconnect");
  if(isDefined(param_00)) {
    self endon(param_00);
  }

  self endon("node_relinquished");
  self endon("bad_path");
  var_02 = gettime();
  if(isDefined(param_01)) {
    self waittill(param_01);
  }

  if(isDefined(self.ambush_end) && isDefined(self.node_ambushing_from)) {
    self.ambush_end = self.ambush_end + gettime() - var_02;
    self.node_ambushing_from.bot_ambush_end = self.ambush_end + 10000;
  }

  self notify("bot_add_ambush_time_delayed");
}

bot_watch_entrances_delayed(param_00, param_01, param_02, param_03) {
  self notify("bot_watch_entrances_delayed");
  if(param_02.size > 0) {
    self endon("bot_watch_entrances_delayed");
    self endon("death");
    self endon("disconnect");
    self endon(param_00);
    self endon("node_relinquished");
    self endon("bad_path");
    if(isDefined(param_01)) {
      self waittill(param_01);
    }

    self endon("path_enemy");
    childthread scripts\mp\bots\_bots_util::bot_watch_nodes(param_02, param_03, 0, self.ambush_end);
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
    foreach(var_01 in self.watch_nodes) {
      var_01.watch_node_chance[self.entity_number] = 1;
    }

    scripts\mp\bots\_bots_strategy::prioritize_watch_nodes_toward_enemies(0.5);
    wait(randomfloatrange(0.5, 0.75));
  }
}

bot_find_ambush_entrances(param_00, param_01) {
  self endon("disconnect");
  var_02 = [];
  var_03 = findentrances(param_00.origin);
  if(isDefined(var_03) && var_03.size > 0) {
    wait(0.05);
    var_04 = param_00.type != "Cover Stand" && param_00.type != "Conceal Stand";
    if(var_04 && param_01) {
      var_03 = self getparent(var_03, "node_exposure_vis", param_00.origin, "crouch");
    }

    foreach(var_06 in var_03) {
      if(distancesquared(self.origin, var_06.origin) < 90000) {
        continue;
      }

      if(var_04 && param_01) {
        wait(0.05);
        if(!scripts\mp\bots\_bots_util::entrance_visible_from(var_06.origin, param_00.origin, "crouch")) {
          continue;
        }
      }

      var_02[var_02.size] = var_06;
    }
  }

  return var_02;
}

bot_filter_ambush_inuse(param_00) {
  var_01 = [];
  var_02 = gettime();
  var_03 = param_00.size;
  for(var_04 = 0; var_04 < var_03; var_04++) {
    var_05 = param_00[var_04];
    if(!isDefined(var_05.bot_ambush_end) || var_02 > var_05.bot_ambush_end) {
      var_01[var_01.size] = var_05;
    }
  }

  return var_01;
}

bot_filter_ambush_vicinity(param_00, param_01, param_02) {
  var_03 = [];
  var_04 = [];
  var_05 = param_02 * param_02;
  if(level.teambased) {
    foreach(var_07 in level.participants) {
      if(!scripts\mp\utility::isreallyalive(var_07)) {
        continue;
      }

      if(!isDefined(var_07.team)) {
        continue;
      }

      if(var_07.team == param_01.team && var_07 != param_01 && isDefined(var_07.node_ambushing_from)) {
        var_04[var_04.size] = var_07.node_ambushing_from.origin;
      }
    }
  }

  var_09 = var_04.size;
  var_0A = param_00.size;
  for(var_0B = 0; var_0B < var_0A; var_0B++) {
    var_0C = 0;
    var_0D = param_00[var_0B];
    for(var_0E = 0; !var_0C && var_0E < var_09; var_0E++) {
      var_0F = distancesquared(var_04[var_0E], var_0D.origin);
      var_0C = var_0F < var_05;
    }

    if(!var_0C) {
      var_03[var_03.size] = var_0D;
    }
  }

  return var_03;
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

  var_00 = getzonenearest(self.origin);
  var_01 = undefined;
  var_02 = undefined;
  var_03 = self.angles;
  if(isDefined(var_00)) {
    var_04 = botzonenearestcount(var_00, self.team, -1, "enemy_predict", ">", 0, "ally", "<", 1);
    if(!isDefined(var_04)) {
      var_04 = botzonenearestcount(var_00, self.team, -1, "enemy_predict", ">", 0);
    }

    if(!isDefined(var_04)) {
      var_05 = -1;
      var_06 = -1;
      for(var_07 = 0; var_07 < level.zonecount; var_07++) {
        var_08 = distance2dsquared(getzoneorigin(var_07), self.origin);
        if(var_08 > var_05) {
          var_05 = var_08;
          var_06 = var_07;
        }
      }

      var_04 = var_06;
    }

    var_09 = getzonepath(var_00, var_04);
    if(isDefined(var_09) && var_09.size > 0) {
      for(var_0A = 0; var_0A <= int(var_09.size / 2); var_0A++) {
        var_01 = var_09[var_0A];
        var_02 = var_09[int(min(var_0A + 1, var_09.size - 1))];
        if(botzonegetcount(var_02, self.team, "enemy_predict") != 0) {
          break;
        }
      }

      if(isDefined(var_01) && isDefined(var_02) && var_01 != var_02) {
        var_03 = getzoneorigin(var_02) - getzoneorigin(var_01);
        var_03 = vectortoangles(var_03);
      }
    }
  }

  var_0B = undefined;
  if(isDefined(var_01)) {
    var_0C = 1;
    var_0D = 1;
    var_0E = 0;
    while(var_0C) {
      var_0F = getzonenodesbydist(var_01, 800 * var_0D, 1);
      if(var_0F.size > 1024) {
        var_0F = getzonenodes(var_01, 0);
      }

      wait(0.05);
      var_10 = randomint(100);
      if(var_10 < 66 && var_10 >= 33) {
        var_03 = (var_03[0], var_03[1] + 45, 0);
      } else if(var_10 < 33) {
        var_03 = (var_03[0], var_03[1] - 45, 0);
      }

      if(var_0F.size > 0) {
        var_11 = int(min(max(1, var_0F.size * 0.15), 5));
        if(var_0E) {
          var_0F = self botnodepickmultiple(var_0F, var_11, var_11, "node_camp", anglesToForward(var_03), "lenient");
        } else {
          var_0F = self botnodepickmultiple(var_0F, var_11, var_11, "node_camp", anglesToForward(var_03));
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
  self.ambush_yaw = var_03[1];
  return 1;
}

find_ambush_node(param_00, param_01) {
  clear_camper_data();
  if(isDefined(param_00)) {
    self.point_to_ambush = param_00;
  } else {
    var_02 = undefined;
    var_03 = getnodesinradius(self.origin, 5000, 0, 2000);
    if(var_03.size > 0) {
      var_02 = self botnodepick(var_03, var_03.size * 0.25, "node_traffic");
    }

    if(isDefined(var_02)) {
      self.point_to_ambush = var_02.origin;
    } else {
      return 0;
    }
  }

  var_04 = 2000;
  if(isDefined(param_01)) {
    var_04 = param_01;
  }

  var_05 = getnodesinradius(self.point_to_ambush, var_04, 0, 1000);
  var_06 = undefined;
  if(var_05.size > 0) {
    var_07 = int(max(1, int(var_05.size * 0.15)));
    var_05 = self botnodepickmultiple(var_05, var_07, var_07, "node_ambush", self.point_to_ambush);
  }

  var_05 = bot_filter_ambush_inuse(var_05);
  if(var_05.size > 0) {
    var_06 = scripts\engine\utility::random_weight_sorted(var_05);
  }

  if(!isDefined(var_06) || !self botnodeavailable(var_06)) {
    return 0;
  }

  self.node_ambushing_from = var_06;
  self.ambush_end = gettime() + self.ambush_duration;
  self.node_ambushing_from.bot_ambush_end = self.ambush_end;
  var_08 = vectornormalize(self.point_to_ambush - self.node_ambushing_from.origin);
  var_09 = vectortoangles(var_08);
  self.ambush_yaw = var_09[1];
  return 1;
}

bot_random_path() {
  if(scripts\mp\bots\_bots_util::bot_is_remote_or_linked()) {
    return 0;
  }

  var_00 = level.bot_random_path_function[self.team];
  return self[[var_00]]();
}

bot_random_path_default() {
  var_00 = 0;
  var_01 = 50;
  if(self.personality == "camper") {
    var_01 = 0;
  }

  var_02 = undefined;
  if(randomint(100) < var_01) {
    var_02 = scripts\mp\bots\_bots_util::bot_recent_point_of_interest();
  }

  if(!isDefined(var_02)) {
    var_03 = self botfindnoderandom();
    if(isDefined(var_03)) {
      var_02 = var_03.origin;
    }
  }

  if(isDefined(var_02)) {
    var_00 = self botsetscriptgoal(var_02, 128, "hunt");
  }

  return var_00;
}

bot_setup_callback_class() {
  if(scripts\mp\bots\_bots_loadout::bot_setup_loadout_callback()) {
    return "callback";
  }

  return "class0";
}