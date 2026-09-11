/*******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\killstreaks\manual_turret_mp.gsc
*******************************************************/

function init() {
  scripts\mp\killstreaks\killstreaks::registerkillstreak("manual_turret", &scripts\cp_mp\killstreaks\manual_turret::tryusemanualturretfromstruct);
  init_manual_turret_settings();
  init_manual_turret_vo();
  scripts\cp_mp\utility\script_utility::registersharedfunc("manual_turret", "monitorDamage", &manual_turret_monitordamage);
  scripts\cp_mp\utility\script_utility::registersharedfunc("manual_turret", "createHintObject", &manual_turret_createhintobject);
  scripts\cp_mp\utility\script_utility::registersharedfunc("manual_turret", "getTargetMarker", &manual_turret_gettargetmarker);
  scripts\cp_mp\utility\script_utility::registersharedfunc("manual_turret", "getEnemyPlayers", &manual_turret_getenemyplayers);
  scripts\cp_mp\utility\script_utility::registersharedfunc("manual_turret", "watchForPlayerEnteringLastStand", &ref_11ac2);
  scripts\cp_mp\utility\script_utility::registersharedfunc("manual_turret", "handleMovingPlatform", &ref_11ac1);
  scripts\cp_mp\utility\script_utility::registersharedfunc("manual_turret", "allowPickupOfTurret", &ref_11ac0);
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
  level.sentrysettings["manual_turret"].timeout = getdvarfloat("scr_manualTurret_timeoutOverride", 90);
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
  level.sentrysettings["manual_turret"].votimeout = "timeout_manual_turret";
  level.sentrysettings["manual_turret"].vodestroyed = "destroyed_manual_turret";
  level.sentrysettings["manual_turret"].scorepopup = "destroyed_manual_turret";
  level.sentrysettings["manual_turret"].lightfxtag = "tag_fx";
  level.sentrysettings["manual_turret"].iskillstreak = 1;
  level.sentrysettings["manual_turret"].headiconoffset = (0, 0, 75);
}

function init_manual_turret_vo() {
  game["dialog"]["manual_turret_low_ammo"] = "manual_turret_ammo_low";
  game["dialog"]["manual_turret_no_ammo"] = "manual_turret_no_ammo";
}

function manual_turret_equipment_wrapper(var0, var1, var2) {
  scripts\mp\equipment::takeequipment(var1);
  var3 = scripts\cp_mp\killstreaks\manual_turret::tryusemanualturret("manual_turret");

  if(!var3) {
    scripts\mp\equipment::giveequipment("equip_shieldturret", var1);
    return;
  }

  init_manual_turret_settings();
  init_manual_turret_vo();
  scripts\cp_mp\utility\script_utility::registersharedfunc("manual_turret", "monitorDamage", &manual_turret_monitordamage);
  scripts\cp_mp\utility\script_utility::registersharedfunc("manual_turret", "createHintObject", &manual_turret_createhintobject);
  scripts\cp_mp\utility\script_utility::registersharedfunc("manual_turret", "getTargetMarker", &manual_turret_gettargetmarker);
  scripts\cp_mp\utility\script_utility::registersharedfunc("manual_turret", "getEnemyPlayers", &manual_turret_getenemyplayers);
}

function manual_turret_gettargetmarker(var0, var1) {
  return scripts\mp\killstreaks\target_marker::gettargetmarker(var0, var1);
}

function manual_turret_createhintobject(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10) {
  return scripts\mp\gameobjects::createhintobject(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10);
}

function manual_turret_monitordamage(var0, var1, var2, var3, var4, var5, var6) {
  scripts\mp\damage::monitordamage(var0, var1, var2, var3, var4, var5, var6);
}

function manual_turret_getenemyplayers(var0) {
  return scripts\mp\utility\teams::getenemyplayers(var0);
}

function ref_11ac1(var0) {
  if(isDefined(var0.moving_platform)) {
    var1 = spawnStruct();
    var1.linkparent = var0.moving_platform;
    var1.x1givelaststandoverride = var0.ref_11dbe;
    var1.angleoffset = var0.ref_11dbd;
    var1.endonstring = "carried";
    var1.deathoverridecallback = &ref_11acb;
    var0 thread scripts\mp\movers::handle_moving_platforms(var1);
    return;
  }
}

function ref_11acb(var0) {
  self notify("death");
}

function ref_11ac2() {
  self endon("death_or_disconnect");
  self notify("stop_manual_turret_lastStandWatcher");
  self endon("stop_manual_turret_lastStandWatcher");
  self endon("turret_placement_finished");
  thread scripts\cp_mp\killstreaks\manual_turret::ref_11ac6("last_stand_start");
  self waittill("last_stand_start");
  self notify("equip_deploy_cancel");
}

function ref_11ac0() {
  if(scripts\cp_mp\utility\inventory_utility::isanymonitoredweaponswitchinprogress()) {
    return false;
  }

  if(scripts\cp_mp\utility\killstreak_utility::unsetobjectivemarker(self getcurrentweapon())) {
    return false;
  }

  return true;
}