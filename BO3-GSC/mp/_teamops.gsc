/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: mp\_teamops.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\mp\_util;
#using scripts\mp\gametypes\_globallogic_audio;
#using scripts\mp\gametypes\_globallogic_utils;
#using scripts\mp\killstreaks\_killstreaks;
#using scripts\shared\callbacks_shared;
#using scripts\shared\sound_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#namespace teamops;

function getteamopstableid() {
  teamopsinfotableloaded = 0;
  teamopsinfotableid = tablelookupfindcoreasset("gamedata/tables/mp/teamops.csv");
  if(isdefined(teamopsinfotableid)) {
    teamopsinfotableloaded = 1;
  }
  assert(teamopsinfotableloaded, "" + "");
  return teamopsinfotableid;
}

function init() {
  game["teamops"] = spawnstruct();
  game["teamops"].data = [];
  game["teamops"].teamprogress = [];
  game["teamops"].teamopsname = undefined;
  foreach(team in level.teams) {
    game["teamops"].teamprogress[team] = 0;
  }
  level.teamopsonprocessplayerevent = & processplayerevent;
  tableid = getteamopstableid();
  assert(isdefined(tableid));
  if(!isdefined(tableid)) {
    game["teamops"].teamopsinitialed = 0;
    return;
  }
  for (row = 1; row < 256; row++) {
    name = tablelookupcolumnforrow(tableid, row, 0);
    if(name != "") {
      game["teamops"].data[name] = spawnstruct();
      game["teamops"].data[name].description = tablelookupcolumnforrow(tableid, row, 1);
      game["teamops"].data[name].pushevent = tablelookupcolumnforrow(tableid, row, 2);
      game["teamops"].data[name].popevent = tablelookupcolumnforrow(tableid, row, 3);
      game["teamops"].data[name].resetevent = tablelookupcolumnforrow(tableid, row, 4);
      game["teamops"].data[name].count = int(tablelookupcolumnforrow(tableid, row, 5));
      game["teamops"].data[name].time = int(tablelookupcolumnforrow(tableid, row, 6));
      game["teamops"].data[name].modes = strtok(tablelookupcolumnforrow(tableid, row, 7), ",");
      game["teamops"].data[name].rewards = strtok(tablelookupcolumnforrow(tableid, row, 8), ",");
    }
  }
  game["teamops"].teamopsinitialized = 1;
}

function getid(name) {
  tableid = getteamopstableid();
  for (row = 1; row < 256; row++) {
    _name = tablelookupcolumnforrow(tableid, row, 0);
    if(name == _name) {
      return row;
    }
  }
  return 0;
}

function teamopsallowed(name) {
  teamops = game["teamops"].data[name];
  if(teamops.modes.size == 0) {
    return true;
  }
  for (mi = 0; mi < teamops.modes.size; mi++) {
    if(teamops.modes[mi] == level.gametype) {
      return true;
    }
  }
  return false;
}

function startteamops(name) {
  level notify("teamops_starting");
  level.teamopsonplayerkilled = undefined;
  if(!teamopsallowed(name)) {
    return;
  }
  teamopsshowhud(0);
  preanouncetime = getdvarint("teamOpsPreanounceTime", 5);
  foreach(team in level.teams) {
    globallogic_audio::leader_dialog("teamops_preannounce", team);
  }
  wait(preanouncetime);
  for (i = 0; i < level.players.size; i++) {
    player = level.players[i];
    if(isdefined(player)) {
      player playlocalsound("uin_objective_updated");
    }
  }
  teamops = game["teamops"].data[name];
  game["teamops"].teamopsname = name;
  game["teamops"].teamopsid = getid(name);
  game["teamops"].teamopsrewardindex = randomintrange(0, teamops.rewards.size);
  game["teamops"].teamopsreward = teamops.rewards[game["teamops"].teamopsrewardindex];
  game["teamops"].teamopsstarttime = gettime();
  foreach(team in level.teams) {
    game["teamops"].teamprogress[team] = 0;
  }
  wait(0.1);
  teamopsstart(game["teamops"].teamopsid, game["teamops"].teamopsrewardindex, game["teamops"].teamopsstarttime, teamops.time);
  wait(0.1);
  teamopsshowhud(1);
  teamopsupdateprogress("axis", 0);
  teamopsupdateprogress("allies", 0);
  level thread teamopswatcher();
}

function teamopswatcher() {
  while (isdefined(game["teamops"].teamopsname)) {
    time = game["teamops"].data[game["teamops"].teamopsname].time;
    if(isdefined(time) && time > 0) {
      elapsed = gettime() - game["teamops"].teamopsstarttime;
      if(elapsed > (time * 1000)) {
        stopteamops();
        foreach(team in level.teams) {
          globallogic_audio::leader_dialog("teamops_timeout", team);
        }
      }
    }
    wait(0.5);
  }
}

function stopteamops() {
  teamopsshowhud(0);
  game["teamops"].teamopsname = undefined;
  game["teamops"].teamopsreward = undefined;
  game["teamops"].teamopsstarttime = undefined;
  foreach(team in level.teams) {
    game["teamops"].teamprogress[team] = 0;
  }
}

function processplayerevent(event, player) {
  teamopsname = game["teamops"].teamopsname;
  if(isplayer(player) && isdefined(teamopsname)) {
    level processteamevent(event, player, player.team);
  }
}

function processteamevent(event, player, team) {
  teamopsname = game["teamops"].teamopsname;
  teamops = game["teamops"].data[teamopsname];
  if(isdefined(teamops.pushevent) && event == teamops.pushevent) {
    game["teamops"].teamprogress[team] = game["teamops"].teamprogress[team] + 1;
    level updateteamops(event, player, team);
  }
  if(isdefined(teamops.popevent) && event == teamops.popevent) {
    game["teamops"].teamprogress[team] = game["teamops"].teamprogress[team] - 1;
    if(game["teamops"].teamprogress[team] < 0) {
      game["teamops"].teamprogress[team] = 0;
    }
    level updateteamops(event, player, team);
  }
  if(isdefined(teamops.resetevent) && event == teamops.resetevent) {
    game["teamops"].teamprogress[team] = 0;
    level updateteamops(event, player, team);
  }
}

function updateteamops(event, player, team) {
  teamopsname = game["teamops"].teamopsname;
  teamops = game["teamops"].data[teamopsname];
  count_target = teamops.count;
  progress = int((100 * game["teamops"].teamprogress[team]) / count_target);
  teamopsupdateprogress(team, progress);
  if(game["teamops"].teamprogress[team] >= teamops.count) {
    if(isdefined(player)) {
      level thread teamopsacheived(player, team);
    }
  }
}

function teamopsacheived(player, team) {
  game["teamops"].teamopsname = undefined;
  wait(0.5);
  teamopsshowhud(0);
  wait(2);
  globallogic_audio::leader_dialog("teamops_win", team);
  globallogic_audio::leader_dialog_for_other_teams("teamops_lose", team);
  player killstreaks::give(game["teamops"].teamopsreward, 1);
  wait(2);
  player killstreaks::usekillstreak(game["teamops"].teamopsreward, 1);
}

function main() {
  thread watchteamopstime();
  level.teamopstargetkills = getdvarint("teamOpsKillsCountTrigger_" + level.gametype, 37);
  if(level.teamopstargetkills > 0) {
    level.teamopsonplayerkilled = & onplayerkilled;
  }
}

function getcompatibleoperation() {
  operations = strtok(getdvarstring("teamOpsName"), ",");
  for (i = 0; i < 20; i++) {
    operation = operations[randomintrange(0, operations.size)];
    if(teamopsallowed(operation)) {
      return operation;
    }
  }
  for (i = 0; i < operations.size; i++) {
    operation = operations[i];
    if(teamopsallowed(operation)) {
      return operation;
    }
  }
  return undefined;
}

function watchteamopstime() {
  level endon("teamops_starting");
  if(isdefined(level.inprematchperiod) && level.inprematchperiod) {
    level waittill("prematch_over");
  }
  activeteamops = getcompatibleoperation();
  if(!isdefined(activeteamops)) {
    return;
  }
  startdelay = getdvarint("teamOpsStartDelay_" + level.gametype, 300);
  while (true) {
    if(isdefined(game["teamops"].teamopsname)) {
      if(getdvarint("scr_stop_teamops") == 1) {
        stopteamops();
        setdvar("scr_stop_teamops", 0);
      }
    }
    timepassed = globallogic_utils::gettimepassed() / 1000;
    startteamops = 0;
    if(timepassed > startdelay) {
      level thread startteamops(activeteamops);
      break;
    }
    wait(1);
  }
}

function onplayerkilled(einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration) {
  level endon("teamops_starting");
  if(isplayer(attacker) == 0 || attacker.team == self.team) {
    return;
  }
  if(!isdefined(level.teamopskilltracker)) {
    level.teamopskilltracker = [];
  }
  if(!isdefined(level.teamopskilltracker[attacker.team])) {
    level.teamopskilltracker[attacker.team] = 0;
  }
  level.teamopskilltracker[attacker.team]++;
  if(level.teamopskilltracker[attacker.team] >= level.teamopstargetkills) {
    activeteamops = getcompatibleoperation();
    if(!isdefined(activeteamops)) {
      return;
    }
    level thread startteamops(activeteamops);
  }
}