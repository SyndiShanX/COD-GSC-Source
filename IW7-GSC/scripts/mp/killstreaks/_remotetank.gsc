/**************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\mp\killstreaks\_remotetank.gsc
**************************************************/

init() {
  scripts\mp\killstreaks\_killstreaks::registerkillstreak("remote_tank", ::func_128FE);
  level.tanksettings = [];
  level.tanksettings["remote_tank"] = spawnStruct();
  level.tanksettings["remote_tank"].timeout = 60;
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

func_128FE(param_00, param_01) {
  var_02 = 1;
  if(scripts\mp\utility::currentactivevehiclecount() >= scripts\mp\utility::maxvehiclesallowed() || level.fauxvehiclecount + var_02 >= scripts\mp\utility::maxvehiclesallowed()) {
    self iprintlnbold(&"KILLSTREAKS_TOO_MANY_VEHICLES");
    return 0;
  }

  scripts\mp\utility::incrementfauxvehiclecount();
  var_03 = _meth_83AC(param_00, "remote_tank");
  if(var_03) {
    scripts\mp\matchdata::logkillstreakevent("remote_tank", self.origin);
    thread scripts\mp\utility::teamplayercardsplash("used_remote_tank", self);
    func_1146D("remote_tank");
  } else {
    scripts\mp\utility::decrementfauxvehiclecount();
  }

  self.iscarrying = 0;
  return var_03;
}

func_1146D(param_00) {
  var_01 = scripts\mp\utility::getkillstreakweapon(level.tanksettings[param_00].streakname);
  scripts\mp\killstreaks\_killstreaks::func_1146C(var_01);
  scripts\mp\utility::_takeweapon(level.tanksettings[param_00].var_A84D);
  scripts\mp\utility::_takeweapon(level.tanksettings[param_00].remotedetonatethink);
}

removeperks() {
  if(scripts\mp\utility::_hasperk("specialty_explosivebullets")) {
    self.restoreperk = "specialty_explosivebullets";
    scripts\mp\utility::removeperk("specialty_explosivebullets");
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

removeweapons() {
  var_00 = self getweaponslistprimaries();
  foreach(var_02 in var_00) {
    var_03 = strtok(var_02, "_");
    if(var_03[0] == "alt") {
      self.restoreweaponclipammo[var_02] = self getweaponammoclip(var_02);
      self.var_E2E9[var_02] = self getweaponammostock(var_02);
      continue;
    }

    self.restoreweaponclipammo[var_02] = self getweaponammoclip(var_02);
    self.var_E2E9[var_02] = self getweaponammostock(var_02);
  }

  self.var_13CD2 = [];
  foreach(var_02 in var_00) {
    var_03 = strtok(var_02, "_");
    self.var_13CD2[self.var_13CD2.size] = var_02;
    if(var_03[0] == "alt") {
      continue;
    }

    scripts\mp\utility::_takeweapon(var_02);
  }
}

restoreweapons() {
  if(!isDefined(self.restoreweaponclipammo) || !isDefined(self.var_E2E9) || !isDefined(self.var_13CD2)) {
    return;
  }

  var_00 = [];
  foreach(var_02 in self.var_13CD2) {
    var_03 = strtok(var_02, "_");
    if(var_03[0] == "alt") {
      var_00[var_00.size] = var_02;
      continue;
    }

    scripts\mp\utility::_giveweapon(var_02);
    if(isDefined(self.restoreweaponclipammo[var_02])) {
      self setweaponammoclip(var_02, self.restoreweaponclipammo[var_02]);
    }

    if(isDefined(self.var_E2E9[var_02])) {
      self setweaponammostock(var_02, self.var_E2E9[var_02]);
    }
  }

  foreach(var_06 in var_00) {
    if(isDefined(self.restoreweaponclipammo[var_06])) {
      self setweaponammoclip(var_06, self.restoreweaponclipammo[var_06]);
    }

    if(isDefined(self.var_E2E9[var_06])) {
      self setweaponammostock(var_06, self.var_E2E9[var_06]);
    }
  }

  self.restoreweaponclipammo = undefined;
  self.var_E2E9 = undefined;
}

func_13710() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  wait(0.05);
  restoreweapons();
}

_meth_83AC(param_00, param_01) {
  var_02 = func_4A20(param_01, self);
  var_02.lifeid = param_00;
  removeperks();
  removeweapons();
  var_03 = func_F689(var_02, 1);
  thread restoreperks();
  thread restoreweapons();
  if(!isDefined(var_03)) {
    var_03 = 0;
  }

  return var_03;
}

func_4A20(param_00, param_01) {
  var_02 = spawnturret("misc_turret", param_01.origin + (0, 0, 25), level.tanksettings[param_00].mgturretinfo);
  var_02.angles = param_01.angles;
  var_02.tanktype = param_00;
  var_02.triggerportableradarping = param_01;
  var_02 setModel(level.tanksettings[param_00].modelbase);
  var_02 getvalidattachments();
  var_02 setturretmodechangewait(1);
  var_02 give_player_session_tokens("sentry_offline");
  var_02 makeunusable();
  var_02 setsentryowner(param_01);
  return var_02;
}

func_F689(param_00, param_01) {
  self endon("death");
  self endon("disconnect");
  param_00 thread func_114CE(self);
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
    var_02 = scripts\engine\utility::waittill_any_return("place_tank", "cancel_tank", "force_cancel_placement");
    if(var_02 == "cancel_tank" || var_02 == "force_cancel_placement") {
      if(!param_01 && var_02 == "cancel_tank") {
        continue;
      }

      if(level.console) {
        var_03 = scripts\mp\utility::getkillstreakweapon(level.tanksettings[param_00.tanktype].streakname);
        if(isDefined(self.var_A6A1) && var_03 == scripts\mp\utility::getkillstreakweapon(self.pers["killstreaks"][self.var_A6A1].streakname) && !self getweaponslistitems().size) {
          scripts\mp\utility::_giveweapon(var_03, 0);
          scripts\mp\utility::_setactionslot(4, "weapon", var_03);
        }
      }

      param_00 func_114CD();
      scripts\engine\utility::allow_weapon(1);
      return 0;
    }

    if(!param_00.canbeplaced) {
      continue;
    }

    param_00 thread func_114D0();
    scripts\engine\utility::allow_weapon(1);
    return 1;
  }
}

func_114CE(param_00) {
  self setModel(level.tanksettings[self.tanktype].modelplacement);
  self setsentrycarrier(param_00);
  self setcontents(0);
  self setCanDamage(0);
  self.carriedby = param_00;
  param_00.iscarrying = 1;
  param_00 thread func_12F34(self);
  thread func_114C6(param_00);
  thread func_114C7(param_00);
  thread func_114C8();
  self notify("carried");
}

func_12F34(param_00) {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  param_00 endon("placed");
  param_00 endon("death");
  param_00.canbeplaced = 1;
  var_01 = -1;
  for(;;) {
    var_02 = self canplayerplacetank(25, 25, 50, 40, 80, 0.7);
    param_00.origin = var_02["origin"];
    param_00.angles = var_02["angles"];
    param_00.canbeplaced = self isonground() && var_02["result"] && abs(var_02["origin"][2] - self.origin[2]) < 20;
    if(param_00.canbeplaced != var_01) {
      if(param_00.canbeplaced) {
        param_00 setModel(level.tanksettings[param_00.tanktype].modelplacement);
        if(self.team != "spectator") {
          self forceusehinton(level.tanksettings[param_00.tanktype].var_1114D);
        }
      } else {
        param_00 setModel(level.tanksettings[param_00.tanktype].modelplacementfailed);
        if(self.team != "spectator") {
          self forceusehinton(level.tanksettings[param_00.tanktype].var_1114C);
        }
      }
    }

    var_01 = param_00.canbeplaced;
    wait(0.05);
  }
}

func_114C6(param_00) {
  self endon("placed");
  self endon("death");
  param_00 waittill("death");
  func_114CD();
}

func_114C7(param_00) {
  self endon("placed");
  self endon("death");
  param_00 waittill("disconnect");
  func_114CD();
}

func_114C8(param_00) {
  self endon("placed");
  self endon("death");
  level waittill("game_ended");
  func_114CD();
}

func_114CD() {
  if(isDefined(self.carriedby)) {
    self.carriedby getrigindexfromarchetyperef();
  }

  if(isDefined(self.triggerportableradarping)) {
    self.triggerportableradarping.iscarrying = 0;
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
  if(!isDefined(self.triggerportableradarping)) {
    return 0;
  }

  var_00 = self.triggerportableradarping;
  var_00.iscarrying = 0;
  var_01 = func_4A1F(self);
  if(!isDefined(var_01)) {
    return 0;
  }

  var_01 playSound("sentry_gun_plant");
  var_01 notify("placed");
  var_01 thread func_114CC();
  self delete();
}

func_114BB() {
  self endon("death");
  level endon("game_ended");
  if(!isDefined(self.triggerportableradarping)) {
    return;
  }

  var_00 = self.triggerportableradarping;
  var_00 endon("death");
  self waittill("placed");
  var_00 func_1146D(self.tanktype);
  var_00 scripts\mp\utility::_giveweapon(level.tanksettings[self.tanktype].var_A84D);
  var_00 scripts\mp\utility::_switchtoweaponimmediate(level.tanksettings[self.tanktype].var_A84D);
}

func_4A1F(param_00) {
  var_01 = param_00.triggerportableradarping;
  var_02 = param_00.tanktype;
  var_03 = param_00.lifeid;
  var_04 = spawnvehicle(level.tanksettings[var_02].modelbase, var_02, level.tanksettings[var_02].vehicleinfo, param_00.origin, param_00.angles, var_01);
  if(!isDefined(var_04)) {
    return undefined;
  }

  var_05 = var_04 gettagorigin("tag_turret_attach");
  var_06 = spawnturret("misc_turret", var_05, level.tanksettings[var_02].mgturretinfo, 0);
  var_06 linkto(var_04, "tag_turret_attach", (0, 0, 0), (0, 0, 0));
  var_06 setModel(level.tanksettings[var_02].var_B922);
  var_06.health = level.tanksettings[var_02].health;
  var_06.triggerportableradarping = var_01;
  var_06.angles = var_01.angles;
  var_06.var_10955 = ::func_3758;
  var_06.var_114B1 = var_04;
  var_06 makeunusable();
  var_06 setdefaultdroppitch(0);
  var_06 setCanDamage(0);
  var_04.var_10955 = ::func_3758;
  var_04.lifeid = var_03;
  var_04.team = var_01.team;
  var_04.triggerportableradarping = var_01;
  var_04 setotherent(var_01);
  var_04.mgturret = var_06;
  var_04.health = level.tanksettings[var_02].health;
  var_04.maxhealth = level.tanksettings[var_02].maxhealth;
  var_04.var_E1 = 0;
  var_04.var_52D0 = 0;
  var_04 setCanDamage(0);
  var_04.tanktype = var_02;
  var_04 scripts\mp\sentientpoolmanager::registersentient("Killstreak_Ground", var_01, 1);
  var_06 setturretmodechangewait(1);
  var_04 func_114CF();
  var_06 setsentryowner(var_01);
  var_01.using_remote_tank = 0;
  var_04.empgrenaded = 0;
  var_04.var_4D49 = 1;
  var_04 thread func_114C5();
  var_04 thread func_114D7();
  var_04 thread func_114BB();
  return var_04;
}

func_114CC() {
  self endon("death");
  self.triggerportableradarping endon("disconnect");
  level endon("game_ended");
  self makeunusable();
  self.mgturret getvalidlocation();
  self makevehiclesolidcapsule(23, 23, 23);
  if(!isDefined(self.triggerportableradarping)) {
    return;
  }

  var_00 = self.triggerportableradarping;
  var_01 = (0, 0, 20);
  if(level.teambased) {
    self.team = var_00.team;
    self.mgturret.team = var_00.team;
    self.mgturret setturretteam(var_00.team);
    foreach(var_03 in level.players) {
      if(var_03 != var_00 && var_03.team == var_00.team) {
        var_04 = self.mgturret scripts\mp\entityheadicons::setheadicon(var_03, scripts\mp\teams::_meth_81B0(self.team), var_01, 10, 10, 0, 0.05, 0, 1, 0, 1);
        if(isDefined(var_04)) {
          var_04 settargetent(self);
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
  var_00 = self.triggerportableradarping;
  var_00 scripts\mp\utility::setusingremote(self.tanktype);
  if(getdvarint("camera_thirdPerson")) {
    var_00 scripts\mp\utility::setthirdpersondof(0);
  }

  var_00.restoreangles = var_00.angles;
  var_00 scripts\mp\utility::freezecontrolswrapper(1);
  var_01 = var_00 scripts\mp\killstreaks\_killstreaks::initridekillstreak("remote_tank");
  if(var_01 != "success") {
    if(var_01 != "disconnect") {
      var_00 scripts\mp\utility::clearusingremote();
    }

    if(isDefined(var_00.disabledweapon) && var_00.disabledweapon) {
      var_00 scripts\engine\utility::allow_weapon(1);
    }

    self notify("death");
    return 0;
  }

  var_00 scripts\mp\utility::freezecontrolswrapper(0);
  self.mgturret setCanDamage(1);
  self setCanDamage(1);
  var_02 = spawnStruct();
  var_02.playdeathfx = 1;
  var_02.deathoverridecallback = ::func_114C9;
  thread scripts\mp\movers::handle_moving_platforms(var_02);
  var_00 remotecontrolvehicle(self);
  var_00 remotecontrolturret(self.mgturret);
  var_00 thread tank_watchfiring(self);
  var_00 thread func_114B9(self);
  thread func_114B7();
  thread func_114CA();
  var_00.using_remote_tank = 1;
  var_00 scripts\mp\utility::_giveweapon(level.tanksettings[self.tanktype].remotedetonatethink);
  var_00 scripts\mp\utility::_switchtoweaponimmediate(level.tanksettings[self.tanktype].remotedetonatethink);
  thread func_114BD();
  self.mgturret thread func_114D5();
}

func_114B2() {
  self endon("death");
  for(;;) {
    playFXOnTag(scripts\engine\utility::getfx("remote_tank_antenna_light_mp"), self.mgturret, "tag_headlight_right");
    wait(1);
    stopFXOnTag(scripts\engine\utility::getfx("remote_tank_antenna_light_mp"), self.mgturret, "tag_headlight_right");
  }
}

func_114B3() {
  self endon("death");
  for(;;) {
    playFXOnTag(scripts\engine\utility::getfx("remote_tank_camera_light_mp"), self.mgturret, "tag_tail_light_right");
    wait(2);
    stopFXOnTag(scripts\engine\utility::getfx("remote_tank_camera_light_mp"), self.mgturret, "tag_tail_light_right");
  }
}

func_114CF() {
  self.mgturret give_player_session_tokens(level.tanksettings[self.tanktype].sentrymodeoff);
  if(level.teambased) {
    scripts\mp\entityheadicons::setteamheadicon("none", (0, 0, 0));
  } else if(isDefined(self.triggerportableradarping)) {
    scripts\mp\entityheadicons::setplayerheadicon(undefined, (0, 0, 0));
  }

  if(!isDefined(self.triggerportableradarping)) {
    return;
  }

  var_00 = self.triggerportableradarping;
  if(isDefined(var_00.using_remote_tank) && var_00.using_remote_tank) {
    var_00 notify("end_remote");
    var_00 remotecontrolvehicleoff(self);
    var_00 geysers_and_boatride(self.mgturret);
    var_00 scripts\mp\utility::_switchtoweapon(var_00 scripts\engine\utility::getlastweapon());
    var_00 scripts\mp\utility::clearusingremote();
    var_00 setplayerangles(var_00.restoreangles);
    if(getdvarint("camera_thirdPerson")) {
      var_00 scripts\mp\utility::setthirdpersondof(1);
    }

    if(isDefined(var_00.disabledusability) && var_00.disabledusability) {
      var_00 scripts\engine\utility::allow_usability(1);
    }

    var_00 func_1146D(level.tanksettings[self.tanktype].streakname);
    var_00.using_remote_tank = 0;
    var_00 thread func_114BA();
  }
}

func_114BA() {
  self endon("disconnect");
  self endon("death");
  level endon("game_ended");
  scripts\mp\utility::freezecontrolswrapper(1);
  wait(0.5);
  scripts\mp\utility::freezecontrolswrapper(0);
}

func_114BF() {
  self endon("death");
  self.triggerportableradarping waittill("disconnect");
  if(isDefined(self.mgturret)) {
    self.mgturret notify("death");
  }

  self notify("death");
}

func_114C0() {
  self endon("death");
  self.triggerportableradarping waittill("stop_using_remote");
  self notify("death");
}

func_114BC() {
  self endon("death");
  self.triggerportableradarping scripts\engine\utility::waittill_any_3("joined_team", "joined_spectators");
  self notify("death");
}

func_114C1() {
  self endon("death");
  var_00 = level.tanksettings[self.tanktype].timeout;
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(var_00);
  self notify("death");
}

func_114C9(param_00) {
  self notify("death");
}

func_114BE() {
  level endon("game_ended");
  var_00 = self getentitynumber();
  addtougvlist(var_00);
  self waittill("death");
  self playSound("talon_destroyed");
  removefromugvlist(var_00);
  self setModel(level.tanksettings[self.tanktype].modeldestroyed);
  if(isDefined(self.triggerportableradarping) && self.triggerportableradarping.using_remote_tank || self.triggerportableradarping scripts\mp\utility::isusingremote()) {
    func_114CF();
    self.triggerportableradarping.using_remote_tank = 0;
  }

  self.mgturret setdefaultdroppitch(40);
  self.mgturret setsentryowner(undefined);
  self playSound("sentry_explode");
  playFXOnTag(level._effect["remote_tank_dying"], self.mgturret, "tag_aim");
  wait(2);
  playFX(level._effect["remote_tank_explode"], self.origin);
  self.mgturret delete();
  scripts\mp\utility::decrementfauxvehiclecount();
  self delete();
}

func_3758(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A, param_0B) {
  var_0C = self;
  if(isDefined(self.var_114B1)) {
    var_0C = self.var_114B1;
  }

  if(isDefined(var_0C.var_1D41) && var_0C.var_1D41) {
    return;
  }

  if(!scripts\mp\weapons::friendlyfirecheck(var_0C.triggerportableradarping, param_01)) {
    return;
  }

  if(isDefined(param_03) && param_03 &level.idflags_penetration) {
    var_0C.wasdamagedfrombulletpenetration = 1;
  }

  if(isDefined(param_03) && param_03 &level.idflags_ricochet) {
    var_0C.wasdamagedfrombulletricochet = 1;
  }

  var_0C.wasdamaged = 1;
  var_0C.var_4D49 = 0;
  playfxontagforclients(level._effect["remote_tank_spark"], var_0C, "tag_player", var_0C.triggerportableradarping);
  if(isDefined(param_05)) {
    switch (param_05) {
      case "stealth_bomb_mp":
      case "artillery_mp":
        param_02 = param_02 * 4;
        break;
    }
  }

  if(param_04 == "MOD_MELEE") {
    param_02 = var_0C.maxhealth * 0.5;
  }

  var_0D = param_02;
  if(isplayer(param_01)) {
    param_01 scripts\mp\damagefeedback::updatedamagefeedback("remote_tank");
    if(param_04 == "MOD_RIFLE_BULLET" || param_04 == "MOD_PISTOL_BULLET") {
      if(param_01 scripts\mp\utility::_hasperk("specialty_armorpiercing")) {
        var_0D = var_0D + param_02 * level.armorpiercingmod;
      }
    }

    if(isexplosivedamagemod(param_04)) {
      var_0D = var_0D + param_02;
    }
  }

  if(isexplosivedamagemod(param_04) && isDefined(param_05) && param_05 == "destructible_car") {
    var_0D = var_0C.maxhealth;
  }

  if(isDefined(param_01.triggerportableradarping) && isplayer(param_01.triggerportableradarping)) {
    param_01.triggerportableradarping scripts\mp\damagefeedback::updatedamagefeedback("remote_tank");
  }

  if(isDefined(param_05)) {
    switch (param_05) {
      case "remotemissile_projectile_mp":
      case "javelin_mp":
      case "remote_mortar_missile_mp":
      case "stinger_mp":
      case "ac130_40mm_mp":
      case "ac130_105mm_mp":
        var_0C.largeprojectiledamage = 1;
        var_0D = var_0C.maxhealth + 1;
        break;

      case "stealth_bomb_mp":
      case "artillery_mp":
        var_0C.largeprojectiledamage = 0;
        var_0D = var_0C.maxhealth * 0.5;
        break;

      case "bomb_site_mp":
        var_0C.largeprojectiledamage = 0;
        var_0D = var_0C.maxhealth + 1;
        break;

      case "emp_grenade_mp":
        var_0D = 0;
        var_0C thread func_114B8();
        break;

      case "ims_projectile_mp":
        var_0C.largeprojectiledamage = 1;
        var_0D = var_0C.maxhealth * 0.5;
        break;
    }

    scripts\mp\killstreaks\_killstreaks::killstreakhit(param_01, param_05, self);
  }

  var_0C.var_E1 = var_0C.var_E1 + var_0D;
  var_0C playSound("talon_damaged");
  if(var_0C.var_E1 >= var_0C.maxhealth) {
    if(isplayer(param_01) && !isDefined(var_0C.triggerportableradarping) || param_01 != var_0C.triggerportableradarping) {
      var_0C.var_1D41 = 1;
      param_01 notify("destroyed_killstreak", param_05);
      thread scripts\mp\utility::teamplayercardsplash("callout_destroyed_remote_tank", param_01);
      param_01 thread scripts\mp\utility::giveunifiedpoints("kill", param_05, 300);
    }

    var_0C notify("death");
  }
}

func_114B8() {
  self notify("tank_EMPGrenaded");
  self endon("tank_EMPGrenaded");
  self endon("death");
  self.triggerportableradarping endon("disconnect");
  level endon("game_ended");
  self.empgrenaded = 1;
  self.mgturret turretfiredisable();
  wait(3.5);
  self.empgrenaded = 0;
  self.mgturret turretfireenable();
}

func_114C5() {
  self endon("death");
  level endon("game_ended");
  var_00 = 0;
  for(;;) {
    if(!self.empgrenaded) {
      if(self.var_4D49 < 1) {
        self.var_4D49 = self.var_4D49 + 0.1;
        var_00 = 1;
      } else if(var_00) {
        self.var_4D49 = 1;
        var_00 = 0;
      }
    }

    wait(0.1);
  }
}

func_114D7() {
  self endon("death");
  level endon("game_ended");
  var_00 = 0.1;
  var_01 = 1;
  var_02 = 1;
  for(;;) {
    if(var_02) {
      if(self.var_E1 > 0) {
        var_02 = 0;
        var_01++;
      }
    } else if(self.var_E1 >= self.maxhealth * var_00 * var_01) {
      var_01++;
    }

    wait(0.05);
  }
}

func_114BD() {
  self endon("death");
  level endon("game_ended");
  for(;;) {
    self waittill("damage", var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09);
    if(isDefined(self.var_10955)) {
      self[[self.var_10955]](undefined, var_01, var_00, var_08, var_04, var_09, var_03, var_02, undefined, undefined, var_05, var_07);
    }
  }
}

func_114D5() {
  self endon("death");
  level endon("game_ended");
  for(;;) {
    self waittill("damage", var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09);
    if(isDefined(self.var_10955) && isDefined(self.var_114B1) && !isexplosivedamagemod(var_04) || isDefined(var_09) && isexplosivedamagemod(var_04) && var_09 == "stealth_bomb_mp" || var_09 == "artillery_mp") {
      self.var_114B1[[self.var_10955]](undefined, var_01, var_00, var_08, var_04, var_09, var_03, var_02, undefined, undefined, var_05, var_07);
    }
  }
}

tank_watchfiring(param_00) {
  self endon("disconnect");
  self endon("end_remote");
  param_00 endon("death");
  var_01 = 50;
  var_02 = var_01;
  var_03 = weaponfiretime(level.tanksettings[param_00.tanktype].mgturretinfo);
  for(;;) {
    if(param_00.mgturret isfiringvehicleturret()) {
      var_02--;
      if(var_02 <= 0) {
        param_00.mgturret turretfiredisable();
        wait(2.5);
        param_00 playSound("talon_reload");
        self playlocalsound("talon_reload_plr");
        var_02 = var_01;
        param_00.mgturret turretfireenable();
      }
    }

    wait(var_03);
  }
}

func_114B9(param_00) {
  self endon("disconnect");
  self endon("end_remote");
  level endon("game_ended");
  param_00 endon("death");
  var_01 = 0;
  for(;;) {
    if(self fragbuttonpressed() && !param_00.empgrenaded) {
      var_02 = param_00.mgturret.origin;
      var_03 = param_00.mgturret.angles;
      switch (var_01) {
        case 0:
          var_02 = param_00.mgturret gettagorigin("tag_missile1");
          var_03 = param_00.mgturret gettagangles("tag_player");
          break;

        case 1:
          var_02 = param_00.mgturret gettagorigin("tag_missile2");
          var_03 = param_00.mgturret gettagangles("tag_player");
          break;
      }

      param_00 playSound("talon_missile_fire");
      self playlocalsound("talon_missile_fire_plr");
      var_04 = var_02 + anglesToForward(var_03) * 100;
      var_05 = scripts\mp\utility::_magicbullet(level.tanksettings[param_00.tanktype].var_B88D, var_02, var_04, self);
      var_01 = var_01 + 1 % 2;
      wait(5);
      param_00 playSound("talon_rocket_reload");
      self playlocalsound("talon_rocket_reload_plr");
      continue;
    }

    wait(0.05);
  }
}

func_114B6(param_00) {
  self endon("disconnect");
  self endon("end_remote");
  level endon("game_ended");
  param_00 endon("death");
  for(;;) {
    if(self secondaryoffhandbuttonpressed()) {
      var_01 = bulletTrace(param_00.origin + (0, 0, 4), param_00.origin - (0, 0, 4), 0, param_00);
      var_02 = vectornormalize(var_01["normal"]);
      var_03 = vectortoangles(var_02);
      var_03 = var_03 + (90, 0, 0);
      var_04 = scripts\mp\weapons::spawnmine(param_00.origin, self, "equipment", var_03);
      param_00 playSound("item_blast_shield_on");
      wait(8);
      continue;
    }

    wait(0.05);
  }
}

func_114B7() {
  self endon("death");
  self.triggerportableradarping endon("end_remote");
  for(;;) {
    earthquake(0.1, 0.25, self.mgturret gettagorigin("tag_player"), 50);
    wait(0.25);
  }
}

addtougvlist(param_00) {
  level.ugvs[param_00] = self;
}

removefromugvlist(param_00) {
  level.ugvs[param_00] = undefined;
}

func_114CA() {
  if(!isDefined(self.triggerportableradarping)) {
    return;
  }

  var_00 = self.triggerportableradarping;
  level endon("game_ended");
  var_00 endon("disconnect");
  var_00 endon("end_remote");
  self endon("death");
  for(;;) {
    var_01 = 0;
    while(var_00 usebuttonpressed()) {
      var_01 = var_01 + 0.05;
      if(var_01 > 0.75) {
        self notify("death");
        return;
      }

      wait(0.05);
    }

    wait(0.05);
  }
}