/****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\gametypes\_teams.gsc
****************************************/

#include maps\mp\_utility;
#include common_scripts\utility;

FACTION_REF_COL = 0;
FACTION_NAME_COL = 1;
FACTION_SHORT_NAME_COL = 2;
FACTION_ELIMINATED_COL = 3;
FACTION_FORFEITED_COL = 4;
FACTION_ICON_COL = 5;
FACTION_HUD_ICON_COL = 6;
FACTION_VOICE_PREFIX_COL = 7;
FACTION_SPAWN_MUSIC_COL = 8;
FACTION_WIN_MUSIC_COL = 9;
FACTION_FLAG_MODEL_COL = 10;
FACTION_FLAG_CARRY_MODEL_COL = 11;
FACTION_FLAG_ICON_COL = 12;
FACTION_FLAG_FX_COL = 13;
FACTION_COLOR_R_COL = 14;
FACTION_COLOR_G_COL = 15;
FACTION_COLOR_B_COL = 16;
FACTION_HEAD_ICON_COL = 17;
FACTION_CRATE_MODEL_COL = 18;
FACTION_DEPLOY_MODEL_COL = 19;

MT_REF_COL = 0;
MT_NAME_COL = 1;
MT_ICON_COL = 2;
MT_HEAD_ICON_COL = 3;

init() {
  initScoreBoard();

  level.teamBalance = getDvarInt("scr_teambalance");
  level.maxClients = getDvarInt("sv_maxclients");

  setPlayerModels();

  level.freeplayers = [];

  if(level.teamBased) {
    level thread onPlayerConnect();
    level thread updateTeamBalance();

    wait .15;

    if(!is_aliens())
      level thread updatePlayerTimes();
  } else {
    level thread onFreePlayerConnect();

    wait .15;
    level thread updateFreePlayerTimes();
  }
}

initScoreBoard() {
  setDvar("g_TeamName_Allies", getTeamShortName("allies"));
  setDvar("g_TeamIcon_Allies", getTeamIcon("allies"));
  setDvar("g_TeamIcon_MyAllies", getTeamIcon("allies"));
  setDvar("g_TeamIcon_EnemyAllies", getTeamIcon("allies"));
  scoreColor = getTeamColor("allies");
  setDvar("g_ScoresColor_Allies", scoreColor[0] + " " + scoreColor[1] + " " + scoreColor[2]);

  setDvar("g_TeamName_Axis", getTeamShortName("axis"));
  setDvar("g_TeamIcon_Axis", getTeamIcon("axis"));
  setDvar("g_TeamIcon_MyAxis", getTeamIcon("axis"));
  setDvar("g_TeamIcon_EnemyAxis", getTeamIcon("axis"));
  scoreColor = getTeamColor("axis");
  setDvar("g_ScoresColor_Axis", scoreColor[0] + " " + scoreColor[1] + " " + scoreColor[2]);

  setdvar("g_ScoresColor_Spectator", ".25 .25 .25");
  setdvar("g_ScoresColor_Free", ".76 .78 .10");
  setdvar("g_teamTitleColor_MyTeam", ".6 .8 .6");
  setdvar("g_teamTitleColor_EnemyTeam", "1 .45 .5");
}

onPlayerConnect() {
  for(;;) {
    level waittill("connected", player);

    player thread onJoinedTeam();
    player thread onJoinedSpectators();
    player thread onPlayerSpawned();

    player thread trackPlayedTime();
  }
}

onFreePlayerConnect() {
  for(;;) {
    level waittill("connected", player);

    player thread trackFreePlayedTime();
  }
}

onJoinedTeam() {
  self endon("disconnect");

  for(;;) {
    self waittill("joined_team");

    self updateTeamTime();
  }
}

onJoinedSpectators() {
  self endon("disconnect");

  for(;;) {
    self waittill("joined_spectators");
    self.pers["teamTime"] = undefined;
  }
}

trackPlayedTime() {
  self endon("disconnect");

  self.timePlayed["allies"] = 0;
  self.timePlayed["axis"] = 0;
  self.timePlayed["free"] = 0;
  self.timePlayed["other"] = 0;
  self.timePlayed["total"] = 0;

  gameFlagWait("prematch_done");

  for(;;) {
    if(game["state"] == "playing") {
      if(self.sessionteam == "allies") {
        self.timePlayed["allies"]++;
        self.timePlayed["total"]++;
      } else if(self.sessionteam == "axis") {
        self.timePlayed["axis"]++;
        self.timePlayed["total"]++;
      } else if(self.sessionteam == "spectator") {
        self.timePlayed["other"]++;
      }

    }

    wait(1.0);
  }
}

updatePlayerTimes() {
  if(!level.rankedmatch) {
    return;
  }
  level endon("game_ended");

  for(;;) {
    maps\mp\gametypes\_hostmigration::waitTillHostMigrationDone();

    foreach(player in level.players)
    player updatePlayedTime();

    wait(1.0);
  }
}

updatePlayedTime() {
  if(IsAI(self)) {
    return;
  }
  if(!self rankingEnabled()) {
    return;
  }
  if(self.timePlayed["allies"]) {
    if(!IsSquadsMode()) {
      self maps\mp\gametypes\_persistence::statAddBuffered("timePlayedAllies", self.timePlayed["allies"]);
      self maps\mp\gametypes\_persistence::statAddBuffered("timePlayedTotal", self.timePlayed["allies"]);
    }
    self maps\mp\gametypes\_persistence::statAddChildBuffered("round", "timePlayed", self.timePlayed["allies"]);

    self maps\mp\gametypes\_persistence::statAddChildBufferedWithMax("xpMultiplierTimePlayed", 0, self.timePlayed["allies"], self.bufferedChildStatsMax["xpMaxMultiplierTimePlayed"][0]);
    self maps\mp\gametypes\_persistence::statAddChildBufferedWithMax("xpMultiplierTimePlayed", 1, self.timePlayed["allies"], self.bufferedChildStatsMax["xpMaxMultiplierTimePlayed"][1]);
    self maps\mp\gametypes\_persistence::statAddChildBufferedWithMax("xpMultiplierTimePlayed", 2, self.timePlayed["allies"], self.bufferedChildStatsMax["xpMaxMultiplierTimePlayed"][2]);

    self maps\mp\gametypes\_persistence::statAddChildBufferedWithMax("challengeXPMultiplierTimePlayed", 0, self.timePlayed["allies"], self.bufferedChildStatsMax["challengeXPMaxMultiplierTimePlayed"][0]);
    self maps\mp\gametypes\_persistence::statAddChildBufferedWithMax("weaponXPMultiplierTimePlayed", 0, self.timePlayed["allies"], self.bufferedChildStatsMax["weaponXPMaxMultiplierTimePlayed"][0]);

    if(IsSquadsMode()) {
      self maps\mp\gametypes\_persistence::statAddBufferedWithMax("prestigeDoubleXpTimePlayed", self.timePlayed["allies"], self.bufferedStatsMax["prestigeDoubleXpMaxTimePlayed"]);
      self maps\mp\gametypes\_persistence::statAddBufferedWithMax("prestigeDoubleWeaponXpTimePlayed", self.timePlayed["allies"], self.bufferedStatsMax["prestigeDoubleWeaponXpMaxTimePlayed"]);
    }
  }

  if(self.timePlayed["axis"]) {
    if(!IsSquadsMode()) {
      self maps\mp\gametypes\_persistence::statAddBuffered("timePlayedOpfor", self.timePlayed["axis"]);
      self maps\mp\gametypes\_persistence::statAddBuffered("timePlayedTotal", self.timePlayed["axis"]);
    }
    self maps\mp\gametypes\_persistence::statAddChildBuffered("round", "timePlayed", self.timePlayed["axis"]);

    self maps\mp\gametypes\_persistence::statAddChildBufferedWithMax("xpMultiplierTimePlayed", 0, self.timePlayed["axis"], self.bufferedChildStatsMax["xpMaxMultiplierTimePlayed"][0]);
    self maps\mp\gametypes\_persistence::statAddChildBufferedWithMax("xpMultiplierTimePlayed", 1, self.timePlayed["axis"], self.bufferedChildStatsMax["xpMaxMultiplierTimePlayed"][1]);
    self maps\mp\gametypes\_persistence::statAddChildBufferedWithMax("xpMultiplierTimePlayed", 2, self.timePlayed["axis"], self.bufferedChildStatsMax["xpMaxMultiplierTimePlayed"][2]);

    self maps\mp\gametypes\_persistence::statAddChildBufferedWithMax("challengeXPMultiplierTimePlayed", 0, self.timePlayed["axis"], self.bufferedChildStatsMax["challengeXPMaxMultiplierTimePlayed"][0]);
    self maps\mp\gametypes\_persistence::statAddChildBufferedWithMax("weaponXPMultiplierTimePlayed", 0, self.timePlayed["axis"], self.bufferedChildStatsMax["weaponXPMaxMultiplierTimePlayed"][0]);

    if(IsSquadsMode()) {
      self maps\mp\gametypes\_persistence::statAddBufferedWithMax("prestigeDoubleXpTimePlayed", self.timePlayed["axis"], self.bufferedStatsMax["prestigeDoubleXpMaxTimePlayed"]);
      self maps\mp\gametypes\_persistence::statAddBufferedWithMax("prestigeDoubleWeaponXpTimePlayed", self.timePlayed["axis"], self.bufferedStatsMax["prestigeDoubleWeaponXpMaxTimePlayed"]);
    }
  }

  if(self.timePlayed["other"]) {
    if(!IsSquadsMode()) {
      self maps\mp\gametypes\_persistence::statAddBuffered("timePlayedOther", self.timePlayed["other"]);
      self maps\mp\gametypes\_persistence::statAddBuffered("timePlayedTotal", self.timePlayed["other"]);
    }
    self maps\mp\gametypes\_persistence::statAddChildBuffered("round", "timePlayed", self.timePlayed["other"]);

    self maps\mp\gametypes\_persistence::statAddChildBufferedWithMax("xpMultiplierTimePlayed", 0, self.timePlayed["other"], self.bufferedChildStatsMax["xpMaxMultiplierTimePlayed"][0]);
    self maps\mp\gametypes\_persistence::statAddChildBufferedWithMax("xpMultiplierTimePlayed", 1, self.timePlayed["other"], self.bufferedChildStatsMax["xpMaxMultiplierTimePlayed"][1]);
    self maps\mp\gametypes\_persistence::statAddChildBufferedWithMax("xpMultiplierTimePlayed", 2, self.timePlayed["other"], self.bufferedChildStatsMax["xpMaxMultiplierTimePlayed"][2]);

    self maps\mp\gametypes\_persistence::statAddChildBufferedWithMax("challengeXPMultiplierTimePlayed", 0, self.timePlayed["other"], self.bufferedChildStatsMax["challengeXPMaxMultiplierTimePlayed"][0]);
    self maps\mp\gametypes\_persistence::statAddChildBufferedWithMax("weaponXPMultiplierTimePlayed", 0, self.timePlayed["other"], self.bufferedChildStatsMax["weaponXPMaxMultiplierTimePlayed"][0]);

    if(IsSquadsMode()) {
      self maps\mp\gametypes\_persistence::statAddBufferedWithMax("prestigeDoubleXpTimePlayed", self.timePlayed["other"], self.bufferedStatsMax["prestigeDoubleXpMaxTimePlayed"]);
      self maps\mp\gametypes\_persistence::statAddBufferedWithMax("prestigeDoubleWeaponXpTimePlayed", self.timePlayed["other"], self.bufferedStatsMax["prestigeDoubleWeaponXpMaxTimePlayed"]);
    }
  }

  if(self.pers["rank"] != level.maxRank) {
    if(self.timePlayed["allies"])
      self maps\mp\gametypes\_persistence::statAddSquadBuffered("experienceToPrestige", self.timePlayed["allies"]);
    else if(self.timePlayed["axis"])
      self maps\mp\gametypes\_persistence::statAddSquadBuffered("experienceToPrestige", self.timePlayed["axis"]);
    else if(self.timePlayed["other"])
      self maps\mp\gametypes\_persistence::statAddSquadBuffered("experienceToPrestige", self.timePlayed["other"]);
  }

  if(game["state"] == "postgame") {
    return;
  }
  self.timePlayed["allies"] = 0;
  self.timePlayed["axis"] = 0;
  self.timePlayed["other"] = 0;
}

updateTeamTime() {
  if(game["state"] != "playing") {
    return;
  }
  self.pers["teamTime"] = getTime();
}

updateTeamBalanceDvar() {
  for(;;) {
    teambalance = getdvarInt("scr_teambalance");
    if(level.teambalance != teambalance)
      level.teambalance = getdvarInt("scr_teambalance");

    wait 1;
  }
}

updateTeamBalance() {
  level.teamLimit = level.maxclients / 2;

  level thread updateTeamBalanceDvar();

  wait .15;

  if(level.teamBalance && isRoundBased()) {
    if(isDefined(game["BalanceTeamsNextRound"]))
      iPrintLnbold(&"MP_AUTOBALANCE_NEXT_ROUND");

    level waittill("restarting");

    if(isDefined(game["BalanceTeamsNextRound"])) {
      level balanceTeams();
      game["BalanceTeamsNextRound"] = undefined;
    } else if(!getTeamBalance()) {
      game["BalanceTeamsNextRound"] = true;
    }
  } else {
    level endon("game_ended");
    for(;;) {
      if(level.teamBalance) {
        if(!getTeamBalance()) {
          iPrintLnBold(&"MP_AUTOBALANCE_SECONDS", 15);
          wait 15.0;

          if(!getTeamBalance())
            level balanceTeams();
        }

        wait 59.0;
      }

      wait 1.0;
    }
  }

}

getTeamBalance() {
  level.team["allies"] = 0;
  level.team["axis"] = 0;

  players = level.players;
  for(i = 0; i < players.size; i++) {
    if((isDefined(players[i].pers["team"])) && (players[i].pers["team"] == "allies"))
      level.team["allies"]++;
    else if((isDefined(players[i].pers["team"])) && (players[i].pers["team"] == "axis"))
      level.team["axis"]++;
  }

  if((level.team["allies"] > (level.team["axis"] + level.teamBalance)) || (level.team["axis"] > (level.team["allies"] + level.teamBalance)))
    return false;
  else
    return true;
}

balanceTeams() {
  iPrintLnBold(game["strings"]["autobalance"]);

  AlliedPlayers = [];
  AxisPlayers = [];

  players = level.players;
  for(i = 0; i < players.size; i++) {
    if(!isDefined(players[i].pers["teamTime"])) {
      continue;
    }
    if((isDefined(players[i].pers["team"])) && (players[i].pers["team"] == "allies"))
      AlliedPlayers[AlliedPlayers.size] = players[i];
    else if((isDefined(players[i].pers["team"])) && (players[i].pers["team"] == "axis"))
      AxisPlayers[AxisPlayers.size] = players[i];
  }

  MostRecent = undefined;

  while((AlliedPlayers.size > (AxisPlayers.size + 1)) || (AxisPlayers.size > (AlliedPlayers.size + 1))) {
    if(AlliedPlayers.size > (AxisPlayers.size + 1)) {
      for(j = 0; j < AlliedPlayers.size; j++) {
        if(isDefined(AlliedPlayers[j].dont_auto_balance)) {
          continue;
        }
        if(!isDefined(MostRecent))
          MostRecent = AlliedPlayers[j];
        else if(AlliedPlayers[j].pers["teamTime"] > MostRecent.pers["teamTime"])
          MostRecent = AlliedPlayers[j];
      }

      MostRecent[[level.onTeamSelection]]("axis");
    } else if(AxisPlayers.size > (AlliedPlayers.size + 1)) {
      for(j = 0; j < AxisPlayers.size; j++) {
        if(isDefined(AxisPlayers[j].dont_auto_balance)) {
          continue;
        }
        if(!isDefined(MostRecent))
          MostRecent = AxisPlayers[j];
        else if(AxisPlayers[j].pers["teamTime"] > MostRecent.pers["teamTime"])
          MostRecent = AxisPlayers[j];
      }

      MostRecent[[level.onTeamSelection]]("allies");
    }

    MostRecent = undefined;
    AlliedPlayers = [];
    AxisPlayers = [];

    players = level.players;
    for(i = 0; i < players.size; i++) {
      if((isDefined(players[i].pers["team"])) && (players[i].pers["team"] == "allies"))
        AlliedPlayers[AlliedPlayers.size] = players[i];
      else if((isDefined(players[i].pers["team"])) && (players[i].pers["team"] == "axis"))
        AxisPlayers[AxisPlayers.size] = players[i];
    }
  }
}

setPlayerModels() {
  setDefaultCharacterData();

  game["allies_model"]["JUGGERNAUT"] = maps\mp\killstreaks\_juggernaut::setJugg;
  game["axis_model"]["JUGGERNAUT"] = maps\mp\killstreaks\_juggernaut::setJugg;
  game["allies_model"]["JUGGERNAUT_MANIAC"] = maps\mp\killstreaks\_juggernaut::setJuggManiac;
  game["axis_model"]["JUGGERNAUT_MANIAC"] = maps\mp\killstreaks\_juggernaut::setJuggManiac;
}

playerModelForWeapon(weapon, secondary) {}

CountPlayers() {
  player_counts = [];

  for(i = 0; i < level.teamNameList.size; i++) {
    player_counts[level.teamNameList[i]] = 0;
  }

  for(i = 0; i < level.players.size; i++) {
    if(level.players[i] == self) {
      continue;
    }
    if(level.players[i].pers["team"] == "spectator") {
      continue;
    }
    if(isDefined(level.players[i].pers["team"])) {
      assert(isDefined(player_counts[level.players[i].pers["team"]]));
      player_counts[level.players[i].pers["team"]]++;
    }
  }

  return player_counts;
}

setDefaultCharacterData() {
  if(!isDefined(level.defaultHeadModels)) {
    level.defaultHeadModels = [];
    level.defaultHeadModels["allies"] = "head_mp_head_a";
    level.defaultHeadModels["axis"] = "head_mp_head_a";
  }

  if(!isDefined(level.defaultBodyModels)) {
    level.defaultBodyModels = [];
    level.defaultBodyModels["allies"] = "mp_body_us_rangers_assault_a_urban";
    level.defaultBodyModels["axis"] = "mp_body_us_rangers_assault_a_woodland";
  }

  if(!isDefined(level.defaultViewArmModels)) {
    level.defaultViewArmModels = [];
    level.defaultViewArmModels["allies"] = "viewhands_us_rangers_urban";
    level.defaultViewArmModels["axis"] = "viewhands_us_rangers_woodland";
  }

  if(!isDefined(level.defaultVoices)) {
    level.defaultVoices = [];
    level.defaultVoices["allies"] = "delta";
    level.defaultVoices["axis"] = "delta";
  }
}

setCharacterModels(bodyModelName, headModelName, viewModelName) {
  self setModel(bodyModelName);
  self SetViewModel(viewModelName);
  self Attach(headModelName, "", true);
  self.headModel = headModelName;
}

setModelFromCustomization() {
  assert(isDefined(self));
  assert(IsPlayer(self));

  bodyModelName = self GetCustomizationBody();
  headModelName = self GetCustomizationHead();
  viewModelName = self GetCustomizationViewmodel();

  setCharacterModels(bodyModelName, headModelName, viewModelName);
}

setDefaultModel() {
  assert(isDefined(self));

  bodyModelName = level.defaultBodyModels[self.team];
  headModelName = level.defaultHeadModels[self.team];
  viewModelName = level.defaultViewArmModels[self.team];

  setCharacterModels(bodyModelName, headModelName, viewModelName);
}

getPlayerModelIndex() {
  if(level.rankedMatch)
    return self GetRankedPlayerData("squadMembers", self.pers["activeSquadMember"], "body");
  else
    return self GetPrivatePlayerData("privateMatchSquadMembers", self.pers["activeSquadMember"], "body");
}

getPlayerFoleyType(bodyIndex) {
  return TableLookup("mp/cac/bodies.csv", 0, bodyIndex, 5);
}

getPlayerModelName(bodyIndex) {
  return TableLookup("mp/cac/bodies.csv", 0, bodyIndex, 1);
}

setupPlayerModel() {
  if(IsPlayer(self))
    self setModelFromCustomization();
  else
    self setDefaultModel();

  if(!isAI(self)) {
    bodyIndex = self getPlayerModelIndex();
    self.bodyIndex = bodyIndex;
    modelFoleyType = self getPlayerFoleyType(bodyIndex);

    self SetClothType(modelFoleyType);
  } else {
    self SetClothType("vestLight");
  }

  self.voice = level.defaultVoices[self.team];

  if(isAnyMLGMatch() && !isAI(self)) {
    bodyModelName = getPlayerModelName(self getPlayerModelIndex());

    if(IsSubStr(bodyModelName, "fullbody_sniper")) {
      self thread forceDefaultModel();
    }
  }

  if(self isJuggernaut()) {
    if(isDefined(self.isJuggernautManiac) && self.isJuggernautManiac)
      thread[[game[self.team + "_model"]["JUGGERNAUT_MANIAC"]]]();
    else if(isDefined(self.isJuggernautLevelCustom) && self.isJuggernautLevelCustom)
      thread[[game[self.team + "_model"]["JUGGERNAUT_CUSTOM"]]]();
    else
      thread[[game[self.team + "_model"]["JUGGERNAUT"]]]();
  }
}

forceDefaultModel() {
  if(isDefined(self.headModel)) {
    self Detach(self.headModel, "");
    self.headModel = undefined;
  }

  if(self.team == "axis") {
    self setModel("mp_body_juggernaut_light_black");
    self SetViewModel("viewhands_juggernaut_ally");
  } else {
    self setModel("mp_body_infected_a");
    self SetViewmodel("viewhands_gs_hostage");
  }

  if(isDefined(self.headModel)) {
    self Detach(self.headModel, "");
    self.headModel = undefined;
  }
  self Attach("head_mp_infected", "", true);
  self.headModel = "head_mp_infected";
  self SetClothType("cloth");
}

trackFreePlayedTime() {
  self endon("disconnect");

  self.timePlayed["allies"] = 0;
  self.timePlayed["axis"] = 0;
  self.timePlayed["other"] = 0;
  self.timePlayed["total"] = 0;

  for(;;) {
    if(game["state"] == "playing") {
      if(isDefined(self.pers["team"]) && self.pers["team"] == "allies" && self.sessionteam != "spectator") {
        self.timePlayed["allies"]++;
        self.timePlayed["total"]++;
      } else if(isDefined(self.pers["team"]) && self.pers["team"] == "axis" && self.sessionteam != "spectator") {
        self.timePlayed["axis"]++;
        self.timePlayed["total"]++;
      } else {
        self.timePlayed["other"]++;
      }
    }

    wait(1.0);
  }
}

playerConnectedTest() {
  if(getdvarint("scr_runlevelandquit") == 1) {
    return;
  }
  level endon("exitLevel_called");

  for(;;) {
    foreach(player in level.players) {
      player GetRankedPlayerData("experience");
    }
    wait .05;
  }
}

updateFreePlayerTimes() {
  if(!level.rankedmatch) {
    return;
  }
  thread playerConnectedTest();

  nextToUpdate = 0;
  for(;;) {
    nextToUpdate++;
    if(nextToUpdate >= level.players.size)
      nextToUpdate = 0;

    if(isDefined(level.players[nextToUpdate]))
      level.players[nextToUpdate] updateFreePlayedTime();

    wait(1.0);
  }
}

updateFreePlayedTime() {
  if(!self rankingEnabled()) {
    return;
  }
  if(IsAI(self)) {
    return;
  }
  if(self.timePlayed["allies"]) {
    if(!IsSquadsMode()) {
      self maps\mp\gametypes\_persistence::statAddBuffered("timePlayedAllies", self.timePlayed["allies"]);
      self maps\mp\gametypes\_persistence::statAddBuffered("timePlayedTotal", self.timePlayed["allies"]);
    }
    self maps\mp\gametypes\_persistence::statAddChildBuffered("round", "timePlayed", self.timePlayed["allies"]);

    self maps\mp\gametypes\_persistence::statAddChildBufferedWithMax("xpMultiplierTimePlayed", 0, self.timePlayed["allies"], self.bufferedChildStatsMax["xpMaxMultiplierTimePlayed"][0]);
    self maps\mp\gametypes\_persistence::statAddChildBufferedWithMax("xpMultiplierTimePlayed", 1, self.timePlayed["allies"], self.bufferedChildStatsMax["xpMaxMultiplierTimePlayed"][1]);
    self maps\mp\gametypes\_persistence::statAddChildBufferedWithMax("xpMultiplierTimePlayed", 2, self.timePlayed["allies"], self.bufferedChildStatsMax["xpMaxMultiplierTimePlayed"][2]);

    if(IsSquadsMode()) {
      self maps\mp\gametypes\_persistence::statAddBufferedWithMax("prestigeDoubleXpTimePlayed", self.timePlayed["allies"], self.bufferedStatsMax["prestigeDoubleXpMaxTimePlayed"]);
      self maps\mp\gametypes\_persistence::statAddBufferedWithMax("prestigeDoubleWeaponXpTimePlayed", self.timePlayed["allies"], self.bufferedStatsMax["prestigeDoubleWeaponXpMaxTimePlayed"]);
    }
  }

  if(self.timePlayed["axis"]) {
    if(!IsSquadsMode()) {
      self maps\mp\gametypes\_persistence::statAddBuffered("timePlayedOpfor", self.timePlayed["axis"]);
      self maps\mp\gametypes\_persistence::statAddBuffered("timePlayedTotal", self.timePlayed["axis"]);
    }
    self maps\mp\gametypes\_persistence::statAddChildBuffered("round", "timePlayed", self.timePlayed["axis"]);

    self maps\mp\gametypes\_persistence::statAddChildBufferedWithMax("xpMultiplierTimePlayed", 0, self.timePlayed["axis"], self.bufferedChildStatsMax["xpMaxMultiplierTimePlayed"][0]);
    self maps\mp\gametypes\_persistence::statAddChildBufferedWithMax("xpMultiplierTimePlayed", 1, self.timePlayed["axis"], self.bufferedChildStatsMax["xpMaxMultiplierTimePlayed"][1]);
    self maps\mp\gametypes\_persistence::statAddChildBufferedWithMax("xpMultiplierTimePlayed", 2, self.timePlayed["axis"], self.bufferedChildStatsMax["xpMaxMultiplierTimePlayed"][2]);

    if(IsSquadsMode()) {
      self maps\mp\gametypes\_persistence::statAddBufferedWithMax("prestigeDoubleXpTimePlayed", self.timePlayed["axis"], self.bufferedStatsMax["prestigeDoubleXpMaxTimePlayed"]);
      self maps\mp\gametypes\_persistence::statAddBufferedWithMax("prestigeDoubleWeaponXpTimePlayed", self.timePlayed["axis"], self.bufferedStatsMax["prestigeDoubleWeaponXpMaxTimePlayed"]);
    }
  }

  if(self.timePlayed["other"]) {
    if(!IsSquadsMode()) {
      self maps\mp\gametypes\_persistence::statAddBuffered("timePlayedOther", self.timePlayed["other"]);
      self maps\mp\gametypes\_persistence::statAddBuffered("timePlayedTotal", self.timePlayed["other"]);
    }
    self maps\mp\gametypes\_persistence::statAddChildBuffered("round", "timePlayed", self.timePlayed["other"]);

    self maps\mp\gametypes\_persistence::statAddChildBufferedWithMax("xpMultiplierTimePlayed", 0, self.timePlayed["other"], self.bufferedChildStatsMax["xpMaxMultiplierTimePlayed"][0]);
    self maps\mp\gametypes\_persistence::statAddChildBufferedWithMax("xpMultiplierTimePlayed", 1, self.timePlayed["other"], self.bufferedChildStatsMax["xpMaxMultiplierTimePlayed"][1]);
    self maps\mp\gametypes\_persistence::statAddChildBufferedWithMax("xpMultiplierTimePlayed", 2, self.timePlayed["other"], self.bufferedChildStatsMax["xpMaxMultiplierTimePlayed"][2]);

    if(IsSquadsMode()) {
      self maps\mp\gametypes\_persistence::statAddBufferedWithMax("prestigeDoubleXpTimePlayed", self.timePlayed["other"], self.bufferedStatsMax["prestigeDoubleXpMaxTimePlayed"]);
      self maps\mp\gametypes\_persistence::statAddBufferedWithMax("prestigeDoubleWeaponXpTimePlayed", self.timePlayed["other"], self.bufferedStatsMax["prestigeDoubleWeaponXpMaxTimePlayed"]);
    }
  }

  if(game["state"] == "postgame") {
    return;
  }
  self.timePlayed["allies"] = 0;
  self.timePlayed["axis"] = 0;
  self.timePlayed["other"] = 0;
}

getJoinTeamPermissions(team) {
  if(is_aliens())
    return true;

  teamcount = 0;
  botcount = 0;

  players = level.players;
  for(i = 0; i < players.size; i++) {
    player = players[i];

    if((isDefined(player.pers["team"])) && (player.pers["team"] == team)) {
      teamcount++;

      if(IsBot(player))
        botcount++;
    }
  }

  if(teamCount < level.teamLimit)
    return true;
  else if(botcount > 0)
    return true;
  else if(!matchMakingGame())
    return true;
  else if(level.gameType == "infect")
    return true;
  else
    return false;
}

onPlayerSpawned() {
  level endon("game_ended");

  for(;;) {
    self waittill("spawned_player");
  }
}

MT_getTeamName(teamRef) {
  return (tableLookupIString("mp/MTTable.csv", MT_REF_COL, teamRef, MT_NAME_COL));
}

MT_getTeamIcon(teamRef) {
  return (tableLookup("mp/MTTable.csv", MT_REF_COL, teamRef, MT_ICON_COL));
}

MT_getTeamHeadIcon(teamRef) {
  return (tableLookup("mp/MTTable.csv", MT_REF_COL, teamRef, MT_HEAD_ICON_COL));
}

getTeamName(teamRef) {
  return (tableLookupIString("mp/factionTable.csv", FACTION_REF_COL, game[teamRef], FACTION_NAME_COL));
}

getTeamShortName(teamRef) {
  return (tableLookupIString("mp/factionTable.csv", FACTION_REF_COL, game[teamRef], FACTION_SHORT_NAME_COL));
}

getTeamForfeitedString(teamRef) {
  return (tableLookupIString("mp/factionTable.csv", FACTION_REF_COL, game[teamRef], FACTION_FORFEITED_COL));
}

getTeamEliminatedString(teamRef) {
  return (tableLookupIString("mp/factionTable.csv", FACTION_REF_COL, game[teamRef], FACTION_ELIMINATED_COL));
}

getTeamIcon(teamRef) {
  return (tableLookup("mp/factionTable.csv", FACTION_REF_COL, game[teamRef], FACTION_ICON_COL));
}

getTeamHudIcon(teamRef) {
  return (tableLookup("mp/factionTable.csv", FACTION_REF_COL, game[teamRef], FACTION_HUD_ICON_COL));
}

getTeamHeadIcon(teamRef) {
  return (tableLookup("mp/factionTable.csv", FACTION_REF_COL, game[teamRef], FACTION_HEAD_ICON_COL));
}

getTeamVoicePrefix(teamRef) {
  return (tableLookup("mp/factionTable.csv", FACTION_REF_COL, game[teamRef], FACTION_VOICE_PREFIX_COL));
}

getTeamSpawnMusic(teamRef) {
  return (tableLookup("mp/factionTable.csv", FACTION_REF_COL, game[teamRef], FACTION_SPAWN_MUSIC_COL));
}

getTeamWinMusic(teamRef) {
  return (tableLookup("mp/factionTable.csv", FACTION_REF_COL, game[teamRef], FACTION_WIN_MUSIC_COL));
}

getTeamFlagModel(teamRef) {
  return (tableLookup("mp/factionTable.csv", FACTION_REF_COL, game[teamRef], FACTION_FLAG_MODEL_COL));
}

getTeamFlagCarryModel(teamRef) {
  return (tableLookup("mp/factionTable.csv", FACTION_REF_COL, game[teamRef], FACTION_FLAG_CARRY_MODEL_COL));
}

getTeamFlagIcon(teamRef) {
  return (tableLookup("mp/factionTable.csv", FACTION_REF_COL, game[teamRef], FACTION_FLAG_ICON_COL));
}

getTeamFlagFX(teamRef) {
  return (tableLookup("mp/factionTable.csv", FACTION_REF_COL, game[teamRef], FACTION_FLAG_FX_COL));
}

getTeamColor(teamRef) {
  return ((stringToFloat(tableLookup("mp/factionTable.csv", FACTION_REF_COL, game[teamRef], FACTION_COLOR_R_COL)), stringToFloat(tableLookup("mp/factionTable.csv", FACTION_REF_COL, game[teamRef], FACTION_COLOR_G_COL)), stringToFloat(tableLookup("mp/factionTable.csv", FACTION_REF_COL, game[teamRef], FACTION_COLOR_B_COL))));
}

getTeamCrateModel(teamRef) {
  return (tableLookup("mp/factionTable.csv", FACTION_REF_COL, game[teamRef], FACTION_CRATE_MODEL_COL));
}

getTeamDeployModel(teamRef) {
  return (tableLookup("mp/factionTable.csv", FACTION_REF_COL, game[teamRef], FACTION_DEPLOY_MODEL_COL));
}