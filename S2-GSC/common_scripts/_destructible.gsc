/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: common_scripts\_destructible.gsc
*********************************************/

func_00D5() {
  level.var_2E2A = 50;
  level.var_2E29 = [];
  level.var_2928 = 0;
  level.var_254D = gettime();
  if(!isDefined(level.var_3A53)) {
    level.var_3A53 = 0;
  }

  if(!isDefined(level.var_3F02)) {
    level.var_3F02 = [];
  }

  var_00 = 1;
  if(var_00) {
    func_3B74();
  }

  var_01 = getEntArray("delete_on_load", "targetname");
  foreach(var_03 in var_01) {
    var_03 delete();
  }

  func_51B4();
  func_51B5();
}

func_2AB9() {}

func_3B74() {
  if(!isDefined(level.var_2DFA)) {
    level.var_2DFA = [];
  }

  var_00 = [];
  foreach(var_02 in level.var_9478) {
    if(isDefined(var_02.var_0165) && var_02.var_0165 == "destructible_dot") {
      var_00[var_00.size] = var_02;
    }
  }

  var_04 = getEntArray("destructible_vehicle", "targetname");
  foreach(var_06 in var_04) {
    var_06 thread func_87D3(var_00);
  }

  var_08 = getEntArray("destructible_toy", "targetname");
  foreach(var_0A in var_08) {
    var_0A thread func_87D3(var_00);
  }

  func_2AB9();
}

func_87D3(param_00) {
  func_87D2();
  func_87D0(param_00);
}

func_87D0(param_00) {
  var_01 = self.var_2E25;
  foreach(var_03 in param_00) {
    if(isDefined(level.var_0075[var_01].var_2DF3)) {
      return;
    }

    if(isDefined(var_03.var_8260) && issubstr(var_03.var_8260, "destructible_type") && issubstr(var_03.var_8260, self.var_0075)) {
      if(distancesquared(self.var_0116, var_03.var_0116) < 1) {
        var_04 = getEntArray(var_03.var_01A2, "targetname");
        level.var_0075[var_01].var_2DF3 = [];
        foreach(var_06 in var_04) {
          var_07 = var_06.var_81E1;
          if(!isDefined(level.var_0075[var_01].var_2DF3[var_07])) {
            level.var_0075[var_01].var_2DF3[var_07] = [];
          }

          var_08 = level.var_0075[var_01].var_2DF3[var_07].size;
          level.var_0075[var_01].var_2DF3[var_07][var_08]["classname"] = var_06.var_003A;
          level.var_0075[var_01].var_2DF3[var_07][var_08]["origin"] = var_06.var_0116;
          var_09 = common_scripts\utility::func_98E7(isDefined(var_06.var_0187), var_06.var_0187, 0);
          level.var_0075[var_01].var_2DF3[var_07][var_08]["spawnflags"] = var_09;
          switch (var_06.var_003A) {
            case "trigger_radius":
              level.var_0075[var_01].var_2DF3[var_07][var_08]["radius"] = var_06.var_00BD;
              level.var_0075[var_01].var_2DF3[var_07][var_08]["height"] = var_06.var_00BD;
              break;

            default:
              break;
          }

          var_06 delete();
        }

        break;
      }
    }
  }
}

func_2E02(param_00) {
  if(!isDefined(level.var_0075)) {
    return -1;
  }

  if(level.var_0075.size == 0) {
    return -1;
  }

  for(var_01 = 0; var_01 < level.var_0075.size; var_01++) {
    if(param_00 == level.var_0075[var_01].var_A265["type"]) {
      return var_01;
    }
  }

  return -1;
}

func_2DA4(param_00, param_01, param_02, param_03, param_04, param_05) {
  if(!isDefined(param_01)) {
    param_01 = 0;
  }

  if(!isDefined(param_02)) {
    param_02 = "test/concrete_cover_dest_test";
  }

  if(!isDefined(param_03)) {
    param_03 = 150;
  }

  func_2DED(param_00, "tag_origin", 1, undefined, 32, "no_melee");
  if(isDefined(param_04)) {
    func_2E1C(undefined, param_04, undefined, undefined, 32, "no_melee");
  }

  for(var_06 = 0; var_06 < param_01; var_06++) {
    var_07 = "fx_joint_" + var_06;
    func_2E0F(var_07, undefined, param_03, undefined, undefined, "no_melee", 1);
    func_2DFB(var_07, param_02);
    if(isDefined(param_05)) {
      func_2E15(param_05);
    }

    func_2E1C(undefined);
  }
}

func_2E03(param_00) {
  var_01 = func_2E02(param_00);
  if(var_01 >= 0) {
    return var_01;
  }

  if(issubstr(param_00, "dest_cover")) {
    func_2DA4(self.var_0075, self.var_8160, self.var_815B, self.var_815C, self.var_815F, self.var_815D);
    var_01 = func_2E02(param_00);
    return var_01;
  }

  if(!isDefined(level.var_2DFA[param_00])) {
    return -1;
  }

  [[level.var_2DFA[param_00]]]();
  var_01 = func_2E02(param_00);
  return var_01;
}

func_87D2() {
  var_00 = undefined;
  self.var_6297 = 0;
  func_0914();
  self.var_2E25 = func_2E03(self.var_0075);
  if(self.var_2E25 < 0) {
    return;
  }

  func_7643();
  func_091C();
  if(isDefined(level.var_2E1E) && isDefined(level.var_2E1E[self.var_0075])) {
    common_scripts\utility::func_3C9F(level.var_2E1E[self.var_0075] + "_loaded");
  }

  if(isDefined(level.var_0075[self.var_2E25].var_1145)) {
    foreach(var_03 in level.var_0075[self.var_2E25].var_1145) {
      if(isDefined(var_03.var_95A6)) {
        self attach(var_03.var_0106, var_03.var_95A6);
      } else {
        self attach(var_03.var_0106);
      }

      if(self.var_6297) {
        if(isDefined(var_03.var_95A6)) {
          self.var_6296 attach(var_03.var_0106, var_03.var_95A6);
          continue;
        }

        self.var_6296 attach(var_03.var_0106);
      }
    }
  }

  if(isDefined(level.var_0075[self.var_2E25].var_6E9F)) {
    self.var_2E10 = [];
    for(var_05 = 0; var_05 < level.var_0075[self.var_2E25].var_6E9F.size; var_05++) {
      self.var_2E10[var_05] = spawnStruct();
      self.var_2E10[var_05].var_A265["currentState"] = 0;
      if(isDefined(level.var_0075[self.var_2E25].var_6E9F[var_05][0].var_A265["health"])) {
        self.var_2E10[var_05].var_A265["health"] = level.var_0075[self.var_2E25].var_6E9F[var_05][0].var_A265["health"];
      }

      if(isDefined(level.var_0075[self.var_2E25].var_6E9F[var_05][0].var_A265["random_dynamic_attachment_1"])) {
        var_06 = randomint(level.var_0075[self.var_2E25].var_6E9F[var_05][0].var_A265["random_dynamic_attachment_1"].size);
        var_07 = level.var_0075[self.var_2E25].var_6E9F[var_05][0].var_A265["random_dynamic_attachment_tag"][var_06];
        var_08 = level.var_0075[self.var_2E25].var_6E9F[var_05][0].var_A265["random_dynamic_attachment_1"][var_06];
        var_09 = level.var_0075[self.var_2E25].var_6E9F[var_05][0].var_A265["random_dynamic_attachment_2"][var_06];
        var_0A = level.var_0075[self.var_2E25].var_6E9F[var_05][0].var_A265["clipToRemove"][var_06];
        thread func_30DF(var_07, var_08, var_09, var_0A);
      }

      if(var_05 == 0) {
        continue;
      }

      var_0B = level.var_0075[self.var_2E25].var_6E9F[var_05][0].var_A265["modelName"];
      var_0C = level.var_0075[self.var_2E25].var_6E9F[var_05][0].var_A265["tagName"];
      for(var_0D = 1; isDefined(level.var_0075[self.var_2E25].var_6E9F[var_05][var_0D]); var_0D++) {
        var_0E = level.var_0075[self.var_2E25].var_6E9F[var_05][var_0D].var_A265["tagName"];
        var_0F = level.var_0075[self.var_2E25].var_6E9F[var_05][var_0D].var_A265["modelName"];
        if(isDefined(var_0E) && var_0E != var_0C) {
          func_4D03(var_0E);
          if(self.var_6297) {
            self.var_6296 func_4D03(var_0E);
          }
        }
      }
    }
  }

  if(isDefined(self.var_01A2)) {
    thread func_2E05();
  }

  if(self.var_003B != "script_vehicle") {
    self setCanDamage(1);
  }

  if(common_scripts\utility::func_57D7()) {
    thread func_258B();
  }

  thread func_2E1D();
  if(issubstr(self.var_0075, "dest_cover")) {
    thread func_2E23();
  }

  thread func_2DFF();
}

func_2DED(param_00, param_01, param_02, param_03, param_04, param_05) {
  if(!isDefined(level.var_0075)) {
    level.var_0075 = [];
  }

  var_06 = level.var_0075.size;
  level.var_0075[var_06] = spawnStruct();
  level.var_0075[var_06].var_A265["type"] = param_00;
  level.var_0075[var_06].var_6E9F = [];
  level.var_0075[var_06].var_6E9F[0][0] = spawnStruct();
  level.var_0075[var_06].var_6E9F[0][0].var_A265["modelName"] = self.var_0106;
  level.var_0075[var_06].var_6E9F[0][0].var_A265["tagName"] = param_01;
  level.var_0075[var_06].var_6E9F[0][0].var_A265["health"] = param_02;
  level.var_0075[var_06].var_6E9F[0][0].var_A265["validAttackers"] = param_03;
  level.var_0075[var_06].var_6E9F[0][0].var_A265["validDamageZone"] = param_04;
  level.var_0075[var_06].var_6E9F[0][0].var_A265["validDamageCause"] = param_05;
  level.var_0075[var_06].var_6E9F[0][0].var_A265["godModeAllowed"] = 1;
  level.var_0075[var_06].var_6E9F[0][0].var_A265["rotateTo"] = self.var_001D;
  level.var_0075[var_06].var_6E9F[0][0].var_A265["vehicle_exclude_anim"] = 0;
}

func_2E0F(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09) {
  var_0A = level.var_0075.size - 1;
  var_0B = level.var_0075[var_0A].var_6E9F.size;
  var_0C = 0;
  func_2E08(var_0B, var_0C, param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, undefined, param_09);
}

func_2E1C(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07) {
  var_08 = level.var_0075.size - 1;
  var_09 = level.var_0075[var_08].var_6E9F.size - 1;
  var_0A = level.var_0075[var_08].var_6E9F[var_09].size;
  if(!isDefined(param_00) && var_09 == 0) {
    param_00 = level.var_0075[var_08].var_6E9F[var_09][0].var_A265["tagName"];
  }

  func_2E08(var_09, var_0A, param_00, param_01, param_02, param_03, param_04, param_05, undefined, undefined, param_06, param_07);
}

func_2DFD(param_00, param_01, param_02, param_03, param_04, param_05, param_06) {
  func_2DFB(param_00, param_01, param_02, param_03, param_04, param_05, 1, param_06);
}

func_2DFB(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07) {
  if(!isDefined(param_02)) {
    param_02 = 1;
  }

  if(!isDefined(param_04)) {
    param_04 = 0;
  }

  if(!isDefined(param_05)) {
    param_05 = 0;
  }

  if(!isDefined(param_06)) {
    param_06 = 0;
  }

  if(!isDefined(param_07)) {
    param_07 = 0;
  }

  var_08 = level.var_0075.size - 1;
  var_09 = level.var_0075[var_08].var_6E9F.size - 1;
  var_0A = level.var_0075[var_08].var_6E9F[var_09].size - 1;
  var_0B = 0;
  if(isDefined(level.var_0075[var_08].var_6E9F[var_09][var_0A].var_A265["fx_filename"])) {
    if(isDefined(level.var_0075[var_08].var_6E9F[var_09][var_0A].var_A265["fx_filename"][param_04])) {
      var_0B = level.var_0075[var_08].var_6E9F[var_09][var_0A].var_A265["fx_filename"][param_04].size;
    }
  }

  if(isDefined(param_03)) {
    level.var_0075[var_08].var_6E9F[var_09][var_0A].var_A265["fx_valid_damagetype"][param_04][var_0B] = param_03;
  }

  level.var_0075[var_08].var_6E9F[var_09][var_0A].var_A265["fx_filename"][param_04][var_0B] = param_01;
  level.var_0075[var_08].var_6E9F[var_09][var_0A].var_A265["fx_tag"][param_04][var_0B] = param_00;
  level.var_0075[var_08].var_6E9F[var_09][var_0A].var_A265["fx_useTagAngles"][param_04][var_0B] = param_02;
  level.var_0075[var_08].var_6E9F[var_09][var_0A].var_A265["fx_cost"][param_04][var_0B] = param_05;
  level.var_0075[var_08].var_6E9F[var_09][var_0A].var_A265["spawn_immediate"][param_04][var_0B] = param_06;
  level.var_0075[var_08].var_6E9F[var_09][var_0A].var_A265["state_change_kill"][param_04][var_0B] = param_07;
}

func_2DEE(param_00) {
  var_01 = level.var_0075.size - 1;
  var_02 = level.var_0075[var_01].var_6E9F.size - 1;
  var_03 = level.var_0075[var_01].var_6E9F[var_02].size - 1;
  if(!isDefined(level.var_0075[var_01].var_6E9F[var_02][var_03].var_A265["dot"])) {
    level.var_0075[var_01].var_6E9F[var_02][var_03].var_A265["dot"] = [];
  }

  var_04 = level.var_0075[var_01].var_6E9F[var_02][var_03].var_A265["dot"].size;
  var_05 = func_27E2();
  var_05.var_01B9 = "predefined";
  var_05.var_00D4 = param_00;
  level.var_0075[var_01].var_6E9F[var_02][var_03].var_A265["dot"][var_04] = var_05;
}

func_2DEF(param_00, param_01, param_02, param_03) {
  var_04 = level.var_0075.size - 1;
  var_05 = level.var_0075[var_04].var_6E9F.size - 1;
  var_06 = level.var_0075[var_04].var_6E9F[var_05].size - 1;
  if(!isDefined(level.var_0075[var_04].var_6E9F[var_05][var_06].var_A265["dot"])) {
    level.var_0075[var_04].var_6E9F[var_05][var_06].var_A265["dot"] = [];
  }

  var_07 = level.var_0075[var_04].var_6E9F[var_05][var_06].var_A265["dot"].size;
  var_08 = func_27E3((0, 0, 0), param_01, param_02, param_03);
  var_08.var_95A6 = param_00;
  level.var_0075[var_04].var_6E9F[var_05][var_06].var_A265["dot"][var_07] = var_08;
}

func_2E13(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07) {
  var_08 = level.var_0075.size - 1;
  var_09 = level.var_0075[var_08].var_6E9F.size - 1;
  var_0A = level.var_0075[var_08].var_6E9F[var_09].size - 1;
  var_0B = level.var_0075[var_08].var_6E9F[var_09][var_0A].var_A265["dot"].size - 1;
  var_0C = level.var_0075[var_08].var_6E9F[var_09][var_0A].var_A265["dot"][var_0B];
  var_0C func_866A(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07);
  func_52AF(param_06);
}

func_2E14(param_00, param_01, param_02) {
  var_03 = level.var_0075.size - 1;
  var_04 = level.var_0075[var_03].var_6E9F.size - 1;
  var_05 = level.var_0075[var_03].var_6E9F[var_04].size - 1;
  var_06 = level.var_0075[var_03].var_6E9F[var_04][var_05].var_A265["dot"].size - 1;
  var_07 = level.var_0075[var_03].var_6E9F[var_04][var_05].var_A265["dot"][var_06];
  var_08 = var_07.var_99C1.size;
  var_07.var_99C1[var_08].var_6B05 = param_00;
  var_07.var_99C1[var_08].var_6B33 = param_01;
  var_07.var_99C1[var_08].var_6AE6 = param_02;
}

func_2DE8(param_00, param_01) {
  var_02 = level.var_0075.size - 1;
  var_03 = level.var_0075[var_02].var_6E9F.size - 1;
  var_04 = level.var_0075[var_02].var_6E9F[var_03].size - 1;
  var_05 = level.var_0075[var_02].var_6E9F[var_03][var_04].var_A265["dot"].size - 1;
  var_06 = level.var_0075[var_02].var_6E9F[var_03][var_04].var_A265["dot"][var_05];
  var_06 func_1D45(param_00, param_01);
}

func_2DE9(param_00) {
  var_01 = level.var_0075.size - 1;
  var_02 = level.var_0075[var_01].var_6E9F.size - 1;
  var_03 = level.var_0075[var_01].var_6E9F[var_02].size - 1;
  var_04 = level.var_0075[var_01].var_6E9F[var_02][var_03].var_A265["dot"].size - 1;
  var_05 = level.var_0075[var_01].var_6E9F[var_02][var_03].var_A265["dot"][var_04];
  var_05 func_1D46(param_00);
}

func_2DE7(param_00, param_01, param_02, param_03, param_04, param_05) {
  var_06 = level.var_0075.size - 1;
  var_07 = level.var_0075[var_06].var_6E9F.size - 1;
  var_08 = level.var_0075[var_06].var_6E9F[var_07].size - 1;
  var_09 = level.var_0075[var_06].var_6E9F[var_07][var_08].var_A265["dot"].size - 1;
  var_0A = level.var_0075[var_06].var_6E9F[var_07][var_08].var_A265["dot"][var_09];
  var_0A func_1D44(param_00, param_01, param_02, param_03, param_04, param_05);
}

func_2DEA(param_00) {
  var_01 = level.var_0075.size - 1;
  var_02 = level.var_0075[var_01].var_6E9F.size - 1;
  var_03 = level.var_0075[var_01].var_6E9F[var_02].size - 1;
  var_04 = level.var_0075[var_01].var_6E9F[var_02][var_03].var_A265["dot"].size - 1;
  var_05 = level.var_0075[var_01].var_6E9F[var_02][var_03].var_A265["dot"][var_04];
  var_05 func_1D47(param_00);
}

func_2E0A(param_00, param_01, param_02, param_03) {
  if(!isDefined(param_03)) {
    param_03 = 0;
  }

  var_04 = level.var_0075.size - 1;
  var_05 = level.var_0075[var_04].var_6E9F.size - 1;
  var_06 = level.var_0075[var_04].var_6E9F[var_05].size - 1;
  var_07 = 0;
  if(isDefined(level.var_0075[var_04].var_6E9F[var_05][var_06].var_A265["loopfx_filename"])) {
    var_07 = level.var_0075[var_04].var_6E9F[var_05][var_06].var_A265["loopfx_filename"].size;
  }

  level.var_0075[var_04].var_6E9F[var_05][var_06].var_A265["loopfx_filename"][var_07] = param_01;
  level.var_0075[var_04].var_6E9F[var_05][var_06].var_A265["loopfx_tag"][var_07] = param_00;
  level.var_0075[var_04].var_6E9F[var_05][var_06].var_A265["loopfx_rate"][var_07] = param_02;
  level.var_0075[var_04].var_6E9F[var_05][var_06].var_A265["loopfx_cost"][var_07] = param_03;
}

func_2E07(param_00, param_01, param_02, param_03) {
  var_04 = level.var_0075.size - 1;
  var_05 = level.var_0075[var_04].var_6E9F.size - 1;
  var_06 = level.var_0075[var_04].var_6E9F[var_05].size - 1;
  level.var_0075[var_04].var_6E9F[var_05][var_06].var_A265["healthdrain_amount"] = param_00;
  level.var_0075[var_04].var_6E9F[var_05][var_06].var_A265["healthdrain_interval"] = param_01;
  level.var_0075[var_04].var_6E9F[var_05][var_06].var_A265["badplace_radius"] = param_02;
  level.var_0075[var_04].var_6E9F[var_05][var_06].var_A265["badplace_team"] = param_03;
}

func_2E15(param_00, param_01, param_02) {
  var_03 = level.var_0075.size - 1;
  var_04 = level.var_0075[var_03].var_6E9F.size - 1;
  var_05 = level.var_0075[var_03].var_6E9F[var_04].size - 1;
  if(!isDefined(param_02)) {
    param_02 = 0;
  }

  if(!isDefined(level.var_0075[var_03].var_6E9F[var_04][var_05].var_A265["sound"])) {
    level.var_0075[var_03].var_6E9F[var_04][var_05].var_A265["sound"] = [];
    level.var_0075[var_03].var_6E9F[var_04][var_05].var_A265["soundCause"] = [];
  }

  if(!isDefined(level.var_0075[var_03].var_6E9F[var_04][var_05].var_A265["sound"][param_02])) {
    level.var_0075[var_03].var_6E9F[var_04][var_05].var_A265["sound"][param_02] = [];
    level.var_0075[var_03].var_6E9F[var_04][var_05].var_A265["soundCause"][param_02] = [];
  }

  var_06 = level.var_0075[var_03].var_6E9F[var_04][var_05].var_A265["sound"][param_02].size;
  level.var_0075[var_03].var_6E9F[var_04][var_05].var_A265["sound"][param_02][var_06] = param_00;
  level.var_0075[var_03].var_6E9F[var_04][var_05].var_A265["soundCause"][param_02][var_06] = param_01;
}

func_2E0B(param_00, param_01) {
  var_02 = level.var_0075.size - 1;
  var_03 = level.var_0075[var_02].var_6E9F.size - 1;
  var_04 = level.var_0075[var_02].var_6E9F[var_03].size - 1;
  if(!isDefined(level.var_0075[var_02].var_6E9F[var_03][var_04].var_A265["loopsound"])) {
    level.var_0075[var_02].var_6E9F[var_03][var_04].var_A265["loopsound"] = [];
    level.var_0075[var_02].var_6E9F[var_03][var_04].var_A265["loopsoundCause"] = [];
  }

  var_05 = level.var_0075[var_02].var_6E9F[var_03][var_04].var_A265["loopsound"].size;
  level.var_0075[var_02].var_6E9F[var_03][var_04].var_A265["loopsound"][var_05] = param_00;
  level.var_0075[var_02].var_6E9F[var_03][var_04].var_A265["loopsoundCause"][var_05] = param_01;
}

func_2DE3(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08) {
  if(!isDefined(param_03)) {
    param_03 = 0;
  }

  if(!isDefined(param_04)) {
    param_04 = 0;
  }

  var_09 = [];
  var_09["anim"] = param_00;
  var_09["animTree"] = param_01;
  var_09["animType"] = param_02;
  var_09["vehicle_exclude_anim"] = param_03;
  var_09["groupNum"] = param_04;
  var_09["mpAnim"] = param_05;
  var_09["maxStartDelay"] = param_06;
  var_09["animRateMin"] = param_07;
  var_09["animRateMax"] = param_08;
  func_0901("animation", var_09);
}

func_2E1A(param_00) {
  var_01 = [];
  var_01["spotlight_tag"] = param_00;
  var_01["spotlight_fx"] = "spotlight_fx";
  var_01["spotlight_brightness"] = 0.85;
  var_01["randomly_flip"] = 1;
  func_093B(var_01);
}

func_093A(param_00, param_01) {
  var_02 = [];
  var_02[param_00] = param_01;
  func_093B(var_02);
}

func_093B(param_00) {
  var_01 = level.var_0075.size - 1;
  var_02 = level.var_0075[var_01].var_6E9F.size - 1;
  var_03 = level.var_0075[var_01].var_6E9F[var_02].size - 1;
  foreach(var_06, var_05 in param_00) {
    level.var_0075[var_01].var_6E9F[var_02][var_03].var_A265[var_06] = var_05;
  }
}

func_0901(param_00, param_01) {
  var_02 = level.var_0075.size - 1;
  var_03 = level.var_0075[var_02].var_6E9F.size - 1;
  var_04 = level.var_0075[var_02].var_6E9F[var_03].size - 1;
  var_05 = level.var_0075[var_02].var_6E9F[var_03][var_04].var_A265;
  if(!isDefined(var_05[param_00])) {
    var_05[param_00] = [];
  }

  var_05[param_00][var_05[param_00].size] = param_01;
  level.var_0075[var_02].var_6E9F[var_03][var_04].var_A265 = var_05;
}

func_2DEB() {
  var_00 = level.var_0075.size - 1;
  var_01 = level.var_0075[var_00].var_6E9F.size - 1;
  var_02 = level.var_0075[var_00].var_6E9F[var_01].size - 1;
  level.var_0075[var_00].var_6E9F[var_01][var_02].var_A265["triggerCarAlarm"] = 1;
}

func_2E09(param_00) {
  if(!isDefined(param_00)) {
    param_00 = 256;
  }

  var_01 = level.var_0075.size - 1;
  var_02 = level.var_0075[var_01].var_6E9F.size - 1;
  var_03 = level.var_0075[var_01].var_6E9F[var_02].size - 1;
  level.var_0075[var_01].var_6E9F[var_02][var_03].var_A265["break_nearby_lights"] = param_00;
}

func_7A38(param_00, param_01, param_02, param_03) {
  if(!isDefined(param_02)) {
    param_02 = "";
  }

  var_04 = level.var_0075.size - 1;
  var_05 = level.var_0075[var_04].var_6E9F.size - 1;
  var_06 = 0;
  if(!isDefined(level.var_0075[var_04].var_6E9F[var_05][var_06].var_A265["random_dynamic_attachment_1"])) {
    level.var_0075[var_04].var_6E9F[var_05][var_06].var_A265["random_dynamic_attachment_1"] = [];
    level.var_0075[var_04].var_6E9F[var_05][var_06].var_A265["random_dynamic_attachment_2"] = [];
    level.var_0075[var_04].var_6E9F[var_05][var_06].var_A265["random_dynamic_attachment_tag"] = [];
  }

  var_07 = level.var_0075[var_04].var_6E9F[var_05][var_06].var_A265["random_dynamic_attachment_1"].size;
  level.var_0075[var_04].var_6E9F[var_05][var_06].var_A265["random_dynamic_attachment_1"][var_07] = param_01;
  level.var_0075[var_04].var_6E9F[var_05][var_06].var_A265["random_dynamic_attachment_2"][var_07] = param_02;
  level.var_0075[var_04].var_6E9F[var_05][var_06].var_A265["random_dynamic_attachment_tag"][var_07] = param_00;
  level.var_0075[var_04].var_6E9F[var_05][var_06].var_A265["clipToRemove"][var_07] = param_03;
}

func_2E11(param_00, param_01) {
  var_02 = level.var_0075.size - 1;
  var_03 = level.var_0075[var_02].var_6E9F.size - 1;
  var_04 = level.var_0075[var_02].var_6E9F[var_03].size - 1;
  if(!isDefined(level.var_0075[var_02].var_6E9F[var_03][var_04].var_A265["physics"])) {
    level.var_0075[var_02].var_6E9F[var_03][var_04].var_A265["physics"] = [];
    level.var_0075[var_02].var_6E9F[var_03][var_04].var_A265["physics_tagName"] = [];
    level.var_0075[var_02].var_6E9F[var_03][var_04].var_A265["physics_velocity"] = [];
  }

  var_05 = level.var_0075[var_02].var_6E9F[var_03][var_04].var_A265["physics"].size;
  level.var_0075[var_02].var_6E9F[var_03][var_04].var_A265["physics"][var_05] = 1;
  level.var_0075[var_02].var_6E9F[var_03][var_04].var_A265["physics_tagName"][var_05] = param_00;
  level.var_0075[var_02].var_6E9F[var_03][var_04].var_A265["physics_velocity"][var_05] = param_01;
}

func_2E18(param_00) {
  var_01 = level.var_0075.size - 1;
  var_02 = level.var_0075[var_01].var_6E9F.size - 1;
  var_03 = level.var_0075[var_01].var_6E9F[var_02].size - 1;
  level.var_0075[var_01].var_6E9F[var_02][var_03].var_A265["splash_damage_scaler"] = param_00;
}

func_2DF4(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A, param_0B, param_0C, param_0D) {
  var_0E = level.var_0075.size - 1;
  var_0F = level.var_0075[var_0E].var_6E9F.size - 1;
  var_10 = level.var_0075[var_0E].var_6E9F[var_0F].size - 1;
  if(common_scripts\utility::func_57D7()) {
    level.var_0075[var_0E].var_6E9F[var_0F][var_10].var_A265["explode_range"] = param_02;
  } else {
    level.var_0075[var_0E].var_6E9F[var_0F][var_10].var_A265["explode_range"] = param_03;
  }

  level.var_0075[var_0E].var_6E9F[var_0F][var_10].var_A265["explode"] = 1;
  level.var_0075[var_0E].var_6E9F[var_0F][var_10].var_A265["explode_force_min"] = param_00;
  level.var_0075[var_0E].var_6E9F[var_0F][var_10].var_A265["explode_force_max"] = param_01;
  level.var_0075[var_0E].var_6E9F[var_0F][var_10].var_A265["explode_mindamage"] = param_04;
  level.var_0075[var_0E].var_6E9F[var_0F][var_10].var_A265["explode_maxdamage"] = param_05;
  level.var_0075[var_0E].var_6E9F[var_0F][var_10].var_A265["continueDamage"] = param_06;
  level.var_0075[var_0E].var_6E9F[var_0F][var_10].var_A265["originOffset"] = param_07;
  level.var_0075[var_0E].var_6E9F[var_0F][var_10].var_A265["earthQuakeScale"] = param_08;
  level.var_0075[var_0E].var_6E9F[var_0F][var_10].var_A265["earthQuakeRadius"] = param_09;
  level.var_0075[var_0E].var_6E9F[var_0F][var_10].var_A265["originOffset3d"] = param_0A;
  level.var_0075[var_0E].var_6E9F[var_0F][var_10].var_A265["delaytime"] = param_0B;
  level.var_0075[var_0E].var_6E9F[var_0F][var_10].var_A265["explode_angularImpulse_min"] = param_0C;
  level.var_0075[var_0E].var_6E9F[var_0F][var_10].var_A265["explode_angularImpulse_max"] = param_0D;
}

func_2DF9(param_00) {
  var_01 = level.var_0075.size - 1;
  var_02 = level.var_0075[var_01].var_6E9F.size - 1;
  var_03 = level.var_0075[var_01].var_6E9F[var_02].size - 1;
  level.var_0075[var_01].var_6E9F[var_02][var_03].var_A265["function"] = param_00;
}

func_2E0E(param_00) {
  var_01 = level.var_0075.size - 1;
  var_02 = level.var_0075[var_01].var_6E9F.size - 1;
  var_03 = level.var_0075[var_01].var_6E9F[var_02].size - 1;
  level.var_0075[var_01].var_6E9F[var_02][var_03].var_A265["functionNotify"] = param_00;
}

func_2DF0(param_00) {
  var_01 = level.var_0075.size - 1;
  var_02 = level.var_0075[var_01].var_6E9F.size - 1;
  var_03 = level.var_0075[var_01].var_6E9F[var_02].size - 1;
  level.var_0075[var_01].var_6E9F[var_02][var_03].var_A265["damage_threshold"] = param_00;
}

func_2DE5(param_00, param_01) {
  param_01 = tolower(param_01);
  var_02 = level.var_0075.size - 1;
  if(!isDefined(level.var_0075[var_02].var_1145)) {
    level.var_0075[var_02].var_1145 = [];
  }

  var_03 = spawnStruct();
  var_03.var_0106 = param_01;
  var_03.var_95A6 = param_00;
  level.var_0075[var_02].var_1145[level.var_0075[var_02].var_1145.size] = var_03;
}

func_2E08(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A, param_0B, param_0C) {
  if(isDefined(param_03)) {
    param_03 = tolower(param_03);
  }

  var_0D = level.var_0075.size - 1;
  level.var_0075[var_0D].var_6E9F[param_00][param_01] = spawnStruct();
  level.var_0075[var_0D].var_6E9F[param_00][param_01].var_A265["modelName"] = param_03;
  level.var_0075[var_0D].var_6E9F[param_00][param_01].var_A265["tagName"] = param_02;
  level.var_0075[var_0D].var_6E9F[param_00][param_01].var_A265["health"] = param_04;
  level.var_0075[var_0D].var_6E9F[param_00][param_01].var_A265["validAttackers"] = param_05;
  level.var_0075[var_0D].var_6E9F[param_00][param_01].var_A265["validDamageZone"] = param_06;
  level.var_0075[var_0D].var_6E9F[param_00][param_01].var_A265["validDamageCause"] = param_07;
  level.var_0075[var_0D].var_6E9F[param_00][param_01].var_A265["alsoDamageParent"] = param_08;
  level.var_0075[var_0D].var_6E9F[param_00][param_01].var_A265["physicsOnExplosion"] = param_09;
  level.var_0075[var_0D].var_6E9F[param_00][param_01].var_A265["grenadeImpactDeath"] = param_0A;
  level.var_0075[var_0D].var_6E9F[param_00][param_01].var_A265["godModeAllowed"] = 0;
  level.var_0075[var_0D].var_6E9F[param_00][param_01].var_A265["splashRotation"] = param_0B;
  level.var_0075[var_0D].var_6E9F[param_00][param_01].var_A265["receiveDamageFromParent"] = param_0C;
}

func_7643() {
  if(!isDefined(level.var_0075[self.var_2E25].var_6E9F)) {
    return;
  }

  if(isDefined(level.var_0075[self.var_2E25].var_1145)) {
    foreach(var_01 in level.var_0075[self.var_2E25].var_1145) {
      precachemodel(var_01.var_0106);
    }
  }

  for(var_03 = 0; var_03 < level.var_0075[self.var_2E25].var_6E9F.size; var_03++) {
    for(var_04 = 0; var_04 < level.var_0075[self.var_2E25].var_6E9F[var_03].size; var_04++) {
      if(level.var_0075[self.var_2E25].var_6E9F[var_03].size <= var_04) {
        continue;
      }

      if(isDefined(level.var_0075[self.var_2E25].var_6E9F[var_03][var_04].var_A265["modelName"])) {
        precachemodel(level.var_0075[self.var_2E25].var_6E9F[var_03][var_04].var_A265["modelName"]);
      }

      if(isDefined(level.var_0075[self.var_2E25].var_6E9F[var_03][var_04].var_A265["animation"])) {
        var_05 = level.var_0075[self.var_2E25].var_6E9F[var_03][var_04].var_A265["animation"];
        foreach(var_07 in var_05) {
          if(isDefined(var_07["mpAnim"])) {
            common_scripts\utility::func_6756("precacheMpAnim", var_07["mpAnim"]);
          }
        }
      }

      if(isDefined(level.var_0075[self.var_2E25].var_6E9F[var_03][var_04].var_A265["random_dynamic_attachment_1"])) {
        foreach(var_0A in level.var_0075[self.var_2E25].var_6E9F[var_03][var_04].var_A265["random_dynamic_attachment_1"]) {
          if(isDefined(var_0A) && var_0A != "") {
            precachemodel(var_0A);
            precachemodel(var_0A + "_destroy");
          }
        }

        foreach(var_0A in level.var_0075[self.var_2E25].var_6E9F[var_03][var_04].var_A265["random_dynamic_attachment_2"]) {
          if(isDefined(var_0A) && var_0A != "") {
            precachemodel(var_0A);
            precachemodel(var_0A + "_destroy");
          }
        }
      }
    }
  }
}

func_091C() {
  if(!isDefined(level.var_0075[self.var_2E25].var_6E9F)) {
    return;
  }

  for(var_00 = 0; var_00 < level.var_0075[self.var_2E25].var_6E9F.size; var_00++) {
    for(var_01 = 0; var_01 < level.var_0075[self.var_2E25].var_6E9F[var_00].size; var_01++) {
      if(level.var_0075[self.var_2E25].var_6E9F[var_00].size <= var_01) {
        continue;
      }

      var_02 = level.var_0075[self.var_2E25].var_6E9F[var_00][var_01];
      if(isDefined(var_02.var_A265["fx_filename"])) {
        for(var_03 = 0; var_03 < var_02.var_A265["fx_filename"].size; var_03++) {
          var_04 = var_02.var_A265["fx_filename"][var_03];
          var_05 = var_02.var_A265["fx_tag"][var_03];
          if(isDefined(var_04)) {
            if(isDefined(var_02.var_A265["fx"]) && isDefined(var_02.var_A265["fx"][var_03]) && var_02.var_A265["fx"][var_03].size == var_04.size) {
              continue;
            }

            for(var_06 = 0; var_06 < var_04.size; var_06++) {
              var_07 = var_04[var_06];
              var_08 = var_05[var_06];
              level.var_0075[self.var_2E25].var_6E9F[var_00][var_01].var_A265["fx"][var_03][var_06] = loadfx(var_07, var_08);
            }
          }
        }
      }

      var_09 = level.var_0075[self.var_2E25].var_6E9F[var_00][var_01].var_A265["loopfx_filename"];
      var_0A = level.var_0075[self.var_2E25].var_6E9F[var_00][var_01].var_A265["loopfx_tag"];
      if(isDefined(var_09)) {
        if(isDefined(var_02.var_A265["loopfx"]) && var_02.var_A265["loopfx"].size == var_09.size) {
          continue;
        }

        for(var_06 = 0; var_06 < var_09.size; var_06++) {
          var_0B = var_09[var_06];
          var_0C = var_0A[var_06];
          level.var_0075[self.var_2E25].var_6E9F[var_00][var_01].var_A265["loopfx"][var_06] = loadfx(var_0B, var_0C);
        }
      }
    }
  }
}

func_1F4B(param_00) {
  foreach(var_02 in self.var_2E27) {
    if(var_02 == param_00) {
      return 1;
    }
  }

  return 0;
}

func_2E1D() {
  var_00 = 0;
  var_01 = self.var_0106;
  var_02 = undefined;
  var_03 = self.var_0116;
  var_04 = undefined;
  var_05 = undefined;
  var_06 = undefined;
  var_07 = self.var_0106;
  func_2E1F(var_00, var_01, var_02, var_03, var_04, var_05, var_06);
  self endon("stop_taking_damage");
  for(;;) {
    var_00 = undefined;
    var_05 = undefined;
    var_04 = undefined;
    var_03 = undefined;
    var_08 = undefined;
    var_01 = undefined;
    var_02 = undefined;
    var_09 = undefined;
    var_0A = undefined;
    self waittill("damage", var_00, var_05, var_04, var_03, var_08, var_01, var_02, var_09, var_0A);
    if(!isDefined(var_00)) {
      continue;
    }

    if(isDefined(var_05) && isDefined(var_05.var_01B9) && var_05.var_01B9 == "soft_landing" && !var_05 func_1F4B(self)) {
      continue;
    }

    if(common_scripts\utility::func_57D7()) {
      var_00 = var_00 * 0.5;
    } else {
      var_00 = var_00 * 1;
    }

    if(var_00 <= 0) {
      continue;
    }

    if(common_scripts\utility::func_57D7()) {
      if(isDefined(var_05) && isPlayer(var_05)) {
        self.var_29D4 = var_05;
      }
    } else if(isDefined(var_05) && isPlayer(var_05)) {
      self.var_29D4 = var_05;
    } else if(isDefined(var_05) && isDefined(var_05.var_48EA) && isPlayer(var_05.var_48EA)) {
      self.var_29D4 = var_05.var_48EA;
    }

    var_08 = func_4487(var_08);
    if(func_5609(var_05, var_08)) {
      if(common_scripts\utility::func_57D7()) {
        var_00 = var_00 * 8;
      } else {
        var_00 = var_00 * 4;
      }
    }

    if(!isDefined(var_01) || var_01 == "") {
      var_01 = self.var_0106;
    }

    if(isDefined(var_02) && var_02 == "") {
      if(isDefined(var_09) && var_09 != "" && var_09 != "tag_body" && var_09 != "body_animate_jnt") {
        var_02 = var_09;
      } else {
        var_02 = undefined;
      }

      var_0B = level.var_0075[self.var_2E25].var_6E9F[0][0].var_A265["tagName"];
      if(isDefined(var_0B) && isDefined(var_09) && var_0B == var_09) {
        var_02 = undefined;
      }
    }

    if(var_08 == "splash" || var_08 == "energy") {
      if(isDefined(level.var_0075[self.var_2E25].var_6E9F[0][0].var_A265["splash_damage_scaler"])) {
        var_00 = var_00 * level.var_0075[self.var_2E25].var_6E9F[0][0].var_A265["splash_damage_scaler"];
      } else if(common_scripts\utility::func_57D7()) {
        var_00 = var_00 * 9;
      } else {
        var_00 = var_00 * 13;
      }

      if(var_07 == self.var_0106 && isDefined(self.var_815F)) {
        self setModel(self.var_815F);
      }

      func_2E17(int(var_00), var_03, var_04, var_05, var_08);
      continue;
    }

    thread func_2E1F(int(var_00), var_01, var_02, var_03, var_04, var_05, var_08);
  }
}

func_5609(param_00, param_01) {
  if(param_01 != "bullet") {
    return 0;
  }

  if(!isDefined(param_00)) {
    return 0;
  }

  var_02 = undefined;
  if(isPlayer(param_00)) {
    var_02 = param_00 getcurrentweapon();
  } else if(isDefined(level.var_3603) && level.var_3603) {
    if(isDefined(param_00.var_01D0)) {
      var_02 = param_00.var_01D0;
    }
  }

  if(!isDefined(var_02)) {
    return 0;
  }

  var_03 = function_01AA(var_02);
  if(isDefined(var_03) && var_03 == "spread") {
    return 1;
  }

  return 0;
}

func_45FD(param_00, param_01) {
  var_02 = spawnStruct();
  var_02.var_A265 = [];
  var_03 = -1;
  var_04 = -1;
  if(tolower(param_00) == tolower(self.var_0106) && !isDefined(param_01)) {
    param_00 = self.var_0106;
    param_01 = undefined;
    var_03 = 0;
    var_04 = 0;
  }

  for(var_05 = 0; var_05 < level.var_0075[self.var_2E25].var_6E9F.size; var_05++) {
    var_04 = self.var_2E10[var_05].var_A265["currentState"];
    if(level.var_0075[self.var_2E25].var_6E9F[var_05].size <= var_04) {
      continue;
    }

    if(!isDefined(param_01)) {
      continue;
    }

    if(isDefined(level.var_0075[self.var_2E25].var_6E9F[var_05][var_04].var_A265["tagName"])) {
      var_06 = level.var_0075[self.var_2E25].var_6E9F[var_05][var_04].var_A265["tagName"];
      if(tolower(var_06) == tolower(param_01)) {
        var_03 = var_05;
        break;
      }
    }
  }

  var_02.var_A265["stateIndex"] = var_04;
  var_02.var_A265["partIndex"] = var_03;
  return var_02;
}

func_2E1F(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07) {
  if(!isDefined(self.var_2E10)) {
    return;
  }

  if(self.var_2E10.size == 0) {
    return;
  }

  if(level.var_3A53) {
    self endon("destroyed");
  }

  var_08 = func_45FD(param_01, param_02);
  var_09 = var_08.var_A265["stateIndex"];
  var_0A = var_08.var_A265["partIndex"];
  if(var_0A < 0) {
    return;
  }

  var_0B = var_09;
  var_0C = 0;
  var_0D = 0;
  for(;;) {
    var_09 = self.var_2E10[var_0A].var_A265["currentState"];
    if(!isDefined(level.var_0075[self.var_2E25].var_6E9F[var_0A][var_09])) {
      break;
    }

    if(isDefined(level.var_0075[self.var_2E25].var_6E9F[var_0A][0].var_A265["alsoDamageParent"])) {
      if(func_4487(param_06) != "splash") {
        var_0E = level.var_0075[self.var_2E25].var_6E9F[var_0A][0].var_A265["alsoDamageParent"];
        var_0F = int(param_00 * var_0E);
        thread func_6807(var_0F, param_05, param_04, param_03, param_06, "", "");
      }
    }

    if(var_0A == 0 && func_4487(param_06) != "splash") {
      for(var_10 = 0; var_10 < level.var_0075[self.var_2E25].var_6E9F.size; var_10++) {
        var_11 = level.var_0075[self.var_2E25].var_6E9F[var_10];
        if(!isDefined(var_11[0].var_A265["receiveDamageFromParent"])) {
          continue;
        }

        var_12 = 0;
        if(isDefined(self.var_2E10[var_10].var_A265["currentState"])) {
          var_12 = self.var_2E10[var_10].var_A265["currentState"];
        }

        if(!isDefined(var_11[var_12])) {
          continue;
        }

        if(!isDefined(var_11[var_12].var_A265["tagName"])) {
          continue;
        }

        var_13 = var_11[var_12].var_A265["tagName"];
        var_0E = var_11[0].var_A265["receiveDamageFromParent"];
        var_14 = int(param_00 * var_0E);
        thread func_6807(var_14, param_05, param_04, param_03, param_06, "", var_13);
      }
    }

    if(!isDefined(level.var_0075[self.var_2E25].var_6E9F[var_0A][var_09].var_A265["health"])) {
      break;
    }

    if(!isDefined(self.var_2E10[var_0A].var_A265["health"])) {
      break;
    }

    if(var_0C) {
      self.var_2E10[var_0A].var_A265["health"] = level.var_0075[self.var_2E25].var_6E9F[var_0A][var_09].var_A265["health"];
    }

    var_0C = 0;
    if(isDefined(level.var_0075[self.var_2E25].var_6E9F[var_0A][var_09].var_A265["grenadeImpactDeath"]) && param_06 == "impact") {
      param_00 = 100000000;
    }

    if(isDefined(level.var_0075[self.var_2E25].var_6E9F[var_0A][var_09].var_A265["damage_threshold"]) && level.var_0075[self.var_2E25].var_6E9F[var_0A][var_09].var_A265["damage_threshold"] > param_00) {
      param_00 = 0;
    }

    var_15 = self.var_2E10[var_0A].var_A265["health"];
    var_16 = func_567E(var_0A, var_09, param_05);
    if(var_16) {
      var_17 = func_5825(var_0A, var_09, param_06);
      if(var_17) {
        if(isDefined(param_05)) {
          if(isPlayer(param_05)) {
            self.var_724D = self.var_724D + param_00;
          } else if(param_05 != self) {
            self.var_6727 = self.var_6727 + param_00;
          }
        }

        if(isDefined(param_06)) {
          if(param_06 == "melee" || param_06 == "impact") {
            param_00 = 100000;
          }
        }

        self.var_2E10[var_0A].var_A265["health"] = self.var_2E10[var_0A].var_A265["health"] - param_00;
      }
    }

    if(self.var_2E10[var_0B].var_A265["health"] > 0) {
      return;
    }

    if(isDefined(var_08)) {
      var_08.var_A265["fxcost"] = func_4283(var_0B, self.var_2E10[var_0B].var_A265["currentState"]);
      func_091D(self, var_08, param_01);
      if(!isDefined(self.var_A6E7)) {
        self.var_A6E7 = 1;
      } else {
        self.var_A6E7++;
      }

      self waittill("queue_processed", var_18);
      self.var_A6E7--;
      if(self.var_A6E7 == 0) {
        self.var_A6E7 = undefined;
      }

      if(!var_18) {
        self.var_2E10[var_0B].var_A265["health"] = var_16;
        return;
      }
    }

    param_01 = int(abs(self.var_2E10[var_0B].var_A265["health"]));
    if(param_01 < 0) {
      return;
    }

    self.var_2E10[var_0B].var_A265["currentState"]++;
    var_0A = self.var_2E10[var_0B].var_A265["currentState"];
    var_1A = var_0A - 1;
    var_1B = undefined;
    if(isDefined(level.var_0075[self.var_2E25].var_6E9F[var_0B][var_1A])) {
      var_1B = level.var_0075[self.var_2E25].var_6E9F[var_0B][var_1A].var_A265;
    }

    var_1D = undefined;
    if(isDefined(level.var_0075[self.var_2E25].var_6E9F[var_0B][var_0A])) {
      var_1D = level.var_0075[self.var_2E25].var_6E9F[var_0B][var_0A].var_A265;
    }

    if(!isDefined(level.var_0075[self.var_2E25].var_6E9F[var_0B][var_1A])) {
      return;
    }

    if(isDefined(level.var_0075[self.var_2E25].var_6E9F[var_0B][var_1A].var_A265["explode"])) {
      self.var_3949 = 1;
    }

    if(isDefined(self.var_5EFB) && isDefined(self.var_5EFB[common_scripts\utility::func_9AAD(var_0B)])) {
      for(var_10 = 0; var_10 < self.var_5EFB[common_scripts\utility::func_9AAD(var_0B)].size; var_10++) {
        self notify(self.var_5EFB[common_scripts\utility::func_9AAD(var_0B)][var_10]);
        if(common_scripts\utility::func_57D7() && self.var_6297) {
          self.var_6296 notify(self.var_5EFB[common_scripts\utility::func_9AAD(var_0B)][var_10]);
        }
      }

      self.var_5EFB[common_scripts\utility::func_9AAD(var_0B)] = undefined;
    }

    if(isDefined(var_1B["break_nearby_lights"])) {
      func_2E01(var_1B["break_nearby_lights"]);
    }

    if(isDefined(level.var_0075[self.var_2E25].var_6E9F[var_0B][var_0A])) {
      if(var_0B == 0) {
        var_1C = var_1D["modelName"];
        if(isDefined(var_1C) && var_1C != self.var_0106) {
          self setModel(var_1C);
          if(common_scripts\utility::func_57D7() && self.var_6297) {
            self.var_6296 setModel(var_1C);
          }

          func_2E19(var_1D);
        }
      } else {
        func_4D03(param_03);
        if(common_scripts\utility::func_57D7() && self.var_6297) {
          self.var_6296 func_4D03(param_03);
        }

        param_03 = var_1D["tagName"];
        if(isDefined(param_03)) {
          func_8BED(param_03);
          if(common_scripts\utility::func_57D7() && self.var_6297) {
            self.var_6296 func_8BED(param_03);
          }
        }
      }
    }

    var_1E = func_4168();
    if(isDefined(self.var_3949)) {
      func_23A2(var_1E);
    }

    var_2E = func_2DE4(var_1B, var_1E, param_07, var_0B);
    var_2E = func_2E00(var_1B, var_1E, param_07, var_0B, var_2E);
    self notify("FX_State_Change_Kill" + var_0B);
    var_2E = func_2E16(var_1B, var_1E, param_07, var_2E);
    if(isDefined(level.var_0075[self.var_2E25].var_6E9F[var_0B][var_1A].var_A265["loopfx"])) {
      var_1F = level.var_0075[self.var_2E25].var_6E9F[var_0B][var_1A].var_A265["loopfx_filename"].size;
      if(var_1F > 0) {
        self notify("FX_State_Change" + var_0B);
      }

      for(var_20 = 0; var_20 < var_1F; var_20++) {
        var_21 = level.var_0075[self.var_2E25].var_6E9F[var_0B][var_1A].var_A265["loopfx"][var_20];
        var_22 = level.var_0075[self.var_2E25].var_6E9F[var_0B][var_1A].var_A265["loopfx_tag"][var_20];
        var_23 = level.var_0075[self.var_2E25].var_6E9F[var_0B][var_1A].var_A265["loopfx_rate"][var_20];
        thread func_5EEF(var_21, var_22, var_23, var_0B);
      }
    }

    if(isDefined(level.var_0075[self.var_2E25].var_6E9F[var_0B][var_1A].var_A265["loopsound"])) {
      for(var_10 = 0; var_10 < level.var_0075[self.var_2E25].var_6E9F[var_0B][var_1A].var_A265["loopsound"].size; var_10++) {
        var_24 = func_583B("loopsoundCause", var_1B, var_10, param_07);
        if(var_24) {
          var_25 = level.var_0075[self.var_2E25].var_6E9F[var_0B][var_1A].var_A265["loopsound"][var_10];
          var_26 = level.var_0075[self.var_2E25].var_6E9F[var_0B][var_1A].var_A265["tagName"];
          thread func_7152(var_25, var_26);
          if(!isDefined(self.var_5EFB)) {
            self.var_5EFB = [];
          }

          if(!isDefined(self.var_5EFB[common_scripts\utility::func_9AAD(var_0B)])) {
            self.var_5EFB[common_scripts\utility::func_9AAD(var_0B)] = [];
          }

          var_27 = self.var_5EFB[common_scripts\utility::func_9AAD(var_0B)].size;
          self.var_5EFB[common_scripts\utility::func_9AAD(var_0B)][var_27] = "stop sound" + var_25;
        }
      }
    }

    if(isDefined(level.var_0075[self.var_2E25].var_6E9F[var_0B][var_1A].var_A265["triggerCarAlarm"])) {
      thread func_3097();
    }

    if(isDefined(level.var_0075[self.var_2E25].var_6E9F[var_0B][var_1A].var_A265["break_nearby_lights"])) {
      thread func_1BA6();
    }

    if(isDefined(level.var_0075[self.var_2E25].var_6E9F[var_0B][var_1A].var_A265["healthdrain_amount"])) {
      self notify("Health_Drain_State_Change" + var_0B);
      var_28 = level.var_0075[self.var_2E25].var_6E9F[var_0B][var_1A].var_A265["healthdrain_amount"];
      var_29 = level.var_0075[self.var_2E25].var_6E9F[var_0B][var_1A].var_A265["healthdrain_interval"];
      var_2A = level.var_0075[self.var_2E25].var_6E9F[var_0B][var_1A].var_A265["modelName"];
      var_2B = level.var_0075[self.var_2E25].var_6E9F[var_0B][var_1A].var_A265["tagName"];
      var_2C = level.var_0075[self.var_2E25].var_6E9F[var_0B][var_1A].var_A265["badplace_radius"];
      var_2D = level.var_0075[self.var_2E25].var_6E9F[var_0B][var_1A].var_A265["badplace_team"];
      if(var_28 > 0) {
        thread func_4C08(var_28, var_29, var_0B, var_2A, var_2B, var_2C, var_2D);
      }
    }

    var_4A = level.var_0075[self.var_2E25].var_6E9F[var_0B][var_1A].var_A265["dot"];
    if(isDefined(var_4A)) {
      foreach(var_30 in var_4A) {
        var_31 = var_30.var_00D4;
        if(var_30.var_01B9 == "predefined" && isDefined(var_31)) {
          var_32 = [];
          foreach(var_34 in level.var_0075[self.var_2E25].var_2DF3[var_31]) {
            var_35 = var_34["classname"];
            var_36 = undefined;
            switch (var_35) {
              case "trigger_radius":
                var_37 = var_34["origin"];
                var_38 = var_34["spawnflags"];
                var_39 = var_34["radius"];
                var_3A = var_34["height"];
                var_36 = func_27E3(self.var_0116 + var_37, var_38, var_39, var_3A);
                var_36.var_99C1 = var_30.var_99C1;
                var_32[var_32.size] = var_36;
                break;

              default:
                break;
            }
          }

          level thread func_92C7(var_32);
          continue;
        }

        if(isDefined(var_30)) {
          if(isDefined(var_30.var_95A6)) {
            var_30 func_866B(self gettagorigin(var_30.var_95A6));
          }

          level thread func_92C7([var_30]);
        }
      }

      var_4A = undefined;
    }

    if(isDefined(level.var_0075[self.var_2E25].var_6E9F[var_0B][var_1A].var_A265["explode"])) {
      var_15 = 1;
      var_3D = level.var_0075[self.var_2E25].var_6E9F[var_0B][var_1A].var_A265["explode_force_min"];
      var_3E = level.var_0075[self.var_2E25].var_6E9F[var_0B][var_1A].var_A265["explode_force_max"];
      var_3F = level.var_0075[self.var_2E25].var_6E9F[var_0B][var_1A].var_A265["explode_angularImpulse_min"];
      var_40 = level.var_0075[self.var_2E25].var_6E9F[var_0B][var_1A].var_A265["explode_angularImpulse_max"];
      var_41 = level.var_0075[self.var_2E25].var_6E9F[var_0B][var_1A].var_A265["explode_range"];
      var_42 = level.var_0075[self.var_2E25].var_6E9F[var_0B][var_1A].var_A265["explode_mindamage"];
      var_43 = level.var_0075[self.var_2E25].var_6E9F[var_0B][var_1A].var_A265["explode_maxdamage"];
      var_44 = level.var_0075[self.var_2E25].var_6E9F[var_0B][var_1A].var_A265["continueDamage"];
      var_45 = level.var_0075[self.var_2E25].var_6E9F[var_0B][var_1A].var_A265["originOffset"];
      var_46 = level.var_0075[self.var_2E25].var_6E9F[var_0B][var_1A].var_A265["earthQuakeScale"];
      var_47 = level.var_0075[self.var_2E25].var_6E9F[var_0B][var_1A].var_A265["earthQuakeRadius"];
      var_48 = level.var_0075[self.var_2E25].var_6E9F[var_0B][var_1A].var_A265["originOffset3d"];
      var_49 = level.var_0075[self.var_2E25].var_6E9F[var_0B][var_1A].var_A265["delaytime"];
      if(isDefined(param_06) && param_06 != self) {
        self.var_1180 = param_06;
        if(self.var_003B == "script_vehicle") {
          self.var_29B2 = param_07;
        }
      }

      thread func_3923(var_0B, var_3D, var_3E, var_41, var_42, var_43, var_44, var_45, var_46, var_47, param_06, var_48, var_49, var_3F, var_40);
    }

    var_17 = undefined;
    if(isDefined(level.var_0075[self.var_2E25].var_6E9F[var_0B][var_1A].var_A265["physics"])) {
      var_10 = 0;
      while(var_10 < level.var_0075[self.var_2E25].var_6E9F[var_0B][var_1A].var_A265["physics"].size) {
        var_17 = undefined;
        var_4B = level.var_0075[self.var_2E25].var_6E9F[var_0B][var_1A].var_A265["physics_tagName"][var_10];
        var_4C = level.var_0075[self.var_2E25].var_6E9F[var_0B][var_1A].var_A265["physics_velocity"][var_10];
        var_4D = undefined;
        if(isDefined(var_4C)) {
          var_4E = undefined;
          if(isDefined(var_4B)) {
            var_4E = self gettagangles(var_4B);
          } else if(isDefined(param_03)) {
            var_4E = self gettagangles(param_03);
          }

          var_17 = undefined;
          if(isDefined(var_4B)) {
            var_17 = self gettagorigin(var_4B);
          } else if(isDefined(param_03)) {
            var_17 = self gettagorigin(param_03);
          }

          var_4F = var_4C[0] - 5 + randomfloat(10);
          var_50 = var_4C[1] - 5 + randomfloat(10);
          var_51 = var_4C[2] - 5 + randomfloat(10);
          var_52 = anglesToForward(var_4E) * var_4F * randomfloatrange(80, 110);
          var_53 = anglestoright(var_4E) * var_50 * randomfloatrange(80, 110);
          var_54 = anglestoup(var_4E) * var_51 * randomfloatrange(80, 110);
          var_4D = var_52 + var_53 + var_54;
        } else {
          var_56 = param_05;
          var_55 = (0, 0, 0);
          if(isDefined(param_07)) {
            var_55 = param_07.var_0116;
            var_56 = vectornormalize(param_05 - var_55);
            var_56 = var_56 * 200;
          }
        }

        if(isDefined(var_4C)) {
          var_57 = undefined;
          for(var_4E = 0; var_4E < level.var_0075[self.var_2E25].var_6E9F.size; var_4E++) {
            if(!isDefined(level.var_0075[self.var_2E25].var_6E9F[var_4E][0].var_A265["tagName"])) {
              continue;
            }

            if(level.var_0075[self.var_2E25].var_6E9F[var_4E][0].var_A265["tagName"] != var_4C) {
              continue;
            }

            var_57 = var_4E;
            break;
          }

          if(isDefined(var_10)) {
            thread func_6FA3(var_57, 0, var_10, var_56);
          } else {
            thread func_6FA3(var_57, 0, param_05, var_56);
          }

          continue;
        }

        if(isDefined(var_10)) {
          thread func_6FA3(var_0C, var_1B, var_10, var_56);
        } else {
          thread func_6FA3(var_0C, var_1B, param_05, var_56);
        }

        return;
        var_4B++;
      }
    }

    if(isDefined(level.var_0075[self.var_2E25].var_6E9F[var_1B][var_10].var_A265) && isDefined(level.var_0075[self.var_2E25].var_6E9F[var_1B][var_10].var_A265["functionNotify"])) {
      self notify(level.var_0075[self.var_2E25].var_6E9F[var_1B][var_10].var_A265["functionNotify"]);
    }

    if(isDefined(level.var_0075[self.var_2E25].var_6E9F[var_1B][var_10].var_A265["function"])) {
      self thread[[level.var_0075[self.var_2E25].var_6E9F[var_1B][var_10].var_A265["function"]]]();
    }

    var_1E = 1;
  }
}

func_2E19(param_00) {
  var_01 = param_00["splashRotation"];
  var_02 = param_00["rotateTo"];
  if(!isDefined(var_02)) {
    return;
  }

  if(!isDefined(var_01)) {
    return;
  }

  if(!var_01) {
    return;
  }

  self.var_001D = (self.var_001D[0], var_02[1], self.var_001D[2]);
}

func_29A7(param_00) {
  var_01 = strtok(param_00, " ");
  var_02 = strtok("splash melee bullet splash impact unknown", " ");
  var_03 = "";
  foreach(var_05 in var_01) {
    var_02 = common_scripts\utility::func_0F93(var_02, var_05);
  }

  foreach(var_08 in var_02) {
    var_03 = var_03 + var_08 + " ";
  }

  return var_03;
}

func_2E17(param_00, param_01, param_02, param_03, param_04) {
  if(param_00 <= 0) {
    return;
  }

  if(isDefined(self.var_3928)) {
    return;
  }

  if(!isDefined(level.var_0075[self.var_2E25].var_6E9F)) {
    return;
  }

  var_05 = func_440C(param_02);
  if(var_05.size <= 0) {
    return;
  }

  var_05 = func_8666(var_05, param_01);
  var_06 = func_456B(var_05);
  foreach(var_08 in var_05) {
    var_09 = var_08.var_A265["distance"] * 1.4;
    var_0A = param_00 - var_09 - var_06;
    if(var_0A <= 0) {
      continue;
    }

    if(isDefined(self.var_3928)) {
      continue;
    }

    thread func_2E1F(var_0A, var_08.var_A265["modelName"], var_08.var_A265["tagName"], param_01, param_02, param_03, param_04, var_08);
  }
}

func_440C(param_00) {
  var_01 = [];
  if(!isDefined(level.var_0075[self.var_2E25].var_6E9F)) {
    return var_01;
  }

  for(var_02 = 0; var_02 < level.var_0075[self.var_2E25].var_6E9F.size; var_02++) {
    var_03 = var_02;
    var_04 = self.var_2E10[var_03].var_A265["currentState"];
    for(var_05 = 0; var_05 < level.var_0075[self.var_2E25].var_6E9F[var_03].size; var_05++) {
      var_06 = level.var_0075[self.var_2E25].var_6E9F[var_03][var_05].var_A265["splashRotation"];
      if(isDefined(var_06) && var_06) {
        var_07 = vectortoangles(param_00);
        var_08 = var_07[1] - 90;
        level.var_0075[self.var_2E25].var_6E9F[var_03][var_05].var_A265["rotateTo"] = (0, var_08, 0);
      }
    }

    if(!isDefined(level.var_0075[self.var_2E25].var_6E9F[var_03][var_04])) {
      continue;
    }

    var_09 = level.var_0075[self.var_2E25].var_6E9F[var_03][var_04].var_A265["tagName"];
    if(!isDefined(var_09)) {
      var_09 = "";
    }

    if(var_09 == "") {
      continue;
    }

    var_0A = level.var_0075[self.var_2E25].var_6E9F[var_03][var_04].var_A265["modelName"];
    if(!isDefined(var_0A)) {
      var_0A = "";
    }

    var_0B = var_01.size;
    var_01[var_0B] = spawnStruct();
    var_01[var_0B].var_A265["modelName"] = var_0A;
    var_01[var_0B].var_A265["tagName"] = var_09;
  }

  return var_01;
}

func_8666(param_00, param_01) {
  for(var_02 = 0; var_02 < param_00.size; var_02++) {
    var_03 = distance(param_01, self gettagorigin(param_00[var_02].var_A265["tagName"]));
    param_00[var_02].var_A265["distance"] = var_03;
  }

  return param_00;
}

func_456B(param_00) {
  var_01 = undefined;
  foreach(var_03 in param_00) {
    var_04 = var_03.var_A265["distance"];
    if(!isDefined(var_01)) {
      var_01 = var_04;
    }

    if(var_04 < var_01) {
      var_01 = var_04;
    }
  }

  return var_01;
}

func_583B(param_00, param_01, param_02, param_03, param_04) {
  if(isDefined(param_04)) {
    var_05 = param_01[param_00][param_04][param_02];
  } else {
    var_05 = param_02[param_01][param_03];
  }

  if(!isDefined(var_05)) {
    return 1;
  }

  if(var_05 == param_03) {
    return 1;
  }

  return 0;
}

func_567E(param_00, param_01, param_02) {
  if(isDefined(self.var_3E1B)) {
    return 1;
  }

  if(isDefined(level.var_0075[self.var_2E25].var_6E9F[param_00][param_01].var_A265["explode"])) {
    if(isDefined(self.var_323D)) {
      return 0;
    }
  }

  if(!isDefined(param_02)) {
    return 1;
  }

  if(param_02 == self) {
    return 1;
  }

  var_03 = level.var_0075[self.var_2E25].var_6E9F[param_00][param_01].var_A265["validAttackers"];
  if(!isDefined(var_03)) {
    return 1;
  }

  if(var_03 == "no_player") {
    if(!isPlayer(param_02)) {
      return 1;
    }

    if(!isDefined(param_02.var_29CF)) {
      return 1;
    }

    if(param_02.var_29CF == 0) {
      return 1;
    }
  } else if(var_03 == "player_only") {
    if(isPlayer(param_02)) {
      return 1;
    }

    if(isDefined(param_02.var_29CF) && param_02.var_29CF) {
      return 1;
    }
  } else if(var_03 == "no_ai" && isDefined(level.var_5665)) {
    if(![[level.var_5665]](param_02)) {
      return 1;
    }
  } else if(var_03 == "ai_only" && isDefined(level.var_5665)) {
    if([[level.var_5665]](param_02)) {
      return 1;
    }
  } else {}

  return 0;
}

func_5825(param_00, param_01, param_02) {
  if(!isDefined(param_02)) {
    return 1;
  }

  var_03 = level.var_0075[self.var_2E25].var_6E9F[param_00][param_01].var_A265["godModeAllowed"];
  if(var_03 && (isDefined(self.var_480F) && self.var_480F) || isDefined(self.var_812F) && self.var_812F && param_02 == "bullet") {
    return 0;
  }

  var_04 = level.var_0075[self.var_2E25].var_6E9F[param_00][param_01].var_A265["validDamageCause"];
  if(!isDefined(var_04)) {
    return 1;
  }

  if(var_04 == "splash" && param_02 != "splash") {
    return 0;
  }

  if(var_04 == "no_splash" && param_02 == "splash") {
    return 0;
  }

  if((var_04 == "no_melee" && param_02 == "melee") || param_02 == "impact") {
    return 0;
  }

  if(var_04 == "bullet" && param_02 != "bullet") {
    return 0;
  }

  return 1;
}

func_4487(param_00) {
  if(!isDefined(param_00)) {
    return "unknown";
  }

  param_00 = tolower(param_00);
  switch (param_00) {
    case "mod_crush":
    case "mod_melee":
    case "melee":
      return "melee";

    case "mod_rifle_bullet":
    case "mod_pistol_bullet":
    case "bullet":
      return "bullet";

    case "mod_explosive":
    case "mod_projectile_splash":
    case "mod_projectile":
    case "mod_grenade_splash":
    case "mod_grenade":
    case "splash":
      return "splash";

    case "mod_impact":
      return "impact";

    case "mod_energy":
      return "energy";

    case "unknown":
      return "unknown";

    default:
      return "unknown";
  }
}

func_29A6(param_00, param_01, param_02) {
  self notify("stop_damage_mirror");
  self endon("stop_damage_mirror");
  param_00 endon("stop_taking_damage");
  self setCanDamage(1);
  for(;;) {
    self waittill("damage", var_03, var_04, var_05, var_06, var_07);
    param_00 notify("damage", var_03, var_04, var_05, var_06, var_07, param_01, param_02);
    var_03 = undefined;
    var_04 = undefined;
    var_05 = undefined;
    var_06 = undefined;
    var_07 = undefined;
  }
}

func_0914() {
  self.var_724D = 0;
  self.var_6727 = 0;
  self.var_1FCF = 1;
}

func_5EEF(param_00, param_01, param_02, param_03) {
  self endon("FX_State_Change" + param_03);
  self endon("delete_destructible");
  level endon("putout_fires");
  while(isDefined(self)) {
    var_04 = func_4168();
    playFXOnTag(param_00, var_04, param_01);
    wait(param_02);
  }
}

func_4C08(param_00, param_01, param_02, param_03, param_04, param_05, param_06) {
  self endon("Health_Drain_State_Change" + param_02);
  level endon("putout_fires");
  self endon("destroyed");
  if(isDefined(param_05) && isDefined(level.var_2DE6)) {
    param_05 = param_05 * level.var_2DE6;
  }

  if(isDefined(param_00) && isDefined(level.var_2E06)) {
    param_00 = param_00 * level.var_2E06;
  }

  wait(param_01);
  self.var_4C18 = 1;
  var_07 = undefined;
  if(isDefined(level.var_2F30) && level.var_2F30) {
    param_05 = undefined;
  }

  if(isDefined(param_05) && isDefined(level.var_14F6)) {
    var_07 = "" + gettime();
    if(!isDefined(self.var_2F71)) {
      if(isDefined(self.var_8276)) {
        param_05 = self.var_8276;
      }

      if(common_scripts\utility::func_57D7() && isDefined(param_06)) {
        if(param_06 == "both") {
          [[level.var_14F6]](var_07, 0, self.var_0116, param_05, 128, "allies", "bad_guys");
        } else {
          [[level.var_14F6]](var_07, 0, self.var_0116, param_05, 128, param_06);
        }

        thread func_14F8(var_07);
      } else {
        [[level.var_14F6]](var_07, 0, self.var_0116, param_05, 128);
        thread func_14F8(var_07);
      }
    }
  }

  while(isDefined(self) && self.var_2E10[param_02].var_A265["health"] > 0) {
    self notify("damage", param_00, self, (0, 0, 0), (0, 0, 0), "MOD_UNKNOWN", param_03, param_04);
    wait(param_01);
  }

  self notify("remove_badplace");
}

func_14F8(param_00) {
  common_scripts\utility::func_A70A("destroyed", "remove_badplace");
  [[level.var_14F7]](param_00);
}

func_6FA3(param_00, param_01, param_02, param_03) {
  var_04 = func_6FA6(param_00, param_01);
  var_04 method_82C5(param_02, param_03);
}

func_6FA4(param_00, param_01, param_02, param_03) {
  var_04 = func_6FA6(param_00, param_01);
  var_04 method_83C9(param_02, param_03);
}

func_6FA6(param_00, param_01) {
  var_02 = level.var_0075[self.var_2E25].var_6E9F[param_00][param_01].var_A265["modelName"];
  var_03 = level.var_0075[self.var_2E25].var_6E9F[param_00][param_01].var_A265["tagName"];
  func_4D03(var_03);
  if(level.var_2E29.size >= level.var_2E2A) {
    func_6FA7(level.var_2E29[0]);
  }

  var_04 = spawn("script_model", self gettagorigin(var_03));
  var_04.var_001D = self gettagangles(var_03);
  var_04 setModel(var_02);
  level.var_2E29[level.var_2E29.size] = var_04;
  return var_04;
}

func_6FA7(param_00) {
  var_01 = [];
  for(var_02 = 0; var_02 < level.var_2E29.size; var_02++) {
    if(level.var_2E29[var_02] == param_00) {
      continue;
    }

    var_01[var_01.size] = level.var_2E29[var_02];
  }

  level.var_2E29 = var_01;
  if(isDefined(param_00)) {
    param_00 delete();
  }
}

func_3923(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A, param_0B, param_0C, param_0D, param_0E) {
  if(isDefined(param_03) && isDefined(level.var_2DF5)) {
    param_03 = param_03 * level.var_2DF5;
  }

  if(!isDefined(param_07)) {
    param_07 = 80;
  }

  if(!isDefined(param_0B)) {
    param_0B = (0, 0, 0);
  }

  if(!isDefined(param_06) || isDefined(param_06) && !param_06) {
    if(isDefined(self.var_3928)) {
      return;
    }

    self.var_3928 = 1;
  }

  if(!isDefined(param_0C)) {
    param_0C = 0;
  }

  self notify("exploded", param_0A);
  level notify("destructible_exploded", self, param_0A);
  if(self.var_003B == "script_vehicle") {
    self notify("death", param_0A, self.var_29B2);
  }

  if(common_scripts\utility::func_57D7()) {
    thread func_2FC6();
  }

  if(!level.var_3A53) {
    wait 0.05;
  }

  if(!isDefined(self)) {
    return;
  }

  var_0F = self.var_2E10[param_00].var_A265["currentState"];
  var_10 = undefined;
  if(isDefined(level.var_0075[self.var_2E25].var_6E9F[param_00][var_0F])) {
    var_10 = level.var_0075[self.var_2E25].var_6E9F[param_00][var_0F].var_A265["tagName"];
  }

  if(isDefined(var_10)) {
    var_11 = self gettagorigin(var_10);
  } else {
    var_11 = self.var_0116;
  }

  self notify("damage", param_05, self, (0, 0, 0), var_11, "MOD_EXPLOSIVE", "", "");
  self notify("stop_car_alarm");
  waittillframeend;
  if(isDefined(level.var_0075[self.var_2E25].var_6E9F)) {
    for(var_12 = level.var_0075[self.var_2E25].var_6E9F.size - 1; var_12 >= 0; var_12--) {
      if(var_12 == param_00) {
        continue;
      }

      var_13 = self.var_2E10[var_12].var_A265["currentState"];
      if(var_13 >= level.var_0075[self.var_2E25].var_6E9F[var_12].size) {
        var_13 = level.var_0075[self.var_2E25].var_6E9F[var_12].size - 1;
      }

      var_14 = level.var_0075[self.var_2E25].var_6E9F[var_12][var_13].var_A265["modelName"];
      var_10 = level.var_0075[self.var_2E25].var_6E9F[var_12][var_13].var_A265["tagName"];
      if(!isDefined(var_14)) {
        continue;
      }

      if(!isDefined(var_10)) {
        continue;
      }

      var_15 = 0;
      if(isDefined(self.var_2E10[var_12].var_A265["health"])) {
        var_15 = self.var_2E10[var_12].var_A265["health"];
      }

      var_16 = 0;
      if(isDefined(level.var_0075[self.var_2E25].var_6E9F[var_12][var_13].var_A265["health"])) {
        var_16 = level.var_0075[self.var_2E25].var_6E9F[var_12][var_13].var_A265["health"];
      }

      if(var_16 > 0 && var_15 <= 0) {
        continue;
      }

      if(isDefined(level.var_0075[self.var_2E25].var_6E9F[var_12][0].var_A265["physicsOnExplosion"])) {
        if(level.var_0075[self.var_2E25].var_6E9F[var_12][0].var_A265["physicsOnExplosion"] > 0) {
          var_17 = level.var_0075[self.var_2E25].var_6E9F[var_12][0].var_A265["physicsOnExplosion"];
          var_18 = self gettagorigin(var_10);
          var_19 = vectornormalize(var_18 - var_11);
          var_19 = var_19 * randomfloatrange(param_01, param_02) * var_17;
          if(isDefined(param_0D) && isDefined(param_0E)) {
            var_1A = common_scripts\utility::func_7A61(param_0D, param_0E);
            thread func_6FA4(var_12, var_13, var_19, var_1A);
          } else {
            thread func_6FA3(var_12, var_13, var_18, var_19);
          }

          continue;
        }
      }
    }
  }

  var_1B = !isDefined(param_0E) || isDefined(param_0E) && !param_0E;
  if(var_1B) {
    self notify("stop_taking_damage");
  }

  if(!level.var_3A53) {
    wait 0.05;
  }

  if(!isDefined(self)) {
    return;
  }

  var_1C = var_19 + (0, 0, var_0F) + var_13;
  var_1D = getsubstr(level.var_0075[self.var_2E25].var_A265["type"], 0, 7) == "vehicle";
  if(var_1D) {
    anim.var_5B7D = gettime();
    anim.var_5B7A = var_1C;
    anim.var_5B7B = var_19;
    anim.var_5B7C = param_0B;
  }

  level thread func_846F(1);
  if(var_14 > 0) {
    wait(var_14);
  }

  if(isDefined(level.var_2E12)) {
    thread[[level.var_2E12]]();
  }

  if(common_scripts\utility::func_57D7()) {
    if(level.var_3FD4 == 0 && !func_7381()) {
      self entityradiusdamage(var_1C, param_0B, param_0D, param_0C, self, "MOD_RIFLE_BULLET");
    } else {
      self entityradiusdamage(var_1C, param_0B, param_0D, param_0C, self);
    }

    if(isDefined(self.var_29D4) && var_1D) {
      self.var_29D4 notify("destroyed_car");
      level notify("player_destroyed_car", self.var_29D4, var_1C);
    }
  } else {
    var_1E = "destructible_toy";
    if(var_1D) {
      var_1E = "destructible_car";
    }

    if(!isDefined(self.var_29D4)) {
      self entityradiusdamage(var_1C, param_0B, param_0D, param_0C, self, "MOD_EXPLOSIVE", var_1E);
    } else {
      self entityradiusdamage(var_1C, param_0B, param_0D, param_0C, self.var_29D4, "MOD_EXPLOSIVE", var_1E);
      if(var_1D) {
        self.var_29D4 notify("destroyed_car");
        level notify("player_destroyed_car", self.var_29D4, var_1C);
      }
    }
  }

  if(isDefined(var_11) && isDefined(var_12)) {
    earthquake(var_11, 2, var_1D, var_12);
  }

  level thread func_846F(0, 0.05);
  var_1F = 0.01;
  var_20 = param_0C * var_1F;
  param_0C = param_0C * 0.99;
  physicsexplosionsphere(var_1B, param_0C, 0, var_20);
  if(var_1C) {
    self setCanDamage(0);
    thread func_2398();
  }

  self notify("destroyed");
}

func_2398() {
  wait 0.05;
  while(isDefined(self) && isDefined(self.var_A6E7)) {
    self waittill("queue_processed");
    wait 0.05;
  }

  if(!isDefined(self)) {
    return;
  }

  self.var_0ED4 = undefined;
  self.var_1180 = undefined;
  self.var_1FCF = undefined;
  self.var_1FD9 = undefined;
  self.var_29D4 = undefined;
  self.var_2E10 = undefined;
  self.var_0075 = undefined;
  self.var_2E25 = undefined;
  self.var_4C18 = undefined;
  self.var_6727 = undefined;
  self.var_724D = undefined;
  if(!isDefined(level.var_2DEC)) {
    return;
  }

  self.var_8249 = undefined;
  self.var_3949 = undefined;
  self.var_5EFB = undefined;
  self.var_1FC7 = undefined;
}

func_846F(param_00, param_01) {
  level notify("set_disable_friendlyfire_value_delayed");
  level endon("set_disable_friendlyfire_value_delayed");
  if(isDefined(param_01)) {
    wait(param_01);
  }

  level.var_3ECF = param_00;
}

func_258B() {
  var_00 = func_4391();
  if(!isDefined(var_00)) {
    return;
  }

  var_00[[level.var_2587]]();
  var_00.var_0116 = var_00.var_0116 - (0, 0, 10000);
}

func_2FC6() {
  var_00 = func_4391();
  if(!isDefined(var_00)) {
    return;
  }

  var_00.var_0116 = var_00.var_0116 + (0, 0, 10000);
  var_00[[level.var_2FC3]]();
  var_00.var_0116 = var_00.var_0116 - (0, 0, 10000);
}

func_4391() {
  if(!isDefined(self.var_01A2)) {
    return undefined;
  }

  var_00 = getEntArray(self.var_01A2, "targetname");
  foreach(var_02 in var_00) {
    if(isspawner(var_02)) {
      continue;
    }

    if(isDefined(var_02.var_8161)) {
      continue;
    }

    if(var_02.var_003B == "light") {
      continue;
    }

    if(!var_02.var_0187 & 1) {
      continue;
    }

    return var_02;
  }
}

func_4D03(param_00) {
  self hidepart(param_00);
}

func_8BED(param_00) {
  self showpart(param_00);
}

func_2F37() {
  self.var_323D = 1;
}

func_3DED() {
  self.var_323D = undefined;
  self.var_3E1B = 1;
  self notify("damage", 100000, self, self.var_0116, self.var_0116, "MOD_EXPLOSIVE", "", "");
}

func_4168() {
  if(!common_scripts\utility::func_57D7()) {
    return self;
  }

  if(self.var_6297) {
    var_00 = self.var_6296;
  } else {
    var_00 = self;
  }

  return var_00;
}

func_7152(param_00, param_01) {
  var_02 = func_4168();
  var_03 = spawn("script_origin", (0, 0, 0));
  if(isDefined(param_01)) {
    var_03.var_0116 = var_02 gettagorigin(param_01);
  } else {
    var_03.var_0116 = var_02.var_0116;
  }

  var_03 method_861D(param_00);
  var_02 thread func_3E01(param_00);
  var_02 waittill("stop sound" + param_00);
  if(!isDefined(var_03)) {
    return;
  }

  var_03 stoploopsound(param_00);
  var_03 delete();
}

func_3E01(param_00) {
  self endon("stop sound" + param_00);
  level waittill("putout_fires");
  self notify("stop sound" + param_00);
}

func_6807(param_00, param_01, param_02, param_03, param_04, param_05, param_06) {
  waittillframeend;
  if(isDefined(self.var_3928)) {
    return;
  }

  if(common_scripts\utility::func_57D7()) {
    param_00 = param_00 / 0.5;
  } else {
    param_00 = param_00 / 1;
  }

  self notify("damage", param_00, param_01, param_02, param_03, param_04, param_05, param_06);
}

func_71A7(param_00, param_01) {
  if(isDefined(param_01)) {
    var_02 = spawn("script_origin", self gettagorigin(param_01));
    var_02 method_805C();
    var_02 linkto(self, param_01, (0, 0, 0), (0, 0, 0));
  } else {
    var_02 = spawn("script_origin", (0, 0, 0));
    var_02 method_805C();
    var_02.var_0116 = self.var_0116;
    var_02.var_001D = self.var_001D;
    var_02 linkto(self);
  }

  var_02 method_8617(param_00);
  wait(5);
  if(isDefined(var_02)) {
    var_02 delete();
  }
}

func_3097() {
  if(isDefined(self.var_1FD9)) {
    return;
  }

  self.var_1FD9 = 1;
  if(!func_8B54()) {
    return;
  }

  self.var_1FC7 = spawn("script_model", self.var_0116);
  self.var_1FC7 method_805C();
  self.var_1FC7 method_861D("car_alarm");
  level.var_2928++;
  thread func_1FC8();
  self waittill("stop_car_alarm");
  level.var_5B79 = gettime();
  level.var_2928--;
  self.var_1FC7 stoploopsound("car_alarm");
  self.var_1FC7 delete();
}

func_1FC8() {
  self endon("stop_car_alarm");
  wait(25);
  if(!isDefined(self)) {
    return;
  }

  thread func_71A7("car_alarm_off");
  self notify("stop_car_alarm");
}

func_8B54() {
  if(level.var_2928 >= 2) {
    return 0;
  }

  var_00 = undefined;
  if(!isDefined(level.var_5B79)) {
    if(common_scripts\utility::func_24A6()) {
      return 1;
    }

    var_00 = gettime() - level.var_254D;
  } else {
    var_00 = gettime() - level.var_5B79;
  }

  if(level.var_2928 == 0 && var_00 >= 120) {
    return 1;
  }

  if(randomint(100) <= 33) {
    return 1;
  }

  return 0;
}

func_30DF(param_00, param_01, param_02, param_03) {
  var_04 = [];
  if(common_scripts\utility::func_57D7()) {
    self attach(param_01, param_00, 0);
    if(isDefined(param_02) && param_02 != "") {
      self attach(param_02, param_00, 0);
    }
  } else {
    var_04[0] = spawn("script_model", self gettagorigin(param_00));
    var_04[0].var_001D = self gettagangles(param_00);
    var_04[0] setModel(param_01);
    var_04[0] linkto(self, param_00);
    if(isDefined(param_02) && param_02 != "") {
      var_04[1] = spawn("script_model", self gettagorigin(param_00));
      var_04[1].var_001D = self gettagangles(param_00);
      var_04[1] setModel(param_02);
      var_04[1] linkto(self, param_00);
    }
  }

  if(isDefined(param_03)) {
    var_05 = self gettagorigin(param_00);
    var_06 = func_410A(var_05, param_03);
    if(isDefined(var_06)) {
      var_06 delete();
    }
  }

  self waittill("exploded");
  if(common_scripts\utility::func_57D7()) {
    self method_802E(param_01, param_00);
    self attach(param_01 + "_destroy", param_00, 0);
    if(isDefined(param_02) && param_02 != "") {
      self method_802E(param_02, param_00);
      self attach(param_02 + "_destroy", param_00, 0);
      return;
    }

    return;
  }

  var_04[0] setModel(param_01 + "_destroy");
  if(isDefined(param_02) && param_02 != "") {
    var_04[1] setModel(param_02 + "_destroy");
  }
}

func_410A(param_00, param_01) {
  var_02 = undefined;
  var_03 = undefined;
  var_04 = getEntArray(param_01, "targetname");
  foreach(var_06 in var_04) {
    var_07 = distancesquared(param_00, var_06.var_0116);
    if(!isDefined(var_02) || var_07 < var_02) {
      var_02 = var_07;
      var_03 = var_06;
    }
  }

  return var_03;
}

func_7381() {
  var_00 = undefined;
  if(!isDefined(self.var_01A2)) {
    return 0;
  }

  var_01 = getEntArray(self.var_01A2, "targetname");
  foreach(var_03 in var_01) {
    if(isDefined(var_03.var_8161) && var_03.var_8161 == "post") {
      var_00 = var_03;
      break;
    }
  }

  if(!isDefined(var_00)) {
    return 0;
  }

  var_05 = func_42AD(var_00);
  if(isDefined(var_05)) {
    return 1;
  }

  return 0;
}

func_42AD(param_00) {
  foreach(var_02 in level.var_744A) {
    if(!isalive(var_02)) {
      continue;
    }

    if(param_00 istouching(var_02)) {
      return var_02;
    }
  }

  return undefined;
}

func_560F() {
  return getDvar("1996") == "1";
}

func_2E05() {
  var_00 = getEntArray(self.var_01A2, "targetname");
  var_01 = [];
  var_01["pre"] = ::func_24E0;
  var_01["post"] = ::func_24DF;
  foreach(var_03 in var_00) {
    if(!isDefined(var_03.var_8161)) {
      continue;
    }

    self thread[[var_01[var_03.var_8161]]](var_03);
  }
}

func_24E0(param_00) {
  waittillframeend;
  if(common_scripts\utility::func_57D7() && param_00.var_0187 & 1) {
    param_00[[level.var_2FC3]]();
  }

  self waittill("exploded");
  if(common_scripts\utility::func_57D7() && param_00.var_0187 & 1) {
    param_00[[level.var_2587]]();
  }

  param_00 delete();
}

func_24DF(param_00) {
  param_00 notsolid();
  if(common_scripts\utility::func_57D7() && param_00.var_0187 & 1) {
    param_00[[level.var_2587]]();
  }

  self waittill("exploded");
  waittillframeend;
  if(common_scripts\utility::func_57D7()) {
    if(param_00.var_0187 & 1) {
      param_00[[level.var_2FC3]]();
    }

    if(func_560F()) {
      var_01 = func_42AD(param_00);
      if(isDefined(var_01)) {
        self thread[[level.var_3F05]](var_01);
      }
    } else {}
  }

  param_00 solid();
}

func_2AFD(param_00) {}

func_2E01(param_00) {
  var_01 = getEntArray("light_destructible", "targetname");
  if(common_scripts\utility::func_57D7()) {
    var_02 = getEntArray("light_destructible", "script_noteworthy");
    var_01 = common_scripts\utility::func_0F73(var_01, var_02);
  }

  if(!var_01.size) {
    return;
  }

  var_03 = param_00 * param_00;
  var_04 = undefined;
  foreach(var_06 in var_01) {
    var_07 = distancesquared(self.var_0116, var_06.var_0116);
    if(var_07 < var_03) {
      var_04 = var_06;
      var_03 = var_07;
    }
  }

  if(!isDefined(var_04)) {
    return;
  }

  self.var_1BAF = var_04;
}

func_1BA6(param_00) {
  if(!isDefined(self.var_1BAF)) {
    return;
  }

  self.var_1BAF method_81DF(0);
}

func_2B01(param_00, param_01, param_02, param_03) {
  var_04 = 16;
  var_05 = 360 / var_04;
  var_06 = [];
  for(var_07 = 0; var_07 < var_04; var_07++) {
    var_08 = var_05 * var_07;
    var_09 = cos(var_08) * param_01;
    var_0A = sin(var_08) * param_01;
    var_0B = param_00[0] + var_09;
    var_0C = param_00[1] + var_0A;
    var_0D = param_00[2];
    var_06[var_06.size] = (var_0B, var_0C, var_0D);
  }

  thread func_2AC5(var_06, 5, (1, 0, 0), param_00);
  var_06 = [];
  for(var_07 = 0; var_07 < var_04; var_07++) {
    var_08 = var_05 * var_07;
    var_09 = cos(var_08) * param_01;
    var_0A = sin(var_08) * param_01;
    var_0B = param_00[0];
    var_0C = param_00[1] + var_09;
    var_0D = param_00[2] + var_0A;
    var_06[var_06.size] = (var_0B, var_0C, var_0D);
  }

  thread func_2AC5(var_06, 5, (1, 0, 0), param_00);
  var_06 = [];
  for(var_07 = 0; var_07 < var_04; var_07++) {
    var_08 = var_05 * var_07;
    var_09 = cos(var_08) * param_01;
    var_0A = sin(var_08) * param_01;
    var_0B = param_00[0] + var_0A;
    var_0C = param_00[1];
    var_0D = param_00[2] + var_09;
    var_06[var_06.size] = (var_0B, var_0C, var_0D);
  }

  thread func_2AC5(var_06, 5, (1, 0, 0), param_00);
}

func_2AC5(param_00, param_01, param_02, param_03) {
  for(var_04 = 0; var_04 < param_00.size; var_04++) {
    var_05 = param_00[var_04];
    if(var_04 + 1 >= param_00.size) {
      var_06 = param_00[0];
    } else {
      var_06 = param_00[var_04 + 1];
    }

    thread func_2AF0(var_05, var_06, param_01, param_02);
    thread func_2AF0(param_03, var_05, param_01, param_02);
  }
}

func_2AF0(param_00, param_01, param_02, param_03) {
  if(!isDefined(param_03)) {
    param_03 = (1, 1, 1);
  }

  for(var_04 = 0; var_04 < param_02 * 20; var_04++) {
    wait 0.05;
  }
}

func_911E(param_00) {
  param_00 endon("death");
  level waittill("new_destructible_spotlight");
  param_00 delete();
}

func_9117(param_00, param_01, param_02, param_03, param_04) {
  level endon("new_destructible_spotlight");
  thread func_911E(param_04);
  var_05 = param_00["spotlight_brightness"];
  wait(randomfloatrange(2, 5));
  func_2E00(param_00, param_01, param_02, param_03);
  level.var_2E1A delete();
  param_04 delete();
}

func_2E1B(param_00, param_01, param_02, param_03) {
  if(!common_scripts\utility::func_57D7()) {
    return;
  }

  if(!isDefined(self.var_1BAF)) {
    return;
  }

  param_01 common_scripts\utility::func_83BE("startignoringspotLight");
  if(!isDefined(level.var_2E1A)) {
    level.var_2E1A = common_scripts\utility::func_8FFC();
    var_04 = common_scripts\utility::func_44F5(param_00["spotlight_fx"]);
    playFXOnTag(var_04, level.var_2E1A, "tag_origin");
  }

  level notify("new_destructible_spotlight");
  level.var_2E1A unlink();
  var_05 = common_scripts\utility::func_8FFC();
  var_05 linkto(self, param_00["spotlight_tag"], (0, 0, 0), (0, 0, 0));
  level.var_2E1A.var_0116 = self.var_1BAF.var_0116;
  level.var_2E1A.var_001D = self.var_1BAF.var_001D;
  level.var_2E1A thread func_9117(param_00, param_01, param_02, param_03, var_05);
  wait 0.05;
  if(isDefined(var_05)) {
    level.var_2E1A linkto(var_05);
  }
}

func_5641(param_00, param_01, param_02, param_03) {
  var_04 = undefined;
  if(isDefined(param_01["fx_valid_damagetype"])) {
    var_04 = param_01["fx_valid_damagetype"][param_03][param_02];
  }

  if(!isDefined(var_04)) {
    return 1;
  }

  return issubstr(var_04, param_00);
}

func_2E16(param_00, param_01, param_02, param_03) {
  if(isDefined(self.var_3928)) {
    return undefined;
  }

  if(!isDefined(param_00["sound"])) {
    return undefined;
  }

  if(!isDefined(param_03)) {
    param_03 = 0;
  }

  if(!isDefined(param_00["sound"][param_03])) {
    return undefined;
  }

  for(var_04 = 0; var_04 < param_00["sound"][param_03].size; var_04++) {
    var_05 = func_583B("soundCause", param_00, var_04, param_02, param_03);
    if(!var_05) {
      continue;
    }

    var_06 = param_00["sound"][param_03][var_04];
    var_07 = param_00["tagName"];
    param_01 thread func_71A7(var_06, var_07);
  }

  return param_03;
}

func_2DFC(param_00) {
  var_01 = level.var_0075[self.var_2E25].var_6E9F[0].size - 1;
  self endon("FX_State_Change_Kill" + param_00);
  for(;;) {
    var_02 = -1;
    if(isDefined(self.var_2E10[0].var_A265["currentState"])) {
      var_02 = self.var_2E10[0].var_A265["currentState"];
    }

    if(var_02 == var_01) {
      return 0;
    }

    wait 0.05;
  }
}

func_2DFE(param_00, param_01, param_02, param_03, param_04, param_05) {
  waittillframeend;
  if(!isDefined(param_05)) {
    param_05 = 0;
  }

  var_06 = undefined;
  var_07 = undefined;
  if(isDefined(param_02)) {
    if(param_04) {
      playFXOnTag(param_01, param_00, param_02);
      wait 0.05;
      if(param_05 == 1 || param_05 == 2) {
        func_2DFC(param_03);
        if(param_05 == 1) {
          stopFXOnTag(param_01, param_00, param_02);
          return;
        }

        killfxontag(param_01, param_00, param_02);
        return;
      }

      return;
    }

    var_08 = param_00 gettagorigin(param_02);
    var_09 = (0, 0, 100);
    if(param_05 == 1 || param_05 == 2) {
      var_07 = spawnfx(param_01, var_08, var_09);
      var_06 = triggerfx(var_07, 0.01);
    } else {
      var_06 = playFX(param_01, var_08, var_09);
    }

    wait 0.05;
    if(param_05 == 1 || param_05 == 2) {
      func_2DFC(param_03);
      if(param_05 == 1) {
        var_07 delete();
        return;
      }

      if(param_05 == 2) {
        function_014E(var_07, 1);
        wait 0.05;
        var_07 delete();
        return;
      }

      return;
    }

    return;
  }

  var_08 = param_02.var_0116;
  var_09 = (0, 0, 100);
  if(param_05 == 1 || param_05 == 2) {
    var_07 = spawnfx(param_01, var_08, var_09);
    var_06 = triggerfx(var_07, 0.01);
  } else {
    var_06 = playFX(param_01, var_08, var_09);
  }

  wait 0.05;
  if(param_05 == 1 || param_05 == 2) {
    func_2DFC(param_03);
    if(param_05 == 1) {
      var_07 delete();
      return;
    }

    if(param_05 == 2) {
      function_014E(var_07, 1);
      wait 0.05;
      var_07 delete();
      return;
    }

    return;
  }
}

func_2DFF() {
  if(!isDefined(level.var_0075[self.var_2E25].var_6E9F)) {
    return;
  }

  var_00 = func_4168();
  for(var_01 = 0; var_01 < level.var_0075[self.var_2E25].var_6E9F.size; var_01++) {
    for(var_02 = 0; var_02 < level.var_0075[self.var_2E25].var_6E9F[var_01].size; var_02++) {
      var_03 = level.var_0075[self.var_2E25].var_6E9F[var_01][var_02];
      if(isDefined(var_03.var_A265["fx_filename"])) {
        for(var_04 = 0; var_04 < var_03.var_A265["fx_filename"].size; var_04++) {
          var_05 = var_03.var_A265["fx_filename"][var_04];
          var_06 = var_03.var_A265["fx_tag"][var_04];
          var_07 = var_03.var_A265["spawn_immediate"][var_04];
          if(isDefined(var_05) && isDefined(var_07)) {
            for(var_08 = 0; var_08 < var_05.size; var_08++) {
              if(var_07[var_08] == 1) {
                var_09 = var_03.var_A265["state_change_kill"][var_04][var_08];
                var_0A = level.var_0075[self.var_2E25].var_6E9F[var_01][var_02].var_A265["fx"][var_04][var_08];
                var_0B = var_06[var_08];
                var_0C = var_05[var_08];
                var_0D = level.var_0075[self.var_2E25].var_6E9F[var_01][var_02].var_A265["fx_useTagAngles"][var_04][var_08];
                thread func_2DFE(var_00, var_0A, var_0B, var_01, var_0D, var_09);
              }
            }
          }
        }
      }
    }
  }
}

func_2E00(param_00, param_01, param_02, param_03, param_04) {
  if(!isDefined(param_00["fx"])) {
    return undefined;
  }

  if(!isDefined(param_04)) {
    param_04 = randomint(param_00["fx_filename"].size);
  }

  if(!isDefined(param_00["fx"][param_04])) {
    param_04 = randomint(param_00["fx_filename"].size);
  }

  var_05 = param_00["fx_filename"][param_04].size;
  var_06 = 0;
  while(var_06 < var_05) {
    if(!func_5641(param_02, param_00, var_06, param_04)) {
      continue;
    }

    if(param_00["spawn_immediate"][param_04][var_06] == 1) {
      continue;
    }

    var_07 = param_00["fx"][param_04][var_06];
    var_08 = param_00["state_change_kill"][param_04][var_06];
    if(isDefined(param_00["fx_tag"][param_04][var_06])) {
      var_09 = param_00["fx_tag"][param_04][var_06];
      self notify("FX_State_Change" + param_03);
      if(param_00["fx_useTagAngles"][param_04][var_06]) {
        thread func_2DFE(param_01, var_07, var_09, param_03, 1, var_08);
      } else {
        thread func_2DFE(param_01, var_07, var_09, param_03, 0, var_08);
      }

      continue;
    }

    thread func_2DFE(param_02, var_08, undefined, param_04, 0, var_09);
    var_07++;
  }

  return param_04;
}

func_2DE4(param_00, param_01, param_02, param_03) {
  if(isDefined(self.var_3928)) {
    return undefined;
  }

  if(!isDefined(param_00["animation"])) {
    return undefined;
  }

  if(isDefined(self.var_66E6)) {
    return undefined;
  }

  if(isDefined(param_00["randomly_flip"]) && !isDefined(self.var_8249)) {
    if(common_scripts\utility::func_24A6()) {
      self.var_001D = self.var_001D + (0, 180, 0);
    }
  }

  if(isDefined(param_00["spotlight_tag"])) {
    thread func_2E1B(param_00, param_01, param_02, param_03);
    wait 0.05;
  }

  var_04 = common_scripts\utility::func_7A33(param_00["animation"]);
  var_05 = var_04["anim"];
  var_06 = var_04["animTree"];
  var_07 = var_04["groupNum"];
  var_08 = var_04["mpAnim"];
  var_09 = var_04["maxStartDelay"];
  var_0A = var_04["animRateMin"];
  var_0B = var_04["animRateMax"];
  if(!isDefined(var_0A)) {
    var_0A = 1;
  }

  if(!isDefined(var_0B)) {
    var_0B = 1;
  }

  if(var_0A == var_0B) {
    var_0C = var_0A;
  } else {
    var_0C = randomfloatrange(var_0B, var_0C);
  }

  var_0D = var_04["vehicle_exclude_anim"];
  if(self.var_003B == "script_vehicle" && var_0D) {
    return undefined;
  }

  param_01 common_scripts\utility::func_83BE("useanimtree", var_06);
  var_0E = var_04["animType"];
  if(!isDefined(self.var_0ED4)) {
    self.var_0ED4 = [];
  }

  self.var_0ED4[self.var_0ED4.size] = var_05;
  if(isDefined(self.var_3949)) {
    func_23A2(param_01);
  }

  if(isDefined(var_09) && var_09 > 0) {
    wait(randomfloat(var_09));
  }

  if(!common_scripts\utility::func_57D7()) {
    if(isDefined(var_08)) {
      common_scripts\utility::func_83BE("scriptModelPlayAnim", var_08);
    }

    return var_07;
  }

  if(var_0E == "setanim") {
    param_01 common_scripts\utility::func_83BE("setanim", var_05, 1, 1, var_0C);
    return var_07;
  }

  if(var_0E == "setanimknob") {
    param_01 common_scripts\utility::func_83BE("setanimknob", var_05, 1, 0, var_0C);
    return var_07;
  }

  return undefined;
}

func_23A2(param_00) {
  if(isDefined(self.var_0ED4)) {
    foreach(var_02 in self.var_0ED4) {
      if(common_scripts\utility::func_57D7()) {
        param_00 common_scripts\utility::func_83BE("clearanim", var_02, 0);
        continue;
      }

      param_00 common_scripts\utility::func_83BE("scriptModelClearAnim");
    }
  }
}

func_51B4() {
  level.var_2DC8 = 0;
  level.var_2DC9 = 0.5;
  if(common_scripts\utility::func_57D7()) {
    level.var_607E = 20;
    return;
  }

  level.var_607E = 2;
}

func_0976() {
  level.var_2DC8++;
  wait(level.var_2DC9);
  level.var_2DC8--;
}

func_414B() {
  return level.var_2DC8;
}

func_420B() {
  return level.var_607E;
}

func_51B5() {
  level.var_2E24 = [];
}

func_091D(param_00, param_01, param_02) {
  var_03 = self getentitynumber();
  if(!isDefined(level.var_2E24[var_03])) {
    level.var_2E24[var_03] = spawnStruct();
    level.var_2E24[var_03].var_37D8 = var_03;
    level.var_2E24[var_03].var_2DE2 = param_00;
    level.var_2E24[var_03].var_9AB1 = 0;
    level.var_2E24[var_03].var_6635 = 9999999;
    level.var_2E24[var_03].var_3F6B = 0;
  }

  level.var_2E24[var_03].var_3F6B = level.var_2E24[var_03].var_3F6B + param_01.var_A265["fxcost"];
  level.var_2E24[var_03].var_9AB1 = level.var_2E24[var_03].var_9AB1 + param_02;
  if(param_01.var_A265["distance"] < level.var_2E24[var_03].var_6635) {
    level.var_2E24[var_03].var_6635 = param_01.var_A265["distance"];
  }

  thread func_49CE();
}

func_49CE() {
  level notify("handle_destructible_frame_queue");
  level endon("handle_destructible_frame_queue");
  wait 0.05;
  var_00 = level.var_2E24;
  level.var_2E24 = [];
  var_01 = func_8F1F(var_00);
  for(var_02 = 0; var_02 < var_01.size; var_02++) {
    if(func_414B() < func_420B()) {
      if(var_01[var_02].var_3F6B) {
        thread func_0976();
      }

      var_01[var_02].var_2DE2 notify("queue_processed", 1);
      continue;
    }

    var_01[var_02].var_2DE2 notify("queue_processed", 0);
  }
}

func_8F1F(param_00) {
  var_01 = [];
  foreach(var_03 in param_00) {
    var_01[var_01.size] = var_03;
  }

  for(var_05 = 1; var_05 < var_01.size; var_05++) {
    var_06 = var_01[var_05];
    for(var_07 = var_05 - 1; var_07 >= 0 && func_40D5(var_06, var_01[var_07]) == var_06; var_07--) {
      var_01[var_07 + 1] = var_01[var_07];
    }

    var_01[var_07 + 1] = var_06;
  }

  return var_01;
}

func_40D5(param_00, param_01) {
  if(param_00.var_9AB1 > param_01.var_9AB1) {
    return param_00;
  }

  return param_01;
}

func_4283(param_00, param_01) {
  var_02 = 0;
  if(!isDefined(level.var_0075[self.var_2E25].var_6E9F[param_00][param_01])) {
    return var_02;
  }

  var_03 = level.var_0075[self.var_2E25].var_6E9F[param_00][param_01].var_A265;
  if(isDefined(var_03["fx"])) {
    foreach(var_05 in var_03["fx_cost"]) {
      foreach(var_07 in var_05) {
        var_02 = var_02 + var_07;
      }
    }
  }

  return var_02;
}

func_52AF(param_00) {
  if(!common_scripts\utility::func_3C83("FLAG_DOT_init")) {
    common_scripts\utility::func_3C87("FLAG_DOT_init");
    common_scripts\utility::func_3C8F("FLAG_DOT_init");
  }

  param_00 = tolower(param_00);
  switch (param_00) {
    case "poison":
      if(!common_scripts\utility::func_3C83("FLAG_DOT_poison_init")) {
        common_scripts\utility::func_3C87("FLAG_DOT_poison_init");
        common_scripts\utility::func_3C8F("FLAG_DOT_poison_init");
      }
      break;

    default:
      break;
  }
}

func_27E2() {
  var_00 = spawnStruct();
  var_00.var_99C1 = [];
  return var_00;
}

func_27E3(param_00, param_01, param_02, param_03) {
  var_04 = spawnStruct();
  var_04.var_01B9 = "trigger_radius";
  var_04.var_0116 = param_00;
  var_04.var_0187 = param_01;
  var_04.var_014F = param_02;
  var_04.var_6220 = param_02;
  var_04.var_6098 = param_02;
  var_04.var_00BD = param_03;
  var_04.var_99C1 = [];
  return var_04;
}

func_866B(param_00) {
  self.var_0116 = param_00;
}

func_866C(param_00, param_01) {
  if(isDefined(self.var_003A) && self.var_003A != "trigger_radius") {}

  if(!isDefined(param_01)) {
    param_01 = param_00;
  }

  self.var_6220 = param_00;
  self.var_6098 = param_01;
}

func_8669(param_00, param_01) {
  if(isDefined(self.var_003A) && issubstr(self.var_003A, "trigger")) {}
}

func_866A(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07) {
  if(isDefined(param_00)) {} else {
    param_00 = 0;
  }

  param_06 = tolower(param_06);
  param_07 = tolower(param_07);
  var_08 = self.var_99C1.size;
  self.var_99C1[var_08] = spawnStruct();
  self.var_99C1[var_08].var_35FE = 0;
  self.var_99C1[var_08].var_2CAC = param_00;
  self.var_99C1[var_08].var_00D9 = param_01;
  self.var_99C1[var_08].var_3511 = param_02;
  self.var_99C1[var_08].var_61BD = param_03;
  self.var_99C1[var_08].var_607B = param_04;
  switch (param_05) {
    case 1:
    case 0:
      break;

    default:
      break;
  }

  self.var_99C1[var_08].var_0093 = param_05;
  self.var_99C1[var_08].var_9309 = 0;
  switch (param_06) {
    case "normal":
      break;

    case "poison":
      switch (param_07) {
        case "player":
          self.var_99C1[var_08].var_01B9 = param_06;
          self.var_99C1[var_08].var_0A32 = param_07;
          self.var_99C1[var_08].var_6B05 = ::func_6B04;
          self.var_99C1[var_08].var_6B33 = ::func_6B32;
          self.var_99C1[var_08].var_6AE6 = ::func_6AE5;
          break;

        default:
          break;
      }
      break;

    default:
      break;
  }
}

func_1D45(param_00, param_01) {
  param_01 = tolower(param_01);
  var_02 = self.var_99C1.size;
  self.var_99C1[var_02] = spawnStruct();
  self.var_99C1[var_02].var_3511 = param_00;
  self.var_99C1[var_02].var_2CAC = 0;
  self.var_99C1[var_02].var_6B05 = ::func_6B00;
  self.var_99C1[var_02].var_6B33 = ::func_6B30;
  self.var_99C1[var_02].var_6AE6 = ::func_6AE4;
  switch (param_01) {
    case "player":
      self.var_99C1[var_02].var_0A32 = param_01;
      break;

    default:
      break;
  }
}

func_1D46(param_00) {
  var_01 = self.var_99C1.size - 1;
  if(!isDefined(self.var_99C1[var_01].var_932C)) {
    self.var_99C1[var_01].var_932C = [];
  }

  var_02 = self.var_99C1[var_01].var_932C.size;
  self.var_99C1[var_01].var_932C = [];
  self.var_99C1[var_01].var_932C["vars"] = [];
  self.var_99C1[var_01].var_932C["vars"]["count"] = param_00;
}

func_1D44(param_00, param_01, param_02, param_03, param_04, param_05) {
  var_06 = self.var_99C1.size - 1;
  if(!isDefined(self.var_99C1[var_06].var_932C["actions"])) {
    self.var_99C1[var_06].var_932C["actions"] = [];
  }

  var_07 = self.var_99C1[var_06].var_932C["actions"].size;
  self.var_99C1[var_06].var_932C["actions"][var_07] = [];
  self.var_99C1[var_06].var_932C["actions"][var_07]["vars"] = [param_00, param_01, param_02, param_03, param_04, param_05];
  self.var_99C1[var_06].var_932C["actions"][var_07]["func"] = ::func_310C;
}

func_1D47(param_00) {
  var_01 = self.var_99C1.size - 1;
  if(!isDefined(self.var_99C1[var_01].var_932C["actions"])) {
    self.var_99C1[var_01].var_932C["actions"] = [];
  }

  var_02 = self.var_99C1[var_01].var_932C["actions"].size;
  self.var_99C1[var_01].var_932C["actions"][var_02] = [];
  self.var_99C1[var_01].var_932C["actions"][var_02]["vars"] = [param_00];
  self.var_99C1[var_01].var_932C["actions"][var_02]["func"] = ::func_310D;
}

func_6B00(param_00, param_01) {
  var_02 = param_01 getentitynumber();
  param_01 endon("death");
  param_01 endon("LISTEN_kill_tick_" + param_00 + "_" + var_02);
  self endon("disconnect");
  self endon("game_ended");
  self endon("death");
  self endon("LISTEN_exit_dot_" + var_02);
  var_02 = undefined;
  var_03 = param_01.var_99C1[param_00].var_932C;
  if(!isDefined(var_03) || !isDefined(var_03["vars"]) || !isDefined(var_03["vars"]["count"]) || !isDefined(var_03["actions"])) {
    return;
  }

  var_04 = var_03["vars"]["count"];
  var_05 = var_03["actions"];
  var_03 = undefined;
  for(var_06 = 1; var_06 <= var_04 || var_04 == 0; var_06--) {
    foreach(var_08 in var_05) {
      var_09 = var_08["vars"];
      var_0A = var_08["func"];
      self[[var_0A]](param_00, param_01, var_09);
    }
  }
}

func_6B30(param_00, param_01) {
  var_02 = param_01 getentitynumber();
  var_03 = self getentitynumber();
  param_01 notify("LISTEN_kill_tick_" + param_00 + "_" + var_02 + "_" + var_03);
}

func_6AE4(param_00, param_01) {}

func_310C(param_00, param_01, param_02) {
  var_03 = param_02[0];
  var_04 = param_02[1];
  var_05 = param_02[2];
  var_06 = param_02[3];
  var_07 = param_02[4];
  var_08 = param_02[5];
  self thread[[level.var_1E78]](param_01, param_01, var_04, var_06, var_07, var_08, param_01.var_0116, (0, 0, 0) - param_01.var_0116, "none", 0);
}

func_310D(param_00, param_01, param_02) {
  var_03 = param_01 getentitynumber();
  var_04 = self getentitynumber();
  param_01 endon("death");
  param_01 endon("LISTEN_kill_tick_" + param_00 + "_" + var_03);
  param_01 notify("LISTEN_kill_tick_" + param_00 + "_" + var_03 + "_" + var_04);
  self endon("disconnect");
  self endon("game_ended");
  self endon("death");
  self endon("LISTEN_exit_dot_" + var_03);
  var_03 = undefined;
  var_04 = undefined;
  wait(param_02[0]);
}

func_92C7(param_00) {
  var_01 = [];
  foreach(var_03 in param_00) {
    var_04 = undefined;
    switch (var_03.var_01B9) {
      case "trigger_radius":
        var_04 = spawn("trigger_radius", var_03.var_0116, var_03.var_0187, var_03.var_014F, var_03.var_00BD);
        var_04.var_6220 = var_03.var_6220;
        var_04.var_6098 = var_03.var_6098;
        var_04.var_99C1 = var_03.var_99C1;
        var_01[var_01.size] = var_04;
        break;

      default:
        break;
    }

    if(isDefined(var_03.var_6E74)) {
      var_04 linkto(var_03.var_6E74);
      var_03.var_6E74.var_32B1 = var_04;
    }

    var_05 = var_04.var_99C1;
    foreach(var_07 in var_05) {
      var_07.var_9309 = gettime();
    }

    foreach(var_07 in var_05) {
      if(!var_07.var_2CAC) {
        var_07.var_35FE = 1;
      }
    }

    foreach(var_07 in var_05) {
      if(issubstr(var_07.var_0A32, "player")) {
        var_04.var_6B6B = 1;
        break;
      }
    }
  }

  foreach(var_04 in var_01) {
    var_04.var_32B2 = [];
    foreach(var_10 in var_01) {
      if(var_04 == var_10) {
        continue;
      }

      var_04.var_32B2[var_04.var_32B2.size] = var_10;
    }
  }

  foreach(var_04 in var_01) {
    if(var_04.var_6B6B) {
      var_04 thread func_92C8();
    }
  }

  foreach(var_04 in var_01) {
    var_04 thread func_6381();
  }
}

func_92C8() {
  thread func_9DC3(::func_6B01, ::func_6B31);
}

func_6381() {
  var_00 = gettime();
  while(isDefined(self)) {
    foreach(var_04, var_02 in self.var_99C1) {
      if(isDefined(var_02) && gettime() - var_00 >= var_02.var_3511 * 1000) {
        var_03 = self getentitynumber();
        self notify("LISTEN_kill_tick_" + var_04 + "_" + var_03);
        self.var_99C1[var_04] = undefined;
      }
    }

    if(!self.var_99C1.size) {
      break;
    }

    wait 0.05;
  }

  if(isDefined(self)) {
    foreach(var_02 in self.var_99C1) {
      self[[var_02.var_6AE6]]();
    }

    self notify("death");
    self delete();
  }
}

func_6B01(param_00) {
  var_01 = param_00 getentitynumber();
  self notify("LISTEN_enter_dot_" + var_01);
  foreach(var_04, var_03 in param_00.var_99C1) {
    if(!var_03.var_35FE) {
      thread func_3144(var_04, param_00, var_03.var_2CAC, var_03.var_6B05);
    }
  }

  foreach(var_04, var_03 in param_00.var_99C1) {
    if(var_03.var_35FE && var_03.var_0A32 == "player") {
      self thread[[var_03.var_6B05]](var_04, param_00);
    }
  }
}

func_6B31(param_00) {
  var_01 = param_00 getentitynumber();
  self notify("LISTEN_exit_dot_" + var_01);
  foreach(var_04, var_03 in param_00.var_99C1) {
    if(var_03.var_35FE && var_03.var_0A32 == "player") {
      self thread[[var_03.var_6B33]](var_04, param_00);
    }
  }
}

func_3144(param_00, param_01, param_02, param_03) {
  var_04 = param_01 getentitynumber();
  var_05 = self getentitynumber();
  param_01 endon("LISTEN_kill_tick_" + param_00 + "_" + var_04 + "_" + var_05);
  self endon("disconnect");
  self endon("game_ended");
  self endon("death");
  self notify("LISTEN_exit_dot_" + var_04);
  var_04 = undefined;
  var_05 = undefined;
  wait(param_02);
  self thread[[param_03]](param_00, param_01);
}

func_6B04(param_00, param_01) {
  var_02 = param_01 getentitynumber();
  var_03 = self getentitynumber();
  param_01 endon("death");
  param_01 endon("LISTEN_kill_tick_" + param_00 + "_" + var_02);
  param_01 endon("LISTEN_kill_tick_" + param_00 + "_" + var_02 + "_" + var_03);
  self endon("disconnect");
  self endon("game_ended");
  self endon("death");
  self endon("LISTEN_exit_dot_" + var_02);
  if(!isDefined(self.var_6B02)) {
    self.var_6B02 = [];
  }

  if(!isDefined(self.var_6B02[param_00])) {
    self.var_6B02[param_00] = [];
  }

  self.var_6B02[param_00][var_02] = 0;
  var_04 = common_scripts\utility::func_98E7(common_scripts\utility::func_57D7(), 1.5, 1);
  while(isDefined(param_01) && isDefined(param_01.var_99C1[param_00])) {
    self.var_6B02[param_00][var_02]++;
    switch (self.var_6B02[param_00][var_02]) {
      case 1:
        self viewkick(1, self.var_0116);
        break;

      case 3:
        self shellshock("mp_radiation_low", 4);
        func_3149(param_01, var_04 * 2);
        break;

      case 4:
        self shellshock("mp_radiation_med", 5);
        thread func_3148(param_00, param_01);
        func_3149(param_01, var_04 * 2);
        break;

      case 6:
        self shellshock("mp_radiation_high", 5);
        func_3149(param_01, var_04 * 2);
        break;

      case 8:
        self shellshock("mp_radiation_high", 5);
        func_3149(param_01, var_04 * 500);
        break;
    }

    wait(param_01.var_99C1[param_00].var_00D9);
  }
}

func_6B32(param_00, param_01) {
  var_02 = param_01 getentitynumber();
  var_03 = self getentitynumber();
  var_04 = self.var_6B03;
  if(isDefined(var_04)) {
    foreach(var_07, var_06 in var_04) {
      if(isDefined(var_04[var_07]) && isDefined(var_04[var_07][var_02])) {
        var_04[var_07][var_02] thread func_3146(0.1, 0);
      }
    }
  }

  param_01 notify("LISTEN_kill_tick_" + param_00 + "_" + var_02 + "_" + var_03);
}

func_6AE5() {
  var_00 = self getentitynumber();
  foreach(var_02 in level.var_744A) {
    var_03 = var_02.var_6B03;
    if(isDefined(var_03)) {
      foreach(var_06, var_05 in var_03) {
        if(isDefined(var_03[var_06]) && isDefined(var_03[var_06][var_00])) {
          var_03[var_06][var_00] thread func_3147();
        }
      }
    }
  }
}

func_3149(param_00, param_01) {
  if(common_scripts\utility::func_57D7()) {
    return;
  }

  self thread[[level.var_1E78]](param_00, param_00, param_01, 0, "MOD_SUICIDE", "claymore_mp", param_00.var_0116, (0, 0, 0) - param_00.var_0116, "none", 0);
}

func_3148(param_00, param_01) {
  var_02 = param_01 getentitynumber();
  var_03 = self getentitynumber();
  param_01 endon("death");
  param_01 endon("LISTEN_kill_tick_" + param_00 + "_" + var_02);
  param_01 endon("LISTEN_kill_tick_" + param_00 + "_" + var_02 + "_" + var_03);
  self endon("disconnect");
  self endon("game_ended");
  self endon("death");
  self endon("LISTEN_exit_dot_" + var_02);
  if(!isDefined(self.var_6B03)) {
    self.var_6B03 = [];
  }

  if(!isDefined(self.var_6B03[param_00])) {
    self.var_6B03[param_00] = [];
  }

  if(!isDefined(self.var_6B03[param_00][var_02])) {
    var_04 = newclienthudelem(self);
    var_04.var_01D3 = 0;
    var_04.var_01D7 = 0;
    var_04.var_0010 = "left";
    var_04.var_0011 = "top";
    var_04.var_00C6 = "fullscreen";
    var_04.var_01CA = "fullscreen";
    var_04.var_0018 = 0;
    var_04 setshader("black", 640, 480);
    self.var_6B03[param_00][var_02] = var_04;
  }

  var_04 = self.var_6B03[param_00][var_02];
  var_05 = 1;
  var_06 = 2;
  var_07 = 0.25;
  var_08 = 1;
  var_09 = 5;
  var_0A = 100;
  var_0B = 0;
  for(;;) {
    while(self.var_6B02[param_00][var_02] > 1) {
      var_0C = var_0A - var_09;
      var_0B = self.var_6B02[param_00][var_02] - var_09 / var_0C;
      if(var_0B < 0) {
        var_0B = 0;
      } else if(var_0B > 1) {
        var_0B = 1;
      }

      var_0D = var_06 - var_05;
      var_0E = var_05 + var_0D * 1 - var_0B;
      var_0F = var_08 - var_07;
      var_10 = var_07 + var_0F * var_0B;
      var_11 = var_0B * 0.5;
      if(var_0B == 1) {
        break;
      }

      var_12 = var_0E / 2;
      var_04 func_3145(var_12, var_10);
      var_04 func_3146(var_12, var_11);
      wait(var_0B * 0.5);
    }

    if(var_0B == 1) {
      break;
    }

    if(var_04.var_0018 != 0) {
      var_04 func_3146(1, 0);
    }

    wait 0.05;
  }

  var_04 func_3145(2, 0);
}

func_3145(param_00, param_01) {
  self fadeovertime(param_00);
  self.var_0018 = param_01;
  param_01 = undefined;
  wait(param_00);
}

func_3146(param_00, param_01) {
  self fadeovertime(param_00);
  self.var_0018 = param_01;
  param_01 = undefined;
  wait(param_00);
}

func_3147(param_00, param_01) {
  self fadeovertime(param_00);
  self.var_0018 = param_01;
  param_01 = undefined;
  wait(param_00);
  self destroy();
}

func_9DC3(param_00, param_01) {
  level endon("game_ended");
  self endon("death");
  self.var_37D8 = self getentitynumber();
  for(;;) {
    self waittill("trigger", var_02);
    if(!isPlayer(var_02) && !isDefined(var_02.var_3BAA)) {
      continue;
    }

    if(!isalive(var_02)) {
      continue;
    }

    if(!isDefined(var_02.var_9AC5[self.var_37D8])) {
      var_02 thread func_7477(self, param_00, param_01);
    }
  }
}

func_7477(param_00, param_01, param_02) {
  param_00 endon("death");
  if(!isPlayer(self)) {
    self endon("death");
  }

  if(!common_scripts\utility::func_57D7()) {
    var_03 = self.var_48CA;
  } else {
    var_03 = "player" + gettime();
  }

  param_00.var_9AC3[var_03] = self;
  if(isDefined(param_00.var_64DD)) {
    self.var_64DE++;
  }

  param_00 notify("trigger_enter", self);
  self notify("trigger_enter", param_00);
  var_04 = 1;
  foreach(var_06 in param_00.var_32B2) {
    foreach(var_08 in self.var_9AC5) {
      if(var_06 == var_08) {
        var_04 = 0;
      }
    }
  }

  if(var_04 && isDefined(param_01)) {
    self thread[[param_01]](param_00);
  }

  self.var_9AC5[param_00.var_37D8] = param_00;
  while(isalive(self) && common_scripts\utility::func_57D7() || !level.var_3F9D) {
    var_0B = 1;
    if(self istouching(param_00)) {
      wait 0.05;
      continue;
    }

    if(!param_00.var_32B2.size) {
      var_0B = 0;
    }

    foreach(var_06 in param_00.var_32B2) {
      if(self istouching(var_06)) {
        wait 0.05;
        break;
      } else {
        var_0B = 0;
      }
    }

    if(!var_0D) {
      break;
    }
  }

  if(isDefined(self)) {
    self.var_9AC5[param_00.var_37D8] = undefined;
    if(isDefined(param_00.var_64DD)) {
      self.var_64DE--;
    }

    self notify("trigger_leave", param_00);
    if(var_04 && isDefined(param_02)) {
      self thread[[param_02]](param_00);
    }
  }

  if(!common_scripts\utility::func_57D7() && level.var_3F9D) {
    return;
  }

  param_00.var_9AC3[var_03] = undefined;
  param_00 notify("trigger_leave", self);
  if(!func_0F13(param_00)) {
    param_00 notify("trigger_empty");
  }
}

func_0F13(param_00) {
  return param_00.var_9AC3.size;
}

func_42C9(param_00) {
  return level.var_05FD[param_00];
}

func_42CA(param_00) {
  return level.var_05FE[param_00];
}

func_2E23() {
  if(!isDefined(level.var_721C)) {
    return;
  }

  if(!isDefined(self.var_815E)) {
    self.var_815E = 20000;
  }

  while(isDefined(self)) {
    if(isDefined(self.var_2E10)) {
      var_00 = 0;
      for(var_01 = 1; var_01 < self.var_2E10.size; var_01++) {
        if(self.var_2E10[var_01].var_A265["currentState"] == 1) {
          var_00++;
        }
      }

      if(var_00 == self.var_2E10.size - 1) {
        break;
      }
    }

    var_02 = distancesquared(level.var_721C.var_0116, self.var_0116);
    if(var_02 > self.var_815E * self.var_815E) {
      self setCanDamage(0);
      continue;
    }

    self setCanDamage(1);
    wait 0.05;
  }
}