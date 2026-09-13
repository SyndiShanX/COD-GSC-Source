/*******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\killstreaks\manual_turret_cp.gsc
*******************************************************/

init() {
  init_manual_turret_settings();
  init_manual_turret_vo();
  scripts\cp_mp\utility\script_utility::registersharedfunc("manual_turret", "monitorDamage", ::manual_turret_monitordamage);
  scripts\cp_mp\utility\script_utility::registersharedfunc("manual_turret", "createHintObject", ::manual_turret_createhintobject);
  scripts\cp_mp\utility\script_utility::registersharedfunc("manual_turret", "getTargetMarker", ::manual_turret_gettargetmarker);
  scripts\cp_mp\utility\script_utility::registersharedfunc("manual_turret", "getEnemyPlayers", ::manual_turret_getenemyplayers);
  scripts\cp_mp\utility\script_utility::registersharedfunc("manual_turret", "munitionUsed", ::manual_turret_munitionused);
  scripts\cp_mp\utility\script_utility::registersharedfunc("manual_turret", "watchForPlayerEnteringLastStand", ::manual_turret_laststandwatcher);
  scripts\cp_mp\utility\script_utility::registersharedfunc("manual_turret", "allowPickupOfTurret", ::manual_turret_allowpickupofturret);
}

init_manual_turret_settings() {
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
  level.sentrysettings["manual_turret"].timeout = 90;
  level.sentrysettings["manual_turret"].spinuptime = 0.05;
  level.sentrysettings["manual_turret"].overheattime = 8.0;
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
  level.sentrysettings["manual_turret"].votimeout = "sentry_shock_timeout";
  level.sentrysettings["manual_turret"].vodestroyed = "sentry_shock_destroy";
  level.sentrysettings["manual_turret"].scorepopup = "destroyed_sentry";
  level.sentrysettings["manual_turret"].lightfxtag = "tag_fx";
  level.sentrysettings["manual_turret"].iskillstreak = 1;
  level.sentrysettings["manual_turret"].headiconoffset = (0, 0, 75);
}

init_manual_turret_vo() {
  game["dialog"]["manual_turret_ammo_low"] = "manual_turret_ammo_low";
  game["dialog"]["manual_turret_no_ammo"] = "manual_turret_no_ammo";
}

manual_turret_gettargetmarker(streakinfo, _id_6152D24062D26039) {
  return scripts\cp\inventory\cp_target_marker::gettargetmarker(streakinfo, _id_6152D24062D26039);
}

manual_turret_createhintobject(_id_963953C3478BF4FE, _id_EE1F571F85C89C5C, _id_EFE526BF6A23D275, hintstring, priority, duration, onobstruction, hintdist, hintfov, usedist, usefov) {
  return scripts\cp\utility::createhintobject(_id_963953C3478BF4FE, _id_EE1F571F85C89C5C, _id_EFE526BF6A23D275, hintstring, priority, duration, onobstruction, hintdist, hintfov, usedist, usefov);
}

manual_turret_monitordamage(maxhealth, damagefeedback, _id_C5D89C3A1224B118, _id_D7B6456018542238, _id_A1823AC1157568DB, rumble, _id_22435C27E2916650) {}

manual_turret_getenemyplayers(team) {
  return scripts\cp\utility::getteamarray(team, 1);
}

manual_turret_munitionused(streakinfo, _id_6152D24062D26039) {
  self notify("munitions_used", "manual_turret");
}

manual_turret_laststandwatcher() {
  self endon("disconnect");
  self endon("death");
  self notify("stop_manual_turret_lastStandWatcher");
  self endon("stop_manual_turret_lastStandWatcher");
  self endon("turret_placement_finished");
  thread scripts\cp_mp\killstreaks\manual_turret::manualturret_clearplacementinstructions("last_stand");
  self waittill("last_stand");
  _id_3B64EB40368C1450::_id_588F2307A3040610("target_marker");
  scripts\cp_mp\killstreaks\manual_turret::manualturret_toggleallowplacementactions(1);
  self.bgivensentry = 0;
}

manual_turret_allowpickupofturret() {
  if(isDefined(level.nuclear_core_carrier)) {
    if(self == level.nuclear_core_carrier)
      return 0;
  }

  return 1;
}