/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: 3086.gsc
*********************************************/

func_97E6(var_0) {
  if(isDefined(self.bt.var_9882)) {
    return level.success;
  }

  self._blackboard.civstate = "noncombat";
  self._blackboard.civstatetime = gettime();
  self.bt.var_9882 = 1;
  return level.success;
}

func_12E8F(var_0) {
  var_1 = scripts\asm\asm::func_233E("ai_notify", "bulletwhizby");
  if(isDefined(var_1)) {
    if(!isDefined(self.disablebulletwhizbyreaction)) {
      var_2 = var_1.params[0];
      var_3 = isDefined(var_2) && distancesquared(self.origin, var_2.origin) < 262144;
      if(var_3 || scripts\engine\utility::cointoss()) {
        scripts\asm\asm_bb::bb_setcivilianstate("combat");
        scripts\asm\asm_bb::bb_requestwhizby(var_1);
        return level.success;
      }
    }
  } else {
    var_4 = 5000;
    var_1 = scripts\asm\asm_bb::bb_getrequestedwhizby();
    if(!isDefined(var_1) || gettime() > var_1.var_7686 + var_4) {
      scripts\asm\asm_bb::bb_requestwhizby(undefined);
    }
  }

  var_5 = getaiarray("axis");
  foreach(var_7 in var_5) {
    if(distancesquared(var_7.origin, self.origin) < 262144) {
      scripts\asm\asm_bb::bb_setcivilianstate("combat");
      return level.success;
    }
  }

  if(scripts\asm\asm_bb::func_291D() == "combat" && gettime() - scripts\asm\asm_bb::func_291E() >= 10000) {
    scripts\asm\asm_bb::bb_setcivilianstate("noncombat");
  }

  return level.success;
}