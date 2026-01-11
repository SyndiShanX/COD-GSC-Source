/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\_popups.gsc
**************************************/

#include maps\mp\_utility;
#include common_scripts\utility;

init() {
  level.medalSettings.waitTime = 1.25;
  level.contractSettings = spawnStruct();
  level.contractSettings.waitTime = 4.2;
  level.killstreakSettings = spawnStruct();
  level.killstreakSettings.waitTime = 3;
  level.rankSettings = spawnStruct();
  level.rankSettings.waitTime = 3;
  level.startMessage = spawnStruct();
  level.startMessageDefaultDuration = 2.0;
  level.endMessageDefaultDuration = 2.0;
  level.challengeSettings = spawnStruct();
  level.challengeSettings.waitTime = 3;
  level.teamMessage = spawnStruct();
  level.teamMessage.waittime = 3;
  level.regularGameMessages = spawnStruct();
  level.regularGameMessages.waittime = 6;
  level.wagerSettings = spawnStruct();
  level.wagerSettings.waittime = 3;
  level thread onPlayerConnect();
}
popupsFromConsole() {
  while(1) {
    timeout = getDvarIntDefault(#"scr_popuptime", 1.0);
    if(timeout == 0) {
      timeout = 1;
    }
    wait(timeout);
    medal = getDvarIntDefault(#"scr_popupmedal", 0);
    challenge = getDvarIntDefault(#"scr_popupchallenge", 0);
    rank = getDvarIntDefault(#"scr_popuprank", 0);
    contractPass = getDvarIntDefault(#"scr_popupcontractpass", 0);
    contractFail = getDvarIntDefault(#"scr_popupcontractfail", 0);
    gameModeMsg = getDvarIntDefault(#"scr_gamemodeslideout", 0);
    teamMsg = getDvarIntDefault(#"scr_teamslideout", 0);
    challengeIndex = getDvarIntDefault(#"scr_challengeIndex", 1);
    for(i = 0; i < medal; i++) {
      level.players[0] maps\mp\gametypes\_persistence::statAdd("BACK_STABBER", 1, false);
    }
    for(i = 0; i < challenge; i++) {
      level.players[0] maps\mp\gametypes\_missions::milestoneNotify(1, challengeIndex, 1, 1);
    }
    for(i = 0; i < rank; i++) {
      level.players[0] maps\mp\gametypes\_rank::updateRankAnnounceHUD();
    }
    for(i = 0; i < contractPass; i++) {
      level.players[0] maps\mp\gametypes\_persistence::addContractToQueue(12, 1);
    }
    for(i = 0; i < contractFail; i++) {
      level.players[0] maps\mp\gametypes\_persistence::addContractToQueue(12, 0);
    }
    for(i = 0; i < gameModeMsg; i++) {
      level.players[0] DisplayGameModeMessage(&"MP_HQ_REVEALED", "uin_alert_slideout");
    }
    for(i = 0; i < teamMsg; i++) {
      player = level.players[0];
      if(isDefined(level.players[1])) {
        player = level.players[1];
      }
      level.players[0] DisplayTeamMessageToAll(&"KILLSTREAK_DESTROYED_HELICOPTER", player);
    }
    reset = getDvarIntDefault(#"scr_popupreset", 1);
    if(reset) {
      if(medal) {
        setdvar("scr_popupmedal", 0);
      }
      if(challenge) {
        setdvar("scr_popupchallenge", 0);
      }
      if(rank) {
        setdvar("scr_popuprank", 0);
      }
      if(contractPass) {
        setdvar("scr_popupcontractpass", 0);
      }
      if(contractFail) {
        setdvar("scr_popupcontractfail", 0);
      }
      if(gameModeMsg) {
        setdvar("scr_gamemodeslideout", 0);
      }
      if(teamMsg) {
        setdvar("scr_teamslideout", 0);
      }
    }
  }
}
DisplayKillstreakTeamMessageToAll(killstreak, player) {
  if(!isDefined(level.killstreaks[killstreak])) {
    return;
  }
  if(!isDefined(level.killstreaks[killstreak].inboundText)) {
    return;
  }
  message = level.killstreaks[killstreak].inboundText;
  self DisplayTeamMessageToAll(message, player);
}
shouldDisplayTeamMessages() {
  if(level.hardcoreMode == true || level.splitscreen == true) {
    return false;
  }
  return true;
}
DisplayTeamMessageToAll(message, player) {
  if(!shouldDisplayTeamMessages()) {
    return;
  }
  for(i = 0; i < level.players.size; i++) {
    cur_player = level.players[i];
    size = cur_player.teamMessageQueue.size;
    cur_player.teamMessageQueue[size] = spawnStruct();
    cur_player.teamMessageQueue[size].message = message;
    cur_player.teamMessageQueue[size].player = player;
    cur_player notify("received teammessage");
  }
}
DisplayTeamMessageToTeam(message, player, team) {
  if(!shouldDisplayTeamMessages()) {
    return;
  }
  for(i = 0; i < level.players.size; i++) {
    cur_player = level.players[i];
    if(cur_player.team != team) {
      continue;
    }
    size = cur_player.teamMessageQueue.size;
    cur_player.teamMessageQueue[size] = spawnStruct();
    cur_player.teamMessageQueue[size].message = message;
    cur_player.teamMessageQueue[size].player = player;
    cur_player notify("received teammessage");
  }
}
displayTeamMessageWaiter() {
  if(!shouldDisplayTeamMessages()) {
    return;
  }
  self endon("disconnect");
  level endon("game_ended");
  self.teamMessageQueue = [];
  for(;;) {
    if(self.teamMessageQueue.size == 0) {
      self waittill("received teammessage");
    }
    if(self.teamMessageQueue.size > 0) {
      nextNotifyData = self.teamMessageQueue[0];
      size = self.teamMessageQueue.size;
      for(i = 0; i < size - 1; i++) {
        self.teamMessageQueue[i] = self.teamMessageQueue[i + 1];
      }
      self.teamMessageQueue[size - 1] = undefined;
      if(!isDefined(nextNotifyData.player) || !isplayer(nextNotifyData.player)) {
        continue;
      }
      self displayTeamMessage(nextNotifyData.message, nextNotifyData.player, "uin_alert_slideout");
    }
    wait(level.teamMessage.waittime);
  }
}
displayPopUpsWaiter() {
  self endon("disconnect");
  self.medalNotifyQueue = [];
  self.killstreakNotifyQueue = [];
  self.rankNotifyQueue = [];
  if(!isDefined(self.pers["challengeNotifyQueue"])) {
    self.pers["challengeNotifyQueue"] = [];
  }
  if(!isDefined(self.pers["contractNotifyQueue"])) {
    self.pers["contractNotifyQueue"] = [];
  }
  self.messageNotifyQueue = [];
  self.startMessageNotifyQueue = [];
  self.wagerNotifyQueue = [];
  while(!level.gameEnded && !wasLastRound()) {
    if(self.startMessageNotifyQueue.size == 0 && self.rankNotifyQueue.size == 0 && self.wagerNotifyQueue.size == 0 && self.pers["contractNotifyQueue"].size == 0 && self.medalNotifyQueue.size == 0 && self.killstreakNotifyQueue.size == 0 && self.messageNotifyQueue.size == 0 && self.pers["challengeNotifyQueue"].size == 0) {
      self waittill("received award");
    }
    waittillframeend;
    if(level.gameEnded && !wasLastRound()) {
      break;
    }
    if(self.startMessageNotifyQueue.size > 0) {
      self clearCenterPopups();
      nextNotifyData = self.startMessageNotifyQueue[0];
      for(i = 1; i < self.startMessageNotifyQueue.size; i++) {
        self.startMessageNotifyQueue[i - 1] = self.startMessageNotifyQueue[i];
      }
      self.startMessageNotifyQueue[i - 1] = undefined;
      if(isDefined(nextNotifyData.duration)) {
        duration = nextNotifyData.duration;
      }
      else {
        duration = level.startMessageDefaultDuration;
      }
      self maps\mp\gametypes\_hud_message::showNotifyMessage(nextNotifyData, duration);
      wait(duration);
    } else if(self.wagerNotifyQueue.size > 0) {
      self.doingNotify = true;
      message = self.wagerNotifyQueue[0].message;
      points = self.wagerNotifyQueue[0].points;
      if(!isDefined(points)) {
        points = 0;
      }
      subMessage = self.wagerNotifyQueue[0].subMessage;
      announcement = self.wagerNotifyQueue[0].announcement;
      for(i = 1; i < self.wagerNotifyQueue.size; i++) {
        self.wagerNotifyQueue[i - 1] = self.wagerNotifyQueue[i];
      }
      self.wagerNotifyQueue[i - 1] = undefined;
      if(isDefined(subMessage)) {
        self displayWagerPopup(message, points, subMessage);
      }
      else {
        self displayWagerPopup(message, points);
      }
      if(isDefined(announcement)) {
        self maps\mp\gametypes\_globallogic_audio::leaderDialogOnPlayer(announcement);
      }
      wait(level.wagerSettings.waitTime / 2);
      if(self.wagerNotifyQueue.size == 0) {
        wait(level.wagerSettings.waitTime / 2);
      }
      self.doingNotify = false;
    } else if(self.medalNotifyQueue.size > 0) {
      nextNotifyData = self.medalNotifyQueue[0];
      for(i = 1; i < self.medalNotifyQueue.size; i++) {
        self.medalNotifyQueue[i - 1] = self.medalNotifyQueue[i];
      }
      self.medalNotifyQueue[i - 1] = undefined;
      sound = "uin_challenge_repeatable";
      self displayMedal(nextNotifyData.index, level.teambased, level.xpScale, sound);
      wait(level.medalSettings.waitTime);
    } else if(self.pers["contractNotifyQueue"].size > 0) {
      if(self.resetGameOverHudRequired == true) {
        self notify("reset_outcome");
        self.resetGameOverHudRequired = false;
      }
      contractIndex = self.pers["contractNotifyQueue"][0]["index"];
      passed = self.pers["contractNotifyQueue"][0]["passed"];
      sound = "null";
      if(passed) {
        sound = "mus_contract_complete";
      } else {
        sound = "mus_contract_expire";
      }
      self displayContract(contractIndex, sound, passed);
      wait(level.contractSettings.waitTime);
      if(!level.gameended && !wasLastRound()) {
        for(i = 1; i < self.pers["contractNotifyQueue"].size; i++) {
          self.pers["contractNotifyQueue"][i - 1] = self.pers["contractNotifyQueue"][i];
        }
        self.pers["contractNotifyQueue"][i - 1] = undefined;
      }
    } else if(self.pers["challengeNotifyQueue"].size > 0) {
      if(self.resetGameOverHudRequired == true) {
        self notify("reset_outcome");
        self.resetGameOverHudRequired = false;
      }
      tier = self.pers["challengeNotifyQueue"][0]["tier"];
      index = self.pers["challengeNotifyQueue"][0]["index"];
      itemIndex = self.pers["challengeNotifyQueue"][0]["itemIndex"];
      type = self.pers["challengeNotifyQueue"][0]["type"];
      sound = "mus_challenge_complete";
      self displayChallengeComplete(tier, index, 1, itemIndex, sound, type);
      wait(level.challengeSettings.waitTime);
      if(!level.gameended && !wasLastRound()) {
        for(i = 1; i < self.pers["challengeNotifyQueue"].size; i++) {
          self.pers["challengeNotifyQueue"][i - 1] = self.pers["challengeNotifyQueue"][i];
        }
        self.pers["challengeNotifyQueue"][i - 1] = undefined;
      }
    } else if(self.rankNotifyQueue.size > 0) {
      if(self.resetGameOverHudRequired == true) {
        self notify("reset_outcome");
        self.resetGameOverHudRequired = false;
      }
      rank = self.rankNotifyQueue[0].rank;
      prestige = self.rankNotifyQueue[0].prestige;
      sound = "mus_level_up";
      self displayRankUp(rank, prestige, sound);
      wait(level.rankSettings.waitTime);
      if(!level.gameended && !wasLastRound()) {
        for(i = 1; i < self.rankNotifyQueue.size; i++) {
          self.rankNotifyQueue[i - 1] = self.rankNotifyQueue[i];
        }
        self.rankNotifyQueue[i - 1] = undefined;
      }
    } else if(self.killstreakNotifyQueue.size > 0) {
      streakCount = self.killstreakNotifyQueue[0].streakCount;
      killstreakTableNumber = self.killstreakNotifyQueue[0].killstreakTableNumber;
      hardpointType = self.killstreakNotifyQueue[0].hardpointType;
      for(i = 1; i < self.killstreakNotifyQueue.size; i++) {
        self.killstreakNotifyQueue[i - 1] = self.killstreakNotifyQueue[i];
      }
      self.killstreakNotifyQueue[i - 1] = undefined;
      if(!isDefined(streakCount)) {
        streakCount = 0;
      }
      self displayKillstreak(streakCount, killstreakTableNumber);
      self maps\mp\gametypes\_hardpoints::playKillstreakReadyAndInformDialog(hardpointType);
      wait(level.killstreakSettings.waitTime);
    } else if(self.messageNotifyQueue.size > 0) {
      self clearCenterPopups();
      nextNotifyData = self.messageNotifyQueue[0];
      for(i = 1; i < self.messageNotifyQueue.size; i++) {
        self.messageNotifyQueue[i - 1] = self.messageNotifyQueue[i];
      }
      self.messageNotifyQueue[i - 1] = undefined;
      if(isDefined(nextNotifyData.duration)) {
        duration = nextNotifyData.duration;
      }
      else {
        duration = level.regularGameMessages.waittime;
      }
      self maps\mp\gametypes\_hud_message::showNotifyMessage(nextNotifyData, duration);
    }
  }
}
displayEndGamePopUps() {
  self.postGamePromotion = false;
  self.postGameMilestones = 0;
  self.postGameContracts = 0;
  promoted = 0;
  contract0 = -1;
  contract1 = -1;
  contract2 = -1;
  sendMessage = false;
  if(self.rankNotifyQueue.size > 0) {
    self.postGamePromotion = true;
    promoted = 1;
    sendMessage = true;
  }
  if(self.pers["contractNotifyQueue"].size > 0) {
    for(i = 0; i < self.pers["contractNotifyQueue"].size; i++) {
      if(self.pers["contractNotifyQueue"][0]["passed"] == false) {
        for(i = 1; i < self.pers["contractNotifyQueue"].size; i++) {
          self.pers["contractNotifyQueue"][i - 1] = self.pers["contractNotifyQueue"][i];
        }
        self.pers["contractNotifyQueue"][i - 1] = undefined;
      }
    }
    self.postGameContracts = self.pers["contractNotifyQueue"].size;
    if(isDefined(self.pers["contractNotifyQueue"].size > 0)) {
      if(isDefined(self.pers["contractNotifyQueue"][0])) {
        contract0 = self.pers["contractNotifyQueue"][0]["index"];
        sendMessage = true;
      }
    }
    if(isDefined(self.pers["contractNotifyQueue"].size > 1)) {
      if(isDefined(self.pers["contractNotifyQueue"][1])) {
        contract1 = self.pers["contractNotifyQueue"][1]["index"];
        sendMessage = true;
      }
    }
    if(isDefined(self.pers["contractNotifyQueue"].size > 2)) {
      if(isDefined(self.pers["contractNotifyQueue"][2])) {
        contract2 = self.pers["contractNotifyQueue"][2]["index"];
        sendMessage = true;
      }
    }
  }
  if(sendMessage == true) {
    self DisplayEndGame(promoted, contract0, contract1, contract2);
  }
  for(challengeNotifyCount = 0; challengeNotifyCount < self.pers["challengeNotifyQueue"].size && challengeNotifyCount < 3; challengeNotifyCount++) {
    self.postGameMilestones++;
    tier = self.pers["challengeNotifyQueue"][challengeNotifyCount]["tier"];
    index = self.pers["challengeNotifyQueue"][challengeNotifyCount]["index"];
    itemIndex = self.pers["challengeNotifyQueue"][challengeNotifyCount]["itemIndex"];
    type = self.pers["challengeNotifyQueue"][challengeNotifyCount]["type"];
    self DisplayEndGameMilestone(challengeNotifyCount, tier, index, itemIndex, type);
  }
}
onPlayerConnect() {
  for(;;) {
    level waittill("connecting", player);
    player clearendgame();
    player clearPopups();
    player.resetGameOverHudRequired = false;
    player thread displayPopupsWaiter();
    if(!level.hardcoreMode) {
      player thread displayTeamMessageWaiter();
    }
  }
}
