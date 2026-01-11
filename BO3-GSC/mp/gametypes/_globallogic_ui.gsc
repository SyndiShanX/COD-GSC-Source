/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: mp\gametypes\_globallogic_ui.gsc
*************************************************/

#using scripts\mp\_util;
#using scripts\mp\bots\_bot;
#using scripts\mp\gametypes\_globallogic;
#using scripts\mp\gametypes\_globallogic_player;
#using scripts\mp\gametypes\_loadout;
#using scripts\mp\gametypes\_spectating;
#using scripts\mp\killstreaks\_killstreaks;
#using scripts\mp\teams\_teams;
#using scripts\shared\array_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\hud_util_shared;
#using scripts\shared\util_shared;
#namespace globallogic_ui;

function init() {}

function setupcallbacks() {
  level.autoassign = &menuautoassign;
  level.spectator = &menuspectator;
  level.curclass = &menuclass;
  level.teammenu = &menuteam;
}

function freegameplayhudelems() {
  if(isDefined(self.perkicon)) {
    for(numspecialties = 0; numspecialties < level.maxspecialties; numspecialties++) {
      if(isDefined(self.perkicon[numspecialties])) {
        self.perkicon[numspecialties] hud::destroyelem();
        self.perkname[numspecialties] hud::destroyelem();
      }
    }
  }
  if(isDefined(self.perkhudelem)) {
    self.perkhudelem hud::destroyelem();
  }
  if(isDefined(self.killstreakicon)) {
    if(isDefined(self.killstreakicon[0])) {
      self.killstreakicon[0] hud::destroyelem();
    }
    if(isDefined(self.killstreakicon[1])) {
      self.killstreakicon[1] hud::destroyelem();
    }
    if(isDefined(self.killstreakicon[2])) {
      self.killstreakicon[2] hud::destroyelem();
    }
    if(isDefined(self.killstreakicon[3])) {
      self.killstreakicon[3] hud::destroyelem();
    }
    if(isDefined(self.killstreakicon[4])) {
      self.killstreakicon[4] hud::destroyelem();
    }
  }
  if(isDefined(self.lowermessage)) {
    self.lowermessage hud::destroyelem();
  }
  if(isDefined(self.lowertimer)) {
    self.lowertimer hud::destroyelem();
  }
  if(isDefined(self.proxbar)) {
    self.proxbar hud::destroyelem();
  }
  if(isDefined(self.proxbartext)) {
    self.proxbartext hud::destroyelem();
  }
  if(isDefined(self.carryicon)) {
    self.carryicon hud::destroyelem();
  }
}

function teamplayercountsequal(playercounts) {
  count = undefined;
  foreach(team in level.teams) {
    if(!isDefined(count)) {
      count = playercounts[team];
      continue;
    }
    if(count != playercounts[team]) {
      return false;
    }
  }
  return true;
}

function teamwithlowestplayercount(playercounts, ignore_team) {
  count = 9999;
  lowest_team = undefined;
  foreach(team in level.teams) {
    if(count > playercounts[team]) {
      count = playercounts[team];
      lowest_team = team;
    }
  }
  return lowest_team;
}

function shouldbespectatorlatejoin(teamname, comingfrommenu) {
  if(level.rankedmatch) {
    return false;
  }
  if(teamname != "free") {
    return false;
  }
  if(comingfrommenu) {
    return false;
  }
  if(self ishost()) {
    return false;
  }
  if(level.forceautoassign) {
    return false;
  }
  if(self util::is_bot()) {
    return false;
  }
  if(self issplitscreen()) {
    return false;
  }
  return true;
}

function menuautoassign(comingfrommenu) {
  teamkeys = getarraykeys(level.teams);
  assignment = teamkeys[randomint(teamkeys.size)];
  self closemenus();
  self luinotifyevent(&"clear_notification_queue");
  if(level.teambased) {
    if(bot::is_bot_comp_stomp()) {
      host = util::gethostplayerforbots();
      assert(isDefined(host));
      if(!isDefined(host.team) || host.team == "spectator") {
        host.team = array::random(teamkeys);
      }
      if(!self util::is_bot()) {
        assignment = host.team;
      } else {
        assignment = util::getotherteam(host.team);
      }
    } else {
      if(isDefined(level.var_485556b)) {
        assignment = [[level.var_485556b]](self, comingfrommenu);
      } else {
        teamname = getassignedteamname(self);
        if(isDefined(teamname) && teamname != "free" && !comingfrommenu) {
          assignment = teamname;
        } else {
          if(shouldbespectatorlatejoin(teamname, comingfrommenu)) {
            assignment = "spectator";
          } else {
            playercounts = self teams::count_players();
            if(teamplayercountsequal(playercounts)) {
              if(!level.splitscreen && self issplitscreen()) {
                assignment = self get_splitscreen_team();
                if(assignment == "") {
                  assignment = pickteamfromscores(teamkeys);
                }
              } else {
                assignment = pickteamfromscores(teamkeys);
              }
            } else {
              assignment = teamwithlowestplayercount(playercounts, "none");
            }
          }
        }
      }
    }
    if(assignment == self.pers["team"] && (self.sessionstate == "playing" || self.sessionstate == "dead")) {
      self beginclasschoice();
      return;
    }
  } else {
    if(!comingfrommenu) {
      assignment = self.sessionteam;
    } else {
      clientnum = self getentitynumber();
      count = 0;
      foreach(team in level.teams) {
        if(team == "free") {
          continue;
        }
        count++;
        if(count == (clientnum + 1)) {
          assignment = team;
          break;
        }
      }
    }
    if(self.sessionstate == "playing" || self.sessionstate == "dead") {
      return;
    }
  }
  if(assignment == "spectator" && !level.forceautoassign) {
    self.pers["team"] = assignment;
    self.team = assignment;
    self.sessionteam = assignment;
    self setclientscriptmainmenu(game["menu_start_menu"]);
    return;
  }
  if(assignment != self.pers["team"] && (self.sessionstate == "playing" || self.sessionstate == "dead")) {
    self.switching_teams = 1;
    self.switchedteamsresetgadgets = 1;
    self.joining_team = assignment;
    self.leaving_team = self.pers["team"];
    self suicide();
  }
  self.pers["team"] = assignment;
  self.team = assignment;
  self.pers["class"] = undefined;
  self.curclass = undefined;
  self.pers["weapon"] = undefined;
  self.pers["savedmodel"] = undefined;
  self updateobjectivetext();
  self.sessionteam = assignment;
  if(!isalive(self)) {
    self.statusicon = "hud_status_dead";
  }
  self notify("joined_team");
  level notify("joined_team");
  callback::callback("hash_95a6c4c0");
  self notify("end_respawn");
  self beginclasschoice();
  self setclientscriptmainmenu(game["menu_start_menu"]);
}

function teamscoresequal() {
  score = undefined;
  foreach(team in level.teams) {
    if(!isDefined(score)) {
      score = getteamscore(team);
      continue;
    }
    if(score != getteamscore(team)) {
      return false;
    }
  }
  return true;
}

function teamwithlowestscore() {
  score = 99999999;
  lowest_team = undefined;
  foreach(team in level.teams) {
    if(score > getteamscore(team)) {
      lowest_team = team;
    }
  }
  return lowest_team;
}

function pickteamfromscores(teams) {
  assignment = "allies";
  if(teamscoresequal()) {
    assignment = teams[randomint(teams.size)];
  } else {
    assignment = teamwithlowestscore();
  }
  return assignment;
}

function get_splitscreen_team() {
  for(index = 0; index < level.players.size; index++) {
    if(!isDefined(level.players[index])) {
      continue;
    }
    if(level.players[index] == self) {
      continue;
    }
    if(!self isplayeronsamemachine(level.players[index])) {
      continue;
    }
    team = level.players[index].sessionteam;
    if(team != "spectator") {
      return team;
    }
  }
  return "";
}

function updateobjectivetext() {
  if(self.pers["team"] == "spectator") {
    self setclientcgobjectivetext("");
    return;
  }
  if(level.scorelimit > 0 || level.roundscorelimit > 0) {
    self setclientcgobjectivetext(util::getobjectivescoretext(self.pers["team"]));
  } else {
    self setclientcgobjectivetext(util::getobjectivetext(self.pers["team"]));
  }
}

function closemenus() {
  self closeingamemenu();
}

function beginclasschoice() {
  assert(isDefined(level.teams[self.pers[""]]));
  team = self.pers["team"];
  if(level.disableclassselection == 1 || (isDefined(self.disableclassselection) && self.disableclassselection) || getdvarint("migration_soak") == 1) {
    started_waiting = gettime();
    while(!self isstreamerready(-1, 1) && (started_waiting + 90000) > gettime()) {
      wait(0.05);
    }
    self.pers["class"] = level.defaultclass;
    self.curclass = level.defaultclass;
    if(self.sessionstate != "playing" && game["state"] == "playing") {
      self thread[[level.spawnclient]]();
    }
    level thread globallogic::updateteamstatus();
    self thread spectating::set_permissions_for_machine();
    return;
  }
  util::wait_network_frame();
  self openmenu(game["menu_changeclass_" + team]);
}

function showmainmenuforteam() {
  assert(isDefined(level.teams[self.pers[""]]));
  team = self.pers["team"];
  self openmenu(game["menu_changeclass_" + team]);
}

function menuteam(team) {
  self closemenus();
  if(!level.console && level.allow_teamchange == "0" && (isDefined(self.hasdonecombat) && self.hasdonecombat)) {
    return;
  }
  if(self.pers["team"] != team) {
    if(level.ingraceperiod && (!isDefined(self.hasdonecombat) || !self.hasdonecombat)) {
      self.hasspawned = 0;
    }
    if(self.sessionstate == "playing") {
      self.switching_teams = 1;
      self.switchedteamsresetgadgets = 1;
      self.joining_team = team;
      self.leaving_team = self.pers["team"];
      self suicide();
    }
    self luinotifyevent(&"clear_notification_queue");
    self.pers["team"] = team;
    self.team = team;
    self.pers["class"] = undefined;
    self.curclass = undefined;
    self.pers["weapon"] = undefined;
    self.pers["savedmodel"] = undefined;
    self updateobjectivetext();
    if(!level.rankedmatch && !level.leaguematch) {
      self.sessionstate = "spectator";
    }
    self.sessionteam = team;
    self setclientscriptmainmenu(game["menu_start_menu"]);
    self notify("joined_team");
    level notify("joined_team");
    callback::callback("hash_95a6c4c0");
    self notify("end_respawn");
  }
  self beginclasschoice();
}

function menuspectator() {
  self closemenus();
  if(self.pers["team"] != "spectator") {
    if(isalive(self)) {
      self.switching_teams = 1;
      self.switchedteamsresetgadgets = 1;
      self.joining_team = "spectator";
      self.leaving_team = self.pers["team"];
      self suicide();
    }
    self.pers["team"] = "spectator";
    self.team = "spectator";
    self.pers["class"] = undefined;
    self.curclass = undefined;
    self.pers["weapon"] = undefined;
    self.pers["savedmodel"] = undefined;
    self updateobjectivetext();
    self.sessionteam = "spectator";
    [[level.spawnspectator]]();
    self thread globallogic_player::spectate_player_watcher();
    self setclientscriptmainmenu(game["menu_start_menu"]);
    self notify("joined_spectators");
    callback::callback("hash_4c5ae192");
  }
}

function menuclass(response, forcedclass) {
  self closemenus();
  if(!isDefined(self.pers["team"]) || !isDefined(level.teams[self.pers["team"]])) {
    return;
  }
  if(!isDefined(forcedclass)) {
    playerclass = self loadout::getclasschoice(response);
  } else {
    playerclass = forcedclass;
  }
  if(isDefined(self.pers["class"]) && self.pers["class"] == playerclass) {
    return;
  }
  self.pers["changed_class"] = 1;
  self notify("changed_class");
  if(isDefined(self.curclass) && self.curclass == playerclass) {
    self.pers["changed_class"] = 0;
  }
  self.pers["class"] = playerclass;
  self.curclass = playerclass;
  self.pers["weapon"] = undefined;
  if(game["state"] == "postgame") {
    return;
  }
  if(self.sessionstate == "playing") {
    supplystationclasschange = isDefined(self.usingsupplystation) && self.usingsupplystation;
    self.usingsupplystation = 0;
    if(level.ingraceperiod && !self.hasdonecombat || supplystationclasschange) {
      self loadout::setclass(self.pers["class"]);
      self.tag_stowed_back = undefined;
      self.tag_stowed_hip = undefined;
      self loadout::giveloadout(self.pers["team"], self.pers["class"]);
      self killstreaks::give_owned();
    } else if(!self issplitscreen() && !util::function_938b1b6b()) {
      self iprintlnbold(game["strings"]["change_class"]);
    }
  } else {
    if(self.sessionstate != "spectator") {
      if(self isinvehicle()) {
        return;
      }
      if(self isremotecontrolling()) {
        return;
      }
      if(self isweaponviewonlylinked()) {
        return false;
      }
    }
    if(game["state"] == "playing") {
      timepassed = undefined;
      if(isDefined(self.respawntimerstarttime)) {
        timepassed = (gettime() - self.respawntimerstarttime) / 1000;
      }
      self thread[[level.spawnclient]](timepassed);
      self.respawntimerstarttime = undefined;
    }
  }
  level thread globallogic::updateteamstatus();
  self thread spectating::set_permissions_for_machine();
}

function removespawnmessageshortly(delay) {
  self endon("disconnect");
  waittillframeend();
  self endon("end_respawn");
  wait(delay);
  self util::clearlowermessage(2);
}