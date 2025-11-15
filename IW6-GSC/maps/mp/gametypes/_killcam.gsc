/******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\gametypes\_killcam.gsc
******************************************/

#include common_scripts\utility;
#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;

CINEMATIC_CAMERA_NUM_ATTACKER_FINAL_KILLCAM = 5;

init() {
  level.killcam = maps\mp\gametypes\_tweakables::getTweakableValue("game", "allowkillcam");
}

setCinematicCameraStyle(cameraStyle, leadingActorId, supportingActorId) {
  if(attackerNum < 0 || !isDefined(attacker)) {
    return;
  }
  killcamTimes = trimKillCamTime(eInflictor, inflictorAgentInfo, attacker, victim, killcamentityindex, camtime, postdelay, predelay, maxtime);

  if(!isDefined(killcamTimes)) {
    return;
  }
  assert(isDefined(killcamTimes.camtime));
  assert(isDefined(killcamTimes.postdelay));
  assert(isDefined(killcamTimes.killcamlength));
  assert(isDefined(killcamTimes.killcamoffset));

  self SetClientOmnvar("ui_killcam_end_milliseconds", 0);

  assert(IsGameParticipant(attacker));

  if(IsPlayer(attacker)) {
    self SetClientOmnvar("ui_killcam_killedby_id", attacker GetEntityNumber());
    self SetClientOmnvar("ui_killcam_victim_id", victim GetEntityNumber());
    self LoadCustomizationPlayerView(attacker);
  }

  if(isKillstreakWeapon(sWeapon)) {
    {
      if(sMeansOfDeath == "MOD_MELEE" && maps\mp\killstreaks\_killstreaks::isAirdropMarker(sWeapon)) {
        weaponRowIdx = TableLookupRowNum("mp/statsTable.csv", 4, "iw6_knifeonly");
        self SetClientOmnvar("ui_killcam_killedby_weapon", weaponRowIdx);
        self SetClientOmnvar("ui_killcam_killedby_killstreak", -1);
      } else {
        killstreakRowIdx = getKillstreakRowNum(level.killstreakWeildWeapons[sWeapon]);
        self SetClientOmnvar("ui_killcam_killedby_killstreak", killstreakRowIdx);
        self SetClientOmnvar("ui_killcam_killedby_weapon", -1);
        self SetClientOmnvar("ui_killcam_killedby_attachment1", -1);
        self SetClientOmnvar("ui_killcam_killedby_attachment2", -1);
        self SetClientOmnvar("ui_killcam_killedby_attachment3", -1);
        self SetClientOmnvar("ui_killcam_killedby_attachment4", -1);
      }
    }
  } else {
    attachments = [];
    weaponName = GetWeaponBaseName(sWeapon);
    if(isDefined(weaponName)) {
      if(sMeansOfDeath == "MOD_MELEE" && (!maps\mp\gametypes\_weapons::isRiotShield(sWeapon))) {
        weaponName = "iw6_knifeonly";
      } else {
        weaponName = weaponMap(weaponName);
        weaponName = strip_suffix(weaponName, "_mp");
      }
      weaponRowIdx = TableLookupRowNum("mp/statsTable.csv", 4, weaponName);
      self SetClientOmnvar("ui_killcam_killedby_weapon", weaponRowIdx);
      self SetClientOmnvar("ui_killcam_killedby_killstreak", -1);

      if(weaponName != "iw6_knifeonly")
        attachments = GetWeaponAttachments(sWeapon);
    } else {
      self SetClientOmnvar("ui_killcam_killedby_weapon", -1);
      self SetClientOmnvar("ui_killcam_killedby_killstreak", -1);
    }

    for(i = 0; i < 4; i++) {
      if(isDefined(attachments[i])) {
        attachmentRowIdx = TableLookupRowNum("mp/attachmentTable.csv", 4, attachmentMap_toBase(attachments[i]));
        self SetClientOmnvar("ui_killcam_killedby_attachment" + (i + 1), attachmentRowIdx);
      } else {
        self SetClientOmnvar("ui_killcam_killedby_attachment" + (i + 1), -1);
      }
    }

    bit_mask = [0, 0];
    pers_loadout_perks = attacker.pers["loadoutPerks"];
    for(i = 0; i < pers_loadout_perks.size; i++) {
      idx = int(TableLookup("mp/killCamAbilitiesBitMaskTable.csv", 1, pers_loadout_perks[i], 0));
      if(idx == 0)
        continue;
      bitmaskIdx = int((idx - 1) / 24);
      bit = 1 << ((idx - 1) % 24);
      bit_mask[bitmaskIdx] |= bit;
    }
    self SetClientOmnvar("ui_killcam_killedby_abilities1", bit_mask[0]);
    self SetClientOmnvar("ui_killcam_killedby_abilities2", bit_mask[1]);
  }

  forceRespawn = GetDvarInt("scr_player_forcerespawn");
  if(timeUntilRespawn && !level.gameEnded || (isDefined(self) && isDefined(self.battleBuddy) && !level.gameEnded) ||
    forceRespawn == false && !level.gameEnded) {
    self SetClientOmnvar("ui_killcam_text", "skip");
  } else if(!level.gameEnded) {
    self SetClientOmnvar("ui_killcam_text", "respawn");
  } else {
    self SetClientOmnvar("ui_killcam_text", "none");
  }

  startTime = getTime();
  self notify("begin_killcam", startTime);

  if(!isAgent(attacker) && isDefined(attacker))
    attacker visionsyncwithplayer(victim);

  self updateSessionState("spectator", "hud_status_dead");
  self.spectatekillcam = true;

  if(IsAgent(attacker) || IsAgent(eInflictor)) {
    attackerNum = victim GetEntityNumber();

    offsetTime -= 25;
  }

  self.forcespectatorclient = attackerNum;
  self.killcamentity = -1;

  usingCinematicKillCam = self setKillCameraStyle(eInflictor, inflictorAgentInfo, attackerNum, victim, killcamentityindex, killcamTimes);

  if(!usingCinematicKillCam)
    self thread setKillCamEntity(killcamentityindex, killcamTimes.killcamoffset, killcamentitystarttime);

  self.archivetime = killcamTimes.killcamoffset;
  self.killcamlength = killcamTimes.killcamlength;
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

  self thread endedKillcamCleanup();

  wait 0.05;

  if(!isDefined(self)) {
    return;
  }
  assertex(self.archivetime <= killcamTimes.killcamoffset + 0.0001, "archivetime: " + self.archivetime + ", killcamTimes.killcamoffset: " + killcamTimes.killcamoffset);
  if(self.archivetime < killcamTimes.killcamoffset) {
    truncation_amount = killcamTimes.killcamoffset - self.archivetime;
    if(game["truncated_killcams"] < 32) {
      println("Truncated killcam is being recorded. Count = " + game["truncated_killcams"]);
      setMatchData("killcam", game["truncated_killcams"], truncation_amount);
      game["truncated_killcams"]++;
    }
    println("WARNING: Code trimmed killcam time by " + truncation_amount + " seconds because it doesn't have enough game time recorded!");
  }

  killcamTimes.camtime = self.archivetime - .05 - predelay;
  killcamTimes.killcamlength = killcamTimes.camtime + killcamTimes.postdelay;
  self.killcamlength = killcamTimes.killcamlength;

  if(killcamTimes.camtime <= 0) {
    println("Cancelling killcam because we don't even have enough recorded to show the death.");

    self updateSessionState("dead");
    self ClearKillcamState();

    self notify("killcam_ended");

    return;
  }

  showFinalKillcamFX = level.showingFinalKillcam;

  self SetClientOmnvar("ui_killcam_end_milliseconds", int(killcamTimes.killcamlength * 1000) + GetTime());
  if(showFinalKillcamFX)
    self SetClientOmnvar("ui_killcam_victim_or_attacker", 1);

  if(getDvarInt("scr_devfinalkillcam") != 0)
    showFinalKillcamFX = !IsBot(victim) && !IsAgent(victim);

  if(showFinalKillcamFX)
    self thread doFinalKillCamFX(killcamTimes, self.killcamentity, attacker, victim, sMeansOfDeath);

  self.killcam = true;

  if(isDefined(self.battleBuddy) && !level.gameEnded) {
    self.battleBuddyRespawnTimeStamp = GetTime();
  }

  self thread spawnedKillcamCleanup();

  if(!level.showingFinalKillcam)
    self thread waitSkipKillcamButton(timeUntilRespawn);
  else
    self notify("showing_final_killcam");

  self thread endKillcamIfNothingToShow();

  self waittillKillcamOver();

  if(level.showingFinalKillcam) {
    self thread maps\mp\gametypes\_playerlogic::spawnEndOfGame();
    return;
  }

  self thread calculateKillCamTime(startTime);

  self thread killcamCleanup(true);
}

doFinalKillCamFX(killcamInfo, killcamentityindex, eAttacker, eVictim, sMeansOfDeath) {
  self endon("killcam_ended");

  if(isDefined(level.doingFinalKillcamFx)) {
    return;
  }
  level.doingFinalKillcamFx = true;
  camTime = killcamInfo.camTime;

  accumTime = 0;

  victimNum = eVictim GetEntityNumber();

  if(!isDefined(killcamInfo.attackerNum))
    killcamInfo.attackerNum = eAttacker GetEntityNumber();

  intoSlowMoTime = camTime;
  if(intoSlowMoTime > 1.0) {
    intoSlowMoTime = 1.0;
    accumTime += 1.0;
    wait(camTime - accumTime);
  }
  SetSlowMotion(1.0, 0.25, intoSlowMoTime);

  wait(intoSlowMoTime + .5);

  SetSlowMotion(0.25, 1, 1);

  level.doingFinalKillcamFx = undefined;
}

calculateKillCamTime(startTime) {
  watchedTime = int(getTime() - startTime);
  self incPlayerStat("killcamtimewatched", watchedTime);
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

    if(starttime > killcamtime)
      wait(starttime - killcamtime) / 1000;
  }
  self.killcamentity = killcamentityindex;
}

waitSkipKillcamButton(timeUntilRespawn) {
  self endon("disconnect");
  self endon("killcam_ended");

  if(!IsAI(self)) {
    self NotifyOnPlayerCommand("kc_respawn", "+usereload");
    self NotifyOnPlayerCommand("kc_respawn", "+activate");

    self waittill("kc_respawn");

    self.cancelKillcam = true;

    if(!matchMakingGame())
      self incPlayerStat("killcamskipped", 1);

    if(timeUntilRespawn <= 0)
      clearLowerMessage("kc_info");

    self notify("abort_killcam");
  }
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

  self.killcam = undefined;

  showingFinalKillcam = level.showingFinalKillcam;

  if(getDvarInt("scr_devfinalkillcam") != 0) {
    showingFinalKillcam = true;
    SetSlowMotion(1.0, 1.0, 0.0);
    level.doingFinalKillcamFx = undefined;
  }

  if(!showingFinalKillcam)
    self setCinematicCameraStyle("unknown", -1, -1);

  if(!level.gameEnded)
    self clearLowerMessage("kc_info");

  self thread maps\mp\gametypes\_spectating::setSpectatePermissions();

  self notify("killcam_ended");

  if(!clearState) {
    return;
  }
  self updateSessionState("dead");
  self ClearKillcamState();
}