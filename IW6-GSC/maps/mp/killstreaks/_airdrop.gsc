/********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\killstreaks\_airdrop.gsc
********************************************/

#include maps\mp\_utility;
#include common_scripts\utility;
#include maps\mp\gametypes\_hud_util;

CRATE_KILLCAM_OFFSET = (0, 0, 300);
GRAVITY_UNITS_PER_SECOND = 800;

DUMMY_CRATE_MODEL = "carepackage_dummy_iw6";
FRIENDLY_CRATE_MODEL = "carepackage_friendly_iw6";
ENEMY_CRATE_MODEL = "carepackage_enemy_iw6";

DUMMY_JUGGERNAUT_CRATE_MODEL = "mp_juggernaut_carepackage_dummy";
FRIENDLY_JUGGERNAUT_CRATE_MODEL = "mp_juggernaut_carepackage";
ENEMY_JUGGERNAUT_CRATE_MODEL = "mp_juggernaut_carepackage_red";

CONST_CRATE_OWNER_USE_TIME = 500;
CONST_CRATE_OTHER_USE_TIME = 3000;

init() {
  level._effect["airdrop_crate_destroy"] = LoadFX("vfx/gameplay/mp/killstreaks/vfx_airdrop_crate_dust_kickup");
  level._effect["airdrop_dust_kickup"] = LoadFX("vfx/gameplay/mp/killstreaks/vfx_airdrop_crate_dust_kickup");

  PrecacheMpAnim("juggernaut_carepackage");

  setAirDropCrateCollision("airdrop_crate");
  setAirDropCrateCollision("care_package");
  assert(isDefined(level.airDropCrateCollision));

  level.killStreakFuncs["airdrop_assault"] = ::tryUseAirdrop;
  level.killStreakFuncs["airdrop_support"] = ::tryUseAirdrop;
  level.killStreakFuncs["airdrop_juggernaut"] = ::tryUseAirdrop;
  level.killStreakFuncs["airdrop_juggernaut_recon"] = ::tryUseAirdrop;
  level.killStreakFuncs["airdrop_juggernaut_maniac"] = ::tryUseAirdrop;

  level.numDropCrates = 0;
  level.littleBirds = [];
  level.crateTypes = [];
  level.crateMaxVal = [];

  addCrateType("airdrop_assault", "uplink", 25, ::killstreakCrateThink, FRIENDLY_CRATE_MODEL, ENEMY_CRATE_MODEL, &"KILLSTREAKS_HINTS_UPLINK_PICKUP", DUMMY_CRATE_MODEL);
  addCrateType("airdrop_assault", "ims", 25, ::killstreakCrateThink, FRIENDLY_CRATE_MODEL, ENEMY_CRATE_MODEL, &"KILLSTREAKS_HINTS_IMS_PICKUP", DUMMY_CRATE_MODEL);
  addCrateType("airdrop_assault", "guard_dog", 20, ::killstreakCrateThink, FRIENDLY_CRATE_MODEL, ENEMY_CRATE_MODEL, &"KILLSTREAKS_HINTS_GUARD_DOG_PICKUP", DUMMY_CRATE_MODEL);
  addCrateType("airdrop_assault", "drone_hive", 20, ::killstreakCrateThink, FRIENDLY_CRATE_MODEL, ENEMY_CRATE_MODEL, &"KILLSTREAKS_HINTS_DRONE_HIVE_PICKUP", DUMMY_CRATE_MODEL);
  addCrateType("airdrop_assault", "sentry", 10, ::killstreakCrateThink, FRIENDLY_CRATE_MODEL, ENEMY_CRATE_MODEL, &"KILLSTREAKS_HINTS_SENTRY_PICKUP", DUMMY_CRATE_MODEL);
  addCrateType("airdrop_assault", "helicopter", 10, ::killstreakCrateThink, FRIENDLY_CRATE_MODEL, ENEMY_CRATE_MODEL, &"KILLSTREAKS_HINTS_HELICOPTER_PICKUP", DUMMY_CRATE_MODEL);
  addCrateType("airdrop_assault", "ball_drone_backup", 4, ::killstreakCrateThink, FRIENDLY_CRATE_MODEL, ENEMY_CRATE_MODEL, &"KILLSTREAKS_HINTS_BALL_DRONE_BACKUP_PICKUP", DUMMY_CRATE_MODEL);
  addCrateType("airdrop_assault", "vanguard", 4, ::killstreakCrateThink, FRIENDLY_CRATE_MODEL, ENEMY_CRATE_MODEL, &"KILLSTREAKS_HINTS_VANGUARD_PICKUP", DUMMY_CRATE_MODEL);
  addCrateType("airdrop_assault", "airdrop_juggernaut_maniac", 3, ::juggernautCrateThink, FRIENDLY_JUGGERNAUT_CRATE_MODEL, ENEMY_JUGGERNAUT_CRATE_MODEL, &"KILLSTREAKS_HINTS_JUGGERNAUT_MANIAC_PICKUP", DUMMY_JUGGERNAUT_CRATE_MODEL);
  addCrateType("airdrop_assault", "airdrop_juggernaut", 2, ::juggernautCrateThink, FRIENDLY_JUGGERNAUT_CRATE_MODEL, ENEMY_JUGGERNAUT_CRATE_MODEL, &"KILLSTREAKS_HINTS_JUGGERNAUT_PICKUP", DUMMY_JUGGERNAUT_CRATE_MODEL);
  addCrateType("airdrop_assault", "heli_pilot", 1, ::killstreakCrateThink, FRIENDLY_CRATE_MODEL, ENEMY_CRATE_MODEL, &"KILLSTREAKS_HINTS_HELI_PILOT_PICKUP", DUMMY_CRATE_MODEL);
  addCrateType("airdrop_assault", "odin_assault", 1, ::killstreakCrateThink, FRIENDLY_CRATE_MODEL, ENEMY_CRATE_MODEL, &"KILLSTREAKS_HINTS_ODIN_ASSAULT_PICKUP", DUMMY_CRATE_MODEL);

  addCrateType("airdrop_support", "uplink_support", 25, ::killstreakCrateThink, FRIENDLY_CRATE_MODEL, ENEMY_CRATE_MODEL, &"KILLSTREAKS_HINTS_UPLINK_PICKUP", DUMMY_CRATE_MODEL);
  addCrateType("airdrop_support", "deployable_vest", 25, ::killstreakCrateThink, FRIENDLY_CRATE_MODEL, ENEMY_CRATE_MODEL, &"KILLSTREAKS_HINTS_DEPLOYABLE_VEST_PICKUP", DUMMY_CRATE_MODEL);
  addCrateType("airdrop_support", "deployable_ammo", 20, ::killstreakCrateThink, FRIENDLY_CRATE_MODEL, ENEMY_CRATE_MODEL, &"KILLSTREAKS_HINTS_DEPLOYABLE_AMMO_PICKUP", DUMMY_CRATE_MODEL);
  addCrateType("airdrop_support", "ball_drone_radar", 20, ::killstreakCrateThink, FRIENDLY_CRATE_MODEL, ENEMY_CRATE_MODEL, &"KILLSTREAKS_HINTS_BALL_DRONE_RADAR_PICKUP", DUMMY_CRATE_MODEL);
  addCrateType("airdrop_support", "aa_launcher", 10, ::killstreakCrateThink, FRIENDLY_CRATE_MODEL, ENEMY_CRATE_MODEL, &"KILLSTREAKS_HINTS_AA_LAUNCHER_PICKUP", DUMMY_CRATE_MODEL);
  addCrateType("airdrop_support", "jammer", 10, ::killstreakCrateThink, FRIENDLY_CRATE_MODEL, ENEMY_CRATE_MODEL, &"KILLSTREAKS_HINTS_JAMMER_PICKUP", DUMMY_CRATE_MODEL);
  addCrateType("airdrop_support", "air_superiority", 4, ::killstreakCrateThink, FRIENDLY_CRATE_MODEL, ENEMY_CRATE_MODEL, &"KILLSTREAKS_HINTS_AIR_SUPERIORITY_PICKUP", DUMMY_CRATE_MODEL);
  addCrateType("airdrop_support", "recon_agent", 4, ::killstreakCrateThink, FRIENDLY_CRATE_MODEL, ENEMY_CRATE_MODEL, &"KILLSTREAKS_HINTS_RECON_AGENT_PICKUP", DUMMY_CRATE_MODEL);
  addCrateType("airdrop_support", "heli_sniper", 4, ::killstreakCrateThink, FRIENDLY_CRATE_MODEL, ENEMY_CRATE_MODEL, &"KILLSTREAKS_HINTS_HELI_SNIPER_PICKUP", DUMMY_CRATE_MODEL);
  addCrateType("airdrop_support", "uav_3dping", 3, ::killstreakCrateThink, FRIENDLY_CRATE_MODEL, ENEMY_CRATE_MODEL, &"KILLSTREAKS_HINTS_UAV_3DPING_PICKUP", DUMMY_CRATE_MODEL);
  addCrateType("airdrop_support", "airdrop_juggernaut_recon", 1, ::juggernautCrateThink, FRIENDLY_JUGGERNAUT_CRATE_MODEL, ENEMY_JUGGERNAUT_CRATE_MODEL, &"KILLSTREAKS_HINTS_JUGGERNAUT_RECON_PICKUP", DUMMY_JUGGERNAUT_CRATE_MODEL);
  addCrateType("airdrop_support", "odin_support", 1, ::killstreakCrateThink, FRIENDLY_CRATE_MODEL, ENEMY_CRATE_MODEL, &"KILLSTREAKS_HINTS_ODIN_SUPPORT_PICKUP", DUMMY_CRATE_MODEL);

  addCrateType("airdrop_juggernaut", "airdrop_juggernaut", 100, ::juggernautCrateThink, FRIENDLY_JUGGERNAUT_CRATE_MODEL, ENEMY_JUGGERNAUT_CRATE_MODEL, &"KILLSTREAKS_HINTS_JUGGERNAUT_PICKUP", DUMMY_JUGGERNAUT_CRATE_MODEL);
  addCrateType("airdrop_juggernaut_recon", "airdrop_juggernaut_recon", 100, ::juggernautCrateThink, FRIENDLY_JUGGERNAUT_CRATE_MODEL, ENEMY_JUGGERNAUT_CRATE_MODEL, &"KILLSTREAKS_HINTS_JUGGERNAUT_RECON_PICKUP", DUMMY_JUGGERNAUT_CRATE_MODEL);
  addCrateType("airdrop_juggernaut_maniac", "airdrop_juggernaut_maniac", 100, ::juggernautCrateThink, FRIENDLY_JUGGERNAUT_CRATE_MODEL, ENEMY_JUGGERNAUT_CRATE_MODEL, &"KILLSTREAKS_HINTS_JUGGERNAUT_MANIAC_PICKUP", DUMMY_JUGGERNAUT_CRATE_MODEL);

  addCrateType("airdrop_grnd", "uplink", 25, ::killstreakCrateThink, FRIENDLY_CRATE_MODEL, ENEMY_CRATE_MODEL, &"KILLSTREAKS_HINTS_UPLINK_PICKUP", DUMMY_CRATE_MODEL);
  addCrateType("airdrop_grnd", "ims", 25, ::killstreakCrateThink, FRIENDLY_CRATE_MODEL, ENEMY_CRATE_MODEL, &"KILLSTREAKS_HINTS_IMS_PICKUP", DUMMY_CRATE_MODEL);
  addCrateType("airdrop_grnd", "guard_dog", 20, ::killstreakCrateThink, FRIENDLY_CRATE_MODEL, ENEMY_CRATE_MODEL, &"KILLSTREAKS_HINTS_GUARD_DOG_PICKUP", DUMMY_CRATE_MODEL);
  addCrateType("airdrop_grnd", "drone_hive", 20, ::killstreakCrateThink, FRIENDLY_CRATE_MODEL, ENEMY_CRATE_MODEL, &"KILLSTREAKS_HINTS_DRONE_HIVE_PICKUP", DUMMY_CRATE_MODEL);
  addCrateType("airdrop_grnd", "sentry", 10, ::killstreakCrateThink, FRIENDLY_CRATE_MODEL, ENEMY_CRATE_MODEL, &"KILLSTREAKS_HINTS_SENTRY_PICKUP", DUMMY_CRATE_MODEL);
  addCrateType("airdrop_grnd", "helicopter", 10, ::killstreakCrateThink, FRIENDLY_CRATE_MODEL, ENEMY_CRATE_MODEL, &"KILLSTREAKS_HINTS_HELICOPTER_PICKUP", DUMMY_CRATE_MODEL);
  addCrateType("airdrop_grnd", "ball_drone_backup", 4, ::killstreakCrateThink, FRIENDLY_CRATE_MODEL, ENEMY_CRATE_MODEL, &"KILLSTREAKS_HINTS_BALL_DRONE_BACKUP_PICKUP", DUMMY_CRATE_MODEL);
  addCrateType("airdrop_grnd", "vanguard", 4, ::killstreakCrateThink, FRIENDLY_CRATE_MODEL, ENEMY_CRATE_MODEL, &"KILLSTREAKS_HINTS_VANGUARD_PICKUP", DUMMY_CRATE_MODEL);
  addCrateType("airdrop_grnd", "airdrop_juggernaut_maniac", 3, ::juggernautCrateThink, FRIENDLY_JUGGERNAUT_CRATE_MODEL, ENEMY_JUGGERNAUT_CRATE_MODEL, &"KILLSTREAKS_HINTS_JUGGERNAUT_MANIAC_PICKUP", DUMMY_JUGGERNAUT_CRATE_MODEL);
  addCrateType("airdrop_grnd", "airdrop_juggernaut", 2, ::juggernautCrateThink, FRIENDLY_JUGGERNAUT_CRATE_MODEL, ENEMY_JUGGERNAUT_CRATE_MODEL, &"KILLSTREAKS_HINTS_JUGGERNAUT_PICKUP", DUMMY_JUGGERNAUT_CRATE_MODEL);
  addCrateType("airdrop_grnd", "heli_pilot", 1, ::killstreakCrateThink, FRIENDLY_CRATE_MODEL, ENEMY_CRATE_MODEL, &"KILLSTREAKS_HINTS_HELI_PILOT_PICKUP", DUMMY_CRATE_MODEL);
  addCrateType("airdrop_grnd", "deployable_vest", 25, ::killstreakCrateThink, FRIENDLY_CRATE_MODEL, ENEMY_CRATE_MODEL, &"KILLSTREAKS_HINTS_DEPLOYABLE_VEST_PICKUP", DUMMY_CRATE_MODEL);
  addCrateType("airdrop_grnd", "deployable_ammo", 20, ::killstreakCrateThink, FRIENDLY_CRATE_MODEL, ENEMY_CRATE_MODEL, &"KILLSTREAKS_HINTS_DEPLOYABLE_AMMO_PICKUP", DUMMY_CRATE_MODEL);
  addCrateType("airdrop_grnd", "ball_drone_radar", 20, ::killstreakCrateThink, FRIENDLY_CRATE_MODEL, ENEMY_CRATE_MODEL, &"KILLSTREAKS_HINTS_BALL_DRONE_RADAR_PICKUP", DUMMY_CRATE_MODEL);
  addCrateType("airdrop_grnd", "aa_launcher", 20, ::killstreakCrateThink, FRIENDLY_CRATE_MODEL, ENEMY_CRATE_MODEL, &"KILLSTREAKS_HINTS_AA_LAUNCHER_PICKUP", DUMMY_CRATE_MODEL);
  addCrateType("airdrop_grnd", "jammer", 10, ::killstreakCrateThink, FRIENDLY_CRATE_MODEL, ENEMY_CRATE_MODEL, &"KILLSTREAKS_HINTS_JAMMER_PICKUP", DUMMY_CRATE_MODEL);
  addCrateType("airdrop_grnd", "air_superiority", 10, ::killstreakCrateThink, FRIENDLY_CRATE_MODEL, ENEMY_CRATE_MODEL, &"KILLSTREAKS_HINTS_AIR_SUPERIORITY_PICKUP", DUMMY_CRATE_MODEL);
  addCrateType("airdrop_grnd", "recon_agent", 15, ::killstreakCrateThink, FRIENDLY_CRATE_MODEL, ENEMY_CRATE_MODEL, &"KILLSTREAKS_HINTS_RECON_AGENT_PICKUP", DUMMY_CRATE_MODEL);
  addCrateType("airdrop_grnd", "heli_sniper", 10, ::killstreakCrateThink, FRIENDLY_CRATE_MODEL, ENEMY_CRATE_MODEL, &"KILLSTREAKS_HINTS_HELI_SNIPER_PICKUP", DUMMY_CRATE_MODEL);
  addCrateType("airdrop_grnd", "uav_3dping", 5, ::killstreakCrateThink, FRIENDLY_CRATE_MODEL, ENEMY_CRATE_MODEL, &"KILLSTREAKS_HINTS_UAV_3DPING_PICKUP", DUMMY_CRATE_MODEL);
  addCrateType("airdrop_grnd", "airdrop_juggernaut_recon", 5, ::juggernautCrateThink, FRIENDLY_JUGGERNAUT_CRATE_MODEL, ENEMY_JUGGERNAUT_CRATE_MODEL, &"KILLSTREAKS_HINTS_JUGGERNAUT_RECON_PICKUP", DUMMY_JUGGERNAUT_CRATE_MODEL);

  if(isDefined(level.customCrateFunc))
    [[level.customCrateFunc]](FRIENDLY_CRATE_MODEL, ENEMY_CRATE_MODEL);

  if(isDefined(level.mapCustomCrateFunc))
    [[level.mapCustomCrateFunc]]();

  generateMaxWeightedCrateValue();

  config = spawnStruct();
  config.xpPopup = "destroyed_airdrop";

  config.voDestroyed = undefined;
  config.callout = "callout_destroyed_airdrop";
  config.samDamageScale = 0.09;

  level.heliConfigs["airdrop"] = config;

  maps\mp\gametypes\_rank::registerScoreInfo("little_bird", 200);

  SetDevDvarIfUninitialized("scr_crateOverride", "");
  SetDevDvarIfUninitialized("scr_crateTypeOverride", "");

  SetDevDvarIfUninitialized("scr_airDrop_max_linear_velocity", 1200);
  SetDevDvarIfUninitialized("scr_airDrop_slowdown_max_linear_velocity", 600);
}

generateMaxWeightedCrateValue() {
  foreach(dropType, dropTypeArray in level.crateTypes) {
    level.crateMaxVal[dropType] = 0;
    foreach(crateType in dropTypeArray) {
      type = crateType.type;
      if(!level.crateTypes[dropType][type].raw_weight) {
        level.crateTypes[dropType][type].weight = level.crateTypes[dropType][type].raw_weight;
        continue;
      }

      level.crateMaxVal[dropType] += level.crateTypes[dropType][type].raw_weight;
      level.crateTypes[dropType][type].weight = level.crateMaxVal[dropType];
    }
  }
}

changeCrateWeight(dropType, crateType, crateWeight) {
  if(!isDefined(level.crateTypes[dropType]) || !isDefined(level.crateTypes[dropType][crateType])) {
    return;
  }
  level.crateTypes[dropType][crateType].raw_weight = crateWeight;
  generateMaxWeightedCrateValue();
}

setAirDropCrateCollision(carePackageName) {
  airDropCrates = getEntArray(carePackageName, "targetname");

  if(!isDefined(airDropCrates) || (airDropCrates.size == 0)) {
    return;
  }

  level.airDropCrateCollision = GetEnt(airDropCrates[0].target, "targetname");

  foreach(crate in airDropCrates) {
    crate deleteCrate();
  }
}

addCrateType(dropType, crateType, crateWeight, crateFunc, crateModelFriendly, crateModelEnemy, hintString, optionalHint, crateModelDummy) {
  if(!isDefined(crateModelFriendly))
    crateModelFriendly = FRIENDLY_CRATE_MODEL;
  if(!isDefined(crateModelEnemy))
    crateModelEnemy = ENEMY_CRATE_MODEL;
  if(!isDefined(crateModelDummy))
    crateModelDummy = DUMMY_CRATE_MODEL;

  level.crateTypes[dropType][crateType] = spawnStruct();
  level.crateTypes[dropType][crateType].dropType = dropType;
  level.crateTypes[dropType][crateType].type = crateType;
  level.crateTypes[dropType][crateType].raw_weight = crateWeight;
  level.crateTypes[dropType][crateType].weight = crateWeight;
  level.crateTypes[dropType][crateType].func = crateFunc;
  level.crateTypes[dropType][crateType].model_name_friendly = crateModelFriendly;
  level.crateTypes[dropType][crateType].model_name_enemy = crateModelEnemy;
  level.crateTypes[dropType][crateType].model_name_dummy = crateModelDummy;

  if(isDefined(hintString))
    game["strings"][crateType + "_hint"] = hintString;

  if(isDefined(optionalHint))
    game["strings"][crateType + "_optional_hint"] = optionalHint;
}

getRandomCrateType(dropType) {
  value = RandomInt(level.crateMaxVal[dropType]);

  selectedCrateType = undefined;
  foreach(crateType in level.crateTypes[dropType]) {
    type = crateType.type;
    if(!level.crateTypes[dropType][type].weight) {
      continue;
    }
    selectedCrateType = type;

    if(level.crateTypes[dropType][type].weight > value) {
      break;
    }
  }

  return (selectedCrateType);
}

getCrateTypeForDropType(dropType) {
  switch (dropType) {
    case "airdrop_sentry_minigun":
      return "sentry";
    case "airdrop_predator_missile":
      return "predator_missile";
    case "airdrop_juggernaut":
      return "airdrop_juggernaut";
    case "airdrop_juggernaut_def":
      return "airdrop_juggernaut_def";
    case "airdrop_juggernaut_gl":
      return "airdrop_juggernaut_gl";
    case "airdrop_juggernaut_recon":
      return "airdrop_juggernaut_recon";
    case "airdrop_juggernaut_maniac":
      return "airdrop_juggernaut_maniac";
    case "airdrop_remote_tank":
      return "remote_tank";
    case "airdrop_lase":
      return "lasedStrike";
    case "airdrop_assault":
    case "airdrop_support":
    case "airdrop_escort":
    case "airdrop_mega":
    case "airdrop_grnd":
    case "airdrop_grnd_mega":
    case "airdrop_sotf":
    default:
      if(isDefined(level.getRandomCrateTypeForGameMode))
        return [
          [level.getRandomCrateTypeForGameMode]
        ](dropType);

      return getRandomCrateType(dropType);
  }
}

tryUseAirdrop(lifeId, streakName) {
  dropType = streakName;
  result = undefined;

  if(!isDefined(dropType))
    dropType = "airdrop_assault";

  numIncomingVehicles = 1;
  if((level.littleBirds.size >= 4 || level.fauxVehicleCount >= 4) && dropType != "airdrop_mega" && !isSubStr(toLower(dropType), "juggernaut")) {
    self iPrintLnBold(&"KILLSTREAKS_AIR_SPACE_TOO_CROWDED");
    return false;
  } else if(currentActiveVehicleCount() >= maxVehiclesAllowed() || level.fauxVehicleCount + numIncomingVehicles >= maxVehiclesAllowed()) {
    self iPrintLnBold(&"KILLSTREAKS_TOO_MANY_VEHICLES");
    return false;
  } else if(dropType == "airdrop_lase" && isDefined(level.lasedStrikeCrateActive) && level.lasedStrikeCrateActive) {
    self iPrintLnBold(&"KILLSTREAKS_AIR_SPACE_TOO_CROWDED");
    return false;
  }

  if(dropType != "airdrop_mega" && !isSubStr(toLower(dropType), "juggernaut")) {
    self thread watchDisconnect();
  }

  if(!IsSubStr(dropType, "juggernaut"))
    incrementFauxVehicleCount();

  result = self beginAirdropViaMarker(lifeId, dropType);

  if((!isDefined(result) || !result)) {
    self notify("markerDetermined");

    decrementFauxVehicleCount();

    return false;
  }

  if(dropType == "airdrop_mega")
    thread teamPlayerCardSplash("used_airdrop_mega", self);

  self notify("markerDetermined");

  self maps\mp\_matchdata::logKillstreakEvent(dropType, self.origin);

  return true;
}

watchDisconnect() {
  self endon("markerDetermined");

  self waittill("disconnect");
  return;
}

beginAirdropViaMarker(lifeId, dropType) {
  self notify("beginAirdropViaMarker");
  self endon("beginAirdropViaMarker");

  self endon("disconnect");
  level endon("game_ended");

  self.threwAirDropMarker = undefined;
  self.threwAirDropMarkerIndex = undefined;
  self thread watchAirDropWeaponChange(lifeId, dropType);
  self thread watchAirDropMarkerUsage(lifeId, dropType);
  self thread watchAirDropMarker(lifeId, dropType);

  result = self waittill_any_return("notAirDropWeapon", "markerDetermined");
  if(isDefined(result) && result == "markerDetermined")
    return true;

  else if(!isDefined(result) && isDefined(self.threwAirDropMarker))
    return true;

  return false;
}

watchAirDropWeaponChange(lifeId, dropType) {
  level endon("game_ended");

  self notify("watchAirDropWeaponChange");
  self endon("watchAirDropWeaponChange");

  self endon("disconnect");
  self endon("markerDetermined");

  while(self isChangingWeapon())
    wait(0.05);

  currentWeapon = self getCurrentWeapon();

  if(maps\mp\killstreaks\_killstreaks::isAirdropMarker(currentWeapon))
    airdropMarkerWeapon = currentWeapon;
  else
    airdropMarkerWeapon = undefined;

  while(maps\mp\killstreaks\_killstreaks::isAirdropMarker(currentWeapon)) {
    self waittill("weapon_switch_started", currentWeapon);

    if(maps\mp\killstreaks\_killstreaks::isAirdropMarker(currentWeapon))
      airdropMarkerWeapon = currentWeapon;
  }

  if(isDefined(self.threwAirDropMarker)) {
    killstreakWeapon = getKillstreakWeapon(self.pers["killstreaks"][self.threwAirDropMarkerIndex].streakName);
    self TakeWeapon(killstreakWeapon);

    self notify("markerDetermined");
  } else
    self notify("notAirDropWeapon");
}

watchAirDropMarkerUsage(lifeId, dropType) {
  level endon("game_ended");

  self notify("watchAirDropMarkerUsage");
  self endon("watchAirDropMarkerUsage");

  self endon("disconnect");
  self endon("markerDetermined");

  while(true) {
    self waittill("grenade_pullback", weaponName);

    if(!maps\mp\killstreaks\_killstreaks::isAirdropMarker(weaponName)) {
      continue;
    }
    self _disableUsability();

    self beginAirDropMarkerTracking();
  }
}

watchAirDropMarker(lifeId, dropType) {
  level endon("game_ended");

  self notify("watchAirDropMarker");
  self endon("watchAirDropMarker");

  self endon("disconnect");
  self endon("markerDetermined");

  while(true) {
    self waittill("grenade_fire", airDropWeapon, weapname);

    if(!maps\mp\killstreaks\_killstreaks::isAirdropMarker(weapname)) {
      continue;
    }
    self.threwAirDropMarker = true;
    self.threwAirDropMarkerIndex = self.killstreakIndexWeapon;
    airDropWeapon thread airdropDetonateOnStuck();

    airDropWeapon.owner = self;
    airDropWeapon.weaponName = weapname;

    airDropWeapon thread airDropMarkerActivate(dropType);
  }
}

beginAirDropMarkerTracking() {
  level endon("game_ended");

  self notify("beginAirDropMarkerTracking");
  self endon("beginAirDropMarkerTracking");

  self endon("death");
  self endon("disconnect");

  self waittill_any("grenade_fire", "weapon_change");
  self _enableUsability();
}

airDropMarkerActivate(dropType, lifeId) {
  level endon("game_ended");

  self notify("airDropMarkerActivate");
  self endon("airDropMarkerActivate");

  self waittill("explode", position);

  owner = self.owner;

  if(!isDefined(owner)) {
    return;
  }
  if(owner isKillStreakDenied()) {
    return;
  }
  if(IsSubStr(toLower(dropType), "escort_airdrop") && isDefined(level.chopper)) {
    return;
  }
  wait 0.05;

  if(IsSubStr(toLower(dropType), "juggernaut"))
    level doC130FlyBy(owner, position, randomFloat(360), dropType);
  else if(IsSubStr(toLower(dropType), "escort_airdrop"))
    owner maps\mp\killstreaks\_escortairdrop::finishSupportEscortUsage(lifeId, position, randomFloat(360), "escort_airdrop");
  else
    level doFlyBy(owner, position, randomFloat(360), dropType);
}

initAirDropCrate() {
  self.inUse = false;
  self hide();

  if(isDefined(self.target)) {
    self.collision = getEnt(self.target, "targetname");
    self.collision notSolid();
  } else {
    self.collision = undefined;
  }
}

deleteOnOwnerDeath(owner) {
  wait(0.25);
  self linkTo(owner, "tag_origin", (0, 0, 0), (0, 0, 0));

  owner waittill("death");

  self delete();
}

crateTeamModelUpdater() {
  self endon("death");

  self hide();
  foreach(player in level.players) {
    if(player.team != "spectator")
      self ShowToPlayer(player);
  }

  for(;;) {
    level waittill("joined_team");

    self hide();
    foreach(player in level.players) {
      if(player.team != "spectator")
        self ShowToPlayer(player);
    }
  }
}

crateModelTeamUpdater(showForTeam) {
  self endon("death");

  self hide();

  foreach(player in level.players) {
    if(player.team == "spectator") {
      if(showForTeam == "allies")
        self ShowToPlayer(player);
    } else if(player.team == showForTeam)
      self ShowToPlayer(player);
  }

  for(;;) {
    level waittill("joined_team");

    self hide();
    foreach(player in level.players) {
      if(player.team == "spectator") {
        if(showForTeam == "allies")
          self ShowToPlayer(player);
      } else if(player.team == showForTeam)
        self ShowToPlayer(player);
    }
  }
}

crateModelEnemyTeamsUpdater(ownerTeam) {
  self endon("death");

  self hide();

  foreach(player in level.players) {
    if(player.team != ownerTeam)
      self ShowToPlayer(player);
  }

  for(;;) {
    level waittill("joined_team");

    self hide();
    foreach(player in level.players) {
      if(player.team != ownerTeam)
        self ShowToPlayer(player);
    }
  }
}

crateModelPlayerUpdater(owner, friendly) {
  self endon("death");

  self hide();

  foreach(player in level.players) {
    if(friendly && isDefined(owner) && player != owner)
      continue;
    if(!friendly && isDefined(owner) && player == owner) {
      continue;
    }
    self ShowToPlayer(player);
  }

  for(;;) {
    level waittill("joined_team");

    self hide();
    foreach(player in level.players) {
      if(friendly && isDefined(owner) && player != owner)
        continue;
      if(!friendly && isDefined(owner) && player == owner) {
        continue;
      }
      self ShowToPlayer(player);
    }
  }
}

crateUseTeamUpdater(team) {
  self endon("death");

  for(;;) {
    setUsableByTeam(team);

    level waittill("joined_team");
  }
}

crateUseTeamUpdater_multiTeams(team) {
  self endon("death");

  for(;;) {
    setUsableByOtherTeams(team);

    level waittill("joined_team");

  }
}

crateUseJuggernautUpdater() {
  if(!isSubStr(self.crateType, "juggernaut")) {
    return;
  }
  self endon("death");
  level endon("game_ended");

  for(;;) {
    level waittill("juggernaut_equipped", player);

    self disablePlayerUse(player);
    self thread crateUsePostJuggernautUpdater(player);
  }
}

crateUsePostJuggernautUpdater(player) {
  self endon("death");
  level endon("game_ended");
  player endon("disconnect");

  player waittill("death");
  self enablePlayerUse(player);
}

createAirDropCrate(owner, dropType, crateType, startPos, dropPoint, crateColor) {
  dropCrate = spawn("script_model", startPos);

  dropCrate.curProgress = 0;
  dropCrate.useTime = 0;
  dropCrate.useRate = 0;
  dropCrate.team = self.team;
  dropCrate.destination = dropPoint;
  dropCrate.id = "care_package";

  if(isDefined(owner))
    dropCrate.owner = owner;
  else
    dropCrate.owner = undefined;

  dropCrate.crateType = crateType;
  dropCrate.dropType = dropType;
  dropCrate.targetname = "care_package";

  dummy_model = DUMMY_CRATE_MODEL;
  if(isDefined(level.custom_dummy_crate_model))
    dummy_model = level.custom_dummy_crate_model;

  dropCrate setModel(dummy_model);

  if(crateType == "airdrop_jackpot") {
    dropCrate.friendlyModel = spawn("script_model", startPos);
    dropCrate.friendlyModel setModel(level.crateTypes[dropType][crateType].model_name_friendly);
    dropCrate.friendlyModel thread deleteOnOwnerDeath(dropCrate);
  } else {
    dropCrate.friendlyModel = spawn("script_model", startPos);
    dropCrate.friendlyModel setModel(level.crateTypes[dropType][crateType].model_name_friendly);

    if(isDefined(level.highLightAirDrop) && level.highLightAirDrop) {
      if(!isDefined(crateColor))
        crateColor = 2;

      dropCrate.friendlyModel HudOutlineEnable(crateColor, false);
      dropCrate.outlineColor = crateColor;
    }

    dropCrate.enemyModel = spawn("script_model", startPos);
    dropCrate.enemyModel setModel(level.crateTypes[dropType][crateType].model_name_enemy);

    dropCrate.friendlyModel SetEntityOwner(dropCrate);
    dropCrate.enemyModel SetEntityOwner(dropCrate);

    dropCrate.friendlyModel thread deleteOnOwnerDeath(dropCrate);
    if(level.teambased)
      dropCrate.friendlyModel thread crateModelTeamUpdater(dropCrate.team);
    else
      dropCrate.friendlyModel thread crateModelPlayerUpdater(owner, true);

    dropCrate.enemyModel thread deleteOnOwnerDeath(dropCrate);
    if(level.multiTeambased)
      dropCrate.enemyModel thread crateModelEnemyTeamsUpdater(dropCrate.team);
    else if(level.teambased)
      dropCrate.enemyModel thread crateModelTeamUpdater(level.otherTeam[dropCrate.team]);
    else
      dropCrate.enemyModel thread crateModelPlayerUpdater(owner, false);
  }

  dropCrate.inUse = false;

  dropCrate CloneBrushmodelToScriptmodel(level.airDropCrateCollision);
  dropCrate thread entity_path_disconnect_thread(1.0);

  dropCrate.killCamEnt = spawn("script_model", dropCrate.origin + CRATE_KILLCAM_OFFSET, 0, true);
  dropCrate.killCamEnt SetScriptMoverKillCam("explosive");
  dropCrate.killCamEnt LinkTo(dropCrate);

  level.numDropCrates++;
  dropCrate thread dropCrateExistence(dropPoint);
  level notify("createAirDropCrate", dropCrate);

  return dropCrate;
}

dropCrateExistence(dropPoint) {
  level endon("game_ended");

  self waittill("death");

  if(isDefined(level.crateKill))
    [[level.crateKill]](dropPoint);

  level.numDropCrates--;
}

crateSetupForUse(hintString, icon) {
  self setCursorHint("HINT_NOICON");
  self setHintString(hintString);
  self makeUsable();

  friendlyShader = "compass_objpoint_ammo_friendly";
  enemyShader = "compass_objpoint_ammo_enemy";

  if(isDefined(level.objVisAll))
    enemyShader = "compass_objpoint_ammo_friendly";

  if(!isDefined(self.objIdFriendly))
    self.objIdFriendly = createObjective(friendlyShader, self.team, true);

  if(!isDefined(self.objIdEnemy))
    self.objIdEnemy = createObjective(enemyShader, level.otherTeam[self.team], false);

  self thread crateUseTeamUpdater();
  self thread crateUseJuggernautUpdater();

  if(isSubStr(self.crateType, "juggernaut")) {
    foreach(player in level.players)
    if(player isJuggernaut())
      self thread crateUsePostJuggernautUpdater(player);
  }

  headIcon = undefined;
  if(level.teamBased)
    headIcon = self maps\mp\_entityheadIcons::setHeadIcon(self.team, icon, (0, 0, 24), 14, 14, false, undefined, undefined, undefined, undefined, false);
  else if(isDefined(self.owner))
    headIcon = self maps\mp\_entityheadIcons::setHeadIcon(self.owner, icon, (0, 0, 24), 14, 14, false, undefined, undefined, undefined, undefined, false);
  if(isDefined(headIcon))
    headIcon.showInKillcam = false;

  if(isDefined(level.iconVisAll))
    [[level.iconVisAll]](self, icon);
  else {
    foreach(player in level.players) {
      if(player.team == "spectator")
        headIcon = self maps\mp\_entityheadIcons::setHeadIcon(player, icon, (0, 0, 24), 14, 14, false, undefined, undefined, undefined, undefined, false);
    }
  }
}

createObjective(shaderName, team, friendly) {
  curObjID = maps\mp\gametypes\_gameobjects::getNextObjID();
  objective_add(curObjID, "invisible", (0, 0, 0));
  if(!isDefined(self GetLinkedParent()))
    Objective_Position(curObjID, self.origin);
  else
    Objective_OnEntity(curObjID, self);
  objective_state(curObjID, "active");

  objective_icon(curObjID, shaderName);

  if(!level.teamBased && isDefined(self.owner))
    if(friendly)
      Objective_PlayerTeam(curObjId, self.owner GetEntityNumber());
    else
      Objective_PlayerEnemyTeam(curObjId, self.owner GetEntityNumber());
  else
    Objective_Team(curObjID, team);

  if(isDefined(level.objVisAll))
    [[level.objVisAll]](curObjID);

  return curObjID;
}

setUsableByTeam(team) {
  foreach(player in level.players) {
    if(isSubStr(self.crateType, "juggernaut") && player isJuggernaut()) {
      self DisablePlayerUse(player);
    } else if(isSubStr(self.crateType, "lased") && isDefined(player.hasSoflam) && player.hasSoflam) {
      self DisablePlayerUse(player);
    } else if(!isDefined(team) || team == player.team)
      self EnablePlayerUse(player);
    else
      self DisablePlayerUse(player);
  }
}

setUsableByOtherTeams(team) {
  foreach(player in level.players) {
    if(isSubStr(self.crateType, "juggernaut") && player isJuggernaut()) {
      self DisablePlayerUse(player);
    } else if(!isDefined(team) || team != player.team)
      self EnablePlayerUse(player);
    else
      self DisablePlayerUse(player);
  }
}

dropTheCrate(dropPoint, dropType, lbHeight, dropImmediately, crateOverride, startPos, dropImpulse, previousCrateTypes, tagName) {
  dropCrate = [];
  self.owner endon("disconnect");

  if(!isDefined(crateOverride)) {
    if(isDefined(previousCrateTypes)) {
      foundDupe = undefined;
      crateType = undefined;
      for(i = 0; i < 100; i++) {
        crateType = getCrateTypeForDropType(dropType);
        foundDupe = false;
        for(j = 0; j < previousCrateTypes.size; j++) {
          if(crateType == previousCrateTypes[j]) {
            foundDupe = true;
            break;
          }
        }
        if(foundDupe == false) {
          break;
        }
      }

      if(foundDupe == true) {
        crateType = getCrateTypeForDropType(dropType);
      }
    } else
      crateType = getCrateTypeForDropType(dropType);
  } else
    crateType = crateOverride;

  if(!isDefined(dropImpulse))
    dropImpulse = (RandomInt(50), RandomInt(50), RandomInt(50));

  dropCrate = createAirDropCrate(self.owner, dropType, crateType, startPos, dropPoint);

  switch (dropType) {
    case "airdrop_mega":
    case "nuke_drop":
    case "airdrop_juggernaut":
    case "airdrop_juggernaut_recon":
    case "airdrop_juggernaut_maniac":
      dropCrate LinkTo(self, "tag_ground", (64, 32, -128), (0, 0, 0));
      break;
    case "airdrop_escort":
    case "airdrop_osprey_gunner":
      dropCrate LinkTo(self, tagName, (0, 0, 0), (0, 0, 0));
      break;
    default:
      dropCrate LinkTo(self, "tag_ground", (32, 0, 5), (0, 0, 0));
      break;
  }

  dropCrate.angles = (0, 0, 0);
  dropCrate show();
  dropSpeed = self.veh_speed;

  if(IsSubStr(crateType, "juggernaut"))
    dropImpulse = (0, 0, 0);

  self thread waitForDropCrateMsg(dropCrate, dropImpulse, dropType, crateType);
  dropCrate.droppingToGround = true;

  return crateType;
}

killPlayerFromCrate_DoDamage(hitEnt) {
  if(isDefined(level.noAirDropKills) && level.noAirDropKills) {
    return;
  }
  hitEnt DoDamage(1000, hitEnt.origin, self, self, "MOD_CRUSH");
}

killPlayerFromCrate_FastVelocityPush() {
  self endon("death");

  while(1) {
    self waittill("player_pushed", hitEnt, platformMPH);
    if(isPlayer(hitEnt) || isAgent(hitEnt)) {
      if(platformMPH[2] < -20) {
        self killPlayerFromCrate_DoDamage(hitEnt);
      }
    }
    wait 0.05;
  }
}

airdrop_override_death_moving_platform(data) {
  if(isDefined(data.lastTouchedPlatform.destroyAirdropOnCollision) && data.lastTouchedPlatform.destroyAirdropOnCollision) {
    playFX(getfx("airdrop_crate_destroy"), self.origin);
    self deleteCrate();
  }
}

cleanup_crate_capture() {
  children = self GetLinkedChildren(true);
  if(!isDefined(children)) {
    return;
  }

  foreach(player in children) {
    if(!IsPlayer(player)) {
      continue;
    }
    if(isDefined(player.isCapturingCrate) && player.isCapturingCrate) {
      parent = player GetLinkedParent();
      if(isDefined(parent)) {
        player maps\mp\gametypes\_gameobjects::updateUIProgress(parent, false);
        player unlink();
      }

      if(isAlive(player))
        player _enableWeapon();

      player.isCapturingCrate = false;
    }
  }
}

airdrop_override_invalid_moving_platform(data) {
  wait(0.05);

  self notify("restarting_physics");
  self cleanup_crate_capture();
  self PhysicsLaunchServer((0, 0, 0), data.dropImpulse, data.airDrop_max_linear_velocity);
  self thread physicsUpdater(data.dropType, data.crateType);
  self thread physicsWaiter(data.dropType, data.crateType, data.dropImpulse, data.airDrop_max_linear_velocity);
}

waitForDropCrateMsg(dropCrate, dropImpulse, dropType, crateType, optionalVelocity, dropImmediately) {
  dropCrate endon("death");

  if(!isDefined(dropImmediately) || !dropImmediately)
    self waittill("drop_crate");

  airDrop_max_linear_velocity = 1200;

  airDrop_max_linear_velocity = getdvarfloat("scr_airDrop_max_linear_velocity", 1200);

  if(isDefined(optionalVelocity))
    airDrop_max_linear_velocity = optionalVelocity;

  dropCrate Unlink();
  dropCrate PhysicsLaunchServer((0, 0, 0), dropImpulse, airDrop_max_linear_velocity);
  dropCrate thread physicsUpdater(dropType, crateType);
  dropCrate thread physicsWaiter(dropType, crateType, dropImpulse, airDrop_max_linear_velocity);
  dropCrate thread killPlayerFromCrate_FastVelocityPush();
  dropCrate.unresolved_collision_func = ::killPlayerFromCrate_DoDamage;

  if(isDefined(dropCrate.killCamEnt)) {
    if(isDefined(dropCrate.carestrike)) {
      horizontal_offset = -2100;
    } else
      horizontal_offset = 0;

    dropCrate.killCamEnt Unlink();
    groundTrace = bulletTrace(dropCrate.origin, dropCrate.origin + (0, 0, -10000), false, dropCrate);
    travelDistance = Distance(dropCrate.origin, groundTrace["position"]);

    travelTime = travelDistance / GRAVITY_UNITS_PER_SECOND;

    dropCrate.killCamEnt MoveTo(groundTrace["position"] + CRATE_KILLCAM_OFFSET + (horizontal_offset, 0, 0), travelTime);

  }
}

physicsUpdater(dropType, crateType) {
  self endon("restarting_physics");
  self endon("physics_finished");

  wait(0.5);

  while(true) {
    if(!isDefined(self)) {
      return;
    }
    groundTrace = bulletTrace(self.origin, self.origin + (0, 0, -60), false, self, false, false, false, true);
    if(groundTrace["fraction"] < 1.0) {
      airDrop_slowdown_max_linear_velocity = 600;

      airDrop_slowdown_max_linear_velocity = getdvarfloat("scr_airDrop_slowdown_max_linear_velocity", 600);

      self PhysicsSetMaxLinVel(airDrop_slowdown_max_linear_velocity);
      self thread waitAndAnimate();
      return;
    }

    waitframe();
  }
}

waitAndAnimate() {
  self endon("death");

  wait(0.035);

  playFX(level._effect["airdrop_dust_kickup"], self.origin + (0, 0, 5), (0, 0, 1));
  self.friendlyModel ScriptModelPlayAnim("juggernaut_carepackage");
  self.enemyModel ScriptModelPlayAnim("juggernaut_carepackage");
}

physicsWaiter(dropType, crateType, dropImpulse, airDrop_max_linear_velocity) {
  self endon("restarting_physics");
  self waittill("physics_finished");

  self.droppingToGround = false;
  self thread[[level.crateTypes[dropType][crateType].func]](dropType);
  level thread dropTimeOut(self, self.owner, crateType);

  data = spawnStruct();
  data.endonString = "restarting_physics";
  data.deathOverrideCallback = ::airdrop_override_death_moving_platform;
  data.invalidParentOverrideCallback = ::airdrop_override_invalid_moving_platform;
  data.dropType = dropType;
  data.crateType = crateType;
  data.dropImpulse = dropImpulse;
  data.airDrop_max_linear_velocity = airDrop_max_linear_velocity;
  self thread maps\mp\_movers::handle_moving_platforms(data);

  if(self.friendlyModel touchingBadTrigger()) {
    self deleteCrate();
    return;
  }

  if(isDefined(self.owner) && (abs(self.origin[2] - self.owner.origin[2]) > 3000)) {
    self deleteCrate();
  }
}

dropTimeOut(dropCrate, owner, crateType) {
  if(isDefined(level.noCrateTimeOut) && (level.noCrateTimeOut)) {
    return;
  }
  level endon("game_ended");
  dropCrate endon("death");

  if(dropCrate.dropType == "nuke_drop") {
    return;
  }
  timeOut = 90.0;
  if(crateType == "supply")
    timeOut = 20.0;

  maps\mp\gametypes\_hostmigration::waitLongDurationWithHostMigrationPause(timeOut);

  while(dropCrate.curProgress != 0)
    wait 1;

  dropCrate deleteCrate();
}

getPathStart(coord, yaw) {
  pathRandomness = 100;
  lbHalfDistance = 15000;

  direction = (0, yaw, 0);

  startPoint = coord + (anglesToForward(direction) * (-1 * lbHalfDistance));
  startPoint += ((randomfloat(2) - 1) * pathRandomness, (randomfloat(2) - 1) * pathRandomness, 0);

  return startPoint;
}

getPathEnd(coord, yaw) {
  pathRandomness = 150;
  lbHalfDistance = 15000;

  direction = (0, yaw, 0);

  endPoint = coord + (anglesToForward(direction + (0, 90, 0)) * lbHalfDistance);
  endPoint += ((randomfloat(2) - 1) * pathRandomness, (randomfloat(2) - 1) * pathRandomness, 0);

  return endPoint;
}

getFlyHeightOffset(dropSite) {
  lbFlyHeight = 850;

  heightEnt = GetEnt("airstrikeheight", "targetname");

  if(!isDefined(heightEnt)) {
    println("NO DEFINED AIRSTRIKE HEIGHT SCRIPT_ORIGIN IN LEVEL");

    if(isDefined(level.airstrikeHeightScale)) {
      if(level.airstrikeHeightScale > 2) {
        lbFlyHeight = 1500;
        return (lbFlyHeight * (level.airStrikeHeightScale));
      }

      return (lbFlyHeight * level.airStrikeHeightScale + 256 + dropSite[2]);
    } else
      return (lbFlyHeight + dropsite[2]);
  } else {
    return heightEnt.origin[2];
  }

}

doFlyBy(owner, dropSite, dropYaw, dropType, heightAdjustment, crateOverride) {
  if(!isDefined(owner)) {
    return;
  }
  if(currentActiveVehicleCount() >= maxVehiclesAllowed()) {
    return;
  }
  flyHeight = self getFlyHeightOffset(dropSite);
  if(isDefined(heightAdjustment))
    flyHeight += heightAdjustment;
  foreach(littlebird in level.littlebirds) {
    if(isDefined(littlebird.dropType))
      flyHeight += 128;
  }

  pathGoal = dropSite * (1, 1, 0) + (0, 0, flyHeight);
  pathStart = getPathStart(pathGoal, dropYaw);
  pathEnd = getPathEnd(pathGoal, dropYaw);

  pathGoal = pathGoal + (anglesToForward((0, dropYaw, 0)) * -50);

  chopper = heliSetup(owner, pathStart, pathGoal);

  if(isDefined(level.highLightAirDrop) && level.highLightAirDrop)
    chopper HudOutlineEnable(3, false);

  assert(isDefined(chopper));

  chopper endon("death");

  if(GetDvar("scr_crateOverride") != "") {
    crateOverride = GetDvar("scr_crateOverride");
    dropType = GetDvar("scr_crateTypeOverride");
  }

  chopper.dropType = dropType;

  chopper setVehGoalPos(pathGoal, 1);

  chopper thread dropTheCrate(dropSite, dropType, flyHeight, false, crateOverride, pathStart);

  wait(2);

  chopper Vehicle_SetSpeed(75, 40);
  chopper SetYawSpeed(180, 180, 180, .3);

  chopper waittill("goal");
  wait(.10);
  chopper notify("drop_crate");
  chopper setvehgoalpos(pathEnd, 1);
  chopper Vehicle_SetSpeed(300, 75);
  chopper.leaving = true;
  chopper waittill("goal");
  chopper notify("leaving");
  chopper notify("delete");

  decrementFauxVehicleCount();

  chopper delete();
}

doMegaFlyBy(owner, dropSite, dropYaw, dropType) {
  level thread doFlyBy(owner, dropSite, dropYaw, dropType, 0);
  wait(RandomIntRange(1, 2));
  level thread doFlyBy(owner, dropSite + (128, 128, 0), dropYaw, dropType, 128);
  wait(RandomIntRange(1, 2));
  level thread doFlyBy(owner, dropSite + (172, 256, 0), dropYaw, dropType, 256);
  wait(RandomIntRange(1, 2));
  level thread doFlyBy(owner, dropSite + (64, 0, 0), dropYaw, dropType, 0);
}

doC130FlyBy(owner, dropSite, dropYaw, dropType) {
  planeHalfDistance = 18000;
  planeFlySpeed = 3000;
  yaw = VectorToYaw(dropsite - owner.origin);

  direction = (0, yaw, 0);

  flyHeight = self getFlyHeightOffset(dropSite);

  pathStart = dropSite + (anglesToForward(direction) * (-1 * planeHalfDistance));
  pathStart = pathStart * (1, 1, 0) + (0, 0, flyHeight);

  pathEnd = dropSite + (anglesToForward(direction) * planeHalfDistance);
  pathEnd = pathEnd * (1, 1, 0) + (0, 0, flyHeight);

  d = length(pathStart - pathEnd);
  flyTime = (d / planeFlySpeed);

  c130 = c130Setup(owner, pathStart, pathEnd);
  c130.veh_speed = planeFlySpeed;
  c130.dropType = dropType;
  c130 playLoopSound("veh_ac130_dist_loop");

  c130.angles = direction;
  forward = anglesToForward(direction);
  c130 MoveTo(pathEnd, flyTime, 0, 0);

  minDist = Distance2D(c130.origin, dropSite);
  boomPlayed = false;

  for(;;) {
    dist = Distance2D(c130.origin, dropSite);

    if(dist < minDist)
      minDist = dist;
    else if(dist > minDist) {
      break;
    }

    if(dist < 320) {
      break;
    } else if(dist < 768) {
      earthquake(0.15, 1.5, dropSite, 1500);
      if(!boomPlayed) {
        c130 playSound("veh_ac130_sonic_boom");

        boomPlayed = true;
      }
    }

    wait(.05);
  }
  wait(0.05);

  dropImpulse = (0, 0, 0);

  if(!is_aliens()) {
    crateType[0] = c130 thread dropTheCrate(dropSite, dropType, flyHeight, false, undefined, pathStart, dropImpulse);
  }
  wait(0.05);
  c130 notify("drop_crate");

  newPathEnd = dropSite + (anglesToForward(direction) * (planeHalfDistance * 1.5));
  c130 MoveTo(newPathEnd, flyTime / 2, 0, 0);

  wait(6);
  c130 delete();
}

doMegaC130FlyBy(owner, dropSite, dropYaw, dropType, forwardOffset) {
  planeHalfDistance = 24000;
  planeFlySpeed = 2000;
  yaw = VectorToYaw(dropsite - owner.origin);
  direction = (0, yaw, 0);
  forward = anglesToForward(direction);

  if(isDefined(forwardOffset))
    dropSite = dropSite + forward * forwardOffset;

  flyHeight = self getFlyHeightOffset(dropSite);

  pathStart = dropSite + (anglesToForward(direction) * (-1 * planeHalfDistance));
  pathStart = pathStart * (1, 1, 0) + (0, 0, flyHeight);

  pathEnd = dropSite + (anglesToForward(direction) * planeHalfDistance);
  pathEnd = pathEnd * (1, 1, 0) + (0, 0, flyHeight);

  d = length(pathStart - pathEnd);
  flyTime = (d / planeFlySpeed);

  c130 = c130Setup(owner, pathStart, pathEnd);
  c130.veh_speed = planeFlySpeed;
  c130.dropType = dropType;
  c130 playLoopSound("veh_ac130_dist_loop");

  c130.angles = direction;
  forward = anglesToForward(direction);
  c130 MoveTo(pathEnd, flyTime, 0, 0);

  minDist = Distance2D(c130.origin, dropSite);
  boomPlayed = false;

  for(;;) {
    dist = Distance2D(c130.origin, dropSite);

    if(dist < minDist)
      minDist = dist;
    else if(dist > minDist) {
      break;
    }

    if(dist < 256) {
      break;
    } else if(dist < 768) {
      earthquake(0.15, 1.5, dropSite, 1500);
      if(!boomPlayed) {
        c130 playSound("veh_ac130_sonic_boom");

        boomPlayed = true;
      }
    }

    wait(.05);
  }
  wait(0.05);

  crateType[0] = c130 thread dropTheCrate(dropSite, dropType, flyHeight, false, undefined, pathStart);
  wait(0.05);
  c130 notify("drop_crate");
  wait(0.05);

  crateType[1] = c130 thread dropTheCrate(dropSite, dropType, flyHeight, false, undefined, pathStart, undefined, crateType);
  wait(0.05);
  c130 notify("drop_crate");
  wait(0.05);

  crateType[2] = c130 thread dropTheCrate(dropSite, dropType, flyHeight, false, undefined, pathStart, undefined, crateType);
  wait(0.05);
  c130 notify("drop_crate");
  wait(0.05);

  crateType[3] = c130 thread dropTheCrate(dropSite, dropType, flyHeight, false, undefined, pathStart, undefined, crateType);
  wait(0.05);
  c130 notify("drop_crate");

  wait(4);
  c130 delete();
}

dropNuke(dropSite, owner, dropType) {
  planeHalfDistance = 24000;
  planeFlySpeed = 2000;
  yaw = RandomInt(360);

  direction = (0, yaw, 0);

  flyHeight = self getFlyHeightOffset(dropSite);

  pathStart = dropSite + (anglesToForward(direction) * (-1 * planeHalfDistance));
  pathStart = pathStart * (1, 1, 0) + (0, 0, flyHeight);

  pathEnd = dropSite + (anglesToForward(direction) * planeHalfDistance);
  pathEnd = pathEnd * (1, 1, 0) + (0, 0, flyHeight);

  d = length(pathStart - pathEnd);
  flyTime = (d / planeFlySpeed);

  c130 = c130Setup(owner, pathStart, pathEnd);
  c130.veh_speed = planeFlySpeed;
  c130.dropType = dropType;
  c130 playLoopSound("veh_ac130_dist_loop");

  c130.angles = direction;
  forward = anglesToForward(direction);
  c130 MoveTo(pathEnd, flyTime, 0, 0);

  boomPlayed = false;
  minDist = Distance2D(c130.origin, dropSite);
  for(;;) {
    dist = Distance2D(c130.origin, dropSite);

    if(dist < minDist)
      minDist = dist;
    else if(dist > minDist) {
      break;
    }

    if(dist < 256) {
      break;
    } else if(dist < 768) {
      earthquake(0.15, 1.5, dropSite, 1500);
      if(!boomPlayed) {
        c130 playSound("veh_ac130_sonic_boom");

        boomPlayed = true;
      }
    }

    wait(.05);
  }

  c130 thread dropTheCrate(dropSite, dropType, flyHeight, false, "nuke", pathStart);
  wait(0.05);
  c130 notify("drop_crate");

  wait(4);
  c130 delete();
}

stopLoopAfter(delay) {
  self endon("death");

  wait(delay);
  self stoploopsound();
}

playloopOnEnt(alias) {
  soundOrg = spawn("script_origin", (0, 0, 0));
  soundOrg hide();
  soundOrg endon("death");
  thread delete_on_death(soundOrg);

  soundOrg.origin = self.origin;
  soundOrg.angles = self.angles;
  soundOrg linkto(self);

  soundOrg playLoopSound(alias);

  self waittill("stop sound" + alias);
  soundOrg stoploopsound(alias);
  soundOrg delete();
}

c130Setup(owner, pathStart, pathGoal) {
  forward = vectorToAngles(pathGoal - pathStart);
  c130 = SpawnPlane(owner, "script_model", pathStart, "compass_objpoint_c130_friendly", "compass_objpoint_c130_enemy");
  c130 setModel("vehicle_ac130_low_mp");

  if(!isDefined(c130)) {
    return;
  }
  c130.owner = owner;
  c130.team = owner.team;
  level.c130 = c130;

  return c130;
}

heliSetup(owner, pathStart, pathGoal) {
  forward = vectorToAngles(pathGoal - pathStart);

  vehicle = "littlebird_mp";

  if(isDefined(level.vehicleOverride))
    vehicle = level.vehicleOverride;

  lb = SpawnHelicopter(owner, pathStart, forward, vehicle, level.littlebird_model);

  if(!isDefined(lb)) {
    return;
  }
  lb maps\mp\killstreaks\_helicopter::addToLittleBirdList();
  lb thread maps\mp\killstreaks\_helicopter::removeFromLittleBirdListOnDeath();

  lb.maxhealth = 500;
  lb.owner = owner;
  lb.team = owner.team;
  lb.isAirdrop = true;
  lb thread watchTimeOut();
  lb thread heli_existence();
  lb thread heliDestroyed();
  lb thread maps\mp\killstreaks\_helicopter::heli_damage_monitor("airdrop");
  lb SetMaxPitchRoll(45, 85);
  lb Vehicle_SetSpeed(250, 175);
  lb.heliType = "airdrop";

  lb HidePart("tag_wings");

  return lb;
}

watchTimeOut() {
  level endon("game_ended");
  self endon("leaving");
  self endon("helicopter_gone");
  self endon("death");

  maps\mp\gametypes\_hostmigration::waitLongDurationWithHostMigrationPause(25.0);

  self notify("death");
}

heli_existence() {
  self waittill_any("crashing", "leaving");

  self notify("helicopter_gone");
}

heliDestroyed() {
  self endon("leaving");
  self endon("helicopter_gone");

  self waittill("death");

  if(!isDefined(self)) {
    return;
  }
  self Vehicle_SetSpeed(25, 5);
  self thread lbSpin(RandomIntRange(180, 220));

  wait(RandomFloatRange(.5, 1.5));

  self notify("drop_crate");

  lbExplode();
}

lbExplode() {
  forward = (self.origin + (0, 0, 1)) - self.origin;
  playFX(level.chopper_fx["explode"]["death"]["cobra"], self.origin, forward);

  self playSound("exp_helicopter_fuel");
  self notify("explode");

  decrementFauxVehicleCount();

  self delete();
}

lbSpin(speed) {
  self endon("explode");

  playFXOnTag(level.chopper_fx["explode"]["medium"], self, "tail_rotor_jnt");
  playFXOnTag(level.chopper_fx["fire"]["trail"]["medium"], self, "tail_rotor_jnt");

  self setyawspeed(speed, speed, speed);
  while(isDefined(self)) {
    self settargetyaw(self.angles[1] + (speed * 0.9));
    wait(1);
  }
}

nukeCaptureThink() {
  while(isDefined(self)) {
    self waittill("trigger", player);

    if(!player isOnGround()) {
      continue;
    }
    if(!useHoldThink(player)) {
      continue;
    }
    self notify("captured", player);
  }
}

crateOtherCaptureThink(useText) {
  self endon("restarting_physics");

  while(isDefined(self)) {
    self waittill("trigger", player);

    if(isDefined(self.owner) && player == self.owner) {
      continue;
    }
    if(!self validateOpenConditions(player)) {
      continue;
    }
    if(isDefined(level.overrideCrateUseTime))
      useTime = level.overrideCrateUseTime;
    else
      useTime = undefined;

    player.isCapturingCrate = true;
    useEnt = self createUseEnt();
    result = useEnt useHoldThink(player, useTime, useText);

    if(isDefined(useEnt))
      useEnt delete();

    if(!isDefined(player)) {
      return;
    }
    if(!result) {
      player.isCapturingCrate = false;
      continue;
    }

    player.isCapturingCrate = false;
    self notify("captured", player);
  }
}

crateOwnerCaptureThink(useText) {
  self endon("restarting_physics");

  while(isDefined(self)) {
    self waittill("trigger", player);

    if(isDefined(self.owner) && player != self.owner) {
      continue;
    }
    if(!self validateOpenConditions(player)) {
      continue;
    }
    player.isCapturingCrate = true;
    if(!useHoldThink(player, CONST_CRATE_OWNER_USE_TIME, useText)) {
      player.isCapturingCrate = false;
      continue;
    }

    player.isCapturingCrate = false;
    self notify("captured", player);
  }
}

crateAllCaptureThink(useText) {
  self endon("restarting_physics");

  self.crateUseEnts = [];

  while(isDefined(self)) {
    self waittill("trigger", player);

    if(!self validateOpenConditions(player)) {
      continue;
    }
    if(isDefined(level.overrideCrateUseTime))
      useTime = level.overrideCrateUseTime;
    else
      useTime = undefined;

    self childthread crateAllUseLogic(player, useTime, useText);
  }
}

crateAllUseLogic(player, useTime, useText) {
  player.isCapturingCrate = true;

  AssertEx(!isDefined(self.crateUseEnts[player.name]), "Crate already has useEnt for " + player.name);

  self.crateUseEnts[player.name] = self createUseEnt();

  useEntToRemove = self.crateUseEnts[player.name];

  result = self.crateUseEnts[player.name] useHoldThink(player, useTime, useText, self);

  if(isDefined(self.crateUseEnts) && isDefined(useEntToRemove)) {
    self.crateUseEnts = array_remove_keep_index(self.crateUseEnts, useEntToRemove);
    useEntToRemove delete();
  }

  if(!isDefined(player)) {
    return;
  }
  player.isCapturingCrate = false;

  if(result)
    self notify("captured", player);
}

updateCrateUseState() {
  self.inUse = false;

  foreach(useEnt in self.crateUseEnts) {
    if(useEnt.inUse) {
      self.inUse = true;
      break;
    }
  }
}

validateOpenConditions(opener) {
  if((self.crateType == "airdrop_juggernaut_recon" || self.crateType == "airdrop_juggernaut" || self.crateType == "airdrop_juggernaut_maniac") && opener isJuggernaut())
    return false;

  if(isDefined(opener.OnHeliSniper) && opener.OnHeliSniper)
    return false;

  currWeapon = opener GetCurrentWeapon();
  if(isKillstreakWeapon(currWeapon) && !isJuggernautWeapon(currWeapon))
    return false;

  if(isDefined(opener.changingWeapon) && isKillstreakWeapon(opener.changingWeapon) && !IsSubStr(opener.changingWeapon, "jugg_mp"))
    return false;

  return true;
}

killstreakCrateThink(dropType) {
  self endon("restarting_physics");
  self endon("death");

  if(isDefined(game["strings"][self.crateType + "_hint"]))
    crateHint = game["strings"][self.crateType + "_hint"];
  else
    crateHint = &"PLATFORM_GET_KILLSTREAK";

  crateSetupForUse(crateHint, getKillstreakOverheadIcon(self.crateType));

  self thread crateOtherCaptureThink();
  self thread crateOwnerCaptureThink();

  for(;;) {
    self waittill("captured", player);

    if(IsPlayer(player)) {
      player SetClientOmnvar("ui_securing", 0);
      player.ui_securing = undefined;
    }

    if(isDefined(self.owner) && player != self.owner) {
      if(!level.teamBased || player.team != self.team) {
        switch (dropType) {
          case "airdrop_assault":
          case "airdrop_support":
          case "airdrop_escort":
          case "airdrop_osprey_gunner":
            player thread maps\mp\gametypes\_missions::genericChallenge("hijacker_airdrop");
            player thread hijackNotify(self, "airdrop");
            break;
          case "airdrop_sentry_minigun":
            player thread maps\mp\gametypes\_missions::genericChallenge("hijacker_airdrop");
            player thread hijackNotify(self, "sentry");
            break;
          case "airdrop_remote_tank":
            player thread maps\mp\gametypes\_missions::genericChallenge("hijacker_airdrop");
            player thread hijackNotify(self, "remote_tank");
            break;
          case "airdrop_mega":
            player thread maps\mp\gametypes\_missions::genericChallenge("hijacker_airdrop_mega");
            player thread hijackNotify(self, "emergency_airdrop");
            break;
        }
      } else {
        self.owner thread maps\mp\gametypes\_rank::giveRankXP("killstreak_giveaway", Int((maps\mp\killstreaks\_killstreaks::getStreakCost(self.crateType) / 10) * 50));

        self.owner thread maps\mp\gametypes\_hud_message::SplashNotifyDelayed("sharepackage", Int((maps\mp\killstreaks\_killstreaks::getStreakCost(self.crateType) / 10) * 50));
      }
    }

    player playLocalSound("ammo_crate_use");
    player thread maps\mp\killstreaks\_killstreaks::giveKillstreak(self.crateType, false, false, self.owner);

    player maps\mp\gametypes\_hud_message::killstreakSplashNotify(self.crateType, undefined);

    self deleteCrate();
  }
}

lasedStrikeCrateThink(dropType) {
  self endon("restarting_physics");
  self endon("death");

  crateSetupForUse(game["strings"]["marker_hint"], getKillstreakOverheadIcon(self.crateType));

  level.lasedStrikeCrateActive = true;
  self thread crateOwnerCaptureThink();
  self thread crateOtherCaptureThink();

  numCount = 0;

  remote = self thread maps\mp\killstreaks\_lasedStrike::spawnRemote(self.owner);
  level.lasedStrikeDrone = remote;
  level.lasedStrikeActive = true;

  level.soflamCrate = self;

  for(;;) {
    self waittill("captured", player);

    if(isDefined(self.owner) && player != self.owner) {
      if(!level.teamBased || player.team != self.team) {
        self deleteCrate();
      }
    }

    self maps\mp\killstreaks\_airdrop::setUsableByTeam(self.team);

    player thread maps\mp\killstreaks\_lasedStrike::giveMarker();

    numCount++;

    if(numCount >= 5)
      self deleteCrate();
  }
}

nukeCrateThink(dropType) {
  self endon("restarting_physics");
  self endon("death");

  crateSetupForUse(&"PLATFORM_CALL_NUKE", getKillstreakOverheadIcon(self.crateType));

  self thread nukeCaptureThink();

  for(;;) {
    self waittill("captured", player);

    player thread[[level.killstreakFuncs[self.crateType]]](level.gtnw);
    level notify("nukeCaptured", player);

    if(isDefined(level.gtnw) && level.gtnw)
      player.capturedNuke = 1;

    player playLocalSound("ammo_crate_use");
    self deleteCrate();
  }
}

juggernautCrateThink(dropType) {
  self endon("restarting_physics");
  self endon("death");

  crateSetupForUse(game["strings"][self.crateType + "_hint"], getKillstreakOverheadIcon(self.crateType));

  self thread crateOtherCaptureThink();
  self thread crateOwnerCaptureThink();

  for(;;) {
    self waittill("captured", player);

    if(isDefined(self.owner) && player != self.owner) {
      if(!level.teamBased || player.team != self.team) {
        if(self.crateType == "airdrop_juggernaut_maniac") {
          player thread hijackNotify(self, "maniac");
        } else if(isStrStart(self.crateType, "juggernaut_")) {
          player thread hijackNotify(self, self.crateType);
        } else {
          player thread hijackNotify(self, "juggernaut");
        }
      } else {
        self.owner thread maps\mp\gametypes\_rank::giveRankXP("killstreak_giveaway", Int(maps\mp\killstreaks\_killstreaks::getStreakCost(self.crateType) / 10) * 50);

        if(self.crateType == "airdrop_juggernaut_maniac") {
          self.owner maps\mp\gametypes\_hud_message::playerCardSplashNotify("giveaway_juggernaut_maniac", player);
        } else if(isStrStart(self.crateType, "juggernaut_")) {
          self.owner maps\mp\gametypes\_hud_message::playerCardSplashNotify("giveaway_" + self.crateType, player);
        } else {
          self.owner maps\mp\gametypes\_hud_message::playerCardSplashNotify("giveaway_juggernaut", player);
        }
      }
    }

    player playLocalSound("ammo_crate_use");

    juggType = "juggernaut";
    switch (self.crateType) {
      case "airdrop_juggernaut":
        juggType = "juggernaut";
        break;
      case "airdrop_juggernaut_recon":
        juggType = "juggernaut_recon";
        break;
      case "airdrop_juggernaut_maniac":
        juggType = "juggernaut_maniac";
        break;
      default:
        if(isStrStart(self.crateType, "juggernaut_")) {
          juggType = self.crateType;
        }
        break;
    }

    player thread maps\mp\killstreaks\_juggernaut::giveJuggernaut(juggType);

    self deleteCrate();
  }
}

sentryCrateThink(dropType) {
  self endon("death");

  crateSetupForUse(game["strings"]["sentry_hint"], getKillstreakOverheadIcon(self.crateType));

  self thread crateOtherCaptureThink();
  self thread crateOwnerCaptureThink();

  for(;;) {
    self waittill("captured", player);

    if(isDefined(self.owner) && player != self.owner) {
      if(!level.teamBased || player.team != self.team) {
        if(isSubStr(dropType, "airdrop_sentry"))
          player thread hijackNotify(self, "sentry");
        else
          player thread hijackNotify(self, "emergency_airdrop");
      } else {
        self.owner thread maps\mp\gametypes\_rank::giveRankXP("killstreak_giveaway", Int(maps\mp\killstreaks\_killstreaks::getStreakCost("sentry") / 10) * 50);
        self.owner maps\mp\gametypes\_hud_message::playerCardSplashNotify("giveaway_sentry", player);
      }
    }

    player playLocalSound("ammo_crate_use");
    player thread sentryUseTracker();

    self deleteCrate();
  }
}

deleteCrate() {
  self notify("crate_deleting");

  if(isDefined(self.usedBy)) {
    foreach(player in self.usedBy) {
      player SetClientOmnvar("ui_securing", 0);
      player.ui_securing = undefined;
    }
  }

  if(isDefined(self.objIdFriendly))
    _objective_delete(self.objIdFriendly);

  if(isDefined(self.objIdEnemy)) {
    if(level.multiTeamBased) {
      foreach(obj in self.objIdEnemy) {
        _objective_delete(obj);
      }
    } else {
      _objective_delete(self.objIdEnemy);
    }
  }

  if(isDefined(self.bomb) && isDefined(self.bomb.killcamEnt))
    self.bomb.killcamEnt delete();

  if(isDefined(self.bomb))
    self.bomb delete();

  if(isDefined(self.killCamEnt))
    self.killCamEnt delete();

  if(isDefined(self.dropType))
    playFX(getfx("airdrop_crate_destroy"), self.origin);

  self delete();
}

sentryUseTracker() {
  if(!self maps\mp\killstreaks\_autosentry::giveSentry("sentry_minigun"))
    self maps\mp\killstreaks\_killstreaks::giveKillstreak("sentry");
}

hijackNotify(crate, crateType) {
  self notify("hijacker", crateType, crate.owner);
}

refillAmmo(refillEquipment) {
  weaponList = self GetWeaponsListAll();

  if(refillEquipment) {
    if(self _hasPerk("specialty_tacticalinsertion") && self getAmmoCount("flare_mp") < 1)
      self givePerkOffhand("specialty_tacticalinsertion", false);
  }

  foreach(weaponName in weaponList) {
    if(isSubStr(weaponName, "grenade") || (GetSubStr(weaponName, 0, 2) == "gl")) {
      if(!refillEquipment || self getAmmoCount(weaponName) >= 1)
        continue;
    }

    self giveMaxAmmo(weaponName);
  }
}

useHoldThink(player, useTime, useText, crate) {
  self maps\mp\_movers::script_mover_link_to_use_object(player);

  player _disableWeapon();

  self.curProgress = 0;
  self.inUse = true;
  self.useRate = 0;

  if(isDefined(crate))
    crate updateCrateUseState();

  if(isDefined(useTime))
    self.useTime = useTime;
  else
    self.useTime = CONST_CRATE_OTHER_USE_TIME;

  result = useHoldThinkLoop(player);
  assert(isDefined(result));

  if(isAlive(player))
    player _enableWeapon();

  if(isDefined(player)) {
    maps\mp\_movers::script_mover_unlink_from_use_object(player);
  }

  if(!isDefined(self))
    return false;

  self.inUse = false;
  self.curProgress = 0;

  if(isDefined(crate))
    crate updateCrateUseState();

  return (result);
}

useHoldThinkLoop(player) {
  while(player maps\mp\killstreaks\_deployablebox::isPlayerUsingBox(self)) {
    if(!player maps\mp\_movers::script_mover_use_can_link(self)) {
      player maps\mp\gametypes\_gameobjects::updateUIProgress(self, false);
      return false;
    }

    self.curProgress += (50 * self.useRate);

    if(isDefined(self.objectiveScaler))
      self.useRate = 1 * self.objectiveScaler;
    else
      self.useRate = 1;

    player maps\mp\gametypes\_gameobjects::updateUIProgress(self, true);

    if(self.curProgress >= self.useTime) {
      player maps\mp\gametypes\_gameobjects::updateUIProgress(self, false);
      return (isReallyAlive(player));
    }

    wait 0.05;
  }

  if(isDefined(self))
    player maps\mp\gametypes\_gameobjects::updateUIProgress(self, false);

  return false;
}

createUseEnt() {
  useEnt = spawn("script_origin", self.origin);
  useEnt.curProgress = 0;
  useEnt.useTime = 0;
  useEnt.useRate = 3000;
  useEnt.inUse = false;
  useEnt.id = self.id;
  useEnt linkto(self);

  useEnt thread deleteUseEnt(self);

  return (useEnt);
}

deleteUseEnt(owner) {
  self endon("death");

  owner waittill("death");

  if(isDefined(self.usedBy)) {
    foreach(player in self.usedBy) {
      player SetClientOmnvar("ui_securing", 0);
      player.ui_securing = undefined;
    }
  }

  self delete();
}

airdropDetonateOnStuck() {
  self endon("death");

  self waittill("missile_stuck");

  self detonate();
}

throw_linked_care_packages(animating_model, offset, throw_vec, delete_volume) {
  if(isDefined(level.carePackages)) {
    foreach(carePackage in level.carePackages) {
      if(isDefined(carePackage.inUse) && carePackage.inUse) {
        continue;
      }
      parent = carePackage GetLinkedParent();
      if(isDefined(parent) && (parent == animating_model)) {
        thread spawn_new_care_package(carePackage, offset, throw_vec);
        if(isDefined(delete_volume)) {
          delayThread(1.0, ::remove_care_packages_in_volume, delete_volume);
        }
      }
    }
  }
}

spawn_new_care_package(package, offset, throw_vec) {
  owner = package.owner;
  dropType = package.dropType;
  crateType = package.crateType;
  origin = package.origin;

  package maps\mp\killstreaks\_airdrop::deleteCrate();

  newCrate = owner maps\mp\killstreaks\_airdrop::createAirDropCrate(owner, dropType, crateType, origin + offset, origin + offset);
  newCrate.droppingtoground = true;

  newCrate thread[[level.crateTypes[newCrate.dropType][newCrate.crateType].func]](newCrate.dropType);

  waitframe();

  newCrate CloneBrushmodelToScriptmodel(level.airDropCrateCollision);
  newCrate thread entity_path_disconnect_thread(1.0);
  newCrate PhysicsLaunchServer(newCrate.origin, throw_vec);

  if(IsBot(newCrate.owner)) {
    wait(0.1);
    newCrate.owner notify("new_crate_to_take");
  }
}

remove_care_packages_in_volume(volume) {
  if(isDefined(level.carePackages)) {
    foreach(carePackage in level.carePackages) {
      if(isDefined(carePackage) && isDefined(carePackage.friendlyModel) && (carePackage.friendlyModel IsTouching(volume))) {
        carePackage maps\mp\killstreaks\_airdrop::deleteCrate();
      }
    }
  }
}

get_dummy_crate_model() {
  return DUMMY_CRATE_MODEL;
}

get_enemy_crate_model() {
  return ENEMY_CRATE_MODEL;
}

get_friendly_crate_model() {
  return FRIENDLY_CRATE_MODEL;
}

get_dummy_juggernaut_crate_model() {
  return DUMMY_JUGGERNAUT_CRATE_MODEL;
}

get_enemy_juggernaut_crate_model() {
  return ENEMY_JUGGERNAUT_CRATE_MODEL;
}

get_friendly_juggernaut_crate_model() {
  return FRIENDLY_JUGGERNAUT_CRATE_MODEL;
}