/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3526.gsc
***************************************/

init() {
  scripts\mp\killstreaks\killstreaks::registerkillstreak("thor", ::func_12909, undefined, undefined, undefined, ::func_13C8E, undefined, ::func_13099, ::weaponswitchendedairstrike);
  level._effect["thor_clouds"] = loadfx("vfx\core\mp\killstreaks\odin\odin_parallax_clouds");
  level._effect["thor_fisheye"] = loadfx("vfx\iw7\_requests\mp\vfx_scrnfx_thor_fisheye.vfx");
  level._effect["thor_targeting"] = loadfx("vfx\core\mp\killstreaks\odin\vfx_marker_odin_cyan");
  level._effect["thor_target_mark"] = loadfx("vfx\iw7\_requests\mp\vfx_marker_map_target");
  level._effect["thor_explode"] = loadfx("vfx\iw7\core\mp\killstreaks\vfx_veh_exp_thor.vfx");
  level.func_117B0 = [];
  level.func_117B0["thor"] = spawnStruct();
  level.func_117B0["thor"].timeout = 60;
  level.func_117B0["thor"].maxhealth = 2600;
  level.func_117B0["thor"].streakname = "thor";
  level.func_117B0["thor"].vehicleinfo = "thor_mp";
  level.func_117B0["thor"].modelbase = "veh_mil_air_thor_wm";
  level.func_117B0["thor"].teamsplash = "used_thor";
  level.func_117B0["thor"].votimedout = "loki_gone";
  level.func_117B0["thor"].func_1352D = "odin_target_killed";
  level.func_117B0["thor"].func_1352C = "odin_targets_killed";
  level.func_117B0["thor"].func_12B20 = 4;
  level.func_117B0["thor"].func_12B80 = &"KILLSTREAKS_LOKI_UNAVAILABLE";
  level.func_117B0["thor"].func_73BE = "compass_objpoint_airstrike_friendly";
  level.func_117B0["thor"].func_6485 = "compass_objpoint_airstrike_busy";
  level.func_117B0["thor"].weapon["missile"] = spawnStruct();
  level.func_117B0["thor"].weapon["missile"].weaponname = "thorproj_mp";
  level.func_117B0["thor"].weapon["missile"].func_13FCB = "thorproj_zoomed_mp";
  level.func_117B0["thor"].weapon["missile"].projectile = "thorproj_mp";
  level.func_117B0["thor"].weapon["missile"].func_E7BA = "heavygun_fire";
  level.func_117B0["thor"].weapon["missile"].func_DF5C = 0.1;
  level.func_117B0["thor"].weapon["missile"].func_B47C = 5;
  level.func_117B0["thor"].weapon["missile"].func_D5E4 = "null";
  level.func_117B0["thor"].weapon["missile"].func_D5DD = "null";
  level.func_117B0["thor"].weapon["missile"].func_C195 = "null";
  level.func_C20D = 0;
  var_00 = ["passive_increased_armor", "passive_decreased_duration", "passive_seek_cluster", "passive_no_cursor", "passive_switch_thruster", "passive_armor_duration"];
  scripts\mp\killstreak_loot::func_DF07("thor", var_00);
}

func_13C8E(var_00) {
  var_01 = 1;

  if(scripts\mp\utility\game::currentactivevehiclecount() >= scripts\mp\utility\game::maxvehiclesallowed() || level.fauxvehiclecount + var_01 >= scripts\mp\utility\game::maxvehiclesallowed()) {
    scripts\mp\hud_message::showerrormessage("KILLSTREAKS_TOO_MANY_VEHICLES");
    return 0;
  }

  level.func_C20D++;

  if(level.func_C20D > 1) {
    scripts\mp\hud_message::showerrormessage("KILLSTREAKS_TOO_MANY_THORS");
    level.func_C20D--;
    return 0;
  }

  thread func_13B73();
  self setclientomnvar("ui_remote_control_sequence", 1);
  return 1;
}

func_13B73() {
  self endon("thor_weapon_switch_ended");
  level endon("game_ended");
  scripts\engine\utility::waittill_any("death", "disconnect");

  if(isDefined(level.func_C20D) && level.func_C20D > 0)
    level.func_C20D--;

  if(isDefined(self))
    self setclientomnvar("ui_remote_control_sequence", 0);
}

weaponswitchendedairstrike(var_00, var_01) {
  self notify("thor_weapon_switch_ended");

  if(!scripts\mp\utility\game::istrue(var_01)) {
    if(isDefined(level.func_C20D) && level.func_C20D > 0)
      level.func_C20D--;

    self setclientomnvar("ui_remote_control_sequence", 0);
  }
}

func_13099(var_00) {
  level.func_C20D--;
  self setclientomnvar("ui_remote_control_sequence", 0);
}

func_12909(var_00) {
  var_01 = scripts\mp\killstreaks\killstreaks::func_D507(var_00);

  if(!var_01) {
    level.func_C20D--;
    return 0;
  }

  var_01 = func_10DFC(var_00);

  if(!isDefined(var_01))
    var_01 = 0;

  return var_01;
}

func_10DFC(var_00) {
  self.func_117AF = spawn("script_model", level.func_12AF6);
  self.func_117AF setModel("tag_origin");
  self.func_117AF.angles = (0, 115, 0);
  self.func_117AF.owner = self;
  self.func_117AF hide();
  self.func_117AF thread func_E731(-360, 60, "thor_fire_thrusters", "thor_switch_thrusters");
  self.thorrigangle = -360;
  self.restoreangles = vectortoangles(anglesToForward(self.angles));
  scripts\mp\utility\game::incrementfauxvehiclecount();
  var_01 = func_4A26(var_0.streakname, var_00);

  if(!isDefined(var_01)) {
    level.func_C20D--;
    scripts\mp\utility\game::decrementfauxvehiclecount();
    thread scripts\mp\killstreaks\killstreaks::func_11086();
    return 0;
  }

  return 1;
}

func_E731(var_00, var_01, var_02, var_03) {
  self endon("death");
  self.owner endon("disconnect");

  if(isDefined(var_02))
    self.owner endon(var_02);

  if(isDefined(var_03))
    self.owner endon(var_03);

  if(!isDefined(var_00))
    var_00 = -360;

  if(!isDefined(var_01))
    var_01 = 60;

  for(;;) {
    self rotateyaw(var_00, var_01);
    wait(var_01);
  }
}

func_4A26(var_00, var_01) {
  var_02 = level.func_117B0[var_00];
  var_03 = randomint(360);
  var_04 = 7000;
  var_05 = 10000;
  var_06 = cos(var_03) * var_04;
  var_07 = sin(var_03) * var_04;
  var_08 = vectornormalize((var_06, var_07, var_05));
  var_08 = var_08 * var_04;
  var_09 = self.func_117AF.origin + var_08 + (0, 0, 1000);
  var_10 = self.func_117AF.origin + var_08;
  var_11 = var_2.modelbase;
  var_12 = scripts\mp\killstreak_loot::getrarityforlootitem(var_1.variantid);

  if(var_12 != "")
    var_11 = var_11 + "_" + var_12;

  var_13 = spawn("script_model", var_09);

  if(!isDefined(var_13))
    return undefined;

  var_13 setModel(var_11);
  var_13.team = self.team;
  var_13.owner = self;
  var_13.health = 99999;
  var_13.numflares = 1;
  var_13.func_C239 = var_2.weapon["missile"].func_B47C;
  var_13.func_C238 = 0;
  var_13.func_B88C = func_989D("ID");
  var_13.func_B888 = func_989D("Distance");
  var_13.func_B47C = var_2.weapon["missile"].func_B47C;
  var_13.func_DF5C = var_2.weapon["missile"].func_DF5C;
  var_13.zoffset = 10000;
  var_13.streakname = var_00;
  var_13.func_117B2 = 1;
  var_13.streakinfo = var_01;
  var_13.basemodel = var_11;
  var_13 setCanDamage(1);
  var_13 setotherent(self);
  var_13 setscriptablepartstate("body", "hide", 0);
  var_13.angles = vectortoangles(self.func_117AF.origin - (var_13.origin[0], var_13.origin[1], self.func_117AF.origin[2]));
  var_13.func_10E4C = func_495B();
  thread func_117AE(var_13, var_10);
  return var_13;
}

func_117AE(var_00, var_01) {
  var_00 endon("death");
  level endon("game_ended");
  var_0.owner playlocalsound("thor_init_plr");
  var_00 moveto(var_01, 1);
  var_00 scriptmodelplayanim("iw7_mp_killstreak_thor_idle", 1);
  var_00 setscriptablepartstate("thrusters", "drop", 0);
  scripts\mp\shellshock::_earthquake(0.15, 2, var_0.origin, 2000);
  var_02 = level.func_117B0[var_0.streakname];

  if(getdvarint("camera_thirdPerson"))
    scripts\mp\utility\game::setthirdpersondof(0);

  var_03 = var_2.weapon["missile"].weaponname;
  var_04 = var_2.weapon["missile"].func_13FCB;
  var_0.primaryweapon = var_03;
  var_0.secondaryweapon = var_04;
  var_0.owner scripts\mp\utility\game::_giveweapon(var_03);
  var_0.owner scripts\mp\utility\game::_giveweapon(var_04);
  var_0.owner scripts\mp\utility\game::_switchtoweaponimmediate(var_03);
  var_0.owner getwholescenedurationmax(var_00, "tag_player", 0.0, 180, 180, 45, 180);
  var_0.owner _meth_8236(0);
  var_0.owner _meth_85A2(getthormapvisionset(level.mapname));
  var_0.owner thread func_B011(var_00);
  var_0.owner setclientomnvar("ui_thor_show", 1);
  var_0.owner setclientomnvar("ui_thor_missiles_loaded", var_2.weapon["missile"].func_B47C);
  var_0.owner thermalvisionfofoverlayon();
  var_0.owner thermalvisionon();

  for(var_05 = 0; var_05 < 5; var_5++) {
    var_0.owner setclientomnvar(var_0.func_B88C[var_05].omnvar, undefined);
    var_0.owner setclientomnvar(var_0.func_B888[var_05].omnvar, -1);
  }

  var_0.owner _meth_82C0("thor_killstreak", 1);
  var_06 = var_2.teamsplash;
  var_07 = scripts\mp\killstreak_loot::getrarityforlootitem(var_0.streakinfo.variantid);

  if(var_07 != "")
    var_06 = var_06 + "_" + var_07;

  level thread scripts\mp\utility\game::teamplayercardsplash(var_06, self);
  var_0.owner scripts\engine\utility::allow_weapon_switch(0);
  var_00 func_8ED7(var_0.basemodel);
  var_00 thread func_117A7();
  var_00 thread func_117A0();
  var_00 thread func_117A9();
  wait 0.5;
  var_00 scriptmodelplayanim("iw7_mp_killstreak_thor_extend", 1);
  wait 0.5;
  var_00 scriptmodelplayanim("iw7_mp_killstreak_thor_extend_idle", 1);
  var_00 setscriptablepartstate("thrusters", "idle", 0);
  scripts\mp\shellshock::_earthquake(0.2, 0.76, var_0.origin, 1000);
  var_00 linkto(self.func_117AF, "tag_origin");
  var_00 scripts\mp\killstreaks\utility::func_1843(var_0.streakname, undefined, var_0.owner, 1);
  var_08 = "icon_minimap_thor_friendly";
  var_0.minimapid = var_00 scripts\mp\killstreaks\airdrop::createobjective(var_08, undefined, 1, 1, 1);
  var_09 = var_2.timeout;

  if(scripts\mp\killstreaks\utility::func_A69F(var_0.streakinfo, "passive_armor_duration"))
    var_09 = var_09 - 5;

  var_00 thread func_1179D(var_0.owner);
  var_00 thread func_117AC(var_09);
  var_00 thread func_117AA();
  var_00 thread func_1179F();
  var_00 thread func_117AD();
  var_00 thread func_117AB();
  var_00 thread func_117A2();

  if(scripts\mp\killstreaks\utility::func_A69F(var_0.streakinfo, "passive_switch_thruster"))
    var_00 thread thor_watchswitchthrust(var_0.owner);

  var_00 thread func_117A3();
  var_00 thread func_1179E();
  var_00 thread func_117A5();
  var_00 thread func_117A1();
  var_00 thread func_117A8();
  var_00 thread func_11790();
  var_00 thread watchhostmigrationfinishedinit(self, var_02);
  var_0.owner scripts\mp\matchdata::logkillstreakevent(var_0.streakname, self.origin);
  var_0.owner scripts\engine\utility::allow_usability(0);
  var_0.owner setclientomnvar("ui_killstreak_countdown", gettime() + int(var_09 * 1000));
  var_0.owner setclientomnvar("ui_killstreak_health", var_2.maxhealth / 2600);
}

func_8ED7(var_00) {
  self hidepart("j_backend", var_00);
  self hidepart("j_shield_1", var_00);
  self hidepart("j_shield_2", var_00);
  self hidepart("j_shield_3", var_00);
  self hidepart("j_shield_4", var_00);
  self hidepart("j_nose", var_00);
}

func_989D(var_00) {
  var_01 = [];

  switch (var_00) {
    case "ID":
      for(var_02 = 0; var_02 < 5; var_2++) {
        var_03 = spawnStruct();
        var_3.omnvar = "ui_thor_missile_" + var_02;
        var_3.inuse = 0;
        var_1[var_1.size] = var_03;
      }

      break;
    case "Distance":
      for(var_02 = 0; var_02 < 5; var_2++) {
        var_03 = spawnStruct();
        var_3.omnvar = "ui_thor_missile_" + var_02 + "_dist";
        var_3.inuse = 0;
        var_1[var_1.size] = var_03;
      }

      break;
  }

  return var_01;
}

watchhostmigrationfinishedinit(var_00, var_01) {
  var_00 endon("disconnect");
  var_00 endon("joined_team");
  var_00 endon("joined_spectators");
  var_00 endon("killstreak_disowned");
  level endon("game_ended");
  self endon("death");
  self endon("leaving");

  for(;;) {
    level waittill("host_migration_end");
    var_00 thermalvisionfofoverlayon();

    if(scripts\mp\utility\game::istrue(self.func_117B2)) {
      var_00 thermalvisionon();
      continue;
    }

    var_00 thermalvisionoff();
  }
}

func_B011(var_00) {
  self endon("disconnect");
  level endon("game_ended");
  var_00 endon("death");
  wait 0.05;
  var_01 = vectortoangles(level.func_12AF5.origin - var_00 gettagorigin("tag_player"));
  self setplayerangles(var_01);
}

func_1369B(var_00) {
  self endon("disconnect");
  var_00 endon("death");
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(1.0);
  var_01 = scripts\mp\utility\game::outlineenableforplayer(self, "cyan", self, 0, 0, "killstreak");
  var_00 thread removeoutline(var_01, self);
}

waitanddelete(var_00) {
  self endon("death");
  level endon("game_ended");
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(var_00);
  self delete();
}

func_1179A(var_00) {
  scripts\mp\utility\game::setusingremote(var_0.streakname);
}

func_1178F(var_00) {
  if(isDefined(self))
    scripts\mp\utility\game::clearusingremote();
}

func_1179C(var_00) {
  while(isDefined(self.func_9BE2) && var_00 > 0) {
    wait 0.05;
    var_00 = var_00 - 0.05;
  }
}

func_1179D(var_00) {
  var_00 endon("disconnect");
  level endon("game_ended");

  for(;;) {
    var_01 = scripts\engine\utility::waittill_any_return("start_fire", "start_reload", "death", "leaving");

    if(var_01 == "death" || var_01 == "leaving") {
      break;
    }
    var_00 scripts\engine\utility::allow_fire(0);
    scripts\engine\utility::waittill_any("finished_single_fire", "finished_reload", "death", "leaving");
    var_00 scripts\engine\utility::allow_fire(1);
  }
}

func_117A0() {
  level endon("game_ended");
  self endon("leaving");
  self waittill("death");

  if(isDefined(self.owner)) {
    self.owner func_11791(self);
    self.owner setclientomnvar("ui_thor_show", 0);
    self.owner setclientomnvar("ui_killstreak_countdown", 0);
    self.owner setclientomnvar("ui_killstreak_health", 0);
    self.owner setclientomnvar("ui_killstreak_missile_warn", 0);
    self.owner clearclienttriggeraudiozone(1);
    self.owner stoprumble("thor_thrust_rumble");

    foreach(var_01 in self.func_B88C)
    self.owner setclientomnvar(var_1.omnvar, undefined);

    foreach(var_04 in self.func_B888)
    self.owner setclientomnvar(var_4.omnvar, -1);
  }

  func_4074();
  scripts\mp\utility\game::decrementfauxvehiclecount();
  playFX(scripts\engine\utility::getfx("thor_explode"), self.origin);
  self delete();
}

func_117AC(var_00) {
  level endon("game_ended");
  self endon("death");
  self endon("leaving");
  self endon("host_migration_lifetime_update");
  self.owner endon("disconnect");
  self.owner endon("joined_team");
  self.owner endon("joined_spectators");
  thread scripts\mp\killstreaks\utility::watchhostmigrationlifetime("leaving", var_00, ::func_117AC);
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(var_00);
  func_1179C(3);
  var_01 = ["thor_end", "thor_timeout"];
  var_02 = randomint(var_1.size);
  var_03 = var_1[var_02];
  self.owner scripts\mp\utility\game::playkillstreakdialogonplayer(var_03, undefined, undefined, self.owner.origin);
  thread func_11795();
}

func_117A7() {
  level endon("game_ended");
  self endon("death");
  self endon("leaving");
  self.owner scripts\engine\utility::waittill_any("disconnect", "joined_team", "joined_spectators");
  self notify("death");
}

func_117A5() {
  level endon("game_ended");
  self endon("death");
  self endon("leaving");
  self.owner endon("disconnect");
  self.owner endon("joined_team");
  self.owner endon("joined_spectators");
  level waittill("objective_cam");
  thread func_11795();
}

func_117A9() {
  self endon("death");
  self endon("leaving");
  self.owner endon("disconnect");
  self.owner endon("joined_team");
  self.owner endon("joined_spectators");
  level scripts\engine\utility::waittill_any("round_end_finished", "game_ended");
  var_00 = 1;
  thread func_11795(var_00);
}

func_11795(var_00) {
  self endon("death");
  self notify("leaving");
  var_01 = level.func_117B0[self.streakname];
  scripts\mp\utility\game::leaderdialog(var_1.votimedout);

  if(isDefined(self.owner)) {
    self.owner func_11791(self, var_00);
    self.owner setclientomnvar("ui_thor_show", 0);
    self.owner setclientomnvar("ui_killstreak_countdown", 0);
    self.owner setclientomnvar("ui_killstreak_health", 0);
    self.owner setclientomnvar("ui_killstreak_missile_warn", 0);
    self.owner clearclienttriggeraudiozone(1);
    self.owner stoprumble("thor_thrust_rumble");

    foreach(var_03 in self.func_B88C)
    self.owner setclientomnvar(var_3.omnvar, undefined);

    foreach(var_06 in self.func_B888)
    self.owner setclientomnvar(var_6.omnvar, -1);
  }

  self notify("gone");
  self scriptmodelplayanim("iw7_mp_killstreak_thor_extend_to_up", 1);
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(1);
  self moveto(self.origin + (0, 0, 15000), 5, 3.5);
  self scriptmodelplayanim("iw7_mp_killstreak_thor_extend_up", 1);
  self setscriptablepartstate("thrusters", "leave", 0);
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(5);
  func_4074();
  scripts\mp\utility\game::decrementfauxvehiclecount();
  self delete();
}

func_11791(var_00, var_01) {
  var_02 = level.func_117B0[var_0.streakname];
  scripts\mp\utility\game::printgameaction("killstreak ended - thor", self);

  if(isDefined(var_00)) {
    var_00 notify("end_remote");
    self notify("thor_ride_ended");
    scripts\engine\utility::allow_usability(1);

    if(getdvarint("camera_thirdPerson"))
      scripts\mp\utility\game::setthirdpersondof(1);

    self thermalvisionfofoverlayoff();
    self thermalvisionoff();
    self _meth_85A2("");
    self unlink();
    self setplayerangles(self.restoreangles);

    if(scripts\mp\utility\game::istrue(var_01))
      scripts\mp\utility\game::func_1136C(scripts\engine\utility::getlastweapon(), 1);
    else
      thread func_11794();

    self stopolcalsound("odin_negative_action");
    self stopolcalsound("odin_positive_action");

    foreach(var_04 in level.func_117B0[var_0.streakname].weapon) {
      if(isDefined(var_4.func_D5E4))
        self stopolcalsound(var_4.func_D5E4);

      if(isDefined(var_4.func_D5DD))
        self stopolcalsound(var_4.func_D5DD);
    }

    thread scripts\mp\killstreaks\killstreaks::func_11086();

    if(isDefined(self.func_117AF))
      self.func_117AF delete();

    thread scripts\mp\utility\game::_takeweapon(var_0.primaryweapon);
    thread scripts\mp\utility\game::_takeweapon(var_0.secondaryweapon);
    scripts\engine\utility::allow_weapon_switch(1);
  }
}

func_11794() {
  self endon("disconnect");
  self endon("death");
  level endon("game_ended");
  scripts\mp\utility\game::freezecontrolswrapper(1);
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(0.5);
  scripts\mp\utility\game::freezecontrolswrapper(0);
}

func_117AA() {
  self endon("death");
  self endon("leaving");
  level endon("game_ended");
  var_00 = self.owner;
  var_00 endon("disconnect");
  var_01 = spawn("script_model", (0, 0, 0));
  var_1.angles = vectortoangles((0, 0, 1));
  var_01 setModel("tag_origin");
  var_01 hide();
  self.targeting_marker = var_01;
  self _meth_8549();
  self _meth_8594();

  for(;;) {
    var_02 = var_00 getvieworigin() - (0, 0, 50);
    var_03 = var_02 + anglesToForward(var_00 getplayerangles()) * 50000;
    var_04 = ["physicscontents_clipshot", "physicscontents_corpseclipshot", "physicscontents_missileclip", "physicscontents_solid", "physicscontents_vehicle"];
    var_05 = physics_createcontents(var_04);
    var_06 = scripts\engine\trace::ray_trace(var_02, var_03, level.characters, var_05);
    var_1.origin = var_6["position"] + (0, 0, 50);
    scripts\engine\utility::waitframe();
  }
}

func_1179F() {
  self endon("death");
  self endon("leaving");
  var_00 = self.owner;
  var_00 endon("disconnect");
  var_01 = level.func_117B0[self.streakname];
  var_02 = var_1.maxhealth;
  var_03 = 0;
  var_04 = 3;
  var_05 = 4;
  var_06 = 5;

  if(scripts\mp\killstreaks\utility::func_A69F(self.streakinfo, "passive_armor_duration")) {
    var_4++;
    var_5++;
    var_6++;
  }

  for(;;) {
    self waittill("damage", var_07, var_08, var_09, var_10, var_11, var_12, var_13, var_14, var_15, var_16, var_17, var_18, var_19, var_20);
    var_16 = scripts\mp\utility\game::func_13CA1(var_16, var_20);

    if(isDefined(var_08)) {
      if(isDefined(var_8.owner))
        var_08 = var_8.owner;

      if(isDefined(var_8.team) && var_8.team == self.team && var_08 != self.owner)
        continue;
    }

    if(scripts\mp\equipment\phase_shift::isentityphaseshifted(var_08)) {
      continue;
    }
    if(isDefined(var_11))
      var_00 func_4CF1(self, var_11);

    if(isDefined(var_16)) {
      var_07 = scripts\mp\killstreaks\utility::getmodifiedantikillstreakdamage(var_08, var_16, var_11, var_07, var_1.maxhealth, var_04, var_05, var_06);

      if(scripts\mp\killstreaks\utility::func_A69F(self.streakinfo, "passive_armor_duration")) {
        if(scripts\mp\killstreaks\utility::isexplosiveantikillstreakweapon(var_16))
          var_08 scripts\mp\damagefeedback::updatedamagefeedback("hitblastshield");
      }
    }

    var_02 = var_02 - var_07;
    var_00 setclientomnvar("ui_killstreak_health", var_02 / var_1.maxhealth);

    if(isplayer(var_08)) {
      var_08 scripts\mp\damagefeedback::updatedamagefeedback("");
      scripts\mp\killstreaks\killstreaks::killstreakhit(var_08, var_16, self, var_11);
      scripts\mp\damage::logattackerkillstreak(self, var_07, var_08, var_09, var_10, var_11, var_12, var_13, var_14, var_15, var_16);

      if(var_02 <= 0) {
        var_08 notify("destroyed_killstreak", var_16);
        var_21 = "callout_destroyed_thor";
        var_22 = scripts\mp\killstreak_loot::getrarityforlootitem(self.streakinfo.variantid);

        if(var_22 != "")
          var_21 = var_21 + "_" + var_22;

        scripts\mp\damage::onkillstreakkilled("thor", var_08, var_16, var_11, var_07, "destroyed_thor", "thor_destroyed", var_21);
        return;
      }
    }
  }
}

func_4CF1(var_00, var_01) {
  switch (var_01) {
    case "MOD_GRENADE_SPLASH":
    case "MOD_GRENADE":
    case "MOD_PROJECTILE":
    case "MOD_EXPLOSIVE_BULLET":
    case "MOD_PISTOL_BULLET":
    case "MOD_RIFLE_BULLET":
      func_3239(var_00);
      break;
    case "MOD_PROJECTILE_SPLASH":
    case "MOD_IMPACT":
    case "MOD_EXPLOSIVE":
      func_69E6(var_00);
      break;
    default:
  }
}

func_3239(var_00) {
  self earthquakeforplayer(0.15, 0.25, var_00 gettagorigin("tag_player"), 50);
  self playrumbleonentity("damage_light");
  thread func_1349D(var_00, 0.4);
}

func_69E6(var_00) {
  self earthquakeforplayer(0.4, 0.45, var_00 gettagorigin("tag_player"), 1000);
  self playrumbleonentity("damage_heavy");
  thread func_1349D(var_00, 0.7);
}

func_1349D(var_00, var_01) {
  self endon("disconnect");
  level endon("game_ended");
  var_00 endon("death");

  for(var_0.func_10E4C.alpha = var_01; var_01 > 0; var_0.func_10E4C.alpha = var_01) {
    scripts\engine\utility::waitframe();
    var_01 = var_01 - 0.1;
  }
}

func_495B() {
  var_00 = newclienthudelem(self);
  var_0.x = 0;
  var_0.y = 0;
  var_00 setshader("white", 640, 480);
  var_0.alignx = "left";
  var_0.aligny = "top";
  var_0.sort = 1;
  var_0.horzalign = "fullscreen";
  var_0.vertalign = "fullscreen";
  var_0.alpha = 0;
  var_0.foreground = 1;
  return var_00;
}

func_117AD() {
  self endon("death");
  self endon("leaving");
  level endon("game_ended");
  var_00 = self.owner;
  var_00 endon("disconnect");
  var_01 = level.func_117B0[self.streakname];

  if(!isai(var_00))
    var_00 notifyonplayercommand("thor_missile_zoom_on", "+weapnext");

  for(;;) {
    var_00 waittill("thor_missile_zoom_on");
    var_00 scripts\engine\utility::allow_weapon_switch(1);

    if(!isDefined(self.func_117B3)) {
      var_00 scripts\mp\utility\game::_switchtoweaponimmediate(self.secondaryweapon);
      self.func_117B3 = 1;
      var_00 setclientomnvar("ui_thor_show", 2);
    } else {
      var_00 scripts\mp\utility\game::_switchtoweaponimmediate(self.primaryweapon);
      self.func_117B3 = undefined;
      var_00 setclientomnvar("ui_thor_show", 1);
    }

    var_00 scripts\engine\utility::allow_weapon_switch(0);
  }
}

func_117AB() {
  self endon("death");
  self endon("leaving");
  level endon("game_ended");
  var_00 = self.owner;
  var_00 endon("disconnect");
  var_01 = level.func_117B0[self.streakname];

  if(!isai(var_00)) {
    if(var_00 scripts\engine\utility::is_player_gamepad_enabled())
      var_00 notifyonplayercommand("thor_thermal_toggle", "+usereload");

    var_00 notifyonplayercommand("thor_thermal_toggle", "+activate");
  }

  for(;;) {
    var_00 waittill("thor_thermal_toggle");

    if(!isDefined(self.func_117B2)) {
      var_00 thermalvisionon();
      self.func_117B2 = 1;
      continue;
    }

    var_00 thermalvisionoff();
    self.func_117B2 = undefined;
  }
}

func_117A2() {
  self endon("death");
  self endon("leaving");
  var_00 = self.owner;
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
      var_0.func_117AF thread func_E731(var_0.thorrigangle, 30, "thor_release_thrusters", "thor_switch_thrusters");
      thread func_B06B(var_00);

      if(var_0.thorrigangle == -360)
        self scriptmodelplayanim("iw7_mp_killstreak_thor_extend_thrust", 1);
      else
        self scriptmodelplayanim("iw7_mp_killstreak_thor_extend_rev_thrust", 1);

      self setscriptablepartstate("thrusters", "boost", 0);
      continue;
    }

    var_0.func_117AF thread func_E731(var_0.thorrigangle, 60, "thor_fire_thrusters", "thor_switch_thrusters");
    var_00 stoprumble("thor_thrust_rumble");

    if(var_0.thorrigangle == -360)
      self scriptmodelplayanim("iw7_mp_killstreak_thor_extend_idle", 1);
    else
      self scriptmodelplayanim("iw7_mp_killstreak_thor_extend_rev_idle", 1);

    self setscriptablepartstate("thrusters", "idle", 0);
  }
}

func_B06B(var_00) {
  self endon("death");
  var_00 endon("thor_release_thrusters");
  var_00 _meth_8244("thor_thrust_rumble");

  for(;;) {
    scripts\mp\shellshock::_earthquake(0.15, 0.05, self.origin, 1000);
    scripts\engine\utility::waitframe();
  }
}

func_B9F2(var_00) {
  self endon("death");
  level endon("game_ended");
  var_00 endon("disconnect");
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(1.5);
  var_01 = [];

  for(;;) {
    var_02 = var_00 scripts\mp\utility\game::get_players_watching();

    foreach(var_04 in var_01) {
      if(!scripts\engine\utility::array_contains(var_02, var_04)) {
        var_01 = scripts\engine\utility::array_remove(var_01, var_04);
        self hide();
        self giveperkequipment(var_00);
      }
    }

    foreach(var_04 in var_02) {
      self giveperkequipment(var_04);

      if(!scripts\engine\utility::array_contains(var_01, var_04)) {
        var_01 = scripts\engine\utility::array_add(var_01, var_04);
        stopFXOnTag(level._effect["thor_targeting"], self, "tag_origin");
        wait 0.05;
        playFXOnTag(level._effect["thor_targeting"], self, "tag_origin");
      }
    }

    wait 0.25;
  }
}

thor_watchswitchthrust(var_00) {
  self endon("death");
  self endon("leaving");
  level endon("game_ended");
  var_00 = self.owner;
  var_00 endon("disconnect");

  if(!isai(var_00)) {
    var_00 notifyonplayercommand("thor_switch_thrusters", "+speed_throw");
    var_00 notifyonplayercommand("thor_switch_thrusters", "+toggleads_throw");
    var_00 notifyonplayercommand("thor_switch_thrusters", "+ads_akimbo_accessible");
  }

  for(;;) {
    var_01 = var_00 scripts\engine\utility::waittill_any_return("thor_switch_thrusters");

    if(var_0.thorrigangle == -360) {
      self scriptmodelplayanim("iw7_mp_killstreak_thor_extend_rev_idle", 1);
      var_0.thorrigangle = 360;
    } else {
      self scriptmodelplayanim("iw7_mp_killstreak_thor_extend_idle", 1);
      var_0.thorrigangle = -360;
    }

    var_0.func_117AF thread func_E731(var_0.thorrigangle, 60, "thor_fire_thrusters", "thor_switch_thrusters");
  }
}

thor_watchdebugtogglemovement(var_00) {
  self endon("death");
  self endon("leaving");
  level endon("game_ended");
  var_00 endon("disconnect");

  if(!isai(var_00)) {
    var_00 notifyonplayercommand("thor_toggle_movement", "+speed_throw");
    var_00 notifyonplayercommand("thor_toggle_movement", "+toggleads_throw");
    var_00 notifyonplayercommand("thor_toggle_movement", "+ads_akimbo_accessible");
  }

  var_01 = 1;

  for(;;) {
    var_02 = var_00 scripts\engine\utility::waittill_any_return("thor_toggle_movement");

    if(scripts\mp\utility\game::istrue(var_01)) {
      self unlink();
      var_01 = 0;
      continue;
    }

    self linkto(var_0.func_117AF, "tag_origin");
    var_01 = 1;
  }
}

func_117A3() {
  self endon("death");
  self endon("leaving");
  level endon("game_ended");
  var_00 = self.owner;
  var_00 endon("disconnect");
  var_01 = "missile";
  var_02 = level.func_117B0[self.streakname].weapon[var_01];

  for(;;) {
    var_00 waittill("missile_fire", var_03, var_04);

    if(scripts\mp\utility\game::istrue(self.func_9BE2)) {
      continue;
    }
    if(scripts\mp\utility\game::istrue(self.func_9C9F)) {
      continue;
    }
    if(isDefined(level.hostmigrationtimer)) {
      continue;
    }
    if(isDefined(self.func_C239) && self.func_C239 < 1) {
      continue;
    }
    if(isDefined(var_04) && (var_04 != "thorproj_mp" && var_04 != "thorproj_zoomed_mp")) {
      continue;
    }
    self setscriptablepartstate("muzzle", "fire", 0);
    thread func_5104(0.1);
    var_3.streakinfo = self.streakinfo;

    if(isDefined(var_04) && var_04 == "thorproj_mp") {
      var_03 thread func_139D1(var_00, var_01, self);
      continue;
    }

    var_03 thread func_13B42(var_00, self);
  }
}

func_5104(var_00) {
  self endon("death");
  wait(var_00);
  self setscriptablepartstate("muzzle", "neutral", 0);
}

func_139D1(var_00, var_01, var_02) {
  var_00 endon("disconnect");
  var_02 endon("death");
  var_03 = var_2.targeting_marker;
  var_04 = var_2.func_B88C;
  var_05 = var_2.func_B888;
  var_06 = self.angles;
  var_2.func_9BE2 = 1;
  var_02 notify("start_fire");
  var_07 = var_3.origin;
  var_08 = scripts\mp\killstreaks\utility::func_7E92(var_00);
  var_09 = [];

  foreach(var_11 in var_08) {
    if(!scripts\mp\killstreaks\utility::manualmissilecantracktarget(var_11)) {
      continue;
    }
    if(var_00 worldpointinreticle_circle(var_11.origin, 65, 55))
      var_9[var_9.size] = var_11;
  }

  self waittill("explode", var_13);
  var_14 = var_2.func_C239;
  var_15 = "thorproj_tracking_mp";

  for(var_16 = 0; var_16 < var_14; var_16++) {
    if(!isDefined(var_02)) {
      break;
    }
    var_17 = randomint(360);
    var_18 = anglestoright(var_06) * cos(var_17);
    var_19 = anglesToForward(var_06) * 3;
    var_20 = anglestoup(var_06) * sin(var_17);
    var_21 = var_18 + var_19 + var_20;
    var_22 = scripts\mp\utility\game::_magicbullet(var_15, var_13, var_13 + var_21, var_00);
    var_22.owner = var_00;
    var_22.zoffset = var_13[2];
    var_22.id = func_7FBA(var_04);
    var_22.func_5716 = func_7FBA(var_05);
    var_22.outlineid = scripts\mp\utility\game::outlineenableforplayer(var_22, "white", var_22.owner, 0, 0, "killstreak_personal");
    var_22.streakinfo = var_2.streakinfo;
    var_22.owner setclientomnvar(var_22.id.omnvar, var_22);
    var_22.owner setclientomnvar(var_22.func_5716.omnvar, int(var_22.zoffset));

    if(scripts\mp\killstreaks\utility::func_A69F(var_2.streakinfo, "passive_seek_cluster"))
      var_22 thread delayseekopentargetinview(0.3, var_22.owner, var_07, var_09);
    else
      var_22 thread func_50E6(0.3, var_03);

    var_22 thread func_139F6(var_22.owner, var_02);
    var_22 thread func_13A22(var_22.owner, var_02);
    var_22 thread scripts\mp\killstreaks\utility::watchsupertrophynotify(var_22.owner);
    var_2.func_C239--;
    var_00 setclientomnvar("ui_thor_missiles_loaded", var_2.func_C239);
    scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(0.1);
  }

  var_02 scriptmodelplayanim("iw7_mp_killstreak_thor_extend_reload", 1);
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(2);
  var_02 notify("start_reload");
  var_2.func_9BE2 = undefined;
}

delayseekopentargetinview(var_00, var_01, var_02, var_03) {
  var_04 = undefined;
  wait(var_00);

  foreach(var_06 in var_03) {
    if(!scripts\mp\killstreaks\utility::manualmissilecantracktarget(var_06)) {
      continue;
    }
    if(scripts\mp\utility\game::istrue(var_6.thortargetted)) {
      continue;
    }
    var_04 = var_06;
    break;
  }

  if(isDefined(var_04)) {
    self missile_settargetent(var_04);
    self missile_setflightmodedirect();
    var_4.thortargetted = 1;
    var_04 thread watchtarget(self);
  } else {
    self missile_settargetpos(var_02);
    self missile_setflightmodedirect();
  }
}

watchtarget(var_00) {
  self endon("disconnect");

  for(;;) {
    if(!scripts\mp\killstreaks\utility::manualmissilecantracktarget(self)) {
      break;
    }
    if(!isDefined(var_00)) {
      break;
    }
    scripts\engine\utility::waitframe();
  }

  self.thortargetted = undefined;

  if(isDefined(var_00))
    var_00 missile_cleartarget();
}

canseetarget(var_00) {
  var_01 = 0;
  var_02 = scripts\engine\trace::create_contents(0, 1, 1, 1, 1, 1, 0);
  var_03 = var_00 gettagorigin("j_head");

  for(var_04 = 0; var_04 < var_3.size; var_4++) {
    if(!scripts\engine\trace::ray_trace_passed(self.origin, var_3[var_04], self, var_02)) {
      continue;
    }
    var_01 = 1;
    break;
  }

  return var_01;
}

func_50E6(var_00, var_01) {
  self.owner endon("disconnect");
  wait(var_00);

  if(isDefined(var_01))
    self missile_settargetent(var_01);

  self missile_setflightmodedirect();
}

func_139F6(var_00, var_01) {
  self endon("explode");
  self endon("death");

  for(;;) {
    if(isDefined(var_1.func_9C9F)) {
      break;
    }
    self.zoffset = self.origin[2];
    var_02 = scripts\engine\trace::ray_trace(self.origin, self.origin + (0, 0, -1000000.0));
    var_03 = var_2["position"];
    self.zoffset = self.origin - var_2["position"];
    self.zoffset = self.zoffset[2];
    var_00 setclientomnvar(self.func_5716.omnvar, int(max(0.0, self.zoffset)));
    scripts\engine\utility::waitframe();
  }
}

func_13A22(var_00, var_01) {
  self waittill("explode", var_02);

  if(isDefined(self.outlineid))
    scripts\mp\utility\game::outlinedisable(self.outlineid, self);

  if(isDefined(var_00)) {
    if(isDefined(self.id.omnvar))
      var_00 setclientomnvar(self.id.omnvar, undefined);
  }
}

func_13B42(var_00, var_01) {
  var_00 endon("disconnect");
  var_01 endon("death");
  var_1.func_9BE2 = 1;
  var_01 notify("start_fire");
  var_02 = var_1.func_B88C;
  var_03 = var_1.func_B888;
  self.zoffset = self.origin[2];
  self.id = func_7FBA(var_02);
  self.func_5716 = func_7FBA(var_03);
  self.outlineid = scripts\mp\utility\game::outlineenableforplayer(self, "white", var_00, 0, 0, "killstreak_personal");
  var_00 setclientomnvar(self.id.omnvar, self);
  var_00 setclientomnvar(self.func_5716.omnvar, int(self.zoffset));
  thread func_139F6(var_00, var_01);
  thread func_13A22(var_00, var_01);
  thread scripts\mp\killstreaks\utility::watchsupertrophynotify(var_00);
  var_1.func_C239--;
  var_00 setclientomnvar("ui_thor_missiles_loaded", var_1.func_C239);
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(0.1);

  if(var_1.func_C239 > 0)
    var_01 notify("finished_single_fire");
  else {
    var_01 scriptmodelplayanim("iw7_mp_killstreak_thor_extend_reload", 1);
    scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(2);
    var_01 notify("start_reload");
  }

  var_1.func_9BE2 = undefined;
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
    var_0++;
  }
}

func_1179B() {
  self endon("death");
  var_00 = self.owner;
  var_00 endon("disconnect");
  var_00 endon("thor_missile_fire_success");
  level endon("game_ended");
  func_1179C(3);

  if(self.func_C239 < self.func_B47C) {
    self.func_9C9F = 1;
    var_00 playlocalsound("thor_missile_reload");
    thread func_510A(1);

    while(self.func_C239 < self.func_B47C) {
      self.func_C239++;
      var_00 setclientomnvar("ui_thor_missiles_loaded", self.func_C239);
      self.func_B88C[self.func_C239 - 1].inuse = 0;
      self.func_B888[self.func_C239 - 1].inuse = 0;
      var_00 setclientomnvar(self.func_B888[self.func_C239 - 1].omnvar, -1);
    }
  } else
    self notify("finished_reload");
}

func_510A(var_00) {
  self endon("death");
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(var_00);
  self.func_9C9F = undefined;
  self notify("finished_reload");
}

func_12F01(var_00) {
  self endon("death");
  var_00 endon("disconnect");
  var_00 endon("thor_missile_fire_success");
  level endon("game_ended");
  var_01 = gettime();
  var_02 = var_01 + self.func_DF5C * 1000;
  var_03 = var_01;

  while(var_03 < var_02) {
    var_03 = gettime();
    var_04 = (var_03 - var_01) / (var_02 - var_01);
    var_04 = clamp(var_04, 0.0, 1.0);
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

  foreach(var_01 in level.participants)
  func_20D2(var_01);
}

func_20D2(var_00) {
  if(level.teambased && var_0.team != self.team)
    return;
  else if(!level.teambased) {
    return;
  }
  var_01 = scripts\mp\utility\game::outlineenableforplayer(var_00, "cyan", self.owner, 1, 1, "killstreak");
  thread removeoutline(var_01, var_00);
}

func_6567(var_00) {
  return var_00 scripts\mp\utility\game::_hasperk("specialty_noplayertarget");
}

removeoutline(var_00, var_01, var_02) {
  if(isDefined(var_01))
    var_01 endon("disconnect");

  level endon("game_ended");
  var_03 = ["leave", "death"];

  if(isDefined(var_02))
    scripts\engine\utility::waittill_any_in_array_or_timeout_no_endon_death(var_03, var_02);
  else
    scripts\engine\utility::waittill_any_in_array_return_no_endon_death(var_03);

  scripts\mp\utility\game::outlinedisable(var_00, var_01);
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

func_11790(var_00) {
  self endon("death");
  self endon("leaving");
  level endon("game_ended");
  var_01 = level.func_117B0[self.streakname];
  var_02 = 1.0;

  for(;;) {
    self waittill("thor_enemy_killed");
    scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(var_02);

    if(self.enemieskilledintimewindow > 1)
      self.owner scripts\mp\utility\game::leaderdialogonplayer(var_1.func_1352C);
    else
      self.owner scripts\mp\utility\game::leaderdialogonplayer(var_1.func_1352D);

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

func_11797(var_00) {
  self endon("disconnect");
  self waittill("spawned_player");
  var_00 func_20D2(self);
}

func_4074() {
  if(isDefined(self.targeting_marker))
    self.targeting_marker delete();

  if(isDefined(self.func_C7FF))
    self.func_C7FF delete();

  if(isDefined(self.func_10E4C))
    self.func_10E4C destroy();

  if(isDefined(self.minimapid))
    scripts\mp\objidpoolmanager::returnminimapid(self.minimapid);

  level.func_C20D--;
}

func_117A1() {
  level endon("game_ended");
  self endon("death");
  self endon("leaving");
  thread scripts\mp\killstreaks\killstreaks::allowridekillstreakplayerexit();
  self waittill("killstreakExit");
  var_00 = level.func_117B0[self.streakname];
  scripts\mp\utility\game::leaderdialog(var_0.votimedout);
  thread func_11795();
}

func_7FBA(var_00) {
  var_01 = undefined;

  for(var_02 = 4; var_02 + 1 > 0; var_2--) {
    if(!var_0[var_02].inuse) {
      var_01 = var_0[var_02];
      var_0[var_02].inuse = 1;
      break;
    }
  }

  return var_01;
}

getthormapvisionset(var_00) {
  var_01 = "";

  switch (var_00) {
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