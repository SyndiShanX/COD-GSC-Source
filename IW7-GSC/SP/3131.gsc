/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3131.gsc
**************************************/

_id_13DC4(var_0, var_1, var_2, var_3) {
  self.asm.footsteps = spawnStruct();
  self.asm.footsteps.foot = "invalid";
  self.asm.footsteps.time = 0;
  self.asm._id_4C86 = spawnStruct();
  self.asm._id_7360 = 0;
  scripts\asm\asm::_id_237B(1);
  scripts\anim\combat::_id_F296();
  self.allowpain = 0;
  self.sharpturnlookaheaddist = 58;
  self.meleerangesq = 5184;
  self.meleechargedist = 256;
  self.meleechargedistvsplayer = 256;
  self.meleechargedistreloadmultiplier = 1;
  self._id_B627 = 50;
  self.meleeactorboundsradius = 40;
  self.acceptablemeleefraction = 0.98;
  self._id_B621 = 1;
  self._id_B5E1 = 6400;
  self._id_B623 = 1;
  self._id_71C8 = _id_0C60::_id_33AA;
  thread _id_3409(var_0);
}

_id_808E() {
  if(!isDefined(anim._id_13DBF))
    return 1;
  else
    return anim._id_13DBF;
}

_id_7E70() {
  var_0 = _id_808E();
  var_1 = 25 + var_0 * 175;

  if(isDefined(self.melee) && isDefined(self.melee.target))
    var_1 = var_1 + 20;

  return var_1;
}

_id_9F06(var_0, var_1, var_2, var_3) {
  return _id_808E() <= 0;
}

_id_C17D(var_0, var_1, var_2, var_3) {
  return !_id_9F06(var_0, var_1, var_2, var_3);
}

_id_3415(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  thread _id_0F3D::_id_136B4(var_0, var_1, var_3);
  thread _id_0F3D::_id_136E7(var_0, var_1, var_3);
  var_4 = scripts\asm\asm::asm_getmoveplaybackrate();
  self _meth_84F1(var_4);
  var_5 = _id_0A1E::asm_getbodyknob();
  self clearanim(var_5, var_2);

  if(scripts\asm\asm::asm_hasalias("Knobs", "move")) {
    var_6 = _id_0A1E::_id_2356("Knobs", "move");
    self _meth_84F2(var_6);
  }

  var_7 = 0;
  var_8 = 1;
  var_9 = scripts\asm\asm::asm_lookupanimfromalias(var_1, "walk");
  var_10 = scripts\asm\asm::asm_lookupanimfromalias(var_1, "fastwalk");
  var_11 = scripts\asm\asm::asm_lookupanimfromalias(var_1, "jog");
  var_12 = scripts\asm\asm::asm_lookupanimfromalias(var_1, "run");
  var_13 = [];
  var_13["walk"] = [];
  var_13["walk"][var_7] = var_9;
  var_13["walk"][var_8] = length(getmovedelta(var_9)) / getanimlength(var_9);
  var_13["fastwalk"] = [];
  var_13["fastwalk"][var_7] = var_10;
  var_13["fastwalk"][var_8] = length(getmovedelta(var_10)) / getanimlength(var_10);
  var_13["jog"] = [];
  var_13["jog"][var_7] = var_11;
  var_13["jog"][var_8] = length(getmovedelta(var_11)) / getanimlength(var_11);
  var_13["run"] = [];
  var_13["run"][var_7] = var_12;
  var_13["run"][var_8] = length(getmovedelta(var_12)) / getanimlength(var_12);
  var_14 = var_5;

  for(;;) {
    var_15 = _id_3407();
    var_16 = var_13[var_15][var_7];
    var_17 = _id_7E70();
    var_4 = var_17 / var_13[var_15][var_8];
    self _meth_84F1(var_4);

    if(var_16 != var_14) {
      self notify(var_1 + "_newanim");
      self _meth_82E7(var_1, var_16, 1.0, 0.3, 1);
      childthread _id_BC22(var_0, var_1, scripts\asm\asm::_id_2341(var_0, var_1));
      var_14 = var_16;
    }

    wait 0.05;
  }
}

_id_BC22(var_0, var_1, var_2) {
  self endon(var_1 + "_newanim");

  for(;;)
    _id_0A1E::_id_231F(var_0, var_1, var_2);
}

_id_3407() {
  var_0 = _id_7E70();

  if(var_0 < 70)
    return "walk";
  else if(var_0 < 110)
    return "fastwalk";
  else if(var_0 < 160)
    return "jog";
  else
    return "run";
}

_id_3406(var_0, var_1, var_2, var_3) {
  var_4 = !_id_0A0B::_id_E52D();
  var_5 = !_id_0A0B::_id_AB53();

  if(var_4 && var_5)
    return scripts\asm\asm::asm_lookupanimfromalias(var_1, "both");
  else if(var_4)
    return scripts\asm\asm::asm_lookupanimfromalias(var_1, "right");
  else
    return scripts\asm\asm::asm_lookupanimfromalias(var_1, "left");
}

_id_340A(var_0, var_1, var_2, var_3) {
  var_4 = self.melee.target;

  if(!isDefined(var_4))
    return 0;

  if(!isalive(var_4))
    return 0;

  if(isPlayer(var_4))
    return 0;

  var_5 = var_3;

  if(self.melee._id_13D8A != var_5)
    return 0;

  var_6 = self[[self._id_7191]](var_0, var_2);

  if(!_id_0C30::_id_335A(var_1 + "_victim", var_6))
    return 0;

  var_7 = self _meth_84AC();
  var_8 = vectorNormalize(var_4.origin - self.origin);
  var_9 = var_7 + var_8 * 64;

  if(!self[[self.fncanmovefrompointtopoint]](var_7, var_9))
    return 0;

  self.melee.target.melee._id_331C = 1;
  return 1;
}

_id_126D6(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  self._blackboard.btraversing = 1;
  var_4 = self[[self._id_7191]](var_0, var_1);
  var_5 = getnotetracktimes(var_4, "jump_begin");
  var_6 = getnotetracktimes(var_4, "jump_end");
  var_7 = getanimlength(var_4);
  var_8 = getmovedelta(var_4, 0, var_5[0]);
  var_9 = getmovedelta(var_4, 0, var_6[0]);
  var_10 = getmovedelta(var_4, 0, 1);
  var_11 = var_10 - var_9;
  var_12 = self _meth_8148();
  var_13 = self _meth_8146();
  self clearanim(_id_0A1E::asm_getbodyknob(), var_2);
  self animmode("noclip", 0);
  self orientmode("face angle", var_12.angles[1]);
  self _meth_82EA(var_1, var_4, 1, var_2, 1);
  _id_0A1E::_id_2323(var_0, var_1, var_5[0] * var_7);
  var_14 = self.origin;
  var_15 = var_13 - rotatevector(var_11, var_12.angles);
  var_16 = rotatevector(var_9 - var_8, var_12.angles);
  var_17 = var_15 - var_14;
  var_18 = 1;

  if(var_17[2] < var_16[2])
    var_18 = var_18 * 1.1;

  self _meth_82B1(var_4, var_18);
  var_19 = self islegacyagent(var_4);
  var_20 = var_17 - var_16;
  var_21 = (var_6[0] - var_19) * var_7 / var_18;
  var_22 = int(var_21 * 20);
  thread _id_126D7(var_1, var_20, var_22, var_4);
  _id_0A1E::_id_231F(var_0, var_1);
  self._blackboard.btraversing = undefined;
  _id_0C6B::_id_11701(var_0, var_1);
}

_id_126D7(var_0, var_1, var_2, var_3) {
  self endon(var_0 + "_finished");
  var_4 = var_1 / var_2;

  while(var_2) {
    self _meth_80F1(self.origin + var_4);
    var_2--;
    wait 0.05;
  }

  if(isDefined(var_3))
    self _meth_82B1(var_3, 1);
}

_id_341C(var_0, var_1, var_2, var_3) {
  if(isDefined(self.disablearrivals))
    return 0;

  if(!isDefined(self.pathgoalpos))
    return 0;

  if(!scripts\asm\asm::_id_232B(var_1, "cover_approach"))
    return 0;

  if(isDefined(self.melee))
    return 0;

  var_4 = 40;
  var_5 = distance(self.origin, self.pathgoalpos);
  var_6 = abs(var_5 - var_4);

  if(var_6 > 12)
    return 0;

  return 1;
}

_id_341B(var_0, var_1, var_2, var_3) {
  if(!scripts\asm\asm::_id_232B(var_1, "sharp_turn"))
    return 0;

  var_4 = scripts\asm\asm::_id_233F(var_1, "sharp_turn");
  var_5 = var_4.params;
  var_6 = var_5[1];
  var_7 = anglesToForward(self.angles);

  if(vectordot(var_7, var_6) > 0.866)
    return 0;

  return 1;
}

_id_341A(var_0, var_1, var_2, var_3) {
  var_4 = self[[self._id_7191]](var_0, var_2);
  var_5 = getmovedelta(var_4);
  var_6 = length(var_5) * 2.25;
  var_7 = self getposonpath(var_6);

  if(distance2dsquared(var_7, self.pathgoalpos) < 4)
    return 0;

  return 1;
}

_id_3405(var_0, var_1, var_2) {
  if(self.asm.footsteps.foot == "right")
    var_3 = "right";
  else
    var_3 = "left";

  return scripts\asm\asm::asm_lookupanimfromalias(var_1, var_3 + "2");
}

_id_3414(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  self._id_4C7E = _id_0F3D::_id_22EA;
  self.a._id_22E5 = var_1;
  var_4 = self[[self._id_7191]](var_0, var_1);
  var_5 = getmovedelta(var_4);
  var_6 = getangledelta(var_4);
  var_7 = self.pathgoalpos;
  var_8 = self.angles;
  var_9 = rotatevector(var_5, var_8);
  var_10 = var_7 - var_9;
  self clearanim(_id_0A1E::asm_getbodyknob(), var_2);
  self _meth_82EA(var_1, var_4, 1, var_2, 1);
  var_11 = var_8[1] - var_6;
  self _meth_8396(var_10, var_11);
  _id_0A1E::_id_231F(var_0, var_1, scripts\asm\asm::_id_2341(var_0, var_1));
  self.a.movement = "stop";
}

_id_340F(var_0, var_1, var_2, var_3) {
  var_4 = anglesToForward(self.angles);

  if(isDefined(self.pathgoalpos)) {
    if(distancesquared(self.pathgoalpos, self.origin) > 144) {
      var_5 = vectorNormalize((self.lookaheaddir[0], self.lookaheaddir[1], 0));

      if(vectordot(var_5, var_4) <= 0.866)
        return 1;
    }

    return 0;
  } else if(isDefined(self.enemy)) {
    if(distancesquared(self.enemy.origin, self.origin) < self.meleechargedist * self.meleechargedist) {
      var_6 = vectorNormalize(self.enemy.origin - self.origin);

      if(vectordot(var_6, var_4) <= 0.866)
        return 1;
    }
  }

  return 0;
}

_id_3408(var_0, var_1, var_2) {
  var_3 = undefined;

  if(isDefined(self.pathgoalpos))
    var_3 = vectortoangles(self.lookaheaddir);
  else if(isDefined(self.enemy))
    var_3 = vectortoangles(self.enemy.origin - self.origin);

  var_4 = angleclamp180(var_3[1] - self.angles[1]);

  if(var_4 < -135)
    return _id_0A1E::_id_2357(var_0, var_1, "2l");
  else if(var_4 < 0)
    return _id_0A1E::_id_2357(var_0, var_1, "6");
  else if(var_4 > 135)
    return _id_0A1E::_id_2357(var_0, var_1, "2r");
  else if(var_4 >= 0)
    return _id_0A1E::_id_2357(var_0, var_1, "4");
}

_id_3418(var_0, var_1, var_2, var_3) {
  var_4 = self[[self._id_7191]](var_0, var_1);
  self clearanim(_id_0A1E::asm_getbodyknob(), var_2);
  self _meth_82EA(var_1, var_4, 1, var_2, 1);
  var_5 = getangledelta(var_4);
  var_6 = undefined;

  if(isDefined(self.pathgoalpos)) {
    var_7 = vectortoangles(self.lookaheaddir);
    var_6 = var_7[1] - var_5;
  } else if(isDefined(self.enemy)) {
    var_8 = self.enemy.origin - self.origin;
    var_9 = vectortoangles(var_8);
    var_6 = var_9[1] - var_5;
  }

  if(isDefined(var_6))
    self orientmode("face angle", var_6);

  _id_0A1E::_id_231F(var_0, var_1);
}

_id_3412(var_0, var_1, var_2, var_3) {
  self.asm.bpowereddown = 1;
  _id_3413(var_0, var_1, var_2);
}

_id_3419(var_0, var_1, var_2) {
  self.asm.bpowereddown = undefined;
}

_id_3413(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  var_4 = _id_0A1E::asm_getallanimsforstate(var_0, var_1);
  var_5 = 1 + (randomfloat(0.2) - 0.1);
  self clearanim(_id_0A1E::asm_getbodyknob(), var_2);
  self _meth_82EA(var_1, var_4, 1.0, var_2, var_5);
  var_6 = _id_0A1E::_id_231F(var_0, var_1, scripts\asm\asm::_id_2341(var_0, var_1));

  if(var_6 == "end")
    thread scripts\asm\asm::_id_2310(var_0, var_1, 0);
}

_id_3411(var_0, var_1, var_2, var_3) {
  var_4 = self[[self._id_7191]](var_0, var_1);
  self notify("c6_pain");
  self _meth_82EA(var_1, var_4, 1, var_2, 1);
  _id_0C66::_id_6CE0(var_0, var_1, []);
}

_id_3416(var_0, var_1, var_2, var_3) {
  self.asm._id_2AD2 = 1;
  self clearpath();
  _id_0C66::_id_D517(var_0, var_1, var_2, var_3);
}

_id_3417(var_0, var_1, var_2) {
  self.asm._id_2AD2 = 0;
  _id_0C66::_id_FE4D(var_0, var_1, var_2);
}

_id_9ED1(var_0) {
  foreach(var_2 in var_0) {
    if(var_2 == "end")
      return 1;
  }

  return 0;
}

_id_3410(var_0) {
  var_1 = "pain_move_default";
  var_2 = self[[self._id_7191]](var_0, var_1);
  self _meth_82EA(var_1, var_2, 1, 0.2, 1);

  for(;;) {
    self waittill(var_1, var_3);

    if(!isarray(var_3))
      var_3 = [var_3];

    if(_id_9ED1(var_3)) {
      break;
    }
  }

  var_4 = scripts\asm\asm::asm_lookupanimfromalias(var_1, "knob");
  self clearanim(var_4, 0.2);
  self.asm._id_2ACF = 0;
}

_id_3409(var_0) {
  self endon("death");
  self endon("terminate_ai_threads");
  self.asm._id_2AD2 = 0;
  self.asm._id_2ACF = 0;
  var_1 = self._id_164D[var_0];

  for(;;) {
    self waittill("damage");

    if(!isalive(self)) {
      break;
    }

    if(self.asm._id_2AD2) {
      continue;
    }
    var_2 = var_1._id_4BC0;
    var_3 = anim.asm[var_0].states[var_2];

    if(isDefined(var_3._id_C87F)) {
      [var_5, var_6] = scripts\asm\asm::_id_2310(var_0, var_3._id_C87F, 1);

      if(isDefined(var_5)) {
        scripts\asm\asm::asm_setstate(var_5, var_3._id_C87C);
        continue;
      }
    }

    if(self.asm._id_2ACF) {
      continue;
    }
    childthread _id_3410(var_0);
  }
}