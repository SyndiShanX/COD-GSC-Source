/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2797.gsc
*************************************************/

_id_4E87() {
  self endon("killanimscript");
  var_0 = self _meth_8161();
  var_1 = var_0._id_005D;
  self notify("traverse_begin", var_1, var_0);
  self waittill("traverse_end");
}

_id_35D0(var_0, var_1, var_2) {
  return 0;
}

_id_982F(var_0, var_1, var_2) {
  self endon(var_1 + "_finished");
  self endon("terminate_ai_threads");
  var_3 = "loop_end";
  var_4 = 2;

  if(_func_0107(var_2)) {
    if(var_2.size > 0) {
      var_4 = var_2[0];
    }

    if(var_2.size > 1) {
      var_3 = var_2[1];
    }
  } else
    var_4 = var_2;

  thread _id_0009::_id_1C81(var_0, var_1, 1);
  wait(var_4);
  _id_0009::_id_1C53(var_0, var_3);
}

_id_107FE(var_0, var_1) {
  self endon(var_1 + "_finished");

  if(self _meth_85EC()) {
    self _meth_84E7();
    self waittill("stop_soon");
    self._id_19FC = self._id_027F;
    _id_0009::_id_1C53(var_0, "cover_approach", self._id_19FC);
  }
}

_id_10818(var_0, var_1) {
  self endon(var_1 + "_finished");
  self waittill("path_set");
  var_2 = self.origin + self._id_027F * self._id_0280;
  var_3 = [0, var_2, 1, self.origin, self._id_0280];
  _id_0009::_id_1C53(var_0, "sharp_turn", var_3);
  thread _id_10818(var_0, var_1);
}

_id_10827(var_0, var_1, var_2) {}

_id_B89B(var_0, var_1, var_2) {
  thread _id_107FE(var_0, var_1);

  if(self _meth_85EC()) {
    thread _id_10827(var_0, var_1);
  } else {
    thread _id_08F1::_id_10826(var_0, var_1);
  }

  thread _id_10818(var_0, var_1);
  var_3 = 1.0;

  if(isDefined(self._id_1C30._id_A246)) {
    var_3 = self._id_1C30._id_A246;
  } else if(isDefined(self._id_A246)) {
    var_3 = self._id_A246;
  }

  _id_0009::_id_1C81(var_0, var_1, var_3, 1);
}

_id_884A(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 0.5;
  }

  var_1 = anglesToForward(self.angles);
  var_2 = vectornormalize(self._id_0192.origin - self.origin);
  var_3 = vectordot(var_1, var_2);

  if(var_3 < var_0) {
    return 0;
  }

  return 1;
}

_id_8B05() {
  if(_id_8738()) {
    return 1;
  }

  return 0;
}

_id_109CC() {
  if(_id_06BD::_id_23C7() == "crouch") {
    return 1;
  }

  return 0;
}

getshootposmp(var_0) {
  if(!istrue(self._id_0B67._id_03CE)) {
    return undefined;
  } else if(isDefined(self._id_0B67._id_03C3)) {
    return self._id_0B67._id_03C3 _meth_8176();
  } else if(isDefined(self._id_0B67._id_03C8)) {
    return self._id_0B67._id_03C8;
  } else if(isDefined(self._id_0192)) {
    return self._id_0192 _meth_8176();
  }

  return undefined;
}

_id_8738() {
  if(!isDefined(self._id_0B67._id_03C8) && !isDefined(self._id_0B67._id_03C3)) {
    return 1;
  }

  var_0 = self _meth_815B();
  var_1 = self _meth_884D();
  var_2 = getshootposmp(var_1);

  if(!isDefined(var_2)) {
    return 0;
  }

  var_3 = vectortoangles(var_2 - var_1);
  var_4 = _func_043F(var_0[1] - var_3[1]);

  if(var_4 > anim._id_135E) {
    if(distancesquared(self getEye(), var_2) > anim._id_135C || var_4 > anim._id_135D) {}
  }

  var_5 = _id_6893();
  return _func_043F(var_0[0] - var_3[0]) <= var_5;
}

_id_6893() {
  if(isDefined(self._id_1351)) {
    return self._id_1351;
  } else {
    return anim._id_1351;
  }
}

_id_46DD(var_0, var_1, var_2, var_3) {}

_id_46D2(var_0, var_1, var_2) {}

_id_18D0(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(isDefined(var_5)) {
    thread _id_18D4(var_5);
  }

  if(istrue(var_3)) {
    thread _id_18D2(var_0, var_1, var_2, var_4);
  } else {
    thread _id_18D3(var_0, var_1, var_2, var_4);
  }
}

animscriptintroloopmp(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(isDefined(var_5)) {
    thread _id_18D4(var_5);
  }

  thread animscriptmp_intro_loop_internal(var_0, var_1, var_2, var_3, var_4);
}

animscriptmp_intro_loop_internal(var_0, var_1, var_2, var_3, var_4) {
  self endon("CancelAnimscriptMP");
  self endon("death");
  _id_18D1(var_0, var_1, var_2, var_4);
  _id_18D2(var_0, var_1, var_3, var_4);
}

_id_3158() {
  if(!_id_06BD::_id_23CE()) {
    return 0;
  }

  _id_3159();
  self notify("CancelAnimscriptMP");
}

_id_18D4(var_0) {
  self endon("AnimscriptMP_Complete");
  self endon("death");
  self endon("CancelAnimscriptMP");
  self waittill(var_0);
  _id_3158();
}

_id_18D3(var_0, var_1, var_2, var_3) {
  _id_18D1(var_0, var_1, var_2, var_3);

  if(isDefined(self) && isalive(self)) {
    _id_3159();
    self notify("AnimscriptMP_Complete");
  }
}

_id_18D2(var_0, var_1, var_2, var_3) {
  self endon("CancelAnimscriptMP");
  self endon("death");

  for(;;) {
    _id_18D1(var_0, var_1, var_2, var_3);
  }
}

_id_18D1(var_0, var_1, var_2, var_3) {
  self endon("CancelAnimscriptMP");
  self endon("death");

  if(!isDefined(var_3)) {
    var_3 = 1;
  }

  self _meth_87CB("animscript", var_0, 1);
  _id_06BE::_id_1C9C();
  var_4 = _func_031D(var_0, var_1, var_2, _id_0009::_id_1C7B());
  self _meth_85ED(var_1, var_4, var_3);
  self _meth_85F5(var_1, var_4, var_3);
  var_5 = _func_038B(var_0, var_1, var_4);
  var_6 = _func_0079(var_5);
  self._id_CF4A = 1;
  self._id_0229 = 1;
  wait(var_6 / var_3);
}

_id_3159() {
  _id_06BD::_id_23AD();
  self _meth_87CC("animscript", 0, 0);
  self._id_CF4A = 0;
  self._id_0229 = 0;
}

_id_18C7(var_0, var_1, var_2) {
  _id_06BE::_id_1C9C();

  if(!isDefined(var_2)) {
    var_2 = "animscripted";
  }

  var_3 = _id_0009::_id_1C7D(var_2, var_0);
  self _meth_85ED(var_2, var_3);

  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  if(!var_1) {
    var_4 = _id_0009::_id_1C6E(var_2, var_3);
    var_5 = _func_0079(var_4);
    wait(var_5);
  }
}

_id_18C9(var_0, var_1) {
  _id_06BE::_id_1C9C();
  var_2 = _id_0009::_id_1C7D("animscripted", var_0);
  self _meth_85ED("animscripted", var_2);
  var_3 = _id_0009::_id_1C6E("animscripted", var_2);
  var_4 = _func_0079(var_3);

  if(var_1 < var_4) {
    wait(var_4 - var_1);
  }
}

_id_18C2(var_0) {
  _id_06BE::_id_1C9C();
  var_1 = _id_0009::_id_1C7D("animscripted", var_0);
  var_2 = _id_0009::_id_1C6E("animscripted", var_1);
  var_3 = _func_0079(var_2);

  if(var_3 < 0.05) {
    var_3 = 0.05;
  }

  for(;;) {
    self _meth_85ED("animscripted", var_1);
    wait(var_3);
  }
}

_id_18C3(var_0, var_1) {
  _id_06BE::_id_1C9C();
  var_2 = _id_0009::_id_1C7D("animscripted", var_0);
  var_3 = _id_0009::_id_1C6E("animscripted", var_2);
  var_4 = _func_0079(var_3);

  if(var_1 < var_4) {
    var_4 = var_4 - var_1;
  }

  if(var_4 < 0.05) {
    var_4 = 0.05;
  }

  for(;;) {
    self _meth_85ED("animscripted", var_2);
    wait(var_4);
  }
}

_id_18C4(var_0, var_1) {
  _id_06BE::_id_1C9C();
  var_2 = _id_0009::_id_1C7D("animscripted", var_0);
  var_3 = _id_0009::_id_1C6E("animscripted", var_2);
  var_4 = _func_0079(var_3);

  if(var_4 < 0.05) {
    var_4 = 0.05;
  }

  for(var_5 = var_1; var_5 >= 0; var_5 = var_5 - var_4) {
    self _meth_85ED("animscripted", var_2);
    wait(var_4);
  }
}

_id_18C5(var_0, var_1) {
  _id_06BE::_id_1C9C();
  var_2 = _id_0009::_id_1C7D("animscripted", var_0);
  var_3 = _id_0009::_id_1C6E("animscripted", var_2);
  var_4 = _func_0079(var_3);

  if(var_4 < 0.05) {
    var_4 = 0.05;
  }

  while(var_1 > 0) {
    self _meth_85ED("animscripted", var_2);
    wait(var_4);
    var_1--;
  }
}

_id_18C6(var_0, var_1, var_2) {
  _id_06BE::_id_1C9C();
  var_3 = _id_0009::_id_1C7D("animscripted", var_0);
  var_4 = _id_0009::_id_1C6E("animscripted", var_3);

  if(isDefined(var_2)) {
    var_5 = var_1 gettagorigin(var_2);
    var_6 = var_1 gettagangles(var_2);
  } else {
    var_5 = var_1.origin;
    var_6 = var_1.angles;
  }

  var_7 = getstartorigin(var_5, var_6, var_4);
  var_8 = _func_00D2(var_5, var_6, var_4);
  self dontinterpolate();
  self _meth_80F9(var_7, var_8, 9999999, 0);

  for(;;) {
    self _meth_85ED("animscripted", var_3);
    var_9 = _func_0079(var_4);
    wait(var_9);
  }
}

_id_18CA(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_4)) {
    var_4 = "animscripted";
  }

  _id_06BE::_id_1C9C();
  var_5 = _id_0009::_id_1C7D(var_4, var_0);
  var_6 = _id_0009::_id_1C6E(var_4, var_5);

  if(isDefined(var_2)) {
    var_7 = var_1 gettagorigin(var_2);
    var_8 = var_1 gettagangles(var_2);
  } else {
    var_7 = var_1.origin;
    var_8 = var_1.angles;
  }

  var_9 = getstartorigin(var_7, var_8, var_6);
  var_10 = _func_00D2(var_7, var_8, var_6);
  self dontinterpolate();
  self _meth_80F9(var_9, var_10, 9999999, 0);
  self _meth_85ED(var_4, var_5);

  if(!isDefined(var_3)) {
    var_3 = 0;
  }

  if(!var_3) {
    var_11 = _func_0079(var_6);
    wait(var_11);
  }
}

_id_18C8(var_0, var_1, var_2, var_3) {
  _id_06BE::_id_1C9C();
  var_4 = _id_0009::_id_1C7D("animscripted", var_0);
  var_5 = _id_0009::_id_1C6E("animscripted", var_4);
  var_6 = _func_00B0(var_5);
  var_7 = _func_0078(var_5);
  var_8 = _func_0047(var_2, _func_00FF(var_7));
  var_9 = var_1 - rotatevector(var_6, var_8);
  self dontinterpolate();
  self _meth_80F9(var_9, var_8, 9999999, 0);
  self _meth_85ED("animscripted", var_4);

  if(!isDefined(var_3)) {
    var_3 = 0;
  }

  if(!var_3) {
    var_10 = _func_0079(var_5);
    wait(var_10);
  }
}

_id_18C1() {
  _id_06BD::_id_23AD();
}