/************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\gametypes\_weaponobjects.gsc
************************************************/

#include common_scripts\utility;
#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;

init() {
  PrecacheString(&"MP_DEFUSING_EXPLOSIVE");
  coneangle = weapons_get_dvar_int("scr_weaponobject_coneangle", "70");
  mindist = weapons_get_dvar_int("scr_weaponobject_mindist", "20");
  graceperiod = weapons_get_dvar("scr_weaponobject_graceperiod", "0.6");
  radius = weapons_get_dvar_int("scr_weaponobject_radius", "192");
  level.claymoreFXid = loadfx("weapon/claymore/fx_claymore_laser");
  level._equipment_spark_fx = loadfx("weapon/grenade/fx_spark_disabled_weapon");
  level._equipment_explode_fx = loadfx("explosions/fx_exp_equipment");
  level._effect["powerLight"] = loadfx("weapon/crossbow/fx_trail_crossbow_blink_red_os");
  level thread onPlayerConnect();
  level.watcherWeaponNames = [];
  level.watcherWeaponNames = getWatcherWeapons();
  level.retrievableWeapons = [];
  level.retrievableWeapons = getRetrievableWeapons();
  setUpRetrievableHintStrings();
  level.weaponobjectexplodethisframe = false;
  level.weaponobjects_headicon_offset = [];
  level.weaponobjects_headicon_offset["default"] = (0, 0, 20);
  level.weaponobjects_headicon_offset["acoustic_sensor_mp"] = (0, 0, 25);
  level.weaponobjects_headicon_offset["camera_spike_mp"] = (0, 0, 35);
  level.weaponobjects_headicon_offset["claymore_mp"] = (0, 0, 20);
  level.weaponobjects_headicon_offset["satchel_charge_mp"] = (0, 0, 10);
  level.weaponobjects_headicon_offset["scrambler_mp"] = (0, 0, 20);
  level.weaponobjects_hacker_trigger_width = 32;
  level.weaponobjects_hacker_trigger_height = 32;
}
weapons_get_dvar_int(dvar, def) {
  return int(weapons_get_dvar(dvar, def));
}
weapons_get_dvar(dvar, def) {
  if(getdvar(dvar) != "") {
    return getdvarfloat(dvar);
  } else {
    setdvar(dvar, def);
    return def;
  }
}
setUpRetrievableHintStrings() {
  createRetrievableHint("hatchet", &"MP_HATCHET_PICKUP");
  createRetrievableHint("claymore", &"MP_CLAYMORE_PICKUP");
  createRetrievableHint("acoustic_sensor", &"MP_ACOUSTIC_SENSOR_PICKUP");
  createRetrievableHint("camera_spike", &"MP_CAMERA_SPIKE_PICKUP");
  createRetrievableHint("satchel_charge", &"MP_SATCHEL_CHARGE_PICKUP");
  createRetrievableHint("scrambler", &"MP_SCRAMBLER_PICKUP");
  createHackerHint("claymore_mp", &"MP_CLAYMORE_HACKING");
  createHackerHint("acoustic_sensor_mp", &"MP_ACOUSTIC_SENSOR_HACKING");
  createHackerHint("camera_spike_mp", &"MP_CAMERA_SPIKE_HACKING");
  createHackerHint("satchel_charge_mp", &"MP_SATCHEL_CHARGE_HACKING");
  createHackerHint("scrambler_mp", &"MP_SCRAMBLER_HACKING");
}
onPlayerConnect() {
  for(;;) {
    level waittill("connecting", player);
    player.usedWeapons = false;
    player.hits = 0;
    player thread onPlayerSpawned();
  }
}
onPlayerSpawned() {
  self endon("disconnect");
  for(;;) {
    self waittill("spawned_player");
    pixbeginevent("onPlayerSpawned");
    self createBaseWatchers();
    self maps\mp\_satchel_charge::createSatchelWatcher();
    self maps\mp\_decoy::createDecoyWatcher();
    self maps\mp\_scrambler::createScramblerWatcher();
    self maps\mp\_acousticsensor::createAcousticSensorWatcher();
    self maps\mp\_cameraspike::createCameraSpikeWatcher();
    self createClaymoreWatcher();
    self createRCBombWatcher();
    self createPlayerHelicopterWatcher();
    self createBallisticKnifeWatcher();
    self createHatchetWatcher();
    self createTactInsertWatcher();
    self setupRetrievableWatcher();
    self thread watchWeaponObjectUsage();
    pixendevent();
  }
}
createBaseWatchers() {
  for(i = 0; i < level.watcherWeaponNames.size; i++) {
    watcherName = getSubStr(level.watcherWeaponNames[i], 0, level.watcherWeaponNames[i].size - 3);
    self createWeaponObjectWatcher(watcherName, level.watcherWeaponNames[i], self.team);
  }
  for(i = 0; i < level.retrievableWeapons.size; i++) {
    watcherName = getSubStr(level.retrievableWeapons[i], 0, level.retrievableWeapons[i].size - 3);
    self createWeaponObjectWatcher(watcherName, level.retrievableWeapons[i], self.team);
  }
}
setupRetrievableWatcher() {
  for(i = 0; i < level.retrievableWeapons.size; i++) {
    watcher = getWeaponObjectWatcherByWeapon(level.retrievableWeapons[i]);
    if(!isDefined(watcher.onSpawnRetrieveTriggers))
      watcher.onSpawnRetrieveTriggers = ::onSpawnRetrievableWeaponObject;
    if(!isDefined(watcher.pickUp))
      watcher.pickUp = ::pickUp;
  }
}
createBallisticKnifeWatcher() {
  watcher = self createUseWeaponObjectWatcher("knife_ballistic", "knife_ballistic_mp", self.team);
  watcher.onSpawn = maps\mp\_ballistic_knife::onSpawn;
  watcher.detonate = ::deleteEnt;
  watcher.onSpawnRetrieveTriggers = maps\mp\_ballistic_knife::onSpawnRetrieveTrigger;
  watcher.storeDifferentObject = true;
}
createHatchetWatcher() {
  watcher = self createUseWeaponObjectWatcher("hatchet", "hatchet_mp", self.team);
  watcher.detonate = ::deleteEnt;
  watcher.onSpawn = ::voidOnSpawn;
}
createTactInsertWatcher() {
  watcher = self createUseWeaponObjectWatcher("tactical_insertion", "tactical_insertion_mp", self.team);
  watcher.playDestroyedDialog = false;
}
createRCBombWatcher() {
  watcher = self createUseWeaponObjectWatcher("rcbomb", "rcbomb_mp", self.team);
  watcher.altDetonate = false;
  watcher.headIcon = false;
  watcher.isMovable = true;
  watcher.ownerGetsAssist = true;
  watcher.playDestroyedDialog = false;
  watcher.deleteOnKillbrush = false;
  watcher.detonate = maps\mp\_rcbomb::blowup;
  watcher.stunTime = 5;
}
createPlayerHelicopterWatcher() {
  watcher = self createUseWeaponObjectWatcher("helicopter_player", "helicopter_player_mp", self.team);
  watcher.altDetonate = true;
  watcher.headIcon = false;
}
createClaymoreWatcher() {
  watcher = self createProximityWeaponObjectWatcher("claymore", "claymore_mp", self.team);
  watcher.watchForFire = true;
  watcher.detonate = ::weaponDetonate;
  watcher.activateSound = "wpn_claymore_alert";
  watcher.hackable = true;
  watcher.reconModel = "weapon_claymore_detect";
  watcher.ownerGetsAssist = true;
  detectionConeAngle = weapons_get_dvar_int("scr_weaponobject_coneangle");
  watcher.detectionDot = cos(detectionConeAngle);
  watcher.detectionMinDist = weapons_get_dvar_int("scr_weaponobject_mindist");
  watcher.detectionGracePeriod = weapons_get_dvar("scr_weaponobject_graceperiod");
  watcher.detonateRadius = weapons_get_dvar_int("scr_weaponobject_radius");
  watcher.stun = ::weaponStun;
  watcher.stunTime = 5;
}
waittillNotMoving_and_notStunned() {
  prevorigin = self.origin;
  while(1) {
    wait .15;
    if(self.origin == prevorigin && !(self isstunned())) {
      break;
    }
    prevorigin = self.origin;
  }
}
voidOnspawn(unused0, unused1) {}
deleteEnt(attacker) {
  self delete();
}
clearFXOnDeath(fx) {
  fx endon("death");
  self waittill_any("death", "hacked");
  fx delete();
}
deleteWeaponObjectArray() {
  if(isDefined(self.objectArray)) {
    for(i = 0; i < self.objectArray.size; i++) {
      if(isDefined(self.objectArray[i]))
        self.objectArray[i] delete();
    }
  }
  self.objectArray = [];
}
weaponDetonate(attacker) {
  if(isDefined(attacker)) {
    self Detonate(attacker);
  } else if(isDefined(self.owner) && isplayer(self.owner)) {
    self Detonate(self.owner);
  } else {
    self Detonate();
  }
}
waitAndDetonate(object, delay, attacker) {
  object endon("death");
  object endon("hacked");
  if(delay)
    wait(delay);
  if(isDefined(object.detonated) && object.detonated == true)
    return;
  if(!isDefined(self.detonate))
    return;
  if(isDefined(attacker) && isDefined(attacker.pers["team"]) && isDefined(object.owner) && isDefined(object.owner.pers["team"])) {
    if(level.teambased) {
      if(attacker.pers["team"] != object.owner.pers["team"]) {
        attacker notify("destroyed_explosive");
        attacker maps\mp\_properks::destroyedEquiptment();
      }
    } else {
      if(attacker != object.owner) {
        attacker notify("destroyed_explosive");
        attacker maps\mp\_properks::destroyedEquiptment();
      }
    }
  }
  object.detonated = true;
  object[[self.detonate]](attacker);
}
detonateWeaponObjectArray(forceDetonation, weapon) {
  if(isDefined(self.disableDetonation) && self.disableDetonation)
    return;
  undetonated = [];
  if(isDefined(self.objectArray)) {
    for(i = 0; i < self.objectArray.size; i++) {
      if(isDefined(self.objectArray[i])) {
        if(self.objectArray[i] isstunned() && forceDetonation == false) {
          undetonated[undetonated.size] = self.objectArray[i];
          continue;
        }
        if(isDefined(weapon)) {
          if(weapon isHacked() && weapon.name != self.objectArray[i].name) {
            undetonated[undetonated.size] = self.objectArray[i];
            continue;
          } else if(self.objectArray[i] isHacked() && weapon.name != self.objectArray[i].name) {
            undetonated[undetonated.size] = self.objectArray[i];
            continue;
          }
        }
        self thread waitAndDetonate(self.objectArray[i], 0.1);
      }
    }
  }
  self.objectArray = undetonated;
}
addWeaponObjectToWatcher(watcherName, weapon) {
  watcher = getWeaponObjectWatcher(watcherName);
  AssertEx(isDefined(watcher), "Weapon object watcher " + watcherName + " does not exist");
  self addWeaponObject(watcher, weapon);
}
addWeaponObject(watcher, weapon) {
  if(!isDefined(watcher.storeDifferentObject))
    watcher.objectArray[watcher.objectArray.size] = weapon;
  weapon.owner = self;
  weapon.detonated = false;
  weapon.name = watcher.weapon;
  if(isDefined(watcher.onDamage)) {
    weapon thread[[watcher.onDamage]](watcher);
  } else {
    weapon thread weaponObjectDamage(watcher);
  }
  weapon.ownerGetsAssist = watcher.ownerGetsAssist;
  if(isDefined(watcher.onSpawn))
    weapon thread[[watcher.onSpawn]](watcher, self);
  if(isDefined(watcher.onSpawnFX))
    weapon thread[[watcher.onSpawnFX]]();
  if(isDefined(watcher.reconModel))
    weapon thread attachReconModel(watcher.reconModel, self);
  if(isDefined(watcher.onSpawnRetrieveTriggers))
    weapon thread[[watcher.onSpawnRetrieveTriggers]](watcher, self);
  if(isDefined(watcher.deploySound) && !weapon isHacked())
    self playSound(watcher.deploySound);
  else if(isDefined(watcher.deploySoundPlayer) && !weapon isHacked())
    self playLocalSound(watcher.deploySoundPlayer);
  if(watcher.hackable)
    weapon thread hackerInit(watcher);
  if(isDefined(watcher.stun))
    weapon thread watchScramble(watcher);
  if(watcher.playDestroyedDialog) {
    weapon thread playDialogOnDeath(self);
    weapon thread watchObjectDamage(self);
  }
  if(watcher.deleteOnKillbrush)
    weapon thread deleteOnKillbrush(self);
}
watchScramble(watcher) {
  self endon("death");
  self endon("hacked");
  self waitTillNotMoving();
  if(self maps\mp\_scrambler::checkScramblerStun()) {
    self thread stunStart(watcher);
  } else {
    self stunStop();
  }
  for(;;) {
    level waittill_any("scrambler_spawn", "scrambler_death", "hacked");
    if(self maps\mp\_scrambler::checkScramblerStun()) {
      self thread stunStart(watcher);
    } else {
      self stunStop();
    }
  }
}
deleteWeaponObject(watcher, weapon_ent) {
  temp_objectArray = watcher.objectArray;
  watcher.objectArray = [];
  j = 0;
  for(i = 0; i < temp_objectArray.size; i++) {
    if(!isDefined(temp_objectArray[i]) || temp_objectArray[i] == weapon_ent) {
      continue;
    }
    watcher.objectArray[j] = temp_objectArray[i];
    j++;
  }
  return watcher.objectArray;
}
weaponObjectDamage(watcher) {
  self endon("death");
  self endon("hacked");
  self setCanDamage(true);
  self.maxhealth = 100000;
  self.health = self.maxhealth;
  attacker = undefined;
  while(1) {
    self waittill("damage", damage, attacker, direction_vec, point, type, modelName, tagName, partName, weaponName, iDFlags);
    if(!IsPlayer(attacker)) {
      continue;
    }
    if(isDefined(weaponName)) {
      switch (weaponName) {
        case "concussion_grenade_mp":
        case "flash_grenade_mp":
          if(watcher.stunTime > 0) {
            self thread stunStart(watcher, watcher.stunTime);
          }
          if(level.teambased && self.owner.team != attacker.team) {
            if(maps\mp\gametypes\_globallogic_player::doDamageFeedback(weaponName, attacker))
              attacker maps\mp\gametypes\_damagefeedback::updateDamageFeedback(false);
          } else if(!level.teambased && self.owner != attacker) {
            if(maps\mp\gametypes\_globallogic_player::doDamageFeedback(weaponName, attacker))
              attacker maps\mp\gametypes\_damagefeedback::updateDamageFeedback(false);
          }
          continue;
        case "willy_pete_mp":
          continue;
        default:
          break;
      }
    }
    if(level.teambased) {
      if(!level.hardcoreMode && self.owner.team == attacker.pers["team"] && self.owner != attacker) {
        continue;
      }
    }
    if(maps\mp\gametypes\_globallogic_player::doDamageFeedback(weaponName, attacker))
      attacker maps\mp\gametypes\_damagefeedback::updateDamageFeedback(false);
    if(!isvehicle(self) && !friendlyFireCheck(self.owner, attacker))
      continue;
    break;
  }
  if(level.weaponobjectexplodethisframe)
    wait .1 + randomfloat(.4);
  else
    wait .05;
  if(!isDefined(self))
    return;
  level.weaponobjectexplodethisframe = true;
  thread resetWeaponObjectExplodeThisFrame();
  self maps\mp\_entityheadicons::setEntityHeadIcon("none");
  if(isDefined(type) && (isSubStr(type, "MOD_GRENADE_SPLASH") || isSubStr(type, "MOD_GRENADE") || isSubStr(type, "MOD_EXPLOSIVE")))
    self.wasChained = true;
  if(isDefined(iDFlags) && (iDFlags &level.iDFLAGS_PENETRATION)) {
    self.wasDamagedFromBulletPenetration = true;
    attacker maps\mp\_properks::shotEquipment(self.owner, iDFlags);
  }
  self.wasDamaged = true;
  attacker.weaponUsedToDamage = weaponName;
  watcher thread waitAndDetonate(self, 0.0, attacker);
}
playDialogOnDeath(owner) {
  owner endon("death");
  owner endon("disconnect");
  self endon("hacked");
  self waittill("death");
  if(isDefined(self.playDialog) && self.playDialog)
    owner maps\mp\gametypes\_globallogic_audio::leaderDialogOnPlayer("equipment_destroyed", "item_destroyed");
}
watchObjectDamage(owner) {
  owner endon("death");
  owner endon("disconnect");
  self endon("hacked");
  self endon("death");
  while(1) {
    self waittill("damage", damage, attacker);
    if(isDefined(attacker) && isPlayer(attacker) && attacker != owner) {
      self.playDialog = true;
    } else {
      self.playDialog = false;
    }
  }
}
stunStart(watcher, time) {
  self endon("death");
  if(self isStunned()) {
    return;
  }
  if(isDefined(self.cameraHead))
    self.cameraHead SetClientFlag(level.const_flag_stunned);
  self SetClientFlag(level.const_flag_stunned);
  if(isDefined(watcher.stun))
    self thread[[watcher.stun]]();
  if(isDefined(time)) {
    wait(time);
  } else {
    return;
  }
  self stunStop();
}
stunStop() {
  self notify("not_stunned");
  if(isDefined(self.cameraHead))
    self.cameraHead ClearClientFlag(level.const_flag_stunned);
  self ClearClientFlag(level.const_flag_stunned);
}
weaponStun() {
  self endon("death");
  self endon("not_stunned");
  origin = self GetTagOrigin("tag_fx");
  if(!isDefined(origin)) {
    origin = self.origin + (0, 0, 10);
  }
  self.stun_fx = spawn("script_model", origin);
  self.stun_fx setModel("tag_origin");
  self thread stunFxThink(self.stun_fx);
  wait(0.1);
  playFXOnTag(level._equipment_spark_fx, self.stun_fx, "tag_origin");
  self.stun_fx playSound("dst_disable_spark");
}
stunFxThink(fx) {
  fx endon("death");
  self waittill_any("death", "not_stunned");
  fx delete();
}
isStunned() {
  return (isDefined(self.stun_fx));
}
resetWeaponObjectExplodeThisFrame() {
  wait .05;
  level.weaponobjectexplodethisframe = false;
}
getWeaponObjectWatcher(name) {
  if(!isDefined(self.weaponObjectWatcherArray)) {
    return undefined;
  }
  for(watcher = 0; watcher < self.weaponObjectWatcherArray.size; watcher++) {
    if(self.weaponObjectWatcherArray[watcher].name == name) {
      return self.weaponObjectWatcherArray[watcher];
    }
  }
  return undefined;
}
getWeaponObjectWatcherByWeapon(weapon) {
  if(!isDefined(self.weaponObjectWatcherArray)) {
    return undefined;
  }
  for(watcher = 0; watcher < self.weaponObjectWatcherArray.size; watcher++) {
    if(isDefined(self.weaponObjectWatcherArray[watcher].weapon) && self.weaponObjectWatcherArray[watcher].weapon == weapon) {
      return self.weaponObjectWatcherArray[watcher];
    }
    if(isDefined(self.weaponObjectWatcherArray[watcher].weapon) && isDefined(self.weaponObjectWatcherArray[watcher].altWeapon) && self.weaponObjectWatcherArray[watcher].altWeapon == weapon) {
      return self.weaponObjectWatcherArray[watcher];
    }
  }
  return undefined;
}
createWeaponObjectWatcher(name, weapon, ownerTeam) {
  if(!isDefined(self.weaponObjectWatcherArray)) {
    self.weaponObjectWatcherArray = [];
  }
  weaponObjectWatcher = getWeaponObjectWatcher(name);
  if(!isDefined(weaponObjectWatcher)) {
    weaponObjectWatcher = spawnStruct();
    self.weaponObjectWatcherArray[self.weaponObjectWatcherArray.size] = weaponObjectWatcher;
  }
  if(GetDvar(#"scr_deleteexplosivesonspawn") == "")
    setdvar("scr_deleteexplosivesonspawn", "1");
  if(GetDvarInt(#"scr_deleteexplosivesonspawn") == 1) {
    self notify("weapon_object_destroyed");
    weaponObjectWatcher deleteWeaponObjectArray();
  }
  if(!isDefined(weaponObjectWatcher.objectArray))
    weaponObjectWatcher.objectArray = [];
  weaponObjectWatcher.name = name;
  weaponObjectWatcher.ownerTeam = ownerTeam;
  weaponObjectWatcher.type = "use";
  weaponObjectWatcher.weapon = weapon;
  weaponObjectWatcher.weaponIdx = GetWeaponIndexFromName(weapon);
  weaponObjectWatcher.watchForFire = false;
  weaponObjectWatcher.hackable = false;
  weaponObjectWatcher.altDetonate = false;
  weaponObjectWatcher.detectable = true;
  weaponObjectWatcher.headIcon = true;
  weaponObjectWatcher.stunTime = 0;
  weaponObjectWatcher.activateSound = undefined;
  weaponObjectWatcher.deploySound = getWeaponFireSound(weaponObjectWatcher.weaponIdx);
  weaponObjectWatcher.deploySoundPlayer = getWeaponFireSoundPlayer(weaponObjectWatcher.weaponIdx);
  weaponObjectWatcher.pickUpSound = getWeaponPickupSound(weaponObjectWatcher.weaponIdx);
  weaponObjectWatcher.pickUpSoundPlayer = getWeaponPickupSoundPlayer(weaponObjectWatcher.weaponIdx);
  weaponObjectWatcher.altWeapon = undefined;
  weaponObjectWatcher.ownerGetsAssist = false;
  weaponObjectWatcher.playDestroyedDialog = true;
  weaponObjectWatcher.deleteOnKillbrush = true;
  weaponObjectWatcher.deleteOnDifferentObjectSpawn = true;
  weaponObjectWatcher.onSpawn = undefined;
  weaponObjectWatcher.onSpawnFX = undefined;
  weaponObjectWatcher.onSpawnRetrieveTriggers = undefined;
  weaponObjectWatcher.onDetonated = undefined;
  weaponObjectWatcher.detonate = undefined;
  weaponObjectWatcher.stun = undefined;
  return weaponObjectWatcher;
}
createUseWeaponObjectWatcher(name, weapon, ownerTeam) {
  weaponObjectWatcher = createWeaponObjectWatcher(name, weapon, ownerTeam);
  weaponObjectWatcher.type = "use";
  weaponObjectWatcher.onSpawn = ::onSpawnUseWeaponObject;
  return weaponObjectWatcher;
}
createProximityWeaponObjectWatcher(name, weapon, ownerTeam) {
  weaponObjectWatcher = createWeaponObjectWatcher(name, weapon, ownerTeam);
  weaponObjectWatcher.type = "proximity";
  weaponObjectWatcher.onSpawn = ::onSpawnProximityWeaponObject;
  detectionConeAngle = weapons_get_dvar_int("scr_weaponobject_coneangle");
  weaponObjectWatcher.detectionDot = cos(detectionConeAngle);
  weaponObjectWatcher.detectionMinDist = weapons_get_dvar_int("scr_weaponobject_mindist");
  weaponObjectWatcher.detectionGracePeriod = weapons_get_dvar("scr_weaponobject_graceperiod");
  weaponObjectWatcher.detonateRadius = weapons_get_dvar_int("scr_weaponobject_radius");
  return weaponObjectWatcher;
}
commonOnSpawnUseWeaponObject(watcher, owner) {
  if(watcher.detectable) {
    if(isDefined(watcher.isMovable) && watcher.isMovable)
      self thread weaponObjectDetectionMovable(owner.pers["team"]);
    else
      self thread weaponObjectDetectionTrigger_wait(owner.pers["team"]);
    if(watcher.headIcon && level.teamBased) {
      self waitTillNotMoving();
      if(!isDefined(watcher.isMovable) || watcher.isMovable == false) {
        groundEnt = self getgroundent();
        if(isDefined(groundEnt) && isvehicle(groundEnt)) {
          if(isDefined(watcher.detonate)) {
            watcher thread waitAndDetonate(self, 0.1);
          }
        }
      }
      offset = level.weaponobjects_headicon_offset["default"];
      if(isDefined(level.weaponobjects_headicon_offset[self.name])) {
        offset = level.weaponobjects_headicon_offset[self.name];
      }
      self maps\mp\_entityheadicons::setEntityHeadIcon(owner.pers["team"], owner, offset);
    }
  }
}
onSpawnUseWeaponObject(watcher, owner) {
  self commonOnSpawnUseWeaponObject(watcher, owner);
}
onSpawnProximityWeaponObject(watcher, owner) {
  self thread commonOnSpawnUseWeaponObject(watcher, owner);
  self thread proximityWeaponObjectDetonation(watcher);
}
watchWeaponObjectUsage() {
  self endon("death");
  self endon("disconnect");
  if(!isDefined(self.weaponObjectWatcherArray)) {
    self.weaponObjectWatcherArray = [];
  }
  self thread watchWeaponObjectspawn();
  self thread watchWeaponProjectileObjectspawn();
  self thread watchWeaponObjectDetonation();
  self thread watchWeaponObjectAltDetonation();
  self thread watchWeaponObjectAltDetonate();
  self thread deleteWeaponObjectsOnDisconnect();
}
watchWeaponObjectspawn() {
  self endon("disconnect");
  self endon("death");
  while(1) {
    self waittill("grenade_fire", weapon, weapname);
    switch (weapname) {
      case "claymore_mp":
      case "camera_spike_mp":
      case "tactical_insertion_mp":
      case "acoustic_sensor_mp":
      case "scrambler_mp":
        weapon.name = weapname;
        for(i = 0; i < self.weaponObjectWatcherArray.size; i++) {
          if(isDefined(self.weaponObjectWatcherArray[i].Detonate) && self.weaponObjectWatcherArray[i].deleteOnDifferentObjectSpawn) {
            self.weaponObjectWatcherArray[i] detonateWeaponObjectArray(true, weapon);
          }
        }
        break;
      case "satchel_charge_mp":
      case "hatchet_mp":
        for(i = 0; i < self.weaponObjectWatcherArray.size; i++) {
          if(self.weaponObjectWatcherArray[i].weapon != weapname)
            continue;
          objectArray_size = self.weaponObjectWatcherArray[i].objectarray.size;
          for(j = 0; j < objectArray_size; j++) {
            if(!isDefined(self.weaponObjectWatcherArray[i].objectarray[j])) {
              self.weaponObjectWatcherArray[i].objectarray = deleteWeaponObject(self.weaponObjectWatcherArray[i], weapon);
            }
          }
          if(isDefined(self.weaponObjectWatcherArray[i].Detonate) && self.weaponObjectWatcherArray[i].objectarray.size > 1) {
            self.weaponObjectWatcherArray[i] thread waitAndDetonate(self.weaponObjectWatcherArray[i].objectarray[0], 0.1);
          }
        }
        break;
      default:
        break;
    }
    if(!self isHacked()) {
      if(weapname == "claymore_mp" || weapname == "satchel_charge_mp")
        self maps\mp\gametypes\_globallogic_score::setWeaponStat(weapname, 1, "used");
    }
    watcher = getWeaponObjectWatcherByWeapon(weapname);
    if(isDefined(watcher)) {
      self addWeaponObject(watcher, weapon);
    }
  }
}
watchWeaponProjectileObjectspawn() {
  self endon("disconnect");
  self endon("death");
  while(1) {
    self waittill("missile_fire", weapon, weapname);
    watcher = getWeaponObjectWatcherByWeapon(weapname);
    if(isDefined(watcher)) {
      self addWeaponObject(watcher, weapon);
      objectArray_size = watcher.objectarray.size;
      for(j = 0; j < objectArray_size; j++) {
        if(!isDefined(watcher.objectarray[j])) {
          watcher.objectarray = deleteWeaponObject(watcher, weapon);
        }
      }
      if(isDefined(watcher.Detonate) && watcher.objectarray.size > 1) {
        watcher thread waitAndDetonate(watcher.objectarray[0], 0.1);
      }
    }
  }
}
weaponObjectDetectionMovable(ownerTeam) {
  self endon("end_detection");
  level endon("game_ended");
  self endon("death");
  self endon("hacked");
  if(level.oldschool)
    return;
  if(!level.teambased)
    return;
  detectTeam = level.otherTeam[ownerTeam];
  self.detectId = "rcBomb" + getTime() + randomInt(1000000);
  while(!level.gameEnded) {
    wait(1);
    players = get_players();
    for(i = 0; i < players.size; i++) {
      player = players[i];
      if(isai(player))
        continue;
      if(level.players[i] HasPerk("specialty_detectexplosive") && isDefined(self.model_name)) {
        switch (self.model_name) {
          case "weapon_claymore_detect":
          case "weapon_c4_mp_detect":
            break;
          default:
            continue;
        }
      } else {
        continue;
      }
      if(player.team != detectTeam)
        continue;
      if(isDefined(player.bombSquadIds[self.detectId]))
        continue;
      player thread showBombIcon(self);
    }
  }
}
showBombIcon(rcBomb) {
  rcBombDetectId = rcBomb.detectId;
  useId = -1;
  for(index = 0; index < 4; index++) {
    detectId = self.bombSquadIcons[index].detectId;
    if(detectId == rcBombDetectId)
      return;
    if(detectId == "")
      useId = index;
  }
  if(useId < 0)
    return;
  self.bombSquadIds[rcBombDetectId] = true;
  setIconPos(rcBomb, self.bombSquadIcons[useId], 32);
  self.bombSquadIcons[useId] fadeOverTime(0.25);
  self.bombSquadIcons[useId].alpha = 1;
  self.bombSquadIcons[useId].detectId = rcBomb.detectId;
  while(isAlive(self) && isDefined(rcBomb)) {
    setIconPos(rcBomb, self.bombSquadIcons[useId], 32);
    wait(0.05);
  }
  if(!isDefined(self))
    return;
  self.bombSquadIcons[useId].detectId = "";
  self.bombSquadIcons[useId] fadeOverTime(0.25);
  self.bombSquadIcons[useId].alpha = 0;
  self.bombSquadIds[rcBombDetectId] = undefined;
}
setIconPos(item, icon, heightIncrease) {
  icon.x = item.origin[0];
  icon.y = item.origin[1];
  icon.z = item.origin[2] + heightIncrease;
}
weaponObjectDetectionTrigger_wait(ownerTeam) {
  self endon("death");
  self endon("hacked");
  waitTillNotMoving();
  if(level.oldschool)
    return;
  self thread weaponObjectDetectionTrigger(ownerTeam);
}
weaponObjectDetectionTrigger(ownerTeam) {
  trigger = spawn("trigger_radius", self.origin - (0, 0, 128), 0, 512, 256);
  trigger.detectId = "trigger" + getTime() + randomInt(1000000);
  trigger SetHintLowPriority(true);
  trigger thread detectIconWaiter(level.otherTeam[ownerTeam], self);
  self waittill_any("death", "hacked");
  trigger notify("end_detection");
  if(isDefined(trigger.bombSquadIcon))
    trigger.bombSquadIcon destroy();
  trigger delete();
}
hackerTriggerSetVisibility(owner) {
  self endon("death");
  assert(IsPlayer(owner));
  if(level.teamBased) {
    self SetVisibleToTeam(GetOtherTeam(owner.pers["team"]));
    self SetTeamForTrigger(GetOtherTeam(owner.pers["team"]));
  } else {
    self SetVisibleToAll();
    self SetTeamForTrigger("none");
  }
  self SetInvisibleToPlayer(owner);
  for(;;) {
    level waittill_any("player_spawned", "joined_team");
    if(level.teamBased) {
      self SetVisibleToTeam(GetOtherTeam(owner.pers["team"]));
      self SetTeamForTrigger(GetOtherTeam(owner.pers["team"]));
    } else {
      self SetVisibleToAll();
      self SetTeamForTrigger("none");
    }
    self SetInvisibleToPlayer(owner);
  }
}
hackerNotMoving() {
  self endon("death");
  self waitTillNotMoving();
  self notify("landed");
}
hackerInit(watcher) {
  self thread hackerNotMoving();
  event = self waittill_any_return("death", "landed");
  if(event == "death") {
    return;
  }
  triggerOrigin = self.origin;
  if(isDefined(self.name) && self.name == "satchel_charge_mp") {
    triggerOrigin = self GetTagOrigin("tag_fx");
  }
  self.hackerTrigger = spawn("trigger_radius_use", triggerOrigin, level.weaponobjects_hacker_trigger_width, level.weaponobjects_hacker_trigger_height);
  self.hackerTrigger SetHintLowPriority(true);
  self.hackerTrigger SetCursorHint("HINT_NOICON", watcher.weapon);
  self.hackerTrigger SetIgnoreEntForTrigger(self);
  self.hackerTrigger EnableLinkTo();
  self.hackerTrigger LinkTo(self);
  if(isDefined(level.hackerHints[self.name])) {
    self.hackerTrigger SetHintString(level.hackerHints[self.name].hint);
  } else {
    self.hackerTrigger SetHintString(&"MP_GENERIC_HACKING");
  }
  self.hackerTrigger SetPerkForTrigger("specialty_disarmexplosive");
  self.hackerTrigger thread hackerTriggerSetVisibility(self.owner);
  self thread hackerThink(self.hackerTrigger, watcher);
}
hackerThink(trigger, watcher) {
  self endon("death");
  for(;;) {
    trigger waittill("trigger", player);
    if(!trigger hackerResult(player, self.owner)) {
      continue;
    }
    self.owner hackerRemoveWeapon(self);
    self.hacked = true;
    self SetOwner(player);
    self SetTeam(player.pers["team"]);
    self.owner = player;
    if(self.name == "satchel_charge_mp" && isDefined(player.lowerMessage)) {
      player.lowerMessage SetText(&"PLATFORM_SATCHEL_CHARGE_DOUBLE_TAP");
      player.lowerMessage.alpha = 1;
      player.lowerMessage FadeOverTime(2.0);
      player.lowerMessage.alpha = 0;
    }
    self notify("hacked", player);
    level notify("hacked", self, player);
    if(self.name == "camera_spike_mp" && isDefined(self.cameraHead)) {
      self.cameraHead notify("hacked", player);
    }
    if(isDefined(watcher.stun)) {
      self thread stunStart(watcher, 2.5);
      wait(2.5);
    } else {
      wait(0.05);
    }
    if(isDefined(player) && player.sessionstate == "playing") {
      player notify("grenade_fire", self, self.name);
    } else {
      watcher thread waitAndDetonate(self, 0.0);
    }
    return;
  }
}
isHacked() {
  return (isDefined(self.hacked) && self.hacked);
}
hackerUnfreezePlayer(player) {
  self endon("hack_done");
  self waittill("death");
  if(isDefined(player)) {
    player freeze_player_controls(false);
    player EnableWeapons();
  }
}
hackerResult(player, owner) {
  success = true;
  time = GetTime();
  hackTime = GetDvarFloat(#"perk_disarmExplosiveTime");
  if(!canHack(player, owner, true)) {
    return false;
  }
  self thread hackerUnfreezePlayer(player);
  while(time + (hackTime * 1000) > GetTime()) {
    if(!canHack(player, owner, false)) {
      success = false;
      break;
    }
    if(!player UseButtonPressed()) {
      success = false;
      break;
    }
    if(!isDefined(self)) {
      success = false;
      break;
    }
    player freeze_player_controls(true);
    player DisableWeapons();
    if(!isDefined(self.progressBar)) {
      self.progressBar = player createPrimaryProgressBar();
      self.progressBar.lastUseRate = -1;
      self.progressBar showElem();
      self.progressBar updateBar(0.01, 1 / hackTime);
      self.progressText = player createPrimaryProgressBarText();
      self.progressText setText(&"MP_HACKING");
      self.progressText showElem();
      player PlayLocalSound("evt_hacker_hacking");
    }
    wait(0.05);
  }
  if(isDefined(player)) {
    player freeze_player_controls(false);
    player EnableWeapons();
  }
  if(isDefined(self.progressBar)) {
    self.progressBar destroyElem();
    self.progressText destroyElem();
  }
  if(isDefined(self)) {
    self notify("hack_done");
  }
  return success;
}
canHack(player, owner, weapon_check) {
  if(!isDefined(player))
    return false;
  if(!IsPlayer(player))
    return false;
  if(!IsAlive(player))
    return false;
  if(!isDefined(owner))
    return false;
  if(owner == player)
    return false;
  if(level.teambased && player.team == owner.team)
    return false;
  if((isDefined(player.isDefusing) && player.isDefusing))
    return false;
  if((isDefined(player.isPlanting) && player.isPlanting))
    return false;
  if(isDefined(player.proxBar) && !player.proxBar.hidden)
    return false;
  if(isDefined(player.revivingTeammate) && player.revivingTeammate == true)
    return false;
  if(!player IsOnGround())
    return false;
  if(player IsInVehicle())
    return false;
  if(!player HasPerk("specialty_disarmexplosive"))
    return false;
  if(isDefined(player.laststand) && player.laststand)
    return false;
  if(weapon_check) {
    if(player IsThrowingGrenade())
      return false;
    if(player IsSwitchingWeapons())
      return false;
    if(player IsMeleeing())
      return false;
    weapon = player GetCurrentWeapon();
    if(!isDefined(weapon))
      return false;
    if(weapon == "none")
      return false;
    if(IsWeaponEquipment(weapon) && player IsFiring())
      return false;
    if(IsWeaponSpecificUse(weapon))
      return false;
  }
  return true;
}
hackerRemoveWeapon(weapon) {
  for(i = 0; i < self.weaponObjectWatcherArray.size; i++) {
    if(self.weaponObjectWatcherArray[i].weapon != weapon.name) {
      continue;
    }
    objectArray_size = self.weaponObjectWatcherArray[i].objectarray.size;
    for(j = 0; j < objectArray_size; j++) {
      self.weaponObjectWatcherArray[i].objectarray = deleteWeaponObject(self.weaponObjectWatcherArray[i], weapon);
    }
    return;
  }
}
proximityWeaponObjectDetonation(watcher) {
  self endon("death");
  self endon("hacked");
  self waitTillNotMoving();
  damagearea = spawn("trigger_radius", self.origin + (0, 0, 0 - watcher.detonateRadius), level.aiTriggerSpawnFlags | level.vehicleTriggerSpawnFlags, watcher.detonateRadius, watcher.detonateRadius * 2);
  damagearea EnableLinkTo();
  damagearea LinkTo(self);
  self thread deleteOnDeath(damagearea);
  while(1) {
    damagearea waittill("trigger", ent);
    if(GetDvarInt(#"scr_weaponobject_debug") != 1) {
      if(isDefined(self.owner) && ent == self.owner)
        continue;
      if(isDefined(self.owner) && IsVehicle(ent) && isDefined(ent.owner) && (self.owner == ent.owner))
        continue;
      if(!friendlyFireCheck(self.owner, ent, 0))
        continue;
    }
    if(lengthsquared(ent getVelocity()) < 10)
      continue;
    if(!ent shouldAffectWeaponObject(self, watcher))
      continue;
    if(self isstunned())
      continue;
    if(IsPlayer(ent) && !IsAlive(ent))
      continue;
    if(ent damageConeTrace(self.origin, self) > 0) {
      break;
    }
  }
  if(isDefined(watcher.activateSound)) {
    self playSound(watcher.activateSound);
  }
  ent thread deathDodger(watcher.detectionGracePeriod);
  wait watcher.detectionGracePeriod;
  if(IsPlayer(ent) && ent HasPerk("specialty_delayexplosive")) {
    wait(GetDvarFloat(#"perk_delayExplosiveTime"));
  }
  self maps\mp\_entityheadicons::setEntityHeadIcon("none");
  if(isDefined(self.owner) && isplayer(self.owner)) {
    self Detonate(self.owner);
  } else {
    self detonate();
  }
}
shouldAffectWeaponObject(object, watcher) {
  pos = self.origin + (0, 0, 32);
  dirToPos = pos - object.origin;
  objectForward = anglesToForward(object.angles);
  dist = vectorDot(dirToPos, objectForward);
  if(dist < watcher.detectionMinDist)
    return false;
  dirToPos = vectornormalize(dirToPos);
  dot = vectorDot(dirToPos, objectForward);
  return (dot > watcher.detectionDot);
}
deathDodger(graceperiod) {
  self endon("death");
  self endon("disconnect");
  wait(0.2 + graceperiod);
  self notify("death_dodger");
}
deleteOnDeath(ent) {
  self waittill_any("death", "hacked");
  wait .05;
  if(isDefined(ent))
    ent delete();
}
deleteOnKillbrush(player) {
  player endon("disconnect");
  self endon("death");
  self endon("stationary");
  killbrushes = getEntArray("trigger_hurt", "classname");
  while(1) {
    for(i = 0; i < killbrushes.size; i++) {
      if(self istouching(killbrushes[i])) {
        if(self.origin[2] > player.origin[2]) {
          break;
        }
        if(isDefined(self))
          self delete();
        return;
      }
    }
    wait(0.1);
  }
}
watchWeaponObjectAltDetonation() {
  self endon("death");
  self endon("disconnect");
  while(1) {
    self waittill("alt_detonate");
    for(watcher = 0; watcher < self.weaponObjectWatcherArray.size; watcher++) {
      if(self.weaponObjectWatcherArray[watcher].altDetonate) {
        self.weaponObjectWatcherArray[watcher] detonateWeaponObjectArray(false);
      }
    }
  }
}
watchWeaponObjectAltDetonate() {
  self endon("death");
  self endon("disconnect");
  self endon("detonated");
  level endon("game_ended");
  buttonTime = 0;
  for(;;) {
    self waittill("doubletap_detonate");
    self notify("alt_detonate");
    wait(0.05);
  }
}
watchWeaponObjectDetonation() {
  self endon("death");
  self endon("disconnect");
  while(1) {
    self waittill("detonate");
    weap = self getCurrentWeapon();
    watcher = getWeaponObjectWatcherByWeapon(weap);
    if(isDefined(watcher)) {
      watcher detonateWeaponObjectArray(false);
    }
  }
}
deleteWeaponObjectsOnDisconnect() {
  self endon("spawned_player");
  self waittill("disconnect");
  if(!isDefined(self.weaponObjectWatcherArray))
    return;
  watchers = [];
  for(watcher = 0; watcher < self.weaponObjectWatcherArray.size; watcher++) {
    weaponObjectWatcher = spawnStruct();
    watchers[watchers.size] = weaponObjectWatcher;
    weaponObjectWatcher.objectArray = [];
    if(isDefined(self.weaponObjectWatcherArray[watcher].objectArray)) {
      weaponObjectWatcher.objectArray = self.weaponObjectWatcherArray[watcher].objectArray;
    }
  }
  wait .05;
  for(watcher = 0; watcher < watchers.size; watcher++) {
    watchers[watcher] deleteWeaponObjectArray();
  }
}
saydamaged(orig, amount) {
  for(i = 0; i < 60; i++) {
    print3d(orig, "damaged! " + amount);
    wait .05;
  }
}
detectIconWaiter(detectTeam, ent) {
  self endon("end_detection");
  level endon("game_ended");
  if(!level.teambased)
    return;
  while(!level.gameEnded) {
    self waittill("trigger", player);
    if(isai(player))
      continue;
    if(player HasPerk("specialty_detectexplosive") && isDefined(ent.model_name)) {
      switch (ent.model_name) {
        case "weapon_claymore_detect":
        case "weapon_c4_mp_detect":
          break;
        default:
          continue;
      }
    } else {
      continue;
    }
    if(player.team != detectTeam)
      continue;
    if(isDefined(player.bombSquadIds[self.detectId]))
      continue;
    player thread showHeadIcon(self);
  }
}
setupBombSquad() {
  self.bombSquadIds = [];
  if(self.detectExplosives && !self.bombSquadIcons.size) {
    for(index = 0; index < 4; index++) {
      self.bombSquadIcons[index] = newClientHudElem(self);
      self.bombSquadIcons[index].x = 0;
      self.bombSquadIcons[index].y = 0;
      self.bombSquadIcons[index].z = 0;
      self.bombSquadIcons[index].alpha = 0;
      self.bombSquadIcons[index].archived = true;
      self.bombSquadIcons[index] setShader("waypoint_bombsquad", 14, 14);
      self.bombSquadIcons[index] setWaypoint(false);
      self.bombSquadIcons[index].detectId = "";
    }
  } else if(!self.detectExplosives) {
    for(index = 0; index < self.bombSquadIcons.size; index++)
      self.bombSquadIcons[index] destroy();
    self.bombSquadIcons = [];
  }
}
showHeadIcon(trigger) {
  triggerDetectId = trigger.detectId;
  useId = -1;
  for(index = 0; index < 4; index++) {
    detectId = self.bombSquadIcons[index].detectId;
    if(detectId == triggerDetectId)
      return;
    if(detectId == "")
      useId = index;
  }
  if(useId < 0)
    return;
  self.bombSquadIds[triggerDetectId] = true;
  self.bombSquadIcons[useId].x = trigger.origin[0];
  self.bombSquadIcons[useId].y = trigger.origin[1];
  self.bombSquadIcons[useId].z = trigger.origin[2] + 24 + 128;
  self.bombSquadIcons[useId] fadeOverTime(0.25);
  self.bombSquadIcons[useId].alpha = 1;
  self.bombSquadIcons[useId].detectId = trigger.detectId;
  while(isAlive(self) && isDefined(trigger) && self isTouching(trigger))
    wait(0.05);
  if(!isDefined(self))
    return;
  self.bombSquadIcons[useId].detectId = "";
  self.bombSquadIcons[useId] fadeOverTime(0.25);
  self.bombSquadIcons[useId].alpha = 0;
  self.bombSquadIds[triggerDetectId] = undefined;
}
friendlyFireCheck(owner, attacker, forcedFriendlyFireRule) {
  if(!isDefined(owner))
    return true;
  if(!level.teamBased)
    return true;
  friendlyFireRule = level.friendlyfire;
  if(isDefined(forcedFriendlyFireRule))
    friendlyFireRule = forcedFriendlyFireRule;
  if(friendlyFireRule != 0)
    return true;
  if(attacker == owner)
    return true;
  if(isplayer(attacker)) {
    if(!isDefined(attacker.pers["team"]))
      return true;
    if(attacker.pers["team"] != owner.pers["team"])
      return true;
  } else if(isai(attacker)) {
    if(attacker.aiteam != owner.pers["team"])
      return true;
  } else if(isvehicle(attacker)) {
    if(isDefined(attacker.owner) && IsPlayer(attacker.owner)) {
      if(attacker.owner.pers["team"] != owner.pers["team"])
        return true;
    } else {
      occupant_team = attacker maps\mp\_vehicles::vehicle_get_occupant_team();
      if(occupant_team != owner.pers["team"])
        return true;
    }
  }
  return false;
}
onSpawnRetrievableWeaponObject(watcher, player) {
  self endon("death");
  self endon("hacked");
  if(isHacked()) {
    self thread watchShutdown(player);
    return;
  }
  self SetOwner(player);
  self SetTeam(player.pers["team"]);
  self.owner = player;
  self.oldAngles = self.angles;
  self waitTillNotMoving();
  waittillframeend;
  if(player.pers["team"] == "spectator") {
    return;
  }
  triggerOrigin = self.origin;
  triggerParentEnt = undefined;
  if(isDefined(self.stuckToPlayer)) {
    if(IsAlive(self.stuckToPlayer) || !isDefined(self.stuckToPlayer.body)) {
      if(self.name == "hatchet_mp" && IsAlive(self.stuckToPlayer)) {
        triggerParentEnt = self;
        self Unlink();
        self.angles = self.oldAngles;
        self launch((5, 5, 5));
        self waitTillNotMoving();
        waittillframeend;
      } else {
        triggerParentEnt = self.stuckToPlayer;
      }
    } else {
      triggerParentEnt = self.stuckToPlayer.body;
    }
  }
  if(isDefined(triggerParentEnt))
    triggerOrigin = triggerParentEnt.origin + (0, 0, 10);
  self.pickUpTrigger = spawn("trigger_radius_use", triggerOrigin);
  self.pickUpTrigger SetHintLowPriority(true);
  self.pickUpTrigger SetCursorHint("HINT_NOICON", watcher.weapon);
  self.pickUpTrigger EnableLinkTo();
  self.pickUpTrigger LinkTo(self);
  if(isDefined(level.retrieveHints[watcher.name])) {
    self.pickUpTrigger SetHintString(level.retrieveHints[watcher.name].hint);
  } else {
    self.pickUpTrigger SetHintString(&"MP_GENERIC_PICKUP");
  }
  if(level.teamBased) {
    self.pickUpTrigger SetTeamForTrigger(player.pers["team"]);
  } else {
    self.pickUpTrigger SetTeamForTrigger("none");
  }
  if(isDefined(triggerParentEnt)) {
    self.pickUpTrigger linkto(triggerParentEnt);
  }
  self thread watchUseTrigger(self.pickUpTrigger, watcher.pickUp, watcher.pickUpSoundPlayer, watcher.pickUpSound);
  if(self.name == "hatchet_mp") {
    self.hatchetPickUpTrigger = spawn("trigger_radius_use", triggerOrigin);
    self.hatchetPickUpTrigger SetHintLowPriority(true);
    self.hatchetPickUpTrigger SetCursorHint("HINT_NOICON", self.name);
    self.hatchetPickUpTrigger EnableLinkTo();
    self.hatchetPickUpTrigger LinkTo(self);
    if(isDefined(level.retrieveHints[watcher.name])) {
      self.hatchetPickUpTrigger SetHintString(level.retrieveHints[watcher.name].hint);
    } else {
      self.hatchetPickUpTrigger SetHintString(&"MP_GENERIC_PICKUP");
    }
    if(level.teamBased) {
      self.hatchetPickUpTrigger SetTeamForTrigger(GetOtherTeam(player.pers["team"]));
    } else {
      self.hatchetPickUpTrigger SetTeamForTrigger("none");
    }
    triggers = [];
    triggers["owner_pickup"] = self.pickUpTrigger;
    triggers["enemy_pickup"] = self.hatchetPickUpTrigger;
    if(isDefined(triggerParentEnt)) {
      self.hatchetPickUpTrigger linkto(triggerParentEnt);
    }
    self thread watch_trigger_visibility(triggers, "hatchet_mp");
    self thread watchUseTrigger(self.hatchetPickUpTrigger, watcher.pickUp, watcher.pickUpSoundPlayer, watcher.pickUpSound);
  }
  self thread watchShutdown(player);
}
watch_trigger_visibility(triggers, weap_name) {
  self notify("watchTriggerVisibility");
  self endon("watchTriggerVisibility");
  self endon("death");
  self endon("hacked");
  max_ammo = WeaponMaxAmmo(weap_name);
  start_ammo = WeaponStartAmmo(weap_name);
  ammo_to_check = 0;
  while(true) {
    players = level.players;
    for(i = 0; i < players.size; i++) {
      if(players[i] HasWeapon(weap_name)) {
        if(!(players[i] HasPerk("specialty_twogrenades")) && weap_name == "hatchet_mp") {
          ammo_to_check = start_ammo;
        } else {
          ammo_to_check = max_ammo;
        }
        if(self.owner == players[i]) {
          curr_ammo = players[i] GetWeaponAmmoStock(weap_name) + players[i] GetWeaponAmmoClip(weap_name);
          if(weap_name == "hatchet_mp") {
            curr_ammo = players[i] GetWeaponAmmoStock(weap_name);
          }
          if(curr_ammo < ammo_to_check) {
            triggers["owner_pickup"] SetVisibleToPlayer(players[i]);
            triggers["enemy_pickup"] SetInvisibleToPlayer(players[i]);
          } else {
            triggers["owner_pickup"] SetInvisibleToPlayer(players[i]);
            triggers["enemy_pickup"] SetInvisibleToPlayer(players[i]);
          }
        } else {
          curr_ammo = players[i] GetWeaponAmmoStock(weap_name) + players[i] GetWeaponAmmoClip(weap_name);
          if(weap_name == "hatchet_mp") {
            curr_ammo = players[i] GetWeaponAmmoStock(weap_name);
          }
          if(curr_ammo < ammo_to_check) {
            triggers["owner_pickup"] SetInvisibleToPlayer(players[i]);
            triggers["enemy_pickup"] SetVisibleToPlayer(players[i]);
          } else {
            triggers["owner_pickup"] SetInvisibleToPlayer(players[i]);
            triggers["enemy_pickup"] SetInvisibleToPlayer(players[i]);
          }
        }
      } else {
        triggers["owner_pickup"] SetInvisibleToPlayer(players[i]);
        triggers["enemy_pickup"] SetInvisibleToPlayer(players[i]);
      }
    }
    wait(0.05);
  }
}
destroyEnt() {
  self delete();
}
pickUp(player) {
  self.playDialog = false;
  self destroyEnt();
  player GiveWeapon(self.name);
  clip_ammo = player GetWeaponAmmoClip(self.name);
  clip_max_ammo = WeaponClipSize(self.name);
  if(self.name == "hatchet_mp" && !player HasPerk("specialty_twogrenades")) {
    clip_max_ammo = WeaponStartAmmo(self.name);
  }
  if(clip_ammo < clip_max_ammo) {
    clip_ammo++;
  }
  player setWeaponAmmoClip(self.name, clip_ammo);
}
watchShutdown(player) {
  self waittill_any("death", "hacked");
  pickUpTrigger = self.pickUpTrigger;
  hackerTrigger = self.hackerTrigger;
  hatchetPickUpTrigger = self.hatchetPickUpTrigger;
  if(isDefined(pickUpTrigger))
    pickUpTrigger delete();
  if(isDefined(hackerTrigger)) {
    if(isDefined(hackerTrigger.progressBar)) {
      hackerTrigger.progressBar destroyElem();
      hackerTrigger.progressText destroyElem();
    }
    hackerTrigger delete();
  }
  if(isDefined(hatchetPickUpTrigger))
    hatchetPickUpTrigger delete();
}
watchUseTrigger(trigger, callback, playerSoundOnUse, npcSoundOnUse) {
  self endon("delete");
  self endon("hacked");
  while(true) {
    trigger waittill("trigger", player);
    if(!isAlive(player))
      continue;
    if(!player isOnGround())
      continue;
    if(isDefined(trigger.triggerTeam) && (player.pers["team"] != trigger.triggerTeam))
      continue;
    if(isDefined(trigger.claimedBy) && (player != trigger.claimedBy))
      continue;
    grenade = player.throwingGrenade;
    isEquipment = IsWeaponEquipment(player GetCurrentWeapon());
    if(isDefined(isEquipment) && isEquipment) {
      grenade = false;
    }
    if(player useButtonPressed() && !grenade && !player meleeButtonPressed()) {
      if(isDefined(playerSoundOnUse))
        player playLocalSound(playerSoundOnUse);
      if(isDefined(npcSoundOnUse))
        player playSound(npcSoundOnUse);
      self thread[[callback]](player);
    }
  }
}
createRetrievableHint(name, hint) {
  retrieveHint = spawnStruct();
  retrieveHint.name = name;
  retrieveHint.hint = hint;
  level.retrieveHints[name] = retrieveHint;
}
createHackerHint(name, hint) {
  hackerHint = spawnStruct();
  hackerHint.name = name;
  hackerHint.hint = hint;
  level.hackerHints[name] = hackerHint;
}
attachReconModel(modelName, owner) {
  if(!isDefined(self))
    return;
  reconModel = spawn("script_model", self.origin);
  reconModel.angles = self.angles;
  reconModel setModel(modelName);
  reconModel.model_name = modelName;
  reconModel linkto(self);
  reconModel SetContents(0);
  reconModel resetReconModelVisibility(owner);
  reconModel thread watchReconModelForDeath(self);
  reconModel thread resetReconModelOnEvent("joined_team", owner);
  reconModel thread resetReconModelOnEvent("player_spawned", owner);
}
resetReconModelVisibility(owner) {
  if(!isDefined(self))
    return;
  self SetInvisibleToAll();
  self SetForceNoCull();
  if(!isDefined(owner))
    return;
  for(i = 0; i < level.players.size; i++) {
    if(!(level.players[i] HasPerk("specialty_detectexplosive")) &&
      !(level.players[i] HasPerk("specialty_showenemyequipment"))) {
      continue;
    }
    hasReconModel = false;
    if(level.players[i] HasPerk("specialty_detectexplosive")) {
      switch (self.model_name) {
        case "weapon_claymore_detect":
        case "weapon_c4_mp_detect":
          hasReconModel = true;
          break;
        default:
          break;
      }
    }
    if(level.players[i] HasPerk("specialty_showenemyequipment")) {
      switch (self.model_name) {
        case "t5_weapon_acoustic_sensor_world_detect":
        case "t5_weapon_camera_spike_world_detect":
        case "t5_weapon_camera_head_world_detect":
        case "t5_weapon_scrambler_world_detect":
        case "t5_weapon_tactical_insertion_world_detect":
          hasReconModel = true;
          break;
        default:
          break;
      }
    }
    if(!hasReconModel)
      continue;
    isEnemy = true;
    if(level.teamBased) {
      if(level.players[i].team == owner.team)
        isEnemy = false;
    } else {
      if(level.players[i] == owner)
        isEnemy = false;
    }
    if(isEnemy) {
      self SetVisibleToPlayer(level.players[i]);
    }
  }
}
watchReconModelForDeath(parentEnt) {
  self endon("death");
  parentEnt waittill_any("death", "hacked");
  self delete();
}
resetReconModelOnEvent(eventName, owner) {
  self endon("death");
  for(;;) {
    level waittill(eventName, newOwner);
    if(isDefined(newOwner)) {
      owner = newOwner;
    }
    self resetReconModelVisibility(owner);
  }
}