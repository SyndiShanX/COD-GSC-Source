/************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: 3900.gsc
************************/

func_5AC0() {
  self endon("killanimscript");
  var_00 = self getspectatepoint();
  var_01 = var_00.var_48;
  self notify("traverse_begin", var_01, var_00);
  self waittill("traverse_end");
}

func_3E96(param_00, param_01, param_02) {
  if(!isDefined(param_02)) {
    return func_3EF4(param_00, param_01, param_02);
  }

  return scripts\asm\asm::asm_lookupanimfromalias(param_01, param_02);
}

func_3EB8(param_00, param_01, param_02) {
  return 0;
}

func_3EF4(param_00, param_01, param_02) {
  var_03 = self getanimentrycount(param_01);
  if(var_03 == 1) {
    return 0;
  }

  return randomint(var_03);
}

func_3EB6(param_00, param_01, param_02) {
  return func_3E96(param_00, param_01, param_02);
}

func_CEA8(param_00, param_01, param_02, param_03) {
  scripts\asm\asm_mp::func_2364(param_00, param_01, param_02, param_03);
}

func_B050(param_00, param_01, param_02, param_03) {
  scripts\asm\asm_mp::func_235F(param_00, param_01, param_02, 1);
}

func_136B4(param_00, param_01, param_02) {
  self endon(param_01 + "_finished");
  self _meth_84BD();
  self waittill("stop_soon");
  self.var_20EE = self _meth_813A();
  scripts\asm\asm::asm_fireevent(param_01, "cover_approach", self.var_20EE);
}

func_136CC(param_00, param_01, param_02) {
  self endon(param_01 + "_finished");
  self waittill("path_set");
  var_03 = self _meth_813A();
  var_04 = [var_03, 1];
  scripts\asm\asm::asm_fireevent(param_01, "sharp_turn", var_04);
  thread func_136CC(param_00, param_01, param_02);
}

func_136E7(param_00, param_01, param_02) {
  self endon(param_01 + "_finished");
  self waittill("path_dir_change", var_03);
  var_04 = [var_03, 1];
  scripts\asm\asm::asm_fireevent(param_01, "sharp_turn", var_04);
  thread func_136E7(param_00, param_01, param_02);
}

func_D4DD(param_00, param_01, param_02, param_03) {
  thread func_136B4(param_00, param_01, param_03);
  thread func_136E7(param_00, param_01, param_03);
  thread func_136CC(param_00, param_01, param_03);
  var_04 = 1;
  if(isDefined(self.asm.moveplaybackrate)) {
    var_04 = self.asm.moveplaybackrate;
  } else if(isDefined(self.moveplaybackrate)) {
    var_04 = self.moveplaybackrate;
  }

  scripts\asm\asm_mp::func_235F(param_00, param_01, param_02, var_04);
}

func_FFB6(param_00, param_01, param_02, param_03) {
  if(!func_100A3(param_00, param_01, param_02, param_03)) {
    return 1;
  }

  if(!scripts\asm\asm_bb::bb_movetyperequested("combat")) {
    return 1;
  }

  if(scripts\asm\asm_bb::bb_meleechargerequested(param_00, param_01, param_02, param_03)) {
    return 1;
  }

  return 0;
}

func_100A3(param_00, param_01, param_02, param_03) {
  if(isDefined(param_03)) {
    if(!scripts\asm\asm_bb::func_2949(param_00, param_01, param_02, param_03)) {
      return 0;
    }
  }

  if(self.var_1198.alwaysrunforward) {
    return 0;
  }

  if(!scripts\asm\asm_bb::bb_movetyperequested("combat")) {
    return 0;
  }

  if(!scripts\asm\asm_bb::bb_wantstostrafe()) {
    return 0;
  }

  if(!isDefined(self.isnodeoccupied)) {
    if(!isDefined(self.var_6571)) {
      return 0;
    }
  }

  return 1;
}

isfacingenemy(param_00) {
  if(!isDefined(param_00)) {
    param_00 = 0.5;
  }

  var_01 = anglesToForward(self.angles);
  var_02 = vectornormalize(self.isnodeoccupied.origin - self.origin);
  var_03 = vectordot(var_01, var_02);
  if(var_03 < param_00) {
    return 0;
  }

  return 1;
}

func_9FFF() {
  if(isaimedataimtarget()) {
    return 1;
  }

  return 0;
}

shouldshoot(param_00, param_01, param_02, param_03) {
  if(!scripts\asm\asm_bb::func_291C()) {
    return 0;
  }

  if(isDefined(self.isnodeoccupied)) {
    if(!isfacingenemy() && !func_9FFF()) {
      return 0;
    }

    if(!self getpersstat(self.isnodeoccupied)) {
      return 0;
    }
  }

  return 1;
}

func_3EB3(param_00, param_01, param_02) {
  var_03 = scripts\asm\asm::asm_getdemeanor();
  if(scripts\asm\asm::asm_hasdemeanoranimoverride(var_03, "idle")) {
    var_04 = scripts\asm\asm::asm_getdemeanoranimoverride(var_03, "idle");
    if(isarray(var_04)) {
      return var_04[randomint(var_04.size)];
    }

    return var_04;
  }

  return func_3EAB(param_01, param_02, var_03);
}

func_3EAB(param_00, param_01, param_02) {
  if(isDefined(self.var_394)) {
    var_03 = weaponclass(self.var_394);
  } else {
    var_03 = "none";
  }

  if(!scripts\asm\asm::asm_hasalias(param_01, var_03 + param_02)) {
    var_03 = "rifle";
  }

  return scripts\asm\asm::asm_lookupanimfromalias(param_01, var_03 + param_02);
}

func_138E2() {
  if(scripts\asm\asm_bb::func_292C() == "crouch") {
    return 1;
  }

  return 0;
}

_meth_811E(param_00) {
  if(!isDefined(self.var_1198.shootparams)) {
    return undefined;
  } else if(isDefined(self.var_1198.shootparams.ent)) {
    return self.var_1198.shootparams.ent getshootatpos();
  } else if(isDefined(self.var_1198.shootparams.pos)) {
    return self.var_1198.shootparams.pos;
  } else if(isDefined(self.isnodeoccupied)) {
    return self.isnodeoccupied getshootatpos();
  }

  return undefined;
}

_meth_811C() {
  if(isDefined(self.var_130A9)) {
    var_00 = self getspawnteam();
    return (var_00[0], var_00[1], self getEye()[2]);
  }

  return (self.origin[0], self.origin[1], self getEye()[2]);
}

isaimedataimtarget() {
  if(!isDefined(self.var_1198.shootparams.pos) && !isDefined(self.var_1198.shootparams.ent)) {
    return 1;
  }

  var_00 = self getspawnpointdist();
  var_01 = _meth_811C();
  var_02 = _meth_811E(var_01);
  if(!isDefined(var_02)) {
    return 0;
  }

  var_03 = vectortoangles(var_02 - var_01);
  var_04 = scripts\engine\utility::absangleclamp180(var_00[1] - var_03[1]);
  if(var_04 > level.var_1A52) {
    if(distancesquared(self getEye(), var_02) > level.var_1A50 || var_04 > level.var_1A51) {}
  }

  var_05 = func_7DA3();
  return scripts\engine\utility::absangleclamp180(var_00[0] - var_03[0]) <= var_05;
}

func_7DA3() {
  if(isDefined(self.var_1A44)) {
    return self.var_1A44;
  }

  return level.var_1A44;
}

func_CEC0(param_00, param_01, param_02) {}

func_CEC1(param_00, param_01, param_02) {}