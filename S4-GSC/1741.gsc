/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 1741.gsc
*************************************************/

_id_81CD() {
  _id_7F48();
}

_id_7F48(var_0) {
  if(isDefined(level._id_CF58)) {
    return;
  }
  level._id_F13C = istrue(var_0);
  level._id_3F68 = [];
  level._id_40ED = [];
  level._id_CF5B = [];
  level._id_40EF = [];
  level._id_CF5D = [];
  level._id_40EE = [];
  level._id_CF5C = [];
  level._id_4047 = 0;
  level._id_CF59 = [];
  level._id_CF5A = [];
  level._id_CF58 = [];
}

_id_81D5() {
  if(isDefined(level._id_CF58)) {
    level._id_40E7 = 0;

    if(_func_0107(level._id_CF58)) {
      for(var_0 = 0; var_0 < level._id_CF58.size; var_0++) {
        [[level._id_CF58[var_0]]](1, "cs" + var_0);
      }
    } else if(istrue(level._id_F13C))
      [[level._id_CF58]](1);
    else {
      [[level._id_CF58]]();
    }
  }
}

_id_C1D7(var_0, var_1, var_2, var_3) {
  if(isDefined(var_3)) {
    level._id_CF58[level._id_CF58.size] = var_3;
  }

  if(isDefined(var_0)) {
    level._id_CF59[level._id_CF59.size] = var_0;
  }

  if(isDefined(var_1)) {
    level._id_CF5A[level._id_CF59.size] = var_1;
  }

  if(isDefined(var_2)) {
    level._id_3F68[var_0] = "cs" + var_2;
  }
}

_id_81CE(var_0) {
  if(scripts\engine\utility::_id_5C0C(var_0)) {
    scripts\engine\utility::_id_5C1B(var_0);

    if(scripts\engine\utility::_id_5C0C(var_0 + "_completed")) {
      level endon("game_ended");
      scripts\engine\utility::_id_5C24(var_0 + "_completed");
    }
  }
}

_id_C22A(var_0) {
  if(!isDefined(level._id_15A5)) {
    level._id_15A5 = [];
  }

  level._id_15A5 = scripts\engine\utility::array_add(level._id_15A5, var_0);
}

_id_C22B(var_0) {
  if(!isDefined(level._id_15A8)) {
    level._id_15A8 = [];
  }

  level._id_15A8 = scripts\engine\utility::array_add(level._id_15A8, var_0);
}

_id_EA4F(var_0, var_1) {
  if(!isDefined(level._id_CF5B)) {
    level._id_CF5B = [];
  }

  if(!isDefined(level._id_CF5D)) {
    level._id_CF5D = [];
  }

  if(!isDefined(level._id_CF5C)) {
    level._id_CF5C = [];
  }

  if(!isDefined(level._id_40EB)) {
    level._id_40EB = [];
  }

  if(!isDefined(level._id_40E6)) {
    level._id_40E6 = [];
  }

  if(!isDefined(level._id_40ED)) {
    level._id_40ED = [];
  }

  if(!isDefined(level._id_40EF)) {
    level._id_40EF = [];
  }

  if(!isDefined(level._id_40EE)) {
    level._id_40EE = [];
  }

  if(isDefined(var_0) && !isDefined(level._id_CF5B[var_0])) {
    level._id_CF5B[var_0] = [];
  }

  if(isDefined(var_0) && !isDefined(level._id_CF5D[var_0])) {
    level._id_CF5D[var_0] = [];
  }

  if(isDefined(var_0) && !isDefined(level._id_CF5C[var_0])) {
    level._id_CF5C[var_0] = [];
  }

  if(isDefined(var_0) && !isDefined(level._id_40ED[var_0])) {
    level._id_40ED[var_0] = [];
  }

  if(isDefined(var_0) && !isDefined(level._id_40EF[var_0])) {
    level._id_40EF[var_0] = [];
  }

  if(isDefined(var_0) && !isDefined(level._id_40EE[var_0])) {
    level._id_40EE[var_0] = [];
  }

  if(!isDefined(level._id_40EA)) {
    level._id_40EA = [];
  }

  if(isDefined(var_1) && !isDefined(level._id_40EA[var_1])) {
    level._id_40EA[var_1] = self;
  }
}

_id_EA47(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14, var_15) {
  level endon("game_ended");

  if(!var_0 _id_A861()) {
    return;
  }
  if(isDefined(level._id_40E7) && !_id_40E9()) {
    level._id_40E7++;

    if(level._id_40E7 % 25 == 0) {
      waitframe();
    }
  }

  if(isDefined(var_3)) {
    var_0.origin = var_3;
  }

  if(isDefined(var_4)) {
    var_0.angles = var_4;
  } else if(!isDefined(var_0.angles)) {
    var_0.angles = (0, 0, 0);
  }

  if(isDefined(var_5)) {
    var_0._id_0481 = var_5;
  }

  if(isDefined(var_6)) {
    var_0.target = var_6;
  }

  if(isDefined(var_7)) {
    var_0._id_039B = var_7;
  }

  if(isDefined(var_8)) {
    var_0._id_0399 = var_8;
  }

  if(isDefined(var_9)) {
    var_0._id_0398 = var_9;
  }

  if(isDefined(var_13)) {
    var_0.speed = var_13;
  }

  if(isDefined(var_12)) {
    var_0._id_0359 = var_12;
  }

  if(isDefined(var_14)) {
    var_0._id_03EA = int(var_14);
  }

  if(isDefined(var_15)) {
    var_0._id_CEA5 = var_15;
  }

  _id_F4A6(var_2, var_0, var_10, var_11);

  if(!isDefined(var_1)) {
    var_1 = "_";
  }

  _id_EA4F(var_1);
  _id_EA49(var_0, var_1);
  _id_F8E1(var_0);

  if(isDefined(self._id_A8FF)) {
    self._id_A8FF[self._id_A8FF.size] = var_0;
  }

  if(isDefined(var_0.model)) {
    _id_EA4B(var_0, var_1);
  } else {
    if(isDefined(var_0._id_0481)) {
      if(istrue(var_0._id_8592)) {
        var_0._id_8592 = undefined;
        _id_EA51(var_0, var_1, 1);
        return;
      }

      if(istrue(var_0._id_858F)) {
        _id_EA4B(var_0, var_1);
        return;
      }

      if(istrue(var_0._id_8590)) {
        var_0._id_8590 = undefined;
        _id_EA4E(var_0, var_1);
        return;
      }

      switch (var_0._id_0481) {
        case "trigger_spawn":
          _id_EA51(var_0, var_1);
          break;
        case "trigger_fallback":
          _id_EA51(var_0, var_1);
          break;
        case "module_update":
          _id_EA51(var_0, var_1, 1);
          break;
        case "cs_trigger":
          _id_EA51(var_0, var_1, 1);
          break;
        case "interaction":
          _id_EA4A(var_0, var_1);
          break;
        case "trigger_kill_floodspawner":
          _id_EA51(var_0, var_1, 1);
          break;
        default:
          _id_EA48(var_0, 0, var_1);
          break;
      }

      return;
      return;
      return;
      return;
    }

    _id_EA48(var_0, 0, var_1);
  }
}

_id_A861() {
  var_0 = 0;
  var_1 = 0;

  if(isDefined(level._id_15A5)) {
    if(isDefined(self._id_CD69)) {
      for(var_2 = 0; var_2 < level._id_15A5.size; var_2++) {
        if(_func_00D6(level._id_15A5[var_2], 0, 1) == "!") {
          var_3 = 1;
        } else {
          var_3 = 0;
        }

        if(_id_8649(self._id_CD69, level._id_15A5[var_2]) != var_3) {
          var_0 = 1;
          break;
        }
      }
    } else
      var_0 = 1;
  } else
    var_0 = 1;

  if(isDefined(level._id_15A8)) {
    if(isDefined(self._id_CD69)) {
      for(var_2 = 0; var_2 < level._id_15A8.size; var_2++) {
        if(_func_00D6(level._id_15A8[var_2], 0, 1) == "!") {
          var_3 = 1;
        } else {
          var_3 = 0;
        }

        if(_id_8649(self._id_CD69, level._id_15A8[var_2]) != var_3) {
          var_1 = 1;
          break;
        }
      }
    } else
      var_1 = 1;
  } else
    var_1 = 1;

  return istrue(var_0 && var_1);
}

_id_8649(var_0, var_1) {
  if(!isDefined(var_0) || var_0 == "" || !isDefined(var_1) || var_1 == "") {
    return 0;
  }

  return issubstr(var_0, var_1);
}

_id_F4A6(var_0, var_1, var_2, var_3) {
  _id_F4A2(var_0, var_1);

  if(isDefined(var_2)) {
    if(!isDefined(var_3)) {
      var_3 = (0, 0, 0);
    }

    var_4 = (0, 0, 0);

    if(isDefined(var_1.angles)) {
      var_4 = var_1.angles;
    }

    var_5 = var_1.origin;
    var_1.origin = var_2 + rotatevector(var_5, var_3);

    if(isDefined(var_1._id_CE10)) {
      var_1._id_CE10 = var_2 + rotatevector(var_1._id_CE10, var_3);
    }

    var_6 = _func_0047(var_3, var_4);
    var_1.angles = var_6;
  }
}

_id_F4A2(var_0, var_1) {
  if(isDefined(var_0) && isDefined(level._id_40EB) && isDefined(level._id_40E6[var_0])) {
    var_2 = level._id_40E6[var_0];
    var_3 = level._id_40EB[var_0];
    var_4 = (0, 0, 0);

    if(isDefined(var_1.angles)) {
      var_4 = var_1.angles;
    }

    var_5 = var_1.origin;
    var_1.origin = var_3 + rotatevector(var_5, var_2);

    if(isDefined(var_1._id_CE10)) {
      var_1._id_CE10 = var_3 + rotatevector(var_1._id_CE10, var_2);
    }

    var_6 = _func_0047(var_2, var_4);
    var_1.angles = var_6;
  }
}

_id_EA46(var_0, var_1, var_2) {
  if(!getdvarint("#x35d134f3aad307e37", 0)) {
    return;
  }
  if(var_0 == "struct") {
    level._id_CF5B[var_2][level._id_CF5B[var_2].size] = var_1;
  } else if(var_0 == "trigger") {
    level._id_CF5D[var_2][level._id_CF5D[var_2].size] = var_1;
  } else if(var_0 == "model") {
    level._id_CF5C[var_2][level._id_CF5C[var_2].size] = var_1;
  }
}

_id_EA4A(var_0, var_1) {
  _id_EA48(var_0, 1, var_1);
}

_id_EA4E(var_0, var_1) {
  var_2 = spawn("script_origin", var_0.origin);

  if(!isDefined(var_0.angles)) {
    var_2.angles = (0, 0, 0);
  } else {
    var_2.angles = var_0.angles;
  }

  if(isDefined(var_0.model)) {
    var_2 setModel(var_0.model);
  }

  if(isDefined(var_0._id_0481)) {
    var_2._id_0481 = var_0._id_0481;
  }

  if(isDefined(var_0._id_039B)) {
    var_2._id_039B = var_0._id_039B;
  }

  if(isDefined(var_0._id_0399)) {
    var_2._id_0399 = var_0._id_0399;
  }

  if(isDefined(var_0._id_0398)) {
    var_2._id_0398 = var_0._id_0398;
  }

  if(isDefined(var_0.target)) {
    var_2.target = var_0.target;
  }

  var_2._id_EA6A = var_0;

  if(isDefined(self._id_A8FF)) {
    self._id_A8FF[self._id_A8FF.size] = var_2;
  }
}

_id_EA4B(var_0, var_1) {
  _id_EA46("model", var_0, var_1);

  if(!isDefined(var_0.angles)) {
    var_0.angles = (0, 0, 0);
  }

  var_2 = spawn("script_model", var_0.origin);
  var_2 setModel(var_0.model);
  var_2.angles = var_0.angles;

  if(isDefined(var_0._id_0481)) {
    var_2._id_0481 = var_0._id_0481;
  }

  if(isDefined(var_0._id_039B)) {
    var_2._id_039B = var_0._id_039B;
  }

  if(isDefined(var_0._id_0399)) {
    var_2._id_0399 = var_0._id_0399;
  }

  if(isDefined(var_0._id_0398)) {
    var_2._id_0398 = var_0._id_0398;
  }

  if(isDefined(var_0.target)) {
    var_2.target = var_0.target;
  }

  if(isDefined(var_0.name)) {
    var_2.name = var_0.name;
  }

  var_2._id_EA6A = var_0;
  var_0._id_858F = undefined;
  var_0._id_8591 = undefined;

  if(isDefined(self._id_A8FF)) {
    self._id_A8FF[self._id_A8FF.size] = var_2;
  }
}

_id_EA51(var_0, var_1, var_2) {
  _id_EA46("trigger", var_0, var_1);
  var_3 = spawn("trigger_rotatable_radius", var_0.origin, 0, int(var_0._id_0359), int(var_0.height));

  if(isDefined(var_0.angles) && var_0.angles != (0, 0, 0)) {
    if(istrue(var_2)) {
      var_3.angles = var_0.angles;
    } else {
      var_3.angles = (-90, 0, 0) + var_0.angles;
    }
  }

  var_3._id_EA6A = var_0;

  if(isDefined(self._id_A8FF)) {
    self._id_A8FF[self._id_A8FF.size] = var_3;
  }

  var_3 _id_EA50(var_0);
}

_id_EA50(var_0) {
  if(!isDefined(var_0.angles)) {
    var_0.angles = (0, 0, 0);
  }

  if(isDefined(var_0._id_CD99)) {
    self._id_CD99 = var_0._id_CD99;
  }

  if(isDefined(var_0._id_CD62)) {
    self._id_CD62 = var_0._id_CD62;
  }

  if(isDefined(var_0._id_039B)) {
    self._id_039B = var_0._id_039B;
  }

  if(isDefined(var_0._id_CD71)) {
    self._id_CD71 = var_0._id_CD71;
  }

  if(isDefined(var_0.target)) {
    self.target = var_0.target;
  }

  if(isDefined(var_0._id_CEC3)) {
    self._id_CEC3 = var_0._id_CEC3;
  }

  if(isDefined(var_0._id_CD45)) {
    self._id_CD45 = var_0._id_CD45;
  }

  if(isDefined(var_0._id_0399)) {
    self._id_0399 = var_0._id_0399;
  }

  if(isDefined(var_0._id_0398)) {
    self._id_0398 = var_0._id_0398;
  }

  if(isDefined(var_0._id_722E)) {
    self._id_722E = var_0._id_722E;
  }

  if(isDefined(var_0._id_CCEA)) {
    self._id_CCEA = var_0._id_CCEA;
  }

  if(isDefined(var_0._id_CCEC)) {
    self._id_CCEC = var_0._id_CCEC;
  }

  if(isDefined(var_0._id_CCEB)) {
    self._id_CCEB = var_0._id_CCEB;
  }

  if(isDefined(var_0._id_CDB3)) {
    self._id_CDB3 = var_0._id_CDB3;
  }

  self._id_0481 = var_0._id_0481;
}

_id_EA48(var_0, var_1, var_2) {
  if(isDefined(var_0.target)) {
    _id_40E5("target", var_0.target, var_0);
  }

  if(isDefined(var_0._id_0398)) {
    _id_40E5("script_linkname", var_0._id_0398, var_0);
  }

  if(isDefined(var_0._id_0481)) {
    _id_40E5("targetname", var_0._id_0481, var_0);
  }

  if(isDefined(var_0._id_039B)) {
    _id_40E5("script_noteworthy", var_0._id_039B, var_0);
  }
}

_id_40E5(var_0, var_1, var_2) {
  if(!isDefined(level._id_EA70[var_0][var_1])) {
    level._id_EA70[var_0][var_1] = [];
  }

  level._id_EA70[var_0][var_1][level._id_EA70[var_0][var_1].size] = var_2;
}

_id_EA49(var_0, var_1) {
  if(isDefined(var_0.target) && issubstr(var_0.target, "auto")) {
    var_0.target = "CS|" + var_1 + var_0.target;
  }

  if(isDefined(var_0._id_0481) && issubstr(var_0._id_0481, "auto")) {
    var_0._id_0481 = "CS|" + var_1 + var_0._id_0481;
  }

  if(isDefined(var_0._id_0399)) {
    var_2 = "";
    var_3 = strtok(var_0._id_0399, " ");

    foreach(var_6, var_5 in var_3) {
      if(var_6 != 0) {
        if(int(var_0._id_0399) == 0) {
          var_2 = var_2 + " " + var_5;
        } else {
          var_2 = var_2 + " " + "CS|" + var_1 + var_5;
        }

        continue;
      }

      if(int(var_0._id_0399) == 0) {
        var_2 = var_2 + var_5;
        continue;
      }

      var_2 = var_2 + "CS|" + var_1 + var_5;
    }

    var_0._id_0399 = var_2;
  }

  if(isDefined(var_0._id_0398)) {
    if(int(var_0._id_0398) != 0) {
      var_0._id_0398 = "CS|" + var_1 + var_0._id_0398;
    }
  }
}

_id_F8E1(var_0) {
  if(istrue(var_0._id_889A)) {
    if(isDefined(var_0._id_CEA5)) {
      var_0._id_CEA5 = int(var_0._id_CEA5);
    }
  }

  if(isDefined(var_0._id_CEBF)) {
    var_0._id_CEBF = float(var_0._id_CEBF);
  }

  if(isDefined(var_0._id_CEBE)) {
    var_0._id_CEBE = float(var_0._id_CEBE);
  }

  if(isDefined(var_0._id_CEBD)) {
    var_0._id_CEBD = float(var_0._id_CEBD);
  }

  if(isDefined(var_0._id_CCC9)) {
    var_0._id_CCC9 = float(var_0._id_CCC9);
  }

  if(isDefined(var_0._id_027E)) {
    var_0._id_027E = int(var_0._id_027E);
  }

  if(isDefined(var_0.speed)) {
    var_0.speed = int(var_0.speed);
  }

  if(isDefined(var_0._id_CC89)) {
    var_0._id_CC89 = int(var_0._id_CC89);
  }

  if(isDefined(var_0._id_CCF6)) {
    var_0._id_CCF6 = int(var_0._id_CCF6);
  }

  if(isDefined(var_0._id_CD77)) {
    if(var_0._id_CD77 == "true" || var_0._id_CD77 == "1") {
      var_0._id_CD77 = 1;
    } else {
      var_0._id_CD77 = undefined;
    }
  }

  if(isDefined(var_0._id_CC9C)) {
    if(var_0._id_CC9C == "true" || var_0._id_CC9C == "1") {
      var_0._id_CD77 = 1;
    } else {
      var_0._id_CD77 = undefined;
    }
  }

  if(isDefined(var_0._id_0393)) {
    var_0._id_0393 = float(var_0._id_0393);
  }

  if(isDefined(var_0._id_CD8A)) {
    var_0._id_CD8A = int(var_0._id_CD8A);
  }

  if(isDefined(var_0._id_CD89)) {
    var_0._id_CD89 = int(var_0._id_CD89);
  }

  if(isDefined(var_0._id_CCEF)) {
    var_0._id_CCEF = int(var_0._id_CCEF);
  }

  if(isDefined(var_0._id_CEB7)) {
    var_0._id_CEB7 = float(var_0._id_CEB7);
  }

  if(isDefined(var_0._id_CD58)) {
    var_0._id_CD58 = int(var_0._id_CD58);
  }

  if(isDefined(var_0._id_CE86)) {
    var_0._id_CE86 = int(var_0._id_CE86);
  }

  if(isDefined(var_0._id_CD11)) {
    var_0._id_CD11 = int(var_0._id_CD11) * int(var_0._id_CD11);
  }

  if(isDefined(var_0._id_CE57)) {
    var_0._id_CE57 = int(var_0._id_CE57);
  }

  if(isDefined(var_0._id_CCEA)) {
    var_0._id_CCEA = int(var_0._id_CCEA);
  }

  if(isDefined(var_0._id_03A0)) {
    var_0._id_03A0 = int(var_0._id_03A0);
  }

  if(isDefined(var_0._id_CCFD)) {
    var_0._id_CCFD = float(var_0._id_CCFD);
  }

  if(isDefined(var_0._id_CCFB)) {
    var_0._id_CCFB = float(var_0._id_CCFB);
  }

  if(isDefined(var_0._id_CD32)) {
    var_0._id_CD32 = int(var_0._id_CD32);
  }

  if(isDefined(var_0._id_CD75)) {
    var_0._id_CD75 = int(var_0._id_CD75);
  }

  if(isDefined(var_0._id_CE85)) {
    var_0._id_CE85 = float(var_0._id_CE85);
  }

  if(isDefined(var_0._id_CE12)) {
    var_0._id_CE12 = int(var_0._id_CE12);
  }

  if(isDefined(var_0._id_CD58)) {
    var_0._id_CD58 = int(var_0._id_CD58);
  }

  if(isDefined(var_0._id_4DA6)) {
    var_0._id_4DA6 = int(var_0._id_4DA6);
  }

  if(isDefined(var_0._id_CE10)) {
    var_0._id_CE10 = var_0._id_CE10;
  }

  if(isDefined(var_0._id_CD20)) {
    var_0._id_CD20 = int(var_0._id_CD20);
  }

  if(isDefined(var_0._id_CD89)) {
    var_0._id_CD89 = int(var_0._id_CD89);
  }
}

_id_40E9() {
  if(scripts\common\utility::iscp()) {
    return gettime() <= level._id_E72D + 250;
  } else {
    return gettime() <= level._id_E730 + 250;
  }
}

_id_40E8(var_0) {
  if(!scripts\engine\utility::_id_5C0C("strike_init_done")) {
    scripts\engine\utility::_id_5C11("strike_init_done");
  }

  if(!scripts\engine\utility::_id_5C0C("create_script_initialized")) {
    scripts\engine\utility::_id_5C11("create_script_initialized");
  }

  var_0._id_A8FF = [];
  var_0 scripts\engine\utility::_id_5473("cs_structs_complete");
  var_0 scripts\engine\utility::_id_5473("cs_models_complete");
  var_0 scripts\engine\utility::_id_5473("cs_triggers_complete");
}

_id_10711(var_0, var_1) {
  var_0 scripts\engine\utility::_id_5476("cs_structs_complete");
  var_0 scripts\engine\utility::_id_5476("cs_triggers_complete");
  scripts\engine\utility::_id_5C1B(var_1 + "_completed");

  if(_id_40E9()) {
    _id_52EF(var_0);
  }
}

_id_52EF(var_0) {
  if(isDefined(level._id_4047)) {
    level._id_4047++;

    if(level._id_4047 >= level._id_CF58.size) {
      scripts\engine\utility::_id_5C1B("strike_init_done");
      scripts\engine\utility::_id_5C1B("create_script_initialized");
    }
  } else {
    scripts\engine\utility::_id_5C1B("strike_init_done");
    scripts\engine\utility::_id_5C1B("create_script_initialized");
  }
}

_id_106FE(var_0) {
  scripts\engine\utility::_id_5C11(var_0 + "_completed");

  if(!_id_DAF2(var_0)) {
    _id_52EF();
    scripts\engine\utility::_id_5C24(var_0);
  }
}

_id_DAF2(var_0) {
  var_1 = strtok(getDvar("#x385ed7963c5e37386", ""), " ");
  var_1 = scripts\engine\utility::array_combine(var_1, level._id_0F1B);

  if(var_1.size < 1) {
    return 1;
  }

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    var_3 = var_1[var_2];

    if(var_3 == "all") {
      return 1;
    }

    if(var_0 == var_3) {
      return 1;
    }
  }

  return 0;
}

_id_C1D9(var_0, var_1, var_2) {
  if(isDefined(var_1)) {
    level._id_40EB[var_0] = var_1;
  }

  if(isDefined(var_2)) {
    level._id_40E6[var_0] = var_2;
  }
}

_id_D1A0(var_0) {
  level._id_0F1B[level._id_0F1B.size] = var_0;
}

_id_3851(var_0) {
  scripts\engine\utility::_id_5C04(var_0 + "_completed");
  scripts\engine\utility::_id_5C04(var_0);

  if(isDefined(level._id_40EA[var_0]) && isDefined(level._id_40EA[var_0]._id_A8FF)) {
    var_1 = level._id_40EA[var_0]._id_A8FF;

    for(var_2 = 0; var_2 < var_1.size; var_2++) {
      var_3 = var_1[var_2];
      level._id_40EA[var_0]._id_A8FF[var_2] = undefined;

      if(_func_02DE(var_3)) {
        scripts\engine\utility::_id_4794(var_3);
      }

      if(isent(var_3)) {
        var_3 delete();
      }
    }
  }
}

_id_CAB0() {
  return spawnStruct();
}

_id_E10A(var_0) {
  var_1 = scripts\engine\utility::getstructarray(var_0, "targetname");

  foreach(var_3 in var_1) {
    if(!isDefined(var_3.angles)) {
      var_3.angles = (0, 0, 0);
    }

    var_4 = "Cover Stand";

    switch (var_3._id_A57C) {
      case "cover_left":
        var_4 = "Cover Left";
        break;
      case "cover_right":
        var_4 = "Cover Right";
        break;
      case "cover_crouch":
        var_4 = "Cover Crouch";
        break;
      case "cover_stand":
        var_4 = "Cover Stand";
        break;
      case "cover_crouch_window":
        var_4 = "Cover Crouch Window";
        break;
      case "conceal_crouch":
        var_4 = "Conceal Crouch";
        break;
      case "turret":
        var_4 = "Turret";
        break;
    }

    var_5 = undefined;

    if(isDefined(var_3._id_A562)) {
      var_5 = var_3._id_A562;
    }

    var_6 = 0;

    if(isDefined(var_3._id_A5DE) && int(var_3._id_A5DE) != 0 && var_3._id_A5DE != "false") {
      var_6 = 4;
    }

    if(isDefined(var_3._id_A549) && int(var_3._id_A549) != 0 && var_3._id_A549 != "false") {
      var_6 = var_6 + 8;
    }

    if(isDefined(var_3._id_A5B9) && int(var_3._id_A5B9) != 0 && var_3._id_A5B9 != "false") {
      var_6 = var_6 + 16;
    }

    var_3._id_011F = _func_02FE(var_3.origin, var_3.angles, var_4, var_6, var_5);

    if(isDefined(var_3._id_0359)) {
      var_3._id_011F._id_0359 = var_3._id_0359;
    }
  }

  return var_1;
}

_id_470A(var_0) {
  var_1 = scripts\engine\utility::getstructarray(var_0, "targetname");

  foreach(var_3 in var_1) {
    if(isDefined(var_3._id_011F)) {
      _func_02FF(var_3._id_011F);
      var_3._id_011F = undefined;
    }
  }
}