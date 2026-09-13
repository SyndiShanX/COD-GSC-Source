/****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\killstreaks\sentry_gun_cp.gsc
****************************************************/

init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("sentry_gun", "createHintObject", ::sentryturret_createhintobject);
  scripts\cp_mp\utility\script_utility::registersharedfunc("sentry_gun", "getTargetMarker", ::sentryturret_gettargetmarker);
  scripts\cp_mp\utility\script_utility::registersharedfunc("sentry_gun", "munitionUsed", ::sentryturret_munitionused);
  scripts\cp_mp\utility\script_utility::registersharedfunc("sentry_gun", "munitionSplash", scripts\cp\cp_hud_message::showsplash);
  scripts\cp_mp\utility\script_utility::registersharedfunc("sentry_gun", "initSentrySettings", ::sentryturret_initsentrysettings);
  scripts\cp_mp\utility\script_utility::registersharedfunc("sentry_gun", "watchForPlayerEnteringLastStand", ::sentryturret_laststandwatcher);
  scripts\cp_mp\utility\script_utility::registersharedfunc("sentry_gun", "allowPickupOfTurret", ::sentryturret_allowpickupofturret);
  scripts\cp_mp\utility\script_utility::registersharedfunc("sentry_gun", "monitorDamage", ::sentryturret_monitordamage);
}

sentryturret_gettargetmarker(streakinfo, _id_6152D24062D26039) {
  return scripts\cp\inventory\cp_target_marker::gettargetmarker(streakinfo, _id_6152D24062D26039);
}

sentryturret_createhintobject(org, type, icon, hintstring, priority, duration, onobstruction, hintdist, hintfov, usedist, usefov, _id_DBCE45A33308630D) {
  return scripts\cp\utility::createhintobject(org, type, icon, hintstring, priority, duration, onobstruction, hintdist, hintfov, usedist, usefov, _id_DBCE45A33308630D);
}

sentryturret_munitionused(streakinfo, _id_6152D24062D26039) {
  self notify("munitions_used", "sentry");
  scripts\cp\utility::_id_98F7CA3781DAC77C(self, "sentry");
}

sentryturret_initsentrysettings() {
  _id_3D7610CD3E0A75E6 = 120;

  if(getdvarint("dvar_DD4F9AAE14A06A39", 9999) > 0)
    _id_3D7610CD3E0A75E6 = getdvarint("dvar_DD4F9AAE14A06A39", 9999);

  _id_CA6267F941B2E4B8 = 250;

  if(getdvarint("dvar_203E0CA521E512AE", 250) != 250)
    _id_CA6267F941B2E4B8 = getdvarint("dvar_203E0CA521E512AE", 250);

  level.sentrysettings["sentry_turret"] = spawnStruct();
  level.sentrysettings["sentry_turret"].health = 999999;
  level.sentrysettings["sentry_turret"].maxhealth = getdvarint("dvar_8B8EEC11ECD348E3", 400);
  level.sentrysettings["sentry_turret"].burstmin = 20;
  level.sentrysettings["sentry_turret"].burstmax = 120;
  level.sentrysettings["sentry_turret"].pausemin = 0.15;
  level.sentrysettings["sentry_turret"].pausemax = 0.35;
  level.sentrysettings["sentry_turret"].lockstrength = 2;
  level.sentrysettings["sentry_turret"].sentrymodeon = "sentry";
  level.sentrysettings["sentry_turret"].sentrymodeoff = "sentry_offline";
  level.sentrysettings["sentry_turret"].ammo = _id_CA6267F941B2E4B8;
  level.sentrysettings["sentry_turret"].timeout = _id_3D7610CD3E0A75E6;
  level.sentrysettings["sentry_turret"].spinuptime = 0.65;
  level.sentrysettings["sentry_turret"].overheattime = 8.0;
  level.sentrysettings["sentry_turret"].cooldowntime = 0.1;
  level.sentrysettings["sentry_turret"].fxtime = 0.3;
  level.sentrysettings["sentry_turret"].streakname = "sentry_gun";
  level.sentrysettings["sentry_turret"].weaponinfo = "sentry_turret_mp";
  level.sentrysettings["sentry_turret"].playerweaponinfo = "sentry_turret_mp";
  level.sentrysettings["sentry_turret"].scriptable = "ks_sentry_turret_mp";
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

sentryturret_laststandwatcher() {
  self endon("disconnect");
  self endon("death");
  self notify("stop_sentryTurret_lastStandWatcher");
  self endon("stop_sentryTurret_lastStandWatcher");
  self endon("turret_placement_finished");
  thread scripts\cp_mp\killstreaks\sentry_gun::_id_5C005D2B1101BC78();
  thread scripts\cp_mp\killstreaks\manual_turret::manualturret_clearplacementinstructions("last_stand");
  self waittill("last_stand");
  _id_3B64EB40368C1450::_id_588F2307A3040610("target_marker");
  scripts\cp_mp\killstreaks\manual_turret::manualturret_toggleallowplacementactions(1);
  self.bgivensentry = 0;
}

sentryturret_allowpickupofturret() {
  if(isDefined(level.nuclear_core_carrier)) {
    if(self == level.nuclear_core_carrier)
      return 0;
  }

  if(istrue(self.isjuggernaut)) {
    if(self getclientomnvar("ui_assault_suit_on") == 0) {
      scripts\cp\cp_hud_message::showerrormessage("KILLSTREAKS/JUGG_CANNOT_BE_PICKED_UP");
      return 0;
    }
  }

  if(self _meth_E40102956C887F7C()) {
    scripts\cp\cp_hud_message::showerrormessage("KILLSTREAKS/CANNOT_BE_PICKED_UP_WATER");
    return 0;
  }

  if(self getstance() != "stand") {
    scripts\cp\cp_hud_message::showerrormessage("KILLSTREAKS/CANNOT_BE_PICKED_UP");
    return 0;
  }

  if(istrue(self.has_gl)) {
    scripts\cp\cp_hud_message::showerrormessage("KILLSTREAKS/CANNOT_BE_PICKED_UP");
    return 0;
  }

  return 1;
}

sentryturret_revivedwatcher() {
  self waittill("revive");
  _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("sentry");
}

sentryturret_monitordamage(turret) {
  thread _id_29FF97AED2607BBB(turret);
  turret thread _id_74502A9E0EF1F19C::monitordamage(turret.maxhealth, "hitequip", ::sentryturret_handledeathdamage, ::sentryturret_modifydamage, 1);
}

sentryturret_handledeathdamage(data) {
  attacker = data.attacker;
  objweapon = data.objweapon;
  type = data.meansofdeath;
  damage = data.damage;
  idflags = data.idflags;
  config = level.sentrysettings[self.turrettype];
  _id_3737240CEFE2C793 = scripts\cp\utility::onkillstreakkilled(config.streakname, attacker, objweapon, type, damage, config.scorepopup, config.vodestroyed, config.destroyedsplash);

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

  if(!isDefined(self.damagetaken))
    self.damagetaken = 0;

  _id_08ED0A351AA70EC7 = self.damagetaken + _id_702BFC08FABD86CB;

  if(_id_08ED0A351AA70EC7 >= _id_3A8030D138E837C8.maxhealth * 0.5 && !istrue(self._id_F6F5159041C139CD)) {
    self._id_F6F5159041C139CD = 1;
    self setscriptablepartstate("turret_damage", "on", 0);
  }

  return _id_702BFC08FABD86CB;
}

_id_29FF97AED2607BBB(turret) {
  if(!getdvarint("dvar_6CC448EE583199A9", 1)) {
    return;
  }
  if(!isDefined(turret._id_7ED5BD10C0E0B451)) {
    objindex = scripts\cp\cp_objectives::requestworldid("sentrygun_healthbar");
    objective_state(objindex, "current");
    objective_setshowoncompass(objindex, 0);
    objective_setlabel(objindex, "");
    objective_icon(objindex, "hud_icon_killstreak_sentry");
    objective_onentity(objindex, turret);
    objective_setshowdistance(objindex, 0);
    objective_setbackground(objindex, 1);
    objective_setplayintro(objindex, 0);
    objective_setownerteam(objindex, "allies");
    turret._id_7ED5BD10C0E0B451 = objindex;
    turret thread _id_AE1723F0F841D98A(turret);
    turret thread _id_8F7DC0E13B5D8B1F(turret);
  }
}

_id_AE1723F0F841D98A(turret) {
  self endon("death");
  level endon("game_ended");
  self endon("monitorDamageEnd");
  _id_C463C0F8A46583C5 = self.ammocount;
  scripts\cp\utility::make_entity_sentient_cp("allies");
  self._id_10F81A6BF4F5CE9A = 1;
  objective_setlabel(turret._id_7ED5BD10C0E0B451, &"COOP_CRAFTING/SENTRY_AMMO_100");
  running = 1;

  while(running) {
    scripts\engine\utility::waittill_any_2("turretstatechange", "updateAmmo");
    thread _id_09641BFF828C9FCC();

    if(isDefined(turret._id_7ED5BD10C0E0B451)) {
      _id_B971E09CE070BD58 = 1 - self.streakinfo.shots_fired / _id_C463C0F8A46583C5;
      label = _id_A561A42BCD3D2AA0(_id_B971E09CE070BD58);

      if(isDefined(label))
        objective_setlabel(turret._id_7ED5BD10C0E0B451, label);

      if(_id_B971E09CE070BD58 <= 0)
        turret notify("kill_turret", 0, 0);
    }
  }
}

_id_09641BFF828C9FCC() {
  self notify("sentryTurret_updateAmmoWhileFiring");
  self endon("sentryTurret_updateAmmoWhileFiring");
  self endon("kill_turret");
  self endon("carried");
  level endon("game_ended");

  while(self isfiringturret()) {
    wait 0.5;
    self notify("updateAmmo");
  }
}

_id_A561A42BCD3D2AA0(ammo) {
  if(ammo >= 1)
    return &"COOP_CRAFTING/SENTRY_AMMO_100";
  else if(ammo >= 0.9)
    return &"COOP_CRAFTING/SENTRY_AMMO_90";
  else if(ammo >= 0.8)
    return &"COOP_CRAFTING/SENTRY_AMMO_80";
  else if(ammo >= 0.7)
    return &"COOP_CRAFTING/SENTRY_AMMO_70";
  else if(ammo >= 0.6)
    return &"COOP_CRAFTING/SENTRY_AMMO_60";
  else if(ammo >= 0.5)
    return &"COOP_CRAFTING/SENTRY_AMMO_50";
  else if(ammo >= 0.4)
    return &"COOP_CRAFTING/SENTRY_AMMO_40";
  else if(ammo >= 0.3)
    return &"COOP_CRAFTING/SENTRY_AMMO_30";
  else if(ammo >= 0.2)
    return &"COOP_CRAFTING/SENTRY_AMMO_20";
  else if(ammo >= 0.1)
    return &"COOP_CRAFTING/SENTRY_AMMO_10";
}

_id_BC709891290F6E67(data) {
  turret = data.victim;
  attacker = data.attacker;
  objweapon = data.objweapon;
  type = data.meansofdeath;
  damage = data.damage;
  idflags = data.idflags;
  _id_A93F9D30441FFED1 = 0;

  if(type == "MOD_EXPLOSIVE" || type == "MOD_PROJECTILE" || type == "MOD_PROJECTILE_SPLASH" || type == "MOD_GRENADE_SPLASH")
    _id_A93F9D30441FFED1 = 1;

  self notify("kill_turret", _id_A93F9D30441FFED1, 1);
}

_id_8F7DC0E13B5D8B1F(turret) {
  level endon("game_ended");
  turret waittill("kill_turret");

  if(isDefined(turret._id_7ED5BD10C0E0B451)) {
    objective_delete(turret._id_7ED5BD10C0E0B451);
    scripts\cp\cp_objectives::freeworldidbyobjid(turret._id_7ED5BD10C0E0B451);
  }
}

_id_2D27A885E0D2BED0(damagedata) {
  _id_D7B6456018542238 = _id_25845ACA699D038D::modifydamage;
  _id_702BFC08FABD86CB = self[[_id_D7B6456018542238]](damagedata);
  _id_702BFC08FABD86CB = _id_702BFC08FABD86CB * 0.5;
  return _id_702BFC08FABD86CB;
}

_id_1654F6551333EDF5(turret) {
  turret endon("death");
  level endon("game_ended");
  turret endon("monitorDamageEnd");
  _id_5FF92924E81160F1 = turret.maxhealth * 0.05;
  delay = 16;

  for(;;) {
    wait(delay);

    if(isDefined(turret.carriedby)) {
      continue;
    }
    turret dodamage(_id_5FF92924E81160F1, turret.origin);
  }
}

_id_42FD6416C3355566(player) {
  player.bgivensentry = 0;
  player thread scripts\cp_mp\killstreaks\sentry_gun::tryusesentryturret("sentry_gun");
  wait 0.05;
  failed = 0;

  if(isDefined(player.bgivensentry) && player.bgivensentry == 0)
    failed = 1;

  return failed;
}