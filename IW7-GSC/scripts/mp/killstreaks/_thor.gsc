/********************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\mp\killstreaks\_thor.gsc
********************************************/

init() {
  scripts\mp\killstreaks\_killstreaks::registerkillstreak("thor", ::func_12909, undefined, undefined, undefined, ::func_13C8E, undefined, ::func_13099, ::weaponswitchendedairstrike);
  level._effect["thor_clouds"] = loadfx("vfx\core\mp\killstreaks\odin\odin_parallax_clouds");
  level._effect["thor_fisheye"] = loadfx("vfx\iw7\_requests\mp\vfx_scrnfx_thor_fisheye.vfx");
  level._effect["thor_targeting"] = loadfx("vfx\core\mp\killstreaks\odin\vfx_marker_odin_cyan");
  level._effect["thor_target_mark"] = loadfx("vfx\iw7\_requests\mp\vfx_marker_map_target");
  level._effect["thor_explode"] = loadfx("vfx\iw7\core\mp\killstreaks\vfx_veh_exp_thor.vfx");
  level.var_117B0 = [];
  level.var_117B0["thor"] = spawnStruct();
  level.var_117B0["thor"].timeout = 60;
  level.var_117B0["thor"].maxhealth = 2600;
  level.var_117B0["thor"].streakname = "thor";
  level.var_117B0["thor"].vehicleinfo = "thor_mp";
  level.var_117B0["thor"].modelbase = "veh_mil_air_thor_wm";
  level.var_117B0["thor"].teamsplash = "used_thor";
  level.var_117B0["thor"].votimedout = "loki_gone";
  level.var_117B0["thor"].var_1352D = "odin_target_killed";
  level.var_117B0["thor"].var_1352C = "odin_targets_killed";
  level.var_117B0["thor"].var_12B20 = 4;
  level.var_117B0["thor"].var_12B80 = &"KILLSTREAKS_LOKI_UNAVAILABLE";
  level.var_117B0["thor"].var_73BE = "compass_objpoint_airstrike_friendly";
  level.var_117B0["thor"].var_6485 = "compass_objpoint_airstrike_busy";
  level.var_117B0["thor"].var_394["missile"] = spawnStruct();
  level.var_117B0["thor"].var_394["missile"].var_39C = "thorproj_mp";
  level.var_117B0["thor"].var_394["missile"].var_13FCB = "thorproj_zoomed_mp";
  level.var_117B0["thor"].var_394["missile"].projectile = "thorproj_mp";
  level.var_117B0["thor"].var_394["missile"].var_E7BA = "heavygun_fire";
  level.var_117B0["thor"].var_394["missile"].var_DF5C = 0.1;
  level.var_117B0["thor"].var_394["missile"].var_B47C = 5;
  level.var_117B0["thor"].var_394["missile"].var_D5E4 = "null";
  level.var_117B0["thor"].var_394["missile"].var_D5DD = "null";
  level.var_117B0["thor"].var_394["missile"].var_C195 = "null";
  level.var_C20D = 0;
  var_00 = ["passive_increased_armor", "passive_decreased_duration", "passive_seek_cluster", "passive_no_cursor", "passive_switch_thruster", "passive_armor_duration"];
  scripts\mp\killstreak_loot::func_DF07("thor", var_00);
}

func_13C8E(param_00) {
  var_01 = 1;
  if(scripts\mp\utility::currentactivevehiclecount() >= scripts\mp\utility::maxvehiclesallowed() || level.fauxvehiclecount + var_01 >= scripts\mp\utility::maxvehiclesallowed()) {
    scripts\mp\hud_message::showerrormessage("KILLSTREAKS_TOO_MANY_VEHICLES");
    return 0;
  }

  level.var_C20D++;
  if(level.var_C20D > 1) {
    scripts\mp\hud_message::showerrormessage("KILLSTREAKS_TOO_MANY_THORS");
    level.var_C20D--;
    return 0;
  }

  thread func_13B73();
  self setclientomnvar("ui_remote_control_sequence", 1);
  return 1;
}

func_13B73() {
  self endon("thor_weapon_switch_ended");
  level endon("game_ended");
  scripts\engine\utility::waittill_any_3("death", "disconnect");
  if(isDefined(level.var_C20D) && level.var_C20D > 0) {
    level.var_C20D--;
  }

  if(isDefined(self)) {
    self setclientomnvar("ui_remote_control_sequence", 0);
  }
}

weaponswitchendedairstrike(param_00, param_01) {
  self notify("thor_weapon_switch_ended");
  if(!scripts\mp\utility::istrue(param_01)) {
    if(isDefined(level.var_C20D) && level.var_C20D > 0) {
      level.var_C20D--;
    }

    self setclientomnvar("ui_remote_control_sequence", 0);
  }
}

func_13099(param_00) {
  level.var_C20D--;
  self setclientomnvar("ui_remote_control_sequence", 0);
}

func_12909(param_00) {
  var_01 = scripts\mp\killstreaks\_killstreaks::func_D507(param_00);
  if(!var_01) {
    level.var_C20D--;
    return 0;
  }

  var_01 = func_10DFC(param_00);
  if(!isDefined(var_01)) {
    var_01 = 0;
  }

  return var_01;
}

func_10DFC(param_00) {
  self.var_117AF = spawn("script_model", level.var_12AF6);
  self.var_117AF setModel("tag_origin");
  self.var_117AF.angles = (0, 115, 0);
  self.var_117AF.triggerportableradarping = self;
  self.var_117AF hide();
  self.var_117AF thread func_E731(-360, 60, "thor_fire_thrusters", "thor_switch_thrusters");
  self.thorrigangle = -360;
  self.restoreangles = vectortoangles(anglesToForward(self.angles));
  scripts\mp\utility::incrementfauxvehiclecount();
  var_01 = func_4A26(param_00.streakname, param_00);
  if(!isDefined(var_01)) {
    level.var_C20D--;
    scripts\mp\utility::decrementfauxvehiclecount();
    thread scripts\mp\killstreaks\_killstreaks::func_11086();
    return 0;
  }

  return 1;
}

func_E731(param_00, param_01, param_02, param_03) {
  self endon("death");
  self.triggerportableradarping endon("disconnect");
  if(isDefined(param_02)) {
    self.triggerportableradarping endon(param_02);
  }

  if(isDefined(param_03)) {
    self.triggerportableradarping endon(param_03);
  }

  if(!isDefined(param_00)) {
    param_00 = -360;
  }

  if(!isDefined(param_01)) {
    param_01 = 60;
  }

  for(;;) {
    self rotateyaw(param_00, param_01);
    wait(param_01);
  }
}

func_4A26(param_00, param_01) {
  var_02 = level.var_117B0[param_00];
  var_03 = randomint(360);
  var_04 = 7000;
  var_05 = 10000;
  var_06 = cos(var_03) * var_04;
  var_07 = sin(var_03) * var_04;
  var_08 = vectornormalize((var_06, var_07, var_05));
  var_08 = var_08 * var_04;
  var_09 = self.var_117AF.origin + var_08 + (0, 0, 1000);
  var_0A = self.var_117AF.origin + var_08;
  var_0B = var_02.modelbase;
  var_0C = scripts\mp\killstreak_loot::getrarityforlootitem(param_01.variantid);
  if(var_0C != "") {
    var_0B = var_0B + "_" + var_0C;
  }

  var_0D = spawn("script_model", var_09);
  if(!isDefined(var_0D)) {
    return undefined;
  }

  var_0D setModel(var_0B);
  var_0D.team = self.team;
  var_0D.triggerportableradarping = self;
  var_0D.health = 99999;
  var_0D.numflares = 1;
  var_0D.var_C239 = var_02.var_394["missile"].var_B47C;
  var_0D.var_C238 = 0;
  var_0D.var_B88C = func_989D("ID");
  var_0D.var_B888 = func_989D("Distance");
  var_0D.var_B47C = var_02.var_394["missile"].var_B47C;
  var_0D.var_DF5C = var_02.var_394["missile"].var_DF5C;
  var_0D.zoffset = 10000;
  var_0D.streakname = param_00;
  var_0D.var_117B2 = 1;
  var_0D.streakinfo = param_01;
  var_0D.basemodel = var_0B;
  var_0D setCanDamage(1);
  var_0D setotherent(self);
  var_0D setscriptablepartstate("body", "hide", 0);
  var_0D.angles = vectortoangles(self.var_117AF.origin - (var_0D.origin[0], var_0D.origin[1], self.var_117AF.origin[2]));
  var_0D.var_10E4C = func_495B();
  thread func_117AE(var_0D, var_0A);
  return var_0D;
}

func_117AE(param_00, param_01) {
  param_00 endon("death");
  level endon("game_ended");
  param_00.triggerportableradarping playlocalsound("thor_init_plr");
  param_00 moveto(param_01, 1);
  param_00 scriptmodelplayanim("iw7_mp_killstreak_thor_idle", 1);
  param_00 setscriptablepartstate("thrusters", "drop", 0);
  scripts\mp\shellshock::_earthquake(0.15, 2, param_00.origin, 2000);
  var_02 = level.var_117B0[param_00.streakname];
  if(getdvarint("camera_thirdPerson")) {
    scripts\mp\utility::setthirdpersondof(0);
  }

  var_03 = var_02.var_394["missile"].var_39C;
  var_04 = var_02.var_394["missile"].var_13FCB;
  param_00.primaryweapon = var_03;
  param_00.secondaryweapon = var_04;
  param_00.triggerportableradarping scripts\mp\utility::_giveweapon(var_03);
  param_00.triggerportableradarping scripts\mp\utility::_giveweapon(var_04);
  param_00.triggerportableradarping scripts\mp\utility::_switchtoweaponimmediate(var_03);
  param_00.triggerportableradarping playerlinkweaponviewtodelta(param_00, "tag_player", 0, 180, 180, 45, 180);
  param_00.triggerportableradarping _meth_8236(0);
  param_00.triggerportableradarping _meth_85A2(getthormapvisionset(level.mapname));
  param_00.triggerportableradarping thread func_B011(param_00);
  param_00.triggerportableradarping setclientomnvar("ui_thor_show", 1);
  param_00.triggerportableradarping setclientomnvar("ui_thor_missiles_loaded", var_02.var_394["missile"].var_B47C);
  param_00.triggerportableradarping thermalvisionfofoverlayon();
  param_00.triggerportableradarping thermalvisionon();
  for(var_05 = 0; var_05 < 5; var_05++) {
    param_00.triggerportableradarping setclientomnvar(param_00.var_B88C[var_05].omnvar, undefined);
    param_00.triggerportableradarping setclientomnvar(param_00.var_B888[var_05].omnvar, -1);
  }

  param_00.triggerportableradarping _meth_82C0("thor_killstreak", 1);
  var_06 = var_02.teamsplash;
  var_07 = scripts\mp\killstreak_loot::getrarityforlootitem(param_00.streakinfo.variantid);
  if(var_07 != "") {
    var_06 = var_06 + "_" + var_07;
  }

  level thread scripts\mp\utility::teamplayercardsplash(var_06, self);
  param_00.triggerportableradarping scripts\engine\utility::allow_weapon_switch(0);
  param_00 func_8ED7(param_00.basemodel);
  param_00 thread func_117A7();
  param_00 thread func_117A0();
  param_00 thread func_117A9();
  wait(0.5);
  param_00 scriptmodelplayanim("iw7_mp_killstreak_thor_extend", 1);
  wait(0.5);
  param_00 scriptmodelplayanim("iw7_mp_killstreak_thor_extend_idle", 1);
  param_00 setscriptablepartstate("thrusters", "idle", 0);
  scripts\mp\shellshock::_earthquake(0.2, 0.76, param_00.origin, 1000);
  param_00 linkto(self.var_117AF, "tag_origin");
  param_00 scripts\mp\killstreaks\_utility::func_1843(param_00.streakname, undefined, param_00.triggerportableradarping, 1);
  var_08 = "icon_minimap_thor_friendly";
  param_00.minimapid = param_00 scripts\mp\killstreaks\_airdrop::createobjective(var_08, undefined, 1, 1, 1);
  var_09 = var_02.timeout;
  if(scripts\mp\killstreaks\_utility::func_A69F(param_00.streakinfo, "passive_armor_duration")) {
    var_09 = var_09 - 5;
  }

  param_00 thread func_1179D(param_00.triggerportableradarping);
  param_00 thread func_117AC(var_09);
  param_00 thread func_117AA();
  param_00 thread func_1179F();
  param_00 thread func_117AD();
  param_00 thread func_117AB();
  param_00 thread func_117A2();
  if(scripts\mp\killstreaks\_utility::func_A69F(param_00.streakinfo, "passive_switch_thruster")) {
    param_00 thread thor_watchswitchthrust(param_00.triggerportableradarping);
  }

  param_00 thread func_117A3();
  param_00 thread func_1179E();
  param_00 thread func_117A5();
  param_00 thread func_117A1();
  param_00 thread func_117A8();
  param_00 thread func_11790();
  param_00 thread watchhostmigrationfinishedinit(self, var_02);
  param_00.triggerportableradarping scripts\mp\matchdata::logkillstreakevent(param_00.streakname, self.origin);
  param_00.triggerportableradarping scripts\engine\utility::allow_usability(0);
  param_00.triggerportableradarping setclientomnvar("ui_killstreak_countdown", gettime() + int(var_09 * 1000));
  param_00.triggerportableradarping setclientomnvar("ui_killstreak_health", var_02.maxhealth / 2600);
}

func_8ED7(param_00) {
  self hidepart("j_backend", param_00);
  self hidepart("j_shield_1", param_00);
  self hidepart("j_shield_2", param_00);
  self hidepart("j_shield_3", param_00);
  self hidepart("j_shield_4", param_00);
  self hidepart("j_nose", param_00);
}

func_989D(param_00) {
  var_01 = [];
  switch (param_00) {
    case "ID":
      for(var_02 = 0; var_02 < 5; var_02++) {
        var_03 = spawnStruct();
        var_03.omnvar = "ui_thor_missile_" + var_02;
        var_03.inuse = 0;
        var_01[var_01.size] = var_03;
      }
      break;

    case "Distance":
      for(var_02 = 0; var_02 < 5; var_02++) {
        var_03 = spawnStruct();
        var_03.omnvar = "ui_thor_missile_" + var_02 + "_dist";
        var_03.inuse = 0;
        var_01[var_01.size] = var_03;
      }
      break;
  }

  return var_01;
}

watchhostmigrationfinishedinit(param_00, param_01) {
  param_00 endon("disconnect");
  param_00 endon("joined_team");
  param_00 endon("joined_spectators");
  param_00 endon("killstreak_disowned");
  level endon("game_ended");
  self endon("death");
  self endon("leaving");
  for(;;) {
    level waittill("host_migration_end");
    param_00 thermalvisionfofoverlayon();
    if(scripts\mp\utility::istrue(self.var_117B2)) {
      param_00 thermalvisionon();
      continue;
    }

    param_00 thermalvisionoff();
  }
}

func_B011(param_00) {
  self endon("disconnect");
  level endon("game_ended");
  param_00 endon("death");
  wait(0.05);
  var_01 = vectortoangles(level.var_12AF5.origin - param_00 gettagorigin("tag_player"));
  self setplayerangles(var_01);
}

func_1369B(param_00) {
  self endon("disconnect");
  param_00 endon("death");
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(1);
  var_01 = scripts\mp\utility::outlineenableforplayer(self, "cyan", self, 0, 0, "killstreak");
  param_00 thread removeoutline(var_01, self);
}

waitanddelete(param_00) {
  self endon("death");
  level endon("game_ended");
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(param_00);
  self delete();
}

func_1179A(param_00) {
  scripts\mp\utility::setusingremote(param_00.streakname);
}

func_1178F(param_00) {
  if(isDefined(self)) {
    scripts\mp\utility::clearusingremote();
  }
}

func_1179C(param_00) {
  while(isDefined(self.var_9BE2) && param_00 > 0) {
    wait(0.05);
    param_00 = param_00 - 0.05;
  }
}

func_1179D(param_00) {
  param_00 endon("disconnect");
  level endon("game_ended");
  for(;;) {
    var_01 = scripts\engine\utility::waittill_any_return("start_fire", "start_reload", "death", "leaving");
    if(var_01 == "death" || var_01 == "leaving") {
      break;
    }

    param_00 scripts\engine\utility::allow_fire(0);
    scripts\engine\utility::waittill_any_3("finished_single_fire", "finished_reload", "death", "leaving");
    param_00 scripts\engine\utility::allow_fire(1);
  }
}

func_117A0() {
  level endon("game_ended");
  self endon("leaving");
  self waittill("death");
  if(isDefined(self.triggerportableradarping)) {
    self.triggerportableradarping func_11791(self);
    self.triggerportableradarping setclientomnvar("ui_thor_show", 0);
    self.triggerportableradarping setclientomnvar("ui_killstreak_countdown", 0);
    self.triggerportableradarping setclientomnvar("ui_killstreak_health", 0);
    self.triggerportableradarping setclientomnvar("ui_killstreak_missile_warn", 0);
    self.triggerportableradarping clearclienttriggeraudiozone(1);
    self.triggerportableradarping stoprumble("thor_thrust_rumble");
    foreach(var_01 in self.var_B88C) {
      self.triggerportableradarping setclientomnvar(var_01.omnvar, undefined);
    }

    foreach(var_04 in self.var_B888) {
      self.triggerportableradarping setclientomnvar(var_04.omnvar, -1);
    }
  }

  func_4074();
  scripts\mp\utility::decrementfauxvehiclecount();
  playFX(scripts\engine\utility::getfx("thor_explode"), self.origin);
  self delete();
}

func_117AC(param_00) {
  level endon("game_ended");
  self endon("death");
  self endon("leaving");
  self endon("host_migration_lifetime_update");
  self.triggerportableradarping endon("disconnect");
  self.triggerportableradarping endon("joined_team");
  self.triggerportableradarping endon("joined_spectators");
  thread scripts\mp\killstreaks\_utility::watchhostmigrationlifetime("leaving", param_00, ::func_117AC);
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(param_00);
  func_1179C(3);
  var_01 = ["thor_end", "thor_timeout"];
  var_02 = randomint(var_01.size);
  var_03 = var_01[var_02];
  self.triggerportableradarping scripts\mp\utility::playkillstreakdialogonplayer(var_03, undefined, undefined, self.triggerportableradarping.origin);
  thread func_11795();
}

func_117A7() {
  level endon("game_ended");
  self endon("death");
  self endon("leaving");
  self.triggerportableradarping scripts\engine\utility::waittill_any_3("disconnect", "joined_team", "joined_spectators");
  self notify("death");
}

func_117A5() {
  level endon("game_ended");
  self endon("death");
  self endon("leaving");
  self.triggerportableradarping endon("disconnect");
  self.triggerportableradarping endon("joined_team");
  self.triggerportableradarping endon("joined_spectators");
  level waittill("objective_cam");
  thread func_11795();
}

func_117A9() {
  self endon("death");
  self endon("leaving");
  self.triggerportableradarping endon("disconnect");
  self.triggerportableradarping endon("joined_team");
  self.triggerportableradarping endon("joined_spectators");
  level scripts\engine\utility::waittill_any_3("round_end_finished", "game_ended");
  var_00 = 1;
  thread func_11795(var_00);
}

func_11795(param_00) {
  self endon("death");
  self notify("leaving");
  var_01 = level.var_117B0[self.streakname];
  scripts\mp\utility::leaderdialog(var_01.votimedout);
  if(isDefined(self.triggerportableradarping)) {
    self.triggerportableradarping func_11791(self, param_00);
    self.triggerportableradarping setclientomnvar("ui_thor_show", 0);
    self.triggerportableradarping setclientomnvar("ui_killstreak_countdown", 0);
    self.triggerportableradarping setclientomnvar("ui_killstreak_health", 0);
    self.triggerportableradarping setclientomnvar("ui_killstreak_missile_warn", 0);
    self.triggerportableradarping clearclienttriggeraudiozone(1);
    self.triggerportableradarping stoprumble("thor_thrust_rumble");
    foreach(var_03 in self.var_B88C) {
      self.triggerportableradarping setclientomnvar(var_03.omnvar, undefined);
    }

    foreach(var_06 in self.var_B888) {
      self.triggerportableradarping setclientomnvar(var_06.omnvar, -1);
    }
  }

  self notify("gone");
  self scriptmodelplayanim("iw7_mp_killstreak_thor_extend_to_up", 1);
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(1);
  self moveto(self.origin + (0, 0, 15000), 5, 3.5);
  self scriptmodelplayanim("iw7_mp_killstreak_thor_extend_up", 1);
  self setscriptablepartstate("thrusters", "leave", 0);
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(5);
  func_4074();
  scripts\mp\utility::decrementfauxvehiclecount();
  self delete();
}

func_11791(param_00, param_01) {
  var_02 = level.var_117B0[param_00.streakname];
  scripts\mp\utility::printgameaction("killstreak ended - thor", self);
  if(isDefined(param_00)) {
    param_00 notify("end_remote");
    self notify("thor_ride_ended");
    scripts\engine\utility::allow_usability(1);
    if(getdvarint("camera_thirdPerson")) {
      scripts\mp\utility::setthirdpersondof(1);
    }

    self thermalvisionfofoverlayoff();
    self thermalvisionoff();
    self _meth_85A2("");
    self unlink();
    self setplayerangles(self.restoreangles);
    if(scripts\mp\utility::istrue(param_01)) {
      scripts\mp\utility::func_1136C(scripts\engine\utility::getlastweapon(), 1);
    } else {
      thread func_11794();
    }

    self stoplocalsound("odin_negative_action");
    self stoplocalsound("odin_positive_action");
    foreach(var_04 in level.var_117B0[param_00.streakname].var_394) {
      if(isDefined(var_04.var_D5E4)) {
        self stoplocalsound(var_04.var_D5E4);
      }

      if(isDefined(var_04.var_D5DD)) {
        self stoplocalsound(var_04.var_D5DD);
      }
    }

    thread scripts\mp\killstreaks\_killstreaks::func_11086();
    if(isDefined(self.var_117AF)) {
      self.var_117AF delete();
    }

    thread scripts\mp\utility::_takeweapon(param_00.primaryweapon);
    thread scripts\mp\utility::_takeweapon(param_00.secondaryweapon);
    scripts\engine\utility::allow_weapon_switch(1);
  }
}

func_11794() {
  self endon("disconnect");
  self endon("death");
  level endon("game_ended");
  scripts\mp\utility::freezecontrolswrapper(1);
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(0.5);
  scripts\mp\utility::freezecontrolswrapper(0);
}

func_117AA() {
  self endon("death");
  self endon("leaving");
  level endon("game_ended");
  var_00 = self.triggerportableradarping;
  var_00 endon("disconnect");
  var_01 = spawn("script_model", (0, 0, 0));
  var_01.angles = vectortoangles((0, 0, 1));
  var_01 setModel("tag_origin");
  var_01 hide();
  self.targeting_marker = var_01;
  self _meth_8549();
  self _meth_8594();
  for(;;) {
    var_02 = var_00 getvieworigin() - (0, 0, 50);
    var_03 = var_02 + anglesToForward(var_00 getplayerangles()) * -15536;
    var_04 = ["physicscontents_clipshot", "physicscontents_corpseclipshot", "physicscontents_missileclip", "physicscontents_solid", "physicscontents_vehicle"];
    var_05 = physics_createcontents(var_04);
    var_06 = scripts\common\trace::ray_trace(var_02, var_03, level.characters, var_05);
    var_01.origin = var_06["position"] + (0, 0, 50);
    scripts\engine\utility::waitframe();
  }
}

func_1179F() {
  self endon("death");
  self endon("leaving");
  var_00 = self.triggerportableradarping;
  var_00 endon("disconnect");
  var_01 = level.var_117B0[self.streakname];
  var_02 = var_01.maxhealth;
  var_03 = 0;
  var_04 = 3;
  var_05 = 4;
  var_06 = 5;
  if(scripts\mp\killstreaks\_utility::func_A69F(self.streakinfo, "passive_armor_duration")) {
    var_04++;
    var_05++;
    var_06++;
  }

  for(;;) {
    self waittill("damage", var_07, var_08, var_09, var_0A, var_0B, var_0C, var_0D, var_0E, var_0F, var_10, var_11, var_12, var_13, var_14);
    var_10 = scripts\mp\utility::func_13CA1(var_10, var_14);
    if(isDefined(var_08)) {
      if(isDefined(var_08.triggerportableradarping)) {
        var_08 = var_08.triggerportableradarping;
      }

      if(isDefined(var_08.team) && var_08.team == self.team && var_08 != self.triggerportableradarping) {
        continue;
      }
    }

    if(scripts\mp\equipment\phase_shift::isentityphaseshifted(var_08)) {
      continue;
    }

    if(isDefined(var_0B)) {
      var_00 func_4CF1(self, var_0B);
    }

    if(isDefined(var_10)) {
      var_07 = scripts\mp\killstreaks\_utility::getmodifiedantikillstreakdamage(var_08, var_10, var_0B, var_07, var_01.maxhealth, var_04, var_05, var_06);
      if(scripts\mp\killstreaks\_utility::func_A69F(self.streakinfo, "passive_armor_duration")) {
        if(scripts\mp\killstreaks\_utility::isexplosiveantikillstreakweapon(var_10)) {
          var_08 scripts\mp\damagefeedback::updatedamagefeedback("hitblastshield");
        }
      }
    }

    var_02 = var_02 - var_07;
    var_00 setclientomnvar("ui_killstreak_health", var_02 / var_01.maxhealth);
    if(isplayer(var_08)) {
      var_08 scripts\mp\damagefeedback::updatedamagefeedback("");
      scripts\mp\killstreaks\_killstreaks::killstreakhit(var_08, var_10, self, var_0B);
      scripts\mp\damage::logattackerkillstreak(self, var_07, var_08, var_09, var_0A, var_0B, var_0C, var_0D, var_0E, var_0F, var_10);
      if(var_02 <= 0) {
        var_08 notify("destroyed_killstreak", var_10);
        var_15 = "callout_destroyed_thor";
        var_16 = scripts\mp\killstreak_loot::getrarityforlootitem(self.streakinfo.variantid);
        if(var_16 != "") {
          var_15 = var_15 + "_" + var_16;
        }

        scripts\mp\damage::onkillstreakkilled("thor", var_08, var_10, var_0B, var_07, "destroyed_thor", "thor_destroyed", var_15);
        return;
      }
    }
  }
}

func_4CF1(param_00, param_01) {
  switch (param_01) {
    case "MOD_GRENADE_SPLASH":
    case "MOD_GRENADE":
    case "MOD_PROJECTILE":
    case "MOD_EXPLOSIVE_BULLET":
    case "MOD_PISTOL_BULLET":
    case "MOD_RIFLE_BULLET":
      func_3239(param_00);
      break;

    case "MOD_PROJECTILE_SPLASH":
    case "MOD_IMPACT":
    case "MOD_EXPLOSIVE":
      func_69E6(param_00);
      break;

    default:
      break;
  }
}

func_3239(param_00) {
  self earthquakeforplayer(0.15, 0.25, param_00 gettagorigin("tag_player"), 50);
  self playrumbleonentity("damage_light");
  thread func_1349D(param_00, 0.4);
}

func_69E6(param_00) {
  self earthquakeforplayer(0.4, 0.45, param_00 gettagorigin("tag_player"), 1000);
  self playrumbleonentity("damage_heavy");
  thread func_1349D(param_00, 0.7);
}

func_1349D(param_00, param_01) {
  self endon("disconnect");
  level endon("game_ended");
  param_00 endon("death");
  param_00.var_10E4C.alpha = param_01;
  while(param_01 > 0) {
    scripts\engine\utility::waitframe();
    param_01 = param_01 - 0.1;
    param_00.var_10E4C.alpha = param_01;
  }
}

func_495B() {
  var_00 = newclienthudelem(self);
  var_00.x = 0;
  var_00.y = 0;
  var_00 setshader("white", 640, 480);
  var_00.alignx = "left";
  var_00.aligny = "top";
  var_00.sort = 1;
  var_00.horzalign = "fullscreen";
  var_00.vertalign = "fullscreen";
  var_00.alpha = 0;
  var_00.foreground = 1;
  return var_00;
}

func_117AD() {
  self endon("death");
  self endon("leaving");
  level endon("game_ended");
  var_00 = self.triggerportableradarping;
  var_00 endon("disconnect");
  var_01 = level.var_117B0[self.streakname];
  if(!isai(var_00)) {
    var_00 notifyonplayercommand("thor_missile_zoom_on", "+weapnext");
  }

  for(;;) {
    var_00 waittill("thor_missile_zoom_on");
    var_00 scripts\engine\utility::allow_weapon_switch(1);
    if(!isDefined(self.var_117B3)) {
      var_00 scripts\mp\utility::_switchtoweaponimmediate(self.secondaryweapon);
      self.var_117B3 = 1;
      var_00 setclientomnvar("ui_thor_show", 2);
    } else {
      var_00 scripts\mp\utility::_switchtoweaponimmediate(self.primaryweapon);
      self.var_117B3 = undefined;
      var_00 setclientomnvar("ui_thor_show", 1);
    }

    var_00 scripts\engine\utility::allow_weapon_switch(0);
  }
}

func_117AB() {
  self endon("death");
  self endon("leaving");
  level endon("game_ended");
  var_00 = self.triggerportableradarping;
  var_00 endon("disconnect");
  var_01 = level.var_117B0[self.streakname];
  if(!isai(var_00)) {
    if(var_00 scripts\engine\utility::is_player_gamepad_enabled()) {
      var_00 notifyonplayercommand("thor_thermal_toggle", "+usereload");
    }

    var_00 notifyonplayercommand("thor_thermal_toggle", "+activate");
  }

  for(;;) {
    var_00 waittill("thor_thermal_toggle");
    if(!isDefined(self.var_117B2)) {
      var_00 thermalvisionon();
      self.var_117B2 = 1;
      continue;
    }

    var_00 thermalvisionoff();
    self.var_117B2 = undefined;
  }
}

func_117A2() {
  self endon("death");
  self endon("leaving");
  var_00 = self.triggerportableradarping;
  var_00 endon("disconnect");
  if(!isai(var_00)) {
    var_00 notifyonplayercommand("thor_fire_thrusters", "+smoke");
    var_00 notifyonplayercommand("thor_release_thrusters", "-smoke");
  }

  for(;;) {
    var_01 = var_00 scripts\engine\utility::waittill_any_return("thor_fire_thrusters", "thor_release_thrusters");
    if(!isDefined(var_01)) {
      continue;
    }

    if(var_01 == "thor_fire_thrusters") {
      var_00.var_117AF thread func_E731(var_00.thorrigangle, 30, "thor_release_thrusters", "thor_switch_thrusters");
      thread func_B06B(var_00);
      if(var_00.thorrigangle == -360) {
        self scriptmodelplayanim("iw7_mp_killstreak_thor_extend_thrust", 1);
      } else {
        self scriptmodelplayanim("iw7_mp_killstreak_thor_extend_rev_thrust", 1);
      }

      self setscriptablepartstate("thrusters", "boost", 0);
      continue;
    }

    var_00.var_117AF thread func_E731(var_00.thorrigangle, 60, "thor_fire_thrusters", "thor_switch_thrusters");
    var_00 stoprumble("thor_thrust_rumble");
    if(var_00.thorrigangle == -360) {
      self scriptmodelplayanim("iw7_mp_killstreak_thor_extend_idle", 1);
    } else {
      self scriptmodelplayanim("iw7_mp_killstreak_thor_extend_rev_idle", 1);
    }

    self setscriptablepartstate("thrusters", "idle", 0);
  }
}

func_B06B(param_00) {
  self endon("death");
  param_00 endon("thor_release_thrusters");
  param_00 _meth_8244("thor_thrust_rumble");
  for(;;) {
    scripts\mp\shellshock::_earthquake(0.15, 0.05, self.origin, 1000);
    scripts\engine\utility::waitframe();
  }
}

func_B9F2(param_00) {
  self endon("death");
  level endon("game_ended");
  param_00 endon("disconnect");
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(1.5);
  var_01 = [];
  for(;;) {
    var_02 = param_00 scripts\mp\utility::get_players_watching();
    foreach(var_04 in var_01) {
      if(!scripts\engine\utility::array_contains(var_02, var_04)) {
        var_01 = scripts\engine\utility::array_remove(var_01, var_04);
        self hide();
        self showtoplayer(param_00);
      }
    }

    foreach(var_04 in var_02) {
      self showtoplayer(var_04);
      if(!scripts\engine\utility::array_contains(var_01, var_04)) {
        var_01 = scripts\engine\utility::array_add(var_01, var_04);
        stopFXOnTag(level._effect["thor_targeting"], self, "tag_origin");
        wait(0.05);
        playFXOnTag(level._effect["thor_targeting"], self, "tag_origin");
      }
    }

    wait(0.25);
  }
}

thor_watchswitchthrust(param_00) {
  self endon("death");
  self endon("leaving");
  level endon("game_ended");
  param_00 = self.triggerportableradarping;
  param_00 endon("disconnect");
  if(!isai(param_00)) {
    param_00 notifyonplayercommand("thor_switch_thrusters", "+speed_throw");
    param_00 notifyonplayercommand("thor_switch_thrusters", "+toggleads_throw");
    param_00 notifyonplayercommand("thor_switch_thrusters", "+ads_akimbo_accessible");
  }

  for(;;) {
    var_01 = param_00 scripts\engine\utility::waittill_any_return("thor_switch_thrusters");
    if(param_00.thorrigangle == -360) {
      self scriptmodelplayanim("iw7_mp_killstreak_thor_extend_rev_idle", 1);
      param_00.thorrigangle = 360;
    } else {
      self scriptmodelplayanim("iw7_mp_killstreak_thor_extend_idle", 1);
      param_00.thorrigangle = -360;
    }

    param_00.var_117AF thread func_E731(param_00.thorrigangle, 60, "thor_fire_thrusters", "thor_switch_thrusters");
  }
}

thor_watchdebugtogglemovement(param_00) {
  self endon("death");
  self endon("leaving");
  level endon("game_ended");
  param_00 endon("disconnect");
  if(!isai(param_00)) {
    param_00 notifyonplayercommand("thor_toggle_movement", "+speed_throw");
    param_00 notifyonplayercommand("thor_toggle_movement", "+toggleads_throw");
    param_00 notifyonplayercommand("thor_toggle_movement", "+ads_akimbo_accessible");
  }

  var_01 = 1;
  for(;;) {
    var_02 = param_00 scripts\engine\utility::waittill_any_return("thor_toggle_movement");
    if(scripts\mp\utility::istrue(var_01)) {
      self unlink();
      var_01 = 0;
      continue;
    }

    self linkto(param_00.var_117AF, "tag_origin");
    var_01 = 1;
  }
}

func_117A3() {
  self endon("death");
  self endon("leaving");
  level endon("game_ended");
  var_00 = self.triggerportableradarping;
  var_00 endon("disconnect");
  var_01 = "missile";
  var_02 = level.var_117B0[self.streakname].var_394[var_01];
  for(;;) {
    var_00 waittill("missile_fire", var_03, var_04);
    if(scripts\mp\utility::istrue(self.var_9BE2)) {
      continue;
    }

    if(scripts\mp\utility::istrue(self.var_9C9F)) {
      continue;
    }

    if(isDefined(level.hostmigrationtimer)) {
      continue;
    }

    if(isDefined(self.var_C239) && self.var_C239 < 1) {
      continue;
    }

    if(isDefined(var_04) && var_04 != "thorproj_mp" && var_04 != "thorproj_zoomed_mp") {
      continue;
    }

    self setscriptablepartstate("muzzle", "fire", 0);
    thread func_5104(0.1);
    var_03.streakinfo = self.streakinfo;
    if(isDefined(var_04) && var_04 == "thorproj_mp") {
      var_03 thread func_139D1(var_00, var_01, self);
      continue;
    }

    var_03 thread func_13B42(var_00, self);
  }
}

func_5104(param_00) {
  self endon("death");
  wait(param_00);
  self setscriptablepartstate("muzzle", "neutral", 0);
}

func_139D1(param_00, param_01, param_02) {
  param_00 endon("disconnect");
  param_02 endon("death");
  var_03 = param_02.targeting_marker;
  var_04 = param_02.var_B88C;
  var_05 = param_02.var_B888;
  var_06 = self.angles;
  param_02.var_9BE2 = 1;
  param_02 notify("start_fire");
  var_07 = var_03.origin;
  var_08 = scripts\mp\killstreaks\_utility::func_7E92(param_00);
  var_09 = [];
  foreach(var_0B in var_08) {
    if(!scripts\mp\killstreaks\_utility::manualmissilecantracktarget(var_0B)) {
      continue;
    }

    if(param_00 worldpointinreticle_circle(var_0B.origin, 65, 55)) {
      var_09[var_09.size] = var_0B;
    }
  }

  self waittill("explode", var_0D);
  var_0E = param_02.var_C239;
  var_0F = "thorproj_tracking_mp";
  for(var_10 = 0; var_10 < var_0E; var_10++) {
    if(!isDefined(param_02)) {
      break;
    }

    var_11 = randomint(360);
    var_12 = anglestoright(var_06) * cos(var_11);
    var_13 = anglesToForward(var_06) * 3;
    var_14 = anglestoup(var_06) * sin(var_11);
    var_15 = var_12 + var_13 + var_14;
    var_16 = scripts\mp\utility::_magicbullet(var_0F, var_0D, var_0D + var_15, param_00);
    var_16.triggerportableradarping = param_00;
    var_16.zoffset = var_0D[2];
    var_16.id = func_7FBA(var_04);
    var_16.var_5716 = func_7FBA(var_05);
    var_16.outlineid = scripts\mp\utility::outlineenableforplayer(var_16, "white", var_16.triggerportableradarping, 0, 0, "killstreak_personal");
    var_16.streakinfo = param_02.streakinfo;
    var_16.triggerportableradarping setclientomnvar(var_16.id.omnvar, var_16);
    var_16.triggerportableradarping setclientomnvar(var_16.var_5716.omnvar, int(var_16.zoffset));
    if(scripts\mp\killstreaks\_utility::func_A69F(param_02.streakinfo, "passive_seek_cluster")) {
      var_16 thread delayseekopentargetinview(0.3, var_16.triggerportableradarping, var_07, var_09);
    } else {
      var_16 thread func_50E6(0.3, var_03);
    }

    var_16 thread func_139F6(var_16.triggerportableradarping, param_02);
    var_16 thread func_13A22(var_16.triggerportableradarping, param_02);
    var_16 thread scripts\mp\killstreaks\_utility::watchsupertrophynotify(var_16.triggerportableradarping);
    param_02.var_C239--;
    param_00 setclientomnvar("ui_thor_missiles_loaded", param_02.var_C239);
    scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(0.1);
  }

  param_02 scriptmodelplayanim("iw7_mp_killstreak_thor_extend_reload", 1);
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(2);
  param_02 notify("start_reload");
  param_02.var_9BE2 = undefined;
}

delayseekopentargetinview(param_00, param_01, param_02, param_03) {
  var_04 = undefined;
  wait(param_00);
  foreach(var_06 in param_03) {
    if(!scripts\mp\killstreaks\_utility::manualmissilecantracktarget(var_06)) {
      continue;
    }

    if(scripts\mp\utility::istrue(var_06.thortargetted)) {
      continue;
    }

    var_04 = var_06;
    break;
  }

  if(isDefined(var_04)) {
    self missile_settargetent(var_04);
    self missile_setflightmodedirect();
    var_04.thortargetted = 1;
    var_04 thread watchtarget(self);
    return;
  }

  self missile_settargetpos(param_02);
  self missile_setflightmodedirect();
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

  self.thortargetted = undefined;
  if(isDefined(param_00)) {
    param_00 missile_cleartarget();
  }
}

canseetarget(param_00) {
  var_01 = 0;
  var_02 = scripts\common\trace::create_contents(0, 1, 1, 1, 1, 1, 0);
  var_03 = param_00 gettagorigin("j_head");
  for(var_04 = 0; var_04 < var_03.size; var_04++) {
    if(!scripts\common\trace::ray_trace_passed(self.origin, var_03[var_04], self, var_02)) {
      continue;
    }

    var_01 = 1;
    break;
  }

  return var_01;
}

func_50E6(param_00, param_01) {
  self.triggerportableradarping endon("disconnect");
  wait(param_00);
  if(isDefined(param_01)) {
    self missile_settargetent(param_01);
  }

  self missile_setflightmodedirect();
}

func_139F6(param_00, param_01) {
  self endon("explode");
  self endon("death");
  for(;;) {
    if(isDefined(param_01.var_9C9F)) {
      break;
    }

    self.zoffset = self.origin[2];
    var_02 = scripts\common\trace::ray_trace(self.origin, self.origin + (0, 0, -1000000));
    var_03 = var_02["position"];
    self.zoffset = self.origin - var_02["position"];
    self.zoffset = self.zoffset[2];
    param_00 setclientomnvar(self.var_5716.omnvar, int(max(0, self.zoffset)));
    scripts\engine\utility::waitframe();
  }
}

func_13A22(param_00, param_01) {
  self waittill("explode", var_02);
  if(isDefined(self.outlineid)) {
    scripts\mp\utility::outlinedisable(self.outlineid, self);
  }

  if(isDefined(param_00)) {
    if(isDefined(self.id.omnvar)) {
      param_00 setclientomnvar(self.id.omnvar, undefined);
    }
  }
}

func_13B42(param_00, param_01) {
  param_00 endon("disconnect");
  param_01 endon("death");
  param_01.var_9BE2 = 1;
  param_01 notify("start_fire");
  var_02 = param_01.var_B88C;
  var_03 = param_01.var_B888;
  self.zoffset = self.origin[2];
  self.id = func_7FBA(var_02);
  self.var_5716 = func_7FBA(var_03);
  self.outlineid = scripts\mp\utility::outlineenableforplayer(self, "white", param_00, 0, 0, "killstreak_personal");
  param_00 setclientomnvar(self.id.omnvar, self);
  param_00 setclientomnvar(self.var_5716.omnvar, int(self.zoffset));
  thread func_139F6(param_00, param_01);
  thread func_13A22(param_00, param_01);
  thread scripts\mp\killstreaks\_utility::watchsupertrophynotify(param_00);
  param_01.var_C239--;
  param_00 setclientomnvar("ui_thor_missiles_loaded", param_01.var_C239);
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(0.1);
  if(param_01.var_C239 > 0) {
    param_01 notify("finished_single_fire");
  } else {
    param_01 scriptmodelplayanim("iw7_mp_killstreak_thor_extend_reload", 1);
    scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(2);
    param_01 notify("start_reload");
  }

  param_01.var_9BE2 = undefined;
}

func_1179E() {
  self endon("death");
  self endon("leaving");
  var_00 = 0;
  for(;;) {
    self waittill("start_reload");
    if(var_00 == 20) {
      func_1179C(3);
      self notify("death");
    }

    thread func_1179B();
    var_00++;
  }
}

func_1179B() {
  self endon("death");
  var_00 = self.triggerportableradarping;
  var_00 endon("disconnect");
  var_00 endon("thor_missile_fire_success");
  level endon("game_ended");
  func_1179C(3);
  if(self.var_C239 < self.var_B47C) {
    self.var_9C9F = 1;
    var_00 playlocalsound("thor_missile_reload");
    thread func_510A(1);
    while(self.var_C239 < self.var_B47C) {
      self.var_C239++;
      var_00 setclientomnvar("ui_thor_missiles_loaded", self.var_C239);
      self.var_B88C[self.var_C239 - 1].inuse = 0;
      self.var_B888[self.var_C239 - 1].inuse = 0;
      var_00 setclientomnvar(self.var_B888[self.var_C239 - 1].omnvar, -1);
    }

    return;
  }

  self notify("finished_reload");
}

func_510A(param_00) {
  self endon("death");
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(param_00);
  self.var_9C9F = undefined;
  self notify("finished_reload");
}

func_12F01(param_00) {
  self endon("death");
  param_00 endon("disconnect");
  param_00 endon("thor_missile_fire_success");
  level endon("game_ended");
  var_01 = gettime();
  var_02 = var_01 + self.var_DF5C * 1000;
  var_03 = var_01;
  while(var_03 < var_02) {
    var_03 = gettime();
    var_04 = var_03 - var_01 / var_02 - var_01;
    var_04 = clamp(var_04, 0, 1);
    scripts\engine\utility::waitframe();
  }
}

func_13AD4() {
  self endon("death");
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(1);
  self delete();
}

func_117A6() {
  self endon("death");
  level endon("game_ended");
  foreach(var_01 in level.participants) {
    func_20D2(var_01);
  }
}

func_20D2(param_00) {
  if(level.teambased && param_00.team != self.team) {
    return;
  } else if(!level.teambased) {
    return;
  }

  var_01 = scripts\mp\utility::outlineenableforplayer(param_00, "cyan", self.triggerportableradarping, 1, 1, "killstreak");
  thread removeoutline(var_01, param_00);
}

func_6567(param_00) {
  return param_00 scripts\mp\utility::_hasperk("specialty_noplayertarget");
}

removeoutline(param_00, param_01, param_02) {
  if(isDefined(param_01)) {
    param_01 endon("disconnect");
  }

  level endon("game_ended");
  var_03 = ["leave", "death"];
  if(isDefined(param_02)) {
    scripts\engine\utility::waittill_any_in_array_or_timeout_no_endon_death(var_03, param_02);
  } else {
    scripts\engine\utility::waittill_any_in_array_return_no_endon_death(var_03);
  }

  scripts\mp\utility::outlinedisable(param_00, param_01);
}

func_117A8() {
  self endon("death");
  self endon("leaving");
  level endon("game_ended");
  self.enemieskilledintimewindow = 0;
  for(;;) {
    level waittill("thor_killed_player", var_00);
    self.enemieskilledintimewindow++;
    self notify("thor_enemy_killed");
  }
}

func_11790(param_00) {
  self endon("death");
  self endon("leaving");
  level endon("game_ended");
  var_01 = level.var_117B0[self.streakname];
  var_02 = 1;
  for(;;) {
    self waittill("thor_enemy_killed");
    scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(var_02);
    if(self.enemieskilledintimewindow > 1) {
      self.triggerportableradarping scripts\mp\utility::leaderdialogonplayer(var_01.var_1352C);
    } else {
      self.triggerportableradarping scripts\mp\utility::leaderdialogonplayer(var_01.var_1352D);
    }

    self.enemieskilledintimewindow = 0;
  }
}

func_11796() {
  self endon("death");
  level endon("game_ended");
  for(;;) {
    level waittill("connected", var_00);
    var_00 thread func_11797(self);
  }
}

func_11797(param_00) {
  self endon("disconnect");
  self waittill("spawned_player");
  param_00 func_20D2(self);
}

func_4074() {
  if(isDefined(self.targeting_marker)) {
    self.targeting_marker delete();
  }

  if(isDefined(self.var_C7FF)) {
    self.var_C7FF delete();
  }

  if(isDefined(self.var_10E4C)) {
    self.var_10E4C destroy();
  }

  if(isDefined(self.minimapid)) {
    scripts\mp\objidpoolmanager::returnminimapid(self.minimapid);
  }

  level.var_C20D--;
}

func_117A1() {
  level endon("game_ended");
  self endon("death");
  self endon("leaving");
  thread scripts\mp\killstreaks\_killstreaks::allowridekillstreakplayerexit();
  self waittill("killstreakExit");
  var_00 = level.var_117B0[self.streakname];
  scripts\mp\utility::leaderdialog(var_00.votimedout);
  thread func_11795();
}

func_7FBA(param_00) {
  var_01 = undefined;
  for(var_02 = 4; var_02 + 1 > 0; var_02--) {
    if(!param_00[var_02].inuse) {
      var_01 = param_00[var_02];
      param_00[var_02].inuse = 1;
      break;
    }
  }

  return var_01;
}

getthormapvisionset(param_00) {
  var_01 = "";
  switch (param_00) {
    case "mp_depot":
    case "mp_hawkwar":
    case "mp_paris":
    case "mp_overflow":
    case "mp_flip":
    case "mp_geneva":
    case "mp_dome_dusk":
    case "mp_rivet":
    case "mp_skyway":
    case "mp_quarry":
    case "mp_breakneck":
    case "mp_junk":
      var_01 = "thorbright_mp";
      break;

    default:
      var_01 = "thor_mp";
      break;
  }

  return var_01;
}