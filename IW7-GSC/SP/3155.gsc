/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: SP\3155.gsc
*********************************************/

func_B063(var_0, var_1, var_2, var_3) {
  lib_0A1E::func_235F(var_0, var_1, var_2, self.moveplaybackrate);
}

func_B064(var_0, var_1, var_2, var_3) {}

func_F171(var_0, var_1, var_2, var_3) {
  var_4 = getclosestpointonnavmesh(self.origin);
  var_5 = distancesquared(var_4, self.origin);
  if(var_5 > squared(15)) {
    return 1;
  }

  return 0;
}

func_11701(var_0, var_1) {
  var_2 = level.asm[var_0].states[var_1];
  var_3 = undefined;
  if(isarray(var_2.var_116FB)) {
    var_3 = var_2.var_116FB[0];
  } else {
    var_3 = var_2.var_116FB;
  }

  scripts\asm\asm::func_2388(var_0, var_1, var_2, var_2.var_116FB);
  scripts\asm\asm::func_238A(var_0, var_3, 0.2, undefined, undefined, undefined);
  self notify("killanimscript");
}

func_F16E(var_0, var_1, var_2, var_3) {
  var_4 = level.asm[var_0].states[var_1].var_71A5;
  var_5 = self[[var_4]](var_0, var_1, var_3);
  var_6 = getanimlength(var_5);
  self func_82E4("deathanim", var_5, lib_0A1E::asm_getbodyknob(), 1, 0.1);
  wait(var_6);
  self notify("terminate_ai_threads");
  self notify("killanimscript");
}

func_F16C(var_0, var_1, var_2, var_3) {
  if(isDefined(self.var_2029)) {
    self.var_2029 delete();
  }

  self.var_EA0E = 1;
  stopFXOnTag(level.var_7649["seeker_" + self.team], self, "tag_fx");
  self func_8484();
  self func_8481(self.origin);
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

isfactorinuse(var_0, var_1, var_2, var_3) {
  if(!isDefined(self.vehicle_getspawnerarray)) {
    return 0;
  }

  var_4 = vectortoangles(self.setocclusionpreset);
  self orientmode("face angle", var_4[1]);
  var_5 = vectordot(vectornormalize((self.setocclusionpreset[0], self.setocclusionpreset[1], 0)), anglesToForward(self.angles));
  var_6 = 0.966;
  return var_5 > var_6;
}

func_D55F(var_0, var_1, var_2, var_3) {
  self endon("death");
  var_4 = self getspectatepoint();
  var_5 = scripts\engine\utility::drop_to_ground(var_4.origin, 5);
  var_6 = self func_8146();
  var_6 = scripts\engine\utility::drop_to_ground(var_6, 5);
  self orientmode("face angle", var_4.angles[1]);
  var_7 = distance(var_5, var_6);
  var_8 = scripts\sp\utility::func_BD6B(20, var_7);
  var_9 = 30;
  var_0A = 1 / var_9 * var_8;
  var_0B = 0;
  var_0C = 0;
  while(!var_0C) {
    if(var_0B > 1) {
      var_0B = 1;
      var_0C = 1;
    }

    var_0D = vectorlerp(var_5, var_6, var_0B);
    var_0B = var_0B + var_0A;
    self func_80F1(var_0D, self.angles, 10000);
    scripts\engine\utility::waitframe();
  }

  self func_80F1(var_6, self.angles, 10000);
  func_11701(var_0, var_1);
}

func_CF22(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  var_4 = self getspectatepoint();
  var_5 = var_4.var_5AE2;
  var_6 = var_5 - var_4.origin;
  thread func_D561(var_0, var_1, var_2, [var_6[2]]);
}

func_CF20(var_0, var_1, var_2, var_3) {
  func_CF22(var_0, var_1, var_2, -8);
}

func_CF27(var_0, var_1, var_2, var_3) {
  func_CF22(var_0, var_1, var_2, -42);
}

func_CF23(var_0, var_1, var_2, var_3) {
  self endon("death");
  var_4 = self.origin;
  var_5 = getclosestpointonnavmesh(var_4, self);
  var_5 = scripts\engine\utility::drop_to_ground(var_5, 50);
  var_6 = 0;
  func_A4E8(var_0, var_1, var_2, var_4, self.angles, var_5, var_6, 1);
  scripts\asm\asm::asm_fireevent(var_1, "end");
}

func_CF25(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  var_4 = self getspectatepoint();
  var_5 = self func_8146();
  var_6 = var_5 - var_4.origin;
  var_6 = (var_6[0], var_6[1], 0);
  func_D561(var_0, var_1, var_2, [var_6[2]]);
}

func_3EA3(var_0, var_1, var_2) {
  return scripts\asm\asm::asm_lookupanimfromalias("traverse_external", var_2);
}

func_D561(var_0, var_1, var_2, var_3) {
  self endon("death");
  var_4 = self getspectatepoint();
  var_5 = scripts\engine\utility::drop_to_ground(var_4.origin, 5);
  var_6 = self func_8146();
  var_6 = scripts\engine\utility::drop_to_ground(var_6, 5);
  var_7 = 0;
  if(isDefined(var_3)) {
    if(isarray(var_3)) {
      var_7 = var_3[0];
    } else {
      var_7 = var_3;
    }
  } else if(isDefined(var_4.var_126D4)) {
    var_7 = var_4.var_126D5;
  }

  func_A4E8(var_0, var_1, var_2, var_5, var_4.angles, var_6, var_7, 0);
  func_11701(var_0, var_1);
}

func_A4E8(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  self animmode("noclip");
  self.var_36A = 1;
  var_8 = 16;
  var_9 = (0, 0, 5);
  var_0A = var_3 + var_9;
  var_0B = var_5 + var_9;
  var_0C = max(var_8, var_6 + var_8);
  var_0D = var_0B + var_0A * 0.5;
  var_0E = var_0D[2];
  var_0F = var_0C + var_0A[2] - var_0E;
  var_10 = var_0D + (0, 0, 1) * var_0F;
  if(var_7) {
    var_11 = scripts\common\trace::create_solid_ai_contents(1);
    var_12 = scripts\common\trace::ray_trace(var_10, var_0A, self, var_11);
    var_13 = scripts\common\trace::ray_trace(var_10, var_0B, self, var_11);
    if(var_12["fraction"] < 0.95 || var_13["fraction"] < 0.95) {
      return;
    }
  }

  var_14 = func_3EA3(var_0, var_1, "takeoff");
  self clearanim(lib_0A1E::asm_getbodyknob(), var_2);
  self func_82EA(var_1, var_14, 1, var_2, 1);
  wait(getanimlength(var_14) - 0.1);
  var_15 = distance(var_0A, var_10) + distance(var_0B, var_10);
  var_16 = scripts\sp\utility::func_BD6B(25, var_15);
  var_17 = 30;
  var_18 = 1 / var_17 * var_16;
  self orientmode("face angle", var_4[1]);
  func_F154(self.pausemayhem);
  thread scripts\sp\utility::play_sound_on_entity("seeker_jump_start");
  var_19 = func_3EA3(var_0, var_1, "jumploop");
  self clearanim(lib_0A1E::asm_getbodyknob(), var_2);
  self func_82EA(var_1, var_19, 1, var_2, 1);
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
    self func_80F1(var_1D, self.angles, 10000);
    if(var_1A > 0.7 && !var_1C) {
      var_19 = func_3EA3(var_0, var_1, "fallloop");
      self clearanim(lib_0A1E::asm_getbodyknob(), var_2);
      self func_82EA(var_1, var_19, 1, var_2, 1);
      killfxontag(level.var_7649["seeker_thruster"], self, "tag_origin");
      var_1C = 1;
    }

    scripts\engine\utility::waitframe();
  }

  self.var_A481 delete();
  self func_80F1(var_0B, self.angles, 10000);
  func_F154(self.pausemayhem);
  var_1E = func_3EA3(var_0, var_1, "land");
  self clearanim(lib_0A1E::asm_getbodyknob(), var_2);
  self func_82EA(var_1, var_1E, 1, var_2, 1);
  thread scripts\sp\utility::play_sound_on_entity("seeker_jump_end");
  wait(getanimlength(var_1E) - 0.05);
  self.var_36A = 0;
}

func_F154(var_0) {
  if(!isDefined(var_0)) {
    return;
  }

  if(isDefined(level.optionalstepeffects) && isDefined(level.optionalstepeffects[var_0])) {
    if(!isDefined(level._effect["step_" + var_0][self.unittype])) {
      if(!isDefined(level._effect["step_" + var_0]["soldier"])) {
        return;
      }

      level._effect["step_" + var_0][self.unittype] = level._effect["step_" + var_0]["soldier"];
    }

    scripts\anim\notetracks::playfootstepeffect("tag_origin", var_0);
  }
}

func_9FBC(var_0, var_1, var_2, var_3) {
  if(!isDefined(self.melee.target)) {
    return 0;
  }

  if(var_3 == "player") {
    return isplayer(self.melee.target);
  }

  return isDefined(self.melee.target.unittype) && tolower(self.melee.target.unittype) == tolower(var_3);
}