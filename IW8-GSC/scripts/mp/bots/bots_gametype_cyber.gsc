/***************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\bots\bots_gametype_cyber.gsc
***************************************************/

function main() {
  setup_callbacks();
  setup_bot_cyber();
}

function setup_callbacks() {
  level.bot_funcs["crate_can_use"] = &crate_can_use;
  level.bot_funcs["gametype_think"] = &bot_cyber_think;
  level.bot_funcs["know_enemies_on_start"] = undefined;
  level.bot_funcs["emp_picked_up_cancel"] = &currentintelflag;
  level.bot_funcs["tactical_revive_override"] = &currentlabel;
}

function setup_bot_cyber() {
  damage_multiplier();
  scripts\mp\bots\bots_gametype_common::bot_setup_objective_bottargets();
  scripts\mp\bots\bots_util::bot_waittill_bots_enabled();
  var_0 = scripts\mp\bots\bots_gametype_common::debug_consoles(["_allies", "_axis"]);

  if(var_0) {
    foreach(var_2 in level.objectives) {
      var_2 thread scripts\mp\bots\bots_gametype_common::monitor_bombzone_control();
    }

    level.protect_radius = 600;
    level.bot_gametype_precaching_done = 1;
    return;
  }
}

function bot_cyber_think() {
  self notify("bot_sab_think");
  self endon("bot_sab_think");
  self endon("death_or_disconnect");
  level endon("game_ended");

  while(!isDefined(level.bot_gametype_precaching_done)) {
    wait 0.05;
  }

  strafe();
  self botsetflag("separation", 0);
  self botsetflag("grenade_objectives", 1);
  self botsetflag("use_obj_path_style", 1);
  self.next_time_hunt_carrier = gettime();

  if(!isDefined(level.next_game_update_time)) {
    level.next_game_update_time = gettime() + 100;
  }

  for(;;) {
    wait 0.05;

    if(gettime() >= level.next_game_update_time) {
      ref_13f85();
      level.next_game_update_time = gettime() + 100;
    }

    if(self.health <= 0) {
      continue;
    }

    if(!isDefined(level.ref_13a9a)) {
      if(!isDefined(level.cover_guys_debug)) {
        if(scripts\mp\bots\bots_strategy::bot_has_tactical_goal("seek_cyber_emp", undefined) == 0) {
          var_0 = &introarmor;
          var_1 = spawnStruct();
          var_1.object = level.cyberemp.trigger;
          var_1.script_goal_radius = 16;
          var_1.should_abort = level.bot_funcs["emp_picked_up_cancel"];
          var_1.action_thread = var_0;
          var_2 = getclosestpointonnavmesh(level.cyberemp.curorigin, self);
          scripts\mp\bots\bots_strategy::bot_new_tactical_goal("seek_cyber_emp", var_2, 99, var_1);
        }
      } else if(self.isbombcarrier) {
        var_3 = level.objectives[scripts\engine\utility::get_enemy_team(self.team)];
        var_4 = scripts\mp\bots\bots_gametype_common::process_should_do_pain(var_3, 1);
        self botsetscriptgoal(var_4.origin, 0, "critical", var_4.angles[1]);
        var_5 = scripts\mp\bots\bots_util::bot_waittill_goal_or_fail();

        if(var_5 == "goal") {
          self botpressbutton("use", level.planttime + 2);
          level scripts\engine\utility::ref_143b9(level.planttime + 2, "bomb_planted");
        }
      } else if(level.cover_guys_debug.team == self.team) {
        if(!scripts\mp\bots\bots_util::bot_is_defending()) {
          scripts\mp\bots\bots_strategy::bot_guard_player(level.cover_guys_debug, 400);
        }
      } else if(gettime() > self.next_time_hunt_carrier || sighttracepassed(self.origin + (0, 0, 77), level.cover_guys_debug.origin + (0, 0, 77), 0, self)) {
        self botsetscriptgoal(level.cover_guys_debug.origin, 16, "hunt");
        self.next_time_hunt_carrier = gettime() + randomintrange(4500, 5500);
      }

      continue;
    }

    var_3 = level.objectives[scripts\engine\utility::get_enemy_team(level.ref_13a9a)];

    if(self.team == level.ref_13a9a) {
      if(!trigger_spawn_kill_watcher()) {
        scripts\mp\bots\bots_strategy::bot_protect_point(var_3.curorigin, 600);
      }
    } else if(isDefined(level.bomb_defuser) && level.bomb_defuser == self) {
      var_6 = scripts\mp\bots\bots_gametype_common::process_players_inside_subway_car(var_3).origin;
      self botsetscriptgoal(var_6, 20, "critical");
      var_7 = scripts\mp\bots\bots_util::bot_waittill_goal_or_fail(undefined, "no_longer_bomb_defuser");

      if(var_7 == "goal") {
        self botpressbutton("use", level.defusetime + 2);
        ref_143eb(level.defusetime + 2);
      }
    } else if(!scripts\mp\bots\bots_util::bot_is_defending()) {
      GscBinSkip1(0x45, "entrance_points_index", "zone" + var_3.label);
    }
  }
}

function currentintelflag(var_0) {
  if(isDefined(level.cyberemp.carrier)) {
    return true;
  }

  return false;
}

function introarmor(var_0) {
  self botpressbutton("use", 0.5);
  var_1 = self botgetpersonality();

  if(var_1 == "default" || var_1 == "camper") {
    wait 0.5;
    return;
  }
}

function ref_143eb(var_0) {
  var_1 = gettime();
  var_2 = var_1 + var_0 * 1000;
  wait 0.05;

  while(self useButtonPressed() && gettime() < var_2 && level.bombplanted) {
    wait 0.05;
  }
}

function trigger_spawn_kill_watcher() {
  return scripts\mp\bots\bots_util::bot_is_protecting();
}

function strafe() {
  if(isDefined(level.bots_gametype_initialized) && level.bots_gametype_initialized) {
    return;
  }

  level.bots_gametype_initialized = 1;
}

function ref_13f85() {
  if(!level.bombplanted) {
    if(isDefined(level.ref_13a9a)) {
      level.ref_13a9a = undefined;
      level.cover_guys_debug = undefined;
    }

    var_0 = level.cover_guys_debug;
    level.cover_guys_debug = undefined;

    foreach(var_2 in level.participants) {
      if(isalive(var_2) && var_2.isbombcarrier) {
        level.cover_guys_debug = var_2;
      }
    }

    var_4 = 0;

    if(!isDefined(var_0) && isDefined(level.cover_guys_debug)) {
      var_4 = 1;

      if(isai(level.cover_guys_debug)) {
        thread createinvalidcirclearea();
      }
    } else if(isDefined(var_0) && !isDefined(level.cover_guys_debug)) {
      var_4 = 1;
    }

    if(var_4) {
      foreach(var_2 in level.participants) {
        if(scripts\mp\utility\entity::isaiteamparticipant(var_2)) {
          var_2 scripts\mp\bots\bots_strategy::bot_defend_stop();
        }
      }

      return;
    }

    return;
  }

  if(isDefined(level.bombowner) && !isDefined(level.ref_13a9a)) {
    level.ref_13a9a = level.bombowner.team;
    level.waittill_player_behind_cover = gettime();
  }

  if(!isDefined(level.bomb_defuser) || !isalive(level.bomb_defuser) || gettime() > level.waittill_player_behind_cover + 1000) {
    var_7 = [];

    foreach(var_2 in level.participants) {
      if(isalive(var_2) && scripts\mp\utility\entity::isaiteamparticipant(var_2) && var_2.team != level.ref_13a9a) {
        var_7 = var_2;
      }
    }

    if(var_7.size > 0) {
      var_10 = level.objectives[scripts\engine\utility::get_enemy_team(level.ref_13a9a)];
      var_11 = scripts\engine\utility::get_array_of_closest(var_10.curorigin, var_7);

      if(!isDefined(level.bomb_defuser) || level.bomb_defuser != var_11[0]) {
        var_12 = level.bomb_defuser;
        level.bomb_defuser = var_11[0];
        level.bomb_defuser scripts\mp\bots\bots_strategy::bot_defend_stop();

        if(isDefined(var_12)) {
          var_12 notify("no_longer_bomb_defuser");
          return;
        }

        return;
      }

      return;
    }

    return;
  }
}

function createinvalidcirclearea() {
  self endon("death_or_disconnect");
  level endon("game_ended");

  while(!level.bombplanted && self.isbombcarrier) {
    var_0 = [];

    foreach(var_2 in level.participants) {
      if(isalive(var_2) && scripts\mp\utility\entity::isaiteamparticipant(var_2) && var_2.team == self.team && var_2 scripts\mp\bots\bots_util::bot_is_defending()) {
        var_0 = var_2;
      }
    }

    var_4 = 0;

    foreach(var_6 in var_0) {
      var_7 = distancesquared(self.origin, var_6.origin);
      var_8 = var_6.bot_defending_radius * var_6.bot_defending_radius;
      var_9 = var_6.bot_defending_radius * 2 * var_6.bot_defending_radius * 2;

      if(var_7 > var_8 && var_7 < var_9) {
        var_4++;
      }
    }

    self setmovespeedscale(1 - 0.15 * var_4);
    wait 1;
  }
}

function crate_can_use(var_0) {
  if(isagent(self) && !isDefined(var_0.boxtype)) {
    return false;
  }

  if(isDefined(var_0.cratetype) && !scripts\mp\bots\bots_killstreaks::bot_is_killstreak_supported(var_0.cratetype)) {
    return false;
  }

  if(self.isbombcarrier) {
    return false;
  }

  if(!scripts\mp\bots\bots_util::bot_is_defending() && !scripts\mp\bots\bots_util::bot_is_protecting() && !scripts\mp\bots\bots_util::bot_is_bodyguarding()) {
    return true;
  }

  return false;
}

function currentlabel() {
  if(level.bombplanted) {
    return false;
  }

  if(isDefined(level.cyberemp.carrier) && self == level.cyberemp.carrier) {
    return false;
  }

  if(istrue(self.tutorial_lead_collected)) {
    return false;
  }

  var_0 = scripts\mp\utility\teams::getteamdata(self.team, "aliveCount");
  var_1 = scripts\mp\utility\teams::getteamdata(self.team, "teamCount");
  var_2 = var_1 - var_0;

  if(var_2 == 0) {
    return false;
  }

  var_3 = 0;
  var_4 = 0;

  foreach(var_6 in scripts\mp\utility\teams::getteamdata(self.team, "players")) {
    if(istrue(self.tutorial_lead_collected)) {
      var_3++;
    }
  }

  var_8 = int(clamp(var_1 - 2, 1, 3));

  if(var_3 < var_8 + 1) {
    var_4 = 1;
  }

  if(var_4) {
    if(var_1 == 2) {
      var_9 = 1;
    } else {
      var_9 = var_1 / var_2 <= 0.7;
    }

    if(var_9) {
      return true;
    }
  }

  return false;
}

function vehicle_compass_br_shouldbevisibletoplayer(var_0) {
  var_1 = spawncovernode(var_0, (0, randomint(360), 0), "Cover Stand");
}

function damage_multiplier() {
  switch (level.mapname) {
    case "mp_petrograd":
      var_0 = (1184, 1849, 158);
      thread vehicle_compass_br_shouldbevisibletoplayer(var_0);
      break;
    case "mp_deadzone":
      var_0 = (812, -2969, 286);
      thread vehicle_compass_br_shouldbevisibletoplayer(var_0);
      var_0 = (812, -3034, 286);
      thread vehicle_compass_br_shouldbevisibletoplayer(var_0);
      var_0 = (741, 2789, 252);
      thread vehicle_compass_br_shouldbevisibletoplayer(var_0);
      var_0 = (677, 2852, 252);
      thread vehicle_compass_br_shouldbevisibletoplayer(var_0);
      break;
    case "mp_aniyah":
      var_0 = (-548, -530, 270);
      thread vehicle_compass_br_shouldbevisibletoplayer(var_0);
      var_0 = (6191, 148, 270);
      thread vehicle_compass_br_shouldbevisibletoplayer(var_0);
      var_0 = (6297, 215, 270);
      thread vehicle_compass_br_shouldbevisibletoplayer(var_0);
      break;
    default:
      break;
  }
}