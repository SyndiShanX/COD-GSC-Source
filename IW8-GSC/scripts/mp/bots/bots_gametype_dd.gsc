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
  var_0 = scripts\mp\bots\bots_gametype_common::debug_consoles(["_a", "_b"]);

  if(var_0) {
    foreach(var_2 in level.objectives) {
      var_2 thread scripts\mp\bots\bots_gametype_common::monitor_bombzone_control();
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
      var_0 = level.objectives["_a"].ownerteam != self.team;
    } else {
      var_0 = self.team == game["attackers"];
    }

    if(var_0) {
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

function notify_enemy_team_bomb_used(var_0) {
  var_1 = scripts\mp\bots\bots_gametype_common::find_closest_bombzone_to_player(self);
  var_2 = scripts\mp\bots\bots_gametype_common::prematchinitx1blueprintloadouts(var_0);

  foreach(var_4 in var_2) {
    if(isDefined(var_4.current_bombzone) && var_1 == var_4.current_bombzone) {
      damage_area(var_4, "investigate_someone_using_bomb");
    }
  }
}

function plant_bomb() {
  self endon("change_role");
  var_0 = scripts\mp\bots\bots_gametype_common::process_should_do_pain(self.current_bombzone, 0);
  self botsetscriptgoal(var_0.origin, 0, "critical");
  var_1 = scripts\mp\bots\bots_util::bot_waittill_goal_or_fail(undefined, "change_role");

  if(var_1 == "goal") {
    var_2 = scripts\mp\gamelogic::gettimeremaining();
    var_3 = var_2 - level.planttime * 2 * 1000;
    var_4 = gettime() + var_3;

    if(var_3 > 0) {
      scripts\mp\bots\bots_util::bot_waittill_out_of_combat_or_time(var_3);
    }

    var_5 = var_4 > 0 && gettime() >= var_4;
    var_6 = scripts\mp\bots\bots_gametype_common::current_respawn_point_override(level.planttime + 2, "bomb_planted", var_5);
    self botclearscriptgoal();

    if(var_6) {
      cypher_vo_intro();
      return;
    }

    return;
  }
}

function defuse_bomb() {
  self endon("change_role");
  self botsetpathingstyle("scripted");
  var_0 = scripts\mp\bots\bots_gametype_common::process_players_inside_subway_car(self.current_bombzone).origin;
  self botsetscriptgoal(var_0, 20, "critical");
  var_1 = scripts\mp\bots\bots_util::bot_waittill_goal_or_fail(undefined, "change_role");

  if(var_1 == "bad_path") {
    self.defuser_bad_path_counter++;

    if(self.defuser_bad_path_counter >= 4) {
      for(;;) {
        var_2 = getnodesinradiussorted(var_0, 50, 0);
        var_3 = self.defuser_bad_path_counter - 4;

        if(var_2.size <= var_3) {
          var_4 = botgetclosestnavigablepoint(var_0, 50, self);

          if(isDefined(var_4)) {
            self botsetscriptgoal(var_4, 20, "critical");
          } else {
            break;
          }
        } else {
          self botsetscriptgoal(var_1[var_2].origin, 20, "critical");
        }

        var_0 = scripts\mp\bots\bots_util::bot_waittill_goal_or_fail(undefined, "change_role");

        if(var_0 == "bad_path") {
          self.defuser_bad_path_counter++;
          continue;
        }

        break;
      }
    }
  }

  if(var_0 == "goal") {
    var_5 = gettime() - self.current_bombzone.startbombtime;
    var_6 = level.bombtimer * 1000 - var_5;
    var_7 = var_6 - level.defusetime * 2 * 1000;
    var_8 = gettime() + var_7;

    if(var_7 > 0) {
      scripts\mp\bots\bots_util::bot_waittill_out_of_combat_or_time(var_7);
    }

    var_9 = var_8 > 0 && gettime() >= var_8;
    var_10 = scripts\mp\bots\bots_gametype_common::current_respawn_point_override(level.defusetime + 2, "bomb_defused", var_9);

    if(!var_10 && self.defuser_bad_path_counter >= 4) {
      self.defuser_bad_path_counter++;
    }

    self botclearscriptgoal();

    if(var_10) {
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
  var_0 = scripts\mp\bots\bots_util::bot_waittill_goal_or_fail();

  if(var_0 == "goal") {
    wait 2;
    cypher_vo_intro();
    return;
  }
}

function quickdropitem(var_0) {
  var_1 = race_calculate_stars(var_0, self.team);

  foreach(var_3 in var_1) {
    if(!isai(var_3)) {
      if(var_3.isdefusing) {
        return var_3;
      }
    }
  }

  foreach(var_3 in var_1) {
    if(isai(var_3)) {
      if(isDefined(var_3.role) && var_3.role == "defuser") {
        return var_3;
      }
    }
  }

  return undefined;
}

function quickdropremovefrominventory(var_0) {
  var_1 = race_calculate_stars(var_0, self.team);

  foreach(var_3 in var_1) {
    if(!isai(var_3)) {
      if(var_3.isplanting) {
        return var_3;
      }
    }
  }

  foreach(var_3 in var_1) {
    if(isai(var_3)) {
      if(isDefined(var_3.role) && var_3.role == "atk_bomber") {
        return var_3;
      }
    }
  }

  return undefined;
}

function current_puddle_count(var_0) {
  if(var_0.visibleteam == "any") {
    return true;
  }

  return false;
}

function pregeneratespawnpoints() {
  var_0 = [];

  foreach(var_2 in level.objectives) {
    if(current_puddle_count(var_2)) {
      var_0 = var_2;
    }
  }

  return var_0;
}

function race_calculate_stars(var_0, var_1) {
  var_2 = [];
  var_3 = scripts\mp\bots\bots_gametype_common::get_living_players_on_team(var_1);

  foreach(var_5 in var_3) {
    if(isai(var_5)) {
      if(isDefined(var_5.current_bombzone) && var_5.current_bombzone == var_0) {
        var_2 = scripts\engine\utility::array_add(var_2, var_5);
      }

      continue;
    }

    if(distancesquared(var_5.origin, var_0.curorigin) < level.protect_radius * level.protect_radius) {
      var_2 = scripts\engine\utility::array_add(var_2, var_5);
    }
  }

  return var_2;
}

function deadred(var_0, var_1) {
  GscBinSkip1(0x45, 0, race_calculate_stars(var_0[0], game["defenders"]).size);
}

function deafen_ai(var_0) {
  var_1 = undefined;

  if(var_0 == "attack") {
    var_1 = custom_loadout_index();
  } else if(var_0 == "defend") {
    var_1 = custom_shouldtakedamage();
  }

  if(isDefined(var_1) && (!isDefined(self.current_bombzone) || self.current_bombzone != var_1)) {
    self.current_bombzone = var_1;
    cypher_vo_intro();
    return;
  }
}

function custom_shouldtakedamage() {
  var_0 = pregeneratespawnpoints();
  var_1 = undefined;

  if(var_0.size == 1) {
    var_1 = var_0[0];
  } else if(var_0.size == 2) {
    GscBinSkip1(0x45, 0, race_calculate_stars(var_0[0], game["defenders"]).size);
  }

  return var_1;
}

function quickdropaddtocache(var_0) {
  var_1 = pregeneratespawnpoints();

  foreach(var_3 in var_1) {
    if(var_3 != var_0) {
      return var_3;
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

  var_0 = level.current_zone_target;
  var_1 = quickdropaddtocache(var_0);
  self.current_bombzone = undefined;

  if(isDefined(var_1)) {
    if(randomfloat(1) < 0.25) {
      return var_1;
    }
  }

  return var_0;
}

function debug_calculatecashonground() {
  var_0 = quickdropaddtocache(self.current_bombzone);

  if(isDefined(var_0)) {
    var_1 = distance(self.origin, self.current_bombzone.curorigin);
    var_2 = distance(self.origin, var_0.curorigin);

    if(var_2 < var_1 * 0.6) {
      self.current_bombzone = var_0;
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

  var_0 = undefined;

  if(is_bomb_planted_on(self.current_bombzone)) {
    var_0 = "defend_zone";
  } else {
    var_1 = quickdropremovefrominventory(self.current_bombzone);

    if(!isDefined(var_1) || var_1 == self) {
      var_0 = "atk_bomber";
    } else if(isai(var_1)) {
      var_2 = distance(self.origin, self.current_bombzone.curorigin);
      var_3 = distance(var_1.origin, self.current_bombzone.curorigin);

      if(var_2 < var_3 * 0.9) {
        var_0 = "atk_bomber";
        cypher_vo_intro(var_1);
      }
    }
  }

  if(!isDefined(var_0)) {
    var_0 = "sweep_zone";
  }

  damage_area(var_0);
}

function custom_putongroundfunc() {
  if(isDefined(self.role)) {
    if(self.role == "investigate_someone_using_bomb") {
      return;
    }
  }

  var_0 = undefined;

  if(is_bomb_planted_on(self.current_bombzone)) {
    var_1 = quickdropitem(self.current_bombzone);

    if(!isDefined(var_1) || var_1 == self) {
      var_0 = "defuser";
    } else if(isai(var_1)) {
      var_2 = distance(self.origin, self.current_bombzone.curorigin);
      var_3 = distance(var_1.origin, self.current_bombzone.curorigin);

      if(var_2 < var_3 * 0.9) {
        var_0 = "defuser";
        cypher_vo_intro(var_1);
      }
    }
  }

  if(!isDefined(var_0)) {
    var_0 = "defend_zone";
  }

  damage_area(var_0);
}

function damage_area(var_0) {
  if(!isDefined(self.role) || self.role != var_0) {
    cypher_vo_intro();
    self.role = var_0;
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
    foreach(var_1 in level.objectives) {
      foreach(var_3 in level.players) {
        if(isDefined(var_3.role) && isDefined(var_3.current_bombzone) && var_3.current_bombzone == var_1) {
          if(!current_puddle_count(var_1)) {
            if(var_3.role == "atk_bomber" || var_3.role == "defuser") {
              cypher_vo_intro(var_3);
            }

            continue;
          }

          if(is_bomb_planted_on(var_1)) {
            if(var_3.role == "atk_bomber") {
              cypher_vo_intro(var_3);
            }
          }
        }
      }
    }

    wait 0.5;
  }
}

function is_bomb_planted_on(var_0) {
  return istrue(var_0.bombplanted);
}

function vehicle_compass_br_shouldbevisibletoplayer(var_0) {
  var_1 = spawncovernode(var_0, (0, randomint(360), 0), "Cover Stand");
}

function damage_multiplier() {
  switch (level.mapname) {
    case "mp_m_speed":
      var_0 = (67, 1916, 22);
      thread vehicle_compass_br_shouldbevisibletoplayer(var_0);
      var_0 = (7, 1877, 22);
      thread vehicle_compass_br_shouldbevisibletoplayer(var_0);
      var_0 = (-35, 1925, 22);
      thread vehicle_compass_br_shouldbevisibletoplayer(var_0);
      var_0 = (-28, 1878, 22);
      thread vehicle_compass_br_shouldbevisibletoplayer(var_0);
      var_0 = (69, 1879, 22);
      thread vehicle_compass_br_shouldbevisibletoplayer(var_0);
      break;
    case "mp_runner":
      var_0 = (196, -1338, 257);
      thread vehicle_compass_br_shouldbevisibletoplayer(var_0);
      var_0 = (920, 821, 260);
      thread vehicle_compass_br_shouldbevisibletoplayer(var_0);
      var_0 = (1005, 707, 260);
      thread vehicle_compass_br_shouldbevisibletoplayer(var_0);
      var_0 = (-53, -411, 262);
      thread vehicle_compass_br_shouldbevisibletoplayer(var_0);
      break;
    case "mp_crash2":
      var_0 = (-226, -791, 100);
      thread vehicle_compass_br_shouldbevisibletoplayer(var_0);
      break;
    default:
      break;
  }
}