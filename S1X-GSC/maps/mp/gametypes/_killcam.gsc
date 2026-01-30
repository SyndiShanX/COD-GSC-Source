/***************************************************
 * Decompiled by Alterware and Edited by SyndiShanX
 * Script: maps\mp\gametypes\_killcam.gsc
***************************************************/

#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
#include common_scripts\utility;

MAX_KILLCAM_START_TIME = 5;

init() {
  level.killcam = maps\mp\gametypes\_tweakables::getTweakableValue("game", "allowkillcam");
}

setCinematicCameraStyle(cameraStyle, leadingActorId, supportingActorId, leadingActorAltId, supportingActorAltId) {
  self SetClientOmnvar("cam_scene_name", cameraStyle);
  self SetClientOmnvar("cam_scene_lead", leadingActorId);
  self SetClientOmnvar("cam_scene_support", supportingActorId);
  if(isDefined(leadingActorAltId)) {
    self SetClientOmnvar("cam_scene_lead_alt", leadingActorAltId);
  } else {
    self SetClientOmnvar("cam_scene_lead_alt", leadingActorId);
  }
  if(isDefined(supportingActorAltId)) {
    self SetClientOmnvar("cam_scene_support_alt", supportingActorAltId);
  } else {
    self SetClientOmnvar("cam_scene_support_alt", supportingActorId);
  }
}

setKillCameraStyle(eInflictor, attackerNum, killcamentityindex, weaponName, victim, camtime) {
  if(isDefined(eInflictor) && isDefined(eInflictor.agent_type)) {
    if(eInflictor.agent_type == "dog") {
      self setCinematicCameraStyle("killcam_dog", eInflictor GetEntityNumber(), self GetEntityNumber());
    } else {
      self setCinematicCameraStyle("killcam_agent", eInflictor GetEntityNumber(), self GetEntityNumber());
    }
  } else if(isDefined(victim) && isDefined(weaponName) && weaponName == "orbital_laser_fov_mp" && camtime == MAX_KILLCAM_START_TIME) {
    body = -1;
    if(isDefined(victim.body)) {
      body = victim.body GetEntityNumber();
    }
    self thread setCinematicCameraStyle("orbital_laser_killcam", attackerNum, victim GetEntityNumber(), attackerNum, body);
  } else if(killcamentityindex >= 0) {
    self setCinematicCameraStyle("unknown", -1, -1);
    return false;
  }

  killcamlength = camtime + postdelay;

  if(isDefined(maxtime) && killcamlength > maxtime) {
    if(maxtime < 2) {
      prof_end("killcam");
      return;
    }

    if(maxtime - camtime >= 1) {
      postdelay = maxtime - camtime;
    } else {
      postdelay = 1;
      camtime = maxtime - 1;
    }

    killcamlength = camtime + postdelay;
  }

  self SetClientOmnvar("ui_killcam_end_milliseconds", 0);

  if(IsAgent(attacker) && !isDefined(attacker.isActive)) {
    prof_end("killcam");
    return;
  }

  assert(IsGameParticipant(attacker));

  if(IsPlayer(attacker)) {
    self SetClientOmnvar("ui_killcam_killedby_id", attacker GetEntityNumber());
  } else if(IsAgent(attacker)) {
    self SetClientOmnvar("ui_killcam_killedby_id", -1);
  }

  if(isKillstreakWeapon(sWeapon)) {
    AssertEx(isDefined(level.killstreakWieldWeapons[sWeapon]), "Killstreak weapon needs to be added to weapons array: " + sWeapon);
    killstreakRowIdx = getKillstreakRowNum(level.killstreakWieldWeapons[sWeapon]);
    self SetClientOmnvar("ui_killcam_killedby_killstreak", killstreakRowIdx);
    self SetClientOmnvar("ui_killcam_killedby_weapon", -1);
    self SetClientOmnvar("ui_killcam_killedby_attachment1", -1);
    self SetClientOmnvar("ui_killcam_killedby_attachment2", -1);
    self SetClientOmnvar("ui_killcam_killedby_attachment3", -1);
    self SetClientOmnvar("ui_killcam_copycat", false);
  } else {
    attachments = [];

    weaponName = GetWeaponBaseName(sWeapon);
    if(isDefined(weaponName)) {
      if(isMeleeMOD(sMeansOfDeath) && !maps\mp\gametypes\_weapons::isRiotShield(sWeapon)) {
        weaponName = "iw5_combatknife";
      } else {
        weaponName = maps\mp\_utility::strip_suffix(weaponName, "_lefthand");
        weaponName = maps\mp\_utility::strip_suffix(weaponName, "_mp");
      }
      weaponRowIdx = TableLookupRowNum("mp/statsTable.csv", 4, weaponName);
      self SetClientOmnvar("ui_killcam_killedby_weapon", weaponRowIdx);
      self SetClientOmnvar("ui_killcam_killedby_killstreak", -1);

      if(weaponName != "iw5_combatknife") {
        attachments = GetWeaponAttachments(sWeapon);
      }

      if(!level.showingFinalKillcam && practiceRoundGame() && IsPlayer(attacker) && !IsBot(self) && !IsAgent(self) && maps\mp\gametypes\_class::loadoutValidForCopycat(attacker)) {
        self SetClientOmnvar("ui_killcam_copycat", true);
        self thread waitCopycatKillcamButton(attacker);
      } else {
        self SetClientOmnvar("ui_killcam_copycat", false);
      }
    } else {
      self SetClientOmnvar("ui_killcam_killedby_weapon", -1);
      self SetClientOmnvar("ui_killcam_killedby_killstreak", -1);
      self SetClientOmnvar("ui_killcam_copycat", false);
    }

    for(i = 0; i < 3; i++) {
      if(isDefined(attachments[i])) {
        attachmentRowIdx = TableLookupRowNum("mp/attachmentTable.csv", 3, attachmentMap_toBase(attachments[i]));
        self SetClientOmnvar("ui_killcam_killedby_attachment" + (i + 1), attachmentRowIdx);
      } else {
        self SetClientOmnvar("ui_killcam_killedby_attachment" + (i + 1), -1);
      }
    }
  }

  if(timeUntilRespawn && !level.gameEnded || (isDefined(self) && isDefined(self.battleBuddy) && !level.gameEnded)) {
    self SetClientOmnvar("ui_killcam_text", "skip");
  } else if(!level.gameEnded) {
    self SetClientOmnvar("ui_killcam_text", "respawn");
  } else {
    self SetClientOmnvar("ui_killcam_text", "none");
  }

  switch (type) {
    case "score":
      self SetClientOmnvar("ui_killcam_type", 1);
      break;
    case "normal":
    default:
      self SetClientOmnvar("ui_killcam_type", 0);
      break;
  }

  killcamoffset = camtime + predelay + totalKillcamWait;

  startTime = getTime();
  self notify("begin_killcam", startTime);

  if(!isAgent(attacker) && isDefined(attacker) && IsPlayer(victim)) {
    attacker visionsyncwithplayer(victim);
  }

  self updateSessionState("spectator");
  self.spectatekillcam = true;

  if(IsAgent(attacker)) {
    attackerNum = victim GetEntityNumber();
  }

  self OnlyStreamActiveWeapon(false);

  self.forcespectatorclient = attackerNum;
  self.killcamentity = -1;

  usingCinematicKillCam = self setKillCameraStyle(eInflictor, attackerNum, killcamentityindex, sWeapon, victim, camtime);

  if(!usingCinematicKillCam) {
    self thread setKillCamEntity(killcamentityindex, killcamoffset, killcamentitystarttime);
  }

  if(killcamoffset > aliveTime) {
    killcamoffset = aliveTime;
  }

  self.archivetime = killcamoffset;
  self.killcamlength = killcamlength;
  self.psoffsettime = offsetTime;

  self allowSpectateTeam("allies", true);
  self allowSpectateTeam("axis", true);
  self allowSpectateTeam("freelook", true);
  self allowSpectateTeam("none", true);
  if(level.multiTeamBased) {
    foreach(teamname in level.teamNameList) {
      self allowSpectateTeam(teamname, true);
    }
  }

  {
    foreach(teamname in level.teamNameList) {
      self allowSpectateTeam(teamname, true);
    }
  }

  self thread endedKillcamCleanup();

  prof_end("killcam");

  wait 0.05;

  if(!isDefined(self)) {
    return;
  }

  prof_begin("killcam2");
  assertex(self.archivetime <= killcamoffset + 0.0001, "archivetime: " + self.archivetime + ", killcamoffset: " + killcamoffset);
  if(self.archivetime < killcamoffset) {
    println("WARNING: Code trimmed killcam time by " + (killcamoffset - self.archivetime) + " seconds because it doesn't have enough game time recorded!");
  }

  camtime = self.archivetime - .05 - predelay;
  killcamlength = camtime + postdelay;
  self.killcamlength = killcamlength;

  if(camtime <= 0) {
    println("Cancelling killcam because we don't even have enough recorded to show the death.");

    self updateSessionState("dead");
    self ClearKillcamState();

    self notify("killcam_ended");

    prof_end("killcam2");
    return;
  }

  self SetClientOmnvar("ui_killcam_end_milliseconds", int(killcamlength * 1000) + GetTime());

  if(level.showingFinalKillcam) {
    thread doFinalKillCamFX(camtime, killcamentityindex);
  }

  self.killcam = true;

  if(isDefined(self.battleBuddy) && !level.gameEnded) {
    self.battleBuddyRespawnTimeStamp = GetTime();
  }

  self thread spawnedKillcamCleanup();

  self.skippedKillCam = false;
  self.killcamStartedTimeDeciSeconds = getTimePassedDeciSecondsIncludingRounds();

  if(!level.showingFinalKillcam) {
    self thread waitSkipKillcamButton(timeUntilRespawn);
  } else {
    self notify("showing_final_killcam");
  }

  self thread endKillcamIfNothingToShow();

  prof_end("killcam2");
  self waittillKillcamOver();

  if(level.showingFinalKillcam) {
    if(self == attacker) {
      attacker maps\mp\gametypes\_missions::processChallenge("ch_precision_moviestar");
    }

    self thread maps\mp\gametypes\_playerlogic::spawnEndOfGame();
    return;
  }

  self thread killcamCleanup(true);
}

doFinalKillCamFX(camTime, killcamentityindex) {
  if(isDefined(level.doingFinalKillcamFx)) {
    return;
  }
  level.doingFinalKillcamFx = true;

  intoSlowMoTime = camTime;
  if(intoSlowMoTime > 1.0) {
    intoSlowMoTime = 1.0;
    wait(camTime - 1.0);
  }

  setSlowMotion(1.0, 0.25, intoSlowMoTime);
  wait(intoSlowMoTime + .5);
  setSlowMotion(0.25, 1, 1.0);

  level.doingFinalKillcamFx = undefined;
}

waittillKillcamOver() {
  self endon("abort_killcam");

  wait(self.killcamlength - 0.05);
}

setKillCamEntity(killcamentityindex, killcamoffset, starttime) {
  self endon("disconnect");
  self endon("killcam_ended");

  killcamtime = (gettime() - killcamoffset * 1000);

  if(starttime > killcamtime) {
    wait .05;

    killcamoffset = self.archivetime;
    killcamtime = (gettime() - killcamoffset * 1000);

    if(starttime > killcamtime) {
      wait(starttime - killcamtime) / 1000;
    }
  }
  self.killcamentity = killcamentityindex;
}

waitSkipKillcamButton(timeUntilRespawn) {
  self endon("disconnect");
  self endon("killcam_ended");

  while(self useButtonPressed()) {
    wait .05;
  }

  while(!(self useButtonPressed())) {
    wait .05;
  }

  self.skippedKillCam = true;

  if(isDefined(self.pers["totalKillcamsSkipped"])) {
    self.pers["totalKillcamsSkipped"]++;
  }

  if(timeUntilRespawn <= 0) {
    clearLowerMessage("kc_info");
  }

  self notify("abort_killcam");
}

waitCopycatKillcamButton(attacker) {
  self endon("disconnect");
  self endon("killcam_ended");

  assert(IsPlayer(attacker));

  self NotifyOnPlayerCommand("KillCamCopyCat", "weapnext");

  self waittill("KillCamCopyCat");

  self SetClientOmnvar("ui_killcam_copycat", false);

  self playSound("copycat_steal_class");
  maps\mp\gametypes\_class::setCopyCatLoadout(attacker);
}

endKillcamIfNothingToShow() {
  self endon("disconnect");
  self endon("killcam_ended");

  while(1) {
    if(self.archivetime <= 0) {
      break;
    }
    wait .05;
  }

  self notify("abort_killcam");
}

spawnedKillcamCleanup() {
  self endon("disconnect");
  self endon("killcam_ended");

  self waittill("spawned");
  self thread killcamCleanup(false);
}

endedKillcamCleanup() {
  self endon("disconnect");
  self endon("killcam_ended");

  level waittill("game_ended");

  self thread killcamCleanup(true);
}

killcamCleanup(clearState) {
  self SetClientOmnvar("ui_killcam_end_milliseconds", 0);

  self setCinematicCameraStyle("unknown", -1, -1);
  self.killcam = undefined;

  if(isDefined(self.killcamStartedTimeDeciSeconds) && isPlayer(self) && maps\mp\_matchdata::canLogLife(self.lifeId)) {
    currTime = getTimePassedDeciSecondsIncludingRounds();
    setMatchData("lives", self.lifeId, "killcamWatchTimeDeciSeconds", clampToByte(currTime - self.killcamStartedTimeDeciSeconds));
  }

  if(!level.gameEnded) {
    self clearLowerMessage("kc_info");
  }

  self thread maps\mp\gametypes\_spectating::setSpectatePermissions();

  self notify("killcam_ended");

  if(!clearState) {
    return;
  }

  self updateSessionState("dead");
  self ClearKillcamState();
}

cancelKillCamOnUse() {
  self.cancelKillcam = false;
  self thread cancelKillCamOnUse_specificButton(::cancelKillCamUseButton, ::cancelKillCamCallback);
}

cancelKillCamUseButton() {
  return self useButtonPressed();
}
cancelKillCamSafeSpawnButton() {
  return self fragButtonPressed();
}
cancelKillCamCallback() {
  self.cancelKillcam = true;
}
cancelKillCamSafeSpawnCallback() {
  self.cancelKillcam = true;
  self.wantSafeSpawn = true;
}

cancelKillCamOnUse_specificButton(pressingButtonFunc, finishedFunc) {
  self endon("death_delay_finished");
  self endon("disconnect");
  level endon("game_ended");

  for(;;) {
    if(!self[[pressingButtonFunc]]()) {
      wait(0.05);
      continue;
    }

    buttonTime = 0;
    while(self[[pressingButtonFunc]]()) {
      buttonTime += 0.05;
      wait(0.05);
    }

    if(buttonTime >= 0.5) {
      continue;
    }

    buttonTime = 0;

    while(!self[[pressingButtonFunc]]() && buttonTime < 0.5) {
      buttonTime += 0.05;
      wait(0.05);
    }

    if(buttonTime >= 0.5) {
      continue;
    }

    self[[finishedFunc]]();
    return;
  }
}