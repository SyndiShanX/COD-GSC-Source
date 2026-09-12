/*******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\killstreaks\manual_turret_cp.gsc
*******************************************************/

function init() {
  init_manual_turret_settings();
  init_manual_turret_vo();
  scripts\cp_mp\utility\script_utility::registersharedfunc("manual_turret", "monitorDamage", &manual_turret_monitordamage);
  scripts\cp_mp\utility\script_utility::registersharedfunc("manual_turret", "createHintObject", &manual_turret_createhintobject);
  scripts\cp_mp\utility\script_utility::registersharedfunc("manual_turret", "getTargetMarker", &manual_turret_gettargetmarker);
  scripts\cp_mp\utility\script_utility::registersharedfunc("manual_turret", "getEnemyPlayers", &manual_turret_getenemyplayers);
  scripts\cp_mp\utility\script_utility::registersharedfunc("manual_turret", "munitionUsed", &ref_11AC3);
  scripts\cp_mp\utility\script_utility::registersharedfunc("manual_turret", "watchForPlayerEnteringLastStand", &ref_11AC2);
  scripts\cp_mp\utility\script_utility::registersharedfunc("manual_turret", "allowPickupOfTurret", &ref_11ABF);
}

function init_manual_turret_settings() {
  level.sentrysettings["manual_turret"] = spawnStruct();
  level.sentrysettings["manual_turret"].health = 999999;
  level.sentrysettings["manual_turret"].maxhealth = 650;
  level.sentrysettings["manual_turret"].burstmin = 20;
  level.sentrysettings["manual_turret"].burstmax = 120;
  level.sentrysettings["manual_turret"].pausemin = 0.15;
  level.sentrysettings["manual_turret"].pausemax = 0.35;
  level.sentrysettings["manual_turret"].sentrymodeon = "manual";
  level.sentrysettings["manual_turret"].sentrymodeoff = "sentry_offline";
  level.sentrysettings["manual_turret"].ammo = 200;
  level.sentrysettings["manual_turret"].timeout = 90;
  level.sentrysettings["manual_turret"].spinuptime = 0.05;
  level.sentrysettings["manual_turret"].overheattime = 8;
  level.sentrysettings["manual_turret"].cooldowntime = 0.1;
  level.sentrysettings["manual_turret"].fxtime = 0.3;
  level.sentrysettings["manual_turret"].streakname = "manual_turret";
  level.sentrysettings["manual_turret"].weaponinfo = "manual_turret_mp";
  level.sentrysettings["manual_turret"].playerweaponinfo = "manual_turret_mp";
  level.sentrysettings["manual_turret"].scriptable = "ks_manual_turret_mp";
  level.sentrysettings["manual_turret"].modelbasecover = "killstreak_wm_mounted_turret";
  level.sentrysettings["manual_turret"].modelbaseground = "weapon_wm_mg_mobile_turret";
  level.sentrysettings["manual_turret"].modeldestroyedcover = "killstreak_wm_mounted_turret";
  level.sentrysettings["manual_turret"].modeldestroyedground = "weapon_wm_mg_mobile_turret";
  level.sentrysettings["manual_turret"].placementhintstring = &"KILLSTREAKS_HINTS/SENTRY_PLACE";
  level.sentrysettings["manual_turret"].ownerusehintstring = &"KILLSTREAKS_HINTS/SENTRY_OWNER_USE";
  level.sentrysettings["manual_turret"].otherusehintstring = &"KILLSTREAKS_HINTS/SENTRY_OTHER_USE";
  level.sentrysettings["manual_turret"].dismantlehintstring = &"KILLSTREAKS_HINTS/SENTRY_DISMANTLE";
  level.sentrysettings["manual_turret"].headicon = 1;
  level.sentrysettings["manual_turret"].teamsplash = "used_manual_turret";
  level.sentrysettings["manual_turret"].destroyedsplash = "callout_destroyed_manual_turret";
  level.sentrysettings["manual_turret"].shouldsplash = 1;
  level.sentrysettings["manual_turret"].votimeout = "sentry_shock_timeout";
  level.sentrysettings["manual_turret"].vodestroyed = "sentry_shock_destroy";
  level.sentrysettings["manual_turret"].scorepopup = "destroyed_sentry";
  level.sentrysettings["manual_turret"].lightfxtag = "tag_fx";
  level.sentrysettings["manual_turret"].iskillstreak = 1;
  level.sentrysettings["manual_turret"].headiconoffset = (0, 0, 75);
}

function init_manual_turret_vo() {
  game["dialog"]["manual_turret_ammo_low"] = "manual_turret_ammo_low";
  game["dialog"]["manual_turret_no_ammo"] = "manual_turret_no_ammo";
}

function manual_turret_gettargetmarker(var_0, var_1) {
  return scripts\cp\inventory\cp_target_marker::gettargetmarker(var_0, var_1);
}

function manual_turret_createhintobject(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  return scripts\cp\utility::createhintobject(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);
}

function manual_turret_monitordamage(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {}

function manual_turret_getenemyplayers(var_0) {
  return scripts\cp\utility::getteamarray(var_0, 1);
}

function ref_11AC3(var_0, var_1) {
  self notify("munitions_used", "manual_turret");
}

function ref_11AC2() {
  self endon("disconnect");
  self endon("death");
  self notify("stop_manual_turret_lastStandWatcher");
  self endon("stop_manual_turret_lastStandWatcher");
  self endon("turret_placement_finished");
  thread scripts\cp_mp\killstreaks\manual_turret::ref_11AC6("last_stand");
  self waittill("last_stand");
  scripts\mp\playeractions::allowactionset("target_marker", 1);
  scripts\cp_mp\killstreaks\manual_turret::ref_11ACC(1);
  self.bgivensentry = 0;
}

function ref_11ABF() {
  if(isDefined(level.nuclear_core_carrier)) {
    if(self == level.nuclear_core_carrier) {
      return false;
    }
  }

  return true;
}