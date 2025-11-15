/************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: 3899.gsc
************************/

func_CEB5(param_00, param_01, param_02, param_03) {
  self endon(param_01 + "_finished");
  var_04 = scripts\asm\asm_mp::asm_getanim(param_00, param_01);
  self.asm.var_4C86.var_697F = undefined;
  if(!isDefined(var_04)) {
    scripts\asm\asm::asm_fireevent(param_01, "code_move", undefined);
    return;
  }

  func_D53A(param_00, param_01, var_04, param_02);
  scripts\asm\asm::asm_fireevent(param_01, "code_move", undefined);
}

func_3E9F(param_00, param_01, param_02) {
  if(!func_3E57()) {
    return undefined;
  }

  var_03 = func_53CA(param_01);
  return var_03;
}

_meth_8162(param_00) {
  var_01 = [];
  if(scripts\asm\asm::asm_hasalias(param_00, "1")) {
    var_01[7] = scripts\asm\asm::asm_lookupanimfromalias(param_00, "1");
  }

  if(scripts\asm\asm::asm_hasalias(param_00, "2")) {
    var_01[0] = scripts\asm\asm::asm_lookupanimfromalias(param_00, "2");
    var_01[8] = var_01[0];
  }

  if(scripts\asm\asm::asm_hasalias(param_00, "3")) {
    var_01[1] = scripts\asm\asm::asm_lookupanimfromalias(param_00, "3");
  }

  if(scripts\asm\asm::asm_hasalias(param_00, "4")) {
    var_01[6] = scripts\asm\asm::asm_lookupanimfromalias(param_00, "4");
  }

  if(scripts\asm\asm::asm_hasalias(param_00, "6")) {
    var_01[2] = scripts\asm\asm::asm_lookupanimfromalias(param_00, "6");
  }

  if(scripts\asm\asm::asm_hasalias(param_00, "7")) {
    var_01[5] = scripts\asm\asm::asm_lookupanimfromalias(param_00, "7");
  }

  if(scripts\asm\asm::asm_hasalias(param_00, "8")) {
    var_01[4] = scripts\asm\asm::asm_lookupanimfromalias(param_00, "8");
  }

  if(scripts\asm\asm::asm_hasalias(param_00, "9")) {
    var_01[3] = scripts\asm\asm::asm_lookupanimfromalias(param_00, "9");
  }

  return var_01;
}

func_53CA(param_00) {
  var_01 = self getspectatepoint();
  if(isDefined(var_01)) {
    var_02 = var_01.origin;
  } else {
    var_02 = self.vehicle_getspawnerarray;
  }

  var_03 = scripts\asm\asm_mp::func_7EA3();
  var_04 = self _meth_813A();
  var_05 = vectortoangles(var_04);
  if(isDefined(var_03)) {
    var_06 = var_03.angles;
  } else {
    var_06 = self.angles;
  }

  var_07 = angleclamp180(var_05[1] - self.angles[1]);
  var_08 = self getvelocity();
  if(length2dsquared(var_08) > 16) {
    var_09 = vectortoangles(var_08);
    if(abs(angleclamp180(var_09[1] - var_05[1])) < 45) {
      return;
    }
  }

  if(distancesquared(var_02, self.origin) < 22500) {
    return;
  }

  if(isDefined(self.asm.var_4C86) && isDefined(self.asm.var_4C86.var_697F)) {
    var_0A = _meth_8162(self.asm.var_4C86.var_697F);
  } else {
    var_0A = _meth_8162(var_01);
  }

  var_0B = getangleindices(var_07);
  var_0C = undefined;
  var_0D = undefined;
  for(var_0E = 0; var_0E < var_0B.size; var_0E++) {
    var_0F = var_0B[var_0E];
    if(!isDefined(var_0A[var_0F])) {
      continue;
    }

    var_0C = self getsafecircleorigin(param_00, var_0A[var_0F]);
    var_10 = getmovedelta(var_0C);
    var_11 = rotatevector(var_10, self.angles) + self.origin;
    if(!navtrace(self.origin, var_11, self)) {
      var_0D = var_0A[var_0F];
      break;
    }
  }

  return var_0D;
}

func_D53A(param_00, param_01, param_02, param_03) {
  self endon(param_01 + "_finished");
  var_04 = vectortoangles(self _meth_813A());
  var_05 = angleclamp180(var_04[1] - self.angles[1]);
  var_06 = self getsafecircleorigin(param_01, param_02);
  var_07 = getnotetracktimes(var_06, "code_move");
  var_08 = 1;
  if(var_07.size > 0) {
    var_08 = var_07[0];
  }

  var_09 = getangledelta3d(var_06, 0, var_08);
  self ghostlaunched("anim deltas");
  var_0A = angleclamp180(var_04[1] - var_09[1]);
  var_0B = (0, var_0A, 0);
  self orientmode("face angle abs", var_0B);
  var_0C = getanimlength(var_06) * var_08;
  var_0D = 0.01 + abs(angleclamp180(var_05 - var_09[1])) / var_0C / 1000;
  if(var_0D < 0.01) {
    var_0D = 0.01;
  }

  self.var_D8C4 = self.var_358;
  self.var_358 = var_0D;
  scripts\asm\asm_mp::func_2365(param_00, param_01, param_03, param_02, self.moveplaybackrate);
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

func_3B1F(param_00, param_01, param_02, param_03) {
  if(!isDefined(param_03[2]) || !scripts\asm\asm_bb::bb_movetyperequested(param_03[2])) {
    return 0;
  }

  return func_FFF8(param_00, param_01, param_02, param_03);
}

func_FFF8(param_00, param_01, param_02, param_03) {
  if(isDefined(self.noturnanims) && self.noturnanims) {
    return 0;
  }

  if(isDefined(self.var_932E) && self.var_932E) {
    return 0;
  }

  var_04 = scripts\asm\asm::asm_getcurrentstatename(param_00);
  var_05 = scripts\asm\asm::func_233F(var_04, "sharp_turn");
  if(!isDefined(var_05)) {
    return 0;
  }

  var_06 = 100;
  var_07 = gettime();
  if(var_07 - var_05.var_7686 > var_06) {
    return 0;
  }

  if(isarray(param_03)) {
    var_08 = param_03[0];
  } else {
    var_08 = var_04;
  }

  var_09 = var_05.params[0];
  var_0A = var_05.params[1];
  var_0B = func_371C(var_04, param_02, var_09, var_0A);
  if(!isDefined(var_0B)) {
    return 0;
  }

  self.var_FC61 = var_0B;
  return 1;
}

func_371C(param_00, param_01, param_02, param_03) {
  var_04 = 10;
  if(param_03) {
    var_04 = 30;
  }

  var_05 = vectortoangles(param_02);
  var_06 = angleclamp180(var_05[1] - self.angles[1]);
  if(param_03) {
    if(abs(var_06) < 30) {
      return undefined;
    }
  }

  var_07 = getangleindices(var_06, var_04);
  if(scripts\engine\utility::istrue(self.var_AB3F)) {
    var_08 = getcurrentweapon(param_01, 0);
  } else {
    var_08 = getcurrentweapon(param_02, 1);
  }

  foreach(var_0A in var_07) {
    if(var_0A == 4) {
      continue;
    }

    if(var_0A < 0 || var_0A > 8) {
      continue;
    }

    var_0B = self getsafecircleorigin(param_01, var_08[var_0A]);
    var_0C = getangledelta(var_0B);
    var_0D = (0, angleclamp180(var_05[1] - var_0C), 0);
    if(func_38B1(var_0B, var_0D, var_0A == 3 || var_0A == 5)) {
      return var_08[var_0A];
    }
  }

  return undefined;
}

func_3EF5(param_00, param_01, param_02, param_03) {
  return self.var_FC61;
}

func_D514(param_00, param_01, param_02, param_03) {
  self endon(param_01 + "_finished");
  var_04 = scripts\asm\asm_mp::asm_getanim(param_00, param_01);
  self.var_FC61 = undefined;
  scripts\asm\asm_mp::func_237E("anim deltas");
  scripts\asm\asm_mp::func_237F("face current");
  scripts\asm\asm_mp::func_2365(param_00, param_01, param_02, var_04, self.moveplaybackrate);
  scripts\asm\asm_mp::func_237E("code_move");
  scripts\asm\asm_mp::func_237F("face motion");
}

func_38B1(param_00, param_01, param_02) {
  if(!isDefined(self.vehicle_getspawnerarray)) {
    return 0;
  }

  if(scripts\asm\asm_bb::bb_wantstostrafe()) {
    return 0;
  }

  var_03 = getnotetracktimes(param_00, "code_move");
  if(var_03.size == 0) {
    var_03[0] = 1;
  }

  var_04 = var_03[0];
  var_05 = getmovedelta(param_00, 0, var_04);
  var_06 = self gettweakablevalue(var_05);
  var_07 = self.vehicle_getspawnerarray;
  var_08 = self getspectatepoint();
  if(isDefined(var_08)) {
    var_07 = var_08.origin;
  }

  if(isDefined(self.var_22F0)) {
    if(squared(self.var_22F0) > distancesquared(var_07, var_06)) {
      return 0;
    }
  } else if(distancesquared(var_07, var_06) < 7056) {
    return 0;
  }

  var_05 = getmovedelta(param_00, 0, 1);
  var_09 = self gettweakablevalue(var_05);
  var_09 = var_06 + vectornormalize(var_09 - var_06) * 20;
  var_0A = navtrace(var_06, var_09, self);
  if(var_0A) {
    return 0;
  }

  if(isDefined(self.var_7198)) {
    return self[[self.var_7198]](param_00, param_01, param_02);
  }

  return 1;
}

getcurrentweaponclipammo(param_00, param_01) {
  var_02 = [];
  var_03 = "";
  if(isDefined(param_01) && param_01 && self.asm.footsteps.foot == "right") {
    var_03 = "right";
  } else {
    var_03 = "left";
  }

  var_02[0] = scripts\asm\asm::asm_lookupanimfromalias(param_00, var_03 + "2");
  var_02[1] = scripts\asm\asm::asm_lookupanimfromalias(param_00, var_03 + "3");
  var_02[2] = scripts\asm\asm::asm_lookupanimfromalias(param_00, var_03 + "6");
  var_02[3] = scripts\asm\asm::asm_lookupanimfromalias(param_00, var_03 + "9");
  var_02[5] = scripts\asm\asm::asm_lookupanimfromalias(param_00, var_03 + "7");
  var_02[6] = scripts\asm\asm::asm_lookupanimfromalias(param_00, var_03 + "4");
  var_02[7] = scripts\asm\asm::asm_lookupanimfromalias(param_00, var_03 + "1");
  var_02[8] = scripts\asm\asm::asm_lookupanimfromalias(param_00, var_03 + "2");
  return var_02;
}

getcurrentweapon(param_00, param_01) {
  if(isDefined(self.var_7C54)) {
    return [[self.var_7C54]](param_00, param_01);
  }

  return getcurrentweaponclipammo(param_00, param_01);
}

func_4EAB(param_00) {}

func_D4E5(param_00, param_01, param_02, param_03) {
  func_98A2(param_00, param_01, param_02, param_03);
  func_BCFC(param_00, param_01, param_02);
}

func_98A2(param_00, param_01, param_02, param_03) {}

func_BCFC(param_00, param_01, param_02) {
  self endon(param_01 + "_finished");
  var_03 = scripts\asm\asm::asm_lookupanimfromalias(param_01, "f");
  var_04 = scripts\asm\asm::asm_lookupanimfromalias(param_01, "l");
  var_05 = scripts\asm\asm::asm_lookupanimfromalias(param_01, "r");
  var_06 = scripts\asm\asm::asm_lookupanimfromalias(param_01, "b");
  self ghostlaunched("code_move");
  var_07 = -1;
  var_08 = -1;
  for(;;) {
    var_09 = scripts\anim\utility_common::quadrantanimweights(self getspawnpoint_searchandrescue());
    if(var_09["back"] == 1) {
      var_08 = var_06;
    } else if(var_09["left"] == 1) {
      var_08 = var_04;
    } else if(var_09["right"] == 1) {
      var_08 = var_05;
    } else {
      var_08 = var_03;
    }

    if(var_08 != var_07) {
      self setanimstate(param_01, var_08);
    }

    var_07 = var_08;
    wait(0.25);
  }
}