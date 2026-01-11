/****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\gametypes\_menus.gsc
****************************************/

#include common_scripts\utility;
#include maps\mp\_utility;

init() {
  if(!isDefined(game["gamestarted"])) {
    game["menu_team"] = "team_marinesopfor";
    if(level.multiTeamBased) {
      game["menu_team"] = "team_mt_options";
    }

    if(bot_is_fireteam_mode()) {
      level.fireteam_menu = "class_commander_" + level.gametype;
      game["menu_class"] = level.fireteam_menu;
      game["menu_class_allies"] = level.fireteam_menu;
      game["menu_class_axis"] = level.fireteam_menu;
    } else {
      game["menu_class"] = "class";
      game["menu_class_allies"] = "class_marines";
      game["menu_class_axis"] = "class_opfor";
    }

    game["menu_changeclass_allies"] = "changeclass_marines";
    game["menu_changeclass_axis"] = "changeclass_opfor";

    if(level.multiTeamBased) {
      for(i = 0; i < level.teamNameList.size; i++) {
        str_menu_class = "menu_class_" + level.teamNameList[i];
        str_menu_changeclass = "menu_changeclass_" + level.teamNameList[i];
        game[str_menu_class] = game["menu_class_allies"];
        game[str_menu_changeclass] = "changeclass_marines";
      }
    }

    game["menu_changeclass"] = "changeclass";

    if(level.console) {
      game["menu_controls"] = "ingame_controls";

      if(level.splitscreen) {
        if(level.multiTeamBased) {
          for(i = 0; i < level.teamNameList.size; i++) {
            str_menu_class = "menu_class_" + level.teamNameList[i];
            str_menu_changeclass = "menu_changeclass_" + level.teamNameList[i];
            game[str_menu_class] += "_splitscreen";
            game[str_menu_changeclass] += "_splitscreen";
          }
        }

        game["menu_team"] += "_splitscreen";
        game["menu_class_allies"] += "_splitscreen";
        game["menu_class_axis"] += "_splitscreen";
        game["menu_changeclass_allies"] += "_splitscreen";
        game["menu_changeclass_axis"] += "_splitscreen";
        game["menu_controls"] += "_splitscreen";

        game["menu_changeclass_defaults_splitscreen"] = "changeclass_splitscreen_defaults";
        game["menu_changeclass_custom_splitscreen"] = "changeclass_splitscreen_custom";

        precacheMenu(game["menu_changeclass_defaults_splitscreen"]);
        precacheMenu(game["menu_changeclass_custom_splitscreen"]);
      }

      precacheMenu(game["menu_controls"]);
    }

    precacheMenu(game["menu_team"]);
    precacheMenu(game["menu_class_allies"]);
    precacheMenu(game["menu_class_axis"]);
    precacheMenu(game["menu_changeclass"]);
    precacheMenu(game["menu_changeclass_allies"]);
    precacheMenu(game["menu_changeclass_axis"]);

    PrecacheMenu(game["menu_class"]);

    precacheString(&"MP_HOST_ENDED_GAME");
    precacheString(&"MP_HOST_ENDGAME_RESPONSE");
  }

  level thread onPlayerConnect();
}

onPlayerConnect() {
  for(;;) {
    level waittill("connected", player);

    player thread watchForClassChange();
    player thread watchForTeamChange();
    player thread watchForLeaveGame();
    player thread connectedMenus();
  }
}

connectedMenus() {
  println("do stuff");
}

getClassChoice(newClassChoice) {
  if(newClassChoice > 10) {
    if(newClassChoice > 10 && newClassChoice < 17) {
      newClassChoice = newClassChoice - 10;
      newClassChoice = "axis_recipe" + newClassChoice;
    } else if(newClassChoice > 16 && newClassChoice < 23) {
      newClassChoice = newClassChoice - 16;
      newClassChoice = "allies_recipe" + newClassChoice;
    }
  } else {
    newClassChoice = "custom" + newClassChoice;
  }

  return newClassChoice;
}

watchForClassChange() {
  self endon("disconnect");
  level endon("game_ended");

  for(;;) {
    self waittill("luinotifyserver", channel, newClass);

    if(channel != "class_select") {
      continue;
    }
    if(GetDvarInt("systemlink") && GetDvarInt("xblive_competitionmatch") && self IsMlgSpectator()) {
      self SetClientOmnvar("ui_options_menu", 0);
      continue;
    }

    isThisATestClient = (isAI(self) || IsSubStr(self.name, "tcBot"));

    if(!isThisATestClient) {
      if(!isAI(self) && (("" + newClass) != "callback")) {
        self SetClientOmnvar("ui_loadout_selected", newClass);
      }
    }

    if(isDefined(self.waitingToSelectClass) && self.waitingToSelectClass) {
      continue;
    }
    if(!self allowClassChoice() || showFakeLoadout()) {
      continue;
    }
    if(("" + newClass) != "callback") {
      if(isDefined(self.pers["isBot"]) && self.pers["isBot"]) {
        self.pers["class"] = newClass;
        self.class = newClass;
      } else {
        newClassChoice = newClass + 1;
        newClassChoice = getClassChoice(newClassChoice);

        if(!isDefined(self.pers["class"]) || newClassChoice == self.pers["class"]) {
          continue;
        }
        self.pers["class"] = newClassChoice;
        self.class = newClassChoice;

        if(level.inGracePeriod && !self.hasDoneCombat) {
          self maps\mp\gametypes\_class::setClass(self.pers["class"]);
          self.tag_stowed_back = undefined;
          self.tag_stowed_hip = undefined;
          self maps\mp\gametypes\_class::giveLoadout(self.pers["team"], self.pers["class"]);
        } else {
          if(isAlive(self)) {
            self iPrintLnBold(game["strings"]["change_class"]);
          }
        }
      }
    } else {
      menuClass("callback");
    }
  }
}

watchForLeaveGame() {
  self endon("disconnect");
  level endon("game_ended");

  for(;;) {
    self waittill("luinotifyserver", channel, val);

    if(channel != "end_game") {
      continue;
    }
    if(is_aliens()) {
      [
        [level.forceEndGame_Alien]
      ]();
    } else {
      level thread maps\mp\gametypes\_gamelogic::forceEnd(val);
    }
  }
}

watchForTeamChange() {
  self endon("disconnect");
  level endon("game_ended");

  for(;;) {
    self waittill("luinotifyserver", channel, teamSelected);

    if(channel != "team_select") {
      continue;
    }
    if(matchMakingGame()) {
      continue;
    }
    if(teamSelected != 3) {
      self thread showLoadoutMenu();
    }

    if(teamSelected == 3) {
      self SetClientOmnvar("ui_spectator_selected", 1);
      self SetClientOmnvar("ui_loadout_selected", -1);
      self.spectating_actively = true;

      if(GetDvarInt("systemlink") && GetDvarInt("xblive_competitionmatch")) {
        self SetMlgSpectator(1);
        self.pers["mlgSpectator"] = true;
        self thread maps\mp\gametypes\_spectating::setMLGCamVisibility(true);
        self thread maps\mp\gametypes\_spectating::setSpectatePermissions();

        self SetClientOmnvar("ui_options_menu", 2);
      }

    } else {
      self SetClientOmnvar("ui_spectator_selected", -1);
      self.spectating_actively = false;
      if(GetDvarInt("systemlink") && GetDvarInt("xblive_competitionmatch")) {
        self SetMlgSpectator(0);
        self.pers["mlgSpectator"] = false;
        self thread maps\mp\gametypes\_spectating::setMLGCamVisibility(false);
      }
    }

    self SetClientOmnvar("ui_team_selected", teamSelected);

    if(teamSelected == 0) {
      teamSelected = "axis";
    } else if(teamSelected == 1) {
      teamSelected = "allies";
    } else if(teamSelected == 2) {
      teamSelected = "random";
    } else {
      teamSelected = "spectator";
    }

    if(isDefined(self.pers["team"]) && teamSelected == self.pers["team"]) {
      self notify("selected_same_team");
      continue;
    }

    self SetClientOmnvar("ui_loadout_selected", -1);

    if(teamSelected == "axis") {
      self thread setTeam("axis");
    } else if(teamSelected == "allies") {
      self thread setTeam("allies");
    } else if(teamSelected == "random") {
      self thread autoAssign();
    } else if(teamSelected == "spectator") {
      self thread setSpectator();
    }
  }
}

showLoadoutMenu() {
  self endon("disconnect");
  level endon("game_ended");

  self waittill_any("joined_team", "selected_same_team");

  self SetClientOmnvar("ui_options_menu", 2);
}

autoAssign() {
  if(is_aliens() || level.gameType == "infect") {
    self thread setTeam("allies");
    return;
  }

  if((GetDvarInt("squad_match") == 1 || GetDvarInt("squad_vs_squad") == 1 || GetDvarInt("squad_use_hosts_squad") == 1) && isDefined(self.bot_team)) {
    self thread setTeam(self.bot_team);
    return;
  }

  if(!isDefined(self.team)) {
    if(self IsMLGSpectator()) {
      self thread setSpectator();
    } else if(level.teamcount["axis"] < level.teamcount["allies"]) {
      self thread setTeam("axis");
    } else if(level.teamcount["allies"] < level.teamcount["axis"]) {
      self thread setTeam("allies");
    } else {
      if(GetTeamScore("allies") > GetTeamScore("axis")) {
        self thread setTeam("axis");
      } else {
        self thread setTeam("allies");
      }
    }
    return;
  }

  if(self IsMLGSpectator()) {
    self thread setSpectator();
  } else if(level.teamcount["axis"] < level.teamcount["allies"] && self.team != "axis") {
    self thread setTeam("axis");
  } else if(level.teamcount["allies"] < level.teamcount["axis"] && self.team != "allies") {
    self thread setTeam("allies");
  } else if(level.teamcount["allies"] == level.teamcount["axis"]) {
    if(GetTeamScore("allies") > GetTeamScore("axis") && self.team != "axis") {
      self thread setTeam("axis");
    } else if(self.team != "allies") {
      self thread setTeam("allies");
    }
  }
}

setTeam(selection) {
  self endon("disconnect");

  if(!IsAI(self) && level.teamBased && !maps\mp\gametypes\_teams::getJoinTeamPermissions(selection)) {
    return;
    /# println( "cant change teams here... would be good to handle this logic in menu" );
  }

  if(level.inGracePeriod && !self.hasDoneCombat) {
    self.hasSpawned = false;
  }

  if(self.sessionstate == "playing") {
    self.switching_teams = true;
    self.joining_team = selection;
    self.leaving_team = self.pers["team"];
  }

  self addToTeam(selection);

  if(self.sessionstate == "playing") {
    self suicide();
  }

  self waitForClassSelect();

  self endRespawnNotify();

  if(self.sessionstate == "spectator") {
    if(game["state"] == "postgame") {
      return;
    }
    if(game["state"] == "playing" && !isInKillcam()) {
      if(isDefined(self.waitingToSpawnAmortize) && self.waitingToSpawnAmortize) {
        return;
      }
      self thread maps\mp\gametypes\_playerlogic::spawnClient();
    }

    self thread maps\mp\gametypes\_spectating::setSpectatePermissions();
  }

  self notify("okToSpawn");
}

setSpectator() {
  if(isDefined(self.pers["team"]) && self.pers["team"] == "spectator") {
    return;
  }
  if(isAlive(self)) {
    assert(isDefined(self.pers["team"]));
    self.switching_teams = true;
    self.joining_team = "spectator";
    self.leaving_team = self.pers["team"];
    self suicide();
  }

  self notify("becameSpectator");
  self addToTeam("spectator");
  self.pers["class"] = undefined;
  self.class = undefined;

  self thread maps\mp\gametypes\_playerlogic::spawnSpectator();
}

waitForClassSelect() {
  self endon("disconnect");
  level endon("game_ended");

  self.waitingToSelectClass = true;

  for(;;) {
    if(allowClassChoice() || (showFakeLoadout() && !isAI(self))) {
      self waittill("luinotifyserver", channel, newClass);
    } else {
      bypassClassChoice();
      break;
    }

    if(channel != "class_select") {
      continue;
    }
    if(self.team == "spectator") {
      continue;
    }
    if(("" + newClass) != "callback") {
      if(isDefined(self.pers["isBot"]) && self.pers["isBot"]) {
        self.pers["class"] = newClass;
        self.class = newClass;
      } else {
        newClass = newClass + 1;
        self.pers["class"] = getClassChoice(newClass);
        self.class = getClassChoice(newClass);
      }

      self.waitingToSelectClass = false;
    } else {
      self.waitingToSelectClass = false;
      menuClass("callback");
    }
    break;
  }
}

beginClassChoice(forceNewChoice) {
  team = self.pers["team"];
  assert(team == "axis" || team == "allies" || IsSubStr(team, "team_"));

  if(allowClassChoice() || (showFakeLoadout() && !isAI(self))) {
    self SetClientOmnvar("ui_options_menu", 2);

    if(!self IsMLGSpectator()) {
      self waitForClassSelect();
    }

    self endRespawnNotify();

    if(self.sessionstate == "spectator") {
      if(game["state"] == "postgame") {
        return;
      }
      if(game["state"] == "playing" && !isInKillcam()) {
        if(isDefined(self.waitingToSpawnAmortize) && self.waitingToSpawnAmortize) {
          return;
        }
        self thread maps\mp\gametypes\_playerlogic::spawnClient();
      }

      self thread maps\mp\gametypes\_spectating::setSpectatePermissions();
    }

    self.connectTime = getTime();
    self notify("okToSpawn");
  } else
    self thread bypassClassChoice();

  if(!isAlive(self)) {
    self thread maps\mp\gametypes\_playerlogic::predictAboutToSpawnPlayerOverTime(0.1);
  }
}

bypassClassChoice() {
  self.selectedClass = true;
  self.waitingToSelectClass = false;

  if(isDefined(level.bypassClassChoiceFunc)) {
    class_choice = self[[level.bypassClassChoiceFunc]]();
    self.class = class_choice;
  } else {
    self.class = "class0";
  }
}

beginTeamChoice() {
  self SetClientOmnvar("ui_options_menu", 1);
}

showMainMenuForTeam() {
  assert(self.pers["team"] == "axis" || self.pers["team"] == "allies");

  team = self.pers["team"];

  self openpopupMenu(game["menu_class_" + team]);
}

menuSpectator() {
  if(isDefined(self.pers["team"]) && self.pers["team"] == "spectator") {
    return;
  }
  if(isAlive(self)) {
    assert(isDefined(self.pers["team"]));
    self.switching_teams = true;
    self.joining_team = "spectator";
    self.leaving_team = self.pers["team"];
    self suicide();
  }

  self addToTeam("spectator");
  self.pers["class"] = undefined;
  self.class = undefined;

  self thread maps\mp\gametypes\_playerlogic::spawnSpectator();
}

menuClass(response) {
  if(response == "demolitions_mp,0" && self GetRankedPlayerData("featureNew", "demolitions")) {
    self setRankedPlayerData("featureNew", "demolitions", false);
  }
  if(response == "sniper_mp,0" && self GetRankedPlayerData("featureNew", "sniper")) {
    self setRankedPlayerData("featureNew", "sniper", false);
  }

  assert(isDefined(self.pers["team"]));
  team = self.pers["team"];
  assert(team == "allies" || team == "axis" || IsSubStr(team, "team_"));

  class = self maps\mp\gametypes\_class::getClassChoice(response);
  primary = self maps\mp\gametypes\_class::getWeaponChoice(response);

  if(class == "restricted") {
    self beginClassChoice();
    return;
  }

  if((isDefined(self.pers["class"]) && self.pers["class"] == class) &&
    (isDefined(self.pers["primary"]) && self.pers["primary"] == primary)) {
    return;
  }
  if(self.sessionstate == "playing") {
    if(isDefined(self.pers["lastClass"]) && isDefined(self.pers["class"])) {
      self.pers["lastClass"] = self.pers["class"];
      self.lastClass = self.pers["lastClass"];
    }

    self.pers["class"] = class;
    self.class = class;
    self.pers["primary"] = primary;

    if(game["state"] == "postgame") {
      return;
    }
    if(level.inGracePeriod && !self.hasDoneCombat) {
      self maps\mp\gametypes\_class::setClass(self.pers["class"]);
      self.tag_stowed_back = undefined;
      self.tag_stowed_hip = undefined;
      self maps\mp\gametypes\_class::giveLoadout(self.pers["team"], self.pers["class"]);
    } else {
      self iPrintLnBold(game["strings"]["change_class"]);
    }
  } else {
    if(isDefined(self.pers["lastClass"]) && isDefined(self.pers["class"])) {
      self.pers["lastClass"] = self.pers["class"];
      self.lastClass = self.pers["lastClass"];
    }

    self.pers["class"] = class;
    self.class = class;
    self.pers["primary"] = primary;

    if(game["state"] == "postgame") {
      return;
    }
    if(game["state"] == "playing" && !isInKillcam()) {
      self thread maps\mp\gametypes\_playerlogic::spawnClient();
    }
  }

  self thread maps\mp\gametypes\_spectating::setSpectatePermissions();
}

update_wargame_after_migration() {
  foreach(player in level.players) {
    if(!isAI(player) && player isHost()) {
      level.wargame_client = player;
    }
  }
}

addToTeam(team, firstConnect, changeTeamsWithoutRespawning) {
  if(isDefined(self.team)) {
    self maps\mp\gametypes\_playerlogic::removeFromTeamCount();

    if(isDefined(changeTeamsWithoutRespawning) && changeTeamsWithoutRespawning) {
      self maps\mp\gametypes\_playerlogic::decrementAliveCount(self.team);
    }
  }

  self.pers["team"] = team;

  self.team = team;

  if((GetDvar("squad_vs_squad") == "1")) {
    if(!isAI(self)) {
      if(team == "allies") {
        if(!isDefined(level.squad_vs_squad_allies_client)) {
          level.squad_vs_squad_allies_client = self;
        }
      } else if(team == "axis") {
        if(!isDefined(level.squad_vs_squad_axis_client)) {
          level.squad_vs_squad_axis_client = self;
        }
      }
    }
  }

  if((GetDvar("squad_match") == "1")) {
    if(!isAI(self) && self isHost()) {
      if(!isDefined(level.squad_match_client)) {
        level.squad_match_client = self;
      }
    }
  }

  if((GetDvar("squad_use_hosts_squad") == "1")) {
    if(!isAI(self) && self isHost()) {
      if(!isDefined(level.wargame_client)) {
        level.wargame_client = self;
      }
    }
  }

  if(!matchMakingGame() || isDefined(self.pers["isBot"]) || !allowTeamChoice()) {
    if(level.teamBased) {
      self.sessionteam = team;
    } else {
      if(team == "spectator") {
        self.sessionteam = "spectator";
      } else {
        self.sessionteam = "none";
      }
    }
  }

  if(game["state"] != "postgame") {
    self maps\mp\gametypes\_playerlogic::addToTeamCount();

    if(isDefined(changeTeamsWithoutRespawning) && changeTeamsWithoutRespawning) {
      self maps\mp\gametypes\_playerlogic::incrementAliveCount(self.team);
    }
  }

  self updateObjectiveText();

  if(isDefined(firstConnect) && firstConnect) {
    waittillframeend;
  }

  self updateMainMenu();

  if(team == "spectator") {
    self notify("joined_spectators");
    level notify("joined_team", self);
  } else {
    self notify("joined_team");
    level notify("joined_team", self);
  }
}

endRespawnNotify() {
  self.waitingToSpawn = false;
  self notify("end_respawn");
}