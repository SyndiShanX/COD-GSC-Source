/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3516.gsc
***************************************/

init() {
  scripts\mp\killstreaks\killstreaks::registerkillstreak("remote_tank", ::func_128FE);
  level.tanksettings = [];
  level.tanksettings["remote_tank"] = spawnStruct();
  level.tanksettings["remote_tank"].timeout = 60.0;
  level.tanksettings["remote_tank"].health = 99999;
  level.tanksettings["remote_tank"].maxhealth = 1000;
  level.tanksettings["remote_tank"].streakname = "remote_tank";
  level.tanksettings["remote_tank"].mgturretinfo = "ugv_turret_mp";
  level.tanksettings["remote_tank"].func_B88D = "remote_tank_projectile_mp";
  level.tanksettings["remote_tank"].sentrymodeoff = "sentry_offline";
  level.tanksettings["remote_tank"].vehicleinfo = "remote_ugv_mp";
  level.tanksettings["remote_tank"].modelbase = "vehicle_ugv_talon_mp";
  level.tanksettings["remote_tank"].func_B922 = "vehicle_ugv_talon_gun_mp";
  level.tanksettings["remote_tank"].modelplacement = "vehicle_ugv_talon_obj";
  level.tanksettings["remote_tank"].modelplacementfailed = "vehicle_ugv_talon_obj_red";
  level.tanksettings["remote_tank"].modeldestroyed = "vehicle_ugv_talon_mp";
  level.tanksettings["remote_tank"].func_1114D = &"KILLSTREAKS_REMOTE_TANK_PLACE";
  level.tanksettings["remote_tank"].func_1114C = &"KILLSTREAKS_REMOTE_TANK_CANNOT_PLACE";
  level.tanksettings["remote_tank"].func_A84D = "killstreak_remote_tank_laptop_mp";
  level.tanksettings["remote_tank"].remotedetonatethink = "killstreak_remote_tank_remote_mp";
  level._effect["remote_tank_dying"] = loadfx("vfx\core\expl\killstreak_explosion_quick");
  level._effect["remote_tank_explode"] = loadfx("vfx\core\expl\bouncing_betty_explosion");
  level._effect["remote_tank_spark"] = loadfx("vfx\core\impacts\large_metal_painted_hit");
  level._effect["remote_tank_antenna_light_mp"] = loadfx("vfx\core\vehicles\aircraft_light_red_blink");
  level._effect["remote_tank_camera_light_mp"] = loadfx("vfx\core\vehicles\aircraft_light_wingtip_green");
  level.remote_tank_armor_bulletdamage = 0.5;
}

func_128FE(var_00, var_01) {
  var_02 = 1;

  if(scripts\mp\utility\game::currentactivevehiclecount() >= scripts\mp\utility\game::maxvehiclesallowed() || level.fauxvehiclecount + var_02 >= scripts\mp\utility\game::maxvehiclesallowed()) {
    self iprintlnbold(&"KILLSTREAKS_TOO_MANY_VEHICLES");
    return 0;
  }

  scripts\mp\utility\game::incrementfauxvehiclecount();
  var_03 = _meth_83AC(var_00, "remote_tank");

  if(var_03) {
    scripts\mp\matchdata::logkillstreakevent("remote_tank", self.origin);
    thread scripts\mp\utility\game::teamplayercardsplash("used_remote_tank", self);
    func_1146D("remote_tank");
  } else
    scripts\mp\utility::decrementfauxvehiclecount();

  self.iscarrying = 0;
  return var_03;
}

func_1146D(var_00) {
  var_01 = scripts\mp\utility\game::getkillstreakweapon(level.tanksettings[var_00].streakname);
  scripts\mp\killstreaks\killstreaks::func_1146C(var_01);
  scripts\mp\utility\game::_takeweapon(level.tanksettings[var_00].func_A84D);
  scripts\mp\utility\game::_takeweapon(level.tanksettings[var_00].remotedetonatethink);
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
  var_00 = self getweaponslistprimaries();

  foreach(var_02 in var_00) {
    var_03 = strtok(var_02, "_");

    if(var_3[0] == "alt") {
      self.restoreweaponclipammo[var_02] = self getweaponammoclip(var_02);
      self.func_E2E9[var_02] = self getweaponammostock(var_02);
      continue;
    }

    self.restoreweaponclipammo[var_02] = self getweaponammoclip(var_02);
    self.func_E2E9[var_02] = self getweaponammostock(var_02);
  }

  self.func_13CD2 = [];

  foreach(var_02 in var_00) {
    var_03 = strtok(var_02, "_");
    self.func_13CD2[self.func_13CD2.size] = var_02;

    if(var_3[0] == "alt") {
      continue;
    }
    scripts\mp\utility\game::_takeweapon(var_02);
  }
}

restoreweapons() {
  if(!isDefined(self.restoreweaponclipammo) || !isDefined(self.func_E2E9) || !isDefined(self.func_13CD2)) {
    return;
  }
  var_00 = [];

  foreach(var_02 in self.func_13CD2) {
    var_03 = strtok(var_02, "_");

    if(var_3[0] == "alt") {
      var_0[var_0.size] = var_02;
      continue;
    }

    scripts\mp\utility\game::_giveweapon(var_02);

    if(isDefined(self.restoreweaponclipammo[var_02])) {
      self setweaponammoclip(var_02, self.restoreweaponclipammo[var_02]);
    }

    if(isDefined(self.func_E2E9[var_02])) {
      self setweaponammostock(var_02, self.func_E2E9[var_02]);
    }
  }

  foreach(var_06 in var_00) {
    if(isDefined(self.restoreweaponclipammo[var_06])) {
      self setweaponammoclip(var_06, self.restoreweaponclipammo[var_06]);
    }

    if(isDefined(self.func_E2E9[var_06])) {
      self setweaponammostock(var_06, self.func_E2E9[var_06]);
    }
  }

  self.restoreweaponclipammo = undefined;
  self.func_E2E9 = undefined;
}

func_13710() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  wait 0.05;
  restoreweapons();
}

_meth_83AC(var_00, var_01) {
  var_02 = func_4A20(var_01, self);
  var_2.lifeid = var_00;
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

func_4A20(var_00, var_01) {
  var_02 = spawnturret("misc_turret", var_1.origin + (0, 0, 25), level.tanksettings[var_00].mgturretinfo);
  var_2.angles = var_1.angles;
  var_2.tanktype = var_00;
  var_2.owner = var_01;
  var_02 setModel(level.tanksettings[var_00].modelbase);
  var_02 maketurretinoperable();
  var_02 setturretmodechangewait(1);
  var_02 give_player_session_tokens("sentry_offline");
  var_02 makeunusable();
  var_02 setsentryowner(var_01);
  return var_02;
}

func_F689(var_00, var_01) {
  self endon("death");
  self endon("disconnect");
  var_00 thread func_114CE(self);
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
      if(!var_01 && var_02 == "cancel_tank") {
        continue;
      }
      if(level.console) {
        var_03 = scripts\mp\utility\game::getkillstreakweapon(level.tanksettings[var_0.tanktype].streakname);

        if(isDefined(self.func_A6A1) && var_03 == scripts\mp\utility\game::getkillstreakweapon(self.pers["killstreaks"][self.func_A6A1].streakname) && !self getweaponlistitems().size) {
          scripts\mp\utility\game::_giveweapon(var_03, 0);
          scripts\mp\utility\game::_setactionslot(4, "weapon", var_03);
        }
      }

      var_00 func_114CD();
      scripts\engine\utility::allow_weapon(1);
      return 0;
    }

    if(!var_0.canbeplaced) {
      continue;
    }
    var_00 thread func_114D0();
    scripts\engine\utility::allow_weapon(1);
    return 1;
  }
}

func_114CE(var_00) {
  self setModel(level.tanksettings[self.tanktype].modelplacement);
  self setsentrycarrier(var_00);
  self setcontents(0);
  self setCanDamage(0);
  self.carriedby = var_00;
  var_0.iscarrying = 1;
  var_00 thread func_12F34(self);
  thread func_114C6(var_00);
  thread func_114C7(var_00);
  thread func_114C8();
  self notify("carried");
}

func_12F34(var_00) {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  var_00 endon("placed");
  var_00 endon("death");
  var_0.canbeplaced = 1;
  var_01 = -1;

  for(;;) {
    var_02 = self _meth_805E(25.0, 25.0, 50.0, 40.0, 80.0, 0.7);
    var_0.origin = var_2["origin"];
    var_0.angles = var_2["angles"];
    var_0.canbeplaced = self isonground() && var_2["result"] && abs(var_2["origin"][2] - self.origin[2]) < 20;

    if(var_0.canbeplaced != var_01) {
      if(var_0.canbeplaced) {
        var_00 setModel(level.tanksettings[var_0.tanktype].modelplacement);

        if(self.team != "spectator") {
          self forceusehinton(level.tanksettings[var_0.tanktype].func_1114D);
        }
      } else {
        var_00 setModel(level.tanksettings[var_0.tanktype].modelplacementfailed);

        if(self.team != "spectator") {
          self forceusehinton(level.tanksettings[var_0.tanktype].func_1114C);
        }
      }
    }

    var_01 = var_0.canbeplaced;
    wait 0.05;
  }
}

func_114C6(var_00) {
  self endon("placed");
  self endon("death");
  var_00 waittill("death");
  func_114CD();
}

func_114C7(var_00) {
  self endon("placed");
  self endon("death");
  var_00 waittill("disconnect");
  func_114CD();
}

func_114C8(var_00) {
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

  var_00 = self.owner;
  var_0.iscarrying = 0;
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

  if(!isDefined(self.owner)) {
    return;
  }
  var_00 = self.owner;
  var_00 endon("death");
  self waittill("placed");
  var_00 func_1146D(self.tanktype);
  var_00 scripts\mp\utility\game::_giveweapon(level.tanksettings[self.tanktype].func_A84D);
  var_00 scripts\mp\utility\game::_switchtoweaponimmediate(level.tanksettings[self.tanktype].func_A84D);
}

func_4A1F(var_00) {
  var_01 = var_0.owner;
  var_02 = var_0.tanktype;
  var_03 = var_0.lifeid;
  var_04 = spawnvehicle(level.tanksettings[var_02].modelbase, var_02, level.tanksettings[var_02].vehicleinfo, var_0.origin, var_0.angles, var_01);

  if(!isDefined(var_04)) {
    return undefined;
  }

  var_05 = var_04 gettagorigin("tag_turret_attach");
  var_06 = spawnturret("misc_turret", var_05, level.tanksettings[var_02].mgturretinfo, 0);
  var_06 linkto(var_04, "tag_turret_attach", (0, 0, 0), (0, 0, 0));
  var_06 setModel(level.tanksettings[var_02].func_B922);
  var_6.health = level.tanksettings[var_02].health;
  var_6.owner = var_01;
  var_6.angles = var_1.angles;
  var_6.func_10955 = ::func_3758;
  var_6.func_114B1 = var_04;
  var_06 makeunusable();
  var_06 setdefaultdroppitch(0);
  var_06 setCanDamage(0);
  var_4.func_10955 = ::func_3758;
  var_4.lifeid = var_03;
  var_4.team = var_1.team;
  var_4.owner = var_01;
  var_04 setotherent(var_01);
  var_4.mgturret = var_06;
  var_4.health = level.tanksettings[var_02].health;
  var_4.maxhealth = level.tanksettings[var_02].maxhealth;
  var_4.damagetaken = 0;
  var_4.func_52D0 = 0;
  var_04 setCanDamage(0);
  var_4.tanktype = var_02;
  var_04 scripts\mp\sentientpoolmanager::registersentient("Killstreak_Ground", var_01, 1);
  var_06 setturretmodechangewait(1);
  var_04 func_114CF();
  var_06 setsentryowner(var_01);
  var_1.using_remote_tank = 0;
  var_4.empgrenaded = 0;
  var_4.func_4D49 = 1.0;
  var_04 thread func_114C5();
  var_04 thread func_114D7();
  var_04 thread func_114BB();
  return var_04;
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
  var_00 = self.owner;
  var_01 = (0, 0, 20);

  if(level.teambased) {
    self.team = var_0.team;
    self.mgturret.team = var_0.team;
    self.mgturret setturretteam(var_0.team);

    foreach(var_03 in level.players) {
      if(var_03 != var_00 && var_3.team == var_0.team) {
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
  var_00 = self.owner;
  var_00 scripts\mp\utility\game::setusingremote(self.tanktype);

  if(getdvarint("camera_thirdPerson")) {
    var_00 scripts\mp\utility\game::setthirdpersondof(0);
  }

  var_0.restoreangles = var_0.angles;
  var_00 scripts\mp\utility\game::freezecontrolswrapper(1);
  var_01 = var_00 scripts\mp\killstreaks\killstreaks::initridekillstreak("remote_tank");

  if(var_01 != "success") {
    if(var_01 != "disconnect") {
      var_00 scripts\mp\utility\game::clearusingremote();
    }

    if(isDefined(var_0.disabledweapon) && var_0.disabledweapon) {
      var_00 scripts\engine\utility::allow_weapon(1);
    }

    self notify("death");
    return 0;
  }

  var_00 scripts\mp\utility\game::freezecontrolswrapper(0);
  self.mgturret setCanDamage(1);
  self setCanDamage(1);
  var_02 = spawnStruct();
  var_2.playdeathfx = 1;
  var_2.deathoverridecallback = ::func_114C9;
  thread scripts\mp\movers::handle_moving_platforms(var_02);
  var_00 remotecontrolvehicle(self);
  var_00 remotecontrolturret(self.mgturret);
  var_00 thread tank_watchfiring(self);
  var_00 thread func_114B9(self);
  thread func_114B7();
  thread func_114CA();
  var_0.using_remote_tank = 1;
  var_00 scripts\mp\utility\game::_giveweapon(level.tanksettings[self.tanktype].remotedetonatethink);
  var_00 scripts\mp\utility\game::_switchtoweaponimmediate(level.tanksettings[self.tanktype].remotedetonatethink);
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
  }
  else if(isDefined(self.owner)) {
    scripts\mp\entityheadicons::setplayerheadicon(undefined, (0, 0, 0));
  }

  if(!isDefined(self.owner)) {
    return;
  }
  var_00 = self.owner;

  if(isDefined(var_0.using_remote_tank) && var_0.using_remote_tank) {
    var_00 notify("end_remote");
    var_00 remotecontrolvehicleoff(self);
    var_00 remotecontrolturretoff(self.mgturret);
    var_00 scripts\mp\utility\game::_switchtoweapon(var_00 scripts\engine\utility::getlastweapon());
    var_00 scripts\mp\utility\game::clearusingremote();
    var_00 setplayerangles(var_0.restoreangles);

    if(getdvarint("camera_thirdPerson")) {
      var_00 scripts\mp\utility\game::setthirdpersondof(1);
    }

    if(isDefined(var_0.disabledusability) && var_0.disabledusability) {
      var_00 scripts\engine\utility::allow_usability(1);
    }

    var_00 func_1146D(level.tanksettings[self.tanktype].streakname);
    var_0.using_remote_tank = 0;
    var_00 thread func_114BA();
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
  var_00 = level.tanksettings[self.tanktype].timeout;
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(var_00);
  self notify("death");
}

func_114C9(var_00) {
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

func_3758(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09, var_10, var_11) {
  var_12 = self;

  if(isDefined(self.func_114B1)) {
    var_12 = self.func_114B1;
  }

  if(isDefined(var_12.func_1D41) && var_12.func_1D41) {
    return;
  }
  if(!scripts\mp\weapons::friendlyfirecheck(var_12.owner, var_01)) {
    return;
  }
  if(isDefined(var_03) && var_03 &level.idflags_penetration) {
    var_12.wasdamagedfrombulletpenetration = 1;
  }

  if(isDefined(var_03) && var_03 &level.idflags_no_team_protection) {
    var_12.wasdamagedfrombulletricochet = 1;
  }

  var_12.wasdamaged = 1;
  var_12.func_4D49 = 0.0;
  playfxontagforclients(level._effect["remote_tank_spark"], var_12, "tag_player", var_12.owner);

  if(isDefined(var_05)) {
    switch (var_05) {
      case "stealth_bomb_mp":
      case "artillery_mp":
        var_02 = var_02 * 4;
        break;
    }
  }

  if(var_04 == "MOD_MELEE") {
    var_02 = var_12.maxhealth * 0.5;
  }

  var_13 = var_02;

  if(isplayer(var_01)) {
    var_01 scripts\mp\damagefeedback::updatedamagefeedback("remote_tank");

    if(var_04 == "MOD_RIFLE_BULLET" || var_04 == "MOD_PISTOL_BULLET") {
      if(var_01 scripts\mp\utility\game::_hasperk("specialty_armorpiercing")) {
        var_13 = var_13 + var_02 * level.armorpiercingmod;
      }
    }

    if(isexplosivedamagemod(var_04)) {
      var_13 = var_13 + var_02;
    }
  }

  if(isexplosivedamagemod(var_04) && (isDefined(var_05) && var_05 == "destructible_car")) {
    var_13 = var_12.maxhealth;
  }

  if(isDefined(var_1.owner) && isplayer(var_1.owner)) {
    var_1.owner scripts\mp\damagefeedback::updatedamagefeedback("remote_tank");
  }

  if(isDefined(var_05)) {
    switch (var_05) {
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

    scripts\mp\killstreaks\killstreaks::killstreakhit(var_01, var_05, self);
  }

  var_12.damagetaken = var_12.damagetaken + var_13;
  var_12 playSound("talon_damaged");

  if(var_12.damagetaken >= var_12.maxhealth) {
    if(isplayer(var_01) && (!isDefined(var_12.owner) || var_01 != var_12.owner)) {
      var_12.func_1D41 = 1;
      var_01 notify("destroyed_killstreak", var_05);
      thread scripts\mp\utility\game::teamplayercardsplash("callout_destroyed_remote_tank", var_01);
      var_01 thread scripts\mp\utility\game::giveunifiedpoints("kill", var_05, 300);
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
  var_00 = 0;

  for(;;) {
    if(!self.empgrenaded) {
      if(self.func_4D49 < 1.0) {
        self.func_4D49 = self.func_4D49 + 0.1;
        var_00 = 1;
      } else if(var_00) {
        self.func_4D49 = 1.0;
        var_00 = 0;
      }
    }

    wait 0.1;
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
      if(self.damagetaken > 0) {
        var_02 = 0;
        var_1++;
      }
    } else if(self.damagetaken >= self.maxhealth * (var_00 * var_01))
      var_1++;

    wait 0.05;
  }
}

func_114BD() {
  self endon("death");
  level endon("game_ended");

  for(;;) {
    self waittill("damage", var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09);

    if(isDefined(self.func_10955)) {
      self[[self.func_10955]](undefined, var_01, var_00, var_08, var_04, var_09, var_03, var_02, undefined, undefined, var_05, var_07);
    }
  }
}

func_114D5() {
  self endon("death");
  level endon("game_ended");

  for(;;) {
    self waittill("damage", var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09);

    if(isDefined(self.func_10955) && isDefined(self.func_114B1) && (!isexplosivedamagemod(var_04) || isDefined(var_09) && isexplosivedamagemod(var_04) && (var_09 == "stealth_bomb_mp" || var_09 == "artillery_mp"))) {
      self.func_114B1[[self.func_10955]](undefined, var_01, var_00, var_08, var_04, var_09, var_03, var_02, undefined, undefined, var_05, var_07);
    }
  }
}

tank_watchfiring(var_00) {
  self endon("disconnect");
  self endon("end_remote");
  var_00 endon("death");
  var_01 = 50;
  var_02 = var_01;
  var_03 = weaponfiretime(level.tanksettings[var_0.tanktype].mgturretinfo);

  for(;;) {
    if(var_0.mgturret isfiringvehicleturret()) {
      var_2--;

      if(var_02 <= 0) {
        var_0.mgturret turretfiredisable();
        wait 2.5;
        var_00 playSound("talon_reload");
        self playlocalsound("talon_reload_plr");
        var_02 = var_01;
        var_0.mgturret turretfireenable();
      }
    }

    wait(var_03);
  }
}

func_114B9(var_00) {
  self endon("disconnect");
  self endon("end_remote");
  level endon("game_ended");
  var_00 endon("death");
  var_01 = 0;

  for(;;) {
    if(self fragbuttonpressed() && !var_0.empgrenaded) {
      var_02 = var_0.mgturret.origin;
      var_03 = var_0.mgturret.angles;

      switch (var_01) {
        case 0:
          var_02 = var_0.mgturret gettagorigin("tag_missile1");
          var_03 = var_0.mgturret gettagangles("tag_player");
          break;
        case 1:
          var_02 = var_0.mgturret gettagorigin("tag_missile2");
          var_03 = var_0.mgturret gettagangles("tag_player");
          break;
      }

      var_00 playSound("talon_missile_fire");
      self playlocalsound("talon_missile_fire_plr");
      var_04 = var_02 + anglesToForward(var_03) * 100;
      var_05 = scripts\mp\utility\game::_magicbullet(level.tanksettings[var_0.tanktype].func_B88D, var_02, var_04, self);
      var_01 = (var_01 + 1) % 2;
      wait 5.0;
      var_00 playSound("talon_rocket_reload");
      self playlocalsound("talon_rocket_reload_plr");
      continue;
    }

    wait 0.05;
  }
}

func_114B6(var_00) {
  self endon("disconnect");
  self endon("end_remote");
  level endon("game_ended");
  var_00 endon("death");

  for(;;) {
    if(self secondaryoffhandbuttonpressed()) {
      var_01 = bulletTrace(var_0.origin + (0, 0, 4), var_0.origin - (0, 0, 4), 0, var_00);
      var_02 = vectornormalize(var_1["normal"]);
      var_03 = vectortoangles(var_02);
      var_03 = var_03 + (90, 0, 0);
      var_04 = scripts\mp\weapons::spawnmine(var_0.origin, self, "equipment", var_03);
      var_00 playSound("item_blast_shield_on");
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

addtougvlist(var_00) {
  level.ugvs[var_00] = self;
}

removefromugvlist(var_00) {
  level.ugvs[var_00] = undefined;
}

func_114CA() {
  if(!isDefined(self.owner)) {
    return;
  }
  var_00 = self.owner;
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

      wait 0.05;
    }

    wait 0.05;
  }
}