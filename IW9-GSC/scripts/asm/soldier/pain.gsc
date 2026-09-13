/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\asm\soldier\pain.gsc
***********************************************/

isdamagelocation_rarm(asmname, statename, _id_F2B19B25D457C2A6, params) {
  if(!self.damageshield)
    return scripts\engine\utility::damagelocationisany("right_arm_upper", "right_arm_lower", "right_hand");

  return 0;
}

isdamagelocation_rleg(asmname, statename, _id_F2B19B25D457C2A6, params) {
  if(!self.damageshield)
    return scripts\engine\utility::damagelocationisany("right_leg_upper", "right_foot", "right_leg_lower");

  return 0;
}

isdamagelocation_lleg(asmname, statename, _id_F2B19B25D457C2A6, params) {
  if(!self.damageshield)
    return scripts\engine\utility::damagelocationisany("left_leg_upper", "left_foot", "left_leg_lower");

  return 0;
}

isdamagelocation_larm(asmname, statename, _id_F2B19B25D457C2A6, params) {
  if(!self.damageshield)
    return scripts\engine\utility::damagelocationisany("left_arm_upper", "left_arm_lower", "left_hand");

  return 0;
}

isdamagelocation_torso(asmname, statename, _id_F2B19B25D457C2A6, params) {
  if(!self.damageshield)
    return scripts\engine\utility::damagelocationisany("torso_upper", "torso_lower");

  return 0;
}

isdamagelocation_head(asmname, statename, _id_F2B19B25D457C2A6, params) {
  if(!self.damageshield)
    return scripts\engine\utility::damagelocationisany("head", "neck", "helmet");

  return 0;
}

isdamagelocation_larmcrouch(asmname, statename, _id_F2B19B25D457C2A6, params) {
  return scripts\engine\utility::damagelocationisany("left_hand", "left_arm_upper", "left_arm_lower", "left_leg_upper", "left_leg_lower", "left_foot", "torso_lower");
}

isdamagelocation_back(asmname, statename, _id_F2B19B25D457C2A6, params) {
  if(!self.damageshield) {
    if(scripts\asm\shared\utility::gethumandamagedirstring() == 1 && !scripts\engine\utility::damagelocationisany("left_leg_upper", "left_leg_lower", "left_foot", "right_leg_upper", "right_leg_lower", "right_foot"))
      return 1;
  }

  return 0;
}

isdamagelocation_torsocovercrouch(asmname, statename, _id_F2B19B25D457C2A6, params) {
  return scripts\engine\utility::damagelocationisany("right_arm_upper", "right_arm_lower", "right_hand", "left_hand", "left_arm_upper", "left_arm_lower", "left_leg_upper", "left_leg_lower", "left_foot", "right_leg_upper", "right_leg_lower", "right_foot", "torso_upper", "torso_lower");
}

choosepainanimshock(asmname, statename, params) {
  return scripts\asm\asm::asm_lookupanimfromalias(statename, "shock_loop_" + self.currentpose);
}

playsonicshockfx() {
  if(scripts\common\utility::isdamageweapon(makeweapon("iw7_sonic")) && scripts\common\utility::isweaponepic(self.damageweapon)) {
    playFXOnTag(level.g_effect["soldier_shock"], self, "j_knee_ri");
    playFXOnTag(level.g_effect["soldier_shock"], self, "j_shoulder_ri");
  }
}

playshockpainloop(asmname, statename, params) {
  self endon("death");
  self endon(statename + "_finished");
  _id_C9EDB1B72607D824 = scripts\asm\asm::asm_getanim(asmname, statename);
  loop_time = scripts\engine\utility::ter_op(isDefined(self.empstuntime), self.empstuntime, 3.5);
  playsonicshockfx();
  self animmode("zonly_physics", 0);
  wait(randomfloat(0.3));

  if(self.asmname == "c6" || self.asmname == "c6_worker") {
    thread shockpainloop_internal(self.asmname, statename, 1, 0, 1);
    self playSound("generic_flashbang_c6_1");
  } else
    thread shockpainloop_internal(self.asmname, statename, 1, 0);

  wait(loop_time);
  self notify("painloop_end");
  scripts\asm\asm::asm_fireevent(asmname, "stop_loop_pain");
  self.emplooptime = undefined;
  finishpain(asmname, statename, params);
}

shockpainloop_c6_cleanup(asmname, statename, params) {
  self stopsounds();
}

shockpainloop_internal(asmname, statename, _id_C08B84490B532FB2, _id_9177DF4FA6F67675, _id_D865B83B6D412E31) {
  self endon(statename + "_finished");
  self endon("painloop_end");

  if(isDefined(_id_9177DF4FA6F67675) && _id_9177DF4FA6F67675) {
    _id_BF3DE88B0E06A07C = scripts\asm\asm::asm_lookupanimfromaliasifexists("knobs", "move");

    if(isDefined(_id_BF3DE88B0E06A07C))
      self setmoveanimknob(_id_BF3DE88B0E06A07C);
  }

  _id_F3716786BF084DD1 = scripts\asm\asm::asm_getbodyknob();
  _id_FFA4A84E8BC9B04C = scripts\asm\asm::asm_getanim(asmname, statename);

  for(;;) {
    if(isDefined(_id_D865B83B6D412E31))
      _id_FFA4A84E8BC9B04C = scripts\asm\asm::asm_getanim(asmname, statename);

    _id_678B2C6541E01262 = scripts\asm\asm::asm_getxanim(statename, _id_FFA4A84E8BC9B04C);
    self aisetanim(statename, _id_FFA4A84E8BC9B04C, _id_C08B84490B532FB2);
    scripts\asm\asm::asm_playfacialanim(asmname, statename, _id_678B2C6541E01262);
    _id_F3716786BF084DD1 = _id_FFA4A84E8BC9B04C;
    scripts\asm\asm::asm_donotetrackssingleloop(asmname, statename, _id_678B2C6541E01262, scripts\asm\asm::asm_getnotehandler(asmname, statename));
  }
}

chooseshockpainrecovery(asmname, statename, params) {
  return scripts\asm\asm::asm_lookupanimfromalias(statename, "shock_finish_" + self.currentpose);
}

playpainanim(asmname, statename, params) {
  playpainaniminternal(asmname, statename, params, 0);
}

playpainanimwithadditives(asmname, statename, params) {
  playpainaniminternal(asmname, statename, params, 1);
}

playpainanimlmg(asmname, statename, params) {
  self._blackboard.inlmgstate = 1;
  playpainaniminternal(asmname, statename, params, 0);
}

pain_can_use_handler(_id_A234A65C378F3289, params) {
  if(_id_A234A65C378F3289 == "pain_can_end")
    return 1;
}

getpainweaponsize() {
  _id_A61C75B156FC1EE0 = "_md";
  _id_3E7B2F709E2F6164 = "rifle";
  objweapon = self.damageweapon;

  if(isDefined(objweapon) && objweapon.basename != "iw8_sn_mike14")
    _id_3E7B2F709E2F6164 = objweapon.classname;

  if(_id_3E7B2F709E2F6164 == "pistol" || _id_3E7B2F709E2F6164 == "smg")
    _id_A61C75B156FC1EE0 = "_md";
  else if(_id_3E7B2F709E2F6164 == "spread") {
    _id_A61C75B156FC1EE0 = "_md";

    if(isDefined(self.lastattacker) && distancesquared(self.lastattacker.origin, self.origin) <= 62500)
      _id_A61C75B156FC1EE0 = "_lg";
  } else if(_id_3E7B2F709E2F6164 == "sniper" || _id_3E7B2F709E2F6164 == "mg")
    _id_A61C75B156FC1EE0 = "_lg";
  else if(_id_3E7B2F709E2F6164 == "grenade" && isDefined(self.damagemod) && self.damagemod == "MOD_IMPACT")
    _id_A61C75B156FC1EE0 = "_lg";

  if(isDefined(level.fnasmsoldiergetpainweaponsize))
    _id_A61C75B156FC1EE0 = self[[level.fnasmsoldiergetpainweaponsize]](_id_A61C75B156FC1EE0);

  return _id_A61C75B156FC1EE0;
}

getpaindirectiontoactor() {
  if(isDefined(self.damageyaw) && self.damageyaw >= -45 && self.damageyaw <= 45) {
    dir = "_b";
    return dir;
  } else if(isDefined(self.damageyaw) && self.damageyaw < -45 && self.damageyaw > -135) {
    dir = "_l";
    return dir;
  } else if(isDefined(self.damageyaw) && self.damageyaw > 45 && self.damageyaw < 135) {
    dir = "_r";
    return dir;
  } else {
    dir = "_f";
    return dir;
  }
}

choosedirectionalpainanim_transition(asmname, statename, params) {
  if(isDefined(self._id_872A8E737F3E5358)) {
    _id_6AD9995DD505716A = self._id_872A8E737F3E5358;
    return scripts\asm\asm::asm_lookupanimfromalias(statename, _id_6AD9995DD505716A);
  }

  return scripts\asm\asm::asm_getrandomanim(statename);
}

playpainaniminternal(asmname, statename, params, _id_837BCC3E005FEB5D, _id_96D69C0CC6FB90C1, _id_1A502982E90B16D9, _id_B6A66CC6C81067A0, _id_94987CCB5819C6E9) {
  self endon(statename + "_finished");

  if(isDefined(self.a.paintime))
    self.a.lastpaintime = self.a.paintime;
  else
    self.a.lastpaintime = 0;

  self.a.paintime = gettime();

  if(self.stairsstate != "none")
    self.a.painonstairs = 1;
  else
    self.a.painonstairs = undefined;

  self.a._id_682A42D4EA27FE49 = 1;

  if(isDefined(self._id_40BC0E4ADB7920BD)) {
    _id_35AB2DABE0210D0F = [[self._id_40BC0E4ADB7920BD]]();

    if(!istrue(_id_35AB2DABE0210D0F)) {
      self.a._id_682A42D4EA27FE49 = undefined;
      return;
    }
  }

  self animmode("gravity");

  if(!istrue(_id_B6A66CC6C81067A0))
    self orientmode("face angle", self.angles[1]);

  if(!isDefined(self.no_pain_sound))
    _id_4ADE3AE5C138C8B3::saygenericdialogue("pain");

  if(scripts\asm\soldier\death::shouldhelmetpoponpain(scripts\common\utility::wasdamagedbyexplosive()))
    scripts\asm\soldier\death::helmetpop();

  animstatename = statename;

  if(isDefined(_id_1A502982E90B16D9))
    animstatename = _id_1A502982E90B16D9;

  _id_C9EDB1B72607D824 = scripts\asm\asm::asm_getanim(asmname, statename, params);
  self aisetanim(animstatename, _id_C9EDB1B72607D824);
  _id_6B9ECB781431451A = scripts\asm\asm::asm_getxanim(animstatename, _id_C9EDB1B72607D824);
  scripts\asm\asm::asm_playfacialanim(asmname, statename, _id_6B9ECB781431451A);

  if(isDefined(_id_94987CCB5819C6E9))
    self thread[[_id_94987CCB5819C6E9]](asmname, statename, _id_C9EDB1B72607D824, _id_6B9ECB781431451A);

  self.requestdifferentcover = 1;

  if(animhasnotetrack(_id_6B9ECB781431451A, "code_move"))
    scripts\asm\asm::asm_donotetracks(asmname, statename, undefined, undefined, animstatename);

  scripts\asm\asm::asm_donotetracks(asmname, statename, undefined, undefined, animstatename);

  if(istrue(_id_96D69C0CC6FB90C1))
    finishpain(asmname, statename, params);
  else
    finishpain(asmname, statename);
}

paincanend(statename, _id_6EF4FD3894A9F0A2) {
  switch (_id_6EF4FD3894A9F0A2) {
    case "pain_can_end":
      return 1;
  }
}

coverexppainselectreturna(asmname, statename, params) {
  if(isDefined(self._blackboard.coverexposetype) && self._blackboard.coverexposetype == "A")
    return 1;
  else
    return 0;
}

finishpain(asmname, statename, params) {
  self.a._id_682A42D4EA27FE49 = undefined;
  self notify("killanimscript");
  _id_8C6D9AEBB9D4A4CC = undefined;

  if(isDefined(params)) {
    if(isarray(params))
      _id_8C6D9AEBB9D4A4CC = params[0];
    else
      _id_8C6D9AEBB9D4A4CC = params;
  }

  if(!isDefined(_id_8C6D9AEBB9D4A4CC)) {
    return;
  }
  thread scripts\asm\asm::asm_setstate(_id_8C6D9AEBB9D4A4CC, undefined);
}

playcoverpainanimwithadditives(asmname, statename, params) {
  self.keepclaimednodeifvalid = 1;
  playpainaniminternal(asmname, statename, params, 1);
}

playcoverpainanim(asmname, statename, params) {
  self.keepclaimednodeifvalid = 1;
  playpainanim(asmname, statename, params);
}

choosepainanim_standtorsotoexposed(asmname, statename, params) {
  if(self.lasttorsoanim == "torso_upper")
    _id_24BE4E2B091E63BF = scripts\asm\asm::asm_lookupanimfromalias(statename, "torso_upper");
  else if(self.lasttorsoanim == "torso_lower")
    _id_24BE4E2B091E63BF = scripts\asm\asm::asm_lookupanimfromalias(statename, "torso_lower");
  else
    _id_24BE4E2B091E63BF = scripts\asm\asm::asm_lookupanimfromalias(statename, "default");

  self.lasttorsoanim = undefined;
  return _id_24BE4E2B091E63BF;
}

choosepainanim_standtorso(asmname, statename, params) {
  if(scripts\engine\utility::damagelocationisany("torso_upper")) {
    self.lasttorsoanim = "torso_upper";
    return scripts\asm\asm::asm_lookupanimfromalias(statename, "torso_upper");
  } else if(scripts\engine\utility::damagelocationisany("torso_lower")) {
    self.lasttorsoanim = "torso_lower";
    return scripts\asm\asm::asm_lookupanimfromalias(statename, "torso_lower");
  } else {
    self.lasttorsoanim = "default";
    return scripts\asm\asm::asm_lookupanimfromalias(statename, "default");
  }
}

choosepainanim_stand(asmname, statename, params) {
  if(_id_2B79931B08683E0A::isusingsidearm())
    return choosepainanim_pistol(asmname, statename, params);

  _id_53AABD9CAFD5B202 = [];

  if(scripts\engine\utility::damagelocationisany("torso_upper"))
    _id_53AABD9CAFD5B202[_id_53AABD9CAFD5B202.size] = scripts\asm\asm::asm_lookupanimfromalias(statename, "torso_upper");
  else if(scripts\engine\utility::damagelocationisany("torso_lower"))
    _id_53AABD9CAFD5B202[_id_53AABD9CAFD5B202.size] = scripts\asm\asm::asm_lookupanimfromalias(statename, "torso_lower");
  else if(scripts\engine\utility::damagelocationisany("head", "helmet", "neck"))
    _id_53AABD9CAFD5B202[_id_53AABD9CAFD5B202.size] = scripts\asm\asm::asm_lookupanimfromalias(statename, "head");
  else if(scripts\engine\utility::damagelocationisany("right_arm_upper", "right_arm_lower"))
    _id_53AABD9CAFD5B202[_id_53AABD9CAFD5B202.size] = scripts\asm\asm::asm_lookupanimfromalias(statename, "right_arm");
  else if(scripts\engine\utility::damagelocationisany("left_arm_upper", "left_arm_lower"))
    _id_53AABD9CAFD5B202[_id_53AABD9CAFD5B202.size] = scripts\asm\asm::asm_lookupanimfromalias(statename, "left_arm");
  else if(scripts\engine\utility::damagelocationisany("left_leg_upper", "left_leg_lower", "left_foot"))
    _id_53AABD9CAFD5B202[_id_53AABD9CAFD5B202.size] = scripts\asm\asm::asm_lookupanimfromalias(statename, "left_leg");
  else if(scripts\engine\utility::damagelocationisany("right_leg_upper", "right_leg_lower", "right_foot"))
    _id_53AABD9CAFD5B202[_id_53AABD9CAFD5B202.size] = scripts\asm\asm::asm_lookupanimfromalias(statename, "right_leg");

  if(_id_53AABD9CAFD5B202.size < 2)
    _id_53AABD9CAFD5B202[_id_53AABD9CAFD5B202.size] = scripts\asm\asm::asm_lookupanimfromalias(statename, "default");

  return _id_53AABD9CAFD5B202[randomint(_id_53AABD9CAFD5B202.size)];
}

choosepainanim_damageshield(asmname, statename, params) {
  _id_53AABD9CAFD5B202 = [];

  if(_id_53AABD9CAFD5B202.size < 2)
    _id_53AABD9CAFD5B202[_id_53AABD9CAFD5B202.size] = scripts\asm\asm::asm_lookupanimfromalias(statename, "default");

  return _id_53AABD9CAFD5B202[randomint(_id_53AABD9CAFD5B202.size)];
}

choosedynamicpainanim_expcrouchlegs(asmname, statename, params) {
  _id_53AABD9CAFD5B202 = [];
  _id_53AABD9CAFD5B202[_id_53AABD9CAFD5B202.size] = scripts\asm\asm::asm_lookupanimfromalias(statename, "default");
  return _id_53AABD9CAFD5B202[randomint(_id_53AABD9CAFD5B202.size)];
}

choosepainanim_crouch(asmname, statename, params) {
  _id_53AABD9CAFD5B202 = [];
  _id_53AABD9CAFD5B202[_id_53AABD9CAFD5B202.size] = scripts\asm\asm::asm_lookupanimfromalias(statename, "default");

  if(scripts\engine\utility::damagelocationisany("left_hand", "left_arm_lower", "left_arm_upper"))
    _id_53AABD9CAFD5B202[_id_53AABD9CAFD5B202.size] = scripts\asm\asm::asm_lookupanimfromalias(statename, "left_arm");

  if(scripts\engine\utility::damagelocationisany("right_hand", "right_arm_lower", "right_arm_upper"))
    _id_53AABD9CAFD5B202[_id_53AABD9CAFD5B202.size] = scripts\asm\asm::asm_lookupanimfromalias(statename, "right_arm");

  return _id_53AABD9CAFD5B202[randomint(_id_53AABD9CAFD5B202.size)];
}

choosepainanim_pistol(asmname, statename, params) {
  _id_53AABD9CAFD5B202 = [];

  if(scripts\engine\utility::damagelocationisany("torso_upper"))
    _id_53AABD9CAFD5B202[_id_53AABD9CAFD5B202.size] = scripts\asm\asm::asm_lookupanimfromalias(statename, "pistol_torso_upper");
  else if(scripts\engine\utility::damagelocationisany("torso_lower"))
    _id_53AABD9CAFD5B202[_id_53AABD9CAFD5B202.size] = scripts\asm\asm::asm_lookupanimfromalias(statename, "pistol_torso_lower");
  else if(scripts\engine\utility::damagelocationisany("neck"))
    _id_53AABD9CAFD5B202[_id_53AABD9CAFD5B202.size] = scripts\asm\asm::asm_lookupanimfromalias(statename, "pistol_neck");
  else if(scripts\engine\utility::damagelocationisany("head"))
    _id_53AABD9CAFD5B202[_id_53AABD9CAFD5B202.size] = scripts\asm\asm::asm_lookupanimfromalias(statename, "pistol_head");
  else if(scripts\engine\utility::damagelocationisany("left_leg_upper", "right_leg_upper"))
    _id_53AABD9CAFD5B202[_id_53AABD9CAFD5B202.size] = scripts\asm\asm::asm_lookupanimfromalias(statename, "pistol_leg");
  else if(scripts\engine\utility::damagelocationisany("left_arm_upper"))
    _id_53AABD9CAFD5B202[_id_53AABD9CAFD5B202.size] = scripts\asm\asm::asm_lookupanimfromalias(statename, "pistol_left_arm_upper");
  else if(scripts\engine\utility::damagelocationisany("left_arm_lower"))
    _id_53AABD9CAFD5B202[_id_53AABD9CAFD5B202.size] = scripts\asm\asm::asm_lookupanimfromalias(statename, "pistol_left_arm_lower");
  else if(scripts\engine\utility::damagelocationisany("right_arm_upper"))
    _id_53AABD9CAFD5B202[_id_53AABD9CAFD5B202.size] = scripts\asm\asm::asm_lookupanimfromalias(statename, "pistol_right_arm_upper");
  else if(scripts\engine\utility::damagelocationisany("right_arm_lower"))
    _id_53AABD9CAFD5B202[_id_53AABD9CAFD5B202.size] = scripts\asm\asm::asm_lookupanimfromalias(statename, "pistol_right_arm_lower");

  if(_id_53AABD9CAFD5B202.size < 2)
    _id_53AABD9CAFD5B202[_id_53AABD9CAFD5B202.size] = scripts\asm\asm::asm_lookupanimfromalias(statename, "pistol_default");

  return _id_53AABD9CAFD5B202[randomint(_id_53AABD9CAFD5B202.size)];
}

choosepainanim_covercorner_helper(asmname, statename, params, angles) {
  if(isDefined(params) && isDefined(params[1]))
    return scripts\asm\asm::asm_lookupanimfromalias(statename, params[1]);

  if(self.currentpose == "crouch")
    return scripts\asm\asm::asm_lookupanimfromalias(statename, "crouch");
  else
    return scripts\asm\asm::asm_lookupanimfromalias(statename, "stand");
}

choosepainanim_covercorner(asmname, statename, params) {
  return choosepainanim_covercorner_helper(asmname, statename, params, undefined);
}

choosedynamicpainanim_back(asmname, statename, params) {
  alias = "back";
  return scripts\asm\asm::asm_lookupanimfromalias(statename, alias);
}

choosedynamicpainanim_covercrouch(asmname, statename, params) {
  _id_53AABD9CAFD5B202 = [];

  if(scripts\engine\utility::damagelocationisany("torso_upper", "torso_lower"))
    _id_53AABD9CAFD5B202[_id_53AABD9CAFD5B202.size] = scripts\asm\asm::asm_lookupanimfromalias(statename, "torso");
  else if(scripts\engine\utility::damagelocationisany("head", "helmet", "neck"))
    _id_53AABD9CAFD5B202[_id_53AABD9CAFD5B202.size] = scripts\asm\asm::asm_lookupanimfromalias(statename, "head");

  if(_id_53AABD9CAFD5B202.size < 2)
    _id_53AABD9CAFD5B202[_id_53AABD9CAFD5B202.size] = scripts\asm\asm::asm_lookupanimfromalias(statename, "default");

  return _id_53AABD9CAFD5B202[randomint(_id_53AABD9CAFD5B202.size)];
}

choosedynamicpainanim_coverstand(asmname, statename, params) {
  _id_53AABD9CAFD5B202 = [];

  if(scripts\engine\utility::damagelocationisany("torso_upper"))
    _id_53AABD9CAFD5B202[_id_53AABD9CAFD5B202.size] = scripts\asm\asm::asm_lookupanimfromalias(statename, "torso_upper");
  else if(scripts\engine\utility::damagelocationisany("torso_lower"))
    _id_53AABD9CAFD5B202[_id_53AABD9CAFD5B202.size] = scripts\asm\asm::asm_lookupanimfromalias(statename, "torso_lower");
  else if(scripts\engine\utility::damagelocationisany("head", "helmet", "neck"))
    _id_53AABD9CAFD5B202[_id_53AABD9CAFD5B202.size] = scripts\asm\asm::asm_lookupanimfromalias(statename, "head");
  else if(scripts\engine\utility::damagelocationisany("right_arm_upper", "right_arm_lower"))
    _id_53AABD9CAFD5B202[_id_53AABD9CAFD5B202.size] = scripts\asm\asm::asm_lookupanimfromalias(statename, "right_arm");
  else if(scripts\engine\utility::damagelocationisany("left_arm_upper", "left_arm_lower"))
    _id_53AABD9CAFD5B202[_id_53AABD9CAFD5B202.size] = scripts\asm\asm::asm_lookupanimfromalias(statename, "left_arm");
  else if(scripts\engine\utility::damagelocationisany("left_leg_upper", "left_leg_lower", "left_foot"))
    _id_53AABD9CAFD5B202[_id_53AABD9CAFD5B202.size] = scripts\asm\asm::asm_lookupanimfromalias(statename, "left_leg");
  else if(scripts\engine\utility::damagelocationisany("right_leg_upper", "right_leg_lower", "right_foot"))
    _id_53AABD9CAFD5B202[_id_53AABD9CAFD5B202.size] = scripts\asm\asm::asm_lookupanimfromalias(statename, "right_leg");

  if(_id_53AABD9CAFD5B202.size < 2)
    _id_53AABD9CAFD5B202[_id_53AABD9CAFD5B202.size] = scripts\asm\asm::asm_lookupanimfromalias(statename, "default");

  return _id_53AABD9CAFD5B202[randomint(_id_53AABD9CAFD5B202.size)];
}

_id_9A4A7270010ADA09(asmname, statename, params) {
  self aisettargetspeed(length(self.velocity));
  cleanuppainanim(asmname, statename, params);
}

cleanuppainanim(asmname, statename, params) {
  if(isDefined(self.script) && self.script == "pain")
    self notify("killanimscript");

  self.a._id_682A42D4EA27FE49 = undefined;

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

  self._blackboard._id_074F8F2B8EFF7C7F = 0;
  clearpainturnrate(asmname, statename, params);

  if(istrue(self.leavecasualkiller))
    scripts\asm\soldier\script_funcs::terminate_casualkiller(asmname, statename, params);

  if(!istrue(self.ignoreall)) {
    if(isDefined(self.enemy) && lengthsquared(self.velocity) < 1 && isDefined(self.weapon) && !istrue(self.enemy.ignoreme) && self cansee(self.enemy))
      self.remainexposedendtime = gettime() + 2000;
  }
}

transition_flashfinished(asmname, _id_8F4EF4FDB5E7800A, _id_93279C66A2E49A45, params) {
  if(!scripts\engine\utility::isflashed())
    return 1;

  if(gettime() > self.flashendtime)
    return 1;

  return scripts\asm\asm::asm_eventfired(asmname, "end") || scripts\asm\asm::asm_eventfired(asmname, "finish");
}

playanim_flashed(asmname, statename, params) {
  self endon(statename + "_finished");
  playanim_flashed_internal(asmname, statename);
  thread playanim_monitorflashrestart(asmname, statename);
  scripts\asm\asm::asm_donotetracks(asmname, statename);
}

playanim_flashed_internal(asmname, statename) {
  _id_C22C902BF03BD098 = scripts\asm\asm::asm_getanim(asmname, statename);
  rate = 1;

  if(isDefined(self.flashendtime)) {
    _id_1EA801324C12E83D = self.flashendtime - gettime();
    xanim = scripts\asm\asm::asm_getxanim(statename, _id_C22C902BF03BD098);
    animlength = getanimlength(xanim) * 1000;

    if(_id_1EA801324C12E83D > 0)
      rate = animlength / _id_1EA801324C12E83D;

    rate = rate + randomfloatrange(-0.1, 0.05);
    rate = clamp(rate, 0.65, 1.2);
    self.flashendtime = gettime() + int(animlength / rate);
  }

  self aisetanim(statename, _id_C22C902BF03BD098, rate);
}

playanim_monitorflashrestart(asmname, statename) {
  self endon(statename + "_finished");
  _id_B2A1F003A8F9E6D2 = self.flashendtime;

  while(isDefined(self.flashendtime)) {
    if(_id_B2A1F003A8F9E6D2 != self.flashendtime) {
      playanim_flashed_internal(asmname, statename);
      _id_B2A1F003A8F9E6D2 = self.flashendtime;
    }

    waitframe();
  }
}

cleanupflashanim(asmname, statename, params) {
  cleanuppainanim(asmname, statename, params);
  scripts\common\utility::flashbangstop();
}

playanim_burning(asmname, statename, params) {
  self endon(statename + "_finished");
  _id_AAC951FEA290E449 = scripts\asm\asm::asm_getanim(asmname, statename, params);
  _id_9EE867A6BBA39A0D = randomfloatrange(0.8, 1.2);
  self orientmode("face angle", self.angles[1]);
  self aisetanim(statename, _id_AAC951FEA290E449, _id_9EE867A6BBA39A0D);
  scripts\asm\asm::asm_donotetracks(asmname, statename, ::burn_notetrack_handler);
}

burn_notetrack_handler(_id_A234A65C378F3289) {
  if(isDefined(self.semtexstuckto)) {
    return;
  }
  switch (_id_A234A65C378F3289) {
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

painanimfaceenemy(asmname, statename, _id_2C8936D08F85C5C1, xanim) {
  self endon(statename + "_finished");
  enemy = self.enemy;
  animlength = getanimlength(xanim);
  endtime = animlength * 0.8;
  _id_F462F2C7298CB429 = animlength;
  _id_6767247F28FABD3C = getnotetracktimes(xanim, "face_enemy")[0];

  if(isDefined(_id_6767247F28FABD3C))
    endtime = _id_6767247F28FABD3C * animlength;
  else {
    if(scripts\asm\asm::asm_currentstatehasflag(asmname, "notetrackAim")) {
      _id_5CBBF76A71910120 = getnotetracktimes(xanim, "start_aim")[0];

      if(isDefined(_id_5CBBF76A71910120)) {
        endtime = min(endtime, max(0, _id_5CBBF76A71910120 - 0.3) * animlength);
        _id_F462F2C7298CB429 = _id_5CBBF76A71910120 * animlength;
      }
    }

    endtime = min(endtime, max(0, animlength - 0.5));
  }

  wait(endtime);

  if(isalive(enemy)) {
    _id_AB47B2EC8E13ED55 = getnotetracktimes(xanim, "face_enemy_end")[0];
    _id_253B2641C5FCF77A = 1;

    if(isDefined(_id_AB47B2EC8E13ED55))
      _id_253B2641C5FCF77A = _id_AB47B2EC8E13ED55;

    _id_B819721CEFD782D2 = getanimlength(xanim) * _id_253B2641C5FCF77A - endtime;
    _id_E473D197CB34AE13 = gettime() + _id_B819721CEFD782D2 * 1000;

    while(gettime() < _id_E473D197CB34AE13 && isalive(enemy)) {
      _id_A79562CDED0C03A2 = enemy.origin - self.origin;
      _id_7EF311E27099889B = vectortoyaw(_id_A79562CDED0C03A2);
      _id_077B9E4B599269EB = angleclamp180(_id_7EF311E27099889B - self.angles[1]);
      _id_30992C23CE045EDF = self getanimtime(xanim);
      _id_1875FB38B6D4D4E4 = getangledelta(xanim, _id_30992C23CE045EDF, _id_253B2641C5FCF77A);
      _id_3777ECE6A73EADA5 = _id_077B9E4B599269EB - _id_1875FB38B6D4D4E4;
      self orientmode("face angle", self.angles[1] + _id_3777ECE6A73EADA5);
      waitframe();
    }
  }
}

playpainanim_faceplayer(asmname, statename, params) {
  self endon(statename + "_finished");
  _id_EB1AC6373DFDE285 = undefined;

  if(isalive(self.enemy) && isDefined(self.lastattacker) && self.enemy == self.lastattacker)
    _id_EB1AC6373DFDE285 = ::painanimfaceenemy;

  playpainaniminternal(asmname, statename, params, 0, 1, undefined, 1, _id_EB1AC6373DFDE285);
}

playpainanim_exposedstand(asmname, statename, params) {
  self endon(statename + "_finished");
  _id_EB1AC6373DFDE285 = undefined;

  if(isalive(self.enemy) && isDefined(self.lastattacker) && self.enemy == self.lastattacker)
    _id_EB1AC6373DFDE285 = ::painanimfaceenemy;

  playpainaniminternal(asmname, statename, params, 0, 1, undefined, 0, _id_EB1AC6373DFDE285);
}

playpainanim_exposedcrouch(asmname, statename, params) {
  self endon(statename + "_finished");
  self.painattacker = self.lastattacker;
  playpainaniminternal(asmname, statename, params, 0, 1);
}

playpainanim_exposedcrouchtransition(asmname, statename, params) {
  self endon(statename + "_finished");
  _id_2C8936D08F85C5C1 = scripts\asm\asm::asm_getanim(asmname, statename);
  self aisetanim(statename, _id_2C8936D08F85C5C1);
  scripts\asm\asm::asm_playfacialanim(asmname, statename, scripts\asm\asm::asm_getxanim(statename, _id_2C8936D08F85C5C1));

  if(isalive(self.enemy) && isDefined(self.painattacker) && self.enemy == self.painattacker)
    thread painanimfaceenemy(asmname, statename, _id_2C8936D08F85C5C1, scripts\asm\asm::asm_getxanim(statename, _id_2C8936D08F85C5C1));

  self.painattacker = undefined;
  scripts\asm\asm::asm_donotetracks(asmname, statename, scripts\asm\asm::asm_getnotehandler(asmname, statename));
}

clearpainturnrate(asmname, statename, params) {
  if(isDefined(self.painoldturnrate)) {
    self.turnrate = self.painoldturnrate;
    self.painoldturnrate = undefined;
  }
}

_id_111158D9CEE51970(asmname, statename, params) {
  _id_5443645C78427889 = undefined;

  if(isDefined(params) && isstring(params))
    _id_5443645C78427889 = params;

  self endon(statename + "_finished");
  self orientmode("face current");
  self animmode("live_ragdoll");

  if(isDefined(_id_5443645C78427889))
    _id_2C8936D08F85C5C1 = scripts\asm\asm::asm_getanim(asmname, statename, _id_5443645C78427889);
  else
    _id_2C8936D08F85C5C1 = scripts\asm\asm::asm_getanim(asmname, statename);

  thread _id_6D4426B00706324E();
  self aisetanim(statename, _id_2C8936D08F85C5C1);
  endnote = scripts\asm\asm::asm_donotetracks(asmname, statename, scripts\asm\asm::asm_getnotehandler(asmname, statename));

  if(endnote == "code_move")
    endnote = scripts\asm\asm::asm_donotetracks(asmname, statename, scripts\asm\asm::asm_getnotehandler(asmname, statename));
}

_id_56A47F26F49FC5EB(asmname, statename, _id_D180B535A33B044D, params) {
  self endon(statename + "_finished");
  _id_2C8936D08F85C5C1 = scripts\asm\asm::asm_getanim(asmname, statename);
  animname = scripts\asm\asm::asm_getxanim(statename, _id_2C8936D08F85C5C1);
  thread _id_B3B20911062201AD();
  self aisetanim(statename, _id_2C8936D08F85C5C1);
  scripts\asm\asm::asm_playfacialanim(asmname, statename, animname);
  self _meth_9C471A7E95A2747E(animname);
  endnote = scripts\asm\asm::asm_donotetracks(asmname, statename, scripts\asm\asm::asm_getnotehandler(asmname, statename));

  if(endnote == "code_move")
    endnote = scripts\asm\asm::asm_donotetracks(asmname, statename, scripts\asm\asm::asm_getnotehandler(asmname, statename));
}

_id_6D4426B00706324E() {
  if(!isDefined(self.weapon)) {
    return;
  }
  self endon("death");
  self waittillmatch("live_ragdoll_test", "ragdoll_gun_stow");
  _id_3433EE6B63C7E243::placeweaponon(self.weapon, "chest");
}

_id_B3B20911062201AD() {
  if(!isDefined(self.weapon)) {
    return;
  }
  self endon("death");
  self waittillmatch("live_ragdoll_recover", "ragdoll_gun_unstow");
  _id_3433EE6B63C7E243::placeweaponon(self.weapon, "right");
}

_id_E585C560D79F00F8(asmname, statename, _id_F2B19B25D457C2A6, params) {
  return istrue(self._id_E585C560D79F00F8);
}