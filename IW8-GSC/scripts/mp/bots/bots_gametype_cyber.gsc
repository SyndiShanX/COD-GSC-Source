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
  var0 = scripts\mp\bots\bots_gametype_common::debug_consoles(["_allies", "_axis"]);

  if(var0) {
    foreach(var2 in level.objectives) {
      var2 thread scripts\mp\bots\bots_gametype_common::monitor_bombzone_control();
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
          var0 = &introarmor;
          var1 = spawnStruct();
          var1.object = level.cyberemp.trigger;
          var1.script_goal_radius = 16;
          var1.should_abort = level.bot_funcs["emp_picked_up_cancel"];
          var1.action_thread = var0;
          var2 = getclosestpointonnavmesh(level.cyberemp.curorigin, self);
          scripts\mp\bots\bots_strategy::bot_new_tactical_goal("seek_cyber_emp", var2, 99, var1);
        }
      } else if(self.isbombcarrier) {
        var3 = level.objectives[scripts\engine\utility::get_enemy_team(self.team)];
        var4 = scripts\mp\bots\bots_gametype_common::process_should_do_pain(var3, 1);
        self botsetscriptgoal(var4.origin, 0, "critical", var4.angles[1]);
        var5 = scripts\mp\bots\bots_util::bot_waittill_goal_or_fail();

        if(var5 == "goal") {
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

    var3 = level.objectives[scripts\engine\utility::get_enemy_team(level.ref_13a9a)];

    if(self.team == level.ref_13a9a) {
      if(!trigger_spawn_kill_watcher()) {
        scripts\mp\bots\bots_strategy::bot_protect_point(var3.curorigin, 600);
      }
    } else if(isDefined(level.bomb_defuser) && level.bomb_defuser == self) {
      var6 = scripts\mp\bots\bots_gametype_common::process_players_inside_subway_car(var3).origin;
      self botsetscriptgoal(var6, 20, "critical");
      var7 = scripts\mp\bots\bots_util::bot_waittill_goal_or_fail(undefined, "no_longer_bomb_defuser");

      if(var7 == "goal") {
        self botpressbutton("use", level.defusetime + 2);
        ref_143eb(level.defusetime + 2);
      }
    } else if(!scripts\mp\bots\bots_util::bot_is_defending()) {
      GscBinSkip1(0x45, "entrance_points_index", "zone" + var3.label);
    }
  }
}

function currentintelflag(var0) {
  if(isDefined(level.cyberemp.carrier)) {
    return true;
  }

  return false;
}

function introarmor(var0) {
  self botpressbutton("use", 0.5);
  var1 = self botgetpersonality();

  if(var1 == "default" || var1 == "camper") {
    wait 0.5;
    return;
  }
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

  var0 = scripts\mp\utility\teams::getteamdata(self.team, "aliveCount");
  var1 = scripts\mp\utility\teams::getteamdata(self.team, "teamCount");
  var2 = var1 - var0;

  if(var2 == 0) {
    return false;
  }

  var3 = 0;
  var4 = 0;

  foreach(var6 in scripts\mp\utility\teams::getteamdata(self.team, "players")) {
    if(istrue(self.tutorial_lead_collected)) {
      var3++;
    }
  }

  var8 = int(clamp(var1 - 2, 1, 3));

  if(var3 < var8 + 1) {
    var4 = 1;
  }

  if(var4) {
    if(var1 == 2) {
      var9 = 1;
    } else {
      var9 = var1 / var2 <= 0.7;
    }

    if(var9) {
      return true;
    }
  }

  return false;
}

function vehicle_compass_br_shouldbevisibletoplayer(var0) {
  var1 = spawncovernode(var0, (0, randomint(360), 0), "Cover Stand");
}

function damage_multiplier() {
  switch (level.mapname) {
    case "mp_petrograd":
      var0 = (1184, 1849, 158);
      thread vehicle_compass_br_shouldbevisibletoplayer(var0);
      break;
    case "mp_deadzone":
      var0 = (812, -2969, 286);
      thread vehicle_compass_br_shouldbevisibletoplayer(var0);
      var0 = (812, -3034, 286);
      thread vehicle_compass_br_shouldbevisibletoplayer(var0);
      var0 = (741, 2789, 252);
      thread vehicle_compass_br_shouldbevisibletoplayer(var0);
      var0 = (677, 2852, 252);
      thread vehicle_compass_br_shouldbevisibletoplayer(var0);
      break;
    case "mp_aniyah":
      var0 = (-548, -530, 270);
      thread vehicle_compass_br_shouldbevisibletoplayer(var0);
      var0 = (6191, 148, 270);
      thread vehicle_compass_br_shouldbevisibletoplayer(var0);
      var0 = (6297, 215, 270);
      thread vehicle_compass_br_shouldbevisibletoplayer(var0);
      break;
    default:
      break;
  }
}