/************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: 3086.gsc
************************/

func_97E6(param_00) {
  if(isDefined(self.var_3135.var_9882)) {
    return level.success;
  }

  self.var_1198.civstate = "noncombat";
  self.var_1198.civstatetime = gettime();
  self.var_3135.var_9882 = 1;
  return level.success;
}

func_12E8F(param_00) {
  var_01 = scripts\asm\asm::func_233E("ai_notify", "bulletwhizby");
  if(isDefined(var_01)) {
    if(!isDefined(self.disablebulletwhizbyreaction)) {
      var_02 = var_01.params[0];
      var_03 = isDefined(var_02) && distancesquared(self.origin, var_02.origin) < 262144;
      if(var_03 || scripts\engine\utility::cointoss()) {
        scripts\asm\asm_bb::bb_setcivilianstate("combat");
        scripts\asm\asm_bb::bb_requestwhizby(var_01);
        return level.success;
      }
    }
  } else {
    var_04 = 5000;
    var_01 = scripts\asm\asm_bb::bb_getrequestedwhizby();
    if(!isDefined(var_01) || gettime() > var_01.var_7686 + var_04) {
      scripts\asm\asm_bb::bb_requestwhizby(undefined);
    }
  }

  var_05 = getaiarray("axis");
  foreach(var_07 in var_05) {
    if(distancesquared(var_07.origin, self.origin) < 262144) {
      scripts\asm\asm_bb::bb_setcivilianstate("combat");
      return level.success;
    }
  }

  if(scripts\asm\asm_bb::func_291D() == "combat" && gettime() - scripts\asm\asm_bb::func_291E() >= 10000) {
    scripts\asm\asm_bb::bb_setcivilianstate("noncombat");
  }

  return level.success;
}