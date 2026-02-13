/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2292.gsc
*************************************************/

_id_DB16() {
  return _id_06BD::_id_23C5() == "exposed" && isDefined(self._id_0192) && isDefined(self._id_02ED);
}

_id_DB17(var_0, var_1, var_2, var_3) {
  if(isDefined(self._id_2C5E._id_011B) && (isDefined(self._id_21BD) || self._id_01D5)) {
    return _id_06BD::_id_23E9();
  }

  return 0;
}

_id_B376(var_0, var_1, var_2, var_3) {
  if(var_3 == "alignToNode") {
    if(isDefined(var_1)) {
      if(scripts\engine\utility::_id_0F78()) {
        var_4 = _func_0078(var_2);
        var_5 = _id_08F1::_id_6B9C(var_1, 0);
        var_6 = _func_0047(var_5, -1 * var_4);
        self _meth_8251("face angle 3d", var_6);
      } else {
        var_4 = _func_0078(var_2);
        var_5 = (0, _id_08F1::_id_6B9D(var_1), 0);
        var_6 = var_5 - var_4;
        self _meth_8251("face angle", var_6[1]);
      }
    }
  } else if(var_3 == "stickToNode") {
    var_7 = _func_00B0(var_2);

    if(distancesquared(var_1.origin, self.origin) < 16) {
      self _meth_82AA(var_1.origin);
    } else {
      thread _id_91DC(var_1, 4, var_0 + "_finished");
    }
  }
}

_id_3635(var_0, var_1, var_2) {
  var_3 = scripts\engine\utility::ter_op(_id_0900::_id_DBC1(var_0, var_1, var_2), "react_newenemy_", "");
  var_4 = _id_0009::_id_1C7D(var_1, var_3 + "2");
  var_5 = _id_0009::_id_1C6E(var_1, var_4);
  var_6 = _func_0077(var_5, 0.0, 1.0);
  var_7 = _func_000B(180 - var_6);

  if(isDefined(self._id_0323) && self._id_01B7) {
    var_8 = vectortoangles(self._id_027F);
    var_9 = var_8[1] - self.angles[1];
    var_10 = _func_000B(var_9 + var_7);
  } else if(isDefined(self._id_0323) && !self._id_01B7 && isDefined(self._id_0192) && !scripts\anim\utility_common::_id_31CC()) {
    var_9 = 0;
    var_10 = var_7;
  } else if(isDefined(self._id_03DC)) {
    var_9 = _func_000B(_func_0261(self._id_03DC - self.origin) - self.angles[1]);
    var_10 = _func_000B(var_9 + var_7);
  } else {
    var_11 = self._id_0192;
    var_9 = scripts\engine\utility::_id_6C82(0.25, var_11, undefined);
    var_10 = _func_000B(var_9 + var_7);
  }

  var_12 = isDefined(var_2) && var_2 == "Cover Left";
  var_13 = isDefined(var_2) && var_2 == "Cover Right";
  var_14 = spawnStruct();

  if(var_12 && var_10 < 0 && var_10 > -90) {
    var_14._id_F80F = _id_0009::_id_1C7D(var_1, var_3 + "8");
  } else if(var_13 && var_10 > 0 && var_10 < 90) {
    var_14._id_F80F = _id_0009::_id_1C7D(var_1, var_3 + "8");
  } else if(abs(var_10) > 135) {
    var_14._id_F80F = _id_0009::_id_1C7D(var_1, var_3 + "2");
  } else if(var_10 < 0) {
    var_14._id_F80F = _id_0009::_id_1C7D(var_1, var_3 + "6");
  } else {
    var_14._id_F80F = _id_0009::_id_1C7D(var_1, var_3 + "4");
  }

  var_14._id_BB7D = var_9;
  return var_14;
}

_id_B906(var_0, var_1, var_2) {
  self endon(var_1 + "_finished");
  var_3 = _id_0009::_id_1C5C(var_0, var_1);
  var_4 = 1.0;
  self _meth_8742();

  if((_id_06BD::_id_23E0() || _id_06BD::_id_23E3()) && isDefined(self._id_9D39.target) && isPlayer(self._id_9D39.target)) {
    var_4 = 2.0;
  } else if(isDefined(level._id_3DFB)) {
    var_4 = level._id_3DFB;
  }

  var_5 = _id_0009::_id_1C6E(var_1, var_3._id_F80F);
  self _meth_85ED(var_1, var_3._id_F80F, var_4);
  _id_0009::_id_1C8E(var_0, var_1, var_5);
  thread _id_B907(var_5, var_1);
  var_6 = _id_0009::_id_1C45(var_0, var_1, _id_0009::_id_1C6A(var_0, var_1));
}

_id_B907(var_0, var_1) {
  self endon("death");
  self endon(var_1 + "_finished");

  if(!isDefined(self._id_0192)) {
    return;
  }
  var_2 = self._id_0192;
  var_2 endon("death");
  var_3 = _func_0079(var_0);

  if(_func_0011(var_0, "start_aim")) {
    var_4 = _func_00BB(var_0, "start_aim");
    var_3 = var_3 * var_4[0];
  } else if(_func_0011(var_0, "finish")) {
    var_4 = _func_00BB(var_0, "finish");
    var_3 = var_3 * var_4[0];
  }

  var_5 = int(var_3 * 20);
  var_6 = var_5;

  while(var_6 > 0) {
    var_7 = 1 / var_6;
    var_8 = scripts\engine\utility::_id_6EA0(var_2.origin);
    self._id_E83A = _func_000B(self.angles[1] + var_8);
    var_9 = self _meth_85F7(var_0);
    var_10 = _func_0077(var_0, var_9, 1.0);
    var_11 = _func_000B(var_8 - var_10);
    self _meth_8251("face angle", _func_000A(self.angles[1] + var_11 * var_7));
    var_6--;
    wait 0.05;
  }
}

_id_38A2(var_0) {
  self waittill(var_0 + "_finished");

  if(isDefined(self)) {
    self _meth_8616();
  }
}

_id_B905(var_0, var_1, var_2) {
  self endon(var_1 + "_finished");
  var_3 = _id_0009::_id_1C5C(var_0, var_1, var_2);

  if(_func_02DE(var_3)) {
    var_4 = var_3._id_040F;
    var_5 = var_3._id_02ED;
    var_6 = _id_0009::_id_1C6E(var_1, var_4);
    thread _id_38A2(var_1);
    var_7 = var_3._id_01BF;
    var_8 = var_3._id_0405;
    var_9 = _func_000B(var_7 - var_3._id_0052);
    self _meth_8019("zonly_physics", 0);
    self _meth_8251("face angle", self.angles[1]);
    _id_0009::_id_1C8E(var_0, var_1, var_6);
    self _meth_85ED(var_1, var_3._id_040F, self._id_18B8);
    var_10 = int(1000 * _func_0079(var_6) - 200);
    self _meth_83D9();
    self _meth_85FB(var_8, (0, var_9, 0), var_5.origin, (0, var_7, 0), var_10);
    _id_0009::_id_1C45(var_0, var_1);
    self._id_0DDF._id_A235 = "stop";
  } else {
    var_11 = var_3;
    var_6 = _id_0009::_id_1C6E(var_1, var_11);
    childthread _id_08F1::_id_D8CE(var_1, 0.2);
    self _meth_8251("face current");
    self _meth_85ED(var_1, var_11);
    _id_0009::_id_1C8E(var_0, var_1, var_6);
    _id_0009::_id_1C45(var_0, var_1, _id_0009::_id_1C6A(var_0, var_1));
  }
}

_id_35BF(var_0, var_1, var_2) {
  var_3 = _id_6D93(var_0, var_1, ::_id_35C0);
  return var_3;
}

_id_3866(var_0, var_1, var_2) {
  self _meth_85FC();
}

_id_2EB1(var_0, var_1, var_2, var_3) {
  var_4 = var_1 - var_3;
  var_5 = (0, var_4, 0);
  var_6 = rotatevector(var_2, var_5);
  return var_0 - var_6;
}

_id_6976(var_0) {
  var_1 = _func_000B(self.angles[1] - var_0);

  if(var_1 >= -45 && var_1 < 45) {
    return 8;
  } else if(var_1 >= 45 && var_1 < 135) {
    return 4;
  } else if(var_1 >= 135 || var_1 < -135) {
    return 2;
  } else if(var_1 >= -135 && var_1 < -45) {
    return 6;
  }
}

_id_35C0(var_0, var_1, var_2, var_3) {
  var_4 = isDefined(self._id_0131) && self._id_0131 == "crouch";
  var_5 = undefined;

  if(isDefined(var_3)) {
    var_6 = _id_6976(var_3[1]);

    if(var_4) {
      var_7 = var_6 + "_crouch";
      var_5 = _id_0009::_id_1C7E(var_1, var_7);
    }

    if(!isDefined(var_5)) {
      var_7 = "" + var_6;
      var_5 = _id_0009::_id_1C7E(var_1, var_7);
    }
  }

  if(!isDefined(var_5)) {
    var_7 = "trans_to_hide";

    if(var_4 && _id_0009::_id_1C72(var_1, "trans_to_hide_crouch")) {
      var_7 = "trans_to_hide_crouch";
    }

    var_5 = _id_0009::_id_1C7D(var_1, var_7);
  }

  return var_5;
}

_id_6D93(var_0, var_1, var_2) {
  var_3 = _id_06BD::_id_23BC();

  if(!isDefined(var_3)) {
    if(isDefined(self._id_02ED) && distancesquared(self.origin, self._id_02ED.origin) < 4096) {
      var_3 = self._id_02ED;
    }
  }

  var_4 = undefined;

  if(!isDefined(var_3)) {
    return self[[var_2]](var_0, var_1);
  }

  var_4 = var_3.origin;
  var_5 = _id_08F1::_id_A57B(var_3);
  var_6 = undefined;
  var_7 = undefined;

  if(var_5) {
    var_8 = undefined;

    if(scripts\engine\utility::_id_8946(var_3) && _id_08F1::_id_8764(var_0, var_1, undefined, "Cover Left Crouch") || scripts\engine\utility::_id_8948(var_3) && _id_08F1::_id_8764(var_0, var_1, undefined, "Cover Right Crouch")) {
      var_8 = "crouch";
    }

    var_6 = _id_08F1::_id_6B9D(var_3, var_8);
    var_7 = var_3.angles;
  }

  var_9 = self[[var_2]](var_0, var_1, undefined, var_7);
  var_10 = spawnStruct();
  var_11 = _id_0009::_id_1C6E(var_1, var_9);
  var_10._id_040F = var_9;
  var_10._id_02ED = var_3;
  var_10._id_02D4 = _func_00B0(var_11, 0.0, 1.0);
  var_10._id_0052 = _func_0077(var_11, 0.0, 1.0);
  var_10._id_0405 = _id_2EB1(var_4, var_6, var_10._id_02D4, var_10._id_0052);
  var_10.angles = var_7;
  var_10._id_01BF = var_6;
  return var_10;
}

_id_88A4(var_0) {
  if(!isDefined(var_0)) {
    return 0;
  }

  if(var_0 scripts\engine\utility::_id_8AE7("over")) {
    return 0;
  }

  return 1;
}

_id_35DB(var_0, var_1, var_2) {
  var_3 = var_2;

  if(_id_88A4(self._id_02ED)) {
    var_3 = var_3 + "_high";
  }

  var_4 = _id_0009::_id_1C7D(var_1, var_3);
  return var_4;
}

_id_B371(var_0, var_1, var_2) {
  self endon(var_1 + "_finished");

  if(self._id_0B67._id_0125 != "exposed" && self._id_025F) {
    thread _id_C61A(var_1 + "_finished");
  } else if(issubstr(var_1, "exposed")) {
    self._id_025F = 1;
  }

  childthread _id_08F1::_id_D8CE(var_1, 0.2);
  var_3 = _id_0009::_id_1C5C(var_0, var_1);
  var_4 = _id_0009::_id_1C6E(var_1, var_3);
  self _meth_8251("face current");
  var_5 = _id_06BD::_id_23BC();

  if(isDefined(var_2)) {
    if(_func_0107(var_2)) {
      foreach(var_7 in var_2) {
        _id_B376(var_1, var_5, var_4, var_7);
      }
    } else
      _id_B376(var_1, var_5, var_4, var_2);
  }

  if(_id_0009::_id_1C43(var_0, "notetrackAim")) {
    var_9 = _func_0077(var_4, 0.0, 1.0);
    self._id_E83A = self.angles[1] + var_9;
  }

  var_10 = 1.0;

  if(isDefined(level._id_3DFB)) {
    var_10 = level._id_3DFB;
  }

  self _meth_85ED(var_1, var_3, var_10);
  _id_0009::_id_1C8E(var_0, var_1, var_4);

  if(!isagent(self)) {
    var_11 = _id_0009::_id_1C7E(var_1, "conceal_add");
    var_5 = _id_06BD::_id_23BC();

    if(isDefined(var_11) && isDefined(var_5) && (var_5.type == "Conceal Crouch" || var_5.type == "Conceal Stand")) {
      var_12 = _id_0009::_id_1C6E(var_1, var_11);
      var_13 = _func_0079(var_4);
      thread _id_E5BF(var_1, var_12, var_13 * 0.3);
    }
  }

  _id_0009::_id_1C45(var_0, var_1, _id_0009::_id_1C6A(var_0, var_1));
  self _meth_8251("face current");
}

_id_C61A(var_0) {
  self endon("death");
  self endon("entitydeleted");
  self waittill(var_0);
  self._id_025F = 0;
}

_id_E5BF(var_0, var_1, var_2) {
  self endon(var_0 + "_finished");
  var_2 = max(var_2, 0.05);
  wait(var_2);
  self _meth_82D9(var_1, 1.0, 0.4, 1.0, 1);
  thread _id_3B58(var_0);
}

_id_B82C(var_0, var_1, var_2) {
  self._id_025F = 1;
  _id_B377(var_0, var_1, var_2);
}

_id_F493(var_0) {
  var_1 = self _meth_85CE(var_0);

  if(isDefined(var_1)) {
    if(var_1 == "stand_run_loop") {
      return 1;
    } else if(scripts\engine\utility::_id_0F78() && var_1 == "stand_run_strafe_loop") {
      return 1;
    }
  }

  return 0;
}

_id_B378(var_0, var_1, var_2) {
  if(!isDefined(self._id_1C30._id_8FB3)) {
    var_3 = [_id_06BD::_id_23BC(), self._id_02ED];

    for(var_4 = 0; !isDefined(self._id_1C30._id_8FB3) && var_4 < var_3.size; var_4++) {
      if(isDefined(var_3[var_4]) && distancesquared(self.origin, var_3[var_4].origin) < 256) {
        self._id_1C30._id_8FB3 = var_3[var_4];
      }
    }
  }

  _id_B377(var_0, var_1, 0.2, var_2);
}

_id_B377(var_0, var_1, var_2) {
  if(isDefined(var_2)) {
    if(var_2 == "stickToNode") {
      var_3 = _id_06BD::_id_23BC();

      if(isDefined(var_3)) {
        if(distancesquared(var_3.origin, self.origin) < 16) {
          self _meth_82AA(var_3.origin);
        } else {
          thread _id_91DC(var_3, 4, var_1 + "_finished");
        }
      }

      if(_id_F493(var_0)) {
        childthread _id_08F1::_id_D8CE(var_1, 0.2);
      }
    }
  }

  if(!isagent(self)) {
    var_4 = _func_031D(self._id_1C30._id_1A35, var_1, "conceal_add", 0);
    var_3 = _id_06BD::_id_23BC();

    if(isDefined(var_4) && isDefined(var_3) && (var_3.type == "Conceal Crouch" || var_3.type == "Conceal Stand")) {
      var_5 = _id_0009::_id_1C6E(var_1, var_4);
      self _meth_82D9(var_5, 1.0, 0.2, 1.0, 1);
      thread _id_3B58(var_1);
    }
  }

  _id_0009::_id_1C81(var_0, var_1, 1);
}

_id_3B58(var_0) {
  self endon("death");
  self endon("entitydeleted");
  self notify("conceal_add_cleanup");
  self endon("conceal_add_cleanup");
  self waittill(var_0 + "_finished");
  var_1 = _func_031C(self._id_1C30._id_1A35, "knobs", "conceal_add", 0);
  self _meth_8077(var_1._id_005C, 0.4);
}

_id_91DC(var_0, var_1, var_2) {
  self endon("death");
  self endon(var_2);

  while(isDefined(var_0)) {
    var_3 = var_0.origin - self.origin;
    var_4 = length(var_3);

    if(var_4 < var_1) {
      self _meth_82AA(var_0.origin);
      break;
    }

    var_3 = var_3 / var_4;
    var_5 = self.origin + var_3 * var_1;
    self _meth_82AA(var_5);
    wait 0.05;
  }
}

_id_3931(var_0, var_1, var_2) {
  if(self._id_025F && !isDefined(self._id_011F)) {
    self._id_025F = 0;
  }

  self._id_0260 = 0;
  self._id_E83A = undefined;
}

_id_F08F(var_0, var_1, var_2) {
  _id_0009::_id_1C52("reload", "end");
  _id_3931(var_0, var_1, var_2);
  _id_0900::_id_C30F(var_0, var_1, var_2);
}

_id_B372(var_0, var_1, var_2) {
  self._id_0260 = 1;
  var_3 = _id_0009::_id_1C5C(var_0, var_1);
  var_4 = _id_0009::_id_1C6E(var_1, var_3);
  self _meth_8251("face current");
  self _meth_85ED(var_1, var_3);
  _id_0009::_id_1C8E(var_0, var_1, var_4);
  _id_0009::_id_1C45(var_0, var_1, _id_0009::_id_1C6A(var_0, var_1));
}

_id_B8D9(var_0, var_1, var_2) {
  var_3 = [];
  var_3["crouch_shuffle_right"] = -90;
  var_3["crouch_shuffle_left"] = 90;
  var_3["stand_shuffle_right"] = -90;
  var_3["stand_shuffle_left"] = 90;
  self endon(var_1 + "_finished");
  var_4 = _id_0009::_id_1C5C(var_0, var_1);
  var_5 = _id_0009::_id_1C6E(var_1, var_4);
  self _meth_85ED(var_1, var_4);
  _id_0009::_id_1C8E(var_0, var_1, var_5);

  if(isDefined(self._id_0B67._id_03D5)) {
    var_6 = self._id_0B67._id_03D5.angles[1];
  } else if(isDefined(self._id_02ED)) {
    var_6 = self._id_02ED.angles[1];
  } else {
    var_6 = self.angles[1];
  }

  if(self._id_04B9 != "c6" && isDefined(var_3[var_1])) {
    var_6 = var_6 + var_3[var_1];
  }

  self _meth_8251("face angle", var_6);
  _id_0009::_id_1C45(var_0, var_1);
}

_id_DBB1(var_0, var_1, var_2, var_3) {
  var_4 = _id_0009::_id_1C6C(var_0, var_2);
  var_5 = _id_0009::_id_1C6E(var_2, var_4);
  var_6 = _func_00B0(var_5);
  var_7 = _func_0135(var_6);
  var_8 = distancesquared(self.origin, self._id_0B67._id_03D5.origin);
  return var_7 <= var_8 + 1;
}

_id_0E0E(var_0, var_1, var_2) {
  self._id_0B67._id_03D5 = undefined;
}

_id_DB0A(var_0, var_1, var_2, var_3) {
  var_4 = self._id_0345;

  if(!isDefined(var_4)) {
    var_4 = self._id_011F;
  }

  var_5 = self._id_0B67._id_03D5.type;

  if(isDefined(var_5) && (var_5 == "Cover Crouch" || var_5 == "Cover Crouch Window" || var_5 == "Conceal Crouch")) {
    var_6 = getDvar("#x3657f39fbcd013f07");

    if(isDefined(self._id_02ED._id_3DD8)) {
      var_5 = self._id_02ED._id_3DD8;
    } else if(var_6 != "") {
      var_5 = var_6;
    }
  }

  if(isDefined(var_3) && var_5 != var_3) {
    return 0;
  }

  var_7 = _id_0009::_id_1C6C(var_0, var_2);
  var_8 = _id_0009::_id_1C6E(var_1, var_7);
  var_9 = self._id_0B67._id_03D5.origin - self.origin;
  var_10 = vectornormalize(var_9);
  var_11 = _func_00B0(var_8, 0, 1);
  var_12 = length(var_11);
  var_13 = self._id_0B67._id_03D5.origin - var_10 * var_12;
  var_9 = var_13 - self.origin;
  var_14 = self._id_0B67._id_03D5.origin - var_4.origin;
  var_14 = (var_14[0], var_14[1], 0);

  if(vectordot(var_14, var_9) <= 0) {
    return 1;
  }

  if(_func_0134(self._id_04DF) > 1 && vectordot(var_10, self._id_04DF) <= 0) {
    return 1;
  }

  return 0;
}

_id_B8D7(var_0, var_1, var_2) {
  self._id_0DDF._id_1C03 = var_1;
  var_3 = _id_0009::_id_1C5C(var_0, var_1);
  var_4 = _id_0009::_id_1C6E(var_1, var_3);
  self _meth_85ED(var_1, var_3);
  _id_0009::_id_1C8E(var_0, var_1, var_4);
  var_5 = _func_00B0(var_4);
  var_6 = _func_0078(var_4);

  if(isDefined(self._id_0B67._id_03D5)) {
    var_7 = self._id_0B67._id_03D5;
  } else {
    var_7 = self._id_02ED;
  }

  if(isDefined(var_7)) {
    var_8 = var_7.origin;
    var_9 = (0, _id_08F1::_id_6B9D(var_7), 0);
    var_10 = _func_0047(var_9, _func_00FF(var_6));
    var_11 = var_7.origin - rotatevector(var_5, var_10);
  } else {
    var_8 = self.origin + var_5;
    var_9 = _func_0047(self.angles, var_6);
    var_11 = self.origin;
    var_10 = self.angles;
  }

  var_12 = int(1000 * _func_0079(var_4) - 200);
  self _meth_83D9();
  self _meth_85FB(var_11, var_10, var_8, var_9, var_12);
  _id_0009::_id_1C45(var_0, var_1);
}

_id_B8D8(var_0, var_1, var_2) {
  self._id_0B67._id_03D5 = undefined;
  self._id_0B67._id_DD07 = undefined;
  self _meth_8616();
}

_id_3DEE(var_0) {
  scripts\anim\notetracks::_id_A604(var_0);
  return undefined;
}

_id_3DED(var_0, var_1, var_2) {
  _id_B371(var_0, var_1, var_2);
}

_id_3DC4(var_0, var_1, var_2, var_3) {
  self._id_2C5E._id_011B._id_3DC3 = undefined;
  var_4 = (self._id_0192.origin + scripts\anim\utility_common::_id_69FC()) / 2;
  var_5 = anim._id_1C30[var_0]._id_E75E[var_2];
  var_6 = scripts\engine\utility::array_randomize(var_5._id_F49D);
  var_7 = undefined;

  foreach(var_9 in var_6) {
    var_7 = var_9._id_DBFD;

    if(var_7 == "up") {
      break;
    }

    var_10 = scripts\anim\utility_common::_id_698C(self._id_02ED, var_7);
    var_11 = self._id_02ED.origin + var_10;

    if(_func_0202(var_11, var_4, 0, undefined)) {
      break;
    }
  }

  self._id_2C5E._id_011B._id_3DC3 = var_0 + "_" + var_2 + "_" + var_7;
  return 1;
}

_id_3DC2(var_0, var_1, var_2, var_3) {
  var_4 = var_0 + "_" + var_1 + "_" + var_3;
  return var_4 == self._id_2C5E._id_011B._id_3DC3;
}

_id_87CC(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_3) || !isDefined(self._id_02ED) || !isDefined(self._id_02ED.type)) {
    return 0;
  }

  return self._id_02ED.type == var_3;
}

_id_87CB(var_0, var_1, var_2, var_3) {
  if(_id_06BD::_id_23CF()) {
    return 1;
  }

  return 0;
}

_id_34ED(var_0, var_1, var_2, var_3) {
  if(!_id_06BD::_id_23CF()) {
    return 0;
  }

  var_4 = _id_06BD::_id_23BC();
  [var_6, var_7] = _id_06BD::_id_23C4();

  if(var_7 != var_3) {
    return 0;
  }

  self._id_1C30._id_3DEA = spawnStruct();
  self._id_1C30._id_3DEA._id_C571 = var_6;
  self._id_1C30._id_3DEA._id_C572 = var_7;
  return 1;
}

_id_5B14(var_0, var_1, var_2) {
  var_3 = self._id_1C30._id_3DEA._id_C571;
  var_4 = self._id_1C30._id_3DEA._id_C572;
  self._id_1C30._id_3DEA._id_C571 _meth_80BA(var_4);
  self._id_1C30._id_3DEA = undefined;
  _id_3931(var_0, var_1, var_2);
}

_id_A1BF(var_0, var_1, var_2, var_3) {
  var_4 = weaponclass(self._id_034C);

  if(istrue(self._id_C57B) && var_4 == "mg") {
    self._id_C57B = 0;
    return 1;
  }

  return 0;
}