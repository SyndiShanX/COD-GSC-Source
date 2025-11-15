/************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\killstreaks\_perkstreaks.gsc
************************************************/

#include maps\mp\_utility;
#include common_scripts\utility;

KILLSTREAK_GIMME_SLOT = 0;
KILLSTREAK_SLOT_1 = 1;
KILLSTREAK_SLOT_2 = 2;
KILLSTREAK_SLOT_3 = 3;
KILLSTREAK_ALL_PERKS_SLOT = 4;
KILLSTREAK_STACKING_START_SLOT = 5;

init() {
  level.killStreakFuncs["specialty_fastsprintrecovery_ks"] = ::tryUsePerkStreak;
  level.killStreakFuncs["specialty_fastreload_ks"] = ::tryUsePerkStreak;
  level.killStreakFuncs["specialty_lightweight_ks"] = ::tryUsePerkStreak;
  level.killStreakFuncs["specialty_marathon_ks"] = ::tryUsePerkStreak;
  level.killStreakFuncs["specialty_stalker_ks"] = ::tryUsePerkStreak;
  level.killStreakFuncs["specialty_reducedsway_ks"] = ::tryUsePerkStreak;
  level.killStreakFuncs["specialty_quickswap_ks"] = ::tryUsePerkStreak;
  level.killStreakFuncs["specialty_pitcher_ks"] = ::tryUsePerkStreak;
  level.killStreakFuncs["specialty_bulletaccuracy_ks"] = ::tryUsePerkStreak;
  level.killStreakFuncs["specialty_quickdraw_ks"] = ::tryUsePerkStreak;
  level.killStreakFuncs["specialty_sprintreload_ks"] = ::tryUsePerkStreak;
  level.killStreakFuncs["specialty_silentkill_ks"] = ::tryUsePerkStreak;
  level.killStreakFuncs["specialty_blindeye_ks"] = ::tryUsePerkStreak;
  level.killStreakFuncs["specialty_gpsjammer_ks"] = ::tryUsePerkStreak;
  level.killStreakFuncs["specialty_quieter_ks"] = ::tryUsePerkStreak;
  level.killStreakFuncs["specialty_incog_ks"] = ::tryUsePerkStreak;
  level.killStreakFuncs["specialty_paint_ks"] = ::tryUsePerkStreak;
  level.killStreakFuncs["specialty_scavenger_ks"] = ::tryUsePerkStreak;
  level.killStreakFuncs["specialty_detectexplosive_ks"] = ::tryUsePerkStreak;
  level.killStreakFuncs["specialty_selectivehearing_ks"] = ::tryUsePerkStreak;
  level.killStreakFuncs["specialty_comexp_ks"] = ::tryUsePerkStreak;
  level.killStreakFuncs["specialty_falldamage_ks"] = ::tryUsePerkStreak;
  level.killStreakFuncs["specialty_regenfaster_ks"] = ::tryUsePerkStreak;
  level.killStreakFuncs["specialty_sharp_focus_ks"] = ::tryUsePerkStreak;
  level.killStreakFuncs["specialty_stun_resistance_ks"] = ::tryUsePerkStreak;
  level.killStreakFuncs["_specialty_blastshield_ks"] = ::tryUsePerkStreak;
  level.killStreakFuncs["specialty_gunsmith_ks"] = ::tryUsePerkStreak;
  level.killStreakFuncs["specialty_extraammo_ks"] = ::tryUsePerkStreak;
  level.killStreakFuncs["specialty_extra_equipment_ks"] = ::tryUsePerkStreak;
  level.killStreakFuncs["specialty_extra_deadly_ks"] = ::tryUsePerkStreak;
  level.killStreakFuncs["specialty_extra_attachment_ks"] = ::tryUsePerkStreak;
  level.killStreakFuncs["specialty_explosivedamage_ks"] = ::tryUsePerkStreak;
  level.killStreakFuncs["specialty_gambler_ks"] = ::tryUsePerkStreak;
  level.killStreakFuncs["specialty_hardline_ks"] = ::tryUsePerkStreak;
  level.killStreakFuncs["specialty_twoprimaries_ks"] = ::tryUsePerkStreak;
  level.killStreakFuncs["specialty_boom_ks"] = ::tryUsePerkStreak;
  level.killStreakFuncs["specialty_deadeye_ks"] = ::tryUsePerkStreak;

  level.killStreakFuncs["all_perks_bonus"] = ::tryUseAllPerks;

  level.killStreakFuncs["speed_boost"] = ::tryUseSpeedBoost;
  level.killStreakFuncs["refill_grenades"] = ::tryUseRefillGrenades;
  level.killStreakFuncs["refill_ammo"] = ::tryUseRefillAmmo;
  level.killStreakFuncs["regen_faster"] = ::tryUseRegenFaster;
}

tryUseSpeedBoost(lifeId, streakName) {
  self doKillstreakFunctions("specialty_juiced", "speed_boost");
  return true;
}

tryUseRefillGrenades(lifeId, streakName) {
  self doKillstreakFunctions("specialty_refill_grenades", "refill_grenades");
  return true;
}

tryUseRefillAmmo(lifeId, streakName) {
  self doKillstreakFunctions("specialty_refill_ammo", "refill_ammo");
  return true;
}

tryUseRegenFaster(lifeId, streakName) {
  self doKillstreakFunctions("specialty_regenfaster", "regen_faster");
  return true;
}

tryUseAllPerks(lifeId, streakName) {
  return true;
}

tryUsePerkStreak(lifeId, streakName) {
  AssertEx(isDefined(streakName), "tryUsePerkStreak needs a streakName instead of undefined");
  perk = strip_suffix(streakName, "_ks");
  self doPerkFunctions(perk);
  return true;
}

doPerkFunctions(perkName) {
  self givePerk(perkName, false);
  self thread watchDeath(perkName);
  self thread checkForPerkUpgrade(perkName);

  if(perkName == "specialty_hardline")
    self maps\mp\killstreaks\_killstreaks::setStreakCountToNext();

  self maps\mp\_matchdata::logKillstreakEvent(perkName + "_ks", self.origin);
}

doKillstreakFunctions(perkName, killstreakEvent) {
  self givePerk(perkName, false);

  if(isDefined(killstreakEvent))
    self maps\mp\_matchdata::logKillstreakEvent(killstreakEvent, self.origin);
}

watchDeath(perkName) {
  self endon("disconnect");
  self waittill("death");
  self _unsetPerk(perkName);
}

checkForPerkUpgrade(perkName) {
  perk_upgrade = self maps\mp\gametypes\_class::getPerkUpgrade(perkName);
  if(perk_upgrade != "specialty_null") {
    self givePerk(perk_upgrade, false);
    self thread watchDeath(perk_upgrade);
  }
}

isPerkStreakOn(streakName) {
  for(i = KILLSTREAK_SLOT_1; i < KILLSTREAK_SLOT_3 + 1; i++) {
    if(isDefined(self.pers["killstreaks"][i].streakName) && self.pers["killstreaks"][i].streakName == streakName) {
      if(self.pers["killstreaks"][i].available)
        return true;
    }
  }

  return false;
}