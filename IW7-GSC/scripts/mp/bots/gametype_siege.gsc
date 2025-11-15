/**********************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
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
    foreach(var_01 in level.players) {
      if(!scripts\mp\utility::isreallyalive(var_01) && var_01.hasspawned) {
        if(var_01.team != "spectator" && var_01.team != "neutral") {
          level.siege_bot_team_need_flags[var_01.team] = 1;
        }
      }
    }

    var_03 = [];
    foreach(var_05 in level.magicbullet) {
      var_06 = var_05.useobj scripts\mp\gameobjects::getownerteam();
      if(var_06 != "neutral") {
        if(!isDefined(var_03[var_06])) {
          var_03[var_06] = 1;
          continue;
        }

        var_03[var_06]++;
      }
    }

    foreach(var_06, var_09 in var_03) {
      if(var_09 >= 2) {
        var_0A = scripts\mp\utility::getotherteam(var_06);
        level.siege_bot_team_need_flags[var_0A] = 1;
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
  var_00 = undefined;
  var_01 = undefined;
  foreach(var_03 in level.magicbullet) {
    var_04 = var_03.useobj scripts\mp\gameobjects::getownerteam();
    if(var_04 != self.team) {
      var_05 = distancesquared(self.origin, var_03.origin);
      if(!isDefined(var_01) || var_05 < var_01) {
        var_01 = var_05;
        var_00 = var_03;
      }
    }
  }

  if(isDefined(var_00)) {
    if(!isDefined(self.goalflag) || self.goalflag != var_00) {
      self.goalflag = var_00;
      scripts\mp\bots\_bots_strategy::bot_capture_point(var_00.origin, 100);
    }
  }
}