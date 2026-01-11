/**************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\gametypes\_intelchallenges.gsc
**************************************************/

#include common_scripts\utility;
#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;

INTEL_MINIGUN_REWARD_DURATION = 60;
INTEL_MINIGUN_REWARD_EXPIRE_FLASH_DURATION = 8;

giveChallenge(challengeIndex) {
  self thread deathWatcher();

  omnvar_index = TableLookupRowNum("mp/intelChallenges.csv", 0, challengeIndex);
  self SetClientOmnvar("ui_intel_active_index", omnvar_index);

  switch (challengeIndex) {
    case "ch_intel_headshots":
      self thread intelHeadshotChallenge(challengeIndex);
      break;
    case "ch_intel_kills":
      self thread intelKillsChallenge(challengeIndex);
      break;
    case "ch_intel_knifekill":
      self thread intelKnifeKillChallenge(challengeIndex);
      break;
    case "ch_intel_explosivekill":
      self thread intelBombKillChallenge(challengeIndex);
      break;
    case "ch_intel_crouchkills":
      self thread intelCrouchKillsChallenge(challengeIndex);
      break;
    case "ch_intel_pronekills":
      self thread intelProneKillsChallenge(challengeIndex);
      break;
    case "ch_intel_backshots":
      self thread intelBackKillsChallenge(challengeIndex);
      break;
    case "ch_intel_jumpshot":
      self thread intelJumpShotKillsChallenge(challengeIndex);
      break;
    case "ch_intel_secondarykills":
      self thread intelSecondaryKillsChallenge(challengeIndex);
      break;
    case "ch_intel_foundshot":
      self thread intelFoundshotKillsChallenge(challengeIndex);
      break;
    case "ch_intel_tbag":
      self thread intelTbagChallenge(challengeIndex);
      break;
    default:
      AssertMsg(challengeIndex + " not found");
  }
}

giveTeamChallenge(challengeIndex, team) {
  switch (challengeIndex) {
    case "ch_team_intel_melee":
      level thread intelTeamMelee(challengeIndex, team);
      break;
    case "ch_team_intel_headshot":
      level thread intelTeamHeadShot(challengeIndex, team);
      break;
    case "ch_team_intel_killstreak":
      level thread intelTeamKillStreak(challengeIndex, team);
      break;
    case "ch_team_intel_equipment":
      level thread intelTeamEquipment(challengeIndex, team);
      break;
    default:
      AssertMsg(challengeIndex + " not found");
  }
}

intelTeamMelee(challengeReference, team) {
  level endon("game_ended");
  level endon("giveTeamIntel");
  level endon("teamIntelFail");

  level.numMeleeKillsIntel = 0;
  numKillsTarget = level.intelChallengeArray[challengeReference].challengeTarget;
  omnvar_index = TableLookupRowNum("mp/intelChallenges.csv", 0, challengeReference);

  level thread teamIntelStartHUD(challengeReference, team, omnvar_index, numKillsTarget);

  while(level.numMeleeKillsIntel < numKillsTarget) {
    level waittill("enemy_death");
    setTeamIntelProgress(numKillsTarget - level.numMeleeKillsIntel);
  }

  teamIntelEndHUD(challengeReference, team);
  level thread intelTeamReward(team);
}

setTeamIntelProgress(progress) {
  level.updateIntelProgress = Int(Max(progress, 0));
  updateTeamIntelProgress(level.updateIntelProgress);
}

updateTeamIntelProgress(progress) {
  level.currentTeamIntelProgress = progress;
  foreach(player in level.players) {
    player playerUpdateTeamIntelProgress();
  }
}

playerUpdateTeamIntelProgress() {
  self SetClientOmnvar("ui_intel_progress_current", level.currentTeamIntelProgress);
}

playerUpdateIntelProgress(updateIntelProgress) {
  self SetClientOmnvar("ui_intel_progress_current", updateIntelProgress);
}

intelTeamHeadShot(challengeReference, team) {
  level endon("game_ended");
  level endon("giveTeamIntel");
  level endon("teamIntelFail");

  level.numHeadShotsIntel = 0;
  numKillsTarget = level.intelChallengeArray[challengeReference].challengeTarget;
  omnvar_index = TableLookupRowNum("mp/intelChallenges.csv", 0, challengeReference);

  level thread teamIntelStartHUD(challengeReference, team, omnvar_index, numKillsTarget);

  while(level.numHeadShotsIntel < numKillsTarget) {
    level waittill("enemy_death");
    setTeamIntelProgress(numKillsTarget - level.numHeadShotsIntel);
  }

  teamIntelEndHUD(challengeReference, team);
  level thread intelTeamReward(team);
}

intelTeamKillStreak(challengeReference, team) {
  level endon("game_ended");
  level endon("giveTeamIntel");
  level endon("teamIntelFail");

  level.numKillStreakKillsIntel = 0;
  numKillsTarget = level.intelChallengeArray[challengeReference].challengeTarget;
  omnvar_index = TableLookupRowNum("mp/intelChallenges.csv", 0, challengeReference);

  level thread teamIntelStartHUD(challengeReference, team, omnvar_index, numKillsTarget);

  while(level.numKillStreakKillsIntel < numKillsTarget) {
    level waittill("enemy_death");
    setTeamIntelProgress(numKillsTarget - level.numKillStreakKillsIntel);
  }

  teamIntelEndHUD(challengeReference, team);
  level thread intelTeamReward(team);
}

intelTeamEquipment(challengeReference, team) {
  level endon("game_ended");
  level endon("giveTeamIntel");
  level endon("teamIntelFail");

  level.numEquipmentKillsIntel = 0;
  numKillsTarget = level.intelChallengeArray[challengeReference].challengeTarget;
  omnvar_index = TableLookupRowNum("mp/intelChallenges.csv", 0, challengeReference);

  level thread teamIntelStartHUD(challengeReference, team, omnvar_index, numKillsTarget);

  while(level.numEquipmentKillsIntel < numKillsTarget) {
    level waittill("enemy_death");
    setTeamIntelProgress(numKillsTarget - level.numEquipmentKillsIntel);
  }

  teamIntelEndHUD(challengeReference, team);
  level thread intelTeamReward(team);
}

teamIntelStartHUD(challengeReference, team, omnvar_index, intelTarget) {
  level endon("game_ended");
  level endon("giveTeamIntel");
  level endon("teamIntelFail");
  level endon("teamIntelComplete");

  level.isTeamIntelComplete = false;
  level.currentTeamIntelName = challengeReference;
  level.currentTeamIntelProgress = intelTarget;

  foreach(player in level.players) {
    player playerTeamIntelStartHUD(challengeReference, team, omnvar_index, intelTarget);
  }

  while(1) {
    level waittill("player_spawned", player);
    player playerTeamIntelStartHUD(challengeReference, team, omnvar_index, intelTarget);
  }
}

playerTeamIntelStartHUD(challengeReference, team, omnvar_index, intelTarget) {
  if(self.team != team) {
    return;
  }
  self SetClientOmnvar("ui_intel_active_index", omnvar_index);
  self playerUpdateTeamIntelProgress();

  if(isReallyAlive(self)) {
    self thread maps\mp\gametypes\_hud_message::SplashNotify(challengeReference + "_received");
  }
}

teamIntelEndHUD(challengeReference, team) {
  level notify("teamIntelComplete");

  foreach(player in level.players) {
    if(player.team != team) {
      continue;
    }
    player SetClientOmnvar("ui_intel_active_index", -1);
    player SetClientOmnvar("ui_intel_progress_current", -1);

    if(isReallyAlive(player)) {
      player thread maps\mp\gametypes\_hud_message::SplashNotify(challengeReference);
    }
  }
}

intelTeamReward(team) {
  level endon("game_ended");

  level notify("intelTeamReward");

  foreach(player in level.players) {
    if(player.team != team) {
      continue;
    }
    if(!isReallyAlive(player)) {
      continue;
    }
    player thread intelTeamRewardPlayer();
  }

  level.isTeamIntelComplete = true;
}

intelTeamRewardPlayerWaitTillComplete(rewardTime) {
  level endon("intelTeamReward");
  while(rewardTime) {
    wait(1.0);
    maps\mp\gametypes\_hostmigration::waitTillHostMigrationDone();

    if((!isDefined(self.isCarrying) || self.isCarrying == 0) && !isDefined(self.ui_securing)) {
      rewardTime = max(0, rewardTime - 1.0);
    }

    if(rewardTime == INTEL_MINIGUN_REWARD_EXPIRE_FLASH_DURATION) {
      self childthread flashIntelIcon();
    }
  }
}

intelTeamRewardPlayer() {
  level endon("game_ended");
  player = self;

  player givePerk("specialty_explosivebullets", false);

  player SetClientOmnvar("ui_horde_update_explosive", 1);

  player _giveWeapon(level.intelMiniGun);
  player GiveStartAmmo(level.intelMiniGun);

  if((player isWeaponEnabled()) && (player isUsabilityEnabled()) && !(player isUsingRemote()) && !(player maps\mp\killstreaks\_killstreaks::isUsingHeliSniper())) {
    player SwitchToWeaponImmediate(level.intelMiniGun);
  }

  player intelTeamRewardPlayerWaitTillComplete(INTEL_MINIGUN_REWARD_DURATION);

  player _unsetPerk("specialty_explosivebullets");

  player SetClientOmnvar("ui_horde_update_explosive", 0);

  cuurentWeaponName = player GetCurrentPrimaryWeapon();
  player TakeWeapon(level.intelMiniGun);

  if(cuurentWeaponName == level.intelMiniGun) {
    nextWeaponName = player maps\mp\killstreaks\_killstreaks::getFirstPrimaryWeapon();
    player SwitchToWeaponImmediate(nextWeaponName);
  }
}

flashIntelIcon() {
  self endon("death");
  self endon("disconnect");

  self SetClientOmnvar("ui_horde_update_explosive", 1);

  wait(8);

  self SetClientOmnvar("ui_horde_update_explosive", 0);
}

intelSplash() {}

deathWatcher() {
  self endon("disconnect");

  self endon("intel_cleanup");

  self waittill("death");

  self SetClientOmnvar("ui_intel_active_index", -1);

  self thread maps\mp\gametypes\_hud_message::SplashNotifyDelayed("ch_intel_failed");
}

intelHeadshotChallenge(challengeReference) {
  self endon("disconnect");
  self endon("death");
  self endon("intel_cleanup");

  numHeadshots = 0;
  headshotTarget = level.intelChallengeArray[challengeReference].challengeTarget;

  self thread maps\mp\gametypes\_hud_message::SplashNotifyDelayed(challengeReference + "_received", headshotTarget);
  self playerUpdateIntelProgress(headshotTarget);

  while(numHeadshots < headshotTarget) {
    self waittill("got_a_kill", victim, weapon, meansOfDeath);

    if(isKillstreakWeapon(weapon)) {
      continue;
    }
    if(meansOfDeath == "MOD_HEAD_SHOT") {
      numHeadshots++;
      updateIntelProgress = headshotTarget - numHeadshots;
      playerUpdateIntelProgress(updateIntelProgress);
    }
  }

  self maps\mp\gametypes\_intel::awardPlayerChallengeComplete(challengeReference);
}

intelKillsChallenge(challengeReference) {
  self endon("disconnect");
  self endon("death");
  self endon("intel_cleanup");

  numKills = 0;
  numKillsTarget = level.intelChallengeArray[challengeReference].challengeTarget;

  self thread maps\mp\gametypes\_hud_message::SplashNotifyDelayed(challengeReference + "_received", numKillsTarget);
  self playerUpdateIntelProgress(numKillsTarget);

  while(numKills < numKillsTarget) {
    self waittill("got_a_kill", victim, weapon);

    if(isKillstreakWeapon(weapon)) {
      continue;
    }

    numKills++;
    updateIntelProgress = numKillsTarget - numKills;
    playerUpdateIntelProgress(updateIntelProgress);
  }

  self maps\mp\gametypes\_intel::awardPlayerChallengeComplete(challengeReference);
}

intelCrouchKillsChallenge(challengeReference) {
  self endon("disconnect");
  self endon("death");
  self endon("intel_cleanup");

  numKills = 0;
  numKillsTarget = level.intelChallengeArray[challengeReference].challengeTarget;
  self playerUpdateIntelProgress(numKillsTarget);

  self thread maps\mp\gametypes\_hud_message::SplashNotifyDelayed(challengeReference + "_received", numKillsTarget);

  while(numKills < numKillsTarget) {
    self waittill("got_a_kill", victim, weapon);

    if(self getStance() == "crouch") {
      if(isKillstreakWeapon(weapon)) {
        continue;
      }
      numKills++;
      updateIntelProgress = numKillsTarget - numKills;
      playerUpdateIntelProgress(updateIntelProgress);
    }
  }

  self maps\mp\gametypes\_intel::awardPlayerChallengeComplete(challengeReference);
}

intelFoundshotKillsChallenge(challengeReference) {
  self endon("disconnect");
  self endon("death");
  self endon("intel_cleanup");

  numKills = 0;
  numKillsTarget = level.intelChallengeArray[challengeReference].challengeTarget;

  self thread maps\mp\gametypes\_hud_message::SplashNotifyDelayed(challengeReference + "_received", numKillsTarget);
  self playerUpdateIntelProgress(numKillsTarget);

  while(numKills < numKillsTarget) {
    self waittill("got_a_kill", victim, weapon, meansOfDeath);

    if(meansOfDeath == "MOD_MELEE" &&
      !maps\mp\gametypes\_weapons::isKnifeOnly(weapon) &&
      !maps\mp\gametypes\_weapons::isRiotShield(weapon)
    ) {
      continue;
    }
    if(maps\mp\gametypes\_weapons::isOffhandWeapon(weapon) ||
      isKillstreakWeapon(weapon) ||
      isEnvironmentWeapon(weapon)
    ) {
      continue;
    }
    weapon = weaponMap(weapon);

    if(weapon != self.pers["primaryWeapon"] &&
      weapon != self.pers["secondaryWeapon"]) {
      numKills++;
      updateIntelProgress = numKillsTarget - numKills;
      playerUpdateIntelProgress(updateIntelProgress);
    }
  }

  self maps\mp\gametypes\_intel::awardPlayerChallengeComplete(challengeReference);
}

intelSecondaryKillsChallenge(challengeReference) {
  self endon("disconnect");
  self endon("death");
  self endon("intel_cleanup");

  numKills = 0;
  numKillsTarget = level.intelChallengeArray[challengeReference].challengeTarget;

  self thread maps\mp\gametypes\_hud_message::SplashNotifyDelayed(challengeReference + "_received", numKillsTarget);
  self playerUpdateIntelProgress(numKillsTarget);

  while(numKills < numKillsTarget) {
    self waittill("got_a_kill", victim, weapon, meansOfDeath);

    weapon = weaponMap(weapon);

    if(isCACSecondaryWeapon(weapon)) {
      if(meansOfDeath == "MOD_MELEE" && !IsSubStr(weapon, "tactical")) {
        continue;
      }
      numKills++;
      updateIntelProgress = numKillsTarget - numKills;
      playerUpdateIntelProgress(updateIntelProgress);
    }
  }

  self maps\mp\gametypes\_intel::awardPlayerChallengeComplete(challengeReference);
}

intelBackKillsChallenge(challengeReference) {
  self endon("disconnect");
  self endon("death");
  self endon("intel_cleanup");

  numKills = 0;
  numKillsTarget = level.intelChallengeArray[challengeReference].challengeTarget;

  self thread maps\mp\gametypes\_hud_message::SplashNotifyDelayed(challengeReference + "_received", numKillsTarget);
  self playerUpdateIntelProgress(numKillsTarget);

  while(numKills < numKillsTarget) {
    self waittill("got_a_kill", victim, weapon, meansOfDeath);

    if(isKillstreakWeapon(weapon)) {
      continue;
    }
    vAngles = victim.anglesOnDeath[1];
    pAngles = self.anglesOnKill[1];
    angleDiff = AngleClamp180(vAngles - pAngles);
    if(abs(angleDiff) < 65) {
      numKills++;
      updateIntelProgress = numKillsTarget - numKills;
      playerUpdateIntelProgress(updateIntelProgress);
    }
  }

  self maps\mp\gametypes\_intel::awardPlayerChallengeComplete(challengeReference);
}

intelJumpShotKillsChallenge(challengeReference) {
  self endon("disconnect");
  self endon("death");
  self endon("intel_cleanup");

  numKills = 0;
  numKillsTarget = Int(level.intelChallengeArray[challengeReference].challengeTarget);

  self thread maps\mp\gametypes\_hud_message::SplashNotifyDelayed(challengeReference + "_received", numKillsTarget);
  self playerUpdateIntelProgress(numKillsTarget);

  while(numKills < numKillsTarget) {
    self waittill("got_a_kill", victim, weapon, meansOfDeath);

    if(isKillstreakWeapon(weapon)) {
      continue;
    }
    if(!self isOnGround()) {
      numKills++;
      updateIntelProgress = numKillsTarget - numKills;
      playerUpdateIntelProgress(updateIntelProgress);
    }
  }

  self maps\mp\gametypes\_intel::awardPlayerChallengeComplete(challengeReference);
}

intelKnifeKillChallenge(challengeReference) {
  self endon("disconnect");
  self endon("death");
  self endon("intel_cleanup");

  numKills = 0;
  numKillsTarget = level.intelChallengeArray[challengeReference].challengeTarget;

  self thread maps\mp\gametypes\_hud_message::SplashNotifyDelayed(challengeReference + "_received", numKillsTarget);
  self playerUpdateIntelProgress(numKillsTarget);

  while(numKills < numKillsTarget) {
    self waittill("got_a_kill", victim, weapon, meansOfDeath);

    if(meansOfDeath == "MOD_MELEE") {
      numKills++;
      updateIntelProgress = numKillsTarget - numKills;
      playerUpdateIntelProgress(updateIntelProgress);
    }
  }

  self maps\mp\gametypes\_intel::awardPlayerChallengeComplete(challengeReference);
}

intelBombKillChallenge(challengeReference) {
  self endon("disconnect");
  self endon("death");
  self endon("intel_cleanup");

  numKills = 0;
  numKillsTarget = level.intelChallengeArray[challengeReference].challengeTarget;

  self thread maps\mp\gametypes\_hud_message::SplashNotifyDelayed(challengeReference + "_received", numKillsTarget);
  self playerUpdateIntelProgress(numKillsTarget);

  while(numKills < numKillsTarget) {
    self waittill("got_a_kill", victim, weapon, meansOfDeath);

    if(isKillstreakWeapon(weapon)) {
      continue;
    }
    if(weapon == "throwingknife_mp") {
      continue;
    }
    if(IsExplosiveDamageMOD(MeansOfDeath) || meansOfDeath == "MOD_IMPACT") {
      numKills++;
      updateIntelProgress = numKillsTarget - numKills;
      playerUpdateIntelProgress(updateIntelProgress);
    }
  }

  self maps\mp\gametypes\_intel::awardPlayerChallengeComplete(challengeReference);
}

intelProneKillsChallenge(challengeReference) {
  self endon("disconnect");
  self endon("death");
  self endon("intel_cleanup");

  numKills = 0;
  numKillsTarget = Int(level.intelChallengeArray[challengeReference].challengeTarget);

  self thread maps\mp\gametypes\_hud_message::SplashNotifyDelayed(challengeReference + "_received", numKillsTarget);
  self playerUpdateIntelProgress(numKillsTarget);

  while(numKills < numKillsTarget) {
    self waittill("got_a_kill", victim, weapon, meansOfDeath);

    if(isKillstreakWeapon(weapon)) {
      continue;
    }
    if(self getStance() == "prone") {
      numKills++;
      updateIntelProgress = numKillsTarget - numKills;
      playerUpdateIntelProgress(updateIntelProgress);
    }
  }

  self maps\mp\gametypes\_intel::awardPlayerChallengeComplete(challengeReference);
}

intelTbagChallenge(challengeReference) {
  self endon("disconnect");
  self endon("death");
  self endon("intel_cleanup");

  numKillsTarget = level.intelChallengeArray[challengeReference].challengeTarget;

  self thread maps\mp\gametypes\_hud_message::SplashNotifyDelayed(challengeReference + "_received");

  for(;;) {
    self waittill("got_a_kill", victim, weapon, meansOfDeath);

    if(isKillstreakWeapon(weapon)) {
      continue;
    }
    self thread watchForTbag(victim.origin, challengeReference);
  }
}

watchForTbag(position, challengeReference) {
  self notify("watchForTbag");
  self endon("watchForTbag");

  self endon("death");
  self endon("disconnect");
  self endon("intel_cleanup");

  numTbag = 0;

  self notifyOnPlayerCommand("Tbag_adjustedStance", "+stance");
  self notifyOnPlayerCommand("Tbag_adjustedStance", "+goStand");

  if(!level.console && !isAI(self)) {
    self notifyOnPlayerCommand("Tbag_adjustedStance", "+togglecrouch");
    self notifyOnPlayerCommand("Tbag_adjustedStance", "+movedown");
  }

  while(true) {
    while(self GetStance() != "stand") {
      wait(0.05);
    }

    self waittill("Tbag_adjustedStance");

    while(self GetStance() != "crouch") {
      wait(0.05);
    }

    if(Distance2D(self.origin, position) < 128) {
      self waittill("Tbag_adjustedStance");

      while(self GetStance() != "stand") {
        wait(0.05);
      }

      if(Distance2D(self.origin, position) < 128) {
        numTbag++;
      }
    }

    if(numTbag) {
      self thread maps\mp\gametypes\_intel::awardPlayerChallengeComplete(challengeReference);
      return;
    }
  }
}

giveJuggernautChallenge(challengeIndex) {
  self thread deathWatcher();

  omnvar_index = TableLookupRowNum("mp/intelChallenges.csv", 0, challengeIndex);
  self SetClientOmnvar("ui_intel_active_index", omnvar_index);
  switch (challengeIndex) {
    case "ch_intel_jugg_maniac_knife":
      self thread intelJuggManiacKnifeChallenge(challengeIndex);
      break;
    case "ch_intel_jugg_maniac_throwingknife":
      self thread intelJuggManiacThrowingKnifeChallenge(challengeIndex);
      break;
    case "ch_intel_jugg_maniac_backknife":
      self thread intelJuggManiacBackKnifeChallenge(challengeIndex);
      break;
    case "ch_intel_jugg_assault_kills":
      self thread intelJuggAssaultKillsChallenge(challengeIndex);
      break;
    case "ch_intel_jugg_recon_shieldkills":
      self thread intelJuggReconShieldKillsChallenge(challengeIndex);
      break;
    case "ch_intel_jugg_recon_pistolkills":
      self thread intelJuggReconPistolKillsChallenge(challengeIndex);
      break;
    default:
      AssertMsg(challengeIndex + " not found");
  }
}

intelJuggAssaultKillsChallenge(challengeReference) {
  self endon("disconnect");
  self endon("death");
  self endon("intel_cleanup");

  numKills = 0;
  numKillsTarget = Int(level.intelChallengeArray[challengeReference].challengeTarget);

  self thread maps\mp\gametypes\_hud_message::SplashNotifyDelayed(challengeReference + "_received", numKillsTarget);
  self playerUpdateIntelProgress(numKillsTarget);

  while(numKills < numKillsTarget) {
    self waittill("got_a_kill", victim, weapon, meansOfDeath);

    if(isJuggernautWeapon(weapon)) {
      numKills++;
      updateIntelProgress = numKillsTarget - numKills;
      playerUpdateIntelProgress(updateIntelProgress);
    }
  }

  self maps\mp\gametypes\_intel::awardPlayerChallengeComplete(challengeReference);
}

intelJuggManiacKnifeChallenge(challengeReference) {
  self endon("disconnect");
  self endon("death");
  self endon("intel_cleanup");

  numKills = 0;
  numKillsTarget = Int(level.intelChallengeArray[challengeReference].challengeTarget);

  self thread maps\mp\gametypes\_hud_message::SplashNotifyDelayed(challengeReference + "_received", numKillsTarget);
  self playerUpdateIntelProgress(numKillsTarget);

  while(numKills < numKillsTarget) {
    self waittill("got_a_kill", victim, weapon, meansOfDeath);

    if(weapon == "iw6_knifeonlyjugg_mp") {
      numKills++;
      updateIntelProgress = numKillsTarget - numKills;
      playerUpdateIntelProgress(updateIntelProgress);
    }
  }

  self maps\mp\gametypes\_intel::awardPlayerChallengeComplete(challengeReference);
}

intelJuggManiacThrowingKnifeChallenge(challengeReference) {
  self endon("disconnect");
  self endon("death");
  self endon("intel_cleanup");

  numKills = 0;
  numKillsTarget = Int(level.intelChallengeArray[challengeReference].challengeTarget);

  self thread maps\mp\gametypes\_hud_message::SplashNotifyDelayed(challengeReference + "_received", numKillsTarget);
  self playerUpdateIntelProgress(numKillsTarget);

  while(numKills < numKillsTarget) {
    self waittill("got_a_kill", victim, weapon, meansOfDeath);

    if(weapon == "throwingknifejugg_mp") {
      numKills++;
      updateIntelProgress = numKillsTarget - numKills;
      playerUpdateIntelProgress(updateIntelProgress);
    }
  }

  self maps\mp\gametypes\_intel::awardPlayerChallengeComplete(challengeReference);
}

intelJuggManiacBackKnifeChallenge(challengeReference) {
  self endon("disconnect");
  self endon("death");
  self endon("intel_cleanup");

  numKills = 0;
  numKillsTarget = level.intelChallengeArray[challengeReference].challengeTarget;

  self thread maps\mp\gametypes\_hud_message::SplashNotifyDelayed(challengeReference + "_received", numKillsTarget);
  self playerUpdateIntelProgress(numKillsTarget);

  while(numKills < numKillsTarget) {
    self waittill("got_a_kill", victim, weapon, meansOfDeath);

    if(isJuggernautWeapon(weapon)) {
      vAngles = victim.anglesOnDeath[1];
      pAngles = self.anglesOnKill[1];
      angleDiff = AngleClamp180(vAngles - pAngles);
      if(abs(angleDiff) < 90) {
        numKills++;
        updateIntelProgress = numKillsTarget - numKills;
        playerUpdateIntelProgress(updateIntelProgress);
      }
    }
  }

  self maps\mp\gametypes\_intel::awardPlayerChallengeComplete(challengeReference);
}

intelJuggReconShieldKillsChallenge(challengeReference) {
  self endon("disconnect");
  self endon("death");
  self endon("intel_cleanup");

  numKills = 0;
  numKillsTarget = Int(level.intelChallengeArray[challengeReference].challengeTarget);

  self thread maps\mp\gametypes\_hud_message::SplashNotifyDelayed(challengeReference + "_received", numKillsTarget);
  self playerUpdateIntelProgress(numKillsTarget);

  while(numKills < numKillsTarget) {
    self waittill("got_a_kill", victim, weapon, meansOfDeath);

    if(weapon == "iw6_riotshieldjugg_mp") {
      numKills++;
      updateIntelProgress = numKillsTarget - numKills;
      playerUpdateIntelProgress(updateIntelProgress);
    }
  }

  self maps\mp\gametypes\_intel::awardPlayerChallengeComplete(challengeReference);
}

intelJuggReconPistolKillsChallenge(challengeReference) {
  self endon("disconnect");
  self endon("death");
  self endon("intel_cleanup");

  numKills = 0;
  numKillsTarget = Int(level.intelChallengeArray[challengeReference].challengeTarget);

  self thread maps\mp\gametypes\_hud_message::SplashNotifyDelayed(challengeReference + "_received", numKillsTarget);
  self playerUpdateIntelProgress(numKillsTarget);

  while(numKills < numKillsTarget) {
    self waittill("got_a_kill", victim, weapon, meansOfDeath);

    if(weapon == "iw6_magnumjugg_mp" && meansOfDeath != "MOD_MELEE") {
      numKills++;
      updateIntelProgress = numKillsTarget - numKills;
      playerUpdateIntelProgress(updateIntelProgress);
    }
  }

  self maps\mp\gametypes\_intel::awardPlayerChallengeComplete(challengeReference);
}