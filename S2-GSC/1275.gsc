/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: 1275.gsc
*********************************************/

func_28AD(param_00) {
  if(!lib_04FF::func_694B()) {
    level.var_611["objective_flag_glow"] = loadfx("vfx/map/mp_raid_bulge/raid_bulge_fuelcan_glow");
    level.var_611["objective_flag_trail"] = loadfx("vfx/map/mp_raid_bulge/raid_bulge_fuelcan_trail");
    level.var_611["objective_resupply_death"] = loadfx("vfx/test/raid/objective_resupply_death");
    setdvarifuninitialized("raid_ctf_flag_throw_type", 0);
  }

  lib_04FF::func_6934(self);
  self.var_6940 = ::func_28AC;
  level.var_3CBF["allies"] = maps\mp\gametypes\_teams::func_46CF("allies");
  level.var_2013["allies"] = maps\mp\gametypes\_teams::func_46CB("allies");
  level.var_3CBF["axis"] = maps\mp\gametypes\_teams::func_46CF("axis");
  level.var_2013["axis"] = maps\mp\gametypes\_teams::func_46CB("axis");
  var_01 = [0.1, 0.3, 0.5, 1, 2, 3, 5, 7.5, 10, 12.5, 15, 20, 25, 60];
  lib_04FF::func_6963("droppedFlagPickupTime", lib_0501::func_4647("ctf_droppedFlagPickupTime"), var_01);
  lib_04FF::func_6963("flagCatchPickupTime", 0.25, var_01);
  lib_04FF::func_6963("flagPickupTime", lib_0501::func_4647("ctf_flagPickupTime"), var_01);
  lib_04FF::func_6963("flagCaptureTime", lib_0501::func_4647("ctf_flagCaptureTime"), var_01);
  lib_04FF::func_6963("flagReturnTime", lib_0501::func_4647("ctf_flagReturnTime"), var_01);
  lib_04FF::func_6963("autoReturnTime", lib_0501::func_4647("ctf_autoReturnTime"), var_01);
  lib_04FF::func_6965("pingFlagCarrier", lib_0501::func_4648("ctf_pingFlagCarrier"));
  lib_04FF::func_6965("objectiveScoreGoal", lib_0501::func_4648("ctf_objectiveScoreGoal"), [1, 2, 3, 4, 5, 6, 7, 8]);
  lib_04FF::func_6966("flagPickupWeapon", "m712carry_mp");
  lib_04FF::func_6966("flagGrenadeWeapon", "raid_carryflag_mp");
  lib_04FF::func_6965("flagGrenadeThrowEnabled", 1);
  lib_04FF::func_6966("flagAttachModel", "ger_jerry_can_01_gas_dirty_flag");
  lib_04FF::func_6966("flagAttachModelTag", "tag_weapon_left");
  lib_04FF::func_6963("flagGriefReturnTime", 45, var_01);
  lib_04FF::func_6963("flagMaxSettleTime", 5, var_01);
  lib_04FF::func_6963("flagCarrierOOBTime", 0.5, var_01);
  lib_04FF::func_6963("flagTriggerRadius", 48);
  lib_04FF::func_6963("flagTriggerHeight", 20);
  lib_04FF::func_6966("flagDeliverStartSound", "");
  lib_04FF::func_6966("flagDeliverStopSound", "");
  lib_04FF::func_6966("flagDeliverStopSoundFade", 0.1);
  lib_04FF::func_6966("flagPickupStartSound", "");
  lib_04FF::func_6966("flagPickupStopSound", "");
  lib_04FF::func_6966("flagPickupStopSoundFade", 0.1);
  lib_04FF::func_6962("flagTriggerHasUI", 1);
  lib_04FF::func_6962("objModelDissappearsOnPickup", 0);
  lib_04FF::func_6962("highlightDeliverZoneModel", 0);
  var_02 = [0.5, 0.85, 1, 1.25, 1.5, 2];
  lib_04FF::func_6963("flagThrowForce", lib_0501::func_4647("ctf_throwDistance"), var_02);
  lib_04FF::func_6963("flagThrowMovementForce", lib_0501::func_4647("ctf_throwDistance"), var_02);
  var_03 = [6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17];
  lib_04FF::func_6965("useSourceTextIndex", 14, var_03);
  lib_04FF::func_6965("useDestTextIndex", 15, var_03);
  level.var_695E[level.var_695E.size] = ::func_28AE;
  self.var_3CC2 = [];
  self.var_3CB8 = [];
  self.var_7C17 = [];
  self.var_2933 = 0;
  setomnvar("ui_war_ctf_capture_count", 0);
  thread func_28AF();
  thread func_28B0();
  var_04 = lib_04FF::func_45D0("flagPickupWeapon");
  lib_0502::func_791A(var_04);
  lib_0505::func_9AE(var_04);
}

func_28AC() {
  var_00 = lib_0502::func_207C("relayDeliveryZone");
  return var_00[0];
}

func_28B1() {
  var_00 = 0;
  foreach(var_02 in self.var_7C17) {
    if(!var_02.var_10F5) {
      var_00 = 1;
      break;
    }
  }

  foreach(var_05 in self.var_3CB8) {
    var_06 = var_05.var_A223;
    if(var_00) {
      var_06 lib_04FF::func_8611();
      var_06 maps\mp\gametypes\_gameobjects::func_8A60("any");
      continue;
    }

    var_06 lib_04FF::func_860F();
    var_06 maps\mp\gametypes\_gameobjects::func_8A60("none");
  }
}

func_28AE(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09) {
  var_0A = self;
  if(isDefined(param_01.var_2016)) {
    param_01 thread maps\mp\_events::func_5A84(param_04);
    return;
  }

  if(isDefined(var_0A.var_2016)) {
    param_01 thread maps\mp\_events::func_5A46(param_09);
  }
}

func_28AF() {
  lib_04FF::func_6983(self.var_695A);
  func_28B1();
  thread func_6AD9();
  for(;;) {
    self waittill("flag_captured");
    var_00 = clamp(self.var_2933 / lib_04FF::func_45D0("objectiveScoreGoal"), 0, 1);
    foreach(var_02 in self.var_3CB8) {
      var_03 = var_02.var_A223.var_A23F;
      var_04 = var_00 * var_03;
      var_02.var_A223 lib_04FF::func_8615(var_04);
    }

    if(self.var_2933 >= lib_04FF::func_45D0("objectiveScoreGoal")) {
      lib_04FF::func_6935(self.var_695A);
      return;
    }
  }
}

func_28B0() {
  level endon("game_ended");
  level endon(lib_04FF::func_6937(self.var_695A));
  for(;;) {
    if(func_28AB()) {
      lib_04FF::func_6981(self.var_695A);
    }

    wait 0.05;
  }
}

func_28AB() {
  foreach(var_01 in self.var_7C17) {
    if(var_01.var_A560 != "none") {
      return 1;
    }
  }

  foreach(var_04 in self.var_3CC2) {
    if(isDefined(var_04.var_A223) && isDefined(var_04.var_A223.var_230E)) {
      return 1;
    }
  }

  return 0;
}

func_6AD9() {
  lib_04FF::func_6982(self.var_695A);
  level.var_695E = common_scripts\utility::func_F93(level.var_695E, ::func_28AE);
  foreach(var_01 in level.var_744A) {
    if(isDefined(var_01.var_2016)) {
      var_01.var_2016 func_7E2F();
    }
  }

  foreach(var_04 in self.var_7C17) {
    if(!var_04.var_10F5) {
      var_04 maps\mp\gametypes\_gameobjects::func_7E30();
    }

    var_04.var_9D65 common_scripts\utility::func_9D9F();
  }

  foreach(var_07 in self.var_3CC2) {
    var_07 common_scripts\utility::func_9D9F();
  }

  foreach(var_0A in self.var_3CB8) {
    var_0A common_scripts\utility::func_9D9F();
  }

  setomnvar("ui_war_ctf_capture_count", -1);
}

func_0991(param_00, param_01, param_02, param_03, param_04, param_05) {
  if(!isDefined(self.var_885B)) {
    self.var_885B = 1;
  }

  while(self.var_885B != param_01.var_81E1) {
    waittillframeend;
  }

  self.var_885B++;
  param_00 lib_04FF::func_990(param_02, undefined, param_03, param_05, param_04, 0, 1, 0, 1, 1);
}

func_528D(param_00) {
  while(!lib_04FA::func_50AC()) {
    wait 0.05;
  }

  lib_04FF::func_8615(param_00);
}

func_289E(param_00) {
  lib_04FF::func_6983(self.var_695A);
  self.var_3CB8[self.var_3CB8.size] = param_00;
  var_01 = lib_04FF::func_45CE(param_00);
  var_02 = [];
  var_03 = maps\mp\gametypes\_gameobjects::func_2837(game["attackers"], param_00, var_02, var_01, 0, 1);
  lib_04FF::func_6942(var_03);
  param_00.var_A223 = var_03;
  var_03 maps\mp\gametypes\_gameobjects::func_C30("friendly");
  var_03 maps\mp\gametypes\_gameobjects::func_8A60("none");
  var_03 maps\mp\gametypes\_gameobjects::func_8A59(&"RAIDS_RESUPPLY_USING_DEST");
  var_04 = lib_04FF::func_45D0("flagCaptureTime");
  var_03 maps\mp\gametypes\_gameobjects::func_8A5A(var_04);
  var_03 maps\mp\gametypes\_gameobjects::func_86B5(self.var_7C17);
  var_03.var_6BBF = ::func_6AD3;
  var_03.var_6ABC = ::func_6AE9;
  var_03.var_6AFA = ::func_6AEA;
  var_03.var_6BB8 = ::func_6AEB;
  var_03.var_6BB9 = ::func_6AEC;
  var_03.var_6BBE = ::func_1198;
  var_03.var_1F84 = ::func_1F7C;
  var_03.var_A414 = 1;
  var_03 maps\mp\gametypes\_gameobjects::func_6B52(1);
  var_05 = lib_04FF::func_45D0("objectiveScoreGoal");
  var_06 = 28;
  if(lib_04FF::func_45D0("highlightDeliverZoneModel")) {
    var_06 = 118;
  }

  var_03 lib_04FF::func_990(var_03.var_28D4 + var_03.var_6A1D, undefined, undefined, var_03.var_A23F, var_06, 0, 1, 0, 1, 0, undefined, undefined, undefined, undefined, var_05);
  var_03 lib_04FF::func_860A(var_06);
  var_03.var_A23E = lib_04FF::func_45D0("useDestTextIndex");
  lib_04FF::func_6982(self.var_695A);
  var_03 lib_04FF::func_7CCA();
  var_03 maps\mp\gametypes\_gameobjects::func_2F93();
  var_03 maps\mp\gametypes\_gameobjects::deleteuseobjectobjectives();
  waittillframeend;
  var_03 maps\mp\gametypes\_gameobjects::func_2D58();
  param_00 delete();
}

func_28B5(param_00) {
  param_00 common_scripts\utility::func_3799("gameobject_created");
  lib_04FF::func_6983(self.var_695A);
  self.var_3CC2[self.var_3CC2.size] = param_00;
  var_01 = lib_04FF::func_45CE(param_00);
  var_02 = [];
  var_03 = maps\mp\gametypes\_gameobjects::func_2837(game["attackers"], param_00, var_02, var_01, 0, 1);
  lib_04FF::func_6942(var_03);
  param_00.var_A223 = var_03;
  param_00 common_scripts\utility::func_379A("gameobject_created");
  var_04 = lib_04FF::func_45D0("flagPickupTime");
  var_03 maps\mp\gametypes\_gameobjects::func_8A5A(var_04);
  var_03 maps\mp\gametypes\_gameobjects::func_8A59(&"RAIDS_RESUPPLY_USING_SOURCE_PICKUP");
  var_03 maps\mp\gametypes\_gameobjects::func_8A60("any");
  var_03 maps\mp\gametypes\_gameobjects::func_C30("friendly");
  var_03.var_1F84 = ::func_1F85;
  var_03.var_6BBF = ::func_6B68;
  var_03.var_6ABC = ::func_6B66;
  var_03.var_6AFA = ::func_6B67;
  var_03.var_6BBE = ::func_1198;
  var_03.var_A23E = lib_04FF::func_45D0("useSourceTextIndex");
  var_03.var_A414 = 1;
  var_03 maps\mp\gametypes\_gameobjects::func_6B52(1);
  var_05 = lib_0502::func_4518("grab_defend", param_00.var_81E1);
  if(lib_04FF::func_45D0("flagTriggerHasUI")) {
    thread func_0991(var_03, param_00, var_03.var_28D4 + var_03.var_6A1D, undefined, var_05, var_03.var_A23F);
  }

  var_03 lib_04FF::func_860A(var_05, param_00.var_81E1);
  var_03.var_607D = param_00.var_8140;
  if(isDefined(var_03.var_607D)) {
    var_03 thread func_528D(var_03.var_A23F);
  }

  lib_04FF::func_6982(self.var_695A);
  var_03 lib_04FF::func_7CCA();
  var_03 maps\mp\gametypes\_gameobjects::func_2F93();
  var_03 maps\mp\gametypes\_gameobjects::deleteuseobjectobjectives();
  waittillframeend;
  var_03 maps\mp\gametypes\_gameobjects::func_2D58();
  param_00 delete();
}

func_6B66(param_00) {
  var_01 = lib_0502::func_4518("taking_defend", self.var_9D65.var_81E1);
  lib_04FF::func_860A(var_01, self.var_9D65.var_81E1);
  lib_04FF::func_8613(var_01);
  var_02 = self.var_79AD lib_04FF::func_45D0("flagPickupStartSound");
  if(var_02 != "") {
    self.var_A238 = lib_04F3::func_79CB(var_02, self.var_9D65.var_116);
  }

  param_00.var_230C = self;
  lib_04FF::func_8610(param_00);
}

func_6B67(param_00, param_01, param_02) {
  if(!common_scripts\utility::func_562E(param_02)) {
    func_28B4();
  } else {
    lib_04FF::func_8616();
  }

  if(isDefined(self.var_A238) && param_02 == 0) {
    var_03 = self.var_79AD lib_04FF::func_45D0("flagPickupStopSoundFade");
    lib_04F3::func_79D0(self.var_A238, var_03);
  }

  var_04 = self.var_79AD lib_04FF::func_45D0("flagPickupStopSound");
  if(var_04 != "" && param_02 == 0) {
    self.var_A238 = lib_04F3::func_79CB(var_04, self.var_9D65.var_116);
  }

  if(isDefined(param_01)) {
    param_01.var_230C = undefined;
  }

  lib_04FF::func_8611();
}

func_28B4() {
  var_00 = lib_0502::func_4518("grab_defend", self.var_9D65.var_81E1);
  lib_04FF::func_860A(var_00, self.var_9D65.var_81E1);
  if(isDefined(self.var_607D) && self.var_607D > 0 && isDefined(self.var_2016)) {
    var_01 = self.var_2016.var_2D5A / self.var_607D;
    var_02 = self.var_A23F - var_01 * self.var_A23F;
    lib_04FF::func_8615(var_02, var_00);
    return;
  }

  lib_04FF::func_8616(var_00);
}

func_6B68(param_00) {
  var_01 = self.var_2016;
  if(isDefined(var_01)) {
    func_28B2();
    var_01 func_28B8();
    var_01 maps\mp\gametypes\_gameobjects::func_86F9(param_00);
  }
}

func_28B2() {
  maps\mp\gametypes\_gameobjects::func_2F93();
  self.var_9D65 notify("flag_pickup", self.var_230E);
}

func_28B3() {
  if(isDefined(self.var_607D) && self.var_607D > 0 && isDefined(self.var_2016) && self.var_2016.var_2D5A >= self.var_607D) {
    self.var_9D65.var_2566 = 1;
    lib_04FF::func_860F(1);
    return;
  }

  maps\mp\gametypes\_gameobjects::func_365D();
  self.var_9D65 notify("flag_return");
  func_28B4();
  if(self.var_79AD lib_04FF::func_45D0("flagTriggerHasUI")) {
    lib_04FF::func_8618(self.var_9D65, undefined, lib_04FF::func_45CE(self.var_9D65));
  }
}

func_28B6(param_00) {
  param_00 method_805C();
  lib_04FF::func_6983(self.var_695A);
  param_00 method_805B();
  var_01 = lib_04FF::func_45D0("flagTriggerRadius");
  var_02 = lib_04FF::func_45D0("flagTriggerHeight");
  var_03 = spawn("trigger_radius", param_00.var_116, 0, var_01, var_02);
  var_03 enablelinkto();
  var_03.var_66F0 = 1;
  var_04 = [param_00];
  var_05 = maps\mp\gametypes\_gameobjects::func_27D6(game["attackers"], var_03, var_04, (0, 0, 0), 0, 1);
  lib_04FF::func_6942(var_05);
  var_05.var_695F = 1;
  var_05.var_7D25 = 1;
  var_05.var_10F5 = 1;
  var_05.var_C2C = 1;
  var_05.var_A414 = 1;
  var_05 maps\mp\gametypes\_gameobjects::func_6B52(1);
  var_06 = param_00.var_982E;
  var_06 common_scripts\utility::func_379C("gameobject_created");
  var_03.var_81E1 = var_06.var_81E1;
  var_03.var_2016 = var_05;
  self.var_7C17[self.var_7C17.size] = var_05;
  var_05.var_698A = var_06.var_A223.var_698A;
  var_05.var_698B = var_06.var_A223.var_698B;
  var_05.var_698C = var_06.var_A223.var_698C;
  var_06.var_A223.var_2016 = var_05;
  var_05.var_501C = var_06.var_A223;
  var_05 maps\mp\gametypes\_gameobjects::func_873F("friendly", &"RAIDS_RESUPPLY_USING_SOURCE_PICKUP");
  var_05 maps\mp\gametypes\_gameobjects::func_873F("enemy", &"MP_RETURNING_FLAG");
  var_05 maps\mp\gametypes\_gameobjects::func_C1D("friendly");
  var_07 = lib_04FF::func_45D0("flagPickupTime");
  var_05 maps\mp\gametypes\_gameobjects::func_8A5A(var_07);
  var_05.var_9D65 = var_03;
  var_05.var_6990 = lib_04FF::func_45D0("pingFlagCarrier");
  var_05.var_698F = 0;
  var_05.var_A23E = lib_04FF::func_45D0("useSourceTextIndex");
  var_05.var_6B62 = ::func_6AD6;
  var_05.var_6AEF = ::func_6AD4;
  var_05.var_866E = ::func_6ADA;
  var_05.var_6B93 = ::func_6AD8;
  var_05.var_6ABC = ::func_6AD2;
  var_05.var_6AFA = ::func_6AD5;
  var_05.var_201C = lib_04FF::func_45D0("flagPickupWeapon");
  if(var_05.var_201C == "noWeapSwitch") {
    var_05.var_201C = undefined;
  }

  var_05.var_59D9 = ::func_28A7;
  var_05.var_201D = ::func_A900;
  var_05.var_6BBE = ::func_6B92;
  var_05.var_1F84 = ::func_1F87;
  var_05.var_1F6A = ::func_1F6B;
  var_05.var_C33 = 1;
  var_05.var_2D5A = 0;
  var_05.var_501F = spawn("script_origin", var_04[0].var_116);
  var_05.var_501F setModel("tag_origin");
  var_05.var_4B80 = [];
  var_05.var_501F thread func_939E(var_04[0]);
  var_05 thread func_28B9();
  var_05 func_28B7();
  lib_04FF::func_6982(self.var_695A);
  var_05 lib_04FF::func_7CCA();
  var_05 maps\mp\gametypes\_gameobjects::func_2F93();
  wait 0.05;
  waittillframeend;
  var_05.var_698A = undefined;
  var_05.var_698B = undefined;
  var_05.var_698C = undefined;
  var_05 maps\mp\gametypes\_gameobjects::func_2D2F();
}

func_939E(param_00) {
  param_00 endon("death");
  wait(1);
  for(;;) {
    if(isDefined(param_00)) {
      self.var_116 = param_00.var_116;
    } else {
      return;
    }

    wait 0.05;
  }
}

func_1F6B(param_00, param_01) {
  var_02 = param_01[0];
  var_03 = self.var_A582[0];
  var_04 = [];
  var_05 = [-1, 0, 1];
  foreach(var_07 in var_05) {
    var_04[var_04.size] = var_03 method_8549(0, 0, var_07);
  }

  var_09 = param_00.var_116 - self.var_9D65.var_116;
  var_0A = common_scripts\utility::func_3D5D(var_09);
  var_0B = vectornormalize(var_0A);
  var_0C = var_0B * 5;
  foreach(var_0E in var_04) {
    var_0F = param_00.var_116 + (0, 0, 10);
    var_10 = var_0E + var_0C;
    var_11 = bulletTrace(var_0F, var_10, 0, var_02, 0, 0, 0, 0, 1, 0, 0);
    if(var_11["fraction"] == 1) {
      return 1;
    }
  }

  return 0;
}

func_28B8() {
  maps\mp\gametypes\_gameobjects::func_365D();
  self.var_9D65.var_116 = self.var_A582[0].var_116;
  self.var_9D65 linkto(self.var_A582[0]);
  maps\mp\gametypes\_gameobjects::func_8A60("any");
  thread func_28A4();
}

func_28B7() {
  if(self.var_9D65 islinked()) {
    self.var_9D65 unlink();
  }

  maps\mp\gametypes\_gameobjects::func_2F93();
  maps\mp\gametypes\_gameobjects::func_8A60("none");
}

func_28B9() {
  level endon("game_ended");
  self endon("death");
  for(;;) {
    self waittill("reset");
    waittillframeend;
    func_28B7();
    if(!lib_04FF::func_5761(self.var_695A)) {
      self.var_501C func_28B3();
      self.var_79AD func_28B1();
    }
  }
}

func_1F85(param_00) {
  var_01 = self.var_2016;
  if(!isDefined(var_01) || isDefined(var_01.var_2006)) {
    return 0;
  }

  if(!var_01.var_10F5) {
    return 0;
  }

  return func_1F87(param_00);
}

func_1F87(param_00) {
  if(param_00 islinked()) {
    return 0;
  }

  if(param_00 isusingturret()) {
    return 0;
  }

  if(isDefined(param_00.var_99AC)) {
    return 0;
  }

  if(isDefined(param_00.var_2016)) {
    return 0;
  }

  if(isDefined(param_00.var_2310)) {
    return 0;
  }

  if(isDefined(param_00.var_230C) && param_00.var_230C != self) {
    return 0;
  }

  if(isDefined(param_00.var_6735) && param_00.var_6735 > gettime()) {
    return 0;
  }

  return 1;
}

func_6B92() {
  self.var_A22B = 0;
  if(self.var_230F != "none") {
    var_00 = self.var_689F[self.var_230F];
    var_01 = self.var_689F[maps\mp\_utility::func_45DE(self.var_230F)];
    var_02 = var_00 && var_01;
    if(var_00 && !var_01) {
      self.var_A22B = 1;
    }
  } else {
    var_02 = 0;
  }

  self.var_915C = var_02;
  func_28A9();
}

func_28A7(param_00) {
  return param_00.var_12C["team"] == maps\mp\gametypes\_gameobjects::func_45F7();
}

func_A900() {
  thread func_5FD8();
  thread func_5FDE();
}

func_5FDE() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("death");
  self endon("drop_object");
  for(;;) {
    self waittill("grenade_fire", var_00, var_01);
    if(!func_5829(var_01)) {
      continue;
    }

    self.var_6735 = gettime() + 500;
    self.var_A871 = 1;
    switch (getdvarint("raid_ctf_flag_throw_type", 0)) {
      case 0:
        thread func_99AF(self, var_00);
        var_00 method_81D6();
        break;

      case 1:
        level thread func_2D38(var_00);
        level thread func_5C2A(self.var_2016, var_00);
        break;
    }

    break;
  }
}

func_99AF(param_00, param_01) {
  var_02 = param_00.var_2016;
  var_03 = -8;
  var_04 = var_02.var_79AD lib_04FF::func_45D0("flagThrowForce");
  var_05 = 37000 * var_04;
  var_06 = param_00 getangles();
  var_06 = var_06 + (var_03, 0, 0);
  var_06 = (clamp(var_06[0], -85, 85), var_06[1], var_06[2]);
  var_07 = anglesToForward(var_06);
  var_08 = param_00 getvelocity();
  var_09 = vectornormalize((var_07[0], var_07[1], 0));
  var_0A = vectornormalize((var_08[0], var_08[1], 0));
  var_0B = 0;
  if(vectordot(var_09, var_0A) >= 0.42 && length(var_08) > 120) {
    var_0C = var_02.var_79AD lib_04FF::func_45D0("flagThrowMovementForce");
    var_0B = 6000 * var_0C;
  }

  var_02.var_A879 = 1;
  var_02 thread func_6ADA(1);
  var_02.var_A582[0].var_116 = param_01.var_116;
  var_02 func_3CC0(var_07 * var_05 + var_0B, param_00);
}

func_2D38(param_00) {
  level endon("game_ended");
  param_00 waittill("missile_stuck", var_01);
  waittillframeend;
  if(isDefined(param_00)) {
    param_00 method_81D6();
  }
}

func_5C2A(param_00, param_01) {
  param_00 endon("picked_up");
  param_00 endon("reset");
  param_00 endon("death");
  param_01 endon("death");
  param_00.var_A879 = 1;
  param_00.var_5DB5 = param_01;
  param_00 thread func_6ADA(1);
  param_00.var_A582[0] linkto(param_01, "tag_origin", (0, 0, 0), (0, 0, 0));
  var_02 = param_00.var_A582[0] method_80B1();
  param_01 waittill("missile_stuck", var_03);
  param_00.var_A582[0] unlink();
  param_00.var_A582[0] method_80B0(var_02);
  param_00.var_A582[0].var_116 = param_00.var_A582[0].var_116 + (0, 0, 10);
  param_00 func_3CC0((0, 0, 8000));
}

func_5FD8() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("death");
  self endon("drop_object");
  for(;;) {
    wait(1);
    self waittill("weapon_change", var_00);
    if(isDefined(var_00) && func_5829(var_00) || var_00 == self.var_2016.var_79AD lib_04FF::func_45D0("flagPickupWeapon")) {
      continue;
    }

    if(isDefined(self.var_2016)) {
      self.var_6735 = gettime() + 2000;
      self.var_2016 thread func_6ADA(0);
      return;
    }
  }
}

func_7E2F(param_00) {
  if(isDefined(param_00)) {
    lib_04FF::func_6981(self.var_695A, "returned", 0, 1, param_00);
  }

  var_01 = self.var_2006;
  if(isDefined(var_01)) {
    var_01 thread func_7DE9(self.var_79AD);
    var_01 func_2E40();
  }

  var_02 = self.var_A582[0];
  if(var_02 islinked()) {
    var_02 unlink();
    if(isDefined(self.var_5DB5)) {
      self.var_5DB5 method_81D6();
    }
  }

  if(var_02 method_8524()) {
    var_02 method_84E0();
  }

  maps\mp\gametypes\_gameobjects::func_7E30();
}

func_1148(param_00) {
  self endon("detachFlag");
  self endon("disconnect");
  self luinotifyevent(&"ctf_is_holding_flag", 1, 1);
  wait(0.2);
  self.var_2013 = param_00.var_79AD lib_04FF::func_45D0("flagAttachModel");
  self.carryflagtag = param_00.var_79AD lib_04FF::func_45D0("flagAttachModelTag");
  if(!isDefined(self.carryflagtag)) {
    self.carryflagtag = "tag_weapon_left";
  }

  if(self.var_2013 != "hus_intel_case_01") {
    self attach(self.var_2013, self.carryflagtag, 1);
  } else {
    self attach("tag_origin", self.carryflagtag, 1);
  }

  lib_04F4::func_8BEA(self);
}

func_2E40() {
  self notify("detachFlag");
  var_00 = 0;
  if(common_scripts\utility::func_562E(self.var_A871)) {
    var_00 = 1;
  }

  self luinotifyevent(&"ctf_is_holding_flag", 2, 0, var_00);
  if(isDefined(self.var_2013)) {
    if(self.var_2013 != "hus_intel_case_01") {
      var_01 = self method_802E(self.var_2013, self.carryflagtag, !function_02BD());
    } else {
      var_01 = self method_802E("tag_origin", self.carryflagtag, !function_02BD());
    }
  }

  self.var_A871 = 0;
  self.var_2013 = undefined;
  lib_0502::replacehintstringclient(&"RAIDS_USE_CONSTRUCT", undefined);
  lib_04F4::func_7D4F(self);
}

func_6AD6(param_00) {
  if(lib_04FF::func_5761(self.var_695A)) {
    return;
  }

  self notify("picked_up");
  func_3CBC();
  self.var_A879 = 0;
  var_01 = param_00.var_12C["team"];
  var_02 = maps\mp\_utility::func_45DE(var_01);
  if(var_01 != maps\mp\gametypes\_gameobjects::func_45F7()) {
    thread func_7E2F(self.var_9D65.var_81E1);
    lib_04F3::func_79CE(game["music"]["flag_returned_pos"], var_01);
    lib_04F3::func_79CE(game["music"]["flag_returned_neg"], var_02);
    param_00 thread maps\mp\_events::func_3CC3();
    return;
  }

  self.var_10F5 = 0;
  self.var_79AD func_28B1();
  var_03 = self.var_A582[0] getlinkedparent();
  if(isDefined(var_03)) {
    self.var_A582[0] unlink();
  }

  self.var_A582[0] method_84E0();
  self.var_A582[0] maps\mp\_movers::func_67F9();
  self.var_A582[0] method_805B();
  self.var_A582[0] method_8511();
  self.var_A582[0].var_116 = self.var_A582[0].var_116 + (0, 0, -10000);
  self.var_9D65 maps\mp\_movers::func_93CE();
  param_00 thread func_1148(self);
  if(self.var_79AD lib_04FF::func_45D0("flagPickupWeapon") != "noWeapSwitch") {
    param_00 common_scripts\utility::func_601();
  }

  param_00 lib_0502::replacehintstringclient(&"RAIDS_USE_CONSTRUCT", &"RAIDS_TRIPWIRE_BLANK");
  maps\mp\gametypes\_gameobjects::func_8A60("any");
  maps\mp\gametypes\_gameobjects::func_8740("friendly", self.var_79AD lib_04FF::func_45D0("flagPickupTime"));
  maps\mp\gametypes\_gameobjects::func_8740("enemy", self.var_79AD lib_04FF::func_45D0("flagPickupTime"));
  func_28A9();
  lib_04FF::func_6981(self.var_695A, "progress", 0, 1, self.var_9D65.var_81E1);
  if(param_00 maps\mp\_utility::func_649("specialty_improvedobjectives")) {
    self.var_6993 = 7.5;
  } else {
    self.var_6993 = 5;
  }

  if(isDefined(self.var_201C)) {
    param_00 givemaxammo(self.var_201C);
  }

  param_00 thread func_941D(self.var_79AD);
  thread func_28A8();
  thread func_28A2();
  lib_04F3::func_79CD("mp_ctf_flag_pickup", param_00);
  lib_04F3::func_79CE(game["music"]["flag_pickedup_pos"], var_01);
  lib_04F3::func_79CE(game["music"]["flag_pickedup_neg"], var_02);
  param_00 thread func_2CE1();
  param_00 thread func_9AAB(self);
  if(self.var_79AD lib_04FF::func_45D0("highlightDeliverZoneModel")) {
    var_04 = getEntArray("deliveryZoneModel", "targetname");
    foreach(var_06 in var_04) {
      var_06 thread updatehudoutlineforcarrier(param_00);
    }
  }
}

func_9AAB(param_00) {
  if(common_scripts\utility::func_F79(param_00.var_4B80, self)) {
    thread maps\mp\_utility::func_9863("callout_flagpickup", self);
    return;
  }

  param_00.var_4B80[param_00.var_4B80.size] = self;
  thread maps\mp\_events::func_3CC1();
}

func_2CE1() {
  wait(1);
  self method_8327();
}

func_28A9() {
  if(self.var_A560 == "none") {
    return;
  }

  if(common_scripts\utility::func_562E(self.var_915C)) {
    func_28A6("contested_contested");
    return;
  }

  if(isDefined(self.var_2006)) {
    func_28A6("escort_kill", self.var_2006);
    return;
  }

  if(self.var_230F != "none" && isDefined(self.var_230E)) {
    var_00 = self.var_230E.var_12C["team"];
    var_01 = maps\mp\gametypes\_gameobjects::func_45F7();
    var_02 = common_scripts\utility::func_98E7(var_00 == var_01, "taking_return", "grab_taking");
    func_28A6(var_02);
    return;
  }

  func_28A6("grab_return");
}

func_28A6(param_00, param_01) {
  thread func_05FA(param_00, param_01);
}

func_05FA(param_00, param_01) {
  level endon("game_ended");
  var_02 = lib_04FF::func_6937(self.var_695A);
  level endon(var_02);
  self notify("ctfItemIconUpdate");
  self endon("ctfItemIconUpdate");
  waittillframeend;
  if(isDefined(self.var_5BAB) && param_00 == self.var_5BAB) {
    return;
  }

  if(!isDefined(param_01)) {
    param_01 = self.var_501F;
  }

  if(isPlayer(param_01)) {
    var_03 = (0, 0, 80);
  } else {
    var_03 = (0, 0, 40);
  }

  var_04 = self.var_9D65.var_81E1;
  var_05 = lib_0502::func_4518(param_00, var_04);
  lib_04FF::func_860A(var_05, var_04);
  if(self.var_79AD lib_04FF::func_45D0("flagTriggerHasUI")) {
    self.var_501C lib_04FF::func_8616(var_05);
    self.var_501C lib_04FF::func_8618(param_01, undefined, var_03);
  }

  self.var_5BAB = param_00;
  func_28AA();
}

func_28AA() {
  if(common_scripts\utility::func_562E(self.var_915C) && isDefined(self.var_230E)) {
    self.var_501C lib_04FF::func_8CFD(self.var_230E);
    return;
  }

  if(isDefined(self.var_5B81)) {
    self.var_501C lib_04FF::func_A088(self.var_5B81);
  }
}

func_6AD4(param_00) {
  maps\mp\gametypes\_gameobjects::func_C1D("any");
  maps\mp\gametypes\_gameobjects::func_8740("enemy", self.var_79AD lib_04FF::func_45D0("flagReturnTime"));
  maps\mp\gametypes\_gameobjects::func_8740("friendly", self.var_79AD lib_04FF::func_45D0("droppedFlagPickupTime"));
  maps\mp\gametypes\_gameobjects::func_8A60("any");
  var_01 = "dropped";
  if(common_scripts\utility::func_562E(self.var_A879)) {
    var_01 = "thrown";
  }

  lib_04FF::func_6981(self.var_695A, var_01, 0, 1, self.var_9D65.var_81E1);
  func_3CBB();
  if(isDefined(param_00)) {
    var_02 = undefined;
    if(common_scripts\utility::func_562E(self.var_A879)) {
      var_02 = 0.5;
    }

    param_00 thread func_7DE9(self.var_79AD, var_02);
    param_00 func_2E40();
    param_00 lib_0502::replacehintstringclient(&"RAIDS_USE_CONSTRUCT", undefined);
    if(self.var_79AD lib_04FF::func_45D0("highlightDeliverZoneModel")) {
      self.var_79AD notify("flag_dropped");
      param_00 thread disablehudoutlineforcarrier();
    }
  }

  var_03 = maps\mp\gametypes\_gameobjects::func_45F7();
  var_04 = maps\mp\_utility::func_45DE(var_03);
  lib_04F3::func_79CE(game["music"]["flag_dropped_neg"], var_03);
  lib_04F3::func_79CE(game["music"]["flag_dropped_pos"], var_04);
  thread func_28A5();
}

func_6AD8() {
  maps\mp\gametypes\_gameobjects::func_C1D("enemy");
  maps\mp\gametypes\_gameobjects::func_8740("friendly", self.var_79AD lib_04FF::func_45D0("flagPickupTime"));
  maps\mp\gametypes\_gameobjects::func_8740("enemy", self.var_79AD lib_04FF::func_45D0("flagPickupTime"));
  maps\mp\gametypes\_gameobjects::func_8A60("none");
  self.var_8748 = undefined;
  self.var_200A = undefined;
  self.var_5BAB = undefined;
  self.var_10F5 = 1;
  self.var_4B80 = [];
  func_3C7A();
}

func_6AD2(param_00) {
  func_28A9();
  param_00.var_230C = self;
}

func_6AD5(param_00, param_01, param_02) {
  if(!common_scripts\utility::func_562E(param_02)) {
    func_28A9();
  }

  if(isDefined(param_01)) {
    param_01.var_230C = undefined;
    param_01 enableusability();
  }
}

func_28A8() {
  level endon("game_ended");
  self endon("reset");
  self endon("dropped");
  var_00 = self.var_2006;
  if(!isDefined(var_00)) {
    return;
  }

  var_00 endon("death");
  var_00 endon("disconnect");
  while(maps\mp\_utility::func_57A0(var_00)) {
    var_00 waittill("reload");
    var_01 = var_00 getcurrentprimaryweapon();
    var_02 = var_00 getweaponammostock(var_01);
    var_03 = weaponclipsize(var_01, var_00);
    if(var_02 < var_03) {
      var_00 setweaponammostock(var_01, var_03);
    }
  }
}

func_28A5() {
  level endon("game_ended");
  self notify("restartDropTimer");
  self endon("restartDropTimer");
  self endon("picked_up");
  self endon("reset");
  self endon("death");
  var_00 = undefined;
  var_01 = self.var_79AD lib_04FF::func_45D0("autoReturnTime") * 1000;
  var_02 = maps\mp\gametypes\_gameobjects::func_45F7();
  var_03 = maps\mp\_utility::func_45DE(var_02);
  for(;;) {
    if(!isDefined(var_00) || self.var_9AC3[var_02].size > 0) {
      var_00 = gettime() + var_01;
    }

    if(self.var_9AC3[var_03].size == 0 && gettime() >= var_00) {
      break;
    }

    wait 0.05;
  }

  lib_04F3::func_79CE(game["music"]["flag_returned_neg"], var_02);
  lib_04F3::func_79CE(game["music"]["flag_returned_pos"], var_03);
  lib_04F3::func_79CB("mp_war_bomb_explo", self.var_A582[0].var_116);
  playFX(common_scripts\utility::func_44F5("objective_resupply_death"), self.var_A582[0].var_116);
  physicsexplosionsphere(self.var_A582[0].var_116, 300, 50, 2);
  thread func_7E2F(self.var_9D65.var_81E1);
}

func_28A4() {
  level endon("game_ended");
  var_00 = lib_04FF::func_6937(self.var_695A);
  level endon(var_00);
  self endon("reset");
  self endon("death");
  if(!common_scripts\utility::func_562E(level.var_99F5)) {
    level waittill("start_overtime");
  }

  var_01 = self.var_79AD lib_04FF::func_45D0("flagGriefReturnTime");
  wait(var_01);
  thread func_7E2F(self.var_9D65.var_81E1);
}

func_28A3() {
  var_00 = getEntArray("trigger_hurt", "classname");
  var_01 = getEntArray("out_of_bounds", "targetname");
  foreach(var_03 in var_01) {
    var_00[var_00.size] = var_03;
  }

  var_05 = self.var_A582[0];
  foreach(var_03 in var_00) {
    if(var_05 istouching(var_03)) {
      return 1;
    }
  }

  return func_28A0();
}

func_28A0() {
  var_00 = self.var_A582[0];
  var_01 = !var_00 islinked() && !var_00 method_8524();
  var_02 = 0;
  var_03 = getEntArray("out_of_bounds_at_rest", "targetname");
  foreach(var_05 in var_03) {
    if(var_00 istouching(var_05)) {
      if(var_01) {
        return 1;
      }

      var_02 = 1;
      if(!isDefined(self.var_8748)) {
        var_06 = self.var_79AD lib_04FF::func_45D0("flagMaxSettleTime");
        self.var_8748 = gettime() + var_06 * 1000;
      }

      break;
    }
  }

  if(isDefined(self.var_8748)) {
    if(!var_02) {
      self.var_8748 = undefined;
    } else if(gettime() >= self.var_8748) {
      return 1;
    }
  }

  return 0;
}

func_28A1() {
  level endon("game_ended");
  self endon("reset");
  self endon("picked_up");
  self endon("death");
  for(;;) {
    if(func_28A3()) {
      waittillframeend;
      func_5E9E(self.var_A582[0], "Flag");
      playFX(common_scripts\utility::func_44F5("objective_resupply_death"), self.var_A582[0].var_116);
      physicsexplosionsphere(self.var_A582[0].var_116, 300, 50, 2);
      playsoundatpos(self.var_A582[0].var_116, "mp_war_bomb_explo");
      func_3CBC();
      thread func_7E2F(self.var_9D65.var_81E1);
      return;
    }

    wait 0.05;
  }
}

func_2009(param_00) {
  var_01 = getEntArray("out_of_bounds", "targetname");
  var_02 = 0;
  foreach(var_04 in var_01) {
    if(param_00 istouching(var_04)) {
      var_02 = 1;
      if(!isDefined(self.var_200A)) {
        var_05 = self.var_79AD lib_04FF::func_45D0("flagCarrierOOBTime");
        self.var_200A = gettime() + var_05 * 1000;
      }

      break;
    }
  }

  if(isDefined(self.var_200A)) {
    if(!var_02) {
      self.var_200A = undefined;
    } else if(gettime() >= self.var_200A) {
      return 1;
    }
  }

  return 0;
}

func_7730(param_00) {
  return "(" + param_00[0] + "," + param_00[1] + "," + param_00[2] + ")";
}

func_5E9E(param_00, param_01) {
  var_02 = lib_0502::func_799F();
  if(!var_02) {
    return;
  }

  var_03 = param_01 + " out-of-bounds at " + func_7730(param_00.var_116);
  iprintlnbold(var_03);
}

func_28A2() {
  level endon("game_ended");
  self endon("reset");
  self endon("dropped");
  var_00 = self.var_2006;
  if(!isDefined(var_00)) {
    return;
  }

  var_00 endon("death");
  var_00 endon("disconnect");
  for(;;) {
    if(func_2009(var_00)) {
      waittillframeend;
      func_5E9E(var_00, "Flag carrier");
      thread func_7E2F(self.var_9D65.var_81E1);
      return;
    }

    wait 0.05;
  }
}

func_1198() {
  self.var_A22B = 0;
  if(self.var_689F[game["attackers"]] > 0) {
    self.var_A22B = 1;
  }
}

func_6AE9(param_00) {
  param_00.var_230C = self;
  param_00.var_2016.var_501C lib_04FF::func_8617("ctf", undefined, undefined, undefined, undefined, self.var_A23F, self);
  var_01 = self.var_79AD lib_04FF::func_45D0("flagDeliverStartSound");
  if(var_01 != "") {
    self.var_A238 = lib_04F3::func_79CB(var_01, self.var_9D65.var_116);
  }

  lib_04FF::func_8610(param_00);
}

func_6AEA(param_00, param_01, param_02) {
  if(!common_scripts\utility::func_562E(param_02)) {
    if(isDefined(param_01.var_2016)) {
      param_01.var_2016.var_501C lib_04FF::func_8616();
    }
  }

  if(isDefined(param_01)) {
    param_01.var_230C = undefined;
  }

  lib_04FF::func_8611();
  if(isDefined(self.var_A238)) {
    var_03 = self.var_79AD lib_04FF::func_45D0("flagDeliverStopSoundFade");
    lib_04F3::func_79D0(self.var_A238, var_03);
  }

  var_04 = self.var_79AD lib_04FF::func_45D0("flagDeliverStopSound");
  if(var_04 != "") {
    lib_04F3::func_79CB(var_04, self.var_9D65.var_116);
  }
}

func_6AEB(param_00) {
  if(maps\mp\gametypes\_gameobjects::func_21CA(param_00) && param_00 != self.var_230E) {
    if(!common_scripts\utility::func_562E(param_00.var_A855)) {
      if(issubstr(maps\mp\_utility::func_4571(), "dlc2")) {
        param_00 iclientprintlnbold(&"RAIDS_INTEL_DEST_BUSY");
      } else {
        param_00 iclientprintlnbold(&"RAIDS_RESUPPLY_DEST_BUSY");
      }

      param_00.var_A855 = 1;
    }
  }
}

func_6AEC(param_00) {
  param_00.var_A855 = undefined;
}

func_1F7C(param_00) {
  return isDefined(param_00.var_2016);
}

func_6AD3(param_00) {
  self.var_79AD.var_2933++;
  setomnvar("ui_war_ctf_capture_count", self.var_79AD.var_2933);
  var_01 = param_00.var_2016;
  param_00 thread func_7DE9(self.var_79AD);
  if(self.var_79AD lib_04FF::func_45D0("highlightDeliverZoneModel")) {
    param_00 thread disablehudoutlineforcarrier();
  }

  lib_04FF::func_6981(self.var_695A, "delivery", 0, 1, var_01.var_9D65.var_81E1);
  var_01 thread func_7E2F();
  var_01.var_2D5A++;
  param_00 thread maps\mp\_events::func_3CB7();
  var_02 = param_00.var_12C["team"];
  var_03 = maps\mp\_utility::func_45DE(var_02);
  if(self.var_79AD.var_2933 < self.var_79AD lib_04FF::func_45D0("objectiveScoreGoal")) {
    lib_04F3::func_79CE("mp_war_stinger_pos", var_02);
    lib_04F3::func_79CE("mp_war_stinger_neg", var_03);
  }

  self.var_79AD notify("flag_captured");
}

func_6ADA(param_00) {
  if(!isDefined(param_00)) {
    param_00 = 0;
  }

  self.var_57A6 = 1;
  self notify("dropped");
  var_01 = self.var_2006;
  if(isDefined(var_01) && isDefined(var_01.var_230C)) {
    var_01.var_230C.var_28D5 = 0;
  }

  if(isDefined(var_01) && var_01.var_12C["team"] != "spectator") {
    var_02 = var_01.var_116;
  } else {
    var_02 = self.var_802F;
  }

  var_02 = var_02 + (0, 0, 40);
  var_03 = (0, 0, 0);
  for(var_04 = 0; var_04 < self.var_A582.size; var_04++) {
    self.var_A582[var_04].var_116 = var_02;
    self.var_A582[var_04].var_1D = var_03;
    self.var_A582[var_04] method_805B();
  }

  self.var_9D65.var_116 = var_02;
  self.var_A582[0] method_808C();
  self.var_28D4 = self.var_9D65.var_116;
  func_3C7A();
  if(isDefined(self.var_6AEF)) {
    self[[self.var_6AEF]](self.var_2006);
  }

  maps\mp\gametypes\_gameobjects::func_23DA();
  maps\mp\gametypes\_gameobjects::func_A0FE();
  maps\mp\gametypes\_gameobjects::func_A19B();
  func_28A9();
  self.var_57A6 = 0;
  thread func_28A1();
  if(!param_00) {
    func_3CC0((0, 0, 80));
  } else {
    maps\mp\gametypes\_gameobjects::func_8740("friendly", self.var_79AD lib_04FF::func_45D0("flagCatchPickupTime"));
  }

  return 1;
}

func_3CC0(param_00, param_01) {
  var_02 = self.var_A582[0];
  var_02.var_6C43 = undefined;
  if(isDefined(param_01)) {
    var_03 = param_01.var_1D;
    var_02.var_1D = (0, var_03[1] + 250, 120);
  }

  var_02 physicslaunchserver(var_02.var_116, param_00);
}

func_3C7A() {
  if(isDefined(self.var_2006)) {
    self.var_2006 common_scripts\utility::func_615();
  }
}

func_941D(param_00) {
  self endon("death");
  self endon("disconnect");
  self endon("drop_object");
  while(self method_8126()) {
    wait 0.05;
  }

  var_01 = param_00 lib_04FF::func_45D0("flagGrenadeWeapon");
  if(param_00 lib_04FF::func_45D0("flagGrenadeThrowEnabled")) {
    if(!isDefined(self.var_9426)) {
      self.var_9426 = [];
    }

    var_02 = spawnStruct();
    var_02.var_109 = self method_834A();
    var_02.var_2420 = self getweaponammoclip(var_02.var_109, "right");
    var_02.var_93AF = self getweaponammostock(var_02.var_109);
    self.var_9426["lethal_offhand"] = var_02;
    var_03 = spawnStruct();
    var_03.var_109 = self method_831F();
    var_03.var_2420 = self getweaponammoclip(var_03.var_109, "right");
    var_03.var_93AF = self getweaponammostock(var_03.var_109);
    self.var_9426["tactical_offhand"] = var_03;
    if(var_02.var_109 != "none") {
      self takeweapon(var_02.var_109);
    }

    if(var_03.var_109 != "none") {
      self takeweapon(var_03.var_109);
    }

    self method_8349(var_01);
    self giveweapon(var_01);
    self method_82FA(var_01, 1, "right");
    self setweaponammostock(var_01, 1);
    return;
  }

  self giveweapon(var_01);
}

func_7DE9(param_00, param_01) {
  if(isDefined(param_01)) {
    wait(param_01);
  }

  var_02 = param_00 lib_04FF::func_45D0("flagPickupWeapon");
  if(var_02 != "noWeapSwitch" && self hasweapon(var_02)) {
    self takeweapon(var_02);
  }

  var_03 = param_00 lib_04FF::func_45D0("flagGrenadeWeapon");
  if(self hasweapon(var_03)) {
    self takeweapon(var_03);
  }

  if(param_00 lib_04FF::func_45D0("flagGrenadeThrowEnabled") == 0) {
    return;
  }

  if(!isDefined(self.var_9426)) {
    return;
  }

  var_04 = self.var_9426["lethal_offhand"];
  if(var_04.var_109 != "none") {
    self method_8349(var_04.var_109);
    self giveweapon(var_04.var_109);
    self method_82FA(var_04.var_109, var_04.var_2420, "right");
    self setweaponammostock(var_04.var_109, var_04.var_93AF);
  }

  var_05 = self.var_9426["tactical_offhand"];
  if(var_05.var_109 != "none") {
    self method_831E(var_05.var_109);
    self giveweapon(var_05.var_109);
    self method_82FA(var_05.var_109, var_05.var_2420, "right");
    self setweaponammostock(var_05.var_109, var_05.var_93AF);
  }
}

func_5829(param_00) {
  switch (param_00) {
    case "raid_carryflag_physics_mp":
    case "raid_carryflag_mp":
      return 1;

    default:
      return 0;
  }
}

func_3CBB() {
  if(!func_3CC8()) {
    var_00 = self.var_A582[0];
    var_01 = self.var_501F;
    playFXOnTag(common_scripts\utility::func_44F5("objective_flag_trail"), var_00, "tag_origin");
    self.var_3C95 = 1;
    thread func_92DB();
  }
}

func_92DB() {
  self endon("picked_up");
  self endon("reset");
  self endon("death");
  var_00 = self.var_A582[0];
  var_00 waittill("physics_impact", var_01, var_02, var_03, var_04);
  if(isDefined(level.ongascanphysics)) {
    var_00 thread[[level.ongascanphysics]]();
  }

  if(func_3CC8()) {
    stopFXOnTag(common_scripts\utility::func_44F5("objective_flag_trail"), var_00, "tag_origin");
    self.var_3C95 = 0;
  }

  var_00 waittill("physics_finished");
  maps\mp\gametypes\_gameobjects::func_8740("friendly", self.var_79AD lib_04FF::func_45D0("droppedFlagPickupTime"));
  playFXOnTag(common_scripts\utility::func_44F5("objective_flag_glow"), var_00, "tag_origin");
  self.var_3C84 = 1;
}

func_3CBC() {
  var_00 = self.var_A582[0];
  if(func_3CC8()) {
    stopFXOnTag(common_scripts\utility::func_44F5("objective_flag_trail"), var_00, "tag_origin");
  }

  if(func_3CBE()) {
    var_01 = self.var_501F;
    killfxontag(common_scripts\utility::func_44F5("objective_flag_glow"), var_00, "tag_origin");
  }

  self.var_3C84 = 0;
  self.var_3C95 = 0;
}

func_3CBE() {
  return isDefined(self.var_3C84) && self.var_3C84;
}

func_3CC8() {
  return isDefined(self.var_3C95) && self.var_3C95;
}

func_A11C(param_00, param_01) {
  param_00 endon("death");
  var_02 = lib_04FF::func_6937(self.var_695A);
  level endon(var_02);
  var_03 = param_00.var_982E;
  for(;;) {
    var_03 waittill("flag_pickup", var_04);
    if(param_01) {
      param_00 notify("showToTeam");
      param_00 method_805C();
    } else {
      param_00 lib_0502::func_8C20();
    }

    var_03 waittill("flag_return");
    if(param_01) {
      param_00 lib_0502::func_8C21(game["attackers"]);
      continue;
    }

    param_00 lib_0502::func_8C21(game["defenders"]);
  }
}

func_7C19(param_00) {
  param_00 method_805C();
  lib_04FF::func_6983(self.var_695A);
  if(!lib_04FF::func_45D0("objModelDissappearsOnPickup")) {
    param_00 thread lib_0502::func_8C21(game["attackers"]);
    thread func_A11C(param_00, 1);
  } else {
    param_00 thread lib_0502::func_8C20();
    param_00 thread updatehudoutline();
    thread updateintelonpickup(param_00, 1);
  }

  lib_04FF::func_6982(self.var_695A);
  param_00 delete();
}

func_7C18(param_00) {
  lib_04FF::func_6983(self.var_695A);
  param_00 method_805C();
  param_00 thread lib_0502::func_8C21(game["defenders"]);
  thread func_A11C(param_00, 0);
  lib_04FF::func_6982(self.var_695A);
  param_00 method_805B();
}

updateintelonpickup(param_00, param_01) {
  param_00 endon("death");
  var_02 = lib_04FF::func_6937(self.var_695A);
  level endon(var_02);
  var_03 = param_00.var_982E;
  for(;;) {
    var_03 waittill("flag_pickup", var_04);
    if(param_01) {
      param_00 notify("showToTeam");
      param_00 method_805C();
    } else {
      param_00 lib_0502::func_8C20();
    }

    var_03 waittill("flag_return");
    param_00 lib_0502::func_8C20();
  }
}

setoutline(param_00, param_01) {
  if(!isDefined(param_01)) {
    param_01 = game["attackers"];
  }

  if(!isDefined(param_00.outlinecolor)) {
    param_00.outlinecolor = 1;
  }

  if(param_01 == game["attackers"]) {
    var_02 = 1;
  } else {
    var_02 = 2;
  }

  param_00 hudoutlinedisableforclient(self);
  param_00 hudoutlineenableforclient(self, var_02, 1);
}

updatehudoutline() {
  self endon("death");
  self endon("destroyed");
  for(;;) {
    foreach(var_01 in level.var_744A) {
      var_01 setoutline(self, var_01.var_1A7);
    }

    wait(3);
  }
}

updatehudoutlineforcarrier(param_00) {
  self endon("death");
  self endon("destroyed");
  param_00 endon("outline_disabled");
  param_00 endon("death");
  param_00 endon("disconnect");
  for(;;) {
    if(param_00.var_1A7 == game["attackers"]) {
      param_00 setoutline(self, param_00.var_1A7);
    }

    wait(3);
  }
}

disablehudoutlineforcarrier() {
  self notify("outline_disabled");
  var_00 = getEntArray("deliveryZoneModel", "targetname");
  foreach(var_02 in var_00) {
    var_02 hudoutlinedisableforclient(self);
  }
}