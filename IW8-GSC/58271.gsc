/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: 58271.gsc
***********************************************/

function init() {
  scripts\mp\killstreaks\killstreaks::registerkillstreak("sentry_gun", &scripts\cp_mp\killstreaks\sentry_gun::tryusesentryturretfromstruct);
  scripts\cp_mp\utility\script_utility::registersharedfunc("sentry_gun", "monitorDamage", &ref_13030);
  scripts\cp_mp\utility\script_utility::registersharedfunc("sentry_gun", "createHintObject", &ref_1302B);
  scripts\cp_mp\utility\script_utility::registersharedfunc("sentry_gun", "getTargetMarker", &ref_1302C);
  scripts\cp_mp\utility\script_utility::registersharedfunc("sentry_gun", "initSentrySettings", &ref_1302E);
  scripts\cp_mp\utility\script_utility::registersharedfunc("sentry_gun", "allowPickupOfTurret", &ref_1302A);
  scripts\cp_mp\utility\script_utility::registersharedfunc("sentry_gun", "handleMovingPlatform", &scripts\mp\killstreaks\manual_turret_mp::ref_11AC1);
}

function ref_1302C(var_0, var_1) {
  return scripts\mp\killstreaks\target_marker::gettargetmarker(var_0, var_1);
}

function ref_1302B(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  return scripts\mp\gameobjects::createhintobject(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);
}

function ref_13030(var_0) {
  var_0 thread scripts\mp\damage::monitordamage(var_0.maxhealth, "hitequip", &ref_1302D, &ref_1302F, 1);
}

function ref_1302D(var_0) {
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

function ref_1302F(var_0) {
  var_1 = var_0.attacker;
  var_2 = var_0.objweapon;
  var_3 = var_0.meansofdeath;
  var_4 = var_0.damage;
  var_5 = var_0.idflags;
  var_6 = var_4;
  var_6 = scripts\mp\utility\killstreak::getmodifiedantikillstreakdamage(var_1, var_2, var_3, var_6, self.maxhealth, 2, 3, 4, 12, 400);

  if(var_2.classname == "rocketlauncher" || var_2.classname == "grenade" || var_2.basename == "iw8_sn_t9explosivebow_mp") {
    var_6 *= getdvarfloat("scr_br_turret_expldmg_multiplier", 2);
  }

  return var_6;
}

function ref_1302E() {
  scripts\mp\killstreaks\sentry_gun_mp::sentryturret_initsentrysettings();

  if(isDefined(level.sentrysettings["sentry_turret"])) {
    level.sentrysettings["sentry_turret"].maxhealth = getdvarint("scr_br_sentry_health", 750);
    level.sentrysettings["sentry_turret"].spinuptime = getdvarfloat("scr_br_sentry_spinuptime", 1);
    level.sentrysettings["sentry_turret"].timeout = getdvarint("scr_br_sentry_lifetime", 90);
    level.sentrysettings["sentry_turret"].weaponinfo = "sentry_turret_wz";
    return;
  }
}

function ref_1302A() {
  if(scripts\cp_mp\utility\inventory_utility::isanymonitoredweaponswitchinprogress()) {
    return false;
  }

  if(scripts\cp_mp\utility\killstreak_utility::unsetobjectivemarker(self getcurrentweapon())) {
    return false;
  }

  return true;
}