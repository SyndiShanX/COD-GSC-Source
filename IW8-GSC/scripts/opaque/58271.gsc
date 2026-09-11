/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\opaque\58271.gsc
***********************************************/

function init() {
  scripts\mp\killstreaks\killstreaks::registerkillstreak("sentry_gun", &scripts\cp_mp\killstreaks\sentry_gun::tryusesentryturretfromstruct);
  scripts\cp_mp\utility\script_utility::registersharedfunc("sentry_gun", "monitorDamage", &ref_13030);
  scripts\cp_mp\utility\script_utility::registersharedfunc("sentry_gun", "createHintObject", &ref_1302b);
  scripts\cp_mp\utility\script_utility::registersharedfunc("sentry_gun", "getTargetMarker", &ref_1302c);
  scripts\cp_mp\utility\script_utility::registersharedfunc("sentry_gun", "initSentrySettings", &ref_1302e);
  scripts\cp_mp\utility\script_utility::registersharedfunc("sentry_gun", "allowPickupOfTurret", &ref_1302a);
  scripts\cp_mp\utility\script_utility::registersharedfunc("sentry_gun", "handleMovingPlatform", &scripts\mp\killstreaks\manual_turret_mp::ref_11ac1);
}

function ref_1302c(var0, var1) {
  return scripts\mp\killstreaks\target_marker::gettargetmarker(var0, var1);
}

function ref_1302b(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10) {
  return scripts\mp\gameobjects::createhintobject(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10);
}

function ref_13030(var0) {
  var0 thread scripts\mp\damage::monitordamage(var0.maxhealth, "hitequip", &ref_1302d, &ref_1302f, 1);
}

function ref_1302d(var0) {
  var1 = var0.attacker;
  var2 = var0.objweapon;
  var3 = var0.meansofdeath;
  var4 = var0.damage;
  var5 = var0.idflags;
  var6 = level.sentrysettings[self.turrettype];
  var7 = scripts\mp\damage::onkillstreakkilled(var6.streakname, var1, var2, var3, var4, var6.scorepopup, var6.vodestroyed, var6.destroyedsplash);

  if(var7) {
    var1 notify("destroyed_equipment");
  }

  var8 = 0;

  if(var3 == "MOD_EXPLOSIVE" || var3 == "MOD_PROJECTILE" || var3 == "MOD_PROJECTILE_SPLASH" || var3 == "MOD_GRENADE_SPLASH") {
    var8 = 1;
  }

  self notify("kill_turret", var8, 1);
}

function ref_1302f(var0) {
  var1 = var0.attacker;
  var2 = var0.objweapon;
  var3 = var0.meansofdeath;
  var4 = var0.damage;
  var5 = var0.idflags;
  var6 = var4;
  var6 = scripts\mp\utility\killstreak::getmodifiedantikillstreakdamage(var1, var2, var3, var6, self.maxhealth, 2, 3, 4, 12, 400);

  if(var2.classname == "rocketlauncher" || var2.classname == "grenade" || var2.basename == "iw8_sn_t9explosivebow_mp") {
    var6 *= getdvarfloat("scr_br_turret_expldmg_multiplier", 2);
  }

  return var6;
}

function ref_1302e() {
  scripts\mp\killstreaks\sentry_gun_mp::sentryturret_initsentrysettings();

  if(isDefined(level.sentrysettings["sentry_turret"])) {
    level.sentrysettings["sentry_turret"].maxhealth = getdvarint("scr_br_sentry_health", 750);
    level.sentrysettings["sentry_turret"].spinuptime = getdvarfloat("scr_br_sentry_spinuptime", 1);
    level.sentrysettings["sentry_turret"].timeout = getdvarint("scr_br_sentry_lifetime", 90);
    level.sentrysettings["sentry_turret"].weaponinfo = "sentry_turret_wz";
    return;
  }
}

function ref_1302a() {
  if(scripts\cp_mp\utility\inventory_utility::isanymonitoredweaponswitchinprogress()) {
    return false;
  }

  if(scripts\cp_mp\utility\killstreak_utility::unsetobjectivemarker(self getcurrentweapon())) {
    return false;
  }

  return true;
}