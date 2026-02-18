/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: zm_common\gametypes\spectating.gsc
***********************************************/

#using scripts\core_common\callbacks_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#namespace spectating;

function private autoexec __init__system__() {
  system::register(#"zm_spectating", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  callback::on_start_gametype(&main);
}

function main() {
  foreach(team, _ in level.teams) {
    level.spectateoverride[team] = spawnStruct();
  }

  callback::on_connecting(&on_player_connecting);
}

function on_player_connecting() {
  callback::on_joined_team(&on_joined_team);
  callback::on_spawned(&on_player_spawned);
  callback::on_joined_spectate(&on_joined_spectate);
}

function on_player_spawned() {
  self endon(#"disconnect");
  self setspectatepermissions();
}

function on_joined_team(params) {
  self endon(#"disconnect");
  self setspectatepermissionsformachine();
}

function on_joined_spectate(params) {
  self endon(#"disconnect");
  self setspectatepermissionsformachine();
}

function updatespectatesettings() {
  level endon(#"game_ended");

  for(index = 0; index < level.players.size; index++) {
    level.players[index] setspectatepermissions();
  }
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

  return self.sessionteam;
}

function otherlocalplayerstillalive() {
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

    if(isalive(level.players[index])) {
      return true;
    }
  }

  return false;
}

function allowspectateallteams(allow) {
  foreach(team, _ in level.teams) {
    self allowspectateteam(team, allow);
  }
}

function allowspectateallteamsexceptteam(skip_team, allow) {
  foreach(team, _ in level.teams) {
    if(team == skip_team) {
      continue;
    }

    self allowspectateteam(team, allow);
  }
}

function setspectatepermissions() {
  team = self.sessionteam;

  if(team == "spectator") {
    if(self issplitscreen() && !level.splitscreen) {
      team = getsplitscreenteam();
    }

    if(team == "spectator") {
      self allowspectateallteams(1);
      self allowspectateteam("freelook", 0);
      self allowspectateteam("none", 1);
      self allowspectateteam("localplayers", 1);
      return;
    }
  }

  spectatetype = level.spectatetype;

  switch (spectatetype) {
    case 0:
      self allowspectateallteams(0);
      self allowspectateteam("freelook", 0);
      self allowspectateteam("none", 1);
      self allowspectateteam("localplayers", 0);
      break;
    case 3:
      if(self issplitscreen() && self otherlocalplayerstillalive()) {
        self allowspectateallteams(0);
        self allowspectateteam("none", 0);
        self allowspectateteam("freelook", 0);
        self allowspectateteam("localplayers", 1);
        break;
      }
    case 1:
      if(!level.teambased) {
        self allowspectateallteams(1);
        self allowspectateteam("none", 1);
        self allowspectateteam("freelook", 0);
        self allowspectateteam("localplayers", 1);
      } else if(isDefined(team) && isDefined(level.teams[team])) {
        self allowspectateteam(team, 1);
        self allowspectateallteamsexceptteam(team, 0);
        self allowspectateteam("freelook", 0);
        self allowspectateteam("none", 0);
        self allowspectateteam("localplayers", 1);
      } else {
        self allowspectateallteams(0);
        self allowspectateteam("freelook", 0);
        self allowspectateteam("none", 0);
        self allowspectateteam("localplayers", 1);
      }

      break;
    case 2:
      self allowspectateallteams(1);
      self allowspectateteam("freelook", 1);
      self allowspectateteam("none", 1);
      self allowspectateteam("localplayers", 1);
      break;
  }

  if(isDefined(team) && isDefined(level.teams[team])) {
    if(isDefined(level.spectateoverride[team].allowfreespectate)) {
      self allowspectateteam("freelook", 1);
    }

    if(isDefined(level.spectateoverride[team].allowenemyspectate)) {
      self allowspectateallteamsexceptteam(team, 1);
    }
  }
}

function setspectatepermissionsformachine() {
  self setspectatepermissions();

  if(!self issplitscreen()) {
    return;
  }

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

    level.players[index] setspectatepermissions();
  }
}