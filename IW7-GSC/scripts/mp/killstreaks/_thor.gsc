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
  var_0 = ["passive_increased_armor", "passive_decreased_duration", "passive_seek_cluster", "passive_no_cursor", "passive_switch_thruster", "passive_armor_duration"];
  scripts\mp\killstreak_loot::func_DF07("thor", var_0);
}

func_13C8E(var_0) {
  var_1 = 1;
  if(scripts\mp\utility::currentactivevehiclecount() >= scripts\mp\utility::maxvehiclesallowed() || level.fauxvehiclecount + var_1 >= scripts\mp\utility::maxvehiclesallowed()) {
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

weaponswitchendedairstrike(var_0, var_1) {
  self notify("thor_weapon_switch_ended");
  if(!scripts\mp\utility::istrue(var_1)) {
    if(isDefined(level.var_C20D) && level.var_C20D > 0) {
      level.var_C20D--;
    }

    self setclientomnvar("ui_remote_control_sequence", 0);
  }
}

func_13099(var_0) {
  level.var_C20D--;
  self setclientomnvar("ui_remote_control_sequence", 0);
}

func_12909(var_0) {
  var_1 = scripts\mp\killstreaks\_killstreaks::func_D507(var_0);
  if(!var_1) {
    level.var_C20D--;
    return 0;
  }

  var_1 = func_10DFC(var_0);
  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  return var_1;
}

func_10DFC(var_0) {
  self.var_117AF = spawn("script_model", level.var_12AF6);
  self.var_117AF setModel("tag_origin");
  self.var_117AF.angles = (0, 115, 0);
  self.var_117AF.triggerportableradarping = self;
  self.var_117AF hide();
  self.var_117AF thread func_E731(-360, 60, "thor_fire_thrusters", "thor_switch_thrusters");
  self.thorrigangle = -360;
  self.restoreangles = vectortoangles(anglesToForward(self.angles));
  scripts\mp\utility::incrementfauxvehiclecount();
  var_1 = func_4A26(var_0.streakname, var_0);
  if(!isDefined(var_1)) {
    level.var_C20D--;
    scripts\mp\utility::decrementfauxvehiclecount();
    thread scripts\mp\killstreaks\_killstreaks::func_11086();
    return 0;
  }

  return 1;
}

func_E731(var_0, var_1, var_2, var_3) {
  self endon("death");
  self.triggerportableradarping endon("disconnect");
  if(isDefined(var_2)) {
    self.triggerportableradarping endon(var_2);
  }

  if(isDefined(var_3)) {
    self.triggerportableradarping endon(var_3);
  }

  if(!isDefined(var_0)) {
    var_0 = -360;
  }

  if(!isDefined(var_1)) {
    var_1 = 60;
  }

  for(;;) {
    self rotateyaw(var_0, var_1);
    wait(var_1);
  }
}

func_4A26(var_0, var_1) {
  var_2 = level.var_117B0[var_0];
  var_3 = randomint(360);
  var_4 = 7000;
  var_5 = 10000;
  var_6 = cos(var_3) * var_4;
  var_7 = sin(var_3) * var_4;
  var_8 = vectornormalize((var_6, var_7, var_5));
  var_8 = var_8 * var_4;
  var_9 = self.var_117AF.origin + var_8 + (0, 0, 1000);
  var_0A = self.var_117AF.origin + var_8;
  var_0B = var_2.modelbase;
  var_0C = scripts\mp\killstreak_loot::getrarityforlootitem(var_1.variantid);
  if(var_0C != "") {
    var_0B = var_0B + "_" + var_0C;
  }

  var_0D = spawn("script_model", var_9);
  if(!isDefined(var_0D)) {
    return undefined;
  }

  var_0D setModel(var_0B);
  var_0D.team = self.team;
  var_0D.triggerportableradarping = self;
  var_0D.health = 99999;
  var_0D.numflares = 1;
  var_0D.var_C239 = var_2.var_394["missile"].var_B47C;
  var_0D.var_C238 = 0;
  var_0D.var_B88C = func_989D("ID");
  var_0D.var_B888 = func_989D("Distance");
  var_0D.var_B47C = var_2.var_394["missile"].var_B47C;
  var_0D.var_DF5C = var_2.var_394["missile"].var_DF5C;
  var_0D.zoffset = 10000;
  var_0D.streakname = var_0;
  var_0D.var_117B2 = 1;
  var_0D.streakinfo = var_1;
  var_0D.basemodel = var_0B;
  var_0D setCanDamage(1);
  var_0D setotherent(self);
  var_0D setscriptablepartstate("body", "hide", 0);
  var_0D.angles = vectortoangles(self.var_117AF.origin - (var_0D.origin[0], var_0D.origin[1], self.var_117AF.origin[2]));
  var_0D.var_10E4C = func_495B();
  thread func_117AE(var_0D, var_0A);
  return var_0D;
}

func_117AE(var_0, var_1) {
  var_0 endon("death");
  level endon("game_ended");
  var_0.triggerportableradarping playlocalsound("thor_init_plr");
  var_0 moveto(var_1, 1);
  var_0 scriptmodelplayanim("iw7_mp_killstreak_thor_idle", 1);
  var_0 setscriptablepartstate("thrusters", "drop", 0);
  scripts\mp\shellshock::_earthquake(0.15, 2, var_0.origin, 2000);
  var_2 = level.var_117B0[var_0.streakname];
  if(getdvarint("camera_thirdPerson")) {
    scripts\mp\utility::setthirdpersondof(0);
  }

  var_3 = var_2.var_394["missile"].var_39C;
  var_4 = var_2.var_394["missile"].var_13FCB;
  var_0.primaryweapon = var_3;
  var_0.secondaryweapon = var_4;
  var_0.triggerportableradarping scripts\mp\utility::_giveweapon(var_3);
  var_0.triggerportableradarping scripts\mp\utility::_giveweapon(var_4);
  var_0.triggerportableradarping scripts\mp\utility::_switchtoweaponimmediate(var_3);
  var_0.triggerportableradarping playerlinkweaponviewtodelta(var_0, "tag_player", 0, 180, 180, 45, 180);
  var_0.triggerportableradarping _meth_8236(0);
  var_0.triggerportableradarping _meth_85A2(getthormapvisionset(level.mapname));
  var_0.triggerportableradarping thread func_B011(var_0);
  var_0.triggerportableradarping setclientomnvar("ui_thor_show", 1);
  var_0.triggerportableradarping setclientomnvar("ui_thor_missiles_loaded", var_2.var_394["missile"].var_B47C);
  var_0.triggerportableradarping thermalvisionfofoverlayon();
  var_0.triggerportableradarping thermalvisionon();
  for(var_5 = 0; var_5 < 5; var_5++) {
    var_0.triggerportableradarping setclientomnvar(var_0.var_B88C[var_5].omnvar, undefined);
    var_0.triggerportableradarping setclientomnvar(var_0.var_B888[var_5].omnvar, -1);
  }

  var_0.triggerportableradarping _meth_82C0("thor_killstreak", 1);
  var_6 = var_2.teamsplash;
  var_7 = scripts\mp\killstreak_loot::getrarityforlootitem(var_0.streakinfo.variantid);
  if(var_7 != "") {
    var_6 = var_6 + "_" + var_7;
  }

  level thread scripts\mp\utility::teamplayercardsplash(var_6, self);
  var_0.triggerportableradarping scripts\engine\utility::allow_weapon_switch(0);
  var_0 func_8ED7(var_0.basemodel);
  var_0 thread func_117A7();
  var_0 thread func_117A0();
  var_0 thread func_117A9();
  wait(0.5);
  var_0 scriptmodelplayanim("iw7_mp_killstreak_thor_extend", 1);
  wait(0.5);
  var_0 scriptmodelplayanim("iw7_mp_killstreak_thor_extend_idle", 1);
  var_0 setscriptablepartstate("thrusters", "idle", 0);
  scripts\mp\shellshock::_earthquake(0.2, 0.76, var_0.origin, 1000);
  var_0 linkto(self.var_117AF, "tag_origin");
  var_0 scripts\mp\killstreaks\_utility::func_1843(var_0.streakname, undefined, var_0.triggerportableradarping, 1);
  var_8 = "icon_minimap_thor_friendly";
  var_0.minimapid = var_0 scripts\mp\killstreaks\_airdrop::createobjective(var_8, undefined, 1, 1, 1);
  var_9 = var_2.timeout;
  if(scripts\mp\killstreaks\_utility::func_A69F(var_0.streakinfo, "passive_armor_duration")) {
    var_9 = var_9 - 5;
  }

  var_0 thread func_1179D(var_0.triggerportableradarping);
  var_0 thread func_117AC(var_9);
  var_0 thread func_117AA();
  var_0 thread func_1179F();
  var_0 thread func_117AD();
  var_0 thread func_117AB();
  var_0 thread func_117A2();
  if(scripts\mp\killstreaks\_utility::func_A69F(var_0.streakinfo, "passive_switch_thruster")) {
    var_0 thread thor_watchswitchthrust(var_0.triggerportableradarping);
  }

  var_0 thread func_117A3();
  var_0 thread func_1179E();
  var_0 thread func_117A5();
  var_0 thread func_117A1();
  var_0 thread func_117A8();
  var_0 thread func_11790();
  var_0 thread watchhostmigrationfinishedinit(self, var_2);
  var_0.triggerportableradarping scripts\mp\matchdata::logkillstreakevent(var_0.streakname, self.origin);
  var_0.triggerportableradarping scripts\engine\utility::allow_usability(0);
  var_0.triggerportableradarping setclientomnvar("ui_killstreak_countdown", gettime() + int(var_9 * 1000));
  var_0.triggerportableradarping setclientomnvar("ui_killstreak_health", var_2.maxhealth / 2600);
}

func_8ED7(var_0) {
  self hidepart("j_backend", var_0);
  self hidepart("j_shield_1", var_0);
  self hidepart("j_shield_2", var_0);
  self hidepart("j_shield_3", var_0);
  self hidepart("j_shield_4", var_0);
  self hidepart("j_nose", var_0);
}

func_989D(var_0) {
  var_1 = [];
  switch (var_0) {
    case "ID":
      for(var_2 = 0; var_2 < 5; var_2++) {
        var_3 = spawnStruct();
        var_3.omnvar = "ui_thor_missile_" + var_2;
        var_3.inuse = 0;
        var_1[var_1.size] = var_3;
      }
      break;

    case "Distance":
      for(var_2 = 0; var_2 < 5; var_2++) {
        var_3 = spawnStruct();
        var_3.omnvar = "ui_thor_missile_" + var_2 + "_dist";
        var_3.inuse = 0;
        var_1[var_1.size] = var_3;
      }
      break;
  }

  return var_1;
}

watchhostmigrationfinishedinit(var_0, var_1) {
  var_0 endon("disconnect");
  var_0 endon("joined_team");
  var_0 endon("joined_spectators");
  var_0 endon("killstreak_disowned");
  level endon("game_ended");
  self endon("death");
  self endon("leaving");
  for(;;) {
    level waittill("host_migration_end");
    var_0 thermalvisionfofoverlayon();
    if(scripts\mp\utility::istrue(self.var_117B2)) {
      var_0 thermalvisionon();
      continue;
    }

    var_0 thermalvisionoff();
  }
}

func_B011(var_0) {
  self endon("disconnect");
  level endon("game_ended");
  var_0 endon("death");
  wait(0.05);
  var_1 = vectortoangles(level.var_12AF5.origin - var_0 gettagorigin("tag_player"));
  self setplayerangles(var_1);
}

func_1369B(var_0) {
  self endon("disconnect");
  var_0 endon("death");
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(1);
  var_1 = scripts\mp\utility::outlineenableforplayer(self, "cyan", self, 0, 0, "killstreak");
  var_0 thread removeoutline(var_1, self);
}

waitanddelete(var_0) {
  self endon("death");
  level endon("game_ended");
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(var_0);
  self delete();
}

func_1179A(var_0) {
  scripts\mp\utility::setusingremote(var_0.streakname);
}

func_1178F(var_0) {
  if(isDefined(self)) {
    scripts\mp\utility::clearusingremote();
  }
}

func_1179C(var_0) {
  while(isDefined(self.var_9BE2) && var_0 > 0) {
    wait(0.05);
    var_0 = var_0 - 0.05;
  }
}

func_1179D(var_0) {
  var_0 endon("disconnect");
  level endon("game_ended");
  for(;;) {
    var_1 = scripts\engine\utility::waittill_any_return("start_fire", "start_reload", "death", "leaving");
    if(var_1 == "death" || var_1 == "leaving") {
      break;
    }

    var_0 scripts\engine\utility::allow_fire(0);
    scripts\engine\utility::waittill_any_3("finished_single_fire", "finished_reload", "death", "leaving");
    var_0 scripts\engine\utility::allow_fire(1);
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
    foreach(var_1 in self.var_B88C) {
      self.triggerportableradarping setclientomnvar(var_1.omnvar, undefined);
    }

    foreach(var_4 in self.var_B888) {
      self.triggerportableradarping setclientomnvar(var_4.omnvar, -1);
    }
  }

  func_4074();
  scripts\mp\utility::decrementfauxvehiclecount();
  playFX(scripts\engine\utility::getfx("thor_explode"), self.origin);
  self delete();
}

func_117AC(var_0) {
  level endon("game_ended");
  self endon("death");
  self endon("leaving");
  self endon("host_migration_lifetime_update");
  self.triggerportableradarping endon("disconnect");
  self.triggerportableradarping endon("joined_team");
  self.triggerportableradarping endon("joined_spectators");
  thread scripts\mp\killstreaks\_utility::watchhostmigrationlifetime("leaving", var_0, ::func_117AC);
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(var_0);
  func_1179C(3);
  var_1 = ["thor_end", "thor_timeout"];
  var_2 = randomint(var_1.size);
  var_3 = var_1[var_2];
  self.triggerportableradarping scripts\mp\utility::playkillstreakdialogonplayer(var_3, undefined, undefined, self.triggerportableradarping.origin);
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
  var_0 = 1;
  thread func_11795(var_0);
}

func_11795(var_0) {
  self endon("death");
  self notify("leaving");
  var_1 = level.var_117B0[self.streakname];
  scripts\mp\utility::leaderdialog(var_1.votimedout);
  if(isDefined(self.triggerportableradarping)) {
    self.triggerportableradarping func_11791(self, var_0);
    self.triggerportableradarping setclientomnvar("ui_thor_show", 0);
    self.triggerportableradarping setclientomnvar("ui_killstreak_countdown", 0);
    self.triggerportableradarping setclientomnvar("ui_killstreak_health", 0);
    self.triggerportableradarping setclientomnvar("ui_killstreak_missile_warn", 0);
    self.triggerportableradarping clearclienttriggeraudiozone(1);
    self.triggerportableradarping stoprumble("thor_thrust_rumble");
    foreach(var_3 in self.var_B88C) {
      self.triggerportableradarping setclientomnvar(var_3.omnvar, undefined);
    }

    foreach(var_6 in self.var_B888) {
      self.triggerportableradarping setclientomnvar(var_6.omnvar, -1);
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

func_11791(var_0, var_1) {
  var_2 = level.var_117B0[var_0.streakname];
  scripts\mp\utility::printgameaction("killstreak ended - thor", self);
  if(isDefined(var_0)) {
    var_0 notify("end_remote");
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
    if(scripts\mp\utility::istrue(var_1)) {
      scripts\mp\utility::func_1136C(scripts\engine\utility::getlastweapon(), 1);
    } else {
      thread func_11794();
    }

    self stoplocalsound("odin_negative_action");
    self stoplocalsound("odin_positive_action");
    foreach(var_4 in level.var_117B0[var_0.streakname].var_394) {
      if(isDefined(var_4.var_D5E4)) {
        self stoplocalsound(var_4.var_D5E4);
      }

      if(isDefined(var_4.var_D5DD)) {
        self stoplocalsound(var_4.var_D5DD);
      }
    }

    thread scripts\mp\killstreaks\_killstreaks::func_11086();
    if(isDefined(self.var_117AF)) {
      self.var_117AF delete();
    }

    thread scripts\mp\utility::_takeweapon(var_0.primaryweapon);
    thread scripts\mp\utility::_takeweapon(var_0.secondaryweapon);
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
  var_0 = self.triggerportableradarping;
  var_0 endon("disconnect");
  var_1 = spawn("script_model", (0, 0, 0));
  var_1.angles = vectortoangles((0, 0, 1));
  var_1 setModel("tag_origin");
  var_1 hide();
  self.targeting_marker = var_1;
  self _meth_8549();
  self _meth_8594();
  for(;;) {
    var_2 = var_0 getvieworigin() - (0, 0, 50);
    var_3 = var_2 + anglesToForward(var_0 getplayerangles()) * -15536;
    var_4 = ["physicscontents_clipshot", "physicscontents_corpseclipshot", "physicscontents_missileclip", "physicscontents_solid", "physicscontents_vehicle"];
    var_5 = physics_createcontents(var_4);
    var_6 = scripts\common\trace::ray_trace(var_2, var_3, level.characters, var_5);
    var_1.origin = var_6["position"] + (0, 0, 50);
    scripts\engine\utility::waitframe();
  }
}

func_1179F() {
  self endon("death");
  self endon("leaving");
  var_0 = self.triggerportableradarping;
  var_0 endon("disconnect");
  var_1 = level.var_117B0[self.streakname];
  var_2 = var_1.maxhealth;
  var_3 = 0;
  var_4 = 3;
  var_5 = 4;
  var_6 = 5;
  if(scripts\mp\killstreaks\_utility::func_A69F(self.streakinfo, "passive_armor_duration")) {
    var_4++;
    var_5++;
    var_6++;
  }

  for(;;) {
    self waittill("damage", var_7, var_8, var_9, var_0A, var_0B, var_0C, var_0D, var_0E, var_0F, var_10, var_11, var_12, var_13, var_14);
    var_10 = scripts\mp\utility::func_13CA1(var_10, var_14);
    if(isDefined(var_8)) {
      if(isDefined(var_8.triggerportableradarping)) {
        var_8 = var_8.triggerportableradarping;
      }

      if(isDefined(var_8.team) && var_8.team == self.team && var_8 != self.triggerportableradarping) {
        continue;
      }
    }

    if(scripts\mp\equipment\phase_shift::isentityphaseshifted(var_8)) {
      continue;
    }

    if(isDefined(var_0B)) {
      var_0 func_4CF1(self, var_0B);
    }

    if(isDefined(var_10)) {
      var_7 = scripts\mp\killstreaks\_utility::getmodifiedantikillstreakdamage(var_8, var_10, var_0B, var_7, var_1.maxhealth, var_4, var_5, var_6);
      if(scripts\mp\killstreaks\_utility::func_A69F(self.streakinfo, "passive_armor_duration")) {
        if(scripts\mp\killstreaks\_utility::isexplosiveantikillstreakweapon(var_10)) {
          var_8 scripts\mp\damagefeedback::updatedamagefeedback("hitblastshield");
        }
      }
    }

    var_2 = var_2 - var_7;
    var_0 setclientomnvar("ui_killstreak_health", var_2 / var_1.maxhealth);
    if(isplayer(var_8)) {
      var_8 scripts\mp\damagefeedback::updatedamagefeedback("");
      scripts\mp\killstreaks\_killstreaks::killstreakhit(var_8, var_10, self, var_0B);
      scripts\mp\damage::logattackerkillstreak(self, var_7, var_8, var_9, var_0A, var_0B, var_0C, var_0D, var_0E, var_0F, var_10);
      if(var_2 <= 0) {
        var_8 notify("destroyed_killstreak", var_10);
        var_15 = "callout_destroyed_thor";
        var_16 = scripts\mp\killstreak_loot::getrarityforlootitem(self.streakinfo.variantid);
        if(var_16 != "") {
          var_15 = var_15 + "_" + var_16;
        }

        scripts\mp\damage::onkillstreakkilled("thor", var_8, var_10, var_0B, var_7, "destroyed_thor", "thor_destroyed", var_15);
        return;
      }
    }
  }
}

func_4CF1(var_0, var_1) {
  switch (var_1) {
    case "MOD_GRENADE_SPLASH":
    case "MOD_GRENADE":
    case "MOD_PROJECTILE":
    case "MOD_EXPLOSIVE_BULLET":
    case "MOD_PISTOL_BULLET":
    case "MOD_RIFLE_BULLET":
      func_3239(var_0);
      break;

    case "MOD_PROJECTILE_SPLASH":
    case "MOD_IMPACT":
    case "MOD_EXPLOSIVE":
      func_69E6(var_0);
      break;

    default:
      break;
  }
}

func_3239(var_0) {
  self earthquakeforplayer(0.15, 0.25, var_0 gettagorigin("tag_player"), 50);
  self playrumbleonentity("damage_light");
  thread func_1349D(var_0, 0.4);
}

func_69E6(var_0) {
  self earthquakeforplayer(0.4, 0.45, var_0 gettagorigin("tag_player"), 1000);
  self playrumbleonentity("damage_heavy");
  thread func_1349D(var_0, 0.7);
}

func_1349D(var_0, var_1) {
  self endon("disconnect");
  level endon("game_ended");
  var_0 endon("death");
  var_0.var_10E4C.alpha = var_1;
  while(var_1 > 0) {
    scripts\engine\utility::waitframe();
    var_1 = var_1 - 0.1;
    var_0.var_10E4C.alpha = var_1;
  }
}

func_495B() {
  var_0 = newclienthudelem(self);
  var_0.x = 0;
  var_0.y = 0;
  var_0 setshader("white", 640, 480);
  var_0.alignx = "left";
  var_0.aligny = "top";
  var_0.sort = 1;
  var_0.horzalign = "fullscreen";
  var_0.vertalign = "fullscreen";
  var_0.alpha = 0;
  var_0.foreground = 1;
  return var_0;
}

func_117AD() {
  self endon("death");
  self endon("leaving");
  level endon("game_ended");
  var_0 = self.triggerportableradarping;
  var_0 endon("disconnect");
  var_1 = level.var_117B0[self.streakname];
  if(!isai(var_0)) {
    var_0 notifyonplayercommand("thor_missile_zoom_on", "+weapnext");
  }

  for(;;) {
    var_0 waittill("thor_missile_zoom_on");
    var_0 scripts\engine\utility::allow_weapon_switch(1);
    if(!isDefined(self.var_117B3)) {
      var_0 scripts\mp\utility::_switchtoweaponimmediate(self.secondaryweapon);
      self.var_117B3 = 1;
      var_0 setclientomnvar("ui_thor_show", 2);
    } else {
      var_0 scripts\mp\utility::_switchtoweaponimmediate(self.primaryweapon);
      self.var_117B3 = undefined;
      var_0 setclientomnvar("ui_thor_show", 1);
    }

    var_0 scripts\engine\utility::allow_weapon_switch(0);
  }
}

func_117AB() {
  self endon("death");
  self endon("leaving");
  level endon("game_ended");
  var_0 = self.triggerportableradarping;
  var_0 endon("disconnect");
  var_1 = level.var_117B0[self.streakname];
  if(!isai(var_0)) {
    if(var_0 scripts\engine\utility::is_player_gamepad_enabled()) {
      var_0 notifyonplayercommand("thor_thermal_toggle", "+usereload");
    }

    var_0 notifyonplayercommand("thor_thermal_toggle", "+activate");
  }

  for(;;) {
    var_0 waittill("thor_thermal_toggle");
    if(!isDefined(self.var_117B2)) {
      var_0 thermalvisionon();
      self.var_117B2 = 1;
      continue;
    }

    var_0 thermalvisionoff();
    self.var_117B2 = undefined;
  }
}

func_117A2() {
  self endon("death");
  self endon("leaving");
  var_0 = self.triggerportableradarping;
  var_0 endon("disconnect");
  if(!isai(var_0)) {
    var_0 notifyonplayercommand("thor_fire_thrusters", "+smoke");
    var_0 notifyonplayercommand("thor_release_thrusters", "-smoke");
  }

  for(;;) {
    var_1 = var_0 scripts\engine\utility::waittill_any_return("thor_fire_thrusters", "thor_release_thrusters");
    if(!isDefined(var_1)) {
      continue;
    }

    if(var_1 == "thor_fire_thrusters") {
      var_0.var_117AF thread func_E731(var_0.thorrigangle, 30, "thor_release_thrusters", "thor_switch_thrusters");
      thread func_B06B(var_0);
      if(var_0.thorrigangle == -360) {
        self scriptmodelplayanim("iw7_mp_killstreak_thor_extend_thrust", 1);
      } else {
        self scriptmodelplayanim("iw7_mp_killstreak_thor_extend_rev_thrust", 1);
      }

      self setscriptablepartstate("thrusters", "boost", 0);
      continue;
    }

    var_0.var_117AF thread func_E731(var_0.thorrigangle, 60, "thor_fire_thrusters", "thor_switch_thrusters");
    var_0 stoprumble("thor_thrust_rumble");
    if(var_0.thorrigangle == -360) {
      self scriptmodelplayanim("iw7_mp_killstreak_thor_extend_idle", 1);
    } else {
      self scriptmodelplayanim("iw7_mp_killstreak_thor_extend_rev_idle", 1);
    }

    self setscriptablepartstate("thrusters", "idle", 0);
  }
}

func_B06B(var_0) {
  self endon("death");
  var_0 endon("thor_release_thrusters");
  var_0 _meth_8244("thor_thrust_rumble");
  for(;;) {
    scripts\mp\shellshock::_earthquake(0.15, 0.05, self.origin, 1000);
    scripts\engine\utility::waitframe();
  }
}

func_B9F2(var_0) {
  self endon("death");
  level endon("game_ended");
  var_0 endon("disconnect");
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(1.5);
  var_1 = [];
  for(;;) {
    var_2 = var_0 scripts\mp\utility::get_players_watching();
    foreach(var_4 in var_1) {
      if(!scripts\engine\utility::array_contains(var_2, var_4)) {
        var_1 = scripts\engine\utility::array_remove(var_1, var_4);
        self hide();
        self showtoplayer(var_0);
      }
    }

    foreach(var_4 in var_2) {
      self showtoplayer(var_4);
      if(!scripts\engine\utility::array_contains(var_1, var_4)) {
        var_1 = scripts\engine\utility::array_add(var_1, var_4);
        stopFXOnTag(level._effect["thor_targeting"], self, "tag_origin");
        wait(0.05);
        playFXOnTag(level._effect["thor_targeting"], self, "tag_origin");
      }
    }

    wait(0.25);
  }
}

thor_watchswitchthrust(var_0) {
  self endon("death");
  self endon("leaving");
  level endon("game_ended");
  var_0 = self.triggerportableradarping;
  var_0 endon("disconnect");
  if(!isai(var_0)) {
    var_0 notifyonplayercommand("thor_switch_thrusters", "+speed_throw");
    var_0 notifyonplayercommand("thor_switch_thrusters", "+toggleads_throw");
    var_0 notifyonplayercommand("thor_switch_thrusters", "+ads_akimbo_accessible");
  }

  for(;;) {
    var_1 = var_0 scripts\engine\utility::waittill_any_return("thor_switch_thrusters");
    if(var_0.thorrigangle == -360) {
      self scriptmodelplayanim("iw7_mp_killstreak_thor_extend_rev_idle", 1);
      var_0.thorrigangle = 360;
    } else {
      self scriptmodelplayanim("iw7_mp_killstreak_thor_extend_idle", 1);
      var_0.thorrigangle = -360;
    }

    var_0.var_117AF thread func_E731(var_0.thorrigangle, 60, "thor_fire_thrusters", "thor_switch_thrusters");
  }
}

thor_watchdebugtogglemovement(var_0) {
  self endon("death");
  self endon("leaving");
  level endon("game_ended");
  var_0 endon("disconnect");
  if(!isai(var_0)) {
    var_0 notifyonplayercommand("thor_toggle_movement", "+speed_throw");
    var_0 notifyonplayercommand("thor_toggle_movement", "+toggleads_throw");
    var_0 notifyonplayercommand("thor_toggle_movement", "+ads_akimbo_accessible");
  }

  var_1 = 1;
  for(;;) {
    var_2 = var_0 scripts\engine\utility::waittill_any_return("thor_toggle_movement");
    if(scripts\mp\utility::istrue(var_1)) {
      self unlink();
      var_1 = 0;
      continue;
    }

    self linkto(var_0.var_117AF, "tag_origin");
    var_1 = 1;
  }
}

func_117A3() {
  self endon("death");
  self endon("leaving");
  level endon("game_ended");
  var_0 = self.triggerportableradarping;
  var_0 endon("disconnect");
  var_1 = "missile";
  var_2 = level.var_117B0[self.streakname].var_394[var_1];
  for(;;) {
    var_0 waittill("missile_fire", var_3, var_4);
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

    if(isDefined(var_4) && var_4 != "thorproj_mp" && var_4 != "thorproj_zoomed_mp") {
      continue;
    }

    self setscriptablepartstate("muzzle", "fire", 0);
    thread func_5104(0.1);
    var_3.streakinfo = self.streakinfo;
    if(isDefined(var_4) && var_4 == "thorproj_mp") {
      var_3 thread func_139D1(var_0, var_1, self);
      continue;
    }

    var_3 thread func_13B42(var_0, self);
  }
}

func_5104(var_0) {
  self endon("death");
  wait(var_0);
  self setscriptablepartstate("muzzle", "neutral", 0);
}

func_139D1(var_0, var_1, var_2) {
  var_0 endon("disconnect");
  var_2 endon("death");
  var_3 = var_2.targeting_marker;
  var_4 = var_2.var_B88C;
  var_5 = var_2.var_B888;
  var_6 = self.angles;
  var_2.var_9BE2 = 1;
  var_2 notify("start_fire");
  var_7 = var_3.origin;
  var_8 = scripts\mp\killstreaks\_utility::func_7E92(var_0);
  var_9 = [];
  foreach(var_0B in var_8) {
    if(!scripts\mp\killstreaks\_utility::manualmissilecantracktarget(var_0B)) {
      continue;
    }

    if(var_0 worldpointinreticle_circle(var_0B.origin, 65, 55)) {
      var_9[var_9.size] = var_0B;
    }
  }

  self waittill("explode", var_0D);
  var_0E = var_2.var_C239;
  var_0F = "thorproj_tracking_mp";
  for(var_10 = 0; var_10 < var_0E; var_10++) {
    if(!isDefined(var_2)) {
      break;
    }

    var_11 = randomint(360);
    var_12 = anglestoright(var_6) * cos(var_11);
    var_13 = anglesToForward(var_6) * 3;
    var_14 = anglestoup(var_6) * sin(var_11);
    var_15 = var_12 + var_13 + var_14;
    var_16 = scripts\mp\utility::_magicbullet(var_0F, var_0D, var_0D + var_15, var_0);
    var_16.triggerportableradarping = var_0;
    var_16.zoffset = var_0D[2];
    var_16.id = func_7FBA(var_4);
    var_16.var_5716 = func_7FBA(var_5);
    var_16.outlineid = scripts\mp\utility::outlineenableforplayer(var_16, "white", var_16.triggerportableradarping, 0, 0, "killstreak_personal");
    var_16.streakinfo = var_2.streakinfo;
    var_16.triggerportableradarping setclientomnvar(var_16.id.omnvar, var_16);
    var_16.triggerportableradarping setclientomnvar(var_16.var_5716.omnvar, int(var_16.zoffset));
    if(scripts\mp\killstreaks\_utility::func_A69F(var_2.streakinfo, "passive_seek_cluster")) {
      var_16 thread delayseekopentargetinview(0.3, var_16.triggerportableradarping, var_7, var_9);
    } else {
      var_16 thread func_50E6(0.3, var_3);
    }

    var_16 thread func_139F6(var_16.triggerportableradarping, var_2);
    var_16 thread func_13A22(var_16.triggerportableradarping, var_2);
    var_16 thread scripts\mp\killstreaks\_utility::watchsupertrophynotify(var_16.triggerportableradarping);
    var_2.var_C239--;
    var_0 setclientomnvar("ui_thor_missiles_loaded", var_2.var_C239);
    scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(0.1);
  }

  var_2 scriptmodelplayanim("iw7_mp_killstreak_thor_extend_reload", 1);
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(2);
  var_2 notify("start_reload");
  var_2.var_9BE2 = undefined;
}

delayseekopentargetinview(var_0, var_1, var_2, var_3) {
  var_4 = undefined;
  wait(var_0);
  foreach(var_6 in var_3) {
    if(!scripts\mp\killstreaks\_utility::manualmissilecantracktarget(var_6)) {
      continue;
    }

    if(scripts\mp\utility::istrue(var_6.thortargetted)) {
      continue;
    }

    var_4 = var_6;
    break;
  }

  if(isDefined(var_4)) {
    self missile_settargetent(var_4);
    self missile_setflightmodedirect();
    var_4.thortargetted = 1;
    var_4 thread watchtarget(self);
    return;
  }

  self missile_settargetpos(var_2);
  self missile_setflightmodedirect();
}

watchtarget(var_0) {
  self endon("disconnect");
  for(;;) {
    if(!scripts\mp\killstreaks\_utility::manualmissilecantracktarget(self)) {
      break;
    }

    if(!isDefined(var_0)) {
      break;
    }

    scripts\engine\utility::waitframe();
  }

  self.thortargetted = undefined;
  if(isDefined(var_0)) {
    var_0 missile_cleartarget();
  }
}

canseetarget(var_0) {
  var_1 = 0;
  var_2 = scripts\common\trace::create_contents(0, 1, 1, 1, 1, 1, 0);
  var_3 = var_0 gettagorigin("j_head");
  for(var_4 = 0; var_4 < var_3.size; var_4++) {
    if(!scripts\common\trace::ray_trace_passed(self.origin, var_3[var_4], self, var_2)) {
      continue;
    }

    var_1 = 1;
    break;
  }

  return var_1;
}

func_50E6(var_0, var_1) {
  self.triggerportableradarping endon("disconnect");
  wait(var_0);
  if(isDefined(var_1)) {
    self missile_settargetent(var_1);
  }

  self missile_setflightmodedirect();
}

func_139F6(var_0, var_1) {
  self endon("explode");
  self endon("death");
  for(;;) {
    if(isDefined(var_1.var_9C9F)) {
      break;
    }

    self.zoffset = self.origin[2];
    var_2 = scripts\common\trace::ray_trace(self.origin, self.origin + (0, 0, -1000000));
    var_3 = var_2["position"];
    self.zoffset = self.origin - var_2["position"];
    self.zoffset = self.zoffset[2];
    var_0 setclientomnvar(self.var_5716.omnvar, int(max(0, self.zoffset)));
    scripts\engine\utility::waitframe();
  }
}

func_13A22(var_0, var_1) {
  self waittill("explode", var_2);
  if(isDefined(self.outlineid)) {
    scripts\mp\utility::outlinedisable(self.outlineid, self);
  }

  if(isDefined(var_0)) {
    if(isDefined(self.id.omnvar)) {
      var_0 setclientomnvar(self.id.omnvar, undefined);
    }
  }
}

func_13B42(var_0, var_1) {
  var_0 endon("disconnect");
  var_1 endon("death");
  var_1.var_9BE2 = 1;
  var_1 notify("start_fire");
  var_2 = var_1.var_B88C;
  var_3 = var_1.var_B888;
  self.zoffset = self.origin[2];
  self.id = func_7FBA(var_2);
  self.var_5716 = func_7FBA(var_3);
  self.outlineid = scripts\mp\utility::outlineenableforplayer(self, "white", var_0, 0, 0, "killstreak_personal");
  var_0 setclientomnvar(self.id.omnvar, self);
  var_0 setclientomnvar(self.var_5716.omnvar, int(self.zoffset));
  thread func_139F6(var_0, var_1);
  thread func_13A22(var_0, var_1);
  thread scripts\mp\killstreaks\_utility::watchsupertrophynotify(var_0);
  var_1.var_C239--;
  var_0 setclientomnvar("ui_thor_missiles_loaded", var_1.var_C239);
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(0.1);
  if(var_1.var_C239 > 0) {
    var_1 notify("finished_single_fire");
  } else {
    var_1 scriptmodelplayanim("iw7_mp_killstreak_thor_extend_reload", 1);
    scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(2);
    var_1 notify("start_reload");
  }

  var_1.var_9BE2 = undefined;
}

func_1179E() {
  self endon("death");
  self endon("leaving");
  var_0 = 0;
  for(;;) {
    self waittill("start_reload");
    if(var_0 == 20) {
      func_1179C(3);
      self notify("death");
    }

    thread func_1179B();
    var_0++;
  }
}

func_1179B() {
  self endon("death");
  var_0 = self.triggerportableradarping;
  var_0 endon("disconnect");
  var_0 endon("thor_missile_fire_success");
  level endon("game_ended");
  func_1179C(3);
  if(self.var_C239 < self.var_B47C) {
    self.var_9C9F = 1;
    var_0 playlocalsound("thor_missile_reload");
    thread func_510A(1);
    while(self.var_C239 < self.var_B47C) {
      self.var_C239++;
      var_0 setclientomnvar("ui_thor_missiles_loaded", self.var_C239);
      self.var_B88C[self.var_C239 - 1].inuse = 0;
      self.var_B888[self.var_C239 - 1].inuse = 0;
      var_0 setclientomnvar(self.var_B888[self.var_C239 - 1].omnvar, -1);
    }

    return;
  }

  self notify("finished_reload");
}

func_510A(var_0) {
  self endon("death");
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(var_0);
  self.var_9C9F = undefined;
  self notify("finished_reload");
}

func_12F01(var_0) {
  self endon("death");
  var_0 endon("disconnect");
  var_0 endon("thor_missile_fire_success");
  level endon("game_ended");
  var_1 = gettime();
  var_2 = var_1 + self.var_DF5C * 1000;
  var_3 = var_1;
  while(var_3 < var_2) {
    var_3 = gettime();
    var_4 = var_3 - var_1 / var_2 - var_1;
    var_4 = clamp(var_4, 0, 1);
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
  foreach(var_1 in level.participants) {
    func_20D2(var_1);
  }
}

func_20D2(var_0) {
  if(level.teambased && var_0.team != self.team) {
    return;
  } else if(!level.teambased) {
    return;
  }

  var_1 = scripts\mp\utility::outlineenableforplayer(var_0, "cyan", self.triggerportableradarping, 1, 1, "killstreak");
  thread removeoutline(var_1, var_0);
}

func_6567(var_0) {
  return var_0 scripts\mp\utility::_hasperk("specialty_noplayertarget");
}

removeoutline(var_0, var_1, var_2) {
  if(isDefined(var_1)) {
    var_1 endon("disconnect");
  }

  level endon("game_ended");
  var_3 = ["leave", "death"];
  if(isDefined(var_2)) {
    scripts\engine\utility::waittill_any_in_array_or_timeout_no_endon_death(var_3, var_2);
  } else {
    scripts\engine\utility::waittill_any_in_array_return_no_endon_death(var_3);
  }

  scripts\mp\utility::outlinedisable(var_0, var_1);
}

func_117A8() {
  self endon("death");
  self endon("leaving");
  level endon("game_ended");
  self.enemieskilledintimewindow = 0;
  for(;;) {
    level waittill("thor_killed_player", var_0);
    self.enemieskilledintimewindow++;
    self notify("thor_enemy_killed");
  }
}

func_11790(var_0) {
  self endon("death");
  self endon("leaving");
  level endon("game_ended");
  var_1 = level.var_117B0[self.streakname];
  var_2 = 1;
  for(;;) {
    self waittill("thor_enemy_killed");
    scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(var_2);
    if(self.enemieskilledintimewindow > 1) {
      self.triggerportableradarping scripts\mp\utility::leaderdialogonplayer(var_1.var_1352C);
    } else {
      self.triggerportableradarping scripts\mp\utility::leaderdialogonplayer(var_1.var_1352D);
    }

    self.enemieskilledintimewindow = 0;
  }
}

func_11796() {
  self endon("death");
  level endon("game_ended");
  for(;;) {
    level waittill("connected", var_0);
    var_0 thread func_11797(self);
  }
}

func_11797(var_0) {
  self endon("disconnect");
  self waittill("spawned_player");
  var_0 func_20D2(self);
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
  var_0 = level.var_117B0[self.streakname];
  scripts\mp\utility::leaderdialog(var_0.votimedout);
  thread func_11795();
}

func_7FBA(var_0) {
  var_1 = undefined;
  for(var_2 = 4; var_2 + 1 > 0; var_2--) {
    if(!var_0[var_2].inuse) {
      var_1 = var_0[var_2];
      var_0[var_2].inuse = 1;
      break;
    }
  }

  return var_1;
}

getthormapvisionset(var_0) {
  var_1 = "";
  switch (var_0) {
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
      var_1 = "thorbright_mp";
      break;

    default:
      var_1 = "thor_mp";
      break;
  }

  return var_1;
}