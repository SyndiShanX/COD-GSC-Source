/**************************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: zm_common\gametypes\globallogic_ui.gsc
**************************************************/

#using scripts\core_common\callbacks_shared;
#using scripts\core_common\hud_message_shared;
#using scripts\core_common\hud_util_shared;
#using scripts\core_common\player\player_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\gametypes\globallogic;
#using scripts\zm_common\gametypes\globallogic_player;
#using scripts\zm_common\gametypes\spectating;
#using scripts\zm_common\util;
#using scripts\zm_common\zm_loadout;
#namespace globallogic_ui;

function private autoexec __init__system__() {
  system::register(#"globallogic_ui", &preinit, undefined, undefined, undefined);
}

function private preinit() {}

function setupcallbacks() {
  level.autoassign = &menuautoassign;
  level.spectator = &menuspectator;
  level.curclass = &zm_loadout::menuclass;
  level.teammenu = &menuteam;
  level.autocontrolplayer = &menuautocontrolplayer;
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

  foreach(team, _ in level.teams) {
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

  foreach(team, _ in level.teams) {
    if(count > ignore_team[team]) {
      count = ignore_team[team];
      lowest_team = team;
    }
  }

  return lowest_team;
}

function menuautoassign(comingfrommenu) {
  teamkeys = getarraykeys(level.teams);
  assignment = teamkeys[randomint(teamkeys.size)];
  self closemenus();

  if(isDefined(level.forceallallies) && level.forceallallies) {
    assignment = # "allies";
  } else if(level.teambased) {
    if(getdvarint(#"party_autoteams", 0) == 1) {
      if(level.allow_teamchange && (self.hasspawned || comingfrommenu)) {
        assignment = "";
      } else {
        team = getassignedteam(self);

        switch (team) {
          case 1:
            assignment = teamkeys[1];
            break;
          case 2:
            assignment = teamkeys[0];
            break;
          case 3:
            assignment = teamkeys[2];
            break;
          case 4:
            if(!isDefined(level.forceautoassign) || !level.forceautoassign) {
              return;
            }
          default:
            assignment = "";

            if(isDefined(level.teams[team])) {
              assignment = team;
            } else if(team == "spectator" && !level.forceautoassign) {
              return;
            }

            break;
        }
      }
    }

    if(assignment == "" || getdvarint(#"party_autoteams", 0) == 0) {
      assignment = # "allies";
    }

    if(assignment == self.pers[#"team"] && (self.sessionstate == "playing" || self.sessionstate == "dead")) {
      self beginclasschoice();
      return;
    }
  } else if(getdvarint(#"party_autoteams", 0) == 1) {
    if(!level.allow_teamchange || !self.hasspawned && !comingfrommenu) {
      team = getassignedteam(self);

      if(isDefined(level.teams[team])) {
        assignment = team;
      } else if(team == "spectator" && !level.forceautoassign) {
        return;
      }
    }
  }

  if(isDefined(self.botteam) && self.botteam != "autoassign") {
    assignment = self.botteam;
  }

  if(assignment != self.pers[#"team"] && (self.sessionstate == "playing" || self.sessionstate == "dead")) {
    self.switching_teams = 1;
    self.joining_team = assignment;
    self.leaving_team = self.pers[#"team"];
    self suicide();
  }

  self.pers[#"team"] = assignment;
  self.team = assignment;
  self.pers[#"class"] = undefined;
  self.curclass = undefined;
  self.pers[#"weapon"] = undefined;
  self.pers[#"savedmodel"] = undefined;
  self updateobjectivetext();
  self.sessionteam = assignment;

  if(!isalive(self)) {
    self.statusicon = "hud_status_dead";
  }

  self player::function_466d8a4b(comingfrommenu);
  self notify(#"end_respawn");
  self beginclasschoice();
}

function teamscoresequal() {
  score = undefined;

  foreach(team, _ in level.teams) {
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

  foreach(team, _ in level.teams) {
    if(score > getteamscore(team)) {
      lowest_team = team;
    }
  }

  return lowest_team;
}

function pickteamfromscores(teams) {
  assignment = # "allies";

  if(teamscoresequal()) {
    assignment = teams[randomint(teams.size)];
  } else {
    assignment = teamwithlowestscore();
  }

  return assignment;
}

function getsplitscreenteam() {
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
  self setclientcgobjectivetext("");
}

function closemenus() {
  self closeingamemenu();
}

function beginclasschoice(forcenewchoice) {
  assert(isDefined(level.teams[self.pers[#"team"]]));
  team = self.pers[#"team"];
  self.pers[#"class"] = level.defaultclass;
  self.curclass = level.defaultclass;

  if(self.sessionstate != "playing" && game.state == "playing") {
    self thread[[level.spawnclient]]();
  }

  self thread spectating::setspectatepermissionsformachine();
}

function showmainmenuforteam() {
  assert(isDefined(level.teams[self.pers[#"team"]]));
  team = self.pers[#"team"];
  self openmenu(game.menu["menu_changeclass_" + level.teams[team]]);
}

function menuautocontrolplayer() {
  self closemenus();

  if(self.pers[#"team"] != "spectator") {
    toggleplayercontrol(self);
  }
}

function menuteam(team) {
  self closemenus();

  if(!level.console && !level.allow_teamchange && isDefined(self.hasdonecombat) && self.hasdonecombat) {
    return;
  }

  if(self.pers[#"team"] != team) {
    if(level.ingraceperiod && (!isDefined(self.hasdonecombat) || !self.hasdonecombat)) {
      self.hasspawned = 0;
    }

    if(self.sessionstate == "playing") {
      self.switching_teams = 1;
      self.joining_team = team;
      self.leaving_team = self.pers[#"team"];
      self suicide();
    }

    self.pers[#"team"] = team;
    self.team = team;
    self.pers[#"class"] = undefined;
    self.curclass = undefined;
    self.pers[#"weapon"] = undefined;
    self.pers[#"savedmodel"] = undefined;
    self updateobjectivetext();
    self.sessionteam = team;
    self player::function_466d8a4b(1);
    self notify(#"end_respawn");
  }

  self beginclasschoice();
}

function menuspectator() {
  self closemenus();

  if(self.pers[#"team"] != "spectator") {
    if(isalive(self)) {
      self.switching_teams = 1;
      self.joining_team = "spectator";
      self.leaving_team = self.pers[#"team"];
      self suicide();
    }

    self.pers[#"team"] = "spectator";
    self.team = "spectator";
    self.pers[#"class"] = undefined;
    self.curclass = undefined;
    self.pers[#"weapon"] = undefined;
    self.pers[#"savedmodel"] = undefined;
    self updateobjectivetext();
    self.sessionteam = "spectator";
    [[level.spawnspectator]]();
    self thread globallogic_player::spectate_player_watcher();
    self notify(#"joined_spectators");
  }
}

function menuclass(response) {
  self closemenus();
}

function removespawnmessageshortly(delay) {
  self endon(#"disconnect");
  waittillframeend();
  self endon(#"end_respawn");
  wait delay;
  self hud_message::clearlowermessage();
}

function function_bc2eb1b8() {
  self luinotifyevent(#"hash_3ab41287e432bf6c");
}

function function_f8f38932() {
  self luinotifyevent(#"hash_6994832352c6262b");
}