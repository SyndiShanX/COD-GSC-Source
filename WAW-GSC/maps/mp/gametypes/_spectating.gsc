/*********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\gametypes\_spectating.gsc
*********************************************/

init() {
  level.spectateOverride["allies"] = spawnStruct();
  level.spectateOverride["axis"] = spawnStruct();

  level thread onPlayerConnect();
}

onPlayerConnect() {
  for(;;) {
    level waittill("connecting", player);

    player thread onJoinedTeam();
    player thread onJoinedSpectators();
    player thread onPlayerSpawned();
  }
}

onPlayerSpawned() {
  self endon("disconnect");

  for(;;) {
    self waittill("spawned_player");
    self setSpectatePermissions();
  }
}

onJoinedTeam() {
  self endon("disconnect");

  for(;;) {
    self waittill("joined_team");
    self setSpectatePermissions();
  }
}

onJoinedSpectators() {
  self endon("disconnect");

  for(;;) {
    self waittill("joined_spectators");
    self setSpectatePermissions();
  }
}

updateSpectateSettings() {
  level endon("game_ended");

  for(index = 0; index < level.players.size; index++) {
    level.players[index] setSpectatePermissions();
  }
}

getOtherTeam(team) {
  if(team == "axis") {
    return "allies";
  } else if(team == "allies") {
    return "axis";
  } else {
    return "none";
  }
}

setSpectatePermissions() {
  team = self.sessionteam;

  if(team == "spectator") {
    self allowSpectateTeam("allies", true);
    self allowSpectateTeam("axis", true);
    self allowSpectateTeam("freelook", true);
    self allowSpectateTeam("none", true);
    return;
  }

  spectateType = maps\mp\gametypes\_tweakables::getTweakableValue("game", "spectatetype");

  switch (spectateType) {
    case 0:
      self allowSpectateTeam("allies", false);
      self allowSpectateTeam("axis", false);
      self allowSpectateTeam("freelook", false);
      self allowSpectateTeam("none", true);
      break;
    case 1:
      if(!level.teamBased) {
        self allowSpectateTeam("allies", true);
        self allowSpectateTeam("axis", true);
        self allowSpectateTeam("none", true);
        self allowSpectateTeam("freelook", false);
      } else if(isDefined(team) && (team == "allies" || team == "axis")) {
        self allowSpectateTeam(team, true);
        self allowSpectateTeam(getOtherTeam(team), false);
        self allowSpectateTeam("freelook", false);
        self allowSpectateTeam("none", false);
      } else {
        self allowSpectateTeam("allies", false);
        self allowSpectateTeam("axis", false);
        self allowSpectateTeam("freelook", false);
        self allowSpectateTeam("none", false);
      }
      break;
    case 2:
      self allowSpectateTeam("allies", true);
      self allowSpectateTeam("axis", true);
      self allowSpectateTeam("freelook", true);
      self allowSpectateTeam("none", true);
      break;
  }

  if(isDefined(team) && (team == "axis" || team == "allies")) {
    if(isDefined(level.spectateOverride[team].allowFreeSpectate)) {
      self allowSpectateTeam("freelook", true);
    }

    if(isDefined(level.spectateOverride[team].allowEnemySpectate)) {
      self allowSpectateTeam(getOtherTeam(team), true);
    }
  }
}