/***********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\alien\_combat_resources.gsc
***********************************************/

#include common_scripts\utility;
#include maps\mp\_utility;
#include maps\mp\agents\_agent_utility;
#include maps\mp\alien\_utility;
#include maps\mp\alien\_persistence;
#include maps\mp\killstreaks\_ball_drone;

WAVE_TABLE = "mp/alien/dpad_tree.csv";

TABLE_INDEX = 0;
TABLE_REF = 1;
TABLE_UNLOCK = 2;
TABLE_POINT_COST = 3;
TABLE_COST = 4;
TABLE_NAME = 5;
TABLE_DESC = 6;
TABLE_ICON = 7;
TABLE_DPAD_ICON = 8;
TABLE_IS_UPGRADE = 9;

TABLE_DPAD_MAX_INDEX = 99;

init_combat_resources() {
  if(!isDefined(level.alien_combat_resources_table))
    level.alien_combat_resources_table = WAVE_TABLE;

  init_combat_resource_callback();

  init_combat_resource_overrides();

  init_combat_resource_from_table();

  init_sentry_function_pointers();
  init_ims_upgrade_function_pointers();
  init_ball_drone_upgrade_function_pointers();
}

init_sentry_function_pointers() {
  level.createsentryforplayer_func = maps\mp\alien\_autosentry_alien::createSentryForPlayer;
  level.sentry_setcarried_func = maps\mp\alien\_autosentry_alien::sentry_setCarried;
  level.sentry_setplaced_func = maps\mp\alien\_autosentry_alien::sentry_setPlaced;
  level.sentry_setCancelled_func = maps\mp\alien\_autosentry_alien::sentry_setCancelled;
}

init_combat_resource_callback() {
  level.alien_combat_resource_callbacks = [];

  level.alien_combat_resource_callbacks["dpad_team_ammo_reg"] = spawnStruct();
  level.alien_combat_resource_callbacks["dpad_team_ammo_reg"].CanUse = ::default_canUse;
  level.alien_combat_resource_callbacks["dpad_team_ammo_reg"].CanPurchase = ::alt_canPurchase;
  level.alien_combat_resource_callbacks["dpad_team_ammo_reg"].TryUse = ::TryUse_dpad_team_ammo;
  level.alien_combat_resource_callbacks["dpad_team_ammo_reg"].Use = ::Use_dpad_team_ammo;
  level.alien_combat_resource_callbacks["dpad_team_ammo_reg"].CancelUse = ::CancelUse_default_deployable_box;

  level.alien_combat_resource_callbacks["dpad_team_armor"] = spawnStruct();
  level.alien_combat_resource_callbacks["dpad_team_armor"].CanUse = ::default_canUse;
  level.alien_combat_resource_callbacks["dpad_team_armor"].CanPurchase = ::alt_canPurchase;
  level.alien_combat_resource_callbacks["dpad_team_armor"].TryUse = ::TryUse_dpad_team_armor;
  level.alien_combat_resource_callbacks["dpad_team_armor"].Use = ::Use_dpad_team_armor;
  level.alien_combat_resource_callbacks["dpad_team_armor"].CancelUse = ::CancelUse_default_deployable_box;

  level.alien_combat_resource_callbacks["dpad_team_explosives"] = spawnStruct();
  level.alien_combat_resource_callbacks["dpad_team_explosives"].CanUse = ::default_canUse;
  level.alien_combat_resource_callbacks["dpad_team_explosives"].CanPurchase = ::alt_canPurchase;
  level.alien_combat_resource_callbacks["dpad_team_explosives"].TryUse = ::TryUse_dpad_team_explosives;
  level.alien_combat_resource_callbacks["dpad_team_explosives"].Use = ::Use_dpad_team_explosives;
  level.alien_combat_resource_callbacks["dpad_team_explosives"].CancelUse = ::CancelUse_default_deployable_box;

  level.alien_combat_resource_callbacks["dpad_team_randombox"] = spawnStruct();
  level.alien_combat_resource_callbacks["dpad_team_randombox"].CanUse = ::default_canUse;
  level.alien_combat_resource_callbacks["dpad_team_randombox"].CanPurchase = ::alt_canPurchase;
  level.alien_combat_resource_callbacks["dpad_team_randombox"].TryUse = ::TryUse_dpad_team_randombox;
  level.alien_combat_resource_callbacks["dpad_team_randombox"].Use = ::Use_dpad_team_randombox;
  level.alien_combat_resource_callbacks["dpad_team_randombox"].CancelUse = ::CancelUse_default_deployable_box;

  level.alien_combat_resource_callbacks["dpad_team_boost"] = spawnStruct();
  level.alien_combat_resource_callbacks["dpad_team_boost"].CanUse = ::default_canUse;
  level.alien_combat_resource_callbacks["dpad_team_boost"].CanPurchase = ::alt_canPurchase;
  level.alien_combat_resource_callbacks["dpad_team_boost"].TryUse = ::TryUse_dpad_team_boost;
  level.alien_combat_resource_callbacks["dpad_team_boost"].Use = ::Use_dpad_team_boost;
  level.alien_combat_resource_callbacks["dpad_team_boost"].CancelUse = ::CancelUse_default_deployable_box;

  level.alien_combat_resource_callbacks["dpad_team_adrenaline"] = spawnStruct();
  level.alien_combat_resource_callbacks["dpad_team_adrenaline"].CanUse = ::default_canUse;
  level.alien_combat_resource_callbacks["dpad_team_adrenaline"].CanPurchase = ::alt_canPurchase;
  level.alien_combat_resource_callbacks["dpad_team_adrenaline"].TryUse = ::TryUse_dpad_team_adrenaline;
  level.alien_combat_resource_callbacks["dpad_team_adrenaline"].Use = ::Use_dpad_team_adrenaline;
  level.alien_combat_resource_callbacks["dpad_team_adrenaline"].CancelUse = ::CancelUse_default_deployable_box;

  level.alien_combat_resource_callbacks["dpad_ims"] = spawnStruct();
  level.alien_combat_resource_callbacks["dpad_ims"].CanUse = ::alt_canUse;
  level.alien_combat_resource_callbacks["dpad_ims"].CanPurchase = ::CanPurchase_dpad_ims;
  level.alien_combat_resource_callbacks["dpad_ims"].TryUse = ::TryUse_dpad_ims;
  level.alien_combat_resource_callbacks["dpad_ims"].Use = ::Use_dpad_ims;
  level.alien_combat_resource_callbacks["dpad_ims"].CancelUse = ::CancelUse_dpad_ims;

  level.alien_combat_resource_callbacks["dpad_sentry"] = spawnStruct();
  level.alien_combat_resource_callbacks["dpad_sentry"].CanUse = ::alt_canUse;
  level.alien_combat_resource_callbacks["dpad_sentry"].CanPurchase = ::CanPurchase_dpad_sentry;
  level.alien_combat_resource_callbacks["dpad_sentry"].TryUse = ::TryUse_dpad_sentry;
  level.alien_combat_resource_callbacks["dpad_sentry"].Use = ::Use_dpad_sentry;
  level.alien_combat_resource_callbacks["dpad_sentry"].CancelUse = ::CancelUse_dpad_sentry;

  level.alien_combat_resource_callbacks["dpad_gl_sentry"] = spawnStruct();
  level.alien_combat_resource_callbacks["dpad_gl_sentry"].CanUse = ::alt_canUse;
  level.alien_combat_resource_callbacks["dpad_gl_sentry"].CanPurchase = ::CanPurchase_dpad_glsentry;
  level.alien_combat_resource_callbacks["dpad_gl_sentry"].TryUse = ::TryUse_dpad_glsentry;
  level.alien_combat_resource_callbacks["dpad_gl_sentry"].Use = ::Use_dpad_glsentry;
  level.alien_combat_resource_callbacks["dpad_gl_sentry"].CancelUse = ::CancelUse_dpad_glsentry;

  level.alien_combat_resource_callbacks["dpad_minigun_turret"] = spawnStruct();
  level.alien_combat_resource_callbacks["dpad_minigun_turret"].CanUse = ::alt_canUse;
  level.alien_combat_resource_callbacks["dpad_minigun_turret"].CanPurchase = ::CanPurchase_dpad_minigun_turret;
  level.alien_combat_resource_callbacks["dpad_minigun_turret"].TryUse = ::TryUse_dpad_minigun_turret;
  level.alien_combat_resource_callbacks["dpad_minigun_turret"].Use = ::Use_dpad_minigun_turret;
  level.alien_combat_resource_callbacks["dpad_minigun_turret"].CancelUse = ::CancelUse_dpad_minigun_turret;

  level.alien_combat_resource_callbacks["dpad_backup_buddy"] = spawnStruct();
  level.alien_combat_resource_callbacks["dpad_backup_buddy"].CanUse = ::alt_canUse;
  level.alien_combat_resource_callbacks["dpad_backup_buddy"].CanPurchase = ::CanPurchase_dpad_backup_buddy;
  level.alien_combat_resource_callbacks["dpad_backup_buddy"].TryUse = ::TryUse_dpad_backup_buddy;
  level.alien_combat_resource_callbacks["dpad_backup_buddy"].Use = ::Use_dpad_backup_buddy;
  level.alien_combat_resource_callbacks["dpad_backup_buddy"].CancelUse = ::CancelUse_dpad_backup_buddy;

  level.alien_combat_resource_callbacks["dpad_mortar"] = spawnStruct();
  level.alien_combat_resource_callbacks["dpad_mortar"].CanUse = ::alt_canUse;
  level.alien_combat_resource_callbacks["dpad_mortar"].CanPurchase = ::default_canPurchase;
  level.alien_combat_resource_callbacks["dpad_mortar"].TryUse = ::TryUse_dpad_airstrike;
  level.alien_combat_resource_callbacks["dpad_mortar"].Use = ::Use_dpad_airstrike;
  level.alien_combat_resource_callbacks["dpad_mortar"].CancelUse = ::CancelUse_dpad_airstrike;

  level.alien_combat_resource_callbacks["dpad_war_machine"] = spawnStruct();
  level.alien_combat_resource_callbacks["dpad_war_machine"].CanUse = ::alt_canUse;
  level.alien_combat_resource_callbacks["dpad_war_machine"].CanPurchase = ::alt_canPurchase;
  level.alien_combat_resource_callbacks["dpad_war_machine"].TryUse = ::TryUse_dpad_war_machine;
  level.alien_combat_resource_callbacks["dpad_war_machine"].Use = ::Use_dpad_war_machine;
  level.alien_combat_resource_callbacks["dpad_war_machine"].CancelUse = ::CancelUse_dpad_war_machine;

  level.alien_combat_resource_callbacks["dpad_death_machine"] = spawnStruct();
  level.alien_combat_resource_callbacks["dpad_death_machine"].CanUse = ::alt_canUse;
  level.alien_combat_resource_callbacks["dpad_death_machine"].CanPurchase = ::alt_canPurchase;
  level.alien_combat_resource_callbacks["dpad_death_machine"].TryUse = ::TryUse_dpad_death_machine;
  level.alien_combat_resource_callbacks["dpad_death_machine"].Use = ::Use_dpad_death_machine;
  level.alien_combat_resource_callbacks["dpad_death_machine"].CancelUse = ::CancelUse_dpad_death_machine;

  level.alien_combat_resource_callbacks["dpad_predator"] = spawnStruct();
  level.alien_combat_resource_callbacks["dpad_predator"].CanUse = ::alt_canUse;
  level.alien_combat_resource_callbacks["dpad_predator"].CanPurchase = ::default_canPurchase;
  level.alien_combat_resource_callbacks["dpad_predator"].TryUse = ::TryUse_dpad_predator;
  level.alien_combat_resource_callbacks["dpad_predator"].Use = ::Use_dpad_predator;
  level.alien_combat_resource_callbacks["dpad_predator"].CancelUse = ::CancelUse_dpad_predator;

  level.alien_combat_resource_callbacks["dpad_riotshield"] = spawnStruct();
  level.alien_combat_resource_callbacks["dpad_riotshield"].CanUse = ::alt_canUse;
  level.alien_combat_resource_callbacks["dpad_riotshield"].CanPurchase = ::CanPurchase_dpad_riotshield;
  level.alien_combat_resource_callbacks["dpad_riotshield"].TryUse = ::TryUse_dpad_riotshield;
  level.alien_combat_resource_callbacks["dpad_riotshield"].Use = ::Use_dpad_riotshield;
  level.alien_combat_resource_callbacks["dpad_riotshield"].CancelUse = ::CancelUse_dpad_riotshield;

  level.alien_combat_resource_callbacks["dpad_team_ammo_stun"] = spawnStruct();
  level.alien_combat_resource_callbacks["dpad_team_ammo_stun"].CanUse = ::default_canUse;
  level.alien_combat_resource_callbacks["dpad_team_ammo_stun"].CanPurchase = ::alt_canPurchase;
  level.alien_combat_resource_callbacks["dpad_team_ammo_stun"].TryUse = ::TryUse_dpad_team_specialammo;
  level.alien_combat_resource_callbacks["dpad_team_ammo_stun"].Use = ::Use_dpad_team_specialammo;
  level.alien_combat_resource_callbacks["dpad_team_ammo_stun"].CancelUse = ::CancelUse_default_deployable_box;

  level.alien_combat_resource_callbacks["dpad_team_ammo_explo"] = spawnStruct();
  level.alien_combat_resource_callbacks["dpad_team_ammo_explo"].CanUse = ::default_canUse;
  level.alien_combat_resource_callbacks["dpad_team_ammo_explo"].CanPurchase = ::alt_canPurchase;
  level.alien_combat_resource_callbacks["dpad_team_ammo_explo"].TryUse = ::TryUse_dpad_team_specialammo_explo;
  level.alien_combat_resource_callbacks["dpad_team_ammo_explo"].Use = ::Use_dpad_team_specialammo_explo;
  level.alien_combat_resource_callbacks["dpad_team_ammo_explo"].CancelUse = ::CancelUse_default_deployable_box;

  level.alien_combat_resource_callbacks["dpad_team_ammo_ap"] = spawnStruct();
  level.alien_combat_resource_callbacks["dpad_team_ammo_ap"].CanUse = ::default_canUse;
  level.alien_combat_resource_callbacks["dpad_team_ammo_ap"].CanPurchase = ::alt_canPurchase;
  level.alien_combat_resource_callbacks["dpad_team_ammo_ap"].TryUse = ::TryUse_dpad_team_specialammo_ap;
  level.alien_combat_resource_callbacks["dpad_team_ammo_ap"].Use = ::Use_dpad_team_specialammo;
  level.alien_combat_resource_callbacks["dpad_team_ammo_ap"].CancelUse = ::CancelUse_default_deployable_box;

  level.alien_combat_resource_callbacks["dpad_team_ammo_in"] = spawnStruct();
  level.alien_combat_resource_callbacks["dpad_team_ammo_in"].CanUse = ::default_canUse;
  level.alien_combat_resource_callbacks["dpad_team_ammo_in"].CanPurchase = ::alt_canPurchase;
  level.alien_combat_resource_callbacks["dpad_team_ammo_in"].TryUse = ::TryUse_dpad_team_specialammo_in;
  level.alien_combat_resource_callbacks["dpad_team_ammo_in"].Use = ::Use_dpad_team_specialammo_in;
  level.alien_combat_resource_callbacks["dpad_team_ammo_in"].CancelUse = ::CancelUse_default_deployable_box;

  level.alien_combat_resource_callbacks["dpad_team_currency"] = spawnStruct();
  level.alien_combat_resource_callbacks["dpad_team_currency"].CanUse = ::default_canUse;
  level.alien_combat_resource_callbacks["dpad_team_currency"].CanPurchase = ::alt_canPurchase;
  level.alien_combat_resource_callbacks["dpad_team_currency"].TryUse = ::TryUse_dpad_team_currency;
  level.alien_combat_resource_callbacks["dpad_team_currency"].Use = ::Use_dpad_team_currency;
  level.alien_combat_resource_callbacks["dpad_team_currency"].CancelUse = ::CancelUse_default_deployable_box;

  level.alien_combat_resource_callbacks["dpad_placeholder_ammo_2"] = spawnStruct();
  level.alien_combat_resource_callbacks["dpad_placeholder_ammo_2"].CanUse = ::default_canUse;
  level.alien_combat_resource_callbacks["dpad_placeholder_ammo_2"].CanPurchase = ::alt_canPurchase;
  level.alien_combat_resource_callbacks["dpad_placeholder_ammo_2"].TryUse = ::TryUse_dpad_team_specialammo_comb;
  level.alien_combat_resource_callbacks["dpad_placeholder_ammo_2"].Use = ::Use_dpad_team_specialammo_comb;
  level.alien_combat_resource_callbacks["dpad_placeholder_ammo_2"].CancelUse = ::CancelUse_default_deployable_box;

  level.mortar_fx["tracer"] = loadFx("fx/misc/tracer_incoming");
  level.mortar_fx["explosion"] = loadFx("vfx/gameplay/alien/vfx_alien_mortar_explosion");

  level._effect["stun_attack"] = loadfx("vfx/gameplay/alien/vfx_alien_stun_ammo_attack");
  level._effect["stun_shock"] = loadfx("vfx/gameplay/alien/vfx_alien_tesla_shock");
}

init_ims_upgrade_function_pointers() {
  level.ims_alien_fire_func = maps\mp\alien\_combat_resources::ims_fire_cloud;
  level.ims_alien_grace_period_func = maps\mp\alien\_combat_resources::ims_grace_period_scalar;
}

init_ball_drone_upgrade_function_pointers() {
  level.ball_drone_alien_timeout_func = maps\mp\alien\_combat_resources::ball_drone_timeout_scalar;
  level.ball_drone_faster_rocket_func = maps\mp\alien\_combat_resources::ball_drone_fire_rocket_scalar;
}

init_combat_resource_overrides() {
  level.imsSettings = [];

  config = spawnStruct();
  config.weaponInfo = "alienims_projectile_mp";
  config.modelBase = "ims_scorpion_body_iw6";
  config.modelPlacement = "ims_scorpion_body_iw6_placement";
  config.modelPlacementFailed = "ims_scorpion_body_iw6_placement_failed";
  config.modelDestroyed = "ims_scorpion_body_iw6";
  config.modelBombSquad = "ims_scorpion_body_iw6_bombsquad";
  config.hintString = &"ALIEN_COLLECTIBLES_IMS_PICKUP";
  config.placeString = &"ALIEN_COLLECTIBLES_IMS_PLACE";
  config.cannotPlaceString = &"ALIEN_COLLECTIBLES_IMS_CANNOT_PLACE";
  config.streakName = "alien_ims";
  config.splashName = "used_ims";
  config.lifeSpan = 600.0;
  config.gracePeriod = 0.8;
  config.rearmTime = 2.0;
  config.numExplosives = 4;
  config.attacks = config.numExplosives;
  config.explosiveModel = "ims_scorpion_explosive_iw6";
  config.placementHeightTolerance = 11.5;
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
  config.maxHealth = 1000;
  level.imsSettings["alien_ims"] = config;

  config = spawnStruct();
  config.weaponInfo = "alienims_projectileradius_mp";
  config.modelBase = "ims_scorpion_body_iw6";
  config.modelPlacement = "ims_scorpion_body_iw6_placement";
  config.modelPlacementFailed = "ims_scorpion_body_iw6_placement_failed";
  config.modelDestroyed = "ims_scorpion_body_iw6";
  config.modelBombSquad = "ims_scorpion_body_iw6_bombsquad";
  config.hintString = &"ALIEN_COLLECTIBLES_IMS_PICKUP";
  config.placeString = &"ALIEN_COLLECTIBLES_IMS_PLACE";
  config.cannotPlaceString = &"ALIEN_COLLECTIBLES_IMS_CANNOT_PLACE";
  config.streakName = "alien_ims_1";
  config.splashName = "used_ims";
  config.lifeSpan = 600.0;
  config.gracePeriod = 0.8;
  config.rearmTime = 2.0;
  config.numExplosives = 4;
  config.attacks = config.numExplosives;
  config.explosiveModel = "ims_scorpion_explosive_iw6";
  config.placementHeightTolerance = 11.5;
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
  config.maxHealth = 1000;
  level.imsSettings["alien_ims_1"] = config;

  config = spawnStruct();
  config.weaponInfo = "alienims_projectileradius_mp";
  config.modelBase = "ims_scorpion_body_iw6";
  config.modelPlacement = "ims_scorpion_body_iw6_placement";
  config.modelPlacementFailed = "ims_scorpion_body_iw6_placement_failed";
  config.modelDestroyed = "ims_scorpion_body_iw6";
  config.modelBombSquad = "ims_scorpion_body_iw6_bombsquad";
  config.hintString = &"ALIEN_COLLECTIBLES_IMS_PICKUP";
  config.placeString = &"ALIEN_COLLECTIBLES_IMS_PLACE";
  config.cannotPlaceString = &"ALIEN_COLLECTIBLES_IMS_CANNOT_PLACE";
  config.streakName = "alien_ims_2";
  config.splashName = "used_ims";
  config.lifeSpan = 600.0;
  config.gracePeriod = 0.2;
  config.rearmTime = 2.0;
  config.numExplosives = 4;
  config.attacks = config.numExplosives;
  config.explosiveModel = "ims_scorpion_explosive_iw6";
  config.placementHeightTolerance = 11.5;
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
  config.maxHealth = 1000;
  level.imsSettings["alien_ims_2"] = config;

  config = spawnStruct();
  config.weaponInfo = "alienims_projectiledamage_mp";
  config.modelBase = "ims_scorpion_body_iw6";
  config.modelPlacement = "ims_scorpion_body_iw6_placement";
  config.modelPlacementFailed = "ims_scorpion_body_iw6_placement_failed";
  config.modelDestroyed = "ims_scorpion_body_iw6";
  config.modelBombSquad = "ims_scorpion_body_iw6_bombsquad";
  config.hintString = &"ALIEN_COLLECTIBLES_IMS_PICKUP";
  config.placeString = &"ALIEN_COLLECTIBLES_IMS_PLACE";
  config.cannotPlaceString = &"ALIEN_COLLECTIBLES_IMS_CANNOT_PLACE";
  config.streakName = "alien_ims_3";
  config.splashName = "used_ims";
  config.lifeSpan = 600.0;
  config.gracePeriod = 0.2;
  config.rearmTime = 2.0;
  config.numExplosives = 4;
  config.attacks = config.numExplosives;
  config.explosiveModel = "ims_scorpion_explosive_iw6";
  config.placementHeightTolerance = 11.5;
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
  config.maxHealth = 1000;
  level.imsSettings["alien_ims_3"] = config;

  config = spawnStruct();
  config.weaponInfo = "alienims_projectiledamage_mp";
  config.modelBase = "ims_scorpion_body_iw6";
  config.modelPlacement = "ims_scorpion_body_iw6_placement";
  config.modelPlacementFailed = "ims_scorpion_body_iw6_placement_failed";
  config.modelDestroyed = "ims_scorpion_body_iw6";
  config.modelBombSquad = "ims_scorpion_body_iw6_bombsquad";
  config.hintString = &"ALIEN_COLLECTIBLES_IMS_PICKUP";
  config.placeString = &"ALIEN_COLLECTIBLES_IMS_PLACE";
  config.cannotPlaceString = &"ALIEN_COLLECTIBLES_IMS_CANNOT_PLACE";
  config.streakName = "alien_ims_4";
  config.splashName = "used_ims";
  config.lifeSpan = 600.0;
  config.gracePeriod = 0.2;
  config.rearmTime = 2.0;
  config.numExplosives = 6;
  config.attacks = config.numExplosives;
  config.explosiveModel = "ims_scorpion_explosive_iw6";
  config.placementHeightTolerance = 11.5;
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
  config.maxHealth = 1000;
  level.imsSettings["alien_ims_4"] = config;

  if(!isDefined(level.ballDroneSettings))
    level.ballDroneSettings = [];

  level.ballDroneSettings["alien_ball_drone"] = spawnStruct();
  level.ballDroneSettings["alien_ball_drone"].timeOut = 35.0;
  level.ballDroneSettings["alien_ball_drone"].health = 999999;
  level.ballDroneSettings["alien_ball_drone"].maxHealth = 250;
  level.ballDroneSettings["alien_ball_drone"].streakName = "ball_drone_backup";
  level.ballDroneSettings["alien_ball_drone"].vehicleInfo = "backup_drone_mp";
  level.ballDroneSettings["alien_ball_drone"].modelBase = "vehicle_drone_backup_buddy";
  level.ballDroneSettings["alien_ball_drone"].teamSplash = "used_ball_drone_radar";
  level.ballDroneSettings["alien_ball_drone"].fxId_sparks = LoadFX("vfx/gameplay/mp/killstreaks/vfx_ims_sparks");
  level.ballDroneSettings["alien_ball_drone"].fxId_explode = LoadFX("fx/explosions/bouncing_betty_explosion");
  level.ballDroneSettings["alien_ball_drone"].sound_explode = "ball_drone_explode";
  level.ballDroneSettings["alien_ball_drone"].voDestroyed = "backup_destroyed";
  level.ballDroneSettings["alien_ball_drone"].xpPopup = "destroyed_ball_drone";
  level.ballDroneSettings["alien_ball_drone"].weaponInfo = "alien_ball_drone_gun_mp";
  level.ballDroneSettings["alien_ball_drone"].weaponModel = "vehicle_drone_backup_buddy_gun";
  level.ballDroneSettings["alien_ball_drone"].weaponTag = "tag_turret_attach";
  level.ballDroneSettings["alien_ball_drone"].sound_weapon = "weap_p99_fire_npc";
  level.ballDroneSettings["alien_ball_drone"].sound_targeting = "ball_drone_targeting";
  level.ballDroneSettings["alien_ball_drone"].sound_lockon = "ball_drone_lockon";
  level.ballDroneSettings["alien_ball_drone"].sentryMode = "sentry";
  level.ballDroneSettings["alien_ball_drone"].visual_range_sq = 650 * 650;

  level.ballDroneSettings["alien_ball_drone"].burstMin = 5;
  level.ballDroneSettings["alien_ball_drone"].burstMax = 10;
  level.ballDroneSettings["alien_ball_drone"].pauseMin = 0.15;
  level.ballDroneSettings["alien_ball_drone"].pauseMax = 0.35;
  level.ballDroneSettings["alien_ball_drone"].lockonTime = 0.5;
  level.ballDroneSettings["alien_ball_drone"].playFXCallback = ::backupBuddyPlayFX;
  level.ballDroneSettings["alien_ball_drone"].fxId_light1 = [];
  level.ballDroneSettings["alien_ball_drone"].fxId_light1["enemy"] = LoadFX("vfx/gameplay/mp/killstreaks/vfx_light_detonator_blink");
  level.ballDroneSettings["alien_ball_drone"].fxId_light1["friendly"] = LoadFX("fx/misc/light_mine_blink_friendly");

  level.ballDroneSettings["alien_ball_drone_1"] = spawnStruct();
  level.ballDroneSettings["alien_ball_drone_1"].timeOut = 35.0;
  level.ballDroneSettings["alien_ball_drone_1"].health = 999999;
  level.ballDroneSettings["alien_ball_drone_1"].maxHealth = 250;
  level.ballDroneSettings["alien_ball_drone_1"].streakName = "ball_drone_backup";
  level.ballDroneSettings["alien_ball_drone_1"].vehicleInfo = "backup_drone_mp";
  level.ballDroneSettings["alien_ball_drone_1"].modelBase = "vehicle_drone_backup_buddy";
  level.ballDroneSettings["alien_ball_drone_1"].teamSplash = "used_ball_drone_radar";
  level.ballDroneSettings["alien_ball_drone_1"].fxId_sparks = LoadFX("vfx/gameplay/mp/killstreaks/vfx_ims_sparks");
  level.ballDroneSettings["alien_ball_drone_1"].fxId_explode = LoadFX("fx/explosions/bouncing_betty_explosion");
  level.ballDroneSettings["alien_ball_drone_1"].sound_explode = "ball_drone_explode";
  level.ballDroneSettings["alien_ball_drone_1"].voDestroyed = "backup_destroyed";
  level.ballDroneSettings["alien_ball_drone_1"].xpPopup = "destroyed_ball_drone";
  level.ballDroneSettings["alien_ball_drone_1"].weaponInfo = "alien_ball_drone_gun1_mp";
  level.ballDroneSettings["alien_ball_drone_1"].weaponModel = "vehicle_drone_backup_buddy_gun";
  level.ballDroneSettings["alien_ball_drone_1"].weaponTag = "tag_turret_attach";
  level.ballDroneSettings["alien_ball_drone_1"].sound_weapon = "weap_p99_fire_npc";
  level.ballDroneSettings["alien_ball_drone_1"].sound_targeting = "ball_drone_targeting";
  level.ballDroneSettings["alien_ball_drone_1"].sound_lockon = "ball_drone_lockon";
  level.ballDroneSettings["alien_ball_drone_1"].sentryMode = "sentry";
  level.ballDroneSettings["alien_ball_drone_1"].visual_range_sq = 650 * 650;

  level.ballDroneSettings["alien_ball_drone_1"].burstMin = 5;
  level.ballDroneSettings["alien_ball_drone_1"].burstMax = 10;
  level.ballDroneSettings["alien_ball_drone_1"].pauseMin = 0.15;
  level.ballDroneSettings["alien_ball_drone_1"].pauseMax = 0.35;
  level.ballDroneSettings["alien_ball_drone_1"].lockonTime = 0.5;
  level.ballDroneSettings["alien_ball_drone_1"].playFXCallback = ::backupBuddyPlayFX;
  level.ballDroneSettings["alien_ball_drone_1"].fxId_light1 = [];
  level.ballDroneSettings["alien_ball_drone_1"].fxId_light1["enemy"] = LoadFX("vfx/gameplay/mp/killstreaks/vfx_light_detonator_blink");
  level.ballDroneSettings["alien_ball_drone_1"].fxId_light1["friendly"] = LoadFX("fx/misc/light_mine_blink_friendly");

  level.ballDroneSettings["alien_ball_drone_2"] = spawnStruct();
  level.ballDroneSettings["alien_ball_drone_2"].timeOut = 35.0;
  level.ballDroneSettings["alien_ball_drone_2"].health = 999999;
  level.ballDroneSettings["alien_ball_drone_2"].maxHealth = 250;
  level.ballDroneSettings["alien_ball_drone_2"].streakName = "ball_drone_backup";
  level.ballDroneSettings["alien_ball_drone_2"].vehicleInfo = "backup_drone_mp";
  level.ballDroneSettings["alien_ball_drone_2"].modelBase = "vehicle_drone_backup_buddy";
  level.ballDroneSettings["alien_ball_drone_2"].teamSplash = "used_ball_drone_radar";
  level.ballDroneSettings["alien_ball_drone_2"].fxId_sparks = LoadFX("vfx/gameplay/mp/killstreaks/vfx_ims_sparks");
  level.ballDroneSettings["alien_ball_drone_2"].fxId_explode = LoadFX("fx/explosions/bouncing_betty_explosion");
  level.ballDroneSettings["alien_ball_drone_2"].sound_explode = "ball_drone_explode";
  level.ballDroneSettings["alien_ball_drone_2"].voDestroyed = "backup_destroyed";
  level.ballDroneSettings["alien_ball_drone_2"].xpPopup = "destroyed_ball_drone";
  level.ballDroneSettings["alien_ball_drone_2"].weaponInfo = "alien_ball_drone_gun2_mp";
  level.ballDroneSettings["alien_ball_drone_2"].weaponModel = "vehicle_drone_backup_buddy_gun";
  level.ballDroneSettings["alien_ball_drone_2"].weaponTag = "tag_turret_attach";
  level.ballDroneSettings["alien_ball_drone_2"].sound_weapon = "weap_p99_fire_npc";
  level.ballDroneSettings["alien_ball_drone_2"].sound_targeting = "ball_drone_targeting";
  level.ballDroneSettings["alien_ball_drone_2"].sound_lockon = "ball_drone_lockon";
  level.ballDroneSettings["alien_ball_drone_2"].sentryMode = "sentry";
  level.ballDroneSettings["alien_ball_drone_2"].visual_range_sq = 850 * 850;

  level.ballDroneSettings["alien_ball_drone_2"].burstMin = 5;
  level.ballDroneSettings["alien_ball_drone_2"].burstMax = 10;
  level.ballDroneSettings["alien_ball_drone_2"].pauseMin = 0.15;
  level.ballDroneSettings["alien_ball_drone_2"].pauseMax = 0.35;
  level.ballDroneSettings["alien_ball_drone_2"].lockonTime = 0.5;
  level.ballDroneSettings["alien_ball_drone_2"].playFXCallback = ::backupBuddyPlayFX;
  level.ballDroneSettings["alien_ball_drone_2"].fxId_light1 = [];
  level.ballDroneSettings["alien_ball_drone_2"].fxId_light1["enemy"] = LoadFX("vfx/gameplay/mp/killstreaks/vfx_light_detonator_blink");
  level.ballDroneSettings["alien_ball_drone_2"].fxId_light1["friendly"] = LoadFX("fx/misc/light_mine_blink_friendly");

  level.ballDroneSettings["alien_ball_drone_3"] = spawnStruct();
  level.ballDroneSettings["alien_ball_drone_3"].timeOut = 50.0;
  level.ballDroneSettings["alien_ball_drone_3"].health = 999999;
  level.ballDroneSettings["alien_ball_drone_3"].maxHealth = 250;
  level.ballDroneSettings["alien_ball_drone_3"].streakName = "ball_drone_backup";
  level.ballDroneSettings["alien_ball_drone_3"].vehicleInfo = "backup_drone_mp";
  level.ballDroneSettings["alien_ball_drone_3"].modelBase = "vehicle_drone_backup_buddy";
  level.ballDroneSettings["alien_ball_drone_3"].teamSplash = "used_ball_drone_radar";
  level.ballDroneSettings["alien_ball_drone_3"].fxId_sparks = LoadFX("vfx/gameplay/mp/killstreaks/vfx_ims_sparks");
  level.ballDroneSettings["alien_ball_drone_3"].fxId_explode = LoadFX("fx/explosions/bouncing_betty_explosion");
  level.ballDroneSettings["alien_ball_drone_3"].sound_explode = "ball_drone_explode";
  level.ballDroneSettings["alien_ball_drone_3"].voDestroyed = "backup_destroyed";
  level.ballDroneSettings["alien_ball_drone_3"].xpPopup = "destroyed_ball_drone";
  level.ballDroneSettings["alien_ball_drone_3"].weaponInfo = "alien_ball_drone_gun3_mp";
  level.ballDroneSettings["alien_ball_drone_3"].weaponModel = "vehicle_drone_backup_buddy_gun";
  level.ballDroneSettings["alien_ball_drone_3"].weaponTag = "tag_turret_attach";
  level.ballDroneSettings["alien_ball_drone_3"].sound_weapon = "weap_p99_fire_npc";
  level.ballDroneSettings["alien_ball_drone_3"].sound_targeting = "ball_drone_targeting";
  level.ballDroneSettings["alien_ball_drone_3"].sound_lockon = "ball_drone_lockon";
  level.ballDroneSettings["alien_ball_drone_3"].sentryMode = "sentry";
  level.ballDroneSettings["alien_ball_drone_3"].visual_range_sq = 850 * 850;

  level.ballDroneSettings["alien_ball_drone_3"].burstMin = 5;
  level.ballDroneSettings["alien_ball_drone_3"].burstMax = 10;
  level.ballDroneSettings["alien_ball_drone_3"].pauseMin = 0.15;
  level.ballDroneSettings["alien_ball_drone_3"].pauseMax = 0.35;
  level.ballDroneSettings["alien_ball_drone_3"].lockonTime = 0.5;
  level.ballDroneSettings["alien_ball_drone_3"].playFXCallback = ::backupBuddyPlayFX;
  level.ballDroneSettings["alien_ball_drone_3"].fxId_light1 = [];
  level.ballDroneSettings["alien_ball_drone_3"].fxId_light1["enemy"] = LoadFX("vfx/gameplay/mp/killstreaks/vfx_light_detonator_blink");
  level.ballDroneSettings["alien_ball_drone_3"].fxId_light1["friendly"] = LoadFX("fx/misc/light_mine_blink_friendly");

  level.ballDroneSettings["alien_ball_drone_4"] = spawnStruct();
  level.ballDroneSettings["alien_ball_drone_4"].timeOut = 50.0;
  level.ballDroneSettings["alien_ball_drone_4"].health = 999999;
  level.ballDroneSettings["alien_ball_drone_4"].maxHealth = 250;
  level.ballDroneSettings["alien_ball_drone_4"].streakName = "ball_drone_backup";
  level.ballDroneSettings["alien_ball_drone_4"].vehicleInfo = "backup_drone_mp";
  level.ballDroneSettings["alien_ball_drone_4"].modelBase = "vehicle_drone_backup_buddy";
  level.ballDroneSettings["alien_ball_drone_4"].teamSplash = "used_ball_drone_radar";
  level.ballDroneSettings["alien_ball_drone_4"].fxId_sparks = LoadFX("vfx/gameplay/mp/killstreaks/vfx_ims_sparks");
  level.ballDroneSettings["alien_ball_drone_4"].fxId_explode = LoadFX("fx/explosions/bouncing_betty_explosion");
  level.ballDroneSettings["alien_ball_drone_4"].sound_explode = "ball_drone_explode";
  level.ballDroneSettings["alien_ball_drone_4"].voDestroyed = "backup_destroyed";
  level.ballDroneSettings["alien_ball_drone_4"].xpPopup = "destroyed_ball_drone";
  level.ballDroneSettings["alien_ball_drone_4"].weaponInfo = "alien_ball_drone_gun4_mp";
  level.ballDroneSettings["alien_ball_drone_4"].weaponModel = "vehicle_drone_backup_buddy_gun";
  level.ballDroneSettings["alien_ball_drone_4"].weaponTag = "tag_turret_attach";
  level.ballDroneSettings["alien_ball_drone_4"].sound_weapon = "weap_p99_fire_npc";
  level.ballDroneSettings["alien_ball_drone_4"].sound_targeting = "ball_drone_targeting";
  level.ballDroneSettings["alien_ball_drone_4"].sound_lockon = "ball_drone_lockon";
  level.ballDroneSettings["alien_ball_drone_4"].sentryMode = "sentry";
  level.ballDroneSettings["alien_ball_drone_4"].visual_range_sq = 850 * 850;

  level.ballDroneSettings["alien_ball_drone_4"].burstMin = 5;
  level.ballDroneSettings["alien_ball_drone_4"].burstMax = 10;
  level.ballDroneSettings["alien_ball_drone_4"].pauseMin = 0.15;
  level.ballDroneSettings["alien_ball_drone_4"].pauseMax = 0.35;
  level.ballDroneSettings["alien_ball_drone_4"].lockonTime = 0.5;
  level.ballDroneSettings["alien_ball_drone_4"].playFXCallback = ::backupBuddyPlayFX;
  level.ballDroneSettings["alien_ball_drone_4"].fxId_light1 = [];
  level.ballDroneSettings["alien_ball_drone_4"].fxId_light1["enemy"] = LoadFX("vfx/gameplay/mp/killstreaks/vfx_light_detonator_blink");
  level.ballDroneSettings["alien_ball_drone_4"].fxId_light1["friendly"] = LoadFX("fx/misc/light_mine_blink_friendly");

  level.boxSettings["deployable_vest"].hintString = &"ALIEN_COLLECTIBLES_DEPLOYABLE_VEST_PICKUP";
  level.boxSettings["deployable_vest"].capturingString = &"ALIEN_COLLECTIBLES_DEPLOYABLE_VEST_GETTING";
  level.boxSettings["deployable_vest"].eventString = &"ALIEN_COLLECTIBLES_DEPLOYED_VEST";

  level.boxSettings["deployable_ammo"].hintString = &"ALIEN_COLLECTIBLES_DEPLOYABLE_AMMO_PICKUP";
  level.boxSettings["deployable_ammo"].capturingString = &"ALIEN_COLLECTIBLES_DEPLOYABLE_AMMO_TAKING";
  level.boxSettings["deployable_ammo"].eventString = &"ALIEN_COLLECTIBLES_DEPLOYABLE_AMMO_TAKEN";

  level.boxSettings["deployable_juicebox"].hintString = &"ALIEN_COLLECTIBLES_DEPLOYABLE_BOOST_PICKUP";
  level.boxSettings["deployable_juicebox"].capturingString = &"ALIEN_COLLECTIBLES_DEPLOYABLE_BOOST_TAKING";
  level.boxSettings["deployable_juicebox"].eventString = &"ALIEN_COLLECTIBLES_DEPLOYABLE_BOOST_TAKEN";

  level.boxSettings["deployable_ammo"].deathDamageMax = undefined;

  level.mineDamageMin = 325;
  level.mineDamageMax = 750;

  level.maxPerPlayerExplosives = 5;

  level.deployablebox_vest_rank = [];
  level.deployablebox_vest_rank[0] = 25;
  level.deployablebox_vest_rank[1] = 50;
  level.deployablebox_vest_rank[2] = 75;
  level.deployablebox_vest_rank[3] = 100;
  level.deployablebox_vest_rank[4] = 125;
  level.deployablebox_vest_max = 125;

  level.deployablebox_juicebox_rank = [];
  level.deployablebox_juicebox_rank[0] = 15;
  level.deployablebox_juicebox_rank[1] = 30;
  level.deployablebox_juicebox_rank[2] = 30;
  level.deployablebox_juicebox_rank[3] = 45;
  level.deployablebox_juicebox_rank[4] = 60;
  level.deployablebox_juicebox_max = 60;

  level.deployablebox_adrenalinebox_rank = [];
  level.deployablebox_adrenalinebox_rank[0] = 15;
  level.deployablebox_adrenalinebox_rank[1] = 15;
  level.deployablebox_adrenalinebox_rank[2] = 15;
  level.deployablebox_adrenalinebox_rank[3] = 30;
  level.deployablebox_adrenalinebox_rank[4] = 45;
  level.deployablebox_adrenalinebox_max = 45;
}

init_combat_resource_from_table() {
  level.alien_combat_resources = [];

  populate_combat_resource_from_table(0, "munition");
  populate_combat_resource_from_table(100, "support");
  populate_combat_resource_from_table(200, "defense");
  populate_combat_resource_from_table(300, "offense");
}

CancelUse_default_deployable_box(def, rank) {
  self takeweapon("aliendeployable_crate_marker_mp");
  self.deployable = false;
  self SwitchToWeapon(self.last_weapon);
  self notify("cancel_deployable_via_marker");
}

populate_combat_resource_from_table(start_idx, resource_type) {
  level.alien_combat_resources[resource_type] = [];

  for(i = start_idx; i <= start_idx + TABLE_DPAD_MAX_INDEX; i++) {
    resource_ref = get_resource_ref_by_index(i);
    if(resource_ref == "") {
      break;
    }

    if(!isDefined(level.alien_combat_resources[resource_ref])) {
      resource = spawnStruct();
      resource.upgrades = [];
      resource.unlock = get_unlock_by_ref(resource_ref);
      resource.name = get_name_by_ref(resource_ref);
      resource.icon = get_icon_by_ref(resource_ref);
      resource.dpad_icon = get_dpad_icon_by_ref(resource_ref);
      resource.ref = resource_ref;
      resource.type = resource_type;
      resource.callbacks = level.alien_combat_resource_callbacks[resource_ref];

      level.alien_combat_resources[resource_type][resource_ref] = resource;
    }

    accumulated_cost = 0;

    for(j = i; j <= start_idx + TABLE_DPAD_MAX_INDEX; j++) {
      upgrade_ref = get_resource_ref_by_index(j);
      if(upgrade_ref == "") {
        break;
      }

      if(resource_ref == upgrade_ref || is_resource_set(resource_ref, upgrade_ref)) {
        upgrade = spawnStruct();
        upgrade.ref = upgrade_ref;
        upgrade.desc = get_desc_by_ref(upgrade_ref);
        upgrade.cost = get_cost_by_ref(upgrade_ref);
        upgrade.point_cost = get_point_cost_by_ref(upgrade_ref);
        upgrade.dpad_icon = get_dpad_upgrade_icon_by_ref(upgrade_ref);

        accumulated_cost += int(upgrade.point_cost);
        upgrade.total_cost = accumulated_cost;

        level.alien_combat_resources[resource_type][resource_ref].upgrades[j - i] = upgrade;
      } else {
        break;
      }
    }

    i = j - 1;
  }
}

is_resource_set(resource_ref, upgrade_ref) {
  assert(isDefined(resource_ref) && isDefined(upgrade_ref));

  if(resource_ref == upgrade_ref)
    return false;

  if(!issubstr(upgrade_ref, resource_ref))
    return false;

  resource_toks = StrTok(resource_ref, "_");
  upgrade_toks = StrTok(upgrade_ref, "_");

  if(upgrade_toks.size - resource_toks.size != 1)
    return false;

  for(i = 0; i < upgrade_toks.size - 1; i++) {
    if(upgrade_toks[i] != resource_toks[i])
      return false;
  }

  return true;
}

get_resource_ref_by_index(index) {
  return tablelookup(level.alien_combat_resources_table, TABLE_INDEX, index, TABLE_REF);
}

get_name_by_ref(ref) {
  return tablelookup(level.alien_combat_resources_table, TABLE_REF, ref, TABLE_NAME);
}

get_icon_by_ref(ref) {
  return tablelookup(level.alien_combat_resources_table, TABLE_REF, ref, TABLE_ICON);
}

get_dpad_icon_by_ref(ref) {
  return tablelookup(level.alien_combat_resources_table, TABLE_REF, ref, TABLE_DPAD_ICON);
}

get_desc_by_ref(ref) {
  return tablelookup(level.alien_combat_resources_table, TABLE_REF, ref, TABLE_DESC);
}

get_point_cost_by_ref(ref) {
  return int(tablelookup(level.alien_combat_resources_table, TABLE_REF, ref, TABLE_POINT_COST));
}

get_cost_by_ref(ref) {
  return int(tablelookup(level.alien_combat_resources_table, TABLE_REF, ref, TABLE_COST));
}

get_unlock_by_ref(ref) {
  return int(tablelookup(level.alien_combat_resources_table, TABLE_REF, ref, TABLE_UNLOCK));
}

get_is_upgrade_by_ref(ref) {
  return int(tablelookup(level.alien_combat_resources_table, TABLE_REF, ref, TABLE_IS_UPGRADE));
}

get_dpad_upgrade_icon_by_ref(ref) {
  return tablelookup(level.alien_combat_resources_table, TABLE_REF, ref, TABLE_DPAD_ICON);
}

has_ims() {
  if(isDefined(self.imsList) && self.imsList.size > 0 && IsAlive(self.imsList[0])) {
    return true;
  }

  return false;
}

has_backup_uav() {
  if(isDefined(self.ballDrone)) {
    return true;
  }

  return false;
}

BOX_TYPE_AMMO = "deployable_ammo";
TryUse_dpad_team_ammo(def, rank) {
  self.team_ammo_rank = rank;
  self common_TryUse_actions();
  self thread maps\mp\alien\_deployablebox::default_tryUseDeployable(rank, BOX_TYPE_AMMO);
}

deployable_ammo_placed_listener() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");

  self waittill("new_deployable_box", ammo);
  self track_deployables(ammo);

  ammo setCanDamage(false);
  ammo setCanRadiusDamage(false);
  if(ammo.upgrade_rank == 4) {
    ammo thread team_ammo_regen();
  }
}

track_deployables(ammo) {
  if(!isDefined(self.active_deployables)) {
    self.active_deployables = [];
  }

  if(isDefined(self.active_deployables[ammo.boxtype]))
    self.active_deployables[ammo.boxtype] notify("death");

  self.active_deployables[ammo.boxtype] = ammo;
}

team_ammo_regen() {
  self endon("death");
  self endon("ammo_regen_timeout");
  AMMO_REGEN_RADIUS_SQR = 65536.0;
  AMMO_REGEN_RATE = 0.1;

  while(1) {
    foreach(player in level.players) {
      if(isAlive(player) && DistanceSquared(self.origin, player.origin) < AMMO_REGEN_RADIUS_SQR) {
        player maps\mp\alien\_deployablebox_functions::addRatioMaxStockToAllWeapons(AMMO_REGEN_RATE);
      }
      wait 5.0;
    }
  }
}

Use_dpad_team_ammo(def, rank) {
  self thread deployable_ammo_placed_listener();
  self.deployable = false;
  level thread maps\mp\alien\_music_and_dialog::playVOForTeamAmmo(self);
}

BOX_TYPE_JUICED = "deployable_juicebox";
TryUse_dpad_team_boost(def, rank) {
  self.team_boost_rank = rank;
  self common_TryUse_actions();
  self thread maps\mp\alien\_deployablebox::default_tryUseDeployable(rank, BOX_TYPE_JUICED);
}

deployable_boost_placed_listener() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");

  self waittill("new_deployable_box", boost);
  self track_deployables(boost);

  boost setCanDamage(false);
  boost setCanRadiusDamage(false);
}

Use_dpad_team_boost(def, rank) {
  self thread deployable_boost_placed_listener();
  self.deployable = false;
  level thread maps\mp\alien\_music_and_dialog::playVOForTeamBoost(self);
}

BOX_TYPE_ADRENALINE = "deployable_adrenalinebox";
TryUse_dpad_team_adrenaline(def, rank) {
  self.team_adrenaline_rank = rank;
  self common_TryUse_actions();
  self thread maps\mp\alien\_deployablebox::default_tryUseDeployable(rank, BOX_TYPE_ADRENALINE);
}

deployable_adrenaline_placed_listener() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");

  self waittill("new_deployable_box", adrenaline);
  self track_deployables(adrenaline);

  adrenaline setCanDamage(false);
  adrenaline setCanRadiusDamage(false);
}

Use_dpad_team_adrenaline(def, rank) {
  self thread deployable_adrenaline_placed_listener();
  self.deployable = false;
  level thread maps\mp\alien\_music_and_dialog::playVOForTeamBoost(self);
}

BOX_TYPE_VEST = "deployable_vest";
TryUse_dpad_team_armor(def, rank) {
  self.team_armor_rank = rank;
  self common_TryUse_actions();
  self thread maps\mp\alien\_deployablebox::default_tryUseDeployable(rank, BOX_TYPE_VEST);
}

deployable_armor_placed_listener() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  self waittill("new_deployable_box", armor);
  self track_deployables(armor);
  armor setCanDamage(false);
  armor setCanRadiusDamage(false);
}

Use_dpad_team_armor(def, rank) {
  self thread deployable_armor_placed_listener();
  self.deployable = false;
  level thread maps\mp\alien\_music_and_dialog::playVOForTeamArmor(self);
}

BOX_TYPE_EXPLOSIVES = "deployable_explosives";
TryUse_dpad_team_explosives(def, rank) {
  self.team_explosives_rank = rank;
  self common_TryUse_actions();
  self thread maps\mp\alien\_deployablebox::default_tryUseDeployable(rank, BOX_TYPE_EXPLOSIVES);
}

deployable_explosives_placed_listener() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  self waittill("new_deployable_box", explosives);
  self track_deployables(explosives);
  explosives setCanDamage(false);
  explosives setCanRadiusDamage(false);
}

Use_dpad_team_explosives(def, rank) {
  self thread deployable_explosives_placed_listener();
  self.deployable = false;

  level notify("dlc_vo_notify", "inform_explosives", self);
  if(!isDefined(level.use_dlc_vo))
    level thread maps\mp\alien\_music_and_dialog::playVOForSupportItems(self);
}

BOX_TYPE_RANDOMBOX = "deployable_randombox";
TryUse_dpad_team_randombox(def, rank) {
  self.team_randombox_rank = rank;
  self common_TryUse_actions();
  self thread maps\mp\alien\_deployablebox::default_tryUseDeployable(rank, BOX_TYPE_RANDOMBOX);
}

deployable_randombox_placed_listener() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  self waittill("new_deployable_box", randombox);
  self track_deployables(randombox);
  randombox setCanDamage(false);
  randombox setCanRadiusDamage(false);
}

Use_dpad_team_randombox(def, rank) {
  self thread deployable_randombox_placed_listener();
  self.deployable = false;

  level thread maps\mp\alien\_music_and_dialog::playVOForRandombox(self);
}

BOX_TYPE_CURRENCY = "deployable_currency";
TryUse_dpad_team_currency(def, rank) {
  self.team_currency_rank = rank;
  self common_TryUse_actions();
  self thread maps\mp\alien\_deployablebox::default_tryUseDeployable(rank, BOX_TYPE_CURRENCY);
}

deployable_currency_placed_listener() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  self waittill("new_deployable_box", currency);
  currency setCanDamage(false);
  currency setCanRadiusDamage(false);
}

Use_dpad_team_currency(def, rank) {
  self thread deployable_currency_placed_listener();
  self.deployable = false;
}

CanPurchase_dpad_riotshield(def, rank) {
  if(self.hasRiotShield) {
    self setLowerMessage("riot_shield_equipped", &"ALIEN_COLLECTIBLES_RIOT_SHIELD_EQUIPPED", 3);
    return false;
  }

  return alt_canPurchase(def, rank);
}
TryUse_dpad_riotshield(def, rank) {
  self TryUse_dpad_riotshield_Internal(def, rank);
}

TryUse_dpad_riotshield_Internal(def, rank) {
  self store_weapons_status();
  self.last_weapon = self GetCurrentWeapon();
  if(rank == 0) {
    self _giveWeapon("iw5_alienriotshield_mp");
    self SetWeaponAmmoClip("iw5_alienriotshield_mp", 10);
    self SwitchToWeapon("iw5_alienriotshield_mp");

  }
  if(rank == 1) {
    self _giveWeapon("iw5_alienriotshield1_mp");
    self SetWeaponAmmoClip("iw5_alienriotshield1_mp", 15);
    self SwitchToWeapon("iw5_alienriotshield1_mp");
  }
  if(rank == 2) {
    self _giveWeapon("iw5_alienriotshield2_mp");
    self SetWeaponAmmoClip("iw5_alienriotshield2_mp", 15);
    self SwitchToWeapon("iw5_alienriotshield2_mp");
  }
  if(rank == 3) {
    self _giveWeapon("iw5_alienriotshield3_mp");
    self SetWeaponAmmoClip("iw5_alienriotshield3_mp", 20);
    self SwitchToWeapon("iw5_alienriotshield3_mp");
  }
  if(rank == 4) {
    self _giveWeapon("iw5_alienriotshield4_mp");
    self SetWeaponAmmoClip("iw5_alienriotshield4_mp", 25);
    self.fireShield = 1.0;
    self SwitchToWeapon("iw5_alienriotshield4_mp");

  }

  wait .5;
}

Use_dpad_riotshield(def, rank) {
  self notify("action_use");
  self SetClientOmnvar("ui_alien_riotshield_equipped", 1);

  level notify("dlc_vo_notify", "inform_shield", self);
}
CancelUse_dpad_riotshield(def, rank) {
  if(rank == 0)
    self TakeWeapon("iw5_alienriotshield_mp");
  if(rank == 1)
    self TakeWeapon("iw5_alienriotshield1_mp");
  if(rank == 2)
    self TakeWeapon("iw5_alienriotshield2_mp");
  if(rank == 3)
    self TakeWeapon("iw5_alienriotshield3_mp");
  if(rank == 4)
    self TakeWeapon("iw5_alienriotshield4_mp");

  if(!isDefined(level.drill_carrier) || (isDefined(level.drill_carrier) && self != level.drill_carrier)) {
    if(isDefined(self.last_weapon)) {
      self SwitchToWeapon(self.last_weapon);
    }
  }

  self SetClientOmnvar("ui_alien_riotshield_equipped", -1);

  return true;
}

CanPurchase_dpad_sentry(def, rank) {
  count = get_valid_sentry_count();

  max_count = get_max_sentry_count(rank, "sentry");

  if(count >= max_count) {
    self iprintlnBold(&"ALIEN_COLLECTIBLES_MAX_TURRETS");
    return false;
  }
  if(is_true(self.isCarrying)) {
    return false;
  }

  return default_canPurchase(def, rank);
}

TryUse_dpad_sentry(def, rank) {
  if(is_true(self.isCarrying))
    return false;

  self.last_weapon = self GetCurrentWeapon();

  if(rank == 0) {
    self.last_sentry = "alien_sentry";
    sentryGunBase = [[level.createsentryforplayer_func]]("alien_sentry", self);
    sentryGunBase SetConvergenceTime(1.5, "pitch");
    sentryGunBase SetConvergenceTime(1.5, "yaw");
    self.carriedSentry = sentryGunBase;
    sentryGunBase[[level.sentry_setcarried_func]](self);
    self DisableWeapons();
  }
  if(rank == 1) {
    self.last_sentry = "alien_sentry_1";
    sentryGun1 = [[level.createsentryforplayer_func]]("alien_sentry_1", self);
    sentryGun1 SetConvergenceTime(1.0, "pitch");
    sentryGun1 SetConvergenceTime(1.0, "yaw");
    self.carriedSentry = sentryGun1;
    sentryGun1[[level.sentry_setcarried_func]](self);
    self DisableWeapons();
  }
  if(rank == 2) {
    self.last_sentry = "alien_sentry_2";
    sentryGun2 = [[level.createsentryforplayer_func]]("alien_sentry_2", self);
    sentryGun2 SetConvergenceTime(1.0, "pitch");
    sentryGun2 SetConvergenceTime(1.0, "yaw");
    self.carriedSentry = sentryGun2;
    sentryGun2[[level.sentry_setcarried_func]](self);
    self DisableWeapons();
  }
  if(rank == 3) {
    self.last_sentry = "alien_sentry_3";
    sentryGun3 = [[level.createsentryforplayer_func]]("alien_sentry_3", self);
    sentryGun3 SetConvergenceTime(1.0, "pitch");
    sentryGun3 SetConvergenceTime(1.0, "yaw");
    self.carriedSentry = sentryGun3;
    sentryGun3[[level.sentry_setcarried_func]](self);
    self DisableWeapons();
  }

  if(rank == 4) {
    self.last_sentry = "alien_sentry_4";
    sentryGun4 = [[level.createsentryforplayer_func]]("alien_sentry_4", self);
    sentryGun4 SetConvergenceTime(1.0, "pitch");
    sentryGun4 SetConvergenceTime(1.0, "yaw");
    self.carriedSentry = sentryGun4;
    sentryGun4[[level.sentry_setcarried_func]](self);
    self DisableWeapons();
  }

}
sentry_placed_listener(rank) {
  SENTRY_HEALTH_UPGRADE_SCALAR = 1.5;

  self endon("death");
  self endon("disconnect");
  level endon("game_ended");

  self DisableWeaponSwitch();
  self waittill("new_sentry", newSentry);
  self EnableWeaponSwitch();

  self thread manage_sentry_count(rank, "sentry");

  if(IsSentient(newSentry)) {
    if(!is_chaos_mode())
      newSentry.threatbias = -1000;
    else
      newSentry.threatbias = -3500;
  }
  newSentry.maxHealth = 150;

  if(isDefined(newsentry.owner) && newSentry.owner maps\mp\alien\_persistence::is_upgrade_enabled("sentry_health_upgrade"))
    newSentry.maxhealth = int(newSentry.maxhealth * SENTRY_HEALTH_UPGRADE_SCALAR);

  ammo = 450;
  switch (rank) {
    case 1:
      ammo = 450;
      break;
    case 2:
      ammo = 450;
      break;
    case 3:
      ammo = 600;
      break;
    case 4:
      ammo = 600;
      break;
    default:
      ammo = 450;
  }

  newSentry thread sentry_watch_ammo(ammo);
}

sentry_watch_ammo(ammo) {
  self endon("death");
  while(ammo > 0) {
    self waittill("bullet_fired");
    ammo--;
  }

  self notify("death");
}

Use_dpad_sentry(def, rank) {
  self thread sentry_placed_listener(rank);
  self.carriedSentry[[level.sentry_setplaced_func]]();
  self EnableWeapons();

  self.carriedSentry = undefined;
  self.isCarrying = false;
  if(isDefined(self.last_weapon))
    self SwitchToWeapon(self.last_weapon);

  level thread maps\mp\alien\_music_and_dialog::playVOForSentry(self, "sentry");
}
CancelUse_dpad_sentry(def, rank) {
  if(isDefined(self.carriedSentry))
    self.carriedSentry[[level.sentry_setcancelled_func]]();
  self EnableWeapons();
  if(isDefined(self.last_weapon))
    self SwitchToWeapon(self.last_weapon);
}

get_valid_sentry_count() {
  my_sentry_list = get_all_my_sentry("sentry");
  return get_valid_equipment_count(my_sentry_list);
}

CanPurchase_dpad_glsentry(def, rank) {
  count = get_valid_grenade_turret_count();

  max_count = 1;

  if(count >= max_count) {
    self iprintlnBold(&"ALIEN_COLLECTIBLES_MAX_TURRETS");
    return false;
  }

  return default_canPurchase(def, rank);
}

TryUse_dpad_glsentry(def, rank) {
  self.last_weapon = self GetCurrentWeapon();

  if(rank == 0) {
    self.last_sentry = "gl_turret";
    glsentryGunBase = [[level.createsentryforplayer_func]]("gl_turret", self);
    self.carriedSentry = glsentryGunBase;
    glsentryGunBase[[level.sentry_setcarried_func]](self);
    self DisableWeapons();
  }
  if(rank == 1) {
    self.last_sentry = "gl_turret_1";
    glsentryGun1 = [[level.createsentryforplayer_func]]("gl_turret_1", self);
    self.carriedSentry = glsentryGun1;
    glsentryGun1[[level.sentry_setcarried_func]](self);
    self DisableWeapons();
  }
  if(rank == 2) {
    self.last_sentry = "gl_turret_2";
    glsentryGun2 = [[level.createsentryforplayer_func]]("gl_turret_2", self);
    self.carriedSentry = glsentryGun2;
    glsentryGun2[[level.sentry_setcarried_func]](self);
    self DisableWeapons();
  }
  if(rank == 3) {
    self.last_sentry = "gl_turret_3";
    glsentryGun3 = [[level.createsentryforplayer_func]]("gl_turret_3", self);
    self.carriedSentry = glsentryGun3;
    glsentryGun3[[level.sentry_setcarried_func]](self);
    self DisableWeapons();
  }

  if(rank == 4) {
    self.last_sentry = "gl_turret_4";
    glsentryGun4 = [[level.createsentryforplayer_func]]("gl_turret_4", self);
    self.carriedSentry = glsentryGun4;
    glsentryGun4[[level.sentry_setcarried_func]](self);
    self DisableWeapons();
  }
}

glsentry_placed_listener(rank) {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");

  self DisableWeaponSwitch();
  self waittill("new_sentry", newSentry);
  self EnableWeaponSwitch();

  self thread manage_sentry_count(rank, "grenade");

  if(IsSentient(newSentry)) {
    newSentry.threatbias = -1000;
  }
  newSentry.maxHealth = 150;

  ammo = 10;
  switch (rank) {
    case 1:
      ammo = 15;
      break;
    case 2:
      ammo = 15;
      break;
    case 3:
      ammo = 30;
      break;
    case 4:
      ammo = 30;
      break;
    default:
      ammo = 10;
  }

  newSentry thread glsentry_watch_ammo(ammo, self);
}

glsentry_watch_ammo(ammo, player) {
  self endon("death");
  self.turret_ammo = ammo;
  self thread watch_players_onoff_turret();

  while(ammo > 0) {
    self waittill("turret_fire");
    ammo--;
  }

  self.forceDisable = true;
  self MakeTurretInoperable();

  if(isDefined(self.owner) && isAlive(self.owner)) {
    self thread watch_player_disengage(player);
  }
}

Use_dpad_glsentry(def, rank) {
  self thread glsentry_placed_listener(rank);
  self.carriedSentry[[level.sentry_setplaced_func]]();
  self EnableWeapons();

  self.carriedSentry = undefined;
  self.isCarrying = false;
  if(isDefined(self.last_weapon))
    self SwitchToWeapon(self.last_weapon);

  level thread maps\mp\alien\_music_and_dialog::playVOForSentry(self, "grenade");
}

CancelUse_dpad_glsentry(def, rank) {
  if(isDefined(self.carriedSentry))
    self.carriedSentry[[level.sentry_setcancelled_func]]();
  self EnableWeapons();
  if(isDefined(self.last_weapon))
    self SwitchToWeapon(self.last_weapon);
}

get_valid_grenade_turret_count() {
  my_sentry_list = get_all_my_sentry("grenade");
  return get_valid_equipment_count(my_sentry_list);
}

CanPurchase_dpad_minigun_turret(def, rank) {
  count = get_valid_minigun_turret_count();

  max_count = 1;

  if(count >= max_count) {
    self iprintlnBold(&"ALIEN_COLLECTIBLES_MAX_TURRETS");
    return false;
  }

  return default_canPurchase(def, rank);
}

TryUse_dpad_minigun_turret(def, rank) {
  self.last_weapon = self GetCurrentWeapon();

  if(rank == 0) {
    self.last_weapon = self GetCurrentWeapon();
    self.last_sentry = "minigun_turret";
    minigunTurretBase = [[level.createsentryforplayer_func]]("minigun_turret", self);
    self.carriedSentry = minigunTurretBase;
    minigunTurretBase[[level.sentry_setcarried_func]](self);
    self DisableWeapons();
  }
  if(rank == 1) {
    self.last_weapon = self GetCurrentWeapon();
    self.last_sentry = "minigun_turret_1";
    minigunTurret1 = [[level.createsentryforplayer_func]]("minigun_turret_1", self);
    self.carriedSentry = minigunTurret1;
    minigunTurret1[[level.sentry_setcarried_func]](self);
    self DisableWeapons();
  }
  if(rank == 2) {
    self.last_weapon = self GetCurrentWeapon();
    self.last_sentry = "minigun_turret";
    minigunTurret2 = [[level.createsentryforplayer_func]]("minigun_turret_2", self);
    self.carriedSentry = minigunTurret2;
    minigunTurret2[[level.sentry_setcarried_func]](self);
    self DisableWeapons();
  }
  if(rank == 3) {
    self.last_weapon = self GetCurrentWeapon();
    self.last_sentry = "minigun_turret";
    minigunTurret3 = [[level.createsentryforplayer_func]]("minigun_turret_3", self);
    self.carriedSentry = minigunTurret3;
    minigunTurret3[[level.sentry_setcarried_func]](self);
    self DisableWeapons();
  }

  if(rank == 4) {
    self.last_weapon = self GetCurrentWeapon();
    self.last_sentry = "minigun_turret";
    minigunTurret4 = [[level.createsentryforplayer_func]]("minigun_turret_4", self);
    self.carriedSentry = minigunTurret4;
    minigunTurret4[[level.sentry_setcarried_func]](self);
    self DisableWeapons();
  }

}
minigun_turret_placed_listener(rank) {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");

  self DisableWeaponSwitch();
  self waittill("new_sentry", newSentry);
  self EnableWeaponSwitch();
  newsentry.owner = self;

  self thread manage_sentry_count(rank, "minigun");

  if(IsSentient(newSentry)) {
    newSentry.threatbias = -1000;
  }
  newSentry.maxHealth = 150;

  ammo = 100;
  switch (rank) {
    case 1:
      ammo = 125;
      break;
    case 2:
      ammo = 150;
      break;
    case 3:
      ammo = 175;
      break;
    case 4:
      ammo = 200;
      break;
    default:
      ammo = 100;
  }

  newSentry thread minigun_turret_watch_ammo(ammo, self);
}

minigun_turret_watch_ammo(ammo, player) {
  self endon("death");
  self.turret_ammo = ammo;

  self thread watch_players_onoff_turret();

  while(ammo > 0) {
    self waittill("turret_fire");
    ammo--;
  }

  self.forceDisable = true;
  self TurretFireDisable();
  if(isDefined(self.owner) && isAlive(self.owner)) {
    self thread watch_player_disengage(player);
  }

}

turret_update_ammocounter(player) {
  self endon("death");
  self notify("turretupdateammocount");
  self endon("turretupdateammocount");

  while(self.turret_ammo > 0) {
    self waittill("turret_fire");
    self.turret_ammo--;
    if(isDefined(player) && isAlive(player)) {
      player notify("turret_fire");
      player set_turret_ammocount(self.turret_ammo);
    }
  }
}

watch_players_onoff_turret() {
  self endon("death");

  while(1) {
    self waittill("trigger", user);

    if(!isPlayer(user)) {
      continue;
    }
    if(isDefined(self.turret_ammo)) {
      user show_turret_icon(1);
      user set_turret_ammocount(self.turret_ammo);
      if(!is_chaos_mode())
        user disable_special_ammo();
    }

    self thread turret_update_ammocounter(user);
    self thread clear_turret_ammo_counter_on_death(user);

    self waittill("turret_deactivate");

    if(isDefined(user) && isAlive(user)) {
      user notify("weapon_change", user GetCurrentPrimaryWeapon());
      user hide_turret_icon();
    }

  }
}

watch_player_disengage(player) {
  player thread wait_for_player_to_dismount_turret();
  self waittill("player_dismount");
  self.deleting = true;
  wait 1;
  self notify("death");

  if(isDefined(player) && isAlive(player)) {
    player hide_turret_icon();
    if(!is_chaos_mode())
      player enable_special_ammo();
    weapon = player GetCurrentWeapon();
    player notify("weapon_change", weapon);
  }

}

clear_turret_ammo_counter_on_death(user) {
  self notify("clearammocounterondeath");
  self endon("clearammocounterondeath");
  self endon("turret_deactivate");
  user endon("disconnect");

  self waittill("death");

  user hide_turret_icon();
  user enable_special_ammo();
}

Use_dpad_minigun_turret(def, rank) {
  self thread minigun_turret_placed_listener(rank);
  self.carriedSentry[[level.sentry_setplaced_func]]();
  self EnableWeapons();

  self.carriedSentry = undefined;
  self.isCarrying = false;
  if(isDefined(self.last_weapon))
    self SwitchToWeapon(self.last_weapon);

  level thread maps\mp\alien\_music_and_dialog::playVOForSentry(self, "generic");
}

CancelUse_dpad_minigun_turret(def, rank) {
  if(isDefined(self.carriedSentry))
    self.carriedSentry[[level.sentry_setcancelled_func]]();
  self EnableWeapons();
  if(isDefined(self.last_weapon))
    self SwitchToWeapon(self.last_weapon);
}

get_valid_minigun_turret_count() {
  my_sentry_list = get_all_my_sentry("minigun");
  return get_valid_equipment_count(my_sentry_list);
}

CanPurchase_dpad_ims(def, rank) {
  if(isDefined(self.imsList))
    valid_ims_count = get_valid_equipment_count(self.imsList);
  else
    valid_ims_count = 0;

  if(valid_ims_count > 0) {
    self iprintlnBold(&"ALIEN_COLLECTIBLES_MAX_IMS");
    return false;
  }

  return default_canPurchase(def, rank);
}

TryUse_dpad_ims(def, rank) {
  self.last_weapon = self GetCurrentWeapon();

  IMS_type = undefined;
  switch (rank) {
    case 0:
      IMS_type = "alien_ims";
      break;

    case 1:
      IMS_type = "alien_ims_1";
      break;

    case 2:
      IMS_type = "alien_ims_2";
      break;

    case 3:
      IMS_type = "alien_ims_3";
      break;

    case 4:
      IMS_type = "alien_ims_4";
      break;
  }

  imsForPlayer = maps\mp\killstreaks\_ims::createIMSForPlayer(IMS_type, self);
  self.carriedIMS = imsForPlayer;
  imsForPlayer.firstPlacement = true;
  self thread maps\mp\killstreaks\_ims::setCarryingIMS(imsForPlayer, true);

  if(IsSentient(self.carriedIMS)) {
    self.carriedIMS.threatbias = -3000;
  }
}

Use_dpad_ims(def, rank) {
  self EnableWeapons();

  self.carriedIms = undefined;
  self.isCarrying = false;
  if(isDefined(self.last_weapon))
    self SwitchToWeapon(self.last_weapon);
  self EnableWeaponSwitch();

  level thread maps\mp\alien\_music_and_dialog::PlayVOForIMS(self);
}

CancelUse_dpad_ims(def, rank) {
  self EnableWeapons();
  if(isDefined(self.last_weapon))
    self SwitchToWeapon(self.last_weapon);
}

ims_fire_cloud(targetpos, owner) {
  self endon("death");
  owner endon("disconnect");
  level endon("game_ended");

  imsFireCloudDuration = 9;

  if(owner maps\mp\alien\_persistence::is_upgrade_enabled("ims_fire_upgrade")) {
    level thread maps\mp\alien\_collectibles::fireCloudMonitor(owner, imsFireCloudDuration, targetpos);
    level thread maps\mp\alien\_collectibles::firecloudsfx(imsFireCloudDuration, targetpos);
  }

}

ims_grace_period_scalar(time, owner) {
  if(owner maps\mp\alien\_persistence::is_upgrade_enabled("ims_gracetime_upgrade"))
    time = time / 2;
  return time;
}

CanPurchase_dpad_backup_buddy(def, rank) {
  if(has_backup_uav()) {
    self iprintlnBold(&"ALIEN_COLLECTIBLES_MAX_DRONE");
    return false;
  }

  return default_canPurchase(def, rank);
}

TryUse_dpad_backup_buddy(def, rank) {
  self.picking_up_item = true;
  self.last_weapon = self GetCurrentWeapon();
  self _giveWeapon("mortar_detonator_mp");
  self SwitchToWeaponImmediate("mortar_detonator_mp");
  self thread maps\mp\alien\_collectibles::clear_item_pickup();
}

Use_dpad_backup_buddy(def, rank) {
  if(rank == 0) {
    self maps\mp\killstreaks\_ball_drone::useBallDrone("alien_ball_drone");
  }
  if(rank == 1) {
    self maps\mp\killstreaks\_ball_drone::useBallDrone("alien_ball_drone_1");
  }
  if(rank == 2) {
    self maps\mp\killstreaks\_ball_drone::useBallDrone("alien_ball_drone_2");
  }
  if(rank == 3) {
    self maps\mp\killstreaks\_ball_drone::useBallDrone("alien_ball_drone_3");
  }
  if(rank == 4) {
    self maps\mp\killstreaks\_ball_drone::useBallDrone("alien_ball_drone_4");
  }

  wait 0.1;

  self notify("action_use");

  if(is_true(self.drone_failed)) {
    self.drone_failed = undefined;
    self IPrintLnBold(&"ALIEN_COLLECTIBLES_REMOTE_TANK_CANNOT_PLACE");
    self give_player_currency(Ceil(def.upgrades[rank].cost));
  } else {
    level notify("dlc_vo_notify", "online_vulture", self);
    if(!isDefined(level.use_dlc_vo))
      level thread maps\mp\alien\_music_and_dialog::PlayVOForDrone(self);
  }
  self TakeWeapon("mortar_detonator_mp");
  if(isDefined(self.last_weapon))
    self SwitchToWeapon(self.last_weapon);
}

CancelUse_dpad_backup_buddy(def, rank) {
  self TakeWeapon("mortar_detonator_mp");
  self.deployable = false;
  if(isDefined(self.last_weapon))
    self SwitchToWeapon(self.last_weapon);
  return true;
}

ball_drone_timeout_scalar(timeout, owner) {
  if(owner maps\mp\alien\_persistence::is_upgrade_enabled("vulture_duration_upgrade"))
    timeout = timeout * 1.5;
  return timeout;
}

ball_drone_fire_rocket_scalar(waittime, owner) {
  if(owner maps\mp\alien\_persistence::is_upgrade_enabled("vulture_duration_upgrade"))
    waittime = waittime * 0.6;
  return waittime;
}

TryUse_dpad_airstrike(def, rank) {
  self.last_weapon = self GetCurrentWeapon();
  self _giveWeapon("mortar_detonator_mp");
  self SwitchToWeaponImmediate("mortar_detonator_mp");
}

Use_dpad_airstrike(def, rank) {
  level thread maps\mp\alien\_music_and_dialog::PlayVOForMortarStrike(self);
  self TakeWeapon("mortar_detonator_mp");
  if(isDefined(self.last_weapon))
    self SwitchToWeapon(self.last_weapon);
  doMortar(rank);
}

CancelUse_dpad_airstrike(def, rank) {
  self TakeWeapon("mortar_detonator_mp");
  if(isDefined(self.last_weapon))
    self SwitchToWeapon(self.last_weapon);
  return true;
}

doMortar(rank) {
  mortar_count = 2;
  mortarDamageRadius = 300;
  mortarDamageMin = 1000;
  mortarDamageMax = 4000;

  if(rank == 0) {
    mortar_count = 3;
    mortarDamageRadius = 200;
    mortarDamageMin = 500;
    mortarDamageMax = 1000;
  }
  if(rank == 1) {
    mortar_count = 4;
    mortarDamageRadius = 200;
    mortarDamageMin = 500;
    mortarDamageMax = 1000;
  }
  if(rank == 2) {
    mortar_count = 4;
    mortarDamageRadius = 256;
    mortarDamageMin = 500;
    mortarDamageMax = 1500;
  }
  if(rank == 3) {
    mortar_count = 5;
    mortarDamageRadius = 350;
    mortarDamageMin = 500;
    mortarDamageMax = 1500;
  }
  if(rank == 4) {
    mortar_count = 6;
    mortarDamageRadius = 350;
    mortarDamageMin = 1000;
    mortarDamageMax = 2000;
  }

  offset = 1;
  mortarTarget = self.origin;
  for(i = 0; i < mortar_count; i++) {
    traceData = bulletTrace(mortarTarget + (0, 0, 500), mortarTarget - (0, 0, 500), false);
    if(isDefined(traceData["position"])) {
      playFX(level.mortar_fx["tracer"], mortarTarget);
      thread playSoundinSpace("fast_artillery_round", mortarTarget);

      wait(RandomFloatRange(0.5, 1.5));

      playFX(level.mortar_fx["explosion"], mortarTarget);
      RadiusDamage(self.origin, mortarDamageRadius, mortarDamageMax, mortarDamageMin, self, "MOD_EXPLOSIVE", "alienmortar_strike_mp");
      PlayRumbleOnPosition("grenade_rumble", mortarTarget);
      Earthquake(1.0, 0.6, mortarTarget, 2000);
      thread playSoundinSpace("exp_suitcase_bomb_main", mortarTarget);
      physicsExplosionSphere(mortarTarget + (0, 0, 30), 250, 125, 2);

      offset *= -1;
    }
    mortarTarget = self.origin + (RandomIntRange(100, 600) * offset, RandomIntRange(100, 600) * offset, 0);
  }
}

BOX_TYPE_SPECIALAMMO_STUN = "deployable_specialammo";
TryUse_dpad_team_specialammo(def, rank) {
  self default_TryUse_dpad_team_specialammo(rank, BOX_TYPE_SPECIALAMMO_STUN);
}

deployable_specialammo_placed_listener() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  self waittill("new_deployable_box", box);
  self track_deployables(box);
  box setCanDamage(false);
  box setCanRadiusDamage(false);
}

Use_dpad_team_specialammo(def, rank) {
  self thread deployable_specialammo_placed_listener();
  self.deployable = false;

  level thread maps\mp\alien\_music_and_dialog::PlayVOForSpecialAmmo(self);
}

BOX_TYPE_SPECIALAMMO_EXPLO = "deployable_specialammo_explo";
TryUse_dpad_team_specialammo_explo(def, rank) {
  self default_TryUse_dpad_team_specialammo(rank, BOX_TYPE_SPECIALAMMO_EXPLO);
}

Use_dpad_team_specialammo_explo(def, rank) {
  self thread deployable_specialammo_placed_listener();
  self.deployable = false;

  level notify("dlc_vo_notify", "ready_explosiverounds", self);
  if(!isDefined(level.use_dlc_vo))
    level thread maps\mp\alien\_music_and_dialog::PlayVOForSpecialAmmo(self);
}

BOX_TYPE_SPECIALAMMO_AP = "deployable_specialammo_ap";
TryUse_dpad_team_specialammo_ap(def, rank) {
  self default_TryUse_dpad_team_specialammo(rank, BOX_TYPE_SPECIALAMMO_AP);
}

BOX_TYPE_SPECIALAMMO_IN = "deployable_specialammo_in";
TryUse_dpad_team_specialammo_in(def, rank) {
  self default_TryUse_dpad_team_specialammo(rank, BOX_TYPE_SPECIALAMMO_IN);
}

Use_dpad_team_specialammo_in(def, rank) {
  self thread deployable_specialammo_placed_listener();
  self.deployable = false;

  level notify("dlc_vo_notify", "ready_incendiaryrounds", self);
  if(!isDefined(level.use_dlc_vo))
    level thread maps\mp\alien\_music_and_dialog::PlayVOForSpecialAmmo(self);
}

BOX_TYPE_SPECIALAMMO_COMB = "deployable_specialammo_comb";
TryUse_dpad_team_specialammo_comb(def, rank) {
  self default_TryUse_dpad_team_specialammo(rank, BOX_TYPE_SPECIALAMMO_COMB);
}

Use_dpad_team_specialammo_comb(def, rank) {
  self thread deployable_combinedammo_placed_listener();
  self.deployable = false;

  level notify("dlc_vo_notify", "ready_explosiverounds", self);
  if(!isDefined(level.use_dlc_vo))
    level thread maps\mp\alien\_music_and_dialog::PlayVOForSpecialAmmo(self);
}

deployable_combinedammo_placed_listener() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  self waittill("new_deployable_box", box);
  self track_deployables(box);
  box setCanDamage(false);
  box setCanRadiusDamage(false);
  if(box.upgrade_rank == 4) {
    box thread team_combined_ammo_regen();
  }
}

team_combined_ammo_regen() {
  self endon("death");
  self endon("ammo_regen_timeout");
  AMMO_REGEN_RADIUS_SQR = 65536.0;
  AMMO_REGEN_RATE = 0.1;

  while(1) {
    foreach(player in level.players) {
      if(isAlive(player) && DistanceSquared(self.origin, player.origin) < AMMO_REGEN_RADIUS_SQR) {
        player maps\mp\alien\_deployablebox_functions::addRatioMaxStockCombinedToAllWeapons(AMMO_REGEN_RATE);
      }
      wait 5.0;
    }
  }
}

TryUse_dpad_war_machine(def, rank) {
  self thread TryUse_dpad_war_machine_Internal(def, rank);
}

TryUse_dpad_war_machine_Internal(def, rank) {
  waittillframeend;
  self store_weapons_status();
  self.last_weapon = self GetCurrentWeapon();
  weaponname = "iw6_alienmk32_mp";
  switch (rank) {
    case 0:
      weaponname = "iw6_alienmk32_mp";
      break;
    case 1:
      weaponname = "iw6_alienmk321_mp";
      break;
    case 2:
      weaponname = "iw6_alienmk322_mp";
      break;
    case 3:
      weaponname = "iw6_alienmk323_mp";
      break;
    case 4:
      weaponname = "iw6_alienmk324_mp";
      break;
  }

  self _giveWeapon(weaponname);
  wait 0.05;
  self SwitchToWeapon(weaponname);
  self disableWeaponSwitch();
}

Use_dpad_war_machine(def, rank) {
  weaponname = "iw6_alienmk32_mp";
  switch (rank) {
    case 0:
      weaponname = "iw6_alienmk32_mp";
      break;
    case 1:
      weaponname = "iw6_alienmk321_mp";
      break;
    case 2:
      weaponname = "iw6_alienmk322_mp";
      break;
    case 3:
      weaponname = "iw6_alienmk323_mp";
      break;
    case 4:
      weaponname = "iw6_alienmk324_mp";
      break;
  }

  self notify("dlc_vo_notify", "online_mk32", self);
  self thread watch_ammo(weaponname);
  if(!isDefined(level.use_dlc_vo))
    level thread maps\mp\alien\_music_and_dialog::PlayVOForWarMachine(self);
}

CancelUse_dpad_war_machine(def, rank) {
  self endon("disconnect");

  self wait_to_cancel_dpad_weapon();

  weaponname = "iw6_alienmk32_mp";
  switch (rank) {
    case 0:
      weaponname = "iw6_alienmk32_mp";
      break;
    case 1:
      weaponname = "iw6_alienmk321_mp";
      break;
    case 2:
      weaponname = "iw6_alienmk322_mp";
      break;
    case 3:
      weaponname = "iw6_alienmk323_mp";
      break;
    case 4:
      weaponname = "iw6_alienmk324_mp";
      break;
  }

  self takeweapon(weaponname);

  if(!isDefined(level.drill_carrier) || (isDefined(level.drill_carrier) && self != level.drill_carrier)) {
    self SwitchToWeapon(self.last_weapon);
    self EnableWeaponSwitch();
  }
}

TryUse_dpad_death_machine(def, rank) {
  self thread TryUse_dpad_death_machine_Internal(def, rank);
}

TryUse_dpad_death_machine_Internal(def, rank) {
  waittillframeend;
  self store_weapons_status();
  self.last_weapon = self GetCurrentWeapon();
  weaponname = "iw6_alienminigun_mp";
  switch (rank) {
    case 0:
      weaponname = "iw6_alienminigun_mp";
      break;
    case 1:
      weaponname = "iw6_alienminigun1_mp";
      break;
    case 2:
      weaponname = "iw6_alienminigun2_mp";
      break;
    case 3:
      weaponname = "iw6_alienminigun3_mp";
      break;
    case 4:
      weaponname = "iw6_alienminigun4_mp";
      break;
  }

  self _giveWeapon(weaponname);
  wait 0.05;
  self SwitchToWeapon(weaponname);
  self disableWeaponSwitch();
}

Use_dpad_death_machine(def, rank) {
  weaponname = "iw6_alienminigun_mp";
  switch (rank) {
    case 0:
      weaponname = "iw6_alienminigun_mp";
      break;
    case 1:
      weaponname = "iw6_alienminigun1_mp";
      break;
    case 2:
      weaponname = "iw6_alienminigun2_mp";
      break;
    case 3:
      weaponname = "iw6_alienminigun3_mp";
      break;
    case 4:
      weaponname = "iw6_alienminigun4_mp";
      break;
  }

  self thread watch_ammo(weaponname);
  level thread maps\mp\alien\_music_and_dialog::PlayVOForDeathMachine(self);
}
CancelUse_dpad_death_machine(def, rank) {
  self endon("disconnect");

  self wait_to_cancel_dpad_weapon();

  weaponname = "iw6_alienminigun_mp";
  switch (rank) {
    case 0:
      weaponname = "iw6_alienminigun_mp";
      break;
    case 1:
      weaponname = "iw6_alienminigun1_mp";
      break;
    case 2:
      weaponname = "iw6_alienminigun2_mp";
      break;
    case 3:
      weaponname = "iw6_alienminigun3_mp";
      break;
    case 4:
      weaponname = "iw6_alienminigun4_mp";
      break;
  }

  self takeweapon(weaponname);

  if(!isDefined(level.drill_carrier) || (isDefined(level.drill_carrier) && self != level.drill_carrier)) {
    self SwitchToWeapon(self.last_weapon);
    self EnableWeaponSwitch();
  }
}

wait_to_cancel_dpad_weapon() {
  self endon("disconnect");

  timeout = gettime() + 1000;
  while(!self has_special_weapon() || timeout < gettime())
    wait(.05);
}

watch_ammo(weapName) {
  self notify("watchammo");
  self endon("watchammo");

  level endon("game_ended");
  self endon("disconnect");

  starting_ammo = self GetAmmoCount(weapName);

  while(true) {
    ammo_count = self GetAmmoCount(weapName);

    if(ammo_count == starting_ammo - 1) {
      self notify("fired_ability_gun");
    }

    if(ammo_count == 0) {
      self takeweapon(weapName);
      self SwitchToWeapon(self.last_weapon);
      self EnableWeaponSwitch();
      break;
    }
    wait 0.05;
  }
}

TryUse_dpad_predator(def, rank) {
  if(isDefined(level.alternate_trinity_weapon_try_use)) {
    [[level.alternate_trinity_weapon_try_use]](def, rank);

    return true;
  }

  self.last_weapon = self GetCurrentWeapon();
  self _giveWeapon("switchblade_laptop_mp");
  self SwitchToWeaponImmediate("switchblade_laptop_mp");
}

Use_dpad_predator(def, rank) {
  if(isDefined(level.alternate_trinity_weapon_use)) {
    [[level.alternate_trinity_weapon_use]](def, rank);

    return true;
  }

  if(self is_in_laststand()) {
    return;
  }
  self.turn_off_class_skill_activation = true;

  num_missiles = 0;
  missile_name = "switchblade_rocket_mp";
  baby_missile_name = "switchblade_baby_mp";
  altitude = 14000;

  if(rank == 0) {
    num_missiles = 0;
  }
  if(rank == 1) {
    num_missiles = 0;
  }
  if(rank == 2) {
    num_missiles = 1;
  }
  if(rank == 3) {
    num_missiles = 2;
    altitude = 16000;
    baby_missile_name = "switchblade_babyfast_mp";
  }
  if(rank == 4) {
    num_missiles = 4;
    altitude = 18000;
    baby_missile_name = "switchblade_babyfast_mp";
  }

  if(isDefined(level.tryUseDroneHive))
    self[[level.tryUseDroneHive]](rank, num_missiles, missile_name, altitude, baby_missile_name);

  wait 0.1;
}

CancelUse_dpad_predator(def, rank) {
  if(isDefined(level.alternate_trinity_weapon_cancel_use)) {
    [[level.alternate_trinity_weapon_cancel_use]](def, rank);

    return true;
  }
  self.turn_off_class_skill_activation = undefined;
  self TakeWeapon("switchblade_laptop_mp");
  if(isDefined(self.last_weapon))
    self SwitchToWeapon(self.last_weapon);
  return true;
}

alien_beginDeployableViaMarker(lifeId, boxType) {
  self endon("death");
  self endon("disconnect");
  self endon("cancel_deployable_via_marker");
  level endon("game_ended");

  self waittill("grenade_fire", marker, weapName);
  if(weapName != "aliendeployable_crate_marker_mp") {
    return false;
  }
  self.marker = marker;
  self takeDeployableOnStuck(marker, weapName, boxType);

  marker.owner = self;
  marker.weaponName = weapName;
  marker thread maps\mp\alien\_deployablebox::markerActivate(lifeId, boxType, maps\mp\alien\_deployablebox::box_setActive);

  return true;
}

takeDeployableOnStuck(weap, weapName, boxType) {
  weap playSoundToPlayer(level.boxSettings[boxType].deployedSfx, self);

  if(self HasWeapon(weapName)) {
    self TakeWeapon(weapName);
    self SwitchToWeapon(self getLastWeapon());
  }
}

common_TryUse_actions() {
  self.last_weapon = self GetCurrentWeapon();
  self GiveWeapon("aliendeployable_crate_marker_mp");
  self SwitchToWeapon("aliendeployable_crate_marker_mp");
  self.deployable = true;
}

get_valid_equipment_count(equipment_list) {
  valid_count = 0;
  foreach(equipment in equipment_list) {
    if(equipment is_equipment_valid(self))
      valid_count++;
  }
  return valid_count;
}

get_all_my_sentry(streakname) {
  result = [];

  foreach(turret in level.turrets) {
    if(isAlive(turret) && level.sentrySettings[turret.sentrytype].streakname == streakname && ((isDefined(turret.originalowner) && turret.originalowner == self) || turret.owner == self))
      result[result.size] = turret;
  }

  return result;
}

is_equipment_valid(owner) {
  VALID_PROXIMITY = 360000;

  if(!isDefined(self) || !isAlive(self) || isDefined(self.deleting))
    return false;

  if(distanceSquared(self.origin, owner.origin) < VALID_PROXIMITY)
    return true;

  owner_world_area = owner get_in_world_area();

  if(isDefined(self.in_world_area))
    equipment_world_area = self.in_world_area;
  else
    equipment_world_area = self get_in_world_area();

  if(equipment_world_area == owner_world_area)
    return true;

  return false;
}

manage_sentry_count(rank, streakname) {
  wait 2.0;
  max_sentry_count = get_max_sentry_count(rank, streakname);
  switch (streakname) {
    case "sentry":
      my_sentry_list = get_all_my_sentry("sentry");
      break;
    case "grenade":
      my_sentry_list = get_all_my_sentry("grenade");
      break;
    case "minigun":
      my_sentry_list = get_all_my_sentry("minigun");
      break;
    default:
      my_sentry_list = get_all_my_sentry("sentry");
  }
  quantity_to_remove = my_sentry_list.size - max_sentry_count;

  if(quantity_to_remove > 0)
    remove_extra_equipment(my_sentry_list, quantity_to_remove);
}

remove_extra_equipment(item_list, quantity_to_remove) {
  for(i = 0; i < quantity_to_remove; i++) {
    equipment_to_remove = GetFarthest(self.origin, item_list);
    item_list = array_remove(item_list, equipment_to_remove);
    equipment_to_remove notify("death");
  }
}

get_max_sentry_count(rank, streakname) {
  if(streakname == "sentry") {
    switch (rank) {
      case 4:
        return 2;
      default:
        return 1;
    }
  } else
    return 1;
}

default_canUse(def) {
  if(self AttackButtonPressed()) {
    return false;
  }

  return alt_canUse(def);
}

alt_canUse(def) {
  if(isDefined(self.laststand) && self.laststand) {
    return false;
  }

  return true;
}

default_canPurchase(def, rank) {
  if(self is_holding_deployable()) {
    return false;
  }

  if(self has_special_weapon()) {
    return false;
  }

  if(isDefined(self.laststand) && self.laststand) {
    return false;
  }

  return true;
}

alt_canPurchase(def, rank) {
  if(self AttackButtonPressed()) {
    return false;
  }

  return default_canPurchase(def, rank);
}

default_TryUse_dpad_team_specialammo(rank, BOX_TYPE) {
  self.team_specialammo_rank = rank;
  self common_TryUse_actions();
  self thread maps\mp\alien\_deployablebox::default_tryUseDeployable(rank, BOX_TYPE);
}