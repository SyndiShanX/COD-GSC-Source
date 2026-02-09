/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: mp\teams\_teams.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\mp\_util;
#using scripts\mp\gametypes\_globallogic_ui;
#using scripts\mp\gametypes\_spectating;
#using scripts\shared\callbacks_shared;
#using scripts\shared\persistence_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#namespace teams;

function autoexec __init__sytem__() {
  system::register("teams", &__init__, undefined, undefined);
}

function __init__() {
  callback::on_start_gametype(&init);
  level.getenemyteam = &getenemyteam;
  level.use_team_based_logic_for_locking_on = 1;
}

function init() {
  game["strings"]["autobalance"] = &"MP_AUTOBALANCE_NOW";
  if(getdvarstring("scr_teambalance") == "") {
    setDvar("scr_teambalance", "0");
  }
  level.teambalance = getdvarint("scr_teambalance");
  level.teambalancetimer = 0;
  if(getdvarstring("scr_timeplayedcap") == "") {
    setDvar("scr_timeplayedcap", "1800");
  }
  level.timeplayedcap = int(getdvarint("scr_timeplayedcap"));
  level.freeplayers = [];
  if(level.teambased) {
    level.alliesplayers = [];
    level.axisplayers = [];
    callback::on_connect(&on_player_connect);
    callback::on_joined_team(&on_joined_team);
    callback::on_joined_spectate(&on_joined_spectators);
    level thread update_balance_dvar();
    wait(0.15);
    if(level.onlinegame) {
      level thread update_player_times();
    }
  } else {
    callback::on_connect(&on_free_player_connect);
    wait(0.15);
    if(level.onlinegame) {
      level thread update_player_times();
    }
  }
}

function on_player_connect() {
  self thread track_played_time();
}

function on_free_player_connect() {
  self thread track_free_played_time();
}

function on_joined_team() {
  println("" + self.pers[""]);
  self update_time();
}

function on_joined_spectators() {
  self.pers["teamTime"] = undefined;
}

function track_played_time() {
  self endon("disconnect");
  if(!isDefined(self.pers["totalTimePlayed"])) {
    self.pers["totalTimePlayed"] = 0;
  }
  foreach(team in level.teams) {
    self.timeplayed[team] = 0;
  }
  self.timeplayed["free"] = 0;
  self.timeplayed["other"] = 0;
  self.timeplayed["alive"] = 0;
  if(!isDefined(self.timeplayed["total"]) || (!(level.gametype == "twar" && 0 < game["roundsplayed"] && 0 < self.timeplayed["total"]))) {
    self.timeplayed["total"] = 0;
  }
  while(level.inprematchperiod) {
    wait(0.05);
  }
  for(;;) {
    if(game["state"] == "playing") {
      if(isDefined(level.teams[self.sessionteam])) {
        self.timeplayed[self.sessionteam]++;
        self.timeplayed["total"]++;
        if(level.mpcustommatch) {
          self.pers["sbtimeplayed"] = self.timeplayed["total"];
          self.sbtimeplayed = self.pers["sbtimeplayed"];
        }
        if(isalive(self)) {
          self.timeplayed["alive"]++;
        }
      } else if(self.sessionteam == "spectator") {
        self.timeplayed["other"]++;
      }
    }
    wait(1);
  }
}

function update_player_times() {
  varwait = 10;
  nexttoupdate = 0;
  for(;;) {
    varwait = varwait - 1;
    nexttoupdate++;
    if(nexttoupdate >= level.players.size) {
      nexttoupdate = 0;
      if(varwait > 0) {
        wait(varwait);
      }
      varwait = 10;
    }
    if(isDefined(level.players[nexttoupdate])) {
      level.players[nexttoupdate] update_played_time();
      level.players[nexttoupdate] persistence::check_contract_expirations();
    }
    wait(1);
  }
}

function update_played_time() {
  pixbeginevent("updatePlayedTime");
  if(level.rankedmatch || level.leaguematch) {
    foreach(team in level.teams) {
      if(self.timeplayed[team]) {
        if(level.teambased) {
          self addplayerstat("time_played_" + team, int(min(self.timeplayed[team], level.timeplayedcap)));
        }
        self addplayerstatwithgametype("time_played_total", int(min(self.timeplayed[team], level.timeplayedcap)));
      }
    }
    if(self.timeplayed["other"]) {
      self addplayerstat("time_played_other", int(min(self.timeplayed["other"], level.timeplayedcap)));
      self addplayerstatwithgametype("time_played_total", int(min(self.timeplayed["other"], level.timeplayedcap)));
    }
    if(self.timeplayed["alive"]) {
      timealive = int(min(self.timeplayed["alive"], level.timeplayedcap));
      self persistence::increment_contract_times(timealive);
      self addplayerstat("time_played_alive", timealive);
    }
  }
  if(level.onlinegame) {
    timealive = int(min(self.timeplayed["alive"], level.timeplayedcap));
    self.pers["time_played_alive"] = self.pers["time_played_alive"] + timealive;
  }
  pixendevent();
  if(game["state"] == "postgame") {
    return;
  }
  foreach(team in level.teams) {
    self.timeplayed[team] = 0;
  }
  self.timeplayed["other"] = 0;
  self.timeplayed["alive"] = 0;
}

function update_time() {
  if(game["state"] != "playing") {
    return;
  }
  self.pers["teamTime"] = gettime();
}

function update_balance_dvar() {
  for(;;) {
    teambalance = getdvarint("scr_teambalance");
    if(level.teambalance != teambalance) {
      level.teambalance = getdvarint("scr_teambalance");
    }
    timeplayedcap = getdvarint("scr_timeplayedcap");
    if(level.timeplayedcap != timeplayedcap) {
      level.timeplayedcap = int(getdvarint("scr_timeplayedcap"));
    }
    wait(1);
  }
}

function change(team) {
  if(self.sessionstate != "dead") {
    self.switching_teams = 1;
    self.switchedteamsresetgadgets = 1;
    self.joining_team = team;
    self.leaving_team = self.pers["team"];
    self suicide();
  }
  self.pers["team"] = team;
  self.team = team;
  self.pers["weapon"] = undefined;
  self.pers["spawnweapon"] = undefined;
  self.pers["savedmodel"] = undefined;
  self.pers["teamTime"] = undefined;
  self.sessionteam = self.pers["team"];
  self globallogic_ui::updateobjectivetext();
  self spectating::set_permissions();
  self setclientscriptmainmenu(game["menu_start_menu"]);
  self openmenu(game["menu_start_menu"]);
  self notify("end_respawn");
}

function count_players() {
  players = level.players;
  playercounts = [];
  foreach(team in level.teams) {
    playercounts[team] = 0;
  }
  foreach(player in level.players) {
    if(player == self) {
      continue;
    }
    team = player.pers["team"];
    if(isDefined(team) && isDefined(level.teams[team])) {
      playercounts[team]++;
    }
  }
  return playercounts;
}

function track_free_played_time() {
  self endon("disconnect");
  foreach(team in level.teams) {
    self.timeplayed[team] = 0;
  }
  self.timeplayed["other"] = 0;
  self.timeplayed["total"] = 0;
  self.timeplayed["alive"] = 0;
  for(;;) {
    if(game["state"] == "playing") {
      team = self.pers["team"];
      if(isDefined(team) && isDefined(level.teams[team]) && self.sessionteam != "spectator") {
        self.timeplayed[team]++;
        self.timeplayed["total"]++;
        if(isalive(self)) {
          self.timeplayed["alive"]++;
        }
      } else {
        self.timeplayed["other"]++;
      }
    }
    wait(1);
  }
}

function set_player_model(team, weapon) {
  self detachall();
  self setmovespeedscale(1);
  self setsprintduration(4);
  self setsprintcooldown(0);
}

function get_flag_model(teamref) {
  assert(isDefined(game[""]));
  assert(isDefined(game[""][teamref]));
  return game["flagmodels"][teamref];
}

function get_flag_carry_model(teamref) {
  assert(isDefined(game[""]));
  assert(isDefined(game[""][teamref]));
  return game["carry_flagmodels"][teamref];
}

function getteamindex(team) {
  if(!isDefined(team)) {
    return 0;
  }
  if(team == "free") {
    return 0;
  }
  if(team == "allies") {
    return 1;
  }
  if(team == "axis") {
    return 2;
  }
  return 0;
}

function getenemyteam(player_team) {
  foreach(team in level.teams) {
    if(team == player_team) {
      continue;
    }
    if(team == "spectator") {
      continue;
    }
    return team;
  }
  return util::getotherteam(player_team);
}

function getenemyplayers() {
  enemies = [];
  foreach(player in level.players) {
    if(player.team == "spectator") {
      continue;
    }
    if(level.teambased && player.team != self.team || (!level.teambased && player != self)) {
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

function getfriendlyplayers() {
  friendlies = [];
  foreach(player in level.players) {
    if(player.team == self.team && player != self) {
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

function waituntilteamchange(player, callback, arg, end_condition1, end_condition2, end_condition3) {
  if(isDefined(end_condition1)) {
    self endon(end_condition1);
  }
  if(isDefined(end_condition2)) {
    self endon(end_condition2);
  }
  if(isDefined(end_condition3)) {
    self endon(end_condition3);
  }
  event = player util::waittill_any("joined_team", "disconnect", "joined_spectators");
  if(isDefined(callback)) {
    self[[callback]](arg, event);
  }
}

function waituntilteamchangesingleton(player, singletonstring, callback, arg, end_condition1, end_condition2, end_condition3) {
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
  event = player util::waittill_any("joined_team", "disconnect", "joined_spectators");
  if(isDefined(callback)) {
    self thread[[callback]](arg, event);
  }
}

function hidetosameteam() {
  if(level.teambased) {
    self setvisibletoallexceptteam(self.team);
  } else {
    self setvisibletoall();
    self setinvisibletoplayer(self.owner);
  }
}