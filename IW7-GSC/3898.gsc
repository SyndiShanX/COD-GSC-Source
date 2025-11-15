/************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: 3898.gsc
************************/

func_FFE6() {
  if(isDefined(self.disablearrivals) && self.disablearrivals) {
    return 0;
  }

  if(isDefined(self.isnodeoccupied) && scripts\asm\asm_bb::bb_wantstostrafe()) {
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

  if(isDefined(self.target_getindexoftarget) && self.target_getindexoftarget.type == "Cover Prone" || self.target_getindexoftarget.type == "Conceal Prone") {
    return 0;
  }

  if(!scripts\asm\asm::func_232B(param_01, "cover_approach")) {
    return 0;
  }

  if(!isDefined(self.var_20EE)) {
    return 0;
  }

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

  if(!func_9D4C(param_00, param_01, param_02, var_04)) {
    return 0;
  }

  var_05 = 0;
  if(isDefined(param_03) && isarray(param_03) && param_03.size >= 2 && param_03[1]) {
    var_05 = 1;
  }

  self.asm.var_7360 = scripts\asm\asm_bb::bb_isfrantic();
  self.asm.var_11068 = func_3721(param_00, param_02, var_04, var_05);
  if(!isDefined(self.asm.var_11068)) {
    return 0;
  }

  return 1;
}

func_FFD4(param_00, param_01, param_02, param_03) {
  if(!func_FFE6()) {
    return 0;
  }

  if(!isDefined(self.vehicle_getspawnerarray)) {
    return 0;
  }

  if(isDefined(self.target_getindexoftarget) && self.target_getindexoftarget.type == "Cover Prone" || self.target_getindexoftarget.type == "Conceal Prone") {
    return 0;
  }

  if(!scripts\asm\asm::func_232B(param_01, "cover_approach")) {
    return 0;
  }

  return 1;
}

func_10093(param_00, param_01, param_02, param_03) {
  return func_1008A(param_00, param_01, param_02, param_03);
}

func_10095(param_00, param_01, param_02, param_03) {
  return func_1008A(param_00, param_01, param_02, param_03);
}

func_10091(param_00, param_01, param_02, param_03) {
  if(scripts\asm\asm_bb::bb_isincombat()) {
    return 0;
  }

  return func_1008A(param_00, param_01, param_02, param_03);
}

func_9D4C(param_00, param_01, param_02, param_03) {
  var_04 = param_03;
  if(isDefined(self.asm.var_4C86.var_22F1)) {
    return var_04 == "Custom";
  }

  if(!isDefined(self.target_getindexoftarget)) {
    return var_04 == "Exposed";
  }

  switch (var_04) {
    case "Exposed":
      return (self.target_getindexoftarget.type == "Path" || self.target_getindexoftarget.type == "Exposed") && self.target_getindexoftarget getrandomattachments("stand");

    case "Exposed Crouch":
      if(scripts\asm\asm_bb::func_292C() != "crouch") {
        return 0;
      }
      return (self.target_getindexoftarget.type == "Path" || self.target_getindexoftarget.type == "Exposed") && self.target_getindexoftarget getrandomattachments("crouch");

    case "Cover Crouch":
      return self.target_getindexoftarget.type == "Cover Crouch" || self.target_getindexoftarget.type == "Conceal Crouch";

    case "Cover Stand":
      return self.target_getindexoftarget.type == "Cover Stand" || self.target_getindexoftarget.type == "Conceal Stand";

    case "Cover Prone":
      return self.target_getindexoftarget.type == "Cover Prone" || self.target_getindexoftarget.type == "Conceal Prone";

    case "Cover Left":
      return self.target_getindexoftarget.type == "Cover Left" && self.target_getindexoftarget getrandomattachments("stand");

    case "Cover Left Crouch":
      return self.target_getindexoftarget.type == "Cover Left" && self.target_getindexoftarget getrandomattachments("crouch");

    case "Cover Right":
      return self.target_getindexoftarget.type == "Cover Right" && self.target_getindexoftarget getrandomattachments("stand");

    case "Cover Right Crouch":
      return self.target_getindexoftarget.type == "Cover Right" && self.target_getindexoftarget getrandomattachments("crouch");
  }

  return var_04 == self.target_getindexoftarget.type;
}

func_3E97(param_00, param_01, param_02) {
  return self.asm.var_11068;
}

func_3721(param_00, param_01, param_02, param_03) {
  var_04 = func_7DD6();
  if(isDefined(var_04)) {
    var_05 = var_04.origin;
  } else {
    var_05 = self.vehicle_getspawnerarray;
  }

  var_06 = func_7E54();
  var_07 = self.var_20EE;
  var_08 = vectortoangles(var_07);
  if(isDefined(var_06)) {
    var_09 = angleclamp180(var_06[1] - var_08[1]);
  } else if(isDefined(var_05) && var_05.type != "Path") {
    var_09 = angleclamp180(var_05.angles[1] - var_09[1]);
  } else {
    var_0A = var_06 - self.origin;
    var_0B = vectortoangles(var_0A);
    var_09 = angleclamp180(var_0B[1] - var_08[1]);
  }

  var_0C = getangleindex(var_09, 22.5);
  var_0D = param_01;
  if(param_02 == "Custom") {
    var_0E = _meth_8174(self.asm.var_4C86.var_22F1, undefined, self.asm.var_4C86.var_22F6);
    var_0D = self.asm.var_4C86.var_22F1;
  } else {
    var_0E = _meth_8174(param_02, undefined, var_04);
  }

  var_0F = getweaponslistprimaries();
  var_10 = var_05 - self.origin;
  var_11 = lengthsquared(var_10);
  var_12 = var_0E[var_0C];
  if(!isDefined(var_12)) {
    return undefined;
  }

  var_13 = self getsafecircleorigin(var_0D, var_12);
  var_14 = getmovedelta(var_13);
  var_15 = getangledelta(var_13);
  var_16 = length(self getvelocity());
  var_17 = var_16 * 0.053;
  var_18 = length(var_10);
  var_19 = length(var_14);
  if(abs(var_18 - var_19) > var_17) {
    return undefined;
  }

  if(var_11 < lengthsquared(var_14)) {
    return undefined;
  }

  var_1A = func_36D9(var_0F.pos, var_0F.log[1], var_14, var_15);
  var_1B = getclosestpointonnavmesh(var_0F.pos, self);
  var_1C = func_36D9(var_1B, var_0F.log[1], var_14, var_15);
  var_1D = self _meth_84AC();
  var_1E = param_02 == "Cover Left" || param_02 == "Cover Right" || param_02 == "Cover Left Crouch" || param_02 == "Cover Right Crouch";
  if(var_1E && var_0C == 0 || var_0C == 8 || var_0C == 7 || var_0C == 1) {
    var_1F = undefined;
    var_20 = undefined;
    var_21 = getnotetracktimes(var_13, "corner");
    if(var_21.size > 0) {
      var_1F = getmovedelta(var_13, 0, var_21[0]);
      var_20 = var_21[0];
    } else {
      var_22 = undefined;
      var_23 = undefined;
      if(param_02 == "Cover Left" || param_02 == "Cover Left Crouch") {
        var_22 = "left";
        if(var_0C == 7) {
          var_23 = "7";
        } else if(var_0C == 0 || var_0C == 8) {
          var_23 = "8";
        }
      } else if(param_02 == "Cover Right" || param_02 == "Cover Right Crouch") {
        var_22 = "right";
        if(var_0C == 0 || var_0C == 8) {
          var_23 = "8";
        } else if(var_0C == 1) {
          var_23 = "9";
        }
      }

      if(isDefined(var_22) && isDefined(var_23)) {
        var_1F = lerpviewangleclamp(param_00, param_01, var_23, param_03);
        var_20 = getnormalizedmovement(param_00, param_01, var_23, param_03);
      }
    }

    if(isDefined(var_1F)) {
      var_1F = rotatevector(var_1F, (0, var_0F.log[1] - var_15, 0));
      var_1F = var_1C + var_1F;
      var_24 = navtrace(var_1D, var_1F, self, 1);
      if(var_24["fraction"] >= 0.9 || navisstraightlinereachable(var_1D, var_1F, self)) {
        var_25 = spawnStruct();
        var_25.var_11060 = var_12;
        var_25.var_3F = var_0C;
        var_25.areanynavvolumesloaded = var_1A;
        var_25.var_3E = var_15;
        var_25.angles = var_0F.angles;
        var_25.log = var_0F.log;
        var_25.stricmp = var_14;
        var_25.var_357 = var_1F;
        var_25._func_2BD = var_20;
        return var_25;
      }
    }
  } else {
    var_24 = navtrace(var_1E, var_1C, self, 1);
    var_26 = var_24["fraction"] >= 0.9 || navisstraightlinereachable(var_1E, var_1C, self);
    if(!var_26) {
      var_27 = self pathdisttogoal();
      var_26 = var_27 < distance(var_1E, var_1C) + 8;
    }

    if(var_26) {
      var_25 = spawnStruct();
      var_25.var_11060 = var_13;
      var_25.var_3F = var_0D;
      var_25.areanynavvolumesloaded = var_1B;
      var_25.var_3E = var_16;
      var_25.angles = var_10.angles;
      var_25.log = var_10.log;
      var_25.var_11069 = var_15;
      var_25.var_22ED = var_06;
      return var_25;
    }
  }

  return undefined;
}

func_CECA(param_00, param_01) {
  self endon("runto_arrived");
  self endon(param_01 + "_finished");
  var_02 = self.objective_playermask_hidefromall;
  for(;;) {
    self waittill("path_set");
    var_03 = self.objective_playermask_hidefromall;
    if(!self.objective_playermask_showtoall) {
      break;
    }

    if(distancesquared(var_02, var_03) > 1) {
      break;
    }

    var_02 = var_03;
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

func_136F5(param_00) {
  self endon(param_00 + "_finished");
  self endon("waypoint_reached");
  self endon("waypoint_aborted");
  wait(2);
}

func_CEAA(param_00, param_01, param_02, param_03) {
  self endon(param_01 + "_finished");
  var_04 = func_7DD6();
  var_05 = scripts\asm\asm_mp::asm_getanim(param_00, param_01);
  if(!isDefined(var_05)) {
    scripts\asm\asm::asm_fireevent(param_01, "abort", undefined);
    return;
  }

  var_06 = scripts\asm\asm::asm_getmoveplaybackrate();
  if(!isDefined(var_06)) {
    var_06 = 1;
  }

  var_07 = var_05.log;
  var_08 = var_05.var_3F;
  var_09 = (0, var_07[1] - var_05.var_3E, 0);
  var_0A = self getsafecircleorigin(param_01, var_05.var_11060);
  var_0B = getanimlength(var_0A);
  var_0B = var_0B * 1 / var_06;
  self _meth_8396(var_05.areanynavvolumesloaded, var_09[1], var_0B);
  scripts\asm\asm_mp::func_2365(param_00, param_01, param_02, var_05.var_11060, var_06);
}

func_22EA() {
  self endon("killanimscript");
  self waittill(self.var_22E5 + "_finished");
}

func_7DD6() {
  if(isDefined(self.physics_querypoint)) {
    return self.physics_querypoint;
  }

  if(isDefined(self.target_getindexoftarget)) {
    return self.target_getindexoftarget;
  }

  if(isDefined(self.weaponmaxdist) && isDefined(self.vehicle_getspawnerarray) && distance2dsquared(self.weaponmaxdist.origin, self.vehicle_getspawnerarray) < 36) {
    return self.weaponmaxdist;
  }

  return undefined;
}

func_7E54() {
  if(isDefined(self.asm.var_4C86.var_22E3)) {
    return self.asm.var_4C86.var_22E3;
  }

  return undefined;
}

getweaponslistprimaries() {
  var_00 = spawnStruct();
  var_01 = func_7DD6();
  if(isDefined(var_01) && var_01.type != "Path") {
    var_00.pos = var_01.origin;
    var_00.angles = var_01.angles;
    var_00.log = (0, scripts\asm\shared_utility::getnodeforwardyaw(var_01), 0);
  } else {
    var_00.pos = self.vehicle_getspawnerarray;
    var_02 = self getvelocity();
    var_03 = self _meth_813A();
    if(lengthsquared(var_02) > 1) {
      var_00.angles = vectortoangles(var_00.pos - self.origin);
    } else {
      var_00.angles = vectortoangles(var_03);
    }

    var_00.log = var_00.angles;
  }

  var_04 = func_7E54();
  if(isDefined(var_04)) {
    var_00.angles = var_04;
    var_00.log = var_00.angles;
  }

  return var_00;
}

func_36D9(param_00, param_01, param_02, param_03) {
  var_04 = param_01 - param_03;
  var_05 = (0, var_04, 0);
  var_06 = rotatevector(param_02, var_05);
  return param_00 - var_06;
}

_meth_8174(param_00, param_01, param_02) {
  var_03 = [];
  var_03[5] = scripts\asm\asm::func_235C(1, param_00, param_02);
  var_03[4] = scripts\asm\asm::func_235C(2, param_00, param_02);
  var_03[3] = scripts\asm\asm::func_235C(3, param_00, param_02);
  var_03[6] = scripts\asm\asm::func_235C(4, param_00, param_02);
  var_03[2] = scripts\asm\asm::func_235C(6, param_00, param_02);
  var_03[7] = scripts\asm\asm::func_235C(7, param_00, param_02);
  var_03[0] = scripts\asm\asm::func_235C(8, param_00, param_02);
  var_03[1] = scripts\asm\asm::func_235C(9, param_00, param_02);
  var_03[8] = var_03[0];
  return var_03;
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
  return undefined;
}

func_1008F(param_00, param_01, param_02, param_03) {
  if(!isDefined(self.var_20EE)) {
    return 0;
  }

  var_04 = undefined;
  if(isDefined(param_03)) {
    if(!isarray(param_03)) {
      var_04 = param_03;
    } else if(param_03.size < 1) {
      var_04 = "Exposed";
    } else {
      var_04 = param_03[0];
    }
  } else {
    var_04 = "Exposed";
  }

  if(!func_9D4C(param_00, param_01, param_02, var_04)) {
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

  self.asm.var_7360 = scripts\asm\asm_bb::bb_isfrantic();
  self.asm.var_11068 = func_3721(param_00, param_02, var_04, var_07);
  if(!isDefined(self.asm.var_11068)) {
    return 0;
  }

  return 1;
}