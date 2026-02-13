/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 1776.gsc
*************************************************/

_id_7F34() {
  _id_7F1A();

  if(!isDefined(level._id_33AC)) {
    level._id_33AC = ::_id_4564;
  }

  _id_811F();
}

_id_AF56() {
  [[level._id_33A9]]();
}

_id_7F1A() {
  scripts\engine\utility::_id_5C11("pause_challenges");
  var_0 = getDvar("#x36d16f02578d0ee10");
  level._id_1101E = "cp/zombies/" + var_0 + "_challenges.csv";

  if(!_func_0221(level._id_1101E)) {
    level._id_1101E = undefined;
  }

  level._id_33A5 = [];

  if(isDefined(level._id_33AA)) {
    [[level._id_33AA]]();
  }

  level._id_415A = -1;
  level._id_415F = -1;
  level._id_415E = -1;
  level._id_415C = -1;
  level._id_4161 = -1;
  level._id_4162 = -1;
  level._id_4160 = -1;
  level._id_4163 = -1;
  level._id_415D = 0;
  level._id_1467 = 1;
  level._id_BB3C = 0;
  level._id_A74F = 0;
  level._id_E9BD = 0;
}

_id_FB43(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(!_id_415B(var_0) || !scripts\cp\utility::_id_3D1D("challenge")) {
    return;
  }
  if(level._id_BB3C) {
    return;
  }
  var_10 = level._id_33A5[level._id_4158];
  var_10 thread[[var_10._id_FC73]](var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
}

_id_5293() {
  if(_id_4159() && scripts\cp\utility::_id_3D1D("challenge")) {
    _id_4374();
  }
}

_id_4374() {
  if(!_id_4159()) {
    return;
  }
  var_0 = level._id_33A5[level._id_4158];
  _id_F9B8();

  if(var_0[[var_0._id_8A70]]()) {
    _id_4B53("challenge_success", 0);
    var_0[[var_0._id_C806]]();
    var_1 = "challenge";

    if(isDefined(level._id_33AD)) {
      var_1 = level._id_33AD;
    }

    _id_072C::_id_FBB4(var_1, "challenge_complete");
    _id_074E::_id_FB79(1);
    _id_0705::_id_FB45(var_0._id_C189, 1);

    if(_id_89EB(var_0)) {
      if(level._id_4162 - level._id_E9BE <= 0.01) {
        _id_0995::_id_9718(var_0._id_C189, level._id_10C9F, level._id_E9BE - level._id_4162);
      } else {
        _id_0995::_id_9718(var_0._id_C189, level._id_10C9F, level._id_4162);
      }

      foreach(var_3 in level.players) {
        var_3 thread _id_076F::_id_F72D("challenge_success_generic", "zmb_comment_vo");
      }

      level._id_A74F++;
    }
  } else {
    _id_4B53("challenge_failed", 0);

    if(_id_89EB(var_0)) {
      if(isDefined(level._id_33AF[var_0._id_C189]) && _id_89EB(var_0)) {
        level._id_33AF[var_0._id_C189]++;
      }

      if(var_0._id_C189 == "no_laststand" || var_0._id_C189 == "no_bleedout" || var_0._id_C189 == "protect_player") {
        _id_0995::_id_9719(var_0._id_C189, level._id_10C9F, 0, level._id_33AF[var_0._id_C189]);
      } else {
        _id_0995::_id_9719(var_0._id_C189, level._id_10C9F, var_0._id_4191 / var_0._id_01FA * 100, level._id_33AF[var_0._id_C189]);
      }

      foreach(var_3 in level.players) {
        if(!scripts\cp\utility::_id_89AE() && level.players.size > 1) {
          _id_076F::_id_F72F("challenge_fail_team");
          continue;
        }

        var_3 thread _id_076F::_id_F72D("challenge_fail_solo", "zmb_comment_vo");
      }
    }

    var_0[[var_0._id_58DA]]();
    level._id_1467 = 0;
    _id_074E::_id_FB79(0);
    _id_0705::_id_FB45(var_0._id_C189, 0);
  }

  level notify("challenge_deactivated");
  var_0[[var_0._id_438E]]();
}

_id_89EB(var_0) {
  switch (var_0._id_C189) {
    case "challenge_success":
    case "challenge_failed":
    case "next_challenge":
      return 0;
    default:
      return 1;
  }
}

_id_0EC7(var_0) {
  var_1 = level._id_33A5[var_0];

  if(!isDefined(level._id_33AF[var_0]) && var_0 != "next_challenge") {
    level._id_33AF[var_0] = 0;
  }

  if(var_1[[var_1._id_3110]]()) {
    var_2 = _id_63BF(var_0);

    if(isDefined(var_2)) {
      level._id_33A5[var_0]._id_01FA = var_2;
      level._id_4160 = var_2;
    } else
      level._id_4160 = -1;

    _id_4B53(var_0, 1, var_2);
    _id_D1A2(var_0);
    level._id_415D = 0;
    var_1[[var_1._id_0EF3]]();
  } else
    var_1[[var_1._id_58D4]]();
}

_id_63BF(var_0) {
  return [[level._id_33AC]](var_0);
}

_id_33A4() {
  level endon("game_ended");
  var_0 = int(gettime() + 5000);

  foreach(var_2 in level.players) {
    var_2 setclientomnvar("ui_intel_title", 1);
  }

  level._id_4163 = 1;
  wait 5;

  foreach(var_2 in level.players) {
    var_2 setclientomnvar("ui_intel_title", -1);
  }

  level._id_4163 = -1;
  wait 0.5;
}

_id_4B53(var_0, var_1, var_2) {
  var_3 = _func_0222(level._id_1101E, 1, var_0, 0);

  foreach(var_5 in level.players) {
    if(var_1) {
      if(isDefined(var_2)) {
        var_5 setclientomnvar("ui_intel_challenge_scalar", var_2);
        var_5 setclientomnvar("ui_intel_progress_max", var_2);
      } else
        var_5 setclientomnvar("ui_intel_challenge_scalar", -1);

      var_5 setclientomnvar("ui_intel_prechallenge", 1);
      var_5 setclientomnvar("ui_intel_active_index", int(var_3));
      level._id_415A = int(var_3);
      level._id_415D = 1;

      if(var_0 == "next_challenge") {
        var_5 playlocalsound("zmb_challenge_config");
      } else {
        var_5 playlocalsound("zmb_challenge_start");
      }

      var_5 setclientomnvar("zm_show_challenge", 4);
      level._id_41AC = 4;
    }
  }

  if(var_1) {
    return;
  }
  if(level._id_41AC != 2 && level._id_41AC != 3 && level._id_41AC != 4) {
    level thread _id_DC28(var_0, var_3);
  }
}

_id_DC28(var_0, var_1) {
  level endon("game_ended");
  wait 1;

  foreach(var_3 in level.players) {
    if(var_0 == "challenge_failed") {
      var_3 playlocalsound("zmb_challenge_fail");
      var_3 setclientomnvar("zm_show_challenge", 2);
      level._id_41AC = 2;
      continue;
    }

    var_3 playlocalsound("zmb_challenge_complete");
    var_3 setclientomnvar("zm_show_challenge", 3);
    level._id_41AC = 3;
  }

  wait 3.0;

  foreach(var_3 in level.players) {
    var_3 thread _id_C5CD();
  }

  setomnvar("zm_challenge_progress", 0);
  level._id_415A = -1;
  level._id_415F = -1;
  level._id_415E = -1;
  level._id_415C = -1;
  level._id_4161 = -1;
  level._id_4162 = -1;
  level._id_4160 = -1;
  level._id_415D = 0;
}

_id_C5CD() {
  wait 0.5;
  self setclientomnvar("ui_intel_active_index", -1);
  self setclientomnvar("ui_intel_progress_current", -1);
  self setclientomnvar("ui_intel_progress_max", -1);
  self setclientomnvar("ui_intel_percent", -1);
  self setclientomnvar("ui_intel_target_player", -1);
  self setclientomnvar("ui_intel_prechallenge", 0);
  self setclientomnvar("ui_intel_timer", -1);
  self setclientomnvar("ui_intel_challenge_scalar", -1);
}

_id_C1D1(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  var_11 = spawnStruct();
  var_11._id_C189 = var_0;
  var_11._id_01FA = var_1;
  var_11._id_4591 = var_2;
  var_11._id_8A70 = ::_id_4575;

  if(isDefined(var_3)) {
    var_11._id_8A70 = var_3;
  }

  var_11._id_3110 = ::_id_4563;

  if(isDefined(var_4)) {
    var_11._id_3110 = var_4;
  }

  var_11._id_0EF3 = var_5;
  var_11._id_438E = var_6;
  var_11._id_58D4 = ::_id_4568;

  if(isDefined(var_7)) {
    var_11._id_58D4 = var_7;
  }

  var_11._id_FC73 = var_8;
  var_11._id_C806 = ::_id_4587;

  if(isDefined(var_9)) {
    var_11._id_C806 = var_9;
  }

  var_11._id_58DA = ::_id_4569;

  if(isDefined(var_10)) {
    var_11._id_58DA = var_10;
  }

  level._id_33A5[var_0] = var_11;
}

_id_FB44(var_0, var_1) {
  if(scripts\engine\utility::_id_5C00("pause_challenges")) {
    return;
  }
  foreach(var_3 in level.players) {
    var_3 setclientomnvar("zm_show_challenge", 1);
    var_3 setclientomnvar("ui_intel_progress_current", var_0);
    level._id_41AC = 1;
  }

  setomnvar("zm_challenge_progress", var_0 / var_1);
  level._id_415F = var_1;
  level._id_415E = var_0;
}

_id_4563() {
  return 1;
}

_id_4568() {}

_id_4575() {
  if(isDefined(self._id_EACB)) {
    return self._id_EACB;
  } else {
    return 0;
  }
}

_id_4592() {
  if(isDefined(self._id_EACB)) {
    return self._id_EACB;
  } else {
    return self._id_4591;
  }
}

_id_4569() {}

_id_4586() {
  self._id_EACB = self._id_4591;
}

_id_4587() {}

_id_4159() {
  return isDefined(level._id_4158);
}

_id_415B(var_0) {
  return _id_4159() && level._id_4158 == var_0;
}

_id_F9B8() {
  level._id_4158 = undefined;
}

_id_D1A2(var_0) {
  level._id_4158 = var_0;
  _id_0995::_id_9717(level._id_4158, level._id_10C9F);
  level._id_E9BD = gettime() / 1000;
}

_id_65F9() {
  if(!isDefined(level._id_A74F)) {
    return 0;
  } else {
    return level._id_A74F;
  }
}

_id_811F() {
  if(!isDefined(level._id_1101E)) {
    return;
  }
  var_0 = level._id_1101E;
  var_1 = 0;
  var_2 = 1;
  var_3 = 99;
  var_4 = 1;
  var_5 = 2;
  var_6 = 6;
  var_7 = 7;
  var_8 = 8;

  for(var_9 = var_2; var_9 <= var_3; var_9++) {
    var_10 = _func_0222(var_0, var_1, var_9, var_4);

    if(var_10 == "") {
      break;
    }

    var_11 = _func_0222(var_0, var_1, var_9, var_5);
    var_12 = _func_0222(var_0, var_1, var_9, var_8);

    if(isDefined(level._id_33A5[var_10])) {
      level._id_33A5[var_10]._id_15A2 = var_11;
      level._id_33A5[var_10]._id_15AD = int(_func_0222(var_0, var_1, var_9, var_6));
      level._id_33A5[var_10]._id_0F33 = strtok(var_12, " ");
    }
  }
}

_id_4564(var_0) {
  return 1;
}

_id_FB53(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  if(istrue(self._id_4982)) {
    return;
  }
  if(!isDefined(level._id_4158)) {
    return;
  }
  var_9 = level._id_4158;

  if(isDefined(level._id_4231)) {
    var_10 = self[[level._id_4231]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8);

    if(!istrue(var_10)) {
      return;
    }
  }
}

_id_FB4E(var_0) {
  level endon("stop_challenge_timer");
  level endon("game_ended");
  level endon("challenge_deactivated");
  self endon("success");
  var_1 = 0;
  var_2 = level._id_4162;

  while(level._id_4162 > 0) {
    wait 0.1;

    if(scripts\engine\utility::_id_5C00("pause_challenges")) {
      foreach(var_4 in level.players) {
        var_4 setclientomnvar("ui_intel_timer", -1);
        var_4 setclientomnvar("zm_show_challenge", 10);
      }

      scripts\engine\utility::_id_5C30("pause_challenges");
      var_6 = int(gettime() + level._id_4162 * 1000);

      foreach(var_4 in level.players) {
        var_4 setclientomnvar("ui_intel_timer", var_6);
        var_4 setclientomnvar("zm_show_challenge", level._id_41AC);
      }
    }

    level._id_4162 = level._id_4162 - 0.1;

    if(isDefined(var_0)) {
      _id_FB44(int(var_2 - level._id_4162), int(var_2));
    }
  }
}

_id_4596(var_0) {
  level endon("game_ended");
  level endon("challenge_deactivated");
  self endon("success");
  var_1 = var_0;

  while(var_1 > 0) {
    wait 0.1;

    if(scripts\engine\utility::_id_5C00("pause_challenges")) {
      continue;
    }
    var_1 = var_1 - 0.1;
  }

  self._id_EACB = self._id_4591;
  level thread _id_4374();
}