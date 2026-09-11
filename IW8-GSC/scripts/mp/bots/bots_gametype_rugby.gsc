/***************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\bots\bots_gametype_rugby.gsc
***************************************************/

function main() {
  setup_callbacks();
  ref_131e0();
}

function setup_callbacks() {
  level.bot_funcs["gametype_think"] = &death_explode;
  level.bot_funcs["crate_can_use"] = &crate_can_use;
  level.bot_funcs["know_enemies_on_start"] = undefined;
  level.bot_funcs["jugg_picked_up_cancel"] = &currentintelindex;
}

function ref_131e0() {
  deathcashcollected();
  scripts\mp\bots\bots_util::bot_waittill_bots_enabled();
  var_0 = debug_display_track_tilts(["_allies", "_axis"]);

  if(var_0) {
    level.protect_radius = 1200;
    level.bot_gametype_precaching_done = 1;
    return;
  }
}

function death_explode() {
  self notify("bot_rugby_think");
  self endon("bot_rugby_think");
  self endon("death_or_disconnect");
  level endon("game_ended");
  self endon("death_or_disconnect");
  level endon("game_ended");

  while(!isDefined(level.bot_gametype_precaching_done)) {
    wait 0.05;
  }

  strafe_acceleration();
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
      level.next_game_update_time = gettime() + 100;
    }

    if(self.health <= 0) {
      continue;
    }

    if(!isDefined(level.ref_12dd4)) {
      if(scripts\mp\bots\bots_strategy::bot_has_tactical_goal("seek_rugby_jugg", undefined) == 0) {
        var_0 = &ref_12dcf;
        var_1 = spawnStruct();
        var_1.object = level.rugby.activejuggcrates[0];
        var_1.script_goal_radius = 16;
        var_1.should_abort = level.bot_funcs["jugg_picked_up_cancel"];
        var_1.action_thread = var_0;
        var_2 = getclosestpointonnavmesh(level.rugby.activejuggcrates[0].origin, self);
        scripts\mp\bots\bots_strategy::bot_new_tactical_goal("seek_rugby_jugg", var_2, 99, var_1);
      }

      continue;
    }

    if(self == level.ref_12dd4) {
      if(istrue(game["switchedsides"])) {
        var_3 = level.rugby.endzones[self.team][0];
      } else {
        var_3 = level.rugby.endzones[scripts\engine\utility::get_enemy_team(self.team)][0];
      }

      var_4 = propminigamesetting(var_3.trigger);
      self botsetscriptgoal(var_4.origin, 0, "critical", var_4.angles[1]);
      var_5 = scripts\mp\bots\bots_util::bot_waittill_goal_or_fail();
      continue;
    }

    if(level.ref_12dd4.team == self.team) {
      if(!scripts\mp\bots\bots_util::bot_is_defending()) {
        scripts\mp\bots\bots_strategy::bot_guard_player(level.ref_12dd4, 400);
      }

      continue;
    }

    if(gettime() > self.next_time_hunt_carrier || sighttracepassed(self.origin + (0, 0, 77), level.ref_12dd4.origin + (0, 0, 77), 0, self)) {
      self botsetscriptgoal(level.ref_12dd4.origin, 16, "hunt");
      self.next_time_hunt_carrier = gettime() + randomintrange(4500, 5500);
    }
  }
}

function propminigamesetting(var_0) {
  if(var_0.bottargets.size >= 2) {
    var_1 = scripts\engine\utility::array_randomize(var_0.bottargets);
    return var_1[0];
  }

  return var_1.bottargets[0];
}

function currentintelindex(var_0) {
  if(isDefined(level.ref_12dd4)) {
    return true;
  }

  return false;
}

function ref_12dcf(var_0) {
  var_1 = vehicle_isfriendlytoteam(scripts\mp\gametypes\rugby::remove_spawn_disable_struct() + 2, "jugg_captured", randomint(100) > 50);
  self botclearscriptgoal();

  if(var_1) {
    return;
  }
}

function vehicle_isfriendlytoteam(var_0, var_1, var_2, var_3) {
  var_4 = 0;

  if(self botgetdifficultysetting("strategyLevel") == 1) {
    var_4 = 40;
  } else if(self botgetdifficultysetting("strategyLevel") >= 2) {
    var_4 = 80;
  }

  if(randomint(100) < var_4 && !(isDefined(var_3) && var_3)) {
    self botsetstance("prone");
    wait 0.2;
  }

  if(self botgetdifficultysetting("strategyLevel") > 0 && !var_2) {}

  self botpressbutton("use", var_0);
  var_5 = scripts\mp\bots\bots_util::bot_usebutton_wait(var_0, var_1, "use_interrupted");
  self botsetstance("none");
  self botclearbutton("use");
  var_6 = var_5 == var_1;
  return var_6;
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

function strafe_acceleration() {
  if(isDefined(level.bots_gametype_initialized) && level.bots_gametype_initialized) {
    return;
  }

  level.bots_gametype_initialized = 1;
}

function deathcashcollected() {
  wait 1;
  death_killstreak_watcher(level.rugby.endzones["allies"][0].trigger);
  death_killstreak_watcher(level.rugby.endzones["axis"][0].trigger);
  level.bot_set_objective_bottargets = 1;
}

function death_killstreak_watcher(var_0) {
  if(!isDefined(var_0.bottargets)) {
    var_0.bottargets = scripts\mp\bots\bots_gametype_common::bot_get_valid_nodes_in_trigger(var_0);
    return;
  }
}

function ref_13f86() {
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

function debug_display_track_tilts(var_0) {
  var_1 = 0;

  foreach(var_3 in level.rugby.endzones) {}

  if(!var_1) {
    currentvalue();
  }

  return !var_1;
}

function currentvalue() {
  var_0 = [];
  var_1 = [];
  var_2 = 0;

  foreach(var_4 in level.rugby.endzones) {
    var_0 = scripts\engine\utility::random(var_4[0].trigger.bottargets).origin;
    var_1 = "zone" + var_4[0].trigger.objectivekey;
    var_2++;
  }

  scripts\mp\bots\bots_gametype_common::bot_cache_entrances(var_0, var_1);
}