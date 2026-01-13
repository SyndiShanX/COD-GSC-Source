/***********************************************
 * Decompiled by Mjkzy and Edited by SyndiShanX
 * Script: 3128.gsc
***********************************************/

func_33FF(var_0, var_1, var_2, var_3) {
  self.asm.footsteps = spawnStruct();
  self.asm.footsteps.foot = "invalid";
  self.asm.footsteps.time = 0;
  self.asm.var_4C86 = spawnStruct();
  self.asm.var_7360 = 0;
  self.asm.var_77C1 = spawnStruct();
  func_98A7();
}

func_98A7() {
  if(isDefined(anim.var_C05A)) {
    return;
  }
  var_0 = [];
  var_0["Cover Left"] = 90;
  var_0["Cover Right"] = -90;
  anim.var_C05A = var_0;
  var_0 = [];
  var_0["Cover Left"] = 90;
  var_0["Cover Right"] = 180;
  anim.var_7365 = var_0;
}

func_10088(var_0, var_1, var_2, var_3) {
  if(scripts\asm\asm_bb::bb_isincombat()) {
    return 0;
  }

  if(isDefined(self.var_6571)) {
    return 0;
  }

  return 1;
}

func_D46D(var_0, var_1, var_2, var_3) {
  scripts\asm\asm_mp::func_2364(var_0, var_1, var_2);
}

reload(var_0, var_1, var_2, var_3) {
  self endon("reload_terminate");
  self endon(var_1 + "_finished");
  var_4 = scripts\asm\asm_mp::asm_getanim(var_0, var_1);
  scripts\asm\asm_mp::func_2365(var_0, var_1, var_2, var_4);
  scripts\anim\weaponlist::refillclip();
  scripts\asm\asm::asm_fireevent(var_1, "reload_finished");
}

func_100A9(var_0, var_1, var_2, var_3) {
  var_4 = scripts\asm\asm_bb::bb_getrequestedweapon();

  if(!isDefined(var_4)) {
    return 0;
  }

  if(weaponclass(self.weapon) == var_4) {
    return 0;
  }

  return 1;
}

func_BEA0(var_0, var_1, var_2, var_3) {
  var_4 = undefined;

  if(isDefined(self._blackboard.shootparams) && isDefined(self._blackboard.shootparams.ent)) {
    var_4 = self._blackboard.shootparams.ent.origin;
  } else if(isDefined(self._blackboard.shootparams) && isDefined(self._blackboard.shootparams.pos)) {
    var_4 = self._blackboard.shootparams.pos;
  } else if(isDefined(self.enemy)) {
    var_4 = self.enemy.origin;
  }

  if(!isDefined(var_4)) {
    return 0;
  }

  var_5 = self.angles[1] - vectortoyaw(var_4 - self.origin);
  var_6 = distancesquared(self.origin, var_4);

  if(var_6 < 65536) {
    var_7 = sqrt(var_6);

    if(var_7 > 3) {
      var_5 = var_5 + asin(-3 / var_7);
    }
  }

  if(abs(angleclamp180(var_5)) > self.var_129AF) {
    return 1;
  }

  return 0;
}

func_81DE() {
  var_0 = 0.25;
  var_1 = undefined;
  var_2 = undefined;

  if(isDefined(self._blackboard.shootparams)) {
    if(isDefined(self._blackboard.shootparams.ent)) {
      var_1 = self._blackboard.shootparams.ent;
    } else if(isDefined(self._blackboard.shootparams.pos)) {
      var_2 = self._blackboard.shootparams.pos;
    }
  }

  if(isDefined(self.enemy)) {
    if(!isDefined(var_1) && !isDefined(var_2)) {
      var_1 = self.enemy;
    }
  }

  if(isDefined(var_1) && !issentient(var_1)) {
    var_0 = 1.5;
  }

  var_3 = scripts\engine\utility::getpredictedaimyawtoshootentorpos(var_0, var_1, var_2);
  return var_3;
}

func_3F0A(var_0, var_1, var_2) {
  var_3 = func_81DE();

  if(var_3 < 0) {
    var_4 = "right";
  } else {
    var_4 = "left";
  }

  var_3 = abs(var_3);
  var_5 = 0;

  if(var_3 > 157.5) {
    var_5 = 180;
  } else if(var_3 > 112.5) {
    var_5 = 135;
  } else if(var_3 > 67.5) {
    var_5 = 90;
  } else {
    var_5 = 45;
  }

  var_6 = var_4 + "_" + var_5;
  var_7 = scripts\asm\asm::asm_lookupanimfromalias(var_1, var_6);
  var_8 = self func_8101(var_1, var_7);
  return var_7;
}

func_116FF(var_0, var_1, var_2, var_3) {}

func_D56A(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  var_4 = scripts\asm\asm_mp::asm_getanim(var_0, var_1);
  var_5 = self.pathgoalpos;
  self scragentsetorientmode("face angle abs", self.angles);
  self ghostlaunched("anim deltas");
  scripts\asm\asm_mp::func_2365(var_0, var_1, var_2, var_4);

  if(!isDefined(var_5) && isDefined(self.pathgoalpos)) {
    self clearpath();
  }

  scripts\asm\asm_mp::func_237F("face current");
  scripts\asm\asm_mp::func_237E("code_move");
}

func_1007E(var_0, var_1, var_2, var_3) {
  var_4 = !scripts\asm\asm_bb::bb_moverequested() && scripts\asm\shared\utility::isatcovernode();

  if(!var_4) {
    return 0;
  }

  if(!isDefined(self.node)) {
    return 0;
  }

  if(!isDefined(var_3)) {
    return 1;
  }

  return lib_0F3A::func_9D4C(var_0, var_1, var_2, var_3);
}

func_CECB(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "finished");
  var_4 = scripts\asm\asm_bb::bb_getrequestedweapon();
  var_5 = scripts\asm\asm_mp::asm_getanim(var_0, var_1);
  scripts\asm\asm_mp::func_2365(var_0, var_1, var_2, var_5);
  self notify("switched_to_sidearm");
}

func_D4B2(var_0, var_1, var_2, var_3) {
  self scragentsetphysicsmode("noclip");
  var_4 = scripts\asm\asm_mp::asm_getanim(var_0, var_1);
  scripts\asm\asm_mp::func_2365(var_0, var_1, var_2, var_4, 1);
}

func_D4B3(var_0, var_1, var_2, var_3) {
  self scragentsetphysicsmode("noclip");
  var_4 = scripts\asm\asm_mp::asm_getanim(var_0, var_1);
  scripts\asm\asm_mp::func_2365(var_0, var_1, var_2, var_4, 0.001);
}

func_FFEF(var_0, var_1, var_2, var_3) {
  if(isDefined(self.var_FFEF)) {
    return 1;
  }

  return 0;
}

func_FFF3(var_0, var_1, var_2, var_3) {
  return isDefined(self.var_FFF3);
}

func_D4EC(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "finished");
  self scragentsetphysicsmode("noclip");
  self scragentsetorientmode("face angle abs", level.neil.angles);
  wait 0.5;
  lib_0F3C::func_CEA8(var_0, var_1, var_2, var_3);
}

func_116EC(var_0, var_1, var_2, var_3) {
  self notify("introanim_done");
  self scragentsetphysicsmode("gravity");
}