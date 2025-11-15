/*******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\killstreaks\_jammer.gsc
*******************************************/

#include maps\mp\_utility;
#include common_scripts\utility;
#include maps\mp\killstreaks\_emp_common;

init() {
  level.teamEMPed["allies"] = false;
  level.teamEMPed["axis"] = false;

  level.empPlayer = undefined;
  level.empTimeout = 10.0;
  level.empTimeRemaining = int(level.empTimeout);

  level.killstreakFuncs["jammer"] = ::EMP_Use;

  level thread onPlayerConnect();

  SetDevDvarIfUninitialized("scr_emp_timeout", 15.0);
  SetDevDvarIfUninitialized("scr_emp_damage_debug", 0);
}

onPlayerConnect() {
  for(;;) {
    level waittill("connected", player);
    player thread onPlayerKilled();
    player thread onPlayerSpawned();
  }
}

onPlayerSpawned() {
  self endon("disconnect");

  while(true) {
    self waittill("spawned_player");

    if(self shouldPlayerBeAffectedByEMP()) {
      self applyPerPlayerEMPEffects();
    }
  }
}

onPlayerKilled() {
  self endon("disconnect");

  while(true) {
    self waittill("death");

    self stopEmpJamSequenceImmediate();
  }
}

EMP_Use(lifeId, streakName) {
  assert(isDefined(self));

  myTeam = self.pers["team"];

  if(level.teamBased) {
    otherTeam = level.otherTeam[myTeam];
    self thread EMP_JamTeam(otherTeam);
  } else {
    self thread EMP_JamPlayers(self);
  }

  self maps\mp\_matchdata::logKillstreakEvent("jammer", self.origin);
  self notify("used_emp");
  level notify("emp_used");

  return true;
}

INITIAL_DELAY = 0.5;

EMP_JamTeam(teamName) {
  level endon("game_ended");

  wait(INITIAL_DELAY);

  assert(teamName == "allies" || teamName == "axis");

  thread teamPlayerCardSplash("used_jammer", self);

  level notify("EMP_JamTeam" + teamName);
  level endon("EMP_JamTeam" + teamName);

  level.teamEMPed[teamName] = true;

  foreach(player in level.players) {
    player applyPerPlayerEMPEffects_OnDetonate();

    if(player shouldPlayerBeAffectedByEMP()) {
      player applyPerPlayerEMPEffects();
    }
  }

  level thread applyGlobalEMPEffects();

  level notify("emp_update");

  level destroyGroundObjects(self, teamName);

  level.empTimeout = GetDvarFloat("scr_emp_timeout");

  level thread keepEMPTimeRemaining();
  maps\mp\gametypes\_hostmigration::waitLongDurationWithHostMigrationPause(level.empTimeout);

  level.teamEMPed[teamName] = false;

  foreach(player in level.players) {
    if(player.team == teamName &&
      !(player shouldPlayerBeAffectedByEMP())
    ) {
      player removePerPlayerEMPEffects();
    }
  }

  level notify("emp_update");
}

EMP_JamPlayers(owner) {
  level notify("EMP_JamPlayers");
  level endon("EMP_JamPlayers");

  wait(INITIAL_DELAY);

  if(!isDefined(owner)) {
    return;
  }

  level.empPlayer = owner;
  foreach(player in level.players) {
    player applyPerPlayerEMPEffects_OnDetonate();

    if(player shouldPlayerBeAffectedByEMP()) {
      player applyPerPlayerEMPEffects();
    }
  }

  level thread applyGlobalEMPEffects();

  level notify("emp_update");

  level.empPlayer thread empPlayerFFADisconnect();
  level destroyGroundObjects(owner);

  level.empTimeout = GetDvarFloat("scr_emp_timeout");

  level thread keepEMPTimeRemaining();
  maps\mp\gametypes\_hostmigration::waitLongDurationWithHostMigrationPause(level.empTimeout);

  level.empPlayer = undefined;
  foreach(player in level.players) {
    if((!isDefined(owner) || player != owner) &&
      !(player shouldPlayerBeAffectedByEMP())
    ) {
      player removePerPlayerEMPEffects();
    }
  }

  level notify("emp_update");
  level notify("emp_ended");
}

keepEMPTimeRemaining() {
  level notify("keepEMPTimeRemaining");
  level endon("keepEMPTimeRemaining");

  level endon("emp_ended");

  level.empTimeRemaining = int(level.empTimeout);
  while(level.empTimeRemaining) {
    wait(1.0);
    level.empTimeRemaining--;
  }
}

empPlayerFFADisconnect() {
  level endon("EMP_JamPlayers");
  level endon("emp_ended");

  self waittill("disconnect");
  level notify("emp_update");
}

destroyGroundObjects(attacker, teamEMPed) {
  maps\mp\killstreaks\_killstreaks::destroyTargetArray(attacker, teamEMPed, "killstreak_emp_mp", level.turrets);

  maps\mp\killstreaks\_killstreaks::destroyTargetArray(attacker, teamEMPed, "killstreak_emp_mp", level.placedIMS);

  maps\mp\killstreaks\_killstreaks::destroyTargetArray(attacker, teamEMPed, "killstreak_emp_mp", level.ballDrones);

  thread maps\mp\killstreaks\_killstreaks::destroyTargetArray(attacker, teamEMPed, "killstreak_emp_mp", level.uplinks);

  maps\mp\killstreaks\_killstreaks::destroyTargetArray(attacker, teamEMPed, "killstreak_emp_mp", level.mines);
}