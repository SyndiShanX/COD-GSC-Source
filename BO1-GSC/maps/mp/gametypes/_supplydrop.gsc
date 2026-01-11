/*********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\gametypes\_supplydrop.gsc
*********************************************/

#include common_scripts\utility;
#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
#include maps\mp\_airsupport;

init() {
  level thread onPlayerConnect();
  level.crateModelFriendly = "mp_supplydrop_ally";
  level.crateModelEnemy = "mp_supplydrop_axis";
  level.crateModelBoobyTrapped = "mp_supplydrop_boobytrapped";
  level.supplyDropHelicopterFriendly = "vehicle_ch46e_mp_light";
  level.supplyDropHelicopterEnemy = "vehicle_ch46e_mp_dark";
  level.suppyDropHelicopterVehicleInfo = "heli_supplydrop_mp";
  level.crateOwnerUseTime = 500;
  level.crateNonOwnerUseTime = 3000;
  level.crate_headicon_offset = (0, 0, 15);
  PreCacheModel(level.crateModelFriendly);
  PreCacheModel(level.crateModelEnemy);
  PreCacheModel(level.crateModelBoobyTrapped);
  PreCacheModel(level.supplyDropHelicopterFriendly);
  PreCacheModel(level.supplyDropHelicopterEnemy);
  PreCacheVehicle(level.suppyDropHelicopterVehicleInfo);
  PreCacheShader("compass_supply_drop_black");
  PreCacheShader("compass_supply_drop_green");
  PreCacheShader("compass_supply_drop_red");
  PreCacheShader("waypoint_recon_artillery_strike");
  PreCacheShader("hud_ks_minigun");
  PreCacheShader("hud_ks_minigun_drop");
  PreCacheShader("hud_ks_m202");
  PreCacheShader("hud_ks_m202_drop");
  PreCacheShader("hud_ammo_refill");
  PreCacheShader("hud_ammo_refill_drop");
  PreCacheString(&"KILLSTREAK_CAPTURING_CRATE");
  PreCacheShader("headicon_dead");
  level._supply_drop_smoke_fx = LoadFX("env/smoke/fx_smoke_supply_drop_blue_mp");
  level._supply_drop_explosion_fx = LoadFX("explosions/fx_grenadeexp_default");
  LoadFX("vehicle/props/fx_seaknight_main_blade_full");
  LoadFX("vehicle/props/fx_seaknight_rear_blade_full");
  maps\mp\gametypes\_hardpoints::registerKillstreak("supply_drop_mp", "supplydrop_mp", "killstreak_supply_drop", "supply_drop_used", ::useKillstreakSupplyDrop, undefined, true);
  maps\mp\gametypes\_hardpoints::registerKillstreakStrings("supply_drop_mp", &"KILLSTREAK_EARNED_SUPPLY_DROP", &"KILLSTREAK_AIRSPACE_FULL");
  maps\mp\gametypes\_hardpoints::registerKillstreakDialog("supply_drop_mp", "mpl_killstreak_supply", "kls_supply_used", "", "kls_supply_enemy", "", "kls_supply_ready");
  maps\mp\gametypes\_hardpoints::registerKillstreakDevDvar("supply_drop_mp", "scr_givesupplydrop");
  maps\mp\gametypes\_hardpoints::registerKillstreakAltWeapon("supply_drop_mp", "mp40_blinged_mp");
  maps\mp\gametypes\_hardpoints::allowKillstreakAssists("supply_drop_mp", true);
  level.crateTypes = [];
  registerCrateType("m220_tow_drop_mp", "killstreak", "m220_tow_mp", 1, &"KILLSTREAK_M220_TOW_CRATE", undefined, "MEDAL_SHARE_PACKAGE_TOW", ::giveCrateKillstreak);
  registerCrateType("supplydrop_mp", "ammo", "ammo", 20, &"KILLSTREAK_AMMO_CRATE", &"PLATFORM_AMMO_CRATE_GAMBLER", "MEDAL_SHARE_PACKAGE_AMMO", ::giveCrateAmmo);
  registerCrateType("supplydrop_mp", "killstreak", "radar_mp", 15, &"KILLSTREAK_RADAR_CRATE", &"PLATFORM_RADAR_GAMBLER", "MEDAL_SHARE_PACKAGE_RECON", ::giveCrateKillstreak);
  registerCrateType("supplydrop_mp", "killstreak", "counteruav_mp", 15, &"KILLSTREAK_COUNTERU2_CRATE", &"PLATFORM_COUNTERU2_GAMBLER", "MEDAL_SHARE_PACKAGE_COUNTERU2", ::giveCrateKillstreak);
  registerCrateType("supplydrop_mp", "killstreak", "rcbomb_mp", 9, &"KILLSTREAK_RCBOMB_CRATE", &"PLATFORM_RCBOMB_GAMBLER", "MEDAL_SHARE_PACKAGE_RCBOMB", ::giveCrateKillstreak);
  registerCrateType("supplydrop_mp", "killstreak", "m220_tow_mp", 5, &"KILLSTREAK_M220_TOW_CRATE", &"PLATFORM_M220_TOW_GAMBLER", "MEDAL_SHARE_PACKAGE_TOW", ::giveCrateKillstreak);
  registerCrateType("supplydrop_mp", "killstreak", "mortar_mp", 5, &"KILLSTREAK_MORTAR_CRATE", &"PLATFORM_MORTAR_GAMBLER", "MEDAL_SHARE_PACKAGE_MORTAR", ::giveCrateKillstreak);
  registerCrateType("supplydrop_mp", "killstreak", "autoturret_mp", 5, &"KILLSTREAK_AUTO_TURRET_CRATE", &"PLATFORM_AUTO_TURRET_GAMBLER", "MEDAL_SHARE_PACKAGE_AUTO_TURRET", ::giveCrateKillstreak);
  registerCrateType("supplydrop_mp", "killstreak", "auto_tow_mp", 5, &"KILLSTREAK_TOW_TURRET_CRATE", &"PLATFORM_TOW_TURRET_GAMBLER", "MEDAL_SHARE_PACKAGE_TOW_TURRET", ::giveCrateKillstreak);
  registerCrateType("supplydrop_mp", "killstreak", "airstrike_mp", 3, &"KILLSTREAK_AIRSTRIKE_CRATE", &"PLATFORM_AIRSTRIKE_GAMBLER", "MEDAL_SHARE_PACKAGE_AIRSTRIKE", ::giveCrateKillstreak);
  registerCrateType("supplydrop_mp", "killstreak", "m202_flash_mp", 3, &"KILLSTREAK_M202_FLASH_CRATE", &"PLATFORM_M202_FLASH_GAMBLER", "MEDAL_SHARE_PACKAGE_FLASH", ::giveCrateKillstreak);
  registerCrateType("supplydrop_mp", "killstreak", "napalm_mp", 3, &"KILLSTREAK_NAPALM_CRATE", &"PLATFORM_NAPALM_GAMBLER", "MEDAL_SHARE_PACKAGE_NAPALM", ::giveCrateKillstreak);
  registerCrateType("supplydrop_mp", "killstreak", "radardirection_mp", 3, &"KILLSTREAK_SATELLITE_CRATE", &"PLATFORM_SATELLITE_GAMBLER", "MEDAL_SHARE_PACKAGE_SATELLITE", ::giveCrateKillstreak);
  registerCrateType("supplydrop_mp", "killstreak", "helicopter_comlink_mp", 3, &"KILLSTREAK_HELICOPTER_CRATE", &"PLATFORM_HELICOPTER_GAMBLER", "MEDAL_SHARE_PACKAGE_HELICOPTER_COMLINK", ::giveCrateKillstreak);
  registerCrateType("supplydrop_mp", "killstreak", "minigun_mp", 2, &"KILLSTREAK_MINIGUN_CRATE", &"PLATFORM_MINIGUN_GAMBLER", "MEDAL_SHARE_PACKAGE_MINIGUN", ::giveCrateKillstreak);
  registerCrateType("supplydrop_mp", "killstreak", "helicopter_gunner_mp", 2, &"KILLSTREAK_HELICOPTER_GUNNER_CRATE", &"PLATFORM_HELICOPTER_GUNNER_GAMBLER", "MEDAL_SHARE_PACKAGE_HELICOPTER_GUNNER", ::giveCrateKillstreak);
  registerCrateType("supplydrop_mp", "killstreak", "dogs_mp", 1, &"KILLSTREAK_DOGS_CRATE", &"PLATFORM_DOGS_GAMBLER", "MEDAL_SHARE_PACKAGE_DOGS", ::giveCrateKillstreak);
  registerCrateType("supplydrop_mp", "killstreak", "helicopter_player_firstperson_mp", 1, &"KILLSTREAK_HELICOPTER_PLAYER_CRATE", &"PLATFORM_HELICOPTER_PLAYER_GAMBLER", "MEDAL_SHARE_PACKAGE_HELICOPTER_PLAYER", ::giveCrateKillstreak);
  registerCrateType("gambler_mp", "ammo", "ammo", 9, &"KILLSTREAK_AMMO_CRATE", undefined, "MEDAL_SHARE_PACKAGE_AMMO", ::giveCrateAmmo);
  registerCrateType("gambler_mp", "killstreak", "radar_mp", 9, &"KILLSTREAK_RADAR_CRATE", undefined, "MEDAL_SHARE_PACKAGE_RECON", ::giveCrateKillstreak);
  registerCrateType("gambler_mp", "killstreak", "counteruav_mp", 9, &"KILLSTREAK_COUNTERU2_CRATE", undefined, "MEDAL_SHARE_PACKAGE_COUNTERU2", ::giveCrateKillstreak);
  registerCrateType("gambler_mp", "killstreak", "rcbomb_mp", 9, &"KILLSTREAK_RCBOMB_CRATE", undefined, "MEDAL_SHARE_PACKAGE_RCBOMB", ::giveCrateKillstreak);
  registerCrateType("gambler_mp", "killstreak", "m220_tow_mp", 9, &"KILLSTREAK_M220_TOW_CRATE", undefined, "MEDAL_SHARE_PACKAGE_TOW", ::giveCrateKillstreak);
  registerCrateType("gambler_mp", "killstreak", "mortar_mp", 9, &"KILLSTREAK_MORTAR_CRATE", undefined, "MEDAL_SHARE_PACKAGE_MORTAR", ::giveCrateKillstreak);
  registerCrateType("gambler_mp", "killstreak", "autoturret_mp", 9, &"KILLSTREAK_AUTO_TURRET_CRATE", undefined, "MEDAL_SHARE_PACKAGE_AUTO_TURRET", ::giveCrateKillstreak);
  registerCrateType("gambler_mp", "killstreak", "auto_tow_mp", 9, &"KILLSTREAK_TOW_TURRET_CRATE", undefined, "MEDAL_SHARE_PACKAGE_TOW_TURRET", ::giveCrateKillstreak);
  registerCrateType("gambler_mp", "killstreak", "airstrike_mp", 4, &"KILLSTREAK_AIRSTRIKE_CRATE", undefined, "MEDAL_SHARE_PACKAGE_AIRSTRIKE", ::giveCrateKillstreak);
  registerCrateType("gambler_mp", "killstreak", "m202_flash_mp", 4, &"KILLSTREAK_M202_FLASH_CRATE", undefined, "MEDAL_SHARE_PACKAGE_FLASH", ::giveCrateKillstreak);
  registerCrateType("gambler_mp", "killstreak", "napalm_mp", 4, &"KILLSTREAK_NAPALM_CRATE", undefined, "MEDAL_SHARE_PACKAGE_NAPALM", ::giveCrateKillstreak);
  registerCrateType("gambler_mp", "killstreak", "radardirection_mp", 4, &"KILLSTREAK_SATELLITE_CRATE", undefined, "MEDAL_SHARE_PACKAGE_SATELLITE", ::giveCrateKillstreak);
  registerCrateType("gambler_mp", "killstreak", "helicopter_comlink_mp", 4, &"KILLSTREAK_HELICOPTER_CRATE", undefined, "MEDAL_SHARE_PACKAGE_HELICOPTER_COMLINK", ::giveCrateKillstreak);
  registerCrateType("gambler_mp", "killstreak", "minigun_mp", 3, &"KILLSTREAK_MINIGUN_CRATE", undefined, "MEDAL_SHARE_PACKAGE_MINIGUN", ::giveCrateKillstreak);
  registerCrateType("gambler_mp", "killstreak", "helicopter_gunner_mp", 3, &"KILLSTREAK_HELICOPTER_GUNNER_CRATE", undefined, "MEDAL_SHARE_PACKAGE_HELICOPTER_GUNNER", ::giveCrateKillstreak);
  registerCrateType("gambler_mp", "killstreak", "dogs_mp", 1, &"KILLSTREAK_DOGS_CRATE", undefined, "MEDAL_SHARE_PACKAGE_DOGS", ::giveCrateKillstreak);
  registerCrateType("gambler_mp", "killstreak", "helicopter_player_firstperson_mp", 1, &"KILLSTREAK_HELICOPTER_PLAYER_CRATE", undefined, "MEDAL_SHARE_PACKAGE_HELICOPTER_PLAYER", ::giveCrateKillstreak);
  level.crateCategoryWeights = [];
  crateCategoryKeys = getarraykeys(level.crateTypes);
  for(crateCategory = 0; crateCategory < crateCategoryKeys.size; crateCategory++) {
    categoryKey = crateCategoryKeys[crateCategory];
    level.crateCategoryWeights[categoryKey] = 0;
    crateTypeKeys = getarraykeys(level.crateTypes[categoryKey]);
    for(crateType = 0; crateType < crateTypeKeys.size; crateType++) {
      typeKey = crateTypeKeys[crateType];
      level.crateCategoryWeights[categoryKey] += level.crateTypes[categoryKey][typeKey].weight;
      level.crateTypes[categoryKey][typeKey].weight = level.crateCategoryWeights[categoryKey];
    }
  }
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
  }
}
registerCrateType(category, type, name, weight, hint, hint_gambler, shareStat, giveFunction) {
  if(!isDefined(level.crateTypes[category])) {
    level.crateTypes[category] = [];
  }
  crateType = spawnStruct();
  crateType.type = type;
  crateType.name = name;
  crateType.weight = weight;
  crateType.hint = hint;
  crateType.hint_gambler = hint_gambler;
  crateType.shareStat = shareStat;
  crateType.giveFunction = giveFunction;
  level.crateTypes[category][name] = crateType;
  game["strings"][name + "_hint"] = hint;
}
getRandomCrateType(category, gambler_crate_name) {
  Assert(isDefined(level.crateTypes));
  Assert(isDefined(level.crateTypes[category]));
  Assert(isDefined(level.crateCategoryWeights[category]));
  typeKey = undefined;
  randomWeight = RandomInt(level.crateCategoryWeights[category]);
  find_another = false;
  crateTypeKeys = getarraykeys(level.crateTypes[category]);
  for(crateType = 0; crateType < crateTypeKeys.size; crateType++) {
    typeKey = crateTypeKeys[crateType];
    if(level.crateTypes[category][typeKey].weight > randomWeight) {
      switch (level.crateTypes[category][typeKey].name) {
        case "minigun_mp":
          find_another = validate_crate_type("minigun_mp", "minigun_mp", "minigun_mp");
          break;
        case "m202_flash_mp":
          find_another = validate_crate_type("m202_flash_mp", "m202_flash_mp", "m202_flash_mp");
          break;
        case "m220_tow_drop_mp":
          find_another = validate_crate_type("m220_tow_drop_mp", "m220_tow_mp", "m220_tow_drop_mp");
          break;
        case "mp40_drop_mp":
          find_another = validate_crate_type("mp40_drop_mp", "mp40_blinged_mp", "mp40_drop_mp");
          break;
        default:
          break;
      }
      if(isDefined(gambler_crate_name) && level.crateTypes[category][typeKey].name == gambler_crate_name) {
        find_another = true;
      }
      if(find_another) {
        if(crateType < crateTypeKeys.size - 1) {
          crateType++;
        } else if(crateType > 0) {
          crateType--;
        }
        typeKey = crateTypeKeys[crateType];
      }
      break;
    }
  }
  return level.crateTypes[category][typeKey];
}
validate_crate_type(killstreak_name, weapon_name, crate_type_name) {
  players = get_players();
  for(i = 0; i < players.size; i++) {
    if(IsAlive(players[i])) {
      for(j = 0; j < players[i].pers["killstreaks"].size; j++) {
        if(players[i].pers["killstreaks"][j] == killstreak_name) {
          return true;
        }
      }
      primary_weapons = players[i] GetWeaponsListPrimaries();
      for(j = 0; j < primary_weapons.size; j++) {
        if(primary_weapons[j] == weapon_name) {
          return true;
        }
      }
      ents = getEntArray("weapon_" + weapon_name, "classname");
      if(isDefined(ents) && ents.size > 0) {
        return true;
      }
      crate_ents = getEntArray("care_package", "script_noteworthy");
      for(j = 0; j < crate_ents.size; j++) {
        if(!isDefined(crate_ents[j].crateType)) {
          continue;
        }
        if(isDefined(crate_ents[j].crateType.name)) {
          if(crate_ents[j].crateType.name == crate_type_name) {
            return true;
          }
        }
      }
    }
  }
  return false;
}
giveCrateItem(crate) {
  if(!IsAlive(self)) {
    return;
  }
  [[crate.crateType.giveFunction]](crate.crateType.name);
}
giveCrateKillstreak(killstreak) {
  self maps\mp\gametypes\_hardpoints::giveKillstreak(killstreak);
}
giveCrateWeapon(weapon) {
  currentWeapon = self GetCurrentWeapon();
  if(currentWeapon == weapon || self HasWeapon(weapon)) {
    self GiveMaxAmmo(weapon);
    return true;
  }
  if(isSupplyDropWeapon(currentWeapon) || isDefined(level.grenade_array[currentWeapon]) || isDefined(level.inventory_array[currentWeapon])) {
    self TakeWeapon(self.lastdroppableweapon);
    self GiveWeapon(weapon);
    self switchToWeapon(weapon);
    return true;
  }
  self maps\mp\gametypes\_globallogic_score::setWeaponStat(weapon, 1, "used");
  switch (weapon) {
    case "minigun_mp":
      level thread maps\mp\_popups::DisplayTeamMessageToAll(&"KILLSTREAK_MINIGUN_INBOUND", self);
      level maps\mp\gametypes\_weapons::addLimitedWeapon(weapon, self, 3);
      break;
    case "m202_flash_mp":
      level thread maps\mp\_popups::DisplayTeamMessageToAll(&"KILLSTREAK_M202_FLASH_INBOUND", self);
      level maps\mp\gametypes\_weapons::addLimitedWeapon(weapon, self, 3);
      break;
    case "m220_tow_mp":
      level thread maps\mp\_popups::DisplayTeamMessageToAll(&"KILLSTREAK_M220_TOW_INBOUND", self);
      level maps\mp\gametypes\_weapons::addLimitedWeapon(weapon, self, 3);
      break;
    case "mp40_blinged_mp":
      level thread maps\mp\_popups::DisplayTeamMessageToAll(&"KILLSTREAK_MP40_INBOUND", self);
      level maps\mp\gametypes\_weapons::addLimitedWeapon(weapon, self, 3);
      break;
    default:
      break;
  }
  self TakeWeapon(currentWeapon);
  self GiveWeapon(weapon);
  self switchToWeapon(weapon);
  return true;
}
giveCrateAmmo(ammo) {
  weaponsList = self GetWeaponsList();
  for(idx = 0; idx < weaponsList.size; idx++) {
    weapon = weaponsList[idx];
    switch (weapon) {
      case "minigun_mp":
      case "m202_flash_mp":
      case "m220_tow_mp":
      case "mp40_blinged_mp":
        continue;
      case "frag_grenade_mp":
      case "sticky_grenade_mp":
      case "hatchet_mp":
      case "flash_grenade_mp":
      case "concussion_grenade_mp":
      case "tabun_gas_mp":
      case "nightingale_mp":
      case "willy_pete_mp":
        stock = self GetWeaponAmmoStock(weapon);
        maxAmmo = WeaponMaxAmmo(weapon);
        if(!(self HasPerk("specialty_twogrenades"))) {
          maxAmmo = WeaponStartAmmo(weapon);
        }
        if(stock < maxAmmo) {
          self SetWeaponAmmoStock(weapon, maxAmmo);
        }
        break;
      default:
        self GiveMaxAmmo(weapon);
        break;
    }
  }
}
useSupplyDropMarker() {
  self endon("death");
  self thread supplyDropWatcher();
  supplyDropWeapon = undefined;
  currentWeapon = self GetCurrentWeapon();
  prevWeapon = currentWeapon;
  if(isSupplyDropWeapon(currentWeapon)) {
    supplyDropWeapon = currentWeapon;
  }
  while(isSupplyDropWeapon(currentWeapon) && prevWeapon == currentWeapon) {
    prevWeapon = currentWeapon;
    self waittill("weapon_change", currentWeapon);
    if(isSupplyDropWeapon(currentWeapon)) {
      supplyDropWeapon = currentWeapon;
    }
  }
  if(!isDefined(supplyDropWeapon)) {
    return false;
  }
  if(self HasWeapon(supplyDropWeapon) && !self GetAmmoCount(supplyDropWeapon)) {
    self TakeWeapon(supplyDropWeapon);
  }
  if(self HasWeapon(supplyDropWeapon) || self GetAmmoCount(supplyDropWeapon)) {
    return false;
  }
  return true;
}
isSupplyDropGrenadeAllowed(hardpointType, killstreakWeapon) {
  if(!isDefined(killstreakWeapon)) {
    killstreakWeapon = hardpointType;
  }
  if(self maps\mp\_killstreakrules::isKillstreakAllowed(hardpointType, self.team) == false) {
    if(isDefined(self.lastStand) && self.lastStand && isDefined(self.laststandpistol) && self hasWeapon(self.laststandpistol)) {
      self switchToWeapon(self.laststandpistol);
    } else if(isDefined(self.lastNonKillstreakWeapon) && self.lastNonKillstreakWeapon != killstreakWeapon && self.lastNonKillstreakWeapon != "none") {
      self SwitchToWeapon(self.lastNonKillstreakWeapon);
    } else if(isDefined(self.lastDroppableWeapon) && self.lastDroppableWeapon != killstreakWeapon && self.lastDroppableWeapon != "none") {
      self SwitchToWeapon(self.lastDroppableWeapon);
    }
    return false;
  }
  return true;
}
useKillstreakSupplyDrop(hardpointType) {
  if(self isSupplyDropGrenadeAllowed(hardpointType, "supplydrop_mp") == false) {
    return false;
  }
  self thread refCountDecChopperOnDisconnect(self.team);
  result = self useSupplyDropMarker();
  self notify("supply_drop_marker_done");
  if(!isDefined(result) || !result) {
    return false;
  }
  return result;
}
use_killstreak_death_machine(hardpointType) {
  if(self maps\mp\_killstreakrules::isKillstreakAllowed(hardpointType, self.team) == false) {
    return false;
  }
  weapon = "minigun_mp";
  currentWeapon = self GetCurrentWeapon();
  if(isSupplyDropWeapon(currentWeapon) || isDefined(level.grenade_array[currentWeapon]) || isDefined(level.inventory_array[currentWeapon])) {
    self TakeWeapon(self.lastdroppableweapon);
    self GiveWeapon(weapon);
    self SwitchToWeapon(weapon);
    self setBlockWeaponPickup(weapon, true);
    return true;
  }
  level thread maps\mp\_popups::DisplayTeamMessageToAll(&"KILLSTREAK_MINIGUN_INBOUND", self);
  level maps\mp\gametypes\_weapons::addLimitedWeapon(weapon, self, 3);
  self TakeWeapon(currentWeapon);
  self GiveWeapon(weapon);
  self SwitchToWeapon(weapon);
  self setBlockWeaponPickup(weapon, true);
  return true;
}
use_killstreak_grim_reaper(hardpointType) {
  if(self maps\mp\_killstreakrules::isKillstreakAllowed(hardpointType, self.team) == false) {
    return false;
  }
  weapon = "m202_flash_mp";
  currentWeapon = self GetCurrentWeapon();
  if(isSupplyDropWeapon(currentWeapon) || isDefined(level.grenade_array[currentWeapon]) || isDefined(level.inventory_array[currentWeapon])) {
    self TakeWeapon(self.lastdroppableweapon);
    self GiveWeapon(weapon);
    self SwitchToWeapon(weapon);
    self setBlockWeaponPickup(weapon, true);
    return true;
  }
  level thread maps\mp\_popups::DisplayTeamMessageToAll(&"KILLSTREAK_M202_FLASH_INBOUND", self);
  level maps\mp\gametypes\_weapons::addLimitedWeapon(weapon, self, 3);
  self TakeWeapon(currentWeapon);
  self GiveWeapon(weapon);
  self SwitchToWeapon(weapon);
  self setBlockWeaponPickup(weapon, true);
  return true;
}
use_killstreak_tv_guided_missile(hardpointType) {
  if(maps\mp\_killstreakrules::isKillstreakAllowed(hardpointType, self.team) == false) {
    self iPrintLnBold(level.killstreaks[hardpointType].notAvailableText);
    return false;
  }
  weapon = "m220_tow_mp";
  currentWeapon = self GetCurrentWeapon();
  if(isSupplyDropWeapon(currentWeapon) || isDefined(level.grenade_array[currentWeapon]) || isDefined(level.inventory_array[currentWeapon])) {
    self TakeWeapon(self.lastdroppableweapon);
    self GiveWeapon(weapon);
    self SwitchToWeapon(weapon);
    self setBlockWeaponPickup(weapon, true);
    return true;
  }
  level thread maps\mp\_popups::DisplayTeamMessageToAll(&"KILLSTREAK_M220_TOW_INBOUND", self);
  level maps\mp\gametypes\_weapons::addLimitedWeapon(weapon, self, 3);
  self TakeWeapon(currentWeapon);
  self GiveWeapon(weapon);
  self SwitchToWeapon(weapon);
  self setBlockWeaponPickup(weapon, true);
  return true;
}
use_killstreak_mp40(hardpointType) {
  if(maps\mp\_killstreakrules::isKillstreakAllowed(hardpointType, self.team) == false) {
    self iPrintLnBold(level.killstreaks[hardpointType].notAvailableText);
    return false;
  }
  weapon = "mp40_blinged_mp";
  currentWeapon = self GetCurrentWeapon();
  if(isSupplyDropWeapon(currentWeapon) || isDefined(level.grenade_array[currentWeapon]) || isDefined(level.inventory_array[currentWeapon])) {
    self TakeWeapon(self.lastdroppableweapon);
    self GiveWeapon(weapon);
    self SwitchToWeapon(weapon);
    self setBlockWeaponPickup(weapon, true);
    return true;
  }
  level thread maps\mp\_popups::DisplayTeamMessageToAll(&"KILLSTREAK_MP40_INBOUND", self);
  level maps\mp\gametypes\_weapons::addLimitedWeapon(weapon, self, 3);
  self TakeWeapon(currentWeapon);
  self GiveWeapon(weapon);
  self SwitchToWeapon(weapon);
  self setBlockWeaponPickup(weapon, true);
  return true;
}
supplyDropWatcher(supplyDropWeapon) {
  self notify("supplyDropWatcher");
  self endon("supplyDropWatcher");
  self endon("spawned_player");
  self endon("disconnect");
  self endon("weapon_change");
  team = self.team;
  self thread checkWeaponChange(team);
  self thread supplyDropGrenadePullWatcher();
  if(self maps\mp\_killstreakrules::killstreakStart("supply_drop_mp", team) == false) {
    return;
  }
  self waittill("grenade_fire", weapon, weapname);
  if(isSupplyDropWeapon(weapname)) {
    self thread doSupplyDrop(weapon, weapname, self);
    weapon thread do_supply_drop_detonation(weapname);
    weapon thread supplyDropGrenadeTimeout(team);
  } else {
    maps\mp\_killstreakrules::killstreakStop("supply_drop_mp", team);
  }
}
supplyDropGrenadeTimeout(team) {
  self endon("death");
  self endon("stationary");
  GRENADE_LIFETIME = 10;
  wait(GRENADE_LIFETIME);
  if(!isDefined(self)) {
    return;
  }
  self notify("grenade_timeout");
  maps\mp\_killstreakrules::killstreakStop("supply_drop_mp", team);
  self delete();
}
checkWeaponChange(team) {
  self endon("supplyDropWatcher");
  self endon("spawned_player");
  self endon("disconnect");
  self endon("grenade_fire");
  self waittill("weapon_change");
  maps\mp\_killstreakrules::killstreakStop("supply_drop_mp", team);
}
supplyDropGrenadePullWatcher() {
  self endon("disconnect");
  self endon("weapon_change");
  self waittill("grenade_pullback", weapon);
  self _disableUsability();
  self thread watchForGrenadePutDown();
  self waittill("death");
  if(isSupplyDropWeapon(weapon)) {
    killstreak = maps\mp\gametypes\_hardpoints::getKillstreakForWeapon(weapon);
    maps\mp\gametypes\_hardpoints::removeUsedKillstreak(killstreak);
  } else {
    maps\mp\gametypes\_hardpoints::removeUsedKillstreak("supply_drop_mp");
  }
}
watchForGrenadePutDown() {
  self notify("watchForGrenadePutDown");
  self endon("watchForGrenadePutDown");
  self endon("death");
  self endon("disconnect");
  self waittill_any("grenade_fire", "weapon_change");
  self _enableUsability();
}
abortSupplyDropMarkerWaiter(waitTillString) {
  self endon("supply_drop_marker_done");
  self waittill(waitTillString);
  self notify("supply_drop_marker_done");
}
playerChangeWeaponWaiter() {
  self endon("supply_drop_marker_done");
  self endon("disconnect");
  self endon("spawned_player");
  currentWeapon = self GetCurrentWeapon();
  while(isSupplyDropWeapon(currentWeapon)) {
    self waittill("weapon_change", currentWeapon);
  }
  waittillframeend;
  self notify("supply_drop_marker_done");
}
isSupplyDropWeapon(weapon) {
  if(weapon == "supplystation_mp" ||
    weapon == "supplydrop_mp" ||
    weapon == "turret_drop_mp" ||
    weapon == "tow_turret_drop_mp" ||
    weapon == "m220_tow_drop_mp") {
    return true;
  }
  return false;
}
getIconForCrate() {
  icon = undefined;
  switch (self.crateType.type) {
    case "killstreak": {
      killstreak = maps\mp\gametypes\_hardpoints::GetKillStreakMenuName(self.crateType.name);
      icon = level.killStreakIcons[killstreak];
    }
    break;
    case "weapon": {
      switch (self.crateType.name) {
        case "minigun_mp":
          icon = "hud_ks_minigun";
          break;
        case "m202_flash_mp":
          icon = "hud_ks_m202";
          break;
        case "m220_tow_mp":
          icon = "hud_ks_tv_guided_missile";
          break;
        case "mp40_drop_mp":
          icon = "hud_mp40";
          break;
        default:
          icon = "waypoint_recon_artillery_strike";
          break;
      }
    }
    break;
    case "ammo": {
      icon = "hud_ammo_refill";
    }
    break;
    default:
      break;
  }
  return icon + "_drop";
}
crateActivate() {
  self MakeUsable();
  self SetCursorHint("HINT_NOICON");
  self setHintString(self.crateType.hint);
  if(isDefined(self.crateType.hint_gambler)) {
    self setHintStringForPerk("specialty_gambler", self.crateType.hint_gambler);
  }
  crateObjID = maps\mp\gametypes\_gameobjects::getNextObjID();
  objective_add(crateObjID, "invisible", self.origin);
  objective_icon(crateObjID, "compass_supply_drop_green");
  objective_state(crateObjID, "active");
  self.friendlyObjID = crateObjID;
  icon = self getIconForCrate();
  if(level.teambased) {
    objective_team(crateObjID, self.team);
    crateObjID = maps\mp\gametypes\_gameobjects::getNextObjID();
    objective_add(crateObjID, "invisible", self.origin);
    if(isDefined(self.hacker)) {
      objective_icon(crateObjID, "compass_supply_drop_black");
    } else {
      objective_icon(crateObjID, "compass_supply_drop_red");
    }
    objective_team(crateObjID, level.otherTeam[self.team]);
    objective_state(crateObjID, "active");
    self.enemyObjID = crateObjID;
  } else {
    Objective_SetInvisibleToAll(crateObjID);
    Objective_SetVisibleToPlayer(crateObjID, self.owner);
    crateObjID = maps\mp\gametypes\_gameobjects::getNextObjID();
    objective_add(crateObjID, "invisible", self.origin);
    objective_icon(crateObjID, "compass_supply_drop_red");
    objective_state(crateObjID, "active");
    Objective_SetInvisibleToPlayer(crateObjID, self.owner);
    self.enemyObjID = crateObjID;
    if(isDefined(self.hacker)) {
      Objective_SetInvisibleToPlayer(crateObjID, self.hacker);
      crateObjID = maps\mp\gametypes\_gameobjects::getNextObjID();
      objective_add(crateObjID, "invisible", self.origin);
      objective_icon(crateObjID, "compass_supply_drop_black");
      objective_state(crateObjID, "active");
      Objective_SetInvisibleToAll(crateObjID);
      Objective_SetVisibleToPlayer(crateObjID, self.hacker);
      self.hackerObjID = crateObjID;
    }
  }
  self thread maps\mp\_entityheadIcons::setEntityHeadIcon(self.team, self, level.crate_headicon_offset, icon, true);
  if(isDefined(self.owner) && self.owner is_bot()) {
    self.owner notify("bot_crate_landed", self);
  }
}
crateDeactivate() {
  self makeunusable();
  if(isDefined(self.friendlyObjID)) {
    Objective_Delete(self.friendlyObjID);
    maps\mp\gametypes\_gameobjects::releaseObjID(self.friendlyObjID);
    self.friendlyObjID = undefined;
  }
  if(isDefined(self.enemyObjID)) {
    Objective_Delete(self.enemyObjID);
    maps\mp\gametypes\_gameobjects::releaseObjID(self.enemyObjID);
    self.enemyObjID = undefined;
  }
  if(isDefined(self.hackerObjID)) {
    Objective_Delete(self.hackerObjID);
    maps\mp\gametypes\_gameobjects::releaseObjID(self.hackerObjID);
    self.hackerObjID = undefined;
  }
  self maps\mp\_entityheadicons::setEntityHeadIcon("none");
}
ownerTeamChangeWatcher() {
  self endon("death");
  if(!level.teamBased || !isDefined(self.owner)) {
    return;
  }
  self.owner waittill("joined_team");
  self.owner = undefined;
}
dropEverythingTouchingCrate(origin) {
  dropAllToGround(origin, 70, 70);
}
dropAllToGroundAfterCrateDelete(crate, crate_origin) {
  crate waittill("death");
  wait(0.1);
  crate dropEverythingTouchingCrate(crate_origin);
}
dropCratesToGround(origin, radius) {
  crate_ents = getEntArray("care_package", "script_noteworthy");
  radius_sq = radius * radius;
  for(i = 0; i < crate_ents.size; i++) {
    if(DistanceSquared(origin, crate_ents[i].origin) < radius_sq) {
      crate_ents[i] thread dropCrateToGround();
    }
  }
}
dropCrateToGround() {
  self endon("death");
  if(isDefined(self.droppingToGround)) {
    return;
  }
  self.droppingToGround = true;
  dropEverythingTouchingCrate(self.origin);
  self crateDeactivate();
  self thread crateDropToGroundKill();
  self crateRedoPhysics();
  self crateActivate();
  self.droppingToGround = undefined;
}
cratespawn(weaponname, owner, team, drop_origin, drop_angle) {
  crate = spawn("script_model", drop_origin, 1);
  crate.angles = drop_angle;
  crate.team = team;
  crate SetTeam(team);
  crate SetOwner(owner);
  crate.script_noteworthy = "care_package";
  if(!level.teamBased || (isDefined(owner) && owner.team == team)) {
    crate.owner = owner;
  }
  crate thread ownerTeamChangeWatcher();
  crate setModel(level.crateModelFriendly);
  crate setEnemyModel(level.crateModelEnemy);
  switch (weaponName) {
    case "turret_drop_mp":
      crate.crateType = level.crateTypes[weaponname]["autoturret_mp"];
      break;
    case "tow_turret_drop_mp":
      crate.crateType = level.crateTypes[weaponname]["auto_tow_mp"];
      break;
    case "minigun_drop_mp":
      crate.crateType = level.crateTypes[weaponname]["minigun_mp"];
      break;
    case "m220_tow_drop_mp":
      crate.crateType = level.crateTypes[weaponname]["m220_tow_mp"];
      break;
    default:
      crate.crateType = getRandomCrateType(weaponname);
      break;
  }
  return crate;
}
crateDelete(drop_all_to_ground) {
  if(!isDefined(drop_all_to_ground)) {
    drop_all_to_ground = true;
  }
  if(isDefined(self.friendlyObjID)) {
    Objective_Delete(self.friendlyObjID);
    maps\mp\gametypes\_gameobjects::releaseObjID(self.friendlyObjID);
    self.friendlyObjID = undefined;
  }
  if(isDefined(self.enemyObjID)) {
    Objective_Delete(self.enemyObjID);
    maps\mp\gametypes\_gameobjects::releaseObjID(self.enemyObjID);
    self.enemyObjID = undefined;
  }
  if(isDefined(self.hackerObjID)) {
    Objective_Delete(self.hackerObjID);
    maps\mp\gametypes\_gameobjects::releaseObjID(self.hackerObjID);
    self.hackerObjID = undefined;
  }
  if(drop_all_to_ground) {
    level thread dropAllToGroundAfterCrateDelete(self, self.origin);
  }
  if(isDefined(self.killcament)) {
    self.killcament thread deleteAfterTime(5);
  }
  self Delete();
}
timeoutCrateWaiter() {
  self endon("death");
  self endon("stationary");
  wait(20);
  self crateDelete();
}
cratePhysics() {
  forcePointVariance = 200.0;
  vertVelocityMin = -100.0;
  vertVelocityMax = 100.0;
  forcePointX = RandomFloatRange(0 - forcePointVariance, forcePointVariance);
  forcePointY = RandomFloatRange(0 - forcePointVariance, forcePointVariance);
  forcePoint = (forcePointX, forcePointY, 0);
  forcePoint += self.origin;
  initialVelocityZ = RandomFloatRange(vertVelocityMin, vertVelocityMax);
  initialVelocity = (0, 0, initialVelocityZ);
  self PhysicsLaunch(forcePoint, initialVelocity);
  self thread timeoutCrateWaiter();
  self thread update_crate_velocity();
  self thread play_impact_sound();
  self waittill("stationary");
}
play_impact_sound() {
  self endon("entityshutdown");
  self endon("stationary");
  wait(0.5);
  while(abs(self.velocity[2]) > 5) {
    wait(0.1);
  }
  self playSound("phy_impact_supply");
}
update_crate_velocity() {
  self endon("entityshutdown");
  self endon("stationary");
  self.velocity = (0, 0, 0);
  self.old_origin = self.origin;
  while(isDefined(self)) {
    self.velocity = (self.origin - self.old_origin);
    self.old_origin = self.origin;
    wait(0.01);
  }
}
crateRedoPhysics() {
  forcePoint = self.origin;
  initialVelocity = (0, 0, 0);
  self PhysicsLaunch(forcePoint, initialVelocity);
  self thread timeoutCrateWaiter();
  self waittill("stationary");
}
do_supply_drop_detonation(weapname) {
  self notify("supplyDropWatcher");
  self endon("supplyDropWatcher");
  self endon("spawned_player");
  self endon("disconnect");
  self endon("death");
  self endon("grenade_timeout");
  self waitTillNotMoving();
  self.angles = (0, self.angles[1], 90);
  fuse_time = GetWeaponFuseTime(weapname) / 1000;
  wait(fuse_time);
  thread playSmokeSound(self.origin, 6, level.sound_smoke_start, level.sound_smoke_stop, level.sound_smoke_loop);
  playFXOnTag(level._supply_drop_smoke_fx, self, "tag_fx");
  proj_explosion_sound = GetWeaponProjExplosionSound(weapname);
  play_sound_in_space(proj_explosion_sound, self.origin);
  wait(3);
  self delete();
}
doSupplyDrop(weapon, weaponname, owner) {
  weapon endon("explode");
  weapon endon("grenade_timeout");
  self endon("disconnect");
  team = owner.team;
  weapon thread watchExplode(weaponname, owner);
  weapon waitTillNotMoving();
  weapon notify("stoppedMoving");
  self thread heliDeliverCrate(weapon.origin, weaponname, owner, team);
}
watchExplode(weaponname, owner) {
  self endon("stoppedMoving");
  team = owner.team;
  self waittill("explode", position);
  owner thread heliDeliverCrate(position, weaponname, owner, team);
}
crateTimeOutThreader() {
  self thread crateTimeOut(90);
}
dropCrate(origin, angle, weaponname, owner, team, killcamEnt) {
  crate = cratespawn(weaponname, owner, team, origin, angle);
  killCamEnt unlink();
  killCamEnt linkto(crate);
  crate.killcamEnt = killcamEnt;
  killCamEnt thread deleteAfterTime(15);
  crate endon("death");
  crate thread crateKill();
  crate cratePhysics();
  crate crateActivate();
  crate thread crateUseThink();
  crate thread crateUseThinkOwner();
  if(isDefined(crate.crateType.hint_gambler)) {
    crate thread crateGamblerThink();
  }
  crate crateTimeOutThreader();
  while(1) {
    crate waittill("captured", player);
    player giveCrateItem(crate);
    if(player HasPerk("specialty_disarmexplosive") &&
      owner != player &&
      ((level.teambased && team != player.team) || !level.teambased)) {
      spawn_explosive_crate(crate.origin, crate.angles, weaponname, owner, team, player);
      crate crateDelete(false);
    } else {
      crate crateDelete();
    }
    return;
  }
}
spawn_explosive_crate(origin, angle, weaponname, owner, team, hacker) {
  crate = cratespawn(weaponname, owner, team, origin, angle);
  crate SetOwner(owner);
  crate SetTeam(team);
  if(level.teambased) {
    crate setEnemyModel(level.crateModelBoobyTrapped);
    crate MakeUsable(team);
  } else {
    crate setEnemyModel(level.crateModelEnemy);
  }
  crate.hacker = hacker;
  crate crateActivate();
  crate thread crateUseThink();
  crate thread crateUseThinkOwner();
  crate thread watch_explosive_crate();
  crate crateTimeOutThreader();
  crate setHintStringForPerk("specialty_gambler", "");
}
watch_explosive_crate() {
  killCamEnt = spawn("script_model", self.origin + (0, 0, 60));
  self.killcament = killcament;
  self waittill("captured", player);
  self thread maps\mp\_entityheadIcons::setEntityHeadIcon(player.team, player, level.crate_headicon_offset, "headicon_dead", true);
  self loop_sound("wpn_semtex_alert", 0.15);
  if(!isDefined(self.hacker)) {
    self.hacker = self;
  }
  self RadiusDamage(self.origin, 256, 300, 75, self.hacker, "MOD_EXPLOSIVE", "supplydrop_mp");
  playFX(level._supply_drop_explosion_fx, self.origin);
  PlaySoundAtPosition("wpn_grenade_explode", self.origin);
  wait(0.1);
  self crateDelete();
  killcament thread deleteAfterTime(5);
}
loop_sound(alias, interval) {
  self endon("death");
  while(1) {
    PlaySoundAtPosition(alias, self.origin);
    wait interval;
    interval = (interval / 1.2);
    if(interval < .08) {
      break;
    }
  }
}
crateKill() {
  self endon("death");
  stationaryThreshold = 2;
  killThreshold = 15;
  maxFramesTillStationary = 20;
  numFramesStationary = 0;
  while(true) {
    vel = 0;
    if(isDefined(self.velocity)) {
      vel = abs(self.velocity[2]);
    }
    if(vel > killThreshold) {
      self is_touching_crate();
    }
    if(vel < stationaryThreshold) {
      numFramesStationary++;
    } else {
      numFramesStationary = 0;
    }
    if(numFramesStationary >= maxFramesTillStationary) {
      break;
    }
    wait 0.01;
  }
}
crateDropToGroundKill() {
  self endon("death");
  self endon("stationary");
  for(;;) {
    players = get_players();
    doTrace = false;
    for(i = 0; i < players.size; i++) {
      if(players[i].sessionstate != "playing") {
        continue;
      }
      if(players[i].team == "spectator") {
        continue;
      }
      self is_equipment_touching_crate(players[i]);
      if(!IsAlive(players[i])) {
        continue;
      }
      flattenedSelfOrigin = (self.origin[0], self.origin[1], 0);
      flattenedPlayerOrigin = (players[i].origin[0], players[i].origin[1], 0);
      if(DistanceSquared(flattenedSelfOrigin, flattenedPlayerOrigin) > 64 * 64) {
        continue;
      }
      doTrace = true;
      break;
    }
    if(doTrace) {
      start = self.origin;
      crateDropToGroundTrace(start);
      start = self GetPointInBounds(1.0, 0.0, 0.0);
      crateDropToGroundTrace(start);
      start = self GetPointInBounds(-1.0, 0.0, 0.0);
      crateDropToGroundTrace(start);
      start = self GetPointInBounds(0.0, -1.0, 0.0);
      crateDropToGroundTrace(start);
      start = self GetPointInBounds(0.0, 1.0, 0.0);
      crateDropToGroundTrace(start);
      start = self GetPointInBounds(1.0, 1.0, 0.0);
      crateDropToGroundTrace(start);
      start = self GetPointInBounds(-1.0, 1.0, 0.0);
      crateDropToGroundTrace(start);
      start = self GetPointInBounds(1.0, -1.0, 0.0);
      crateDropToGroundTrace(start);
      start = self GetPointInBounds(-1.0, -1.0, 0.0);
      crateDropToGroundTrace(start);
      wait(0.2);
    } else {
      wait(0.5);
    }
  }
}
crateDropToGroundTrace(start) {
  end = start + (0, 0, -8000);
  trace = bulletTrace(start, end, true, self, true, true);
  if(isDefined(trace["entity"]) && IsPlayer(trace["entity"]) && IsAlive(trace["entity"])) {
    player = trace["entity"];
    if(player.sessionstate != "playing") {
      return;
    }
    if(player.team == "spectator") {
      return;
    }
    if(DistanceSquared(start, trace["position"]) < 12 * 12 || self IsTouching(player)) {
      player DoDamage(player.health + 1, player.origin, self.owner, self, 0, "MOD_HIT_BY_OBJECT", 0, "supplydrop_mp");
      player playSound("mpl_supply_crush");
      player playSound("phy_impact_supply");
    }
  }
}
is_touching_crate() {
  extraBoundary = (10, 10, 10);
  players = get_players();
  for(i = 0; i < players.size; i++) {
    if(isDefined(players[i]) && IsAlive(players[i]) && self IsTouching(players[i], extraBoundary)) {
      players[i] DoDamage(players[i].health + 1, players[i].origin, self.owner, self, 0, "MOD_HIT_BY_OBJECT", 0, "supplydrop_mp");
      players[i] playSound("mpl_supply_crush");
      players[i] playSound("phy_impact_supply");
    }
    self is_equipment_touching_crate(players[i]);
  }
}
is_equipment_touching_crate(player) {
  extraBoundary = (10, 10, 10);
  if(isDefined(player) && isDefined(player.weaponObjectWatcherArray)) {
    for(watcher = 0; watcher < player.weaponObjectWatcherArray.size; watcher++) {
      objectWatcher = player.weaponObjectWatcherArray[watcher];
      objectArray = objectWatcher.objectArray;
      if(isDefined(objectArray)) {
        for(weaponObject = 0; weaponObject < objectArray.size; weaponObject++) {
          if(isDefined(objectArray[weaponObject]) && self IsTouching(objectArray[weaponObject], extraBoundary)) {
            if(isDefined(objectWatcher.detonate)) {
              objectWatcher thread maps\mp\gametypes\_weaponobjects::waitAndDetonate(objectArray[weaponObject], 0);
            } else {
              maps\mp\gametypes\_weaponobjects::deleteWeaponObject(objectWatcher, objectArray[weaponObject]);
            }
          }
        }
      }
    }
  }
  extraBoundary = (15, 15, 15);
  if(isDefined(player) && isDefined(player.tacticalInsertion) && self IsTouching(player.tacticalInsertion, extraBoundary)) {
    player.tacticalInsertion thread maps\mp\_tacticalinsertion::fizzle();
  }
}
crateTimeOut(time) {
  self endon("death");
  wait(time);
  self crateDelete();
}
spawnUseEnt() {
  useEnt = spawn("script_origin", self.origin);
  useEnt.curProgress = 0;
  useEnt.inUse = false;
  useEnt.useRate = 0;
  useEnt.useTime = 0;
  useEnt.owner = self;
  useEnt thread useEntOwnerDeathWaiter(self);
  return useEnt;
}
useEntOwnerDeathWaiter(owner) {
  self endon("death");
  owner waittill("death");
  self delete();
}
crateUseThink() {
  while(isDefined(self)) {
    self waittill("trigger", player);
    if(!isAlive(player)) {
      continue;
    }
    if(!player isOnGround()) {
      continue;
    }
    if(isDefined(self.owner) && self.owner == player) {
      continue;
    }
    useEnt = self spawnUseEnt();
    result = false;
    if(isDefined(self.hacker)) {
      useEnt.hacker = self.hacker;
    }
    self.useEnt = useEnt;
    if(player HasPerk("specialty_fastinteract")) {
      if(level.teambased && player.team == self.owner.team) {
        result = useEnt useHoldThink(player, level.crateNonOwnerUseTime);
      } else {
        result = useEnt useHoldThink(player, level.crateOwnerUseTime);
      }
    } else {
      result = useEnt useHoldThink(player, level.crateNonOwnerUseTime);
    }
    if(isDefined(useEnt)) {
      useEnt Delete();
    }
    if(result) {
      if(isDefined(self.owner)) {
        if(level.teambased) {
          if(player.team != self.owner.team) {
            self.owner playlocalsound("mpl_crate_enemy_steals");
            if(!isDefined(self.hacker)) {
              player notify("hijacked crate");
            }
          } else {
            if(isDefined(self.owner)) {
              self.owner playlocalsound("mpl_crate_friendly_steals");
              if(!isDefined(self.hacker)) {
                self.owner notify("team crate hijacked", self.crateType);
              }
            }
          }
        } else {
          if(player != self.owner) {
            self.owner playlocalsound("mpl_crate_enemy_steals");
            if(!isDefined(self.hacker)) {
              player notify("hijacked crate");
            }
          }
        }
      }
      self notify("captured", player);
    }
  }
}
crateUseThinkOwner() {
  self endon("joined_team");
  while(isDefined(self)) {
    self waittill("trigger", player);
    if(!isAlive(player)) {
      continue;
    }
    if(!player isOnGround()) {
      continue;
    }
    if(!isDefined(self.owner)) {
      continue;
    }
    if(self.owner != player) {
      continue;
    }
    result = self useHoldThink(player, level.crateOwnerUseTime);
    if(result) {
      self notify("captured", player);
    }
  }
}
useHoldThink(player, useTime) {
  player notify("use_hold");
  player freeze_player_controls(true);
  player _disableWeapon();
  self.curProgress = 0;
  self.inUse = true;
  self.useRate = 0;
  self.useTime = useTime;
  player thread personalUseBar(self);
  result = useHoldThinkLoop(player);
  if(isDefined(player)) {
    player notify("done_using");
  }
  if(isDefined(player)) {
    if(IsAlive(player)) {
      player _enableWeapon();
      player freeze_player_controls(false);
    }
  }
  if(isDefined(self)) {
    self.inUse = false;
  }
  if(isDefined(result) && result) {
    return true;
  }
  return false;
}
useHoldThinkLoop(player) {
  level endon("game_ended");
  self endon("disabled");
  timedOut = 0;
  while(isDefined(self) && isAlive(player) && player useButtonPressed() && !player.throwingGrenade && !player meleeButtonPressed() && !player IsInVehicle() && self.curProgress < self.useTime) {
    timedOut += 0.05;
    self.curProgress += (50 * self.useRate);
    self.useRate = 1;
    if(self.curProgress >= self.useTime) {
      self.inUse = false;
      wait .05;
      return isAlive(player);
    }
    wait 0.05;
    maps\mp\gametypes\_hostmigration::waitTillHostMigrationDone();
  }
  return false;
}
crateGamblerThink() {
  self endon("death");
  for(;;) {
    self waittill("trigger_use_doubletap", player);
    if(!player HasPerk("specialty_gambler")) {
      continue;
    }
    if(isDefined(self.useEnt) && self.useEnt.inUse) {
      continue;
    }
    player playlocalsound("uin_gamble_perk");
    self.crateType = getRandomCrateType("gambler_mp", self.crateType.name);
    self crateReactivate();
    return;
  }
}
crateReactivate() {
  self setHintString(self.crateType.hint);
  self setHintStringForPerk("specialty_gambler", "");
  icon = self getIconForCrate();
  self thread maps\mp\_entityheadIcons::setEntityHeadIcon(self.team, self, level.crate_headicon_offset, icon, true);
}
personalUseBar(object) {
  self endon("disconnect");
  self.useBar = createSecondaryProgressBar();
  self.useBarText = createSecondaryProgressBarText();
  if(self HasPerk("specialty_disarmexplosive") &&
    object.owner != self &&
    !isDefined(object.hacker) &&
    ((level.teambased && object.owner.team != self.team) || !level.teambased)) {
    self.useBarText setText(&"KILLSTREAK_HACKING_CRATE");
    self PlayLocalSound("evt_hacker_hacking");
  } else {
    self.useBarText setText(&"KILLSTREAK_CAPTURING_CRATE");
  }
  lastRate = -1;
  while(isAlive(self) && isDefined(object) && object.inUse && !level.gameEnded) {
    if(lastRate != object.useRate) {
      if(object.curProgress > object.useTime) {
        object.curProgress = object.useTime;
      }
      self.useBar updateBar(object.curProgress / object.useTime, (1000 / object.useTime) * object.useRate);
      if(!object.useRate) {
        self.useBar hideElem();
        self.useBarText hideElem();
      } else {
        self.useBar showElem();
        self.useBarText showElem();
      }
    }
    lastRate = object.useRate;
    wait(0.05);
  }
  self.useBar destroyElem();
  self.useBarText destroyElem();
}
spawn_helicopter(owner, team, origin, angles, model, targetname) {
  chopper = spawnHelicopter(owner, origin, angles, model, targetname);
  if(!isDefined(chopper)) {
    maps\mp\_killstreakrules::killstreakStop("supply_drop_mp", team);
    return undefined;
  }
  chopper.owner = owner;
  chopper.maxhealth = 1500;
  chopper.health = 999999;
  chopper.rocketDamageOneShot = chopper.maxhealth + 1;
  chopper.damageTaken = 0;
  chopper thread maps\mp\_helicopter::heli_damage_monitor("supply_drop_mp");
  chopper.spawnTime = GetTime();
  supplydropSpeed = getDvarIntDefault(#"scr_supplydropSpeedStarting", 125);
  supplydropAccel = getDvarIntDefault(#"scr_supplydropAccelStarting", 100);
  chopper SetSpeed(supplydropSpeed, supplydropAccel);
  maxPitch = getDvarIntDefault(#"scr_supplydropMaxPitch", 25);
  maxRoll = getDvarIntDefault(#"scr_supplydropMaxRoll", 45);
  chopper SetMaxPitchRoll(0, maxRoll);
  chopper.team = team;
  Target_Set(chopper, (-200, 0, -100));
  chopper thread refCountDecChopper(team);
  chopper thread heliDestroyed();
  return chopper;
}
getDropHeight(origin) {
  return maps\mp\_airsupport::getMinimumFlyHeight();
}
getDropDirection() {
  return (0, RandomInt(360), 0);
}
getNextDropDirection(drop_direction, degrees) {
  drop_direction = (0, drop_direction[1] + degrees, 0);
  if(drop_direction[1] >= 360) {
    drop_direction = (0, drop_direction[1] - 360, 0);
  }
  return drop_direction;
}
getHeliStart(drop_origin, drop_direction) {
  dist = -1 * getDvarIntDefault(#"scr_supplydropIncomingDistance", 10000);
  pathRandomness = 100;
  direction = drop_direction + (0, RandomIntRange(-2, 3), 0);
  start_origin = drop_origin + vector_multiply(anglesToForward(direction), dist);
  start_origin += ((randomfloat(2) - 1) * pathRandomness, (randomfloat(2) - 1) * pathRandomness, 0);
  return start_origin;
}
getHeliEnd(drop_origin, drop_direction) {
  pathRandomness = 150;
  dist = -1 * getDvarIntDefault(#"scr_supplydropOutgoingDistance", 15000);
  if(RandomIntRange(0, 2) == 0) {
    turn = RandomIntRange(60, 121);
  } else {
    turn = -1 * RandomIntRange(60, 121);
  }
  direction = drop_direction + (0, turn, 0);
  end_origin = drop_origin + vector_multiply(anglesToForward(direction), dist);
  end_origin += ((randomfloat(2) - 1) * pathRandomness, (randomfloat(2) - 1) * pathRandomness, 0);
  return end_origin;
}
addOffsetOntoPoint(point, direction, offset) {
  angles = VectorToAngles((direction[0], direction[1], 0));
  offset_world = RotatePoint(offset, angles);
  return (point + offset_world);
}
supplyDropHeliStartPath(goal, goal_offset) {
  total_tries = 12;
  tries = 0;
  goalPath = spawnStruct();
  drop_direction = getDropDirection();
  while(tries < total_tries) {
    goalPath.start = getHeliStart(goal, drop_direction);
    goalPath.path = maps\mp\_airsupport::getHeliPath(goalPath.start, goal);
    if(isDefined(goalPath.path)) {
      if(goalPath.path.size > 1) {
        direction = (goalPath.path[goalPath.path.size - 1] - goalPath.path[goalPath.path.size - 2]);
      } else {
        direction = (goalPath.path[goalPath.path.size - 1] - goalPath.start);
      }
      goalPath.path[goalPath.path.size - 1] = addOffsetOntoPoint(goalPath.path[goalPath.path.size - 1], direction, goal_offset);
      return goalPath;
    }
    drop_direction = getNextDropDirection(drop_direction, 30);
    tries++;
  }
  drop_direction = getDropDirection();
  goalPath.start = getHeliStart(goal, drop_direction);
  direction = (goal - goalPath.start);
  goalPath.path = [];
  goalPath.path[0] = addOffsetOntoPoint(goal, direction, goal_offset);
  return goalPath;
}
supplyDropHeliEndPath(origin, drop_direction) {
  total_tries = 5;
  tries = 0;
  goalPath = spawnStruct();
  while(tries < total_tries) {
    goal = getHeliEnd(origin, drop_direction);
    goalPath.path = maps\mp\_airsupport::getHeliPath(origin, goal);
    if(isDefined(goalPath.path)) {
      return goalPath;
    }
    tries++;
  }
  goalPath.path = [];
  goalPath.path[0] = getHeliEnd(origin, drop_direction);
  return goalPath;
}
heliDeliverCrate(origin, weaponname, owner, team) {
  if(weaponname == "turret_drop_mp") {
    self maps\mp\gametypes\_hardpoints::playKillstreakStartDialog("turret_drop_mp", self.pers["team"]);
    self maps\mp\gametypes\_persistence::statAdd("AUTO_TURRET_USED", 1, false);
  } else if(weaponname == "tow_turret_drop_mp") {
    self maps\mp\gametypes\_hardpoints::playKillstreakStartDialog("tow_turret_drop_mp", self.pers["team"]);
    self maps\mp\gametypes\_persistence::statAdd("TOW_TURRET_USED", 1, false);
  } else {
    self maps\mp\gametypes\_hardpoints::playKillstreakStartDialog("supply_drop_mp", self.pers["team"]);
    self maps\mp\gametypes\_persistence::statAdd("SUPPLY_DROP_USED", 1, false);
    self maps\mp\gametypes\_globallogic_score::incItemStatByReference("killstreak_supply_drop", 1, "used");
  }
  rear_hatch_offset_local = getDvarIntDefault(#"scr_supplydropOffset", 400);
  drop_origin = origin;
  drop_height = getDropHeight(drop_origin);
  heli_drop_goal = (drop_origin[0], drop_origin[1], drop_height);
  goalPath = supplyDropHeliStartPath(heli_drop_goal, (rear_hatch_offset_local, 0, 0));
  drop_direction = VectorToAngles((heli_drop_goal[0], heli_drop_goal[1], 0) - (goalPath.start[0], goalPath.start[1], 0));
  chopper = spawn_helicopter(owner, team, goalPath.start, drop_direction, level.suppyDropHelicopterVehicleInfo, level.supplyDropHelicopterFriendly);
  chopper setenemymodel(level.supplyDropHelicopterEnemy);
  chopper SetTeam(team);
  chopper SetOwner(owner);
  killCamEnt = spawn("script_model", chopper.origin + (0, 0, 800));
  killCamEnt.angles = (100, chopper.angles[1], chopper.angles[2]);
  killCamEnt.startTime = gettime();
  killCamEnt linkTo(chopper);
  Target_SetTurretAquire(self, false);
  chopper thread SAMTurretWatcher(drop_origin);
  if(!isDefined(chopper)) {
    return;
  }
  chopper thread heliDropCrate(weaponname, owner, rear_hatch_offset_local, killCamEnt);
  chopper endon("death");
  chopper thread maps\mp\_airsupport::followPath(goalPath.path, "drop_goal", true);
  chopper thread speedRegulator(heli_drop_goal);
  chopper waittill("drop_goal");
  wait(0.2);
  chopper notify("drop_crate", chopper.origin, chopper.angles);
  chopper.dropTime = GetTime();
  supplydropSpeed = getDvarIntDefault(#"scr_supplydropSpeedLeaving", 150);
  supplydropAccel = getDvarIntDefault(#"scr_supplydropAccelLeaving", 40);
  chopper setspeed(supplydropSpeed, supplydropAccel);
  goalPath = supplyDropHeliEndPath(chopper.origin, (0, chopper.angles[1], 0));
  chopper maps\mp\_airsupport::followPath(goalPath.path, undefined, false);
  chopper notify("leaving");
  chopper Delete();
}
SAMTurretWatcher(destination) {
  self endon("leaving");
  self endon("helicopter_gone");
  self endon("death");
  SAM_TURRET_AQUIRE_DIST = 1500;
  while(1) {
    if(Distance(destination, self.origin) < SAM_TURRET_AQUIRE_DIST) {
      break;
    }
    if(self.origin[0] > level.spawnMins[0] && self.origin[0] < level.spawnMaxs[0] &&
      self.origin[1] > level.spawnMins[1] && self.origin[1] < level.spawnMaxs[1]) {
      break;
    }
    wait(0.1);
  }
  Target_SetTurretAquire(self, true);
}
speedRegulator(goal) {
  self endon("drop_goal");
  self endon("death");
  wait(3);
  supplydropSpeed = getDvarIntDefault(#"scr_supplydropSpeed", 75);
  supplydropAccel = getDvarIntDefault(#"scr_supplydropAccel", 40);
  self SetYawSpeed(100, 60, 60);
  self SetSpeed(supplydropSpeed, supplydropAccel);
  wait(1);
  maxPitch = getDvarIntDefault(#"scr_supplydropMaxPitch", 25);
  maxRoll = getDvarIntDefault(#"scr_supplydropMaxRoll", 35);
  self SetMaxPitchRoll(maxPitch, maxRoll);
}
heliDropCrate(weaponname, owner, offset, killCamEnt) {
  owner endon("disconnect");
  self waittill("drop_crate", origin, angles);
  rear_hatch_offset_height = getDvarIntDefault(#"scr_supplydropOffsetHeight", 200);
  rear_hatch_offset_world = RotatePoint((offset, 0, 0), angles);
  drop_origin = origin - (0, 0, rear_hatch_offset_height) - rear_hatch_offset_world;
  thread dropCrate(drop_origin, angles, weaponname, owner, self.team, killCamEnt);
}
heliDestroyed() {
  self endon("leaving");
  self endon("helicopter_gone");
  self endon("death");
  while(true) {
    if(self.damageTaken > self.maxhealth) {
      break;
    }
    wait(0.05);
  }
  if(!isDefined(self)) {
    return;
  }
  self SetSpeed(25, 5);
  self thread lbSpin(RandomIntRange(180, 220));
  wait(RandomFloatRange(.5, 1.5));
  self notify("drop_crate", self.origin, self.angles);
  lbExplode();
}
lbExplode() {
  forward = (self.origin + (0, 0, 1)) - self.origin;
  playFX(level.chopper_fx["explode"]["death"], self.origin, forward);
  self playSound(level.heli_sound[self.team]["crash"]);
  self notify("explode");
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
refCountDecChopper(team) {
  self waittill("death");
  maps\mp\_killstreakrules::killstreakStop("supply_drop_mp", team);
}
refCountDecChopperOnDisconnect(team) {
  self endon("supply_drop_marker_done");
  self waittill("disconnecct");
  maps\mp\_killstreakrules::killstreakStop("supply_drop_mp", team);
}