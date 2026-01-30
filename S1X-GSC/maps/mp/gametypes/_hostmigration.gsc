/***************************************************
 * Decompiled by Alterware and Edited by SyndiShanX
 * Script: maps\mp\gametypes\_hostmigration.gsc
***************************************************/

#include maps\mp\_utility;
#include common_scripts\utility;

Callback_HostMigration() {
  level.hostMigrationReturnedPlayerCount = 0;

  if(level.gameEnded) {
    println("Migration starting at time " + gettime() + ", but game has ended, so no countdown.");
    return;
  }

  hostMigrationCount = getMatchData("hostMigrationCount");
  hostMigrationCount++;
  setMatchData("hostMigrationCount", hostMigrationCount);

  println("Migration starting at time " + gettime());

  foreach(character in level.characters) {
    character.hostMigrationControlsFrozen = false;
  }

  level.hostMigrationTimer = true;
  setDvar("ui_inhostmigration", 1);

  level notify("host_migration_begin");
  maps\mp\gametypes\_gamelogic::UpdateTimerPausedness();

  foreach(character in level.characters) {
    character thread hostMigrationTimerThink();

    if(IsPlayer(character)) {
      character SetClientOmnvar("ui_session_state", character.sessionstate);
    }
  }

  SetDvar("ui_game_state", game["state"]);

  level endon("host_migration_begin");
  hostMigrationWait();

  level.hostMigrationTimer = undefined;
  setDvar("ui_inhostmigration", 0);
  println("Migration finished at time " + gettime());

  level notify("host_migration_end");
  maps\mp\gametypes\_gamelogic::UpdateTimerPausedness();

  level thread maps\mp\gametypes\_gamelogic::updateGameEvents();
}

hostMigrationWait() {
  level endon("game_ended");

  level.inGracePeriod = 25;
  thread maps\mp\gametypes\_gamelogic::matchStartTimer(20.0);
  hostMigrationWaitForPlayers();

  level.inGracePeriod = 10;
  thread maps\mp\gametypes\_gamelogic::matchStartTimer(5.0);
  wait 5;
  level.inGracePeriod = false;
}

hostMigrationWaitForPlayers() {
  level endon("hostmigration_enoughplayers");
  wait 15;
}

hostMigrationName(ent) {
  if(!isDefined(ent)) {
    return "<removed_ent>";
  }

  entNum = -1;
  entName = "?";

  if(isDefined(ent.entity_number)) {
    entNum = ent.entity_number;
  }

  if(isPlayer(ent) && isDefined(ent.name)) {
    entName = ent.name;
  }

  if(isPlayer(ent)) {
    return "player <" + entName + "> (entNum " + entNum + " )";
  }

  if(IsAgent(ent) && IsGameParticipant(ent)) {
    return "participant agent <" + entNum + ">";
  }

  if(IsAgent(ent)) {
    return "non-participant agent <" + entNum + ">";
  }

  return "unknown entity <" + entNum + ">";
}

hostMigrationTimerThink_Internal() {
  level endon("host_migration_begin");
  level endon("host_migration_end");
  self endon("disconnect");

  assertex(isDefined(self.hostMigrationControlsFrozen), "Not properly tracking controller frozen for " + hostMigrationName(self));

  self.hostMigrationControlsFrozen = true;

  while(!isReallyAlive(self)) {
    self waittill("spawned");
  }

  println("Migration freezing controls for " + hostMigrationName(self) + " with hostMigrationControlsFrozen = " + self.hostMigrationControlsFrozen);

  self freezeControlsWrapper(true);
  self DisableAmmoGeneration();

  level waittill("host_migration_end");
}

hostMigrationTimerThink() {
  level endon("host_migration_begin");
  self endon("disconnect");

  assertex(isDefined(self.hostMigrationControlsFrozen), "Not properly tracking controller frozen for " + hostMigrationName(self));

  hostMigrationTimerThink_Internal();

  assertex(isDefined(self.hostMigrationControlsFrozen), "Attempted to unfreeze controls for " + hostMigrationName(self));
  println("Migration attempting to unfreeze controls for " + hostMigrationName(self) + " with hostMigrationControlsFrozen = " + self.hostMigrationControlsFrozen);

  if(self.hostMigrationControlsFrozen) {
    if(gameFlag("prematch_done")) {
      self freezeControlsWrapper(false);
      self EnableAmmoGeneration();
    }
    self.hostMigrationControlsFrozen = undefined;
  }

}

waitTillHostMigrationDone() {
  if(!isDefined(level.hostMigrationTimer)) {
    return 0;
  }

  starttime = gettime();
  level waittill("host_migration_end");
  return gettime() - starttime;
}

waitTillHostMigrationStarts(duration) {
  if(isDefined(level.hostMigrationTimer)) {
    return;
  }

  level endon("host_migration_begin");
  wait duration;
}

waitLongDurationWithHostMigrationPause(duration) {
  if(duration == 0) {
    return;
  }
  assert(duration > 0);

  starttime = gettime();

  endtime = gettime() + duration * 1000;

  while(gettime() < endtime) {
    waitTillHostMigrationStarts((endtime - gettime()) / 1000);

    if(isDefined(level.hostMigrationTimer)) {
      timePassed = waitTillHostMigrationDone();
      endtime += timePassed;
    }
  }

  waitTillHostMigrationDone();

  return gettime() - starttime;
}

waittill_notify_or_timeout_hostmigration_pause(msg, duration) {
  self endon(msg);

  if(duration == 0) {
    return;
  }
  assert(duration > 0);

  starttime = gettime();

  endtime = gettime() + duration * 1000;

  while(gettime() < endtime) {
    waitTillHostMigrationStarts((endtime - gettime()) / 1000);

    if(isDefined(level.hostMigrationTimer)) {
      timePassed = waitTillHostMigrationDone();
      endtime += timePassed;
    }
  }

  waitTillHostMigrationDone();

  return gettime() - starttime;
}

waitLongDurationWithGameEndTimeUpdate(duration) {
  if(duration == 0) {
    return;
  }
  assert(duration > 0);

  starttime = gettime();

  endtime = gettime() + duration * 1000;

  while(gettime() < endtime) {
    waitTillHostMigrationStarts((endtime - gettime()) / 1000);

    while(isDefined(level.hostMigrationTimer)) {
      endTime += 1000;
      setGameEndTime(int(endTime));
      wait 1;
    }
  }

  while(isDefined(level.hostMigrationTimer)) {
    endTime += 1000;
    setGameEndTime(int(endTime));
    wait 1;
  }

  return gettime() - starttime;
}