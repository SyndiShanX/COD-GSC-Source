/************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: 3174.gsc
************************/

func_9DAD(param_00, param_01, param_02, param_03) {
  if(!self.var_E0) {
    return scripts\engine\utility::damagelocationisany("right_arm_upper", "right_arm_lower", "right_hand");
  }

  return 0;
}

func_9DAE(param_00, param_01, param_02, param_03) {
  if(!self.var_E0) {
    return scripts\engine\utility::damagelocationisany("right_leg_upper", "right_foot", "right_leg_lower");
  }

  return 0;
}

func_9DAC(param_00, param_01, param_02, param_03) {
  if(!self.var_E0) {
    return scripts\engine\utility::damagelocationisany("left_leg_upper", "left_foot", "left_leg_lower");
  }

  return 0;
}

func_9DAA(param_00, param_01, param_02, param_03) {
  if(!self.var_E0) {
    return scripts\engine\utility::damagelocationisany("left_arm_upper", "left_arm_lower", "left_hand");
  }

  return 0;
}

func_9DAF(param_00, param_01, param_02, param_03) {
  if(!self.var_E0) {
    return scripts\engine\utility::damagelocationisany("torso_upper", "torso_lower");
  }

  return 0;
}

func_9DA9(param_00, param_01, param_02, param_03) {
  if(!self.var_E0) {
    return scripts\engine\utility::damagelocationisany("head", "neck", "helmet");
  }

  return 0;
}

func_9DAB(param_00, param_01, param_02, param_03) {
  return scripts\engine\utility::damagelocationisany("left_hand", "left_arm_upper", "left_arm_lower", "left_leg_upper", "left_leg_lower", "left_foot", "torso_lower");
}

func_9DA8(param_00, param_01, param_02, param_03) {
  if(!self.var_E0) {
    if(lib_0A1E::func_7F08() == 1 && !scripts\engine\utility::damagelocationisany("left_leg_upper", "left_leg_lower", "left_foot", "right_leg_upper", "right_leg_lower", "right_foot")) {
      return 1;
    }
  }

  return 0;
}

func_9DB0(param_00, param_01, param_02, param_03) {
  return scripts\engine\utility::damagelocationisany("right_arm_upper", "right_arm_lower", "right_hand", "left_hand", "left_arm_upper", "left_arm_lower", "left_leg_upper", "left_leg_lower", "left_foot", "right_leg_upper", "right_leg_lower", "right_foot", "torso_upper", "torso_lower");
}

func_89E1() {
  self endon("death");
  self notify("new_secondary_pain");
  self endon("new_secondary_pain");
  self.asm.var_F0BC = 1;
  wait(0.5);
  self.asm.var_F0BC = 0;
}

func_136E3(param_00, param_01) {
  self endon(param_01 + "_finished");
  for(;;) {
    self waittill("damage", var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09, var_0A, var_0B);
    if(!isalive(self)) {
      break;
    }

    var_0C = func_3E95(param_00, param_01);
    self _meth_82AB(var_0C, 1, 0.01, 1);
    thread func_89E1();
    wait(0.35);
  }
}

func_9F3A(param_00) {
  if(param_00 == 1) {
    return 1;
  }

  return 0;
}

func_3E95(param_00, param_01) {
  var_02 = [];
  if(scripts\engine\utility::damagelocationisany("torso_upper", "torso_lower")) {
    var_02[var_02.size] = ::scripts\asm\asm::asm_lookupanimfromalias(param_01, "add_torso");
  } else if(scripts\engine\utility::damagelocationisany("head", "helmet", "neck")) {
    var_02[var_02.size] = ::scripts\asm\asm::asm_lookupanimfromalias(param_01, "add_head");
  } else if(scripts\engine\utility::damagelocationisany("right_arm_upper", "right_arm_lower")) {
    var_02[var_02.size] = ::scripts\asm\asm::asm_lookupanimfromalias(param_01, "add_right_arm");
  } else if(scripts\engine\utility::damagelocationisany("left_arm_upper", "left_arm_lower")) {
    var_02[var_02.size] = ::scripts\asm\asm::asm_lookupanimfromalias(param_01, "add_left_arm");
  } else if(scripts\engine\utility::damagelocationisany("left_leg_upper", "left_leg_lower", "left_foot")) {
    var_02[var_02.size] = ::scripts\asm\asm::asm_lookupanimfromalias(param_01, "add_left_leg");
  } else if(scripts\engine\utility::damagelocationisany("right_leg_upper", "right_leg_lower", "right_foot")) {
    var_02[var_02.size] = ::scripts\asm\asm::asm_lookupanimfromalias(param_01, "add_right_leg");
  }

  if(var_02.size < 2) {
    var_02[var_02.size] = ::scripts\asm\asm::asm_lookupanimfromalias(param_01, "add_default");
  }

  return var_02[randomint(var_02.size)];
}

func_3EF0(param_00, param_01, param_02) {
  return scripts\asm\asm::asm_lookupanimfromalias(param_01, "shock_loop_" + self.a.pose);
}

func_D517(param_00, param_01, param_02, param_03) {
  self endon("death");
  self endon(param_01 + "_finished");
  var_04 = level.asm[param_00].states[param_01].var_71A5;
  var_05 = self[[var_04]](param_00, param_01, param_03);
  var_06 = scripts\engine\utility::ter_op(isDefined(self.empstartcallback), self.empstartcallback, 3.5);
  lib_0A1E::func_D521();
  self animmode("zonly_physics", 0);
  wait(randomfloat(0.3));
  if(self.asmname == "c6" || self.asmname == "c6_worker") {
    thread func_FE4E(self.asmname, param_01, param_02, 1, 0, 1);
    self playSound("generic_flashbang_c6_1");
  } else {
    thread func_FE4E(self.asmname, param_01, param_02, 1, 0);
  }

  wait(var_06);
  self notify("painloop_end");
  scripts\asm\asm::asm_fireevent(param_01, "stop_loop_pain");
  self.var_61A9 = undefined;
  func_6CE0(param_00, param_01, param_03);
}

func_FE4D(param_00, param_01, param_02) {
  self stopsounds();
}

func_FE4E(param_00, param_01, param_02, param_03, param_04, param_05) {
  self endon(param_01 + "_finished");
  self endon("painloop_end");
  var_06 = lib_0A1E::asm_getbodyknob();
  self clearanim(var_06, param_02);
  if(isDefined(param_04) && param_04) {
    if(scripts\asm\asm::asm_hasalias("Knobs", "move")) {
      var_07 = lib_0A1E::func_2356("Knobs", "move");
      self _meth_84F2(var_07);
    }
  }

  var_08 = var_06;
  var_09 = lib_0A1E::asm_getallanimsforstate(param_00, param_01);
  for(;;) {
    if(isDefined(param_05)) {
      var_09 = lib_0A1E::asm_getallanimsforstate(param_00, param_01);
    }

    self _meth_82E7(param_01, var_09, 1, param_02, param_03);
    lib_0A1E::func_2369(param_00, param_01, var_09);
    var_08 = var_09;
    lib_0A1E::func_2320(param_00, param_01, var_09, scripts\asm\asm::func_2341(param_00, param_01));
  }
}

func_3EF7(param_00, param_01, param_02, param_03) {
  return scripts\asm\asm::asm_lookupanimfromalias(param_01, "shock_finish_" + self.a.pose);
}

func_D4EE(param_00, param_01, param_02, param_03) {
  func_D4F1(param_00, param_01, param_02, param_03, 0);
}

func_D4F4(param_00, param_01, param_02, param_03) {
  func_D4F1(param_00, param_01, param_02, param_03, 1);
}

func_D4F2(param_00, param_01, param_02, param_03) {
  self.var_1198.var_98F4 = 1;
  func_D4F1(param_00, param_01, param_02, param_03, 0);
}

func_C860(param_00, param_01) {
  if(param_00 == "pain_can_end") {
    return 1;
  }
}

func_6374(param_00, param_01, param_02) {
  self endon(param_01 + "_finished");
  while(isDefined(self.asm.var_F0BC) && self.asm.var_F0BC) {
    wait(0.05);
  }

  scripts\asm\asm::asm_fireevent(param_01, "end");
  func_6CE0(param_00, param_01, param_02);
  self notify(param_01 + "_finished");
}

func_D4F1(param_00, param_01, param_02, param_03, param_04, param_05) {
  self endon(param_01 + "_finished");
  if(isDefined(self.a.var_C888)) {
    self.a.var_A9C8 = self.a.var_C888;
  } else {
    self.a.var_A9C8 = 0;
  }

  self.a.var_C888 = gettime();
  if(self.getcsplinepointtargetname != "none") {
    self.a.var_C87B = 1;
  } else {
    self.a.var_C87B = undefined;
  }

  if(isDefined(self.var_9E33)) {
    scripts\anim\combat_utility::func_5D29();
    self.var_9E33 = undefined;
  }

  self animmode("gravity");
  if(!isDefined(self.var_C006)) {
    scripts\anim\face::saygenericdialogue("pain");
  }

  if(lib_0C60::func_10025(func_1390C())) {
    lib_0C60::func_8E17();
  }

  var_06 = level.asm[param_00].states[param_01].var_71A5;
  var_07 = self[[var_06]](param_00, param_01, param_03);
  self _meth_82E4(param_01, var_07, lib_0A1E::asm_getbodyknob(), 1, param_02, 1);
  if(param_04 == 1) {
    self.asm.var_F0BC = 0;
    thread func_136E3(param_00, param_01);
  }

  lib_0A1E::func_2369(param_00, param_01, var_07);
  if(animhasnotetrack(var_07, "pain_can_end")) {
    var_08 = getnotetracktimes(var_07, "pain_can_end");
    var_09 = getanimlength(var_07);
    wait(var_09 * var_08[0]);
    thread func_6374(param_00, param_01, param_03);
  }

  if(animhasnotetrack(var_07, "code_move")) {
    lib_0A1E::func_231F(param_00, param_01);
  }

  lib_0A1E::func_231F(param_00, param_01);
  func_6CE0(param_00, param_01, param_03, param_05);
}

func_C872(param_00, param_01) {
  switch (param_01) {
    case "pain_can_end":
      return 1;
  }
}

func_6CE0(param_00, param_01, param_02, param_03) {
  self notify("killanimscript");
  var_04 = level.asm[param_00].states[param_01];
  if(isDefined(self.asm.var_F0BC)) {
    self.asm.var_F0BC = undefined;
  }

  var_05 = undefined;
  if(!isDefined(param_03) || !param_03) {
    if(isarray(param_02)) {
      var_05 = param_02[0];
    } else {
      var_05 = param_02;
    }
  }

  if(!isDefined(var_05)) {
    if(isDefined(var_04.transitions) && var_04.transitions.size > 0) {
      return;
    }

    var_05 = "exposed_idle";
  }

  thread scripts\asm\asm::asm_setstate(var_05, undefined);
}

func_CF05(param_00, param_01, param_02, param_03) {
  self.sendmatchdata = 1;
  func_D4F1(param_00, param_01, param_02, param_03, 1);
}

func_CF04(param_00, param_01, param_02, param_03) {
  self.sendmatchdata = 1;
  func_D4EE(param_00, param_01, param_02, param_03);
}

func_100B7() {
  if(self.var_E0 && !isDefined(self.var_55BF)) {
    if(self.a.pose == "prone") {
      return 0;
    }

    if(isDefined(self.sethalfresparticles) && isDefined(self.sethalfresparticles.team) && self.sethalfresparticles.team == self.team) {
      return 0;
    }

    if(self.damageshieldcounter > 0) {
      return 0;
    }

    return 1;
  }

  return 0;
}

func_FFE0(param_00, param_01, param_02, param_03) {
  if(isDefined(self.var_E0) && self.var_E0 && !isDefined(self.var_55BF)) {
    if(isDefined(self.sethalfresparticles) && isDefined(self.sethalfresparticles.unittype) && self.sethalfresparticles.unittype == "c8" && isDefined(self.var_E2) && weaponisbeam(self.var_E2)) {
      return 1;
    }
  }

  return 0;
}

func_D4EF(param_00, param_01, param_02, param_03) {
  self.asm.var_2AD2 = 1;
  func_D4F1(param_00, param_01, param_02, param_03, 0, 1);
}

func_D4F0(param_00, param_01, param_02) {
  self.asm.var_2AD2 = undefined;
}

func_3E9D(param_00, param_01, param_02) {
  return [
    [self.var_7193]
  ](param_01, "pain");
}

func_3EEE(param_00, param_01, param_02) {
  if(self.lasttorsoanim == "torso_upper") {
    var_03 = scripts\asm\asm::asm_lookupanimfromalias(param_01, "torso_upper");
  } else if(self.lasttorsoanim == "torso_lower") {
    var_03 = scripts\asm\asm::asm_lookupanimfromalias(param_02, "torso_lower");
  } else {
    var_03 = scripts\asm\asm::asm_lookupanimfromalias(param_02, "default");
  }

  self.lasttorsoanim = undefined;
  return var_03;
}

func_3EED(param_00, param_01, param_02) {
  if(scripts\engine\utility::damagelocationisany("torso_upper")) {
    self.lasttorsoanim = "torso_upper";
    return scripts\asm\asm::asm_lookupanimfromalias(param_01, "torso_upper");
  }

  if(scripts\engine\utility::damagelocationisany("torso_lower")) {
    self.lasttorsoanim = "torso_lower";
    return scripts\asm\asm::asm_lookupanimfromalias(param_01, "torso_lower");
  }

  self.lasttorsoanim = "default";
  return scripts\asm\asm::asm_lookupanimfromalias(param_01, "default");
}

func_3EEC(param_00, param_01, param_02) {
  if(func_100B7()) {
    if(self.a.pose == "crouch") {
      return scripts\asm\asm::asm_lookupanimfromalias(param_01, "damage_shield_crouch");
    } else if(self.a.pose == "stand") {
      return scripts\asm\asm::asm_lookupanimfromalias(param_01, "damage_shield_stand");
    }
  }

  if(scripts\anim\utility_common::isusingsidearm()) {
    return func_3EEA(param_00, param_01, param_02);
  }

  var_03 = [];
  if(scripts\engine\utility::damagelocationisany("torso_upper")) {
    var_03[var_03.size] = ::scripts\asm\asm::asm_lookupanimfromalias(param_01, "torso_upper");
  } else if(scripts\engine\utility::damagelocationisany("torso_lower")) {
    var_03[var_03.size] = ::scripts\asm\asm::asm_lookupanimfromalias(param_01, "torso_lower");
  } else if(scripts\engine\utility::damagelocationisany("head", "helmet", "neck")) {
    var_03[var_03.size] = ::scripts\asm\asm::asm_lookupanimfromalias(param_01, "head");
  } else if(scripts\engine\utility::damagelocationisany("right_arm_upper", "right_arm_lower")) {
    var_03[var_03.size] = ::scripts\asm\asm::asm_lookupanimfromalias(param_01, "right_arm");
  } else if(scripts\engine\utility::damagelocationisany("left_arm_upper", "left_arm_lower")) {
    var_03[var_03.size] = ::scripts\asm\asm::asm_lookupanimfromalias(param_01, "left_arm");
  } else if(scripts\engine\utility::damagelocationisany("left_leg_upper", "left_leg_lower", "left_foot")) {
    var_03[var_03.size] = ::scripts\asm\asm::asm_lookupanimfromalias(param_01, "left_leg");
  } else if(scripts\engine\utility::damagelocationisany("right_leg_upper", "right_leg_lower", "right_foot")) {
    var_03[var_03.size] = ::scripts\asm\asm::asm_lookupanimfromalias(param_01, "right_leg");
  }

  if(var_03.size < 2) {
    var_03[var_03.size] = ::scripts\asm\asm::asm_lookupanimfromalias(param_01, "default");
  }

  return var_03[randomint(var_03.size)];
}

func_3EE9(param_00, param_01, param_02) {
  if(func_100B7()) {
    if(self.a.pose == "crouch") {
      return scripts\asm\asm::asm_lookupanimfromalias(param_01, "damage_shield_crouch");
    } else if(self.a.pose == "stand") {
      return scripts\asm\asm::asm_lookupanimfromalias(param_01, "damage_shield_stand");
    }
  }

  var_03 = [];
  if(var_03.size < 2) {
    var_03[var_03.size] = ::scripts\asm\asm::asm_lookupanimfromalias(param_01, "default");
  }

  return var_03[randomint(var_03.size)];
}

func_3ED6(param_00, param_01, param_02) {
  var_03 = [];
  var_03[var_03.size] = ::scripts\asm\asm::asm_lookupanimfromalias(param_01, "default");
  return var_03[randomint(var_03.size)];
}

func_3EE8(param_00, param_01, param_02) {
  var_03 = [];
  var_03[var_03.size] = ::scripts\asm\asm::asm_lookupanimfromalias(param_01, "default");
  if(scripts\engine\utility::damagelocationisany("left_hand", "left_arm_lower", "left_arm_upper")) {
    var_03[var_03.size] = ::scripts\asm\asm::asm_lookupanimfromalias(param_01, "left_arm");
  }

  if(scripts\engine\utility::damagelocationisany("right_hand", "right_arm_lower", "right_arm_upper")) {
    var_03[var_03.size] = ::scripts\asm\asm::asm_lookupanimfromalias(param_01, "right_arm");
  }

  return var_03[randomint(var_03.size)];
}

func_3EEA(param_00, param_01, param_02) {
  var_03 = [];
  if(scripts\engine\utility::damagelocationisany("torso_upper")) {
    var_03[var_03.size] = ::scripts\asm\asm::asm_lookupanimfromalias(param_01, "pistol_torso_upper");
  } else if(scripts\engine\utility::damagelocationisany("torso_lower")) {
    var_03[var_03.size] = ::scripts\asm\asm::asm_lookupanimfromalias(param_01, "pistol_torso_lower");
  } else if(scripts\engine\utility::damagelocationisany("neck")) {
    var_03[var_03.size] = ::scripts\asm\asm::asm_lookupanimfromalias(param_01, "pistol_neck");
  } else if(scripts\engine\utility::damagelocationisany("head")) {
    var_03[var_03.size] = ::scripts\asm\asm::asm_lookupanimfromalias(param_01, "pistol_head");
  } else if(scripts\engine\utility::damagelocationisany("left_leg_upper", "right_leg_upper")) {
    var_03[var_03.size] = ::scripts\asm\asm::asm_lookupanimfromalias(param_01, "pistol_leg");
  } else if(scripts\engine\utility::damagelocationisany("left_arm_upper")) {
    var_03[var_03.size] = ::scripts\asm\asm::asm_lookupanimfromalias(param_01, "pistol_left_arm_upper");
  } else if(scripts\engine\utility::damagelocationisany("left_arm_lower")) {
    var_03[var_03.size] = ::scripts\asm\asm::asm_lookupanimfromalias(param_01, "pistol_left_arm_lower");
  } else if(scripts\engine\utility::damagelocationisany("right_arm_upper")) {
    var_03[var_03.size] = ::scripts\asm\asm::asm_lookupanimfromalias(param_01, "pistol_right_arm_upper");
  } else if(scripts\engine\utility::damagelocationisany("right_arm_lower")) {
    var_03[var_03.size] = ::scripts\asm\asm::asm_lookupanimfromalias(param_01, "pistol_right_arm_lower");
  }

  if(var_03.size < 2) {
    var_03[var_03.size] = ::scripts\asm\asm::asm_lookupanimfromalias(param_01, "pistol_default");
  }

  return var_03[randomint(var_03.size)];
}

func_3EEB(param_00, param_01, param_02) {
  var_03 = 120;
  var_04 = 200;
  var_05 = 300;
  var_06 = [];
  var_07 = 0;
  var_08 = 0;
  var_09 = 0;
  if(self maymovetopoint(self gettweakablevalue((var_05, 0, 0)))) {
    var_08 = 1;
    var_07 = 1;
  } else if(self maymovetopoint(self gettweakablevalue((var_04, 0, 0)))) {
    var_07 = 1;
  }

  if(isDefined(self.a.var_55FD)) {
    var_08 = 0;
    var_07 = 0;
  }

  if(var_08) {
    var_06[var_06.size] = ::scripts\asm\asm::asm_lookupanimfromalias(param_01, "long");
  } else if(var_07) {
    var_06[var_06.size] = ::scripts\asm\asm::asm_lookupanimfromalias(param_01, "medium");
  } else if(self maymovetopoint(self gettweakablevalue((var_03, 0, 0)))) {
    var_06[var_06.size] = ::scripts\asm\asm::asm_lookupanimfromalias(param_01, "short");
  }

  if(var_06.size == 0) {
    return scripts\asm\asm::asm_lookupanimfromalias(param_01, "emergency_backup");
  }

  return var_06[randomint(var_06.size)];
}

func_3EE5(param_00, param_01, param_02) {
  if(isDefined(param_02) && isDefined(param_02[1])) {
    return scripts\asm\asm::asm_lookupanimfromalias(param_01, param_02[1]);
  }

  if(self.a.pose == "crouch") {
    return scripts\asm\asm::asm_lookupanimfromalias(param_01, "crouch");
  }

  return scripts\asm\asm::asm_lookupanimfromalias(param_01, "stand");
}

func_3ED3(param_00, param_01, param_02) {
  var_03 = "back";
  return scripts\asm\asm::asm_lookupanimfromalias(param_01, var_03);
}

func_3EE6(param_00, param_01, param_02) {
  var_03 = "crouch";
  if(isDefined(param_02)) {
    var_03 = var_03 + "_" + param_02;
  }

  return scripts\asm\asm::asm_lookupanimfromalias(param_01, var_03);
}

func_3ED4(param_00, param_01, param_02) {
  var_03 = [];
  if(scripts\engine\utility::damagelocationisany("torso_upper", "torso_lower")) {
    var_03[var_03.size] = ::scripts\asm\asm::asm_lookupanimfromalias(param_01, "torso");
  } else if(scripts\engine\utility::damagelocationisany("head", "helmet", "neck")) {
    var_03[var_03.size] = ::scripts\asm\asm::asm_lookupanimfromalias(param_01, "head");
  }

  if(var_03.size < 2) {
    var_03[var_03.size] = ::scripts\asm\asm::asm_lookupanimfromalias(param_01, "default");
  }

  return var_03[randomint(var_03.size)];
}

func_3EE7(param_00, param_01, param_02) {
  var_03 = "stand";
  if(isDefined(param_02) && isDefined(param_02)) {
    var_03 = var_03 + "_" + param_02;
  }

  return scripts\asm\asm::asm_lookupanimfromalias(param_01, var_03);
}

func_3ED5(param_00, param_01, param_02) {
  var_03 = [];
  if(scripts\engine\utility::damagelocationisany("torso_upper")) {
    var_03[var_03.size] = ::scripts\asm\asm::asm_lookupanimfromalias(param_01, "torso_upper");
  } else if(scripts\engine\utility::damagelocationisany("torso_lower")) {
    var_03[var_03.size] = ::scripts\asm\asm::asm_lookupanimfromalias(param_01, "torso_lower");
  } else if(scripts\engine\utility::damagelocationisany("head", "helmet", "neck")) {
    var_03[var_03.size] = ::scripts\asm\asm::asm_lookupanimfromalias(param_01, "head");
  } else if(scripts\engine\utility::damagelocationisany("right_arm_upper", "right_arm_lower")) {
    var_03[var_03.size] = ::scripts\asm\asm::asm_lookupanimfromalias(param_01, "right_arm");
  } else if(scripts\engine\utility::damagelocationisany("left_arm_upper", "left_arm_lower")) {
    var_03[var_03.size] = ::scripts\asm\asm::asm_lookupanimfromalias(param_01, "left_arm");
  } else if(scripts\engine\utility::damagelocationisany("left_leg_upper", "left_leg_lower", "left_foot")) {
    var_03[var_03.size] = ::scripts\asm\asm::asm_lookupanimfromalias(param_01, "left_leg");
  } else if(scripts\engine\utility::damagelocationisany("right_leg_upper", "right_leg_lower", "right_foot")) {
    var_03[var_03.size] = ::scripts\asm\asm::asm_lookupanimfromalias(param_01, "right_leg");
  }

  if(var_03.size < 2) {
    var_03[var_03.size] = ::scripts\asm\asm::asm_lookupanimfromalias(param_01, "default");
  }

  return var_03[randomint(var_03.size)];
}

func_3EEF(param_00, param_01, param_02) {
  var_03 = 3;
  var_04 = "deaf_" + randomint(var_03) + 1;
  return scripts\asm\asm::asm_lookupanimfromalias(param_01, var_04);
}

func_4109(param_00, param_01, param_02) {
  if(self.script == "pain") {
    self notify("killanimscript");
  }

  if(isDefined(self.var_4D6A)) {
    self.damageshieldcounter = undefined;
    self.var_4D6A = undefined;
    self.allowpain = 1;
    if(!isDefined(self.var_D817)) {
      self.ignoreme = 0;
    }

    self.var_D817 = undefined;
  }

  if(isDefined(self.var_2BB9)) {
    self.var_2BB9 = undefined;
    self.allowpain = 1;
  }
}

func_1390C() {
  if(isexplosivedamagemod(self.var_DE)) {
    return 1;
  }

  if(gettime() - level.var_A955 <= 50) {
    var_00 = level.var_A954 * level.var_A954 * 1.2 * 1.2;
    if(distancesquared(self.origin, level.var_A952) < var_00) {
      var_01 = var_00 * 0.5 * 0.5;
      self.var_B4DF = distancesquared(self.origin, level.var_A953) < var_01;
      return 1;
    }
  }

  return 0;
}