/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp_common\teams\teams.gsc
***********************************************/

#include scripts\core_common\callbacks_shared;
#include scripts\core_common\gamestate;
#include scripts\core_common\persistence_shared;
#include scripts\core_common\player\player_stats;
#include scripts\core_common\spectating;
#include scripts\core_common\struct;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\mp_common\gametypes\globallogic_ui;
#include scripts\mp_common\util;

#namespace teams;

autoexec __init__system__() {
  system::register(#"teams", &__init__, undefined, undefined);
}

__init__() {
  callback::on_start_gametype(&init);
  level.getenemyteam = &getenemyteam;
  level.use_team_based_logic_for_locking_on = 1;
}

init() {
  game.strings[#"autobalance"] = #"mp/autobalance_now";
  level.teambalance = getdvarint(#"scr_teambalance", 0);
  level.teambalancetimer = 0;
  level.timeplayedcap = getdvarint(#"scr_timeplayedcap", 1800);
  level.freeplayers = [];

  if(level.teambased) {
    level.alliesplayers = [];
    level.axisplayers = [];
    callback::on_connect(&on_player_connect);
    callback::on_joined_team(&on_joined_team);
    callback::on_joined_spectate(&on_joined_spectators);
    level thread update_balance_dvar();
    wait 0.15;
    level thread update_player_times();
    level thread function_badbaae6();
    return;
  }

  callback::on_connect(&on_free_player_connect);
  wait 0.15;
  level thread update_player_times();
}

on_player_connect() {
  self init_played_time();
}

on_free_player_connect() {
  self thread track_free_played_time();
}

on_joined_team(params) {
  self update_time();
}

on_joined_spectators(params) {
  self.pers[#"teamtime"] = undefined;
}

init_played_time() {
  if(!isDefined(self.pers[#"totaltimeplayed"])) {
    self.pers[#"totaltimeplayed"] = 0;
  }

  self.timeplayed[#"free"] = 0;
  self.timeplayed[#"other"] = 0;
  self.timeplayed[#"alive"] = 0;

  if(!isDefined(self.timeplayed[#"total"]) || !(level.gametype == "twar" && 0 < game.roundsplayed && 0 < self.timeplayed[#"total"])) {
    self.timeplayed[#"total"] = 0;
  }
}

function_badbaae6() {
  level endon(#"game_ended");

  while(level.inprematchperiod) {
    waitframe(1);
  }

  for(;;) {
    if(game.state == "playing") {
      function_351a57a9();
    }

    wait 1;
  }
}

update_player_times() {
  nexttoupdate = 0;

  for(;;) {
    nexttoupdate++;

    if(nexttoupdate >= level.players.size) {
      nexttoupdate = 0;
    }

    if(isDefined(level.players[nexttoupdate])) {
      level.players[nexttoupdate] update_played_time();
    }

    wait 1;
  }
}

update_played_time() {
  pixbeginevent(#"updateplayedtime");

  if(!isDefined(self.timeplayed)) {
    self.timeplayed = [];
  }

  foreach(team, str_team in level.teams) {
    if(isDefined(self.timeplayed[team]) && self.timeplayed[team]) {
      time = int(min(self.timeplayed[team], level.timeplayedcap));

      if(sessionmodeismultiplayergame()) {
        if(level.teambased) {
          self stats::function_dad108fa(#"time_played_" + str_team, time);
        }

        if(isDefined(level.hardcoremode) && level.hardcoremode) {
          hc_time_played = self stats::get_stat(#"playerstatslist", #"hc_time_played", #"statvalue") + time;
          self stats::set_stat(#"playerstatslist", #"hc_time_played", #"statvalue", hc_time_played);
        }
      }

      self stats::function_bb7eedf0(#"time_played_total", time);
    }
  }

  if(self.timeplayed[#"other"]) {
    time = int(min(self.timeplayed[#"other"], level.timeplayedcap));
    self stats::function_dad108fa(#"time_played_other", time);
    self stats::function_bb7eedf0(#"time_played_other", time);
  }

  if(self.timeplayed[#"alive"]) {
    timealive = int(min(self.timeplayed[#"alive"], level.timeplayedcap));
    self stats::function_dad108fa(#"time_played_alive", timealive);
  }

  timealive = int(min(self.timeplayed[#"alive"], level.timeplayedcap));
  self.pers[#"time_played_alive"] += timealive;
  pixendevent();

  if(gamestate::is_game_over()) {
    return;
  }

  foreach(team, _ in level.teams) {
    if(isDefined(self.timeplayed[team])) {
      self.timeplayed[team] = 0;
    }
  }

  self.timeplayed[#"other"] = 0;
  self.timeplayed[#"alive"] = 0;
}

update_time() {
  if(game.state != "playing") {
    return;
  }

  self.pers[#"teamtime"] = gettime();
}

update_balance_dvar() {
  for(;;) {
    level.teambalance = getdvarint(#"scr_teambalance", 0);
    level.timeplayedcap = getdvarint(#"scr_timeplayedcap", 1800);
    wait 1;
  }
}

change(team) {
  if(self.sessionstate != "dead") {
    self.switching_teams = 1;
    self.switchedteamsresetgadgets = 1;
    self.joining_team = team;
    self.leaving_team = self.pers[#"team"];
    self suicide();
  }

  self.pers[#"team"] = team;
  self.team = team;
  self.pers[#"spawnweapon"] = undefined;
  self.pers[#"savedmodel"] = undefined;
  self.pers[#"teamtime"] = undefined;
  self.sessionteam = self.pers[#"team"];
  self globallogic_ui::updateobjectivetext();
  self spectating::set_permissions();
  self openmenu(game.menu[#"menu_start_menu"]);
  self notify(#"end_respawn");
}

count_players() {
  players = level.players;
  playercounts = [];

  foreach(team, _ in level.teams) {
    playercounts[team] = 0;
  }

  foreach(player in level.players) {
    if(player == self) {
      continue;
    }

    team = player.pers[#"team"];

    if(isDefined(team) && isDefined(level.teams[team])) {
      playercounts[team]++;
    }
  }

  return playercounts;
}

track_free_played_time() {
  self endon(#"disconnect");

  if(!isDefined(self.timeplayed)) {
    self.timeplayed = [];
  }

  foreach(team, _ in level.teams) {
    if(isDefined(self.timeplayed[team])) {
      self.timeplayed[team] = 0;
    }
  }

  self.timeplayed[#"other"] = 0;
  self.timeplayed[#"total"] = 0;
  self.timeplayed[#"alive"] = 0;

  for(;;) {
    if(game.state == "playing") {
      team = self.pers[#"team"];

      if(isDefined(team) && isDefined(level.teams[team]) && self.sessionteam != #"spectator") {
        if(!isDefined(self.timeplayed[team])) {
          self.timeplayed[team] = 0;
        }

        self.timeplayed[team]++;
        self.timeplayed[#"total"]++;

        if(isalive(self)) {
          self.timeplayed[#"alive"]++;
        }
      } else {
        self.timeplayed[#"other"]++;
      }
    }

    wait 1;
  }
}

get_flag_model(teamref) {
  assert(isDefined(game.flagmodels));
  assert(isDefined(game.flagmodels[teamref]));
  return game.flagmodels[teamref];
}

get_flag_carry_model(teamref) {
  assert(isDefined(game.carry_flagmodels));
  assert(isDefined(game.carry_flagmodels[teamref]));
  return game.carry_flagmodels[teamref];
}

getteamindex(team) {
  if(!isDefined(team)) {
    return 0;
  }

  if(team == #"free") {
    return 0;
  }

  if(team == #"allies") {
    return 1;
  }

  if(team == #"axis") {
    return 2;
  }

  return 0;
}

getenemyteam(player_team) {
  foreach(team, _ in level.teams) {
    if(team == player_team) {
      continue;
    }

    if(team == #"spectator") {
      continue;
    }

    return team;
  }

  return util::getotherteam(player_team);
}

getenemyplayers() {
  enemies = [];

  foreach(player in level.players) {
    if(player.team == #"spectator") {
      continue;
    }

    if(level.teambased && player util::isenemyteam(self.team) || !level.teambased && player != self) {
      if(!isDefined(enemies)) {
        enemies = [];
      } else if(!isarray(enemies)) {
        enemies = array(enemies);
      }

      enemies[enemies.size] = player;
    }
  }

  return enemies;
}

getfriendlyplayers() {
  friendlies = [];

  foreach(player in level.players) {
    if(!player util::isenemyteam(self.team) && player != self) {
      if(!isDefined(friendlies)) {
        friendlies = [];
      } else if(!isarray(friendlies)) {
        friendlies = array(friendlies);
      }

      friendlies[friendlies.size] = player;
    }
  }

  return friendlies;
}

waituntilteamchange(player, callback, arg, end_condition1, end_condition2, end_condition3) {
  if(isDefined(end_condition1)) {
    self endon(end_condition1);
  }

  if(isDefined(end_condition2)) {
    self endon(end_condition2);
  }

  if(isDefined(end_condition3)) {
    self endon(end_condition3);
  }

  event = player waittill(#"joined_team", #"disconnect", #"joined_spectators");

  if(isDefined(callback)) {
    self[[callback]](arg, event);
  }
}

waituntilteamchangesingleton(player, singletonstring, callback, arg, end_condition1, end_condition2, end_condition3) {
  self notify(singletonstring);
  self endon(singletonstring);

  if(isDefined(end_condition1)) {
    self endon(end_condition1);
  }

  if(isDefined(end_condition2)) {
    self endon(end_condition2);
  }

  if(isDefined(end_condition3)) {
    self endon(end_condition3);
  }

  event = player waittill(#"joined_team", #"disconnect", #"joined_spectators");

  if(isDefined(callback)) {
    self thread[[callback]](arg, event);
  }
}

hidetosameteam() {
  if(isDefined(self)) {
    if(level.teambased) {
      self setvisibletoallexceptteam(self.team);
      return;
    }

    self setvisibletoall();

    if(isDefined(self.owner)) {
      self setinvisibletoplayer(self.owner);
    }
  }
}

function_9dd75dad(team) {
  return level.everexisted[team];
}

is_all_dead(team) {
  if(level.playerlives[team]) {
    return false;
  }

  if(level.alivecount[team]) {
    return false;
  }

  return true;
}

function_596bfb16() {
  foreach(team, _ in level.teams) {
    if(level.alivecount[team]) {
      game.everexisted[team] = 1;
      level.var_4ad4bec3 = 1;

      if(level.everexisted[team] == 0) {
        level.everexisted[team] = gettime();
      }
    }
  }

  if(getdvarint(#"hash_79f55d595a926104", 0)) {
    foreach(team, _ in level.teams) {
      game.everexisted[team] = 0;
      level.everexisted[team] = 0;
    }
  }

}