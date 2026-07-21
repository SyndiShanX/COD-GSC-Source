/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: asm\soldier\pain.gsc
***********************************************/

isdamagelocation_rarm(var_0, var_1, var_2, var_3) {
  if(!self.damageshield)
    return scripts\engine\utility::damagelocationisany("right_arm_upper", "right_arm_lower", "right_hand");

  return 0;
}

isdamagelocation_rleg(var_0, var_1, var_2, var_3) {
  if(!self.damageshield)
    return scripts\engine\utility::damagelocationisany("right_leg_upper", "right_foot", "right_leg_lower");

  return 0;
}

isdamagelocation_lleg(var_0, var_1, var_2, var_3) {
  if(!self.damageshield)
    return scripts\engine\utility::damagelocationisany("left_leg_upper", "left_foot", "left_leg_lower");

  return 0;
}

isdamagelocation_larm(var_0, var_1, var_2, var_3) {
  if(!self.damageshield)
    return scripts\engine\utility::damagelocationisany("left_arm_upper", "left_arm_lower", "left_hand");

  return 0;
}

isdamagelocation_torso(var_0, var_1, var_2, var_3) {
  if(!self.damageshield)
    return scripts\engine\utility::damagelocationisany("torso_upper", "torso_lower");

  return 0;
}

isdamagelocation_head(var_0, var_1, var_2, var_3) {
  if(!self.damageshield)
    return scripts\engine\utility::damagelocationisany("head", "neck", "helmet");

  return 0;
}

isdamagelocation_larmcrouch(var_0, var_1, var_2, var_3) {
  return scripts\engine\utility::damagelocationisany("left_hand", "left_arm_upper", "left_arm_lower", "left_leg_upper", "left_leg_lower", "left_foot", "torso_lower");
}

isdamagelocation_back(var_0, var_1, var_2, var_3) {
  if(!self.damageshield) {
    if(scripts\asm\shared\utility::gethumandamagedirstring() == 1 && !scripts\engine\utility::damagelocationisany("left_leg_upper", "left_leg_lower", "left_foot", "right_leg_upper", "right_leg_lower", "right_foot"))
      return 1;
  }

  return 0;
}

isdamagelocation_torsocovercrouch(var_0, var_1, var_2, var_3) {
  return scripts\engine\utility::damagelocationisany("right_arm_upper", "right_arm_lower", "right_hand", "left_hand", "left_arm_upper", "left_arm_lower", "left_leg_upper", "left_leg_lower", "left_foot", "right_leg_upper", "right_leg_lower", "right_foot", "torso_upper", "torso_lower");
}

handlesecondarypainflag() {
  self endon("death");
  self notify("new_secondary_pain");
  self endon("new_secondary_pain");
  self.asm.secondarypainactive = 1;
  wait 0.5;
  self.asm.secondarypainactive = 0;
}

waitforsecondarypain(var_0, var_1) {
  self endon(var_1 + "_finished");

  for(;;) {
    self waittill("damage");

    if(!isalive(self)) {
      break;
    }

    var_2 = chooseadditivepainanim_stand(var_0, var_1);
    var_3 = scripts\asm\asm::asm_getxanim(var_1, var_2);
    self aisetanimknobrestart(var_3, 1.0, 0.01, 1);
    thread handlesecondarypainflag();
    wait 0.35;
  }
}

chooseadditivepainanim_stand(var_0, var_1) {
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

choosepainanimshock(var_0, var_1, var_2) {
  return scripts\asm\asm::asm_lookupanimfromalias(var_1, "shock_loop_" + self.currentpose);
}

playsonicshockfx() {
  if(scripts\common\utility::isdamageweapon(getcompleteweaponname("iw7_sonic")) && scripts\common\utility::isweaponepic(self.damageweapon)) {
    playFXOnTag(level.g_effect["soldier_shock"], self, "j_knee_ri");
    playFXOnTag(level.g_effect["soldier_shock"], self, "j_shoulder_ri");
  }
}

playshockpainloop(var_0, var_1, var_2) {
  self endon("death");
  self endon(var_1 + "_finished");
  var_3 = scripts\asm\asm::asm_getanim(var_0, var_1);
  var_4 = scripts\engine\utility::ter_op(isDefined(self.empstuntime), self.empstuntime, 3.5);
  playsonicshockfx();
  self animmode("zonly_physics", 0);
  wait(randomfloat(0.3));

  if(self.asmname == "c6" || self.asmname == "c6_worker") {
    thread shockpainloop_internal(self.asmname, var_1, 1, 0, 1);
    self playSound("generic_flashbang_c6_1");
  } else
    thread shockpainloop_internal(self.asmname, var_1, 1, 0);

  wait(var_4);
  self notify("painloop_end");
  scripts\asm\asm::asm_fireevent(var_0, "stop_loop_pain");
  self.emplooptime = undefined;
  finishpain(var_0, var_1, var_2);
}

shockpainloop_c6_cleanup(var_0, var_1, var_2) {
  self stopsounds();
}

shockpainloop_internal(var_0, var_1, var_2, var_3, var_4) {
  self endon(var_1 + "_finished");
  self endon("painloop_end");

  if(isDefined(var_3) && var_3) {
    var_5 = scripts\asm\asm::asm_lookupanimfromaliasifexists("knobs", "move");

    if(isDefined(var_5))
      self setmoveanimknob(var_5);
  }

  var_6 = scripts\asm\asm::asm_getbodyknob();
  var_7 = scripts\asm\asm::asm_getanim(var_0, var_1);

  for(;;) {
    if(isDefined(var_4))
      var_7 = scripts\asm\asm::asm_getanim(var_0, var_1);

    var_8 = scripts\asm\asm::asm_getxanim(var_1, var_7);
    self aisetanim(var_1, var_7, var_2);
    scripts\asm\asm::asm_playfacialanim(var_0, var_1, var_8);
    var_6 = var_7;
    scripts\asm\asm::asm_donotetrackssingleloop(var_0, var_1, var_8, scripts\asm\asm::asm_getnotehandler(var_0, var_1));
  }
}

chooseshockpainrecovery(var_0, var_1, var_2) {
  return scripts\asm\asm::asm_lookupanimfromalias(var_1, "shock_finish_" + self.currentpose);
}

playpainanim(var_0, var_1, var_2) {
  playpainaniminternal(var_0, var_1, var_2, 0);
}

playpainanimwithadditives(var_0, var_1, var_2) {
  playpainaniminternal(var_0, var_1, var_2, 1);
}

playpainanimlmg(var_0, var_1, var_2) {
  self._blackboard.inlmgstate = 1;
  playpainaniminternal(var_0, var_1, var_2, 0);
}

pain_can_use_handler(var_0, var_1) {
  if(var_0 == "pain_can_end")
    return 1;
}

shouldpainruntostrafereverse(var_0, var_1, var_2, var_3) {
  if(!isDefined(self.pathgoalpos))
    return 0;

  if(self pathdisttogoal() < 36)
    return 0;

  var_4 = length(self.velocity);

  if(var_4 < 20)
    return 0;

  var_5 = self.velocity / var_4;

  if(self.lookaheaddist > 12)
    var_6 = self.lookaheaddir;
  else
    var_6 = vectorNormalize(self getposonpath(36) - self.origin);

  return vectordot(var_6, var_5) < 0.5;
}

ispainweaponsizelarge(var_0, var_1, var_2, var_3) {
  var_4 = "rifle";
  var_5 = self.damageweapon;

  if(isDefined(var_5) && var_5.basename != "iw8_sn_mike14")
    var_4 = var_5.classname;

  if(var_4 == "spread") {
    if(isDefined(self.lastattacker) && distancesquared(self.lastattacker.origin, self.origin) <= 62500)
      return 1;
  } else if(var_4 == "sniper" || var_4 == "mg")
    return 1;

  return 0;
}

getpainweaponsize() {
  var_0 = "_md";
  var_1 = "rifle";
  var_2 = self.damageweapon;

  if(isDefined(var_2) && var_2.basename != "iw8_sn_mike14")
    var_1 = var_2.classname;

  if(var_1 == "pistol" || var_1 == "smg")
    var_0 = "_md";
  else if(var_1 == "spread") {
    var_0 = "_md";

    if(isDefined(self.lastattacker) && distancesquared(self.lastattacker.origin, self.origin) <= 62500)
      var_0 = "_lg";
  } else if(var_1 == "sniper" || var_1 == "mg")
    var_0 = "_lg";
  else if(var_1 == "grenade" && isDefined(self.damagemod) && self.damagemod == "MOD_IMPACT")
    var_0 = "_lg";

  if(isDefined(level.fnasmsoldiergetpainweaponsize))
    var_0 = self[[level.fnasmsoldiergetpainweaponsize]](var_0);

  return var_0;
}

getpainweaponsize_exposed() {
  var_0 = "_md";
  var_1 = "rifle";
  var_2 = self.damageweapon;

  if(isDefined(var_2) && var_2.basename != "iw8_sn_mike14")
    var_1 = var_2.classname;

  if(var_1 == "pistol" || var_1 == "smg")
    var_0 = "_md";
  else if(var_1 == "spread") {
    var_0 = "_md";

    if(isDefined(self.lastattacker) && distancesquared(self.lastattacker.origin, self.origin) <= 62500)
      var_0 = "_lg";
  } else if(var_1 == "sniper" || var_1 == "mg")
    var_0 = "_lg";

  if(isDefined(level.fnasmsoldiergetpainweaponsize))
    var_0 = self[[level.fnasmsoldiergetpainweaponsize]](var_0);

  return var_0;
}

getpaindirectiontoactor() {
  if(isDefined(self.damageyaw) && self.damageyaw >= -45 && self.damageyaw <= 45) {
    var_0 = "_b";
    return var_0;
  } else if(isDefined(self.damageyaw) && self.damageyaw < -45 && self.damageyaw > -135) {
    var_0 = "_l";
    return var_0;
  } else if(isDefined(self.damageyaw) && self.damageyaw > 45 && self.damageyaw < 135) {
    var_0 = "_r";
    return var_0;
  } else {
    var_0 = "_f";
    return var_0;
  }
}

choosedirectionalpainanim_exposedstand(var_0, var_1, var_2) {
  var_3 = getpainweaponsize();
  var_4 = getpaindirectiontoactor();
  var_5 = "torso";
  var_6 = "midbody";
  var_7 = [];

  if(scripts\engine\utility::damagelocationisany("head", "helmet", "neck")) {
    var_5 = "head";
    var_6 = "head";
    var_7[var_7.size] = scripts\asm\asm::asm_lookupanimfromalias(var_1, "head" + var_3 + var_4);
  } else if(scripts\engine\utility::damagelocationisany("torso_upper", "torso_lower")) {
    var_5 = "torso";
    var_6 = "midbody";
    var_7[var_7.size] = scripts\asm\asm::asm_lookupanimfromalias(var_1, "torso" + var_3 + var_4);
  } else if(scripts\engine\utility::damagelocationisany("right_arm_upper", "right_arm_lower", "right_hand")) {
    var_5 = "rarm";
    var_6 = "midbody";
    var_7[var_7.size] = scripts\asm\asm::asm_lookupanimfromalias(var_1, "rarm" + var_3 + var_4);
  } else if(scripts\engine\utility::damagelocationisany("left_arm_upper", "left_arm_lower", "left_hand")) {
    var_5 = "larm";
    var_6 = "midbody";
    var_7[var_7.size] = scripts\asm\asm::asm_lookupanimfromalias(var_1, "larm" + var_3 + var_4);
  } else if(scripts\engine\utility::damagelocationisany("left_leg_upper", "left_leg_lower", "left_foot")) {
    var_5 = "lleg";
    var_6 = "lowerbody";
    var_7[var_7.size] = scripts\asm\asm::asm_lookupanimfromalias(var_1, "lleg" + var_3 + var_4);
  } else if(scripts\engine\utility::damagelocationisany("right_leg_upper", "right_leg_lower", "right_foot")) {
    var_5 = "rleg";
    var_6 = "lowerbody";
    var_7[var_7.size] = scripts\asm\asm::asm_lookupanimfromalias(var_1, "rleg" + var_3 + var_4);
  } else {
    var_5 = "torso";
    var_6 = "midbody";
    var_7[var_7.size] = scripts\asm\asm::asm_lookupanimfromalias(var_1, "torso" + var_3 + var_4);
  }

  var_8 = var_5 + var_3 + var_4;
  var_9 = "_2";

  if(var_4 == "_b")
    var_9 = "_8";
  else if(var_4 == "_l")
    var_9 = "_6";
  else if(var_4 == "_r")
    var_9 = "_4";

  self.asm.aliaspain = var_8;
  self.asm.painloc = var_6;
  self.asm.painsize = var_3;
  return var_7[randomint(var_7.size)];
}

choosedirectionalfullpainanim_exposedstand(var_0, var_1, var_2) {
  var_3 = getpaindirectiontoactor();
  var_4 = "torso";
  var_5 = "midbody";
  var_6 = [];

  if(scripts\engine\utility::damagelocationisany("head", "helmet", "neck")) {
    var_4 = "head";
    var_5 = "head";
    var_6[var_6.size] = scripts\asm\asm::asm_lookupanimfromalias(var_1, "head" + var_3);
  } else if(scripts\engine\utility::damagelocationisany("torso_upper")) {
    var_4 = "torso_upper";
    var_5 = "midbody";
    var_6[var_6.size] = scripts\asm\asm::asm_lookupanimfromalias(var_1, "torso_upper" + var_3);
  } else if(scripts\engine\utility::damagelocationisany("torso_lower")) {
    var_4 = "torso_lower";
    var_5 = "midbody";
    var_6[var_6.size] = scripts\asm\asm::asm_lookupanimfromalias(var_1, "torso_lower" + var_3);
  } else if(scripts\engine\utility::damagelocationisany("right_arm_upper")) {
    var_4 = "rarm_upper";
    var_5 = "midbody";
    var_6[var_6.size] = scripts\asm\asm::asm_lookupanimfromalias(var_1, "rarm_upper" + var_3);
  } else if(scripts\engine\utility::damagelocationisany("right_arm_lower", "right_hand")) {
    var_4 = "rarm_lower";
    var_5 = "midbody";
    var_6[var_6.size] = scripts\asm\asm::asm_lookupanimfromalias(var_1, "rarm_lower" + var_3);
  } else if(scripts\engine\utility::damagelocationisany("left_arm_upper")) {
    var_4 = "larm_upper";
    var_5 = "midbody";
    var_6[var_6.size] = scripts\asm\asm::asm_lookupanimfromalias(var_1, "larm_upper" + var_3);
  } else if(scripts\engine\utility::damagelocationisany("left_arm_lower", "left_hand")) {
    var_4 = "larm_lower";
    var_5 = "midbody";
    var_6[var_6.size] = scripts\asm\asm::asm_lookupanimfromalias(var_1, "larm_lower" + var_3);
  } else if(scripts\engine\utility::damagelocationisany("left_leg_upper")) {
    var_4 = "lleg_upper";
    var_5 = "lowerbody";
    var_6[var_6.size] = scripts\asm\asm::asm_lookupanimfromalias(var_1, "lleg_upper" + var_3);
  } else if(scripts\engine\utility::damagelocationisany("left_leg_lower", "left_foot")) {
    var_4 = "lleg_lower";
    var_5 = "lowerbody";
    var_6[var_6.size] = scripts\asm\asm::asm_lookupanimfromalias(var_1, "lleg_lower" + var_3);
  } else if(scripts\engine\utility::damagelocationisany("right_leg_upper")) {
    var_4 = "rleg_upper";
    var_5 = "lowerbody";
    var_6[var_6.size] = scripts\asm\asm::asm_lookupanimfromalias(var_1, "rleg_upper" + var_3);
  } else if(scripts\engine\utility::damagelocationisany("right_leg_lower", "right_foot")) {
    var_4 = "rleg_lower";
    var_5 = "lowerbody";
    var_6[var_6.size] = scripts\asm\asm::asm_lookupanimfromalias(var_1, "rleg_lower" + var_3);
  } else {
    var_4 = "torso_lower";
    var_5 = "midbody";
    var_6[var_6.size] = scripts\asm\asm::asm_lookupanimfromalias(var_1, "torso_lower" + var_3);
  }

  var_7 = var_4 + var_3;
  var_8 = "_2";

  if(var_3 == "_b")
    var_8 = "_8";
  else if(var_3 == "_l")
    var_8 = "_6";
  else if(var_3 == "_r")
    var_8 = "_4";

  self.asm.aliaspain = var_7;
  self.asm.painloc = var_5;
  return var_6[randomint(var_6.size)];
}

choosedirectionalpainanim_transition(var_0, var_1, var_2) {
  if(isDefined(self.asm.aliaspain)) {
    var_3 = self.asm.aliaspain;
    return scripts\asm\asm::asm_lookupanimfromalias(var_1, var_3);
  }

  return scripts\asm\asm::asm_getrandomanim(var_1);
}

choosedirectionalpainanim_coverstand(var_0, var_1, var_2) {
  var_3 = getpainweaponsize();
  var_4 = getpaindirectiontoactor();
  var_5 = "torso";
  var_6 = "midbody";
  var_7 = [];

  if(scripts\engine\utility::damagelocationisany("head", "helmet", "neck")) {
    var_5 = "head";
    var_6 = "head";
    var_7[var_7.size] = scripts\asm\asm::asm_lookupanimfromalias(var_1, "head" + var_3 + var_4);
  } else if(scripts\engine\utility::damagelocationisany("left_leg_upper", "left_leg_lower", "left_foot", "right_leg_upper", "right_leg_lower", "right_foot")) {
    var_5 = "legs";
    var_6 = "lowerbody";
    var_7[var_7.size] = scripts\asm\asm::asm_lookupanimfromalias(var_1, "legs" + var_3 + var_4);
  } else {
    var_5 = "torso";
    var_6 = "midbody";
    var_7[var_7.size] = scripts\asm\asm::asm_lookupanimfromalias(var_1, "torso" + var_3 + var_4);
  }

  var_8 = var_5 + var_3 + var_4;
  var_9 = "_2";

  if(var_4 == "_b")
    var_9 = "_8";
  else if(var_4 == "_l")
    var_9 = "_6";
  else if(var_4 == "_r")
    var_9 = "_4";

  self.asm.aliaspain = var_8;
  self.asm.painloc = var_6;
  self.asm.painsize = var_3;
  return var_7[randomint(var_7.size)];
}

choosedirectionalpainanim_covercrouch(var_0, var_1, var_2) {
  var_3 = getpainweaponsize();
  var_4 = getpaindirectiontoactor();
  var_5 = "torso";
  var_6 = "midbody";
  var_7 = [];

  if(scripts\engine\utility::damagelocationisany("head", "helmet", "neck")) {
    var_5 = "head";
    var_6 = "head";
    var_7[var_7.size] = scripts\asm\asm::asm_lookupanimfromalias(var_1, "head" + var_3 + var_4);
  } else {
    var_5 = "torso";
    var_6 = "midbody";
    var_7[var_7.size] = scripts\asm\asm::asm_lookupanimfromalias(var_1, "torso" + var_3 + var_4);
  }

  var_8 = var_5 + var_3 + var_4;
  var_9 = "_2";

  if(var_4 == "_b")
    var_9 = "_8";
  else if(var_4 == "_l")
    var_9 = "_6";
  else if(var_4 == "_r")
    var_9 = "_4";

  self.asm.aliaspain = var_8;
  self.asm.painloc = var_6;
  self.asm.painsize = var_3;
  return var_7[randomint(var_7.size)];
}

choosepainanim_covercrouchlean(var_0, var_1, var_2) {
  var_3 = getpainweaponsize();
  var_4 = "pain";
  var_5 = [];
  var_5[var_5.size] = scripts\asm\asm::asm_lookupanimfromalias(var_1, var_4 + var_3);
  var_6 = var_4 + var_3;
  self.asm.aliaspain = var_6;
  return var_5[randomint(var_5.size)];
}

playpainaniminternal(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  self endon(var_1 + "_finished");

  if(isDefined(self.a.paintime))
    self.a.lastpaintime = self.a.paintime;
  else
    self.a.lastpaintime = 0;

  self.a.paintime = gettime();

  if(self.stairsstate != "none")
    self.a.painonstairs = 1;
  else
    self.a.painonstairs = undefined;

  self animmode("gravity");

  if(!istrue(var_6))
    self orientmode("face angle", self.angles[1]);

  if(!isDefined(self.no_pain_sound))
    scripts\anim\face.gsc::saygenericdialogue("pain");

  if(scripts\asm\soldier\death::shouldhelmetpoponpain(scripts\common\utility::wasdamagedbyexplosive()))
    scripts\asm\soldier\death::helmetpop();

  var_7 = var_1;

  if(isDefined(var_5))
    var_7 = var_5;

  var_8 = scripts\asm\asm::asm_getanim(var_0, var_1, var_2);
  self aisetanim(var_7, var_8);

  if(var_3 == 1) {
    self.asm.secondarypainactive = 0;
    thread waitforsecondarypain(var_0, var_1);
  }

  var_9 = scripts\asm\asm::asm_getxanim(var_7, var_8);
  scripts\asm\asm::asm_playfacialanim(var_0, var_1, var_9);
  self.requestdifferentcover = 1;

  if(animhasnotetrack(var_9, "code_move"))
    scripts\asm\asm::asm_donotetracks(var_0, var_1, undefined, undefined, var_7);

  scripts\asm\asm::asm_donotetracks(var_0, var_1, undefined, undefined, var_7);

  if(istrue(var_4))
    finishpain(var_0, var_1, var_2);
  else
    finishpain(var_0, var_1);
}

paincanend(var_0, var_1) {
  switch (var_1) {
    case "pain_can_end":
      return 1;
  }
}

coverexppainselectreturna(var_0, var_1, var_2) {
  if(isDefined(self._blackboard.coverexposetype) && self._blackboard.coverexposetype == "A")
    return 1;
  else
    return 0;
}

finishpain(var_0, var_1, var_2) {
  self notify("killanimscript");

  if(isDefined(self.asm.secondarypainactive))
    self.asm.secondarypainactive = undefined;

  var_3 = undefined;

  if(isDefined(var_2)) {
    if(isarray(var_2))
      var_3 = var_2[0];
    else
      var_3 = var_2;
  }

  if(!isDefined(var_3)) {
    return;
  }
  thread scripts\asm\asm::asm_setstate(var_3, undefined);
}

playcoverpainanimwithadditives(var_0, var_1, var_2) {
  self.keepclaimednodeifvalid = 1;
  playpainaniminternal(var_0, var_1, var_2, 1);
}

playcoverpainanim(var_0, var_1, var_2) {
  self.keepclaimednodeifvalid = 1;
  playpainanim(var_0, var_1, var_2);
}

shouldusedamageshieldanim() {
  if(self.damageshield && !isDefined(self.disabledamageshieldpain)) {
    if(self.currentpose == "prone")
      return 0;

    if(isDefined(self.lastattacker) && isDefined(self.lastattacker.team) && self.lastattacker.team == self.team)
      return 0;

    if(self.damageshieldcounter > 0)
      return 0;

    return 1;
  }

  return 0;
}

shoulddamageshielddowntoground(var_0, var_1, var_2, var_3) {
  if(isDefined(self.damageshield) && self.damageshield && !isDefined(self.disabledamageshieldpain)) {
    if(isDefined(self.lastattacker) && isDefined(self.lastattacker.unittype) && self.lastattacker.unittype == "c8") {
      var_4 = self.damageweapon;

      if(isDefined(var_4) && var_4.isbeam)
        return 1;
    }
  }

  return 0;
}

playpainanim_damageshieldtoground(var_0, var_1, var_2) {
  self.asm.binfullbodypain = 1;
  playpainaniminternal(var_0, var_1, var_2, 0, 1);
}

playpainanim_damageshieldtoground_cleanup(var_0, var_1, var_2) {
  self.asm.binfullbodypain = undefined;
}

chooseanim_damageshieldtoground(var_0, var_1, var_2) {
  return scripts\asm\asm::asm_lookupanimfromalias(var_1, "pain");
}

choosepainanim_standtorsotoexposed(var_0, var_1, var_2) {
  if(self.lasttorsoanim == "torso_upper")
    var_3 = scripts\asm\asm::asm_lookupanimfromalias(var_1, "torso_upper");
  else if(self.lasttorsoanim == "torso_lower")
    var_3 = scripts\asm\asm::asm_lookupanimfromalias(var_1, "torso_lower");
  else
    var_3 = scripts\asm\asm::asm_lookupanimfromalias(var_1, "default");

  self.lasttorsoanim = undefined;
  return var_3;
}

choosepainanim_standtorso(var_0, var_1, var_2) {
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

choosepainanim_stand(var_0, var_1, var_2) {
  if(shouldusedamageshieldanim()) {
    if(self.currentpose == "crouch")
      return scripts\asm\asm::asm_lookupanimfromalias(var_1, "damage_shield_crouch");
    else if(self.currentpose == "stand")
      return scripts\asm\asm::asm_lookupanimfromalias(var_1, "damage_shield_stand");
  }

  if(scripts\anim\utility_common.gsc::isusingsidearm())
    return choosepainanim_pistol(var_0, var_1, var_2);

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

choosepainanim_damageshield(var_0, var_1, var_2) {
  if(shouldusedamageshieldanim()) {
    if(self.currentpose == "crouch")
      return scripts\asm\asm::asm_lookupanimfromalias(var_1, "damage_shield_crouch");
    else if(self.currentpose == "stand")
      return scripts\asm\asm::asm_lookupanimfromalias(var_1, "damage_shield_stand");
  }

  var_3 = [];

  if(var_3.size < 2)
    var_3[var_3.size] = scripts\asm\asm::asm_lookupanimfromalias(var_1, "default");

  return var_3[randomint(var_3.size)];
}

choosedynamicpainanim_expcrouchlegs(var_0, var_1, var_2) {
  var_3 = [];
  var_3[var_3.size] = scripts\asm\asm::asm_lookupanimfromalias(var_1, "default");
  return var_3[randomint(var_3.size)];
}

choosepainanim_crouch(var_0, var_1, var_2) {
  var_3 = [];
  var_3[var_3.size] = scripts\asm\asm::asm_lookupanimfromalias(var_1, "default");

  if(scripts\engine\utility::damagelocationisany("left_hand", "left_arm_lower", "left_arm_upper"))
    var_3[var_3.size] = scripts\asm\asm::asm_lookupanimfromalias(var_1, "left_arm");

  if(scripts\engine\utility::damagelocationisany("right_hand", "right_arm_lower", "right_arm_upper"))
    var_3[var_3.size] = scripts\asm\asm::asm_lookupanimfromalias(var_1, "right_arm");

  return var_3[randomint(var_3.size)];
}

choosepainanim_pistol(var_0, var_1, var_2) {
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

choosepainanim_run(var_0, var_1, var_2) {
  var_3 = 30;
  var_4 = 150;
  var_5 = 300;
  var_6 = [];
  var_7 = 0;
  var_8 = 0;
  var_9 = 0;
  var_10 = navtrace(self.origin, self localtoworldcoords((var_5, 0, 0)), self, 1);

  if(var_10["fraction"] > 0.9)
    var_8 = 1;

  if(var_10["fraction"] > 0.9 * (var_4 / var_5))
    var_7 = 1;

  if(isDefined(self.a.disablelongpain)) {
    var_8 = 0;
    var_7 = 0;
  }

  var_11 = length(self.velocity);
  var_12 = scripts\asm\shared\utility::getbasearchetype();
  var_13 = getnextlowestspeedthresholdstring(var_12, var_11);

  if(var_8) {
    var_14 = "long" + var_13;
    var_6[var_6.size] = scripts\asm\asm::asm_lookupanimfromalias(var_1, var_14);
  } else if(var_7) {
    var_14 = "medium" + var_13;
    var_6[var_6.size] = scripts\asm\asm::asm_lookupanimfromalias(var_1, var_14);
  } else if(var_10["fraction"] > 0.9 * (var_3 / var_5)) {
    var_14 = "short" + var_13;
    var_6[var_6.size] = scripts\asm\asm::asm_lookupanimfromalias(var_1, var_14);
  }

  if(var_6.size == 0)
    return scripts\asm\asm::asm_lookupanimfromalias(var_1, "emergency_backup");

  return var_6[randomint(var_6.size)];
}

choosepainanim_tocoverhide_helper(var_0, var_1, var_2, var_3) {
  return scripts\asm\asm::asm_chooseanim(var_0, var_1, var_2);
}

choosepainanim_tocoverhide(var_0, var_1, var_2) {
  return scripts\asm\soldier\cover::getstopdatafortransition(var_0, var_1, ::choosepainanim_tocoverhide_helper);
}

choosepainanim_covercorner_helper(var_0, var_1, var_2, var_3) {
  if(isDefined(var_2) && isDefined(var_2[1]))
    return scripts\asm\asm::asm_lookupanimfromalias(var_1, var_2[1]);

  if(self.currentpose == "crouch")
    return scripts\asm\asm::asm_lookupanimfromalias(var_1, "crouch");
  else
    return scripts\asm\asm::asm_lookupanimfromalias(var_1, "stand");
}

choosepainanim_covercorner_tocoverhide(var_0, var_1, var_2) {
  return scripts\asm\soldier\cover::getstopdatafortransition(var_0, var_1, ::choosepainanim_covercorner_helper);
}

choosepainanim_covercorner(var_0, var_1, var_2) {
  return choosepainanim_covercorner_helper(var_0, var_1, var_2, undefined);
}

choosedynamicpainanim_back(var_0, var_1, var_2) {
  var_3 = "back";
  return scripts\asm\asm::asm_lookupanimfromalias(var_1, var_3);
}

choosepainanim_covercrouch(var_0, var_1, var_2) {
  var_3 = "crouch";

  if(isDefined(var_2))
    var_3 = var_3 + "_" + var_2;

  return scripts\asm\asm::asm_lookupanimfromalias(var_1, var_3);
}

choosedynamicpainanim_covercrouch(var_0, var_1, var_2) {
  var_3 = [];

  if(scripts\engine\utility::damagelocationisany("torso_upper", "torso_lower"))
    var_3[var_3.size] = scripts\asm\asm::asm_lookupanimfromalias(var_1, "torso");
  else if(scripts\engine\utility::damagelocationisany("head", "helmet", "neck"))
    var_3[var_3.size] = scripts\asm\asm::asm_lookupanimfromalias(var_1, "head");

  if(var_3.size < 2)
    var_3[var_3.size] = scripts\asm\asm::asm_lookupanimfromalias(var_1, "default");

  return var_3[randomint(var_3.size)];
}

choosepainanim_coverstand(var_0, var_1, var_2) {
  var_3 = "stand";

  if(isDefined(var_2) && isDefined(var_2))
    var_3 = var_3 + "_" + var_2;

  return scripts\asm\asm::asm_lookupanimfromalias(var_1, var_3);
}

choosedynamicpainanim_coverstand(var_0, var_1, var_2) {
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

choosepainanimdeafened(var_0, var_1, var_2) {
  var_3 = 3;
  var_4 = "deaf_" + (randomint(var_3) + 1);
  return scripts\asm\asm::asm_lookupanimfromalias(var_1, var_4);
}

cleanuppainanim(var_0, var_1, var_2) {
  if(isDefined(self.script) && self.script == "pain")
    self notify("killanimscript");

  if(isDefined(self.damageshieldpain)) {
    self.damageshieldcounter = undefined;
    self.damageshieldpain = undefined;
    self.allowpain = 1;

    if(!isDefined(self.predamageshieldignoreme))
      self.ignoreme = 0;

    self.predamageshieldignoreme = undefined;
  }

  if(isDefined(self.blockingpain)) {
    self.blockingpain = undefined;
    self.allowpain = 1;
  }

  clearpainturnrate(var_0, var_1, var_2);

  if(istrue(self.leavecasualkiller))
    scripts\asm\soldier\script_funcs::terminate_casualkiller(var_0, var_1, var_2);

  if(!istrue(self.ignoreall)) {
    if(isDefined(self.enemy) && lengthsquared(self.velocity) < 1 && isDefined(self.weapon) && !istrue(self.enemy.ignoreme) && self cansee(self.enemy))
      self.remainexposedendtime = gettime() + 2000;
  }
}

transition_flashfinished(var_0, var_1, var_2, var_3) {
  if(!scripts\engine\utility::isflashed())
    return 1;

  if(gettime() > self.flashendtime)
    return 1;

  return scripts\asm\asm::asm_eventfired(var_0, "end") || scripts\asm\asm::asm_eventfired(var_0, "finish");
}

iscovercrouch(var_0, var_1, var_2, var_3) {
  if(!isDefined(self._blackboard.covernode))
    return 0;

  if(isDefined(self._blackboard.covernode.type) && self._blackboard.covernode.type == "Cover Crouch")
    return 1;
  else
    return 0;
}

iscoverstand(var_0, var_1, var_2, var_3) {
  if(!isDefined(self._blackboard.covernode))
    return 0;

  if(isDefined(self._blackboard.covernode.type) && self._blackboard.covernode.type == "Cover Stand")
    return 1;
  else
    return 0;
}

iscoverright_crouch(var_0, var_1, var_2, var_3) {
  if(!isDefined(self._blackboard.covernode))
    return 0;

  if(isDefined(self._blackboard.covernode.type) && self._blackboard.covernode.type == "Cover Right" && (isDefined(self.currentpose) && self.currentpose == "crouch"))
    return 1;
  else
    return 0;
}

iscoverright_stand(var_0, var_1, var_2, var_3) {
  if(!isDefined(self._blackboard.covernode))
    return 0;

  if(isDefined(self._blackboard.covernode.type) && self._blackboard.covernode.type == "Cover Right" && (isDefined(self.currentpose) && self.currentpose == "stand"))
    return 1;
  else
    return 0;
}

iscoverleft_crouch(var_0, var_1, var_2, var_3) {
  if(!isDefined(self._blackboard.covernode))
    return 0;

  if(isDefined(self._blackboard.covernode.type) && self._blackboard.covernode.type == "Cover Left" && (isDefined(self.currentpose) && self.currentpose == "crouch"))
    return 1;
  else
    return 0;
}

iscoverleft_stand(var_0, var_1, var_2, var_3) {
  if(!isDefined(self._blackboard.covernode))
    return 0;

  if(isDefined(self._blackboard.covernode.type) && self._blackboard.covernode.type == "Cover Left" && (isDefined(self.currentpose) && self.currentpose == "stand"))
    return 1;
  else
    return 0;
}

isexposed_crouch(var_0, var_1, var_2, var_3) {
  if(!isDefined(self._blackboard.covernode))
    return 0;

  if(isDefined(self._blackboard.covernode.type) && self._blackboard.covernode.type == "Exposed" && (isDefined(self.currentpose) && self.currentpose == "crouch"))
    return 1;
  else
    return 0;
}

isexposed_prone(var_0, var_1, var_2, var_3) {
  if(!isDefined(self._blackboard.covernode))
    return 0;

  if(isDefined(self._blackboard.covernode.type) && self._blackboard.covernode.type == "Exposed" && (isDefined(self.currentpose) && self.currentpose == "prone"))
    return 1;
  else
    return 0;
}

playanim_flashed(var_0, var_1, var_2) {
  self endon(var_1 + "_finished");
  playanim_flashed_internal(var_0, var_1);
  thread playanim_monitorflashrestart(var_0, var_1);
  scripts\asm\asm::asm_donotetracks(var_0, var_1);
}

playanim_flashed_internal(var_0, var_1) {
  var_2 = scripts\asm\asm::asm_getanim(var_0, var_1);
  var_3 = 1;

  if(isDefined(self.flashendtime)) {
    var_4 = self.flashendtime - gettime();
    var_5 = scripts\asm\asm::asm_getxanim(var_1, var_2);
    var_6 = getanimlength(var_5) * 1000;

    if(var_4 > 0)
      var_3 = var_6 / var_4;

    var_3 = var_3 + randomfloatrange(-0.2, 0.2);
    var_3 = clamp(var_3, 0.2, 1.65);
  }

  self aisetanim(var_1, var_2, var_3);
}

playanim_monitorflashrestart(var_0, var_1) {
  self endon(var_1 + "_finished");
  var_2 = self.flashendtime;

  while(isDefined(self.flashendtime)) {
    if(var_2 != self.flashendtime) {
      var_2 = self.flashendtime;
      playanim_flashed_internal(var_0, var_1);
    }

    waitframe();
  }
}

chooseanim_flashed(var_0, var_1, var_2) {
  var_3 = "med";

  if(isDefined(self.flashendtime)) {
    var_4 = self.flashendtime - gettime();

    if(var_4 <= 3750)
      var_3 = "short";
    else if(var_4 >= 5250)
      var_3 = "med";
  }

  var_5 = scripts\asm\asm::asm_lookupanimfromalias(var_1, var_3);
  return scripts\asm\shared\utility::preventrecentanimindex(var_1, var_3, var_5);
}

cleanupflashanim(var_0, var_1, var_2) {
  cleanuppainanim(var_0, var_1, var_2);
  scripts\common\utility::flashbangstop();
}

playanim_burning(var_0, var_1, var_2) {
  self endon(var_1 + "_finished");
  var_3 = scripts\asm\asm::asm_getanim(var_0, var_1, var_2);
  var_4 = randomfloatrange(0.8, 1.2);
  self orientmode("face angle", self.angles[1]);
  self aisetanim(var_1, var_3, var_4);
  scripts\asm\asm::asm_donotetracks(var_0, var_1, ::burn_notetrack_handler);
}

burn_notetrack_handler(var_0) {
  if(isDefined(self.semtexstuckto)) {
    return;
  }
  switch (var_0) {
    case "burn_vfx_pain_start_head":
      playFXOnTag(level.g_effect["vfx_burn_sml_head_low"], self, "j_helmet");
      break;
    case "burn_vfx_pain_start_arm_l":
      playFXOnTag(level.g_effect["vfx_burn_sml_low"], self, "j_elbow_le");
      break;
    case "burn_vfx_pain_start_arm_r":
      playFXOnTag(level.g_effect["vfx_burn_sml_low"], self, "j_shoulder_ri");
      break;
    case "burn_vfx_pain_start_leg_l":
      playFXOnTag(level.g_effect["vfx_burn_med_low"], self, "j_knee_le");
      break;
    case "burn_vfx_pain_start_leg_r":
      playFXOnTag(level.g_effect["vfx_burn_med_low"], self, "j_knee_ri");
      break;
  }
}

chooseanim_burning(var_0, var_1, var_2) {
  var_3 = var_1;

  if(self.currentpose == "prone")
    return scripts\asm\asm::asm_lookupanimfromalias(var_1, "pain_burning_prone");

  var_4 = scripts\engine\utility::ter_op(randomint(2) == 1, "arm", "leg");
  var_3 = var_3 + "_" + self.burningdirection + "_" + var_4;
  var_5 = scripts\asm\asm::asm_lookupanimfromalias(var_1, var_3);
  return scripts\asm\shared\utility::preventrecentanimindex(var_1, var_3, var_5);
}

shouldpainfaceplayer(var_0, var_1, var_2, var_3) {
  var_4 = getpaindirectiontoactor();

  if(var_4 == "_f")
    return 0;

  self forcethreatupdate();

  if(isDefined(self.enemy) && isDefined(self.lastattacker) && self.enemy == self.lastattacker) {
    var_5 = vectorNormalize(self.origin - self.enemy.origin);

    if(vectordot(var_5, self.damagedir) > 0.866)
      return 1;
  }

  return 0;
}

shouldpaincoverfaceplayer(var_0, var_1, var_2, var_3) {
  if(shouldpainfaceplayer(var_0, var_1, var_2, var_3)) {
    var_4 = 1;

    if(isDefined(self.covernode) && scripts\aitypes\cover::shouldbeinlmgcover())
      var_4 = scripts\aitypes\cover::iscovervalidforlmg(self.covernode);
    else
      var_4 = scripts\asm\shared\utility::iscovervalid();

    return !var_4;
  }

  return 0;
}

shouldpainrunfaceplayer(var_0, var_1, var_2, var_3) {
  var_4 = getpaindirectiontoactor();

  if(var_4 == "_f")
    return 0;

  if(lengthsquared(self.velocity) > 3600)
    return 0;

  self forcethreatupdate();

  if(isDefined(self.enemy) && isPlayer(self.enemy))
    return 1;

  return 0;
}

choosepainanim_faceplayer(var_0, var_1, var_2) {
  var_3 = getpaindirectiontoactor();
  self.asm.aliaspain = "torso_md" + var_3;
  self.asm.painloc = "midbody";
  self.asm.painsize = "_md";
  return scripts\asm\asm::asm_lookupanimfromalias(var_1, self.asm.aliaspain);
}

painanimfaceenemy(var_0, var_1, var_2) {
  self endon(var_1 + "_finished");
  var_3 = scripts\asm\asm::asm_getanim(var_0, var_1);
  var_4 = scripts\asm\asm::asm_getxanim(var_1, var_3);
  var_5 = getanimlength(var_4);
  var_6 = var_5 * 0.8;
  var_7 = var_5;
  var_8 = getnotetracktimes(var_4, "face_enemy")[0];

  if(isDefined(var_8))
    var_6 = var_8 * var_5;
  else {
    if(scripts\asm\asm::asm_currentstatehasflag(var_0, "notetrackAim")) {
      var_9 = getnotetracktimes(var_4, "start_aim")[0];

      if(isDefined(var_9)) {
        var_6 = min(var_6, max(0, var_9 - 0.3) * var_5);
        var_7 = var_9 * var_5;
      }
    }

    var_6 = min(var_6, max(0, var_5 - 0.5));
  }

  wait(var_6);

  if(isalive(var_2)) {
    self.painoldturnrate = self.turnrate;
    self.turnrate = 0.1;
    self orientmode("face enemy");
  }
}

playpainanim_faceplayer(var_0, var_1, var_2) {
  self endon(var_1 + "_finished");

  if(isalive(self.enemy) && isDefined(self.lastattacker) && self.enemy == self.lastattacker)
    thread painanimfaceenemy(var_0, var_1, self.enemy);

  playpainaniminternal(var_0, var_1, var_2, 0, 1, undefined, 1);
}

playpainanim_exposedstand(var_0, var_1, var_2) {
  self endon(var_1 + "_finished");

  if(isalive(self.enemy) && isDefined(self.lastattacker) && self.enemy == self.lastattacker)
    thread painanimfaceenemy(var_0, var_1, self.enemy);

  playpainaniminternal(var_0, var_1, var_2, 0, 1);
}

playpainanim_exposedcrouch(var_0, var_1, var_2) {
  self endon(var_1 + "_finished");
  self.painattacker = self.lastattacker;
  playpainaniminternal(var_0, var_1, var_2, 0, 1);
}

playpainanim_exposedcrouchtransition(var_0, var_1, var_2) {
  self endon(var_1 + "_finished");

  if(isalive(self.enemy) && isDefined(self.painattacker) && self.enemy == self.painattacker)
    thread painanimfaceenemy(var_0, var_1, self.enemy);

  self.painattacker = undefined;
  scripts\asm\shared\utility::playanim(var_0, var_1, var_2);
}

clearpainturnrate(var_0, var_1, var_2) {
  if(isDefined(self.painoldturnrate)) {
    self.turnrate = self.painoldturnrate;
    self.painoldturnrate = undefined;
  }
}