/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3516.gsc
**************************************/

init() {
  scripts\mp\killstreaks\killstreaks::registerkillstreak("remote_tank", ::func_128FE);
  level.tanksettings = [];
  level.tanksettings["remote_tank"] = spawnStruct();
  level.tanksettings["remote_tank"].timeout = 60.0;
  level.tanksettings["remote_tank"].health = 99999;
  level.tanksettings["remote_tank"].maxhealth = 1000;
  level.tanksettings["remote_tank"].streakname = "remote_tank";
  level.tanksettings["remote_tank"].mgturretinfo = "ugv_turret_mp";
  level.tanksettings["remote_tank"].var_B88D = "remote_tank_projectile_mp";
  level.tanksettings["remote_tank"].sentrymodeoff = "sentry_offline";
  level.tanksettings["remote_tank"].vehicleinfo = "remote_ugv_mp";
  level.tanksettings["remote_tank"].modelbase = "vehicle_ugv_talon_mp";
  level.tanksettings["remote_tank"].var_B922 = "vehicle_ugv_talon_gun_mp";
  level.tanksettings["remote_tank"].modelplacement = "vehicle_ugv_talon_obj";
  level.tanksettings["remote_tank"].modelplacementfailed = "vehicle_ugv_talon_obj_red";
  level.tanksettings["remote_tank"].modeldestroyed = "vehicle_ugv_talon_mp";
  level.tanksettings["remote_tank"].var_1114D = &"KILLSTREAKS_REMOTE_TANK_PLACE";
  level.tanksettings["remote_tank"].var_1114C = &"KILLSTREAKS_REMOTE_TANK_CANNOT_PLACE";
  level.tanksettings["remote_tank"].var_A84D = "killstreak_remote_tank_laptop_mp";
  level.tanksettings["remote_tank"].remotedetonatethink = "killstreak_remote_tank_remote_mp";
  level._effect["remote_tank_dying"] = loadfx("vfx\core\expl\killstreak_explosion_quick");
  level._effect["remote_tank_explode"] = loadfx("vfx\core\expl\bouncing_betty_explosion");
  level._effect["remote_tank_spark"] = loadfx("vfx\core\impacts\large_metal_painted_hit");
  level._effect["remote_tank_antenna_light_mp"] = loadfx("vfx\core\vehicles\aircraft_light_red_blink");
  level._effect["remote_tank_camera_light_mp"] = loadfx("vfx\core\vehicles\aircraft_light_wingtip_green");
  level.remote_tank_armor_bulletdamage = 0.5;
}

func_128FE(var_0, var_1) {
  var_2 = 1;

  if(scripts\mp\utility\game::currentactivevehiclecount() >= scripts\mp\utility\game::maxvehiclesallowed() || level.fauxvehiclecount + var_2 >= scripts\mp\utility\game::maxvehiclesallowed()) {
    self iprintlnbold(&"KILLSTREAKS_TOO_MANY_VEHICLES");
    return 0;
  }

  scripts\mp\utility\game::incrementfauxvehiclecount();
  var_3 = _meth_83AC(var_0, "remote_tank");

  if(var_3) {
    scripts\mp\matchdata::logkillstreakevent("remote_tank", self.origin);
    thread scripts\mp\utility\game::teamplayercardsplash("used_remote_tank", self);
    func_1146D("remote_tank");
  } else
    scripts\mp\utility::decrementfauxvehiclecount();

  self.iscarrying = 0;
  return var_3;
}

func_1146D(var_0) {
  var_1 = scripts\mp\utility\game::getkillstreakweapon(level.tanksettings[var_0].streakname);
  scripts\mp\killstreaks\killstreaks::func_1146C(var_1);
  scripts\mp\utility\game::_takeweapon(level.tanksettings[var_0].var_A84D);
  scripts\mp\utility\game::_takeweapon(level.tanksettings[var_0].remotedetonatethink);
}

removeperks() {
  if(scripts\mp\utility\game::_hasperk("specialty_explosivebullets")) {
    self.restoreperk = "specialty_explosivebullets";
    scripts\mp\utility\game::removeperk("specialty_explosivebullets");
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

removeweapons() {
  var_0 = self getweaponslistprimaries();

  foreach(var_2 in var_0) {
    var_3 = strtok(var_2, "_");

    if(var_3[0] == "alt") {
      self.restoreweaponclipammo[var_2] = self getweaponammoclip(var_2);
      self.var_E2E9[var_2] = self getweaponammostock(var_2);
      continue;
    }

    self.restoreweaponclipammo[var_2] = self getweaponammoclip(var_2);
    self.var_E2E9[var_2] = self getweaponammostock(var_2);
  }

  self.var_13CD2 = [];

  foreach(var_2 in var_0) {
    var_3 = strtok(var_2, "_");
    self.var_13CD2[self.var_13CD2.size] = var_2;

    if(var_3[0] == "alt") {
      continue;
    }
    scripts\mp\utility\game::_takeweapon(var_2);
  }
}

restoreweapons() {
  if(!isDefined(self.restoreweaponclipammo) || !isDefined(self.var_E2E9) || !isDefined(self.var_13CD2)) {
    return;
  }
  var_0 = [];

  foreach(var_2 in self.var_13CD2) {
    var_3 = strtok(var_2, "_");

    if(var_3[0] == "alt") {
      var_0[var_0.size] = var_2;
      continue;
    }

    scripts\mp\utility\game::_giveweapon(var_2);

    if(isDefined(self.restoreweaponclipammo[var_2])) {
      self setweaponammoclip(var_2, self.restoreweaponclipammo[var_2]);
    }

    if(isDefined(self.var_E2E9[var_2])) {
      self setweaponammostock(var_2, self.var_E2E9[var_2]);
    }
  }

  foreach(var_6 in var_0) {
    if(isDefined(self.restoreweaponclipammo[var_6])) {
      self setweaponammoclip(var_6, self.restoreweaponclipammo[var_6]);
    }

    if(isDefined(self.var_E2E9[var_6])) {
      self setweaponammostock(var_6, self.var_E2E9[var_6]);
    }
  }

  self.restoreweaponclipammo = undefined;
  self.var_E2E9 = undefined;
}

func_13710() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  wait 0.05;
  restoreweapons();
}

_meth_83AC(var_0, var_1) {
  var_2 = func_4A20(var_1, self);
  var_2.lifeid = var_0;
  removeperks();
  removeweapons();
  var_3 = func_F689(var_2, 1);
  thread restoreperks();
  thread restoreweapons();

  if(!isDefined(var_3)) {
    var_3 = 0;
  }

  return var_3;
}

func_4A20(var_0, var_1) {
  var_2 = spawnturret("misc_turret", var_1.origin + (0, 0, 25), level.tanksettings[var_0].mgturretinfo);
  var_2.angles = var_1.angles;
  var_2.tanktype = var_0;
  var_2.owner = var_1;
  var_2 setModel(level.tanksettings[var_0].modelbase);
  var_2 maketurretinoperable();
  var_2 setturretmodechangewait(1);
  var_2 give_player_session_tokens("sentry_offline");
  var_2 makeunusable();
  var_2 setsentryowner(var_1);
  return var_2;
}

func_F689(var_0, var_1) {
  self endon("death");
  self endon("disconnect");
  var_0 thread func_114CE(self);
  scripts\engine\utility::allow_weapon(0);
  self notifyonplayercommand("place_tank", "+attack");
  self notifyonplayercommand("place_tank", "+attack_akimbo_accessible");
  self notifyonplayercommand("cancel_tank", "+actionslot 4");

  if(!level.console) {
    self notifyonplayercommand("cancel_tank", "+actionslot 5");
    self notifyonplayercommand("cancel_tank", "+actionslot 6");
    self notifyonplayercommand("cancel_tank", "+actionslot 7");
  }

  for(;;) {
    var_2 = scripts\engine\utility::waittill_any_return("place_tank", "cancel_tank", "force_cancel_placement");

    if(var_2 == "cancel_tank" || var_2 == "force_cancel_placement") {
      if(!var_1 && var_2 == "cancel_tank") {
        continue;
      }
      if(level.console) {
        var_3 = scripts\mp\utility\game::getkillstreakweapon(level.tanksettings[var_0.tanktype].streakname);

        if(isDefined(self.var_A6A1) && var_3 == scripts\mp\utility\game::getkillstreakweapon(self.pers["killstreaks"][self.var_A6A1].streakname) && !self getweaponlistitems().size) {
          scripts\mp\utility\game::_giveweapon(var_3, 0);
          scripts\mp\utility\game::_setactionslot(4, "weapon", var_3);
        }
      }

      var_0 func_114CD();
      scripts\engine\utility::allow_weapon(1);
      return 0;
    }

    if(!var_0.canbeplaced) {
      continue;
    }
    var_0 thread func_114D0();
    scripts\engine\utility::allow_weapon(1);
    return 1;
  }
}

func_114CE(var_0) {
  self setModel(level.tanksettings[self.tanktype].modelplacement);
  self setsentrycarrier(var_0);
  self setcontents(0);
  self setCanDamage(0);
  self.carriedby = var_0;
  var_0.iscarrying = 1;
  var_0 thread func_12F34(self);
  thread func_114C6(var_0);
  thread func_114C7(var_0);
  thread func_114C8();
  self notify("carried");
}

func_12F34(var_0) {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  var_0 endon("placed");
  var_0 endon("death");
  var_0.canbeplaced = 1;
  var_1 = -1;

  for(;;) {
    var_2 = self _meth_805E(25.0, 25.0, 50.0, 40.0, 80.0, 0.7);
    var_0.origin = var_2["origin"];
    var_0.angles = var_2["angles"];
    var_0.canbeplaced = self isonground() && var_2["result"] && abs(var_2["origin"][2] - self.origin[2]) < 20;

    if(var_0.canbeplaced != var_1) {
      if(var_0.canbeplaced) {
        var_0 setModel(level.tanksettings[var_0.tanktype].modelplacement);

        if(self.team != "spectator") {
          self forceusehinton(level.tanksettings[var_0.tanktype].var_1114D);
        }
      } else {
        var_0 setModel(level.tanksettings[var_0.tanktype].modelplacementfailed);

        if(self.team != "spectator") {
          self forceusehinton(level.tanksettings[var_0.tanktype].var_1114C);
        }
      }
    }

    var_1 = var_0.canbeplaced;
    wait 0.05;
  }
}

func_114C6(var_0) {
  self endon("placed");
  self endon("death");
  var_0 waittill("death");
  func_114CD();
}

func_114C7(var_0) {
  self endon("placed");
  self endon("death");
  var_0 waittill("disconnect");
  func_114CD();
}

func_114C8(var_0) {
  self endon("placed");
  self endon("death");
  level waittill("game_ended");
  func_114CD();
}

func_114CD() {
  if(isDefined(self.carriedby)) {
    self.carriedby getrigindexfromarchetyperef();
  }

  if(isDefined(self.owner)) {
    self.owner.iscarrying = 0;
  }

  if(isDefined(self)) {
    self delete();
  }
}

func_114D0() {
  self endon("death");
  level endon("game_ended");
  self notify("placed");
  self.carriedby getrigindexfromarchetyperef();
  self.carriedby = undefined;

  if(!isDefined(self.owner)) {
    return 0;
  }

  var_0 = self.owner;
  var_0.iscarrying = 0;
  var_1 = func_4A1F(self);

  if(!isDefined(var_1)) {
    return 0;
  }

  var_1 playSound("sentry_gun_plant");
  var_1 notify("placed");
  var_1 thread func_114CC();
  self delete();
}

func_114BB() {
  self endon("death");
  level endon("game_ended");

  if(!isDefined(self.owner)) {
    return;
  }
  var_0 = self.owner;
  var_0 endon("death");
  self waittill("placed");
  var_0 func_1146D(self.tanktype);
  var_0 scripts\mp\utility\game::_giveweapon(level.tanksettings[self.tanktype].var_A84D);
  var_0 scripts\mp\utility\game::_switchtoweaponimmediate(level.tanksettings[self.tanktype].var_A84D);
}

func_4A1F(var_0) {
  var_1 = var_0.owner;
  var_2 = var_0.tanktype;
  var_3 = var_0.lifeid;
  var_4 = spawnvehicle(level.tanksettings[var_2].modelbase, var_2, level.tanksettings[var_2].vehicleinfo, var_0.origin, var_0.angles, var_1);

  if(!isDefined(var_4)) {
    return undefined;
  }

  var_5 = var_4 gettagorigin("tag_turret_attach");
  var_6 = spawnturret("misc_turret", var_5, level.tanksettings[var_2].mgturretinfo, 0);
  var_6 linkto(var_4, "tag_turret_attach", (0, 0, 0), (0, 0, 0));
  var_6 setModel(level.tanksettings[var_2].var_B922);
  var_6.health = level.tanksettings[var_2].health;
  var_6.owner = var_1;
  var_6.angles = var_1.angles;
  var_6.var_10955 = ::func_3758;
  var_6.var_114B1 = var_4;
  var_6 makeunusable();
  var_6 setdefaultdroppitch(0);
  var_6 setCanDamage(0);
  var_4.var_10955 = ::func_3758;
  var_4.lifeid = var_3;
  var_4.team = var_1.team;
  var_4.owner = var_1;
  var_4 setotherent(var_1);
  var_4.mgturret = var_6;
  var_4.health = level.tanksettings[var_2].health;
  var_4.maxhealth = level.tanksettings[var_2].maxhealth;
  var_4.damagetaken = 0;
  var_4.var_52D0 = 0;
  var_4 setCanDamage(0);
  var_4.tanktype = var_2;
  var_4 scripts\mp\sentientpoolmanager::registersentient("Killstreak_Ground", var_1, 1);
  var_6 setturretmodechangewait(1);
  var_4 func_114CF();
  var_6 setsentryowner(var_1);
  var_1.using_remote_tank = 0;
  var_4.empgrenaded = 0;
  var_4.var_4D49 = 1.0;
  var_4 thread func_114C5();
  var_4 thread func_114D7();
  var_4 thread func_114BB();
  return var_4;
}

func_114CC() {
  self endon("death");
  self.owner endon("disconnect");
  level endon("game_ended");
  self makeunusable();
  self.mgturret getvalidlocation();
  self makevehiclesolidcapsule(23, 23, 23);

  if(!isDefined(self.owner)) {
    return;
  }
  var_0 = self.owner;
  var_1 = (0, 0, 20);

  if(level.teambased) {
    self.team = var_0.team;
    self.mgturret.team = var_0.team;
    self.mgturret setturretteam(var_0.team);

    foreach(var_3 in level.players) {
      if(var_3 != var_0 && var_3.team == var_0.team) {
        var_4 = self.mgturret scripts\mp\entityheadicons::setheadicon(var_3, scripts\mp\teams::_meth_81B0(self.team), var_1, 10, 10, 0, 0.05, 0, 1, 0, 1);

        if(isDefined(var_4)) {
          var_4 settargetent(self);
        }
      }
    }
  }

  thread func_114BF();
  thread func_114C0();
  thread func_114BC();
  thread func_114BE();
  thread func_114C1();
  thread func_114B2();
  thread func_114B3();
  func_10E09();
}

func_10E09() {
  var_0 = self.owner;
  var_0 scripts\mp\utility\game::setusingremote(self.tanktype);

  if(getdvarint("camera_thirdPerson")) {
    var_0 scripts\mp\utility\game::setthirdpersondof(0);
  }

  var_0.restoreangles = var_0.angles;
  var_0 scripts\mp\utility\game::freezecontrolswrapper(1);
  var_1 = var_0 scripts\mp\killstreaks\killstreaks::initridekillstreak("remote_tank");

  if(var_1 != "success") {
    if(var_1 != "disconnect") {
      var_0 scripts\mp\utility\game::clearusingremote();
    }

    if(isDefined(var_0.disabledweapon) && var_0.disabledweapon) {
      var_0 scripts\engine\utility::allow_weapon(1);
    }

    self notify("death");
    return 0;
  }

  var_0 scripts\mp\utility\game::freezecontrolswrapper(0);
  self.mgturret setCanDamage(1);
  self setCanDamage(1);
  var_2 = spawnStruct();
  var_2.playdeathfx = 1;
  var_2.deathoverridecallback = ::func_114C9;
  thread scripts\mp\movers::handle_moving_platforms(var_2);
  var_0 remotecontrolvehicle(self);
  var_0 remotecontrolturret(self.mgturret);
  var_0 thread tank_watchfiring(self);
  var_0 thread func_114B9(self);
  thread func_114B7();
  thread func_114CA();
  var_0.using_remote_tank = 1;
  var_0 scripts\mp\utility\game::_giveweapon(level.tanksettings[self.tanktype].remotedetonatethink);
  var_0 scripts\mp\utility\game::_switchtoweaponimmediate(level.tanksettings[self.tanktype].remotedetonatethink);
  thread func_114BD();
  self.mgturret thread func_114D5();
}

func_114B2() {
  self endon("death");

  for(;;) {
    playFXOnTag(scripts\engine\utility::getfx("remote_tank_antenna_light_mp"), self.mgturret, "tag_headlight_right");
    wait 1.0;
    stopFXOnTag(scripts\engine\utility::getfx("remote_tank_antenna_light_mp"), self.mgturret, "tag_headlight_right");
  }
}

func_114B3() {
  self endon("death");

  for(;;) {
    playFXOnTag(scripts\engine\utility::getfx("remote_tank_camera_light_mp"), self.mgturret, "tag_tail_light_right");
    wait 2.0;
    stopFXOnTag(scripts\engine\utility::getfx("remote_tank_camera_light_mp"), self.mgturret, "tag_tail_light_right");
  }
}

func_114CF() {
  self.mgturret give_player_session_tokens(level.tanksettings[self.tanktype].sentrymodeoff);

  if(level.teambased) {
    scripts\mp\entityheadicons::setteamheadicon("none", (0, 0, 0));
  } else if(isDefined(self.owner)) {
    scripts\mp\entityheadicons::setplayerheadicon(undefined, (0, 0, 0));
  }

  if(!isDefined(self.owner)) {
    return;
  }
  var_0 = self.owner;

  if(isDefined(var_0.using_remote_tank) && var_0.using_remote_tank) {
    var_0 notify("end_remote");
    var_0 remotecontrolvehicleoff(self);
    var_0 remotecontrolturretoff(self.mgturret);
    var_0 scripts\mp\utility\game::_switchtoweapon(var_0 scripts\engine\utility::getlastweapon());
    var_0 scripts\mp\utility\game::clearusingremote();
    var_0 setplayerangles(var_0.restoreangles);

    if(getdvarint("camera_thirdPerson")) {
      var_0 scripts\mp\utility\game::setthirdpersondof(1);
    }

    if(isDefined(var_0.disabledusability) && var_0.disabledusability) {
      var_0 scripts\engine\utility::allow_usability(1);
    }

    var_0 func_1146D(level.tanksettings[self.tanktype].streakname);
    var_0.using_remote_tank = 0;
    var_0 thread func_114BA();
  }
}

func_114BA() {
  self endon("disconnect");
  self endon("death");
  level endon("game_ended");
  scripts\mp\utility\game::freezecontrolswrapper(1);
  wait 0.5;
  scripts\mp\utility\game::freezecontrolswrapper(0);
}

func_114BF() {
  self endon("death");
  self.owner waittill("disconnect");

  if(isDefined(self.mgturret)) {
    self.mgturret notify("death");
  }

  self notify("death");
}

func_114C0() {
  self endon("death");
  self.owner waittill("stop_using_remote");
  self notify("death");
}

func_114BC() {
  self endon("death");
  self.owner scripts\engine\utility::waittill_any("joined_team", "joined_spectators");
  self notify("death");
}

func_114C1() {
  self endon("death");
  var_0 = level.tanksettings[self.tanktype].timeout;
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(var_0);
  self notify("death");
}

func_114C9(var_0) {
  self notify("death");
}

func_114BE() {
  level endon("game_ended");
  var_0 = self getentitynumber();
  addtougvlist(var_0);
  self waittill("death");
  self playSound("talon_destroyed");
  removefromugvlist(var_0);
  self setModel(level.tanksettings[self.tanktype].modeldestroyed);

  if(isDefined(self.owner) && (self.owner.using_remote_tank || self.owner scripts\mp\utility\game::isusingremote())) {
    func_114CF();
    self.owner.using_remote_tank = 0;
  }

  self.mgturret setdefaultdroppitch(40);
  self.mgturret setsentryowner(undefined);
  self playSound("sentry_explode");
  playFXOnTag(level._effect["remote_tank_dying"], self.mgturret, "tag_aim");
  wait 2.0;
  playFX(level._effect["remote_tank_explode"], self.origin);
  self.mgturret delete();
  scripts\mp\utility::decrementfauxvehiclecount();
  self delete();
}

func_3758(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11) {
  var_12 = self;

  if(isDefined(self.var_114B1)) {
    var_12 = self.var_114B1;
  }

  if(isDefined(var_12.var_1D41) && var_12.var_1D41) {
    return;
  }
  if(!scripts\mp\weapons::friendlyfirecheck(var_12.owner, var_1)) {
    return;
  }
  if(isDefined(var_3) && var_3 &level.idflags_penetration) {
    var_12.wasdamagedfrombulletpenetration = 1;
  }

  if(isDefined(var_3) && var_3 &level.idflags_no_team_protection) {
    var_12.wasdamagedfrombulletricochet = 1;
  }

  var_12.wasdamaged = 1;
  var_12.var_4D49 = 0.0;
  playfxontagforclients(level._effect["remote_tank_spark"], var_12, "tag_player", var_12.owner);

  if(isDefined(var_5)) {
    switch (var_5) {
      case "stealth_bomb_mp":
      case "artillery_mp":
        var_2 = var_2 * 4;
        break;
    }
  }

  if(var_4 == "MOD_MELEE") {
    var_2 = var_12.maxhealth * 0.5;
  }

  var_13 = var_2;

  if(isplayer(var_1)) {
    var_1 scripts\mp\damagefeedback::updatedamagefeedback("remote_tank");

    if(var_4 == "MOD_RIFLE_BULLET" || var_4 == "MOD_PISTOL_BULLET") {
      if(var_1 scripts\mp\utility\game::_hasperk("specialty_armorpiercing")) {
        var_13 = var_13 + var_2 * level.armorpiercingmod;
      }
    }

    if(isexplosivedamagemod(var_4)) {
      var_13 = var_13 + var_2;
    }
  }

  if(isexplosivedamagemod(var_4) && (isDefined(var_5) && var_5 == "destructible_car")) {
    var_13 = var_12.maxhealth;
  }

  if(isDefined(var_1.owner) && isplayer(var_1.owner)) {
    var_1.owner scripts\mp\damagefeedback::updatedamagefeedback("remote_tank");
  }

  if(isDefined(var_5)) {
    switch (var_5) {
      case "remotemissile_projectile_mp":
      case "javelin_mp":
      case "remote_mortar_missile_mp":
      case "stinger_mp":
      case "ac130_40mm_mp":
      case "ac130_105mm_mp":
        var_12.largeprojectiledamage = 1;
        var_13 = var_12.maxhealth + 1;
        break;
      case "stealth_bomb_mp":
      case "artillery_mp":
        var_12.largeprojectiledamage = 0;
        var_13 = var_12.maxhealth * 0.5;
        break;
      case "bomb_site_mp":
        var_12.largeprojectiledamage = 0;
        var_13 = var_12.maxhealth + 1;
        break;
      case "emp_grenade_mp":
        var_13 = 0;
        var_12 thread func_114B8();
        break;
      case "ims_projectile_mp":
        var_12.largeprojectiledamage = 1;
        var_13 = var_12.maxhealth * 0.5;
        break;
    }

    scripts\mp\killstreaks\killstreaks::killstreakhit(var_1, var_5, self);
  }

  var_12.damagetaken = var_12.damagetaken + var_13;
  var_12 playSound("talon_damaged");

  if(var_12.damagetaken >= var_12.maxhealth) {
    if(isplayer(var_1) && (!isDefined(var_12.owner) || var_1 != var_12.owner)) {
      var_12.var_1D41 = 1;
      var_1 notify("destroyed_killstreak", var_5);
      thread scripts\mp\utility\game::teamplayercardsplash("callout_destroyed_remote_tank", var_1);
      var_1 thread scripts\mp\utility\game::giveunifiedpoints("kill", var_5, 300);
    }

    var_12 notify("death");
  }
}

func_114B8() {
  self notify("tank_EMPGrenaded");
  self endon("tank_EMPGrenaded");
  self endon("death");
  self.owner endon("disconnect");
  level endon("game_ended");
  self.empgrenaded = 1;
  self.mgturret turretfiredisable();
  wait 3.5;
  self.empgrenaded = 0;
  self.mgturret turretfireenable();
}

func_114C5() {
  self endon("death");
  level endon("game_ended");
  var_0 = 0;

  for(;;) {
    if(!self.empgrenaded) {
      if(self.var_4D49 < 1.0) {
        self.var_4D49 = self.var_4D49 + 0.1;
        var_0 = 1;
      } else if(var_0) {
        self.var_4D49 = 1.0;
        var_0 = 0;
      }
    }

    wait 0.1;
  }
}

func_114D7() {
  self endon("death");
  level endon("game_ended");
  var_0 = 0.1;
  var_1 = 1;
  var_2 = 1;

  for(;;) {
    if(var_2) {
      if(self.damagetaken > 0) {
        var_2 = 0;
        var_1++;
      }
    } else if(self.damagetaken >= self.maxhealth * (var_0 * var_1))
      var_1++;

    wait 0.05;
  }
}

func_114BD() {
  self endon("death");
  level endon("game_ended");

  for(;;) {
    self waittill("damage", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);

    if(isDefined(self.var_10955)) {
      self[[self.var_10955]](undefined, var_1, var_0, var_8, var_4, var_9, var_3, var_2, undefined, undefined, var_5, var_7);
    }
  }
}

func_114D5() {
  self endon("death");
  level endon("game_ended");

  for(;;) {
    self waittill("damage", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);

    if(isDefined(self.var_10955) && isDefined(self.var_114B1) && (!isexplosivedamagemod(var_4) || isDefined(var_9) && isexplosivedamagemod(var_4) && (var_9 == "stealth_bomb_mp" || var_9 == "artillery_mp"))) {
      self.var_114B1[[self.var_10955]](undefined, var_1, var_0, var_8, var_4, var_9, var_3, var_2, undefined, undefined, var_5, var_7);
    }
  }
}

tank_watchfiring(var_0) {
  self endon("disconnect");
  self endon("end_remote");
  var_0 endon("death");
  var_1 = 50;
  var_2 = var_1;
  var_3 = weaponfiretime(level.tanksettings[var_0.tanktype].mgturretinfo);

  for(;;) {
    if(var_0.mgturret isfiringvehicleturret()) {
      var_2--;

      if(var_2 <= 0) {
        var_0.mgturret turretfiredisable();
        wait 2.5;
        var_0 playSound("talon_reload");
        self playlocalsound("talon_reload_plr");
        var_2 = var_1;
        var_0.mgturret turretfireenable();
      }
    }

    wait(var_3);
  }
}

func_114B9(var_0) {
  self endon("disconnect");
  self endon("end_remote");
  level endon("game_ended");
  var_0 endon("death");
  var_1 = 0;

  for(;;) {
    if(self fragbuttonpressed() && !var_0.empgrenaded) {
      var_2 = var_0.mgturret.origin;
      var_3 = var_0.mgturret.angles;

      switch (var_1) {
        case 0:
          var_2 = var_0.mgturret gettagorigin("tag_missile1");
          var_3 = var_0.mgturret gettagangles("tag_player");
          break;
        case 1:
          var_2 = var_0.mgturret gettagorigin("tag_missile2");
          var_3 = var_0.mgturret gettagangles("tag_player");
          break;
      }

      var_0 playSound("talon_missile_fire");
      self playlocalsound("talon_missile_fire_plr");
      var_4 = var_2 + anglesToForward(var_3) * 100;
      var_5 = scripts\mp\utility\game::_magicbullet(level.tanksettings[var_0.tanktype].var_B88D, var_2, var_4, self);
      var_1 = (var_1 + 1) % 2;
      wait 5.0;
      var_0 playSound("talon_rocket_reload");
      self playlocalsound("talon_rocket_reload_plr");
      continue;
    }

    wait 0.05;
  }
}

func_114B6(var_0) {
  self endon("disconnect");
  self endon("end_remote");
  level endon("game_ended");
  var_0 endon("death");

  for(;;) {
    if(self secondaryoffhandbuttonpressed()) {
      var_1 = bulletTrace(var_0.origin + (0, 0, 4), var_0.origin - (0, 0, 4), 0, var_0);
      var_2 = vectornormalize(var_1["normal"]);
      var_3 = vectortoangles(var_2);
      var_3 = var_3 + (90, 0, 0);
      var_4 = scripts\mp\weapons::spawnmine(var_0.origin, self, "equipment", var_3);
      var_0 playSound("item_blast_shield_on");
      wait 8.0;
      continue;
    }

    wait 0.05;
  }
}

func_114B7() {
  self endon("death");
  self.owner endon("end_remote");

  for(;;) {
    earthquake(0.1, 0.25, self.mgturret gettagorigin("tag_player"), 50);
    wait 0.25;
  }
}

addtougvlist(var_0) {
  level.ugvs[var_0] = self;
}

removefromugvlist(var_0) {
  level.ugvs[var_0] = undefined;
}

func_114CA() {
  if(!isDefined(self.owner)) {
    return;
  }
  var_0 = self.owner;
  level endon("game_ended");
  var_0 endon("disconnect");
  var_0 endon("end_remote");
  self endon("death");

  for(;;) {
    var_1 = 0;

    while(var_0 usebuttonpressed()) {
      var_1 = var_1 + 0.05;

      if(var_1 > 0.75) {
        self notify("death");
        return;
      }

      wait 0.05;
    }

    wait 0.05;
  }
}