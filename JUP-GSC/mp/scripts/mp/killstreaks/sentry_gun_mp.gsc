/*******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\killstreaks\sentry_gun_mp.gsc
*******************************************************/

#using scripts\common\damage_tuning;
#using scripts\common\utility;
#using scripts\cp_mp\killstreaks\sentry_gun;
#using scripts\cp_mp\utility\inventory_utility;
#using scripts\cp_mp\utility\killstreak_utility;
#using scripts\cp_mp\utility\weapon_utility;
#using scripts\engine\utility;
#using scripts\mp\damage;
#using scripts\mp\gameobjects;
#using scripts\mp\hud_message;
#using scripts\mp\hud_util;
#using scripts\mp\killstreaks\killstreaks;
#using scripts\mp\killstreaks\manual_turret_mp;
#using scripts\mp\killstreaks\target_marker;
#using scripts\mp\utility\killstreak;
#using scripts\mp\utility\player;
#using scripts\mp\utility\teams;
#namespace sentry_gun_mp;

function init() {
  scripts\mp\killstreaks\killstreaks::registerkillstreak("sentry_gun", &scripts\cp_mp\killstreaks\sentry_gun::tryusesentryturretfromstruct);
  scripts\engine\utility::registersharedfunc("sentry_gun", "monitorDamage", &sentryturret_monitordamage, 1);
  scripts\engine\utility::registersharedfunc("sentry_gun", "createHintObject", &sentryturret_createhintobject);
  scripts\engine\utility::registersharedfunc("sentry_gun", "getTargetMarker", &sentryturret_gettargetmarker);
  scripts\engine\utility::registersharedfunc("sentry_gun", "initSentrySettings", &sentryturret_initsentrysettings);
  scripts\engine\utility::registersharedfunc("sentry_gun", "allowPickupOfTurret", &sentryturret_canpickup);
  scripts\engine\utility::registersharedfunc("sentry_gun", "handleMovingPlatform", &scripts\mp\killstreaks\manual_turret_mp::manual_turret_handlemovingplatform);
  scripts\engine\utility::registersharedfunc("sentry_gun", "empStarted", &sentryturret_empstarted);
  scripts\engine\utility::registersharedfunc("sentry_gun", "empCleared", &sentryturret_empcleared);
  scripts\engine\utility::registersharedfunc("sentry_gun", "attachXRays", &function_21ed6c77fb27d039);
}

function sentryturret_gettargetmarker(streakinfo, ignorecancel) {
  assertex(isPlayer(self), "<dev string:x1c>");
  return scripts\mp\killstreaks\target_marker::gettargetmarker(streakinfo, ignorecancel);
}

function sentryturret_createhintobject(hintpos, hinttype, hinticon, hintstring, priority, duration, onobstruction, hintdist, hintfov, usedist, usefov) {
  return scripts\mp\gameobjects::createhintobject(hintpos, hinttype, hinticon, hintstring, priority, duration, onobstruction, hintdist, hintfov, usedist, usefov);
}

function sentryturret_monitordamage(turret) {
  assertex(isPlayer(self), "<dev string:x1c>");
  turret thread scripts\mp\damage::monitordamage(turret.maxhealth, "hitequip", &sentryturret_handledeathdamage, &sentryturret_modifydamage, 1);
}

function sentryturret_handledeathdamage(data) {
  attacker = data.attacker;
  objweapon = data.objweapon;
  type = data.meansofdeath;
  damage = data.damage;
  idflags = data.idflags;
  config = level.sentrysettings[self.turrettype];

  if(isPlayer(attacker)) {
    notifyattacker = scripts\mp\damage::onkillstreakkilled(config.streakname, attacker, objweapon, type, damage, config.scorepopup, config.vodestroyed, config.destroyedsplash);

    if(notifyattacker) {
      attacker notify("destroyed_equipment");
    }
  }

  self notify("enemy_destroyed_equipment", attacker);
  explosivedamage = 0;

  if(type == "MOD_EXPLOSIVE" || type == "MOD_PROJECTILE" || type == "MOD_PROJECTILE_SPLASH" || type == "MOD_GRENADE_SPLASH") {
    explosivedamage = 1;
  }

  self notify("kill_turret", explosivedamage, 1);
}

function sentryturret_modifydamage(data) {
  sentryconfig = level.sentrysettings["sentry_turret"];
  bundle = level.streakglobals.streakbundles["sentry_gun"];
  attacker = data.attacker;
  objweapon = data.objweapon;
  type = data.meansofdeath;
  damage = data.damage;
  idflags = data.idflags;
  modifieddamage = damage;

  if(istrue(level.var_be6a42242be00b66)) {
    modifieddamage = getmodifieddamageusingdamagetuning(attacker, objweapon, type, modifieddamage, self.maxhealth, bundle.var_e913079a5ffda56d);
  } else {
    modifieddamage = getmodifiedantikillstreakdamage(attacker, objweapon, type, modifieddamage, self.maxhealth, 2, 3, 4, 12, 400);
  }

  if(!isDefined(self.damagetaken)) {
    self.damagetaken = 0;
  }

  if(isDefined(objweapon) && objweapon.basename == "throwstar_mp") {
    modifieddamage = 0;
  }

  var_8ed0a351aa70ec7 = self.damagetaken + modifieddamage;

  if(var_8ed0a351aa70ec7 >= sentryconfig.lowhealth && !istrue(self.damagedstate)) {
    self.damagedstate = 1;
    self setscriptablepartstate("turret_damage", "on", 0);
  }

  return modifieddamage;
}

function sentryturret_initsentrysettings() {
  bundle = level.streakglobals.streakbundles["sentry_gun"];

  if(!isDefined(bundle)) {
    return;
  }

  assert(isDefined(bundle.maxhealth));
  assert(isDefined(bundle.sentrylowhealth));
  assert(isDefined(bundle.spawnweapon));
  level.sentrysettings["sentry_turret"] = spawnStruct();
  level.sentrysettings["sentry_turret"].health = 999999;
  level.sentrysettings["sentry_turret"].maxhealth = default_to(bundle.maxhealth, 650);
  level.sentrysettings["sentry_turret"].lowhealth = default_to(bundle.sentrylowhealth, level.sentrysettings["sentry_turret"].maxhealth * 0.5);
  level.sentrysettings["sentry_turret"].burstmin = 35;
  level.sentrysettings["sentry_turret"].burstmax = 70;
  level.sentrysettings["sentry_turret"].pausemin = 0.15;
  level.sentrysettings["sentry_turret"].pausemax = 0.25;
  level.sentrysettings["sentry_turret"].lockstrength = 6;
  level.sentrysettings["sentry_turret"].sentrymodeon = "sentry";
  level.sentrysettings["sentry_turret"].sentrymodeoff = "sentry_offline";
  level.sentrysettings["sentry_turret"].timeout = 120;
  level.sentrysettings["sentry_turret"].spinuptime = 0.65;
  level.sentrysettings["sentry_turret"].overheattime = 8;
  level.sentrysettings["sentry_turret"].cooldowntime = 0.3;
  level.sentrysettings["sentry_turret"].fxtime = 0.3;
  level.sentrysettings["sentry_turret"].streakname = "sentry_gun";
  level.sentrysettings["sentry_turret"].weaponinfo = default_to(bundle.spawnweapon, "sentry_turret_mp");
  level.sentrysettings["sentry_turret"].playerweaponinfo = "sentry_turret_mp";
  level.sentrysettings["sentry_turret"].modelbaseground = default_to(bundle.sentrymodelbaseground, "wpn_wm_p45_mg_auto_sentry_v0_mp");
  level.sentrysettings["sentry_turret"].modeldestroyedground = default_to(bundle.sentrymodeldestroyed, "wpn_wm_p45_mg_auto_sentry_v0_mp");
  level.sentrysettings["sentry_turret"].placementhintstring = &"KILLSTREAKS_HINTS/SENTRY_GUN_PLACE";
  level.sentrysettings["sentry_turret"].ownerusehintstring = &"KILLSTREAKS_HINTS/SENTRY_USE";
  level.sentrysettings["sentry_turret"].otherusehintstring = &"KILLSTREAKS_HINTS/SENTRY_OTHER_USE";
  level.sentrysettings["sentry_turret"].dismantlehintstring = &"KILLSTREAKS_HINTS/SENTRY_DISMANTLE";
  level.sentrysettings["sentry_turret"].headicon = 1;
  level.sentrysettings["sentry_turret"].teamsplash = "used_sentry_gun";
  level.sentrysettings["sentry_turret"].destroyedsplash = "callout_destroyed_sentry_gun";
  level.sentrysettings["sentry_turret"].shouldsplash = 1;
  level.sentrysettings["sentry_turret"].votimeout = "sentry_gun_teamleader_crash";
  level.sentrysettings["sentry_turret"].vodestroyed = "sentry_gun_teamleader_crash";
  level.sentrysettings["sentry_turret"].scorepopup = "destroyed_sentry";
  level.sentrysettings["sentry_turret"].lightfxtag = "tag_fx";
  level.sentrysettings["sentry_turret"].iskillstreak = 1;
  level.sentrysettings["sentry_turret"].headiconoffset = (0, 0, 75);
}

function sentryturret_canpickup() {
  if(scripts\cp_mp\utility\inventory_utility::isanymonitoredweaponswitchinprogress()) {
    return false;
  }

  if(scripts\cp_mp\utility\killstreak_utility::iskillstreakdeployweapon(self getcurrentweapon())) {
    return false;
  }

  if(istrue(self.isjuggernaut)) {
    scripts\mp\hud_message::showerrormessage("KILLSTREAKS/JUGG_CANNOT_BE_PICKED_UP");
    return false;
  }

  if(self isswimming()) {
    scripts\mp\hud_message::showerrormessage("KILLSTREAKS/CANNOT_BE_PICKED_UP_WATER");
    return false;
  }

  if(!self isonground()) {
    return false;
  }

  if(istrue(self.oob)) {
    return false;
  }

  return true;
}

function sentryturret_empstarted() {
  self setscriptablepartstate("empd", "active", 0);
}

function sentryturret_empcleared() {
  self setscriptablepartstate("empd", "neutral", 0);
}

function function_21ed6c77fb27d039(turret) {
  turret setentityhudoutlinedata(3, turret.team);
  return turret;
}