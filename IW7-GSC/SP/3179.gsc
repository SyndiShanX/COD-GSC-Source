/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3179.gsc
**************************************/

_id_D55D(var_0, var_1, var_2, var_3) {
  self endon("death");
  self endon("terminate_ai_threads");
  _id_3E58(var_1);
  var_4 = _id_0A1E::asm_getallanimsforstate(var_0, var_1);
  self._id_5270 = "crouch";
  scripts\anim\utility::_id_12E5F();
  self endon("killanimscript");
  self animmode("noclip");
  var_5 = self _meth_8148();
  self orientmode("face angle", var_5.angles[1]);
  var_5._id_126D4 = var_5.origin[2] + var_5._id_126D5;
  var_6 = var_5._id_126D4 - var_5.origin[2];
  thread _id_11661(var_6 - var_3);
  var_2 = 0.15;
  var_7 = _id_0A1E::asm_getbodyknob();
  self clearanim(var_7, var_2);
  self _meth_82E7(var_1, var_4, 1, var_2, 1);
  var_8 = 0.2;
  var_9 = 0.2;
  thread _id_126D1(var_0, var_1);

  if(!animhasnotetrack(var_4, "gravity on")) {
    var_10 = 1.23;
    wait(var_10 - var_8);
    self animmode("gravity");
    wait(var_8);
  } else {
    self waittillmatch("traverse", "gravity on");
    self animmode("gravity");

    if(!animhasnotetrack(var_4, "blend")) {
      wait(var_8);
    } else {
      self waittillmatch("traverse", "blend");
    }
  }

  _id_11701(var_0, var_1);
}

_id_D566(var_0, var_1, var_2, var_3) {
  self endon("death");
  self endon("terminate_ai_threads");
  _id_3E58(var_1);
  var_4 = _id_0A1E::asm_getallanimsforstate(var_0, var_1);
  scripts\asm\asm_bb::bb_requestsmartobject("stand");
  var_5 = self _meth_8148();
  var_5._id_126D4 = var_5.origin[2] + var_5._id_126D5;
  self orientmode("face angle", var_5.angles[1]);
  self._id_126E6 = var_3;
  self._id_126EB = var_5;
  var_6 = 0;
  self animmode("noclip");
  self._id_126EC = self.origin[2];

  if(!animhasnotetrack(var_4, "traverse_align")) {
    _id_89F5();
  }

  var_7 = 0;
  _id_0A1E::_id_2369(var_0, var_1, var_4);
  self._id_126DB = var_4;
  self._id_126DD = _id_0A1E::asm_getbodyknob();
  self _meth_82E4(var_1, var_4, self._id_126DD, 1, 0.2, 1);
  self._id_126E3 = 0;
  self._id_126E2 = undefined;
  _id_0A1E::_id_231F(var_0, var_1, ::_id_89F8);
  self animmode("gravity");

  if(self.delayeddeath) {
    _id_11701(var_0, var_1);
    return;
  }

  self.a.nodeath = 0;

  if(var_7 && isDefined(self.node) && distancesquared(self.origin, self.node.origin) < 256) {
    self.a.movement = "stop";
    self _meth_83B9(self.node.origin);
  } else {
    self.a.movement = "run";
    self clearanim(var_4, 0.2);
  }

  self._id_126DD = undefined;
  self._id_126DB = undefined;
  self._id_4E2A = undefined;
  self._id_126EB = undefined;
  _id_11701(var_0, var_1);
}

_id_D55C(var_0, var_1, var_2, var_3) {
  var_4 = _id_0A1E::asm_getallanimsforstate(var_0, var_1);
  _id_3E58(var_1);
  self animmode("noclip");
  var_5 = self _meth_8148();
  self orientmode("face angle", var_5.angles[1]);
  self clearanim(_id_0A1E::asm_getbodyknob(), var_2);
  self _meth_82E7(var_1, var_4, 1, var_2, 1);
  _id_0A1E::_id_231F(var_0, var_1);
  _id_11701(var_0, var_1);
}

_id_11701(var_0, var_1) {
  self.useanimgoalweight = 0;
  self._id_A4CA = undefined;
  self._id_126C5 = undefined;
  self._id_126C3 = undefined;
  var_2 = anim.asm[var_0].states[var_1];
  var_3 = undefined;

  if(isDefined(var_2._id_116FB)) {
    if(isarray(var_2._id_116FB[0])) {
      var_3 = var_2._id_116FB[0];
    } else {
      var_3 = var_2._id_116FB;
    }
  }

  var_4 = isDefined(var_2.transitions) && var_2.transitions.size > 0;

  if(!var_4 && !isDefined(var_3)) {
    var_3 = "exposed_idle";
  }

  if(isDefined(var_3)) {
    thread scripts\asm\asm::asm_setstate(var_3, undefined);
  } else {
    scripts\asm\asm::asm_fireevent(var_1, "traverse_end");
  }

  self notify("killanimscript");
}

_id_11661(var_0) {
  self endon("killanimscript");
  self notify("endTeleportThread");
  self endon("endTeleportThread");
  var_1 = 5;
  var_2 = (0, 0, var_0 / var_1);

  for(var_3 = 0; var_3 < var_1; var_3++) {
    self _meth_80F1(self.origin + var_2);
    scripts\engine\utility::waitframe();
  }
}

_id_11662(var_0, var_1, var_2, var_3) {
  self endon("killanimscript");
  self endon("death");
  self notify("endTeleportThread");
  self endon("endTeleportThread");

  if(var_0 == 0 || var_2 <= 0) {
    return;
  }
  if(var_1 > 0) {
    wait(var_1);
  }

  var_4 = (0, 0, var_0 / var_2);

  if(isDefined(var_3) && var_3 < 1.0) {
    self _meth_82B1(self._id_126DB, var_3);
  }

  for(var_5 = 0; var_5 < var_2; var_5++) {
    self _meth_80F1(self.origin + var_4);
    scripts\engine\utility::waitframe();
  }

  if(isDefined(var_3) && var_3 < 1.0) {
    self _meth_82B1(self._id_126DB, 1.0);
  }
}

_id_89F8(var_0) {
  if(var_0 == "traverse_death") {
    return _id_89F6();
  } else if(var_0 == "traverse_align") {
    return _id_89F5();
  } else if(var_0 == "traverse_drop") {
    return _id_89F7();
  }
}

_id_89F6() {
  if(isDefined(self._id_126E2)) {
    var_0 = self._id_126E2[self._id_126E3];
    self._id_4E2A = var_0[randomint(var_0.size)];
    self._id_126E3++;
  }
}

_id_89F5() {
  self animmode("noclip");

  if(isDefined(self._id_126E6) && isDefined(self._id_126EB._id_126D4)) {
    var_0 = self._id_126EB._id_126D4 - self._id_126EC;
    thread _id_11661(var_0 - self._id_126E6);
  }
}

_id_89F7() {
  var_0 = self.origin + (0, 0, 32);
  var_1 = physicstrace(var_0, self.origin + (0, 0, -512));
  var_2 = distance(var_0, var_1);
  var_3 = var_2 - 32 - 0.5;
  var_4 = self islegacyagent(self._id_126DB);
  var_5 = getmovedelta(self._id_126DB, var_4, 1.0);
  var_6 = getanimlength(self._id_126DB);
  var_7 = var_4 * var_6;
  var_8 = 0 - var_5[2];
  var_9 = var_8 - var_3;

  if(var_8 < var_3) {
    var_10 = var_8 / var_3;
  } else {
    var_10 = 1;
  }

  var_11 = (var_6 - var_4) / 3.0;
  var_12 = (var_6 - var_7) / 3.0;
  var_13 = ceil(var_12 * 20);
  thread _id_11662(var_9, 0, var_13, var_10);
  thread _id_6CE5(var_1[2]);
}

_id_6CE5(var_0) {
  self endon("killanimscript");
  self endon("death");
  var_0 = var_0 + 4.0;

  for(;;) {
    if(self.origin[2] < var_0) {
      self animmode("gravity");
      break;
    }

    scripts\engine\utility::waitframe();
  }
}

_id_D55E(var_0, var_1, var_2, var_3) {
  self endon("death");
  self endon("terminate_ai_threads");
  self endon(var_1 + "_finished");
  var_4 = getdvarint("ai_debug_doublejump", 0);

  if(var_4 != 3 && var_4 != 4) {
    _id_3E58(var_1);
  }

  self._id_DC1A = 1;
  var_5 = self _meth_8148();
  var_6 = self _meth_8146();
  var_5._id_126D4 = var_5.origin[2] + var_5._id_126D5 - 44;
  var_7 = [];

  if(var_5._id_126D4 > var_6[2]) {
    var_8 = (var_5.origin[0] + var_6[0]) * 0.5;
    var_9 = (var_5.origin[1] + var_6[1]) * 0.5;
    var_7[var_7.size] = (var_8, var_9, var_5._id_126D4);
  }

  var_7[var_7.size] = var_6;
  var_11 = spawn("script_model", var_5.origin);
  var_11 setModel("tag_origin");
  var_11.angles = var_5.angles;
  thread scripts\engine\utility::delete_on_death(var_11);
  self orientmode("face angle", var_5.angles[1]);
  var_12 = 1.63;
  self linkTo(var_11);
  var_13 = _id_0A1E::asm_getallanimsforstate(var_0, var_1);
  self clearanim(_id_0A1E::asm_getbodyknob(), 0.2);
  _id_0A1E::_id_2369(var_0, var_1, var_13);
  self _meth_82EA(var_1, var_13, 1, var_2, 1);
  thread _id_126D1(var_0, var_1);

  foreach(var_15 in var_7) {
    var_16 = var_12 / var_7.size;
    var_11 moveTo(var_15, var_16);
    var_11 waittill("movedone");
  }

  self notify("double_jumped");
  self unlink();
  self._id_DC1A = undefined;
  var_11 delete();
  thread _id_11701(var_0, var_1);
}

_id_126D2(var_0, var_1, var_2) {
  self unlink();
  self._id_DC1A = undefined;
}

_id_D565(var_0, var_1, var_2, var_3) {
  var_4 = self _meth_8148();
  var_5 = self _meth_8145();
  _id_3E58(var_1);
  var_6 = distance(var_4.origin, var_5.origin);
  self animmode("noclip");
  self orientmode("face angle", var_4.angles[1]);
  var_7 = _id_0A1E::asm_getallanimsforstate(var_0, var_1);
  var_8 = getanimlength(var_7);
  var_9 = getmovedelta(var_7);
  var_10 = length(var_9) / var_8;
  var_11 = var_6 / var_10;
  self clearanim(_id_0A1E::asm_getbodyknob(), var_2);
  self _meth_82EA(var_1, var_7, 1.0, var_2, 1.0);
  wait(var_11);
  _id_11701(var_0, var_1);
}

_id_126D1(var_0, var_1) {
  self endon("death");
  self endon("terminate_ai_threads");
  self endon(var_1 + "_finished");
  self endon("double_jumped");
  _id_0A1E::_id_231F(var_0, var_1);
}

_id_D560(var_0, var_1, var_2, var_3) {
  self waittill("external_traverse_complete");
  _id_11701(var_0, var_1);
}

_id_CF1E(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  self animmode("noclip");
  self orientmode("face angle", self.angles[1]);
  self.useanimgoalweight = 1;
  var_4 = _id_0A1E::asm_getallanimsforstate(var_0, var_1);
  self _meth_82E7(var_1, var_4, 1, var_2, 1);
  _id_0A1E::_id_2369(var_0, var_1, var_4);
  _id_0A1E::_id_231F(var_0, var_1);
  thread _id_11701(var_0, var_1);
}

_id_7E83(var_0, var_1, var_2, var_3, var_4) {
  var_5 = _id_0F3D::_id_3E96(var_0, var_1);
  var_6 = getnotetracktimes(var_5, var_4);
  var_7 = var_6[0];
  var_8 = getmovedelta(var_5, 0, var_7);
  var_9 = getangledelta(var_5, 0, var_7);
  return _id_0C5E::_id_36D9(var_2, var_3[1], var_8, var_9);
}

_id_5AE3(var_0, var_1, var_2, var_3) {
  var_4 = var_3[2] - var_2.origin[2];

  if(var_4 < 0) {
    return 0;
  }

  if(isDefined(var_2._id_A4C9) && getdvarint("ai_debug_doublejump", 0) != 2) {
    var_5 = var_2._id_A4C9;
    var_6 = var_2.angles - var_2._id_10DCE;

    if(var_6 != (0, 0, 0)) {
      var_5 = rotatevector(var_5, var_6);
    }

    var_7 = var_2.origin + var_5;
    var_8 = var_7[2];
    var_8 = var_8 - 44;

    if(var_3[2] < var_8) {
      return 0;
    }
  }

  var_9 = var_3 - var_2.origin;
  var_9 = (var_9[0], var_9[1], 0);
  var_10 = vectortoangles(var_9);
  var_11 = _id_7E83(var_0, var_1, var_3, var_10, "footstep_left_small");
  var_12 = var_11 - var_2.origin;

  if(vectordot(var_12, var_9) < 0) {
    return 0;
  }

  return 1;
}

_id_3E04(var_0, var_1, var_2, var_3) {
  var_4 = _id_81D8();

  if(!isDefined(var_4)) {
    thread _id_11701(var_0, "double_jump");
    return 0;
  }

  var_5 = _id_81D7();

  if(!_id_5AE3(var_0, var_2, var_4, var_5)) {
    thread _id_11701(var_0, "double_jump");
    return 0;
  }

  return 1;
}

_id_81D8() {
  if(isDefined(self._id_126C5)) {
    return self._id_126C5;
  }

  return self _meth_8148();
}

_id_81D7() {
  if(isDefined(self._id_126C3)) {
    return self._id_126C3;
  }

  return self _meth_8146();
}

_id_CF21(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  var_4 = _id_81D8();
  var_5 = var_4._id_5AE2;
  var_6 = var_5 - var_4.origin;
  var_6 = (var_6[0], var_6[1], 0);
  var_7 = vectortoangles(var_6);
  var_8 = _id_0A1E::asm_getallanimsforstate(var_0, var_1);
  var_9 = var_1 + "_finish";
  var_10 = _id_7E83(var_0, var_9, var_5, var_7, "mantle_align");
  var_10 = (var_10[0], var_10[1], var_10[2] + var_3);
  _id_D50F(var_0, var_1, var_8, var_2, var_10, var_7, 1, 0, 1);
}

_id_CF1F(var_0, var_1, var_2, var_3) {
  _id_CF21(var_0, var_1, var_2, -8);
}

_id_CF26(var_0, var_1, var_2, var_3) {
  _id_CF21(var_0, var_1, var_2, -42);
}

doublejumpterminate(var_0, var_1, var_2) {
  self.useanimgoalweight = 0;
  self._id_A4CA = undefined;
  self._id_126C5 = undefined;
  self._id_126C3 = undefined;
}

doublejumpearlyterminate(var_0, var_1, var_2) {
  if(!scripts\asm\asm::_id_232B(var_1, "end")) {
    doublejumpterminate(var_0, var_1, var_2);
  }
}

isdriving(var_0, var_1, var_2, var_3) {
  return scripts\asm\asm::_id_68B0(var_0, var_1, var_2, "end");
}

_id_CF24(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  var_4 = _id_81D8();
  var_5 = _id_81D7();
  var_6 = var_4.angles - var_4._id_10DCE;

  if(var_6 != (0, 0, 0)) {
    var_5 = rotatevector(var_5, var_6);
  }

  var_7 = undefined;
  var_8 = getdvarint("ai_debug_doublejump", 0);

  if(var_8 != 2) {
    if(isDefined(var_4._id_A4C9)) {
      var_9 = var_4._id_A4C9;

      if(var_6 != (0, 0, 0)) {
        var_9 = rotatevector(var_9, var_6);
      }

      var_7 = var_4.origin + var_9;
      var_10 = var_7[2];
      var_10 = var_10 - 44;

      if(var_10 > var_5[2]) {
        var_11 = (var_4.origin[0] + var_5[0]) * 0.5;
        var_12 = (var_4.origin[1] + var_5[1]) * 0.5;
        var_7 = (var_11, var_12, var_7[2]);
      } else
        var_7 = undefined;
    }
  }

  var_13 = _id_0A1E::asm_getallanimsforstate(var_0, var_1);
  self._id_A4CA = var_7;
  var_14 = var_1 + "_finish";

  if(_id_5AE3(var_0, var_14, var_4, var_5)) {
    var_15 = var_5 - var_4.origin;
    var_15 = (var_15[0], var_15[1], 0);
    var_16 = vectortoangles(var_15);
    var_14 = var_1 + "_finish";
    var_17 = _id_7E83(var_0, var_14, var_5, var_16, "footstep_left_small");
    var_5 = var_17;
  }

  var_15 = var_5 - var_4.origin;
  var_18 = 0;
  var_19 = 1.0;

  if(var_15[2] < 0) {
    var_18 = 1;
    var_20 = getnotetracktimes(var_13, "gravity on");

    if(isDefined(var_20) && var_20.size > 0) {
      var_19 = var_20[0];
    }
  }

  var_15 = (var_15[0], var_15[1], 0);
  var_16 = vectortoangles(var_15);
  _id_D50F(var_0, var_1, var_13, var_2, var_5, var_16, var_19, var_18, 1);
}

_id_3ED2(var_0, var_1, var_2) {
  var_3 = _id_81D7();
  var_4 = "double_jump_up";

  if(isDefined(var_2)) {
    var_4 = "double_jump_" + var_2;
  } else if(var_3[2] < self.origin[2]) {
    var_4 = "double_jump_down";
  }

  if(self.asm.footsteps.foot == "right") {
    var_5 = "right_";
  } else {
    var_5 = "left_";
  }

  var_4 = var_5 + var_4;
  var_6 = scripts\asm\asm::asm_lookupanimfromalias(var_1, var_4);
  return var_6;
}

_id_820D(var_0, var_1) {
  var_2 = var_0.angles - var_0._id_138A6._id_10DCE;

  if(var_2 != (0, 0, 0)) {
    var_3 = rotatevector(var_0._id_138A6._id_C050[var_1], var_2);
    var_4 = var_0.origin + var_3;
  } else
    var_4 = var_0.origin + var_0._id_138A6._id_C050[var_1];

  return var_4;
}

_id_100BF(var_0, var_1, var_2, var_3) {
  if(!isDefined(self.enemy)) {
    return 0;
  }

  var_4 = self.enemy.origin;
  var_5 = self._id_126C5;
  var_6 = _id_820D(var_5, self._id_138BA);
  var_7 = _id_820D(var_5, self._id_138BA + 1);
  var_7 = (var_7[0], var_7[1], var_6[2]);
  var_4 = (var_4[0], var_4[1], var_6[2]);
  var_8 = vectorNormalize(var_7 - var_6);
  var_9 = vectorNormalize(var_4 - var_6);
  var_10 = vectordot(var_8, var_9);

  if(var_10 < 0.2588) {
    return 0;
  }

  return 1;
}

_id_3F0E(var_0, var_1, var_2) {
  var_3 = scripts\asm\asm::asm_lookupanimfromalias(var_1, self._id_138BC);
  return var_3;
}

_id_812B(var_0) {
  return var_0 * var_0 * (3 - 2 * var_0);
}

_id_11657(var_0, var_1, var_2, var_3, var_4, var_5) {
  self endon(var_0 + "_finished");

  if(var_1 > 0) {
    wait(var_1);
  }

  var_6 = var_2 / var_3;
  var_7 = self.origin[2];
  var_8 = var_7 + var_2[2];
  var_9 = self.origin[2];
  self _meth_82B1(var_4, var_5);

  for(var_10 = 0; var_10 < var_3; var_10++) {
    var_11 = 1;

    if(var_11) {
      var_12 = var_10 / (var_3 - 1);
      var_13 = _id_812B(var_12);
      var_14 = var_8 * var_13 + var_7 * (1 - var_13);
      var_15 = var_14 - var_9;
      var_6 = (var_6[0], var_6[1], var_15);
      var_9 = var_14;
    }

    var_16 = self.origin + var_6;
    self _meth_80F1(var_16);

    if(var_10 + 1 < var_3) {
      scripts\engine\utility::waitframe();
    }
  }

  self _meth_82B1(var_4, 1);
}

_id_138D4(var_0, var_1) {
  if(var_0 == "start_jump") {
    thread _id_89BB(var_1);
  } else if(var_0 == "end_mantle") {
    self animmode("gravity");
  }
}

_id_89BB(var_0, var_1, var_2) {
  var_3 = var_0[0];
  var_4 = var_0[1];
  var_5 = var_0[2];
  var_6 = var_0[3];
  var_7 = var_0[4];
  var_8 = var_0[5];
  var_9 = var_0[6];
  self endon(var_3 + "_finished");
  var_10 = getanimlength(var_4);

  if(!isDefined(var_1)) {
    var_1 = (gettime() - var_6) * 0.001;
  }

  var_11 = var_1 / var_10;
  var_12 = getnotetracktimes(var_4, "end_jump");
  var_13 = getnotetracktimes(var_4, "end_double_jump");

  if(var_13.size > 0) {
    self._id_138BD = 1;
    var_12 = var_13;
  } else
    self._id_138BD = 0;

  if(isDefined(self._id_A4CA)) {
    var_7 = (var_12[0] - var_11) / 2 + var_11;
    var_12[0] = var_7;
    var_5 = self._id_A4CA;
  }

  var_14 = getmovedelta(var_4, var_11, var_7);
  var_15 = self localtoworldcoords(var_14);

  if(!isDefined(var_2)) {
    var_2 = 1;
  }

  if(var_9) {
    var_16 = distance(self.origin, var_15);
    var_17 = distance(self.origin, var_5);
    var_2 = var_16 / var_17;

    if(var_2 < 0.7) {
      var_2 = 0.7;
    } else if(var_2 > 1.3) {
      var_2 = 1.3;
    }
  }

  var_19 = var_5 - var_15;
  var_20 = var_12[0] * var_10;
  var_21 = var_20 - var_11 * var_10;
  var_21 = var_21 * (1 / var_2);
  var_22 = var_21 * 20;
  var_22 = ceil(var_22);
  var_23 = gettime();
  _id_11657(var_3, 0, var_19, var_22, var_4, var_2);

  if(isDefined(self._id_A4CA)) {
    var_24 = (gettime() - var_23) * var_2;
    var_25 = var_1 + var_24 * 0.001;
    self._id_A4CA = undefined;
    var_0[6] = 0;
    _id_89BB(var_0, var_25, var_2);
  }
}

_id_8213(var_0) {
  var_1 = _id_820D(var_0, 1) - _id_820D(var_0, 0);
  var_2 = vectortoangles(var_1);
  return var_2[1];
}

_id_820F(var_0) {
  self._id_138BA = 0;
  var_1 = _id_820D(var_0, 1) - _id_820D(var_0, 0);
  var_2 = vectortoangles(var_1);
  self._id_138C1 = var_2[1];
  var_3 = _id_820D(var_0, self._id_138BA);
  var_4 = anglestoright(var_2);
  var_5 = var_3 - var_0.origin;
  var_6 = vectordot(var_4, var_5);

  if(var_6 > 0) {
    return "right";
  }

  return "left";
}

_id_FAF8() {
  if(isDefined(self._id_138BC)) {
    return;
  }
  if(!isDefined(self._id_126C5)) {
    self._id_126C5 = self _meth_8148();
    self._id_126C3 = self _meth_8146();
  }

  var_0 = self._id_126C5;
  self._id_138BC = _id_820F(var_0);
}

_id_820E() {
  _id_FAF8();
  return self._id_138BC;
}

wallrunterminate(var_0, var_1, var_2) {
  self._id_138BA = undefined;
  self._id_138BC = undefined;
  self._id_138BD = undefined;
  self._id_138C1 = undefined;
  self._id_138B9 = undefined;
  self _meth_82D0();
  self.useanimgoalweight = 0;
  self._id_A4CA = undefined;
  self._id_126C5 = undefined;
  self._id_126C3 = undefined;
}

_id_D5CF(var_0, var_1, var_2, var_3) {
  self animmode("noclip");
  self orientmode("face angle", self.angles[1]);
  self.useanimgoalweight = 1;

  if(isDefined(var_3) && var_3 == "shoot") {
    _id_FAF7();
  }

  var_4 = _id_0A1E::asm_getallanimsforstate(var_0, var_1);
  var_5 = getnotetracktimes(var_4, "wall_contact");
  var_6 = var_5[0];
  var_7 = getangledelta(var_4, 0, var_6);
  var_8 = self._id_138C1 - var_7;
  var_9 = (0, var_8, 0);
  self _meth_80F1(self.origin, var_9);
  self clearanim(_id_0A1E::asm_getbodyknob(), var_2);
  self _meth_82E7(var_1, var_4, 1.0, var_2, 1.0);
  _id_0A1E::_id_2369(var_0, var_1, var_4);
  var_10 = _id_0A1E::_id_231F(var_0, var_1, scripts\asm\asm::_id_2341(var_0, var_1));

  if(var_10 == "end") {
    thread scripts\asm\asm::_id_2310(var_0, var_1, 0);
  }
}

_id_820C(var_0) {
  var_1 = _id_3F0D(var_0, "wall_run_attach");
  var_2 = getnotetracktimes(var_1, "wall_contact");
  var_3 = var_2[0];
  var_4 = getmovedelta(var_1, 0, var_3);
  var_5 = getangledelta(var_1, 0, var_3);
  return _id_0C5E::_id_36D9(_id_820D(self._id_126C5, 0), self._id_138C1, var_4, var_5);
}

_id_D5D2(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  var_4 = _id_0A1E::asm_getallanimsforstate(var_0, var_1);
  var_5 = self._id_126C5;
  self._id_138BA = 0;
  var_6 = _id_820D(var_5, 0);
  var_7 = var_6 - self.origin;
  var_7 = (var_7[0], var_7[1], 0);
  var_8 = vectortoangles(var_7);
  var_9 = _id_820C();
  self orientmode("face angle", var_8[1]);
  var_10 = 1.0;
  var_11 = getnotetracktimes(var_4, "code_move");

  if(isDefined(var_11) && var_11.size > 0) {
    var_10 = var_11[0];
  }

  _id_D50F(var_0, var_1, var_4, var_2, var_9, var_8, var_10, 0, 1);
  self _meth_80F1(var_9, var_8);
  thread scripts\asm\asm::_id_2310(var_0, var_1, 0);
}

_id_D50F(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  self endon(var_1 + "_finished");

  if(!isDefined(var_6)) {
    var_6 = 1;
  }

  if(!isDefined(var_7)) {
    var_7 = 0;
  }

  if(!isDefined(var_8)) {
    var_8 = 0;
  }

  self _meth_80F1(self.origin, var_5);
  self animmode("noclip");
  self orientmode("face angle", var_5[1]);
  self.useanimgoalweight = 1;
  self _meth_82E7(var_1, var_2, 1, var_3, 1);
  _id_0A1E::_id_2369(var_0, var_1, var_2);
  var_9 = [var_1, var_2, var_4, gettime(), var_6, var_7, var_8];
  _id_0A1E::_id_231F(var_0, var_1, ::_id_138D4, var_9);
}

_id_3F0D(var_0, var_1, var_2) {
  if(isDefined(self._id_138B9)) {
    return self._id_138B9;
  }

  var_3 = self._id_138BC;
  var_4 = angleclamp180(self._id_138C1 - self.angles[1]);
  var_4 = abs(var_4);

  if(var_4 >= 22.5) {
    if(var_4 > 67.5) {
      var_3 = var_3 + "_90";
    } else {
      var_3 = var_3 + "_45";
    }
  }

  self._id_138B9 = scripts\asm\asm::asm_lookupanimfromalias(var_1, var_3);
  return self._id_138B9;
}

_id_3F0F(var_0, var_1, var_2) {
  _id_FAF8();
  var_3 = self._id_138BC;
  var_4 = self._id_126C5;
  var_5 = _id_820D(var_4, 0);
  var_6 = var_5[2] - self.origin[2];
  var_7 = 0;

  if(var_6 >= 0) {
    if(var_6 > 120) {
      var_7 = 1;
    }
  } else if(0 - var_6 > 240)
    var_7 = 1;

  if(var_7 == 0) {
    var_8 = distancesquared(self.origin, var_5);

    if(var_8 > 40000) {
      var_7 = 1;
    }
  }

  var_9 = "left_";

  if(self.asm.footsteps.foot == "right") {
    var_9 = "right_";
  }

  if(var_7) {
    var_3 = var_9 + "double_jump";
  } else {
    var_3 = var_9 + "single_jump";
  }

  var_10 = scripts\asm\asm::asm_lookupanimfromalias(var_1, var_3);
  return var_10;
}

_id_F22D(var_0, var_1, var_2, var_3) {
  self endon(var_0 + "_finished");
  wait(var_1);
  scripts\asm\asm::asm_fireevent(var_0, var_2);

  if(var_3) {
    self notify(var_2);
  }
}

_id_8BCB(var_0, var_1, var_2, var_3) {
  if(!isDefined(self._id_138BA)) {
    return 0;
  }

  var_4 = self._id_126C5;

  if(!isDefined(var_4)) {
    return 0;
  }

  var_5 = self._id_138BA + 2;

  if(var_4._id_138A6._id_C050.size <= var_5) {
    return 0;
  }

  return 1;
}

_id_D5D0(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  var_4 = self._id_126C5;
  scripts\anim\combat::_id_F296();
  self._id_138BA = self._id_138BA + 2;
  var_5 = _id_820D(var_4, self._id_138BA);
  var_6 = self.angles;

  if(self._id_138BC == "left") {
    self._id_138BC = "right";
  } else {
    self._id_138BC = "left";
  }

  var_7 = _id_0A1E::asm_getallanimsforstate(var_0, var_1);
  _id_D50F(var_0, var_1, var_7, var_2, var_5, var_6);
}

_id_8211(var_0) {
  var_1 = var_0.angles - var_0._id_138A6._id_10DCE;

  if(var_1 == (0, 0, 0)) {
    return var_0.origin + var_0._id_138A6._id_B313;
  }

  var_2 = rotatevector(var_0._id_138A6._id_B313, var_1);
  return var_0.origin + var_2;
}

_id_8210(var_0) {
  if(!isDefined(var_0._id_138A6._id_B312)) {
    return undefined;
  }

  var_1 = var_0.angles[1] - var_0._id_138A6._id_10DCE[1];

  if(var_1 == 0) {
    return var_0._id_138A6._id_B312;
  }

  return (0, angleclamp180(var_0._id_138A6._id_B312[1] + var_1), 0);
}

_id_8212() {
  var_0 = self._id_126C5;

  if(!isDefined(var_0._id_138A6._id_B313)) {
    return "none";
  }

  var_1 = _id_8211(var_0);

  if(var_1[2] >= self.origin[2]) {
    return "high";
  }

  return "low";
}

_id_100C0(var_0, var_1, var_2, var_3) {
  var_4 = self._id_126C5;

  if(!isDefined(var_4._id_138A6._id_331A)) {
    return 0;
  }

  return var_4._id_138A6._id_331A;
}

_id_D5D4(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  var_4 = self._id_126C5;
  _id_FAF7();
  var_5 = _id_0A1E::asm_getallanimsforstate(var_0, var_1);
  var_6 = getmovedelta(var_5);
  var_7 = length2d(var_6);

  if(!isDefined(var_4._id_138A6._id_B313) && self._id_138BA == var_4._id_138A6._id_C050.size - 2) {
    var_8 = _id_0A1E::asm_getallanimsforstate(var_0, "wall_run_exit");
    var_9 = getnotetracktimes(var_8, "start_jump");
    var_10 = getanimlength(var_8);
    var_11 = getmovedelta(var_8, 0, var_9[0]);
    var_12 = length2d(var_11);
  } else
    var_12 = 0;

  var_13 = _id_820D(var_4, self._id_138BA + 1) - self.origin;
  var_14 = length(var_13);
  var_14 = var_14 - var_12;

  if(var_14 < 0) {
    var_14 = 0;
  }

  var_15 = var_14 / var_7;
  var_16 = getanimlength(var_5);
  var_17 = var_16 * var_15;
  thread _id_F22D(var_1, var_17, "wall_run_loop_done", 1);
  var_18 = vectorNormalize(var_13);
  self orientmode("face direction", var_18);
  thread _id_D5D1(var_1);
  self animmode("noclip");
  self _meth_82E7(var_1, var_5, 1, var_2, 1);
  _id_0A1E::_id_2369(var_0, var_1, var_5);
  _id_0A1E::_id_231F(var_0, var_1);
}

_id_D5D1(var_0) {
  self endon("death");

  if(soundexists("wallrun_end_npc")) {
    self waittill("wall_run_loop_done");
    self playSound("wallrun_end_npc");
  }
}

_id_3F10(var_0, var_1, var_2) {
  var_3 = self._id_138BC;
  var_4 = self._id_126C3;
  var_5 = var_4[2] - self.origin[2];
  var_6 = 0;

  if(var_5 >= 0) {
    if(var_5 > 120) {
      var_6 = 1;
    }
  } else if(0 - var_5 > 240)
    var_6 = 1;

  if(var_6 == 0) {
    var_7 = distancesquared(self.origin, var_4);

    if(var_7 > 46225) {
      var_6 = 1;
    }
  }

  if(var_6) {
    var_3 = var_3 + "_double";
  }

  var_4 = self._id_126C3;
  var_8 = self._id_126C5;
  var_9 = self._id_126C3 - _id_820D(var_8, var_8._id_138A6._id_C050.size - 1);
  var_9 = (var_9[0], var_9[1], 0);
  var_9 = vectorNormalize(var_9);
  var_10 = vectortoangles(var_9);
  var_11 = angleclamp180(var_10[1] - self.angles[1]);
  var_11 = abs(var_11);

  if(var_11 >= 22.5) {
    if(var_11 > 67.5) {
      var_3 = var_3 + "_90";
    } else {
      var_3 = var_3 + "_45";
    }
  }

  var_12 = scripts\asm\asm::asm_lookupanimfromalias(var_1, var_3);
  return var_12;
}

_id_D5D3(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  var_4 = self._id_126C5;
  var_5 = self._id_126C3;
  var_6 = self.angles;
  var_7 = 1.0;
  var_8 = _id_0A1E::asm_getallanimsforstate(var_0, var_1);
  var_9 = getnotetracktimes(var_8, "ground");
  scripts\anim\combat::_id_F296();

  if(isDefined(var_9) && var_9.size > 0) {
    var_7 = var_9[0];
  } else {
    var_10 = getnotetracktimes(var_8, "end_double_jump");

    if(isDefined(var_10) && var_10.size > 0) {
      var_7 = var_10[0];
    } else {
      var_11 = getnotetracktimes(var_8, "end_jump");

      if(isDefined(var_11) && var_11.size > 0) {
        var_7 = var_11[0];
      }
    }
  }

  if(soundexists("wallrun_end_npc")) {
    self playSound("wallrun_end_npc");
  }

  _id_D50F(var_0, var_1, var_8, var_2, var_5, var_6, var_7, 1, 1);
  thread _id_11705(var_0, var_1);
}

_id_9EBA(var_0, var_1, var_2, var_3) {
  if(isDefined(self._id_126C5)) {
    return 0;
  }

  return 1;
}

_id_11705(var_0, var_1) {
  self._id_138BA = undefined;
  self._id_138BC = undefined;
  self._id_138BD = undefined;
  self._id_138C1 = undefined;
  self._id_138B9 = undefined;
  self _meth_82D0();
  _id_11701(var_0, var_1);
}

_id_D5D5(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  var_4 = self._id_126C5;
  var_5 = self._id_126C3;
  var_6 = _id_8211(var_4);

  if(isDefined(var_4._id_138A6._id_331A) || _id_8212() == "high") {
    var_7 = _id_8210(var_4);

    if(!isDefined(var_7)) {
      var_8 = var_5 - var_6;
      var_8 = (var_8[0], var_8[1], 0);
      var_7 = vectortoangles(var_8);
    }
  } else {
    var_8 = var_6 - self.origin;
    var_8 = (var_8[0], var_8[1], 0);
    var_7 = vectortoangles(var_8);
  }

  var_9 = _id_0A1E::asm_getallanimsforstate(var_0, var_1);
  var_10 = getanimlength(var_9);
  var_11 = getnotetracktimes(var_9, "start_mantle");
  var_12 = var_11[0];
  var_13 = getnotetracktimes(var_9, "end_mantle");
  var_14 = var_13[0];
  var_15 = getmovedelta(var_9, var_12, var_14);
  self _meth_80F1(self.origin, var_7);
  var_16 = self localtoworldcoords(var_15);
  var_17 = var_16 - self.origin;
  var_18 = var_6 - var_17;
  _id_D50F(var_0, var_1, var_9, var_2, var_18, var_7, var_12, 0, 1);
  thread _id_11705(var_0, var_1);
}

_id_D55B(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  var_4 = _id_0A1E::asm_getallanimsforstate(var_0, var_1);

  if(!isDefined(var_4)) {
    scripts\asm\asm::asm_fireevent(var_1, "code_move");
    return;
  }

  var_5 = 1.0;
  var_6 = undefined;

  if(getdvarint("ai_wall_run_use_align_notetrack", 1) == 1) {
    var_6 = getnotetracktimes(var_4, "align");
  }

  if(!isDefined(var_6) || var_6.size == 0) {
    var_6 = getnotetracktimes(var_4, "code_move");
  }

  if(isDefined(var_6) && var_6.size > 0) {
    var_5 = var_6[0];
  }

  var_7 = getmovedelta(var_4, 0, var_5);
  var_8 = getangledelta(var_4, 0, var_5);
  var_9 = self._id_126C5;
  var_10 = getanimlength(var_4) * var_5;
  var_11 = int(ceil(var_10 * 20));

  if(self._id_126C5.animscript == "wall_run") {
    var_12 = _id_820D(self._id_126C5, 0) - self.origin;
    var_13 = vectortoangles(var_12);
    var_14 = var_13[1];
  } else {
    var_15 = self._id_126C3 - self._id_126C5.origin;
    var_15 = (var_15[0], var_15[1], 0);
    var_16 = vectortoangles(var_15);
    var_14 = var_16[1];
  }

  var_17 = _id_0C5E::_id_36D9(var_9.origin, var_14, var_7, var_8);
  var_18 = var_14 - var_8;
  self._id_4C7E = _id_0F3D::_id_22EA;
  self.a._id_22E5 = var_1;
  self.useanimgoalweight = 1;
  self _meth_8396(var_17, var_18, var_11);
  self clearanim(_id_0A1E::asm_getbodyknob(), var_2);
  self _meth_82E7(var_1, var_4, 1.0, var_2, 1.0);
  _id_0A1E::_id_2369(var_0, var_1, var_4);
  _id_0A1E::_id_231F(var_0, var_1, scripts\asm\asm::_id_2341(var_0, var_1));
  thread scripts\asm\asm::_id_2310(var_0, var_1, 0);
}

_id_3F12(var_0, var_1, var_2) {
  return _id_0C65::_id_3EF5(var_0, var_1, var_2);
}

_id_3F07(var_0, var_1, var_2) {
  var_3 = anglesToForward(self.angles);
  var_4 = vectortoangles(var_3);

  if(self._id_126C5.animscript == "wall_run") {
    var_5 = vectortoangles(_id_820D(self._id_126C5, 0) - self.origin);
  } else {
    var_6 = self._id_126C3 - self._id_126C5.origin;
    var_6 = (var_6[0], var_6[1], 0);
    var_5 = vectortoangles(var_6);
  }

  var_7 = var_5[1];
  var_8 = angleclamp180(var_7 - var_4[1]);
  var_9 = getangleindex(var_8, 22.5);
  var_10 = _id_0C5D::_id_8174(var_1, undefined, 1);

  if(!isDefined(var_10[var_9])) {
    return undefined;
  }

  return var_10[var_9];
}

_id_FAF0(var_0, var_1, var_2, var_3) {
  var_4 = self _meth_84F9(120);

  if(!isDefined(var_4)) {
    return 0;
  }

  var_5 = var_4["node"];
  var_6 = var_4["position"];

  if(!isDefined(var_5) || !isDefined(var_5.animscript)) {
    return 0;
  }

  self._id_126C5 = var_5;
  self._id_126C3 = var_6;
  return 1;
}

_id_4123(var_0, var_1, var_2, var_3) {
  self._id_126C5 = undefined;
  self._id_126C3 = undefined;
  return 0;
}

_id_FFB7(var_0, var_1, var_2, var_3) {
  var_4 = distance2dsquared(self.origin, _id_820D(self._id_126C5, 1));

  if(var_4 < 144) {
    return 1;
  }

  return 0;
}

_id_FFFD(var_0, var_1, var_2, var_3) {
  if(_id_9EBA(var_0, var_1, var_2, var_3)) {
    _id_FAF0(var_0, var_1, var_2, var_3);

    if(!isDefined(self._id_126C5)) {
      return 0;
    }

    if(self._id_126C5.animscript != "wall_run") {
      return 0;
    }

    var_4 = self._id_126C5;
    var_5 = vectorNormalize(_id_820D(var_4, 0) - self.origin);
    var_6 = _id_0C65::_id_371C(var_1, var_2, var_5, 0, 1);

    if(!isDefined(var_6)) {
      return 0;
    }

    self.a._id_FC61 = var_6;
    self._id_138BC = _id_820F(self._id_126C5);
    return 1;
  }

  return 0;
}

_id_100B3(var_0, var_1, var_2, var_3) {
  if(var_2 == self._id_126C5.animscript) {
    return 1;
  }

  return 0;
}

_id_9FB1(var_0) {
  switch (var_0) {
    case "rail_hop_double_jump_down":
    case "double_jump":
    case "double_jump_mantle":
    case "double_jump_vault":
    case "wall_run":
      return 1;
  }

  return 0;
}

_id_FFFC(var_0, var_1, var_2, var_3) {
  if(!isDefined(self._id_126C5)) {
    return 0;
  }

  if(!_id_9FB1(self._id_126C5.animscript)) {
    return 0;
  }

  if(!self.facemotion) {
    return 0;
  }

  var_4 = undefined;

  if(self._id_126C5.animscript == "wall_run") {
    var_4 = _id_820F(self._id_126C5);
    var_5 = _id_820D(self._id_126C5, 0) - self.origin;
    var_6 = vectortoangles(var_5);
  } else {
    var_5 = self._id_126C3 - self._id_126C5.origin;
    var_5 = (var_5[0], var_5[1], 0);
    var_4 = vectorNormalize(var_5);
    var_6 = vectortoangles(var_4);
  }

  var_7 = var_6[1];
  var_8 = anglesToForward(self.angles);
  var_9 = vectortoangles(var_8);
  var_10 = angleclamp180(var_7 - var_9[1]);
  var_11 = getangleindex(var_10, 22.5);
  var_12 = _id_0C5D::_id_8174(var_2, undefined, 1);
  var_13 = var_12[var_11];

  if(!isDefined(var_13)) {
    return 0;
  }

  var_14 = 1.0;
  var_15 = undefined;

  if(getdvarint("ai_wall_run_use_align_notetrack", 1) == 1) {
    var_15 = getnotetracktimes(var_13, "align");
  }

  if(!isDefined(var_15) || var_15.size == 0) {
    var_15 = getnotetracktimes(var_13, "code_move");
  }

  if(isDefined(var_15) && var_15.size > 0) {
    var_14 = var_15[0];
  }

  var_16 = getmovedelta(var_13, 0, var_14);
  var_17 = getangledelta(var_13, 0, var_14);
  var_18 = distance2d(self.origin, self._id_126C5.origin);
  var_19 = length(var_16);
  var_20 = var_18 - var_19;

  if(var_20 < 0) {
    var_21 = anglesToForward(var_6);
    var_22 = vectordot(var_8, var_21);

    if(var_22 > 0.707) {
      if(abs(var_20) > 10) {
        return 0;
      }
    } else if(abs(var_20) > 64)
      return 0;
  } else if(var_20 > 10)
    return 0;

  if(self._id_126C5.animscript == "wall_run") {
    self._id_138BC = var_4;
  }

  return 1;
}

_id_89FB(var_0) {
  if(var_0 == "wall_contact") {
    if(soundexists("wallrun_start_npc")) {
      self playSound("wallrun_start_npc");
    }
  }
}

_id_FAF7() {
  self.upaimlimit = -45;
  self.downaimlimit = 45;
  self.rightaimlimit = -90;
  self.leftaimlimit = 90;
}

_id_126CE(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  var_4 = _id_0A1E::asm_getallanimsforstate(var_0, var_1);
  self clearanim(_id_0A1E::asm_getbodyknob(), var_2);
  self animmode("noclip", 0);
  var_5 = self _meth_8148();
  self orientmode("face angle", var_5.angles[1]);
  self _meth_82EA(var_1, var_4, 1.0, var_2, 1.0);
  _id_0A1E::_id_231F(var_0, var_1, scripts\asm\asm::_id_2341(var_0, var_1));
  _id_11701(var_0, var_1);
}

_id_3E58(var_0) {}