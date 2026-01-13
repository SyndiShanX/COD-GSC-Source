/************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: 3899.gsc
************************/

func_CEB5(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  var_4 = scripts\asm\asm_mp::asm_getanim(var_0, var_1);
  self.asm.var_4C86.var_697F = undefined;
  if(!isDefined(var_4)) {
    scripts\asm\asm::asm_fireevent(var_1, "code_move", undefined);
    return;
  }

  func_D53A(var_0, var_1, var_4, var_2);
  scripts\asm\asm::asm_fireevent(var_1, "code_move", undefined);
}

func_3E9F(var_0, var_1, var_2) {
  if(!func_3E57()) {
    return undefined;
  }

  var_3 = func_53CA(var_1);
  return var_3;
}

_meth_8162(var_0) {
  var_1 = [];
  if(scripts\asm\asm::asm_hasalias(var_0, "1")) {
    var_1[7] = ::scripts\asm\asm::asm_lookupanimfromalias(var_0, "1");
  }

  if(scripts\asm\asm::asm_hasalias(var_0, "2")) {
    var_1[0] = ::scripts\asm\asm::asm_lookupanimfromalias(var_0, "2");
    var_1[8] = var_1[0];
  }

  if(scripts\asm\asm::asm_hasalias(var_0, "3")) {
    var_1[1] = ::scripts\asm\asm::asm_lookupanimfromalias(var_0, "3");
  }

  if(scripts\asm\asm::asm_hasalias(var_0, "4")) {
    var_1[6] = ::scripts\asm\asm::asm_lookupanimfromalias(var_0, "4");
  }

  if(scripts\asm\asm::asm_hasalias(var_0, "6")) {
    var_1[2] = ::scripts\asm\asm::asm_lookupanimfromalias(var_0, "6");
  }

  if(scripts\asm\asm::asm_hasalias(var_0, "7")) {
    var_1[5] = ::scripts\asm\asm::asm_lookupanimfromalias(var_0, "7");
  }

  if(scripts\asm\asm::asm_hasalias(var_0, "8")) {
    var_1[4] = ::scripts\asm\asm::asm_lookupanimfromalias(var_0, "8");
  }

  if(scripts\asm\asm::asm_hasalias(var_0, "9")) {
    var_1[3] = ::scripts\asm\asm::asm_lookupanimfromalias(var_0, "9");
  }

  return var_1;
}

func_53CA(var_0) {
  var_1 = self getspectatepoint();
  if(isDefined(var_1)) {
    var_2 = var_1.origin;
  } else {
    var_2 = self.vehicle_getspawnerarray;
  }

  var_3 = scripts\asm\asm_mp::func_7EA3();
  var_4 = self _meth_813A();
  var_5 = vectortoangles(var_4);
  if(isDefined(var_3)) {
    var_6 = var_3.angles;
  } else {
    var_6 = self.angles;
  }

  var_7 = angleclamp180(var_5[1] - self.angles[1]);
  var_8 = self getvelocity();
  if(length2dsquared(var_8) > 16) {
    var_9 = vectortoangles(var_8);
    if(abs(angleclamp180(var_9[1] - var_5[1])) < 45) {
      return;
    }
  }

  if(distancesquared(var_2, self.origin) < 22500) {
    return;
  }

  if(isDefined(self.asm.var_4C86) && isDefined(self.asm.var_4C86.var_697F)) {
    var_0A = _meth_8162(self.asm.var_4C86.var_697F);
  } else {
    var_0A = _meth_8162(var_1);
  }

  var_0B = getangleindices(var_7);
  var_0C = undefined;
  var_0D = undefined;
  for(var_0E = 0; var_0E < var_0B.size; var_0E++) {
    var_0F = var_0B[var_0E];
    if(!isDefined(var_0A[var_0F])) {
      continue;
    }

    var_0C = self getsafecircleorigin(var_0, var_0A[var_0F]);
    var_10 = getmovedelta(var_0C);
    var_11 = rotatevector(var_10, self.angles) + self.origin;
    if(!navtrace(self.origin, var_11, self)) {
      var_0D = var_0A[var_0F];
      break;
    }
  }

  return var_0D;
}

func_D53A(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  var_4 = vectortoangles(self _meth_813A());
  var_5 = angleclamp180(var_4[1] - self.angles[1]);
  var_6 = self getsafecircleorigin(var_1, var_2);
  var_7 = getnotetracktimes(var_6, "code_move");
  var_8 = 1;
  if(var_7.size > 0) {
    var_8 = var_7[0];
  }

  var_9 = getangledelta3d(var_6, 0, var_8);
  self ghostlaunched("anim deltas");
  var_0A = angleclamp180(var_4[1] - var_9[1]);
  var_0B = (0, var_0A, 0);
  self orientmode("face angle abs", var_0B);
  var_0C = getanimlength(var_6) * var_8;
  var_0D = 0.01 + abs(angleclamp180(var_5 - var_9[1])) / var_0C / 1000;
  if(var_0D < 0.01) {
    var_0D = 0.01;
  }

  self.var_D8C4 = self.var_358;
  self.var_358 = var_0D;
  scripts\asm\asm_mp::func_2365(var_0, var_1, var_3, var_2, self.moveplaybackrate);
  self.var_358 = self.var_D8C4;
  self.var_D8C4 = undefined;
  self ghostlaunched("code_move");
  self orientmode("face motion");
}

func_3E57() {
  if(!isDefined(self.vehicle_getspawnerarray)) {
    return 0;
  }

  if(!self givemidmatchaward()) {
    return 0;
  }

  if(isDefined(self.isnodeoccupied) && scripts\asm\asm_bb::bb_wantstostrafe()) {
    return 0;
  }

  if(isDefined(self.var_55ED) && self.var_55ED) {
    return 0;
  }

  if(distancesquared(self.origin, self.vehicle_getspawnerarray) < 10000) {
    return 0;
  }

  return 1;
}

func_3B1F(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_3[2]) || !scripts\asm\asm_bb::bb_movetyperequested(var_3[2])) {
    return 0;
  }

  return func_FFF8(var_0, var_1, var_2, var_3);
}

func_FFF8(var_0, var_1, var_2, var_3) {
  if(isDefined(self.noturnanims) && self.noturnanims) {
    return 0;
  }

  if(isDefined(self.var_932E) && self.var_932E) {
    return 0;
  }

  var_4 = scripts\asm\asm::asm_getcurrentstatename(var_0);
  var_5 = scripts\asm\asm::func_233F(var_4, "sharp_turn");
  if(!isDefined(var_5)) {
    return 0;
  }

  var_6 = 100;
  var_7 = gettime();
  if(var_7 - var_5.var_7686 > var_6) {
    return 0;
  }

  if(isarray(var_3)) {
    var_8 = var_3[0];
  } else {
    var_8 = var_4;
  }

  var_9 = var_5.params[0];
  var_0A = var_5.params[1];
  var_0B = func_371C(var_4, var_2, var_9, var_0A);
  if(!isDefined(var_0B)) {
    return 0;
  }

  self.var_FC61 = var_0B;
  return 1;
}

func_371C(var_0, var_1, var_2, var_3) {
  var_4 = 10;
  if(var_3) {
    var_4 = 30;
  }

  var_5 = vectortoangles(var_2);
  var_6 = angleclamp180(var_5[1] - self.angles[1]);
  if(var_3) {
    if(abs(var_6) < 30) {
      return undefined;
    }
  }

  var_7 = getangleindices(var_6, var_4);
  if(scripts\engine\utility::istrue(self.var_AB3F)) {
    var_8 = getcurrentweapon(var_1, 0);
  } else {
    var_8 = getcurrentweapon(var_2, 1);
  }

  foreach(var_0A in var_7) {
    if(var_0A == 4) {
      continue;
    }

    if(var_0A < 0 || var_0A > 8) {
      continue;
    }

    var_0B = self getsafecircleorigin(var_1, var_8[var_0A]);
    var_0C = getangledelta(var_0B);
    var_0D = (0, angleclamp180(var_5[1] - var_0C), 0);
    if(func_38B1(var_0B, var_0D, var_0A == 3 || var_0A == 5)) {
      return var_8[var_0A];
    }
  }

  return undefined;
}

func_3EF5(var_0, var_1, var_2, var_3) {
  return self.var_FC61;
}

func_D514(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  var_4 = scripts\asm\asm_mp::asm_getanim(var_0, var_1);
  self.var_FC61 = undefined;
  scripts\asm\asm_mp::func_237E("anim deltas");
  scripts\asm\asm_mp::func_237F("face current");
  scripts\asm\asm_mp::func_2365(var_0, var_1, var_2, var_4, self.moveplaybackrate);
  scripts\asm\asm_mp::func_237E("code_move");
  scripts\asm\asm_mp::func_237F("face motion");
}

func_38B1(var_0, var_1, var_2) {
  if(!isDefined(self.vehicle_getspawnerarray)) {
    return 0;
  }

  if(scripts\asm\asm_bb::bb_wantstostrafe()) {
    return 0;
  }

  var_3 = getnotetracktimes(var_0, "code_move");
  if(var_3.size == 0) {
    var_3[0] = 1;
  }

  var_4 = var_3[0];
  var_5 = getmovedelta(var_0, 0, var_4);
  var_6 = self gettweakablevalue(var_5);
  var_7 = self.vehicle_getspawnerarray;
  var_8 = self getspectatepoint();
  if(isDefined(var_8)) {
    var_7 = var_8.origin;
  }

  if(isDefined(self.var_22F0)) {
    if(squared(self.var_22F0) > distancesquared(var_7, var_6)) {
      return 0;
    }
  } else if(distancesquared(var_7, var_6) < 7056) {
    return 0;
  }

  var_5 = getmovedelta(var_0, 0, 1);
  var_9 = self gettweakablevalue(var_5);
  var_9 = var_6 + vectornormalize(var_9 - var_6) * 20;
  var_0A = navtrace(var_6, var_9, self);
  if(var_0A) {
    return 0;
  }

  if(isDefined(self.var_7198)) {
    return self[[self.var_7198]](var_0, var_1, var_2);
  }

  return 1;
}

getcurrentweaponclipammo(var_0, var_1) {
  var_2 = [];
  var_3 = "";
  if(isDefined(var_1) && var_1 && self.asm.footsteps.foot == "right") {
    var_3 = "right";
  } else {
    var_3 = "left";
  }

  var_2[0] = ::scripts\asm\asm::asm_lookupanimfromalias(var_0, var_3 + "2");
  var_2[1] = ::scripts\asm\asm::asm_lookupanimfromalias(var_0, var_3 + "3");
  var_2[2] = ::scripts\asm\asm::asm_lookupanimfromalias(var_0, var_3 + "6");
  var_2[3] = ::scripts\asm\asm::asm_lookupanimfromalias(var_0, var_3 + "9");
  var_2[5] = ::scripts\asm\asm::asm_lookupanimfromalias(var_0, var_3 + "7");
  var_2[6] = ::scripts\asm\asm::asm_lookupanimfromalias(var_0, var_3 + "4");
  var_2[7] = ::scripts\asm\asm::asm_lookupanimfromalias(var_0, var_3 + "1");
  var_2[8] = ::scripts\asm\asm::asm_lookupanimfromalias(var_0, var_3 + "2");
  return var_2;
}

getcurrentweapon(var_0, var_1) {
  if(isDefined(self.var_7C54)) {
    return [[self.var_7C54]](var_0, var_1);
  }

  return getcurrentweaponclipammo(var_0, var_1);
}

func_4EAB(var_0) {}

func_D4E5(var_0, var_1, var_2, var_3) {
  func_98A2(var_0, var_1, var_2, var_3);
  func_BCFC(var_0, var_1, var_2);
}

func_98A2(var_0, var_1, var_2, var_3) {}

func_BCFC(var_0, var_1, var_2) {
  self endon(var_1 + "_finished");
  var_3 = scripts\asm\asm::asm_lookupanimfromalias(var_1, "f");
  var_4 = scripts\asm\asm::asm_lookupanimfromalias(var_1, "l");
  var_5 = scripts\asm\asm::asm_lookupanimfromalias(var_1, "r");
  var_6 = scripts\asm\asm::asm_lookupanimfromalias(var_1, "b");
  self ghostlaunched("code_move");
  var_7 = -1;
  var_8 = -1;
  for(;;) {
    var_9 = scripts\anim\utility_common::quadrantanimweights(self getspawnpoint_searchandrescue());
    if(var_9["back"] == 1) {
      var_8 = var_6;
    } else if(var_9["left"] == 1) {
      var_8 = var_4;
    } else if(var_9["right"] == 1) {
      var_8 = var_5;
    } else {
      var_8 = var_3;
    }

    if(var_8 != var_7) {
      self setanimstate(var_1, var_8);
    }

    var_7 = var_8;
    wait(0.25);
  }
}