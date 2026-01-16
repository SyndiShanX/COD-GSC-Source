/******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\_turret_killstreak.gsc
******************************************/

#include maps\mp\_utility;
#include common_scripts\utility;
#include maps\mp\gametypes\_hud_util;

init() {
  precacheturret("auto_gun_turret_mp");
  precacheturret("tow_turret_mp");
  PrecacheModel("t5_weapon_minigun_turret");
  PrecacheModel("t5_weapon_minigun_turret_yellow");
  PrecacheModel("t5_weapon_minigun_turret_red");
  PrecacheModel("t5_weapon_sam_turret");
  PrecacheModel("t5_weapon_sam_turret_yellow");
  PrecacheModel("t5_weapon_sam_turret_red");
  thread maps\mp\_mgturret::init_turret_difficulty_settings();
  level.auto_turret_timeout = 90.0;
  flag_init("end_target_confirm");
  level.auto_turret_settings = [];
  level.auto_turret_settings["sentry"] = spawnStruct();
  level.auto_turret_settings["sentry"].hintString = & "KILLSTREAK_SENTRY_TURRET_PICKUP";
  level.auto_turret_settings["sentry"].hackerHintString = & "KILLSTREAK_TURRET_HACKING";
  level.auto_turret_settings["sentry"].hintIcon = "hud_ks_auto_turret";
  level.auto_turret_settings["sentry"].modelBase = "t5_weapon_minigun_turret";
  level.auto_turret_settings["sentry"].modelGoodPlacement = "t5_weapon_minigun_turret_yellow";
  level.auto_turret_settings["sentry"].modelBadPlacement = "t5_weapon_minigun_turret_red";
  level.auto_turret_settings["sentry"].stunFX = loadfx("weapon/grenade/fx_spark_disabled_weapon_lg");
  level.auto_turret_settings["sentry"].stunFXFrequencyMin = 0.1;
  level.auto_turret_settings["sentry"].stunFXFrequencyMax = 0.75;
  level.auto_turret_settings["sentry"].turretInitDelay = 1.0;
  level.auto_turret_settings["tow"] = spawnStruct();
  level.auto_turret_settings["tow"].hintString = & "KILLSTREAK_TOW_TURRET_PICKUP";
  level.auto_turret_settings["tow"].hackerHintString = & "KILLSTREAK_TURRET_HACKING";
  level.auto_turret_settings["tow"].hintIcon = "hud_ks_sam_turret";
  level.auto_turret_settings["tow"].modelBase = "t5_weapon_sam_turret";
  level.auto_turret_settings["tow"].modelGoodPlacement = "t5_weapon_sam_turret_yellow";
  level.auto_turret_settings["tow"].modelBadPlacement = "t5_weapon_sam_turret_red";
  level.auto_turret_settings["tow"].stunFX = loadfx("weapon/grenade/fx_spark_disabled_weapon_lg");
  level.auto_turret_settings["tow"].stunFXFrequencyMin = 0.1;
  level.auto_turret_settings["tow"].stunFXFrequencyMax = 0.75;
  level.auto_turret_settings["tow"].turretInitDelay = 1.0;
  level.auto_turret_settings["tow"].turretFireDelay = 5.0;
  level._turret_explode_fx = loadfx("explosions/fx_exp_equipment_lg");
  minefields = GetEntarray("minefield", "targetname");
  hurt_triggers = GetEntArray("trigger_hurt", "classname");
  level.fatal_triggers = array_combine(minefields, hurt_triggers);
  level.noTurretPlacementTriggers = getEntArray("no_turret_placement", "targetname");
  if(maps\mp\gametypes\_tweakables::getTweakableValue("killstreak", "allowauto_turret")) {
    maps\mp\gametypes\_hardpoints::registerKillstreak("autoturret_mp", "autoturret_mp", "killstreak_auto_turret", "auto_turret_used", ::useSentryTurretKillstreak);
    maps\mp\gametypes\_hardpoints::registerKillstreakAltWeapon("autoturret_mp", "auto_gun_turret_mp");
    maps\mp\gametypes\_hardpoints::registerKillstreakStrings("autoturret_mp", & "KILLSTREAK_EARNED_AUTO_TURRET", & "KILLSTREAK_AUTO_TURRET_NOT_AVAILABLE");
    maps\mp\gametypes\_hardpoints::registerKillstreakDialog("autoturret_mp", "mpl_killstreak_auto_turret", "kls_turret_used", "", "kls_turret_enemy", "", "kls_turret_drop");
    maps\mp\gametypes\_hardpoints::registerKillstreakDevDvar("autoturret_mp", "scr_giveautoturret");
    maps\mp\gametypes\_hardpoints::registerKillstreak("turret_drop_mp", "turret_drop_mp", "killstreak_auto_turret_drop", "auto_turret_used", ::useKillstreakTurretDrop, undefined, true);
    maps\mp\gametypes\_hardpoints::registerKillstreakStrings("turret_drop_mp", & "KILLSTREAK_EARNED_AUTO_TURRET", & "KILLSTREAK_AIRSPACE_FULL");
    maps\mp\gametypes\_hardpoints::registerKillstreakDialog("turret_drop_mp", "mpl_killstreak_turret", "kls_turret_used", "", "kls_turret_enemy", "", "kls_turret_ready");
    maps\mp\gametypes\_hardpoints::registerKillstreakDevDvar("turret_drop_mp", "scr_giveautoturretdrop");
    maps\mp\gametypes\_supplydrop::registerCrateType("turret_drop_mp", "killstreak", "autoturret_mp", 1, & "KILLSTREAK_AUTO_TURRET_CRATE", undefined, "MEDAL_SHARE_PACKAGE_AUTO_TURRET", maps\mp\gametypes\_supplydrop::giveCrateKillstreak);
    level.killStreakIcons["autoturret_mp"] = "hud_ks_auto_turret";
    maps\mp\gametypes\_hardpoints::registerKillstreak("auto_tow_mp", "auto_tow_mp", "killstreak_tow_turret", "tow_turret_used", ::useTowTurretKillstreak);
    maps\mp\gametypes\_hardpoints::registerKillstreakAltWeapon("auto_tow_mp", "tow_turret_mp");
    maps\mp\gametypes\_hardpoints::registerKillstreakStrings("auto_tow_mp", & "KILLSTREAK_EARNED_TOW_TURRET", & "KILLSTREAK_TOW_TURRET_NOT_AVAILABLE");
    maps\mp\gametypes\_hardpoints::registerKillstreakDialog("auto_tow_mp", "mpl_killstreak_auto_turret", "kls_tow_used", "", "kls_tow_enemy", "", "kls_tow_drop");
    maps\mp\gametypes\_hardpoints::registerKillstreakDevDvar("auto_tow_mp", "scr_giveautotowturret");
    maps\mp\gametypes\_hardpoints::registerKillstreak("tow_turret_drop_mp", "tow_turret_drop_mp", "killstreak_tow_turret_drop", "tow_turret_used", ::useKillstreakTurretDrop, undefined, true);
    maps\mp\gametypes\_hardpoints::registerKillstreakStrings("tow_turret_drop_mp", & "KILLSTREAK_EARNED_TOW_TURRET", & "KILLSTREAK_AIRSPACE_FULL");
    maps\mp\gametypes\_hardpoints::registerKillstreakDialog("tow_turret_drop_mp", "mpl_killstreak_auto_turret", "kls_tow_used", "", "kls_tow_enemy", "", "kls_tow_ready");
    maps\mp\gametypes\_hardpoints::registerKillstreakDevDvar("tow_turret_drop_mp", "scr_giveautotowturretdrop");
    maps\mp\gametypes\_supplydrop::registerCrateType("tow_turret_drop_mp", "killstreak", "auto_tow_mp", 1, & "KILLSTREAK_TOW_TURRET_CRATE", undefined, "MEDAL_SHARE_PACKAGE_TOW_TURRET", maps\mp\gametypes\_supplydrop::giveCrateKillstreak);
    level.killStreakIcons["auto_tow_mp"] = "hud_ks_sam_turret";
  }
  level.turrets_headicon_offset = [];
  level.turrets_headicon_offset["default"] = (0, 0, 70);
  level.turrets_headicon_offset["sentry"] = (0, 0, 70);
  level.turrets_headicon_offset["tow"] = (0, 0, 65);
  level.turrets_hacker_trigger_width = 72;
  level.turrets_hacker_trigger_height = 96;
}
useKillstreakTurretDrop(hardpointType) {
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
useSentryTurretKillstreak(hardpointType) {
  if(self maps\mp\_killstreakrules::isKillstreakAllowed(hardpointType, self.team) == false)
    return false;
  if(self maps\mp\_killstreakrules::killstreakStart(hardpointType, self.team) == false)
    return false;
  self thread useSentryTurret(hardpointType);
  return true;
}
useTowTurretKillstreak(hardpointType) {
  if(self maps\mp\_killstreakrules::isKillstreakAllowed(hardpointType, self.team) == false)
    return false;
  if(self maps\mp\_killstreakrules::killstreakStart(hardpointType, self.team) == false)
    return false;
  self thread useTowTurret(hardpointType);
  return true;
}
useSentryTurret(hardpointType) {
  if(!self maps\mp\gametypes\_hardpoints::getIfTopKillstreakHasBeenUsed()) {
    self maps\mp\gametypes\_persistence::statAdd("AUTO_TURRET_USED", 1, false);
    level.globalKillstreaksCalled++;
    self maps\mp\gametypes\_globallogic_score::incItemStatByReference("killstreak_auto_turret_drop", 1, "used");
  }
  turret = spawnTurret("auto_turret", self.origin, "auto_gun_turret_mp");
  turret.turretType = "sentry";
  turret SetTurretType(turret.turretType);
  turret SetModel(level.auto_turret_settings[turret.turretType].modelGoodPlacement);
  turret.angles = self.angles;
  turret.hardPointWeapon = hardpointType;
  turret.hasBeenPlanted = false;
  turret.waitForTargetToBeginLifespan = false;
  self.turret_active = false;
  self.curr_time = -1;
  turret.stunnedByTacticalGrenade = false;
  turret.stunTime = 0.0;
  turret SetTurretOwner(self);
  if(level.teamBased) {
    turret setturretteam(self.team);
    turret.team = self.team;
  } else {
    turret setturretteam("free");
    turret.team = "free";
  }
  setupTurretHealth(turret);
  self.carryingTurret = true;
  turret.carried = true;
  turret.curr_time = 0;
  turret.stunDuration = 5.0;
  turret thread watchTurretLifespan();
  self thread watchOwnerDisconnect(turret);
  turret thread destroyTurret();
  self thread startCarryTurret(turret);
}
useTowTurret(hardpointType) {
  if(!self maps\mp\gametypes\_hardpoints::getIfTopKillstreakHasBeenUsed()) {
    level.globalKillstreaksCalled++;
    self maps\mp\gametypes\_globallogic_score::incItemStatByReference("killstreak_tow_turret_drop", 1, "used");
  }
  turret = spawnTurret("auto_turret", self.origin, "tow_turret_mp");
  turret.turretType = "tow";
  turret SetTurretType(turret.turretType);
  turret SetModel(level.auto_turret_settings[turret.turretType].modelGoodPlacement);
  turret.angles = self.angles;
  turret.hardPointWeapon = hardpointType;
  turret.hasBeenPlanted = false;
  turret.waitForTargetToBeginLifespan = false;
  turret.fireTime = level.auto_turret_settings["tow"].turretFireDelay;
  self.turret_active = false;
  turret.stunnedByTacticalGrenade = false;
  turret.stunTime = 0.0;
  turret SetTurretOwner(self);
  if(level.teamBased) {
    turret setturretteam(self.team);
    turret.team = self.team;
  } else {
    turret setturretteam("free");
    turret.team = "free";
  }
  setupTurretHealth(turret);
  self.carryingTurret = true;
  turret.carried = true;
  turret.curr_time = 0;
  turret.stunDuration = 5.0;
  turret SetScanningPitch(-35.0);
  turret thread watchTurretLifespan();
  self thread watchOwnerDisconnect(turret);
  turret thread destroyTurret();
  self thread startCarryTurret(turret);
}
watchRoundAndGameEnd(turret) {
  self endon("disconnect");
  turret endon("turret_placed");
  turret endon("destroy_turret");
  turret endon("hacked");
  level waittill("game_ended");
  self stopCarryTurret(turret);
  turret notify("destroy_turret", false);
}
watchOwnerDeath(turret) {
  self endon("disconnect");
  turret endon("turret_placed");
  turret endon("destroy_turret");
  turret endon("hacked");
  self waittill("death");
  if(!turret.hasBeenPlanted) {
    if(self.team != turret.team) {
      self stopCarryTurret(turret);
      turret notify("destroy_turret", false);
    } else {
      maps\mp\gametypes\_hardpoints::giveKillstreak(turret.hardPointWeapon, undefined, undefined, true);
      turret setTurretCarried(false);
      self stopCarryTurret(turret);
      self _enableWeapon();
      turret notify("destroy_turret", false);
    }
  } else if(turret.canBePlaced && turret.carried) {
    if(level.teamBased && self.team != turret.team) {
      self stopCarryTurret(turret);
      turret notify("destroy_turret", false);
    } else {
      self placeTurret(turret);
    }
  } else {
    if(isDefined(turret)) {
      self stopCarryTurret(turret);
      turret notify("destroy_turret", false);
    }
  }
}
watchOwnerLastStand(turret) {
  self endon("disconnect");
  self endon("death");
  turret endon("turret_placed");
  turret endon("destroy_turret");
  turret endon("hacked");
  while (1) {
    self waittill("entering_last_stand");
    if(!turret.hasBeenPlanted) {
      maps\mp\gametypes\_hardpoints::giveKillstreak(turret.hardPointWeapon, undefined, undefined, true);
      turret setTurretCarried(false);
      self stopCarryTurret(turret);
      self _enableWeapon();
      self TakeWeapon(turret.hardPointWeapon);
      turret notify("destroy_turret", false);
    } else if(turret.canBePlaced && turret.carried) {
      self placeTurret(turret);
    } else {
      if(isDefined(turret)) {
        self stopCarryTurret(turret);
        turret notify("destroy_turret", false);
      }
    }
  }
}
watchOwnerDisconnect(turret) {
  turret endon("turret_deactivated");
  turret endon("hacked");
  self waittill_any("disconnect", "joined_team");
  if(isDefined(turret))
    turret notify("destroy_turret", true);
}
startCarryTurret(turret) {
  turret maketurretunusable();
  turret setTurretCarried(true);
  self _disableWeapon();
  turret SetMode("auto_ai");
  if(turret.turretType == "sentry") {
    turret notify("stop_burst_fire_unmanned");
  } else if(turret.turretType == "tow") {
    turret notify("target_lost");
  }
  turret.carried = true;
  self.carryingTurret = true;
  if(turret.hasBeenPlanted)
    level notify("drop_objects_to_ground", turret.origin, 80);
  self CarryTurret(turret, (40, 0, 0), (0, 0, 0));
  self thread watchOwnerDeath(turret);
  self thread watchOwnerLastStand(turret);
  self thread watchRoundAndGameEnd(turret);
  turret maps\mp\_entityheadicons::destroyEntityHeadIcons();
  turret SetTurretOwner(self);
  turret SetDefaultDropPitch(-90.0);
  self thread updateTurretPlacement(turret);
  self thread watchTurretPlacement(turret);
  turret notify("turret_carried");
}
updateTurretPlacement(turret) {
  self endon("death");
  self endon("entering_last_stand");
  self endon("disconnect");
  turret endon("turret_placed");
  turret endon("turret_deactivated");
  lastPlacedTurret = -1;
  turret.canBePlaced = false;
  while (1) {
    placement = self canPlayerPlaceTurret();
    turret.origin = placement["origin"];
    turret.angles = placement["angles"];
    good_spot_check = placement["result"] & !(turret turretInHurtTrigger());
    good_spot_check = placement["result"] & !(turret turretInNoTurretPlacementTrigger());
    turret.canBePlaced = good_spot_check;
    if(turret.canBePlaced != lastPlacedTurret) {
      if(good_spot_check)
        turret SetModel(level.auto_turret_settings[turret.turretType].modelGoodPlacement);
      else
        turret SetModel(level.auto_turret_settings[turret.turretType].modelBadPlacement);
      lastPlacedTurret = turret.canBePlaced;
    }
    self SetTurretHint(turret.canBePlaced);
    wait(0.05);
  }
}
turretInHurtTrigger() {
  for (i = 0; i < level.fatal_triggers.size; i++) {
    if(self IsTouching(level.fatal_triggers[i])) {
      return true;
    }
  }
  return false;
}
turretInNoTurretPlacementTrigger() {
  for (i = 0; i < level.noTurretPlacementTriggers.size; i++) {
    if(self IsTouching(level.noTurretPlacementTriggers[i])) {
      return true;
    }
  }
  return false;
}
watchTurretPlacement(turret) {
  self endon("disconnect");
  self endon("death");
  self endon("entering_last_stand");
  turret endon("turret_placed");
  turret endon("turret_deactivated");
  while (1) {
    if(!turret.hasBeenPlanted && self actionSlotFourButtonPressed()) {
      maps\mp\gametypes\_hardpoints::giveKillstreak(turret.hardPointWeapon, undefined, undefined, true);
      turret setTurretCarried(false);
      self.carryingTurret = false;
      self stopCarryTurret(turret);
      self _enableWeapon();
      turret notify("destroy_turret", false);
      break;
    }
    if(self attackbuttonpressed() && turret.canBePlaced) {
      placement = self canPlayerPlaceTurret();
      if(placement["result"]) {
        turret.origin = placement["origin"];
        turret.angles = placement["angles"];
        self placeTurret(turret);
      }
    }
    wait(0.05);
  }
}
placeTurret(turret) {
  if(!turret.carried || !turret.canBePlaced)
    return;
  turret setTurretCarried(false);
  self stopCarryTurret(turret, turret.origin, turret.angles);
  turret spawnTurretPickUpTrigger(self);
  turret spawnTurretHackerTrigger(self);
  self thread initTurret(turret);
  self _enableWeapon();
  turret.carried = false;
  self.carryingTurret = false;
  turret.hasBeenPlanted = true;
  turret thread watchScramble();
  if(turret.stunnedByTacticalGrenade)
    turret thread stunTurretTacticalGrenade(turret.stunDuration);
  self PlayRumbleOnEntity("damage_heavy");
  turret thread TurretScanStartWaiter();
  turret notify("turret_placed");
}
initTurret(turret) {
  maps\mp\_mgturret::turret_set_difficulty(turret, "fu");
  turret SetModel(level.auto_turret_settings[turret.turretType].modelBase);
  turret SetForceNoCull();
  turret PlaySound("mpl_turret_startup");
  if(level.teambased) {
    offset = level.turrets_headicon_offset["default"];
    if(isDefined(level.turrets_headicon_offset[turret.turretType])) {
      offset = level.turrets_headicon_offset[turret.turretType];
    }
    turret maps\mp\_entityheadicons::setEntityHeadIcon(self.pers["team"], self, offset);
  }
  turret maketurretunusable();
  turret SetMode("auto_nonai");
  turret SetTurretOwner(self);
  turret.owner = self;
  turret SetDefaultDropPitch(45.0);
  if(turret.turretType == "sentry")
    turret thread turret_sentry_think(self);
  else if(turret.turretType == "tow")
    turret thread turret_tow_think(self);
  turret.turret_active = true;
  turret.spawninfluencerid = maps\mp\gametypes\_spawning::create_auto_turret_influencer(turret.origin, turret.team, turret.angles);
  turret thread watchDamage();
  turret thread checkForStunDamage();
  wait(1.0);
  flag_set("end_target_confirm");
}
setupTurretHealth(turret) {
  turret.health = 1000;
  turret.bulletDamageReduction = 0.3;
}
watchDamage() {
  self endon("turret_deactivated");
  medalGiven = false;
  self.damageTaken = 0;
  for (;;) {
    self waittill("damage", damage, attacker, direction, point, type, tagName, modelName, partname, weaponName);
    if(!isDefined(attacker) || !isplayer(attacker))
      continue;
    if(isPlayer(attacker) && level.teambased && isDefined(attacker.team) && self.team == attacker.team && attacker != self.owner)
      continue;
    if((type == "MOD_PISTOL_BULLET") || (type == "MOD_RIFLE_BULLET")) {
      if(attacker HasPerk("specialty_armorpiercing"))
        damage += int(damage * level.cac_armorpiercing_data);
      self.damageTaken += self.bulletDamageReduction * damage;
    } else if((type == "MOD_MELEE"))
      self.damageTaken = self.health;
    else
      self.damageTaken += damage;
    if(isDefined(weaponName)) {
      switch (weaponName) {
        case "concussion_grenade_mp":
        case "flash_grenade_mp":
          if(!self.stunnedByTacticalGrenade) {
            self thread stunTurretTacticalGrenade(self.stunDuration);
          }
          if(level.teambased && self.owner.team != attacker.team) {
            if(maps\mp\gametypes\_globallogic_player::doDamageFeedback(weaponName, attacker))
              attacker maps\mp\gametypes\_damagefeedback::updateDamageFeedback(false);
          } else if(!level.teambased && self.owner != attacker) {
            if(maps\mp\gametypes\_globallogic_player::doDamageFeedback(weaponName, attacker))
              attacker maps\mp\gametypes\_damagefeedback::updateDamageFeedback(false);
          }
          break;
        default:
          if(maps\mp\gametypes\_globallogic_player::doDamageFeedback(weaponName, attacker))
            attacker maps\mp\gametypes\_damagefeedback::updateDamageFeedback(false);
          break;
      }
    }
    if(self.damageTaken >= self.health) {
      doMedal = false;
      if(level.teambased && attacker != self.owner && attacker.team != self.owner.team) {
        doMedal = true;
      } else if(!level.teambased && attacker != self.owner) {
        doMedal = true;
      }
      if(doMedal) {
        attacker maps\mp\_medals::destroyerTurret(weaponName);
        if(medalGiven == false) {
          if(self.turretType == "sentry") {
            attacker maps\mp\_properks::destroyedSentryTurret();
          }
          attacker maps\mp\_properks::destroyedKillstreak();
          if(isDefined(self.hardPointWeapon)) {
            level.globalKillstreaksDestroyed++;
            attacker maps\mp\gametypes\_globallogic_score::setWeaponStat(self.hardPointWeapon, 1, "destroyed");
          }
          medalGiven = true;
        }
      }
      owner = self.owner;
      if(self.turretType == "sentry")
        owner maps\mp\gametypes\_globallogic_audio::leaderDialogOnPlayer("sentry_destroyed", "item_destroyed");
      else if(self.turretType == "tow")
        owner maps\mp\gametypes\_globallogic_audio::leaderDialogOnPlayer("sam_destroyed", "item_destroyed");
      self.damageTaken = self.health;
      self notify("destroy_turret", true);
    }
  }
}
watchTurretLifespan() {
  self endon("turret_deactivated");
  self endon("death");
  while (1) {
    if(self.curr_time > level.auto_turret_timeout) {
      break;
    }
    if(self.waitForTargetToBeginLifespan) {
      wait(0.1);
      continue;
    }
    if((self.curr_time + 2.0) > level.auto_turret_timeout)
      self DeleteTurretUseTrigger();
    if(!self.carried)
      self.curr_time += 1.0;
    wait(1.0);
  }
  self notify("destroy_turret", true);
}
checkForStunDamage() {
  self endon("turret_deactivated");
  while (1) {
    self waittill("damage_caused_by", weapon);
    if(isStunWeapon(weapon) && !self.stunnedByTacticalGrenade) {
      self thread stunTurretTacticalGrenade(self.stunDuration);
    }
  }
}
stunTurretTacticalGrenade(duration) {
  self endon("turret_deactivated");
  self SetMode("auto_ai");
  self notify("stop_burst_fire_unmanned");
  if(self maps\mp\gametypes\_weaponobjects::isStunned()) {
    return;
  }
  self.stunnedByTacticalGrenade = true;
  self thread stunTurretFx();
  if(self.stunnedByTacticalGrenade) {
    while (1) {
      if(self.stunTime >= duration) {
        break;
      }
      if(self.carried)
        return;
      self.stunTime += 0.1;
      wait(0.1);
    }
  }
  self.stunnedByTacticalGrenade = false;
  self.stunTime = 0.0;
  if(!self.carried)
    self SetMode("auto_nonai");
  if(self.turretType != "tow" && !self.carried)
    self thread maps\mp\_mgturret::burst_fire_unmanned();
  self notify("turret_stun_ended");
}
stunTurret(duration) {
  self endon("turret_deactivated");
  if(self maps\mp\gametypes\_weaponobjects::isStunned() && !self.stunnedByTacticalGrenade) {
    return;
  }
  self SetMode("auto_ai");
  self notify("stop_burst_fire_unmanned");
  self thread stunTurretFx();
  if(isDefined(duration)) {
    wait(duration);
  } else {
    return;
  }
  if(!self.carried)
    self SetMode("auto_nonai");
  if(self.turretType != "tow" && !self.carried)
    self thread maps\mp\_mgturret::burst_fire_unmanned();
  self notify("turret_stun_ended");
  level notify("turret_stun_ended", self);
}
stunFxThink(fx) {
  fx endon("death");
  self waittill_any("death", "turret_stun_ended", "turret_deactivated", "hacked", "turret_carried");
  fx delete();
}
stunTurretFx() {
  self endon("turret_deactivated");
  self endon("death");
  self endon("turret_stun_ended");
  if(self maps\mp\gametypes\_weaponobjects::isStunned()) {
    return;
  }
  origin = self GetTagOrigin("TAG_aim");
  self.stun_fx = Spawn("script_model", origin);
  self.stun_fx SetModel("tag_origin");
  self thread stunFxThink(self.stun_fx);
  wait(0.1);
  PlayFXOnTag(level.auto_turret_settings[self.turretType].stunFX, self.stun_fx, "tag_origin");
  self.stun_fx PlaySound("dst_disable_spark");
}
isStunWeapon(weapon) {
  switch (weapon) {
    case "concussion_grenade_mp":
      return true;
    case "flash_grenade_mp":
      return true;
    default:
      return false;
  }
}
scramblerStun(stun) {
  if(stun) {
    self thread stunTurret();
  } else {
    self SetMode("auto_nonai");
    if(self.turretType != "tow")
      self thread maps\mp\_mgturret::burst_fire_unmanned();
    self notify("turret_stun_ended");
    level notify("turret_stun_ended", self);
  }
}
watchScramble() {
  self endon("death");
  self endon("turret_deactivated");
  self endon("turret_carried");
  if(self maps\mp\_scrambler::checkScramblerStun()) {
    self thread scramblerStun(true);
  }
  for (;;) {
    level waittill_any("scrambler_spawn", "scrambler_death", "hacked", "turret_stun_ended");
    wait(0.05);
    if(self maps\mp\_scrambler::checkScramblerStun()) {
      self thread scramblerStun(true);
    } else {
      self scramblerStun(false);
    }
  }
}
destroyTurret() {
  self waittill("destroy_turret", playDeathAnim);
  if(self.turretType == "sentry")
    maps\mp\_killstreakrules::killstreakStop("autoturret_mp", self.team);
  else
    maps\mp\_killstreakrules::killstreakStop("auto_tow_mp", self.team);
  self.turret_active = false;
  self.curr_time = -1;
  self SetMode("auto_ai");
  self notify("stop_burst_fire_unmanned");
  self notify("turret_deactivated");
  self DeleteTurretUseTrigger();
  if(isDefined(playDeathAnim) && playDeathAnim && !self.carried) {
    self playsound("dst_equipment_destroy");
    self stunTurret(self.stunDuration);
  }
  level notify("drop_objects_to_ground", self.origin, 80);
  if(isDefined(self.spawninfluencerid))
    RemoveInfluencer(self.spawninfluencerid);
  wait(0.1);
  if(isDefined(self)) {
    if(self.hasBeenPlanted) {
      PlayFX(level._turret_explode_fx, self.origin + (0, 0, 20));
      self playsound("mpl_turret_exp");
    }
    if(self.carried && isDefined(self.owner)) {
      self.owner _enableWeapon();
    }
    self Delete();
  }
}
DeleteTurretUseTrigger() {
  if(isDefined(self.pickUpTrigger))
    self.pickUpTrigger delete();
  if(isDefined(self.hackerTrigger)) {
    if(isDefined(self.hackerTrigger.progressBar)) {
      self.hackerTrigger.progressBar destroyElem();
      self.hackerTrigger.progressText destroyElem();
    }
    self.hackerTrigger delete();
  }
}
spawnTurretPickUpTrigger(player) {
  pos = self.origin + (0, 0, 15);
  self.pickUpTrigger = spawn("trigger_radius_use", pos);
  if(self.turretType == "sentry")
    self.pickUpTrigger SetCursorHint("HINT_NOICON", "auto_gun_turret_mp");
  else
    self.pickUpTrigger SetCursorHint("HINT_NOICON", "tow_turret_mp");
  if(isDefined(level.auto_turret_settings[self.turretType].hintString))
    self.pickUpTrigger SetHintString(level.auto_turret_settings[self.turretType].hintString);
  else
    self.pickUpTrigger SetHintString(&"MP_GENERIC_PICKUP");
  if(level.teamBased)
    self.pickUpTrigger SetTeamForTrigger(player.team);
  player ClientClaimTrigger(self.pickUpTrigger);
  self thread watchTurretUse(self.pickUpTrigger);
}
watchTurretUse(trigger) {
  self endon("delete");
  self endon("turret_deactivated");
  self endon("turret_carried");
  while (true) {
    trigger waittill("trigger", player);
    if(!isAlive(player))
      continue;
    if(!player isOnGround())
      continue;
    if(isDefined(trigger.triggerTeam) && (player.team != trigger.triggerTeam))
      continue;
    if(isDefined(trigger.claimedBy) && (player != trigger.claimedBy))
      continue;
    if(player useButtonPressed() && !player.throwingGrenade && !player meleeButtonPressed() && !player attackButtonPressed() && !player.carryingTurret) {
      player PlayRumbleOnEntity("damage_heavy");
      self PlaySound("mpl_turret_down");
      self DeleteTurretUseTrigger();
      player thread startCarryTurret(self);
      self DeleteTurretUseTrigger();
      RemoveInfluencer(self.spawninfluencerid);
    }
  }
}
turret_sentry_think(player) {
  wait(level.auto_turret_settings[self.turretType].turretInitDelay);
  self thread maps\mp\_mgturret::burst_fire_unmanned();
}
turret_tow_think(player) {
  self endon("turret_deactivated");
  self endon("death");
  player endon("disconnect");
  level endon("game_ended");
  turretState = "started";
  self thread missile_fired_notify();
  wait(level.auto_turret_settings[self.turretType].turretInitDelay);
  while (1) {
    if(self IsFiringTurret() && turretState != "firing") {
      turretState = "firing";
      self playsound("mpl_turret_alert");
      self thread do_tow_shoot(player);
    } else {
      self notify("target_lost");
      turretState = "scanning";
    }
    self waittill("turretstatechange");
    self notify("target_lost");
  }
}
do_tow_shoot(player) {
  self endon("turret_deactivated");
  self endon("death");
  player endon("disconnect");
  self endon("target_lost");
  level endon("game_ended");
  while (1) {
    if(self.fireTime < level.auto_turret_settings["tow"].turretFireDelay) {
      wait(0.1);
      self.fireTime += 0.1;
      continue;
    }
    self ShootTurret();
    self.fireTime = 0.0;
  }
}
missile_fired_notify() {
  self endon("turret_deactivated");
  self endon("death");
  level endon("game_ended");
  if(isDefined(self.owner)) {
    self.owner endon("disconnect");
  }
  while (true) {
    self waittill("missile_fire", missile, weap, target);
    if(isDefined(target)) {
      target notify("stinger_fired_at_me", missile, weap, self.owner);
    }
    level notify("missile_fired", self, missile, target, true);
  }
}
spawnTurretHackerTrigger(player) {
  triggerOrigin = self.origin + (0, 0, 10);
  self.hackerTrigger = Spawn("trigger_radius_use", triggerOrigin, level.weaponobjects_hacker_trigger_width, level.weaponobjects_hacker_trigger_height);
  if(self.turretType == "sentry")
    self.hackerTrigger SetCursorHint("HINT_NOICON", "auto_gun_turret_mp");
  else
    self.hackerTrigger SetCursorHint("HINT_NOICON", "tow_turret_mp");
  self.hackerTrigger SetIgnoreEntForTrigger(self);
  self.hackerTrigger SetHintString(level.auto_turret_settings[self.turretType].hackerHintString);
  self.hackerTrigger SetPerkForTrigger("specialty_disarmexplosive");
  self.hackerTrigger thread maps\mp\gametypes\_weaponobjects::hackerTriggerSetVisibility(player);
  self thread hackerThink(self.hackerTrigger, player);
}
hackerThink(trigger, owner) {
  self endon("death");
  for (;;) {
    trigger waittill("trigger", player);
    if(!trigger maps\mp\gametypes\_weaponobjects::hackerResult(player, owner)) {
      continue;
    }
    if(self.turretType == "sentry") {
      maps\mp\_killstreakrules::killstreakStop("autoturret_mp", self.team);
      maps\mp\_killstreakrules::killstreakStart("autoturret_mp", player.team, true);
    } else {
      maps\mp\_killstreakrules::killstreakStop("auto_tow_mp", self.team);
      maps\mp\_killstreakrules::killstreakStart("auto_tow_mp", player.team, true);
    }
    if(level.teamBased) {
      self SetTurretTeam(player.team);
      self.team = player.team;
    } else {
      self SetTurretTeam("free");
      self.team = "free";
    }
    self.hacked = true;
    self SetTurretOwner(player);
    self.owner = player;
    self notify("hacked", player);
    level notify("hacked", self);
    self DeleteTurretUseTrigger();
    wait(0.1);
    self thread stunTurret(2.5);
    wait(2.5);
    if(isDefined(player) && player.sessionstate == "playing") {
      player thread watchOwnerDeath(self);
      player thread watchOwnerDisconnect(self);
    }
    offset = level.turrets_headicon_offset["default"];
    if(isDefined(level.turrets_headicon_offset[self.turretType])) {
      offset = level.turrets_headicon_offset[self.turretType];
    }
    self maps\mp\_entityheadicons::setEntityHeadIcon(player.pers["team"], player, offset);
    self spawnTurretHackerTrigger(player);
    return;
  }
}
TurretScanStartWaiter() {
  self endon("turret_deactivated");
  self endon("death");
  self endon("turret_carried");
  level endon("game_ended");
  turret_scan_start_sound_ent = spawn("script_origin", self.origin);
  turret_scan_start_sound_ent linkto(self, "tag_origin", (0, 0, 0), (0, 0, 0));
  self thread TurretScanStopWaiter(turret_scan_start_sound_ent);
  self thread TurretScanStopWaiterCleanup(turret_scan_start_sound_ent);
  while (1) {
    self waittill("turret_scan_start");
    turret_scan_start_sound_ent playloopsound("mpl_turret_servo", 2);
    wait(0.5);
  }
}
TurretScanStopWaiter(ent) {
  self endon("turret_sound_cleanup");
  level endon("game_ended");
  while (1) {
    self waittill("turret_scan_stop");
    ent playsound("mpl_turret_servo_stop");
    ent StopLoopSound(0.5);
    wait(0.5);
  }
}
TurretScanStopWaiterCleanup(ent) {
  level endon("game_ended");
  self waittill_any("death", "disconnect", "turret_deactivated");
  self notify("turret_sound_cleanup");
  wait .1;
  println("snd scan delete");
  if(isDefined(ent))
    ent delete();
}
turretScanStopNotify() {}
turret_debug_box(origin, mins, maxs, color) {}
turret_debug_line(start, end, color) {}