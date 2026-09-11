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

function crate_can_use(var0) {
  if(isagent(self) && !isDefined(var0.boxtype)) {
    return 0;
  }

  if(isDefined(var0.cratetype) && !scripts\mp\bots\bots_killstreaks::bot_is_killstreak_supported(var0.cratetype)) {
    return 0;
  }

  return is_protecting_zone();
}

function iw7_ship_hack_add_bombzone_node(var0, var1) {
  if(var0 == 0) {
    var0 = "_a";
  } else {
    var0 = "_b";
  }

  var2 = spawnStruct();
  var2.origin = var1;
  var2.angles = (0, randomint(360), 0);
  level.objectives[var0].bottargets[level.objectives[var0].bottargets.size] = var2;
}

function bot_fixup_bombzone_issues() {
  if(level.mapname == "mp_metropolis") {
    if(scripts\mp\utility\game::inovertime() && level.objectives["_a"].bottargets.size == 0) {
      var0 = (-505, -361, 68);
      iw7_ship_hack_add_bombzone_node(0, var0);
      var0 = (-582, -311, 68);
      iw7_ship_hack_add_bombzone_node(0, var0);
      var0 = (-583, -387, 68);
      iw7_ship_hack_add_bombzone_node(0, var0);
      var0 = (-583, -387, 68);
      iw7_ship_hack_add_bombzone_node(0, var0);
      var0 = (-497, -326, 68);
      iw7_ship_hack_add_bombzone_node(0, var0);
      return;
    }

    return;
  }
}

function setup_bot_dd() {
  scripts\mp\bots\bots_util::bot_waittill_bots_enabled();
  var0 = scripts\mp\bots\bots_gametype_common::debug_consoles(["_a", "_b"]);

  if(var0) {
    foreach(var2 in level.objectives) {
      var2 thread scripts\mp\bots\bots_gametype_common::monitor_bombzone_control();
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

  var0 = getovertimebombzone();

  if(var0.ownerteam == "neutral") {
    return true;
  }

  if(var0.ownerteam == self.team) {
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

  var0 = getovertimebombzone();

  if(var0.ownerteam == "neutral") {
    return false;
  }

  if(var0.ownerteam == self.team) {
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

function goto_bomb_and_use(var0) {
  scripts\mp\bots\bots_strategy::bot_defend_stop();

  if(var0) {
    self botsetscriptgoal(self.current_bombzone.bottarget.origin, 20, "critical", self.current_bombzone.bottarget.angles[1]);
  } else {
    var1 = level.ddbombmodel[self.current_bombzone.label].origin;
    self botsetscriptgoal(var1, 20, "critical");
  }

  var2 = scripts\mp\bots\bots_util::bot_waittill_goal_or_fail(undefined, "dem_bomb_exploded", "no_longer_bomb_defuser");

  if(var2 == "goal") {
    self botpressbutton("use", level.defusetime + 2);
    waittill_usebutton_released_or_time(level.defusetime + 2, var0);

    if(var0) {
      self.is_planting = 0;
      return;
    }

    self.is_defusing = 0;
    return;
  }
}

function waittill_usebutton_released_or_time(var0, var1) {
  var2 = gettime();
  var3 = var2 + var0 * 1000;
  wait 0.05;

  while(self useButtonPressed() && gettime() < var3 && isDefined(self.current_bombzone) && var1 != is_bomb_planted_on(self.current_bombzone)) {
    wait 0.05;
  }
}

function is_protecting_zone() {
  return scripts\mp\bots\bots_util::bot_is_protecting();
}

function is_capturing_zone() {
  return scripts\mp\bots\bots_util::bot_is_capturing();
}

function get_bots_using_zone(var0, var1) {
  var2 = [];

  foreach(var4 in level.participants) {
    if(var1 == "attackers" && !isattacker(var4)) {
      continue;
    }

    if(var1 == "defenders" && !isdefender(var4)) {
      continue;
    }

    if(isalive(var4) && scripts\mp\utility\entity::isteamparticipant(var4) && isDefined(var4.current_bombzone) && var4.current_bombzone == var0) {
      var2 = var4;
    }
  }

  return var2;
}

function get_bot_defusing_zone(var0) {
  var1 = get_bots_using_zone(var0, "defenders");

  foreach(var3 in var1) {
    if(var3.is_defusing) {
      return var3;
    }
  }

  return undefined;
}

function get_bot_planting_zone(var0) {
  var1 = get_bots_using_zone(var0, "attackers");

  foreach(var3 in var1) {
    if(var3.is_planting) {
      return var3;
    }
  }

  return undefined;
}

function find_best_bombzone(var0) {
  var1 = [];

  foreach(var3 in level.objectives) {
    if(!istrue(var3.bombexploded)) {
      var4 = 0;

      if(var0 == "defenders") {
        var4 = var3.bots_defending_wanted > get_bots_using_zone(var3, "defenders").size;
      } else if(var0 == "attackers") {
        var4 = var3.bots_attacking_wanted > get_bots_using_zone(var3, "attackers").size;
      }

      if(var4) {
        var1 = var3;
      }
    }
  }

  var6 = undefined;

  if(var1.size > 0) {
    var7 = 999999999;

    foreach(var3 in var1) {
      var9 = distancesquared(var3.bottarget.origin, self.origin);

      if(var9 < var7) {
        var6 = var3;
        var7 = var9;
      }
    }
  }

  return var6;
}

function update_game_demolition() {
  var0 = [];

  foreach(var2 in level.objectives) {
    if(!istrue(var2.bombexploded)) {
      var0 = var2;
    }
  }

  if(level.prev_num_active_zones == 2 && var0.size == 1) {
    foreach(var5 in level.participants) {
      if(scripts\mp\utility\entity::isteamparticipant(var5) && isDefined(var5.current_bombzone) && var5.current_bombzone != var0[0]) {
        var5.current_bombzone = undefined;
        var5 scripts\mp\bots\bots_strategy::bot_defend_stop();
        var5 notify("dem_bomb_exploded");
        var5.is_defusing = 0;
        var5.is_planting = 0;
      }
    }

    level.prev_num_active_zones = 1;
  }

  update_demolition_attackers(var0);
  update_demolition_defenders(var0);
}

function update_demolition_attackers(var0) {
  if(gettime() > level.next_target_switch_time) {
    level.current_zone_target = 1 - level.current_zone_target;
    level.next_target_switch_time = gettime() + 90000;
  }

  var1 = 0;

  foreach(var3 in level.participants) {
    if(scripts\mp\utility\entity::isaiteamparticipant(var3) && isalive(var3) && isattacker(var3)) {
      var1++;
    }
  }

  if(var0.size == 2) {
    if(var1 >= 2) {
      var0[1 - level.current_zone_target].bots_attacking_wanted = 1;
    } else {
      var0[1 - level.current_zone_target].bots_attacking_wanted = 0;
    }

    var0[level.current_zone_target].bots_attacking_wanted = var1 - var0[1 - level.current_zone_target].bots_attacking_wanted;
  } else if(var0.size == 1) {
    var0[0].bots_attacking_wanted = var1;
  }

  foreach(var6 in var0) {
    var7 = get_bots_using_zone(var6, "attackers");

    if(var7.size > var6.bots_attacking_wanted) {
      var7 = scripts\engine\utility::array_randomize(var7);

      foreach(var9 in var7) {
        if(!var9.is_planting) {
          var9.current_bombzone = undefined;
          var9 scripts\mp\bots\bots_strategy::bot_defend_stop();
          break;
        }
      }
    }
  }

  foreach(var6 in var0) {
    if(!is_bomb_planted_on(var6) && !isDefined(get_bot_planting_zone(var6))) {
      var7 = get_bots_using_zone(var6, "attackers");

      if(var7.size > 0) {
        var13 = scripts\engine\utility::get_array_of_closest(var6.bottarget.origin, var7);
        var13[0].is_planting = 1;
        var13[0] scripts\mp\bots\bots_strategy::bot_defend_stop();
      }
    }
  }
}

function update_demolition_defenders(var0) {
  var1 = 0;

  foreach(var3 in level.participants) {
    if(scripts\mp\utility\entity::isaiteamparticipant(var3) && isalive(var3) && isdefender(var3)) {
      var1++;
    }
  }

  if(var0.size == 2) {
    var0[0].bots_defending_wanted = int(var1 / 2);
    var0[1].bots_defending_wanted = int(var1 / 2);
    var0[level.more_populated_bombzone].bots_defending_wanted += var1 % 2;

    for(var5 = 0; var5 < var0.size; var5++) {
      if(is_bomb_planted_on(var0[var5])) {
        var0[var5].bots_defending_wanted++;
        var0[1 - var5].bots_defending_wanted--;
      }
    }
  } else if(var0.size == 1) {
    var0[0].bots_defending_wanted = var1;
  }

  foreach(var7 in var0) {
    var8 = get_bots_using_zone(var7, "defenders");

    if(var8.size > var7.bots_defending_wanted) {
      var8 = scripts\engine\utility::array_randomize(var8);

      foreach(var10 in var8) {
        if(!var10.is_defusing) {
          var10.current_bombzone = undefined;
          var10 scripts\mp\bots\bots_strategy::bot_defend_stop();
          break;
        }
      }
    }
  }

  foreach(var7 in var0) {
    if(is_bomb_planted_on(var7)) {
      var14 = get_bot_defusing_zone(var7);

      if(!isDefined(var14) || gettime() > level.next_time_switch_defusers) {
        var8 = get_bots_using_zone(var7, "defenders");

        if(var8.size > 0) {
          var15 = scripts\engine\utility::get_array_of_closest(var7.bottarget.origin, var8);

          if(!isDefined(var14) || var15[0] != var14) {
            var15[0].is_defusing = 1;
            var15[0] scripts\mp\bots\bots_strategy::bot_defend_stop();

            if(isDefined(var14)) {
              var14.is_defusing = 0;
              var14 notify("no_longer_bomb_defuser");
            }
          }
        }

        level.next_time_switch_defusers = gettime() + 2500;
      }
    }
  }
}

function is_bomb_planted_on(var0) {
  return isDefined(var0.bombplanted) && var0.bombplanted == 1;
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