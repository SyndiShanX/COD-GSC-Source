/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3182.gsc
**************************************/

_id_D46F(var_0, var_1, var_2, var_3) {
  scripts\anim\combat::_id_F296();
  var_4 = self._id_164D[var_0];

  if(isDefined(var_4._id_10E23) && (var_4._id_10E23 == "stand_run_loop" || var_4._id_10E23 == "stand_run_strafe_loop"))
    childthread scripts\asm\shared\utility::setuseanimgoalweight(var_1, var_2);

  thread _id_899F(var_1);

  if(!self.fixednode)
    self animmode("physics_drift");

  if(isDefined(self.node)) {
    self._id_A984 = self.node.origin;
    self._blackboard._id_AA3D = self.node;
  } else if(isDefined(self.pathgoalpos))
    self._id_A984 = self.pathgoalpos;
  else
    self._id_A984 = self.origin;

  thread _id_0A1E::_id_235F(var_0, var_1, var_2, 1.0);
  thread _id_CEA2(var_1, var_2, var_3, 1.0);
  thread _id_8983(var_1);
}

_id_3E9B(var_0, var_1, var_2) {
  return scripts\asm\asm::asm_lookupanimfromalias(var_1, "casual_idle");
}

_id_8983(var_0) {
  self endon("death");
  self endon(var_0 + "_finished");
  self notify("HandleCasualTransition");
  self endon("HandleCasualTransition");

  for(;;) {
    if(self._blackboard.movetype == "casual" && _id_100AF()) {
      self notify("handleExposedOrientation");
      self animmode("normal");

      if(ispointonnavmesh3d(self.origin, self))
        self orientmode("face motion");
      else {
        var_1 = getclosestpointonnavmesh3d(self.origin, self);
        self orientmode("face point", var_1);
      }
    }

    wait 0.05;
  }
}

_id_899F(var_0) {
  self endon("death");
  self endon(var_0 + "_finished");
  self notify("handleExposedOrientation");
  self endon("handleExposedOrientation");
  waittillframeend;

  if(scripts\engine\utility::is_true(self._id_B3E9) && isDefined(self.node))
    self orientmode("face angle 3d", self.node.angles);
  else {
    if(scripts\engine\utility::is_true(self._id_C010) || self.fixednode) {
      self orientmode("face angle 3d", self.angles);
      return;
    }

    var_1 = randomfloatrange(0.003, 0.011);
    thread _id_89F9(var_0, "handleExposedOrientation", var_1);

    if(isDefined(self.enemy)) {
      var_2 = 0.3333;

      if(randomfloat(1) < var_2) {
        if(isPlayer(self.enemy))
          var_3 = self.enemy getplayerangles();
        else
          var_3 = self.enemy.angles;

        var_4 = (self.angles[0], self.angles[1], -1 * var_3[2]);
        self orientmode("face angle 3d", var_4);
        return;
      }
    }

    var_5 = 0.5;

    if(randomfloat(1) < var_5) {
      var_6 = scripts\engine\utility::random([-1, 1]);

      for(;;) {
        var_4 = self.angles + (0, 0, 50) * var_6;
        self orientmode("face angle 3d", var_4);
        wait 0.5;
      }

      return;
    }

    self orientmode("face angle 3d", self.angles);
  }
}

_id_89F9(var_0, var_1, var_2) {
  self endon("death");
  self._id_C406 = self.turnrate;
  self.turnrate = var_2;

  if(isDefined(var_1))
    scripts\engine\utility::waittill_any(var_0 + "_finished", var_1);
  else
    self waittill(var_0 + "_finished");

  self.turnrate = self._id_C406;
}

_id_D569(var_0, var_1, var_2, var_3) {
  scripts\sp\gameskill::_id_54C4();
  var_4 = _id_0A1E::asm_getallanimsforstate(var_0, var_1);
  self clearanim(_id_0A1E::asm_getbodyknob(), var_2);

  if(scripts\engine\utility::actor_is3d() && isDefined(self.enemy))
    self orientmode("face point", self.enemy.origin);
  else
    self orientmode("face angle 3d", self.angles);

  if(self.fixednode) {
    if(isDefined(self.node))
      self animmode("angle deltas");
    else
      self animmode("zonly_physics");
  }

  _id_0A1E::_id_2369(var_0, var_1, var_4);
  self _meth_82E7(var_1, var_4, 1, var_2, 1);
  _id_0A1E::_id_231F(var_0, var_1);
}

_id_CEB5(var_0, var_1, var_2, var_3) {
  var_4 = _id_0A1E::asm_getallanimsforstate(var_0, var_1);
  self.asm._id_4C86._id_697F = undefined;

  if(scripts\engine\utility::is_true(self._id_28CF)) {
    var_5 = 1;
    _id_BCF9(var_5);
    scripts\anim\battlechatter::_id_CEE8();
  }

  if(!isDefined(var_4)) {
    scripts\asm\asm::asm_fireevent(var_1, "code_move", undefined);
    scripts\asm\asm::asm_fireevent(var_1, "end", undefined);
    scripts\asm\asm::asm_fireevent(var_1, "finish", undefined);
    return;
  }

  _id_D53A(var_0, var_1, var_4, var_2);
}

_id_128AD(var_0, var_1, var_2, var_3) {
  var_4 = self.asm._id_A961;

  if(isDefined(var_4) && var_4.type == "Cover 3D") {
    if(isDefined(var_4.script_parameters)) {
      var_5 = strtok(var_4.script_parameters, "|");
      var_6 = _id_8161(var_1, var_3);

      if(var_6 == "5T") {
        if(scripts\engine\utility::array_contains(var_5, "special_exit_up")) {
          var_7 = scripts\asm\asm::asm_lookupanimfromalias(var_1, "5T_Special");
          _id_D53A(var_0, var_1, var_7, var_2);
          return 1;
        }
      } else if(var_6 == "4M") {
        if(scripts\engine\utility::array_contains(var_5, "special_exit_left")) {
          var_7 = scripts\asm\asm::asm_lookupanimfromalias(var_1, "4M_Special");
          _id_D53A(var_0, var_1, var_7, var_2);
          return 1;
        }
      } else if(var_6 == "6M") {
        if(scripts\engine\utility::array_contains(var_5, "special_exit_right")) {
          var_7 = scripts\asm\asm::asm_lookupanimfromalias(var_1, "6M_Special");
          _id_D53A(var_0, var_1, var_7, var_2);
          return 1;
        }
      }
    }
  }

  return 0;
}

_id_CEB4(var_0, var_1, var_2, var_3) {
  self.asm._id_4C86._id_697F = undefined;
  self clearanim(_id_0A1E::asm_getbodyknob(), var_2);

  if(scripts\engine\utility::is_true(self._id_28CF)) {
    var_4 = 1;
    _id_BCF9(var_4);
    scripts\anim\battlechatter::_id_CEE8();
  }

  if(_id_128AD(var_0, var_1, var_2, var_3)) {
    return;
  }
  var_5 = isDefined(var_3) && var_3 == "noForward";
  var_6 = _id_8250(var_1, undefined, var_5);
  _id_CEF4(var_0, var_1, var_2, var_6);
}

_id_38F1(var_0, var_1, var_2, var_3) {
  if(isarray(var_3))
    var_4 = var_3[0];
  else
    var_4 = var_3;

  if(!transitionlightcolor(var_3, 1))
    return 0;

  return _id_3E0B(var_4);
}

_id_BD24(var_0, var_1, var_2) {
  if(var_0 == "is")
    return var_1 == var_2;
  else if(var_0 == "not")
    return var_1 != var_2;
  else {}
}

transitionlightcolor(var_0, var_1) {
  if(isarray(var_0) && isDefined(var_0[var_1]) && isstring(var_0[var_1]) && var_0[var_1] == "moveType") {
    if(isDefined(self._id_13EE5)) {
      var_1++;

      if(!_id_BD24(var_0[var_1], var_0[var_1 + 1], self._id_13EE5))
        return 0;
    }
  }

  return 1;
}

_id_38EF(var_0, var_1, var_2, var_3) {
  var_4 = 0;
  var_5 = undefined;

  if(isnumber(var_3[var_4])) {
    var_5 = var_3[var_4];
    var_4++;
  }

  if(!transitionlightcolor(var_3, var_4))
    return 0;

  if(isDefined(var_5)) {
    var_6 = self.lookaheaddist;

    if(var_6 < var_5)
      return 0;
  }

  return 1;
}

_id_8250(var_0, var_1, var_2) {
  var_3 = !scripts\engine\utility::is_true(var_2);
  var_4 = ["F", "B", "L", "R", "2B", "2T", "4B", "4T", "5B", "5T", "6B", "6T", "8B", "8T"];
  var_5 = [];

  foreach(var_7 in var_4) {
    var_5[var_7] = spawnStruct();
    var_5[var_7]._id_2CB7 = scripts\asm\asm::asm_lookupanimfromalias(var_0, var_7);
    var_5[var_7]._id_51DE = getmovedelta(var_5[var_7]._id_2CB7);
    var_5[var_7]._id_51DF = length(var_5[var_7]._id_51DE);
    var_5[var_7].weight = 0;
    var_5[var_7].string = var_7;
  }

  var_9 = anglestoaxis(self.angles);

  if(isDefined(var_1))
    var_10 = vectorNormalize(var_1);
  else {
    if(!isDefined(self.pathgoalpos))
      var_11 = self.origin + var_9["up"] * 100;
    else
      var_11 = self.origin + self.lookaheaddir * self.lookaheaddist;

    var_10 = vectorNormalize(var_11 - self.origin);

    if(var_2) {
      var_12 = vectordot(var_10, var_9["forward"]);

      if(var_12 > 0.996) {
        var_10 = vectorNormalize(self _meth_845C(10) - self.origin);

        if(vectordot(var_10, var_9["forward"]) > 0.996)
          var_10 = var_9["up"];
      } else if(var_12 > 0)
        var_10 = scripts\sp\math::_id_13198(var_10, var_9["forward"]);
    }
  }

  var_13 = [];

  if(var_3)
    var_13["F"] = vectorNormalize(var_9["forward"]);

  var_13["B"] = vectorNormalize(-1 * var_9["forward"]);
  var_13["R"] = vectorNormalize(var_9["right"]);
  var_13["L"] = vectorNormalize(-1 * var_9["right"]);
  var_14 = [];

  foreach(var_19, var_16 in var_13) {
    var_17 = acos(clamp(vectordot(var_10, var_16), -1.0, 1.0));
    var_18 = 90 - var_17;
    var_14[var_19] = var_18 / 90;
  }

  var_20["2T"] = vectorNormalize(var_9["up"] + -1 * var_9["forward"]);
  var_20["4T"] = vectorNormalize(var_9["up"] + -1 * var_9["right"]);
  var_20["5T"] = vectorNormalize(var_9["up"]);
  var_20["6T"] = vectorNormalize(var_9["up"] + var_9["right"]);

  if(var_3)
    var_20["8T"] = vectorNormalize(var_9["up"] + var_9["forward"]);

  var_20["2B"] = vectorNormalize(-1 * var_9["up"] + -1 * var_9["forward"]);
  var_20["4B"] = vectorNormalize(-1 * var_9["up"] + -1 * var_9["right"]);
  var_20["5B"] = vectorNormalize(-1 * var_9["up"]);
  var_20["6B"] = vectorNormalize(-1 * var_9["up"] + var_9["right"]);

  if(var_3)
    var_20["8B"] = vectorNormalize(-1 * var_9["up"] + var_9["forward"]);

  foreach(var_19, var_16 in var_20) {
    var_17 = acos(clamp(vectordot(var_10, var_16), -1.0, 1.0));
    var_18 = 45 - var_17;
    var_14[var_19] = var_18 / 45;
  }

  var_22 = [];
  var_23 = 99999;
  var_24 = 0;

  foreach(var_19, var_26 in var_14) {
    if(var_26 > 0.01) {
      var_22[var_19] = var_26;

      if(var_26 > var_24)
        var_24 = var_26;

      if(var_5[var_19]._id_51DF < var_23)
        var_23 = var_5[var_19]._id_51DF;
    }
  }

  var_27 = [];

  foreach(var_19, var_26 in var_22)
  var_27[var_19] = var_26 * (1 / var_24);

  var_29 = [];

  foreach(var_19, var_26 in var_27)
  var_29[var_19] = var_26 * (var_23 / var_5[var_19]._id_51DF);

  foreach(var_19, var_26 in var_29)
  var_5[var_19].weight = var_26;

  return var_5;
}

_id_3E9F(var_0, var_1, var_2) {
  if(!_id_3E09())
    var_3 = scripts\asm\asm::asm_lookupanimfromalias(var_1, "5T_Short");
  else
    var_3 = _id_53CA(var_1, var_2);

  return var_3;
}

_id_8161(var_0, var_1) {
  var_2 = scripts\anim\exit_node::_id_7EA3();
  var_3 = self.origin + self.lookaheaddir * self.lookaheaddist;
  var_4 = vectortoangles(var_3 - self.origin);

  if(_id_0F3D::_id_C057(var_2))
    var_5 = var_2.angles;
  else
    var_5 = self.angles;

  var_6 = anglesToForward(var_4);
  var_7 = anglestoup(var_5);
  var_8 = vectordot(var_6, var_7);

  if(var_8 > 0.966) {
    var_9 = undefined;
    var_10 = 5;
    var_11 = 0;
  } else if(var_8 < -0.9666) {
    var_9 = undefined;
    var_10 = 5;
    var_11 = 8;
  } else {
    var_12 = combineangles(invertangles(var_5), var_4);
    var_13 = angleclamp180(var_12[1]);
    var_14 = angleclamp180(var_12[0]);
    var_9 = getangleindex(var_13, 22.5);
    var_10 = _id_8014(var_9);
    var_11 = getangleindex(var_14, 22.5);
  }

  if(var_11 == 4)
    var_15 = "M";
  else if(var_11 > 4)
    var_15 = "B";
  else
    var_15 = "T";

  if(isDefined(var_1) && !isarray(var_1) && (var_1 == "Cover Stand 3D" || var_1 == "Cover Exposed 3D")) {
    if(var_15 == "B") {
      if(var_10 == 5)
        var_15 = "T";
      else
        var_15 = "M";
    }

    if(var_10 == 7)
      var_10 = 4;

    if(var_10 == 9)
      var_10 = 6;

    if(var_10 == 8) {
      var_10 = 5;
      var_15 = "T";
    }
  }

  var_16 = var_10 + var_15;
  return var_16;
}

_id_53CA(var_0, var_1) {
  var_2 = _id_8161(var_0, var_1);
  var_3 = scripts\asm\asm::asm_lookupanimfromalias(var_0, var_2);
  return var_3;
}

_id_8014(var_0) {
  var_1 = [2, 3, 6, 9, 8, 7, 4, 1, 2];
  return var_1[var_0];
}

_id_899E(var_0, var_1) {
  if(var_0 == "exit_align" || var_0 == "corner") {
    var_2 = var_1;
    var_3 = self _meth_845C(36);
    var_4 = vectortoangles(var_3 - self.origin);
    var_5 = self islegacyagent(var_2);
    var_6 = getangledelta3d(var_2, var_5, 1);
    self orientmode("face angle", angleclamp180(var_4[1] - var_6[1]));
  }
}

_id_D53A(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  self animmode("nogravity", 0);
  childthread scripts\asm\shared\utility::setuseanimgoalweight(var_1, var_3);
  _id_0A1E::_id_2369(var_0, var_1, var_2);
  self _meth_82E4(var_1, var_2, _id_0A1E::asm_getbodyknob(), 1, var_3, self.moveplaybackrate);
  _id_0A1E::_id_231F(var_0, var_1, ::_id_899E, var_2, undefined, 1);
}

_id_CEF4(var_0, var_1, var_2, var_3, var_4) {
  self endon(var_1 + "_finished");
  self orientmode("face angle 3d", self.angles);
  childthread scripts\asm\shared\utility::setuseanimgoalweight(var_1, var_2);
  var_5 = self.moveplaybackrate;

  if(isDefined(var_4))
    var_5 = var_4;

  var_3 = scripts\anim\utility_common::sortandcullanimstructarray(var_3);

  for(var_6 = 0; var_6 < var_3.size; var_6++) {
    var_7 = var_3[var_6];
    var_8 = var_1 + "_" + var_7.string;
    self _meth_82EA(var_8, var_7._id_2CB7, var_7.weight, var_2, var_5);

    if(var_6 == var_3.size - 1)
      _id_0A1E::_id_231F(var_0, var_1, undefined, undefined, var_8);
  }
}

_id_8BF5() {
  if(scripts\engine\utility::is_true(self._id_55ED))
    return 0;

  if(!isDefined(self.pathgoalpos))
    return 0;

  return 1;
}

_id_3E0B(var_0) {
  if(!_id_8BF5())
    return 0;

  if(self.lookaheaddist < var_0)
    return 0;

  return 1;
}

_id_3E09() {
  if(!_id_8BF5())
    return 0;

  if(distancesquared(self.origin, self.pathgoalpos) < 10000)
    return 0;

  return 1;
}

_id_3EBF(var_0, var_1, var_2, var_3) {
  return self.a._id_FC61;
}

_id_FFE8(var_0, var_1, var_2, var_3) {
  if(scripts\engine\utility::is_true(self.noturnanims))
    return 0;

  if(scripts\engine\utility::is_true(self._id_932E))
    return 0;

  var_4 = scripts\asm\asm::_id_233F(var_1, "sharp_turn");

  if(!isDefined(var_4))
    return 0;

  if(gettime() - var_4._id_7686 > 100)
    return 0;

  var_5 = var_3[0];
  var_6 = var_3[1];

  if(!transitionlightcolor(var_3, 2))
    return 0;

  var_7 = var_4.params[1];
  var_8 = var_4.params[2];
  var_9 = var_4.params[3];

  if(var_9 < var_6)
    return 0;

  self.a._id_FC61 = _id_8250(var_5, var_7);
  return 1;
}

_id_CEF6(var_0, var_1, var_2, var_3) {
  var_4 = _id_0A1E::asm_getallanimsforstate(var_0, var_1);
  self.a._id_FC61 = undefined;
  self clearanim(_id_0A1E::asm_getbodyknob(), var_2);
  var_5 = vectordot(vectorNormalize(self.velocity), self.lookaheaddir);
  var_6 = clamp(var_5, -0.5, 1.0);
  var_7 = (var_6 + 0.5) / 1.5;
  var_8 = scripts\sp\math::_id_AB6F(0.6, 1.0, var_7);
  var_8 = var_8 * self.moveplaybackrate;
  _id_CEF4(var_0, var_1, var_2, var_4, var_8);
}

_id_11080(var_0, var_1, var_2) {
  self._id_13EE7 = undefined;
}

_id_D4E4(var_0, var_1, var_2, var_3) {
  thread _id_0F3D::_id_136B4(var_0, var_1, var_3);
  thread _id_0F3D::_id_136E7(var_0, var_1, var_3);
  var_4 = scripts\asm\asm::asm_getmoveplaybackrate();
  var_5 = 0;

  if(isDefined(var_3) && isarray(var_3)) {
    foreach(var_7 in var_3) {
      if(isstring(var_7) && var_7 == "onlyForwardWalk")
        var_5 = 1;
    }
  }

  _id_98A1(var_1, var_2, var_4, var_5);
  thread _id_BCFB(var_1, var_2, var_5);
  thread _id_CEA2(var_1, var_2, var_3, var_4);
}

_id_98A1(var_0, var_1, var_2, var_3) {
  self.asm._id_A961 = undefined;
  self _meth_84F1(var_2);

  if(isDefined(self._id_72CF))
    self orientmode("face angle 3d", self._id_72CF);
  else if(var_3)
    self orientmode("face motion");
  else
    self orientmode("face enemy or motion");

  var_4 = _id_0A1E::asm_getbodyknob();
  self clearanim(var_4, var_1);

  if(scripts\asm\asm::asm_hasalias("Knobs", "move")) {
    var_5 = _id_0A1E::_id_2356("Knobs", "move");
    self _meth_84F2(var_5);
  }

  var_6 = undefined;

  if(var_3)
    var_6 = "walk";
  else if(isDefined(self._id_13EE5))
    var_6 = self._id_13EE5;
  else {
    var_7 = self pathdisttogoal();

    if(var_7 >= self._id_13887)
      var_6 = "run";
    else
      var_6 = "walk";
  }

  var_8 = undefined;
  var_9 = undefined;
  var_10 = undefined;
  var_11 = undefined;
  var_12 = undefined;
  var_13 = undefined;

  if(var_6 == "run") {
    self._id_13EE7 = "run";
    var_8 = scripts\asm\asm::asm_lookupanimfromalias(var_0, "f_run");
    var_9 = scripts\asm\asm::asm_lookupanimfromalias(var_0, "l_run");
    var_10 = scripts\asm\asm::asm_lookupanimfromalias(var_0, "r_run");
    var_11 = scripts\asm\asm::asm_lookupanimfromalias(var_0, "b_run");
    var_12 = scripts\asm\asm::asm_lookupanimfromalias(var_0, "u_run");
    var_13 = scripts\asm\asm::asm_lookupanimfromalias(var_0, "d_run");
  } else if(var_6 == "walk") {
    self._id_13EE7 = "walk";
    var_8 = scripts\asm\asm::asm_lookupanimfromalias(var_0, "f_walk");

    if(!var_3) {
      var_9 = scripts\asm\asm::asm_lookupanimfromalias(var_0, "l_walk");
      var_10 = scripts\asm\asm::asm_lookupanimfromalias(var_0, "r_walk");
      var_11 = scripts\asm\asm::asm_lookupanimfromalias(var_0, "b_walk");
      var_12 = scripts\asm\asm::asm_lookupanimfromalias(var_0, "u_walk");
      var_13 = scripts\asm\asm::asm_lookupanimfromalias(var_0, "d_walk");
    }
  } else {}

  self _meth_82A9(var_8, 1, var_1, 1.0, 1);

  if(!var_3) {
    self _meth_82A9(var_11, 1, var_1, 1.0, 1);
    self _meth_82A9(var_10, 1, var_1, 1.0, 1);
    self _meth_82A9(var_9, 1, var_1, 1.0, 1);
    self _meth_82A9(var_12, 1, var_1, 1.0, 1);
    self _meth_82A9(var_13, 1, var_1, 1.0, 1);
  }
}

_id_BCFB(var_0, var_1, var_2) {
  self endon(var_0 + "_finished");

  if(var_2) {
    var_3 = scripts\asm\asm::asm_lookupanimfromalias(var_0, "f_knob");

    for(;;) {
      self _meth_82A2(var_3, 1.0, var_1, 1.0, 1);
      wait 0.05;
      waittillframeend;
    }
  } else {
    var_3 = scripts\asm\asm::asm_lookupanimfromalias(var_0, "f_knob");
    var_4 = scripts\asm\asm::asm_lookupanimfromalias(var_0, "l_knob");
    var_5 = scripts\asm\asm::asm_lookupanimfromalias(var_0, "r_knob");
    var_6 = scripts\asm\asm::asm_lookupanimfromalias(var_0, "b_knob");
    var_7 = scripts\asm\asm::asm_lookupanimfromalias(var_0, "u_knob");
    var_8 = scripts\asm\asm::asm_lookupanimfromalias(var_0, "d_knob");

    for(;;) {
      var_9 = _id_8251(self _meth_84F6());
      self _meth_82A2(var_3, var_9["front"], var_1, 1.0, 1);
      self _meth_82A2(var_6, var_9["back"], var_1, 1.0, 1);
      self _meth_82A2(var_4, var_9["left"], var_1, 1.0, 1);
      self _meth_82A2(var_5, var_9["right"], var_1, 1.0, 1);
      self _meth_82A2(var_7, var_9["up"], var_1, 1.0, 1);
      self _meth_82A2(var_8, var_9["down"], var_1, 1.0, 1);
      wait 0.05;
      waittillframeend;
    }
  }
}

_id_CEA2(var_0, var_1, var_2, var_3) {
  self endon(var_0 + "_finished");
  wait 0.05;
  var_4 = 0.75;

  for(var_5 = 0; var_5 < var_2.size; var_5++) {
    if(var_2[var_5] == "additive_leg_anim_chance") {
      var_4 = var_2[var_5 + 1];
      break;
    }
  }

  var_6 = _func_2EE(self.asm.archetype, var_0, "additive_leg_anims", 0);

  if(!isDefined(var_6)) {}

  if(!isarray(var_6.anims))
    var_7 = [var_6.anims];
  else
    var_7 = var_6.anims;

  var_8 = 0;

  foreach(var_10 in var_7)
  var_8 = var_8 + getanimlength(var_10);

  var_12 = var_8 / var_7.size;
  thread _id_41C2(var_0);

  for(;;) {
    if(randomfloat(1.0) < var_4) {
      var_13 = scripts\asm\asm::asm_lookupanimfromalias(var_0, "additive_leg_anims");
      var_14 = getanimlength(var_13);
      self _meth_82EA(var_0, var_13, 1, var_1, var_3);
      wait(var_14);
      self clearanim(var_13, var_1);
      continue;
    }

    wait(var_12);
  }
}

_id_41C2(var_0) {
  self endon("death");
  self waittill(var_0 + "_finished");
  var_1 = _id_0A1E::_id_2356(var_0, "add_idle_legs");
  self clearanim(var_1, 0.2);
}

_id_8251(var_0) {
  var_1 = cos(var_0[1]);
  var_2 = sin(var_0[1]);
  var_3 = sin(var_0[0]);
  var_4["front"] = 0;
  var_4["right"] = 0;
  var_4["back"] = 0;
  var_4["left"] = 0;
  var_4["up"] = 0;
  var_4["down"] = 0;

  if(var_1 > 0)
    var_4["front"] = var_1;
  else
    var_4["back"] = -1 * var_1;

  if(var_2 > 0)
    var_4["left"] = var_2;
  else
    var_4["right"] = -1 * var_2;

  if(var_3 > 0)
    var_4["down"] = var_3;
  else
    var_4["up"] = -1 * var_3;

  return var_4;
}

_id_BCF9(var_0) {
  var_1 = scripts\asm\asm::asm_getdemeanor();

  if(var_1 == "frantic" || var_1 == "combat" || var_1 == "sprint")
    scripts\anim\battlechatter_ai::_id_67D2(var_0);
}

_id_100AF(var_0, var_1, var_2, var_3) {
  if(isDefined(var_3) && var_3 == "requireOrientToMoveDir" && scripts\asm\asm_bb::bb_moverequested()) {
    var_4 = anglesToForward(self.angles);

    if(ispointonnavmesh3d(self.origin, self))
      var_5 = self.lookaheaddir;
    else {
      var_6 = getclosestpointonnavmesh3d(self.origin, self);
      var_5 = vectorNormalize(var_6 - self.origin);
    }

    var_7 = vectordot(var_4, var_5);

    if(var_7 < 0.996)
      return 0;
  }

  if(scripts\asm\asm_bb::bb_meleechargerequested())
    return 1;

  if(self._blackboard.movetype == "combat" || self._blackboard.movetype == "casual") {
    if(scripts\asm\asm_bb::bb_moverequested()) {
      if(isDefined(self._id_A984) && distancesquared(self.pathgoalpos, self._id_A984) < 4.0) {
        if(distancesquared(self.pathgoalpos, self.origin) > 90000)
          return 1;

        if(length(self.velocity) < 3.0)
          return 1;
      } else {
        if(distancesquared(self.pathgoalpos, self.origin) > 4.0)
          return 1;

        return 0;
      }
    }
  }

  return 0;
}

_id_100AE(var_0, var_1, var_2, var_3) {
  if(isDefined(self.pathgoalpos)) {
    var_4 = self pathdisttogoal();

    if(var_4 > 4 && var_4 < 60) {
      if(navisstraightlinereachable3d(self.origin, self.pathgoalpos, self))
        return 1;
    }
  }

  return 0;
}

_id_100B0(var_0, var_1, var_2, var_3) {
  if(isDefined(self.node) && self.node.type != "Exposed 3D")
    return 0;

  if(!scripts\asm\asm_bb::bb_moverequested() || distancesquared(self.pathgoalpos, self.origin) < 16)
    return 1;

  if(!self.fixednode && !isDefined(self._id_DD0B) && distancesquared(self.pathgoalpos, self.origin) < 1024)
    return 1;

  return 0;
}

_id_FFB3(var_0, var_1, var_2, var_3) {
  if(!_id_FF0C(var_0, var_1, var_2, var_3))
    return 1;

  if(!scripts\asm\asm_bb::bb_movetyperequested("combat"))
    return 1;

  if(scripts\asm\asm_bb::bb_meleechargerequested(var_0, var_1, var_2, var_3))
    return 1;

  return 0;
}

_id_FF0C(var_0, var_1, var_2, var_3) {
  return !self.facemotion && !self._blackboard.alwaysrunforward;
}

shouldreload(var_0, var_1, var_2, var_3) {
  if(!scripts\asm\asm_bb::bb_reloadrequested())
    return 0;

  var_4 = self pathdisttogoal();
  return var_4 > 512;
}