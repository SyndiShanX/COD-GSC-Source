/*****************************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\mp\bots\_bots_gametype_oldschool.gsc
*****************************************************/

bot_oldschool_init() {
  if(!level.oldschool) {
    return;
  }
  while (!isdefined(level.allpickupstracked))
    wait 0.05;

  level.bot_oldschool_pickup_struct_array = [];
  var_0 = getentarray("oldschool_pickup", "targetname");

  foreach(var_2 in var_0) {
    if(isdefined(var_2.script_parameters) && var_2.script_parameters == "bots_ignore") {
      continue;
    }
    var_3 = spawnstruct();
    var_3.origin = var_2.origin;
    var_3.nearest_node = bot_oldschool_pickup_get_nearest_node(var_2);
    var_3.ground_pos = var_2.groundpoint;
    var_3.respawntime = var_2.respawntime;

    if(bot_oldschool_pickup_isweapon(var_2)) {
      var_3.type = "weapon";
      var_3.weaponname = bot_oldschool_pickup_get_weapon_name(var_2);
    } else if(bot_oldschool_pickup_isperk(var_2)) {
      var_3.type = "perk";
      var_3.perkname = bot_oldschool_pickup_get_perk_name(var_2);
    }

    level.bot_oldschool_pickup_struct_array[level.bot_oldschool_pickup_struct_array.size] = var_3;
  }

  maps\mp\bots\_bots_util::bot_waittill_bots_enabled();

  if(!isdefined(level.bot_oldschool_primary_weapon_priorities)) {
    level.bot_oldschool_primary_weapon_priorities["camper"] = [];
    level.bot_oldschool_primary_weapon_priorities["camper"]["pistol"] = 0;
    level.bot_oldschool_primary_weapon_priorities["camper"]["spread"] = 2;
    level.bot_oldschool_primary_weapon_priorities["camper"]["smg"] = 4;
    level.bot_oldschool_primary_weapon_priorities["camper"]["rifle"] = 6;
    level.bot_oldschool_primary_weapon_priorities["camper"]["mg"] = 8;
    level.bot_oldschool_primary_weapon_priorities["camper"]["sniper"] = 10;
    level.bot_oldschool_primary_weapon_priorities["cqb"] = [];
    level.bot_oldschool_primary_weapon_priorities["cqb"]["sniper"] = 0;
    level.bot_oldschool_primary_weapon_priorities["cqb"]["pistol"] = 0;
    level.bot_oldschool_primary_weapon_priorities["cqb"]["mg"] = 2;
    level.bot_oldschool_primary_weapon_priorities["cqb"]["rifle"] = 5;
    level.bot_oldschool_primary_weapon_priorities["cqb"]["spread"] = 10;
    level.bot_oldschool_primary_weapon_priorities["cqb"]["smg"] = 10;
    level.bot_oldschool_primary_weapon_priorities["run_and_gun"] = [];
    level.bot_oldschool_primary_weapon_priorities["run_and_gun"]["sniper"] = 0;
    level.bot_oldschool_primary_weapon_priorities["run_and_gun"]["spread"] = 0;
    level.bot_oldschool_primary_weapon_priorities["run_and_gun"]["pistol"] = 0;
    level.bot_oldschool_primary_weapon_priorities["run_and_gun"]["smg"] = 5;
    level.bot_oldschool_primary_weapon_priorities["run_and_gun"]["rifle"] = 10;
    level.bot_oldschool_primary_weapon_priorities["run_and_gun"]["mg"] = 10;
  }

  if(!isdefined(level.bot_oldschool_secondary_weapon_priorities)) {
    level.bot_oldschool_secondary_weapon_priorities["camper"] = [];
    level.bot_oldschool_secondary_weapon_priorities["camper"]["rifle"] = 0;
    level.bot_oldschool_secondary_weapon_priorities["camper"]["mg"] = 0;
    level.bot_oldschool_secondary_weapon_priorities["camper"]["sniper"] = 0;
    level.bot_oldschool_secondary_weapon_priorities["camper"]["pistol"] = 5;
    level.bot_oldschool_secondary_weapon_priorities["camper"]["spread"] = 10;
    level.bot_oldschool_secondary_weapon_priorities["camper"]["smg"] = 10;
    level.bot_oldschool_secondary_weapon_priorities["cqb"] = [];
    level.bot_oldschool_secondary_weapon_priorities["cqb"]["rifle"] = 0;
    level.bot_oldschool_secondary_weapon_priorities["cqb"]["mg"] = 0;
    level.bot_oldschool_secondary_weapon_priorities["cqb"]["sniper"] = 0;
    level.bot_oldschool_secondary_weapon_priorities["cqb"]["spread"] = 0;
    level.bot_oldschool_secondary_weapon_priorities["cqb"]["smg"] = 0;
    level.bot_oldschool_secondary_weapon_priorities["cqb"]["pistol"] = 10;
    level.bot_oldschool_secondary_weapon_priorities["run_and_gun"] = [];
    level.bot_oldschool_secondary_weapon_priorities["run_and_gun"]["rifle"] = 0;
    level.bot_oldschool_secondary_weapon_priorities["run_and_gun"]["mg"] = 0;
    level.bot_oldschool_secondary_weapon_priorities["run_and_gun"]["sniper"] = 0;
    level.bot_oldschool_secondary_weapon_priorities["run_and_gun"]["spread"] = 0;
    level.bot_oldschool_secondary_weapon_priorities["run_and_gun"]["smg"] = 0;
    level.bot_oldschool_secondary_weapon_priorities["run_and_gun"]["pistol"] = 10;
  }

  if(!isdefined(level.bot_oldschool_pickup_memory_time_seen)) {
    level.bot_oldschool_pickup_memory_time_seen["recruit"] = 10000;
    level.bot_oldschool_pickup_memory_time_seen["regular"] = 20000;
    level.bot_oldschool_pickup_memory_time_seen["hardened"] = 30000;
  }

  if(!isdefined(level.bot_oldschool_pickup_memory_picked_up)) {
    level.bot_oldschool_pickup_memory_picked_up["recruit"] = 20000;
    level.bot_oldschool_pickup_memory_picked_up["regular"] = 40000;
    level.bot_oldschool_pickup_memory_picked_up["hardened"] = 60000;
  }

  if(!isdefined(level.bot_oldschool_pickup_close_radius_self_sq))
    level.bot_oldschool_pickup_close_radius_self_sq = 490000;

  if(!isdefined(level.bot_oldschool_pickup_close_obj_radius_self_sq))
    level.bot_oldschool_pickup_close_obj_radius_self_sq = 250000;

  if(!isdefined(level.bot_oldschool_pickup_close_crit_radius_self_sq))
    level.bot_oldschool_pickup_close_crit_radius_self_sq = 160000;

  if(!isdefined(level.bot_oldschool_use_radius_sq))
    level.bot_oldschool_use_radius_sq = squared(getdvarfloat("player_useRadius"));

  if(!isdefined(level.bot_oldschool_weapon_switch_time)) {
    level.bot_oldschool_weapon_switch_time["veteran"]["min"] = 0.75;
    level.bot_oldschool_weapon_switch_time["veteran"]["max"] = 0.85;
    level.bot_oldschool_weapon_switch_time["hardened"]["min"] = 0.85;
    level.bot_oldschool_weapon_switch_time["hardened"]["max"] = 1.0;
    level.bot_oldschool_weapon_switch_time["regular"]["min"] = 1.0;
    level.bot_oldschool_weapon_switch_time["regular"]["max"] = 1.25;
    level.bot_oldschool_weapon_switch_time["recruit"]["min"] = 1.25;
    level.bot_oldschool_weapon_switch_time["recruit"]["max"] = 2.0;
  }

  if(!isdefined(level.bot_oldschool_weapon_pickup_time)) {
    level.bot_oldschool_weapon_pickup_time["veteran"]["min"] = 0.5;
    level.bot_oldschool_weapon_pickup_time["veteran"]["max"] = 0.6;
    level.bot_oldschool_weapon_pickup_time["hardened"]["min"] = 0.6;
    level.bot_oldschool_weapon_pickup_time["hardened"]["max"] = 0.75;
    level.bot_oldschool_weapon_pickup_time["regular"]["min"] = 0.75;
    level.bot_oldschool_weapon_pickup_time["regular"]["max"] = 1.25;
    level.bot_oldschool_weapon_pickup_time["recruit"]["min"] = 1.25;
    level.bot_oldschool_weapon_pickup_time["recruit"]["max"] = 2.5;
  }

  if(!isdefined(level.bot_oldschool_perk_pickup_time)) {
    level.bot_oldschool_perk_pickup_time["veteran"]["min"] = 0.05;
    level.bot_oldschool_perk_pickup_time["veteran"]["max"] = 0.1;
    level.bot_oldschool_perk_pickup_time["hardened"]["min"] = 0.1;
    level.bot_oldschool_perk_pickup_time["hardened"]["max"] = 0.25;
    level.bot_oldschool_perk_pickup_time["regular"]["min"] = 0.25;
    level.bot_oldschool_perk_pickup_time["regular"]["max"] = 0.5;
    level.bot_oldschool_perk_pickup_time["recruit"]["min"] = 0.5;
    level.bot_oldschool_perk_pickup_time["recruit"]["max"] = 1.0;
  }

  level.override_find_camp_node = ::oldschool_attempt_camp_pickup;
}

bot_think_oldschool() {
  self notify("bot_think_oldschool");
  self endon("bot_think_oldschool");
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");

  if(!level.oldschool) {
    return;
  }
  thread bot_oldschool_track_pickups_in_sight();
  childthread bot_oldschool_handle_pickup_goals();
}

bot_oldschool_pickup_get_nearest_node(var_0) {
  if(!isdefined(var_0.calculated_nearest_node)) {
    var_0.nearest_node = getclosestnodeinsight(var_0.origin);

    if(!isdefined(var_0.nearest_node))
      var_0.nearest_node = getclosestnodeinsight(var_0.groundpoint);

    var_0.calculated_nearest_node = 1;
  }

  return var_0.nearest_node;
}

bot_oldschool_init_pickups() {
  while (!isdefined(level.bot_oldschool_pickup_struct_array))
    wait 0.05;

  self.pickup_array = [];
  var_0 = self botgetdifficultysetting("strategyLevel");
  var_1 = var_0 / 3.0;

  foreach(var_3 in level.bot_oldschool_pickup_struct_array) {
    var_4 = spawnstruct();
    var_4.parent = var_3;
    var_4.origin = var_3.origin;
    var_4.nearest_node = var_3.nearest_node;
    var_4.ground_pos = var_3.ground_pos;
    var_4.type = var_3.type;
    var_4.weaponname = var_3.weaponname;
    var_4.perkname = var_3.perkname;
    var_4.respawntime = var_3.respawntime;
    var_4.last_time_seen = 0;
    var_4.sight_time = 0;
    var_4.next_valid_time = 0;
    var_4.last_pickup_time = 0;
    var_4.always_known = randomfloat(1.0) < var_1;
    self.pickup_array[self.pickup_array.size] = var_4;
  }
}

bot_oldschool_track_pickups_in_sight() {
  self endon("disconnect");
  level endon("game_ended");

  if(isdefined(self.pickup_array)) {
    return;
  }
  bot_oldschool_init_pickups();
  var_0 = self botgetdifficultysetting("averageEnemySightTime") / 1000.0;
  var_1 = var_0 * 0.7;

  for (;;) {
    var_2 = common_scripts\utility::random([0.1, 0.15, 0.2]);
    wait(var_2);
    var_3 = self getnearestnode();

    if(!isdefined(var_3)) {
      continue;
    }
    var_4 = gettime();
    var_5 = self botgetfovdot();
    var_6 = self _meth_8576();

    foreach(var_8 in self.pickup_array) {
      if(!isdefined(var_8.pickup))
        var_8.pickup = bot_oldschool_get_pickup_ent_for_struct(var_8);

      var_9 = 0;

      if(distancesquared(self.origin, var_8.origin) < 1600) {
        var_9 = 1;
        var_8.sight_time = var_1;
      } else if(bot_oldschool_pickup_is_probably_visible(var_8, var_3, var_5, var_6))
        var_9 = bot_oldschool_pickup_trace_passed(var_8);

      if(var_9) {
        if(var_8.sight_time < var_1) {
          var_10 = vectornormalize(var_8.origin - self.origin);
          var_11 = anglestoforward(self getplayerangles());
          var_12 = vectordot(var_10, var_11);
          var_13 = clamp((var_12 - var_5) / (1.0 - var_5), 0.0, 1.0);
          var_14 = distance(self.origin, var_8.origin);
          var_15 = clamp((var_14 - 3000) / -2500, 0.0, 1.0);
          var_16 = (var_2 * var_13 + var_2 * var_15) * 0.5;
          var_8.sight_time = min(var_8.sight_time + var_16, var_1);
        }
      } else if(var_8.sight_time > 0)
        var_8.sight_time = max(var_8.sight_time - var_2, 0);

      if(var_8.sight_time >= var_1) {
        var_8.last_time_seen = var_4;

        if(!isdefined(var_8.pickup)) {
          bot_oldschool_update_pickup_recharge_time(var_4, var_8);
          continue;
        }

        var_17 = 0;

        if(var_8.last_pickup_time > 0 && gettime() - var_8.last_pickup_time < var_8.respawntime * 1000)
          var_17 = 1;

        if(!var_17)
          bot_oldschool_reset_pickup_recharge_time(var_8);
      }
    }

    wait 0.25;
  }
}

bot_oldschool_handle_pickup_goals() {
  var_0 = undefined;

  for (;;) {
    wait 0.5;

    if(!isalive(self) || maps\mp\_utility::is_true(self.inlaststand) || maps\mp\bots\_bots_util::bot_is_remote_or_linked() || self usebuttonpressed()) {
      continue;
    }
    var_1 = maps\mp\bots\_bots_strategy::bot_get_active_tactical_goals_of_type("oldschool_pickup");
    var_2 = self botgetscriptgoaltype();

    if(var_2 == "tactical") {
      var_3 = 0;

      if(var_1.size > 0)
        var_3 = maps\mp\bots\_bots_util::bot_vectors_are_equal(self botgetscriptgoal(), var_1[0].object.ground_pos);

      if(!var_3) {
        if(var_1.size > 0)
          self notify("stop_tactical_goal");

        continue;
      }
    }

    if(maps\mp\bots\_bots_strategy::bot_has_tactical_goal("oldschool_pickup") && self.tactical_goal_in_action_thread) {
      continue;
    }
    if(maps\mp\bots\_bots_util::bot_in_combat(1000)) {
      continue;
    }
    if(isdefined(self.role) && self.role == "defuser") {
      continue;
    }
    var_4 = gettime();
    var_5 = [];

    foreach(var_7 in self.pickup_array) {
      if(bot_oldschool_pickup_is_recharging(var_4, var_7)) {
        continue;
      }
      if(!bot_oldschool_bot_remembers_pickup(var_4, var_7)) {
        continue;
      }
      var_5[var_5.size] = var_7;
    }

    var_9 = common_scripts\utility::get_array_of_closest(self.origin, var_5);

    if(isdefined(var_0))
      var_10 = var_0;
    else {
      var_10 = "normal";

      if(var_2 == "critical")
        var_10 = "critical";
      else if(maps\mp\bots\_bots_util::bot_is_defending() || var_2 == "objective")
        var_10 = "objective";
    }

    var_11 = undefined;

    foreach(var_7 in var_9) {
      if(var_7.type == "weapon") {
        var_13 = bot_oldschool_pickup_get_desired_weapon_pickup_action(var_7.weaponname);

        if(bot_oldschool_should_pickup_weapon(var_13, var_7, var_10)) {
          var_11["pickup_struct"] = var_7;
          var_11["action"] = var_13["action"];
          var_11["weapon_to_replace"] = var_13["weapon_to_replace"];
          break;
        }

        continue;
      }

      if(var_7.type == "perk") {
        if(bot_oldschool_should_pickup_perk(var_7, var_10)) {
          var_11["pickup_struct"] = var_7;
          var_11["action"] = "pickup_perk";
          break;
        }
      } else {

      }
    }

    if(var_1.size > 0) {
      if(isdefined(var_11) && maps\mp\bots\_bots_strategy::bot_has_tactical_goal("oldschool_pickup", var_11["pickup_struct"])) {
        continue;
      }
      var_15 = distancesquared(self.origin, var_1[0].object.origin);

      if(var_15 <= level.bot_oldschool_use_radius_sq) {
        continue;
      }
      maps\mp\bots\_bots_strategy::bot_abort_tactical_goal("oldschool_pickup");
      wait 0.25;
    }

    if(isdefined(var_11)) {
      var_16 = spawnstruct();
      var_16.object = var_11["pickup_struct"];
      var_16.script_goal_radius = 40;
      var_16.should_abort = ::bot_oldschool_pickup_deleted;

      if(var_10 == "normal")
        var_16.script_goal_type = "guard";

      var_16.clear_prev_goal = 1;
      var_16.short_term_goal = 1;

      if(var_11["action"] == "pickup_weapon") {
        var_16.action_thread = ::bot_oldschool_pickup_weapon;
        var_16.optional_params = var_11["weapon_to_replace"];
      } else if(var_11["action"] == "pickup_perk")
        var_16.action_thread = ::bot_oldschool_pickup_perk;
      else if(var_11["action"] == "pickup_ammo")
        var_16.action_thread = ::bot_oldschool_pickup_ammo;
      else {

      }

      maps\mp\bots\_bots_strategy::bot_new_tactical_goal("oldschool_pickup", var_11["pickup_struct"].ground_pos, 20, var_16);
      var_0 = var_10;
      continue;
    }

    var_0 = undefined;
  }
}

bot_oldschool_bot_remembers_pickup(var_0, var_1) {
  if(var_1.always_known)
    return 1;

  if(var_1.last_time_seen > 0) {
    var_2 = var_0 - var_1.last_time_seen;

    if(var_2 <= level.bot_oldschool_pickup_memory_time_seen[self.difficulty])
      return 1;
  }

  if(var_1.last_pickup_time > 0) {
    var_3 = var_0 - var_1.last_pickup_time;

    if(var_3 <= level.bot_oldschool_pickup_memory_picked_up[self.difficulty])
      return 1;
  }

  if(maps\mp\bots\_bots_strategy::bot_has_tactical_goal("oldschool_pickup", var_1))
    return 1;

  return 0;
}

bot_oldschool_can_currently_see_pickup(var_0, var_1) {
  return var_0 - var_1.last_time_seen <= 500;
}

bot_oldschool_get_pickup_ent_for_struct(var_0) {
  var_1 = getentarray("oldschool_pickup", "targetname");

  foreach(var_3 in var_1) {
    if(distance2dsquared(var_0.origin, var_3.origin) < 16)
      return var_3;
  }

  return undefined;
}

bot_oldschool_pickup_is_recharging(var_0, var_1) {
  return var_0 < var_1.next_valid_time;
}

bot_oldschool_update_pickup_recharge_time(var_0, var_1) {
  if(!bot_oldschool_pickup_is_recharging(var_0, var_1)) {
    var_2 = (4 - self botgetdifficultysetting("strategyLevel")) * 0.15;
    var_3 = randomfloatrange(1.0 - var_2, 1.0 + var_2);
    var_4 = var_1.respawntime * var_3;
    var_1.next_valid_time = var_0 + var_4 * 1000;
  }
}

bot_oldschool_reset_pickup_recharge_time(var_0) {
  var_0.next_valid_time = 0;
}

bot_oldschool_update_pickup_time(var_0, var_1) {
  var_1.last_pickup_time = var_0;
}

bot_oldschool_should_pickup_weapon(var_0, var_1, var_2) {
  if(var_2 != "normal" && var_0["action"] != "do_not_pickup") {
    if(bot_oldschool_nearly_out_of_ammo_for_active_weapon())
      return 1;

    return bot_oldschool_should_pursue_pickup(var_1, var_2);
  }

  if(var_0["action"] == "pickup_weapon") {
    var_3 = weaponclass(var_1.weaponname);

    if(var_3 == "rocketlauncher" || var_3 == "grenade")
      return bot_oldschool_should_pursue_pickup(var_1, "normal");

    return 1;
  } else if(var_0["action"] == "pickup_ammo") {
    if(bot_oldschool_nearly_out_of_ammo_for_active_weapon())
      return 1;

    return bot_oldschool_should_pursue_pickup(var_1, "normal");
  }

  return 0;
}

bot_oldschool_should_pickup_perk(var_0, var_1) {
  if(maps\mp\_utility::_hasperk(var_0.perkname))
    return 0;

  if(var_1 != "normal")
    return bot_oldschool_should_pursue_pickup(var_0, var_1);

  if(self.personality == "camper")
    return bot_oldschool_should_pursue_pickup(var_0, "normal");

  return 1;
}

bot_oldschool_should_pursue_pickup(var_0, var_1) {
  var_2 = var_1 == "normal";

  if(var_2 && self bothasscriptgoal()) {
    var_3 = self botgetscriptgoal();
    var_4 = self botgetscriptgoalradius();

    if(distancesquared(self.origin, var_3) < squared(var_4)) {
      var_5 = 0;
      var_6 = maps\mp\bots\_bots_strategy::bot_get_active_tactical_goals_of_type("oldschool_pickup");

      if(var_6.size == 1)
        var_5 = maps\mp\bots\_bots_util::bot_vectors_are_equal(var_3, var_6[0].object.ground_pos);

      if(!var_5)
        return 0;
    }
  }

  var_7 = level.bot_oldschool_pickup_close_radius_self_sq;

  if(var_1 == "critical")
    var_7 = level.bot_oldschool_pickup_close_crit_radius_self_sq;
  else if(var_1 == "objective")
    var_7 = level.bot_oldschool_pickup_close_obj_radius_self_sq;

  if(distancesquared(self.origin, var_0.origin) < var_7)
    return 1;

  return 0;
}

bot_oldschool_pickup_weapon(var_0) {
  if(maps\mp\bots\_bots_util::bot_in_combat(1000)) {
    while (maps\mp\bots\_bots_util::bot_in_combat(1000))
      wait 0.05;
  } else {
    var_1 = randomfloatrange(level.bot_oldschool_weapon_pickup_time[self.difficulty]["min"], level.bot_oldschool_weapon_pickup_time[self.difficulty]["max"]) * 0.5;
    wait(var_1);
  }

  if(isdefined(var_0.object) && !bot_oldschool_pickup_is_recharging(gettime(), var_0.object)) {
    if(isdefined(var_0.optional_params)) {
      var_2 = self getcurrentweapon() != var_0.optional_params;
      self switchtoweapon(var_0.optional_params);

      if(var_2) {
        var_3 = randomfloatrange(level.bot_oldschool_weapon_switch_time[self.difficulty]["min"], level.bot_oldschool_weapon_switch_time[self.difficulty]["max"]);
        wait(var_3);
      }
    }

    self botpressbutton("use", 1.0);
    var_4 = gettime();

    while (!self hasweapon(var_0.object.weaponname) && gettime() - var_4 < 1000.0 || gettime() - var_4 <= 100)
      wait 0.05;

    var_5 = randomfloatrange(level.bot_oldschool_weapon_pickup_time[self.difficulty]["min"], level.bot_oldschool_weapon_pickup_time[self.difficulty]["max"]);
    var_6 = 0;

    if(self hasweapon(var_0.object.weaponname) && weaponclass(var_0.object.weaponname) != "grenade") {
      self switchtoweapon(var_0.object.weaponname);

      if(weaponclass(var_0.object.weaponname) == "rocketlauncher")
        var_6 = 0.75;
    }

    wait(var_5 + var_6);
    self switchtoweapon("none");
    var_7 = gettime();
    bot_oldschool_update_pickup_recharge_time(var_7, var_0.object);
    bot_oldschool_update_pickup_time(var_7, var_0.object);
  }
}

bot_oldschool_pickup_ammo(var_0) {
  var_1 = gettime();
  bot_oldschool_update_pickup_recharge_time(var_1, var_0.object);
  bot_oldschool_update_pickup_time(var_1, var_0.object);
}

bot_oldschool_pickup_perk(var_0) {
  if(maps\mp\bots\_bots_util::bot_in_combat(1000)) {
    while (maps\mp\bots\_bots_util::bot_in_combat(1000))
      wait 0.05;
  } else {
    var_1 = randomfloatrange(level.bot_oldschool_perk_pickup_time[self.difficulty]["min"], level.bot_oldschool_perk_pickup_time[self.difficulty]["max"]) * 0.5;
    wait(var_1);
  }

  if(isdefined(var_0.object) && !bot_oldschool_pickup_is_recharging(gettime(), var_0.object)) {
    self botpressbutton("use", 1.0);
    var_2 = gettime();

    while (!maps\mp\_utility::_hasperk(var_0.object.perkname) && gettime() - var_2 < 1000.0 || gettime() - var_2 <= 100)
      wait 0.05;

    var_3 = randomfloatrange(level.bot_oldschool_perk_pickup_time[self.difficulty]["min"], level.bot_oldschool_perk_pickup_time[self.difficulty]["max"]);
    wait(var_3);
    var_4 = gettime();
    bot_oldschool_update_pickup_recharge_time(var_4, var_0.object);
    bot_oldschool_update_pickup_time(var_4, var_0.object);
  }
}

bot_oldschool_pickup_deleted(var_0) {
  if(!isdefined(var_0.object) || bot_oldschool_pickup_is_recharging(gettime(), var_0.object))
    return 1;

  return 0;
}

bot_oldschool_pickup_get_desired_weapon_pickup_action(var_0) {
  var_1["action"] = "do_not_pickup";
  var_2 = weaponclass(var_0);

  if(var_2 == "grenade") {
    if(maps\mp\gametypes\_class::isvalidoffhand(var_0)) {
      var_3 = 0;
      var_4 = self gettacticalweapon();

      if(var_4 != "none")
        var_3 = self getweaponammoclip(var_4);

      if(var_3 > 0) {
        if(var_0 == var_4) {
          if(bot_oldschool_is_valid_ammo_pickup(var_0))
            var_1["action"] = "pickup_ammo";
        }
      } else if(!self hasweapon(var_0))
        var_1["action"] = "pickup_weapon";
      else if(bot_oldschool_is_valid_ammo_pickup(var_0))
        var_1["action"] = "pickup_ammo";
    } else if(bot_oldschool_is_valid_ammo_pickup(var_0))
      var_1["action"] = "pickup_ammo";

    return var_1;
  } else if(var_2 == "rocketlauncher") {
    if(!self hasweapon(var_0))
      var_1["action"] = "pickup_weapon";
    else if(bot_oldschool_is_valid_ammo_pickup(var_0))
      var_1["action"] = "pickup_ammo";

    return var_1;
  }

  var_5 = self.personality;

  if(var_5 == "default")
    var_5 = "run_and_gun";

  var_6 = maps\mp\bots\_bots_util::bot_get_active_and_stowed_weapons();
  var_7 = weaponclass(var_6["active"]);
  var_8 = weaponclass(var_6["stowed"]);
  var_9 = bot_oldschool_calculate_primary_and_secondary_weapons(var_5, var_6["active"], var_7, var_6["stowed"], var_8);
  var_10 = bot_oldschool_get_weapon_primary_priority(var_5, var_2);
  var_11 = bot_oldschool_get_weapon_primary_priority(var_5, var_9["primary"]["class"]);
  var_11 = var_11 + bot_oldschool_adjust_weapon_priority(var_9["primary"]["weap"], var_7);

  if(var_10 > var_11) {
    var_1["action"] = "pickup_weapon";
    var_1["weapon_to_replace"] = var_9["primary"]["weap"];
    return var_1;
  }

  var_12 = bot_oldschool_get_weapon_secondary_priority(var_5, var_2);
  var_13 = bot_oldschool_get_weapon_secondary_priority(var_5, var_9["secondary"]["class"]);
  var_13 = var_13 + bot_oldschool_adjust_weapon_priority(var_9["secondary"]["weap"], var_8);

  if(var_12 > var_13) {
    var_1["action"] = "pickup_weapon";
    var_1["weapon_to_replace"] = var_9["secondary"]["weap"];
    return var_1;
  }

  if(bot_oldschool_is_valid_ammo_pickup(var_0))
    var_1["action"] = "pickup_ammo";

  return var_1;
}

bot_oldschool_is_valid_ammo_pickup(var_0) {
  if(self botgetdifficultysetting("strategyLevel") > 0) {
    if(!self hascompatibleweapon(var_0))
      return 0;

    var_1 = self maxpickupammo(var_0);

    if(var_1 <= 0)
      return 0;
  }

  return 1;
}

bot_oldschool_adjust_weapon_priority(var_0, var_1) {
  if(maps\mp\_utility::getbaseweaponname(var_0) == "h1_skorpion")
    return -1;

  if(bot_oldschool_nearly_out_of_ammo_for_weapon(var_0, var_1))
    return -10;

  return 0;
}

bot_oldschool_nearly_out_of_ammo_for_active_weapon() {
  var_0 = maps\mp\bots\_bots_util::bot_get_active_and_stowed_weapons();
  var_1 = weaponclass(var_0["active"]);

  if(bot_oldschool_nearly_out_of_ammo_for_weapon(var_0["active"], var_1))
    return 1;

  return 0;
}

bot_oldschool_nearly_out_of_ammo_for_weapon(var_0, var_1) {
  if(var_1 == "grenade") {
    if(self getweaponammoclip(var_0) <= 0)
      return 1;
  } else {
    var_2 = self getweaponammostock(var_0);
    var_3 = self getweaponammoclip(var_0);
    var_4 = weaponclipsize(var_0, self);

    if(var_2 + var_3 <= var_4)
      return 1;
  }

  return 0;
}

bot_oldschool_calculate_primary_and_secondary_weapons(var_0, var_1, var_2, var_3, var_4) {
  var_5 = bot_oldschool_get_weapon_primary_priority(var_0, var_2);
  var_6 = bot_oldschool_get_weapon_secondary_priority(var_0, var_2);
  var_7 = bot_oldschool_get_weapon_primary_priority(var_0, var_4);
  var_8 = bot_oldschool_get_weapon_secondary_priority(var_0, var_4);
  var_9["primary"] = [];
  var_9["secondary"] = [];
  var_10 = var_5 - var_7;
  var_11 = var_6 - var_8;

  if(var_10 >= var_11) {
    var_9["primary"]["weap"] = var_1;
    var_9["primary"]["class"] = var_2;
    var_9["secondary"]["weap"] = var_3;
    var_9["secondary"]["class"] = var_4;
  } else {
    var_9["primary"]["weap"] = var_3;
    var_9["primary"]["class"] = var_4;
    var_9["secondary"]["weap"] = var_1;
    var_9["secondary"]["class"] = var_2;
  }

  return var_9;
}

bot_oldschool_get_weapon_primary_priority(var_0, var_1) {
  return level.bot_oldschool_primary_weapon_priorities[var_0][var_1];
}

bot_oldschool_get_weapon_secondary_priority(var_0, var_1) {
  return level.bot_oldschool_secondary_weapon_priorities[var_0][var_1];
}

bot_oldschool_pickup_isweapon(var_0) {
  return issubstr(var_0.classname, "weapon_");
}

bot_oldschool_pickup_get_weapon_name(var_0) {
  return var_0 maps\mp\gametypes\_weapons::getitemweaponname();
}

bot_oldschool_pickup_isperk(var_0) {
  return var_0.classname == "script_model";
}

bot_oldschool_pickup_get_perk_name(var_0) {
  return var_0.script_noteworthy;
}

bot_oldschool_pickup_is_probably_visible(var_0, var_1, var_2, var_3) {
  if(!nodesvisible(var_0.nearest_node, var_1, 1))
    return 0;

  var_4 = var_0.origin - self geteye();
  var_5 = lengthsquared(var_4);
  var_6 = anglestoforward(self getplayerangles());
  var_7 = vectordot(var_4, var_6);

  if(var_7 < 0 || var_7 * var_7 < var_5 * var_2 * var_2)
    return 0;

  if(var_3 > var_2) {
    var_4 = (var_6[0] * length2d(var_4), var_6[1] * length2d(var_4), var_4[2]);
    var_5 = lengthsquared(var_4);
    var_7 = vectordot(var_4, var_6);

    if(var_7 < 0 || var_7 * var_7 < var_5 * (var_3 * var_3))
      return 0;
  }

  return 1;
}

bot_oldschool_pickup_trace_passed(var_0) {
  if(sighttracepassed(self geteye(), var_0.origin + (0, 0, 30), 1, self, var_0.pickup, 0))
    return 1;

  return sighttracepassed(self geteye(), var_0.origin, 1, self, var_0.pickup, 0);
}

oldschool_attempt_camp_pickup() {
  if(randomfloat(1.0) < 0.5)
    return 0;

  if(maps\mp\bots\_bots_strategy::bot_has_tactical_goal("oldschool_pickup"))
    return 0;

  var_0 = [];
  var_1 = gettime();

  foreach(var_3 in self.pickup_array) {
    if(bot_oldschool_pickup_is_recharging(var_1, var_3)) {
      continue;
    }
    if(!bot_oldschool_bot_remembers_pickup(var_1, var_3)) {
      continue;
    }
    var_0[var_0.size] = var_3;
  }

  if(var_0.size == 0)
    return 0;

  var_5 = common_scripts\utility::get_array_of_closest(self.origin, var_0);
  var_6 = var_5[0];

  if(maps\mp\bots\_bots_personality::find_ambush_node(var_6.origin, 512))
    return 1;

  return 0;
}