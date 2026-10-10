/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\asm\soldier\pain.gsc
***********************************************/

#using scripts\anim\battlechatter_events;
#using scripts\anim\face;
#using scripts\anim\shared;
#using scripts\anim\utility;
#using scripts\anim\utility_common;
#using scripts\asm\asm;
#using scripts\asm\shared\utility;
#using scripts\asm\soldier\death;
#using scripts\asm\soldier\script_funcs;
#using scripts\common\utility;
#using scripts\engine\utility;
#namespace pain;

function isdamagelocation_rarm(asmname, statename, tostatename, params) {
  if(!self.damageshield) {
    return damagelocationisany("right_arm_upper", "right_arm_lower", "right_hand");
  }

  return 0;
}

function isdamagelocation_rleg(asmname, statename, tostatename, params) {
  if(!self.damageshield) {
    return damagelocationisany("right_leg_upper", "right_foot", "right_leg_lower");
  }

  return 0;
}

function isdamagelocation_lleg(asmname, statename, tostatename, params) {
  if(!self.damageshield) {
    return damagelocationisany("left_leg_upper", "left_foot", "left_leg_lower");
  }

  return 0;
}

function isdamagelocation_larm(asmname, statename, tostatename, params) {
  if(!self.damageshield) {
    return damagelocationisany("left_arm_upper", "left_arm_lower", "left_hand");
  }

  return 0;
}

function isdamagelocation_torso(asmname, statename, tostatename, params) {
  if(!self.damageshield) {
    return damagelocationisany("torso_upper", "torso_lower");
  }

  return 0;
}

function isdamagelocation_head(asmname, statename, tostatename, params) {
  if(!self.damageshield) {
    return damagelocationisany("head", "neck", "helmet");
  }

  return 0;
}

function isdamagelocation_larmcrouch(asmname, statename, tostatename, params) {
  return damagelocationisany("left_hand", "left_arm_upper", "left_arm_lower", "left_leg_upper", "left_leg_lower", "left_foot", "torso_lower");
}

function isdamagelocation_back(asmname, statename, tostatename, params) {
  if(!self.damageshield) {
    if(gethumandamagedirstring() == 1 && !damagelocationisany("left_leg_upper", "left_leg_lower", "left_foot", "right_leg_upper", "right_leg_lower", "right_foot")) {
      return true;
    }
  }

  return false;
}

function isdamagelocation_torsocovercrouch(asmname, statename, tostatename, params) {
  return damagelocationisany("right_arm_upper", "right_arm_lower", "right_hand", "left_hand", "left_arm_upper", "left_arm_lower", "left_leg_upper", "left_leg_lower", "left_foot", "right_leg_upper", "right_leg_lower", "right_foot");
}

function choosepainanimshock(asmname, statename, params) {
  return asm_lookupanimfromalias(statename, "shock_loop_" + self.currentpose);
}

function playsonicshockfx() {
  if(utility::isdamageweapon(makeweapon("iw7_sonic")) && utility::isweaponepic(self.damageweapon)) {
    playFXOnTag(level.g_effect["soldier_shock"], self, "j_knee_ri");
    playFXOnTag(level.g_effect["soldier_shock"], self, "j_shoulder_ri");
  }
}

function playshockpainloop(asmname, statename, params) {
  self endon("death");
  self endon(statename + "_finished");
  painanim = asm_getanim(asmname, statename);
  loop_time = ter_op(isDefined(self.empstuntime), self.empstuntime, 3.5);
  playsonicshockfx();
  self animmode("zonly_physics", 0);
  wait randomfloat(0.3);

  if(self.asmname == "c6" || self.asmname == "c6_worker") {
    thread shockpainloop_internal(self.asmname, statename, 1, 0, 1);
    self playSound("generic_flashbang_c6_1");
  } else {
    thread shockpainloop_internal(self.asmname, statename, 1, 0);
  }

  wait loop_time;
  self notify("painloop_end");
  asm_fireevent(asmname, "stop_loop_pain");
  self.emplooptime = undefined;
  finishpain(asmname, statename, params);
}

function shockpainloop_c6_cleanup(asmname, statename, params) {
  self stopsounds();
}

function shockpainloop_internal(asmname, statename, playbackrate, ismovestate, allowrandom) {
  self endon(statename + "_finished");
  self endon("painloop_end");

  if(isDefined(ismovestate) && ismovestate) {
    moveknob = asm_lookupanimfromaliasifexists("knobs", "move");

    if(isDefined(moveknob)) {
      self setmoveanimknob(moveknob);
    }
  }

  prevanim = asm_getbodyknob();
  curanim = asm_getanim(asmname, statename);

  while(true) {
    if(isDefined(allowrandom)) {
      curanim = asm_getanim(asmname, statename);
    }

    curxanim = asm_getxanim(statename, curanim);
    self aisetanim(statename, curanim, playbackrate);
    asm_playfacialanim(asmname, statename, curxanim);
    prevanim = curanim;
    asm_donotetrackssingleloop(asmname, statename, curxanim, asm_getnotehandler(asmname, statename));
  }
}

function chooseshockpainrecovery(asmname, statename, params) {
  return asm_lookupanimfromalias(statename, "shock_finish_" + self.currentpose);
}

function playpainanim(asmname, statename, params) {
  playpainaniminternal(asmname, statename, params, 0);
}

function playpainanimwithadditives(asmname, statename, params) {
  playpainaniminternal(asmname, statename, params, 1);
}

function playpainanimlmg(asmname, statename, params) {
  self._blackboard.inlmgstate = 1;
  playpainaniminternal(asmname, statename, params, 0);
}

function pain_can_use_handler(note, params) {
  if(note == "pain_can_end") {
    return 1;
  }
}

function getpainweaponsize() {
  size = "_md";
  weaponsize = "rifle";
  objweapon = self.damageweapon;

  if(isDefined(objweapon) && objweapon.basename != "iw8_sn_mike14") {
    weaponsize = objweapon.classname;
  }

  if(weaponsize == "pistol" || weaponsize == "smg") {
    size = "_md";
  } else if(weaponsize == "spread") {
    size = "_md";

    if(isDefined(self.lastattacker) && distancesquared(self.lastattacker.origin, self.origin) <= 62500) {
      size = "_lg";
    }
  } else if(weaponsize == "sniper" || weaponsize == "mg") {
    size = "_lg";
  } else if(weaponsize == "grenade" && isDefined(self.damagemod) && self.damagemod == "MOD_IMPACT") {
    size = "_lg";
  }

  if(isDefined(level.fnasmsoldiergetpainweaponsize)) {
    size = self[[level.fnasmsoldiergetpainweaponsize]](size);
  }

  return size;
}

function getpaindirectiontoactor() {
  if(isDefined(self.damageyaw) && self.damageyaw >= -45 && self.damageyaw <= 45) {
    dir = "_b";
    return dir;
  }

  if(isDefined(self.damageyaw) && self.damageyaw < -45 && self.damageyaw > -135) {
    dir = "_l";
    return dir;
  }

  if(isDefined(self.damageyaw) && self.damageyaw > 45 && self.damageyaw < 135) {
    dir = "_r";
    return dir;
  }

  dir = "_f";
  return dir;
}

function choosedirectionalpainanim_transition(asmname, statename, params) {
  if(isDefined(self.var_872a8e737f3e5358)) {
    var_6ad9995dd505716a = self.var_872a8e737f3e5358;
    return asm_lookupanimfromalias(statename, var_6ad9995dd505716a);
  }

  return asm_getrandomanim(statename);
}

function playpainaniminternal(asmname, statename, params, var_837bcc3e005feb5d, var_96d69c0cc6fb90c1, statenameoverride, var_b6a66cc6c81067a0, var_94987ccb5819c6e9) {
  self endon(statename + "_finished");

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

  self.a.painplaying = 1;

  if(isDefined(self.painfunction)) {
    shouldcontinue = [[self.painfunction]]();

    if(!istrue(shouldcontinue)) {
      self.a.painplaying = undefined;
      return;
    }
  }

  self animmode("gravity");

  if(!istrue(var_b6a66cc6c81067a0)) {
    self orientmode("face angle", self.angles[1]);
  }

  if(!isDefined(self.no_pain_sound)) {
    scripts\anim\face::saygenericdialogue("pain");
  }

  if(scripts\asm\soldier\death::shouldhelmetpoponpain(utility::wasdamagedbyexplosive())) {
    scripts\asm\soldier\death::helmetpop();
  }

  animstatename = statename;

  if(isDefined(statenameoverride)) {
    animstatename = statenameoverride;
  }

  painanim = asm_getanim(asmname, statename, params);
  assert(isDefined(painanim));
  self aisetanim(animstatename, painanim);
  painxanim = asm_getxanim(animstatename, painanim);
  asm_playfacialanim(asmname, statename, painxanim);

  if(isDefined(var_94987ccb5819c6e9)) {
    self thread[[var_94987ccb5819c6e9]](asmname, statename, painanim, painxanim);
  }

  self.requestdifferentcover = 1;

  if(animhasnotetrack(painxanim, "code_move")) {
    asm_donotetracks(asmname, statename, undefined, undefined, animstatename);
  }

  asm_donotetracks(asmname, statename, asm_getnotehandler(asmname, statename), undefined, animstatename);

  if(istrue(var_96d69c0cc6fb90c1)) {
    finishpain(asmname, statename, params);
    return;
  }

  finishpain(asmname, statename);
}

function paincanend(statename, notename) {
  switch (notename) {
    case #"hash_b28f889d3f68dd76":
      return 1;
  }
}

function coverexppainselectreturna(asmname, statename, params) {
  if(isDefined(self._blackboard.coverexposetype) && self._blackboard.coverexposetype == "A") {
    return 1;
  }

  return 0;
}

function finishpain(asmname, statename, params) {
  self.a.painplaying = undefined;
  self notify("killanimscript");
  returnstate = undefined;

  if(isDefined(params)) {
    if(isarray(params)) {
      returnstate = params[0];
    } else {
      returnstate = params;
    }
  }

  if(!isDefined(returnstate)) {
    return;
  }

  thread asm_setstate(returnstate, undefined);
}

function playcoverpainanimwithadditives(asmname, statename, params) {
  self.keepclaimednodeifvalid = 1;
  playpainaniminternal(asmname, statename, params, 1);
}

function playcoverpainanim(asmname, statename, params) {
  self.keepclaimednodeifvalid = 1;
  playpainanim(asmname, statename, params);
}

function choosepainanim_standtorsotoexposed(asmname, statename, params) {
  assert(isDefined(self.lasttorsoanim));

  if(self.lasttorsoanim == "torso_upper") {
    transitionanim = asm_lookupanimfromalias(statename, "torso_upper");
  } else if(self.lasttorsoanim == "torso_lower") {
    transitionanim = asm_lookupanimfromalias(statename, "torso_lower");
  } else {
    transitionanim = asm_lookupanimfromalias(statename, "default");
  }

  self.lasttorsoanim = undefined;
  return transitionanim;
}

function choosepainanim_standtorso(asmname, statename, params) {
  if(damagelocationisany("torso_upper")) {
    self.lasttorsoanim = "torso_upper";
    return asm_lookupanimfromalias(statename, "torso_upper");
  }

  if(damagelocationisany("torso_lower")) {
    self.lasttorsoanim = "torso_lower";
    return asm_lookupanimfromalias(statename, "torso_lower");
  }

  self.lasttorsoanim = "default";
  return asm_lookupanimfromalias(statename, "default");
}

function choosepainanim_stand(asmname, statename, params) {
  if(isusingsidearm()) {
    return choosepainanim_pistol(asmname, statename, params);
  }

  painarray = [];

  if(damagelocationisany("torso_upper")) {
    painarray[painarray.size] = asm_lookupanimfromalias(statename, "torso_upper");
  } else if(damagelocationisany("torso_lower")) {
    painarray[painarray.size] = asm_lookupanimfromalias(statename, "torso_lower");
  } else if(damagelocationisany("head", "helmet", "neck")) {
    painarray[painarray.size] = asm_lookupanimfromalias(statename, "head");
  } else if(damagelocationisany("right_arm_upper", "right_arm_lower")) {
    painarray[painarray.size] = asm_lookupanimfromalias(statename, "right_arm");
  } else if(damagelocationisany("left_arm_upper", "left_arm_lower")) {
    painarray[painarray.size] = asm_lookupanimfromalias(statename, "left_arm");
  } else if(damagelocationisany("left_leg_upper", "left_leg_lower", "left_foot")) {
    painarray[painarray.size] = asm_lookupanimfromalias(statename, "left_leg");
  } else if(damagelocationisany("right_leg_upper", "right_leg_lower", "right_foot")) {
    painarray[painarray.size] = asm_lookupanimfromalias(statename, "right_leg");
  }

  if(painarray.size < 2) {
    painarray[painarray.size] = asm_lookupanimfromalias(statename, "default");
  }

  assertex(painarray.size > 0, painarray.size);
  return painarray[randomint(painarray.size)];
}

function choosepainanim_damageshield(asmname, statename, params) {
  painarray = [];

  if(painarray.size < 2) {
    painarray[painarray.size] = asm_lookupanimfromalias(statename, "default");
  }

  assertex(painarray.size > 0, painarray.size);
  return painarray[randomint(painarray.size)];
}

function choosedynamicpainanim_expcrouchlegs(asmname, statename, params) {
  painarray = [];
  painarray[painarray.size] = asm_lookupanimfromalias(statename, "default");
  assertex(painarray.size > 0, painarray.size);
  return painarray[randomint(painarray.size)];
}

function choosepainanim_crouch(asmname, statename, params) {
  painarray = [];
  painarray[painarray.size] = asm_lookupanimfromalias(statename, "default");

  if(damagelocationisany("left_hand", "left_arm_lower", "left_arm_upper")) {
    painarray[painarray.size] = asm_lookupanimfromalias(statename, "left_arm");
  }

  if(damagelocationisany("right_hand", "right_arm_lower", "right_arm_upper")) {
    painarray[painarray.size] = asm_lookupanimfromalias(statename, "right_arm");
  }

  assertex(painarray.size > 0, painarray.size);
  return painarray[randomint(painarray.size)];
}

function choosepainanim_pistol(asmname, statename, params) {
  painarray = [];

  if(damagelocationisany("torso_upper")) {
    painarray[painarray.size] = asm_lookupanimfromalias(statename, "pistol_torso_upper");
  } else if(damagelocationisany("torso_lower")) {
    painarray[painarray.size] = asm_lookupanimfromalias(statename, "pistol_torso_lower");
  } else if(damagelocationisany("neck")) {
    painarray[painarray.size] = asm_lookupanimfromalias(statename, "pistol_neck");
  } else if(damagelocationisany("head")) {
    painarray[painarray.size] = asm_lookupanimfromalias(statename, "pistol_head");
  } else if(damagelocationisany("left_leg_upper", "right_leg_upper")) {
    painarray[painarray.size] = asm_lookupanimfromalias(statename, "pistol_leg");
  } else if(damagelocationisany("left_arm_upper")) {
    painarray[painarray.size] = asm_lookupanimfromalias(statename, "pistol_left_arm_upper");
  } else if(damagelocationisany("left_arm_lower")) {
    painarray[painarray.size] = asm_lookupanimfromalias(statename, "pistol_left_arm_lower");
  } else if(damagelocationisany("right_arm_upper")) {
    painarray[painarray.size] = asm_lookupanimfromalias(statename, "pistol_right_arm_upper");
  } else if(damagelocationisany("right_arm_lower")) {
    painarray[painarray.size] = asm_lookupanimfromalias(statename, "pistol_right_arm_lower");
  }

  if(painarray.size < 2) {
    painarray[painarray.size] = asm_lookupanimfromalias(statename, "pistol_default");
  }

  assertex(painarray.size > 0, painarray.size);
  return painarray[randomint(painarray.size)];
}

function choosepainanim_covercorner_helper(asmname, statename, params, angles) {
  if(isDefined(params) && isDefined(params[1])) {
    return asm_lookupanimfromalias(statename, params[1]);
  }

  if(self.currentpose == "crouch") {
    return asm_lookupanimfromalias(statename, "crouch");
  }

  return asm_lookupanimfromalias(statename, "stand");
}

function choosepainanim_covercorner(asmname, statename, params) {
  return choosepainanim_covercorner_helper(asmname, statename, params, undefined);
}

function choosedynamicpainanim_back(asmname, statename, params) {
  alias = "back";
  return asm_lookupanimfromalias(statename, alias);
}

function choosedynamicpainanim_covercrouch(asmname, statename, params) {
  painarray = [];

  if(damagelocationisany("torso_upper", "torso_lower")) {
    painarray[painarray.size] = asm_lookupanimfromalias(statename, "torso");
  } else if(damagelocationisany("head", "helmet", "neck")) {
    painarray[painarray.size] = asm_lookupanimfromalias(statename, "head");
  }

  if(painarray.size < 2) {
    painarray[painarray.size] = asm_lookupanimfromalias(statename, "default");
  }

  assertex(painarray.size > 0, painarray.size);
  return painarray[randomint(painarray.size)];
}

function choosedynamicpainanim_coverstand(asmname, statename, params) {
  painarray = [];

  if(damagelocationisany("torso_upper")) {
    painarray[painarray.size] = asm_lookupanimfromalias(statename, "torso_upper");
  } else if(damagelocationisany("torso_lower")) {
    painarray[painarray.size] = asm_lookupanimfromalias(statename, "torso_lower");
  } else if(damagelocationisany("head", "helmet", "neck")) {
    painarray[painarray.size] = asm_lookupanimfromalias(statename, "head");
  } else if(damagelocationisany("right_arm_upper", "right_arm_lower")) {
    painarray[painarray.size] = asm_lookupanimfromalias(statename, "right_arm");
  } else if(damagelocationisany("left_arm_upper", "left_arm_lower")) {
    painarray[painarray.size] = asm_lookupanimfromalias(statename, "left_arm");
  } else if(damagelocationisany("left_leg_upper", "left_leg_lower", "left_foot")) {
    painarray[painarray.size] = asm_lookupanimfromalias(statename, "left_leg");
  } else if(damagelocationisany("right_leg_upper", "right_leg_lower", "right_foot")) {
    painarray[painarray.size] = asm_lookupanimfromalias(statename, "right_leg");
  }

  if(painarray.size < 2) {
    painarray[painarray.size] = asm_lookupanimfromalias(statename, "default");
  }

  assertex(painarray.size > 0, painarray.size);
  return painarray[randomint(painarray.size)];
}

function function_9a4a7270010ada09(asmname, statename, params) {
  self aisettargetspeed(length(self.velocity));
  cleanuppainanim(asmname, statename, params);
}

function cleanuppainanim(asmname, statename, params) {
  if(isDefined(self.script) && self.script == "pain") {
    self notify("killanimscript");
  }

  self.a.painplaying = undefined;

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

  self._blackboard.var_74f8f2b8eff7c7f = 0;
  clearpainturnrate(asmname, statename, params);

  if(istrue(self.leavecasualkiller)) {
    scripts\asm\soldier\script_funcs::terminate_casualkiller(asmname, statename, params);
  }

  if(!istrue(self.ignoreall)) {
    if(isDefined(self.enemy) && lengthsquared(self.velocity) < 1 && isDefined(self.weapon) && !istrue(self.enemy.ignoreme) && self cansee(self.enemy)) {
      self.remainexposedendtime = gettime() + 2000;
    }
  }
}

function transition_flashfinished(asmname, fromstate, tostate, params) {
  if(!isflashed()) {
    return true;
  }

  if(gettime() > self.flashendtime) {
    return true;
  }

  return asm_eventfired(asmname, "end") || asm_eventfired(asmname, "finish");
}

function function_f0cf338a66c2a842(asmname, statename, params) {
  if(isDefined(self.stunnedcallback)) {
    self[[self.stunnedcallback]]();
  }

  stunnedanim = asm_getanim(asmname, statename, params);
  self aisetanim(statename, stunnedanim);
  asm_donotetracks(asmname, statename);
}

function function_5f1b71fde3cd5900(asmname, statename, params) {
  stunnedanim = asm_getanim(asmname, statename, params);
  self aisetanim(statename, stunnedanim);
  asm_donotetracks(asmname, statename);
}

function function_e00aa948164f088c(asmname, statename, params) {
  if(isstunned()) {
    return false;
  }

  cleanuppainanim(asmname, statename, params);
  return true;
}

function playanim_flashed(asmname, statename, params) {
  self endon(statename + "_finished");
  playanim_flashed_internal(asmname, statename);
  thread playanim_monitorflashrestart(asmname, statename);
  asm_donotetracks(asmname, statename);
}

function playanim_flashed_internal(asmname, statename) {
  flashanim = asm_getanim(asmname, statename);
  rate = 1;

  if(isDefined(self.flashendtime)) {
    flashlength = self.flashendtime - gettime();
    xanim = asm_getxanim(statename, flashanim);
    animlength = getanimlength(xanim) * 1000;

    if(flashlength > 0) {
      rate = animlength / flashlength;
    }

    rate += randomfloatrange(-0.1, 0.05);
    rate = clamp(rate, 0.65, 1.2);
    self.flashendtime = gettime() + int(animlength / rate);
  }

  self aisetanim(statename, flashanim, rate);
}

function playanim_monitorflashrestart(asmname, statename) {
  self endon(statename + "_finished");
  prevflashendtime = self.flashendtime;

  while(isDefined(self.flashendtime)) {
    if(prevflashendtime != self.flashendtime) {
      playanim_flashed_internal(asmname, statename);
      prevflashendtime = self.flashendtime;
    }

    waitframe();
  }
}

function cleanupflashanim(asmname, statename, params) {
  cleanuppainanim(asmname, statename, params);
  flashbangstop();
}

function playanim_burning(asmname, statename, params) {
  self endon(statename + "_finished");
  var_fc3f189c0832aec2 = scripts\anim\battlechatter_events::function_c666e714b2411844(self.damageweapon);

  if(isDefined(var_fc3f189c0832aec2)) {
    function_216c67ab6749137a(self, undefined, "burn", var_fc3f189c0832aec2);
  }

  burninganim = asm_getanim(asmname, statename, params);
  playrate = randomfloatrange(0.8, 1.2);
  self orientmode("face angle", self.angles[1]);
  self aisetanim(statename, burninganim, playrate);
  asm_donotetracks(asmname, statename, &burn_notetrack_handler);
}

function burn_notetrack_handler(note) {
  if(isDefined(self.semtexstuckto)) {
    return;
  }

  switch (note) {
    case #"hash_b3c1b4729e0c6d1a":
      playFXOnTag(level.g_effect["vfx_burn_sml_head_low"], self, "j_helmet");
      break;
    case #"hash_91b66b1e7d9268f1":
      playFXOnTag(level.g_effect["vfx_burn_sml_low"], self, "j_elbow_le");
      break;
    case #"hash_91b6751e7d9278af":
      playFXOnTag(level.g_effect["vfx_burn_sml_low"], self, "j_shoulder_ri");
      break;
    case #"hash_72c435d66be93437":
      playFXOnTag(level.g_effect["vfx_burn_med_low"], self, "j_knee_le");
      break;
    case #"hash_72c43bd66be93da9":
      playFXOnTag(level.g_effect["vfx_burn_med_low"], self, "j_knee_ri");
      break;
  }
}

function painanimfaceenemy(asmname, statename, animid, xanim) {
  self endon(statename + "_finished");
  enemy = self.enemy;
  animlength = getanimlength(xanim);
  endtime = animlength * 0.8;
  startaimtime = animlength;
  var_6767247f28fabd3c = getnotetracktimes(xanim, "face_enemy")[0];

  if(isDefined(var_6767247f28fabd3c)) {
    endtime = var_6767247f28fabd3c * animlength;
  } else {
    if(asm_currentstatehasflag(asmname, "notetrackAim")) {
      startaimfrac = getnotetracktimes(xanim, "start_aim")[0];

      if(isDefined(startaimfrac)) {
        endtime = min(endtime, max(0, startaimfrac - 0.3) * animlength);
        startaimtime = startaimfrac * animlength;
      }
    }

    endtime = min(endtime, max(0, animlength - 0.5));
  }

  wait endtime;

  if(isalive(enemy)) {
    var_ab47b2ec8e13ed55 = getnotetracktimes(xanim, "face_enemy_end")[0];
    var_253b2641c5fcf77a = 1;

    if(isDefined(var_ab47b2ec8e13ed55)) {
      var_253b2641c5fcf77a = var_ab47b2ec8e13ed55;
    }

    turnduration = getanimlength(xanim) * var_253b2641c5fcf77a - endtime;
    var_e473d197cb34ae13 = gettime() + turnduration * 1000;

    while(gettime() < var_e473d197cb34ae13 && isalive(enemy)) {
      metoenemy = enemy.origin - self.origin;
      angletoenemy = vectortoyaw(metoenemy);
      anglediff = angleclamp180(angletoenemy - self.angles[1]);
      curt = self getanimtime(xanim);
      remainingrot = getangledelta(xanim, curt, var_253b2641c5fcf77a);
      delta = anglediff - remainingrot;
      self orientmode("face angle", self.angles[1] + delta);
      waitframe();
    }
  }
}

function playpainanim_faceplayer(asmname, statename, params) {
  self endon(statename + "_finished");
  fnthread = undefined;

  if(isalive(self.enemy) && isDefined(self.lastattacker) && self.enemy == self.lastattacker) {
    fnthread = &painanimfaceenemy;
  }

  playpainaniminternal(asmname, statename, params, 0, 1, undefined, 1, fnthread);
}

function playpainanim_exposedstand(asmname, statename, params) {
  self endon(statename + "_finished");
  fnthread = undefined;

  if(isalive(self.enemy) && isDefined(self.lastattacker) && self.enemy == self.lastattacker) {
    fnthread = &painanimfaceenemy;
  }

  playpainaniminternal(asmname, statename, params, 0, 1, undefined, 0, fnthread);
}

function playpainanim_exposedcrouch(asmname, statename, params) {
  self endon(statename + "_finished");
  self.painattacker = self.lastattacker;
  playpainaniminternal(asmname, statename, params, 0, 1);
}

function playpainanim_exposedcrouchtransition(asmname, statename, params) {
  self endon(statename + "_finished");
  animid = asm_getanim(asmname, statename);
  self aisetanim(statename, animid);
  asm_playfacialanim(asmname, statename, asm_getxanim(statename, animid));

  if(isalive(self.enemy) && isDefined(self.painattacker) && self.enemy == self.painattacker) {
    thread painanimfaceenemy(asmname, statename, animid, asm_getxanim(statename, animid));
  }

  self.painattacker = undefined;
  asm_donotetracks(asmname, statename, asm_getnotehandler(asmname, statename));
}

function clearpainturnrate(asmname, statename, params) {
  if(isDefined(self.painoldturnrate)) {
    self.turnrate = self.painoldturnrate;
    self.painoldturnrate = undefined;
  }
}

function function_111158d9cee51970(asmname, statename, params) {
  var_5443645c78427889 = undefined;

  if(isDefined(params) && isstring(params)) {
    var_5443645c78427889 = params;
  }

  self endon(statename + "_finished");
  self orientmode("face current");
  self animmode("live_ragdoll");

  if(isDefined(var_5443645c78427889)) {
    animid = asm_getanim(asmname, statename, var_5443645c78427889);
  } else {
    animid = asm_getanim(asmname, statename);
  }

  thread function_6d4426b00706324e();
  self aisetanim(statename, animid);
  endnote = asm_donotetracks(asmname, statename, asm_getnotehandler(asmname, statename));

  if(endnote == "code_move") {
    endnote = asm_donotetracks(asmname, statename, asm_getnotehandler(asmname, statename));
  }
}

function function_56a47f26f49fc5eb(asmname, statename, blendtime, params) {
  self endon(statename + "_finished");
  animid = asm_getanim(asmname, statename);
  animname = asm_getxanim(statename, animid);
  thread function_b3b20911062201ad();
  self aisetanim(statename, animid);
  asm_playfacialanim(asmname, statename, animname);
  self function_9c471a7e95a2747e(animname);
  endnote = asm_donotetracks(asmname, statename, asm_getnotehandler(asmname, statename));

  if(endnote == "code_move") {
    endnote = asm_donotetracks(asmname, statename, asm_getnotehandler(asmname, statename));
  }
}

function function_6d4426b00706324e() {
  if(!isDefined(self.weapon)) {
    return;
  }

  self endon("death");
  self waittillmatch("live_ragdoll_test", "ragdoll_gun_stow");
  scripts\anim\shared::placeweaponon(self.weapon, "chest");
}

function function_b3b20911062201ad() {
  if(!isDefined(self.weapon)) {
    return;
  }

  self endon("death");
  self waittillmatch("live_ragdoll_recover", "ragdoll_gun_unstow");
  scripts\anim\shared::placeweaponon(self.weapon, "right");
}

function function_e585c560d79f00f8(asmname, statename, tostatename, params) {
  return istrue(self.var_e585c560d79f00f8);
}

function function_5e9e03bdd9237c0f(asmname, statename, params) {
  painalias = "pain_popup" + getpaindirectiontoactor();
  painanim = asm_lookupanimfromalias(statename, painalias);
  return painanim;
}

function function_a131b253107d514b(asmname, statename, params) {
  painalias = "pain_popup_recover" + getpaindirectiontoactor();
  painanim = asm_lookupanimfromalias(statename, painalias);
  return painanim;
}