/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: 3174.gsc
*********************************************/

func_9DAD(var_0, var_1, var_2, var_3) {
  if(!self.var_E0) {
    return scripts\engine\utility::damagelocationisany("right_arm_upper", "right_arm_lower", "right_hand");
  }

  return 0;
}

func_9DAE(var_0, var_1, var_2, var_3) {
  if(!self.var_E0) {
    return scripts\engine\utility::damagelocationisany("right_leg_upper", "right_foot", "right_leg_lower");
  }

  return 0;
}

func_9DAC(var_0, var_1, var_2, var_3) {
  if(!self.var_E0) {
    return scripts\engine\utility::damagelocationisany("left_leg_upper", "left_foot", "left_leg_lower");
  }

  return 0;
}

func_9DAA(var_0, var_1, var_2, var_3) {
  if(!self.var_E0) {
    return scripts\engine\utility::damagelocationisany("left_arm_upper", "left_arm_lower", "left_hand");
  }

  return 0;
}

func_9DAF(var_0, var_1, var_2, var_3) {
  if(!self.var_E0) {
    return scripts\engine\utility::damagelocationisany("torso_upper", "torso_lower");
  }

  return 0;
}

func_9DA9(var_0, var_1, var_2, var_3) {
  if(!self.var_E0) {
    return scripts\engine\utility::damagelocationisany("head", "neck", "helmet");
  }

  return 0;
}

func_9DAB(var_0, var_1, var_2, var_3) {
  return scripts\engine\utility::damagelocationisany("left_hand", "left_arm_upper", "left_arm_lower", "left_leg_upper", "left_leg_lower", "left_foot", "torso_lower");
}

func_9DA8(var_0, var_1, var_2, var_3) {
  if(!self.var_E0) {
    if(lib_0A1E::func_7F08() == 1 && !scripts\engine\utility::damagelocationisany("left_leg_upper", "left_leg_lower", "left_foot", "right_leg_upper", "right_leg_lower", "right_foot")) {
      return 1;
    }
  }

  return 0;
}

func_9DB0(var_0, var_1, var_2, var_3) {
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

func_136E3(var_0, var_1) {
  self endon(var_1 + "_finished");
  for(;;) {
    self waittill("damage", var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11);
    if(!isalive(self)) {
      break;
    }

    var_12 = func_3E95(var_0, var_1);
    self func_82AB(var_12, 1, 0.01, 1);
    thread func_89E1();
    wait(0.35);
  }
}

func_9F3A(var_0) {
  if(var_0 == 1) {
    return 1;
  }

  return 0;
}

func_3E95(var_0, var_1) {
  var_2 = [];
  if(scripts\engine\utility::damagelocationisany("torso_upper", "torso_lower")) {
    var_2[var_2.size] = ::scripts\asm\asm::asm_lookupanimfromalias(var_1, "add_torso");
  } else if(scripts\engine\utility::damagelocationisany("head", "helmet", "neck")) {
    var_2[var_2.size] = ::scripts\asm\asm::asm_lookupanimfromalias(var_1, "add_head");
  } else if(scripts\engine\utility::damagelocationisany("right_arm_upper", "right_arm_lower")) {
    var_2[var_2.size] = ::scripts\asm\asm::asm_lookupanimfromalias(var_1, "add_right_arm");
  } else if(scripts\engine\utility::damagelocationisany("left_arm_upper", "left_arm_lower")) {
    var_2[var_2.size] = ::scripts\asm\asm::asm_lookupanimfromalias(var_1, "add_left_arm");
  } else if(scripts\engine\utility::damagelocationisany("left_leg_upper", "left_leg_lower", "left_foot")) {
    var_2[var_2.size] = ::scripts\asm\asm::asm_lookupanimfromalias(var_1, "add_left_leg");
  } else if(scripts\engine\utility::damagelocationisany("right_leg_upper", "right_leg_lower", "right_foot")) {
    var_2[var_2.size] = ::scripts\asm\asm::asm_lookupanimfromalias(var_1, "add_right_leg");
  }

  if(var_2.size < 2) {
    var_2[var_2.size] = ::scripts\asm\asm::asm_lookupanimfromalias(var_1, "add_default");
  }

  return var_2[randomint(var_2.size)];
}

func_3EF0(var_0, var_1, var_2) {
  return scripts\asm\asm::asm_lookupanimfromalias(var_1, "shock_loop_" + self.a.pose);
}

func_D517(var_0, var_1, var_2, var_3) {
  self endon("death");
  self endon(var_1 + "_finished");
  var_4 = level.asm[var_0].states[var_1].var_71A5;
  var_5 = self[[var_4]](var_0, var_1, var_3);
  var_6 = scripts\engine\utility::ter_op(isDefined(self.empstartcallback), self.empstartcallback, 3.5);
  lib_0A1E::func_D521();
  self animmode("zonly_physics", 0);
  wait(randomfloat(0.3));
  if(self.asmname == "c6" || self.asmname == "c6_worker") {
    thread func_FE4E(self.asmname, var_1, var_2, 1, 0, 1);
    self playSound("generic_flashbang_c6_1");
  } else {
    thread func_FE4E(self.asmname, var_1, var_2, 1, 0);
  }

  wait(var_6);
  self notify("painloop_end");
  scripts\asm\asm::asm_fireevent(var_1, "stop_loop_pain");
  self.var_61A9 = undefined;
  func_6CE0(var_0, var_1, var_3);
}

func_FE4D(var_0, var_1, var_2) {
  self stopsounds();
}

func_FE4E(var_0, var_1, var_2, var_3, var_4, var_5) {
  self endon(var_1 + "_finished");
  self endon("painloop_end");
  var_6 = lib_0A1E::asm_getbodyknob();
  self clearanim(var_6, var_2);
  if(isDefined(var_4) && var_4) {
    if(scripts\asm\asm::asm_hasalias("Knobs", "move")) {
      var_7 = lib_0A1E::func_2356("Knobs", "move");
      self func_84F2(var_7);
    }
  }

  var_8 = var_6;
  var_9 = lib_0A1E::asm_getallanimsforstate(var_0, var_1);
  for(;;) {
    if(isDefined(var_5)) {
      var_9 = lib_0A1E::asm_getallanimsforstate(var_0, var_1);
    }

    self func_82E7(var_1, var_9, 1, var_2, var_3);
    lib_0A1E::func_2369(var_0, var_1, var_9);
    var_8 = var_9;
    lib_0A1E::func_2320(var_0, var_1, var_9, scripts\asm\asm::func_2341(var_0, var_1));
  }
}

func_3EF7(var_0, var_1, var_2, var_3) {
  return scripts\asm\asm::asm_lookupanimfromalias(var_1, "shock_finish_" + self.a.pose);
}

func_D4EE(var_0, var_1, var_2, var_3) {
  func_D4F1(var_0, var_1, var_2, var_3, 0);
}

func_D4F4(var_0, var_1, var_2, var_3) {
  func_D4F1(var_0, var_1, var_2, var_3, 1);
}

func_D4F2(var_0, var_1, var_2, var_3) {
  self._blackboard.var_98F4 = 1;
  func_D4F1(var_0, var_1, var_2, var_3, 0);
}

func_C860(var_0, var_1) {
  if(var_0 == "pain_can_end") {
    return 1;
  }
}

func_6374(var_0, var_1, var_2) {
  self endon(var_1 + "_finished");
  while(isDefined(self.asm.var_F0BC) && self.asm.var_F0BC) {
    wait(0.05);
  }

  scripts\asm\asm::asm_fireevent(var_1, "end");
  func_6CE0(var_0, var_1, var_2);
  self notify(var_1 + "_finished");
}

func_D4F1(var_0, var_1, var_2, var_3, var_4, var_5) {
  self endon(var_1 + "_finished");
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

  var_6 = level.asm[var_0].states[var_1].var_71A5;
  var_7 = self[[var_6]](var_0, var_1, var_3);
  self func_82E4(var_1, var_7, lib_0A1E::asm_getbodyknob(), 1, var_2, 1);
  if(var_4 == 1) {
    self.asm.var_F0BC = 0;
    thread func_136E3(var_0, var_1);
  }

  lib_0A1E::func_2369(var_0, var_1, var_7);
  if(animhasnotetrack(var_7, "pain_can_end")) {
    var_8 = getnotetracktimes(var_7, "pain_can_end");
    var_9 = getanimlength(var_7);
    wait(var_9 * var_8[0]);
    thread func_6374(var_0, var_1, var_3);
  }

  if(animhasnotetrack(var_7, "code_move")) {
    lib_0A1E::func_231F(var_0, var_1);
  }

  lib_0A1E::func_231F(var_0, var_1);
  func_6CE0(var_0, var_1, var_3, var_5);
}

func_C872(var_0, var_1) {
  switch (var_1) {
    case "pain_can_end":
      return 1;
  }
}

func_6CE0(var_0, var_1, var_2, var_3) {
  self notify("killanimscript");
  var_4 = level.asm[var_0].states[var_1];
  if(isDefined(self.asm.var_F0BC)) {
    self.asm.var_F0BC = undefined;
  }

  var_5 = undefined;
  if(!isDefined(var_3) || !var_3) {
    if(isarray(var_2)) {
      var_5 = var_2[0];
    } else {
      var_5 = var_2;
    }
  }

  if(!isDefined(var_5)) {
    if(isDefined(var_4.transitions) && var_4.transitions.size > 0) {
      return;
    }

    var_5 = "exposed_idle";
  }

  thread scripts\asm\asm::asm_setstate(var_5, undefined);
}

func_CF05(var_0, var_1, var_2, var_3) {
  self.sendmatchdata = 1;
  func_D4F1(var_0, var_1, var_2, var_3, 1);
}

func_CF04(var_0, var_1, var_2, var_3) {
  self.sendmatchdata = 1;
  func_D4EE(var_0, var_1, var_2, var_3);
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

func_FFE0(var_0, var_1, var_2, var_3) {
  if(isDefined(self.var_E0) && self.var_E0 && !isDefined(self.var_55BF)) {
    if(isDefined(self.sethalfresparticles) && isDefined(self.sethalfresparticles.unittype) && self.sethalfresparticles.unittype == "c8" && isDefined(self.var_E2) && weaponisbeam(self.var_E2)) {
      return 1;
    }
  }

  return 0;
}

func_D4EF(var_0, var_1, var_2, var_3) {
  self.asm.var_2AD2 = 1;
  func_D4F1(var_0, var_1, var_2, var_3, 0, 1);
}

func_D4F0(var_0, var_1, var_2) {
  self.asm.var_2AD2 = undefined;
}

func_3E9D(var_0, var_1, var_2) {
  return [[self.var_7193]](var_1, "pain");
}

func_3EEE(var_0, var_1, var_2) {
  if(self.lasttorsoanim == "torso_upper") {
    var_3 = scripts\asm\asm::asm_lookupanimfromalias(var_1, "torso_upper");
  } else if(self.lasttorsoanim == "torso_lower") {
    var_3 = scripts\asm\asm::asm_lookupanimfromalias(var_2, "torso_lower");
  } else {
    var_3 = scripts\asm\asm::asm_lookupanimfromalias(var_2, "default");
  }

  self.lasttorsoanim = undefined;
  return var_3;
}

func_3EED(var_0, var_1, var_2) {
  if(scripts\engine\utility::damagelocationisany("torso_upper")) {
    self.lasttorsoanim = "torso_upper";
    return scripts\asm\asm::asm_lookupanimfromalias(var_1, "torso_upper");
  }

  if(scripts\engine\utility::damagelocationisany("torso_lower")) {
    self.lasttorsoanim = "torso_lower";
    return scripts\asm\asm::asm_lookupanimfromalias(var_1, "torso_lower");
  }

  self.lasttorsoanim = "default";
  return scripts\asm\asm::asm_lookupanimfromalias(var_1, "default");
}

func_3EEC(var_0, var_1, var_2) {
  if(func_100B7()) {
    if(self.a.pose == "crouch") {
      return scripts\asm\asm::asm_lookupanimfromalias(var_1, "damage_shield_crouch");
    } else if(self.a.pose == "stand") {
      return scripts\asm\asm::asm_lookupanimfromalias(var_1, "damage_shield_stand");
    }
  }

  if(scripts\anim\utility_common::isusingsidearm()) {
    return func_3EEA(var_0, var_1, var_2);
  }

  var_3 = [];
  if(scripts\engine\utility::damagelocationisany("torso_upper")) {
    var_3[var_3.size] = ::scripts\asm\asm::asm_lookupanimfromalias(var_1, "torso_upper");
  } else if(scripts\engine\utility::damagelocationisany("torso_lower")) {
    var_3[var_3.size] = ::scripts\asm\asm::asm_lookupanimfromalias(var_1, "torso_lower");
  } else if(scripts\engine\utility::damagelocationisany("head", "helmet", "neck")) {
    var_3[var_3.size] = ::scripts\asm\asm::asm_lookupanimfromalias(var_1, "head");
  } else if(scripts\engine\utility::damagelocationisany("right_arm_upper", "right_arm_lower")) {
    var_3[var_3.size] = ::scripts\asm\asm::asm_lookupanimfromalias(var_1, "right_arm");
  } else if(scripts\engine\utility::damagelocationisany("left_arm_upper", "left_arm_lower")) {
    var_3[var_3.size] = ::scripts\asm\asm::asm_lookupanimfromalias(var_1, "left_arm");
  } else if(scripts\engine\utility::damagelocationisany("left_leg_upper", "left_leg_lower", "left_foot")) {
    var_3[var_3.size] = ::scripts\asm\asm::asm_lookupanimfromalias(var_1, "left_leg");
  } else if(scripts\engine\utility::damagelocationisany("right_leg_upper", "right_leg_lower", "right_foot")) {
    var_3[var_3.size] = ::scripts\asm\asm::asm_lookupanimfromalias(var_1, "right_leg");
  }

  if(var_3.size < 2) {
    var_3[var_3.size] = ::scripts\asm\asm::asm_lookupanimfromalias(var_1, "default");
  }

  return var_3[randomint(var_3.size)];
}

func_3EE9(var_0, var_1, var_2) {
  if(func_100B7()) {
    if(self.a.pose == "crouch") {
      return scripts\asm\asm::asm_lookupanimfromalias(var_1, "damage_shield_crouch");
    } else if(self.a.pose == "stand") {
      return scripts\asm\asm::asm_lookupanimfromalias(var_1, "damage_shield_stand");
    }
  }

  var_3 = [];
  if(var_3.size < 2) {
    var_3[var_3.size] = ::scripts\asm\asm::asm_lookupanimfromalias(var_1, "default");
  }

  return var_3[randomint(var_3.size)];
}

func_3ED6(var_0, var_1, var_2) {
  var_3 = [];
  var_3[var_3.size] = ::scripts\asm\asm::asm_lookupanimfromalias(var_1, "default");
  return var_3[randomint(var_3.size)];
}

func_3EE8(var_0, var_1, var_2) {
  var_3 = [];
  var_3[var_3.size] = ::scripts\asm\asm::asm_lookupanimfromalias(var_1, "default");
  if(scripts\engine\utility::damagelocationisany("left_hand", "left_arm_lower", "left_arm_upper")) {
    var_3[var_3.size] = ::scripts\asm\asm::asm_lookupanimfromalias(var_1, "left_arm");
  }

  if(scripts\engine\utility::damagelocationisany("right_hand", "right_arm_lower", "right_arm_upper")) {
    var_3[var_3.size] = ::scripts\asm\asm::asm_lookupanimfromalias(var_1, "right_arm");
  }

  return var_3[randomint(var_3.size)];
}

func_3EEA(var_0, var_1, var_2) {
  var_3 = [];
  if(scripts\engine\utility::damagelocationisany("torso_upper")) {
    var_3[var_3.size] = ::scripts\asm\asm::asm_lookupanimfromalias(var_1, "pistol_torso_upper");
  } else if(scripts\engine\utility::damagelocationisany("torso_lower")) {
    var_3[var_3.size] = ::scripts\asm\asm::asm_lookupanimfromalias(var_1, "pistol_torso_lower");
  } else if(scripts\engine\utility::damagelocationisany("neck")) {
    var_3[var_3.size] = ::scripts\asm\asm::asm_lookupanimfromalias(var_1, "pistol_neck");
  } else if(scripts\engine\utility::damagelocationisany("head")) {
    var_3[var_3.size] = ::scripts\asm\asm::asm_lookupanimfromalias(var_1, "pistol_head");
  } else if(scripts\engine\utility::damagelocationisany("left_leg_upper", "right_leg_upper")) {
    var_3[var_3.size] = ::scripts\asm\asm::asm_lookupanimfromalias(var_1, "pistol_leg");
  } else if(scripts\engine\utility::damagelocationisany("left_arm_upper")) {
    var_3[var_3.size] = ::scripts\asm\asm::asm_lookupanimfromalias(var_1, "pistol_left_arm_upper");
  } else if(scripts\engine\utility::damagelocationisany("left_arm_lower")) {
    var_3[var_3.size] = ::scripts\asm\asm::asm_lookupanimfromalias(var_1, "pistol_left_arm_lower");
  } else if(scripts\engine\utility::damagelocationisany("right_arm_upper")) {
    var_3[var_3.size] = ::scripts\asm\asm::asm_lookupanimfromalias(var_1, "pistol_right_arm_upper");
  } else if(scripts\engine\utility::damagelocationisany("right_arm_lower")) {
    var_3[var_3.size] = ::scripts\asm\asm::asm_lookupanimfromalias(var_1, "pistol_right_arm_lower");
  }

  if(var_3.size < 2) {
    var_3[var_3.size] = ::scripts\asm\asm::asm_lookupanimfromalias(var_1, "pistol_default");
  }

  return var_3[randomint(var_3.size)];
}

func_3EEB(var_0, var_1, var_2) {
  var_3 = 120;
  var_4 = 200;
  var_5 = 300;
  var_6 = [];
  var_7 = 0;
  var_8 = 0;
  var_9 = 0;
  if(self maymovetopoint(self gettweakablevalue((var_5, 0, 0)))) {
    var_8 = 1;
    var_7 = 1;
  } else if(self maymovetopoint(self gettweakablevalue((var_4, 0, 0)))) {
    var_7 = 1;
  }

  if(isDefined(self.a.var_55FD)) {
    var_8 = 0;
    var_7 = 0;
  }

  if(var_8) {
    var_6[var_6.size] = ::scripts\asm\asm::asm_lookupanimfromalias(var_1, "long");
  } else if(var_7) {
    var_6[var_6.size] = ::scripts\asm\asm::asm_lookupanimfromalias(var_1, "medium");
  } else if(self maymovetopoint(self gettweakablevalue((var_3, 0, 0)))) {
    var_6[var_6.size] = ::scripts\asm\asm::asm_lookupanimfromalias(var_1, "short");
  }

  if(var_6.size == 0) {
    return scripts\asm\asm::asm_lookupanimfromalias(var_1, "emergency_backup");
  }

  return var_6[randomint(var_6.size)];
}

func_3EE5(var_0, var_1, var_2) {
  if(isDefined(var_2) && isDefined(var_2[1])) {
    return scripts\asm\asm::asm_lookupanimfromalias(var_1, var_2[1]);
  }

  if(self.a.pose == "crouch") {
    return scripts\asm\asm::asm_lookupanimfromalias(var_1, "crouch");
  }

  return scripts\asm\asm::asm_lookupanimfromalias(var_1, "stand");
}

func_3ED3(var_0, var_1, var_2) {
  var_3 = "back";
  return scripts\asm\asm::asm_lookupanimfromalias(var_1, var_3);
}

func_3EE6(var_0, var_1, var_2) {
  var_3 = "crouch";
  if(isDefined(var_2)) {
    var_3 = var_3 + "_" + var_2;
  }

  return scripts\asm\asm::asm_lookupanimfromalias(var_1, var_3);
}

func_3ED4(var_0, var_1, var_2) {
  var_3 = [];
  if(scripts\engine\utility::damagelocationisany("torso_upper", "torso_lower")) {
    var_3[var_3.size] = ::scripts\asm\asm::asm_lookupanimfromalias(var_1, "torso");
  } else if(scripts\engine\utility::damagelocationisany("head", "helmet", "neck")) {
    var_3[var_3.size] = ::scripts\asm\asm::asm_lookupanimfromalias(var_1, "head");
  }

  if(var_3.size < 2) {
    var_3[var_3.size] = ::scripts\asm\asm::asm_lookupanimfromalias(var_1, "default");
  }

  return var_3[randomint(var_3.size)];
}

func_3EE7(var_0, var_1, var_2) {
  var_3 = "stand";
  if(isDefined(var_2) && isDefined(var_2)) {
    var_3 = var_3 + "_" + var_2;
  }

  return scripts\asm\asm::asm_lookupanimfromalias(var_1, var_3);
}

func_3ED5(var_0, var_1, var_2) {
  var_3 = [];
  if(scripts\engine\utility::damagelocationisany("torso_upper")) {
    var_3[var_3.size] = ::scripts\asm\asm::asm_lookupanimfromalias(var_1, "torso_upper");
  } else if(scripts\engine\utility::damagelocationisany("torso_lower")) {
    var_3[var_3.size] = ::scripts\asm\asm::asm_lookupanimfromalias(var_1, "torso_lower");
  } else if(scripts\engine\utility::damagelocationisany("head", "helmet", "neck")) {
    var_3[var_3.size] = ::scripts\asm\asm::asm_lookupanimfromalias(var_1, "head");
  } else if(scripts\engine\utility::damagelocationisany("right_arm_upper", "right_arm_lower")) {
    var_3[var_3.size] = ::scripts\asm\asm::asm_lookupanimfromalias(var_1, "right_arm");
  } else if(scripts\engine\utility::damagelocationisany("left_arm_upper", "left_arm_lower")) {
    var_3[var_3.size] = ::scripts\asm\asm::asm_lookupanimfromalias(var_1, "left_arm");
  } else if(scripts\engine\utility::damagelocationisany("left_leg_upper", "left_leg_lower", "left_foot")) {
    var_3[var_3.size] = ::scripts\asm\asm::asm_lookupanimfromalias(var_1, "left_leg");
  } else if(scripts\engine\utility::damagelocationisany("right_leg_upper", "right_leg_lower", "right_foot")) {
    var_3[var_3.size] = ::scripts\asm\asm::asm_lookupanimfromalias(var_1, "right_leg");
  }

  if(var_3.size < 2) {
    var_3[var_3.size] = ::scripts\asm\asm::asm_lookupanimfromalias(var_1, "default");
  }

  return var_3[randomint(var_3.size)];
}

func_3EEF(var_0, var_1, var_2) {
  var_3 = 3;
  var_4 = "deaf_" + randomint(var_3) + 1;
  return scripts\asm\asm::asm_lookupanimfromalias(var_1, var_4);
}

func_4109(var_0, var_1, var_2) {
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
    var_0 = level.var_A954 * level.var_A954 * 1.2 * 1.2;
    if(distancesquared(self.origin, level.var_A952) < var_0) {
      var_1 = var_0 * 0.5 * 0.5;
      self.var_B4DF = distancesquared(self.origin, level.var_A953) < var_1;
      return 1;
    }
  }

  return 0;
}