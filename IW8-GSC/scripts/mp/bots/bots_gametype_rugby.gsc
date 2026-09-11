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
  var0 = debug_display_track_tilts(["_allies", "_axis"]);

  if(var0) {
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
        var0 = &ref_12dcf;
        var1 = spawnStruct();
        var1.object = level.rugby.activejuggcrates[0];
        var1.script_goal_radius = 16;
        var1.should_abort = level.bot_funcs["jugg_picked_up_cancel"];
        var1.action_thread = var0;
        var2 = getclosestpointonnavmesh(level.rugby.activejuggcrates[0].origin, self);
        scripts\mp\bots\bots_strategy::bot_new_tactical_goal("seek_rugby_jugg", var2, 99, var1);
      }

      continue;
    }

    if(self == level.ref_12dd4) {
      if(istrue(game["switchedsides"])) {
        var3 = level.rugby.endzones[self.team][0];
      } else {
        var3 = level.rugby.endzones[scripts\engine\utility::get_enemy_team(self.team)][0];
      }

      var4 = propminigamesetting(var3.trigger);
      self botsetscriptgoal(var4.origin, 0, "critical", var4.angles[1]);
      var5 = scripts\mp\bots\bots_util::bot_waittill_goal_or_fail();
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

function propminigamesetting(var0) {
  if(var0.bottargets.size >= 2) {
    var1 = scripts\engine\utility::array_randomize(var0.bottargets);
    return var1[0];
  }

  return var1.bottargets[0];
}

function currentintelindex(var0) {
  if(isDefined(level.ref_12dd4)) {
    return true;
  }

  return false;
}

function ref_12dcf(var0) {
  var1 = vehicle_isfriendlytoteam(scripts\mp\gametypes\rugby::remove_spawn_disable_struct() + 2, "jugg_captured", randomint(100) > 50);
  self botclearscriptgoal();

  if(var1) {
    return;
  }
}

function vehicle_isfriendlytoteam(var0, var1, var2, var3) {
  var4 = 0;

  if(self botgetdifficultysetting("strategyLevel") == 1) {
    var4 = 40;
  } else if(self botgetdifficultysetting("strategyLevel") >= 2) {
    var4 = 80;
  }

  if(randomint(100) < var4 && !(isDefined(var3) && var3)) {
    self botsetstance("prone");
    wait 0.2;
  }

  if(self botgetdifficultysetting("strategyLevel") > 0 && !var2) {}

  self botpressbutton("use", var0);
  var5 = scripts\mp\bots\bots_util::bot_usebutton_wait(var0, var1, "use_interrupted");
  self botsetstance("none");
  self botclearbutton("use");
  var6 = var5 == var1;
  return var6;
}

function ref_143eb(var0) {
  var1 = gettime();
  var2 = var1 + var0 * 1000;
  wait 0.05;

  while(self useButtonPressed() && gettime() < var2 && level.bombplanted) {
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

function death_killstreak_watcher(var0) {
  if(!isDefined(var0.bottargets)) {
    var0.bottargets = scripts\mp\bots\bots_gametype_common::bot_get_valid_nodes_in_trigger(var0);
    return;
  }
}

function ref_13f86() {
  if(!level.bombplanted) {
    if(isDefined(level.ref_13a9a)) {
      level.ref_13a9a = undefined;
      level.cover_guys_debug = undefined;
    }

    var0 = level.cover_guys_debug;
    level.cover_guys_debug = undefined;

    foreach(var2 in level.participants) {
      if(isalive(var2) && var2.isbombcarrier) {
        level.cover_guys_debug = var2;
      }
    }

    var4 = 0;

    if(!isDefined(var0) && isDefined(level.cover_guys_debug)) {
      var4 = 1;

      if(isai(level.cover_guys_debug)) {
        thread createinvalidcirclearea();
      }
    } else if(isDefined(var0) && !isDefined(level.cover_guys_debug)) {
      var4 = 1;
    }

    if(var4) {
      foreach(var2 in level.participants) {
        if(scripts\mp\utility\entity::isaiteamparticipant(var2)) {
          var2 scripts\mp\bots\bots_strategy::bot_defend_stop();
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
    var7 = [];

    foreach(var2 in level.participants) {
      if(isalive(var2) && scripts\mp\utility\entity::isaiteamparticipant(var2) && var2.team != level.ref_13a9a) {
        var7 = var2;
      }
    }

    if(var7.size > 0) {
      var10 = level.objectives[scripts\engine\utility::get_enemy_team(level.ref_13a9a)];
      var11 = scripts\engine\utility::get_array_of_closest(var10.curorigin, var7);

      if(!isDefined(level.bomb_defuser) || level.bomb_defuser != var11[0]) {
        var12 = level.bomb_defuser;
        level.bomb_defuser = var11[0];
        level.bomb_defuser scripts\mp\bots\bots_strategy::bot_defend_stop();

        if(isDefined(var12)) {
          var12 notify("no_longer_bomb_defuser");
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
    var0 = [];

    foreach(var2 in level.participants) {
      if(isalive(var2) && scripts\mp\utility\entity::isaiteamparticipant(var2) && var2.team == self.team && var2 scripts\mp\bots\bots_util::bot_is_defending()) {
        var0 = var2;
      }
    }

    var4 = 0;

    foreach(var6 in var0) {
      var7 = distancesquared(self.origin, var6.origin);
      var8 = var6.bot_defending_radius * var6.bot_defending_radius;
      var9 = var6.bot_defending_radius * 2 * var6.bot_defending_radius * 2;

      if(var7 > var8 && var7 < var9) {
        var4++;
      }
    }

    self setmovespeedscale(1 - 0.15 * var4);
    wait 1;
  }
}

function crate_can_use(var0) {
  if(isagent(self) && !isDefined(var0.boxtype)) {
    return false;
  }

  if(isDefined(var0.cratetype) && !scripts\mp\bots\bots_killstreaks::bot_is_killstreak_supported(var0.cratetype)) {
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

function debug_display_track_tilts(var0) {
  var1 = 0;

  foreach(var3 in level.rugby.endzones) {}

  if(!var1) {
    currentvalue();
  }

  return !var1;
}

function currentvalue() {
  var0 = [];
  var1 = [];
  var2 = 0;

  foreach(var4 in level.rugby.endzones) {
    var0 = scripts\engine\utility::random(var4[0].trigger.bottargets).origin;
    var1 = "zone" + var4[0].trigger.objectivekey;
    var2++;
  }

  scripts\mp\bots\bots_gametype_common::bot_cache_entrances(var0, var1);
}