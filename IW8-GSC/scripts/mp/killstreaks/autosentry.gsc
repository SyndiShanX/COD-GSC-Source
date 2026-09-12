/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\killstreaks\autosentry.gsc
*************************************************/

function init() {
  level.sentrytype = [];
  level.sentrytype["super_trophy"] = "super_trophy";
  level.sentrytype["sentry_shock"] = "sentry_shock";
  level.sentrytype["manual_turret"] = "manual_turret";
  level.sentrysettings = [];
  level.sentrysettings["super_trophy"] = spawnStruct();
  level.sentrysettings["super_trophy"].health = 999999;
  level.sentrysettings["super_trophy"].maxhealth = 100;
  level.sentrysettings["super_trophy"].sentrymodeon = "sentry";
  level.sentrysettings["super_trophy"].sentrymodeoff = "sentry_offline";
  level.sentrysettings["super_trophy"].weaponinfo = "sentry_laser_mp";
  level.sentrysettings["super_trophy"].modelbase = "super_trophy_mp";
  level.sentrysettings["super_trophy"].modelgood = "super_trophy_mp_placement";
  level.sentrysettings["super_trophy"].modelbad = "super_trophy_mp_placement_fail";
  level.sentrysettings["super_trophy"].modeldestroyed = "super_trophy_mp";
  level.sentrysettings["super_trophy"].hintstring = &"SENTRY/PICKUP";
  level.sentrysettings["super_trophy"].headicon = 1;
  level.sentrysettings["super_trophy"].teamsplash = "used_super_trophy";
  level.sentrysettings["super_trophy"].shouldsplash = 0;
  level.sentrysettings["super_trophy"].lightfxtag = "tag_fx";
  level.sentrysettings["sentry_shock"] = spawnStruct();
  level.sentrysettings["sentry_shock"].health = 999999;
  level.sentrysettings["sentry_shock"].maxhealth = 670;
  level.sentrysettings["sentry_shock"].burstmin = 20;
  level.sentrysettings["sentry_shock"].burstmax = 120;
  level.sentrysettings["sentry_shock"].pausemin = 0.15;
  level.sentrysettings["sentry_shock"].pausemax = 0.35;
  level.sentrysettings["sentry_shock"].sentrymodeon = "sentry";
  level.sentrysettings["sentry_shock"].sentrymodeoff = "sentry_offline";
  level.sentrysettings["sentry_shock"].timeout = 90;
  level.sentrysettings["sentry_shock"].spinuptime = 0.05;
  level.sentrysettings["sentry_shock"].overheattime = 8;
  level.sentrysettings["sentry_shock"].cooldowntime = 0.1;
  level.sentrysettings["sentry_shock"].fxtime = 0.3;
  level.sentrysettings["sentry_shock"].streakname = "sentry_shock";
  level.sentrysettings["sentry_shock"].weaponinfo = "sentry_shock_mp";
  level.sentrysettings["sentry_shock"].scriptable = "ks_shock_sentry_mp";
  level.sentrysettings["sentry_shock"].modelbase = "shock_sentry_gun_wm";
  level.sentrysettings["sentry_shock"].modelgood = "shock_sentry_gun_wm_obj";
  level.sentrysettings["sentry_shock"].modelbad = "shock_sentry_gun_wm_obj_red";
  level.sentrysettings["sentry_shock"].modeldestroyed = "shock_sentry_gun_wm_destroyed";
  level.sentrysettings["sentry_shock"].hintstring = &"SENTRY/PICKUP";
  level.sentrysettings["sentry_shock"].headicon = 1;
  level.sentrysettings["sentry_shock"].teamsplash = "used_shock_sentry";
  level.sentrysettings["sentry_shock"].destroyedsplash = "callout_destroyed_sentry_shock";
  level.sentrysettings["sentry_shock"].shouldsplash = 1;
  level.sentrysettings["sentry_shock"].votimeout = "sentry_shock_timeout";
  level.sentrysettings["sentry_shock"].vodestroyed = "sentry_shock_destroy";
  level.sentrysettings["sentry_shock"].scorepopup = "destroyed_sentry";
  level.sentrysettings["sentry_shock"].lightfxtag = "tag_fx";
  level.sentrysettings["sentry_shock"].iskillstreak = 1;
  level.sentrysettings["sentry_shock"].headiconoffset = 75;
  level._effect["sentry_overheat_mp"] = loadfx("vfx/core/mp/killstreaks/vfx_sg_overheat_smoke");
  level._effect["sentry_explode_mp"] = loadfx("vfx/iw7/_requests/mp/vfx_generic_equipment_exp_lg.vfx");
  level._effect["sentry_sparks_mp"] = loadfx("vfx/core/mp/killstreaks/vfx_sentry_gun_explosion");
  level._effect["sentry_smoke_mp"] = loadfx("vfx/iw7/_requests/mp/vfx_gen_equip_dam_spark_runner.vfx");
  level._effect["sentry_shock_charge"] = loadfx("vfx/iw7/_requests/mp/vfx_sentry_shock_charge_up.vfx");
  level._effect["sentry_shock_screen"] = loadfx("vfx/iw7/_requests/mp/vfx_sentry_shock_screen");
  level._effect["sentry_shock_base"] = loadfx("vfx/iw7/_requests/mp/vfx_sentry_shock_base");
  level._effect["sentry_shock_radius"] = loadfx("vfx/iw7/_requests/mp/vfx_sentry_shock_radius");
  level._effect["sentry_shock_explosion"] = loadfx("vfx/iw7/_requests/mp/vfx_sentry_shock_end.vfx");
  level._effect["sentry_shock_trail"] = loadfx("vfx/iw7/_requests/mp/vfx_sentry_shock_proj_trail.vfx");
  level._effect["sentry_shock_arc"] = loadfx("vfx/iw7/_requests/mp/vfx_sentry_shock_arc.vfx");
}

function tryuseautosentry(var_0, var_1) {
  var_2 = givesentry("sentry_minigun");

  if(var_2) {
    scripts\common\utility::ref_13E0A(level.ref_11B2A, level.sentrysettings["sentry_minigun"].streakname, self.origin);
  }

  return var_2;
}

function tryusesam(var_0, var_1) {
  var_2 = givesentry("sam_turret");

  if(var_2) {
    scripts\common\utility::ref_13E0A(level.ref_11B2A, level.sentrysettings["sam_turret"].streakname, self.origin);
  }

  return var_2;
}

function tryuseshocksentry(var_0) {
  var_1 = givesentry("sentry_shock", undefined, var_0);

  if(var_1) {
    scripts\common\utility::ref_13E0A(level.ref_11B2A, var_0.streakname, self.origin);
  } else {
    waitframe();
  }

  return var_1;
}

function tryusemanualturret(var_0) {
  var_1 = givesentry("manual_turret", undefined, var_0);

  if(var_1) {
    scripts\common\utility::ref_13E0A(level.ref_11B2A, var_0.streakname, self.origin);
  } else {
    waitframe();
  }

  return var_1;
}

function givesentry(var_0, var_1, var_2) {
  self.last_sentry = var_0;

  if(!isDefined(self.placedsentries)) {
    self.placedsentries = [];
  }

  if(!isDefined(self.placedsentries[var_0])) {
    self.placedsentries[var_0] = [];
  }

  var_3 = 1;

  if(isDefined(var_1)) {
    var_3 = var_1;
  }

  var_4 = createsentryforplayer(var_0, self, var_3, var_2);

  if(isDefined(var_2)) {
    var_2.sentrygun = var_4;
  }

  removeperks();
  self.carriedsentry = var_4;
  var_5 = setcarryingsentry(var_4, 1, var_3);
  self.carriedsentry = undefined;
  thread waitrestoreperks();
  self.iscarrying = 0;

  if(isDefined(var_4)) {
    return 1;
  }

  return 0;
}

function setcarryingsentry(var_0, var_1, var_2, var_3) {
  self endon("death_or_disconnect");
  sentry_setcarried(var_0, self, var_2, var_3);
  scripts\common\utility::allow_usability(0);
  allowweaponsforsentry(0);
  scripts\common\utility::allow_melee(0);
  jumpiftrue(isai(self)) LOC_00000094;
  self notifyonplayercommand("place_sentry", "+attack");
  self notifyonplayercommand("place_sentry", "+attack_akimbo_accessible");
  self notifyonplayercommand("cancel_sentry", "+actionslot 4");
  jumpiftrue(self isconsoleplayer()) LOC_00000094;
  self notifyonplayercommand("cancel_sentry", "+actionslot 5");
  self notifyonplayercommand("cancel_sentry", "+actionslot 6");
  self notifyonplayercommand("cancel_sentry", "+actionslot 7");

  for(;;) {
    var_4 = scripts\engine\utility::ref_143AF("place_sentry", "cancel_sentry", "force_cancel_placement", "emp_applied");

    if(!isDefined(var_0)) {
      allowweaponsforsentry(1);
      scripts\common\utility::allow_usability(1);
      thread enablemeleeforsentry();
      return 1;
    }

    if(var_4 == "cancel_sentry" || var_4 == "force_cancel_placement" || var_4 == "emp_applied") {
      if(!var_1 && (var_4 == "cancel_sentry" || var_4 == "emp_applied")) {
        continue;
      }

      sentry_setcancelled(var_0, var_4 == "force_cancel_placement" && !isDefined(var_0.firstplacement));
      return 0;
    }

    if(!var_0.canbeplaced) {
      continue;
    }

    sentry_setplaced(var_0, var_2);
    return 1;
  }
}

function enablemeleeforsentry() {
  self endon("death_or_disconnect");
  wait 0.25;
  scripts\common\utility::allow_melee(1);
}

function removeweapons() {
  if(self hasweapon("iw6_riotshield_mp")) {
    self.restoreweapon = "iw6_riotshield_mp";
    scripts\cp_mp\utility\inventory_utility::_takeweapon("iw6_riotshield_mp");
    return;
  }
}

function removeperks() {
  if(scripts\mp\utility\perk::_hasperk("specialty_explosivebullets")) {
    self.restoreperk = "specialty_explosivebullets";
    scripts\mp\utility\perk::removeperk("specialty_explosivebullets");
    return;
  }
}

function restoreweapons() {
  if(isDefined(self.restoreweapon)) {
    scripts\cp_mp\utility\inventory_utility::_giveweapon(self.restoreweapon);
    self.restoreweapon = undefined;
    return;
  }
}

function restoreperks() {
  if(isDefined(self.restoreperk)) {
    scripts\mp\utility\perk::giveperk(self.restoreperk);
    self.restoreperk = undefined;
    return;
  }
}

function waitrestoreperks() {
  self endon("death_or_disconnect");
  level endon("game_ended");
  waitframe();
  restoreperks();
}

function createsentryforplayer(var_0, var_1, var_2, var_3) {
  var_4 = level.sentrysettings[var_0].weaponinfo;
  var_5 = spawnturret("misc_turret", var_1.origin, var_4);
  var_5.angles = var_1.angles;
  var_5.streakinfo = var_3;
  sentry_initsentry(var_5, var_0, var_1, var_2);
  thread sentry_destroyongameend();
  var_5 scripts\cp_mp\emp_debuff::allow_emp(0);
  var_5 scripts\cp_mp\emp_debuff::set_start_emp_callback(&sentry_empstarted);
  var_5 scripts\cp_mp\emp_debuff::set_clear_emp_callback(&sentry_empcleared);
  return var_5;
}

function sentry_initsentry(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_3)) {
    var_3 = 1;
  }

  self.sentrytype = var_0;
  self.canbeplaced = 1;
  self setModel(level.sentrysettings[var_0].modelbase);
  self setnodeploy(1);

  if(level.sentrysettings[var_0].shouldsplash) {
    self.shouldsplash = 1;
  } else {
    self.shouldsplash = 0;
  }

  self.firstplacement = 1;
  self setCanDamage(1);

  switch (var_0) {
    case "gl_turret_4":
    case "gl_turret_3":
    case "gl_turret_2":
    case "gl_turret_1":
    case "gl_turret":
    case "minigun_turret_4":
    case "minigun_turret_3":
    case "minigun_turret_2":
    case "minigun_turret_1":
    case "minigun_turret":
      self setleftarc(80);
      self setrightarc(80);
      self setbottomarc(50);
      self setdefaultdroppitch(0);
      self.originalowner = var_1;
      break;
    case "scramble_turret":
    case "sam_turret":
      self maketurretinoperable();
      self setleftarc(180);
      self setrightarc(180);
      self settoparc(80);
      self setdefaultdroppitch(-89);
      self.laser_on = 0;
      var_4 = spawn("script_model", self gettagorigin("tag_laser"));
      var_4 linkTo(self);
      self.killcament = var_4;
      self.killcament setscriptmoverkillcam("explosive");
      break;
    case "sentry_shock":
      self maketurretinoperable();
      var_5 = anglesToForward(self.angles);
      var_6 = self gettagorigin("tag_laser") + (0, 0, 10);
      var_6 -= var_5 * 20;
      var_4 = spawn("script_model", var_6);
      var_4 linkTo(self);
      self.killcament = var_4;
      break;
    case "manual_turret":
      var_5 = anglesToForward(self.angles);
      var_6 = self gettagorigin("tag_laser") + (0, 0, 10);
      var_6 -= var_5 * 20;
      var_4 = spawn("script_model", var_6);
      var_4 linkTo(self);
      self.killcament = var_4;
      break;
    default:
      self maketurretinoperable();
      self setdefaultdroppitch(-89);
      break;
  }

  self setturretmodechangewait(1);
  sentry_setinactive();
  sentry_setowner(var_1);

  if(var_3) {
    thread sentry_timeout();
  }

  switch (var_0) {
    case "minigun_turret_4":
    case "minigun_turret_3":
    case "minigun_turret_2":
    case "minigun_turret_1":
    case "minigun_turret":
      self.momentum = 0;
      self.heatlevel = 0;
      self.overheated = 0;
      thread sentry_heatmonitor();
      break;
    case "gl_turret_4":
    case "gl_turret_3":
    case "gl_turret_2":
    case "gl_turret_1":
    case "gl_turret":
      self.momentum = 0;
      self.heatlevel = 0;
      self.cooldownwaittime = 0;
      self.overheated = 0;
      thread turret_heatmonitor();
      thread turret_coolmonitor();
      break;
    case "scramble_turret":
    case "sam_turret":
    case "sentry_shock":
      self.momentum = 0;
      thread sentry_handleuse(var_2);
      thread sentry_beepsounds();
      break;
    case "manual_turret":
      self.momentum = 0;
      thread sentry_handlemanualuse();
      thread sentry_handlealteratepickup(var_2);
      break;
    case "super_trophy":
      thread sentry_handleuse(0);
      thread sentry_beepsounds();
      break;
    default:
      thread sentry_handleuse(var_2);
      thread sentry_attacktargets();
      thread sentry_beepsounds();
      break;
  }
}

function sentry_setteamheadicon() {
  var_0 = level.sentrysettings[self.sentrytype].headiconoffset;

  if(!isDefined(var_0)) {
    return;
  }

  if(!isDefined(self.owner)) {
    return;
  }

  var_1 = self.owner;
  var_2 = var_1.team;
  self.headiconid = thread scripts\cp_mp\entityheadicons::setheadicon_factionimage(0, var_0, undefined, undefined, undefined, undefined, 1);
}

function sentry_clearteamheadicon() {
  var_0 = level.sentrysettings[self.sentrytype].headiconoffset;

  if(!isDefined(var_0)) {
    return;
  }

  scripts\cp_mp\entityheadicons::setheadicon_deleteicon(self.headiconid);
}

function sentry_destroyongameend() {
  self endon("death");
  level scripts\engine\utility::ref_143A5("bro_shot_start", "game_ended");
  self notify("death");
}

function sentry_handledamage() {
  self endon("carried");
  var_0 = level.sentrysettings[self.sentrytype].maxhealth;
  var_1 = 0;

  if(self.owner scripts\mp\utility\perk::_hasperk("specialty_rugged_eqp")) {
    var_2 = self.weapon_name;

    if(isDefined(var_2)) {
      switch (var_2) {
        default:
          break;
      }
    }
  }

  var_0 += int(var_1);
  scripts\mp\damage::monitordamage(var_0, "sentry", &sentryhandledeathdamage, &sentrymodifydamage, 1);
}

function sentrymodifydamage(var_0) {
  var_1 = var_0.attacker;
  var_2 = var_0.objweapon;
  var_3 = var_0.meansofdeath;
  var_4 = var_0.damage;
  var_5 = var_0.idflags;
  var_6 = var_4;

  if(var_3 == "MOD_MELEE") {
    var_6 = self.maxhealth * 0.34;
  }

  var_6 = scripts\mp\utility\killstreak::getmodifiedantikillstreakdamage(var_1, var_2, var_3, var_6, self.maxhealth, 2, 3, 4);
  return var_6;
}

function sentryhandledeathdamage(var_0) {
  var_1 = var_0.attacker;
  var_2 = var_0.objweapon;
  var_3 = var_0.meansofdeath;
  var_4 = var_0.damage;
  var_5 = var_0.idflags;
  var_6 = level.sentrysettings[self.sentrytype];

  if(var_6.iskillstreak) {
    var_7 = scripts\mp\damage::onkillstreakkilled(var_6.streakname, var_1, var_2, var_3, var_4, var_6.scorepopup, var_6.vodestroyed, var_6.destroyedsplash);

    if(var_7) {
      var_1 notify("destroyed_equipment");
      return;
    }

    return;
  }

  var_8 = undefined;
  var_9 = var_1;

  if(isDefined(var_9) && isDefined(self.owner)) {
    if(isDefined(var_1.owner) && isPlayer(var_1.owner)) {
      var_9 = var_1.owner;
    }

    if(self.owner scripts\mp\utility\player::isenemy(var_9)) {
      var_8 = var_9;
    }
  }

  if(isDefined(var_8)) {
    var_8 thread scripts\mp\events::supershutdown(self.owner);
    var_8 notify("destroyed_equipment");
  }

  self notify("death");
}

function sentry_empstarted(var_0) {
  self.disabled = 1;
  self setdefaultdroppitch(40);
  self setmode(level.sentrysettings[self.sentrytype].sentrymodeoff);
  self cleartargetentity();
  self setscriptablepartstate("muzzle", "neutral", 0);
  self setscriptablepartstate("stunned", "active");
}

function sentry_empcleared(var_0) {
  if(var_0) {
    return;
  }

  self setdefaultdroppitch(-89);
  self setmode(level.sentrysettings[self.sentrytype].sentrymodeon);
  self setscriptablepartstate("stunned", "neutral");
  self.disabled = undefined;
}

function sentry_handledeath() {
  self endon("carried");
  self waittill("death");

  if(isDefined(self.owner)) {
    self.owner.placedsentries[self.sentrytype] = scripts\engine\utility::array_remove(self.owner.placedsentries[self.sentrytype], self);
  }

  if(!isDefined(self)) {
    return;
  }

  self cleartargetentity();
  self laseroff();
  self setModel(level.sentrysettings[self.sentrytype].modeldestroyed);

  if(isDefined(self.fxentdeletelist) && self.fxentdeletelist.size > 0) {
    foreach(var_1 in self.fxentdeletelist) {
      if(isDefined(var_1)) {
        var_1 delete();
      }
    }

    self.fxentdeletelist = undefined;
  }

  sentry_setinactive();
  self setdefaultdroppitch(40);
  self setsentryowner(undefined);

  if(isDefined(self.inuseby)) {
    self useby(self.inuseby);
  }

  self setturretminimapvisible(0);

  if(isDefined(self.ownertrigger)) {
    self.ownertrigger delete();
  }

  self playSound("mp_equip_destroyed");

  switch (self.sentrytype) {
    case "gl_turret":
    case "minigun_turret":
      self.forcedisable = 1;
      self turretfiredisable();
      break;
    default:
      break;
  }

  if(isDefined(self.inuseby)) {
    playFXOnTag(scripts\engine\utility::getfx("sentry_explode_mp"), self, "tag_origin");
    playFXOnTag(scripts\engine\utility::getfx("sentry_smoke_mp"), self, "tag_aim");
    self.inuseby.turret_overheat_bar scripts\mp\hud_util::destroyelem();
    restoreperks(self.inuseby);
    restoreweapons(self.inuseby);
    self notify("deleting");
    wait 1;
    stopFXOnTag(scripts\engine\utility::getfx("sentry_explode_mp"), self, "tag_origin");
    stopFXOnTag(scripts\engine\utility::getfx("sentry_smoke_mp"), self, "tag_aim");
  } else {
    self playSound("sentry_explode_smoke");
    self setscriptablepartstate("destroyed", "sparks");
    wait 5;
    playFX(scripts\engine\utility::getfx("sentry_explode_mp"), self.origin + (0, 0, 10));
    self notify("deleting");
  }

  scripts\mp\weapons::equipmentdeletevfx();

  if(isDefined(self.killcament)) {
    self.killcament delete();
  }

  if(isDefined(self.airlookatent)) {
    self.airlookatent delete();
  }

  if(isDefined(self.manualpickuptrigger)) {
    self.manualpickuptrigger delete();
  }

  scripts\mp\utility\print::printgameaction("killstreak ended - shock_sentry", self.owner);
  self delete();
}

function sentry_handleuse(var_0) {
  self endon("death");
  level endon("game_ended");

  for(;;) {
    self waittill("trigger", var_1);

    if(!scripts\mp\utility\player::isreallyalive(var_1)) {
      continue;
    }

    if(self.sentrytype == "sam_turret" || self.sentrytype == "scramble_turret") {
      self setmode(level.sentrysettings[self.sentrytype].sentrymodeoff);
    }

    var_1.placedsentries[self.sentrytype] = scripts\engine\utility::array_remove(var_1.placedsentries[self.sentrytype], self);
    setcarryingsentry(var_1, self, 0, var_0);
  }
}

function turret_handlepickup(var_0) {
  self endon("disconnect");
  level endon("game_ended");
  var_0 endon("death");

  if(!isDefined(var_0.ownertrigger)) {
    return;
  }

  var_1 = 0;

  for(;;) {
    if(isalive(self) && self istouching(var_0.ownertrigger) && !isDefined(var_0.inuseby) && !isDefined(var_0.carriedby) && self isonground()) {
      if(self useButtonPressed()) {
        var_1 = 0;

        while(self useButtonPressed()) {
          var_1 += level.framedurationseconds;
          waitframe();
        }

        if(var_1 >= 0.5) {
          continue;
        }

        var_1 = 0;

        while(!self useButtonPressed() && var_1 < 0.5) {
          var_1 += level.framedurationseconds;
          waitframe();
        }

        if(var_1 >= 0.5) {
          continue;
        }

        if(!scripts\mp\utility\player::isreallyalive(self)) {
          continue;
        }

        var_0 setmode(level.sentrysettings[var_0.sentrytype].sentrymodeoff);
        thread setcarryingsentry(var_0, 0);
        var_0.ownertrigger delete();
        return;
      }
    }

    waitframe();
  }
}

function turret_handleuse() {
  self notify("turret_handluse");
  self endon("turret_handleuse");
  self endon("deleting");
  level endon("game_ended");
  self.forcedisable = 0;
  var_0 = (1, 0.9, 0.7);
  var_1 = (1, 0.65, 0);
  var_2 = (1, 0.25, 0);

  for(;;) {
    self waittill("trigger", var_3);

    if(isDefined(self.carriedby)) {
      continue;
    }

    if(isDefined(self.inuseby)) {
      continue;
    }

    if(!scripts\mp\utility\player::isreallyalive(var_3)) {
      continue;
    }

    removeperks(var_3);
    removeweapons(var_3);
    self.inuseby = var_3;
    self setmode(level.sentrysettings[self.sentrytype].sentrymodeoff);
    sentry_setowner(var_3);
    self setmode(level.sentrysettings[self.sentrytype].sentrymodeon);
    thread turret_shotmonitor(var_3);
    var_3.turret_overheat_bar = var_3 scripts\mp\hud_util::createbar(var_0, 100, 6);
    var_3.turret_overheat_bar scripts\mp\hud_util::setpoint("CENTER", "BOTTOM", 0, -70);
    var_3.turret_overheat_bar.alpha = 0.65;
    var_3.turret_overheat_bar.bar.alpha = 0.65;
    var_4 = 0;

    for(;;) {
      if(!scripts\mp\utility\player::isreallyalive(var_3)) {
        self.inuseby = undefined;
        var_3.turret_overheat_bar scripts\mp\hud_util::destroyelem();
        break;
      }

      if(!var_3 isusingturret()) {
        self notify("player_dismount");
        self.inuseby = undefined;
        var_3.turret_overheat_bar scripts\mp\hud_util::destroyelem();
        restoreperks(var_3);
        restoreweapons(var_3);
        self setHintString(level.sentrysettings[self.sentrytype].hintstring);
        self setmode(level.sentrysettings[self.sentrytype].sentrymodeoff);
        sentry_setowner(self.originalowner);
        self setmode(level.sentrysettings[self.sentrytype].sentrymodeon);
        break;
      }

      if(self.heatlevel >= level.sentrysettings[self.sentrytype].overheattime) {
        var_5 = 1;
      } else {
        var_5 = self.heatlevel / level.sentrysettings[self.sentrytype].overheattime;
      }

      var_3.turret_overheat_bar scripts\mp\hud_util::updatebar(var_5);

      if(scripts\engine\utility::string_starts_with(self.sentrytype, "minigun_turret")) {
        var_6 = "minigun_turret";
      }

      if(self.forcedisable || self.overheated) {
        self turretfiredisable();
        var_3.turret_overheat_bar.bar.color = var_2;
        var_4 = 0;
      } else if(self.heatlevel > level.sentrysettings[self.sentrytype].overheattime * 0.75 && scripts\engine\utility::string_starts_with(self.sentrytype, "minigun_turret")) {
        var_3.turret_overheat_bar.bar.color = var_1;

        if(randomintrange(0, 10) < 6) {
          self turretfireenable();
        } else {
          self turretfiredisable();
        }

        if(!var_4) {
          var_4 = 1;
          thread playheatfx();
        }
      } else {
        var_3.turret_overheat_bar.bar.color = var_0;
        self turretfireenable();
        var_4 = 0;
        self notify("not_overheated");
      }

      wait 0.05;
    }

    self setdefaultdroppitch(0);
  }
}

function sentry_handleownerdisconnect() {
  self endon("death");
  level endon("game_ended");
  self notify("sentry_handleOwner");
  self endon("sentry_handleOwner");
  GscBinSkip4(0x35, "disconnect");
}

function sentry_watchownerstatus(var_0) {
  self.owner waittill(var_0);
  self notify("death");
}

function sentry_setowner(var_0) {
  self.owner = var_0;
  self setsentryowner(self.owner);
  self setturretminimapvisible(1, self.sentrytype);

  if(level.teambased) {
    self.team = self.owner.team;
    self setturretteam(self.team);
  }

  thread sentry_handleownerdisconnect();
}

function sentry_moving_platform_death(var_0) {
  self notify("death");
}

function sentry_setplaced(var_0) {
  if(isDefined(self.owner)) {
    var_1 = self.owner.placedsentries[self.sentrytype].size;
    self.owner.placedsentries[self.sentrytype][var_1] = self;

    if(var_1 + 1 > 2) {
      self.owner.placedsentries[self.sentrytype][0] notify("death");
    }

    allowweaponsforsentry(self.owner, 1);
    self.owner scripts\common\utility::allow_usability(1);
    thread enablemeleeforsentry();
    self.owner enableworldup(1);
  }

  self setModel(level.sentrysettings[self.sentrytype].modelbase);

  if(self getmode() == "manual") {
    self setmode(level.sentrysettings[self.sentrytype].sentrymodeoff);
  }

  if(self.sentrytype == "sentry_shock") {}

  thread sentry_handledamage();
  thread sentry_handledeath();
  self setsentrycarrier(undefined);
  self setCanDamage(1);

  switch (self.sentrytype) {
    case "gl_turret_4":
    case "gl_turret_3":
    case "gl_turret_2":
    case "gl_turret_1":
    case "gl_turret":
    case "minigun_turret_4":
    case "minigun_turret_3":
    case "minigun_turret_2":
    case "minigun_turret_1":
    case "minigun_turret":
      if(var_0) {
        self.angles = self.carriedby.angles;

        if(isalive(self.originalowner)) {
          self.originalowner scripts\mp\utility\lower_message::setlowermessage("pickup_hint", level.sentrysettings[self.sentrytype].ownerhintstring, 3, undefined, undefined, undefined, undefined, undefined, 1);
        }

        self.ownertrigger = spawn("trigger_radius", self.origin + (0, 0, 1), 0, 105, 64);
        self.ownertrigger enablelinkTo();
        self.ownertrigger linkTo(self);
        thread turret_handlepickup(self.originalowner);
        thread turret_handleuse();
      }

      break;
    case "manual_turret":
      self setdefaultdroppitch(30);
      break;
    default:
      break;
  }

  sentry_makesolid();

  if(isDefined(self.bombsquadmodel)) {
    self.bombsquadmodel show();
    level notify("update_bombsquad");
  }

  self.carriedby forceusehintoff();
  self.carriedby = undefined;
  self.firstplacement = undefined;

  if(isDefined(self.owner)) {
    self.owner.iscarrying = 0;
    self.owner notify("new_sentry", self);
  }

  sentry_setactive(var_0);
  var_2 = spawnStruct();

  if(isDefined(self.moving_platform)) {
    var_2.linkparent = self.moving_platform;
  }

  var_2.endonstring = "carried";
  var_2.deathoverridecallback = &sentry_moving_platform_death;
  thread scripts\mp\movers::handle_moving_platforms(var_2);

  if(self.sentrytype != "multiturret") {
    self playSound("sentry_gun_plant");
  }

  self notify("placed");
}

function sentry_setcancelled(var_0) {
  if(isDefined(self.carriedby)) {
    var_1 = self.carriedby;
    var_1 forceusehintoff();
    var_1.iscarrying = undefined;
    var_1.carrieditem = undefined;
    allowweaponsforsentry(var_1, 1);
    var_1 scripts\common\utility::allow_usability(1);
    thread enablemeleeforsentry();
    var_1 enableworldup(1);

    if(isDefined(self.bombsquadmodel)) {
      self.bombsquadmodel delete();
    }
  }

  if(isDefined(var_0) && var_0) {
    scripts\mp\weapons::equipmentdeletevfx();
  }

  self delete();
}

function sentry_setcarried(var_0, var_1, var_2) {
  if(isDefined(self.originalowner)) {}

  if(self.sentrytype == "sentry_shock") {
    self setscriptablepartstate("muzzle", "neutral", 0);
  }

  self setModel(level.sentrysettings[self.sentrytype].modelgood);
  self setsentrycarrier(var_0);
  self setCanDamage(0);
  sentry_makenotsolid();
  var_0 enableworldup(0);
  self.carriedby = var_0;
  var_0.iscarrying = 1;
  self.pickupenabled = var_1;
  thread sentry_oncarrierdeathoremp(var_0, var_2);
  thread updatesentryplacement(var_0);
  thread sentry_oncarrierdisconnect(var_0);
  thread sentry_oncarrierchangedteam(var_0);
  thread sentry_ongameended();
  scripts\cp_mp\emp_debuff::allow_emp(0);
  self setdefaultdroppitch(-89);
  sentry_setinactive();

  if(isDefined(self getlinkedparent())) {
    self unlink();
  }

  self notify("carried");

  if(isDefined(self.bombsquadmodel)) {
    self.bombsquadmodel hide();
    return;
  }
}

function updatesentryplacement(var_0) {
  self endon("death_or_disconnect");
  level endon("game_ended");
  var_0 endon("placed");
  var_0 endon("death");
  var_0.canbeplaced = 1;
  var_1 = -1;

  for(;;) {
    var_2 = self canplayerplacesentry(1, 40);
    var_0.origin = var_2["origin"];
    var_0.angles = var_2["angles"];
    var_3 = scripts\engine\utility::array_combine(level.turrets, level.microturrets, level.supertrophy.trophies, level.mines);
    var_4 = var_0 getistouchingentities(var_3);
    var_0.canbeplaced = self isonground() && var_2["result"] && abs(var_0.origin[2] - self.origin[2]) < 30 && !scripts\mp\utility\entity::istouchingboundstrigger(self) && var_4.size == 0;

    if(isDefined(var_2["entity"])) {
      var_0.moving_platform = var_2["entity"];
    } else {
      var_0.moving_platform = undefined;
    }

    if(var_0.canbeplaced != var_1) {
      if(var_0.canbeplaced) {
        var_0 setModel(level.sentrysettings[var_0.sentrytype].modelgood);
        placehinton(var_0);
      } else {
        var_0 setModel(level.sentrysettings[var_0.sentrytype].modelbad);
        cannotplacehinton(var_0);
      }
    }

    var_1 = var_0.canbeplaced;
    wait 0.05;
  }
}

function sentry_oncarrierdeathoremp(var_0, var_1) {
  self endon("placed");
  self endon("death");
  var_0 endon("disconnect");
  var_0 scripts\engine\utility::ref_143A5("death", "emp_applied");

  if(self.canbeplaced && !istrue(var_1)) {
    sentry_setplaced(self.pickupenabled);
    return;
  }

  sentry_setcancelled(0);
}

function sentry_oncarrierdisconnect(var_0) {
  self endon("placed");
  self endon("death");
  var_0 waittill("disconnect");
  self delete();
}

function sentry_oncarrierchangedteam(var_0) {
  self endon("placed");
  self endon("death");
  var_0 scripts\engine\utility::ref_143A5("joined_team", "joined_spectators");
  self delete();
}

function sentry_ongameended(var_0) {
  self endon("placed");
  self endon("death");
  level waittill("game_ended");
  self delete();
}

function sentry_setactive(var_0) {
  self setmode(level.sentrysettings[self.sentrytype].sentrymodeon);

  if(var_0) {
    self setCursorHint("HINT_NOICON");
    self setHintString(level.sentrysettings[self.sentrytype].hintstring);
    self makeusable();
  }

  foreach(var_2 in level.players) {
    switch (self.sentrytype) {
      case "gl_turret_4":
      case "gl_turret_3":
      case "gl_turret_2":
      case "gl_turret_1":
      case "gl_turret":
      case "minigun_turret_4":
      case "minigun_turret_3":
      case "minigun_turret_2":
      case "minigun_turret_1":
      case "minigun_turret":
        if(var_0) {
          self enableplayeruse(var_2);
        }

        break;
      default:
        scripts\mp\utility\killstreak::addtoactivekillstreaklist(self.sentrytype, "Killstreak_Ground", self.owner, 0, 1, 70, "carried");

        if(var_2 == self.owner && var_0) {
          self enableplayeruse(var_2);
        } else {
          self disableplayeruse(var_2);
        }

        break;
    }
  }

  var_4 = level.sentrysettings[self.sentrytype].teamsplash;

  if(self.shouldsplash) {
    level thread scripts\mp\hud_util::teamplayercardsplash(var_4, self.owner);
    self.shouldsplash = 0;
  }

  if(self.sentrytype == "sam_turret") {
    thread sam_attacktargets();
  }

  if(self.sentrytype == "scramble_turret") {
    thread scrambleturretattacktargets();
  }

  if(self.sentrytype == "sentry_shock") {
    thread sentryshocktargets();
  }

  scripts\cp_mp\emp_debuff::allow_emp(1);
}

function sentry_setinactive() {
  if(self.sentrytype == "manual_turret") {
    self setHintString("");
    self makeunusable();
  }

  self setmode(level.sentrysettings[self.sentrytype].sentrymodeoff);
  self makeunusable();
}

function sentry_makesolid() {
  self solid();
}

function sentry_makenotsolid() {
  self notsolid();
}

function isfriendlytosentry(var_0) {
  if(level.teambased && self.team == var_0.team) {
    return true;
  }

  return false;
}

function sentry_attacktargets() {
  self endon("death");
  level endon("game_ended");
  self.momentum = 0;
  self.heatlevel = 0;
  self.overheated = 0;
  thread sentry_heatmonitor();

  for(;;) {
    scripts\engine\utility::waittill_either("turretstatechange", "cooled");

    if(self isfiringturret()) {
      thread sentry_burstfirestart();
      continue;
    }

    sentry_spindown();
    thread sentry_burstfirestop();
  }
}

function sentry_timeout() {
  self endon("death");
  level endon("game_ended");
  var_0 = level.sentrysettings[self.sentrytype].timeout;

  if(isDefined(var_0) && var_0 == 0) {
    return;
  }

  while(var_0) {
    wait 1;
    scripts\mp\hostmigration::waittillhostmigrationdone();

    if(!isDefined(self.carriedby)) {
      var_0 = max(0, var_0 - 1);
    }
  }

  if(isDefined(self.owner)) {
    if(isDefined(level.sentrysettings[self.sentrytype].votimeout)) {
      self.owner scripts\mp\utility\dialog::playkillstreakdialogonplayer(level.sentrysettings[self.sentrytype].votimeout, undefined, undefined, self.owner.origin);
    }
  }

  self notify("death");
}

function sentry_targetlocksound() {
  self endon("death");
  self playSound("sentry_gun_beep");
  wait 0.1;
  self playSound("sentry_gun_beep");
  wait 0.1;
  self playSound("sentry_gun_beep");
}

function sentry_spinup() {
  thread sentry_targetlocksound();

  while(self.momentum < level.sentrysettings[self.sentrytype].spinuptime) {
    self.momentum += 0.1;
    wait 0.1;
  }
}

function sentry_spindown() {
  self.momentum = 0;
}

function sentry_laser_burstfirestart() {
  self endon("death");
  self endon("stop_shooting");
  level endon("game_ended");
  sentry_spinup();
  var_0 = weaponfiretime(level.sentrysettings[self.sentrytype].weaponinfo);
  var_1 = level.sentrysettings[self.sentrytype].burstmin;
  var_2 = level.sentrysettings[self.sentrytype].burstmax;

  if(isDefined(self.supportturret) && self.supportturret) {
    var_0 = 0.05;
    var_3 = 50;
  } else {
    var_1 = 0.5 / (self.listoffoundturrets.size + 1);
    var_3 = var_2;
  }

  for(var_4 = 0; var_4 < var_3; var_4++) {
    var_5 = self getturrettarget(1);

    if(!isDefined(var_5)) {
      break;
    }

    self shootturret();
    wait var_1;
  }

  self notify("doneFiring");
  self cleartargetentity();
}

function sentry_burstfirestart() {
  self endon("death");
  self endon("stop_shooting");
  level endon("game_ended");
  sentry_spinup();
  var_0 = weaponfiretime(level.sentrysettings[self.sentrytype].weaponinfo);
  var_1 = level.sentrysettings[self.sentrytype].burstmin;
  var_2 = level.sentrysettings[self.sentrytype].burstmax;
  var_3 = level.sentrysettings[self.sentrytype].pausemin;
  var_4 = level.sentrysettings[self.sentrytype].pausemax;

  for(;;) {
    var_5 = randomintrange(var_1, var_2 + 1);

    for(var_6 = 0; var_6 < var_5 && !self.overheated; var_6++) {
      self shootturret();
      self notify("bullet_fired");
      self.heatlevel += var_0;
      wait var_0;
    }

    wait randomfloatrange(var_3, var_4);
  }
}

function sentry_burstfirestop() {
  self notify("stop_shooting");
}

function turret_shotmonitor(var_0) {
  self endon("death_or_disconnect");
  level endon("game_ended");
  var_0 endon("death");
  var_0 endon("player_dismount");
  var_1 = weaponfiretime(level.sentrysettings[var_0.sentrytype].weaponinfo);

  for(;;) {
    var_0 waittill("turret_fire");
    var_0.heatlevel += var_1;
    var_0.cooldownwaittime = var_1;
  }
}

function sentry_heatmonitor() {
  self endon("death");
  var_0 = weaponfiretime(level.sentrysettings[self.sentrytype].weaponinfo);
  var_1 = 0;
  var_2 = 0;
  var_3 = level.sentrysettings[self.sentrytype].overheattime;
  var_4 = level.sentrysettings[self.sentrytype].cooldowntime;

  for(;;) {
    if(self.heatlevel != var_1) {
      wait var_0;
    } else {
      self.heatlevel = max(0, self.heatlevel - 0.05);
    }

    if(self.heatlevel > var_3) {
      self.overheated = 1;
      thread playheatfx();

      switch (self.sentrytype) {
        case "minigun_turret_4":
        case "minigun_turret_3":
        case "minigun_turret_2":
        case "minigun_turret_1":
        case "minigun_turret":
          playFXOnTag(scripts\engine\utility::getfx("sentry_smoke_mp"), self, "tag_aim");
          break;
        default:
          break;
      }

      while(self.heatlevel) {
        self.heatlevel = max(0, self.heatlevel - var_4);
        wait 0.1;
      }

      self.overheated = 0;
      self notify("not_overheated");
    }

    var_1 = self.heatlevel;
    wait 0.05;
  }
}

function turret_heatmonitor() {
  self endon("death");
  var_0 = level.sentrysettings[self.sentrytype].overheattime;

  for(;;) {
    if(self.heatlevel > var_0) {
      self.overheated = 1;
      thread playheatfx();

      switch (self.sentrytype) {
        case "gl_turret":
          playFXOnTag(scripts\engine\utility::getfx("sentry_smoke_mp"), self, "tag_aim");
          break;
        default:
          break;
      }

      while(self.heatlevel) {
        wait 0.1;
      }

      self.overheated = 0;
      self notify("not_overheated");
    }

    wait 0.05;
  }
}

function turret_coolmonitor() {
  self endon("death");

  for(;;) {
    if(self.heatlevel > 0) {
      if(self.cooldownwaittime <= 0) {
        self.heatlevel = max(0, self.heatlevel - 0.05);
      } else {
        self.cooldownwaittime = max(0, self.cooldownwaittime - 0.05);
      }
    }

    wait 0.05;
  }
}

function playheatfx() {
  self endon("death");
  self endon("not_overheated");
  level endon("game_ended");
  self notify("playing_heat_fx");
  self endon("playing_heat_fx");

  for(;;) {
    playFXOnTag(scripts\engine\utility::getfx("sentry_overheat_mp"), self, "tag_flash");
    wait level.sentrysettings[self.sentrytype].fxtime;
  }
}

function playsmokefx() {
  self endon("death");
  self endon("not_overheated");
  level endon("game_ended");

  for(;;) {
    playFXOnTag(scripts\engine\utility::getfx("sentry_smoke_mp"), self, "tag_aim");
    wait 0.4;
  }
}

function sentry_beepsounds() {
  self endon("death");
  level endon("game_ended");

  for(;;) {
    wait 3;

    if(!isDefined(self.carriedby)) {
      self playSound("sentry_gun_beep");
    }
  }
}

function sam_attacktargets() {
  self endon("carried");
  self endon("death");
  level endon("game_ended");
  self.samtargetent = undefined;
  self.sammissilegroups = [];

  for(;;) {
    self.samtargetent = sam_acquiretarget();
    sam_fireontarget();
    wait 0.05;
  }
}

function sam_acquiretarget() {
  var_0 = self gettagorigin("tag_laser");

  if(!isDefined(self.samtargetent)) {
    jumpiffalse(level.teambased) LOC_000002be;
    var_1 = [];
    var_2 = undefined;
    var_3 = scripts\mp\utility\teams::getenemyteams(self.team);

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "squadAsTeamEnabled")) {
      var_2 = level[[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "squadAsTeamEnabled")]]();
    }

    if(istrue(var_2) && getdvarint("scr_uav_for_squad_only", 1)) {
      foreach(var_5 in var_3) {
        foreach(var_7 in level.squaddata[var_5]) {
          var_8 = var_5 + var_12;

          foreach(var_10 in level.uavmodels[var_8]) {
            var_1 = var_10;
          }
        }
      }
    } else {
      foreach(var_15 in var_3) {
        foreach(var_17 in level.uavmodels[var_15]) {
          var_1 = var_17;
        }
      }
    }

    foreach(var_17 in var_1) {
      if(isDefined(var_17.isleaving) && var_17.isleaving) {
        continue;
      }

      if(sighttracepassed(var_0, var_17.origin, 0, self)) {
        return var_17;
      }
    }

    foreach(var_23 in level.littlebirds) {
      if(isDefined(var_23.team) && var_23.team == self.team) {
        continue;
      }

      if(sighttracepassed(var_0, var_23.origin, 0, self)) {
        return var_23;
      }
    }

    foreach(var_26 in level.helis) {
      if(isDefined(var_26.team) && var_26.team == self.team) {
        continue;
      }

      if(sighttracepassed(var_0, var_26.origin, 0, self)) {
        return var_26;
      }
    }

    foreach(var_17 in level.remote_uav) {
      if(!isDefined(var_17)) {
        continue;
      }

      if(isDefined(var_17.team) && var_17.team == self.team) {
        continue;
      }

      if(sighttracepassed(var_0, var_17.origin, 0, self, var_17)) {
        return var_17;
      }
    }

    goto LOC_0000046b;
  }

  if(!sighttracepassed(var_26, self.samtargetent.origin, 0, self)) {
    self cleartargetentity();
    return undefined;
  }

  return self.samtargetent;
}

function sam_fireontarget() {
  if(isDefined(self.samtargetent)) {
    if(self.samtargetent == level.gunship.planemodel && !isDefined(level.gunshipplayer)) {
      self.samtargetent = undefined;
      self cleartargetentity();
      return;
    }

    self settargetentity(self.samtargetent);
    self waittill("turret_on_target");

    if(!isDefined(self.samtargetent)) {
      return;
    }

    if(!self.laser_on) {
      thread sam_watchlaser();
      thread sam_watchcrashing();
      thread sam_watchleaving();
      thread sam_watchlineofsight();
    }

    wait 2;

    if(!isDefined(self.samtargetent)) {
      return;
    }

    if(self.samtargetent == level.gunship.planemodel && !isDefined(level.gunshipplayer)) {
      self.samtargetent = undefined;
      self cleartargetentity();
      return;
    }

    var_0 = [];
    GscBinSkip0(0x2e, 0, self gettagorigin("tag_le_missile1"));
  }
}

function sam_watchlineofsight() {
  level endon("game_ended");
  self endon("death");

  while(isDefined(self.samtargetent) && isDefined(self getturrettarget(1)) && self getturrettarget(1) == self.samtargetent) {
    var_0 = self gettagorigin("tag_laser");

    if(!sighttracepassed(var_0, self.samtargetent.origin, 0, self, self.samtargetent)) {
      self cleartargetentity();
      self.samtargetent = undefined;
      break;
    }

    wait 0.05;
  }
}

function sam_watchlaser() {
  self endon("death");
  self laseron();
  self.laser_on = 1;

  while(isDefined(self.samtargetent) && isDefined(self getturrettarget(1)) && self getturrettarget(1) == self.samtargetent) {
    waitframe();
  }

  self laseroff();
  self.laser_on = 0;
}

function sam_watchcrashing() {
  self endon("death");
  self.samtargetent endon("death");

  if(!isDefined(self.samtargetent.helitype)) {
    return;
  }

  self.samtargetent waittill("crashing");
  self cleartargetentity();
  self.samtargetent = undefined;
}

function sam_watchleaving() {
  self endon("death");
  self.samtargetent endon("death");

  if(!isDefined(self.samtargetent.model)) {
    return;
  }

  if(self.samtargetent.model == "vehicle_uav_static_mp") {
    self.samtargetent waittill("leaving");
    self cleartargetentity();
    self.samtargetent = undefined;
    return;
  }
}

function scrambleturretattacktargets() {
  self endon("carried");
  self endon("death");
  level endon("game_ended");
  self.scrambletargetent = undefined;

  for(;;) {
    self.scrambletargetent = scramble_acquiretarget();

    if(isDefined(self.scrambletargetent) && isDefined(self.scrambletargetent.scrambled) && !self.scrambletargetent.scrambled) {
      scrambletarget();
    }

    wait 0.05;
  }
}

function scramble_acquiretarget() {
  return sam_acquiretarget();
}

function scrambletarget() {
  if(isDefined(self.scrambletargetent)) {
    if(self.scrambletargetent == level.gunship.planemodel && !isDefined(level.gunshipplayer)) {
      self.scrambletargetent = undefined;
      self cleartargetentity();
      return;
    }

    self settargetentity(self.scrambletargetent);
    self waittill("turret_on_target");

    if(!isDefined(self.scrambletargetent)) {
      return;
    }

    if(!self.laser_on) {
      thread scramble_watchlaser();
      thread scramble_watchcrashing();
      thread scramble_watchleaving();
      thread scramble_watchlineofsight();
    }

    wait 2;

    if(!isDefined(self.scrambletargetent)) {
      return;
    }

    if(self.scrambletargetent == level.gunship.planemodel && !isDefined(level.gunshipplayer)) {
      self.scrambletargetent = undefined;
      self cleartargetentity();
      return;
    }

    if(!isDefined(self.scrambletargetent)) {
      return;
    }

    if(isDefined(self.carriedby)) {
      return;
    }

    self shootturret();
    thread setscrambled();
    self notify("death");
    return;
  }
}

function setscrambled() {
  var_0 = self.scrambletargetent;
  var_0 notify("scramble_fired", self.owner);
  var_0 endon("scramble_fired");
  var_0 endon("death");
  var_0 thread scripts\mp\killstreaks\helicopter::heli_targeting();
  var_0.scrambled = 1;
  var_0.secondowner = self.owner;
  var_0 notify("findNewTarget");
  wait 30;

  if(isDefined(var_0)) {
    var_0.scrambled = 0;
    var_0.secondowner = undefined;
    var_0 thread scripts\mp\killstreaks\helicopter::heli_targeting();
    return;
  }
}

function scramble_watchlineofsight() {
  level endon("game_ended");
  self endon("death");

  while(isDefined(self.scrambletargetent) && isDefined(self getturrettarget(1)) && self getturrettarget(1) == self.scrambletargetent) {
    var_0 = self gettagorigin("tag_laser");

    if(!sighttracepassed(var_0, self.scrambletargetent.origin, 0, self, self.scrambletargetent)) {
      self cleartargetentity();
      self.scrambletargetent = undefined;
      break;
    }

    wait 0.05;
  }
}

function scramble_watchlaser() {
  self endon("death");
  self laseron();
  self.laser_on = 1;

  while(isDefined(self.scrambletargetent) && isDefined(self getturrettarget(1)) && self getturrettarget(1) == self.scrambletargetent) {
    wait 0.05;
  }

  self laseroff();
  self.laser_on = 0;
}

function scramble_watchcrashing() {
  self endon("death");
  self.scrambletargetent endon("death");

  if(!isDefined(self.scrambletargetent.helitype)) {
    return;
  }

  self.scrambletargetent waittill("crashing");
  self cleartargetentity();
  self.scrambletargetent = undefined;
}

function scramble_watchleaving() {
  self endon("death");
  self.scrambletargetent endon("death");

  if(!isDefined(self.scrambletargetent.model)) {
    return;
  }

  if(self.scrambletargetent.model == "vehicle_uav_static_mp") {
    self.scrambletargetent waittill("leaving");
    self cleartargetentity();
    self.scrambletargetent = undefined;
    return;
  }
}

function sentryshocktargets() {
  self endon("death");
  self endon("carried");
  level endon("game_ended");
  thread watchsentryshockpickup();
  self.airlookatent = scripts\engine\utility::spawn_tag_origin(self.origin, self.angles);
  self.airlookatent linkTo(self, "tag_flash");

  for(;;) {
    var_0 = scripts\engine\utility::ref_143B9(1, "turret_on_target");

    if(var_0 == "timeout") {
      continue;
    }

    self.sentryshocktargetent = self getturrettarget(1);

    if(isDefined(self.sentryshocktargetent) && scripts\mp\utility\player::isreallyalive(self.sentryshocktargetent)) {
      thread shocktarget(self.sentryshocktargetent);
      self waittill("done_firing");
    }
  }
}

function searchforshocksentryairtarget() {
  if(isDefined(level.uavmodels)) {
    jumpiffalse(level.teambased) LOC_0000015b;
    var_0 = undefined;
    var_1 = scripts\mp\utility\teams::getenemyteams(self.owner.team);

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "squadAsTeamEnabled")) {
      var_0 = level[[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "squadAsTeamEnabled")]]();
    }

    jumpiffalse(istrue(var_0) && getdvarint("scr_uav_for_squad_only", 1)) LOC_000000f9;

    foreach(var_3 in var_1) {
      foreach(var_5 in level.squaddata[var_3]) {
        var_6 = var_3 + var_10;

        foreach(var_8 in level.uavmodels[var_6]) {
          if(targetvisibleinfront(var_8)) {
            return var_8;
          }
        }
      }
    }

    goto LOC_00000154;
  }

  if(isDefined(level.helis)) {
    foreach(var_19 in level.helis) {
      if(var_19.streakname != "jackal") {
        continue;
      }

      if(level.teambased && var_19.team == self.owner.team) {
        continue;
      }

      if(!level.teambased && var_19.owner == self.owner) {
        continue;
      }

      if(targetvisibleinfront(var_19)) {
        return var_19;
      }
    }

    return;
  }
}

function targetvisibleinfront(var_0) {
  if(!isDefined(var_0)) {
    return 0;
  }

  var_1 = 0;
  var_2 = self gettagorigin("tag_flash");
  var_3 = var_0.origin;
  var_4 = vectorNormalize(var_3 - var_2);
  var_5 = anglesToForward(self.angles);
  var_6 = [self, self.owner, var_0];
  var_7 = physics_createcontents(["physicscontents_solid", "physicscontents_glass", "physicscontents_water", "physicscontents_vehicle", "physicscontents_item"]);

  if(scripts\engine\trace::ray_trace_passed(var_2, var_3, var_6, var_7) && vectordot(var_5, var_4) > 0.25 && distance2dsquared(var_2, var_3) > 10000) {
    var_1 = 1;
  }

  return var_1;
}

function shootshocksentrysamtarget(var_0, var_1) {
  self endon("death");
  self endon("carried");
  level endon("game_ended");
  self setmode("manual");
  thread setshocksamtargetEnt(var_0, var_1);
  self.sentryshocksamtarget = undefined;
  self waittill("turret_on_target");
  thread marktargetlaser(var_0);
  self playSound("shock_sentry_charge_up");
  playFXOnTag(scripts\engine\utility::getfx("sentry_shock_charge"), self, "tag_laser");
  sentry_spinup();
  stopFXOnTag(scripts\engine\utility::getfx("sentry_shock_charge"), self, "tag_laser");
  self notify("start_firing");
  self setscriptablepartstate("coil", "active");
  var_2 = 2;
  var_3 = 1;

  while(isDefined(var_0) && targetvisibleinfront(var_0)) {
    var_4 = self gettagorigin("tag_flash");
    var_5 = scripts\cp_mp\utility\weapon_utility::_magicbullet(getcompleteweaponname("sentry_shock_missile_mp"), var_4, var_0.origin, self.owner);
    var_5 missile_settargetEnt(var_0);
    var_5 missile_setflightmodedirect();
    var_5.killcament = self.killcament;
    var_5.streakinfo = self.streakinfo;
    self setscriptablepartstate("muzzle", "fire" + var_3, 0);
    level notify("laserGuidedMissiles_incoming", self.owner, var_5, var_0);
    var_3++;

    if(var_3 > 2) {
      var_3 = 1;
    }

    wait var_2;
  }

  self setscriptablepartstate("muzzle", "neutral", 0);
  self notify("sentry_lost_target");
  var_1 unlink();
  var_1.origin = self gettagorigin("tag_flash");
  var_1 linkTo(self, "tag_flash");
  self setmode("sentry");
  self cleartargetentity();
  self setscriptablepartstate("coil", "idle");
  sentry_spindown();
  self notify("done_firing");
}

function sentry_handlemanualuse() {
  self endon("death");
  level endon("game_ended");

  for(;;) {
    self waittill("trigger", var_0);

    while(var_0 isusingturret()) {
      if(var_0 attackButtonPressed()) {
        self shootturret();
      }

      waitframe();
    }

    waitframe();
  }
}

function sentry_handlealteratepickup(var_0) {
  self endon("death");
  self.owner endon("disconnect");
  level endon("game_ended");
  self.owner notifyonplayercommand("maunal_sentry_pickup", "+weapnext");
  self.manualpickuptrigger = spawn("trigger_radius", self.origin, 0, 128, 128);
  self.manualpickuptrigger enablelinkTo();
  self.manualpickuptrigger linkTo(self, "tag_origin");

  for(;;) {
    if(isDefined(self.carriedby)) {
      waitframe();
    }

    if(!self.owner istouching(self.manualpickuptrigger)) {
      waitframe();
    }

    self.owner waittill("maunal_sentry_pickup");
    self setmode(level.sentrysettings[self.sentrytype].sentrymodeoff);
    self.owner.placedsentries[self.sentrytype] = scripts\engine\utility::array_remove(self.owner.placedsentries[self.sentrytype], self);
    setcarryingsentry(self.owner, self, 0, var_0);
  }
}

function setshocksamtargetEnt(var_0, var_1) {
  self endon("death");
  self endon("carried");
  self endon("sentry_lost_target");
  var_0 endon("death");
  level endon("game_ended");

  for(;;) {
    var_2 = self gettagorigin("tag_aim");
    var_3 = var_0.origin;
    var_4 = vectorNormalize(var_3 - var_2);
    var_5 = var_2 + var_4 * 500;
    var_1 unlink();
    var_1.origin = var_5;
    var_1 linkTo(self);
    self settargetentity(var_1);
    waitframe();
  }
}

function watchsentryshockpickup() {
  self endon("death");

  for(;;) {
    self waittill("carried");

    if(isDefined(self.sentryshocktargetent)) {
      self.sentryshocktargetent = undefined;
    }

    if(isDefined(self.sentryshocksamtarget)) {
      self.sentryshocksamtarget = undefined;
    }

    self cleartargetentity();
  }
}

function shocktarget(var_0) {
  self endon("death");
  self endon("carried");

  if(!isDefined(var_0)) {
    return;
  }

  thread marktargetlaser(var_0);
  self playSound("shock_sentry_charge_up");
  sentry_spinup();
  self notify("start_firing");
  level thread scripts\mp\battlechatter_mp::saytoself(var_0, "plr_killstreak_target");
  var_1 = weaponfiretime(level.sentrysettings[self.sentrytype].weaponinfo);

  while(isDefined(var_0) && scripts\mp\utility\player::isreallyalive(var_0) && isDefined(self getturrettarget(1)) && self getturrettarget(1) == var_0 && !scripts\mp\utility\outline::outlineoccluded(self gettagorigin("tag_flash"), var_0 getEye())) {
    self shootturret();
    wait var_1;
  }

  self.sentryshocktargetent = undefined;
  self cleartargetentity();
  sentry_spindown();
  self notify("done_firing");
}

function missileburstfire(var_0) {
  self endon("death");
  self endon("carried");
  var_1 = 3;
  var_2 = 1;

  while(var_1 > 0) {
    if(!isDefined(var_0)) {
      return;
    }

    if(!isDefined(self.owner)) {
      return;
    }

    var_3 = scripts\cp_mp\utility\weapon_utility::_magicbullet(getcompleteweaponname("sentry_shock_grenade_mp"), self gettagorigin("tag_flash"), var_0.origin, self.owner);
    var_3 missile_settargetEnt(var_0, gettargetoffset(var_0));
    var_3.killcament = self.killcament;
    var_3.streakinfo = self.streakinfo;
    self setscriptablepartstate("muzzle", "fire" + var_2, 0);
    var_2++;

    if(var_2 > 2) {
      var_2 = 1;
    }

    thread watchtargetchange(var_3);
    var_1--;
    wait 0.2;
  }
}

function gettargetoffset(var_0) {
  var_1 = (0, 0, 40);
  var_2 = var_0 getstance();

  switch (var_2) {
    case "stand":
      var_1 = (0, 0, 40);
      break;
    case "crouch":
      var_1 = (0, 0, 20);
      break;
    case "prone":
      var_1 = (0, 0, 5);
      break;
  }

  return var_1;
}

function watchtargetchange(var_0) {
  self endon("death");
  var_0 endon("disconnect");

  for(;;) {
    if(!scripts\mp\utility\player::isreallyalive(var_0)) {
      self missile_settargetEnt(var_0 getcorpseentity());
      break;
    }

    waitframe();
  }
}

function marktargetlaser(var_0) {
  self endon("death");
  self laseron();
  self.laser_on = 1;
  scripts\engine\utility::ref_143A5("done_firing", "carried");
  self laseroff();
  self.laser_on = 0;
}

function watchshockdamage(var_0) {
  self endon("death");
  self endon("done_firing");
  var_1 = undefined;

  for(;;) {
    self waittill("victim_damaged", var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11);

    if(var_2 == var_0) {
      var_12 = 100;
      var_13 = scripts\mp\utility\player::getplayersinradiusview(var_8, var_12, var_2.team, self.owner);
      playFX(scripts\engine\utility::getfx("sentry_shock_explosion"), var_8);

      if(var_13.size > 0) {
        foreach(var_15 in var_13) {
          if(var_15.player != var_2) {
            var_15.player dodamage(5, var_8, self.owner, self, var_6, var_7);
            var_16 = undefined;
            var_17 = undefined;

            if(var_15.visiblelocations.size > 1) {
              var_17 = randomint(var_15.visiblelocations.size);
              var_16 = var_15.visiblelocations[var_17];
            } else {
              var_16 = var_15.visiblelocations[0];
            }

            playfxbetweenpoints(scripts\engine\utility::getfx("sentry_shock_arc"), var_8, vectortoangles(var_16 - var_8), var_16);
          }
        }
      }
    }
  }
}

function allowweaponsforsentry(var_0) {
  if(var_0) {
    scripts\common\utility::allow_weapon(1);
    thread scripts\mp\supers::unstowsuperweapon();
    return;
  }

  thread scripts\mp\supers::allowsuperweaponstow();
  scripts\common\utility::allow_weapon(0);
}

function placehinton() {
  var_0 = self.sentrytype;

  if(var_0 == "super_trophy") {
    self.owner forceusehinton(&"LUA_MENU_MP/PLACE_SUPER_TROPHY");
    return;
  }

  self.owner forceusehinton(&"SENTRY/PLACE");
}

function cannotplacehinton() {
  var_0 = self.sentrytype;

  if(var_0 == "super_trophy") {
    self.owner forceusehinton(&"LUA_MENU_MP/CANNOT_PLACE_SUPER_TROPHY");
    return;
  }

  self.owner forceusehinton(&"SENTRY/CANNOT_PLACE");
}