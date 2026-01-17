/*****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\killstreaks\_nuke.gsc
*****************************************/

#include common_scripts\utility;
#include maps\mp\_utility;
#include maps\mp\killstreaks\_emp_common;

init() {
  level.nukeVisionSet = "aftermath_post";

  level._effect["nuke_player"] = loadfx("fx/explosions/player_death_nuke");
  level._effect["nuke_flash"] = loadfx("fx/explosions/player_death_nuke_flash");
  level._effect["nuke_aftermath"] = loadfx("fx/dust/nuke_aftermath_mp");

  level.killstreakFuncs["nuke"] = ::tryUseNuke;

  SetDvarIfUninitialized("scr_nukeTimer", 10);
  SetDvarIfUninitialized("scr_nukeCancelMode", 0);

  level.nukeTimer = getDvarInt("scr_nukeTimer");
  level.cancelMode = getDvarInt("scr_nukeCancelMode");

  if(level.multiTeamBased) {
    for(i = 0; i < level.teamNameList.size; i++) {
      level.teamNukeEMPed[level.teamNameList[i]] = false;
    }
  } else {
    level.teamNukeEMPed["allies"] = false;
    level.teamNukeEMPed["axis"] = false;
  }

  level.nukeEmpTimeout = 60.0;
  level.nukeEmpTimeRemaining = int(level.nukeEmpTimeout);
  level.nukeInfo = spawnStruct();
  level.nukeInfo.xpScalar = 2;
  level.nukeDetonated = undefined;

  level thread onPlayerConnect();

  SetDevDvarIfUninitialized("scr_nuke_empTimeout", 60.0);
  SetDevDvarIfUninitialized("scr_nukeDistance", 5000);
  SetDevDvarIfUninitialized("scr_nukeEndsGame", true);
  SetDevDvarIfUninitialized("scr_nukeDebugPosition", false);
}

tryUseNuke(lifeId, streakName, allowCancel) {
  if(isDefined(level.nukeIncoming)) {
    self iPrintLnBold(&"KILLSTREAKS_NUKE_ALREADY_INBOUND");
    return false;
  }

  if(self isUsingRemote() && (!isDefined(level.gtnw) || !level.gtnw))
    return false;

  if(!isDefined(allowCancel))
    allowCancel = true;

  self thread doNuke(allowCancel);
  self notify("used_nuke");

  self maps\mp\_matchdata::logKillstreakEvent("nuke", self.origin);

  return true;
}

delaythread_nuke(delay, func) {
  level endon("nuke_cancelled");

  maps\mp\gametypes\_hostmigration::waitLongDurationWithHostMigrationPause(delay);

  thread[[func]]();
}

doNuke(allowCancel) {
  level endon("nuke_cancelled");

  level.nukeInfo.player = self;
  level.nukeInfo.team = self.pers["team"];

  level.nukeIncoming = true;

  level.prevUIBombTimer = int(GetOmnvar("ui_bomb_timer"));
  SetOmnvar("ui_bomb_timer", 4);

  if(level.teambased) {
    thread teamPlayerCardSplash("used_nuke", self, self.team);
  } else {
    if(!level.hardcoreMode)
      self IPrintLnBold(&"KILLSTREAKS_FRIENDLY_TACTICAL_NUKE");
  }

  if(!isDefined(level.doNuke_fx) || ![[level.doNuke_fx]]()) {
    if(!isDefined(level.nuke_soundObject)) {
      level.nuke_soundObject = spawn("script_origin", (0, 0, 1));
      level.nuke_soundObject hide();
    }

    level thread delaythread_nuke((level.nukeTimer - 3.3), ::nukeSoundIncoming);
    level thread delaythread_nuke(level.nukeTimer, ::nukeSoundExplosion);
    level thread delaythread_nuke(level.nukeTimer, ::nukeSlowMo);
    level thread delaythread_nuke(level.nukeTimer, ::nukeEffects);
    level thread delaythread_nuke((level.nukeTimer + 0.25), ::nukeVision);
    level thread delaythread_nuke((level.nukeTimer + 1.5), ::nukeDeath);
    level thread delaythread_nuke((level.nukeTimer + 1.5), ::nukeEarthquake);
    level thread nukeAftermathEffect();

    if(level.cancelMode && allowCancel)
      level thread cancelNukeOnDeath(self);
  }

  level thread update_ui_timers();

  if(!isDefined(level.nuke_clockObject)) {
    level.nuke_clockObject = spawn("script_origin", (0, 0, 0));
    level.nuke_clockObject hide();
  }

  nukeTimer = level.nukeTimer;
  while(nukeTimer > 0) {
    level.nuke_clockObject playSound("ui_mp_kem_timer");
    wait(1.0);
    nukeTimer--;
  }
}

doNukeSimple() {
  level.nukeInfo.player = self;
  level.nukeInfo.team = self.pers["team"];
  level.nukeIncoming = true;

  level thread delaythread_nuke((level.nukeTimer - 3.3), ::nukeSoundIncoming);
  level thread delaythread_nuke(level.nukeTimer, ::nukeSoundExplosion);
  level thread delaythread_nuke(level.nukeTimer, ::nukeSlowMo);
  level thread delaythread_nuke(level.nukeTimer, ::nukeEffects);
  level thread delaythread_nuke((level.nukeTimer + 0.25), ::nukeVision);
  level thread delaythread_nuke((level.nukeTimer + 1.5), ::nukeDeathSimple);
  level thread delaythread_nuke((level.nukeTimer + 1.5), ::nukeEarthquake);

  if(!isDefined(level.nuke_soundObject)) {
    level.nuke_soundObject = spawn("script_origin", (0, 0, 1));
    level.nuke_soundObject hide();
  }
}

nukeDeathSimple() {
  level notify("nuke_death");
}

cancelNukeOnDeath(player) {
  player waittill_any("death", "disconnect");

  if(isDefined(player) && level.cancelMode == 2)
    player thread maps\mp\killstreaks\_emp::EMP_Use(0, 0);

  nukeClearTimer();
  level.nukeIncoming = undefined;

  level notify("nuke_cancelled");
}

nukeSoundIncoming() {
  level endon("nuke_cancelled");

  if(isDefined(level.nuke_soundObject))
    level.nuke_soundObject playSound("nuke_incoming");
}

nukeSoundExplosion() {
  level endon("nuke_cancelled");

  if(isDefined(level.nuke_soundObject)) {
    level.nuke_soundObject playSound("nuke_explosion");
    level.nuke_soundObject playSound("nuke_wave");
  }
}

nukeClearTimer() {
  uiBombTimer = 0;
  if(isDefined(level.prevUIBombTimer))
    uiBombTimer = level.prevUIBombTimer;
  SetOmnvar("ui_bomb_timer", uiBombTimer);
}

nukeEffects() {
  level endon("nuke_cancelled");

  nukeClearTimer();

  level.nukeDetonated = true;

  foreach(player in level.players) {
    level thread nukeEffect(player);

  }
}

nukeEffect(player) {
  level endon("nuke_cancelled");

  player endon("disconnect");

  waitframe();

  nukeLoc = undefined;
  dirToNuke = undefined;

  if(!isDefined(level.nukeLoc)) {
    yawAngle = (0, player.angles[1], 0);
    dirToNuke = anglesToForward(yawAngle);

    nukeDistance = 5000;
    /# nukeDistance = getDvarInt( "scr_nukeDistance" );	

    nukeLoc = player.origin + (dirToNuke * nukeDistance);
  } else {
    nukeLoc = level.nukeLoc;
  }

  effectFwd = undefined;
  effectUp = (0, 0, 1);
  if(!isDefined(level.nukeAngles)) {
    effectFwd = AnglesToRight((0, (player.angles[1] + 180), 0));
  } else {
    effectFwd = anglesToForward(level.nukeAngles);
    effectUp = AnglesToUp(level.nukeAngles);
  }

  if(getDvarInt("scr_nukeDebugPosition")) {
    thread draw_line_for_time(nukeLoc, nukeLoc + 500 * effectUp, 1, 0, 0, 20);
    thread draw_line_for_time(nukeLoc, nukeLoc + 500 * effectFwd, 0, 1, 0, 20);
  }

  fxObj = SpawnFXForClient(level._effect["nuke_flash"], nukeLoc, player, effectUp, effectFwd);
  TriggerFX(fxObj);

  player thread cleanupNukeEffect(fxObj, 30);
}

cleanupNukeEffect(fxObj, lifetime) {
  self waitForTimeOrNotify(lifetime, "disconnect");

  fxObj Delete();
}

nukeAftermathEffect() {
  level endon("nuke_cancelled");

  level waittill("spawning_intermission");

  afermathEnt = getEntArray("mp_global_intermission", "classname");
  afermathEnt = afermathEnt[0];
  up = anglestoup(afermathEnt.angles);
  right = anglestoright(afermathEnt.angles);

  playFX(level._effect["nuke_aftermath"], afermathEnt.origin, up, right);
}

nukeSlowMo() {
  level endon("nuke_cancelled");

  SetSlowMotion(1.0, 0.25, 0.5);
  level waittill("nuke_death");
  SetSlowMotion(0.25, 1, 2.0);
}

nukeVision() {
  level endon("nuke_cancelled");

  level.nukeVisionInProgress = true;

  VisionSetPostApply("mpnuke", 3);
  maps\mp\gametypes\_hostmigration::waitLongDurationWithHostMigrationPause(2);

  VisionSetPostApply("nuke_global_flash", .1);
  SetExpFog(0, 956, 0.72, 0.61, 0.39, 0.968, 0.85, 1, 0.298, 0.273, 0.266, .25, (0, 0, -1), 84, 118, 2.75, .984, 124, 100);
  SetDvar("r_materialBloomHQScriptMasterEnable", 0);
  maps\mp\gametypes\_hostmigration::waitLongDurationWithHostMigrationPause(.5);

  level notify("nuke_aftermath_post_started");

  VisionSetPostApply("aftermath_post", .5);

  level waittill("nuke_death");

  level thread updateNukeVisionOnHostMigration();

  level setNukeAftermathVision(5);
}

nukeDeath() {
  level endon("nuke_cancelled");
  level endon("game_ended");

  level notify("nuke_death");

  maps\mp\gametypes\_hostmigration::waitTillHostMigrationDone();

  foreach(character in level.characters) {
    if(nukeCanKill(character)) {
      if(isPlayer(character)) {
        character.nuked = true;
        if(isReallyAlive(character)) {
          character thread maps\mp\gametypes\_damage::finishPlayerDamageWrapper(level.nukeInfo.player, level.nukeInfo.player, 999999, 0, "MOD_EXPLOSIVE", "nuke_mp", character.origin, (0, 0, 1), "none", 0, 0);
        }
      } else {
        character maps\mp\agents\_agents::agent_damage_finished(level.nukeInfo.player, level.nukeInfo.player, 999999, 0, "MOD_EXPLOSIVE", "nuke_mp", character.origin, (0, 0, 1), "none", 0);
      }
    }
  }

  level thread nuke_EMPJam();

  level.nukeIncoming = undefined;
}

nukeCanKill(character) {
  if(!isDefined(level.nukeInfo))
    return false;

  if(level.teambased) {
    if(isDefined(level.nukeInfo.team) && character.team == level.nukeInfo.team)
      return false;
  } else {
    isKillstreakPlayer = isDefined(level.nukeInfo.player) && (character == level.nukeInfo.player);
    ownerIsPlayer = isDefined(level.nukeInfo.player) && isDefined(character.owner) && (character.owner == level.nukeInfo.player);

    if(isKillstreakPlayer || ownerIsPlayer)
      return false;
  }

  return true;
}

nukeEarthquake() {
  level endon("nuke_cancelled");

  level waittill("nuke_death");
}

nuke_EMPJam() {
  level endon("game_ended");

  if(level.teamBased) {
    level nukeEmpJamTeam(getOtherTeam(level.nukeInfo.team));
  } else {
    level.teamNukeEMPed[level.nukeInfo.team] = true;
    level.teamNukeEMPed[getOtherTeam(level.nukeInfo.team)] = true;
    nukeEmpJamPlayers(level.nukeInfo.player);
  }
}

nukeEmpJamTeam(teamName) {
  level endon("game_ended");
  level notify("nuke_EMPJam");
  level endon("nuke_EMPJam");

  assert(teamName == "allies" || teamName == "axis");

  level.teamNukeEMPed[teamName] = true;

  foreach(player in level.players) {
    if(player shouldPlayerBeAffectedByEMP()) {
      player applyPerPlayerEMPEffects();
    }
  }

  level notify("nuke_emp_update");

  level maps\mp\killstreaks\_jammer::destroyGroundObjects(level.nukeInfo.player, teamName);
  level maps\mp\killstreaks\_air_superiority::destroyActiveVehicles(level.nukeInfo.player, teamName);

  level.empTimeout = GetDvarFloat("scr_nuke_empTimeout");

  level thread keepNukeEMPTimeRemaining();
  maps\mp\gametypes\_hostmigration::waitLongDurationWithHostMigrationPause(level.nukeEmpTimeout);

  level.teamNukeEMPed[teamName] = false;

  foreach(player in level.players) {
    if(player.team == teamName &&
      !(player shouldPlayerBeAffectedByEMP())
    ) {
      player removePerPlayerEMPEffects();
      player.nuked = undefined;
    }
  }

  level notify("nuke_emp_update");
  level notify("nuke_emp_ended");
}

nukeEmpJamPlayers(owner) {
  level notify("nuke_EMPJam");
  level endon("nuke_EMPJam");

  if(!isDefined(owner)) {
    return;
  }

  foreach(player in level.players) {
    if(player shouldPlayerBeAffectedByEMP()) {
      player applyPerPlayerEMPEffects();
    }
  }

  level notify("nuke_emp_update");

  level maps\mp\killstreaks\_jammer::destroyGroundObjects(level.nukeInfo.player);
  level maps\mp\killstreaks\_air_superiority::destroyActiveVehicles(level.nukeInfo.player);

  level.empTimeout = GetDvarFloat("scr_emp_timeout");

  level thread keepNukeEMPTimeRemaining();
  maps\mp\gametypes\_hostmigration::waitLongDurationWithHostMigrationPause(level.nukeEmpTimeout);

  level.nukeInfo.player = undefined;
  foreach(player in level.players) {
    if((!isDefined(owner) || player != owner) &&
      !(player shouldPlayerBeAffectedByEMP())
    ) {
      player removePerPlayerEMPEffects();
    }
  }

  level notify("nuke_emp_update");
  level notify("nuke_emp_ended");
}

keepNukeEMPTimeRemaining() {
  level notify("keepNukeEMPTimeRemaining");
  level endon("keepNukeEMPTimeRemaining");

  level endon("nuke_emp_ended");

  level.nukeEmpTimeRemaining = int(level.nukeEmpTimeout);
  while(level.nukeEmpTimeRemaining) {
    wait(1.0);
    level.nukeEmpTimeRemaining--;
  }
}

onPlayerConnect() {
  for(;;) {
    level waittill("connected", player);
    player thread onPlayerSpawned();
  }
}

onPlayerSpawned() {
  self endon("disconnect");

  while(true) {
    self waittill("spawned_player");

    if(isDefined(level.nukeDetonated)) {
      self thread setVisionForPlayer();
    }
  }
}

setVisionForPlayer() {
  wait(0.1);
  self VisionSetPostApplyForPlayer(level.nukeVisionSet, 0);
}

update_ui_timers() {
  level endon("game_ended");
  level endon("disconnect");
  level endon("nuke_cancelled");
  level endon("nuke_death");

  nukeEndMilliseconds = (level.nukeTimer * 1000) + gettime();
  SetOmnvar("ui_nuke_end_milliseconds", nukeEndMilliseconds);

  level waittill("host_migration_begin");

  timePassed = maps\mp\gametypes\_hostmigration::waitTillHostMigrationDone();

  if(timePassed > 0) {
    SetOmnvar("ui_nuke_end_milliseconds", nukeEndMilliseconds + timePassed);
  }
}

updateNukeVisionOnHostMigration() {
  level endon("game_ended");

  while(true) {
    level waittill("host_migration_end");

    level setNukeAftermathVision(0);
  }
}

setNukeAftermathVision(transitionTime) {
  if(isDefined(level.nukeDeathVisionFunc)) {
    level thread[[level.nukeDeathVisionFunc]]();
  } else {
    VisionSetPostApply(level.nukeVisionSet, transitionTime);
  }
}