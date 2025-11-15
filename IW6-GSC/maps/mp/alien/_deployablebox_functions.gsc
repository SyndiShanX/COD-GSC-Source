/******************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\alien\_deployablebox_functions.gsc
******************************************************/

#include maps\mp\_utility;
#include common_scripts\utility;
#include maps\mp\gametypes\_hud_util;
#include maps\mp\alien\_utility;
#include maps\mp\alien\_perk_utility;

RANDOMBOX_TABLE = "mp/alien/deployable_randombox.csv";

TABLE_ITEM_INDEX = 0;
TABLE_ITEM_REF = 1;
TABLE_ITEM_LEVEL_0_WEIGHT = 2;
TABLE_ITEM_LEVEL_1_WEIGHT = 3;
TABLE_ITEM_LEVEL_2_WEIGHT = 4;
TABLE_ITEM_LEVEL_3_WEIGHT = 5;
TABLE_ITEM_LEVEL_4_WEIGHT = 6;
TABLE_ITEM_STRING = 7;

pre_load() {
  level.deployable_currency_ranks = [];
  level.deployable_currency_ranks[0] = 1000;
  level.deployable_currency_ranks[1] = 2000;
  level.deployable_currency_ranks[2] = 3000;
  level.deployable_currency_ranks[3] = 4000;
  level.deployable_currency_ranks[4] = 10000;

  PreCacheString(&"ALIEN_COLLECTIBLES_DEPLOYABLE_CURRENCY_PICKUP");
  PreCacheString(&"ALIEN_COLLECTIBLES_DEPLOYABLE_CURRENCY_TAKING");
  PreCacheString(&"ALIEN_COLLECTIBLES_DEPLOYABLE_CURRENCY_TAKEN");

  level.randombox_items = [];
  randombox_table_init(0, 99);
}

deployables_init() {
  boxConfig = spawnStruct();
  boxConfig.weaponInfo = "aliendeployable_crate_marker_mp";
  boxConfig.modelBase = "mp_weapon_alien_crate";
  boxConfig.hintString = & "ALIEN_COLLECTIBLES_DEPLOYABLE_EXPLOSIVES_PICKUP";
  boxConfig.capturingString = & "ALIEN_COLLECTIBLES_DEPLOYABLE_EXPLOSIVES_TAKING";
  boxConfig.eventString = & "ALIEN_COLLECTIBLES_DEPLOYABLE_EXPLOSIVES_TAKEN";
  boxConfig.streakName = "deployable_explosives";
  boxConfig.dpadName = "dpad_team_explosives";
  boxConfig.splashName = "used_deployable_explosives";
  boxConfig.shaderName = "compass_objpoint_deploy_grenades_friendly";
  boxConfig.headIconOffset = 25;
  boxConfig.lifeSpan = 90.0;
  boxConfig.useXP = 0;
  boxConfig.voDestroyed = "ballistic_vest_destroyed";
  boxConfig.deployedSfx = "mp_vest_deployed_ui";
  boxConfig.onUseSfx = "ammo_crate_use";
  boxConfig.onUseCallback = ::onUseDeployable_explosives;
  boxConfig.canUseCallback = maps\mp\alien\_deployablebox::default_canUseDeployable;
  boxConfig.useTime = 500;
  boxConfig.maxHealth = 150;
  boxConfig.damageFeedback = "deployable_bag";
  boxConfig.deathWeaponInfo = "deployable_grenades_mp";
  boxConfig.killXP = 0;
  boxConfig.allowMeleeDamage = false;
  boxConfig.allowGrenadeDamage = false;
  boxConfig.maxUses = 4;
  maps\mp\alien\_deployablebox::init_deployable("deployable_explosives", boxConfig);

  boxConfig = spawnStruct();
  boxConfig.weaponInfo = "aliendeployable_crate_marker_mp";
  boxConfig.modelBase = "mp_weapon_alien_crate";
  boxConfig.hintString = & "KILLSTREAKS_HINTS_LIGHT_ARMOR_PICKUP";
  boxConfig.capturingString = & "KILLSTREAKS_BOX_GETTING_VEST";
  boxConfig.eventString = & "KILLSTREAKS_DEPLOYED_VEST";
  boxConfig.streakName = "deployable_vest";
  boxConfig.dpadName = "dpad_team_armor";
  boxConfig.splashName = "used_deployable_vest";
  boxConfig.shaderName = "compass_objpoint_deploy_friendly";
  boxConfig.headIconOffset = 20;
  boxConfig.lifeSpan = 90.0;
  boxConfig.useXP = 0;
  boxConfig.voDestroyed = "ballistic_vest_destroyed";
  boxConfig.deployedSfx = "mp_vest_deployed_ui";
  boxConfig.onUseSfx = "ammo_crate_use";
  boxConfig.onUseCallback = ::onUseDeployable_vest;
  boxConfig.canUseCallback = maps\mp\alien\_deployablebox::default_canUseDeployable;
  boxConfig.useTime = 500;
  boxConfig.maxHealth = 300;
  boxConfig.damageFeedback = "deployable_bag";
  boxConfig.killXP = 0;
  boxConfig.allowMeleeDamage = false;
  boxConfig.allowGrenadeDamage = false;
  boxConfig.maxUses = 3;
  maps\mp\alien\_deployablebox::init_deployable("deployable_vest", boxConfig);

  boxConfig = spawnStruct();
  boxConfig.weaponInfo = "aliendeployable_crate_marker_mp";
  boxConfig.modelBase = "mp_weapon_alien_crate";
  boxConfig.hintString = & "KILLSTREAKS_HINTS_DEPLOYABLE_AMMO_USE";
  boxConfig.capturingString = & "KILLSTREAKS_DEPLOYABLE_AMMO_TAKING";
  boxConfig.eventString = & "KILLSTREAKS_DEPLOYABLE_AMMO_TAKEN";
  boxConfig.streakName = "deployable_ammo";
  boxConfig.dpadName = "dpad_team_ammo_reg";
  boxConfig.splashName = "used_deployable_ammo";
  boxConfig.shaderName = "compass_objpoint_deploy_ammo_friendly";
  boxConfig.headIconOffset = 25;
  boxConfig.lifeSpan = 90.0;
  boxConfig.useXP = 0;
  boxConfig.voDestroyed = "ballistic_vest_destroyed";
  boxConfig.deployedSfx = "mp_vest_deployed_ui";
  boxConfig.onUseSfx = "ammo_crate_use";
  boxConfig.onUseCallback = ::onUseDeployable_ammo;
  boxConfig.canUseCallback = maps\mp\alien\_deployablebox::default_canUseDeployable;
  boxConfig.useTime = 500;
  boxConfig.maxHealth = 150;
  boxConfig.damageFeedback = "deployable_bag";
  boxConfig.killXP = 0;
  boxConfig.allowMeleeDamage = false;
  boxConfig.allowGrenadeDamage = false;
  boxConfig.maxUses = 3;
  maps\mp\alien\_deployablebox::init_deployable("deployable_ammo", boxConfig);

  if(is_chaos_mode())
    level.randombox_table = "mp/alien/chaos_deployable_randombox.csv";
  if(!isDefined(level.randombox_table))
    level.randombox_table = RANDOMBOX_TABLE;

  boxConfig = spawnStruct();
  boxConfig.weaponInfo = "aliendeployable_crate_marker_mp";
  boxConfig.modelBase = "mp_weapon_alien_crate";
  boxConfig.hintString = & "ALIEN_COLLECTIBLES_DEPLOYABLE_RANDOM_PICKUP";
  boxConfig.capturingString = & "ALIEN_COLLECTIBLES_DEPLOYABLE_RANDOM_TAKING";
  boxConfig.streakName = "deployable_randombox";
  boxConfig.dpadName = "dpad_team_randombox";
  boxConfig.splashName = "used_deployable_randombox";
  boxConfig.shaderName = "compass_objpoint_deploy_grenades_friendly";
  boxConfig.headIconOffset = 25;
  boxConfig.lifeSpan = 90.0;
  boxConfig.useXP = 0;
  boxConfig.voDestroyed = "ballistic_vest_destroyed";
  boxConfig.deployedSfx = "mp_vest_deployed_ui";
  boxConfig.onUseSfx = "ammo_crate_use";
  boxConfig.onUseCallback = ::onUseDeployable_randombox;
  boxConfig.canUseCallback = maps\mp\alien\_deployablebox::default_canUseDeployable;
  boxConfig.useTime = 500;
  boxConfig.maxHealth = 150;
  boxConfig.damageFeedback = "deployable_bag";
  boxConfig.deathWeaponInfo = "deployable_grenades_mp";
  boxConfig.killXP = 0;
  boxConfig.allowMeleeDamage = false;
  boxConfig.allowGrenadeDamage = false;
  boxConfig.maxUses = 3;
  maps\mp\alien\_deployablebox::init_deployable("deployable_randombox", boxConfig);

  boxConfig = spawnStruct();
  boxConfig.weaponInfo = "aliendeployable_crate_marker_mp";
  boxConfig.modelBase = "mp_weapon_alien_crate";
  boxConfig.hintString = & "ALIEN_COLLECTIBLES_DEPLOYABLE_CURRENCY_PICKUP";
  boxConfig.capturingString = & "ALIEN_COLLECTIBLES_DEPLOYABLE_CURRENCY_TAKING";
  boxConfig.eventString = & "ALIEN_COLLECTIBLES_DEPLOYABLE_CURRENCY_TAKEN";
  boxConfig.streakName = "deployable_currency";
  boxConfig.dpadName = "dpad_team_currency";
  boxConfig.splashName = "used_deployable_currency";
  boxConfig.shaderName = "compass_objpoint_deploy_friendly";
  boxConfig.headIconOffset = 25;
  boxConfig.lifeSpan = 90.0;
  boxConfig.useXP = 0;
  boxConfig.voDestroyed = "ballistic_vest_destroyed";
  boxConfig.deployedSfx = "mp_vest_deployed_ui";
  boxConfig.onUseSfx = "ammo_crate_use";
  boxConfig.onUseCallback = ::onUseDeployable_currency;
  boxConfig.canUseCallback = maps\mp\alien\_deployablebox::default_canUseDeployable;
  boxConfig.useTime = 500;
  boxConfig.maxHealth = 150;
  boxConfig.damageFeedback = "deployable_bag";
  boxConfig.deathWeaponInfo = "deployable_grenades_mp";
  boxConfig.killXP = 0;
  boxConfig.allowMeleeDamage = false;
  boxConfig.allowGrenadeDamage = false;
  boxConfig.maxUses = 4;
  boxConfig.icon_name = "alien_dpad_icon_team_money";
  maps\mp\alien\_deployablebox::init_deployable("deployable_currency", boxConfig);

  boxConfig = spawnStruct();
  boxConfig.weaponInfo = "aliendeployable_crate_marker_mp";
  boxConfig.modelBase = "mp_weapon_alien_crate";
  boxConfig.hintString = & "ALIEN_COLLECTIBLES_DEPLOYABLE_ADRENALINE_PICKUP";
  boxConfig.capturingString = & "ALIEN_COLLECTIBLES_DEPLOYABLE_BOOST_TAKING";
  boxConfig.eventString = & "ALIEN_COLLECTIBLES_DEPLOYABLE_BOOST_TAKEN";
  boxConfig.streakName = "deployable_adrenalinebox";
  boxConfig.dpadName = "dpad_team_adrenaline";
  boxConfig.splashName = "used_deployable_juicebox";
  boxConfig.shaderName = "compass_objpoint_deploy_juiced_friendly";
  boxConfig.headIconOffset = 25;
  boxConfig.lifeSpan = 90.0;
  boxConfig.useXP = 0;
  boxConfig.voDestroyed = "ballistic_vest_destroyed";
  boxConfig.deployedSfx = "mp_vest_deployed_ui";
  boxConfig.onUseSfx = "ammo_crate_use";
  boxConfig.onUseCallback = ::onUseDeployable_adrenaline;
  boxConfig.canUseCallback = maps\mp\alien\_deployablebox::default_canUseDeployable;
  boxConfig.useTime = 500;
  boxConfig.maxHealth = 300;
  boxConfig.damageFeedback = "deployable_bag";
  boxConfig.deathWeaponInfo = "deployable_ammo_mp";
  boxConfig.killXP = 0;
  boxConfig.allowMeleeDamage = false;
  boxConfig.allowGrenadeDamage = false;
  boxConfig.maxUses = 3;
  level.custom_adrenalinebox_logic = ::custom_adrenalinebox_logic;
  maps\mp\alien\_deployablebox::init_deployable("deployable_adrenalinebox", boxConfig);

  boxConfig = spawnStruct();
  boxConfig.weaponInfo = "aliendeployable_crate_marker_mp";
  boxConfig.modelBase = "mp_weapon_alien_crate";
  boxConfig.hintString = & "KILLSTREAKS_HINTS_DEPLOYABLE_JUICEBOX_PICKUP";
  boxConfig.capturingString = & "KILLSTREAKS_DEPLOYABLE_JUICEBOX_TAKING";
  boxConfig.eventString = & "KILLSTREAKS_DEPLOYABLE_JUICEBOX_TAKEN";
  boxConfig.streakName = "deployable_juicebox";
  boxConfig.dpadName = "dpad_team_boost";
  boxConfig.splashName = "used_deployable_juicebox";
  boxConfig.shaderName = "compass_objpoint_deploy_juiced_friendly";
  boxConfig.headIconOffset = 25;
  boxConfig.lifeSpan = 90.0;
  boxConfig.useXP = 0;
  boxConfig.voDestroyed = "ballistic_vest_destroyed";
  boxConfig.deployedSfx = "mp_vest_deployed_ui";
  boxConfig.onUseSfx = "ammo_crate_use";
  boxConfig.onUseCallback = ::onUseDeployable_juicebox;
  boxConfig.canUseCallback = maps\mp\alien\_deployablebox::default_canUseDeployable;
  boxConfig.useTime = 500;
  boxConfig.maxHealth = 300;
  boxConfig.damageFeedback = "deployable_bag";
  boxConfig.deathWeaponInfo = "deployable_ammo_mp";
  boxConfig.killXP = 0;
  boxConfig.allowMeleeDamage = false;
  boxConfig.allowGrenadeDamage = false;
  boxConfig.maxUses = 3;
  level.custom_juicebox_logic = ::custom_juicebox_logic;
  maps\mp\alien\_deployablebox::init_deployable("deployable_juicebox", boxConfig);
}

specialammo_init() {
  BOX_TYPE = "";
  DPAD_BOX_NAME = "dpad_team_ammo_in";

  boxConfig = spawnStruct();
  boxConfig.weaponInfo = "aliendeployable_crate_marker_mp";
  boxConfig.modelBase = "mp_weapon_alien_crate";
  boxConfig.hintString = & "ALIEN_COLLECTIBLES_DEPLOYABLE_INCENDIARYAMMO_PICKUP";
  boxConfig.capturingString = & "ALIEN_COLLECTIBLES_DEPLOYABLE_AMMO_TAKING";
  boxConfig.eventString = & "ALIEN_COLLECTIBLES_DEPLOYABLE_AMMO_TAKEN";
  boxConfig.streakName = "deployable_specialammo_in";
  boxConfig.dpadName = "dpad_team_ammo_in";
  boxConfig.splashName = "used_deployable_in_ammo";
  boxConfig.shaderName = "compass_objpoint_deploy_grenades_friendly";
  boxConfig.headIconOffset = 25;
  boxConfig.lifeSpan = 90.0;
  boxConfig.useXP = 0;
  boxConfig.voDestroyed = "ballistic_vest_destroyed";
  boxConfig.deployedSfx = "mp_vest_deployed_ui";
  boxConfig.onUseSfx = "ammo_crate_use";
  boxConfig.onUseCallback = ::default_specialammo_onUseDeployable;
  boxConfig.canUseCallback = maps\mp\alien\_deployablebox::default_canUseDeployable;
  boxConfig.useTime = 500;
  boxConfig.maxHealth = 150;
  boxConfig.damageFeedback = "deployable_bag";
  boxConfig.deathWeaponInfo = "deployable_specialammo_mp";
  boxConfig.killXP = 0;
  boxConfig.allowMeleeDamage = false;
  boxConfig.allowGrenadeDamage = false;
  boxConfig.maxUses = 3;
  if(is_chaos_mode())
    boxConfig.maxUses = 1;
  maps\mp\alien\_deployablebox::init_deployable("deployable_specialammo_in", boxConfig);

  boxConfig = spawnStruct();
  boxConfig.weaponInfo = "aliendeployable_crate_marker_mp";
  boxConfig.modelBase = "mp_weapon_alien_crate";
  boxConfig.hintString = & "ALIEN_COLLECTIBLES_DEPLOYABLE_EXPLOSIVEAMMO_PICKUP";
  boxConfig.capturingString = & "ALIEN_COLLECTIBLES_DEPLOYABLE_AMMO_TAKING";
  boxConfig.eventString = & "ALIEN_COLLECTIBLES_DEPLOYABLE_AMMO_TAKEN";
  boxConfig.streakName = "deployable_specialammo_explo";
  boxConfig.dpadName = "dpad_team_ammo_explo";
  boxConfig.splashName = "used_deployable_exp_ammo";
  boxConfig.shaderName = "compass_objpoint_deploy_grenades_friendly";
  boxConfig.headIconOffset = 25;
  boxConfig.lifeSpan = 90.0;
  boxConfig.useXP = 0;
  boxConfig.voDestroyed = "ballistic_vest_destroyed";
  boxConfig.deployedSfx = "mp_vest_deployed_ui";
  boxConfig.onUseSfx = "ammo_crate_use";
  boxConfig.onUseCallback = ::default_specialammo_onUseDeployable;
  boxConfig.canUseCallback = maps\mp\alien\_deployablebox::default_canUseDeployable;
  boxConfig.useTime = 500;
  boxConfig.maxHealth = 150;
  boxConfig.damageFeedback = "deployable_bag";
  boxConfig.deathWeaponInfo = "deployable_specialammo_mp";
  boxConfig.killXP = 0;
  boxConfig.allowMeleeDamage = false;
  boxConfig.allowGrenadeDamage = false;
  boxConfig.maxUses = 3;
  if(is_chaos_mode())
    boxConfig.maxUses = 1;

  maps\mp\alien\_deployablebox::init_deployable("deployable_specialammo_explo", boxConfig);

  boxConfig = spawnStruct();
  boxConfig.weaponInfo = "aliendeployable_crate_marker_mp";
  boxConfig.modelBase = "mp_weapon_alien_crate";
  boxConfig.hintString = & "ALIEN_COLLECTIBLES_DEPLOYABLE_STUNAMMO_PICKUP";
  boxConfig.capturingString = & "ALIEN_COLLECTIBLES_DEPLOYABLE_AMMO_TAKING";
  boxConfig.eventString = & "ALIEN_COLLECTIBLES_DEPLOYABLE_AMMO_TAKEN";
  boxConfig.streakName = "deployable_specialammo";
  boxConfig.dpadName = "dpad_team_ammo_stun";
  boxConfig.splashName = "used_deployable_stun_ammo";
  boxConfig.shaderName = "compass_objpoint_deploy_grenades_friendly";
  boxConfig.headIconOffset = 25;
  boxConfig.lifeSpan = 90.0;
  boxConfig.useXP = 0;
  boxConfig.voDestroyed = "ballistic_vest_destroyed";
  boxConfig.deployedSfx = "mp_vest_deployed_ui";
  boxConfig.onUseSfx = "ammo_crate_use";
  boxConfig.onUseCallback = ::default_specialammo_onUseDeployable;
  boxConfig.canUseCallback = maps\mp\alien\_deployablebox::default_canUseDeployable;
  boxConfig.useTime = 500;
  boxConfig.maxHealth = 150;
  boxConfig.damageFeedback = "deployable_bag";
  boxConfig.deathWeaponInfo = "deployable_specialammo_mp";
  boxConfig.killXP = 0;
  boxConfig.allowMeleeDamage = false;
  boxConfig.allowGrenadeDamage = false;
  boxConfig.maxUses = 3;
  if(is_chaos_mode())
    boxConfig.maxUses = 1;

  maps\mp\alien\_deployablebox::init_deployable("deployable_specialammo", boxConfig);

  boxConfig = spawnStruct();
  boxConfig.weaponInfo = "aliendeployable_crate_marker_mp";
  boxConfig.modelBase = "mp_weapon_alien_crate";
  boxConfig.hintString = & "ALIEN_COLLECTIBLES_DEPLOYABLE_APAMMO_PICKUP";
  boxConfig.capturingString = & "ALIEN_COLLECTIBLES_DEPLOYABLE_AMMO_TAKING";
  boxConfig.eventString = & "ALIEN_COLLECTIBLES_DEPLOYABLE_AMMO_TAKEN";
  boxConfig.streakName = "deployable_specialammo_ap";
  boxConfig.dpadName = "dpad_team_ammo_ap";
  boxConfig.splashName = "used_deployable_ap_ammo";
  boxConfig.shaderName = "compass_objpoint_deploy_grenades_friendly";
  boxConfig.headIconOffset = 25;
  boxConfig.lifeSpan = 90.0;
  boxConfig.useXP = 0;
  boxConfig.voDestroyed = "ballistic_vest_destroyed";
  boxConfig.deployedSfx = "mp_vest_deployed_ui";
  boxConfig.onUseSfx = "ammo_crate_use";
  boxConfig.onUseCallback = ::default_specialammo_onUseDeployable;
  boxConfig.canUseCallback = maps\mp\alien\_deployablebox::default_canUseDeployable;
  boxConfig.useTime = 500;
  boxConfig.maxHealth = 150;
  boxConfig.damageFeedback = "deployable_bag";
  boxConfig.deathWeaponInfo = "deployable_specialammo_mp";
  boxConfig.killXP = 0;
  boxConfig.allowMeleeDamage = false;
  boxConfig.allowGrenadeDamage = false;
  boxConfig.maxUses = 3;
  if(is_chaos_mode())
    boxConfig.maxUses = 1;

  maps\mp\alien\_deployablebox::init_deployable("deployable_specialammo_ap", boxConfig);

  boxConfig = spawnStruct();
  boxConfig.weaponInfo = "aliendeployable_crate_marker_mp";
  boxConfig.modelBase = "mp_weapon_alien_crate";
  boxConfig.hintString = & "ALIENS_PATCH_COMBINED_AMMO_PICKUP";
  boxConfig.capturingString = & "ALIEN_COLLECTIBLES_DEPLOYABLE_AMMO_TAKING";
  boxConfig.eventString = & "ALIEN_COLLECTIBLES_DEPLOYABLE_AMMO_TAKEN";
  boxConfig.streakName = "deployable_specialammo_comb";
  boxConfig.dpadName = "dpad_placeholder_ammo_2";
  boxConfig.splashName = "used_deployable_ammo";
  boxConfig.shaderName = "compass_objpoint_deploy_ammo_friendly";
  boxConfig.headIconOffset = 25;
  boxConfig.lifeSpan = 90.0;
  boxConfig.useXP = 0;
  boxConfig.voDestroyed = "ballistic_vest_destroyed";
  boxConfig.deployedSfx = "mp_vest_deployed_ui";
  boxConfig.onUseSfx = "ammo_crate_use";
  boxConfig.onUseCallback = ::default_specialammo_onUseDeployable;
  boxConfig.canUseCallback = maps\mp\alien\_deployablebox::default_canUseDeployable;
  boxConfig.useTime = 500;
  boxConfig.maxHealth = 150;
  boxConfig.damageFeedback = "deployable_bag";
  boxConfig.killXP = 0;
  boxConfig.allowMeleeDamage = false;
  boxConfig.allowGrenadeDamage = false;
  boxConfig.maxUses = 3;
  maps\mp\alien\_deployablebox::init_deployable("deployable_specialammo_comb", boxConfig);
}

default_specialammo_onUseDeployable(boxent, track_usage, pillage, ammo_type) {
  self endon("disconnect");

  if(!isDefined(track_usage)) {
    track_usage = true;
  }

  if(track_usage) {
    self thread maps\mp\alien\_persistence::deployablebox_used_track(boxEnt);
    maps\mp\alien\_utility::deployable_box_onuse_message(boxent);
  }

  while(self isChangingWeapon())
    wait(0.05);

  if(!isDefined(ammo_type)) {
    assert(isDefined(boxent), "No boxent or special ammo type specified");
    ammo_type = boxent.boxtype;
  }

  special_ammo = undefined;
  special_ammotype = undefined;
  has_special_ammo = false;

  switch (ammo_type) {
    case "deployable_specialammo_ap":
      if(!isDefined(self.special_ammocount_ap))
        self.special_ammocount_ap = [];
      special_ammotype = "piercing";
      break;

    case "deployable_specialammo_in":
      if(!isDefined(self.special_ammocount_in))
        self.special_ammocount_in = [];

      special_ammotype = "incendiary";
      break;

    case "deployable_specialammo":
      if(!isDefined(self.special_ammocount))
        self.special_ammocount = [];

      special_ammotype = "stun";
      break;

    case "deployable_specialammo_explo":
      if(!isDefined(self.special_ammocount_explo))
        self.special_ammocount_explo = [];

      special_ammotype = "explosive";
      break;
    case "deployable_specialammo_comb":
      if(!isDefined(self.special_ammocount_comb))
        self.special_ammocount_comb = [];

      special_ammotype = "combined";
      break;
  }

  primaryweapons = self GetWeaponsListPrimaries();
  foreach(weapon in primaryweapons) {
    if(!weapon_can_use_specialammo(weapon) && !is_chaos_mode()) {
      continue;
    }
    special_ammocount = self give_special_ammo_by_weaponclass(boxent, weapon, pillage);
    if(special_ammocount == 0) {
      continue;
    }
    special_ammo_weapon = getRawBaseWeaponName(weapon);

    self handle_existing_ammo(special_ammo_weapon, weapon, special_ammotype);

    switch (ammo_type) {
      case "deployable_specialammo_ap":
        if(!isDefined(self.special_ammocount_ap[special_ammo_weapon])) {
          self.special_ammocount_ap[special_ammo_weapon] = 0;
        }

        if(self.special_ammocount_ap[special_ammo_weapon] + special_ammocount > (WeaponMaxAmmo(weapon) + WeaponClipSize(weapon))) {
          self.special_ammocount_ap[special_ammo_weapon] = WeaponMaxAmmo(weapon);
        }
        if(self.special_ammocount_ap[special_ammo_weapon] > 0) {
          has_special_ammo = true;
        }
        self.special_ammocount_ap[special_ammo_weapon] += special_ammocount;
        self SetWeaponAmmoStock(weapon, self.special_ammocount_ap[special_ammo_weapon]);
        break;

      case "deployable_specialammo_in":
        if(!isDefined(self.special_ammocount_in[special_ammo_weapon])) {
          self.special_ammocount_in[special_ammo_weapon] = 0;
        }

        if(self.special_ammocount_in[special_ammo_weapon] + special_ammocount > (WeaponMaxAmmo(weapon) + WeaponClipSize(weapon))) {
          self.special_ammocount_in[special_ammo_weapon] = WeaponMaxAmmo(weapon);
        }
        if(self.special_ammocount_in[special_ammo_weapon] > 0) {
          has_special_ammo = true;
        }
        self.special_ammocount_in[special_ammo_weapon] += special_ammocount;
        self SetWeaponAmmoStock(weapon, self.special_ammocount_in[special_ammo_weapon]);
        break;

      case "deployable_specialammo":
        if(!isDefined(self.special_ammocount[special_ammo_weapon])) {
          self.special_ammocount[special_ammo_weapon] = 0;
        }

        if(self.special_ammocount[special_ammo_weapon] + special_ammocount > (WeaponMaxAmmo(weapon) + WeaponClipSize(weapon))) {
          self.special_ammocount[special_ammo_weapon] = WeaponMaxAmmo(weapon);
        }
        if(self.special_ammocount[special_ammo_weapon] > 0) {
          has_special_ammo = true;
        }
        self.special_ammocount[special_ammo_weapon] += special_ammocount;
        self SetWeaponAmmoStock(weapon, self.special_ammocount[special_ammo_weapon]);
        break;

      case "deployable_specialammo_explo":
        if(!isDefined(self.special_ammocount_explo[special_ammo_weapon])) {
          self.special_ammocount_explo[special_ammo_weapon] = 0;
        }

        if(self.special_ammocount_explo[special_ammo_weapon] + special_ammocount > (WeaponMaxAmmo(weapon) + WeaponClipSize(weapon))) {
          self.special_ammocount_explo[special_ammo_weapon] = WeaponMaxAmmo(weapon);
        }
        if(self.special_ammocount_explo[special_ammo_weapon] > 0) {
          has_special_ammo = true;
        }
        self.special_ammocount_explo[special_ammo_weapon] += special_ammocount;
        self SetWeaponAmmoStock(weapon, self.special_ammocount_explo[special_ammo_weapon]);
        break;

      case "deployable_specialammo_comb":
        if(!isDefined(self.special_ammocount_comb[special_ammo_weapon])) {
          self.special_ammocount_comb[special_ammo_weapon] = 0;
        }

        if(self.special_ammocount_comb[special_ammo_weapon] + special_ammocount > (WeaponMaxAmmo(weapon) + WeaponClipSize(weapon))) {
          self.special_ammocount_comb[special_ammo_weapon] = WeaponMaxAmmo(weapon);
        }
        if(self.special_ammocount_comb[special_ammo_weapon] > 0) {
          has_special_ammo = true;
        }
        self.special_ammocount_comb[special_ammo_weapon] += special_ammocount;
        self SetWeaponAmmoStock(weapon, self.special_ammocount_comb[special_ammo_weapon]);
    }

    if(!has_special_ammo && !is_chaos_mode())
      self zero_out_specialammo_clip(weapon);
  }

  cur_weapon = self GetCurrentPrimaryWeapon();
  if((weapon_can_use_specialammo(cur_weapon) && self give_special_ammo_by_weaponclass(boxent, cur_weapon, pillage) > 0) || is_chaos_mode()) {
    switch (special_ammotype) {
      case "incendiary":
        self.has_incendiary_ammo = true;
        self SetClientOmnvar("ui_alien_specialammo", 2);
        break;

      case "explosive":
        if(!self _hasPerk("specialty_explosivebullets"))
          self givePerk("specialty_explosivebullets", false);

        self SetClientOmnvar("ui_alien_specialammo", 3);
        break;

      case "stun":
        if(!self _hasPerk("specialty_bulletdamage"))
          self givePerk("specialty_bulletdamage", false);

        self SetClientOmnvar("ui_alien_specialammo", 1);
        break;

      case "piercing":
        if(!self _hasPerk("specialty_armorpiercing"))
          self givePerk("specialty_armorpiercing", false);

        self SetClientOmnvar("ui_alien_specialammo", 4);
        break;
      case "combined":
        if(!self _hasPerk("specialty_explosivebullets"))
          self givePerk("specialty_explosivebullets", false);
        if(!self _hasPerk("specialty_bulletdamage"))
          self givePerk("specialty_bulletdamage", false);
        if(!self _hasPerk("specialty_armorpiercing"))
          self givePerk("specialty_armorpiercing", false);
        self.has_incendiary_ammo = true;

        self SetClientOmnvar("ui_alien_specialammo", 5);
        break;
    }
  }

  if(is_chaos_mode()) {
    perk = undefined;
    if(special_ammotype != "incendiary")
      self.has_incendiary_ammo = undefined;
    else if(special_ammotype != "stun")
      perk = "specialty_bulletdamage";
    else if(special_ammotype != "piercing")
      perk = "specialty_armorpiercing";
    else if(special_ammotype != "explosive")
      perk = "specialty_explosivebullets";

    if(isDefined(perk)) {
      if(self _hasPerk(perk))
        self _unsetPerk(perk);
    }
  } else {
    self thread special_ammo_weapon_change_monitor(special_ammotype);
    self thread special_ammo_weapon_fire_monitor(special_ammotype);
  }
}

addRatioMaxStockCombinedToAllWeapons(ratio_of_max) {
  primary_weapons = self GetWeaponsListPrimaries();
  foreach(weapon in primary_weapons) {
    if(is_incompatible_weapon(weapon)) {
      continue;
    }
    if(maps\mp\gametypes\_weapons::isBulletWeapon(weapon)) {
      if(weapon != "iw6_alienminigun_mp" &&
        weapon != "iw6_alienminigun1_mp" &&
        weapon != "iw6_alienminigun2_mp" &&
        weapon != "iw6_alienminigun3_mp" &&
        weapon != "iw6_alienminigun4_mp" &&
        WeaponType(weapon) != "riotshield"
      ) {
        base_weapon = getRawBaseWeaponName(weapon);

        cur_stock = self GetWeaponAmmoStock(weapon);
        max_stock = WeaponMaxAmmo(weapon);
        new_stock = cur_stock + max_stock * ratio_of_max;
        self SetWeaponAmmoStock(weapon, int(min(new_stock, max_stock)));
      }
    }
  }
}

addFullCombinedClipToAllWeapons() {
  primary_weapons = self GetWeaponsListPrimaries();
  foreach(weapon in primary_weapons) {
    if(is_incompatible_weapon(weapon)) {
      continue;
    }
    if(maps\mp\gametypes\_weapons::isBulletWeapon(weapon)) {
      if(weapon != "iw6_alienminigun_mp" &&
        weapon != "iw6_alienminigun1_mp" &&
        weapon != "iw6_alienminigun2_mp" &&
        weapon != "iw6_alienminigun3_mp" &&
        weapon != "iw6_alienminigun4_mp" &&
        WeaponType(weapon) != "riotshield") {
        base_weapon = getRawBaseWeaponName(weapon);

        clip_size = WeaponClipSize(weapon);

        if(is_akimbo_weapon(weapon)) {
          self SetWeaponAmmoClip(weapon, clip_size, "left");
          self SetWeaponAmmoClip(weapon, clip_size, "right");
        } else
          self SetWeaponAmmoClip(weapon, clip_size);
      }
    }
  }
}

weapon_can_use_specialammo(weapon_ref) {
  if(maps\mp\gametypes\_weapons::isBulletWeapon(weapon_ref) && !is_incompatible_weapon(weapon_ref))
    return true;

  return false;
}

onUseDeployable_randombox(boxEnt) {
  self thread maps\mp\alien\_persistence::deployablebox_used_track(boxEnt);

  self giveRandomDeployable(boxent);
}

giveRandomDeployable(boxent) {
  self choose_item_inside_randombox(boxEnt);
}

choose_item_inside_randombox(boxent) {
  dice = [];
  item_weight = 0;
  rank = boxEnt.upgrade_rank;

  foreach(item, data in level.randombox_items) {
    if(rank == 0)
      item_weight = data.level_0_weight;
    else if(rank == 1)
      item_weight = data.level_1_weight;
    else if(rank == 2)
      item_weight = data.level_2_weight;
    else if(rank == 3)
      item_weight = data.level_3_weight;
    else if(rank == 4)
      item_weight = data.level_4_weight;

    for(j = 0; j < item_weight; j++)
      dice[dice.size] = data;
  }

  random_item = dice[RandomIntRange(0, dice.size)];

  self give_randombox_item(random_item, boxent);
}

give_randombox_item(item, boxent) {
  switch (item.ref) {
    case "ammo":
      self give_ammo_item(boxent);
      break;
    case "soflam":
      self give_soflam_item(boxent);
      break;
    case "flare":
      self give_flare_item(boxent);
      break;
    case "leash":
      self give_leash_item(boxent);
      break;
    case "armor":
      self give_armor_item(boxent);
      break;
    case "boost":
      self give_boost_item(boxent);
      break;
    case "explosives":
      self give_explosive_item(boxent);
      break;
    case "trophy":
      self give_trophy_item(boxent);
      break;
    case "feral":
      self give_feral_item(boxent);
      break;
    case "specialammo":
      self give_special_ammo(boxent);
      break;
  }
}

give_ammo_item(boxent) {
  self addAlienWeaponAmmo(boxEnt);
  self setLowerMessage("ammo_message", & "ALIEN_COLLECTIBLES_DEPLOYABLE_AMMO_TAKEN", 3);
}

give_soflam_item(boxent) {
  self _giveWeapon("aliensoflam_mp");
  self setLowerMessage("soflam_messgae", & "ALIEN_COLLECTIBLES_FOUND_SOFLAM", 3);
}

give_flare_item(boxent) {
  if(self hasweapon("alienthrowingknife_mp"))
    self TakeWeapon("alienthrowingknife_mp");

  if(self hasweapon("alientrophy_mp"))
    self takeweapon("alientrophy_mp");

  if(isDefined(level.give_randombox_item_check))
    self[[level.give_randombox_item_check]]("flare");

  self setOffhandSecondaryClass("flash");
  self _giveweapon("alienflare_mp");
  self SetWeaponAmmoClip("alienflare_mp", 1);
  self setLowerMessage("flare_message", & "ALIEN_COLLECTIBLES_FOUND_FLARE", 3);
}

give_leash_item(boxent) {
  self SetOffhandSecondaryClass("throwingknife");
  self _giveWeapon("alienthrowingknife_mp");
  self setLowerMessage("pet_leash_message", & "ALIEN_COLLECTIBLES_FOUND_PET_LEASH", 3);
}

give_armor_item(boxent) {
  if(!self isJuggernaut()) {
    boxEnt.boxType = "deployable_vest";
    self onUseDeployable_vest(boxEnt);
    self setLowerMessage("armor_mesage", & "ALIEN_COLLECTIBLES_DEPLOYED_VEST", 3);
  }
}

give_explosive_item(boxent) {
  boxEnt.boxType = "deployable_explosives";
  self onUseDeployable_explosives(boxent);
  self setLowerMessage("explosives_message", & "ALIEN_COLLECTIBLES_DEPLOYABLE_EXPLOSIVES_TAKEN", 3);
}

give_boost_item(boxent) {
  self onUseDeployable_juicebox(boxent);
  self setLowerMessage("mortar_shell_message", & "ALIEN_COLLECTIBLES_DEPLOYABLE_BOOST_TAKEN", 3);
}

give_feral_item(boxent) {
  self onUseDeployable_adrenaline(boxent);
  self setLowerMessage("feral_message", & "ALIEN_COLLECTIBLES_DEPLOYABLE_ADRENALINE_TAKEN", 3);
}

give_trophy_item(boxent) {
  if(self hasweapon("alienthrowingknife_mp"))
    self TakeWeapon("alienthrowingknife_mp");

  if(self hasweapon("alienflare_mp"))
    self takeweapon("alienflare_mp");

  if(isDefined(level.give_randombox_item_check))
    self[[level.give_randombox_item_check]]("trophy");

  self setOffhandSecondaryClass("flash");
  self giveWeapon("alientrophy_mp", false);
  self SetWeaponAmmoClip("alientrophy_mp", 1);
  self setLowerMessage("trophy_message", & "ALIEN_COLLECTIBLES_FOUND_TROPHY", 3);
}

give_special_ammo(boxent) {
  type = self maps\mp\alien\_utility::get_specialized_ammo_type();

  if(type == "none") {
    type = random(["stun_ammo", "incendiary_ammo", "ap_ammo", "explosive_ammo"]);
  }

  switch (type) {
    case "stun_ammo":
      self default_specialammo_onUseDeployable(boxent, false, false, "deployable_specialammo");
      self setLowerMessage("sp_ammo", & "ALIENS_PATCH_STUN_AMMO_TAKEN", 3);
      break;

    case "incendiary_ammo":
      self default_specialammo_onUseDeployable(boxent, false, false, "deployable_specialammo_in");
      self setLowerMessage("sp_ammo", & "ALIEN_COLLECTIBLES_INCENDIARY_AMMO_TAKEN", 3);
      break;
    case "ap_ammo":
      self default_specialammo_onUseDeployable(boxent, false, false, "deployable_specialammo_ap");
      self setLowerMessage("sp_ammo", & "ALIEN_COLLECTIBLES_AP_AMMO_TAKEN", 3);
      break;

    case "explosive_ammo":
      self default_specialammo_onUseDeployable(boxent, false, false, "deployable_specialammo_explo");
      self setLowerMessage("sp_ammo", & "ALIEN_COLLECTIBLES_EXPLOSIVE_AMMO_TAKEN", 3);
      break;
    case "combined_ammo":
      self default_specialammo_onUseDeployable(boxent, false, false, "deployable_specialammo_comb");
      self setLowerMessage("sp_ammo", & "ALIEN_COLLECTIBLES_DEPLOYABLE_AMMO_TAKEN", 3);
      break;

  }
}

randombox_table_init(index_start, index_end) {
  for(i = index_start; i < index_end; i++) {
    randombox = spawnStruct();
    randombox.ref = TableLookup(level.randombox_table, TABLE_ITEM_INDEX, i, TABLE_ITEM_REF);
    if(randombox.ref == "") {
      break;
    }
    randombox.level_0_weight = int(TableLookup(level.randombox_table, TABLE_ITEM_INDEX, i, TABLE_ITEM_LEVEL_0_WEIGHT));
    randombox.level_1_weight = int(TableLookup(level.randombox_table, TABLE_ITEM_INDEX, i, TABLE_ITEM_LEVEL_1_WEIGHT));
    randombox.level_2_weight = int(TableLookup(level.randombox_table, TABLE_ITEM_INDEX, i, TABLE_ITEM_LEVEL_2_WEIGHT));
    randombox.level_3_weight = int(TableLookup(level.randombox_table, TABLE_ITEM_INDEX, i, TABLE_ITEM_LEVEL_3_WEIGHT));
    randombox.level_4_weight = int(TableLookup(level.randombox_table, TABLE_ITEM_INDEX, i, TABLE_ITEM_LEVEL_4_WEIGHT));

    level.randombox_items[randombox.ref] = randombox;
  }
}

onUseDeployable_currency(boxEnt) {
  maps\mp\alien\_deployablebox::default_OnUseDeployable(boxent);

  self giveCurrency(boxent);
}

giveCurrency(boxent) {
  if(isDefined(boxEnt.upgrade_rank) && boxEnt.upgrade_rank == 0) {
    self maps\mp\alien\_persistence::give_player_currency(level.deployable_currency_ranks[0]);
  }
  if(isDefined(boxEnt.upgrade_rank) && boxEnt.upgrade_rank == 1) {
    self maps\mp\alien\_persistence::give_player_currency(level.deployable_currency_ranks[1]);
  }
  if(isDefined(boxEnt.upgrade_rank) && boxEnt.upgrade_rank == 2) {
    self maps\mp\alien\_persistence::give_player_currency(level.deployable_currency_ranks[2]);
  }
  if(isDefined(boxEnt.upgrade_rank) && boxEnt.upgrade_rank == 3) {
    self maps\mp\alien\_persistence::give_player_currency(level.deployable_currency_ranks[3]);
  }
  if(isDefined(boxEnt.upgrade_rank) && boxEnt.upgrade_rank == 4) {
    self maps\mp\alien\_persistence::give_player_currency(level.deployable_currency_ranks[4]);
  }
}

onUseDeployable_adrenaline(boxEnt) {
  self thread maps\mp\alien\_persistence::deployablebox_used_track(boxEnt);

  assert(isDefined(boxEnt.upgrade_rank), "No rank specified for deployable adrenalinebox");

  if(isDefined(level.custom_adrenalinebox_logic)) {
    self thread[[level.custom_adrenalinebox_logic]](level.deployablebox_adrenalinebox_rank[boxEnt.upgrade_rank], boxEnt.upgrade_rank);

  }
}

custom_adrenalinebox_logic(adrenalinetime, rank) {
  self endon("death");
  self endon("faux_spawn");
  self endon("disconnect");

  self endon("unset_adrenaline");
  level endon("game_ended");

  if(isDefined(self.adrenalinetime)) {
    self.adrenalinetime += adrenalinetime;
  } else {
    self.adrenalinetime = adrenalinetime;
  }

  if(isDefined(self.adrenalinetime) && self.adrenalinetime > level.deployablebox_adrenalinebox_max) {
    self.adrenalinetime = level.deployablebox_adrenalinebox_max;
  }

  if(isDefined(self.isFeral) && self.isFeral) {
    return;
  }

  self.isFeral = true;

  self.moveSpeedScaler = 1.1;
  self givePerk("specialty_selectivehearing", false);

  self maps\mp\alien\_utility::restore_client_fog(0);
  self playlocalsound("alien_feral_instinct_bed");
  self thread maps\mp\alien\_outline_proto::set_alien_outline();

  self thread unsetAdrenalineOnDeath();

  endTime = (adrenalinetime * 1000) + GetTime();

  if(rank == 1) {
    self.moveSpeedScaler = 1.2;
  }

  if(rank == 2) {
    self.moveSpeedScaler = 1.2;
    self activateRegenFaster();
  }

  if(rank == 3) {
    self.moveSpeedScaler = 1.2;
    self activateRegenFaster();
  }

  if(rank == 4) {
    self givePerk("specialty_longersprint", false);
    self activateRegenFaster();
    self.moveSpeedScaler = 1.2;
  }

  maps\mp\alien\_perkfunctions::updateCombatSpeedScalar();

  while(isDefined(self.adrenalinetime)) {
    wait(1);
    self.adrenalinetime--;
    if(self.adrenalinetime < 0) {
      self.adrenalinetime = undefined;
      self SetClientDvar("ui_juiced_end_milliseconds", 0);
      break;
    }

    endTime = (self.adrenalinetime * 1000) + GetTime();
  }

  custom_unset_adrenaline();
}

activateRegenFaster() {
  self.regenSpeed = level.regenHealthMod;
  self.isHealthBoosted = true;
}

unsetAdrenalineOnDeath() {
  self endon("disconnect");
  self endon("unset_adrenaline");

  self waittill_any("death", "faux_spawn", "last_stand");

  self thread custom_unset_adrenaline(true);
}

custom_unset_adrenaline(death) {
  self _unsetperk("specialty_longersprint");
  self _unsetperk("specialty_selectivehearing");
  self.isHealthBoosted = undefined;

  self.regenSpeed = 1;

  if(self has_perk("perk_medic")) {
    self.moveSpeedScaler = self perk_GetMoveSpeedScalar();
    if(self has_perk("perk_medic", [2, 3, 4]))
      self givePerk("specialty_longersprint", false);
  } else {
    self.moveSpeedScaler = self maps\mp\alien\_prestige::prestige_getMoveSlowScalar();
  }

  self maps\mp\gametypes\_weapons::updateMoveSpeedScale();

  if(!is_true(level.easter_egg_lodge_sign_active))
    self thread maps\mp\alien\_outline_proto::unset_alien_outline();

  self maps\mp\alien\_utility::restore_client_fog(0);
  self.isFeral = undefined;
  if(!is_true(level.easter_egg_lodge_sign_active))
    self notify("unset_adrenaline");
}

onUseDeployable_juicebox(boxEnt) {
  self thread maps\mp\alien\_persistence::deployablebox_used_track(boxEnt);

  assert(isDefined(boxEnt.upgrade_rank), "No rank specified for deployable juicebox");

  if(isDefined(level.custom_juicebox_logic)) {
    self thread[[level.custom_juicebox_logic]](level.deployablebox_juicebox_rank[boxEnt.upgrade_rank], boxEnt.upgrade_rank);

  }
}

custom_juicebox_logic(juicetime, rank, isEasterEgg) {
  self endon("death");
  self endon("faux_spawn");
  self endon("disconnect");

  self endon("unset_juiced");
  level endon("game_ended");

  if(isDefined(self.juicetime)) {
    self.juicetime += juicetime;
  } else {
    self.juicetime = juicetime;
  }

  if(isDefined(self.juicetime) && self.juicetime > level.deployablebox_juicebox_max) {
    self.juicetime = level.deployablebox_juicebox_max;
  }

  if(is_true(isEasterEgg)) {
    self.juicetime = juicetime;
  }

  if(isDefined(self.isJuiced) && self.isJuiced) {
    return;
  }

  self.isJuiced = true;

  self givePerk("specialty_fastreload", false);

  self givePerk("specialty_quickdraw", false);

  self givePerk("specialty_stalker", false);

  self givePerk("specialty_fastoffhand", false);

  self givePerk("specialty_fastsprintrecovery", false);

  self givePerk("specialty_quickswap", false);

  self givePerk("specialty_fastermelee", false);

  if(rank == 2 || rank == 3 || rank == 4)
    self.drillSpeedModifier = 0.75;
  else
    self.drillSpeedModifier = 1.0;

  self thread unsetJuiceBoxOnDeath();

  endTime = (juicetime * 1000) + GetTime();
  if(!IsAI(self)) {
    self SetClientDvar("ui_juiced_end_milliseconds", endTime);
  }

  while(isDefined(self.juicetime)) {
    wait(1);
    self.juicetime--;
    if(self.juicetime < 0) {
      self.juicetime = undefined;
      self SetClientDvar("ui_juiced_end_milliseconds", 0);
      break;
    }

    endTime = (self.juicetime * 1000) + GetTime();

    self SetClientDvar("ui_juiced_end_milliseconds", endTime);

  }

  custom_unset_juicebox();
}

unsetJuiceBoxOnDeath() {
  self endon("disconnect");
  self endon("unset_juiced");

  self waittill_any("death", "faux_spawn", "last_stand");

  self thread custom_unset_juicebox(true);
}

custom_unset_juicebox(death) {
  class_level = maps\mp\alien\_persistence::get_perk_0_level();

  if(self isJuggernaut()) {
    Assert(isDefined(self.juggMoveSpeedScaler));
    if(isDefined(self.juggMoveSpeedScaler))
      self.moveSpeedScaler = self.juggMoveSpeedScaler;
    else
      self.moveSpeedScaler = 0.7;
  }

  if(self has_perk("perk_medic", [2, 3, 4]))
    self givePerk("specialty_longersprint", false);

  self _unsetPerk("specialty_fastreload");

  self.drillSpeedModifier = 1.0;

  self _unsetPerk("specialty_quickdraw");

  self _unsetPerk("specialty_stalker");

  self _unsetPerk("specialty_fastoffhand");

  self _unsetPerk("specialty_fastsprintrecovery");

  self _unsetPerk("specialty_quickswap");

  self _unsetPerk("specialty_fastermelee");

  if(maps\mp\alien\_perk_utility::has_perk("perk_bullet_damage")) {
    switch (class_level) {
      case 0:
        self maps\mp\alien\_perkfunctions::set_perk_bullet_damage_0();
        break;
      case 1:
        self maps\mp\alien\_perkfunctions::set_perk_bullet_damage_1();
        break;
      case 2:
        self maps\mp\alien\_perkfunctions::set_perk_bullet_damage_2();
        break;
      case 3:
        self maps\mp\alien\_perkfunctions::set_perk_bullet_damage_3();
        break;
      case 4:
        self maps\mp\alien\_perkfunctions::set_perk_bullet_damage_4();
        break;
    }
  }

  self.isJuiced = undefined;
  if(!IsAI(self)) {
    self SetClientDvar("ui_juiced_end_milliseconds", 0);
  }

  self notify("unset_juiced");
}

onUseDeployable_ammo(boxEnt) {
  maps\mp\alien\_deployablebox::default_OnUseDeployable(boxent);
  self addAlienWeaponAmmo(boxEnt);
}

addRatioMaxStockToAllWeapons(ratio_of_max) {
  primary_weapons = self GetWeaponsListPrimaries();
  foreach(weapon in primary_weapons) {
    if(is_incompatible_weapon(weapon)) {
      continue;
    }
    if(maps\mp\gametypes\_weapons::isBulletWeapon(weapon)) {
      if(weapon != "iw6_alienminigun_mp" &&
        weapon != "iw6_alienminigun1_mp" &&
        weapon != "iw6_alienminigun2_mp" &&
        weapon != "iw6_alienminigun3_mp" &&
        weapon != "iw6_alienminigun4_mp" &&
        WeaponType(weapon) != "riotshield"
      ) {
        base_weapon = getRawBaseWeaponName(weapon);
        if(self player_has_specialized_ammo(base_weapon)) {
          if(isDefined(self.stored_ammo[base_weapon])) {
            if(self.stored_ammo[base_weapon].ammoStock < WeaponMaxAmmo(weapon)) {
              max_stock = WeaponMaxAmmo(weapon);
              new_stock = self.stored_ammo[base_weapon].ammoStock + max_stock * ratio_of_max;
              self.stored_ammo[base_weapon].ammoStock = int(floor(new_stock));
            }
          }

        } else {
          cur_stock = self GetWeaponAmmoStock(weapon);
          max_stock = WeaponMaxAmmo(weapon);
          new_stock = cur_stock + max_stock * ratio_of_max;
          self SetWeaponAmmoStock(weapon, int(min(new_stock, max_stock)));
        }
      }
    }
  }
}

addFullClipToAllWeapons(ammo_scalar) {
  primary_weapons = self GetWeaponsListPrimaries();
  foreach(weapon in primary_weapons) {
    if(is_incompatible_weapon(weapon)) {
      continue;
    }
    if(maps\mp\gametypes\_weapons::isBulletWeapon(weapon)) {
      if(weapon != "iw6_alienminigun_mp" &&
        weapon != "iw6_alienminigun1_mp" &&
        weapon != "iw6_alienminigun2_mp" &&
        weapon != "iw6_alienminigun3_mp" &&
        weapon != "iw6_alienminigun4_mp" &&
        WeaponType(weapon) != "riotshield") {
        base_weapon = getRawBaseWeaponName(weapon);
        if(self player_has_specialized_ammo(base_weapon))
          continue;
        else {
          clip_size = WeaponClipSize(weapon);
          if(isDefined(ammo_scalar))
            clip_size = int(self GetWeaponAmmoClip(weapon) + (clip_size * ammo_scalar));

          if(is_akimbo_weapon(weapon)) {
            left_clip = clip_size;
            right_clip = clip_size;
            if(isDefined(ammo_scalar)) {
              left_clip = int(self GetWeaponAmmoClip(weapon, "left") + (clip_size * ammo_scalar));
              right_clip = int(self GetWeaponAmmoClip(weapon, "right") + (clip_size * ammo_scalar));
            }
            self SetWeaponAmmoClip(weapon, left_clip, "left");
            self SetWeaponAmmoClip(weapon, right_clip, "right");
          } else
            self SetWeaponAmmoClip(weapon, clip_size);
        }
      }
    }
  }
}

addAlienWeaponAmmo(boxEnt) {
  primary_weapons = self GetWeaponsListPrimaries();

  assert(isDefined(boxEnt.upgrade_rank));

  nerf_min_ammo_scalar = self check_for_nerf_min_ammo();
  if(nerf_min_ammo_scalar != 1.0) {
    self addRatioMaxStockToAllWeapons(nerf_min_ammo_scalar);
    if(boxEnt.upgrade_rank == 3 || boxEnt.upgrade_rank == 4) {
      self addFullClipToAllWeapons(nerf_min_ammo_scalar);
    }
    return;
  }

  switch (boxEnt.upgrade_rank) {
    case 0:
      self addRatioMaxStockToAllWeapons(.4);
      break;
    case 1:
      self addRatioMaxStockToAllWeapons(.7);
      break;
    case 2:
      self addRatioMaxStockToAllWeapons(1.0);
      break;
    case 3:
      self addRatioMaxStockToAllWeapons(1.0);
      self addFullClipToAllWeapons();
      break;
    case 4:
      self addRatioMaxStockToAllWeapons(1.0);
      self addFullClipToAllWeapons();
      break;
  }
}

check_for_nerf_min_ammo() {
  return self maps\mp\alien\_prestige::prestige_getMinAmmo();
}

onUseDeployable_vest(boxEnt) {
  maps\mp\alien\_deployablebox::default_OnUseDeployable(boxent);
  existing_armor = 0;
  if(isDefined(self.bodyArmorHP)) {
    existing_armor = self.bodyArmorHP;
  }

  assertex(isDefined(boxEnt.upgrade_rank), "No upgrade rank defined for deployable armor");

  armor_to_give = get_adjusted_armor(existing_armor, boxEnt.upgrade_rank);
  self maps\mp\alien\_damage::setBodyArmor(armor_to_give);

  self notify("enable_armor");
}

get_adjusted_armor(existing_armor, rank) {
  if(existing_armor + level.deployablebox_vest_rank[rank] > level.deployablebox_vest_max) {
    return level.deployablebox_vest_max;
  }

  return existing_armor + level.deployablebox_vest_rank[rank];
}

onUseDeployable_explosives(boxEnt) {
  maps\mp\alien\_deployablebox::default_OnUseDeployable(boxent);

  self fillTeamExplosives(boxent);
}
fillTeamExplosives(boxent) {
  if(isDefined(boxEnt.upgrade_rank) && boxEnt.upgrade_rank == 0) {
    self SetOffhandPrimaryClass("other");
    self fillOffhandWeapons("aliensemtex_mp", 2);
    self fillLaunchers(boxent, 4);
  }
  if(isDefined(boxEnt.upgrade_rank) && boxEnt.upgrade_rank == 1) {
    self SetOffhandPrimaryClass("other");
    self fillOffhandWeapons("alienmortar_shell_mp", 2);
    self fillLaunchers(boxent, 6);
  }
  if(isDefined(boxEnt.upgrade_rank) && boxEnt.upgrade_rank == 2) {
    self SetOffhandPrimaryClass("other");
    self fillOffhandWeapons("alienbetty_mp", 2);
    self fillLaunchers(boxent, 8);
  }
  if(isDefined(boxEnt.upgrade_rank) && boxEnt.upgrade_rank == 3) {
    self SetOffhandPrimaryClass("other");
    self fillOffhandWeapons("alienclaymore_mp", 4);
    self fillLaunchers(boxent, 10);
  }
  if(isDefined(boxEnt.upgrade_rank) && boxEnt.upgrade_rank == 4) {
    self SetOffhandPrimaryClass("other");
    self fillOffhandWeapons("alienbetty_mp", 5);
    self fillLaunchers(boxent, 12);
  }
}

fillOffhandWeapons(offhand_type, additional_ammo) {
  offhandweapons = self GetWeaponsListOffhands();
  added_ammo = false;
  cur_offhand = undefined;
  current_ammo = 0;
  foreach(offhandweapon in offhandweapons) {
    if(offhandweapon != offhand_type) {
      if(offhandweapon != "none" && offhandweapon != "alienthrowingknife_mp" && offhandweapon != "alienflare_mp" && offhandweapon != "alientrophy_mp" && offhandweapon != "iw6_aliendlc21_mp") {
        self takeweapon(offhandweapon);
      }
      continue;
    }
    if(isDefined(offhandweapon) && offhandweapon != "none") {
      current_ammo = self GetAmmoCount(offhandweapon);
      self SetWeaponAmmoStock(offhandweapon, (current_ammo + additional_ammo));
      added_ammo = true;
      break;
    }
  }
  if(added_ammo == false) {
    self _giveWeapon(offhand_type);
    self SetWeaponAmmoStock(offhand_type, additional_ammo);
  }
}

fillLaunchers(boxent, extra_ammo) {
  weaponList = self GetWeaponsListAll();

  if(isDefined(weaponList)) {
    foreach(weaponName in weaponList) {
      if(is_incompatible_weapon(weaponName)) {
        continue;
      }
      weapClass = weaponClass(weaponName);
      weapType = weaponInventoryType(weaponName);
      if(weaponName != "iw6_alienmk32_mp" &&
        weaponName != "iw6_alienmk321_mp" &&
        weaponName != "iw6_alienmk322_mp" &&
        weaponName != "iw6_alienmk323_mp" &&
        weaponName != "iw6_alienmk324_mp" &&
        weaponName != "aliensoflam_mp"
      ) {
        if(weapClass == "rocketlauncher" || weapClass == "grenade") {
          if(weapType == "primary" || weapType == "altmode") {
            clipSize = WeaponClipSize(weaponName);
            nerf_min_ammo_scalar = self check_for_nerf_min_ammo();
            extra_ammo = int(extra_ammo * nerf_min_ammo_scalar);
            curStock = self GetWeaponAmmoStock(weaponName);
            newStock = curStock + extra_ammo;
            maxAmmo = WeaponMaxAmmo(weaponName);
            if(newStock > maxAmmo)
              newStock = maxAmmo;
            self SetWeaponAmmoStock(weaponName, newStock);
          }
        }
      }
    }
  }
}