/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: SP\3885.gsc
*********************************************/

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

func_661E(var_0) {
  setomnvar("ui_in_vr", 1);
  setomnvar("ui_close_vr_pause_menu", 0);
  scripts\engine\utility::flag_set("in_vr_mode");
  level.var_93A9 = 1;
  level.var_116D8.var_13558 = 1;
  level thread func_13598();
  level thread func_F61F();
  scripts\sp\outline::func_91A1("default", ::func_1356B);
  level thread func_6DA9(var_0);
}

func_1356B() {
  var_0["r_hudoutlineWidth"] = 3;
  var_0["cg_hud_outline_colors_5"] = "0.122 0.235 0.425 0.500";
  return var_0;
}

func_6DA9(var_0) {
  level endon("reset_vr");
  var_1 = undefined;
  var_2 = level.var_13563.var_E546[1].segments[0];
  var_3 = scripts\engine\utility::array_remove(level.var_13563.var_E546[1].segments, var_2);
  level thread func_A5D0();
  if(var_0) {
    func_9AD8();
  } else {
    func_9AD6();
  }

  for(var_4 = 0; var_4 < 3; var_4++) {
    func_669D(var_2, var_3, var_4);
    level thread func_2F0A(1);
    level thread func_4D96(level.var_13563.var_BF5A.var_CBFA.origin, 1);
    wait(0.75);
    func_106C8(level.var_13563.var_BF5A, var_4);
    func_A62A();
    func_12B92();
    wait(1.75);
    func_6B73(level.var_13563.var_BF5A, 0);
    level thread func_2F0A(0);
    var_5 = level.var_13563.var_BF5A.var_CBFA.origin + anglestoright(level.var_13563.var_BF5A.var_CBFA.angles) * -1792;
    level thread func_4D96(var_5, 0, 1, 1);
    var_3 = scripts\engine\utility::array_remove(var_3, level.var_13563.var_BF5A);
    var_2 = level.var_13563.var_BF5A;
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
  var_0 = level.var_13563.var_E546;
  var_1 = level.var_13563.var_E546[1].segments[0];
  level.var_13563.var_9B3D hide();
  foreach(var_3 in var_0) {
    var_4 = anglesToForward(var_3.angles) * 9408;
    var_5 = anglestoright(var_3.angles) * 608;
    var_3.origin = var_3.start_pos + var_4 + var_5;
    var_3 thread func_E53E("passive", 1, undefined, 1);
    level notify("vr_ring" + var_3.var_EDD5 + "_intro_show_geo");
    foreach(var_7 in var_3.var_466A) {
      var_7 show();
    }

    foreach(var_0A in var_3.segments) {
      if(isDefined(var_0A.var_6E86)) {
        var_0A.var_6E86 show();
      }

      var_0A show();
    }

    if(var_3 == level.var_13563.var_E546[1]) {
      continue;
    }

    var_3 rotateroll(90, 0.05);
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
  level.var_13563.var_2F09.origin = var_1.var_CBFA.origin;
  foreach(var_12 in level.var_13563.var_4D95) {
    var_12.origin = var_1.var_CBFA.origin + anglestoright(var_1.var_CBFA.angles) * -1792;
  }

  scripts\engine\utility::flag_clear("vr_delete_thrown_grenades");
  wait(0.25);
}

func_9AD6() {
  level endon("reset_vr");
  scripts\engine\utility::flag_set("vr_delete_thrown_grenades");
  var_0 = level.var_13563.var_E546;
  var_1 = level.var_13563.var_E546[1].segments[0];
  wait(1);
  level.player playSound("shipcrib_hud_loading_simulation");
  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    if(var_2 == 0) {
      var_0[var_2] playSound("scn_vr_enter");
    }

    var_0[var_2] thread func_E539();
    wait(0.25);
  }

  var_0[var_0.size - 1] waittill("vr_intro_part1");
  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    var_3 = 608;
    var_4 = 1.5;
    var_5 = 0.35;
    if(var_2 == 0) {
      var_6 = level.var_13563.var_9B3D;
      var_6 thread func_3108(0, 1);
    }

    var_0[var_2] thread func_E542(var_3, var_4, var_5);
    wait(0.125);
  }

  var_0[2] waittill("intro_finished");
  scripts\engine\utility::flag_clear("vr_delete_thrown_grenades");
  var_0[var_0.size - 1] waittill("intro_finished");
  level.var_13563.var_2F09.origin = var_1.var_CBFA.origin;
  foreach(var_8 in level.var_13563.var_4D95) {
    var_8.origin = var_1.var_CBFA.origin + anglestoright(var_1.var_CBFA.angles) * -1792;
  }

  wait(0.25);
}

func_E539(var_0) {
  level endon("reset_vr");
  thread scripts\sp\anim::func_1EC3(self, "vr_intro_part1");
  func_E53E("passive", 1, undefined, 1);
  foreach(var_2 in self.var_466A) {
    var_2 show();
  }

  wait(0.5);
  thread scripts\sp\anim::func_1F35(self, "vr_intro_part1");
  level waittill("vr_ring" + self.var_EDD5 + "_intro_show_geo");
  foreach(var_5 in self.segments) {
    if(isDefined(var_5.var_6E86)) {
      var_5.var_6E86 show();
    }

    var_5 show();
  }
}

func_E542(var_0, var_1, var_2) {
  level endon("reset_vr");
  func_E53E("active");
  self rotateroll(90, var_1, var_2, var_2);
  self moveto(self.origin + anglestoright(self.angles) * var_0, var_1, var_2, var_2);
  wait(var_1 + 0.05);
  func_E53E("passive");
  if(self == level.var_13563.var_E546[0]) {
    self.segments[0].var_6E86 playSound("scn_vr_enter_cap");
    foreach(var_4 in self.segments) {
      var_4.var_6E86 unlink();
      var_4.var_6E86 rotateroll(-90, 1, 0.25, 0.25);
    }
  }

  self notify("intro_finished");
}

func_669D(var_0, var_1, var_2) {
  level endon("reset_vr");
  if(var_2 == 0) {
    level.var_13563.var_BF5A = var_0;
    level.var_13563.var_BF5B[0] = level.var_13563.var_E546[1].var_466A[0];
    level.var_13563.var_BF5B[1] = level.var_13563.var_E546[1].var_466A[1];
    var_3 = undefined;
    var_4 = undefined;
    var_5 = 0;
  } else if(var_5 == 1) {
    var_4 = undefined;
    var_4 = level.var_13563.var_E546[1].segments;
    level.var_13563.var_BF5A = var_2[randomint(var_2.size)];
    var_5 = 0;
  } else {
    var_4 = undefined;
    var_4 = level.var_13563.var_E546[1].segments;
    level.var_13563.var_BF5A = var_2[randomint(var_2.size)];
    var_5 = 1;
  }

  if(var_2 == 0) {
    func_6B74(level.var_13563.var_BF5A, 0);
    level thread func_F188(level.var_13563.var_BF5A, 1);
    level.player playSound("shipcrib_hud_activate_simulation");
    return;
  }

  if(var_0 == var_3[0]) {
    if(level.var_13563.var_BF5A == var_3[1]) {
      var_4 = "negative_90";
      level.var_13563.var_BF5B[0] = level.var_13563.var_E546[1].var_466A[1];
      level.var_13563.var_BF5B[1] = level.var_13563.var_E546[1].var_466A[2];
    } else if(level.var_13563.var_BF5A == var_3[2]) {
      var_4 = "positive_180";
      level.var_13563.var_BF5B[0] = level.var_13563.var_E546[1].var_466A[2];
      level.var_13563.var_BF5B[1] = level.var_13563.var_E546[1].var_466A[3];
    } else {
      var_4 = "positive_90";
      level.var_13563.var_BF5B[0] = level.var_13563.var_E546[1].var_466A[3];
      level.var_13563.var_BF5B[1] = level.var_13563.var_E546[1].var_466A[0];
    }
  } else if(var_0 == var_3[1]) {
    if(level.var_13563.var_BF5A == var_3[2]) {
      var_4 = "negative_90";
      level.var_13563.var_BF5B[0] = level.var_13563.var_E546[1].var_466A[2];
      level.var_13563.var_BF5B[1] = level.var_13563.var_E546[1].var_466A[3];
    } else if(level.var_13563.var_BF5A == var_3[3]) {
      var_4 = "positive_180";
      level.var_13563.var_BF5B[0] = level.var_13563.var_E546[1].var_466A[3];
      level.var_13563.var_BF5B[1] = level.var_13563.var_E546[1].var_466A[0];
    }
  } else if(var_0 == var_3[2]) {
    if(level.var_13563.var_BF5A == var_3[1]) {
      var_4 = "positive_90";
      level.var_13563.var_BF5B[0] = level.var_13563.var_E546[1].var_466A[1];
      level.var_13563.var_BF5B[1] = level.var_13563.var_E546[1].var_466A[2];
    } else if(level.var_13563.var_BF5A == var_3[3]) {
      var_4 = "negative_90";
      level.var_13563.var_BF5B[0] = level.var_13563.var_E546[1].var_466A[3];
      level.var_13563.var_BF5B[1] = level.var_13563.var_E546[1].var_466A[0];
    }
  } else if(var_0 == var_3[3]) {
    if(level.var_13563.var_BF5A == var_3[1]) {
      var_4 = "negative_180";
      level.var_13563.var_BF5B[0] = level.var_13563.var_E546[1].var_466A[1];
      level.var_13563.var_BF5B[1] = level.var_13563.var_E546[1].var_466A[2];
    } else if(level.var_13563.var_BF5A == var_3[2]) {
      var_4 = "positive_90";
      level.var_13563.var_BF5B[0] = level.var_13563.var_E546[1].var_466A[2];
      level.var_13563.var_BF5B[1] = level.var_13563.var_E546[1].var_466A[3];
    }
  }

  level.player playSound("shipcrib_hud_cleared_simulation");
  level thread func_A62B(1);
  func_DFED();
  scripts\engine\utility::flag_set("vr_delete_thrown_grenades");
  level thread func_A5BD(level.var_13563.var_E546[2]);
  switch (var_4) {
    case "positive_90":
    case "negative_90":
      level.player playSound("scn_vr_rotate_90");
      if(var_5) {
        level.player scripts\engine\utility::delaycall(1.5, ::playsound, "scn_vr_unfold_side");
      }
      break;

    case "negative_180":
    case "positive_180":
      level.player playSound("scn_vr_rotate_180");
      if(var_5) {
        level.player scripts\engine\utility::delaycall(3, ::playsound, "scn_vr_unfold_side");
      }
      break;

    default:
      break;
  }

  for(var_6 = 0; var_6 < level.var_13563.var_E546.size; var_6++) {
    if(level.var_13563.var_BF5A == var_3[1]) {
      var_7 = 1;
    } else if(level.var_13563.var_BF5A == var_3[2]) {
      var_7 = 2;
    } else {
      var_7 = 3;
    }

    if(var_6 == 0) {
      level.var_13563.var_E546[var_6] thread func_1266B(var_4, var_5, var_7);
    } else {
      level.var_13563.var_E546[var_6] thread func_12669(var_4, var_5, var_7);
    }

    wait(0.125);
  }

  level.var_13563.var_E546[1] scripts\sp\utility::func_65E8("ring_spinning");
  level.var_13563.var_BF5A scripts\sp\utility::func_65E8("segment_dropping_geo");
  level thread func_F188(level.var_13563.var_BF5A, 1);
  wait(0.25);
}

func_12669(var_0, var_1, var_2) {
  level endon("reset_vr");
  scripts\sp\utility::func_65E1("ring_spinning");
  func_E53E("active");
  var_3 = 1.5;
  var_4 = 0.35;
  if(var_0 == "positive_90") {
    self rotateroll(90, var_3, var_4, var_4);
  } else if(var_0 == "negative_90") {
    self rotateroll(-90, var_3, var_4, var_4);
  } else if(var_0 == "positive_180") {
    var_3 = var_3 * 2;
    var_4 = var_4 * 1.5;
    self rotateroll(180, var_3, var_4, var_4);
  } else if(var_0 == "negative_180") {
    var_3 = var_3 * 2;
    var_4 = var_4 * 1.5;
    self rotateroll(-180, var_3, var_4, var_4);
  }

  wait(var_3 + 0.1);
  self notify("rotation_done");
  if(self == level.var_13563.var_E546[1]) {
    level thread func_6B74(level.var_13563.var_BF5A, 0);
  }

  func_E53E("passive");
  scripts\sp\utility::func_65DD("ring_spinning");
  if(var_1) {
    thread func_12673("left", var_2);
    thread func_12673("right", var_2);
    if(self == level.var_13563.var_E546[1]) {
      level waittill("corner_dropping_geo");
      func_6B74(level.var_13563.var_BF5A, 1);
    }
  }
}

func_1266B(var_0, var_1, var_2) {
  level endon("reset_vr");
  func_E53E("active");
  var_3 = 1.5;
  var_4 = 0.35;
  if(var_0 == "positive_180") {
    var_3 = var_3 * 2;
  } else if(var_0 == "negative_180") {
    var_3 = var_3 * 2;
  }

  wait(var_3 + 0.1);
  func_E53E("passive");
  if(var_1) {
    func_E53E("active");
    var_3 = getanimlength( % vr_unfold_left);
    wait(var_3);
    func_E53E("passive");
  }
}

func_12673(var_0, var_1) {
  level endon("reset_vr");
  var_2 = undefined;
  var_3 = undefined;
  var_4 = undefined;
  if(var_0 == "left") {
    if(var_1 == 0) {
      var_2 = "tag_corner0_bottom";
      var_3 = 3;
      var_4 = 0;
    } else if(var_1 == 1) {
      var_2 = "tag_corner1_bottom";
      var_3 = 0;
      var_4 = 1;
    } else if(var_1 == 2) {
      var_2 = "tag_corner2_bottom";
      var_3 = 1;
      var_4 = 2;
    } else if(var_1 == 3) {
      var_2 = "tag_corner3_bottom";
      var_3 = 2;
      var_4 = 3;
    }
  } else if(var_0 == "right") {
    if(var_1 == 0) {
      var_2 = "tag_corner1_top";
      var_3 = 1;
      var_4 = 1;
    } else if(var_1 == 1) {
      var_2 = "tag_corner2_top";
      var_3 = 2;
      var_4 = 2;
    } else if(var_1 == 2) {
      var_2 = "tag_corner3_top";
      var_3 = 3;
      var_4 = 3;
    } else if(var_1 == 3) {
      var_2 = "tag_corner0_top";
      var_3 = 0;
      var_4 = 0;
    }
  }

  func_12B95(var_0, var_2, var_1, var_3, var_4);
}

func_12B95(var_0, var_1, var_2, var_3, var_4) {
  level endon("reset_vr");
  var_5 = self gettagorigin(var_1);
  var_6 = vectortoangles(anglesToForward(self.angles));
  var_7 = scripts\sp\utility::func_10639("vr_unfold_" + var_0 + "_rig", var_5, var_6);
  var_7 hide();
  level.var_13563.var_12B98[level.var_13563.var_12B98.size] = var_7;
  var_8 = self.segments[var_3];
  var_9 = self.var_466A[var_4];
  var_8.var_CBFA unlink();
  var_8.var_CBFA linkto(var_7, "tag_segment", (0, 0, 0), (0, 0, 0));
  var_9.var_CBFA unlink();
  var_9.var_CBFA linkto(var_7, "tag_corner_bottom", (0, 0, 0), (0, 0, 0));
  func_E53E("active");
  scripts\sp\utility::func_65E1("ring_unfolding");
  var_7 scripts\sp\anim::func_1F35(var_7, "vr_unfold");
  func_E53E("passive");
  if(isDefined(var_9.var_1078F)) {
    var_9.var_1078F.var_A534 = var_0;
    var_9 func_57F2(level.var_13563.var_BF5A);
    level thread func_6B74(var_8, 1);
    wait(0.25);
    level thread func_6B74(var_9, 1);
    level thread scripts\sp\utility::func_C12D("corner_dropping_geo", 0.25);
    var_9 scripts\sp\utility::func_65E8("segment_dropping_geo");
  }

  scripts\sp\utility::func_65DD("ring_unfolding");
}

func_E53E(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_3)) {
    var_3 = 0;
  }

  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  if(!isDefined(var_2)) {
    var_2 = 0;
  }

  if(var_0 == "passive") {
    foreach(var_5 in self.var_466A) {
      var_5.var_AC84 _meth_82FC(var_5.var_AC84.var_10BF7);
      var_5.var_6128 show();
      var_5.var_6123 hide();
      if(var_1) {
        var_5.var_AC84 setlightintensity(var_5.var_AC84.script_intensity_01);
        continue;
      }

      if(var_2) {
        var_5.var_AC84 setlightintensity(0);
        var_5.var_6128 hide();
        var_5.var_6123 hide();
      }
    }
  } else if(var_0 == "active") {
    foreach(var_5 in self.var_466A) {
      var_5.var_AC84 _meth_82FC(var_5.var_AC84.var_62C0);
      var_5.var_6128 hide();
      var_5.var_6123 show();
      if(var_1) {
        var_5.var_AC84 setlightintensity(var_5.var_AC84.script_intensity_01);
        continue;
      }

      if(var_2) {
        var_5.var_AC84 setlightintensity(0);
        var_5.var_6128 hide();
        var_5.var_6123 hide();
      }
    }
  }

  if(self == level.var_13563.var_E546[0] || self == level.var_13563.var_E546[5]) {
    thread func_E53F(var_0, var_1, var_2, var_3);
  }
}

func_E53F(var_0, var_1, var_2, var_3) {
  level endon("reset_vr");
  var_4 = [self.segments[1], self.segments[3]];
  if(var_3) {
    level waittill("vr_ring" + self.var_EDD5 + "_intro_show_geo");
  }

  if(var_0 == "passive") {
    foreach(var_6 in var_4) {
      if(isDefined(var_6.var_6E86)) {
        if(isDefined(var_6.var_6E86.var_6128)) {
          var_6.var_6E86.var_6128 show();
          var_6.var_6E86.var_6123 hide();
          if(var_2) {
            var_6.var_6E86.var_6128 hide();
            var_6.var_6E86.var_6123 hide();
          }
        }
      }

      if(isDefined(var_6.var_6128)) {
        var_6.var_6128 show();
        var_6.var_6123 hide();
        if(var_2) {
          var_6.var_6128 hide();
          var_6.var_6123 hide();
        }
      }
    }

    return;
  }

  if(var_0 == "active") {
    foreach(var_6 in self.segments) {
      if(isDefined(var_6.var_6E86)) {
        if(isDefined(var_6.var_6E86.var_6128)) {
          var_6.var_6E86.var_6128 hide();
          var_6.var_6E86.var_6123 show();
          if(var_2) {
            var_6.var_6E86.var_6128 hide();
            var_6.var_6E86.var_6123 hide();
          }
        }
      }

      if(isDefined(var_6.var_6128)) {
        var_6.var_6128 hide();
        var_6.var_6123 show();
        if(var_2) {
          var_6.var_6128 hide();
          var_6.var_6123 hide();
        }
      }
    }
  }
}

func_6B74(var_0, var_1) {
  level endon("reset_vr");
  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  if(isDefined(var_0.var_6B71)) {
    var_0 scripts\sp\utility::func_65E1("segment_dropping_geo");
    if(!var_1) {
      if(var_0 == level.var_13563.var_E546[1].segments[0]) {
        var_0 playSound("vr_blocks_in_and_hit_01");
      } else if(var_0 == level.var_13563.var_E546[1].segments[1]) {
        var_0 playSound("vr_blocks_in_and_hit_02");
      } else if(var_0 == level.var_13563.var_E546[1].segments[2]) {
        var_0 playSound("vr_blocks_in_and_hit_03");
      } else if(var_0 == level.var_13563.var_E546[1].segments[3]) {
        var_0 playSound("vr_blocks_in_and_hit_04");
      }
    } else if(isDefined(var_0.var_1078F)) {
      if(var_0.var_1078F.var_A534 == "left") {
        var_0 playSound("vr_blocks_in_bridge_left");
      } else {
        var_0 playSound("vr_blocks_in_bridge_right");
      }
    }

    for(var_2 = 0; var_2 < var_0.var_6B71.size; var_2++) {
      var_3 = var_0.var_6B71[var_2];
      if(var_1) {
        if(!isDefined(var_3.script_parameters)) {
          continue;
        }

        if(var_3.script_parameters == "unfold") {
          var_3 thread func_6B72();
          wait(0.05);
        }

        continue;
      }

      if(isDefined(var_3.script_parameters)) {
        if(var_3.script_parameters == "unfold") {
          continue;
        }
      }

      var_3 thread func_6B72();
      wait(0.1);
    }

    wait(0.3);
    var_0 scripts\sp\utility::func_65DD("segment_dropping_geo");
  }
}

func_6B72() {
  var_0 = self.var_8D0D * -1;
  var_1 = self.origin + (0, 0, var_0);
  func_F188(level.var_13563.var_BF5A, 0, self.var_7595, var_1, self.var_7587, anglestoup(self.angles));
  self unlink();
  self show();
  self moveto(var_1, 0.25);
}

func_2F0A(var_0) {
  if(var_0) {
    level.var_13563.var_2F09 thread func_3108(1);
    return;
  }

  level.var_13563.var_2F09 thread func_3108(0);
}

func_4D96(var_0, var_1, var_2, var_3) {
  level notify("data_box_moving");
  level endon("reset_vr");
  level endon("data_box_moving");
  if(!isDefined(var_1)) {
    var_1 = 1;
  }

  if(!isDefined(var_2)) {
    var_2 = 0;
  }

  if(!isDefined(var_3)) {
    var_3 = 0;
  }

  foreach(var_5 in level.var_13563.var_4D95) {
    var_5 thread func_4D97(var_0, var_1, var_2, var_3);
    if(!var_3) {
      wait(0.125);
    }
  }
}

func_4D97(var_0, var_1, var_2, var_3) {
  if(var_1) {
    thread func_3108(1);
  } else if(var_2) {
    thread func_3108(0, 1);
  }

  if(isDefined(self.var_A645) && var_1) {
    self.var_A645 playSound("killcounter_appear");
    self.var_A645 thread func_3108(1);
  } else if(isDefined(self.var_A645) && var_2) {
    self.var_A645 playSound("killcounter_disappear");
    self.var_A645 thread func_3108(0, 1);
  }

  if(var_3) {
    self waittill("vr_flicker_done");
    self moveto(var_0, 0.05);
    return;
  }

  self moveto(var_0, 0.5, 0.125, 0.125);
}

func_3108(var_0, var_1) {
  self notify("vr_flicker");
  level endon("reset_vr");
  self endon("vr_flicker");
  var_2 = 0.1;
  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  if(var_1) {
    var_3 = 3;
  } else {
    var_3 = 5;
  }

  if(var_0) {
    for(var_4 = 0; var_4 < var_3; var_4++) {
      if(var_4 > 2) {
        var_2 = 0.15;
      }

      self hide();
      wait(randomfloatrange(0.05, var_2));
      self show();
      wait(randomfloatrange(0.05, var_2));
    }
  } else {
    for(var_4 = 0; var_4 < var_3; var_4++) {
      if(var_4 > 2) {
        var_2 = 0.15;
      }

      self show();
      wait(randomfloatrange(0.05, var_2));
      self hide();
      wait(randomfloatrange(0.05, var_2));
    }
  }

  self notify("vr_flicker_done");
}

func_A647() {
  var_0 = level.var_13563.var_63A1;
  var_1 = var_0.size;
  var_2 = [level.var_13563.var_4D95["front_top_right"].var_A645, level.var_13563.var_4D95["rear_top_left"].var_A645, level.var_13563.var_4D95["rear_top_right"].var_A645];
  foreach(var_4 in var_2) {
    var_4 thread func_A646();
    if(var_1 != var_4.var_4B5B) {
      var_4 hidepart("tag_num" + var_4.var_4B5B);
      var_4 giveperk("tag_num" + var_1);
      var_4.var_4B5B = var_1;
    }

    if(var_1 == 0) {
      foreach(var_6 in var_4.var_1141C) {
        var_4 hidepart(var_6);
      }

      continue;
    }

    for(var_8 = 1; var_8 < var_4.var_1141C.size; var_8++) {
      if(var_8 <= var_1) {
        var_4 giveperk("tag_boxcounter" + var_8);
        continue;
      }

      var_4 hidepart("tag_boxcounter" + var_8);
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

func_106C8(var_0, var_1) {
  level endon("reset_vr");
  var_2 = [];
  var_3 = [];
  if(isDefined(level.var_13563.var_46C6)) {
    var_2 = func_799F(var_0, level.var_13563.var_46C6, 4);
    if(isDefined(level.var_13563.var_46C7)) {
      if(level.var_13563.var_46C7 != level.var_13563.var_46C6) {
        var_3 = func_799F(var_0, level.var_13563.var_46C7, 4);
      }
    }
  } else {
    var_2 = func_799F(var_0, level.var_13563.var_46C7, 4);
  }

  if(var_1 == 0) {
    level.var_13563.var_10691 = 2;
    level.var_13563.var_1087E[0] func_1085F(var_0, var_2[0], 0);
    if(var_3.size > 0) {
      level.var_13563.var_1087E[1] func_1085F(var_0, var_3[0], 0);
    } else {
      level.var_13563.var_1087E[1] func_1085F(var_0, var_2[1], 0);
    }

    level waittill("equipment_range_enemies_dead");
    return;
  }

  if(var_1 == 1) {
    level.var_13563.var_10691 = 4;
    level.var_13563.var_1087E[0] func_1085F(var_0, var_2[0], 0);
    if(var_3.size > 0) {
      level.var_13563.var_1087E[1] func_1085F(var_0, var_3[0], 0);
    } else {
      level.var_13563.var_1087E[1] func_1085F(var_0, var_2[1], 0);
    }

    wait(1);
    if(var_3.size > 0) {
      level.var_13563.var_1087E[2] func_1085F(var_0, var_2[1], 0);
      level.var_13563.var_1087E[3] func_1085F(var_0, var_3[1], 0);
    } else {
      level.var_13563.var_1087E[2] func_1085F(var_0, var_2[2], 0);
      level.var_13563.var_1087E[3] func_1085F(var_0, var_2[3], 0);
    }

    level waittill("equipment_range_enemies_dead");
    return;
  }

  if(var_1 > 1) {
    level.var_13563.var_10691 = 5;
    level.var_13563.var_1087E[0] func_1085F(var_0, var_2[0], 0);
    if(var_3.size > 0) {
      level.var_13563.var_1087E[1] func_1085F(var_0, var_3[0], 0);
      level.var_13563.var_1087E[2] func_1085F(var_0, var_2[1], 0);
    } else {
      level.var_13563.var_1087E[1] func_1085F(var_0, var_2[1], 0);
      level.var_13563.var_1087E[2] func_1085F(var_0, var_2[2], 0);
    }

    wait(1);
    level.var_13563.var_E546[1] scripts\sp\utility::func_65E8("ring_unfolding");
    for(var_4 = 3; var_4 < 4; var_4++) {
      var_5 = level.var_13563.var_BF5B[0];
      level.var_13563.var_1087E[var_4] func_1085F(var_5, var_5.var_1078F, 1);
    }

    for(var_4 = 4; var_4 < 5; var_4++) {
      var_5 = level.var_13563.var_BF5B[1];
      level.var_13563.var_1087E[var_4] func_1085F(var_5, var_5.var_1078F, 1);
    }

    level waittill("equipment_range_enemies_dead");
    return;
  }
}

func_F60F() {
  var_0 = level.player _meth_84C6("selectedLoadout");
  var_1 = level.player _meth_84C6("loadouts", var_0, "weaponSetups", 0, "weapon");
  var_2 = level.player _meth_84C6("loadouts", var_0, "weaponSetups", 1, "weapon");
  var_3 = scripts\sp\loadout::func_31CE(0, var_0);
  var_4 = scripts\sp\loadout::func_31CE(1, var_0);
  if(isDefined(var_3) || isDefined(var_4)) {
    level.var_13563.var_46C6 = func_78E8(var_3);
    level.var_13563.var_46C7 = func_78E8(var_4);
    return;
  }

  level.var_13563.var_46C6 = "medium";
  level.var_13563.var_46C7 = undefined;
}

func_78E8(var_0) {
  if(!isDefined(var_0)) {
    return undefined;
  }

  var_1 = weaponclass(var_0);
  switch (var_1) {
    case "rifle":
      var_2 = "medium";
      break;

    case "mg":
      var_2 = "medium";
      break;

    case "smg":
      var_2 = "close";
      break;

    case "sniper":
      var_2 = "long";
      break;

    case "pistol":
      var_2 = "close";
      break;

    case "spread":
      var_2 = "close";
      break;

    case "beam":
      var_2 = "medium";
      break;

    default:
      var_2 = "medium";
      break;
  }

  return var_2;
}

func_799F(var_0, var_1, var_2) {
  var_3 = [];
  var_4 = [];
  var_5 = [];
  var_6 = [];
  foreach(var_8 in var_0.var_10870) {
    if(var_8.script_parameters == "long") {
      var_4[var_4.size] = var_8;
    }

    if(var_8.script_parameters == "medium") {
      var_5[var_5.size] = var_8;
    }

    if(var_8.script_parameters == "close") {
      var_6[var_6.size] = var_8;
    }
  }

  switch (var_1) {
    case "long":
      var_3 = scripts\engine\utility::array_randomize(var_4);
      break;

    case "medium":
      var_3 = scripts\engine\utility::array_randomize(var_5);
      break;

    case "close":
      var_3 = scripts\engine\utility::array_randomize(var_6);
      break;
  }

  var_0A = [];
  for(var_0B = 0; var_0B < var_2; var_0B++) {
    if(var_0B > var_3.size - 1) {
      break;
    }

    var_0A[var_0A.size] = var_3[var_0B];
  }

  return scripts\engine\utility::array_randomize(var_0A);
}

func_1085F(var_0, var_1, var_2) {
  level endon("reset_vr");
  if(var_2) {
    if(var_1.var_A534 == "left") {
      var_3 = level.var_13563.var_BF5A.var_12B96;
      self.angles = vectortoangles(anglesToForward(var_1.angles));
    } else {
      var_3 = level.var_13563.var_BF5A.var_12B97;
      self.angles = vectortoangles(anglesToForward(var_1.angles) * -1);
    }
  } else {
    var_3 = getnode(var_2.target, "targetname");
    self.angles = var_1.angles;
  }

  self.var_C1 = 1;
  self.target = var_3.var_336;
  self.origin = var_0.var_CBFA.origin + var_1.var_F187;
  self.var_EDE3 = 1;
  var_3.fgetarg = 128;
  level thread scripts\engine\utility::play_sound_in_space("vr_enemy_spawn", self.origin);
  var_4 = self.origin + anglestoup(self.angles) * 300;
  var_5 = anglestoup(self.angles) * -1;
  var_6 = anglesToForward(self.angles);
  func_F188(var_0, 0, "vfx_vr_enemy_spawn", var_4, var_5, var_6);
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
  var_0 = ["j_head", "j_chest", "j_shoulder_ri", "j_shoulder_le", "j_elbow_ri", "j_elbow_le", "j_hip_ri", "j_hip_le", "j_knee_ri", "j_knee_le"];
  var_1 = var_0.size;
  for(var_2 = 0; var_2 < var_1; var_2++) {
    var_3 = var_0[var_2];
    var_4 = self gettagorigin(var_3);
    var_5 = self gettagangles(var_3);
    var_6 = self.var_DC;
    if(var_6 == (0, 0, 0)) {
      var_7 = getent("start_vr_chamber", "targetname");
      var_6 = anglesToForward(var_7.angles);
    }

    var_8 = anglestoup(var_5);
    func_F188(level.var_13563.var_BF5A, 0, "vfx_vr_enemy_death", var_4, var_6, var_8);
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
  var_0 = func_336D();
  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    var_2 = var_0[var_1];
    var_3 = self gettagorigin(var_2);
    var_4 = self gettagangles(var_2);
    var_5 = self.var_DC;
    if(var_5 == (0, 0, 0)) {
      var_6 = getent("start_vr_chamber", "targetname");
      var_5 = anglesToForward(var_6.angles);
    }

    var_7 = anglestoup(var_4);
    func_F188(level.var_13563.var_BF5A, 0, "vfx_vr_enemy_death", var_3, var_5, var_7);
  }

  if(!isDefined(self.var_4E68) || self.var_4E68 != 1) {
    level thread scripts\engine\utility::play_sound_in_space("vr_enemy_death", self gettagorigin("J_Neck"));
  }

  wait(0.1);
  self delete();
  return 1;
}

func_336D() {
  var_0 = ["j_head", "j_spineupper", "j_shoulder_ri", "j_shoulder_le", "j_elbow_ri", "j_elbow_le", "j_hip_ri", "j_hip_le", "j_knee_ri", "j_knee_le"];
  if(lib_0A0B::func_7C35("left_leg") == "dismember") {
    var_0 = scripts\engine\utility::array_remove_array(var_0, ["j_hip_le", "j_knee_le"]);
  }

  if(lib_0A0B::func_7C35("right_leg") == "dismember") {
    var_0 = scripts\engine\utility::array_remove_array(var_0, ["j_hip_ri", "j_knee_ri"]);
  }

  if(lib_0A0B::func_7C35("left_arm") == "dismember") {
    var_0 = scripts\engine\utility::array_remove_array(var_0, ["j_shoulder_le", "j_elbow_le"]);
  }

  if(lib_0A0B::func_7C35("right_arm") == "dismember") {
    var_0 = scripts\engine\utility::array_remove_array(var_0, ["j_shoulder_ri", "j_elbow_ri"]);
  }

  if(lib_0A0B::func_7C35("torso") == "dismember") {
    var_0 = scripts\engine\utility::array_remove_array(var_0, ["j_spineupper"]);
  }

  return var_0;
}

func_A62A() {
  var_0 = level.var_13563.var_63A1;
  clearallcorpses();
  foreach(var_2 in var_0) {
    if(isDefined(var_2.var_FE4A)) {
      if(var_2.var_FE4A) {
        killfxontag(level.var_7649[var_2.unittype + "_death"], var_2, "j_spine4");
      }
    }

    var_2.var_4E68 = 1;
    var_2 _meth_81D0();
  }
}

func_13566(var_0) {
  level endon("reset_vr");
  if(scripts\engine\utility::flag("vr_delete_thrown_grenades")) {
    if(isDefined(var_0)) {
      var_1 = undefined;
      if(issubstr(var_0.model, "seeker")) {
        var_2 = "seeker";
      } else if(issubstr(var_1.model, "emp")) {
        var_2 = "emp";
      } else if(issubstr(var_1.model, "anti_grav")) {
        var_2 = "antigrav";
      } else if(issubstr(var_1.model, "frag")) {
        var_2 = "frag";
      } else if(issubstr(var_1.model, "foam")) {
        var_2 = "coverwall";
      } else if(issubstr(var_1.model, "drone")) {
        var_2 = var_1.origin;
        var_2 = "drone";
      } else {
        return;
      }

      var_0 _meth_85AC();
      if(scripts\engine\utility::flag("vr_delete_thrown_grenades")) {
        switch (var_2) {
          case "seeker":
            level thread lib_0E26::func_DFC1();
            scripts\engine\utility::flag_waitopen("seeker_force_delete");
            var_3 = level.var_F10A.var_A8C6;
            break;

          case "emp":
            level thread lib_0E25::func_DFBE();
            scripts\engine\utility::flag_waitopen("emp_force_delete");
            var_3 = level.var_612D.var_A8C6;
            break;

          case "antigrav":
            level thread lib_0E21::func_DFBA();
            scripts\engine\utility::flag_waitopen("antigrav_force_delete");
            var_3 = level.var_2006.var_A8C6;
            break;

          case "coverwall":
            level thread scripts\sp\coverwall::func_DFBD();
            scripts\engine\utility::flag_waitopen("coverwall_force_delete");
            var_3 = level.player.var_4759.var_A8C6;
            break;

          case "frag":
            level thread scripts\sp\detonategrenades::func_DFBF();
            scripts\engine\utility::flag_waitopen("frag_force_delete");
            var_3 = level.newteamhudelem.var_A8C6;
            break;

          case "drone":
            level thread lib_0E2D::func_5139();
            var_3 = var_2;
            break;

          default:
            var_3 = undefined;
            break;
        }

        if(var_2 == "drone") {
          level thread func_DFF0(0);
          return;
        }

        if(isDefined(var_3)) {
          level thread _meth_859E("vfx_vr_equipment_derez", var_3);
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
  var_0 = getent("vr_thrown_grenade_trigger", "targetname");
  for(;;) {
    if(self istouching(var_0)) {
      scripts\engine\utility::waitframe();
      continue;
    }

    break;
  }
}

func_DFED(var_0) {
  level endon("reset_vr");
  if(!isDefined(var_0)) {
    var_0 = 0;
  }

  level thread func_DFF0(var_0);
  level thread func_DFF3(var_0);
  level thread func_DFF1(var_0);
  level thread func_DFEE(var_0);
  level thread func_DFEF(var_0);
  level thread func_DFF2(var_0);
  if(!var_0) {
    scripts\engine\utility::flag_waitopen("seeker_force_delete");
    scripts\engine\utility::flag_waitopen("emp_force_delete");
    scripts\engine\utility::flag_waitopen("antigrav_force_delete");
    scripts\engine\utility::flag_waitopen("coverwall_force_delete");
    scripts\engine\utility::flag_waitopen("frag_force_delete");
  }
}

func_DFF0(var_0) {
  level thread lib_0E2D::func_5139();
  level thread lib_0E2D::func_5138();
  foreach(var_2 in level.player.var_4C29) {
    if(isDefined(var_2.var_51BA)) {
      if(var_2.var_51BA) {
        continue;
      }
    }

    if(isDefined(var_2.var_C7B4)) {
      if(var_2.var_C7B4) {
        continue;
      }
    }

    if(!var_0) {
      level thread missilethermal("vfx_vr_equipment_derez", var_2);
    }
  }
}

func_DFF3(var_0) {
  if(!var_0) {
    foreach(var_2 in level.var_F10A.var_162D) {
      level thread _meth_859E("vfx_vr_equipment_derez", var_2.origin);
    }

    foreach(var_5 in level.var_F10A.var_1633) {
      level thread _meth_859E("vfx_vr_equipment_derez", var_5.origin);
    }
  }

  lib_0E26::func_DFC1();
}

func_DFF1(var_0) {
  if(!var_0) {
    foreach(var_2 in level.var_612D.var_522C) {
      level thread _meth_859E("vfx_vr_equipment_derez", var_2.origin + (0, 0, 16));
    }
  }

  lib_0E25::func_DFBE();
}

func_DFEE(var_0) {
  if(!var_0) {
    foreach(var_2 in level.var_2006.var_522B) {
      level thread _meth_859E("vfx_vr_equipment_derez", var_2.origin + (0, 0, 16));
    }
  }

  lib_0E21::func_DFBA();
}

func_DFEF(var_0) {
  if(!var_0) {
    foreach(var_2 in level.player.var_4759.var_11168) {
      if(isDefined(var_2.objective_position)) {
        var_3 = var_2.objective_position.origin;
      } else {
        var_3 = var_2.origin;
      }

      level thread _meth_859E("vfx_vr_equipment_derez", var_3 + (0, 0, 16));
    }
  }

  scripts\sp\coverwall::func_DFBD();
}

func_DFF2(var_0) {
  if(!var_0) {
    foreach(var_2 in level.newteamhudelem.var_B37A) {
      var_3 = var_2.origin;
      level thread _meth_859E("vfx_vr_equipment_derez", var_3);
    }
  }

  scripts\sp\detonategrenades::func_DFBF();
}

_meth_859E(var_0, var_1) {
  level endon("reset_vr");
  var_2 = spawnfx(scripts\engine\utility::getfx(var_0), var_1);
  triggerfx(var_2);
  level thread scripts\engine\utility::play_sound_in_space("emp_shock_short", var_1);
  var_2.var_F185 = 0;
  level.var_13563.var_760D[level.var_13563.var_760D.size] = var_2;
  wait(1.5);
  level.var_13563.var_760D = scripts\engine\utility::array_remove(level.var_13563.var_760D, var_2);
  var_2 delete();
}

missilethermal(var_0, var_1) {
  level endon("reset_vr");
  if(isDefined(var_1.var_9A96)) {
    while(var_1.var_9A96) {
      scripts\engine\utility::waitframe();
    }
  }

  var_2 = spawnfx(scripts\engine\utility::getfx(var_0), var_1.var_5BD7.origin);
  triggerfx(var_2);
  level thread scripts\engine\utility::play_sound_in_space("emp_shock_short", var_1.var_5BD7.origin);
  var_2.var_F185 = 0;
  level.var_13563.var_760D[level.var_13563.var_760D.size] = var_2;
  wait(1.5);
  level.var_13563.var_760D = scripts\engine\utility::array_remove(level.var_13563.var_760D, var_2);
  var_2 delete();
}

func_A5BD(var_0) {
  level endon("reset_vr");
  var_0 waittill("rotation_done");
  scripts\engine\utility::flag_clear("vr_delete_thrown_grenades");
}

func_A5D0() {
  level endon("reset_vr");
  var_0 = getent("vr_trigger_kill_equipment", "targetname");
  for(;;) {
    var_0 waittill("trigger", var_1);
    if(var_1.unittype == "seeker") {
      level thread _meth_859E("vfx_vr_equipment_derez", var_1.origin);
      var_1 thread lib_0E26::func_E084();
    }
  }
}

func_1E3A() {
  level endon("reset_vr");
  for(;;) {
    level.player scripts\engine\utility::waittill_any_3("reload_start", "weapon_switch_started", "offhand_fired", "weapon_fired");
    var_0 = undefined;
    var_1 = undefined;
    var_2 = undefined;
    var_3 = undefined;
    var_4 = level.player getcurrentprimaryweapon();
    var_5 = weaponclipsize(var_4);
    var_6 = level.player getweaponammostock(var_4);
    var_7 = scripts\sp\utility::func_7BD6();
    var_8 = scripts\sp\utility::func_7C3D();
    var_9 = scripts\sp\utility::func_7CAF();
    var_0A = scripts\sp\utility::func_7CB1();
    if(isDefined(var_7) && var_7 != "none") {
      var_0 = level.player getweaponammoclip(var_7);
    }

    if(isDefined(var_8) && var_8 != "none") {
      var_1 = level.player getweaponammoclip(var_8);
    }

    if(isDefined(var_9) && var_9 != "none") {
      var_2 = level.player getweaponammoclip(var_9);
    }

    if(isDefined(var_0A) && var_0A != "none") {
      var_3 = level.player getweaponammoclip(var_0A);
    }

    if(lib_0A2F::func_DA40(var_4)) {
      if(issubstr(var_4, "chargeshot") || issubstr(var_4, "penetrationrail")) {
        var_0B = 2;
        if(level.player getcurrentweaponclipammo() < var_0B) {
          level.player setweaponammoclip(var_4, var_5);
        }
      } else if(issubstr(var_4, "steeldragon")) {
        var_0B = 25;
        if(var_6 < var_5) {
          if(level.player getcurrentweaponclipammo() < var_0B) {
            level.player givemaxammo(var_4);
          }
        }
      } else if(issubstr(var_4, "lockon")) {
        if(var_6 <= var_5) {
          level.player givemaxammo(var_4);
        }
      }
    } else if(var_6 <= var_5) {
      level.player givemaxammo(var_4);
    }

    if(isDefined(var_0) && var_0 < 1) {
      level.player givemaxammo(var_7);
    }

    if(isDefined(var_1) && var_1 < 1) {
      level.player givemaxammo(var_8);
    }

    if(isDefined(var_2) && var_2 < 1) {
      level.player givemaxammo(var_9);
    }

    if(isDefined(var_3) && var_3 < 1) {
      level.player givemaxammo(var_0A);
    }
  }
}

func_653A() {
  level endon("reset_vr");
  self endon("death");
  foreach(var_1 in level.var_13563.var_653C) {
    if(!var_1.var_19) {
      var_1.var_19 = 1;
      self.utility_triggers = var_1;
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

func_653B(var_0, var_1) {
  level endon("reset_vr");
  self endon("death");
  var_2 = int(var_1 * 20);
  var_3 = self.utility_triggers getspawnpoint();
  var_4 = var_0 - var_3 / var_2;
  for(var_5 = 0; var_5 < var_2; var_5++) {
    self.utility_triggers give_player_explosive_armor(var_3 + var_5 * var_4);
    wait(0.05);
  }

  self.utility_triggers give_player_explosive_armor(var_0);
}

func_F188(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  if(var_1) {
    foreach(var_7 in var_0.var_75B5) {
      var_3 = var_0.var_CBFA.origin + var_7.var_F187;
      var_8 = spawnfx(scripts\engine\utility::getfx(var_7.script_parameters), var_3);
      triggerfx(var_8);
      var_8.var_F185 = 1;
      level.var_13563.var_760D[level.var_13563.var_760D.size] = var_8;
    }

    return;
  }

  if(isDefined(var_5) && isDefined(var_8)) {
    var_8 = spawnfx(scripts\engine\utility::getfx(var_3), var_4, var_5, var_8);
  } else {
    var_8 = spawnfx(scripts\engine\utility::getfx(var_3), var_4);
  }

  triggerfx(var_8);
  var_8.var_F185 = 1;
  level.var_13563.var_760D[level.var_13563.var_760D.size] = var_8;
}

func_A62B(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 0;
  }

  var_1 = [];
  foreach(var_3 in level.var_13563.var_760D) {
    if(var_0) {
      if(isDefined(var_3.var_F185)) {
        if(var_3.var_F185) {
          var_3 delete();
        }
      } else {
        var_1[var_1.size] = var_3;
      }

      continue;
    }

    var_3 delete();
  }

  level.var_13563.var_760D = var_1;
}

create_fx_pause() {
  foreach(var_1 in level.createfxent) {
    if(isDefined(var_1.v["exploder"])) {
      continue;
    }

    var_1 scripts\engine\utility::pauseeffect();
  }
}

create_fx_resume() {
  foreach(var_1 in level.createfxent) {
    if(isDefined(var_1.v["exploder"])) {
      continue;
    }

    var_1 scripts\sp\utility::func_E2B0();
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
  foreach(var_1 in level.var_13563.var_12B98) {
    var_1 delete();
  }

  level.var_13563.var_12B98 = [];
  level.var_13563.var_2F09 hide();
  level.var_13563.var_9B3D show();
  foreach(var_4 in level.var_13563.var_653C) {
    var_4.var_19 = 0;
    var_4 setlightintensity(0);
  }

  func_E1A2();
  wait(0.1);
  level.var_13563.var_4E37 = 0;
  level.var_13563.var_5BDE = 0;
  func_A62B();
  foreach(var_7 in level.var_13563.var_E546) {
    if(var_7.var_EDD5 == 0) {
      var_7.var_D958 linkto(var_7, "tag_origin", (0, 0, 0), (0, 90, 0));
    }

    foreach(var_9 in var_7.var_466A) {
      func_465F(var_9, var_7);
    }

    foreach(var_0C in var_7.segments) {
      func_F189(var_0C, var_7);
    }

    var_7 scripts\sp\utility::func_65DD("ring_spinning");
    var_7 scripts\sp\utility::func_65DD("ring_unfolding");
  }

  level.player freezecontrols(0);
}

func_465F(var_0, var_1) {
  if(isDefined(var_0.var_1078F)) {
    var_0.var_1078F.var_A534 = undefined;
  }

  var_0.var_AC84 _meth_82FC(var_0.var_AC84.var_10BF7);
  var_0.var_AC84 setlightintensity(0);
  var_0.var_6128 hide();
  var_0.var_6123 hide();
  var_0 hide();
  var_0.var_CBFA linkto(var_1, "j_corner" + var_0.script_index, (0, 0, 0), (0, 0, 0));
  func_6B73(var_0, 1);
}

func_F189(var_0, var_1) {
  var_0 hide();
  if(isDefined(var_0.collision)) {
    var_0.collision hide();
  }

  if(isDefined(var_0.var_6128)) {
    var_0.var_6128 hide();
  }

  if(isDefined(var_0.var_6123)) {
    var_0.var_6123 hide();
  }

  if(isDefined(var_0.var_6E86)) {
    if(isDefined(var_0.var_6E86.var_6128)) {
      var_0.var_6E86.var_6128 hide();
    }

    if(isDefined(var_0.var_6E86.var_6123)) {
      var_0.var_6E86.var_6123 hide();
    }

    var_0.var_6E86 hide();
    var_0.var_6E86 linkto(var_0.var_CBFA, "", var_0.var_6E86.var_D6A0, var_0.var_6E86.var_42);
  }

  var_0.var_CBFA linkto(var_1, "j_segment" + var_0.script_index, (0, 0, 0), (0, 0, 0));
  func_6B73(var_0, 1);
}

func_6B73(var_0, var_1) {
  if(isDefined(var_0.var_6B71)) {
    foreach(var_3 in var_0.var_6B71) {
      if(var_1) {
        var_3 linkto(var_0.var_CBFA, "", var_3.var_D6A0, var_3.var_42);
        var_3 hide();
        continue;
      }

      var_3 linkto(var_0.var_CBFA);
    }
  }
}

func_57F2(var_0) {
  self getrandomarchetype(var_0);
  level.var_13563.var_2BE3[level.var_13563.var_2BE3.size] = self;
}

func_12B92() {
  foreach(var_1 in level.var_13563.var_2BE3) {
    var_1 _meth_83C9();
  }

  level.var_13563.var_2BE3 = [];
}

func_E1A2() {
  level.var_13563.var_9B3D.var_CBFA.origin = level.var_13563.var_9B3D.var_CBFA.start_pos;
  foreach(var_1 in level.var_13563.var_E546) {
    var_1 moveto(var_1.start_pos, 0.05);
    var_1 rotateto(var_1.var_10BA1, 0.05);
    foreach(var_3 in var_1.var_466A) {
      if(isDefined(var_3.var_6B71)) {
        foreach(var_5 in var_3.var_6B71) {
          var_5 moveto(var_5.origin, 0.05);
          var_5 rotateto(var_5.angles, 0.05);
        }
      }
    }

    foreach(var_9 in var_1.segments) {
      if(isDefined(var_9.var_6E86)) {
        var_9.var_6E86 rotateto(var_9.var_6E86.angles, 0.05);
      }

      if(isDefined(var_9.var_6B71)) {
        foreach(var_5 in var_9.var_6B71) {
          var_5 moveto(var_5.origin, 0.05);
          var_5 rotateto(var_5.angles, 0.05);
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
  foreach(var_1 in level.var_13563.var_E546) {
    var_1 stopsounds();
    var_1 givescorefortrophyblocks();
    var_1 clearanim( % root, 0);
  }

  foreach(var_4 in level.var_13563.var_E546[1].var_466A) {
    var_4 stopsounds();
  }

  foreach(var_7 in level.var_13563.var_E546[1].segments) {
    var_7 stopsounds();
  }

  foreach(var_7 in level.var_13563.var_E546[0].segments) {
    var_7.var_6E86 stopsounds();
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
    level.player waittill("luinotifyserver", var_0, var_1);
    break;
  }

  switch (var_0) {
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
  foreach(var_1 in level.var_13563.var_653C) {
    if(var_1 islinked()) {
      var_1 unlink();
    }
  }

  foreach(var_4 in level.var_13563.var_E546) {
    if(var_4.var_EDD5 == 0) {
      var_4.var_D958 unlink();
    }

    foreach(var_6 in var_4.var_466A) {
      var_6.var_CBFA unlink();
      if(isDefined(var_6.var_6B71)) {
        foreach(var_8 in var_6.var_6B71) {
          var_8 unlink();
        }
      }
    }

    foreach(var_0C in var_4.segments) {
      var_0C.var_CBFA unlink();
      if(isDefined(var_0C.var_6E86)) {
        var_0C.var_6E86 unlink();
      }

      if(isDefined(var_0C.var_6B71)) {
        foreach(var_8 in var_0C.var_6B71) {
          var_8 unlink();
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

func_CE8D(var_0, var_1) {
  level notify("playing_vr_tranistion_bink");
  level endon("playing_vr_tranistion_bink");
  if(!isDefined(var_0)) {
    var_0 = "ship_enter_vr";
  }

  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  stopcinematicingame();
  wait(0.1);
  setsaveddvar("bg_cinematicFullScreen", "1");
  setsaveddvar("bg_cinematicCanPause", "0");
  setsaveddvar("bg_cinematicAboveUI", "1");
  if(var_1) {
    var_2 = "weapon_loadout_terminal_intro";
  } else {
    var_2 = "weapon_loadout_terminal_transition";
  }

  cinematicingame(var_2);
  while(!iscinematicplaying()) {
    scripts\engine\utility::waitframe();
  }

  level.player playSound(var_0);
  level thread waittilbinkend();
  while(iscinematicplaying()) {
    var_3 = cinematicgettimeinmsec();
    if(var_3 > 750) {
      level notify("vr_transition_bink_full_opacity");
      setomnvar("ui_close_vr_pause_menu", 1);
      break;
    }

    scripts\engine\utility::waitframe();
  }
}