/*******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\killstreaks\manual_turret_mp.gsc
*******************************************************/

init() {
  scripts\mp\killstreaks\killstreaks::registerkillstreak("manual_turret", scripts\cp_mp\killstreaks\manual_turret::tryusemanualturretfromstruct);
  init_manual_turret_settings();
  init_manual_turret_vo();
  scripts\cp_mp\utility\script_utility::registersharedfunc("manual_turret", "monitorDamage", ::manual_turret_monitordamage);
  scripts\cp_mp\utility\script_utility::registersharedfunc("manual_turret", "createHintObject", ::manual_turret_createhintobject);
  scripts\cp_mp\utility\script_utility::registersharedfunc("manual_turret", "getTargetMarker", ::manual_turret_gettargetmarker);
  scripts\cp_mp\utility\script_utility::registersharedfunc("manual_turret", "getEnemyPlayers", ::manual_turret_getenemyplayers);
  scripts\cp_mp\utility\script_utility::registersharedfunc("manual_turret", "watchForPlayerEnteringLastStand", ::manual_turret_laststandwatcher);
  scripts\cp_mp\utility\script_utility::registersharedfunc("manual_turret", "handleMovingPlatform", ::manual_turret_handlemovingplatform);
  scripts\cp_mp\utility\script_utility::registersharedfunc("manual_turret", "allowPickupOfTurret", ::manual_turret_canpickup);
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
  level.sentrysettings["manual_turret"].timeout = getdvarfloat("dvar_9775C39C335AAB23", 90.0);
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
  level.sentrysettings["manual_turret"].votimeout = "timeout_manual_turret";
  level.sentrysettings["manual_turret"].vodestroyed = "destroyed_manual_turret";
  level.sentrysettings["manual_turret"].scorepopup = "destroyed_manual_turret";
  level.sentrysettings["manual_turret"].lightfxtag = "tag_fx";
  level.sentrysettings["manual_turret"].iskillstreak = 1;
  level.sentrysettings["manual_turret"].headiconoffset = (0, 0, 75);
}

init_manual_turret_vo() {
  game["dialog"]["manual_turret_low_ammo"] = "manual_turret_ammo_low";
  game["dialog"]["manual_turret_no_ammo"] = "manual_turret_no_ammo";
}

manual_turret_equipment_wrapper(ref, slot, objweapon) {
  scripts\mp\equipment::takeequipment(slot);
  used = scripts\cp_mp\killstreaks\manual_turret::tryusemanualturret("manual_turret");

  if(!used)
    scripts\mp\equipment::giveequipment("equip_shieldturret", slot);
  else {
    init_manual_turret_settings();
    init_manual_turret_vo();
    scripts\cp_mp\utility\script_utility::registersharedfunc("manual_turret", "monitorDamage", ::manual_turret_monitordamage);
    scripts\cp_mp\utility\script_utility::registersharedfunc("manual_turret", "createHintObject", ::manual_turret_createhintobject);
    scripts\cp_mp\utility\script_utility::registersharedfunc("manual_turret", "getTargetMarker", ::manual_turret_gettargetmarker);
    scripts\cp_mp\utility\script_utility::registersharedfunc("manual_turret", "getEnemyPlayers", ::manual_turret_getenemyplayers);
  }
}

manual_turret_gettargetmarker(streakinfo, _id_6152D24062D26039) {
  return scripts\mp\killstreaks\target_marker::gettargetmarker(streakinfo, _id_6152D24062D26039);
}

manual_turret_createhintobject(_id_963953C3478BF4FE, _id_EE1F571F85C89C5C, _id_EFE526BF6A23D275, hintstring, priority, duration, onobstruction, hintdist, hintfov, usedist, usefov) {
  return scripts\mp\gameobjects::createhintobject(_id_963953C3478BF4FE, _id_EE1F571F85C89C5C, _id_EFE526BF6A23D275, hintstring, priority, duration, onobstruction, hintdist, hintfov, usedist, usefov);
}

manual_turret_monitordamage(maxhealth, damagefeedback, _id_C5D89C3A1224B118, _id_D7B6456018542238, _id_A1823AC1157568DB, rumble, _id_22435C27E2916650) {
  scripts\mp\damage::monitordamage(maxhealth, damagefeedback, _id_C5D89C3A1224B118, _id_D7B6456018542238, _id_A1823AC1157568DB, rumble, _id_22435C27E2916650);
}

manual_turret_getenemyplayers(team) {
  return scripts\mp\utility\teams::getenemyplayers(team);
}

manual_turret_handlemovingplatform(turret) {
  if(isDefined(turret.moving_platform)) {
    data = spawnStruct();
    data.linkparent = turret.moving_platform;
    data.linkoffset = turret.moving_platform_offset;
    data.angleoffset = turret.moving_platform_angles_offset;
    data.endonstring = "carried";
    data.deathoverridecallback = ::manualturret_moving_platform_death;
    turret thread scripts\mp\movers::handle_moving_platforms(data);
  }
}

manualturret_moving_platform_death(data) {
  self notify("death");
}

manual_turret_laststandwatcher() {
  self endon("death_or_disconnect");
  self notify("stop_manual_turret_lastStandWatcher");
  self endon("stop_manual_turret_lastStandWatcher");
  self endon("turret_placement_finished");
  thread scripts\cp_mp\killstreaks\manual_turret::manualturret_clearplacementinstructions("last_stand_start");
  self waittill("last_stand_start");
  self notify("equip_deploy_cancel");
}

manual_turret_canpickup() {
  if(scripts\cp_mp\utility\inventory_utility::isanymonitoredweaponswitchinprogress())
    return 0;

  if(scripts\cp_mp\utility\killstreak_utility::iskillstreakdeployweapon(self getcurrentweapon()))
    return 0;

  return 1;
}