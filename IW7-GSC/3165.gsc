/************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: 3165.gsc
************************/

func_FFE6() {
  if(isDefined(self.disablearrivals) && self.disablearrivals) {
    return 0;
  }

  return 1;
}

func_C186(param_00, param_01, param_02, param_03) {
  return !func_1008A(param_00, param_01, param_03);
}

func_7F95(param_00) {
  return 256;
}

func_1008A(param_00, param_01, param_02, param_03) {
  if(!func_FFE6()) {
    return 0;
  }

  if(!isDefined(self.vehicle_getspawnerarray)) {
    return 0;
  }

  var_04 = lib_0F3D::func_7DD6();
  if(isDefined(var_04) && isDefined(var_04.type) && var_04.type == "Cover Prone" || var_04.type == "Conceal Prone") {
    return 0;
  }

  if(!scripts\asm\asm::func_232B(param_01, "cover_approach")) {
    return 0;
  }

  if(isDefined(param_03)) {
    if(!isarray(param_03)) {
      var_05 = param_03;
    } else if(var_04.size < 1) {
      var_05 = "Exposed";
    } else {
      var_05 = var_04[0];
    }
  } else {
    var_05 = "Exposed";
  }

  if(!lib_0F3D::func_9D4C(param_00, param_01, param_02, var_05)) {
    return 0;
  }

  var_06 = distance(self.origin, self.vehicle_getspawnerarray);
  var_07 = func_7F95(var_05);
  if(var_06 > var_07) {
    return 0;
  }

  var_08 = 0;
  if(isDefined(param_03) && param_03.size > 1) {
    var_08 = int(param_03[1]);
  }

  var_09 = undefined;
  if(isDefined(param_03) && isarray(param_03) && param_03.size > 2) {
    var_09 = scripts\asm\asm_bb::func_2928(param_03[2]);
  }

  var_0A = scripts\asm\asm::asm_getdemeanor();
  if(var_0A == "casual" || var_0A == "casual_gun") {
    var_0B = 0.4;
    if(self pathdisttogoal() < 25) {
      var_0B = 2;
    }

    self.asm.var_11068 = func_3721(param_00, param_01, param_02, var_05, var_08, undefined, var_09, var_0B);
  } else {
    self.asm.var_11068 = func_3721(param_00, param_01, param_02, var_05, var_08, undefined, var_09);
  }

  if(!isDefined(self.asm.var_11068)) {
    return 0;
  }

  return 1;
}

func_10094(param_00, param_01, param_02, param_03) {
  if(!scripts\asm\asm::func_232B(param_01, "code_move")) {
    return 0;
  }

  return func_10093(param_00, param_01, param_02, param_03);
}

func_10093(param_00, param_01, param_02, param_03) {
  var_04 = scripts\asm\asm::asm_getdemeanor();
  if(!isDefined(param_03) || var_04 != param_03[2]) {
    return 0;
  }

  if(!scripts\asm\asm::func_232C(param_01, "pass_left") && !scripts\asm\asm::func_232C(param_01, "pass_right") && self pathdisttogoal() > 25) {
    return 0;
  }

  return func_1008A(param_00, param_01, param_02, param_03);
}

func_10096(param_00, param_01, param_02, param_03) {
  if(!scripts\asm\asm::func_232B(param_01, "code_move")) {
    return 0;
  }

  return func_10095(param_00, param_01, param_02, param_03);
}

func_10095(param_00, param_01, param_02, param_03) {
  var_04 = scripts\asm\asm::asm_getdemeanor();
  if(!isDefined(param_03) || var_04 != param_03[2]) {
    return 0;
  }

  if(!scripts\asm\asm::func_232C(param_01, "pass_left") && !scripts\asm\asm::func_232C(param_01, "pass_right") && self pathdisttogoal() > 20) {
    return 0;
  }

  return func_1008A(param_00, param_01, param_02, param_03);
}

func_C9B5() {
  var_00 = lib_0F3D::func_7DD6();
  if(!isDefined(var_00)) {
    return 1;
  }

  if(!isDefined(var_00.var_C9A7)) {
    return 1;
  }

  return var_00.var_C9A7;
}

func_10091(param_00, param_01, param_02, param_03) {
  if(scripts\asm\asm_bb::bb_isincombat()) {
    return 0;
  }

  if(!func_C9B5()) {
    return 0;
  }

  return func_1008A(param_00, param_01, param_02, param_03);
}

func_3E97(param_00, param_01, param_02) {
  return self.asm.var_11068;
}

func_3EA4(param_00, param_01, param_02) {
  var_03 = lib_0F3D::func_7DD6();
  if(isDefined(var_03)) {
    var_04 = scripts\asm\shared_utility::getnodeforwardyaw(var_03);
    var_05 = angleclamp(var_04 - var_03.angles[1]);
    var_06 = angleclamp(self.angles[1] - var_03.angles[1]);
    var_07 = getguid(var_05);
    var_08 = getguid(var_06);
    var_09 = var_08 + "_to_" + var_07;
    var_0A = scripts\asm\asm::asm_lookupanimfromalias(param_01, var_09);
    return var_0A;
  }
}

getguid(param_00) {
  var_01 = 8;
  if(param_00 > 45 && param_00 <= 135) {
    var_01 = 4;
  } else if(param_00 > 135 && param_00 <= 225) {
    var_01 = 2;
  } else if(param_00 > 225 && param_00 <= 315) {
    var_01 = 6;
  }

  return var_01;
}

func_3721(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07) {
  var_08 = lib_0F3D::func_7DD6();
  if(isDefined(var_08) && !self _meth_858D() && isDefined(self.physics_querypoint) && self.physics_querypoint == var_08) {
    if(distance2dsquared(self.physics_querypoint.origin, self.vehicle_getspawnerarray) > 4096) {
      if(!isDefined(self.physics_querypoint.var_3723) || self.physics_querypoint.var_3723 < gettime() - 50) {
        self.physics_querypoint.var_3723 = gettime();
      } else {
        self.physics_querypoint delete();
        self.physics_querypoint = undefined;
        var_08 = lib_0F3D::func_7DD6();
      }
    }
  }

  if(param_03 == "Custom") {
    param_02 = self.asm.var_4C86.var_22F1;
    param_04 = self.asm.var_4C86.var_22F6;
  }

  if(!isDefined(param_06)) {
    param_06 = "";
  }

  var_09 = "";
  if(param_04) {
    if(scripts\asm\asm::func_232C(param_01, "pass_left")) {
      var_09 = param_06 + "left";
    } else if(scripts\asm\asm::func_232C(param_01, "pass_right")) {
      var_09 = param_06 + "right";
    } else if(self.asm.footsteps.foot == "right") {
      var_09 = param_06 + "right";
    } else {
      var_09 = param_06 + "left";
    }
  } else {
    var_09 = param_06;
  }

  var_0A = undefined;
  if(isDefined(var_08)) {
    var_0A = var_08.origin;
  } else {
    var_0A = self.vehicle_getspawnerarray;
  }

  if(vectordot(vectornormalize(var_0A - self.origin), anglesToForward(self.angles)) < 0.707) {
    return undefined;
  }

  var_0B = lib_0F3D::func_C057(var_08);
  var_0C = undefined;
  var_0D = undefined;
  if(var_0B) {
    var_0C = scripts\asm\shared_utility::getnodeforwardyaw(var_08, param_03);
    var_0D = var_08.angles;
  }

  return self _meth_8547(var_0A, var_0D, func_7E54(), param_05, var_0B, self.asm.archetype, param_02, scripts\asm\asm::asm_getdemeanor(), var_0C, var_09, param_06, param_07, param_03);
}

func_CECA(param_00, param_01) {
  self endon("runto_arrived");
  self endon(param_01 + "_finished");
  for(;;) {
    self waittill("path_set");
    if(!self.objective_playermask_showtoall) {
      break;
    }
  }

  scripts\asm\asm::asm_fireevent(param_01, "abort");
}

func_CEC9(param_00, param_01) {
  self endon("runto_arrived");
  self endon(param_01 + "_finished");
  for(;;) {
    if(!isDefined(self.vehicle_getspawnerarray)) {
      break;
    }

    wait(0.05);
  }

  scripts\asm\asm::asm_fireevent(param_01, "abort");
}

func_22F3(param_00, param_01, param_02) {
  if(func_C9B5()) {
    var_03 = lib_0F3D::func_7DD6();
    var_04 = self;
    if(lib_0F3D::func_C057(var_03)) {
      var_04 = var_03;
    }

    self orientmode("face angle", var_04.angles[1]);
  }
}

func_22F4(param_00) {
  self endon("death");
  self.asm.var_22F8 = param_00;
  self waittill(param_00 + "_finished");
  self.asm.var_22F8 = undefined;
}

func_CEAA(param_00, param_01, param_02, param_03) {
  self endon(param_01 + "_finished");
  var_04 = 1;
  if(isDefined(param_03)) {
    var_04 = param_03;
  }

  self.var_4C7E = ::lib_0F3D::func_22EA;
  self.a.var_22E5 = param_01;
  self orientmode("face motion");
  thread func_22F4(param_01);
  var_05 = lib_0A1E::asm_getallanimsforstate(param_00, param_01);
  if(!isDefined(var_05)) {
    scripts\asm\asm::asm_fireevent(param_01, "abort", undefined);
    return;
  }

  var_06 = var_05.log;
  var_07 = var_05.var_3F;
  var_08 = (0, var_06[1] - var_05.var_3E, 0);
  var_09 = var_05.areanynavvolumesloaded;
  var_0A = var_08[1];
  if(isDefined(var_05.updategamerprofile) && isDefined(var_05.unloadtransient)) {
    var_0B = var_05.areanynavvolumesloaded - var_05.updategamerprofile;
    var_0B = rotatevectorinverted(var_0B, var_05.unloadtransient);
    var_0C = invertangles(var_05.unloadtransient);
    var_0D = combineangles(var_08, var_0C);
    var_0E = self _meth_846B();
    var_0B = rotatevector(var_0B, var_0E.angles);
    var_09 = var_0B + var_0E.origin;
    var_0F = combineangles(var_0D, var_0E.angles);
    var_0A = var_0F[1];
  }

  var_10 = self.vehicle_getspawnerarray;
  self _meth_8396(var_09, var_0A);
  if(isDefined(self.asm.var_4C86.var_4C38)) {
    var_11 = self.asm.var_4C86.var_4C38;
    self animmode(var_11);
  } else {
    self animmode("zonly_physics", 0);
  }

  lib_0A1E::func_2369(param_00, param_01, var_05.getgrenadedamageradius);
  self clearanim(lib_0A1E::asm_getbodyknob(), param_02);
  var_12 = 1;
  if(isDefined(var_10)) {
    var_13 = length(var_05.stricmp);
    var_14 = length(self.origin - var_10);
    if(var_14 > 1) {
      var_12 = var_13 / length(self.origin - var_10);
    }

    var_12 = clamp(var_12, 0.8, 1.3);
  }

  if(isDefined(self.var_22EE)) {
    self _meth_82E7(param_01, var_05.getgrenadedamageradius, 1, param_02, self.var_BD22 * self.var_22EE * var_04 * var_12);
  } else {
    self _meth_82E7(param_01, var_05.getgrenadedamageradius, 1, param_02, self.var_BD22 * var_04 * var_12);
  }

  thread lib_0F3D::func_444B(param_01);
  lib_0A1E::func_231F(param_00, param_01);
  self.a.movement = "stop";
}

func_7E54() {
  if(isDefined(self.asm.var_4C86.var_22E3)) {
    return self.asm.var_4C86.var_22E3;
  }

  return undefined;
}

_meth_8174(param_00, param_01, param_02, param_03) {
  var_04 = [];
  var_04[5] = ::scripts\asm\asm::func_235C(1, param_00, param_02, param_03);
  var_04[4] = ::scripts\asm\asm::func_235C(2, param_00, param_02, param_03);
  var_04[3] = ::scripts\asm\asm::func_235C(3, param_00, param_02, param_03);
  var_04[6] = ::scripts\asm\asm::func_235C(4, param_00, param_02, param_03);
  var_04[2] = ::scripts\asm\asm::func_235C(6, param_00, param_02, param_03);
  var_04[7] = ::scripts\asm\asm::func_235C(7, param_00, param_02, param_03);
  var_04[0] = ::scripts\asm\asm::func_235C(8, param_00, param_02, param_03);
  var_04[1] = ::scripts\asm\asm::func_235C(9, param_00, param_02, param_03);
  var_04[8] = var_04[0];
  return var_04;
}

getnormalizedmovement(param_00, param_01, param_02, param_03) {
  var_04 = [];
  var_04["cover_left_arrival"]["7"] = 0.369369;
  var_04["cover_left_crouch_arrival"]["7"] = 0.321321;
  var_04["cqb_cover_left_crouch_arrival"]["7"] = 0.2002;
  var_04["cqb_cover_left_arrival"]["7"] = 0.275275;
  var_04["cover_left_arrival"]["8"] = 0.525526;
  var_04["cover_left_crouch_arrival"]["8"] = 0.448448;
  var_04["cqb_cover_left_crouch_arrival"]["8"] = 0.251251;
  var_04["cqb_cover_left_arrival"]["8"] = 0.335335;
  var_04["cover_right_arrival"]["8"] = 0.472472;
  var_04["cover_right_crouch_arrival"]["8"] = 0.248248;
  var_04["cqb_cover_right_arrival"]["8"] = 0.345345;
  var_04["cqb_cover_right_crouch_arrival"]["8"] = 0.428428;
  var_04["cover_right_arrival"]["9"] = 0.551552;
  var_04["cover_right_crouch_arrival"]["9"] = 0.2002;
  var_04["cqb_cover_right_arrival"]["9"] = 0.3003;
  var_04["cqb_cover_right_crouch_arrival"]["9"] = 0.224224;
  return var_04[param_01][param_02];
}

lerpviewangleclamp(param_00, param_01, param_02, param_03) {
  if(!isDefined(level.archetypes[param_00].var_1FAD)) {
    level.archetypes[param_00].var_1FAD = [];
  }

  if(!isDefined(level.archetypes[param_00].var_1FAD[param_01])) {
    level.archetypes[param_00].var_1FAD[param_01] = [];
  }

  if(!isDefined(level.archetypes[param_00].var_1FAD[param_01][param_02])) {
    var_04 = getnormalizedmovement(param_00, param_01, param_02, param_03);
    var_05 = scripts\asm\asm::func_235C(param_02, param_01, param_03);
    level.archetypes[param_00].var_1FAD[param_01][param_02] = getmovedelta(var_05, 0, var_04);
  }

  var_06 = level.archetypes[param_00].var_1FAD[param_01][param_02];
  return var_06;
}

func_FFD4(param_00, param_01, param_02, param_03) {
  if(!func_FFE6()) {
    return 0;
  }

  if(!isDefined(self.vehicle_getspawnerarray)) {
    return 0;
  }

  scripts\asm\asm::asm_updatefrantic();
  var_04 = lib_0F3D::func_7DD6();
  if(isDefined(var_04) && isDefined(var_04.type) && var_04.type == "Cover Prone" || var_04.type == "Conceal Prone") {
    return 0;
  }

  if(isDefined(var_04)) {
    var_05 = undefined;
    if((scripts\engine\utility::isnodecoverleft(var_04) && lib_0F3D::func_9D4C(param_00, param_01, undefined, "Cover Left Crouch")) || scripts\engine\utility::isnodecoverright(var_04) && lib_0F3D::func_9D4C(param_00, param_01, undefined, "Cover Right Crouch")) {
      var_05 = "crouch";
    }

    var_06 = scripts\asm\shared_utility::_meth_812E(var_04, var_05);
    self _meth_853D(var_06);
  }

  var_07 = self.var_164D[param_00].var_4BC0;
  if(!scripts\asm\asm::func_232B(var_07, "cover_approach")) {
    return 0;
  }

  return 1;
}

func_FFD5(param_00, param_01, param_02, param_03) {
  if(!scripts\asm\asm::func_232B(param_01, "code_move")) {
    return 0;
  }

  return func_FFD4(param_00, param_01, param_02, param_03);
}

func_1008F(param_00, param_01, param_02, param_03) {
  if(isDefined(param_03)) {
    if(!isarray(param_03)) {
      var_04 = param_03;
    } else if(var_04.size < 1) {
      var_04 = "Exposed";
    } else {
      var_04 = var_04[0];
    }
  } else {
    var_04 = "Exposed";
  }

  if(!lib_0F3D::func_9D4C(param_00, param_01, param_02, var_04)) {
    return 0;
  }

  var_05 = distance(self.origin, self.vehicle_getspawnerarray);
  var_06 = func_7F95(var_04);
  if(var_05 > var_06) {
    return 0;
  }

  var_07 = 0;
  if(isDefined(param_03) && isarray(param_03) && param_03.size >= 2) {
    var_07 = 1;
  }

  var_08 = undefined;
  var_09 = self.var_164D[param_00].var_4BC0;
  var_0A = scripts\asm\asm::func_233F(var_09, "cover_approach");
  if(isDefined(var_0A)) {
    var_08 = var_0A.params;
  }

  self.asm.var_11068 = func_3721(param_00, param_01, param_02, var_04, var_07, var_08);
  if(!isDefined(self.asm.var_11068)) {
    return 0;
  }

  return 1;
}

func_10090(param_00, param_01, param_02, param_03) {
  if(!isDefined(param_03) || param_03.size < 1) {
    var_04 = "Exposed";
  } else {
    var_04 = var_04[0];
  }

  if(!lib_0F3D::func_9D4C(param_00, param_01, param_02, var_04)) {
    return 0;
  }

  var_05 = distance(self.origin, self.vehicle_getspawnerarray);
  var_06 = func_7F95(var_04);
  if(var_05 > var_06) {
    return 0;
  }

  var_07 = 0;
  if(isDefined(param_03) && param_03.size >= 2) {
    var_07 = 1;
  }

  var_08 = undefined;
  var_09 = scripts\asm\asm::func_233F(param_01, "cover_approach");
  if(isDefined(var_09)) {
    var_08 = var_09.params;
  }

  self.asm.var_11068 = func_3721(param_00, param_01, param_02, var_04, var_07, var_08);
  if(!isDefined(self.asm.var_11068)) {
    return 0;
  }

  return 1;
}