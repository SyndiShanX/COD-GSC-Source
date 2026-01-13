/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: SP\2822.gsc
*********************************************/

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
  var_0 = getarraykeys(level.var_EC8D);
  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    func_969F(var_0[var_1]);
  }

  var_0 = getarraykeys(level.var_EC86);
  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    func_9526(var_0[var_1]);
  }
}

func_9526(var_0) {
  var_1 = getarraykeys(level.var_EC86[var_0]);
  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    var_3 = var_1[var_2];
    var_4 = level.var_EC86[var_0][var_3];
    level.var_1FD4[var_0][var_3]["#" + var_3]["soundalias"] = var_4;
    level.var_1FD4[var_0][var_3]["#" + var_3]["created_by_animSound"] = 1;
  }
}

func_969F(var_0) {
  foreach(var_0A, var_2 in level.var_EC8D[var_0]) {
    foreach(var_9, var_4 in var_2) {
      foreach(var_6 in var_4) {
        var_7 = var_6["sound"];
        if(!isDefined(var_7)) {
          continue;
        }

        level.var_1FD4[var_0][var_0A][var_9]["soundalias"] = var_7;
        if(isDefined(var_6["created_by_animSound"])) {
          level.var_1FD4[var_0][var_0A][var_9]["created_by_animSound"] = 1;
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

  var_0 = getarraykeys(level.var_EC8C);
  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    if(isarray(level.var_EC8C[var_0[var_1]])) {
      for(var_2 = 0; var_2 < level.var_EC8C[var_0[var_1]].size; var_2++) {
        precachemodel(level.var_EC8C[var_0[var_1]][var_2]);
      }

      continue;
    }

    precachemodel(level.var_EC8C[var_0[var_1]]);
  }
}

func_6370(var_0, var_1) {
  self waittill(var_0);
  foreach(var_3 in var_1) {
    var_4 = var_3["guy"];
    if(!isDefined(var_4)) {
      continue;
    }

    var_4.var_117C--;
    var_4.var_1300 = gettime();
  }
}

func_1EC1(var_0, var_1, var_2) {
  var_3 = func_781C(var_2);
  var_4 = var_3["origin"];
  var_5 = var_3["angles"];
  scripts\engine\utility::array_levelthread(var_0, ::func_1EC2, var_1, var_4, var_5);
}

func_1ECA(var_0, var_1, var_2) {
  var_3 = func_781C(var_2);
  var_4 = var_3["origin"];
  var_5 = var_3["angles"];
  thread func_1EC2(var_0, var_1, var_4, var_5, "generic");
}

func_1EC7(var_0, var_1, var_2) {
  var_3 = [];
  var_3[0] = var_0;
  func_1F2C(var_3, var_1, var_2, 0, "generic");
}

func_1ECB(var_0, var_1, var_2) {
  var_3 = var_0.allowpain;
  var_0 scripts\sp\utility::func_5564();
  func_1EC8(var_0, "gravity", var_1, var_2);
  if(var_3) {
    var_0 scripts\sp\utility::func_6224();
  }
}

func_1ED1(var_0, var_1, var_2) {
  var_3 = [];
  var_3[0] = var_0;
  func_1F2C(var_3, var_1, var_2, 0.25, "generic");
}

func_1ECE(var_0, var_1, var_2) {
  var_3 = [];
  var_3[0] = var_0;
  func_1F0A(var_3, var_1, var_2, "generic");
}

func_1ED0(var_0, var_1, var_2, var_3) {
  var_4 = [];
  var_4[0] = var_0;
  if(scripts\sp\interaction::func_9C26(self) || scripts\sp\interaction::func_9CD7(self)) {
    foreach(var_0 in var_4) {
      if(isDefined(self.var_EE92)) {
        var_0.asm.var_4C86.interaction = self.var_EE92;
        continue;
      }

      var_0.asm.var_4C86.interaction = self.script_noteworthy;
    }

    var_7 = scripts\sp\interaction::func_7A45(var_0.asm.var_4C86.interaction);
    if(!isDefined(var_7)) {
      var_7 = scripts\sp\interaction::func_7CA7(var_0.asm.var_4C86.interaction);
    }

    var_0.asm.var_4C86.var_22F1 = undefined;
    if(isDefined(var_7)) {
      var_0.asm.var_4C86.var_22F1 = var_0 scripts\sp\interaction::func_7837(var_7);
    }

    if(isDefined(var_0.asm.var_4C86.var_22F1)) {
      func_1F1B(var_4, var_1, var_2, "generic", ::func_DD0F, ::func_DD10, var_3);
      return;
    }

    func_1F1B(var_4, var_1, var_2, "generic", ::func_DD11, ::func_DD15, var_3);
    return;
  }

  func_1F1B(var_4, var_1, var_2, "generic", ::func_DD11, ::func_DD15, var_3);
}

func_1F10(var_0, var_1, var_2) {
  func_1F1B(var_0, var_1, var_2, undefined, ::func_DD12, ::func_DD15);
}

func_1F11(var_0, var_1, var_2) {
  func_1F1B(var_0, var_1, var_2, undefined, ::func_DD13, ::func_DD15);
}

func_1ECC(var_0, var_1, var_2, var_3) {
  var_4 = [];
  var_4["guy"] = var_0;
  var_4["entity"] = self;
  var_4["tag"] = var_3;
  var_5[0] = var_4;
  func_1EE8(var_5, var_1, var_2, "generic");
}

func_1EAB(var_0, var_1, var_2, var_3) {
  var_4 = func_781C(var_3);
  var_5 = var_4["origin"];
  var_6 = var_4["angles"];
  var_7 = undefined;
  foreach(var_9 in var_0) {
    var_7 = var_9;
    thread func_1EAE(var_9, var_1, var_2, var_5, var_6, var_9.var_1FBB, 0);
  }

  var_7 func_1368A(var_2);
  self notify(var_2);
}

func_1EAC(var_0, var_1, var_2, var_3) {
  var_4 = func_781C(var_3);
  var_5 = var_4["origin"];
  var_6 = var_4["angles"];
  foreach(var_8 in var_0) {
    thread func_1EAE(var_8, var_1, var_2, var_5, var_6, var_8.var_1FBB, 1);
  }

  var_0[0] func_1368A(var_2);
  self notify(var_2);
}

func_1368A(var_0) {
  self endon("finished_custom_animmode" + var_0);
  self waittill("death");
}

func_1EC8(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = func_781C(var_3);
  var_7 = var_6["origin"];
  var_8 = var_6["angles"];
  thread func_1EAE(var_0, var_1, var_2, var_7, var_8, "generic", 0, var_4, var_5);
  var_0 func_1368A(var_2);
  self notify(var_2);
}

func_1EC9(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = func_781C(var_3);
  var_7 = var_6["origin"];
  var_8 = var_6["angles"];
  thread func_1EAE(var_0, var_1, var_2, var_7, var_8, "generic", 1, var_4, var_5);
  var_0 func_1368A(var_2);
  self notify(var_2);
}

func_1EAF(var_0, var_1, var_2, var_3) {
  var_4 = [];
  var_4[0] = var_0;
  func_1EAB(var_4, var_1, var_2, var_3);
}

func_1EAD(var_0, var_1, var_2, var_3) {
  var_4 = [];
  var_4[0] = var_0;
  func_1EAC(var_4, var_1, var_2, var_3);
}

func_1EC3(var_0, var_1, var_2) {
  var_3 = [];
  var_3[0] = var_0;
  func_1EC1(var_3, var_1, var_2);
}

func_1EE0(var_0, var_1, var_2) {
  var_3 = [];
  var_3[0] = var_0;
  func_1EC1(var_3, var_1, var_2);
  func_1F2A(var_3, var_1, 1);
  var_4 = var_0 scripts\sp\utility::func_7DC1(var_1);
  var_5 = getmovedelta(var_4);
  var_6 = getangledelta3d(var_4);
  var_7 = rotatevector(var_5, var_0.angles);
  var_8 = var_0.origin + var_7;
  var_9 = combineangles(var_0.angles, var_6);
  if(isai(var_0)) {
    var_0 _meth_80F1(var_8, var_9, 9999);
    return;
  }

  if(isDefined(self.var_380)) {
    var_0 vehicle_teleport(var_8, var_9);
    var_0 dontinterpolate();
    return;
  }

  var_0.origin = var_8;
  var_0.angles = var_9;
  var_0 dontinterpolate();
}

func_23AE(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = self.var_1FBB;
  }

  var_2 = 0;
  if(isDefined(level.var_EC85[var_1])) {
    var_2 = 1;
    if(isDefined(level.var_EC85[var_1][var_0])) {
      return;
    }
  }

  var_3 = 0;
  if(isDefined(level.var_EC88[var_1])) {
    var_3 = 1;
    if(isDefined(level.var_EC88[var_1][var_0])) {
      return;
    }
  }

  var_4 = 0;
  if(isDefined(level.scr_sound[var_1])) {
    var_4 = 1;
    if(isDefined(level.scr_sound[var_1][var_0])) {
      return;
    }
  }

  if(var_2 || var_4 || var_3) {
    if(var_2) {
      var_5 = getarraykeys(level.var_EC85[var_1]);
      foreach(var_7 in var_5) {}
    }

    if(var_4) {
      var_5 = getarraykeys(level.scr_sound[var_1]);
      foreach(var_7 in var_5) {}
    }

    if(var_3) {
      var_5 = getarraykeys(level.var_EC88[var_1]);
      foreach(var_7 in var_5) {}
    }

    return;
  }

  var_0D = getarraykeys(level.var_EC85);
  var_0D = scripts\engine\utility::array_combine(var_0D, getarraykeys(level.scr_sound));
  foreach(var_0F in var_0D) {}
}

func_1EC2(var_0, var_1, var_2, var_3, var_4) {
  var_0.var_6DCC = gettime();
  var_5 = undefined;
  if(isDefined(var_4)) {
    var_5 = var_4;
  } else {
    var_5 = var_0.var_1FBB;
  }

  var_6 = 0;
  if(isarray(level.var_EC85[var_5][var_1])) {
    var_7 = level.var_EC85[var_5][var_1][0];
    var_6 = 1;
  } else {
    var_7 = level.var_EC85[var_6][var_2];
  }

  var_0 func_F5B0(var_1, var_2, var_3, var_5, var_6);
  if(isai(var_0)) {
    var_0.var_1286 = var_7;
    var_0.var_1180 = var_5;
    var_0 lib_0A1E::func_2307(::scripts\anim\first_frame::main);
    return;
  }

  var_0 givescorefortrophyblocks();
  var_0 setanimknob(var_7, 1, 0, 0);
}

func_1EAE(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  if(isai(var_0) && var_0 scripts\sp\utility::func_58DA()) {
    return;
  }

  var_9 = undefined;
  if(isDefined(var_5)) {
    var_9 = var_5;
  } else {
    var_9 = var_0.var_1FBB;
  }

  if(!isDefined(var_8) || !var_8) {
    var_0 func_F5B0(var_2, var_3, var_4, var_5, var_6);
  }

  var_0.var_117F = var_1;
  var_0.var_11BA = var_2;
  var_0.var_141C = self;
  var_0.var_117E = var_2;
  var_0.var_1180 = var_9;
  var_0.var_11BB = var_6;
  var_0.var_11BC = var_7;
  if(getdvarint("ai_iw7", 0) == 1) {
    var_0 lib_0A1E::func_2307(::scripts\anim\animmode::main, ::lib_0A1E::func_2385);
    return;
  }

  var_0 animcustom(::scripts\anim\animmode::main);
}

func_1EE7(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = [];
  foreach(var_8 in var_0) {
    var_9 = [];
    var_9["guy"] = var_8;
    var_9["entity"] = self;
    var_9["tag"] = var_3;
    var_9["origin_offset"] = var_4;
    var_6[var_6.size] = var_9;
  }

  func_1EE8(var_6, var_1, var_2, var_5);
}

func_1EE9(var_0, var_1, var_2, var_3) {
  var_4 = [];
  var_4[0] = var_0;
  func_1EE8(var_4, var_1, var_2, var_3);
}

func_1EE8(var_0, var_1, var_2, var_3) {
  foreach(var_5 in var_0) {
    var_6 = var_5["guy"];
    if(!isDefined(var_6)) {
      continue;
    }

    if(!isDefined(var_6.var_117C)) {
      var_6.var_117C = 0;
    }

    if(scripts\sp\utility::func_93A6() && isDefined(var_6.team) && var_6.team == "axis" && isDefined(var_6.unittype) && var_6.unittype == "soldier") {
      var_6.var_C05C = 1;
    }

    var_6 endon("death");
    var_6.var_117C++;
  }

  var_8 = var_0[0]["guy"];
  if(!isDefined(var_2)) {
    var_2 = "stop_loop";
  }

  thread func_6370(var_2, var_0);
  self endon(var_2);
  var_9 = "looping anim";
  var_0A = undefined;
  if(isDefined(var_3)) {
    var_0A = var_3;
  } else {
    var_0A = var_8.var_1FBB;
  }

  var_0B = 0;
  var_0C = 0;
  for(;;) {
    for(var_0B = func_1F60(var_0A, var_1); var_0B == var_0C && var_0B != 0; var_0B = func_1F60(var_0A, var_1)) {}

    var_0C = var_0B;
    var_0D = undefined;
    var_0E = 999999;
    var_0F = undefined;
    var_6 = undefined;
    foreach(var_23, var_5 in var_0) {
      var_11 = var_5["entity"];
      var_6 = var_5["guy"];
      var_12 = var_11 func_781C(var_5["tag"]);
      var_13 = var_12["origin"];
      var_14 = var_12["angles"];
      if(isDefined(var_5["origin_offset"])) {
        var_15 = var_5["origin_offset"];
        var_16 = anglesToForward(var_14);
        var_17 = anglestoright(var_14);
        var_18 = anglestoup(var_14);
        var_13 = var_13 + var_16 * var_15[0];
        var_13 = var_13 + var_17 * var_15[1];
        var_13 = var_13 + var_18 * var_15[2];
      }

      if(isDefined(var_6.var_E014)) {
        var_6.var_E014 = undefined;
        var_0[var_23] = undefined;
        continue;
      }

      var_19 = 0;
      var_1A = 0;
      var_1B = 0;
      var_1C = 0;
      var_1D = undefined;
      var_1E = undefined;
      var_1F = undefined;
      if(isDefined(var_3)) {
        var_1F = var_3;
      } else {
        var_1F = var_6.var_1FBB;
      }

      if(isDefined(level.var_EC88[var_1F]) && isDefined(level.var_EC88[var_1F][var_1]) && isDefined(level.var_EC88[var_1F][var_1][var_0B])) {
        var_19 = 1;
        var_1D = level.var_EC88[var_1F][var_1][var_0B];
      }

      if(isDefined(level.scr_sound[var_1F]) && isDefined(level.scr_sound[var_1F][var_1]) && isDefined(level.scr_sound[var_1F][var_1][var_0B])) {
        var_1A = 1;
        var_1E = level.scr_sound[var_1F][var_1][var_0B];
      }

      if(isDefined(level.var_EC86[var_1F]) && isDefined(level.var_EC86[var_1F][var_0B + var_1])) {
        var_6 playSound(level.var_EC86[var_1F][var_0B + var_1]);
      }

      if(isDefined(level.var_EC85[var_1F]) && isDefined(level.var_EC85[var_1F][var_1]) && !isai(var_6) || !var_6 scripts\sp\utility::func_58DA()) {
        var_1B = 1;
      }

      if(var_1B) {
        if(isDefined(level.var_EC89[var_1F]) && isDefined(level.var_EC89[var_1F][var_1])) {
          var_20 = level.var_EC89[var_1F][var_1];
        } else {
          var_20 = 0.2;
        }

        var_6 func_A888();
        var_21 = undefined;
        if(isai(var_6)) {
          var_21 = var_6 lib_0A1E::func_2356("Knobs", "body");
        } else if(isDefined(var_6.var_1ED4)) {
          var_21 = [
            [var_6.var_1ED4]
          ]();
        }

        var_6 animscripted(var_9, var_13, var_14, level.var_EC85[var_1F][var_1][var_0B], undefined, var_21, var_20);
        var_22 = getanimlength(level.var_EC85[var_1F][var_1][var_0B]);
        if(var_22 < var_0E) {
          var_0E = var_22;
          var_0D = var_23;
        }

        thread func_10CBF(var_6, var_9, var_1, var_1F, level.var_EC85[var_1F][var_1][var_0B]);
        thread func_1FCA(var_6, var_9, var_1);
      }

      if(var_19 || var_1A) {
        if(isai(var_6)) {
          if(var_1B) {
            var_6 scripts\anim\face::sayspecificdialogue(var_1E);
          } else {
            var_6 scripts\anim\face::sayspecificdialogue(var_1E, var_9);
          }
        } else {
          var_6 scripts\sp\utility::play_sound_on_entity(var_1E);
        }

        var_0F = var_23;
      }
    }

    if(!isDefined(var_6)) {
      break;
    }

    if(isDefined(var_0D)) {
      var_0[var_0D]["guy"] waittillmatch("end", var_9);
      continue;
    }

    if(isDefined(var_0F)) {
      var_0[var_0F]["guy"] waittill(var_9);
    }
  }
}

func_1F2F(var_0, var_1) {}

func_1F2E(var_0, var_1) {
  foreach(var_3 in var_0) {
    var_3 thread func_1F2F(self, var_1);
  }
}

func_1F2C(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_3)) {
    var_3 = 0;
  }

  func_1F31(var_0, var_1, var_2, var_3, var_4);
}

func_1F30(var_0, var_1, var_2) {
  foreach(var_4 in var_0) {
    var_4 scripts\sp\utility::func_5564();
  }

  func_1EAB(var_0, "gravity", var_1, var_2);
  foreach(var_4 in var_0) {
    if(isDefined(var_4) && isalive(var_4)) {
      var_4 scripts\sp\utility::func_6224();
    }
  }
}

func_1F33(var_0, var_1, var_2, var_3) {
  func_1F31(var_0, var_1, var_2, 0.25, var_3);
}

func_1F31(var_0, var_1, var_2, var_3, var_4) {
  var_5 = self;
  foreach(var_7 in var_0) {
    if(!isDefined(var_7)) {
      continue;
    }

    if(!isDefined(var_7.var_117C)) {
      var_7.var_117C = 0;
    }

    var_7.var_117C++;
  }

  var_9 = func_781C(var_2);
  var_0A = var_9["origin"];
  var_0B = var_9["angles"];
  var_0C = undefined;
  var_0D = 999999;
  var_0E = undefined;
  var_0F = undefined;
  var_10 = undefined;
  var_11 = undefined;
  var_12 = "single anim";
  foreach(var_22, var_7 in var_0) {
    var_14 = 0;
    var_15 = 0;
    var_16 = 0;
    var_17 = 0;
    var_18 = 0;
    var_19 = undefined;
    var_1A = undefined;
    var_1B = undefined;
    var_1C = undefined;
    if(isDefined(var_4)) {
      var_1C = var_4;
    } else {
      var_1C = var_7.var_1FBB;
    }

    if(isDefined(level.scr_sound[var_1C]) && isDefined(level.scr_sound[var_1C][var_1])) {
      var_16 = 1;
      var_19 = level.scr_sound[var_1C][var_1];
    }

    if(isDefined(level.var_EC88[var_1C]) && isDefined(level.var_EC88[var_1C][var_1])) {
      var_14 = 1;
      var_1A = level.var_EC88[var_1C][var_1];
      var_10 = var_1A;
      if(var_16) {
        if(animhasnotetrack(var_1A, "vo_" + var_19)) {
          var_16 = 0;
          var_19 = undefined;
        }
      }
    }

    if(isDefined(level.var_EC8A[var_1C]) && isDefined(level.var_EC8A[var_1C][var_1])) {
      var_15 = 1;
      var_1B = level.var_EC8A[var_1C][var_1];
      var_11 = var_1B;
    }

    if(isDefined(level.var_EC85[var_1C]) && isDefined(level.var_EC85[var_1C][var_1]) && !isai(var_7) || !var_7 scripts\sp\utility::func_58DA()) {
      var_17 = 1;
    }

    if(isDefined(level.var_EC86[var_1C]) && isDefined(level.var_EC86[var_1C][var_1])) {
      var_7 playSound(level.var_EC86[var_1C][var_1]);
    }

    if(var_17) {
      if(scripts\sp\utility::func_93A6() && isDefined(var_7.team) && var_7.team == "axis" && isDefined(var_7.unittype) && var_7.unittype == "soldier") {
        var_7.iscinematicplaying = 0;
      }

      if(isDefined(level.var_EC89[var_1C]) && isDefined(level.var_EC89[var_1C][var_1])) {
        var_1D = level.var_EC89[var_1C][var_1];
      } else {
        var_1D = 0.2;
      }

      var_7 func_A888();
      var_7.var_12FF = var_1;
      if(isplayer(var_7)) {
        var_1E = level.var_EC85[var_1C]["root"];
        var_7 give_attacker_kill_rewards(var_1E, 0, var_1D);
        var_1F = level.var_EC85[var_1C][var_1];
        var_7 _meth_82E1(var_12, var_1F, 1, var_1D);
      } else if(var_7.var_9F == "misc_turret") {
        var_1F = level.var_EC85[var_1C][var_1];
        var_7 _meth_82E1(var_12, var_1F, 1, var_1D);
      } else {
        var_20 = undefined;
        if(isai(var_7)) {
          var_20 = var_7 lib_0A1E::func_2356("Knobs", "body");
        } else if(isDefined(var_7.var_1ED4)) {
          var_20 = [
            [var_7.var_1ED4]
          ]();
        }

        if(isDefined(var_7.asm) && !isai(var_7)) {
          var_7 lib_0A1E::func_230A();
        }

        var_7 animscripted(var_12, var_0A, var_0B, level.var_EC85[var_1C][var_1], undefined, var_20, var_1D);
      }

      var_21 = getanimlength(level.var_EC85[var_1C][var_1]);
      if(var_21 < var_0D) {
        var_0D = var_21;
        var_0C = var_22;
      }

      thread func_10CBF(var_7, var_12, var_1, var_1C, level.var_EC85[var_1C][var_1]);
      thread func_1FCA(var_7, var_12, var_1);
    }

    if(var_14 || var_16) {
      if(var_14) {
        if(var_16) {
          var_7 thread scripts\anim\face::sayspecificdialogue(var_19);
        }

        thread func_1EBD(var_7, var_1, level.var_EC88[var_1C][var_1]);
        var_0F = var_22;
      } else if(isai(var_7) || isDefined(var_7.var_6B14) && var_7.var_6B14) {
        if(var_17) {
          var_7 scripts\anim\face::sayspecificdialogue(var_19);
        } else {
          var_7 thread func_1EBF("single dialogue");
          var_7 scripts\anim\face::sayspecificdialogue(var_19, "single dialogue");
        }
      } else {
        var_7 thread scripts\sp\utility::play_sound_on_entity(var_19, "single dialogue");
      }

      var_0E = var_22;
    }

    if(var_15) {
      var_7 thread func_CC70(var_7, var_11);
    }
  }

  if(isDefined(var_0C)) {
    var_23 = spawnStruct();
    var_23 thread func_1EB0(var_0[var_0C], var_1);
    var_23 thread func_1E9B(var_0[var_0C], var_1, var_0D, var_3);
    var_23 waittill(var_1);
  } else if(isDefined(var_0F)) {
    var_23 = spawnStruct();
    var_23 thread func_1EB0(var_0[var_0F], var_1);
    var_23 thread func_1EBE(var_0[var_0F], var_1, var_10);
    var_23 waittill(var_1);
  } else if(isDefined(var_0E)) {
    var_23 = spawnStruct();
    var_23 thread func_1EB0(var_0[var_0E], var_1);
    var_23 thread func_1EB1(var_0[var_0E], var_1);
    var_23 waittill(var_1);
  }

  foreach(var_7 in var_0) {
    if(!isDefined(var_7)) {
      continue;
    }

    if(isplayer(var_7)) {
      var_1C = undefined;
      if(isDefined(var_4)) {
        var_1C = var_4;
      } else {
        var_1C = var_7.var_1FBB;
      }

      if(isDefined(level.var_EC85[var_1C][var_1])) {
        var_1E = level.var_EC85[var_1C]["root"];
        var_7 give_attacker_kill_rewards(var_1E, 1, 0.2);
        var_1F = level.var_EC85[var_1C][var_1];
        var_7 clearanim(var_1F, 0.2);
      }
    }

    var_7.var_117C--;
    var_7.var_1300 = gettime();
  }

  self notify(var_1);
}

func_10CBF(var_0, var_1, var_2, var_3, var_4) {
  var_0 notify("stop_sequencing_notetracks");
  thread scripts\sp\anim::func_C0E1(var_0, var_1, self, var_2, var_3, var_4);
}

func_1EB0(var_0, var_1) {
  self endon(var_1);
  var_0 waittill("death");
  if(isDefined(var_0.var_1EDD) && var_0.var_1EDD) {
    return;
  }

  self notify(var_1);
}

func_1EBE(var_0, var_1, var_2) {
  self endon(var_1);
  var_3 = getanimlength(var_2);
  wait(var_3);
  self notify(var_1);
}

func_1EB1(var_0, var_1) {
  self endon(var_1);
  var_0 waittill("single dialogue");
  self notify(var_1);
}

func_1E9B(var_0, var_1, var_2, var_3) {
  self endon(var_1);
  var_0 endon("death");
  var_2 = var_2 - var_3;
  if(var_3 > 0 && var_2 > 0) {
    var_0 scripts\sp\utility::func_137A3("single anim", "end", var_2);
    var_0 givescorefortrophyblocks();
  } else {
    var_0 waittillmatch("end", "single anim");
  }

  self notify(var_1);
}

func_1FCA(var_0, var_1, var_2) {
  if(isDefined(var_0.var_5959) && var_0.var_5959) {
    return;
  }

  var_0 endon("stop_sequencing_notetracks");
  var_0 endon("death");
  var_0 scripts\anim\shared::donotetracks(var_1);
}

func_1F60(var_0, var_1) {
  var_2 = level.var_EC85[var_0][var_1].size;
  var_3 = randomint(var_2);
  if(var_2 > 1) {
    var_4 = 0;
    var_5 = 0;
    for(var_6 = 0; var_6 < var_2; var_6++) {
      if(isDefined(level.var_EC85[var_0][var_1 + "weight"])) {
        if(isDefined(level.var_EC85[var_0][var_1 + "weight"][var_6])) {
          var_4++;
          var_5 = var_5 + level.var_EC85[var_0][var_1 + "weight"][var_6];
        }
      }
    }

    if(var_4 == var_2) {
      var_7 = randomfloat(var_5);
      var_5 = 0;
      for(var_6 = 0; var_6 < var_2; var_6++) {
        var_5 = var_5 + level.var_EC85[var_0][var_1 + "weight"][var_6];
        if(var_7 < var_5) {
          var_3 = var_6;
          break;
        }
      }
    }
  }

  return var_3;
}

func_CC70(var_0, var_1) {
  var_0 _meth_82AC( % addtive_head_anims, 1, 0.2);
  var_0 _meth_82AC(var_1, 1, 0.2);
  wait(getanimlength(var_1));
  var_0 clearanim( % addtive_head_anims, 0.2);
  var_0 clearanim(var_1, 0.2);
}

func_1F0E(var_0, var_1, var_2, var_3, var_4) {
  thread func_1F0A(var_0, var_1, var_4);
  var_5 = spawnStruct();
  var_5.var_DD1F = 0;
  foreach(var_7 in var_0) {
    var_5.var_DD1F++;
    thread func_92E4(var_7, var_2, var_3, var_4, var_5);
  }

  for(;;) {
    var_5 waittill("reached_position");
    if(var_5.var_DD1F <= 0) {
      return;
    }
  }
}

func_135DC() {
  self endon("death");
  self waittill("anim_reach_complete");
}

func_92E4(var_0, var_1, var_2, var_3, var_4) {
  var_0 func_135DC();
  var_4.var_DD1F--;
  var_4 notify("reached_position");
  if(isalive(var_0)) {
    func_1EEA(var_0, var_1, var_2, var_3);
  }
}

func_781C(var_0) {
  var_1 = undefined;
  var_2 = undefined;
  if(isDefined(var_0)) {
    var_1 = self gettagorigin(var_0);
    var_2 = self gettagangles(var_0);
  } else {
    var_1 = self.origin;
    var_2 = self.angles;
  }

  var_3 = [];
  var_3["angles"] = var_2;
  var_3["origin"] = var_1;
  return var_3;
}

func_1F1A(var_0, var_1, var_2, var_3) {
  thread modify_moveplaybackrate_together(var_0);
  func_1F1B(var_0, var_1, var_2, var_3, ::func_DD14, ::func_DD15);
}

modify_moveplaybackrate_together(var_0) {
  var_1 = 0.3;
  waittillframeend;
  for(;;) {
    var_0 = scripts\sp\utility::func_DFEB(var_0);
    var_2 = [];
    var_3 = 0;
    foreach(var_8, var_5 in var_0) {
      var_6 = var_5.objective_playermask_hidefromall;
      if(isDefined(var_5.var_DD0B)) {
        var_6 = var_5.var_DD0B;
      }

      var_7 = distance(var_5.origin, var_6);
      var_2[var_5.unique_id] = var_7;
      if(var_7 <= 4) {
        var_0[var_8] = undefined;
        continue;
      }

      var_3 = var_3 + var_7;
    }

    if(var_0.size <= 1) {
      break;
    }

    var_3 = var_3 / var_0.size;
    foreach(var_5 in var_0) {
      var_0A = var_2[var_5.unique_id] - var_3;
      var_0B = var_0A * 0.003;
      if(var_0B > var_1) {
        var_0B = var_1;
      } else if(var_0B < var_1 * -1) {
        var_0B = var_1 * -1;
      }

      var_5 scripts\asm\asm::func_237B(1 + var_0B);
    }

    wait(0.05);
  }

  foreach(var_5 in var_0) {
    if(isalive(var_5)) {
      var_5 scripts\asm\asm::func_237B(1);
    }
  }
}

func_1F13(var_0, var_1) {
  if(isarray(var_0)) {
    foreach(var_3 in var_0) {
      thread func_1F13(var_3, var_1);
    }

    return;
  }

  var_3 = var_3;
  var_4 endon("new_anim_reach");
  wait(var_3);
  var_4 notify("goal");
}

func_1F0A(var_0, var_1, var_2, var_3) {
  if(scripts\sp\interaction::func_9C26(self)) {
    foreach(var_5 in var_0) {
      if(isDefined(self.var_EE92)) {
        var_5.asm.var_4C86.interaction = self.var_EE92;
        continue;
      }

      var_5.asm.var_4C86.interaction = self.script_noteworthy;
    }

    func_1F1B(var_0, var_1, var_2, var_3, ::func_DD0F, ::func_DD10);
    return;
  }

  func_1F1B(var_0, var_1, var_2, var_3, ::func_DD14, ::func_DD15);
}

func_1F1B(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = func_781C(var_2);
  var_8 = var_7["origin"];
  var_9 = var_7["angles"];
  var_0A = spawnStruct();
  var_0B = 0;
  var_0C = 0;
  foreach(var_0E in var_0) {
    if(isDefined(var_3)) {
      var_0F = var_3;
    } else {
      var_0F = var_0E.var_1FBB;
    }

    if(isDefined(level.var_EC85[var_0F][var_1])) {
      if(isarray(level.var_EC85[var_0F][var_1])) {
        var_10 = getstartorigin(var_8, var_9, level.var_EC85[var_0F][var_1][0]);
        var_11 = getstartangles(var_8, var_9, level.var_EC85[var_0F][var_1][0]);
      } else {
        var_10 = getstartorigin(var_8, var_9, level.var_EC85[var_0F][var_1]);
        var_11 = getstartangles(var_8, var_9, level.var_EC85[var_0F][var_1]);
      }
    } else {
      var_10 = var_8;
      var_11 = var_9;
    }

    if(isDefined(var_6)) {
      var_0E.physics_querypoint = spawn("script_origin", var_10);
      var_0E.physics_querypoint.angles = var_11;
      var_0E.physics_querypoint.type = var_6;
      var_0E.physics_querypoint.var_22EF = "stand";
      var_12 = var_0E getmovingplatformparent();
      if(isDefined(var_12)) {
        var_0E.physics_querypoint linkto(var_12);
      }
    }

    var_0C++;
    var_0E thread func_2A51(var_0A, var_10, var_11, var_4, var_5);
  }

  while(var_0C) {
    var_0A waittill("reach_notify");
    var_0C--;
  }

  foreach(var_15, var_0E in var_0) {
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

func_1F12(var_0) {
  if(!isalive(var_0)) {
    return;
  }

  if(isDefined(var_0.var_C3EE)) {
    var_0.objective_playermask_showto = var_0.var_C3EE;
  }

  if(isDefined(var_0.physics_querypoint)) {
    var_0.physics_querypoint delete();
  }

  var_0.spawncovernode = 0;
}

func_1F57(var_0, var_1, var_2) {
  var_3 = func_781C(var_2);
  var_4 = var_3["origin"];
  var_5 = var_3["angles"];
  foreach(var_7 in var_0) {
    var_8 = getstartorigin(var_4, var_5, level.var_EC85[var_7.var_1FBB][var_1]);
    var_9 = getstartangles(var_4, var_5, level.var_EC85[var_7.var_1FBB][var_1]);
    if(isai(var_7)) {
      var_7 _meth_83B9(var_8);
      continue;
    }

    var_7.origin = var_8;
    var_7.angles = var_9;
  }
}

func_1EEE(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = func_781C(var_2);
  var_7 = var_6["origin"];
  var_8 = var_6["angles"];
  foreach(var_0A in var_0) {
    var_0B = getstartorigin(var_7, var_8, level.var_EC85[var_0A.var_1FBB][var_1]);
    var_0C = getstartangles(var_7, var_8, level.var_EC85[var_0A.var_1FBB][var_1]);
    if(isai(var_0A)) {
      continue;
    }

    var_0A moveto(var_0B, var_3, var_4, var_5);
    var_0A rotateto(var_0C, var_3, var_4, var_5);
  }
}

func_1ED2(var_0, var_1, var_2) {
  var_3 = func_781C(var_2);
  var_4 = var_3["origin"];
  var_5 = var_3["angles"];
  var_6 = getstartorigin(var_4, var_5, level.var_EC85["generic"][var_1]);
  var_7 = getstartangles(var_4, var_5, level.var_EC85["generic"][var_1]);
  if(isai(var_0)) {
    var_0 _meth_83B9(var_6);
    return;
  }

  var_0.origin = var_6;
  var_0.angles = var_7;
}

func_1F41(var_0, var_1, var_2) {
  return func_1F42(var_0, "generic", var_1, var_2);
}

func_1F42(var_0, var_1, var_2, var_3) {
  var_4 = func_781C(var_3);
  var_5 = var_4["origin"];
  var_6 = var_4["angles"];
  var_7 = getstartorigin(var_5, var_6, level.var_EC85[var_1][var_2]);
  var_8 = getstartorigin(var_5, var_6, level.var_EC85[var_1][var_2]);
  var_9 = spawn("script_model", var_7);
  var_9 setModel(var_0);
  var_9.angles = var_8;
  return var_9;
}

func_1F44(var_0, var_1) {
  self attach(var_0, var_1);
}

func_1EE5(var_0, var_1) {
  var_2 = self gettagorigin(var_1);
  var_3 = spawn("script_model", var_2);
  var_3 setModel(var_0);
  var_3 linkto(self, var_1, (0, 0, 0), (0, 0, 0));
  return var_3;
}

func_1F45(var_0, var_1, var_2) {
  var_3 = func_781C(var_2);
  var_4 = var_3["origin"];
  var_5 = var_3["angles"];
  var_6 = spawnStruct();
  foreach(var_8 in var_0) {
    var_9 = getstartorigin(var_4, var_5, level.var_EC85[var_8.var_1FBB][var_1]);
    var_8.origin = var_9;
  }
}

func_DD08(var_0) {
  scripts\engine\utility::waittill_either("death", "goal");
  while(isalive(self) && isDefined(self.asm) && isDefined(self.asm.var_22F8)) {
    wait(0.05);
  }

  var_0 notify("reach_notify");
}

func_2A51(var_0, var_1, var_2, var_3, var_4) {
  self endon("death");
  self endon("new_anim_reach");
  thread func_DD08(var_0);
  var_1 = [[var_3]](var_1, var_2);
  scripts\sp\utility::func_F3DC(var_1);
  self.var_DD0B = var_1;
  self.objective_playermask_showto = 0;
  self.spawncovernode = squared(64);
  self waittill("goal");
  self notify("anim_reach_complete");
  [[var_4]]();
  self notify("new_anim_reach");
}

func_DD0F(var_0, var_1) {
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
  var_2 = scripts\sp\interaction::func_7A45(self.asm.var_4C86.interaction);
  if(!isDefined(var_2)) {
    var_2 = scripts\sp\interaction::func_7CA7(self.asm.var_4C86.interaction);
  }

  self.asm.var_4C86.var_22F1 = scripts\sp\interaction::func_7837(var_2);
  self.asm.var_4C86.var_22E3 = var_1;
  self.asm.var_4C86.var_92FA = scripts\sp\interaction::func_7A30(var_2);
  self.asm.var_4C86.var_22F6 = 1;
  if(isDefined(var_2.var_22E1)) {
    self.asm.var_4C86.var_4C38 = var_2.var_22E1;
  }

  return var_0;
}

func_DD14(var_0, var_1) {
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
    self.physics_querypoint.angles = var_1;
    self.physics_querypoint.origin = var_0;
  }

  self.var_DD0B = undefined;
  return var_0;
}

func_DD10() {
  func_1EA8(0);
  self.target_set = 0;
  self.logstring = self.var_6E04;
  self.var_6E04 = undefined;
  self.vectortoyaw = self.var_C3FD;
  self.vehicle_getarray = self.var_C3FE;
  self.disablearrivals = self.var_C3B9;
  var_0 = scripts\sp\interaction::func_7A45(self.asm.var_4C86.interaction);
  if(!isDefined(var_0)) {
    var_0 = scripts\sp\interaction::func_7CA7(self.asm.var_4C86.interaction);
  }

  self.asm.var_4C86.var_697F = scripts\sp\interaction::func_79A5(var_0);
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

func_1EA8(var_0) {
  if(isDefined(self.var_5954)) {
    return;
  }

  self _meth_8250(var_0);
}

func_DD11(var_0, var_1) {
  var_0 = func_DD14(var_0, var_1);
  self.disablearrivals = 0;
  return var_0;
}

func_DD12(var_0, var_1) {
  var_2 = self _meth_811F(var_0);
  var_0 = var_2;
  var_0 = func_DD14(var_0, var_1);
  self.disablearrivals = 1;
  return var_0;
}

func_DD13(var_0, var_1) {
  var_2 = self _meth_811F(var_0);
  var_0 = var_2;
  var_0 = func_DD14(var_0, var_1);
  self.disablearrivals = 0;
  return var_0;
}

func_F64A() {
  self glinton(level.var_EC87[self.var_1FBB]);
}

func_1F35(var_0, var_1, var_2, var_3, var_4) {
  self endon("death");
  var_5[0] = var_0;
  if(!isDefined(var_3)) {
    var_3 = 0;
  }

  func_1F2C(var_5, var_1, var_2, var_3, var_4);
}

func_1F37(var_0, var_1, var_2) {
  self endon("death");
  var_3[0] = var_0;
  func_1F2C(var_3, var_1, var_2, 0.25);
}

func_1F34(var_0, var_1, var_2, var_3) {
  self endon("death");
  var_4[0] = var_0;
  func_1F2C(var_4, var_1, var_2, 0.25);
}

func_1F0F(var_0, var_1, var_2, var_3, var_4) {
  self endon("death");
  var_5[0] = var_0;
  func_1F0E(var_5, var_1, var_2, var_3, var_4);
}

func_1F17(var_0, var_1, var_2) {
  self endon("death");
  var_3[0] = var_0;
  func_1F0A(var_3, var_1, var_2);
}

func_1F0D(var_0, var_1, var_2, var_3) {
  self endon("death");
  var_4[0] = var_0;
  func_1F0B(var_4, var_1, var_2, var_3);
}

func_1F0C(var_0, var_1, var_2, var_3, var_4) {
  self endon("death");
  var_5[0] = var_0;
  var_6 = func_781C(var_2);
  var_7 = var_6["origin"];
  var_8 = var_6["angles"];
  var_9 = var_0.var_1FBB;
  if(isDefined(level.var_EC85[var_9][var_1])) {
    if(isarray(level.var_EC85[var_9][var_1])) {
      var_0A = level.var_EC85[var_9][var_1][0];
    } else {
      var_0A = level.var_EC85[var_0A][var_2];
    }

    var_7 = getstartorigin(var_7, var_8, var_0A);
    var_8 = getstartorigin(var_7, var_8, var_0A);
  }

  var_0B = spawn("script_origin", var_7);
  var_0B.angles = var_8;
  if(isDefined(var_3)) {
    var_0B.type = var_3;
  } else {
    var_0B.type = self.type;
  }

  if(isDefined(var_4)) {
    var_0B.var_22EF = var_4;
  } else {
    var_0B.var_22EF = self gethighestnodestance();
  }

  var_0.physics_querypoint = var_0B;
  func_1F0B(var_5, var_1, var_2);
  var_0.physics_querypoint = undefined;
  var_0B delete();
  while(var_0.a.movement != "stop") {
    wait(0.05);
  }
}

func_1F0B(var_0, var_1, var_2, var_3) {
  self endon("death");
  if(scripts\sp\interaction::func_9C26(self)) {
    foreach(var_5 in var_0) {
      if(isDefined(self.script_noteworthy)) {
        var_5.asm.var_4C86.interaction = self.script_noteworthy;
        continue;
      }

      var_5.asm.var_4C86.interaction = self.var_EE92;
    }

    func_1F1B(var_0, var_1, var_2, undefined, ::func_DD0F, ::func_DD10, var_3);
    return;
  }

  if(!isDefined(var_3)) {
    var_3 = "Exposed";
  }

  func_1F1B(var_0, var_1, var_2, undefined, ::func_DD11, ::func_DD15, var_3);
}

func_1EEA(var_0, var_1, var_2, var_3, var_4, var_5) {
  self endon("death");
  var_0 endon("death");
  var_6[0] = var_0;
  func_1EE7(var_6, var_1, var_2, var_3, var_4, var_5);
}

func_1F58(var_0, var_1, var_2) {
  self endon("death");
  var_3[0] = var_0;
  func_1F57(var_3, var_1, var_2);
}

func_1696(var_0, var_1) {
  if(!isDefined(level.var_4483)) {
    level.var_4483[var_0][0] = var_1;
    return;
  }

  if(!isDefined(level.var_4483[var_0])) {
    level.var_4483[var_0][0] = var_1;
    return;
  }

  for(var_2 = 0; var_2 < level.var_4483[var_0].size; var_2++) {
    if(level.var_4483[var_0][var_2] == var_1) {
      return;
    }
  }

  level.var_4483[var_0][level.var_4483[var_0].size] = var_1;
}

func_1F32(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_3)) {
    var_3 = 0;
  }

  if(isDefined(var_0.var_A8F8)) {
    scripts\sp\utility::func_135AF(var_0.var_A8F8, 0.5);
  }

  scripts\sp\utility::func_74D7(::func_1F35, var_0, var_1, var_2, var_3);
  if(isalive(var_0)) {
    var_0.var_A8F8 = gettime();
  }
}

func_1ECD(var_0, var_1, var_2, var_3, var_4) {
  var_0 endon("death");
  if(!isDefined(var_3)) {
    var_3 = 0;
  }

  if(isDefined(var_0.var_A8F8)) {
    scripts\sp\utility::func_135AF(var_0.var_A8F8, 0.5);
  }

  if(isDefined(var_4)) {
    scripts\sp\utility::func_74DD(var_4, ::func_1F35, var_0, var_1, var_2, var_3, "generic");
  } else {
    scripts\sp\utility::func_74D7(::func_1F35, var_0, var_1, var_2, var_3, "generic");
  }

  if(isalive(var_0)) {
    var_0.var_A8F8 = gettime();
  }
}

func_1EB3(var_0) {
  foreach(var_2 in var_0) {
    var_2 _meth_8250(0);
  }
}

func_1F08(var_0) {
  foreach(var_2 in var_0) {
    var_2 _meth_8250(1);
  }
}

func_E140(var_0, var_1, var_2, var_3, var_4) {
  var_1 = tolower(var_1);
  var_5 = level.var_EC8D[var_0][var_2][var_1];
  var_2 = func_79E4(var_2);
  var_6 = -1;
  if(!isDefined(var_5) || !isarray(var_5) || var_5.size < 1) {
    return;
  }

  for(var_7 = 0; var_7 < var_5.size; var_7++) {
    if(isDefined(var_5[var_7][var_3])) {
      if(!isDefined(var_4) || var_5[var_7][var_3] == var_4) {
        var_6 = var_7;
        break;
      }
    }
  }

  if(var_6 < 0) {
    return;
  }

  if(var_5.size == 1) {
    var_5 = [];
  } else {
    var_5 = scripts\sp\utility::array_remove_index(var_5, var_6);
  }

  level.var_EC8D[var_0][var_2][var_1] = var_5;
}

func_17F9(var_0, var_1, var_2, var_3) {
  var_1 = tolower(var_1);
  var_2 = func_79E4(var_2);
  var_4 = func_1720(var_0, var_1, var_2);
  level.var_EC8D[var_0][var_2][var_1][var_4] = [];
  level.var_EC8D[var_0][var_2][var_1][var_4]["dialog"] = var_3;
}

func_1720(var_0, var_1, var_2) {
  var_1 = tolower(var_1);
  func_1721(var_0, var_1, var_2);
  return level.var_EC8D[var_0][var_2][var_1].size;
}

func_1721(var_0, var_1, var_2) {
  var_1 = tolower(var_1);
  if(!isDefined(level.var_EC8D)) {
    level.var_EC8D = [];
  }

  if(!isDefined(level.var_EC8D[var_0])) {
    level.var_EC8D[var_0] = [];
  }

  if(!isDefined(level.var_EC8D[var_0][var_2])) {
    level.var_EC8D[var_0][var_2] = [];
  }

  if(!isDefined(level.var_EC8D[var_0][var_2][var_1])) {
    level.var_EC8D[var_0][var_2][var_1] = [];
  }
}

func_17FF(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_1 = tolower(var_1);
  var_2 = func_79E4(var_2);
  var_6 = func_1720(var_0, var_1, var_2);
  level.var_EC8D[var_0][var_2][var_1][var_6] = [];
  level.var_EC8D[var_0][var_2][var_1][var_6]["sound"] = var_3;
  if(isDefined(var_4)) {
    level.var_EC8D[var_0][var_2][var_1][var_6]["sound_stays_death"] = 1;
  }

  if(isDefined(var_5)) {
    level.var_EC8D[var_0][var_2][var_1][var_6]["sound_on_tag"] = var_5;
  }
}

func_C0BB(var_0, var_1, var_2, var_3) {
  var_4 = func_7926();
  func_17FF(var_4.var_1FBB, var_0, var_4.var_1F24, var_1, var_2, var_3);
}

func_17FE(var_0, var_1, var_2, var_3) {
  var_1 = tolower(var_1);
  var_2 = func_79E4(var_2);
  var_4 = func_1720(var_0, var_1, var_2);
  level.var_EC8D[var_0][var_2][var_1][var_4] = [];
  level.var_EC8D[var_0][var_2][var_1][var_4]["playersound"] = var_3;
}

func_79E4(var_0) {
  if(!isDefined(var_0)) {
    return "any";
  }

  return var_0;
}

func_1806(var_0, var_1, var_2) {
  if(!isDefined(level.var_EC86[var_0])) {
    level.var_EC86[var_0] = [];
  }

  level.var_EC86[var_0][var_1] = var_2;
}

func_17FD(var_0, var_1, var_2, var_3) {
  var_1 = tolower(var_1);
  var_2 = func_79E4(var_2);
  var_4 = func_1720(var_0, var_1, var_2);
  level.var_EC8D[var_0][var_2][var_1][var_4] = [];
  level.var_EC8D[var_0][var_2][var_1][var_4]["playerdialogue"] = var_3;
}

func_17F4(var_0, var_1, var_2, var_3) {
  var_2 = tolower(var_2);
  var_1 = func_79E4(var_1);
  var_4 = func_1720(var_0, var_2, var_1);
  var_5 = [];
  var_5["sound"] = var_3;
  var_5["created_by_animSound"] = 1;
  level.var_EC8D[var_0][var_1][var_2][var_4] = var_5;
}

func_17F5(var_0, var_1, var_2, var_3, var_4) {
  var_1 = tolower(var_1);
  var_4 = func_79E4(var_4);
  var_5 = func_1720(var_0, var_1, var_4);
  var_6 = [];
  var_6["attach model"] = var_2;
  var_6["selftag"] = var_3;
  level.var_EC8D[var_0][var_4][var_1][var_5] = var_6;
}

func_17F7(var_0, var_1, var_2, var_3, var_4) {
  var_1 = tolower(var_1);
  var_4 = func_79E4(var_4);
  var_5 = func_1720(var_0, var_1, var_4);
  var_6 = [];
  var_6["detach model"] = var_2;
  var_6["selftag"] = var_3;
  level.var_EC8D[var_0][var_4][var_1][var_5] = var_6;
}

func_17F8(var_0, var_1, var_2, var_3) {
  var_1 = tolower(var_1);
  var_2 = func_79E4(var_2);
  var_4 = func_1720(var_0, var_1, var_2);
  var_5 = [];
  var_5["detach gun"] = 1;
  var_5["tag"] = "tag_weapon_right";
  if(isDefined(var_3)) {
    var_5["suspend"] = var_3;
  }

  level.var_EC8D[var_0][var_2][var_1][var_4] = var_5;
}

func_17F6(var_0, var_1, var_2, var_3) {
  var_1 = tolower(var_1);
  var_3 = func_79E4(var_3);
  var_4 = func_1720(var_0, var_1, var_3);
  var_5 = [];
  var_5["function"] = var_2;
  level.var_EC8D[var_0][var_3][var_1][var_4] = var_5;
}

func_1800(var_0, var_1, var_2, var_3, var_4, var_5) {
  scripts\engine\utility::getfx(var_3);
  var_1 = tolower(var_1);
  var_2 = func_79E4(var_2);
  var_6 = func_1720(var_0, var_1, var_2);
  var_7 = [];
  var_7["effect"] = var_3;
  var_7["selftag"] = var_4;
  if(isDefined(var_5)) {
    var_7["moreThanThreeHack"] = var_5;
  }

  level.var_EC8D[var_0][var_2][var_1][var_6] = var_7;
}

func_1801(var_0, var_1, var_2, var_3, var_4) {
  scripts\engine\utility::getfx(var_3);
  var_1 = tolower(var_1);
  var_2 = func_79E4(var_2);
  var_5 = func_1720(var_0, var_1, var_2);
  var_6 = [];
  var_6["stop_effect"] = var_3;
  var_6["selftag"] = var_4;
  level.var_EC8D[var_0][var_2][var_1][var_5] = var_6;
}

func_C0BD(var_0, var_1, var_2) {
  var_3 = func_7926();
  scripts\engine\utility::add_fx(var_1, var_1);
  func_1802(var_3.var_1FBB, var_0, var_3.var_1FCF, var_1, var_2);
}

func_C0BC(var_0, var_1, var_2) {
  var_3 = func_7926();
  scripts\engine\utility::add_fx(var_1, var_1);
  func_1801(var_3.var_1FBB, var_0, var_3.var_1FCF, var_1, var_2);
}

func_1802(var_0, var_1, var_2, var_3, var_4) {
  scripts\engine\utility::getfx(var_3);
  var_1 = tolower(var_1);
  var_2 = func_79E4(var_2);
  var_5 = func_1720(var_0, var_1, var_2);
  var_6 = [];
  var_6["swap_part_to_efx"] = var_3;
  var_6["selftag"] = var_4;
  level.var_EC8D[var_0][var_2][var_1][var_5] = var_6;
}

func_C0BE(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = func_7926();
  if(var_0 != "start" && !animhasnotetrack(var_6 scripts\sp\utility::func_7DC1(var_6.var_1F24), var_0)) {
    return;
  }

  scripts\engine\utility::add_fx(var_3, var_3);
  if(isDefined(var_4)) {
    scripts\engine\utility::add_fx(var_4, var_4);
  }

  func_1803(var_6.var_1FBB, var_0, var_1, var_6.var_1F24, var_2, var_3, var_4, var_5);
}

func_C0BA(var_0, var_1, var_2) {
  var_3 = func_7926();
  if(var_0 != "start" && !animhasnotetrack(var_3 scripts\sp\utility::func_7DC1(var_3.var_1F24), var_0)) {
    return;
  }

  scripts\engine\utility::add_fx(var_2, var_2);
  func_1800(var_3.var_1FBB, var_0, var_3.var_1F24, var_2, var_1, 1);
}

func_7926() {
  var_0 = level.var_4B3E;
  return var_0;
}

func_1803(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  scripts\engine\utility::getfx(var_5);
  var_1 = tolower(var_1);
  var_3 = func_79E4(var_3);
  var_8 = func_1720(var_0, var_1, var_3);
  var_9 = [];
  var_9["trace_part_for_efx"] = var_5;
  var_9["trace_part_for_efx_water"] = var_6;
  var_9["trace_part_for_efx_cancel"] = var_2;
  var_9["trace_part_for_efx_delete_depth"] = var_7;
  var_9["selftag"] = var_4;
  level.var_EC8D[var_0][var_3][var_1][var_8] = var_9;
  if(isDefined(var_2)) {
    var_9 = [];
    var_9["trace_part_for_efx_canceling"] = var_2;
    var_9["selftag"] = var_4;
    var_8 = func_1720(var_0, var_2, var_3);
    level.var_EC8D[var_0][var_3][var_2][var_8] = var_9;
  }
}

func_17FA(var_0, var_1, var_2, var_3) {
  var_1 = tolower(var_1);
  var_3 = func_79E4(var_3);
  var_4 = func_1720(var_0, var_1, var_3);
  var_5 = [];
  var_5["flag"] = var_2;
  level.var_EC8D[var_0][var_3][var_1][var_4] = var_5;
  if(!isDefined(level.flag) || !isDefined(level.flag[var_2])) {
    scripts\engine\utility::flag_init(var_2);
  }
}

func_17FB(var_0, var_1, var_2, var_3) {
  var_1 = tolower(var_1);
  var_3 = func_79E4(var_3);
  var_4 = func_1720(var_0, var_1, var_3);
  var_5 = [];
  var_5["flag_clear"] = var_2;
  level.var_EC8D[var_0][var_3][var_1][var_4] = var_5;
  if(!isDefined(level.flag) || !isDefined(level.flag[var_2])) {
    scripts\engine\utility::flag_init(var_2);
  }
}

func_17FC(var_0, var_1, var_2, var_3) {
  var_1 = tolower(var_1);
  var_3 = func_79E4(var_3);
  var_4 = func_1720(var_0, var_1, var_3);
  var_5 = [];
  var_5["notify"] = var_2;
  level.var_EC8D[var_0][var_3][var_1][var_4] = var_5;
}

func_55C7(var_0) {
  if(!isDefined(self.var_8C7E)) {
    self.var_8C7E = lib_0A1E::func_2356("Knobs", "head");
  }

  if(!isDefined(var_0) || var_0) {
    scripts\sp\utility::func_F6FE("vignette");
    self clearanim(self.var_8C7E, 0.2);
    self.facialidx = undefined;
    return;
  }

  scripts\sp\utility::func_41AD("vignette");
}

func_1EBD(var_0, var_1, var_2) {
  var_0 endon("death");
  self endon(var_1);
  var_3 = 0.05;
  var_0 notify("newLookTarget");
  func_55C7();
  waittillframeend;
  if(!isDefined(self.var_EF82)) {
    self.var_EF82 = lib_0A1E::func_2356("Knobs", "scripted_talking");
  }

  var_4 = "scripted_face_" + var_1;
  var_0 give_attacker_kill_rewards(self.var_EF82, 5, 0.2);
  var_0 _meth_82E7(var_4, var_2, 1, 0, 1);
  thread scripts\sp\anim::func_6A85(var_0, var_4, var_1);
  thread func_41AC(var_0, var_4, var_1);
}

func_1EBF(var_0, var_1) {
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

  var_2 = 0.05;
  self notify("newLookTarget");
  self endon("newLookTarget");
  waittillframeend;
  if(!isDefined(var_1) && isDefined(self.var_299D)) {
    var_1 = self.var_299D;
  }

  var_3 = "";
  if(isDefined(self.asm)) {
    var_3 = self.asm.archetype;
  }

  if(isDefined(self.var_1FA8)) {
    var_3 = self.var_1FA8;
  }

  var_4 = self.var_504D;
  var_5 = self.var_EF82;
  if(var_3 != "") {
    var_5 = lib_0A1E::func_2356("Knobs", "head");
    var_4 = _func_2EF(var_3, "facial_animation", "facial_talk", 0);
  }

  scripts\sp\utility::func_F6FE("filler");
  self _meth_82AA(var_4, 1, 0, 1);
  self give_attacker_kill_rewards(var_5, 5, 0.267);
  func_F5BE(var_0, var_4, var_5);
  var_2 = 0.3;
  self clearanim(var_5, 0.2);
  scripts\sp\utility::func_41AD("filler");
}

func_F5BE(var_0, var_1, var_2) {
  self waittill(var_0);
}

func_11497(var_0) {
  self endon("death");
  var_1 = self.var_504D;
  self _meth_82AA(var_1, 1, 0, 1);
  self give_attacker_kill_rewards(self.var_EF82, 5, 0.4);
  func_55C7();
  wait(var_0);
  var_2 = 0.3;
  self clearanim(self.var_EF82, 0.2);
  func_55C7(0);
}

getyawangles(var_0, var_1) {
  var_2 = var_0[1] - var_1[1];
  var_2 = angleclamp180(var_2);
  return var_2;
}

func_B022(var_0, var_1) {
  self notify("lookline");
  self endon("lookline");
  self endon(var_1);
  self endon("death");
  wait(0.05);
}

func_1F14(var_0, var_1, var_2) {
  var_3 = spawnStruct();
  var_3.var_C1 = var_0.size;
  foreach(var_5 in var_0) {
    thread func_DD20(var_5, var_1, var_2, var_3);
  }

  while(var_3.var_C1) {
    var_3 waittill("reached_goal");
  }

  self notify("stopReachIdle");
}

func_DD20(var_0, var_1, var_2, var_3) {
  func_1F17(var_0, var_1);
  var_3.var_C1--;
  var_3 notify("reached_goal");
  if(var_3.var_C1 > 0) {
    func_1EEA(var_0, var_2, "stopReachIdle");
  }
}

func_41AC(var_0, var_1, var_2) {
  var_0 endon("death");
  var_0 waittillmatch("end", var_1);
  var_0 notify("scripted_face_done");
  var_3 = 0.3;
  var_0 clearanim(self.var_EF82, 0.2);
  func_55C7(0);
}

func_1F50(var_0, var_1, var_2) {
  var_3 = func_781C(var_2);
  var_4 = var_3["origin"];
  var_5 = var_3["angles"];
  scripts\engine\utility::array_thread(var_0, ::func_F5B0, var_1, var_4, var_5);
}

func_1F51(var_0, var_1, var_2) {
  var_3[0] = var_0;
  func_1F50(var_3, var_1, var_2);
}

func_F5B0(var_0, var_1, var_2, var_3, var_4) {
  var_5 = undefined;
  if(isDefined(var_3)) {
    var_5 = var_3;
  } else {
    var_5 = self.var_1FBB;
  }

  if(isDefined(var_4) && var_4) {
    var_6 = level.var_EC85[var_5][var_0][0];
  } else {
    var_6 = level.var_EC85[var_6][var_1];
  }

  if(isai(self)) {
    var_7 = getstartorigin(var_1, var_2, var_6);
    var_8 = getstartangles(var_1, var_2, var_6);
    if(isDefined(self.var_1F4E)) {
      var_7 = scripts\sp\utility::func_864C(var_7);
    }

    self _meth_80F1(var_7, var_8);
    return;
  }

  if(self.var_9F == "script_vehicle") {
    self vehicle_teleport(getstartorigin(var_1, var_2, var_6), getstartangles(var_1, var_2, var_6));
    return;
  }

  self.origin = getstartorigin(var_1, var_2, var_6);
  self.angles = getstartangles(var_1, var_2, var_6);
}

func_1E9F(var_0, var_1) {
  var_2 = [];
  var_2["guy"] = self;
  var_2["entity"] = self;
  return var_2;
}

func_1E9E(var_0, var_1) {
  var_2 = [];
  var_2["guy"] = self;
  var_2["entity"] = var_0;
  var_2["tag"] = var_1;
  return var_2;
}

func_1F29(var_0, var_1, var_2) {
  var_0 thread func_1F28(var_1, var_2);
}

func_1F27(var_0, var_1, var_2) {
  scripts\engine\utility::array_thread(var_0, ::func_1F28, var_1, var_2);
}

func_1F28(var_0, var_1, var_2) {
  var_3 = undefined;
  if(isDefined(var_2)) {
    var_3 = var_2;
  } else {
    var_3 = self.var_1FBB;
  }

  self _meth_82E1("single anim", scripts\sp\utility::func_7DC2(var_0, var_3), 1, 0, var_1);
}

func_1F2A(var_0, var_1, var_2) {
  scripts\engine\utility::array_thread(var_0, ::func_1F23, var_1, var_2);
}

func_1F23(var_0, var_1) {
  var_2 = scripts\sp\utility::func_7DC1(var_0);
  self _meth_82B0(var_2, var_1);
}

func_A888() {
  if(!isDefined(self.var_A887)) {
    self.var_A887 = gettime();
    return;
  }

  var_0 = gettime();
  if(self.var_A887 == var_0) {
    self endon("death");
    wait(0.05);
  }

  self.var_A887 = var_0;
}

func_F325(var_0, var_1) {
  var_0.custommovetransition = ::scripts\anim\cover_arrival::custommovetransitionfunc;
  var_0.var_10DCB = level.var_EC85[var_0.var_1FBB][var_1];
}

func_489E(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_3)) {
    var_3 = "generic";
  } else {
    level.var_EC87[var_3] = var_0;
  }

  var_5 = spawnStruct();
  var_5.var_1FEC = var_0;
  var_5.model = var_4;
  if(isDefined(var_4)) {
    level.var_EC8C[var_3] = var_4;
  }

  if(isDefined(var_2)) {
    level.var_EC85[var_3][var_1] = var_2;
  }

  var_5.var_1FBB = var_3;
  var_5.var_1F24 = var_1;
  level.var_4B3E = var_5;
}

func_2B8C(var_0, var_1, var_2, var_3) {
  var_0.var_1E9D = var_2;
  var_0.var_6317 = var_3;
  var_0.var_77A3 = var_1;
  var_0.var_1FBD = self;
  var_0 lib_0A1E::func_2307(::lib_0C4C::func_2B8A, ::lib_0C4C::func_2B8B);
}

func_2B87(var_0, var_1, var_2) {
  while(isDefined(var_0.var_1E9D)) {
    wait(0.05);
  }

  var_0.var_1E9D = var_2;
  var_0.var_77A3 = var_1;
  var_0.var_1FBD = self;
  var_0 lib_0A1E::func_2307(::lib_0C4C::func_2B86);
}