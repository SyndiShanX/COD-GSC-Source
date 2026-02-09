/****************************************************
 * Decompiled by Alterware and Edited by SyndiShanX
 * Script: maps\mp\killstreaks\streak_mp_laser2.gsc
****************************************************/

#include maps\mp\_utility;
#include common_scripts\utility;
#include maps\mp\_audio;

LASER_DROP_PITCH_OFFLINE = -10;
LASER_DROP_PITCH_ONLINE = 5;

init() {
  initLaserFX();
  initLaserSound();
  initLaser();
  initLaserEnts();

  level.killstreakFuncs["mp_laser2"] = ::tryUseMPLaser;
  level.mapKillStreak = "mp_laser2";
  level.mapKillstreakPickupString = &"MP_LASER2_MAP_KILLSTREAK_PICKUP";
  level.mapKillStreakDamageFeedbackSound = ::handleDamageFeedbackSound;
  level.killstreak_laser_fxmode = 0;
  level.mapCustomBotKillstreakFunc = ::setupBotsForMapKillstreak;
}

setupBotsForMapKillstreak() {
  level thread maps\mp\bots\_bots_ks::bot_register_killstreak_func("mp_laser2", maps\mp\bots\_bots_ks::bot_killstreak_simple_use);
}

initLaserFX() {
  level.laser_fx["beahm"] = LoadFX("vfx/muzzleflash/laser_wv_mp_laser");
  level.laser_fx["beahm_smoke"] = LoadFX("vfx/muzzleflash/laser_wv_mp_laser_smoke");
  level.laser_fx["laser_field1"] = LoadFX("vfx/map/mp_laser2/laser_core_lvl1");
  level.laser_fx["laser_field1_cheap"] = LoadFX("vfx/map/mp_laser2/laser_core_lvl1_cheap");
  level.laser_fx["laser_field2"] = LoadFX("vfx/map/mp_laser2/laser_core_lvl2");
  level.laser_fx["laser_field2_cheap"] = LoadFX("vfx/map/mp_laser2/laser_core_lvl2_cheap");
  level.laser_fx["laser_field3"] = LoadFX("vfx/map/mp_laser2/laser_core_lvl3");

  level.laser_fx["laser_field2_up"] = LoadFX("vfx/map/mp_laser2/laser_core_up_lvl2");
  level.laser_fx["laser_field3_up"] = LoadFX("vfx/map/mp_laser2/laser_core_up_lvl3");
  level.laser_fx["laser_field1_up_slow"] = LoadFX("vfx/map/mp_laser2/laser_core_up_slow_lvl1");

  level.laser_fx["laser_field2_down"] = LoadFX("vfx/map/mp_laser2/laser_core_down_lvl2");
  level.laser_fx["laser_field3_down"] = LoadFX("vfx/map/mp_laser2/laser_core_down_lvl3");
  level.laser_fx["laser_field1_down_slow"] = LoadFX("vfx/map/mp_laser2/laser_core_down_slow_lvl1");

  level.laser_fx["laser_charge1"] = LoadFX("vfx/map/mp_laser2/laser_energy_fire_lvl1");
  level.laser_fx["laser_beam_done1"] = LoadFX("vfx/map/mp_laser2/laser_energy_beam_done_lvl1");
  level.laser_fx["hatch_light"] = Loadfx("vfx/lights/mp_laser2/light_lasercore_glow");
  level.laser_fx["hatch_light_close"] = Loadfx("vfx/lights/mp_laser2/light_lasercore_glow_close");

  level.laser_fx["laser_steam"] = LoadFX("vfx/map/mp_laser2/laser_core_steam");
  level.laser_fx["laser_movement_sparks"] = LoadFX("vfx/sparks/machinery_scrape_sparks_looping");
}

initLaserSound() {
  game["dialog"]["laser_deactivated"] = "laser_deactivated";
  game["dialog"]["laser_offline"] = "laser_offline";
  game["dialog"]["laser_strength"] = "laser_strength";
}

initLaser() {
  laser = spawnStruct();
  laser.health = 999999;
  laser.maxHealth = 1000;
  laser.burstMin = 20;
  laser.burstMax = 120;
  laser.pauseMin = 0.15;
  laser.pauseMax = 0.35;
  laser.sentryModeOn = "sentry_manual";
  laser.sentryModeOff = "sentry_offline";
  laser.timeOut = 45.0;
  laser.spinupTime = 0.05;
  laser.overheatTime = 8.0;
  laser.cooldownTime = 0.1;
  laser.fxTime = 0.3;
  laser.streakName = "sky_laser_turret";
  laser.weaponInfo = "sky_laser_mp";
  laser.useweaponinfo = "killstreak_laser2_mp";
  laser.modelBase = "mp_sky_laser_turret_head";
  laser.modelDestroyed = "mp_sky_laser_turret_head";
  laser.headIcon = true;
  laser.teamSplash = "used_mp_laser2";
  laser.shouldSplash = false;
  laser.voDestroyed = "laser_deactivated";
  laser.voOffline = "laser_offline";
  laser.vopower = "laser_strength";
  laser.coreShellshock = "default";

  if(!isDefined(level.sentrySettings)) {
    level.sentrySettings = [];
  }

  level.sentrySettings["sky_laser_turret"] = laser;
  level.killstreakWieldWeapons["mp_laser2_core"] = "mp_laser2";
}

initLaserEnts() {
  sentryType = "sky_laser_turret";

  PreCacheItem("mp_laser2_core");
  PreCacheModel("lsr_laser_button_01_obj");

  laserEnt = GetEnt("lasergun", "targetname");
  assertEx(isDefined(laserEnt), "ent with targetname of lasergun is undefined");
  laserEnt hide();
  laserEnt laserlightfill();
  laserEnt.FxEnts = laserEnt laser_initFxEnts();
  laserEnt.offSwitch = laserEnt laser_initOffSwitch();

  laserEnt.lifter = GetEnt("laser_animated_prop", "targetname");
  laserEnt.lifter.parts = getEntArray("lsr_animated_parts", "targetname");
  laserEnt.lifter laserlightfill();
  assertEx(isDefined(laserEnt), "ent with targetname of laser_lifter is undefined");
  laserEnt.moveOrgs = laserEnt.lifter laser_initMoveOrgs();
  laserEnt.lifter.animUp = "lsr_laser_turret_up";
  laserEnt.lifter.animDown = "lsr_laser_turret_down";
  laserEnt.lifter.animIdleDown = "lsr_laser_turret_idle_down";
  laserEnt.lifter.animIdleUp = "lsr_laser_turret_idle_up";

  laserEnt.GeneratorHat = GetEnt("generator_hat", "targetname");
  assertEx(isDefined(laserEnt), "ent with targetname of generator_hat is undefined");
  laserEnt.GeneratorHat.anim_up = "laser_button_on";
  laserEnt.GeneratorHat.anim_down = "laser_button_off";
  laserEnt.GeneratorHat.anim_idle_up = "laser_button_idle_on";
  laserEnt.GeneratorHat.anim_idle_down = "laser_button_idle_off";

  laserEnt.coreDamageTrig = getent("trig_lasercore_damage", "targetname");
  assertEx(isDefined(laserEnt.coreDamageTrig), "ent with targetname of trig_lasercore_damage is undefined");

  laserEnt.coreDeathTrig = getent("trig_lasercore_death", "targetname");
  assertEx(isDefined(laserEnt.coreDeathTrig), "ent with targetname of trig_lasercore_death is undefined");

  laserEnt.firingDamageTrig = getent("trig_laserfire_damage", "targetname");
  assertEx(isDefined(laserEnt.firingDamageTrig), "ent with targetname of trig_laserfire_damage is undefined");

  laserEnt.ownerList = [];

  laserEnt.collision = spawnStruct();

  laserEnt.collision.col_base = GetEnt("laser_collision_base", "targetname");
  laserEnt.collision.col_head = GetEnt("laser_collision_head", "targetname");

  laserEnt.flaps_top = getEntArray("lsr_flap_top", "targetname");
  laserEnt.attachments = getEntArray("lsr_geo_attach", "targetname");

  laserEnt.lifter LinkGeoToTurret(laserEnt, true);

  flaps_bottom = getEntArray("lsr_flap_bottom", "targetname");
  laserEnt.flaps = array_combine(laserEnt.flaps_top, flaps_bottom);
  foreach(flap in laserEnt.flaps) {
    flap.col_base = getent(flap.target, "targetname");
    if(isDefined(flap.col_base)) {
      flap.col_base.unresolved_collision_kill = true;
    }
    flap.col_T = getent(flap.col_base.target, "targetname");
    if(isDefined(flap.col_T)) {
      flap.col_T.unresolved_collision_kill = true;
    }
    flap.col_base LinkToSynchronizedParent(flap, "mainFlapBase");
    flap.col_T LinkToSynchronizedParent(flap, "mainFlap_T");
  }
  laserEnt.flap_animClose = "lsr_energy_hatch_close";
  laserEnt.flap_animIdleClose = "lsr_energy_hatch_close_idle";
  laserEnt.flap_animOpen = "lsr_energy_hatch_open";
  laserEnt.flap_animIdleOpen = "lsr_energy_hatch_open_idle";

  level.sentryGun = laserEnt;
  level.sentryGun laser_initSentry(sentryType);
}
LinkGeoToTurret(laser, ShouldLink) {
  if(ShouldLink == false) {
    laser.collision.col_base unlink();
    laser.collision.col_head unlink();

    foreach(flap in laser.flaps_top) {
      flap unlink();
    }
    foreach(attachment in laser.attachments) {
      attachment unlink();
    }
    foreach(part in laser.lifter.parts) {
      part unlink();
    }
  } else if(ShouldLink == true) {
    laser.collision.col_base linkto(self, "tag_origin");
    laser.collision.col_head linkto(self, "tag_aim_pivot");

    foreach(flap in laser.flaps_top) {
      flap linktoSynchronizedParent(self);
    }
    foreach(attachment in laser.attachments) {
      attachment linktoSynchronizedParent(self);
    }
    foreach(part in laser.lifter.parts) {
      part linktoSynchronizedParent(self);
    }
  }
}
laser_initMoveOrgs() {
  locEnt_top = getStruct("laser_lifter_top_loc", "targetname");
  locEnt_bottom = getStruct("laser_lifter_bottom_loc", "targetname");

  assertEx(isDefined(locEnt_top), "struct with targetname of laser_lifter_top_loc is undefined");
  assertEx(isDefined(locEnt_bottom), "struct with targetname of laser_lifter_bottom_loc is undefined");

  locEnt_dist = locEnt_top.origin - locEnt_bottom.origin;

  moveOrgs = [];
  moveOrgs["bottom"] = self.origin;
  moveOrgs["top"] = self.origin + locEnt_dist;

  return moveOrgs;
}

laser_initFxEnts() {
  charge_up = undefined;

  coreStruct = getstruct("laser_core_fx_pos", "targetname");

  assertEx(isDefined(coreStruct), "struct with targetname of laser_core_fx_pos is undefined");

  charge_up = coreStruct spawn_tag_origin();
  charge_up show();

  FxEnts = [];
  FxEnts["charge_up"] = charge_up;

  return FxEnts;
}

laser_initOffSwitch() {
  trigger = GetEnt("laser_use_trig", "targetname");
  offSwitchEnt = GetEnt("laser_switch", "targetname");

  assertEx(isDefined(offSwitchEnt), "ent with targetname of laser_switch is not defined");
  assertEx(isDefined(trigger), "ent with targetname of laser_use_trig is not defined");

  offSwitch = [];

  switch_obj = spawn("script_model", offSwitchEnt.origin);
  switch_obj.angles = offSwitchEnt.angles;
  switch_obj setModel("lsr_laser_button_01_obj");
  switch_obj hide();

  visuals = [switch_obj];

  use_zone = maps\mp\gametypes\_gameobjects::createUseObject("none", trigger, visuals, (0, 0, 64));
  use_zone maps\mp\gametypes\_gameobjects::allowUse("none");
  use_zone maps\mp\gametypes\_gameobjects::setUseTime(5);
  use_zone maps\mp\gametypes\_gameobjects::setUseText(&"MP_LASERTURRET_HACKING");
  use_zone maps\mp\gametypes\_gameobjects::setUseHintText(&"MP_LASERTURRET_HACK");

  use_zone.onBeginUse = ::laser_offSwitch_onBeginUse;
  use_zone.onEndUse = ::laser_offSwitch_onEndUse;
  use_zone.onUse = ::laser_offSwitch_onUsePlantObject;
  use_zone.onCantUse = ::laser_offSwitch_onCantUse;
  use_zone.useWeapon = "search_dstry_bomb_mp";

  offSwitch = [];
  offSwitch["switch_obj"] = switch_obj;
  offSwitch["use_zone"] = use_zone;

  return offSwitch;
}

laser_offSwitch_onBeginUse(player) {}

laser_offSwitch_onEndUse(team, player, result) {}

laser_offSwitch_onUsePlantObject(player) {
  level.sentryGun endon("death");
  level endon("game_ended");

  if(isDefined(level.sentryGun.owner)) {
    level.sentryGun.owner thread leaderDialogOnPlayer(level.sentrySettings[level.sentryGun.sentryType].voDestroyed);
  }

  player playSound("mp_bomb_plant");
  damage = level.sentrySettings["sky_laser_turret"].maxhealth;
  level.sentryGun notify("damage", damage, player, (0, 0, 0), (0, 0, 0), "MOD_UNKNOWN", undefined, undefined, undefined, undefined, "none");
}

laser_offSwitch_onCantUse(player) {}

laser_initSentry(sentryType) {
  self.sentryType = sentryType;

  self setModel(level.sentrySettings[self.sentryType].modelBase);
  self.shouldSplash = true;

  self setCanDamage(false);

  self makeTurretInoperable();
  self SetLeftArc(180);
  self SetRightArc(180);
  self SetTopArc(80);
  self SetDefaultDropPitch(LASER_DROP_PITCH_OFFLINE);
  self.laser_on = false;

  self.lifter ScriptModelPlayAnimDeltaMotion(self.lifter.animIdleDown);
  foreach(part in self.lifter.parts) {
    part ScriptModelPlayAnimDeltaMotion(self.lifter.animIdleDown);
  }

  killCamEnt = spawn("script_model", self GetTagOrigin("tag_laser"));
  killCamEnt LinkTo(self);
  self.killCamEnt = killCamEnt;
  self.killCamEnt SetScriptMoverKillCam("explosive");

  self maps\mp\killstreaks\_autosentry::sentry_makeSolid();

  self setTurretModeChangeWait(true);
  self laser_setInactive();

  self thread laser_handleDamage();
  self thread laser_handleFakeDeath();
  self thread maps\mp\killstreaks\_autosentry::sentry_beepSounds();
}

laser_handleDamage() {
  self endon("death");
  level endon("game_ended");

  while(true) {
    self.health = level.sentrySettings[self.sentryType].health;
    self.maxHealth = level.sentrySettings[self.sentryType].maxHealth;
    self.damageTaken = 0;

    self waittill("damage", damage, attacker, direction_vec, point, meansOfDeath, modelName, tagName, partName, iDFlags, weapon);

    if(!maps\mp\gametypes\_weapons::friendlyFireCheck(self.owner, attacker)) {
      continue;
    }

    if(isDefined(iDFlags) && (iDFlags &level.iDFLAGS_PENETRATION)) {
      self.wasDamagedFromBulletPenetration = true;
    }

    switch (weapon) {
      case "artillery_mp":
      case "stealth_bomb_mp":
        damage *= 4;
        break;
      case "bomb_site_mp":
        damage = self.maxHealth;
        break;
    }

    if(meansOfDeath == "MOD_MELEE") {
      self.damageTaken += self.maxHealth;
    }

    modifiedDamage = damage;
    if(isPlayer(attacker)) {
      attacker maps\mp\gametypes\_damagefeedback::updateDamageFeedback("sentry");

      if(attacker _hasPerk("specialty_armorpiercing")) {
        modifiedDamage = damage * level.armorPiercingMod;
      }
    }

    if(isDefined(attacker.owner) && isPlayer(attacker.owner)) {
      attacker.owner maps\mp\gametypes\_damagefeedback::updateDamageFeedback("sentry");
    }

    if(isDefined(weapon)) {
      shortWeapon = maps\mp\_utility::strip_suffix(weapon, "_lefthand");

      switch (shortWeapon) {
        case "ac130_105mm_mp":
        case "ac130_40mm_mp":
        case "stinger_mp":
        case "remotemissile_projectile_mp":
          self.largeProjectileDamage = true;
          modifiedDamage = self.maxHealth + 1;
          break;

        case "artillery_mp":
        case "stealth_bomb_mp":
          self.largeProjectileDamage = false;
          modifiedDamage += (damage * 4);
          break;

        case "bomb_site_mp":
        case "emp_grenade_mp":
        case "emp_grenade_var_mp":
          self.largeProjectileDamage = false;
          modifiedDamage = self.maxHealth + 1;
          break;
      }

      maps\mp\killstreaks\_killstreaks::killstreakHit(attacker, weapon, self);
    }

    self.damageTaken += modifiedDamage;

    if(self.damageTaken >= self.maxHealth) {
      thread maps\mp\gametypes\_missions::vehicleKilled(self.owner, self, undefined, attacker, damage, meansOfDeath, weapon);

      if(isPlayer(attacker) && (!isDefined(self.owner) || attacker != self.owner)) {
        level thread maps\mp\gametypes\_rank::awardGameEvent("kill", attacker, weapon, undefined, meansOfDeath);
      }

      if(isDefined(self.owner)) {
        self.owner thread leaderDialogOnPlayer(level.sentrySettings[self.sentryType].voDestroyed, undefined, undefined, self.origin);
      }

      self notify("fakedeath");
    }
  }
}

laser_handleFakeDeath() {
  self endon("death");
  level endon("game_ended");

  for(;;) {
    self waittill("fakedeath");

    self laser_setInactive();
    self.ownerList = [];
    self SetSentryOwner(undefined);
    self.samTargetEnt = undefined;

    if(level.teamBased) {
      self.team = undefined;
    }

    if(isDefined(self.ownerTrigger)) {
      self.ownerTrigger delete();
    }

    self playSound("sentry_explode");

    if(isDefined(self.inUseBy)) {
      self.inUseBy.turret_overheat_bar maps\mp\gametypes\_hud_util::destroyElem();
      self.inUseBy maps\mp\killstreaks\_autosentry::restorePerks();
      self.inUseBy maps\mp\killstreaks\_autosentry::restoreWeapons();

      self notify("deleting");
      wait(1.0);
    } else {
      wait(1.5);
      self playSound("sentry_explode_smoke");
      for(smokeTime = 8; smokeTime > 0; smokeTime -= 0.4) {
        wait(0.4);
      }
    }
  }
}

tryUseMPLaser(lifeId, modules) {
  if(!self playerCanUseLaser()) {
    self iPrintLnBold(&"MP_LASERTURRET_ENEMY");
    return false;
  }

  if(self isUsingRemote()) {
    return false;
  }

  if(self isAirDenied()) {
    return false;
  }

  if(self isEMPed()) {
    return false;
  }

  if(isDefined(level.sentryGun.locked) && level.sentryGun.locked == true) {
    self iPrintLnBold(&"MP_LASERTURRET_BUSY");
    return false;
  }

  self maps\mp\_matchdata::logKillstreakEvent("mp_laser2", self.origin);
  level.sentryGun laser_setOwner(self);

  mode = level.sentryGun getMode();
  if((!isDefined(level.sentryGun.mode) || level.sentryGun.mode == "off") && (!isDefined(level.sentryGun.moving) || level.sentryGun.moving == false)) {
    self laser_setPlaceSentry(level.sentryGun, level.sentryGun.sentryType);
  }

  return true;
}

playerCanUseLaser() {
  assertEx(isPlayer(self), "playerCanUseLaser() called on non-player entity type: " + self.classname);
  assertEx(isDefined(level.sentryGun), "playerCanUseLaser() called without a laser entity");

  if(!isDefined(level.sentryGun)) {
    return false;
  }

  if(level.teamBased) {
    if(isDefined(level.sentryGun.team) && level.sentryGun.team != self.team) {
      return false;
    }
  } else {
    foreach(owner in level.sentryGun.ownerList) {
      if((isDefined(owner) && owner != self)) {
        return false;
      }
    }
  }

  return true;
}

laser_setOwner(owner) {
  assertEx(isDefined(owner), "laser_setOwner() called without owner specified");
  assertEx(isPlayer(owner), "laser_setOwner() called on non-player entity type: " + owner.classname);

  self.owner = owner;
  self.ownerList = array_add(self.ownerList, owner);

  self SetSentryOwner(self.owner);
  self SetTurretMinimapVisible(true, "sam_turret");

  if(level.teamBased) {
    self.team = self.owner.team;
    self setTurretTeam(self.team);
  }

  self thread laser_handleOwnerDisconnect(owner);
  self thread player_sentry_timeOut(owner);

  if(self.ownerList.size > 1) {
    self thread playLaserContainmentSwap();
  }
}

laser_handleOwnerDisconnect(owner) {
  self endon("death");
  self endon("fakedeath");
  level endon("game_ended");

  owner common_scripts\utility::waittill_any("disconnect", "joined_team", "joined_spectators");

  self.ownerList = array_remove(self.ownerList, owner);

  if(owner != self.owner) {
    self thread stopLaserContainmentSwap();
  } else if(owner == self.owner) {
    next_owner = getNextPlayerInOwnerQueue(self.ownerList);
    if(isDefined(next_owner)) {
      self laser_setOwner(next_owner);
    } else {
      self notify("fakedeath");
    }
  }
}

array_removeFirstInQueue(ents, remover) {
  indexents = [];
  indexent = undefined;

  for(i = 0; i < ents.size; i++) {
    if(ents[i] == remover) {
      indexents[indexents.size] = i;
    }
  }

  indexent = indexents[indexents.size - 1];

  newents = [];
  for(i = 0; i < ents.size; i++) {
    if(i != indexent) {
      newents[newents.size] = ents[i];
    }
  }

  return newents;
}

getNextPlayerInOwnerQueue(array) {
  if(!isDefined(array)) {
    return undefined;
  }

  array = array_reverse(array);
  foreach(ent in array) {
    if(isDefined(ent) && isPlayer(ent) && isAlive(ent)) {
      return ent;
    }
  }

  return undefined;
}

laser_setPlaceSentry(sentryGun, sentryType) {
  self endon("death");
  self endon("disconnect");

  player = self;

  if(!player maps\mp\_utility::validateUseStreak()) {
    return false;
  }

  player.last_sentry = sentryType;
  sentryGun laser_setPlaced(self);
  return true;
}

laser_setPlaced(player) {
  if(self GetMode() == "manual") {
    self SetMode(level.sentrySettings[self.sentryType].sentryModeOff);
    self.mode = "off";
  }

  self setSentryCarrier(undefined);
  self setCanDamage(true);

  if(isDefined(self.owner)) {
    self.owner.isCarrying = false;
  }

  self thread laser_setActive(player);
  self thread playLaserCoreEvent();
  self thread playLaserContainmentStart();
  self playSound("sentry_gun_plant");

  self notify("placed");
}

playLaserCoreEvent() {
  wait 2.0;
  playFXOnTag(level.laser_fx["laser_steam"], self.FxEnts["charge_up"], "tag_origin");
}

StopLaserCoreEvent() {
  wait 4;
  stopFXOnTag(level.laser_fx["laser_steam"], self.FxEnts["charge_up"], "tag_origin");

  level noself_delayCall(3.5, ::ActivatePersistentClientExploder, 200);
}

StartLaserLights() {
  laserLgtEnts = GetScriptableArray("laser_light", "targetname");
  foreach(laserLgtEnt in laserLgtEnts) {
    laserLgtEnt SetScriptablePartState("lsr_part_a", "laser_on_a");
  }

  laserLgtEnts = GetScriptableArray("laser_light_b", "targetname");
  foreach(laserLgtEnt in laserLgtEnts) {
    laserLgtEnt SetScriptablePartState("lsr_part_b", "laser_on_b");
  }

  laserLgtEnts = GetScriptableArray("laser_point_lights", "targetname");
  foreach(laserLgtEnt in laserLgtEnts) {
    laserLgtEnt SetScriptablePartState("static_part1", "warning");
  }
}

StopLaserLights() {
  laserLgtEnts = GetScriptableArray("laser_light", "targetname");
  foreach(laserLgtEnt in laserLgtEnts) {
    laserLgtEnt SetScriptablePartState("lsr_part_a", "laser_off_a");
  }

  laserLgtEnts = GetScriptableArray("laser_light_b", "targetname");
  foreach(laserLgtEnt in laserLgtEnts) {
    laserLgtEnt SetScriptablePartState("lsr_part_b", "laser_off_b");
  }

  laserLgtEnts = GetScriptableArray("laser_point_lights", "targetname");
  foreach(laserLgtEnt in laserLgtEnts) {
    laserLgtEnt SetScriptablePartState("static_part1", "healthy");
  }
}

playLaserContainmentStart() {
  level.killstreak_laser_fxmode = 1;

  stopclientexploder(200);
  playFXOnTag(level.laser_fx["hatch_light"], self.FxEnts["charge_up"], "tag_origin");
  playFXOnTag(level.laser_fx["hatch_light"], level.sentryGun.lifter, "tag_origin");
  wait 5.33;
  StartLaserLights();
  playFXOnTag(level.laser_fx["laser_field1_up_slow"], self.FxEnts["charge_up"], "tag_origin");
  wait 1.0;
  playFXOnTag(level.laser_fx["laser_field1"], self.FxEnts["charge_up"], "tag_origin");
}

playLaserContainmentSwap() {
  if(!isDefined(self.ownerList) || self.ownerList.size < 1) {
    return;
  }

  level.killstreak_laser_fxmode = self.ownerList.size;
  fxId = level.killstreak_laser_fxmode;

  switch (fxId) {
    case 0:
      break;
    case 1:

      break;
    case 2:
      stopFXOnTag(level.laser_fx["laser_field1"], self.FxEnts["charge_up"], "tag_origin");
      playFXOnTag(level.laser_fx["laser_field1_cheap"], self.FxEnts["charge_up"], "tag_origin");
      playFXOnTag(level.laser_fx["laser_field2_up"], self.FxEnts["charge_up"], "tag_origin");
      wait 1.0;

      laserOrngLgtEnts = GetScriptableArray("laser_light", "targetname");
      foreach(laserOrngLgtEnt in laserOrngLgtEnts) {
        laserOrngLgtEnt SetScriptablePartState("lsr_part_a", "laser_on_02_a");
      }

      laserLgtEnts = GetScriptableArray("laser_light_b", "targetname");
      foreach(laserLgtEnt in laserLgtEnts) {
        laserLgtEnt SetScriptablePartState("lsr_part_b", "laser_on_02_b");
      }

      playFXOnTag(level.laser_fx["laser_field2"], self.FxEnts["charge_up"], "tag_origin");
      break;
    case 3:
      stopFXOnTag(level.laser_fx["laser_field2"], self.FxEnts["charge_up"], "tag_origin");
      playFXOnTag(level.laser_fx["laser_field2_cheap"], self.FxEnts["charge_up"], "tag_origin");
      playFXOnTag(level.laser_fx["laser_field3_up"], self.FxEnts["charge_up"], "tag_origin");
      wait 1.0;

      laserYellowLgtEnts = GetScriptableArray("laser_light", "targetname");
      foreach(laserYellowLgtEnt in laserYellowLgtEnts) {
        laserYellowLgtEnt SetScriptablePartState("lsr_part_a", "laser_on_03_a");
      }

      laserLgtEnts = GetScriptableArray("laser_light_b", "targetname");
      foreach(laserLgtEnt in laserLgtEnts) {
        laserLgtEnt SetScriptablePartState("lsr_part_b", "laser_on_03_b");
      }

      playFXOnTag(level.laser_fx["laser_field3"], self.FxEnts["charge_up"], "tag_origin");
      break;
    default:
      break;
  }
}

stopLaserContainmentSwap() {
  if(!isDefined(level.killstreak_laser_fxmode)) {
    return;
  }

  fxId = level.killstreak_laser_fxmode;
  level.killstreak_laser_fxmode = self.ownerList.size;
  wait 1.0;
  switch (fxId) {
    case 0:
      break;
    case 1:

      break;
    case 2:
      playFXOnTag(level.laser_fx["laser_field2_down"], self.FxEnts["charge_up"], "tag_origin");
      stopFXOnTag(level.laser_fx["laser_field2"], self.FxEnts["charge_up"], "tag_origin");
      stopFXOnTag(level.laser_fx["laser_field1_cheap"], self.FxEnts["charge_up"], "tag_origin");
      playFXOnTag(level.laser_fx["laser_field1"], self.FxEnts["charge_up"], "tag_origin");

      laserLgtEnts = GetScriptableArray("laser_light", "targetname");
      foreach(laserLgtEnt in laserLgtEnts) {
        laserLgtEnt SetScriptablePartState("lsr_part_a", "laser_on_a");
      }

      laserLgtEnts = GetScriptableArray("laser_light_b", "targetname");
      foreach(laserLgtEnt in laserLgtEnts) {
        laserLgtEnt SetScriptablePartState("lsr_part_b", "laser_on_b");
      }

      break;
    case 3:
      playFXOnTag(level.laser_fx["laser_field3_down"], self.FxEnts["charge_up"], "tag_origin");
      stopFXOnTag(level.laser_fx["laser_field3"], self.FxEnts["charge_up"], "tag_origin");
      stopFXOnTag(level.laser_fx["laser_field2_cheap"], self.FxEnts["charge_up"], "tag_origin");
      playFXOnTag(level.laser_fx["laser_field2"], self.FxEnts["charge_up"], "tag_origin");

      laserLgtEnts = GetScriptableArray("laser_light", "targetname");
      foreach(laserLgtEnt in laserLgtEnts) {
        laserLgtEnt SetScriptablePartState("lsr_part_a", "laser_on_02_a");
      }

      laserLgtEnts = GetScriptableArray("laser_light_b", "targetname");
      foreach(laserLgtEnt in laserLgtEnts) {
        laserLgtEnt SetScriptablePartState("lsr_part_b", "laser_on_02_b");
      }

      break;
    default:
      break;
  }
}

stopLaserContainmentEnd() {
  if(!isDefined(level.killstreak_laser_fxmode)) {
    return;
  }

  fxId = level.killstreak_laser_fxmode;
  level.killstreak_laser_fxmode = 0;
  wait 1.6;
  switch (fxId) {
    case 0:
      break;
    case 1:
      playFXOnTag(level.laser_fx["laser_field1_down_slow"], self.FxEnts["charge_up"], "tag_origin");
      KillFXOnTag(level.laser_fx["laser_field1"], self.FxEnts["charge_up"], "tag_origin");
      StopLaserLights();

      wait 1.5;
      playFXOnTag(level.laser_fx["hatch_light_close"], self.FxEnts["charge_up"], "tag_origin");
      playFXOnTag(level.laser_fx["hatch_light_close"], level.sentryGun.lifter, "tag_origin");
      break;

    default:
      break;
  }
}

laser_setInactive() {
  self.samTargetEnt = undefined;
  self ClearTargetEntity();
  self setMode(level.sentrySettings[self.sentryType].sentryModeOff);
  self.mode = "off";

  entNum = self GetEntityNumber();

  self maps\mp\killstreaks\_autosentry::removeFromTurretList(entNum);

  if(level.teamBased) {
    self setTeamHeadIcon_large("none", (0, 0, 0));
  } else if(isDefined(self.owner)) {
    self setTeamHeadIcon_large("none", (0, 0, 0));
  }

  self SetDefaultDropPitch(LASER_DROP_PITCH_OFFLINE);
  level.sentryGun SetTurretMinimapVisible(false);
  self SetTurretMinimapVisible(false);
  self setCanDamage(false);

  self laser_coreDamage_deactivated(self.coreDamageTrig);
  self laser_coreDamage_deactivated(self.coreDeathTrig);

  if(self.lifter.origin != self.moveOrgs["bottom"]) {
    self laser_usableOffSwitch_off();
    self thread StopLaserCoreEvent();
    self thread stopLaserContainmentEnd();
    self thread laser_handleMoveBottom();
  }
}

laser_handleMoveBottom() {
  self endon("death");
  self endon("fakedeath");
  level endon("game_ended");

  assert(isDefined(self.lifter));
  foreach(part in self.lifter.parts) {
    assert(isDefined(part));
  }

  self.locked = true;
  self.moving = true;

  wait(1);

  self LinkGeoToTurret(self, false);
  self.lifter show();
  self.lifter LinkGeoToTurret(self, true);
  self hide();

  notetracktoaliasarray = [];
  notetracktoaliasarray["laser_xform_down_sec1_start"] = "laser_xform_down_sec1_start";
  notetracktoaliasarray["laser_xform_down_sec1_end"] = "laser_xform_down_sec1_end";
  notetracktoaliasarray["laser_xform_down_sec2_start"] = "laser_xform_down_sec2_start";
  notetracktoaliasarray["laser_xform_down_sec2_end"] = "laser_xform_down_sec2_end";

  self.lifter ScriptModelPlayAnimDeltaMotion(self.lifter.animDown, "laser_xform_down_sec1_start");
  foreach(part in self.lifter.parts) {
    part ScriptModelPlayAnimDeltaMotion(self.lifter.animDown, "laser_xform_down_sec1_start");
  }
  self.lifter thread snd_play_on_notetrack(notetracktoaliasarray, "laser_xform_down_sec1_start");

  foreach(flap in self.flaps) {
    if(isDefined(flap.targetname) && flap.targetname == "lsr_flap_bottom") {
      flap ScriptModelPlayAnimDeltaMotion(self.flap_animClose);
    } else {
      flap ScriptModelPlayAnim(self.flap_animClose);
    }
  }

  self.lifter thread aud_play_laser_move_down(6);
  self.lifter thread playMovementSparks(2.5);
  self.lifter delayThread(6, ::stopMovementSparks);
  wait(7.8);

  self.moving = false;
  self.locked = false;
}

laser_handleMoveTop() {
  self endon("death");
  self endon("fakedeath");
  level endon("game_ended");

  assert(isDefined(self.lifter));
  foreach(part in self.lifter.parts) {
    assert(isDefined(part));
  }

  self.moving = true;

  notetracktoaliasarray = [];
  notetracktoaliasarray["laser_xform_up_sec1_start"] = "laser_xform_up_sec1_start";
  notetracktoaliasarray["laser_xform_up_sec1_end"] = "laser_xform_up_sec1_end";
  notetracktoaliasarray["laser_xform_up_sec2_start"] = "laser_xform_up_sec2_start";
  notetracktoaliasarray["laser_xform_up_sec2_end"] = "laser_xform_up_sec2_end";

  self.lifter ScriptModelPlayAnimDeltaMotion(self.lifter.animUp, "laser_xform_up_sec1_start");
  foreach(part in self.lifter.parts) {
    part ScriptModelPlayAnimDeltaMotion(self.lifter.animUp, "laser_xform_up_sec1_start");
  }
  self.lifter thread snd_play_on_notetrack(notetracktoaliasarray, "laser_xform_up_sec1_start");

  foreach(flap in self.flaps) {
    if(isDefined(flap.targetname) && flap.targetname == "lsr_flap_bottom") {
      flap ScriptModelPlayAnimDeltaMotion(self.flap_animOpen);
    } else {
      flap ScriptModelPlayAnim(self.flap_animOpen);
    }
  }

  self.lifter thread aud_play_laser_move_up(5.0);
  self.lifter thread playMovementSparks(1.5);
  self.lifter delaythread(5.0, ::stopMovementSparks);
  wait(8);

  self.lifter LinkGeoToTurret(self, false);
  self show();
  self LinkGeoToTurret(self, true);
  self.lifter hide();

  waittillframeend;

  self.moving = false;
}

aud_play_laser_move_up(delay_time) {
  thread snd_play_in_space_delayed("laser_beam_power_up", (15, 382, 902), 5.2);
  thread snd_play_linked("laser_platform_move_up_start", self);
  thread aud_laser_energy_beam_start();
  thread snd_play_loop_in_space("laser_platform_move_alarm_lp", (-1, 355, 945), "aud_stop_laser_alarm", 2);
  wait(delay_time);
  thread snd_play_linked("laser_platform_move_up_end", self);
  level notify("aud_stop_laser_alarm");
}

aud_play_laser_move_down(delay_time) {
  thread snd_play_in_space_delayed("laser_beam_power_down", (15, 382, 902), 1.25);
  thread aud_laser_pre_move_down();
  wait(2.5);
  move_down_sound = thread snd_play_linked("laser_platform_move_down_start", self);
  wait(3);
  thread snd_play_linked("laser_platform_move_down_legs_fold", self);
  move_down_sound scalevolume(0.0, 0.05);
  move_down_sound stopsounds();
  level notify("aud_laser_energy_lp_off");
  wait(0.7);
  thread snd_play_linked("laser_platform_move_down_end", self);
}

aud_laser_pre_move_down() {
  wait(1);
  pre_move_down_sound = thread snd_play_linked("laser_platform_pre_move_down", self);
}

aud_laser_energy_beam_start() {
  thread snd_play_loop_in_space("laser_base_pulse_energy_lp", (-13, 393, 352), "aud_laser_energy_lp_off", 2);
  thread snd_play_loop_in_space("laser_base_pulse_low_lp", (-13, 393, 352), "aud_laser_energy_lp_off", 2);
  thread snd_play_loop_in_space("laser_base_pulse_motor_lp", (-13, 393, 352), "aud_laser_energy_lp_off", 2);
}

playMovementSparks(waitTime) {
  wait waitTime;

  foreach(part in self.parts) {
    if(part.model == "mp_sky_laser_turret_lega") {
      playFXOnTag(level.laser_fx["laser_movement_sparks"], part, "fx_joint_0");
    }
  }
}

stopMovementSparks() {
  foreach(part in self.parts) {
    if(part.model == "mp_sky_laser_turret_lega") {
      stopFXOnTag(level.laser_fx["laser_movement_sparks"], part, "fx_joint_0");
    }
  }
}

player_sentry_timeOut(player) {
  self endon("death");
  self endon("fakedeath");
  level endon("game_ended");

  player endon("disconnect");
  player endon("joined_team");
  player endon("joined_spectators");

  lifeSpan = level.sentrySettings[self.sentryType].timeOut;

  while(lifeSpan) {
    wait(1.0);
    maps\mp\gametypes\_hostmigration::waitTillHostMigrationDone();

    lifeSpan = max(0, lifeSpan - 1.0);
  }

  if(isDefined(player)) {
    self.ownerList = array_removeFirstInQueue(self.ownerList, player);

    if(self.ownerList.size != 0) {
      player thread leaderDialogOnPlayer(level.sentrySettings[level.sentryGun.sentryType].vopower);
      self thread stopLaserContainmentSwap();
    } else {
      player thread leaderDialogOnPlayer(level.sentrySettings[level.sentryGun.sentryType].voOffline);
      self notify("fakedeath");
    }
  }
}

laser_setActive(player) {
  foreach(player in level.players) {
    entNum = self GetEntityNumber();
    self maps\mp\killstreaks\_autosentry::addToTurretList(entNum);
  }

  if(self.shouldSplash) {
    level thread maps\mp\_utility::teamPlayerCardSplash(level.sentrySettings[self.sentryType].teamSplash, self.owner, self.owner.team);
    self.shouldSplash = false;
  }

  self laser_coreDamage_activated(self.coreDamageTrig);
  self laser_coreDamage_activated(self.coreDeathTrig, true);
  self laser_handleMoveTop();

  self SetDefaultDropPitch(LASER_DROP_PITCH_ONLINE);
  self SetMode(level.sentrySettings[self.sentryType].sentryModeOn);
  self.mode = "on";

  self laser_usableOffSwitch_on();

  if(level.sentrySettings[self.sentryType].headIcon) {
    if(level.teamBased) {
      self setTeamHeadIcon_large(self.team, (0, 0, 400));
    } else {
      self setTeamHeadIcon_large(self.team, (0, 0, 400));
    }
  }

  self thread laser_attackTargets();
  self thread laser_watchDisabled();
}

laser_usableOffSwitch_off() {
  self.GeneratorHat ScriptModelPlayAnim(self.GeneratorHat.anim_down);

  level.sentryGun.offSwitch["use_zone"] maps\mp\gametypes\_gameobjects::disableObject();
  level.sentryGun.offSwitch["switch_obj"] hide();
}

laser_usableOffSwitch_on() {
  laserOwner = "none";
  if(isDefined(level.sentryGun.owner) && isDefined(level.sentryGun.owner.team)) {
    laserOwner = level.sentryGun.owner.team;
  }
  self.GeneratorHat ScriptModelPlayAnim(self.GeneratorHat.anim_up);

  level.sentryGun.offSwitch["use_zone"].interactTeam = "enemy";
  level.sentryGun.offSwitch["use_zone"] maps\mp\gametypes\_gameobjects::setOwnerTeam(laserOwner);

  foreach(player in level.players) {
    if(player.team != laserOwner && laserOwner != "none") {
      player.laserOffSwitch_isVisible = true;
      level.sentryGun.offSwitch["switch_obj"] showtoplayer(player);
    }
  }
}

setTeamHeadIcon_large(team, offset) {
  if(!level.teamBased) {
    return;
  }

  if(!isDefined(self.entityHeadIconTeam)) {
    self.entityHeadIconTeam = "none";
    self.entityHeadIcon = undefined;
  }

  shader = game["entity_headicon_" + team];

  self.entityHeadIconTeam = team;

  if(isDefined(offset)) {
    self.entityHeadIconOffset = offset;
  } else {
    self.entityHeadIconOffset = (0, 0, 0);
  }

  self notify("kill_entity_headicon_thread");

  if(team == "none") {
    if(isDefined(self.entityHeadIcon)) {
      self.entityHeadIcon destroy();
    }
    return;
  }

  headIcon = newTeamHudElem(team);
  headIcon.archived = true;
  headIcon.x = self.origin[0] + self.entityHeadIconOffset[0];
  headIcon.y = self.origin[1] + self.entityHeadIconOffset[1];
  headIcon.z = self.origin[2] + self.entityHeadIconOffset[2];
  headIcon.alpha = 1;
  headIcon setShader(shader, 50, 50);
  headIcon setWaypoint(false, false, false, true);
  self.entityHeadIcon = headIcon;

  self thread maps\mp\_entityheadicons::keepIconPositioned();
  self thread maps\mp\_entityheadicons::destroyHeadIconsOnDeath();
}

setPlayerHeadIcon_large(player, offset) {
  if(level.teamBased) {
    return;
  }

  if(!isDefined(self.entityHeadIconTeam)) {
    self.entityHeadIconTeam = "none";
    self.entityHeadIcon = undefined;
  }

  self notify("kill_entity_headicon_thread");

  if(!isDefined(player)) {
    if(isDefined(self.entityHeadIcon)) {
      self.entityHeadIcon destroy();
    }
    return;
  }

  team = player.team;
  self.entityHeadIconTeam = team;

  if(isDefined(offset)) {
    self.entityHeadIconOffset = offset;
  } else {
    self.entityHeadIconOffset = (0, 0, 0);
  }

  shader = game["entity_headicon_" + team];

  headIcon = newClientHudElem(player);
  headIcon.archived = true;
  headIcon.x = self.origin[0] + self.entityHeadIconOffset[0];
  headIcon.y = self.origin[1] + self.entityHeadIconOffset[1];
  headIcon.z = self.origin[2] + self.entityHeadIconOffset[2];
  headIcon.alpha = 1;
  headIcon setShader(shader, 50, 50);
  headIcon setWaypoint(false, false, false, true);
  self.entityHeadIcon = headIcon;

  self thread maps\mp\_entityheadicons::keepIconPositioned();
  self thread maps\mp\_entityheadicons::destroyHeadIconsOnDeath();
}

laser_watchDisabled() {
  self endon("death");
  self endon("fakedeath");
  level endon("game_ended");

  self notify("laser_watchDisabled");
  self endon("laser_watchDisabled");

  while(true) {
    self waittill("emp_damage", attacker, duration);

    playFXOnTag(common_scripts\utility::getfx("sentry_explode_mp"), self, "tag_aim");

    self SetDefaultDropPitch(LASER_DROP_PITCH_OFFLINE);
    self SetMode(level.sentrySettings[self.sentryType].sentryModeOff);
    self.mode = "none";

    wait(duration);

    self SetDefaultDropPitch(LASER_DROP_PITCH_ONLINE);
    self SetMode(level.sentrySettings[self.sentryType].sentryModeOn);
    self.mode = "on";
  }
}

laser_attackTargets() {
  self endon("death");
  self endon("fakedeath");
  level endon("game_ended");

  self notify("laser_attackTargets");
  self endon("laser_attackTargets");

  self.samTargetEnt = undefined;
  self.samMissileGroups = [];

  while(true) {
    self.samTargetEnt = maps\mp\killstreaks\_autosentry::sam_acquireTarget();
    self laser_fireOnTarget();
    wait(0.05);
  }
}

laser_watchLightBeam() {
  self endon("death");
  level endon("game_ended");

  wait(0.5);

  if(!isDefined(self.ownerList) || self.ownerList.size < 1) {
    return;
  }

  fxId = self.ownerList.size;

  playFXOnTag(level.laser_fx["laser_charge1"], self.FxEnts["charge_up"], "tag_origin");
  playFXOnTag(level.laser_fx["beahm"], self, "tag_laser");
  self laser_coreDamage_activated(self.firingDamageTrig);
  fire_start_sfx = snd_play_linked("wpn_skylaser_fire_startup", self);
  self thread play_loop_sound_on_entity("wpn_skylaser_beam_lp");

  self LaserOn("mp_laser2_laser");

  while(isDefined(self.samTargetEnt) && isDefined(self GetTurretTarget(true)) && self GetTurretTarget(true) == self.samTargetEnt) {
    wait(0.05);
  }

  self LaserOff();

  stopFXOnTag(level.laser_fx["laser_charge1"], self.FxEnts["charge_up"], "tag_origin");
  playFXOnTag(level.laser_fx["laser_beam_done1"], self.FxEnts["charge_up"], "tag_origin");
  stopFXOnTag(level.laser_fx["beahm"], self, "tag_laser");
  playFXOnTag(level.laser_fx["beahm_smoke"], self, "tag_laser");
  self laser_coreDamage_deactivated(self.firingDamageTrig);
  self stop_loop_sound_on_entity("wpn_skylaser_beam_lp");
  fire_stop_sfx = snd_play_linked("wpn_skylaser_beam_stop", self);
  if(isDefined(fire_start_sfx)) {
    fire_start_sfx StopSounds();
  }
}

laser_fireOnTarget() {
  self endon("death");
  self endon("fakedeath");
  level endon("game_ended");

  if(isDefined(self.samTargetEnt)) {
    if(isDefined(level.orbitalsupport_planeModel) && self.samTargetEnt == level.orbitalsupport_planeModel && !isDefined(level.orbitalsupport_player)) {
      self.samTargetEnt = undefined;
      self ClearTargetEntity();
      return;
    }

    self SetTargetEntity(self.samTargetEnt);
    self waittill("turret_on_target");
    if(!isDefined(self.samTargetEnt)) {
      return;
    }

    if(!self.laser_on) {
      self thread laser_watchLightBeam();
      self thread maps\mp\killstreaks\_autosentry::sam_watchLaser();
      self thread maps\mp\killstreaks\_autosentry::sam_watchCrashing();
      self thread maps\mp\killstreaks\_autosentry::sam_watchLeaving();
      self thread maps\mp\killstreaks\_autosentry::sam_watchLineOfSight();
    }

    wait(0.5);

    if(!isDefined(self.samTargetEnt)) {
      return;
    }

    if(isDefined(level.orbitalsupport_planeModel) && self.samTargetEnt == level.orbitalsupport_planeModel && !isDefined(level.orbitalsupport_player)) {
      self.samTargetEnt = undefined;
      self ClearTargetEntity();
      return;
    }

    self ShootTurret();

    self fireLaserBeam();
  }
}

fireLaserBeam() {
  self endon("death");
  self endon("fakedeath");
  level endon("game_ended");

  trace_start = self GetTagOrigin("tag_laser");
  trace_vector = anglesToForward(self GetTagAngles("tag_laser"));
  trace_end = trace_start + 15000 * trace_vector;
  LaserTraceData = bulletTrace(trace_start, trace_end, true, self);

  if(isDefined(level.orbitalSupport_planemodel) && self.samTargetEnt == level.orbitalSupport_planemodel && isDefined(level.orbitalSupport_player)) {
    RadiusDamage(level.orbitalSupport_planemodel.origin, 512, 100, 100, self.owner, "MOD_EXPLOSIVE", "killstreak_laser2_mp");
  } else if(isDefined(self.samTargetEnt.isPodRocket) && self.samTargetEnt.isPodRocket) {
    self.samTargetEnt notify("damage", 1000, self.owner, undefined, undefined, "mod_explosive", undefined, undefined, undefined, undefined, "killstreak_laser2_mp");
  } else {
    RadiusDamage(LaserTraceData["position"], 512, 200, 200, self.owner, "MOD_EXPLOSIVE", "killstreak_laser2_mp");
  }
}

laser_coreDamage_activated(trig, b_kill) {
  level endon("game_ended");

  self thread watchPlayerEnterLaserCore(trig, b_kill);
  trig trigger_on();
}

laser_coreDamage_deactivated(trig) {
  level endon("game_ended");

  trig notify("laser_coreDamage_deactivated");

  trig trigger_off();
}

watchPlayerEnterLaserCore(trig, b_kill) {
  level endon("game_ended");
  trig endon("laser_coreDamage_deactivated");

  while(true) {
    trig waittill("trigger", player);
    if(!isPlayer(player)) {
      continue;
    }

    if(!isAlive(player)) {
      continue;
    }

    if(isDefined(player.laserCoreTrigIDs) && isDefined(player.laserCoreTrigIDs[trig.targetname]) && player.laserCoreTrigIDs[trig.targetname] == 1) {
      continue;
    } else {
      if(!isDefined(player.laserCoreTrigIDs)) {
        player.laserCoreTrigIDs = [];
      }

      player.laserCoreTrigIDs[trig.targetname] = 1;
      player thread player_laserCoreEffect(trig, b_kill);

      if(IsAlive(player)) {
        player thread player_watchExitLaserCore(trig);
        player thread player_watchDeath(trig);
      } else {
        player.laserCoreTrigIDs[trig.targetname] = 0;
      }
    }
  }
}

player_watchExitLaserCore(trig) {
  level endon("game_ended");
  self endon("player_leftLaserCoreTrigger" + trig.targetname);
  self endon("stop_watching_trig");

  while(self isTouching(trig)) {
    wait(.05);
  }

  if(isDefined(self.laserCoreTrigIDs)) {
    self.laserCoreTrigIDs[trig.targetname] = 0;
  }
  self player_resetLaserCoreValues();
  self notify("player_leftLaserCoreTrigger" + trig.targetname);
}

player_laserCoreEffect(trig, b_kill) {
  level endon("game_ended");
  self endon("player_leftLaserCoreTrigger" + trig.targetname);
  self endon("stop_watching_trig");

  if(isDefined(b_kill) && b_kill) {
    self _suicide();
    return;
  }

  self.poison = 0;
  shellshockName = level.sentrySettings[level.sentryGun.sentryType].coreShellshock;

  if(!isDefined(self.usingRemote) && !isDefined(self.rideVisionSet)) {
    self VisionSetNakedForPlayer("aftermath", .5);
    self shellshock(shellshockName, 60);
  } else {
    self.laserCoreVisualsBlocked = true;
  }

  while(1) {
    self.poison++;

    switch (self.poison) {
      case 1:
        self ViewKick(1, self.origin);
        break;
      case 2:
        self ViewKick(3, self.origin);
        self player_doLaserCoreDamage(15);
        break;
      case 3:
        self ViewKick(15, self.origin);
        self player_doLaserCoreDamage(15);
        break;
      case 4:
        self ViewKick(75, self.origin);
        self _suicide();
        return;
    }
    wait(1);
  }
}

player_watchDeath(trig) {
  level endon("game_ended");
  self endon("player_leftLaserCoreTrigger" + trig.targetname);

  self common_scripts\utility::waittill_any("disconnect", "joined_team", "joined_spectators", "death");

  self.laserCoreTrigIDs = undefined;
  self player_resetLaserCoreValues();
  self notify("stop_watching_trig");
}

player_resetLaserCoreValues() {
  if(!isDefined(self.laserCoreVisualsBlocked)) {
    self stopShellShock();
    self thread revertVisionSetForPlayer(.5);
  }
  self.laserCoreVisualsBlocked = undefined;
}

laserlightfill() {
  playFXOnTag(getFx("light_laser_fill"), self, "tag_origin");
}

player_doLaserCoreDamage(iDamage) {
  if(!isDefined(level.sentryGun.owner)) {
    return;
  }

  self thread[[level.callbackPlayerDamage]](
    self, level.sentryGun.owner, iDamage, 0, "MOD_TRIGGER_HURT", "mp_laser2_core", self.origin, (0, 0, 0) - self.origin, "none", 0
  );
}

handleDamageFeedbackSound(killer_ent) {}