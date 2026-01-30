/***************************************************
 * Decompiled by Alterware and Edited by SyndiShanX
 * Script: maps\mp\_riotshield.gsc
***************************************************/

#include common_scripts\utility;
#include maps\mp\_utility;

init() {
  level.riot_shield_names = [];
  level.riot_shield_names[level.riot_shield_names.size] = "riotshield_mp";
  level.riot_shield_names[level.riot_shield_names.size] = "iw5_riotshieldt6_mp";
  level.riot_shield_names[level.riot_shield_names.size] = "iw5_riotshieldt6loot0_mp";
  level.riot_shield_names[level.riot_shield_names.size] = "iw5_riotshieldt6loot1_mp";
  level.riot_shield_names[level.riot_shield_names.size] = "iw5_riotshieldt6loot2_mp";
  level.riot_shield_names[level.riot_shield_names.size] = "iw5_riotshieldt6loot3_mp";
  level.riot_shield_names[level.riot_shield_names.size] = "iw5_riotshieldjugg_mp";

  precacheAnims();

  level.riot_shield_collision = GetEnt("riot_shield_collision", "targetname");

  level._effect["riot_shield_shock_fx"] = LoadFX("vfx/explosion/riotshield_stun");
  level._effect["riot_shield_deploy_smoke"] = LoadFX("vfx/smoke/riotshield_deploy_smoke");
  level._effect["riot_shield_deploy_lights"] = LoadFX("vfx/lights/riotshield_deploy_lights");
}

#using_animtree("mp_riotshield");
precacheAnims() {
  PrecacheMpAnim("npc_deployable_riotshield_stand_deploy");
  PrecacheMpAnim("npc_deployable_riotshield_stand_destroyed");
  PrecacheMpAnim("npc_deployable_riotshield_stand_shot");
  PrecacheMpAnim("npc_deployable_riotshield_stand_shot_back");
  PrecacheMpAnim("npc_deployable_riotshield_stand_melee_front");
  PrecacheMpAnim("npc_deployable_riotshield_stand_melee_back");
}

hasRiotShield() {
  return (isDefined(self.frontShieldModel) || isDefined(self.backShieldModel));
}

hasRiotShieldEquipped() {
  return (isDefined(self.frontShieldModel));
}

weaponIsRiotShield(inWeaponName) {
  inBaseWeaponName = GetWeaponBaseName(inWeaponName);
  if(!isDefined(inBaseWeaponName)) {
    inBaseWeaponName = inWeaponName;
  }

  foreach(weaponName in level.riot_shield_names) {
    if(weaponName == inBaseWeaponName) {
      return true;
    }
  }

  return false;
}

weaponIsShockPlantRiotShield(inWeaponName) {
  if(!weaponIsRiotShield(inWeaponName)) {
    return false;
  }

  return IsSubStr(inWeaponName, "shockplant");
}

getOtherRiotShieldName(inWeaponName) {
  foundInputWeapon = false;
  weapons = self GetWeaponsListPrimaries();
  foreach(weapon in weapons) {
    if(weaponIsRiotShield(weapon)) {
      if((weapon == inWeaponName) && !foundInputWeapon) {
        foundInputWeapon = true;
      } else {
        return weapon;
      }
    }
  }

  return undefined;
}

updateFrontAndBackShields(newWeapon) {
  self.frontShieldModel = undefined;
  self.backShieldModel = undefined;

  if(!isDefined(newWeapon)) {
    newWeapon = self GetCurrentPrimaryWeapon();
  }

  if(weaponIsRiotShield(newWeapon)) {
    self.frontShieldModel = GetWeaponModel(newWeapon);
  }

  otherShield = getOtherRiotShieldName(newWeapon);
  if(isDefined(otherShield)) {
    assert(weaponIsRiotShield(otherShield));
    self.backShieldModel = GetWeaponModel(otherShield);
  }

  self RefreshShieldModels(newWeapon);
}

riotShield_clear() {
  self.frontShieldModel = undefined;
  self.backShieldModel = undefined;
}

entIsStuckToShield() {
  if(!self IsLinked()) {
    return false;
  }

  tagName = self GetLinkedTagName();
  if(!isDefined(tagName)) {
    return false;
  }

  switch (tagName) {
    case "tag_weapon_left":
    case "tag_shield_back":
    case "tag_inhand":
      return true;
  }

  return false;
}

watchRiotShieldUse() {
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");

  self thread trackRiotShield();

  for(;;) {
    self waittill("raise_riotshield");
    self thread startRiotshieldDeploy();
  }
}

riotshield_watch_for_change_weapon() {
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");
  self endon("riotshield_change_weapon");

  newWeapon = undefined;

  self waittill("weapon_change", newWeapon);

  self notify("riotshield_change_weapon", newWeapon);
}

riotshield_watch_for_start_change_weapon() {
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");
  self endon("riotshield_change_weapon");

  newWeapon = undefined;

  while(1) {
    self waittill("weapon_switch_started", newWeapon);

    if(self IsOnLadder()) {
      self thread riotshield_watch_for_ladder_early_exit();
      break;
    }

    if(isDefined(self.frontShieldModel) && isDefined(self.backShieldModel)) {
      wait(0.5);
      break;
    }
  }

  self notify("riotshield_change_weapon", newWeapon);
}

riotshield_watch_for_ladder_early_exit() {
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");
  self endon("weapon_change");

  while(self IsOnLadder()) {
    waitframe();
  }

  self notify("riotshield_change_weapon", self GetCurrentPrimaryWeapon());
}

riotshield_watch_for_exo_shield_pullback() {
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");
  self endon("riotshield_change_weapon");

  newWeapon = undefined;

  exo_shield_weapon = maps\mp\_exo_shield::get_exo_shield_weapon();

  self waittillmatch("grenade_pullback", exo_shield_weapon);

  while(!isDefined(self.exo_shield_on) || !self.exo_shield_on) {
    waitframe();
  }

  self notify("riotshield_change_weapon", exo_shield_weapon);
}

riotshield_watch_for_exo_shield_release() {
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");
  self endon("riotshield_change_weapon");

  if(!isDefined(self.exo_shield_on) || !self.exo_shield_on) {
    return;
  }

  newWeapon = undefined;

  exo_shield_weapon = maps\mp\_exo_shield::get_exo_shield_weapon();

  self waittillmatch("battery_discharge_end", exo_shield_weapon);

  while(isDefined(self.exo_shield_on) && self.exo_shield_on) {
    waitframe();
  }

  self notify("riotshield_change_weapon", self getCurrentWeapon());
}

trackRiotShield() {
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");

  self notify("track_riot_shield");
  self endon("track_riot_shield");

  self updateFrontAndBackShields(self.currentWeaponAtSpawn);

  self.lastNonShieldWeapon = "none";

  for(;;) {
    self thread watchRiotshieldPickup();

    prevWeapon = self getCurrentWeapon();
    if(isDefined(self.exo_shield_on) && self.exo_shield_on) {
      prevWeapon = maps\mp\_exo_shield::get_exo_shield_weapon();
    }

    self thread riotshield_watch_for_change_weapon();
    self thread riotshield_watch_for_start_change_weapon();
    self thread riotshield_watch_for_exo_shield_pullback();
    self thread riotshield_watch_for_exo_shield_release();
    self waittill("riotshield_change_weapon", newWeapon);

    if(weaponIsRiotShield(newWeapon)) {
      if(self hasRiotShield()) {
        if(isDefined(self.riotshieldTakeWeapon)) {
          self TakeWeapon(self.riotshieldTakeWeapon);
          self.riotshieldTakeWeapon = undefined;
        }
      }

      if(isValidNonShieldWeapon(prevWeapon)) {
        self.lastNonShieldWeapon = prevWeapon;
      }
    }

    updateRiotShieldAttachForNewWeapon(newWeapon);
  }
}

updateRiotShieldAttachForNewWeapon(newWeapon) {
  if((self IsMantling()) && (newWeapon == "none")) {
    return;
  }

  updateFrontAndBackShields(newWeapon);
}

watchRiotshieldPickup() {
  self endon("death");
  self endon("disconnect");
  self endon("track_riot_shield");

  self notify("watch_riotshield_pickup");
  self endon("watch_riotshield_pickup");

  self waittill("pickup_riotshield");
  self endon("weapon_change");

  /#println( "Picked up riotshield, expecting weapon_change notify..." );

  wait 0.5;

  /#println( "picked up shield but didn't change weapons, attach it!" );

  updateRiotShieldAttachForNewWeapon(self getCurrentWeapon());
}

isValidNonShieldWeapon(weapon) {
  if(maps\mp\_utility::isKillstreakWeapon(weapon)) {
    return false;
  }

  if(weapon == "none") {
    return false;
  }

  if(maps\mp\gametypes\_class::isValidEquipment(weapon, true) ||
    maps\mp\gametypes\_class::isValidEquipment(weapon, false))
    return false;

  if(weaponIsRiotShield(weapon)) {
    return false;
  }

  if(WeaponClass(weapon) == "ball") {
    return false;
  }

  return true;
}

startRiotshieldDeploy() {
  self thread watchRiotshieldDeploy();
}

handleRiotShieldShockPlant() {
  shield_ent = self.riotshieldEntity;
  assert(isDefined(shield_ent));

  min_damage = 10;
  max_damage = 50;
  radius = 150;
  radius_sq = (radius * radius);

  event_origin = self.riotshieldEntity.origin + (0, 0, -25);

  self RadiusDamage(event_origin, radius, max_damage, min_damage, self, "MOD_EXPLOSIVE");

  playFX(level._effect["riot_shield_shock_fx"], event_origin, anglesToForward(self.riotshieldEntity.angles + (-90, 0, 0)));

  foreach(player in level.players) {
    if(isReallyAlive(player) && !IsAlliedSentient(player, self)) {
      if(DistanceSquared(event_origin, player.origin) < radius_sq) {
        player ShellShock("concussion_grenade_mp", 1);
      }
    }
  }
}

watchRiotshieldDeploy() {
  self endon("death");
  self endon("disconnect");

  self notify("start_riotshield_deploy");
  self endon("start_riotshield_deploy");

  self waittill("startdeploy_riotshield");

  self playSound("wpn_riot_shield_plant_mech");

  self waittill("deploy_riotshield", deploy_attempt);

  if(isDefined(self.riotshieldEntity)) {
    self.riotshieldEntity thread damageThenDestroyRiotshield();
    waitframe();
  }

  curWeapon = self GetCurrentWeapon();
  self SetWeaponModelVariant(curWeapon, 0);

  shockVersion = weaponIsShockPlantRiotShield(curWeapon);

  self playSound("wpn_riot_shield_plant_punch");
  if(shockVersion) {
    self playSound("wpn_riot_shield_blast_punch");
  }

  placement_hint = false;

  if(deploy_attempt) {
    placement = self CanPlaceRiotshield();

    if(placement["result"] && riotshieldDistanceTest(placement["origin"])) {
      zoffset = 28;

      shield_ent = self spawnRiotshieldCover(placement["origin"] + (0, 0, zoffset), placement["angles"]);
      coll_ent = self spawnRiotshieldCollision(placement["origin"] + (0, 0, zoffset), placement["angles"], shield_ent);
      item_ent = DeployRiotShield(self, shield_ent);

      primaries = self GetWeaponsListPrimaries();

      assert(isDefined(item_ent));
      assert(!isDefined(self.riotshieldRetrieveTrigger));
      assert(!isDefined(self.riotshieldEntity));
      assert(!isDefined(self.riotshieldCollisionEntity));

      self.riotshieldRetrieveTrigger = item_ent;
      self.riotshieldEntity = shield_ent;
      self.riotshieldCollisionEntity = coll_ent;

      if(shockVersion) {
        self thread handleRiotShieldShockPlant();
      } else {
        playFXOnTag(getfx("riot_shield_deploy_smoke"), shield_ent, "tag_weapon");
      }

      shield_ent ScriptModelPlayAnimDeltaMotion("npc_deployable_riotshield_stand_deploy");

      thread spawnShieldLights(shield_ent);

      switchToKnife = false;
      if(self.lastNonShieldWeapon != "none" && self hasWeapon(self.lastNonShieldWeapon)) {
        self SwitchToWeaponImmediate(self.lastNonShieldWeapon);
      } else if(primaries.size > 0) {
        self SwitchToWeaponImmediate(primaries[0]);
      } else {
        switchToKnife = true;
      }

      if(!self HasWeapon("iw5_combatknife_mp")) {
        self GiveWeapon("iw5_combatknife_mp");
        self.riotshieldTakeWeapon = "iw5_combatknife_mp";
      }

      if(switchToKnife) {
        self SwitchToWeaponImmediate("iw5_combatknife_mp");
      }

      data = spawnStruct();
      data.deathOverrideCallback = ::damageThenDestroyRiotshield;
      shield_ent thread maps\mp\_movers::handle_moving_platforms(data);

      self thread watchDeployedRiotshieldEnts();

      self thread deleteShieldOnTriggerDeath(self.riotshieldRetrieveTrigger);
      self thread deleteShieldOnTriggerPickup(self.riotshieldRetrieveTrigger, self.riotshieldEntity);
      self thread deleteShieldOnPlayerDeathOrDisconnect(shield_ent);

      self.riotshieldEntity thread watchDeployedRiotshieldDamage();
      level notify("riotshield_planted", self);
    } else {
      placement_hint = true;

      clip_max_ammo = WeaponClipSize(curWeapon);
      self setWeaponAmmoClip(curWeapon, clip_max_ammo);
    }
  } else {
    placement_hint = true;
  }

  if(placement_hint) {
    self SetRiotshieldFailHint();
  }
}

spawnShieldLights(ent) {
  level endon("game_ended");
  ent endon("death");

  wait 0.6;
  playFXOnTag(getfx("riot_shield_deploy_lights"), ent, "tag_weapon");
}

riotshieldDistanceTest(origin) {
  assert(isDefined(origin));

  min_dist_squared = GetDvarFloat("riotshield_deploy_limit_radius");
  min_dist_squared *= min_dist_squared;

  foreach(player in level.players) {
    if(isDefined(player.riotshieldEntity)) {
      dist_squared = DistanceSquared(player.riotshieldEntity.origin, origin);
      if(min_dist_squared > dist_squared) {
        println("Shield placement denied!Failed distance check to other riotshields.");

        return false;
      }
    }
  }

  return true;
}

spawnRiotshieldCover(origin, angles) {
  shield_ent = spawn("script_model", origin);
  shield_ent.targetname = "riotshield_mp";
  shield_ent.angles = angles;

  model = undefined;
  curWeapon = self GetCurrentPrimaryWeapon();
  if(weaponIsRiotShield(curWeapon)) {
    model = GetWeaponModel(curWeapon);
  }

  if(!isDefined(model)) {
    model = "npc_deployable_riot_shield_base";
  }

  shield_ent setModel(model);

  shield_ent.owner = self;
  shield_ent.team = self.team;

  return shield_ent;
}

spawnRiotshieldCollision(origin, angles, shield_ent) {
  coll_ent = spawn("script_model", origin, 1);
  coll_ent.targetname = "riotshield_coll_mp";
  coll_ent.angles = angles;
  coll_ent setModel("tag_origin");
  coll_ent.owner = self;
  coll_ent.team = self.team;
  coll_ent CloneBrushmodelToScriptModel(level.riot_shield_collision);
  coll_ent DisconnectPaths();

  return coll_ent;
}

watchDeployedRiotshieldEnts() {
  assert(isDefined(self.riotshieldRetrieveTrigger));
  assert(isDefined(self.riotshieldEntity));
  assert(isDefined(self.riotshieldCollisionEntity));

  self waittill("destroy_riotshield");

  if(isDefined(self.riotshieldRetrieveTrigger)) {
    self.riotshieldRetrieveTrigger delete();
  }

  if(isDefined(self.riotshieldCollisionEntity)) {
    self.riotshieldCollisionEntity ConnectPaths();
    self.riotshieldCollisionEntity delete();
  }

  if(isDefined(self.riotshieldEntity)) {
    self.riotshieldEntity delete();
  }
}

deleteShieldOnTriggerPickup(shield_trigger, shield_ent) {
  level endon("game_ended");
  shield_trigger endon("death");

  shield_trigger waittill("trigger", player);

  HandlePickupDeployedRiotshield(player, shield_ent);

  self notify("destroy_riotshield");
}

deleteShieldOnTriggerDeath(shield_trigger) {
  level endon("game_ended");

  shield_trigger waittill("death");
  self notify("destroy_riotshield");
}

deleteShieldOnPlayerDeathOrDisconnect(shield_ent) {
  shield_ent endon("death");
  shield_ent endon("damageThenDestroyRiotshield");

  self waittill_any("death", "disconnect", "remove_planted_weapons");

  shield_ent thread damageThenDestroyRiotshield();
}

watchDeployedRiotshieldDamage() {
  self endon("death");

  damageMax = GetDvarInt("riotshield_deployed_health");
  self.damageTaken = 0;

  nextDamageAnimTime = 0;

  while(true) {
    self.maxhealth = 100000;
    self.health = self.maxhealth;

    self waittill("damage", damage, attacker, direction, point, type, modelName, tagName, partname, iDFlags, weaponName);

    if(!isDefined(attacker)) {
      continue;
    }

    assert(isDefined(self.owner) && isDefined(self.owner.team));

    if(isplayer(attacker)) {
      if((level.teamBased) && (attacker.team == self.owner.team) && (attacker != self.owner)) {
        continue;
      }
    }

    isMeleeDamage = false;
    isBulletDamage = false;

    if(isMeleeMOD(type)) {
      isMeleeDamage = true;
      damage *= GetDvarfloat("riotshield_melee_damage_scale");
    } else if(type == "MOD_PISTOL_BULLET" || type == "MOD_RIFLE_BULLET") {
      isBulletDamage = true;
      damage *= GetDvarfloat("riotshield_bullet_damage_scale");
    } else if(type == "MOD_GRENADE" || type == "MOD_GRENADE_SPLASH" || type == "MOD_EXPLOSIVE" || type == "MOD_EXPLOSIVE_SPLASH" || type == "MOD_PROJECTILE" || type == "MOD_PROJECTILE_SPLASH") {
      damage *= GetDvarfloat("riotshield_explosive_damage_scale");
    } else if(type == "MOD_IMPACT") {
      damage *= GetDvarFloat("riotshield_projectile_damage_scale");
    } else if(type == "MOD_CRUSH") {
      damage = damageMax;
    }

    self.damageTaken += damage;

    if(self.damageTaken >= damageMax) {
      self thread damageThenDestroyRiotshield(attacker, weaponName);
      break;
    } else if((isMeleeDamage || isBulletDamage) && (GetTime() >= nextDamageAnimTime)) {
      nextDamageAnimTime = GetTime() + 500;

      fromBack = false;
      shield_fwd = anglesToForward(self.angles);
      if(VectorDot(direction, shield_fwd) > 0) {
        fromBack = true;
      }

      if(isMeleeDamage) {
        if(fromBack) {
          self ScriptModelPlayAnimDeltaMotion("npc_deployable_riotshield_stand_melee_back");
        } else {
          self ScriptModelPlayAnimDeltaMotion("npc_deployable_riotshield_stand_melee_front");
        }
      } else {
        Assert(isBulletDamage);
        if(fromBack) {
          self ScriptModelPlayAnimDeltaMotion("npc_deployable_riotshield_stand_shot_back");
        } else {
          self ScriptModelPlayAnimDeltaMotion("npc_deployable_riotshield_stand_shot");
        }
      }
    }
  }
}

damageThenDestroyRiotshield(attacker, weaponName) {
  self notify("damageThenDestroyRiotshield");
  self endon("death");

  if(isDefined(self.owner.riotshieldRetrieveTrigger)) {
    self.owner.riotshieldRetrieveTrigger delete();
  }

  if(isDefined(self.owner.riotshieldCollisionEntity)) {
    self.owner.riotshieldCollisionEntity ConnectPaths();
    self.owner.riotshieldCollisionEntity delete();
  }

  self.owner.riotshieldEntity = undefined;

  self NotSolid();

  self ScriptModelPlayAnimDeltaMotion("npc_deployable_riotshield_stand_destroyed");

  wait(GetDvarFloat("riotshield_destroyed_cleanup_time"));

  self delete();
}

watchRiotshieldStuckEntityDeath(grenade, owner) {
  grenade endon("death");

  self waittill_any("damageThenDestroyRiotshield", "death", "disconnect", "weapon_change", "deploy_riotshield");

  grenade Detonate(owner);
}