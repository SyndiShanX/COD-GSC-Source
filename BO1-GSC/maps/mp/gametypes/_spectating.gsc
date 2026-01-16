/*********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\gametypes\_spectating.gsc
*********************************************/

init() {
  level.spectateOverride["allies"] = spawnstruct();
  level.spectateOverride["axis"] = spawnstruct();
  level thread onPlayerConnect();
}
onPlayerConnect() {
  for (;;) {
    level waittill("connecting", player);
    player thread onJoinedTeam();
    player thread onJoinedSpectators();
    player thread onPlayerSpawned();
  }
}
onPlayerSpawned() {
  self endon("disconnect");
  for (;;) {
    self waittill("spawned_player");
    self setSpectatePermissions();
  }
}
onJoinedTeam() {
  self endon("disconnect");
  for (;;) {
    self waittill("joined_team");
    self setSpectatePermissionsForMachine();
  }
}
onJoinedSpectators() {
  self endon("disconnect");
  for (;;) {
    self waittill("joined_spectators");
    self setSpectatePermissionsForMachine();
  }
}
updateSpectateSettings() {
  level endon("game_ended");
  for (index = 0; index < level.players.size; index++)
    level.players[index] setSpectatePermissions();
}
getOtherTeam(team) {
  if(team == "axis")
    return "allies";
  else if(team == "allies")
    return "axis";
  else
    return "none";
}
getSplitscreenTeam() {
  for (index = 0; index < level.players.size; index++) {
    if(!isDefined(level.players[index]))
      continue;
    if(level.players[index] == self)
      continue;
    if(!(self IsPlayerOnSameMachine(level.players[index])))
      continue;
    team = level.players[index].sessionteam;
    if(team != "spectator")
      return team;
  }
  return self.sessionteam;
}
OtherLocalPlayerStillAlive() {
  for (index = 0; index < level.players.size; index++) {
    if(!isDefined(level.players[index]))
      continue;
    if(level.players[index] == self)
      continue;
    if(!(self IsPlayerOnSameMachine(level.players[index])))
      continue;
    if(IsAlive(level.players[index]))
      return true;
  }
  return false;
}
setSpectatePermissions() {
  team = self.sessionteam;
  if(team == "spectator") {
    if(self IsSplitScreen() && !level.splitscreen) {
      team = getSplitscreenTeam();
    }
    if(team == "spectator") {
      self allowSpectateTeam("allies", true);
      self allowSpectateTeam("axis", true);
      self allowSpectateTeam("freelook", true);
      self allowSpectateTeam("none", true);
      self allowSpectateTeam("localplayers", true);
      return;
    }
  }
  spectateType = maps\mp\gametypes\_tweakables::getTweakableValue("game", "spectatetype");
  switch (spectateType) {
    case 0:
      self allowSpectateTeam("allies", false);
      self allowSpectateTeam("axis", false);
      self allowSpectateTeam("freelook", false);
      self allowSpectateTeam("none", true);
      self allowSpectateTeam("localplayers", false);
      break;
    case 3:
      if(self IsSplitScreen() && self OtherLocalPlayerStillAlive()) {
        self allowSpectateTeam("allies", false);
        self allowSpectateTeam("axis", false);
        self allowSpectateTeam("none", false);
        self allowSpectateTeam("freelook", false);
        self allowSpectateTeam("localplayers", true);
        break;
      }
    case 1:
      if(!level.teamBased) {
        self allowSpectateTeam("allies", true);
        self allowSpectateTeam("axis", true);
        self allowSpectateTeam("none", true);
        self allowSpectateTeam("freelook", false);
        self allowSpectateTeam("localplayers", true);
      } else if(isDefined(team) && (team == "allies" || team == "axis")) {
        self allowSpectateTeam(team, true);
        self allowSpectateTeam(getOtherTeam(team), false);
        self allowSpectateTeam("freelook", false);
        self allowSpectateTeam("none", false);
        self allowSpectateTeam("localplayers", true);
      } else {
        self allowSpectateTeam("allies", false);
        self allowSpectateTeam("axis", false);
        self allowSpectateTeam("freelook", false);
        self allowSpectateTeam("none", false);
        self allowSpectateTeam("localplayers", true);
      }
      break;
    case 2:
      self allowSpectateTeam("allies", true);
      self allowSpectateTeam("axis", true);
      self allowSpectateTeam("freelook", true);
      self allowSpectateTeam("none", true);
      self allowSpectateTeam("localplayers", true);
      break;
  }
  if(isDefined(team) && (team == "axis" || team == "allies")) {
    if(isDefined(level.spectateOverride[team].allowFreeSpectate))
      self allowSpectateTeam("freelook", true);
    if(isDefined(level.spectateOverride[team].allowEnemySpectate))
      self allowSpectateTeam(getOtherTeam(team), true);
  }
}
setSpectatePermissionsForMachine() {
  self setSpectatePermissions();
  if(!self IsSplitScreen())
    return;
  for (index = 0; index < level.players.size; index++) {
    if(!isDefined(level.players[index]))
      continue;
    if(level.players[index] == self)
      continue;
    if(!(self IsPlayerOnSameMachine(level.players[index])))
      continue;
    level.players[index] setSpectatePermissions();
  }
}