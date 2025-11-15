/************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: 3179.gsc
************************/

func_D55D(param_00, param_01, param_02, param_03) {
  self endon("death");
  self endon("terminate_ai_threads");
  func_3E58(param_01);
  var_04 = lib_0A1E::asm_getallanimsforstate(param_00, param_01);
  self.var_5270 = "crouch";
  scripts\anim\utility::func_12E5F();
  self endon("killanimscript");
  self animmode("noclip");
  var_05 = self getspectatepoint();
  self orientmode("face angle", var_05.angles[1]);
  var_05.var_126D4 = var_05.origin[2] + var_05.var_126D5;
  var_06 = var_05.var_126D4 - var_05.origin[2];
  thread func_11661(var_06 - param_03);
  param_02 = 0.15;
  var_07 = lib_0A1E::asm_getbodyknob();
  self clearanim(var_07, param_02);
  self _meth_82E7(param_01, var_04, 1, param_02, 1);
  var_08 = 0.2;
  var_09 = 0.2;
  thread func_126D1(param_00, param_01);
  if(!animhasnotetrack(var_04, "gravity on")) {
    var_0A = 1.23;
    wait(var_0A - var_08);
    self animmode("gravity");
    wait(var_08);
  } else {
    self waittillmatch("gravity on", "traverse");
    self animmode("gravity");
    if(!animhasnotetrack(var_04, "blend")) {
      wait(var_08);
    } else {
      self waittillmatch("blend", "traverse");
    }
  }

  func_11701(param_00, param_01);
}

func_D566(param_00, param_01, param_02, param_03) {
  self endon("death");
  self endon("terminate_ai_threads");
  func_3E58(param_01);
  var_04 = lib_0A1E::asm_getallanimsforstate(param_00, param_01);
  scripts\asm\asm_bb::bb_requestsmartobject("stand");
  var_05 = self getspectatepoint();
  var_05.var_126D4 = var_05.origin[2] + var_05.var_126D5;
  self orientmode("face angle", var_05.angles[1]);
  self.var_126E6 = param_03;
  self.var_126EB = var_05;
  var_06 = 0;
  self animmode("noclip");
  self.var_126EC = self.origin[2];
  if(!animhasnotetrack(var_04, "traverse_align")) {
    func_89F5();
  }

  var_07 = 0;
  lib_0A1E::func_2369(param_00, param_01, var_04);
  self.var_126DB = var_04;
  self.var_126DD = lib_0A1E::asm_getbodyknob();
  self _meth_82E4(param_01, var_04, self.var_126DD, 1, 0.2, 1);
  self.var_126E3 = 0;
  self.var_126E2 = undefined;
  lib_0A1E::func_231F(param_00, param_01, ::func_89F8);
  self animmode("gravity");
  if(self.var_EB) {
    func_11701(param_00, param_01);
    return;
  }

  self.a.nodeath = 0;
  if(var_07 && isDefined(self.target_getindexoftarget) && distancesquared(self.origin, self.target_getindexoftarget.origin) < 256) {
    self.a.movement = "stop";
    self _meth_83B9(self.target_getindexoftarget.origin);
  } else {
    self.a.movement = "run";
    self clearanim(var_04, 0.2);
  }

  self.var_126DD = undefined;
  self.var_126DB = undefined;
  self.var_4E2A = undefined;
  self.var_126EB = undefined;
  func_11701(param_00, param_01);
}

func_D55C(param_00, param_01, param_02, param_03) {
  var_04 = lib_0A1E::asm_getallanimsforstate(param_00, param_01);
  func_3E58(param_01);
  self animmode("noclip");
  var_05 = self getspectatepoint();
  self orientmode("face angle", var_05.angles[1]);
  self clearanim(lib_0A1E::asm_getbodyknob(), param_02);
  self _meth_82E7(param_01, var_04, 1, param_02, 1);
  lib_0A1E::func_231F(param_00, param_01);
  func_11701(param_00, param_01);
}

func_11701(param_00, param_01) {
  self.var_36A = 0;
  self.var_A4CA = undefined;
  self.var_126C5 = undefined;
  self.var_126C3 = undefined;
  var_02 = level.asm[param_00].states[param_01];
  var_03 = undefined;
  if(isDefined(var_02.var_116FB)) {
    if(isarray(var_02.var_116FB[0])) {
      var_03 = var_02.var_116FB[0];
    } else {
      var_03 = var_02.var_116FB;
    }
  }

  var_04 = isDefined(var_02.transitions) && var_02.transitions.size > 0;
  if(!var_04 && !isDefined(var_03)) {
    var_03 = "exposed_idle";
  }

  if(isDefined(var_03)) {
    thread scripts\asm\asm::asm_setstate(var_03, undefined);
  } else {
    scripts\asm\asm::asm_fireevent(param_01, "traverse_end");
  }

  self notify("killanimscript");
}

func_11661(param_00) {
  self endon("killanimscript");
  self notify("endTeleportThread");
  self endon("endTeleportThread");
  var_01 = 5;
  var_02 = (0, 0, param_00 / var_01);
  for(var_03 = 0; var_03 < var_01; var_03++) {
    self _meth_80F1(self.origin + var_02);
    scripts\engine\utility::waitframe();
  }
}

func_11662(param_00, param_01, param_02, param_03) {
  self endon("killanimscript");
  self endon("death");
  self notify("endTeleportThread");
  self endon("endTeleportThread");
  if(param_00 == 0 || param_02 <= 0) {
    return;
  }

  if(param_01 > 0) {
    wait(param_01);
  }

  var_04 = (0, 0, param_00 / param_02);
  if(isDefined(param_03) && param_03 < 1) {
    self _meth_82B1(self.var_126DB, param_03);
  }

  for(var_05 = 0; var_05 < param_02; var_05++) {
    self _meth_80F1(self.origin + var_04);
    scripts\engine\utility::waitframe();
  }

  if(isDefined(param_03) && param_03 < 1) {
    self _meth_82B1(self.var_126DB, 1);
  }
}

func_89F8(param_00) {
  if(param_00 == "traverse_death") {
    return func_89F6();
  }

  if(param_00 == "traverse_align") {
    return func_89F5();
  }

  if(param_00 == "traverse_drop") {
    return func_89F7();
  }
}

func_89F6() {
  if(isDefined(self.var_126E2)) {
    var_00 = self.var_126E2[self.var_126E3];
    self.var_4E2A = var_00[randomint(var_00.size)];
    self.var_126E3++;
  }
}

func_89F5() {
  self animmode("noclip");
  if(isDefined(self.var_126E6) && isDefined(self.var_126EB.var_126D4)) {
    var_00 = self.var_126EB.var_126D4 - self.var_126EC;
    thread func_11661(var_00 - self.var_126E6);
  }
}

func_89F7() {
  var_00 = self.origin + (0, 0, 32);
  var_01 = physicstrace(var_00, self.origin + (0, 0, -512));
  var_02 = distance(var_00, var_01);
  var_03 = var_02 - 32 - 0.5;
  var_04 = self getscoreinfocategory(self.var_126DB);
  var_05 = getmovedelta(self.var_126DB, var_04, 1);
  var_06 = getanimlength(self.var_126DB);
  var_07 = var_04 * var_06;
  var_08 = 0 - var_05[2];
  var_09 = var_08 - var_03;
  if(var_08 < var_03) {
    var_0A = var_08 / var_03;
  } else {
    var_0A = 1;
  }

  var_0B = var_06 - var_04 / 3;
  var_0C = var_06 - var_07 / 3;
  var_0D = ceil(var_0C * 20);
  thread func_11662(var_09, 0, var_0D, var_0A);
  thread func_6CE5(var_01[2]);
}

func_6CE5(param_00) {
  self endon("killanimscript");
  self endon("death");
  param_00 = param_00 + 4;
  for(;;) {
    if(self.origin[2] < param_00) {
      self animmode("gravity");
      break;
    }

    scripts\engine\utility::waitframe();
  }
}

func_D55E(param_00, param_01, param_02, param_03) {
  self endon("death");
  self endon("terminate_ai_threads");
  self endon(param_01 + "_finished");
  var_04 = getdvarint("ai_debug_doublejump", 0);
  if(var_04 != 3 && var_04 != 4) {
    func_3E58(param_01);
  }

  self.var_DC1A = 1;
  var_05 = self getspectatepoint();
  var_06 = self _meth_8146();
  var_05.var_126D4 = var_05.origin[2] + var_05.var_126D5 - 44;
  var_07 = [];
  if(var_05.var_126D4 > var_06[2]) {
    var_08 = var_05.origin[0] + var_06[0] * 0.5;
    var_09 = var_05.origin[1] + var_06[1] * 0.5;
    var_07[var_07.size] = (var_08, var_09, var_05.var_126D4);
  }

  var_07[var_07.size] = var_06;
  var_0B = spawn("script_model", var_05.origin);
  var_0B setModel("tag_origin");
  var_0B.angles = var_05.angles;
  thread scripts\engine\utility::delete_on_death(var_0B);
  self orientmode("face angle", var_05.angles[1]);
  var_0C = 1.63;
  self linkto(var_0B);
  var_0D = lib_0A1E::asm_getallanimsforstate(param_00, param_01);
  self clearanim(lib_0A1E::asm_getbodyknob(), 0.2);
  lib_0A1E::func_2369(param_00, param_01, var_0D);
  self _meth_82EA(param_01, var_0D, 1, param_02, 1);
  thread func_126D1(param_00, param_01);
  foreach(var_0F in var_07) {
    var_10 = var_0C / var_07.size;
    var_0B moveto(var_0F, var_10);
    var_0B waittill("movedone");
  }

  self notify("double_jumped");
  self unlink();
  self.var_DC1A = undefined;
  var_0B delete();
  thread func_11701(param_00, param_01);
}

func_126D2(param_00, param_01, param_02) {
  self unlink();
  self.var_DC1A = undefined;
}

func_D565(param_00, param_01, param_02, param_03) {
  var_04 = self getspectatepoint();
  var_05 = self _meth_8145();
  func_3E58(param_01);
  var_06 = distance(var_04.origin, var_05.origin);
  self animmode("noclip");
  self orientmode("face angle", var_04.angles[1]);
  var_07 = lib_0A1E::asm_getallanimsforstate(param_00, param_01);
  var_08 = getanimlength(var_07);
  var_09 = getmovedelta(var_07);
  var_0A = length(var_09) / var_08;
  var_0B = var_06 / var_0A;
  self clearanim(lib_0A1E::asm_getbodyknob(), param_02);
  self _meth_82EA(param_01, var_07, 1, param_02, 1);
  wait(var_0B);
  func_11701(param_00, param_01);
}

func_126D1(param_00, param_01) {
  self endon("death");
  self endon("terminate_ai_threads");
  self endon(param_01 + "_finished");
  self endon("double_jumped");
  lib_0A1E::func_231F(param_00, param_01);
}

func_D560(param_00, param_01, param_02, param_03) {
  self waittill("external_traverse_complete");
  func_11701(param_00, param_01);
}

func_CF1E(param_00, param_01, param_02, param_03) {
  self endon(param_01 + "_finished");
  self animmode("noclip");
  self orientmode("face angle", self.angles[1]);
  self.var_36A = 1;
  var_04 = lib_0A1E::asm_getallanimsforstate(param_00, param_01);
  self _meth_82E7(param_01, var_04, 1, param_02, 1);
  lib_0A1E::func_2369(param_00, param_01, var_04);
  lib_0A1E::func_231F(param_00, param_01);
  thread func_11701(param_00, param_01);
}

func_7E83(param_00, param_01, param_02, param_03, param_04) {
  var_05 = lib_0F3D::func_3E96(param_00, param_01);
  var_06 = getnotetracktimes(var_05, param_04);
  var_07 = var_06[0];
  var_08 = getmovedelta(var_05, 0, var_07);
  var_09 = getangledelta(var_05, 0, var_07);
  return lib_0C5E::func_36D9(param_02, param_03[1], var_08, var_09);
}

func_5AE3(param_00, param_01, param_02, param_03) {
  var_04 = param_03[2] - param_02.origin[2];
  if(var_04 < 0) {
    return 0;
  }

  if(isDefined(param_02.var_A4C9) && getdvarint("ai_debug_doublejump", 0) != 2) {
    var_05 = param_02.var_A4C9;
    var_06 = param_02.angles - param_02.var_10DCE;
    if(var_06 != (0, 0, 0)) {
      var_05 = rotatevector(var_05, var_06);
    }

    var_07 = param_02.origin + var_05;
    var_08 = var_07[2];
    var_08 = var_08 - 44;
    if(param_03[2] < var_08) {
      return 0;
    }
  }

  var_09 = param_03 - param_02.origin;
  var_09 = (var_09[0], var_09[1], 0);
  var_0A = vectortoangles(var_09);
  var_0B = func_7E83(param_00, param_01, param_03, var_0A, "footstep_left_small");
  var_0C = var_0B - param_02.origin;
  if(vectordot(var_0C, var_09) < 0) {
    return 0;
  }

  return 1;
}

func_3E04(param_00, param_01, param_02, param_03) {
  var_04 = laseroff();
  if(!isDefined(var_04)) {
    thread func_11701(param_00, "double_jump");
    return 0;
  }

  var_05 = _meth_81D7();
  if(!func_5AE3(param_00, param_02, var_04, var_05)) {
    thread func_11701(param_00, "double_jump");
    return 0;
  }

  return 1;
}

laseroff() {
  if(isDefined(self.var_126C5)) {
    return self.var_126C5;
  }

  return self getspectatepoint();
}

_meth_81D7() {
  if(isDefined(self.var_126C3)) {
    return self.var_126C3;
  }

  return self _meth_8146();
}

func_CF21(param_00, param_01, param_02, param_03) {
  self endon(param_01 + "_finished");
  var_04 = laseroff();
  var_05 = var_04.var_5AE2;
  var_06 = var_05 - var_04.origin;
  var_06 = (var_06[0], var_06[1], 0);
  var_07 = vectortoangles(var_06);
  var_08 = lib_0A1E::asm_getallanimsforstate(param_00, param_01);
  var_09 = param_01 + "_finish";
  var_0A = func_7E83(param_00, var_09, var_05, var_07, "mantle_align");
  var_0A = (var_0A[0], var_0A[1], var_0A[2] + param_03);
  func_D50F(param_00, param_01, var_08, param_02, var_0A, var_07, 1, 0, 1);
}

func_CF1F(param_00, param_01, param_02, param_03) {
  func_CF21(param_00, param_01, param_02, -8);
}

func_CF26(param_00, param_01, param_02, param_03) {
  func_CF21(param_00, param_01, param_02, -42);
}

doublejumpterminate(param_00, param_01, param_02) {
  self.var_36A = 0;
  self.var_A4CA = undefined;
  self.var_126C5 = undefined;
  self.var_126C3 = undefined;
}

doublejumpearlyterminate(param_00, param_01, param_02) {
  if(!scripts\asm\asm::func_232B(param_01, "end")) {
    doublejumpterminate(param_00, param_01, param_02);
  }
}

isdriving(param_00, param_01, param_02, param_03) {
  return scripts\asm\asm::func_68B0(param_00, param_01, param_02, "end");
}

func_CF24(param_00, param_01, param_02, param_03) {
  self endon(param_01 + "_finished");
  var_04 = laseroff();
  var_05 = _meth_81D7();
  var_06 = var_04.angles - var_04.var_10DCE;
  if(var_06 != (0, 0, 0)) {
    var_05 = rotatevector(var_05, var_06);
  }

  var_07 = undefined;
  var_08 = getdvarint("ai_debug_doublejump", 0);
  if(var_08 != 2) {
    if(isDefined(var_04.var_A4C9)) {
      var_09 = var_04.var_A4C9;
      if(var_06 != (0, 0, 0)) {
        var_09 = rotatevector(var_09, var_06);
      }

      var_07 = var_04.origin + var_09;
      var_0A = var_07[2];
      var_0A = var_0A - 44;
      if(var_0A > var_05[2]) {
        var_0B = var_04.origin[0] + var_05[0] * 0.5;
        var_0C = var_04.origin[1] + var_05[1] * 0.5;
        var_07 = (var_0B, var_0C, var_07[2]);
      } else {
        var_07 = undefined;
      }
    }
  }

  var_0D = lib_0A1E::asm_getallanimsforstate(param_00, param_01);
  self.var_A4CA = var_07;
  var_0E = param_01 + "_finish";
  if(func_5AE3(param_00, var_0E, var_04, var_05)) {
    var_0F = var_05 - var_04.origin;
    var_0F = (var_0F[0], var_0F[1], 0);
    var_10 = vectortoangles(var_0F);
    var_0E = param_01 + "_finish";
    var_11 = func_7E83(param_00, var_0E, var_05, var_10, "footstep_left_small");
    var_05 = var_11;
  }

  var_0F = var_05 - var_04.origin;
  var_12 = 0;
  var_13 = 1;
  if(var_0F[2] < 0) {
    var_12 = 1;
    var_14 = getnotetracktimes(var_0D, "gravity on");
    if(isDefined(var_14) && var_14.size > 0) {
      var_13 = var_14[0];
    }
  }

  var_0F = (var_0F[0], var_0F[1], 0);
  var_10 = vectortoangles(var_0F);
  func_D50F(param_00, param_01, var_0D, param_02, var_05, var_10, var_13, var_12, 1);
}

func_3ED2(param_00, param_01, param_02) {
  var_03 = _meth_81D7();
  var_04 = "double_jump_up";
  if(isDefined(param_02)) {
    var_04 = "double_jump_" + param_02;
  } else if(var_03[2] < self.origin[2]) {
    var_04 = "double_jump_down";
  }

  if(self.asm.footsteps.foot == "right") {
    var_05 = "right_";
  } else {
    var_05 = "left_";
  }

  var_04 = var_05 + var_04;
  var_06 = scripts\asm\asm::asm_lookupanimfromalias(param_01, var_04);
  return var_06;
}

moveshieldmodel(param_00, param_01) {
  var_02 = param_00.angles - param_00.var_138A6.var_10DCE;
  if(var_02 != (0, 0, 0)) {
    var_03 = rotatevector(param_00.var_138A6.var_C050[param_01], var_02);
    var_04 = param_00.origin + var_03;
  } else {
    var_04 = param_01.origin + param_01.var_138A6.var_C050[var_02];
  }

  return var_04;
}

func_100BF(param_00, param_01, param_02, param_03) {
  if(!isDefined(self.isnodeoccupied)) {
    return 0;
  }

  var_04 = self.isnodeoccupied.origin;
  var_05 = self.var_126C5;
  var_06 = moveshieldmodel(var_05, self.var_138BA);
  var_07 = moveshieldmodel(var_05, self.var_138BA + 1);
  var_07 = (var_07[0], var_07[1], var_06[2]);
  var_04 = (var_04[0], var_04[1], var_06[2]);
  var_08 = vectornormalize(var_07 - var_06);
  var_09 = vectornormalize(var_04 - var_06);
  var_0A = vectordot(var_08, var_09);
  if(var_0A < 0.2588) {
    return 0;
  }

  return 1;
}

func_3F0E(param_00, param_01, param_02) {
  var_03 = scripts\asm\asm::asm_lookupanimfromalias(param_01, self.var_138BC);
  return var_03;
}

_meth_812B(param_00) {
  return param_00 * param_00 * 3 - 2 * param_00;
}

func_11657(param_00, param_01, param_02, param_03, param_04, param_05) {
  self endon(param_00 + "_finished");
  if(param_01 > 0) {
    wait(param_01);
  }

  var_06 = param_02 / param_03;
  var_07 = self.origin[2];
  var_08 = var_07 + param_02[2];
  var_09 = self.origin[2];
  self _meth_82B1(param_04, param_05);
  for(var_0A = 0; var_0A < param_03; var_0A++) {
    var_0B = 1;
    if(var_0B) {
      var_0C = var_0A / param_03 - 1;
      var_0D = _meth_812B(var_0C);
      var_0E = var_08 * var_0D + var_07 * 1 - var_0D;
      var_0F = var_0E - var_09;
      var_06 = (var_06[0], var_06[1], var_0F);
      var_09 = var_0E;
    }

    var_10 = self.origin + var_06;
    self _meth_80F1(var_10);
    if(var_0A + 1 < param_03) {
      scripts\engine\utility::waitframe();
    }
  }

  self _meth_82B1(param_04, 1);
}

func_138D4(param_00, param_01) {
  if(param_00 == "start_jump") {
    thread func_89BB(param_01);
    return;
  }

  if(param_00 == "end_mantle") {
    self animmode("gravity");
  }
}

func_89BB(param_00, param_01, param_02) {
  var_03 = param_00[0];
  var_04 = param_00[1];
  var_05 = param_00[2];
  var_06 = param_00[3];
  var_07 = param_00[4];
  var_08 = param_00[5];
  var_09 = param_00[6];
  self endon(var_03 + "_finished");
  var_0A = getanimlength(var_04);
  if(!isDefined(param_01)) {
    param_01 = gettime() - var_06 * 0.001;
  }

  var_0B = param_01 / var_0A;
  var_0C = getnotetracktimes(var_04, "end_jump");
  var_0D = getnotetracktimes(var_04, "end_double_jump");
  if(var_0D.size > 0) {
    self.var_138BD = 1;
    var_0C = var_0D;
  } else {
    self.var_138BD = 0;
  }

  if(isDefined(self.var_A4CA)) {
    var_07 = var_0C[0] - var_0B / 2 + var_0B;
    var_0C[0] = var_07;
    var_05 = self.var_A4CA;
  }

  var_0E = getmovedelta(var_04, var_0B, var_07);
  var_0F = self gettweakablevalue(var_0E);
  if(!isDefined(param_02)) {
    param_02 = 1;
  }

  if(var_09) {
    var_10 = distance(self.origin, var_0F);
    var_11 = distance(self.origin, var_05);
    param_02 = var_10 / var_11;
    if(param_02 < 0.7) {
      param_02 = 0.7;
    } else if(param_02 > 1.3) {
      param_02 = 1.3;
    }
  }

  var_13 = var_05 - var_0F;
  var_14 = var_0C[0] * var_0A;
  var_15 = var_14 - var_0B * var_0A;
  var_15 = var_15 * 1 / param_02;
  var_16 = var_15 * 20;
  var_16 = ceil(var_16);
  var_17 = gettime();
  func_11657(var_03, 0, var_13, var_16, var_04, param_02);
  if(isDefined(self.var_A4CA)) {
    var_18 = gettime() - var_17 * param_02;
    var_19 = param_01 + var_18 * 0.001;
    self.var_A4CA = undefined;
    param_00[6] = 0;
    func_89BB(param_00, var_19, param_02);
  }
}

_meth_8213(param_00) {
  var_01 = moveshieldmodel(param_00, 1) - moveshieldmodel(param_00, 0);
  var_02 = vectortoangles(var_01);
  return var_02[1];
}

moveto(param_00) {
  self.var_138BA = 0;
  var_01 = moveshieldmodel(param_00, 1) - moveshieldmodel(param_00, 0);
  var_02 = vectortoangles(var_01);
  self.var_138C1 = var_02[1];
  var_03 = moveshieldmodel(param_00, self.var_138BA);
  var_04 = anglestoright(var_02);
  var_05 = var_03 - param_00.origin;
  var_06 = vectordot(var_04, var_05);
  if(var_06 > 0) {
    return "right";
  }

  return "left";
}

func_FAF8() {
  if(isDefined(self.var_138BC)) {
    return;
  }

  if(!isDefined(self.var_126C5)) {
    self.var_126C5 = self getspectatepoint();
    self.var_126C3 = self _meth_8146();
  }

  var_00 = self.var_126C5;
  self.var_138BC = moveto(var_00);
}

moveslide() {
  func_FAF8();
  return self.var_138BC;
}

wallrunterminate(param_00, param_01, param_02) {
  self.var_138BA = undefined;
  self.var_138BC = undefined;
  self.var_138BD = undefined;
  self.var_138C1 = undefined;
  self.var_138B9 = undefined;
  self _meth_82D0();
  self.var_36A = 0;
  self.var_A4CA = undefined;
  self.var_126C5 = undefined;
  self.var_126C3 = undefined;
}

traversalorientearlyterminate(param_00, param_01, param_02) {
  if(!scripts\asm\asm::func_232B(param_01, "end") && !scripts\asm\asm::func_232B(param_01, "code_move")) {
    func_4123(param_00, param_01, param_02);
  }
}

func_D5CF(param_00, param_01, param_02, param_03) {
  self animmode("noclip");
  self orientmode("face angle", self.angles[1]);
  self.var_36A = 1;
  if(isDefined(param_03) && param_03 == "shoot") {
    func_FAF7();
  }

  var_04 = lib_0A1E::asm_getallanimsforstate(param_00, param_01);
  var_05 = getnotetracktimes(var_04, "wall_contact");
  var_06 = var_05[0];
  var_07 = getangledelta(var_04, 0, var_06);
  var_08 = self.var_138C1 - var_07;
  var_09 = (0, var_08, 0);
  self _meth_80F1(self.origin, var_09);
  self clearanim(lib_0A1E::asm_getbodyknob(), param_02);
  self _meth_82E7(param_01, var_04, 1, param_02, 1);
  lib_0A1E::func_2369(param_00, param_01, var_04);
  var_0A = lib_0A1E::func_231F(param_00, param_01, scripts\asm\asm::func_2341(param_00, param_01));
  if(var_0A == "end") {
    thread scripts\asm\asm::func_2310(param_00, param_01, 0);
  }
}

moveovertime(param_00) {
  var_01 = func_3F0D(param_00, "wall_run_attach");
  var_02 = getnotetracktimes(var_01, "wall_contact");
  var_03 = var_02[0];
  var_04 = getmovedelta(var_01, 0, var_03);
  var_05 = getangledelta(var_01, 0, var_03);
  return lib_0C5E::func_36D9(moveshieldmodel(self.var_126C5, 0), self.var_138C1, var_04, var_05);
}

func_D5D2(param_00, param_01, param_02, param_03) {
  self endon(param_01 + "_finished");
  var_04 = lib_0A1E::asm_getallanimsforstate(param_00, param_01);
  var_05 = self.var_126C5;
  self.var_138BA = 0;
  var_06 = moveshieldmodel(var_05, 0);
  var_07 = var_06 - self.origin;
  var_07 = (var_07[0], var_07[1], 0);
  var_08 = vectortoangles(var_07);
  var_09 = moveovertime();
  self orientmode("face angle", var_08[1]);
  var_0A = 1;
  var_0B = getnotetracktimes(var_04, "code_move");
  if(isDefined(var_0B) && var_0B.size > 0) {
    var_0A = var_0B[0];
  }

  func_D50F(param_00, param_01, var_04, param_02, var_09, var_08, var_0A, 0, 1);
  self _meth_80F1(var_09, var_08);
  thread scripts\asm\asm::func_2310(param_00, param_01, 0);
}

func_D50F(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08) {
  self endon(param_01 + "_finished");
  if(!isDefined(param_06)) {
    param_06 = 1;
  }

  if(!isDefined(param_07)) {
    param_07 = 0;
  }

  if(!isDefined(param_08)) {
    param_08 = 0;
  }

  self _meth_80F1(self.origin, param_05);
  self animmode("noclip");
  self orientmode("face angle", param_05[1]);
  var_09 = getanimlength(param_02);
  var_0A = int(var_09 * 1000);
  self _meth_85A1(gettime() + var_0A - 1000);
  self.var_36A = 1;
  self _meth_82E7(param_01, param_02, 1, param_03, 1);
  lib_0A1E::func_2369(param_00, param_01, param_02);
  var_0B = [param_01, param_02, param_04, gettime(), param_06, param_07, param_08];
  lib_0A1E::func_231F(param_00, param_01, ::func_138D4, var_0B);
}

func_3F0D(param_00, param_01, param_02) {
  if(isDefined(self.var_138B9)) {
    return self.var_138B9;
  }

  var_03 = self.var_138BC;
  var_04 = angleclamp180(self.var_138C1 - self.angles[1]);
  var_04 = abs(var_04);
  if(var_04 >= 22.5) {
    if(var_04 > 67.5) {
      var_03 = var_03 + "_90";
    } else {
      var_03 = var_03 + "_45";
    }
  }

  self.var_138B9 = scripts\asm\asm::asm_lookupanimfromalias(param_01, var_03);
  return self.var_138B9;
}

func_3F0F(param_00, param_01, param_02) {
  func_FAF8();
  var_03 = self.var_138BC;
  var_04 = self.var_126C5;
  var_05 = moveshieldmodel(var_04, 0);
  var_06 = var_05[2] - self.origin[2];
  var_07 = 0;
  if(var_06 >= 0) {
    if(var_06 > 120) {
      var_07 = 1;
    }
  } else if(0 - var_06 > 240) {
    var_07 = 1;
  }

  if(var_07 == 0) {
    var_08 = distancesquared(self.origin, var_05);
    if(var_08 > -25536) {
      var_07 = 1;
    }
  }

  var_09 = "left_";
  if(self.asm.footsteps.foot == "right") {
    var_09 = "right_";
  }

  if(var_07) {
    var_03 = var_09 + "double_jump";
  } else {
    var_03 = var_09 + "single_jump";
  }

  var_0A = scripts\asm\asm::asm_lookupanimfromalias(param_01, var_03);
  return var_0A;
}

func_F22D(param_00, param_01, param_02, param_03) {
  self endon(param_00 + "_finished");
  wait(param_01);
  scripts\asm\asm::asm_fireevent(param_00, param_02);
  if(param_03) {
    self notify(param_02);
  }
}

func_8BCB(param_00, param_01, param_02, param_03) {
  if(!isDefined(self.var_138BA)) {
    return 0;
  }

  var_04 = self.var_126C5;
  if(!isDefined(var_04)) {
    return 0;
  }

  var_05 = self.var_138BA + 2;
  if(var_04.var_138A6.var_C050.size <= var_05) {
    return 0;
  }

  return 1;
}

func_D5D0(param_00, param_01, param_02, param_03) {
  self endon(param_01 + "_finished");
  var_04 = self.var_126C5;
  scripts\anim\combat::func_F296();
  self.var_138BA = self.var_138BA + 2;
  var_05 = moveshieldmodel(var_04, self.var_138BA);
  var_06 = self.angles;
  if(self.var_138BC == "left") {
    self.var_138BC = "right";
  } else {
    self.var_138BC = "left";
  }

  var_07 = lib_0A1E::asm_getallanimsforstate(param_00, param_01);
  func_D50F(param_00, param_01, var_07, param_02, var_05, var_06);
}

movey(param_00) {
  var_01 = param_00.angles - param_00.var_138A6.var_10DCE;
  if(var_01 == (0, 0, 0)) {
    return param_00.origin + param_00.var_138A6.var_B313;
  }

  var_02 = rotatevector(param_00.var_138A6.var_B313, var_01);
  return param_00.origin + var_02;
}

movex(param_00) {
  if(!isDefined(param_00.var_138A6.var_B312)) {
    return undefined;
  }

  var_01 = param_00.angles[1] - param_00.var_138A6.var_10DCE[1];
  if(var_01 == 0) {
    return param_00.var_138A6.var_B312;
  }

  return (0, angleclamp180(param_00.var_138A6.var_B312[1] + var_01), 0);
}

movez() {
  var_00 = self.var_126C5;
  if(!isDefined(var_00.var_138A6.var_B313)) {
    return "none";
  }

  var_01 = movey(var_00);
  if(var_01[2] >= self.origin[2]) {
    return "high";
  }

  return "low";
}

func_100C0(param_00, param_01, param_02, param_03) {
  var_04 = self.var_126C5;
  if(!isDefined(var_04.var_138A6.var_331A)) {
    return 0;
  }

  return var_04.var_138A6.var_331A;
}

func_D5D4(param_00, param_01, param_02, param_03) {
  self endon(param_01 + "_finished");
  var_04 = self.var_126C5;
  func_FAF7();
  var_05 = lib_0A1E::asm_getallanimsforstate(param_00, param_01);
  var_06 = getmovedelta(var_05);
  var_07 = length2d(var_06);
  if(!isDefined(var_04.var_138A6.var_B313) && self.var_138BA == var_04.var_138A6.var_C050.size - 2) {
    var_08 = lib_0A1E::asm_getallanimsforstate(param_00, "wall_run_exit");
    var_09 = getnotetracktimes(var_08, "start_jump");
    var_0A = getanimlength(var_08);
    var_0B = getmovedelta(var_08, 0, var_09[0]);
    var_0C = length2d(var_0B);
  } else {
    var_0C = 0;
  }

  var_0D = moveshieldmodel(var_04, self.var_138BA + 1) - self.origin;
  var_0E = length(var_0D);
  var_0E = var_0E - var_0C;
  if(var_0E < 0) {
    var_0E = 0;
  }

  var_0F = var_0E / var_07;
  var_10 = getanimlength(var_05);
  var_11 = var_10 * var_0F;
  thread func_F22D(param_01, var_11, "wall_run_loop_done", 1);
  var_12 = vectornormalize(var_0D);
  self orientmode("face direction", var_12);
  thread func_D5D1(param_01);
  self animmode("noclip");
  self _meth_82E7(param_01, var_05, 1, param_02, 1);
  lib_0A1E::func_2369(param_00, param_01, var_05);
  lib_0A1E::func_231F(param_00, param_01);
}

func_D5D1(param_00) {
  self endon("death");
  if(soundexists("wallrun_end_npc")) {
    self waittill("wall_run_loop_done");
    self playSound("wallrun_end_npc");
  }
}

func_3F10(param_00, param_01, param_02) {
  var_03 = self.var_138BC;
  var_04 = self.var_126C3;
  var_05 = var_04[2] - self.origin[2];
  var_06 = 0;
  if(var_05 >= 0) {
    if(var_05 > 120) {
      var_06 = 1;
    }
  } else if(0 - var_05 > 240) {
    var_06 = 1;
  }

  if(var_06 == 0) {
    var_07 = distancesquared(self.origin, var_04);
    if(var_07 > -19311) {
      var_06 = 1;
    }
  }

  if(var_06) {
    var_03 = var_03 + "_double";
  }

  var_04 = self.var_126C3;
  var_08 = self.var_126C5;
  var_09 = self.var_126C3 - moveshieldmodel(var_08, var_08.var_138A6.var_C050.size - 1);
  var_09 = (var_09[0], var_09[1], 0);
  var_09 = vectornormalize(var_09);
  var_0A = vectortoangles(var_09);
  var_0B = angleclamp180(var_0A[1] - self.angles[1]);
  var_0B = abs(var_0B);
  if(var_0B >= 22.5) {
    if(var_0B > 67.5) {
      var_03 = var_03 + "_90";
    } else {
      var_03 = var_03 + "_45";
    }
  }

  var_0C = scripts\asm\asm::asm_lookupanimfromalias(param_01, var_03);
  return var_0C;
}

func_D5D3(param_00, param_01, param_02, param_03) {
  self endon(param_01 + "_finished");
  var_04 = self.var_126C5;
  var_05 = self.var_126C3;
  var_06 = self.angles;
  var_07 = 1;
  var_08 = lib_0A1E::asm_getallanimsforstate(param_00, param_01);
  var_09 = getnotetracktimes(var_08, "ground");
  scripts\anim\combat::func_F296();
  if(isDefined(var_09) && var_09.size > 0) {
    var_07 = var_09[0];
  } else {
    var_0A = getnotetracktimes(var_08, "end_double_jump");
    if(isDefined(var_0A) && var_0A.size > 0) {
      var_07 = var_0A[0];
    } else {
      var_0B = getnotetracktimes(var_08, "end_jump");
      if(isDefined(var_0B) && var_0B.size > 0) {
        var_07 = var_0B[0];
      }
    }
  }

  if(soundexists("wallrun_end_npc")) {
    self playSound("wallrun_end_npc");
  }

  func_D50F(param_00, param_01, var_08, param_02, var_05, var_06, var_07, 1, 1);
  thread func_11705(param_00, param_01);
}

func_9EBA(param_00, param_01, param_02, param_03) {
  if(isDefined(self.var_126C5)) {
    return 0;
  }

  return 1;
}

func_11705(param_00, param_01) {
  self.var_138BA = undefined;
  self.var_138BC = undefined;
  self.var_138BD = undefined;
  self.var_138C1 = undefined;
  self.var_138B9 = undefined;
  self _meth_82D0();
  func_11701(param_00, param_01);
}

func_D5D5(param_00, param_01, param_02, param_03) {
  self endon(param_01 + "_finished");
  var_04 = self.var_126C5;
  var_05 = self.var_126C3;
  var_06 = movey(var_04);
  if(isDefined(var_04.var_138A6.var_331A) || movez() == "high") {
    var_07 = movex(var_04);
    if(!isDefined(var_07)) {
      var_08 = var_05 - var_06;
      var_08 = (var_08[0], var_08[1], 0);
      var_07 = vectortoangles(var_08);
    }
  } else {
    var_08 = var_07 - self.origin;
    var_08 = (var_08[0], var_08[1], 0);
    var_07 = vectortoangles(var_08);
  }

  var_09 = lib_0A1E::asm_getallanimsforstate(param_00, param_01);
  var_0A = getanimlength(var_09);
  var_0B = getnotetracktimes(var_09, "start_mantle");
  var_0C = var_0B[0];
  var_0D = getnotetracktimes(var_09, "end_mantle");
  var_0E = var_0D[0];
  var_0F = getmovedelta(var_09, var_0C, var_0E);
  self _meth_80F1(self.origin, var_07);
  var_10 = self gettweakablevalue(var_0F);
  var_11 = var_10 - self.origin;
  var_12 = var_06 - var_11;
  func_D50F(param_00, param_01, var_09, param_02, var_12, var_07, var_0C, 0, 1);
  thread func_11705(param_00, param_01);
}

func_D55B(param_00, param_01, param_02, param_03) {
  self endon(param_01 + "_finished");
  var_04 = lib_0A1E::asm_getallanimsforstate(param_00, param_01);
  if(!isDefined(var_04)) {
    scripts\asm\asm::asm_fireevent(param_01, "code_move");
    return;
  }

  var_05 = 1;
  var_06 = undefined;
  if(getdvarint("ai_wall_run_use_align_notetrack", 1) == 1) {
    var_06 = getnotetracktimes(var_04, "align");
  }

  if(!isDefined(var_06) || var_06.size == 0) {
    var_06 = getnotetracktimes(var_04, "code_move");
  }

  if(isDefined(var_06) && var_06.size > 0) {
    var_05 = var_06[0];
  }

  var_07 = getmovedelta(var_04, 0, var_05);
  var_08 = getangledelta(var_04, 0, var_05);
  var_09 = self.var_126C5;
  var_0A = getanimlength(var_04) * var_05;
  var_0B = int(ceil(var_0A * 20));
  if(self.var_126C5.var_48 == "wall_run") {
    var_0C = moveshieldmodel(self.var_126C5, 0) - self.origin;
    var_0D = vectortoangles(var_0C);
    var_0E = var_0D[1];
  } else {
    var_0F = self.var_126C3 - self.var_126C5.origin;
    var_0F = (var_0F[0], var_0F[1], 0);
    var_10 = vectortoangles(var_0F);
    var_0E = var_10[1];
  }

  var_11 = lib_0C5E::func_36D9(var_09.origin, var_0E, var_07, var_08);
  var_12 = var_0E - var_08;
  self.var_4C7E = ::lib_0F3D::func_22EA;
  self.a.var_22E5 = param_01;
  self.var_36A = 1;
  self _meth_8396(var_11, var_12, var_0B);
  self clearanim(lib_0A1E::asm_getbodyknob(), param_02);
  self _meth_82E7(param_01, var_04, 1, param_02, 1);
  lib_0A1E::func_2369(param_00, param_01, var_04);
  lib_0A1E::func_231F(param_00, param_01, scripts\asm\asm::func_2341(param_00, param_01));
  thread scripts\asm\asm::func_2310(param_00, param_01, 0);
}

func_3F12(param_00, param_01, param_02) {
  return lib_0C65::func_3EF5(param_00, param_01, param_02);
}

func_3F07(param_00, param_01, param_02) {
  var_03 = anglesToForward(self.angles);
  var_04 = vectortoangles(var_03);
  if(self.var_126C5.var_48 == "wall_run") {
    var_05 = vectortoangles(moveshieldmodel(self.var_126C5, 0) - self.origin);
  } else {
    var_06 = self.var_126C3 - self.var_126C5.origin;
    var_06 = (var_06[0], var_06[1], 0);
    var_05 = vectortoangles(var_06);
  }

  var_07 = var_05[1];
  var_08 = angleclamp180(var_07 - var_04[1]);
  var_09 = getangleindex(var_08, 22.5);
  var_0A = lib_0C5D::_meth_8174(param_01, undefined, 1);
  if(!isDefined(var_0A[var_09])) {
    return undefined;
  }

  return var_0A[var_09];
}

func_FAF0(param_00, param_01, param_02, param_03) {
  var_04 = self _meth_84F9(120);
  if(!isDefined(var_04)) {
    return 0;
  }

  var_05 = var_04["node"];
  var_06 = var_04["position"];
  if(!isDefined(var_05) || !isDefined(var_05.var_48)) {
    return 0;
  }

  self.var_126C5 = var_05;
  self.var_126C3 = var_06;
  return 1;
}

func_4123(param_00, param_01, param_02, param_03) {
  self.var_126C5 = undefined;
  self.var_126C3 = undefined;
  self.var_138BC = undefined;
  return 0;
}

func_FFB7(param_00, param_01, param_02, param_03) {
  var_04 = distance2dsquared(self.origin, moveshieldmodel(self.var_126C5, 1));
  if(var_04 < 144) {
    return 1;
  }

  return 0;
}

func_FFFD(param_00, param_01, param_02, param_03) {
  if(func_9EBA(param_00, param_01, param_02, param_03)) {
    func_FAF0(param_00, param_01, param_02, param_03);
    if(!isDefined(self.var_126C5)) {
      return 0;
    }

    if(self.var_126C5.var_48 != "wall_run") {
      return 0;
    }

    var_04 = self.var_126C5;
    var_05 = vectornormalize(moveshieldmodel(var_04, 0) - self.origin);
    var_06 = lib_0C65::func_371C(param_01, param_02, var_05, 0, 1);
    if(!isDefined(var_06)) {
      return 0;
    }

    self.a.var_FC61 = var_06;
    self.var_138BC = moveto(self.var_126C5);
    return 1;
  }

  return 0;
}

func_100B3(param_00, param_01, param_02, param_03) {
  if(param_02 == self.var_126C5.var_48) {
    return 1;
  }

  return 0;
}

func_9FB1(param_00) {
  switch (param_00) {
    case "rail_hop_double_jump_down":
    case "double_jump":
    case "double_jump_mantle":
    case "double_jump_vault":
    case "wall_run":
      return 1;
  }

  return 0;
}

func_FFFC(param_00, param_01, param_02, param_03) {
  if(!isDefined(self.var_126C5)) {
    return 0;
  }

  if(!func_9FB1(self.var_126C5.var_48)) {
    return 0;
  }

  if(!self.livestreamingenable) {
    return 0;
  }

  var_04 = undefined;
  if(self.var_126C5.var_48 == "wall_run") {
    var_04 = moveto(self.var_126C5);
    var_05 = moveshieldmodel(self.var_126C5, 0) - self.origin;
    var_06 = vectortoangles(var_05);
  } else {
    var_05 = self.var_126C3 - self.var_126C5.origin;
    var_06 = (var_06[0], var_06[1], 0);
    var_05 = vectornormalize(var_06);
    var_06 = vectortoangles(var_05);
  }

  var_07 = var_06[1];
  var_08 = anglesToForward(self.angles);
  var_09 = vectortoangles(var_08);
  var_0A = angleclamp180(var_07 - var_09[1]);
  var_0B = getangleindex(var_0A, 22.5);
  var_0C = lib_0C5D::_meth_8174(param_02, undefined, 1);
  var_0D = var_0C[var_0B];
  if(!isDefined(var_0D)) {
    return 0;
  }

  var_0E = 1;
  var_0F = undefined;
  if(getdvarint("ai_wall_run_use_align_notetrack", 1) == 1) {
    var_0F = getnotetracktimes(var_0D, "align");
  }

  if(!isDefined(var_0F) || var_0F.size == 0) {
    var_0F = getnotetracktimes(var_0D, "code_move");
  }

  if(isDefined(var_0F) && var_0F.size > 0) {
    var_0E = var_0F[0];
  }

  var_10 = getmovedelta(var_0D, 0, var_0E);
  var_11 = getangledelta(var_0D, 0, var_0E);
  var_12 = distance2d(self.origin, self.var_126C5.origin);
  var_13 = length(var_10);
  var_14 = var_12 - var_13;
  if(var_14 < 0) {
    var_15 = anglesToForward(var_06);
    var_16 = vectordot(var_08, var_15);
    if(var_16 > 0.707) {
      if(abs(var_14) > 10) {
        return 0;
      }
    } else if(abs(var_14) > 64) {
      return 0;
    }
  } else if(var_14 > 10) {
    return 0;
  }

  if(self.var_126C5.var_48 == "wall_run") {
    self.var_138BC = var_04;
  }

  return 1;
}

func_89FB(param_00) {
  if(param_00 == "wall_contact") {
    if(soundexists("wallrun_start_npc")) {
      self playSound("wallrun_start_npc");
    }
  }
}

func_FAF7() {
  self.var_368 = -45;
  self.isbot = 45;
  self.setdevdvar = -90;
  self.setmatchdatadef = 90;
}

func_126CE(param_00, param_01, param_02, param_03) {
  self endon(param_01 + "_finished");
  var_04 = lib_0A1E::asm_getallanimsforstate(param_00, param_01);
  self clearanim(lib_0A1E::asm_getbodyknob(), param_02);
  self animmode("noclip", 0);
  var_05 = self getspectatepoint();
  self orientmode("face angle", var_05.angles[1]);
  self _meth_82EA(param_01, var_04, 1, param_02, 1);
  lib_0A1E::func_231F(param_00, param_01, scripts\asm\asm::func_2341(param_00, param_01));
  func_11701(param_00, param_01);
}

func_3E58(param_00) {}