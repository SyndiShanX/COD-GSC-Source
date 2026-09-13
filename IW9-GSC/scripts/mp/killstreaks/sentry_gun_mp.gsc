/****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\killstreaks\sentry_gun_mp.gsc
****************************************************/

init() {
  scripts\mp\killstreaks\killstreaks::registerkillstreak("sentry_gun", scripts\cp_mp\killstreaks\sentry_gun::tryusesentryturretfromstruct);
  scripts\cp_mp\utility\script_utility::registersharedfunc("sentry_gun", "monitorDamage", ::sentryturret_monitordamage);
  scripts\cp_mp\utility\script_utility::registersharedfunc("sentry_gun", "createHintObject", ::sentryturret_createhintobject);
  scripts\cp_mp\utility\script_utility::registersharedfunc("sentry_gun", "getTargetMarker", ::sentryturret_gettargetmarker);
  scripts\cp_mp\utility\script_utility::registersharedfunc("sentry_gun", "initSentrySettings", ::sentryturret_initsentrysettings);
  scripts\cp_mp\utility\script_utility::registersharedfunc("sentry_gun", "allowPickupOfTurret", ::sentryturret_canpickup);
  scripts\cp_mp\utility\script_utility::registersharedfunc("sentry_gun", "handleMovingPlatform", scripts\mp\killstreaks\manual_turret_mp::manual_turret_handlemovingplatform);
  scripts\cp_mp\utility\script_utility::registersharedfunc("sentry_gun", "empStarted", ::sentryturret_empstarted);
  scripts\cp_mp\utility\script_utility::registersharedfunc("sentry_gun", "empCleared", ::sentryturret_empcleared);
  scripts\cp_mp\utility\script_utility::registersharedfunc("sentry_gun", "attachXRays", ::_id_21ED6C77FB27D039);
}

sentryturret_gettargetmarker(streakinfo, _id_6152D24062D26039) {
  return scripts\mp\killstreaks\target_marker::gettargetmarker(streakinfo, _id_6152D24062D26039);
}

sentryturret_createhintobject(_id_963953C3478BF4FE, _id_EE1F571F85C89C5C, _id_EFE526BF6A23D275, hintstring, priority, duration, onobstruction, hintdist, hintfov, usedist, usefov) {
  return scripts\mp\gameobjects::createhintobject(_id_963953C3478BF4FE, _id_EE1F571F85C89C5C, _id_EFE526BF6A23D275, hintstring, priority, duration, onobstruction, hintdist, hintfov, usedist, usefov);
}

sentryturret_monitordamage(turret) {
  turret thread scripts\mp\damage::monitordamage(turret.maxhealth, "hitequip", ::sentryturret_handledeathdamage, ::sentryturret_modifydamage, 1);
}

sentryturret_handledeathdamage(data) {
  attacker = data.attacker;
  objweapon = data.objweapon;
  type = data.meansofdeath;
  damage = data.damage;
  idflags = data.idflags;
  config = level.sentrysettings[self.turrettype];
  _id_3737240CEFE2C793 = scripts\mp\damage::onkillstreakkilled(config.streakname, attacker, objweapon, type, damage, config.scorepopup, config.vodestroyed, config.destroyedsplash);

  if(_id_3737240CEFE2C793)
    attacker notify("destroyed_equipment");

  _id_A93F9D30441FFED1 = 0;

  if(type == "MOD_EXPLOSIVE" || type == "MOD_PROJECTILE" || type == "MOD_PROJECTILE_SPLASH" || type == "MOD_GRENADE_SPLASH")
    _id_A93F9D30441FFED1 = 1;

  self notify("kill_turret", _id_A93F9D30441FFED1, 1);
}

sentryturret_modifydamage(data) {
  _id_3A8030D138E837C8 = level.sentrysettings["sentry_turret"];
  attacker = data.attacker;
  objweapon = data.objweapon;
  type = data.meansofdeath;
  damage = data.damage;
  idflags = data.idflags;
  _id_702BFC08FABD86CB = damage;
  _id_702BFC08FABD86CB = scripts\mp\utility\killstreak::getmodifiedantikillstreakdamage(attacker, objweapon, type, _id_702BFC08FABD86CB, self.maxhealth, 2, 3, 4, 12, 400);

  if(!isDefined(self.damagetaken))
    self.damagetaken = 0;

  if(isDefined(objweapon) && objweapon.basename == "throwstar_mp")
    _id_702BFC08FABD86CB = 0;

  _id_08ED0A351AA70EC7 = self.damagetaken + _id_702BFC08FABD86CB;

  if(_id_08ED0A351AA70EC7 >= _id_3A8030D138E837C8.maxhealth * 0.5 && !istrue(self._id_F6F5159041C139CD)) {
    self._id_F6F5159041C139CD = 1;
    self setscriptablepartstate("turret_damage", "on", 0);
  }

  return _id_702BFC08FABD86CB;
}

sentryturret_initsentrysettings() {
  level.sentrysettings["sentry_turret"] = spawnStruct();
  level.sentrysettings["sentry_turret"].health = 999999;
  level.sentrysettings["sentry_turret"].maxhealth = 650;
  level.sentrysettings["sentry_turret"].burstmin = 35;
  level.sentrysettings["sentry_turret"].burstmax = 70;
  level.sentrysettings["sentry_turret"].pausemin = 0.15;
  level.sentrysettings["sentry_turret"].pausemax = 0.25;
  level.sentrysettings["sentry_turret"].lockstrength = 6;
  level.sentrysettings["sentry_turret"].sentrymodeon = "sentry";
  level.sentrysettings["sentry_turret"].sentrymodeoff = "sentry_offline";
  level.sentrysettings["sentry_turret"].timeout = 120;
  level.sentrysettings["sentry_turret"].spinuptime = 0.65;
  level.sentrysettings["sentry_turret"].overheattime = 8.0;
  level.sentrysettings["sentry_turret"].cooldowntime = 0.3;
  level.sentrysettings["sentry_turret"].fxtime = 0.3;
  level.sentrysettings["sentry_turret"].streakname = "sentry_gun";
  level.sentrysettings["sentry_turret"].weaponinfo = "sentry_turret_mp";
  level.sentrysettings["sentry_turret"].playerweaponinfo = "sentry_turret_mp";
  level.sentrysettings["sentry_turret"].modelbaseground = "wpn_wm_p45_mg_auto_sentry_v0_mp";
  level.sentrysettings["sentry_turret"].modeldestroyedground = "wpn_wm_p45_mg_auto_sentry_v0_mp";
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

sentryturret_canpickup() {
  if(scripts\cp_mp\utility\inventory_utility::isanymonitoredweaponswitchinprogress())
    return 0;

  if(scripts\cp_mp\utility\killstreak_utility::iskillstreakdeployweapon(self getcurrentweapon()))
    return 0;

  if(istrue(self.isjuggernaut)) {
    scripts\mp\hud_message::showerrormessage("KILLSTREAKS/JUGG_CANNOT_BE_PICKED_UP");
    return 0;
  }

  if(self _meth_E40102956C887F7C()) {
    scripts\mp\hud_message::showerrormessage("KILLSTREAKS/CANNOT_BE_PICKED_UP_WATER");
    return 0;
  }

  if(!self isonground())
    return 0;

  if(istrue(self.oob))
    return 0;

  return 1;
}

sentryturret_empstarted() {
  self setscriptablepartstate("empd", "active", 0);
}

sentryturret_empcleared() {
  self setscriptablepartstate("empd", "neutral", 0);
}

_id_21ED6C77FB27D039(turret) {
  turret _meth_5226227BCE83EBE9(3, turret.team);
  return turret;
}