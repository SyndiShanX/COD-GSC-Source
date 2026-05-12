/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: 1278.gsc
*********************************************/

func_5322() {
  var_00 = lib_0502::func_2548("neutralizeObjective", ::func_6671);
  var_01 = var_00 lib_0502::func_2548("vehicle", ::func_667E);
}

func_6E8A(param_00) {
  var_01 = [];
  if(isDefined(param_00.var_8260)) {
    var_02 = strtok(param_00.var_8260, " ");
    foreach(var_04 in var_02) {
      var_01[var_04] = 1;
    }
  }

  return var_01;
}

func_6671(param_00) {
  level.var_611["tank_exhaust"] = loadfx("vfx/smoke/sherman_tank_exhaust");
  level.var_611["tank_muzzle"] = loadfx("vfx/muzzleflash/us_tank_sherman_muzzle");
  lib_04FF::func_6934(param_00);
  thread func_6673();
  var_01 = func_6E8A(param_00);
  if(common_scripts\utility::func_562E(var_01["capture"])) {
    thread func_667D();
    return;
  }

  thread func_667C();
}

func_667E(param_00) {
  var_01 = function_01E0(param_00.var_106, param_00.var_1A5, param_00.var_1C8, param_00.var_116, param_00.var_1D);
  var_01.var_1C8 = param_00.var_1C8;
  var_01.var_1A2 = param_00.var_1A2;
  var_02 = param_00.var_82B2;
  if(common_scripts\utility::func_562E(level.var_79C1)) {
    var_01.var_1A7 = maps\mp\_utility::func_45DE(var_02);
  } else {
    var_01.var_1A7 = var_02;
  }

  var_01 method_8253(var_01.var_1A7);
  var_01.var_A045 = ::lib_0504::func_A3FE;
  var_01 method_867B(1);
  var_01.var_4881 = 1;
  var_01 makeunusable();
  var_01 method_828E();
  var_01.var_BC = lib_04FF::func_45D0("health");
  var_01.var_FB = var_01.var_BC;
  var_01.var_6A = 0;
  var_01 setCanDamage(0);
  var_01.var_29B5 = ::func_97B7;
  var_01.var_118F = [];
  var_01 common_scripts\utility::func_3799("cannon_loaded");
  var_01 common_scripts\utility::func_379A("cannon_loaded");
  var_01 common_scripts\utility::func_3799("weapons_free");
  var_01 common_scripts\utility::func_379A("weapons_free");
  var_01.var_675B = getEntArray("tank_notarget", "script_noteworthy");
  var_03 = anglesToForward(var_01 gettagangles("tag_flash"));
  var_04 = var_01 gettagorigin("tag_flash") + var_03 * 300;
  var_05 = spawn("script_origin", var_04);
  var_05 linkto(var_01);
  var_01.var_6680 = var_05;
  var_06 = spawn("script_origin", var_04);
  var_01.var_11B6 = var_06;
  var_01.var_8383 = 1;
  var_01.var_112 = self;
  self.var_A2C8 = var_01;
  var_07 = common_scripts\utility::func_44F5("tank_exhaust");
  playFXOnTag(var_07, var_01, "tag_exhaust_left");
  playFXOnTag(var_07, var_01, "tag_exhaust_right");
  lib_0504::func_79F3(var_01, function_01DD(), ::func_6677);
  lib_04FF::func_6983(self.var_695A);
  var_01 thread func_97B5(self);
  var_01 thread func_97BB(self);
  var_01 thread func_97BF(self);
}

func_6677(param_00, param_01, param_02) {
  level endon(lib_04FF::func_6937(self.var_695A));
  for(;;) {
    param_01 waittill("trigger", var_03);
    if(param_00 != var_03) {
      continue;
    }

    switch (param_02) {
      case "arena_enter":
        func_6675(param_00, param_01);
        break;

      case "arena_exit":
        func_6676(param_00, param_01);
        break;

      default:
        break;
    }
  }
}

func_6673() {
  var_00 = getEntArray("gun", "script_noteworthy");
  foreach(var_02 in var_00) {
    var_02 setdefaultdroppitchyaw(0, 0);
    var_02 method_8131();
    var_03 = var_02 common_scripts\utility::func_41ED();
    foreach(var_05 in var_03) {
      if(!isDefined(var_05.var_165)) {
        continue;
      }

      switch (var_05.var_165) {
        case "tank_notarget":
          var_02.var_675A = var_05;
          var_02.var_675A.var_8BE = 1;
          break;

        case "gun_capture":
          var_02.var_1FC2 = var_05;
          break;
      }
    }
  }
}

func_8A0D(param_00) {}

func_9F7C(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A, param_0B) {
  if(!isDefined(param_05) || param_05 != "ger_tank_panzer_4_turret") {
    return;
  }

  if(!common_scripts\utility::func_562E(self.var_29BF)) {
    return;
  }

  func_2DDE(self);
  var_0C = 128;
  radiusdamage(param_06, var_0C, 500, 100, param_01, param_04, param_05, 0);
}

func_2DDE(param_00) {
  param_00 notify("destroyed");
  var_01 = param_00 method_80E2();
  if(isDefined(var_01)) {
    var_01 func_73D2();
    var_01 method_85E9();
  }

  param_00 makeunusable();
  param_00 setdefaultdroppitchyaw(0, 0);
  param_00 setCanDamage(0);
  param_00 setdamagecallbackon(0);
  param_00.var_29B5 = undefined;
  param_00.var_566B = 0;
  param_00 setModel("ger_btry_pak38_dstrypv_raid");
  if(isDefined(param_00.var_675A)) {
    param_00.var_675A.var_8BE = 0;
  }

  lib_04F3::func_79CF("mp_war_bomb_explo", param_00, "tag_origin");
  playFXOnTag(common_scripts\utility::func_44F5("turret_destruction"), param_00, "tag_origin");
}

func_97B5(param_00) {
  self endon("neutralized");
  self endon("death");
  for(;;) {
    wait 0.05;
    if(!common_scripts\utility::func_562E(self.var_8383)) {
      continue;
    }

    if(isDefined(self.var_88)) {
      if(func_97DB(self.var_88)) {
        func_97B4();
        continue;
      }

      continue;
    }

    var_01 = func_97B8();
    if(isDefined(var_01)) {
      func_97D9(var_01);
    }
  }
}

func_97DB(param_00) {
  if(func_5675(param_00)) {
    return 0;
  }

  var_01 = gettime();
  var_02 = var_01 - param_00.var_6E31;
  if(var_02 >= 10000) {
    self.var_50A2 = param_00;
    return 1;
  }

  if(!func_97F5(param_00)) {
    if(!isDefined(param_00.var_6E32)) {
      param_00.var_6E32 = var_01;
    } else {
      var_03 = var_01 - param_00.var_6E32;
      if(var_03 >= 1000) {
        return 1;
      }
    }
  } else {
    param_00.var_6E32 = undefined;
  }

  return 0;
}

func_5675(param_00) {
  if(!lib_0504::func_5812(param_00)) {
    return 0;
  }

  return isDefined(param_00.maxhealth) && param_00.maxhealth == "turret_ger_btry_pak38_raid_mp";
}

func_7487(param_00) {
  if(!param_00 isusingturret()) {
    return 0;
  }

  var_01 = param_00 method_85E3();
  if(!isDefined(var_01)) {
    return 0;
  }

  return func_5675(var_01);
}

func_9787() {
  var_00 = [];
  var_01 = maps\mp\_utility::func_45DE(self.var_1A7);
  var_02 = lib_0502::func_4627(var_01);
  foreach(var_04 in var_02) {
    if(isDefined(self.var_50A2) && var_04 == self.var_50A2) {
      continue;
    }

    if(!func_97BE(var_04)) {
      continue;
    }

    if(!func_97F5(var_04)) {
      continue;
    }

    if(func_7487(var_04)) {
      continue;
    }

    var_00[var_00.size] = var_04;
  }

  return var_00;
}

func_97B8() {
  var_00 = func_9787();
  var_01 = undefined;
  var_02 = undefined;
  var_03 = self gettagorigin("tag_barrel");
  var_04 = anglesToForward(self gettagangles("tag_barrel"));
  foreach(var_06 in var_00) {
    var_07 = var_06.var_116 + func_46C0(var_06);
    var_08 = var_07 - var_03;
    var_09 = vectornormalize(var_08);
    var_0A = vectordot(var_03, var_09);
    if(!isDefined(var_02) || var_0A > var_01) {
      var_01 = var_0A;
      var_02 = var_06;
    }
  }

  self.var_50A2 = undefined;
  return var_02;
}

func_97BB(param_00) {
  self endon("neutralized");
  self endon("death");
  for(;;) {
    if(isDefined(self.var_88)) {
      func_97DA(self.var_88);
      wait(1);
    }

    wait 0.05;
  }
}

func_97E3(param_00) {
  self endon("neutralized");
  self endon("death");
  self endon("weapon_fired");
  for(;;) {
    if(func_97BE(self.var_88)) {
      func_9783(self.var_88);
    } else {
      thread func_97B4();
      return;
    }

    wait(0.1);
  }
}

func_9783(param_00) {
  var_01 = func_46C0(param_00);
  if(function_0296(param_00)) {
    self.var_11B6.var_116 = param_00;
    param_00 = self.var_11B6;
  } else {
    self.var_11B6.var_116 = param_00.var_116 + var_01;
    if(!self.var_11B6 islinked()) {
      self.var_11B6 linkto(param_00);
    }
  }

  var_02 = self gettagorigin("tag_barrel");
  var_03 = param_00.var_116 + var_01;
  var_04 = distance(var_02, var_03);
  if(var_04 < 500) {
    var_05 = var_03 - var_02;
    var_06 = vectornormalize(var_05);
    var_07 = var_02 + var_06 * getdvarfloat("scr_raid_panzerSafeTargetDistance", 1000);
    self method_825B(var_07);
    self.var_8030 = var_07;
    return;
  }

  self.var_8030 = undefined;
  self method_825C(param_00, var_01);
}

func_97DA(param_00) {
  self endon("abortTarget");
  thread func_97E3(param_00);
  common_scripts\utility::func_379C("cannon_loaded");
  self waittill("turret_on_target");
  common_scripts\utility::func_379C("weapons_free");
  wait(0.1);
  playFXOnTag(common_scripts\utility::func_44F5("tank_muzzle"), self, "tag_flash");
  self method_8263();
}

func_97C4(param_00) {
  param_00.var_4D3B = 1;
  func_97D9(param_00);
  if(lib_0504::func_5812(param_00)) {
    param_00 thread func_9F80(20);
  }

  var_01 = 0;
  while(var_01 < 5) {
    if(!func_97F5(param_00) || !func_97F4(param_00)) {
      var_01 = 0;
      continue;
    }

    var_01++;
    wait 0.05;
  }

  self method_8280(0, self.var_112 lib_04FF::func_45D0("haltAccel"));
  self.var_112 thread func_667B(self, param_00);
}

func_9F80(param_00) {
  self endon("destroyed");
  wait(param_00);
  level thread func_2DDE(self);
}

func_97B4() {
  self notify("abortTarget");
  self method_825C(self.var_6680);
  self.var_88 = undefined;
  self.var_11B6 unlink();
}

func_97D9(param_00) {
  func_97B4();
  if(!func_97BE(param_00)) {
    return;
  }

  param_00.var_6E31 = gettime();
  param_00.var_6E32 = undefined;
  self.var_88 = param_00;
}

func_97BE(param_00) {
  if(!isDefined(param_00)) {
    return 0;
  }

  if(!function_0296(param_00) && common_scripts\utility::func_562E(param_00.var_4D3B) && func_97E2(param_00)) {
    return 1;
  }

  var_01 = func_46C1(param_00);
  if(!self method_825E(var_01, 0)) {
    return 0;
  }

  if(function_0296(param_00)) {
    return 1;
  }

  if(isPlayer(param_00)) {
    if(param_00 method_8541()) {
      return 0;
    }

    foreach(var_03 in self.var_675B) {
      if(common_scripts\utility::func_562E(var_03.var_8BE) && param_00 istouching(var_03)) {
        return 0;
      }
    }
  }

  if(!func_97E2(param_00)) {
    return 0;
  }

  return lib_04FF::func_583D(param_00, self);
}

func_46C1(param_00) {
  if(function_0296(param_00)) {
    var_01 = param_00;
  } else {
    var_01 = var_01.var_116;
  }

  var_01 = var_01 + func_46C0(param_00);
  return var_01;
}

func_46C0(param_00) {
  if(function_0296(param_00)) {
    return (0, 0, 0);
  } else if(lib_0504::func_5812(param_00)) {
    var_01 = param_00 gettagorigin("tag_aim");
    var_02 = var_01 - param_00.var_116;
    return var_02;
  } else if(isPlayer(var_02)) {
    var_03 = var_02 getviewheight();
    var_04 = (0, 0, var_03 / 2);
    return var_04;
  }

  return (0, 0, 0);
}

func_97F5(param_00) {
  var_01 = func_46C1(param_00);
  var_02 = self method_825E(var_01, 1);
  return var_02;
}

func_97F4(param_00) {
  var_01 = self gettagorigin("tag_turret");
  var_02 = func_46C1(param_00);
  var_03 = sighttracepassed(var_01, var_02, 0, self, undefined, 0);
  return var_03;
}

func_97E2(param_00) {
  if(function_0296(param_00) || param_00 == self.var_11B6) {
    return 1;
  }

  if(isDefined(param_00.var_566B)) {
    return param_00.var_566B;
  }

  return isalive(param_00);
}

func_97BF(param_00) {
  self endon("neutralized");
  self endon("death");
  for(;;) {
    self waittill("weapon_fired");
    common_scripts\utility::func_3796("cannon_loaded");
    var_01 = param_00 lib_04FF::func_45D0("reloadTime");
    wait(var_01);
    common_scripts\utility::func_379A("cannon_loaded");
  }
}

func_6670(param_00) {
  if(isPlayer(param_00)) {
    return param_00;
  }

  var_01 = undefined;
  if(lib_0504::func_5812(param_00)) {
    var_01 = param_00 method_80E2();
  } else if(isDefined(param_00.var_117)) {
    var_01 = param_00.var_117;
  }

  if(isDefined(var_01) && isPlayer(var_01)) {
    return var_01;
  }

  return undefined;
}

func_6674(param_00, param_01, param_02, param_03) {
  if(param_02 == "MOD_IMPACT" && maps\mp\gametypes\_weapons::func_5707(param_01)) {
    return 0;
  }

  if(param_02 == "MOD_MELEE") {
    return 0;
  }

  var_04 = param_01;
  if(function_030D(param_01)) {
    var_04 = maps\mp\_utility::func_452B(param_01);
  }

  if(maps\mp\_utility::func_5856(var_04)) {
    var_04 = maps\mp\gametypes\_class::func_4432(var_04);
  }

  switch (var_04) {
    case "turret_ger_btry_pak38_raid_mp":
      var_05 = self.var_112 lib_04FF::func_45D0("gunDamage");
      break;

    case "panzerschreck_mp":
    case "bazooka_mp":
    default:
      var_05 = 0;
      break;
  }

  return var_05;
}

func_97B7(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A, param_0B) {
  var_0C = self;
  if(common_scripts\utility::func_562E(var_0C.var_480F)) {
    return;
  }

  if(!isDefined(param_01) || param_01.var_3A == "worldspawn") {
    return;
  }

  var_0D = func_6670(param_01);
  if(!isDefined(var_0D) && !lib_0504::func_5812(param_01)) {
    return;
  }

  if(maps\mp\_utility::func_118D(var_0C, var_0D)) {
    return;
  }

  if(common_scripts\utility::func_562E(param_01.var_29BF)) {
    return;
  }

  var_0E = func_6674(param_01, param_05, param_04, param_02);
  var_0F = var_0C.var_FB - var_0C.var_6A;
  var_10 = int(min(var_0E, var_0F));
  if(var_10 < 1) {
    return;
  }

  var_0C.var_6A = var_0C.var_6A + var_10;
  if(isDefined(var_0D)) {
    func_667A(var_0C, var_0D, var_10);
    var_0D maps\mp\gametypes\_damagefeedback::func_A102("standard");
  }

  func_667F(var_0C);
  if(var_0C.var_6A >= var_0C.var_FB) {
    level thread func_666F(var_0C);
    return;
  }

  if(lib_0504::func_5812(param_01)) {
    param_01.var_29BF = 1;
    var_0C thread func_97C4(param_01);
  }
}

func_666F(param_00) {
  param_00 endon("death");
  param_00 setCanDamage(0);
  param_00 method_825D();
  param_00 lib_04FF::func_7CCA();
  param_00 notify("neutralized");
  param_00 method_8280(0, 3);
  var_01 = common_scripts\utility::func_44F5("tank_exhaust");
  stopFXOnTag(var_01, param_00, "tag_exhaust_left");
  stopFXOnTag(var_01, param_00, "tag_exhaust_right");
}

func_667A(param_00, param_01, param_02) {
  if(!isDefined(param_00.var_118F[param_01.var_48CA])) {
    var_03 = spawnStruct();
    var_03.var_721C = param_01;
    var_03.var_9309 = gettime();
    var_03.var_9AB1 = 0;
    param_00.var_118F[param_01.var_48CA] = var_03;
  }

  var_03 = param_00.var_118F[param_01.var_48CA];
  var_03.var_9AB1 = var_03.var_9AB1 + param_02;
}

func_667F(param_00) {
  var_01 = param_00.var_6A / param_00.var_BC;
  var_02 = clamp(var_01, 0, 1);
  var_03 = int(var_02 * 30000);
  param_00 lib_04FF::func_8615(var_03);
}

func_6679() {
  lib_04FF::func_6935(self.var_695A);
  func_6678();
}

func_6678() {
  var_00 = undefined;
  foreach(var_02 in self.var_A2C8.var_118F) {
    level thread maps\mp\gametypes\_rank::func_1457("raids_neutralize", var_02.var_721C);
    if(!isDefined(var_00)) {
      var_00 = var_02;
      continue;
    }

    if(var_02.var_9AB1 > var_00.var_9AB1) {
      var_00 = var_02;
      continue;
    }

    if(var_02.var_9AB1 == var_00.var_9AB1 && var_02.var_9309 < var_00.var_9309) {
      var_00 = var_02;
    }
  }

  if(isDefined(var_00)) {
    level thread maps\mp\_utility::func_9863("raids_callout_capture", var_00.var_721C);
  }
}

func_4376(param_00) {
  if(!isDefined(self.var_1A2)) {
    return [];
  }

  var_01 = getEntArray(self.var_1A2, "targetname");
  if(!isDefined(param_00)) {
    return var_01;
  }

  var_02 = [];
  foreach(var_04 in var_01) {
    if(isDefined(var_04.var_165) && issubstr(var_04.var_165, param_00)) {
      var_02[var_02.size] = var_04;
    }
  }

  return var_02;
}

func_667C() {
  var_00 = [1, 2, 3, 4, 5, 10, 20];
  lib_04FF::func_6963("speed", 3, var_00);
  lib_04FF::func_6963("accel", 3, var_00);
  lib_04FF::func_6963("haltAccel", 20, var_00);
  lib_04FF::func_6963("decel", 3, var_00);
  lib_04FF::func_6963("reloadTime", 7);
  lib_04FF::func_6963("gunDamage", 1000);
  lib_04FF::func_6965("health", 3000);
  var_01 = func_4376("gun");
  func_6672(var_01[0]);
  lib_04FF::func_6983(self.var_695A);
  thread func_666E();
  var_02 = self.var_A2C8;
  var_03 = getvehiclenode(var_02.var_1A2, "targetname");
  var_02 startpath(var_03);
  var_02 setCanDamage(1);
  var_02 lib_04FF::func_990(self.var_A2C8, "tag_body", (0, 0, 120), 30000, 22, 0, 1, 0, 1, 0, []);
  var_02 waittill("neutralized");
  foreach(var_05 in self.var_48F4) {
    var_05.var_2563 maps\mp\gametypes\_gameobjects::func_2D58();
  }

  func_6679();
}

func_6672(param_00) {
  var_01 = [];
  for(var_02 = param_00; isDefined(var_02); var_02 = var_02 common_scripts\utility::func_4375()) {
    var_01[var_01.size] = var_02;
    if(!isDefined(var_02.var_1A2)) {
      break;
    }
  }

  foreach(var_02 in var_01) {
    func_8A03(var_02);
  }

  self.var_48F4 = var_01;
}

func_8A03(param_00) {
  param_00.var_29BF = 0;
  param_00 setCanDamage(1);
  param_00 setdamagecallbackon(1);
  param_00.var_29B5 = ::func_9F7C;
  param_00.var_566B = 1;
  param_00 thread func_9F8D();
  var_01 = lib_04FF::func_27DE(param_00 getentitynumber(), game["defenders"], param_00.var_116, (0, 0, 60));
  var_01 maps\mp\gametypes\_gameobjects::func_8A60("none");
  var_01 maps\mp\gametypes\_gameobjects::func_860A("friendly", "waypoint_defend");
  var_01 maps\mp\gametypes\_gameobjects::func_860E("friendly", "waypoint_defend");
  var_01 maps\mp\gametypes\_gameobjects::func_860A("enemy", "waypoint_capture");
  var_01 maps\mp\gametypes\_gameobjects::func_860E("enemy", "waypoint_capture");
  param_00.var_2563 = var_01;
}

func_666E() {
  level endon(lib_04FF::func_6937(self.var_695A));
  for(var_00 = 0; var_00 < self.var_48F4.size; var_00++) {
    var_01 = self.var_48F4[var_00];
    var_01.var_2563 maps\mp\gametypes\_gameobjects::func_8A60("any");
    var_01 waittill("destroyed");
    var_01.var_2563 maps\mp\gametypes\_gameobjects::func_8A60("none");
  }
}

func_6675(param_00, param_01) {
  var_02 = param_01 common_scripts\utility::func_41F1();
  param_00 startpath(var_02);
}

func_6676(param_00, param_01) {
  var_02 = param_01 common_scripts\utility::func_41EC();
  if(!common_scripts\utility::func_562E(var_02.var_566B)) {
    var_03 = param_01 common_scripts\utility::func_41F1();
    param_00 startpath(var_03);
  }
}

func_667B(param_00, param_01) {
  level endon("tank_retaliate");
  for(;;) {
    if(!isDefined(param_01)) {
      break;
    }

    if(!param_00 func_97E2(param_01)) {
      break;
    }

    wait 0.05;
  }

  param_00 method_8293(lib_04FF::func_45D0("accel"));
}

func_9F8D() {
  self endon("destroyed");
  var_00 = undefined;
  for(;;) {
    self waittill("turretownerchange", var_01);
    if(!isDefined(var_01) && isDefined(var_00)) {
      var_00 func_73D2();
      var_00 = undefined;
      continue;
    }

    var_01 thread func_747A(self);
    var_00 = var_01;
  }
}

func_747A(param_00) {
  self notify("playerTurretHud");
  self endon("playerTurretHud");
  var_01 = param_00 method_856E();
  var_02 = param_00 method_8686();
  var_03 = maps\mp\gametypes\_hud_util::func_27CF((0, 1, 0), 120, 9);
  var_03 maps\mp\gametypes\_hud_util::func_8707("CENTER", undefined, 0, 61);
  self.var_9F95 = var_03;
  if(var_02 > 0) {
    var_04 = 1 - var_02 / var_01;
    func_747B(var_03, var_04, var_02);
  } else {
    var_03.var_1586 setshader(var_03.var_1586.var_8AC7, var_03.var_1D2, var_03.var_BD);
  }

  for(;;) {
    param_00 waittill("turret_fire");
    func_747B(var_03, 0, var_01);
  }
}

func_747B(param_00, param_01, param_02) {
  param_00.var_1586.var_56 = (1, 0, 0);
  var_03 = int(param_00.var_1D2 * param_01);
  param_00.var_1586 setshader(param_00.var_1586.var_8AC7, var_03, param_00.var_BD);
  param_00.var_1586 scaleovertime(param_02, param_00.var_1D2, param_00.var_BD);
  wait(param_02);
  param_00.var_1586.var_56 = (0, 1, 0);
}

func_73D2() {
  self notify("playerTurretHud");
  if(isDefined(self.var_9F95)) {
    self.var_9F95 maps\mp\gametypes\_hud_util::func_2DCC();
  }
}

func_667D() {
  lib_04FF::func_6965("health", 3000);
  lib_04FF::func_6963("reloadTime", 7);
  lib_04FF::func_6983(self.var_695A);
  var_00 = self.var_A2C8;
  var_01 = getvehiclenode(var_00.var_1A2, "targetname");
  var_00 startpath(var_01);
}