/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2822.gsc
**************************************/

init() {
  if(!isDefined(level._id_EC8D))
    level._id_EC8D = [];

  if(!isDefined(level._id_EC88))
    level._id_EC88 = [];

  if(!isDefined(level._id_EC8A))
    level._id_EC8A = [];

  if(!isDefined(level._id_EC8B))
    level._id_EC8B = [];

  if(!isDefined(level._id_EC86))
    level._id_EC86 = [];

  if(!isDefined(level.scr_sound))
    level.scr_sound = [];

  if(!isDefined(level._id_EC91))
    level._id_EC91 = [];

  if(!isDefined(level._id_EC95))
    level._id_EC95 = [];

  if(!isDefined(level._id_EC85))
    level._id_EC85[0][0] = 0;

  if(!isDefined(level._id_EC91))
    level._id_EC91 = [];

  if(!isDefined(level._id_EC8E))
    level._id_EC8E = [];

  if(!isDefined(level._id_EC89))
    level._id_EC89 = [];

  if(!isDefined(level._notetrackfx))
    level._notetrackfx = [];

  scripts\engine\utility::create_lock("moreThanThreeHack", 3);
  scripts\engine\utility::create_lock("trace_part_for_efx", 12);
  thread _id_D807();
  scripts\anim\notetracks::registernotetracks_init();
  scripts\anim\pain::_id_98AC();
  scripts\anim\death::_id_95A2();
  _id_9525();
}

_id_9525() {
  level._id_1FDC = [];
  level._id_1FD4 = [];
  var_0 = getarraykeys(level._id_EC8D);

  for(var_1 = 0; var_1 < var_0.size; var_1++)
    _id_969F(var_0[var_1]);

  var_0 = getarraykeys(level._id_EC86);

  for(var_1 = 0; var_1 < var_0.size; var_1++)
    _id_9526(var_0[var_1]);
}

_id_9526(var_0) {
  var_1 = getarraykeys(level._id_EC86[var_0]);

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    var_3 = var_1[var_2];
    var_4 = level._id_EC86[var_0][var_3];
    level._id_1FD4[var_0][var_3]["#" + var_3]["soundalias"] = var_4;
    level._id_1FD4[var_0][var_3]["#" + var_3]["created_by_animSound"] = 1;
  }
}

_id_969F(var_0) {
  foreach(var_10, var_2 in level._id_EC8D[var_0]) {
    foreach(var_9, var_4 in var_2) {
      foreach(var_6 in var_4) {
        var_7 = var_6["sound"];

        if(!isDefined(var_7)) {
          continue;
        }
        level._id_1FD4[var_0][var_10][var_9]["soundalias"] = var_7;

        if(isDefined(var_6["created_by_animSound"]))
          level._id_1FD4[var_0][var_10][var_9]["created_by_animSound"] = 1;
      }
    }
  }
}

_id_D807() {
  waittillframeend;

  if(!isDefined(level._id_EC8C)) {
    return;
  }
  var_0 = getarraykeys(level._id_EC8C);

  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    if(isarray(level._id_EC8C[var_0[var_1]])) {
      for(var_2 = 0; var_2 < level._id_EC8C[var_0[var_1]].size; var_2++)
        precachemodel(level._id_EC8C[var_0[var_1]][var_2]);

      continue;
    }

    precachemodel(level._id_EC8C[var_0[var_1]]);
  }
}

_id_6370(var_0, var_1) {
  self waittill(var_0);

  foreach(var_3 in var_1) {
    var_4 = var_3["guy"];

    if(!isDefined(var_4)) {
      continue;
    }
    var_4._id_117C--;
    var_4._id_1300 = gettime();
  }
}

_id_1EC1(var_0, var_1, var_2) {
  var_3 = _id_781C(var_2);
  var_4 = var_3["origin"];
  var_5 = var_3["angles"];
  scripts\engine\utility::array_levelthread(var_0, ::_id_1EC2, var_1, var_4, var_5);
}

_id_1ECA(var_0, var_1, var_2) {
  var_3 = _id_781C(var_2);
  var_4 = var_3["origin"];
  var_5 = var_3["angles"];
  thread _id_1EC2(var_0, var_1, var_4, var_5, "generic");
}

_id_1EC7(var_0, var_1, var_2) {
  var_3 = [];
  var_3[0] = var_0;
  _id_1F2C(var_3, var_1, var_2, 0, "generic");
}

_id_1ECB(var_0, var_1, var_2) {
  var_3 = var_0.allowpain;
  var_0 scripts\sp\utility::_id_5564();
  _id_1EC8(var_0, "gravity", var_1, var_2);

  if(var_3)
    var_0 scripts\sp\utility::_id_6224();
}

_id_1ED1(var_0, var_1, var_2) {
  var_3 = [];
  var_3[0] = var_0;
  _id_1F2C(var_3, var_1, var_2, 0.25, "generic");
}

_id_1ECE(var_0, var_1, var_2) {
  var_3 = [];
  var_3[0] = var_0;
  _id_1F0A(var_3, var_1, var_2, "generic");
}

_id_1ED0(var_0, var_1, var_2, var_3) {
  var_4 = [];
  var_4[0] = var_0;

  if(scripts\sp\interaction::_id_9C26(self) || scripts\sp\interaction::_id_9CD7(self)) {
    foreach(var_0 in var_4) {
      if(isDefined(self._id_EE92)) {
        var_0.asm._id_4C86.interaction = self._id_EE92;
        continue;
      }

      var_0.asm._id_4C86.interaction = self.script_noteworthy;
    }

    var_7 = scripts\sp\interaction::_id_7A45(var_0.asm._id_4C86.interaction);

    if(!isDefined(var_7))
      var_7 = scripts\sp\interaction::_id_7CA7(var_0.asm._id_4C86.interaction);

    var_0.asm._id_4C86._id_22F1 = undefined;

    if(isDefined(var_7))
      var_0.asm._id_4C86._id_22F1 = var_0 scripts\sp\interaction::_id_7837(var_7);

    if(isDefined(var_0.asm._id_4C86._id_22F1)) {
      _id_1F1B(var_4, var_1, var_2, "generic", ::_id_DD0F, ::_id_DD10, var_3);
      return;
    }

    _id_1F1B(var_4, var_1, var_2, "generic", ::_id_DD11, ::_id_DD15, var_3);
    return;
  } else
    _id_1F1B(var_4, var_1, var_2, "generic", ::_id_DD11, ::_id_DD15, var_3);
}

_id_1F10(var_0, var_1, var_2) {
  _id_1F1B(var_0, var_1, var_2, undefined, ::_id_DD12, ::_id_DD15);
}

_id_1F11(var_0, var_1, var_2) {
  _id_1F1B(var_0, var_1, var_2, undefined, ::_id_DD13, ::_id_DD15);
}

_id_1ECC(var_0, var_1, var_2, var_3) {
  var_4 = [];
  var_4["guy"] = var_0;
  var_4["entity"] = self;
  var_4["tag"] = var_3;
  var_5[0] = var_4;
  _id_1EE8(var_5, var_1, var_2, "generic");
}

_id_1EAB(var_0, var_1, var_2, var_3) {
  var_4 = _id_781C(var_3);
  var_5 = var_4["origin"];
  var_6 = var_4["angles"];
  var_7 = undefined;

  foreach(var_9 in var_0) {
    var_7 = var_9;
    thread _id_1EAE(var_9, var_1, var_2, var_5, var_6, var_9._id_1FBB, 0);
  }

  var_7 _id_1368A(var_2);
  self notify(var_2);
}

_id_1EAC(var_0, var_1, var_2, var_3) {
  var_4 = _id_781C(var_3);
  var_5 = var_4["origin"];
  var_6 = var_4["angles"];

  foreach(var_8 in var_0)
  thread _id_1EAE(var_8, var_1, var_2, var_5, var_6, var_8._id_1FBB, 1);

  var_0[0] _id_1368A(var_2);
  self notify(var_2);
}

_id_1368A(var_0) {
  self endon("finished_custom_animmode" + var_0);
  self waittill("death");
}

_id_1EC8(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = _id_781C(var_3);
  var_7 = var_6["origin"];
  var_8 = var_6["angles"];
  thread _id_1EAE(var_0, var_1, var_2, var_7, var_8, "generic", 0, var_4, var_5);
  var_0 _id_1368A(var_2);
  self notify(var_2);
}

_id_1EC9(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = _id_781C(var_3);
  var_7 = var_6["origin"];
  var_8 = var_6["angles"];
  thread _id_1EAE(var_0, var_1, var_2, var_7, var_8, "generic", 1, var_4, var_5);
  var_0 _id_1368A(var_2);
  self notify(var_2);
}

_id_1EAF(var_0, var_1, var_2, var_3) {
  var_4 = [];
  var_4[0] = var_0;
  _id_1EAB(var_4, var_1, var_2, var_3);
}

_id_1EAD(var_0, var_1, var_2, var_3) {
  var_4 = [];
  var_4[0] = var_0;
  _id_1EAC(var_4, var_1, var_2, var_3);
}

_id_1EC3(var_0, var_1, var_2) {
  var_3 = [];
  var_3[0] = var_0;
  _id_1EC1(var_3, var_1, var_2);
}

_id_1EE0(var_0, var_1, var_2) {
  var_3 = [];
  var_3[0] = var_0;
  _id_1EC1(var_3, var_1, var_2);
  _id_1F2A(var_3, var_1, 1.0);
  var_4 = var_0 scripts\sp\utility::_id_7DC1(var_1);
  var_5 = getmovedelta(var_4);
  var_6 = getangledelta3d(var_4);
  var_7 = rotatevector(var_5, var_0.angles);
  var_8 = var_0.origin + var_7;
  var_9 = combineangles(var_0.angles, var_6);

  if(isai(var_0))
    var_0 _meth_80F1(var_8, var_9, 9999);
  else if(isDefined(self.vehicletype)) {
    var_0 vehicle_teleport(var_8, var_9);
    var_0 dontinterpolate();
  } else {
    var_0.origin = var_8;
    var_0.angles = var_9;
    var_0 dontinterpolate();
  }
}

_id_23AE(var_0, var_1) {
  if(!isDefined(var_1))
    var_1 = self._id_1FBB;

  var_2 = 0;

  if(isDefined(level._id_EC85[var_1])) {
    var_2 = 1;

    if(isDefined(level._id_EC85[var_1][var_0]))
      return;
  }

  var_3 = 0;

  if(isDefined(level._id_EC88[var_1])) {
    var_3 = 1;

    if(isDefined(level._id_EC88[var_1][var_0]))
      return;
  }

  var_4 = 0;

  if(isDefined(level.scr_sound[var_1])) {
    var_4 = 1;

    if(isDefined(level.scr_sound[var_1][var_0]))
      return;
  }

  if(var_2 || var_4 || var_3) {
    if(var_2) {
      var_5 = getarraykeys(level._id_EC85[var_1]);

      foreach(var_7 in var_5) {}
    }

    if(var_4) {
      var_5 = getarraykeys(level.scr_sound[var_1]);

      foreach(var_7 in var_5) {}
    }

    if(var_3) {
      var_5 = getarraykeys(level._id_EC88[var_1]);

      foreach(var_7 in var_5) {}
    }

    return;
  }

  var_13 = getarraykeys(level._id_EC85);
  var_13 = scripts\engine\utility::array_combine(var_13, getarraykeys(level.scr_sound));

  foreach(var_15 in var_13) {}
}

_id_1EC2(var_0, var_1, var_2, var_3, var_4) {
  var_0._id_6DCC = gettime();
  var_5 = undefined;

  if(isDefined(var_4))
    var_5 = var_4;
  else
    var_5 = var_0._id_1FBB;

  var_6 = 0;

  if(isarray(level._id_EC85[var_5][var_1])) {
    var_7 = level._id_EC85[var_5][var_1][0];
    var_6 = 1;
  } else
    var_7 = level._id_EC85[var_5][var_1];

  var_0 _id_F5B0(var_1, var_2, var_3, var_5, var_6);

  if(isai(var_0)) {
    var_0._id_1286 = var_7;
    var_0._id_1180 = var_5;
    var_0 _id_0A1E::_id_2307(scripts\anim\first_frame::main);
  } else {
    var_0 _meth_83A1();
    var_0 setanimknob(var_7, 1, 0, 0);
  }
}

_id_1EAE(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  if(isai(var_0) && var_0 scripts\sp\utility::_id_58DA()) {
    return;
  }
  var_9 = undefined;

  if(isDefined(var_5))
    var_9 = var_5;
  else
    var_9 = var_0._id_1FBB;

  if(!isDefined(var_8) || !var_8)
    var_0 _id_F5B0(var_2, var_3, var_4, var_5, var_6);

  var_0._id_117F = var_1;
  var_0._id_11BA = var_2;
  var_0._id_141C = self;
  var_0._id_117E = var_2;
  var_0._id_1180 = var_9;
  var_0._id_11BB = var_6;
  var_0._id_11BC = var_7;

  if(getdvarint("ai_iw7", 0) == 1) {
    var_0 _id_0A1E::_id_2307(scripts\anim\animmode::main, _id_0A1E::_id_2385);
    return;
  }

  var_0 animcustom(scripts\anim\animmode::main);
}

_id_1EE7(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = [];

  foreach(var_8 in var_0) {
    var_9 = [];
    var_9["guy"] = var_8;
    var_9["entity"] = self;
    var_9["tag"] = var_3;
    var_9["origin_offset"] = var_4;
    var_6[var_6.size] = var_9;
  }

  _id_1EE8(var_6, var_1, var_2, var_5);
}

_id_1EE9(var_0, var_1, var_2, var_3) {
  var_4 = [];
  var_4[0] = var_0;
  _id_1EE8(var_4, var_1, var_2, var_3);
}

_id_1EE8(var_0, var_1, var_2, var_3) {
  foreach(var_5 in var_0) {
    var_6 = var_5["guy"];

    if(!isDefined(var_6)) {
      continue;
    }
    if(!isDefined(var_6._id_117C))
      var_6._id_117C = 0;

    if(scripts\sp\utility::_id_93A6() && (isDefined(var_6.team) && var_6.team == "axis") && (isDefined(var_6.unittype) && var_6.unittype == "soldier"))
      var_6._id_C05C = 1;

    var_6 endon("death");
    var_6._id_117C++;
  }

  var_8 = var_0[0]["guy"];

  if(!isDefined(var_2))
    var_2 = "stop_loop";

  thread _id_6370(var_2, var_0);
  self endon(var_2);
  var_9 = "looping anim";
  var_10 = undefined;

  if(isDefined(var_3))
    var_10 = var_3;
  else
    var_10 = var_8._id_1FBB;

  var_11 = 0;
  var_12 = 0;

  for(;;) {
    for(var_11 = _id_1F60(var_10, var_1); var_11 == var_12 && var_11 != 0; var_11 = _id_1F60(var_10, var_1)) {}

    var_12 = var_11;
    var_13 = undefined;
    var_14 = 999999;
    var_15 = undefined;
    var_6 = undefined;

    foreach(var_35, var_5 in var_0) {
      var_17 = var_5["entity"];
      var_6 = var_5["guy"];
      var_18 = var_17 _id_781C(var_5["tag"]);
      var_19 = var_18["origin"];
      var_20 = var_18["angles"];

      if(isDefined(var_5["origin_offset"])) {
        var_21 = var_5["origin_offset"];
        var_22 = anglesToForward(var_20);
        var_23 = anglestoright(var_20);
        var_24 = anglestoup(var_20);
        var_19 = var_19 + var_22 * var_21[0];
        var_19 = var_19 + var_23 * var_21[1];
        var_19 = var_19 + var_24 * var_21[2];
      }

      if(isDefined(var_6._id_E014)) {
        var_6._id_E014 = undefined;
        var_0[var_35] = undefined;
        continue;
      }

      var_25 = 0;
      var_26 = 0;
      var_27 = 0;
      var_28 = 0;
      var_29 = undefined;
      var_30 = undefined;
      var_31 = undefined;

      if(isDefined(var_3))
        var_31 = var_3;
      else
        var_31 = var_6._id_1FBB;

      if(isDefined(level._id_EC88[var_31]) && isDefined(level._id_EC88[var_31][var_1]) && isDefined(level._id_EC88[var_31][var_1][var_11])) {
        var_25 = 1;
        var_29 = level._id_EC88[var_31][var_1][var_11];
      }

      if(isDefined(level.scr_sound[var_31]) && isDefined(level.scr_sound[var_31][var_1]) && isDefined(level.scr_sound[var_31][var_1][var_11])) {
        var_26 = 1;
        var_30 = level.scr_sound[var_31][var_1][var_11];
      }

      if(isDefined(level._id_EC86[var_31]) && isDefined(level._id_EC86[var_31][var_11 + var_1]))
        var_6 playSound(level._id_EC86[var_31][var_11 + var_1]);

      if(isDefined(level._id_EC85[var_31]) && isDefined(level._id_EC85[var_31][var_1]) && (!isai(var_6) || !var_6 scripts\sp\utility::_id_58DA()))
        var_27 = 1;

      if(var_27) {
        if(isDefined(level._id_EC89[var_31]) && isDefined(level._id_EC89[var_31][var_1]))
          var_32 = level._id_EC89[var_31][var_1];
        else
          var_32 = 0.2;

        var_6 _id_A888();
        var_33 = undefined;

        if(isai(var_6))
          var_33 = var_6 _id_0A1E::_id_2356("Knobs", "body");
        else if(isDefined(var_6._id_1ED4))
          var_33 = [[var_6._id_1ED4]]();

        var_6 animScripted(var_9, var_19, var_20, level._id_EC85[var_31][var_1][var_11], undefined, var_33, var_32);
        var_34 = getanimlength(level._id_EC85[var_31][var_1][var_11]);

        if(var_34 < var_14) {
          var_14 = var_34;
          var_13 = var_35;
        }

        thread _id_10CBF(var_6, var_9, var_1, var_31, level._id_EC85[var_31][var_1][var_11]);
        thread _id_1FCA(var_6, var_9, var_1);
      }

      if(var_25 || var_26) {
        if(isai(var_6)) {
          if(var_27)
            var_6 scripts\anim\face::sayspecificdialogue(var_30);
          else
            var_6 scripts\anim\face::sayspecificdialogue(var_30, var_9);
        } else
          var_6 scripts\sp\utility::play_sound_on_entity(var_30);

        var_15 = var_35;
      }
    }

    if(!isDefined(var_6)) {
      break;
    }

    if(isDefined(var_13)) {
      var_0[var_13]["guy"] waittillmatch(var_9, "end");
      continue;
    }

    if(isDefined(var_15))
      var_0[var_15]["guy"] waittill(var_9);
  }
}

_id_1F2F(var_0, var_1) {}

_id_1F2E(var_0, var_1) {
  foreach(var_3 in var_0)
  var_3 thread _id_1F2F(self, var_1);
}

_id_1F2C(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_3))
    var_3 = 0;

  _id_1F31(var_0, var_1, var_2, var_3, var_4);
}

_id_1F30(var_0, var_1, var_2) {
  foreach(var_4 in var_0)
  var_4 scripts\sp\utility::_id_5564();

  _id_1EAB(var_0, "gravity", var_1, var_2);

  foreach(var_4 in var_0) {
    if(isDefined(var_4) && isalive(var_4))
      var_4 scripts\sp\utility::_id_6224();
  }
}

_id_1F33(var_0, var_1, var_2, var_3) {
  _id_1F31(var_0, var_1, var_2, 0.25, var_3);
}

_id_1F31(var_0, var_1, var_2, var_3, var_4) {
  var_5 = self;

  foreach(var_7 in var_0) {
    if(!isDefined(var_7)) {
      continue;
    }
    if(!isDefined(var_7._id_117C))
      var_7._id_117C = 0;

    var_7._id_117C++;
  }

  var_9 = _id_781C(var_2);
  var_10 = var_9["origin"];
  var_11 = var_9["angles"];
  var_12 = undefined;
  var_13 = 999999;
  var_14 = undefined;
  var_15 = undefined;
  var_16 = undefined;
  var_17 = undefined;
  var_18 = "single anim";

  foreach(var_34, var_7 in var_0) {
    var_20 = 0;
    var_21 = 0;
    var_22 = 0;
    var_23 = 0;
    var_24 = 0;
    var_25 = undefined;
    var_26 = undefined;
    var_27 = undefined;
    var_28 = undefined;

    if(isDefined(var_4))
      var_28 = var_4;
    else
      var_28 = var_7._id_1FBB;

    if(isDefined(level.scr_sound[var_28]) && isDefined(level.scr_sound[var_28][var_1])) {
      var_22 = 1;
      var_25 = level.scr_sound[var_28][var_1];
    }

    if(isDefined(level._id_EC88[var_28]) && isDefined(level._id_EC88[var_28][var_1])) {
      var_20 = 1;
      var_26 = level._id_EC88[var_28][var_1];
      var_16 = var_26;

      if(var_22) {
        if(animhasnotetrack(var_26, "vo_" + var_25)) {
          var_22 = 0;
          var_25 = undefined;
        }
      }
    }

    if(isDefined(level._id_EC8A[var_28]) && isDefined(level._id_EC8A[var_28][var_1])) {
      var_21 = 1;
      var_27 = level._id_EC8A[var_28][var_1];
      var_17 = var_27;
    }

    if(isDefined(level._id_EC85[var_28]) && isDefined(level._id_EC85[var_28][var_1]) && (!isai(var_7) || !var_7 scripts\sp\utility::_id_58DA()))
      var_23 = 1;

    if(isDefined(level._id_EC86[var_28]) && isDefined(level._id_EC86[var_28][var_1]))
      var_7 playSound(level._id_EC86[var_28][var_1]);

    if(var_23) {
      if(scripts\sp\utility::_id_93A6() && (isDefined(var_7.team) && var_7.team == "axis") && (isDefined(var_7.unittype) && var_7.unittype == "soldier"))
        var_7.dropweapon = 0;

      if(isDefined(level._id_EC89[var_28]) && isDefined(level._id_EC89[var_28][var_1]))
        var_29 = level._id_EC89[var_28][var_1];
      else
        var_29 = 0.2;

      var_7 _id_A888();
      var_7._id_12FF = var_1;

      if(isPlayer(var_7)) {
        var_30 = level._id_EC85[var_28]["root"];
        var_7 _meth_82A2(var_30, 0, var_29);
        var_31 = level._id_EC85[var_28][var_1];
        var_7 _meth_82E1(var_18, var_31, 1, var_29);
      } else if(var_7.code_classname == "misc_turret") {
        var_31 = level._id_EC85[var_28][var_1];
        var_7 _meth_82E1(var_18, var_31, 1, var_29);
      } else {
        var_32 = undefined;

        if(isai(var_7))
          var_32 = var_7 _id_0A1E::_id_2356("Knobs", "body");
        else if(isDefined(var_7._id_1ED4))
          var_32 = [[var_7._id_1ED4]]();

        if(isDefined(var_7.asm) && !isai(var_7))
          var_7 _id_0A1E::_id_230A();

        var_7 animScripted(var_18, var_10, var_11, level._id_EC85[var_28][var_1], undefined, var_32, var_29);
      }

      var_33 = getanimlength(level._id_EC85[var_28][var_1]);

      if(var_33 < var_13) {
        var_13 = var_33;
        var_12 = var_34;
      }

      thread _id_10CBF(var_7, var_18, var_1, var_28, level._id_EC85[var_28][var_1]);
      thread _id_1FCA(var_7, var_18, var_1);
    }

    if(var_20 || var_22) {
      if(var_20) {
        if(var_22)
          var_7 thread scripts\anim\face::sayspecificdialogue(var_25);

        thread _id_1EBD(var_7, var_1, level._id_EC88[var_28][var_1]);
        var_15 = var_34;
      } else if(isai(var_7) || isDefined(var_7._id_6B14) && var_7._id_6B14) {
        if(var_23)
          var_7 scripts\anim\face::sayspecificdialogue(var_25);
        else {
          var_7 thread _id_1EBF("single dialogue");
          var_7 scripts\anim\face::sayspecificdialogue(var_25, "single dialogue");
        }
      } else
        var_7 thread scripts\sp\utility::play_sound_on_entity(var_25, "single dialogue");

      var_14 = var_34;
    }

    if(var_21)
      var_7 thread _id_CC70(var_7, var_17);
  }

  if(isDefined(var_12)) {
    var_35 = spawnStruct();
    var_35 thread _id_1EB0(var_0[var_12], var_1);
    var_35 thread _id_1E9B(var_0[var_12], var_1, var_13, var_3);
    var_35 waittill(var_1);
  } else if(isDefined(var_15)) {
    var_35 = spawnStruct();
    var_35 thread _id_1EB0(var_0[var_15], var_1);
    var_35 thread _id_1EBE(var_0[var_15], var_1, var_16);
    var_35 waittill(var_1);
  } else if(isDefined(var_14)) {
    var_35 = spawnStruct();
    var_35 thread _id_1EB0(var_0[var_14], var_1);
    var_35 thread _id_1EB1(var_0[var_14], var_1);
    var_35 waittill(var_1);
  }

  foreach(var_7 in var_0) {
    if(!isDefined(var_7)) {
      continue;
    }
    if(isPlayer(var_7)) {
      var_28 = undefined;

      if(isDefined(var_4))
        var_28 = var_4;
      else
        var_28 = var_7._id_1FBB;

      if(isDefined(level._id_EC85[var_28][var_1])) {
        var_30 = level._id_EC85[var_28]["root"];
        var_7 _meth_82A2(var_30, 1, 0.2);
        var_31 = level._id_EC85[var_28][var_1];
        var_7 clearanim(var_31, 0.2);
      }
    }

    var_7._id_117C--;
    var_7._id_1300 = gettime();
  }

  self notify(var_1);
}

_id_10CBF(var_0, var_1, var_2, var_3, var_4) {
  var_0 notify("stop_sequencing_notetracks");
  thread scripts\sp\anim_notetrack::_id_C0E1(var_0, var_1, self, var_2, var_3, var_4);
}

_id_1EB0(var_0, var_1) {
  self endon(var_1);
  var_0 waittill("death");

  if(isDefined(var_0._id_1EDD) && var_0._id_1EDD) {
    return;
  }
  self notify(var_1);
}

_id_1EBE(var_0, var_1, var_2) {
  self endon(var_1);
  var_3 = getanimlength(var_2);
  wait(var_3);
  self notify(var_1);
}

_id_1EB1(var_0, var_1) {
  self endon(var_1);
  var_0 waittill("single dialogue");
  self notify(var_1);
}

_id_1E9B(var_0, var_1, var_2, var_3) {
  self endon(var_1);
  var_0 endon("death");
  var_2 = var_2 - var_3;

  if(var_3 > 0 && var_2 > 0) {
    var_0 scripts\sp\utility::_id_137A3("single anim", "end", var_2);
    var_0 _meth_83A1();
  } else
    var_0 waittillmatch("single anim", "end");

  self notify(var_1);
}

_id_1FCA(var_0, var_1, var_2) {
  if(isDefined(var_0._id_5959) && var_0._id_5959) {
    return;
  }
  var_0 endon("stop_sequencing_notetracks");
  var_0 endon("death");
  var_0 scripts\anim\shared::donotetracks(var_1);
}

_id_1F60(var_0, var_1) {
  var_2 = level._id_EC85[var_0][var_1].size;
  var_3 = randomint(var_2);

  if(var_2 > 1) {
    var_4 = 0;
    var_5 = 0;

    for(var_6 = 0; var_6 < var_2; var_6++) {
      if(isDefined(level._id_EC85[var_0][var_1 + "weight"])) {
        if(isDefined(level._id_EC85[var_0][var_1 + "weight"][var_6])) {
          var_4++;
          var_5 = var_5 + level._id_EC85[var_0][var_1 + "weight"][var_6];
        }
      }
    }

    if(var_4 == var_2) {
      var_7 = randomfloat(var_5);
      var_5 = 0;

      for(var_6 = 0; var_6 < var_2; var_6++) {
        var_5 = var_5 + level._id_EC85[var_0][var_1 + "weight"][var_6];

        if(var_7 < var_5) {
          var_3 = var_6;
          break;
        }
      }
    }
  }

  return var_3;
}

#using_animtree("generic_human");

_id_CC70(var_0, var_1) {
  var_0 _meth_82AC(%addtive_head_anims, 1.0, 0.2);
  var_0 _meth_82AC(var_1, 1.0, 0.2);
  wait(getanimlength(var_1));
  var_0 clearanim(%addtive_head_anims, 0.2);
  var_0 clearanim(var_1, 0.2);
}

_id_1F0E(var_0, var_1, var_2, var_3, var_4) {
  thread _id_1F0A(var_0, var_1, var_4);
  var_5 = spawnStruct();
  var_5._id_DD1F = 0;

  foreach(var_7 in var_0) {
    var_5._id_DD1F++;
    thread _id_92E4(var_7, var_2, var_3, var_4, var_5);
  }

  for(;;) {
    var_5 waittill("reached_position");

    if(var_5._id_DD1F <= 0)
      return;
  }
}

_id_135DC() {
  self endon("death");
  self waittill("anim_reach_complete");
}

_id_92E4(var_0, var_1, var_2, var_3, var_4) {
  var_0 _id_135DC();
  var_4._id_DD1F--;
  var_4 notify("reached_position");

  if(isalive(var_0))
    _id_1EEA(var_0, var_1, var_2, var_3);
}

_id_781C(var_0) {
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

_id_1F1A(var_0, var_1, var_2, var_3) {
  thread modify_moveplaybackrate_together(var_0);
  _id_1F1B(var_0, var_1, var_2, var_3, ::_id_DD14, ::_id_DD15);
}

modify_moveplaybackrate_together(var_0) {
  var_1 = 0.3;
  waittillframeend;

  for(;;) {
    var_0 = scripts\sp\utility::_id_DFEB(var_0);
    var_2 = [];
    var_3 = 0;

    foreach(var_8, var_5 in var_0) {
      var_6 = var_5.goalpos;

      if(isDefined(var_5._id_DD0B))
        var_6 = var_5._id_DD0B;

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
      var_10 = var_2[var_5.unique_id] - var_3;
      var_11 = var_10 * 0.003;

      if(var_11 > var_1)
        var_11 = var_1;
      else if(var_11 < var_1 * -1)
        var_11 = var_1 * -1;

      var_5 scripts\asm\asm::_id_237B(1 + var_11);
    }

    wait 0.05;
  }

  foreach(var_5 in var_0) {
    if(isalive(var_5))
      var_5 scripts\asm\asm::_id_237B(1);
  }
}

_id_1F13(var_0, var_1) {
  if(isarray(var_0)) {
    foreach(var_3 in var_0)
    thread _id_1F13(var_3, var_1);

    return;
  }

  var_3 = var_0;
  var_3 endon("new_anim_reach");
  wait(var_1);
  var_3 notify("goal");
}

_id_1F0A(var_0, var_1, var_2, var_3) {
  if(scripts\sp\interaction::_id_9C26(self)) {
    foreach(var_5 in var_0) {
      if(isDefined(self._id_EE92)) {
        var_5.asm._id_4C86.interaction = self._id_EE92;
        continue;
      }

      var_5.asm._id_4C86.interaction = self.script_noteworthy;
    }

    _id_1F1B(var_0, var_1, var_2, var_3, ::_id_DD0F, ::_id_DD10);
  } else
    _id_1F1B(var_0, var_1, var_2, var_3, ::_id_DD14, ::_id_DD15);
}

_id_1F1B(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = _id_781C(var_2);
  var_8 = var_7["origin"];
  var_9 = var_7["angles"];
  var_10 = spawnStruct();
  var_11 = 0;
  var_12 = 0;

  foreach(var_14 in var_0) {
    if(isDefined(var_3))
      var_15 = var_3;
    else
      var_15 = var_14._id_1FBB;

    if(isDefined(level._id_EC85[var_15][var_1])) {
      if(isarray(level._id_EC85[var_15][var_1])) {
        var_16 = getstartorigin(var_8, var_9, level._id_EC85[var_15][var_1][0]);
        var_17 = getstartangles(var_8, var_9, level._id_EC85[var_15][var_1][0]);
      } else {
        var_16 = getstartorigin(var_8, var_9, level._id_EC85[var_15][var_1]);
        var_17 = getstartangles(var_8, var_9, level._id_EC85[var_15][var_1]);
      }
    } else {
      var_16 = var_8;
      var_17 = var_9;
    }

    if(isDefined(var_6)) {
      var_14.scriptedarrivalent = spawn("script_origin", var_16);
      var_14.scriptedarrivalent.angles = var_17;
      var_14.scriptedarrivalent.type = var_6;
      var_14.scriptedarrivalent._id_22EF = "stand";
      var_18 = var_14 getmovingplatformparent();

      if(isDefined(var_18))
        var_14.scriptedarrivalent linkTo(var_18);
    }

    var_12++;
    var_14 thread _id_2A51(var_10, var_16, var_17, var_4, var_5);
  }

  while(var_12) {
    var_10 waittill("reach_notify");
    var_12--;
  }

  foreach(var_14 in var_0) {
    if(!isalive(var_14)) {
      continue;
    }
    var_14.goalradius = var_14._id_C3EE;

    if(isDefined(var_14.scriptedarrivalent))
      var_14.scriptedarrivalent delete();

    var_14.stopanimdistsq = 0;
  }
}

_id_1F12(var_0) {
  if(!isalive(var_0)) {
    return;
  }
  if(isDefined(var_0._id_C3EE))
    var_0.goalradius = var_0._id_C3EE;

  if(isDefined(var_0.scriptedarrivalent))
    var_0.scriptedarrivalent delete();

  var_0.stopanimdistsq = 0;
}

_id_1F57(var_0, var_1, var_2) {
  var_3 = _id_781C(var_2);
  var_4 = var_3["origin"];
  var_5 = var_3["angles"];

  foreach(var_7 in var_0) {
    var_8 = getstartorigin(var_4, var_5, level._id_EC85[var_7._id_1FBB][var_1]);
    var_9 = getstartangles(var_4, var_5, level._id_EC85[var_7._id_1FBB][var_1]);

    if(isai(var_7)) {
      var_7 _meth_83B9(var_8);
      continue;
    }

    var_7.origin = var_8;
    var_7.angles = var_9;
  }
}

_id_1EEE(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = _id_781C(var_2);
  var_7 = var_6["origin"];
  var_8 = var_6["angles"];

  foreach(var_10 in var_0) {
    var_11 = getstartorigin(var_7, var_8, level._id_EC85[var_10._id_1FBB][var_1]);
    var_12 = getstartangles(var_7, var_8, level._id_EC85[var_10._id_1FBB][var_1]);

    if(isai(var_10)) {
      continue;
    }
    var_10 moveTo(var_11, var_3, var_4, var_5);
    var_10 rotateTo(var_12, var_3, var_4, var_5);
  }
}

_id_1ED2(var_0, var_1, var_2) {
  var_3 = _id_781C(var_2);
  var_4 = var_3["origin"];
  var_5 = var_3["angles"];
  var_6 = getstartorigin(var_4, var_5, level._id_EC85["generic"][var_1]);
  var_7 = getstartangles(var_4, var_5, level._id_EC85["generic"][var_1]);

  if(isai(var_0))
    var_0 _meth_83B9(var_6);
  else {
    var_0.origin = var_6;
    var_0.angles = var_7;
  }
}

_id_1F41(var_0, var_1, var_2) {
  return _id_1F42(var_0, "generic", var_1, var_2);
}

_id_1F42(var_0, var_1, var_2, var_3) {
  var_4 = _id_781C(var_3);
  var_5 = var_4["origin"];
  var_6 = var_4["angles"];
  var_7 = getstartorigin(var_5, var_6, level._id_EC85[var_1][var_2]);
  var_8 = getstartorigin(var_5, var_6, level._id_EC85[var_1][var_2]);
  var_9 = spawn("script_model", var_7);
  var_9 setModel(var_0);
  var_9.angles = var_8;
  return var_9;
}

_id_1F44(var_0, var_1) {
  self attach(var_0, var_1);
}

_id_1EE5(var_0, var_1) {
  var_2 = self gettagorigin(var_1);
  var_3 = spawn("script_model", var_2);
  var_3 setModel(var_0);
  var_3 linkTo(self, var_1, (0, 0, 0), (0, 0, 0));
  return var_3;
}

_id_1F45(var_0, var_1, var_2) {
  var_3 = _id_781C(var_2);
  var_4 = var_3["origin"];
  var_5 = var_3["angles"];
  var_6 = spawnStruct();

  foreach(var_8 in var_0) {
    var_9 = getstartorigin(var_4, var_5, level._id_EC85[var_8._id_1FBB][var_1]);
    var_8.origin = var_9;
  }
}

_id_DD08(var_0) {
  scripts\engine\utility::waittill_either("death", "goal");

  while(isalive(self) && isDefined(self.asm) && isDefined(self.asm._id_22F8))
    wait 0.05;

  var_0 notify("reach_notify");
}

_id_2A51(var_0, var_1, var_2, var_3, var_4) {
  self endon("death");
  self endon("new_anim_reach");
  thread _id_DD08(var_0);
  var_1 = [[var_3]](var_1, var_2);
  scripts\sp\utility::_id_F3DC(var_1);
  self._id_DD0B = var_1;
  self.goalradius = 0;
  self.stopanimdistsq = squared(64);
  self waittill("goal");
  self notify("anim_reach_complete");
  [[var_4]]();
  self notify("new_anim_reach");
}

_id_DD0F(var_0, var_1) {
  self._id_C3EE = self.goalradius;
  self._id_C3FD = self.pathenemyfightdist;
  self._id_C3FE = self.pathenemylookahead;
  self.pathenemyfightdist = 128;
  self.pathenemylookahead = 128;
  scripts\sp\utility::_id_54F7();
  _id_1EA8(1);
  self.nododgemove = 1;
  self._id_6E04 = self.fixednode;
  self.fixednode = 0;
  self._id_C3B9 = self.disablearrivals;
  self.disablearrivals = 0;
  self._id_DD0B = undefined;
  var_2 = scripts\sp\interaction::_id_7A45(self.asm._id_4C86.interaction);

  if(!isDefined(var_2))
    var_2 = scripts\sp\interaction::_id_7CA7(self.asm._id_4C86.interaction);

  self.asm._id_4C86._id_22F1 = scripts\sp\interaction::_id_7837(var_2);
  self.asm._id_4C86._id_22E3 = var_1;
  self.asm._id_4C86._id_92FA = scripts\sp\interaction::_id_7A30(var_2);
  self.asm._id_4C86._id_22F6 = 1;

  if(isDefined(var_2._id_22E1))
    self.asm._id_4C86._id_4C38 = var_2._id_22E1;

  return var_0;
}

_id_DD14(var_0, var_1) {
  self._id_C3EE = self.goalradius;
  self._id_C3FD = self.pathenemyfightdist;
  self._id_C3FE = self.pathenemylookahead;
  self.pathenemyfightdist = 128;
  self.pathenemylookahead = 128;
  scripts\sp\utility::_id_54F7();
  _id_1EA8(1);
  self.nododgemove = 1;
  self._id_6E04 = self.fixednode;
  self.fixednode = 0;

  if(!isDefined(self.scriptedarrivalent)) {
    self._id_C3B9 = self.disablearrivals;
    self.disablearrivals = 1;
  } else {
    self.scriptedarrivalent.angles = var_1;
    self.scriptedarrivalent.origin = var_0;
  }

  self._id_DD0B = undefined;
  return var_0;
}

_id_DD10() {
  _id_1EA8(0);
  self.nododgemove = 0;
  self.fixednode = self._id_6E04;
  self._id_6E04 = undefined;
  self.pathenemyfightdist = self._id_C3FD;
  self.pathenemylookahead = self._id_C3FE;
  self.disablearrivals = self._id_C3B9;
  var_0 = scripts\sp\interaction::_id_7A45(self.asm._id_4C86.interaction);

  if(!isDefined(var_0))
    var_0 = scripts\sp\interaction::_id_7CA7(self.asm._id_4C86.interaction);

  self.asm._id_4C86._id_697F = scripts\sp\interaction::_id_79A5(var_0);
  self.asm._id_4C86.interaction = undefined;
  self.asm._id_4C86._id_22F1 = undefined;
  self.asm._id_4C86._id_22E3 = undefined;
}

_id_DD15() {
  _id_1EA8(0);
  self.nododgemove = 0;
  self.fixednode = self._id_6E04;
  self._id_6E04 = undefined;
  self.pathenemyfightdist = self._id_C3FD;
  self.pathenemylookahead = self._id_C3FE;
  self.disablearrivals = self._id_C3B9;
}

_id_1EA8(var_0) {
  if(isDefined(self._id_5954)) {
    return;
  }
  self _meth_8250(var_0);
  return;
}

_id_DD11(var_0, var_1) {
  var_0 = _id_DD14(var_0, var_1);
  self.disablearrivals = 0;
  return var_0;
}

_id_DD12(var_0, var_1) {
  var_2 = self _meth_811F(var_0);
  var_0 = var_2;
  var_0 = _id_DD14(var_0, var_1);
  self.disablearrivals = 1;
  return var_0;
}

_id_DD13(var_0, var_1) {
  var_2 = self _meth_811F(var_0);
  var_0 = var_2;
  var_0 = _id_DD14(var_0, var_1);
  self.disablearrivals = 0;
  return var_0;
}

_id_F64A() {
  self _meth_83D0(level._id_EC87[self._id_1FBB]);
}

_id_1F35(var_0, var_1, var_2, var_3, var_4) {
  self endon("death");
  var_5[0] = var_0;

  if(!isDefined(var_3))
    var_3 = 0;

  _id_1F2C(var_5, var_1, var_2, var_3, var_4);
}

_id_1F37(var_0, var_1, var_2) {
  self endon("death");
  var_3[0] = var_0;
  _id_1F2C(var_3, var_1, var_2, 0.25);
}

_id_1F34(var_0, var_1, var_2, var_3) {
  self endon("death");
  var_4[0] = var_0;
  _id_1F2C(var_4, var_1, var_2, 0.25);
}

_id_1F0F(var_0, var_1, var_2, var_3, var_4) {
  self endon("death");
  var_5[0] = var_0;
  _id_1F0E(var_5, var_1, var_2, var_3, var_4);
}

_id_1F17(var_0, var_1, var_2) {
  self endon("death");
  var_3[0] = var_0;
  _id_1F0A(var_3, var_1, var_2);
}

_id_1F0D(var_0, var_1, var_2, var_3) {
  self endon("death");
  var_4[0] = var_0;
  _id_1F0B(var_4, var_1, var_2, var_3);
}

_id_1F0C(var_0, var_1, var_2, var_3, var_4) {
  self endon("death");
  var_5[0] = var_0;
  var_6 = _id_781C(var_2);
  var_7 = var_6["origin"];
  var_8 = var_6["angles"];
  var_9 = var_0._id_1FBB;

  if(isDefined(level._id_EC85[var_9][var_1])) {
    if(isarray(level._id_EC85[var_9][var_1]))
      var_10 = level._id_EC85[var_9][var_1][0];
    else
      var_10 = level._id_EC85[var_9][var_1];

    var_7 = getstartorigin(var_7, var_8, var_10);
    var_8 = getstartorigin(var_7, var_8, var_10);
  }

  var_11 = spawn("script_origin", var_7);
  var_11.angles = var_8;

  if(isDefined(var_3))
    var_11.type = var_3;
  else
    var_11.type = self.type;

  if(isDefined(var_4))
    var_11._id_22EF = var_4;
  else
    var_11._id_22EF = self gethighestnodestance();

  var_0.scriptedarrivalent = var_11;
  _id_1F0B(var_5, var_1, var_2);
  var_0.scriptedarrivalent = undefined;
  var_11 delete();

  while(var_0.a.movement != "stop")
    wait 0.05;
}

_id_1F0B(var_0, var_1, var_2, var_3) {
  self endon("death");

  if(scripts\sp\interaction::_id_9C26(self)) {
    foreach(var_5 in var_0) {
      if(isDefined(self.script_noteworthy)) {
        var_5.asm._id_4C86.interaction = self.script_noteworthy;
        continue;
      }

      var_5.asm._id_4C86.interaction = self._id_EE92;
    }

    _id_1F1B(var_0, var_1, var_2, undefined, ::_id_DD0F, ::_id_DD10, var_3);
  } else {
    if(!isDefined(var_3))
      var_3 = "Exposed";

    _id_1F1B(var_0, var_1, var_2, undefined, ::_id_DD11, ::_id_DD15, var_3);
  }
}

_id_1EEA(var_0, var_1, var_2, var_3, var_4, var_5) {
  self endon("death");
  var_0 endon("death");
  var_6[0] = var_0;
  _id_1EE7(var_6, var_1, var_2, var_3, var_4, var_5);
}

_id_1F58(var_0, var_1, var_2) {
  self endon("death");
  var_3[0] = var_0;
  _id_1F57(var_3, var_1, var_2);
}

_id_1696(var_0, var_1) {
  if(!isDefined(level._id_4483))
    level._id_4483[var_0][0] = var_1;
  else if(!isDefined(level._id_4483[var_0]))
    level._id_4483[var_0][0] = var_1;
  else {
    for(var_2 = 0; var_2 < level._id_4483[var_0].size; var_2++) {
      if(level._id_4483[var_0][var_2] == var_1)
        return;
    }

    level._id_4483[var_0][level._id_4483[var_0].size] = var_1;
  }
}

_id_1F32(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_3))
    var_3 = 0;

  if(isDefined(var_0._id_A8F8))
    scripts\sp\utility::_id_135AF(var_0._id_A8F8, 0.5);

  scripts\sp\utility::_id_74D7(::_id_1F35, var_0, var_1, var_2, var_3);

  if(isalive(var_0))
    var_0._id_A8F8 = gettime();
}

_id_1ECD(var_0, var_1, var_2, var_3, var_4) {
  var_0 endon("death");

  if(!isDefined(var_3))
    var_3 = 0;

  if(isDefined(var_0._id_A8F8))
    scripts\sp\utility::_id_135AF(var_0._id_A8F8, 0.5);

  if(isDefined(var_4))
    scripts\sp\utility::_id_74DD(var_4, ::_id_1F35, var_0, var_1, var_2, var_3, "generic");
  else
    scripts\sp\utility::_id_74D7(::_id_1F35, var_0, var_1, var_2, var_3, "generic");

  if(isalive(var_0))
    var_0._id_A8F8 = gettime();
}

_id_1EB3(var_0) {
  foreach(var_2 in var_0)
  var_2 _meth_8250(0);
}

_id_1F08(var_0) {
  foreach(var_2 in var_0)
  var_2 _meth_8250(1);
}

_id_E140(var_0, var_1, var_2, var_3, var_4) {
  var_1 = tolower(var_1);
  var_5 = level._id_EC8D[var_0][var_2][var_1];
  var_2 = _id_79E4(var_2);
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
  if(var_5.size == 1)
    var_5 = [];
  else
    var_5 = scripts\sp\utility::array_remove_index(var_5, var_6);

  level._id_EC8D[var_0][var_2][var_1] = var_5;
}

_id_17F9(var_0, var_1, var_2, var_3) {
  var_1 = tolower(var_1);
  var_2 = _id_79E4(var_2);
  var_4 = _id_1720(var_0, var_1, var_2);
  level._id_EC8D[var_0][var_2][var_1][var_4] = [];
  level._id_EC8D[var_0][var_2][var_1][var_4]["dialog"] = var_3;
}

_id_1720(var_0, var_1, var_2) {
  var_1 = tolower(var_1);
  _id_1721(var_0, var_1, var_2);
  return level._id_EC8D[var_0][var_2][var_1].size;
}

_id_1721(var_0, var_1, var_2) {
  var_1 = tolower(var_1);

  if(!isDefined(level._id_EC8D))
    level._id_EC8D = [];

  if(!isDefined(level._id_EC8D[var_0]))
    level._id_EC8D[var_0] = [];

  if(!isDefined(level._id_EC8D[var_0][var_2]))
    level._id_EC8D[var_0][var_2] = [];

  if(!isDefined(level._id_EC8D[var_0][var_2][var_1]))
    level._id_EC8D[var_0][var_2][var_1] = [];
}

_id_17FF(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_1 = tolower(var_1);
  var_2 = _id_79E4(var_2);
  var_6 = _id_1720(var_0, var_1, var_2);
  level._id_EC8D[var_0][var_2][var_1][var_6] = [];
  level._id_EC8D[var_0][var_2][var_1][var_6]["sound"] = var_3;

  if(isDefined(var_4))
    level._id_EC8D[var_0][var_2][var_1][var_6]["sound_stays_death"] = 1;

  if(isDefined(var_5))
    level._id_EC8D[var_0][var_2][var_1][var_6]["sound_on_tag"] = var_5;
}

_id_C0BB(var_0, var_1, var_2, var_3) {
  var_4 = _id_7926();
  _id_17FF(var_4._id_1FBB, var_0, var_4._id_1F24, var_1, var_2, var_3);
}

_id_17FE(var_0, var_1, var_2, var_3) {
  var_1 = tolower(var_1);
  var_2 = _id_79E4(var_2);
  var_4 = _id_1720(var_0, var_1, var_2);
  level._id_EC8D[var_0][var_2][var_1][var_4] = [];
  level._id_EC8D[var_0][var_2][var_1][var_4]["playersound"] = var_3;
}

_id_79E4(var_0) {
  if(!isDefined(var_0))
    return "any";

  return var_0;
}

_id_1806(var_0, var_1, var_2) {
  if(!isDefined(level._id_EC86[var_0]))
    level._id_EC86[var_0] = [];

  level._id_EC86[var_0][var_1] = var_2;
}

_id_17FD(var_0, var_1, var_2, var_3) {
  var_1 = tolower(var_1);
  var_2 = _id_79E4(var_2);
  var_4 = _id_1720(var_0, var_1, var_2);
  level._id_EC8D[var_0][var_2][var_1][var_4] = [];
  level._id_EC8D[var_0][var_2][var_1][var_4]["playerdialogue"] = var_3;
}

_id_17F4(var_0, var_1, var_2, var_3) {
  var_2 = tolower(var_2);
  var_1 = _id_79E4(var_1);
  var_4 = _id_1720(var_0, var_2, var_1);
  var_5 = [];
  var_5["sound"] = var_3;
  var_5["created_by_animSound"] = 1;
  level._id_EC8D[var_0][var_1][var_2][var_4] = var_5;
}

_id_17F5(var_0, var_1, var_2, var_3, var_4) {
  var_1 = tolower(var_1);
  var_4 = _id_79E4(var_4);
  var_5 = _id_1720(var_0, var_1, var_4);
  var_6 = [];
  var_6["attach model"] = var_2;
  var_6["selftag"] = var_3;
  level._id_EC8D[var_0][var_4][var_1][var_5] = var_6;
}

_id_17F7(var_0, var_1, var_2, var_3, var_4) {
  var_1 = tolower(var_1);
  var_4 = _id_79E4(var_4);
  var_5 = _id_1720(var_0, var_1, var_4);
  var_6 = [];
  var_6["detach model"] = var_2;
  var_6["selftag"] = var_3;
  level._id_EC8D[var_0][var_4][var_1][var_5] = var_6;
}

_id_17F8(var_0, var_1, var_2, var_3) {
  var_1 = tolower(var_1);
  var_2 = _id_79E4(var_2);
  var_4 = _id_1720(var_0, var_1, var_2);
  var_5 = [];
  var_5["detach gun"] = 1;
  var_5["tag"] = "tag_weapon_right";

  if(isDefined(var_3))
    var_5["suspend"] = var_3;

  level._id_EC8D[var_0][var_2][var_1][var_4] = var_5;
}

_id_17F6(var_0, var_1, var_2, var_3) {
  var_1 = tolower(var_1);
  var_3 = _id_79E4(var_3);
  var_4 = _id_1720(var_0, var_1, var_3);
  var_5 = [];
  var_5["function"] = var_2;
  level._id_EC8D[var_0][var_3][var_1][var_4] = var_5;
}

_id_1800(var_0, var_1, var_2, var_3, var_4, var_5) {
  scripts\engine\utility::getfx(var_3);
  var_1 = tolower(var_1);
  var_2 = _id_79E4(var_2);
  var_6 = _id_1720(var_0, var_1, var_2);
  var_7 = [];
  var_7["effect"] = var_3;
  var_7["selftag"] = var_4;

  if(isDefined(var_5))
    var_7["moreThanThreeHack"] = var_5;

  level._id_EC8D[var_0][var_2][var_1][var_6] = var_7;
}

_id_1801(var_0, var_1, var_2, var_3, var_4) {
  scripts\engine\utility::getfx(var_3);
  var_1 = tolower(var_1);
  var_2 = _id_79E4(var_2);
  var_5 = _id_1720(var_0, var_1, var_2);
  var_6 = [];
  var_6["stop_effect"] = var_3;
  var_6["selftag"] = var_4;
  level._id_EC8D[var_0][var_2][var_1][var_5] = var_6;
}

_id_C0BD(var_0, var_1, var_2) {
  var_3 = _id_7926();
  scripts\engine\utility::add_fx(var_1, var_1);
  _id_1802(var_3._id_1FBB, var_0, var_3._id_1FCF, var_1, var_2);
}

_id_C0BC(var_0, var_1, var_2) {
  var_3 = _id_7926();
  scripts\engine\utility::add_fx(var_1, var_1);
  _id_1801(var_3._id_1FBB, var_0, var_3._id_1FCF, var_1, var_2);
}

_id_1802(var_0, var_1, var_2, var_3, var_4) {
  scripts\engine\utility::getfx(var_3);
  var_1 = tolower(var_1);
  var_2 = _id_79E4(var_2);
  var_5 = _id_1720(var_0, var_1, var_2);
  var_6 = [];
  var_6["swap_part_to_efx"] = var_3;
  var_6["selftag"] = var_4;
  level._id_EC8D[var_0][var_2][var_1][var_5] = var_6;
}

_id_C0BE(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = _id_7926();

  if(var_0 != "start" && !animhasnotetrack(var_6 scripts\sp\utility::_id_7DC1(var_6._id_1F24), var_0)) {
    return;
  }
  scripts\engine\utility::add_fx(var_3, var_3);

  if(isDefined(var_4))
    scripts\engine\utility::add_fx(var_4, var_4);

  _id_1803(var_6._id_1FBB, var_0, var_1, var_6._id_1F24, var_2, var_3, var_4, var_5);
}

_id_C0BA(var_0, var_1, var_2) {
  var_3 = _id_7926();

  if(var_0 != "start" && !animhasnotetrack(var_3 scripts\sp\utility::_id_7DC1(var_3._id_1F24), var_0)) {
    return;
  }
  scripts\engine\utility::add_fx(var_2, var_2);
  _id_1800(var_3._id_1FBB, var_0, var_3._id_1F24, var_2, var_1, 1);
}

_id_7926() {
  var_0 = level._id_4B3E;
  return var_0;
}

_id_1803(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  scripts\engine\utility::getfx(var_5);
  var_1 = tolower(var_1);
  var_3 = _id_79E4(var_3);
  var_8 = _id_1720(var_0, var_1, var_3);
  var_9 = [];
  var_9["trace_part_for_efx"] = var_5;
  var_9["trace_part_for_efx_water"] = var_6;
  var_9["trace_part_for_efx_cancel"] = var_2;
  var_9["trace_part_for_efx_delete_depth"] = var_7;
  var_9["selftag"] = var_4;
  level._id_EC8D[var_0][var_3][var_1][var_8] = var_9;

  if(isDefined(var_2)) {
    var_9 = [];
    var_9["trace_part_for_efx_canceling"] = var_2;
    var_9["selftag"] = var_4;
    var_8 = _id_1720(var_0, var_2, var_3);
    level._id_EC8D[var_0][var_3][var_2][var_8] = var_9;
  }
}

_id_17FA(var_0, var_1, var_2, var_3) {
  var_1 = tolower(var_1);
  var_3 = _id_79E4(var_3);
  var_4 = _id_1720(var_0, var_1, var_3);
  var_5 = [];
  var_5["flag"] = var_2;
  level._id_EC8D[var_0][var_3][var_1][var_4] = var_5;

  if(!isDefined(level.flag) || !isDefined(level.flag[var_2]))
    scripts\engine\utility::flag_init(var_2);
}

_id_17FB(var_0, var_1, var_2, var_3) {
  var_1 = tolower(var_1);
  var_3 = _id_79E4(var_3);
  var_4 = _id_1720(var_0, var_1, var_3);
  var_5 = [];
  var_5["flag_clear"] = var_2;
  level._id_EC8D[var_0][var_3][var_1][var_4] = var_5;

  if(!isDefined(level.flag) || !isDefined(level.flag[var_2]))
    scripts\engine\utility::flag_init(var_2);
}

_id_17FC(var_0, var_1, var_2, var_3) {
  var_1 = tolower(var_1);
  var_3 = _id_79E4(var_3);
  var_4 = _id_1720(var_0, var_1, var_3);
  var_5 = [];
  var_5["notify"] = var_2;
  level._id_EC8D[var_0][var_3][var_1][var_4] = var_5;
}

_id_55C7(var_0) {
  if(!isDefined(self._id_8C7E))
    self._id_8C7E = _id_0A1E::_id_2356("Knobs", "head");

  if(!isDefined(var_0) || var_0) {
    scripts\sp\utility::_id_F6FE("vignette");
    self clearanim(self._id_8C7E, 0.2);
    self.facialidx = undefined;
  } else
    scripts\sp\utility::_id_41AD("vignette");
}

_id_1EBD(var_0, var_1, var_2) {
  var_0 endon("death");
  self endon(var_1);
  var_3 = 0.05;
  var_0 notify("newLookTarget");
  _id_55C7();
  waittillframeend;

  if(!isDefined(self._id_EF82))
    self._id_EF82 = _id_0A1E::_id_2356("Knobs", "scripted_talking");

  var_4 = "scripted_face_" + var_1;
  var_0 _meth_82A2(self._id_EF82, 5, 0.2);
  var_0 _meth_82E7(var_4, var_2, 1, 0, 1);
  thread scripts\sp\anim_notetrack::_id_6A85(var_0, var_4, var_1);
  thread _id_41AC(var_0, var_4, var_1);
}

_id_1EBF(var_0, var_1) {
  self endon("death");

  if(isai(self) && !isalive(self)) {
    return;
  }
  if(!isai(self) && (!isDefined(self._id_6B14) || !self._id_6B14)) {
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

  if(!isDefined(var_1) && isDefined(self._id_299D))
    var_1 = self._id_299D;

  var_3 = "";

  if(isDefined(self.asm))
    var_3 = self.asm.archetype;

  if(isDefined(self._id_1FA8))
    var_3 = self._id_1FA8;

  var_4 = self._id_504D;
  var_5 = self._id_EF82;

  if(var_3 != "") {
    var_5 = _id_0A1E::_id_2356("Knobs", "head");
    var_4 = _func_2EF(var_3, "facial_animation", "facial_talk", 0);
  }

  scripts\sp\utility::_id_F6FE("filler");
  self _meth_82AA(var_4, 1, 0, 1);
  self _meth_82A2(var_5, 5, 0.267);
  _id_F5BE(var_0, var_4, var_5);
  var_2 = 0.3;
  self clearanim(var_5, 0.2);
  scripts\sp\utility::_id_41AD("filler");
}

_id_F5BE(var_0, var_1, var_2) {
  self waittill(var_0);
}

_id_11497(var_0) {
  self endon("death");
  var_1 = self._id_504D;
  self _meth_82AA(var_1, 1, 0, 1);
  self _meth_82A2(self._id_EF82, 5, 0.4);
  _id_55C7();
  wait(var_0);
  var_2 = 0.3;
  self clearanim(self._id_EF82, 0.2);
  _id_55C7(0);
}

getyawangles(var_0, var_1) {
  var_2 = var_0[1] - var_1[1];
  var_2 = angleclamp180(var_2);
  return var_2;
}

_id_B022(var_0, var_1) {
  self notify("lookline");
  self endon("lookline");
  self endon(var_1);
  self endon("death");

  for(;;)
    wait 0.05;
}

_id_1F14(var_0, var_1, var_2) {
  var_3 = spawnStruct();
  var_3.count = var_0.size;

  foreach(var_5 in var_0)
  thread _id_DD20(var_5, var_1, var_2, var_3);

  while(var_3.count)
    var_3 waittill("reached_goal");

  self notify("stopReachIdle");
}

_id_DD20(var_0, var_1, var_2, var_3) {
  _id_1F17(var_0, var_1);
  var_3.count--;
  var_3 notify("reached_goal");

  if(var_3.count > 0)
    _id_1EEA(var_0, var_2, "stopReachIdle");
}

_id_41AC(var_0, var_1, var_2) {
  var_0 endon("death");
  var_0 waittillmatch(var_1, "end");
  var_0 notify("scripted_face_done");
  var_3 = 0.3;
  var_0 clearanim(self._id_EF82, 0.2);
  _id_55C7(0);
}

_id_1F50(var_0, var_1, var_2) {
  var_3 = _id_781C(var_2);
  var_4 = var_3["origin"];
  var_5 = var_3["angles"];
  scripts\engine\utility::array_thread(var_0, ::_id_F5B0, var_1, var_4, var_5);
}

_id_1F51(var_0, var_1, var_2) {
  var_3[0] = var_0;
  _id_1F50(var_3, var_1, var_2);
}

_id_F5B0(var_0, var_1, var_2, var_3, var_4) {
  var_5 = undefined;

  if(isDefined(var_3))
    var_5 = var_3;
  else
    var_5 = self._id_1FBB;

  if(isDefined(var_4) && var_4)
    var_6 = level._id_EC85[var_5][var_0][0];
  else
    var_6 = level._id_EC85[var_5][var_0];

  if(isai(self)) {
    var_7 = getstartorigin(var_1, var_2, var_6);
    var_8 = getstartangles(var_1, var_2, var_6);

    if(isDefined(self._id_1F4E))
      var_7 = scripts\sp\utility::_id_864C(var_7);

    self _meth_80F1(var_7, var_8);
  } else if(self.code_classname == "script_vehicle")
    self vehicle_teleport(getstartorigin(var_1, var_2, var_6), getstartangles(var_1, var_2, var_6));
  else {
    self.origin = getstartorigin(var_1, var_2, var_6);
    self.angles = getstartangles(var_1, var_2, var_6);
  }
}

_id_1E9F(var_0, var_1) {
  var_2 = [];
  var_2["guy"] = self;
  var_2["entity"] = self;
  return var_2;
}

_id_1E9E(var_0, var_1) {
  var_2 = [];
  var_2["guy"] = self;
  var_2["entity"] = var_0;
  var_2["tag"] = var_1;
  return var_2;
}

_id_1F29(var_0, var_1, var_2) {
  var_0 thread _id_1F28(var_1, var_2);
}

_id_1F27(var_0, var_1, var_2) {
  scripts\engine\utility::array_thread(var_0, ::_id_1F28, var_1, var_2);
}

_id_1F28(var_0, var_1, var_2) {
  var_3 = undefined;

  if(isDefined(var_2))
    var_3 = var_2;
  else
    var_3 = self._id_1FBB;

  self _meth_82E1("single anim", scripts\sp\utility::_id_7DC2(var_0, var_3), 1, 0, var_1);
}

_id_1F2A(var_0, var_1, var_2) {
  scripts\engine\utility::array_thread(var_0, ::_id_1F23, var_1, var_2);
}

_id_1F23(var_0, var_1) {
  var_2 = scripts\sp\utility::_id_7DC1(var_0);
  self _meth_82B0(var_2, var_1);
}

_id_A888() {
  if(!isDefined(self._id_A887)) {
    self._id_A887 = gettime();
    return;
  }

  var_0 = gettime();

  if(self._id_A887 == var_0) {
    self endon("death");
    wait 0.05;
  }

  self._id_A887 = var_0;
}

_id_F325(var_0, var_1) {
  var_0.custommovetransition = scripts\anim\cover_arrival::custommovetransitionfunc;
  var_0._id_10DCB = level._id_EC85[var_0._id_1FBB][var_1];
}

_id_489E(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_3))
    var_3 = "generic";
  else
    level._id_EC87[var_3] = var_0;

  var_5 = spawnStruct();
  var_5._id_1FEC = var_0;
  var_5.model = var_4;

  if(isDefined(var_4))
    level._id_EC8C[var_3] = var_4;

  if(isDefined(var_2))
    level._id_EC85[var_3][var_1] = var_2;

  var_5._id_1FBB = var_3;
  var_5._id_1F24 = var_1;
  level._id_4B3E = var_5;
}

_id_2B8C(var_0, var_1, var_2, var_3) {
  var_0._id_1E9D = var_2;
  var_0._id_6317 = var_3;
  var_0._id_77A3 = var_1;
  var_0._id_1FBD = self;
  var_0 _id_0A1E::_id_2307(_id_0C4C::_id_2B8A, _id_0C4C::_id_2B8B);
}

_id_2B87(var_0, var_1, var_2) {
  while(isDefined(var_0._id_1E9D))
    wait 0.05;

  var_0._id_1E9D = var_2;
  var_0._id_77A3 = var_1;
  var_0._id_1FBD = self;
  var_0 _id_0A1E::_id_2307(_id_0C4C::_id_2B86);
}