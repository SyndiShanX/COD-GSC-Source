/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: 3898.gsc
*********************************************/

func_FFE6() {
  if(isDefined(self.disablearrivals) && self.disablearrivals) {
    return 0;
  }

  if(isDefined(self.isnodeoccupied) && scripts\asm\asm_bb::bb_wantstostrafe()) {
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

  if(isDefined(self.target_getindexoftarget) && self.target_getindexoftarget.type == "Cover Prone" || self.target_getindexoftarget.type == "Conceal Prone") {
    return 0;
  }

  if(!scripts\asm\asm::func_232B(var_1, "cover_approach")) {
    return 0;
  }

  if(!isDefined(self.var_20EE)) {
    return 0;
  }

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

  if(!func_9D4C(var_0, var_1, var_2, var_4)) {
    return 0;
  }

  var_5 = 0;
  if(isDefined(var_3) && isarray(var_3) && var_3.size >= 2 && var_3[1]) {
    var_5 = 1;
  }

  self.asm.var_7360 = scripts\asm\asm_bb::bb_isfrantic();
  self.asm.var_11068 = func_3721(var_0, var_2, var_4, var_5);
  if(!isDefined(self.asm.var_11068)) {
    return 0;
  }

  return 1;
}

func_FFD4(var_0, var_1, var_2, var_3) {
  if(!func_FFE6()) {
    return 0;
  }

  if(!isDefined(self.vehicle_getspawnerarray)) {
    return 0;
  }

  if(isDefined(self.target_getindexoftarget) && self.target_getindexoftarget.type == "Cover Prone" || self.target_getindexoftarget.type == "Conceal Prone") {
    return 0;
  }

  if(!scripts\asm\asm::func_232B(var_1, "cover_approach")) {
    return 0;
  }

  return 1;
}

func_10093(var_0, var_1, var_2, var_3) {
  return func_1008A(var_0, var_1, var_2, var_3);
}

func_10095(var_0, var_1, var_2, var_3) {
  return func_1008A(var_0, var_1, var_2, var_3);
}

func_10091(var_0, var_1, var_2, var_3) {
  if(scripts\asm\asm_bb::bb_isincombat()) {
    return 0;
  }

  return func_1008A(var_0, var_1, var_2, var_3);
}

func_9D4C(var_0, var_1, var_2, var_3) {
  var_4 = var_3;
  if(isDefined(self.asm.var_4C86.var_22F1)) {
    return var_4 == "Custom";
  }

  if(!isDefined(self.target_getindexoftarget)) {
    return var_4 == "Exposed";
  }

  switch (var_4) {
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

  return var_4 == self.target_getindexoftarget.type;
}

func_3E97(var_0, var_1, var_2) {
  return self.asm.var_11068;
}

func_3721(var_0, var_1, var_2, var_3) {
  var_4 = func_7DD6();
  if(isDefined(var_4)) {
    var_5 = var_4.origin;
  } else {
    var_5 = self.vehicle_getspawnerarray;
  }

  var_6 = func_7E54();
  var_7 = self.var_20EE;
  var_8 = vectortoangles(var_7);
  if(isDefined(var_6)) {
    var_9 = angleclamp180(var_6[1] - var_8[1]);
  } else if(isDefined(var_5) && var_5.type != "Path") {
    var_9 = angleclamp180(var_5.angles[1] - var_9[1]);
  } else {
    var_0A = var_6 - self.origin;
    var_0B = vectortoangles(var_0A);
    var_9 = angleclamp180(var_0B[1] - var_8[1]);
  }

  var_0C = getangleindex(var_9, 22.5);
  var_0D = var_1;
  if(var_2 == "Custom") {
    var_0E = _meth_8174(self.asm.var_4C86.var_22F1, undefined, self.asm.var_4C86.var_22F6);
    var_0D = self.asm.var_4C86.var_22F1;
  } else {
    var_0E = _meth_8174(var_2, undefined, var_4);
  }

  var_0F = getweaponslistprimaries();
  var_10 = var_5 - self.origin;
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
  var_1E = var_2 == "Cover Left" || var_2 == "Cover Right" || var_2 == "Cover Left Crouch" || var_2 == "Cover Right Crouch";
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
      if(var_2 == "Cover Left" || var_2 == "Cover Left Crouch") {
        var_22 = "left";
        if(var_0C == 7) {
          var_23 = "7";
        } else if(var_0C == 0 || var_0C == 8) {
          var_23 = "8";
        }
      } else if(var_2 == "Cover Right" || var_2 == "Cover Right Crouch") {
        var_22 = "right";
        if(var_0C == 0 || var_0C == 8) {
          var_23 = "8";
        } else if(var_0C == 1) {
          var_23 = "9";
        }
      }

      if(isDefined(var_22) && isDefined(var_23)) {
        var_1F = lerpviewangleclamp(var_0, var_1, var_23, var_3);
        var_20 = getnormalizedmovement(var_0, var_1, var_23, var_3);
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
      var_25.var_22ED = var_6;
      return var_25;
    }
  }

  return undefined;
}

func_CECA(var_0, var_1) {
  self endon("runto_arrived");
  self endon(var_1 + "_finished");
  var_2 = self.objective_playermask_hidefromall;
  for(;;) {
    self waittill("path_set");
    var_3 = self.objective_playermask_hidefromall;
    if(!self.objective_playermask_showtoall) {
      break;
    }

    if(distancesquared(var_2, var_3) > 1) {
      break;
    }

    var_2 = var_3;
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

func_136F5(var_0) {
  self endon(var_0 + "_finished");
  self endon("waypoint_reached");
  self endon("waypoint_aborted");
  wait(2);
}

func_CEAA(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  var_4 = func_7DD6();
  var_5 = scripts\asm\asm_mp::asm_getanim(var_0, var_1);
  if(!isDefined(var_5)) {
    scripts\asm\asm::asm_fireevent(var_1, "abort", undefined);
    return;
  }

  var_6 = scripts\asm\asm::asm_getmoveplaybackrate();
  if(!isDefined(var_6)) {
    var_6 = 1;
  }

  var_7 = var_5.log;
  var_8 = var_5.var_3F;
  var_9 = (0, var_7[1] - var_5.var_3E, 0);
  var_0A = self getsafecircleorigin(var_1, var_5.var_11060);
  var_0B = getanimlength(var_0A);
  var_0B = var_0B * 1 / var_6;
  self _meth_8396(var_5.areanynavvolumesloaded, var_9[1], var_0B);
  scripts\asm\asm_mp::func_2365(var_0, var_1, var_2, var_5.var_11060, var_6);
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
  var_0 = spawnStruct();
  var_1 = func_7DD6();
  if(isDefined(var_1) && var_1.type != "Path") {
    var_0.pos = var_1.origin;
    var_0.angles = var_1.angles;
    var_0.log = (0, scripts\asm\shared_utility::getnodeforwardyaw(var_1), 0);
  } else {
    var_0.pos = self.vehicle_getspawnerarray;
    var_2 = self getvelocity();
    var_3 = self _meth_813A();
    if(lengthsquared(var_2) > 1) {
      var_0.angles = vectortoangles(var_0.pos - self.origin);
    } else {
      var_0.angles = vectortoangles(var_3);
    }

    var_0.log = var_0.angles;
  }

  var_4 = func_7E54();
  if(isDefined(var_4)) {
    var_0.angles = var_4;
    var_0.log = var_0.angles;
  }

  return var_0;
}

func_36D9(var_0, var_1, var_2, var_3) {
  var_4 = var_1 - var_3;
  var_5 = (0, var_4, 0);
  var_6 = rotatevector(var_2, var_5);
  return var_0 - var_6;
}

_meth_8174(var_0, var_1, var_2) {
  var_3 = [];
  var_3[5] = ::scripts\asm\asm::func_235C(1, var_0, var_2);
  var_3[4] = ::scripts\asm\asm::func_235C(2, var_0, var_2);
  var_3[3] = ::scripts\asm\asm::func_235C(3, var_0, var_2);
  var_3[6] = ::scripts\asm\asm::func_235C(4, var_0, var_2);
  var_3[2] = ::scripts\asm\asm::func_235C(6, var_0, var_2);
  var_3[7] = ::scripts\asm\asm::func_235C(7, var_0, var_2);
  var_3[0] = ::scripts\asm\asm::func_235C(8, var_0, var_2);
  var_3[1] = ::scripts\asm\asm::func_235C(9, var_0, var_2);
  var_3[8] = var_3[0];
  return var_3;
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
  return undefined;
}

func_1008F(var_0, var_1, var_2, var_3) {
  if(!isDefined(self.var_20EE)) {
    return 0;
  }

  var_4 = undefined;
  if(isDefined(var_3)) {
    if(!isarray(var_3)) {
      var_4 = var_3;
    } else if(var_3.size < 1) {
      var_4 = "Exposed";
    } else {
      var_4 = var_3[0];
    }
  } else {
    var_4 = "Exposed";
  }

  if(!func_9D4C(var_0, var_1, var_2, var_4)) {
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

  self.asm.var_7360 = scripts\asm\asm_bb::bb_isfrantic();
  self.asm.var_11068 = func_3721(var_0, var_2, var_4, var_7);
  if(!isDefined(self.asm.var_11068)) {
    return 0;
  }

  return 1;
}