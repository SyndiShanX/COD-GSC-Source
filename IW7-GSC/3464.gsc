/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3464.gsc
**************************************/

init() {
  level.sentrytype = [];
  level.sentrytype["sentry_minigun"] = "sentry";
  level.sentrytype["sam_turret"] = "sam_turret";
  level.sentrytype["super_trophy"] = "super_trophy";
  level.sentrytype["sentry_shock"] = "sentry_shock";
  scripts\mp\killstreaks\killstreaks::registerkillstreak("sentry_shock", ::tryuseshocksentry);
  scripts\mp\killstreak_loot::func_DF07("sentry_shock", ["passive_extra_health", "passive_increased_duration"]);
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
  level.sentrysettings["super_trophy"].hintstring = &"SENTRY_PICKUP";
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
  level.sentrysettings["sentry_shock"].timeout = 90.0;
  level.sentrysettings["sentry_shock"].spinuptime = 0.05;
  level.sentrysettings["sentry_shock"].overheattime = 8.0;
  level.sentrysettings["sentry_shock"].cooldowntime = 0.1;
  level.sentrysettings["sentry_shock"].fxtime = 0.3;
  level.sentrysettings["sentry_shock"].streakname = "sentry_shock";
  level.sentrysettings["sentry_shock"].weaponinfo = "sentry_shock_mp";
  level.sentrysettings["sentry_shock"].scriptable = "ks_shock_sentry_mp";
  level.sentrysettings["sentry_shock"].modelbase = "shock_sentry_gun_wm";
  level.sentrysettings["sentry_shock"].modelgood = "shock_sentry_gun_wm_obj";
  level.sentrysettings["sentry_shock"].modelbad = "shock_sentry_gun_wm_obj_red";
  level.sentrysettings["sentry_shock"].modeldestroyed = "shock_sentry_gun_wm_destroyed";
  level.sentrysettings["sentry_shock"].hintstring = &"SENTRY_PICKUP";
  level.sentrysettings["sentry_shock"].headicon = 1;
  level.sentrysettings["sentry_shock"].teamsplash = "used_shock_sentry";
  level.sentrysettings["sentry_shock"].destroyedsplash = "callout_destroyed_sentry_shock";
  level.sentrysettings["sentry_shock"].shouldsplash = 1;
  level.sentrysettings["sentry_shock"].votimeout = "sentry_shock_timeout";
  level.sentrysettings["sentry_shock"].vodestroyed = "sentry_shock_destroy";
  level.sentrysettings["sentry_shock"].scorepopup = "destroyed_sentry";
  level.sentrysettings["sentry_shock"].lightfxtag = "tag_fx";
  level.sentrysettings["sentry_shock"].iskillstreak = 1;
  level.sentrysettings["sentry_shock"].headiconoffset = (0, 0, 75);
  level._effect["sentry_overheat_mp"] = loadfx("vfx\core\mp\killstreaks\vfx_sg_overheat_smoke");
  level._effect["sentry_explode_mp"] = loadfx("vfx\iw7\_requests\mp\vfx_generic_equipment_exp_lg.vfx");
  level._effect["sentry_sparks_mp"] = loadfx("vfx\core\mp\killstreaks\vfx_sentry_gun_explosion");
  level._effect["sentry_smoke_mp"] = loadfx("vfx\iw7\_requests\mp\vfx_gen_equip_dam_spark_runner.vfx");
  level._effect["sentry_shock_charge"] = loadfx("vfx\iw7\_requests\mp\vfx_sentry_shock_charge_up.vfx");
  level._effect["sentry_shock_screen"] = loadfx("vfx\iw7\_requests\mp\vfx_sentry_shock_screen");
  level._effect["sentry_shock_base"] = loadfx("vfx\iw7\_requests\mp\vfx_sentry_shock_base");
  level._effect["sentry_shock_radius"] = loadfx("vfx\iw7\_requests\mp\vfx_sentry_shock_radius");
  level._effect["sentry_shock_explosion"] = loadfx("vfx\iw7\_requests\mp\vfx_sentry_shock_end.vfx");
  level._effect["sentry_shock_trail"] = loadfx("vfx\iw7\_requests\mp\vfx_sentry_shock_proj_trail.vfx");
  level._effect["sentry_shock_arc"] = loadfx("vfx\iw7\_requests\mp\vfx_sentry_shock_arc.vfx");
  var_0 = ["passive_fast_sweep", "passive_decreased_health", "passive_sam_turret", "passive_no_shock", "passive_mini_explosives", "passive_slow_turret"];
  scripts\mp\killstreak_loot::func_DF07("sentry_shock", var_0);
}

tryuseautosentry(var_0, var_1) {
  var_2 = givesentry("sentry_minigun");

  if(var_2) {
    scripts\mp\matchdata::logkillstreakevent(level.sentrysettings["sentry_minigun"].streakname, self.origin);
  }

  return var_2;
}

tryusesam(var_0, var_1) {
  var_2 = givesentry("sam_turret");

  if(var_2) {
    scripts\mp\matchdata::logkillstreakevent(level.sentrysettings["sam_turret"].streakname, self.origin);
  }

  return var_2;
}

tryuseshocksentry(var_0) {
  var_1 = givesentry("sentry_shock", undefined, var_0);

  if(var_1) {
    scripts\mp\matchdata::logkillstreakevent(var_0.streakname, self.origin);
  } else {
    scripts\engine\utility::waitframe();
  }

  return var_1;
}

givesentry(var_0, var_1, var_2) {
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
  } else {
    return 0;
  }
}

setcarryingsentry(var_0, var_1, var_2, var_3) {
  self endon("death");
  self endon("disconnect");
  var_0 sentry_setcarried(self, var_2, var_3);
  scripts\engine\utility::allow_usability(0);
  allowweaponsforsentry(0);
  scripts\engine\utility::allow_melee(0);

  if(!isai(self)) {
    self notifyonplayercommand("place_sentry", "+attack");
    self notifyonplayercommand("place_sentry", "+attack_akimbo_accessible");
    self notifyonplayercommand("cancel_sentry", "+actionslot 4");

    if(!level.console) {
      self notifyonplayercommand("cancel_sentry", "+actionslot 5");
      self notifyonplayercommand("cancel_sentry", "+actionslot 6");
      self notifyonplayercommand("cancel_sentry", "+actionslot 7");
    }
  }

  for(;;) {
    var_4 = scripts\engine\utility::waittill_any_return("place_sentry", "cancel_sentry", "force_cancel_placement", "apply_player_emp");

    if(!isDefined(var_0)) {
      allowweaponsforsentry(1);
      scripts\engine\utility::allow_usability(1);
      thread enablemeleeforsentry();
      return 1;
    }

    if(var_4 == "cancel_sentry" || var_4 == "force_cancel_placement" || var_4 == "apply_player_emp") {
      if(!var_1 && (var_4 == "cancel_sentry" || var_4 == "apply_player_emp")) {
        continue;
      }
      var_0 sentry_setcancelled(var_4 == "force_cancel_placement" && !isDefined(var_0.firstplacement));
      return 0;
    }

    if(!var_0.canbeplaced) {
      continue;
    }
    var_0 sentry_setplaced(var_2);
    return 1;
  }
}

enablemeleeforsentry() {
  self endon("death");
  self endon("disconnect");
  wait 0.25;
  scripts\engine\utility::allow_melee(1);
}

removeweapons() {
  if(self hasweapon("iw6_riotshield_mp")) {
    self.restoreweapon = "iw6_riotshield_mp";
    scripts\mp\utility\game::_takeweapon("iw6_riotshield_mp");
  }
}

removeperks() {
  if(scripts\mp\utility\game::_hasperk("specialty_explosivebullets")) {
    self.restoreperk = "specialty_explosivebullets";
    scripts\mp\utility\game::removeperk("specialty_explosivebullets");
  }
}

restoreweapons() {
  if(isDefined(self.restoreweapon)) {
    scripts\mp\utility\game::_giveweapon(self.restoreweapon);
    self.restoreweapon = undefined;
  }
}

restoreperks() {
  if(isDefined(self.restoreperk)) {
    scripts\mp\utility\game::giveperk(self.restoreperk);
    self.restoreperk = undefined;
  }
}

waitrestoreperks() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  wait 0.05;
  restoreperks();
}

createsentryforplayer(var_0, var_1, var_2, var_3) {
  var_4 = level.sentrysettings[var_0].weaponinfo;

  if(scripts\mp\killstreaks\utility::func_A69F(var_3, "passive_fast_sweep")) {
    var_4 = "sentry_shock_fast_mp";
  }

  var_5 = spawnturret("misc_turret", var_1.origin, var_4);
  var_5.angles = var_1.angles;
  var_5.streakinfo = var_3;
  var_5 sentry_initsentry(var_0, var_1, var_2);
  var_5 thread sentry_destroyongameend();
  return var_5;
}

sentry_initsentry(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_3)) {
    var_3 = 1;
  }

  self.sentrytype = var_0;
  self.canbeplaced = 1;
  self setModel(level.sentrysettings[var_0].modelbase);
  self setnonstick(1);
  self give_player_tickets(1);

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
      self give_crafted_gascan(50);
      self setdefaultdroppitch(0.0);
      self.originalowner = var_1;
      break;
    case "scramble_turret":
    case "sam_turret":
      self maketurretinoperable();
      self setleftarc(180);
      self setrightarc(180);
      self settoparc(80);
      self setdefaultdroppitch(-89.0);
      self.laser_on = 0;
      var_4 = spawn("script_model", self gettagorigin("tag_laser"));
      var_4 linkto(self);
      self.killcament = var_4;
      self.killcament setscriptmoverkillcam("explosive");
      break;
    case "sentry_shock":
      self maketurretinoperable();
      var_5 = anglesToForward(self.angles);
      var_6 = self gettagorigin("tag_laser") + (0, 0, 10);
      var_6 = var_6 - var_5 * 20;
      var_4 = spawn("script_model", var_6);
      var_4 linkto(self);
      self.killcament = var_4;
      break;
    default:
      self maketurretinoperable();
      self setdefaultdroppitch(-89.0);
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

sentry_createbombsquadmodel(var_0) {
  if(isDefined(level.sentrysettings[var_0].modelbombsquad)) {
    var_1 = spawn("script_model", self.origin);
    var_1.angles = self.angles;
    var_1 hide();
    var_1 thread scripts\mp\weapons::bombsquadvisibilityupdater(self.owner);
    var_1 setModel(level.sentrysettings[var_0].modelbombsquad);
    var_1 linkto(self);
    var_1 setcontents(0);
    self.bombsquadmodel = var_1;
    self waittill("death");

    if(isDefined(var_1)) {
      var_1 delete();
    }
  }
}

sentry_setteamheadicon() {
  var_0 = level.sentrysettings[self.sentrytype].headiconoffset;

  if(!isDefined(var_0)) {
    return;
  }
  if(!isDefined(self.owner)) {
    return;
  }
  var_1 = self.owner;
  var_2 = var_1.team;

  if(level.teambased && !scripts\mp\utility\game::istrue(self.var_115D1)) {
    scripts\mp\entityheadicons::setteamheadicon(var_2, var_0);
    self.var_115D1 = 1;
  } else if(!scripts\mp\utility\game::istrue(self.var_D3AA)) {
    scripts\mp\entityheadicons::setplayerheadicon(var_1, var_0);
    self.var_D3AA = 1;
  }
}

sentry_clearteamheadicon() {
  var_0 = level.sentrysettings[self.sentrytype].headiconoffset;

  if(!isDefined(var_0)) {
    return;
  }
  if(scripts\mp\utility\game::istrue(self.var_115D1)) {
    scripts\mp\entityheadicons::setteamheadicon("none", (0, 0, 0));
    self.var_115D1 = undefined;
  }

  if(scripts\mp\utility\game::istrue(self.var_D3AA)) {
    scripts\mp\entityheadicons::setplayerheadicon(undefined, (0, 0, 0));
    self.var_D3AA = undefined;
  }
}

sentry_destroyongameend() {
  self endon("death");
  level scripts\engine\utility::waittill_any("bro_shot_start", "game_ended");
  self notify("death");
}

sentry_handledamage() {
  self endon("carried");
  var_0 = level.sentrysettings[self.sentrytype].maxhealth;

  if(scripts\mp\killstreaks\utility::func_A69F(self.streakinfo, "passive_fast_sweep")) {
    var_0 = int(var_0 / 1.25);
  }

  var_1 = 0;

  if(self.owner scripts\mp\utility\game::_hasperk("specialty_rugged_eqp")) {
    var_2 = self.weapon_name;

    if(isDefined(var_2)) {
      switch (var_2) {
        default:
      }
    }
  }

  var_0 = var_0 + int(var_1);
  scripts\mp\damage::monitordamage(var_0, "sentry", ::sentryhandledeathdamage, ::sentrymodifydamage, 1);
}

sentrymodifydamage(var_0, var_1, var_2, var_3, var_4) {
  var_5 = var_3;

  if(var_2 == "MOD_MELEE") {
    var_5 = self.maxhealth * 0.34;
  }

  var_5 = scripts\mp\killstreaks\utility::getmodifiedantikillstreakdamage(var_0, var_1, var_2, var_5, self.maxhealth, 2, 3, 4);

  if(isDefined(var_0) && isplayer(var_0) && scripts\mp\equipment\phase_shift::isentityphaseshifted(var_0)) {
    var_5 = 0;
  }

  return var_5;
}

sentryhandledeathdamage(var_0, var_1, var_2, var_3) {
  var_4 = level.sentrysettings[self.sentrytype];

  if(var_4.iskillstreak) {
    if(isDefined(var_1) && var_1 == "concussion_grenade_mp") {
      if(scripts\mp\utility\game::istrue(scripts\mp\utility\game::playersareenemies(self.owner, var_0))) {
        var_0 scripts\mp\missions::func_D991("ch_tactical_emp_eqp");
      }
    }

    var_5 = var_4.destroyedsplash;
    var_6 = scripts\mp\killstreak_loot::getrarityforlootitem(self.streakinfo.variantid);

    if(var_6 != "") {
      var_5 = var_5 + "_" + var_6;
    }

    var_7 = scripts\mp\damage::onkillstreakkilled(var_4.streakname, var_0, var_1, var_2, var_3, var_4.scorepopup, var_4.vodestroyed, var_5);

    if(var_7) {
      var_0 notify("destroyed_equipment");
      return;
    }
  } else {
    var_8 = undefined;
    var_9 = var_0;

    if(isDefined(var_9) && isDefined(self.owner)) {
      if(isDefined(var_0.owner) && isplayer(var_0.owner)) {
        var_9 = var_0.owner;
      }

      if(self.owner scripts\mp\utility\game::isenemy(var_9)) {
        var_8 = var_9;
      }
    }

    if(isDefined(var_8)) {
      var_8 thread scripts\mp\events::supershutdown(self.owner);
      var_8 notify("destroyed_equipment");
    }

    self notify("death");
  }
}

sentry_watchdisabled() {
  self endon("carried");
  self endon("death");
  level endon("game_ended");

  for(;;) {
    self waittill("emp_damage", var_0, var_1, var_2, var_3, var_4);
    scripts\mp\killstreaks\utility::dodamagetokillstreak(100, var_0, var_0, self.team, var_2, var_4, var_3);

    if(!scripts\mp\utility\game::istrue(self.disabled)) {
      thread disablesentry(var_1);
    }
  }
}

disablesentry(var_0) {
  self endon("carried");
  self endon("death");
  level endon("game_ended");
  self.disabled = 1;
  scripts\mp\weapons::stopblinkinglight();
  self setdefaultdroppitch(40);
  self give_player_session_tokens(level.sentrysettings[self.sentrytype].sentrymodeoff);
  self cleartargetentity();
  self setscriptablepartstate("coil", "neutral");
  self setscriptablepartstate("muzzle", "neutral", 0);
  self setscriptablepartstate("stunned", "active");
  sentry_clearteamheadicon();
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(var_0);
  self setdefaultdroppitch(-89.0);
  self give_player_session_tokens(level.sentrysettings[self.sentrytype].sentrymodeon);
  thread scripts\mp\weapons::doblinkinglight(level.sentrysettings[self.sentrytype].lightfxtag);
  self setscriptablepartstate("coil", "idle");
  self setscriptablepartstate("stunned", "neutral");
  sentry_setteamheadicon();
  self.disabled = undefined;
}

sentry_handledeath() {
  self endon("carried");
  self waittill("death");

  if(isDefined(self.owner)) {
    self.owner.placedsentries[self.sentrytype] = ::scripts\engine\utility::array_remove(self.owner.placedsentries[self.sentrytype], self);
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
    self _meth_83D3(self.inuseby);
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
    self.inuseby restoreperks();
    self.inuseby restoreweapons();
    self notify("deleting");
    wait 1.0;
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

  scripts\mp\utility\game::printgameaction("killstreak ended - shock_sentry", self.owner);
  self delete();
}

sentry_handleuse(var_0) {
  self endon("death");
  level endon("game_ended");

  for(;;) {
    self waittill("trigger", var_1);

    if(!scripts\mp\utility\game::isreallyalive(var_1)) {
      continue;
    }
    if(self.sentrytype == "sam_turret" || self.sentrytype == "scramble_turret" || self.sentrytype == "sentry_shock" && scripts\mp\killstreaks\utility::func_A69F(self.streakinfo, "passive_sam_turret")) {
      self give_player_session_tokens(level.sentrysettings[self.sentrytype].sentrymodeoff);
    }

    var_1.placedsentries[self.sentrytype] = ::scripts\engine\utility::array_remove(var_1.placedsentries[self.sentrytype], self);
    var_1 setcarryingsentry(self, 0, var_0);
  }
}

turret_handlepickup(var_0) {
  self endon("disconnect");
  level endon("game_ended");
  var_0 endon("death");

  if(!isDefined(var_0.ownertrigger)) {
    return;
  }
  var_1 = 0;

  for(;;) {
    if(isalive(self) && self istouching(var_0.ownertrigger) && !isDefined(var_0.inuseby) && !isDefined(var_0.carriedby) && self isonground()) {
      if(self usebuttonpressed()) {
        if(isDefined(self.using_remote_turret) && self.using_remote_turret) {
          continue;
        }
        var_1 = 0;

        while(self usebuttonpressed()) {
          var_1 = var_1 + 0.05;
          wait 0.05;
        }

        if(var_1 >= 0.5) {
          continue;
        }
        var_1 = 0;

        while(!self usebuttonpressed() && var_1 < 0.5) {
          var_1 = var_1 + 0.05;
          wait 0.05;
        }

        if(var_1 >= 0.5) {
          continue;
        }
        if(!scripts\mp\utility\game::isreallyalive(self)) {
          continue;
        }
        if(isDefined(self.using_remote_turret) && self.using_remote_turret) {
          continue;
        }
        var_0 give_player_session_tokens(level.sentrysettings[var_0.sentrytype].sentrymodeoff);
        thread setcarryingsentry(var_0, 0);
        var_0.ownertrigger delete();
        return;
      }
    }

    wait 0.05;
  }
}

turret_handleuse() {
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
    if(!scripts\mp\utility\game::isreallyalive(var_3)) {
      continue;
    }
    var_3 removeperks();
    var_3 removeweapons();
    self.inuseby = var_3;
    self give_player_session_tokens(level.sentrysettings[self.sentrytype].sentrymodeoff);
    sentry_setowner(var_3);
    self give_player_session_tokens(level.sentrysettings[self.sentrytype].sentrymodeon);
    var_3 thread turret_shotmonitor(self);
    var_3.turret_overheat_bar = var_3 scripts\mp\hud_util::createbar(var_0, 100, 6);
    var_3.turret_overheat_bar scripts\mp\hud_util::setpoint("CENTER", "BOTTOM", 0, -70);
    var_3.turret_overheat_bar.alpha = 0.65;
    var_3.turret_overheat_bar.bar.alpha = 0.65;
    var_4 = 0;

    for(;;) {
      if(!scripts\mp\utility\game::isreallyalive(var_3)) {
        self.inuseby = undefined;
        var_3.turret_overheat_bar scripts\mp\hud_util::destroyelem();
        break;
      }

      if(!var_3 isusingturret()) {
        self notify("player_dismount");
        self.inuseby = undefined;
        var_3.turret_overheat_bar scripts\mp\hud_util::destroyelem();
        var_3 restoreperks();
        var_3 restoreweapons();
        self sethintstring(level.sentrysettings[self.sentrytype].hintstring);
        self give_player_session_tokens(level.sentrysettings[self.sentrytype].sentrymodeoff);
        sentry_setowner(self.originalowner);
        self give_player_session_tokens(level.sentrysettings[self.sentrytype].sentrymodeon);
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

    self setdefaultdroppitch(0.0);
  }
}

sentry_handleownerdisconnect() {
  self endon("death");
  level endon("game_ended");
  self notify("sentry_handleOwner");
  self endon("sentry_handleOwner");
  self.owner waittill("killstreak_disowned");
  self notify("death");
}

sentry_setowner(var_0) {
  self.owner = var_0;
  self setsentryowner(self.owner);
  self setturretminimapvisible(1, self.sentrytype);

  if(level.teambased) {
    self.team = self.owner.team;
    self setturretteam(self.team);
  }

  thread sentry_handleownerdisconnect();
}

sentry_moving_platform_death(var_0) {
  self notify("death");
}

sentry_setplaced(var_0) {
  if(isDefined(self.owner)) {
    var_1 = self.owner.placedsentries[self.sentrytype].size;
    self.owner.placedsentries[self.sentrytype][var_1] = self;

    if(var_1 + 1 > 2) {
      self.owner.placedsentries[self.sentrytype][0] notify("death");
    }

    self.owner allowweaponsforsentry(1);
    self.owner scripts\engine\utility::allow_usability(1);
    self.owner thread enablemeleeforsentry();
    self.owner enableworldup(1);
  }

  var_2 = level.sentrysettings[self.sentrytype].modelbase;
  var_3 = scripts\mp\killstreak_loot::getrarityforlootitem(self.streakinfo.variantid);

  if(var_3 != "") {
    var_2 = var_2 + "_" + var_3;
  }

  self setModel(var_2);

  if(self getspawnpoint_safeguard() == "manual") {
    self give_player_session_tokens(level.sentrysettings[self.sentrytype].sentrymodeoff);
  }

  if(self.sentrytype == "sentry_shock") {
    self setscriptablepartstate("coil", "idle");
  }

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
          self.originalowner scripts\mp\utility\game::setlowermessage("pickup_hint", level.sentrysettings[self.sentrytype].ownerhintstring, 3.0, undefined, undefined, undefined, undefined, undefined, 1);
        }

        self.ownertrigger = spawn("trigger_radius", self.origin + (0, 0, 1), 0, 105, 64);
        self.ownertrigger getrankxp();
        self.ownertrigger linkto(self);
        self.originalowner thread turret_handlepickup(self);
        thread turret_handleuse();
      }

      break;
    default:
      break;
  }

  sentry_makesolid();

  if(isDefined(self.bombsquadmodel)) {
    self.bombsquadmodel show();
    level notify("update_bombsquad");
  }

  self.carriedby getrigindexfromarchetyperef();
  self.carriedby = undefined;
  self.firstplacement = undefined;

  if(isDefined(self.owner)) {
    self.owner.iscarrying = 0;
    self.owner notify("new_sentry", self);
  }

  sentry_setactive(var_0);
  var_4 = spawnStruct();

  if(isDefined(self.moving_platform)) {
    var_4.linkparent = self.moving_platform;
  }

  var_4.endonstring = "carried";
  var_4.deathoverridecallback = ::sentry_moving_platform_death;
  thread scripts\mp\movers::handle_moving_platforms(var_4);

  if(self.sentrytype != "multiturret") {
    self playSound("sentry_gun_plant");
  }

  thread scripts\mp\weapons::doblinkinglight(level.sentrysettings[self.sentrytype].lightfxtag);
  self notify("placed");
}

sentry_setcancelled(var_0) {
  if(isDefined(self.carriedby)) {
    var_1 = self.carriedby;
    var_1 getrigindexfromarchetyperef();
    var_1.iscarrying = undefined;
    var_1.carrieditem = undefined;
    var_1 allowweaponsforsentry(1);
    var_1 scripts\engine\utility::allow_usability(1);
    var_1 thread enablemeleeforsentry();
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

sentry_setcarried(var_0, var_1, var_2) {
  if(isDefined(self.originalowner)) {}

  if(self.sentrytype == "sentry_shock") {
    self setscriptablepartstate("coil", "neutral");
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
  var_0 thread updatesentryplacement(self);
  thread sentry_oncarrierdisconnect(var_0);
  thread sentry_oncarrierchangedteam(var_0);
  thread sentry_ongameended();
  self setdefaultdroppitch(-89.0);
  sentry_setinactive();

  if(isDefined(self getlinkedparent())) {
    self unlink();
  }

  self notify("carried");

  if(isDefined(self.bombsquadmodel)) {
    self.bombsquadmodel hide();
  }
}

updatesentryplacement(var_0) {
  self endon("death");
  self endon("disconnect");
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
    var_0.canbeplaced = self isonground() && var_2["result"] && abs(var_0.origin[2] - self.origin[2]) < 30 && !scripts\mp\utility\game::func_9FAE(self) && var_4.size == 0;

    if(isDefined(var_2["entity"])) {
      var_0.moving_platform = var_2["entity"];
    } else {
      var_0.moving_platform = undefined;
    }

    if(var_0.canbeplaced != var_1) {
      if(var_0.canbeplaced) {
        var_0 setModel(level.sentrysettings[var_0.sentrytype].modelgood);
        var_0 placehinton();
      } else {
        var_0 setModel(level.sentrysettings[var_0.sentrytype].modelbad);
        var_0 cannotplacehinton();
      }
    }

    var_1 = var_0.canbeplaced;
    wait 0.05;
  }
}

sentry_oncarrierdeathoremp(var_0, var_1) {
  self endon("placed");
  self endon("death");
  var_0 endon("disconnect");
  var_0 scripts\engine\utility::waittill_any("death", "apply_player_emp");

  if(self.canbeplaced && !scripts\mp\utility\game::istrue(var_1)) {
    sentry_setplaced(self.pickupenabled);
  } else {
    sentry_setcancelled(0);
  }
}

sentry_oncarrierdisconnect(var_0) {
  self endon("placed");
  self endon("death");
  var_0 waittill("disconnect");
  self delete();
}

sentry_oncarrierchangedteam(var_0) {
  self endon("placed");
  self endon("death");
  var_0 scripts\engine\utility::waittill_any("joined_team", "joined_spectators");
  self delete();
}

sentry_ongameended(var_0) {
  self endon("placed");
  self endon("death");
  level waittill("game_ended");
  self delete();
}

sentry_setactive(var_0) {
  self give_player_session_tokens(level.sentrysettings[self.sentrytype].sentrymodeon);

  if(var_0) {
    self setcursorhint("HINT_NOICON");
    self sethintstring(level.sentrysettings[self.sentrytype].hintstring);
    self makeusable();
  }

  sentry_setteamheadicon();

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
        scripts\mp\killstreaks\utility::func_1843(self.sentrytype, "Killstreak_Ground", self.owner, 1, "carried");

        if(var_2 == self.owner && var_0) {
          self enableplayeruse(var_2);
        } else {
          self disableplayeruse(var_2);
        }

        break;
    }
  }

  var_4 = level.sentrysettings[self.sentrytype].teamsplash;
  var_5 = scripts\mp\killstreak_loot::getrarityforlootitem(self.streakinfo.variantid);

  if(var_5 != "") {
    var_4 = var_4 + "_" + var_5;
  }

  if(self.shouldsplash) {
    level thread scripts\mp\utility\game::teamplayercardsplash(var_4, self.owner);
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

  thread sentry_watchdisabled();
}

sentry_setinactive() {
  self give_player_session_tokens(level.sentrysettings[self.sentrytype].sentrymodeoff);
  self makeunusable();
  scripts\mp\weapons::stopblinkinglight();
  sentry_clearteamheadicon();
}

sentry_makesolid() {
  self getvalidlocation();
}

sentry_makenotsolid() {
  self setcontents(0);
}

isfriendlytosentry(var_0) {
  if(level.teambased && self.team == var_0.team) {
    return 1;
  }

  return 0;
}

sentry_attacktargets() {
  self endon("death");
  level endon("game_ended");
  self.momentum = 0;
  self.heatlevel = 0;
  self.overheated = 0;
  thread sentry_heatmonitor();

  for(;;) {
    scripts\engine\utility::waittill_either("turretstatechange", "cooled");

    if(self getteamarray()) {
      thread sentry_burstfirestart();
      continue;
    }

    sentry_spindown();
    thread sentry_burstfirestop();
  }
}

sentry_timeout() {
  self endon("death");
  level endon("game_ended");
  var_0 = level.sentrysettings[self.sentrytype].timeout;

  if(isDefined(var_0) && var_0 == 0) {
    return;
  }
  while(var_0) {
    wait 1.0;
    scripts\mp\hostmigration::waittillhostmigrationdone();

    if(!isDefined(self.carriedby)) {
      var_0 = max(0, var_0 - 1.0);
    }
  }

  if(isDefined(self.owner)) {
    if(isDefined(level.sentrysettings[self.sentrytype].votimeout)) {
      self.owner scripts\mp\utility\game::playkillstreakdialogonplayer(level.sentrysettings[self.sentrytype].votimeout, undefined, undefined, self.owner.origin);
    }
  }

  self notify("death");
}

sentry_targetlocksound() {
  self endon("death");
  self playSound("sentry_gun_beep");
  wait 0.1;
  self playSound("sentry_gun_beep");
  wait 0.1;
  self playSound("sentry_gun_beep");
}

sentry_spinup() {
  thread sentry_targetlocksound();

  while(self.momentum < level.sentrysettings[self.sentrytype].spinuptime) {
    self.momentum = self.momentum + 0.1;
    wait 0.1;
  }
}

sentry_spindown() {
  self.momentum = 0;
}

sentry_laser_burstfirestart() {
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
    var_0 = 0.5 / (self.listoffoundturrets.size + 1);
    var_3 = var_1;
  }

  for(var_4 = 0; var_4 < var_3; var_4++) {
    var_5 = self getturrettarget(1);

    if(!isDefined(var_5)) {
      break;
    }
    self shootturret();
    wait(var_0);
  }

  self notify("doneFiring");
  self cleartargetentity();
}

sentry_burstfirestart() {
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
      self.heatlevel = self.heatlevel + var_0;
      wait(var_0);
    }

    wait(randomfloatrange(var_3, var_4));
  }
}

sentry_burstfirestop() {
  self notify("stop_shooting");
}

turret_shotmonitor(var_0) {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  var_0 endon("death");
  var_0 endon("player_dismount");
  var_1 = weaponfiretime(level.sentrysettings[var_0.sentrytype].weaponinfo);

  for(;;) {
    var_0 waittill("turret_fire");
    var_0.heatlevel = var_0.heatlevel + var_1;
    var_0.cooldownwaittime = var_1;
  }
}

sentry_heatmonitor() {
  self endon("death");
  var_0 = weaponfiretime(level.sentrysettings[self.sentrytype].weaponinfo);
  var_1 = 0;
  var_2 = 0;
  var_3 = level.sentrysettings[self.sentrytype].overheattime;
  var_4 = level.sentrysettings[self.sentrytype].cooldowntime;

  for(;;) {
    if(self.heatlevel != var_1) {
      wait(var_0);
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

turret_heatmonitor() {
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

turret_coolmonitor() {
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

playheatfx() {
  self endon("death");
  self endon("not_overheated");
  level endon("game_ended");
  self notify("playing_heat_fx");
  self endon("playing_heat_fx");

  for(;;) {
    playFXOnTag(scripts\engine\utility::getfx("sentry_overheat_mp"), self, "tag_flash");
    wait(level.sentrysettings[self.sentrytype].fxtime);
  }
}

playsmokefx() {
  self endon("death");
  self endon("not_overheated");
  level endon("game_ended");

  for(;;) {
    playFXOnTag(scripts\engine\utility::getfx("sentry_smoke_mp"), self, "tag_aim");
    wait 0.4;
  }
}

sentry_beepsounds() {
  self endon("death");
  level endon("game_ended");

  for(;;) {
    wait 3.0;

    if(!isDefined(self.carriedby)) {
      self playSound("sentry_gun_beep");
    }
  }
}

sam_attacktargets() {
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

sam_acquiretarget() {
  var_0 = self gettagorigin("tag_laser");

  if(!isDefined(self.samtargetent)) {
    if(level.teambased) {
      var_1 = [];

      if(level.multiteambased) {
        foreach(var_3 in level.teamnamelist) {
          if(var_3 != self.team) {
            foreach(var_5 in level.uavmodels[var_3]) {
              var_1[var_1.size] = var_5;
            }
          }
        }
      } else
        var_1 = level.uavmodels[level.otherteam[self.team]];

      foreach(var_9 in var_1) {
        if(isDefined(var_9.isleaving) && var_9.isleaving) {
          continue;
        }
        if(sighttracepassed(var_0, var_9.origin, 0, self)) {
          return var_9;
        }
      }

      foreach(var_12 in level.littlebirds) {
        if(isDefined(var_12.team) && var_12.team == self.team) {
          continue;
        }
        if(sighttracepassed(var_0, var_12.origin, 0, self)) {
          return var_12;
        }
      }

      foreach(var_15 in level.helis) {
        if(isDefined(var_15.team) && var_15.team == self.team) {
          continue;
        }
        if(sighttracepassed(var_0, var_15.origin, 0, self)) {
          return var_15;
        }
      }

      foreach(var_9 in level.remote_uav) {
        if(!isDefined(var_9)) {
          continue;
        }
        if(isDefined(var_9.team) && var_9.team == self.team) {
          continue;
        }
        if(sighttracepassed(var_0, var_9.origin, 0, self, var_9)) {
          return var_9;
        }
      }
    } else {
      foreach(var_9 in level.uavmodels) {
        if(isDefined(var_9.isleaving) && var_9.isleaving) {
          continue;
        }
        if(isDefined(var_9.owner) && isDefined(self.owner) && var_9.owner == self.owner) {
          continue;
        }
        if(sighttracepassed(var_0, var_9.origin, 0, self)) {
          return var_9;
        }
      }

      foreach(var_12 in level.littlebirds) {
        if(isDefined(var_12.owner) && isDefined(self.owner) && var_12.owner == self.owner) {
          continue;
        }
        if(sighttracepassed(var_0, var_12.origin, 0, self)) {
          return var_12;
        }
      }

      foreach(var_15 in level.helis) {
        if(isDefined(var_15.owner) && isDefined(self.owner) && var_15.owner == self.owner) {
          continue;
        }
        if(sighttracepassed(var_0, var_15.origin, 0, self)) {
          return var_15;
        }
      }

      foreach(var_9 in level.remote_uav) {
        if(!isDefined(var_9)) {
          continue;
        }
        if(isDefined(var_9.owner) && isDefined(self.owner) && var_9.owner == self.owner) {
          continue;
        }
        if(sighttracepassed(var_0, var_9.origin, 0, self, var_9)) {
          return var_9;
        }
      }
    }

    self cleartargetentity();
    return undefined;
  } else {
    if(!sighttracepassed(var_0, self.samtargetent.origin, 0, self)) {
      self cleartargetentity();
      return undefined;
    }

    return self.samtargetent;
  }
}

sam_fireontarget() {
  if(isDefined(self.samtargetent)) {
    if(self.samtargetent == level.ac130.planemodel && !isDefined(level.ac130player)) {
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

    wait 2.0;

    if(!isDefined(self.samtargetent)) {
      return;
    }
    if(self.samtargetent == level.ac130.planemodel && !isDefined(level.ac130player)) {
      self.samtargetent = undefined;
      self cleartargetentity();
      return;
    }

    var_0 = [];
    var_0[0] = self gettagorigin("tag_le_missile1");
    var_0[1] = self gettagorigin("tag_le_missile2");
    var_0[2] = self gettagorigin("tag_ri_missile1");
    var_0[3] = self gettagorigin("tag_ri_missile2");
    var_1 = self.sammissilegroups.size;

    for(var_2 = 0; var_2 < 4; var_2++) {
      if(!isDefined(self.samtargetent)) {
        return;
      }
      if(isDefined(self.carriedby)) {
        return;
      }
      self shootturret();
      var_3 = scripts\mp\utility\game::_magicbullet("sam_projectile_mp", var_0[var_2], self.samtargetent.origin, self.owner);
      var_3 missile_settargetent(self.samtargetent);
      var_3 missile_setflightmodedirect();
      var_3.samturret = self;
      var_3.sammissilegroup = var_1;
      self.sammissilegroups[var_1][var_2] = var_3;
      level notify("sam_missile_fired", self.owner, var_3, self.samtargetent);

      if(var_2 == 3) {
        break;
      }
      wait 0.25;
    }

    level notify("sam_fired", self.owner, self.sammissilegroups[var_1], self.samtargetent);
    wait 3.0;
  }
}

sam_watchlineofsight() {
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

sam_watchlaser() {
  self endon("death");
  self laseron();
  self.laser_on = 1;

  while(isDefined(self.samtargetent) && isDefined(self getturrettarget(1)) && self getturrettarget(1) == self.samtargetent) {
    wait 0.05;
  }

  self laseroff();
  self.laser_on = 0;
}

sam_watchcrashing() {
  self endon("death");
  self.samtargetent endon("death");

  if(!isDefined(self.samtargetent.helitype)) {
    return;
  }
  self.samtargetent waittill("crashing");
  self cleartargetentity();
  self.samtargetent = undefined;
}

sam_watchleaving() {
  self endon("death");
  self.samtargetent endon("death");

  if(!isDefined(self.samtargetent.model)) {
    return;
  }
  if(self.samtargetent.model == "vehicle_uav_static_mp") {
    self.samtargetent waittill("leaving");
    self cleartargetentity();
    self.samtargetent = undefined;
  }
}

scrambleturretattacktargets() {
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

scramble_acquiretarget() {
  return sam_acquiretarget();
}

scrambletarget() {
  if(isDefined(self.scrambletargetent)) {
    if(self.scrambletargetent == level.ac130.planemodel && !isDefined(level.ac130player)) {
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

    wait 2.0;

    if(!isDefined(self.scrambletargetent)) {
      return;
    }
    if(self.scrambletargetent == level.ac130.planemodel && !isDefined(level.ac130player)) {
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
  }
}

setscrambled() {
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
  }
}

scramble_watchlineofsight() {
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

scramble_watchlaser() {
  self endon("death");
  self laseron();
  self.laser_on = 1;

  while(isDefined(self.scrambletargetent) && isDefined(self getturrettarget(1)) && self getturrettarget(1) == self.scrambletargetent) {
    wait 0.05;
  }

  self laseroff();
  self.laser_on = 0;
}

scramble_watchcrashing() {
  self endon("death");
  self.scrambletargetent endon("death");

  if(!isDefined(self.scrambletargetent.helitype)) {
    return;
  }
  self.scrambletargetent waittill("crashing");
  self cleartargetentity();
  self.scrambletargetent = undefined;
}

scramble_watchleaving() {
  self endon("death");
  self.scrambletargetent endon("death");

  if(!isDefined(self.scrambletargetent.model)) {
    return;
  }
  if(self.scrambletargetent.model == "vehicle_uav_static_mp") {
    self.scrambletargetent waittill("leaving");
    self cleartargetentity();
    self.scrambletargetent = undefined;
  }
}

sentryshocktargets() {
  self endon("death");
  self endon("carried");
  level endon("game_ended");
  thread watchsentryshockpickup();
  self.airlookatent = scripts\engine\utility::spawn_tag_origin(self.origin, self.angles);
  self.airlookatent linkto(self, "tag_flash");

  for(;;) {
    var_0 = scripts\engine\utility::waittill_any_timeout(1, "turret_on_target");

    if(var_0 == "timeout") {
      if(scripts\mp\killstreaks\utility::func_A69F(self.streakinfo, "passive_sam_turret")) {
        self.sentryshocksamtarget = thread searchforshocksentryairtarget();

        if(isDefined(self.sentryshocksamtarget)) {
          thread shootshocksentrysamtarget(self.sentryshocksamtarget, self.airlookatent);
          self waittill("done_firing");
        }
      }

      continue;
    }

    self.sentryshocktargetent = self getturrettarget(1);

    if(isDefined(self.sentryshocktargetent) && scripts\mp\utility\game::isreallyalive(self.sentryshocktargetent)) {
      thread shocktarget(self.sentryshocktargetent);
      self waittill("done_firing");
    }
  }
}

searchforshocksentryairtarget() {
  if(isDefined(level.uavmodels)) {
    if(level.teambased) {
      foreach(var_1 in level.uavmodels[scripts\mp\utility\game::getotherteam(self.owner.team)]) {
        if(targetvisibleinfront(var_1)) {
          return var_1;
        }
      }
    } else {
      foreach(var_1 in level.uavmodels) {
        if(var_1.owner == self.owner) {
          continue;
        }
        if(targetvisibleinfront(var_1)) {
          return var_1;
        }
      }
    }
  }

  if(isDefined(level.balldrones)) {
    foreach(var_6 in level.balldrones) {
      if(var_6.streakname != "ball_drone_backup") {
        continue;
      }
      if(level.teambased && var_6.team == self.owner.team) {
        continue;
      }
      if(!level.teambased && var_6.owner == self.owner) {
        continue;
      }
      if(targetvisibleinfront(var_6)) {
        return var_6;
      }
    }
  }

  if(isDefined(level.helis)) {
    foreach(var_9 in level.helis) {
      if(var_9.streakname != "jackal") {
        continue;
      }
      if(level.teambased && var_9.team == self.owner.team) {
        continue;
      }
      if(!level.teambased && var_9.owner == self.owner) {
        continue;
      }
      if(targetvisibleinfront(var_9)) {
        return var_9;
      }
    }
  }

  if(isDefined(level.var_DA61)) {
    foreach(var_12 in level.var_DA61) {
      if(var_12.streakname != "thor") {
        continue;
      }
      if(isDefined(var_12.team)) {
        if(level.teambased && var_12.team == self.owner.team) {
          continue;
        }
      }

      if(!level.teambased && var_12.owner == self.owner) {
        continue;
      }
      if(targetvisibleinfront(var_12)) {
        return var_12;
      }
    }
  }

  if(isDefined(level.var_105EA)) {
    foreach(var_12 in level.var_105EA) {
      if(var_12.streakname != "minijackal") {
        continue;
      }
      if(isDefined(var_12.team)) {
        if(level.teambased && var_12.team == self.owner.team) {
          continue;
        }
      }

      if(!level.teambased && var_12.owner == self.owner) {
        continue;
      }
      if(targetvisibleinfront(var_12)) {
        return var_12;
      }
    }
  }
}

targetvisibleinfront(var_0) {
  if(!isDefined(var_0)) {
    return 0;
  }

  var_1 = 0;
  var_2 = self gettagorigin("tag_flash");
  var_3 = var_0.origin;
  var_4 = vectornormalize(var_3 - var_2);
  var_5 = anglesToForward(self.angles);
  var_6 = [self, self.owner, var_0];
  var_7 = physics_createcontents(["physicscontents_solid", "physicscontents_glass", "physicscontents_water", "physicscontents_vehicle", "physicscontents_item"]);

  if(scripts\engine\trace::ray_trace_passed(var_2, var_3, var_6, var_7) && vectordot(var_5, var_4) > 0.25 && distance2dsquared(var_2, var_3) > 10000) {
    var_1 = 1;
  }

  return var_1;
}

shootshocksentrysamtarget(var_0, var_1) {
  self endon("death");
  self endon("carried");
  level endon("game_ended");
  self give_player_session_tokens("manual");
  thread setshocksamtargetent(var_0, var_1);
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
    var_5 = scripts\mp\utility\game::_magicbullet("sentry_shock_missile_mp", var_4, var_0.origin, self.owner);
    var_5 missile_settargetent(var_0);
    var_5 missile_setflightmodedirect();
    var_5.killcament = self.killcament;
    var_5.streakinfo = self.streakinfo;
    self setscriptablepartstate("muzzle", "fire" + var_3, 0);
    level notify("laserGuidedMissiles_incoming", self.owner, var_5, var_0);
    var_3++;

    if(var_3 > 2) {
      var_3 = 1;
    }

    wait(var_2);
  }

  self setscriptablepartstate("muzzle", "neutral", 0);
  self notify("sentry_lost_target");
  var_1 unlink();
  var_1.origin = self gettagorigin("tag_flash");
  var_1 linkto(self, "tag_flash");
  self give_player_session_tokens("sentry");
  self cleartargetentity();
  self setscriptablepartstate("coil", "idle");
  sentry_spindown();
  self notify("done_firing");
}

setshocksamtargetent(var_0, var_1) {
  self endon("death");
  self endon("carried");
  self endon("sentry_lost_target");
  var_0 endon("death");
  level endon("game_ended");

  for(;;) {
    var_2 = self gettagorigin("tag_aim");
    var_3 = var_0.origin;
    var_4 = vectornormalize(var_3 - var_2);
    var_5 = var_2 + var_4 * 500;
    var_1 unlink();
    var_1.origin = var_5;
    var_1 linkto(self);
    self settargetentity(var_1);
    scripts\engine\utility::waitframe();
  }
}

watchsentryshockpickup() {
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

shocktarget(var_0) {
  self endon("death");
  self endon("carried");

  if(!isDefined(var_0)) {
    return;
  }
  thread marktargetlaser(var_0);

  if(!scripts\mp\killstreaks\utility::func_A69F(self.streakinfo, "passive_sam_turret")) {
    thread watchshockdamage(var_0);
  }

  self playSound("shock_sentry_charge_up");
  playFXOnTag(scripts\engine\utility::getfx("sentry_shock_charge"), self, "tag_laser");
  sentry_spinup();
  stopFXOnTag(scripts\engine\utility::getfx("sentry_shock_charge"), self, "tag_laser");
  self notify("start_firing");
  self setscriptablepartstate("coil", "active");
  level thread scripts\mp\battlechatter_mp::saytoself(var_0, "plr_killstreak_target");
  var_1 = weaponfiretime(level.sentrysettings[self.sentrytype].weaponinfo);

  while(isDefined(var_0) && scripts\mp\utility\game::isreallyalive(var_0) && isDefined(self getturrettarget(1)) && self getturrettarget(1) == var_0 && !scripts\mp\utility\game::func_C7A0(self gettagorigin("tag_flash"), var_0 getEye())) {
    if(scripts\mp\killstreaks\utility::func_A69F(self.streakinfo, "passive_mini_explosives")) {
      thread missileburstfire(var_0);
      var_1 = 1.5;
    } else
      self shootturret();

    wait(var_1);
  }

  self setscriptablepartstate("coil", "idle");
  self setscriptablepartstate("muzzle", "neutral", 0);
  self.sentryshocktargetent = undefined;
  self cleartargetentity();
  sentry_spindown();
  self notify("done_firing");
}

missileburstfire(var_0) {
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
    var_3 = scripts\mp\utility\game::_magicbullet("sentry_shock_grenade_mp", self gettagorigin("tag_flash"), var_0.origin, self.owner);

    if(scripts\mp\killstreaks\utility::manualmissilecantracktarget(var_0)) {
      var_3 missile_settargetent(var_0, gettargetoffset(var_0));
      var_0 thread watchtarget(var_3);
    }

    var_3.killcament = self.killcament;
    var_3.streakinfo = self.streakinfo;
    self setscriptablepartstate("muzzle", "fire" + var_2, 0);
    var_2++;

    if(var_2 > 2) {
      var_2 = 1;
    }

    var_1--;
    wait 0.2;
  }
}

gettargetoffset(var_0) {
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

watchtarget(var_0) {
  self endon("disconnect");

  for(;;) {
    if(!scripts\mp\killstreaks\utility::manualmissilecantracktarget(self)) {
      break;
    }
    if(!isDefined(var_0)) {
      break;
    }
    scripts\engine\utility::waitframe();
  }

  if(isDefined(var_0)) {
    var_0 missile_cleartarget();
  }
}

marktargetlaser(var_0) {
  self endon("death");
  self laseron();
  self.laser_on = 1;
  scripts\engine\utility::waittill_any("done_firing", "carried");
  self laseroff();
  self.laser_on = 0;
}

watchshockdamage(var_0) {
  self endon("death");
  self endon("done_firing");
  var_1 = undefined;

  for(;;) {
    self waittill("victim_damaged", var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11);

    if(var_2 == var_0) {
      var_12 = 100;
      var_13 = scripts\mp\utility\game::getplayersinradiusview(var_8, var_12, var_2.team, self.owner);
      playFX(scripts\engine\utility::getfx("sentry_shock_explosion"), var_8);

      if(var_13.size > 0) {
        foreach(var_15 in var_13) {
          if(var_15.player != var_2) {
            var_15.player getrandomarmkillstreak(5, var_8, self.owner, self, var_6, var_7);
            var_16 = undefined;
            var_17 = undefined;

            if(var_15.visiblelocations.size > 1) {
              var_17 = randomint(var_15.visiblelocations.size);
              var_16 = var_15.visiblelocations[var_17];
            } else
              var_16 = var_15.visiblelocations[0];

            playfxbetweenpoints(scripts\engine\utility::getfx("sentry_shock_arc"), var_8, vectortoangles(var_16 - var_8), var_16);
          }
        }
      }
    }
  }
}

allowweaponsforsentry(var_0) {
  if(var_0) {
    scripts\engine\utility::allow_weapon(1);
    thread scripts\mp\supers::unstowsuperweapon();
  } else {
    thread scripts\mp\supers::allowsuperweaponstow();
    scripts\engine\utility::allow_weapon(0);
  }
}

placehinton() {
  var_0 = self.sentrytype;

  if(var_0 == "super_trophy") {
    self.owner forceusehinton(&"LUA_MENU_MP_PLACE_SUPER_TROPHY");
    return;
  } else
    self.owner forceusehinton(&"SENTRY_PLACE");
}

cannotplacehinton() {
  var_0 = self.sentrytype;

  if(var_0 == "super_trophy") {
    self.owner forceusehinton(&"LUA_MENU_MP_CANNOT_PLACE_SUPER_TROPHY");
    return;
  } else
    self.owner forceusehinton(&"SENTRY_CANNOT_PLACE");
}