/*****************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\asm\alien_goon\alien_goon_asm.gsc
*****************************************************/

asminit(var_0, var_1, var_2, var_3) {
  scripts\asm\zombie\zombie::func_13F9A(var_0, var_1, var_2, var_3);
  self.fnactionvalidator = ::isvalidaction;
  scripts\asm\dlc4\dlc4_asm::analyzeanims();
}

isvalidaction(var_0) {
  switch (var_0) {
    case "stumble":
    case "slide_right":
    case "slide_left":
    case "jump_back":
    case "jump_attack":
    case "stand_melee":
    case "jump":
    case "moving_melee":
    case "taunt":
      return 1;
  }

  return 0;
}

shouldplayentranceanim(var_0, var_1, var_2, var_3) {
  return 0;
}

playstumble(var_0, var_1, var_2, var_3) {
  var_4 = scripts\asm\asm_mp::asm_getanim(var_0, var_1);
  if(scripts\engine\utility::istrue(self.activated_venomx_sphere)) {
    scripts\asm\asm_mp::func_2365(var_0, var_1, var_2, var_4, 0.2);
    return;
  }

  scripts\asm\asm_mp::func_2365(var_0, var_1, var_2, var_4, self.var_C081);
}

playpostattackmanuever(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  var_4 = scripts\asm\dlc4\dlc4_asm::getenemy();
  if(isDefined(var_4)) {
    thread scripts\asm\zombie\melee::func_6A6A(var_1, var_4);
  }

  var_5 = scripts\asm\asm_mp::asm_getanim(var_0, var_1);
  if(scripts\engine\utility::istrue(self.activated_venomx_sphere)) {
    scripts\asm\asm_mp::func_2365(var_0, var_1, var_2, var_5, 0.2);
    return;
  }

  scripts\asm\asm_mp::func_2365(var_0, var_1, var_2, var_5, self.var_C081);
}

wantstododge(var_0, var_1, var_2, var_3) {
  return isDefined(self._blackboard.requested_dodge_dir);
}

playdodgeanim(var_0, var_1, var_2, var_3) {
  var_4 = scripts\asm\asm_mp::asm_getanim(var_0, var_1);
  if(scripts\engine\utility::istrue(self.activated_venomx_sphere)) {
    self scragentsetanimscale(0.2, 0.2);
  } else {
    self scragentsetanimscale(self._blackboard.requested_dodge_scale, 1);
  }

  self._blackboard.requested_dodge_dir = undefined;
  self._blackboard.requested_dodge_scale = undefined;
  if(scripts\engine\utility::istrue(self.activated_venomx_sphere)) {
    scripts\asm\asm_mp::func_2365(var_0, var_1, var_2, var_4, 0.2);
    return;
  }

  scripts\asm\asm_mp::func_2365(var_0, var_1, var_2, var_4, self.var_C081);
}

terminate_rundodge(var_0, var_1, var_2) {
  if(scripts\engine\utility::istrue(self.activated_venomx_sphere)) {
    self scragentsetanimscale(0.2, 0.2);
    return;
  }

  self scragentsetanimscale(1, 1);
}

choosedodgeanim(var_0, var_1, var_2) {
  return scripts\asm\asm::asm_lookupanimfromalias(var_1, self._blackboard.requested_dodge_dir);
}