/**********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\mp\bots\gametype_siege.gsc
**********************************************/

main() {
  setup_callbacks();
  thread bot_siege_manager_think();
  setup_bot_siege();
}

setup_callbacks() {
  level.bot_funcs["gametype_think"] = ::bot_siege_think;
}

setup_bot_siege() {
  level.bot_gametype_precaching_done = 1;
}

bot_siege_manager_think() {
  level.siege_bot_team_need_flags = [];
  scripts\mp\utility::gameflagwait("prematch_done");
  for(;;) {
    level.siege_bot_team_need_flags = [];
    foreach(var_1 in level.players) {
      if(!scripts\mp\utility::isreallyalive(var_1) && var_1.hasspawned) {
        if(var_1.team != "spectator" && var_1.team != "neutral") {
          level.siege_bot_team_need_flags[var_1.team] = 1;
        }
      }
    }

    var_3 = [];
    foreach(var_5 in level.magicbullet) {
      var_6 = var_5.useobj scripts\mp\gameobjects::getownerteam();
      if(var_6 != "neutral") {
        if(!isDefined(var_3[var_6])) {
          var_3[var_6] = 1;
          continue;
        }

        var_3[var_6]++;
      }
    }

    foreach(var_6, var_9 in var_3) {
      if(var_9 >= 2) {
        var_10 = scripts\mp\utility::getotherteam(var_6);
        level.siege_bot_team_need_flags[var_10] = 1;
      }
    }

    wait(1);
  }
}

bot_siege_think() {
  self notify("bot_siege_think");
  self endon("bot_siege_think");
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  while(!isDefined(level.bot_gametype_precaching_done)) {
    wait(0.05);
  }

  while(!isDefined(level.siege_bot_team_need_flags)) {
    wait(0.05);
  }

  self botsetflag("separation", 0);
  self botsetflag("use_obj_path_style", 1);
  for(;;) {
    if(isDefined(level.siege_bot_team_need_flags[self.team]) && level.siege_bot_team_need_flags[self.team]) {
      bot_choose_flag();
    } else if(isDefined(self.goalflag)) {
      if(scripts\mp\bots\_bots_util::bot_is_defending()) {
        scripts\mp\bots\_bots_strategy::bot_defend_stop();
      }

      self.goalflag = undefined;
    }

    wait(1);
  }
}

bot_choose_flag() {
  var_0 = undefined;
  var_1 = undefined;
  foreach(var_3 in level.magicbullet) {
    var_4 = var_3.useobj scripts\mp\gameobjects::getownerteam();
    if(var_4 != self.team) {
      var_5 = distancesquared(self.origin, var_3.origin);
      if(!isDefined(var_1) || var_5 < var_1) {
        var_1 = var_5;
        var_0 = var_3;
      }
    }
  }

  if(isDefined(var_0)) {
    if(!isDefined(self.goalflag) || self.goalflag != var_0) {
      self.goalflag = var_0;
      scripts\mp\bots\_bots_strategy::bot_capture_point(var_0.origin, 100);
    }
  }
}