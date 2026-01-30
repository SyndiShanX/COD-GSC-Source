/***************************************************
 * Decompiled by Alterware and Edited by SyndiShanX
 * Script: maps\mp\gametypes\_menus.gsc
***************************************************/

#include common_scripts\utility;
#include maps\mp\_utility;

init() {
  if(!isDefined(game["gamestarted"])) {
    game["menu_team"] = "team_marinesopfor";
    if(level.multiTeamBased) {
      game["menu_team"] = "team_mt_options";
    }

    game["menu_class"] = "class";
    game["menu_class_allies"] = "class_marines";
    game["menu_class_axis"] = "class_opfor";
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
      }
    }

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
  if(newClassChoice <= 100) {
    if(practiceRoundGame()) {
      newClassChoice = "practice" + newClassChoice;
    } else {
      newClassChoice = "custom" + newClassChoice;
    }
  } else {
    if(newClassChoice <= 200) {
      newClassChoice -= 101;
      newClassChoice = "class" + newClassChoice;
    } else {
      if(newClassChoice <= 206) {
        newClassChoice -= 200;
        newClassChoice = "axis_recipe" + newClassChoice;
      } else {
        newClassChoice = newClassChoice - 206;
        newClassChoice = "allies_recipe" + newClassChoice;
      }
    }
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
    if(isMLGSplitScreen() && self IsMlgSpectator() && !inVirtualLobby()) {
      self SetClientOmnvar("ui_options_menu", 0);
      continue;
    }

    if(!IsTestClient(self) && !IsAI(self)) {
      if(("" + newClass) != "callback") {
        self SetClientOmnvar("ui_loadout_selected", newClass);
      }
    }

    if(isDefined(self.waitingToSelectClass) && self.waitingToSelectClass) {
      continue;
    }

    if(!self allowClassChoice()) {
      continue;
    }

    self SetClientOmnvar("ui_options_menu", 0);

    if(("" + newClass) != "callback") {
      if(IsBot(self) || IsTestClient(self)) {
        self.pers["class"] = newClass;
        self.class = newClass;
        self maps\mp\gametypes\_class::clearCopyCatLoadout();
      } else {
        newClassChoice = newClass + 1;
        newClassChoice = getClassChoice(newClassChoice);

        if(!isDefined(self.pers["class"]) || newClassChoice == self.pers["class"]) {
          continue;
        }

        self.pers["class"] = newClassChoice;
        self.class = newClassChoice;
        self maps\mp\gametypes\_class::clearCopyCatLoadout();

        self thread menuGiveClass();
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

    level thread maps\mp\gametypes\_gamelogic::forceEnd();
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

    if(matchMakingGame() && !getDvarInt("force_ranking")) {
      continue;
    }

    if(teamSelected != 3) {
      self thread showLoadoutMenu();
    }

    if(teamSelected == 3) {
      self setClientOmnvar("ui_options_menu", 0);

      self SetClientOmnvar("ui_spectator_selected", 1);
      self SetClientOmnvar("ui_loadout_selected", -1);
      self.spectating_actively = true;
      if(isMLGSplitScreen()) {
        self SetMlgSpectator(1);
        self SetClientOmnvar("ui_use_mlg_hud", true);
        self thread maps\mp\gametypes\_spectating::setSpectatePermissions();
      }
    } else {
      self SetClientOmnvar("ui_spectator_selected", -1);
      self.spectating_actively = false;
      if(isMLGSplitScreen()) {
        self SetMlgSpectator(0);
        self SetClientOmnvar("ui_use_mlg_hud", false);
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
      self thread[[level.autoassign]]();
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
  if(isCOOP()) {
    self thread setTeam("allies");
    self.sessionteam = "allies";
    return;
  }

  if(!isDefined(self.team)) {
    if(self IsMLGSpectator() && !inVirtualLobby()) {
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

  if(self IsMLGSpectator() && !inVirtualLobby()) {
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

      self maps\mp\gametypes\_playerlogic::spawnClient();
    }

    self thread maps\mp\gametypes\_spectating::setSpectatePermissions();
  }
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

  if(allowClassChoice()) {
    for(;;) {
      self waittill("luinotifyserver", channel, newClass);

      if(channel == "class_select") {
        break;
      }
    }

    if(("" + newClass) != "callback") {
      if(IsBot(self) || IsTestClient(self)) {
        self.pers["class"] = newClass;
        self.class = newClass;
        self maps\mp\gametypes\_class::clearCopyCatLoadout();
      } else {
        newClass = newClass + 1;
        self.pers["class"] = getClassChoice(newClass);
        self.class = getClassChoice(newClass);
        self maps\mp\gametypes\_class::clearCopyCatLoadout();
      }

      self notify("notWaitingToSelectClass");
      self.waitingToSelectClass = false;
    } else {
      self notify("notWaitingToSelectClass");
      self.waitingToSelectClass = false;
      menuClass("callback");
    }
  } else {
    if(!IsAI(self) && showGenericMenuOnMatchStart()) {
      self thread maps\mp\gametypes\_playerlogic::setUIOptionsMenu(3);
      for(;;) {
        self waittill("luinotifyserver", channel, newClass);

        if(channel == "class_select") {
          break;
        }
      }
    }

    self notify("notWaitingToSelectClass");
    self.waitingToSelectClass = false;
    bypassClassChoice();
  }
}

beginClassChoice(forceNewChoice) {
  team = self.pers["team"];
  assert(team == "axis" || team == "allies" || IsSubStr(team, "team_"));

  if(allowClassChoice()) {
    self thread maps\mp\gametypes\_playerlogic::setUIOptionsMenu(2);

    if(!self IsMLGSpectator() || inVirtualLobby()) {
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
  } else {
    self thread bypassClassChoice();
  }
}

bypassClassChoice() {
  self maps\mp\gametypes\_class::clearCopyCatLoadout();

  self.selectedClass = true;
  self.class = "class0";

  if(isDefined(level.bypassClassChoiceFunc)) {
    self[[level.bypassClassChoiceFunc]]();
  }
}

beginTeamChoice() {
  self thread maps\mp\gametypes\_playerlogic::setUIOptionsMenu(1);
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
  self maps\mp\gametypes\_class::clearCopyCatLoadout();

  self thread maps\mp\gametypes\_playerlogic::spawnSpectator();
}

watchHasDoneCombat() {
  if(!self.hasDoneCombat) {
    self endon("death");
    self endon("disconnect");
    self endon("streamClassWeaponsComplete");
    level endon("game_ended");

    self waittill("hasDoneCombat");
    self notify("endStreamClassWeapons");

    self IPrintLnBold(game["strings"]["change_class_cancel"]);
    wait(2.0);
    self iPrintLnBold(game["strings"]["change_class"]);
  }
}

menuGiveClass() {
  if(level.inGracePeriod && !self.hasDoneCombat) {
    self thread maps\mp\gametypes\_playerlogic::streamClassWeapons(true);

    if(self.classWeaponsWait) {
      self endon("death");
      self endon("disconnect");
      level endon("game_ended");
      self endon("endStreamClassWeapons");

      self thread watchHasDoneCombat();

      self IPrintLnBold(game["strings"]["change_class_wait"]);
      println("menuGiveClass(): Waiting for streamClassWeaponsComplete for " + self.name + " at time " + gettime());
      self waittill("streamClassWeaponsComplete");
      println("menuGiveClass(): Finished waiting for streamClassWeaponsComplete for " + self.name + " at time " + gettime());
      self IPrintLnBold("");

      self OnlyStreamActiveWeapon(false);
    }

    self maps\mp\gametypes\_class::setClass(self.pers["class"]);
    self.tag_stowed_back = undefined;
    self.tag_stowed_hip = undefined;
    self maps\mp\gametypes\_class::giveAndApplyLoadout(self.pers["team"], self.pers["class"]);
    if(self _hasPerk("specialty_moreminimap")) {
      SetOmnvar("ui_minimap_extend_grace_period", 1);
    } else {
      SetOmnvar("ui_minimap_extend_grace_period", 0);
    }
  } else {
    self maps\mp\gametypes\_playerlogic::streamClassWeapons();

    self iPrintLnBold(game["strings"]["change_class"]);
  }
}

menuClass(response) {
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
    self maps\mp\gametypes\_class::clearCopyCatLoadout();

    self.pers["primary"] = primary;

    if(game["state"] == "postgame") {
      return;
    }

    self thread menuGiveClass();
  } else {
    if(isDefined(self.pers["lastClass"]) && isDefined(self.pers["class"])) {
      self.pers["lastClass"] = self.pers["class"];
      self.lastClass = self.pers["lastClass"];
    }

    self.pers["class"] = class;
    self.class = class;
    self maps\mp\gametypes\_class::clearCopyCatLoadout();

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

addToTeam(team, firstConnect, changeTeamsWithoutRespawning) {
  if(isDefined(self.team)) {
    self maps\mp\gametypes\_playerlogic::removeFromTeamCount();

    if(isDefined(changeTeamsWithoutRespawning) && changeTeamsWithoutRespawning) {
      self maps\mp\gametypes\_playerlogic::decrementAliveCount(self.team);
    }
  }

  self.pers["team"] = team;

  self.team = team;

  if(!GetDvarInt("party_playersCoop", 0) && (!matchMakingGame() || (IsBot(self) || IsTestClient(self)) || !allowTeamChoice() || getDvarInt("force_ranking"))) {
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