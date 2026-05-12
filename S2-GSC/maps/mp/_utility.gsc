/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\_utility.gsc
*********************************************/

func_3941() {
  if(isDefined(self.var_0161)) {
    wait(self.var_0161);
  }

  self method_8617(level.var_80D2[self.var_828A]);
}

func_05D4(param_00, param_01, param_02, param_03, param_04, param_05) {
  self endon("location_selection_complete");
  self endon("stop_location_selection");
  if(isDefined(level.var_6465)) {
    self setscriptmotionblurparams(0, level.var_6465["cameraRotationInfluence"], level.var_6465["cameraTranslationInfluence"]);
  }

  thread func_36E6("cancel_location");
  thread func_36E6("death");
  thread func_36E6("disconnect");
  thread func_36E6("used");
  thread func_36E6("weapon_change");
  thread func_36E8();
  thread func_36E7();
  thread func_36E5();
  thread func_A6AA();
  var_06 = 1;
  if(isDefined(param_05) && param_05) {
    var_06 = 2;
  }

  var_07 = int(tablelookup("mp/killstreakTable.csv", 1, param_00, 0));
  self setclientomnvar("ui_map_location_selector_streak_index", var_07);
  self setclientomnvar("ui_map_location_selector", var_06);
  if(param_02) {
    var_08 = 1;
  } else {
    var_08 = 0;
  }

  switch (param_00) {
    case "firebomb":
      var_08 = 2;
      break;
  }

  self setclientomnvar("ui_map_location_selector_directional_type", var_08);
  if(isDefined(param_04)) {
    wait(param_04);
  }

  self method_8320(param_01, param_02, param_03);
  self.var_83AF = 1;
  self luinotifyevent(&"streak_targeting_started", 0);
  self setblurforplayer(10.3, 0.3);
}

func_0618(param_00) {
  if(!param_00) {
    self setclientomnvar("ui_map_location_selector", 0);
    self setclientomnvar("ui_map_location_selector_directional_type", 0);
    self setclientomnvar("ui_map_location_selector_streak_index", 0);
    self setclientomnvar("ui_map_location_num_planes", 0);
    self setclientomnvar("ui_map_location_fighter_strike", 0);
    self setblurforplayer(0, 0.3);
    self method_8321();
    self.var_83AF = undefined;
    if(isDefined(level.var_6465)) {
      self setscriptmotionblurparams(level.var_6465["velocityscaler"], level.var_6465["cameraRotationInfluence"], level.var_6465["cameraTranslationInfluence"]);
    }
  }
}

func_A6AA() {
  self endon("stop_location_selection");
  self waittill("location_selection_complete");
  func_0618(0);
}

func_940B(param_00, param_01) {
  if(!isDefined(param_01)) {
    param_01 = "generic";
  }

  func_0618(param_00);
  self notify("stop_location_selection", param_01);
}

func_36E7() {
  self endon("location_selection_complete");
  self endon("stop_location_selection");
  for(;;) {
    level waittill("emp_update");
    if(!func_56D7()) {
      continue;
    }

    func_940B(0, "emp");
  }
}

func_36E6(param_00, param_01) {
  self endon("location_selection_complete");
  self endon("stop_location_selection");
  if(!isDefined(param_01)) {
    param_01 = 1;
  }

  while(param_01 > 0) {
    self waittill(param_00);
    param_01--;
  }

  func_940B(param_00 == "disconnect", param_00);
}

func_36E8() {
  self endon("location_selection_complete");
  self endon("stop_location_selection");
  level waittill("game_ended");
  func_940B(0, "end_game");
}

func_36E5() {
  self endon("location_selection_complete");
  self endon("stop_location_selection");
  level waittill("host_migration_begin");
  func_940B(0, "hostmigrate");
}

func_5679(param_00) {
  var_01 = tablelookup("mp/attachmenttable.csv", 3, param_00, 0);
  if(isDefined(var_01) && var_01 != "") {
    return 1;
  }

  return 0;
}

func_4429(param_00) {
  var_01 = tablelookup("mp/attachmenttable.csv", 3, param_00, 1);
  return var_01;
}

isproductionlevelactive(param_00) {
  var_01 = getdvarint("6024", 23);
  return var_01 >= param_00;
}

productionlevelindextostring(param_00) {
  switch (param_00) {
    case 0:
      return "NOTSET";

    case 1:
      return "GOLD";

    case 2:
      return "TU1";

    case 3:
      return "TU2";

    case 4:
      return "TU3";

    case 5:
      return "CP";

    case 6:
      return "MTX1";

    case 7:
      return "MTX2";

    case 8:
      return "DLC1";

    case 9:
      return "MTX3";

    case 10:
      return "MTX3_5";

    case 11:
      return "MTX4";

    case 12:
      return "DLC2";

    case 13:
      return "MTX5";

    case 14:
      return "MTX6";

    case 15:
      return "DLC3";

    case 16:
      return "MTX7";

    case 17:
      return "MTX8";

    case 18:
      return "DLC4";

    case 19:
      return "MTX9";

    case 20:
      return "MTX10";

    case 21:
      return "MTX11";

    case 22:
      return "MTX12";

    case 23:
      return "ALL";

    case 24:
      return "NEVER";
  }
}

productionlevelstringtoindex(param_00) {
  switch (tolower(param_00)) {
    case "notset":
    case "":
      return 0;

    case "gold":
      return 1;

    case "tu1":
      return 2;

    case "tu2":
      return 3;

    case "tu3":
      return 4;

    case "cp":
      return 5;

    case "mtx1":
      return 6;

    case "mtx2":
      return 7;

    case "dlc1":
      return 8;

    case "mtx3":
      return 9;

    case "mtx3_5":
      return 10;

    case "mtx4":
      return 11;

    case "dlc2":
      return 12;

    case "mtx5":
      return 13;

    case "mtx6":
      return 14;

    case "dlc3":
      return 15;

    case "mtx7":
      return 16;

    case "mtx8":
      return 17;

    case "dlc4":
      return 18;

    case "mtx9":
      return 19;

    case "mtx10":
      return 20;

    case "mtx11":
      return 21;

    case "mtx12":
      return 22;

    case "all":
      return 23;

    case "never":
      return 24;
  }
}

productionlevelstringtouidvarbool(param_00) {
  switch (tolower(param_00)) {
    case "notset":
    case "":
      return 1;

    case "gold":
      return 1;

    case "tu1":
      return 1;

    case "tu2":
      return 1;

    case "tu3":
      return 1;

    case "cp":
      return 1;

    case "mtx1":
      return getdvarint("5955") == 1;

    case "mtx2":
      return getdvarint("5954") == 0;

    case "dlc1":
      return getdvarint("5953") == 0;

    case "mtx3":
      return getdvarint("mtx3_killswitch") == 0;

    case "mtx3_5":
      return getdvarint("mtx3_5_killswitch") == 0;

    case "mtx4":
      return getdvarint("mtx4_killswitch") == 0;

    case "dlc2":
      return getdvarint("dlc2_killswitch") == 0;

    case "mtx5":
      return getdvarint("mtx5_killswitch") == 0;

    case "mtx6":
      return getdvarint("mtx6_killswitch") == 0;

    case "dlc3":
      return getdvarint("dlc3_killswitch") == 0;

    case "mtx7":
      return getdvarint("mtx7_killswitch") == 0;

    case "mtx8":
      return getdvarint("mtx8_killswitch") == 0;

    case "dlc4":
      return getdvarint("dlc4_killswitch") == 0;

    case "mtx9":
      return getdvarint("mtx9_killswitch") == 0;

    case "mtx10":
      return getdvarint("mtx10_killswitch") == 0;

    case "mtx11":
      return getdvarint("mtx11_killswitch") == 0;

    case "mtx12":
      return getdvarint("mtx12_killswitch") == 0;

    case "all":
      return 0;

    case "never":
      return 0;
  }
}

func_2CED(param_00, param_01, param_02, param_03, param_04, param_05, param_06) {
  thread func_2CEF(param_01, param_00, param_02, param_03, param_04, param_05, param_06);
}

func_2CEF(param_00, param_01, param_02, param_03, param_04, param_05, param_06) {
  wait(param_01);
  if(!isDefined(param_02)) {
    thread[[param_00]]();
    return;
  }

  if(!isDefined(param_03)) {
    thread[[param_00]](param_02);
    return;
  }

  if(!isDefined(param_04)) {
    thread[[param_00]](param_02, param_03);
    return;
  }

  if(!isDefined(param_05)) {
    thread[[param_00]](param_02, param_03, param_04);
    return;
  }

  if(!isDefined(param_06)) {
    thread[[param_00]](param_02, param_03, param_04, param_05);
    return;
  }

  thread[[param_00]](param_02, param_03, param_04, param_05, param_06);
}

func_4617() {
  var_00 = self.var_0116 + (0, 0, 10);
  var_01 = 11;
  var_02 = anglesToForward(self.var_001D);
  var_02 = var_02 * var_01;
  var_03[0] = var_00 + var_02;
  var_03[1] = var_00;
  var_04 = bulletTrace(var_03[0], var_03[0] + (0, 0, -18), 0, undefined);
  if(var_04["fraction"] < 1) {
    var_05 = spawnStruct();
    var_05.var_0116 = var_04["position"];
    var_05.var_001D = func_6C3A(var_04["normal"]);
    return var_05;
  }

  var_04 = bulletTrace(var_03[1], var_03[1] + (0, 0, -18), 0, undefined);
  if(var_04["fraction"] < 1) {
    var_05 = spawnStruct();
    var_05.var_0116 = var_04["position"];
    var_05.var_001D = func_6C3A(var_04["normal"]);
    return var_05;
  }

  var_03[2] = var_00 + (16, 16, 0);
  var_03[3] = var_00 + (16, -16, 0);
  var_03[4] = var_00 + (-16, -16, 0);
  var_03[5] = var_00 + (-16, 16, 0);
  var_06 = undefined;
  var_07 = undefined;
  for(var_08 = 0; var_08 < var_03.size; var_08++) {
    var_04 = bulletTrace(var_03[var_08], var_03[var_08] + (0, 0, -1000), 0, undefined);
    if(!isDefined(var_06) || var_04["fraction"] < var_06) {
      var_06 = var_04["fraction"];
      var_07 = var_04["position"];
    }
  }

  if(var_06 == 1) {
    var_07 = self.var_0116;
  }

  var_05 = spawnStruct();
  var_05.var_0116 = var_07;
  var_05.var_001D = func_6C3A(var_04["normal"]);
  return var_05;
}

func_6C3A(param_00) {
  var_01 = (param_00[0], param_00[1], 0);
  var_02 = length(var_01);
  if(!var_02) {
    return (0, 0, 0);
  }

  var_03 = vectornormalize(var_01);
  var_04 = param_00[2] * -1;
  var_05 = (var_03[0] * var_04, var_03[1] * var_04, var_02);
  var_06 = vectortoangles(var_05);
  return var_06;
}

func_2D46(param_00) {
  var_01 = getEntArray(param_00, "classname");
  for(var_02 = 0; var_02 < var_01.size; var_02++) {
    var_01[var_02] delete();
  }
}

func_74D9(param_00, param_01, param_02) {
  if(level.var_910F) {
    if(isDefined(level.var_744A[0])) {
      level.var_744A[0] method_8615(param_00);
      return;
    }

    return;
  }

  if(isDefined(param_01)) {
    if(isDefined(param_02)) {
      for(var_03 = 0; var_03 < level.var_744A.size; var_03++) {
        var_04 = level.var_744A[var_03];
        if(var_04 issplitscreenplayer() && !var_04 method_82ED()) {
          continue;
        }

        if(isDefined(var_04.var_012C["team"]) && var_04.var_012C["team"] == param_01 && !func_56E0(var_04, param_02)) {
          var_04 method_8615(param_00);
        }
      }

      return;
    }

    for(var_03 = 0; var_03 < level.var_744A.size; var_03++) {
      var_04 = level.var_744A[var_03];
      if(var_04 issplitscreenplayer() && !var_04 method_82ED()) {
        continue;
      }

      if(isDefined(var_04.var_012C["team"]) && var_04.var_012C["team"] == param_01) {
        var_04 method_8615(param_00);
      }
    }

    return;
  }

  if(isDefined(param_02)) {
    for(var_03 = 0; var_03 < level.var_744A.size; var_03++) {
      var_04 = level.var_744A[var_03];
      if(var_04 issplitscreenplayer() && !var_04 method_82ED()) {
        continue;
      }

      if(!func_56E0(var_04, param_02)) {
        var_04 method_8615(param_00);
      }
    }

    return;
  }

  for(var_03 = 0; var_03 < level.var_744A.size; var_03++) {
    var_04 = level.var_744A[var_03];
    if(var_04 issplitscreenplayer() && !var_04 method_82ED()) {
      continue;
    }

    var_04 method_8615(param_00);
  }
}

func_74C3(param_00, param_01, param_02) {
  if(!function_0344(param_00)) {
    return;
  }

  var_03 = spawn("script_origin", (0, 0, 0));
  var_03 endon("death");
  thread common_scripts\utility::func_2D18(var_03);
  if(isDefined(param_02)) {
    var_03 method_805C();
    foreach(var_05 in param_02) {
      var_03 showtoclient(var_05);
    }
  }

  if(isDefined(param_01)) {
    var_03.var_0116 = self.var_0116 + param_01;
    var_03.var_001D = self.var_001D;
    var_03 method_8449(self);
  } else {
    var_03.var_0116 = self.var_0116;
    var_03.var_001D = self.var_001D;
    var_03 method_8449(self);
  }

  var_03 method_861D(param_00);
  self waittill("stop sound" + param_00);
  var_03 stoploopsound(param_00);
  var_03 delete();
}

func_8F25() {
  for(var_00 = 1; var_00 < self.var_5F2B.size; var_00++) {
    var_01 = self.var_5F2B[var_00];
    var_02 = var_01.var_7734;
    for(var_03 = var_00 - 1; var_03 >= 0 && var_02 > self.var_5F2B[var_03].var_7734; var_03--) {
      self.var_5F2B[var_03 + 1] = self.var_5F2B[var_03];
    }

    self.var_5F2B[var_03 + 1] = var_01;
  }
}

func_09C7(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08) {
  var_09 = undefined;
  foreach(var_0B in self.var_5F2B) {
    if(var_0B.var_0109 == param_00) {
      if(var_0B.var_991F == param_01 && var_0B.var_7734 == param_03) {
        return;
      }

      var_09 = var_0B;
      break;
    }
  }

  if(!isDefined(var_09)) {
    var_09 = spawnStruct();
    self.var_5F2B[self.var_5F2B.size] = var_09;
  }

  var_09.var_0109 = param_00;
  var_09.var_991F = param_01;
  var_09.var_99DA = param_02;
  var_09.var_09F6 = gettime();
  var_09.var_7734 = param_03;
  var_09.var_8C1E = param_04;
  var_09.var_8B91 = param_05;
  var_09.var_39CE = param_06;
  var_09.var_39CF = param_07;
  var_09.var_00C1 = param_08;
  func_8F25();
}

func_7CE9(param_00) {
  if(isDefined(self.var_5F2B)) {
    for(var_01 = self.var_5F2B.size; var_01 > 0; var_01--) {
      if(self.var_5F2B[var_01 - 1].var_0109 != param_00) {
        continue;
      }

      var_02 = self.var_5F2B[var_01 - 1];
      for(var_03 = var_01; var_03 < self.var_5F2B.size; var_03++) {
        if(isDefined(self.var_5F2B[var_03])) {
          self.var_5F2B[var_03 - 1] = self.var_5F2B[var_03];
        }
      }

      self.var_5F2B[self.var_5F2B.size - 1] = undefined;
    }

    func_8F25();
  }
}

func_4569() {
  return self.var_5F2B[0];
}

func_86C3(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08) {
  if(!isDefined(param_03)) {
    param_03 = 1;
  }

  if(!isDefined(param_02)) {
    param_02 = 0;
  }

  if(!isDefined(param_04)) {
    param_04 = 0;
  }

  if(!isDefined(param_05)) {
    param_05 = 0;
  }

  if(!isDefined(param_06)) {
    param_06 = 0.85;
  }

  if(!isDefined(param_07)) {
    param_07 = 3;
  }

  if(!isDefined(param_08)) {
    param_08 = 0;
  }

  func_09C7(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08);
  func_A131();
}

func_A131() {
  if(!isDefined(self.var_5F29)) {
    return;
  }

  var_00 = func_4569();
  if(!isDefined(var_00)) {
    if(isDefined(self.var_5F29) && isDefined(self.var_5F30)) {
      self.var_5F29.var_0018 = 0;
      self.var_5F30.var_0018 = 0;
    }

    return;
  }

  self.var_5F29 settext(var_00.var_991F);
  self.var_5F29.var_0018 = 0.85;
  self.var_5F30.var_0018 = 1;
  self.var_5F29.var_00C1 = var_00.var_00C1;
  if(var_00.var_8B91) {
    self.var_5F29 fadeovertime(min(var_00.var_39CF, 60));
    self.var_5F29.var_0018 = var_00.var_39CE;
  }

  if(var_00.var_99DA > 0 && var_00.var_8C1E) {
    self.var_5F30 settimer(max(var_00.var_99DA - gettime() - var_00.var_09F6 / 1000, 0.1));
    return;
  }

  if(var_00.var_99DA > 0 && !var_00.var_8C1E) {
    self.var_5F30 settext("");
    self.var_5F29 fadeovertime(min(var_00.var_99DA, 60));
    self.var_5F29.var_0018 = 0;
    thread func_2403(var_00);
    thread func_23D6(var_00);
    return;
  }

  self.var_5F30 settext("");
}

func_2403(param_00) {
  self notify("message_cleared");
  self endon("message_cleared");
  self endon("disconnect");
  level endon("game_ended");
  self waittill("death");
  func_2401(param_00.var_0109);
}

func_23D6(param_00) {
  wait(param_00.var_99DA);
  func_2401(param_00.var_0109);
  self notify("message_cleared");
}

func_2401(param_00) {
  func_7CE9(param_00);
  func_A131();
}

func_2402() {
  for(var_00 = 0; var_00 < self.var_5F2B.size; var_00++) {
    self.var_5F2B[var_00] = undefined;
  }

  if(!isDefined(self.var_5F29)) {
    return;
  }

  func_A131();
}

func_7728(param_00, param_01) {
  foreach(var_03 in level.var_744A) {
    if(var_03.var_01A7 != param_01) {
      continue;
    }

    var_03 iclientprintln(param_00);
  }
}

func_772A(param_00, param_01, param_02) {
  foreach(var_04 in level.var_744A) {
    if(var_04.var_01A7 != param_01) {
      continue;
    }

    var_04 iclientprintln(param_00, param_02);
  }
}

func_771E(param_00, param_01) {
  for(var_02 = 0; var_02 < level.var_744A.size; var_02++) {
    var_03 = level.var_744A[var_02];
    if(isDefined(var_03.var_012C["team"]) && var_03.var_012C["team"] == param_01) {
      var_03 iclientprintlnbold(param_00);
    }
  }
}

func_771F(param_00, param_01, param_02) {
  for(var_03 = 0; var_03 < level.var_744A.size; var_03++) {
    var_04 = level.var_744A[var_03];
    if(isDefined(var_04.var_012C["team"]) && var_04.var_012C["team"] == param_01) {
      var_04 iclientprintlnbold(param_00, param_02);
    }
  }
}

func_7729(param_00, param_01, param_02) {
  for(var_03 = 0; var_03 < level.var_744A.size; var_03++) {
    var_04 = level.var_744A[var_03];
    if(isDefined(var_04.var_012C["team"]) && var_04.var_012C["team"] == param_01) {
      var_04 iclientprintln(param_00, param_02);
    }
  }
}

func_7727(param_00, param_01) {
  var_02 = level.var_744A;
  for(var_03 = 0; var_03 < var_02.size; var_03++) {
    if(isDefined(param_01)) {
      if(isDefined(var_02[var_03].var_012C["team"]) && var_02[var_03].var_012C["team"] == param_01) {
        var_02[var_03] iclientprintln(param_00);
      }

      continue;
    }

    var_02[var_03] iclientprintln(param_00);
  }
}

func_771A(param_00, param_01, param_02, param_03, param_04, param_05, param_06) {
  var_07 = isDefined(param_04);
  var_08 = 0;
  if(isDefined(param_05)) {
    var_08 = 1;
  }

  if(level.var_910F || !var_07) {
    for(var_09 = 0; var_09 < level.var_744A.size; var_09++) {
      var_0A = level.var_744A[var_09];
      var_0B = var_0A.var_01A7;
      if(isDefined(var_0B)) {
        if(var_0B == param_00 && isDefined(param_02)) {
          var_0A iclientprintln(param_02, param_06);
          continue;
        }

        if(var_0B == param_01 && isDefined(param_03)) {
          var_0A iclientprintln(param_03, param_06);
        }
      }
    }

    if(var_07) {
      level.var_744A[0] method_8615(param_04);
      return;
    }

    return;
  }

  if(var_08) {
    for(var_09 = 0; var_09 < level.var_744A.size; var_09++) {
      var_0A = level.var_744A[var_09];
      var_0B = var_0A.var_01A7;
      if(isDefined(var_0B)) {
        if(var_0B == param_00) {
          if(isDefined(param_02)) {
            var_0A iclientprintln(param_02, param_06);
          }

          var_0A method_8615(param_04);
          continue;
        }

        if(var_0B == param_01) {
          if(isDefined(param_03)) {
            var_0A iclientprintln(param_03, param_06);
          }

          var_0A method_8615(param_05);
        }
      }
    }

    return;
  }

  for(var_09 = 0; var_09 < level.var_744A.size; var_09++) {
    var_0A = level.var_744A[var_09];
    var_0B = var_0A.var_01A7;
    if(isDefined(var_0B)) {
      if(var_0B == param_00) {
        if(isDefined(param_02)) {
          var_0A iclientprintln(param_02, param_06);
        }

        var_0A method_8615(param_04);
        continue;
      }

      if(var_0B == param_01) {
        if(isDefined(param_03)) {
          var_0A iclientprintln(param_03, param_06);
        }
      }
    }
  }
}

func_771C(param_00, param_01, param_02) {
  foreach(var_04 in level.var_744A) {
    if(var_04.var_01A7 != param_00) {
      continue;
    }

    var_04 func_771B(param_01, param_02);
  }
}

func_771B(param_00, param_01) {
  self iclientprintln(param_00);
  self method_8615(param_01);
}

func_069F(param_00) {
  if(level.var_910F && self getentitynumber() != 0) {
    return;
  }

  self method_8615(param_00);
}

func_3517(param_00, param_01, param_02, param_03) {
  param_00 = "scr_" + level.var_3FDC + "_" + param_00;
  if(getDvar(param_00) == "") {
    setDvar(param_00, param_01);
    return param_01;
  }

  var_04 = getdvarint(param_00);
  if(var_04 > param_03) {
    var_04 = param_03;
  } else if(var_04 < param_02) {
    var_04 = param_02;
  } else {
    return var_04;
  }

  setDvar(param_00, var_04);
  return var_04;
}

func_3516(param_00, param_01, param_02, param_03) {
  param_00 = "scr_" + level.var_3FDC + "_" + param_00;
  if(getDvar(param_00) == "") {
    setDvar(param_00, param_01);
    return param_01;
  }

  var_04 = getdvarfloat(param_00);
  if(var_04 > param_03) {
    var_04 = param_03;
  } else if(var_04 < param_02) {
    var_04 = param_02;
  } else {
    return var_04;
  }

  setDvar(param_00, var_04);
  return var_04;
}

func_71AC(param_00, param_01) {
  if(isDefined(param_01)) {
    playsoundatpos(self gettagorigin(param_01), param_00);
    return;
  }

  playsoundatpos(self.var_0116, param_00);
}

func_45DE(param_00) {
  if(level.var_6520) {}

  if(param_00 == "allies") {
    return "axis";
  } else if(param_00 == "axis") {
    return "allies";
  } else {
    return "none";
  }
}

func_532D(param_00) {
  if(!isDefined(self.var_012C[param_00])) {
    self.var_012C[param_00] = 0;
  }
}

func_4607(param_00) {
  return self.var_012C[param_00];
}

func_50E9(param_00, param_01) {
  if(isDefined(self) && isDefined(self.var_012C) && isDefined(self.var_012C[param_00])) {
    self.var_012C[param_00] = self.var_012C[param_00] + param_01;
    if((!isDefined(level.disableallplayerstats) || !level.disableallplayerstats) && (param_00 != "suicides" && param_00 != "kills" && param_00 != "deaths") || !func_579B() || function_03AF() || isDefined(level.var_2F8B) && level.var_2F8B) {
      maps\mp\gametypes\_persistence::func_9314(param_00, param_01);
    }
  }
}

func_86F5(param_00, param_01) {
  self.var_012C[param_00] = param_01;
}

func_5335(param_00, param_01) {
  if(!isDefined(self.var_9337["stats_" + param_00])) {
    if(!isDefined(param_01)) {
      param_01 = 0;
    }

    self.var_9337["stats_" + param_00] = spawnStruct();
    self.var_9337["stats_" + param_00].var_A281 = param_01;
    if(!function_0367() && func_7A69()) {
      self setrankedplayerdata(common_scripts\utility::func_46A7(), "round", "awards", param_00, 0);
    }
  }
}

func_50EA(param_00, param_01) {
  if(function_01EF(self)) {
    return;
  }

  var_02 = self.var_9337["stats_" + param_00];
  var_02.var_A281 = var_02.var_A281 + param_01;
}

func_8702(param_00, param_01) {
  var_02 = self.var_9337["stats_" + param_00];
  var_02.var_A281 = param_01;
  var_02.var_99DA = gettime();
}

func_4628(param_00) {
  return self.var_9337["stats_" + param_00].var_A281;
}

func_4629(param_00) {
  return self.var_9337["stats_" + param_00].var_99DA;
}

func_8703(param_00, param_01) {
  var_02 = func_4628(param_00);
  if(param_01 > var_02) {
    func_8702(param_00, param_01);
  }
}

func_8704(param_00, param_01) {
  var_02 = func_4628(param_00);
  if(param_01 < var_02) {
    func_8702(param_00, param_01);
  }
}

func_A14B(param_00, param_01, param_02) {
  if(!func_7A69()) {
    return;
  }

  var_03 = maps\mp\gametypes\_persistence::func_932F(param_01);
  var_04 = maps\mp\gametypes\_persistence::func_932F(param_02);
  if(var_04 == 0) {
    var_04 = 1;
  }

  maps\mp\gametypes\_persistence::func_9338(param_00, int(var_03 * 1000 / var_04));
}

func_A14C(param_00, param_01, param_02) {
  if(!func_7A69()) {
    return;
  }

  var_03 = maps\mp\gametypes\_persistence::func_9330(param_01);
  var_04 = maps\mp\gametypes\_persistence::func_9330(param_02);
  if(var_04 == 0) {
    var_04 = 1;
  }

  maps\mp\gametypes\_persistence::func_9339(param_00, int(var_03 * 1000 / var_04));
}

func_A790(param_00) {
  if(level.var_5BDF == gettime()) {
    if(isDefined(param_00) && param_00) {
      while(level.var_5BDF == gettime()) {
        wait 0.05;
      }
    } else {
      wait 0.05;
      if(level.var_5BDF == gettime()) {
        wait 0.05;
        if(level.var_5BDF == gettime()) {
          wait 0.05;
          if(level.var_5BDF == gettime()) {
            wait 0.05;
          }
        }
      }
    }
  }

  level.var_5BDF = gettime();
}

func_A6D1(param_00, param_01) {
  self endon(param_01);
  wait(param_00);
}

func_A6D0(param_00, param_01) {
  if(isDefined(param_01)) {
    foreach(var_03 in param_01) {
      self endon(var_03);
    }
  }

  if(isDefined(param_00) && param_00 > 0) {
    wait(param_00);
  }
}

func_56E0(param_00, param_01) {
  for(var_02 = 0; var_02 < param_01.size; var_02++) {
    if(param_00 == param_01[var_02]) {
      return 1;
    }
  }

  return 0;
}

func_5C39(param_00, param_01, param_02, param_03, param_04) {
  if(isDefined(level.var_585D) && level.var_585D) {
    return;
  }

  if(param_00 == "null") {
    return;
  }

  if(!isDefined(param_01)) {
    func_5C3E(param_00, "allies", param_00, "axis", param_02, param_03, param_04);
    return;
  }

  if(isDefined(param_03)) {
    for(var_05 = 0; var_05 < level.var_744A.size; var_05++) {
      var_06 = level.var_744A[var_05];
      if(isDefined(var_06.var_012C["team"]) && var_06.var_012C["team"] == param_01 && !func_56E0(var_06, param_03)) {
        if(var_06 issplitscreenplayer() && !var_06 method_82ED()) {
          continue;
        }

        var_06 func_5C43(param_00, param_02, undefined, param_04);
      }
    }

    return;
  }

  for(var_05 = 0; var_05 < level.var_744A.size; var_05++) {
    var_06 = level.var_744A[var_05];
    if(isDefined(var_06.var_012C["team"]) && var_06.var_012C["team"] == param_01) {
      if(var_06 issplitscreenplayer() && !var_06 method_82ED()) {
        continue;
      }

      var_06 func_5C43(param_00, param_02, undefined, param_04);
    }
  }
}

func_5C3E(param_00, param_01, param_02, param_03, param_04, param_05, param_06) {
  if(isDefined(level.var_585D) && level.var_585D) {
    return;
  }

  if(level.var_910F) {
    return;
  }

  if(level.var_910F) {
    if(level.var_744A.size) {
      level.var_744A[0] func_5C43(param_00, param_04, undefined, param_06);
    }

    return;
  }

  if(isDefined(param_05)) {
    for(var_07 = 0; var_07 < level.var_744A.size; var_07++) {
      var_08 = level.var_744A[var_07];
      var_09 = var_08.var_012C["team"];
      if(!isDefined(var_09)) {
        continue;
      }

      if(func_56E0(var_08, param_05)) {
        continue;
      }

      if(var_08 issplitscreenplayer() && !var_08 method_82ED()) {
        continue;
      }

      if(var_09 == param_01) {
        var_08 func_5C43(param_00, param_04, undefined, param_06);
        continue;
      }

      if(var_09 == param_03) {
        var_08 func_5C43(param_02, param_04, undefined, param_06);
      }
    }

    return;
  }

  for(var_07 = 0; var_07 < level.var_744A.size; var_07++) {
    var_08 = level.var_744A[var_07];
    var_09 = var_08.var_012C["team"];
    if(!isDefined(var_09)) {
      continue;
    }

    if(var_08 issplitscreenplayer() && !var_08 method_82ED()) {
      continue;
    }

    if(var_09 == param_01) {
      var_08 func_5C43(param_00, param_04, undefined, param_06);
      continue;
    }

    if(var_09 == param_03) {
      var_08 func_5C43(param_02, param_04, undefined, param_06);
    }
  }
}

func_5C46(param_00, param_01, param_02, param_03) {
  if(isDefined(level.var_585D) && level.var_585D) {
    return;
  }

  foreach(var_05 in param_01) {
    var_05 func_5C43(param_00, param_02, undefined, param_03);
  }
}

func_5C43(param_00, param_01, param_02, param_03) {
  if(isDefined(level.var_585D) && level.var_585D) {
    return;
  }

  if(function_01EF(self)) {
    return;
  }

  if(!isDefined(param_02)) {
    param_02 = 0;
  }

  var_04 = self.var_012C["team"];
  if(isDefined(level.var_0F05) && level.var_0F05) {
    return;
  }

  if(!isDefined(var_04)) {
    return;
  }

  if(var_04 != "allies" && var_04 != "axis") {
    return;
  }

  if(self issplitscreenplayer() && !self method_82ED()) {
    return;
  }

  if(!isDefined(param_03)) {
    param_03 = (0, 0, 0);
  }

  if(isDefined(param_01)) {
    if(self.var_5C3F == param_01) {
      if(param_02) {
        if(isDefined(self.var_5C3D)) {
          lib_0380::func_2893(self.var_5C3D, 0.1);
          self.var_5C3D = undefined;
        }

        thread func_5C45(param_00, var_04, param_03);
      }

      return;
    }

    var_05 = isDefined(self.var_5C40[param_01]);
    self.var_5C40[param_01] = param_00;
    param_00 = param_01;
    if(var_05) {
      return;
    }
  }

  if(!isDefined(self.var_5C3D)) {
    thread func_5C45(param_00, var_04, param_03);
    return;
  }

  self.var_5C47[self.var_5C47.size] = param_00;
  self.var_5C42[self.var_5C42.size] = param_03;
}

func_5C3C(param_00, param_01) {
  var_02 = 2;
  if(isDefined(game["dialog"]["lockouts"][param_00])) {
    var_02 = game["dialog"]["lockouts"][param_00];
    if(var_02 == 0) {
      return;
    }
  }

  if(!isDefined(param_01.var_08C9)) {
    param_01.var_08C9 = [];
  }

  param_01.var_08C9[param_00] = 1;
  thread func_5C3B(param_00, param_01, var_02);
}

func_5C3B(param_00, param_01, param_02) {
  param_01 endon("disconnect");
  wait(param_02);
  param_01.var_08C9[param_00] = undefined;
}

func_5C3A(param_00, param_01) {
  if(isDefined(param_01.var_08C9)) {
    if(isDefined(param_01.var_08C9[param_00])) {
      if(isDefined(param_01.var_08C9[param_00] == 1)) {
        return 1;
      }
    }
  }

  return 0;
}

func_5C45(param_00, param_01, param_02) {
  self endon("disconnect");
  self notify("playLeaderDialogOnPlayer");
  self endon("playLeaderDialogOnPlayer");
  if(isDefined(self.var_5C40[param_00])) {
    var_03 = param_00;
    param_00 = self.var_5C40[var_03];
    self.var_5C40[var_03] = undefined;
    self.var_5C3F = var_03;
  }

  if(!isDefined(game["dialog"][param_00])) {
    return;
  }

  if(isai(self) && isDefined(level.var_19D5) && isDefined(level.var_19D5["leader_dialog"])) {
    self[[level.var_19D5["leader_dialog"]]](param_00, param_02);
  }

  if(issubstr(game["dialog"][param_00], "null")) {
    return;
  }

  var_04 = game["voice"][param_01] + game["dialog"][param_00];
  if(function_0344(var_04)) {
    if(func_5C3A(game["dialog"][param_00], self)) {
      return;
    }

    if(func_5727()) {
      return;
    }

    if(isDefined(self.var_5C3D)) {
      lib_0380::func_2893(self.var_5C3D, 0.1);
      self.var_5C3D = undefined;
    }

    self.var_5C3D = lib_0380::func_2888(var_04, self);
    func_5C3C(game["dialog"][param_00], self);
  } else {}

  if(isDefined(level.var_2EBB)) {
    [[level.var_2EBB]](param_00, var_04);
  } else {
    wait(2);
  }

  self.var_5C41 = "";
  self.var_5C3D = undefined;
  self.var_5C3F = "";
  if(self.var_5C47.size > 0) {
    var_05 = self.var_5C47[0];
    var_06 = self.var_5C42[0];
    for(var_07 = 1; var_07 < self.var_5C47.size; var_07++) {
      self.var_5C47[var_07 - 1] = self.var_5C47[var_07];
    }

    for(var_07 = 1; var_07 < self.var_5C42.size; var_07++) {
      self.var_5C42[var_07 - 1] = self.var_5C42[var_07];
    }

    self.var_5C47[var_07 - 1] = undefined;
    self.var_5C42[var_07 - 1] = undefined;
    thread func_5C45(var_05, param_01, var_06);
  }
}

func_45AA() {
  for(var_00 = 0; var_00 < self.var_5C47.size; var_00++) {
    if(issubstr(self.var_5C47[var_00], "losing")) {
      if(self.var_01A7 == "allies") {
        if(issubstr(level.var_147A, self.var_5C47[var_00])) {
          return self.var_5C47[var_00];
        } else {
          common_scripts\utility::func_0F93(self.var_5C47, self.var_5C47[var_00]);
        }
      } else if(issubstr(level.var_0BF4, self.var_5C47[var_00])) {
        return self.var_5C47[var_00];
      } else {
        common_scripts\utility::func_0F93(self.var_5C47, self.var_5C47[var_00]);
      }

      continue;
    }

    return level.var_0BF4[self.var_5C47];
  }
}

func_6C2A() {
  self endon("disconnect");
  var_00 = [];
  var_00 = self.var_5C47;
  for(var_01 = 0; var_01 < self.var_5C47.size; var_01++) {
    if(issubstr(self.var_5C47[var_01], "losing")) {
      for(var_02 = var_01; var_02 >= 0; var_02--) {
        if(!issubstr(self.var_5C47[var_02], "losing") && var_02 != 0) {
          continue;
        }

        if(var_02 != var_01) {
          func_0FBD(var_00, self.var_5C47[var_01], var_02);
          common_scripts\utility::func_0F93(var_00, self.var_5C47[var_01]);
          break;
        }
      }
    }
  }

  self.var_5C47 = var_00;
}

func_3D8B() {
  self.var_5C40 = [];
  self.var_5C47 = [];
  self.var_5C3D = undefined;
  self.var_293C = "";
  self notify("flush_dialog");
}

func_3D8C(param_00) {
  foreach(var_02 in level.var_744A) {
    var_02 func_3D8D(param_00);
  }
}

func_0FC0(param_00, param_01) {
  var_02 = 0;
  for(var_03 = 0; var_02 < param_00.size; var_03++) {
    if(param_00[var_02] == param_01) {
      var_02++;
      continue;
    }

    if(var_02 != var_03) {
      param_00[var_03] = param_00[var_02];
    }

    var_02++;
  }

  while(var_03 < param_00.size) {
    param_00[var_03] = undefined;
    var_03++;
  }
}

func_3D8D(param_00) {
  self.var_5C40[param_00] = undefined;
  func_0FC0(self.var_5C47, param_00);
  if(self.var_5C47.size == 0) {
    func_3D8B();
  }
}

func_A132() {
  if(self.var_012C["team"] == "spectator") {
    self setclientdvar("g_scriptMainMenu", game["menu_team"]);
    return;
  }

  self setclientdvar("g_scriptMainMenu", game["menu_class_" + self.var_012C["team"]]);
}

func_A143() {
  if(self.var_012C["team"] == "spectator") {
    self setclientdvar("cg_objectiveText", "");
    return;
  }

  if(func_471A("scorelimit") > 0 && !func_5760()) {
    if(level.var_910F) {
      self setclientdvar("cg_objectiveText", func_45D2(self.var_012C["team"]));
      return;
    }

    self setclientdvar("cg_objectiveText", func_45D2(self.var_012C["team"]), func_471A("scorelimit"));
    return;
  }

  self setclientdvar("cg_objectiveText", func_45D3(self.var_012C["team"]));
}

func_86DC(param_00, param_01) {
  game["strings"]["objective_" + param_00] = param_01;
}

func_86DB(param_00, param_01) {
  game["strings"]["objective_score_" + param_00] = param_01;
}

func_86D8(param_00, param_01) {
  game["strings"]["objective_hint_" + param_00] = param_01;
}

func_45D3(param_00) {
  return game["strings"]["objective_" + param_00];
}

func_45D2(param_00) {
  return game["strings"]["objective_score_" + param_00];
}

func_45CD(param_00) {
  return game["strings"]["objective_hint_" + param_00];
}

func_46E3() {
  if(!isDefined(level.var_9309) || !isDefined(level.var_2FB1)) {
    return 0;
  }

  if(level.var_9A12) {
    return level.var_9A11 - level.var_9309 - level.var_2FB1;
  }

  return gettime() - level.var_9309 - level.var_2FB1;
}

func_4705() {
  if(!isDefined(level.var_6027)) {
    return 0;
  }

  return gettime() - level.var_6027;
}

func_44FA() {
  var_00 = getmatchdata("match_common", "game_length_seconds") * 1000;
  var_00 = var_00 + func_4705();
  return var_00;
}

func_44FB() {
  var_00 = func_44FA();
  var_01 = int(var_00 / 1000);
  return var_01;
}

func_46E4() {
  return func_46E3() / func_46E2() * 60 * 1000 * 100;
}

func_467B() {
  return func_46E3() / 1000;
}

func_4589() {
  return func_467B() / 60;
}

func_2315(param_00) {
  param_00 = int(param_00);
  if(param_00 > 32767) {
    param_00 = 32767;
  }

  if(param_00 < --32768) {
    param_00 = --32768;
  }

  return param_00;
}

func_2314(param_00) {
  param_00 = int(param_00);
  if(param_00 > 255) {
    param_00 = 255;
  }

  if(param_00 < 0) {
    param_00 = 0;
  }

  return param_00;
}

func_23FF() {
  self.var_009F = -1;
  self.var_00E1 = -1;
  self.var_0020 = 0;
  self.var_014A = 0;
  self.var_0188 = 0;
  self.var_0189 = 0;
}

func_5727() {
  var_00 = "Player";
  if(function_026D(self)) {
    var_00 = "TestClient";
  }

  if(function_01EF(self)) {
    var_00 = "Agent";
  }

  var_01 = "ERROR: self.spectateKillcam is " + self.var_0188 + ", but self.forcespectatorclient = " + self.var_009F + " and self.killcamentity = " + self.var_00E1 + " (self is " + var_00 + ")";
  return self.var_0188;
}

func_5822(param_00) {
  return isDefined(param_00) && param_00 != "";
}

func_470E(param_00, param_01, param_02) {
  if(param_00 > param_02) {
    return param_02;
  }

  if(param_00 < param_01) {
    return param_01;
  }

  return param_00;
}

func_5EB0() {
  if(!isDefined(self.var_012C["summary"])) {
    return;
  }

  if(isai(self)) {
    return;
  }

  var_00 = 0;
  if(isDefined(self.var_9A06["total"])) {
    var_00 = self.var_9A06["total"];
  }

  function_00F5("script_EarnedXP: totalXP %d, timeplayed %d, score %d, challenge %d, match %d, misc %d, gamemode %s", self.var_012C["summary"]["xp"], var_00, self.var_012C["summary"]["score"], self.var_012C["summary"]["challenge"], self.var_012C["summary"]["match"], self.var_012C["summary"]["misc"], level.var_3FDC);
}

func_7BF8(param_00, param_01, param_02, param_03) {
  func_7C01("roundswitch", param_01);
  param_00 = "scr_" + param_00 + "_roundswitch";
  level.var_7F27 = param_00;
  level.var_7F29 = param_02;
  level.var_7F28 = param_03;
  level.var_7F26 = getdvarint(param_00, param_01);
  if(level.var_7F26 < param_02) {
    level.var_7F26 = param_02;
    return;
  }

  if(level.var_7F26 > param_03) {
    level.var_7F26 = param_03;
  }
}

func_7BF7(param_00, param_01) {
  func_7C01("roundlimit", param_01);
}

func_7BF2(param_00, param_01) {
  func_7C01("numTeams", param_01);
}

func_7C04(param_00, param_01) {
  func_7C01("winlimit", param_01);
}

func_7BF9(param_00, param_01) {
  func_7C01("scorelimit", param_01);
}

func_7BFA(param_00, param_01) {
  func_7C00("timelimit", param_01);
  setDvar("ui_timelimit", func_46E2());
}

func_7BE5(param_00, param_01) {
  func_7C01("halftime", param_01);
  setDvar("ui_halftime", func_4502());
}

func_7BF1(param_00, param_01) {
  func_7C01("numlives", param_01);
}

func_86EB(param_00) {
  setDvar("overtimeTimeLimit", param_00);
}

func_413A(param_00, param_01) {
  var_02 = spawnStruct();
  var_02.var_5779 = 1;
  var_02.var_5662 = 0;
  var_02.var_008E = param_00;
  var_02.var_29B6 = param_01;
  return var_02;
}

func_413C(param_00, param_01) {
  var_02 = spawnStruct();
  var_02.var_5779 = 0;
  var_02.var_5662 = 0;
  var_02.var_57C4 = 1;
  var_02.var_008E = param_00;
  var_02.var_29B6 = param_01;
  return var_02;
}

func_4137(param_00, param_01) {
  var_02 = spawnStruct();
  var_02.var_5779 = 0;
  var_02.var_5662 = 0;
  var_02.var_008E = param_00;
  var_02.var_29B6 = param_01;
  return var_02;
}

func_4139(param_00, param_01) {
  var_02 = spawnStruct();
  var_02.var_5779 = 0;
  var_02.var_5662 = 0;
  var_02.var_008E = param_00;
  var_02.var_29B6 = param_01;
  return var_02;
}

func_413B(param_00) {
  return param_00.var_0116 + (0, 0, 32);
}

func_469E() {
  if(self getstance() == "crouch") {
    var_00 = self.var_0116 + (0, 0, 24);
  } else if(self getstance() == "prone") {
    var_00 = self.var_0116 + (0, 0, 10);
  } else {
    var_00 = self.var_0116 + (0, 0, 32);
  }

  return var_00;
}

func_4138(param_00) {
  return param_00.var_0116;
}

func_44AB(param_00) {
  var_01 = getDvar(param_00);
  if(var_01 == "") {
    return (0, 0, 0);
  }

  var_02 = strtok(var_01, " ");
  if(var_02.size < 3) {
    return (0, 0, 0);
  }

  setDvar("tempR", var_02[0]);
  setDvar("tempG", var_02[1]);
  setDvar("tempB", var_02[2]);
  return (getdvarfloat("tempR"), getdvarfloat("tempG"), getdvarfloat("tempB"));
}

func_9472(param_00, param_01) {
  if(param_00.size <= param_01.size) {
    return param_00;
  }

  if(getsubstr(param_00, param_00.size - param_01.size, param_00.size) == param_01) {
    return getsubstr(param_00, 0, param_00.size - param_01.size);
  }

  return param_00;
}

func_072B(param_00) {
  var_01 = self getweaponslistall();
  foreach(var_03 in var_01) {
    if(var_03 == param_00) {
      continue;
    } else {
      self takeweapon(var_03);
    }
  }
}

func_8064() {
  var_00 = spawnStruct();
  var_00.var_69A9 = self method_831F();
  var_00.var_0888 = self.var_805F;
  var_00.var_2953 = self getcurrentweapon();
  var_01 = self getweaponslistall();
  var_00.var_A9E7 = [];
  foreach(var_03 in var_01) {
    if(function_01D4(var_03) == "exclusive") {
      continue;
    }

    if(function_01D4(var_03) == "altmode") {
      continue;
    }

    var_04 = spawnStruct();
    var_04.var_0109 = var_03;
    var_04.var_242A = self getweaponammoclip(var_03, "right");
    var_04.var_2429 = self getweaponammoclip(var_03, "left");
    var_04.var_93B1 = self getweaponammostock(var_03);
    if(isDefined(self.var_99AC) && self.var_99AC == var_03) {
      var_04.var_93B1--;
    }

    var_00.var_A9E7[var_00.var_A9E7.size] = var_04;
  }

  self.var_827E = var_00;
}

func_7DEF() {
  var_00 = self.var_827E;
  self method_831E(var_00.var_69A9);
  foreach(var_02 in var_00.var_A9E7) {
    self method_82FA(var_02.var_0109, var_02.var_242A, "right");
    if(issubstr(var_02.var_0109, "akimbo")) {
      self method_82FA(var_02.var_0109, var_02.var_2429, "left");
    }

    self setweaponammostock(var_02.var_0109, var_02.var_93B1);
  }

  foreach(var_06, var_05 in var_00.var_0888) {
    func_06D0(var_06, var_05.var_01B9, var_05.var_586B);
  }

  if(self getcurrentweapon() == "none") {
    var_02 = var_00.var_2953;
    if(var_02 == "none") {
      var_02 = common_scripts\utility::func_4550();
    }

    self setspawnweapon(var_02);
    self switchtoweapon(var_02);
  }
}

func_867B(param_00) {
  self.var_008F = param_00;
  func_86F5("extrascore0", param_00);
}

func_867C(param_00) {
  self.var_0090 = param_00;
  func_86F5("extrascore1", param_00);
}

func_06D0(param_00, param_01, param_02) {
  self.var_805F[param_00].var_01B9 = param_01;
  self.var_805F[param_00].var_586B = param_02;
  self setactionslot(param_00, param_01, param_02);
}

func_861B() {
  func_06D0(1, "");
  func_06D0(2, "");
  func_06D0(3, "altMode");
  func_06D0(4, "");
  if(!level.var_258F) {
    func_06D0(5, "");
    func_06D0(6, "");
    func_06D0(7, "");
    func_06D0(8, "");
  }
}

func_56F6(param_00) {
  if(int(param_00) != param_00) {
    return 1;
  }

  return 0;
}

func_7C01(param_00, param_01) {
  var_02 = "scr_" + level.var_3FDC + "_" + param_00;
  level.var_A901[var_02] = spawnStruct();
  level.var_A901[var_02].var_A281 = getdvarint(var_02, param_01);
  level.var_A901[var_02].var_01B9 = "int";
  level.var_A901[var_02].var_6810 = "update_" + param_00;
}

func_7C00(param_00, param_01) {
  var_02 = "scr_" + level.var_3FDC + "_" + param_00;
  level.var_A901[var_02] = spawnStruct();
  level.var_A901[var_02].var_A281 = getdvarfloat(var_02, param_01);
  level.var_A901[var_02].var_01B9 = "float";
  level.var_A901[var_02].var_6810 = "update_" + param_00;
}

func_7BFF(param_00, param_01) {
  var_02 = "scr_" + level.var_3FDC + "_" + param_00;
  level.var_A901[var_02] = spawnStruct();
  level.var_A901[var_02].var_A281 = getDvar(var_02, param_01);
  level.var_A901[var_02].var_01B9 = "string";
  level.var_A901[var_02].var_6810 = "update_" + param_00;
}

func_86EA(param_00, param_01) {
  param_00 = "scr_" + level.var_3FDC + "_" + param_00;
  level.var_6CC8[param_00] = param_01;
}

func_471A(param_00) {
  param_00 = "scr_" + level.var_3FDC + "_" + param_00;
  if(isDefined(level.var_6CC8) && isDefined(level.var_6CC8[param_00])) {
    return level.var_6CC8[param_00];
  }

  return level.var_A901[param_00].var_A281;
}

func_A194() {
  while(game["state"] == "playing") {
    foreach(var_02, var_01 in level.var_A901) {
      func_A193(var_02);
    }

    wait(1);
  }
}

func_A193(param_00) {
  var_01 = level.var_A901[param_00];
  if(var_01.var_01B9 == "string") {
    var_02 = func_463A(param_00, var_01.var_A281);
  } else if(var_02.var_01B9 == "float") {
    var_02 = func_44E8(var_01, var_02.var_A281);
  } else {
    var_02 = func_4529(var_01, var_02.var_A281);
  }

  if(var_02 != var_01.var_A281) {
    var_01.var_A281 = var_02;
    level notify(var_01.var_6810, var_02);
  }
}

func_57B2() {
  if(!level.var_984D && !common_scripts\utility::func_562E(level.roundbasedffa)) {
    return 0;
  }

  if(func_471A("winlimit") != 1 && func_471A("roundlimit") != 1) {
    return 1;
  }

  return 0;
}

func_56F0() {
  if(!level.var_984D) {
    return 1;
  }

  if(func_471A("roundlimit") > 1 && game["roundsPlayed"] == 0) {
    return 1;
  }

  if(func_471A("winlimit") > 1 && game["roundsWon"]["allies"] == 0 && game["roundsWon"]["axis"] == 0) {
    return 1;
  }

  return 0;
}

func_5743() {
  if(!level.var_984D) {
    return 1;
  }

  if(func_471A("roundlimit") > 1 && game["roundsPlayed"] >= func_471A("roundlimit") - 1) {
    return 1;
  }

  if(func_471A("winlimit") > 1 && isDefined(game["roundsWon"]) && game["roundsWon"]["allies"] >= func_471A("winlimit") - 1 && game["roundsWon"]["axis"] >= func_471A("winlimit") - 1) {
    return 1;
  }

  return 0;
}

func_A875() {
  if(!level.var_984D && !common_scripts\utility::func_562E(level.roundbasedffa)) {
    return 1;
  }

  if(isDefined(level.var_6B54)) {
    return 0;
  }

  if(func_471A("winlimit") == 1 && func_4DE7()) {
    return 1;
  }

  if(func_471A("roundlimit") == 1) {
    return 1;
  }

  return 0;
}

func_A872() {
  if(level.var_3E16) {
    return 1;
  }

  if(!level.var_984D && !common_scripts\utility::func_562E(level.roundbasedffa)) {
    return 1;
  }

  if(func_4DDD() || func_4DE7()) {
    return 1;
  }

  return 0;
}

func_4DDD() {
  if(func_471A("roundlimit") <= 0) {
    return 0;
  }

  return game["roundsPlayed"] >= func_471A("roundlimit");
}

func_4DE2() {
  if(func_5760()) {
    return 0;
  }

  if(func_471A("scorelimit") <= 0) {
    return 0;
  }

  if(level.var_984D) {
    if(game["teamScores"]["allies"] >= func_471A("scorelimit") || game["teamScores"]["axis"] >= func_471A("scorelimit")) {
      return 1;
    }
  } else {
    for(var_00 = 0; var_00 < level.var_744A.size; var_00++) {
      var_01 = level.var_744A[var_00];
      if(isDefined(var_01.var_015C) && var_01.var_015C >= func_471A("scorelimit")) {
        return 1;
      }
    }
  }

  return 0;
}

func_4DE7() {
  if(func_471A("winlimit") <= 0) {
    return 0;
  }

  if(common_scripts\utility::func_562E(level.roundbasedffa)) {
    return 0;
  }

  if(!level.var_984D) {
    return 1;
  }

  if(func_4669("allies") >= func_471A("winlimit") || func_4669("axis") >= func_471A("winlimit")) {
    return 1;
  }

  return 0;
}

func_4672() {
  if(func_57B2()) {
    if(func_471A("roundlimit")) {
      return func_471A("roundlimit");
    }

    return func_471A("winlimit");
  }

  return func_471A("scorelimit");
}

func_4669(param_00) {
  return game["roundsWon"][param_00];
}

func_5760() {
  return level.var_6933;
}

func_579B() {
  return isDefined(level.var_579A) && level.var_579A && isDefined(level.var_79C2);
}

func_585F() {
  return isDefined(level.var_585D) && level.var_585D;
}

iszombiegameshattermode() {
  if(func_585F() == 0) {
    return 0;
  }

  var_00 = func_4571();
  return isDefined(level.iszombiesshotgun) && level.iszombiesshotgun;
}

getcurzombiegameshatterindex() {
  if(iszombiegameshattermode() == 0) {
    return -1;
  }

  var_00 = func_4571();
  if(var_00 == "mp_zombie_windmill") {
    return 1;
  } else if(var_00 == "mp_zombie_dnk") {
    return 2;
  } else if(var_00 == "mp_zombie_dig_02") {
    return 3;
  }

  return -1;
}

isprophuntgametype() {
  return common_scripts\utility::func_562E(level.isprophunt);
}

isdogfightgametype() {
  return common_scripts\utility::func_562E(level.isdogfight);
}

func_46E2() {
  if(func_5380()) {
    var_00 = float(getDvar("overtimeTimeLimit"));
    if(!isDefined(var_00)) {
      var_00 = 1;
    }

    return var_00;
  } else if(isDefined(level.var_2D64) && level.var_2D64 == 1 && isDefined(level.var_18EE) && level.var_18EE == 1 && isDefined(level.var_3992)) {
    return func_471A("timelimit") + 2 * level.var_3992;
  } else if(level.var_3FDC == "onevone" && isDefined(level.var_09B7)) {
    return func_471A("timelimit") + level.var_09B7;
  } else if(level.var_3FDC == "ctf" && isDefined(level.var_289F) && level.var_289F && isDefined(level.var_3992)) {
    return func_471A("timelimit") + 2 * level.var_3992;
  }

  return func_471A("timelimit");
}

func_4502() {
  if(func_5380()) {
    return 0;
  }

  return func_471A("halftime");
}

func_5380() {
  return isDefined(game["status"]) && func_576C(game["status"]);
}

func_576C(param_00) {
  return param_00 == "overtime" || param_00 == "overtime_halftime";
}

func_3FA6() {
  if(isDefined(level.var_3FA6)) {
    return level.var_3FA6;
  }

  if(level.var_984D) {
    return level.var_4B96["axis"] && level.var_4B96["allies"];
  }

  return level.var_6094 > 1;
}

func_442E(param_00) {
  var_01 = (0, 0, 0);
  if(!param_00.size) {
    return undefined;
  }

  foreach(var_03 in param_00) {
    var_01 = var_01 + var_03.var_0116;
  }

  var_05 = int(var_01[0] / param_00.size);
  var_06 = int(var_01[1] / param_00.size);
  var_07 = int(var_01[2] / param_00.size);
  var_01 = (var_05, var_06, var_07);
  return var_01;
}

func_455E(param_00) {
  var_01 = [];
  foreach(var_03 in level.var_744A) {
    if(!isalive(var_03)) {
      continue;
    }

    if(level.var_984D && isDefined(param_00)) {
      if(param_00 == var_03.var_012C["team"]) {
        var_01[var_01.size] = var_03;
      }

      continue;
    }

    var_01[var_01.size] = var_03;
  }

  return var_01;
}

func_8A5B(param_00) {
  if(isDefined(self.var_2015)) {
    self.var_2015.var_0018 = 0;
  }

  self.var_A25C = param_00;
  common_scripts\utility::func_0600();
  self notify("using_remote");
}

func_4664() {
  return self.var_A25C;
}

func_3E8E(param_00) {
  if(isDefined(level.var_4E09)) {
    self freezecontrols(1);
    return;
  }

  self freezecontrols(param_00);
  self.var_260C = param_00;
}

func_3E8F(param_00) {
  if(!param_00) {
    self method_84CB();
    self method_8324();
  } else {
    self method_84CC();
    self method_8325();
  }

  self allowmovement(param_00);
  self allowjump(param_00);
  self method_812B(param_00);
  self method_86CD(1, param_00, param_00);
  self method_8114(1);
  self method_8113(1);
  self method_812A(param_00);
  self method_8307(param_00);
  if(!_hasexperimentalbtperk("specialty_class_snowblind")) {
    self allowads(1);
  }

  self.var_260C = !param_00;
}

func_3E90(param_00, param_01) {
  wait(param_01);
  if(isDefined(self)) {
    func_3E8E(param_00);
  }
}

func_2414() {
  if(isDefined(self.var_2015)) {
    self.var_2015.var_0018 = 1;
  }

  self.var_A25C = undefined;
  common_scripts\utility::func_0614();
  var_00 = self getcurrentweapon();
  if(var_00 == "none" || func_5740(var_00)) {
    self switchtoweapon(common_scripts\utility::func_4550());
  }

  func_3E8E(0);
  func_7441();
  self notify("stopped_using_remote");
}

func_7440() {
  self setclientomnvar("ui_killstreak_remote", 1);
}

func_7441() {
  self setclientomnvar("ui_killstreak_remote", 0);
}

func_43D1() {
  if(isDefined(self.var_A01A)) {
    if(self.var_A01A == "shallow" && isDefined(level.var_8ACF)) {
      return level.var_8ACF;
    }

    if(self.var_A01A == "deep" && isDefined(level.var_2B7C)) {
      return level.var_2B7C;
    }

    if(self.var_A01A != "none" && isDefined(level.var_8ACF)) {
      return level.var_8ACF;
    }
  }

  return "none";
}

func_4739(param_00, param_01) {
  if(!func_7A69() || func_761E()) {
    return 0;
  }

  if(isDefined(param_00) && isDefined(param_01) && isPlayer(param_00) && func_5699(param_01) || func_569A(param_01)) {
    var_02 = param_00 getrankedplayerdata(common_scripts\utility::func_46AE(), "weaponStats", func_45B5(param_01), "prestigeLevel");
    var_03 = param_00 getrankedplayerdata(common_scripts\utility::func_46AE(), "weaponStats", func_45B5(param_01), "kills");
    return getweaponreputation(var_03, var_02);
  }

  return 0;
}

func_581D() {
  return isDefined(self.var_A25C);
}

func_572D() {
  return isDefined(self.var_7C67);
}

func_57B0() {
  return isDefined(self.var_57B0) && self.var_57B0;
}

func_6F74(param_00, param_01, param_02) {
  if(isDefined(param_02)) {
    level endon(param_02);
  }

  if(isDefined(level.var_744A)) {
    common_scripts\utility::func_0FB2(level.var_744A, param_00, param_01);
  }

  if(isDefined(level.var_596C)) {
    common_scripts\utility::func_0FB2(level.var_596C, param_00, param_01);
  }

  for(;;) {
    level waittill("connected", var_03);
    common_scripts\utility::func_0FB2([var_03], param_00, param_01);
  }
}

safe_str(param_00) {
  if(isDefined(param_00)) {
    return "" + param_00;
  }

  return "<undefined>";
}

print3d_lines(param_00, param_01, param_02, param_03, param_04, param_05) {
  if(!isDefined(param_02)) {
    param_02 = (1, 1, 1);
  }

  if(!isDefined(param_03)) {
    param_03 = 1;
  }

  if(!isDefined(param_04)) {
    param_04 = 1;
  }

  if(!isDefined(param_05)) {
    param_05 = 0;
  }

  var_06 = "";
  foreach(var_08 in param_01) {
    var_06 = var_06 + "\n";
  }
}

func_9466(param_00, param_01) {
  if(!isDefined(param_01)) {
    param_01 = " ";
  }

  var_02 = "";
  var_03 = "";
  foreach(var_05 in param_00) {
    var_02 = var_02 + var_03 + var_05;
    var_03 = param_01;
  }

  return var_02;
}

func_5DC8() {
  var_00 = spawnStruct();
  var_00.var_005C = 0;
  return var_00;
}

func_5DC6(param_00) {
  var_01 = spawnStruct();
  var_01.var_A281 = param_00;
  if(!isDefined(self.var_95BE)) {
    self.var_00B9 = var_01;
    self.var_95BE = var_01;
  } else {
    self.var_95BE.var_66A1 = var_01;
    self.var_95BE = var_01;
  }

  self.var_005C++;
}

func_5DCA() {
  if(!isDefined(self.var_00B9)) {
    return undefined;
  }

  if(self.var_00B9 == self.var_95BE) {
    var_00 = self.var_00B9.var_A281;
    self.var_00B9 = undefined;
    self.var_95BE = undefined;
    self.var_005C = 0;
    return var_00;
  }

  var_00 = self.var_00B9.var_A281;
  self.var_00B9 = self.var_00B9.var_66A1;
  self.var_005C--;
  return var_00;
}

func_5DC9() {
  if(!isDefined(self.var_00B9)) {
    return undefined;
  }

  return self.var_00B9.var_A281;
}

func_5DCB() {
  return self.var_005C;
}

func_5DC7() {
  var_00 = self.var_005C;
  for(var_01 = self.var_00B9; var_00; var_01 = var_02) {
    var_02 = var_01.var_66A1;
    var_01.var_66A1 = undefined;
    var_01.var_A281 = undefined;
    var_01 = undefined;
    var_00 = var_00 - 1;
  }

  self.var_005C = 0;
  self.var_00B9 = undefined;
  self.var_95BE = undefined;
}

func_5DCC() {
  var_00 = [];
  var_01 = 0;
  var_02 = self.var_00B9;
  while(isDefined(var_02)) {
    var_00[var_01] = var_02.var_A281;
    var_01++;
    var_02 = var_02.var_66A1;
  }

  return var_00;
}

func_06D4(param_00, param_01) {
  if(isPlayer(self)) {
    maps\mp\gametypes\_divisions::updatedivisionusagestats();
    self.divisionusageindex = param_01;
    self setloadoutdivision(param_01);
    self.var_305A = gettime();
  }

  self.var_0079 = param_01;
}

func_0642(param_00, param_01, param_02, param_03) {
  if(issubstr(param_00, "alt") == 0) {
    param_00 = func_922B(param_00);
  }

  if(issubstr(param_00, "+akimbo") || isDefined(param_01) && param_01 == 1) {
    if(function_01EF(self)) {
      self giveweapon(param_00, 1, 0);
      return;
    }

    self giveweapon(param_00, 1, 0, self, param_02, param_03);
    return;
  }

  if(function_01EF(self)) {
    self giveweapon(param_00, 0, 0);
    return;
  }

  self giveweapon(param_00, 0, 0, self, param_02, param_03);
}

func_4604() {
  if(func_585F()) {
    return "mp/zombiePerkTable.csv";
  }

  return "mp/perktable.csv";
}

isdivisionsglobaloverhaulenabled() {
  return getdvarint("divisionsGlobalOverhaul", 1) == 1;
}

areexperimentalbasictrainingsenabled() {
  return getdvarint("6015", 0) == 1;
}

func_0649(param_00) {
  if(!func_585F() && maps\mp\perks\_perkfunctions::isspecialistperk(param_00) && !maps\mp\perks\_perkfunctions::hasspecialistperkunlocked(param_00)) {
    return 0;
  }

  if(!func_585F() && maps\mp\perks\_perkfunctions::isclassifiedsecondbt(param_00) && !maps\mp\perks\_perkfunctions::hasclassifiedsecondbt()) {
    return 0;
  }

  if(isDefined(self.var_6F65) && isDefined(self.var_6F65[param_00])) {
    return 1;
  }

  return 0;
}

_hasexperimentalbtperk(param_00) {
  if(areexperimentalbasictrainingsenabled()) {
    return func_0649(param_00);
  }

  return 0;
}

func_47A3(param_00, param_01) {
  if(issubstr(param_00, "_mp")) {
    func_0642(param_00);
    self givestartammo(param_00);
    func_06D7(param_00, 1);
    return;
  }

  if(issubstr(param_00, "specialty_weapon_")) {
    func_06D7(param_00, 1);
    return;
  }

  if(function_030D(param_00)) {
    param_00 = func_452B(param_00);
  }

  func_06D7(param_00, 1, param_01);
}

func_47A2(param_00) {
  if(issubstr(param_00, "_mp")) {
    func_0642(param_00);
    self givestartammo(param_00);
    func_06D7(param_00, 0);
    return;
  }

  if(issubstr(param_00, "specialty_weapon_")) {
    func_06D7(param_00, 0);
    return;
  }

  if(function_030D(param_00)) {
    param_00 = func_452B(param_00);
  }

  func_06D7(param_00, 0);
}

func_06D7(param_00, param_01, param_02) {
  self.var_6F65[param_00] = 1;
  self.var_6F6A[param_00] = param_01;
  if(isDefined(level.var_6F68[param_00])) {
    self thread[[level.var_6F68[param_00]]]();
  }

  if(isDefined(param_02)) {
    self setperk(param_00, !isDefined(level.var_8324[param_00]), param_01, param_02);
    return;
  }

  self setperk(param_00, !isDefined(level.var_8324[param_00]), param_01);
}

func_0735(param_00) {
  self.var_6F65[param_00] = undefined;
  self.var_6F6A[param_00] = undefined;
  if(isDefined(level.var_6F6C[param_00])) {
    self thread[[level.var_6F6C[param_00]]]();
  }

  self unsetperk(param_00, !isDefined(level.var_8324[param_00]));
}

func_05E4() {
  foreach(var_02, var_01 in self.var_6F65) {
    if(isDefined(level.var_6F6C[var_02])) {
      self[[level.var_6F6C[var_02]]]();
    }
  }

  self.var_6F65 = [];
  self.var_6F6A = [];
  self method_82AB();
}

func_1F50(param_00) {
  return func_05DE(param_00);
}

func_05DE(param_00) {
  if(!isDefined(level.var_083D) || !isDefined(level.var_083D[param_00])) {
    return 1;
  }

  return self[[level.var_083D[param_00]]]();
}

func_476E(param_00, param_01) {
  func_06CF(param_00, param_01);
}

func_06CF(param_00, param_01) {
  self.var_083B[param_00] = 1;
  if(isPlayer(self)) {
    if(isDefined(level.var_0841[param_00])) {
      self thread[[level.var_0841[param_00]]]();
    }
  }

  self setperk(param_00, !isDefined(level.var_82EE[param_00]), param_01);
}

func_0734(param_00) {
  self.var_083B[param_00] = undefined;
  if(isPlayer(self)) {
    if(isDefined(level.var_0842[param_00])) {
      self thread[[level.var_0842[param_00]]]();
    }
  }

  self unsetperk(param_00, !isDefined(level.var_82EE[param_00]));
}

func_05E1() {
  if(isPlayer(self)) {
    if(isDefined(level.var_0842[self.var_012C["ability"]])) {
      self[[level.var_0842[self.var_012C["ability"]]]]();
    }
  }

  self.var_083B = [];
  self method_82AB();
}

func_0648(param_00, param_01) {
  if(!isDefined(param_01)) {
    param_01 = 0;
  }

  if(param_01) {
    if(isDefined(self.var_083B[param_00]) && self.var_083B[param_00]) {
      return 1;
    }
  } else if(isDefined(self.var_012C["ability"]) && self.var_012C["ability"] == param_00 && isDefined(self.var_012C["abilityOn"]) && self.var_012C["abilityOn"]) {
    return 1;
  }

  return 0;
}

func_0728() {
  if(func_581D() && !function_02D2(self)) {
    thread maps\mp\gametypes\_damage::func_7418(self, self, self, 10000, "MOD_SUICIDE", "frag_grenade_mp", (0, 0, 0), "none", 0, 1116, 1);
    return;
  }

  if(!func_581D() && !function_02D2(self)) {
    self suicide();
  }
}

func_57A0(param_00) {
  if(isalive(param_00) && !function_02D2(param_00)) {
    return 1;
  }

  return 0;
}

func_A71C(param_00, param_01, param_02, param_03, param_04, param_05) {
  var_06 = spawnStruct();
  if(isDefined(param_01)) {
    thread common_scripts\utility::func_A75E(param_01, var_06);
  }

  if(isDefined(param_02)) {
    thread common_scripts\utility::func_A75E(param_02, var_06);
  }

  if(isDefined(param_03)) {
    thread common_scripts\utility::func_A75E(param_03, var_06);
  }

  if(isDefined(param_04)) {
    thread common_scripts\utility::func_A75E(param_04, var_06);
  }

  if(isDefined(param_05)) {
    thread common_scripts\utility::func_A75E(param_05, var_06);
  }

  var_06 thread func_0731(param_00, self);
  var_06 waittill("returned", var_07);
  var_06 notify("die");
  return var_07;
}

func_0731(param_00, param_01) {
  self endon("die");
  var_02 = 0.05;
  while(param_00 > 0) {
    if(isPlayer(param_01) && !func_57A0(param_01)) {
      param_01 waittill("spawned_player");
    }

    if(getdvarint("ui_inprematch")) {
      level waittill("prematch_over");
    }

    wait(var_02);
    param_00 = param_00 - var_02;
  }

  self notify("returned", "timeout");
}

func_7210(param_00, param_01) {
  if(isDefined(level.var_2980)) {
    self thread[[level.var_2980]]();
    return;
  }

  if(isDefined(self.var_18A8)) {
    if(self.var_01A7 == "axis") {
      if(self method_843D()) {
        var_02 = randomintrange(1, 4);
        if(isDefined(param_00) && param_00 == "MOD_BURNED" || param_00 == "MOD_BURNED_OVER_TIME") {
          var_03 = lib_0380::func_6842("flame_death_enemy_fm_" + var_02, undefined, self.var_18A8.var_0116);
          return;
        }

        if(isDefined(param_00) && param_00 == "MOD_MELEE" && issubstr(param_01, "bayonet")) {
          var_03 = lib_0380::func_2889("bayo_death_enemy_fm_" + var_02, undefined, self.var_18A8.var_0116);
          return;
        }

        if(isDefined(self.var_5D9F) && self.var_5D9F == 1) {
          var_03 = lib_0380::func_6842("lingering_death_enemy_fm_" + var_02, undefined, self.var_18A8.var_0116);
          return;
        }

        var_03 = lib_0380::func_6842("generic_death_enemy_fm_" + var_02, undefined, self.var_18A8.var_0116);
        return;
      }

      var_02 = randomintrange(1, 7);
      if(isDefined(param_00) && param_00 == "MOD_BURNED" || param_00 == "MOD_BURNED_OVER_TIME") {
        var_03 = lib_0380::func_6842("flame_death_enemy_" + var_02, undefined, self.var_18A8.var_0116);
        return;
      }

      if(isDefined(param_00) && param_00 == "MOD_MELEE" && issubstr(param_01, "bayonet")) {
        var_03 = lib_0380::func_2889("bayo_death_enemy_" + var_02, undefined, self.var_18A8.var_0116);
        return;
      }

      if(isDefined(self.var_5D9F) && self.var_5D9F == 1) {
        var_03 = lib_0380::func_6842("lingering_death_enemy_" + var_02, undefined, self.var_18A8.var_0116);
        return;
      }

      var_03 = lib_0380::func_6842("generic_death_enemy_" + var_02, undefined, self.var_18A8.var_0116);
      return;
    }

    if(self method_843D()) {
      var_02 = randomintrange(1, 4);
      if(isDefined(param_00) && param_00 == "MOD_BURNED" || param_00 == "MOD_BURNED_OVER_TIME") {
        var_03 = lib_0380::func_6842("flame_death_friendly_fm_" + var_02, undefined, self.var_18A8.var_0116);
        return;
      }

      if(isDefined(param_00) && param_00 == "MOD_MELEE" && issubstr(param_01, "bayonet")) {
        var_03 = lib_0380::func_2889("bayo_death_friendly_fm_" + var_02, undefined, self.var_18A8.var_0116);
        return;
      }

      if(isDefined(self.var_5D9F) && self.var_5D9F == 1) {
        var_03 = lib_0380::func_6842("lingering_death_friendly_fm_" + var_02, undefined, self.var_18A8.var_0116);
        return;
      }

      var_03 = lib_0380::func_6842("generic_death_friendly_fm_" + var_02, undefined, self.var_18A8.var_0116);
      return;
    }

    var_02 = randomintrange(1, 7);
    if(isDefined(param_00) && param_00 == "MOD_BURNED" || param_00 == "MOD_BURNED_OVER_TIME") {
      var_03 = lib_0380::func_6842("flame_death_friendly_" + var_02, undefined, self.var_18A8.var_0116);
      return;
    }

    if(isDefined(param_00) && param_00 == "MOD_MELEE" && issubstr(param_01, "bayonet")) {
      var_03 = lib_0380::func_2889("bayo_death_friendly_" + var_02, undefined, self.var_18A8.var_0116);
      return;
    }

    if(isDefined(self.var_5D9F) && self.var_5D9F == 1) {
      var_03 = lib_0380::func_6842("lingering_death_friendly_" + var_02, undefined, self.var_18A8.var_0116);
      return;
    }

    var_03 = lib_0380::func_6842("generic_death_friendly_" + var_02, undefined, self.var_18A8.var_0116);
    return;
  }
}

func_7A69() {
  if(!isPlayer(self)) {
    return 0;
  }

  return (level.var_7A67 && !self.var_A25B) || function_0367() && !function_0371() && !issplitscreen() && !function_02A4();
}

func_773F() {
  return !level.var_6B4D || function_0371();
}

func_602B() {
  return level.var_6B4D && !function_0371();
}

func_761E() {
  return level.var_7616;
}

func_8626(param_00, param_01, param_02, param_03) {}

func_36E4(param_00) {
  self endon("altscene");
  param_00 waittill("death");
  self notify("end_altScene");
}

func_4571() {
  return getDvar("1673");
}

func_44FC() {
  return func_471A("numlives");
}

func_0FBD(param_00, param_01, param_02) {
  if(param_00.size != 0) {
    for(var_03 = param_00.size; var_03 >= param_02; var_03--) {
      param_00[var_03 + 1] = param_00[var_03];
    }
  }

  param_00[param_02] = param_01;
}

func_463A(param_00, param_01) {
  var_02 = param_01;
  var_02 = getDvar(param_00, param_01);
  return var_02;
}

func_4529(param_00, param_01) {
  var_02 = param_01;
  var_02 = getdvarint(param_00, param_01);
  return var_02;
}

func_44E8(param_00, param_01) {
  var_02 = param_01;
  var_02 = getdvarfloat(param_00, param_01);
  return var_02;
}

func_56A8() {
  return isDefined(self.var_20CC);
}

func_5A54(param_00) {
  return 1;
}

func_5740(param_00) {
  if(!isDefined(param_00)) {
    return 0;
  }

  if(param_00 == "none") {
    return 0;
  }

  if(func_56C4(param_00)) {
    return 0;
  }

  if(func_568F(param_00) || isuseweapon(param_00)) {
    return 0;
  }

  if(issubstr(param_00, "killstreak")) {
    return 1;
  }

  if(param_00 == "p51_cannon") {
    return 0;
  }

  param_00 = func_4431(param_00);
  if(param_00 == "airdrop_sentry_marker_mp") {
    return 1;
  }

  if(param_00 == "teslagun_war_moon_mp" || param_00 == "war_super_soldier_syrum_purple_mp" || param_00 == "war_super_soldier_syrum_green_mp" || param_00 == "war_super_soldier_syrum_mp" || param_00 == "war_super_soldier_syrum_orange_mp" || param_00 == "war_sword_mp") {
    return 1;
  }

  if(isDefined(level.var_5A7D) && isDefined(level.var_5A7D[param_00])) {
    return 1;
  }

  var_01 = function_01D4(param_00);
  if(isDefined(var_01) && var_01 == "exclusive") {
    return 1;
  }

  return 0;
}

func_56C4(param_00) {
  if(!isDefined(param_00)) {
    return 0;
  }

  switch (param_00) {
    case "barrel_mp":
    case "destructible_toy":
    case "destructible_car":
    case "destructible":
      return 1;
  }

  return 0;
}

func_5705() {
  if(func_551F()) {
    return 0;
  }

  return getdvarint("scr_game_grappling_hook", 0);
}

func_571D() {
  return getdvarint("scr_game_increased_clients", 0);
}

func_568F(param_00) {
  if(!isDefined(param_00)) {
    return 0;
  }

  switch (param_00) {
    case "bomb_site_mp":
    case "search_dstry_bomb_defuse_mp":
    case "search_dstry_bomb_mp":
      return 1;
  }

  return 0;
}

isuseweapon(param_00) {
  if(!isDefined(param_00)) {
    return 0;
  }

  switch (param_00) {
    case "wrench_disassemble_dig_zm":
    case "explosives_dig_zm":
    case "war_generic_open_mp":
    case "war_rope_untie_mp":
    case "war_dynamite_disarm_mp":
    case "war_wrench_assemble_mp":
    case "war_generic_assemble_mp":
    case "war_bangalore_mp":
    case "war_hammer_assemble_mp":
    case "war_dynamite_mp":
    case "search_dstry_bomb_defuse_mp":
    case "search_dstry_bomb_mp":
      return 1;
  }

  return 0;
}

func_56DF(param_00) {
  if(!isDefined(param_00)) {
    return 0;
  }

  if(param_00 == "turret_minigun_mp") {
    return 1;
  }

  if(issubstr(param_00, "_bipod_")) {
    return 1;
  }

  return 0;
}

func_5856(param_00) {
  if(issubstr(param_00, "loot")) {
    return 1;
  }

  return 0;
}

func_5857(param_00) {
  if(param_00 == 0) {
    return 0;
  }

  var_01 = getitemreffromguid(param_00);
  return func_5856(var_01);
}

func_4738(param_00) {
  return strtok(param_00, "+");
}

func_4730(param_00, param_01) {
  var_02 = func_4738(param_00);
  for(var_03 = 1; var_03 < var_02.size; var_03++) {
    var_04 = var_02[var_03];
    if(!func_5679(var_04) && issubstr(var_04, param_01)) {
      return var_04;
    }
  }

  return "";
}

func_4728(param_00) {
  return func_4730(param_00, "camo");
}

func_472B(param_00) {
  return func_4730(param_00, "cond");
}

func_473A(param_00) {
  return func_4730(param_00, "scope");
}

func_472F(param_00) {
  return func_4730(param_00, "cust");
}

func_472A(param_00, param_01) {
  if(param_00 == "p51_cannon") {
    return "none";
  }

  var_02 = func_4431(param_00);
  var_03 = tablelookup("mp/statstable.csv", 2, var_02, 0);
  if(var_03 == "") {
    var_03 = tablelookup("mp/statstable.csv", 2, param_00, 0);
  }

  if(func_56DF(param_00)) {
    var_03 = "weapon_mg";
  } else if(!common_scripts\utility::func_562E(param_01) && func_5740(param_00)) {
    var_03 = "killstreak";
  } else if(param_00 == "none") {
    var_03 = "other";
  } else if(var_03 == "") {
    var_03 = "other";
  }

  return var_03;
}

func_4723(param_00) {
  return function_0060(param_00);
}

func_4431(param_00, param_01) {
  var_02 = strtok(param_00, "+");
  var_03 = "";
  if(var_02[0] == "alt") {
    var_03 = var_02[1];
  } else {
    var_03 = var_02[0];
  }

  if(isDefined(param_01) && param_01 == 1) {
    var_04 = tablelookup("mp/statstable.csv", 2, var_03, 28);
    if(var_04 != "") {
      return var_04;
    }
  }

  return var_03;
}

func_45B5(param_00) {
  var_01 = func_4431(param_00);
  if(func_5856(var_01)) {
    var_01 = maps\mp\gametypes\_class::func_4432(var_01);
  }

  return var_01;
}

func_74D8(param_00, param_01) {
  playsoundatpos(param_01, param_00);
}

func_5D7F(param_00, param_01) {
  if(!isDefined(param_01)) {
    param_01 = 2;
  }

  var_02 = 1;
  for(var_03 = 0; var_03 < param_01; var_03++) {
    var_02 = var_02 * 10;
  }

  var_04 = param_00 * var_02;
  var_04 = int(var_04);
  var_04 = var_04 / var_02;
  return var_04;
}

func_73E2(param_00) {
  foreach(var_02 in level.var_744A) {
    if(var_02.var_2418 == param_00) {
      return var_02;
    }
  }

  return undefined;
}

func_871E(param_00) {
  self makeusable();
  foreach(var_02 in level.var_744A) {
    if(var_02 != param_00) {
      self disableplayeruse(var_02);
      continue;
    }

    self enableplayeruse(var_02);
  }
}

func_A18D(param_00) {
  level endon("game_ended");
  self endon("death");
  for(;;) {
    level waittill("connected", var_01);
    self disableplayeruse(var_01);
  }
}

func_871D() {
  self makeunusable();
  foreach(var_01 in level.var_744A) {
    self disableplayeruse(var_01);
  }
}

func_5FBD(param_00) {
  self makeusable();
  thread func_073A(param_00);
}

func_073A(param_00) {
  self endon("death");
  self notify("stop_usable_update");
  self endon("stop_usable_update");
  for(;;) {
    foreach(var_02 in level.var_744A) {
      if(var_02.var_01A7 == param_00) {
        self enableplayeruse(var_02);
        continue;
      }

      self disableplayeruse(var_02);
    }

    level waittill("joined_team");
  }
}

func_5FB6(param_00) {
  self makeusable();
  thread func_0737(param_00);
}

func_0737(param_00) {
  self endon("death");
  var_01 = param_00.var_01A7;
  for(;;) {
    if(level.var_984D) {
      foreach(var_03 in level.var_744A) {
        if(var_03.var_01A7 != var_01) {
          self enableplayeruse(var_03);
          continue;
        }

        self disableplayeruse(var_03);
      }
    } else {
      foreach(var_03 in level.var_744A) {
        if(var_03 != param_00) {
          self enableplayeruse(var_03);
          continue;
        }

        self disableplayeruse(var_03);
      }
    }

    level waittill("joined_team");
  }
}

func_45AD(param_00) {
  var_01 = getmatchdata("match_common", "life_count");
  if(var_01 < level.var_608B) {
    setmatchdata("match_common", "life_count", var_01 + 1);
    level.var_5CC7[var_01] = gettime();
    return var_01;
  }

  return level.var_608B - 1;
}

func_52BE() {
  if(!isDefined(game["flags"])) {
    game["flags"] = [];
  }
}

func_3FA3(param_00, param_01) {
  game["flags"][param_00] = param_01;
}

func_3FA2(param_00) {
  return isDefined(game["flags"]) && isDefined(game["flags"][param_00]);
}

func_3FA0(param_00) {
  return game["flags"][param_00];
}

func_3FA4(param_00) {
  game["flags"][param_00] = 1;
  level notify(param_00);
}

func_3FA1(param_00) {
  game["flags"][param_00] = 0;
}

func_3FA5(param_00) {
  while(!func_3FA0(param_00)) {
    level waittill(param_00);
  }
}

func_5694(param_00) {
  var_01 = "MOD_RIFLE_BULLET MOD_PISTOL_BULLET MOD_HEAD_SHOT";
  if(issubstr(var_01, param_00)) {
    return 1;
  }

  return 0;
}

func_56F8(param_00, param_01, param_02) {
  return isDefined(param_02) && isPlayer(param_02) && (param_02 func_0649("specialty_bulletpenetration") || param_02 func_0649("specialty_superbulletpenetration")) && isDefined(param_01) && func_5694(param_01);
}

func_5315() {
  if(!isDefined(level.var_5CBD)) {
    level.var_5CBD = [];
  }
}

func_5CBC(param_00, param_01) {
  level.var_5CBD[param_00] = param_01;
}

func_5CBA(param_00) {
  return level.var_5CBD[param_00];
}

func_5CBE(param_00) {
  level.var_5CBD[param_00] = 1;
  level notify(param_00);
}

func_5CBB(param_00) {
  level.var_5CBD[param_00] = 0;
  level notify(param_00);
}

func_5CBF(param_00) {
  while(!func_5CBA(param_00)) {
    level waittill(param_00);
  }
}

func_5CC0(param_00) {
  while(func_5CBA(param_00)) {
    level waittill(param_00);
  }
}

func_551F() {
  if(!isDefined(level.var_A559) || level.var_A559 == 0) {
    return 0;
  }

  return 1;
}

func_5716(param_00) {
  if(param_00 == "emote_weapon_mp" || param_00 == "boxing_gloves_hub_mp") {
    return 1;
  }

  return 0;
}

func_573D() {
  if(func_551F()) {
    return 0;
  }

  return func_56D7() || func_5668();
}

func_56D7() {
  if(self.var_01A7 == "spectator") {
    return 0;
  }

  if(func_551F()) {
    return 0;
  }

  if(level.var_984D) {
    return (isDefined(level.var_9852) && level.var_9852[self.var_01A7]) || isDefined(self.var_35F1) && self.var_35F1;
  }

  return (isDefined(level.var_35F6) && level.var_35F6 != self) || isDefined(self.var_35F1) && self.var_35F1;
}

func_56D8() {
  if(self.var_01A7 == "spectator") {
    return 0;
  }

  if(func_551F()) {
    return 0;
  }

  if(level.var_984D) {
    return level.var_9852[self.var_01A7];
  }

  return isDefined(level.var_35F6) && level.var_35F6 != self;
}

func_5668(param_00, param_01) {
  var_02 = self.var_01A7;
  if(isDefined(param_01)) {
    var_02 = param_01;
  }

  if((level.var_984D && isDefined(level.var_9854) && isDefined(var_02) && isDefined(level.var_9854[var_02]) && level.var_9854[var_02]) || !level.var_984D && isDefined(level.var_3CE0) && level.var_3CE0 != self) {
    if(!isDefined(param_00) || param_00) {
      self iclientprintlnbold(&"KILLSTREAKS_FLAK_GUN_ACTIVE");
    }

    return 1;
  }

  return 0;
}

func_5814(param_00, param_01) {
  var_02 = self.var_01A7;
  if(isDefined(param_01)) {
    var_02 = param_01;
  }

  if((level.var_984D && isDefined(level.var_9850) && level.var_9850[var_02]) || !level.var_984D && isDefined(level.var_2694) && level.var_2694 != self) {
    if(!isDefined(param_00) || param_00) {
      self iclientprintlnbold(&"KILLSTREAKS_COUNTER_RECON_ACTIVE");
    }

    return 1;
  }

  return 0;
}

func_575F() {
  if(self.var_01A7 == "spectator") {
    return 0;
  }

  return isDefined(self.var_6857);
}

func_4621(param_00) {
  foreach(var_02 in level.var_744A) {
    if(var_02.var_48CA == param_00) {
      return var_02;
    }
  }

  return undefined;
}

func_9863(param_00, param_01, param_02, param_03) {
  if(level.var_4B17) {
    return;
  }

  foreach(var_05 in level.var_744A) {
    if(!isDefined(var_05)) {
      continue;
    }

    if(isDefined(param_02) && !isDefined(var_05.var_01A7) || var_05.var_01A7 != param_02) {
      continue;
    }

    if(!isPlayer(var_05)) {
      continue;
    }

    var_05 thread maps\mp\gametypes\_hud_message::func_73C2(param_00, param_01, param_03);
  }
}

func_5699(param_00) {
  switch (func_472A(param_00)) {
    case "weapon_special":
    case "weapon_heavy":
    case "weapon_shotgun":
    case "weapon_lmg":
    case "weapon_sniper":
    case "weapon_riot":
    case "weapon_assault":
    case "weapon_smg":
      return 1;

    default:
      return 0;
  }
}

func_569A(param_00) {
  switch (func_472A(param_00)) {
    case "weapon_other":
    case "weapon_sec_special":
    case "weapon_machine_pistol":
    case "weapon_pistol":
    case "weapon_knife":
    case "weapon_projectile":
      return 1;

    default:
      return 0;
  }
}

func_454F(param_00) {
  var_01 = undefined;
  foreach(var_03 in level.var_744A) {
    if(isDefined(param_00) && var_03.var_01A7 != param_00) {
      continue;
    }

    if(!func_57A0(var_03) && !var_03 maps\mp\gametypes\_playerlogic::func_60B2()) {
      continue;
    }

    var_01 = var_03;
  }

  return var_01;
}

func_4630() {
  var_00 = [];
  foreach(var_02 in level.var_744A) {
    if(!func_57A0(var_02) && !var_02 maps\mp\gametypes\_playerlogic::func_60B2()) {
      continue;
    }

    var_00[var_00.size] = var_02;
  }

  return var_00;
}

func_A78E(param_00, param_01) {
  self endon("death");
  self endon("disconnect");
  var_02 = 0;
  if(!isDefined(param_01)) {
    param_01 = 0.05;
  }

  if(!isDefined(param_00)) {
    param_00 = 0;
  }

  for(;;) {
    if(self.var_00BC != self.var_00FB) {
      var_02 = 0;
    } else {
      var_02 = var_02 + param_01;
    }

    wait(param_01);
    if(self.var_00BC == self.var_00FB && var_02 >= param_00) {
      break;
    }
  }
}

func_1151(param_00, param_01) {
  var_02 = param_00;
  if(isDefined(param_00)) {
    param_01 = func_4431(param_01, 1);
    if(func_5856(param_01)) {
      param_01 = maps\mp\gametypes\_class::func_4432(param_01);
    }

    if(isDefined(level.var_114F[param_01]) && isDefined(level.var_114F[param_01][param_00])) {
      var_02 = level.var_114F[param_01][param_00];
    } else {
      var_03 = tablelookup("mp/statstable.csv", 2, param_01, 0);
      if(isDefined(level.var_114F[var_03]) && isDefined(level.var_114F[var_03][param_00])) {
        var_02 = level.var_114F[var_03][param_00];
      }
    }
  }

  return var_02;
}

func_1153(param_00) {
  var_01 = undefined;
  if(isDefined(level.var_114E[param_00])) {
    var_01 = level.var_114E[param_00];
  }

  return var_01;
}

func_567A(param_00, param_01) {
  var_02 = strtok(param_00, "_");
  return func_567B(var_02, param_01);
}

func_567B(param_00, param_01) {
  var_02 = 0;
  if(param_00.size && isDefined(param_01)) {
    var_03 = 0;
    if(param_00[0] == "alt") {
      var_03 = 1;
    }

    if(param_00.size >= 3 + var_03 && param_00[var_03] == "iw5" || param_00[var_03] == "iw6") {
      if(function_01AA(param_00[var_03] + "_" + param_00[var_03 + 1] + "_" + param_00[var_03 + 2]) == "sniper") {
        var_02 = param_00[var_03 + 1] + "scope" == param_01;
      }
    }
  }

  return var_02;
}

func_4725(param_00) {
  var_01 = function_0061(param_00);
  foreach(var_04, var_03 in var_01) {
    var_01[var_04] = func_1150(var_03);
  }

  return var_01;
}

func_4427() {
  var_00 = [];
  var_01 = 0;
  var_02 = tablelookup("mp/attachmenttable.csv", 0, var_01, 4);
  while(var_02 != "") {
    if(!common_scripts\utility::func_0F79(var_00, var_02)) {
      var_00[var_00.size] = var_02;
    }

    var_01++;
    var_02 = tablelookup("mp/attachmenttable.csv", 0, var_01, 4);
  }

  return var_00;
}

func_4428() {
  var_00 = [];
  var_01 = 0;
  var_02 = tablelookup("mp/attachmenttable.csv", 0, var_01, 3);
  while(var_02 != "") {
    var_00[var_00.size] = var_02;
    var_01++;
    var_02 = tablelookup("mp/attachmenttable.csv", 0, var_01, 3);
  }

  return var_00;
}

func_1D3E() {
  var_00 = func_4428();
  level.var_1152 = [];
  foreach(var_02 in var_00) {
    var_03 = tablelookup("mp/attachmenttable.csv", 3, var_02, 4);
    if(var_02 == var_03) {
      continue;
    }

    level.var_1152[var_02] = var_03;
  }

  var_05 = [];
  var_06 = 1;
  var_07 = tablelookupbyrow("mp/attachmentmap.csv", var_06, 0);
  while(var_07 != "") {
    var_05[var_05.size] = var_07;
    var_06++;
    var_07 = tablelookupbyrow("mp/attachmentmap.csv", var_06, 0);
  }

  var_08 = [];
  var_09 = 1;
  var_0A = tablelookupbyrow("mp/attachmentmap.csv", 0, var_09);
  while(var_0A != "") {
    var_08[var_0A] = var_09;
    var_09++;
    var_0A = tablelookupbyrow("mp/attachmentmap.csv", 0, var_09);
  }

  level.var_114F = [];
  foreach(var_07 in var_05) {
    foreach(var_0F, var_0D in var_08) {
      var_0E = tablelookup("mp/attachmentmap.csv", 0, var_07, var_0D);
      if(var_0E == "") {
        continue;
      }

      if(!isDefined(level.var_114F[var_07])) {
        level.var_114F[var_07] = [];
      }

      level.var_114F[var_07][var_0F] = var_0E;
    }
  }

  level.var_114E = [];
  foreach(var_12 in var_00) {
    var_13 = tablelookup("mp/attachmenttable.csv", 3, var_12, 8);
    if(var_13 == "") {
      continue;
    }

    level.var_114E[var_12] = var_13;
  }
}

func_1150(param_00) {
  if(isDefined(level.var_1152[param_00])) {
    param_00 = level.var_1152[param_00];
  }

  return param_00;
}

func_068B(param_00) {
  objective_delete(param_00);
  if(!isDefined(level.var_7AD6)) {
    level.var_7AD6 = [];
    level.var_7AD6[0] = param_00;
    return;
  }

  level.var_7AD6[level.var_7AD6.size] = param_00;
}

func_9AC1() {
  var_00 = getEntArray("trigger_hurt", "classname");
  foreach(var_02 in var_00) {
    if(self istouching(var_02)) {
      return 1;
    }
  }

  var_04 = getEntArray("radiation", "targetname");
  foreach(var_02 in var_04) {
    if(self istouching(var_02)) {
      return 1;
    }
  }

  if(getDvar("1924") == "hp" && isDefined(level.var_AC7C) && isDefined(level.var_AC7C.var_9D5E) && self istouching(level.var_AC7C.var_9D5E)) {
    return 1;
  }

  if(getDvar("1924") == "undead" && isDefined(level.var_AC7C) && isDefined(level.var_AC7C.var_9D5E) && self istouching(level.var_AC7C.var_9D5E)) {
    return 1;
  }

  return 0;
}

func_8742(param_00) {
  if(param_00) {
    self setdepthoffield(0, 110, 512, 4096, 6, 1.8);
    return;
  }

  self setdepthoffield(0, 0, 512, 512, 4, 0);
}

func_5A81(param_00, param_01, param_02) {
  var_03 = spawn("trigger_radius", param_00, 0, param_01, param_02);
  for(;;) {
    var_03 waittill("trigger", var_04);
    if(!isPlayer(var_04)) {
      continue;
    }

    var_04 suicide();
  }
}

func_3B8E(param_00, param_01, param_02) {
  return findisfacingvectors(param_00.var_0116, anglesToForward(param_00.var_001D), param_01.var_0116, param_02);
}

findplayerisfacing(param_00, param_01, param_02) {
  var_03 = distance(param_00 getEye(), param_01.var_0116);
  var_04 = param_00 getEye() + var_03 * vectornormalize(anglesToForward(param_00 geteyeangles()));
  return distance(param_01.var_0116, var_04) < param_02;
}

findisfacingvectors(param_00, param_01, param_02, param_03) {
  var_04 = cos(param_03);
  var_05 = param_02 - param_00;
  var_05 = var_05 * (1, 1, 0);
  var_05 = vectornormalize(var_05);
  param_01 = param_01 * (1, 1, 0);
  param_01 = vectornormalize(param_01);
  var_06 = vectordot(var_05, param_01);
  return var_06 >= var_04;
}

func_33D8(param_00, param_01, param_02, param_03) {
  var_04 = int(param_02 * 20);
  for(var_05 = 0; var_05 < var_04; var_05++) {
    wait 0.05;
  }
}

func_33DF(param_00, param_01, param_02, param_03) {
  var_04 = int(param_02 * 20);
  for(var_05 = 0; var_05 < var_04; var_05++) {
    wait 0.05;
  }
}

func_870F(param_00, param_01) {
  if(!isDefined(param_00)) {
    param_00 = 0;
  }

  if(!isDefined(self.var_7AD7)) {
    self.var_7AD7 = param_00;
  } else {
    self.var_7AD7 = self.var_7AD7 + param_00;
  }

  if(isDefined(param_01)) {
    if(isDefined(self.var_7AD7) && param_01 < self.var_7AD7) {
      param_01 = self.var_7AD7;
    }

    var_02 = 100 - param_01;
  } else {
    var_02 = 100 - self.var_7AD7;
  }

  if(func_0649("specialty_sessionProgressionC") && isDefined(self.var_012C["sessionProgressionC_Modifier"])) {
    var_02 = var_02 * maps\mp\perks\_perkfunctions::getgrenadiermodvalue_c();
  }

  if(isDefined(self.classifiedboostafterreloadactive) && self.classifiedboostafterreloadactive) {
    var_02 = var_02 * 50;
  }

  if(isDefined(self.raidbasictrainingbuff) && self.raidbasictrainingbuff) {
    var_02 = var_02 * 70;
  }

  if(var_02 < 0) {
    var_02 = 0;
  }

  if(var_02 > 100) {
    var_02 = 100;
  }

  if(var_02 == 100) {
    self method_82E8();
    return;
  }

  self method_82E7(int(var_02));
}

func_2341(param_00) {
  var_01 = [];
  foreach(var_04, var_03 in param_00) {
    if(!isDefined(var_03)) {
      continue;
    }

    var_01[var_01.size] = param_00[var_04];
  }

  return var_01;
}

func_6819(param_00) {
  self notify("notusablejoiningplayers");
  self endon("death");
  level endon("game_ended");
  param_00 endon("disconnect");
  param_00 endon("death");
  self endon("notusablejoiningplayers");
  for(;;) {
    level waittill("player_spawned", var_01);
    if(isDefined(var_01) && var_01 != param_00) {
      self disableplayeruse(var_01);
    }
  }
}

func_57E5(param_00, param_01) {
  return getsubstr(param_00, 0, param_01.size) == param_01;
}

func_2F6D() {
  level.var_5A74 = 1;
}

func_3653() {
  level.var_5A74 = undefined;
}

func_0F5C() {
  return !isDefined(level.var_5A74) || !level.var_5A74;
}

func_A27A(param_00, param_01) {
  if(isDefined(param_00)) {
    var_02 = param_00;
  } else {
    var_03 = self.var_012C["killstreaks"];
    var_02 = var_03[self.var_5A69].var_944C;
  }

  if(isDefined(level.var_5A74) && level.var_5A74) {
    return 0;
  }

  if(isDefined(self.var_5A74) && self.var_5A74) {
    return 0;
  }

  if(getdvarint("scorestreak_enabled_" + var_02) == 0) {
    return 0;
  }

  if(!self isonground() && func_57AD(var_02)) {
    return 0;
  }

  if(func_581D() || func_572D()) {
    return 0;
  }

  if(isDefined(self.var_83AF)) {
    return 0;
  }

  if(!func_3FA0("prematch_done")) {
    return 0;
  }

  if(func_8BA1(var_02) && level.var_5A70) {
    var_04 = 0;
    if(isDefined(level.var_7690)) {
      var_04 = gettime() - level.var_7690 / 1000;
    }

    if(var_04 < level.var_5A70) {
      var_05 = int(level.var_5A70 - var_04 + 0.5);
      if(!var_05) {
        var_05 = 1;
      }

      if(!isDefined(param_01) && param_01) {
        self iclientprintlnbold(&"MP_UNAVAILABLE_FOR_N", var_05);
      }

      return 0;
    }
  }

  if(func_56D7() && !isDefined(level.var_585D) || !level.var_585D) {
    if(!isDefined(param_01) && param_01) {
      if(isDefined(level.var_35F7) && level.var_35F7 > 0) {
        self iclientprintlnbold(&"MP_UNAVAILABLE_FOR_N_WHEN_EMP", level.var_35F7);
      } else if(isDefined(self.var_35EF) && int(self.var_35EF - gettime() / 1000) > 0) {
        self iclientprintlnbold(&"MP_UNAVAILABLE_FOR_N", int(self.var_35EF - gettime() / 1000));
      }
    }

    return 0;
  }

  if(self isusingturret() && func_57AD(var_02) || func_56A6(var_02)) {
    if(!isDefined(param_01) && param_01) {
      self iclientprintlnbold(&"MP_UNAVAILABLE_USING_TURRET");
    }

    return 0;
  }

  if(isDefined(self.var_00E8) && !func_0649("specialty_finalstand")) {
    if(!isDefined(param_01) && param_01) {
      self iclientprintlnbold(&"MP_UNAVILABLE_IN_LASTSTAND");
    }

    return 0;
  }

  if(!common_scripts\utility::func_5851()) {
    return 0;
  }

  return 1;
}

func_57AD(param_00) {
  return 0;
}

func_56A6(param_00) {
  switch (param_00) {
    case "remote_mg_sentry_turret":
    case "deployable_exp_ammo":
    case "sentry":
    case "deployable_grenades":
    case "deployable_ammo":
      return 1;

    default:
      return 0;
  }
}

func_8BA1(param_00) {
  switch (param_00) {
    case "plane_gunner":
    case "v2_rocket":
    case "fighter_strike":
    case "firebomb":
    case "airstrike":
    case "missile_strike":
    case "mortar_strike":
    case "fritzx":
      return 1;
  }

  return 0;
}

func_3153(param_00) {
  switch (param_00) {
    case "plane_gunner":
    case "v2_rocket":
    case "fighter_strike":
    case "firebomb":
    case "missile_strike":
    case "mortar_strike":
      return 1;
  }

  return 0;
}

func_573A(param_00) {
  switch (param_00) {
    case "refill_grenades":
    case "speed_boost":
    case "eyes_on":
    case "high_value_target":
    case "recon_agent":
    case "agent":
    case "placeable_barrier":
    case "deployable_juicebox":
    case "deployable_grenades":
    case "deployable_ammo":
      return 0;

    default:
      return 1;
  }
}

func_573B(param_00) {
  return func_573A(param_00) && !func_56F7(param_00);
}

func_56F7(param_00) {
  switch (param_00) {
    case "orbital_strike_drone":
    case "orbital_strike_cluster":
    case "orbital_strike_laser_chem":
    case "orbital_strike_chem":
    case "orbital_strike_laser":
    case "orbital_strike":
    case "orbital_carepackag":
    case "orbitalsupport":
    case "airdrop_support":
    case "airdrop_assault":
    case "airdrop_sentry_minigun":
    case "missile_strike":
      return 0;

    default:
      return 1;
  }
}

func_4545(param_00) {
  return tablelookuprownum("mp/killstreakTable.csv", 1, param_00);
}

func_453F(param_00) {
  var_01 = tablelookup("mp/killstreakTable.csv", 1, param_00, 0);
  if(var_01 == "") {
    var_02 = -1;
  } else {
    var_02 = int(var_02);
  }

  return var_02;
}

func_4543(param_00) {
  return tablelookup("mp/killstreakTable.csv", 1, param_00, 1);
}

func_4541(param_00) {
  return function_01AF("mp/killstreakTable.csv", 1, param_00, 2);
}

func_4544(param_00) {
  return tablelookup("mp/killstreakTable.csv", 0, param_00, 1);
}

func_4534(param_00) {
  return function_01AF("mp/killstreakTable.csv", 1, param_00, 3);
}

func_4531(param_00) {
  return tablelookup("mp/killstreakTable.csv", 1, param_00, 4);
}

func_453C(param_00) {
  return tablelookup("mp/killstreakTable.csv", 1, param_00, 5);
}

func_4548(param_00) {
  return tablelookup("mp/killstreakTable.csv", 1, param_00, 6);
}

getkillstreakesportscost(param_00) {
  return tablelookup("mp/killstreakTable.csv", 1, param_00, 33);
}

getkillstreakkills(param_00) {
  return tablelookup("mp/killstreakTable.csv", 1, param_00, 7);
}

getkillstreakhardlinekills(param_00) {
  return tablelookup("mp/killstreakTable.csv", 1, param_00, 8);
}

getkillstreaksupportkills(param_00) {
  return tablelookup("mp/killstreakTable.csv", 1, param_00, 9);
}

func_4538(param_00) {
  return function_01AF("mp/killstreakTable.csv", 1, param_00, 10);
}

func_4547(param_00) {
  return tablelookup("mp/killstreakTable.csv", 1, param_00, 11);
}

func_4537(param_00) {
  return tablelookup("mp/killstreakTable.csv", 1, param_00, 12);
}

func_4530(param_00) {
  return tablelookup("mp/killstreakTable.csv", 1, param_00, 13);
}

func_4539(param_00) {
  return tablelookup("mp/killstreakTable.csv", 1, param_00, 14);
}

func_453A(param_00) {
  return int("mp/killstreakTable.csv", 1, param_00, 15);
}

func_454A(param_00, param_01, param_02) {
  var_03 = tablelookup("mp/killstreakTable.csv", 1, param_00, 16);
  if(func_579B() && common_scripts\utility::func_562E(level.var_79C1)) {
    param_01 = func_45DE(param_01);
  }

  if(isDefined(param_01) && param_01 == "axis") {
    var_04 = tablelookup("mp/killstreakTable.csv", 1, param_00, 29);
    if(isDefined(var_04) && var_04 != "") {
      var_03 = var_04;
    }
  }

  if(isDefined(param_02) && param_02) {
    var_05 = tablelookup("mp/killstreakTable.csv", 1, param_00, 31);
    if(isDefined(var_05) && var_05 != "") {
      var_03 = var_05;
    }

    if(isDefined(param_01) && param_01 == "axis") {
      var_06 = tablelookup("mp/killstreakTable.csv", 1, param_00, 32);
      if(isDefined(var_06) && var_06 != "") {
        var_03 = var_06;
      }
    }
  }

  return var_03;
}

func_4546(param_00) {
  return tablelookup("mp/killstreakTable.csv", 1, param_00, 17);
}

func_453E(param_00) {
  return tablelookup("mp/killstreakTable.csv", 1, param_00, 18);
}

func_4542(param_00) {
  return tablelookup("mp/killstreakTable.csv", 1, param_00, 19);
}

func_4536(param_00) {
  return tablelookup("mp/killstreakTable.csv", 1, param_00, 23);
}

func_4549(param_00) {
  return tablelookup("mp/killstreakTable.csv", 1, param_00, 24);
}

func_2924(param_00) {
  if(!isDefined(param_00)) {
    param_00 = 0;
  }

  var_01 = param_00;
  if(isDefined(level.var_4C9C)) {
    var_01 = var_01 + level.var_4C9C.size;
  }

  if(isDefined(level.var_7043)) {
    var_01 = var_01 + level.var_7043.size;
  }

  if(isDefined(level.var_9FEA)) {
    var_01 = var_01 + level.var_9FEA.size;
  }

  return var_01;
}

func_60A6() {
  return 8;
}

func_50FD() {
  level.var_3A62++;
}

func_2B78() {
  level.var_3A62--;
  if(level.var_3A62 < 0) {
    level.var_3A62 = 0;
  }
}

func_0C2D() {
  if(!function_02BD() && getdvarint("scr_skipclasschoice", 0) > 0) {
    return 0;
  }

  var_00 = int(tablelookup("mp/gametypesTable.csv", 0, level.var_3FDC, 4));
  return var_00;
}

func_0C1E() {
  if(!function_02BD() && getdvarint("scr_skipclasschoice", 0) > 0) {
    return 0;
  }

  if(isprophuntgametype() && !level.phsettings.allowloadouts || !isDefined(self.var_01A7) || self.var_01A7 == game["defenders"]) {
    return 0;
  }

  var_00 = int(tablelookup("mp/gametypesTable.csv", 0, level.var_3FDC, 5));
  return var_00;
}

func_8BFD() {
  if(func_0C2D() || func_0C1E()) {
    return 0;
  }

  var_00 = int(tablelookup("mp/gametypesTable.csv", 0, level.var_3FDC, 7));
  return var_00;
}

func_5693(param_00, param_01) {
  return 0;
}

func_8653(param_00) {
  var_01 = getmatchrulesdata("commonOption", "timeLimit");
  setdynamicdvar("scr_" + level.var_3FDC + "_timeLimit", var_01);
  func_7BFA(level.var_3FDC, var_01);
  var_02 = getmatchrulesdata("commonOption", "scoreLimit");
  setdynamicdvar("scr_" + level.var_3FDC + "_scoreLimit", var_02);
  func_7BF9(level.var_3FDC, var_02);
  setdynamicdvar("scr_game_matchstarttime", getmatchrulesdata("commonOption", "preMatchTimer"));
  setdynamicdvar("scr_game_roundstarttime", getmatchrulesdata("commonOption", "preRoundTimer"));
  setdynamicdvar("scr_game_suicidespawndelay", getmatchrulesdata("commonOption", "suicidePenalty"));
  setdynamicdvar("scr_team_teamkillspawndelay", getmatchrulesdata("commonOption", "teamKillPenalty"));
  setdynamicdvar("scr_team_teamkillkicklimit", getmatchrulesdata("commonOption", "teamKillKickLimit"));
  var_03 = getmatchrulesdata("commonOption", "numLives");
  setdynamicdvar("scr_" + level.var_3FDC + "_numLives", var_03);
  func_7BF1(level.var_3FDC, var_03);
  setdynamicdvar("scr_player_maxhealth", getmatchrulesdata("commonOption", "maxHealth"));
  setdynamicdvar("scr_player_healthregentime", getmatchrulesdata("commonOption", "healthRegen"));
  level.var_6031 = 0;
  level.var_6035 = 0;
  setdynamicdvar("scr_game_spectatetype", getmatchrulesdata("commonOption", "spectateModeAllowed"));
  setdynamicdvar("scr_game_lockspectatorpov", getmatchrulesdata("commonOption", "spectateModePOV"));
  setdynamicdvar("scr_game_allowkillcam", getmatchrulesdata("commonOption", "showKillcam"));
  setdynamicdvar("scr_game_forceuav", getmatchrulesdata("commonOption", "radarMode") == 2);
  setdynamicdvar("scr_game_radarMode", getmatchrulesdata("commonOption", "radarMode"));
  setdynamicdvar("scr_" + level.var_3FDC + "_playerrespawndelay", getmatchrulesdata("commonOption", "respawnDelay"));
  setdynamicdvar("scr_" + level.var_3FDC + "_waverespawndelay", getmatchrulesdata("commonOption", "waveRespawnDelay"));
  setdynamicdvar("scr_player_forcerespawn", getmatchrulesdata("commonOption", "forceRespawn"));
  level.var_6030 = getmatchrulesdata("commonOption", "allowCustomClasses");
  level.var_297A = getmatchrulesdata("commonOption", "classPickCount");
  setdynamicdvar("scr_game_hardpoints", 1);
  setdynamicdvar("scr_game_perks", 1);
  setdynamicdvar("2043", getmatchrulesdata("commonOption", "hardcoreModeOn"));
  setdynamicdvar("scr_thirdPerson", getmatchrulesdata("commonOption", "forceThirdPersonView"));
  setdynamicdvar("311", getmatchrulesdata("commonOption", "forceThirdPersonView"));
  setdynamicdvar("scr_game_onlyheadshots", getmatchrulesdata("commonOption", "headshotsOnly"));
  if(!isDefined(param_00)) {
    setdynamicdvar("scr_team_fftype", getmatchrulesdata("commonOption", "ffType"));
  }

  setdynamicdvar("scr_game_killstreakdelay", getmatchrulesdata("commonOption", "streakGracePeriod"));
  level.var_352F = 1;
  level.var_5FF1 = 1;
  level.mgnestsdisabled = getmatchrulesdata("commonOption", "disableMGNests");
  level.var_212F = getmatchrulesdata("commonOption", "chatterDisabled");
  level.var_0F05 = getmatchrulesdata("commonOption", "announcerDisabled");
  level.var_6034 = getmatchrulesdata("commonOption", "switchTeamDisabled");
  level.var_4867 = getmatchrulesdata("commonOption", "grenadeGracePeriod");
  setdynamicdvar("scr_oneShot", getmatchrulesdata("commonOption", "oneShotMode"));
  if(getdvarint("scr_oneShot", 0) == 1 || getdvarint("scr_wanderlustOnly", 0) == 1) {
    level.var_2FAB = 1;
    level.disabledivisionstats = 1;
    level.var_2F8B = 1;
    level.disableallplayerstats = 1;
    level.disableweaponchallenges = 1;
    level.disabledivisionchallenges = 1;
    level.disablewinlossstats = 1;
    level.mgnestsdisabled = 1;
  }

  if(getmatchrulesdata("commonOption", "hardcoreModeOn")) {
    setdynamicdvar("scr_team_fftype", 1);
    setdynamicdvar("scr_player_maxhealth", 30);
    setdynamicdvar("scr_player_healthregentime", 0);
    setdynamicdvar("scr_player_respawndelay", 10);
    setdynamicdvar("scr_game_allowkillcam", 0);
    setdynamicdvar("scr_game_forceuav", 0);
    setdynamicdvar("scr_game_radarMode", 0);
  }

  if(function_0371() || function_02A4()) {
    setDvar("1689", getmatchrulesdata("commonOption", "broadcasterEnabled"));
  }

  setDvar("isMLGMatch", getmatchrulesdata("commonOption", "isMLGMatch"));
  setDvar("isEsportsMatch", getmatchrulesdata("commonOption", "isEsportsMatch"));
  setDvar("spawning_use_classic", getmatchrulesdata("commonOption", "useClassicSpawning"));
  setDvar("4899", getDvar("scr_game_forceuav"));
  setDvar("4648", getDvar("scr_game_compassRadarUpdateTime"));
}

func_7C13() {
  for(;;) {
    level waittill("host_migration_begin");
    [[level.var_5300]]();
  }
}

func_7C15(param_00) {
  self endon("disconnect");
  if(isDefined(param_00)) {
    param_00 endon("death");
  }

  for(;;) {
    level waittill("host_migration_begin");
    if(isDefined(self.var_5C0E)) {
      self visionsetthermalforplayer(self.var_5C0E, 0);
    }
  }
}

func_4573(param_00, param_01) {
  var_02 = [];
  var_02["loadoutDivision"] = getmatchrulesdata("defaultClasses", param_00, "defaultClass", param_01, "class", "division");
  var_02["loadoutPrimaryWeaponStruct"] = func_473C(getmatchrulesdata("defaultClasses", param_00, "defaultClass", param_01, "class", "weaponSetups", 0, "weapon"), 0);
  for(var_03 = 0; var_03 < 6; var_03++) {
    var_02["loadoutPrimaryAttachmentsGUID"][var_03] = getmatchrulesdata("defaultClasses", param_00, "defaultClass", param_01, "class", "weaponSetups", 0, "attachment", var_03);
  }

  var_02["loadoutPrimaryCamoGUID"] = getmatchrulesdata("defaultClasses", param_00, "defaultClass", param_01, "class", "weaponSetups", 0, "camo");
  var_02["loadoutPrimaryCamo2GUID"] = getmatchrulesdata("defaultClasses", param_00, "defaultClass", param_01, "class", "weaponSetups", 0, "camo2");
  var_02["loadoutPrimaryReticleGUID"] = getmatchrulesdata("defaultClasses", param_00, "defaultClass", param_01, "class", "weaponSetups", 0, "reticle");
  var_02["loadoutPrimaryPaintjobId"] = getmatchrulesdata("defaultClasses", param_00, "defaultClass", param_01, "class", "weaponSetups", 0, "paintjob");
  var_02["loadoutPrimaryCharmGUID"] = getmatchrulesdata("defaultClasses", param_00, "defaultClass", param_01, "class", "weaponSetups", 0, "charm");
  var_02["loadoutSecondaryWeaponStruct"] = func_473C(getmatchrulesdata("defaultClasses", param_00, "defaultClass", param_01, "class", "weaponSetups", 1, "weapon"), 0);
  for(var_03 = 0; var_03 < 6; var_03++) {
    var_02["loadoutSecondaryAttachmentsGUID"][var_03] = getmatchrulesdata("defaultClasses", param_00, "defaultClass", param_01, "class", "weaponSetups", 1, "attachment", var_03);
  }

  var_02["loadoutSecondaryCamoGUID"] = getmatchrulesdata("defaultClasses", param_00, "defaultClass", param_01, "class", "weaponSetups", 1, "camo");
  var_02["loadoutSecondaryCamo2GUID"] = getmatchrulesdata("defaultClasses", param_00, "defaultClass", param_01, "class", "weaponSetups", 1, "camo2");
  var_02["loadoutSecondaryReticleGUID"] = getmatchrulesdata("defaultClasses", param_00, "defaultClass", param_01, "class", "weaponSetups", 1, "reticle");
  var_02["loadoutSecondaryPaintjobId"] = getmatchrulesdata("defaultClasses", param_00, "defaultClass", param_01, "class", "weaponSetups", 1, "paintjob");
  var_02["loadoutSecondaryCharmGUID"] = getmatchrulesdata("defaultClasses", param_00, "defaultClass", param_01, "class", "weaponSetups", 1, "charm");
  var_02["loadoutEquipmentStruct"] = func_44CE(getmatchrulesdata("defaultClasses", param_00, "defaultClass", param_01, "class", "equipmentSetups", 0, "equipment"), 0);
  var_02["loadoutEquipmentNumExtra"] = getmatchrulesdata("defaultClasses", param_00, "defaultClass", param_01, "class", "equipmentSetups", 0, "numExtra");
  var_02["loadoutOffhandStruct"] = func_44CE(getmatchrulesdata("defaultClasses", param_00, "defaultClass", param_01, "class", "equipmentSetups", 1, "equipment"), 0);
  var_02["loadoutOffhandNumExtra"] = getmatchrulesdata("defaultClasses", param_00, "defaultClass", param_01, "class", "equipmentSetups", 1, "numExtra");
  for(var_03 = 0; var_03 < 9; var_03++) {
    var_02["loadoutPerksGUID"][var_03] = getmatchrulesdata("defaultClasses", param_00, "defaultClass", param_01, "class", "perkSlots", var_03);
  }

  for(var_03 = 0; var_03 < 4; var_03++) {
    var_02["loadoutKillstreaksGUID"][var_03] = getmatchrulesdata("defaultClasses", param_00, "defaultClass", param_01, "class", "assaultStreaks", var_03, "streak");
  }

  var_02["loadoutJuggernaut"] = getmatchrulesdata("defaultClasses", param_00, "defaultClass", param_01, "juggernaut");
  return var_02;
}

removemgnestsfromlevel() {
  var_00 = getEntArray("misc_turret", "classname");
  if(isDefined(var_00)) {
    foreach(var_02 in var_00) {
      var_02 delete();
    }
  }
}

func_A165(param_00) {
  self.var_0178 = param_00;
  self setclientomnvar("ui_session_state", param_00);
}

func_1E01() {
  if(isDefined(level.var_3E0E)) {
    return level.var_3E0E;
  }

  if(function_02A4() || !function_03AC() || func_5385()) {
    return "privateMatchCustomClasses";
  }

  if(function_03AF() || common_scripts\utility::func_562E(self.inrankedlobby)) {
    return "competitiveCustomClasses";
  }

  return "customClasses";
}

func_5385() {
  if(isDefined(self.var_537B)) {
    return self.var_537B == 2;
  }

  return 0;
}

func_5387() {
  if(isDefined(self.var_537B)) {
    return self.var_537B == 1;
  }

  return 0;
}

func_537D() {
  var_00 = func_5385();
  var_01 = func_5387();
  return var_00 || var_01;
}

func_445D(param_00) {
  if(isDefined(level.var_2321[param_00])) {
    return level.var_2321[param_00];
  }

  return 0;
}

func_57FF() {
  var_00 = func_455E(self.var_01A7);
  foreach(var_02 in var_00) {
    if(var_02 != self && !isDefined(var_02.var_00E8) || !var_02.var_00E8) {
      return 0;
    }
  }

  return 1;
}

func_5A7F(param_00) {
  var_01 = func_455E(param_00);
  foreach(var_03 in var_01) {
    if(isDefined(var_03.var_00E8) && var_03.var_00E8) {
      var_03 thread maps\mp\gametypes\_damage::func_2EEF(randomintrange(1, 3));
    }
  }
}

func_955C(param_00) {
  if(!isai(self)) {
    self switchtoweapon(param_00);
    return;
  }

  self switchtoweapon("none");
}

func_955D(param_00) {
  if(!isai(self)) {
    self method_86A5(param_00);
    return;
  }

  self method_86A5("none");
}

func_566A(param_00) {
  if(function_01EF(param_00) && param_00.var_0A4A == 1) {
    return 1;
  }

  if(isbot(param_00)) {
    return 1;
  }

  return 0;
}

func_5800(param_00) {
  if(func_566A(param_00)) {
    return 1;
  }

  if(isPlayer(param_00)) {
    return 1;
  }

  return 0;
}

func_5666(param_00) {
  if(function_01EF(param_00) && param_00.var_0A42 == 1) {
    return 1;
  }

  if(isbot(param_00)) {
    return 1;
  }

  return 0;
}

func_56FF(param_00) {
  if(func_5666(param_00)) {
    return 1;
  }

  if(isPlayer(param_00)) {
    return 1;
  }

  return 0;
}

func_46D4(param_00) {
  var_01 = 0;
  if(level.var_984D) {
    switch (param_00) {
      case "axis":
        var_01 = 1;
        break;

      case "allies":
        var_01 = 2;
        break;
    }
  }

  return var_01;
}

func_5755(param_00) {
  return param_00 == "MOD_MELEE";
}

func_5695(param_00) {
  return param_00 == "MOD_RIFLE_BULLET" || param_00 == "MOD_PISTOL_BULLET" || param_00 == "MOD_HEAD_SHOT";
}

func_56E5(param_00) {
  return param_00 == "MOD_GRENADE" || param_00 == "MOD_GRENADE_SPLASH" || param_00 == "MOD_PROJECTILE" || param_00 == "MOD_PROJECTILE_SPLASH" || param_00 == "MOD_EXPLOSIVE";
}

func_5697(param_00, param_01) {
  return param_00 == "MOD_BURNED" || param_00 == "MOD_BURNED_OVER_TIME";
}

func_570A(param_00, param_01, param_02, param_03) {
  if(isDefined(param_03)) {
    if(isDefined(param_03.var_0117)) {
      if(function_02BD() && !isDefined(param_03.var_003B)) {
        return 0;
      }

      if(param_03.var_003B == "script_vehicle") {
        return 0;
      }

      if(param_03.var_003B == "misc_turret") {
        return 0;
      }

      if(param_03.var_003B == "script_model") {
        return 0;
      }
    }

    if(isDefined(param_03.var_0A4B)) {
      if(param_03.var_0A4B == "dog") {
        return 0;
      }
    }
  }

  return (param_01 == "head" || param_01 == "helmet") && !func_5755(param_02) && (func_45B5(param_00) == "dp28_mp" || param_02 != "MOD_IMPACT") && !func_56DF(param_00);
}

func_5670(param_00) {
  if(param_00 == "none") {
    return 0;
  }

  return function_01D4(param_00) == "altmode";
}

func_118D(param_00, param_01) {
  if(isDefined(param_00) && isDefined(param_01) && function_01EF(param_00) && isDefined(param_00.var_0A4B) && param_00.var_0A4B == "leprechauns") {
    return 0;
  }

  if(isDefined(param_00) && isDefined(param_01) && function_01EF(param_00) && isDefined(param_00.var_0A4B) && param_00.var_0A4B == "mp_zombie_generic") {
    return 0;
  }

  if(isDefined(param_00) && isDefined(param_01) && function_01EF(param_01) && isDefined(param_01.var_0A4B) && param_01.var_0A4B == "paratroopers" && isDefined(param_01.var_0117) && param_01.var_0117 == param_00) {
    return 1;
  }

  if(!level.var_984D) {
    return 0;
  }

  if(function_0367() && isDefined(param_01) && isDefined(param_00) && isDefined(param_01.var_572A) && isDefined(param_00.var_572A) && param_01.var_572A && param_00.var_572A) {
    return 0;
  }

  if(!isDefined(param_01) || !isDefined(param_00)) {
    return 0;
  }

  if(!isDefined(param_00.var_01A7) || !isDefined(param_01.var_01A7)) {
    return 0;
  }

  if(param_00 == param_01) {
    return 0;
  }

  if(isDefined(param_01.var_984E) && param_00.var_012C["team"] == param_01.var_01A7) {
    return 0;
  }

  if(isDefined(param_01.var_80D7) && param_01.var_80D7) {
    return 0;
  }

  if(param_00.var_01A7 == param_01.var_01A7) {
    return 1;
  }

  return 0;
}

playerhaskillstreak(param_00, param_01) {
  foreach(var_03 in param_00.var_012C["killstreaks"]) {
    if(isDefined(var_03.var_944C) && var_03.var_944C == param_01) {
      return 1;
    }
  }

  return 0;
}

func_84D3(param_00) {
  if(!isDefined(self.var_4D3C) && common_scripts\utility::func_0F79(self.var_4D3C, param_00)) {
    self.var_4D3C = common_scripts\utility::func_0F6F(self.var_4D3C, param_00);
    param_00 notify("calculate_new_level_targets");
  }
}

func_0974(param_00, param_01) {
  if(isDefined(level.var_19D5) && isDefined(level.var_19D5["bots_add_to_level_targets"])) {
    param_00.var_A1F5 = param_01;
    param_00.var_1A23 = "use";
    [[level.var_19D5["bots_add_to_level_targets"]]](param_00);
  }
}

func_7C8D(param_00) {
  if(isDefined(level.var_19D5) && isDefined(level.var_19D5["bots_remove_from_level_targets"])) {
    [[level.var_19D5["bots_remove_from_level_targets"]]](param_00);
  }
}

func_0973(param_00) {
  if(isDefined(level.var_19D5) && isDefined(level.var_19D5["bots_add_to_level_targets"])) {
    param_00.var_1A23 = "damage";
    [[level.var_19D5["bots_add_to_level_targets"]]](param_00);
  }
}

func_7C8C(param_00) {
  if(isDefined(level.var_19D5) && isDefined(level.var_19D5["bots_remove_from_level_targets"])) {
    [[level.var_19D5["bots_remove_from_level_targets"]]](param_00);
  }
}

func_67F4(param_00) {
  if(isDefined(level.var_19D5) && isDefined(level.var_19D5["notify_enemy_bots_bomb_used"])) {
    self[[level.var_19D5["notify_enemy_bots_bomb_used"]]](param_00);
  }
}

func_42EC() {
  if(isDefined(level.var_19D5) && isDefined(level.var_19D5["bot_get_rank_xp_and_prestige"])) {
    return self[[level.var_19D5["bot_get_rank_xp_and_prestige"]]]();
  }
}

func_8568() {
  var_00 = func_42EC();
  if(isDefined(var_00)) {
    self.var_012C["rankxp"] = var_00.var_7A6D;
    self.var_012C["prestige"] = var_00.var_76B0;
    self.var_012C["prestige_fake"] = var_00.var_76B0;
  }
}

func_8567() {
  if(isDefined(level.var_19D5) && isDefined(level.var_19D5["bot_set_rank_options"])) {
    self[[level.var_19D5["bot_set_rank_options"]]]();
  }
}

func_843E() {
  if(!isDefined(level.var_258F)) {
    level.var_258F = getDvar("5554") == "true";
  } else {}

  if(!isDefined(level.var_01D4)) {
    level.var_01D4 = getDvar("3475") == "true";
  } else {}

  if(!isDefined(level.var_01D5)) {
    level.var_01D5 = getDvar("2695") == "true";
  } else {}

  if(!isDefined(level.var_0148)) {
    level.var_0148 = getDvar("3864") == "true";
  } else {}

  if(!isDefined(level.var_0149)) {
    level.var_0149 = getDvar("3957") == "true";
  }
}

func_5583() {
  if(level.var_01D4 || level.var_0148 || !level.var_258F) {
    return 1;
  }

  return 0;
}

func_8670(param_00, param_01, param_02) {
  if(!isDefined(level.var_258F) || !isDefined(level.var_01D4) || !isDefined(level.var_0148)) {
    func_843E();
  }

  if(func_5583()) {
    setDvar(param_00, param_02);
    return;
  }

  setDvar(param_00, param_01);
}

func_583E(param_00, param_01) {
  return isDefined(param_01.var_01A7) && param_01.var_01A7 != param_00.var_01A7;
}

func_5828(param_00, param_01) {
  return isDefined(param_01.var_0117) && param_01.var_0117 != param_00;
}

func_4507() {
  return (0, 0, 5000);
}

func_4508() {
  return (0, 0, 2500);
}

func_7E50(param_00) {
  if(!isDefined(param_00)) {
    param_00 = 1;
  }

  if(isDefined(level.var_6859) && isDefined(level.var_6869)) {
    self method_8483(level.var_6869, param_00);
    self visionsetnakedforplayer(level.var_6869, param_00);
    func_85F0(level.var_6869, param_00);
    return;
  }

  if(isDefined(self.var_A25C) && isDefined(self.var_7E7B)) {
    self method_8483(self.var_7E7B, param_00);
    self visionsetnakedforplayer(self.var_7E7B, param_00);
    func_85F0(self.var_7E7B, param_00);
    return;
  }

  self method_8483("", param_00);
  self visionsetnakedforplayer("", param_00);
  func_85F0("", param_00);
}

func_8513(param_00) {
  if(!isPlayer(self)) {
    return;
  }

  if(isDefined(level.var_5D79)) {
    level.var_5D7A = level.var_5D79;
  }

  level.var_5D79 = param_00;
  self lightsetforplayer(param_00);
}

func_23C0() {
  if(!isPlayer(self)) {
    return;
  }

  var_00 = getmapcustom("map");
  if(isDefined(level.var_5D7A)) {
    var_00 = level.var_5D7A;
    level.var_5D7A = undefined;
  }

  level.var_5D79 = var_00;
  self lightsetforplayer(var_00);
}

func_5D22(param_00, param_01, param_02, param_03) {
  if(!isPlayer(self)) {
    return;
  }

  self lightsetoverrideenableforplayer(param_00, param_01);
  func_A6D0(param_02, ["death", "disconnect"]);
  if(isDefined(self)) {
    self method_83C8(param_03);
  }
}

func_4704() {
  if(isDefined(self.var_012C["guid"])) {
    return self.var_012C["guid"];
  }

  var_00 = self getguid();
  if(var_00 == "0000000000000000") {
    if(isDefined(level.var_48CB)) {
      level.var_48CB++;
    } else {
      level.var_48CB = 1;
    }

    var_00 = "script" + level.var_48CB;
  }

  self.var_012C["guid"] = var_00;
  return self.var_012C["guid"];
}

func_42B8(param_00, param_01) {
  if(!isDefined(param_00)) {
    param_00 = 0;
  }

  if(!isDefined(param_01)) {
    param_01 = 0;
  }

  var_02 = self getentitynumber();
  var_03 = [];
  foreach(var_05 in level.var_744A) {
    if(!isDefined(var_05) || var_05 == self) {
      continue;
    }

    var_06 = 0;
    if(!param_01) {
      if((isDefined(var_05.var_01A7) && var_05.var_01A7 == "spectator") || var_05.var_0178 == "spectator") {
        var_07 = var_05 getspectatingplayer();
        if(isDefined(var_07) && var_07 == self) {
          var_06 = 1;
        }
      }

      if(var_05.var_009F == var_02) {
        var_06 = 1;
      }
    }

    if(!param_00) {
      if(var_05.var_00E1 == var_02) {
        var_06 = 1;
      }
    }

    if(var_06) {
      var_03[var_03.size] = var_05;
    }
  }

  return var_03;
}

func_85F0(param_00, param_01, param_02, param_03, param_04, param_05, param_06) {
  var_07 = func_42B8(param_04, param_05);
  foreach(var_09 in var_07) {
    var_09 notify("changing_watching_visionset");
    if(isDefined(param_03) && param_03) {
      var_09 visionsetmissilecamforplayer(param_00, param_01);
    } else if(isDefined(param_06) && param_06) {
      var_09 visionsetpostapplyforplayer(param_00, param_01);
    } else {
      var_09 visionsetnakedforplayer(param_00, param_01);
    }

    if(param_00 != "" && isDefined(param_02)) {
      var_09 thread func_7D4B(self, param_01 + param_02, param_06);
      var_09 thread func_7D49(self, param_06);
      if(var_09 func_5727()) {
        var_09 thread func_7D4A();
      }
    }
  }
}

func_7D4A() {
  self endon("disconnect");
  self waittill("spawned");
  self visionsetnakedforplayer("", 0);
  self visionsetpostapplyforplayer("", 0);
}

func_7D4B(param_00, param_01, param_02) {
  self endon("changing_watching_visionset");
  param_00 endon("disconnect");
  var_03 = gettime();
  var_04 = self.var_01A7;
  while(gettime() - var_03 < param_01 * 1000) {
    if(self.var_01A7 != var_04 || !common_scripts\utility::func_0F79(param_00 func_42B8(), self)) {
      if(isDefined(param_02) && param_02) {
        self visionsetpostapplyforplayer("", 0);
      } else {
        self visionsetnakedforplayer("", 0);
      }

      self notify("changing_visionset");
      break;
    }

    wait 0.05;
  }
}

func_7D49(param_00, param_01) {
  self endon("changing_watching_visionset");
  param_00 waittill("disconnect");
  if(isDefined(param_01) && param_01) {
    self visionsetpostapplyforplayer("", 0);
    return;
  }

  self visionsetnakedforplayer("", 0);
}

func_073C(param_00) {
  if(function_01EF(param_00) && !isDefined(param_00.var_565F) || !param_00.var_565F) {
    return undefined;
  }

  return param_00;
}

func_06D6(param_00, param_01) {
  if(!isDefined(self.var_6609)) {
    self.var_6609 = [];
    self.var_76E2 = [];
  } else {
    self.var_76E2[0] = self.var_6609[0];
    self.var_76E2[1] = self.var_6609[1];
  }

  self.var_6609[0] = param_00;
  self.var_6609[1] = param_01;
  self method_83F4(param_00, param_01);
}

func_06AF() {
  if(isDefined(self.var_76E2)) {
    self method_83F4(self.var_76E2[0], self.var_76E2[1]);
  } else {
    self method_83F4("", "");
  }

  self.var_6609 = undefined;
  self.var_76E2 = undefined;
}

func_3B88(param_00, param_01) {
  var_02 = getEntArray(param_00, "targetname");
  if(var_02.size > 0) {
    foreach(var_04 in var_02) {
      var_05 = 0;
      if(isDefined(var_04.var_8109)) {
        if(isDefined(var_04.var_8260) && var_04.var_8260 == "delta_anim") {
          var_05 = 1;
        }

        var_04 thread func_71F5(param_01, var_05);
      }
    }
  }
}

func_71F5(param_00, param_01) {
  if(param_00 == 1) {
    wait(randomfloatrange(0, 1));
  }

  if(param_01 == 0) {
    self scriptmodelplayanim(self.var_8109);
    return;
  }

  self method_8278(self.var_8109);
}

func_73AF(param_00, param_01) {
  func_0693("dodge", param_00, param_01, ::method_8497);
}

func_0693(param_00, param_01, param_02, param_03, param_04) {
  if(!isDefined(self.var_73D4)) {
    self.var_73D4 = [];
  }

  if(!isDefined(self.var_73D4[param_00])) {
    self.var_73D4[param_00] = [];
  }

  if(!isDefined(param_02)) {
    param_02 = "default";
  }

  if(!isDefined(param_04)) {
    param_04 = 1;
  }

  if(param_01) {
    self.var_73D4[param_00] = common_scripts\utility::func_0F93(self.var_73D4[param_00], param_02);
    if(!self.var_73D4[param_00].size) {
      if(param_04) {
        self[[param_03]](1);
        return;
      }

      self[[param_03]](1);
      return;
    }

    return;
  }

  if(!isDefined(common_scripts\utility::func_0F7E(self.var_73D4[param_00], param_02))) {
    self.var_73D4[param_00] = common_scripts\utility::func_0F6F(self.var_73D4[param_00], param_02);
  }

  if(param_04) {
    self[[param_03]](0);
    return;
  }

  self[[param_03]](0);
}

func_5FBA(param_00, param_01, param_02, param_03) {
  var_04 = 500;
  switch (param_00) {
    case "killstreakRemote":
      var_04 = 300;
      break;

    case "coopStreakPrompt":
      var_04 = 301;
      break;

    default:
      break;
  }

  func_065E(var_04, param_00, param_02, param_03);
  self registerusable(var_04, param_02, param_03);
  self sethintstring(param_01);
  self setcursorhint("HINT_NOICON");
}

func_065E(param_00, param_01, param_02, param_03) {
  if(!isDefined(level.var_47E6)) {
    level.var_47E6 = [];
  }

  var_04 = -1;
  for(var_05 = 0; var_05 < level.var_47E6.size; var_05++) {
    var_06 = level.var_47E6[var_05];
    if(var_06.var_7734 > param_00) {
      if(var_04 == -1) {
        var_04 = var_05;
      }

      break;
    }

    if(var_06.var_7734 == param_00) {
      var_06.var_7734 = var_06.var_7734 + 0.01;
      if(var_06.var_3655) {
        var_06.var_378F registerusable(var_06.var_7734, var_06.var_721C, var_06.var_01A7);
      }

      if(var_04 == -1) {
        var_04 = var_05;
      }
    }
  }

  if(var_04 == -1) {
    var_04 = 0;
  }

  var_07 = spawnStruct();
  var_07.var_378F = self;
  var_07.var_7734 = param_00;
  var_07.var_01B9 = param_01;
  var_07.var_721C = param_02;
  var_07.var_01A7 = param_03;
  var_07.var_3655 = 1;
  level.var_47E6 = common_scripts\utility::func_0F86(level.var_47E6, var_07, var_04);
}

func_5FB9() {
  var_00 = undefined;
  foreach(var_02 in level.var_47E6) {
    if(var_02.var_378F == self) {
      var_00 = var_02;
      break;
    }
  }

  if(isDefined(var_00)) {
    var_04 = var_00.var_7734;
    level.var_47E6 = common_scripts\utility::func_0F93(level.var_47E6, var_00);
    self method_80B5();
    foreach(var_02 in level.var_47E6) {
      if(var_04 > var_02.var_7734 && int(var_04) == int(var_02.var_7734)) {
        var_02.var_7734 = var_02.var_7734 - 0.01;
        if(var_02.var_3655) {
          var_02.var_378F registerusable(var_02.var_7734, var_02.var_721C, var_02.var_01A7);
        }
      }
    }
  }
}

func_2F89() {
  foreach(var_01 in level.var_47E6) {
    if(var_01.var_378F == self) {
      if(var_01.var_3655) {
        var_01.var_378F method_80B5();
        var_01.var_3655 = 0;
      }

      break;
    }
  }
}

func_3659() {
  foreach(var_01 in level.var_47E6) {
    if(var_01.var_378F == self) {
      if(!var_01.var_3655) {
        var_01.var_378F registerusable(var_01.var_7734, var_01.var_721C, var_01.var_01A7);
        var_01.var_3655 = 1;
      }

      break;
    }
  }
}

func_8668(param_00) {
  self setdepthoffield(param_00["nearStart"], param_00["nearEnd"], param_00["farStart"], param_00["farEnd"], param_00["nearBlur"], param_00["farBlur"]);
}

func_86F8() {
  if(!isDefined(level.var_6F9D)) {
    return;
  }

  if(isDefined(level.var_6F9D["dofScripting"])) {
    self method_84B4(level.var_6F9D["dofScripting"]);
  }

  self method_84B7(level.var_6F9D["fstop"], level.var_6F9D["focus"], level.var_6F9D["focusSpeed"], level.var_6F9D["apertureSpeed"]);
  self method_84C9(level.var_6F9D["viewModelFstop"], level.var_6F9D["viewModelFocus"]);
}

func_86F7(param_00, param_01, param_02, param_03, param_04, param_05, param_06) {
  if(self method_8436()) {
    return;
  }

  if(!isDefined(level.var_6F9D)) {
    level.var_6F9D = [];
  }

  level.var_6F9D["fstop"] = param_00;
  level.var_6F9D["focus"] = param_01;
  level.var_6F9D["viewModelFstop"] = param_02;
  level.var_6F9D["viewModelFocus"] = param_03;
  level.var_6F9D["focusSpeed"] = param_04;
  level.var_6F9D["apertureSpeed"] = param_05;
  level.var_6F9D["dofScripting"] = param_06;
  func_86F8();
}

func_56D9(param_00) {
  if(level.var_984D) {
    return func_5781(param_00);
  }

  return func_577B(param_00);
}

func_5781(param_00) {
  return param_00.var_01A7 != self.var_01A7;
}

func_577B(param_00) {
  if(isDefined(param_00.var_0117)) {
    return param_00.var_0117 != self;
  }

  return param_00 != self;
}

func_56B4() {
  if(function_02A4() && getdvarint("4974")) {
    return 1;
  }

  return 0;
}

func_56B3() {
  if(issplitscreen() && getdvarint("4974")) {
    return 1;
  }

  return 0;
}

func_56B2() {
  if(func_773F() && getdvarint("4974")) {
    return 1;
  }

  return 0;
}

func_56B1() {
  if(getdvarint("isMLGMatch")) {
    return 1;
  }

  return 0;
}

func_9067(param_00, param_01, param_02, param_03) {
  var_04 = spawnfx(param_00, param_02, param_03);
  var_04 func_3F7B(param_01);
  return var_04;
}

func_3F7B(param_00) {
  thread func_8BFC(param_00);
  function_014E(self, 1);
  triggerfx(self);
}

func_8BFC(param_00) {
  self endon("death");
  level endon("game_ended");
  for(;;) {
    self method_805C();
    foreach(var_02 in level.var_744A) {
      var_03 = var_02.var_01A7;
      if(var_02 method_8436()) {
        var_03 = "broadcaster";
      } else if(var_03 != "axis") {
        var_03 = "allies";
      }

      if(param_00 == var_03 || param_00 == "neutral") {
        self showtoclient(var_02);
      }
    }

    level waittill("joined_team");
  }
}

func_74A3(param_00, param_01, param_02, param_03) {
  var_04 = spawnlinkedfx(param_00, param_01, param_02);
  triggerfx(var_04, param_03);
  return var_04;
}

func_9028(param_00, param_01, param_02, param_03, param_04, param_05) {
  var_06 = spawnlinkedfx(param_00, param_04, param_05);
  var_06 func_3F7A(param_01, param_02, param_03);
  return var_06;
}

func_3F7A(param_00, param_01, param_02) {
  thread func_8C1B(param_00, param_01, param_02);
  function_014E(self, 1);
  triggerfx(self);
}

func_8C1B(param_00, param_01, param_02) {
  self endon("death");
  level endon("game_ended");
  for(;;) {
    self method_805C();
    foreach(var_04 in level.var_744A) {
      var_05 = var_04.var_01A7;
      if(var_04 method_8436()) {
        var_05 = "broadcaster";
      } else if(var_05 != "axis") {
        var_05 = "allies";
      }

      var_06 = var_04 func_0649("specialty_stun_resistance");
      if((!param_02 && var_06) || param_01 == var_05 && var_04 == param_00 && !var_06) {
        continue;
      }

      if(param_01 == var_05 || param_01 == "neutral" || var_06 || param_01 != var_05 && var_04 == param_00) {
        self showtoclient(var_04);
      }
    }

    level waittill("joined_team");
  }
}

func_922B(param_00) {
  var_01 = issubstr(param_00, "zk383");
  if(isDefined(self.var_012C["altModeActive"]) && isDefined(self.var_0079) && self.var_012C["altModeActive"] && self.var_0079 != 5 && func_472A(param_00) == "weapon_smg" && issubstr(param_00, "suppressor") && !var_01) {
    var_02 = maps\mp\gametypes\_divisions::func_461C(1);
    if(var_02 == "suppressor_level1" || var_02 == "suppressor_level2" || var_02 == "suppressor_level3") {
      param_00 = "alt+" + param_00;
    }
  } else if(var_01 && common_scripts\utility::func_562E(self.var_012C["altModeActive"])) {
    param_00 = "alt+" + param_00;
  } else if(isDefined(self.var_0079) && self.var_0079 != 5 && func_472A(param_00) == "weapon_shotgun" && issubstr(param_00, "dragon_breath")) {}

  return param_00;
}

func_4340(param_00) {
  var_01 = "m1garand_mp";
  if(isDefined(param_00.var_76F8) && param_00.var_76F8 != "none") {
    var_01 = param_00.var_76F8;
    var_01 = func_922B(var_01);
  } else if(isDefined(param_00.var_8358) && param_00.var_8358 != "none") {
    var_01 = param_00.var_8358;
  } else if(isDefined(param_00.var_60EE) && param_00.var_60EE != "none") {
    var_01 = param_00.var_60EE;
  }

  return var_01;
}

func_744E() {
  self.var_7DEE = self getangles();
}

func_7447() {
  if(isDefined(self.var_7DEE)) {
    if(self.var_01A7 != "spectator") {
      self setangles(self.var_7DEE);
    }

    self.var_7DEE = undefined;
  }
}

func_863F(param_00, param_01, param_02, param_03) {
  param_00 maps\mp\gametypes\_gameobjects::func_860A("broadcaster", param_01, undefined, param_02);
  param_00 maps\mp\gametypes\_gameobjects::func_860E("broadcaster", param_01, param_02, param_03);
}

func_907D(param_00, param_01, param_02) {
  var_03 = getent(param_00, "targetname");
  if(!isDefined(var_03)) {
    return undefined;
  }

  var_04 = spawn("script_model", param_01);
  var_04 clonebrushmodeltoscriptmodel(var_03);
  var_04.var_001D = param_02;
  return var_04;
}

func_56B9() {
  if(isDefined(level.var_585D) && level.var_585D) {
    return 1;
  }

  return 0;
}

func_86BF(param_00) {
  var_01 = getEntArray();
  setomnvar("lighting_state", param_00);
  if(!getdvarint("233")) {
    foreach(var_03 in var_01) {
      if(isDefined(var_03.var_5D56) && isDefined(var_03.var_003A) && var_03.var_003A == "script_brushmodel" || var_03.var_003A == "script_model") {
        if(var_03.var_5D56 == 0) {
          continue;
        }

        if(var_03.var_5D56 == param_00) {
          var_03 common_scripts\utility::func_8BE0();
          var_03 allowriotshieldplant();
          continue;
        }

        var_03 notify("hidingLightingState");
        var_03 common_scripts\utility::func_4CEB();
      }
    }
  }
}

func_46E7() {
  return function_003E();
}

func_08F7() {
  if(isDefined(self.var_005C) && self.var_005C <= 0) {
    return undefined;
  }

  if(self.var_003A == "agent_enemy_dog_raid") {
    var_00 = [[level.var_0A4C]](undefined, undefined, self.var_0116, self.var_001D, undefined, 0, undefined, self.var_003A);
  } else {
    var_00 = [[level.var_0A4D]]("player", "axis", undefined, self.var_0116, self.var_001D, undefined, 0, 0, undefined, self.var_003A);
  }

  if(isDefined(var_00) && function_01EF(var_00)) {
    if(isDefined(level.var_0A41[var_00.var_0A4B]["set_initial_behavior"])) {
      self[[level.var_0A41[var_00.var_0A4B]["set_initial_behavior"]]](var_00);
    }

    if(isDefined(self.var_005C)) {
      self.var_005C--;
    }
  }

  return var_00;
}

func_0FA7(param_00, param_01) {
  if(!isDefined(param_01)) {
    param_01 = 0;
  }

  var_02 = [];
  foreach(var_04 in param_00) {
    if(isDefined(var_04.var_005C) && var_04.var_005C <= 0) {
      continue;
    }

    var_05 = var_04 func_08F7();
    if(!param_01) {}

    var_02[var_02.size] = var_05;
  }

  if(!param_01) {}

  return var_02;
}

func_8FE4(param_00, param_01, param_02, param_03) {
  if(isDefined(param_03) && param_03) {
    var_04 = getvehiclenode(param_00, "script_noteworthy");
  } else {
    var_04 = getvehiclenode(param_01, "targetname");
  }

  var_05 = spawnhelicopter(var_04.var_0116, var_04.var_001D, param_02, param_01);
  var_05 notify("forward");
  var_05.var_01C7 = "forward";
  var_05.var_01C1 = "forward";
  var_05.var_17DC = 0;
  var_05.var_931A = "forward";
  var_05 startpath(var_04);
  return var_05;
}

func_0FA8(param_00, param_01) {
  var_02 = getEntArray(param_00, "targetname");
  return func_0FA7(var_02, param_01);
}

func_853A(param_00) {
  if(!isDefined(level.var_738E)) {
    thread func_5243();
  }

  if(param_00) {
    self.var_738F = 1;
    return;
  }

  self.var_738F = undefined;
}

func_5243() {
  level.var_738E = 1;
  foreach(var_01 in level.var_744A) {
    var_01 thread func_A1CE();
  }

  for(;;) {
    level waittill("connected", var_01);
    var_01 thread func_A1CE();
  }
}

func_A1CE() {
  self endon("disconnect");
  var_00 = undefined;
  for(;;) {
    var_01 = self getusableentity();
    if(isDefined(var_01) && distance2dsquared(var_01.var_0116, self.var_0116) > pow(getdvarfloat("2098"), 2)) {
      var_01 = undefined;
    }

    if(isDefined(var_01) && !isDefined(var_00) || var_01 != var_00) {
      if(isDefined(var_01.var_738F)) {
        var_01 notify("player_usable_focus", self);
      }
    }

    if(isDefined(var_00) && !isDefined(var_01) || var_01 != var_00) {
      if(isDefined(var_00.var_738F)) {
        var_00 notify("player_usable_focus_end", self);
      }
    }

    wait 0.05;
    var_00 = var_01;
  }
}

func_461F() {
  if(isDefined(level.var_585D) && level.var_585D) {
    return common_scripts\utility::func_46A8();
  }

  if(function_03AC()) {
    return common_scripts\utility::func_46AE();
  }

  return common_scripts\utility::func_46A7();
}

func_461E() {
  if(function_03AC()) {
    return "rankedloadouts";
  }

  return "privateloadouts";
}

func_86FB() {
  level.var_933C = func_461F();
  level.var_5E09 = func_461E();
}

func_452A(param_00) {
  if(!isDefined(param_00) || param_00 == "" || param_00 == "none" || param_00 == "specialty_null") {
    return 0;
  }

  return getitemguidfromref(param_00);
}

func_452B(param_00) {
  if(isDefined(param_00) && param_00 != 0) {
    var_01 = getitemreffromguid(param_00);
    return var_01;
  }

  return "none";
}

func_473D(param_00) {
  var_01 = spawnStruct();
  var_02 = param_00;
  if(issubstr(param_00, "_raid")) {
    var_01.var_3FC3 = 2;
    var_02 = function_0337(param_00, "_raid");
  } else if(issubstr(param_00, "_zm")) {
    var_01.var_3FC3 = 1;
    var_02 = function_0337(param_00, "_zm");
  } else {
    var_01.var_3FC3 = 0;
  }

  var_01.var_48CA = func_452A(var_02);
  return var_01;
}

func_473C(param_00, param_01) {
  var_02 = spawnStruct();
  var_02.var_48CA = param_00;
  var_02.var_3FC3 = param_01;
  return var_02;
}

func_4737(param_00) {
  var_01 = "none";
  if(!isDefined(param_00) || !isDefined(param_00.var_48CA) || param_00.var_48CA == 0 || !isDefined(param_00.var_3FC3)) {
    return var_01;
  }

  var_02 = func_452B(param_00.var_48CA);
  if(param_00.var_3FC3 == 2) {
    var_01 = function_02FF(var_02, "_mp") + "_raid" + "_mp";
  } else if(param_00.var_3FC3 == 1) {
    var_01 = function_02FF(var_02, "_mp") + "_zm";
  } else {
    var_01 = var_02;
  }

  return var_01;
}

func_472C(param_00) {
  var_01 = 0;
  if(isDefined(param_00) && param_00 != 0) {
    var_01 = getweaponconditionid(param_00);
  }

  return var_01;
}

func_472D(param_00) {
  var_01 = 0;
  if(!isDefined(param_00) || !isDefined(param_00.var_48CA) || param_00.var_48CA == 0 || !isDefined(param_00.var_3FC3)) {
    return var_01;
  }

  var_01 = getweaponconditionid(param_00.var_48CA);
  return var_01;
}

func_44CF(param_00) {
  var_01 = spawnStruct();
  var_02 = param_00;
  if(issubstr(param_00, "_raid")) {
    var_01.var_3FC3 = 2;
    var_02 = function_0337(param_00, "_raid");
  } else if(issubstr(param_00, "_zm")) {
    var_01.var_3FC3 = 1;
    var_02 = function_0337(param_00, "_zm");
  } else {
    var_01.var_3FC3 = 0;
  }

  var_01.var_48CA = func_452A(var_02);
  return var_01;
}

func_44CE(param_00, param_01) {
  var_02 = spawnStruct();
  var_02.var_48CA = param_00;
  var_02.var_3FC3 = param_01;
  return var_02;
}

func_44CD(param_00) {
  var_01 = "none";
  if(!isDefined(param_00) || !isDefined(param_00.var_48CA) || param_00.var_48CA == 0 || !isDefined(param_00.var_3FC3)) {
    return var_01;
  }

  var_02 = func_452B(param_00.var_48CA);
  if(param_00.var_3FC3 == 2) {
    var_01 = function_02FF(var_02, "_mp") + "_raid" + "_mp";
  } else if(param_00.var_3FC3 == 1) {
    var_01 = function_02FF(var_02, "_mp") + "_zm";
  } else if(func_579B() && common_scripts\utility::func_562E(level.var_79C1)) {
    if(var_02 == "smoke_grenade_mp") {
      var_01 = "smoke_grenade_axis_mp";
    } else if(var_02 == "smoke_grenade_axis_mp") {
      var_01 = "smoke_grenade_mp";
    } else {
      var_01 = var_02;
    }
  } else {
    var_01 = var_02;
  }

  return var_01;
}

func_5746(param_00, param_01, param_02) {
  var_03 = (param_00[0], param_00[1], 0);
  var_04 = (param_02[0], param_02[1], 0);
  var_05 = var_04 - var_03;
  var_06 = (param_01[0], param_01[1], 0);
  return var_05[0] * var_06[1] - var_05[1] * var_06[0] < 0;
}

func_873B(param_00) {
  level.var_984D = param_00;
  setDvar("4491", param_00);
}

func_44DD() {
  var_00 = self getweaponslistprimaries();
  return var_00[0];
}

func_5C98(param_00, param_01, param_02) {
  var_03 = getent(param_00, "targetname");
  if(!isDefined(var_03)) {
    return;
  }

  var_04 = var_03 method_81DE();
  var_03.var_36D5 = param_02;
  var_05 = 0;
  while(var_05 < param_01) {
    var_06 = var_04 + param_02 - var_04 * var_05 / param_01;
    var_05 = var_05 + 0.05;
    var_03 method_81DF(var_06);
    wait 0.05;
  }

  var_03 method_81DF(param_02);
}

func_5C99(param_00, param_01, param_02) {
  var_03 = getEntArray(param_00, "targetname");
  foreach(var_05 in var_03) {
    var_06 = var_05 method_81DE();
    var_05.var_36D5 = param_02;
    var_07 = 0;
    while(var_07 < param_01) {
      var_08 = var_06 + param_02 - var_06 * var_07 / param_01;
      var_07 = var_07 + 0.05;
      var_05 method_81DF(var_08);
      wait 0.05;
    }

    var_05 method_81DF(param_02);
  }
}

func_33C0(param_00, param_01, param_02, param_03) {
  level endon(param_03);
  wait 0.05;
}

func_33A8(param_00, param_01, param_02, param_03, param_04) {
  if(isDefined(param_04)) {
    var_05 = param_04;
  } else {
    var_05 = 16;
  }

  var_06 = 360 / var_05;
  var_07 = [];
  for(var_08 = 0; var_08 < var_05; var_08++) {
    var_09 = var_06 * var_08;
    var_0A = cos(var_09) * param_01;
    var_0B = sin(var_09) * param_01;
    var_0C = param_00[0] + var_0A;
    var_0D = param_00[1] + var_0B;
    var_0E = param_00[2];
    var_07[var_07.size] = (var_0C, var_0D, var_0E);
  }

  for(var_08 = 0; var_08 < var_07.size; var_08++) {
    var_0F = var_07[var_08];
    if(var_08 + 1 >= var_07.size) {
      var_10 = var_07[0];
    } else {
      var_10 = var_07[var_08 + 1];
    }

    thread func_33C0(var_0F, var_10, param_02, param_03);
  }
}

func_2D4F(param_00) {
  if(!isDefined(param_00)) {
    return;
  }

  var_01 = param_00.var_0164;
  if(isDefined(var_01) && isDefined(level.var_947C["script_linkname"]) && isDefined(level.var_947C["script_linkname"][var_01])) {
    foreach(var_04, var_03 in level.var_947C["script_linkname"][var_01]) {
      if(isDefined(var_03) && param_00 == var_03) {
        level.var_947C["script_linkname"][var_01][var_04] = undefined;
      }
    }

    if(level.var_947C["script_linkname"][var_01].size == 0) {
      level.var_947C["script_linkname"][var_01] = undefined;
    }
  }

  var_01 = param_00.var_0165;
  if(isDefined(var_01) && isDefined(level.var_947C["script_noteworthy"]) && isDefined(level.var_947C["script_noteworthy"][var_01])) {
    foreach(var_04, var_03 in level.var_947C["script_noteworthy"][var_01]) {
      if(isDefined(var_03) && param_00 == var_03) {
        level.var_947C["script_noteworthy"][var_01][var_04] = undefined;
      }
    }

    if(level.var_947C["script_noteworthy"][var_01].size == 0) {
      level.var_947C["script_noteworthy"][var_01] = undefined;
    }
  }

  var_01 = param_00.var_01A2;
  if(isDefined(var_01) && isDefined(level.var_947C["target"]) && isDefined(level.var_947C["target"][var_01])) {
    foreach(var_04, var_03 in level.var_947C["target"][var_01]) {
      if(isDefined(var_03) && param_00 == var_03) {
        level.var_947C["target"][var_01][var_04] = undefined;
      }
    }

    if(level.var_947C["target"][var_01].size == 0) {
      level.var_947C["target"][var_01] = undefined;
    }
  }

  var_01 = param_00.var_01A5;
  if(isDefined(var_01) && isDefined(level.var_947C["targetname"]) && isDefined(level.var_947C["targetname"][var_01])) {
    foreach(var_04, var_03 in level.var_947C["targetname"][var_01]) {
      if(isDefined(var_03) && param_00 == var_03) {
        level.var_947C["targetname"][var_01][var_04] = undefined;
      }
    }

    if(level.var_947C["targetname"][var_01].size == 0) {
      level.var_947C["targetname"][var_01] = undefined;
    }
  }

  if(isDefined(level.var_9478)) {
    foreach(var_04, var_03 in level.var_9478) {
      if(param_00 == var_03) {
        level.var_9478[var_04] = undefined;
      }
    }
  }
}

func_863E(param_00, param_01, param_02, param_03) {
  if(param_01 == "axis") {
    param_00 = param_00 + 2000;
  } else if(param_01 == "allies") {
    param_00 = param_00 + 1000;
  }

  if(isDefined(param_02)) {
    param_00 = param_00 + param_02 + 1 * 10000;
  }

  if(isDefined(param_03)) {
    if(function_02A2(param_03)) {
      param_00 = param_00 + param_03 + 1 * 1000000;
    } else {
      common_scripts\utility::func_3809("broadcaster announcement extra data supports numbers only. Invalid extra data: " + param_03);
    }
  }

  setomnvar("ui_broadcaster_announcement", param_00);
}

func_5246() {
  level endon("game_ended");
  for(;;) {
    level waittill("connected", var_00);
    var_00 thread func_0F24();
  }
}

func_0F24() {
  level endon("game_ended");
  self endon("disconnect");
  for(;;) {
    self waittill("applyLoadout");
    var_00 = getEntArray("scorestreakclosed", "targetname");
    if(var_00.size > 0) {
      foreach(var_02 in var_00) {
        var_02 enableportalgroup(1, self);
      }
    }

    var_00 = getEntArray("scorestreakopen", "targetname");
    if(var_00.size > 0) {
      foreach(var_02 in var_00) {
        var_02 enableportalgroup(0, self);
      }
    }
  }
}

array_combine_no_dupes(param_00, param_01) {
  var_02 = [];
  foreach(var_04 in param_00) {
    if(isDefined(var_04) && !isDefined(common_scripts\utility::func_0F7E(var_02, var_04))) {
      var_02[var_02.size] = var_04;
    }
  }

  foreach(var_04 in param_01) {
    if(isDefined(var_04) && !isDefined(common_scripts\utility::func_0F7E(var_02, var_04))) {
      var_02[var_02.size] = var_04;
    }
  }

  return var_02;
}

unsignedint_to_hexstring_fixed(param_00) {
  var_01 = "0123456789ABCDEF";
  if(param_00 == 0) {
    return var_01[0];
  }

  var_02 = param_00;
  var_03 = "";
  while(param_00 > 0) {
    var_03 = var_01[int(param_00 % 16)] + var_03;
    param_00 = param_00 >> 4;
  }

  var_03 = "0x" + var_03;
  return var_03;
}

no_obfuscate(param_00) {
  return param_00;
}