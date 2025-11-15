/**********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\gametypes\_battlebuddy.gsc
**********************************************/

#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;

RESPAWN_DELAY = 4000;
RESPAWN_MIN_DELAY = 2000;

BATTLEBUDDY_SPAWN_STATUS_OK = 0;
BATTLEBUDDY_SPAWN_STATUS_INCOMBAT = -1;
BATTLEBUDDY_SPAWN_STATUS_BLOCKED = -2;
BATTLEBUDDY_SPAWN_STATUS_ENEMY_LOS = -3;
BATTLEBUDDY_SPAWN_STATUS_BUDDY_DEAD = -4;

init() {
  if(level.teamBased &&
    !isDefined(level.noBuddySpawns)
  ) {
    if(!isDefined(level.battleBuddyWaitList)) {
      level.battleBuddyWaitList = [];
    }

    level thread onPlayerSpawned();
    level thread onPlayerConnect();
  }
}

onPlayerConnect() {
  for(;;) {
    level waittill("connected", player);

    player thread onBattleBuddyMenuSelection();
    player thread onDisconnect();
  }
}

onPlayerSpawned() {
  level endon("game_ended");

  for(;;) {
    level waittill("player_spawned", player);

    if(!IsAI(player)) {
      if(isDefined(player.isSpawningOnBattleBuddy)) {
        player.isSpawningOnBattleBuddy = undefined;

        if(isDefined(player.battleBuddy) && IsAlive(player.battleBuddy)) {
          if(player.battleBuddy GetStance() != "stand") {
            player SetStance("crouch");
          }
        }
      }

      if(player wantsBattleBuddy()) {
        if(!(player hasBattleBuddy())) {
          player.firstSpawn = false;

          player findBattleBuddy();
        }
      } else {
        player leaveBattleBuddySystem();
      }
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
      self SetCommonPlayerData("enableBattleBuddy", newBBFlag);
      if(newBBFlag) {
        self findBattleBuddy();
      } else {
        self leaveBattleBuddySystem();
      }
    } else if(channel == "team_select" &&
      self.hasSpawned
    ) {
      bbFlag = self wantsBattleBuddy();

      self leaveBattleBuddySystem();

      self SetCommonPlayerData("enableBattleBuddy", bbFlag);
    }
  }
}

onDisconnect() {
  self waittill("disconnect");

  self leaveBattleBuddySystemDisconnect();
}

waitForPlayerRespawnChoice() {
  self updateSessionState("spectator");
  self.forceSpectatorClient = self.battleBuddy getEntityNumber();
  self forceThirdPersonWhenFollowing();

  self SetClientOmnvar("cam_scene_name", "over_shoulder");
  self SetClientOmnvar("cam_scene_lead", self.battleBuddy getEntityNumber());

  self waitForBuddySpawnTimer();
}

watchForRandomSpawnButton() {
  self endon("disconnect");
  self endon("abort_battlebuddy_spawn");
  self endon("teamSpawnPressed");
  level endon("game_ended");

  self SetClientOmnvar("ui_battlebuddy_showButtonPrompt", true);

  self NotifyOnPlayerCommand("respawn_random", "+usereload");
  self NotifyOnPlayerCommand("respawn_random", "+activate");

  wait(0.5);

  self waittill("respawn_random");

  self SetClientOmnvar("ui_battlebuddy_timer_ms", 0);
  self SetClientOmnvar("ui_battlebuddy_showButtonPrompt", false);

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
  if(result.status == BATTLEBUDDY_SPAWN_STATUS_OK) {
    self.battleBuddy SetClientOmnvar("ui_battlebuddy_status", "incoming");
  } else if(result.status == BATTLEBUDDY_SPAWN_STATUS_INCOMBAT ||
    result.status == BATTLEBUDDY_SPAWN_STATUS_ENEMY_LOS) {
    self.battleBuddy SetClientOmnvar("ui_battlebuddy_status", "err_combat");
  } else {
    self.battleBuddy SetClientOmnvar("ui_battlebuddy_status", "err_pos");
  }

  self updateTimer(timeToWait);

  result = self checkBuddyspawn();
  while(result.status != BATTLEBUDDY_SPAWN_STATUS_OK) {
    if(result.status == BATTLEBUDDY_SPAWN_STATUS_INCOMBAT ||
      result.status == BATTLEBUDDY_SPAWN_STATUS_ENEMY_LOS) {
      self SetClientOmnvar("ui_battlebuddy_status", "wait_combat");
      self.battleBuddy SetClientOmnvar("ui_battlebuddy_status", "err_combat");
    } else if(result.status == BATTLEBUDDY_SPAWN_STATUS_BLOCKED) {
      self SetClientOmnvar("ui_battlebuddy_status", "wait_pos");
      self.battleBuddy SetClientOmnvar("ui_battlebuddy_status", "err_pos");
    } else if(result.status == BATTLEBUDDY_SPAWN_STATUS_BUDDY_DEAD) {
      self cleanupBuddyspawn();
      return;
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
  self SetClientOmnvar("ui_battlebuddy_status", "none");
  self SetClientOmnvar("ui_battlebuddy_showButtonPrompt", false);

  if(isDefined(self.battleBuddy)) {
    self.battleBuddy SetClientOmnvar("ui_battlebuddy_status", "none");
  }
}

displayBuddyStatusMessage(messageID) {
  self setLowerMessage("waiting_info", messageID, undefined, undefined, undefined, undefined, undefined, undefined, true);
}

displayBuddySpawnSuccessful() {
  self clearBuddyMessage();

  if(isDefined(self.battleBuddy)) {
    self.battleBuddy SetClientOmnvar("ui_battlebuddy_status", "on_you");
    wait(1.5);
    self.battleBuddy SetClientOmnvar("ui_battlebuddy_status", "none");
  }
}

checkBuddyspawn() {
  result = spawnStruct();

  if(!isDefined(self.battleBuddy) || !IsAlive(self.battleBuddy)) {
    result.status = BATTLEBUDDY_SPAWN_STATUS_BUDDY_DEAD;
    return result;
  }

  if(maps\mp\gametypes\_spawnscoring::isPlayerInCombat(self.battleBuddy, true)) {
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
        dirToBuddy = self.battleBuddy.origin - spawnLocation;
        result.angles = (0, self.battleBuddy.angles[1], 0);
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

  self SetClientOmnvar("cam_scene_name", "unknown");

  self clearBuddyMessage();

  self notify("abort_battlebuddy_spawn");
}

updateTimer(timeToWait) {
  self endon("disconnect");
  self endon("abort_battlebuddy_spawn");
  self endon("teamSpawnPressed");

  timeInSeconds = timeToWait * 0.001;
  self SetClientOmnvar("ui_battlebuddy_timer_ms", timeToWait + GetTime());

  wait(timeInSeconds);

  self SetClientOmnvar("ui_battlebuddy_timer_ms", 0);
}

wantsBattleBuddy() {
  return self GetCommonPlayerData("enableBattleBuddy");
}

hasBattleBuddy() {
  return isDefined(self.battleBuddy);
}

needsBattleBuddy() {
  return (self wantsBattleBuddy() &&
    !self hasBattleBuddy());
}

isValidBattleBuddy(otherPlayer) {
  return (self != otherPlayer &&
    self.team == otherPlayer.team &&
    otherPlayer needsBattleBuddy()
  );
}

canBuddyspawn() {
  return (self hasBattleBuddy() && isReallyAlive(self.battleBuddy));
}

pairBattleBuddy(otherPlayer) {
  removeFromBattleBuddyWaitList(otherPlayer);

  self.battleBuddy = otherPlayer;
  otherPlayer.battleBuddy = self;

  self SetClientOmnvar("ui_battlebuddy_idx", otherPlayer GetEntityNumber());
  otherPlayer SetClientOmnvar("ui_battlebuddy_idx", self GetEntityNumber());
}

getWaitingBattleBuddy() {
  return (level.battleBuddyWaitList[self.team]);
}

addToBattleBuddyWaitList(player) {
  if(!isDefined(level.battleBuddyWaitList[player.team])) {
    level.battleBuddyWaitList[player.team] = player;
  } else if(level.battleBuddyWaitList[player.team] != player) {
    Print("There is already a player: " + (level.battleBuddyWaitList[player.team] GetEntityNumber()) + " but trying to add: " + (player GetEntityNumber()));
  }
}

removeFromBattleBuddyWaitList(player) {
  if(isDefined(player.team) &&
    isDefined(level.battleBuddyWaitList[player.team]) &&
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

  if(!(self hasBattleBuddy())) {
    otherPlayer = self getWaitingBattleBuddy();
    if(isDefined(otherPlayer) && self isValidBattleBuddy(otherPlayer)) {
      self pairBattleBuddy(otherPlayer);
    } else {
      addToBattleBuddyWaitList(self);
      self SetClientOmnvar("ui_battlebuddy_idx", -1);
    }
  }
}

clearBattleBuddy() {
  if(!IsAlive(self)) {
    self setupForRandomspawn();
  }

  self SetClientOmnvar("ui_battlebuddy_idx", -1);
  self.battleBuddy = undefined;
}

leaveBattleBuddySystem() {
  if(self hasBattleBuddy()) {
    otherPlayer = self.battleBuddy;

    self clearBattleBuddy();
    self SetCommonPlayerData("enableBattleBuddy", false);

    otherPlayer clearBattleBuddy();
    otherPlayer findBattleBuddy();
  } else {
    removeFromBattleBuddyWaitList(self);

    self SetClientOmnvar("ui_battlebuddy_idx", -1);
  }
}

leaveBattleBuddySystemDisconnect() {
  if(self hasBattleBuddy()) {
    otherPlayer = self.battleBuddy;
    otherPlayer clearBattleBuddy();
    otherPlayer findBattleBuddy();

    otherPlayer clearBuddyMessage();
  } else {
    foreach(teamName, waitingPlayer in level.battleBuddyWaitList) {
      if(waitingPlayer == self) {
        level.battleBuddyWaitList[teamName] = undefined;
        break;
      }
    }
  }
}