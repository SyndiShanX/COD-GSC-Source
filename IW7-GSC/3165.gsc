/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: 3165.gsc
*********************************************/

func_FFE6() {
  if(isDefined(self.disablearrivals) && self.disablearrivals) {
    return 0;
  }

  return 1;
}

func_C186(var_0, var_1, var_2, var_3) {
  return !func_1008A(var_0, var_1, var_3);
}

func_7F95(var_0) {
  return 256;
}

func_1008A(var_0, var_1, var_2, var_3) {
  if(!func_FFE6()) {
    return 0;
  }

  if(!isDefined(self.vehicle_getspawnerarray)) {
    return 0;
  }

  var_4 = lib_0F3D::func_7DD6();
  if(isDefined(var_4) && isDefined(var_4.type) && var_4.type == "Cover Prone" || var_4.type == "Conceal Prone") {
    return 0;
  }

  if(!scripts\asm\asm::func_232B(var_1, "cover_approach")) {
    return 0;
  }

  if(isDefined(var_3)) {
    if(!isarray(var_3)) {
      var_5 = var_3;
    } else if(var_4.size < 1) {
      var_5 = "Exposed";
    } else {
      var_5 = var_4[0];
    }
  } else {
    var_5 = "Exposed";
  }

  if(!lib_0F3D::func_9D4C(var_0, var_1, var_2, var_5)) {
    return 0;
  }

  var_6 = distance(self.origin, self.vehicle_getspawnerarray);
  var_7 = func_7F95(var_5);
  if(var_6 > var_7) {
    return 0;
  }

  var_8 = 0;
  if(isDefined(var_3) && var_3.size > 1) {
    var_8 = int(var_3[1]);
  }

  var_9 = undefined;
  if(isDefined(var_3) && isarray(var_3) && var_3.size > 2) {
    var_9 = scripts\asm\asm_bb::func_2928(var_3[2]);
  }

  var_10 = scripts\asm\asm::asm_getdemeanor();
  if(var_10 == "casual" || var_10 == "casual_gun") {
    var_11 = 0.4;
    if(self pathdisttogoal() < 25) {
      var_11 = 2;
    }

    self.asm.var_11068 = func_3721(var_0, var_1, var_2, var_5, var_8, undefined, var_9, var_11);
  } else {
    self.asm.var_11068 = func_3721(var_0, var_1, var_2, var_5, var_8, undefined, var_9);
  }

  if(!isDefined(self.asm.var_11068)) {
    return 0;
  }

  return 1;
}

func_10094(var_0, var_1, var_2, var_3) {
  if(!scripts\asm\asm::func_232B(var_1, "code_move")) {
    return 0;
  }

  return func_10093(var_0, var_1, var_2, var_3);
}

func_10093(var_0, var_1, var_2, var_3) {
  var_4 = scripts\asm\asm::asm_getdemeanor();
  if(!isDefined(var_3) || var_4 != var_3[2]) {
    return 0;
  }

  if(!scripts\asm\asm::func_232C(var_1, "pass_left") && !scripts\asm\asm::func_232C(var_1, "pass_right") && self pathdisttogoal() > 25) {
    return 0;
  }

  return func_1008A(var_0, var_1, var_2, var_3);
}

func_10096(var_0, var_1, var_2, var_3) {
  if(!scripts\asm\asm::func_232B(var_1, "code_move")) {
    return 0;
  }

  return func_10095(var_0, var_1, var_2, var_3);
}

func_10095(var_0, var_1, var_2, var_3) {
  var_4 = scripts\asm\asm::asm_getdemeanor();
  if(!isDefined(var_3) || var_4 != var_3[2]) {
    return 0;
  }

  if(!scripts\asm\asm::func_232C(var_1, "pass_left") && !scripts\asm\asm::func_232C(var_1, "pass_right") && self pathdisttogoal() > 20) {
    return 0;
  }

  return func_1008A(var_0, var_1, var_2, var_3);
}

func_C9B5() {
  var_0 = lib_0F3D::func_7DD6();
  if(!isDefined(var_0)) {
    return 1;
  }

  if(!isDefined(var_0.var_C9A7)) {
    return 1;
  }

  return var_0.var_C9A7;
}

func_10091(var_0, var_1, var_2, var_3) {
  if(scripts\asm\asm_bb::bb_isincombat()) {
    return 0;
  }

  if(!func_C9B5()) {
    return 0;
  }

  return func_1008A(var_0, var_1, var_2, var_3);
}

func_3E97(var_0, var_1, var_2) {
  return self.asm.var_11068;
}

func_3EA4(var_0, var_1, var_2) {
  var_3 = lib_0F3D::func_7DD6();
  if(isDefined(var_3)) {
    var_4 = scripts\asm\shared_utility::getnodeforwardyaw(var_3);
    var_5 = angleclamp(var_4 - var_3.angles[1]);
    var_6 = angleclamp(self.angles[1] - var_3.angles[1]);
    var_7 = getguid(var_5);
    var_8 = getguid(var_6);
    var_9 = var_8 + "_to_" + var_7;
    var_10 = scripts\asm\asm::asm_lookupanimfromalias(var_1, var_9);
    return var_10;
  }
}

getguid(var_0) {
  var_1 = 8;
  if(var_0 > 45 && var_0 <= 135) {
    var_1 = 4;
  } else if(var_0 > 135 && var_0 <= 225) {
    var_1 = 2;
  } else if(var_0 > 225 && var_0 <= 315) {
    var_1 = 6;
  }

  return var_1;
}

func_3721(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  var_8 = lib_0F3D::func_7DD6();
  if(isDefined(var_8) && !self func_858D() && isDefined(self.physics_querypoint) && self.physics_querypoint == var_8) {
    if(distance2dsquared(self.physics_querypoint.origin, self.vehicle_getspawnerarray) > 4096) {
      if(!isDefined(self.physics_querypoint.var_3723) || self.physics_querypoint.var_3723 < gettime() - 50) {
        self.physics_querypoint.var_3723 = gettime();
      } else {
        self.physics_querypoint delete();
        self.physics_querypoint = undefined;
        var_8 = lib_0F3D::func_7DD6();
      }
    }
  }

  if(var_3 == "Custom") {
    var_2 = self.asm.var_4C86.var_22F1;
    var_4 = self.asm.var_4C86.var_22F6;
  }

  if(!isDefined(var_6)) {
    var_6 = "";
  }

  var_9 = "";
  if(var_4) {
    if(scripts\asm\asm::func_232C(var_1, "pass_left")) {
      var_9 = var_6 + "left";
    } else if(scripts\asm\asm::func_232C(var_1, "pass_right")) {
      var_9 = var_6 + "right";
    } else if(self.asm.footsteps.foot == "right") {
      var_9 = var_6 + "right";
    } else {
      var_9 = var_6 + "left";
    }
  } else {
    var_9 = var_6;
  }

  var_10 = undefined;
  if(isDefined(var_8)) {
    var_10 = var_8.origin;
  } else {
    var_10 = self.vehicle_getspawnerarray;
  }

  if(vectordot(vectornormalize(var_10 - self.origin), anglesToForward(self.angles)) < 0.707) {
    return undefined;
  }

  var_11 = lib_0F3D::func_C057(var_8);
  var_12 = undefined;
  var_13 = undefined;
  if(var_11) {
    var_12 = scripts\asm\shared_utility::getnodeforwardyaw(var_8, var_3);
    var_13 = var_8.angles;
  }

  return self func_8547(var_10, var_13, func_7E54(), var_5, var_11, self.asm.archetype, var_2, scripts\asm\asm::asm_getdemeanor(), var_12, var_9, var_6, var_7, var_3);
}

func_CECA(var_0, var_1) {
  self endon("runto_arrived");
  self endon(var_1 + "_finished");
  for(;;) {
    self waittill("path_set");
    if(!self.objective_playermask_showtoall) {
      break;
    }
  }

  scripts\asm\asm::asm_fireevent(var_1, "abort");
}

func_CEC9(var_0, var_1) {
  self endon("runto_arrived");
  self endon(var_1 + "_finished");
  for(;;) {
    if(!isDefined(self.vehicle_getspawnerarray)) {
      break;
    }

    wait(0.05);
  }

  scripts\asm\asm::asm_fireevent(var_1, "abort");
}

func_22F3(var_0, var_1, var_2) {
  if(func_C9B5()) {
    var_3 = lib_0F3D::func_7DD6();
    var_4 = self;
    if(lib_0F3D::func_C057(var_3)) {
      var_4 = var_3;
    }

    self orientmode("face angle", var_4.angles[1]);
  }
}

func_22F4(var_0) {
  self endon("death");
  self.asm.var_22F8 = var_0;
  self waittill(var_0 + "_finished");
  self.asm.var_22F8 = undefined;
}

func_CEAA(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  var_4 = 1;
  if(isDefined(var_3)) {
    var_4 = var_3;
  }

  self.var_4C7E = lib_0F3D::func_22EA;
  self.a.var_22E5 = var_1;
  self orientmode("face motion");
  thread func_22F4(var_1);
  var_5 = lib_0A1E::asm_getallanimsforstate(var_0, var_1);
  if(!isDefined(var_5)) {
    scripts\asm\asm::asm_fireevent(var_1, "abort", undefined);
    return;
  }

  var_6 = var_5.log;
  var_7 = var_5.var_3F;
  var_8 = (0, var_6[1] - var_5.var_3E, 0);
  var_9 = var_5.areanynavvolumesloaded;
  var_10 = var_8[1];
  if(isDefined(var_5.updategamerprofile) && isDefined(var_5.unloadtransient)) {
    var_11 = var_5.areanynavvolumesloaded - var_5.updategamerprofile;
    var_11 = rotatevectorinverted(var_11, var_5.unloadtransient);
    var_12 = invertangles(var_5.unloadtransient);
    var_13 = combineangles(var_8, var_12);
    var_14 = self func_846B();
    var_11 = rotatevector(var_11, var_14.angles);
    var_9 = var_11 + var_14.origin;
    var_15 = combineangles(var_13, var_14.angles);
    var_10 = var_15[1];
  }

  var_10 = self.vehicle_getspawnerarray;
  self func_8396(var_9, var_10);
  if(isDefined(self.asm.var_4C86.var_4C38)) {
    var_11 = self.asm.var_4C86.var_4C38;
    self animmode(var_11);
  } else {
    self animmode("zonly_physics", 0);
  }

  lib_0A1E::func_2369(var_0, var_1, var_5.getgrenadedamageradius);
  self clearanim(lib_0A1E::asm_getbodyknob(), var_2);
  var_12 = 1;
  if(isDefined(var_10)) {
    var_13 = length(var_5.stricmp);
    var_14 = length(self.origin - var_10);
    if(var_14 > 1) {
      var_12 = var_13 / length(self.origin - var_10);
    }

    var_12 = clamp(var_12, 0.8, 1.3);
  }

  if(isDefined(self.var_22EE)) {
    self func_82E7(var_1, var_5.getgrenadedamageradius, 1, var_2, self.var_BD22 * self.var_22EE * var_4 * var_12);
  } else {
    self func_82E7(var_1, var_5.getgrenadedamageradius, 1, var_2, self.var_BD22 * var_4 * var_12);
  }

  thread lib_0F3D::func_444B(var_1);
  lib_0A1E::func_231F(var_0, var_1);
  self.a.movement = "stop";
}

func_7E54() {
  if(isDefined(self.asm.var_4C86.var_22E3)) {
    return self.asm.var_4C86.var_22E3;
  }

  return undefined;
}

func_8174(var_0, var_1, var_2, var_3) {
  var_4 = [];
  var_4[5] = ::scripts\asm\asm::func_235C(1, var_0, var_2, var_3);
  var_4[4] = ::scripts\asm\asm::func_235C(2, var_0, var_2, var_3);
  var_4[3] = ::scripts\asm\asm::func_235C(3, var_0, var_2, var_3);
  var_4[6] = ::scripts\asm\asm::func_235C(4, var_0, var_2, var_3);
  var_4[2] = ::scripts\asm\asm::func_235C(6, var_0, var_2, var_3);
  var_4[7] = ::scripts\asm\asm::func_235C(7, var_0, var_2, var_3);
  var_4[0] = ::scripts\asm\asm::func_235C(8, var_0, var_2, var_3);
  var_4[1] = ::scripts\asm\asm::func_235C(9, var_0, var_2, var_3);
  var_4[8] = var_4[0];
  return var_4;
}

getnormalizedmovement(var_0, var_1, var_2, var_3) {
  var_4 = [];
  var_4["cover_left_arrival"]["7"] = 0.369369;
  var_4["cover_left_crouch_arrival"]["7"] = 0.321321;
  var_4["cqb_cover_left_crouch_arrival"]["7"] = 0.2002;
  var_4["cqb_cover_left_arrival"]["7"] = 0.275275;
  var_4["cover_left_arrival"]["8"] = 0.525526;
  var_4["cover_left_crouch_arrival"]["8"] = 0.448448;
  var_4["cqb_cover_left_crouch_arrival"]["8"] = 0.251251;
  var_4["cqb_cover_left_arrival"]["8"] = 0.335335;
  var_4["cover_right_arrival"]["8"] = 0.472472;
  var_4["cover_right_crouch_arrival"]["8"] = 0.248248;
  var_4["cqb_cover_right_arrival"]["8"] = 0.345345;
  var_4["cqb_cover_right_crouch_arrival"]["8"] = 0.428428;
  var_4["cover_right_arrival"]["9"] = 0.551552;
  var_4["cover_right_crouch_arrival"]["9"] = 0.2002;
  var_4["cqb_cover_right_arrival"]["9"] = 0.3003;
  var_4["cqb_cover_right_crouch_arrival"]["9"] = 0.224224;
  return var_4[var_1][var_2];
}

lerpviewangleclamp(var_0, var_1, var_2, var_3) {
  if(!isDefined(level.archetypes[var_0].var_1FAD)) {
    level.archetypes[var_0].var_1FAD = [];
  }

  if(!isDefined(level.archetypes[var_0].var_1FAD[var_1])) {
    level.archetypes[var_0].var_1FAD[var_1] = [];
  }

  if(!isDefined(level.archetypes[var_0].var_1FAD[var_1][var_2])) {
    var_4 = getnormalizedmovement(var_0, var_1, var_2, var_3);
    var_5 = scripts\asm\asm::func_235C(var_2, var_1, var_3);
    level.archetypes[var_0].var_1FAD[var_1][var_2] = getmovedelta(var_5, 0, var_4);
  }

  var_6 = level.archetypes[var_0].var_1FAD[var_1][var_2];
  return var_6;
}

func_FFD4(var_0, var_1, var_2, var_3) {
  if(!func_FFE6()) {
    return 0;
  }

  if(!isDefined(self.vehicle_getspawnerarray)) {
    return 0;
  }

  scripts\asm\asm::asm_updatefrantic();
  var_4 = lib_0F3D::func_7DD6();
  if(isDefined(var_4) && isDefined(var_4.type) && var_4.type == "Cover Prone" || var_4.type == "Conceal Prone") {
    return 0;
  }

  if(isDefined(var_4)) {
    var_5 = undefined;
    if((scripts\engine\utility::isnodecoverleft(var_4) && lib_0F3D::func_9D4C(var_0, var_1, undefined, "Cover Left Crouch")) || scripts\engine\utility::isnodecoverright(var_4) && lib_0F3D::func_9D4C(var_0, var_1, undefined, "Cover Right Crouch")) {
      var_5 = "crouch";
    }

    var_6 = scripts\asm\shared_utility::func_812E(var_4, var_5);
    self func_853D(var_6);
  }

  var_7 = self.var_164D[var_0].var_4BC0;
  if(!scripts\asm\asm::func_232B(var_7, "cover_approach")) {
    return 0;
  }

  return 1;
}

func_FFD5(var_0, var_1, var_2, var_3) {
  if(!scripts\asm\asm::func_232B(var_1, "code_move")) {
    return 0;
  }

  return func_FFD4(var_0, var_1, var_2, var_3);
}

func_1008F(var_0, var_1, var_2, var_3) {
  if(isDefined(var_3)) {
    if(!isarray(var_3)) {
      var_4 = var_3;
    } else if(var_4.size < 1) {
      var_4 = "Exposed";
    } else {
      var_4 = var_4[0];
    }
  } else {
    var_4 = "Exposed";
  }

  if(!lib_0F3D::func_9D4C(var_0, var_1, var_2, var_4)) {
    return 0;
  }

  var_5 = distance(self.origin, self.vehicle_getspawnerarray);
  var_6 = func_7F95(var_4);
  if(var_5 > var_6) {
    return 0;
  }

  var_7 = 0;
  if(isDefined(var_3) && isarray(var_3) && var_3.size >= 2) {
    var_7 = 1;
  }

  var_8 = undefined;
  var_9 = self.var_164D[var_0].var_4BC0;
  var_10 = scripts\asm\asm::func_233F(var_9, "cover_approach");
  if(isDefined(var_10)) {
    var_8 = var_10.params;
  }

  self.asm.var_11068 = func_3721(var_0, var_1, var_2, var_4, var_7, var_8);
  if(!isDefined(self.asm.var_11068)) {
    return 0;
  }

  return 1;
}

func_10090(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_3) || var_3.size < 1) {
    var_4 = "Exposed";
  } else {
    var_4 = var_4[0];
  }

  if(!lib_0F3D::func_9D4C(var_0, var_1, var_2, var_4)) {
    return 0;
  }

  var_5 = distance(self.origin, self.vehicle_getspawnerarray);
  var_6 = func_7F95(var_4);
  if(var_5 > var_6) {
    return 0;
  }

  var_7 = 0;
  if(isDefined(var_3) && var_3.size >= 2) {
    var_7 = 1;
  }

  var_8 = undefined;
  var_9 = scripts\asm\asm::func_233F(var_1, "cover_approach");
  if(isDefined(var_9)) {
    var_8 = var_9.params;
  }

  self.asm.var_11068 = func_3721(var_0, var_1, var_2, var_4, var_7, var_8);
  if(!isDefined(self.asm.var_11068)) {
    return 0;
  }

  return 1;
}