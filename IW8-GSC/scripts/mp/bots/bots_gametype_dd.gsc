/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\bots\bots_gametype_dd.gsc
************************************************/

function main() {
  setup_callbacks();
  damage_data();
}

function setup_callbacks() {
  level.bot_funcs["gametype_think"] = &damage_empty_vehicles_infrontofme;
  level.bot_funcs["notify_enemy_bots_bomb_used"] = &notify_enemy_team_bomb_used;
}

function damage_data() {
  setup_bot_dd();
}

function setup_bot_dd() {
  damage_multiplier();
  scripts\mp\bots\bots_gametype_common::bot_setup_objective_bottargets();
  scripts\mp\bots\bots_util::bot_waittill_bots_enabled();
  var0 = scripts\mp\bots\bots_gametype_common::debug_consoles(["_a", "_b"]);

  if(var0) {
    foreach(var2 in level.objectives) {
      var2 thread scripts\mp\bots\bots_gametype_common::monitor_bombzone_control();
    }

    thread cypher_vo_hack_progress();
    level.bot_gametype_precaching_done = 1;
    return;
  }
}

function damage_empty_vehicles_infrontofme() {
  self notify("bot_dd_think");
  self endon("bot_dd_think");
  self endon("death_or_disconnect");
  level endon("game_ended");

  while(!isDefined(level.bot_gametype_precaching_done)) {
    wait 0.05;
  }

  self botsetflag("separation", 0);
  self botsetflag("grenade_objectives", 1);
  self.current_bombzone = undefined;
  self.defuser_bad_path_counter = 0;

  for(;;) {
    wait 0.05;

    if(isDefined(self.current_bombzone) && !current_puddle_count(self.current_bombzone)) {
      self.current_bombzone = undefined;
      cypher_vo_intro();
    }

    if(scripts\mp\utility\game::inovertime()) {
      var0 = level.objectives["_a"].ownerteam != self.team;
    } else {
      var0 = self.team == game["attackers"];
    }

    if(var0) {
      deafen_ai("attack");

      if(!isDefined(self.current_bombzone)) {
        continue;
      }

      debug_calculatecashonground();
      custom_helicopter_firendly_dmg_func();

      if(self.role == "sweep_zone") {
        if(!scripts\mp\bots\bots_util::bot_is_defending_point(self.current_bombzone.curorigin)) {
          GscBinSkip1(0x45, "min_goal_time", 2);
        }
      } else if(self.role == "defend_zone") {
        if(!scripts\mp\bots\bots_util::bot_is_defending_point(level.ddbombmodel[self.current_bombzone.objectivekey].origin)) {
          GscBinSkip1(0x45, "score_flags", "strongly_avoid_center");
        }
      } else if(self.role == "investigate_someone_using_bomb") {
        trial_target_think();
      } else if(self.role == "atk_bomber") {
        plant_bomb();
      }

      continue;
    }

    deafen_ai("defend");

    if(!isDefined(self.current_bombzone)) {
      continue;
    }

    custom_putongroundfunc();

    if(self.role == "defend_zone") {
      if(!scripts\mp\bots\bots_util::bot_is_defending_point(self.current_bombzone.curorigin)) {
        GscBinSkip1(0x45, "score_flags", "strict_los");
      }

      continue;
    }

    if(self.role == "investigate_someone_using_bomb") {
      trial_target_think();
      continue;
    }

    if(self.role == "defuser") {
      defuse_bomb();
    }
  }
}

function notify_enemy_team_bomb_used(var0) {
  var1 = scripts\mp\bots\bots_gametype_common::find_closest_bombzone_to_player(self);
  var2 = scripts\mp\bots\bots_gametype_common::prematchinitx1blueprintloadouts(var0);

  foreach(var4 in var2) {
    if(isDefined(var4.current_bombzone) && var1 == var4.current_bombzone) {
      damage_area(var4, "investigate_someone_using_bomb");
    }
  }
}

function plant_bomb() {
  self endon("change_role");
  var0 = scripts\mp\bots\bots_gametype_common::process_should_do_pain(self.current_bombzone, 0);
  self botsetscriptgoal(var0.origin, 0, "critical");
  var1 = scripts\mp\bots\bots_util::bot_waittill_goal_or_fail(undefined, "change_role");

  if(var1 == "goal") {
    var2 = scripts\mp\gamelogic::gettimeremaining();
    var3 = var2 - level.planttime * 2 * 1000;
    var4 = gettime() + var3;

    if(var3 > 0) {
      scripts\mp\bots\bots_util::bot_waittill_out_of_combat_or_time(var3);
    }

    var5 = var4 > 0 && gettime() >= var4;
    var6 = scripts\mp\bots\bots_gametype_common::current_respawn_point_override(level.planttime + 2, "bomb_planted", var5);
    self botclearscriptgoal();

    if(var6) {
      cypher_vo_intro();
      return;
    }

    return;
  }
}

function defuse_bomb() {
  self endon("change_role");
  self botsetpathingstyle("scripted");
  var0 = scripts\mp\bots\bots_gametype_common::process_players_inside_subway_car(self.current_bombzone).origin;
  self botsetscriptgoal(var0, 20, "critical");
  var1 = scripts\mp\bots\bots_util::bot_waittill_goal_or_fail(undefined, "change_role");

  if(var1 == "bad_path") {
    self.defuser_bad_path_counter++;

    if(self.defuser_bad_path_counter >= 4) {
      for(;;) {
        var2 = getnodesinradiussorted(var0, 50, 0);
        var3 = self.defuser_bad_path_counter - 4;

        if(var2.size <= var3) {
          var4 = botgetclosestnavigablepoint(var0, 50, self);

          if(isDefined(var4)) {
            self botsetscriptgoal(var4, 20, "critical");
          } else {
            break;
          }
        } else {
          self botsetscriptgoal(var1[var2].origin, 20, "critical");
        }

        var0 = scripts\mp\bots\bots_util::bot_waittill_goal_or_fail(undefined, "change_role");

        if(var0 == "bad_path") {
          self.defuser_bad_path_counter++;
          continue;
        }

        break;
      }
    }
  }

  if(var0 == "goal") {
    var5 = gettime() - self.current_bombzone.startbombtime;
    var6 = level.bombtimer * 1000 - var5;
    var7 = var6 - level.defusetime * 2 * 1000;
    var8 = gettime() + var7;

    if(var7 > 0) {
      scripts\mp\bots\bots_util::bot_waittill_out_of_combat_or_time(var7);
    }

    var9 = var8 > 0 && gettime() >= var8;
    var10 = scripts\mp\bots\bots_gametype_common::current_respawn_point_override(level.defusetime + 2, "bomb_defused", var9);

    if(!var10 && self.defuser_bad_path_counter >= 4) {
      self.defuser_bad_path_counter++;
    }

    self botclearscriptgoal();

    if(var10) {
      cypher_vo_intro();
      return;
    }

    return;
  }
}

function trial_target_think() {
  self endon("change_role");

  if(scripts\mp\bots\bots_util::bot_is_defending()) {
    scripts\mp\bots\bots_strategy::bot_defend_stop();
  }

  self botsetscriptgoalnode(scripts\engine\utility::random(self.current_bombzone.bottargets), "critical");
  var0 = scripts\mp\bots\bots_util::bot_waittill_goal_or_fail();

  if(var0 == "goal") {
    wait 2;
    cypher_vo_intro();
    return;
  }
}

function quickdropitem(var0) {
  var1 = race_calculate_stars(var0, self.team);

  foreach(var3 in var1) {
    if(!isai(var3)) {
      if(var3.isdefusing) {
        return var3;
      }
    }
  }

  foreach(var3 in var1) {
    if(isai(var3)) {
      if(isDefined(var3.role) && var3.role == "defuser") {
        return var3;
      }
    }
  }

  return undefined;
}

function quickdropremovefrominventory(var0) {
  var1 = race_calculate_stars(var0, self.team);

  foreach(var3 in var1) {
    if(!isai(var3)) {
      if(var3.isplanting) {
        return var3;
      }
    }
  }

  foreach(var3 in var1) {
    if(isai(var3)) {
      if(isDefined(var3.role) && var3.role == "atk_bomber") {
        return var3;
      }
    }
  }

  return undefined;
}

function current_puddle_count(var0) {
  if(var0.visibleteam == "any") {
    return true;
  }

  return false;
}

function pregeneratespawnpoints() {
  var0 = [];

  foreach(var2 in level.objectives) {
    if(current_puddle_count(var2)) {
      var0 = var2;
    }
  }

  return var0;
}

function race_calculate_stars(var0, var1) {
  var2 = [];
  var3 = scripts\mp\bots\bots_gametype_common::get_living_players_on_team(var1);

  foreach(var5 in var3) {
    if(isai(var5)) {
      if(isDefined(var5.current_bombzone) && var5.current_bombzone == var0) {
        var2 = scripts\engine\utility::array_add(var2, var5);
      }

      continue;
    }

    if(distancesquared(var5.origin, var0.curorigin) < level.protect_radius * level.protect_radius) {
      var2 = scripts\engine\utility::array_add(var2, var5);
    }
  }

  return var2;
}

function deadred(var0, var1) {
  GscBinSkip1(0x45, 0, race_calculate_stars(var0[0], game["defenders"]).size);
}

function deafen_ai(var0) {
  var1 = undefined;

  if(var0 == "attack") {
    var1 = custom_loadout_index();
  } else if(var0 == "defend") {
    var1 = custom_shouldtakedamage();
  }

  if(isDefined(var1) && (!isDefined(self.current_bombzone) || self.current_bombzone != var1)) {
    self.current_bombzone = var1;
    cypher_vo_intro();
    return;
  }
}

function custom_shouldtakedamage() {
  var0 = pregeneratespawnpoints();
  var1 = undefined;

  if(var0.size == 1) {
    var1 = var0[0];
  } else if(var0.size == 2) {
    GscBinSkip1(0x45, 0, race_calculate_stars(var0[0], game["defenders"]).size);
  }

  return var1;
}

function quickdropaddtocache(var0) {
  var1 = pregeneratespawnpoints();

  foreach(var3 in var1) {
    if(var3 != var0) {
      return var3;
    }
  }
}

function custom_loadout_index() {
  if(isDefined(self.current_bombzone)) {
    return;
  }

  if(!isDefined(level.current_zone_target) || !current_puddle_count(level.current_zone_target) || gettime() > level.next_target_switch_time) {
    level.next_target_switch_time = gettime() + 1000 * randomintrange(30, 45);
    level.current_zone_target = scripts\engine\utility::random(pregeneratespawnpoints());
  }

  if(!isDefined(level.current_zone_target)) {
    return;
  }

  var0 = level.current_zone_target;
  var1 = quickdropaddtocache(var0);
  self.current_bombzone = undefined;

  if(isDefined(var1)) {
    if(randomfloat(1) < 0.25) {
      return var1;
    }
  }

  return var0;
}

function debug_calculatecashonground() {
  var0 = quickdropaddtocache(self.current_bombzone);

  if(isDefined(var0)) {
    var1 = distance(self.origin, self.current_bombzone.curorigin);
    var2 = distance(self.origin, var0.curorigin);

    if(var2 < var1 * 0.6) {
      self.current_bombzone = var0;
      return;
    }

    return;
  }
}

function custom_helicopter_firendly_dmg_func() {
  if(isDefined(self.role)) {
    if(self.role == "investigate_someone_using_bomb") {
      return;
    }
  }

  var0 = undefined;

  if(is_bomb_planted_on(self.current_bombzone)) {
    var0 = "defend_zone";
  } else {
    var1 = quickdropremovefrominventory(self.current_bombzone);

    if(!isDefined(var1) || var1 == self) {
      var0 = "atk_bomber";
    } else if(isai(var1)) {
      var2 = distance(self.origin, self.current_bombzone.curorigin);
      var3 = distance(var1.origin, self.current_bombzone.curorigin);

      if(var2 < var3 * 0.9) {
        var0 = "atk_bomber";
        cypher_vo_intro(var1);
      }
    }
  }

  if(!isDefined(var0)) {
    var0 = "sweep_zone";
  }

  damage_area(var0);
}

function custom_putongroundfunc() {
  if(isDefined(self.role)) {
    if(self.role == "investigate_someone_using_bomb") {
      return;
    }
  }

  var0 = undefined;

  if(is_bomb_planted_on(self.current_bombzone)) {
    var1 = quickdropitem(self.current_bombzone);

    if(!isDefined(var1) || var1 == self) {
      var0 = "defuser";
    } else if(isai(var1)) {
      var2 = distance(self.origin, self.current_bombzone.curorigin);
      var3 = distance(var1.origin, self.current_bombzone.curorigin);

      if(var2 < var3 * 0.9) {
        var0 = "defuser";
        cypher_vo_intro(var1);
      }
    }
  }

  if(!isDefined(var0)) {
    var0 = "defend_zone";
  }

  damage_area(var0);
}

function damage_area(var0) {
  if(!isDefined(self.role) || self.role != var0) {
    cypher_vo_intro();
    self.role = var0;
    return;
  }
}

function cypher_vo_intro() {
  self.role = undefined;
  self botclearscriptgoal();
  self botsetpathingstyle(undefined);
  scripts\mp\bots\bots_strategy::bot_defend_stop();
  self notify("change_role");
  self.defuser_bad_path_counter = 0;
}

function cypher_vo_hack_progress() {
  level notify("bot_dd_ai_director_update");
  level endon("bot_dd_ai_director_update");
  level endon("game_ended");
  level.protect_radius = 725;

  for(;;) {
    foreach(var1 in level.objectives) {
      foreach(var3 in level.players) {
        if(isDefined(var3.role) && isDefined(var3.current_bombzone) && var3.current_bombzone == var1) {
          if(!current_puddle_count(var1)) {
            if(var3.role == "atk_bomber" || var3.role == "defuser") {
              cypher_vo_intro(var3);
            }

            continue;
          }

          if(is_bomb_planted_on(var1)) {
            if(var3.role == "atk_bomber") {
              cypher_vo_intro(var3);
            }
          }
        }
      }
    }

    wait 0.5;
  }
}

function is_bomb_planted_on(var0) {
  return istrue(var0.bombplanted);
}

function vehicle_compass_br_shouldbevisibletoplayer(var0) {
  var1 = spawncovernode(var0, (0, randomint(360), 0), "Cover Stand");
}

function damage_multiplier() {
  switch (level.mapname) {
    case "mp_m_speed":
      var0 = (67, 1916, 22);
      thread vehicle_compass_br_shouldbevisibletoplayer(var0);
      var0 = (7, 1877, 22);
      thread vehicle_compass_br_shouldbevisibletoplayer(var0);
      var0 = (-35, 1925, 22);
      thread vehicle_compass_br_shouldbevisibletoplayer(var0);
      var0 = (-28, 1878, 22);
      thread vehicle_compass_br_shouldbevisibletoplayer(var0);
      var0 = (69, 1879, 22);
      thread vehicle_compass_br_shouldbevisibletoplayer(var0);
      break;
    case "mp_runner":
      var0 = (196, -1338, 257);
      thread vehicle_compass_br_shouldbevisibletoplayer(var0);
      var0 = (920, 821, 260);
      thread vehicle_compass_br_shouldbevisibletoplayer(var0);
      var0 = (1005, 707, 260);
      thread vehicle_compass_br_shouldbevisibletoplayer(var0);
      var0 = (-53, -411, 262);
      thread vehicle_compass_br_shouldbevisibletoplayer(var0);
      break;
    case "mp_crash2":
      var0 = (-226, -791, 100);
      thread vehicle_compass_br_shouldbevisibletoplayer(var0);
      break;
    default:
      break;
  }
}