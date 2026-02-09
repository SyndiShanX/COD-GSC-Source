/****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\killstreaks\_ims.gsc
****************************************/

#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
#include common_scripts\utility;

KS_ATTACH = "_attach";
CONST_NUM_LID_ON_MODEL = 4;

init() {
  level.killStreakFuncs["ims"] = ::tryUseIMS;

  level.imsSettings = [];

  config = spawnStruct();
  config.weaponInfo = "ims_projectile_mp";
  config.modelBase = "ims_scorpion_body_iw6";
  config.modelPlacement = "ims_scorpion_body_iw6_placement";
  config.modelPlacementFailed = "ims_scorpion_body_iw6_placement_failed";
  config.modelDestroyed = "ims_scorpion_body_iw6";
  config.modelBombSquad = "ims_scorpion_body_iw6_bombsquad";
  config.hintString = &"KILLSTREAKS_HINTS_IMS_PICKUP_TO_MOVE";
  config.placeString = &"KILLSTREAKS_HINTS_IMS_PLACE";
  config.cannotPlaceString = &"KILLSTREAKS_HINTS_IMS_CANNOT_PLACE";
  config.streakName = "ims";
  config.splashName = "used_ims";
  config.maxHealth = 1000;
  config.lifeSpan = 90.0;
  config.rearmTime = 0.5;
  config.gracePeriod = 0.4;
  config.numExplosives = 4;
  config.explosiveModel = "ims_scorpion_explosive_iw6";
  config.placementHeightTolerance = 30.0;
  config.placementRadius = 24.0;

  config.lidTagRoot = "tag_lid";

  config.lidOpenAnims = [];
  config.lidOpenAnims[1] = "IMS_Scorpion_door_1";
  config.lidOpenAnims[2] = "IMS_Scorpion_door_2";
  config.lidOpenAnims[3] = "IMS_Scorpion_door_3";
  config.lidOpenAnims[4] = "IMS_Scorpion_door_4";

  config.lidSnapOpenAnims = [];
  config.lidSnapOpenAnims[1] = "IMS_Scorpion_1_opened";
  config.lidSnapOpenAnims[2] = "IMS_Scorpion_2_opened";
  config.lidSnapOpenAnims[3] = "IMS_Scorpion_3_opened";

  config.explTagRoot = "tag_explosive";

  config.killCamOffset = (0, 0, 12);

  level.imsSettings["ims"] = config;

  level._effect["ims_explode_mp"] = LoadFX("vfx/gameplay/mp/killstreaks/vfx_ims_explosion");
  level._effect["ims_smoke_mp"] = LoadFX("vfx/gameplay/mp/killstreaks/vfx_sg_damage_blacksmoke");

  level._effect["ims_sensor_explode"] = LoadFX("vfx/gameplay/mp/killstreaks/vfx_ims_sparks");
  level._effect["ims_antenna_light_mp"] = LoadFX("vfx/gameplay/mp/killstreaks/vfx_light_detonator_blink");

  level.placedIMS = [];

  SetDevDvarIfUninitialized("scr_ims_timeout", config.lifeSpan);
  SetDevDvarIfUninitialized("scr_ims_debug_draw", "0");
}

tryUseIMS(lifeId, streakName) {
  prevIMSList = [];
  if(isDefined(self.imsList))
    prevIMSList = self.imsList;

  result = self giveIMS("ims");

  if(!isDefined(result)) {
    result = false;

    if(isDefined(self.imsList)) {
      if(!prevIMSList.size && self.imsList.size)
        result = true;
      if(prevIMSList.size && prevIMSList[0] != self.imsList[0])
        result = true;
    }
  }

  if(result) {
    self maps\mp\_matchdata::logKillstreakEvent(level.imsSettings["ims"].streakName, self.origin);
  }

  self.isCarrying = false;

  return (result);
}

giveIMS(imsType) {
  imsForPlayer = createIMSForPlayer(imsType, self);

  self removePerks();

  self.carriedIMS = imsForPlayer;
  imsForPlayer.firstPlacement = true;

  result = self setCarryingIMS(imsForPlayer, true);

  self.carriedIMS = undefined;

  self thread restorePerks();

  return result;
}

setCarryingIMS(imsForPlayer, allowCancel) {
  self endon("death");
  self endon("disconnect");

  assert(isReallyAlive(self));

  imsForPlayer thread ims_setCarried(self);

  self _disableWeapon();

  if(!IsAI(self)) {
    self notifyOnPlayerCommand("place_ims", "+attack");
    self notifyOnPlayerCommand("place_ims", "+attack_akimbo_accessible");
    self notifyOnPlayerCommand("cancel_ims", "+actionslot 4");
    if(!level.console) {
      self notifyOnPlayerCommand("cancel_ims", "+actionslot 5");
      self notifyOnPlayerCommand("cancel_ims", "+actionslot 6");
      self notifyOnPlayerCommand("cancel_ims", "+actionslot 7");
    }
  }

  for(;;) {
    if(is_aliens())
      result = waittill_any_return("place_ims", "cancel_ims", "force_cancel_placement", "player_action_slot_restart");
    else
      result = waittill_any_return("place_ims", "cancel_ims", "force_cancel_placement");

    if(result == "cancel_ims" || result == "force_cancel_placement" || result == "player_action_slot_restart") {
      if(!allowCancel && result == "cancel_ims") {
        continue;
      }
      if(level.console) {
        killstreakWeapon = getKillstreakWeapon(level.imsSettings[imsForPlayer.imsType].streakName);
        if(isDefined(self.killstreakIndexWeapon) && killstreakWeapon == getKillstreakWeapon(self.pers["killstreaks"][self.killstreakIndexWeapon].streakName) && !(self GetWeaponsListItems()).size) {
          self _giveWeapon(killstreakWeapon, 0);
          self _setActionSlot(4, "weapon", killstreakWeapon);
        }
      }

      imsForPlayer ims_setCancelled(result == "force_cancel_placement" && !isDefined(imsForPlayer.firstPlacement));
      return false;
    }

    if(!imsForPlayer.canBePlaced) {
      continue;
    }
    imsForPlayer thread ims_setPlaced();
    self notify("IMS_placed");
    self _enableWeapon();
    return true;
  }
}

removeWeapons() {
  if(self HasWeapon("iw6_riotshield_mp")) {
    self.restoreWeapon = "iw6_riotshield_mp";
    self takeWeapon("iw6_riotshield_mp");
  }
}

removePerks() {
  if(self _hasPerk("specialty_explosivebullets")) {
    self.restorePerk = "specialty_explosivebullets";
    self _unsetPerk("specialty_explosivebullets");
  }
}

restoreWeapons() {
  if(isDefined(self.restoreWeapon)) {
    self _giveWeapon(self.restoreWeapon);
    self.restoreWeapon = undefined;
  }
}

restorePerks() {
  if(isDefined(self.restorePerk)) {
    self givePerk(self.restorePerk, false);
    self.restorePerk = undefined;
  }
}

waitRestorePerks() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  wait(0.05);
  self restorePerks();
}

createIMSForPlayer(imsType, owner) {
  assertEx(isDefined(owner), "createIMSForPlayer() called without owner specified");

  if(isDefined(owner.isCarrying) && owner.isCarrying) {
    return;
  }
  ims = SpawnTurret("misc_turret", owner.origin + (0, 0, 25), "sentry_minigun_mp");

  ims.angles = owner.angles;
  ims.imsType = imsType;
  ims.owner = owner;

  ims setModel(level.imsSettings[imsType].modelBase);

  ims MakeTurretInoperable();
  ims SetTurretModeChangeWait(true);
  ims SetMode("sentry_offline");
  ims MakeUnusable();
  ims SetSentryOwner(owner);

  return ims;
}

createIMS(carriedIMS) {
  owner = carriedIMS.owner;
  imsType = carriedIMS.imsType;

  ims = spawn("script_model", carriedIMS.origin);
  ims setModel(level.imsSettings[imsType].modelBase);
  ims.scale = 3;
  ims.angles = carriedIMS.angles;
  ims.imsType = imsType;
  ims.owner = owner;
  ims SetOtherEnt(owner);
  ims.team = owner.team;
  ims.shouldSplash = false;
  ims.hidden = false;
  ims.attacks = 1;

  ims DisableMissileStick();

  ims.hasExplosiveFired = [];
  ims.config = level.imsSettings[imsType];

  ims thread ims_handleUse();
  ims thread ims_timeOut();
  ims thread ims_createBombSquadModel();
  ims thread ims_onKillstreakDisowned();

  return ims;
}

ims_createBombSquadModel() {
  bombSquadModel = spawn("script_model", self.origin);
  bombSquadModel.angles = self.angles;
  bombSquadModel hide();

  bombSquadModel thread maps\mp\gametypes\_weapons::bombSquadVisibilityUpdater(self.owner);
  bombSquadModel setModel(level.imsSettings[self.imsType].modelBombSquad);
  bombSquadModel LinkTo(self);
  bombSquadModel SetContents(0);
  self.bombSquadModel = bombSquadModel;

  self waittill("death");

  if(isDefined(bombSquadModel)) {
    bombSquadModel delete();
  }
}

ims_moving_platform_death(data) {
  self.immediateDeath = true;
  self notify("death");
}

ims_handleDamage() {
  self endon("carried");

  self maps\mp\gametypes\_damage::monitorDamage(self.config.maxHealth, "ims", ::ims_HandleDeathDamage, ::ims_ModifyDamage, true);
}

ims_ModifyDamage(attacker, weapon, type, damage) {
  if(self.hidden || weapon == "ims_projectile_mp") {
    return -1;
  }

  modifiedDamage = damage;

  if(type == "MOD_MELEE") {
    modifiedDamage = self.maxhealth * 0.25;
  }

  if(IsExplosiveDamageMOD(type)) {
    modifiedDamage = damage * 1.5;
  }

  modifiedDamage = self maps\mp\gametypes\_damage::handleMissileDamage(weapon, type, modifiedDamage);
  modifiedDamage = self maps\mp\gametypes\_damage::handleAPDamage(weapon, type, modifiedDamage, attacker);

  return modifiedDamage;
}

ims_HandleDeathDamage(attacker, weapon, type, damage) {
  notifyAttacker = self maps\mp\gametypes\_damage::onKillstreakKilled(attacker, weapon, type, damage, "destroyed_ims", "ims_destroyed");

  if(notifyAttacker) {
    attacker notify("destroyed_equipment");
  }
}

ims_handleDeath() {
  self endon("carried");

  self waittill("death");

  self removeFromIMSList();

  if(!isDefined(self)) {
    return;
  }
  self ims_setInactive();

  self playSound("ims_destroyed");

  if(isDefined(self.inUseBy)) {
    playFX(getfx("ims_explode_mp"), self.origin + (0, 0, 10));
    playFX(getfx("ims_smoke_mp"), self.origin);

    self.inUseBy restorePerks();
    self.inUseBy restoreWeapons();

    self notify("deleting");
    wait(1.0);
  } else if(isDefined(self.immediateDeath)) {
    playFX(getfx("ims_explode_mp"), self.origin + (0, 0, 10));
    self notify("deleting");
  } else {
    playFX(getfx("ims_explode_mp"), self.origin + (0, 0, 10));

    playFX(getfx("ims_smoke_mp"), self.origin);
    wait(3.0);
    self playSound("ims_fire");

    self notify("deleting");
  }

  if(isDefined(self.objIdFriendly))
    _objective_delete(self.objIdFriendly);

  if(isDefined(self.objIdEnemy))
    _objective_delete(self.objIdEnemy);

  self maps\mp\gametypes\_weapons::equipmentDeleteVfx();

  self EnableMissileStick();

  self delete();
}

watchEMPDamage() {
  self endon("carried");
  self endon("death");
  level endon("game_ended");

  while(true) {
    self waittill("emp_damage", attacker, duration);

    self maps\mp\gametypes\_weapons::stopBlinkingLight();

    playFX(getfx("emp_stun"), self.origin);
    playFX(getfx("ims_smoke_mp"), self.origin);

    wait(duration);

    self ims_Start();
  }
}

ims_handleUse() {
  self endon("death");
  level endon("game_ended");

  for(;;) {
    self waittill("trigger", player);

    assert(player == self.owner);
    assert(!isDefined(self.carriedBy));

    if(!isReallyAlive(player)) {
      continue;
    }
    if(self.damageTaken >= self.maxHealth) {
      continue;
    }
    if(is_aliens() && isDefined(level.drill_carrier) && player == level.drill_carrier) {
      continue;
    }
    imsForPlayer = createIMSForPlayer(self.imsType, player);

    if(!isDefined(imsForPlayer))
      continue;
    imsForPlayer.ims = self;
    self ims_setInactive();
    self ims_hideAllParts();

    if(isDefined(self GetLinkedParent())) {
      self Unlink();
    }

    player setCarryingIMS(imsForPlayer, false);
  }
}

ims_setPlaced() {
  self endon("death");
  level endon("game_ended");

  if(isDefined(self.carriedBy))
    self.carriedBy forceUseHintOff();
  self.carriedBy = undefined;

  if(isDefined(self.owner))
    self.owner.isCarrying = false;

  self.firstPlacement = undefined;

  ims = undefined;
  if(isDefined(self.ims)) {
    ims = self.ims;
    ims endon("death");
    ims.origin = self.origin;
    ims.angles = self.angles;
    ims.carriedBy = undefined;
    ims ims_showAllParts();
    if(isDefined(ims.bombSquadModel)) {
      ims.bombSquadModel Show();
      ims imsOpenAllDoors(ims.bombSquadModel, true);
      level notify("update_bombsquad");
    }
  } else {
    ims = createIMS(self);
  }

  ims addToIMSList();

  ims.isPlaced = true;

  ims thread ims_handleDamage();
  ims thread watchEmpDamage();
  ims thread ims_handleDeath();

  ims setCanDamage(true);
  self playSound("ims_plant");

  self notify("placed");
  ims thread ims_setActive();

  data = spawnStruct();
  if(isDefined(self.moving_platform)) {
    data.linkparent = self.moving_platform;
  }
  data.endonString = "carried";
  data.deathOverrideCallback = ::ims_moving_platform_death;
  ims thread maps\mp\_movers::handle_moving_platforms(data);

  self delete();
}

ims_setCancelled(playDestroyVfx) {
  if(isDefined(self.carriedBy)) {
    owner = self.carriedBy;
    owner ForceUseHintOff();
    owner.isCarrying = undefined;

    owner.carriedItem = undefined;

    owner _enableWeapon();

    if(isDefined(owner.imsList)) {
      foreach(ims in owner.imsList) {
        if(isDefined(ims.bombSquadModel))
          ims.bombSquadModel delete();
      }
    }
  }

  if(isDefined(playDestroyVfx) && playDestroyVfx) {
    self maps\mp\gametypes\_weapons::equipmentDeleteVfx();
  }

  self delete();
}

ims_setCarried(carrier) {
  assert(isPlayer(carrier));
  assertEx(carrier == self.owner, "ims_setCarried() specified carrier does not own this ims");

  self removeFromIMSList();

  self setModel(level.imsSettings[self.imsType].modelPlacement);

  self SetSentryCarrier(carrier);
  self SetContents(0);
  self setCanDamage(false);

  self.carriedBy = carrier;
  carrier.isCarrying = true;

  carrier thread updateIMSPlacement(self);

  self thread ims_onCarrierDeath(carrier);
  self thread ims_onCarrierDisconnect(carrier);
  self thread ims_onGameEnded();
  self thread ims_onEnterRide(carrier);
  if(is_aliens() && isDefined(level.drop_ims_when_grabbed_func))
    self thread[[level.drop_ims_when_grabbed_func]](carrier);

  self notify("carried");

  if(isDefined(self.ims)) {
    self.ims notify("carried");
    self.ims.carriedBy = carrier;
    self.ims.isPlaced = false;

    if(isDefined(self.ims.bombSquadModel))
      self.ims.bombSquadModel Hide();
  }
}

updateIMSPlacement(ims) {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");

  ims endon("placed");
  ims endon("death");

  ims.canBePlaced = true;
  lastCanPlaceIMS = -1;

  config = level.imsSettings[ims.imsType];

  for(;;) {
    placement = self CanPlayerPlaceSentry(true, config.placementRadius);

    ims.origin = placement["origin"];
    ims.angles = placement["angles"];
    ims.canBePlaced = self isOnGround() && placement["result"] && (abs(ims.origin[2] - self.origin[2]) < config.placementHeightTolerance);

    if(isDefined(placement["entity"])) {
      ims.moving_platform = placement["entity"];
    } else {
      ims.moving_platform = undefined;
    }

    if(ims.canBePlaced != lastCanPlaceIMS) {
      if(ims.canBePlaced) {
        ims setModel(level.imsSettings[ims.imsType].modelPlacement);
        self ForceUseHintOn(level.imsSettings[ims.imsType].placeString);
      } else {
        ims setModel(level.imsSettings[ims.imsType].modelPlacementFailed);
        self ForceUseHintOn(level.imsSettings[ims.imsType].cannotPlaceString);
      }
    }

    lastCanPlaceIMS = ims.canBePlaced;
    wait(0.05);
  }
}

ims_onCarrierDeath(carrier) {
  self endon("placed");
  self endon("death");
  carrier endon("disconnect");

  carrier waittill("death");

  if(self.canBePlaced && carrier.team != "spectator")
    self thread ims_setPlaced();
  else
    self ims_setCancelled();
}

ims_onCarrierDisconnect(carrier) {
  self endon("placed");
  self endon("death");

  carrier waittill("disconnect");

  self ims_setCancelled();
}

ims_onEnterRide(carrier) {
  self endon("placed");
  self endon("death");

  for(;;) {
    if(isDefined(self.carriedBy.OnHeliSniper) && self.carriedBy.OnHeliSniper) {
      self notify("death");
    }
    wait 0.1;
  }
}

ims_onGameEnded(carrier) {
  self endon("placed");
  self endon("death");

  level waittill("game_ended");

  self ims_setCancelled();
}

ims_setActive() {
  self setCursorHint("HINT_NOICON");
  self setHintString(level.imsSettings[self.imsType].hintString);

  owner = self.owner;
  owner ForceUseHintOff();
  if(!is_aliens()) {
    if(level.teamBased)
      self maps\mp\_entityheadicons::setTeamHeadIcon(self.team, (0, 0, 60));
    else
      self maps\mp\_entityheadicons::setPlayerHeadIcon(owner, (0, 0, 60));
  }
  self MakeUsable();
  self setCanDamage(true);
  self maps\mp\gametypes\_weapons::makeExplosiveTargetableByAI();

  if(isDefined(owner.imsList)) {
    foreach(ims in owner.imsList) {
      if(ims == self) {
        continue;
      }
      ims notify("death");
    }
  }
  owner.imsList = [];
  owner.imsList[0] = self;

  foreach(player in level.players) {
    if(player == owner)
      self enablePlayerUse(player);
    else
      self disablePlayerUse(player);
  }

  if(self.shouldSplash) {
    level thread teamPlayerCardSplash(level.imsSettings[self.imsType].splashName, owner);
    self.shouldSplash = false;
  }

  positionOffset = (0, 0, 20);
  traceOffset = (0, 0, 256) - positionOffset;
  results = [];

  self.killcam_ents = [];
  for(i = 0; i < self.config.numExplosives; i++) {
    if(numExplosivesExceedModelCapacity())
      TagIndex = shiftIndexForward(i + 1, self.config.numExplosives - CONST_NUM_LID_ON_MODEL);
    else
      TagIndex = i + 1;

    tag_origin = self GetTagOrigin(self.config.explTagRoot + TagIndex + KS_ATTACH);
    tag_origin_with_pos_offset = self GetTagOrigin(self.config.explTagRoot + TagIndex + KS_ATTACH) + positionOffset;
    results[i] = bulletTrace(tag_origin_with_pos_offset, tag_origin_with_pos_offset + traceOffset, false, self);

    if(i < CONST_NUM_LID_ON_MODEL) {
      killcam_ent = spawn("script_model", tag_origin + self.config.killCamOffset);
      killcam_ent SetScriptMoverKillCam("explosive");
      self.killcam_ents[self.killcam_ents.size] = killcam_ent;
    }
  }

  lowestZ = results[0];
  for(i = 0; i < results.size; i++) {
    if(results[i]["position"][2] < lowestZ["position"][2])
      lowestZ = results[i];
  }

  self.attackHeightPos = lowestZ["position"] - (0, 0, 20) - self.origin;

  attackTrigger = spawn("trigger_radius", self.origin, 0, 256, 100);
  self.attackTrigger = attackTrigger;
  self.attackTrigger EnableLinkTo();
  self.attackTrigger LinkTo(self);

  self.attackMoveTime = Length(self.attackHeightPos) / 200;

  self imsCreateExplosiveWithKillCam();

  self ims_Start();
  self thread ims_WatchPlayerConnected();

  foreach(player in level.players)
  self thread ims_playerJoinedTeam(player);

  self thread debug_draw();
}

debug_draw() {
  self endon("death");

  while(true) {
    if(GetDvarInt("scr_ims_debug_draw") != 0) {
      if(isDefined(self.attackTrigger))
        draw_volume(self.attackTrigger, 1.0, (0, 0, 1));

      foreach(player in level.players) {
        if(player.team == self.team) {
          continue;
        }
        start = self.attackHeightPos + self.origin;
        end = player.origin + (0, 0, 50);
        result = bulletTrace(start, end, false, self);
        Print3d(start, result["surfacetype"], (1, 1, 1), 1, 1, 10);
        drawLine(start, end, 1.0, (1, 0, 0));
      }
    }

    wait(1.0);
  }
}

ims_WatchPlayerConnected() {
  self endon("death");

  while(true) {
    level waittill("connected", player);
    self ims_playerConnected(player);
  }
}

ims_playerConnected(player) {
  self endon("death");
  player endon("disconnect");

  player waittill("spawned_player");

  self DisablePlayerUse(player);
}

ims_playerJoinedTeam(player) {
  self endon("death");
  player endon("disconnect");

  while(true) {
    player waittill("joined_team");

    self DisablePlayerUse(player);
  }
}

ims_onKillstreakDisowned() {
  self endon("death");
  level endon("game_ended");

  self.owner waittill("killstreak_disowned");

  if(isDefined(self.isPlaced)) {
    self notify("death");
  } else {
    self ims_setCancelled(false);
  }
}

ims_Start() {
  self thread maps\mp\gametypes\_weapons::doBlinkingLight("tag_fx");
  self thread ims_attackTargets();
}

ims_setInactive() {
  self MakeUnusable();
  self FreeEntitySentient();

  if(level.teamBased)
    self maps\mp\_entityheadicons::setTeamHeadIcon("none", (0, 0, 0));
  else if(isDefined(self.owner))
    self maps\mp\_entityheadicons::setPlayerHeadIcon(undefined, (0, 0, 0));

  if(isDefined(self.attackTrigger))
    self.attackTrigger delete();

  if(isDefined(self.killcam_ents)) {
    foreach(ent in self.killcam_ents) {
      if(isDefined(ent)) {
        if(isDefined(self.owner) && isDefined(self.owner.imsKillCamEnt) && ent == self.owner.imsKillCamEnt)
          continue;
        else
          ent Delete();
      }
    }
  }

  if(isDefined(self.explosive1)) {
    self.explosive1 Delete();
    self.explosive1 = undefined;
  }

  self maps\mp\gametypes\_weapons::stopBlinkingLight();
}

isFriendlyToIMS(ims) {
  if(level.teamBased && self.team == ims.team)
    return true;

  return false;
}

ims_attackTargets() {
  self endon("death");
  self endon("emp_damage");
  level endon("game_ended");

  while(true) {
    if(!isDefined(self.attackTrigger)) {
      break;
    }

    self.attackTrigger waittill("trigger", targetEnt);

    if(isPlayer(targetEnt)) {
      if(isDefined(self.owner) && targetEnt == self.owner) {
        continue;
      }
      if(level.teambased && targetEnt.pers["team"] == self.team) {
        continue;
      }
      if(!isReallyAlive(targetEnt))
        continue;
    } else {
      if(isDefined(targetEnt.owner)) {
        if(isDefined(self.owner) && targetEnt.owner == self.owner) {
          continue;
        }
        if(level.teambased && targetEnt.owner.pers["team"] == self.team)
          continue;
      }
    }

    offsetPos = targetEnt.origin + (0, 0, 50);

    if(!SightTracePassed(self.attackHeightPos + self.origin, offsetPos, false, self)) {
      continue;
    }
    sightPassed = false;
    for(i = 1; i <= self.config.numExplosives; i++) {
      if(i > CONST_NUM_LID_ON_MODEL) {
        break;
      }

      if(SightTracePassed(self GetTagOrigin(self.config.lidTagRoot + i), offsetPos, false, self)) {
        sightPassed = true;
        break;
      }
    }

    if(!sightPassed) {
      continue;
    }
    self playSound("ims_trigger");
    if(is_aliens() && isDefined(level.ims_alien_grace_period_func) && isDefined(self.owner)) {
      grace_period = [[level.ims_alien_grace_period_func]](level.imsSettings[self.imsType].gracePeriod, self.owner);
      self maps\mp\gametypes\_weapons::explosiveTrigger(targetEnt, grace_period, "ims");
    } else
      self maps\mp\gametypes\_weapons::explosiveTrigger(targetEnt, level.imsSettings[self.imsType].gracePeriod, "ims");

    if(!isDefined(self.attackTrigger)) {
      break;
    }

    if(!isDefined(self.hasExplosiveFired[self.attacks])) {
      self.hasExplosiveFired[self.attacks] = true;
      self thread fire_sensor(targetEnt, self.attacks);
      self.attacks++;
    }

    if(self.attacks > self.config.numExplosives) {
      break;
    }

    self imsCreateExplosiveWithKillCam();

    self waittill("sensor_exploded");
    wait(self.config.rearmTime);

    if(!isDefined(self.owner)) {
      break;
    }
  }

  if(isDefined(self.carriedBy) && isDefined(self.owner) && self.carriedBy == self.owner) {
    return;
  }
  self notify("death");
}

fire_sensor(targetEnt, explNum) {
  if(numExplosivesExceedModelCapacity())
    explNum = shiftIndexForward(explNum, self.config.numExplosives - CONST_NUM_LID_ON_MODEL);

  sensor = self.explosive1;
  self.explosive1 = undefined;

  lidName = self.config.lidTagRoot + explNum;
  playFXOnTag(level._effect["ims_sensor_explode"], self, lidName);

  self imsOpenDoor(explNum, self.config);

  savedWeaponInfo = self.config.weaponInfo;
  savedOwner = self.owner;

  sensor Unlink();
  sensor RotateYaw(3600, self.attackMoveTime);
  sensor MoveTo(self.attackHeightPos + self.origin, self.attackMoveTime, self.attackMoveTime * 0.25, self.attackMoveTime * 0.25);

  if(isDefined(sensor.killCamEnt)) {
    killCamEnt = sensor.killCamEnt;
    killCamEnt Unlink();

    if(isDefined(self.owner))
      self.owner.imsKillCamEnt = killCamEnt;

    killCamEnt MoveTo(self.attackHeightPos + self.origin + self.config.killCamOffset, self.attackMoveTime, self.attackMoveTime * 0.25, self.attackMoveTime * 0.25);

    if(!numExplosivesExceedModelCapacity())
      killCamEnt thread deleteAfterTime(5.0);
  }

  sensor playSound("ims_launch");

  sensor waittill("movedone");

  playFX(level._effect["ims_sensor_explode"], sensor.origin);

  dropBombs = [];
  dropBombs[0] = targetEnt.origin;
  for(i = 0; i < dropBombs.size; i++) {
    if(isDefined(savedOwner)) {
      MagicBullet(savedWeaponInfo, sensor.origin, dropBombs[i], savedOwner);
      if(is_aliens() && isDefined(level.ims_alien_fire_func)) {
        self thread[[level.ims_alien_fire_func]](dropBombs[i], savedOwner);
      }
    } else
      MagicBullet(savedWeaponInfo, sensor.origin, dropBombs[i]);
  }

  sensor Delete();
  self notify("sensor_exploded");
}

deleteAfterTime(time) {
  self endon("death");

  level maps\mp\gametypes\_hostmigration::waitLongDurationWithHostMigrationPause(time);

  if(isDefined(self))
    self delete();
}

ims_timeOut() {
  self endon("death");
  level endon("game_ended");

  lifeSpan = level.imsSettings[self.imsType].lifeSpan;

  lifeSpan = GetDvarFloat("scr_ims_timeout");

  while(lifeSpan) {
    wait(1.0);
    maps\mp\gametypes\_hostmigration::waitTillHostMigrationDone();

    if(!isDefined(self.carriedBy))
      lifeSpan = max(0, lifeSpan - 1.0);
  }

  self notify("death");
}

addToIMSList() {
  entNum = self GetEntityNumber();
  level.placedIMS[entNum] = self;
}

removeFromIMSList() {
  entNum = self GetEntityNumber();
  level.placedIMS[entNum] = undefined;
}

ims_hideAllParts() {
  self Hide();
  self.hidden = true;
}

ims_showAllParts() {
  self Show();
  self.hidden = false;

  self imsOpenAllDoors(self, true);
}

imsCreateExplosive(explNum) {
  Assert(explNum >= 1 && explNum <= self.config.numExplosives);

  expl = spawn("script_model", self GetTagOrigin(self.config.explTagRoot + explNum + KS_ATTACH));
  expl setModel(self.config.explosiveModel);

  expl.angles = self.angles;

  expl.killCamEnt = self.killcam_ents[explNum - 1];
  expl.killCamEnt LinkTo(self);

  return expl;
}

imsCreateExplosiveWithKillCam() {
  i = 1;
  while(i <= self.config.numExplosives && isDefined(self.hasExplosiveFired[i])) {
    i++;
  }

  if(i <= self.config.numExplosives) {
    if(numExplosivesExceedModelCapacity())
      i = shiftIndexForward(i, self.config.numExplosives - CONST_NUM_LID_ON_MODEL);

    expl = self imsCreateExplosive(i);
    expl LinkTo(self);
    self.explosive1 = expl;
  }
}

imsOpenDoor(explNum, config, immediate) {
  lidName = config.lidTagRoot + explNum + KS_ATTACH;

  animName = undefined;
  if(isDefined(immediate)) {
    animName = config.lidSnapOpenAnims[explNum];
  } else {
    animName = config.lidOpenAnims[explNum];
  }

  self ScriptModelPlayAnim(animName);

  explName = config.explTagRoot + explNum + KS_ATTACH;
  self HidePart(explName);
}

imsOpenAllDoors(modelEnt, immediate) {
  numDoors = self.hasExplosiveFired.size;
  if(numDoors > 0) {
    if(numExplosivesExceedModelCapacity())
      numDoors = shiftIndexForward(numDoors, self.config.numExplosives - CONST_NUM_LID_ON_MODEL);

    modelEnt imsOpenDoor(numDoors, self.config, immediate);
  }
}

numExplosivesExceedModelCapacity() {
  return (self.config.numExplosives > CONST_NUM_LID_ON_MODEL);
}

shiftIndexForward(index, amount_to_shift) {
  shifted_index = index - amount_to_shift;
  shifted_index = max(1, shifted_index);
  return int(shifted_index);
}