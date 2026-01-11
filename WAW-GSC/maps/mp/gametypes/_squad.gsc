/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\gametypes\_squad.gsc
*****************************************************/

#include maps\mp\_utility;
#include common_scripts\utility;

init() {
  precacheShader("compass_squad_attack");
  precacheLocationSelector("map_squad_command");
  level thread resetSquadCommands();
  level thread onPlayerConnect();
}

onPlayerConnect() {
  level endon("game_ended");
  for(;;) {
    level waittill("connecting", player);
    player thread onPlayerSpawned();
    player thread onDisconnect();
    player thread doSquadInitialNotification();
  }
}

doSquadInitialNotification() {
  self endon("disconnect");
  level endon("game_ended");
  self waittill("spawned_player");
  wait(10.0);
  if(getplayersquad(self)) {
    if(issquadleader(self)) {
      self.pers["squadMessage"] = 4;
    } else {
      self.pers["squadMessage"] = 5;
    }
    self[[level.showsquadinfo]]();
  }
}

onPlayerSpawned() {
  self endon("disconnect");
  level endon("game_ended");
  for(;;) {
    self waittill_any("spawned_player", "give_map");
    self setSquadFeatures();
  }
}

setSquadFeatures() {
  self giveSquadFeatures();
  self thread squadCommandWaiter();
}

squadCommandWaiter() {
  self endon("death_or_disconnect");
  self thread destroyOnDeath();
  self.lastWeapon = self getCurrentWeapon();
  for(;;) {
    self waittill("weapon_change");
    self.squadId = getplayersquad(self);
    currentWeapon = self getCurrentWeapon();
    if(currentWeapon != "squadcommand_mp" && currentWeapon != "none" && currentWeapon != "artillery_mp" && currentWeapon != "dogs_mp") {
      self.lastWeapon = currentWeapon;
    }
    if(currentWeapon == "squadcommand_mp") {
      self ShowSquadLocationSelectionMap();
      if(self.lastWeapon != "none") {
        self switchToWeapon(self.lastWeapon);
      }
    }
  }
}

giveSquadFeatures() {
  self takeSquadFeatures();
  self SetActionSlot(1, "weapon", "squadcommand_mp");
  self giveWeapon("squadcommand_mp");
}

takeSquadFeatures() {
  self.squadCommandInProgress = undefined;
  self SetActionSlot(1, "");
  if(self hasWeapon("squadcommand_mp")) {
    self takeWeapon("squadcommand_mp");
  }
}

ShowSquadLocationSelectionMap() {
  self beginLocationSelection("map_squad_command");
  self.selectingLocation = true;
  self.squadCommandInProgress = true;
  self thread endSquadCommandSelectionOn("cancel_location");
  self thread endSquadCommandSelectionOn("death");
  self thread endSquadCommandSelectionOn("disconnect");
  self thread endSquadCommandSelectionOnGameEnd();
  currentWeapon = self getCurrentWeapon();
  if(issquadleader(self)) {
    self thread endSquadCommandSelectionOn("used");
    self thread selectConfirmcommand(currentWeapon);
    self thread selectClearcommand(currentWeapon);
  }
  self waittill("stop_location_selection");
  return true;
}

selectConfirmcommand(currentWeapon) {
  self endon("used");
  self waittill("confirm_location", location);
  if(currentWeapon == "squadcommand_mp") {
    self finishSquadCommandUsage(location, "confirm_location", ::useSquadCommand);
  }
}

selectClearcommand(currentWeapon) {
  self endon("used");
  self waittill("clear_squadcommand", location);
  if(currentWeapon == "squadcommand_mp") {
    self finishSquadCommandUsage(location, "clear_squadcommand", ::useSquadCommand);
  }
}

finishSquadCommandUsage(location, command, usedCallback) {
  self stopSquadCommandLocationSelection(false);
  self[[usedCallback]](location, command);
  return true;
}

stopSquadCommandLocationSelection(disconnected) {
  if(!disconnected) {
    self endLocationSelection();
    self.selectingLocation = undefined;
  }
  wait(0.05);
  self notify("stop_location_selection");
}

useSquadCommand(pos, command) {
  pos = (pos[0], pos[1], 0.0);
  self createsquadCommand(pos, command);
  self.squadCommandInProgress = false;
  self notify("used");
  wait(0.05);
}

endSquadCommandSelectionOn(waitfor) {
  self endon("stop_location_selection");
  self waittill(waitfor);
  self stopSquadCommandLocationSelection((waitfor == "disconnect"));
}

endSquadCommandSelectionOnGameEnd() {
  self endon("stop_location_selection");
  level waittill("game_ended");
  self stopSquadCommandLocationSelection(false);
}

createSquadCommand(pos, command) {
  squadId = self.squadId;
  if(command == "clear_squadcommand") {
    clear_objective_squad(squadId);
    obituary_squad(self, 11);
  }
  if(command == "confirm_location") {
    self playVOForSquadCommand();
    objective_squad(pos, squadId);
    obituary_squad(self, 10);
  }
}

playVOForSquadCommand() {
  playerSquadID = getplayersquadid(self);
  if(isDefined(playerSquadID)) {
    team = self.pers["team"];
    for(i = 0; i < level.squads[team][playerSquadID].size; i++) {
      level.squads[team][playerSquadID][i] maps\mp\gametypes\_globallogic::leaderDialogOnPlayer("squad_move");
    }
  }
}

onDisconnect() {
  self endon("disconnect");
  level endon("game_ended");
}

destroyOnDeath() {
  self endon("disconnect");
  self waittill("death");
  self takeSquadFeatures();
}

resetSquadCommands() {
  self waittill("squad_disbanded", squadId);
  self endon("game_ended");
  clear_objective_squad(squadId);
}