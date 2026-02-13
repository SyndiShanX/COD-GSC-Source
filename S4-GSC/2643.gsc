/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2643.gsc
*************************************************/

init() {
  scripts\mp\killstreaks\killstreaks::_id_C26A("manual_turret", _id_09BA::_id_F792);
  _id_7FEB();
  _id_7FEC();
  scripts\cp_mp\utility\script_utility::registersharedfunc("manual_turret", "monitorDamage", ::_id_9A61);
  scripts\cp_mp\utility\script_utility::registersharedfunc("manual_turret", "createHintObject", ::_id_9A5C);
  scripts\cp_mp\utility\script_utility::registersharedfunc("manual_turret", "getTargetMarker", ::_id_9A5F);
  scripts\cp_mp\utility\script_utility::registersharedfunc("manual_turret", "getEnemyPlayers", ::_id_9A5E);
  scripts\cp_mp\utility\script_utility::registersharedfunc("manual_turret", "watchForPlayerEnteringLastStand", ::_id_9A60);
}

_id_7FEB() {
  level._id_D0FA["manual_turret"] = spawnStruct();
  level._id_D0FA["manual_turret"].health = 999999;
  level._id_D0FA["manual_turret"].maxhealth = 650;
  level._id_D0FA["manual_turret"]._id_2DB2 = 20;
  level._id_D0FA["manual_turret"]._id_2DB1 = 120;
  level._id_D0FA["manual_turret"]._id_AF6E = 0.15;
  level._id_D0FA["manual_turret"]._id_AF6C = 0.35;
  level._id_D0FA["manual_turret"]._id_D0F8 = "manual";
  level._id_D0FA["manual_turret"]._id_D0F7 = "sentry_offline";
  level._id_D0FA["manual_turret"]._id_16CC = 200;
  level._id_D0FA["manual_turret"]._id_F224 = 90;
  level._id_D0FA["manual_turret"]._id_E410 = 0.05;
  level._id_D0FA["manual_turret"]._id_AD21 = 8.0;
  level._id_D0FA["manual_turret"]._id_3D0F = 0.1;
  level._id_D0FA["manual_turret"]._id_609D = 0.3;
  level._id_D0FA["manual_turret"].streakname = "manual_turret";
  level._id_D0FA["manual_turret"].weaponinfo = "manual_turret_mp";
  level._id_D0FA["manual_turret"]._id_B820 = "manual_turret_mp";
  level._id_D0FA["manual_turret"]._id_03A9 = "ks_manual_turret_mp";
  level._id_D0FA["manual_turret"]._id_9FD2 = "killstreak_wm_mounted_turret";
  level._id_D0FA["manual_turret"]._id_9FD3 = "weapon_wm_mg_mobile_turret";
  level._id_D0FA["manual_turret"]._id_9FD6 = "killstreak_wm_mounted_turret";
  level._id_D0FA["manual_turret"]._id_9FD7 = "weapon_wm_mg_mobile_turret";
  level._id_D0FA["manual_turret"]._id_B16F = &"KILLSTREAKS_HINTS/SENTRY_PLACE";
  level._id_D0FA["manual_turret"]._id_ADB2 = &"KILLSTREAKS_HINTS/SENTRY_OWNER_USE";
  level._id_D0FA["manual_turret"]._id_AC9E = &"KILLSTREAKS_HINTS/SENTRY_OTHER_USE";
  level._id_D0FA["manual_turret"]._id_4B3B = &"KILLSTREAKS_HINTS/SENTRY_DISMANTLE";
  level._id_D0FA["manual_turret"]._id_75E9 = 1;
  level._id_D0FA["manual_turret"]._id_EFAC = "used_manual_turret";
  level._id_D0FA["manual_turret"]._id_484B = "callout_destroyed_manual_turret";
  level._id_D0FA["manual_turret"]._id_DBE2 = 1;
  level._id_D0FA["manual_turret"]._id_106B4 = "timeout_manual_turret";
  level._id_D0FA["manual_turret"]._id_1068F = "destroyed_manual_turret";
  level._id_D0FA["manual_turret"]._id_CC16 = "destroyed_manual_turret";
  level._id_D0FA["manual_turret"]._id_9461 = "tag_fx";
  level._id_D0FA["manual_turret"]._id_88E9 = 1;
  level._id_D0FA["manual_turret"]._id_75F5 = (0, 0, 75);
}

_id_7FEC() {
  game["dialog"]["manual_turret_low_ammo"] = "manual_turret_ammo_low";
  game["dialog"]["manual_turret_no_ammo"] = "manual_turret_no_ammo";
}

_id_9A5D(var_0, var_1, var_2) {
  scripts\mp\equipment::_id_EDBD(var_1);
  var_3 = _id_09BA::_id_F791("manual_turret");

  if(!var_3) {
    scripts\mp\equipment::giveequipment("equip_shieldturret", var_1);
  } else {
    _id_7FEB();
    _id_7FEC();
    scripts\cp_mp\utility\script_utility::registersharedfunc("manual_turret", "monitorDamage", ::_id_9A61);
    scripts\cp_mp\utility\script_utility::registersharedfunc("manual_turret", "createHintObject", ::_id_9A5C);
    scripts\cp_mp\utility\script_utility::registersharedfunc("manual_turret", "getTargetMarker", ::_id_9A5F);
    scripts\cp_mp\utility\script_utility::registersharedfunc("manual_turret", "getEnemyPlayers", ::_id_9A5E);
  }
}

_id_9A5F(var_0, var_1) {
  return _id_0A61::_id_6DBE(var_0, var_1);
}

_id_9A5C(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  return _id_07D6::_id_3FF0(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);
}

_id_9A61(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  _id_07C3::_id_A0FF(var_0, var_1, var_2, var_3, var_4, var_5, var_6);
}

_id_9A5E(var_0) {
  return scripts\mp\utility\teams::_id_69FD(var_0);
}

_id_9A60() {
  self endon("death_or_disconnect");
  self notify("stop_manual_turret_lastStandWatcher");
  self endon("stop_manual_turret_lastStandWatcher");
  self endon("turret_placement_finished");
  thread _id_09BA::_id_9A6E("last_stand_start");
  self waittill("last_stand_start");
  self notify("equip_deploy_cancel");
}