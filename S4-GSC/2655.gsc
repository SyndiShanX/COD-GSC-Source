/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2655.gsc
*************************************************/

init() {
  scripts\mp\killstreaks\killstreaks::_id_C26A("sentry_gun", _id_09BB::_id_F79E);
  scripts\cp_mp\utility\script_utility::registersharedfunc("sentry_gun", "monitorDamage", ::_id_D10F);
  scripts\cp_mp\utility\script_utility::registersharedfunc("sentry_gun", "createHintObject", ::_id_D100);
  scripts\cp_mp\utility\script_utility::registersharedfunc("sentry_gun", "getTargetMarker", ::_id_D10A);
  scripts\cp_mp\utility\script_utility::registersharedfunc("sentry_gun", "initSentrySettings", ::_id_D10C);
}

_id_D10A(var_0, var_1) {
  return _id_0A61::_id_6DBE(var_0, var_1);
}

_id_D100(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  return _id_07D6::_id_3FF0(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);
}

_id_D10F(var_0) {
  var_0 thread _id_07C3::_id_A0FF(var_0.maxhealth, "hitequip", ::_id_D10B, ::_id_D10E, 1);
}

_id_D10B(var_0) {
  var_1 = var_0.attacker;
  var_2 = var_0.objweapon;
  var_3 = var_0._id_9CD6;
  var_4 = var_0.damage;
  var_5 = var_0._id_7C97;
  var_6 = level._id_D0FA[self._id_F89C];
  var_7 = _id_07C3::_id_AB18(var_6.streakname, var_1, var_2, var_3, var_4, var_6._id_CC16, var_6._id_1068F, var_6._id_484B);

  if(var_7) {
    var_1 notify("destroyed_equipment");
  }

  var_8 = 0;

  if(var_3 == "MOD_EXPLOSIVE" || var_3 == "MOD_PROJECTILE" || var_3 == "MOD_PROJECTILE_SPLASH" || var_3 == "MOD_GRENADE_SPLASH") {
    var_8 = 1;
  }

  self notify("kill_turret", var_8, 1);
}

_id_D10E(var_0) {
  var_1 = var_0.attacker;
  var_2 = var_0.objweapon;
  var_3 = var_0._id_9CD6;
  var_4 = var_0.damage;
  var_5 = var_0._id_7C97;
  var_6 = var_4;
  var_6 = scripts\mp\utility\killstreak::_id_6B66(var_1, var_2, var_3, var_6, self.maxhealth, 2, 3, 4, 12);
  return var_6;
}

_id_D10C() {
  level._id_D0FA["sentry_turret"] = spawnStruct();
  level._id_D0FA["sentry_turret"].health = 999999;
  level._id_D0FA["sentry_turret"].maxhealth = 650;
  level._id_D0FA["sentry_turret"]._id_2DB2 = 20;
  level._id_D0FA["sentry_turret"]._id_2DB1 = 120;
  level._id_D0FA["sentry_turret"]._id_AF6E = 0.15;
  level._id_D0FA["sentry_turret"]._id_AF6C = 0.35;
  level._id_D0FA["sentry_turret"]._id_9708 = 6;
  level._id_D0FA["sentry_turret"]._id_D0F8 = "sentry";
  level._id_D0FA["sentry_turret"]._id_D0F7 = "sentry_offline";
  level._id_D0FA["sentry_turret"]._id_F224 = 75;
  level._id_D0FA["sentry_turret"]._id_E410 = 0.65;
  level._id_D0FA["sentry_turret"]._id_AD21 = 8.0;
  level._id_D0FA["sentry_turret"]._id_3D0F = 0.3;
  level._id_D0FA["sentry_turret"]._id_609D = 0.3;
  level._id_D0FA["sentry_turret"].streakname = "sentry_gun";
  level._id_D0FA["sentry_turret"].weaponinfo = "sentry_turret_mp";
  level._id_D0FA["sentry_turret"]._id_B820 = "sentry_turret_mp";
  level._id_D0FA["sentry_turret"]._id_03A9 = "ks_sentry_turret_mp";
  level._id_D0FA["sentry_turret"]._id_9FD2 = "killstreak_wm_mounted_turret";
  level._id_D0FA["sentry_turret"]._id_9FD3 = "weapon_wm_mg_sentry_turret";
  level._id_D0FA["sentry_turret"]._id_9FD6 = "killstreak_wm_mounted_turret";
  level._id_D0FA["sentry_turret"]._id_9FD7 = "weapon_wm_mg_sentry_turret";
  level._id_D0FA["sentry_turret"]._id_B16F = &"KILLSTREAKS_HINTS/SENTRY_GUN_PLACE";
  level._id_D0FA["sentry_turret"]._id_ADB2 = &"KILLSTREAKS_HINTS/SENTRY_USE";
  level._id_D0FA["sentry_turret"]._id_AC9E = &"KILLSTREAKS_HINTS/SENTRY_OTHER_USE";
  level._id_D0FA["sentry_turret"]._id_4B3B = &"KILLSTREAKS_HINTS/SENTRY_DISMANTLE";
  level._id_D0FA["sentry_turret"]._id_75E9 = 1;
  level._id_D0FA["sentry_turret"]._id_EFAC = "used_sentry_gun";
  level._id_D0FA["sentry_turret"]._id_484B = "callout_destroyed_sentry_gun";
  level._id_D0FA["sentry_turret"]._id_DBE2 = 1;
  level._id_D0FA["sentry_turret"]._id_106B4 = "destroyed_sentry_gun";
  level._id_D0FA["sentry_turret"]._id_1068F = "destroyed_sentry_gun";
  level._id_D0FA["sentry_turret"]._id_CC16 = "destroyed_sentry";
  level._id_D0FA["sentry_turret"]._id_9461 = "tag_fx";
  level._id_D0FA["sentry_turret"]._id_88E9 = 1;
  level._id_D0FA["sentry_turret"]._id_75F5 = (0, 0, 75);
}