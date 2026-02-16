/***************************************************
 * Decompiled by Alterware and Edited by SyndiShanX
 * Script: maps\mp\killstreaks\_coop_util.gsc
***************************************************/

#include maps\mp\_utility;
#include common_scripts\utility;

CONST_COOP_USE_BAR_TIME_MIN = 1.25;
CONST_COOP_USE_BAR_TIME_MAX = 2.5;

init() {
  if(!level.teamBased) {
    return;
  }

  level.streakSupportQueueAllies = [];
  level.streakSupportQueueAxis = [];
  level.streakSupporDisabledCount = [];

  setDvar("scr_coop_util_delay", "1");
}

promptForStreakSupport(streakTeam, joinText, splashRef, needSupportVO, buddyJoinedVO, streakPlayer, joinedVO) {
  if(!level.teamBased) {
    return;
  }

  AssertEx(!isDefined(streakPlayer) || streakPlayer.team == streakTeam, "promptForStreakSupport: streakPlayer's team needs to match streakTeam.");

  streakPromptOrigin = (0, 0, 0);
  if(isDefined(streakPlayer)) {
    streakPromptOrigin = streakPlayer.origin;
  }

  streakPrompt = spawn("script_model", streakPromptOrigin);
  streakPrompt Hide();
  streakPrompt.team = streakTeam;
  streakPrompt.needSupportVO = needSupportVO;
  streakPrompt.buddyJoinedVO = buddyJoinedVO;
  streakPrompt.streakPlayer = streakPlayer;
  streakPrompt.joinedVO = joinedVO;
  streakPrompt.joinText = joinText;
  streakPrompt.splashRef = splashRef;
  streakPrompt.active = false;
  streakPrompt.promptID = getUniqueStreakPromptID();
  if(isDefined(streakPlayer)) {
    streakPrompt DisablePlayerUse(streakPlayer);
  }

  addStreakSupportPrompt(streakPrompt);

  return streakPrompt.promptID;
}

stopPromptForStreakSupport(promptID) {
  if(!level.teamBased) {
    return;
  }

  foreach(streakPrompt in level.streakSupportQueueAllies) {
    if(streakPrompt.promptID == promptID) {
      thread removeStreakSupportPrompt(streakPrompt);
      return;
    }
  }

  foreach(streakPrompt in level.streakSupportQueueAxis) {
    if(streakPrompt.promptID == promptID) {
      thread removeStreakSupportPrompt(streakPrompt);
      return;
    }
  }
}

waittillBuddyJoinedStreak(promptId) {
  while(true) {
    level waittill("buddyJoinedStreak", buddy, id);

    if(id == promptID) {
      return buddy;
    }
  }
}

playerSetupCoopStreak(delay) {
  self playerSetupCoopStreakInternal(delay);
}

playerResetAfterCoopStreak() {
  self playerResetAfterCoopStreakInternal();
}

playerStopPromptForStreakSupport() {
  if(!level.teamBased) {
    return;
  }

  if(!isDefined(level.streakSupporDisabledCount[self.guid])) {
    level.streakSupporDisabledCount[self.guid] = 0;
  }

  level.streakSupporDisabledCount[self.guid]++;

  if(level.streakSupporDisabledCount[self.guid] > 1) {
    return;
  }

  if(self.team == "allies") {
    foreach(streakPrompt in level.streakSupportQueueAllies) {
      streakPrompt DisablePlayerUse(self);
    }
  } else {
    foreach(streakPrompt in level.streakSupportQueueAxis) {
      streakPrompt DisablePlayerUse(self);
    }
  }
}

playerStartPromptForStreakSupport() {
  if(!level.teamBased) {
    return;
  }

  level.streakSupporDisabledCount[self.guid]--;

  assert(level.streakSupporDisabledCount[self.guid] >= 0);

  if(level.streakSupporDisabledCount[self.guid] > 0) {
    return;
  }

  if(self.team == "allies") {
    foreach(streakPrompt in level.streakSupportQueueAllies) {
      if(self != streakPrompt.streakPlayer) {
        streakPrompt EnablePlayerUse(self);
      }
    }
  } else {
    foreach(streakPrompt in level.streakSupportQueueAxis) {
      if(self != streakPrompt.streakPlayer) {
        streakPrompt EnablePlayerUse(self);
      }
    }
  }
}

addStreakSupportPrompt(streakPrompt) {
  if(streakPrompt.team == "allies") {
    level.streakSupportQueueAllies[level.streakSupportQueueAllies.size] = streakPrompt;

    if(level.streakSupportQueueAllies.size == 1) {
      level thread startStreakSupportPrompt(streakPrompt);
    }
  } else {
    level.streakSupportQueueAxis[level.streakSupportQueueAxis.size] = streakPrompt;

    if(level.streakSupportQueueAxis.size == 1) {
      level thread startStreakSupportPrompt(streakPrompt);
    }
  }
}

removeStreakSupportPrompt(streakPrompt) {
  wasActive = streakPrompt.active;
  streakPrompt.active = false;
  streakPrompt notify("streakPromptStopped");

  if(streakPrompt.team == "allies") {
    level.streakSupportQueueAllies = array_remove(level.streakSupportQueueAllies, streakPrompt);

    if(wasActive && level.streakSupportQueueAllies.size > 0) {
      level thread startStreakSupportPrompt(level.streakSupportQueueAllies[0]);
    }
  } else {
    level.streakSupportQueueAxis = array_remove(level.streakSupportQueueAxis, streakPrompt);

    if(wasActive && level.streakSupportQueueAxis.size > 0) {
      level thread startStreakSupportPrompt(level.streakSupportQueueAxis[0]);
    }
  }
  thread delayDeletePrompt(streakPrompt);
}

delayDeletePrompt(streakPrompt) {
  wait 1;
  streakPrompt Delete();
}

getUniqueStreakPromptID(team) {
  maxID = 0;

  foreach(streakPrompt in level.streakSupportQueueAllies) {
    if(streakPrompt.promptID >= maxID) {
      maxID = streakPrompt.promptID + 1;
    }
  }

  foreach(streakPrompt in level.streakSupportQueueAxis) {
    if(streakPrompt.promptID >= maxID) {
      maxID = streakPrompt.promptID + 1;
    }
  }

  return maxID;
}

startStreakSupportPrompt(streakPrompt) {
  streakPrompt.active = true;

  level thread handlePrompt(streakPrompt);
  level thread onConnectPrompt(streakPrompt);

  foreach(player in level.players) {
    if(isDefined(streakPrompt.streakPlayer) && player == streakPrompt.streakPlayer) {
      continue;
    }

    if(isReallyAlive(player) && player.team == streakPrompt.team) {
      player thread playerSetupStreakPrompt(streakPrompt);
    }

    player thread playerOnSpawnPrompt(streakPrompt);
  }
}

onConnectPrompt(streakPrompt) {
  level endon("game_ended");
  streakPrompt endon("streakPromptStopped");

  while(true) {
    level waittill("connected", player);

    player thread playerOnSpawnPrompt(streakPrompt);
  }
}

playerOnSpawnPrompt(streakPrompt) {
  level endon("game_ended");
  self endon("disconnect");
  streakPrompt endon("streakPromptStopped");

  while(true) {
    self waittill("spawned_player");

    if(self.team == streakPrompt.team) {
      self thread playerSetupStreakPrompt(streakPrompt);
    }
  }
}

playerSetupStreakPrompt(streakPrompt) {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  streakPrompt endon("streakPromptStopped");

  while(self isUsingRemote() || self isInRemoteTransition()) {
    waitframe();
  }

  playerDisabledWait(streakPrompt);

  self thread playerDisplayJoinRequest(streakPrompt);
  self thread playerTakeStreakSupportInput(streakPrompt);
}

playerDisabledWait(streakPrompt) {
  if(!isDefined(level.streakSupporDisabledCount[self.guid])) {
    return;
  }

  if(level.streakSupporDisabledCount[self.guid] > 0) {
    streakPrompt DisablePlayerUse(self);
    while(level.streakSupporDisabledCount[self.guid] > 0) {
      waitframe();
    }
  }
}

playerDisplayJoinRequest(streakPrompt) {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  streakPrompt endon("streakPromptStopped");

  if(isDefined(streakPrompt.splashRef)) {
    self thread maps\mp\gametypes\_hud_message::coopKillstreakSplashNotify(streakPrompt.splashRef, streakPrompt.needSupportVO);
  }
}

waittillPlayerCanBeBuddy(player, streakPrompt) {
  if(isInRemoteTransition()) {
    player maps\mp\killstreaks\_killstreaks::playerWaittillRideKillstreakComplete();
  }

  waitframe();

  if(isUsingRemote()) {
    player waittill("stopped_using_remote");
  }
}

waittillPromptActivated(streakPrompt) {
  streakPrompt endon("streakPromptStopped");

  streakPrompt waittill("trigger");

  return true;
}

playerTakeStreakSupportInput(streakPrompt) {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");

  while(true) {
    waittillPlayerCanBeBuddy(self);

    result = waittillPromptActivated(streakPrompt);
    if(!isDefined(result)) {
      return;
    }

    if(!streakPrompt.active) {
      return;
    }

    if(isDefined(self PlayerGetUseEnt()) && self PlayerGetUseEnt() == streakPrompt && self useButtonPressed() && self IsOnGround()) {
      useTime = self PlayerGetUseTime();
      result = self playerHandleJoining(streakPrompt, useTime);
      if(result || !streakPrompt.active) {
        return;
      }
    }
  }
}

playerGetUseTime() {
  if(GetDvarInt("scr_coop_util_delay", 1) == 0) {
    return CONST_COOP_USE_BAR_TIME_MIN;
  } else {
    minScore = self.score;
    maxScore = self.score;

    for(i = 1; i < level.players.size; i++) {
      player = level.players[i];

      if(player.team != self.team) {
        continue;
      }

      if(player.score > maxScore) {
        maxScore = player.score;
      } else if(player.score < minScore) {
        minScore = player.score;
      }
    }

    scoreSpread = maxScore - minScore;
    if(scoreSpread == 0) {
      return CONST_COOP_USE_BAR_TIME_MIN;
    }

    playerScorePercent = (self.score - minScore) / scoreSpread;

    useTimeSpread = CONST_COOP_USE_BAR_TIME_MAX - CONST_COOP_USE_BAR_TIME_MIN;
    useTime = CONST_COOP_USE_BAR_TIME_MIN + (playerScorePercent * useTimeSpread);

    return useTime;
  }
}

handlePrompt(streakPrompt) {
  streakPrompt makeGloballyUsableByType("coopStreakPrompt", streakPrompt.joinText, undefined, streakPrompt.team);

  streakPrompt waittill("streakPromptStopped");

  streakPrompt makeGloballyUnusableByType();
}

playerHandleJoining(streakPrompt, useTime) {
  useTimeMS = useTime * 1000;
  if(streakPrompt useHoldThink(self, useTimeMS, streakPrompt)) {
    level notify("buddyJoinedStreak", self, streakPrompt.promptID);

    self thread maps\mp\_events::killStreakJoinEvent();

    if(isDefined(streakPrompt.streakPlayer) && IsAlive(streakPrompt.streakPlayer)) {
      if(isDefined(streakPrompt.joinedVO)) {
        self thread leaderDialogOnPlayer(streakPrompt.joinedVO);
      }

      if(isDefined(streakPrompt.buddyJoinedVO)) {
        streakPrompt.streakPlayer thread leaderDialogOnPlayer(streakPrompt.buddyJoinedVO);
      }

      if(isDefined(streakPrompt.streakPlayer.currentKillStreakIndex)) {
        setMatchData("killstreaks", streakPrompt.streakPlayer.currentKillStreakIndex, "coopPlayerIndex", self.clientId);
      }
    }

    streakPrompt notify("streakPromptStopped");
    return true;
  }

  return false;
}

useHoldThink(player, useTimeMS, streakPrompt) {
  Assert(isPlayer(player));

  player PlayerLinkTo(streakPrompt);
  player PlayerLinkedOffsetEnable();
  player.manuallyJoiningKillStreak = true;

  self thread useHoldThinkCleanupOnPlayerDeath(player);

  self.curProgress = 0;
  self.inUse = true;
  self.useRate = 0;
  self.useTime = useTimeMS;

  if(isDefined(player.inWater)) {
    player AllowCrouch(false);
    player AllowProne(false);
  }

  player _giveWeapon("killstreak_remote_turret_mp");
  player SwitchToWeapon("killstreak_remote_turret_mp");
  player DisableWeaponSwitch();

  player thread personalUseBar(self, streakPrompt);

  result = useHoldThinkLoop(player, streakPrompt);

  if(!isDefined(result)) {
    result = false;
  }

  if(isAlive(player) && !result) {
    player playerResetAfterCoopStreakInternal();
  }

  self.inUse = false;
  self.curProgress = 0;
  if(isDefined(player)) {
    player.manuallyJoiningKillStreak = false;
    player SetClientOmnvar("ui_use_bar_text", 0);
    player SetClientOmnvar("ui_use_bar_end_time", 0);
    player SetClientOmnvar("ui_use_bar_start_time", 0);
  }

  self notify("coopUtilUseHoldThinkComplete");

  return result;
}

useHoldThinkCleanupOnPlayerDeath(player) {
  self endon("coopUtilUseHoldThinkComplete");

  player waittill_any("death", "disconnect");

  if(isDefined(player)) {
    player playerResetAfterCoopStreakInternal();
    player.manuallyJoiningKillStreak = false;
    player SetClientOmnvar("ui_use_bar_text", 0);
    player SetClientOmnvar("ui_use_bar_end_time", 0);
    player SetClientOmnvar("ui_use_bar_start_time", 0);
  }
}

playerResetAfterCoopStreakInternal() {
  self maps\mp\killstreaks\_killstreaks::takeKillstreakWeaponIfNoDupe("killstreak_predator_missile_mp");
  self maps\mp\killstreaks\_killstreaks::takeKillstreakWeaponIfNoDupe("killstreak_remote_turret_mp");
  self AllowCrouch(true);
  self AllowProne(true);
  self EnableWeaponSwitch();
  self SwitchToWeapon(self getLastWeapon());
  self thread playerDelayControl();
  self Unlink();
}

playerSetupCoopStreakInternal(delay) {
  if(isDefined(delay)) {
    wait delay;
  }

  self EnableWeaponSwitch();
  self _giveWeapon("killstreak_predator_missile_mp");
  self SwitchToWeaponImmediate("killstreak_predator_missile_mp");
  self maps\mp\killstreaks\_killstreaks::takeKillstreakWeaponIfNoDupe("killstreak_remote_turret_mp");
  self DisableWeaponSwitch();
}

playerDelayControl() {
  self endon("disconnect");

  self freezeControlsWrapper(true);
  wait(0.5);
  self freezeControlsWrapper(false);
}

personalUseBar(object, streakPrompt) {
  self endon("disconnect");
  streakPrompt endon("streakPromptStopped");

  self SetClientOmnvar("ui_use_bar_text", 2);
  self SetClientOmnvar("ui_use_bar_start_time", int(GetTime()));

  lastRate = -1;
  while(isReallyAlive(self) && isDefined(object) && object.inUse && !level.gameEnded) {
    if(lastRate != object.useRate) {
      if(object.curProgress > object.useTime) {
        object.curProgress = object.useTime;
      }
      if(object.useRate > 0) {
        now = GetTime();
        current = object.curProgress / object.useTime;
        endTime = now + (1 - current) * (object.useTime / object.useRate);
        self SetClientOmnvar("ui_use_bar_end_time", int(endTime));
      }
      lastRate = object.useRate;
    }
    wait(0.05);
  }

  self SetClientOmnvar("ui_use_bar_end_time", 0);
}

useHoldThinkLoop(player, streakPrompt) {
  streakPrompt endon("streakPromptStopped");

  while(!level.gameEnded && isDefined(self) && isReallyAlive(player) && player useButtonPressed() && self.curProgress < self.useTime) {
    self.curProgress += (50 * self.useRate);

    if(isDefined(self.objectiveScaler)) {
      self.useRate = 1 * self.objectiveScaler;
    } else {
      self.useRate = 1;
    }

    if(self.curProgress >= self.useTime) {
      return (isReallyAlive(player));
    }

    wait 0.05;
  }

  return false;
}