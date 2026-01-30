/***************************************************
 * Decompiled by Alterware and Edited by SyndiShanX
 * Script: maps\mp\gametypes\_battlebuddy.gsc
***************************************************/

#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;

RESPAWN_DELAY = 4000;
RESPAWN_MIN_DELAY = 2000;

BATTLEBUDDY_SPAWN_STATUS_OK = 0;
BATTLEBUDDY_SPAWN_STATUS_INCOMBAT = -1;
BATTLEBUDDY_SPAWN_STATUS_BLOCKED = -2;
BATTLEBUDDY_SPAWN_STATUS_ENEMY_LOS = -3;

init() {
  if(!isDefined(level.battleBuddyWaitList)) {
    level.battleBuddyWaitList = [];
  }

  level thread onPlayerSpawned();
  level thread onPlayerConnect();
}

onPlayerConnect() {
  for(;;) {
    level waittill("connecting", player);

    player thread initTeamSpawnElements();
    player thread onBattleBuddyMenuSelection();
    player thread onDisconnect();
  }
}

onPlayerSpawned() {
  level endon("game_ended");

  for(;;) {
    level waittill("player_spawned", player);

    if(!IsAI(player)) {
      player.isSpawningOnBattleBuddy = undefined;

      if(player wantsBattleBuddy()) {
        if(!(player hasBattleBuddy())) {
          player.firstSpawn = false;

          player findBattleBuddy();
        }
      } else {
        if(player hasBattleBuddy()) {
          player clearBattleBuddy();
        }
      }
    }
  }
}

initTeamSpawnElements() {
  if(!isDefined(self.kc_teamSpawnText)) {
    self.kc_teamSpawnText = newClientHudElem(self);
    self.kc_teamSpawnText.archived = false;
    self.kc_teamSpawnText.y = 34;
    self.kc_teamSpawnText.alignX = "left";
    self.kc_teamSpawnText.alignY = "top";
    self.kc_teamSpawnText.horzAlign = "center";
    self.kc_teamSpawnText.vertAlign = "middle";
    self.kc_teamSpawnText.sort = 10;
    self.kc_teamSpawnText.font = "small";
    self.kc_teamSpawnText.foreground = true;
    self.kc_teamSpawnText.hideWhenInMenu = true;

    if(level.splitscreen) {
      self.kc_teamSpawnText.x = 16;
      self.kc_teamSpawnText.fontscale = 1.2;
    } else {
      self.kc_teamSpawnText.x = 62;
      self.kc_teamSpawnText.fontscale = 1.6;
    }
  }

  if(!isDefined(self.kc_randomSpawnText)) {
    self.kc_randomSpawnText = newClientHudElem(self);
    self.kc_randomSpawnText.archived = false;
    self.kc_randomSpawnText.y = 58;
    self.kc_randomSpawnText.alignX = "left";
    self.kc_randomSpawnText.alignY = "top";
    self.kc_randomSpawnText.horzAlign = "center";
    self.kc_randomSpawnText.vertAlign = "middle";
    self.kc_randomSpawnText.sort = 10;
    self.kc_randomSpawnText.font = "small";
    self.kc_randomSpawnText.foreground = true;
    self.kc_randomSpawnText.hideWhenInMenu = true;

    if(level.splitscreen) {
      self.kc_randomSpawnText.x = 16;
      self.kc_randomSpawnText.fontscale = 1.2;
    } else {
      self.kc_randomSpawnText.x = 62;
      self.kc_randomSpawnText.fontscale = 1.6;
    }
  }
}

onBattleBuddyMenuSelection() {
  self endon("disconnect");
  level endon("game_ended");

  while(true) {
    self waittill("luinotifyserver", channel, value);

    if(channel == "battlebuddy_update") {
      newBBFlag = !(self wantsBattleBuddy());
      self SetPlayerData("enableBattleBuddy", newBBFlag);
      if(newBBFlag) {
        self findBattleBuddy();
      } else {
        if(self hasBattleBuddy()) {
          if(!IsAlive(self.battleBuddy)) {
            self.battleBuddy setupForRandomspawn();
          } else if(!IsAlive(self)) {
            self setupForRandomspawn();
          }

          self clearBattleBuddy();
        } else {
          removeFromBattleBuddyWaitList(self);
          self SetClientDvar("ui_battle_buddy_entity_num", -1);
        }
      }
    } else if(channel == "team_select") {
      removeFromBattleBuddyWaitList(self);
    }
  }
}

onDisconnect() {}

waitForPlayerRespawnChoice() {
  self updateSessionState("spectator");
  self.forceSpectatorClient = self.battleBuddy getEntityNumber();
  self forceThirdPersonWhenFollowing();

  self waitForBuddySpawnTimer();
}

watchForRandomSpawnButton() {
  self endon("disconnect");
  self endon("abort_battlebuddy_spawn");
  self endon("teamSpawnPressed");
  level endon("game_ended");

  self.kc_randomSpawnText setText(&"PLATFORM_PRESS_TO_RESPAWN");
  self.kc_randomSpawnText.alpha = 1;

  self notifyOnPlayerCommand("respawn_random", "+usereload");

  wait(0.5);

  self waittill("respawn_random");

  self setupForRandomspawn();
}

setupForRandomspawn() {
  self clearBuddyMessage();

  self.isSpawningOnBattleBuddy = undefined;

  self notify("randomSpawnPressed");

  self cleanupBuddyspawn();
}

waitForBuddySpawnTimer() {
  self endon("randomSpawnPressed");
  level endon("game_ended");

  if(!isDefined(self.kc_teamSpawnText)) {
    initTeamSpawnElements();
  }

  self.isSpawningOnBattleBuddy = undefined;

  self thread watchForRandomSpawnButton();

  if(isDefined(self.battleBuddyRespawnTimeStamp)) {
    timeToWait = RESPAWN_DELAY - (GetTime() - self.battleBuddyRespawnTimeStamp);

    if(timeToWait < RESPAWN_MIN_DELAY) {
      timeToWait = RESPAWN_MIN_DELAY;
    }
  } else {
    timeToWait = RESPAWN_DELAY;
  }

  result = self checkBuddyspawn();
  if(result.status == BATTLEBUDDY_SPAWN_STATUS_INCOMBAT ||
    result.status == BATTLEBUDDY_SPAWN_STATUS_ENEMY_LOS) {
    self.battleBuddy displayBuddyStatusMessage(&"MP_BUDDY_ERR_COMBAT");
  } else {
    self.battleBuddy displayBuddyStatusMessage(&"MP_BUDDY_INCOMING");
  }

  print("~=== TIME TO WAIT " + timeToWait);
  self updateTimer(&"MP_BUDDY_TIME_UNTIL_SPAWN", timeToWait);

  result = self checkBuddyspawn();
  while(result.status != BATTLEBUDDY_SPAWN_STATUS_OK) {
    if(result.status == BATTLEBUDDY_SPAWN_STATUS_INCOMBAT ||
      result.status == BATTLEBUDDY_SPAWN_STATUS_ENEMY_LOS) {
      self displayBuddyStatusMessage(&"MP_BUDDY_WAITING_COMBAT");
      self.battleBuddy displayBuddyStatusMessage(&"MP_BUDDY_ERR_COMBAT");
    } else if(result.status == BATTLEBUDDY_SPAWN_STATUS_BLOCKED) {
      self displayBuddyStatusMessage(&"MP_BUDDY_WAITING_POINT");
      self.battleBuddy displayBuddyStatusMessage(&"MP_BUDDY_ERR_POINT");
    }

    wait(0.5);
    result = self checkBuddyspawn();
  }

  self.isSpawningOnBattleBuddy = true;
  self thread displayBuddySpawnSuccessful();

  self playLocalSound("copycat_steal_class");
  self notify("teamSpawnPressed");
}

clearBuddyMessage() {
  self.kc_randomSpawnText.alpha = 0;
  self.kc_teamSpawnText.alpha = 0;
  self clearLowerMessage("kc_info");
  self clearLowerMessage("waiting_info");

  if(isDefined(self.battleBuddy)) {
    self.battleBuddy clearLowermessage("waiting_info");
  }
}

displayBuddyStatusMessage(messageID) {
  self setLowerMessage("waiting_info", messageID, undefined, undefined, undefined, undefined, undefined, undefined, true);
}

displayBuddySpawnSuccessful() {
  self clearBuddyMessage();

  if(isDefined(self.battleBuddy)) {
    self.battleBuddy displayBuddyStatusMessage(&"MP_BUDDY_SPAWNED_ON_YOU");
    wait(1.5);
    self.battleBuddy clearLowermessage("waiting_info");
  }
}

checkBuddyspawn() {
  result = spawnStruct();

  if(maps\mp\gametypes\_spawnscoring::isPlayerInCombat(self.battleBuddy)) {
    result.status = BATTLEBUDDY_SPAWN_STATUS_INCOMBAT;
  } else {
    spawnLocation = maps\mp\gametypes\_spawnscoring::findSpawnLocationNearPlayer(self.battleBuddy);

    if(isDefined(spawnLocation)) {
      trace = spawnStruct();
      trace.maxTraceCount = 18;
      trace.currentTraceCount = 0;

      if(!maps\mp\gametypes\_spawnscoring::isSafeToSpawnOn(self.battleBuddy, spawnLocation, trace)) {
        result.status = BATTLEBUDDY_SPAWN_STATUS_ENEMY_LOS;
      } else {
        result.status = BATTLEBUDDY_SPAWN_STATUS_OK;
        result.origin = spawnLocation;
        result.angles = self.battleBuddy.angles;
      }
    } else {
      result.status = BATTLEBUDDY_SPAWN_STATUS_BLOCKED;
    }
  }

  return result;
}

cleanupBuddyspawn() {
  self thread maps\mp\gametypes\_spectating::setSpectatePermissions();
  self.forceSpectatorClient = -1;
  self updateSessionState("dead");
  self disableForceThirdPersonWhenFollowing();
  self.isSpawningOnBattleBuddy = undefined;

  self notify("abort_battlebuddy_spawn");
}

updateTimer(msg, timeToWait) {
  self endon("disconnect");
  self endon("abort_battlebuddy_spawn");
  self endon("teamSpawnPressed");

  timeInSeconds = timeToWait * 0.001;
  self setLowerMessage("kc_info", msg, timeInSeconds, 1, true);

  wait(timeInSeconds);

  self clearLowerMessage("kc_info");
}

updateProgressBar(msg, timeToWait) {
  self endon("disconnect");
  self endon("abort_battlebuddy_spawn");
  self endon("teamSpawnPressed");

  buddyRespawnBar = createPrimaryProgressBar(0, 25);
  buddyRespawnText = createPrimaryProgressBarText(0, 25);
  buddyRespawnText setText(msg);

  invTime = 1.0 / timeToWait;
  startTime = GetTime();

  t = 1.0;
  buddyRespawnBar updateBar(t);
  buddyRespawnBar showElem();
  buddyRespawnText showElem();

  while(!level.gameEnded &&
    t > 0.0
  ) {
    remainingTime = timeToWait - (GetTime() - startTime);
    t = remainingTime * invTime;

    t = clamp(t, 0.0, 1.0);

    print("*** " + remainingTime + " = " + t);

    buddyRespawnBar updateBar(t);

    wait(0.1);
  }

  buddyRespawnBar destroyElem();
  buddyRespawnText destroyElem();
}

wantsBattleBuddy() {
  return self GetPlayerData("enableBattleBuddy");
}

hasBattleBuddy() {
  return isDefined(self.battleBuddy);
}

needsBattleBuddy() {
  return (self wantsBattleBuddy() &&
    !self hasBattleBuddy());
}

isValidBattleBuddy(otherPlayer) {
  return (otherPlayer needsBattleBuddy() &&
    self.team == otherPlayer.team);
}

pairBattleBuddy(otherPlayer) {
  Print("Battle buddy pairing " + (self GetEntityNumber()) + " with " + (otherPlayer GetEntityNumber()) + "\n");
  if(self.team == otherPlayer.team) {
    removeFromBattleBuddyWaitList(otherPlayer);

    self.battleBuddy = otherPlayer;
    otherPlayer.battleBuddy = self;

    self SetClientDvar("ui_battle_buddy_entity_num", otherPlayer GetEntityNumber());
    otherPlayer SetClientDvar("ui_battle_buddy_entity_num", self GetEntityNumber());
  } else {
    Print("Battle buddy error: mis-matched teams!");
  }
}

getWaitingBattleBuddy() {
  return (level.battleBuddyWaitList[self.team]);
}

addToBattleBuddyWaitList(player) {
  AssertEx(!isDefined(level.battleBuddyWaitList[player.team]), "A player is already waiting for a battle buddy: ", level.battleBuddyWaitList[player.team]);
  level.battleBuddyWaitList[player.team] = player;
}

removeFromBattleBuddyWaitList(player) {
  if(isDefined(level.battleBuddyWaitList[player.team]) &&
    player == level.battleBuddyWaitList[player.team]) {
    level.battleBuddyWaitList[player.team] = undefined;
  }
}

findBattleBuddy() {
  if(level.onlineGame) {
    self.fireTeamMembers = self GetFireteamMembers();;
    if(self.fireTeamMembers.size >= 1) {
      foreach(otherPlayer in self.fireTeamMembers) {
        if(self isValidBattleBuddy(otherPlayer)) {
          self pairBattleBuddy(otherPlayer);
        }
      }
    }
  }

  if(!isDefined(self.battleBuddy)) {
    otherPlayer = self getWaitingBattleBuddy();
    if(isDefined(otherPlayer)) {
      self pairBattleBuddy(otherPlayer);
    } else {
      addToBattleBuddyWaitList(self);
      self SetClientDvar("ui_battle_buddy_entity_num", -1);
    }
  }
}

clearBattleBuddy() {
  assert(isDefined(self.battleBuddy));

  otherPlayer = self.battleBuddy;
  self SetClientDvar("ui_battle_buddy_entity_num", -1);
  self.battleBuddy = undefined;
  otherPlayer SetClientDvar("ui_battle_buddy_entity_num", -1);
  otherPlayer.battleBuddy = undefined;

  self SetPlayerData("enableBattleBuddy", false);

  otherPlayer findBattleBuddy();
}