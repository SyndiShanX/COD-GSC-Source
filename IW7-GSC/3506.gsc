/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3506.gsc
**************************************/

init() {
  level.rockets = [];
  level.remotekillstreaks["explode"] = loadfx("vfx\core\expl\aerial_explosion");
  scripts\mp\killstreaks\killstreaks::registerkillstreak("orbital_deployment", ::func_128F2);
  level._effect["odin_clouds"] = loadfx("vfx\core\mp\killstreaks\odin\odin_parallax_clouds");
  level._effect["odin_fisheye"] = loadfx("vfx\code\screen\vfx_scrnfx_odin_fisheye.vfx");
  level._effect["odin_targeting"] = loadfx("vfx\core\mp\killstreaks\odin\vfx_marker_good_target");
  level._effect["odin_targeting_bad"] = loadfx("vfx\core\mp\killstreaks\odin\vfx_marker_bad_target");
  level._effect["phase_out_friendly"] = loadfx("vfx\core\mp\killstreaks\vfx_phase_orbital_deployment_friendly");
  level._effect["phase_out_enemy"] = loadfx("vfx\core\mp\killstreaks\vfx_phase_orbital_deployment_enemy");
  level._effect["drop_pod_atmo"] = loadfx("vfx\core\expl\emp_flash_mp");
  level._effect["drop_pod_fx"] = loadfx("vfx\core\mp\killstreaks\odin\vfx_odin_flash_small");
  level.var_C6D7 = [];
  level.var_C6D7["orbital_deployment"] = spawnStruct();
  level.var_C6D7["orbital_deployment"].timeout = 60.0;
  level.var_C6D7["orbital_deployment"].streakname = "orbital_deployment";
  level.var_C6D7["orbital_deployment"].vehicleinfo = "odin_mp";
  level.var_C6D7["orbital_deployment"].modelbase = "vehicle_odin_mp";
  level.var_C6D7["orbital_deployment"].teamsplash = "used_orbital_deployment";
  level.var_C6D7["orbital_deployment"].votimedout = "odin_gone";
  level.var_C6D7["orbital_deployment"].var_1352D = "odin_target_killed";
  level.var_C6D7["orbital_deployment"].var_1352C = "odin_targets_killed";
  level.var_C6D7["orbital_deployment"].var_12B20 = 3;
  level.var_C6D7["orbital_deployment"].var_12B80 = &"KILLSTREAKS_ODIN_UNAVAILABLE";
  level.var_C6D7["orbital_deployment"].weapon["juggernaut"] = spawnStruct();
  level.var_C6D7["orbital_deployment"].weapon["juggernaut"].var_D5E4 = "null";
  level.var_C6D7["orbital_deployment"].weapon["juggernaut"].var_D5DD = "odin_jugg_launch";

  if(!isDefined(level.heli_pilot_mesh)) {
    level.heli_pilot_mesh = getent("heli_pilot_mesh", "targetname");

    if(!isDefined(level.heli_pilot_mesh)) {} else
      level.heli_pilot_mesh.origin = level.heli_pilot_mesh.origin + scripts\mp\utility\game::gethelipilotmeshoffset();
  }

  level.var_163A = [];
}

func_128F2(var_0) {
  self endon("disconnect");
  var_1 = var_0.var_98F2;

  if(isDefined(self.underwater) && self.underwater) {
    return 0;
  }

  var_2 = func_10DD3(var_0.streakname);

  if(!isDefined(var_2)) {
    var_2 = 0;
  }

  return var_2;
}

func_10DD3(var_0, var_1) {
  level endon("game_ended");

  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  self.restoreangles = vectortoangles(anglesToForward(self.angles));
  func_C6CB();

  if(var_1 == 1) {
    scripts\engine\utility::allow_usability(0);
    scripts\engine\utility::allow_weapon_switch(0);
    scripts\mp\utility\game::incrementfauxvehiclecount();
    var_2 = func_49FB();

    if(!isDefined(var_2)) {
      scripts\engine\utility::allow_weapon_switch(1);
      scripts\mp\utility::decrementfauxvehiclecount();
      return 0;
    }

    self remotecontrolvehicle(var_2);
  } else {
    scripts\engine\utility::allow_usability(0);
    scripts\engine\utility::allow_weapon_switch(0);
    var_3 = scripts\mp\killstreaks\mapselect::_meth_8112(var_0);

    if(!isDefined(var_3)) {
      func_C6C4();
      scripts\engine\utility::allow_usability(1);
      scripts\engine\utility::allow_weapon_switch(1);
      return 0;
    }

    func_10DD4(var_3[0].location, var_3[0].location + (0, 0, 10000), var_0);
  }

  return 1;
}

func_49FB() {
  var_0 = (0, 0, 0);
  var_1 = self.origin * (1, 1, 0) + (level.heli_pilot_mesh.origin - scripts\mp\utility\game::gethelipilotmeshoffset()) * (0, 0, 1);
  var_2 = spawnhelicopter(self, var_1, var_0, level.var_C6D7["orbital_deployment"].vehicleinfo, level.var_C6D7["orbital_deployment"].modelbase);

  if(!isDefined(var_2)) {
    return;
  }
  var_2.speed = 40;
  var_2.owner = self;
  var_2.team = self.team;
  var_2.streakname = "orbital_deployment";
  level.var_163A["orbital_deployment"] = 1;
  self.var_98FF = 1;
  self.var_A641 = 0;
  self.var_C6C3 = var_2;
  var_2 thread func_C6D4();
  var_2 thread func_C6D3();
  var_2 thread func_C6D0();
  var_2 thread func_C6D2();
  return var_2;
}

func_C6D4() {
  self endon("death");
  level endon("game_ended");
  var_0 = self.owner;
  var_0 endon("disconnect");
  var_0 endon("juggernaut_dead");

  if(!isai(var_0)) {
    var_0 notifyonplayercommand("orbital_deployment_action", "+attack");
    var_0 notifyonplayercommand("orbital_deployment_action", "+attack_akimbo_accessible");
  }

  for(;;) {
    var_0 waittill("orbital_deployment_action");

    if(scripts\mp\utility\game::istrue(self.targeting_marker.var_EA21)) {
      var_0 setclientomnvar("ui_odin", -1);
      var_0 func_10DD4(self.targeting_marker.origin, self.origin, self.streakname);
      var_0 remotecontrolvehicleoff(self);
      func_4074();
      self notify("death");
      break;
    } else
      var_0 scripts\mp\utility\game::func_13A7("odin_negative_action");

    wait 1.1;
  }
}

func_7E6A(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  var_1 = getnodesinradiussorted(var_0, 256, 0, 128, "Path");

  if(!isDefined(var_1[0])) {
    return;
  }
  return var_1[0];
}

func_C6D3() {
  level endon("game_ended");
  self endon("death");
  self.owner endon("disconnect");
  self.owner endon("joined_team");
  self.owner endon("joined_spectators");
  var_0 = level.var_C6D7["orbital_deployment"];
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(var_0.timeout);
  thread func_C6C7();
}

func_C6D0() {
  level endon("game_ended");
  self endon("death");
  self endon("leaving");
  self.owner scripts\engine\utility::waittill_any("disconnect", "joined_team", "joined_spectators");
  thread func_C6C7();
}

func_C6D2() {
  self endon("death");
  level endon("game_ended");
  var_0 = self.owner;
  var_0 endon("disconnect");
  var_1 = var_0 getvieworigin();
  var_2 = var_1 + anglesToForward(self gettagangles("tag_player")) * 10000;
  var_3 = bulletTrace(var_1, var_2, 0, self);
  var_4 = spawn("script_model", var_3["position"]);
  var_4.angles = vectortoangles((0, 0, 1));
  var_4 setModel("tag_origin");
  self.targeting_marker = var_4;
  var_4 endon("death");
  var_5 = bulletTrace(var_4.origin + (0, 0, 50), var_4.origin + (0, 0, -100), 0, var_4);
  var_4.origin = var_5["position"] + (0, 0, 50);
  var_4 hide();
  var_4 giveperkequipment(var_0);
  var_4 childthread func_B9F2(var_0);
  thread func_10129();
  self setotherent(var_4);
}

func_B9F2(var_0) {
  var_0 endon("disconnect");
  self endon("death");
  level endon("game_ended");
  wait 1.5;
  var_1 = [];

  for(;;) {
    var_2 = func_7E6A(self.origin);

    if(isDefined(var_2)) {
      self.var_EA21 = 1;
      stopFXOnTag(level._effect["odin_targeting_bad"], self, "tag_origin");
      wait 0.05;
      playFXOnTag(level._effect["odin_targeting"], self, "tag_origin");
    } else {
      self.var_EA21 = 0;
      stopFXOnTag(level._effect["odin_targeting"], self, "tag_origin");
      wait 0.05;
      playFXOnTag(level._effect["odin_targeting_bad"], self, "tag_origin");
    }

    var_3 = var_0 scripts\mp\utility\game::get_players_watching();

    foreach(var_5 in var_1) {
      if(!scripts\engine\utility::array_contains(var_3, var_5)) {
        var_1 = scripts\engine\utility::array_remove(var_1, var_5);
        self hide();
        self giveperkequipment(var_0);
      }
    }

    foreach(var_5 in var_3) {
      self giveperkequipment(var_5);

      if(!scripts\engine\utility::array_contains(var_1, var_5)) {
        var_1 = scripts\engine\utility::array_add(var_1, var_5);
        stopFXOnTag(level._effect["odin_targeting"], self, "tag_origin");
        wait 0.05;
        playFXOnTag(level._effect["odin_targeting"], self, "tag_origin");
      }
    }

    wait 0.05;
  }
}

func_10129() {
  self endon("death");
  wait 1.0;
  var_0 = func_7E6A(self.targeting_marker.origin);

  if(isDefined(var_0)) {
    playFXOnTag(level._effect["odin_targeting"], self.targeting_marker, "tag_origin");
  } else {
    playFXOnTag(level._effect["odin_targeting_bad"], self.targeting_marker, "tag_origin");
  }
}

func_C6C7(var_0) {
  self endon("death");
  self notify("leaving");
  var_1 = level.var_C6D7["orbital_deployment"];
  scripts\mp\utility\game::leaderdialog(var_1.votimedout);

  if(isDefined(self.owner)) {
    self.owner func_C6C5(self, var_0);
  }

  self notify("gone");
  func_4074();
  func_C6CC(3.0);
  scripts\mp\utility::decrementfauxvehiclecount();
  level.var_163A["orbital_deployment"] = undefined;
  self delete();
}

func_4074() {
  if(isDefined(self.targeting_marker)) {
    self.targeting_marker delete();
  }

  if(isDefined(self.var_C6CA)) {
    self.var_C6CA delete();
  }
}

func_C6CC(var_0) {
  while(isDefined(self.var_9BE2) && var_0 > 0) {
    wait 0.05;
    var_0 = var_0 - 0.05;
  }
}

func_C6C5(var_0, var_1) {
  if(isDefined(var_0)) {
    self setclientomnvar("ui_odin", -1);
    var_0 notify("end_remote");
    self notify("odin_ride_ended");
    func_C6C4();

    if(getdvarint("camera_thirdPerson")) {
      scripts\mp\utility\game::setthirdpersondof(1);
    }

    self thermalvisionfofoverlayoff();
    self remotecontrolvehicleoff(var_0);
    self setplayerangles(self.restoreangles);

    if(isDefined(var_1) && var_1) {
      func_108F5();
      self.var_A641 = 0;
      scripts\engine\utility::allow_weapon(1);
      self notify("weapon_change", self getcurrentweapon());
    }

    self stopolcalsound("odin_negative_action");
    self stopolcalsound("odin_positive_action");

    foreach(var_3 in level.var_C6D7["orbital_deployment"].weapon) {
      if(isDefined(var_3.var_D5E4)) {
        self stopolcalsound(var_3.var_D5E4);
      }

      if(isDefined(var_3.var_D5DD)) {
        self stopolcalsound(var_3.var_D5DD);
      }
    }

    if(isDefined(var_0.var_A4A3)) {
      var_0.var_A4A3 scripts\mp\bots\bots_strategy::bot_guard_player(self, 350);
    }

    self notify("stop_odin");
  }
}

func_108F5() {
  self.var_98FF = 0;
  var_0 = self[[level.getspawnpoint]]();
  var_1 = var_0.origin;
  var_2 = var_0.angles;
  self.angles = var_2;
  self setorigin(var_1, 1);

  foreach(var_4 in level.players) {
    if(var_4 != self) {
      self giveperkequipment(var_4);
    }
  }
}

func_10DD8() {
  var_0 = undefined;

  if(self.team == "allies") {
    var_0 = "axis";
  } else if(self.team == "axis") {
    var_0 = "allies";
  }

  var_1 = anglesToForward(self.angles);
  var_2 = anglestoup(self.angles);

  foreach(var_4 in level.players) {
    if(var_4 != self) {
      self hidefromplayer(var_4);

      if(var_4.team == self.team) {
        playFX(level._effect["phase_out_friendly"], self.origin, var_1, var_2);
        continue;
      }

      playFX(level._effect["phase_out_enemy"], self.origin, var_1, var_2);
    }
  }
}

func_C6CB() {
  scripts\mp\utility\game::setusingremote("orbital_deployment");
}

func_C6C4() {
  if(isDefined(self)) {
    scripts\mp\utility\game::clearusingremote();
  }
}

func_10DD4(var_0, var_1, var_2) {
  func_10D70();
  self waittill("blackout_done");
  scripts\mp\utility\game::freezecontrolswrapper(1);
  level thread func_B9CB(self);
  level thread monitorgameend(self);
  level thread monitorobjectivecamera(self);
  var_3 = scripts\mp\killstreaks\killstreaks::initridekillstreak(var_2);

  if(var_3 == "success") {
    level thread func_1285(var_0, var_1, self, var_2);
  } else {
    self notify("end_kill_streak");
    func_C6C4();
    scripts\engine\utility::allow_usability(1);
    scripts\engine\utility::allow_weapon_switch(1);
  }

  level thread scripts\mp\utility\game::teamplayercardsplash(level.var_C6D7["orbital_deployment"].teamsplash, self);
}

func_1285(var_0, var_1, var_2, var_3) {
  var_2.var_98FF = 1;
  var_4 = 0;
  var_5 = var_0;
  var_6 = var_1;
  var_7 = vectornormalize(var_6 - var_5);
  var_6 = var_7 * 14000 + var_5;
  var_8 = scripts\mp\utility\game::_magicbullet("drone_hive_projectile_mp", var_6 - (0, 0, 5000), var_5, var_2);
  var_8 give_player_next_weapon(1);
  var_9 = spawn("script_model", var_8.origin);
  var_9 setModel("jsp_drop_pod_top");
  var_9 linkto(var_8, "tag_origin");
  var_9 setotherent(var_8);
  var_9.team = var_2.team;
  var_9.owner = var_2;
  var_9 scripts\mp\killstreaks\utility::func_1843(var_3, "Killstreak_Air", var_9.owner, 1);

  if(scripts\mp\utility\game::isreallyalive(var_2)) {
    var_2 func_10DD8();
  }

  if(isDefined(var_2.fauxdeath) && var_2.fauxdeath) {
    var_2.faux_spawn_stance = var_2 getstance();
    var_2 thread scripts\mp\playerlogic::spawnplayer(0);
    var_4 = 1;
  }

  var_2 setorigin(var_8.origin + (0, 0, 10), 1);
  var_8 thread func_13A22("large_rod");
  var_8.team = var_2.team;
  var_8.type = "remote";
  var_8.owner = var_2;
  var_8 thread scripts\mp\killstreaks\remotemissile::handledamage();
  level.remotemissileinprogress = 1;
  level thread monitordeath(var_8, 1);
  level thread monitorboost(var_8);
  func_C6D6(var_2, var_8);
  var_2 setclientomnvar("ui_predator_missile", 3);
  var_2 setclientomnvar("ui_predator_missiles_left", 0);
  playFX(level._effect["drop_pod_atmo"], var_8.origin);
  var_8 thread func_5821();
  var_8 thread func_13AA4(var_2);
  var_8 thread func_13AA3(var_2);

  for(;;) {
    var_10 = var_8 scripts\engine\utility::waittill_any_return("death", "missileTargetSet");
    scripts\mp\hostmigration::waittillhostmigrationdone();

    if(var_10 == "death") {
      break;
    }
    if(!isDefined(var_8)) {
      break;
    }
  }

  if(isDefined(var_8)) {
    var_0 = var_8.origin;

    if(isDefined(var_2)) {
      var_2 scripts\mp\matchdata::logkillstreakevent(var_3, var_8.origin);
    }
  }

  level thread func_E474(var_2, undefined, var_0, var_9, var_4);
}

monitorboost(var_0) {
  var_0 endon("death");

  for(;;) {
    var_0.owner waittill("missileTargetSet");
    var_0 notify("missileTargetSet");
  }
}

func_C6D6(var_0, var_1) {
  var_0 scripts\mp\utility\game::freezecontrolswrapper(1);
  var_0 cameralinkto(var_1, "tag_origin");
  var_0 controlslinkto(var_1);
  var_0 visionsetmissilecamforplayer("default", 0);
  var_0 thread scripts\mp\utility\game::set_visionset_for_watching_players("default", 0, undefined, 1);
  var_0 visionsetmissilecamforplayer(game["thermal_vision"], 1.0);
  var_0 thread delayedfofoverlay();
}

delayedfofoverlay() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(0.25);
  self thermalvisionfofoverlayon();
}

func_13A22(var_0) {
  self waittill("explode", var_1);

  if(var_0 == "small_rod") {
    playrumbleonentity("grenade_rumble", var_1);
    earthquake(0.7, 1.0, var_1, 1000);
  } else if(var_0 == "large_rod") {
    playrumbleonentity("artillery_rumble", var_1);
    earthquake(1.0, 1.0, var_1, 2000);
  }
}

func_13AA4(var_0) {
  var_0 endon("killstreak_disowned");
  var_0 endon("disconnect");
  level endon("game_ended");
  self endon("death");

  for(;;) {
    level waittill("host_migration_begin");

    if(isDefined(self)) {
      var_0 visionsetmissilecamforplayer(game["thermal_vision"], 0);
      var_0 scripts\mp\utility\game::set_visionset_for_watching_players("default", 0, undefined, 1);
      var_0 thermalvisionfofoverlayon();
      continue;
    }

    var_0 setclientomnvar("ui_predator_missile", 2);
  }
}

func_13AA3(var_0) {
  var_0 endon("killstreak_disowned");
  var_0 endon("disconnect");
  level endon("game_ended");
  self endon("death");

  for(;;) {
    level waittill("host_migration_end");

    if(isDefined(self)) {
      var_0 setclientomnvar("ui_predator_missile", 3);
      continue;
    }

    var_0 setclientomnvar("ui_predator_missile", 2);
  }
}

func_B9CB(var_0) {
  var_0 endon("disconnect");
  var_0 endon("end_kill_streak");
  var_0 waittill("killstreak_disowned");
  level thread func_E474(var_0);
}

monitorgameend(var_0) {
  var_0 endon("disconnect");
  var_0 endon("end_kill_streak");
  level waittill("game_ended");
  level thread func_E474(var_0);
}

monitorobjectivecamera(var_0) {
  var_0 endon("end_kill_streak");
  var_0 endon("disconnect");
  level waittill("objective_cam");
  level thread func_E474(var_0, 1);
}

monitordeath(var_0, var_1) {
  var_0 waittill("death");
  scripts\mp\hostmigration::waittillhostmigrationdone();

  if(isDefined(var_0.var_114F1)) {
    var_0.var_114F1 delete();
  }

  if(isDefined(var_0.entitynumber)) {
    level.rockets[var_0.entitynumber] = undefined;
  }

  if(var_1) {
    level.remotemissileinprogress = undefined;
  }
}

func_E474(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_0)) {
    if(isDefined(var_3)) {
      var_3 thread func_51B1();
    }

    return;
  }

  var_0 setclientomnvar("ui_predator_missile", 2);
  var_0 notify("end_kill_streak");
  var_0 notify("orbital_deployment_complete");
  var_0 thermalvisionfofoverlayoff();
  var_0 controlsunlink();

  if(!isDefined(var_1)) {
    scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(0.95);
  }

  var_0 cameraunlink();
  var_0 setclientomnvar("ui_predator_missile", 0);

  if(!var_4) {
    var_0 func_C6C4();
    var_0 scripts\engine\utility::allow_weapon_switch(1);
  } else {
    var_0 scripts\engine\utility::allow_offhand_weapons(0);
    var_0 scripts\engine\utility::allow_weapon_switch(0);
    var_0 func_C6C4();
    var_0 scripts\engine\utility::allow_weapon_switch(1);
  }

  var_0 scripts\mp\utility\game::freezecontrolswrapper(0);
  var_0 scripts\engine\utility::allow_usability(1);

  if(isDefined(var_2)) {
    var_0 func_10D89(var_2, var_3);
  }
}

func_10D89(var_0, var_1) {
  var_2 = spawn("script_model", var_0);
  var_2.angles = self.angles;
  var_2.owner = self;
  var_2.team = self.team;
  self.var_98FF = 0;
  self setorigin(var_0 + (0, 0, 15), 1);

  foreach(var_4 in level.players) {
    if(var_4 != self) {
      self giveperkequipment(var_4);
    }
  }

  self notify("weapon_change", self getcurrentweapon());
  var_1 thread func_51B1();
}

func_51B1() {
  wait 0.7;
  playFX(scripts\engine\utility::getfx("trophy_spark_fx"), self.origin);
  self delete();
}

func_10D70() {
  var_0 = newclienthudelem(self);
  var_0.x = 0;
  var_0.y = 0;
  var_0.alignx = "left";
  var_0.aligny = "top";
  var_0.sort = 1;
  var_0.horzalign = "fullscreen";
  var_0.vertalign = "fullscreen";
  var_0.foreground = 1;
  var_0 setshader("black", 640, 480);
  thread func_50E0(var_0, 0, 0.05, 1);
  var_1 = 0.1;
  childthread func_50DE(var_0, var_1);
}

func_50E0(var_0, var_1, var_2, var_3) {
  self endon("disconnect");
  wait(var_1);
  var_0 fadeovertime(var_2);
}

func_50DE(var_0, var_1) {
  wait(var_1);
  var_0 destroy();
  self notify("blackout_done");
}

func_5821() {
  wait 0.5;
  playFX(level._effect["drop_pod_fx"], self.origin);
  wait 0.3;
  playFX(level._effect["drop_pod_fx"], self.origin);
  wait 0.3;
  playFX(level._effect["drop_pod_fx"], self.origin);
}

func_D39C(var_0) {
  var_1 = self.pers["killstreaks"];

  for(var_2 = 0; var_2 <= 3; var_2++) {
    var_3 = var_1[var_2];

    if(isDefined(var_3) && var_3.streakname == var_0 && var_3.var_269A) {
      return 1;
    }
  }

  return 0;
}