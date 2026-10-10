/**********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\killstreaks\manual_turret_mp.gsc
**********************************************************/

#using scripts\common\utility;
#using scripts\cp_mp\killstreaks\manual_turret;
#using scripts\cp_mp\utility\inventory_utility;
#using scripts\cp_mp\utility\killstreak_utility;
#using scripts\engine\utility;
#using scripts\mp\damage;
#using scripts\mp\equipment;
#using scripts\mp\gameobjects;
#using scripts\mp\hud_util;
#using scripts\mp\killstreaks\killstreaks;
#using scripts\mp\killstreaks\target_marker;
#using scripts\mp\movers;
#using scripts\mp\utility\game;
#using scripts\mp\utility\killstreak;
#using scripts\mp\utility\player;
#using scripts\mp\utility\print;
#using scripts\mp\utility\teams;
#namespace manual_turret_mp;

function init() {
  scripts\mp\killstreaks\killstreaks::registerkillstreak("manual_turret", &scripts\cp_mp\killstreaks\manual_turret::tryusemanualturretfromstruct);
  init_manual_turret_settings();
  init_manual_turret_vo();
  scripts\engine\utility::registersharedfunc("manual_turret", "monitorDamage", &manual_turret_monitordamage);
  scripts\engine\utility::registersharedfunc("manual_turret", "createHintObject", &manual_turret_createhintobject);
  scripts\engine\utility::registersharedfunc("manual_turret", "getTargetMarker", &manual_turret_gettargetmarker);
  scripts\engine\utility::registersharedfunc("manual_turret", "getEnemyPlayers", &manual_turret_getenemyplayers);
  scripts\engine\utility::registersharedfunc("manual_turret", "watchForPlayerEnteringLastStand", &manual_turret_laststandwatcher);
  scripts\engine\utility::registersharedfunc("manual_turret", "handleMovingPlatform", &manual_turret_handlemovingplatform);
  scripts\engine\utility::registersharedfunc("manual_turret", "allowPickupOfTurret", &manual_turret_canpickup);
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
  level.sentrysettings["manual_turret"].timeout = getdvarfloat(@ "hash_9775c39c335aab23", 90);
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

function manual_turret_equipment_wrapper(ref, slot, objweapon) {
  scripts\mp\equipment::takeequipment(slot);
  used = scripts\cp_mp\killstreaks\manual_turret::tryusemanualturret("manual_turret");

  if(!used) {
    scripts\mp\equipment::giveequipment("equip_shieldturret", slot);
    return;
  }

  init_manual_turret_settings();
  init_manual_turret_vo();
  scripts\engine\utility::registersharedfunc("manual_turret", "monitorDamage", &manual_turret_monitordamage);
  scripts\engine\utility::registersharedfunc("manual_turret", "createHintObject", &manual_turret_createhintobject);
  scripts\engine\utility::registersharedfunc("manual_turret", "getTargetMarker", &manual_turret_gettargetmarker);
  scripts\engine\utility::registersharedfunc("manual_turret", "getEnemyPlayers", &manual_turret_getenemyplayers);
}

function manual_turret_gettargetmarker(streakinfo, ignorecancel) {
  assertex(isPlayer(self), "<dev string:x1c>");
  return scripts\mp\killstreaks\target_marker::gettargetmarker(streakinfo, ignorecancel);
}

function manual_turret_createhintobject(hintpos, hinttype, hinticon, hintstring, priority, duration, onobstruction, hintdist, hintfov, usedist, usefov) {
  return scripts\mp\gameobjects::createhintobject(hintpos, hinttype, hinticon, hintstring, priority, duration, onobstruction, hintdist, hintfov, usedist, usefov);
}

function manual_turret_monitordamage(maxhealth, damagefeedback, ondeathfunc, var_d7b6456018542238, biskillstreak, rumble, resetdamagetaken) {
  scripts\mp\damage::monitordamage(maxhealth, damagefeedback, ondeathfunc, var_d7b6456018542238, biskillstreak, rumble, resetdamagetaken);
}

function manual_turret_getenemyplayers(team) {
  return scripts\mp\utility\teams::getenemyplayers(team);
}

function manual_turret_handlemovingplatform(turret) {
  if(isDefined(turret.moving_platform)) {
    data = spawnStruct();
    data.linkparent = turret.moving_platform;
    data.linkoffset = turret.moving_platform_offset;
    data.angleoffset = turret.moving_platform_angles_offset;
    data.endonstring = "carried";
    data.deathoverridecallback = &manualturret_moving_platform_death;
    turret thread scripts\mp\movers::handle_moving_platforms(data);
  }
}

function manualturret_moving_platform_death(data) {
  self notify("death");
}

function manual_turret_laststandwatcher() {
  self endon("death_or_disconnect");
  self notify("stop_manual_turret_lastStandWatcher");
  self endon("stop_manual_turret_lastStandWatcher");
  self endon("turret_placement_finished");
  thread scripts\cp_mp\killstreaks\manual_turret::manualturret_clearplacementinstructions("last_stand_start");
  self waittill("last_stand_start");
  self notify("equip_deploy_cancel");
}

function manual_turret_canpickup() {
  if(scripts\cp_mp\utility\inventory_utility::isanymonitoredweaponswitchinprogress()) {
    return false;
  }

  if(scripts\cp_mp\utility\killstreak_utility::iskillstreakdeployweapon(self getcurrentweapon())) {
    return false;
  }

  return true;
}