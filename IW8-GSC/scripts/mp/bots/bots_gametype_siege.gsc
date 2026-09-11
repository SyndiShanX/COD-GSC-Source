/***************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\bots\bots_gametype_siege.gsc
***************************************************/

function main() {
  setup_callbacks();

  if(level.unset_relic_lfo) {
    scripts\mp\bots\bots_gametype_war::setup_bot_war();
    return;
  }

  thread bot_siege_manager_think();
  setup_bot_siege();
}

function setup_callbacks() {
  level.bot_funcs["gametype_think"] = &bot_siege_think;
}

function setup_bot_siege() {
  level.bot_gametype_precaching_done = 1;
}

function bot_siege_manager_think() {
  level.siege_bot_team_need_flags = [];
  scripts\mp\flags::gameflagwait("prematch_done");
  level.ref_13391 = [];
  level.ref_13390 = [];

  for(;;) {
    level.siege_bot_team_need_flags = [];

    foreach(var_1 in level.players) {
      if(!scripts\mp\utility\player::isreallyalive(var_1) && var_1.hasspawned) {
        if(var_1.team != "spectator" && var_1.team != "neutral") {
          level.siege_bot_team_need_flags[var_1.team] = 1;
        }
      }
    }

    var_3 = [];

    foreach(var_5 in level.objectives) {
      var_6 = var_5 scripts\mp\gameobjects::getownerteam();

      if(var_6 != "neutral") {
        if(!isDefined(var_3[var_6])) {
          var_3 = 1;
          continue;
        }

        var_3++;
      }
    }

    foreach(var_6, var_9 in var_3) {
      if(var_9 >= 2) {
        var_10 = scripts\mp\utility\game::getotherteam(var_6)[0];
        level.siege_bot_team_need_flags[var_10] = 1;

        if(var_9 == 2 && !istrue(level.ref_13391[var_6])) {
          if(randomint(100) > 75) {
            level.siege_bot_team_need_flags[var_6] = 1;
          } else {
            level.ref_13391[var_6] = 0;
          }

          level.ref_13390[var_6] = 1;
        }

        continue;
      }

      if(var_9 < 2 && istrue(level.ref_13390[var_6])) {
        level.ref_13390[var_6] = 0;
        level.ref_13391[var_6] = 0;
      }
    }

    wait 1;
  }
}

function bot_siege_think() {
  self notify("bot_siege_think");
  self endon("bot_siege_think");
  self endon("death_or_disconnect");
  level endon("game_ended");

  while(!isDefined(level.bot_gametype_precaching_done)) {
    wait 0.05;
  }

  while(!isDefined(level.siege_bot_team_need_flags)) {
    wait 0.05;
  }

  self botsetflag("separation", 0);
  self botsetflag("use_obj_path_style", 1);

  for(;;) {
    if(isDefined(level.siege_bot_team_need_flags[self.team]) && level.siege_bot_team_need_flags[self.team]) {
      bot_choose_flag();
    } else if(isDefined(self.goalflag)) {
      if(scripts\mp\bots\bots_util::bot_is_defending()) {
        scripts\mp\bots\bots_strategy::bot_defend_stop();
      }

      self.goalflag = undefined;
    }

    wait 1;
  }
}

function bot_choose_flag() {
  var_0 = undefined;
  var_1 = undefined;

  foreach(var_3 in level.objectives) {
    var_4 = var_3 scripts\mp\gameobjects::getownerteam();

    if(var_4 != self.team) {
      var_5 = distancesquared(self.origin, var_3.trigger.origin);

      if(!isDefined(var_1) || var_5 < var_1) {
        var_1 = var_5;
        var_0 = var_3;
      }
    }
  }

  if(isDefined(var_0)) {
    if(!isDefined(self.goalflag) || self.goalflag != var_0) {
      self.goalflag = var_0;
      scripts\mp\bots\bots_strategy::bot_capture_point(var_0.trigger.origin, 100);
      return;
    }

    return;
  }
}