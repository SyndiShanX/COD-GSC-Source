/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\gametypes\_killstreak_weapons.gsc
*****************************************************/

#include common_scripts\utility;
#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;

init() {
  PreCacheShader("hud_ks_minigun");
  PreCacheShader("hud_ks_m202");
  maps\mp\gametypes\_hardpoints::registerKillstreak("minigun_mp", "minigun_mp", "killstreak_minigun", "minigun_used", ::useCarriedKillstreakWeapon, false, true, "MINIGUN_USED");
  maps\mp\gametypes\_hardpoints::registerKillstreakStrings("minigun_mp", &"KILLSTREAK_EARNED_MINIGUN", &"KILLSTREAK_MINIGUN_NOT_AVAILABLE", &"KILLSTREAK_MINIGUN_INBOUND");
  maps\mp\gametypes\_hardpoints::registerKillstreakDialog("minigun_mp", "mpl_killstreak_minigun", "kls_death_used", "", "kls_death_enemy", "", "kls_death_ready");
  maps\mp\gametypes\_hardpoints::registerKillstreakDevDvar("minigun_mp", "scr_giveminigun");
  maps\mp\gametypes\_hardpoints::registerKillstreak("m202_flash_mp", "m202_flash_mp", "killstreak_m202_flash", "m202_flash_used", ::useCarriedKillstreakWeapon, false, true, "M202_FLASH_USED");
  maps\mp\gametypes\_hardpoints::registerKillstreakStrings("m202_flash_mp", &"KILLSTREAK_EARNED_M202_FLASH", &"KILLSTREAK_M202_FLASH_NOT_AVAILABLE", &"KILLSTREAK_M202_FLASH_INBOUND");
  maps\mp\gametypes\_hardpoints::registerKillstreakDialog("m202_flash_mp", "mpl_killstreak_tvmissile", "kls_grim_used", "", "kls_grim_enemy", "", "kls_grim_ready");
  maps\mp\gametypes\_hardpoints::registerKillstreakDevDvar("m202_flash_mp", "scr_givem202flash");
  maps\mp\gametypes\_hardpoints::registerKillstreak("m220_tow_mp", "m220_tow_mp", "killstreak_m220_tow", "m220_tow_used", ::useCarriedKillstreakWeapon, true, true, "M220_TOW_USED");
  maps\mp\gametypes\_hardpoints::registerKillstreakStrings("m220_tow_mp", &"KILLSTREAK_EARNED_M220_TOW", &"KILLSTREAK_M220_TOW_NOT_AVAILABLE", &"KILLSTREAK_M220_TOW_INBOUND");
  maps\mp\gametypes\_hardpoints::registerKillstreakDialog("m220_tow_mp", "mpl_killstreak_tvmissile", "kls_tv_used", "", "kls_tv_enemy", "", "kls_tv_ready");
  maps\mp\gametypes\_hardpoints::registerKillstreak("m220_tow_drop_mp", "m220_tow_drop_mp", "killstreak_m220_tow_drop", "m220_tow_used", ::useKillstreakWeaponDrop, undefined, true);
  maps\mp\gametypes\_hardpoints::registerKillstreakStrings("m220_tow_drop_mp", &"KILLSTREAK_EARNED_M220_TOW", &"KILLSTREAK_AIRSPACE_FULL", &"KILLSTREAK_M220_TOW_INBOUND");
  maps\mp\gametypes\_hardpoints::registerKillstreakDialog("m220_tow_drop_mp", "mpl_killstreak_tvmissile", "kls_tv_used", "", "kls_tv_enemy", "", "kls_tv_ready");
  maps\mp\gametypes\_hardpoints::registerKillstreakDevDvar("m220_tow_mp", "scr_givem220tow");
  level.killStreakIcons["killstreak_minigun"] = "hud_ks_minigun";
  level.killStreakIcons["killstreak_m202_flash_mp"] = "hud_ks_m202";
  level.killStreakIcons["killstreak_m220_tow_drop_mp"] = "hud_ks_tv_guided_marker";
  level.killStreakIcons["killstreak_m220_tow_mp"] = "hud_ks_tv_guided_missile";
  level thread onPlayerConnect();
}
onPlayerConnect() {
  for(;;) {
    level waittill("connecting", player);
    player thread onPlayerSpawned();
  }
}
onPlayerSpawned() {
  self endon("disconnect");
  for(;;) {
    self waittill("spawned_player");
    self.firedKillstreakWeapon = false;
    self.usingKillstreakHeldWeapon = undefined;
    self thread watchKillstreakWeaponUsage();
    self thread watchKillstreakWeaponDelay();
  }
}
watchKillstreakWeaponDelay() {
  self endon("disconnect");
  self endon("death");
  while(1) {
    currentWeapon = self GetCurrentWeapon();
    self waittill("weapon_change", newWeapon);
    if(!maps\mp\gametypes\_hardpoints::isKillstreakWeapon(newWeapon)) {
      wait(0.5);
      continue;
    }
    if(level.killstreakRoundDelay >= (maps\mp\gametypes\_globallogic_utils::getTimePassed() / 1000) &&
      maps\mp\gametypes\_hardpoints::isDelayableKillstreak(newWeapon) && isHeldKillstreakWeapon(newWeapon)) {
      timeLeft = Int(level.killstreakRoundDelay - (maps\mp\gametypes\_globallogic_utils::getTimePassed() / 1000));
      if(!timeLeft)
        timeLeft = 1;
      self iPrintLnBold(&"MP_UNAVAILABLE_FOR_N", " " + timeLeft + " ", &"EXE_SECONDS");
      self switchToWeapon(currentWeapon);
      wait(0.5);
    }
  }
}
useKillstreakWeaponDrop(hardpointType) {
  if(self maps\mp\gametypes\_supplydrop::isSupplyDropGrenadeAllowed(hardpointType) == false)
    return false;
  self thread maps\mp\gametypes\_supplydrop::refCountDecChopperOnDisconnect();
  result = self maps\mp\gametypes\_supplydrop::useSupplyDropMarker();
  self notify("supply_drop_marker_done");
  if(!isDefined(result) || !result) {
    return false;
  }
  return result;
}
useCarriedKillstreakWeapon(hardpointType) {
  if(self maps\mp\_killstreakrules::isKillstreakAllowed(hardpointType, self.team) == false)
    return false;
  if(!isDefined(hardpointType))
    return false;
  currentWeapon = self GetCurrentWeapon();
  if(hardpointType == "none")
    return false;
  level maps\mp\gametypes\_weapons::addLimitedWeapon(hardpointType, self, 3);
  self.firedKillstreakWeapon = false;
  self setBlockWeaponPickup(hardpointType, true);
  self thread watchKillsteakWeaponSwitch(hardpointType);
  self.usingKillstreakHeldWeapon = true;
  return false;
}
watchKillsteakWeaponSwitch(killstreakWeapon) {
  self endon("disconnect");
  self endon("death");
  KillstreakId = maps\mp\gametypes\_hardpoints::getTopKillstreakUniqueId();
  while(1) {
    currentWeapon = self GetCurrentWeapon();
    self waittill("weapon_change", newWeapon);
    if(newWeapon == "none")
      continue;
    if(!self checkIfSwitchableWeapon(currentWeapon, newWeapon, killstreakWeapon, KillstreakId))
      continue;
    self TakeWeapon(killstreakWeapon);
    self.firedKillstreakWeapon = false;
    self.usingKillstreakHeldWeapon = undefined;
    waittillframeend;
    self maps\mp\gametypes\_hardpoints::activateNextKillstreak();
    break;
  }
}
checkIfSwitchableWeapon(currentWeapon, newWeapon, killstreakWeapon, currentKillstreakId) {
  switchableWeapon = true;
  topKillstreak = maps\mp\gametypes\_hardpoints::getTopKillstreak();
  killstreakId = maps\mp\gametypes\_hardpoints::getTopKillstreakUniqueId();
  if(!isDefined(killstreakId))
    killstreakId = -1;
  if(self HasWeapon(killstreakWeapon) && !self GetAmmoCount(killstreakWeapon))
    switchableWeapon = true;
  else if(self.firedKillstreakWeapon && newWeapon == killstreakWeapon && isHeldKillstreakWeapon(currentWeapon))
    switchableWeapon = true;
  else if(IsWeaponEquipment(newWeapon))
    switchableWeapon = true;
  else if(isDefined(level.grenade_array[newWeapon]))
    switchableWeapon = false;
  else if(isHeldKillstreakWeapon(newWeapon) && isHeldKillstreakWeapon(currentWeapon) && currentKillstreakId != killstreakId)
    switchableWeapon = true;
  else if(maps\mp\gametypes\_hardpoints::isKillstreakWeapon(newWeapon))
    switchableWeapon = false;
  else if(isGameplayWeapon(newWeapon))
    switchableWeapon = false;
  else if(self.firedKillstreakWeapon)
    switchableWeapon = true;
  else if(self.lastNonKillstreakWeapon == killstreakWeapon)
    switchableWeapon = false;
  else if(isDefined(topKillstreak) && topKillstreak == killstreakWeapon && currentKillstreakId == killstreakId)
    switchableWeapon = false;
  return switchableWeapon;
}
watchKillstreakWeaponUsage() {
  self endon("disconnect");
  self endon("death");
  while(1) {
    self waittill("weapon_fired", killstreakWeapon);
    if(!isHeldKillstreakWeapon(killstreakWeapon)) {
      wait(0.1);
      continue;
    }
    if(self.firedKillstreakWeapon)
      continue;
    level thread maps\mp\_popups::DisplayTeamMessageToAll(level.killstreaks[killstreakWeapon].inboundText, self);
    self maps\mp\gametypes\_globallogic_score::setWeaponStat(killstreakWeapon, 1, "used");
    self maps\mp\gametypes\_hardpoints::playKillstreakStartDialog(killstreakWeapon, self.team);
    maps\mp\gametypes\_hardpoints::removeUsedKillstreak(killstreakWeapon);
    self.firedKillstreakWeapon = true;
    self setActionSlot(4, "");
    waittillframeend;
    maps\mp\gametypes\_hardpoints::activateNextKillstreak();
  }
}
isHeldKillstreakWeapon(killstreakType) {
  switch (killstreakType) {
    case "minigun_mp":
    case "m202_flash_mp":
    case "m220_tow_mp":
    case "mp40_drop_mp":
      return true;
  }
  return false;
}
isGameplayWeapon(weapon) {
  switch (weapon) {
    case "syrette_mp":
    case "briefcase_bomb_mp":
    case "briefcase_bomb_defuse_mp":
      return true;
    default:
      return false;
  }
  return false;
}