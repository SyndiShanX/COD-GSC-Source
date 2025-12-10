/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\_properks.gsc
**************************************/

#include maps\mp\_utility;
#include common_scripts\utility;

init() {
  level.ProPerkCallbacks = [];
  registerProPerkCallback("playerKilled", maps\mp\_properks::proPerkKills);
  level thread onPlayerConnect();
}
registerProPerkCallback(callback, func) {
  if(!isDefined(level.ProPerkCallbacks[callback]))
    level.ProPerkCallbacks[callback] = [];
  level.ProPerkCallbacks[callback][level.ProPerkCallbacks[callback].size] = func;
}
doProPerkCallback(callback, data) {
  if(!isDefined(level.ProPerkCallbacks))
    return;
  if(!isDefined(level.ProPerkCallbacks[callback]))
    return;
  if(isDefined(data)) {
    for(i = 0; i < level.ProPerkCallbacks[callback].size; i++)
      thread[[level.ProPerkCallbacks[callback][i]]](data);
  } else {
    for(i = 0; i < level.ProPerkCallbacks[callback].size; i++)
      thread[[level.ProPerkCallbacks[callback][i]]]();
  }
}
onPlayerConnect() {
  for(;;) {
    level waittill("connected", player);
    player thread monitorSprintDistance();
    player thread monitorReloads();
    player thread monitorGrenadeThrowBacks();
  }
}
ownsAndUsingPerk(specialty) {
  if(self hasPerk(specialty)) {
    if(isDefined(level.specialtyToPerkIndex[specialty])) {
      if(self isItemPurchased(level.specialtyToPerkIndex[specialty])) {
        return true;
      }
    }
  }
  return false;
}
proPerkkills(data, time) {
  victim = data.victim;
  attacker = data.attacker;
  time = data.time;
  victim = data.victim;
  weapon = data.sWeapon;
  if(!isDefined(data.sWeapon) || maps\mp\gametypes\_hardpoints::isKillstreakWeapon(data.sWeapon))
    return;
  if(!isDefined(attacker) || !isplayer(attacker))
    return;
  if(level.teambased) {
    if(attacker.team == victim.team)
      return;
  } else {
    if(attacker == victim)
      return;
  }
  attacker notify("killed_a_player");
  if(weapon == "frag_grenade_mp" || weapon == "sticky_grenade_mp") {
    attacker notify("lethalGrenadeKill");
  }
  if(isDefined(data.sMeansOfDeath) && data.sMeansOfDeath == "MOD_MELEE") {
    if(attacker ownsAndUsingPerk("specialty_bulletaccuracy")) {
      attacker thread quickMelee();
    }
    if(attacker ownsAndUsingPerk("specialty_movefaster")) {
      attacker maps\mp\gametypes\_persistence::statAdd("PERKS_LIGHTWEIGHT_MELEE", 1, false);
    }
  }
  if(attacker ownsAndUsingPerk("specialty_holdbreath")) {
    if(isDefined(data.sMeansOfDeath) && data.sMeansOfDeath == "MOD_HEAD_SHOT")
      attacker maps\mp\gametypes\_persistence::statAdd("PERKS_SCOUT_HEADSHOTS", 1, false);
  }
  if(attacker ownsAndUsingPerk("specialty_fastreload")) {
    if(isDefined(victim.attackerDamage) && isDefined(victim.attackerDamage[attacker.clientid]) && isDefined(victim.attackerDamage[attacker.clientid])) {
      if(isDefined(attacker.lastreloadtime) && victim.attackerDamage[attacker.clientid].time < attacker.lastreloadtime) {
        attacker maps\mp\gametypes\_persistence::statAdd("PERKS_SLEIGHT_OF_HAND_DAMAGE_RELOAD_KILL", 1, false);
      }
    }
  }
  if(attacker ownsAndUsingPerk("specialty_gpsjammer")) {
    if(level.teambased) {
      if(isDefined(victim.team)) {
        if(maps\mp\_radar::teamHasSpyplane(victim.team) || maps\mp\_radar::teamHasSatellite(victim.team))
          attacker maps\mp\gametypes\_persistence::statAdd("PERKS_GHOST_RADAR_KILL", 1, false);
      }
    } else {
      if((isDefined(victim.hasSatellite) && victim.hasSatellite == true) || (isDefined(victim.hasSpyplane) && victim.hasSpyplane == true))
        attacker maps\mp\gametypes\_persistence::statAdd("PERKS_GHOST_RADAR_KILL", 1, false);
    }
  }
  if(isDefined(data.sMeansOfDeath) && IsBulletImpactMOD(data.sMeansOfDeath)) {
    if(attacker ownsAndUsingPerk("specialty_bulletaccuracy") && (attacker playerAds() != 1.0))
      attacker maps\mp\gametypes\_persistence::statAdd("PERKS_STEADY_AIM_KILL", 1, false);
  }
  if(attacker ownsAndUsingPerk("specialty_holdbreath")) {
    if(maps\mp\gametypes\_weapons::isSideArm(data.sWeapon) ||
      data.sWeapon == "m72_law_mp" ||
      data.sWeapon == "rpg_mp" ||
      data.sWeapon == "china_lake_mp" ||
      data.sWeapon == "knife_ballistic_mp" ||
      data.sWeapon == "explosive_bolt_mp") {
      attacker maps\mp\gametypes\_persistence::statAdd("PERKS_SCOUT_SIDE_ARM_KILL", 1, false);
    }
  }
  if(attacker ownsAndUsingPerk("specialty_detectexplosive")) {
    if(data.sWeapon == "claymore_mp" || data.sWeapon == "satchel_charge_mp")
      attacker maps\mp\gametypes\_persistence::statAdd("PERKS_HACKER_EXPLOSIVE_KILL", 1, false);
    victimFlatOrigin = (data.victim.origin[0], data.victim.origin[1], 0);
    if(isDefined(attacker.scrambler)) {
      scramblerFlatOrigin = (attacker.scrambler.origin[0], attacker.scrambler.origin[1], 0);
      if(distanceSquared(victimFlatOrigin, scramblerFlatOrigin) < (level.scramblerOuterRadiusSq * 1.2)) {
        attacker maps\mp\gametypes\_persistence::statAdd("PERKS_HACKER_NEAR_EQUIPT_KILL", 1, false);
      }
    }
    if(isDefined(attacker.acousticSensor)) {
      acousticSensorRadius = getdvarfloatdefault("compassLocalRadarRadius", 0);
      acousticFlatOrigin = (attacker.acousticSensor.origin[0], attacker.acousticSensor.origin[1], 0);
      if(distanceSquared(victimFlatOrigin, acousticFlatOrigin) < (acousticSensorRadius * acousticSensorRadius * 1.2)) {
        attacker maps\mp\gametypes\_persistence::statAdd("PERKS_HACKER_NEAR_EQUIPT_KILL", 1, false);
      }
    }
  }
  if(attacker ownsAndUsingPerk("specialty_bulletpenetration")) {
    if(isDefined(victim.iDFlags) && victim.iDFlags &level.iDFLAGS_PENETRATION) {
      attacker maps\mp\gametypes\_persistence::statAdd("PERKS_DEEP_IMPACT_KILL", 1, false);
    }
  }
  if(attacker ownsAndUsingPerk("specialty_fastreload")) {
    if(attacker playerAds() == 1.0 && isDefined(data.sMeansOfDeath) && IsBulletImpactMOD(data.sMeansOfDeath)) {
      attacker maps\mp\gametypes\_persistence::statAdd("PERKS_SLEIGHT_OF_HAND_ADS_KILL", 1, false);
    }
  }
  if(attacker ownsAndUsingPerk("specialty_quieter")) {
    if((data.sMeansOfDeath == "MOD_RIFLE_BULLET" || data.sMeansOfDeath == "MOD_PISTOL_BULLET" || data.sMeansOfDeath == "MOD_HEAD_SHOT") && isDefined(weapon)) {
      if(isDefined(attacker.currentWeapon) && attacker.currentWeapon == weapon && isDefined(attacker.currentAttachments)) {
        attachmentArray = attacker.currentAttachments;
      } else {
        attachmentArray = maps\mp\gametypes\_class::listWeaponAttachments(weapon);
      }
      for(attachmentCount = 0; attachmentCount < attachmentArray.size; attachmentCount++) {
        if(attachmentArray[attachmentCount]["name"] == "silencer")
          attacker maps\mp\gametypes\_persistence::statAdd("PERKS_NINJA_SILENCED", 1, false);
      }
    }
  }
  if(attacker ownsAndUsingPerk("specialty_pistoldeath")) {
    if(isDefined(data.attacker.lastStand) && data.attacker.lastStand) {
      attacker maps\mp\gametypes\_persistence::statAdd("PERKS_SECOND_CHANCE_KILL", 1, false);
      if(data.sMeansOfDeath == "MOD_HEAD_SHOT")
        attacker maps\mp\gametypes\_persistence::statAdd("PERKS_SECOND_CHANCE_HEADSHOT", 1, false);
      if(isDefined(attacker.lastStandParams.attacker) && attacker.lastStandParams.attacker == victim)
        attacker maps\mp\gametypes\_persistence::statAdd("PERKS_SECOND_CHANCE_REVENGE", 1, false);
    }
  }
  if(attacker ownsAndUsingPerk("specialty_gas_mask")) {
    if(victim maps\mp\_flashgrenades::isFlashbanged())
      attacker maps\mp\gametypes\_persistence::statAdd("PERKS_TACTICAL_MASK_FLASH", 1, false);
    if(isDefined(victim.concussionEndTime) && victim.concussionEndTime > gettime())
      attacker maps\mp\gametypes\_persistence::statAdd("PERKS_TACTICAL_MASK_CONCUSSION", 1, false);
    if(isDefined(victim.inPoisonArea) && victim.inPoisonArea)
      attacker maps\mp\gametypes\_persistence::statAdd("PERKS_TACTICAL_MASK_GAS", 1, false);
  }
  if(attacker ownsAndUsingPerk("specialty_twoattach")) {
    if((data.sMeansOfDeath == "MOD_RIFLE_BULLET" || data.sMeansOfDeath == "MOD_PISTOL_BULLET" || data.sMeansOfDeath == "MOD_HEAD_SHOT") && isDefined(weapon)) {
      if(isDefined(attacker.currentWeapon) && attacker.currentWeapon == weapon && isDefined(attacker.currentAttachments)) {
        attachmentArray = attacker.currentAttachments;
      } else {
        attachmentArray = maps\mp\gametypes\_class::listWeaponAttachments(weapon);
      }
      if(attachmentArray.size > 1)
        attacker maps\mp\gametypes\_persistence::statAdd("PERKS_PROFESSIONAL_TWO_ATTACH_KILLS", 1, false);
    }
    if(data.sWeapon == "frag_grenade_mp" || data.sWeapon == "sticky_grenade_mp")
      attacker maps\mp\gametypes\_persistence::statAdd("PERKS_PROFESSIONAL_GRENADE_KILLS", 1, false);
  }
}
multiGrenadeKill() {
  if(self ownsAndUsingPerk("specialty_twoattach")) {
    self maps\mp\gametypes\_persistence::statAdd("PERKS_PROFESSIONAL_MULTI_GRENADE_KILLS", 1, false);
  }
}
shotEquipment(owner, idflags) {
  if(isplayer(self) && self ownsAndUsingPerk("specialty_bulletpenetration")) {
    if(isDefined(owner)) {
      if(isDefined(iDFlags) && (iDFlags &level.iDFLAGS_PENETRATION)) {
        if(level.teambased) {
          if(isplayer(owner) && (owner.team != self.team))
            self maps\mp\gametypes\_persistence::statAdd("PERKS_DEEP_IMPACT_SHOT_EQUIPMENT", 1, false);
        } else {
          if(owner != self)
            self maps\mp\gametypes\_persistence::statAdd("PERKS_DEEP_IMPACT_SHOT_EQUIPMENT", 1, false);
        }
      }
    }
  }
}
checkKillCount() {
  self endon("death");
  self endon("disconnect");
  minScavengerKillCount = 5;
  if(self ownsAndUsingPerk("specialty_scavenger")) {
    if(self.pers["cur_kill_streak"] == minScavengerKillCount)
      self maps\mp\gametypes\_persistence::statAdd("PERKS_SCAVENGER_KILL_COUNT", 1, false);
  }
}
quickMelee() {
  self endon("disconnect");
  self notify("proPerkMelee");
  self endon("proPerkMeleeTimedOut");
  nSecondsBetweenMelee = 5;
  self thread meleeTimeOut(nSecondsBetweenMelee);
  self waittill("proPerkMelee");
  self maps\mp\gametypes\_persistence::statAdd("PERKS_STEADY_AIM_QUICK_MELEE", 1, false);
}
meleeTimeOut(time) {
  self endon("disconnect");
  self endon("proPerkMelee");
  wait(time);
  self notify("proPerkMeleeTimedOut");
}
monitorSprintDistance() {
  self endon("disconnect");
  if(!isDefined(self.pers["sprintDist"]))
    self.pers["sprintDist"] = 0;
  self.currentSprintDist = self.pers["sprintDist"];
  while(1) {
    self waittill("sprint_begin");
    self.currentSprintDist = int(self.currentSprintDist) % 100;
    self monitorSingleSprintDistance();
    if(self ownsAndUsingPerk("specialty_longersprint"))
      self maps\mp\gametypes\_persistence::statAdd("PERKS_MARATHON_MILE", int((self.currentSprintDist / 100)), false);
    level.globalDistanceSprinted += (self.currentSprintDist / 100);
    if(self ownsAndUsingPerk("specialty_bulletaccuracy"))
      self thread sprintThenKill();
    self.pers["sprintDist"] = self.currentSprintDist;
  }
}
sprintThenKill() {
  self endon("disconnect");
  self notify("sprintThenKillEnd");
  self endon("sprintThenKillEnd");
  sprintThenKillTimeOut = 3;
  self thread sprintThenKillTimeOut(sprintThenKillTimeOut);
  while(1) {
    self waittill("killed_a_player");
    if(self ownsAndUsingPerk("specialty_bulletaccuracy"))
      self maps\mp\gametypes\_persistence::statAdd("PERKS_STEADY_AIM_SPRINT_KILL", 1, false);
  }
}
sprintThenKillTimeOut(time) {
  self endon("disconnect");
  wait(time);
  self notify("sprintThenKillEnd");
}
monitorSingleSprintDistance() {
  self endon("disconnect");
  self endon("death");
  self endon("sprint_end");
  prevpos = self.origin;
  while(1) {
    wait .1;
    self.currentSprintDist += distance(self.origin, prevpos);
    prevpos = self.origin;
  }
}
monitorGrenadeThrowBacks() {
  self endon("disconnect");
  while(1) {
    self waittill("grenade_throwback", originalOwner, grenade);
    grenade.originalOwner = originalOwner;
    if(self ownsAndUsingPerk("specialty_flakjacket") && isplayer(originalOwner)) {
      if(level.teambased) {
        if(originalOwner.team != self.team)
          self maps\mp\gametypes\_persistence::statAdd("PERKS_FLAK_JACKET_THREWBACK", 1, false);
      } else {
        if(originalOwner != self)
          self maps\mp\gametypes\_persistence::statAdd("PERKS_FLAK_JACKET_THREWBACK", 1, false);
      }
    }
  }
}
monitorReloads() {
  self endon("disconnect");
  while(1) {
    self waittill("reload");
    self thread reloadThenKill();
    self.lastReloadTime = getTime();
  }
}
reloadThenKill() {
  self endon("disconnect");
  self endon("reloadThenKillTimedOut");
  self notify("reloadThenKillStart");
  self thread reloadThenKillTimeOut(5);
  self waittill("killed_a_player");
  if(self ownsAndUsingPerk("specialty_fastreload"))
    self maps\mp\gametypes\_persistence::statAdd("PERKS_SLEIGHT_OF_HAND_RELOAD_KILL", 1, false);
}
reloadThenKillTimeOut(time) {
  self endon("disconnect");
  self endon("reloadThenKillStart");
  wait(time);
  self notify("reloadThenKillTimedOut");
}
scavengedGrenade() {
  self endon("disconnect");
  self endon("death");
  self notify("scavengedGrenade");
  self endon("scavengedGrenade");
  for(;;) {
    self waittill("lethalGrenadeKill");
    if(self ownsAndUsingPerk("specialty_scavenger")) {
      self maps\mp\gametypes\_persistence::statAdd("PERKS_SCAVENGER_NADE_KILL", 1, false);
    }
  }
}
scavenged() {
  if(self ownsAndUsingPerk("specialty_scavenger")) {
    self maps\mp\gametypes\_persistence::statAdd("PERKS_SCAVENGER_RESUPPLY", 1, false);
  }
}
destroyedKillstreak() {}
destroyedSentryTurret() {
  if(self ownsAndUsingPerk("specialty_gpsjammer"))
    self maps\mp\gametypes\_persistence::statAdd("PERKS_GHOST_DESTROY_TURRET", 1, false);
}
earnedAKillstreak() {
  if(self ownsAndUsingPerk("specialty_killstreak")) {
    hardPointKillstreakEarnedCount = 7;
    if(!isDefined(self.pers["proEarnedKillstreak"]))
      self.pers["proEarnedKillstreak"] = 0;
    self.pers["proEarnedKillstreak"]++;
    if(self.pers["proEarnedKillstreak"] == hardPointKillstreakEarnedCount) {
      self maps\mp\gametypes\_persistence::statAdd("PERKS_HARDLINE_KILLSTREAK", 1, false);
    }
  }
}
earnedAKill() {
  self endon("disconnect");
  if(self ownsAndUsingPerk("specialty_killstreak")) {
    if(!isDefined(self.pers["properkKills"]))
      self.pers["properkKills"] = 0;
    self.pers["properkKills"]++;
    minKillCount = 7;
    if(self.pers["properkKills"] == minKillCount)
      self maps\mp\gametypes\_persistence::statAdd("PERKS_HARDLINE_DOGS_KILLSTREAK", 1, false);
    self thread hardlineWatchForDeath();
  }
}
hardlineWatchForDeath() {
  self notify("hardlineWatchingForDeath");
  self endon("hardlineWatchingForDeath");
  self endon("disconnect");
  self waittill("death");
  self.pers["properkKills"] = 0;
}
flakjacketProtected() {
  self endon("death");
  waittillframeend;
  if(self ownsAndUsingPerk("specialty_flakjacket"))
    self maps\mp\gametypes\_persistence::statAdd("PERKS_FLAK_JACKET_PROTECTED", 1, false);
}
destroyedEquiptment() {
  if(self ownsAndUsingPerk("specialty_detectexplosive"))
    self maps\mp\gametypes\_persistence::statAdd("PERKS_HACKER_DESTROY", 1, false);
}
healthRegenerated() {
  if(!isalive(self))
    return;
  if(self ownsAndUsingPerk("specialty_movefaster")) {
    if(isDefined(self.lastDamageWasFromEnemy) && self.lastDamageWasFromEnemy) {
      self maps\mp\gametypes\_persistence::statAdd("PERKS_LIGHTWEIGHT_ESCAPE_DEATH", 1, false);
    }
  }
}
medalEarned(medalName, weapon) {
  if(self ownsAndUsingPerk("specialty_movefaster") && medalName == "MEDAL_OFFENSE_MEDAL") {
    self maps\mp\gametypes\_persistence::statAdd("PERKS_LIGHTWEIGHT_OFFENSE_MEDAL", 1, false);
  }
  if(self ownsAndUsingPerk("specialty_longersprint")) {
    if(medalName == "MEDAL_FIRST_BLOOD")
      self maps\mp\gametypes\_persistence::statAdd("PERKS_MARATHON_FIRST_BLOOD_MEDAL", 1, false);
    else if(medalName == "MEDAL_FLAG_CAPTURE")
      self maps\mp\gametypes\_persistence::statAdd("PERKS_MARATHON_CAPTURE_MEDAL", 1, false);
  }
  if(self ownsAndUsingPerk("specialty_gpsjammer")) {
    if(medalName == "MEDAL_DESTROYER_HELICOPTER" || medalName == "MEDAL_DESTROYER_HELICOPTER_PLAYER" || medalName == "MEDAL_DESTROYER_UAV" || medalName == "MEDAL_DESTROYER_COUNTERUAV") {
      if(isDefined(weapon) && weaponClass(weapon) == "rocketlauncher")
        self maps\mp\gametypes\_persistence::statAdd("PERKS_GHOST_DESTROY_AIRCRAFT", 1, false);
    }
  }
  if(self ownsAndUsingPerk("specialty_holdbreath")) {
    if(medalName == "MEDAL_ONE_SHOT_KILL")
      self maps\mp\gametypes\_persistence::statAdd("PERKS_SCOUT_ONE_SHOT_KILL", 1, false);
  }
  if(self ownsAndUsingPerk("specialty_killstreak")) {
    if(isStrStart(medalName, "MEDAL_SHARE_PACKAGE_"))
      self maps\mp\gametypes\_persistence::statAdd("PERKS_HARDLINE_SHARE_PACKAGE", 1, false);
  }
  if(self ownsAndUsingPerk("specialty_flakjacket")) {
    if(medalName == "MEDAL_SABOTEUR" || medalName == "MEDAL_HERO") {
      self maps\mp\gametypes\_persistence::statAdd("PERKS_FLAK_JACKET_DEMOLISHED", 1, false);
    }
  }
  if(self ownsAndUsingPerk("specialty_quieter")) {
    if(medalName == "MEDAL_SABOTEUR") {
      self maps\mp\gametypes\_persistence::statAdd("PERKS_NINJA_PLANTS", 1, false);
    }
    if(medalName == "MEDAL_BACK_STABBER") {
      self maps\mp\gametypes\_persistence::statAdd("PERKS_NINJA_BACK_STABBER", 1, false);
    }
  }
}
shotAirplane(owner, weapon, type) {
  if(!isDefined(owner))
    return;
  if(level.teambased) {
    if(owner.team == self.team)
      return;
  } else {
    if(owner == self)
      return;
  }
  if(self ownsAndUsingPerk("specialty_bulletpenetration")) {
    if(isDefined(weapon) && !maps\mp\gametypes\_hardpoints::isKillstreakWeapon(weapon)) {
      if(type == "MOD_RIFLE_BULLET" || type == "MOD_PISTOL_BULLET") {
        self maps\mp\gametypes\_persistence::statAdd("PERKS_DEEP_IMPACT_SHOT_PLANE", 1, false);
      }
    }
  }
}

