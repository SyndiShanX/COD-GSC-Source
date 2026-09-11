/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\asm\soldier\pain.gsc
***********************************************/

function isdamagelocation_rarm(var0, var1, var2, var3) {
  if(!self.damageshield) {
    return scripts\engine\utility::damagelocationisany("right_arm_upper", "right_arm_lower", "right_hand");
  }

  return 0;
}

function isdamagelocation_rleg(var0, var1, var2, var3) {
  if(!self.damageshield) {
    return scripts\engine\utility::damagelocationisany("right_leg_upper", "right_foot", "right_leg_lower");
  }

  return 0;
}

function isdamagelocation_lleg(var0, var1, var2, var3) {
  if(!self.damageshield) {
    return scripts\engine\utility::damagelocationisany("left_leg_upper", "left_foot", "left_leg_lower");
  }

  return 0;
}

function isdamagelocation_larm(var0, var1, var2, var3) {
  if(!self.damageshield) {
    return scripts\engine\utility::damagelocationisany("left_arm_upper", "left_arm_lower", "left_hand");
  }

  return 0;
}

function isdamagelocation_torso(var0, var1, var2, var3) {
  if(!self.damageshield) {
    return scripts\engine\utility::damagelocationisany("torso_upper", "torso_lower");
  }

  return 0;
}

function isdamagelocation_head(var0, var1, var2, var3) {
  if(!self.damageshield) {
    return scripts\engine\utility::damagelocationisany("head", "neck", "helmet");
  }

  return 0;
}

function isdamagelocation_larmcrouch(var0, var1, var2, var3) {
  return scripts\engine\utility::damagelocationisany("left_hand", "left_arm_upper", "left_arm_lower", "left_leg_upper", "left_leg_lower", "left_foot", "torso_lower");
}

function isdamagelocation_back(var0, var1, var2, var3) {
  if(!self.damageshield) {
    if(scripts\asm\shared\utility::gethumandamagedirstring() == 1 && !scripts\engine\utility::damagelocationisany("left_leg_upper", "left_leg_lower", "left_foot", "right_leg_upper", "right_leg_lower", "right_foot")) {
      return true;
    }
  }

  return false;
}

function isdamagelocation_torsocovercrouch(var0, var1, var2, var3) {
  return scripts\engine\utility::damagelocationisany("right_arm_upper", "right_arm_lower", "right_hand", "left_hand", "left_arm_upper", "left_arm_lower", "left_leg_upper", "left_leg_lower", "left_foot", "right_leg_upper", "right_leg_lower", "right_foot", "torso_upper", "torso_lower");
}

function handlesecondarypainflag() {
  self endon("death");
  self notify("new_secondary_pain");
  self endon("new_secondary_pain");
  self.asm.secondarypainactive = 1;
  wait 0.5;
  self.asm.secondarypainactive = 0;
}

function waitforsecondarypain(var0, var1) {
  self endon(var1 + "_finished");

  for(;;) {
    self waittill("damage");

    if(!isalive(self)) {
      break;
    }

    var2 = chooseadditivepainanim_stand(var0, var1);
    var3 = scripts\asm\asm::asm_getxanim(var1, var2);
    self aisetanimknobrestart(var3, 1, 0.01, 1);
    thread handlesecondarypainflag();
    wait 0.35;
  }
}

function chooseadditivepainanim_stand(var0, var1) {
  var2 = [];

  if(scripts\engine\utility::damagelocationisany("torso_upper", "torso_lower")) {
    GscBinSkip0(0x2e, var2.size, scripts\asm\asm::asm_lookupanimfromalias(var1, "add_torso"));
  }

  if(scripts\engine\utility::damagelocationisany("head", "helmet", "neck")) {
    GscBinSkip0(0x2e, var2.size, scripts\asm\asm::asm_lookupanimfromalias(var1, "add_head"));
  }

  if(scripts\engine\utility::damagelocationisany("right_arm_upper", "right_arm_lower")) {
    GscBinSkip0(0x2e, var2.size, scripts\asm\asm::asm_lookupanimfromalias(var1, "add_right_arm"));
  }

  if(scripts\engine\utility::damagelocationisany("left_arm_upper", "left_arm_lower")) {
    GscBinSkip0(0x2e, var2.size, scripts\asm\asm::asm_lookupanimfromalias(var1, "add_left_arm"));
  }

  if(scripts\engine\utility::damagelocationisany("left_leg_upper", "left_leg_lower", "left_foot")) {
    GscBinSkip0(0x2e, var2.size, scripts\asm\asm::asm_lookupanimfromalias(var1, "add_left_leg"));
  }

  if(scripts\engine\utility::damagelocationisany("right_leg_upper", "right_leg_lower", "right_foot")) {
    GscBinSkip0(0x2e, var2.size, scripts\asm\asm::asm_lookupanimfromalias(var1, "add_right_leg"));
  }

  if(var2.size < 2) {
    GscBinSkip0(0x2e, var2.size, scripts\asm\asm::asm_lookupanimfromalias(var1, "add_default"));
  }

  return var2[randomint(var2.size)];
}

function choosepainanimshock(var0, var1, var2) {
  return scripts\asm\asm::asm_lookupanimfromalias(var1, "shock_loop_" + self.currentpose);
}

function playsonicshockfx() {
  if(scripts\common\utility::isdamageweapon(getcompleteweaponname("iw7_sonic")) && scripts\common\utility::isweaponepic(self.damageweapon)) {
    playFXOnTag(level.g_effect["soldier_shock"], self, "j_knee_ri");
    playFXOnTag(level.g_effect["soldier_shock"], self, "j_shoulder_ri");
    return;
  }
}

function playshockpainloop(var0, var1, var2) {
  self endon("death");
  self endon(var1 + "_finished");
  var3 = scripts\asm\asm::asm_getanim(var0, var1);
  var4 = scripts\engine\utility::ter_op(isDefined(self.empstuntime), self.empstuntime, 3.5);
  playsonicshockfx();
  self animmode("zonly_physics", 0);
  wait randomfloat(0.3);

  if(self.asmname == "c6" || self.asmname == "c6_worker") {
    thread shockpainloop_internal(self.asmname, var1, 1, 0, 1);
    self playSound("generic_flashbang_c6_1");
  } else {
    thread shockpainloop_internal(self.asmname, var1, 1, 0);
  }

  wait var4;
  self notify("painloop_end");
  scripts\asm\asm::asm_fireevent(var0, "stop_loop_pain");
  self.emplooptime = undefined;
  finishpain(var0, var1, var2);
}

function shockpainloop_c6_cleanup(var0, var1, var2) {
  self stopsounds();
}

function shockpainloop_internal(var0, var1, var2, var3, var4) {
  self endon(var1 + "_finished");
  self endon("painloop_end");

  if(isDefined(var3) && var3) {
    var5 = scripts\asm\asm::asm_lookupanimfromaliasifexists("knobs", "move");

    if(isDefined(var5)) {
      self setmoveanimknob(var5);
    }
  }

  var6 = scripts\asm\asm::asm_getbodyknob();
  var7 = scripts\asm\asm::asm_getanim(var0, var1);

  for(;;) {
    if(isDefined(var4)) {
      var7 = scripts\asm\asm::asm_getanim(var0, var1);
    }

    var8 = scripts\asm\asm::asm_getxanim(var1, var7);
    self aisetanim(var1, var7, var2);
    scripts\asm\asm::asm_playfacialanim(var0, var1, var8);
    var6 = var7;
    scripts\asm\asm::asm_donotetrackssingleloop(var0, var1, var8, scripts\asm\asm::asm_getnotehandler(var0, var1));
  }
}

function chooseshockpainrecovery(var0, var1, var2) {
  return scripts\asm\asm::asm_lookupanimfromalias(var1, "shock_finish_" + self.currentpose);
}

function playpainanim(var0, var1, var2) {
  playpainaniminternal(var0, var1, var2, 0);
}

function playpainanimwithadditives(var0, var1, var2) {
  playpainaniminternal(var0, var1, var2, 1);
}

function playpainanimlmg(var0, var1, var2) {
  self._blackboard.inlmgstate = 1;
  playpainaniminternal(var0, var1, var2, 0);
}

function pain_can_use_handler(var0, var1) {
  if(var0 == "pain_can_end") {
    return 1;
  }
}

function shouldpainruntostrafereverse(var0, var1, var2, var3) {
  if(!isDefined(self.pathgoalpos)) {
    return false;
  }

  if(self pathdisttogoal() < 36) {
    return false;
  }

  var4 = length(self.velocity);

  if(var4 < 20) {
    return false;
  }

  var5 = self.velocity / var4;

  if(self.lookaheaddist > 12) {
    var6 = self.lookaheaddir;
  } else {
    var6 = vectorNormalize(self getposonpath(36) - self.origin);
  }

  return vectordot(var6, var6) < 0.5;
}

function ispainweaponsizelarge(var0, var1, var2, var3) {
  var4 = "rifle";
  var5 = self.damageweapon;

  if(isDefined(var5) && var5.basename != "iw8_sn_mike14") {
    var4 = var5.classname;
  }

  if(var4 == "spread") {
    if(isDefined(self.lastattacker) && distancesquared(self.lastattacker.origin, self.origin) <= 62500) {
      return true;
    }
  } else if(var4 == "sniper" || var4 == "mg") {
    return true;
  }

  return false;
}

function getpainweaponsize() {
  var0 = "_md";
  var1 = "rifle";
  var2 = self.damageweapon;

  if(isDefined(var2) && var2.basename != "iw8_sn_mike14") {
    var1 = var2.classname;
  }

  if(var1 == "pistol" || var1 == "smg") {
    var0 = "_md";
  } else if(var1 == "spread") {
    var0 = "_md";

    if(isDefined(self.lastattacker) && distancesquared(self.lastattacker.origin, self.origin) <= 62500) {
      var0 = "_lg";
    }
  } else if(var1 == "sniper" || var1 == "mg") {
    var0 = "_lg";
  } else if(var1 == "grenade" && isDefined(self.damagemod) && self.damagemod == "MOD_IMPACT") {
    var0 = "_lg";
  }

  if(isDefined(level.fnasmsoldiergetpainweaponsize)) {
    var0 = self[[level.fnasmsoldiergetpainweaponsize]](var0);
  }

  return var0;
}

function getpainweaponsize_exposed() {
  var0 = "_md";
  var1 = "rifle";
  var2 = self.damageweapon;

  if(isDefined(var2) && var2.basename != "iw8_sn_mike14") {
    var1 = var2.classname;
  }

  if(var1 == "pistol" || var1 == "smg") {
    var0 = "_md";
  } else if(var1 == "spread") {
    var0 = "_md";

    if(isDefined(self.lastattacker) && distancesquared(self.lastattacker.origin, self.origin) <= 62500) {
      var0 = "_lg";
    }
  } else if(var1 == "sniper" || var1 == "mg") {
    var0 = "_lg";
  }

  if(isDefined(level.fnasmsoldiergetpainweaponsize)) {
    var0 = self[[level.fnasmsoldiergetpainweaponsize]](var0);
  }

  return var0;
}

function getpaindirectiontoactor() {
  if(isDefined(self.damageyaw) && self.damageyaw >= -45 && self.damageyaw <= 45) {
    var0 = "_b";
    return var0;
  }

  if(isDefined(self.damageyaw) && self.damageyaw < -45 && self.damageyaw > -135) {
    var0 = "_l";
    return var0;
  }

  if(isDefined(self.damageyaw) && self.damageyaw > 45 && self.damageyaw < 135) {
    var0 = "_r";
    return var0;
  }

  var0 = "_f";
  return var0;
}

function choosedirectionalpainanim_exposedstand(var0, var1, var2) {
  var3 = getpainweaponsize();
  var4 = getpaindirectiontoactor();
  var5 = "torso";
  var6 = "midbody";
  var7 = [];

  if(scripts\engine\utility::damagelocationisany("head", "helmet", "neck")) {
    var5 = "head";
    var6 = "head";
    GscBinSkip0(0x2e, var7.size, scripts\asm\asm::asm_lookupanimfromalias(var1, "head" + var3 + var4));
  }

  if(scripts\engine\utility::damagelocationisany("torso_upper", "torso_lower")) {
    var5 = "torso";
    var6 = "midbody";
    GscBinSkip0(0x2e, var7.size, scripts\asm\asm::asm_lookupanimfromalias(var1, "torso" + var3 + var4));
  }

  if(scripts\engine\utility::damagelocationisany("right_arm_upper", "right_arm_lower", "right_hand")) {
    var5 = "rarm";
    var6 = "midbody";
    GscBinSkip0(0x2e, var7.size, scripts\asm\asm::asm_lookupanimfromalias(var1, "rarm" + var3 + var4));
  }

  if(scripts\engine\utility::damagelocationisany("left_arm_upper", "left_arm_lower", "left_hand")) {
    var5 = "larm";
    var6 = "midbody";
    GscBinSkip0(0x2e, var7.size, scripts\asm\asm::asm_lookupanimfromalias(var1, "larm" + var3 + var4));
  }

  if(scripts\engine\utility::damagelocationisany("left_leg_upper", "left_leg_lower", "left_foot")) {
    var5 = "lleg";
    var6 = "lowerbody";
    GscBinSkip0(0x2e, var7.size, scripts\asm\asm::asm_lookupanimfromalias(var1, "lleg" + var3 + var4));
  }

  if(scripts\engine\utility::damagelocationisany("right_leg_upper", "right_leg_lower", "right_foot")) {
    var5 = "rleg";
    var6 = "lowerbody";
    GscBinSkip0(0x2e, var7.size, scripts\asm\asm::asm_lookupanimfromalias(var1, "rleg" + var3 + var4));
  }

  var5 = "torso";
  var6 = "midbody";
  GscBinSkip0(0x2e, var7.size, scripts\asm\asm::asm_lookupanimfromalias(var1, "torso" + var3 + var4));
}

function choosedirectionalfullpainanim_exposedstand(var0, var1, var2) {
  var3 = getpaindirectiontoactor();
  var4 = "torso";
  var5 = "midbody";
  var6 = [];

  if(scripts\engine\utility::damagelocationisany("head", "helmet", "neck")) {
    var4 = "head";
    var5 = "head";
    GscBinSkip0(0x2e, var6.size, scripts\asm\asm::asm_lookupanimfromalias(var1, "head" + var3));
  }

  if(scripts\engine\utility::damagelocationisany("torso_upper")) {
    var4 = "torso_upper";
    var5 = "midbody";
    GscBinSkip0(0x2e, var6.size, scripts\asm\asm::asm_lookupanimfromalias(var1, "torso_upper" + var3));
  }

  if(scripts\engine\utility::damagelocationisany("torso_lower")) {
    var4 = "torso_lower";
    var5 = "midbody";
    GscBinSkip0(0x2e, var6.size, scripts\asm\asm::asm_lookupanimfromalias(var1, "torso_lower" + var3));
  }

  if(scripts\engine\utility::damagelocationisany("right_arm_upper")) {
    var4 = "rarm_upper";
    var5 = "midbody";
    GscBinSkip0(0x2e, var6.size, scripts\asm\asm::asm_lookupanimfromalias(var1, "rarm_upper" + var3));
  }

  if(scripts\engine\utility::damagelocationisany("right_arm_lower", "right_hand")) {
    var4 = "rarm_lower";
    var5 = "midbody";
    GscBinSkip0(0x2e, var6.size, scripts\asm\asm::asm_lookupanimfromalias(var1, "rarm_lower" + var3));
  }

  if(scripts\engine\utility::damagelocationisany("left_arm_upper")) {
    var4 = "larm_upper";
    var5 = "midbody";
    GscBinSkip0(0x2e, var6.size, scripts\asm\asm::asm_lookupanimfromalias(var1, "larm_upper" + var3));
  }

  if(scripts\engine\utility::damagelocationisany("left_arm_lower", "left_hand")) {
    var4 = "larm_lower";
    var5 = "midbody";
    GscBinSkip0(0x2e, var6.size, scripts\asm\asm::asm_lookupanimfromalias(var1, "larm_lower" + var3));
  }

  if(scripts\engine\utility::damagelocationisany("left_leg_upper")) {
    var4 = "lleg_upper";
    var5 = "lowerbody";
    GscBinSkip0(0x2e, var6.size, scripts\asm\asm::asm_lookupanimfromalias(var1, "lleg_upper" + var3));
  }

  if(scripts\engine\utility::damagelocationisany("left_leg_lower", "left_foot")) {
    var4 = "lleg_lower";
    var5 = "lowerbody";
    GscBinSkip0(0x2e, var6.size, scripts\asm\asm::asm_lookupanimfromalias(var1, "lleg_lower" + var3));
  }

  if(scripts\engine\utility::damagelocationisany("right_leg_upper")) {
    var4 = "rleg_upper";
    var5 = "lowerbody";
    GscBinSkip0(0x2e, var6.size, scripts\asm\asm::asm_lookupanimfromalias(var1, "rleg_upper" + var3));
  }

  if(scripts\engine\utility::damagelocationisany("right_leg_lower", "right_foot")) {
    var4 = "rleg_lower";
    var5 = "lowerbody";
    GscBinSkip0(0x2e, var6.size, scripts\asm\asm::asm_lookupanimfromalias(var1, "rleg_lower" + var3));
  }

  var4 = "torso_lower";
  var5 = "midbody";
  GscBinSkip0(0x2e, var6.size, scripts\asm\asm::asm_lookupanimfromalias(var1, "torso_lower" + var3));
}

function choosedirectionalpainanim_transition(var0, var1, var2) {
  if(isDefined(self.asm.aliaspain)) {
    var3 = self.asm.aliaspain;
    return scripts\asm\asm::asm_lookupanimfromalias(var1, var3);
  }

  return scripts\asm\asm::asm_getrandomanim(var2);
}

function choosedirectionalpainanim_coverstand(var0, var1, var2) {
  var3 = getpainweaponsize();
  var4 = getpaindirectiontoactor();
  var5 = "torso";
  var6 = "midbody";
  var7 = [];

  if(scripts\engine\utility::damagelocationisany("head", "helmet", "neck")) {
    var5 = "head";
    var6 = "head";
    GscBinSkip0(0x2e, var7.size, scripts\asm\asm::asm_lookupanimfromalias(var1, "head" + var3 + var4));
  }

  if(scripts\engine\utility::damagelocationisany("left_leg_upper", "left_leg_lower", "left_foot", "right_leg_upper", "right_leg_lower", "right_foot")) {
    var5 = "legs";
    var6 = "lowerbody";
    GscBinSkip0(0x2e, var7.size, scripts\asm\asm::asm_lookupanimfromalias(var1, "legs" + var3 + var4));
  }

  var5 = "torso";
  var6 = "midbody";
  GscBinSkip0(0x2e, var7.size, scripts\asm\asm::asm_lookupanimfromalias(var1, "torso" + var3 + var4));
}

function choosedirectionalpainanim_covercrouch(var0, var1, var2) {
  var3 = getpainweaponsize();
  var4 = getpaindirectiontoactor();
  var5 = "torso";
  var6 = "midbody";
  var7 = [];

  if(scripts\engine\utility::damagelocationisany("head", "helmet", "neck")) {
    var5 = "head";
    var6 = "head";
    GscBinSkip0(0x2e, var7.size, scripts\asm\asm::asm_lookupanimfromalias(var1, "head" + var3 + var4));
  }

  var5 = "torso";
  var6 = "midbody";
  GscBinSkip0(0x2e, var7.size, scripts\asm\asm::asm_lookupanimfromalias(var1, "torso" + var3 + var4));
}

function choosepainanim_covercrouchlean(var0, var1, var2) {
  var3 = getpainweaponsize();
  var4 = "pain";
  var5 = [];
  GscBinSkip0(0x2e, var5.size, scripts\asm\asm::asm_lookupanimfromalias(var1, var4 + var3));
}

function playpainaniminternal(var0, var1, var2, var3, var4, var5, var6) {
  self endon(var1 + "_finished");

  if(isDefined(self.a.paintime)) {
    self.a.lastpaintime = self.a.paintime;
  } else {
    self.a.lastpaintime = 0;
  }

  self.a.paintime = gettime();

  if(self.stairsstate != "none") {
    self.a.painonstairs = 1;
  } else {
    self.a.painonstairs = undefined;
  }

  self animmode("gravity");

  if(!istrue(var6)) {
    self orientmode("face angle", self.angles[1]);
  }

  if(!isDefined(self.no_pain_sound)) {
    scripts\anim\face::saygenericdialogue("pain");
  }

  if(scripts\asm\soldier\death::shouldhelmetpoponpain(scripts\common\utility::wasdamagedbyexplosive())) {
    scripts\asm\soldier\death::helmetpop();
  }

  var7 = var1;

  if(isDefined(var5)) {
    var7 = var5;
  }

  var8 = scripts\asm\asm::asm_getanim(var0, var1, var2);
  self aisetanim(var7, var8);

  if(var3 == 1) {
    self.asm.secondarypainactive = 0;
    thread waitforsecondarypain(var0, var1);
  }

  var9 = scripts\asm\asm::asm_getxanim(var7, var8);
  scripts\asm\asm::asm_playfacialanim(var0, var1, var9);
  self.requestdifferentcover = 1;

  if(animhasnotetrack(var9, "code_move")) {
    scripts\asm\asm::asm_donotetracks(var0, var1, undefined, undefined, var7);
  }

  scripts\asm\asm::asm_donotetracks(var0, var1, undefined, undefined, var7);

  if(istrue(var4)) {
    finishpain(var0, var1, var2);
    return;
  }

  finishpain(var0, var1);
}

function paincanend(var0, var1) {
  switch (var1) {
    case "pain_can_end":
      return 1;
  }
}

function coverexppainselectreturna(var0, var1, var2) {
  if(isDefined(self._blackboard.coverexposetype) && self._blackboard.coverexposetype == "A") {
    return 1;
  }

  return 0;
}

function finishpain(var0, var1, var2) {
  self notify("killanimscript");

  if(isDefined(self.asm.secondarypainactive)) {
    self.asm.secondarypainactive = undefined;
  }

  var3 = undefined;

  if(isDefined(var2)) {
    if(isarray(var2)) {
      var3 = var2[0];
    } else {
      var3 = var2;
    }
  }

  if(!isDefined(var3)) {
    return;
  }

  thread scripts\asm\asm::asm_setstate(var3, undefined);
}

function playcoverpainanimwithadditives(var0, var1, var2) {
  self.keepclaimednodeifvalid = 1;
  playpainaniminternal(var0, var1, var2, 1);
}

function playcoverpainanim(var0, var1, var2) {
  self.keepclaimednodeifvalid = 1;
  playpainanim(var0, var1, var2);
}

function shouldusedamageshieldanim() {
  if(self.damageshield && !isDefined(self.disabledamageshieldpain)) {
    if(self.currentpose == "prone") {
      return false;
    }

    if(isDefined(self.lastattacker) && isDefined(self.lastattacker.team) && self.lastattacker.team == self.team) {
      return false;
    }

    if(self.damageshieldcounter > 0) {
      return false;
    }

    return true;
  }

  return false;
}

function shoulddamageshielddowntoground(var0, var1, var2, var3) {
  if(isDefined(self.damageshield) && self.damageshield && !isDefined(self.disabledamageshieldpain)) {
    if(isDefined(self.lastattacker) && isDefined(self.lastattacker.unittype) && self.lastattacker.unittype == "c8") {
      var4 = self.damageweapon;

      if(isDefined(var4) && var4.isbeam) {
        return true;
      }
    }
  }

  return false;
}

function playpainanim_damageshieldtoground(var0, var1, var2) {
  self.asm.binfullbodypain = 1;
  playpainaniminternal(var0, var1, var2, 0, 1);
}

function playpainanim_damageshieldtoground_cleanup(var0, var1, var2) {
  self.asm.binfullbodypain = undefined;
}

function chooseanim_damageshieldtoground(var0, var1, var2) {
  return scripts\asm\asm::asm_lookupanimfromalias(var1, "pain");
}

function choosepainanim_standtorsotoexposed(var0, var1, var2) {
  if(self.lasttorsoanim == "torso_upper") {
    var3 = scripts\asm\asm::asm_lookupanimfromalias(var1, "torso_upper");
  } else if(self.lasttorsoanim == "torso_lower") {
    var3 = scripts\asm\asm::asm_lookupanimfromalias(var2, "torso_lower");
  } else {
    var3 = scripts\asm\asm::asm_lookupanimfromalias(var3, "default");
  }

  self.lasttorsoanim = undefined;
  return var3;
}

function choosepainanim_standtorso(var0, var1, var2) {
  if(scripts\engine\utility::damagelocationisany("torso_upper")) {
    self.lasttorsoanim = "torso_upper";
    return scripts\asm\asm::asm_lookupanimfromalias(var1, "torso_upper");
  }

  if(scripts\engine\utility::damagelocationisany("torso_lower")) {
    self.lasttorsoanim = "torso_lower";
    return scripts\asm\asm::asm_lookupanimfromalias(var1, "torso_lower");
  }

  self.lasttorsoanim = "default";
  return scripts\asm\asm::asm_lookupanimfromalias(var1, "default");
}

function choosepainanim_stand(var0, var1, var2) {
  if(shouldusedamageshieldanim()) {
    if(self.currentpose == "crouch") {
      return scripts\asm\asm::asm_lookupanimfromalias(var1, "damage_shield_crouch");
    } else if(self.currentpose == "stand") {
      return scripts\asm\asm::asm_lookupanimfromalias(var1, "damage_shield_stand");
    }
  }

  if(scripts\anim\utility_common::isusingsidearm()) {
    return choosepainanim_pistol(var0, var1, var2);
  }

  var3 = [];

  if(scripts\engine\utility::damagelocationisany("torso_upper")) {
    GscBinSkip0(0x2e, var3.size, scripts\asm\asm::asm_lookupanimfromalias(var1, "torso_upper"));
  }

  if(scripts\engine\utility::damagelocationisany("torso_lower")) {
    GscBinSkip0(0x2e, var3.size, scripts\asm\asm::asm_lookupanimfromalias(var1, "torso_lower"));
  }

  if(scripts\engine\utility::damagelocationisany("head", "helmet", "neck")) {
    GscBinSkip0(0x2e, var3.size, scripts\asm\asm::asm_lookupanimfromalias(var1, "head"));
  }

  if(scripts\engine\utility::damagelocationisany("right_arm_upper", "right_arm_lower")) {
    GscBinSkip0(0x2e, var3.size, scripts\asm\asm::asm_lookupanimfromalias(var1, "right_arm"));
  }

  if(scripts\engine\utility::damagelocationisany("left_arm_upper", "left_arm_lower")) {
    GscBinSkip0(0x2e, var3.size, scripts\asm\asm::asm_lookupanimfromalias(var1, "left_arm"));
  }

  if(scripts\engine\utility::damagelocationisany("left_leg_upper", "left_leg_lower", "left_foot")) {
    GscBinSkip0(0x2e, var3.size, scripts\asm\asm::asm_lookupanimfromalias(var1, "left_leg"));
  }

  if(scripts\engine\utility::damagelocationisany("right_leg_upper", "right_leg_lower", "right_foot")) {
    GscBinSkip0(0x2e, var3.size, scripts\asm\asm::asm_lookupanimfromalias(var1, "right_leg"));
  }

  if(var3.size < 2) {
    GscBinSkip0(0x2e, var3.size, scripts\asm\asm::asm_lookupanimfromalias(var1, "default"));
  }

  return var3[randomint(var3.size)];
}

function choosepainanim_damageshield(var0, var1, var2) {
  if(shouldusedamageshieldanim()) {
    if(self.currentpose == "crouch") {
      return scripts\asm\asm::asm_lookupanimfromalias(var1, "damage_shield_crouch");
    } else if(self.currentpose == "stand") {
      return scripts\asm\asm::asm_lookupanimfromalias(var1, "damage_shield_stand");
    }
  }

  var3 = [];

  if(var3.size < 2) {
    GscBinSkip0(0x2e, var3.size, scripts\asm\asm::asm_lookupanimfromalias(var1, "default"));
  }

  return var3[randomint(var3.size)];
}

function choosedynamicpainanim_expcrouchlegs(var0, var1, var2) {
  var3 = [];
  GscBinSkip0(0x2e, var3.size, scripts\asm\asm::asm_lookupanimfromalias(var1, "default"));
}

function choosepainanim_crouch(var0, var1, var2) {
  var3 = [];
  GscBinSkip0(0x2e, var3.size, scripts\asm\asm::asm_lookupanimfromalias(var1, "default"));
}

function choosepainanim_pistol(var0, var1, var2) {
  var3 = [];

  if(scripts\engine\utility::damagelocationisany("torso_upper")) {
    GscBinSkip0(0x2e, var3.size, scripts\asm\asm::asm_lookupanimfromalias(var1, "pistol_torso_upper"));
  }

  if(scripts\engine\utility::damagelocationisany("torso_lower")) {
    GscBinSkip0(0x2e, var3.size, scripts\asm\asm::asm_lookupanimfromalias(var1, "pistol_torso_lower"));
  }

  if(scripts\engine\utility::damagelocationisany("neck")) {
    GscBinSkip0(0x2e, var3.size, scripts\asm\asm::asm_lookupanimfromalias(var1, "pistol_neck"));
  }

  if(scripts\engine\utility::damagelocationisany("head")) {
    GscBinSkip0(0x2e, var3.size, scripts\asm\asm::asm_lookupanimfromalias(var1, "pistol_head"));
  }

  if(scripts\engine\utility::damagelocationisany("left_leg_upper", "right_leg_upper")) {
    GscBinSkip0(0x2e, var3.size, scripts\asm\asm::asm_lookupanimfromalias(var1, "pistol_leg"));
  }

  if(scripts\engine\utility::damagelocationisany("left_arm_upper")) {
    GscBinSkip0(0x2e, var3.size, scripts\asm\asm::asm_lookupanimfromalias(var1, "pistol_left_arm_upper"));
  }

  if(scripts\engine\utility::damagelocationisany("left_arm_lower")) {
    GscBinSkip0(0x2e, var3.size, scripts\asm\asm::asm_lookupanimfromalias(var1, "pistol_left_arm_lower"));
  }

  if(scripts\engine\utility::damagelocationisany("right_arm_upper")) {
    GscBinSkip0(0x2e, var3.size, scripts\asm\asm::asm_lookupanimfromalias(var1, "pistol_right_arm_upper"));
  }

  if(scripts\engine\utility::damagelocationisany("right_arm_lower")) {
    GscBinSkip0(0x2e, var3.size, scripts\asm\asm::asm_lookupanimfromalias(var1, "pistol_right_arm_lower"));
  }

  if(var3.size < 2) {
    GscBinSkip0(0x2e, var3.size, scripts\asm\asm::asm_lookupanimfromalias(var1, "pistol_default"));
  }

  return var3[randomint(var3.size)];
}

function choosepainanim_run(var0, var1, var2) {
  var3 = 30;
  var4 = 150;
  var5 = 300;
  var6 = [];
  var7 = 0;
  var8 = 0;
  var9 = 0;
  var10 = navtrace(self.origin, self localtoworldcoords((var5, 0, 0)), self, 1);

  if(var10["fraction"] > 0.9) {
    var8 = 1;
  }

  if(var10["fraction"] > 0.9 * var4 / var5) {
    var7 = 1;
  }

  if(isDefined(self.a.disablelongpain)) {
    var8 = 0;
    var7 = 0;
  }

  var11 = length(self.velocity);
  var12 = scripts\asm\shared\utility::getbasearchetype();
  var13 = getnextlowestspeedthresholdstring(var12, var11);

  if(var8) {
    var14 = "long" + var13;
    var6 = scripts\asm\asm::asm_lookupanimfromalias(var1, var14);
  } else if(var7) {
    var14 = "medium" + var13;
    var6 = scripts\asm\asm::asm_lookupanimfromalias(var1, var14);
  } else if(var10["fraction"] > 0.9 * var3 / var5) {
    var14 = "short" + var13;
    var6 = scripts\asm\asm::asm_lookupanimfromalias(var1, var14);
  }

  if(var6.size == 0) {
    return scripts\asm\asm::asm_lookupanimfromalias(var1, "emergency_backup");
  }

  return var6[randomint(var6.size)];
}

function choosepainanim_tocoverhide_helper(var0, var1, var2, var3) {
  return scripts\asm\asm::asm_chooseanim(var0, var1, var2);
}

function choosepainanim_tocoverhide(var0, var1, var2) {
  return scripts\asm\soldier\cover::getstopdatafortransition(var0, var1, &choosepainanim_tocoverhide_helper);
}

function choosepainanim_covercorner_helper(var0, var1, var2, var3) {
  if(isDefined(var2) && isDefined(var2[1])) {
    return scripts\asm\asm::asm_lookupanimfromalias(var1, var2[1]);
  }

  if(self.currentpose == "crouch") {
    return scripts\asm\asm::asm_lookupanimfromalias(var1, "crouch");
  }

  return scripts\asm\asm::asm_lookupanimfromalias(var1, "stand");
}

function choosepainanim_covercorner_tocoverhide(var0, var1, var2) {
  return scripts\asm\soldier\cover::getstopdatafortransition(var0, var1, &choosepainanim_covercorner_helper);
}

function choosepainanim_covercorner(var0, var1, var2) {
  return choosepainanim_covercorner_helper(var0, var1, var2, undefined);
}

function choosedynamicpainanim_back(var0, var1, var2) {
  var3 = "back";
  return scripts\asm\asm::asm_lookupanimfromalias(var1, var3);
}

function choosepainanim_covercrouch(var0, var1, var2) {
  var3 = "crouch";

  if(isDefined(var2)) {
    var3 = var3 + "_" + var2;
  }

  return scripts\asm\asm::asm_lookupanimfromalias(var1, var3);
}

function choosedynamicpainanim_covercrouch(var0, var1, var2) {
  var3 = [];

  if(scripts\engine\utility::damagelocationisany("torso_upper", "torso_lower")) {
    GscBinSkip0(0x2e, var3.size, scripts\asm\asm::asm_lookupanimfromalias(var1, "torso"));
  }

  if(scripts\engine\utility::damagelocationisany("head", "helmet", "neck")) {
    GscBinSkip0(0x2e, var3.size, scripts\asm\asm::asm_lookupanimfromalias(var1, "head"));
  }

  if(var3.size < 2) {
    GscBinSkip0(0x2e, var3.size, scripts\asm\asm::asm_lookupanimfromalias(var1, "default"));
  }

  return var3[randomint(var3.size)];
}

function choosepainanim_coverstand(var0, var1, var2) {
  var3 = "stand";

  if(isDefined(var2) && isDefined(var2)) {
    var3 = var3 + "_" + var2;
  }

  return scripts\asm\asm::asm_lookupanimfromalias(var1, var3);
}

function choosedynamicpainanim_coverstand(var0, var1, var2) {
  var3 = [];

  if(scripts\engine\utility::damagelocationisany("torso_upper")) {
    GscBinSkip0(0x2e, var3.size, scripts\asm\asm::asm_lookupanimfromalias(var1, "torso_upper"));
  }

  if(scripts\engine\utility::damagelocationisany("torso_lower")) {
    GscBinSkip0(0x2e, var3.size, scripts\asm\asm::asm_lookupanimfromalias(var1, "torso_lower"));
  }

  if(scripts\engine\utility::damagelocationisany("head", "helmet", "neck")) {
    GscBinSkip0(0x2e, var3.size, scripts\asm\asm::asm_lookupanimfromalias(var1, "head"));
  }

  if(scripts\engine\utility::damagelocationisany("right_arm_upper", "right_arm_lower")) {
    GscBinSkip0(0x2e, var3.size, scripts\asm\asm::asm_lookupanimfromalias(var1, "right_arm"));
  }

  if(scripts\engine\utility::damagelocationisany("left_arm_upper", "left_arm_lower")) {
    GscBinSkip0(0x2e, var3.size, scripts\asm\asm::asm_lookupanimfromalias(var1, "left_arm"));
  }

  if(scripts\engine\utility::damagelocationisany("left_leg_upper", "left_leg_lower", "left_foot")) {
    GscBinSkip0(0x2e, var3.size, scripts\asm\asm::asm_lookupanimfromalias(var1, "left_leg"));
  }

  if(scripts\engine\utility::damagelocationisany("right_leg_upper", "right_leg_lower", "right_foot")) {
    GscBinSkip0(0x2e, var3.size, scripts\asm\asm::asm_lookupanimfromalias(var1, "right_leg"));
  }

  if(var3.size < 2) {
    GscBinSkip0(0x2e, var3.size, scripts\asm\asm::asm_lookupanimfromalias(var1, "default"));
  }

  return var3[randomint(var3.size)];
}

function choosepainanimdeafened(var0, var1, var2) {
  var3 = 3;
  var4 = "deaf_" + randomint(var3) + 1;
  return scripts\asm\asm::asm_lookupanimfromalias(var1, var4);
}

function cleanuppainanim(var0, var1, var2) {
  if(isDefined(self.script) && self.script == "pain") {
    self notify("killanimscript");
  }

  if(isDefined(self.damageshieldpain)) {
    self.damageshieldcounter = undefined;
    self.damageshieldpain = undefined;
    self.allowpain = 1;

    if(!isDefined(self.predamageshieldignoreme)) {
      self.ignoreme = 0;
    }

    self.predamageshieldignoreme = undefined;
  }

  if(isDefined(self.blockingpain)) {
    self.blockingpain = undefined;
    self.allowpain = 1;
  }

  clearpainturnrate(var0, var1, var2);

  if(istrue(self.leavecasualkiller)) {
    scripts\asm\soldier\script_funcs::terminate_casualkiller(var0, var1, var2);
  }

  if(!istrue(self.ignoreall)) {
    if(isDefined(self.enemy) && lengthsquared(self.velocity) < 1 && isDefined(self.weapon) && !istrue(self.enemy.ignoreme) && self cansee(self.enemy)) {
      self.remainexposedendtime = gettime() + 2000;
      return;
    }

    return;
  }
}

function transition_flashfinished(var0, var1, var2, var3) {
  if(!scripts\engine\utility::isflashed()) {
    return true;
  }

  if(gettime() > self.flashendtime) {
    return true;
  }

  return scripts\asm\asm::asm_eventfired(var0, "end") || scripts\asm\asm::asm_eventfired(var0, "finish");
}

function iscovercrouch(var0, var1, var2, var3) {
  if(!isDefined(self._blackboard.covernode)) {
    return 0;
  }

  if(isDefined(self._blackboard.covernode.type) && self._blackboard.covernode.type == "Cover Crouch") {
    return 1;
  }

  return 0;
}

function iscoverstand(var0, var1, var2, var3) {
  if(!isDefined(self._blackboard.covernode)) {
    return 0;
  }

  if(isDefined(self._blackboard.covernode.type) && self._blackboard.covernode.type == "Cover Stand") {
    return 1;
  }

  return 0;
}

function iscoverright_crouch(var0, var1, var2, var3) {
  if(!isDefined(self._blackboard.covernode)) {
    return 0;
  }

  if(isDefined(self._blackboard.covernode.type) && self._blackboard.covernode.type == "Cover Right" && isDefined(self.currentpose) && self.currentpose == "crouch") {
    return 1;
  }

  return 0;
}

function iscoverright_stand(var0, var1, var2, var3) {
  if(!isDefined(self._blackboard.covernode)) {
    return 0;
  }

  if(isDefined(self._blackboard.covernode.type) && self._blackboard.covernode.type == "Cover Right" && isDefined(self.currentpose) && self.currentpose == "stand") {
    return 1;
  }

  return 0;
}

function iscoverleft_crouch(var0, var1, var2, var3) {
  if(!isDefined(self._blackboard.covernode)) {
    return 0;
  }

  if(isDefined(self._blackboard.covernode.type) && self._blackboard.covernode.type == "Cover Left" && isDefined(self.currentpose) && self.currentpose == "crouch") {
    return 1;
  }

  return 0;
}

function iscoverleft_stand(var0, var1, var2, var3) {
  if(!isDefined(self._blackboard.covernode)) {
    return 0;
  }

  if(isDefined(self._blackboard.covernode.type) && self._blackboard.covernode.type == "Cover Left" && isDefined(self.currentpose) && self.currentpose == "stand") {
    return 1;
  }

  return 0;
}

function isexposed_crouch(var0, var1, var2, var3) {
  if(!isDefined(self._blackboard.covernode)) {
    return 0;
  }

  if(isDefined(self._blackboard.covernode.type) && self._blackboard.covernode.type == "Exposed" && isDefined(self.currentpose) && self.currentpose == "crouch") {
    return 1;
  }

  return 0;
}

function isexposed_prone(var0, var1, var2, var3) {
  if(!isDefined(self._blackboard.covernode)) {
    return 0;
  }

  if(isDefined(self._blackboard.covernode.type) && self._blackboard.covernode.type == "Exposed" && isDefined(self.currentpose) && self.currentpose == "prone") {
    return 1;
  }

  return 0;
}

function playanim_flashed(var0, var1, var2) {
  self endon(var1 + "_finished");
  playanim_flashed_internal(var0, var1);
  thread playanim_monitorflashrestart(var0, var1);
  scripts\asm\asm::asm_donotetracks(var0, var1);
}

function playanim_flashed_internal(var0, var1) {
  var2 = scripts\asm\asm::asm_getanim(var0, var1);
  var3 = 1;

  if(isDefined(self.flashendtime)) {
    var4 = self.flashendtime - gettime();
    var5 = scripts\asm\asm::asm_getxanim(var1, var2);
    var6 = getanimlength(var5) * 1000;

    if(var4 > 0) {
      var3 = var6 / var4;
    }

    var3 += randomfloatrange(-0.2, 0.2);
    var3 = clamp(var3, 0.2, 1.65);
  }

  self aisetanim(var1, var2, var3);
}

function playanim_monitorflashrestart(var0, var1) {
  self endon(var1 + "_finished");
  var2 = self.flashendtime;

  while(isDefined(self.flashendtime)) {
    if(var2 != self.flashendtime) {
      var2 = self.flashendtime;
      playanim_flashed_internal(var0, var1);
    }

    waitframe();
  }
}

function chooseanim_flashed(var0, var1, var2) {
  var3 = "med";

  if(isDefined(self.flashendtime)) {
    var4 = self.flashendtime - gettime();

    if(var4 <= 3750) {
      var3 = "short";
    } else if(var4 >= 5250) {
      var3 = "med";
    }
  }

  var5 = scripts\asm\asm::asm_lookupanimfromalias(var1, var3);
  return scripts\asm\shared\utility::preventrecentanimindex(var1, var3, var5);
}

function cleanupflashanim(var0, var1, var2) {
  cleanuppainanim(var0, var1, var2);
  scripts\common\utility::flashbangstop();
}

function playanim_burning(var0, var1, var2) {
  self endon(var1 + "_finished");
  var3 = scripts\asm\asm::asm_getanim(var0, var1, var2);
  var4 = randomfloatrange(0.8, 1.2);
  self orientmode("face angle", self.angles[1]);
  self aisetanim(var1, var3, var4);
  scripts\asm\asm::asm_donotetracks(var0, var1, &burn_notetrack_handler);
}

function burn_notetrack_handler(var0) {
  if(isDefined(self.semtexstuckto)) {
    return;
  }

  switch (var0) {
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

function chooseanim_burning(var0, var1, var2) {
  var3 = var1;

  if(self.currentpose == "prone") {
    return scripts\asm\asm::asm_lookupanimfromalias(var1, "pain_burning_prone");
  }

  var4 = scripts\engine\utility::ter_op(randomint(2) == 1, "arm", "leg");
  var3 = var3 + "_" + self.burningdirection + "_" + var4;
  var5 = scripts\asm\asm::asm_lookupanimfromalias(var1, var3);
  return scripts\asm\shared\utility::preventrecentanimindex(var1, var3, var5);
}

function shouldpainfaceplayer(var0, var1, var2, var3) {
  var4 = getpaindirectiontoactor();

  if(var4 == "_f") {
    return false;
  }

  self forcethreatupdate();

  if(isDefined(self.enemy) && isDefined(self.lastattacker) && self.enemy == self.lastattacker) {
    var5 = vectorNormalize(self.origin - self.enemy.origin);

    if(vectordot(var5, self.damagedir) > 0.866) {
      return true;
    }
  }

  return false;
}

function shouldpaincoverfaceplayer(var0, var1, var2, var3) {
  if(shouldpainfaceplayer(var0, var1, var2, var3)) {
    var4 = 1;

    if(isDefined(self.covernode) && scripts\aitypes\cover::shouldbeinlmgcover()) {
      var4 = scripts\aitypes\cover::iscovervalidforlmg(self.covernode);
    } else {
      var4 = scripts\asm\shared\utility::iscovervalid();
    }

    return !var4;
  }

  return false;
}

function shouldpainrunfaceplayer(var0, var1, var2, var3) {
  var4 = getpaindirectiontoactor();

  if(var4 == "_f") {
    return false;
  }

  if(lengthsquared(self.velocity) > 3600) {
    return false;
  }

  self forcethreatupdate();

  if(isDefined(self.enemy) && isPlayer(self.enemy)) {
    return true;
  }

  return false;
}

function choosepainanim_faceplayer(var0, var1, var2) {
  var3 = getpaindirectiontoactor();
  self.asm.aliaspain = "torso_md" + var3;
  self.asm.painloc = "midbody";
  self.asm.painsize = "_md";
  return scripts\asm\asm::asm_lookupanimfromalias(var1, self.asm.aliaspain);
}

function painanimfaceenemy(var0, var1, var2) {
  self endon(var1 + "_finished");
  var3 = scripts\asm\asm::asm_getanim(var0, var1);
  var4 = scripts\asm\asm::asm_getxanim(var1, var3);
  var5 = getanimlength(var4);
  var6 = var5 * 0.8;
  var7 = var5;
  var8 = getnotetracktimes(var4, "face_enemy")[0];

  if(isDefined(var8)) {
    var6 = var8 * var5;
  } else {
    if(scripts\asm\asm::asm_currentstatehasflag(var0, "notetrackAim")) {
      var9 = getnotetracktimes(var4, "start_aim")[0];

      if(isDefined(var9)) {
        var6 = min(var6, max(0, var9 - 0.3) * var5);
        var7 = var9 * var5;
      }
    }

    var6 = min(var6, max(0, var5 - 0.5));
  }

  wait var6;

  if(isalive(var2)) {
    self.painoldturnrate = self.turnrate;
    self.turnrate = 0.1;
    self orientmode("face enemy");
    return;
  }
}

function playpainanim_faceplayer(var0, var1, var2) {
  self endon(var1 + "_finished");

  if(isalive(self.enemy) && isDefined(self.lastattacker) && self.enemy == self.lastattacker) {
    thread painanimfaceenemy(var0, var1, self.enemy);
  }

  playpainaniminternal(var0, var1, var2, 0, 1, undefined, 1);
}

function playpainanim_exposedstand(var0, var1, var2) {
  self endon(var1 + "_finished");

  if(isalive(self.enemy) && isDefined(self.lastattacker) && self.enemy == self.lastattacker) {
    thread painanimfaceenemy(var0, var1, self.enemy);
  }

  playpainaniminternal(var0, var1, var2, 0, 1);
}

function playpainanim_exposedcrouch(var0, var1, var2) {
  self endon(var1 + "_finished");
  self.painattacker = self.lastattacker;
  playpainaniminternal(var0, var1, var2, 0, 1);
}

function playpainanim_exposedcrouchtransition(var0, var1, var2) {
  self endon(var1 + "_finished");

  if(isalive(self.enemy) && isDefined(self.painattacker) && self.enemy == self.painattacker) {
    thread painanimfaceenemy(var0, var1, self.enemy);
  }

  self.painattacker = undefined;
  scripts\asm\shared\utility::playanim(var0, var1, var2);
}

function clearpainturnrate(var0, var1, var2) {
  if(isDefined(self.painoldturnrate)) {
    self.turnrate = self.painoldturnrate;
    self.painoldturnrate = undefined;
    return;
  }
}