/***********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\alien\_autosentry_alien.gsc
***********************************************/

#include maps\mp\_utility;
#include maps\mp\alien\_utility;
#include maps\mp\gametypes\_hud_util;
#include common_scripts\utility;

init() {
  level._effect["sentry_overheat_mp"] = loadfx("vfx/gameplay/mp/killstreaks/vfx_sg_overheat_smoke");
  level._effect["sentry_explode_mp"] = loadfx("vfx/gameplay/mp/killstreaks/vfx_ims_explosion");
  level._effect["sentry_smoke_mp"] = loadfx("vfx/gameplay/mp/killstreaks/vfx_sg_damage_blacksmoke");

  level.sentrySettings = [];
  level.sentrySettings["alien_sentry"] = spawnStruct();
  level.sentrySettings["alien_sentry"].health = 999999;
  level.sentrySettings["alien_sentry"].maxHealth = 300;
  level.sentrySettings["alien_sentry"].burstMin = 5;
  level.sentrySettings["alien_sentry"].burstMax = 40;
  level.sentrySettings["alien_sentry"].pauseMin = 0.15;
  level.sentrySettings["alien_sentry"].pauseMax = 0.35;
  level.sentrySettings["alien_sentry"].sentryModeOn = "sentry";
  level.sentrySettings["alien_sentry"].sentryModeOff = "sentry_offline";
  level.sentrySettings["alien_sentry"].timeOut = 600.0;
  level.sentrySettings["alien_sentry"].spinupTime = 1.0;
  level.sentrySettings["alien_sentry"].overheatTime = 5.0;
  level.sentrySettings["alien_sentry"].cooldownTime = 0.1;
  level.sentrySettings["alien_sentry"].fxTime = 0.3;
  level.sentrySettings["alien_sentry"].streakName = "sentry";
  level.sentrySettings["alien_sentry"].weaponInfo = "alien_sentry_minigun_1_mp";
  level.sentrySettings["alien_sentry"].modelBase = "weapon_sentry_chaingun";
  level.sentrySettings["alien_sentry"].modelPlacement = "weapon_sentry_chaingun_obj";
  level.sentrySettings["alien_sentry"].modelPlacementFailed = "weapon_sentry_chaingun_obj_red";
  level.sentrySettings["alien_sentry"].modelDestroyed = "weapon_sentry_chaingun_destroyed";
  level.sentrySettings["alien_sentry"].hintString = &"SENTRY_PICKUP";
  level.sentrySettings["alien_sentry"].headIcon = true;
  level.sentrySettings["alien_sentry"].teamSplash = "used_sentry";
  level.sentrySettings["alien_sentry"].shouldSplash = false;
  level.sentrySettings["alien_sentry"].voDestroyed = "sentry_destroyed";
  level.sentrySettings["alien_sentry"].isSentient = true;

  level.sentrySettings["alien_sentry_1"] = spawnStruct();
  level.sentrySettings["alien_sentry_1"].health = 999999;
  level.sentrySettings["alien_sentry_1"].maxHealth = 300;
  level.sentrySettings["alien_sentry_1"].burstMin = 5;
  level.sentrySettings["alien_sentry_1"].burstMax = 40;
  level.sentrySettings["alien_sentry_1"].pauseMin = 0.15;
  level.sentrySettings["alien_sentry_1"].pauseMax = 0.35;
  level.sentrySettings["alien_sentry_1"].sentryModeOn = "sentry";
  level.sentrySettings["alien_sentry_1"].sentryModeOff = "sentry_offline";
  level.sentrySettings["alien_sentry_1"].timeOut = 600.0;
  level.sentrySettings["alien_sentry_1"].spinupTime = 1.0;
  level.sentrySettings["alien_sentry_1"].overheatTime = 5.0;
  level.sentrySettings["alien_sentry_1"].cooldownTime = 0.1;
  level.sentrySettings["alien_sentry_1"].fxTime = 0.3;
  level.sentrySettings["alien_sentry_1"].streakName = "sentry";
  level.sentrySettings["alien_sentry_1"].weaponInfo = "alien_sentry_minigun_2_mp";
  level.sentrySettings["alien_sentry_1"].modelBase = "weapon_sentry_chaingun";
  level.sentrySettings["alien_sentry_1"].modelPlacement = "weapon_sentry_chaingun_obj";
  level.sentrySettings["alien_sentry_1"].modelPlacementFailed = "weapon_sentry_chaingun_obj_red";
  level.sentrySettings["alien_sentry_1"].modelDestroyed = "weapon_sentry_chaingun_destroyed";
  level.sentrySettings["alien_sentry_1"].hintString = &"SENTRY_PICKUP";
  level.sentrySettings["alien_sentry_1"].headIcon = true;
  level.sentrySettings["alien_sentry_1"].teamSplash = "used_sentry";
  level.sentrySettings["alien_sentry_1"].shouldSplash = false;
  level.sentrySettings["alien_sentry_1"].voDestroyed = "sentry_destroyed";
  level.sentrySettings["alien_sentry_1"].isSentient = true;

  level.sentrySettings["alien_sentry_2"] = spawnStruct();
  level.sentrySettings["alien_sentry_2"].health = 999999;
  level.sentrySettings["alien_sentry_2"].maxHealth = 300;
  level.sentrySettings["alien_sentry_2"].burstMin = 10;
  level.sentrySettings["alien_sentry_2"].burstMax = 80;
  level.sentrySettings["alien_sentry_2"].pauseMin = 0.15;
  level.sentrySettings["alien_sentry_2"].pauseMax = 0.25;
  level.sentrySettings["alien_sentry_2"].sentryModeOn = "sentry";
  level.sentrySettings["alien_sentry_2"].sentryModeOff = "sentry_offline";
  level.sentrySettings["alien_sentry_2"].timeOut = 600.0;
  level.sentrySettings["alien_sentry_2"].spinupTime = 1.0;
  level.sentrySettings["alien_sentry_2"].overheatTime = 5.0;
  level.sentrySettings["alien_sentry_2"].cooldownTime = 0.2;
  level.sentrySettings["alien_sentry_2"].fxTime = 0.3;
  level.sentrySettings["alien_sentry_2"].streakName = "sentry";
  level.sentrySettings["alien_sentry_2"].weaponInfo = "alien_sentry_minigun_3_mp";
  level.sentrySettings["alien_sentry_2"].modelBase = "weapon_sentry_chaingun";
  level.sentrySettings["alien_sentry_2"].modelPlacement = "weapon_sentry_chaingun_obj";
  level.sentrySettings["alien_sentry_2"].modelPlacementFailed = "weapon_sentry_chaingun_obj_red";
  level.sentrySettings["alien_sentry_2"].modelDestroyed = "weapon_sentry_chaingun_destroyed";
  level.sentrySettings["alien_sentry_2"].hintString = &"SENTRY_PICKUP";
  level.sentrySettings["alien_sentry_2"].headIcon = true;
  level.sentrySettings["alien_sentry_2"].teamSplash = "used_sentry";
  level.sentrySettings["alien_sentry_2"].shouldSplash = false;
  level.sentrySettings["alien_sentry_2"].voDestroyed = "sentry_destroyed";
  level.sentrySettings["alien_sentry_2"].isSentient = true;

  level.sentrySettings["alien_sentry_3"] = spawnStruct();
  level.sentrySettings["alien_sentry_3"].health = 999999;
  level.sentrySettings["alien_sentry_3"].maxHealth = 300;
  level.sentrySettings["alien_sentry_3"].burstMin = 10;
  level.sentrySettings["alien_sentry_3"].burstMax = 80;
  level.sentrySettings["alien_sentry_3"].pauseMin = 0.15;
  level.sentrySettings["alien_sentry_3"].pauseMax = 0.25;
  level.sentrySettings["alien_sentry_3"].sentryModeOn = "sentry";
  level.sentrySettings["alien_sentry_3"].sentryModeOff = "sentry_offline";
  level.sentrySettings["alien_sentry_3"].timeOut = 600.0;
  level.sentrySettings["alien_sentry_3"].spinupTime = 1.0;
  level.sentrySettings["alien_sentry_3"].overheatTime = 5.0;
  level.sentrySettings["alien_sentry_3"].cooldownTime = 0.2;
  level.sentrySettings["alien_sentry_3"].fxTime = 0.3;
  level.sentrySettings["alien_sentry_3"].streakName = "sentry";
  level.sentrySettings["alien_sentry_3"].weaponInfo = "alien_sentry_minigun_4_mp";
  level.sentrySettings["alien_sentry_3"].modelBase = "weapon_sentry_chaingun";
  level.sentrySettings["alien_sentry_3"].modelPlacement = "weapon_sentry_chaingun_obj";
  level.sentrySettings["alien_sentry_3"].modelPlacementFailed = "weapon_sentry_chaingun_obj_red";
  level.sentrySettings["alien_sentry_3"].modelDestroyed = "weapon_sentry_chaingun_destroyed";
  level.sentrySettings["alien_sentry_3"].hintString = &"SENTRY_PICKUP";
  level.sentrySettings["alien_sentry_3"].headIcon = true;
  level.sentrySettings["alien_sentry_3"].teamSplash = "used_sentry";
  level.sentrySettings["alien_sentry_3"].shouldSplash = false;
  level.sentrySettings["alien_sentry_3"].voDestroyed = "sentry_destroyed";
  level.sentrySettings["alien_sentry_3"].isSentient = true;

  level.sentrySettings["alien_sentry_4"] = spawnStruct();
  level.sentrySettings["alien_sentry_4"].health = 999999;
  level.sentrySettings["alien_sentry_4"].maxHealth = 300;
  level.sentrySettings["alien_sentry_4"].burstMin = 10;
  level.sentrySettings["alien_sentry_4"].burstMax = 80;
  level.sentrySettings["alien_sentry_4"].pauseMin = 0.15;
  level.sentrySettings["alien_sentry_4"].pauseMax = 0.25;
  level.sentrySettings["alien_sentry_4"].sentryModeOn = "sentry";
  level.sentrySettings["alien_sentry_4"].sentryModeOff = "sentry_offline";
  level.sentrySettings["alien_sentry_4"].timeOut = 600.0;
  level.sentrySettings["alien_sentry_4"].spinupTime = 1.0;
  level.sentrySettings["alien_sentry_4"].overheatTime = 6.0;
  level.sentrySettings["alien_sentry_4"].cooldownTime = 0.2;
  level.sentrySettings["alien_sentry_4"].fxTime = 0.3;
  level.sentrySettings["alien_sentry_4"].streakName = "sentry";
  level.sentrySettings["alien_sentry_4"].weaponInfo = "alien_sentry_minigun_4_mp";
  level.sentrySettings["alien_sentry_4"].modelBase = "weapon_sentry_chaingun";
  level.sentrySettings["alien_sentry_4"].modelPlacement = "weapon_sentry_chaingun_obj";
  level.sentrySettings["alien_sentry_4"].modelPlacementFailed = "weapon_sentry_chaingun_obj_red";
  level.sentrySettings["alien_sentry_4"].modelDestroyed = "weapon_sentry_chaingun_destroyed";
  level.sentrySettings["alien_sentry_4"].hintString = &"SENTRY_PICKUP";
  level.sentrySettings["alien_sentry_4"].headIcon = true;
  level.sentrySettings["alien_sentry_4"].teamSplash = "used_sentry";
  level.sentrySettings["alien_sentry_4"].shouldSplash = false;
  level.sentrySettings["alien_sentry_4"].voDestroyed = "sentry_destroyed";
  level.sentrySettings["alien_sentry_4"].isSentient = true;

  level.sentrySettings["gl_turret"] = spawnStruct();
  level.sentrySettings["gl_turret"].health = 999999;
  level.sentrySettings["gl_turret"].maxHealth = 650;
  level.sentrySettings["gl_turret"].burstMin = 20;
  level.sentrySettings["gl_turret"].burstMax = 130;
  level.sentrySettings["gl_turret"].pauseMin = 0.15;
  level.sentrySettings["gl_turret"].pauseMax = 0.35;
  level.sentrySettings["gl_turret"].sentryModeOn = "manual";
  level.sentrySettings["gl_turret"].sentryModeOff = "sentry_offline";
  level.sentrySettings["gl_turret"].timeOut = 600.0;
  level.sentrySettings["gl_turret"].spinupTime = 0.05;
  level.sentrySettings["gl_turret"].overheatTime = 2.5;
  level.sentrySettings["gl_turret"].cooldownTime = 0.5;
  level.sentrySettings["gl_turret"].fxTime = 0.3;
  level.sentrySettings["gl_turret"].streakName = "grenade";
  level.sentrySettings["gl_turret"].weaponInfo = "alien_manned_gl_turret_mp";
  level.sentrySettings["gl_turret"].modelBase = "weapon_standing_turret_grenade_launcher";
  level.sentrySettings["gl_turret"].modelPlacement = "weapon_standing_turret_grenade_launcher_obj";
  level.sentrySettings["gl_turret"].modelPlacementFailed = "weapon_standing_turret_grenade_launcher_obj_red";
  level.sentrySettings["gl_turret"].modelDestroyed = "weapon_sentry_chaingun_destroyed";
  level.sentrySettings["gl_turret"].hintString = &"ALIEN_COLLECTIBLES_USE_TURRET";
  level.sentrySettings["gl_turret"].ownerHintString = &"ALIEN_COLLECTIBLES_DOUBLE_TAP_TO_CARRY";
  level.sentrySettings["gl_turret"].headIcon = false;
  level.sentrySettings["gl_turret"].teamSplash = "used_gl_turret";
  level.sentrySettings["gl_turret"].shouldSplash = true;
  level.sentrySettings["gl_turret"].voDestroyed = "sentry_destroyed";
  level.sentrySettings["gl_turret"].isSentient = false;

  level.sentrySettings["gl_turret_1"] = spawnStruct();
  level.sentrySettings["gl_turret_1"].health = 999999;
  level.sentrySettings["gl_turret_1"].maxHealth = 650;
  level.sentrySettings["gl_turret_1"].burstMin = 20;
  level.sentrySettings["gl_turret_1"].burstMax = 130;
  level.sentrySettings["gl_turret_1"].pauseMin = 0.15;
  level.sentrySettings["gl_turret_1"].pauseMax = 0.35;
  level.sentrySettings["gl_turret_1"].sentryModeOn = "manual";
  level.sentrySettings["gl_turret_1"].sentryModeOff = "sentry_offline";
  level.sentrySettings["gl_turret_1"].timeOut = 600.0;
  level.sentrySettings["gl_turret_1"].spinupTime = 0.05;
  level.sentrySettings["gl_turret_1"].overheatTime = 2.5;
  level.sentrySettings["gl_turret_1"].cooldownTime = 0.5;
  level.sentrySettings["gl_turret_1"].fxTime = 0.3;
  level.sentrySettings["gl_turret_1"].streakName = "grenade";
  level.sentrySettings["gl_turret_1"].weaponInfo = "alien_manned_gl_turret1_mp";
  level.sentrySettings["gl_turret_1"].modelBase = "weapon_standing_turret_grenade_launcher";
  level.sentrySettings["gl_turret_1"].modelPlacement = "weapon_standing_turret_grenade_launcher_obj";
  level.sentrySettings["gl_turret_1"].modelPlacementFailed = "weapon_standing_turret_grenade_launcher_obj_red";
  level.sentrySettings["gl_turret_1"].modelDestroyed = "weapon_sentry_chaingun_destroyed";
  level.sentrySettings["gl_turret_1"].hintString = &"ALIEN_COLLECTIBLES_USE_TURRET";
  level.sentrySettings["gl_turret_1"].ownerHintString = &"ALIEN_COLLECTIBLES_DOUBLE_TAP_TO_CARRY";
  level.sentrySettings["gl_turret_1"].headIcon = false;
  level.sentrySettings["gl_turret_1"].teamSplash = "used_gl_turret";
  level.sentrySettings["gl_turret_1"].shouldSplash = true;
  level.sentrySettings["gl_turret_1"].voDestroyed = "sentry_destroyed";
  level.sentrySettings["gl_turret_1"].isSentient = false;

  level.sentrySettings["gl_turret_2"] = spawnStruct();
  level.sentrySettings["gl_turret_2"].health = 999999;
  level.sentrySettings["gl_turret_2"].maxHealth = 650;
  level.sentrySettings["gl_turret_2"].burstMin = 20;
  level.sentrySettings["gl_turret_2"].burstMax = 130;
  level.sentrySettings["gl_turret_2"].pauseMin = 0.15;
  level.sentrySettings["gl_turret_2"].pauseMax = 0.35;
  level.sentrySettings["gl_turret_2"].sentryModeOn = "manual";
  level.sentrySettings["gl_turret_2"].sentryModeOff = "sentry_offline";
  level.sentrySettings["gl_turret_2"].timeOut = 600.0;
  level.sentrySettings["gl_turret_2"].spinupTime = 0.05;
  level.sentrySettings["gl_turret_2"].overheatTime = 2.5;
  level.sentrySettings["gl_turret_2"].cooldownTime = 0.5;
  level.sentrySettings["gl_turret_2"].fxTime = 0.3;
  level.sentrySettings["gl_turret_2"].streakName = "grenade";
  level.sentrySettings["gl_turret_2"].weaponInfo = "alien_manned_gl_turret2_mp";
  level.sentrySettings["gl_turret_2"].modelBase = "weapon_standing_turret_grenade_launcher";
  level.sentrySettings["gl_turret_2"].modelPlacement = "weapon_standing_turret_grenade_launcher_obj";
  level.sentrySettings["gl_turret_2"].modelPlacementFailed = "weapon_standing_turret_grenade_launcher_obj_red";
  level.sentrySettings["gl_turret_2"].modelDestroyed = "weapon_sentry_chaingun_destroyed";
  level.sentrySettings["gl_turret_2"].hintString = &"ALIEN_COLLECTIBLES_USE_TURRET";
  level.sentrySettings["gl_turret_2"].ownerHintString = &"ALIEN_COLLECTIBLES_DOUBLE_TAP_TO_CARRY";
  level.sentrySettings["gl_turret_2"].headIcon = false;
  level.sentrySettings["gl_turret_2"].teamSplash = "used_gl_turret";
  level.sentrySettings["gl_turret_2"].shouldSplash = true;
  level.sentrySettings["gl_turret_2"].voDestroyed = "sentry_destroyed";
  level.sentrySettings["gl_turret_2"].isSentient = false;

  level.sentrySettings["gl_turret_3"] = spawnStruct();
  level.sentrySettings["gl_turret_3"].health = 999999;
  level.sentrySettings["gl_turret_3"].maxHealth = 650;
  level.sentrySettings["gl_turret_3"].burstMin = 20;
  level.sentrySettings["gl_turret_3"].burstMax = 130;
  level.sentrySettings["gl_turret_3"].pauseMin = 0.15;
  level.sentrySettings["gl_turret_3"].pauseMax = 0.35;
  level.sentrySettings["gl_turret_3"].sentryModeOn = "manual";
  level.sentrySettings["gl_turret_3"].sentryModeOff = "sentry_offline";
  level.sentrySettings["gl_turret_3"].timeOut = 600.0;
  level.sentrySettings["gl_turret_3"].spinupTime = 0.05;
  level.sentrySettings["gl_turret_3"].overheatTime = 2.5;
  level.sentrySettings["gl_turret_3"].cooldownTime = 0.5;
  level.sentrySettings["gl_turret_3"].fxTime = 0.3;
  level.sentrySettings["gl_turret_3"].streakName = "grenade";
  level.sentrySettings["gl_turret_3"].weaponInfo = "alien_manned_gl_turret3_mp";
  level.sentrySettings["gl_turret_3"].modelBase = "weapon_standing_turret_grenade_launcher";
  level.sentrySettings["gl_turret_3"].modelPlacement = "weapon_standing_turret_grenade_launcher_obj";
  level.sentrySettings["gl_turret_3"].modelPlacementFailed = "weapon_standing_turret_grenade_launcher_obj_red";
  level.sentrySettings["gl_turret_3"].modelDestroyed = "weapon_sentry_chaingun_destroyed";
  level.sentrySettings["gl_turret_3"].hintString = &"ALIEN_COLLECTIBLES_USE_TURRET";
  level.sentrySettings["gl_turret_3"].ownerHintString = &"ALIEN_COLLECTIBLES_DOUBLE_TAP_TO_CARRY";
  level.sentrySettings["gl_turret_3"].headIcon = false;
  level.sentrySettings["gl_turret_3"].teamSplash = "used_gl_turret";
  level.sentrySettings["gl_turret_3"].shouldSplash = true;
  level.sentrySettings["gl_turret_3"].voDestroyed = "sentry_destroyed";
  level.sentrySettings["gl_turret_3"].isSentient = false;

  level.sentrySettings["gl_turret_4"] = spawnStruct();
  level.sentrySettings["gl_turret_4"].health = 999999;
  level.sentrySettings["gl_turret_4"].maxHealth = 650;
  level.sentrySettings["gl_turret_4"].burstMin = 20;
  level.sentrySettings["gl_turret_4"].burstMax = 130;
  level.sentrySettings["gl_turret_4"].pauseMin = 0.15;
  level.sentrySettings["gl_turret_4"].pauseMax = 0.35;
  level.sentrySettings["gl_turret_4"].sentryModeOn = "manual";
  level.sentrySettings["gl_turret_4"].sentryModeOff = "sentry_offline";
  level.sentrySettings["gl_turret_4"].timeOut = 600.0;
  level.sentrySettings["gl_turret_4"].spinupTime = 0.05;
  level.sentrySettings["gl_turret_4"].overheatTime = 2.5;
  level.sentrySettings["gl_turret_4"].cooldownTime = 0.5;
  level.sentrySettings["gl_turret_4"].fxTime = 0.3;
  level.sentrySettings["gl_turret_4"].streakName = "grenade";
  level.sentrySettings["gl_turret_4"].weaponInfo = "alien_manned_gl_turret4_mp";
  level.sentrySettings["gl_turret_4"].modelBase = "weapon_standing_turret_grenade_launcher";
  level.sentrySettings["gl_turret_4"].modelPlacement = "weapon_standing_turret_grenade_launcher_obj";
  level.sentrySettings["gl_turret_4"].modelPlacementFailed = "weapon_standing_turret_grenade_launcher_obj_red";
  level.sentrySettings["gl_turret_4"].modelDestroyed = "weapon_sentry_chaingun_destroyed";
  level.sentrySettings["gl_turret_4"].hintString = &"ALIEN_COLLECTIBLES_USE_TURRET";
  level.sentrySettings["gl_turret_4"].ownerHintString = &"ALIEN_COLLECTIBLES_DOUBLE_TAP_TO_CARRY";
  level.sentrySettings["gl_turret_4"].headIcon = false;
  level.sentrySettings["gl_turret_4"].teamSplash = "used_gl_turret";
  level.sentrySettings["gl_turret_4"].shouldSplash = true;
  level.sentrySettings["gl_turret_4"].voDestroyed = "sentry_destroyed";
  level.sentrySettings["gl_turret_4"].isSentient = false;

  level.sentrySettings["minigun_turret"] = spawnStruct();
  level.sentrySettings["minigun_turret"].health = 999999;
  level.sentrySettings["minigun_turret"].maxHealth = 650;
  level.sentrySettings["minigun_turret"].burstMin = 20;
  level.sentrySettings["minigun_turret"].burstMax = 130;
  level.sentrySettings["minigun_turret"].pauseMin = 0.15;
  level.sentrySettings["minigun_turret"].pauseMax = 0.35;
  level.sentrySettings["minigun_turret"].sentryModeOn = "manual";
  level.sentrySettings["minigun_turret"].sentryModeOff = "sentry_offline";
  level.sentrySettings["minigun_turret"].timeOut = 600.0;
  level.sentrySettings["minigun_turret"].spinupTime = 0.5;
  level.sentrySettings["minigun_turret"].overheatTime = 4.0;
  level.sentrySettings["minigun_turret"].cooldownTime = 0.5;
  level.sentrySettings["minigun_turret"].fxTime = 0.3;
  level.sentrySettings["minigun_turret"].streakName = "minigun";
  level.sentrySettings["minigun_turret"].weaponInfo = "alien_manned_minigun_turret_mp";
  level.sentrySettings["minigun_turret"].modelBase = "weapon_standing_turret_grenade_launcher";
  level.sentrySettings["minigun_turret"].modelPlacement = "weapon_standing_turret_grenade_launcher_obj";
  level.sentrySettings["minigun_turret"].modelPlacementFailed = "weapon_standing_turret_grenade_launcher_obj_red";
  level.sentrySettings["minigun_turret"].modelDestroyed = "weapon_sentry_chaingun_destroyed";
  level.sentrySettings["minigun_turret"].hintString = &"ALIEN_COLLECTIBLES_USE_TURRET";
  level.sentrySettings["minigun_turret"].ownerHintString = &"ALIEN_COLLECTIBLES_DOUBLE_TAP_TO_CARRY";
  level.sentrySettings["minigun_turret"].headIcon = false;
  level.sentrySettings["minigun_turret"].teamSplash = "used_minigun_turret";
  level.sentrySettings["minigun_turret"].shouldSplash = true;
  level.sentrySettings["minigun_turret"].voDestroyed = "sentry_destroyed";
  level.sentrySettings["minigun_turret"].isSentient = false;

  level.sentrySettings["minigun_turret_1"] = spawnStruct();
  level.sentrySettings["minigun_turret_1"].health = 999999;
  level.sentrySettings["minigun_turret_1"].maxHealth = 650;
  level.sentrySettings["minigun_turret_1"].burstMin = 20;
  level.sentrySettings["minigun_turret_1"].burstMax = 130;
  level.sentrySettings["minigun_turret_1"].pauseMin = 0.15;
  level.sentrySettings["minigun_turret_1"].pauseMax = 0.35;
  level.sentrySettings["minigun_turret_1"].sentryModeOn = "manual";
  level.sentrySettings["minigun_turret_1"].sentryModeOff = "sentry_offline";
  level.sentrySettings["minigun_turret_1"].timeOut = 600.0;
  level.sentrySettings["minigun_turret_1"].spinupTime = 0.05;
  level.sentrySettings["minigun_turret_1"].overheatTime = 4.0;
  level.sentrySettings["minigun_turret_1"].cooldownTime = 0.5;
  level.sentrySettings["minigun_turret_1"].fxTime = 0.3;
  level.sentrySettings["minigun_turret_1"].streakName = "minigun";
  level.sentrySettings["minigun_turret_1"].weaponInfo = "alien_manned_minigun_turret1_mp";
  level.sentrySettings["minigun_turret_1"].modelBase = "weapon_standing_turret_grenade_launcher";
  level.sentrySettings["minigun_turret_1"].modelPlacement = "weapon_standing_turret_grenade_launcher_obj";
  level.sentrySettings["minigun_turret_1"].modelPlacementFailed = "weapon_standing_turret_grenade_launcher_obj_red";
  level.sentrySettings["minigun_turret_1"].modelDestroyed = "weapon_sentry_chaingun_destroyed";
  level.sentrySettings["minigun_turret_1"].hintString = &"ALIEN_COLLECTIBLES_USE_TURRET";
  level.sentrySettings["minigun_turret_1"].ownerHintString = &"ALIEN_COLLECTIBLES_DOUBLE_TAP_TO_CARRY";
  level.sentrySettings["minigun_turret_1"].headIcon = false;
  level.sentrySettings["minigun_turret_1"].teamSplash = "used_minigun_turret";
  level.sentrySettings["minigun_turret_1"].shouldSplash = true;
  level.sentrySettings["minigun_turret_1"].voDestroyed = "sentry_destroyed";
  level.sentrySettings["minigun_turret_1"].isSentient = false;

  level.sentrySettings["minigun_turret_2"] = spawnStruct();
  level.sentrySettings["minigun_turret_2"].health = 999999;
  level.sentrySettings["minigun_turret_2"].maxHealth = 650;
  level.sentrySettings["minigun_turret_2"].burstMin = 20;
  level.sentrySettings["minigun_turret_2"].burstMax = 130;
  level.sentrySettings["minigun_turret_2"].pauseMin = 0.15;
  level.sentrySettings["minigun_turret_2"].pauseMax = 0.35;
  level.sentrySettings["minigun_turret_2"].sentryModeOn = "manual";
  level.sentrySettings["minigun_turret_2"].sentryModeOff = "sentry_offline";
  level.sentrySettings["minigun_turret_2"].timeOut = 600.0;
  level.sentrySettings["minigun_turret_2"].spinupTime = 0.05;
  level.sentrySettings["minigun_turret_2"].overheatTime = 4.0;
  level.sentrySettings["minigun_turret_2"].cooldownTime = 0.5;
  level.sentrySettings["minigun_turret_2"].fxTime = 0.3;
  level.sentrySettings["minigun_turret_2"].streakName = "minigun";
  level.sentrySettings["minigun_turret_2"].weaponInfo = "alien_manned_minigun_turret2_mp";
  level.sentrySettings["minigun_turret_2"].modelBase = "weapon_standing_turret_grenade_launcher";
  level.sentrySettings["minigun_turret_2"].modelPlacement = "weapon_standing_turret_grenade_launcher_obj";
  level.sentrySettings["minigun_turret_2"].modelPlacementFailed = "weapon_standing_turret_grenade_launcher_obj_red";
  level.sentrySettings["minigun_turret_2"].modelDestroyed = "weapon_sentry_chaingun_destroyed";
  level.sentrySettings["minigun_turret_2"].hintString = &"ALIEN_COLLECTIBLES_USE_TURRET";
  level.sentrySettings["minigun_turret_2"].ownerHintString = &"ALIEN_COLLECTIBLES_DOUBLE_TAP_TO_CARRY";
  level.sentrySettings["minigun_turret_2"].headIcon = false;
  level.sentrySettings["minigun_turret_2"].teamSplash = "used_minigun_turret";
  level.sentrySettings["minigun_turret_2"].shouldSplash = true;
  level.sentrySettings["minigun_turret_2"].voDestroyed = "sentry_destroyed";
  level.sentrySettings["minigun_turret_2"].isSentient = false;

  level.sentrySettings["minigun_turret_3"] = spawnStruct();
  level.sentrySettings["minigun_turret_3"].health = 999999;
  level.sentrySettings["minigun_turret_3"].maxHealth = 650;
  level.sentrySettings["minigun_turret_3"].burstMin = 20;
  level.sentrySettings["minigun_turret_3"].burstMax = 130;
  level.sentrySettings["minigun_turret_3"].pauseMin = 0.15;
  level.sentrySettings["minigun_turret_3"].pauseMax = 0.35;
  level.sentrySettings["minigun_turret_3"].sentryModeOn = "manual";
  level.sentrySettings["minigun_turret_3"].sentryModeOff = "sentry_offline";
  level.sentrySettings["minigun_turret_3"].timeOut = 600.0;
  level.sentrySettings["minigun_turret_3"].spinupTime = 0.05;
  level.sentrySettings["minigun_turret_3"].overheatTime = 4.0;
  level.sentrySettings["minigun_turret_3"].cooldownTime = 0.5;
  level.sentrySettings["minigun_turret_3"].fxTime = 0.3;
  level.sentrySettings["minigun_turret_3"].streakName = "minigun";
  level.sentrySettings["minigun_turret_3"].weaponInfo = "alien_manned_minigun_turret3_mp";
  level.sentrySettings["minigun_turret_3"].modelBase = "weapon_standing_turret_grenade_launcher";
  level.sentrySettings["minigun_turret_3"].modelPlacement = "weapon_standing_turret_grenade_launcher_obj";
  level.sentrySettings["minigun_turret_3"].modelPlacementFailed = "weapon_standing_turret_grenade_launcher_obj_red";
  level.sentrySettings["minigun_turret_3"].modelDestroyed = "weapon_sentry_chaingun_destroyed";
  level.sentrySettings["minigun_turret_3"].hintString = &"ALIEN_COLLECTIBLES_USE_TURRET";
  level.sentrySettings["minigun_turret_3"].ownerHintString = &"ALIEN_COLLECTIBLES_DOUBLE_TAP_TO_CARRY";
  level.sentrySettings["minigun_turret_3"].headIcon = false;
  level.sentrySettings["minigun_turret_3"].teamSplash = "used_minigun_turret";
  level.sentrySettings["minigun_turret_3"].shouldSplash = true;
  level.sentrySettings["minigun_turret_3"].voDestroyed = "sentry_destroyed";
  level.sentrySettings["minigun_turret_3"].isSentient = false;

  level.sentrySettings["minigun_turret_4"] = spawnStruct();
  level.sentrySettings["minigun_turret_4"].health = 999999;
  level.sentrySettings["minigun_turret_4"].maxHealth = 650;
  level.sentrySettings["minigun_turret_4"].burstMin = 20;
  level.sentrySettings["minigun_turret_4"].burstMax = 130;
  level.sentrySettings["minigun_turret_4"].pauseMin = 0.15;
  level.sentrySettings["minigun_turret_4"].pauseMax = 0.35;
  level.sentrySettings["minigun_turret_4"].sentryModeOn = "manual";
  level.sentrySettings["minigun_turret_4"].sentryModeOff = "sentry_offline";
  level.sentrySettings["minigun_turret_4"].timeOut = 600.0;
  level.sentrySettings["minigun_turret_4"].spinupTime = 0.05;
  level.sentrySettings["minigun_turret_4"].overheatTime = 6.0;
  level.sentrySettings["minigun_turret_4"].cooldownTime = 0.5;
  level.sentrySettings["minigun_turret_4"].fxTime = 0.3;
  level.sentrySettings["minigun_turret_4"].streakName = "minigun";
  level.sentrySettings["minigun_turret_4"].weaponInfo = "alien_manned_minigun_turret4_mp";
  level.sentrySettings["minigun_turret_4"].modelBase = "weapon_standing_turret_grenade_launcher";
  level.sentrySettings["minigun_turret_4"].modelPlacement = "weapon_standing_turret_grenade_launcher_obj";
  level.sentrySettings["minigun_turret_4"].modelPlacementFailed = "weapon_standing_turret_grenade_launcher_obj_red";
  level.sentrySettings["minigun_turret_4"].modelDestroyed = "weapon_sentry_chaingun_destroyed";
  level.sentrySettings["minigun_turret_4"].hintString = &"ALIEN_COLLECTIBLES_USE_TURRET";
  level.sentrySettings["minigun_turret_4"].ownerHintString = &"ALIEN_COLLECTIBLES_DOUBLE_TAP_TO_CARRY";
  level.sentrySettings["minigun_turret_4"].headIcon = false;
  level.sentrySettings["minigun_turret_4"].teamSplash = "used_minigun_turret";
  level.sentrySettings["minigun_turret_4"].shouldSplash = true;
  level.sentrySettings["minigun_turret_4"].voDestroyed = "sentry_destroyed";
  level.sentrySettings["minigun_turret_4"].isSentient = false;
}

giveSentry(sentryType) {
  self.last_sentry = sentryType;

  sentryGun = createSentryForPlayer(sentryType, self);

  self removePerks();

  self.carriedSentry = sentryGun;

  result = self setCarryingSentry(sentryGun, true);

  self.carriedSentry = undefined;

  self thread waitRestorePerks();

  self.isCarrying = false;

  if(isDefined(sentryGun))
    return true;
  else
    return false;
}

setCarryingSentry(sentryGun, allowCancel) {
  self endon("death");
  self endon("disconnect");

  assert(isReallyAlive(self));

  sentryGun sentry_setCarried(self);

  self _disableWeapon();

  self notifyOnPlayerCommand("place_sentry", "+attack");
  self notifyOnPlayerCommand("place_sentry", "+attack_akimbo_accessible");
  self notifyOnPlayerCommand("cancel_sentry", "+actionslot 4");
  if(!level.console) {
    self notifyOnPlayerCommand("cancel_sentry", "+actionslot 5");
    self notifyOnPlayerCommand("cancel_sentry", "+actionslot 6");
    self notifyOnPlayerCommand("cancel_sentry", "+actionslot 7");
  }

  for(;;) {
    result = waittill_any_return("place_sentry", "cancel_sentry", "force_cancel_placement");

    if(!isDefined(sentryGun)) {
      self _enableWeapon();
      return true;
    }

    if(result == "cancel_sentry" || result == "force_cancel_placement") {
      if(!allowCancel && result == "cancel_sentry") {
        continue;
      }
      if(level.console) {
        killstreakWeapon = getKillstreakWeapon(level.sentrySettings[sentryGun.sentryType].streakName);
        if(isDefined(self.killstreakIndexWeapon) && killstreakWeapon == getKillstreakWeapon(self.pers["killstreaks"][self.killstreakIndexWeapon].streakName) && !(self GetWeaponsListItems()).size) {
          self _giveWeapon(killstreakWeapon, 0);
          self _setActionSlot(4, "weapon", killstreakWeapon);
        }
      }

      sentryGun sentry_setCancelled();
      self _enableWeapon();
      return false;
    }

    if(!sentryGun.canBePlaced) {
      continue;
    }
    sentryGun sentry_setPlaced();
    self _enableWeapon();
    return true;
  }
}

removeWeapons() {
  if(self.hasRiotShield) {
    riot_shield = self riotShieldName();
    self.restoreWeapon = riot_shield;
    self.riotshieldAmmo = self GetAmmoCount(riot_shield);
    self takeWeapon(riot_shield);
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

    if(self.hasRiotShield) {
      riot_shield = self riotShieldName();
      self SetWeaponAmmoClip(riot_shield, self.riotshieldAmmo);
    }
  }

  self.restoreWeapon = undefined;
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

createSentryForPlayer(sentryType, owner) {
  assertEx(isDefined(owner), "createSentryForPlayer() called without owner specified");

  sentryGun = spawnTurret("misc_turret", owner.origin, level.sentrySettings[sentryType].weaponInfo);
  sentryGun.angles = owner.angles;

  sentryGun sentry_initSentry(sentryType, owner);

  return (sentryGun);
}

sentry_initSentry(sentryType, owner) {
  self.sentryType = sentryType;
  self.canBePlaced = true;

  self setModel(level.sentrySettings[self.sentryType].modelBase);
  self.shouldSplash = true;

  self setCanDamage(true);
  switch (sentryType) {
    case "minigun_turret":
    case "minigun_turret_1":
    case "minigun_turret_2":
    case "minigun_turret_3":
    case "minigun_turret_4":
    case "gl_turret":
    case "gl_turret_1":
    case "gl_turret_2":
    case "gl_turret_3":
    case "gl_turret_4":
      self SetLeftArc(65);
      self SetRightArc(65);
      self SetTopArc(50);
      self SetBottomArc(30);
      self SetDefaultDropPitch(0.0);
      self.originalOwner = owner;
      break;

    default:
      self makeTurretInoperable();
      self SetDefaultDropPitch(-89.0);
      break;
  }

  self setTurretModeChangeWait(true);

  self sentry_setInactive();

  self sentry_setOwner(owner);
  self thread sentry_handleDamage();
  self thread sentry_handleDeath();
  self thread sentry_timeOut();

  switch (sentryType) {
    case "minigun_turret":
    case "minigun_turret_1":
    case "minigun_turret_2":
    case "minigun_turret_3":
    case "minigun_turret_4":
      self.momentum = 0;
      self.heatLevel = 0;
      self.overheated = false;
      self thread sentry_heatMonitor();
      break;

    case "gl_turret":
    case "gl_turret_1":
    case "gl_turret_2":
    case "gl_turret_3":
    case "gl_turret_4":
      self.momentum = 0;
      self.heatLevel = 0;
      self.cooldownWaitTime = 0;
      self.overheated = false;
      self thread turret_heatMonitor();
      self thread turret_coolMonitor();
      break;

    default:
      self set_sentry_attack_setup();
      self thread sentry_handleUse();
      self thread sentry_attackTargets();
      self thread sentry_beepSounds();
      break;
  }
}

sentry_handleDamage() {
  self endon("death");
  level endon("game_ended");

  self.health = level.sentrySettings[self.sentryType].health;
  self.maxHealth = level.sentrySettings[self.sentryType].maxHealth;
  self.damageTaken = 0;

  while(true) {
    self waittill("damage", damage, attacker, direction_vec, point, meansOfDeath, modelName, tagName, partName, iDFlags, weapon);

    if(!maps\mp\gametypes\_weapons::friendlyFireCheck(self.owner, attacker, 0)) {
      continue;
    }
    if(isDefined(iDFlags) && (iDFlags &level.iDFLAGS_PENETRATION))
      self.wasDamagedFromBulletPenetration = true;

    if(meansOfDeath == "MOD_MELEE")
      self.damageTaken += self.maxHealth;

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

    self.damageTaken += modifiedDamage;

    if(self.damageTaken >= self.maxHealth) {
      thread maps\mp\gametypes\_missions::vehicleKilled(self.owner, self, undefined, attacker, damage, meansOfDeath, weapon);

      if(isPlayer(attacker) && (!isDefined(self.owner) || attacker != self.owner)) {
        attacker thread maps\mp\gametypes\_rank::giveRankXP("kill", 100, weapon, meansOfDeath);
        attacker notify("destroyed_killstreak");

        if(isDefined(self.UAVRemoteMarkedBy) && self.UAVRemoteMarkedBy != attacker)
          self.UAVRemoteMarkedBy thread maps\mp\killstreaks\_remoteuav::remoteUAV_processTaggedAssist();
      }

      if(isDefined(self.owner))
        self.owner thread leaderDialogOnPlayer(level.sentrySettings[self.sentryType].voDestroyed, undefined, undefined, self.origin);

      self notify("death");
      return;
    }
  }
}

sentry_watchDisabled() {
  self endon("carried");
  self endon("death");
  level endon("game_ended");

  while(true) {
    self waittill("emp_damage", attacker, duration);

    playFXOnTag(getfx("sentry_explode_mp"), self, "tag_aim");

    self SetDefaultDropPitch(40);
    self SetMode(level.sentrySettings[self.sentryType].sentryModeOff);

    wait(duration);

    self SetDefaultDropPitch(-89.0);
    self SetMode(level.sentrySettings[self.sentryType].sentryModeOn);
  }
}

sentry_handleDeath() {
  self waittill("death");

  if(!isDefined(self)) {
    return;
  }
  self FreeEntitySentient();

  self setModel(level.sentrySettings[self.sentryType].modelDestroyed);

  self sentry_setInactive();
  self SetDefaultDropPitch(40);

  if(isDefined(self.carriedBy)) {
    self SetSentryCarrier(undefined);
  }
  self SetSentryOwner(undefined);
  self SetTurretMinimapVisible(false);

  if(isDefined(self.ownerTrigger))
    self.ownerTrigger delete();

  self playSound("sentry_explode");

  switch (self.sentryType) {
    case "minigun_turret":
    case "gl_turret":
      self.forceDisable = true;
      self TurretFireDisable();
      break;
    default:
      break;
  }
  if(isDefined(self))
    self thread sentry_deleteturret();
}

sentry_deleteturret() {
  self notify("sentry_delete_turret");
  self endon("sentry_delete_turret");

  if(isDefined(self.inUseBy)) {
    playFXOnTag(getFx("sentry_explode_mp"), self, "tag_origin");
    playFXOnTag(getFx("sentry_smoke_mp"), self, "tag_aim");

    self.inUseBy SetClientOmnvar("ui_alien_turret_overheat", -1);
    self.inUseBy restorePerks();
    self.inUseBy restoreWeapons();
    self notify("deleting");
    self useby(self.inUseBy);
    wait(1.0);
  } else {
    wait(1.5);
    playFXOnTag(getFx("sentry_explode_mp"), self, "tag_aim");
    playFXOnTag(getFx("sentry_smoke_mp"), self, "tag_aim");
    self playSound("sentry_explode_smoke");
    wait(.1);
    self notify("deleting");
  }

  if(isDefined(self.killCamEnt))
    self.killCamEnt delete();

  if(isDefined(self))
    self delete();
}

sentry_handleUse() {
  self endon("death");
  level endon("game_ended");

  for(;;) {
    self waittill("trigger", player);

    assert(player == self.owner);
    assert(!isDefined(self.carriedBy));

    if(!isReallyAlive(player)) {
      continue;
    }
    player setCarryingSentry(self, false);
  }
}

turret_handlePickup(turret) {
  self endon("disconnect");
  level endon("game_ended");
  turret endon("death");
  turret endon("sentry_delete_turret");

  if(!isDefined(turret.ownerTrigger)) {
    return;
  }
  buttonTime = 0;
  for(;;) {
    if(IsAlive(self) && self IsTouching(turret.ownerTrigger) && !isDefined(turret.inUseBy) && !isDefined(turret.carriedBy) && self IsOnGround() && !isDefined(turret.deleting)) {
      if(self useButtonPressed()) {
        buttonTime = 0;
        while(self useButtonPressed()) {
          buttonTime += 0.05;
          wait(0.05);
        }

        println("pressTime1: " + buttonTime);
        if(buttonTime >= 0.25) {
          continue;
        }
        buttonTime = 0;
        while(!self useButtonPressed() && buttonTime < 0.25) {
          buttonTime += 0.05;
          wait(0.05);
        }

        println("delayTime: " + buttonTime);
        if(buttonTime >= 0.25) {
          continue;
        }
        if(!self can_pickup_sentry(turret)) {
          continue;
        }
        turret setMode(level.sentrySettings[turret.sentryType].sentryModeOff);

        self thread setCarryingSentry(turret, false);
        turret.ownerTrigger delete();
        return;
      }
    }
    wait(0.05);
  }
}

turret_handlePickup_pc(turret) {
  self endon("disconnect");
  level endon("game_ended");
  turret endon("death");
  turret endon("sentry_delete_turret");

  if(!isDefined(turret.ownerTrigger)) {
    return;
  }
  buttonTime = 0;
  for(;;) {
    if(IsAlive(self) && self IsTouching(turret.ownerTrigger) && !isDefined(turret.inUseBy) && !isDefined(turret.carriedBy) && self IsOnGround() && !isDefined(turret.deleting)) {
      if(self meleeButtonPressed()) {
        buttonTime = 0;
        while(self meleeButtonPressed()) {
          buttonTime += 0.05;
          wait(0.05);
        }

        println("pressTime1: " + buttonTime);
        if(buttonTime >= 0.5) {
          continue;
        }
        buttonTime = 0;
        while(!self meleeButtonPressed() && buttonTime < 0.5) {
          buttonTime += 0.05;
          wait(0.05);
        }

        println("delayTime: " + buttonTime);
        if(buttonTime >= 0.5) {
          continue;
        }
        if(!self can_pickup_sentry(turret)) {
          continue;
        }
        turret setMode(level.sentrySettings[turret.sentryType].sentryModeOff);

        self thread setCarryingSentry(turret, false);
        turret.ownerTrigger delete();
        return;
      }
    }
    wait(0.05);
  }
}

can_pickup_sentry(turret) {
  if(!isReallyAlive(self))
    return false;

  if(isDefined(self.using_remote_turret) && self.using_remote_turret)
    return false;

  if(self IsUsingTurret() || isDefined(turret.deleting))
    return false;

  if(self is_holding_deployable())
    return false;

  if(is_true(self.isCarrying))
    return false;

  if(isDefined(turret.inUseBy))
    return false;

  if(isDefined(level.drill_carrier) && level.drill_carrier == self)
    return false;

  if(isDefined(self.remoteUAV))
    return false;

  return true;
}

turret_handleUse() {
  self notify("turret_handluse");
  self endon("turret_handleuse");
  self endon("deleting");
  level endon("game_ended");

  self.forceDisable = false;
  colorStable = (1, 0.9, 0.7);
  colorUnstable = (1, 0.65, 0);
  colorOverheated = (1, 0.25, 0);

  for(;;) {
    self waittill("trigger", player);

    if(isDefined(self.carriedBy)) {
      continue;
    }
    if(isDefined(self.inUseBy)) {
      continue;
    }
    if(!isReallyAlive(player)) {
      continue;
    }
    if(player is_holding_deployable()) {
      continue;
    }
    if(isDefined(level.drill_carrier) && player == level.drill_carrier) {
      continue;
    }
    player removePerks();
    player notify("weapon_change", "none");

    self.inUseBy = player;
    self setMode(level.sentrySettings[self.sentryType].sentryModeOff);
    self sentry_setOwner(player);
    self setMode(level.sentrySettings[self.sentryType].sentryModeOn);
    player thread turret_shotMonitor(self);

    player SetClientOmnvar("ui_alien_turret_overheat", 0);

    playingHeatFX = false;

    submitted_overheat_value = 0;
    player setLowerMessage("disengage_turret", &"ALIEN_COLLECTIBLES_DISENGAGE_TURRET", 4);

    for(;;) {
      if(!isReallyAlive(player)) {
        self.inUseBy = undefined;
        player SetClientOmnvar("ui_alien_turret_overheat", -1);
        player clearLowerMessage("disengage_turret");
        break;
      }
      if(!player IsUsingTurret()) {
        self notify("player_dismount");
        self.inUseBy = undefined;
        player restorePerks();
        player restoreWeapons();
        self setHintString(level.sentrySettings[self.sentryType].hintString);
        self setMode(level.sentrySettings[self.sentryType].sentryModeOff);
        self sentry_setOwner(self.originalOwner);
        self setMode(level.sentrySettings[self.sentryType].sentryModeOn);
        player SetClientOmnvar("ui_alien_turret_overheat", -1);
        player clearLowerMessage("disengage_turret");
        break;
      }

      if(self.heatLevel >= level.sentrySettings[self.sentryType].overheatTime)
        barFrac = 1;
      else
        barFrac = self.heatLevel / level.sentrySettings[self.sentryType].overheatTime;

      throttle = 5;
      new_value = int(barFrac * 100);
      if(submitted_overheat_value != new_value) {
        if(new_value <= throttle || (abs(abs(submitted_overheat_value) - abs(new_value)) > throttle)) {
          player SetClientOmnvar("ui_alien_turret_overheat", new_value);
          submitted_overheat_value = new_value;
        }
      }

      if(string_starts_with(self.sentryType, "minigun_turret"))
        minigun_turret = "minigun_turret";

      if(self.forceDisable || self.overheated) {
        self TurretFireDisable();
        playingHeatFX = false;
      } else {
        self TurretFireEnable();
        playingHeatFX = false;
        self notify("not_overheated");
      }

      wait(0.05);
    }
    player clearLowerMessage("disengage_turret");
    self SetDefaultDropPitch(0.0);
    player SetClientOmnvar("ui_alien_turret_overheat", -1);
  }
}

sentry_handleOwnerDisconnect() {
  self endon("death");
  level endon("game_ended");

  self notify("sentry_handleOwner");
  self endon("sentry_handleOwner");

  self.owner waittill("killstreak_disowned");

  self notify("death");
}

sentry_setOwner(owner) {
  assertEx(isDefined(owner), "sentry_setOwner() called without owner specified");
  assertEx(isPlayer(owner), "sentry_setOwner() called on non-player entity type: " + owner.classname);

  owner.current_sentry = self;
  self.owner = owner;

  self SetSentryOwner(self.owner);
  self SetTurretMinimapVisible(true, self.sentryType);

  if(level.teamBased) {
    self.team = self.owner.team;
    self setTurretTeam(self.team);
  }

  self thread sentry_handleOwnerDisconnect();
}

sentry_setPlaced() {
  self setModel(level.sentrySettings[self.sentryType].modelBase);

  if(self GetMode() == "manual")
    self SetMode(level.sentrySettings[self.sentryType].sentryModeOff);

  self setSentryCarrier(undefined);
  self setCanDamage(true);

  switch (self.sentryType) {
    case "minigun_turret":
    case "minigun_turret_1":
    case "minigun_turret_2":
    case "minigun_turret_3":
    case "minigun_turret_4":
    case "gl_turret":
    case "gl_turret_1":
    case "gl_turret_2":
    case "gl_turret_3":
    case "gl_turret_4":
      self.angles = self.carriedBy.angles;

      if(IsAlive(self.originalOwner)) {
        if(level.Console || self.originalOwner usinggamepad())
          self.originalOwner setLowerMessage("pickup_hint", level.sentrySettings[self.sentryType].ownerHintString, 3.0, undefined, undefined, undefined, undefined, undefined, true);
        else
          self.originalOwner setLowerMessage("pickup_hint", &"ALIENS_PATCH_PRESS_TO_CARRY", 3.0, undefined, undefined, undefined, undefined, undefined, true);
      }

      self.ownerTrigger = spawn("trigger_radius", self.origin + (0, 0, 1), 0, 105, 64);
      assert(isDefined(self.ownerTrigger));

      if(level.Console || self.originalOwner usinggamepad())
        self.originalOwner thread turret_handlePickup(self);
      else
        self.originalOwner thread turret_handlePickup_PC(self);
      self thread turret_handleUse();
      break;
    default:
      break;
  }

  self sentry_makeSolid();

  self.carriedBy forceUseHintOff();
  self.carriedBy = undefined;

  self.in_world_area = self get_in_world_area();

  if(isDefined(self.owner)) {
    self.owner.isCarrying = false;
    if(level.sentrySettings[self.sentryType].isSentient)
      self make_entity_sentient_mp(self.owner.team);
    self.owner notify("new_sentry", self);
  }

  self sentry_setActive();

  self playSound("sentry_gun_plant");

  self notify("placed");
}

sentry_setCancelled() {
  self.carriedBy forceUseHintOff();
  if(isDefined(self.owner))
    self.owner.isCarrying = false;

  self delete();
}

sentry_setCarried(carrier) {
  assert(isPlayer(carrier));
  if(isDefined(self.originalOwner))
    assertEx(carrier == self.originalOwner, "sentry_setCarried() specified carrier does not own this sentry");
  else
    assertEx(carrier == self.owner, "sentry_setCarried() specified carrier does not own this sentry");

  self setModel(level.sentrySettings[self.sentryType].modelPlacement);

  self setSentryCarrier(carrier);
  self setCanDamage(false);
  self sentry_makeNotSolid();

  self.carriedBy = carrier;
  carrier.isCarrying = true;

  carrier thread updateSentryPlacement(self);

  self thread sentry_onCarrierDeath(carrier);
  self thread sentry_onCarrierDisconnect(carrier);
  self thread sentry_onCarrierChangedTeam(carrier);
  self thread sentry_onGameEnded();

  self FreeEntitySentient();

  self SetDefaultDropPitch(-89.0);

  self sentry_setInactive();

  self notify("carried");
}

updateSentryPlacement(sentryGun) {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");

  sentryGun endon("placed");
  sentryGun endon("death");

  sentryGun.canBePlaced = true;
  lastCanPlaceSentry = -1;

  for(;;) {
    sentryGun.canBePlaced = self can_place_sentry(sentryGun);

    if(sentryGun.canBePlaced != lastCanPlaceSentry) {
      if(sentryGun.canBePlaced) {
        sentryGun setModel(level.sentrySettings[sentryGun.sentryType].modelPlacement);
        self ForceUseHintOn(&"SENTRY_PLACE");
      } else {
        sentryGun setModel(level.sentrySettings[sentryGun.sentryType].modelPlacementFailed);
        self ForceUseHintOn(&"SENTRY_CANNOT_PLACE");
      }
    }

    lastCanPlaceSentry = sentryGun.canBePlaced;
    wait(0.05);
  }
}

can_place_sentry(sentryGun) {
  placement = self canPlayerPlaceSentry();
  sentryGun.origin = placement["origin"];
  sentryGun.angles = placement["angles"];
  return (self isOnGround() && placement["result"] && (abs(sentryGun.origin[2] - self.origin[2]) < 10));
}

sentry_onCarrierDeath(carrier) {
  self endon("placed");
  self endon("death");

  carrier waittill("death");

  if(self.canBePlaced)
    self sentry_setPlaced();
  else
    self delete();
}

sentry_onCarrierDisconnect(carrier) {
  self endon("placed");
  self endon("death");

  carrier waittill("disconnect");

  self delete();
}

sentry_onCarrierChangedTeam(carrier) {
  self endon("placed");
  self endon("death");

  carrier waittill_any("joined_team", "joined_spectators");

  self delete();
}

sentry_onGameEnded(carrier) {
  self endon("placed");
  self endon("death");

  level waittill("game_ended");

  self delete();
}

sentry_setActive() {
  self SetMode(level.sentrySettings[self.sentryType].sentryModeOn);
  self setCursorHint("HINT_NOICON");
  self setHintString(level.sentrySettings[self.sentryType].hintString);

  self makeUsable();

  foreach(player in level.players) {
    switch (self.sentryType) {
      case "minigun_turret":
      case "minigun_turret_1":
      case "minigun_turret_2":
      case "minigun_turret_3":
      case "minigun_turret_4":
      case "gl_turret":
      case "gl_turret_1":
      case "gl_turret_2":
      case "gl_turret_3":
      case "gl_turret_4":
        self enablePlayerUse(player);
        if(is_aliens()) {
          entNum = self GetEntityNumber();
          self addToTurretList(entNum);
        }
        break;
      default:
        entNum = self GetEntityNumber();
        self addToTurretList(entNum);

        if(player == self.owner)
          self enablePlayerUse(player);
        else
          self disablePlayerUse(player);
        break;
    }
  }

  if(self.shouldSplash && !isPlayingSolo()) {
    level thread teamPlayerCardSplash(level.sentrySettings[self.sentryType].teamSplash, self.owner, self.owner.team);
    self.shouldSplash = false;
  }

  self thread sentry_watchDisabled();
}

sentry_setInactive() {
  self setMode(level.sentrySettings[self.sentryType].sentryModeOff);
  self makeUnusable();

  entNum = self GetEntityNumber();
  switch (self.sentryType) {
    case "gl_turret":
      break;
    default:
      self removeFromTurretList(entNum);
      break;
  }

  if(level.teamBased)
    self maps\mp\_entityheadicons::setTeamHeadIcon("none", (0, 0, 0));
  else if(isDefined(self.owner))
    self maps\mp\_entityheadicons::setPlayerHeadIcon(undefined, (0, 0, 0));
}

sentry_makeSolid() {
  self makeTurretSolid();
}

sentry_makeNotSolid() {
  self setContents(0);
}

isFriendlyToSentry(sentryGun) {
  if(level.teamBased && self.team == sentryGun.team)
    return true;

  return false;
}

addToTurretList(entNum) {
  level.turrets[entNum] = self;
}

removeFromTurretList(entNum) {
  level.turrets[entNum] = undefined;
}

sentry_attackTargets() {
  self endon("death");
  level endon("game_ended");

  self.momentum = 0;
  self.heatLevel = 0;
  self.overheated = false;

  self thread sentry_heatMonitor();

  for(;;) {
    self waittill_either("turretstatechange", "cooled");

    if(self isFiringTurret()) {
      self thread sentry_burstFireStart();
    } else {
      self sentry_spinDown();
      self thread sentry_burstFireStop();
    }
  }
}

sentry_timeOut() {
  self endon("death");
  level endon("game_ended");

  lifeSpan = level.sentrySettings[self.sentryType].timeOut;

  while(lifeSpan) {
    wait(1.0);
    maps\mp\gametypes\_hostmigration::waitTillHostMigrationDone();

    if(!isDefined(self.carriedBy))
      lifeSpan = max(0, lifeSpan - 1.0);
  }

  while(isDefined(self) && isDefined(self.inUseBy)) {
    wait(.05);
  }
  self notify("death");
}

sentry_targetLockSound() {
  self endon("death");

  self playSound("sentry_gun_beep");
  wait(0.1);
  self playSound("sentry_gun_beep");
  wait(0.1);
  self playSound("sentry_gun_beep");
}

sentry_spinUp() {
  self thread sentry_targetLockSound();

  while(self.momentum < level.sentrySettings[self.sentryType].spinupTime) {
    self.momentum += 0.1;

    wait(0.1);
  }
}

sentry_spinDown() {
  self.momentum = 0;
}

sentry_burstFireStart() {
  self endon("death");
  self endon("stop_shooting");

  level endon("game_ended");

  self sentry_spinUp();

  fireTime = weaponFireTime(level.sentrySettings[self.sentryType].weaponInfo);
  minShots = level.sentrySettings[self.sentryType].burstMin;
  maxShots = level.sentrySettings[self.sentryType].burstMax;
  minPause = level.sentrySettings[self.sentryType].pauseMin;
  maxPause = level.sentrySettings[self.sentryType].pauseMax;

  for(;;) {
    numShots = randomIntRange(minShots, maxShots + 1);

    for(i = 0; i < numShots && !self.overheated; i++) {
      self shootTurret();
      self notify("bullet_fired");
      self.heatLevel += fireTime;
      wait(fireTime);
    }

    wait(randomFloatRange(minPause, maxPause));
  }
}

sentry_burstFireStop() {
  self notify("stop_shooting");
}

turret_shotMonitor(turret) {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  turret endon("death");
  turret endon("player_dismount");

  fireTime = weaponFireTime(level.sentrySettings[turret.sentryType].weaponInfo);
  for(;;) {
    turret waittill("turret_fire");
    turret GetTurretOwner() notify("turret_fire");
    turret.heatLevel += fireTime;

    turret.cooldownWaitTime = fireTime;
  }
}

sentry_heatMonitor() {
  self endon("death");

  fireTime = weaponFireTime(level.sentrySettings[self.sentryType].weaponInfo);

  lastHeatLevel = 0;
  lastFxTime = 0;

  overheatTime = level.sentrySettings[self.sentryType].overheatTime;
  overheatCoolDown = level.sentrySettings[self.sentryType].cooldownTime;

  for(;;) {
    if(self.heatLevel != lastHeatLevel)
      wait(fireTime);
    else
      self.heatLevel = max(0, self.heatLevel - 0.05);

    if(self.heatLevel > overheatTime) {
      self.overheated = true;
      self thread PlayHeatFX();
      switch (self.sentryType) {
        case "minigun_turret":
        case "minigun_turret_1":
        case "minigun_turret_2":
        case "minigun_turret_3":
        case "minigun_turret_4":

          playFXOnTag(getFx("sentry_smoke_mp"), self, "tag_aim");

          break;
        default:
          break;
      }

      while(self.heatLevel) {
        self.heatLevel = max(0, self.heatLevel - .1);
        wait(.1);
      }

      self.overheated = false;
      self notify("not_overheated");
    }

    lastHeatLevel = self.heatLevel;
    wait(0.05);
  }
}

turret_heatMonitor() {
  self endon("death");

  overheatTime = level.sentrySettings[self.sentryType].overheatTime;

  while(true) {
    if(self.heatLevel > overheatTime) {
      self.overheated = true;
      self thread PlayHeatFX();
      switch (self.sentryType) {
        case "gl_turret":
          playFXOnTag(getFx("sentry_smoke_mp"), self, "tag_aim");

          break;
        default:
          break;
      }

      while(self.heatLevel) {
        wait(0.1);
      }

      self.overheated = false;
      self notify("not_overheated");
    }

    wait(0.05);
  }
}

turret_coolMonitor() {
  self endon("death");

  while(true) {
    if(self.heatLevel > 0) {
      if(self.cooldownWaitTime <= 0) {
        self.heatLevel = max(0, self.heatLevel - 0.05);
      } else {
        self.cooldownWaitTime = max(0, self.cooldownWaitTime - 0.05);
      }
    }

    wait(0.05);
  }
}

playHeatFX() {
  self endon("death");
  self endon("not_overheated");
  level endon("game_ended");

  self notify("playing_heat_fx");
  self endon("playing_heat_fx");

  for(;;) {
    playFXOnTag(getFx("sentry_overheat_mp"), self, "tag_flash");

    wait(level.sentrySettings[self.sentryType].fxTime);
  }
}

playSmokeFX() {
  self endon("death");
  self endon("not_overheated");
  level endon("game_ended");

  for(;;) {
    playFXOnTag(getFx("sentry_smoke_mp"), self, "tag_aim");
    wait(0.4);
  }
}

sentry_beepSounds() {
  self endon("death");
  level endon("game_ended");

  for(;;) {
    wait(3.0);

    if(!isDefined(self.carriedBy))
      self playSound("sentry_gun_beep");
  }
}

set_sentry_attack_setup() {
  synchDirections = [];
  synchDirections["brute"][0] = maps\mp\alien\_utility::set_attack_sync_direction((1, 0, 0), "alien_sentry_attack_sentry_front_enter", "alien_sentry_attack_sentry_front_loop", "alien_sentry_attack_sentry_front_exit", "attack_sentry_front", "attack_sentry");
  synchDirections["brute"][1] = maps\mp\alien\_utility::set_attack_sync_direction((0, 1, 0), "alien_sentry_attack_sentry_side_l_enter", "alien_sentry_attack_sentry_side_l_loop", "alien_sentry_attack_sentry_side_l_exit", "attack_sentry_left", "attack_sentry");
  synchDirections["brute"][2] = maps\mp\alien\_utility::set_attack_sync_direction((0, -1, 0), "alien_sentry_attack_sentry_side_r_enter", "alien_sentry_attack_sentry_side_r_loop", "alien_sentry_attack_sentry_side_r_exit", "attack_sentry_right", "attack_sentry");
  synchDirections["goon"][0] = maps\mp\alien\_utility::set_attack_sync_direction((1, 0, 0), "alien_goon_sentry_attack_sentry_F_enter", "alien_goon_sentry_attack_sentry_F_loop", "alien_goon_sentry_attack_sentry_F_exit", "attack_sentry_front", "attack_sentry");
  synchDirections["goon"][1] = maps\mp\alien\_utility::set_attack_sync_direction((0, 1, 0), "alien_goon_sentry_attack_sentry_L_enter", "alien_goon_sentry_attack_sentry_L_loop", "alien_goon_sentry_attack_sentry_L_exit", "attack_sentry_left", "attack_sentry");
  synchDirections["goon"][2] = maps\mp\alien\_utility::set_attack_sync_direction((0, -1, 0), "alien_goon_sentry_attack_sentry_R_enter", "alien_goon_sentry_attack_sentry_R_loop", "alien_goon_sentry_attack_sentry_R_exit", "attack_sentry_right", "attack_sentry");

  endNotifies[0] = "death";
  endNotifies[1] = "destroyed";
  endNotifies[2] = "carried";

  self maps\mp\alien\_utility::set_synch_attack_setup(synchDirections, true, endNotifies, ::sentry_can_synch_attack, ::sentry_synch_attack_begin, ::sentry_synch_attack_loop, ::sentry_synch_attack_end, "sentry gun");
}

sentry_can_synch_attack() {
  return !isDefined(self.synched_turret);
}

sentry_synch_attack_begin(anim_name) {
  self Hide();
  self.synched_turret = spawn("script_model", self.origin);
  self.synched_turret setModel(level.sentrySettings[self.sentryType].modelBase);
  self.synched_turret.angles = self.angles;
  self TurretFireDisable();

  self.synched_turret ScriptModelPlayAnim(anim_name);
}

sentry_synch_attack_loop(anim_name) {
  self.synched_turret ScriptModelClearAnim();
  self.synched_turret ScriptModelPlayAnim(anim_name);
}

sentry_synch_attack_end(anim_name, anim_time) {
  if(isDefined(anim_name)) {
    self.synched_turret ScriptModelClearAnim();
    self.synched_turret ScriptModelPlayAnim(anim_name);
    wait anim_time;
  }

  if(!isDefined(self)) {
    return;
  }
  self.synched_turret Delete();

  self Show();
  if(IsAlive(self)) {
    self TurretFireEnable();
  }
}