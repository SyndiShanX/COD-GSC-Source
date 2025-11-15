/*******************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\mp\bots\gametype_dd.gsc
*******************************************/

main() {
  setup_callbacks();
  setup_bot_dd();
}

setup_callbacks() {
  level.bot_funcs["crate_can_use"] = ::crate_can_use;
  level.bot_funcs["gametype_think"] = ::bot_dd_think;
}

crate_can_use(param_00) {
  if(isagent(self) && !isDefined(param_00.boxtype)) {
    return 0;
  }

  if(isDefined(param_00.cratetype) && !scripts\mp\bots\_bots_killstreaks::bot_is_killstreak_supported(param_00.cratetype)) {
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
    var_00 = getzonenearest(self.curorigin);
    if(isDefined(var_00)) {
      if(self.bombplanted) {
        var_01 = scripts\engine\utility::get_enemy_team(self.ownerteam);
      } else {
        var_01 = self.ownerteam;
      }

      if(var_01 != "neutral") {
        botzonesetteam(var_00, var_01);
      }
    }
  }
}

iw7_ship_hack_add_bombzone_node(param_00, param_01) {
  var_02 = spawnStruct();
  var_02.origin = param_01;
  var_02.angles = (0, randomint(360), 0);
  level.bombzones[param_00].bottargets[level.bombzones[param_00].bottargets.size] = var_02;
}

bot_fixup_bombzone_issues() {
  if(level.mapname == "mp_metropolis") {
    if(scripts\mp\utility::inovertime() && level.bombzones[0].bottargets.size == 0) {
      var_00 = (-505, -361, 68);
      iw7_ship_hack_add_bombzone_node(0, var_00);
      var_00 = (-582, -311, 68);
      iw7_ship_hack_add_bombzone_node(0, var_00);
      var_00 = (-583, -387, 68);
      iw7_ship_hack_add_bombzone_node(0, var_00);
      var_00 = (-583, -387, 68);
      iw7_ship_hack_add_bombzone_node(0, var_00);
      var_00 = (-497, -326, 68);
      iw7_ship_hack_add_bombzone_node(0, var_00);
    }
  }
}

setup_bot_dd() {
  scripts\mp\bots\_bots_util::bot_waittill_bots_enabled();
  scripts\mp\bots\_bots_strategy::bot_setup_bombzone_bottargets();
  bot_fixup_bombzone_issues();
  foreach(var_01 in level.bombzones) {
    foreach(var_03 in var_01.bottargets) {
      var_04 = scripts\engine\utility::array_randomize(var_01.bottargets);
      var_01.bottarget = var_04[0];
      break;
    }
  }

  scripts\mp\bots\_bots_util::bot_cache_entrances_to_bombzones();
  foreach(var_01 in level.bombzones) {
    var_01 thread monitor_zone_control();
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

  var_00 = getovertimebombzone();
  if(var_00.ownerteam == "neutral") {
    return 1;
  }

  if(var_00.ownerteam == self.team) {
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

  var_00 = getovertimebombzone();
  if(var_00.ownerteam == "neutral") {
    return 0;
  }

  if(var_00.ownerteam == self.team) {
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
            var_00["entrance_points_index"] = "zone" + self.current_bombzone.label;
            scripts\mp\bots\_bots_strategy::bot_capture_point(self.current_bombzone.bottarget.origin, 350, var_00);
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
        var_00["entrance_points_index"] = "zone" + self.current_bombzone.label;
        scripts\mp\bots\_bots_strategy::bot_capture_point(self.current_bombzone.bottarget.origin, 350, var_00);
        continue;
      }

      if(!func_9B7E(self.current_bombzone) && !func_9C96()) {
        scripts\mp\bots\_bots_strategy::bot_protect_point(self.current_bombzone.bottarget.origin, 600);
      }
    }
  }
}

plant_set_stage() {
  _meth_8466(1);
}

func_50A6() {
  _meth_8466(0);
}

_meth_8466(param_00) {
  scripts\mp\bots\_bots_strategy::bot_defend_stop();
  if(param_00) {
    self botsetscriptgoal(self.current_bombzone.bottarget.origin, 20, "critical", self.current_bombzone.bottarget.angles[1]);
  } else {
    var_01 = level.ddbombmodel[self.current_bombzone.label].origin;
    self botsetscriptgoal(var_01, 20, "critical");
  }

  var_02 = scripts\mp\bots\_bots_util::bot_waittill_goal_or_fail(undefined, "dem_bomb_exploded", "no_longer_bomb_defuser");
  if(var_02 == "goal") {
    self botpressbutton("use", level.defusetime + 2);
    func_1381B(level.defusetime + 2, param_00);
    if(param_00) {
      self.var_9C6A = 0;
      return;
    }

    self.var_9BB6 = 0;
  }
}

func_1381B(param_00, param_01) {
  var_02 = gettime();
  var_03 = var_02 + param_00 * 1000;
  wait(0.05);
  while(self usebuttonpressed() && gettime() < var_03 && isDefined(self.current_bombzone) && param_01 != func_9B7E(self.current_bombzone)) {
    wait(0.05);
  }
}

func_9C96() {
  return scripts\mp\bots\_bots_util::bot_is_protecting();
}

func_9B84() {
  return scripts\mp\bots\_bots_util::bot_is_capturing();
}

func_787A(param_00, param_01) {
  var_02 = [];
  foreach(var_04 in level.participants) {
    if(param_01 == "attackers" && !var_04 isattacker()) {
      continue;
    }

    if(param_01 == "defenders" && !var_04 isdefender()) {
      continue;
    }

    if(isalive(var_04) && scripts\mp\utility::isteamparticipant(var_04) && isDefined(var_04.current_bombzone) && var_04.current_bombzone == param_00) {
      var_02[var_02.size] = var_04;
    }
  }

  return var_02;
}

func_7877(param_00) {
  var_01 = func_787A(param_00, "defenders");
  foreach(var_03 in var_01) {
    if(var_03.var_9BB6) {
      return var_03;
    }
  }

  return undefined;
}

func_7878(param_00) {
  var_01 = func_787A(param_00, "attackers");
  foreach(var_03 in var_01) {
    if(var_03.var_9C6A) {
      return var_03;
    }
  }

  return undefined;
}

func_6C7A(param_00) {
  var_01 = [];
  foreach(var_03 in level.bombzones) {
    if(!scripts\engine\utility::istrue(var_03.bombexploded)) {
      var_04 = 0;
      if(param_00 == "defenders") {
        var_04 = var_03.bots_defending_wanted > func_787A(var_03, "defenders").size;
      } else if(param_00 == "attackers") {
        var_04 = var_03.bots_attacking_wanted > func_787A(var_03, "attackers").size;
      }

      if(var_04) {
        var_01[var_01.size] = var_03;
      }
    }
  }

  var_06 = undefined;
  if(var_01.size > 0) {
    var_07 = 999999999;
    foreach(var_03 in var_01) {
      var_09 = distancesquared(var_03.bottarget.origin, self.origin);
      if(var_09 < var_07) {
        var_06 = var_03;
        var_07 = var_09;
      }
    }
  }

  return var_06;
}

func_12DC2() {
  var_00 = [];
  foreach(var_02 in level.bombzones) {
    if(!scripts\engine\utility::istrue(var_02.bombexploded)) {
      var_00[var_00.size] = var_02;
    }
  }

  if(level.var_D88D == 2 && var_00.size == 1) {
    foreach(var_05 in level.participants) {
      if(scripts\mp\utility::isteamparticipant(var_05) && isDefined(var_05.current_bombzone) && var_05.current_bombzone != var_00[0]) {
        var_05.current_bombzone = undefined;
        var_05 scripts\mp\bots\_bots_strategy::bot_defend_stop();
        var_05 notify("dem_bomb_exploded");
        var_05.var_9BB6 = 0;
        var_05.var_9C6A = 0;
      }
    }

    level.var_D88D = 1;
  }

  func_12DAD(var_00);
  func_12DAE(var_00);
}

func_12DAD(param_00) {
  if(gettime() > level.var_BF62) {
    level.var_4BD6 = 1 - level.var_4BD6;
    level.var_BF62 = gettime() + 90000;
  }

  var_01 = 0;
  foreach(var_03 in level.participants) {
    if(scripts\mp\utility::isaiteamparticipant(var_03) && isalive(var_03) && var_03 isattacker()) {
      var_01++;
    }
  }

  if(param_00.size == 2) {
    if(var_01 >= 2) {
      param_00[1 - level.var_4BD6].bots_attacking_wanted = 1;
    } else {
      param_00[1 - level.var_4BD6].bots_attacking_wanted = 0;
    }

    param_00[level.var_4BD6].bots_attacking_wanted = var_01 - param_00[1 - level.var_4BD6].bots_attacking_wanted;
  } else if(param_00.size == 1) {
    param_00[0].bots_attacking_wanted = var_01;
  }

  foreach(var_06 in param_00) {
    var_07 = func_787A(var_06, "attackers");
    if(var_07.size > var_06.bots_attacking_wanted) {
      var_07 = scripts\engine\utility::array_randomize(var_07);
      foreach(var_09 in var_07) {
        if(!var_09.var_9C6A) {
          var_09.current_bombzone = undefined;
          var_09 scripts\mp\bots\_bots_strategy::bot_defend_stop();
          break;
        }
      }
    }
  }

  foreach(var_06 in param_00) {
    if(!func_9B7E(var_06) && !isDefined(func_7878(var_06))) {
      var_07 = func_787A(var_06, "attackers");
      if(var_07.size > 0) {
        var_0D = scripts\engine\utility::get_array_of_closest(var_06.bottarget.origin, var_07);
        var_0D[0].var_9C6A = 1;
        var_0D[0] scripts\mp\bots\_bots_strategy::bot_defend_stop();
      }
    }
  }
}

func_12DAE(param_00) {
  var_01 = 0;
  foreach(var_03 in level.participants) {
    if(scripts\mp\utility::isaiteamparticipant(var_03) && isalive(var_03) && var_03 isdefender()) {
      var_01++;
    }
  }

  if(param_00.size == 2) {
    param_00[0].bots_defending_wanted = int(var_01 / 2);
    param_00[1].bots_defending_wanted = int(var_01 / 2);
    param_00[level.var_BB52].bots_defending_wanted = param_00[level.var_BB52].bots_defending_wanted + var_01 % 2;
    for(var_05 = 0; var_05 < param_00.size; var_05++) {
      if(func_9B7E(param_00[var_05])) {
        param_00[var_05].bots_defending_wanted++;
        param_00[1 - var_05].bots_defending_wanted--;
      }
    }
  } else if(param_00.size == 1) {
    param_00[0].bots_defending_wanted = var_01;
  }

  foreach(var_07 in param_00) {
    var_08 = func_787A(var_07, "defenders");
    if(var_08.size > var_07.bots_defending_wanted) {
      var_08 = scripts\engine\utility::array_randomize(var_08);
      foreach(var_0A in var_08) {
        if(!var_0A.var_9BB6) {
          var_0A.current_bombzone = undefined;
          var_0A scripts\mp\bots\_bots_strategy::bot_defend_stop();
          break;
        }
      }
    }
  }

  foreach(var_07 in param_00) {
    if(func_9B7E(var_07)) {
      var_0E = func_7877(var_07);
      if(!isDefined(var_0E) || gettime() > level.var_BF6A) {
        var_08 = func_787A(var_07, "defenders");
        if(var_08.size > 0) {
          var_0F = scripts\engine\utility::get_array_of_closest(var_07.bottarget.origin, var_08);
          if(!isDefined(var_0E) || var_0F[0] != var_0E) {
            var_0F[0].var_9BB6 = 1;
            var_0F[0] scripts\mp\bots\_bots_strategy::bot_defend_stop();
            if(isDefined(var_0E)) {
              var_0E.var_9BB6 = 0;
              var_0E notify("no_longer_bomb_defuser");
            }
          }
        }

        level.var_BF6A = gettime() + 2500;
      }
    }
  }
}

func_9B7E(param_00) {
  return isDefined(param_00.bombplanted) && param_00.bombplanted == 1;
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