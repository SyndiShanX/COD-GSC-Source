/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\mp\bots\gametype_dd.gsc
*********************************************/

main() {
  setup_callbacks();
  setup_bot_dd();
}

setup_callbacks() {
  level.bot_funcs["crate_can_use"] = ::crate_can_use;
  level.bot_funcs["gametype_think"] = ::bot_dd_think;
}

crate_can_use(var_0) {
  if(isagent(self) && !isDefined(var_0.boxtype)) {
    return 0;
  }

  if(isDefined(var_0.cratetype) && !scripts\mp\bots\_bots_killstreaks::bot_is_killstreak_supported(var_0.cratetype)) {
    return 0;
  }

  return func_9C96();
}

monitor_zone_control() {
  self notify("monitor_zone_control");
  self endon("monitor_zone_control");
  self endon("death");
  level endon("game_ended");
  for(;;) {
    wait(1);
    var_0 = getzonenearest(self.curorigin);
    if(isDefined(var_0)) {
      if(self.bombplanted) {
        var_1 = scripts\engine\utility::get_enemy_team(self.ownerteam);
      } else {
        var_1 = self.ownerteam;
      }

      if(var_1 != "neutral") {
        botzonesetteam(var_0, var_1);
      }
    }
  }
}

iw7_ship_hack_add_bombzone_node(var_0, var_1) {
  var_2 = spawnStruct();
  var_2.origin = var_1;
  var_2.angles = (0, randomint(360), 0);
  level.bombzones[var_0].bottargets[level.bombzones[var_0].bottargets.size] = var_2;
}

bot_fixup_bombzone_issues() {
  if(level.mapname == "mp_metropolis") {
    if(scripts\mp\utility::inovertime() && level.bombzones[0].bottargets.size == 0) {
      var_0 = (-505, -361, 68);
      iw7_ship_hack_add_bombzone_node(0, var_0);
      var_0 = (-582, -311, 68);
      iw7_ship_hack_add_bombzone_node(0, var_0);
      var_0 = (-583, -387, 68);
      iw7_ship_hack_add_bombzone_node(0, var_0);
      var_0 = (-583, -387, 68);
      iw7_ship_hack_add_bombzone_node(0, var_0);
      var_0 = (-497, -326, 68);
      iw7_ship_hack_add_bombzone_node(0, var_0);
    }
  }
}

setup_bot_dd() {
  scripts\mp\bots\_bots_util::bot_waittill_bots_enabled();
  scripts\mp\bots\_bots_strategy::bot_setup_bombzone_bottargets();
  bot_fixup_bombzone_issues();
  foreach(var_1 in level.bombzones) {
    foreach(var_3 in var_1.bottargets) {
      var_4 = scripts\engine\utility::array_randomize(var_1.bottargets);
      var_1.bottarget = var_4[0];
      break;
    }
  }

  scripts\mp\bots\_bots_util::bot_cache_entrances_to_bombzones();
  foreach(var_1 in level.bombzones) {
    var_1 thread monitor_zone_control();
  }

  level.bot_gametype_precaching_done = 1;
}

getovertimebombzone() {
  return level.bombzones[0];
}

isattacker() {
  if(!scripts\mp\utility::inovertime()) {
    if(self.team == game["attackers"]) {
      return 1;
    }

    return 0;
  }

  var_0 = getovertimebombzone();
  if(var_0.ownerteam == "neutral") {
    return 1;
  }

  if(var_0.ownerteam == self.team) {
    return 0;
  }

  return 1;
}

isdefender() {
  if(!scripts\mp\utility::inovertime()) {
    if(self.team == game["defenders"]) {
      return 1;
    }

    return 0;
  }

  var_0 = getovertimebombzone();
  if(var_0.ownerteam == "neutral") {
    return 0;
  }

  if(var_0.ownerteam == self.team) {
    return 1;
  }

  return 0;
}

bot_dd_think() {
  self notify("bot_dem_think");
  self endon("bot_dem_think");
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  while(!isDefined(level.bot_gametype_precaching_done)) {
    wait(0.05);
  }

  init_bot_game_demolition();
  self botsetflag("separation", 0);
  self botsetflag("grenade_objectives", 1);
  self botsetflag("use_obj_path_style", 1);
  self.var_9BB6 = 0;
  self.var_9C6A = 0;
  self.current_bombzone = undefined;
  if(!isDefined(level.var_BF3F)) {
    level.var_BF3F = gettime() - 100;
  }

  for(;;) {
    wait(0.05);
    if(gettime() >= level.var_BF3F) {
      func_12DC2();
      level.var_BF3F = gettime() + 100;
    }

    if(self.health <= 0) {
      continue;
    }

    if(scripts\mp\utility::inovertime() && !isDefined(self.current_bombzone)) {
      self.current_bombzone = getovertimebombzone();
    }

    if(isattacker()) {
      if(self.var_9C6A) {
        plant_set_stage();
      } else {
        if(!isDefined(self.current_bombzone)) {
          self.current_bombzone = func_6C7A("attackers");
        }

        if(isDefined(self.current_bombzone)) {
          if(func_9B7E(self.current_bombzone) && !func_9C96()) {
            scripts\mp\bots\_bots_strategy::bot_protect_point(self.current_bombzone.bottarget.origin, 600);
          } else if(!func_9B7E(self.current_bombzone) && !func_9B84()) {
            var_0["entrance_points_index"] = "zone" + self.current_bombzone.label;
            scripts\mp\bots\_bots_strategy::bot_capture_point(self.current_bombzone.bottarget.origin, 350, var_0);
          }
        }
      }

      continue;
    }

    if(self.var_9BB6) {
      if(!isDefined(level.ddbombmodel[self.current_bombzone.label])) {
        self.var_9BB6 = 0;
      }
    }

    if(self.var_9BB6) {
      func_50A6();
      continue;
    }

    if(!isDefined(self.current_bombzone)) {
      self.current_bombzone = func_6C7A("defenders");
    }

    if(isDefined(self.current_bombzone)) {
      if(func_9B7E(self.current_bombzone) && !func_9B84()) {
        var_0["entrance_points_index"] = "zone" + self.current_bombzone.label;
        scripts\mp\bots\_bots_strategy::bot_capture_point(self.current_bombzone.bottarget.origin, 350, var_0);
        continue;
      }

      if(!func_9B7E(self.current_bombzone) && !func_9C96()) {
        scripts\mp\bots\_bots_strategy::bot_protect_point(self.current_bombzone.bottarget.origin, 600);
      }
    }
  }
}

plant_set_stage() {
  func_8466(1);
}

func_50A6() {
  func_8466(0);
}

func_8466(var_0) {
  scripts\mp\bots\_bots_strategy::bot_defend_stop();
  if(var_0) {
    self botsetscriptgoal(self.current_bombzone.bottarget.origin, 20, "critical", self.current_bombzone.bottarget.angles[1]);
  } else {
    var_1 = level.ddbombmodel[self.current_bombzone.label].origin;
    self botsetscriptgoal(var_1, 20, "critical");
  }

  var_2 = scripts\mp\bots\_bots_util::bot_waittill_goal_or_fail(undefined, "dem_bomb_exploded", "no_longer_bomb_defuser");
  if(var_2 == "goal") {
    self botpressbutton("use", level.defusetime + 2);
    func_1381B(level.defusetime + 2, var_0);
    if(var_0) {
      self.var_9C6A = 0;
      return;
    }

    self.var_9BB6 = 0;
  }
}

func_1381B(var_0, var_1) {
  var_2 = gettime();
  var_3 = var_2 + var_0 * 1000;
  wait(0.05);
  while(self useButtonPressed() && gettime() < var_3 && isDefined(self.current_bombzone) && var_1 != func_9B7E(self.current_bombzone)) {
    wait(0.05);
  }
}

func_9C96() {
  return scripts\mp\bots\_bots_util::bot_is_protecting();
}

func_9B84() {
  return scripts\mp\bots\_bots_util::bot_is_capturing();
}

func_787A(var_0, var_1) {
  var_2 = [];
  foreach(var_4 in level.participants) {
    if(var_1 == "attackers" && !var_4 isattacker()) {
      continue;
    }

    if(var_1 == "defenders" && !var_4 isdefender()) {
      continue;
    }

    if(isalive(var_4) && scripts\mp\utility::isteamparticipant(var_4) && isDefined(var_4.current_bombzone) && var_4.current_bombzone == var_0) {
      var_2[var_2.size] = var_4;
    }
  }

  return var_2;
}

func_7877(var_0) {
  var_1 = func_787A(var_0, "defenders");
  foreach(var_3 in var_1) {
    if(var_3.var_9BB6) {
      return var_3;
    }
  }

  return undefined;
}

func_7878(var_0) {
  var_1 = func_787A(var_0, "attackers");
  foreach(var_3 in var_1) {
    if(var_3.var_9C6A) {
      return var_3;
    }
  }

  return undefined;
}

func_6C7A(var_0) {
  var_1 = [];
  foreach(var_3 in level.bombzones) {
    if(!scripts\engine\utility::istrue(var_3.bombexploded)) {
      var_4 = 0;
      if(var_0 == "defenders") {
        var_4 = var_3.bots_defending_wanted > func_787A(var_3, "defenders").size;
      } else if(var_0 == "attackers") {
        var_4 = var_3.bots_attacking_wanted > func_787A(var_3, "attackers").size;
      }

      if(var_4) {
        var_1[var_1.size] = var_3;
      }
    }
  }

  var_6 = undefined;
  if(var_1.size > 0) {
    var_7 = 999999999;
    foreach(var_3 in var_1) {
      var_9 = distancesquared(var_3.bottarget.origin, self.origin);
      if(var_9 < var_7) {
        var_6 = var_3;
        var_7 = var_9;
      }
    }
  }

  return var_6;
}

func_12DC2() {
  var_0 = [];
  foreach(var_2 in level.bombzones) {
    if(!scripts\engine\utility::istrue(var_2.bombexploded)) {
      var_0[var_0.size] = var_2;
    }
  }

  if(level.var_D88D == 2 && var_0.size == 1) {
    foreach(var_5 in level.participants) {
      if(scripts\mp\utility::isteamparticipant(var_5) && isDefined(var_5.current_bombzone) && var_5.current_bombzone != var_0[0]) {
        var_5.current_bombzone = undefined;
        var_5 scripts\mp\bots\_bots_strategy::bot_defend_stop();
        var_5 notify("dem_bomb_exploded");
        var_5.var_9BB6 = 0;
        var_5.var_9C6A = 0;
      }
    }

    level.var_D88D = 1;
  }

  func_12DAD(var_0);
  func_12DAE(var_0);
}

func_12DAD(var_0) {
  if(gettime() > level.var_BF62) {
    level.var_4BD6 = 1 - level.var_4BD6;
    level.var_BF62 = gettime() + 90000;
  }

  var_1 = 0;
  foreach(var_3 in level.participants) {
    if(scripts\mp\utility::isaiteamparticipant(var_3) && isalive(var_3) && var_3 isattacker()) {
      var_1++;
    }
  }

  if(var_0.size == 2) {
    if(var_1 >= 2) {
      var_0[1 - level.var_4BD6].bots_attacking_wanted = 1;
    } else {
      var_0[1 - level.var_4BD6].bots_attacking_wanted = 0;
    }

    var_0[level.var_4BD6].bots_attacking_wanted = var_1 - var_0[1 - level.var_4BD6].bots_attacking_wanted;
  } else if(var_0.size == 1) {
    var_0[0].bots_attacking_wanted = var_1;
  }

  foreach(var_6 in var_0) {
    var_7 = func_787A(var_6, "attackers");
    if(var_7.size > var_6.bots_attacking_wanted) {
      var_7 = scripts\engine\utility::array_randomize(var_7);
      foreach(var_9 in var_7) {
        if(!var_9.var_9C6A) {
          var_9.current_bombzone = undefined;
          var_9 scripts\mp\bots\_bots_strategy::bot_defend_stop();
          break;
        }
      }
    }
  }

  foreach(var_6 in var_0) {
    if(!func_9B7E(var_6) && !isDefined(func_7878(var_6))) {
      var_7 = func_787A(var_6, "attackers");
      if(var_7.size > 0) {
        var_13 = scripts\engine\utility::get_array_of_closest(var_6.bottarget.origin, var_7);
        var_13[0].var_9C6A = 1;
        var_13[0] scripts\mp\bots\_bots_strategy::bot_defend_stop();
      }
    }
  }
}

func_12DAE(var_0) {
  var_1 = 0;
  foreach(var_3 in level.participants) {
    if(scripts\mp\utility::isaiteamparticipant(var_3) && isalive(var_3) && var_3 isdefender()) {
      var_1++;
    }
  }

  if(var_0.size == 2) {
    var_0[0].bots_defending_wanted = int(var_1 / 2);
    var_0[1].bots_defending_wanted = int(var_1 / 2);
    var_0[level.var_BB52].bots_defending_wanted = var_0[level.var_BB52].bots_defending_wanted + var_1 % 2;
    for(var_5 = 0; var_5 < var_0.size; var_5++) {
      if(func_9B7E(var_0[var_5])) {
        var_0[var_5].bots_defending_wanted++;
        var_0[1 - var_5].bots_defending_wanted--;
      }
    }
  } else if(var_0.size == 1) {
    var_0[0].bots_defending_wanted = var_1;
  }

  foreach(var_7 in var_0) {
    var_8 = func_787A(var_7, "defenders");
    if(var_8.size > var_7.bots_defending_wanted) {
      var_8 = scripts\engine\utility::array_randomize(var_8);
      foreach(var_10 in var_8) {
        if(!var_10.var_9BB6) {
          var_10.current_bombzone = undefined;
          var_10 scripts\mp\bots\_bots_strategy::bot_defend_stop();
          break;
        }
      }
    }
  }

  foreach(var_7 in var_0) {
    if(func_9B7E(var_7)) {
      var_14 = func_7877(var_7);
      if(!isDefined(var_14) || gettime() > level.var_BF6A) {
        var_8 = func_787A(var_7, "defenders");
        if(var_8.size > 0) {
          var_15 = scripts\engine\utility::get_array_of_closest(var_7.bottarget.origin, var_8);
          if(!isDefined(var_14) || var_15[0] != var_14) {
            var_15[0].var_9BB6 = 1;
            var_15[0] scripts\mp\bots\_bots_strategy::bot_defend_stop();
            if(isDefined(var_14)) {
              var_14.var_9BB6 = 0;
              var_14 notify("no_longer_bomb_defuser");
            }
          }
        }

        level.var_BF6A = gettime() + 2500;
      }
    }
  }
}

func_9B7E(var_0) {
  return isDefined(var_0.bombplanted) && var_0.bombplanted == 1;
}

init_bot_game_demolition() {
  if(isDefined(level.bots_gametype_initialized) && level.bots_gametype_initialized) {
    return;
  }

  level.bots_gametype_initialized = 1;
  level.var_BB52 = randomint(2);
  level.var_D88D = 2;
  level.var_4BD6 = randomint(2);
  level.var_BF62 = gettime() + 90000;
  level.var_BF6A = 0;
}