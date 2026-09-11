/***************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\bots\bots_gametype_to_dd.gsc
***************************************************/

function main() {
  setup_callbacks();
  setup_bot_dd();
}

function setup_callbacks() {
  level.bot_funcs["crate_can_use"] = &crate_can_use;
  level.bot_funcs["gametype_think"] = &bot_demolition_think;
}

function crate_can_use(var_0) {
  if(isagent(self) && !isDefined(var_0.boxtype)) {
    return 0;
  }

  if(isDefined(var_0.cratetype) && !scripts\mp\bots\bots_killstreaks::bot_is_killstreak_supported(var_0.cratetype)) {
    return 0;
  }

  return is_protecting_zone();
}

function iw7_ship_hack_add_bombzone_node(var_0, var_1) {
  if(var_0 == 0) {
    var_0 = "_a";
  } else {
    var_0 = "_b";
  }

  var_2 = spawnStruct();
  var_2.origin = var_1;
  var_2.angles = (0, randomint(360), 0);
  level.objectives[var_0].bottargets[level.objectives[var_0].bottargets.size] = var_2;
}

function bot_fixup_bombzone_issues() {
  if(level.mapname == "mp_metropolis") {
    if(scripts\mp\utility\game::inovertime() && level.objectives["_a"].bottargets.size == 0) {
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
      return;
    }

    return;
  }
}

function setup_bot_dd() {
  scripts\mp\bots\bots_util::bot_waittill_bots_enabled();
  var_0 = scripts\mp\bots\bots_gametype_common::debug_consoles(["_a", "_b"]);

  if(var_0) {
    foreach(var_2 in level.objectives) {
      var_2 thread scripts\mp\bots\bots_gametype_common::monitor_bombzone_control();
    }

    level.bot_gametype_precaching_done = 1;
    return;
  }
}

function getovertimebombzone() {
  return level.objectives["_a"];
}

function isattacker() {
  if(!scripts\mp\utility\game::inovertime()) {
    if(self.team == game["attackers"]) {
      return true;
    }

    return false;
  }

  var_0 = getovertimebombzone();

  if(var_0.ownerteam == "neutral") {
    return true;
  }

  if(var_0.ownerteam == self.team) {
    return false;
  }

  return true;
}

function isdefender() {
  if(!scripts\mp\utility\game::inovertime()) {
    if(self.team == game["defenders"]) {
      return true;
    }

    return false;
  }

  var_0 = getovertimebombzone();

  if(var_0.ownerteam == "neutral") {
    return false;
  }

  if(var_0.ownerteam == self.team) {
    return true;
  }

  return false;
}

function bot_demolition_think() {
  self notify("bot_dem_think");
  self endon("bot_dem_think");
  self endon("death_or_disconnect");
  level endon("game_ended");

  while(!isDefined(level.bot_gametype_precaching_done)) {
    wait 0.05;
  }

  init_bot_game_demolition();
  self botsetflag("separation", 0);
  self botsetflag("grenade_objectives", 1);
  self botsetflag("use_obj_path_style", 1);
  self.is_defusing = 0;
  self.is_planting = 0;
  self.current_bombzone = undefined;

  if(!isDefined(level.next_game_update_time)) {
    level.next_game_update_time = gettime() - 100;
  }

  for(;;) {
    wait 0.05;

    if(gettime() >= level.next_game_update_time) {
      update_game_demolition();
      level.next_game_update_time = gettime() + 100;
    }

    if(self.health <= 0) {
      continue;
    }

    if(scripts\mp\utility\game::inovertime() && !isDefined(self.current_bombzone)) {
      self.current_bombzone = getovertimebombzone();
    }

    if(isattacker()) {
      if(self.is_planting) {
        plant_bomb();
      } else {
        if(!isDefined(self.current_bombzone)) {
          self.current_bombzone = find_best_bombzone("attackers");
        }

        if(isDefined(self.current_bombzone)) {
          if(is_bomb_planted_on(self.current_bombzone) && !is_protecting_zone()) {
            scripts\mp\bots\bots_strategy::bot_protect_point(self.current_bombzone.bottarget.origin, 600);
          } else if(!is_bomb_planted_on(self.current_bombzone) && !is_capturing_zone()) {
            GscBinSkip1(0x45, "entrance_points_index", "zone" + self.current_bombzone.label);
          }
        }
      }

      continue;
    }

    if(self.is_defusing) {
      if(!isDefined(level.ddbombmodel[self.current_bombzone.label])) {
        self.is_defusing = 0;
      }
    }

    if(self.is_defusing) {
      defuse_bomb();
      continue;
    }

    if(!isDefined(self.current_bombzone)) {
      self.current_bombzone = find_best_bombzone("defenders");
    }

    if(isDefined(self.current_bombzone)) {
      if(is_bomb_planted_on(self.current_bombzone) && !is_capturing_zone()) {
        GscBinSkip1(0x45, "entrance_points_index", "zone" + self.current_bombzone.label);
      }

      if(!is_bomb_planted_on(self.current_bombzone) && !is_protecting_zone()) {
        scripts\mp\bots\bots_strategy::bot_protect_point(self.current_bombzone.bottarget.origin, 600);
      }
    }
  }
}

function plant_bomb() {
  goto_bomb_and_use(1);
}

function defuse_bomb() {
  goto_bomb_and_use(0);
}

function goto_bomb_and_use(var_0) {
  scripts\mp\bots\bots_strategy::bot_defend_stop();

  if(var_0) {
    self botsetscriptgoal(self.current_bombzone.bottarget.origin, 20, "critical", self.current_bombzone.bottarget.angles[1]);
  } else {
    var_1 = level.ddbombmodel[self.current_bombzone.label].origin;
    self botsetscriptgoal(var_1, 20, "critical");
  }

  var_2 = scripts\mp\bots\bots_util::bot_waittill_goal_or_fail(undefined, "dem_bomb_exploded", "no_longer_bomb_defuser");

  if(var_2 == "goal") {
    self botpressbutton("use", level.defusetime + 2);
    waittill_usebutton_released_or_time(level.defusetime + 2, var_0);

    if(var_0) {
      self.is_planting = 0;
      return;
    }

    self.is_defusing = 0;
    return;
  }
}

function waittill_usebutton_released_or_time(var_0, var_1) {
  var_2 = gettime();
  var_3 = var_2 + var_0 * 1000;
  wait 0.05;

  while(self useButtonPressed() && gettime() < var_3 && isDefined(self.current_bombzone) && var_1 != is_bomb_planted_on(self.current_bombzone)) {
    wait 0.05;
  }
}

function is_protecting_zone() {
  return scripts\mp\bots\bots_util::bot_is_protecting();
}

function is_capturing_zone() {
  return scripts\mp\bots\bots_util::bot_is_capturing();
}

function get_bots_using_zone(var_0, var_1) {
  var_2 = [];

  foreach(var_4 in level.participants) {
    if(var_1 == "attackers" && !isattacker(var_4)) {
      continue;
    }

    if(var_1 == "defenders" && !isdefender(var_4)) {
      continue;
    }

    if(isalive(var_4) && scripts\mp\utility\entity::isteamparticipant(var_4) && isDefined(var_4.current_bombzone) && var_4.current_bombzone == var_0) {
      var_2 = var_4;
    }
  }

  return var_2;
}

function get_bot_defusing_zone(var_0) {
  var_1 = get_bots_using_zone(var_0, "defenders");

  foreach(var_3 in var_1) {
    if(var_3.is_defusing) {
      return var_3;
    }
  }

  return undefined;
}

function get_bot_planting_zone(var_0) {
  var_1 = get_bots_using_zone(var_0, "attackers");

  foreach(var_3 in var_1) {
    if(var_3.is_planting) {
      return var_3;
    }
  }

  return undefined;
}

function find_best_bombzone(var_0) {
  var_1 = [];

  foreach(var_3 in level.objectives) {
    if(!istrue(var_3.bombexploded)) {
      var_4 = 0;

      if(var_0 == "defenders") {
        var_4 = var_3.bots_defending_wanted > get_bots_using_zone(var_3, "defenders").size;
      } else if(var_0 == "attackers") {
        var_4 = var_3.bots_attacking_wanted > get_bots_using_zone(var_3, "attackers").size;
      }

      if(var_4) {
        var_1 = var_3;
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

function update_game_demolition() {
  var_0 = [];

  foreach(var_2 in level.objectives) {
    if(!istrue(var_2.bombexploded)) {
      var_0 = var_2;
    }
  }

  if(level.prev_num_active_zones == 2 && var_0.size == 1) {
    foreach(var_5 in level.participants) {
      if(scripts\mp\utility\entity::isteamparticipant(var_5) && isDefined(var_5.current_bombzone) && var_5.current_bombzone != var_0[0]) {
        var_5.current_bombzone = undefined;
        var_5 scripts\mp\bots\bots_strategy::bot_defend_stop();
        var_5 notify("dem_bomb_exploded");
        var_5.is_defusing = 0;
        var_5.is_planting = 0;
      }
    }

    level.prev_num_active_zones = 1;
  }

  update_demolition_attackers(var_0);
  update_demolition_defenders(var_0);
}

function update_demolition_attackers(var_0) {
  if(gettime() > level.next_target_switch_time) {
    level.current_zone_target = 1 - level.current_zone_target;
    level.next_target_switch_time = gettime() + 90000;
  }

  var_1 = 0;

  foreach(var_3 in level.participants) {
    if(scripts\mp\utility\entity::isaiteamparticipant(var_3) && isalive(var_3) && isattacker(var_3)) {
      var_1++;
    }
  }

  if(var_0.size == 2) {
    if(var_1 >= 2) {
      var_0[1 - level.current_zone_target].bots_attacking_wanted = 1;
    } else {
      var_0[1 - level.current_zone_target].bots_attacking_wanted = 0;
    }

    var_0[level.current_zone_target].bots_attacking_wanted = var_1 - var_0[1 - level.current_zone_target].bots_attacking_wanted;
  } else if(var_0.size == 1) {
    var_0[0].bots_attacking_wanted = var_1;
  }

  foreach(var_6 in var_0) {
    var_7 = get_bots_using_zone(var_6, "attackers");

    if(var_7.size > var_6.bots_attacking_wanted) {
      var_7 = scripts\engine\utility::array_randomize(var_7);

      foreach(var_9 in var_7) {
        if(!var_9.is_planting) {
          var_9.current_bombzone = undefined;
          var_9 scripts\mp\bots\bots_strategy::bot_defend_stop();
          break;
        }
      }
    }
  }

  foreach(var_6 in var_0) {
    if(!is_bomb_planted_on(var_6) && !isDefined(get_bot_planting_zone(var_6))) {
      var_7 = get_bots_using_zone(var_6, "attackers");

      if(var_7.size > 0) {
        var_13 = scripts\engine\utility::get_array_of_closest(var_6.bottarget.origin, var_7);
        var_13[0].is_planting = 1;
        var_13[0] scripts\mp\bots\bots_strategy::bot_defend_stop();
      }
    }
  }
}

function update_demolition_defenders(var_0) {
  var_1 = 0;

  foreach(var_3 in level.participants) {
    if(scripts\mp\utility\entity::isaiteamparticipant(var_3) && isalive(var_3) && isdefender(var_3)) {
      var_1++;
    }
  }

  if(var_0.size == 2) {
    var_0[0].bots_defending_wanted = int(var_1 / 2);
    var_0[1].bots_defending_wanted = int(var_1 / 2);
    var_0[level.more_populated_bombzone].bots_defending_wanted += var_1 % 2;

    for(var_5 = 0; var_5 < var_0.size; var_5++) {
      if(is_bomb_planted_on(var_0[var_5])) {
        var_0[var_5].bots_defending_wanted++;
        var_0[1 - var_5].bots_defending_wanted--;
      }
    }
  } else if(var_0.size == 1) {
    var_0[0].bots_defending_wanted = var_1;
  }

  foreach(var_7 in var_0) {
    var_8 = get_bots_using_zone(var_7, "defenders");

    if(var_8.size > var_7.bots_defending_wanted) {
      var_8 = scripts\engine\utility::array_randomize(var_8);

      foreach(var_10 in var_8) {
        if(!var_10.is_defusing) {
          var_10.current_bombzone = undefined;
          var_10 scripts\mp\bots\bots_strategy::bot_defend_stop();
          break;
        }
      }
    }
  }

  foreach(var_7 in var_0) {
    if(is_bomb_planted_on(var_7)) {
      var_14 = get_bot_defusing_zone(var_7);

      if(!isDefined(var_14) || gettime() > level.next_time_switch_defusers) {
        var_8 = get_bots_using_zone(var_7, "defenders");

        if(var_8.size > 0) {
          var_15 = scripts\engine\utility::get_array_of_closest(var_7.bottarget.origin, var_8);

          if(!isDefined(var_14) || var_15[0] != var_14) {
            var_15[0].is_defusing = 1;
            var_15[0] scripts\mp\bots\bots_strategy::bot_defend_stop();

            if(isDefined(var_14)) {
              var_14.is_defusing = 0;
              var_14 notify("no_longer_bomb_defuser");
            }
          }
        }

        level.next_time_switch_defusers = gettime() + 2500;
      }
    }
  }
}

function is_bomb_planted_on(var_0) {
  return isDefined(var_0.bombplanted) && var_0.bombplanted == 1;
}

function init_bot_game_demolition() {
  if(isDefined(level.bots_gametype_initialized) && level.bots_gametype_initialized) {
    return;
  }

  level.bots_gametype_initialized = 1;
  level.more_populated_bombzone = randomint(2);
  level.prev_num_active_zones = 2;
  level.current_zone_target = randomint(2);
  level.next_target_switch_time = gettime() + 90000;
  level.next_time_switch_defusers = 0;
}