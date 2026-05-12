/*************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\killstreaks\_plane_gunner.gsc
*************************************************/

func_00D5() {
  level.var_0611["airstrike_death"] = loadfx("vfx/scorestreaks/plane_gunner_death");
  self.var_701F = 0;
  self.var_7020 = 0;
  level.var_5A7D["plane_gunner_bomber_projectile_mp"] = "plane_gunner";
  level.var_5A7D["turretweapon_plane_gunner_turret_mp"] = "plane_gunner";
  level.var_5A7D["turretweapon_plane_gunner_turret_grenadier_mp"] = "plane_gunner";
  level.var_5A61["plane_gunner"] = ::func_9E37;
}

func_9E37(param_00) {
  if(maps\mp\_utility::func_5668()) {
    return 0;
  }

  if(isDefined(level.var_7019)) {
    self iclientprintlnbold(&"KILLSTREAKS_AIR_SPACE_TOO_CROWDED");
    return 0;
  }

  var_01 = func_2BD1(param_00, "plane_gunner");
  if(!isDefined(var_01) || !var_01) {
    return 0;
  }

  return 1;
}

func_9081(param_00, param_01, param_02, param_03, param_04, param_05, param_06) {
  var_07 = param_01 maps\mp\_utility::func_0649("specialty_improvedstreaks");
  var_08 = spawn("script_model", param_03);
  var_08.var_001D = param_04;
  var_09 = "usa_bomber_b17_vista_noball_axis";
  var_08.var_39C8 = "usa_bomber_b17_vista_noball_axis_fade";
  if(param_01.var_01A7 == "allies") {
    var_09 = "usa_bomber_b17_vista_noball";
    var_08.var_39C8 = "usa_bomber_b17_vista_noball_fade";
  }

  var_08 setModel(var_08.var_39C8);
  var_08 thread lib_0527::func_39C6(var_09, 0.5);
  var_08 scriptmodelplayanim("ks_plane_gunner_usa");
  var_08.var_5C2F = gettime();
  var_08 thread lib_0527::func_2818();
  var_08 thread lib_0527::func_4ACE();
  param_01 maps\mp\_utility::func_744E();
  level thread func_637A(var_08, param_01);
  level thread func_63A8(var_08, param_01);
  level thread func_637D(var_08, param_01);
  level thread func_636E(var_08, param_01);
  level thread func_63D9(var_08, param_01);
  level thread func_7CF3(var_08, param_01);
  param_01 maps\mp\_utility::func_3E8E(1);
  var_0A = "usa_bomber_b17_ballturret_axis";
  if(param_01.var_01A7 == "allies") {
    var_0A = "usa_bomber_b17_ballturret";
  }

  if(var_07) {
    var_08.var_7039 = var_08 func_9083("turretweapon_plane_gunner_turret_grenadier_mp", var_0A, "tag_turret", param_01);
  } else {
    var_08.var_7039 = var_08 func_9083("turretweapon_plane_gunner_turret_mp", var_0A, "tag_turret", param_01);
  }

  var_08.var_7037 = var_08 func_9082();
  level.var_7019 = var_08;
  func_86FA(var_08, param_01, "machine_gun", 1);
  thread func_3C19(var_08, param_01);
  if(getdvarint("311")) {
    param_01 maps\mp\_utility::func_8742(0);
  }

  param_01 setclientomnvar("ui_plane_gunner_reloading", 0);
  param_01 thread lib_0526::func_8A61(0.05, level.var_5A7C, level.var_5A6B);
  lib_0526::func_A232(1);
  param_01 thermalvisionfofoverlayon();
  param_01 thread maps\mp\killstreaks\_killstreaks::func_0A2F();
  param_01 thread func_316F(var_08, param_01);
  param_01 thread maps\mp\_utility::func_3E90(0, 0.75);
  if(1) {
    var_08.var_620D = spawnplane("script_model", param_03);
    var_08.var_620D setModel("tag_origin");
    var_08.var_620D method_8351(param_01, lib_0527::func_4613(param_05), 20, 20);
    var_08.var_620D method_8449(var_08, "tag_origin", (0, 0, 0), (0, 0, 0));
  }

  var_08.var_01C8 = param_05;
  lib_0527::func_09E1(var_08);
  var_08 setCanDamage(1);
  var_08 setCanRadiusDamage(1);
  var_08 thread maps\mp\gametypes\_damage::func_8676(lib_0527::func_4612(param_05), undefined, ::func_6B6A, ::func_6B69, 1);
  var_08 thread func_4AB8(param_01);
  var_08 thread func_701A(param_01);
  var_08.var_5CC6 = param_00;
  var_08.var_0117 = param_01;
  var_08.var_01A7 = param_01.var_01A7;
  var_08.var_34AC = param_02;
  if(!getdvarint("plane_gunner_debug", 0)) {
    var_08 thread func_702D(param_02, param_04, param_01);
  }

  thread func_703A(var_08, param_05);
  var_08 endon("death");
  var_08 endon("crashing");
  var_08 waittill("pathComplete");
  var_08 thread func_2390();
}

func_701A(param_00) {
  var_01 = self;
  wait(0.1);
  if(isDefined(param_00)) {
    thread func_701C(var_01, param_00);
  }

  var_02 = [];
  foreach(var_04 in level.var_744A) {
    if(!isDefined(param_00) || var_04 != param_00) {
      var_02[var_02.size] = var_04;
    }
  }

  if(isDefined(var_02) && var_02.size > 0) {
    thread func_701B(var_01, var_02);
  }
}

func_701D() {
  self endon("death");
  self waittill("leaving");
  return 1;
}

func_701C(param_00, param_01) {
  lib_0380::func_6844("ks_gunner_plr_enter", [param_01], param_00);
  param_01.var_7038 = lib_0380::func_6844("ks_gunner_plr_loop", [param_01], param_00, 1.5);
  var_02 = param_00 func_701D();
  lib_0380::func_6850(param_01.var_7038, 2);
  if(isDefined(var_02)) {
    wait(0.1);
    lib_0380::func_6842("ks_gunner_plr_exit", [param_01], param_01.var_0116);
  }
}

func_701B(param_00, param_01) {
  lib_0380::func_6844("ks_gunner_npc_enter", param_01, param_00);
  var_02 = lib_0380::func_6844("ks_gunner_npc_loop", param_01, param_00, 1.5);
  var_03 = param_00 func_701D();
  lib_0380::func_6850(var_02, 1.5);
  if(isDefined(var_03)) {
    lib_0380::func_6842("ks_gunner_npc_exit", param_01, param_00.var_0116);
  }
}

func_702D(param_00, param_01, param_02) {
  self endon("airstrike_complete");
  self endon("leaving");
  var_03 = param_02 maps\mp\_utility::func_0649("specialty_improvedstreaks");
  self.var_933D = "flying_in";
  if(1 && isDefined(self.var_620D)) {
    var_04 = int(3.8) * 1000;
    self.var_620D method_8352(var_04, 1);
  }

  var_05 = func_703E(param_01[1], 4750, 1250);
  wait(var_05);
  if(isDefined(param_02.var_701E) && param_02.var_701E) {
    thread func_7034();
    return;
  }

  thread func_705D();
  self.var_933D = "strike";
  self notify("entering_playspace");
  if(var_03) {
    var_05 = func_703E(param_01[1], 4000, 475);
  } else {
    var_05 = func_703E(param_01[1], 4000, 750);
  }

  var_06 = 2;
  wait(var_05 - var_06);
  self rotateroll(-10, var_06, var_06 / 2, var_06 / 2);
  self.var_5683 = 1;
  wait(var_06);
  self.var_5683 = undefined;
  var_07 = self.var_0116 - 3000 * anglestoright(param_01);
  self.var_9E9F = spawn("script_origin", var_07);
  self method_8449(self.var_9E9F);
  var_08 = 3.141593;
  var_09 = var_08 * 3000;
  if(var_03) {
    var_0A = abs(var_09 / 475);
  } else {
    var_0A = abs(var_0A / 750);
  }

  self.var_9E9F rotateby((0, 180, 0), var_0A);
  wait(var_0A);
  self unlink();
  self.var_9E9F delete();
  if(var_03) {
    var_05 = func_703E(param_01[1], -6375, 475);
  } else {
    var_05 = func_703E(param_01[1], -6375, 750);
  }

  self rotateroll(10, var_06, var_06 / 2, var_06 / 2);
  self.var_5683 = 1;
  wait(var_06);
  self.var_5683 = undefined;
  wait(var_05 - var_06);
  thread func_7034();
}

func_7034() {
  self endon("airstrike_complete");
  self.var_933D = "flying_out";
  self notify("leaving");
  if(isDefined(self.var_0117)) {
    self.var_0117 thread maps\mp\_utility::func_5C43("planegun_ended");
  }

  if(1 && isDefined(self.var_620D)) {
    var_00 = int(9.6) * 1000;
    self.var_620D method_8352(var_00, 0);
  }

  var_01 = func_703E(self.var_001D[1], 12000, 1250);
  wait(var_01 - 1);
  if(isDefined(self.var_39C8)) {
    self setModel(self.var_39C8);
    self setmaterialscriptparam(1, 0, 1);
  }

  wait(1);
  self notify("pathComplete");
}

func_705D() {
  self endon("airstrike_complete");
  self waittill("player_exit");
  while(isDefined(self.var_5683)) {
    wait 0.05;
  }

  if(self islinked()) {
    self unlink();
    var_00 = 2;
    self rotateroll(10, var_00, var_00 / 2, var_00 / 2);
  }

  if(isDefined(self.var_9E9F)) {
    self.var_9E9F delete();
  }

  thread func_7034();
}

func_703E(param_00, param_01, param_02) {
  self endon("planeBomberOutOfAmmo");
  var_03 = self.var_0116;
  var_04 = (var_03[0] + param_01 * cos(param_00), var_03[1] + param_01 * sin(param_00), var_03[2]);
  var_05 = abs(param_01 / param_02);
  self moveto(var_04, var_05);
  return var_05;
}

func_4610() {
  if(getdvarint("trailer_plane_gunner_height", -1) != -1) {
    return getdvarint("trailer_plane_gunner_height");
  }

  return lib_0527::func_4409() + 2000;
}

func_44E7(param_00, param_01, param_02) {
  var_03 = 6750;
  var_04 = 3000;
  var_05 = param_00 - rotatevector((var_03, var_04, 0), param_01);
  var_05 = (var_05[0], var_05[1], param_02);
  return var_05;
}

func_83B9(param_00, param_01) {
  self endon("stop_location_selection");
  if(!isDefined(level.var_5FF0)) {
    level.var_5FF0 = 1024;
  }

  var_02 = level.var_5FF0 / 6.46875;
  if(level.var_910F) {
    var_02 = var_02 * 1.5;
  }

  var_03 = 1;
  self setclientomnvar("ui_map_location_num_planes", 1);
  self setclientomnvar("ui_map_location_height", func_4610());
  maps\mp\_utility::func_05D4(param_01, "map_artillery_selector", var_03, var_02, 0.5);
  thread lib_0527::func_A68F();
  var_04 = undefined;
  var_05 = undefined;
  var_06 = 0;
  while(!var_06 && !maps\mp\_utility::func_5668(0)) {
    self waittill("confirm_location", var_07, var_08);
    if(lib_0527::func_A272(var_07, var_08, self, param_01)) {
      var_04 = var_07;
      var_05 = var_08;
      self setclientomnvar("ui_map_location_use_carepackages", 0);
      self setclientomnvar("ui_map_location_num_planes", 0);
      self setclientomnvar("ui_map_location_height", 0);
      break;
    } else {
      thread lib_0527::func_8BEE();
    }
  }

  self setblurforplayer(0, 0.3);
  self notify("location_selection_complete");
  self setclientomnvar("ui_map_location_blocked", 0);
  return func_329A(param_00, param_01, var_04, var_05);
}

func_2BD1(param_00, param_01) {
  var_02 = lib_0527::func_4570();
  var_03 = getEntArray("minimap_corner", "targetname");
  var_04 = (0, 0, 0);
  if(var_03.size) {
    var_04 = lib_050D::func_3B89(var_03[0].var_0116, var_03[1].var_0116);
  }

  var_05 = var_04 + rotatevector((-1000, 0, 0), (0, var_02, 0));
  if(maps\mp\_utility::func_4571() == "mp_airship") {
    var_05 = (-168, 100, 128);
  }

  return func_329A(param_00, param_01, var_05, var_02);
}

func_329A(param_00, param_01, param_02, param_03) {
  if(maps\mp\_utility::func_5668()) {
    return 0;
  }

  if(isDefined(self.var_6E6B) && self.var_6E6B) {
    self iclientprintlnbold(&"KILLSTREAKS_DLC4_CANT_USE_STREAK_WHILE_PARATROOPING");
    return 0;
  }

  if(isDefined(level.var_7019)) {
    self iclientprintlnbold(&"KILLSTREAKS_AIR_SPACE_TOO_CROWDED");
    return 0;
  }

  level.var_7019 = 1;
  thread func_73DA();
  self waittill("initRideKillstreak_complete", var_04);
  if(!var_04) {
    return;
  }

  maps\mp\_matchdata::func_5E9A(param_01, param_02);
  maps\mp\_utility::func_8A5B("plane_gunner");
  self notify("used");
  if(level.var_3FDC == "scorestreak_training") {
    maps\mp\gametypes\scorestreak_training::func_244D();
  }

  self.var_7036 = 0;
  thread func_1E88(param_00, self, param_02, param_03, param_01);
  return 1;
}

func_1E88(param_00, param_01, param_02, param_03, param_04) {
  var_05 = func_4610();
  param_01 endon("disconnect");
  var_06 = (0, param_03, 0);
  if(getdvarint("plane_gunner_debug", 0)) {
    var_07 = param_02 + (0, 0, var_05);
  } else {
    var_07 = func_44E7(param_03, var_07, var_06);
  }

  level thread func_9081(param_00, param_01, param_02, var_07, var_06, param_04, 1);
}

func_6B6A(param_00, param_01, param_02, param_03) {
  thread lib_0527::func_272D();
  var_04 = "plane_gunner_destroyed";
  var_05 = "planegun_bailout";
  var_06 = "callout_destroyed_plane_gunner";
  maps\mp\gametypes\_damage::func_6B4B(param_00, param_01, param_02, param_03, var_04, var_05, var_06, 1);
  if(isDefined(param_00)) {
    param_00 maps\mp\_utility::func_5C43("planegun_destroyed");
  }
}

func_4AB8(param_00) {
  level endon("game_ended");
  self endon("airstrike_complete");
  common_scripts\utility::func_A732("death", "crashing");
  if(isDefined(self)) {
    var_01 = anglesToForward(self.var_001D);
    playFX(common_scripts\utility::func_44F5("airstrike_death"), self.var_0116, var_01);
    thread func_1358(param_00);
  }

  thread func_2390();
}

func_2390() {
  self notify("airstrike_complete");
  lib_0527::func_7CEE(self);
  level.var_7019 = undefined;
  if(isDefined(self.var_620D)) {
    self.var_620D delete();
  }

  lib_0527::func_2DD3();
  waittillframeend;
  maps\mp\gametypes\_hostmigration::func_A782();
  if(isDefined(self)) {
    if(isDefined(self.var_7039)) {
      if(isDefined(self.var_7039.var_3981)) {
        self.var_7039.var_3981 delete();
      }

      self.var_7039 delete();
    }

    if(isDefined(self.var_7037)) {
      self.var_7037 delete();
    }

    self delete();
  }
}

func_1358(param_00) {
  var_01 = self;
  if(isDefined(param_00)) {
    lib_0380::func_6842("ks_plane_destruct_plr_explode", [param_00], self.var_0116);
    if(isDefined(param_00.var_7038)) {
      lib_0380::func_6850(param_00.var_7038, 0);
    }
  }

  var_02 = [];
  foreach(var_04 in level.var_744A) {
    if(!isDefined(param_00) || var_04 != param_00) {
      var_02[var_02.size] = var_04;
    }
  }

  if(isDefined(var_02) && var_02.size > 0) {
    lib_0380::func_6842("ks_plane_destruct_explode", var_02, self.var_0116);
  }
}

func_637A(param_00, param_01) {
  level endon("game_ended");
  param_01 endon("disconnect");
  param_01 endon("StopWaitForDeathorTimeout");
  param_00 common_scripts\utility::func_A70A("death", "crashing");
  param_01 notify("StopWaitForLeavingAirspace");
  param_01 notify("StopWaitForExitCommand");
  param_01 notify("StopWaitForChangeTeams");
  param_01 notify("StopWaitForFireBombsCommand");
  param_01 notify("StopWaitForRoundSwitch");
  param_01 notify("StopWaitForDisconnect");
  param_01 thread func_7CF2(param_00);
}

func_63A8(param_00, param_01) {
  level endon("game_ended");
  param_01 endon("disconnect");
  param_01 endon("StopWaitForLeavingAirspace");
  param_00 waittill("leaving");
  param_01 notify("StopWaitForDeathorTimeout");
  param_01 notify("StopWaitForExitCommand");
  param_01 notify("StopWaitForChangeTeams");
  param_01 notify("StopWaitForFireBombsCommand");
  param_01 notify("StopWaitForRoundSwitch");
  param_01 notify("StopWaitForDisconnect");
  param_01 thread func_7CF2(param_00);
}

func_637D(param_00, param_01) {
  level endon("game_ended");
  param_01 endon("StopWaitForDisconnect");
  param_01 waittill("disconnect");
  param_01 notify("StopWaitForLeavingAirspace");
  param_01 notify("StopWaitForDeathorTimeout");
  param_01 notify("StopWaitForExitCommand");
  param_01 notify("StopWaitForChangeTeams");
  param_01 notify("StopWaitForFireBombsCommand");
  param_01 notify("StopWaitForRoundSwitch");
  param_00 lib_0527::func_272D();
}

func_636E(param_00, param_01) {
  level endon("game_ended");
  param_01 endon("disconnect");
  param_01 endon("StopWaitForChangeTeams");
  param_01 common_scripts\utility::func_A70A("joined_team", "joined_spectators");
  param_01 notify("StopWaitForLeavingAirspace");
  param_01 notify("StopWaitForDeathorTimeout");
  param_01 notify("StopWaitForExitCommand");
  param_01 notify("StopWaitForDisconnect");
  param_01 notify("StopWaitForFireBombsCommand");
  param_01 notify("StopWaitForRoundSwitch");
  param_01 thread func_7CF2(param_00);
  param_00 thread lib_0527::func_272D();
}

func_63D9(param_00, param_01) {
  param_01 endon("disconnect");
  param_01 endon("StopWaitForRoundSwitch");
  level waittill("game_ended");
  param_01 notify("StopWaitForLeavingAirspace");
  param_01 notify("StopWaitForDeathorTimeout");
  param_01 notify("StopWaitForExitCommand");
  param_01 notify("StopWaitForDisconnect");
  param_01 notify("StopWaitForFireBombsCommand");
  param_01 notify("StopWaitForChangeTeams");
  param_01 setclientomnvar("ui_plane_gunner_phase", 0);
  if(isDefined(param_01)) {
    param_01 func_7CF2(param_00);
  }

  param_00 notify("player_exit");
}

func_7CF3(param_00, param_01) {
  param_01 endon("disconnect");
  level endon("game_ended");
  param_01 endon("StopWaitForExitCommand");
  param_01.var_701E = 0;
  if(!isbot(param_01)) {
    param_01 notifyonplayercommand("ExitButtonDown", "+activate");
    param_01 notifyonplayercommand("ExitButtonUp", "-activate");
  }

  param_01 notifyonplayercommand("ExitButtonDown", "+usereload");
  param_01 notifyonplayercommand("ExitButtonUp", "-usereload");
  for(;;) {
    param_01 waittill("ExitButtonDown");
    level thread func_92CB(param_00, param_01);
    level thread func_1F3A(param_01);
  }
}

func_92CB(param_00, param_01) {
  param_01 endon("StopWaitForExitCommand");
  param_01 endon("ExitButtonUp");
  param_01.var_701E = 1;
  wait(0.5);
  if(param_01.var_701E == 1) {
    param_01 notify("StopWaitForLeavingAirspace");
    param_01 notify("StopWaitForDeathorTimeout");
    param_01 notify("StopWaitForDisconnect");
    param_01 notify("StopWaitForChangeTeams");
    param_01 notify("StopWaitForFireBombsCommand");
    param_01 notify("StopWaitForRoundSwitch");
    param_01 thread func_7CF2(param_00);
    param_00 notify("player_exit");
    param_01 notify("StopWaitForExitCommand");
  }
}

func_1F3A(param_00) {
  param_00 endon("disconnect");
  param_00 endon("StopWaitForExitCommand");
  param_00 waittill("ExitButtonUp");
  param_00.var_701E = 0;
}

func_7CF2(param_00) {
  self endon("disconnect");
  level endon("game_ended");
  level.var_7019 = undefined;
  if(!isbot(self)) {
    self notifyonplayercommandremove("ExitButtonDown", "+activate");
    self notifyonplayercommandremove("ExitButtonUp", "-activate");
  }

  self notifyonplayercommandremove("ExitButtonDown", "+usereload");
  self notifyonplayercommandremove("ExitButtonUp", "-usereload");
  if(isDefined(param_00.var_7039)) {
    self method_80E0(param_00.var_7039);
  }

  self method_8323();
  var_01 = maps\mp\_utility::func_454A("plane_gunner");
  self takeweapon(var_01);
  self takeweapon("turretweapon_plane_gunner_turret_mp");
  self takeweapon("turretweapon_plane_gunner_turret_grenadier_mp");
  self unlink();
  if(maps\mp\_utility::func_581D()) {
    maps\mp\_utility::func_2414();
  }

  self setclientomnvar("ui_plane_gunner_phase", 0);
  if(maps\mp\gametypes\_hostmigration::func_A782() > 0) {
    self switchtoweapon(common_scripts\utility::func_4550());
  }

  func_7445(0);
}

func_7445(param_00) {
  self endon("disconnect");
  if(!isDefined(param_00)) {
    param_00 = 1;
  }

  maps\mp\_utility::func_3E8E(1);
  self setclientomnvar("fov_scale", 1);
  if(param_00) {
    wait(0.5);
    maps\mp\gametypes\_hostmigration::func_A782();
  }

  self thermalvisionfofoverlayoff();
  self notify("clearAerialKillstreakMarkers");
  self method_84B6();
  self method_81E3();
  maps\mp\_utility::func_3E8E(0);
  if(maps\mp\_utility::func_581D()) {
    maps\mp\_utility::func_2414();
  }

  if(getdvarint("311")) {
    maps\mp\_utility::func_8742(1);
  }

  self setshadows(1);
  lib_0526::func_7D04(0);
  lib_0526::func_A232(0);
  maps\mp\_utility::func_7447();
  thread func_4D17();
}

func_4D17() {
  if(!maps\mp\_utility::func_57A0(self)) {
    self waittill("spawned");
    wait 0.05;
    self setclientomnvar("ui_plane_gunner_phase", 0);
  }
}

func_73DA() {
  var_00 = maps\mp\killstreaks\_killstreaks::func_5345("plane_gunner", 1, 0, 0);
  if(var_00 != "success") {
    if(var_00 != "disconnect") {
      func_7445(0);
    }

    level.var_7019 = undefined;
    self notify("initRideKillstreak_complete", 0);
    return;
  }

  self notify("initRideKillstreak_complete", 1);
}

func_A68D(param_00) {
  self endon("airstrike_complete");
  level endon("game_ended");
  self endon("disconnect");
  wait(param_00);
  self setshadows(0);
}

func_9083(param_00, param_01, param_02, param_03) {
  var_04 = spawnturret("misc_turret", self gettagorigin(param_02), param_00, 0);
  var_04 setModel(param_01);
  var_04 setdefaultdroppitchyaw(0, 0);
  var_04 linkto(self, param_02, (0, 4, 4), (0, 0, 0));
  var_04.var_0117 = param_03;
  var_04.var_01A7 = param_03.var_01A7;
  var_04.var_00BC = 99999;
  var_04.var_00FB = 1000;
  var_04.var_006A = 0;
  var_04.var_94B9 = 0;
  var_04.var_94BB = 0;
  var_04 setCanDamage(0);
  var_04 setCanRadiusDamage(0);
  var_04 setmode("sentry_manual");
  var_04 method_80F9(param_03);
  var_04 method_80FB(0);
  var_04.var_2210 = self;
  var_04.var_7C29 = 0;
  var_04.var_3981 = spawn("script_model", var_04.var_0116);
  var_04.var_3981 setModel("usa_bomber_b17_ballturret_vista");
  var_04.var_3981 linkto(var_04, "TAG_ROLL", (-9, 0, 0), (0, 90, 0));
  var_04.var_3981 hidefromclient(param_03);
  return var_04;
}

func_703A(param_00, param_01) {
  param_00 endon("airstrike_complete");
  var_02 = anglesToForward(param_00.var_001D);
  var_03 = spawn("script_model", param_00.var_7039.var_0116);
  param_00.var_7039.var_5A2C = var_03;
  var_03 method_8449(param_00.var_7039, "tag_player");
}

func_9082() {
  var_00 = spawn("script_model", (0, 0, 0));
  var_00 setModel("tag_origin");
  var_00 linkto(self, "tag_bombardier", (0, 0, 0), (80, 180, 0));
  var_00.var_7C29 = 0;
  return var_00;
}

func_86FA(param_00, param_01, param_02, param_03) {
  param_01 unlink();
  param_01 method_81E3();
  var_04 = vectortoangles(level.var_5FEB - param_00.var_0116);
  var_05 = -60;
  var_06 = -60;
  if(param_02 == "machine_gun") {
    if(getdvarint("trailer_plane_gunner_height", -1) != -1) {
      param_01 playerlinkweaponviewtodelta(param_00.var_7039, "tag_player", 1, 85, 85, 0, 80, 0);
    } else {
      param_01 playerlinkweaponviewtodelta(param_00.var_7039, "tag_player", 1, 75, 75, -32, 80, 0);
    }

    param_01 method_80DF(param_00.var_7039, var_05, var_06);
    param_01 playerlinkedoffsetenable(0);
    param_01 playerlinkedoffsetdisable(1);
    if(getdvarint("5270", 1)) {
      param_01 setclientomnvar("ui_plane_gunner_phase", 1);
    }

    param_01 setclientomnvar("ui_plane_gunner_phase_end_time", gettime() + 30000);
  } else if(param_02 == "bomber") {
    if(param_01 maps\mp\_utility::func_581D() && isDefined(param_00.var_7039)) {
      param_01 method_80E0(param_00.var_7039);
    }

    param_01 maps\mp\_utility::func_3E8E(1);
    param_01 method_81E2(param_00.var_7037, "tag_origin");
    param_00.var_7037.var_0D95 = 7;
    param_01 notify("clearAerialKillstreakMarkers");
    if(getdvarint("5270", 1)) {
      param_01 setclientomnvar("ui_plane_gunner_phase", 2);
    }

    param_01 setclientomnvar("ui_plane_gunner_phase_end_time", gettime() + 13200);
    param_01 setclientomnvar("ui_plane_gunner_ammo", param_00.var_7037.var_0D95);
  }

  param_00.var_9FA4 = param_02;
}

func_3C19(param_00, param_01) {
  param_01 endon("disconnect");
  level endon("game_ended");
  param_01 endon("StopWaitForFireBombsCommand");
  param_01 notifyonplayercommand("FirePlaneGunnerBombsButtonDown", "+attack");
  param_01 notifyonplayercommand("FirePlaneGunnerBombsButtonUp", "-attack");
  param_00.var_18C8 = spawn("script_model", (0, 0, 0));
  param_00.var_18C8 setModel("tag_origin");
  param_00.var_18C8 linkto(param_00, "tag_bombardier", (0, 0, 0), (0, 0, 0));
  for(;;) {
    param_01 waittill("FirePlaneGunnerBombsButtonDown");
    if(param_00.var_9FA4 == "bomber") {
      if(self.var_701F || !param_00.var_7037.var_7C29) {
        thread func_92CD(param_00, param_01);
        thread func_1F3B(param_00, param_01);
      }
    }

    thread func_92CE(param_01);
    thread func_1F3C(param_01);
  }
}

func_92CD(param_00, param_01) {
  param_01 endon("StopWaitForFireBombsCommand");
  param_01 endon("FirePlaneGunnerBombsButtonUp");
  param_01 endon("FirePlaneGunnerBombsButtonUpFake");
  self.var_7020 = 1;
  if(self.var_7020 == 1) {
    for(;;) {
      if(!param_00.var_7037.var_7C29 && param_00.var_7037.var_0D95 > 0) {
        param_00.var_7037.var_0D95--;
        param_01 setclientomnvar("ui_plane_gunner_ammo", param_00.var_7037.var_0D95);
        var_02 = param_00.var_7037.var_0116;
        for(var_03 = -3; var_03 < 4; var_03++) {
          var_04 = (var_02[0] + 256 * var_03 * cos(param_00.var_001D[1] + 90), var_02[1] + 256 * var_03 * sin(param_00.var_001D[1] + 90), var_02[2]);
          param_00 thread func_3C18(var_04, param_01, 256, 1, var_03 == 0, var_03 + 3);
        }

        thread func_A694(param_00, param_01);
        continue;
      }

      if(param_00.var_7037.var_0D95 <= 0) {
        param_00 thread func_18E8();
        break;
      }

      wait 0.05;
    }
  }
}

func_18E8() {
  wait(0.75);
  self notify("planeBomberOutOfAmmo");
}

func_A694(param_00, param_01) {
  param_01 endon("disconnect");
  level endon("game_ended");
  param_01 endon("StopWaitForFireBombsCommand");
  param_00.var_7037.var_7C29 = 1;
  param_01 setclientomnvar("ui_plane_gunner_reloading", 1);
  wait(0.45);
  param_01 setclientomnvar("ui_plane_gunner_reloading", 0);
  param_00.var_7037.var_7C29 = 0;
}

func_1F3B(param_00, param_01) {
  self endon("disconnect");
  param_01 common_scripts\utility::func_A70A("FirePlaneGunnerBombsButtonUp", "FirePlaneGunnerBombsButtonUpFake");
  self.var_7020 = 0;
}

func_92CE(param_00) {
  param_00 endon("StopWaitForFireBombsCommand");
  param_00 endon("FirePlaneGunnerBombsButtonUp");
  self.var_701F = 1;
}

func_1F3C(param_00) {
  self endon("disconnect");
  param_00 common_scripts\utility::func_A70A("FirePlaneGunnerBombsButtonUp");
  self.var_701F = 0;
}

func_3C18(param_00, param_01, param_02, param_03, param_04, param_05) {
  param_01 endon("disconnect");
  level endon("game_ended");
  param_01 endon("StopWaitForFireBombsCommand");
  if(!isDefined(param_01) || param_01 maps\mp\_utility::func_56D7()) {
    lib_0527::func_272D();
    return;
  }

  var_06 = (0, randomint(360), 0);
  var_07 = param_00 + anglesToForward(var_06) * param_02 / 2 + randomfloat(param_02 / 2);
  var_08 = bulletTrace(var_07, var_07 + (0, 0, -10000), 0, self);
  var_09 = var_08["position"];
  var_0A = distance(param_00, var_09);
  if(var_0A > 10000) {
    return;
  }

  wait(0.85 * var_0A / 4000);
  if(!isDefined(param_01) || param_01 maps\mp\_utility::func_56D7()) {
    lib_0527::func_272D();
    return;
  }

  if(param_03) {}

  if(param_04) {
    level thread maps\mp\gametypes\_shellshock::func_938E(var_09);
  }

  param_01 entityradiusdamage(var_09, 1000, 500, 75, param_01, "MOD_EXPLOSIVE", "plane_gunner_bomber_projectile_mp");
}

func_316F(param_00, param_01) {
  param_01 endon("disconnect");
  param_01 endon("player_exit");
  param_00 endon("death");
  param_01 method_84B4();
  param_01 method_84B7(10, 7000, 20, 20);
}

func_6B69(param_00, param_01, param_02, param_03) {
  if(isDefined(level.var_7019) && isDefined(level.var_7019.var_0117)) {
    if(param_02 == "MOD_PROJECTILE") {
      earthquake(1.25, 0.75, level.var_7019.var_0116, 400, level.var_7019.var_0117);
    } else {
      earthquake(0.15, 0.5, level.var_7019.var_0116, 400, level.var_7019.var_0117);
    }
  }

  return lib_0527::func_6B9C(param_00, param_01, param_02, param_03);
}