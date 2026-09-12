/****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\killstreaks\sentry_gun_cp.gsc
****************************************************/

function init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("sentry_gun", "createHintObject", &sentryturret_createhintobject);
  scripts\cp_mp\utility\script_utility::registersharedfunc("sentry_gun", "getTargetMarker", &sentryturret_gettargetmarker);
  scripts\cp_mp\utility\script_utility::registersharedfunc("sentry_gun", "munitionUsed", &sentryturret_munitionused);
  scripts\cp_mp\utility\script_utility::registersharedfunc("sentry_gun", "munitionSplash", &scripts\cp\cp_hud_message::showsplash);
  scripts\cp_mp\utility\script_utility::registersharedfunc("sentry_gun", "initSentrySettings", &sentryturret_initsentrysettings);
  scripts\cp_mp\utility\script_utility::registersharedfunc("sentry_gun", "watchForPlayerEnteringLastStand", &sentryturret_laststandwatcher);
  scripts\cp_mp\utility\script_utility::registersharedfunc("sentry_gun", "allowPickupOfTurret", &ref_13026);
}

function sentryturret_gettargetmarker(var_0, var_1) {
  return scripts\cp\inventory\cp_target_marker::gettargetmarker(var_0, var_1);
}

function sentryturret_createhintobject(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11) {
  return scripts\cp\utility::createhintobject(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11);
}

function sentryturret_munitionused(var_0, var_1) {
  self notify("munitions_used", "sentry");
}

function sentryturret_initsentrysettings() {
  level.sentrysettings["sentry_turret"] = spawnStruct();
  level.sentrysettings["sentry_turret"].health = 999999;
  level.sentrysettings["sentry_turret"].maxhealth = 650;
  level.sentrysettings["sentry_turret"].burstmin = 20;
  level.sentrysettings["sentry_turret"].burstmax = 120;
  level.sentrysettings["sentry_turret"].pausemin = 0.15;
  level.sentrysettings["sentry_turret"].pausemax = 0.35;
  level.sentrysettings["sentry_turret"].lockstrength = 2;
  level.sentrysettings["sentry_turret"].sentrymodeon = "sentry";
  level.sentrysettings["sentry_turret"].sentrymodeoff = "sentry_offline";
  level.sentrysettings["sentry_turret"].ammo = 200;
  level.sentrysettings["sentry_turret"].timeout = 75;
  level.sentrysettings["sentry_turret"].spinuptime = 0.65;
  level.sentrysettings["sentry_turret"].overheattime = 8;
  level.sentrysettings["sentry_turret"].cooldowntime = 0.1;
  level.sentrysettings["sentry_turret"].fxtime = 0.3;
  level.sentrysettings["sentry_turret"].streakname = "sentry_gun";
  level.sentrysettings["sentry_turret"].weaponinfo = "sentry_turret_mp";
  level.sentrysettings["sentry_turret"].playerweaponinfo = "sentry_turret_mp";
  level.sentrysettings["sentry_turret"].scriptable = "ks_sentry_turret_mp";
  level.sentrysettings["sentry_turret"].modelbasecover = "killstreak_wm_mounted_turret";
  level.sentrysettings["sentry_turret"].modelbaseground = "weapon_wm_mg_sentry_turret";
  level.sentrysettings["sentry_turret"].modeldestroyedcover = "killstreak_wm_mounted_turret";
  level.sentrysettings["sentry_turret"].modeldestroyedground = "weapon_wm_mg_sentry_turret";
  level.sentrysettings["sentry_turret"].placementhintstring = &"KILLSTREAKS_HINTS/SENTRY_GUN_PLACE";
  level.sentrysettings["sentry_turret"].ownerusehintstring = &"KILLSTREAKS_HINTS/SENTRY_USE";
  level.sentrysettings["sentry_turret"].otherusehintstring = &"KILLSTREAKS_HINTS/SENTRY_OTHER_USE";
  level.sentrysettings["sentry_turret"].dismantlehintstring = &"KILLSTREAKS_HINTS/SENTRY_DISMANTLE";
  level.sentrysettings["sentry_turret"].headicon = 1;
  level.sentrysettings["sentry_turret"].teamsplash = "used_sentry_gun";
  level.sentrysettings["sentry_turret"].destroyedsplash = "callout_destroyed_sentry_gun";
  level.sentrysettings["sentry_turret"].shouldsplash = 1;
  level.sentrysettings["sentry_turret"].votimeout = "sentry_shock_timeout";
  level.sentrysettings["sentry_turret"].vodestroyed = "sentry_shock_destroy";
  level.sentrysettings["sentry_turret"].scorepopup = "destroyed_sentry";
  level.sentrysettings["sentry_turret"].lightfxtag = "tag_fx";
  level.sentrysettings["sentry_turret"].iskillstreak = 1;
  level.sentrysettings["sentry_turret"].headiconoffset = (0, 0, 75);
}

function sentryturret_laststandwatcher() {
  self endon("disconnect");
  self endon("death");
  self notify("stop_sentryTurret_lastStandWatcher");
  self endon("stop_sentryTurret_lastStandWatcher");
  self endon("turret_placement_finished");
  thread scripts\cp_mp\killstreaks\manual_turret::ref_11AC6("last_stand");
  self waittill("last_stand");
  scripts\mp\playeractions::allowactionset("target_marker", 1);
  scripts\cp_mp\killstreaks\manual_turret::ref_11ACC(1);
  self.bgivensentry = 0;
}

function ref_13026() {
  if(isDefined(level.nuclear_core_carrier)) {
    if(self == level.nuclear_core_carrier) {
      return false;
    }
  }

  return true;
}

function sentryturret_revivedwatcher() {
  self waittill("revive");
  scripts\common\utility::allow_sprint(1);
}