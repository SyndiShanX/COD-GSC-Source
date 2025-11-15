/**************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\mp\killstreaks\_autosentry.gsc
**************************************************/

init() {
  level.sentrytype = [];
  level.sentrytype["sentry_minigun"] = "sentry";
  level.sentrytype["sam_turret"] = "sam_turret";
  level.sentrytype["super_trophy"] = "super_trophy";
  level.sentrytype["sentry_shock"] = "sentry_shock";
  scripts\mp\killstreaks\_killstreaks::registerkillstreak("sentry_shock", ::tryuseshocksentry);
  scripts\mp\killstreak_loot::func_DF07("sentry_shock", ["passive_extra_health", "passive_increased_duration"]);
  level.sentrysettings = [];
  level.sentrysettings["super_trophy"] = spawnStruct();
  level.sentrysettings["super_trophy"].health = 999999;
  level.sentrysettings["super_trophy"].maxhealth = 100;
  level.sentrysettings["super_trophy"].sentrymodeon = "sentry";
  level.sentrysettings["super_trophy"].sentrymodeoff = "sentry_offline";
  level.sentrysettings["super_trophy"].var_39B = "sentry_laser_mp";
  level.sentrysettings["super_trophy"].modelbase = "super_trophy_mp";
  level.sentrysettings["super_trophy"].modelgood = "super_trophy_mp_placement";
  level.sentrysettings["super_trophy"].modelbad = "super_trophy_mp_placement_fail";
  level.sentrysettings["super_trophy"].modeldestroyed = "super_trophy_mp";
  level.sentrysettings["super_trophy"].pow = & "SENTRY_PICKUP";
  level.sentrysettings["super_trophy"].playerphysicstrace = 1;
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
  level.sentrysettings["sentry_shock"].var_39B = "sentry_shock_mp";
  level.sentrysettings["sentry_shock"].physics_capsulecast = "ks_shock_sentry_mp";
  level.sentrysettings["sentry_shock"].modelbase = "shock_sentry_gun_wm";
  level.sentrysettings["sentry_shock"].modelgood = "shock_sentry_gun_wm_obj";
  level.sentrysettings["sentry_shock"].modelbad = "shock_sentry_gun_wm_obj_red";
  level.sentrysettings["sentry_shock"].modeldestroyed = "shock_sentry_gun_wm_destroyed";
  level.sentrysettings["sentry_shock"].pow = & "SENTRY_PICKUP";
  level.sentrysettings["sentry_shock"].playerphysicstrace = 1;
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
  var_00 = ["passive_fast_sweep", "passive_decreased_health", "passive_sam_turret", "passive_no_shock", "passive_mini_explosives", "passive_slow_turret"];
  scripts\mp\killstreak_loot::func_DF07("sentry_shock", var_00);
}

tryuseautosentry(param_00, param_01) {
  var_02 = givesentry("sentry_minigun");
  if(var_02) {
    scripts\mp\matchdata::logkillstreakevent(level.sentrysettings["sentry_minigun"].streakname, self.origin);
  }

  return var_02;
}

tryusesam(param_00, param_01) {
  var_02 = givesentry("sam_turret");
  if(var_02) {
    scripts\mp\matchdata::logkillstreakevent(level.sentrysettings["sam_turret"].streakname, self.origin);
  }

  return var_02;
}

tryuseshocksentry(param_00) {
  var_01 = givesentry("sentry_shock", undefined, param_00);
  if(var_01) {
    scripts\mp\matchdata::logkillstreakevent(param_00.streakname, self.origin);
  } else {
    scripts\engine\utility::waitframe();
  }

  return var_01;
}

givesentry(param_00, param_01, param_02) {
  self.last_sentry = param_00;
  if(!isDefined(self.placedsentries)) {
    self.placedsentries = [];
  }

  if(!isDefined(self.placedsentries[param_00])) {
    self.placedsentries[param_00] = [];
  }

  var_03 = 1;
  if(isDefined(param_01)) {
    var_03 = param_01;
  }

  var_04 = createsentryforplayer(param_00, self, var_03, param_02);
  if(isDefined(param_02)) {
    param_02.sentrygun = var_04;
  }

  removeperks();
  self.carriedsentry = var_04;
  var_05 = setcarryingsentry(var_04, 1, var_03);
  self.carriedsentry = undefined;
  thread waitrestoreperks();
  self.iscarrying = 0;
  if(isDefined(var_04)) {
    return 1;
  }

  return 0;
}

setcarryingsentry(param_00, param_01, param_02, param_03) {
  self endon("death");
  self endon("disconnect");
  param_00 sentry_setcarried(self, param_02, param_03);
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
    var_04 = scripts\engine\utility::waittill_any_return("place_sentry", "cancel_sentry", "force_cancel_placement", "apply_player_emp");
    if(!isDefined(param_00)) {
      allowweaponsforsentry(1);
      scripts\engine\utility::allow_usability(1);
      thread enablemeleeforsentry();
      return 1;
    }

    if(var_04 == "cancel_sentry" || var_04 == "force_cancel_placement" || var_04 == "apply_player_emp") {
      if(!param_01 && var_04 == "cancel_sentry" || var_04 == "apply_player_emp") {
        continue;
      }

      param_00 sentry_setcancelled(var_04 == "force_cancel_placement" && !isDefined(param_00.firstplacement));
      return 0;
    }

    if(!param_00.canbeplaced) {
      continue;
    }

    param_00 sentry_setplaced(param_02);
    return 1;
  }
}

enablemeleeforsentry() {
  self endon("death");
  self endon("disconnect");
  wait(0.25);
  scripts\engine\utility::allow_melee(1);
}

removeweapons() {
  if(self hasweapon("iw6_riotshield_mp")) {
    self.restoreweapon = "iw6_riotshield_mp";
    scripts\mp\utility::_takeweapon("iw6_riotshield_mp");
  }
}

removeperks() {
  if(scripts\mp\utility::_hasperk("specialty_explosivebullets")) {
    self.restoreperk = "specialty_explosivebullets";
    scripts\mp\utility::removeperk("specialty_explosivebullets");
  }
}

restoreweapons() {
  if(isDefined(self.restoreweapon)) {
    scripts\mp\utility::_giveweapon(self.restoreweapon);
    self.restoreweapon = undefined;
  }
}

restoreperks() {
  if(isDefined(self.restoreperk)) {
    scripts\mp\utility::giveperk(self.restoreperk);
    self.restoreperk = undefined;
  }
}

waitrestoreperks() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  wait(0.05);
  restoreperks();
}

createsentryforplayer(param_00, param_01, param_02, param_03) {
  var_04 = level.sentrysettings[param_00].var_39B;
  if(scripts\mp\killstreaks\_utility::func_A69F(param_03, "passive_fast_sweep")) {
    var_04 = "sentry_shock_fast_mp";
  }

  var_05 = spawnturret("misc_turret", param_01.origin, var_04);
  var_05.angles = param_01.angles;
  var_05.streakinfo = param_03;
  var_05 sentry_initsentry(param_00, param_01, param_02);
  var_05 thread sentry_destroyongameend();
  return var_05;
}

sentry_initsentry(param_00, param_01, param_02, param_03) {
  if(!isDefined(param_03)) {
    param_03 = 1;
  }

  self.sentrytype = param_00;
  self.canbeplaced = 1;
  self setModel(level.sentrysettings[param_00].modelbase);
  self setnonstick(1);
  self give_player_tickets(1);
  if(level.sentrysettings[param_00].shouldsplash) {
    self.shouldsplash = 1;
  } else {
    self.shouldsplash = 0;
  }

  self.firstplacement = 1;
  self setCanDamage(1);
  switch (param_00) {
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
      self setdefaultdroppitch(0);
      self.originalowner = param_01;
      break;

    case "scramble_turret":
    case "sam_turret":
      self getvalidattachments();
      self setleftarc(180);
      self setrightarc(180);
      self settoparc(80);
      self setdefaultdroppitch(-89);
      self.laser_on = 0;
      var_04 = spawn("script_model", self gettagorigin("tag_laser"));
      var_04 linkto(self);
      self.killcament = var_04;
      self.killcament setscriptmoverkillcam("explosive");
      break;

    case "sentry_shock":
      self getvalidattachments();
      var_05 = anglesToForward(self.angles);
      var_06 = self gettagorigin("tag_laser") + (0, 0, 10);
      var_06 = var_06 - var_05 * 20;
      var_04 = spawn("script_model", var_06);
      var_04 linkto(self);
      self.killcament = var_04;
      break;

    default:
      self getvalidattachments();
      self setdefaultdroppitch(-89);
      break;
  }

  self setturretmodechangewait(1);
  sentry_setinactive();
  sentry_setowner(param_01);
  if(param_03) {
    thread sentry_timeout();
  }

  switch (param_00) {
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
      thread sentry_handleuse(param_02);
      thread sentry_beepsounds();
      break;

    case "super_trophy":
      thread sentry_handleuse(0);
      thread sentry_beepsounds();
      break;

    default:
      thread sentry_handleuse(param_02);
      thread sentry_attacktargets();
      thread sentry_beepsounds();
      break;
  }
}

sentry_createbombsquadmodel(param_00) {
  if(isDefined(level.sentrysettings[param_00].modelbombsquad)) {
    var_01 = spawn("script_model", self.origin);
    var_01.angles = self.angles;
    var_01 hide();
    var_01 thread scripts\mp\weapons::bombsquadvisibilityupdater(self.triggerportableradarping);
    var_01 setModel(level.sentrysettings[param_00].modelbombsquad);
    var_01 linkto(self);
    var_01 setcontents(0);
    self.bombsquadmodel = var_01;
    self waittill("death");
    if(isDefined(var_01)) {
      var_01 delete();
    }
  }
}

sentry_setteamheadicon() {
  var_00 = level.sentrysettings[self.sentrytype].headiconoffset;
  if(!isDefined(var_00)) {
    return;
  }

  if(!isDefined(self.triggerportableradarping)) {
    return;
  }

  var_01 = self.triggerportableradarping;
  var_02 = var_01.team;
  if(level.teambased && !scripts\mp\utility::istrue(self.var_115D1)) {
    scripts\mp\entityheadicons::setteamheadicon(var_02, var_00);
    self.var_115D1 = 1;
    return;
  }

  if(!scripts\mp\utility::istrue(self.var_D3AA)) {
    scripts\mp\entityheadicons::setplayerheadicon(var_01, var_00);
    self.var_D3AA = 1;
  }
}

sentry_clearteamheadicon() {
  var_00 = level.sentrysettings[self.sentrytype].headiconoffset;
  if(!isDefined(var_00)) {
    return;
  }

  if(scripts\mp\utility::istrue(self.var_115D1)) {
    scripts\mp\entityheadicons::setteamheadicon("none", (0, 0, 0));
    self.var_115D1 = undefined;
  }

  if(scripts\mp\utility::istrue(self.var_D3AA)) {
    scripts\mp\entityheadicons::setplayerheadicon(undefined, (0, 0, 0));
    self.var_D3AA = undefined;
  }
}

sentry_destroyongameend() {
  self endon("death");
  level scripts\engine\utility::waittill_any_3("bro_shot_start", "game_ended");
  self notify("death");
}

sentry_handledamage() {
  self endon("carried");
  var_00 = level.sentrysettings[self.sentrytype].maxhealth;
  if(scripts\mp\killstreaks\_utility::func_A69F(self.streakinfo, "passive_fast_sweep")) {
    var_00 = int(var_00 / 1.25);
  }

  var_01 = 0;
  if(self.triggerportableradarping scripts\mp\utility::_hasperk("specialty_rugged_eqp")) {
    var_02 = self.weapon_name;
    if(isDefined(var_02)) {
      switch (var_02) {
        default:
          break;
      }
    }
  }

  var_00 = var_00 + int(var_01);
  scripts\mp\damage::monitordamage(var_00, "sentry", ::sentryhandledeathdamage, ::sentrymodifydamage, 1);
}

sentrymodifydamage(param_00, param_01, param_02, param_03, param_04) {
  var_05 = param_03;
  if(param_02 == "MOD_MELEE") {
    var_05 = self.maxhealth * 0.34;
  }

  var_05 = scripts\mp\killstreaks\_utility::getmodifiedantikillstreakdamage(param_00, param_01, param_02, var_05, self.maxhealth, 2, 3, 4);
  if(isDefined(param_00) && isplayer(param_00) && scripts\mp\equipment\phase_shift::isentityphaseshifted(param_00)) {
    var_05 = 0;
  }

  return var_05;
}

sentryhandledeathdamage(param_00, param_01, param_02, param_03) {
  var_04 = level.sentrysettings[self.sentrytype];
  if(var_04.iskillstreak) {
    if(isDefined(param_01) && param_01 == "concussion_grenade_mp") {
      if(scripts\mp\utility::istrue(scripts\mp\utility::playersareenemies(self.triggerportableradarping, param_00))) {
        param_00 scripts\mp\missions::func_D991("ch_tactical_emp_eqp");
      }
    }

    var_05 = var_04.destroyedsplash;
    var_06 = scripts\mp\killstreak_loot::getrarityforlootitem(self.streakinfo.variantid);
    if(var_06 != "") {
      var_05 = var_05 + "_" + var_06;
    }

    var_07 = scripts\mp\damage::onkillstreakkilled(var_04.streakname, param_00, param_01, param_02, param_03, var_04.scorepopup, var_04.vodestroyed, var_05);
    if(var_07) {
      param_00 notify("destroyed_equipment");
      return;
    }

    return;
  }

  var_08 = undefined;
  var_09 = param_00;
  if(isDefined(var_09) && isDefined(self.triggerportableradarping)) {
    if(isDefined(param_00.triggerportableradarping) && isplayer(param_00.triggerportableradarping)) {
      var_09 = param_00.triggerportableradarping;
    }

    if(self.triggerportableradarping scripts\mp\utility::isenemy(var_09)) {
      var_08 = var_09;
    }
  }

  if(isDefined(var_08)) {
    var_08 thread scripts\mp\events::supershutdown(self.triggerportableradarping);
    var_08 notify("destroyed_equipment");
  }

  self notify("death");
}

sentry_watchdisabled() {
  self endon("carried");
  self endon("death");
  level endon("game_ended");
  for(;;) {
    self waittill("emp_damage", var_00, var_01, var_02, var_03, var_04);
    scripts\mp\killstreaks\_utility::dodamagetokillstreak(100, var_00, var_00, self.team, var_02, var_04, var_03);
    if(!scripts\mp\utility::istrue(self.disabled)) {
      thread disablesentry(var_01);
    }
  }
}

disablesentry(param_00) {
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
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(param_00);
  self setdefaultdroppitch(-89);
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
  if(isDefined(self.triggerportableradarping)) {
    self.triggerportableradarping.placedsentries[self.sentrytype] = scripts\engine\utility::array_remove(self.triggerportableradarping.placedsentries[self.sentrytype], self);
  }

  if(!isDefined(self)) {
    return;
  }

  self cleartargetentity();
  self laseroff();
  self setModel(level.sentrysettings[self.sentrytype].modeldestroyed);
  if(isDefined(self.fxentdeletelist) && self.fxentdeletelist.size > 0) {
    foreach(var_01 in self.fxentdeletelist) {
      if(isDefined(var_01)) {
        var_01 delete();
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
    self.inuseby restoreperks();
    self.inuseby restoreweapons();
    self notify("deleting");
    wait(1);
    stopFXOnTag(scripts\engine\utility::getfx("sentry_explode_mp"), self, "tag_origin");
    stopFXOnTag(scripts\engine\utility::getfx("sentry_smoke_mp"), self, "tag_aim");
  } else {
    self playSound("sentry_explode_smoke");
    self setscriptablepartstate("destroyed", "sparks");
    wait(5);
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

  scripts\mp\utility::printgameaction("killstreak ended - shock_sentry", self.triggerportableradarping);
  self delete();
}

sentry_handleuse(param_00) {
  self endon("death");
  level endon("game_ended");
  for(;;) {
    self waittill("trigger", var_01);
    if(!scripts\mp\utility::isreallyalive(var_01)) {
      continue;
    }

    if(self.sentrytype == "sam_turret" || self.sentrytype == "scramble_turret" || self.sentrytype == "sentry_shock" && scripts\mp\killstreaks\_utility::func_A69F(self.streakinfo, "passive_sam_turret")) {
      self give_player_session_tokens(level.sentrysettings[self.sentrytype].sentrymodeoff);
    }

    var_01.placedsentries[self.sentrytype] = scripts\engine\utility::array_remove(var_01.placedsentries[self.sentrytype], self);
    var_01 setcarryingsentry(self, 0, param_00);
  }
}

turret_handlepickup(param_00) {
  self endon("disconnect");
  level endon("game_ended");
  param_00 endon("death");
  if(!isDefined(param_00.ownertrigger)) {
    return;
  }

  var_01 = 0;
  for(;;) {
    if(isalive(self) && self istouching(param_00.ownertrigger) && !isDefined(param_00.inuseby) && !isDefined(param_00.carriedby) && self isonground()) {
      if(self usebuttonpressed()) {
        if(isDefined(self.using_remote_turret) && self.using_remote_turret) {
          continue;
        }

        var_01 = 0;
        while(self usebuttonpressed()) {
          var_01 = var_01 + 0.05;
          wait(0.05);
        }

        if(var_01 >= 0.5) {
          continue;
        }

        var_01 = 0;
        while(!self usebuttonpressed() && var_01 < 0.5) {
          var_01 = var_01 + 0.05;
          wait(0.05);
        }

        if(var_01 >= 0.5) {
          continue;
        }

        if(!scripts\mp\utility::isreallyalive(self)) {
          continue;
        }

        if(isDefined(self.using_remote_turret) && self.using_remote_turret) {
          continue;
        }

        param_00 give_player_session_tokens(level.sentrysettings[param_00.sentrytype].sentrymodeoff);
        thread setcarryingsentry(param_00, 0);
        param_00.ownertrigger delete();
        return;
      }
    }

    wait(0.05);
  }
}

turret_handleuse() {
  self notify("turret_handluse");
  self endon("turret_handleuse");
  self endon("deleting");
  level endon("game_ended");
  self.forcedisable = 0;
  var_00 = (1, 0.9, 0.7);
  var_01 = (1, 0.65, 0);
  var_02 = (1, 0.25, 0);
  for(;;) {
    self waittill("trigger", var_03);
    if(isDefined(self.carriedby)) {
      continue;
    }

    if(isDefined(self.inuseby)) {
      continue;
    }

    if(!scripts\mp\utility::isreallyalive(var_03)) {
      continue;
    }

    var_03 removeperks();
    var_03 removeweapons();
    self.inuseby = var_03;
    self give_player_session_tokens(level.sentrysettings[self.sentrytype].sentrymodeoff);
    sentry_setowner(var_03);
    self give_player_session_tokens(level.sentrysettings[self.sentrytype].sentrymodeon);
    var_03 thread turret_shotmonitor(self);
    var_03.turret_overheat_bar = var_03 scripts\mp\hud_util::createbar(var_00, 100, 6);
    var_03.turret_overheat_bar scripts\mp\hud_util::setpoint("CENTER", "BOTTOM", 0, -70);
    var_03.turret_overheat_bar.alpha = 0.65;
    var_03.turret_overheat_bar.bar.alpha = 0.65;
    var_04 = 0;
    for(;;) {
      if(!scripts\mp\utility::isreallyalive(var_03)) {
        self.inuseby = undefined;
        var_03.turret_overheat_bar scripts\mp\hud_util::destroyelem();
        break;
      }

      if(!var_03 isusingturret()) {
        self notify("player_dismount");
        self.inuseby = undefined;
        var_03.turret_overheat_bar scripts\mp\hud_util::destroyelem();
        var_03 restoreperks();
        var_03 restoreweapons();
        self sethintstring(level.sentrysettings[self.sentrytype].pow);
        self give_player_session_tokens(level.sentrysettings[self.sentrytype].sentrymodeoff);
        sentry_setowner(self.originalowner);
        self give_player_session_tokens(level.sentrysettings[self.sentrytype].sentrymodeon);
        break;
      }

      if(self.heatlevel >= level.sentrysettings[self.sentrytype].overheattime) {
        var_05 = 1;
      } else {
        var_05 = self.heatlevel / level.sentrysettings[self.sentrytype].overheattime;
      }

      var_03.turret_overheat_bar scripts\mp\hud_util::updatebar(var_05);
      if(scripts\engine\utility::string_starts_with(self.sentrytype, "minigun_turret")) {
        var_06 = "minigun_turret";
      }

      if(self.forcedisable || self.overheated) {
        self turretfiredisable();
        var_03.turret_overheat_bar.bar.color = var_02;
        var_04 = 0;
      } else if(self.heatlevel > level.sentrysettings[self.sentrytype].overheattime * 0.75 && scripts\engine\utility::string_starts_with(self.sentrytype, "minigun_turret")) {
        var_03.turret_overheat_bar.bar.color = var_01;
        if(randomintrange(0, 10) < 6) {
          self turretfireenable();
        } else {
          self turretfiredisable();
        }

        if(!var_04) {
          var_04 = 1;
          thread playheatfx();
        }
      } else {
        var_03.turret_overheat_bar.bar.color = var_00;
        self turretfireenable();
        var_04 = 0;
        self notify("not_overheated");
      }

      wait(0.05);
    }

    self setdefaultdroppitch(0);
  }
}

sentry_handleownerdisconnect() {
  self endon("death");
  level endon("game_ended");
  self notify("sentry_handleOwner");
  self endon("sentry_handleOwner");
  self.triggerportableradarping waittill("killstreak_disowned");
  self notify("death");
}

sentry_setowner(param_00) {
  self.triggerportableradarping = param_00;
  self setsentryowner(self.triggerportableradarping);
  self setturretminimapvisible(1, self.sentrytype);
  if(level.teambased) {
    self.team = self.triggerportableradarping.team;
    self setturretteam(self.team);
  }

  thread sentry_handleownerdisconnect();
}

sentry_moving_platform_death(param_00) {
  self notify("death");
}

sentry_setplaced(param_00) {
  if(isDefined(self.triggerportableradarping)) {
    var_01 = self.triggerportableradarping.placedsentries[self.sentrytype].size;
    self.triggerportableradarping.placedsentries[self.sentrytype][var_01] = self;
    if(var_01 + 1 > 2) {
      self.triggerportableradarping.placedsentries[self.sentrytype][0] notify("death");
    }

    self.triggerportableradarping allowweaponsforsentry(1);
    self.triggerportableradarping scripts\engine\utility::allow_usability(1);
    self.triggerportableradarping thread enablemeleeforsentry();
    self.triggerportableradarping enableworldup(1);
  }

  var_02 = level.sentrysettings[self.sentrytype].modelbase;
  var_03 = scripts\mp\killstreak_loot::getrarityforlootitem(self.streakinfo.variantid);
  if(var_03 != "") {
    var_02 = var_02 + "_" + var_03;
  }

  self setModel(var_02);
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
      if(param_00) {
        self.angles = self.carriedby.angles;
        if(isalive(self.originalowner)) {
          self.originalowner scripts\mp\utility::setlowermessage("pickup_hint", level.sentrysettings[self.sentrytype].ownerhintstring, 3, undefined, undefined, undefined, undefined, undefined, 1);
        }

        self.ownertrigger = spawn("trigger_radius", self.origin + (0, 0, 1), 0, 105, 64);
        self.ownertrigger enablelinkto();
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
  if(isDefined(self.triggerportableradarping)) {
    self.triggerportableradarping.iscarrying = 0;
    self.triggerportableradarping notify("new_sentry", self);
  }

  sentry_setactive(param_00);
  var_04 = spawnStruct();
  if(isDefined(self.moving_platform)) {
    var_04.linkparent = self.moving_platform;
  }

  var_04.endonstring = "carried";
  var_04.deathoverridecallback = ::sentry_moving_platform_death;
  thread scripts\mp\movers::handle_moving_platforms(var_04);
  if(self.sentrytype != "multiturret") {
    self playSound("sentry_gun_plant");
  }

  thread scripts\mp\weapons::doblinkinglight(level.sentrysettings[self.sentrytype].lightfxtag);
  self notify("placed");
}

sentry_setcancelled(param_00) {
  if(isDefined(self.carriedby)) {
    var_01 = self.carriedby;
    var_01 getrigindexfromarchetyperef();
    var_01.iscarrying = undefined;
    var_01.carrieditem = undefined;
    var_01 allowweaponsforsentry(1);
    var_01 scripts\engine\utility::allow_usability(1);
    var_01 thread enablemeleeforsentry();
    var_01 enableworldup(1);
    if(isDefined(self.bombsquadmodel)) {
      self.bombsquadmodel delete();
    }
  }

  if(isDefined(param_00) && param_00) {
    scripts\mp\weapons::equipmentdeletevfx();
  }

  self delete();
}

sentry_setcarried(param_00, param_01, param_02) {
  if(isDefined(self.originalowner)) {} else {}

  if(self.sentrytype == "sentry_shock") {
    self setscriptablepartstate("coil", "neutral");
    self setscriptablepartstate("muzzle", "neutral", 0);
  }

  self setModel(level.sentrysettings[self.sentrytype].modelgood);
  self setsentrycarrier(param_00);
  self setCanDamage(0);
  sentry_makenotsolid();
  param_00 enableworldup(0);
  self.carriedby = param_00;
  param_00.iscarrying = 1;
  self.pickupenabled = param_01;
  thread sentry_oncarrierdeathoremp(param_00, param_02);
  param_00 thread updatesentryplacement(self);
  thread sentry_oncarrierdisconnect(param_00);
  thread sentry_oncarrierchangedteam(param_00);
  thread sentry_ongameended();
  self setdefaultdroppitch(-89);
  sentry_setinactive();
  if(isDefined(self getlinkedparent())) {
    self unlink();
  }

  self notify("carried");
  if(isDefined(self.bombsquadmodel)) {
    self.bombsquadmodel hide();
  }
}

updatesentryplacement(param_00) {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  param_00 endon("placed");
  param_00 endon("death");
  param_00.canbeplaced = 1;
  var_01 = -1;
  for(;;) {
    var_02 = self canplayerplacesentry(1, 40);
    param_00.origin = var_02["origin"];
    param_00.angles = var_02["angles"];
    var_03 = scripts\engine\utility::array_combine(level.turrets, level.microturrets, level.supertrophy.trophies, level.mines);
    var_04 = param_00 getistouchingentities(var_03);
    param_00.canbeplaced = self isonground() && var_02["result"] && abs(param_00.origin[2] - self.origin[2]) < 30 && !scripts\mp\utility::func_9FAE(self) && var_04.size == 0;
    if(isDefined(var_02["entity"])) {
      param_00.moving_platform = var_02["entity"];
    } else {
      param_00.moving_platform = undefined;
    }

    if(param_00.canbeplaced != var_01) {
      if(param_00.canbeplaced) {
        param_00 setModel(level.sentrysettings[param_00.sentrytype].modelgood);
        param_00 placehinton();
      } else {
        param_00 setModel(level.sentrysettings[param_00.sentrytype].modelbad);
        param_00 cannotplacehinton();
      }
    }

    var_01 = param_00.canbeplaced;
    wait(0.05);
  }
}

sentry_oncarrierdeathoremp(param_00, param_01) {
  self endon("placed");
  self endon("death");
  param_00 endon("disconnect");
  param_00 scripts\engine\utility::waittill_any_3("death", "apply_player_emp");
  if(self.canbeplaced && !scripts\mp\utility::istrue(param_01)) {
    sentry_setplaced(self.pickupenabled);
    return;
  }

  sentry_setcancelled(0);
}

sentry_oncarrierdisconnect(param_00) {
  self endon("placed");
  self endon("death");
  param_00 waittill("disconnect");
  self delete();
}

sentry_oncarrierchangedteam(param_00) {
  self endon("placed");
  self endon("death");
  param_00 scripts\engine\utility::waittill_any_3("joined_team", "joined_spectators");
  self delete();
}

sentry_ongameended(param_00) {
  self endon("placed");
  self endon("death");
  level waittill("game_ended");
  self delete();
}

sentry_setactive(param_00) {
  self give_player_session_tokens(level.sentrysettings[self.sentrytype].sentrymodeon);
  if(param_00) {
    self setcursorhint("HINT_NOICON");
    self sethintstring(level.sentrysettings[self.sentrytype].pow);
    self makeusable();
  }

  sentry_setteamheadicon();
  foreach(var_02 in level.players) {
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
        if(param_00) {
          self enableplayeruse(var_02);
        }
        break;

      default:
        scripts\mp\killstreaks\_utility::func_1843(self.sentrytype, "Killstreak_Ground", self.triggerportableradarping, 1, "carried");
        if(var_02 == self.triggerportableradarping && param_00) {
          self enableplayeruse(var_02);
        } else {
          self disableplayeruse(var_02);
        }
        break;
    }
  }

  var_04 = level.sentrysettings[self.sentrytype].teamsplash;
  var_05 = scripts\mp\killstreak_loot::getrarityforlootitem(self.streakinfo.variantid);
  if(var_05 != "") {
    var_04 = var_04 + "_" + var_05;
  }

  if(self.shouldsplash) {
    level thread scripts\mp\utility::teamplayercardsplash(var_04, self.triggerportableradarping);
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

isfriendlytosentry(param_00) {
  if(level.teambased && self.team == param_00.team) {
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
  var_00 = level.sentrysettings[self.sentrytype].timeout;
  if(isDefined(var_00) && var_00 == 0) {
    return;
  }

  while(var_00) {
    wait(1);
    scripts\mp\hostmigration::waittillhostmigrationdone();
    if(!isDefined(self.carriedby)) {
      var_00 = max(0, var_00 - 1);
    }
  }

  if(isDefined(self.triggerportableradarping)) {
    if(isDefined(level.sentrysettings[self.sentrytype].votimeout)) {
      self.triggerportableradarping scripts\mp\utility::playkillstreakdialogonplayer(level.sentrysettings[self.sentrytype].votimeout, undefined, undefined, self.triggerportableradarping.origin);
    }
  }

  self notify("death");
}

sentry_targetlocksound() {
  self endon("death");
  self playSound("sentry_gun_beep");
  wait(0.1);
  self playSound("sentry_gun_beep");
  wait(0.1);
  self playSound("sentry_gun_beep");
}

sentry_spinup() {
  thread sentry_targetlocksound();
  while(self.momentum < level.sentrysettings[self.sentrytype].spinuptime) {
    self.momentum = self.momentum + 0.1;
    wait(0.1);
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
  var_00 = weaponfiretime(level.sentrysettings[self.sentrytype].var_39B);
  var_01 = level.sentrysettings[self.sentrytype].burstmin;
  var_02 = level.sentrysettings[self.sentrytype].burstmax;
  if(isDefined(self.supportturret) && self.supportturret) {
    var_00 = 0.05;
    var_03 = 50;
  } else {
    var_01 = 0.5 / self.listoffoundturrets.size + 1;
    var_03 = var_02;
  }

  for(var_04 = 0; var_04 < var_03; var_04++) {
    var_05 = self getturrettarget(1);
    if(!isDefined(var_05)) {
      break;
    }

    self shootturret();
    wait(var_00);
  }

  self notify("doneFiring");
  self cleartargetentity();
}

sentry_burstfirestart() {
  self endon("death");
  self endon("stop_shooting");
  level endon("game_ended");
  sentry_spinup();
  var_00 = weaponfiretime(level.sentrysettings[self.sentrytype].var_39B);
  var_01 = level.sentrysettings[self.sentrytype].burstmin;
  var_02 = level.sentrysettings[self.sentrytype].burstmax;
  var_03 = level.sentrysettings[self.sentrytype].pausemin;
  var_04 = level.sentrysettings[self.sentrytype].pausemax;
  for(;;) {
    var_05 = randomintrange(var_01, var_02 + 1);
    for(var_06 = 0; var_06 < var_05 && !self.overheated; var_06++) {
      self shootturret();
      self notify("bullet_fired");
      self.heatlevel = self.heatlevel + var_00;
      wait(var_00);
    }

    wait(randomfloatrange(var_03, var_04));
  }
}

sentry_burstfirestop() {
  self notify("stop_shooting");
}

turret_shotmonitor(param_00) {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  param_00 endon("death");
  param_00 endon("player_dismount");
  var_01 = weaponfiretime(level.sentrysettings[param_00.sentrytype].var_39B);
  for(;;) {
    param_00 waittill("turret_fire");
    param_00.heatlevel = param_00.heatlevel + var_01;
    param_00.cooldownwaittime = var_01;
  }
}

sentry_heatmonitor() {
  self endon("death");
  var_00 = weaponfiretime(level.sentrysettings[self.sentrytype].var_39B);
  var_01 = 0;
  var_02 = 0;
  var_03 = level.sentrysettings[self.sentrytype].overheattime;
  var_04 = level.sentrysettings[self.sentrytype].cooldowntime;
  for(;;) {
    if(self.heatlevel != var_01) {
      wait(var_00);
    } else {
      self.heatlevel = max(0, self.heatlevel - 0.05);
    }

    if(self.heatlevel > var_03) {
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
        self.heatlevel = max(0, self.heatlevel - var_04);
        wait(0.1);
      }

      self.overheated = 0;
      self notify("not_overheated");
    }

    var_01 = self.heatlevel;
    wait(0.05);
  }
}

turret_heatmonitor() {
  self endon("death");
  var_00 = level.sentrysettings[self.sentrytype].overheattime;
  for(;;) {
    if(self.heatlevel > var_00) {
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
        wait(0.1);
      }

      self.overheated = 0;
      self notify("not_overheated");
    }

    wait(0.05);
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

    wait(0.05);
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
    wait(0.4);
  }
}

sentry_beepsounds() {
  self endon("death");
  level endon("game_ended");
  for(;;) {
    wait(3);
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
    wait(0.05);
  }
}

sam_acquiretarget() {
  var_00 = self gettagorigin("tag_laser");
  if(!isDefined(self.samtargetent)) {
    if(level.teambased) {
      var_01 = [];
      if(level.multiteambased) {
        foreach(var_03 in level.teamnamelist) {
          if(var_03 != self.team) {
            foreach(var_05 in level.uavmodels[var_03]) {
              var_01[var_01.size] = var_05;
            }
          }
        }
      } else {
        var_01 = level.uavmodels[level.otherteam[self.team]];
      }

      foreach(var_09 in var_01) {
        if(isDefined(var_09.isleaving) && var_09.isleaving) {
          continue;
        }

        if(sighttracepassed(var_00, var_09.origin, 0, self)) {
          return var_09;
        }
      }

      foreach(var_0C in level.littlebirds) {
        if(isDefined(var_0C.team) && var_0C.team == self.team) {
          continue;
        }

        if(sighttracepassed(var_00, var_0C.origin, 0, self)) {
          return var_0C;
        }
      }

      foreach(var_0F in level.helis) {
        if(isDefined(var_0F.team) && var_0F.team == self.team) {
          continue;
        }

        if(sighttracepassed(var_00, var_0F.origin, 0, self)) {
          return var_0F;
        }
      }

      foreach(var_09 in level.remote_uav) {
        if(!isDefined(var_09)) {
          continue;
        }

        if(isDefined(var_09.team) && var_09.team == self.team) {
          continue;
        }

        if(sighttracepassed(var_00, var_09.origin, 0, self, var_09)) {
          return var_09;
        }
      }
    } else {
      foreach(var_09 in level.uavmodels) {
        if(isDefined(var_09.isleaving) && var_09.isleaving) {
          continue;
        }

        if(isDefined(var_09.triggerportableradarping) && isDefined(self.triggerportableradarping) && var_09.triggerportableradarping == self.triggerportableradarping) {
          continue;
        }

        if(sighttracepassed(var_00, var_09.origin, 0, self)) {
          return var_09;
        }
      }

      foreach(var_0C in level.littlebirds) {
        if(isDefined(var_0C.triggerportableradarping) && isDefined(self.triggerportableradarping) && var_0C.triggerportableradarping == self.triggerportableradarping) {
          continue;
        }

        if(sighttracepassed(var_00, var_0C.origin, 0, self)) {
          return var_0C;
        }
      }

      foreach(var_0F in level.helis) {
        if(isDefined(var_0F.triggerportableradarping) && isDefined(self.triggerportableradarping) && var_0F.triggerportableradarping == self.triggerportableradarping) {
          continue;
        }

        if(sighttracepassed(var_00, var_0F.origin, 0, self)) {
          return var_0F;
        }
      }

      foreach(var_09 in level.remote_uav) {
        if(!isDefined(var_09)) {
          continue;
        }

        if(isDefined(var_09.triggerportableradarping) && isDefined(self.triggerportableradarping) && var_09.triggerportableradarping == self.triggerportableradarping) {
          continue;
        }

        if(sighttracepassed(var_00, var_09.origin, 0, self, var_09)) {
          return var_09;
        }
      }
    }

    self cleartargetentity();
    return undefined;
  }

  if(!sighttracepassed(var_0F, self.samtargetent.origin, 0, self)) {
    self cleartargetentity();
    return undefined;
  }

  return self.samtargetent;
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

    wait(2);
    if(!isDefined(self.samtargetent)) {
      return;
    }

    if(self.samtargetent == level.ac130.planemodel && !isDefined(level.ac130player)) {
      self.samtargetent = undefined;
      self cleartargetentity();
      return;
    }

    var_00 = [];
    var_00[0] = self gettagorigin("tag_le_missile1");
    var_00[1] = self gettagorigin("tag_le_missile2");
    var_00[2] = self gettagorigin("tag_ri_missile1");
    var_00[3] = self gettagorigin("tag_ri_missile2");
    var_01 = self.sammissilegroups.size;
    for(var_02 = 0; var_02 < 4; var_02++) {
      if(!isDefined(self.samtargetent)) {
        return;
      }

      if(isDefined(self.carriedby)) {
        return;
      }

      self shootturret();
      var_03 = scripts\mp\utility::_magicbullet("sam_projectile_mp", var_00[var_02], self.samtargetent.origin, self.triggerportableradarping);
      var_03 missile_settargetent(self.samtargetent);
      var_03 missile_setflightmodedirect();
      var_03.samturret = self;
      var_03.sammissilegroup = var_01;
      self.sammissilegroups[var_01][var_02] = var_03;
      level notify("sam_missile_fired", self.triggerportableradarping, var_03, self.samtargetent);
      if(var_02 == 3) {
        break;
      }

      wait(0.25);
    }

    level notify("sam_fired", self.triggerportableradarping, self.sammissilegroups[var_01], self.samtargetent);
    wait(3);
  }
}

sam_watchlineofsight() {
  level endon("game_ended");
  self endon("death");
  while(isDefined(self.samtargetent) && isDefined(self getturrettarget(1)) && self getturrettarget(1) == self.samtargetent) {
    var_00 = self gettagorigin("tag_laser");
    if(!sighttracepassed(var_00, self.samtargetent.origin, 0, self, self.samtargetent)) {
      self cleartargetentity();
      self.samtargetent = undefined;
      break;
    }

    wait(0.05);
  }
}

sam_watchlaser() {
  self endon("death");
  self laseron();
  self.laser_on = 1;
  while(isDefined(self.samtargetent) && isDefined(self getturrettarget(1)) && self getturrettarget(1) == self.samtargetent) {
    wait(0.05);
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

    wait(0.05);
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

    wait(2);
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
  var_00 = self.scrambletargetent;
  var_00 notify("scramble_fired", self.triggerportableradarping);
  var_00 endon("scramble_fired");
  var_00 endon("death");
  var_00 thread scripts\mp\killstreaks\_helicopter::heli_targeting();
  var_00.scrambled = 1;
  var_00.secondowner = self.triggerportableradarping;
  var_00 notify("findNewTarget");
  wait(30);
  if(isDefined(var_00)) {
    var_00.scrambled = 0;
    var_00.secondowner = undefined;
    var_00 thread scripts\mp\killstreaks\_helicopter::heli_targeting();
  }
}

scramble_watchlineofsight() {
  level endon("game_ended");
  self endon("death");
  while(isDefined(self.scrambletargetent) && isDefined(self getturrettarget(1)) && self getturrettarget(1) == self.scrambletargetent) {
    var_00 = self gettagorigin("tag_laser");
    if(!sighttracepassed(var_00, self.scrambletargetent.origin, 0, self, self.scrambletargetent)) {
      self cleartargetentity();
      self.scrambletargetent = undefined;
      break;
    }

    wait(0.05);
  }
}

scramble_watchlaser() {
  self endon("death");
  self laseron();
  self.laser_on = 1;
  while(isDefined(self.scrambletargetent) && isDefined(self getturrettarget(1)) && self getturrettarget(1) == self.scrambletargetent) {
    wait(0.05);
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
    var_00 = scripts\engine\utility::waittill_any_timeout_1(1, "turret_on_target");
    if(var_00 == "timeout") {
      if(scripts\mp\killstreaks\_utility::func_A69F(self.streakinfo, "passive_sam_turret")) {
        self.sentryshocksamtarget = thread searchforshocksentryairtarget();
        if(isDefined(self.sentryshocksamtarget)) {
          thread shootshocksentrysamtarget(self.sentryshocksamtarget, self.airlookatent);
          self waittill("done_firing");
        }
      }

      continue;
    }

    self.sentryshocktargetent = self getturrettarget(1);
    if(isDefined(self.sentryshocktargetent) && scripts\mp\utility::isreallyalive(self.sentryshocktargetent)) {
      thread shocktarget(self.sentryshocktargetent);
      self waittill("done_firing");
    }
  }
}

searchforshocksentryairtarget() {
  if(isDefined(level.uavmodels)) {
    if(level.teambased) {
      foreach(var_01 in level.uavmodels[scripts\mp\utility::getotherteam(self.triggerportableradarping.team)]) {
        if(targetvisibleinfront(var_01)) {
          return var_01;
        }
      }
    } else {
      foreach(var_01 in level.uavmodels) {
        if(var_01.triggerportableradarping == self.triggerportableradarping) {
          continue;
        }

        if(targetvisibleinfront(var_01)) {
          return var_01;
        }
      }
    }
  }

  if(isDefined(level.balldrones)) {
    foreach(var_06 in level.balldrones) {
      if(var_06.streakname != "ball_drone_backup") {
        continue;
      }

      if(level.teambased && var_06.team == self.triggerportableradarping.team) {
        continue;
      }

      if(!level.teambased && var_06.triggerportableradarping == self.triggerportableradarping) {
        continue;
      }

      if(targetvisibleinfront(var_06)) {
        return var_06;
      }
    }
  }

  if(isDefined(level.helis)) {
    foreach(var_09 in level.helis) {
      if(var_09.streakname != "jackal") {
        continue;
      }

      if(level.teambased && var_09.team == self.triggerportableradarping.team) {
        continue;
      }

      if(!level.teambased && var_09.triggerportableradarping == self.triggerportableradarping) {
        continue;
      }

      if(targetvisibleinfront(var_09)) {
        return var_09;
      }
    }
  }

  if(isDefined(level.var_DA61)) {
    foreach(var_0C in level.var_DA61) {
      if(var_0C.streakname != "thor") {
        continue;
      }

      if(isDefined(var_0C.team)) {
        if(level.teambased && var_0C.team == self.triggerportableradarping.team) {
          continue;
        }
      }

      if(!level.teambased && var_0C.triggerportableradarping == self.triggerportableradarping) {
        continue;
      }

      if(targetvisibleinfront(var_0C)) {
        return var_0C;
      }
    }
  }

  if(isDefined(level.var_105EA)) {
    foreach(var_0C in level.var_105EA) {
      if(var_0C.streakname != "minijackal") {
        continue;
      }

      if(isDefined(var_0C.team)) {
        if(level.teambased && var_0C.team == self.triggerportableradarping.team) {
          continue;
        }
      }

      if(!level.teambased && var_0C.triggerportableradarping == self.triggerportableradarping) {
        continue;
      }

      if(targetvisibleinfront(var_0C)) {
        return var_0C;
      }
    }
  }
}

targetvisibleinfront(param_00) {
  if(!isDefined(param_00)) {
    return 0;
  }

  var_01 = 0;
  var_02 = self gettagorigin("tag_flash");
  var_03 = param_00.origin;
  var_04 = vectornormalize(var_03 - var_02);
  var_05 = anglesToForward(self.angles);
  var_06 = [self, self.triggerportableradarping, param_00];
  var_07 = physics_createcontents(["physicscontents_solid", "physicscontents_glass", "physicscontents_water", "physicscontents_vehicle", "physicscontents_item"]);
  if(scripts\common\trace::ray_trace_passed(var_02, var_03, var_06, var_07) && vectordot(var_05, var_04) > 0.25 && distance2dsquared(var_02, var_03) > 10000) {
    var_01 = 1;
  }

  return var_01;
}

shootshocksentrysamtarget(param_00, param_01) {
  self endon("death");
  self endon("carried");
  level endon("game_ended");
  self give_player_session_tokens("manual");
  thread setshocksamtargetent(param_00, param_01);
  self.sentryshocksamtarget = undefined;
  self waittill("turret_on_target");
  thread marktargetlaser(param_00);
  self playSound("shock_sentry_charge_up");
  playFXOnTag(scripts\engine\utility::getfx("sentry_shock_charge"), self, "tag_laser");
  sentry_spinup();
  stopFXOnTag(scripts\engine\utility::getfx("sentry_shock_charge"), self, "tag_laser");
  self notify("start_firing");
  self setscriptablepartstate("coil", "active");
  var_02 = 2;
  var_03 = 1;
  while(isDefined(param_00) && targetvisibleinfront(param_00)) {
    var_04 = self gettagorigin("tag_flash");
    var_05 = scripts\mp\utility::_magicbullet("sentry_shock_missile_mp", var_04, param_00.origin, self.triggerportableradarping);
    var_05 missile_settargetent(param_00);
    var_05 missile_setflightmodedirect();
    var_05.killcament = self.killcament;
    var_05.streakinfo = self.streakinfo;
    self setscriptablepartstate("muzzle", "fire" + var_03, 0);
    level notify("laserGuidedMissiles_incoming", self.triggerportableradarping, var_05, param_00);
    var_03++;
    if(var_03 > 2) {
      var_03 = 1;
    }

    wait(var_02);
  }

  self setscriptablepartstate("muzzle", "neutral", 0);
  self notify("sentry_lost_target");
  param_01 unlink();
  param_01.origin = self gettagorigin("tag_flash");
  param_01 linkto(self, "tag_flash");
  self give_player_session_tokens("sentry");
  self cleartargetentity();
  self setscriptablepartstate("coil", "idle");
  sentry_spindown();
  self notify("done_firing");
}

setshocksamtargetent(param_00, param_01) {
  self endon("death");
  self endon("carried");
  self endon("sentry_lost_target");
  param_00 endon("death");
  level endon("game_ended");
  for(;;) {
    var_02 = self gettagorigin("tag_aim");
    var_03 = param_00.origin;
    var_04 = vectornormalize(var_03 - var_02);
    var_05 = var_02 + var_04 * 500;
    param_01 unlink();
    param_01.origin = var_05;
    param_01 linkto(self);
    self settargetentity(param_01);
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

shocktarget(param_00) {
  self endon("death");
  self endon("carried");
  if(!isDefined(param_00)) {
    return;
  }

  thread marktargetlaser(param_00);
  if(!scripts\mp\killstreaks\_utility::func_A69F(self.streakinfo, "passive_sam_turret")) {
    thread watchshockdamage(param_00);
  }

  self playSound("shock_sentry_charge_up");
  playFXOnTag(scripts\engine\utility::getfx("sentry_shock_charge"), self, "tag_laser");
  sentry_spinup();
  stopFXOnTag(scripts\engine\utility::getfx("sentry_shock_charge"), self, "tag_laser");
  self notify("start_firing");
  self setscriptablepartstate("coil", "active");
  level thread scripts\mp\battlechatter_mp::saytoself(param_00, "plr_killstreak_target");
  var_01 = weaponfiretime(level.sentrysettings[self.sentrytype].var_39B);
  while(isDefined(param_00) && scripts\mp\utility::isreallyalive(param_00) && isDefined(self getturrettarget(1)) && self getturrettarget(1) == param_00 && !scripts\mp\utility::func_C7A0(self gettagorigin("tag_flash"), param_00 getEye())) {
    if(scripts\mp\killstreaks\_utility::func_A69F(self.streakinfo, "passive_mini_explosives")) {
      thread missileburstfire(param_00);
      var_01 = 1.5;
      continue;
    }

    self shootturret();
    wait(var_01);
  }

  self setscriptablepartstate("coil", "idle");
  self setscriptablepartstate("muzzle", "neutral", 0);
  self.sentryshocktargetent = undefined;
  self cleartargetentity();
  sentry_spindown();
  self notify("done_firing");
}

missileburstfire(param_00) {
  self endon("death");
  self endon("carried");
  var_01 = 3;
  var_02 = 1;
  while(var_01 > 0) {
    if(!isDefined(param_00)) {
      return;
    }

    if(!isDefined(self.triggerportableradarping)) {
      return;
    }

    var_03 = scripts\mp\utility::_magicbullet("sentry_shock_grenade_mp", self gettagorigin("tag_flash"), param_00.origin, self.triggerportableradarping);
    if(scripts\mp\killstreaks\_utility::manualmissilecantracktarget(param_00)) {
      var_03 missile_settargetent(param_00, gettargetoffset(param_00));
      param_00 thread watchtarget(var_03);
    }

    var_03.killcament = self.killcament;
    var_03.streakinfo = self.streakinfo;
    self setscriptablepartstate("muzzle", "fire" + var_02, 0);
    var_02++;
    if(var_02 > 2) {
      var_02 = 1;
    }

    var_01--;
    wait(0.2);
  }
}

gettargetoffset(param_00) {
  var_01 = (0, 0, 40);
  var_02 = param_00 getstance();
  switch (var_02) {
    case "stand":
      var_01 = (0, 0, 40);
      break;

    case "crouch":
      var_01 = (0, 0, 20);
      break;

    case "prone":
      var_01 = (0, 0, 5);
      break;
  }

  return var_01;
}

watchtarget(param_00) {
  self endon("disconnect");
  for(;;) {
    if(!scripts\mp\killstreaks\_utility::manualmissilecantracktarget(self)) {
      break;
    }

    if(!isDefined(param_00)) {
      break;
    }

    scripts\engine\utility::waitframe();
  }

  if(isDefined(param_00)) {
    param_00 missile_cleartarget();
  }
}

marktargetlaser(param_00) {
  self endon("death");
  self laseron();
  self.laser_on = 1;
  scripts\engine\utility::waittill_any_3("done_firing", "carried");
  self laseroff();
  self.laser_on = 0;
}

watchshockdamage(param_00) {
  self endon("death");
  self endon("done_firing");
  var_01 = undefined;
  for(;;) {
    self waittill("victim_damaged", var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09, var_0A, var_0B);
    if(var_02 == param_00) {
      var_0C = 100;
      var_0D = scripts\mp\utility::getplayersinradiusview(var_08, var_0C, var_02.team, self.triggerportableradarping);
      playFX(scripts\engine\utility::getfx("sentry_shock_explosion"), var_08);
      if(var_0D.size > 0) {
        foreach(var_0F in var_0D) {
          if(var_0F.player != var_02) {
            var_0F.player dodamage(5, var_08, self.triggerportableradarping, self, var_06, var_07);
            var_10 = undefined;
            var_11 = undefined;
            if(var_0F.visiblelocations.size > 1) {
              var_11 = randomint(var_0F.visiblelocations.size);
              var_10 = var_0F.visiblelocations[var_11];
            } else {
              var_10 = var_0F.visiblelocations[0];
            }

            playfxbetweenpoints(scripts\engine\utility::getfx("sentry_shock_arc"), var_08, vectortoangles(var_10 - var_08), var_10);
          }
        }
      }
    }
  }
}

allowweaponsforsentry(param_00) {
  if(param_00) {
    scripts\engine\utility::allow_weapon(1);
    thread scripts\mp\supers::unstowsuperweapon();
    return;
  }

  thread scripts\mp\supers::allowsuperweaponstow();
  scripts\engine\utility::allow_weapon(0);
}

placehinton() {
  var_00 = self.sentrytype;
  if(var_00 == "super_trophy") {
    self.triggerportableradarping forceusehinton( & "LUA_MENU_MP_PLACE_SUPER_TROPHY");
    return;
  }

  self.triggerportableradarping forceusehinton( & "SENTRY_PLACE");
}

cannotplacehinton() {
  var_00 = self.sentrytype;
  if(var_00 == "super_trophy") {
    self.triggerportableradarping forceusehinton( & "LUA_MENU_MP_CANNOT_PLACE_SUPER_TROPHY");
    return;
  }

  self.triggerportableradarping forceusehinton( & "SENTRY_CANNOT_PLACE");
}