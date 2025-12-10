/**********************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\mp\killstreaks\_orbital_deployment.gsc
**********************************************************/

init() {
  level.rockets = [];
  level.remotekillstreaks["explode"] = loadfx("vfx\core\expl\aerial_explosion");
  scripts\mp\killstreaks\_killstreaks::registerkillstreak("orbital_deployment", ::func_128F2);
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
  level.var_C6D7["orbital_deployment"].timeout = 60;
  level.var_C6D7["orbital_deployment"].streakname = "orbital_deployment";
  level.var_C6D7["orbital_deployment"].vehicleinfo = "odin_mp";
  level.var_C6D7["orbital_deployment"].modelbase = "vehicle_odin_mp";
  level.var_C6D7["orbital_deployment"].teamsplash = "used_orbital_deployment";
  level.var_C6D7["orbital_deployment"].votimedout = "odin_gone";
  level.var_C6D7["orbital_deployment"].var_1352D = "odin_target_killed";
  level.var_C6D7["orbital_deployment"].var_1352C = "odin_targets_killed";
  level.var_C6D7["orbital_deployment"].var_12B20 = 3;
  level.var_C6D7["orbital_deployment"].var_12B80 = &"KILLSTREAKS_ODIN_UNAVAILABLE";
  level.var_C6D7["orbital_deployment"].var_394["juggernaut"] = spawnStruct();
  level.var_C6D7["orbital_deployment"].var_394["juggernaut"].var_D5E4 = "null";
  level.var_C6D7["orbital_deployment"].var_394["juggernaut"].var_D5DD = "odin_jugg_launch";
  if(!isDefined(level.heli_pilot_mesh)) {
    level.heli_pilot_mesh = getent("heli_pilot_mesh", "targetname");
    if(!isDefined(level.heli_pilot_mesh)) {} else {
      level.heli_pilot_mesh.origin = level.heli_pilot_mesh.origin + scripts\mp\utility::gethelipilotmeshoffset();
    }
  }

  level.var_163A = [];
}

func_128F2(param_00) {
  self endon("disconnect");
  var_01 = param_00.var_98F2;
  if(isDefined(self.underwater) && self.underwater) {
    return 0;
  }

  var_02 = func_10DD3(param_00.streakname);
  if(!isDefined(var_02)) {
    var_02 = 0;
  }

  return var_02;
}

func_10DD3(param_00, param_01) {
  level endon("game_ended");
  if(!isDefined(param_01)) {
    param_01 = 0;
  }

  self.restoreangles = vectortoangles(anglesToForward(self.angles));
  func_C6CB();
  if(param_01 == 1) {
    scripts\engine\utility::allow_usability(0);
    scripts\engine\utility::allow_weapon_switch(0);
    scripts\mp\utility::incrementfauxvehiclecount();
    var_02 = func_49FB();
    if(!isDefined(var_02)) {
      scripts\engine\utility::allow_weapon_switch(1);
      scripts\mp\utility::decrementfauxvehiclecount();
      return 0;
    }

    self remotecontrolvehicle(var_02);
  } else {
    scripts\engine\utility::allow_usability(0);
    scripts\engine\utility::allow_weapon_switch(0);
    var_03 = scripts\mp\killstreaks\_mapselect::_meth_8112(param_00);
    if(!isDefined(var_03)) {
      func_C6C4();
      scripts\engine\utility::allow_usability(1);
      scripts\engine\utility::allow_weapon_switch(1);
      return 0;
    }

    func_10DD4(var_03[0].location, var_03[0].location + (0, 0, 10000), param_00);
  }

  return 1;
}

func_49FB() {
  var_00 = (0, 0, 0);
  var_01 = self.origin * (1, 1, 0) + level.heli_pilot_mesh.origin - scripts\mp\utility::gethelipilotmeshoffset() * (0, 0, 1);
  var_02 = spawnhelicopter(self, var_01, var_00, level.var_C6D7["orbital_deployment"].vehicleinfo, level.var_C6D7["orbital_deployment"].modelbase);
  if(!isDefined(var_02)) {
    return;
  }

  var_02.getclosestpointonnavmesh3d = 40;
  var_02.triggerportableradarping = self;
  var_02.team = self.team;
  var_02.streakname = "orbital_deployment";
  level.var_163A["orbital_deployment"] = 1;
  self.var_98FF = 1;
  self.var_A641 = 0;
  self.var_C6C3 = var_02;
  var_02 thread func_C6D4();
  var_02 thread func_C6D3();
  var_02 thread func_C6D0();
  var_02 thread func_C6D2();
  return var_02;
}

func_C6D4() {
  self endon("death");
  level endon("game_ended");
  var_00 = self.triggerportableradarping;
  var_00 endon("disconnect");
  var_00 endon("juggernaut_dead");
  if(!isai(var_00)) {
    var_00 notifyonplayercommand("orbital_deployment_action", "+attack");
    var_00 notifyonplayercommand("orbital_deployment_action", "+attack_akimbo_accessible");
  }

  for(;;) {
    var_00 waittill("orbital_deployment_action");
    if(scripts\mp\utility::istrue(self.targeting_marker.var_EA21)) {
      var_00 setclientomnvar("ui_odin", -1);
      var_00 func_10DD4(self.targeting_marker.origin, self.origin, self.streakname);
      var_00 remotecontrolvehicleoff(self);
      func_4074();
      self notify("death");
      break;
    } else {
      var_00 scripts\mp\utility::_playlocalsound("odin_negative_action");
    }

    wait(1.1);
  }
}

func_7E6A(param_00) {
  if(!isDefined(param_00)) {
    return;
  }

  var_01 = getnodesinradiussorted(param_00, 256, 0, 128, "Path");
  if(!isDefined(var_01[0])) {
    return;
  }

  return var_01[0];
}

func_C6D3() {
  level endon("game_ended");
  self endon("death");
  self.triggerportableradarping endon("disconnect");
  self.triggerportableradarping endon("joined_team");
  self.triggerportableradarping endon("joined_spectators");
  var_00 = level.var_C6D7["orbital_deployment"];
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(var_00.timeout);
  thread func_C6C7();
}

func_C6D0() {
  level endon("game_ended");
  self endon("death");
  self endon("leaving");
  self.triggerportableradarping scripts\engine\utility::waittill_any_3("disconnect", "joined_team", "joined_spectators");
  thread func_C6C7();
}

func_C6D2() {
  self endon("death");
  level endon("game_ended");
  var_00 = self.triggerportableradarping;
  var_00 endon("disconnect");
  var_01 = var_00 getvieworigin();
  var_02 = var_01 + anglesToForward(self gettagangles("tag_player")) * 10000;
  var_03 = bulletTrace(var_01, var_02, 0, self);
  var_04 = spawn("script_model", var_03["position"]);
  var_04.angles = vectortoangles((0, 0, 1));
  var_04 setModel("tag_origin");
  self.targeting_marker = var_04;
  var_04 endon("death");
  var_05 = bulletTrace(var_04.origin + (0, 0, 50), var_04.origin + (0, 0, -100), 0, var_04);
  var_04.origin = var_05["position"] + (0, 0, 50);
  var_04 hide();
  var_04 showtoplayer(var_00);
  var_04 childthread func_B9F2(var_00);
  thread func_10129();
  self setotherent(var_04);
}

func_B9F2(param_00) {
  param_00 endon("disconnect");
  self endon("death");
  level endon("game_ended");
  wait(1.5);
  var_01 = [];
  for(;;) {
    var_02 = func_7E6A(self.origin);
    if(isDefined(var_02)) {
      self.var_EA21 = 1;
      stopFXOnTag(level._effect["odin_targeting_bad"], self, "tag_origin");
      wait(0.05);
      playFXOnTag(level._effect["odin_targeting"], self, "tag_origin");
    } else {
      self.var_EA21 = 0;
      stopFXOnTag(level._effect["odin_targeting"], self, "tag_origin");
      wait(0.05);
      playFXOnTag(level._effect["odin_targeting_bad"], self, "tag_origin");
    }

    var_03 = param_00 scripts\mp\utility::get_players_watching();
    foreach(var_05 in var_01) {
      if(!scripts\engine\utility::array_contains(var_03, var_05)) {
        var_01 = scripts\engine\utility::array_remove(var_01, var_05);
        self hide();
        self showtoplayer(param_00);
      }
    }

    foreach(var_05 in var_03) {
      self showtoplayer(var_05);
      if(!scripts\engine\utility::array_contains(var_01, var_05)) {
        var_01 = scripts\engine\utility::array_add(var_01, var_05);
        stopFXOnTag(level._effect["odin_targeting"], self, "tag_origin");
        wait(0.05);
        playFXOnTag(level._effect["odin_targeting"], self, "tag_origin");
      }
    }

    wait(0.05);
  }
}

func_10129() {
  self endon("death");
  wait(1);
  var_00 = func_7E6A(self.targeting_marker.origin);
  if(isDefined(var_00)) {
    playFXOnTag(level._effect["odin_targeting"], self.targeting_marker, "tag_origin");
    return;
  }

  playFXOnTag(level._effect["odin_targeting_bad"], self.targeting_marker, "tag_origin");
}

func_C6C7(param_00) {
  self endon("death");
  self notify("leaving");
  var_01 = level.var_C6D7["orbital_deployment"];
  scripts\mp\utility::leaderdialog(var_01.votimedout);
  if(isDefined(self.triggerportableradarping)) {
    self.triggerportableradarping func_C6C5(self, param_00);
  }

  self notify("gone");
  func_4074();
  func_C6CC(3);
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

func_C6CC(param_00) {
  while(isDefined(self.var_9BE2) && param_00 > 0) {
    wait(0.05);
    param_00 = param_00 - 0.05;
  }
}

func_C6C5(param_00, param_01) {
  if(isDefined(param_00)) {
    self setclientomnvar("ui_odin", -1);
    param_00 notify("end_remote");
    self notify("odin_ride_ended");
    func_C6C4();
    if(getdvarint("camera_thirdPerson")) {
      scripts\mp\utility::setthirdpersondof(1);
    }

    self thermalvisionfofoverlayoff();
    self remotecontrolvehicleoff(param_00);
    self setplayerangles(self.restoreangles);
    if(isDefined(param_01) && param_01) {
      func_108F5();
      self.var_A641 = 0;
      scripts\engine\utility::allow_weapon(1);
      self notify("weapon_change", self getcurrentweapon());
    }

    self stoplocalsound("odin_negative_action");
    self stoplocalsound("odin_positive_action");
    foreach(var_03 in level.var_C6D7["orbital_deployment"].var_394) {
      if(isDefined(var_03.var_D5E4)) {
        self stoplocalsound(var_03.var_D5E4);
      }

      if(isDefined(var_03.var_D5DD)) {
        self stoplocalsound(var_03.var_D5DD);
      }
    }

    if(isDefined(param_00.var_A4A3)) {
      param_00.var_A4A3 scripts\mp\bots\_bots_strategy::bot_guard_player(self, 350);
    }

    self notify("stop_odin");
  }
}

func_108F5() {
  self.var_98FF = 0;
  var_00 = self[[level.getspawnpoint]]();
  var_01 = var_00.origin;
  var_02 = var_00.angles;
  self.angles = var_02;
  self setorigin(var_01, 1);
  foreach(var_04 in level.players) {
    if(var_04 != self) {
      self showtoplayer(var_04);
    }
  }
}

func_10DD8() {
  var_00 = undefined;
  if(self.team == "allies") {
    var_00 = "axis";
  } else if(self.team == "axis") {
    var_00 = "allies";
  } else {}

  var_01 = anglesToForward(self.angles);
  var_02 = anglestoup(self.angles);
  foreach(var_04 in level.players) {
    if(var_04 != self) {
      self hidefromplayer(var_04);
      if(var_04.team == self.team) {
        playFX(level._effect["phase_out_friendly"], self.origin, var_01, var_02);
        continue;
      }

      playFX(level._effect["phase_out_enemy"], self.origin, var_01, var_02);
    }
  }
}

func_C6CB() {
  scripts\mp\utility::setusingremote("orbital_deployment");
}

func_C6C4() {
  if(isDefined(self)) {
    scripts\mp\utility::clearusingremote();
  }
}

func_10DD4(param_00, param_01, param_02) {
  func_10D70();
  self waittill("blackout_done");
  scripts\mp\utility::freezecontrolswrapper(1);
  level thread func_B9CB(self);
  level thread monitorgameend(self);
  level thread monitorobjectivecamera(self);
  var_03 = scripts\mp\killstreaks\_killstreaks::initridekillstreak(param_02);
  if(var_03 == "success") {
    level thread func_1285(param_00, param_01, self, param_02);
  } else {
    self notify("end_kill_streak");
    func_C6C4();
    scripts\engine\utility::allow_usability(1);
    scripts\engine\utility::allow_weapon_switch(1);
  }

  level thread scripts\mp\utility::teamplayercardsplash(level.var_C6D7["orbital_deployment"].teamsplash, self);
}

func_1285(param_00, param_01, param_02, param_03) {
  param_02.var_98FF = 1;
  var_04 = 0;
  var_05 = param_00;
  var_06 = param_01;
  var_07 = vectornormalize(var_06 - var_05);
  var_06 = var_07 * 14000 + var_05;
  var_08 = scripts\mp\utility::_magicbullet("drone_hive_projectile_mp", var_06 - (0, 0, 5000), var_05, param_02);
  var_08 give_player_next_weapon(1);
  var_09 = spawn("script_model", var_08.origin);
  var_09 setModel("jsp_drop_pod_top");
  var_09 linkto(var_08, "tag_origin");
  var_09 setotherent(var_08);
  var_09.team = param_02.team;
  var_09.triggerportableradarping = param_02;
  var_09 scripts\mp\killstreaks\_utility::func_1843(param_03, "Killstreak_Air", var_09.triggerportableradarping, 1);
  if(scripts\mp\utility::isreallyalive(param_02)) {
    param_02 func_10DD8();
  }

  if(isDefined(param_02.fauxdeath) && param_02.fauxdeath) {
    param_02.faux_spawn_stance = param_02 getstance();
    param_02 thread scripts\mp\playerlogic::spawnplayer(0);
    var_04 = 1;
  }

  param_02 setorigin(var_08.origin + (0, 0, 10), 1);
  var_08 thread func_13A22("large_rod");
  var_08.team = param_02.team;
  var_08.type = "remote";
  var_08.triggerportableradarping = param_02;
  var_08 thread scripts\mp\killstreaks\_remotemissile::handledamage();
  level.remotemissileinprogress = 1;
  level thread monitordeath(var_08, 1);
  level thread monitorboost(var_08);
  func_C6D6(param_02, var_08);
  param_02 setclientomnvar("ui_predator_missile", 3);
  param_02 setclientomnvar("ui_predator_missiles_left", 0);
  playFX(level._effect["drop_pod_atmo"], var_08.origin);
  var_08 thread func_5821();
  var_08 thread func_13AA4(param_02);
  var_08 thread func_13AA3(param_02);
  for(;;) {
    var_0A = var_08 scripts\engine\utility::waittill_any_return("death", "missileTargetSet");
    scripts\mp\hostmigration::waittillhostmigrationdone();
    if(var_0A == "death") {
      break;
    }

    if(!isDefined(var_08)) {
      break;
    }
  }

  if(isDefined(var_08)) {
    param_00 = var_08.origin;
    if(isDefined(param_02)) {
      param_02 scripts\mp\matchdata::logkillstreakevent(param_03, var_08.origin);
    }
  }

  level thread func_E474(param_02, undefined, param_00, var_09, var_04);
}

monitorboost(param_00) {
  param_00 endon("death");
  for(;;) {
    param_00.triggerportableradarping waittill("missileTargetSet");
    param_00 notify("missileTargetSet");
  }
}

func_C6D6(param_00, param_01) {
  param_00 scripts\mp\utility::freezecontrolswrapper(1);
  param_00 cameralinkto(param_01, "tag_origin");
  param_00 controlslinkto(param_01);
  param_00 visionsetmissilecamforplayer("default", 0);
  param_00 thread scripts\mp\utility::set_visionset_for_watching_players("default", 0, undefined, 1);
  param_00 visionsetmissilecamforplayer(game["thermal_vision"], 1);
  param_00 thread delayedfofoverlay();
}

delayedfofoverlay() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(0.25);
  self thermalvisionfofoverlayon();
}

func_13A22(param_00) {
  self waittill("explode", var_01);
  if(param_00 == "small_rod") {
    playrumbleonposition("grenade_rumble", var_01);
    earthquake(0.7, 1, var_01, 1000);
    return;
  }

  if(param_00 == "large_rod") {
    playrumbleonposition("artillery_rumble", var_01);
    earthquake(1, 1, var_01, 2000);
  }
}

func_13AA4(param_00) {
  param_00 endon("killstreak_disowned");
  param_00 endon("disconnect");
  level endon("game_ended");
  self endon("death");
  for(;;) {
    level waittill("host_migration_begin");
    if(isDefined(self)) {
      param_00 visionsetmissilecamforplayer(game["thermal_vision"], 0);
      param_00 scripts\mp\utility::set_visionset_for_watching_players("default", 0, undefined, 1);
      param_00 thermalvisionfofoverlayon();
      continue;
    }

    param_00 setclientomnvar("ui_predator_missile", 2);
  }
}

func_13AA3(param_00) {
  param_00 endon("killstreak_disowned");
  param_00 endon("disconnect");
  level endon("game_ended");
  self endon("death");
  for(;;) {
    level waittill("host_migration_end");
    if(isDefined(self)) {
      param_00 setclientomnvar("ui_predator_missile", 3);
      continue;
    }

    param_00 setclientomnvar("ui_predator_missile", 2);
  }
}

func_B9CB(param_00) {
  param_00 endon("disconnect");
  param_00 endon("end_kill_streak");
  param_00 waittill("killstreak_disowned");
  level thread func_E474(param_00);
}

monitorgameend(param_00) {
  param_00 endon("disconnect");
  param_00 endon("end_kill_streak");
  level waittill("game_ended");
  level thread func_E474(param_00);
}

monitorobjectivecamera(param_00) {
  param_00 endon("end_kill_streak");
  param_00 endon("disconnect");
  level waittill("objective_cam");
  level thread func_E474(param_00, 1);
}

monitordeath(param_00, param_01) {
  param_00 waittill("death");
  scripts\mp\hostmigration::waittillhostmigrationdone();
  if(isDefined(param_00.var_114F1)) {
    param_00.var_114F1 delete();
  }

  if(isDefined(param_00.entitynumber)) {
    level.rockets[param_00.entitynumber] = undefined;
  }

  if(param_01) {
    level.remotemissileinprogress = undefined;
  }
}

func_E474(param_00, param_01, param_02, param_03, param_04) {
  if(!isDefined(param_00)) {
    if(isDefined(param_03)) {
      param_03 thread func_51B1();
    }

    return;
  }

  param_00 setclientomnvar("ui_predator_missile", 2);
  param_00 notify("end_kill_streak");
  param_00 notify("orbital_deployment_complete");
  param_00 thermalvisionfofoverlayoff();
  param_00 controlsunlink();
  if(!isDefined(param_01)) {
    scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(0.95);
  }

  param_00 cameraunlink();
  param_00 setclientomnvar("ui_predator_missile", 0);
  if(!param_04) {
    param_00 func_C6C4();
    param_00 scripts\engine\utility::allow_weapon_switch(1);
  } else {
    param_00 scripts\engine\utility::allow_offhand_weapons(0);
    param_00 scripts\engine\utility::allow_weapon_switch(0);
    param_00 func_C6C4();
    param_00 scripts\engine\utility::allow_weapon_switch(1);
  }

  param_00 scripts\mp\utility::freezecontrolswrapper(0);
  param_00 scripts\engine\utility::allow_usability(1);
  if(isDefined(param_02)) {
    param_00 func_10D89(param_02, param_03);
  }
}

func_10D89(param_00, param_01) {
  var_02 = spawn("script_model", param_00);
  var_02.angles = self.angles;
  var_02.triggerportableradarping = self;
  var_02.team = self.team;
  self.var_98FF = 0;
  self setorigin(param_00 + (0, 0, 15), 1);
  foreach(var_04 in level.players) {
    if(var_04 != self) {
      self showtoplayer(var_04);
    }
  }

  self notify("weapon_change", self getcurrentweapon());
  param_01 thread func_51B1();
}

func_51B1() {
  wait(0.7);
  playFX(scripts\engine\utility::getfx("trophy_spark_fx"), self.origin);
  self delete();
}

func_10D70() {
  var_00 = newclienthudelem(self);
  var_00.x = 0;
  var_00.y = 0;
  var_00.alignx = "left";
  var_00.aligny = "top";
  var_00.sort = 1;
  var_00.horzalign = "fullscreen";
  var_00.vertalign = "fullscreen";
  var_00.foreground = 1;
  var_00 setshader("black", 640, 480);
  thread func_50E0(var_00, 0, 0.05, 1);
  var_01 = 0.1;
  childthread func_50DE(var_00, var_01);
}

func_50E0(param_00, param_01, param_02, param_03) {
  self endon("disconnect");
  wait(param_01);
  param_00 fadeovertime(param_02);
}

func_50DE(param_00, param_01) {
  wait(param_01);
  param_00 destroy();
  self notify("blackout_done");
}

func_5821() {
  wait(0.5);
  playFX(level._effect["drop_pod_fx"], self.origin);
  wait(0.3);
  playFX(level._effect["drop_pod_fx"], self.origin);
  wait(0.3);
  playFX(level._effect["drop_pod_fx"], self.origin);
}

func_D39C(param_00) {
  var_01 = self.pers["killstreaks"];
  for(var_02 = 0; var_02 <= 3; var_02++) {
    var_03 = var_01[var_02];
    if(isDefined(var_03) && var_03.streakname == param_00 && var_03.var_269A) {
      return 1;
    }
  }

  return 0;
}