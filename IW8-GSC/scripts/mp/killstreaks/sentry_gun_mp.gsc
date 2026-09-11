/****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\killstreaks\sentry_gun_mp.gsc
****************************************************/

function init() {
  scripts\mp\killstreaks\killstreaks::registerkillstreak("sentry_gun", &scripts\cp_mp\killstreaks\sentry_gun::tryusesentryturretfromstruct);
  scripts\cp_mp\utility\script_utility::registersharedfunc("sentry_gun", "monitorDamage", &sentryturret_monitordamage);
  scripts\cp_mp\utility\script_utility::registersharedfunc("sentry_gun", "createHintObject", &sentryturret_createhintobject);
  scripts\cp_mp\utility\script_utility::registersharedfunc("sentry_gun", "getTargetMarker", &sentryturret_gettargetmarker);
  scripts\cp_mp\utility\script_utility::registersharedfunc("sentry_gun", "initSentrySettings", &sentryturret_initsentrysettings);
  scripts\cp_mp\utility\script_utility::registersharedfunc("sentry_gun", "allowPickupOfTurret", &ref_13027);
  scripts\cp_mp\utility\script_utility::registersharedfunc("sentry_gun", "handleMovingPlatform", &scripts\mp\killstreaks\manual_turret_mp::ref_11ac1);
}

function sentryturret_gettargetmarker(var_0, var_1) {
  return scripts\mp\killstreaks\target_marker::gettargetmarker(var_0, var_1);
}

function sentryturret_createhintobject(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  return scripts\mp\gameobjects::createhintobject(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);
}

function sentryturret_monitordamage(var_0) {
  var_0 thread scripts\mp\damage::monitordamage(var_0.maxhealth, "hitequip", &sentryturret_handledeathdamage, &sentryturret_modifydamage, 1);
}

function sentryturret_handledeathdamage(var_0) {
  var_1 = var_0.attacker;
  var_2 = var_0.objweapon;
  var_3 = var_0.meansofdeath;
  var_4 = var_0.damage;
  var_5 = var_0.idflags;
  var_6 = level.sentrysettings[self.turrettype];
  var_7 = scripts\mp\damage::onkillstreakkilled(var_6.streakname, var_1, var_2, var_3, var_4, var_6.scorepopup, var_6.vodestroyed, var_6.destroyedsplash);

  if(var_7) {
    var_1 notify("destroyed_equipment");
  }

  var_8 = 0;

  if(var_3 == "MOD_EXPLOSIVE" || var_3 == "MOD_PROJECTILE" || var_3 == "MOD_PROJECTILE_SPLASH" || var_3 == "MOD_GRENADE_SPLASH") {
    var_8 = 1;
  }

  self notify("kill_turret", var_8, 1);
}

function sentryturret_modifydamage(var_0) {
  var_1 = var_0.attacker;
  var_2 = var_0.objweapon;
  var_3 = var_0.meansofdeath;
  var_4 = var_0.damage;
  var_5 = var_0.idflags;
  var_6 = var_4;
  var_6 = scripts\mp\utility\killstreak::getmodifiedantikillstreakdamage(var_1, var_2, var_3, var_6, self.maxhealth, 2, 3, 4, 12, 400);
  return var_6;
}

function sentryturret_initsentrysettings() {
  level.sentrysettings["sentry_turret"] = spawnStruct();
  level.sentrysettings["sentry_turret"].health = 999999;
  level.sentrysettings["sentry_turret"].maxhealth = 650;
  level.sentrysettings["sentry_turret"].burstmin = 20;
  level.sentrysettings["sentry_turret"].burstmax = 120;
  level.sentrysettings["sentry_turret"].pausemin = 0.15;
  level.sentrysettings["sentry_turret"].pausemax = 0.35;
  level.sentrysettings["sentry_turret"].lockstrength = 6;
  level.sentrysettings["sentry_turret"].sentrymodeon = "sentry";
  level.sentrysettings["sentry_turret"].sentrymodeoff = "sentry_offline";
  level.sentrysettings["sentry_turret"].timeout = 75;
  level.sentrysettings["sentry_turret"].spinuptime = 0.65;
  level.sentrysettings["sentry_turret"].overheattime = 8;
  level.sentrysettings["sentry_turret"].cooldowntime = 0.3;
  level.sentrysettings["sentry_turret"].fxtime = 0.3;
  level.sentrysettings["sentry_turret"].streakname = "sentry_gun";
  level.sentrysettings["sentry_turret"].weaponinfo = "sentry_turret_mp";
  level.sentrysettings["sentry_turret"].playerweaponinfo = "sentry_turret_mp";
  level.sentrysettings["sentry_turret"].scriptable = "ks_sentry_turret_mp";
  level.sentrysettings["sentry_turret"].modelbasecover = "killstreak_wm_mounted_turret";
  level.sentrysettings["sentry_turret"].modelbaseground = "weapon_wm_mg_sentry_turret";
  level.sentrysettings["sentry_turret"].modeldestroyedcover = "killstreak_wm_mounted_turret";
  level.sentrysettings["sentry_turret"].modeldestroyedground = "weapon_wm_mg_sentry_turret";
  level.sentrysettings["sentry_turret"].placementhintstring = &"KILLSTREAKS_HINTS/SENTRY_PLACE";
  level.sentrysettings["sentry_turret"].ownerusehintstring = &"KILLSTREAKS_HINTS/SENTRY_USE";
  level.sentrysettings["sentry_turret"].otherusehintstring = &"KILLSTREAKS_HINTS/SENTRY_OTHER_USE";
  level.sentrysettings["sentry_turret"].dismantlehintstring = &"KILLSTREAKS_HINTS/SENTRY_DISMANTLE";
  level.sentrysettings["sentry_turret"].headicon = 1;
  level.sentrysettings["sentry_turret"].teamsplash = "used_sentry_gun";
  level.sentrysettings["sentry_turret"].destroyedsplash = "callout_destroyed_sentry_gun";
  level.sentrysettings["sentry_turret"].shouldsplash = 1;
  level.sentrysettings["sentry_turret"].votimeout = "destroyed_sentry_gun";
  level.sentrysettings["sentry_turret"].vodestroyed = "destroyed_sentry_gun";
  level.sentrysettings["sentry_turret"].scorepopup = "destroyed_sentry";
  level.sentrysettings["sentry_turret"].lightfxtag = "tag_fx";
  level.sentrysettings["sentry_turret"].iskillstreak = 1;
  level.sentrysettings["sentry_turret"].headiconoffset = (0, 0, 75);
}

function ref_13027() {
  if(scripts\cp_mp\utility\inventory_utility::isanymonitoredweaponswitchinprogress()) {
    return false;
  }

  if(scripts\cp_mp\utility\killstreak_utility::unsetobjectivemarker(self getcurrentweapon())) {
    return false;
  }

  return true;
}