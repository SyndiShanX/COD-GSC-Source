/***************************************************
 * Decompiled by Alterware and Edited by SyndiShanX
 * Script: maps\mp\killstreaks\_juggernaut.gsc
***************************************************/

#include maps\mp\_utility;
#include common_scripts\utility;
#include maps\mp\gametypes\_hud_util;
#include maps\mp\killstreaks\_orbital_util;

CONST_JUGG_EXO_SPEED_SCALE = 1;
CONST_JUGG_EXO_SPEED_SCALE_MANIAC = 1.15;
CONST_JUGG_EXO_TURRET_TOP_ARC = 55;
CONST_JUGG_EXO_TURRET_BOTTOM_ARC = 30;
CONST_JUGG_EXO_TURRET_HORZ_ARC = 180;
CONST_JUGG_EXO_ROCKET_SWARM_RELOAD_TIME = 10;
CONST_JUGG_EXO_ROCKET_RELOAD_TIME = 10;
CONST_JUGG_EXO_HEALTH = 125;
CONST_JUGG_EXO_HEALTH_HORDE = 300;
CONST_JUGG_EXO_LETHAL = "playermech_rocket_mp";
CONST_JUGG_EXO_TACTICAL = "playermech_rocket_swarm_mp";
CONST_JUGG_EXO_TACTICAL_MANIAC = "playermech_rocket_swarm_maniac_mp";
CONST_JUGG_EXO_TIMEOUT_SEC = 120;
CONST_JUGG_EXO_USABILITY_RADIUS_SQ = 6000;

HEAVY_EXO_PING_RANGE = 700;
HEAVY_EXO_PING_RANGE_SQ = 490000;
HEAVY_EXO_PING_DURATION = 1.5;
HEAVY_EXO_PING_THREAT_DURATION = 1.75;
MIN_TIME_BETWEEN_PINGS = 5;
PING_DURATION = 10;

init() {
  level.juggSettings = [];

  level.juggSettings["juggernaut_exosuit"] = spawnStruct();
  level.juggSettings["juggernaut_exosuit"].splashUsedName = "used_juggernaut";
  level.juggSettings["juggernaut_exosuit"].splashAttachmentName = "callout_destroyed_heavyexoattachment";
  level.juggSettings["juggernaut_exosuit"].splashWeakenedName = "callout_weakened_heavyexoattachment";

  level._effect["green_light_mp"] = LoadFX("vfx/lights/aircraft_light_wingtip_green");
  level._effect["juggernaut_sparks"] = LoadFX("vfx/explosion/bouncing_betty_explosion");
  level._effect["jugg_droppod_open"] = LoadFX("vfx/explosion/goliath_pod_opening");
  level._effect["jugg_droppod_marker"] = LoadFX("vfx/unique/vfx_marker_killstreak_guide_goliath");
  level._effect["exo_ping_inactive"] = LoadFX("vfx/unique/exo_ping_inactive");
  level._effect["exo_ping_active"] = LoadFX("vfx/unique/exo_ping_active");
  level._effect["goliath_death_fire"] = LoadFX("vfx/fire/goliath_death_fire");
  level._effect["goliath_self_destruct"] = LoadFX("vfx/explosion/goliath_self_destruct");
  level._effect["lethal_rocket_wv"] = LoadFX("vfx/muzzleflash/playermech_lethal_flash_wv");
  level._effect["swarm_rocket_wv"] = LoadFX("vfx/muzzleflash/playermech_tactical_wv_run");

  level.killstreakWieldWeapons["juggernaut_sentry_mg_mp"] = "juggernaut_exosuit";
  level.killstreakWieldWeapons["iw5_juggernautrockets_mp"] = "juggernaut_exosuit";
  level.killstreakWieldWeapons["iw5_exoxmgjugg_mp_akimbo"] = "juggernaut_exosuit";
  level.killstreakWieldWeapons["iw5_juggtitan45_mp"] = "juggernaut_exosuit";
  level.killstreakWieldWeapons["iw5_exominigun_mp"] = "juggernaut_exosuit";
  level.killstreakWieldWeapons["iw5_mechpunch_mp"] = "juggernaut_exosuit";
  level.killstreakWieldWeapons["playermech_rocket_mp"] = "juggernaut_exosuit";
  level.killstreakWieldWeapons["killstreak_goliathsd_mp"] = "juggernaut_exosuit";
  level.killstreakWieldWeapons["orbital_carepackage_droppod_mp"] = "juggernaut_exosuit";
  level.killstreakWieldWeapons["heavy_exo_trophy_mp"] = "juggernaut_exosuit";
  level.killstreakFuncs["heavy_exosuit"] = ::tryUseHeavyExosuit;

  SetDvarIfUninitialized("scr_goliath_god", "0");

  game["dialog"]["assist_mp_goliath"] = "ks_goliath_joinreq";
  game["dialog"]["copilot_mp_goliath"] = "copilot_mp_goliath";

  game["dialog"]["sntryoff_mp_exoai"] = "sntryoff_mp_exoai";
  game["dialog"]["mancoff_mp_exoai"] = "mancoff_mp_exoai";
  game["dialog"]["longoff_mp_exoai"] = "longoff_mp_exoai";
  game["dialog"]["rcnoff_mp_exoai"] = "rcnoff_mp_exoai";
  game["dialog"]["rcktoff_mp_exoai"] = "rcktoff_mp_exoai";
  game["dialog"]["trphyoff_mp_exoai"] = "trphyoff_mp_exoai";
  game["dialog"]["weakdmg_mp_exoai"] = "weakdmg_mp_exoai";

  level thread onPlayerConnect();
}

tryUseHeavyExosuit(lifeId, modules) {
  if(isDefined(level.isHorde) && level.isHorde) {
    if(isDefined(self.hordeGoliathPodInField) || isDefined(self.hordeGoliathController) || isDefined(self.hordeClassGoliathController)) {
      self IPrintLnBold(&"KILLSTREAKS_HEAVY_EXO_IN_USE");
      return false;
    }
  }

  result = self playerLaunchDropPod(modules);

  return result;
}

resetWeapon() {
  killstreakWeapon = getKillstreakWeapon("heavy_exosuit");
  self SwitchToWeapon(self getLastWeapon());
  self maps\mp\killstreaks\_killstreaks::takeKillstreakWeaponIfNoDupe(killstreakWeapon);
}

canSetupStance() {
  if(self GetStance() == "prone" || self GetStance() == "crouch") {
    self SetStance("stand");
  }

  self freezeControlsWrapper(true);
  waitTimeEnd = GetTime() + 1500;
  while(GetTime() < waitTimeEnd && self GetStance() != "stand") {
    waitframe();
  }
  self freezeControlsWrapper(false);
  return self GetStance() == "stand";
}

giveJuggernaut(juggType, modules) {
  self endon("death");
  self endon("disconnect");
  if(isDefined(level.isHorde) && level.isHorde) {
    self endon("becameSpectator");
  }

  if(self maps\mp\perks\_perkfunctions::hasLightArmor()) {
    maps\mp\perks\_perkfunctions::unsetLightArmor();
  }

  if(self _hasPerk("specialty_explosivebullets")) {
    self _unsetPerk("specialty_explosivebullets");
  }

  self.maxHealth = CONST_JUGG_EXO_HEALTH;
  if(isDefined(level.isHorde) && level.isHorde) {
    self.maxHealth = CONST_JUGG_EXO_HEALTH_HORDE + (25 * self.hordeArmor);
  }
  self.health = self.maxHealth;
  self.attackerList = [];

  switch (juggType) {
    case "juggernaut_exosuit":
    default:
      speedScale = CONST_JUGG_EXO_SPEED_SCALE;
      juggClass = "juggernaut_exosuit";
      if(!isDefined(modules) || array_contains(modules, "heavy_exosuit_maniac")) {
        speedScale = CONST_JUGG_EXO_SPEED_SCALE_MANIAC;
        juggClass = "juggernaut_exosuit_maniac";
      }

      self.juggMoveSpeedScaler = speedScale;
      self removeWeapons();
      hasHardline = isDefined(self.perks["specialty_hardline"]);
      self maps\mp\gametypes\_class::giveAndApplyLoadout(self.pers["team"], juggClass, false, false);
      self maps\mp\gametypes\_playerlogic::streamClassWeapons(false, false, juggClass);
      self.isJuggernaut = true;
      self.moveSpeedScaler = speedScale;
      self givePerk("specialty_radarjuggernaut", false);
      if(hasHardline) {
        self givePerk("specialty_hardline", false);
      }
      self thread playerSetupJuggernautExo(modules, juggType);
      self.saved_lastWeapon = self getWeaponsListPrimaries()[0];
      break;
  }

  self maps\mp\gametypes\_weapons::updateMoveSpeedScale();

  self disableWeaponPickup();

  if(!isDefined(modules) || array_contains(modules, "heavy_exosuit_maniac")) {
    self playSound("goliath_suit_up_mp");
  } else {
    self playSound("goliath_suit_up_mp");
  }

  self thread teamPlayerCardSplash(level.juggSettings[juggType].splashUsedName, self);

  self thread juggRemover();

  level notify("juggernaut_equipped", self);

  self maps\mp\_matchdata::logKillstreakEvent("juggernaut", self.origin);
}

juggernautSounds() {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  self endon("jugg_removed");
  if(isDefined(level.isHorde) && level.isHorde) {
    self endon("becameSpectator");
  }

  for(;;) {
    wait(3.0);
    self playSound("juggernaut_breathing_sound");
  }
}

radarMover(portableRadar) {
  level endon("game_ended");
  self endon("disconnect");
  self endon("jugg_removed");
  self endon("jugdar_removed");

  for(;;) {
    portableRadar MoveTo(self.origin, .05);
    wait(0.05);
  }
}

juggRemover() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("jugg_removed");

  self thread juggRemoveOnGameEnded();
  self waittill_any("death", "joined_team", "joined_spectators", "lost_juggernaut");

  self enableWeaponPickup();
  self.isJuggernaut = false;
  if(isDefined(self.juggernautOverlay)) {
    self.juggernautOverlay destroy();
  }

  self unsetPerk("specialty_radarjuggernaut", true);

  if(isDefined(self.personalRadar)) {
    self notify("jugdar_removed");
    level maps\mp\gametypes\_portable_radar::deletePortableRadar(self.personalRadar);
    self.personalRadar = undefined;
  }

  self notify("jugg_removed");
}

juggRemoveOnGameEnded() {
  self endon("disconnect");
  self endon("jugg_removed");

  level waittill("game_ended");

  if(isDefined(self.juggernautOverlay)) {
    self.juggernautOverlay destroy();
  }
}

removeWeapons() {
  self.primaryToRestore = self getLastWeapon();

  foreach(weapon in self.weaponlist) {
    weaponTokens = getWeaponNameTokens(weapon);
    if(weaponTokens[0] == "alt") {
      self.restoreWeaponClipAmmo[weapon] = self GetWeaponAmmoClip(weapon);
      self.restoreWeaponStockAmmo[weapon] = self GetWeaponAmmoStock(weapon);
      continue;
    }

    self.restoreWeaponClipAmmo[weapon] = self GetWeaponAmmoClip(weapon);
    self.restoreWeaponStockAmmo[weapon] = self GetWeaponAmmoStock(weapon);
  }

  self.weaponsToRestore = [];
  foreach(weapon in self.weaponlist) {
    weaponTokens = getWeaponNameTokens(weapon);
    if(weaponTokens[0] == "alt") {
      continue;
    }

    if(isKillstreakWeapon(weapon)) {
      continue;
    }

    self.weaponsToRestore[self.weaponsToRestore.size] = weapon;

    self TakeWeapon(weapon);
  }

}

playerSetupJuggernautExo(modules, juggType) {
  data = spawnStruct();
  self.heavyExoData = data;
  data.streakPlayer = self;
  data.hasCoopSentry = true;
  data.modules = modules;
  data.juggType = juggType;

  data.hasCoopSentry = GetDvarInt("scr_heavy_exo_turret", 1) == 1;

  if(isDefined(modules)) {
    data.hasRadar = array_contains(modules, "heavy_exosuit_radar");
    data.hasManiac = array_contains(modules, "heavy_exosuit_maniac");
    data.hasLongPunch = array_contains(modules, "heavy_exosuit_punch");
    data.hasTrophy = array_contains(modules, "heavy_exosuit_trophy");
    data.hasRockets = array_contains(modules, "heavy_exosuit_rockets");
    data.hasExtraAmmo = array_contains(modules, "heavy_exosuit_ammo");
  } else {
    data.hasRadar = true;
    data.hasManiac = true;
    data.hasLongPunch = false;
    data.hasTrophy = true;
    data.hasRockets = true;
    data.hasExtraAmmo = true;
  }

  modulesOn = 0;

  if(data.hasRockets) modulesOn += 1;
  if(data.hasLongPunch) modulesOn += 2;
  if(data.hasRadar) modulesOn += 4;
  if(data.hasTrophy) modulesOn += 8;
  if(data.hasManiac) modulesOn += 16;
  if(data.hasCoopSentry) modulesOn += 32;
  self SetClientOmnvar("ui_exo_suit_modules_on", modulesOn);

  self playerAllowPowerSlide(false, "heavyexo");

  if(!data.hasManiac) {
    self playerAllowDodge(false, "heavyexo");
    self playerAllowBoostJump(false, "heavyexo");
    self playerAllowHighJump(false, "heavyexo");
    self playerAllowHighJumpDrop(false, "heavyexo");
  }
  self _disableUsability();
  self AllowJump(false);
  self AllowCrouch(false);
  self AllowLadder(false);
  self AllowMantle(false);
  self.inLivePlayerKillstreak = true;
  self.mechHealth = CONST_JUGG_EXO_HEALTH;
  if(isDefined(level.isHorde) && level.isHorde) {
    self.mechHealth = self.maxhealth;
  }
  self SetDemiGod(true);
  self SetClientOmnvar("ui_exo_suit_health", 1);

  self playerSetJuggExoModel(data);
  self thread playerShowJuggernautHud(data);
  self thread playerCleanupOnDeath(data);
  self thread playerCleanupOnOther();
  self thread playerRocketsAndSwarmWatcher();
  self thread playermech_invalid_weapon_watcher();
  self thread playerHandleBootupSequence();
  self thread play_goliath_death_fx();
  self thread playermech_watch_emp_grenade();
  if(isDefined(level.isHorde) && level.isHorde) {
    self thread playerMechTimeout();
  }

  if(data.hasCoopSentry) {}

  if(data.hasRadar) {
    level thread setupRadar(self, data);
  }

  if(data.hasManiac) {
    level thread setupManiac(self);
    set_mech_chaingun_state("offline");
  } else {
    self thread playerHandleBarrel();
    set_mech_chaingun_state("ready");
  }

  if(data.hasLongPunch) {
    level thread setupLongPunch(self, data);
    set_mech_rocket_state("ready");
    self thread playermech_monitor_rocket_recharge();
  } else {
    set_mech_rocket_state("offline");
    if(!data.hasManiac) {
      self DisableOffhandWeapons();
    }
  }

  if(data.hasTrophy) {
    level thread setupTrophy(self, data);
  }

  if(data.hasRockets) {
    level thread setupRocketSwarm(self, data);
    set_mech_swarm_state("ready");
    self thread playermech_monitor_swarm_recharge();
  } else {
    self DisableOffhandSecondaryWeapons();
    set_mech_swarm_state("offline");
  }

  level thread delaySetWeapon(self);

  if(isDefined(level.isHorde) && level.isHorde) {
    self endon("horde_cancel_goliath");
  }

  wait(5);

  if(isDefined(self)) {
    self thread self_destruct_goliath();
  }
}

playerHandleBootupSequence() {
  self.goliathBootupSequence = true;

  wait 4.16;

  self.goliathBootupSequence = undefined;
}

juggernautModifyDamage(victim, eAttacker, iDamage, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc, eInflictor) {
  if(!victim isJuggernaut()) {
    return iDamage;
  }

  finalDamage = iDamage;

  if(isDefined(sMeansOfDeath) && sMeansOfDeath == "MOD_FALLING") {
    finalDamage = 0;
  }

  if(isDefined(sWeapon) && sWeapon == "boost_slam_mp") {
    finalDamage = 20;
  }

  if(isDefined(eAttacker) && isDefined(victim) && eAttacker == victim && isDefined(sWeapon) && (sWeapon == "iw5_juggernautrockets_mp" || sWeapon == "playermech_rocket_mp")) {
    finalDamage = 0;
  }

  if(isDefined(victim.goliathBootupSequence) && victim.goliathBootupSequence) {
    if(isDefined(level.isHorde) && level.isHorde && sMeansOfDeath == "MOD_TRIGGER_HURT" && victim touchingBadTrigger()) {
      finalDamage = 10000;
    } else {
      finalDamage = 0;
    }
  }

  if(isDefined(eAttacker) && !maps\mp\gametypes\_weapons::friendlyFireCheck(victim, eAttacker)) {
    finalDamage = 0;
  }

  if(GetDvar("scr_goliath_god", "0") != "0") {
    finalDamage = 0;
  }

  if(finalDamage > 0) {
    if(attackerIsHittingTeam(victim, eAttacker)) {
      if(isDefined(level.juggernautMod)) {
        finalDamage *= level.juggernautMod;
      } else {
        finalDamage *= 0.08;
      }
    }

    if(isDefined(sHitLoc) && sHitLoc == "head") {
      finalDamage *= 4.0;
    }

    if(isDefined(sWeapon) && sWeapon == "killstreak_goliathsd_mp" && isDefined(eAttacker) && isDefined(victim) && eAttacker == victim) {
      finalDamage = victim.mechHealth + 1;
    }

    if(isDefined(sWeapon) && sWeapon == "nuke_mp" && isDefined(eAttacker) && isDefined(victim) && eAttacker != victim) {
      finalDamage = victim.mechHealth + 1;
    }

    victim.mechHealth -= finalDamage;
    if(isDefined(level.isHorde) && level.isHorde) {
      victim SetClientOmnvar("ui_exo_suit_health", victim.mechHealth / victim.maxhealth);
    } else {
      victim SetClientOmnvar("ui_exo_suit_health", victim.mechHealth / CONST_JUGG_EXO_HEALTH);
    }

    if(isDefined(eAttacker) && IsPlayer(eAttacker)) {
      if(isDefined(sHitLoc) && sHitLoc == "head") {
        eAttacker maps\mp\gametypes\_damagefeedback::updateDamageFeedback("headshot");
      } else {
        eAttacker maps\mp\gametypes\_damagefeedback::updateDamageFeedback("hitjuggernaut");
      }

      if(victim maps\mp\gametypes\_damage::isNewAttacker(eAttacker)) {
        victim.attackerList[victim.attackerList.size] = eAttacker;
      }
    }

    if(victim.mechHealth < 0) {
      if(isDefined(level.isHorde) && level.isHorde) {
        self maps\mp\_snd_common_mp::snd_message("goliath_self_destruct");
        playFX(getfx("goliath_self_destruct"), self.origin, AnglesToUp(self.angles));
        self thread[[level.hordeHandleJuggDeath]]();
      } else {
        victim thread playerKillHeavyExo(vPoint, eAttacker, sMeansOfDeath, sWeapon, eInflictor);
      }
    }
  }

  return int(finalDamage);
}

playerKillHeavyExo(point, attacker, meansOfDeath, weapon, eInflictor) {
  self notify("killHeavyExo");
  self _enableUsability();
  self AllowJump(true);
  self AllowCrouch(true);
  self AllowLadder(true);
  self AllowMantle(true);
  self SetDemiGod(false);
  self.isJuggernaut = false;
  damage = 1001;

  if(!isDefined(point)) {
    point = self.origin;
  }

  damaged = false;

  if(isDefined(weapon) && isDefined(attacker) && isDefined(meansOfDeath) && isDefined(eInflictor)) {
    damaged = self DoDamage(damage, point, attacker, eInflictor, meansOfDeath, weapon);
  } else if(isDefined(weapon) && isDefined(attacker) && isDefined(meansOfDeath)) {
    damaged = self DoDamage(damage, point, attacker, undefined, meansOfDeath, weapon);
  } else if(isDefined(attacker) && isDefined(meansOfDeath)) {
    damaged = self DoDamage(damage, point, attacker, undefined, meansOfDeath);
  } else if(isDefined(attacker)) {
    damaged = self DoDamage(damage, point, attacker, undefined);
  } else {
    damaged = self DoDamage(damage, point);
  }

  Assert(damaged == true);
}

delaySetWeapon(player) {
  player endon("death");
  player endon("disconnect");
  if(isDefined(level.isHorde) && level.isHorde) {
    player endon("becameSpectator");
  }

  killstreakWeapon = getKillstreakWeapon("heavy_exosuit");
  player maps\mp\killstreaks\_killstreaks::takeKillstreakWeaponIfNoDupe(killstreakWeapon);
  player GiveWeapon("iw5_exominigun_mp");
  player SwitchToWeapon("iw5_exominigun_mp");
  player notify("waitTakeKillstreakWeapon");
  waitframe();
  player SetPlayerMech(1);
  player DisableWeaponSwitch();
}

playerCleanupOnDeath(data) {
  self endon("disconnect");

  self waittill("death", attacker, meansOfDeath, weapon);

  if(isDefined(attacker) && IsPlayer(attacker) && (attacker != self)) {
    attacker incPlayerStat("goliath_destroyed", 1);
    level thread maps\mp\gametypes\_rank::awardGameEvent("goliath_destroyed", attacker, weapon, self, meansOfDeath);
  }

  if(!isDefined(level.isHorde)) {
    self maps\mp\_events::checkVandalismMedal(attacker);
  }

  self.inLivePlayerKillstreak = undefined;
  self.mechHealth = undefined;

  self playerReset(data);
}

playerCleanupOnOther() {
  self endon("death");
  self endon("disconnect");
  self endon("joined_team");
  self endon("faux_spawn");
  if(isDefined(level.isHorde) && level.isHorde) {
    self endon("becameSpectator");
  }

  level waittill_any("game_ended");

  self playerResetOmnvars();
}

playerReset(data) {
  self notify("lost_juggernaut");
  self notify("exit_mech");

  self playerResetOmnvars();
  self playerAllowDodge(true, "heavyexo");
  self playerAllowPowerSlide(true, "heavyexo");
  self playerAllowBoostJump(true, "heavyexo");
  self playerAllowHighJump(true, "heavyexo");
  self EnableOffhandSecondaryWeapons();
  self EnableOffhandWeapons();
  self EnableWeaponSwitch();

  self SetPlayerMech(0);

  self.restoreWeaponClipAmmo = undefined;
  self.restoreWeaponStockAmmo = undefined;
  self.juggernautWeak = undefined;
  self.heavyExoData = undefined;
  if(isDefined(self.juggernautAttachments)) {
    self.juggernautAttachments = undefined;
  }

  foreach(element in data.hud) {
    if(isDefined(element)) {
      element.textOffline = undefined;
      element.type = undefined;
      element Destroy();
    }
  }
}

playerResetOmnvars() {
  self SetClientOmnvar("ui_exo_suit_enabled", false);
  self SetClientOmnvar("ui_exo_suit_modules_on", 0);
  self SetClientOmnvar("ui_exo_suit_health", 0);
  self SetClientOmnvar("ui_exo_suit_recon_cd", 0);
  self SetClientOmnvar("ui_exo_suit_punch_cd", 0);
  self SetClientOmnvar("ui_exo_suit_rockets_cd", 0);

  self SetClientOmnvar("ui_playermech_swarmrecharge", 0);
  self SetClientOmnvar("ui_playermech_rocketrecharge", 0);
}

playerSetJuggExoModel(data) {
  self DetachAll();

  self setModel("npc_exo_armor_mp_base");
  self Attach("head_hero_cormack_sentinel_halo");
  self SetViewModel("vm_view_arms_mech_mp");

  if((isDefined(data) && !data.hasManiac) || isDefined(level.isHorde)) {
    self Attach("npc_exo_armor_minigun_handle", "TAG_HANDLE");
  }

  if(IsAI(self)) {
    self.hideOnDeath = true;
  }

  self notify("goliath_equipped");
}

playerHandleBarrel() {
  self endon("death");
  self endon("disconnect");
  if(isDefined(level.isHorde) && level.isHorde) {
    self endon("becameSpectator");
  }

  self thread playerCleanupBarrel();

  self NotifyOnPlayerCommand("goliathAttack", "+attack");
  self NotifyOnPlayerCommand("goliathAttackDone", "-attack");

  self.barrelLinker = spawn("script_model", self GetTagOrigin("tag_barrel"));
  self.barrelLinker setModel("generic_prop_raven");
  self.barrelLinker LinkToSynchronizedParent(self, "tag_barrel", (12.7, 0, -2.9), (90, 0, 0));

  self.barrel = spawn("script_model", self.barrelLinker GetTagOrigin("j_prop_1"));
  self.barrel setModel("npc_exo_armor_minigun_barrel");
  self.barrel LinkToSynchronizedParent(self.barrelLinker, "j_prop_1", (0, 0, 0), (-90, 0, 0));

  if(isDefined(level.isHorde) && level.isHorde && isPlayer(self)) {
    self.barrel HudOutlineEnable(5, true);
  }

  self.barrelLinker ScriptModelPlayAnimDeltaMotion("mp_generic_prop_spin_02");
  self.barrelLinker ScriptModelPauseAnim(true);

  while(true) {
    self waittill("goliathAttack");
    self.barrelLinker ScriptModelPauseAnim(false);

    self waittill("goliathAttackDone");
    self.barrelLinker ScriptModelPauseAnim(true);
  }
}

playerCleanupBarrel() {
  if(isDefined(level.isHorde) && level.isHorde) {
    self waittill_any("death", "disconnect", "becameSpectator");
  } else {
    self waittill_any("death", "disconnect");
  }

  if(isDefined(level.isHorde) && level.isHorde) {
    self.barrel HudOutlineDisable();
  }
  self.barrel Delete();
  self.barrelLinker Delete();
}

playerRocketsAndSwarmWatcher() {
  self endon("death");
  self endon("disconnect");
  if(isDefined(level.isHorde) && level.isHorde) {
    self endon("becameSpectator");
  }

  while(true) {
    self waittill("grenade_pullback", weaponName);

    if(weaponName == CONST_JUGG_EXO_LETHAL) {
      self notify("mech_rocket_pullback");
      self waittill("grenade_fire", missileEnt, weaponName);
      self notify("mech_rocket_fire", missileEnt);
    } else if(weaponName == CONST_JUGG_EXO_TACTICAL || weaponName == CONST_JUGG_EXO_TACTICAL_MANIAC) {
      self notify("mech_swarm_pullback");
      self waittill("grenade_fire", missileEnt, weaponName);
      self notify("mech_swarm_fire", missileEnt.origin);
      missileEnt delete();
    }

    waitframe();
  }
}

setupCoopTurret(data, player) {
  startOrigin = player GetTagOrigin("tag_turret");

  turret = spawnAttachment("juggernaut_sentry_mg_mp", "npc_heavy_exo_armor_turret_base", startOrigin, 200, player, &"KILLSTREAKS_HEAVY_EXO_SENTRY_LOST");
  turret SetMode("sentry_offline");
  turret SetSentryOwner(player);
  turret SetLeftArc(CONST_JUGG_EXO_TURRET_HORZ_ARC);
  turret SetRightArc(CONST_JUGG_EXO_TURRET_HORZ_ARC);
  turret SetTopArc(CONST_JUGG_EXO_TURRET_TOP_ARC);
  turret SetBottomArc(CONST_JUGG_EXO_TURRET_BOTTOM_ARC);
  turret SetDefaultDropPitch(0.0);
  turret SetTurretModeChangeWait(true);
  turret MakeUnusable();
  turret MakeTurretSolid();
  turret.rocketTurret = false;
  turret.energyTurret = false;
  turret.turretType = "mg_turret";
  turret.isSentry = false;
  turret.stunned = false;
  turret.nextTracer = 5;
  turret.heatLevel = 0;
  turret.baseOwner = player;
  if(level.teamBased) {
    turret setTurretTeam(player.team);
  }

  turret make_entity_sentient_mp(player.team);
  turret maps\mp\killstreaks\_autosentry::addToTurretList(turret GetEntityNumber());
  turret thread maps\mp\killstreaks\_remoteturret::turret_watchDisabled();
  turret LinkTo(player, "tag_turret", (0, 0, 0), (0, 0, 0));

  turret.effect = spawnAttachmentEffect(startOrigin, player);
  turret.effect LinkTo(turret, "tag_player", (29, -7, -6), (0, 0, 0));
  turret.effect Hide();

  data.coopTurret = turret;

  thread stopTurret(data, turret, player);
  thread handleCoopShooting(data, turret, player);
  thread handleTurretOnPlayerDone(data, turret, player);

  return turret;
}

stopTurret(data, turret, player) {
  turret waittill("death");

  if(isDefined(turret)) {
    turret.isSentry = false;
    player notify("turretDead");
    removeCoopTurretBuddy(data);
    stopFXOnAttachment(turret, getfx("green_light_mp"), true);
    turret playSound("sentry_explode");
    turret thread maps\mp\killstreaks\_remoteturret::sentry_stopAttackingTargets();
    turret maps\mp\killstreaks\_autosentry::removeFromTurretList(turret GetEntityNumber());
    turret SetMode("sentry_offline");
    turret.damagecallback = undefined;
    turret setCanDamage(false);
    turret SetDamageCallbackOn(false);
    turret FreeEntitySentient();
    turret setDefaultDropPitch(35);
    turret SetSentryOwner(undefined);
    level thread doTurretDeathEffects(turret);
  }
}

handleCoopShooting(data, turret, player) {
  turret endon("death");

  fireTime = weaponFireTime("juggernaut_sentry_mg_mp");

  while(true) {
    if(!isDefined(turret.remoteControlled) || !turret.remoteControlled) {
      waitframe();
      continue;
    }

    if(turret.owner AttackButtonPressed() && !turret IsTurretOverheated()) {
      turret turretShootBlank(turret.baseOwner);
      wait fireTime;
      continue;
    }

    waitframe();
  }
}

turretShoot() {
  self ShootTurret();

  self turretShootBlank(self.baseOwner);
}

turretShootBlank(showTo) {
  aimOrigin = self GetTagOrigin("tag_flash");
  aimDir = anglesToForward(self GetTagAngles("tag_flash"));
  aimEnd = aimOrigin + (aimDir * 1000);

  drawTracer = false;
  self.nextTracer--;
  if(self.nextTracer <= 0) {
    drawTracer = true;
    self.nextTracer = 5;
  }

  ShootBlank(aimOrigin, aimEnd, "juggernaut_sentry_mg_mp", drawTracer, showTo);
}

doTurretDeathEffects(turret) {
  turret playSound("sentry_explode");

  playFXOnTag(getFx("sentry_explode_mp"), turret, "tag_aim");
  wait(1.5);

  if(!isDefined(turret)) {
    return;
  }

  turret playSound("sentry_explode_smoke");
  for(i = 0; i < 10; i++) {
    playFXOnTag(getFx("sentry_smoke_mp"), turret, "tag_aim");
    wait(0.4);

    if(!isDefined(turret)) {
      return;
    }
  }
}

handleTurretOnPlayerDone(data, turret, player) {
  thread attachmentDeath(data, turret, player);

  waittillAttachmentDone(player);

  stopFXOnAttachment(turret, getfx("green_light_mp"));
  turret maps\mp\killstreaks\_autosentry::removeFromTurretList(turret GetEntityNumber());
  turret.isSentry = false;
  player notify("turretDead");
  removeCoopTurretBuddy(data);
  turret Delete();
}

setupRadar(player, data) {
  radarOrigin = player GetTagOrigin("tag_recon_back");

  radar = spawnAttachment("radar", "npc_heavy_exo_armor_recon_back_base", radarOrigin, undefined, player);
  radar LinkTo(player, "tag_recon_back", (0, 0, 0), (0, 0, 0));

  player thread playerHandleRadarPing(data, radar);

  waittillAttachmentDone(player);

  waitframe();
  radar Delete();
}

playerHandleRadarPing(data, radar) {
  radar endon("death");
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");
  self endon("joined_team");
  if(isDefined(level.isHorde) && level.isHorde) {
    self endon("becameSpectator");
  }

  if(!IsBot(self)) {
    self NotifyOnPlayerCommand("juggernautPing", "weapnext");
  }

  playFXOnTag(getfx("exo_ping_inactive"), self, "J_SpineUpper");
  while(true) {
    self waittill("juggernautPing");

    activate_exo_ping();

    self SetClientOmnvar("ui_exo_suit_recon_cd", 1);
    wait PING_DURATION;

    deactivate_exo_ping();

    waitAttachmentCooldown(MIN_TIME_BETWEEN_PINGS, "ui_exo_suit_recon_cd");
  }
}

activate_exo_ping() {
  self thread stop_exo_ping();

  self SetPerk("specialty_exo_ping", true, false);

  self PlayLocalSound("mp_exo_cloak_activate");

  self.highlight_effect = maps\mp\_threatdetection::detection_highlight_hud_effect_on(self, -1);

  KillFXOnTag(getfx("exo_ping_inactive"), self, "J_SpineUpper");
  playFXOnTag(getfx("exo_ping_active"), self, "J_SpineUpper");
}

deactivate_exo_ping() {
  self UnSetPerk("specialty_exo_ping", true);

  self PlayLocalSound("mp_exo_cloak_deactivate");

  if(isDefined(self.highlight_effect)) {
    maps\mp\_threatdetection::detection_highlight_hud_effect_off(self.highlight_effect);
  }

  KillFXOnTag(getfx("exo_ping_active"), self, "J_SpineUpper");
  playFXOnTag(getfx("exo_ping_inactive"), self, "J_SpineUpper");
}

stop_exo_ping() {
  self endon("disconnect");

  if(isDefined(level.isHorde) && level.isHorde) {
    self waittill_any("death", "faux_spawn", "joined_team", "becameSpectator");
  } else {
    self waittill_any("death", "faux_spawn", "joined_team");
  }

  self UnSetPerk("specialty_exo_ping", true);

  if(isDefined(self.highlight_effect)) {
    maps\mp\_threatdetection::detection_highlight_hud_effect_off(self.highlight_effect);
  }

  KillFXOnTag(getfx("exo_ping_active"), self, "J_SpineUpper");
}

setupManiac(player) {
  legsOrigin = player GetTagOrigin("tag_maniac_l");
  speedAttachment = spawnAttachment("speedAttachment", "npc_heavy_exo_armor_maniac_l_base", legsOrigin, undefined, player);
  speedAttachment LinkTo(player, "tag_maniac_l", (0, 0, 0), (0, 0, 0));

  legsOrigin = player GetTagOrigin("tag_maniac_r");
  speedAttachmentR = spawnAttachment("speedAttachment", "npc_heavy_exo_armor_maniac_r_base", legsOrigin, undefined, player);
  speedAttachmentR LinkTo(player, "tag_maniac_r", (0, 0, 0), (0, 0, 0));

  backOrigin = player GetTagOrigin("tag_jetpack");
  speedAttachmentB = spawnAttachment("speedAttachment", "npc_heavy_exo_armor_jetpack_base", backOrigin, undefined, player);
  speedAttachmentB LinkTo(player, "tag_jetpack", (0, 0, 0), (0, 0, 0));

  waittillAttachmentDone(player);

  attachmentExplode(speedAttachment, player, "maniac", speedAttachmentR);
  attachmentExplode(speedAttachmentB, player, "maniac");
  waitframe();
  speedAttachment Delete();
  speedAttachmentR Delete();
  speedAttachmentB Delete();
}

setupLongPunch(player, data) {
  player SetLethalWeapon(CONST_JUGG_EXO_LETHAL);
  player GiveWeapon(CONST_JUGG_EXO_LETHAL);

  tag = "tag_origin";

  player thread playerWatchNoobTubeUse(data);

  waittillAttachmentDone(player);
}

playerWatchNoobTubeUse(data) {
  self endon("death");
  self endon("disconnect");
  if(isDefined(level.isHorde) && level.isHorde) {
    self endon("becameSpectator");
  }

  while(true) {
    self waittill("mech_rocket_fire", missileEnt);

    playFXOnTag(getfx("lethal_rocket_wv"), self, "TAG_WEAPON_RIGHT");

    thread reloadRocket(self, data);
  }
}

reloadRocket(player, data) {
  player endon("death");
  player endon("disconnect");
  if(isDefined(level.isHorde) && level.isHorde) {
    player endon("becameSpectator");
  }

  waitAttachmentCooldown(CONST_JUGG_EXO_ROCKET_RELOAD_TIME, "ui_exo_suit_punch_cd");
}

playRocketReloadSound(player) {
  self PlayLocalSound("orbitalsupport_reload_40mm");
}

waitAttachmentCooldown(duration, omnvar) {
  waited = 0;
  while(true) {
    wait 0.05;
    waited += 0.05;
    coolDown = 1 - (waited / duration);
    coolDown = clamp(coolDown, 0, 1);
    self SetClientOmnvar(omnvar, coolDown);
    if(coolDown <= 0) {
      break;
    }
  }
}

setupTrophy(player, data) {
  chestOrigin = player GetTagOrigin("j_spine4");

  trophy1 = spawnAttachment("trophy", "npc_heavy_exo_armor_trophy_l_base", chestOrigin, undefined, player);
  trophy1.stunned = false;
  trophy1.ammo = 1;
  trophy1 LinkTo(player, "tag_trophy_l", (0, 0, 0), (0, 0, 0));
  trophy1.weaponName = "heavy_exo_trophy_mp";
  trophy1 thread maps\mp\gametypes\_equipment::trophyActive(player, undefined, true, trophy1.weaponName);
  trophy1 thread maps\mp\gametypes\_equipment::trophyAddlaser(12, (90, 90, 270));
  trophy1 thread maps\mp\gametypes\_equipment::trophySetMinDot(-0.087, (90, 90, 270));
  level.trophies[level.trophies.size] = trophy1;

  trophy2 = spawnAttachment("trophy", "npc_heavy_exo_armor_trophy_r_base", chestOrigin, undefined, player);
  trophy2.stunned = false;
  trophy2.ammo = 1;
  trophy2 LinkTo(player, "tag_trophy_r", (0, 0, 0), (0, 0, 0));
  trophy2.weaponName = "heavy_exo_trophy_mp";
  trophy2 thread maps\mp\gametypes\_equipment::trophyActive(player, undefined, true, trophy2.weaponName);
  trophy2 thread maps\mp\gametypes\_equipment::trophyAddlaser(6, (260, 90, 270));
  trophy2 thread maps\mp\gametypes\_equipment::trophySetMinDot(-0.087, (260, 90, 270));
  level.trophies[level.trophies.size] = trophy2;

  trophy1.otherTrophy = trophy2;
  trophy2.otherTrophy = trophy1;

  waittillAttachmentDone(player);

  trophy1 notify("trophyDisabled");
  trophy2 notify("trophyDisabled");

  waitframe();
  if(isDefined(trophy1.laserEnt)) {
    trophy1.laserEnt Delete();
  }
  if(isDefined(trophy2.laserEnt)) {
    trophy2.laserEnt Delete();
  }
  trophy1 Delete();
  trophy2 Delete();
}

trophyStunBegin() {
  if(self.stunned) {
    return;
  }

  self.stunned = true;
  self.otherTrophy.stunned = true;
  stunEnt = spawn("script_model", self.origin);
  stunEnt setModel("tag_origin");
  playFXOnTag(getfx("mine_stunned"), stunEnt, "tag_origin");
  self thread trophyMoveStunEnt(stunEnt);

  self waittill_notify_or_timeout("death", 3);
  self notify("stunEnd");

  stopFXOnTag(getfx("mine_stunned"), stunEnt, "tag_origin");
  waitframe();
  stunEnt Delete();
  if(isDefined(self)) {
    self.stunned = false;
    self.otherTrophy.stunned = false;
  }
}

trophyMoveStunEnt(stunEnt) {
  self endon("death");
  self endon("stunEnd");

  while(true) {
    stunEnt.origin = self.origin;
    waitframe();
  }
}

setupRocketSwarm(player, data) {
  swarmWeapon = CONST_JUGG_EXO_TACTICAL;
  if(data.hasManiac) {
    swarmWeapon = CONST_JUGG_EXO_TACTICAL_MANIAC;
  }
  player SetTacticalWeapon(swarmWeapon);
  player GiveWeapon(swarmWeapon);

  tag = "tag_origin";
  startOrigin = player GetTagOrigin(tag);

  rocketAttachment = spawnAttachment("rocketAttachment", "npc_heavy_exo_armor_missile_pack_base", startOrigin, undefined, player);
  rocketAttachment.lockedTarget = false;
  rocketAttachment.reloading = false;
  rocketAttachment.rockets = [];
  rocketAttachment.icons = [];
  rocketAttachment LinkTo(player, tag, (0, 0, 0), (0, 0, 0));
  rocketAttachment Hide();
  player.rocketAttachment = rocketAttachment;

  thread scanForRocketEnemies(rocketAttachment, player);
  player thread playerWatchRocketUse(rocketAttachment, data);

  waittillAttachmentDone(player, rocketAttachment);

  waitframe();
  rocketAttachment Delete();
  player.rocketAttachment = undefined;
}

scanForRocketEnemies(rocketAttachment, streakPlayer) {
  streakPlayer endon("death");
  streakPlayer endon("disconnect");
  if(isDefined(level.isHorde) && level.isHorde) {
    streakplayer endon("becameSpectator");
  }

  while(true) {
    waitframe();

    if(rocketAttachment.reloading || rocketAttachment.rockets.size > 0 || rocketAttachment.lockedTarget) {
      continue;
    }

    bestEnemy = getBestEnemy(streakPlayer, 4);

    if(isDefined(bestEnemy)) {
      if(!isDefined(rocketAttachment.enemyTarget) || rocketAttachment.enemyTarget != bestEnemy) {
        thread markPlayerAsRocketTarget(rocketAttachment, streakPlayer, bestEnemy);
      }
    } else if(isDefined(rocketAttachment.enemyTarget)) {
      rocketAttachment notify("unmark");
      rocketAttachment.enemyTarget = undefined;
    }
  }
}

playerIsRocketSwarmReloading() {
  return (isDefined(self.rocketAttachment) && isDefined(self.rocketAttachment.reloading) && self.rocketAttachment.reloading);
}

playerIsRocketSwarmTargetLocked() {
  return (isDefined(self.rocketAttachment) && isDefined(self.rocketAttachment.enemyTarget));
}

getBestEnemy(player, numSightTracesTotal) {
  cos32 = 0.8433914458;
  playerDir = anglesToForward(player GetPlayerAngles());
  playerEye = player getEye();
  bestEnemy = undefined;

  bestEnemies = [];
  foreach(guy in level.participants) {
    if(guy.team == player.team) {
      continue;
    }

    if(!isReallyAlive(guy)) {
      continue;
    }

    enemyEye = guy getEye();
    dirToEnemy = VectorNormalize(enemyEye - playerEye);
    dot = VectorDot(playerDir, dirToEnemy);
    if(dot > cos32) {
      bestEnemies[bestEnemies.size] = guy;
      guy.dot = dot;
      guy.checked = false;
    }
  }

  if(bestEnemies.size == 0) {
    return;
  }

  numSightTraces = 0;
  while(numSightTraces < numSightTracesTotal && numSightTraces < bestEnemies.size) {
    nextEnemy = getHighestDot(bestEnemies);
    nextEnemy.checked = true;

    start = playerEye;
    end = nextEnemy getEye();
    passed = SightTracePassed(start, end, true, player, nextEnemy);
    if(passed) {
      bestEnemy = nextEnemy;

      break;
    }

    numSightTraces++;
  }

  foreach(guy in level.participants) {
    guy.dot = undefined;
    guy.checked = undefined;
  }

  return bestEnemy;
}

getHighestDot(enemies) {
  if(enemies.size == 0) {
    return;
  }

  bestEnemy = undefined;
  bestDot = 0;

  foreach(enemy in enemies) {
    if(!enemy.checked && enemy.dot > bestDot) {
      bestEnemy = enemy;
      bestDot = enemy.dot;
    }
  }

  return bestEnemy;
}

playerWatchRocketUse(rocketAttachment, data) {
  rocketAttachment endon("death");

  while(true) {
    self waittill("mech_swarm_fire", origin);

    if(rocketAttachment.reloading || rocketAttachment.lockedTarget) {
      waitframe();
      continue;
    }

    {
      thread handleLockedTarget(rocketAttachment, data);
      thread reloadRocketSwarm(rocketAttachment, self, data);
      thread fireRocketSwarm(rocketAttachment, self, origin);
    }
  }
}

handleLockedTarget(rocketAttachment, data) {
  rocketAttachment endon("death");

  rocketAttachment.lockedTarget = true;
  rocketAttachment notify("lockedTarget");

  waittillRocketsExploded(rocketAttachment);

  if(isDefined(rocketAttachment)) {
    rocketAttachment.lockedTarget = false;
    rocketAttachment.enemyTarget = undefined;
  }
}

fireRocketSwarm(rocketAttachment, streakPlayer, origin) {
  playerDir = anglesToForward(streakPlayer GetPlayerAngles());
  playerRight = AnglesToRight(streakPlayer GetPlayerAngles());
  offsets = [(0, 0, 50), (0, 0, 20), (10, 0, 0), (0, 10, 0)];

  playFXOnTag(getfx("swarm_rocket_wv"), streakPlayer, "TAG_ROCKET4");

  for(i = 0; i < 4; i++) {
    initOrigin = origin + (playerDir * 20) + (playerRight * -30);
    fireDirection = playerDir + random_vector(0.2);

    rocket = MagicBullet("iw5_juggernautrockets_mp", initOrigin, initOrigin + fireDirection, streakPlayer);
    rocketAttachment.rockets = array_add(rocketAttachment.rockets, rocket);
    rocket thread rocketTargetEnt(rocketAttachment, rocketAttachment.enemyTarget, offsets[i]);
    rocket thread rocketDestroyAfterTime(7);
  }
}

rocketTargetEnt(rocketAttachment, target, offset) {
  rocketAttachment endon("death");

  if(isDefined(target)) {
    self Missile_SetTargetEnt(target, offset);
  }
  self waittill("death");

  rocketAttachment.rockets = array_remove(rocketAttachment.rockets, self);
}

rocketDestroyAfterTime(time) {
  self endon("death");

  wait time;

  self Delete();
}

reloadRocketSwarm(rocketAttachment, player, data) {
  rocketAttachment endon("death");

  rocketAttachment.reloading = true;

  waitAttachmentCooldown(CONST_JUGG_EXO_ROCKET_SWARM_RELOAD_TIME, "ui_exo_suit_rockets_cd");

  rocketAttachment.reloading = false;
}

playRocketSwarmReloadSound(rocketAttachment, player, reloadTime) {
  rocketAttachment endon("death");

  missileCount = 3;

  self PlayLocalSound("warbird_missile_reload_bed");

  wait 0.5;

  for(i = 0; i < missileCount; i++) {
    self PlayLocalSound("warbird_missile_reload");
    wait(reloadTime / missileCount);
  }
}

markPlayerAsRocketTarget(rocketAttachment, streakPlayer, markedPlayer) {
  markedPlayer endon("disconnect");
  rocketAttachment notify("mark");
  rocketAttachment endon("mark");
  rocketAttachment endon("unmark");

  offset = (0, 0, 60);

  entNum = markedPlayer GetEntityNumber();

  rocketAttachment.enemyTarget = markedPlayer;
  if(isDefined(level.isHorde) && level.isHorde) {
    markedPlayer HudOutlineEnableForClient(streakPlayer, 1, 0);
    streakPlayer.markedForMech[streakPlayer.markedForMech.size] = markedPlayer;
  } else {
    markedPlayer HudOutlineEnableForClient(streakPlayer, 4, 0);
  }

  thread cleanupRocketTargetIcon(rocketAttachment, markedPlayer, streakPlayer);

  rocketAttachment waittill("lockedTarget");

  markedPlayer HudOutlineEnableForClient(streakPlayer, 0, 0);

  waittillRocketsExploded(rocketAttachment);

  if(isDefined(level.isHorde) && level.isHorde) {
    if(level.currentAliveEnemyCount < 3) {
      if((level.objDefend && distancesquared(streakPlayer.origin, level.currentDefendLoc.origin) > 640000)) {
        markedPlayer HudOutlineEnableForClient(streakPlayer, level.enemyOutlineColor, false);
      }
      streakPlayer.markedForMech = array_remove(streakPlayer.markedForMech, markedPlayer);
    } else {
      markedPlayer HudOutlineDisableForClient(streakPlayer);
      streakPlayer.markedForMech = array_remove(streakPlayer.markedForMech, markedPlayer);
    }
  } else {
    markedPlayer HudOutlineDisableForClient(streakPlayer);
  }
}

cleanupRocketTargetIcon(rocketAttachment, markedPlayer, streakPlayer) {
  markedPlayer endon("disconnect");

  waittillUnmarkPlayerAsRocketTarget(rocketAttachment);

  if(isDefined(level.isHorde) && level.isHorde && isDefined(streakPlayer)) {
    if(level.currentAliveEnemyCount < 3) {
      if((level.objDefend && distancesquared(streakPlayer.origin, level.currentDefendLoc.origin) > 640000)) {
        markedPlayer HudOutlineEnableForClient(streakPlayer, level.enemyOutlineColor, false);
      }
      streakPlayer.markedForMech = array_remove(streakPlayer.markedForMech, markedPlayer);
    } else {
      markedPlayer HudOutlineDisableForClient(streakPlayer);
      streakPlayer.markedForMech = array_remove(streakPlayer.markedForMech, markedPlayer);
    }
  } else if(isDefined(streakPlayer)) {
    markedPlayer HudOutlineDisableForClient(streakPlayer);
  }
}

waittillUnmarkPlayerAsRocketTarget(rocketAttachment) {
  rocketAttachment.enemyTarget endon("death");

  rocketAttachment waittill_any("death", "mark", "unmark");
}

waittillRocketsExploded(rocketAttachment) {
  wait 0.1;

  while(isDefined(rocketAttachment) && rocketAttachment.rockets.size > 0) {
    waitframe();
  }
}

waittillAttachmentDone(player, attachment1, attachment2) {
  player endon("disconnect");
  player endon("death");
  if(isDefined(level.isHorde) && level.isHorde) {
    player endon("becameSpectator");
  }

  if(isDefined(attachment1)) {
    attachment1 endon("death");
  }

  if(isDefined(attachment2)) {
    attachment2 endon("death");
  }

  player waittill("forever");
}

delayplayFX(ent, fx) {
  ent endon("death");
  waitframe();
  waitframe();
  playFXOnTag(fx, ent, "tag_origin");
}

stopFXOnAttachment(attachment, fx, doSparksFx) {
  if(isDefined(attachment.effect)) {
    stopFXOnTag(fx, attachment.effect, "tag_origin");
    if(isDefined(doSparksFx) && doSparksFx) {
      playFX(getfx("juggernaut_sparks"), attachment.effect.origin);
    }
    attachment.effect Delete();
  }
}

attachmentDeath(data, attachment, player, attachment2) {
  player endon("death");
  player endon("disconnect");
  if(isDefined(level.isHorde) && level.isHorde) {
    player endon("becameSpectator");
  }

  if(isDefined(attachment2)) {
    attachment2 endon("death");
  }

  attachment waittill("death", attacker, meansOfDeath, weapon);

  if(isDefined(attacker) && IsPlayer(attacker)) {
    splash = level.juggSettings[data.juggType].splashAttachmentName;
    if(IsSubStr(attachment.attachmentType, "weakSpot")) {
      splash = level.juggSettings[data.juggType].splashWeakenedName;
    }
    teamPlayerCardSplash(splash, attacker);
  }
}

attachmentExplode(attachment1, player, type, attachment2) {
  if(isDefined(player)) {
    if(IsAlive(player)) {
      player thread playerPlayAttachmentDialog(attachment1.attachmentType);
    }
    if(isDefined(attachment1)) {
      playFX(getfx("juggernaut_sparks"), attachment1.origin);
    }
    if(isDefined(attachment2)) {
      playFX(getfx("juggernaut_sparks"), attachment2.origin);
    }
    player playSound("sentry_explode");
  }
}

HideFromPlayer(playerToHideFrom) {
  self Hide();
  foreach(player in level.players) {
    if(player != playerToHideFrom) {
      self ShowToPlayer(player);
    }
  }
}

HideFromPlayers(playersToHideFrom) {
  self Hide();
  foreach(player in level.players) {
    if(!array_contains(playersToHideFrom, player)) {
      self ShowToPlayer(player);
    }
  }
}

spawnAttachment(type, modelName, startOrigin, health, player, eventString) {
  attachment = undefined;
  if(IsSubStr(type, "sentry")) {
    attachment = SpawnTurret("misc_turret", startOrigin, type);
  } else {
    attachment = spawn("script_model", startOrigin);
  }
  attachment setModel(modelName);
  attachment.attachmentType = type;
  if(isDefined(health)) {
    attachment.health = health;
    attachment.maxhealth = attachment.health;
    attachment.damagecallback = ::handleAttachmentDamage;
    if(isDefined(eventString)) {
      attachment thread handleAttachmentDeath(type, player, eventString);
    }
    attachment SetDamageCallbackOn(true);
  }
  attachment HideFromPlayer(player);

  attachment.owner = player;
  if(level.teamBased) {
    attachment.team = player.team;
  }

  if(!isDefined(player.juggernautAttachments)) {
    player.juggernautAttachments = [];
  } else {
    player.juggernautAttachments = array_removeUndefined(player.juggernautAttachments);
  }
  player.juggernautAttachments[player.juggernautAttachments.size] = attachment;

  return attachment;
}

spawnAttachmentEffect(startOrigin, player, isWeakSpot) {
  if(!isDefined(isWeakSpot)) {
    isWeakSpot = false;
  }

  effect = spawn("script_model", startOrigin);
  effect setModel("tag_origin");
  effect HideFromPlayer(player);
  thread delayplayFX(effect, getfx("green_light_mp"));
  return effect;
}

handleAttachmentDeath(type, player, eventString) {
  if(type == "weakSpotHead") {
    return;
  }

  level endon("game_ended");

  self waittill("death", attacker, meansOfDeath, weapon);

  if(!isDefined(attacker) || !IsPlayer(attacker) || (isDefined(player) && attacker == player)) {
    return;
  }

  level thread maps\mp\gametypes\_rank::awardGameEvent("heavy_exo_attachment", attacker, undefined, undefined, undefined, eventString);
}

handleAttachmentDamage(inflictor, attacker, damage, iDFlags, meansOfDeath, weapon, point, direction_vec, hitLoc, timeOffset, modelIndex, partName) {
  if(!isDefined(self.lastTimeDamaged)) {
    self.lastTimeDamaged = 0;
  }

  finalDamage = damage;

  if(isDefined(attacker) && !maps\mp\gametypes\_weapons::friendlyFireCheck(self.owner, attacker) || attacker == self.owner || self.lastTimeDamaged == GetTime()) {
    finalDamage = 0;
  } else {
    if(isDefined(weapon) && weapon == "boost_slam_mp" && damage > 10) {
      finalDamage = 10;
    }

    if(isMeleeMOD(meansOfDeath)) {
      finalDamage += self.maxHealth;
    }

    if(isDefined(iDFlags) && (iDFlags &level.iDFLAGS_PENETRATION)) {
      self.wasDamagedFromBulletPenetration = true;
    }

    self.wasDamaged = true;

    self.damageFade = 0.0;

    if(IsPlayer(attacker)) {
      if(attacker _hasPerk("specialty_armorpiercing")) {
        finalDamage = finalDamage * level.armorPiercingMod;
      }

      attacker maps\mp\gametypes\_damagefeedback::updateDamageFeedback("juggernautAttachment");
      attacker notify("hitHeavyExoAttachment");
      self.lastAttacker = attacker;
    }

    if(isDefined(weapon)) {
      shortWeapon = maps\mp\_utility::strip_suffix(weapon, "_lefthand");

      switch (shortWeapon) {
        case "ac130_105mm_mp":
        case "ac130_40mm_mp":
        case "stinger_mp":
        case "remotemissile_projectile_mp":
          self.largeProjectileDamage = true;
          finalDamage = self.maxHealth + 1;
          break;

        case "artillery_mp":
        case "stealth_bomb_mp":
          self.largeProjectileDamage = false;
          finalDamage += (damage * 4);
          break;

        case "bomb_site_mp":
        case "emp_grenade_mp":
        case "emp_grenade_var_mp":
        case "emp_grenade_killstreak_mp":
          self.largeProjectileDamage = false;
          finalDamage = self.maxHealth + 1;
          break;
      }

      maps\mp\killstreaks\_killstreaks::killstreakHit(attacker, weapon, self);
    }
  }

  self.lastTimeDamaged = GetTime();
  self FinishEntityDamage(inflictor, attacker, finalDamage, iDFlags, meansOfDeath, weapon, point, direction_vec, hitLoc, timeOffset, modelIndex, partName);
}

random_vector(num) {
  return (RandomFloat(num) - num * 0.5, RandomFloat(num) - num * 0.5, RandomFloat(num) - num * 0.5);
}

handleCoopJoining(data, player) {
  while(true) {
    id = maps\mp\killstreaks\_coop_util::promptForStreakSupport(player.team, &"MP_JOIN_HEAVY_EXO", "heavy_exosuit_coop_offensive", "assist_mp_goliath", "copilot_mp_goliath", player);

    level thread watchForJoin(id, player, data);

    result = waittillPromptComplete(player, "buddyJoinedStreak");

    maps\mp\killstreaks\_coop_util::stopPromptForStreakSupport(id);

    if(!isDefined(result)) {
      return;
    }

    result = waittillPromptComplete(player, "buddyLeftCoopTurret");

    if(!isDefined(result)) {
      return;
    }
  }
}

waittillPromptComplete(player, text, text2, text3) {
  player endon("death");
  player endon("disconnect");
  player endon("turretDead");
  if(isDefined(level.isHorde) && level.isHorde) {
    player endon("becameSpectator");
  }

  return player waittill_any_return_no_endon_death(text, text2, text3);
}

waittillTurretStunComplete(data, player) {
  player endon("death");
  player endon("disconnect");
  player endon("turretDead");
  if(isDefined(level.isHorde) && level.isHorde) {
    player endon("becameSpectator");
  }

  while(true) {
    waitframe();

    if(data.coopTurret.stunned || data.coopTurret.directHacked) {
      continue;
    }

    return true;
  }
}

watchForJoin(id, player, data) {
  player endon("disconnect");
  player endon("death");
  if(isDefined(level.isHorde) && level.isHorde) {
    player endon("becameSpectator");
  }

  buddy = maps\mp\killstreaks\_coop_util::waittillBuddyJoinedStreak(id);

  player notify("buddyJoinedStreak");
  buddy thread playerRemoteCoopTurret(data);
}

playerRemoteCoopTurret(data) {
  self endon("disconnect");
  data.coopTurret endon("death");
  data.streakPlayer endon("death");
  data.streakPlayer endon("disconnect");
  if(isDefined(level.isHorde) && level.isHorde) {
    self endon("becameSpectator");
    data.streakPlayer endon("becameSpectator");
  }

  data.coopTurret SetSentryOwner(undefined);
  data.coopTurret SetSentryOwner(self);
  data.coopTurret.owner = self;
  data.coopTurret.effect HideFromPlayers([self, data.streakPlayer]);
  self.using_remote_turret = true;
  data.coopTurret maps\mp\killstreaks\_remoteturret::startUsingRemoteTurret(CONST_JUGG_EXO_TURRET_HORZ_ARC, CONST_JUGG_EXO_TURRET_HORZ_ARC, CONST_JUGG_EXO_TURRET_TOP_ARC, CONST_JUGG_EXO_TURRET_BOTTOM_ARC, true);
  self thread removeCoopTurretBuddyOnDisconnect(data);

  data.coopTurret maps\mp\killstreaks\_remoteturret::waittillRemoteTurretLeaveReturn();

  removeCoopTurretBuddy(data);
}

removeCoopTurretBuddyOnDisconnect(data) {
  data.coopTurret endon("removeCoopTurretBuddy");

  self waittill("disconnect");

  thread removeCoopTurretBuddy(data);
}

removeCoopTurretBuddy(data) {
  Assert(isDefined(data.coopTurret));

  if(!isDefined(data.coopTurret.remoteControlled)) {
    return;
  }

  data.coopTurret notify("removeCoopTurretBuddy");

  data.coopTurret.remoteControlled = undefined;

  buddy = data.coopTurret.owner;
  if(isDefined(buddy)) {
    buddy.using_remote_turret = undefined;
    data.coopTurret maps\mp\killstreaks\_remoteTurret::stopUsingRemoteTurret(false);
  } else if(IsAlive(data.coopTurret)) {}

  buddy EnableWeaponSwitch();

  if(isDefined(data.streakPlayer) && isReallyAlive(data.streakPlayer)) {
    if(isDefined(data.coopTurret.effect)) {
      data.coopTurret.effect Hide();
    }
    data.coopTurret SetSentryOwner(undefined);
    data.coopTurret SetSentryOwner(data.streakPlayer);
    data.coopTurret.owner = data.streakPlayer;
    data.streakPlayer notify("buddyLeftCoopTurret");
  }
}

playerShowJuggernautHud(data) {
  data.hud = [];

  self thread playerWatchEMP(data);

  createJuggernautOverlay(data);
}

createJuggernautOverlay(data) {
  self SetClientOmnvar("ui_exo_suit_enabled", true);
  self thread playermech_state_manager();
}

playerWatchEMP(data) {
  self endon("death");
  self endon("disconnect");
  if(isDefined(level.isHorde) && level.isHorde) {
    self endon("becameSpectator");
  }

  while(true) {
    self waittill_any("emp_grenaded", "applyEMPkillstreak", "directHackStarted");

    foreach(element in data.hud) {
      element.alpha = 0;
    }

    while(true) {
      self waittill_any("empGrenadeTimedOut", "removeEMPkillstreak", "directHackTimedOut");
      waitframe();

      if(playerShouldShowHUD()) {
        break;
      }
    }

    foreach(element in data.hud) {
      if(element.type != "rocketReload") {
        element FadeOverTime(0.5);
        element.alpha = 1;
      }
    }
  }
}

playerShouldShowHUD() {
  return ((!isDefined(self.empGrenaded) || !self.empGrenaded) || (!isDefined(self.empOn) || !self.empOn));
}

playerPlayAttachmentDialog(attachmentType) {
  dialogRef = undefined;
  switch (attachmentType) {
    case "juggernaut_sentry_mp_mp":
      dialogRef = "sntryoff_mp_exoai";
      break;
    case "speedAttachment":
      dialogRef = "mancoff_mp_exoai";
      break;
    case "punchAttachment":
      dialogRef = "longoff_mp_exoai";
      break;
    case "radar":
      dialogRef = "rcnoff_mp_exoai";
      break;
    case "rocketAttachment":
      dialogRef = "rcktoff_mp_exoai";
      break;
    case "trophy":
      dialogRef = "trphyoff_mp_exoai";
      break;
    default:
      dialogRef = "weakdmg_mp_exoai";
      break;
  }

  self leaderDialogOnPlayer(dialogRef);
}

playerLaunchDropPod(modules) {
  outsideNode = self playerGetOutsideNode();
  if(!isDefined(outsideNode)) {
    self thread playerPlayInvalidPositionEffect(getfx("ocp_ground_marker_bad"));
    self SetClientOmnvar("ui_invalid_goliath", 1);
    return false;
  }

  self thread fireDropPod(outsideNode, modules);

  return true;
}

dropPodMoveNearbyAllies(player) {
  if(!isDefined(self) || !isDefined(player)) {
    return;
  }

  self.unresolved_collision_nodes = GetNodesInRadius(self.origin, 300, 80, 200);

  foreach(character in level.characters) {
    if(!IsAlive(character)) {
      continue;
    }

    if(IsAlliedSentient(character, player)) {
      if(DistanceSquared(self.origin, character.origin) < CONST_JUGG_EXO_USABILITY_RADIUS_SQ) {
        self maps\mp\_movers::unresolved_collision_nearest_node(character, true);
      }
    }
  }
}

fireDropPod(node, modules) {
  startPos = self playerGetOrbitalStartPos(node);
  targetPos = node.origin;

  podrocket = MagicBullet("orbital_carepackage_droppod_mp", startPos, targetPos, self);
  podrocket.team = self.team;

  podrocket.killCamEnt = spawn("script_model", (0, 0, 0));
  podrocket.killCamEnt LinkToSynchronizedParent(podrocket, "tag_origin", (0, 0, 200), (0, 10, 10));
  podrocket.killCamEnt.targetname = "killCamEnt_goliath_droppod";
  podrocket.killCamEnt SetScriptMoverKillCam("missile");
  podrocket thread maps\mp\_load::deleteDestructibleKillCamEnt();

  curObjID = maps\mp\gametypes\_gameobjects::getNextObjID();
  Objective_Add(curObjID, "invisible", (0, 0, 0));
  Objective_Position(curObjID, targetPos);
  Objective_State(curObjID, "active");
  shaderName = "compass_waypoint_farp";
  Objective_Icon(curObjID, shaderName);

  marker = spawn("script_model", targetPos + (0, 0, 5));
  marker.angles = (-90, 0, 0);
  marker setModel("tag_origin");
  marker Hide();
  marker ShowToPlayer(self);
  playFXOnTag(getfx("jugg_droppod_marker"), marker, "tag_origin");

  maps\mp\killstreaks\_orbital_util::addDropMarker(marker);

  hordeClassGoliath = false;
  if(isDefined(level.isHorde) && level.isHorde) {
    if(self.killstreakIndexWeapon == 1) {
      self notify("used_horde_goliath");
      hordeClassGoliath = true;
      self.hordeClassGoliathPodInField = true;
    }
    self.hordeGoliathPodInField = true;
  }

  podrocket waittill("death");

  targetPos = GetGroundPosition(podrocket.origin + (0, 0, 8), 20);

  thread destroy_nearby_turrets(targetPos);

  marker Hide();

  Earthquake(0.4, 1, targetPos, 800);
  PlayRumbleOnPosition("artillery_rumble", targetPos);

  stopFXOnTag(getfx("jugg_droppod_marker"), marker, "tag_origin");

  useEnt = spawn("script_model", targetPos);
  useEnt.angles = (0, 0, 0);
  useEnt createCollision(targetPos);
  useEnt.targetname = "care_package";
  useEnt.droppingToGround = false;
  useEnt.curObjID = curObjID;

  goliathPodModel = spawn("script_model", targetPos);
  goliathPodModel.angles = (90, 0, 0);
  goliathPodModel.targetname = "goliath_pod_model";
  goliathPodModel setModel("vehicle_drop_pod");
  goliathPodModel thread handle_goliath_drop_pod_removal(useEnt);

  if(isDefined(self)) {
    useEnt.owner = self;
  }
  useEnt.crateType = "juggernaut";
  useEnt.dropType = "juggernaut";
  useEnt thread control_goliath_usability();
  useEnt SetHintString(&"KILLSTREAKS_HEAVY_EXO_PICKUP");
  useEnt thread maps\mp\killstreaks\_airdrop::crateOtherCaptureThink();
  useEnt thread maps\mp\killstreaks\_airdrop::crateOwnerCaptureThink();
  useEnt thread useGoliathUpdater();

  data = spawnStruct();

  data.useEnt = useEnt;
  data.playDeathFx = true;
  data.deathOverrideCallback = ::movingPlatformDeathFunc;
  data.touchingPlatformValid = ::movingPlatformTouchValid;

  useEnt thread maps\mp\_movers::handle_moving_platforms(data);

  useEnt thread handle_goliath_drop_pod_timeout(hordeClassGoliath);

  useEnt dropPodMoveNearbyAllies(self);

  if(isDefined(level.isHorde) && level.isHorde) {
    if(level.zombiesStarted || level.teamEMPed["allies"]) {
      useEnt deleteGoliathPod();
    } else {
      useent thread delete_goliath_drop_pod_for_event();
    }
  }

  activator = useEnt playerWaittillGoliathActivated();

  if(isDefined(level.isHorde) && level.isHorde) {
    if(isDefined(activator) && activator != self) {
      if(hordeClassGoliath) {
        activator.hordeClassGoliathOwner = self;
        self.hordeClassGoliathController = activator;
      } else {
        activator.hordeGoliathOwner = self;
        self.hordeGoliathController = activator;
      }
      activator[[level.lastStandSaveLoadoutInfo]](true, true, true);
    } else {
      self[[level.lastStandSaveLoadoutInfo]](true, true, true);
    }
    self.hordeClassGoliathPodInField = undefined;
    self.hordeGoliathPodInField = undefined;
  }

  if(isDefined(activator) && IsAlive(activator)) {
    activator.enteringGoliath = true;
    activator TakeAllWeapons();
    activator GiveWeapon("iw5_combatknifegoliath_mp", 0, false, 0, true);
    activator SwitchToWeapon("iw5_combatknifegoliath_mp");

    activator Unlink();
    activator freezeControlsWrapper(true);

    goliath_to_player_vector = targetPos - activator.origin;
    goliath_to_player_angles = VectorToAngles(goliath_to_player_vector);
    goliath_angles = (0, goliath_to_player_angles[1], 0);
    drop_pod_vfx_forward_vector = RotateVector(goliath_to_player_vector, (45, 0, 0));

    emptyMech = spawn("script_model", targetPos);
    emptyMech.angles = goliath_angles;
    emptyMech setModel("npc_exo_armor_ingress");
    emptyMech ScriptModelPlayAnimDeltaMotion("mp_goliath_spawn");

    activator maps\mp\_snd_common_mp::snd_message("goliath_pod_burst");

    if(isDefined(useEnt)) {
      useEnt deleteGoliathPod(false);
    }

    playFX(level._effect["jugg_droppod_open"], targetPos, drop_pod_vfx_forward_vector);

    wait(0.1);

    activator is_entering_goliath(emptyMech, targetPos);

    if(isDefined(activator) && IsAlive(activator)) {
      activator SetOrigin(targetPos, true);
      activator SetPlayerAngles(emptyMech.angles);
      activator EnableWeapons();
      activator giveJuggernaut("juggernaut_exosuit", modules);

      emptyMech Delete();

      activator PlayGoliathToIdleAnim();

      wait(1);
      activator.enteringGoliath = undefined;
      activator freezeControlsWrapper(false);
      if(isDefined(level.isHorde) && level.isHorde) {
        activator HudOutlineEnable(5, true);
      }
    } else {
      emptyMech Delete();
    }
  }

  marker Delete();
}

destroy_nearby_turrets(org) {
  dist_sq = 64 * 64;

  foreach(player in level.players) {
    if(isDefined(player.turret) && DistanceSquared(player.turret.origin, org) <= dist_sq) {
      player.turret notify("death");
    }
  }
}

is_goliath_drop_pod(crate) {
  return isDefined(crate.crateType) && (crate.crateType == "juggernaut") && isDefined(crate.dropType) && crate.dropType == "juggernaut";
}

movingPlatformDeathFunc(data) {
  if(isDefined(data.emptyMech)) {
    data.emptyMech Delete();
  }

  if(isDefined(data.useEnt)) {
    data.useEnt Delete();
  }
}

movingPlatformTouchValid(platform) {
  return (self goliathAndCarepackageValid(platform) && self goliathAndGoliathValid(platform) && goliathAndPlatformValid(platform));
}

goliathAndCarepackageValid(platform) {
  return (!isDefined(self.crateType) || !isDefined(platform.targetname) || self.crateType != "juggernaut" || platform.targetname != "care_package");
}

goliathAndGoliathValid(platform) {
  return (!isDefined(self.crateType) || !isDefined(platform.crateType) || self.crateType != "juggernaut" || platform.crateType != "juggernaut");
}

goliathAndPlatformValid(platform) {
  return (!isDefined(self.crateType) || !isDefined(platform.carepackageTouchValid) || self.crateType != "juggernaut" || !platform.carepackageTouchValid);
}

control_goliath_usability() {
  self endon("captured");
  self endon("death");
  level endon("game_ended");

  self MakeUsable();

  foreach(player in level.players) {
    self DisablePlayerUse(player);
  }

  while(true) {
    foreach(player in level.players) {
      enable_goliath_use = false;

      if(player IsOnGround() && !player IsOnLadder() && !player IsJumping() && !player IsMantling() && isReallyAlive(player) && player GetStance() == "stand") {
        if(DistanceSquared(self.origin, player.origin) < CONST_JUGG_EXO_USABILITY_RADIUS_SQ) {
          if(player WorldPointInReticle_Rect(self.origin + (0, 0, 50), 65, 400, 600)) {
            enable_goliath_use = true;
          }
        }
      }

      if(enable_goliath_use == true) {
        self EnablePlayerUse(player);
      } else {
        self DisablePlayerUse(player);
      }
    }

    wait(0.2);
  }
}

is_entering_goliath(goliathModel, targetPos) {
  goliathForward = anglesToForward(goliathModel.angles);
  targetPos = targetPos - (goliathForward * 37);
  self SetOrigin(targetPos, false);
  self SetPlayerAngles(goliathModel.angles);

  wait(0.05);

  goliathModel ScriptModelPlayAnimDeltaMotion("mp_goliath_enter");
  self PlayGoliathEntryAnim();

  wait(2.3);
}

createCollision(targetPos) {
  collision = GetEnt("goliath_collision", "targetname");
  if(isDefined(collision)) {
    self CloneBrushmodelToScriptmodel(collision);
  }
}

playerWaittillGoliathActivated() {
  self endon("death");

  self waittill("captured", player);

  player SetStance("stand");

  player SetDemiGod(true);

  if(isDefined(self.owner) && player != self.owner) {
    if(!level.teamBased || player.team != self.owner.team) {
      player thread maps\mp\_events::hijackerEvent(self.owner);
    } else {
      if(!isDefined(level.isHorde)) {
        self.owner thread maps\mp\_events::sharedEvent();
      }
    }
  }

  return player;
}

useGoliathUpdater() {
  self endon("death");
  level endon("game_ended");

  foreach(player in level.players) {
    if(player isJuggernaut()) {
      self DisablePlayerUse(player);
      self thread usePostJuggernautUpdater(player);
    }
  }

  while(true) {
    level waittill("juggernaut_equipped", player);

    self disablePlayerUse(player);
    self thread usePostJuggernautUpdater(player);
  }
}

usePostJuggernautUpdater(player) {
  self endon("death");
  level endon("game_ended");
  player endon("disconnect");
  if(isDefined(level.isHorde) && level.isHorde) {
    player endon("becameSpectator");
  }

  player waittill("death");
  self enablePlayerUse(player);
}

adjustLink(item, tagName, player, startOrigin, startAngles) {
  item endon("death");

  if(!isDefined(startOrigin)) {
    startOrigin = (0, 0, 0);
  }
  if(!isDefined(startAngles)) {
    startAngles = (0, 0, 0);
  }
  thread drawSpine(player, item);
  SetDvar("scr_adjust_angles", "" + startAngles);
  SetDvar("scr_adjust_origin", "" + startOrigin);
  currentAngles = (0, 0, 0);
  currentOrigin = (0, 0, 0);
  while(true) {
    waitframe();

    nextAngles = GetDvarVector("scr_adjust_angles");
    nextOrigin = GetDvarVector("scr_adjust_origin");

    if(nextAngles == currentAngles && nextOrigin == currentOrigin) {
      continue;
    }

    currentAngles = nextAngles;
    currentOrigin = nextOrigin;

    item Unlink();
    item LinkTo(player, tagName, currentOrigin, currentAngles);
  }
}

drawSpine(player, item) {
  player endon("disconnect");
  player endon("death");
  item endon("death");
  if(isDefined(level.isHorde) && level.isHorde) {
    player endon("becameSpectator");
  }

  while(true) {
    origin = item.origin;
    angles = item.angles;
    debug_axis(origin, angles);
    waitframe();
  }
}

debug_axis(origin, angles) {
  size = 20;

  forward = anglesToForward(angles) * size;
  right = AnglesToRight(angles) * size;
  up = AnglesToUp(angles) * size;
  Line(origin, origin + forward, (1, 0, 0), 1.0, 0, 1);
  Line(origin, origin + up, (0, 1, 0), 1.0, 0, 1);
  Line(origin, origin + right, (0, 0, 1), 1.0, 0, 1);
}

MECH_CHAINGUN_STATE_NONE = 0;
MECH_CHAINGUN_STATE_READY = 1;
MECH_CHAINGUN_STATE_FIRING = 2;
MECH_CHAINGUN_STATE_OVERHEAT = 3;
MECH_CHAINGUN_STATE_OFFLINE = 4;

MECH_SWARM_STATE_NONE = 0;
MECH_SWARM_STATE_READY = 1;
MECH_SWARM_STATE_TARGETING = 2;
MECH_SWARM_STATE_RELOADING = 3;
MECH_SWARM_STATE_OFFLINE = 4;

MECH_ROCKET_STATE_NONE = 0;
MECH_ROCKET_STATE_READY = 1;
MECH_ROCKET_STATE_RELOADING = 2;
MECH_ROCKET_STATE_OFFLINE = 3;

playermech_ui_state_reset() {
  if(!isDefined(self.mechUIState)) {
    self.mechUIState = spawnStruct();
    self.mechUIState.chaingun = spawnStruct();
    self.mechUIState.swarm = spawnStruct();
    self.mechUIState.rocket = spawnStruct();
    self.mechUIState.threat_list = spawnStruct();

    self.mechUIState.state = "none";
    self.mechUIState.chaingun.state = "none";
    self.mechUIState.chaingun.last_state = "none";
    self.mechUIState.swarm.state = "none";
    self.mechUIState.swarm.last_state = "none";
    self.mechUIState.rocket.state = "none";
    self.mechUIState.rocket.last_state = "none";
  }

  self set_mech_state();

  self.mechUIState.threat_list.threats = [];
  self.mechUIState.threat_list.compass_offsets = [];

  self.mechUIState.chaingun.heatlevel = 0;
  self.mechUIState.chaingun.overheated = false;

  self.mechUIState.swarm.threat_scan = false;
  self.mechUIState.swarm.recharge = 100;

  self.mechUIState.rocket.fire = false;
  self.mechUIState.rocket.recharge = 100;
}

playermech_state_manager() {
  self endon("disconnect");
  self endon("exit_mech");
  if(isDefined(level.isHorde) && level.isHorde) {
    self endon("becameSpectator");
  }

  playermech_ui_state_reset();

  self set_mech_state();
  self set_mech_chaingun_state();
  self set_mech_rocket_state();
  self set_mech_swarm_state();

  waitframe();

  while(1) {
    state_chaingun_pump();
    state_rocket_pump();
    state_swarm_pump();

    self playermech_ui_update_lui(self.mechUIState);

    wait 0.05;
  }
}

set_mech_state(state) {
  Assert(IsPlayer(self));

  if(!isDefined(state)) {
    state = "none";
  }

  if(!isDefined(self.mechUIState)) {
    return;
  }

  if(self.mechUIState.state == state) {
    return;
  }

  self.mechUIState.state = state;
}

get_mech_state() {
  Assert(IsPlayer(self));
  if(!isDefined(self.mechUIState)) {
    return;
  }
  return self.mechUIState.state;
}

get_is_in_mech() {
  modelName = self getattachmodelname(0);

  if(isDefined(modelName) && modelName == "head_hero_cormack_sentinel_halo") {
    return true;
  }

  return false;
}

get_front_sorted_threat_list(threats, forward) {
  sorted = [];

  foreach(threat in threats) {
    if(VectorDot(threat.origin - self.origin, forward) < 0) {
      continue;
    }

    sorted[sorted.size] = threat;
  }
  sorted = SortByDistance(sorted, self.origin);
  return sorted;
}

playermech_ui_weapon_feedback(buttonPressed, omnvar) {
  self endon("disconnect");
  self endon("exit_mech");
  if(isDefined(level.isHorde) && level.isHorde) {
    self endon("becameSpectator");
  }

  self SetClientOmnvar(omnvar, false);
  while(1) {
    while(!self call[[buttonPressed]]()) {
      wait(0.05);
    }
    self SetClientOmnvar(omnvar, true);
    while(self call[[buttonPressed]]()) {
      wait(0.05);
    }
    self SetClientOmnvar(omnvar, false);
    wait(0.05);
  }
}

playermech_ui_update_lui(uiState) {
  isThreat = self playerIsRocketSwarmTargetLocked();
  numSwarmTargets = 0;
  if(isThreat) {
    numSwarmTargets = 1;
  }

  if(self.heavyExoData.hasRockets) {
    self SetClientOmnvar("ui_playermech_swarmrecharge", uiState.swarm.recharge);
  }
  if(self.heavyExoData.hasLongPunch) {
    self SetClientOmnvar("ui_playermech_rocketrecharge", uiState.rocket.recharge);
  }
}

playermech_invalid_gun_callback() {
  if(self.mechUIState.chaingun.overheated) {
    return true;
  }

  return false;
}

playermech_invalid_rocket_callback() {
  if(self.mechUIState.rocket.recharge < 100) {
    return true;
  }
  return false;
}

playermech_invalid_swarm_callback() {
  if(self.mechUIState.swarm.recharge < 100) {
    return true;
  }
  return false;
}

playermech_invalid_weapon_instance(buttonFunc, callback) {
  self endon("disconnect");
  self endon("exit_mech");
  if(isDefined(level.isHorde) && level.isHorde) {
    self endon("becameSpectator");
  }

  buttonDown = false;
  while(1) {
    wait 0.05;

    if(self call[[buttonFunc]]()) {
      if(!buttonDown) {
        if([
            [callback]
          ]()) {
          buttonDown = true;
          self PlayLocalSound("wpn_mech_offline");
          wait 1.5;
        }
      }
    } else {
      buttonDown = false;
    }
  }
}

playermech_invalid_weapon_watcher() {
  self thread playermech_invalid_weapon_instance(::AttackButtonPressed, ::playermech_invalid_gun_callback);
  self thread playermech_invalid_weapon_instance(::FragButtonPressed, ::playermech_invalid_rocket_callback);
  self thread playermech_invalid_weapon_instance(::SecondaryOffhandButtonPressed, ::playermech_invalid_swarm_callback);
}

state_main_pump() {
  switch (self get_mech_state()) {
    case "base_noweap_bootup":
    case "base_swarmonly_nolegs":
    case "base_swarmonly_exit":
    case "base_noweap":
    case "base_swarmonly":
    case "base_transition":
    case "base":
    case "dmg1_transition":
    case "dmg1":
    case "dmg2_transition":
    case "dmg2":
      break;

    case "none": {
      playermech_ui_state_reset();
      break;
    }

    default: {
      assertmsg("Mech state invalid: " + self get_mech_state());
    }
  }
}

state_chaingun_pump() {
  current_state = self get_mech_chaingun_state();

  weapon = self GetCurrentWeapon();
  self.mechUIState.chaingun.heatlevel = self GetWeaponHeatLevel(weapon);
  self.mechUIState.chaingun.overheated = self IsWeaponOverheated(weapon);

  if(current_state == "ready") {
    if(self.mechUIState.chaingun.overheated) {
      set_mech_chaingun_state("overheat");
    } else if(self AttackButtonPressed()) {
      set_mech_chaingun_state("firing");
    }
  } else if(current_state == "firing") {
    if(self.mechUIState.chaingun.overheated) {
      set_mech_chaingun_state("overheat");
    } else if(!self AttackButtonPressed()) {
      set_mech_chaingun_state("ready");
    }
  } else if(current_state == "overheat" && !self.mechUIState.chaingun.overheated) {
    set_mech_chaingun_state("ready");
  }
}

state_rocket_pump() {
  current_state = self get_mech_rocket_state();

  if(current_state != "offline" && self playermech_invalid_rocket_callback()) {
    set_mech_rocket_state("reload");
  } else if(current_state == "reload" && !self playermech_invalid_rocket_callback()) {
    set_mech_rocket_state("ready");
  }
}

state_swarm_pump() {
  current_state = self get_mech_swarm_state();

  if(!self playerIsRocketSwarmTargetLocked() && !self playerIsRocketSwarmReloading()) {
    set_mech_swarm_state("target");
  } else if(current_state == "target" && self playermech_invalid_swarm_callback()) {
    set_mech_swarm_state("reload");
  } else if(current_state == "reload" && !self playermech_invalid_swarm_callback()) {
    set_mech_swarm_state("ready");
  }
}

set_mech_chaingun_state(state) {
  Assert(IsPlayer(self));

  if(!isDefined(state)) {
    state = "none";
  }

  if(!isDefined(self.mechUIState.chaingun.state)) {
    self.mechUIState.chaingun.state = "none";
  }

  if(self.mechUIState.chaingun.state == state) {
    return;
  }

  self.mechUIState.chaingun.state = state;
  self notify("chaingun_state_" + state);
}

get_mech_chaingun_state() {
  Assert(IsPlayer(self));
  if(!isDefined(self.mechUIState)) {
    return;
  }
  return self.mechUIState.chaingun.state;
}

same_mech_chaingun_last_state() {
  if(isDefined(self.mechUIState.chaingun.last_state) && self.mechUIState.chaingun.state == self.mechUIState.chaingun.last_state) {
    return true;
  }
  self.mechUIState.chaingun.last_state = self.mechUIState.chaingun.state;
  return false;
}

set_mech_rocket_state(state) {
  Assert(IsPlayer(self));

  if(!isDefined(state)) {
    state = "none";
  }

  if(!isDefined(self.mechUIState.rocket.state)) {
    self.mechUIState.rocket.state = "none";
  }

  if(self.mechUIState.rocket.state == state) {
    return;
  }

  self.mechUIState.rocket.state = state;
}

get_mech_rocket_state() {
  Assert(IsPlayer(self));
  if(!isDefined(self.mechUIState)) {
    return;
  }
  return self.mechUIState.rocket.state;
}

same_mech_rocket_last_state() {
  if(isDefined(self.mechUIState.rocket.last_state) && self.mechUIState.rocket.state == self.mechUIState.rocket.last_state) {
    return true;
  }
  self.mechUIState.rocket.last_state = self.mechUIState.rocket.state;
  return false;
}

set_mech_swarm_state(state) {
  Assert(IsPlayer(self));

  if(!isDefined(state)) {
    state = "none";
  }

  if(!isDefined(self.mechUIState.swarm.state)) {
    self.mechUIState.swarm.state = "none";
  }

  if(self.mechUIState.swarm.state == state) {
    return;
  }

  self.mechUIState.swarm.state = state;
}

get_mech_swarm_state() {
  Assert(IsPlayer(self));
  if(!isDefined(self.mechUIState)) {
    return;
  }
  return self.mechUIState.swarm.state;
}

same_mech_swarm_last_state() {
  if(isDefined(self.mechUIState.swarm.last_state) && self.mechUIState.swarm.state == self.mechUIState.swarm.last_state) {
    return true;
  }
  self.mechUIState.swarm.last_state = self.mechUIState.swarm.state;
  return false;
}

playermech_monitor_update_recharge(weapon, time) {
  weapon.recharge = 0;
  iteration = 100.0 / (time / 0.05);
  while(weapon.recharge < 100) {
    weapon.recharge += iteration;
    wait 0.05;
  }
  weapon.recharge = 100;

  while(isDefined(self.underwaterMotionType)) {
    wait(0.05);
  }
}

playermech_monitor_rocket_recharge() {
  self endon("disconnect");
  self endon("exit_mech");
  self notify("stop_rocket_recharge");
  self endon("stop_rocket_recharge");
  if(isDefined(level.isHorde) && level.isHorde) {
    self endon("becameSpectator");
  }

  while(1) {
    self waittill("mech_rocket_fire");
    self DisableOffhandWeapons();
    self playermech_monitor_update_recharge(self.mechuistate.rocket, CONST_JUGG_EXO_ROCKET_RELOAD_TIME);
    self EnableOffhandWeapons();
    wait 0.05;
  }
}

playermech_monitor_swarm_recharge() {
  self endon("disconnect");
  self endon("exit_mech");
  self notify("stop_swarm_recharge");
  self endon("stop_swarm_recharge");
  if(isDefined(level.isHorde) && level.isHorde) {
    self endon("becameSpectator");
  }

  while(1) {
    self waittill("mech_swarm_fire");
    self DisableOffhandSecondaryWeapons();
    self playermech_monitor_update_recharge(self.mechuistate.swarm, CONST_JUGG_EXO_ROCKET_SWARM_RELOAD_TIME);
    self EnableOffhandSecondaryWeapons();
    wait 0.05;
  }
}

play_goliath_death_fx() {
  level endon("game_ended");
  self endon("disconnect");
  if(isDefined(level.isHorde) && level.isHorde) {
    self endon("becameSpectator");
  }

  self waittill_any("death", "joined_team", "faux_spawn");

  if(IsAI(self)) {
    self maps\mp\_snd_common_mp::snd_message("goliath_self_destruct");
    playFX(getfx("goliath_self_destruct"), self.origin, AnglesToUp(self.angles));

    if(IsAgent(self) && isDefined(self.hideOnDeath) && self.hideOnDeath == true) {
      agent_corpse = self GetCorpseEntity();
      if(isDefined(agent_corpse)) {
        agent_corpse Hide();
      }
    }
  } else if(!isDefined(self.juggernautSuicide) && !isDefined(level.isHorde)) {
    playFXOnTag(getfx("goliath_death_fire"), self.body, "J_NECK");
    self maps\mp\_snd_common_mp::snd_message("goliath_death_explosion");
  }
  self.juggernautSuicide = undefined;
}

self_destruct_goliath() {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  self endon("joined_team");
  self endon("faux_spawn");
  if(isDefined(level.isHorde) && level.isHorde) {
    self endon("horde_cancel_goliath");
  }

  button_hold_time = 0;

  while(true) {
    if(self UseButtonPressed()) {
      button_hold_time += 0.05;
      if(button_hold_time > 1.0) {
        self maps\mp\_snd_common_mp::snd_message("goliath_self_destruct");
        playFX(getfx("goliath_self_destruct"), self.origin, AnglesToUp(self.angles));
        wait 0.05;
        self.hideOnDeath = true;
        self.juggernautSuicide = true;

        RadiusDamage(self.origin + (0, 0, 50), 400, 200, 20, self, "MOD_EXPLOSIVE", "killstreak_goliathsd_mp");

        if(isDefined(level.isHorde) && level.isHorde) {
          self thread[[level.hordeHandleJuggDeath]]();
        }
      }
    } else {
      button_hold_time = 0;
    }
    wait(0.05);
  }
}

playerMechTimeout() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("lost_juggernaut");
  if(isDefined(level.isHorde) && level.isHorde) {
    self endon("horde_cancel_goliath");
  }

  while(true) {
    wait 1;
    self.mechHealth -= int(self.maxhealth / 100);

    if(self.mechHealth < 0) {
      self maps\mp\_snd_common_mp::snd_message("goliath_self_destruct");
      playFX(getfx("goliath_self_destruct"), self.origin, AnglesToUp(self.angles));
      self thread[[level.hordeHandleJuggDeath]]();
    }

    self SetClientOmnvar("ui_exo_suit_health", self.mechHealth / self.maxhealth);
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

  for(;;) {
    self waittill("spawned_player");
    self.hideOnDeath = false;
  }
}

deleteGoliathPod(playDestroyVFX, playDestroySound) {
  if(!isDefined(playDestroyVFX)) {
    playDestroyVFX = true;
  }

  if(!isDefined(playDestroySound)) {
    playDestroySound = false;
  }

  if(isDefined(self.curObjID)) {
    _objective_delete(self.curObjID);
  }

  if(isDefined(self.dropType)) {
    if(playDestroyVFX) {
      playFX(getfx("ocp_death"), self.origin);
    }

    if(playDestroySound) {
      playSoundAtPos(self.origin, "orbital_pkg_self_destruct");
    }
  }

  self delete();
}

handle_goliath_drop_pod_timeout(hordeClassGoliath) {
  level endon("game_ended");
  self endon("death");

  wait(CONST_JUGG_EXO_TIMEOUT_SEC);

  if(isDefined(level.isHorde) && level.isHorde && hordeClassGoliath) {
    self.owner.hordeClassGoliathPodInField = undefined;
    self.owner.hordeGoliathPodInField = undefined;
    self.owner notify("startJuggCooldown");
  }

  self deleteGoliathPod();
}

delete_goliath_drop_pod_for_event() {
  level endon("game_ended");
  self endon("death");

  level waittill_any("zombies_start", "EMP_JamTeamallies");

  self deleteGoliathPod();
}

handle_goliath_drop_pod_removal(useEnt) {
  level endon("game_ended");
  self endon("death");

  useEnt waittill("death");

  self Delete();
}

playermech_watch_emp_grenade() {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  if(isDefined(level.isHorde) && level.isHorde) {
    self endon("becameSpectator");
  }

  while(true) {
    self waittill("emp_grenaded", attacker);
    if(isDefined(attacker) && IsPlayer(attacker)) {
      attacker thread ch_emp_goliath_think();
    }
  }
}

ch_emp_goliath_think() {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  if(isDefined(level.isHorde) && level.isHorde) {
    self endon("becameSpectator");
  }

  time_to_wait = 5.0;

  wait(time_to_wait);

  if(isReallyAlive(self)) {
    self maps\mp\gametypes\_missions::processChallenge("ch_precision_closecall");
  }
}