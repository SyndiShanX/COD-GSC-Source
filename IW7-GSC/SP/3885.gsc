/************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: SP\3885.gsc
************************/

func_1355D() {
  precachemodel("vr_unfold_left_rig");
  precachemodel("vr_unfold_right_rig");
  lib_0F30::main();
  lib_0F2E::main();
  if(isDefined(level.var_13567)) {
    scripts\engine\utility::flag_wait(level.var_13567);
  }

  scripts\sp\utility::func_9189("default_vroutline", -1, "default");
  level.func["player_grenade_thrown"] = ::func_13566;
  scripts\sp\utility::func_22C9("vr_enemy_human", ::func_D70F);
  lib_0F2F::main();
}

func_661E(param_00) {
  setomnvar("ui_in_vr", 1);
  setomnvar("ui_close_vr_pause_menu", 0);
  scripts\engine\utility::flag_set("in_vr_mode");
  level.var_93A9 = 1;
  level.var_116D8.var_13558 = 1;
  level thread func_13598();
  level thread func_F61F();
  scripts\sp\outline::func_91A1("default", ::func_1356B);
  level thread func_6DA9(param_00);
}

func_1356B() {
  var_00["r_hudoutlineWidth"] = 3;
  var_00["cg_hud_outline_colors_5"] = "0.122 0.235 0.425 0.500";
  return var_00;
}

func_6DA9(param_00) {
  level endon("reset_vr");
  var_01 = undefined;
  var_02 = level.var_13563.var_E546[1].segments[0];
  var_03 = scripts\engine\utility::array_remove(level.var_13563.var_E546[1].segments, var_02);
  level thread func_A5D0();
  if(param_00) {
    func_9AD8();
  } else {
    func_9AD6();
  }

  for(var_04 = 0; var_04 < 3; var_04++) {
    func_669D(var_02, var_03, var_04);
    level thread func_2F0A(1);
    level thread func_4D96(level.var_13563.var_BF5A.var_CBFA.origin, 1);
    wait(0.75);
    func_106C8(level.var_13563.var_BF5A, var_04);
    func_A62A();
    func_12B92();
    wait(1.75);
    func_6B73(level.var_13563.var_BF5A, 0);
    level thread func_2F0A(0);
    var_05 = level.var_13563.var_BF5A.var_CBFA.origin + anglestoright(level.var_13563.var_BF5A.var_CBFA.angles) * -1792;
    level thread func_4D96(var_05, 0, 1, 1);
    var_03 = scripts\engine\utility::array_remove(var_03, level.var_13563.var_BF5A);
    var_02 = level.var_13563.var_BF5A;
  }

  wait(0.5);
  level.player playSound("vr_course_complete");
  func_DFED();
  wait(0.5);
  level.player playSound("shipcrib_hud_complete_simulation");
  wait(2);
  scripts\sp\utility::func_56BA("vr_tut_leave");
  level thread scripts\engine\utility::flag_set_delayed("vr_tutorial_leave_shown", 5);
}

func_9AD8() {
  level endon("reset_vr");
  scripts\engine\utility::flag_set("vr_delete_thrown_grenades");
  var_00 = level.var_13563.var_E546;
  var_01 = level.var_13563.var_E546[1].segments[0];
  level.var_13563.var_9B3D hide();
  foreach(var_03 in var_00) {
    var_04 = anglesToForward(var_03.angles) * 9408;
    var_05 = anglestoright(var_03.angles) * 608;
    var_03.origin = var_03.start_pos + var_04 + var_05;
    var_03 thread func_E53E("passive", 1, undefined, 1);
    level notify("vr_ring" + var_03.var_EDD5 + "_intro_show_geo");
    foreach(var_07 in var_03.var_466A) {
      var_07 show();
    }

    foreach(var_0A in var_03.segments) {
      if(isDefined(var_0A.var_6E86)) {
        var_0A.var_6E86 show();
      }

      var_0A show();
    }

    if(var_03 == level.var_13563.var_E546[1]) {
      continue;
    }

    var_03 rotateroll(90, 0.05);
  }

  scripts\engine\utility::waitframe();
  foreach(var_0A in level.var_13563.var_E546[0].segments) {
    var_0A.var_6E86 unlink();
    var_0A.var_6E86 rotateroll(-90, 0.05);
  }

  wait(1);
  level.player playSound("scn_vr_rotate_90");
  level.var_13563.var_E546[1] func_E53E("active");
  var_0F = 1.5;
  var_10 = 0.35;
  level.var_13563.var_E546[1] rotateroll(90, var_0F, var_10, var_10);
  wait(var_0F + 0.1);
  level.var_13563.var_E546[1] func_E53E("passive");
  level.var_13563.var_2F09.origin = var_01.var_CBFA.origin;
  foreach(var_12 in level.var_13563.var_4D95) {
    var_12.origin = var_01.var_CBFA.origin + anglestoright(var_01.var_CBFA.angles) * -1792;
  }

  scripts\engine\utility::flag_clear("vr_delete_thrown_grenades");
  wait(0.25);
}

func_9AD6() {
  level endon("reset_vr");
  scripts\engine\utility::flag_set("vr_delete_thrown_grenades");
  var_00 = level.var_13563.var_E546;
  var_01 = level.var_13563.var_E546[1].segments[0];
  wait(1);
  level.player playSound("shipcrib_hud_loading_simulation");
  for(var_02 = 0; var_02 < var_00.size; var_02++) {
    if(var_02 == 0) {
      var_00[var_02] playSound("scn_vr_enter");
    }

    var_00[var_02] thread func_E539();
    wait(0.25);
  }

  var_00[var_00.size - 1] waittill("vr_intro_part1");
  for(var_02 = 0; var_02 < var_00.size; var_02++) {
    var_03 = 608;
    var_04 = 1.5;
    var_05 = 0.35;
    if(var_02 == 0) {
      var_06 = level.var_13563.var_9B3D;
      var_06 thread func_3108(0, 1);
    }

    var_00[var_02] thread func_E542(var_03, var_04, var_05);
    wait(0.125);
  }

  var_00[2] waittill("intro_finished");
  scripts\engine\utility::flag_clear("vr_delete_thrown_grenades");
  var_00[var_00.size - 1] waittill("intro_finished");
  level.var_13563.var_2F09.origin = var_01.var_CBFA.origin;
  foreach(var_08 in level.var_13563.var_4D95) {
    var_08.origin = var_01.var_CBFA.origin + anglestoright(var_01.var_CBFA.angles) * -1792;
  }

  wait(0.25);
}

func_E539(param_00) {
  level endon("reset_vr");
  thread scripts\sp\anim::func_1EC3(self, "vr_intro_part1");
  func_E53E("passive", 1, undefined, 1);
  foreach(var_02 in self.var_466A) {
    var_02 show();
  }

  wait(0.5);
  thread scripts\sp\anim::func_1F35(self, "vr_intro_part1");
  level waittill("vr_ring" + self.var_EDD5 + "_intro_show_geo");
  foreach(var_05 in self.segments) {
    if(isDefined(var_05.var_6E86)) {
      var_05.var_6E86 show();
    }

    var_05 show();
  }
}

func_E542(param_00, param_01, param_02) {
  level endon("reset_vr");
  func_E53E("active");
  self rotateroll(90, param_01, param_02, param_02);
  self moveto(self.origin + anglestoright(self.angles) * param_00, param_01, param_02, param_02);
  wait(param_01 + 0.05);
  func_E53E("passive");
  if(self == level.var_13563.var_E546[0]) {
    self.segments[0].var_6E86 playSound("scn_vr_enter_cap");
    foreach(var_04 in self.segments) {
      var_04.var_6E86 unlink();
      var_04.var_6E86 rotateroll(-90, 1, 0.25, 0.25);
    }
  }

  self notify("intro_finished");
}

func_669D(param_00, param_01, param_02) {
  level endon("reset_vr");
  if(param_02 == 0) {
    level.var_13563.var_BF5A = param_00;
    level.var_13563.var_BF5B[0] = level.var_13563.var_E546[1].var_466A[0];
    level.var_13563.var_BF5B[1] = level.var_13563.var_E546[1].var_466A[1];
    var_03 = undefined;
    var_04 = undefined;
    var_05 = 0;
  } else if(var_05 == 1) {
    var_04 = undefined;
    var_04 = level.var_13563.var_E546[1].segments;
    level.var_13563.var_BF5A = param_02[randomint(param_02.size)];
    var_05 = 0;
  } else {
    var_04 = undefined;
    var_04 = level.var_13563.var_E546[1].segments;
    level.var_13563.var_BF5A = param_02[randomint(param_02.size)];
    var_05 = 1;
  }

  if(param_02 == 0) {
    func_6B74(level.var_13563.var_BF5A, 0);
    level thread func_F188(level.var_13563.var_BF5A, 1);
    level.player playSound("shipcrib_hud_activate_simulation");
    return;
  }

  if(param_00 == var_03[0]) {
    if(level.var_13563.var_BF5A == var_03[1]) {
      var_04 = "negative_90";
      level.var_13563.var_BF5B[0] = level.var_13563.var_E546[1].var_466A[1];
      level.var_13563.var_BF5B[1] = level.var_13563.var_E546[1].var_466A[2];
    } else if(level.var_13563.var_BF5A == var_03[2]) {
      var_04 = "positive_180";
      level.var_13563.var_BF5B[0] = level.var_13563.var_E546[1].var_466A[2];
      level.var_13563.var_BF5B[1] = level.var_13563.var_E546[1].var_466A[3];
    } else {
      var_04 = "positive_90";
      level.var_13563.var_BF5B[0] = level.var_13563.var_E546[1].var_466A[3];
      level.var_13563.var_BF5B[1] = level.var_13563.var_E546[1].var_466A[0];
    }
  } else if(param_00 == var_03[1]) {
    if(level.var_13563.var_BF5A == var_03[2]) {
      var_04 = "negative_90";
      level.var_13563.var_BF5B[0] = level.var_13563.var_E546[1].var_466A[2];
      level.var_13563.var_BF5B[1] = level.var_13563.var_E546[1].var_466A[3];
    } else if(level.var_13563.var_BF5A == var_03[3]) {
      var_04 = "positive_180";
      level.var_13563.var_BF5B[0] = level.var_13563.var_E546[1].var_466A[3];
      level.var_13563.var_BF5B[1] = level.var_13563.var_E546[1].var_466A[0];
    }
  } else if(param_00 == var_03[2]) {
    if(level.var_13563.var_BF5A == var_03[1]) {
      var_04 = "positive_90";
      level.var_13563.var_BF5B[0] = level.var_13563.var_E546[1].var_466A[1];
      level.var_13563.var_BF5B[1] = level.var_13563.var_E546[1].var_466A[2];
    } else if(level.var_13563.var_BF5A == var_03[3]) {
      var_04 = "negative_90";
      level.var_13563.var_BF5B[0] = level.var_13563.var_E546[1].var_466A[3];
      level.var_13563.var_BF5B[1] = level.var_13563.var_E546[1].var_466A[0];
    }
  } else if(param_00 == var_03[3]) {
    if(level.var_13563.var_BF5A == var_03[1]) {
      var_04 = "negative_180";
      level.var_13563.var_BF5B[0] = level.var_13563.var_E546[1].var_466A[1];
      level.var_13563.var_BF5B[1] = level.var_13563.var_E546[1].var_466A[2];
    } else if(level.var_13563.var_BF5A == var_03[2]) {
      var_04 = "positive_90";
      level.var_13563.var_BF5B[0] = level.var_13563.var_E546[1].var_466A[2];
      level.var_13563.var_BF5B[1] = level.var_13563.var_E546[1].var_466A[3];
    }
  }

  level.player playSound("shipcrib_hud_cleared_simulation");
  level thread func_A62B(1);
  func_DFED();
  scripts\engine\utility::flag_set("vr_delete_thrown_grenades");
  level thread func_A5BD(level.var_13563.var_E546[2]);
  switch (var_04) {
    case "positive_90":
    case "negative_90":
      level.player playSound("scn_vr_rotate_90");
      if(var_05) {
        level.player scripts\engine\utility::delaycall(1.5, ::playsound, "scn_vr_unfold_side");
      }
      break;

    case "negative_180":
    case "positive_180":
      level.player playSound("scn_vr_rotate_180");
      if(var_05) {
        level.player scripts\engine\utility::delaycall(3, ::playsound, "scn_vr_unfold_side");
      }
      break;

    default:
      break;
  }

  for(var_06 = 0; var_06 < level.var_13563.var_E546.size; var_06++) {
    if(level.var_13563.var_BF5A == var_03[1]) {
      var_07 = 1;
    } else if(level.var_13563.var_BF5A == var_03[2]) {
      var_07 = 2;
    } else {
      var_07 = 3;
    }

    if(var_06 == 0) {
      level.var_13563.var_E546[var_06] thread func_1266B(var_04, var_05, var_07);
    } else {
      level.var_13563.var_E546[var_06] thread func_12669(var_04, var_05, var_07);
    }

    wait(0.125);
  }

  level.var_13563.var_E546[1] scripts\sp\utility::func_65E8("ring_spinning");
  level.var_13563.var_BF5A scripts\sp\utility::func_65E8("segment_dropping_geo");
  level thread func_F188(level.var_13563.var_BF5A, 1);
  wait(0.25);
}

func_12669(param_00, param_01, param_02) {
  level endon("reset_vr");
  scripts\sp\utility::func_65E1("ring_spinning");
  func_E53E("active");
  var_03 = 1.5;
  var_04 = 0.35;
  if(param_00 == "positive_90") {
    self rotateroll(90, var_03, var_04, var_04);
  } else if(param_00 == "negative_90") {
    self rotateroll(-90, var_03, var_04, var_04);
  } else if(param_00 == "positive_180") {
    var_03 = var_03 * 2;
    var_04 = var_04 * 1.5;
    self rotateroll(180, var_03, var_04, var_04);
  } else if(param_00 == "negative_180") {
    var_03 = var_03 * 2;
    var_04 = var_04 * 1.5;
    self rotateroll(-180, var_03, var_04, var_04);
  }

  wait(var_03 + 0.1);
  self notify("rotation_done");
  if(self == level.var_13563.var_E546[1]) {
    level thread func_6B74(level.var_13563.var_BF5A, 0);
  }

  func_E53E("passive");
  scripts\sp\utility::func_65DD("ring_spinning");
  if(param_01) {
    thread func_12673("left", param_02);
    thread func_12673("right", param_02);
    if(self == level.var_13563.var_E546[1]) {
      level waittill("corner_dropping_geo");
      func_6B74(level.var_13563.var_BF5A, 1);
    }
  }
}

func_1266B(param_00, param_01, param_02) {
  level endon("reset_vr");
  func_E53E("active");
  var_03 = 1.5;
  var_04 = 0.35;
  if(param_00 == "positive_180") {
    var_03 = var_03 * 2;
  } else if(param_00 == "negative_180") {
    var_03 = var_03 * 2;
  }

  wait(var_03 + 0.1);
  func_E53E("passive");
  if(param_01) {
    func_E53E("active");
    var_03 = getanimlength( % vr_unfold_left);
    wait(var_03);
    func_E53E("passive");
  }
}

func_12673(param_00, param_01) {
  level endon("reset_vr");
  var_02 = undefined;
  var_03 = undefined;
  var_04 = undefined;
  if(param_00 == "left") {
    if(param_01 == 0) {
      var_02 = "tag_corner0_bottom";
      var_03 = 3;
      var_04 = 0;
    } else if(param_01 == 1) {
      var_02 = "tag_corner1_bottom";
      var_03 = 0;
      var_04 = 1;
    } else if(param_01 == 2) {
      var_02 = "tag_corner2_bottom";
      var_03 = 1;
      var_04 = 2;
    } else if(param_01 == 3) {
      var_02 = "tag_corner3_bottom";
      var_03 = 2;
      var_04 = 3;
    }
  } else if(param_00 == "right") {
    if(param_01 == 0) {
      var_02 = "tag_corner1_top";
      var_03 = 1;
      var_04 = 1;
    } else if(param_01 == 1) {
      var_02 = "tag_corner2_top";
      var_03 = 2;
      var_04 = 2;
    } else if(param_01 == 2) {
      var_02 = "tag_corner3_top";
      var_03 = 3;
      var_04 = 3;
    } else if(param_01 == 3) {
      var_02 = "tag_corner0_top";
      var_03 = 0;
      var_04 = 0;
    }
  }

  func_12B95(param_00, var_02, param_01, var_03, var_04);
}

func_12B95(param_00, param_01, param_02, param_03, param_04) {
  level endon("reset_vr");
  var_05 = self gettagorigin(param_01);
  var_06 = vectortoangles(anglesToForward(self.angles));
  var_07 = scripts\sp\utility::func_10639("vr_unfold_" + param_00 + "_rig", var_05, var_06);
  var_07 hide();
  level.var_13563.var_12B98[level.var_13563.var_12B98.size] = var_07;
  var_08 = self.segments[param_03];
  var_09 = self.var_466A[param_04];
  var_08.var_CBFA unlink();
  var_08.var_CBFA linkto(var_07, "tag_segment", (0, 0, 0), (0, 0, 0));
  var_09.var_CBFA unlink();
  var_09.var_CBFA linkto(var_07, "tag_corner_bottom", (0, 0, 0), (0, 0, 0));
  func_E53E("active");
  scripts\sp\utility::func_65E1("ring_unfolding");
  var_07 scripts\sp\anim::func_1F35(var_07, "vr_unfold");
  func_E53E("passive");
  if(isDefined(var_09.var_1078F)) {
    var_09.var_1078F.var_A534 = param_00;
    var_09 func_57F2(level.var_13563.var_BF5A);
    level thread func_6B74(var_08, 1);
    wait(0.25);
    level thread func_6B74(var_09, 1);
    level thread scripts\sp\utility::func_C12D("corner_dropping_geo", 0.25);
    var_09 scripts\sp\utility::func_65E8("segment_dropping_geo");
  }

  scripts\sp\utility::func_65DD("ring_unfolding");
}

func_E53E(param_00, param_01, param_02, param_03) {
  if(!isDefined(param_03)) {
    param_03 = 0;
  }

  if(!isDefined(param_01)) {
    param_01 = 0;
  }

  if(!isDefined(param_02)) {
    param_02 = 0;
  }

  if(param_00 == "passive") {
    foreach(var_05 in self.var_466A) {
      var_05.var_AC84 _meth_82FC(var_05.var_AC84.var_10BF7);
      var_05.var_6128 show();
      var_05.var_6123 hide();
      if(param_01) {
        var_05.var_AC84 setlightintensity(var_05.var_AC84.script_intensity_01);
        continue;
      }

      if(param_02) {
        var_05.var_AC84 setlightintensity(0);
        var_05.var_6128 hide();
        var_05.var_6123 hide();
      }
    }
  } else if(param_00 == "active") {
    foreach(var_05 in self.var_466A) {
      var_05.var_AC84 _meth_82FC(var_05.var_AC84.var_62C0);
      var_05.var_6128 hide();
      var_05.var_6123 show();
      if(param_01) {
        var_05.var_AC84 setlightintensity(var_05.var_AC84.script_intensity_01);
        continue;
      }

      if(param_02) {
        var_05.var_AC84 setlightintensity(0);
        var_05.var_6128 hide();
        var_05.var_6123 hide();
      }
    }
  }

  if(self == level.var_13563.var_E546[0] || self == level.var_13563.var_E546[5]) {
    thread func_E53F(param_00, param_01, param_02, param_03);
  }
}

func_E53F(param_00, param_01, param_02, param_03) {
  level endon("reset_vr");
  var_04 = [self.segments[1], self.segments[3]];
  if(param_03) {
    level waittill("vr_ring" + self.var_EDD5 + "_intro_show_geo");
  }

  if(param_00 == "passive") {
    foreach(var_06 in var_04) {
      if(isDefined(var_06.var_6E86)) {
        if(isDefined(var_06.var_6E86.var_6128)) {
          var_06.var_6E86.var_6128 show();
          var_06.var_6E86.var_6123 hide();
          if(param_02) {
            var_06.var_6E86.var_6128 hide();
            var_06.var_6E86.var_6123 hide();
          }
        }
      }

      if(isDefined(var_06.var_6128)) {
        var_06.var_6128 show();
        var_06.var_6123 hide();
        if(param_02) {
          var_06.var_6128 hide();
          var_06.var_6123 hide();
        }
      }
    }

    return;
  }

  if(param_00 == "active") {
    foreach(var_06 in self.segments) {
      if(isDefined(var_06.var_6E86)) {
        if(isDefined(var_06.var_6E86.var_6128)) {
          var_06.var_6E86.var_6128 hide();
          var_06.var_6E86.var_6123 show();
          if(param_02) {
            var_06.var_6E86.var_6128 hide();
            var_06.var_6E86.var_6123 hide();
          }
        }
      }

      if(isDefined(var_06.var_6128)) {
        var_06.var_6128 hide();
        var_06.var_6123 show();
        if(param_02) {
          var_06.var_6128 hide();
          var_06.var_6123 hide();
        }
      }
    }
  }
}

func_6B74(param_00, param_01) {
  level endon("reset_vr");
  if(!isDefined(param_01)) {
    param_01 = 0;
  }

  if(isDefined(param_00.var_6B71)) {
    param_00 scripts\sp\utility::func_65E1("segment_dropping_geo");
    if(!param_01) {
      if(param_00 == level.var_13563.var_E546[1].segments[0]) {
        param_00 playSound("vr_blocks_in_and_hit_01");
      } else if(param_00 == level.var_13563.var_E546[1].segments[1]) {
        param_00 playSound("vr_blocks_in_and_hit_02");
      } else if(param_00 == level.var_13563.var_E546[1].segments[2]) {
        param_00 playSound("vr_blocks_in_and_hit_03");
      } else if(param_00 == level.var_13563.var_E546[1].segments[3]) {
        param_00 playSound("vr_blocks_in_and_hit_04");
      }
    } else if(isDefined(param_00.var_1078F)) {
      if(param_00.var_1078F.var_A534 == "left") {
        param_00 playSound("vr_blocks_in_bridge_left");
      } else {
        param_00 playSound("vr_blocks_in_bridge_right");
      }
    }

    for(var_02 = 0; var_02 < param_00.var_6B71.size; var_02++) {
      var_03 = param_00.var_6B71[var_02];
      if(param_01) {
        if(!isDefined(var_03.script_parameters)) {
          continue;
        }

        if(var_03.script_parameters == "unfold") {
          var_03 thread func_6B72();
          wait(0.05);
        }

        continue;
      }

      if(isDefined(var_03.script_parameters)) {
        if(var_03.script_parameters == "unfold") {
          continue;
        }
      }

      var_03 thread func_6B72();
      wait(0.1);
    }

    wait(0.3);
    param_00 scripts\sp\utility::func_65DD("segment_dropping_geo");
  }
}

func_6B72() {
  var_00 = self.var_8D0D * -1;
  var_01 = self.origin + (0, 0, var_00);
  func_F188(level.var_13563.var_BF5A, 0, self.var_7595, var_01, self.var_7587, anglestoup(self.angles));
  self unlink();
  self show();
  self moveto(var_01, 0.25);
}

func_2F0A(param_00) {
  if(param_00) {
    level.var_13563.var_2F09 thread func_3108(1);
    return;
  }

  level.var_13563.var_2F09 thread func_3108(0);
}

func_4D96(param_00, param_01, param_02, param_03) {
  level notify("data_box_moving");
  level endon("reset_vr");
  level endon("data_box_moving");
  if(!isDefined(param_01)) {
    param_01 = 1;
  }

  if(!isDefined(param_02)) {
    param_02 = 0;
  }

  if(!isDefined(param_03)) {
    param_03 = 0;
  }

  foreach(var_05 in level.var_13563.var_4D95) {
    var_05 thread func_4D97(param_00, param_01, param_02, param_03);
    if(!param_03) {
      wait(0.125);
    }
  }
}

func_4D97(param_00, param_01, param_02, param_03) {
  if(param_01) {
    thread func_3108(1);
  } else if(param_02) {
    thread func_3108(0, 1);
  }

  if(isDefined(self.var_A645) && param_01) {
    self.var_A645 playSound("killcounter_appear");
    self.var_A645 thread func_3108(1);
  } else if(isDefined(self.var_A645) && param_02) {
    self.var_A645 playSound("killcounter_disappear");
    self.var_A645 thread func_3108(0, 1);
  }

  if(param_03) {
    self waittill("vr_flicker_done");
    self moveto(param_00, 0.05);
    return;
  }

  self moveto(param_00, 0.5, 0.125, 0.125);
}

func_3108(param_00, param_01) {
  self notify("vr_flicker");
  level endon("reset_vr");
  self endon("vr_flicker");
  var_02 = 0.1;
  if(!isDefined(param_01)) {
    param_01 = 0;
  }

  if(param_01) {
    var_03 = 3;
  } else {
    var_03 = 5;
  }

  if(param_00) {
    for(var_04 = 0; var_04 < var_03; var_04++) {
      if(var_04 > 2) {
        var_02 = 0.15;
      }

      self hide();
      wait(randomfloatrange(0.05, var_02));
      self show();
      wait(randomfloatrange(0.05, var_02));
    }
  } else {
    for(var_04 = 0; var_04 < var_03; var_04++) {
      if(var_04 > 2) {
        var_02 = 0.15;
      }

      self show();
      wait(randomfloatrange(0.05, var_02));
      self hide();
      wait(randomfloatrange(0.05, var_02));
    }
  }

  self notify("vr_flicker_done");
}

func_A647() {
  var_00 = level.var_13563.var_63A1;
  var_01 = var_00.size;
  var_02 = [level.var_13563.var_4D95["front_top_right"].var_A645, level.var_13563.var_4D95["rear_top_left"].var_A645, level.var_13563.var_4D95["rear_top_right"].var_A645];
  foreach(var_04 in var_02) {
    var_04 thread func_A646();
    if(var_01 != var_04.var_4B5B) {
      var_04 hidepart("tag_num" + var_04.var_4B5B);
      var_04 giveperk("tag_num" + var_01);
      var_04.var_4B5B = var_01;
    }

    if(var_01 == 0) {
      foreach(var_06 in var_04.var_1141C) {
        var_04 hidepart(var_06);
      }

      continue;
    }

    for(var_08 = 1; var_08 < var_04.var_1141C.size; var_08++) {
      if(var_08 <= var_01) {
        var_04 giveperk("tag_boxcounter" + var_08);
        continue;
      }

      var_04 hidepart("tag_boxcounter" + var_08);
    }
  }
}

func_A646() {
  level endon("reset_vr");
  if(scripts\sp\utility::func_65DB("killcounter_animating")) {
    return;
  }

  scripts\sp\utility::func_65E1("killcounter_animating");
  scripts\sp\anim::func_1F35(self, "update");
  scripts\sp\utility::func_65DD("killcounter_animating");
}

func_106C8(param_00, param_01) {
  level endon("reset_vr");
  var_02 = [];
  var_03 = [];
  if(isDefined(level.var_13563.var_46C6)) {
    var_02 = func_799F(param_00, level.var_13563.var_46C6, 4);
    if(isDefined(level.var_13563.var_46C7)) {
      if(level.var_13563.var_46C7 != level.var_13563.var_46C6) {
        var_03 = func_799F(param_00, level.var_13563.var_46C7, 4);
      }
    }
  } else {
    var_02 = func_799F(param_00, level.var_13563.var_46C7, 4);
  }

  if(param_01 == 0) {
    level.var_13563.var_10691 = 2;
    level.var_13563.var_1087E[0] func_1085F(param_00, var_02[0], 0);
    if(var_03.size > 0) {
      level.var_13563.var_1087E[1] func_1085F(param_00, var_03[0], 0);
    } else {
      level.var_13563.var_1087E[1] func_1085F(param_00, var_02[1], 0);
    }

    level waittill("equipment_range_enemies_dead");
    return;
  }

  if(param_01 == 1) {
    level.var_13563.var_10691 = 4;
    level.var_13563.var_1087E[0] func_1085F(param_00, var_02[0], 0);
    if(var_03.size > 0) {
      level.var_13563.var_1087E[1] func_1085F(param_00, var_03[0], 0);
    } else {
      level.var_13563.var_1087E[1] func_1085F(param_00, var_02[1], 0);
    }

    wait(1);
    if(var_03.size > 0) {
      level.var_13563.var_1087E[2] func_1085F(param_00, var_02[1], 0);
      level.var_13563.var_1087E[3] func_1085F(param_00, var_03[1], 0);
    } else {
      level.var_13563.var_1087E[2] func_1085F(param_00, var_02[2], 0);
      level.var_13563.var_1087E[3] func_1085F(param_00, var_02[3], 0);
    }

    level waittill("equipment_range_enemies_dead");
    return;
  }

  if(param_01 > 1) {
    level.var_13563.var_10691 = 5;
    level.var_13563.var_1087E[0] func_1085F(param_00, var_02[0], 0);
    if(var_03.size > 0) {
      level.var_13563.var_1087E[1] func_1085F(param_00, var_03[0], 0);
      level.var_13563.var_1087E[2] func_1085F(param_00, var_02[1], 0);
    } else {
      level.var_13563.var_1087E[1] func_1085F(param_00, var_02[1], 0);
      level.var_13563.var_1087E[2] func_1085F(param_00, var_02[2], 0);
    }

    wait(1);
    level.var_13563.var_E546[1] scripts\sp\utility::func_65E8("ring_unfolding");
    for(var_04 = 3; var_04 < 4; var_04++) {
      var_05 = level.var_13563.var_BF5B[0];
      level.var_13563.var_1087E[var_04] func_1085F(var_05, var_05.var_1078F, 1);
    }

    for(var_04 = 4; var_04 < 5; var_04++) {
      var_05 = level.var_13563.var_BF5B[1];
      level.var_13563.var_1087E[var_04] func_1085F(var_05, var_05.var_1078F, 1);
    }

    level waittill("equipment_range_enemies_dead");
    return;
  }
}

func_F60F() {
  var_00 = level.player _meth_84C6("selectedLoadout");
  var_01 = level.player _meth_84C6("loadouts", var_00, "weaponSetups", 0, "weapon");
  var_02 = level.player _meth_84C6("loadouts", var_00, "weaponSetups", 1, "weapon");
  var_03 = scripts\sp\loadout::func_31CE(0, var_00);
  var_04 = scripts\sp\loadout::func_31CE(1, var_00);
  if(isDefined(var_03) || isDefined(var_04)) {
    level.var_13563.var_46C6 = func_78E8(var_03);
    level.var_13563.var_46C7 = func_78E8(var_04);
    return;
  }

  level.var_13563.var_46C6 = "medium";
  level.var_13563.var_46C7 = undefined;
}

func_78E8(param_00) {
  if(!isDefined(param_00)) {
    return undefined;
  }

  var_01 = weaponclass(param_00);
  switch (var_01) {
    case "rifle":
      var_02 = "medium";
      break;

    case "mg":
      var_02 = "medium";
      break;

    case "smg":
      var_02 = "close";
      break;

    case "sniper":
      var_02 = "long";
      break;

    case "pistol":
      var_02 = "close";
      break;

    case "spread":
      var_02 = "close";
      break;

    case "beam":
      var_02 = "medium";
      break;

    default:
      var_02 = "medium";
      break;
  }

  return var_02;
}

func_799F(param_00, param_01, param_02) {
  var_03 = [];
  var_04 = [];
  var_05 = [];
  var_06 = [];
  foreach(var_08 in param_00.var_10870) {
    if(var_08.script_parameters == "long") {
      var_04[var_04.size] = var_08;
    }

    if(var_08.script_parameters == "medium") {
      var_05[var_05.size] = var_08;
    }

    if(var_08.script_parameters == "close") {
      var_06[var_06.size] = var_08;
    }
  }

  switch (param_01) {
    case "long":
      var_03 = scripts\engine\utility::array_randomize(var_04);
      break;

    case "medium":
      var_03 = scripts\engine\utility::array_randomize(var_05);
      break;

    case "close":
      var_03 = scripts\engine\utility::array_randomize(var_06);
      break;
  }

  var_0A = [];
  for(var_0B = 0; var_0B < param_02; var_0B++) {
    if(var_0B > var_03.size - 1) {
      break;
    }

    var_0A[var_0A.size] = var_03[var_0B];
  }

  return scripts\engine\utility::array_randomize(var_0A);
}

func_1085F(param_00, param_01, param_02) {
  level endon("reset_vr");
  if(param_02) {
    if(param_01.var_A534 == "left") {
      var_03 = level.var_13563.var_BF5A.var_12B96;
      self.angles = vectortoangles(anglesToForward(param_01.angles));
    } else {
      var_03 = level.var_13563.var_BF5A.var_12B97;
      self.angles = vectortoangles(anglesToForward(param_01.angles) * -1);
    }
  } else {
    var_03 = getnode(param_02.target, "targetname");
    self.angles = param_01.angles;
  }

  self.var_C1 = 1;
  self.target = var_03.var_336;
  self.origin = param_00.var_CBFA.origin + param_01.var_F187;
  self.var_EDE3 = 1;
  var_03.fgetarg = 128;
  level thread scripts\engine\utility::play_sound_in_space("vr_enemy_spawn", self.origin);
  var_04 = self.origin + anglestoup(self.angles) * 300;
  var_05 = anglestoup(self.angles) * -1;
  var_06 = anglesToForward(self.angles);
  func_F188(param_00, 0, "vfx_vr_enemy_spawn", var_04, var_05, var_06);
  wait(0.65);
  scripts\sp\utility::func_10619(1);
}

func_D70F() {
  level endon("reset_vr");
  self endon("death");
  level.var_13563.var_63A1[level.var_13563.var_63A1.size] = self;
  self.iscinematicplaying = 0;
  self.objective_state_nomessage = 0;
  self.var_10264 = 1;
  self.var_28CF = 0;
  self.var_4E46 = ::func_643D;
  scripts\sp\utility::func_5550();
  level thread func_A647();
  thread func_653A();
  scripts\sp\utility::func_9196(4, 1, 0, "default_vroutline");
}

func_D709() {
  level endon("reset_vr");
  self endon("death");
  level.var_13563.var_639F[level.var_13563.var_639F.size] = self;
  self.iscinematicplaying = 0;
  self.objective_state_nomessage = 0;
  self.var_4E46 = ::func_643C;
  scripts\sp\utility::func_5550();
  level thread func_A647();
  thread func_653A();
  scripts\sp\utility::func_9196(4, 1, 0, "default_vroutline");
}

func_643D() {
  if(!scripts\engine\utility::array_contains(level.var_13563.var_63A1, self)) {
    return 1;
  }

  level.var_13563.var_63A1 = scripts\engine\utility::array_remove(level.var_13563.var_63A1, self);
  level.var_13563.var_4E37 = level.var_13563.var_4E37 + 1;
  if(level.var_13563.var_4E37 >= level.var_13563.var_10691) {
    level notify("equipment_range_enemies_dead");
    level.var_13563.var_4E37 = 0;
  }

  level thread func_A647();
  self.utility_triggers unlink();
  self.utility_triggers setlightintensity(0);
  self.utility_triggers.var_19 = 0;
  var_00 = ["j_head", "j_chest", "j_shoulder_ri", "j_shoulder_le", "j_elbow_ri", "j_elbow_le", "j_hip_ri", "j_hip_le", "j_knee_ri", "j_knee_le"];
  var_01 = var_00.size;
  for(var_02 = 0; var_02 < var_01; var_02++) {
    var_03 = var_00[var_02];
    var_04 = self gettagorigin(var_03);
    var_05 = self gettagangles(var_03);
    var_06 = self.var_DC;
    if(var_06 == (0, 0, 0)) {
      var_07 = getent("start_vr_chamber", "targetname");
      var_06 = anglesToForward(var_07.angles);
    }

    var_08 = anglestoup(var_05);
    func_F188(level.var_13563.var_BF5A, 0, "vfx_vr_enemy_death", var_04, var_06, var_08);
  }

  if(!isDefined(self.var_4E68) || self.var_4E68 != 1) {
    level thread scripts\engine\utility::play_sound_in_space("vr_enemy_death", self gettagorigin("J_Neck"));
  }

  wait(0.1);
  self delete();
  return 1;
}

func_643C() {
  if(!scripts\engine\utility::array_contains(level.var_13563.var_639F, self)) {
    return 1;
  }

  level.var_13563.var_639F = scripts\engine\utility::array_remove(level.var_13563.var_639F, self);
  level.var_13563.var_4E37 = level.var_13563.var_4E37 + 1;
  if(level.var_13563.var_4E37 >= level.var_13563.var_10691) {
    level notify("equipment_range_enemies_dead");
    level.var_13563.var_4E37 = 0;
  }

  level thread func_A647();
  self.utility_triggers unlink();
  self.utility_triggers setlightintensity(0);
  self.utility_triggers.var_19 = 0;
  var_00 = func_336D();
  for(var_01 = 0; var_01 < var_00.size; var_01++) {
    var_02 = var_00[var_01];
    var_03 = self gettagorigin(var_02);
    var_04 = self gettagangles(var_02);
    var_05 = self.var_DC;
    if(var_05 == (0, 0, 0)) {
      var_06 = getent("start_vr_chamber", "targetname");
      var_05 = anglesToForward(var_06.angles);
    }

    var_07 = anglestoup(var_04);
    func_F188(level.var_13563.var_BF5A, 0, "vfx_vr_enemy_death", var_03, var_05, var_07);
  }

  if(!isDefined(self.var_4E68) || self.var_4E68 != 1) {
    level thread scripts\engine\utility::play_sound_in_space("vr_enemy_death", self gettagorigin("J_Neck"));
  }

  wait(0.1);
  self delete();
  return 1;
}

func_336D() {
  var_00 = ["j_head", "j_spineupper", "j_shoulder_ri", "j_shoulder_le", "j_elbow_ri", "j_elbow_le", "j_hip_ri", "j_hip_le", "j_knee_ri", "j_knee_le"];
  if(lib_0A0B::func_7C35("left_leg") == "dismember") {
    var_00 = scripts\engine\utility::array_remove_array(var_00, ["j_hip_le", "j_knee_le"]);
  }

  if(lib_0A0B::func_7C35("right_leg") == "dismember") {
    var_00 = scripts\engine\utility::array_remove_array(var_00, ["j_hip_ri", "j_knee_ri"]);
  }

  if(lib_0A0B::func_7C35("left_arm") == "dismember") {
    var_00 = scripts\engine\utility::array_remove_array(var_00, ["j_shoulder_le", "j_elbow_le"]);
  }

  if(lib_0A0B::func_7C35("right_arm") == "dismember") {
    var_00 = scripts\engine\utility::array_remove_array(var_00, ["j_shoulder_ri", "j_elbow_ri"]);
  }

  if(lib_0A0B::func_7C35("torso") == "dismember") {
    var_00 = scripts\engine\utility::array_remove_array(var_00, ["j_spineupper"]);
  }

  return var_00;
}

func_A62A() {
  var_00 = level.var_13563.var_63A1;
  clearallcorpses();
  foreach(var_02 in var_00) {
    if(isDefined(var_02.var_FE4A)) {
      if(var_02.var_FE4A) {
        killfxontag(level.var_7649[var_02.unittype + "_death"], var_02, "j_spine4");
      }
    }

    var_02.var_4E68 = 1;
    var_02 _meth_81D0();
  }
}

func_13566(param_00) {
  level endon("reset_vr");
  if(scripts\engine\utility::flag("vr_delete_thrown_grenades")) {
    if(isDefined(param_00)) {
      var_01 = undefined;
      if(issubstr(param_00.model, "seeker")) {
        var_02 = "seeker";
      } else if(issubstr(var_01.model, "emp")) {
        var_02 = "emp";
      } else if(issubstr(var_01.model, "anti_grav")) {
        var_02 = "antigrav";
      } else if(issubstr(var_01.model, "frag")) {
        var_02 = "frag";
      } else if(issubstr(var_01.model, "foam")) {
        var_02 = "coverwall";
      } else if(issubstr(var_01.model, "drone")) {
        var_02 = var_01.origin;
        var_02 = "drone";
      } else {
        return;
      }

      param_00 _meth_85AC();
      if(scripts\engine\utility::flag("vr_delete_thrown_grenades")) {
        switch (var_02) {
          case "seeker":
            level thread lib_0E26::func_DFC1();
            scripts\engine\utility::flag_waitopen("seeker_force_delete");
            var_03 = level.var_F10A.var_A8C6;
            break;

          case "emp":
            level thread lib_0E25::func_DFBE();
            scripts\engine\utility::flag_waitopen("emp_force_delete");
            var_03 = level.var_612D.var_A8C6;
            break;

          case "antigrav":
            level thread lib_0E21::func_DFBA();
            scripts\engine\utility::flag_waitopen("antigrav_force_delete");
            var_03 = level.var_2006.var_A8C6;
            break;

          case "coverwall":
            level thread scripts\sp\coverwall::func_DFBD();
            scripts\engine\utility::flag_waitopen("coverwall_force_delete");
            var_03 = level.player.var_4759.var_A8C6;
            break;

          case "frag":
            level thread scripts\sp\detonategrenades::func_DFBF();
            scripts\engine\utility::flag_waitopen("frag_force_delete");
            var_03 = level.newteamhudelem.var_A8C6;
            break;

          case "drone":
            level thread lib_0E2D::func_5139();
            var_03 = var_02;
            break;

          default:
            var_03 = undefined;
            break;
        }

        if(var_02 == "drone") {
          level thread func_DFF0(0);
          return;
        }

        if(isDefined(var_03)) {
          level thread _meth_859E("vfx_vr_equipment_derez", var_03);
          return;
        }

        return;
      }
    }
  }
}

_meth_85AC() {
  self endon("explode");
  self endon("missile_stuck");
  self endon("death");
  self endon("entitydeleted");
  level endon("reset_vr");
  var_00 = getent("vr_thrown_grenade_trigger", "targetname");
  for(;;) {
    if(self istouching(var_00)) {
      scripts\engine\utility::waitframe();
      continue;
    }

    break;
  }
}

func_DFED(param_00) {
  level endon("reset_vr");
  if(!isDefined(param_00)) {
    param_00 = 0;
  }

  level thread func_DFF0(param_00);
  level thread func_DFF3(param_00);
  level thread func_DFF1(param_00);
  level thread func_DFEE(param_00);
  level thread func_DFEF(param_00);
  level thread func_DFF2(param_00);
  if(!param_00) {
    scripts\engine\utility::flag_waitopen("seeker_force_delete");
    scripts\engine\utility::flag_waitopen("emp_force_delete");
    scripts\engine\utility::flag_waitopen("antigrav_force_delete");
    scripts\engine\utility::flag_waitopen("coverwall_force_delete");
    scripts\engine\utility::flag_waitopen("frag_force_delete");
  }
}

func_DFF0(param_00) {
  level thread lib_0E2D::func_5139();
  level thread lib_0E2D::func_5138();
  foreach(var_02 in level.player.var_4C29) {
    if(isDefined(var_02.var_51BA)) {
      if(var_02.var_51BA) {
        continue;
      }
    }

    if(isDefined(var_02.var_C7B4)) {
      if(var_02.var_C7B4) {
        continue;
      }
    }

    if(!param_00) {
      level thread missilethermal("vfx_vr_equipment_derez", var_02);
    }
  }
}

func_DFF3(param_00) {
  if(!param_00) {
    foreach(var_02 in level.var_F10A.var_162D) {
      level thread _meth_859E("vfx_vr_equipment_derez", var_02.origin);
    }

    foreach(var_05 in level.var_F10A.var_1633) {
      level thread _meth_859E("vfx_vr_equipment_derez", var_05.origin);
    }
  }

  lib_0E26::func_DFC1();
}

func_DFF1(param_00) {
  if(!param_00) {
    foreach(var_02 in level.var_612D.var_522C) {
      level thread _meth_859E("vfx_vr_equipment_derez", var_02.origin + (0, 0, 16));
    }
  }

  lib_0E25::func_DFBE();
}

func_DFEE(param_00) {
  if(!param_00) {
    foreach(var_02 in level.var_2006.var_522B) {
      level thread _meth_859E("vfx_vr_equipment_derez", var_02.origin + (0, 0, 16));
    }
  }

  lib_0E21::func_DFBA();
}

func_DFEF(param_00) {
  if(!param_00) {
    foreach(var_02 in level.player.var_4759.var_11168) {
      if(isDefined(var_02.objective_position)) {
        var_03 = var_02.objective_position.origin;
      } else {
        var_03 = var_02.origin;
      }

      level thread _meth_859E("vfx_vr_equipment_derez", var_03 + (0, 0, 16));
    }
  }

  scripts\sp\coverwall::func_DFBD();
}

func_DFF2(param_00) {
  if(!param_00) {
    foreach(var_02 in level.newteamhudelem.var_B37A) {
      var_03 = var_02.origin;
      level thread _meth_859E("vfx_vr_equipment_derez", var_03);
    }
  }

  scripts\sp\detonategrenades::func_DFBF();
}

_meth_859E(param_00, param_01) {
  level endon("reset_vr");
  var_02 = spawnfx(scripts\engine\utility::getfx(param_00), param_01);
  triggerfx(var_02);
  level thread scripts\engine\utility::play_sound_in_space("emp_shock_short", param_01);
  var_02.var_F185 = 0;
  level.var_13563.var_760D[level.var_13563.var_760D.size] = var_02;
  wait(1.5);
  level.var_13563.var_760D = scripts\engine\utility::array_remove(level.var_13563.var_760D, var_02);
  var_02 delete();
}

missilethermal(param_00, param_01) {
  level endon("reset_vr");
  if(isDefined(param_01.var_9A96)) {
    while(param_01.var_9A96) {
      scripts\engine\utility::waitframe();
    }
  }

  var_02 = spawnfx(scripts\engine\utility::getfx(param_00), param_01.var_5BD7.origin);
  triggerfx(var_02);
  level thread scripts\engine\utility::play_sound_in_space("emp_shock_short", param_01.var_5BD7.origin);
  var_02.var_F185 = 0;
  level.var_13563.var_760D[level.var_13563.var_760D.size] = var_02;
  wait(1.5);
  level.var_13563.var_760D = scripts\engine\utility::array_remove(level.var_13563.var_760D, var_02);
  var_02 delete();
}

func_A5BD(param_00) {
  level endon("reset_vr");
  param_00 waittill("rotation_done");
  scripts\engine\utility::flag_clear("vr_delete_thrown_grenades");
}

func_A5D0() {
  level endon("reset_vr");
  var_00 = getent("vr_trigger_kill_equipment", "targetname");
  for(;;) {
    var_00 waittill("trigger", var_01);
    if(var_01.unittype == "seeker") {
      level thread _meth_859E("vfx_vr_equipment_derez", var_01.origin);
      var_01 thread lib_0E26::func_E084();
    }
  }
}

func_1E3A() {
  level endon("reset_vr");
  for(;;) {
    level.player scripts\engine\utility::waittill_any_3("reload_start", "weapon_switch_started", "offhand_fired", "weapon_fired");
    var_00 = undefined;
    var_01 = undefined;
    var_02 = undefined;
    var_03 = undefined;
    var_04 = level.player getcurrentprimaryweapon();
    var_05 = weaponclipsize(var_04);
    var_06 = level.player getweaponammostock(var_04);
    var_07 = scripts\sp\utility::func_7BD6();
    var_08 = scripts\sp\utility::func_7C3D();
    var_09 = scripts\sp\utility::func_7CAF();
    var_0A = scripts\sp\utility::func_7CB1();
    if(isDefined(var_07) && var_07 != "none") {
      var_00 = level.player getweaponammoclip(var_07);
    }

    if(isDefined(var_08) && var_08 != "none") {
      var_01 = level.player getweaponammoclip(var_08);
    }

    if(isDefined(var_09) && var_09 != "none") {
      var_02 = level.player getweaponammoclip(var_09);
    }

    if(isDefined(var_0A) && var_0A != "none") {
      var_03 = level.player getweaponammoclip(var_0A);
    }

    if(lib_0A2F::func_DA40(var_04)) {
      if(issubstr(var_04, "chargeshot") || issubstr(var_04, "penetrationrail")) {
        var_0B = 2;
        if(level.player getcurrentweaponclipammo() < var_0B) {
          level.player setweaponammoclip(var_04, var_05);
        }
      } else if(issubstr(var_04, "steeldragon")) {
        var_0B = 25;
        if(var_06 < var_05) {
          if(level.player getcurrentweaponclipammo() < var_0B) {
            level.player givemaxammo(var_04);
          }
        }
      } else if(issubstr(var_04, "lockon")) {
        if(var_06 <= var_05) {
          level.player givemaxammo(var_04);
        }
      }
    } else if(var_06 <= var_05) {
      level.player givemaxammo(var_04);
    }

    if(isDefined(var_00) && var_00 < 1) {
      level.player givemaxammo(var_07);
    }

    if(isDefined(var_01) && var_01 < 1) {
      level.player givemaxammo(var_08);
    }

    if(isDefined(var_02) && var_02 < 1) {
      level.player givemaxammo(var_09);
    }

    if(isDefined(var_03) && var_03 < 1) {
      level.player givemaxammo(var_0A);
    }
  }
}

func_653A() {
  level endon("reset_vr");
  self endon("death");
  foreach(var_01 in level.var_13563.var_653C) {
    if(!var_01.var_19) {
      var_01.var_19 = 1;
      self.utility_triggers = var_01;
      break;
    }
  }

  self.utility_triggers linkto(self, "tag_origin", (0, 0, 8), (0, 0, 0));
  scripts\engine\utility::waitframe();
  self.utility_triggers setlightintensity(self.utility_triggers.var_10C89);
  self.utility_triggers give_player_explosive_armor(37);
  for(;;) {
    func_653B(47, 1);
    wait(0.25);
    func_653B(37, 1);
  }
}

func_653B(param_00, param_01) {
  level endon("reset_vr");
  self endon("death");
  var_02 = int(param_01 * 20);
  var_03 = self.utility_triggers getspawnpoint();
  var_04 = param_00 - var_03 / var_02;
  for(var_05 = 0; var_05 < var_02; var_05++) {
    self.utility_triggers give_player_explosive_armor(var_03 + var_05 * var_04);
    wait(0.05);
  }

  self.utility_triggers give_player_explosive_armor(param_00);
}

func_F188(param_00, param_01, param_02, param_03, param_04, param_05) {
  if(!isDefined(param_01)) {
    param_01 = 0;
  }

  if(param_01) {
    foreach(var_07 in param_00.var_75B5) {
      param_03 = param_00.var_CBFA.origin + var_07.var_F187;
      var_08 = spawnfx(scripts\engine\utility::getfx(var_07.script_parameters), param_03);
      triggerfx(var_08);
      var_08.var_F185 = 1;
      level.var_13563.var_760D[level.var_13563.var_760D.size] = var_08;
    }

    return;
  }

  if(isDefined(param_05) && isDefined(var_08)) {
    var_08 = spawnfx(scripts\engine\utility::getfx(param_03), param_04, param_05, var_08);
  } else {
    var_08 = spawnfx(scripts\engine\utility::getfx(param_03), param_04);
  }

  triggerfx(var_08);
  var_08.var_F185 = 1;
  level.var_13563.var_760D[level.var_13563.var_760D.size] = var_08;
}

func_A62B(param_00) {
  if(!isDefined(param_00)) {
    param_00 = 0;
  }

  var_01 = [];
  foreach(var_03 in level.var_13563.var_760D) {
    if(param_00) {
      if(isDefined(var_03.var_F185)) {
        if(var_03.var_F185) {
          var_03 delete();
        }
      } else {
        var_01[var_01.size] = var_03;
      }

      continue;
    }

    var_03 delete();
  }

  level.var_13563.var_760D = var_01;
}

create_fx_pause() {
  foreach(var_01 in level.createfxent) {
    if(isDefined(var_01.v["exploder"])) {
      continue;
    }

    var_01 scripts\engine\utility::pauseeffect();
  }
}

create_fx_resume() {
  foreach(var_01 in level.createfxent) {
    if(isDefined(var_01.v["exploder"])) {
      continue;
    }

    var_01 scripts\sp\utility::func_E2B0();
  }
}

func_E241() {
  level notify("reset_vr");
  level.player notify("stop_delay_call");
  level.player freezecontrols(1);
  level.player setstance("stand");
  scripts\sp\outline::func_91A1("default", ::scripts\sp\outline::func_9192);
  func_A62A();
  func_10FB6();
  func_DFED(1);
  scripts\engine\utility::flag_clear("vr_delete_thrown_grenades");
  func_12BA8();
  func_12B92();
  scripts\engine\utility::waitframe();
  level.var_13563.var_BF5B = [];
  foreach(var_01 in level.var_13563.var_12B98) {
    var_01 delete();
  }

  level.var_13563.var_12B98 = [];
  level.var_13563.var_2F09 hide();
  level.var_13563.var_9B3D show();
  foreach(var_04 in level.var_13563.var_653C) {
    var_04.var_19 = 0;
    var_04 setlightintensity(0);
  }

  func_E1A2();
  wait(0.1);
  level.var_13563.var_4E37 = 0;
  level.var_13563.var_5BDE = 0;
  func_A62B();
  foreach(var_07 in level.var_13563.var_E546) {
    if(var_07.var_EDD5 == 0) {
      var_07.var_D958 linkto(var_07, "tag_origin", (0, 0, 0), (0, 90, 0));
    }

    foreach(var_09 in var_07.var_466A) {
      func_465F(var_09, var_07);
    }

    foreach(var_0C in var_07.segments) {
      func_F189(var_0C, var_07);
    }

    var_07 scripts\sp\utility::func_65DD("ring_spinning");
    var_07 scripts\sp\utility::func_65DD("ring_unfolding");
  }

  level.player freezecontrols(0);
}

func_465F(param_00, param_01) {
  if(isDefined(param_00.var_1078F)) {
    param_00.var_1078F.var_A534 = undefined;
  }

  param_00.var_AC84 _meth_82FC(param_00.var_AC84.var_10BF7);
  param_00.var_AC84 setlightintensity(0);
  param_00.var_6128 hide();
  param_00.var_6123 hide();
  param_00 hide();
  param_00.var_CBFA linkto(param_01, "j_corner" + param_00.script_index, (0, 0, 0), (0, 0, 0));
  func_6B73(param_00, 1);
}

func_F189(param_00, param_01) {
  param_00 hide();
  if(isDefined(param_00.collision)) {
    param_00.collision hide();
  }

  if(isDefined(param_00.var_6128)) {
    param_00.var_6128 hide();
  }

  if(isDefined(param_00.var_6123)) {
    param_00.var_6123 hide();
  }

  if(isDefined(param_00.var_6E86)) {
    if(isDefined(param_00.var_6E86.var_6128)) {
      param_00.var_6E86.var_6128 hide();
    }

    if(isDefined(param_00.var_6E86.var_6123)) {
      param_00.var_6E86.var_6123 hide();
    }

    param_00.var_6E86 hide();
    param_00.var_6E86 linkto(param_00.var_CBFA, "", param_00.var_6E86.var_D6A0, param_00.var_6E86.var_42);
  }

  param_00.var_CBFA linkto(param_01, "j_segment" + param_00.script_index, (0, 0, 0), (0, 0, 0));
  func_6B73(param_00, 1);
}

func_6B73(param_00, param_01) {
  if(isDefined(param_00.var_6B71)) {
    foreach(var_03 in param_00.var_6B71) {
      if(param_01) {
        var_03 linkto(param_00.var_CBFA, "", var_03.var_D6A0, var_03.var_42);
        var_03 hide();
        continue;
      }

      var_03 linkto(param_00.var_CBFA);
    }
  }
}

func_57F2(param_00) {
  self getrandomarchetype(param_00);
  level.var_13563.var_2BE3[level.var_13563.var_2BE3.size] = self;
}

func_12B92() {
  foreach(var_01 in level.var_13563.var_2BE3) {
    var_01 _meth_83C9();
  }

  level.var_13563.var_2BE3 = [];
}

func_E1A2() {
  level.var_13563.var_9B3D.var_CBFA.origin = level.var_13563.var_9B3D.var_CBFA.start_pos;
  foreach(var_01 in level.var_13563.var_E546) {
    var_01 moveto(var_01.start_pos, 0.05);
    var_01 rotateto(var_01.var_10BA1, 0.05);
    foreach(var_03 in var_01.var_466A) {
      if(isDefined(var_03.var_6B71)) {
        foreach(var_05 in var_03.var_6B71) {
          var_05 moveto(var_05.origin, 0.05);
          var_05 rotateto(var_05.angles, 0.05);
        }
      }
    }

    foreach(var_09 in var_01.segments) {
      if(isDefined(var_09.var_6E86)) {
        var_09.var_6E86 rotateto(var_09.var_6E86.angles, 0.05);
      }

      if(isDefined(var_09.var_6B71)) {
        foreach(var_05 in var_09.var_6B71) {
          var_05 moveto(var_05.origin, 0.05);
          var_05 rotateto(var_05.angles, 0.05);
        }
      }
    }
  }

  foreach(var_0F in level.var_13563.var_4D95) {
    var_0F moveto(var_0F.origin, 0.05);
    var_0F hide();
    if(isDefined(var_0F.var_A645)) {
      var_0F.var_A645 hide();
      var_0F.var_A645 hidepart("tag_num" + var_0F.var_A645.var_4B5B);
      var_0F.var_A645 giveperk("tag_num0");
      var_0F.var_A645.var_4B5B = 0;
      foreach(var_11 in var_0F.var_A645.var_1141C) {
        var_0F.var_A645 hidepart(var_11);
      }
    }
  }
}

func_10FB6() {
  level.player stopsounds();
  foreach(var_01 in level.var_13563.var_E546) {
    var_01 stopsounds();
    var_01 givescorefortrophyblocks();
    var_01 clearanim( % root, 0);
  }

  foreach(var_04 in level.var_13563.var_E546[1].var_466A) {
    var_04 stopsounds();
  }

  foreach(var_07 in level.var_13563.var_E546[1].segments) {
    var_07 stopsounds();
  }

  foreach(var_07 in level.var_13563.var_E546[0].segments) {
    var_07.var_6E86 stopsounds();
  }

  foreach(var_0C in level.var_13563.var_12B98) {
    var_0C stopsounds();
    var_0C givescorefortrophyblocks();
    var_0C clearanim( % root, 0);
  }

  foreach(var_0F in level.var_13563.var_4D95) {
    if(isDefined(var_0F.var_A645)) {
      var_0F.var_A645 stopsounds();
      var_0F.var_A645 givescorefortrophyblocks();
      var_0F.var_A645 clearanim( % root, 0);
      var_0F.var_A645 scripts\sp\utility::func_65DD("killcounter_animating");
    }
  }
}

func_13598() {
  for(;;) {
    level.player waittill("luinotifyserver", var_00, var_01);
    break;
  }

  switch (var_00) {
    case "player_vr_reset_request":
      scripts\engine\utility::flag_set("vr_tutorial_leave_shown");
      setsaveddvar("bg_cinematicAboveUI", "1");
      setsaveddvar("bg_cinematicFullScreen", "1");
      setsaveddvar("bg_cinematicCanPause", "1");
      func_CE8D(undefined, 0);
      func_E241();
      func_F620();
      level thread func_661E(1);
      break;

    case "player_vr_exit_request":
      scripts\engine\utility::flag_set("vr_tutorial_leave_shown");
      setsaveddvar("bg_cinematicAboveUI", "1");
      setsaveddvar("bg_cinematicFullScreen", "1");
      setsaveddvar("bg_cinematicCanPause", "1");
      level.player clearclienttriggeraudiozone(2);
      if(scripts\engine\utility::flag_exist("acceped_vr")) {
        scripts\engine\utility::flag_clear("acceped_vr");
      }

      func_CE8D(undefined, 0);
      func_E241();
      func_F620();
      setomnvar("ui_in_vr", 0);
      scripts\engine\utility::flag_clear("in_vr_mode");
      level.var_93A9 = undefined;
      level thread lib_0EE8::func_C608(0);
      break;
  }
}

func_F61F() {
  level.player playerlinktoabsolute(getent("start_vr_chamber", "targetname"));
  scripts\sp\utility::func_28D7("axis");
  level.player scripts\sp\utility::func_11428();
  level.player _meth_8559(0);
  if(issubstr(level.script, "shipcrib")) {
    setsuncolorandintensity(0);
  }

  wait(0.75);
  level.player unlink();
  level.player disableusability();
  if(issubstr(level.script, "shipcrib")) {
    level.var_EFED = "combat_vr";
  } else {
    level.player scripts\sp\utility::func_F526("normal");
    level.player thread scripts\sp\utility::func_2B77(0.5);
    level.player scripts\engine\utility::allow_mantle(1);
    level.player scripts\engine\utility::allow_weapon_switch(1);
    level.player scripts\engine\utility::allow_prone(1);
    level.player _meth_80A1();
    level.player getrankinfofull(1);
    level.player switchtoweaponimmediate(level.player getcurrentprimaryweapon());
    setsaveddvar("mantle_enable", 1);
    setsaveddvar("cg_drawCrosshair", 1);
    setomnvar("ui_hide_weapon_info", 0);
    setomnvar("ui_hide_hud", 0);
  }

  lib_0EE8::_meth_8311();
  level thread create_fx_pause();
  func_F60F();
  level thread func_1E3A();
}

func_F620() {
  level.player _meth_8475();
  level.player _meth_8559(1);
  level thread scripts\sp\gameskill::func_E080();
  level.player enableusability();
  scripts\sp\utility::func_28D8("axis");
  level thread create_fx_resume();
  if(issubstr(level.script, "shipcrib")) {
    setsuncolorandintensity(level.var_FD6E.var_111D7);
    return;
  }

  level.player scripts\sp\utility::func_11428();
  level.player scripts\engine\utility::allow_mantle(0);
  level.player scripts\engine\utility::allow_weapon_switch(0);
  level.player scripts\engine\utility::allow_prone(0);
  level.player getrankinfoxpamt();
  level.player getrankinfofull(0);
  setsaveddvar("mantle_enable", 0);
  setsaveddvar("cg_drawCrosshair", 0);
  setomnvar("ui_hide_weapon_info", 1);
}

func_12BA8() {
  foreach(var_01 in level.var_13563.var_653C) {
    if(var_01 islinked()) {
      var_01 unlink();
    }
  }

  foreach(var_04 in level.var_13563.var_E546) {
    if(var_04.var_EDD5 == 0) {
      var_04.var_D958 unlink();
    }

    foreach(var_06 in var_04.var_466A) {
      var_06.var_CBFA unlink();
      if(isDefined(var_06.var_6B71)) {
        foreach(var_08 in var_06.var_6B71) {
          var_08 unlink();
        }
      }
    }

    foreach(var_0C in var_04.segments) {
      var_0C.var_CBFA unlink();
      if(isDefined(var_0C.var_6E86)) {
        var_0C.var_6E86 unlink();
      }

      if(isDefined(var_0C.var_6B71)) {
        foreach(var_08 in var_0C.var_6B71) {
          var_08 unlink();
        }
      }
    }
  }
}

waittilbinkend() {
  while(iscinematicplaying()) {
    scripts\engine\utility::waitframe();
  }

  setsaveddvar("bg_cinematicAboveUI", "0");
}

func_CE8D(param_00, param_01) {
  level notify("playing_vr_tranistion_bink");
  level endon("playing_vr_tranistion_bink");
  if(!isDefined(param_00)) {
    param_00 = "ship_enter_vr";
  }

  if(!isDefined(param_01)) {
    param_01 = 0;
  }

  stopcinematicingame();
  wait(0.1);
  setsaveddvar("bg_cinematicFullScreen", "1");
  setsaveddvar("bg_cinematicCanPause", "0");
  setsaveddvar("bg_cinematicAboveUI", "1");
  if(param_01) {
    var_02 = "weapon_loadout_terminal_intro";
  } else {
    var_02 = "weapon_loadout_terminal_transition";
  }

  cinematicingame(var_02);
  while(!iscinematicplaying()) {
    scripts\engine\utility::waitframe();
  }

  level.player playSound(param_00);
  level thread waittilbinkend();
  while(iscinematicplaying()) {
    var_03 = cinematicgettimeinmsec();
    if(var_03 > 750) {
      level notify("vr_transition_bink_full_opacity");
      setomnvar("ui_close_vr_pause_menu", 1);
      break;
    }

    scripts\engine\utility::waitframe();
  }
}