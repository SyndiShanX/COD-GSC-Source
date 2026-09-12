/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: 477.gsc
*********************************************/

func_0052() {
  if(getDvar("233") == "1") {
    level waittill("eternity");
  }

  if(!isDefined(level.var_3FDF) || !level.var_3FDF) {
    [[level.callbackstartgametype]]();
    level.var_3FDF = 1;
  }
}

func_004B() {
  if(getDvar("233") == "1") {
    level waittill("eternity");
  }

  self endon("disconnect");
  [[level.callbackplayerconnect]]();
}

func_004D(param_00) {
  self notify("disconnect");
  [[level.callbackplayerdisconnect]](param_00);
}

func_004C(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09) {
  self endon("disconnect");
  [[level.callbackplayerdamage]](param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09);
}

func_004F(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08) {
  self endon("disconnect");
  [[level.callbackplayerkilled]](param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08);
}

func_0042(param_00, param_01) {
  self endon("disconnect");
  [[level.var_1E72]](param_00, param_01);
}

func_004E(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07) {
  self endon("disconnect");
  [[level.var_1E7A]](param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07);
}

func_0044() {
  self endon("disconnect");
  [[level.callbackentityoutofworld]]();
}

func_0040(param_00, param_01, param_02, param_03, param_04, param_05) {
  self endon("disconnect");
  if(isDefined(self.var_1D7D)) {
    [[self.var_1D7D]](param_00, param_01, param_02, param_03, param_04, param_05);
  }
}

func_0054(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A, param_0B) {
  if(isDefined(self.var_29B5)) {
    self[[self.var_29B5]](param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A, param_0B);
    return;
  }

  self method_827F(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A, param_0B);
}

func_0043(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A, param_0B) {
  if(isDefined(self.var_29B5)) {
    self[[self.var_29B5]](param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A, param_0B);
    return;
  }

  self finishentitydamage(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A, param_0B);
}

func_0041() {
  self endon("disconnect");
  [[level.callbackcodeendgame]]();
}

func_0048(param_00, param_01, param_02) {
  maps\mp\gametypes\_killcam::func_92E1(param_00, param_01, param_02);
}

func_0050(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08) {
  self endon("disconnect");
  [[level.callbackplayerlaststand]](param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08);
}

func_0051() {
  self endon("disconnect");
  [[level.callbackplayermigrated]]();
}

func_0047() {
  [[level.var_1E75]]();
}

func_2491(param_00, param_01) {
  if(isbot(param_00) || function_026D(param_00) || (isDefined(param_00.team) && param_00.team == "spectator") || param_00.sessionstate == "spectator") {
    return;
  }

  if(!isDefined(level.killstreakfuncs)) {
    return;
  }

  if((isDefined(level.killstreakfuncs[param_01]) && tablelookup("mp/killstreakTable.csv", 1, param_01, 0) != "") || issubstr(param_01, "turrethead")) {
    if(getdvarint("scorestreak_enabled_" + param_01) == 0) {
      iprintlnbold("Scorestreak " + param_01 + " was disabled.Re-enabling...");
      setDvar("scorestreak_enabled_" + param_01, 1);
    }

    var_02 = param_00 maps\mp\killstreaks\_killstreaks::func_46B4(param_01);
    var_03 = param_00 maps\mp\killstreaks\_killstreaks::func_45A5(param_01);
    param_00 thread maps\mp\gametypes\_hud_message::func_5A78(param_01, var_02, undefined, var_03);
    param_00 maps\mp\killstreaks\_killstreaks::func_478D(param_01);
  }
}

func_47B6(param_00) {
  wait 0.05;
  lib_0533::func_3662(param_00);
}

func_95F2(param_00) {
  wait 0.05;
  lib_0533::func_2F9E(param_00);
}

func_0045(param_00, param_01) {
  if(function_026D(param_00) || param_00.team == "spectator" || param_00.sessionstate == "spectator") {
    return;
  }

  param_00 thread func_47B6(param_01);
}

func_0053(param_00, param_01) {
  if(function_026D(param_00) || param_00.team == "spectator" || param_00.sessionstate == "spectator") {
    return;
  }

  param_00 thread func_95F2(param_01);
}

func_2492(param_00, param_01) {}

func_2499(param_00) {}

func_2494(param_00, param_01) {}

func_249D(param_00, param_01) {}

func_249E(param_00, param_01) {}

func_249A(param_00, param_01) {}

func_2496(param_00) {}

func_2490(param_00, param_01) {}

func_249B(param_00, param_01) {}

func_249C(param_00, param_01) {}

func_248F(param_00) {}

func_2495(param_00) {}

func_2493(param_00) {}

func_2498(param_00) {}

func_24A0(param_00) {}

func_2497(param_00) {}

func_249F(param_00, param_01) {}

func_004A(param_00) {
  if(isDefined(level.var_6EA3)) {
    [[level.var_6EA3]](param_00);
  }
}

func_8A13() {
  level.var_503C = 1;
  level.var_5034 = 2;
  level.var_5035 = 4;
  level.var_503B = 8;
  level.var_503A = 16;
  level.var_5040 = 32;
  level.var_503D = 64;
  level.var_503E = 128;
  level.var_503F = 256;
  level.var_5037 = 512;
  level.var_5036 = 1024;
  level.var_5038 = 2048;
  level.var_5039 = level.var_503B | level.var_503A;
}

func_8A0C() {
  func_865F();
  func_8A13();
}

func_865F() {
  level.callbackstartgametype = ::maps\mp\gametypes\_gamelogic::func_1E70;
  level.callbackplayerconnect = ::maps\mp\gametypes\_playerlogic::callback_playerconnect;
  level.callbackplayerdisconnect = ::maps\mp\gametypes\_playerlogic::func_1E6A;
  level.callbackplayerdamage = ::maps\mp\gametypes\_damage::func_1E68;
  level.callbackplayerkilled = ::maps\mp\gametypes\_damage::callback_playerkilled;
  level.var_1E72 = ::maps\mp\gametypes\_damage::func_1E63;
  level.callbackentityoutofworld = ::maps\mp\gametypes\_damage::callback_entityoutofworld;
  level.var_1E7A = ::maps\mp\gametypes\_damage::callback_playergrenadesuicide;
  level.callbackcodeendgame = ::maps\mp\gametypes\_gamelogic::func_1E62;
  level.callbackplayerlaststand = ::maps\mp\gametypes\_damage::func_1E6D;
  level.callbackplayermigrated = ::maps\mp\gametypes\_playerlogic::func_1E6F;
  level.var_1E75 = ::maps\mp\gametypes\_hostmigration::func_1E65;
}

func_0847() {
  level.callbackstartgametype = ::func_1E81;
  level.callbackplayerconnect = ::func_1E81;
  level.callbackplayerdisconnect = ::func_1E81;
  level.callbackplayerdamage = ::func_1E81;
  level.callbackplayerkilled = ::func_1E81;
  level.callbackentityoutofworld = ::func_1E81;
  level.var_1E7A = ::func_1E81;
  level.callbackcodeendgame = ::func_1E81;
  level.callbackplayerlaststand = ::func_1E81;
  level.callbackplayermigrated = ::func_1E81;
  level.var_1E75 = ::func_1E81;
  setDvar("1924", "dm");
  exitlevel(0);
}

func_1E81() {}