/************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: SP\3155.gsc
************************/

func_B063(param_00, param_01, param_02, param_03) {
  lib_0A1E::func_235F(param_00, param_01, param_02, self.moveplaybackrate);
}

func_B064(param_00, param_01, param_02, param_03) {}

func_F171(param_00, param_01, param_02, param_03) {
  var_04 = getclosestpointonnavmesh(self.origin);
  var_05 = distancesquared(var_04, self.origin);
  if(var_05 > squared(15)) {
    return 1;
  }

  return 0;
}

func_11701(param_00, param_01) {
  var_02 = level.asm[param_00].states[param_01];
  var_03 = undefined;
  if(isarray(var_02.var_116FB)) {
    var_03 = var_02.var_116FB[0];
  } else {
    var_03 = var_02.var_116FB;
  }

  scripts\asm\asm::func_2388(param_00, param_01, var_02, var_02.var_116FB);
  scripts\asm\asm::func_238A(param_00, var_03, 0.2, undefined, undefined, undefined);
  self notify("killanimscript");
}

func_F16E(param_00, param_01, param_02, param_03) {
  var_04 = level.asm[param_00].states[param_01].var_71A5;
  var_05 = self[[var_04]](param_00, param_01, param_03);
  var_06 = getanimlength(var_05);
  self _meth_82E4("deathanim", var_05, lib_0A1E::asm_getbodyknob(), 1, 0.1);
  wait(var_06);
  self notify("terminate_ai_threads");
  self notify("killanimscript");
}

func_F16C(param_00, param_01, param_02, param_03) {
  if(isDefined(self.var_2029)) {
    self.var_2029 delete();
  }

  self.var_EA0E = 1;
  stopFXOnTag(level.var_7649["seeker_" + self.team], self, "tag_fx");
  self _meth_8484();
  self _meth_8481(self.origin);
  if(isDefined(self.var_B14F)) {
    self notify("stop_magic_bullet_shield");
    self.var_B14F = undefined;
    self.var_E0 = 0;
    self notify("internal_stop_magic_bullet_shield");
  }

  playFX(level.var_7649["seeker_sparks"], self gettagorigin("tag_fx"));
  playworldsound("seeker_expire", self.origin);
  self hudoutlinedisable();
  self notify("terminate_ai_threads");
  self notify("killanimscript");
  self delete();
}

isfactorinuse(param_00, param_01, param_02, param_03) {
  if(!isDefined(self.vehicle_getspawnerarray)) {
    return 0;
  }

  var_04 = vectortoangles(self.setocclusionpreset);
  self orientmode("face angle", var_04[1]);
  var_05 = vectordot(vectornormalize((self.setocclusionpreset[0], self.setocclusionpreset[1], 0)), anglesToForward(self.angles));
  var_06 = 0.966;
  return var_05 > var_06;
}

func_D55F(param_00, param_01, param_02, param_03) {
  self endon("death");
  var_04 = self getspectatepoint();
  var_05 = scripts\engine\utility::drop_to_ground(var_04.origin, 5);
  var_06 = self _meth_8146();
  var_06 = scripts\engine\utility::drop_to_ground(var_06, 5);
  self orientmode("face angle", var_04.angles[1]);
  var_07 = distance(var_05, var_06);
  var_08 = scripts\sp\utility::func_BD6B(20, var_07);
  var_09 = 30;
  var_0A = 1 / var_09 * var_08;
  var_0B = 0;
  var_0C = 0;
  while(!var_0C) {
    if(var_0B > 1) {
      var_0B = 1;
      var_0C = 1;
    }

    var_0D = vectorlerp(var_05, var_06, var_0B);
    var_0B = var_0B + var_0A;
    self _meth_80F1(var_0D, self.angles, 10000);
    scripts\engine\utility::waitframe();
  }

  self _meth_80F1(var_06, self.angles, 10000);
  func_11701(param_00, param_01);
}

func_CF22(param_00, param_01, param_02, param_03) {
  self endon(param_01 + "_finished");
  var_04 = self getspectatepoint();
  var_05 = var_04.var_5AE2;
  var_06 = var_05 - var_04.origin;
  thread func_D561(param_00, param_01, param_02, [var_06[2]]);
}

func_CF20(param_00, param_01, param_02, param_03) {
  func_CF22(param_00, param_01, param_02, -8);
}

func_CF27(param_00, param_01, param_02, param_03) {
  func_CF22(param_00, param_01, param_02, -42);
}

func_CF23(param_00, param_01, param_02, param_03) {
  self endon("death");
  var_04 = self.origin;
  var_05 = getclosestpointonnavmesh(var_04, self);
  var_05 = scripts\engine\utility::drop_to_ground(var_05, 50);
  var_06 = 0;
  func_A4E8(param_00, param_01, param_02, var_04, self.angles, var_05, var_06, 1);
  scripts\asm\asm::asm_fireevent(param_01, "end");
}

func_CF25(param_00, param_01, param_02, param_03) {
  self endon(param_01 + "_finished");
  var_04 = self getspectatepoint();
  var_05 = self _meth_8146();
  var_06 = var_05 - var_04.origin;
  var_06 = (var_06[0], var_06[1], 0);
  func_D561(param_00, param_01, param_02, [var_06[2]]);
}

func_3EA3(param_00, param_01, param_02) {
  return scripts\asm\asm::asm_lookupanimfromalias("traverse_external", param_02);
}

func_D561(param_00, param_01, param_02, param_03) {
  self endon("death");
  var_04 = self getspectatepoint();
  var_05 = scripts\engine\utility::drop_to_ground(var_04.origin, 5);
  var_06 = self _meth_8146();
  var_06 = scripts\engine\utility::drop_to_ground(var_06, 5);
  var_07 = 0;
  if(isDefined(param_03)) {
    if(isarray(param_03)) {
      var_07 = param_03[0];
    } else {
      var_07 = param_03;
    }
  } else if(isDefined(var_04.var_126D4)) {
    var_07 = var_04.var_126D5;
  }

  func_A4E8(param_00, param_01, param_02, var_05, var_04.angles, var_06, var_07, 0);
  func_11701(param_00, param_01);
}

func_A4E8(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07) {
  self animmode("noclip");
  self.var_36A = 1;
  var_08 = 16;
  var_09 = (0, 0, 5);
  var_0A = param_03 + var_09;
  var_0B = param_05 + var_09;
  var_0C = max(var_08, param_06 + var_08);
  var_0D = var_0B + var_0A * 0.5;
  var_0E = var_0D[2];
  var_0F = var_0C + var_0A[2] - var_0E;
  var_10 = var_0D + (0, 0, 1) * var_0F;
  if(param_07) {
    var_11 = scripts\common\trace::create_solid_ai_contents(1);
    var_12 = scripts\common\trace::ray_trace(var_10, var_0A, self, var_11);
    var_13 = scripts\common\trace::ray_trace(var_10, var_0B, self, var_11);
    if(var_12["fraction"] < 0.95 || var_13["fraction"] < 0.95) {
      return;
    }
  }

  var_14 = func_3EA3(param_00, param_01, "takeoff");
  self clearanim(lib_0A1E::asm_getbodyknob(), param_02);
  self _meth_82EA(param_01, var_14, 1, param_02, 1);
  wait(getanimlength(var_14) - 0.1);
  var_15 = distance(var_0A, var_10) + distance(var_0B, var_10);
  var_16 = scripts\sp\utility::func_BD6B(25, var_15);
  var_17 = 30;
  var_18 = 1 / var_17 * var_16;
  self orientmode("face angle", param_04[1]);
  func_F154(self.pausemayhem);
  thread scripts\sp\utility::play_sound_on_entity("seeker_jump_start");
  var_19 = func_3EA3(param_00, param_01, "jumploop");
  self clearanim(lib_0A1E::asm_getbodyknob(), param_02);
  self _meth_82EA(param_01, var_19, 1, param_02, 1);
  self.var_A481 = scripts\engine\utility::spawn_tag_origin();
  self.var_A481 linkto(self, "tag_origin", (0, 0, 0), (90, 0, 0));
  playFXOnTag(level.var_7649["seeker_thruster"], self.var_A481, "tag_origin");
  var_1A = 0;
  var_1B = 0;
  var_1C = 0;
  while(!var_1B) {
    if(var_1A > 1) {
      var_1A = 1;
      var_1B = 1;
    }

    var_1D = scripts\sp\math::func_7BC5(var_0A, var_0B, var_0F, var_1A);
    var_1A = var_1A + var_18;
    self _meth_80F1(var_1D, self.angles, 10000);
    if(var_1A > 0.7 && !var_1C) {
      var_19 = func_3EA3(param_00, param_01, "fallloop");
      self clearanim(lib_0A1E::asm_getbodyknob(), param_02);
      self _meth_82EA(param_01, var_19, 1, param_02, 1);
      killfxontag(level.var_7649["seeker_thruster"], self, "tag_origin");
      var_1C = 1;
    }

    scripts\engine\utility::waitframe();
  }

  self.var_A481 delete();
  self _meth_80F1(var_0B, self.angles, 10000);
  func_F154(self.pausemayhem);
  var_1E = func_3EA3(param_00, param_01, "land");
  self clearanim(lib_0A1E::asm_getbodyknob(), param_02);
  self _meth_82EA(param_01, var_1E, 1, param_02, 1);
  thread scripts\sp\utility::play_sound_on_entity("seeker_jump_end");
  wait(getanimlength(var_1E) - 0.05);
  self.var_36A = 0;
}

func_F154(param_00) {
  if(!isDefined(param_00)) {
    return;
  }

  if(isDefined(level.optionalstepeffects) && isDefined(level.optionalstepeffects[param_00])) {
    if(!isDefined(level._effect["step_" + param_00][self.unittype])) {
      if(!isDefined(level._effect["step_" + param_00]["soldier"])) {
        return;
      }

      level._effect["step_" + param_00][self.unittype] = level._effect["step_" + param_00]["soldier"];
    }

    scripts\anim\notetracks::playfootstepeffect("tag_origin", param_00);
  }
}

func_9FBC(param_00, param_01, param_02, param_03) {
  if(!isDefined(self.melee.target)) {
    return 0;
  }

  if(param_03 == "player") {
    return isplayer(self.melee.target);
  }

  return isDefined(self.melee.target.unittype) && tolower(self.melee.target.unittype) == tolower(param_03);
}