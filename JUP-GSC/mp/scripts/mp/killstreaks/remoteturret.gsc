/******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\killstreaks\remoteturret.gsc
******************************************************/

#using scripts\common\utility;
#using scripts\engine\utility;
#using scripts\mp\killstreaks\killstreaks;
#namespace remoteturret;

function init() {
  level.turrettype = [];
  level.turrettype["mg_turret"] = "remote_mg_turret";
  scripts\mp\killstreaks\killstreaks::registerkillstreak("remote_mg_turret", &tryuseremotemgturret);
  level.turretsettings = [];
  level.turretsettings["mg_turret"] = spawnStruct();
  level.turretsettings["mg_turret"].sentrymodeon = "manual";
  level.turretsettings["mg_turret"].sentrymodeoff = "sentry_offline";
  level.turretsettings["mg_turret"].timeout = 60;
  level.turretsettings["mg_turret"].health = 999999;
  level.turretsettings["mg_turret"].maxhealth = 1000;
  level.turretsettings["mg_turret"].streakname = "remote_mg_turret";
  level.turretsettings["mg_turret"].weaponinfo = "remote_turret_mp";
  level.turretsettings["mg_turret"].modelbase = "mp_remote_turret";
  level.turretsettings["mg_turret"].modelplacement = "mp_remote_turret_placement";
  level.turretsettings["mg_turret"].modelplacementfailed = "mp_remote_turret_placement_failed";
  level.turretsettings["mg_turret"].modeldestroyed = "mp_remote_turret";
  level.turretsettings["mg_turret"].teamsplash = "used_remote_mg_turret";
  level.turretsettings["mg_turret"].hintenter = &"KILLSTREAKS_ENTER_REMOTE_TURRET";
  level.turretsettings["mg_turret"].hintexit = &"KILLSTREAKS/EARLY_EXIT";
  level.turretsettings["mg_turret"].hintpickup = &"KILLSTREAKS_DOUBLE_TAP_TO_CARRY";
  level.turretsettings["mg_turret"].placestring = &"KILLSTREAKS_TURRET_PLACE";
  level.turretsettings["mg_turret"].cannotplacestring = &"KILLSTREAKS_TURRET_CANNOT_PLACE";
  level.turretsettings["mg_turret"].vodestroyed = "remote_sentry_destroyed";
  level.turretsettings["mg_turret"].laptopinfo = "killstreak_remote_turret_laptop_mp";
  level.turretsettings["mg_turret"].remoteinfo = "killstreak_remote_turret_remote_mp";
  level._effect["sentry_explode_mp"] = loadfx("vfx/core/mp/killstreaks/vfx_sentry_gun_explosion");
  level._effect["sentry_smoke_mp"] = loadfx("vfx/core/mp/killstreaks/vfx_sg_damage_blacksmoke");

  setdevdvarifuninitialized(@ "hash_91875b7a6afe114", 60);
  setdevdvarifuninitialized(@ "hash_ab79f3052ec707c9", 100);
  setdevdvarifuninitialized(@ "hash_11c4cbf36415fa0e", 10);
}

function tryuseremotemgturret(lifeid, streakname) {}