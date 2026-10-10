/*******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\cp\killstreaks\sentry_gun_cp.gsc
*******************************************************/

#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp\cp_hud_message;
#using scripts\cp\cp_objectives;
#using scripts\cp\damage;
#using scripts\cp\inventory\cp_target_marker;
#using scripts\cp\utility;
#using scripts\cp\weapon;
#using scripts\cp_mp\killstreaks\manual_turret;
#using scripts\cp_mp\killstreaks\sentry_gun;
#using scripts\cp_mp\utility\weapon_utility;
#using scripts\engine\utility;
#namespace sentry_gun_cp;

function init() {
  scripts\engine\utility::registersharedfunc("sentry_gun", "createHintObject", &sentryturret_createhintobject);
  scripts\engine\utility::registersharedfunc("sentry_gun", "getTargetMarker", &sentryturret_gettargetmarker);
  scripts\engine\utility::registersharedfunc("sentry_gun", "munitionUsed", &sentryturret_munitionused);
  scripts\engine\utility::registersharedfunc("sentry_gun", "munitionSplash", &scripts\cp\cp_hud_message::showsplash);
  scripts\engine\utility::registersharedfunc("sentry_gun", "initSentrySettings", &sentryturret_initsentrysettings);
  scripts\engine\utility::registersharedfunc("sentry_gun", "watchForPlayerEnteringLastStand", &sentryturret_laststandwatcher);
  scripts\engine\utility::registersharedfunc("sentry_gun", "allowPickupOfTurret", &sentryturret_allowpickupofturret);
  scripts\engine\utility::registersharedfunc("sentry_gun", "monitorDamage", &sentryturret_monitordamage);
  scripts\engine\utility::registersharedfunc("sentry_gun", "setActionSets", &function_44f3449aec8bc267);
  function_d54473cdf3e580d7();
}

function function_d54473cdf3e580d7() {
  level.var_73bf0234360f5232 = "sentry_turret_placement";
  val::group_register(level.var_73bf0234360f5232, ["cp_munitions_pickup"]);
}

function function_44f3449aec8bc267(value) {
  if(value == 0) {
    val::group_set(level.var_73bf0234360f5232, 0);
    return;
  }

  val::group_reset(level.var_73bf0234360f5232);
}

function sentryturret_gettargetmarker(streakinfo, ignorecancel) {
  assertex(isPlayer(self), "this function needs to be called on a player Entity");
  return scripts\cp\inventory\cp_target_marker::gettargetmarker(streakinfo, ignorecancel);
}

function sentryturret_createhintobject(org, type, icon, hintstring, priority, duration, onobstruction, hintdist, hintfov, usedist, usefov, useent) {
  return scripts\cp\utility::createhintobject(org, type, icon, hintstring, priority, duration, onobstruction, hintdist, hintfov, usedist, usefov, useent);
}

function sentryturret_munitionused(streakinfo, ignorecancel) {
  self notify("munitions_used", "sentry");
  scripts\cp\utility::function_98f7ca3781dac77c(self, "sentry");
}

function function_dad8d4cd587ec141(vehicle) {
  wasdestroyed = 1;
  skipshutdown = 1;
  self.var_455a731f2701dd65 = 1;
  self notify("kill_turret", skipshutdown, wasdestroyed);
}

function sentryturret_initsentrysettings() {
  timeout_seconds = 120;

  if(getdvarint(@ "hash_dd4f9aae14a06a39", 9999) > 0) {
    timeout_seconds = getdvarint(@ "hash_dd4f9aae14a06a39", 9999);
  }

  ammo_amount = 250;

  if(getdvarint(@ "hash_203e0ca521e512ae", 250) != 250) {
    ammo_amount = getdvarint(@ "hash_203e0ca521e512ae", 250);
  }

  level.sentrysettings["sentry_turret"] = spawnStruct();
  level.sentrysettings["sentry_turret"].health = 999999;
  level.sentrysettings["sentry_turret"].maxhealth = getdvarint(@ "hash_8b8eec11ecd348e3", 400);
  level.sentrysettings["sentry_turret"].burstmin = 20;
  level.sentrysettings["sentry_turret"].burstmax = 120;
  level.sentrysettings["sentry_turret"].pausemin = 0.15;
  level.sentrysettings["sentry_turret"].pausemax = 0.35;
  level.sentrysettings["sentry_turret"].lockstrength = 2;
  level.sentrysettings["sentry_turret"].sentrymodeon = "sentry";
  level.sentrysettings["sentry_turret"].sentrymodeoff = "sentry_offline";
  level.sentrysettings["sentry_turret"].ammo = ammo_amount;
  level.sentrysettings["sentry_turret"].timeout = timeout_seconds;
  level.sentrysettings["sentry_turret"].spinuptime = 0.65;
  level.sentrysettings["sentry_turret"].overheattime = 8;
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
  level.sentrysettings["sentry_turret"].var_34d24162c014a897 = &function_dad8d4cd587ec141;
}

function sentryturret_laststandwatcher() {
  self endon("disconnect");
  self endon("death");
  self notify("stop_sentryTurret_lastStandWatcher");
  self endon("stop_sentryTurret_lastStandWatcher");
  self endon("turret_placement_finished");
  thread scripts\cp_mp\killstreaks\sentry_gun::function_5c005d2b1101bc78();
  thread scripts\cp_mp\killstreaks\manual_turret::manualturret_clearplacementinstructions("last_stand");
  self waittill("last_stand");
  val::group_reset("target_marker");
  scripts\cp_mp\killstreaks\manual_turret::manualturret_toggleallowplacementactions(1);
  self.bgivensentry = 0;
}

function sentryturret_allowpickupofturret() {
  if(isDefined(level.nuclear_core_carrier)) {
    if(self == level.nuclear_core_carrier) {
      return false;
    }
  }

  if(istrue(self.isjuggernaut)) {
    if(self getclientomnvar("ui_assault_suit_on") == 0) {
      scripts\cp\cp_hud_message::showerrormessage("KILLSTREAKS/JUGG_CANNOT_BE_PICKED_UP");
      return false;
    }
  }

  if(self isswimming()) {
    scripts\cp\cp_hud_message::showerrormessage("EQUIPMENT/ARMAMENT_CANNOT_BE_USED_WATER");
    return false;
  }

  if(!self isonground()) {
    scripts\cp\cp_hud_message::showerrormessage("EQUIPMENT/ARMAMENT_CANNOT_BE_USED");
    return false;
  }

  if(self getstance() != "stand" && self getstance() != "crouch") {
    scripts\cp\cp_hud_message::showerrormessage("EQUIPMENT/ARMAMENT_CANNOT_BE_USED");
    return false;
  }

  if(istrue(self.has_gl)) {
    scripts\cp\cp_hud_message::showerrormessage("EQUIPMENT/ARMAMENT_CANNOT_BE_USED");
    return false;
  }

  return true;
}

function sentryturret_revivedwatcher() {
  self waittill("revive");
  val::reset_all("sentry");
}

function sentryturret_monitordamage(turret) {
  assertex(isPlayer(self), "this function needs to be called on a player Entity");
  thread function_29ff97aed2607bbb(turret);
  turret thread scripts\cp\weapon::monitordamage(turret.maxhealth, "hitequip", &sentryturret_handledeathdamage, &sentryturret_modifydamage, 1);
}

function sentryturret_handledeathdamage(data) {
  attacker = data.attacker;
  objweapon = data.objweapon;
  type = data.meansofdeath;
  damage = data.damage;
  idflags = data.idflags;
  config = level.sentrysettings[self.turrettype];
  notifyattacker = scripts\cp\utility::onkillstreakkilled(config.streakname, attacker, objweapon, type, damage, config.scorepopup, config.vodestroyed, config.destroyedsplash);

  if(notifyattacker) {
    attacker notify("destroyed_equipment");
  }

  explosivedamage = 0;

  if(type == "MOD_EXPLOSIVE" || type == "MOD_PROJECTILE" || type == "MOD_PROJECTILE_SPLASH" || type == "MOD_GRENADE_SPLASH") {
    explosivedamage = 1;
  }

  self notify("kill_turret", explosivedamage, 1);
}

function sentryturret_modifydamage(data) {
  var_3a8030d138e837c8 = level.sentrysettings["sentry_turret"];
  attacker = data.attacker;
  objweapon = data.objweapon;
  type = data.meansofdeath;
  damage = data.damage;
  idflags = data.idflags;
  modifieddamage = damage;

  if(issharedfuncdefined("killstreak", "getModifiedAntiKillstreakDamage")) {
    modifieddamage = self[[getsharedfunc("killstreak", "getModifiedAntiKillstreakDamage")]](attacker, objweapon, type, modifieddamage, var_3a8030d138e837c8.maxhealth, 1, 1, 1);
  }

  if(!isDefined(self.damagetaken)) {
    self.damagetaken = 0;
  }

  var_8ed0a351aa70ec7 = self.damagetaken + modifieddamage;

  if(var_8ed0a351aa70ec7 >= var_3a8030d138e837c8.maxhealth * 0.5 && !istrue(self.damagedstate)) {
    self.damagedstate = 1;
    self setscriptablepartstate("turret_damage", "on", 0);
  }

  return modifieddamage;
}

function function_29ff97aed2607bbb(turret) {
  assertex(isPlayer(self), "this function needs to be called on a player Entity");

  if(!getdvarint(@ "hash_6cc448ee583199a9", 1)) {
    return;
  }

  if(!isDefined(turret.var_7ed5bd10c0e0b451)) {
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
    turret.var_7ed5bd10c0e0b451 = objindex;
    turret thread function_ae1723f0f841d98a(turret);
    turret thread function_8f7dc0e13b5d8b1f(turret);
  }
}

function function_ae1723f0f841d98a(turret) {
  self endon("death");
  level endon("game_ended");
  self endon("monitorDamageEnd");
  var_c463c0f8a46583c5 = self.ammocount;
  scripts\cp\utility::make_entity_sentient_cp("allies");
  self.var_10f81a6bf4f5ce9a = 1;
  objective_setlabel(turret.var_7ed5bd10c0e0b451, &"COOP_CRAFTING/SENTRY_AMMO_100");
  running = 1;

  while(running) {
    waittill_any_2("turretstatechange", "updateAmmo");
    thread sentryturret_updateammowhilefiring();

    if(isDefined(turret.var_7ed5bd10c0e0b451)) {
      currentammo = 1 - self.streakinfo.shots_fired / var_c463c0f8a46583c5;
      label = function_a561a42bcd3d2aa0(currentammo);

      if(isDefined(label)) {
        objective_setlabel(turret.var_7ed5bd10c0e0b451, label);
      }

      if(currentammo <= 0) {
        turret notify("kill_turret", 0, 0);
      }
    }
  }
}

function sentryturret_updateammowhilefiring() {
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

function function_a561a42bcd3d2aa0(ammo) {
  if(ammo >= 1) {
    return &"COOP_CRAFTING/SENTRY_AMMO_100";
  }

  if(ammo >= 0.9) {
    return &"COOP_CRAFTING/SENTRY_AMMO_90";
  }

  if(ammo >= 0.8) {
    return &"COOP_CRAFTING/SENTRY_AMMO_80";
  }

  if(ammo >= 0.7) {
    return &"COOP_CRAFTING/SENTRY_AMMO_70";
  }

  if(ammo >= 0.6) {
    return &"COOP_CRAFTING/SENTRY_AMMO_60";
  }

  if(ammo >= 0.5) {
    return &"COOP_CRAFTING/SENTRY_AMMO_50";
  }

  if(ammo >= 0.4) {
    return &"COOP_CRAFTING/SENTRY_AMMO_40";
  }

  if(ammo >= 0.3) {
    return &"COOP_CRAFTING/SENTRY_AMMO_30";
  }

  if(ammo >= 0.2) {
    return &"COOP_CRAFTING/SENTRY_AMMO_20";
  }

  if(ammo >= 0.1) {
    return &"COOP_CRAFTING/SENTRY_AMMO_10";
  }
}

function function_bc709891290f6e67(data) {
  turret = data.victim;
  attacker = data.attacker;
  objweapon = data.objweapon;
  type = data.meansofdeath;
  damage = data.damage;
  idflags = data.idflags;
  explosivedamage = 0;

  if(type == "MOD_EXPLOSIVE" || type == "MOD_PROJECTILE" || type == "MOD_PROJECTILE_SPLASH" || type == "MOD_GRENADE_SPLASH") {
    explosivedamage = 1;
  }

  self notify("kill_turret", explosivedamage, 1);
}

function function_8f7dc0e13b5d8b1f(turret) {
  level endon("game_ended");
  turret waittill("kill_turret");

  if(isDefined(turret.var_7ed5bd10c0e0b451)) {
    scripts\cp\cp_objectives::freeworldidbyobjid(turret.var_7ed5bd10c0e0b451);
  }
}

function function_2d27a885e0d2bed0(damagedata) {
  var_d7b6456018542238 = &scripts\cp\damage::modifydamage;
  modifieddamage = self[[var_d7b6456018542238]](damagedata);
  modifieddamage *= 0.5;
  return modifieddamage;
}

function function_1654f6551333edf5(turret) {
  turret endon("death");
  level endon("game_ended");
  turret endon("monitorDamageEnd");
  var_5ff92924e81160f1 = turret.maxhealth * 0.05;
  delay = 16;

  while(true) {
    wait delay;

    if(isDefined(turret.carriedby)) {
      continue;
    }

    turret dodamage(var_5ff92924e81160f1, turret.origin);
  }
}

function function_42fd6416c3355566(player) {
  player.bgivensentry = 0;
  player thread scripts\cp_mp\killstreaks\sentry_gun::tryusesentryturret("sentry_gun");
  wait 0.05;
  failed = 0;

  if(isDefined(player.bgivensentry) && player.bgivensentry == 0) {
    failed = 1;
  }

  return failed;
}