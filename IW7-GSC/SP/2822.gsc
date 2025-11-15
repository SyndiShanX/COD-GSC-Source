/************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: SP\2822.gsc
************************/

init() {
  if(!isDefined(level.var_EC8D)) {
    level.var_EC8D = [];
  }

  if(!isDefined(level.var_EC88)) {
    level.var_EC88 = [];
  }

  if(!isDefined(level.var_EC8A)) {
    level.var_EC8A = [];
  }

  if(!isDefined(level.var_EC8B)) {
    level.var_EC8B = [];
  }

  if(!isDefined(level.var_EC86)) {
    level.var_EC86 = [];
  }

  if(!isDefined(level.scr_sound)) {
    level.scr_sound = [];
  }

  if(!isDefined(level.var_EC91)) {
    level.var_EC91 = [];
  }

  if(!isDefined(level.var_EC95)) {
    level.var_EC95 = [];
  }

  if(!isDefined(level.var_EC85)) {
    level.var_EC85[0][0] = 0;
  }

  if(!isDefined(level.var_EC91)) {
    level.var_EC91 = [];
  }

  if(!isDefined(level.var_EC8E)) {
    level.var_EC8E = [];
  }

  if(!isDefined(level.var_EC89)) {
    level.var_EC89 = [];
  }

  if(!isDefined(level._notetrackfx)) {
    level._notetrackfx = [];
  }

  scripts\engine\utility::create_lock("moreThanThreeHack", 3);
  scripts\engine\utility::create_lock("trace_part_for_efx", 12);
  thread func_D807();
  scripts\anim\notetracks::registernotetracks_init();
  scripts\anim\pain::func_98AC();
  scripts\anim\death::func_95A2();
  func_9525();
}

func_9525() {
  level.var_1FDC = [];
  level.var_1FD4 = [];
  var_00 = getarraykeys(level.var_EC8D);
  for(var_01 = 0; var_01 < var_00.size; var_01++) {
    func_969F(var_00[var_01]);
  }

  var_00 = getarraykeys(level.var_EC86);
  for(var_01 = 0; var_01 < var_00.size; var_01++) {
    func_9526(var_00[var_01]);
  }
}

func_9526(param_00) {
  var_01 = getarraykeys(level.var_EC86[param_00]);
  for(var_02 = 0; var_02 < var_01.size; var_02++) {
    var_03 = var_01[var_02];
    var_04 = level.var_EC86[param_00][var_03];
    level.var_1FD4[param_00][var_03]["#" + var_03]["soundalias"] = var_04;
    level.var_1FD4[param_00][var_03]["#" + var_03]["created_by_animSound"] = 1;
  }
}

func_969F(param_00) {
  foreach(var_0A, var_02 in level.var_EC8D[param_00]) {
    foreach(var_09, var_04 in var_02) {
      foreach(var_06 in var_04) {
        var_07 = var_06["sound"];
        if(!isDefined(var_07)) {
          continue;
        }

        level.var_1FD4[param_00][var_0A][var_09]["soundalias"] = var_07;
        if(isDefined(var_06["created_by_animSound"])) {
          level.var_1FD4[param_00][var_0A][var_09]["created_by_animSound"] = 1;
        }
      }
    }
  }
}

func_D807() {
  waittillframeend;
  if(!isDefined(level.var_EC8C)) {
    return;
  }

  var_00 = getarraykeys(level.var_EC8C);
  for(var_01 = 0; var_01 < var_00.size; var_01++) {
    if(isarray(level.var_EC8C[var_00[var_01]])) {
      for(var_02 = 0; var_02 < level.var_EC8C[var_00[var_01]].size; var_02++) {
        precachemodel(level.var_EC8C[var_00[var_01]][var_02]);
      }

      continue;
    }

    precachemodel(level.var_EC8C[var_00[var_01]]);
  }
}

func_6370(param_00, param_01) {
  self waittill(param_00);
  foreach(var_03 in param_01) {
    var_04 = var_03["guy"];
    if(!isDefined(var_04)) {
      continue;
    }

    var_04.var_117C--;
    var_04.var_1300 = gettime();
  }
}

func_1EC1(param_00, param_01, param_02) {
  var_03 = func_781C(param_02);
  var_04 = var_03["origin"];
  var_05 = var_03["angles"];
  scripts\engine\utility::array_levelthread(param_00, ::func_1EC2, param_01, var_04, var_05);
}

func_1ECA(param_00, param_01, param_02) {
  var_03 = func_781C(param_02);
  var_04 = var_03["origin"];
  var_05 = var_03["angles"];
  thread func_1EC2(param_00, param_01, var_04, var_05, "generic");
}

func_1EC7(param_00, param_01, param_02) {
  var_03 = [];
  var_03[0] = param_00;
  func_1F2C(var_03, param_01, param_02, 0, "generic");
}

func_1ECB(param_00, param_01, param_02) {
  var_03 = param_00.allowpain;
  param_00 scripts\sp\utility::func_5564();
  func_1EC8(param_00, "gravity", param_01, param_02);
  if(var_03) {
    param_00 scripts\sp\utility::func_6224();
  }
}

func_1ED1(param_00, param_01, param_02) {
  var_03 = [];
  var_03[0] = param_00;
  func_1F2C(var_03, param_01, param_02, 0.25, "generic");
}

func_1ECE(param_00, param_01, param_02) {
  var_03 = [];
  var_03[0] = param_00;
  func_1F0A(var_03, param_01, param_02, "generic");
}

func_1ED0(param_00, param_01, param_02, param_03) {
  var_04 = [];
  var_04[0] = param_00;
  if(scripts\sp\interaction::func_9C26(self) || scripts\sp\interaction::func_9CD7(self)) {
    foreach(param_00 in var_04) {
      if(isDefined(self.var_EE92)) {
        param_00.asm.var_4C86.interaction = self.var_EE92;
        continue;
      }

      param_00.asm.var_4C86.interaction = self.script_noteworthy;
    }

    var_07 = scripts\sp\interaction::func_7A45(param_00.asm.var_4C86.interaction);
    if(!isDefined(var_07)) {
      var_07 = scripts\sp\interaction::func_7CA7(param_00.asm.var_4C86.interaction);
    }

    param_00.asm.var_4C86.var_22F1 = undefined;
    if(isDefined(var_07)) {
      param_00.asm.var_4C86.var_22F1 = param_00 scripts\sp\interaction::func_7837(var_07);
    }

    if(isDefined(param_00.asm.var_4C86.var_22F1)) {
      func_1F1B(var_04, param_01, param_02, "generic", ::func_DD0F, ::func_DD10, param_03);
      return;
    }

    func_1F1B(var_04, param_01, param_02, "generic", ::func_DD11, ::func_DD15, param_03);
    return;
  }

  func_1F1B(var_04, param_01, param_02, "generic", ::func_DD11, ::func_DD15, param_03);
}

func_1F10(param_00, param_01, param_02) {
  func_1F1B(param_00, param_01, param_02, undefined, ::func_DD12, ::func_DD15);
}

func_1F11(param_00, param_01, param_02) {
  func_1F1B(param_00, param_01, param_02, undefined, ::func_DD13, ::func_DD15);
}

func_1ECC(param_00, param_01, param_02, param_03) {
  var_04 = [];
  var_04["guy"] = param_00;
  var_04["entity"] = self;
  var_04["tag"] = param_03;
  var_05[0] = var_04;
  func_1EE8(var_05, param_01, param_02, "generic");
}

func_1EAB(param_00, param_01, param_02, param_03) {
  var_04 = func_781C(param_03);
  var_05 = var_04["origin"];
  var_06 = var_04["angles"];
  var_07 = undefined;
  foreach(var_09 in param_00) {
    var_07 = var_09;
    thread func_1EAE(var_09, param_01, param_02, var_05, var_06, var_09.var_1FBB, 0);
  }

  var_07 func_1368A(param_02);
  self notify(param_02);
}

func_1EAC(param_00, param_01, param_02, param_03) {
  var_04 = func_781C(param_03);
  var_05 = var_04["origin"];
  var_06 = var_04["angles"];
  foreach(var_08 in param_00) {
    thread func_1EAE(var_08, param_01, param_02, var_05, var_06, var_08.var_1FBB, 1);
  }

  param_00[0] func_1368A(param_02);
  self notify(param_02);
}

func_1368A(param_00) {
  self endon("finished_custom_animmode" + param_00);
  self waittill("death");
}

func_1EC8(param_00, param_01, param_02, param_03, param_04, param_05) {
  var_06 = func_781C(param_03);
  var_07 = var_06["origin"];
  var_08 = var_06["angles"];
  thread func_1EAE(param_00, param_01, param_02, var_07, var_08, "generic", 0, param_04, param_05);
  param_00 func_1368A(param_02);
  self notify(param_02);
}

func_1EC9(param_00, param_01, param_02, param_03, param_04, param_05) {
  var_06 = func_781C(param_03);
  var_07 = var_06["origin"];
  var_08 = var_06["angles"];
  thread func_1EAE(param_00, param_01, param_02, var_07, var_08, "generic", 1, param_04, param_05);
  param_00 func_1368A(param_02);
  self notify(param_02);
}

func_1EAF(param_00, param_01, param_02, param_03) {
  var_04 = [];
  var_04[0] = param_00;
  func_1EAB(var_04, param_01, param_02, param_03);
}

func_1EAD(param_00, param_01, param_02, param_03) {
  var_04 = [];
  var_04[0] = param_00;
  func_1EAC(var_04, param_01, param_02, param_03);
}

func_1EC3(param_00, param_01, param_02) {
  var_03 = [];
  var_03[0] = param_00;
  func_1EC1(var_03, param_01, param_02);
}

func_1EE0(param_00, param_01, param_02) {
  var_03 = [];
  var_03[0] = param_00;
  func_1EC1(var_03, param_01, param_02);
  func_1F2A(var_03, param_01, 1);
  var_04 = param_00 scripts\sp\utility::func_7DC1(param_01);
  var_05 = getmovedelta(var_04);
  var_06 = getangledelta3d(var_04);
  var_07 = rotatevector(var_05, param_00.angles);
  var_08 = param_00.origin + var_07;
  var_09 = combineangles(param_00.angles, var_06);
  if(isai(param_00)) {
    param_00 _meth_80F1(var_08, var_09, 9999);
    return;
  }

  if(isDefined(self.var_380)) {
    param_00 vehicle_teleport(var_08, var_09);
    param_00 dontinterpolate();
    return;
  }

  param_00.origin = var_08;
  param_00.angles = var_09;
  param_00 dontinterpolate();
}

func_23AE(param_00, param_01) {
  if(!isDefined(param_01)) {
    param_01 = self.var_1FBB;
  }

  var_02 = 0;
  if(isDefined(level.var_EC85[param_01])) {
    var_02 = 1;
    if(isDefined(level.var_EC85[param_01][param_00])) {
      return;
    }
  }

  var_03 = 0;
  if(isDefined(level.var_EC88[param_01])) {
    var_03 = 1;
    if(isDefined(level.var_EC88[param_01][param_00])) {
      return;
    }
  }

  var_04 = 0;
  if(isDefined(level.scr_sound[param_01])) {
    var_04 = 1;
    if(isDefined(level.scr_sound[param_01][param_00])) {
      return;
    }
  }

  if(var_02 || var_04 || var_03) {
    if(var_02) {
      var_05 = getarraykeys(level.var_EC85[param_01]);
      foreach(var_07 in var_05) {}
    }

    if(var_04) {
      var_05 = getarraykeys(level.scr_sound[param_01]);
      foreach(var_07 in var_05) {}
    }

    if(var_03) {
      var_05 = getarraykeys(level.var_EC88[param_01]);
      foreach(var_07 in var_05) {}
    }

    return;
  }

  var_0D = getarraykeys(level.var_EC85);
  var_0D = scripts\engine\utility::array_combine(var_0D, getarraykeys(level.scr_sound));
  foreach(var_0F in var_0D) {}
}

func_1EC2(param_00, param_01, param_02, param_03, param_04) {
  param_00.var_6DCC = gettime();
  var_05 = undefined;
  if(isDefined(param_04)) {
    var_05 = param_04;
  } else {
    var_05 = param_00.var_1FBB;
  }

  var_06 = 0;
  if(isarray(level.var_EC85[var_05][param_01])) {
    var_07 = level.var_EC85[var_05][param_01][0];
    var_06 = 1;
  } else {
    var_07 = level.var_EC85[var_06][param_02];
  }

  param_00 func_F5B0(param_01, param_02, param_03, var_05, var_06);
  if(isai(param_00)) {
    param_00.var_1286 = var_07;
    param_00.var_1180 = var_05;
    param_00 lib_0A1E::func_2307(::scripts\anim\first_frame::main);
    return;
  }

  param_00 givescorefortrophyblocks();
  param_00 setanimknob(var_07, 1, 0, 0);
}

func_1EAE(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08) {
  if(isai(param_00) && param_00 scripts\sp\utility::func_58DA()) {
    return;
  }

  var_09 = undefined;
  if(isDefined(param_05)) {
    var_09 = param_05;
  } else {
    var_09 = param_00.var_1FBB;
  }

  if(!isDefined(param_08) || !param_08) {
    param_00 func_F5B0(param_02, param_03, param_04, param_05, param_06);
  }

  param_00.var_117F = param_01;
  param_00.var_11BA = param_02;
  param_00.var_141C = self;
  param_00.var_117E = param_02;
  param_00.var_1180 = var_09;
  param_00.var_11BB = param_06;
  param_00.var_11BC = param_07;
  if(getdvarint("ai_iw7", 0) == 1) {
    param_00 lib_0A1E::func_2307(::scripts\anim\animmode::main, ::lib_0A1E::func_2385);
    return;
  }

  param_00 animcustom(::scripts\anim\animmode::main);
}

func_1EE7(param_00, param_01, param_02, param_03, param_04, param_05) {
  var_06 = [];
  foreach(var_08 in param_00) {
    var_09 = [];
    var_09["guy"] = var_08;
    var_09["entity"] = self;
    var_09["tag"] = param_03;
    var_09["origin_offset"] = param_04;
    var_06[var_06.size] = var_09;
  }

  func_1EE8(var_06, param_01, param_02, param_05);
}

func_1EE9(param_00, param_01, param_02, param_03) {
  var_04 = [];
  var_04[0] = param_00;
  func_1EE8(var_04, param_01, param_02, param_03);
}

func_1EE8(param_00, param_01, param_02, param_03) {
  foreach(var_05 in param_00) {
    var_06 = var_05["guy"];
    if(!isDefined(var_06)) {
      continue;
    }

    if(!isDefined(var_06.var_117C)) {
      var_06.var_117C = 0;
    }

    if(scripts\sp\utility::func_93A6() && isDefined(var_06.team) && var_06.team == "axis" && isDefined(var_06.unittype) && var_06.unittype == "soldier") {
      var_06.var_C05C = 1;
    }

    var_06 endon("death");
    var_06.var_117C++;
  }

  var_08 = param_00[0]["guy"];
  if(!isDefined(param_02)) {
    param_02 = "stop_loop";
  }

  thread func_6370(param_02, param_00);
  self endon(param_02);
  var_09 = "looping anim";
  var_0A = undefined;
  if(isDefined(param_03)) {
    var_0A = param_03;
  } else {
    var_0A = var_08.var_1FBB;
  }

  var_0B = 0;
  var_0C = 0;
  for(;;) {
    for(var_0B = func_1F60(var_0A, param_01); var_0B == var_0C && var_0B != 0; var_0B = func_1F60(var_0A, param_01)) {}

    var_0C = var_0B;
    var_0D = undefined;
    var_0E = 999999;
    var_0F = undefined;
    var_06 = undefined;
    foreach(var_23, var_05 in param_00) {
      var_11 = var_05["entity"];
      var_06 = var_05["guy"];
      var_12 = var_11 func_781C(var_05["tag"]);
      var_13 = var_12["origin"];
      var_14 = var_12["angles"];
      if(isDefined(var_05["origin_offset"])) {
        var_15 = var_05["origin_offset"];
        var_16 = anglesToForward(var_14);
        var_17 = anglestoright(var_14);
        var_18 = anglestoup(var_14);
        var_13 = var_13 + var_16 * var_15[0];
        var_13 = var_13 + var_17 * var_15[1];
        var_13 = var_13 + var_18 * var_15[2];
      }

      if(isDefined(var_06.var_E014)) {
        var_06.var_E014 = undefined;
        param_00[var_23] = undefined;
        continue;
      }

      var_19 = 0;
      var_1A = 0;
      var_1B = 0;
      var_1C = 0;
      var_1D = undefined;
      var_1E = undefined;
      var_1F = undefined;
      if(isDefined(param_03)) {
        var_1F = param_03;
      } else {
        var_1F = var_06.var_1FBB;
      }

      if(isDefined(level.var_EC88[var_1F]) && isDefined(level.var_EC88[var_1F][param_01]) && isDefined(level.var_EC88[var_1F][param_01][var_0B])) {
        var_19 = 1;
        var_1D = level.var_EC88[var_1F][param_01][var_0B];
      }

      if(isDefined(level.scr_sound[var_1F]) && isDefined(level.scr_sound[var_1F][param_01]) && isDefined(level.scr_sound[var_1F][param_01][var_0B])) {
        var_1A = 1;
        var_1E = level.scr_sound[var_1F][param_01][var_0B];
      }

      if(isDefined(level.var_EC86[var_1F]) && isDefined(level.var_EC86[var_1F][var_0B + param_01])) {
        var_06 playSound(level.var_EC86[var_1F][var_0B + param_01]);
      }

      if(isDefined(level.var_EC85[var_1F]) && isDefined(level.var_EC85[var_1F][param_01]) && !isai(var_06) || !var_06 scripts\sp\utility::func_58DA()) {
        var_1B = 1;
      }

      if(var_1B) {
        if(isDefined(level.var_EC89[var_1F]) && isDefined(level.var_EC89[var_1F][param_01])) {
          var_20 = level.var_EC89[var_1F][param_01];
        } else {
          var_20 = 0.2;
        }

        var_06 func_A888();
        var_21 = undefined;
        if(isai(var_06)) {
          var_21 = var_06 lib_0A1E::func_2356("Knobs", "body");
        } else if(isDefined(var_06.var_1ED4)) {
          var_21 = [
            [var_06.var_1ED4]
          ]();
        }

        var_06 animscripted(var_09, var_13, var_14, level.var_EC85[var_1F][param_01][var_0B], undefined, var_21, var_20);
        var_22 = getanimlength(level.var_EC85[var_1F][param_01][var_0B]);
        if(var_22 < var_0E) {
          var_0E = var_22;
          var_0D = var_23;
        }

        thread func_10CBF(var_06, var_09, param_01, var_1F, level.var_EC85[var_1F][param_01][var_0B]);
        thread func_1FCA(var_06, var_09, param_01);
      }

      if(var_19 || var_1A) {
        if(isai(var_06)) {
          if(var_1B) {
            var_06 scripts\anim\face::sayspecificdialogue(var_1E);
          } else {
            var_06 scripts\anim\face::sayspecificdialogue(var_1E, var_09);
          }
        } else {
          var_06 scripts\sp\utility::play_sound_on_entity(var_1E);
        }

        var_0F = var_23;
      }
    }

    if(!isDefined(var_06)) {
      break;
    }

    if(isDefined(var_0D)) {
      param_00[var_0D]["guy"] waittillmatch("end", var_09);
      continue;
    }

    if(isDefined(var_0F)) {
      param_00[var_0F]["guy"] waittill(var_09);
    }
  }
}

func_1F2F(param_00, param_01) {}

func_1F2E(param_00, param_01) {
  foreach(var_03 in param_00) {
    var_03 thread func_1F2F(self, param_01);
  }
}

func_1F2C(param_00, param_01, param_02, param_03, param_04) {
  if(!isDefined(param_03)) {
    param_03 = 0;
  }

  func_1F31(param_00, param_01, param_02, param_03, param_04);
}

func_1F30(param_00, param_01, param_02) {
  foreach(var_04 in param_00) {
    var_04 scripts\sp\utility::func_5564();
  }

  func_1EAB(param_00, "gravity", param_01, param_02);
  foreach(var_04 in param_00) {
    if(isDefined(var_04) && isalive(var_04)) {
      var_04 scripts\sp\utility::func_6224();
    }
  }
}

func_1F33(param_00, param_01, param_02, param_03) {
  func_1F31(param_00, param_01, param_02, 0.25, param_03);
}

func_1F31(param_00, param_01, param_02, param_03, param_04) {
  var_05 = self;
  foreach(var_07 in param_00) {
    if(!isDefined(var_07)) {
      continue;
    }

    if(!isDefined(var_07.var_117C)) {
      var_07.var_117C = 0;
    }

    var_07.var_117C++;
  }

  var_09 = func_781C(param_02);
  var_0A = var_09["origin"];
  var_0B = var_09["angles"];
  var_0C = undefined;
  var_0D = 999999;
  var_0E = undefined;
  var_0F = undefined;
  var_10 = undefined;
  var_11 = undefined;
  var_12 = "single anim";
  foreach(var_22, var_07 in param_00) {
    var_14 = 0;
    var_15 = 0;
    var_16 = 0;
    var_17 = 0;
    var_18 = 0;
    var_19 = undefined;
    var_1A = undefined;
    var_1B = undefined;
    var_1C = undefined;
    if(isDefined(param_04)) {
      var_1C = param_04;
    } else {
      var_1C = var_07.var_1FBB;
    }

    if(isDefined(level.scr_sound[var_1C]) && isDefined(level.scr_sound[var_1C][param_01])) {
      var_16 = 1;
      var_19 = level.scr_sound[var_1C][param_01];
    }

    if(isDefined(level.var_EC88[var_1C]) && isDefined(level.var_EC88[var_1C][param_01])) {
      var_14 = 1;
      var_1A = level.var_EC88[var_1C][param_01];
      var_10 = var_1A;
      if(var_16) {
        if(animhasnotetrack(var_1A, "vo_" + var_19)) {
          var_16 = 0;
          var_19 = undefined;
        }
      }
    }

    if(isDefined(level.var_EC8A[var_1C]) && isDefined(level.var_EC8A[var_1C][param_01])) {
      var_15 = 1;
      var_1B = level.var_EC8A[var_1C][param_01];
      var_11 = var_1B;
    }

    if(isDefined(level.var_EC85[var_1C]) && isDefined(level.var_EC85[var_1C][param_01]) && !isai(var_07) || !var_07 scripts\sp\utility::func_58DA()) {
      var_17 = 1;
    }

    if(isDefined(level.var_EC86[var_1C]) && isDefined(level.var_EC86[var_1C][param_01])) {
      var_07 playSound(level.var_EC86[var_1C][param_01]);
    }

    if(var_17) {
      if(scripts\sp\utility::func_93A6() && isDefined(var_07.team) && var_07.team == "axis" && isDefined(var_07.unittype) && var_07.unittype == "soldier") {
        var_07.iscinematicplaying = 0;
      }

      if(isDefined(level.var_EC89[var_1C]) && isDefined(level.var_EC89[var_1C][param_01])) {
        var_1D = level.var_EC89[var_1C][param_01];
      } else {
        var_1D = 0.2;
      }

      var_07 func_A888();
      var_07.var_12FF = param_01;
      if(isplayer(var_07)) {
        var_1E = level.var_EC85[var_1C]["root"];
        var_07 give_attacker_kill_rewards(var_1E, 0, var_1D);
        var_1F = level.var_EC85[var_1C][param_01];
        var_07 _meth_82E1(var_12, var_1F, 1, var_1D);
      } else if(var_07.var_9F == "misc_turret") {
        var_1F = level.var_EC85[var_1C][param_01];
        var_07 _meth_82E1(var_12, var_1F, 1, var_1D);
      } else {
        var_20 = undefined;
        if(isai(var_07)) {
          var_20 = var_07 lib_0A1E::func_2356("Knobs", "body");
        } else if(isDefined(var_07.var_1ED4)) {
          var_20 = [
            [var_07.var_1ED4]
          ]();
        }

        if(isDefined(var_07.asm) && !isai(var_07)) {
          var_07 lib_0A1E::func_230A();
        }

        var_07 animscripted(var_12, var_0A, var_0B, level.var_EC85[var_1C][param_01], undefined, var_20, var_1D);
      }

      var_21 = getanimlength(level.var_EC85[var_1C][param_01]);
      if(var_21 < var_0D) {
        var_0D = var_21;
        var_0C = var_22;
      }

      thread func_10CBF(var_07, var_12, param_01, var_1C, level.var_EC85[var_1C][param_01]);
      thread func_1FCA(var_07, var_12, param_01);
    }

    if(var_14 || var_16) {
      if(var_14) {
        if(var_16) {
          var_07 thread scripts\anim\face::sayspecificdialogue(var_19);
        }

        thread func_1EBD(var_07, param_01, level.var_EC88[var_1C][param_01]);
        var_0F = var_22;
      } else if(isai(var_07) || isDefined(var_07.var_6B14) && var_07.var_6B14) {
        if(var_17) {
          var_07 scripts\anim\face::sayspecificdialogue(var_19);
        } else {
          var_07 thread func_1EBF("single dialogue");
          var_07 scripts\anim\face::sayspecificdialogue(var_19, "single dialogue");
        }
      } else {
        var_07 thread scripts\sp\utility::play_sound_on_entity(var_19, "single dialogue");
      }

      var_0E = var_22;
    }

    if(var_15) {
      var_07 thread func_CC70(var_07, var_11);
    }
  }

  if(isDefined(var_0C)) {
    var_23 = spawnStruct();
    var_23 thread func_1EB0(param_00[var_0C], param_01);
    var_23 thread func_1E9B(param_00[var_0C], param_01, var_0D, param_03);
    var_23 waittill(param_01);
  } else if(isDefined(var_0F)) {
    var_23 = spawnStruct();
    var_23 thread func_1EB0(param_00[var_0F], param_01);
    var_23 thread func_1EBE(param_00[var_0F], param_01, var_10);
    var_23 waittill(param_01);
  } else if(isDefined(var_0E)) {
    var_23 = spawnStruct();
    var_23 thread func_1EB0(param_00[var_0E], param_01);
    var_23 thread func_1EB1(param_00[var_0E], param_01);
    var_23 waittill(param_01);
  }

  foreach(var_07 in param_00) {
    if(!isDefined(var_07)) {
      continue;
    }

    if(isplayer(var_07)) {
      var_1C = undefined;
      if(isDefined(param_04)) {
        var_1C = param_04;
      } else {
        var_1C = var_07.var_1FBB;
      }

      if(isDefined(level.var_EC85[var_1C][param_01])) {
        var_1E = level.var_EC85[var_1C]["root"];
        var_07 give_attacker_kill_rewards(var_1E, 1, 0.2);
        var_1F = level.var_EC85[var_1C][param_01];
        var_07 clearanim(var_1F, 0.2);
      }
    }

    var_07.var_117C--;
    var_07.var_1300 = gettime();
  }

  self notify(param_01);
}

func_10CBF(param_00, param_01, param_02, param_03, param_04) {
  param_00 notify("stop_sequencing_notetracks");
  thread scripts\sp\anim::func_C0E1(param_00, param_01, self, param_02, param_03, param_04);
}

func_1EB0(param_00, param_01) {
  self endon(param_01);
  param_00 waittill("death");
  if(isDefined(param_00.var_1EDD) && param_00.var_1EDD) {
    return;
  }

  self notify(param_01);
}

func_1EBE(param_00, param_01, param_02) {
  self endon(param_01);
  var_03 = getanimlength(param_02);
  wait(var_03);
  self notify(param_01);
}

func_1EB1(param_00, param_01) {
  self endon(param_01);
  param_00 waittill("single dialogue");
  self notify(param_01);
}

func_1E9B(param_00, param_01, param_02, param_03) {
  self endon(param_01);
  param_00 endon("death");
  param_02 = param_02 - param_03;
  if(param_03 > 0 && param_02 > 0) {
    param_00 scripts\sp\utility::func_137A3("single anim", "end", param_02);
    param_00 givescorefortrophyblocks();
  } else {
    param_00 waittillmatch("end", "single anim");
  }

  self notify(param_01);
}

func_1FCA(param_00, param_01, param_02) {
  if(isDefined(param_00.var_5959) && param_00.var_5959) {
    return;
  }

  param_00 endon("stop_sequencing_notetracks");
  param_00 endon("death");
  param_00 scripts\anim\shared::donotetracks(param_01);
}

func_1F60(param_00, param_01) {
  var_02 = level.var_EC85[param_00][param_01].size;
  var_03 = randomint(var_02);
  if(var_02 > 1) {
    var_04 = 0;
    var_05 = 0;
    for(var_06 = 0; var_06 < var_02; var_06++) {
      if(isDefined(level.var_EC85[param_00][param_01 + "weight"])) {
        if(isDefined(level.var_EC85[param_00][param_01 + "weight"][var_06])) {
          var_04++;
          var_05 = var_05 + level.var_EC85[param_00][param_01 + "weight"][var_06];
        }
      }
    }

    if(var_04 == var_02) {
      var_07 = randomfloat(var_05);
      var_05 = 0;
      for(var_06 = 0; var_06 < var_02; var_06++) {
        var_05 = var_05 + level.var_EC85[param_00][param_01 + "weight"][var_06];
        if(var_07 < var_05) {
          var_03 = var_06;
          break;
        }
      }
    }
  }

  return var_03;
}

func_CC70(param_00, param_01) {
  param_00 _meth_82AC( % addtive_head_anims, 1, 0.2);
  param_00 _meth_82AC(param_01, 1, 0.2);
  wait(getanimlength(param_01));
  param_00 clearanim( % addtive_head_anims, 0.2);
  param_00 clearanim(param_01, 0.2);
}

func_1F0E(param_00, param_01, param_02, param_03, param_04) {
  thread func_1F0A(param_00, param_01, param_04);
  var_05 = spawnStruct();
  var_05.var_DD1F = 0;
  foreach(var_07 in param_00) {
    var_05.var_DD1F++;
    thread func_92E4(var_07, param_02, param_03, param_04, var_05);
  }

  for(;;) {
    var_05 waittill("reached_position");
    if(var_05.var_DD1F <= 0) {
      return;
    }
  }
}

func_135DC() {
  self endon("death");
  self waittill("anim_reach_complete");
}

func_92E4(param_00, param_01, param_02, param_03, param_04) {
  param_00 func_135DC();
  param_04.var_DD1F--;
  param_04 notify("reached_position");
  if(isalive(param_00)) {
    func_1EEA(param_00, param_01, param_02, param_03);
  }
}

func_781C(param_00) {
  var_01 = undefined;
  var_02 = undefined;
  if(isDefined(param_00)) {
    var_01 = self gettagorigin(param_00);
    var_02 = self gettagangles(param_00);
  } else {
    var_01 = self.origin;
    var_02 = self.angles;
  }

  var_03 = [];
  var_03["angles"] = var_02;
  var_03["origin"] = var_01;
  return var_03;
}

func_1F1A(param_00, param_01, param_02, param_03) {
  thread modify_moveplaybackrate_together(param_00);
  func_1F1B(param_00, param_01, param_02, param_03, ::func_DD14, ::func_DD15);
}

modify_moveplaybackrate_together(param_00) {
  var_01 = 0.3;
  waittillframeend;
  for(;;) {
    param_00 = scripts\sp\utility::func_DFEB(param_00);
    var_02 = [];
    var_03 = 0;
    foreach(var_08, var_05 in param_00) {
      var_06 = var_05.objective_playermask_hidefromall;
      if(isDefined(var_05.var_DD0B)) {
        var_06 = var_05.var_DD0B;
      }

      var_07 = distance(var_05.origin, var_06);
      var_02[var_05.unique_id] = var_07;
      if(var_07 <= 4) {
        param_00[var_08] = undefined;
        continue;
      }

      var_03 = var_03 + var_07;
    }

    if(param_00.size <= 1) {
      break;
    }

    var_03 = var_03 / param_00.size;
    foreach(var_05 in param_00) {
      var_0A = var_02[var_05.unique_id] - var_03;
      var_0B = var_0A * 0.003;
      if(var_0B > var_01) {
        var_0B = var_01;
      } else if(var_0B < var_01 * -1) {
        var_0B = var_01 * -1;
      }

      var_05 scripts\asm\asm::func_237B(1 + var_0B);
    }

    wait(0.05);
  }

  foreach(var_05 in param_00) {
    if(isalive(var_05)) {
      var_05 scripts\asm\asm::func_237B(1);
    }
  }
}

func_1F13(param_00, param_01) {
  if(isarray(param_00)) {
    foreach(var_03 in param_00) {
      thread func_1F13(var_03, param_01);
    }

    return;
  }

  var_03 = var_03;
  var_04 endon("new_anim_reach");
  wait(var_03);
  var_04 notify("goal");
}

func_1F0A(param_00, param_01, param_02, param_03) {
  if(scripts\sp\interaction::func_9C26(self)) {
    foreach(var_05 in param_00) {
      if(isDefined(self.var_EE92)) {
        var_05.asm.var_4C86.interaction = self.var_EE92;
        continue;
      }

      var_05.asm.var_4C86.interaction = self.script_noteworthy;
    }

    func_1F1B(param_00, param_01, param_02, param_03, ::func_DD0F, ::func_DD10);
    return;
  }

  func_1F1B(param_00, param_01, param_02, param_03, ::func_DD14, ::func_DD15);
}

func_1F1B(param_00, param_01, param_02, param_03, param_04, param_05, param_06) {
  var_07 = func_781C(param_02);
  var_08 = var_07["origin"];
  var_09 = var_07["angles"];
  var_0A = spawnStruct();
  var_0B = 0;
  var_0C = 0;
  foreach(var_0E in param_00) {
    if(isDefined(param_03)) {
      var_0F = param_03;
    } else {
      var_0F = var_0E.var_1FBB;
    }

    if(isDefined(level.var_EC85[var_0F][param_01])) {
      if(isarray(level.var_EC85[var_0F][param_01])) {
        var_10 = getstartorigin(var_08, var_09, level.var_EC85[var_0F][param_01][0]);
        var_11 = getstartangles(var_08, var_09, level.var_EC85[var_0F][param_01][0]);
      } else {
        var_10 = getstartorigin(var_08, var_09, level.var_EC85[var_0F][param_01]);
        var_11 = getstartangles(var_08, var_09, level.var_EC85[var_0F][param_01]);
      }
    } else {
      var_10 = var_08;
      var_11 = var_09;
    }

    if(isDefined(param_06)) {
      var_0E.physics_querypoint = spawn("script_origin", var_10);
      var_0E.physics_querypoint.angles = var_11;
      var_0E.physics_querypoint.type = param_06;
      var_0E.physics_querypoint.var_22EF = "stand";
      var_12 = var_0E getmovingplatformparent();
      if(isDefined(var_12)) {
        var_0E.physics_querypoint linkto(var_12);
      }
    }

    var_0C++;
    var_0E thread func_2A51(var_0A, var_10, var_11, param_04, param_05);
  }

  while(var_0C) {
    var_0A waittill("reach_notify");
    var_0C--;
  }

  foreach(var_15, var_0E in param_00) {
    if(!isalive(var_0E)) {
      continue;
    }

    var_0E.objective_playermask_showto = var_0E.var_C3EE;
    if(isDefined(var_0E.physics_querypoint)) {
      var_0E.physics_querypoint delete();
    }

    var_0E.spawncovernode = 0;
  }
}

func_1F12(param_00) {
  if(!isalive(param_00)) {
    return;
  }

  if(isDefined(param_00.var_C3EE)) {
    param_00.objective_playermask_showto = param_00.var_C3EE;
  }

  if(isDefined(param_00.physics_querypoint)) {
    param_00.physics_querypoint delete();
  }

  param_00.spawncovernode = 0;
}

func_1F57(param_00, param_01, param_02) {
  var_03 = func_781C(param_02);
  var_04 = var_03["origin"];
  var_05 = var_03["angles"];
  foreach(var_07 in param_00) {
    var_08 = getstartorigin(var_04, var_05, level.var_EC85[var_07.var_1FBB][param_01]);
    var_09 = getstartangles(var_04, var_05, level.var_EC85[var_07.var_1FBB][param_01]);
    if(isai(var_07)) {
      var_07 _meth_83B9(var_08);
      continue;
    }

    var_07.origin = var_08;
    var_07.angles = var_09;
  }
}

func_1EEE(param_00, param_01, param_02, param_03, param_04, param_05) {
  var_06 = func_781C(param_02);
  var_07 = var_06["origin"];
  var_08 = var_06["angles"];
  foreach(var_0A in param_00) {
    var_0B = getstartorigin(var_07, var_08, level.var_EC85[var_0A.var_1FBB][param_01]);
    var_0C = getstartangles(var_07, var_08, level.var_EC85[var_0A.var_1FBB][param_01]);
    if(isai(var_0A)) {
      continue;
    }

    var_0A moveto(var_0B, param_03, param_04, param_05);
    var_0A rotateto(var_0C, param_03, param_04, param_05);
  }
}

func_1ED2(param_00, param_01, param_02) {
  var_03 = func_781C(param_02);
  var_04 = var_03["origin"];
  var_05 = var_03["angles"];
  var_06 = getstartorigin(var_04, var_05, level.var_EC85["generic"][param_01]);
  var_07 = getstartangles(var_04, var_05, level.var_EC85["generic"][param_01]);
  if(isai(param_00)) {
    param_00 _meth_83B9(var_06);
    return;
  }

  param_00.origin = var_06;
  param_00.angles = var_07;
}

func_1F41(param_00, param_01, param_02) {
  return func_1F42(param_00, "generic", param_01, param_02);
}

func_1F42(param_00, param_01, param_02, param_03) {
  var_04 = func_781C(param_03);
  var_05 = var_04["origin"];
  var_06 = var_04["angles"];
  var_07 = getstartorigin(var_05, var_06, level.var_EC85[param_01][param_02]);
  var_08 = getstartorigin(var_05, var_06, level.var_EC85[param_01][param_02]);
  var_09 = spawn("script_model", var_07);
  var_09 setModel(param_00);
  var_09.angles = var_08;
  return var_09;
}

func_1F44(param_00, param_01) {
  self attach(param_00, param_01);
}

func_1EE5(param_00, param_01) {
  var_02 = self gettagorigin(param_01);
  var_03 = spawn("script_model", var_02);
  var_03 setModel(param_00);
  var_03 linkto(self, param_01, (0, 0, 0), (0, 0, 0));
  return var_03;
}

func_1F45(param_00, param_01, param_02) {
  var_03 = func_781C(param_02);
  var_04 = var_03["origin"];
  var_05 = var_03["angles"];
  var_06 = spawnStruct();
  foreach(var_08 in param_00) {
    var_09 = getstartorigin(var_04, var_05, level.var_EC85[var_08.var_1FBB][param_01]);
    var_08.origin = var_09;
  }
}

func_DD08(param_00) {
  scripts\engine\utility::waittill_either("death", "goal");
  while(isalive(self) && isDefined(self.asm) && isDefined(self.asm.var_22F8)) {
    wait(0.05);
  }

  param_00 notify("reach_notify");
}

func_2A51(param_00, param_01, param_02, param_03, param_04) {
  self endon("death");
  self endon("new_anim_reach");
  thread func_DD08(param_00);
  param_01 = [
    [param_03]
  ](param_01, param_02);
  scripts\sp\utility::func_F3DC(param_01);
  self.var_DD0B = param_01;
  self.objective_playermask_showto = 0;
  self.spawncovernode = squared(64);
  self waittill("goal");
  self notify("anim_reach_complete");
  [
    [param_04]
  ]();
  self notify("new_anim_reach");
}

func_DD0F(param_00, param_01) {
  self.var_C3EE = self.objective_playermask_showto;
  self.var_C3FD = self.vectortoyaw;
  self.var_C3FE = self.vehicle_getarray;
  self.vectortoyaw = 128;
  self.vehicle_getarray = 128;
  scripts\sp\utility::func_54F7();
  func_1EA8(1);
  self.target_set = 1;
  self.var_6E04 = self.logstring;
  self.logstring = 0;
  self.var_C3B9 = self.disablearrivals;
  self.disablearrivals = 0;
  self.var_DD0B = undefined;
  var_02 = scripts\sp\interaction::func_7A45(self.asm.var_4C86.interaction);
  if(!isDefined(var_02)) {
    var_02 = scripts\sp\interaction::func_7CA7(self.asm.var_4C86.interaction);
  }

  self.asm.var_4C86.var_22F1 = scripts\sp\interaction::func_7837(var_02);
  self.asm.var_4C86.var_22E3 = param_01;
  self.asm.var_4C86.var_92FA = scripts\sp\interaction::func_7A30(var_02);
  self.asm.var_4C86.var_22F6 = 1;
  if(isDefined(var_02.var_22E1)) {
    self.asm.var_4C86.var_4C38 = var_02.var_22E1;
  }

  return param_00;
}

func_DD14(param_00, param_01) {
  self.var_C3EE = self.objective_playermask_showto;
  self.var_C3FD = self.vectortoyaw;
  self.var_C3FE = self.vehicle_getarray;
  self.vectortoyaw = 128;
  self.vehicle_getarray = 128;
  scripts\sp\utility::func_54F7();
  func_1EA8(1);
  self.target_set = 1;
  self.var_6E04 = self.logstring;
  self.logstring = 0;
  if(!isDefined(self.physics_querypoint)) {
    self.var_C3B9 = self.disablearrivals;
    self.disablearrivals = 1;
  } else {
    self.physics_querypoint.angles = param_01;
    self.physics_querypoint.origin = param_00;
  }

  self.var_DD0B = undefined;
  return param_00;
}

func_DD10() {
  func_1EA8(0);
  self.target_set = 0;
  self.logstring = self.var_6E04;
  self.var_6E04 = undefined;
  self.vectortoyaw = self.var_C3FD;
  self.vehicle_getarray = self.var_C3FE;
  self.disablearrivals = self.var_C3B9;
  var_00 = scripts\sp\interaction::func_7A45(self.asm.var_4C86.interaction);
  if(!isDefined(var_00)) {
    var_00 = scripts\sp\interaction::func_7CA7(self.asm.var_4C86.interaction);
  }

  self.asm.var_4C86.var_697F = scripts\sp\interaction::func_79A5(var_00);
  self.asm.var_4C86.interaction = undefined;
  self.asm.var_4C86.var_22F1 = undefined;
  self.asm.var_4C86.var_22E3 = undefined;
}

func_DD15() {
  func_1EA8(0);
  self.target_set = 0;
  self.logstring = self.var_6E04;
  self.var_6E04 = undefined;
  self.vectortoyaw = self.var_C3FD;
  self.vehicle_getarray = self.var_C3FE;
  self.disablearrivals = self.var_C3B9;
}

func_1EA8(param_00) {
  if(isDefined(self.var_5954)) {
    return;
  }

  self _meth_8250(param_00);
}

func_DD11(param_00, param_01) {
  param_00 = func_DD14(param_00, param_01);
  self.disablearrivals = 0;
  return param_00;
}

func_DD12(param_00, param_01) {
  var_02 = self _meth_811F(param_00);
  param_00 = var_02;
  param_00 = func_DD14(param_00, param_01);
  self.disablearrivals = 1;
  return param_00;
}

func_DD13(param_00, param_01) {
  var_02 = self _meth_811F(param_00);
  param_00 = var_02;
  param_00 = func_DD14(param_00, param_01);
  self.disablearrivals = 0;
  return param_00;
}

func_F64A() {
  self glinton(level.var_EC87[self.var_1FBB]);
}

func_1F35(param_00, param_01, param_02, param_03, param_04) {
  self endon("death");
  var_05[0] = param_00;
  if(!isDefined(param_03)) {
    param_03 = 0;
  }

  func_1F2C(var_05, param_01, param_02, param_03, param_04);
}

func_1F37(param_00, param_01, param_02) {
  self endon("death");
  var_03[0] = param_00;
  func_1F2C(var_03, param_01, param_02, 0.25);
}

func_1F34(param_00, param_01, param_02, param_03) {
  self endon("death");
  var_04[0] = param_00;
  func_1F2C(var_04, param_01, param_02, 0.25);
}

func_1F0F(param_00, param_01, param_02, param_03, param_04) {
  self endon("death");
  var_05[0] = param_00;
  func_1F0E(var_05, param_01, param_02, param_03, param_04);
}

func_1F17(param_00, param_01, param_02) {
  self endon("death");
  var_03[0] = param_00;
  func_1F0A(var_03, param_01, param_02);
}

func_1F0D(param_00, param_01, param_02, param_03) {
  self endon("death");
  var_04[0] = param_00;
  func_1F0B(var_04, param_01, param_02, param_03);
}

func_1F0C(param_00, param_01, param_02, param_03, param_04) {
  self endon("death");
  var_05[0] = param_00;
  var_06 = func_781C(param_02);
  var_07 = var_06["origin"];
  var_08 = var_06["angles"];
  var_09 = param_00.var_1FBB;
  if(isDefined(level.var_EC85[var_09][param_01])) {
    if(isarray(level.var_EC85[var_09][param_01])) {
      var_0A = level.var_EC85[var_09][param_01][0];
    } else {
      var_0A = level.var_EC85[var_0A][param_02];
    }

    var_07 = getstartorigin(var_07, var_08, var_0A);
    var_08 = getstartorigin(var_07, var_08, var_0A);
  }

  var_0B = spawn("script_origin", var_07);
  var_0B.angles = var_08;
  if(isDefined(param_03)) {
    var_0B.type = param_03;
  } else {
    var_0B.type = self.type;
  }

  if(isDefined(param_04)) {
    var_0B.var_22EF = param_04;
  } else {
    var_0B.var_22EF = self gethighestnodestance();
  }

  param_00.physics_querypoint = var_0B;
  func_1F0B(var_05, param_01, param_02);
  param_00.physics_querypoint = undefined;
  var_0B delete();
  while(param_00.a.movement != "stop") {
    wait(0.05);
  }
}

func_1F0B(param_00, param_01, param_02, param_03) {
  self endon("death");
  if(scripts\sp\interaction::func_9C26(self)) {
    foreach(var_05 in param_00) {
      if(isDefined(self.script_noteworthy)) {
        var_05.asm.var_4C86.interaction = self.script_noteworthy;
        continue;
      }

      var_05.asm.var_4C86.interaction = self.var_EE92;
    }

    func_1F1B(param_00, param_01, param_02, undefined, ::func_DD0F, ::func_DD10, param_03);
    return;
  }

  if(!isDefined(param_03)) {
    param_03 = "Exposed";
  }

  func_1F1B(param_00, param_01, param_02, undefined, ::func_DD11, ::func_DD15, param_03);
}

func_1EEA(param_00, param_01, param_02, param_03, param_04, param_05) {
  self endon("death");
  param_00 endon("death");
  var_06[0] = param_00;
  func_1EE7(var_06, param_01, param_02, param_03, param_04, param_05);
}

func_1F58(param_00, param_01, param_02) {
  self endon("death");
  var_03[0] = param_00;
  func_1F57(var_03, param_01, param_02);
}

func_1696(param_00, param_01) {
  if(!isDefined(level.var_4483)) {
    level.var_4483[param_00][0] = param_01;
    return;
  }

  if(!isDefined(level.var_4483[param_00])) {
    level.var_4483[param_00][0] = param_01;
    return;
  }

  for(var_02 = 0; var_02 < level.var_4483[param_00].size; var_02++) {
    if(level.var_4483[param_00][var_02] == param_01) {
      return;
    }
  }

  level.var_4483[param_00][level.var_4483[param_00].size] = param_01;
}

func_1F32(param_00, param_01, param_02, param_03) {
  if(!isDefined(param_03)) {
    param_03 = 0;
  }

  if(isDefined(param_00.var_A8F8)) {
    scripts\sp\utility::func_135AF(param_00.var_A8F8, 0.5);
  }

  scripts\sp\utility::func_74D7(::func_1F35, param_00, param_01, param_02, param_03);
  if(isalive(param_00)) {
    param_00.var_A8F8 = gettime();
  }
}

func_1ECD(param_00, param_01, param_02, param_03, param_04) {
  param_00 endon("death");
  if(!isDefined(param_03)) {
    param_03 = 0;
  }

  if(isDefined(param_00.var_A8F8)) {
    scripts\sp\utility::func_135AF(param_00.var_A8F8, 0.5);
  }

  if(isDefined(param_04)) {
    scripts\sp\utility::func_74DD(param_04, ::func_1F35, param_00, param_01, param_02, param_03, "generic");
  } else {
    scripts\sp\utility::func_74D7(::func_1F35, param_00, param_01, param_02, param_03, "generic");
  }

  if(isalive(param_00)) {
    param_00.var_A8F8 = gettime();
  }
}

func_1EB3(param_00) {
  foreach(var_02 in param_00) {
    var_02 _meth_8250(0);
  }
}

func_1F08(param_00) {
  foreach(var_02 in param_00) {
    var_02 _meth_8250(1);
  }
}

func_E140(param_00, param_01, param_02, param_03, param_04) {
  param_01 = tolower(param_01);
  var_05 = level.var_EC8D[param_00][param_02][param_01];
  param_02 = func_79E4(param_02);
  var_06 = -1;
  if(!isDefined(var_05) || !isarray(var_05) || var_05.size < 1) {
    return;
  }

  for(var_07 = 0; var_07 < var_05.size; var_07++) {
    if(isDefined(var_05[var_07][param_03])) {
      if(!isDefined(param_04) || var_05[var_07][param_03] == param_04) {
        var_06 = var_07;
        break;
      }
    }
  }

  if(var_06 < 0) {
    return;
  }

  if(var_05.size == 1) {
    var_05 = [];
  } else {
    var_05 = scripts\sp\utility::array_remove_index(var_05, var_06);
  }

  level.var_EC8D[param_00][param_02][param_01] = var_05;
}

func_17F9(param_00, param_01, param_02, param_03) {
  param_01 = tolower(param_01);
  param_02 = func_79E4(param_02);
  var_04 = func_1720(param_00, param_01, param_02);
  level.var_EC8D[param_00][param_02][param_01][var_04] = [];
  level.var_EC8D[param_00][param_02][param_01][var_04]["dialog"] = param_03;
}

func_1720(param_00, param_01, param_02) {
  param_01 = tolower(param_01);
  func_1721(param_00, param_01, param_02);
  return level.var_EC8D[param_00][param_02][param_01].size;
}

func_1721(param_00, param_01, param_02) {
  param_01 = tolower(param_01);
  if(!isDefined(level.var_EC8D)) {
    level.var_EC8D = [];
  }

  if(!isDefined(level.var_EC8D[param_00])) {
    level.var_EC8D[param_00] = [];
  }

  if(!isDefined(level.var_EC8D[param_00][param_02])) {
    level.var_EC8D[param_00][param_02] = [];
  }

  if(!isDefined(level.var_EC8D[param_00][param_02][param_01])) {
    level.var_EC8D[param_00][param_02][param_01] = [];
  }
}

func_17FF(param_00, param_01, param_02, param_03, param_04, param_05) {
  param_01 = tolower(param_01);
  param_02 = func_79E4(param_02);
  var_06 = func_1720(param_00, param_01, param_02);
  level.var_EC8D[param_00][param_02][param_01][var_06] = [];
  level.var_EC8D[param_00][param_02][param_01][var_06]["sound"] = param_03;
  if(isDefined(param_04)) {
    level.var_EC8D[param_00][param_02][param_01][var_06]["sound_stays_death"] = 1;
  }

  if(isDefined(param_05)) {
    level.var_EC8D[param_00][param_02][param_01][var_06]["sound_on_tag"] = param_05;
  }
}

func_C0BB(param_00, param_01, param_02, param_03) {
  var_04 = func_7926();
  func_17FF(var_04.var_1FBB, param_00, var_04.var_1F24, param_01, param_02, param_03);
}

func_17FE(param_00, param_01, param_02, param_03) {
  param_01 = tolower(param_01);
  param_02 = func_79E4(param_02);
  var_04 = func_1720(param_00, param_01, param_02);
  level.var_EC8D[param_00][param_02][param_01][var_04] = [];
  level.var_EC8D[param_00][param_02][param_01][var_04]["playersound"] = param_03;
}

func_79E4(param_00) {
  if(!isDefined(param_00)) {
    return "any";
  }

  return param_00;
}

func_1806(param_00, param_01, param_02) {
  if(!isDefined(level.var_EC86[param_00])) {
    level.var_EC86[param_00] = [];
  }

  level.var_EC86[param_00][param_01] = param_02;
}

func_17FD(param_00, param_01, param_02, param_03) {
  param_01 = tolower(param_01);
  param_02 = func_79E4(param_02);
  var_04 = func_1720(param_00, param_01, param_02);
  level.var_EC8D[param_00][param_02][param_01][var_04] = [];
  level.var_EC8D[param_00][param_02][param_01][var_04]["playerdialogue"] = param_03;
}

func_17F4(param_00, param_01, param_02, param_03) {
  param_02 = tolower(param_02);
  param_01 = func_79E4(param_01);
  var_04 = func_1720(param_00, param_02, param_01);
  var_05 = [];
  var_05["sound"] = param_03;
  var_05["created_by_animSound"] = 1;
  level.var_EC8D[param_00][param_01][param_02][var_04] = var_05;
}

func_17F5(param_00, param_01, param_02, param_03, param_04) {
  param_01 = tolower(param_01);
  param_04 = func_79E4(param_04);
  var_05 = func_1720(param_00, param_01, param_04);
  var_06 = [];
  var_06["attach model"] = param_02;
  var_06["selftag"] = param_03;
  level.var_EC8D[param_00][param_04][param_01][var_05] = var_06;
}

func_17F7(param_00, param_01, param_02, param_03, param_04) {
  param_01 = tolower(param_01);
  param_04 = func_79E4(param_04);
  var_05 = func_1720(param_00, param_01, param_04);
  var_06 = [];
  var_06["detach model"] = param_02;
  var_06["selftag"] = param_03;
  level.var_EC8D[param_00][param_04][param_01][var_05] = var_06;
}

func_17F8(param_00, param_01, param_02, param_03) {
  param_01 = tolower(param_01);
  param_02 = func_79E4(param_02);
  var_04 = func_1720(param_00, param_01, param_02);
  var_05 = [];
  var_05["detach gun"] = 1;
  var_05["tag"] = "tag_weapon_right";
  if(isDefined(param_03)) {
    var_05["suspend"] = param_03;
  }

  level.var_EC8D[param_00][param_02][param_01][var_04] = var_05;
}

func_17F6(param_00, param_01, param_02, param_03) {
  param_01 = tolower(param_01);
  param_03 = func_79E4(param_03);
  var_04 = func_1720(param_00, param_01, param_03);
  var_05 = [];
  var_05["function"] = param_02;
  level.var_EC8D[param_00][param_03][param_01][var_04] = var_05;
}

func_1800(param_00, param_01, param_02, param_03, param_04, param_05) {
  scripts\engine\utility::getfx(param_03);
  param_01 = tolower(param_01);
  param_02 = func_79E4(param_02);
  var_06 = func_1720(param_00, param_01, param_02);
  var_07 = [];
  var_07["effect"] = param_03;
  var_07["selftag"] = param_04;
  if(isDefined(param_05)) {
    var_07["moreThanThreeHack"] = param_05;
  }

  level.var_EC8D[param_00][param_02][param_01][var_06] = var_07;
}

func_1801(param_00, param_01, param_02, param_03, param_04) {
  scripts\engine\utility::getfx(param_03);
  param_01 = tolower(param_01);
  param_02 = func_79E4(param_02);
  var_05 = func_1720(param_00, param_01, param_02);
  var_06 = [];
  var_06["stop_effect"] = param_03;
  var_06["selftag"] = param_04;
  level.var_EC8D[param_00][param_02][param_01][var_05] = var_06;
}

func_C0BD(param_00, param_01, param_02) {
  var_03 = func_7926();
  scripts\engine\utility::add_fx(param_01, param_01);
  func_1802(var_03.var_1FBB, param_00, var_03.var_1FCF, param_01, param_02);
}

func_C0BC(param_00, param_01, param_02) {
  var_03 = func_7926();
  scripts\engine\utility::add_fx(param_01, param_01);
  func_1801(var_03.var_1FBB, param_00, var_03.var_1FCF, param_01, param_02);
}

func_1802(param_00, param_01, param_02, param_03, param_04) {
  scripts\engine\utility::getfx(param_03);
  param_01 = tolower(param_01);
  param_02 = func_79E4(param_02);
  var_05 = func_1720(param_00, param_01, param_02);
  var_06 = [];
  var_06["swap_part_to_efx"] = param_03;
  var_06["selftag"] = param_04;
  level.var_EC8D[param_00][param_02][param_01][var_05] = var_06;
}

func_C0BE(param_00, param_01, param_02, param_03, param_04, param_05) {
  var_06 = func_7926();
  if(param_00 != "start" && !animhasnotetrack(var_06 scripts\sp\utility::func_7DC1(var_06.var_1F24), param_00)) {
    return;
  }

  scripts\engine\utility::add_fx(param_03, param_03);
  if(isDefined(param_04)) {
    scripts\engine\utility::add_fx(param_04, param_04);
  }

  func_1803(var_06.var_1FBB, param_00, param_01, var_06.var_1F24, param_02, param_03, param_04, param_05);
}

func_C0BA(param_00, param_01, param_02) {
  var_03 = func_7926();
  if(param_00 != "start" && !animhasnotetrack(var_03 scripts\sp\utility::func_7DC1(var_03.var_1F24), param_00)) {
    return;
  }

  scripts\engine\utility::add_fx(param_02, param_02);
  func_1800(var_03.var_1FBB, param_00, var_03.var_1F24, param_02, param_01, 1);
}

func_7926() {
  var_00 = level.var_4B3E;
  return var_00;
}

func_1803(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07) {
  scripts\engine\utility::getfx(param_05);
  param_01 = tolower(param_01);
  param_03 = func_79E4(param_03);
  var_08 = func_1720(param_00, param_01, param_03);
  var_09 = [];
  var_09["trace_part_for_efx"] = param_05;
  var_09["trace_part_for_efx_water"] = param_06;
  var_09["trace_part_for_efx_cancel"] = param_02;
  var_09["trace_part_for_efx_delete_depth"] = param_07;
  var_09["selftag"] = param_04;
  level.var_EC8D[param_00][param_03][param_01][var_08] = var_09;
  if(isDefined(param_02)) {
    var_09 = [];
    var_09["trace_part_for_efx_canceling"] = param_02;
    var_09["selftag"] = param_04;
    var_08 = func_1720(param_00, param_02, param_03);
    level.var_EC8D[param_00][param_03][param_02][var_08] = var_09;
  }
}

func_17FA(param_00, param_01, param_02, param_03) {
  param_01 = tolower(param_01);
  param_03 = func_79E4(param_03);
  var_04 = func_1720(param_00, param_01, param_03);
  var_05 = [];
  var_05["flag"] = param_02;
  level.var_EC8D[param_00][param_03][param_01][var_04] = var_05;
  if(!isDefined(level.flag) || !isDefined(level.flag[param_02])) {
    scripts\engine\utility::flag_init(param_02);
  }
}

func_17FB(param_00, param_01, param_02, param_03) {
  param_01 = tolower(param_01);
  param_03 = func_79E4(param_03);
  var_04 = func_1720(param_00, param_01, param_03);
  var_05 = [];
  var_05["flag_clear"] = param_02;
  level.var_EC8D[param_00][param_03][param_01][var_04] = var_05;
  if(!isDefined(level.flag) || !isDefined(level.flag[param_02])) {
    scripts\engine\utility::flag_init(param_02);
  }
}

func_17FC(param_00, param_01, param_02, param_03) {
  param_01 = tolower(param_01);
  param_03 = func_79E4(param_03);
  var_04 = func_1720(param_00, param_01, param_03);
  var_05 = [];
  var_05["notify"] = param_02;
  level.var_EC8D[param_00][param_03][param_01][var_04] = var_05;
}

func_55C7(param_00) {
  if(!isDefined(self.var_8C7E)) {
    self.var_8C7E = lib_0A1E::func_2356("Knobs", "head");
  }

  if(!isDefined(param_00) || param_00) {
    scripts\sp\utility::func_F6FE("vignette");
    self clearanim(self.var_8C7E, 0.2);
    self.facialidx = undefined;
    return;
  }

  scripts\sp\utility::func_41AD("vignette");
}

func_1EBD(param_00, param_01, param_02) {
  param_00 endon("death");
  self endon(param_01);
  var_03 = 0.05;
  param_00 notify("newLookTarget");
  func_55C7();
  waittillframeend;
  if(!isDefined(self.var_EF82)) {
    self.var_EF82 = lib_0A1E::func_2356("Knobs", "scripted_talking");
  }

  var_04 = "scripted_face_" + param_01;
  param_00 give_attacker_kill_rewards(self.var_EF82, 5, 0.2);
  param_00 _meth_82E7(var_04, param_02, 1, 0, 1);
  thread scripts\sp\anim::func_6A85(param_00, var_04, param_01);
  thread func_41AC(param_00, var_04, param_01);
}

func_1EBF(param_00, param_01) {
  self endon("death");
  if(isai(self) && !isalive(self)) {
    return;
  }

  if(!isai(self) && !isDefined(self.var_6B14) || !self.var_6B14) {
    return;
  }

  if(!scripts\sp\utility::isfacialstateallowed("filler")) {
    return;
  }

  if(self.unittype == "c6" || self.unittype == "c8" || self.unittype == "c12") {
    return;
  }

  var_02 = 0.05;
  self notify("newLookTarget");
  self endon("newLookTarget");
  waittillframeend;
  if(!isDefined(param_01) && isDefined(self.var_299D)) {
    param_01 = self.var_299D;
  }

  var_03 = "";
  if(isDefined(self.asm)) {
    var_03 = self.asm.archetype;
  }

  if(isDefined(self.var_1FA8)) {
    var_03 = self.var_1FA8;
  }

  var_04 = self.var_504D;
  var_05 = self.var_EF82;
  if(var_03 != "") {
    var_05 = lib_0A1E::func_2356("Knobs", "head");
    var_04 = _func_2EF(var_03, "facial_animation", "facial_talk", 0);
  }

  scripts\sp\utility::func_F6FE("filler");
  self _meth_82AA(var_04, 1, 0, 1);
  self give_attacker_kill_rewards(var_05, 5, 0.267);
  func_F5BE(param_00, var_04, var_05);
  var_02 = 0.3;
  self clearanim(var_05, 0.2);
  scripts\sp\utility::func_41AD("filler");
}

func_F5BE(param_00, param_01, param_02) {
  self waittill(param_00);
}

func_11497(param_00) {
  self endon("death");
  var_01 = self.var_504D;
  self _meth_82AA(var_01, 1, 0, 1);
  self give_attacker_kill_rewards(self.var_EF82, 5, 0.4);
  func_55C7();
  wait(param_00);
  var_02 = 0.3;
  self clearanim(self.var_EF82, 0.2);
  func_55C7(0);
}

getyawangles(param_00, param_01) {
  var_02 = param_00[1] - param_01[1];
  var_02 = angleclamp180(var_02);
  return var_02;
}

func_B022(param_00, param_01) {
  self notify("lookline");
  self endon("lookline");
  self endon(param_01);
  self endon("death");
  wait(0.05);
}

func_1F14(param_00, param_01, param_02) {
  var_03 = spawnStruct();
  var_03.var_C1 = param_00.size;
  foreach(var_05 in param_00) {
    thread func_DD20(var_05, param_01, param_02, var_03);
  }

  while(var_03.var_C1) {
    var_03 waittill("reached_goal");
  }

  self notify("stopReachIdle");
}

func_DD20(param_00, param_01, param_02, param_03) {
  func_1F17(param_00, param_01);
  param_03.var_C1--;
  param_03 notify("reached_goal");
  if(param_03.var_C1 > 0) {
    func_1EEA(param_00, param_02, "stopReachIdle");
  }
}

func_41AC(param_00, param_01, param_02) {
  param_00 endon("death");
  param_00 waittillmatch("end", param_01);
  param_00 notify("scripted_face_done");
  var_03 = 0.3;
  param_00 clearanim(self.var_EF82, 0.2);
  func_55C7(0);
}

func_1F50(param_00, param_01, param_02) {
  var_03 = func_781C(param_02);
  var_04 = var_03["origin"];
  var_05 = var_03["angles"];
  scripts\engine\utility::array_thread(param_00, ::func_F5B0, param_01, var_04, var_05);
}

func_1F51(param_00, param_01, param_02) {
  var_03[0] = param_00;
  func_1F50(var_03, param_01, param_02);
}

func_F5B0(param_00, param_01, param_02, param_03, param_04) {
  var_05 = undefined;
  if(isDefined(param_03)) {
    var_05 = param_03;
  } else {
    var_05 = self.var_1FBB;
  }

  if(isDefined(param_04) && param_04) {
    var_06 = level.var_EC85[var_05][param_00][0];
  } else {
    var_06 = level.var_EC85[var_06][param_01];
  }

  if(isai(self)) {
    var_07 = getstartorigin(param_01, param_02, var_06);
    var_08 = getstartangles(param_01, param_02, var_06);
    if(isDefined(self.var_1F4E)) {
      var_07 = scripts\sp\utility::func_864C(var_07);
    }

    self _meth_80F1(var_07, var_08);
    return;
  }

  if(self.var_9F == "script_vehicle") {
    self vehicle_teleport(getstartorigin(param_01, param_02, var_06), getstartangles(param_01, param_02, var_06));
    return;
  }

  self.origin = getstartorigin(param_01, param_02, var_06);
  self.angles = getstartangles(param_01, param_02, var_06);
}

func_1E9F(param_00, param_01) {
  var_02 = [];
  var_02["guy"] = self;
  var_02["entity"] = self;
  return var_02;
}

func_1E9E(param_00, param_01) {
  var_02 = [];
  var_02["guy"] = self;
  var_02["entity"] = param_00;
  var_02["tag"] = param_01;
  return var_02;
}

func_1F29(param_00, param_01, param_02) {
  param_00 thread func_1F28(param_01, param_02);
}

func_1F27(param_00, param_01, param_02) {
  scripts\engine\utility::array_thread(param_00, ::func_1F28, param_01, param_02);
}

func_1F28(param_00, param_01, param_02) {
  var_03 = undefined;
  if(isDefined(param_02)) {
    var_03 = param_02;
  } else {
    var_03 = self.var_1FBB;
  }

  self _meth_82E1("single anim", scripts\sp\utility::func_7DC2(param_00, var_03), 1, 0, param_01);
}

func_1F2A(param_00, param_01, param_02) {
  scripts\engine\utility::array_thread(param_00, ::func_1F23, param_01, param_02);
}

func_1F23(param_00, param_01) {
  var_02 = scripts\sp\utility::func_7DC1(param_00);
  self _meth_82B0(var_02, param_01);
}

func_A888() {
  if(!isDefined(self.var_A887)) {
    self.var_A887 = gettime();
    return;
  }

  var_00 = gettime();
  if(self.var_A887 == var_00) {
    self endon("death");
    wait(0.05);
  }

  self.var_A887 = var_00;
}

func_F325(param_00, param_01) {
  param_00.custommovetransition = ::scripts\anim\cover_arrival::custommovetransitionfunc;
  param_00.var_10DCB = level.var_EC85[param_00.var_1FBB][param_01];
}

func_489E(param_00, param_01, param_02, param_03, param_04) {
  if(!isDefined(param_03)) {
    param_03 = "generic";
  } else {
    level.var_EC87[param_03] = param_00;
  }

  var_05 = spawnStruct();
  var_05.var_1FEC = param_00;
  var_05.model = param_04;
  if(isDefined(param_04)) {
    level.var_EC8C[param_03] = param_04;
  }

  if(isDefined(param_02)) {
    level.var_EC85[param_03][param_01] = param_02;
  }

  var_05.var_1FBB = param_03;
  var_05.var_1F24 = param_01;
  level.var_4B3E = var_05;
}

func_2B8C(param_00, param_01, param_02, param_03) {
  param_00.var_1E9D = param_02;
  param_00.var_6317 = param_03;
  param_00.var_77A3 = param_01;
  param_00.var_1FBD = self;
  param_00 lib_0A1E::func_2307(::lib_0C4C::func_2B8A, ::lib_0C4C::func_2B8B);
}

func_2B87(param_00, param_01, param_02) {
  while(isDefined(param_00.var_1E9D)) {
    wait(0.05);
  }

  param_00.var_1E9D = param_02;
  param_00.var_77A3 = param_01;
  param_00.var_1FBD = self;
  param_00 lib_0A1E::func_2307(::lib_0C4C::func_2B86);
}