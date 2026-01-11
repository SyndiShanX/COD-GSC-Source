/*************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\gametypes\_globallogic_ui.gsc
*************************************************/

#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;

init() {
  precacheString(&"MP_HALFTIME");
  precacheString(&"MP_OVERTIME");
  precacheString(&"MP_ROUNDEND");
  precacheString(&"MP_INTERMISSION");
  precacheString(&"MP_SWITCHING_SIDES_CAPS");
  precacheString(&"MP_FRIENDLY_FIRE_WILL_NOT");
  if(level.splitScreen) {
    precacheString(&"MP_ENDED_GAME");
  }
  else {
    precacheString(&"MP_HOST_ENDED_GAME");
  }
}
SetupCallbacks() {
  level.autoassign = ::menuAutoAssign;
  level.spectator = ::menuSpectator;
  level.class = ::menuClass;
  level.allies = ::menuAllies;
  level.axis = ::menuAxis;
}
hideLoadoutAfterTime(delay) {
  self endon("disconnect");
  self endon("perks_hidden");
  wait delay;
  self thread hidePerk(0, 0.4);
  self thread hidePerk(1, 0.4);
  self thread hidePerk(2, 0.4);
  self thread hidePerk(3, 0.4);
  self notify("perks_hidden");
}
hideLoadoutOnDeath() {
  self endon("disconnect");
  self endon("perks_hidden");
  self waittill("death");
  self hidePerk(0);
  self hidePerk(1);
  self hidePerk(2);
  self notify("perks_hidden");
}
hideLoadoutOnKill() {
  self endon("disconnect");
  self endon("death");
  self endon("perks_hidden");
  self waittill("killed_player");
  self hidePerk(0);
  self hidePerk(1);
  self hidePerk(2);
  self hidePerk(3);
  self notify("perks_hidden");
}
freeGameplayHudElems() {
  if(isDefined(self.perkicon)) {
    if(isDefined(self.perkicon[0])) {
      self.perkicon[0] destroyElem();
      self.perkname[0] destroyElem();
    }
    if(isDefined(self.perkicon[1])) {
      self.perkicon[1] destroyElem();
      self.perkname[1] destroyElem();
    }
    if(isDefined(self.perkicon[2])) {
      self.perkicon[2] destroyElem();
      self.perkname[2] destroyElem();
    }
    if(isDefined(self.perkicon[3])) {
      self.perkicon[3] destroyElem();
      self.perkname[3] destroyElem();
    }
  }
  if(isDefined(self.killstreakicon)) {
    if(isDefined(self.killstreakicon[0])) {
      self.killstreakicon[0] destroyElem();
    }
    if(isDefined(self.killstreakicon[1])) {
      self.killstreakicon[1] destroyElem();
    }
    if(isDefined(self.killstreakicon[2])) {
      self.killstreakicon[2] destroyElem();
    }
    if(isDefined(self.killstreakicon[3])) {
      self.killstreakicon[3] destroyElem();
    }
    if(isDefined(self.killstreakicon[4])) {
      self.killstreakicon[4] destroyElem();
    }
  }
  self notify("perks_hidden");
  if(isDefined(self.lowerMessage)) {
    self.lowerMessage destroyElem();
  }
  if(isDefined(self.lowerTimer)) {
    self.lowerTimer destroyElem();
  }
  if(isDefined(self.proxBar)) {
    self.proxBar destroyElem();
  }
  if(isDefined(self.proxBarText)) {
    self.proxBarText destroyElem();
  }
  if(isDefined(self.carryIcon)) {
    self.carryIcon destroyElem();
  }
}
menuAutoAssign() {
  teams[0] = "allies";
  teams[1] = "axis";
  assignment = teams[randomInt(2)];
  self closeMenus();
  if(level.teamBased) {
    if(level.console && GetDvarInt(#"party_autoteams") == 1) {
      if(level.allow_teamchange == "1" && self.hasSpawned) {
        assignment = "";
      } else {
        teamNum = getAssignedTeam(self);
        switch (teamNum) {
          case 1:
            assignment = teams[1];
            break;
          case 2:
            assignment = teams[0];
            break;
          default:
            assignment = "";
        }
      }
    }
    if(assignment == "" || GetDvarInt(#"party_autoteams") == 0) {
      playerCounts = self maps\mp\gametypes\_teams::CountPlayers();
      if(playerCounts["allies"] == playerCounts["axis"]) {
        if(!level.splitscreen && self IsSplitScreen()) {
          assignment = self getSplitscreenTeam();
          if(assignment == "") {
            assignment = pickTeamFromScores(teams);
          }
        } else {
          assignment = pickTeamFromScores(teams);
        }
      } else if(playerCounts["allies"] < playerCounts["axis"]) {
        assignment = "allies";
      } else {
        assignment = "axis";
      }
    }
    if(assignment == self.pers["team"] && (self.sessionstate == "playing" || self.sessionstate == "dead")) {
      self beginClassChoice();
      return;
    }
  }
  if(assignment != self.pers["team"] && (self.sessionstate == "playing" || self.sessionstate == "dead")) {
    self.switching_teams = true;
    self.joining_team = assignment;
    self.leaving_team = self.pers["team"];
    self suicide();
  }
  self.pers["team"] = assignment;
  self.team = assignment;
  self.pers["class"] = undefined;
  self.class = undefined;
  self.pers["weapon"] = undefined;
  self.pers["savedmodel"] = undefined;
  self updateObjectiveText();
  if(level.teamBased) {
    self.sessionteam = assignment;
  }
  else {
    self.sessionteam = "none";
    self.ffateam = assignment;
  }
  if(!isAlive(self)) {
    self.statusicon = "hud_status_dead";
  }
  self notify("joined_team");
  level notify("joined_team");
  self notify("end_respawn");
  if(isPregame()) {
    if(!self is_bot()) {
      pclass = self maps\mp\gametypes\_pregame::get_pregame_class();
      self closeMenu();
      self closeInGameMenu();
      self.selectedClass = true;
      self[[level.class]](pclass);
      self setclientdvar("g_scriptMainMenu", game["menu_class_" + self.pers["team"]]);
      return;
    }
  }
  if(isPregameGameStarted()) {
    if(self is_bot() && isDefined(self.pers["class"])) {
      pclass = self.pers["class"];
      self closeMenu();
      self closeInGameMenu();
      self.selectedClass = true;
      self[[level.class]](pclass);
      return;
    }
  }
  self beginClassChoice();
  self setclientdvar("g_scriptMainMenu", game["menu_class_" + self.pers["team"]]);
}
pickTeamFromScores(teams) {
  assignment = "allies";
  if(getTeamScore("allies") == getTeamScore("axis")) {
    assignment = teams[randomInt(2)];
  }
  else if(getTeamScore("allies") < getTeamScore("axis")) {
    assignment = "allies";
  }
  else {
    assignment = "axis";
  }
  return assignment;
}
getSplitscreenTeam() {
  for(index = 0; index < level.players.size; index++) {
    if(!isDefined(level.players[index])) {
      continue;
    }
    if(level.players[index] == self) {
      continue;
    }
    if(!(self IsPlayerOnSameMachine(level.players[index]))) {
      continue;
    }
    team = level.players[index].sessionteam;
    if(team != "spectator") {
      return team;
    }
  }
  return "";
}
updateObjectiveText() {
  if(self.pers["team"] == "spectator") {
    self setClientDvar("cg_objectiveText", "");
    return;
  }
  if(level.scorelimit > 0) {
    if(level.splitScreen) {
      self setclientdvar("cg_objectiveText", getObjectiveScoreText(self.pers["team"]));
    }
    else {
      self setclientdvar("cg_objectiveText", getObjectiveScoreText(self.pers["team"]), level.scorelimit);
    }
  } else {
    self setclientdvar("cg_objectiveText", getObjectiveText(self.pers["team"]));
  }
}
closeMenus() {
  self closeMenu();
  self closeInGameMenu();
}
beginClassChoice(forceNewChoice) {
  assert(self.pers["team"] == "axis" || self.pers["team"] == "allies");
  team = self.pers["team"];
  if(level.oldschool || (GetDvarInt(#"scr_disable_cac") == 1)) {
    self.pers["class"] = level.defaultClass;
    self.class = level.defaultClass;
    if(self.sessionstate != "playing" && game["state"] == "playing") {
      self thread[[level.spawnClient]]();
    }
    level thread maps\mp\gametypes\_globallogic::updateTeamStatus();
    self thread maps\mp\gametypes\_spectating::setSpectatePermissionsForMachine();
    return;
  }
  if(level.wagerMatch) {
    self openMenu(game["menu_changeclass_wager"]);
  } else if(maps\mp\gametypes\_customClasses::isUsingCustomGameModeClasses()) {
    self openMenu(game["menu_changeclass_custom"]);
  } else if(GetDvarInt(#"barebones_class_mode")) {
    self openMenu(game["menu_changeclass_barebones"]);
  } else {
    self openMenu(game["menu_changeclass_" + team]);
  }
}
showMainMenuForTeam() {
  assert(self.pers["team"] == "axis" || self.pers["team"] == "allies");
  team = self.pers["team"];
  if(level.wagerMatch) {
    self openMenu(game["menu_changeclass_wager"]);
  } else if(maps\mp\gametypes\_customClasses::isUsingCustomGameModeClasses()) {
    self openMenu(game["menu_changeclass_custom"]);
  } else {
    self openMenu(game["menu_changeclass_" + team]);
  }
}
menuAllies() {
  self closeMenus();
  if(!level.console && level.allow_teamchange == "0" && (isDefined(self.hasDoneCombat) && self.hasDoneCombat)) {
    return;
  }
  if(self.pers["team"] != "allies") {
    if(level.inGracePeriod && (!isDefined(self.hasDoneCombat) || !self.hasDoneCombat)) {
      self.hasSpawned = false;
    }
    if(self.sessionstate == "playing") {
      self.switching_teams = true;
      self.joining_team = "allies";
      self.leaving_team = self.pers["team"];
      self suicide();
    }
    self.pers["team"] = "allies";
    self.team = "allies";
    self.pers["class"] = undefined;
    self.class = undefined;
    self.pers["weapon"] = undefined;
    self.pers["savedmodel"] = undefined;
    self updateObjectiveText();
    if(level.teamBased) {
      self.sessionteam = "allies";
    }
    else {
      self.sessionteam = "none";
      self.ffateam = "allies";
    }
    self setclientdvar("g_scriptMainMenu", game["menu_class_allies"]);
    self notify("joined_team");
    level notify("joined_team");
    self notify("end_respawn");
  }
  self beginClassChoice();
}
menuAxis() {
  self closeMenus();
  if(!level.console && level.allow_teamchange == "0" && (isDefined(self.hasDoneCombat) && self.hasDoneCombat)) {
    return;
  }
  if(self.pers["team"] != "axis") {
    if(level.inGracePeriod && (!isDefined(self.hasDoneCombat) || !self.hasDoneCombat)) {
      self.hasSpawned = false;
    }
    if(self.sessionstate == "playing") {
      self.switching_teams = true;
      self.joining_team = "axis";
      self.leaving_team = self.pers["team"];
      self suicide();
    }
    self.pers["team"] = "axis";
    self.team = "axis";
    self.pers["class"] = undefined;
    self.class = undefined;
    self.pers["weapon"] = undefined;
    self.pers["savedmodel"] = undefined;
    self updateObjectiveText();
    if(level.teamBased) {
      self.sessionteam = "axis";
    }
    else {
      self.sessionteam = "none";
      self.ffateam = "axis";
    }
    self setclientdvar("g_scriptMainMenu", game["menu_class_axis"]);
    self notify("joined_team");
    level notify("joined_team");
    self notify("end_respawn");
  }
  self beginClassChoice();
}
menuSpectator() {
  self closeMenus();
  if(self.pers["team"] != "spectator") {
    if(isAlive(self)) {
      self.switching_teams = true;
      self.joining_team = "spectator";
      self.leaving_team = self.pers["team"];
      self suicide();
    }
    self.pers["team"] = "spectator";
    self.team = "spectator";
    self.pers["class"] = undefined;
    self.class = undefined;
    self.pers["weapon"] = undefined;
    self.pers["savedmodel"] = undefined;
    self updateObjectiveText();
    self.sessionteam = "spectator";
    if(!level.teamBased) {
      self.ffateam = "spectator";
    }
    [[level.spawnSpectator]]();
    self setclientdvar("g_scriptMainMenu", game["menu_team"]);
    self notify("joined_spectators");
  }
}
menuClass(response) {
  self closeMenus();
  assert(!level.oldschool);
  if(!isDefined(self.pers["team"]) || (self.pers["team"] != "allies" && self.pers["team"] != "axis")) {
    return;
  }
  class = self maps\mp\gametypes\_class::getClassChoice(response);
  primary = self maps\mp\gametypes\_class::getWeaponChoice(response);
  if(class == "restricted") {
    self beginClassChoice();
    return;
  }
  if((isDefined(self.pers["class"]) && self.pers["class"] == class) &&
    (isDefined(self.pers["primary"]) && self.pers["primary"] == primary))
    return;
  self notify("changed_class");
  self maps\mp\gametypes\_gametype_variants::OnPlayerClassChange();
  if(isPregame()) {
    self maps\mp\gametypes\_pregame::OnPlayerClassChange(response);
  }
  if(self.sessionstate == "playing") {
    self.pers["class"] = class;
    self.class = class;
    self.pers["primary"] = primary;
    self.pers["weapon"] = undefined;
    if(game["state"] == "postgame") {
      return;
    }
    supplyStationClassChange = isDefined(self.usingSupplyStation) && self.usingSupplyStation;
    self.usingSupplyStation = false;
    if((level.inGracePeriod && !self.hasDoneCombat) || supplyStationClassChange) {
      self maps\mp\gametypes\_class::setClass(self.pers["class"]);
      self.tag_stowed_back = undefined;
      self.tag_stowed_hip = undefined;
      self maps\mp\gametypes\_class::giveLoadout(self.pers["team"], self.pers["class"]);
      self maps\mp\gametypes\_hardpoints::giveOwnedKillstreak();
    } else if(!level.splitScreen) {
      notifyData = spawnStruct();
      self DisplayGameModeMessage(game["strings"]["change_class"], "uin_alert_slideout");
    }
  } else {
    self.pers["class"] = class;
    self.class = class;
    self.pers["primary"] = primary;
    self.pers["weapon"] = undefined;
    if(game["state"] == "postgame") {
      return;
    }
    if(self.sessionstate != "spectator") {
      if(self IsInVehicle()) {
        return;
      }
      if(self IsRemoteControlling()) {
        return;
      }
    }
    if(game["state"] == "playing") {
      self thread[[level.spawnClient]]();
    }
  }
  level thread maps\mp\gametypes\_globallogic::updateTeamStatus();
  self thread maps\mp\gametypes\_spectating::setSpectatePermissionsForMachine();
}
removeSpawnMessageShortly(delay) {
  self endon("disconnect");
  waittillframeend;
  self endon("end_respawn");
  wait delay;
  self clearLowerMessage(2.0);
}
setObjectiveText(team, text) {
  game["strings"]["objective_" + team] = text;
  precacheString(text);
}
setObjectiveScoreText(team, text) {
  game["strings"]["objective_score_" + team] = text;
  precacheString(text);
}
setObjectiveHintText(team, text) {
  game["strings"]["objective_hint_" + team] = text;
  precacheString(text);
}
getObjectiveText(team) {
  return game["strings"]["objective_" + team];
}
getObjectiveScoreText(team) {
  return game["strings"]["objective_score_" + team];
}
getObjectiveHintText(team) {
  return game["strings"]["objective_hint_" + team];
}
