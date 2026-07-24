/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3173.gsc
**************************************/

_id_CEB5(var_0, var_1, var_2, var_3) {
  var_4 = _id_0A1E::asm_getallanimsforstate(var_0, var_1);
  self.asm._id_4C86._id_697F = undefined;

  if(isDefined(self._id_28CF) && self._id_28CF) {
    var_5 = issubstr(var_1, "cover");
    _id_BCF9(var_5);
  }

  if(!isDefined(var_4)) {
    scripts\asm\asm::asm_fireevent(var_1, "abort");
    scripts\asm\asm::asm_fireevent(var_1, "code_move", undefined);
    scripts\asm\asm::asm_fireevent(var_1, "end", undefined);
    scripts\asm\asm::asm_fireevent(var_1, "finish", undefined);
    return;
  }

  var_6 = 0;

  if(isDefined(var_3)) {
    var_6 = var_3;
  }

  _id_D53A(var_0, var_1, var_4, var_2, var_6);
}

_id_3E9F(var_0, var_1, var_2) {
  if(!_id_3E57()) {
    return undefined;
  }

  var_3 = undefined;
  var_4 = 0;

  if(isarray(var_2) && isDefined(var_2[1])) {
    var_4 = var_2[1];
  }

  if(isDefined(var_2) && isarray(var_2) && isDefined(var_2[0])) {
    var_3 = _id_53CA(var_1, scripts\asm\asm_bb::_id_2928(var_2[0]), var_4);
  } else if(isDefined(var_2) && !isarray(var_2)) {
    var_3 = _id_53CA(var_1, scripts\asm\asm_bb::_id_2928(var_2), var_4);
  } else {
    var_3 = _id_53CA(var_1, undefined, var_4);
  }

  return var_3;
}

_id_8162(var_0, var_1) {
  var_2 = [];
  var_3 = "";

  if(isDefined(var_1)) {
    var_3 = var_1;
  }

  var_4 = "";

  if(isDefined(self.asm._id_13CAF) && self.asm._id_13CAF) {
    if(scripts\asm\asm::asm_hasalias(var_0, var_3 + "2_2h")) {
      var_4 = "_2h";
    }
  }

  if(scripts\asm\asm::asm_hasalias(var_0, var_3 + "1" + var_4)) {
    var_2[7] = ::scripts\asm\asm::asm_lookupanimfromalias(var_0, var_3 + "1" + var_4);
  }

  if(scripts\asm\asm::asm_hasalias(var_0, var_3 + "2" + var_4)) {
    var_2[0] = ::scripts\asm\asm::asm_lookupanimfromalias(var_0, var_3 + "2" + var_4);
    var_2[8] = var_2[0];
  }

  if(scripts\asm\asm::asm_hasalias(var_0, var_3 + "3" + var_4)) {
    var_2[1] = ::scripts\asm\asm::asm_lookupanimfromalias(var_0, var_3 + "3" + var_4);
  }

  if(scripts\asm\asm::asm_hasalias(var_0, var_3 + "4" + var_4)) {
    var_2[6] = ::scripts\asm\asm::asm_lookupanimfromalias(var_0, var_3 + "4" + var_4);
  }

  if(scripts\asm\asm::asm_hasalias(var_0, var_3 + "6" + var_4)) {
    var_2[2] = ::scripts\asm\asm::asm_lookupanimfromalias(var_0, var_3 + "6" + var_4);
  }

  if(scripts\asm\asm::asm_hasalias(var_0, var_3 + "7" + var_4)) {
    var_2[5] = ::scripts\asm\asm::asm_lookupanimfromalias(var_0, var_3 + "7" + var_4);
  }

  if(scripts\asm\asm::asm_hasalias(var_0, var_3 + "8" + var_4)) {
    var_2[4] = ::scripts\asm\asm::asm_lookupanimfromalias(var_0, var_3 + "8" + var_4);
  }

  if(scripts\asm\asm::asm_hasalias(var_0, var_3 + "9" + var_4)) {
    var_2[3] = ::scripts\asm\asm::asm_lookupanimfromalias(var_0, var_3 + "9" + var_4);
  }

  return var_2;
}

_id_8163() {
  var_0 = scripts\asm\asm::asm_getdemeanor();

  if(var_0 == "casual" || var_0 == "casual_gun") {
    return 75.0;
  }

  return 100.0;
}

_id_53CA(var_0, var_1, var_2) {
  var_3 = self _meth_8148();

  if(isDefined(var_3)) {
    var_4 = var_3.origin;
  } else {
    var_4 = self.pathgoalpos;
  }

  var_5 = scripts\anim\exit_node::_id_7EA3();

  if(self.usingnavmesh) {
    if(var_2) {
      var_6 = self.origin + self.lookaheaddir * self.lookaheaddist;
    } else {
      var_6 = self _meth_845C(128);
    }

    var_7 = vectortoangles(var_6 - self.origin);
  } else
    var_7 = vectortoangles(self.lookaheaddir);

  if(_id_0F3D::_id_C057(var_5) && !var_2) {
    var_8 = var_5.angles;
  } else {
    var_8 = self.angles;
  }

  var_9 = angleclamp180(var_7[1] - var_8[1]);

  if(length2dsquared(self.velocity) > 16) {
    var_10 = vectortoangles(self.velocity);

    if(abs(angleclamp180(var_10[1] - var_7[1])) < 45) {
      return;
    }
  }

  var_11 = _id_8163();

  if(distancesquared(var_4, self.origin) < var_11 * var_11) {
    return;
  }
  if(isDefined(self.asm._id_4C86._id_697F)) {
    var_12 = _id_8162(self.asm._id_4C86._id_697F, var_1);
  } else {
    var_12 = _id_8162(var_0, var_1);
  }

  var_13 = getangleindices(var_9);
  var_14 = self _meth_84AC();
  var_15 = undefined;
  var_16 = 0;

  for(var_16 = 0; var_16 < var_13.size; var_16++) {
    var_17 = var_13[var_16];

    if(!isDefined(var_12[var_17])) {
      continue;
    }
    var_15 = var_12[var_17];
    var_18 = 1;
    var_19 = getnotetracktimes(var_15, "code_move");

    if(var_19.size > 0) {
      var_18 = var_19[0];
    }

    var_20 = getmovedelta(var_15, 0, var_18);
    var_21 = rotatevector(var_20, self.angles) + var_14;
    var_22 = getnotetracktimes(var_15, "corner");

    if(var_22.size == 0) {
      var_22 = getnotetracktimes(var_15, "exit_align");
    }

    if(var_22.size > 0) {
      var_23 = getmovedelta(var_15, 0, var_22[0]);
      var_24 = rotatevector(var_23, self.angles) + var_14;
      var_25 = self maymovefrompointtopoint(var_24, var_21, 1, 1);

      if(var_25) {
        break;
      }

      continue;
    }

    if(self maymovefrompointtopoint(var_14, var_21, 1, 1)) {
      break;
    }
  }

  if(var_16 == var_13.size) {
    return undefined;
  }

  return var_15;
}

_id_D53A(var_0, var_1, var_2, var_3, var_4) {
  self endon(var_1 + "_finished");

  if(self.usingnavmesh) {
    var_5 = self _meth_845C(128);
    var_6 = vectortoangles(var_5 - self.origin);
  } else
    var_6 = vectortoangles(self.lookaheaddir);

  var_7 = angleclamp180(var_6[1] - self.angles[1]);
  var_8 = getnotetracktimes(var_2, "code_move");
  var_9 = 1;

  if(var_8.size > 0) {
    thread _id_0F3D::_id_136B4(var_0, var_1, undefined);
    thread _id_0F3D::_id_136E7(var_0, var_1, undefined);
    var_9 = var_8[0];
  }

  var_10 = getangledelta3d(var_2, 0, var_9);
  self animmode("zonly_physics", 0);
  childthread scripts\asm\shared\utility::setuseanimgoalweight(var_1, var_3);
  thread _id_0F3D::_id_444B(var_1);
  _id_0A1E::_id_2369(var_0, var_1, var_2);

  if(isDefined(self._id_22EE)) {
    self _meth_82E4(var_1, var_2, _id_0A1E::asm_getbodyknob(), 1, var_3, self.moveplaybackrate * self._id_22EE);
  } else {
    self _meth_82E4(var_1, var_2, _id_0A1E::asm_getbodyknob(), 1, var_3, self.moveplaybackrate);
  }

  _id_0A1E::_id_231F(var_0, var_1, ::_id_899E, var_2, undefined, 1);

  if(var_4) {
    _id_0F3D::_id_11065();
    self animmode("normal", 0);
    self orientmode("face motion");
    _id_0A1E::_id_231F(var_0, var_1);
  }
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

_id_3E57() {
  if(!isDefined(self.pathgoalpos)) {
    return 0;
  }

  if(!self _meth_8380()) {
    return 0;
  }

  if(self.a.pose == "prone") {
    return 0;
  }

  if(isDefined(self._id_55ED) && self._id_55ED) {
    return 0;
  }

  if(self.stairsstate != "none") {
    return 0;
  }

  if(!self _meth_81BF("stand") && !isDefined(self.heat)) {
    return 0;
  }

  var_0 = 10000;
  var_1 = scripts\asm\asm::asm_getdemeanor();

  if(scripts\asm\asm::asm_getdemeanor() == "casual" || scripts\asm\asm::asm_getdemeanor() == "casual_gun") {
    var_0 = 2500;
  }

  if(distancesquared(self.origin, self.pathgoalpos) < var_0) {
    return 0;
  }

  return 1;
}

_id_3B1F(var_0, var_1, var_2, var_3) {
  var_4 = scripts\asm\asm::asm_getdemeanor();

  if(!isDefined(var_3[2]) || var_3[2] != var_4) {
    return 0;
  }

  if(!_id_FFF8(var_0, var_1, var_2, var_3)) {
    return 0;
  }

  var_5 = self.a._id_FC62;
  return var_5 < 2 || var_5 > 6;
}

_id_FFF8(var_0, var_1, var_2, var_3) {
  if(isDefined(self.noturnanims) && self.noturnanims) {
    return 0;
  }

  if(isDefined(self._id_932E) && self._id_932E) {
    return 0;
  }

  var_4 = self._id_164D[var_0]._id_4BC0;
  var_5 = scripts\asm\asm::_id_233F(var_4, "sharp_turn");

  if(!isDefined(var_5)) {
    return 0;
  }

  var_6 = 50;
  var_7 = gettime();

  if(var_7 - var_5._id_7686 > var_6) {
    return 0;
  }

  var_8 = var_5.params[1];
  var_9 = var_5.params[2];
  var_10 = 0;
  var_11 = undefined;

  if(!isarray(var_3)) {
    var_12 = var_3;
  } else {
    var_12 = var_3[0];

    if(var_3.size > 1 && var_3[1] == 1) {
      var_10 = 1;
    }

    if(var_3.size > 2) {
      var_11 = scripts\asm\asm_bb::_id_2928(var_3[2]);
    }
  }

  var_13 = _id_371C(var_1, var_12, var_8, var_9, var_10, var_11);

  if(!isDefined(var_13)) {
    return 0;
  }

  self.a._id_FC61 = var_13;
  return 1;
}

_id_371C(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = 10;

  if(var_3 || self.lookaheaddist > self.sharpturnlookaheaddist * 2) {
    var_6 = 30;
  }

  if(!isDefined(var_5)) {
    var_5 = "";
  }

  if(var_4) {
    if(scripts\asm\asm::_id_232C(var_0, "pass_left")) {
      var_7 = var_5 + "left";
    } else if(scripts\asm\asm::_id_232C(var_0, "pass_right")) {
      var_7 = var_5 + "right";
    } else if(self.asm.footsteps.foot == "right") {
      var_7 = var_5 + "right";
    } else {
      var_7 = var_5 + "left";
    }
  } else
    var_7 = var_5;

  if(isDefined(self._id_22F0)) {
    var_8 = self._id_22F0;
  } else {
    var_8 = -1;
  }

  [var_10, var_11] = self _meth_8546(self.asm.archetype, var_1, scripts\asm\asm::asm_getdemeanor(), var_2, var_3, var_6, var_8, var_7, var_5);

  if(isDefined(self.asm._id_13CAF) && self.asm._id_13CAF && isDefined(var_11)) {
    var_12 = var_11;

    if(var_11 == 0 || var_11 == 8) {
      var_12 = 2;
    }

    if(var_11 == 1) {
      var_12 = 3;
    }

    if(var_11 == 2) {
      var_12 = 6;
    }

    if(var_11 == 3) {
      var_12 = 9;
    }

    if(var_11 == 4) {
      var_12 = 8;
    }

    if(var_11 == 5) {
      var_12 = 7;
    }

    if(var_11 == 6) {
      var_12 = 4;
    }

    if(var_11 == 7) {
      var_12 = 1;
    }

    var_13 = var_7 + var_12 + "_2h";

    if(_id_0A1E::_id_2305(self.asm.archetype, var_1, var_13)) {
      var_10 = _id_0A1E::_id_2359(self.asm.archetype, var_1, var_13);
    }
  }

  self.a._id_FC62 = var_11;
  return var_10;
}

_id_3EF5(var_0, var_1, var_2, var_3) {
  return self.a._id_FC61;
}

_id_8989(var_0) {
  if(var_0 == "corner") {
    self orientmode("face motion");
  }
}

_id_D514(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  var_4 = _id_0A1E::asm_getallanimsforstate(var_0, var_1);
  self.a._id_FC61 = undefined;
  self animmode("zonly_physics", 0);
  self orientmode("face angle", self.angles[1]);
  self clearanim(_id_0A1E::asm_getbodyknob(), var_2);
  _id_0A1E::_id_2369(var_0, var_1, var_4);
  thread _id_0F3D::_id_444B(var_1);
  self _meth_82EA(var_1, var_4, 1, var_2, self.moveplaybackrate);
  var_5 = _id_0A1E::_id_231F(var_0, var_1, ::_id_8989, undefined, undefined, 0);
  self orientmode("face motion");
  self animmode("normal", 0);

  if(var_5 == "code_move") {
    _id_0F3D::_id_11065();
    thread _id_0F3D::_id_136B4(var_0, var_1, var_3);
    thread _id_0F3D::_id_136E7(var_0, var_1, var_3);
    var_6 = getnotetracktimes(var_4, "finish");

    if(var_6.size > 0) {
      _id_0A1E::_id_231F(var_0, var_1);
    }
  }
}

_id_98C6(var_0, var_1, var_2, var_3) {
  if(!isDefined(self._id_E873)) {
    self notify("stop_move_anim_update");
    self._id_12DEF = undefined;
    thread _id_0F3D::_id_136B4(var_0, var_1, var_3);
    thread _id_0F3D::_id_136E7(var_0, var_1, var_3);
    self clearanim(_id_0A1E::asm_getbodyknob(), var_2);
    self._id_E879 = 0;
    self._id_E873 = 1;
  }
}

_id_11088(var_0, var_1, var_2) {
  if(isDefined(self._id_E873)) {
    self clearanim(scripts\asm\asm::asm_lookupanimfromalias(var_1, "run_n_gun"), 0.2);
    self._id_E873 = undefined;
  }

  return 0;
}

_id_D50D(var_0, var_1, var_2, var_3) {
  _id_98C6(var_0, var_1, var_2, var_3);
  _id_E877(var_0, var_1, var_2, var_3);
}

_id_E875() {
  if(isalive(self.enemy) && self cansee(self.enemy)) {
    return self.enemy;
  }
}

_id_1006E(var_0, var_1, var_2, var_3) {
  if(self.team == "allies" && _id_9EC3(var_0, var_1, var_2, var_3)) {
    return 0;
  }

  if(self pathdisttogoal() < 200) {
    return 0;
  }

  var_4 = _id_E875();
  return self.facemotion && isDefined(var_4) && scripts\anim\move::_id_B4EC() && scripts\asm\asm_bb::bb_movetyperequested("combat");
}

_id_10070(var_0, var_1, var_2, var_3) {
  return canshoottargetfrompos();
}

_id_1006F(var_0, var_1, var_2, var_3) {
  return canshoottarget();
}

_id_1009F(var_0, var_1, var_2, var_3) {
  return !_id_1006E(var_0, var_1, var_3) || !_id_10070(var_0, var_1, var_2, var_3);
}

_id_1009E(var_0, var_1, var_2, var_3) {
  return !_id_1006E(var_0, var_1, var_3) || !_id_1006F(var_0, var_1, var_2, var_3);
}

canshoottargetfrompos() {
  if((!isDefined(self._id_E879) || self._id_E879 == 0) && abs(self _meth_813E()) > self._id_B4C3) {
    return 0;
  }

  return 1;
}

canshoottarget() {
  if(!isDefined(self._id_E879) || self._id_E879 == 0) {
    return 0;
  }

  if(180 - abs(self _meth_813E()) >= 45) {
    return 0;
  }

  var_0 = _id_8096(0.2);

  if(abs(var_0) > 30) {
    return 0;
  }

  return 1;
}

canshootinvehicle() {
  return scripts\anim\move::_id_B4EC() && isDefined(self.enemy) && (canshoottargetfrompos() || canshoottarget());
}

_id_8096(var_0) {
  var_1 = self.origin;
  var_2 = self.angles[1] + self _meth_813E();
  var_1 = var_1 + (cos(var_2), sin(var_2), 0) * length(self.velocity) * var_0;
  var_3 = self.angles[1] - vectortoyaw(self.enemy.origin - var_1);
  var_3 = angleclamp180(var_3);
  return var_3;
}

_id_E877(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  var_4 = scripts\asm\asm::asm_lookupanimfromalias(var_1, "F");
  var_5 = scripts\asm\asm::asm_lookupanimfromalias(var_1, "L");
  var_6 = scripts\asm\asm::asm_lookupanimfromalias(var_1, "R");
  var_7 = scripts\asm\asm::asm_lookupanimfromalias(var_1, "LB");
  var_8 = scripts\asm\asm::asm_lookupanimfromalias(var_1, "RB");
  var_9 = scripts\asm\asm::asm_lookupanimfromalias(var_1, "run_n_gun");
  var_10 = self._id_B4C3;
  var_11 = self._id_E878;
  var_12 = self._id_E876;

  for(;;) {
    var_13 = _id_E875();

    if(isDefined(var_13)) {
      var_14 = _id_8096(0.2);
      var_15 = var_14 < 0;
    } else {
      var_14 = 0;
      var_15 = self._id_E879 < 0;
    }

    var_16 = 1 - var_15;
    var_17 = var_14 / var_10;
    var_18 = var_17 - self._id_E879;

    if(abs(var_18) < var_11 * 0.7) {
      self._id_E879 = var_17;
    } else if(var_18 > 0) {
      self._id_E879 = self._id_E879 + var_12;
    } else {
      self._id_E879 = self._id_E879 - var_12;
    }

    var_19 = abs(self._id_E879);

    if(var_19 > var_11) {
      var_20 = (var_19 - var_11) / var_11;
      var_20 = clamp(var_20, 0, 1);
      self clearanim(var_4, 0.2);
      self _meth_82AC(var_5, (1.0 - var_20) * var_15, 0.2);
      self _meth_82AC(var_6, (1.0 - var_20) * var_16, 0.2);
      self _meth_82AC(var_7, var_20 * var_15, 0.2);
      self _meth_82AC(var_8, var_20 * var_16, 0.2);
    } else {
      var_20 = clamp(var_19 / var_11, 0, 1);
      self _meth_82AC(var_4, 1.0 - var_20, 0.2);
      self _meth_82AC(var_5, var_20 * var_15, 0.2);
      self _meth_82AC(var_6, var_20 * var_16, 0.2);

      if(var_11 < 1) {
        self clearanim(var_7, 0.2);
        self clearanim(var_8, 0.2);
      }
    }

    self setanimknob(var_9, 1, 0.3, 0.8);
    self.a._id_1C8D = gettime() + 500;

    if(isDefined(var_13) && isPlayer(var_13)) {
      self _meth_83CE();
    }

    wait 0.2;
  }
}

_id_D50E(var_0, var_1, var_2, var_3) {
  _id_98C6(var_0, var_1, var_2, var_3);
  _id_E874(var_0, var_1, var_2, var_3);
}

_id_E874(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");

  for(;;) {
    if(isPlayer(self.enemy)) {
      self _meth_83CE();
    }

    var_4 = _id_0A1E::asm_getallanimsforstate(var_0, var_1);
    self _meth_82E2(var_1, var_4, 1.0, var_2, 1.0);
    _id_0A1E::_id_2369(var_0, var_1, var_4);
    wait 0.2;
  }
}

_id_D4E6(var_0, var_1, var_2, var_3) {
  if(getdvarint("ai_usefullstrafe", 0) == 0) {
    _id_D4E5(var_0, var_1, var_2, var_3);
    return;
  }

  self clearanim(_id_0A1E::asm_getbodyknob(), var_2);
  _id_98A3(var_0, var_1, var_2, var_3);
  thread _id_BCFD(var_0, var_1, var_2, var_3);
}

_id_98A3(var_0, var_1, var_2, var_3) {
  var_4 = 1.0;

  if(isDefined(var_3)) {
    var_4 = var_3;
  }

  var_5 = _id_0A1E::asm_getallanimsforstate(var_0, var_1);
  self setanimknob(var_5[0], 1, 0.2, var_4, 1);
}

_id_817A(var_0) {
  var_1 = [];

  for(var_2 = 0; var_2 < 9; var_2++) {
    var_1[var_2] = 0;
  }

  var_3 = [-180, -135, -90, -45, 0, 45, 90, 135, 180];

  for(var_2 = 0; var_0 >= var_3[var_2]; var_2++) {}

  var_4 = var_2 - 1;
  var_5 = var_2;
  var_6 = (var_0 - var_3[var_4]) / (var_3[var_5] - var_3[var_4]);
  var_7 = 1 - var_6;
  var_1[var_4] = var_7;
  var_1[var_5] = var_6;

  if(var_1[0] > var_1[8]) {
    var_1[8] = var_1[0];
  } else {
    var_1[0] = var_1[8];
  }

  return var_1;
}

_id_3F03(var_0, var_1, var_2) {
  var_3 = [];
  var_3[0] = ::scripts\asm\asm::asm_lookupanimfromalias(var_1, "0");
  var_3[1] = ::scripts\asm\asm::asm_lookupanimfromalias(var_1, "1");
  var_3[2] = ::scripts\asm\asm::asm_lookupanimfromalias(var_1, "2");
  var_3[3] = ::scripts\asm\asm::asm_lookupanimfromalias(var_1, "3");
  var_3[4] = ::scripts\asm\asm::asm_lookupanimfromalias(var_1, "4");
  var_3[5] = ::scripts\asm\asm::asm_lookupanimfromalias(var_1, "5");
  var_3[6] = ::scripts\asm\asm::asm_lookupanimfromalias(var_1, "6");
  var_3[7] = ::scripts\asm\asm::asm_lookupanimfromalias(var_1, "7");
  var_3[8] = ::scripts\asm\asm::asm_lookupanimfromalias(var_1, "8");
  return var_3;
}

_id_3F0C(var_0, var_1, var_2) {
  var_3 = spawnStruct();
  var_4 = [];
  var_4[0] = ::scripts\asm\asm::asm_lookupanimfromalias(var_1, "0");
  var_4[1] = ::scripts\asm\asm::asm_lookupanimfromalias(var_1, "1");
  var_4[2] = ::scripts\asm\asm::asm_lookupanimfromalias(var_1, "2");
  var_3.anims = var_4;
  var_3._id_7332 = scripts\asm\asm::asm_lookupanimfromalias(var_1, "forward");
  return var_3;
}

_id_100BD() {
  return scripts\asm\asm_bb::bb_moverequested() && isDefined(self._blackboard._id_13863) && self._blackboard._id_13863;
}

_id_13874(var_0, var_1) {
  self endon(var_1 + "_finished");

  for(;;) {
    _id_0A1E::_id_231F(var_0, var_1);
  }
}

_id_BD2C(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  thread _id_0F3D::_id_136B4(var_0, var_1, var_3);
  thread _id_0F3D::_id_136E7(var_0, var_1, var_3);
  var_4 = scripts\asm\asm::asm_getmoveplaybackrate();
  scripts\asm\asm::asm_updatefrantic();
  self _meth_84F1(var_4);
  scripts\asm\asm::asm_updatefrantic();
  var_5 = _id_0A1E::asm_getallanimsforstate(var_0, var_1);
  var_6 = var_5.anims;
  var_7 = var_5._id_7332;
  self clearanim(_id_0A1E::asm_getbodyknob(), 0.2);
  self _meth_82E1(var_1, var_7, 1.0, 0.2, 1.0);
  thread _id_13874(var_0, var_1);
  var_8 = 0;
  var_9 = 20;

  for(;;) {
    var_10 = scripts\asm\asm::_id_232B(var_1, "cover_approach");
    var_11 = self pathdisttogoal();

    if(var_10 && var_11 < 150) {
      var_12 = _id_1E80();
      var_13 = 1;

      while(var_13 <= var_9) {
        var_14 = var_13 / var_9;
        var_15 = var_14 * var_14 * (3 - 2 * var_14);
        var_16 = var_12;
        var_17 = var_16 * var_15;
        var_18 = var_16 - var_17;
        var_19 = _id_820A(var_18);

        for(var_20 = 0; var_20 < var_19.size; var_20++) {
          self _meth_82A2(var_6[var_20], var_19[var_20], 0.2, 1.0, 1);
        }

        var_13++;
        wait 0.05;
        waittillframeend;
      }

      while(var_10) {
        var_19 = _id_820A(0);

        for(var_13 = 0; var_13 < var_19.size; var_13++) {
          if(isDefined(var_6[var_13])) {
            self _meth_82A2(var_6[var_13], var_19[var_13], 0.2, 1.0, 1);
          }
        }

        wait 0.05;
        waittillframeend;
      }

      continue;
    }

    var_12 = _id_1E80();
    var_21 = var_8 - var_12;

    if(var_21 < 0) {
      var_21 = var_21 * -1;
    }

    if(var_21 >= 60) {
      var_22 = var_8;
      var_23 = var_8;
      var_13 = 1;

      while(var_13 <= var_9) {
        var_12 = _id_1E80();
        var_24 = var_22 - var_12;

        if(var_24 < 0) {
          var_24 = var_24 * -1;
        }

        if(var_24 >= 60) {
          if(var_13 == 1) {
            var_13 = 1;
          } else {
            var_13 = var_13 - 1;
          }

          var_25 = var_22 - var_8;
          var_14 = var_13 / var_9;
          var_15 = var_14 * var_14 * (3 - 2 * var_14);
          var_26 = var_25 * var_15;
          var_23 = var_26 + var_8;
          var_13 = 1;
          var_8 = var_23;
        }

        var_14 = var_13 / var_9;
        var_15 = var_14 * var_14 * (3 - 2 * var_14);
        var_16 = var_12 - var_23;
        var_17 = var_16 * var_15;
        var_18 = var_17 + var_8;
        var_19 = _id_820A(var_18);

        for(var_20 = 0; var_20 < var_19.size; var_20++) {
          self _meth_82A2(var_6[var_20], var_19[var_20], 0.2, 1.0, 1);
        }

        var_13++;
        var_22 = var_12;
        wait 0.05;
        waittillframeend;
      }
    } else {
      var_19 = _id_820A(var_12);

      for(var_13 = 0; var_13 < var_19.size; var_13++) {
        if(isDefined(var_6[var_13])) {
          self _meth_82A2(var_6[var_13], var_19[var_13], 0.2, 1.0, 1);
        }
      }

      wait 0.05;
      waittillframeend;
    }

    var_8 = var_12;
  }
}

_id_1E80() {
  var_0 = self._id_13864.origin;
  var_1 = self.origin;
  var_2 = var_0 - var_1;
  var_3 = anglesToForward(self.angles);
  var_4 = vectorcross(var_3, var_2);
  var_5 = vectorNormalize(var_4);
  var_6 = vectorNormalize(var_2);
  var_7 = vectorNormalize(var_3);
  var_8 = vectordot(var_6, var_7);

  if(isDefined(self._id_13862)) {
    var_9 = scripts\engine\utility::anglebetweenvectors(var_2, var_3);

    if(self._id_13862 == "right") {
      if(var_8 <= -1) {
        return -180;
      }

      return var_9 * -1;
      return;
    }

    if(var_8 >= 1) {
      return 180;
    }

    return var_9;
    return;
  } else {
    if(var_8 >= 1) {
      return 180;
    }

    if(var_8 <= -1) {
      return -180;
    } else {
      var_9 = scripts\engine\utility::anglebetweenvectors(var_2, var_3);

      if(var_5[2] == -1) {
        var_9 = var_9 * -1;
      }

      return var_9;
    }
  }
}

_id_820A(var_0) {
  var_1 = [];

  for(var_2 = 0; var_2 < 3; var_2++) {
    var_1[var_2] = 0;
  }

  var_3 = [-180, 0, 180];

  for(var_2 = 0; var_0 >= var_3[var_2]; var_2++) {}

  var_4 = var_2 - 1;
  var_5 = var_2;
  var_6 = (var_0 - var_3[var_4]) / (var_3[var_5] - var_3[var_4]);
  var_7 = 1 - var_6;
  var_1[var_4] = var_7;
  var_1[var_5] = var_6;
  var_1[1] = max(0.01, var_1[1]);
  return var_1;
}

_id_BCFD(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  var_4 = 1.0;

  if(isDefined(var_3)) {
    var_4 = var_3;
  }

  var_5 = _id_0A1E::asm_getallanimsforstate(var_0, var_1);
  self._id_110D5 = 0;
  var_6 = self _meth_813E();

  for(;;) {
    if(length(self.velocity) > 1.0) {
      var_6 = self _meth_813E();
    }

    self._id_110D5 = var_6;
    var_7 = _id_817A(self._id_110D5);

    for(var_8 = 0; var_8 < var_7.size; var_8++) {
      if(isDefined(var_5[var_8])) {
        self _meth_82AC(var_5[var_8], var_7[var_8], 0.1, var_4, 1);
      }
    }

    wait 0.1;
  }
}

_id_D4E5(var_0, var_1, var_2, var_3) {
  _id_98A2(var_0, var_1, var_2, var_3);
  thread _id_BCFC(var_0, var_1, var_2, var_3);
}

_id_98A2(var_0, var_1, var_2, var_3) {
  var_4 = 1.0;

  if(isDefined(var_3) && scripts\asm\asm::asm_getdemeanor() != "frantic") {
    var_4 = var_3;
  }

  var_5 = scripts\asm\asm::asm_lookupanimfromalias(var_1, "F");
  var_6 = scripts\asm\asm::asm_lookupanimfromalias(var_1, "L");
  var_7 = scripts\asm\asm::asm_lookupanimfromalias(var_1, "R");
  var_8 = scripts\asm\asm::asm_lookupanimfromalias(var_1, "B");
  self _meth_82A9(var_5, 1, 0.1, var_4, 1);
  self _meth_82A9(var_8, 1, 0.1, var_4, 1);
  self _meth_82A9(var_7, 1, 0.1, var_4, 1);
  self _meth_82A9(var_6, 1, 0.1, var_4, 1);
}

_id_BCFC(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  var_4 = 1.0;

  if(isDefined(var_3)) {
    var_4 = var_3;
  }

  self _meth_84F1(var_4);
  var_5 = scripts\asm\asm::asm_lookupanimfromalias(var_1, "f_knob");
  var_6 = scripts\asm\asm::asm_lookupanimfromalias(var_1, "l_knob");
  var_7 = scripts\asm\asm::asm_lookupanimfromalias(var_1, "r_knob");
  var_8 = scripts\asm\asm::asm_lookupanimfromalias(var_1, "b_knob");

  for(;;) {
    var_9 = scripts\anim\utility_common::quadrantanimweights(self _meth_813E());
    self _meth_82A2(var_5, var_9["front"], 0.2, 1.0, 1);
    self _meth_82A2(var_8, var_9["back"], 0.2, 1.0, 1);
    self _meth_82A2(var_6, var_9["left"], 0.2, 1.0, 1);
    self _meth_82A2(var_7, var_9["right"], 0.2, 1.0, 1);
    wait 0.05;
    waittillframeend;
  }
}

_id_3EFF(var_0, var_1, var_2) {
  if(isDefined(self.grenade)) {
    return scripts\asm\asm::asm_lookupanimfromalias(var_1, "sprint_short");
  }

  if(scripts\asm\asm::asm_hasdemeanoranimoverride("sprint", "move")) {
    var_3 = scripts\asm\asm::asm_getdemeanoranimoverride("sprint", "move");

    if(isarray(var_3)) {
      return var_3[randomint(var_3.size)];
    }

    return var_3;
  }

  return scripts\asm\asm::asm_lookupanimfromalias(var_1, "sprint");
}

_id_FFF5(var_0, var_1, var_2, var_3) {
  if(isDefined(self.disablebulletwhizbyreaction)) {
    return 0;
  }

  var_4 = scripts\asm\asm_bb::bb_getrequestedwhizby();

  if(!isDefined(var_4)) {
    return 0;
  }

  if(self.lookaheaddist < 100) {
    return 0;
  }

  if(!isDefined(self.pathgoalpos) || distancesquared(self.pathgoalpos, self.origin) < 160000) {
    return 0;
  }

  return 1;
}

_id_BCF9(var_0) {
  var_1 = scripts\asm\asm::asm_getdemeanor();

  if(var_1 == "frantic" || var_1 == "combat" || var_1 == "sprint") {
    scripts\anim\battlechatter_ai::_id_67D2(var_0);
  }
}

shouldreload(var_0, var_1, var_2, var_3) {
  if(!scripts\asm\asm_bb::bb_reloadrequested()) {
    return 0;
  }

  if(scripts\asm\asm::asm_getdemeanor()) {
    var_4 = 400;
  } else if(scripts\asm\asm_bb::bb_movetyperequested("cqb")) {
    var_4 = 500;
  } else {
    var_4 = 600;
  }

  var_5 = self pathdisttogoal();
  return var_4 < var_5;
}

_id_D506(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  thread _id_0F3D::_id_136B4(var_0, var_1, var_3);
  thread _id_0F3D::_id_136E7(var_0, var_1, var_3);
  var_4 = _id_0A1E::asm_getallanimsforstate(var_0, var_1);
  self _meth_82E7(var_1, var_4, 1, var_2, self.moveplaybackrate);
  _id_0A1E::_id_2369(var_0, var_1, var_4);
  _id_0A1E::_id_231F(var_0, var_1);
}

_id_116FE(var_0, var_1, var_2) {
  if(!scripts\asm\asm::_id_232B(var_1, "reload done")) {
    scripts\anim\weaponlist::refillclip();
  }

  _id_0C68::_id_DF4F(var_0, var_1, var_2);
}

_id_10B4F(var_0, var_1, var_2) {
  if(isDefined(var_2)) {
    var_3 = scripts\asm\asm_bb::_id_2928(var_2);

    if(isDefined(var_3)) {
      var_1 = var_3 + var_1;
    }
  }

  return scripts\engine\utility::is_true(scripts\asm\asm::asm_hasalias(var_0, var_1));
}

_id_9EC3(var_0, var_1, var_2, var_3) {
  return isDefined(self.pathgoalpos) && self.stairsstate != "none";
}

_id_9EC9(var_0, var_1, var_2, var_3) {
  if(!isDefined(self.pathgoalpos)) {
    return 0;
  }

  if(isarray(var_3)) {
    var_4 = var_3[0];
  } else {
    var_4 = var_3;
  }

  return self.stairsstate == var_4;
}

_id_8157() {
  var_0 = scripts\asm\asm::asm_getdemeanor();

  switch (var_0) {
    case "casual":
      return 23;
    case "casual_gun":
      return 17;
    case "cqb":
      return 20;
    default:
      return 36;
  }
}

_id_10006(var_0, var_1, var_2, var_3) {
  var_4 = undefined;

  if(isarray(var_3)) {
    var_4 = var_3[0];
  } else {
    var_4 = var_3;
  }

  if(self.stairsstate == var_4) {
    return 1;
  }

  var_5 = _id_8157();
  var_6 = self _meth_84D7(var_5);

  if(var_6 == var_4) {
    return 1;
  }

  return 0;
}

_id_10005(var_0, var_1, var_2, var_3) {
  var_4 = undefined;

  if(isarray(var_3)) {
    var_4 = var_3[0];
  } else {
    var_4 = var_3;
  }

  if(self.stairsstate == var_4) {
    var_5 = undefined;

    if(isarray(var_3)) {
      var_5 = var_3[1];
    }

    return _id_10B4F(var_2, "left", var_5);
  }

  var_6 = _id_8157();
  var_7 = self _meth_84D7(var_6);

  if(var_7 == var_4) {
    var_5 = undefined;

    if(isarray(var_3)) {
      var_5 = var_3[1];
    }

    return _id_10B4F(var_2, "left", var_5);
  }

  return 0;
}

_id_8158() {
  var_0 = scripts\asm\asm::asm_getdemeanor();

  switch (var_0) {
    case "casual":
      return 13;
    case "casual_gun":
      return 10;
    case "cqb":
      return 13;
    case "combat":
      return 10;
    case "frantic":
      return 10;
    default:
      return 28;
  }
}

_id_8159() {
  var_0 = scripts\asm\asm::asm_getdemeanor();

  switch (var_0) {
    case "casual":
      return 24;
    case "casual_gun":
      return 24;
    case "cqb":
      return 15;
    default:
      return 28;
  }
}

_id_7EEA() {
  var_0 = self _meth_8552();

  if(abs(var_0) > 0.99) {
    return 0;
  }

  var_1 = acos(var_0);
  return var_1;
}

_id_10030(var_0, var_1, var_2, var_3) {
  return self.stairsstate != "none" && _id_1000E(var_0, var_1, var_2, var_3);
}

_id_1000E(var_0, var_1, var_2, var_3) {
  if(isDefined(self._blackboard.disablestairsexits) && self._blackboard.disablestairsexits) {
    return 0;
  }

  if(self.stairsstate == "none") {
    return 1;
  }

  var_4 = var_3;
  var_5 = _id_8158();

  if(isDefined(var_3) && var_3 == "up") {
    var_5 = _id_8159();
  }

  if(self.stairsstate != var_4) {
    return 1;
  }

  var_6 = self _meth_84D7(var_5);
  return var_6 != self.stairsstate;
}

_id_3EA5(var_0, var_1, var_2) {
  if(self.asm.footsteps.foot == "left") {
    var_3 = "right";
  } else {
    var_3 = "left";
  }

  if(isDefined(var_2)) {
    var_4 = scripts\asm\asm_bb::_id_2928(var_2);

    if(isDefined(var_4)) {
      var_3 = var_4 + var_3;
    }
  }

  var_5 = _id_0A1E::_id_2356(var_1, var_3);
  return var_5;
}

_id_3EA6(var_0, var_1, var_2) {
  var_3 = "8x10";
  var_4 = _id_7EEA();

  if(var_4 < 27.75) {
    var_3 = "8x20";
  }

  if(var_4 >= 27.75 && var_4 < 36.2) {
    var_3 = "8x12";
  }

  if(var_4 >= 36.2 && var_4 < 41.85) {
    var_3 = "8x10";
  }

  if(var_4 >= 41.85) {
    var_3 = "8x8";
  }

  var_5 = _id_0A1E::_id_2356(var_1, var_3);
  return var_5;
}