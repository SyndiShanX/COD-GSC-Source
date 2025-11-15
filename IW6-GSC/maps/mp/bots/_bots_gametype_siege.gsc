/*************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\bots\_bots_gametype_siege.gsc
*************************************************/

#include common_scripts\utility;
#include maps\mp\_utility;
#include maps\mp\bots\_bots_strategy;

main() {
  setup_callbacks();
  thread bot_siege_manager_think();
  setup_bot_siege();

  thread bot_siege_debug();
}

setup_callbacks() {
  level.bot_funcs["gametype_think"] = ::bot_siege_think;
}

setup_bot_siege() {
  level.bot_gametype_precaching_done = true;
}

bot_siege_debug() {
  while(!isDefined(level.bot_gametype_precaching_done))
    wait(0.05);

  while(1) {
    if(GetDvarInt("bot_debugSiege", 0) == 1) {
      foreach(player in level.participants) {
        if(IsAI(player) && isDefined(player.goalFlag) && isReallyAlive(player)) {
          line(player.origin, player.goalFlag.origin, (0, 255, 0), 1, false, 1);
        }
      }
    }

    wait(0.05);
  }
}

bot_siege_manager_think() {
  level.siege_bot_team_need_flags = [];

  gameFlagWait("prematch_done");

  for(;;) {
    level.siege_bot_team_need_flags = [];
    foreach(player in level.players) {
      if(!isReallyAlive(player) && player.hasSpawned) {
        if(player.team != "spectator" && player.team != "neutral") {
          level.siege_bot_team_need_flags[player.team] = true;
        }
      }
    }

    flagCounts = [];
    foreach(flag in level.flags) {
      team = flag.useObj maps\mp\gametypes\_gameobjects::getOwnerTeam();
      if(team != "neutral") {
        if(!isDefined(flagCounts[team]))
          flagCounts[team] = 1;
        else
          flagCounts[team]++;
      }
    }

    foreach(team, count in flagCounts) {
      if(count >= 2) {
        enemyTeam = getOtherTeam(team);
        level.siege_bot_team_need_flags[enemyTeam] = true;
      }
    }

    wait(1.0);
  }
}

bot_siege_think() {
  self notify("bot_siege_think");
  self endon("bot_siege_think");

  self endon("death");
  self endon("disconnect");
  level endon("game_ended");

  while(!isDefined(level.bot_gametype_precaching_done))
    wait(0.05);
  while(!isDefined(level.siege_bot_team_need_flags))
    wait(0.05);

  self BotSetFlag("separation", 0);
  self BotSetFlag("use_obj_path_style", true);

  for(;;) {
    if(isDefined(level.siege_bot_team_need_flags[self.team]) && level.siege_bot_team_need_flags[self.team]) {
      self bot_choose_flag();
    } else {
      if(isDefined(self.goalFlag)) {
        if(self maps\mp\bots\_bots_util::bot_is_defending())
          self bot_defend_stop();
        self.goalFlag = undefined;
      }
    }

    wait(1.0);
  }
}

bot_choose_flag() {
  goalFlag = undefined;
  shortestDistSq = undefined;

  foreach(flag in level.flags) {
    team = flag.useObj maps\mp\gametypes\_gameobjects::getOwnerTeam();
    if(team != self.team) {
      distToFlagSq = DistanceSquared(self.origin, flag.origin);
      if(!isDefined(shortestDistSq) || distToFlagSq < shortestDistSq) {
        shortestDistSq = distToFlagSq;
        goalFlag = flag;
      }
    }
  }

  if(isDefined(goalFlag)) {
    if(!isDefined(self.goalFlag) || self.goalFlag != goalFlag) {
      self.goalFlag = goalFlag;
      bot_capture_point(goalFlag.origin, 100);
    }
  }
}