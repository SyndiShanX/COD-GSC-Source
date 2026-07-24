/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3885.gsc
**************************************/

_id_1355D() {
  precachemodel("vr_unfold_left_rig");
  precachemodel("vr_unfold_right_rig");
  _id_0F30::main();
  _id_0F2E::main();

  if(isDefined(level._id_13567))
    scripts\engine\utility::flag_wait(level._id_13567);

  scripts\sp\utility::_id_9189("default_vroutline", -1, "default");
  level.func["player_grenade_thrown"] = ::_id_13566;
  scripts\sp\utility::_id_22C9("vr_enemy_human", ::_id_D70F);
  _id_0F2F::main();
}

_id_661E(var_0) {
  setomnvar("ui_in_vr", 1);
  setomnvar("ui_close_vr_pause_menu", 0);
  scripts\engine\utility::flag_set("in_vr_mode");
  level._id_93A9 = 1;
  level._id_116D8._id_13558 = 1;
  level thread _id_13598();
  level thread _id_F61F();
  scripts\sp\outline::_id_91A1("default", ::_id_1356B);
  level thread _id_6DA9(var_0);
}

_id_1356B() {
  var_0["r_hudoutlineWidth"] = 3;
  var_0["cg_hud_outline_colors_5"] = "0.122 0.235 0.425 0.500";
  return var_0;
}

_id_6DA9(var_0) {
  level endon("reset_vr");
  var_1 = undefined;
  var_2 = level._id_13563._id_E546[1].segments[0];
  var_3 = scripts\engine\utility::array_remove(level._id_13563._id_E546[1].segments, var_2);
  level thread _id_A5D0();

  if(var_0)
    _id_9AD8();
  else
    _id_9AD6();

  for(var_4 = 0; var_4 < 3; var_4++) {
    _id_669D(var_2, var_3, var_4);
    level thread _id_2F0A(1);
    level thread _id_4D96(level._id_13563._id_BF5A._id_CBFA.origin, 1);
    wait 0.75;
    _id_106C8(level._id_13563._id_BF5A, var_4);
    _id_A62A();
    _id_12B92();
    wait 1.75;
    _id_6B73(level._id_13563._id_BF5A, 0);
    level thread _id_2F0A(0);
    var_5 = level._id_13563._id_BF5A._id_CBFA.origin + anglestoright(level._id_13563._id_BF5A._id_CBFA.angles) * -1792;
    level thread _id_4D96(var_5, 0, 1, 1);
    var_3 = scripts\engine\utility::array_remove(var_3, level._id_13563._id_BF5A);
    var_2 = level._id_13563._id_BF5A;
  }

  wait 0.5;
  level.player playSound("vr_course_complete");
  _id_DFED();
  wait 0.5;
  level.player playSound("shipcrib_hud_complete_simulation");
  wait 2;
  scripts\sp\utility::_id_56BA("vr_tut_leave");
  level thread scripts\engine\utility::flag_set_delayed("vr_tutorial_leave_shown", 5);
}

_id_9AD8() {
  level endon("reset_vr");
  scripts\engine\utility::flag_set("vr_delete_thrown_grenades");
  var_0 = level._id_13563._id_E546;
  var_1 = level._id_13563._id_E546[1].segments[0];
  level._id_13563._id_9B3D hide();

  foreach(var_3 in var_0) {
    var_4 = anglesToForward(var_3.angles) * 9408;
    var_5 = anglestoright(var_3.angles) * 608;
    var_3.origin = var_3.start_pos + var_4 + var_5;
    var_3 thread _id_E53E("passive", 1, undefined, 1);
    level notify("vr_ring" + var_3._id_EDD5 + "_intro_show_geo");

    foreach(var_7 in var_3._id_466A)
    var_7 show();

    foreach(var_10 in var_3.segments) {
      if(isDefined(var_10._id_6E86))
        var_10._id_6E86 show();

      var_10 show();
    }

    if(var_3 == level._id_13563._id_E546[1]) {
      continue;
    }
    var_3 rotateroll(90, 0.05);
  }

  scripts\engine\utility::waitframe();

  foreach(var_10 in level._id_13563._id_E546[0].segments) {
    var_10._id_6E86 unlink();
    var_10._id_6E86 rotateroll(-90, 0.05);
  }

  wait 1;
  level.player playSound("scn_vr_rotate_90");
  level._id_13563._id_E546[1] _id_E53E("active");
  var_15 = 1.5;
  var_16 = 0.35;
  level._id_13563._id_E546[1] rotateroll(90, var_15, var_16, var_16);
  wait(var_15 + 0.1);
  level._id_13563._id_E546[1] _id_E53E("passive");
  level._id_13563._id_2F09.origin = var_1._id_CBFA.origin;

  foreach(var_18 in level._id_13563._id_4D95)
  var_18.origin = var_1._id_CBFA.origin + anglestoright(var_1._id_CBFA.angles) * -1792;

  scripts\engine\utility::flag_clear("vr_delete_thrown_grenades");
  wait 0.25;
}

_id_9AD6() {
  level endon("reset_vr");
  scripts\engine\utility::flag_set("vr_delete_thrown_grenades");
  var_0 = level._id_13563._id_E546;
  var_1 = level._id_13563._id_E546[1].segments[0];
  wait 1;
  level.player playSound("shipcrib_hud_loading_simulation");

  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    if(var_2 == 0)
      var_0[var_2] playSound("scn_vr_enter");

    var_0[var_2] thread _id_E539();
    wait 0.25;
  }

  var_0[var_0.size - 1] waittill("vr_intro_part1");

  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    var_3 = 608;
    var_4 = 1.5;
    var_5 = 0.35;

    if(var_2 == 0) {
      var_6 = level._id_13563._id_9B3D;
      var_6 thread _id_3108(0, 1);
    }

    var_0[var_2] thread _id_E542(var_3, var_4, var_5);
    wait 0.125;
  }

  var_0[2] waittill("intro_finished");
  scripts\engine\utility::flag_clear("vr_delete_thrown_grenades");
  var_0[var_0.size - 1] waittill("intro_finished");
  level._id_13563._id_2F09.origin = var_1._id_CBFA.origin;

  foreach(var_8 in level._id_13563._id_4D95)
  var_8.origin = var_1._id_CBFA.origin + anglestoright(var_1._id_CBFA.angles) * -1792;

  wait 0.25;
}

_id_E539(var_0) {
  level endon("reset_vr");
  thread scripts\sp\anim::_id_1EC3(self, "vr_intro_part1");
  _id_E53E("passive", 1, undefined, 1);

  foreach(var_2 in self._id_466A)
  var_2 show();

  wait 0.5;
  thread scripts\sp\anim::_id_1F35(self, "vr_intro_part1");
  level waittill("vr_ring" + self._id_EDD5 + "_intro_show_geo");

  foreach(var_5 in self.segments) {
    if(isDefined(var_5._id_6E86))
      var_5._id_6E86 show();

    var_5 show();
  }
}

_id_E542(var_0, var_1, var_2) {
  level endon("reset_vr");
  _id_E53E("active");
  self rotateroll(90, var_1, var_2, var_2);
  self moveTo(self.origin + anglestoright(self.angles) * var_0, var_1, var_2, var_2);
  wait(var_1 + 0.05);
  _id_E53E("passive");

  if(self == level._id_13563._id_E546[0]) {
    self.segments[0]._id_6E86 playSound("scn_vr_enter_cap");

    foreach(var_4 in self.segments) {
      var_4._id_6E86 unlink();
      var_4._id_6E86 rotateroll(-90, 1.0, 0.25, 0.25);
    }
  }

  self notify("intro_finished");
}

_id_669D(var_0, var_1, var_2) {
  level endon("reset_vr");

  if(var_2 == 0) {
    level._id_13563._id_BF5A = var_0;
    level._id_13563._id_BF5B[0] = level._id_13563._id_E546[1]._id_466A[0];
    level._id_13563._id_BF5B[1] = level._id_13563._id_E546[1]._id_466A[1];
    var_3 = undefined;
    var_4 = undefined;
    var_5 = 0;
  } else if(var_2 == 1) {
    var_4 = undefined;
    var_3 = level._id_13563._id_E546[1].segments;
    level._id_13563._id_BF5A = var_1[randomint(var_1.size)];
    var_5 = 0;
  } else {
    var_4 = undefined;
    var_3 = level._id_13563._id_E546[1].segments;
    level._id_13563._id_BF5A = var_1[randomint(var_1.size)];
    var_5 = 1;
  }

  if(var_2 == 0) {
    _id_6B74(level._id_13563._id_BF5A, 0);
    level thread _id_F188(level._id_13563._id_BF5A, 1);
    level.player playSound("shipcrib_hud_activate_simulation");
  } else {
    if(var_0 == var_3[0]) {
      if(level._id_13563._id_BF5A == var_3[1]) {
        var_4 = "negative_90";
        level._id_13563._id_BF5B[0] = level._id_13563._id_E546[1]._id_466A[1];
        level._id_13563._id_BF5B[1] = level._id_13563._id_E546[1]._id_466A[2];
      } else if(level._id_13563._id_BF5A == var_3[2]) {
        var_4 = "positive_180";
        level._id_13563._id_BF5B[0] = level._id_13563._id_E546[1]._id_466A[2];
        level._id_13563._id_BF5B[1] = level._id_13563._id_E546[1]._id_466A[3];
      } else {
        var_4 = "positive_90";
        level._id_13563._id_BF5B[0] = level._id_13563._id_E546[1]._id_466A[3];
        level._id_13563._id_BF5B[1] = level._id_13563._id_E546[1]._id_466A[0];
      }
    } else if(var_0 == var_3[1]) {
      if(level._id_13563._id_BF5A == var_3[2]) {
        var_4 = "negative_90";
        level._id_13563._id_BF5B[0] = level._id_13563._id_E546[1]._id_466A[2];
        level._id_13563._id_BF5B[1] = level._id_13563._id_E546[1]._id_466A[3];
      } else if(level._id_13563._id_BF5A == var_3[3]) {
        var_4 = "positive_180";
        level._id_13563._id_BF5B[0] = level._id_13563._id_E546[1]._id_466A[3];
        level._id_13563._id_BF5B[1] = level._id_13563._id_E546[1]._id_466A[0];
      }
    } else if(var_0 == var_3[2]) {
      if(level._id_13563._id_BF5A == var_3[1]) {
        var_4 = "positive_90";
        level._id_13563._id_BF5B[0] = level._id_13563._id_E546[1]._id_466A[1];
        level._id_13563._id_BF5B[1] = level._id_13563._id_E546[1]._id_466A[2];
      } else if(level._id_13563._id_BF5A == var_3[3]) {
        var_4 = "negative_90";
        level._id_13563._id_BF5B[0] = level._id_13563._id_E546[1]._id_466A[3];
        level._id_13563._id_BF5B[1] = level._id_13563._id_E546[1]._id_466A[0];
      }
    } else if(var_0 == var_3[3]) {
      if(level._id_13563._id_BF5A == var_3[1]) {
        var_4 = "negative_180";
        level._id_13563._id_BF5B[0] = level._id_13563._id_E546[1]._id_466A[1];
        level._id_13563._id_BF5B[1] = level._id_13563._id_E546[1]._id_466A[2];
      } else if(level._id_13563._id_BF5A == var_3[2]) {
        var_4 = "positive_90";
        level._id_13563._id_BF5B[0] = level._id_13563._id_E546[1]._id_466A[2];
        level._id_13563._id_BF5B[1] = level._id_13563._id_E546[1]._id_466A[3];
      }
    }

    level.player playSound("shipcrib_hud_cleared_simulation");
    level thread _id_A62B(1);
    _id_DFED();
    scripts\engine\utility::flag_set("vr_delete_thrown_grenades");
    level thread _id_A5BD(level._id_13563._id_E546[2]);

    switch (var_4) {
      case "positive_90":
      case "negative_90":
        level.player playSound("scn_vr_rotate_90");

        if(var_5)
          level.player scripts\engine\utility::delaycall(1.5, ::playsound, "scn_vr_unfold_side");

        break;
      case "negative_180":
      case "positive_180":
        level.player playSound("scn_vr_rotate_180");

        if(var_5)
          level.player scripts\engine\utility::delaycall(3.0, ::playsound, "scn_vr_unfold_side");

        break;
      default:
        break;
    }

    for(var_6 = 0; var_6 < level._id_13563._id_E546.size; var_6++) {
      if(level._id_13563._id_BF5A == var_3[1])
        var_7 = 1;
      else if(level._id_13563._id_BF5A == var_3[2])
        var_7 = 2;
      else
        var_7 = 3;

      if(var_6 == 0)
        level._id_13563._id_E546[var_6] thread _id_1266B(var_4, var_5, var_7);
      else
        level._id_13563._id_E546[var_6] thread _id_12669(var_4, var_5, var_7);

      wait 0.125;
    }

    level._id_13563._id_E546[1] scripts\sp\utility::_id_65E8("ring_spinning");
    level._id_13563._id_BF5A scripts\sp\utility::_id_65E8("segment_dropping_geo");
    level thread _id_F188(level._id_13563._id_BF5A, 1);
    wait 0.25;
  }
}

_id_12669(var_0, var_1, var_2) {
  level endon("reset_vr");
  scripts\sp\utility::_id_65E1("ring_spinning");
  _id_E53E("active");
  var_3 = 1.5;
  var_4 = 0.35;

  if(var_0 == "positive_90")
    self rotateroll(90, var_3, var_4, var_4);
  else if(var_0 == "negative_90")
    self rotateroll(-90, var_3, var_4, var_4);
  else if(var_0 == "positive_180") {
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

  if(self == level._id_13563._id_E546[1])
    level thread _id_6B74(level._id_13563._id_BF5A, 0);

  _id_E53E("passive");
  scripts\sp\utility::_id_65DD("ring_spinning");

  if(var_1) {
    thread _id_12673("left", var_2);
    thread _id_12673("right", var_2);

    if(self == level._id_13563._id_E546[1]) {
      level waittill("corner_dropping_geo");
      _id_6B74(level._id_13563._id_BF5A, 1);
    }
  }
}

#using_animtree("script_model");

_id_1266B(var_0, var_1, var_2) {
  level endon("reset_vr");
  _id_E53E("active");
  var_3 = 1.5;
  var_4 = 0.35;

  if(var_0 == "positive_180")
    var_3 = var_3 * 2;
  else if(var_0 == "negative_180")
    var_3 = var_3 * 2;

  wait(var_3 + 0.1);
  _id_E53E("passive");

  if(var_1) {
    _id_E53E("active");
    var_3 = getanimlength(%vr_unfold_left);
    wait(var_3);
    _id_E53E("passive");
  }
}

_id_12673(var_0, var_1) {
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

  _id_12B95(var_0, var_2, var_1, var_3, var_4);
}

_id_12B95(var_0, var_1, var_2, var_3, var_4) {
  level endon("reset_vr");
  var_5 = self gettagorigin(var_1);
  var_6 = vectortoangles(anglesToForward(self.angles));
  var_7 = scripts\sp\utility::_id_10639("vr_unfold_" + var_0 + "_rig", var_5, var_6);
  var_7 hide();
  level._id_13563._id_12B98[level._id_13563._id_12B98.size] = var_7;
  var_8 = self.segments[var_3];
  var_9 = self._id_466A[var_4];
  var_8._id_CBFA unlink();
  var_8._id_CBFA linkTo(var_7, "tag_segment", (0, 0, 0), (0, 0, 0));
  var_9._id_CBFA unlink();
  var_9._id_CBFA linkTo(var_7, "tag_corner_bottom", (0, 0, 0), (0, 0, 0));
  _id_E53E("active");
  scripts\sp\utility::_id_65E1("ring_unfolding");
  var_7 scripts\sp\anim::_id_1F35(var_7, "vr_unfold");
  _id_E53E("passive");

  if(isDefined(var_9._id_1078F)) {
    var_9._id_1078F._id_A534 = var_0;
    var_9 _id_57F2(level._id_13563._id_BF5A);
    level thread _id_6B74(var_8, 1);
    wait 0.25;
    level thread _id_6B74(var_9, 1);
    level thread scripts\sp\utility::_id_C12D("corner_dropping_geo", 0.25);
    var_9 scripts\sp\utility::_id_65E8("segment_dropping_geo");
  }

  scripts\sp\utility::_id_65DD("ring_unfolding");
}

_id_E53E(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_3))
    var_3 = 0;

  if(!isDefined(var_1))
    var_1 = 0;

  if(!isDefined(var_2))
    var_2 = 0;

  if(var_0 == "passive") {
    foreach(var_5 in self._id_466A) {
      var_5._id_AC84 _meth_82FC(var_5._id_AC84._id_10BF7);
      var_5._id_6128 show();
      var_5._id_6123 hide();

      if(var_1) {
        var_5._id_AC84 setlightintensity(var_5._id_AC84.script_intensity_01);
        continue;
      }

      if(var_2) {
        var_5._id_AC84 setlightintensity(0);
        var_5._id_6128 hide();
        var_5._id_6123 hide();
      }
    }
  } else if(var_0 == "active") {
    foreach(var_5 in self._id_466A) {
      var_5._id_AC84 _meth_82FC(var_5._id_AC84._id_62C0);
      var_5._id_6128 hide();
      var_5._id_6123 show();

      if(var_1) {
        var_5._id_AC84 setlightintensity(var_5._id_AC84.script_intensity_01);
        continue;
      }

      if(var_2) {
        var_5._id_AC84 setlightintensity(0);
        var_5._id_6128 hide();
        var_5._id_6123 hide();
      }
    }
  }

  if(self == level._id_13563._id_E546[0] || self == level._id_13563._id_E546[5])
    thread _id_E53F(var_0, var_1, var_2, var_3);
}

_id_E53F(var_0, var_1, var_2, var_3) {
  level endon("reset_vr");
  var_4 = [self.segments[1], self.segments[3]];

  if(var_3)
    level waittill("vr_ring" + self._id_EDD5 + "_intro_show_geo");

  if(var_0 == "passive") {
    foreach(var_6 in var_4) {
      if(isDefined(var_6._id_6E86)) {
        if(isDefined(var_6._id_6E86._id_6128)) {
          var_6._id_6E86._id_6128 show();
          var_6._id_6E86._id_6123 hide();

          if(var_2) {
            var_6._id_6E86._id_6128 hide();
            var_6._id_6E86._id_6123 hide();
          }
        }
      }

      if(isDefined(var_6._id_6128)) {
        var_6._id_6128 show();
        var_6._id_6123 hide();

        if(var_2) {
          var_6._id_6128 hide();
          var_6._id_6123 hide();
        }
      }
    }
  } else if(var_0 == "active") {
    foreach(var_6 in self.segments) {
      if(isDefined(var_6._id_6E86)) {
        if(isDefined(var_6._id_6E86._id_6128)) {
          var_6._id_6E86._id_6128 hide();
          var_6._id_6E86._id_6123 show();

          if(var_2) {
            var_6._id_6E86._id_6128 hide();
            var_6._id_6E86._id_6123 hide();
          }
        }
      }

      if(isDefined(var_6._id_6128)) {
        var_6._id_6128 hide();
        var_6._id_6123 show();

        if(var_2) {
          var_6._id_6128 hide();
          var_6._id_6123 hide();
        }
      }
    }
  }
}

_id_6B74(var_0, var_1) {
  level endon("reset_vr");

  if(!isDefined(var_1))
    var_1 = 0;

  if(isDefined(var_0._id_6B71)) {
    var_0 scripts\sp\utility::_id_65E1("segment_dropping_geo");

    if(!var_1) {
      if(var_0 == level._id_13563._id_E546[1].segments[0])
        var_0 playSound("vr_blocks_in_and_hit_01");
      else if(var_0 == level._id_13563._id_E546[1].segments[1])
        var_0 playSound("vr_blocks_in_and_hit_02");
      else if(var_0 == level._id_13563._id_E546[1].segments[2])
        var_0 playSound("vr_blocks_in_and_hit_03");
      else if(var_0 == level._id_13563._id_E546[1].segments[3])
        var_0 playSound("vr_blocks_in_and_hit_04");
    } else if(isDefined(var_0._id_1078F)) {
      if(var_0._id_1078F._id_A534 == "left")
        var_0 playSound("vr_blocks_in_bridge_left");
      else
        var_0 playSound("vr_blocks_in_bridge_right");
    }

    for(var_2 = 0; var_2 < var_0._id_6B71.size; var_2++) {
      var_3 = var_0._id_6B71[var_2];

      if(var_1) {
        if(!isDefined(var_3.script_parameters)) {
          continue;
        }
        if(var_3.script_parameters == "unfold") {
          var_3 thread _id_6B72();
          wait 0.05;
        }

        continue;
      }

      if(isDefined(var_3.script_parameters)) {
        if(var_3.script_parameters == "unfold")
          continue;
      }

      var_3 thread _id_6B72();
      wait 0.1;
    }

    wait 0.3;
    var_0 scripts\sp\utility::_id_65DD("segment_dropping_geo");
  }
}

_id_6B72() {
  var_0 = self._id_8D0D * -1;
  var_1 = self.origin + (0, 0, var_0);
  _id_F188(level._id_13563._id_BF5A, 0, self._id_7595, var_1, self._id_7587, anglestoup(self.angles));
  self unlink();
  self show();
  self moveTo(var_1, 0.25);
}

_id_2F0A(var_0) {
  if(var_0)
    level._id_13563._id_2F09 thread _id_3108(1);
  else
    level._id_13563._id_2F09 thread _id_3108(0);
}

_id_4D96(var_0, var_1, var_2, var_3) {
  level notify("data_box_moving");
  level endon("reset_vr");
  level endon("data_box_moving");

  if(!isDefined(var_1))
    var_1 = 1;

  if(!isDefined(var_2))
    var_2 = 0;

  if(!isDefined(var_3))
    var_3 = 0;

  foreach(var_5 in level._id_13563._id_4D95) {
    var_5 thread _id_4D97(var_0, var_1, var_2, var_3);

    if(!var_3)
      wait 0.125;
  }
}

_id_4D97(var_0, var_1, var_2, var_3) {
  if(var_1)
    thread _id_3108(1);
  else if(var_2)
    thread _id_3108(0, 1);

  if(isDefined(self._id_A645) && var_1) {
    self._id_A645 playSound("killcounter_appear");
    self._id_A645 thread _id_3108(1);
  } else if(isDefined(self._id_A645) && var_2) {
    self._id_A645 playSound("killcounter_disappear");
    self._id_A645 thread _id_3108(0, 1);
  }

  if(var_3) {
    self waittill("vr_flicker_done");
    self moveTo(var_0, 0.05);
  } else
    self moveTo(var_0, 0.5, 0.125, 0.125);
}

_id_3108(var_0, var_1) {
  self notify("vr_flicker");
  level endon("reset_vr");
  self endon("vr_flicker");
  var_2 = 0.1;

  if(!isDefined(var_1))
    var_1 = 0;

  if(var_1)
    var_3 = 3;
  else
    var_3 = 5;

  if(var_0) {
    for(var_4 = 0; var_4 < var_3; var_4++) {
      if(var_4 > 2)
        var_2 = 0.15;

      self hide();
      wait(randomfloatrange(0.05, var_2));
      self show();
      wait(randomfloatrange(0.05, var_2));
    }
  } else {
    for(var_4 = 0; var_4 < var_3; var_4++) {
      if(var_4 > 2)
        var_2 = 0.15;

      self show();
      wait(randomfloatrange(0.05, var_2));
      self hide();
      wait(randomfloatrange(0.05, var_2));
    }
  }

  self notify("vr_flicker_done");
}

_id_A647() {
  var_0 = level._id_13563._id_63A1;
  var_1 = var_0.size;
  var_2 = [level._id_13563._id_4D95["front_top_right"]._id_A645, level._id_13563._id_4D95["rear_top_left"]._id_A645, level._id_13563._id_4D95["rear_top_right"]._id_A645];

  foreach(var_4 in var_2) {
    var_4 thread _id_A646();

    if(var_1 != var_4._id_4B5B) {
      var_4 hidepart("tag_num" + var_4._id_4B5B);
      var_4 showpart("tag_num" + var_1);
      var_4._id_4B5B = var_1;
    }

    if(var_1 == 0) {
      foreach(var_6 in var_4._id_1141C)
      var_4 hidepart(var_6);

      continue;
    }

    for(var_8 = 1; var_8 < var_4._id_1141C.size; var_8++) {
      if(var_8 <= var_1) {
        var_4 showpart("tag_boxcounter" + var_8);
        continue;
      }

      var_4 hidepart("tag_boxcounter" + var_8);
    }
  }
}

_id_A646() {
  level endon("reset_vr");

  if(scripts\sp\utility::_id_65DB("killcounter_animating")) {
    return;
  }
  scripts\sp\utility::_id_65E1("killcounter_animating");
  scripts\sp\anim::_id_1F35(self, "update");
  scripts\sp\utility::_id_65DD("killcounter_animating");
}

_id_106C8(var_0, var_1) {
  level endon("reset_vr");
  var_2 = [];
  var_3 = [];

  if(isDefined(level._id_13563._id_46C6)) {
    var_2 = _id_799F(var_0, level._id_13563._id_46C6, 4);

    if(isDefined(level._id_13563._id_46C7)) {
      if(level._id_13563._id_46C7 != level._id_13563._id_46C6)
        var_3 = _id_799F(var_0, level._id_13563._id_46C7, 4);
    }
  } else
    var_2 = _id_799F(var_0, level._id_13563._id_46C7, 4);

  if(var_1 == 0) {
    level._id_13563._id_10691 = 2;
    level._id_13563._id_1087E[0] _id_1085F(var_0, var_2[0], 0);

    if(var_3.size > 0)
      level._id_13563._id_1087E[1] _id_1085F(var_0, var_3[0], 0);
    else
      level._id_13563._id_1087E[1] _id_1085F(var_0, var_2[1], 0);

    level waittill("equipment_range_enemies_dead");
  } else if(var_1 == 1) {
    level._id_13563._id_10691 = 4;
    level._id_13563._id_1087E[0] _id_1085F(var_0, var_2[0], 0);

    if(var_3.size > 0)
      level._id_13563._id_1087E[1] _id_1085F(var_0, var_3[0], 0);
    else
      level._id_13563._id_1087E[1] _id_1085F(var_0, var_2[1], 0);

    wait 1;

    if(var_3.size > 0) {
      level._id_13563._id_1087E[2] _id_1085F(var_0, var_2[1], 0);
      level._id_13563._id_1087E[3] _id_1085F(var_0, var_3[1], 0);
    } else {
      level._id_13563._id_1087E[2] _id_1085F(var_0, var_2[2], 0);
      level._id_13563._id_1087E[3] _id_1085F(var_0, var_2[3], 0);
    }

    level waittill("equipment_range_enemies_dead");
  } else if(var_1 > 1) {
    level._id_13563._id_10691 = 5;
    level._id_13563._id_1087E[0] _id_1085F(var_0, var_2[0], 0);

    if(var_3.size > 0) {
      level._id_13563._id_1087E[1] _id_1085F(var_0, var_3[0], 0);
      level._id_13563._id_1087E[2] _id_1085F(var_0, var_2[1], 0);
    } else {
      level._id_13563._id_1087E[1] _id_1085F(var_0, var_2[1], 0);
      level._id_13563._id_1087E[2] _id_1085F(var_0, var_2[2], 0);
    }

    wait 1;
    level._id_13563._id_E546[1] scripts\sp\utility::_id_65E8("ring_unfolding");

    for(var_4 = 3; var_4 < 4; var_4++) {
      var_5 = level._id_13563._id_BF5B[0];
      level._id_13563._id_1087E[var_4] _id_1085F(var_5, var_5._id_1078F, 1);
    }

    for(var_4 = 4; var_4 < 5; var_4++) {
      var_5 = level._id_13563._id_BF5B[1];
      level._id_13563._id_1087E[var_4] _id_1085F(var_5, var_5._id_1078F, 1);
    }

    level waittill("equipment_range_enemies_dead");
  }
}

_id_F60F() {
  var_0 = level.player _meth_84C6("selectedLoadout");
  var_1 = level.player _meth_84C6("loadouts", var_0, "weaponSetups", 0, "weapon");
  var_2 = level.player _meth_84C6("loadouts", var_0, "weaponSetups", 1, "weapon");
  var_3 = scripts\sp\loadout::_id_31CE(0, var_0);
  var_4 = scripts\sp\loadout::_id_31CE(1, var_0);

  if(isDefined(var_3) || isDefined(var_4)) {
    level._id_13563._id_46C6 = _id_78E8(var_3);
    level._id_13563._id_46C7 = _id_78E8(var_4);
  } else {
    level._id_13563._id_46C6 = "medium";
    level._id_13563._id_46C7 = undefined;
  }
}

_id_78E8(var_0) {
  if(!isDefined(var_0))
    return undefined;

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

_id_799F(var_0, var_1, var_2) {
  var_3 = [];
  var_4 = [];
  var_5 = [];
  var_6 = [];

  foreach(var_8 in var_0._id_10870) {
    if(var_8.script_parameters == "long")
      var_4[var_4.size] = var_8;

    if(var_8.script_parameters == "medium")
      var_5[var_5.size] = var_8;

    if(var_8.script_parameters == "close")
      var_6[var_6.size] = var_8;
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

  var_10 = [];

  for(var_11 = 0; var_11 < var_2; var_11++) {
    if(var_11 > var_3.size - 1) {
      break;
    }

    var_10[var_10.size] = var_3[var_11];
  }

  return scripts\engine\utility::array_randomize(var_10);
}

_id_1085F(var_0, var_1, var_2) {
  level endon("reset_vr");

  if(var_2) {
    if(var_1._id_A534 == "left") {
      var_3 = level._id_13563._id_BF5A._id_12B96;
      self.angles = vectortoangles(anglesToForward(var_1.angles));
    } else {
      var_3 = level._id_13563._id_BF5A._id_12B97;
      self.angles = vectortoangles(anglesToForward(var_1.angles) * -1);
    }
  } else {
    var_3 = getnode(var_1.target, "targetname");
    self.angles = var_1.angles;
  }

  self.count = 1;
  self.target = var_3.targetname;
  self.origin = var_0._id_CBFA.origin + var_1._id_F187;
  self._id_EDE3 = 1;
  var_3.radius = 128;
  level thread scripts\engine\utility::play_sound_in_space("vr_enemy_spawn", self.origin);
  var_4 = self.origin + anglestoup(self.angles) * 300.0;
  var_5 = anglestoup(self.angles) * -1;
  var_6 = anglesToForward(self.angles);
  _id_F188(var_0, 0, "vfx_vr_enemy_spawn", var_4, var_5, var_6);
  wait 0.65;
  scripts\sp\utility::_id_10619(1);
}

_id_D70F() {
  level endon("reset_vr");
  self endon("death");
  level._id_13563._id_63A1[level._id_13563._id_63A1.size] = self;
  self.dropweapon = 0;
  self.grenadeawareness = 0;
  self._id_10264 = 1;
  self._id_28CF = 0;
  self._id_4E46 = ::_id_643D;
  scripts\sp\utility::_id_5550();
  level thread _id_A647();
  thread _id_653A();
  scripts\sp\utility::_id_9196(4, 1, 0, "default_vroutline");
}

_id_D709() {
  level endon("reset_vr");
  self endon("death");
  level._id_13563._id_639F[level._id_13563._id_639F.size] = self;
  self.dropweapon = 0;
  self.grenadeawareness = 0;
  self._id_4E46 = ::_id_643C;
  scripts\sp\utility::_id_5550();
  level thread _id_A647();
  thread _id_653A();
  scripts\sp\utility::_id_9196(4, 1, 0, "default_vroutline");
}

_id_643D() {
  if(!scripts\engine\utility::array_contains(level._id_13563._id_63A1, self))
    return 1;

  level._id_13563._id_63A1 = scripts\engine\utility::array_remove(level._id_13563._id_63A1, self);
  level._id_13563._id_4E37 = level._id_13563._id_4E37 + 1;

  if(level._id_13563._id_4E37 >= level._id_13563._id_10691) {
    level notify("equipment_range_enemies_dead");
    level._id_13563._id_4E37 = 0;
  }

  level thread _id_A647();
  self.utility_triggers unlink();
  self.utility_triggers setlightintensity(0);
  self.utility_triggers.active = 0;
  var_0 = ["j_head", "j_chest", "j_shoulder_ri", "j_shoulder_le", "j_elbow_ri", "j_elbow_le", "j_hip_ri", "j_hip_le", "j_knee_ri", "j_knee_le"];
  var_1 = var_0.size;

  for(var_2 = 0; var_2 < var_1; var_2++) {
    var_3 = var_0[var_2];
    var_4 = self gettagorigin(var_3);
    var_5 = self gettagangles(var_3);
    var_6 = self.damagedir;

    if(var_6 == (0, 0, 0)) {
      var_7 = getEnt("start_vr_chamber", "targetname");
      var_6 = anglesToForward(var_7.angles);
    }

    var_8 = anglestoup(var_5);
    _id_F188(level._id_13563._id_BF5A, 0, "vfx_vr_enemy_death", var_4, var_6, var_8);
  }

  if(!isDefined(self._id_4E68) || self._id_4E68 != 1)
    level thread scripts\engine\utility::play_sound_in_space("vr_enemy_death", self gettagorigin("J_Neck"));

  wait 0.1;
  self delete();
  return 1;
}

_id_643C() {
  if(!scripts\engine\utility::array_contains(level._id_13563._id_639F, self))
    return 1;

  level._id_13563._id_639F = scripts\engine\utility::array_remove(level._id_13563._id_639F, self);
  level._id_13563._id_4E37 = level._id_13563._id_4E37 + 1;

  if(level._id_13563._id_4E37 >= level._id_13563._id_10691) {
    level notify("equipment_range_enemies_dead");
    level._id_13563._id_4E37 = 0;
  }

  level thread _id_A647();
  self.utility_triggers unlink();
  self.utility_triggers setlightintensity(0);
  self.utility_triggers.active = 0;
  var_0 = _id_336D();

  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    var_2 = var_0[var_1];
    var_3 = self gettagorigin(var_2);
    var_4 = self gettagangles(var_2);
    var_5 = self.damagedir;

    if(var_5 == (0, 0, 0)) {
      var_6 = getEnt("start_vr_chamber", "targetname");
      var_5 = anglesToForward(var_6.angles);
    }

    var_7 = anglestoup(var_4);
    _id_F188(level._id_13563._id_BF5A, 0, "vfx_vr_enemy_death", var_3, var_5, var_7);
  }

  if(!isDefined(self._id_4E68) || self._id_4E68 != 1)
    level thread scripts\engine\utility::play_sound_in_space("vr_enemy_death", self gettagorigin("J_Neck"));

  wait 0.1;
  self delete();
  return 1;
}

_id_336D() {
  var_0 = ["j_head", "j_spineupper", "j_shoulder_ri", "j_shoulder_le", "j_elbow_ri", "j_elbow_le", "j_hip_ri", "j_hip_le", "j_knee_ri", "j_knee_le"];

  if(_id_0A0B::_id_7C35("left_leg") == "dismember")
    var_0 = scripts\engine\utility::array_remove_array(var_0, ["j_hip_le", "j_knee_le"]);

  if(_id_0A0B::_id_7C35("right_leg") == "dismember")
    var_0 = scripts\engine\utility::array_remove_array(var_0, ["j_hip_ri", "j_knee_ri"]);

  if(_id_0A0B::_id_7C35("left_arm") == "dismember")
    var_0 = scripts\engine\utility::array_remove_array(var_0, ["j_shoulder_le", "j_elbow_le"]);

  if(_id_0A0B::_id_7C35("right_arm") == "dismember")
    var_0 = scripts\engine\utility::array_remove_array(var_0, ["j_shoulder_ri", "j_elbow_ri"]);

  if(_id_0A0B::_id_7C35("torso") == "dismember")
    var_0 = scripts\engine\utility::array_remove_array(var_0, ["j_spineupper"]);

  return var_0;
}

_id_A62A() {
  var_0 = level._id_13563._id_63A1;
  clearallcorpses();

  foreach(var_2 in var_0) {
    if(isDefined(var_2._id_FE4A)) {
      if(var_2._id_FE4A)
        killfxontag(level._id_7649[var_2.unittype + "_death"], var_2, "j_spine4");
    }

    var_2._id_4E68 = 1;
    var_2 _meth_81D0();
  }
}

_id_13566(var_0) {
  level endon("reset_vr");

  if(scripts\engine\utility::flag("vr_delete_thrown_grenades")) {
    if(isDefined(var_0)) {
      var_1 = undefined;

      if(issubstr(var_0.model, "seeker"))
        var_2 = "seeker";
      else if(issubstr(var_0.model, "emp"))
        var_2 = "emp";
      else if(issubstr(var_0.model, "anti_grav"))
        var_2 = "antigrav";
      else if(issubstr(var_0.model, "frag"))
        var_2 = "frag";
      else if(issubstr(var_0.model, "foam"))
        var_2 = "coverwall";
      else if(issubstr(var_0.model, "drone")) {
        var_1 = var_0.origin;
        var_2 = "drone";
      } else
        return;

      var_0 _id_85AC();

      if(scripts\engine\utility::flag("vr_delete_thrown_grenades")) {
        switch (var_2) {
          case "seeker":
            level thread _id_0E26::_id_DFC1();
            scripts\engine\utility::flag_waitopen("seeker_force_delete");
            var_3 = level._id_F10A._id_A8C6;
            break;
          case "emp":
            level thread _id_0E25::_id_DFBE();
            scripts\engine\utility::flag_waitopen("emp_force_delete");
            var_3 = level._id_612D._id_A8C6;
            break;
          case "antigrav":
            level thread _id_0E21::_id_DFBA();
            scripts\engine\utility::flag_waitopen("antigrav_force_delete");
            var_3 = level._id_2006._id_A8C6;
            break;
          case "coverwall":
            level thread scripts\sp\coverwall::_id_DFBD();
            scripts\engine\utility::flag_waitopen("coverwall_force_delete");
            var_3 = level.player._id_4759._id_A8C6;
            break;
          case "frag":
            level thread _id_0B1D::_id_DFBF();
            scripts\engine\utility::flag_waitopen("frag_force_delete");
            var_3 = level._id_0149._id_A8C6;
            break;
          case "drone":
            level thread _id_0E2D::_id_5139();
            var_3 = var_1;
            break;
          default:
            var_3 = undefined;
        }

        if(var_2 == "drone")
          level thread _id_DFF0(0);
        else if(isDefined(var_3))
          level thread _id_859E("vfx_vr_equipment_derez", var_3);
      }
    }
  }
}

_id_85AC() {
  self endon("explode");
  self endon("missile_stuck");
  self endon("death");
  self endon("entitydeleted");
  level endon("reset_vr");
  var_0 = getEnt("vr_thrown_grenade_trigger", "targetname");

  for(;;) {
    if(self istouching(var_0)) {
      scripts\engine\utility::waitframe();
      continue;
    }

    break;
  }
}

_id_DFED(var_0) {
  level endon("reset_vr");

  if(!isDefined(var_0))
    var_0 = 0;

  level thread _id_DFF0(var_0);
  level thread _id_DFF3(var_0);
  level thread _id_DFF1(var_0);
  level thread _id_DFEE(var_0);
  level thread _id_DFEF(var_0);
  level thread _id_DFF2(var_0);

  if(!var_0) {
    scripts\engine\utility::flag_waitopen("seeker_force_delete");
    scripts\engine\utility::flag_waitopen("emp_force_delete");
    scripts\engine\utility::flag_waitopen("antigrav_force_delete");
    scripts\engine\utility::flag_waitopen("coverwall_force_delete");
    scripts\engine\utility::flag_waitopen("frag_force_delete");
  }
}

_id_DFF0(var_0) {
  level thread _id_0E2D::_id_5139();
  level thread _id_0E2D::_id_5138();

  foreach(var_2 in level.player._id_4C29) {
    if(isDefined(var_2._id_51BA)) {
      if(var_2._id_51BA)
        continue;
    }

    if(isDefined(var_2._id_C7B4)) {
      if(var_2._id_C7B4)
        continue;
    }

    if(!var_0)
      level thread _id_859F("vfx_vr_equipment_derez", var_2);
  }
}

_id_DFF3(var_0) {
  if(!var_0) {
    foreach(var_2 in level._id_F10A._id_162D)
    level thread _id_859E("vfx_vr_equipment_derez", var_2.origin);

    foreach(var_5 in level._id_F10A._id_1633)
    level thread _id_859E("vfx_vr_equipment_derez", var_5.origin);
  }

  _id_0E26::_id_DFC1();
}

_id_DFF1(var_0) {
  if(!var_0) {
    foreach(var_2 in level._id_612D._id_522C)
    level thread _id_859E("vfx_vr_equipment_derez", var_2.origin + (0, 0, 16));
  }

  _id_0E25::_id_DFBE();
}

_id_DFEE(var_0) {
  if(!var_0) {
    foreach(var_2 in level._id_2006._id_522B)
    level thread _id_859E("vfx_vr_equipment_derez", var_2.origin + (0, 0, 16));
  }

  _id_0E21::_id_DFBA();
}

_id_DFEF(var_0) {
  if(!var_0) {
    foreach(var_2 in level.player._id_4759._id_11168) {
      if(isDefined(var_2.grenade))
        var_3 = var_2.grenade.origin;
      else
        var_3 = var_2.origin;

      level thread _id_859E("vfx_vr_equipment_derez", var_3 + (0, 0, 16));
    }
  }

  scripts\sp\coverwall::_id_DFBD();
}

_id_DFF2(var_0) {
  if(!var_0) {
    foreach(var_2 in level._id_0149._id_B37A) {
      var_3 = var_2.origin;
      level thread _id_859E("vfx_vr_equipment_derez", var_3);
    }
  }

  _id_0B1D::_id_DFBF();
}

_id_859E(var_0, var_1) {
  level endon("reset_vr");
  var_2 = spawnfx(scripts\engine\utility::getfx(var_0), var_1);
  triggerfx(var_2);
  level thread scripts\engine\utility::play_sound_in_space("emp_shock_short", var_1);
  var_2._id_F185 = 0;
  level._id_13563._id_760D[level._id_13563._id_760D.size] = var_2;
  wait 1.5;
  level._id_13563._id_760D = scripts\engine\utility::array_remove(level._id_13563._id_760D, var_2);
  var_2 delete();
}

_id_859F(var_0, var_1) {
  level endon("reset_vr");

  if(isDefined(var_1._id_9A96)) {
    while(var_1._id_9A96)
      scripts\engine\utility::waitframe();
  }

  var_2 = spawnfx(scripts\engine\utility::getfx(var_0), var_1._id_5BD7.origin);
  triggerfx(var_2);
  level thread scripts\engine\utility::play_sound_in_space("emp_shock_short", var_1._id_5BD7.origin);
  var_2._id_F185 = 0;
  level._id_13563._id_760D[level._id_13563._id_760D.size] = var_2;
  wait 1.5;
  level._id_13563._id_760D = scripts\engine\utility::array_remove(level._id_13563._id_760D, var_2);
  var_2 delete();
}

_id_A5BD(var_0) {
  level endon("reset_vr");
  var_0 waittill("rotation_done");
  scripts\engine\utility::flag_clear("vr_delete_thrown_grenades");
}

_id_A5D0() {
  level endon("reset_vr");
  var_0 = getEnt("vr_trigger_kill_equipment", "targetname");

  for(;;) {
    var_0 waittill("trigger", var_1);

    if(var_1.unittype == "seeker") {
      level thread _id_859E("vfx_vr_equipment_derez", var_1.origin);
      var_1 thread _id_0E26::_id_E084();
    }
  }
}

_id_1E3A() {
  level endon("reset_vr");

  for(;;) {
    level.player scripts\engine\utility::waittill_any("reload_start", "weapon_switch_started", "offhand_fired", "weapon_fired");
    var_0 = undefined;
    var_1 = undefined;
    var_2 = undefined;
    var_3 = undefined;
    var_4 = level.player getcurrentprimaryweapon();
    var_5 = weaponclipsize(var_4);
    var_6 = level.player getweaponammostock(var_4);
    var_7 = scripts\sp\utility::_id_7BD6();
    var_8 = scripts\sp\utility::_id_7C3D();
    var_9 = scripts\sp\utility::_id_7CAF();
    var_10 = scripts\sp\utility::_id_7CB1();

    if(isDefined(var_7) && var_7 != "none")
      var_0 = level.player getweaponammoclip(var_7);

    if(isDefined(var_8) && var_8 != "none")
      var_1 = level.player getweaponammoclip(var_8);

    if(isDefined(var_9) && var_9 != "none")
      var_2 = level.player getweaponammoclip(var_9);

    if(isDefined(var_10) && var_10 != "none")
      var_3 = level.player getweaponammoclip(var_10);

    if(_id_0A2F::_id_DA40(var_4)) {
      if(issubstr(var_4, "chargeshot") || issubstr(var_4, "penetrationrail")) {
        var_11 = 2;

        if(level.player getcurrentweaponclipammo() < var_11)
          level.player setweaponammoclip(var_4, var_5);
      } else if(issubstr(var_4, "steeldragon")) {
        var_11 = 25;

        if(var_6 < var_5) {
          if(level.player getcurrentweaponclipammo() < var_11)
            level.player givemaxammo(var_4);
        }
      } else if(issubstr(var_4, "lockon")) {
        if(var_6 <= var_5)
          level.player givemaxammo(var_4);
      }
    } else if(var_6 <= var_5)
      level.player givemaxammo(var_4);

    if(isDefined(var_0) && var_0 < 1)
      level.player givemaxammo(var_7);

    if(isDefined(var_1) && var_1 < 1)
      level.player givemaxammo(var_8);

    if(isDefined(var_2) && var_2 < 1)
      level.player givemaxammo(var_9);

    if(isDefined(var_3) && var_3 < 1)
      level.player givemaxammo(var_10);
  }
}

_id_653A() {
  level endon("reset_vr");
  self endon("death");

  foreach(var_1 in level._id_13563._id_653C) {
    if(!var_1.active) {
      var_1.active = 1;
      self.utility_triggers = var_1;
      break;
    }
  }

  self.utility_triggers linkTo(self, "tag_origin", (0, 0, 8), (0, 0, 0));
  scripts\engine\utility::waitframe();
  self.utility_triggers setlightintensity(self.utility_triggers._id_10C89);
  self.utility_triggers _meth_8300(37);

  for(;;) {
    _id_653B(47, 1.0);
    wait 0.25;
    _id_653B(37, 1.0);
  }
}

_id_653B(var_0, var_1) {
  level endon("reset_vr");
  self endon("death");
  var_2 = int(var_1 * 20);
  var_3 = self.utility_triggers _meth_8136();
  var_4 = (var_0 - var_3) / var_2;

  for(var_5 = 0; var_5 < var_2; var_5++) {
    self.utility_triggers _meth_8300(var_3 + var_5 * var_4);
    wait 0.05;
  }

  self.utility_triggers _meth_8300(var_0);
}

_id_F188(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(var_1))
    var_1 = 0;

  if(var_1) {
    foreach(var_7 in var_0._id_75B5) {
      var_3 = var_0._id_CBFA.origin + var_7._id_F187;
      var_8 = spawnfx(scripts\engine\utility::getfx(var_7.script_parameters), var_3);
      triggerfx(var_8);
      var_8._id_F185 = 1;
      level._id_13563._id_760D[level._id_13563._id_760D.size] = var_8;
    }
  } else {
    if(isDefined(var_4) && isDefined(var_5))
      var_8 = spawnfx(scripts\engine\utility::getfx(var_2), var_3, var_4, var_5);
    else
      var_8 = spawnfx(scripts\engine\utility::getfx(var_2), var_3);

    triggerfx(var_8);
    var_8._id_F185 = 1;
    level._id_13563._id_760D[level._id_13563._id_760D.size] = var_8;
  }
}

_id_A62B(var_0) {
  if(!isDefined(var_0))
    var_0 = 0;

  var_1 = [];

  foreach(var_3 in level._id_13563._id_760D) {
    if(var_0) {
      if(isDefined(var_3._id_F185)) {
        if(var_3._id_F185)
          var_3 delete();
      } else
        var_1[var_1.size] = var_3;

      continue;
    }

    var_3 delete();
  }

  level._id_13563._id_760D = var_1;
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
    var_1 scripts\sp\utility::_id_E2B0();
  }
}

_id_E241() {
  level notify("reset_vr");
  level.player notify("stop_delay_call");
  level.player freezecontrols(1);
  level.player setstance("stand");
  scripts\sp\outline::_id_91A1("default", scripts\sp\outline::_id_9192);
  _id_A62A();
  _id_10FB6();
  _id_DFED(1);
  scripts\engine\utility::flag_clear("vr_delete_thrown_grenades");
  _id_12BA8();
  _id_12B92();
  scripts\engine\utility::waitframe();
  level._id_13563._id_BF5B = [];

  foreach(var_1 in level._id_13563._id_12B98)
  var_1 delete();

  level._id_13563._id_12B98 = [];
  level._id_13563._id_2F09 hide();
  level._id_13563._id_9B3D show();

  foreach(var_4 in level._id_13563._id_653C) {
    var_4.active = 0;
    var_4 setlightintensity(0);
  }

  _id_E1A2();
  wait 0.1;
  level._id_13563._id_4E37 = 0;
  level._id_13563._id_5BDE = 0;
  _id_A62B();

  foreach(var_7 in level._id_13563._id_E546) {
    if(var_7._id_EDD5 == 0)
      var_7._id_D958 linkTo(var_7, "tag_origin", (0, 0, 0), (0, 90, 0));

    foreach(var_9 in var_7._id_466A)
    _id_465F(var_9, var_7);

    foreach(var_12 in var_7.segments)
    _id_F189(var_12, var_7);

    var_7 scripts\sp\utility::_id_65DD("ring_spinning");
    var_7 scripts\sp\utility::_id_65DD("ring_unfolding");
  }

  level.player freezecontrols(0);
}

_id_465F(var_0, var_1) {
  if(isDefined(var_0._id_1078F))
    var_0._id_1078F._id_A534 = undefined;

  var_0._id_AC84 _meth_82FC(var_0._id_AC84._id_10BF7);
  var_0._id_AC84 setlightintensity(0);
  var_0._id_6128 hide();
  var_0._id_6123 hide();
  var_0 hide();
  var_0._id_CBFA linkTo(var_1, "j_corner" + var_0.script_index, (0, 0, 0), (0, 0, 0));
  _id_6B73(var_0, 1);
}

_id_F189(var_0, var_1) {
  var_0 hide();

  if(isDefined(var_0.collision))
    var_0.collision hide();

  if(isDefined(var_0._id_6128))
    var_0._id_6128 hide();

  if(isDefined(var_0._id_6123))
    var_0._id_6123 hide();

  if(isDefined(var_0._id_6E86)) {
    if(isDefined(var_0._id_6E86._id_6128))
      var_0._id_6E86._id_6128 hide();

    if(isDefined(var_0._id_6E86._id_6123))
      var_0._id_6E86._id_6123 hide();

    var_0._id_6E86 hide();
    var_0._id_6E86 linkTo(var_0._id_CBFA, "", var_0._id_6E86._id_D6A0, var_0._id_6E86.angles_offset);
  }

  var_0._id_CBFA linkTo(var_1, "j_segment" + var_0.script_index, (0, 0, 0), (0, 0, 0));
  _id_6B73(var_0, 1);
}

_id_6B73(var_0, var_1) {
  if(isDefined(var_0._id_6B71)) {
    foreach(var_3 in var_0._id_6B71) {
      if(var_1) {
        var_3 linkTo(var_0._id_CBFA, "", var_3._id_D6A0, var_3.angles_offset);
        var_3 hide();
        continue;
      }

      var_3 linkTo(var_0._id_CBFA);
    }
  }
}

_id_57F2(var_0) {
  self _meth_80AF(var_0);
  level._id_13563._id_2BE3[level._id_13563._id_2BE3.size] = self;
}

_id_12B92() {
  foreach(var_1 in level._id_13563._id_2BE3)
  var_1 _meth_83C9();

  level._id_13563._id_2BE3 = [];
}

_id_E1A2() {
  level._id_13563._id_9B3D._id_CBFA.origin = level._id_13563._id_9B3D._id_CBFA.start_pos;

  foreach(var_1 in level._id_13563._id_E546) {
    var_1 moveTo(var_1.start_pos, 0.05);
    var_1 rotateTo(var_1._id_10BA1, 0.05);

    foreach(var_3 in var_1._id_466A) {
      if(isDefined(var_3._id_6B71)) {
        foreach(var_5 in var_3._id_6B71) {
          var_5 moveTo(var_5.origin, 0.05);
          var_5 rotateTo(var_5.angles, 0.05);
        }
      }
    }

    foreach(var_9 in var_1.segments) {
      if(isDefined(var_9._id_6E86))
        var_9._id_6E86 rotateTo(var_9._id_6E86.angles, 0.05);

      if(isDefined(var_9._id_6B71)) {
        foreach(var_5 in var_9._id_6B71) {
          var_5 moveTo(var_5.origin, 0.05);
          var_5 rotateTo(var_5.angles, 0.05);
        }
      }
    }
  }

  foreach(var_15 in level._id_13563._id_4D95) {
    var_15 moveTo(var_15.origin, 0.05);
    var_15 hide();

    if(isDefined(var_15._id_A645)) {
      var_15._id_A645 hide();
      var_15._id_A645 hidepart("tag_num" + var_15._id_A645._id_4B5B);
      var_15._id_A645 showpart("tag_num0");
      var_15._id_A645._id_4B5B = 0;

      foreach(var_17 in var_15._id_A645._id_1141C)
      var_15._id_A645 hidepart(var_17);
    }
  }
}

_id_10FB6() {
  level.player stopsounds();

  foreach(var_1 in level._id_13563._id_E546) {
    var_1 stopsounds();
    var_1 _meth_83A1();
    var_1 clearanim(%root, 0);
  }

  foreach(var_4 in level._id_13563._id_E546[1]._id_466A)
  var_4 stopsounds();

  foreach(var_7 in level._id_13563._id_E546[1].segments)
  var_7 stopsounds();

  foreach(var_7 in level._id_13563._id_E546[0].segments)
  var_7._id_6E86 stopsounds();

  foreach(var_12 in level._id_13563._id_12B98) {
    var_12 stopsounds();
    var_12 _meth_83A1();
    var_12 clearanim(%root, 0);
  }

  foreach(var_15 in level._id_13563._id_4D95) {
    if(isDefined(var_15._id_A645)) {
      var_15._id_A645 stopsounds();
      var_15._id_A645 _meth_83A1();
      var_15._id_A645 clearanim(%root, 0);
      var_15._id_A645 scripts\sp\utility::_id_65DD("killcounter_animating");
    }
  }
}

_id_13598() {
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
      _id_CE8D(undefined, 0);
      _id_E241();
      _id_F620();
      level thread _id_661E(1);
      break;
    case "player_vr_exit_request":
      scripts\engine\utility::flag_set("vr_tutorial_leave_shown");
      setsaveddvar("bg_cinematicAboveUI", "1");
      setsaveddvar("bg_cinematicFullScreen", "1");
      setsaveddvar("bg_cinematicCanPause", "1");
      level.player clearclienttriggeraudiozone(2);

      if(scripts\engine\utility::flag_exist("acceped_vr"))
        scripts\engine\utility::flag_clear("acceped_vr");

      _id_CE8D(undefined, 0);
      _id_E241();
      _id_F620();
      setomnvar("ui_in_vr", 0);
      scripts\engine\utility::flag_clear("in_vr_mode");
      level._id_93A9 = undefined;
      level thread _id_0EE8::_id_C608(0);
      break;
  }
}

_id_F61F() {
  level.player _meth_823B(getEnt("start_vr_chamber", "targetname"));
  scripts\sp\utility::_id_28D7("axis");
  level.player scripts\sp\utility::_id_11428();
  level.player _meth_8559(0);

  if(issubstr(level.script, "shipcrib"))
    setsuncolorandintensity(0);

  wait 0.75;
  level.player unlink();
  level.player disableusability();

  if(issubstr(level.script, "shipcrib"))
    level._id_EFED = "combat_vr";
  else {
    level.player scripts\sp\utility::_id_F526("normal");
    level.player thread scripts\sp\utility::_id_2B77(0.5);
    level.player scripts\engine\utility::allow_mantle(1);
    level.player scripts\engine\utility::allow_weapon_switch(1);
    level.player scripts\engine\utility::allow_prone(1);
    level.player _meth_80A1();
    level.player _meth_80CB(1);
    level.player switchtoweaponimmediate(level.player getcurrentprimaryweapon());
    setsaveddvar("mantle_enable", 1);
    setsaveddvar("cg_drawCrosshair", 1);
    setomnvar("ui_hide_weapon_info", 0);
    setomnvar("ui_hide_hud", 0);
  }

  _id_0EE8::_id_8311();
  level thread create_fx_pause();
  _id_F60F();
  level thread _id_1E3A();
}

_id_F620() {
  level.player _meth_8475();
  level.player _meth_8559(1);
  level thread scripts\sp\gameskill::_id_E080();
  level.player enableusability();
  scripts\sp\utility::_id_28D8("axis");
  level thread create_fx_resume();

  if(issubstr(level.script, "shipcrib"))
    setsuncolorandintensity(level._id_FD6E._id_111D7);
  else {
    level.player scripts\sp\utility::_id_11428();
    level.player scripts\engine\utility::allow_mantle(0);
    level.player scripts\engine\utility::allow_weapon_switch(0);
    level.player scripts\engine\utility::allow_prone(0);
    level.player _meth_80D1();
    level.player _meth_80CB(0);
    setsaveddvar("mantle_enable", 0);
    setsaveddvar("cg_drawCrosshair", 0);
    setomnvar("ui_hide_weapon_info", 1);
  }
}

_id_12BA8() {
  foreach(var_1 in level._id_13563._id_653C) {
    if(var_1 islinked())
      var_1 unlink();
  }

  foreach(var_4 in level._id_13563._id_E546) {
    if(var_4._id_EDD5 == 0)
      var_4._id_D958 unlink();

    foreach(var_6 in var_4._id_466A) {
      var_6._id_CBFA unlink();

      if(isDefined(var_6._id_6B71)) {
        foreach(var_8 in var_6._id_6B71)
        var_8 unlink();
      }
    }

    foreach(var_12 in var_4.segments) {
      var_12._id_CBFA unlink();

      if(isDefined(var_12._id_6E86))
        var_12._id_6E86 unlink();

      if(isDefined(var_12._id_6B71)) {
        foreach(var_8 in var_12._id_6B71)
        var_8 unlink();
      }
    }
  }
}

waittilbinkend() {
  while(iscinematicplaying())
    scripts\engine\utility::waitframe();

  setsaveddvar("bg_cinematicAboveUI", "0");
}

_id_CE8D(var_0, var_1) {
  level notify("playing_vr_tranistion_bink");
  level endon("playing_vr_tranistion_bink");

  if(!isDefined(var_0))
    var_0 = "ship_enter_vr";

  if(!isDefined(var_1))
    var_1 = 0;

  stopcinematicingame();
  wait 0.1;
  setsaveddvar("bg_cinematicFullScreen", "1");
  setsaveddvar("bg_cinematicCanPause", "0");
  setsaveddvar("bg_cinematicAboveUI", "1");

  if(var_1)
    var_2 = "weapon_loadout_terminal_intro";
  else
    var_2 = "weapon_loadout_terminal_transition";

  cinematicingame(var_2);

  while(!iscinematicplaying())
    scripts\engine\utility::waitframe();

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