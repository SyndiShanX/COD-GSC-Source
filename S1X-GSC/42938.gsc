/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 42938.gsc
**************************************/

init() {
  if(!isDefined(level.sentrytype)) {
    level.sentrytype = [];
  }

  level.sentrytype["sentry_minigun"] = "sentry";
  level.sentrytype["sam_turret"] = "sam_turret";
  level.killstreakfuncs[level.sentrytype["sentry_minigun"]] = ::tryuseautosentry;
  level.killstreakfuncs[level.sentrytype["sam_turret"]] = ::tryusesam;

  if(!isDefined(level.sentrysettings)) {
    level.sentrysettings = [];
  }

  level.sentrysettings["sentry_minigun"] = spawnStruct();
  level.sentrysettings["sentry_minigun"].health = 999999;
  level.sentrysettings["sentry_minigun"].maxhealth = 1000;
  level.sentrysettings["sentry_minigun"].burstmin = 20;
  level.sentrysettings["sentry_minigun"].burstmax = 120;
  level.sentrysettings["sentry_minigun"].pausemin = 0.15;
  level.sentrysettings["sentry_minigun"].pausemax = 0.35;
  level.sentrysettings["sentry_minigun"].sentrymodeon = "sentry";
  level.sentrysettings["sentry_minigun"].sentrymodeoff = "sentry_offline";
  level.sentrysettings["sentry_minigun"].timeout = 90.0;
  level.sentrysettings["sentry_minigun"].spinuptime = 0.05;
  level.sentrysettings["sentry_minigun"].overheattime = 8.0;
  level.sentrysettings["sentry_minigun"].cooldowntime = 0.1;
  level.sentrysettings["sentry_minigun"].fxtime = 0.3;
  level.sentrysettings["sentry_minigun"].streakname = "sentry";
  level.sentrysettings["sentry_minigun"].weaponinfo = "sentry_minigun_mp";
  level.sentrysettings["sentry_minigun"].modelbase = "sentry_minigun_weak";
  level.sentrysettings["sentry_minigun"].modelplacement = "sentry_minigun_weak_obj";
  level.sentrysettings["sentry_minigun"].modelplacementfailed = "sentry_minigun_weak_obj_red";
  level.sentrysettings["sentry_minigun"].modeldestroyed = "sentry_minigun_weak_destroyed";
  level.sentrysettings["sentry_minigun"].hintstring = &"SENTRY_PICKUP";
  level.sentrysettings["sentry_minigun"].headicon = 1;
  level.sentrysettings["sentry_minigun"].teamsplash = "used_sentry";
  level.sentrysettings["sentry_minigun"].shouldsplash = 0;
  level.sentrysettings["sentry_minigun"].vodestroyed = "sentry_destroyed";
  level.sentrysettings["sam_turret"] = spawnStruct();
  level.sentrysettings["sam_turret"].health = 999999;
  level.sentrysettings["sam_turret"].maxhealth = 1000;
  level.sentrysettings["sam_turret"].burstmin = 20;
  level.sentrysettings["sam_turret"].burstmax = 120;
  level.sentrysettings["sam_turret"].pausemin = 0.15;
  level.sentrysettings["sam_turret"].pausemax = 0.35;
  level.sentrysettings["sam_turret"].sentrymodeon = "sentry_manual";
  level.sentrysettings["sam_turret"].sentrymodeoff = "sentry_offline";
  level.sentrysettings["sam_turret"].timeout = 90.0;
  level.sentrysettings["sam_turret"].spinuptime = 0.05;
  level.sentrysettings["sam_turret"].overheattime = 8.0;
  level.sentrysettings["sam_turret"].cooldowntime = 0.1;
  level.sentrysettings["sam_turret"].fxtime = 0.3;
  level.sentrysettings["sam_turret"].streakname = "sam_turret";
  level.sentrysettings["sam_turret"].weaponinfo = "sam_mp";
  level.sentrysettings["sam_turret"].modelbase = "mp_sam_turret";
  level.sentrysettings["sam_turret"].modelplacement = "mp_sam_turret_placement";
  level.sentrysettings["sam_turret"].modelplacementfailed = "mp_sam_turret_placement_failed";
  level.sentrysettings["sam_turret"].modeldestroyed = "mp_sam_turret";
  level.sentrysettings["sam_turret"].hintstring = &"SENTRY_PICKUP";
  level.sentrysettings["sam_turret"].headicon = 1;
  level.sentrysettings["sam_turret"].teamsplash = "used_sam_turret";
  level.sentrysettings["sam_turret"].shouldsplash = 0;
  level.sentrysettings["sam_turret"].vodestroyed = "sam_destroyed";
  level._effect["sentry_overheat_mp"] = loadfx("vfx/distortion/sentrygun_overheat");
  level._effect["sentry_explode_mp"] = loadfx("vfx/explosion/vehicle_pdrone_explosion");
  level._effect["sentry_smoke_mp"] = loadfx("vfx/smoke/vehicle_sentrygun_damaged_smoke");
  level._effect["sentry_stunned"] = loadfx("vfx/sparks/direct_hack_stun");
}

tryuseautosentry(var_0, var_1) {
  var_2 = givesentry("sentry_minigun");

  if(var_2) {
    maps\mp\_matchdata::logkillstreakevent(level.sentrysettings["sentry_minigun"].streakname, self.origin);
  }

  return var_2;
}

tryusesam(var_0, var_1) {
  var_2 = givesentry("sam_turret");

  if(var_2) {
    maps\mp\_matchdata::logkillstreakevent(level.sentrysettings["sam_turret"].streakname, self.origin);
  }

  return var_2;
}

givesentry(var_0) {
  if(!maps\mp\_utility::validateusestreak()) {
    return 0;
  }

  self.last_sentry = var_0;
  var_1 = createsentryforplayer(var_0, self);
  removeperks();
  var_2 = setcarryingsentry(var_1, 1);
  thread waitrestoreperks();
  self.iscarrying = 0;

  if(isDefined(var_1)) {
    return 1;
  } else {
    return 0;
  }
}

setcarryingsentry(var_0, var_1) {
  self endon("death");
  self endon("disconnect");
  var_0 sentry_setcarried(self);
  common_scripts\utility::_disableweapon();

  if(!isai(self)) {
    self notifyonplayercommand("place_sentry", "+attack");
    self notifyonplayercommand("place_sentry", "+attack_akimbo_accessible");
    self notifyonplayercommand("cancel_sentry", "+actionslot 4");

    if(!level.console) {
      self notifyonplayercommand("cancel_sentry", "+actionslot 5");
      self notifyonplayercommand("cancel_sentry", "+actionslot 6");
      self notifyonplayercommand("cancel_sentry", "+actionslot 7");
      self notifyonplayercommand("cancel_sentry", "+actionslot 8");
    }
  }

  for(;;) {
    var_2 = common_scripts\utility::waittill_any_return("place_sentry", "cancel_sentry", "force_cancel_placement");

    if(var_2 == "cancel_sentry" || var_2 == "force_cancel_placement") {
      if(!var_1 && var_2 == "cancel_sentry") {
        continue;
      }
      if(level.console) {
        var_3 = maps\mp\_utility::getkillstreakweapon(level.sentrysettings[var_0.sentrytype].streakname);

        if(isDefined(self.killstreakindexweapon) && var_3 == maps\mp\_utility::getkillstreakweapon(self.pers["killstreaks"][self.killstreakindexweapon].streakname) && !self getweaponslistitems().size) {
          maps\mp\_utility::_giveweapon(var_3, 0);
          maps\mp\_utility::_setactionslot(4, "weapon", var_3);
        }
      }

      var_0 sentry_setcancelled();
      common_scripts\utility::_enableweapon();
      return 0;
    }

    if(!var_0.canbeplaced) {
      continue;
    }
    var_0 sentry_setplaced();
    common_scripts\utility::_enableweapon();
    return 1;
  }
}

removeweapons() {
  if(self hasweapon("riotshield_mp")) {
    self.restoreweapon = "riotshield_mp";
    self takeweapon("riotshield_mp");
  }
}

removeperks() {
  if(maps\mp\_utility::_hasperk("specialty_explosivebullets")) {
    self.restoreperk = "specialty_explosivebullets";
    maps\mp\_utility::_unsetperk("specialty_explosivebullets");
  }
}

restoreweapons() {
  if(isDefined(self.restoreweapon)) {
    maps\mp\_utility::_giveweapon(self.restoreweapon);
    self.restoreweapon = undefined;
  }
}

restoreperks() {
  if(isDefined(self.restoreperk)) {
    maps\mp\_utility::giveperk(self.restoreperk, 0);
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

createsentryforplayer(var_0, var_1) {
  var_2 = spawnturret("misc_turret", var_1.origin, level.sentrysettings[var_0].weaponinfo);
  var_2.angles = var_1.angles;
  var_2 sentry_initsentry(var_0, var_1);
  return var_2;
}

sentry_initsentry(var_0, var_1) {
  self.sentrytype = var_0;
  self.canbeplaced = 1;
  self setModel(level.sentrysettings[self.sentrytype].modelbase);
  self.shouldsplash = 1;
  self setCanDamage(1);

  switch (var_0) {
    case "sam_turret":
      self maketurretinoperable();
      self setleftarc(180);
      self setrightarc(180);
      self settoparc(80);
      self setdefaultdroppitch(-89.0);
      self.laser_on = 0;
      var_2 = spawn("script_model", self gettagorigin("tag_laser"));
      var_2 linkto(self);
      self.killcament = var_2;
      self.killcament setscriptmoverkillcam("explosive");
      break;
    default:
      self maketurretinoperable();
      self setdefaultdroppitch(-89.0);
      break;
  }

  self setturretmodechangewait(1);
  sentry_setinactive();
  sentry_setowner(var_1);
  thread sentry_handledeath();
  thread sentry_timeout();

  switch (var_0) {
    case "sam_turret":
      thread sentry_handleuse();
      thread sentry_beepsounds();
      break;
    default:
      thread sentry_handleuse();
      thread sentry_attacktargets();
      thread sentry_beepsounds();
      break;
  }
}

sentry_watchdisabled() {
  self endon("carried");
  self endon("death");
  level endon("game_ended");

  for(;;) {
    self waittill("emp_damage", var_0, var_1);
    playFXOnTag(common_scripts\utility::getfx("sentry_stunned"), self, "tag_aim");
    self setdefaultdroppitch(40);
    self setmode(level.sentrysettings[self.sentrytype].sentrymodeoff);
    wait(var_1);
    stopFXOnTag(common_scripts\utility::getfx("sentry_stunned"), self, "tag_aim");
    self setdefaultdroppitch(-89.0);
    self setmode(level.sentrysettings[self.sentrytype].sentrymodeon);
  }
}

sentry_directhacked() {
  self endon("death");
  level endon("game_ended");
  self.directhackduration = 0.25;

  if(isDefined(self.directhackendtime) && gettime() < self.directhackendtime) {
    self.directhackendtime = gettime() + self.directhackduration * 1000;
    return;
  }

  playFXOnTag(common_scripts\utility::getfx("sentry_stunned"), self, "tag_aim");
  self.directhackendtime = gettime() + self.directhackduration * 1000;
  self setdefaultdroppitch(40);
  self setmode(level.sentrysettings[self.sentrytype].sentrymodeoff);

  for(;;) {
    if(gettime() > self.directhackendtime) {
      break;
    }

    wait 0.05;
  }

  self setdefaultdroppitch(-89.0);
  self setmode(level.sentrysettings[self.sentrytype].sentrymodeon);
  stopFXOnTag(common_scripts\utility::getfx("sentry_stunned"), self, "tag_aim");
}

sentry_handledeath() {
  self waittill("death");

  if(!isDefined(self)) {
    return;
  }
  self setModel(level.sentrysettings[self.sentrytype].modeldestroyed);
  sentry_setinactive();
  self setdefaultdroppitch(40);
  self setsentryowner(undefined);
  self setturretminimapvisible(0);

  if(isDefined(self.ownertrigger)) {
    self.ownertrigger delete();
  }

  self playSound("sentry_explode");

  if(isDefined(self.inuseby)) {
    playFXOnTag(common_scripts\utility::getfx("sentry_explode_mp"), self, "tag_origin");
    playFXOnTag(common_scripts\utility::getfx("sentry_smoke_mp"), self, "tag_aim");
    self.inuseby.turret_overheat_bar maps\mp\gametypes\_hud_util::destroyelem();
    self.inuseby restoreperks();
    self.inuseby restoreweapons();
    self notify("deleting");
    wait 1.0;
    stopFXOnTag(common_scripts\utility::getfx("sentry_explode_mp"), self, "tag_origin");
    stopFXOnTag(common_scripts\utility::getfx("sentry_smoke_mp"), self, "tag_aim");
  } else {
    playFXOnTag(common_scripts\utility::getfx("sentry_explode_mp"), self, "tag_aim");
    wait 1.5;
    self playSound("sentry_explode_smoke");

    for(var_0 = 8; var_0 > 0; var_0 = var_0 - 0.4) {
      playFXOnTag(common_scripts\utility::getfx("sentry_smoke_mp"), self, "tag_aim");
      wait 0.4;
    }

    self notify("deleting");
  }

  if(isDefined(self.killcament)) {
    self.killcament delete();
  }

  self delete();
}

sentry_handleuse() {
  self endon("death");
  level endon("game_ended");

  for(;;) {
    self waittill("trigger", var_0);

    if(!maps\mp\_utility::isreallyalive(var_0)) {
      continue;
    }
    if(self.sentrytype == "sam_turret") {
      self setmode(level.sentrysettings[self.sentrytype].sentrymodeoff);
    }

    var_0 setcarryingsentry(self, 0);
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
        if(!maps\mp\_utility::isreallyalive(self)) {
          continue;
        }
        if(isDefined(self.using_remote_turret) && self.using_remote_turret) {
          continue;
        }
        var_0 setmode(level.sentrysettings[var_0.sentrytype].sentrymodeoff);
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
    if(!maps\mp\_utility::isreallyalive(var_3)) {
      continue;
    }
    var_3 removeperks();
    var_3 removeweapons();
    self.inuseby = var_3;
    self setmode(level.sentrysettings[self.sentrytype].sentrymodeoff);
    sentry_setowner(var_3);
    self setmode(level.sentrysettings[self.sentrytype].sentrymodeon);
    var_3 thread turret_shotmonitor(self);
    var_3.turret_overheat_bar = var_3 maps\mp\gametypes\_hud_util::createbar(var_0, 100, 6);
    var_3.turret_overheat_bar maps\mp\gametypes\_hud_util::setpoint("CENTER", "BOTTOM", 0, -70);
    var_3.turret_overheat_bar.alpha = 0.65;
    var_3.turret_overheat_bar.bar.alpha = 0.65;
    var_4 = 0;

    for(;;) {
      if(!maps\mp\_utility::isreallyalive(var_3)) {
        self.inuseby = undefined;
        var_3.turret_overheat_bar maps\mp\gametypes\_hud_util::destroyelem();
        break;
      }

      if(!var_3 isusingturret()) {
        self notify("player_dismount");
        self.inuseby = undefined;
        var_3.turret_overheat_bar maps\mp\gametypes\_hud_util::destroyelem();
        var_3 restoreperks();
        var_3 restoreweapons();
        self sethintstring(level.sentrysettings[self.sentrytype].hintstring);
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

      var_3.turret_overheat_bar maps\mp\gametypes\_hud_util::updatebar(var_5);

      if(self.forcedisable || self.overheated) {
        self turretfiredisable();
        var_3.turret_overheat_bar.bar.color = var_2;
        var_4 = 0;
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
  self.owner common_scripts\utility::waittill_any("disconnect", "joined_team", "joined_spectators");
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

sentry_setplaced() {
  self setModel(level.sentrysettings[self.sentrytype].modelbase);

  if(self getmode() == "manual") {
    self setmode(level.sentrysettings[self.sentrytype].sentrymodeoff);
  }

  self setsentrycarrier(undefined);
  self setCanDamage(1);
  sentry_makesolid();
  self.carriedby forceusehintoff();
  self.carriedby = undefined;

  if(isDefined(self.owner)) {
    self.owner.iscarrying = 0;
  }

  sentry_setactive();
  self playSound("sentry_gun_plant");
  self notify("placed");
}

sentry_setcancelled() {
  self.carriedby forceusehintoff();

  if(isDefined(self.owner)) {
    self.owner.iscarrying = 0;
  }

  self delete();
}

sentry_setcarried(var_0) {
  if(isDefined(self.originalowner)) {
    } else {}

  self setModel(level.sentrysettings[self.sentrytype].modelplacement);
  self setsentrycarrier(var_0);
  self setCanDamage(0);
  sentry_makenotsolid();
  self.carriedby = var_0;
  var_0.iscarrying = 1;
  var_0 thread updatesentryplacement(self);
  thread sentry_oncarrierdeath(var_0);
  thread sentry_oncarrierdisconnect(var_0);
  thread sentry_oncarrierchangedteam(var_0);
  thread sentry_ongameended();
  self setdefaultdroppitch(-89.0);
  sentry_setinactive();
  self notify("carried");
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
    var_2 = self canplayerplacesentry(1, 22);
    var_0.origin = var_2["origin"];
    var_0.angles = var_2["angles"];
    var_0.canbeplaced = self isonground() && var_2["result"] && abs(var_0.origin[2] - self.origin[2]) < 30;

    if(var_0.canbeplaced != var_1) {
      if(var_0.canbeplaced) {
        var_0 setModel(level.sentrysettings[var_0.sentrytype].modelplacement);
        self forceusehinton(&"SENTRY_PLACE");
      } else {
        var_0 setModel(level.sentrysettings[var_0.sentrytype].modelplacementfailed);
        self forceusehinton(&"SENTRY_CANNOT_PLACE");
      }
    }

    var_1 = var_0.canbeplaced;
    wait 0.05;
  }
}

sentry_oncarrierdeath(var_0) {
  self endon("placed");
  self endon("death");
  var_0 waittill("death");

  if(self.canbeplaced) {
    sentry_setplaced();
  } else {
    self delete();
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
  var_0 common_scripts\utility::waittill_any("joined_team", "joined_spectators");
  self delete();
}

sentry_ongameended(var_0) {
  self endon("placed");
  self endon("death");
  level waittill("game_ended");
  self delete();
}

sentry_setactive() {
  self setmode(level.sentrysettings[self.sentrytype].sentrymodeon);
  self setcursorhint("HINT_NOICON");
  self sethintstring(level.sentrysettings[self.sentrytype].hintstring);

  if(level.sentrysettings[self.sentrytype].headicon) {
    if(level.teambased) {
      maps\mp\_entityheadicons::setteamheadicon(self.team, (0, 0, 65));
    } else {
      maps\mp\_entityheadicons::setplayerheadicon(self.owner, (0, 0, 65));
    }
  }

  self makeusable();

  foreach(var_1 in level.players) {
    var_2 = self getentitynumber();
    addtoturretlist(var_2);

    if(var_1 == self.owner) {
      self enableplayeruse(var_1);
      continue;
    }

    self disableplayeruse(var_1);
  }

  if(self.shouldsplash) {
    level thread maps\mp\_utility::teamplayercardsplash(level.sentrysettings[self.sentrytype].teamsplash, self.owner, self.owner.team);
    self.shouldsplash = 0;
  }

  if(self.sentrytype == "sam_turret") {
    thread sam_attacktargets();
  }

  thread sentry_watchdisabled();
}

sentry_setinactive() {
  self setmode(level.sentrysettings[self.sentrytype].sentrymodeoff);
  self makeunusable();
  self freeentitysentient();
  var_0 = self getentitynumber();
  removefromturretlist(var_0);

  if(level.teambased) {
    maps\mp\_entityheadicons::setteamheadicon("none", (0, 0, 0));
  } else if(isDefined(self.owner)) {
    maps\mp\_entityheadicons::setplayerheadicon(undefined, (0, 0, 0));
  }
}

sentry_makesolid() {
  self maketurretsolid();
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

addtoturretlist(var_0) {
  level.turrets[var_0] = self;
}

removefromturretlist(var_0) {
  level.turrets[var_0] = undefined;
}

sentry_attacktargets() {
  self endon("death");
  level endon("game_ended");
  self.momentum = 0;
  self.heatlevel = 0;
  self.overheated = 0;
  thread sentry_heatmonitor();

  for(;;) {
    common_scripts\utility::waittill_either("turretstatechange", "cooled");

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
  var_0 = level.sentrysettings[self.sentrytype].timeout;

  while(var_0) {
    wait 1.0;
    maps\mp\gametypes\_hostmigration::waittillhostmigrationdone();

    if(!isDefined(self.carriedby)) {
      var_0 = max(0, var_0 - 1.0);
    }
  }

  if(isDefined(self.owner)) {
    if(self.sentrytype == "sam_turret") {
      self.owner thread maps\mp\_utility::leaderdialogonplayer("sam_gone");
    } else {
      self.owner thread maps\mp\_utility::leaderdialogonplayer("sentry_gone");
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
    playFXOnTag(common_scripts\utility::getfx("sentry_overheat_mp"), self, "tag_flash");
    wait(level.sentrysettings[self.sentrytype].fxtime);
  }
}

playsmokefx() {
  self endon("death");
  self endon("not_overheated");
  level endon("game_ended");

  for(;;) {
    playFXOnTag(common_scripts\utility::getfx("sentry_smoke_mp"), self, "tag_aim");
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
      } else if(isDefined(self.team)) {
        var_1 = level.uavmodels[level.otherteam[self.team]];
      }

      foreach(var_9 in var_1) {
        if(isDefined(var_9.isleaving) && var_9.isleaving) {
          continue;
        }
        if(isDefined(var_9.orbit) && var_9.orbit) {
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
        if(isDefined(var_15.cloakstate) && var_15.cloakstate < 1) {
          continue;
        }
        if(sighttracepassed(var_0, var_15.origin, 0, self, var_15)) {
          return var_15;
        }
      }

      if(level.orbitalsupportinuse && isDefined(level.orbitalsupport_planemodel.owner) && level.orbitalsupport_planemodel.owner.team != self.team) {
        if(sighttracepassed(var_0, level.orbitalsupport_planemodel.origin, 0, self)) {
          return level.orbitalsupport_planemodel;
        }
      }

      if(isDefined(level._orbital_care_pod)) {
        foreach(var_18 in level._orbital_care_pod) {
          if(isDefined(var_18.podrocket) && var_18.owner.team != self.team) {
            if(sighttracepassed(var_0, var_18.podrocket.origin, 0, self)) {
              return var_18.podrocket;
            }
          }
        }
      }

      foreach(var_21 in level.planes) {
        if(isDefined(var_21.team) && var_21.team == self.team) {
          continue;
        }
        if(sighttracepassed(var_0, var_21.origin, 0, self)) {
          return var_21;
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
        if(isDefined(var_9.orbit) && var_9.orbit) {
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
        if(isDefined(var_15.cloakstate) && var_15.cloakstate < 1) {
          continue;
        }
        if(sighttracepassed(var_0, var_15.origin, 0, self, var_15)) {
          return var_15;
        }
      }

      if(level.orbitalsupportinuse && isDefined(level.orbitalsupport_planemodel.owner) && isDefined(self.owner) && level.orbitalsupport_planemodel.owner != self.owner) {
        if(sighttracepassed(var_0, level.orbitalsupport_planemodel.owner.origin, 0, self)) {
          return level.orbitalsupport_planemodel.owner;
        }
      }

      if(isDefined(level._orbital_care_pod)) {
        foreach(var_18 in level._orbital_care_pod) {
          if(isDefined(var_18.podrocket) && var_18.owner != self) {
            if(sighttracepassed(var_0, var_18.podrocket.origin, 0, self)) {
              return var_18.podrocket;
            }
          }
        }
      }

      foreach(var_21 in level.planes) {
        if(isDefined(var_21.team) && var_21.owner == self.owner) {
          continue;
        }
        if(sighttracepassed(var_0, var_21.origin, 0, self)) {
          return var_21;
        }
      }
    }

    self cleartargetentity();
    return undefined;
  } else {
    if(!sighttracepassed(var_0, self.samtargetent.origin, 0, self, self.samtargetent)) {
      self cleartargetentity();
      return undefined;
    }

    return self.samtargetent;
  }
}

sam_fireontarget() {
  if(isDefined(self.samtargetent)) {
    if(self.samtargetent == level.ac130.planemodel && !isDefined(level.ac130player) || isDefined(level.orbitalsupport_planemodel) && self.samtargetent == level.orbitalsupport_planemodel && !isDefined(level.orbitalsupport_player)) {
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
      var_3 = magicbullet("sam_projectile_mp", var_0[var_2], self.samtargetent.origin, self.owner);
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
  self endon("fakedeath");

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
  self notify("laser_on");

  while(isDefined(self.samtargetent) && isDefined(self getturrettarget(1)) && self getturrettarget(1) == self.samtargetent) {
    wait 0.05;
  }

  self laseroff();
  self.laser_on = 0;
  self notify("laser_off");
}

sam_watchcrashing() {
  self endon("death");
  self endon("fakedeath");
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
  self endon("fakedeath");
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