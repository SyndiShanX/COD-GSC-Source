/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\bots\bots_personality.gsc
************************************************/

function setup_personalities() {
  level.bot_personality = [];
  level.bot_personality_list = [];
  level.bot_personality["active"][0] = "run_and_gun";
  level.bot_personality["active"][1] = "cqb";
  level.bot_personality["stationary"][0] = "camper";
  level.bot_personality_type = [];

  foreach(var1 in level.bot_personality) {
    foreach(var3 in var1) {
      level.bot_personality_type[var3] = var5;
      level.bot_personality_list[level.bot_personality_list.size] = var3;
    }
  }

  level.bot_personality_types_desired = [];
  level.bot_personality_types_desired["active"] = 4;
  level.bot_personality_types_desired["stationary"] = 1;
  level.bot_pers_init = [];
  level.bot_pers_init["run_and_gun"] = &init_personality_default;
  level.bot_pers_init["camper"] = &init_personality_camper;
  level.bot_pers_update["run_and_gun"] = &update_personality_default;
  level.bot_pers_update["camper"] = &update_personality_camper;
}

function bot_assign_personality_functions() {
  self.personality = self botgetpersonality();
  self.pers["personality"] = self.personality;
  self.personality_init_function = level.bot_pers_init[self.personality];

  if(!isDefined(self.personality_init_function)) {
    self.personality_init_function = level.bot_pers_init["run_and_gun"];
  }

  self[[self.personality_init_function]]();
  self.personality_update_function = level.bot_pers_update[self.personality];

  if(!isDefined(self.personality_update_function)) {
    self.personality_update_function = level.bot_pers_update["run_and_gun"];
    return;
  }
}

function bot_balance_personality() {
  if(isDefined(self.personalitymanuallyset) && self.personalitymanuallyset) {
    return;
  }

  if(isDefined(self.pers["personality"])) {
    self botsetpersonality(self.pers["personality"]);
    return;
  }

  var0 = self.team;

  if(!isDefined(var0) && !isDefined(self.bot_team)) {
    var0 = self.pers["team"];
  }

  var1 = getarraykeys(level.bot_personality_types_desired);
  var2 = [];
  var3 = [];

  foreach(var9, var5 in level.bot_personality) {
    var3 = 0;

    foreach(var7 in var5) {
      var2 = 0;
    }
  }

  foreach(var11 in level.participants) {
    if(var11 == self) {
      continue;
    }

    if(!scripts\mp\utility\entity::isteamparticipant(var11) || !isDefined(var11.has_balanced_personality)) {
      continue;
    }

    if(isDefined(var11.team) && var11.team == var0 || !level.teambased) {
      var7 = var11 botgetpersonality();
      var9 = level.bot_personality_type[var7];
      var2 = var2[var7] + 1;
      var3 = var3[var9] + 1;
    }
  }

  var13 = [];

  foreach(var15 in var1) {
    var13 = int(var3[var15] / level.bot_personality_types_desired[var15]);
  }

  var17 = undefined;

  for(var18 = 0; var18 < var1.size && !isDefined(var17); var18++) {
    var19 = var1[var18];
    var20 = 1;

    for(var21 = 0; var21 < var1.size; var21++) {
      var22 = var1[var21];

      if(var19 != var22) {
        if(var13[var19] >= var13[var22]) {
          var20 = 0;
        }
      }
    }

    if(var20) {
      var17 = var19;
    }
  }

  if(!isDefined(var17)) {
    var23 = [];

    foreach(var15 in var1) {
      var23 = level.bot_personality_types_desired[var15] - var3[var15] % level.bot_personality_types_desired[var15];
    }

    var26 = 0;

    foreach(var15 in var1) {
      var26 += var23[var15];
    }

    var29 = randomfloat(var26);

    foreach(var15 in var1) {
      if(var29 < var23[var15]) {
        var17 = var15;
        break;
      }

      var29 -= var23[var15];
    }
  }

  var32 = undefined;
  var33 = undefined;
  var34 = 9999;
  var35 = undefined;
  var36 = -9999;
  var37 = scripts\engine\utility::array_randomize(level.bot_personality[var17]);

  foreach(var7 in var37) {
    if(var2[var7] < var34) {
      var33 = var7;
      var34 = var2[var7];
    }

    if(var2[var7] > var36) {
      var35 = var7;
      var36 = var2[var7];
    }
  }

  if(var36 - var34 >= 2) {
    var32 = var33;
  } else {
    var32 = scripts\engine\utility::random(level.bot_personality[var17]);
  }

  if(self botgetpersonality() != var32) {
    self botsetpersonality(var32);
  }

  self.has_balanced_personality = 1;
}

function init_personality_camper() {
  clear_camper_data();
}

function init_personality_default() {
  clear_camper_data();
}

function update_personality_camper() {
  if(should_select_new_ambush_point() && !scripts\mp\bots\bots_util::bot_is_defending() && !scripts\mp\bots\bots_util::bot_is_remote_or_linked()) {
    var0 = self botgetscriptgoaltype();
    var1 = 0;

    if(!isDefined(self.camper_time_started_hunting)) {
      self.camper_time_started_hunting = 0;
    }

    var2 = var0 == "hunt";
    var3 = gettime() > self.camper_time_started_hunting + 10000;

    if((!var2 || var3) && !scripts\mp\bots\bots_util::bot_out_of_ammo()) {
      if(!self bothasscriptgoal()) {
        bot_random_path();
      }

      if(isDefined(level.override_find_camp_node)) {
        var1 = [[level.override_find_camp_node]]();
      }

      if(!var1) {
        var1 = find_camp_node();

        if(!var1) {
          self.camper_time_started_hunting = gettime();
        }
      }
    }

    if(isDefined(var1) && var1) {
      self.ambush_entrances = scripts\mp\bots\bots_util::bot_queued_process("bot_find_ambush_entrances", &bot_find_ambush_entrances, self.node_ambushing_from, 1);
      var4 = scripts\mp\bots\bots_strategy::bot_get_ambush_trap_item("trap_directional", "trap", "c4");

      if(isDefined(var4)) {
        var5 = gettime();
        scripts\mp\bots\bots_strategy::bot_set_ambush_trap(var4, self.ambush_entrances, self.node_ambushing_from, self.ambush_yaw);
        var5 = gettime() - var5;

        if(var5 > 0 && isDefined(self.ambush_end) && isDefined(self.node_ambushing_from)) {
          self.ambush_end += var5;
          self.node_ambushing_from.bot_ambush_end = self.ambush_end + 10000;
        }
      }

      if(!scripts\mp\bots\bots_strategy::bot_has_tactical_goal() && !scripts\mp\bots\bots_util::bot_is_defending() && isDefined(self.node_ambushing_from)) {
        var6 = self botsetscriptgoalnode(self.node_ambushing_from, "camp", self.ambush_yaw);

        if(var6) {
          thread clear_script_goal_on("bad_path", "node_relinquished", "out_of_ammo");
          thread watch_out_of_ammo();
          thread bot_add_ambush_time_delayed("clear_camper_data", "goal");
          thread bot_watch_entrances_delayed("clear_camper_data", "bot_add_ambush_time_delayed", self.ambush_entrances, self.ambush_yaw);
          GscBinSkip4(0x35, "clear_camper_data", "goal");
        }

        clear_camper_data();
        return;
      }

      return;
    }

    if(var1 == "camp") {
      self botclearscriptgoal();
    }

    update_personality_default();
    return;
  }
}

function update_personality_default() {
  var0 = undefined;
  var1 = self bothasscriptgoal();

  if(var1) {
    var0 = self botgetscriptgoal();
  }

  if(gettime() - self.lastspawntime > 5000) {
    bot_try_trap_follower();
  }

  if(!scripts\mp\bots\bots_strategy::bot_has_tactical_goal() && !scripts\mp\bots\bots_util::bot_is_remote_or_linked()) {
    var2 = undefined;
    var3 = undefined;

    if(var1) {
      var2 = distancesquared(self.origin, var0);
      var3 = self botgetscriptgoalRadius();
      var4 = var3 * 2;

      if(isDefined(self.bot_memory_goal) && var2 < var4 * var4) {
        var5 = botmemoryflags("investigated");
        botflagmemoryevents(0, gettime() - self.bot_memory_goal_time, 1, self.bot_memory_goal, var4, "kill", var5, self);
        botflagmemoryevents(0, gettime() - self.bot_memory_goal_time, 1, self.bot_memory_goal, var4, "death", var5, self);
        self.bot_memory_goal = undefined;
        self.bot_memory_goal_time = undefined;
      }
    }

    if(!var1 || var2 < var3 * var3) {
      var6 = bot_random_path();
      var7 = undefined;
      var8 = undefined;

      if(var6) {
        var7 = self botgetscriptgoal();
        var8 = self botgetscriptgoaltype();
      }

      var9 = 25;

      if(istrue(self.encourage_explosive_use)) {
        var9 = 50;
      }

      if(var6 && randomfloat(100) < var9) {
        var10 = scripts\mp\bots\bots_strategy::bot_get_ambush_trap_item("trap_directional", "trap");

        if(isDefined(var10)) {
          var11 = self botgetscriptgoal();

          if(isDefined(var11)) {
            var12 = getclosestnodeinsight(var11);

            if(isDefined(var12) && getlinkednodes(var12).size > 0) {
              var13 = bot_find_ambush_entrances(var12, 0);
              var14 = scripts\mp\bots\bots_strategy::bot_set_ambush_trap(var10, var13, var12);

              if(!isDefined(var14) || var14) {
                self botclearscriptgoal();
                var6 = bot_random_path();

                if(var6) {
                  var7 = self botgetscriptgoal();
                  var8 = self botgetscriptgoaltype();
                }
              }
            }
          }
        }
      }

      if(var6 && self bothasscriptgoal()) {
        var15 = self botgetscriptgoal();
        var16 = self botgetscriptgoaltype();
        var17 = scripts\mp\bots\bots_util::bot_vectors_are_equal(var7, var15);
        var18 = var8 == var16;

        if(var17 && var18) {
          thread clear_script_goal_on("enemy", "bad_path", "goal", "node_relinquished", "search_end");
          return;
        }

        return;
      }

      return;
    }

    return;
  }
}

function bot_try_trap_follower(var0, var1) {}

function clear_script_goal_on(var0, var1, var2, var3, var4) {
  self notify("clear_script_goal_on");
  self endon("clear_script_goal_on");
  self endon("death_or_disconnect");
  self endon("start_tactical_goal");
  var5 = self botgetscriptgoal();
  var6 = 1;

  while(var6) {
    var7 = scripts\engine\utility::ref_143b1(var0, var1, var2, var3, var4, "script_goal_changed");
    var6 = 0;
    var8 = 1;

    if(var7 == "node_relinquished" || var7 == "goal" || var7 == "script_goal_changed") {
      if(!self bothasscriptgoal()) {
        var8 = 0;
      } else {
        var9 = self botgetscriptgoal();
        var8 = scripts\mp\bots\bots_util::bot_vectors_are_equal(var5, var9);
      }
    }

    if(var7 == "enemy" && isDefined(self.enemy)) {
      var8 = 0;
      var6 = 1;
    }

    if(var8) {
      self botclearscriptgoal();
    }
  }
}

function watch_out_of_ammo() {
  self notify("watch_out_of_ammo");
  self endon("watch_out_of_ammo");
  self endon("death_or_disconnect");

  while(!scripts\mp\bots\bots_util::bot_out_of_ammo()) {
    wait 0.5;
  }

  self notify("out_of_ammo");
}

function bot_add_ambush_time_delayed(var0, var1) {
  self notify("bot_add_ambush_time_delayed");
  self endon("bot_add_ambush_time_delayed");
  self endon("death_or_disconnect");

  if(isDefined(var0)) {
    self endon(var0);
  }

  self endon("node_relinquished");
  self endon("bad_path");
  var2 = gettime();

  if(isDefined(var1)) {
    self waittill(var1);
  }

  if(isDefined(self.ambush_end) && isDefined(self.node_ambushing_from)) {
    self.ambush_end += gettime() - var2;
    self.node_ambushing_from.bot_ambush_end = self.ambush_end + 10000;
  }

  self notify("bot_add_ambush_time_delayed");
}

function bot_watch_entrances_delayed(var0, var1, var2, var3) {
  self notify("bot_watch_entrances_delayed");

  if(var2.size > 0) {
    self endon("bot_watch_entrances_delayed");
    self endon("death_or_disconnect");
    self endon(var0);
    self endon("node_relinquished");
    self endon("bad_path");

    if(isDefined(var1)) {
      self waittill(var1);
    }

    self endon("path_enemy");
    childthread scripts\mp\bots\bots_util::bot_watch_nodes(var2, var3, 0, self.ambush_end);
    GscBinSkip4(0x35);
  }
}

function bot_monitor_watch_entrances_camp() {
  self notify("bot_monitor_watch_entrances_camp");
  self endon("bot_monitor_watch_entrances_camp");
  self notify("bot_monitor_watch_entrances");
  self endon("bot_monitor_watch_entrances");
  self endon("bot_watch_nodes_stop");
  self endon("death_or_disconnect");

  for(;;) {
    jumpiftrue(isDefined(self.watch_nodes)) LOC_0000003f;
    wait 0.05;
  }

  while(isDefined(self.watch_nodes)) {
    foreach(var1 in self.watch_nodes) {
      var1.watch_node_chance[self.entity_number] = var1.watch_node_base_chance[self.entity_number];
    }

    scripts\mp\bots\bots_strategy::prioritize_watch_nodes_toward_enemies(0.5);
    wait randomfloatrange(0.5, 0.75);
  }
}

function bot_find_ambush_entrances(var0, var1) {
  self endon("disconnect");
  var2 = [];
  var3 = findentrances(var0.origin);

  if(isDefined(var3) && var3.size > 0) {
    wait 0.05;
    var4 = var0.type != "Cover Stand" && var0.type != "Conceal Stand";

    if(var4 && var1) {
      var3 = self botnodescoremultiple(var3, "node_exposure_vis", var0.origin, "crouch");
    }

    foreach(var6 in var3) {
      if(distancesquared(self.origin, var6.origin) < 90000) {
        continue;
      }

      if(var4 && var1) {
        wait 0.05;

        if(!scripts\mp\bots\bots_util::entrance_visible_from(var6.origin, var0.origin, "crouch")) {
          continue;
        }
      }

      var2 = var6;
    }
  }

  return var2;
}

function bot_filter_ambush_inuse(var0) {
  var1 = [];
  var2 = gettime();
  var3 = var0.size;

  for(var4 = 0; var4 < var3; var4++) {
    var5 = var0[var4];

    if(!isDefined(var5.bot_ambush_end) || var2 > var5.bot_ambush_end) {
      var1 = var5;
    }
  }

  return var1;
}

function bot_filter_ambush_vicinity(var0, var1, var2) {
  var3 = [];
  var4 = [];
  var5 = var2 * var2;

  if(level.teambased) {
    foreach(var7 in level.participants) {
      if(!var7 scripts\cp_mp\utility\player_utility::_isalive()) {
        continue;
      }

      if(!isDefined(var7.team)) {
        continue;
      }

      if(var7.team == var1.team && var7 != var1 && isDefined(var7.node_ambushing_from)) {
        var4 = var7.node_ambushing_from.origin;
      }
    }
  }

  var9 = var4.size;
  var10 = var0.size;

  for(var11 = 0; var11 < var10; var11++) {
    var12 = 0;
    var13 = var0[var11];

    for(var14 = 0; !var12 && var14 < var9; var14++) {
      var15 = distancesquared(var4[var14], var13.origin);
      var12 = var15 < var5;
    }

    if(!var12) {
      var3 = var13;
    }
  }

  return var3;
}

function clear_camper_data() {
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

function should_select_new_ambush_point() {
  if(scripts\mp\bots\bots_strategy::bot_has_tactical_goal()) {
    return false;
  }

  if(gettime() > self.ambush_end) {
    return true;
  }

  if(!self bothasscriptgoal()) {
    return true;
  }

  return false;
}

function find_camp_node() {
  self notify("find_camp_node");
  self endon("find_camp_node");
  return scripts\mp\bots\bots_util::bot_queued_process("find_camp_node_worker", &find_camp_node_worker);
}

function find_camp_node_worker() {
  self notify("find_camp_node_worker");
  self endon("find_camp_node_worker");
  self endon("death_or_disconnect");
  level endon("game_ended");
  clear_camper_data();

  if(level.zonecount <= 0) {
    return false;
  }

  var0 = getzonenearest(self.origin);
  var1 = undefined;
  var2 = undefined;
  var3 = self getplayerangles();

  if(isDefined(var0)) {
    var4 = botzonenearestcount(var0, self.team, -1, "enemy_predict", ">", 0, "ally", "<", 1);

    if(!isDefined(var4)) {
      var4 = botzonenearestcount(var0, self.team, -1, "enemy_predict", ">", 0);
    }

    if(isDefined(var4)) {
      var5 = getzonenodeforindex(var4);
      var6 = getlinkednodes(var5);

      if(var6.size == 0) {
        var4 = undefined;
      }
    }

    if(!isDefined(var4)) {
      var7 = -1;
      var8 = -1;

      for(var9 = 0; var9 < level.zonecount; var9++) {
        var5 = getzonenodeforindex(var9);
        var6 = getlinkednodes(var5);

        if(var6.size > 0) {
          var10 = scripts\engine\utility::random(getzonenodes(var9));
          var11 = isDefined(var10.targetname) && var10.targetname == "no_bot_random_path";

          if(!var11) {
            var12 = distance2dsquared(getzoneorigin(var9), self.origin);

            if(var12 > var7) {
              var7 = var12;
              var8 = var9;
            }
          }
        }
      }

      var4 = var8;
    }

    var13 = getzonepath(var0, var4);

    if(!isDefined(var13) || var13.size == 0) {
      return false;
    }

    for(var14 = 0; var14 <= int(var13.size / 2); var14++) {
      var1 = var13[var14];
      var2 = var13[int(min(var14 + 1, var13.size - 1))];

      if(botzonegetcount(var2, self.team, "enemy_predict") != 0) {
        break;
      }
    }

    if(isDefined(var1) && isDefined(var2) && var1 != var2) {
      var3 = getzoneorigin(var2) - getzoneorigin(var1);
      var3 = vectortoangles(var3);
    }
  }

  var15 = undefined;

  if(isDefined(var1)) {
    var16 = 1;
    var17 = 1;
    var18 = 0;

    while(var16) {
      var19 = getzonenodesbydist(var1, 800 * var17, 1);

      if(var19.size > 1024) {
        var19 = getzonenodes(var1, 0);
      }

      wait 0.05;
      var20 = randomint(100);

      if(var20 < 66 && var20 >= 33) {
        var3 = (var3[0], var3[1] + 45, 0);
      } else if(var20 < 33) {
        var3 = (var3[0], var3[1] - 45, 0);
      }

      if(var19.size > 0) {
        while(var19.size > 1024) {
          var19[var19.size - 1] = undefined;
        }

        var21 = int(clamp(var19.size * 0.15, 1, 10));

        if(var18) {
          var19 = self botnodepickmultiple(var19, var21, var21, "node_camp", anglesToForward(var3), "lenient");
        } else {
          var19 = self botnodepickmultiple(var19, var21, var21, "node_camp", anglesToForward(var3));
        }

        var19 = bot_filter_ambush_inuse(var19);

        if(!isDefined(self.can_camp_near_others) || !self.can_camp_near_others) {
          var22 = 800;
          var19 = bot_filter_ambush_vicinity(var19, self, var22);
        }

        if(var19.size > 0) {
          var15 = scripts\engine\utility::random_weight_sorted(var19);
        }
      }

      if(isDefined(var15)) {
        var16 = 0;
      } else if(isDefined(self.camping_needs_fallback_camp_location)) {
        if(var17 == 1 && !var18) {
          var17 = 3;
        } else if(var17 == 3 && !var18) {
          var18 = 1;
        } else if(var17 == 3 && var18) {
          var16 = 0;
        }
      } else {
        var16 = 0;
      }

      if(var16) {
        wait 0.05;
      }
    }
  }

  if(!isDefined(var15) || !self botnodeavailable(var15)) {
    return false;
  }

  self.node_ambushing_from = var15;
  self.ambush_end = gettime() + self.ambush_duration;
  self.node_ambushing_from.bot_ambush_end = self.ambush_end;
  self.ambush_yaw = var3[1];
  return true;
}

function find_ambush_node(var0, var1) {
  clear_camper_data();

  if(isDefined(var0)) {
    self.point_to_ambush = var0;
  } else {
    var2 = undefined;
    var3 = getnodesinradius(self.origin, 5000, 0, 2000);

    if(var3.size > 0) {
      var2 = self botnodepick(var3, var3.size * 0.25, "node_traffic");
    }

    if(isDefined(var2)) {
      self.point_to_ambush = var2.origin;
    } else {
      return false;
    }
  }

  var4 = 2000;

  if(isDefined(var1)) {
    var4 = var1;
  }

  var5 = getnodesinradius(self.point_to_ambush, var4, 0, 1000);
  var6 = undefined;

  if(var5.size > 0) {
    var7 = int(max(1, int(var5.size * 0.15)));
    var5 = self botnodepickmultiple(var5, var7, var7, "node_ambush", self.point_to_ambush);
  }

  var5 = bot_filter_ambush_inuse(var5);

  if(var5.size > 0) {
    var6 = scripts\engine\utility::random_weight_sorted(var5);
  }

  if(!isDefined(var6) || !self botnodeavailable(var6)) {
    return false;
  }

  self.node_ambushing_from = var6;
  self.ambush_end = gettime() + self.ambush_duration;
  self.node_ambushing_from.bot_ambush_end = self.ambush_end;
  var8 = vectorNormalize(self.point_to_ambush - self.node_ambushing_from.origin);
  var9 = vectortoangles(var8);
  self.ambush_yaw = var9[1];
  return true;
}

function bot_random_path() {
  if(scripts\mp\bots\bots_util::bot_is_remote_or_linked()) {
    return 0;
  }

  return self[[level.bot_random_path_function]]();
}

function bot_random_path_default() {
  var0 = 0;
  var1 = 50;

  if(self.personality == "camper") {
    var1 = 0;
  }

  var2 = undefined;

  if(randomint(100) < var1) {
    var2 = scripts\mp\bots\bots_util::bot_recent_point_of_interest();
  }

  if(!isDefined(var2)) {
    var2 = self botfindrandomgoal();
  }

  if(isDefined(var2)) {
    var0 = self botsetscriptgoal(var2, 128, "hunt");
  }

  return var0;
}

function bot_setup_callback_class() {
  if(scripts\mp\bots\bots_loadout::bot_setup_loadout_callback()) {
    return "callback";
  }

  return "class0";
}