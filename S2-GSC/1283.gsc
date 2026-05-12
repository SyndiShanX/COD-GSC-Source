/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: 1283.gsc
*********************************************/

func_5282() {
  level.var_79F0 = [];
  level.var_79F9 = [];
  level.var_79F9["ger_apc_sdkfz10_halftrack_mp"] = [];
  level.var_79F9["ger_apc_sdkfz10_halftrack_mp"]["turretWeapon"] = "turretweapon_ger_btry_flak38_mp";
  level.var_79F9["ger_apc_sdkfz10_halftrack_mp"]["model"] = "ger_btry_flak38_turret_gun";
  level.var_79F9["ger_apc_sdkfz10_halftrack_mp"]["tag"] = "tag_turret";
  level.var_79F9["ger_apc_sdkfz10_halftrack_mp"]["AIEnabled"] = 1;
  level.var_79F9["usa_apc_halftrack_mp"] = [];
  level.var_79F9["usa_apc_halftrack_mp"]["turretWeapon"] = "turretweapon_50cal_raid_mp";
  level.var_79F9["usa_apc_halftrack_mp"]["model"] = "turret_npc_usa_browning_50cal_tripod";
  level.var_79F9["usa_apc_halftrack_mp"]["tag"] = "tag_turret";
  level.var_79F9["usa_apc_halftrack_mp"]["AIEnabled"] = 1;
  level.var_79F9["usa_tank_sherman_mp"] = [];
  level.var_79F9["usa_tank_sherman_mp"]["turretWeapon"] = "turretweapon_tank_sherman_mp";
  level.var_79F9["usa_tank_sherman_mp"]["model"] = "usa_tank_sherman_coax_turret";
  level.var_79F9["usa_tank_sherman_mp"]["tag"] = "tag_turret_attach";
  level.var_79F9["usa_tank_sherman_mp"]["AIEnabled"] = 1;
  level.var_79F9["usa_tank_sherman_player"] = [];
  level.var_79F9["usa_tank_sherman_player"]["turretWeapon"] = "turretweapon_tank_sherman_mp";
  level.var_79F9["usa_tank_sherman_player"]["model"] = "usa_tank_sherman_coax_turret";
  level.var_79F9["usa_tank_sherman_player"]["tag"] = "tag_turret_attach";
  level.var_79F9["usa_tank_sherman_player"]["AIEnabled"] = 1;
  level.var_79F9["usa_tank_sherman_player_mp"] = level.var_79F9["usa_tank_sherman_player"];
  level.var_79F9["ger_tank_panzer_4_player_mp"]["turretWeapon"] = "turretweapon_tank_sherman_mp";
  level.var_79F9["ger_tank_panzer_4_player_mp"]["model"] = "ger_tank_panzer_iv_turret_mg";
  level.var_79F9["ger_tank_panzer_4_player_mp"]["tag"] = "TAG_TURRET_2";
  level.var_79F9["ger_tank_panzer_4_player_mp"]["AIEnabled"] = 1;
  level.var_79F9["ger_tank_king_tiger_mp"] = [];
  level.var_79F9["ger_tank_king_tiger_mp"]["turretWeapon"] = undefined;
  level.var_79F9["ger_tank_king_tiger_mp"]["model"] = undefined;
  level.var_79F9["ger_tank_king_tiger_mp"]["tag"] = undefined;
  level.var_79F9["ger_tank_king_tiger_mp"]["AIEnabled"] = 0;
  level.var_79F9["usa_fighter_thunderbolt_mp"] = [];
  level.var_79F9["usa_fighter_thunderbolt_mp"]["turretWeapon"] = undefined;
  level.var_79F9["usa_fighter_thunderbolt_mp"]["model"] = undefined;
  level.var_79F9["usa_fighter_thunderbolt_mp"]["tag"] = undefined;
  level.var_79F9["usa_fighter_thunderbolt_mp"]["AIEnabled"] = 0;
  level.var_79F9["ger_fighter_bf109_mp"] = [];
  level.var_79F9["ger_fighter_bf109_mp"]["turretWeapon"] = undefined;
  level.var_79F9["ger_fighter_bf109_mp"]["model"] = undefined;
  level.var_79F9["ger_fighter_bf109_mp"]["tag"] = undefined;
  level.var_79F9["ger_fighter_bf109_mp"]["AIEnabled"] = 0;
  level.var_79F4 = [];
  level.var_79F4["ger_apc_sdkfz10_halftrack_mp"] = 0;
  level.var_79F4["jeep_player_mp"] = 1;
  level.var_79F4["usa_apc_halftrack_mp"] = 0;
  level.var_79F4["usa_tank_sherman_mp"] = 0;
  level.var_79F4["usa_tank_sherman_player"] = 0;
  level.var_79F4["ger_tank_king_tiger_mp"] = 0;
  level.var_79F4["usa_fighter_thunderbolt_mp"] = 0;
  level.var_79F4["ger_fighter_bf109_mp"] = 0;
}

func_2838(param_00, param_01, param_02, param_03, param_04, param_05) {
  var_06 = param_00.var_1A5;
  if(!isDefined(var_06)) {
    var_06 = "UNDEFINED";
  }

  var_07 = undefined;
  if(common_scripts\utility::func_562E(param_00.use_original_classname)) {
    var_07 = param_00 method_8225();
  } else if(isDefined(param_05) && isPlayer(param_05)) {
    var_07 = function_01E0(param_00.var_106, var_06, param_00.var_1C8, param_00.var_116, param_00.var_1D, param_05);
  } else {
    var_07 = function_01E0(param_00.var_106, var_06, param_00.var_1C8, param_00.var_116, param_00.var_1D);
  }

  var_07.var_1C8 = param_00.var_1C8;
  var_07.var_FB = 9000;
  var_07.var_BC = 9000;
  var_07.var_6A = 0;
  var_07 setCanDamage(0);
  if(common_scripts\utility::func_562E(level.var_79F4[param_00.var_1C8])) {
    var_07 func_A300();
  }

  if(isDefined(param_01)) {
    var_07 method_8253(param_01);
    var_07.var_1A7 = param_01;
  } else {
    var_07 method_8253("axis");
    var_07.var_1A7 = "axis";
  }

  var_08 = level.var_79F0[param_00.var_1C8];
  if(isDefined(var_08)) {
    var_07.var_3400 = var_07 func_1D62(var_08["turretWeapon"], var_08["model"], var_08["tag"]);
  }

  var_09 = level.var_79F9[param_00.var_1C8];
  if(isDefined(var_09)) {
    var_07.var_835F = var_07 func_1D62(var_09["turretWeapon"], var_09["model"], var_09["tag"]);
    var_07.var_835F.var_5C04 = 0;
    var_07.var_5C03 = 0;
  }

  var_07 thread func_A334();
  var_07 thread func_A333();
  if(param_02) {
    if(!isDefined(param_04) || !param_04) {
      var_07 makeusable();
    }

    var_0A = var_07 method_8564();
    if(var_0A != "plane") {
      var_07 thread func_A90D();
    }

    if(isDefined(var_07.var_835F)) {
      var_07.var_835F thread last_stand_player_down_slide();
    }
  } else {
    if(var_07 method_85C3() != "none" || isDefined(var_07.var_3400) || isDefined(var_07.var_835F)) {
      var_07 thread func_9F8F();
      if(var_07 method_85C3() != "none") {
        var_07 thread func_A3FF();
      }

      if(isDefined(var_07.var_3400) && var_08["AIEnabled"]) {
        var_07.var_3400 thread func_9F9C();
      }

      if(isDefined(var_07.var_835F) && var_09["AIEnabled"]) {
        var_07.var_835F thread func_9F9C();
      }
    }

    var_07.var_A3F8 = func_A3EE(param_00.var_1A2);
    if(param_03 == 1) {
      var_07 thread func_4816(5, 1);
    } else {
      var_07 thread func_4816(5, 0);
    }
  }

  if(var_07.var_1A7 == "axis") {
    if(!isDefined(level.var_148E)) {
      level.var_148E = [];
    }

    level.var_148E = common_scripts\utility::func_F6F(level.var_148E, var_07);
  }

  return var_07;
}

func_A3F3() {}

func_1D62(param_00, param_01, param_02, param_03) {
  var_04 = spawnturret("misc_turret", self gettagorigin(param_02), param_00, 0);
  var_04.maxhealth = param_00;
  var_04 setModel(param_01);
  if(!isDefined(param_03) || !param_03) {
    var_04.var_1D = self gettagangles(param_02);
    var_04 linkto(self, param_02, (0, 0, 0), (0, 0, 0));
    var_04 func_9F53();
    var_04 setmode("auto_nonai");
    var_04 method_80F9(undefined);
    var_04 method_8131();
    var_04 setdefaultdroppitchyaw(0);
  } else {
    var_04 method_8449(self, param_02, (0, 0, 0), (0, 0, 0));
    var_04 setCanDamage(0);
    var_04 setCanRadiusDamage(0);
    var_04 setmode("manual");
    var_04 setdefaultdroppitchyaw(-45, 0);
  }

  var_04.var_1A7 = self.var_1A7;
  var_04.var_12C["team"] = self.var_1A7;
  var_04.isbucket = param_03;
  if(level.var_984D) {
    var_04 method_8130(self.var_1A7);
  }

  var_04 method_80FB(0);
  var_04.var_6E7A = self;
  var_04.var_5DBC = 1;
  var_04.var_A2C8 = self;
  var_04 makeunusable();
  return var_04;
}

func_1D2F(param_00, param_01) {
  if(!isDefined(level.var_A37A)) {
    level.var_A37A = [];
  }

  if(!isDefined(level.var_A37A[self.var_1C8])) {
    level.var_A37A[self.var_1C8] = [];
  }

  level.var_A37A[self.var_1C8][param_00] = param_01;
}

func_A300() {
  func_1D2F("tag_windshield_glass", 2);
  func_1D2F("tag_windshield_area", 2);
  func_1D2F("tag_lt_wiper", 1);
  func_1D2F("tag_rt_wiper", 1);
  func_1D2F("tag_grill", 2);
  func_1D2F("tag_hood", 2);
  func_1D2F("tag_bumper_f", 2);
  func_1D2F("tag_subframe", 1);
  func_1D2F("tag_lt_wheel_f", 1);
  func_1D2F("tag_rt_wheel_f", 1);
  func_1D2F("tag_lt_wheel_k", 1);
  func_1D2F("tag_rt_wheel_k", 1);
  func_1D2F("tag_lt_headlight", 1);
  func_1D2F("tag_rt_headlight", 1);
  func_1D2F("tag_signal_light", 2);
  func_1D2F("tag_side_mirror", 2);
  func_1D2F("tag_lt_fender_f", 2);
  func_1D2F("tag_rt_fender_f", 2);
  func_1D2F("tag_lt_fender_k", 2);
  func_1D2F("tag_rt_fender_k", 2);
  if(!isDefined(level.var_A37A) || !isDefined(level.var_A37A[self.var_1C8])) {
    return;
  }

  if(!isDefined(self.var_29AC)) {
    self.var_29AC = [];
  }

  foreach(var_04, var_01 in level.var_A37A[self.var_1C8]) {
    if(!isDefined(self.var_29AC[var_04])) {
      self.var_29AC[var_04] = [];
    }

    self.var_29AC[var_04] = 0;
    for(var_02 = 1; var_02 <= var_01; var_02++) {
      var_03 = var_04 + var_02;
      self hidepart(var_03);
    }
  }
}

func_4466() {
  var_00 = (0, 0, 72);
  var_01 = (0, 0, 60);
  var_02 = (0, 0, 40);
  if(level.var_744A.size == 0) {
    return undefined;
  }

  var_03 = [];
  var_04 = [];
  foreach(var_06 in level.var_744A) {
    if(!var_06.var_CE && var_06.var_178 != "spectator") {
      var_04[var_04.size] = var_06;
    }

    if(isDefined(var_06.var_9EDD) && !var_06.var_56A3 && isDefined(var_06.var_9EDD.var_6A) && var_06.var_9EDD.var_6A < var_06.var_9EDD.var_FB) {
      var_03[var_03.size] = var_06.var_9EDD;
    }

    if(isDefined(var_06.var_A2E)) {
      var_03[var_03.size] = var_06.var_A2E;
    }
  }

  var_08 = 500000000;
  var_09 = undefined;
  foreach(var_06 in var_04) {
    var_0B = distancesquared(var_06.var_116, self.var_116);
    if(var_0B < var_08) {
      if(sighttracepassed(var_06.var_116 + var_00, self.var_116 + var_01, 0, self)) {
        var_08 = var_0B;
        var_09 = var_06;
      }
    }
  }

  if(isDefined(var_09)) {
    return var_09;
  }

  var_08 = 500000000;
  foreach(var_0E in var_03) {
    var_0B = distancesquared(var_0E.var_116, self.var_116);
    if(var_0B < var_08) {
      var_0F = var_0E.var_116;
      if(isDefined(var_0E.var_57C4) && var_0E.var_57C4) {
        var_0F = var_0F + var_02;
      }

      if(sighttracepassed(var_0F, self.var_116 + var_02, 0, self, var_0E)) {
        var_08 = var_0B;
        var_09 = var_0E;
      }
    }
  }

  return var_09;
}

func_9F8F() {
  self endon("death");
  level endon("game_ended");
  for(;;) {
    var_00 = func_4466();
    if(!isDefined(self.var_A6EE) && isDefined(var_00)) {
      if(self method_85C3() != "none") {
        self method_825C(var_00, (0, 0, 0));
      }

      self.var_9828 = var_00;
    } else {
      if(self method_85C3() != "none") {
        self method_825D();
      }

      self.var_9828 = undefined;
    }

    wait(0.1);
  }
}

func_9F9C() {
  self endon("death");
  level endon("game_ended");
  for(;;) {
    if(isDefined(self.var_6E7A.var_9828)) {
      var_00 = self gettagorigin("TAG_AIM");
      var_01 = self gettagangles("TAG_AIM");
      var_02 = anglesToForward(var_01);
      var_03 = vectornormalize(self.var_6E7A.var_9828.var_116 - var_00);
      var_04 = vectordot(var_02, var_03);
      if(var_04 > 0.9) {
        self method_80D5();
      } else {
        self method_80D6();
      }
    } else {
      self method_80D6();
    }

    wait 0.05;
  }
}

func_A3FF() {
  self endon("death");
  level endon("game_ended");
  for(;;) {
    if(isDefined(self.var_9828) && self method_8222()) {
      var_00 = self gettagorigin("TAG_AIM");
      var_01 = self gettagangles("TAG_AIM");
      var_02 = anglesToForward(var_01);
      var_03 = vectornormalize(self.var_9828.var_116 - var_00);
      var_04 = vectordot(var_02, var_03);
      if(var_04 > 0.9) {
        self method_8263();
      }
    }

    wait 0.05;
  }
}

func_A334() {
  self endon("death");
  level endon("game_ended");
  for(;;) {
    self waittill("vehicle_mount", var_00);
    if(isDefined(var_00) && isDefined(var_00.var_1A7)) {
      common_scripts\utility::func_5FA9(var_00.var_1A7);
    }
  }
}

func_A333() {
  self endon("death");
  level endon("game_ended");
  for(;;) {
    self waittill("vehicle_dismount", var_00);
    if(isDefined(self.var_835F)) {
      var_01 = self.var_835F method_80E2();
      if(isDefined(var_01)) {
        continue;
      }
    }

    self freeentitysentient();
  }
}

func_9F53() {
  self.var_29B5 = ::func_9F28;
  self setCanDamage(1);
  self setdamagecallbackon(1);
}

func_9F28(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A, param_0B) {
  self.var_6E7A notify("damage", param_02, param_01, param_07, param_06, param_04, undefined, undefined, param_0B, param_03, param_05);
}

func_A3EE(param_00) {
  param_00 = getent(param_00, "targetname");
  var_01 = [param_00];
  var_02 = param_00;
  for(;;) {
    if(isDefined(var_02.var_1A2)) {
      var_03 = getent(var_02.var_1A2, "targetname");
      var_01[var_01.size] = var_03;
      var_02 = var_03;
      continue;
    }

    break;
  }

  return var_01;
}

func_4816(param_00, param_01) {
  level endon("game_ended");
  self endon("stop_path");
  self endon("death");
  if(!isDefined(param_01)) {
    param_01 = 0;
  }

  for(var_02 = 0; var_02 < self.var_A3F8.size; var_02++) {
    self.var_66CA = self.var_A3F8[var_02];
    self method_8224(self.var_66CA.var_116, param_00);
    while(distance2d(self.var_116, self.var_66CA.var_116) > 64) {
      wait 0.05;
    }
  }

  if(param_01) {
    thread func_4816(param_00, 1);
    return;
  }

  self method_8280(0, 10, 10);
}

func_A90D() {
  level endon("game_ended");
  var_00 = "";
  while(var_00 != "death") {
    var_01 = undefined;
    if(!isDefined(self method_8251())) {
      var_02 = common_scripts\utility::func_A717("vehicle_mount", "turret_mount_from_ground", "death");
      var_00 = var_02[0];
      if(var_00 == "death") {
        return;
      }

      var_01 = var_02[1];
    } else {
      var_00 = "vehicle_mount_from_gunner";
      var_01 = self method_8251();
    }

    if(var_00 == "vehicle_mount") {
      if(self method_85C3() != "none") {
        if(isDefined(level.vehicleweapon_fire_mode) && level.vehicleweapon_fire_mode == "SCRIPT") {
          thread last_stand_weapons();
        }
      }

      if(isDefined(self.var_3400)) {
        self.var_3400.var_117 = var_01;
        self.var_3400 useby(var_01);
      }

      if(isDefined(self.var_835F)) {
        if(common_scripts\utility::func_562E(self.var_835F.isbucket)) {
          var_01 lib_0502::replacehintstringclient(&"RAIDS_USE_TANK_MG_FROM_GROUND", &"RAIDS_USE_TANK_MG_FROM_DRIVER");
        } else {
          self.var_835F makeusable();
        }

        var_01 notifyonplayercommand("switch_seats_driver", "-actionslot 2");
        var_01 thread func_A912(self);
      }

      if(!function_01EF(var_01)) {
        var_01 method_8003();
      }

      var_01 setangles((15, self.var_1D[1], 0));
      if(isDefined(self.mountcallback)) {
        self[[self.mountcallback]](var_01);
      }

      var_00 = common_scripts\utility::func_A715("vehicle_dismount", "death");
      if(!isDefined(var_01) && !isDefined(self)) {
        return;
      }

      if(isDefined(self.dismountcallback)) {
        self[[self.dismountcallback]](var_01);
      }
    }

    if(!isDefined(self.var_9567)) {
      if(isDefined(self.var_3400) && !common_scripts\utility::func_562E(self.var_835F.isbucket)) {
        self.var_3400.var_117 = undefined;
        var_01 method_80E0(self.var_3400);
      }

      if(!function_01EF(var_01)) {
        var_01 method_8004();
      }

      if(isDefined(self.var_835F)) {
        self notify("kill_switch_seats_driver");
      }
    } else {
      self.var_9567 = undefined;
      if(common_scripts\utility::func_562E(self.var_835F.isbucket)) {
        var_01 method_8004();
      }
    }

    if(isDefined(self.var_835F)) {
      if(common_scripts\utility::func_562E(self.var_835F.isbucket)) {
        var_01 lib_0502::replacehintstringclient(&"RAIDS_USE_TANK_MG_FROM_GROUND", undefined);
        continue;
      }

      self.var_835F makeunusable();
      var_01 notifyonplayercommandremove("switch_seats_driver", "-actionslot 2");
    }
  }
}

last_stand_player_down_slide() {
  self endon("end_watchForSecondPlayerUsage");
  level endon("game_ended");
  var_00 = "";
  var_01 = undefined;
  while(var_00 != "death") {
    var_00 = common_scripts\utility::func_A715("turretownerchange", "death");
    if(isalive(self)) {
      var_02 = self method_80E2();
    } else {
      var_02 = undefined;
    }

    if(isDefined(var_01)) {
      if(!isDefined(self.var_9568)) {
        var_01 method_8004();
        self notify("kill_switch_seats_gunner");
      }

      var_01 notifyonplayercommandremove("switch_seats_gunner", "-actionslot 2");
    }

    if(isDefined(var_02)) {
      if(!common_scripts\utility::func_562E(self.isbucket)) {
        var_02 method_8003();
      }

      var_02 notifyonplayercommand("switch_seats_gunner", "-actionslot 2");
      var_02 thread func_A913(self);
      if(isDefined(self.var_6E7A)) {
        self.var_6E7A common_scripts\utility::func_5FA9(var_02.var_1A7);
      }
    } else if(isDefined(self.var_6E7A)) {
      var_03 = self.var_6E7A method_8251();
      if(!isDefined(var_03)) {
        self.var_6E7A freeentitysentient();
      }
    }

    var_01 = var_02;
    self.var_9568 = undefined;
  }
}

func_A912(param_00) {
  level endon("game_ended");
  param_00 endon("death");
  param_00 endon("kill_switch_seats_driver");
  self waittill("switch_seats_driver");
  if(!0 && isDefined(param_00.var_835F method_80E2())) {
    thread func_A912(param_00);
    return;
  }

  while(isDefined(param_00.var_835F method_80E2()) && param_00.var_835F.var_5C04 < gettime() - 5000) {
    param_00.var_5C03 = gettime();
    self waittill("switch_seats_driver");
  }

  if(isDefined(param_00.var_835F method_80E2())) {
    var_01 = param_00.var_835F method_80E2();
    param_00 func_9538(self, param_00.var_835F method_80E2());
    param_00.var_835F notify("kill_switch_seats_gunner");
    return;
  }

  param_00.var_9567 = 1;
  self method_80F4();
  if(isDefined(param_00.var_3400)) {
    self method_80E0(param_00.var_3400);
  }

  param_00.var_835F useby(self);
  param_00.var_5C03 = 0;
  param_00.var_835F.var_5C04 = 0;
  waittillframeend;
  if(isDefined(param_00.var_835F.mountcallback)) {
    param_00.var_835F[[param_00.var_835F.mountcallback]](self);
  }

  param_00.var_835F notify("turret_mount_from_driver", self);
}

func_A913(param_00) {
  level endon("game_ended");
  param_00 endon("death");
  param_00 endon("kill_switch_seats_gunner");
  self waittill("switch_seats_gunner");
  if(!0 && isDefined(param_00.var_6E7A method_8251())) {
    thread func_A913(param_00);
    return;
  }

  while(isDefined(param_00.var_6E7A method_8251()) && param_00.var_6E7A.var_5C03 < gettime() - 5000) {
    param_00.var_5C04 = gettime();
    self waittill("switch_seats_gunner");
  }

  if(isDefined(param_00.var_6E7A method_8251())) {
    param_00.var_6E7A func_9538(param_00.var_6E7A method_8251(), self);
    param_00.var_6E7A notify("kill_switch_seats_driver");
    return;
  }

  param_00.var_9568 = 1;
  self method_80E0(param_00);
  waittillframeend;
  self method_80F3(param_00.var_6E7A);
  self method_808C();
  param_00.var_5C04 = 0;
  param_00.var_6E7A.var_5C03 = 0;
  lib_0502::replacehintstringclient(&"RAIDS_USE_TANK_MG_FROM_GROUND", undefined);
}

func_9538(param_00, param_01) {
  self.var_9567 = 1;
  self.var_835F.var_9568 = 1;
  param_00 method_80F4();
  param_00 method_80E0(self.var_3400);
  param_01 method_80E0(self.var_835F);
  param_01 method_80F3(self);
  self.var_835F useby(param_00);
  self.var_5C03 = 0;
  self.var_835F.var_5C04 = 0;
}

last_stand_weapons() {
  level endon("game_ended");
  self endon("vehicle_dismount");
  self endon("death");
  for(;;) {
    self waittill("turret_fire");
    self method_8263();
  }
}

initscriptedtanktargeting() {
  if(!isDefined(level.var_A3FB)) {
    level.var_A3FB = [];
  }

  level.var_A3FB["aimAtTarget"] = ::func_9784;
  level.var_A3FB["fireAtTarget"] = ::func_97B9;
}

func_9784(param_00, param_01) {
  var_02 = param_00;
  if(isDefined(param_01)) {
    var_02 = param_01;
  }

  if(!isDefined(self.var_B70)) {
    self.var_B70 = [];
    thread func_9785();
  }

  if(self.var_1C7 == "reverse") {
    if(self.var_B70.size > 0 && self.var_B70[self.var_B70.size - 1] == var_02) {
      self.var_B70 = common_scripts\utility::func_F9A(self.var_B70, self.var_B70.size - 1);
      self notify("tank_aim_update");
      return;
    }

    return;
  }

  self.var_B70[self.var_B70.size] = var_02;
  self notify("tank_aim_update");
}

func_9785() {
  self endon("death");
  for(;;) {
    self waittill("tank_aim_update");
    if(isDefined(self.var_3BD5)) {
      self.var_9734 = 0;
      continue;
    }

    if(self.var_B70.size == 0) {
      self.var_9734 = 0;
      continue;
    }

    var_00 = self.var_B70[self.var_B70.size - 1];
    if(var_00 == "" || var_00 == "none") {
      self.var_9734 = 0;
      continue;
    }

    if(var_00 == "clear") {
      self.var_9734 = 0;
      self method_825D();
      continue;
    }

    var_01 = common_scripts\utility::func_46B5(var_00, "script_linkname");
    if(!isDefined(var_01)) {
      self.var_9734 = 0;
      continue;
    }

    self.var_9734 = 1;
    self method_825B(var_01.var_116);
  }
}

func_97B9(param_00, param_01) {
  var_02 = param_01;
  if(!isDefined(level.var_4B9C)) {
    level.var_4B9C = [];
  }

  if(isDefined(level.var_4B9C[var_02])) {
    return;
  }

  level.var_4B9C[var_02] = 1;
  if(!isDefined(self.var_3C3A)) {
    self.var_3C3A = [];
  }

  self.var_3C3A[self.var_3C3A.size] = var_02;
  thread func_97C3();
}

func_97C3() {
  var_00 = 1;
  var_01 = 0.1;
  var_02 = 1;
  self endon("death");
  var_03 = self.var_1C8 == "ger_tank_king_tiger_mp_snow";
  if(self.var_3C3A.size == 0) {
    self.var_3BD5 = undefined;
    self method_825D();
    self notify("tank_aim_update");
    return;
  }

  if(isDefined(self.var_3BD5)) {
    return;
  }

  var_04 = self.var_3C3A[0];
  self.var_3C3A = common_scripts\utility::func_F9A(self.var_3C3A, 0);
  var_05 = common_scripts\utility::func_46B5(var_04, "script_linkname");
  if(!isDefined(var_05)) {
    thread func_97C3();
    return;
  }

  self.var_3BD5 = var_04;
  self.var_9734 = 1;
  self method_825B(var_05.var_116);
  var_06 = undefined;
  if(var_03) {
    var_06 = lib_04F3::func_79CC("tiger_turret_spin_lp", self);
  }

  while(!func_57FA(var_05.var_116)) {
    wait 0.05;
  }

  if(var_03) {
    lib_04F3::func_79D0(var_06, 0.05);
    lib_04F3::func_79CC("tiger_turret_stop", self);
  }

  wait(var_00);
  func_3C22(self);
  wait(var_01);
  if(isDefined(level.tanktargethitfunc)) {
    level thread[[level.tanktargethitfunc]](var_04);
  }

  wait(var_02);
  self.var_3BD5 = undefined;
  self.var_9734 = 0;
  if(var_03) {
    var_06 = lib_04F3::func_79CC("tiger_turret_spin_lp", self);
    maps\mp\_utility::func_2CED(1.8, ::lib_04F3::func_79D0, var_06, 0.05);
    maps\mp\_utility::func_2CED(1.8, ::lib_04F3::func_79CC, "tiger_turret_stop", self);
  }

  thread func_97C3();
}

func_57FA(param_00) {
  var_01 = self gettagorigin("tag_flash");
  var_02 = param_00 - var_01;
  var_02 = vectornormalize(var_02);
  var_03 = self gettagangles("tag_flash");
  var_03 = anglesToForward(var_03);
  if(vectordot(var_02, var_03) > 0.99) {
    return 1;
  }

  return 0;
}

func_3C22(param_00) {
  playFXOnTag(common_scripts\utility::func_44F5("us_tank_sherman_muzzle"), param_00, "tag_flash");
  param_00 method_8263();
}

bomber_healthbar_update(param_00, param_01) {
  if(isPlayer(param_00)) {
    var_02 = param_01 getentitynumber();
    if(!isDefined(param_00.lasttarget) || var_02 != param_00.lasttarget) {
      param_00 notify("bomber_target_changed");
      param_00 setclientomnvar("ui_raid_vehicle_target_ent_num", var_02);
      param_00.lasttarget = var_02;
      param_00.lasttargethealth = undefined;
      thread watch_bomber_health(param_00, param_01);
    }

    param_00 notify("bomber_damage_dealt");
    thread watch_player_target_timeout(param_00, param_01);
  }
}

watch_bomber_health(param_00, param_01) {
  param_00 endon("death");
  param_00 endon("disconnect");
  param_00 endon("bomber_target_changed");
  for(;;) {
    if(!isDefined(param_01)) {
      return;
    }

    var_02 = param_01.var_BC / param_01.var_FB;
    if(var_02 < 0) {
      var_02 = 0;
    }

    if(!isDefined(param_00.lasttargethealth) || abs(param_00.lasttargethealth - var_02) >= 0.01) {
      param_00.lasttargethealth = var_02;
      param_00 setclientomnvar("ui_raid_vehicle_target_health_percent", var_02);
    }

    if(param_01.var_BC <= 0) {
      return;
    }

    wait 0.05;
  }
}

watch_player_target_timeout(param_00, param_01) {
  param_00 endon("death");
  param_00 endon("disconnect");
  param_00 endon("bomber_target_changed");
  param_00 endon("bomber_damage_dealt");
  wait(5);
  clear_player_target(param_00);
}

clear_player_target(param_00) {
  param_00.lasttarget = undefined;
  param_00.lasttargethealth = undefined;
  param_00 setclientomnvar("ui_raid_vehicle_target_ent_num", -1);
}