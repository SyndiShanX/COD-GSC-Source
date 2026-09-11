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

    foreach(var1 in level.players) {
      if(!scripts\mp\utility\player::isreallyalive(var1) && var1.hasspawned) {
        if(var1.team != "spectator" && var1.team != "neutral") {
          level.siege_bot_team_need_flags[var1.team] = 1;
        }
      }
    }

    var3 = [];

    foreach(var5 in level.objectives) {
      var6 = var5 scripts\mp\gameobjects::getownerteam();

      if(var6 != "neutral") {
        if(!isDefined(var3[var6])) {
          var3 = 1;
          continue;
        }

        var3++;
      }
    }

    foreach(var6, var9 in var3) {
      if(var9 >= 2) {
        var10 = scripts\mp\utility\game::getotherteam(var6)[0];
        level.siege_bot_team_need_flags[var10] = 1;

        if(var9 == 2 && !istrue(level.ref_13391[var6])) {
          if(randomint(100) > 75) {
            level.siege_bot_team_need_flags[var6] = 1;
          } else {
            level.ref_13391[var6] = 0;
          }

          level.ref_13390[var6] = 1;
        }

        continue;
      }

      if(var9 < 2 && istrue(level.ref_13390[var6])) {
        level.ref_13390[var6] = 0;
        level.ref_13391[var6] = 0;
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
  var0 = undefined;
  var1 = undefined;

  foreach(var3 in level.objectives) {
    var4 = var3 scripts\mp\gameobjects::getownerteam();

    if(var4 != self.team) {
      var5 = distancesquared(self.origin, var3.trigger.origin);

      if(!isDefined(var1) || var5 < var1) {
        var1 = var5;
        var0 = var3;
      }
    }
  }

  if(isDefined(var0)) {
    if(!isDefined(self.goalflag) || self.goalflag != var0) {
      self.goalflag = var0;
      scripts\mp\bots\bots_strategy::bot_capture_point(var0.trigger.origin, 100);
      return;
    }

    return;
  }
}