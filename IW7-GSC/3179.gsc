/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: 3179.gsc
*********************************************/

func_D55D(var_0, var_1, var_2, var_3) {
  self endon("death");
  self endon("terminate_ai_threads");
  func_3E58(var_1);
  var_4 = lib_0A1E::asm_getallanimsforstate(var_0, var_1);
  self.var_5270 = "crouch";
  scripts\anim\utility::func_12E5F();
  self endon("killanimscript");
  self animmode("noclip");
  var_5 = self getspectatepoint();
  self orientmode("face angle", var_5.angles[1]);
  var_5.var_126D4 = var_5.origin[2] + var_5.var_126D5;
  var_6 = var_5.var_126D4 - var_5.origin[2];
  thread func_11661(var_6 - var_3);
  var_2 = 0.15;
  var_7 = lib_0A1E::asm_getbodyknob();
  self clearanim(var_7, var_2);
  self func_82E7(var_1, var_4, 1, var_2, 1);
  var_8 = 0.2;
  var_9 = 0.2;
  thread func_126D1(var_0, var_1);
  if(!animhasnotetrack(var_4, "gravity on")) {
    var_10 = 1.23;
    wait(var_10 - var_8);
    self animmode("gravity");
    wait(var_8);
  } else {
    self waittillmatch("gravity on", "traverse");
    self animmode("gravity");
    if(!animhasnotetrack(var_4, "blend")) {
      wait(var_8);
    } else {
      self waittillmatch("blend", "traverse");
    }
  }

  func_11701(var_0, var_1);
}

func_D566(var_0, var_1, var_2, var_3) {
  self endon("death");
  self endon("terminate_ai_threads");
  func_3E58(var_1);
  var_4 = lib_0A1E::asm_getallanimsforstate(var_0, var_1);
  scripts\asm\asm_bb::bb_requestsmartobject("stand");
  var_5 = self getspectatepoint();
  var_5.var_126D4 = var_5.origin[2] + var_5.var_126D5;
  self orientmode("face angle", var_5.angles[1]);
  self.var_126E6 = var_3;
  self.var_126EB = var_5;
  var_6 = 0;
  self animmode("noclip");
  self.var_126EC = self.origin[2];
  if(!animhasnotetrack(var_4, "traverse_align")) {
    func_89F5();
  }

  var_7 = 0;
  lib_0A1E::func_2369(var_0, var_1, var_4);
  self.var_126DB = var_4;
  self.var_126DD = lib_0A1E::asm_getbodyknob();
  self func_82E4(var_1, var_4, self.var_126DD, 1, 0.2, 1);
  self.var_126E3 = 0;
  self.var_126E2 = undefined;
  lib_0A1E::func_231F(var_0, var_1, ::func_89F8);
  self animmode("gravity");
  if(self.var_EB) {
    func_11701(var_0, var_1);
    return;
  }

  self.a.nodeath = 0;
  if(var_7 && isDefined(self.node) && distancesquared(self.origin, self.node.origin) < 256) {
    self.a.movement = "stop";
    self func_83B9(self.node.origin);
  } else {
    self.a.movement = "run";
    self clearanim(var_4, 0.2);
  }

  self.var_126DD = undefined;
  self.var_126DB = undefined;
  self.var_4E2A = undefined;
  self.var_126EB = undefined;
  func_11701(var_0, var_1);
}

func_D55C(var_0, var_1, var_2, var_3) {
  var_4 = lib_0A1E::asm_getallanimsforstate(var_0, var_1);
  func_3E58(var_1);
  self animmode("noclip");
  var_5 = self getspectatepoint();
  self orientmode("face angle", var_5.angles[1]);
  self clearanim(lib_0A1E::asm_getbodyknob(), var_2);
  self func_82E7(var_1, var_4, 1, var_2, 1);
  lib_0A1E::func_231F(var_0, var_1);
  func_11701(var_0, var_1);
}

func_11701(var_0, var_1) {
  self.var_36A = 0;
  self.var_A4CA = undefined;
  self.var_126C5 = undefined;
  self.var_126C3 = undefined;
  var_2 = level.asm[var_0].states[var_1];
  var_3 = undefined;
  if(isDefined(var_2.var_116FB)) {
    if(isarray(var_2.var_116FB[0])) {
      var_3 = var_2.var_116FB[0];
    } else {
      var_3 = var_2.var_116FB;
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

func_11661(var_0) {
  self endon("killanimscript");
  self notify("endTeleportThread");
  self endon("endTeleportThread");
  var_1 = 5;
  var_2 = (0, 0, var_0 / var_1);
  for(var_3 = 0; var_3 < var_1; var_3++) {
    self func_80F1(self.origin + var_2);
    scripts\engine\utility::waitframe();
  }
}

func_11662(var_0, var_1, var_2, var_3) {
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
  if(isDefined(var_3) && var_3 < 1) {
    self func_82B1(self.var_126DB, var_3);
  }

  for(var_5 = 0; var_5 < var_2; var_5++) {
    self func_80F1(self.origin + var_4);
    scripts\engine\utility::waitframe();
  }

  if(isDefined(var_3) && var_3 < 1) {
    self func_82B1(self.var_126DB, 1);
  }
}

func_89F8(var_0) {
  if(var_0 == "traverse_death") {
    return func_89F6();
  }

  if(var_0 == "traverse_align") {
    return func_89F5();
  }

  if(var_0 == "traverse_drop") {
    return func_89F7();
  }
}

func_89F6() {
  if(isDefined(self.var_126E2)) {
    var_0 = self.var_126E2[self.var_126E3];
    self.var_4E2A = var_0[randomint(var_0.size)];
    self.var_126E3++;
  }
}

func_89F5() {
  self animmode("noclip");
  if(isDefined(self.var_126E6) && isDefined(self.var_126EB.var_126D4)) {
    var_0 = self.var_126EB.var_126D4 - self.var_126EC;
    thread func_11661(var_0 - self.var_126E6);
  }
}

func_89F7() {
  var_0 = self.origin + (0, 0, 32);
  var_1 = physicstrace(var_0, self.origin + (0, 0, -512));
  var_2 = distance(var_0, var_1);
  var_3 = var_2 - 32 - 0.5;
  var_4 = self getscoreinfocategory(self.var_126DB);
  var_5 = getmovedelta(self.var_126DB, var_4, 1);
  var_6 = getanimlength(self.var_126DB);
  var_7 = var_4 * var_6;
  var_8 = 0 - var_5[2];
  var_9 = var_8 - var_3;
  if(var_8 < var_3) {
    var_10 = var_8 / var_3;
  } else {
    var_10 = 1;
  }

  var_11 = var_6 - var_4 / 3;
  var_12 = var_6 - var_7 / 3;
  var_13 = ceil(var_12 * 20);
  thread func_11662(var_9, 0, var_13, var_10);
  thread func_6CE5(var_1[2]);
}

func_6CE5(var_0) {
  self endon("killanimscript");
  self endon("death");
  var_0 = var_0 + 4;
  for(;;) {
    if(self.origin[2] < var_0) {
      self animmode("gravity");
      break;
    }

    scripts\engine\utility::waitframe();
  }
}

func_D55E(var_0, var_1, var_2, var_3) {
  self endon("death");
  self endon("terminate_ai_threads");
  self endon(var_1 + "_finished");
  var_4 = getdvarint("ai_debug_doublejump", 0);
  if(var_4 != 3 && var_4 != 4) {
    func_3E58(var_1);
  }

  self.var_DC1A = 1;
  var_5 = self getspectatepoint();
  var_6 = self func_8146();
  var_5.var_126D4 = var_5.origin[2] + var_5.var_126D5 - 44;
  var_7 = [];
  if(var_5.var_126D4 > var_6[2]) {
    var_8 = var_5.origin[0] + var_6[0] * 0.5;
    var_9 = var_5.origin[1] + var_6[1] * 0.5;
    var_7[var_7.size] = (var_8, var_9, var_5.var_126D4);
  }

  var_7[var_7.size] = var_6;
  var_11 = spawn("script_model", var_5.origin);
  var_11 setModel("tag_origin");
  var_11.angles = var_5.angles;
  thread scripts\engine\utility::delete_on_death(var_11);
  self orientmode("face angle", var_5.angles[1]);
  var_12 = 1.63;
  self linkto(var_11);
  var_13 = lib_0A1E::asm_getallanimsforstate(var_0, var_1);
  self clearanim(lib_0A1E::asm_getbodyknob(), 0.2);
  lib_0A1E::func_2369(var_0, var_1, var_13);
  self func_82EA(var_1, var_13, 1, var_2, 1);
  thread func_126D1(var_0, var_1);
  foreach(var_15 in var_7) {
    var_10 = var_12 / var_7.size;
    var_11 moveto(var_15, var_10);
    var_11 waittill("movedone");
  }

  self notify("double_jumped");
  self unlink();
  self.var_DC1A = undefined;
  var_11 delete();
  thread func_11701(var_0, var_1);
}

func_126D2(var_0, var_1, var_2) {
  self unlink();
  self.var_DC1A = undefined;
}

func_D565(var_0, var_1, var_2, var_3) {
  var_4 = self getspectatepoint();
  var_5 = self func_8145();
  func_3E58(var_1);
  var_6 = distance(var_4.origin, var_5.origin);
  self animmode("noclip");
  self orientmode("face angle", var_4.angles[1]);
  var_7 = lib_0A1E::asm_getallanimsforstate(var_0, var_1);
  var_8 = getanimlength(var_7);
  var_9 = getmovedelta(var_7);
  var_10 = length(var_9) / var_8;
  var_11 = var_6 / var_10;
  self clearanim(lib_0A1E::asm_getbodyknob(), var_2);
  self func_82EA(var_1, var_7, 1, var_2, 1);
  wait(var_11);
  func_11701(var_0, var_1);
}

func_126D1(var_0, var_1) {
  self endon("death");
  self endon("terminate_ai_threads");
  self endon(var_1 + "_finished");
  self endon("double_jumped");
  lib_0A1E::func_231F(var_0, var_1);
}

func_D560(var_0, var_1, var_2, var_3) {
  self waittill("external_traverse_complete");
  func_11701(var_0, var_1);
}

func_CF1E(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  self animmode("noclip");
  self orientmode("face angle", self.angles[1]);
  self.var_36A = 1;
  var_4 = lib_0A1E::asm_getallanimsforstate(var_0, var_1);
  self func_82E7(var_1, var_4, 1, var_2, 1);
  lib_0A1E::func_2369(var_0, var_1, var_4);
  lib_0A1E::func_231F(var_0, var_1);
  thread func_11701(var_0, var_1);
}

func_7E83(var_0, var_1, var_2, var_3, var_4) {
  var_5 = lib_0F3D::func_3E96(var_0, var_1);
  var_6 = getnotetracktimes(var_5, var_4);
  var_7 = var_6[0];
  var_8 = getmovedelta(var_5, 0, var_7);
  var_9 = getangledelta(var_5, 0, var_7);
  return lib_0C5E::func_36D9(var_2, var_3[1], var_8, var_9);
}

func_5AE3(var_0, var_1, var_2, var_3) {
  var_4 = var_3[2] - var_2.origin[2];
  if(var_4 < 0) {
    return 0;
  }

  if(isDefined(var_2.var_A4C9) && getdvarint("ai_debug_doublejump", 0) != 2) {
    var_5 = var_2.var_A4C9;
    var_6 = var_2.angles - var_2.var_10DCE;
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
  var_11 = func_7E83(var_0, var_1, var_3, var_10, "footstep_left_small");
  var_12 = var_11 - var_2.origin;
  if(vectordot(var_12, var_9) < 0) {
    return 0;
  }

  return 1;
}

func_3E04(var_0, var_1, var_2, var_3) {
  var_4 = laseroff();
  if(!isDefined(var_4)) {
    thread func_11701(var_0, "double_jump");
    return 0;
  }

  var_5 = func_81D7();
  if(!func_5AE3(var_0, var_2, var_4, var_5)) {
    thread func_11701(var_0, "double_jump");
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

func_81D7() {
  if(isDefined(self.var_126C3)) {
    return self.var_126C3;
  }

  return self func_8146();
}

func_CF21(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  var_4 = laseroff();
  var_5 = var_4.var_5AE2;
  var_6 = var_5 - var_4.origin;
  var_6 = (var_6[0], var_6[1], 0);
  var_7 = vectortoangles(var_6);
  var_8 = lib_0A1E::asm_getallanimsforstate(var_0, var_1);
  var_9 = var_1 + "_finish";
  var_10 = func_7E83(var_0, var_9, var_5, var_7, "mantle_align");
  var_10 = (var_10[0], var_10[1], var_10[2] + var_3);
  func_D50F(var_0, var_1, var_8, var_2, var_10, var_7, 1, 0, 1);
}

func_CF1F(var_0, var_1, var_2, var_3) {
  func_CF21(var_0, var_1, var_2, -8);
}

func_CF26(var_0, var_1, var_2, var_3) {
  func_CF21(var_0, var_1, var_2, -42);
}

doublejumpterminate(var_0, var_1, var_2) {
  self.var_36A = 0;
  self.var_A4CA = undefined;
  self.var_126C5 = undefined;
  self.var_126C3 = undefined;
}

doublejumpearlyterminate(var_0, var_1, var_2) {
  if(!scripts\asm\asm::func_232B(var_1, "end")) {
    doublejumpterminate(var_0, var_1, var_2);
  }
}

isdriving(var_0, var_1, var_2, var_3) {
  return scripts\asm\asm::func_68B0(var_0, var_1, var_2, "end");
}

func_CF24(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  var_4 = laseroff();
  var_5 = func_81D7();
  var_6 = var_4.angles - var_4.var_10DCE;
  if(var_6 != (0, 0, 0)) {
    var_5 = rotatevector(var_5, var_6);
  }

  var_7 = undefined;
  var_8 = getdvarint("ai_debug_doublejump", 0);
  if(var_8 != 2) {
    if(isDefined(var_4.var_A4C9)) {
      var_9 = var_4.var_A4C9;
      if(var_6 != (0, 0, 0)) {
        var_9 = rotatevector(var_9, var_6);
      }

      var_7 = var_4.origin + var_9;
      var_10 = var_7[2];
      var_10 = var_10 - 44;
      if(var_10 > var_5[2]) {
        var_11 = var_4.origin[0] + var_5[0] * 0.5;
        var_12 = var_4.origin[1] + var_5[1] * 0.5;
        var_7 = (var_11, var_12, var_7[2]);
      } else {
        var_7 = undefined;
      }
    }
  }

  var_13 = lib_0A1E::asm_getallanimsforstate(var_0, var_1);
  self.var_A4CA = var_7;
  var_14 = var_1 + "_finish";
  if(func_5AE3(var_0, var_14, var_4, var_5)) {
    var_15 = var_5 - var_4.origin;
    var_15 = (var_15[0], var_15[1], 0);
    var_10 = vectortoangles(var_15);
    var_14 = var_1 + "_finish";
    var_11 = func_7E83(var_0, var_14, var_5, var_10, "footstep_left_small");
    var_5 = var_11;
  }

  var_15 = var_5 - var_4.origin;
  var_12 = 0;
  var_13 = 1;
  if(var_15[2] < 0) {
    var_12 = 1;
    var_14 = getnotetracktimes(var_13, "gravity on");
    if(isDefined(var_14) && var_14.size > 0) {
      var_13 = var_14[0];
    }
  }

  var_15 = (var_15[0], var_15[1], 0);
  var_10 = vectortoangles(var_15);
  func_D50F(var_0, var_1, var_13, var_2, var_5, var_10, var_13, var_12, 1);
}

func_3ED2(var_0, var_1, var_2) {
  var_3 = func_81D7();
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

moveshieldmodel(var_0, var_1) {
  var_2 = var_0.angles - var_0.var_138A6.var_10DCE;
  if(var_2 != (0, 0, 0)) {
    var_3 = rotatevector(var_0.var_138A6.var_C050[var_1], var_2);
    var_4 = var_0.origin + var_3;
  } else {
    var_4 = var_1.origin + var_1.var_138A6.var_C050[var_2];
  }

  return var_4;
}

func_100BF(var_0, var_1, var_2, var_3) {
  if(!isDefined(self.enemy)) {
    return 0;
  }

  var_4 = self.enemy.origin;
  var_5 = self.var_126C5;
  var_6 = moveshieldmodel(var_5, self.var_138BA);
  var_7 = moveshieldmodel(var_5, self.var_138BA + 1);
  var_7 = (var_7[0], var_7[1], var_6[2]);
  var_4 = (var_4[0], var_4[1], var_6[2]);
  var_8 = vectornormalize(var_7 - var_6);
  var_9 = vectornormalize(var_4 - var_6);
  var_10 = vectordot(var_8, var_9);
  if(var_10 < 0.2588) {
    return 0;
  }

  return 1;
}

func_3F0E(var_0, var_1, var_2) {
  var_3 = scripts\asm\asm::asm_lookupanimfromalias(var_1, self.var_138BC);
  return var_3;
}

func_812B(var_0) {
  return var_0 * var_0 * 3 - 2 * var_0;
}

func_11657(var_0, var_1, var_2, var_3, var_4, var_5) {
  self endon(var_0 + "_finished");
  if(var_1 > 0) {
    wait(var_1);
  }

  var_6 = var_2 / var_3;
  var_7 = self.origin[2];
  var_8 = var_7 + var_2[2];
  var_9 = self.origin[2];
  self func_82B1(var_4, var_5);
  for(var_10 = 0; var_10 < var_3; var_10++) {
    var_11 = 1;
    if(var_11) {
      var_12 = var_10 / var_3 - 1;
      var_13 = func_812B(var_12);
      var_14 = var_8 * var_13 + var_7 * 1 - var_13;
      var_15 = var_14 - var_9;
      var_6 = (var_6[0], var_6[1], var_15);
      var_9 = var_14;
    }

    var_10 = self.origin + var_6;
    self func_80F1(var_10);
    if(var_10 + 1 < var_3) {
      scripts\engine\utility::waitframe();
    }
  }

  self func_82B1(var_4, 1);
}

func_138D4(var_0, var_1) {
  if(var_0 == "start_jump") {
    thread func_89BB(var_1);
    return;
  }

  if(var_0 == "end_mantle") {
    self animmode("gravity");
  }
}

func_89BB(var_0, var_1, var_2) {
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
    var_1 = gettime() - var_6 * 0.001;
  }

  var_11 = var_1 / var_10;
  var_12 = getnotetracktimes(var_4, "end_jump");
  var_13 = getnotetracktimes(var_4, "end_double_jump");
  if(var_13.size > 0) {
    self.var_138BD = 1;
    var_12 = var_13;
  } else {
    self.var_138BD = 0;
  }

  if(isDefined(self.var_A4CA)) {
    var_7 = var_12[0] - var_11 / 2 + var_11;
    var_12[0] = var_7;
    var_5 = self.var_A4CA;
  }

  var_14 = getmovedelta(var_4, var_11, var_7);
  var_15 = self gettweakablevalue(var_14);
  if(!isDefined(var_2)) {
    var_2 = 1;
  }

  if(var_9) {
    var_10 = distance(self.origin, var_15);
    var_11 = distance(self.origin, var_5);
    var_2 = var_10 / var_11;
    if(var_2 < 0.7) {
      var_2 = 0.7;
    } else if(var_2 > 1.3) {
      var_2 = 1.3;
    }
  }

  var_13 = var_5 - var_15;
  var_14 = var_12[0] * var_10;
  var_15 = var_14 - var_11 * var_10;
  var_15 = var_15 * 1 / var_2;
  var_16 = var_15 * 20;
  var_16 = ceil(var_16);
  var_17 = gettime();
  func_11657(var_3, 0, var_13, var_16, var_4, var_2);
  if(isDefined(self.var_A4CA)) {
    var_18 = gettime() - var_17 * var_2;
    var_19 = var_1 + var_18 * 0.001;
    self.var_A4CA = undefined;
    var_0[6] = 0;
    func_89BB(var_0, var_19, var_2);
  }
}

func_8213(var_0) {
  var_1 = moveshieldmodel(var_0, 1) - moveshieldmodel(var_0, 0);
  var_2 = vectortoangles(var_1);
  return var_2[1];
}

moveto(var_0) {
  self.var_138BA = 0;
  var_1 = moveshieldmodel(var_0, 1) - moveshieldmodel(var_0, 0);
  var_2 = vectortoangles(var_1);
  self.var_138C1 = var_2[1];
  var_3 = moveshieldmodel(var_0, self.var_138BA);
  var_4 = anglestoright(var_2);
  var_5 = var_3 - var_0.origin;
  var_6 = vectordot(var_4, var_5);
  if(var_6 > 0) {
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
    self.var_126C3 = self func_8146();
  }

  var_0 = self.var_126C5;
  self.var_138BC = moveto(var_0);
}

moveslide() {
  func_FAF8();
  return self.var_138BC;
}

wallrunterminate(var_0, var_1, var_2) {
  self.var_138BA = undefined;
  self.var_138BC = undefined;
  self.var_138BD = undefined;
  self.var_138C1 = undefined;
  self.var_138B9 = undefined;
  self func_82D0();
  self.var_36A = 0;
  self.var_A4CA = undefined;
  self.var_126C5 = undefined;
  self.var_126C3 = undefined;
}

traversalorientearlyterminate(var_0, var_1, var_2) {
  if(!scripts\asm\asm::func_232B(var_1, "end") && !scripts\asm\asm::func_232B(var_1, "code_move")) {
    func_4123(var_0, var_1, var_2);
  }
}

func_D5CF(var_0, var_1, var_2, var_3) {
  self animmode("noclip");
  self orientmode("face angle", self.angles[1]);
  self.var_36A = 1;
  if(isDefined(var_3) && var_3 == "shoot") {
    func_FAF7();
  }

  var_4 = lib_0A1E::asm_getallanimsforstate(var_0, var_1);
  var_5 = getnotetracktimes(var_4, "wall_contact");
  var_6 = var_5[0];
  var_7 = getangledelta(var_4, 0, var_6);
  var_8 = self.var_138C1 - var_7;
  var_9 = (0, var_8, 0);
  self func_80F1(self.origin, var_9);
  self clearanim(lib_0A1E::asm_getbodyknob(), var_2);
  self func_82E7(var_1, var_4, 1, var_2, 1);
  lib_0A1E::func_2369(var_0, var_1, var_4);
  var_10 = lib_0A1E::func_231F(var_0, var_1, scripts\asm\asm::func_2341(var_0, var_1));
  if(var_10 == "end") {
    thread scripts\asm\asm::func_2310(var_0, var_1, 0);
  }
}

moveovertime(var_0) {
  var_1 = func_3F0D(var_0, "wall_run_attach");
  var_2 = getnotetracktimes(var_1, "wall_contact");
  var_3 = var_2[0];
  var_4 = getmovedelta(var_1, 0, var_3);
  var_5 = getangledelta(var_1, 0, var_3);
  return lib_0C5E::func_36D9(moveshieldmodel(self.var_126C5, 0), self.var_138C1, var_4, var_5);
}

func_D5D2(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  var_4 = lib_0A1E::asm_getallanimsforstate(var_0, var_1);
  var_5 = self.var_126C5;
  self.var_138BA = 0;
  var_6 = moveshieldmodel(var_5, 0);
  var_7 = var_6 - self.origin;
  var_7 = (var_7[0], var_7[1], 0);
  var_8 = vectortoangles(var_7);
  var_9 = moveovertime();
  self orientmode("face angle", var_8[1]);
  var_10 = 1;
  var_11 = getnotetracktimes(var_4, "code_move");
  if(isDefined(var_11) && var_11.size > 0) {
    var_10 = var_11[0];
  }

  func_D50F(var_0, var_1, var_4, var_2, var_9, var_8, var_10, 0, 1);
  self func_80F1(var_9, var_8);
  thread scripts\asm\asm::func_2310(var_0, var_1, 0);
}

func_D50F(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
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

  self func_80F1(self.origin, var_5);
  self animmode("noclip");
  self orientmode("face angle", var_5[1]);
  var_9 = getanimlength(var_2);
  var_10 = int(var_9 * 1000);
  self func_85A1(gettime() + var_10 - 1000);
  self.var_36A = 1;
  self func_82E7(var_1, var_2, 1, var_3, 1);
  lib_0A1E::func_2369(var_0, var_1, var_2);
  var_11 = [var_1, var_2, var_4, gettime(), var_6, var_7, var_8];
  lib_0A1E::func_231F(var_0, var_1, ::func_138D4, var_11);
}

func_3F0D(var_0, var_1, var_2) {
  if(isDefined(self.var_138B9)) {
    return self.var_138B9;
  }

  var_3 = self.var_138BC;
  var_4 = angleclamp180(self.var_138C1 - self.angles[1]);
  var_4 = abs(var_4);
  if(var_4 >= 22.5) {
    if(var_4 > 67.5) {
      var_3 = var_3 + "_90";
    } else {
      var_3 = var_3 + "_45";
    }
  }

  self.var_138B9 = scripts\asm\asm::asm_lookupanimfromalias(var_1, var_3);
  return self.var_138B9;
}

func_3F0F(var_0, var_1, var_2) {
  func_FAF8();
  var_3 = self.var_138BC;
  var_4 = self.var_126C5;
  var_5 = moveshieldmodel(var_4, 0);
  var_6 = var_5[2] - self.origin[2];
  var_7 = 0;
  if(var_6 >= 0) {
    if(var_6 > 120) {
      var_7 = 1;
    }
  } else if(0 - var_6 > 240) {
    var_7 = 1;
  }

  if(var_7 == 0) {
    var_8 = distancesquared(self.origin, var_5);
    if(var_8 > -25536) {
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

func_F22D(var_0, var_1, var_2, var_3) {
  self endon(var_0 + "_finished");
  wait(var_1);
  scripts\asm\asm::asm_fireevent(var_0, var_2);
  if(var_3) {
    self notify(var_2);
  }
}

func_8BCB(var_0, var_1, var_2, var_3) {
  if(!isDefined(self.var_138BA)) {
    return 0;
  }

  var_4 = self.var_126C5;
  if(!isDefined(var_4)) {
    return 0;
  }

  var_5 = self.var_138BA + 2;
  if(var_4.var_138A6.var_C050.size <= var_5) {
    return 0;
  }

  return 1;
}

func_D5D0(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  var_4 = self.var_126C5;
  scripts\anim\combat::func_F296();
  self.var_138BA = self.var_138BA + 2;
  var_5 = moveshieldmodel(var_4, self.var_138BA);
  var_6 = self.angles;
  if(self.var_138BC == "left") {
    self.var_138BC = "right";
  } else {
    self.var_138BC = "left";
  }

  var_7 = lib_0A1E::asm_getallanimsforstate(var_0, var_1);
  func_D50F(var_0, var_1, var_7, var_2, var_5, var_6);
}

movey(var_0) {
  var_1 = var_0.angles - var_0.var_138A6.var_10DCE;
  if(var_1 == (0, 0, 0)) {
    return var_0.origin + var_0.var_138A6.var_B313;
  }

  var_2 = rotatevector(var_0.var_138A6.var_B313, var_1);
  return var_0.origin + var_2;
}

movex(var_0) {
  if(!isDefined(var_0.var_138A6.var_B312)) {
    return undefined;
  }

  var_1 = var_0.angles[1] - var_0.var_138A6.var_10DCE[1];
  if(var_1 == 0) {
    return var_0.var_138A6.var_B312;
  }

  return (0, angleclamp180(var_0.var_138A6.var_B312[1] + var_1), 0);
}

movez() {
  var_0 = self.var_126C5;
  if(!isDefined(var_0.var_138A6.var_B313)) {
    return "none";
  }

  var_1 = movey(var_0);
  if(var_1[2] >= self.origin[2]) {
    return "high";
  }

  return "low";
}

func_100C0(var_0, var_1, var_2, var_3) {
  var_4 = self.var_126C5;
  if(!isDefined(var_4.var_138A6.var_331A)) {
    return 0;
  }

  return var_4.var_138A6.var_331A;
}

func_D5D4(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  var_4 = self.var_126C5;
  func_FAF7();
  var_5 = lib_0A1E::asm_getallanimsforstate(var_0, var_1);
  var_6 = getmovedelta(var_5);
  var_7 = length2d(var_6);
  if(!isDefined(var_4.var_138A6.var_B313) && self.var_138BA == var_4.var_138A6.var_C050.size - 2) {
    var_8 = lib_0A1E::asm_getallanimsforstate(var_0, "wall_run_exit");
    var_9 = getnotetracktimes(var_8, "start_jump");
    var_10 = getanimlength(var_8);
    var_11 = getmovedelta(var_8, 0, var_9[0]);
    var_12 = length2d(var_11);
  } else {
    var_12 = 0;
  }

  var_13 = moveshieldmodel(var_4, self.var_138BA + 1) - self.origin;
  var_14 = length(var_13);
  var_14 = var_14 - var_12;
  if(var_14 < 0) {
    var_14 = 0;
  }

  var_15 = var_14 / var_7;
  var_10 = getanimlength(var_5);
  var_11 = var_10 * var_15;
  thread func_F22D(var_1, var_11, "wall_run_loop_done", 1);
  var_12 = vectornormalize(var_13);
  self orientmode("face direction", var_12);
  thread func_D5D1(var_1);
  self animmode("noclip");
  self func_82E7(var_1, var_5, 1, var_2, 1);
  lib_0A1E::func_2369(var_0, var_1, var_5);
  lib_0A1E::func_231F(var_0, var_1);
}

func_D5D1(var_0) {
  self endon("death");
  if(soundexists("wallrun_end_npc")) {
    self waittill("wall_run_loop_done");
    self playSound("wallrun_end_npc");
  }
}

func_3F10(var_0, var_1, var_2) {
  var_3 = self.var_138BC;
  var_4 = self.var_126C3;
  var_5 = var_4[2] - self.origin[2];
  var_6 = 0;
  if(var_5 >= 0) {
    if(var_5 > 120) {
      var_6 = 1;
    }
  } else if(0 - var_5 > 240) {
    var_6 = 1;
  }

  if(var_6 == 0) {
    var_7 = distancesquared(self.origin, var_4);
    if(var_7 > -19311) {
      var_6 = 1;
    }
  }

  if(var_6) {
    var_3 = var_3 + "_double";
  }

  var_4 = self.var_126C3;
  var_8 = self.var_126C5;
  var_9 = self.var_126C3 - moveshieldmodel(var_8, var_8.var_138A6.var_C050.size - 1);
  var_9 = (var_9[0], var_9[1], 0);
  var_9 = vectornormalize(var_9);
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

func_D5D3(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  var_4 = self.var_126C5;
  var_5 = self.var_126C3;
  var_6 = self.angles;
  var_7 = 1;
  var_8 = lib_0A1E::asm_getallanimsforstate(var_0, var_1);
  var_9 = getnotetracktimes(var_8, "ground");
  scripts\anim\combat::func_F296();
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

  func_D50F(var_0, var_1, var_8, var_2, var_5, var_6, var_7, 1, 1);
  thread func_11705(var_0, var_1);
}

func_9EBA(var_0, var_1, var_2, var_3) {
  if(isDefined(self.var_126C5)) {
    return 0;
  }

  return 1;
}

func_11705(var_0, var_1) {
  self.var_138BA = undefined;
  self.var_138BC = undefined;
  self.var_138BD = undefined;
  self.var_138C1 = undefined;
  self.var_138B9 = undefined;
  self func_82D0();
  func_11701(var_0, var_1);
}

func_D5D5(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  var_4 = self.var_126C5;
  var_5 = self.var_126C3;
  var_6 = movey(var_4);
  if(isDefined(var_4.var_138A6.var_331A) || movez() == "high") {
    var_7 = movex(var_4);
    if(!isDefined(var_7)) {
      var_8 = var_5 - var_6;
      var_8 = (var_8[0], var_8[1], 0);
      var_7 = vectortoangles(var_8);
    }
  } else {
    var_8 = var_7 - self.origin;
    var_8 = (var_8[0], var_8[1], 0);
    var_7 = vectortoangles(var_8);
  }

  var_9 = lib_0A1E::asm_getallanimsforstate(var_0, var_1);
  var_10 = getanimlength(var_9);
  var_11 = getnotetracktimes(var_9, "start_mantle");
  var_12 = var_11[0];
  var_13 = getnotetracktimes(var_9, "end_mantle");
  var_14 = var_13[0];
  var_15 = getmovedelta(var_9, var_12, var_14);
  self func_80F1(self.origin, var_7);
  var_10 = self gettweakablevalue(var_15);
  var_11 = var_10 - self.origin;
  var_12 = var_6 - var_11;
  func_D50F(var_0, var_1, var_9, var_2, var_12, var_7, var_12, 0, 1);
  thread func_11705(var_0, var_1);
}

func_D55B(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  var_4 = lib_0A1E::asm_getallanimsforstate(var_0, var_1);
  if(!isDefined(var_4)) {
    scripts\asm\asm::asm_fireevent(var_1, "code_move");
    return;
  }

  var_5 = 1;
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
  var_9 = self.var_126C5;
  var_10 = getanimlength(var_4) * var_5;
  var_11 = int(ceil(var_10 * 20));
  if(self.var_126C5.var_48 == "wall_run") {
    var_12 = moveshieldmodel(self.var_126C5, 0) - self.origin;
    var_13 = vectortoangles(var_12);
    var_14 = var_13[1];
  } else {
    var_15 = self.var_126C3 - self.var_126C5.origin;
    var_15 = (var_15[0], var_15[1], 0);
    var_10 = vectortoangles(var_15);
    var_14 = var_10[1];
  }

  var_11 = lib_0C5E::func_36D9(var_9.origin, var_14, var_7, var_8);
  var_12 = var_14 - var_8;
  self.var_4C7E = lib_0F3D::func_22EA;
  self.a.var_22E5 = var_1;
  self.var_36A = 1;
  self func_8396(var_11, var_12, var_11);
  self clearanim(lib_0A1E::asm_getbodyknob(), var_2);
  self func_82E7(var_1, var_4, 1, var_2, 1);
  lib_0A1E::func_2369(var_0, var_1, var_4);
  lib_0A1E::func_231F(var_0, var_1, scripts\asm\asm::func_2341(var_0, var_1));
  thread scripts\asm\asm::func_2310(var_0, var_1, 0);
}

func_3F12(var_0, var_1, var_2) {
  return lib_0C65::func_3EF5(var_0, var_1, var_2);
}

func_3F07(var_0, var_1, var_2) {
  var_3 = anglesToForward(self.angles);
  var_4 = vectortoangles(var_3);
  if(self.var_126C5.var_48 == "wall_run") {
    var_5 = vectortoangles(moveshieldmodel(self.var_126C5, 0) - self.origin);
  } else {
    var_6 = self.var_126C3 - self.var_126C5.origin;
    var_6 = (var_6[0], var_6[1], 0);
    var_5 = vectortoangles(var_6);
  }

  var_7 = var_5[1];
  var_8 = angleclamp180(var_7 - var_4[1]);
  var_9 = getangleindex(var_8, 22.5);
  var_10 = lib_0C5D::func_8174(var_1, undefined, 1);
  if(!isDefined(var_10[var_9])) {
    return undefined;
  }

  return var_10[var_9];
}

func_FAF0(var_0, var_1, var_2, var_3) {
  var_4 = self func_84F9(120);
  if(!isDefined(var_4)) {
    return 0;
  }

  var_5 = var_4["node"];
  var_6 = var_4["position"];
  if(!isDefined(var_5) || !isDefined(var_5.var_48)) {
    return 0;
  }

  self.var_126C5 = var_5;
  self.var_126C3 = var_6;
  return 1;
}

func_4123(var_0, var_1, var_2, var_3) {
  self.var_126C5 = undefined;
  self.var_126C3 = undefined;
  self.var_138BC = undefined;
  return 0;
}

func_FFB7(var_0, var_1, var_2, var_3) {
  var_4 = distance2dsquared(self.origin, moveshieldmodel(self.var_126C5, 1));
  if(var_4 < 144) {
    return 1;
  }

  return 0;
}

func_FFFD(var_0, var_1, var_2, var_3) {
  if(func_9EBA(var_0, var_1, var_2, var_3)) {
    func_FAF0(var_0, var_1, var_2, var_3);
    if(!isDefined(self.var_126C5)) {
      return 0;
    }

    if(self.var_126C5.var_48 != "wall_run") {
      return 0;
    }

    var_4 = self.var_126C5;
    var_5 = vectornormalize(moveshieldmodel(var_4, 0) - self.origin);
    var_6 = lib_0C65::func_371C(var_1, var_2, var_5, 0, 1);
    if(!isDefined(var_6)) {
      return 0;
    }

    self.a.var_FC61 = var_6;
    self.var_138BC = moveto(self.var_126C5);
    return 1;
  }

  return 0;
}

func_100B3(var_0, var_1, var_2, var_3) {
  if(var_2 == self.var_126C5.var_48) {
    return 1;
  }

  return 0;
}

func_9FB1(var_0) {
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

func_FFFC(var_0, var_1, var_2, var_3) {
  if(!isDefined(self.var_126C5)) {
    return 0;
  }

  if(!func_9FB1(self.var_126C5.var_48)) {
    return 0;
  }

  if(!self.livestreamingenable) {
    return 0;
  }

  var_4 = undefined;
  if(self.var_126C5.var_48 == "wall_run") {
    var_4 = moveto(self.var_126C5);
    var_5 = moveshieldmodel(self.var_126C5, 0) - self.origin;
    var_6 = vectortoangles(var_5);
  } else {
    var_5 = self.var_126C3 - self.var_126C5.origin;
    var_6 = (var_6[0], var_6[1], 0);
    var_5 = vectornormalize(var_6);
    var_6 = vectortoangles(var_5);
  }

  var_7 = var_6[1];
  var_8 = anglesToForward(self.angles);
  var_9 = vectortoangles(var_8);
  var_10 = angleclamp180(var_7 - var_9[1]);
  var_11 = getangleindex(var_10, 22.5);
  var_12 = lib_0C5D::func_8174(var_2, undefined, 1);
  var_13 = var_12[var_11];
  if(!isDefined(var_13)) {
    return 0;
  }

  var_14 = 1;
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

  var_10 = getmovedelta(var_13, 0, var_14);
  var_11 = getangledelta(var_13, 0, var_14);
  var_12 = distance2d(self.origin, self.var_126C5.origin);
  var_13 = length(var_10);
  var_14 = var_12 - var_13;
  if(var_14 < 0) {
    var_15 = anglesToForward(var_6);
    var_16 = vectordot(var_8, var_15);
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
    self.var_138BC = var_4;
  }

  return 1;
}

func_89FB(var_0) {
  if(var_0 == "wall_contact") {
    if(soundexists("wallrun_start_npc")) {
      self playSound("wallrun_start_npc");
    }
  }
}

func_FAF7() {
  self.upaimlimit = -45;
  self.downaimlimit = 45;
  self.setdevdvar = -90;
  self.setmatchdatadef = 90;
}

func_126CE(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  var_4 = lib_0A1E::asm_getallanimsforstate(var_0, var_1);
  self clearanim(lib_0A1E::asm_getbodyknob(), var_2);
  self animmode("noclip", 0);
  var_5 = self getspectatepoint();
  self orientmode("face angle", var_5.angles[1]);
  self func_82EA(var_1, var_4, 1, var_2, 1);
  lib_0A1E::func_231F(var_0, var_1, scripts\asm\asm::func_2341(var_0, var_1));
  func_11701(var_0, var_1);
}

func_3E58(var_0) {}