/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3174.gsc
**************************************/

_id_9DAD(var_0, var_1, var_2, var_3) {
  if(!self.damageshield)
    return scripts\engine\utility::damagelocationisany("right_arm_upper", "right_arm_lower", "right_hand");

  return 0;
}

_id_9DAE(var_0, var_1, var_2, var_3) {
  if(!self.damageshield)
    return scripts\engine\utility::damagelocationisany("right_leg_upper", "right_foot", "right_leg_lower");

  return 0;
}

_id_9DAC(var_0, var_1, var_2, var_3) {
  if(!self.damageshield)
    return scripts\engine\utility::damagelocationisany("left_leg_upper", "left_foot", "left_leg_lower");

  return 0;
}

_id_9DAA(var_0, var_1, var_2, var_3) {
  if(!self.damageshield)
    return scripts\engine\utility::damagelocationisany("left_arm_upper", "left_arm_lower", "left_hand");

  return 0;
}

_id_9DAF(var_0, var_1, var_2, var_3) {
  if(!self.damageshield)
    return scripts\engine\utility::damagelocationisany("torso_upper", "torso_lower");

  return 0;
}

_id_9DA9(var_0, var_1, var_2, var_3) {
  if(!self.damageshield)
    return scripts\engine\utility::damagelocationisany("head", "neck", "helmet");

  return 0;
}

_id_9DAB(var_0, var_1, var_2, var_3) {
  return scripts\engine\utility::damagelocationisany("left_hand", "left_arm_upper", "left_arm_lower", "left_leg_upper", "left_leg_lower", "left_foot", "torso_lower");
}

_id_9DA8(var_0, var_1, var_2, var_3) {
  if(!self.damageshield) {
    if(_id_0A1E::_id_7F08() == 1 && !scripts\engine\utility::damagelocationisany("left_leg_upper", "left_leg_lower", "left_foot", "right_leg_upper", "right_leg_lower", "right_foot"))
      return 1;
  }

  return 0;
}

_id_9DB0(var_0, var_1, var_2, var_3) {
  return scripts\engine\utility::damagelocationisany("right_arm_upper", "right_arm_lower", "right_hand", "left_hand", "left_arm_upper", "left_arm_lower", "left_leg_upper", "left_leg_lower", "left_foot", "right_leg_upper", "right_leg_lower", "right_foot", "torso_upper", "torso_lower");
}

_id_89E1() {
  self endon("death");
  self notify("new_secondary_pain");
  self endon("new_secondary_pain");
  self.asm._id_F0BC = 1;
  wait 0.5;
  self.asm._id_F0BC = 0;
}

_id_136E3(var_0, var_1) {
  self endon(var_1 + "_finished");

  for(;;) {
    self waittill("damage", var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11);

    if(!isalive(self)) {
      break;
    }

    var_12 = _id_3E95(var_0, var_1);
    self _meth_82AB(var_12, 1.0, 0.01, 1);
    thread _id_89E1();
    wait 0.35;
  }
}

_id_9F3A(var_0) {
  if(var_0 == 1)
    return 1;
  else
    return 0;
}

_id_3E95(var_0, var_1) {
  var_2 = [];

  if(scripts\engine\utility::damagelocationisany("torso_upper", "torso_lower"))
    var_2[var_2.size] = scripts\asm\asm::asm_lookupanimfromalias(var_1, "add_torso");
  else if(scripts\engine\utility::damagelocationisany("head", "helmet", "neck"))
    var_2[var_2.size] = scripts\asm\asm::asm_lookupanimfromalias(var_1, "add_head");
  else if(scripts\engine\utility::damagelocationisany("right_arm_upper", "right_arm_lower"))
    var_2[var_2.size] = scripts\asm\asm::asm_lookupanimfromalias(var_1, "add_right_arm");
  else if(scripts\engine\utility::damagelocationisany("left_arm_upper", "left_arm_lower"))
    var_2[var_2.size] = scripts\asm\asm::asm_lookupanimfromalias(var_1, "add_left_arm");
  else if(scripts\engine\utility::damagelocationisany("left_leg_upper", "left_leg_lower", "left_foot"))
    var_2[var_2.size] = scripts\asm\asm::asm_lookupanimfromalias(var_1, "add_left_leg");
  else if(scripts\engine\utility::damagelocationisany("right_leg_upper", "right_leg_lower", "right_foot"))
    var_2[var_2.size] = scripts\asm\asm::asm_lookupanimfromalias(var_1, "add_right_leg");

  if(var_2.size < 2)
    var_2[var_2.size] = scripts\asm\asm::asm_lookupanimfromalias(var_1, "add_default");

  return var_2[randomint(var_2.size)];
}

_id_3EF0(var_0, var_1, var_2) {
  return scripts\asm\asm::asm_lookupanimfromalias(var_1, "shock_loop_" + self.a.pose);
}

_id_D517(var_0, var_1, var_2, var_3) {
  self endon("death");
  self endon(var_1 + "_finished");
  var_4 = anim.asm[var_0].states[var_1]._id_71A5;
  var_5 = self[[var_4]](var_0, var_1, var_3);
  var_6 = scripts\engine\utility::ter_op(isDefined(self.empstartcallback), self.empstartcallback, 3.5);
  _id_0A1E::_id_D521();
  self animmode("zonly_physics", 0);
  wait(randomfloat(0.3));

  if(self.asmname == "c6" || self.asmname == "c6_worker") {
    thread _id_FE4E(self.asmname, var_1, var_2, 1, 0, 1);
    self playSound("generic_flashbang_c6_1");
  } else
    thread _id_FE4E(self.asmname, var_1, var_2, 1, 0);

  wait(var_6);
  self notify("painloop_end");
  scripts\asm\asm::asm_fireevent(var_1, "stop_loop_pain");
  self._id_61A9 = undefined;
  _id_6CE0(var_0, var_1, var_3);
}

_id_FE4D(var_0, var_1, var_2) {
  self stopsounds();
}

_id_FE4E(var_0, var_1, var_2, var_3, var_4, var_5) {
  self endon(var_1 + "_finished");
  self endon("painloop_end");
  var_6 = _id_0A1E::asm_getbodyknob();
  self clearanim(var_6, var_2);

  if(isDefined(var_4) && var_4) {
    if(scripts\asm\asm::asm_hasalias("Knobs", "move")) {
      var_7 = _id_0A1E::_id_2356("Knobs", "move");
      self _meth_84F2(var_7);
    }
  }

  var_8 = var_6;
  var_9 = _id_0A1E::asm_getallanimsforstate(var_0, var_1);

  for(;;) {
    if(isDefined(var_5))
      var_9 = _id_0A1E::asm_getallanimsforstate(var_0, var_1);

    self _meth_82E7(var_1, var_9, 1.0, var_2, var_3);
    _id_0A1E::_id_2369(var_0, var_1, var_9);
    var_8 = var_9;
    _id_0A1E::_id_2320(var_0, var_1, var_9, scripts\asm\asm::_id_2341(var_0, var_1));
  }
}

_id_3EF7(var_0, var_1, var_2, var_3) {
  return scripts\asm\asm::asm_lookupanimfromalias(var_1, "shock_finish_" + self.a.pose);
}

_id_D4EE(var_0, var_1, var_2, var_3) {
  _id_D4F1(var_0, var_1, var_2, var_3, 0);
}

_id_D4F4(var_0, var_1, var_2, var_3) {
  _id_D4F1(var_0, var_1, var_2, var_3, 1);
}

_id_D4F2(var_0, var_1, var_2, var_3) {
  self._blackboard._id_98F4 = 1;
  _id_D4F1(var_0, var_1, var_2, var_3, 0);
}

_id_C860(var_0, var_1) {
  if(var_0 == "pain_can_end")
    return 1;
}

_id_6374(var_0, var_1, var_2) {
  self endon(var_1 + "_finished");

  while(isDefined(self.asm._id_F0BC) && self.asm._id_F0BC)
    wait 0.05;

  scripts\asm\asm::asm_fireevent(var_1, "end");
  _id_6CE0(var_0, var_1, var_2);
  self notify(var_1 + "_finished");
  return;
}

_id_D4F1(var_0, var_1, var_2, var_3, var_4, var_5) {
  self endon(var_1 + "_finished");

  if(isDefined(self.a._id_C888))
    self.a._id_A9C8 = self.a._id_C888;
  else
    self.a._id_A9C8 = 0;

  self.a._id_C888 = gettime();

  if(self.stairsstate != "none")
    self.a._id_C87B = 1;
  else
    self.a._id_C87B = undefined;

  if(isDefined(self._id_9E33)) {
    scripts\anim\combat_utility::_id_5D29();
    self._id_9E33 = undefined;
  }

  self animmode("gravity");

  if(!isDefined(self._id_C006))
    scripts\anim\face::saygenericdialogue("pain");

  if(_id_0C60::_id_10025(_id_1390C()))
    _id_0C60::_id_8E17();

  var_6 = anim.asm[var_0].states[var_1]._id_71A5;
  var_7 = self[[var_6]](var_0, var_1, var_3);
  self _meth_82E4(var_1, var_7, _id_0A1E::asm_getbodyknob(), 1, var_2, 1);

  if(var_4 == 1) {
    self.asm._id_F0BC = 0;
    thread _id_136E3(var_0, var_1);
  }

  _id_0A1E::_id_2369(var_0, var_1, var_7);

  if(animhasnotetrack(var_7, "pain_can_end")) {
    var_8 = getnotetracktimes(var_7, "pain_can_end");
    var_9 = getanimlength(var_7);
    wait(var_9 * var_8[0]);
    thread _id_6374(var_0, var_1, var_3);
  }

  if(animhasnotetrack(var_7, "code_move"))
    _id_0A1E::_id_231F(var_0, var_1);

  _id_0A1E::_id_231F(var_0, var_1);
  _id_6CE0(var_0, var_1, var_3, var_5);
}

_id_C872(var_0, var_1) {
  switch (var_1) {
    case "pain_can_end":
      return 1;
  }
}

_id_6CE0(var_0, var_1, var_2, var_3) {
  self notify("killanimscript");
  var_4 = anim.asm[var_0].states[var_1];

  if(isDefined(self.asm._id_F0BC))
    self.asm._id_F0BC = undefined;

  var_5 = undefined;

  if(!isDefined(var_3) || !var_3) {
    if(isarray(var_2))
      var_5 = var_2[0];
    else
      var_5 = var_2;
  }

  if(!isDefined(var_5)) {
    if(isDefined(var_4.transitions) && var_4.transitions.size > 0) {
      return;
    }
    var_5 = "exposed_idle";
  }

  thread scripts\asm\asm::asm_setstate(var_5, undefined);
}

_id_CF05(var_0, var_1, var_2, var_3) {
  self.keepclaimednodeifvalid = 1;
  _id_D4F1(var_0, var_1, var_2, var_3, 1);
}

_id_CF04(var_0, var_1, var_2, var_3) {
  self.keepclaimednodeifvalid = 1;
  _id_D4EE(var_0, var_1, var_2, var_3);
}

_id_100B7() {
  if(self.damageshield && !isDefined(self._id_55BF)) {
    if(self.a.pose == "prone")
      return 0;

    if(isDefined(self.lastattacker) && isDefined(self.lastattacker.team) && self.lastattacker.team == self.team)
      return 0;

    if(self.damageshieldcounter > 0)
      return 0;

    return 1;
  }

  return 0;
}

_id_FFE0(var_0, var_1, var_2, var_3) {
  if(isDefined(self.damageshield) && self.damageshield && !isDefined(self._id_55BF)) {
    if(isDefined(self.lastattacker) && isDefined(self.lastattacker.unittype) && self.lastattacker.unittype == "c8" && isDefined(self.damageweapon) && weaponisbeam(self.damageweapon))
      return 1;
  }

  return 0;
}

_id_D4EF(var_0, var_1, var_2, var_3) {
  self.asm._id_2AD2 = 1;
  _id_D4F1(var_0, var_1, var_2, var_3, 0, 1);
}

_id_D4F0(var_0, var_1, var_2) {
  self.asm._id_2AD2 = undefined;
}

_id_3E9D(var_0, var_1, var_2) {
  return [[self._id_7193]](var_1, "pain");
}

_id_3EEE(var_0, var_1, var_2) {
  if(self.lasttorsoanim == "torso_upper")
    var_3 = scripts\asm\asm::asm_lookupanimfromalias(var_1, "torso_upper");
  else if(self.lasttorsoanim == "torso_lower")
    var_3 = scripts\asm\asm::asm_lookupanimfromalias(var_1, "torso_lower");
  else
    var_3 = scripts\asm\asm::asm_lookupanimfromalias(var_1, "default");

  self.lasttorsoanim = undefined;
  return var_3;
}

_id_3EED(var_0, var_1, var_2) {
  if(scripts\engine\utility::damagelocationisany("torso_upper")) {
    self.lasttorsoanim = "torso_upper";
    return scripts\asm\asm::asm_lookupanimfromalias(var_1, "torso_upper");
  } else if(scripts\engine\utility::damagelocationisany("torso_lower")) {
    self.lasttorsoanim = "torso_lower";
    return scripts\asm\asm::asm_lookupanimfromalias(var_1, "torso_lower");
  } else {
    self.lasttorsoanim = "default";
    return scripts\asm\asm::asm_lookupanimfromalias(var_1, "default");
  }
}

_id_3EEC(var_0, var_1, var_2) {
  if(_id_100B7()) {
    if(self.a.pose == "crouch")
      return scripts\asm\asm::asm_lookupanimfromalias(var_1, "damage_shield_crouch");
    else if(self.a.pose == "stand")
      return scripts\asm\asm::asm_lookupanimfromalias(var_1, "damage_shield_stand");
  }

  if(scripts\anim\utility_common::isusingsidearm())
    return _id_3EEA(var_0, var_1, var_2);

  var_3 = [];

  if(scripts\engine\utility::damagelocationisany("torso_upper"))
    var_3[var_3.size] = scripts\asm\asm::asm_lookupanimfromalias(var_1, "torso_upper");
  else if(scripts\engine\utility::damagelocationisany("torso_lower"))
    var_3[var_3.size] = scripts\asm\asm::asm_lookupanimfromalias(var_1, "torso_lower");
  else if(scripts\engine\utility::damagelocationisany("head", "helmet", "neck"))
    var_3[var_3.size] = scripts\asm\asm::asm_lookupanimfromalias(var_1, "head");
  else if(scripts\engine\utility::damagelocationisany("right_arm_upper", "right_arm_lower"))
    var_3[var_3.size] = scripts\asm\asm::asm_lookupanimfromalias(var_1, "right_arm");
  else if(scripts\engine\utility::damagelocationisany("left_arm_upper", "left_arm_lower"))
    var_3[var_3.size] = scripts\asm\asm::asm_lookupanimfromalias(var_1, "left_arm");
  else if(scripts\engine\utility::damagelocationisany("left_leg_upper", "left_leg_lower", "left_foot"))
    var_3[var_3.size] = scripts\asm\asm::asm_lookupanimfromalias(var_1, "left_leg");
  else if(scripts\engine\utility::damagelocationisany("right_leg_upper", "right_leg_lower", "right_foot"))
    var_3[var_3.size] = scripts\asm\asm::asm_lookupanimfromalias(var_1, "right_leg");

  if(var_3.size < 2)
    var_3[var_3.size] = scripts\asm\asm::asm_lookupanimfromalias(var_1, "default");

  return var_3[randomint(var_3.size)];
}

_id_3EE9(var_0, var_1, var_2) {
  if(_id_100B7()) {
    if(self.a.pose == "crouch")
      return scripts\asm\asm::asm_lookupanimfromalias(var_1, "damage_shield_crouch");
    else if(self.a.pose == "stand")
      return scripts\asm\asm::asm_lookupanimfromalias(var_1, "damage_shield_stand");
  }

  var_3 = [];

  if(var_3.size < 2)
    var_3[var_3.size] = scripts\asm\asm::asm_lookupanimfromalias(var_1, "default");

  return var_3[randomint(var_3.size)];
}

_id_3ED6(var_0, var_1, var_2) {
  var_3 = [];
  var_3[var_3.size] = scripts\asm\asm::asm_lookupanimfromalias(var_1, "default");
  return var_3[randomint(var_3.size)];
}

_id_3EE8(var_0, var_1, var_2) {
  var_3 = [];
  var_3[var_3.size] = scripts\asm\asm::asm_lookupanimfromalias(var_1, "default");

  if(scripts\engine\utility::damagelocationisany("left_hand", "left_arm_lower", "left_arm_upper"))
    var_3[var_3.size] = scripts\asm\asm::asm_lookupanimfromalias(var_1, "left_arm");

  if(scripts\engine\utility::damagelocationisany("right_hand", "right_arm_lower", "right_arm_upper"))
    var_3[var_3.size] = scripts\asm\asm::asm_lookupanimfromalias(var_1, "right_arm");

  return var_3[randomint(var_3.size)];
}

_id_3EEA(var_0, var_1, var_2) {
  var_3 = [];

  if(scripts\engine\utility::damagelocationisany("torso_upper"))
    var_3[var_3.size] = scripts\asm\asm::asm_lookupanimfromalias(var_1, "pistol_torso_upper");
  else if(scripts\engine\utility::damagelocationisany("torso_lower"))
    var_3[var_3.size] = scripts\asm\asm::asm_lookupanimfromalias(var_1, "pistol_torso_lower");
  else if(scripts\engine\utility::damagelocationisany("neck"))
    var_3[var_3.size] = scripts\asm\asm::asm_lookupanimfromalias(var_1, "pistol_neck");
  else if(scripts\engine\utility::damagelocationisany("head"))
    var_3[var_3.size] = scripts\asm\asm::asm_lookupanimfromalias(var_1, "pistol_head");
  else if(scripts\engine\utility::damagelocationisany("left_leg_upper", "right_leg_upper"))
    var_3[var_3.size] = scripts\asm\asm::asm_lookupanimfromalias(var_1, "pistol_leg");
  else if(scripts\engine\utility::damagelocationisany("left_arm_upper"))
    var_3[var_3.size] = scripts\asm\asm::asm_lookupanimfromalias(var_1, "pistol_left_arm_upper");
  else if(scripts\engine\utility::damagelocationisany("left_arm_lower"))
    var_3[var_3.size] = scripts\asm\asm::asm_lookupanimfromalias(var_1, "pistol_left_arm_lower");
  else if(scripts\engine\utility::damagelocationisany("right_arm_upper"))
    var_3[var_3.size] = scripts\asm\asm::asm_lookupanimfromalias(var_1, "pistol_right_arm_upper");
  else if(scripts\engine\utility::damagelocationisany("right_arm_lower"))
    var_3[var_3.size] = scripts\asm\asm::asm_lookupanimfromalias(var_1, "pistol_right_arm_lower");

  if(var_3.size < 2)
    var_3[var_3.size] = scripts\asm\asm::asm_lookupanimfromalias(var_1, "pistol_default");

  return var_3[randomint(var_3.size)];
}

_id_3EEB(var_0, var_1, var_2) {
  var_3 = 120;
  var_4 = 200;
  var_5 = 300;
  var_6 = [];
  var_7 = 0;
  var_8 = 0;
  var_9 = 0;

  if(self maymovetopoint(self localtoworldcoords((var_5, 0, 0)))) {
    var_8 = 1;
    var_7 = 1;
  } else if(self maymovetopoint(self localtoworldcoords((var_4, 0, 0))))
    var_7 = 1;

  if(isDefined(self.a._id_55FD)) {
    var_8 = 0;
    var_7 = 0;
  }

  if(var_8)
    var_6[var_6.size] = scripts\asm\asm::asm_lookupanimfromalias(var_1, "long");
  else if(var_7)
    var_6[var_6.size] = scripts\asm\asm::asm_lookupanimfromalias(var_1, "medium");
  else if(self maymovetopoint(self localtoworldcoords((var_3, 0, 0))))
    var_6[var_6.size] = scripts\asm\asm::asm_lookupanimfromalias(var_1, "short");

  if(var_6.size == 0)
    return scripts\asm\asm::asm_lookupanimfromalias(var_1, "emergency_backup");

  return var_6[randomint(var_6.size)];
}

_id_3EE5(var_0, var_1, var_2) {
  if(isDefined(var_2) && isDefined(var_2[1]))
    return scripts\asm\asm::asm_lookupanimfromalias(var_1, var_2[1]);

  if(self.a.pose == "crouch")
    return scripts\asm\asm::asm_lookupanimfromalias(var_1, "crouch");
  else
    return scripts\asm\asm::asm_lookupanimfromalias(var_1, "stand");
}

_id_3ED3(var_0, var_1, var_2) {
  var_3 = "back";
  return scripts\asm\asm::asm_lookupanimfromalias(var_1, var_3);
}

_id_3EE6(var_0, var_1, var_2) {
  var_3 = "crouch";

  if(isDefined(var_2))
    var_3 = var_3 + "_" + var_2;

  return scripts\asm\asm::asm_lookupanimfromalias(var_1, var_3);
}

_id_3ED4(var_0, var_1, var_2) {
  var_3 = [];

  if(scripts\engine\utility::damagelocationisany("torso_upper", "torso_lower"))
    var_3[var_3.size] = scripts\asm\asm::asm_lookupanimfromalias(var_1, "torso");
  else if(scripts\engine\utility::damagelocationisany("head", "helmet", "neck"))
    var_3[var_3.size] = scripts\asm\asm::asm_lookupanimfromalias(var_1, "head");

  if(var_3.size < 2)
    var_3[var_3.size] = scripts\asm\asm::asm_lookupanimfromalias(var_1, "default");

  return var_3[randomint(var_3.size)];
}

_id_3EE7(var_0, var_1, var_2) {
  var_3 = "stand";

  if(isDefined(var_2) && isDefined(var_2))
    var_3 = var_3 + "_" + var_2;

  return scripts\asm\asm::asm_lookupanimfromalias(var_1, var_3);
}

_id_3ED5(var_0, var_1, var_2) {
  var_3 = [];

  if(scripts\engine\utility::damagelocationisany("torso_upper"))
    var_3[var_3.size] = scripts\asm\asm::asm_lookupanimfromalias(var_1, "torso_upper");
  else if(scripts\engine\utility::damagelocationisany("torso_lower"))
    var_3[var_3.size] = scripts\asm\asm::asm_lookupanimfromalias(var_1, "torso_lower");
  else if(scripts\engine\utility::damagelocationisany("head", "helmet", "neck"))
    var_3[var_3.size] = scripts\asm\asm::asm_lookupanimfromalias(var_1, "head");
  else if(scripts\engine\utility::damagelocationisany("right_arm_upper", "right_arm_lower"))
    var_3[var_3.size] = scripts\asm\asm::asm_lookupanimfromalias(var_1, "right_arm");
  else if(scripts\engine\utility::damagelocationisany("left_arm_upper", "left_arm_lower"))
    var_3[var_3.size] = scripts\asm\asm::asm_lookupanimfromalias(var_1, "left_arm");
  else if(scripts\engine\utility::damagelocationisany("left_leg_upper", "left_leg_lower", "left_foot"))
    var_3[var_3.size] = scripts\asm\asm::asm_lookupanimfromalias(var_1, "left_leg");
  else if(scripts\engine\utility::damagelocationisany("right_leg_upper", "right_leg_lower", "right_foot"))
    var_3[var_3.size] = scripts\asm\asm::asm_lookupanimfromalias(var_1, "right_leg");

  if(var_3.size < 2)
    var_3[var_3.size] = scripts\asm\asm::asm_lookupanimfromalias(var_1, "default");

  return var_3[randomint(var_3.size)];
}

_id_3EEF(var_0, var_1, var_2) {
  var_3 = 3;
  var_4 = "deaf_" + (randomint(var_3) + 1);
  return scripts\asm\asm::asm_lookupanimfromalias(var_1, var_4);
}

_id_4109(var_0, var_1, var_2) {
  if(self.script == "pain")
    self notify("killanimscript");

  if(isDefined(self._id_4D6A)) {
    self.damageshieldcounter = undefined;
    self._id_4D6A = undefined;
    self.allowpain = 1;

    if(!isDefined(self._id_D817))
      self.ignoreme = 0;

    self._id_D817 = undefined;
  }

  if(isDefined(self._id_2BB9)) {
    self._id_2BB9 = undefined;
    self.allowpain = 1;
  }
}

_id_1390C() {
  if(isexplosivedamagemod(self.damagemod))
    return 1;

  if(gettime() - anim._id_A955 <= 50) {
    var_0 = anim._id_A954 * anim._id_A954 * 1.2 * 1.2;

    if(distancesquared(self.origin, anim._id_A952) < var_0) {
      var_1 = var_0 * 0.5 * 0.5;
      self._id_B4DF = distancesquared(self.origin, anim._id_A953) < var_1;
      return 1;
    }
  }

  return 0;
}