/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\killstreaks\autosentry.gsc
*************************************************/

init() {
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
  level.sentrysettings["sentry_shock"].hintstring = &"SENTRY/PICKUP";
  level.sentrysettings["sentry_shock"].headicon = 1;
  level.sentrysettings["sentry_shock"].teamsplash = "used_shock_sentry";
  level.sentrysettings["sentry_shock"].destroyedsplash = "callout_destroyed_sentry_shock";
  level.sentrysettings["sentry_shock"].shouldsplash = 1;
  level.sentrysettings["sentry_shock"].votimeout = "sentry_gun_teamleader_crash";
  level.sentrysettings["sentry_shock"].vodestroyed = "sentry_gun_teamleader_crash";
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

tryuseautosentry(lifeid, streakname) {
  result = givesentry("sentry_minigun");

  if(result)
    scripts\common\utility::trycall(level.matchdata_logkillstreakevent, level.sentrysettings["sentry_minigun"].streakname, self.origin);

  return result;
}

tryusesam(lifeid, streakname) {
  result = givesentry("sam_turret");

  if(result)
    scripts\common\utility::trycall(level.matchdata_logkillstreakevent, level.sentrysettings["sam_turret"].streakname, self.origin);

  return result;
}

tryuseshocksentry(streakinfo) {
  result = givesentry("sentry_shock", undefined, streakinfo);

  if(result)
    scripts\common\utility::trycall(level.matchdata_logkillstreakevent, streakinfo.streakname, self.origin);
  else
    waitframe();

  return result;
}

tryusemanualturret(streakinfo) {
  result = givesentry("manual_turret", undefined, streakinfo);

  if(result)
    scripts\common\utility::trycall(level.matchdata_logkillstreakevent, streakinfo.streakname, self.origin);
  else
    waitframe();

  return result;
}

givesentry(sentrytype, _id_7FF7EF0188F9B7EF, streakinfo) {
  self.last_sentry = sentrytype;

  if(!isDefined(self.placedsentries))
    self.placedsentries = [];

  if(!isDefined(self.placedsentries[sentrytype]))
    self.placedsentries[sentrytype] = [];

  _id_508482F603C6293E = 1;

  if(isDefined(_id_7FF7EF0188F9B7EF))
    _id_508482F603C6293E = _id_7FF7EF0188F9B7EF;

  sentrygun = createsentryforplayer(sentrytype, self, _id_508482F603C6293E, streakinfo);

  if(isDefined(streakinfo))
    streakinfo.sentrygun = sentrygun;

  removeperks();
  self.carriedsentry = sentrygun;
  result = setcarryingsentry(sentrygun, 1, _id_508482F603C6293E);
  self.carriedsentry = undefined;
  thread waitrestoreperks();
  self.iscarrying = 0;

  if(isDefined(sentrygun))
    return 1;
  else
    return 0;
}

setcarryingsentry(sentrygun, _id_3A565847D875F3EC, _id_508482F603C6293E, _id_593F001FD97E03B8) {
  self endon("death_or_disconnect");
  sentrygun sentry_setcarried(self, _id_508482F603C6293E, _id_593F001FD97E03B8);
  _id_3B64EB40368C1450::set("sentry", "usability", 0);
  _id_3B64EB40368C1450::set("sentry", "melee", 0);
  allowweaponsforsentry(0);

  if(!isai(self)) {
    self notifyonplayercommand("place_sentry", "+attack");
    self notifyonplayercommand("place_sentry", "+attack_akimbo_accessible");
    self notifyonplayercommand("cancel_sentry", "+actionslot 4");

    if(!self isconsoleplayer()) {
      self notifyonplayercommand("cancel_sentry", "+actionslot 5");
      self notifyonplayercommand("cancel_sentry", "+actionslot 6");
      self notifyonplayercommand("cancel_sentry", "+actionslot 7");
    }
  }

  for(;;) {
    result = scripts\engine\utility::waittill_any_return_4("place_sentry", "cancel_sentry", "force_cancel_placement", "emp_applied");

    if(!isDefined(sentrygun)) {
      allowweaponsforsentry(1);
      thread enablemeleeforsentry();
      return 1;
    }

    if(result == "cancel_sentry" || result == "force_cancel_placement" || result == "emp_applied") {
      if(!_id_3A565847D875F3EC && (result == "cancel_sentry" || result == "emp_applied")) {
        continue;
      }
      sentrygun sentry_setcancelled(result == "force_cancel_placement" && !isDefined(sentrygun.firstplacement));
      return 0;
    }

    if(!sentrygun.canbeplaced) {
      continue;
    }
    sentrygun sentry_setplaced(_id_508482F603C6293E);
    return 1;
  }
}

enablemeleeforsentry() {
  self endon("death_or_disconnect");
  wait 0.25;
  _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("sentry");
}

removeweapons() {
  if(self hasweapon("iw6_riotshield_mp")) {
    self.restoreweapon = "iw6_riotshield_mp";
    scripts\cp_mp\utility\inventory_utility::_takeweapon("iw6_riotshield_mp");
  }
}

removeperks() {
  if(scripts\mp\utility\perk::_hasperk("specialty_explosivebullets")) {
    self.restoreperk = "specialty_explosivebullets";
    scripts\mp\utility\perk::removeperk("specialty_explosivebullets");
  }
}

restoreweapons() {
  if(isDefined(self.restoreweapon)) {
    scripts\cp_mp\utility\inventory_utility::_giveweapon(self.restoreweapon);
    self.restoreweapon = undefined;
  }
}

restoreperks() {
  if(isDefined(self.restoreperk)) {
    scripts\mp\utility\perk::giveperk(self.restoreperk);
    self.restoreperk = undefined;
  }
}

waitrestoreperks() {
  self endon("death_or_disconnect");
  level endon("game_ended");
  waitframe();
  restoreperks();
}

createsentryforplayer(sentrytype, owner, _id_508482F603C6293E, streakinfo) {
  _id_A74853F29ED4EEAE = level.sentrysettings[sentrytype].weaponinfo;
  sentrygun = spawnturret("misc_turret", owner.origin, _id_A74853F29ED4EEAE);
  sentrygun.angles = owner.angles;
  sentrygun.streakinfo = streakinfo;
  sentrygun sentry_initsentry(sentrytype, owner, _id_508482F603C6293E);
  sentrygun thread sentry_destroyongameend();
  sentrygun scripts\cp_mp\emp_debuff::allow_emp(0);
  sentrygun scripts\cp_mp\emp_debuff::set_start_emp_callback(::sentry_empstarted);
  sentrygun scripts\cp_mp\emp_debuff::set_clear_emp_callback(::sentry_empcleared);
  return sentrygun;
}

sentry_initsentry(sentrytype, owner, _id_508482F603C6293E, timeout) {
  if(!isDefined(timeout))
    timeout = 1;

  self.sentrytype = sentrytype;
  self.canbeplaced = 1;
  self setModel(level.sentrysettings[sentrytype].modelbase);
  self setnodeploy(1);

  if(level.sentrysettings[sentrytype].shouldsplash)
    self.shouldsplash = 1;
  else
    self.shouldsplash = 0;

  self.firstplacement = 1;
  self setCanDamage(1);

  switch (sentrytype) {
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
      self setdefaultdroppitch(0.0);
      self.originalowner = owner;
      break;
    case "scramble_turret":
    case "sam_turret":
      self maketurretinoperable();
      self setleftarc(180);
      self setrightarc(180);
      self settoparc(80);
      self setdefaultdroppitch(-89.0);
      self.laser_on = 0;
      killcament = spawn("script_model", self gettagorigin("tag_laser"));
      killcament linkTo(self);
      self.killcament = killcament;
      self.killcament setscriptmoverkillcam("explosive");
      break;
    case "sentry_shock":
      self maketurretinoperable();
      _id_0D3DC97C59992D51 = anglesToForward(self.angles);
      _id_A8AE5E047A5B6CB6 = self gettagorigin("tag_laser") + (0, 0, 10);
      _id_A8AE5E047A5B6CB6 = _id_A8AE5E047A5B6CB6 - _id_0D3DC97C59992D51 * 20;
      killcament = spawn("script_model", _id_A8AE5E047A5B6CB6);
      killcament linkTo(self);
      self.killcament = killcament;
      break;
    case "manual_turret":
      _id_0D3DC97C59992D51 = anglesToForward(self.angles);
      _id_A8AE5E047A5B6CB6 = self gettagorigin("tag_laser") + (0, 0, 10);
      _id_A8AE5E047A5B6CB6 = _id_A8AE5E047A5B6CB6 - _id_0D3DC97C59992D51 * 20;
      killcament = spawn("script_model", _id_A8AE5E047A5B6CB6);
      killcament linkTo(self);
      self.killcament = killcament;
      break;
    default:
      self maketurretinoperable();
      self setdefaultdroppitch(-89.0);
      break;
  }

  self setturretmodechangewait(1);
  sentry_setinactive();
  sentry_setowner(owner);

  if(timeout)
    thread sentry_timeout();

  switch (sentrytype) {
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
    case "sentry_shock":
    case "sam_turret":
      self.momentum = 0;
      thread sentry_handleuse(_id_508482F603C6293E);
      thread sentry_beepsounds();
      break;
    case "manual_turret":
      self.momentum = 0;
      thread sentry_handlemanualuse();
      thread sentry_handlealteratepickup(_id_508482F603C6293E);
      break;
    case "super_trophy":
      thread sentry_handleuse(0);
      thread sentry_beepsounds();
      break;
    default:
      thread sentry_handleuse(_id_508482F603C6293E);
      thread sentry_attacktargets();
      thread sentry_beepsounds();
      break;
  }
}

sentry_setteamheadicon() {
  headiconoffset = level.sentrysettings[self.sentrytype].headiconoffset;

  if(!isDefined(headiconoffset)) {
    return;
  }
  if(!isDefined(self.owner)) {
    return;
  }
  owner = self.owner;
  team = owner.team;
  self.headiconid = thread scripts\cp_mp\entityheadicons::setheadicon_factionimage(0, headiconoffset, undefined, undefined, undefined, undefined, 1);
}

sentry_clearteamheadicon() {
  headiconoffset = level.sentrysettings[self.sentrytype].headiconoffset;

  if(!isDefined(headiconoffset)) {
    return;
  }
  scripts\cp_mp\entityheadicons::setheadicon_deleteicon(self.headiconid);
}

sentry_destroyongameend() {
  self endon("death");
  level scripts\engine\utility::waittill_any_2("bro_shot_start", "game_ended");
  self notify("death");
}

sentry_handledamage() {
  self endon("carried");
  maxhealth = level.sentrysettings[self.sentrytype].maxhealth;
  _id_4B9CD0374A51877C = 0;

  if(self.owner scripts\mp\utility\perk::_hasperk("specialty_rugged_eqp")) {
    weaponname = self.weapon_name;

    if(isDefined(weaponname)) {
      switch (weaponname) {
        default:
      }
    }
  }

  maxhealth = maxhealth + int(_id_4B9CD0374A51877C);
  scripts\mp\damage::monitordamage(maxhealth, "sentry", ::sentryhandledeathdamage, ::sentrymodifydamage, 1);
}

sentrymodifydamage(data) {
  attacker = data.attacker;
  objweapon = data.objweapon;
  type = data.meansofdeath;
  damage = data.damage;
  idflags = data.idflags;
  _id_702BFC08FABD86CB = damage;

  if(type == "MOD_MELEE")
    _id_702BFC08FABD86CB = self.maxhealth * 0.34;

  _id_702BFC08FABD86CB = scripts\mp\utility\killstreak::getmodifiedantikillstreakdamage(attacker, objweapon, type, _id_702BFC08FABD86CB, self.maxhealth, 2, 3, 4);
  return _id_702BFC08FABD86CB;
}

sentryhandledeathdamage(data) {
  attacker = data.attacker;
  objweapon = data.objweapon;
  type = data.meansofdeath;
  damage = data.damage;
  idflags = data.idflags;
  config = level.sentrysettings[self.sentrytype];

  if(config.iskillstreak) {
    _id_3737240CEFE2C793 = scripts\mp\damage::onkillstreakkilled(config.streakname, attacker, objweapon, type, damage, config.scorepopup, config.vodestroyed, config.destroyedsplash);

    if(_id_3737240CEFE2C793) {
      attacker notify("destroyed_equipment");
      return;
    }
  } else {
    _id_2D113E958C753976 = undefined;
    _id_43DBEB17E356BBB0 = attacker;

    if(isDefined(_id_43DBEB17E356BBB0) && isDefined(self.owner)) {
      if(isDefined(attacker.owner) && isPlayer(attacker.owner))
        _id_43DBEB17E356BBB0 = attacker.owner;

      if(self.owner scripts\cp_mp\utility\player_utility::isenemy(_id_43DBEB17E356BBB0))
        _id_2D113E958C753976 = _id_43DBEB17E356BBB0;
    }

    if(isDefined(_id_2D113E958C753976)) {
      _id_2D113E958C753976 thread scripts\mp\events::supershutdown(self.owner);
      _id_2D113E958C753976 notify("destroyed_equipment");
    }

    self notify("death");
  }
}

sentry_empstarted(data) {
  self.disabled = 1;
  self setdefaultdroppitch(40);
  self setmode(level.sentrysettings[self.sentrytype].sentrymodeoff);
  self cleartargetentity();
  self setscriptablepartstate("muzzle", "neutral", 0);
  self setscriptablepartstate("stunned", "active");
}

sentry_empcleared(_id_B3990D56E2779F79) {
  if(_id_B3990D56E2779F79) {
    return;
  }
  self setdefaultdroppitch(-89.0);
  self setmode(level.sentrysettings[self.sentrytype].sentrymodeon);
  self setscriptablepartstate("stunned", "neutral");
  self.disabled = undefined;
}

sentry_handledeath() {
  self endon("carried");
  self waittill("death");

  if(isDefined(self.owner))
    self.owner.placedsentries[self.sentrytype] = scripts\engine\utility::array_remove(self.owner.placedsentries[self.sentrytype], self);

  if(!isDefined(self)) {
    return;
  }
  self cleartargetentity();
  self laseroff();
  self setModel(level.sentrysettings[self.sentrytype].modeldestroyed);

  if(isDefined(self.fxentdeletelist) && self.fxentdeletelist.size > 0) {
    foreach(fxent in self.fxentdeletelist) {
      if(isDefined(fxent))
        fxent delete();
    }

    self.fxentdeletelist = undefined;
  }

  sentry_setinactive();
  self setdefaultdroppitch(40);
  self setsentryowner(undefined);

  if(isDefined(self.inuseby))
    self useby(self.inuseby);

  self setturretminimapvisible(0);

  if(isDefined(self.ownertrigger))
    self.ownertrigger delete();

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

  if(isDefined(self.killcament))
    self.killcament delete();

  if(isDefined(self.airlookatent))
    self.airlookatent delete();

  if(isDefined(self.manualpickuptrigger))
    self.manualpickuptrigger delete();

  scripts\mp\utility\print::printgameaction("killstreak ended - shock_sentry", self.owner);
  self delete();
}

sentry_handleuse(_id_508482F603C6293E) {
  self endon("death");
  level endon("game_ended");

  for(;;) {
    self waittill("trigger", player);

    if(!scripts\mp\utility\player::isreallyalive(player)) {
      continue;
    }
    if(self.sentrytype == "sam_turret" || self.sentrytype == "scramble_turret")
      self setmode(level.sentrysettings[self.sentrytype].sentrymodeoff);

    player.placedsentries[self.sentrytype] = scripts\engine\utility::array_remove(player.placedsentries[self.sentrytype], self);
    player setcarryingsentry(self, 0, _id_508482F603C6293E);
  }
}

turret_handlepickup(turret) {
  self endon("disconnect");
  level endon("game_ended");
  turret endon("death");

  if(!isDefined(turret.ownertrigger)) {
    return;
  }
  _id_8B07FA3892A3A8A4 = 0;

  for(;;) {
    if(isalive(self) && self istouching(turret.ownertrigger) && !isDefined(turret.inuseby) && !isDefined(turret.carriedby) && self isonground()) {
      if(self useButtonPressed()) {
        _id_8B07FA3892A3A8A4 = 0;

        while(self useButtonPressed()) {
          _id_8B07FA3892A3A8A4 = _id_8B07FA3892A3A8A4 + level.framedurationseconds;
          waitframe();
        }

        if(_id_8B07FA3892A3A8A4 >= 0.5) {
          continue;
        }
        _id_8B07FA3892A3A8A4 = 0;

        while(!self useButtonPressed() && _id_8B07FA3892A3A8A4 < 0.5) {
          _id_8B07FA3892A3A8A4 = _id_8B07FA3892A3A8A4 + level.framedurationseconds;
          waitframe();
        }

        if(_id_8B07FA3892A3A8A4 >= 0.5) {
          continue;
        }
        if(!scripts\mp\utility\player::isreallyalive(self)) {
          continue;
        }
        turret setmode(level.sentrysettings[turret.sentrytype].sentrymodeoff);
        thread setcarryingsentry(turret, 0);
        turret.ownertrigger delete();
        return;
      }
    }

    waitframe();
  }
}

turret_handleuse() {
  self notify("turret_handluse");
  self endon("turret_handleuse");
  self endon("deleting");
  level endon("game_ended");
  self.forcedisable = 0;
  _id_B1DFDF129250E6FF = (1, 0.9, 0.7);
  _id_541DA7CF90E97010 = (1, 0.65, 0);
  _id_E96EC83C82048EE1 = (1, 0.25, 0);

  for(;;) {
    self waittill("trigger", player);

    if(isDefined(self.carriedby)) {
      continue;
    }
    if(isDefined(self.inuseby)) {
      continue;
    }
    if(!scripts\mp\utility\player::isreallyalive(player)) {
      continue;
    }
    player removeperks();
    player removeweapons();
    self.inuseby = player;
    self setmode(level.sentrysettings[self.sentrytype].sentrymodeoff);
    sentry_setowner(player);
    self setmode(level.sentrysettings[self.sentrytype].sentrymodeon);
    player thread turret_shotmonitor(self);
    player.turret_overheat_bar = player scripts\mp\hud_util::createbar(_id_B1DFDF129250E6FF, 100, 6);
    player.turret_overheat_bar scripts\mp\hud_util::setpoint("CENTER", "BOTTOM", 0, -70);
    player.turret_overheat_bar.alpha = 0.65;
    player.turret_overheat_bar.bar.alpha = 0.65;
    _id_5FB0C5A6344C28A9 = 0;

    for(;;) {
      if(!scripts\mp\utility\player::isreallyalive(player)) {
        self.inuseby = undefined;
        player.turret_overheat_bar scripts\mp\hud_util::destroyelem();
        break;
      }

      if(!player isusingturret()) {
        self notify("player_dismount");
        self.inuseby = undefined;
        player.turret_overheat_bar scripts\mp\hud_util::destroyelem();
        player restoreperks();
        player restoreweapons();
        self setHintString(level.sentrysettings[self.sentrytype].hintstring);
        self setmode(level.sentrysettings[self.sentrytype].sentrymodeoff);
        sentry_setowner(self.originalowner);
        self setmode(level.sentrysettings[self.sentrytype].sentrymodeon);
        break;
      }

      if(self.heatlevel >= level.sentrysettings[self.sentrytype].overheattime)
        _id_144981CC6EB4B07A = 1;
      else
        _id_144981CC6EB4B07A = self.heatlevel / level.sentrysettings[self.sentrytype].overheattime;

      player.turret_overheat_bar scripts\mp\hud_util::updatebar(_id_144981CC6EB4B07A);

      if(scripts\engine\utility::string_starts_with(self.sentrytype, "minigun_turret"))
        _id_87B4320AC60C4223 = "minigun_turret";

      if(self.forcedisable || self.overheated) {
        self turretfiredisable();
        player.turret_overheat_bar.bar.color = _id_E96EC83C82048EE1;
        _id_5FB0C5A6344C28A9 = 0;
      } else if(self.heatlevel > level.sentrysettings[self.sentrytype].overheattime * 0.75 && scripts\engine\utility::string_starts_with(self.sentrytype, "minigun_turret")) {
        player.turret_overheat_bar.bar.color = _id_541DA7CF90E97010;

        if(randomintrange(0, 10) < 6)
          self turretfireenable();
        else
          self turretfiredisable();

        if(!_id_5FB0C5A6344C28A9) {
          _id_5FB0C5A6344C28A9 = 1;
          thread playheatfx();
        }
      } else {
        player.turret_overheat_bar.bar.color = _id_B1DFDF129250E6FF;
        self turretfireenable();
        _id_5FB0C5A6344C28A9 = 0;
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
  childthread sentry_watchownerstatus("disconnect");
  childthread sentry_watchownerstatus("joined_team");
  childthread sentry_watchownerstatus("joined_spectators");
}

sentry_watchownerstatus(_id_70687E0CC558A009) {
  self.owner waittill(_id_70687E0CC558A009);
  self notify("death");
}

sentry_setowner(owner) {
  self.owner = owner;
  self setsentryowner(self.owner);
  self setturretminimapvisible(1, self.sentrytype);

  if(level.teambased) {
    self.team = self.owner.team;
    self setturretteam(self.team);
  }

  thread sentry_handleownerdisconnect();
}

sentry_moving_platform_death(data) {
  self notify("death");
}

sentry_setplaced(_id_508482F603C6293E) {
  if(isDefined(self.owner)) {
    _id_BE6E776392E3983D = self.owner.placedsentries[self.sentrytype].size;
    self.owner.placedsentries[self.sentrytype][_id_BE6E776392E3983D] = self;

    if(_id_BE6E776392E3983D + 1 > 2)
      self.owner.placedsentries[self.sentrytype][0] notify("death");

    self.owner allowweaponsforsentry(1);
    self.owner thread enablemeleeforsentry();
    self.owner enableworldup(1);
  }

  self setModel(level.sentrysettings[self.sentrytype].modelbase);

  if(self getmode() == "manual")
    self setmode(level.sentrysettings[self.sentrytype].sentrymodeoff);

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
      if(_id_508482F603C6293E) {
        self.angles = self.carriedby.angles;

        if(isalive(self.originalowner))
          self.originalowner scripts\mp\utility\lower_message::setlowermessage("pickup_hint", level.sentrysettings[self.sentrytype].ownerhintstring, 3.0, undefined, undefined, undefined, undefined, undefined, 1);

        self.ownertrigger = spawn("trigger_radius", self.origin + (0, 0, 1), 0, 105, 64);
        self.ownertrigger enablelinkTo();
        self.ownertrigger linkTo(self);
        self.originalowner thread turret_handlepickup(self);
        thread turret_handleuse();
      }

      break;
    case "manual_turret":
      self setdefaultdroppitch(30.0);
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

  sentry_setactive(_id_508482F603C6293E);
  data = spawnStruct();

  if(isDefined(self.moving_platform))
    data.linkparent = self.moving_platform;

  data.endonstring = "carried";
  data.deathoverridecallback = ::sentry_moving_platform_death;
  thread scripts\mp\movers::handle_moving_platforms(data);

  if(self.sentrytype != "multiturret")
    self playSound("sentry_gun_plant");

  self notify("placed");
}

sentry_setcancelled(_id_DDD5B75D0CD367C5) {
  if(isDefined(self.carriedby)) {
    owner = self.carriedby;
    owner forceusehintoff();
    owner.iscarrying = undefined;
    owner.carrieditem = undefined;
    owner allowweaponsforsentry(1);
    owner thread enablemeleeforsentry();
    owner enableworldup(1);

    if(isDefined(self.bombsquadmodel))
      self.bombsquadmodel delete();
  }

  if(isDefined(_id_DDD5B75D0CD367C5) && _id_DDD5B75D0CD367C5)
    scripts\mp\weapons::equipmentdeletevfx();

  self delete();
}

sentry_setcarried(carrier, _id_508482F603C6293E, _id_593F001FD97E03B8) {
  if(isDefined(self.originalowner)) {} else {}

  if(self.sentrytype == "sentry_shock")
    self setscriptablepartstate("muzzle", "neutral", 0);

  self setModel(level.sentrysettings[self.sentrytype].modelgood);
  self setsentrycarrier(carrier);
  self setCanDamage(0);
  sentry_makenotsolid();
  carrier enableworldup(0);
  self.carriedby = carrier;
  carrier.iscarrying = 1;
  self.pickupenabled = _id_508482F603C6293E;
  thread sentry_oncarrierdeathoremp(carrier, _id_593F001FD97E03B8);
  carrier thread updatesentryplacement(self);
  thread sentry_oncarrierdisconnect(carrier);
  thread sentry_oncarrierchangedteam(carrier);
  thread sentry_ongameended();
  scripts\cp_mp\emp_debuff::allow_emp(0);
  self setdefaultdroppitch(-89.0);
  sentry_setinactive();

  if(isDefined(self getlinkedparent()))
    self unlink();

  self notify("carried");

  if(isDefined(self.bombsquadmodel))
    self.bombsquadmodel hide();
}

updatesentryplacement(sentrygun) {
  self endon("death_or_disconnect");
  level endon("game_ended");
  sentrygun endon("placed");
  sentrygun endon("death");
  sentrygun.canbeplaced = 1;
  _id_A0C968FD72A36B5B = -1;

  for(;;) {
    placement = self canplayerplacesentry(1, 40);
    sentrygun.origin = placement["origin"];
    sentrygun.angles = placement["angles"];
    _id_8509066F54F7C75A = scripts\engine\utility::array_combine(level.turrets, level.microturrets, level.supertrophy.trophies, level.mines);
    _id_3B23C52FF5BBD6C7 = sentrygun getistouchingentities(_id_8509066F54F7C75A);
    sentrygun.canbeplaced = self isonground() && placement["result"] && abs(sentrygun.origin[2] - self.origin[2]) < 30 && !scripts\mp\utility\entity::istouchingboundstrigger(self) && _id_3B23C52FF5BBD6C7.size == 0;

    if(isDefined(placement["entity"]))
      sentrygun.moving_platform = placement["entity"];
    else
      sentrygun.moving_platform = undefined;

    if(sentrygun.canbeplaced != _id_A0C968FD72A36B5B) {
      if(sentrygun.canbeplaced) {
        sentrygun setModel(level.sentrysettings[sentrygun.sentrytype].modelgood);
        sentrygun placehinton();
      } else {
        sentrygun setModel(level.sentrysettings[sentrygun.sentrytype].modelbad);
        sentrygun cannotplacehinton();
      }
    }

    _id_A0C968FD72A36B5B = sentrygun.canbeplaced;
    wait 0.05;
  }
}

sentry_oncarrierdeathoremp(carrier, _id_593F001FD97E03B8) {
  self endon("placed");
  self endon("death");
  carrier endon("disconnect");
  carrier scripts\engine\utility::waittill_any_2("death", "emp_applied");

  if(self.canbeplaced && !istrue(_id_593F001FD97E03B8))
    sentry_setplaced(self.pickupenabled);
  else
    sentry_setcancelled(0);
}

sentry_oncarrierdisconnect(carrier) {
  self endon("placed");
  self endon("death");
  carrier waittill("disconnect");
  self delete();
}

sentry_oncarrierchangedteam(carrier) {
  self endon("placed");
  self endon("death");
  carrier scripts\engine\utility::waittill_any_2("joined_team", "joined_spectators");
  self delete();
}

sentry_ongameended(carrier) {
  self endon("placed");
  self endon("death");
  level waittill("game_ended");
  self delete();
}

sentry_setactive(_id_508482F603C6293E) {
  self setmode(level.sentrysettings[self.sentrytype].sentrymodeon);

  if(_id_508482F603C6293E) {
    self setCursorHint("HINT_NOICON");
    self setHintString(level.sentrysettings[self.sentrytype].hintstring);
    self makeusable();
  }

  foreach(player in level.players) {
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
        if(_id_508482F603C6293E)
          self enableplayeruse(player);

        break;
      default:
        scripts\mp\utility\killstreak::addtoactivekillstreaklist(self.sentrytype, "Killstreak_Ground", self.owner, 0, 1, 70, "carried");

        if(player == self.owner && _id_508482F603C6293E)
          self enableplayeruse(player);
        else
          self disableplayeruse(player);

        break;
    }
  }

  splashname = level.sentrysettings[self.sentrytype].teamsplash;

  if(self.shouldsplash) {
    level thread scripts\mp\hud_util::teamplayercardsplash(splashname, self.owner);
    self.shouldsplash = 0;
  }

  if(self.sentrytype == "sam_turret")
    thread sam_attacktargets();

  if(self.sentrytype == "scramble_turret")
    thread scrambleturretattacktargets();

  if(self.sentrytype == "sentry_shock")
    thread sentryshocktargets();

  scripts\cp_mp\emp_debuff::allow_emp(1);
}

sentry_setinactive() {
  if(self.sentrytype == "manual_turret") {
    self setHintString("");
    self makeunusable();
  }

  self setmode(level.sentrysettings[self.sentrytype].sentrymodeoff);
  self makeunusable();
}

sentry_makesolid() {
  self solid();
}

sentry_makenotsolid() {
  self notsolid();
}

isfriendlytosentry(sentrygun) {
  if(level.teambased && self.team == sentrygun.team)
    return 1;

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

    if(self isfiringturret()) {
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
  lifespan = level.sentrysettings[self.sentrytype].timeout;

  if(isDefined(lifespan) && lifespan == 0) {
    return;
  }
  while(lifespan) {
    wait 1.0;
    scripts\mp\hostmigration::waittillhostmigrationdone();

    if(!isDefined(self.carriedby))
      lifespan = max(0, lifespan - 1.0);
  }

  if(isDefined(self.owner)) {
    if(isDefined(level.sentrysettings[self.sentrytype].votimeout))
      self.owner scripts\cp_mp\utility\killstreak_utility::_id_08959C1606F65E65(self.streakinfo.streakname, level.sentrysettings[self.sentrytype].votimeout);
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
  firetime = weaponfiretime(level.sentrysettings[self.sentrytype].weaponinfo);
  _id_3746EC1BEFD86AE8 = level.sentrysettings[self.sentrytype].burstmin;
  _id_3E92CD336A99CE02 = level.sentrysettings[self.sentrytype].burstmax;

  if(isDefined(self.supportturret) && self.supportturret) {
    firetime = 0.05;
    _id_89F949A75D92E1A4 = 50;
  } else {
    firetime = 0.5 / (self.listoffoundturrets.size + 1);
    _id_89F949A75D92E1A4 = _id_3746EC1BEFD86AE8;
  }

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_89F949A75D92E1A4; _id_AC0E594AC96AA3A8++) {
    turrettarget = self getturrettarget(1);

    if(!isDefined(turrettarget)) {
      break;
    }

    self shootturret();
    wait(firetime);
  }

  self notify("doneFiring");
  self cleartargetentity();
}

sentry_burstfirestart() {
  self endon("death");
  self endon("stop_shooting");
  level endon("game_ended");
  sentry_spinup();
  firetime = weaponfiretime(level.sentrysettings[self.sentrytype].weaponinfo);
  _id_3746EC1BEFD86AE8 = level.sentrysettings[self.sentrytype].burstmin;
  _id_3E92CD336A99CE02 = level.sentrysettings[self.sentrytype].burstmax;
  _id_5F622C39D6661B23 = level.sentrysettings[self.sentrytype].pausemin;
  _id_42AE243CD994C3BD = level.sentrysettings[self.sentrytype].pausemax;

  for(;;) {
    _id_89F949A75D92E1A4 = randomintrange(_id_3746EC1BEFD86AE8, _id_3E92CD336A99CE02 + 1);

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_89F949A75D92E1A4 && !self.overheated; _id_AC0E594AC96AA3A8++) {
      self shootturret();
      self notify("bullet_fired");
      self.heatlevel = self.heatlevel + firetime;
      wait(firetime);
    }

    wait(randomfloatrange(_id_5F622C39D6661B23, _id_42AE243CD994C3BD));
  }
}

sentry_burstfirestop() {
  self notify("stop_shooting");
}

turret_shotmonitor(turret) {
  self endon("death_or_disconnect");
  level endon("game_ended");
  turret endon("death");
  turret endon("player_dismount");
  firetime = weaponfiretime(level.sentrysettings[turret.sentrytype].weaponinfo);

  for(;;) {
    turret waittill("turret_fire");
    turret.heatlevel = turret.heatlevel + firetime;
    turret.cooldownwaittime = firetime;
  }
}

sentry_heatmonitor() {
  self endon("death");
  firetime = weaponfiretime(level.sentrysettings[self.sentrytype].weaponinfo);
  _id_C81D1AE9575CD803 = 0;
  _id_06D613D4ED09F7CA = 0;
  overheattime = level.sentrysettings[self.sentrytype].overheattime;
  overheatcooldown = level.sentrysettings[self.sentrytype].cooldowntime;

  for(;;) {
    if(self.heatlevel != _id_C81D1AE9575CD803)
      wait(firetime);
    else
      self.heatlevel = max(0, self.heatlevel - 0.05);

    if(self.heatlevel > overheattime) {
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
        self.heatlevel = max(0, self.heatlevel - overheatcooldown);
        wait 0.1;
      }

      self.overheated = 0;
      self notify("not_overheated");
    }

    _id_C81D1AE9575CD803 = self.heatlevel;
    wait 0.05;
  }
}

turret_heatmonitor() {
  self endon("death");
  overheattime = level.sentrysettings[self.sentrytype].overheattime;

  for(;;) {
    if(self.heatlevel > overheattime) {
      self.overheated = 1;
      thread playheatfx();

      switch (self.sentrytype) {
        case "gl_turret":
          playFXOnTag(scripts\engine\utility::getfx("sentry_smoke_mp"), self, "tag_aim");
          break;
        default:
          break;
      }

      while(self.heatlevel)
        wait 0.1;

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
      if(self.cooldownwaittime <= 0)
        self.heatlevel = max(0, self.heatlevel - 0.05);
      else
        self.cooldownwaittime = max(0, self.cooldownwaittime - 0.05);
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

    if(!isDefined(self.carriedby))
      self playSound("sentry_gun_beep");
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
  _id_446576956FC59F64 = self gettagorigin("tag_laser");

  if(!isDefined(self.samtargetent)) {
    if(level.teambased) {
      _id_DCB5FD0CC07E40A2 = [];
      _id_B0C33D224B825287 = scripts\mp\utility\teams::getenemyteams(self.team);

      foreach(_id_F90358454413407F in _id_B0C33D224B825287) {
        foreach(uav in level.uavmodels[_id_F90358454413407F])
        _id_DCB5FD0CC07E40A2[_id_DCB5FD0CC07E40A2.size] = uav;
      }

      foreach(uav in _id_DCB5FD0CC07E40A2) {
        if(isDefined(uav.isleaving) && uav.isleaving) {
          continue;
        }
        if(sighttracepassed(_id_446576956FC59F64, uav.origin, 0, self))
          return uav;
      }

      foreach(_id_CE482378F59E5B3F in level.littlebirds) {
        if(isDefined(_id_CE482378F59E5B3F.team) && _id_CE482378F59E5B3F.team == self.team) {
          continue;
        }
        if(sighttracepassed(_id_446576956FC59F64, _id_CE482378F59E5B3F.origin, 0, self))
          return _id_CE482378F59E5B3F;
      }

      foreach(heli in level.helis) {
        if(isDefined(heli.team) && heli.team == self.team) {
          continue;
        }
        if(sighttracepassed(_id_446576956FC59F64, heli.origin, 0, self))
          return heli;
      }

      foreach(uav in level.remote_uav) {
        if(!isDefined(uav)) {
          continue;
        }
        if(isDefined(uav.team) && uav.team == self.team) {
          continue;
        }
        if(sighttracepassed(_id_446576956FC59F64, uav.origin, 0, self, uav))
          return uav;
      }
    } else {
      foreach(uav in level.uavmodels) {
        if(isDefined(uav.isleaving) && uav.isleaving) {
          continue;
        }
        if(isDefined(uav.owner) && isDefined(self.owner) && uav.owner == self.owner) {
          continue;
        }
        if(sighttracepassed(_id_446576956FC59F64, uav.origin, 0, self))
          return uav;
      }

      foreach(_id_CE482378F59E5B3F in level.littlebirds) {
        if(isDefined(_id_CE482378F59E5B3F.owner) && isDefined(self.owner) && _id_CE482378F59E5B3F.owner == self.owner) {
          continue;
        }
        if(sighttracepassed(_id_446576956FC59F64, _id_CE482378F59E5B3F.origin, 0, self))
          return _id_CE482378F59E5B3F;
      }

      foreach(heli in level.helis) {
        if(isDefined(heli.owner) && isDefined(self.owner) && heli.owner == self.owner) {
          continue;
        }
        if(sighttracepassed(_id_446576956FC59F64, heli.origin, 0, self))
          return heli;
      }

      foreach(uav in level.remote_uav) {
        if(!isDefined(uav)) {
          continue;
        }
        if(isDefined(uav.owner) && isDefined(self.owner) && uav.owner == self.owner) {
          continue;
        }
        if(sighttracepassed(_id_446576956FC59F64, uav.origin, 0, self, uav))
          return uav;
      }
    }

    self cleartargetentity();
    return undefined;
  } else {
    if(!sighttracepassed(_id_446576956FC59F64, self.samtargetent.origin, 0, self)) {
      self cleartargetentity();
      return undefined;
    }

    return self.samtargetent;
  }
}

sam_fireontarget() {
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

    wait 2.0;

    if(!isDefined(self.samtargetent)) {
      return;
    }
    if(self.samtargetent == level.gunship.planemodel && !isDefined(level.gunshipplayer)) {
      self.samtargetent = undefined;
      self cleartargetentity();
      return;
    }

    _id_B3CD0252C480A4AF = [];
    _id_B3CD0252C480A4AF[0] = self gettagorigin("tag_le_missile1");
    _id_B3CD0252C480A4AF[1] = self gettagorigin("tag_le_missile2");
    _id_B3CD0252C480A4AF[2] = self gettagorigin("tag_ri_missile1");
    _id_B3CD0252C480A4AF[3] = self gettagorigin("tag_ri_missile2");
    _id_A512AA80EA6BF396 = self.sammissilegroups.size;

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < 4; _id_AC0E594AC96AA3A8++) {
      if(!isDefined(self.samtargetent)) {
        return;
      }
      if(isDefined(self.carriedby)) {
        return;
      }
      self shootturret();
      rocket = scripts\cp_mp\utility\weapon_utility::_magicbullet(makeweapon("sam_projectile_mp"), _id_B3CD0252C480A4AF[_id_AC0E594AC96AA3A8], self.samtargetent.origin, self.owner);
      rocket missile_settargetEnt(self.samtargetent);
      rocket missile_setflightmodedirect();
      rocket.samturret = self;
      rocket.sammissilegroup = _id_A512AA80EA6BF396;
      self.sammissilegroups[_id_A512AA80EA6BF396][_id_AC0E594AC96AA3A8] = rocket;
      level notify("sam_missile_fired", self.owner, rocket, self.samtargetent);

      if(_id_AC0E594AC96AA3A8 == 3) {
        break;
      }

      wait 0.25;
    }

    level notify("sam_fired", self.owner, self.sammissilegroups[_id_A512AA80EA6BF396], self.samtargetent);
    wait 3.0;
  }
}

sam_watchlineofsight() {
  level endon("game_ended");
  self endon("death");

  while(isDefined(self.samtargetent) && isDefined(self getturrettarget(1)) && self getturrettarget(1) == self.samtargetent) {
    _id_446576956FC59F64 = self gettagorigin("tag_laser");

    if(!sighttracepassed(_id_446576956FC59F64, self.samtargetent.origin, 0, self, self.samtargetent)) {
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

  while(isDefined(self.samtargetent) && isDefined(self getturrettarget(1)) && self getturrettarget(1) == self.samtargetent)
    waitframe();

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

    if(isDefined(self.scrambletargetent) && isDefined(self.scrambletargetent.scrambled) && !self.scrambletargetent.scrambled)
      scrambletarget();

    wait 0.05;
  }
}

scramble_acquiretarget() {
  return sam_acquiretarget();
}

scrambletarget() {
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

    wait 2.0;

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
  }
}

setscrambled() {
  _id_45B8A1E894F0E1F3 = self.scrambletargetent;
  _id_45B8A1E894F0E1F3 notify("scramble_fired", self.owner);
  _id_45B8A1E894F0E1F3 endon("scramble_fired");
  _id_45B8A1E894F0E1F3 endon("death");
  _id_45B8A1E894F0E1F3 thread scripts\mp\killstreaks\helicopter::heli_targeting();
  _id_45B8A1E894F0E1F3.scrambled = 1;
  _id_45B8A1E894F0E1F3.secondowner = self.owner;
  _id_45B8A1E894F0E1F3 notify("findNewTarget");
  wait 30;

  if(isDefined(_id_45B8A1E894F0E1F3)) {
    _id_45B8A1E894F0E1F3.scrambled = 0;
    _id_45B8A1E894F0E1F3.secondowner = undefined;
    _id_45B8A1E894F0E1F3 thread scripts\mp\killstreaks\helicopter::heli_targeting();
  }
}

scramble_watchlineofsight() {
  level endon("game_ended");
  self endon("death");

  while(isDefined(self.scrambletargetent) && isDefined(self getturrettarget(1)) && self getturrettarget(1) == self.scrambletargetent) {
    _id_446576956FC59F64 = self gettagorigin("tag_laser");

    if(!sighttracepassed(_id_446576956FC59F64, self.scrambletargetent.origin, 0, self, self.scrambletargetent)) {
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

  while(isDefined(self.scrambletargetent) && isDefined(self getturrettarget(1)) && self getturrettarget(1) == self.scrambletargetent)
    wait 0.05;

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
  self.airlookatent linkTo(self, "tag_flash");

  for(;;) {
    result = scripts\engine\utility::waittill_any_timeout_1(1, "turret_on_target");

    if(result == "timeout") {
      continue;
    }
    self.sentryshocktargetent = self getturrettarget(1);

    if(isDefined(self.sentryshocktargetent) && scripts\mp\utility\player::isreallyalive(self.sentryshocktargetent)) {
      thread shocktarget(self.sentryshocktargetent);
      self waittill("done_firing");
    }
  }
}

searchforshocksentryairtarget() {
  if(isDefined(level.uavmodels)) {
    if(level.teambased) {
      _id_B0C33D224B825287 = scripts\mp\utility\teams::getenemyteams(self.owner.team);

      foreach(_id_F90358454413407F in _id_B0C33D224B825287) {
        foreach(uav in level.uavmodels[_id_F90358454413407F]) {
          if(targetvisibleinfront(uav))
            return uav;
        }
      }
    } else {
      foreach(uav in level.uavmodels) {
        if(uav.owner == self.owner) {
          continue;
        }
        if(targetvisibleinfront(uav))
          return uav;
      }
    }
  }

  if(isDefined(level.helis)) {
    foreach(heli in level.helis) {
      if(heli.streakname != "jackal") {
        continue;
      }
      if(level.teambased && heli.team == self.owner.team) {
        continue;
      }
      if(!level.teambased && heli.owner == self.owner) {
        continue;
      }
      if(targetvisibleinfront(heli))
        return heli;
    }
  }
}

targetvisibleinfront(target) {
  if(!isDefined(target))
    return 0;

  infront = 0;
  _id_27653C8C1EFD30B7 = self gettagorigin("tag_flash");
  targetpos = target.origin;
  _id_11B27B4CC48CD1F4 = vectorNormalize(targetpos - _id_27653C8C1EFD30B7);
  _id_1BB2CE3F090FF09F = anglesToForward(self.angles);
  ignorelist = [self, self.owner, target];
  contents = physics_createcontents(["physicscontents_clipshot", "physicscontents_glass", "physicscontents_water", "physicscontents_vehicle", "physicscontents_item"]);

  if(scripts\engine\trace::ray_trace_passed(_id_27653C8C1EFD30B7, targetpos, ignorelist, contents) && vectordot(_id_1BB2CE3F090FF09F, _id_11B27B4CC48CD1F4) > 0.25 && distance2dsquared(_id_27653C8C1EFD30B7, targetpos) > 10000)
    infront = 1;

  return infront;
}

shootshocksentrysamtarget(target, _id_BEA243C252114A9C) {
  self endon("death");
  self endon("carried");
  level endon("game_ended");
  self setmode("manual");
  thread setshocksamtargetEnt(target, _id_BEA243C252114A9C);
  self.sentryshocksamtarget = undefined;
  self waittill("turret_on_target");
  thread marktargetlaser(target);
  self playSound("shock_sentry_charge_up");
  playFXOnTag(scripts\engine\utility::getfx("sentry_shock_charge"), self, "tag_laser");
  sentry_spinup();
  stopFXOnTag(scripts\engine\utility::getfx("sentry_shock_charge"), self, "tag_laser");
  self notify("start_firing");
  self setscriptablepartstate("coil", "active");
  _id_81E7EE4D98262708 = 2;
  _id_89C026C489DDC1E3 = 1;

  while(isDefined(target) && targetvisibleinfront(target)) {
    _id_27653C8C1EFD30B7 = self gettagorigin("tag_flash");
    _id_BCFEEF729656E635 = scripts\cp_mp\utility\weapon_utility::_magicbullet(makeweapon("sentry_shock_missile_mp"), _id_27653C8C1EFD30B7, target.origin, self.owner);
    _id_BCFEEF729656E635 missile_settargetEnt(target);
    _id_BCFEEF729656E635 missile_setflightmodedirect();
    _id_BCFEEF729656E635.killcament = self.killcament;
    _id_BCFEEF729656E635.streakinfo = self.streakinfo;
    self setscriptablepartstate("muzzle", "fire" + _id_89C026C489DDC1E3, 0);
    level notify("laserGuidedMissiles_incoming", self.owner, _id_BCFEEF729656E635, target);
    _id_89C026C489DDC1E3++;

    if(_id_89C026C489DDC1E3 > 2)
      _id_89C026C489DDC1E3 = 1;

    wait(_id_81E7EE4D98262708);
  }

  self setscriptablepartstate("muzzle", "neutral", 0);
  self notify("sentry_lost_target");
  _id_BEA243C252114A9C unlink();
  _id_BEA243C252114A9C.origin = self gettagorigin("tag_flash");
  _id_BEA243C252114A9C linkTo(self, "tag_flash");
  self setmode("sentry");
  self cleartargetentity();
  self setscriptablepartstate("coil", "idle");
  sentry_spindown();
  self notify("done_firing");
}

sentry_handlemanualuse() {
  self endon("death");
  level endon("game_ended");

  for(;;) {
    self waittill("trigger", player);

    while(player isusingturret()) {
      if(player attackButtonPressed())
        self shootturret();

      waitframe();
    }

    waitframe();
  }
}

sentry_handlealteratepickup(_id_508482F603C6293E) {
  self endon("death");
  self.owner endon("disconnect");
  level endon("game_ended");
  self.owner notifyonplayercommand("maunal_sentry_pickup", "+weapnext");
  self.manualpickuptrigger = spawn("trigger_radius", self.origin, 0, 128, 128);
  self.manualpickuptrigger enablelinkTo();
  self.manualpickuptrigger linkTo(self, "tag_origin");

  for(;;) {
    if(isDefined(self.carriedby))
      waitframe();

    if(!self.owner istouching(self.manualpickuptrigger))
      waitframe();

    self.owner waittill("maunal_sentry_pickup");
    self setmode(level.sentrysettings[self.sentrytype].sentrymodeoff);
    self.owner.placedsentries[self.sentrytype] = scripts\engine\utility::array_remove(self.owner.placedsentries[self.sentrytype], self);
    self.owner setcarryingsentry(self, 0, _id_508482F603C6293E);
  }
}

setshocksamtargetEnt(target, _id_BEA243C252114A9C) {
  self endon("death");
  self endon("carried");
  self endon("sentry_lost_target");
  target endon("death");
  level endon("game_ended");

  for(;;) {
    startpoint = self gettagorigin("tag_aim");
    endpoint = target.origin;
    _id_734A884DF1A36225 = vectorNormalize(endpoint - startpoint);
    _id_180854261168EDDA = startpoint + _id_734A884DF1A36225 * 500;
    _id_BEA243C252114A9C unlink();
    _id_BEA243C252114A9C.origin = _id_180854261168EDDA;
    _id_BEA243C252114A9C linkTo(self);
    self settargetentity(_id_BEA243C252114A9C);
    waitframe();
  }
}

watchsentryshockpickup() {
  self endon("death");

  for(;;) {
    self waittill("carried");

    if(isDefined(self.sentryshocktargetent))
      self.sentryshocktargetent = undefined;

    if(isDefined(self.sentryshocksamtarget))
      self.sentryshocksamtarget = undefined;

    self cleartargetentity();
  }
}

shocktarget(target) {
  self endon("death");
  self endon("carried");

  if(!isDefined(target)) {
    return;
  }
  thread marktargetlaser(target);
  self playSound("shock_sentry_charge_up");
  sentry_spinup();
  self notify("start_firing");
  level thread scripts\mp\battlechatter_mp::saytoself(target, "plr_killstreak_target");
  firetime = weaponfiretime(level.sentrysettings[self.sentrytype].weaponinfo);

  while(isDefined(target) && scripts\mp\utility\player::isreallyalive(target) && isDefined(self getturrettarget(1)) && self getturrettarget(1) == target && !scripts\mp\utility\outline::outlineoccluded(self gettagorigin("tag_flash"), target getEye())) {
    self shootturret();
    wait(firetime);
  }

  self.sentryshocktargetent = undefined;
  self cleartargetentity();
  sentry_spindown();
  self notify("done_firing");
}

missileburstfire(target) {
  self endon("death");
  self endon("carried");
  _id_C8CC9E14CBC6C616 = 3;
  _id_89C026C489DDC1E3 = 1;

  while(_id_C8CC9E14CBC6C616 > 0) {
    if(!isDefined(target)) {
      return;
    }
    if(!isDefined(self.owner)) {
      return;
    }
    _id_261AF406EE6924EA = scripts\cp_mp\utility\weapon_utility::_magicbullet(makeweapon("sentry_shock_grenade_mp"), self gettagorigin("tag_flash"), target.origin, self.owner);
    _id_261AF406EE6924EA missile_settargetEnt(target, gettargetoffset(target));
    _id_261AF406EE6924EA.killcament = self.killcament;
    _id_261AF406EE6924EA.streakinfo = self.streakinfo;
    self setscriptablepartstate("muzzle", "fire" + _id_89C026C489DDC1E3, 0);
    _id_89C026C489DDC1E3++;

    if(_id_89C026C489DDC1E3 > 2)
      _id_89C026C489DDC1E3 = 1;

    _id_261AF406EE6924EA thread watchtargetchange(target);
    _id_C8CC9E14CBC6C616--;
    wait 0.2;
  }
}

gettargetoffset(target) {
  heightoffset = (0, 0, 40);
  _id_E8BE66AEC958DE65 = target getstance();

  switch (_id_E8BE66AEC958DE65) {
    case "stand":
      heightoffset = (0, 0, 40);
      break;
    case "crouch":
      heightoffset = (0, 0, 20);
      break;
    case "prone":
      heightoffset = (0, 0, 5);
      break;
  }

  return heightoffset;
}

watchtargetchange(target) {
  self endon("death");
  target endon("disconnect");

  for(;;) {
    if(!scripts\mp\utility\player::isreallyalive(target)) {
      self missile_settargetEnt(target getcorpseentity());
      break;
    }

    waitframe();
  }
}

marktargetlaser(target) {
  self endon("death");
  self laseron();
  self.laser_on = 1;
  scripts\engine\utility::waittill_any_2("done_firing", "carried");
  self laseroff();
  self.laser_on = 0;
}

watchshockdamage(target) {
  self endon("death");
  self endon("done_firing");
  triggerradius = undefined;

  for(;;) {
    self waittill("victim_damaged", victim, einflictor, idamage, idflags, smeansofdeath, objweapon, vpoint, vdir, shitloc, psoffsettime);

    if(victim == target) {
      damageradius = 100;
      _id_B959B266290F9E13 = scripts\mp\utility\player::getplayersinradiusview(vpoint, damageradius, victim.team, self.owner);
      playFX(scripts\engine\utility::getfx("sentry_shock_explosion"), vpoint);

      if(_id_B959B266290F9E13.size > 0) {
        foreach(info in _id_B959B266290F9E13) {
          if(info.player != victim) {
            info.player dodamage(5, vpoint, self.owner, self, smeansofdeath, objweapon);
            _id_879997A46F725F30 = undefined;
            _id_610520BE555433B2 = undefined;

            if(info.visiblelocations.size > 1) {
              _id_610520BE555433B2 = randomint(info.visiblelocations.size);
              _id_879997A46F725F30 = info.visiblelocations[_id_610520BE555433B2];
            } else
              _id_879997A46F725F30 = info.visiblelocations[0];

            playfxbetweenpoints(scripts\engine\utility::getfx("sentry_shock_arc"), vpoint, vectortoangles(_id_879997A46F725F30 - vpoint), _id_879997A46F725F30);
          }
        }
      }
    }
  }
}

allowweaponsforsentry(_id_CD187E38E3DF8F36) {
  if(_id_CD187E38E3DF8F36) {
    _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("sentry_weapons");
    thread scripts\mp\supers::unstowsuperweapon();
  } else {
    thread scripts\mp\supers::allowsuperweaponstow();
    _id_3B64EB40368C1450::set("sentry_weapons", "weapon", 0);
  }
}

placehinton() {
  sentrytype = self.sentrytype;

  if(sentrytype == "super_trophy") {
    self.owner forceusehinton(&"LUA_MENU_MP/PLACE_SUPER_TROPHY");
    return;
  } else
    self.owner forceusehinton(&"SENTRY/PLACE");
}

cannotplacehinton() {
  sentrytype = self.sentrytype;

  if(sentrytype == "super_trophy") {
    self.owner forceusehinton(&"LUA_MENU_MP/CANNOT_PLACE_SUPER_TROPHY");
    return;
  } else
    self.owner forceusehinton(&"SENTRY/CANNOT_PLACE");
}