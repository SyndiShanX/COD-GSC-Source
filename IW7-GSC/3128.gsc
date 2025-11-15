/************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: 3128.gsc
************************/

func_33FF(param_00, param_01, param_02, param_03) {
  self.asm.footsteps = spawnStruct();
  self.asm.footsteps.foot = "invalid";
  self.asm.footsteps.time = 0;
  self.asm.var_4C86 = spawnStruct();
  self.asm.var_7360 = 0;
  self.asm.var_77C1 = spawnStruct();
  func_98A7();
}

func_98A7() {
  if(isDefined(level.var_C05A)) {
    return;
  }

  var_00 = [];
  var_00["Cover Left"] = 90;
  var_00["Cover Right"] = -90;
  anim.var_C05A = var_00;
  var_00 = [];
  var_00["Cover Left"] = 90;
  var_00["Cover Right"] = 180;
  anim.var_7365 = var_00;
}

func_10088(param_00, param_01, param_02, param_03) {
  if(scripts\asm\asm_bb::bb_isincombat()) {
    return 0;
  }

  if(isDefined(self.var_6571)) {
    return 0;
  }

  return 1;
}

func_D46D(param_00, param_01, param_02, param_03) {
  scripts\asm\asm_mp::func_2364(param_00, param_01, param_02);
}

reload(param_00, param_01, param_02, param_03) {
  self endon("reload_terminate");
  self endon(param_01 + "_finished");
  var_04 = scripts\asm\asm_mp::asm_getanim(param_00, param_01);
  scripts\asm\asm_mp::func_2365(param_00, param_01, param_02, var_04);
  scripts\anim\weaponlist::refillclip();
  scripts\asm\asm::asm_fireevent(param_01, "reload_finished");
}

func_100A9(param_00, param_01, param_02, param_03) {
  var_04 = scripts\asm\asm_bb::bb_getrequestedweapon();
  if(!isDefined(var_04)) {
    return 0;
  }

  if(weaponclass(self.var_394) == var_04) {
    return 0;
  }

  return 1;
}

func_BEA0(param_00, param_01, param_02, param_03) {
  var_04 = undefined;
  if(isDefined(self.var_1198.shootparams) && isDefined(self.var_1198.shootparams.ent)) {
    var_04 = self.var_1198.shootparams.ent.origin;
  } else if(isDefined(self.var_1198.shootparams) && isDefined(self.var_1198.shootparams.pos)) {
    var_04 = self.var_1198.shootparams.pos;
  } else if(isDefined(self.isnodeoccupied)) {
    var_04 = self.isnodeoccupied.origin;
  }

  if(!isDefined(var_04)) {
    return 0;
  }

  var_05 = self.angles[1] - vectortoyaw(var_04 - self.origin);
  var_06 = distancesquared(self.origin, var_04);
  if(var_06 < 65536) {
    var_07 = sqrt(var_06);
    if(var_07 > 3) {
      var_05 = var_05 + asin(-3 / var_07);
    }
  }

  if(abs(angleclamp180(var_05)) > self.var_129AF) {
    return 1;
  }

  return 0;
}

_meth_81DE() {
  var_00 = 0.25;
  var_01 = undefined;
  var_02 = undefined;
  if(isDefined(self.var_1198.shootparams)) {
    if(isDefined(self.var_1198.shootparams.ent)) {
      var_01 = self.var_1198.shootparams.ent;
    } else if(isDefined(self.var_1198.shootparams.pos)) {
      var_02 = self.var_1198.shootparams.pos;
    }
  }

  if(isDefined(self.isnodeoccupied)) {
    if(!isDefined(var_01) && !isDefined(var_02)) {
      var_01 = self.isnodeoccupied;
    }
  }

  if(isDefined(var_01) && !issentient(var_01)) {
    var_00 = 1.5;
  }

  var_03 = scripts\engine\utility::getpredictedaimyawtoshootentorpos(var_00, var_01, var_02);
  return var_03;
}

func_3F0A(param_00, param_01, param_02) {
  var_03 = _meth_81DE();
  if(var_03 < 0) {
    var_04 = "right";
  } else {
    var_04 = "left";
  }

  var_03 = abs(var_03);
  var_05 = 0;
  if(var_03 > 157.5) {
    var_05 = 180;
  } else if(var_03 > 112.5) {
    var_05 = 135;
  } else if(var_03 > 67.5) {
    var_05 = 90;
  } else {
    var_05 = 45;
  }

  var_06 = var_04 + "_" + var_05;
  var_07 = scripts\asm\asm::asm_lookupanimfromalias(param_01, var_06);
  var_08 = self _meth_8101(param_01, var_07);
  return var_07;
}

func_116FF(param_00, param_01, param_02, param_03) {}

func_D56A(param_00, param_01, param_02, param_03) {
  self endon(param_01 + "_finished");
  var_04 = scripts\asm\asm_mp::asm_getanim(param_00, param_01);
  var_05 = self.vehicle_getspawnerarray;
  self orientmode("face angle abs", self.angles);
  self ghostlaunched("anim deltas");
  scripts\asm\asm_mp::func_2365(param_00, param_01, param_02, var_04);
  if(!isDefined(var_05) && isDefined(self.vehicle_getspawnerarray)) {
    self clearpath();
  }

  scripts\asm\asm_mp::func_237F("face current");
  scripts\asm\asm_mp::func_237E("code_move");
}

func_1007E(param_00, param_01, param_02, param_03) {
  var_04 = !scripts\asm\asm_bb::bb_moverequested() && scripts\asm\shared_utility::isatcovernode();
  if(!var_04) {
    return 0;
  }

  if(!isDefined(self.target_getindexoftarget)) {
    return 0;
  }

  if(!isDefined(param_03)) {
    return 1;
  }

  return lib_0F3A::func_9D4C(param_00, param_01, param_02, param_03);
}

func_CECB(param_00, param_01, param_02, param_03) {
  self endon(param_01 + "finished");
  var_04 = scripts\asm\asm_bb::bb_getrequestedweapon();
  var_05 = scripts\asm\asm_mp::asm_getanim(param_00, param_01);
  scripts\asm\asm_mp::func_2365(param_00, param_01, param_02, var_05);
  self notify("switched_to_sidearm");
}

func_D4B2(param_00, param_01, param_02, param_03) {
  self gib_fx_override("noclip");
  var_04 = scripts\asm\asm_mp::asm_getanim(param_00, param_01);
  scripts\asm\asm_mp::func_2365(param_00, param_01, param_02, var_04, 1);
}

func_D4B3(param_00, param_01, param_02, param_03) {
  self gib_fx_override("noclip");
  var_04 = scripts\asm\asm_mp::asm_getanim(param_00, param_01);
  scripts\asm\asm_mp::func_2365(param_00, param_01, param_02, var_04, 0.001);
}

func_FFEF(param_00, param_01, param_02, param_03) {
  if(isDefined(self.var_FFEF)) {
    return 1;
  }

  return 0;
}

func_FFF3(param_00, param_01, param_02, param_03) {
  return isDefined(self.var_FFF3);
}

func_D4EC(param_00, param_01, param_02, param_03) {
  self endon(param_01 + "finished");
  self gib_fx_override("noclip");
  self orientmode("face angle abs", level.neil.angles);
  wait(0.5);
  lib_0F3C::func_CEA8(param_00, param_01, param_02, param_03);
}

func_116EC(param_00, param_01, param_02, param_03) {
  self notify("introanim_done");
  self gib_fx_override("gravity");
}