/****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\asm\soldier\pain.gsc
****************************************/

#using scripts\anim\battlechatter_events;
#using scripts\anim\face;
#using scripts\anim\shared;
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
    return utility::damagelocationisany("Wr\xcf\xaaD\xdb\xc0\xb8\xff5~\x187\xa5m", "\x15\x018#\xac\xddK8v\xdf$\x8f\xd7\xaf\xe9", "\xd1y|{;\xd4r4\fp");
  }

  return 0;
}

function isdamagelocation_rleg(asmname, statename, tostatename, params) {
  if(!self.damageshield) {
    return utility::damagelocationisany("\x11\xfa\xe7\x05\x0f\xfe\x84wW\xbbh\xc9\x82\xc6;", "#c'\x88\xfb\xd1W\xa7\xbd\xbb", "-\x10\xe9y\x90\x97\xd7\xd2\xc2F\x8d\xd8\x81\x99i");
  }

  return 0;
}

function isdamagelocation_lleg(asmname, statename, tostatename, params) {
  if(!self.damageshield) {
    return utility::damagelocationisany("M\xde\x83\xb6\xcbT\xdb}bX~J\xa5[", "\xcbcp\x97\x9e\xb3\x04\xd0\x9d", "!d\xbe\x12\x1f\x85\xdc\xf1:\xc5\xab\x9b\t5");
  }

  return 0;
}

function isdamagelocation_larm(asmname, statename, tostatename, params) {
  if(!self.damageshield) {
    return utility::damagelocationisany("DZKnO\xecT\\\xd23\x15\xf4\xfa6", "\x80\x037^\vH5.\xed\t\xc4^\xcd\x0e", "\xfa\xa3I)\xad\xea\xf0+n");
  }

  return 0;
}

function isdamagelocation_torso(asmname, statename, tostatename, params) {
  if(!self.damageshield) {
    return utility::damagelocationisany("\x1e\x9c\x9f\xceLO\xc5\xe4\xf1\x9a\xb7", "]\x7fU\x15\xb1\xfa\xc9\x143g7");
  }

  return 0;
}

function isdamagelocation_head(asmname, statename, tostatename, params) {
  if(!self.damageshield) {
    return utility::damagelocationisany("\x83\xe2\x11D", "\xcd\xca\xd8k", "\xebe\xe3\x82S\x14");
  }

  return 0;
}

function isdamagelocation_larmcrouch(asmname, statename, tostatename, params) {
  return utility::damagelocationisany("\xfa\xa3I)\xad\xea\xf0+n", "DZKnO\xecT\\\xd23\x15\xf4\xfa6", "\x80\x037^\vH5.\xed\t\xc4^\xcd\x0e", "M\xde\x83\xb6\xcbT\xdb}bX~J\xa5[", "!d\xbe\x12\x1f\x85\xdc\xf1:\xc5\xab\x9b\t5", "\xcbcp\x97\x9e\xb3\x04\xd0\x9d", "]\x7fU\x15\xb1\xfa\xc9\x143g7");
}

function isdamagelocation_back(asmname, statename, tostatename, params) {
  if(!self.damageshield) {
    if(utility::gethumandamagedirstring() == 1 && !utility::damagelocationisany("M\xde\x83\xb6\xcbT\xdb}bX~J\xa5[", "!d\xbe\x12\x1f\x85\xdc\xf1:\xc5\xab\x9b\t5", "\xcbcp\x97\x9e\xb3\x04\xd0\x9d", "\x11\xfa\xe7\x05\x0f\xfe\x84wW\xbbh\xc9\x82\xc6;", "-\x10\xe9y\x90\x97\xd7\xd2\xc2F\x8d\xd8\x81\x99i", "#c'\x88\xfb\xd1W\xa7\xbd\xbb")) {
      return true;
    }
  }

  return false;
}

function isdamagelocation_torsocovercrouch(asmname, statename, tostatename, params) {
  return utility::damagelocationisany("Wr\xcf\xaaD\xdb\xc0\xb8\xff5~\x187\xa5m", "\x15\x018#\xac\xddK8v\xdf$\x8f\xd7\xaf\xe9", "\xd1y|{;\xd4r4\fp", "\xfa\xa3I)\xad\xea\xf0+n", "DZKnO\xecT\\\xd23\x15\xf4\xfa6", "\x80\x037^\vH5.\xed\t\xc4^\xcd\x0e", "M\xde\x83\xb6\xcbT\xdb}bX~J\xa5[", "!d\xbe\x12\x1f\x85\xdc\xf1:\xc5\xab\x9b\t5", "\xcbcp\x97\x9e\xb3\x04\xd0\x9d", "\x11\xfa\xe7\x05\x0f\xfe\x84wW\xbbh\xc9\x82\xc6;", "-\x10\xe9y\x90\x97\xd7\xd2\xc2F\x8d\xd8\x81\x99i", "#c'\x88\xfb\xd1W\xa7\xbd\xbb");
}

function choosepainanimshock(asmname, statename, params) {
  return asm::asm_lookupanimfromalias(statename, "\xcd\xa1olm\xaf\xd8\xde{\xc1}" + self.currentpose);
}

function playsonicshockfx() {
  if(utility::isdamageweapon(makeweapon("\xd2\xee\xcd\xfa\xdc{\xdci\x8d")) && utility::isweaponepic(self.damageweapon)) {
    playFXOnTag(level.g_effect["\xab\xd7\xe8\x0e2\t\xa4\xb2\x0e\xac\xbc\xbd\xf7"], self, "\xb0\xe1)\x0e\xbe\xf5\x9c\xed\xb4");
    playFXOnTag(level.g_effect["\xab\xd7\xe8\x0e2\t\xa4\xb2\x0e\xac\xbc\xbd\xf7"], self, "\x96\xbd\x11i\xfb|\xe1G\x8f\xafQnO");
  }
}

function playshockpainloop(asmname, statename, params) {
  self endon("\x1e\xfd\xd1\xa2\a");
  self endon(statename + "\x1b\xe0K\x01;P\xfdf\x98");
  painanim = asm::asm_getanim(asmname, statename);
  loop_time = self.empstuntime ?? 3.5;
  playsonicshockfx();
  self animmode("\xee\xedc\xfb\xfa}f\x11y\xb9>\x9f\xaa", 0);
  wait randomfloat(0.3);

  if(self.asmname == "\xdf~" || self.asmname == "\x12\xc2!i\xbe\xf2\x104]") {
    thread shockpainloop_internal(self.asmname, statename, 1, 0, 1);
    self playSound("\xa6\xe8\x7f-v\xc8\x83\xdcKX\xc8x Mhvg\xe2]\x9e\\\xc8");
  } else {
    thread shockpainloop_internal(self.asmname, statename, 1, 0);
  }

  wait loop_time;
  self notify("\x8a;\x8f\xb6\xae\xc5\\\xee\xa0\x02_>");
  asm::asm_fireevent(asmname, "\x99\\\xc8\xcd\xf2<\x1f$\xa3F3\xa3P\xbc");
  self.emplooptime = undefined;
  finishpain(asmname, statename, params);
}

function shockpainloop_c6_cleanup(asmname, statename, params) {
  self stopsounds();
}

function shockpainloop_internal(asmname, statename, playbackrate, ismovestate, allowrandom) {
  self endon(statename + "\x1b\xe0K\x01;P\xfdf\x98");
  self endon("\x8a;\x8f\xb6\xae\xc5\\\xee\xa0\x02_>");

  if(isDefined(ismovestate) && ismovestate) {
    moveknob = asm::asm_lookupanimfromaliasifexists("?\xd3b\x8e/", "\x80[\xb3\x9d");

    if(isDefined(moveknob)) {
      self setmoveanimknob(moveknob);
    }
  }

  prevanim = asm::asm_getbodyknob();
  curanim = asm::asm_getanim(asmname, statename);

  while(true) {
    if(isDefined(allowrandom)) {
      curanim = asm::asm_getanim(asmname, statename);
    }

    curxanim = asm::asm_getxanim(statename, curanim);
    self aisetanim(statename, curanim, playbackrate);
    asm::asm_playfacialanim(asmname, statename, curxanim);
    prevanim = curanim;
    asm::asm_donotetrackssingleloop(asmname, statename, curxanim, asm::asm_getnotehandler(asmname, statename));
  }
}

function chooseshockpainrecovery(asmname, statename, params) {
  return asm::asm_lookupanimfromalias(statename, "\x9b9\x906_X1\x92\xea8\xa6\x8b\xe1" + self.currentpose);
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
  if(note == "&\x1d\x8e\xdeq(4x\x06\xf8\x16\x1c") {
    return 1;
  }
}

function getpainweaponsize() {
  size = "\xffG\x90";
  weaponsize = "\x93\xa536Y";
  objweapon = self.damageweapon;

  if(isDefined(objweapon) && objweapon.basename != "\x8e`0\xbf\x1f\xc6`\x0fS\x8d/\a\xa8") {
    weaponsize = objweapon.classname;
  }

  if(weaponsize == "\x8e\xfcc\xbe\xdf\xa6" || weaponsize == "\xff\x9el") {
    size = "\xffG\x90";
  } else if(weaponsize == "\n\x1f+\x8dob") {
    size = "\xffG\x90";

    if(isDefined(self.lastattacker) && distancesquared(self.lastattacker.origin, self.origin) <= 62500) {
      size = "\x97\xf4\xf1";
    }
  } else if(weaponsize == "\xff\x12\x9a\xbe.a" || weaponsize == "\b5") {
    size = "\x97\xf4\xf1";
  } else if(weaponsize == ",\xe1\x93So\x98\r" && isDefined(self.damagemod) && self.damagemod == "M\x81\xaf\xee\xc9\xcfD\xef\x91J") {
    size = "\x97\xf4\xf1";
  }

  if(isDefined(level.fnasmsoldiergetpainweaponsize)) {
    size = self[[level.fnasmsoldiergetpainweaponsize]](size);
  }

  return size;
}

function getpaindirectiontoactor() {
  if(isDefined(self.damageyaw) && self.damageyaw >= -45 && self.damageyaw <= 45) {
    dir = "3\x1b";
    return dir;
  }

  if(isDefined(self.damageyaw) && self.damageyaw < -45 && self.damageyaw > -135) {
    dir = "9\x02";
    return dir;
  }

  if(isDefined(self.damageyaw) && self.damageyaw > 45 && self.damageyaw < 135) {
    dir = "\a}";
    return dir;
  }

  dir = "\xbe\xcc";
  return dir;
}

function choosedirectionalpainanim_transition(asmname, statename, params) {
  if(isDefined(self.var_abda3fb46b2edef9)) {
    var_d29d37a790ea7183 = self.var_abda3fb46b2edef9;
    return asm::asm_lookupanimfromalias(statename, var_d29d37a790ea7183);
  }

  return asm::asm_getrandomanim(asmname, statename);
}

function playpainaniminternal(asmname, statename, params, shouldplayadditives, var_7087b61a0580c0c8, statenameoverride, dontsetorientmode, var_4d6df2156444203c) {
  self endon(statename + "\x1b\xe0K\x01;P\xfdf\x98");
  self.var_d888f8cc0358318f = 1;

  if(isDefined(self.a.paintime)) {
    self.a.lastpaintime = self.a.paintime;
  } else {
    self.a.lastpaintime = 0;
  }

  self.a.paintime = gettime();

  if(self.stairsstate != "\r+x5") {
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

  self animmode("\x1b\x9e\x86\xecr\x97\xa2");

  if(!istrue(dontsetorientmode)) {
    self orientmode("u\x9fP\x1a\xbe4oa\xd5\xd9", self.angles[1]);
  }

  if(!isDefined(self.no_pain_sound)) {
    face::saygenericdialogue("\x80\xb5\xc7J");
  }

  if(death::shouldhelmetpoponpain(utility::wasdamagedbyexplosive())) {
    death::helmetpop();
  }

  animstatename = statename;

  if(isDefined(statenameoverride)) {
    animstatename = statenameoverride;
  }

  painanim = asm::asm_getanim(asmname, statename, params);
  assert(isDefined(painanim));
  self aisetanim(animstatename, painanim);
  painxanim = asm::asm_getxanim(animstatename, painanim);
  asm::asm_playfacialanim(asmname, statename, painxanim);

  if(isDefined(var_4d6df2156444203c)) {
    self thread[[var_4d6df2156444203c]](asmname, statename, painanim, painxanim);
  }

  self.requestdifferentcover = 1;

  if(animhasnotetrack(painxanim, "f\x97\xb9`\xd1~\x80(\xca")) {
    asm::asm_donotetracks(asmname, statename, undefined, undefined, animstatename);
  }

  asm::asm_donotetracks(asmname, statename, asm::asm_getnotehandler(asmname, statename), undefined, animstatename);

  if(istrue(var_7087b61a0580c0c8)) {
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
  if(isDefined(self._blackboard.coverexposetype) && self._blackboard.coverexposetype == "&") {
    return 1;
  }

  return 0;
}

function finishpain(asmname, statename, params) {
  self.a.painplaying = undefined;
  self notify("\xbb\x91a^\xe9\x1dr\x1e\x1cks\xf5y@");
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

  thread asm::asm_setstate(returnstate, undefined);
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

  if(self.lasttorsoanim == "\x1e\x9c\x9f\xceLO\xc5\xe4\xf1\x9a\xb7") {
    transitionanim = asm::asm_lookupanimfromalias(statename, "\x1e\x9c\x9f\xceLO\xc5\xe4\xf1\x9a\xb7");
  } else if(self.lasttorsoanim == "]\x7fU\x15\xb1\xfa\xc9\x143g7") {
    transitionanim = asm::asm_lookupanimfromalias(statename, "]\x7fU\x15\xb1\xfa\xc9\x143g7");
  } else {
    transitionanim = asm::asm_lookupanimfromalias(statename, "\x91\xca\xcc\v\xab\xd8:");
  }

  self.lasttorsoanim = undefined;
  return transitionanim;
}

function choosepainanim_standtorso(asmname, statename, params) {
  if(utility::damagelocationisany("\x1e\x9c\x9f\xceLO\xc5\xe4\xf1\x9a\xb7")) {
    self.lasttorsoanim = "\x1e\x9c\x9f\xceLO\xc5\xe4\xf1\x9a\xb7";
    return asm::asm_lookupanimfromalias(statename, "\x1e\x9c\x9f\xceLO\xc5\xe4\xf1\x9a\xb7");
  }

  if(utility::damagelocationisany("]\x7fU\x15\xb1\xfa\xc9\x143g7")) {
    self.lasttorsoanim = "]\x7fU\x15\xb1\xfa\xc9\x143g7";
    return asm::asm_lookupanimfromalias(statename, "]\x7fU\x15\xb1\xfa\xc9\x143g7");
  }

  self.lasttorsoanim = "\x91\xca\xcc\v\xab\xd8:";
  return asm::asm_lookupanimfromalias(statename, "\x91\xca\xcc\v\xab\xd8:");
}

function choosepainanim_stand(asmname, statename, params) {
  if(utility_common::isusingsidearm()) {
    return choosepainanim_pistol(asmname, statename, params);
  }

  painarray = [];

  if(utility::damagelocationisany("\x1e\x9c\x9f\xceLO\xc5\xe4\xf1\x9a\xb7")) {
    painarray[painarray.size] = asm::asm_lookupanimfromalias(statename, "\x1e\x9c\x9f\xceLO\xc5\xe4\xf1\x9a\xb7");
  } else if(utility::damagelocationisany("]\x7fU\x15\xb1\xfa\xc9\x143g7")) {
    painarray[painarray.size] = asm::asm_lookupanimfromalias(statename, "]\x7fU\x15\xb1\xfa\xc9\x143g7");
  } else if(utility::damagelocationisany("\x83\xe2\x11D", "\xebe\xe3\x82S\x14", "\xcd\xca\xd8k")) {
    painarray[painarray.size] = asm::asm_lookupanimfromalias(statename, "\x83\xe2\x11D");
  } else if(utility::damagelocationisany("Wr\xcf\xaaD\xdb\xc0\xb8\xff5~\x187\xa5m", "\x15\x018#\xac\xddK8v\xdf$\x8f\xd7\xaf\xe9")) {
    painarray[painarray.size] = asm::asm_lookupanimfromalias(statename, "\xc2p`0\x13\xe0\x8b\x8b\x8f");
  } else if(utility::damagelocationisany("DZKnO\xecT\\\xd23\x15\xf4\xfa6", "\x80\x037^\vH5.\xed\t\xc4^\xcd\x0e")) {
    painarray[painarray.size] = asm::asm_lookupanimfromalias(statename, "r,t\x87\xc3W\xaf\xa1");
  } else if(utility::damagelocationisany("M\xde\x83\xb6\xcbT\xdb}bX~J\xa5[", "!d\xbe\x12\x1f\x85\xdc\xf1:\xc5\xab\x9b\t5", "\xcbcp\x97\x9e\xb3\x04\xd0\x9d")) {
    painarray[painarray.size] = asm::asm_lookupanimfromalias(statename, "\xb0&}O,\xe8ZI");
  } else if(utility::damagelocationisany("\x11\xfa\xe7\x05\x0f\xfe\x84wW\xbbh\xc9\x82\xc6;", "-\x10\xe9y\x90\x97\xd7\xd2\xc2F\x8d\xd8\x81\x99i", "#c'\x88\xfb\xd1W\xa7\xbd\xbb")) {
    painarray[painarray.size] = asm::asm_lookupanimfromalias(statename, "\xeb\xf0\xef\x95x|\xe0\x1a:");
  }

  if(painarray.size < 2) {
    painarray[painarray.size] = asm::asm_lookupanimfromalias(statename, "\x91\xca\xcc\v\xab\xd8:");
  }

  assert(painarray.size > 0, painarray.size);
  return painarray[randomint(painarray.size)];
}

function choosepainanim_damageshield(asmname, statename, params) {
  painarray = [];

  if(painarray.size < 2) {
    painarray[painarray.size] = asm::asm_lookupanimfromalias(statename, "\x91\xca\xcc\v\xab\xd8:");
  }

  assert(painarray.size > 0, painarray.size);
  return painarray[randomint(painarray.size)];
}

function choosedynamicpainanim_expcrouchlegs(asmname, statename, params) {
  painarray = [];
  painarray[painarray.size] = asm::asm_lookupanimfromalias(statename, "\x91\xca\xcc\v\xab\xd8:");
  assert(painarray.size > 0, painarray.size);
  return painarray[randomint(painarray.size)];
}

function choosepainanim_crouch(asmname, statename, params) {
  painarray = [];
  painarray[painarray.size] = asm::asm_lookupanimfromalias(statename, "\x91\xca\xcc\v\xab\xd8:");

  if(utility::damagelocationisany("\xfa\xa3I)\xad\xea\xf0+n", "\x80\x037^\vH5.\xed\t\xc4^\xcd\x0e", "DZKnO\xecT\\\xd23\x15\xf4\xfa6")) {
    painarray[painarray.size] = asm::asm_lookupanimfromalias(statename, "r,t\x87\xc3W\xaf\xa1");
  }

  if(utility::damagelocationisany("\xd1y|{;\xd4r4\fp", "\x15\x018#\xac\xddK8v\xdf$\x8f\xd7\xaf\xe9", "Wr\xcf\xaaD\xdb\xc0\xb8\xff5~\x187\xa5m")) {
    painarray[painarray.size] = asm::asm_lookupanimfromalias(statename, "\xc2p`0\x13\xe0\x8b\x8b\x8f");
  }

  assert(painarray.size > 0, painarray.size);
  return painarray[randomint(painarray.size)];
}

function choosepainanim_pistol(asmname, statename, params) {
  painarray = [];

  if(utility::damagelocationisany("\x1e\x9c\x9f\xceLO\xc5\xe4\xf1\x9a\xb7")) {
    painarray[painarray.size] = asm::asm_lookupanimfromalias(statename, "pisG\xbd\x8d\xaf\xe8\xed\xc9\xb9\xed_]\xc1\x0ee9");
  } else if(utility::damagelocationisany("]\x7fU\x15\xb1\xfa\xc9\x143g7")) {
    painarray[painarray.size] = asm::asm_lookupanimfromalias(statename, "1\x1f6\x11\x90\xd5\xceqjJ\xd2\x97\x93\xf1\x87\x16\x04q");
  } else if(utility::damagelocationisany("\xcd\xca\xd8k")) {
    painarray[painarray.size] = asm::asm_lookupanimfromalias(statename, "\x1c\xd27\x8e\xb7\xd8_nY\xd8k");
  } else if(utility::damagelocationisany("\x83\xe2\x11D")) {
    painarray[painarray.size] = asm::asm_lookupanimfromalias(statename, "8\x96\xe6\x8e\xb7\xc6}\x86e\xb0d");
  } else if(utility::damagelocationisany("M\xde\x83\xb6\xcbT\xdb}bX~J\xa5[", "\x11\xfa\xe7\x05\x0f\xfe\x84wW\xbbh\xc9\x82\xc6;")) {
    painarray[painarray.size] = asm::asm_lookupanimfromalias(statename, "K.\a\xe4\xb3\x82\x95j\xfe\xfb");
  } else if(utility::damagelocationisany("DZKnO\xecT\\\xd23\x15\xf4\xfa6")) {
    painarray[painarray.size] = asm::asm_lookupanimfromalias(statename, "g\x1d\xd6\xb2\x1c\xd8\xb55\\&L\xf6d\xb8O<\xe7\x9c\xffqK");
  } else if(utility::damagelocationisany("\x80\x037^\vH5.\xed\t\xc4^\xcd\x0e")) {
    painarray[painarray.size] = asm::asm_lookupanimfromalias(statename, "\xdf\xda\xef\xb7\xf7F\x14\xa2\xbd_\xba\xd7C\x01d@\x99D\x87\x85\xec");
  } else if(utility::damagelocationisany("Wr\xcf\xaaD\xdb\xc0\xb8\xff5~\x187\xa5m")) {
    painarray[painarray.size] = asm::asm_lookupanimfromalias(statename, "Y\x9er\x1b\x80\x89X\x05L+\v\x92s\x13$\xc2\x81\xf3\x84\xf9\x15R");
  } else if(utility::damagelocationisany("\x15\x018#\xac\xddK8v\xdf$\x8f\xd7\xaf\xe9")) {
    painarray[painarray.size] = asm::asm_lookupanimfromalias(statename, "p\xa5n\x8e\xdb\xd8_'Zv4\xa3\xbe\x16N\xb5\xeb\xb1ow\xacr");
  }

  if(painarray.size < 2) {
    painarray[painarray.size] = asm::asm_lookupanimfromalias(statename, ">\xe5KTXv$\xf2\x14\n}u(W");
  }

  assert(painarray.size > 0, painarray.size);
  return painarray[randomint(painarray.size)];
}

function choosepainanim_covercorner_helper(asmname, statename, params, angles) {
  if(isDefined(params) && isDefined(params[1])) {
    return asm::asm_lookupanimfromalias(statename, params[1]);
  }

  if(self.currentpose == "1x\xc5\xb4\xabx") {
    return asm::asm_lookupanimfromalias(statename, "1x\xc5\xb4\xabx");
  }

  return asm::asm_lookupanimfromalias(statename, "\x8b\x90\xb5\xc4W");
}

function choosepainanim_covercorner(asmname, statename, params) {
  return choosepainanim_covercorner_helper(asmname, statename, params, undefined);
}

function choosedynamicpainanim_back(asmname, statename, params) {
  alias = "\x8a+\xf04";
  return asm::asm_lookupanimfromalias(statename, alias);
}

function choosedynamicpainanim_covercrouch(asmname, statename, params) {
  painarray = [];

  if(utility::damagelocationisany("\x1e\x9c\x9f\xceLO\xc5\xe4\xf1\x9a\xb7", "]\x7fU\x15\xb1\xfa\xc9\x143g7")) {
    painarray[painarray.size] = asm::asm_lookupanimfromalias(statename, "p\x82\x8b\x888");
  } else if(utility::damagelocationisany("\x83\xe2\x11D", "\xebe\xe3\x82S\x14", "\xcd\xca\xd8k")) {
    painarray[painarray.size] = asm::asm_lookupanimfromalias(statename, "\x83\xe2\x11D");
  }

  if(painarray.size < 2) {
    painarray[painarray.size] = asm::asm_lookupanimfromalias(statename, "\x91\xca\xcc\v\xab\xd8:");
  }

  assert(painarray.size > 0, painarray.size);
  return painarray[randomint(painarray.size)];
}

function choosedynamicpainanim_coverstand(asmname, statename, params) {
  painarray = [];

  if(utility::damagelocationisany("\x1e\x9c\x9f\xceLO\xc5\xe4\xf1\x9a\xb7")) {
    painarray[painarray.size] = asm::asm_lookupanimfromalias(statename, "\x1e\x9c\x9f\xceLO\xc5\xe4\xf1\x9a\xb7");
  } else if(utility::damagelocationisany("]\x7fU\x15\xb1\xfa\xc9\x143g7")) {
    painarray[painarray.size] = asm::asm_lookupanimfromalias(statename, "]\x7fU\x15\xb1\xfa\xc9\x143g7");
  } else if(utility::damagelocationisany("\x83\xe2\x11D", "\xebe\xe3\x82S\x14", "\xcd\xca\xd8k")) {
    painarray[painarray.size] = asm::asm_lookupanimfromalias(statename, "\x83\xe2\x11D");
  } else if(utility::damagelocationisany("Wr\xcf\xaaD\xdb\xc0\xb8\xff5~\x187\xa5m", "\x15\x018#\xac\xddK8v\xdf$\x8f\xd7\xaf\xe9")) {
    painarray[painarray.size] = asm::asm_lookupanimfromalias(statename, "\xc2p`0\x13\xe0\x8b\x8b\x8f");
  } else if(utility::damagelocationisany("DZKnO\xecT\\\xd23\x15\xf4\xfa6", "\x80\x037^\vH5.\xed\t\xc4^\xcd\x0e")) {
    painarray[painarray.size] = asm::asm_lookupanimfromalias(statename, "r,t\x87\xc3W\xaf\xa1");
  } else if(utility::damagelocationisany("M\xde\x83\xb6\xcbT\xdb}bX~J\xa5[", "!d\xbe\x12\x1f\x85\xdc\xf1:\xc5\xab\x9b\t5", "\xcbcp\x97\x9e\xb3\x04\xd0\x9d")) {
    painarray[painarray.size] = asm::asm_lookupanimfromalias(statename, "\xb0&}O,\xe8ZI");
  } else if(utility::damagelocationisany("\x11\xfa\xe7\x05\x0f\xfe\x84wW\xbbh\xc9\x82\xc6;", "-\x10\xe9y\x90\x97\xd7\xd2\xc2F\x8d\xd8\x81\x99i", "#c'\x88\xfb\xd1W\xa7\xbd\xbb")) {
    painarray[painarray.size] = asm::asm_lookupanimfromalias(statename, "\xeb\xf0\xef\x95x|\xe0\x1a:");
  }

  if(painarray.size < 2) {
    painarray[painarray.size] = asm::asm_lookupanimfromalias(statename, "\x91\xca\xcc\v\xab\xd8:");
  }

  assert(painarray.size > 0, painarray.size);
  return painarray[randomint(painarray.size)];
}

function function_efa45fa0165bb478(asmname, statename, params) {
  self aisettargetspeed(length(self.velocity));
  cleanuppainanim(asmname, statename, params);
}

function cleanuppainanim(asmname, statename, params) {
  if(isDefined(self.script) && self.script == "\x80\xb5\xc7J") {
    self notify("\xbb\x91a^\xe9\x1dr\x1e\x1cks\xf5y@");
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

  self._blackboard.var_6ec57c69feb27c7e = 0;
  self.var_d888f8cc0358318f = 0;
  clearpainturnrate(asmname, statename, params);

  if(istrue(self.leavecasualkiller)) {
    namespace_ad29b7c653247c74::terminate_casualkiller(asmname, statename, params);
  }

  if(!istrue(self.ignoreall)) {
    if(isDefined(self.enemy) && lengthsquared(self.velocity) < 1 && isDefined(self.weapon) && !istrue(self.enemy.ignoreme) && self cansee(self.enemy)) {
      self.remainexposedendtime = gettime() + 2000;
    }
  }
}

function transition_flashfinished(asmname, fromstate, tostate, params) {
  if(!utility::isflashed()) {
    return true;
  }

  if(gettime() > self.flashendtime) {
    return true;
  }

  return asm::asm_eventfired(asmname, "8\xdb\x90") || asm::asm_eventfired(asmname, "\xd7\xca\xae\xca\xff\xdb");
}

function playanim_stunned(asmname, statename, params) {
  if(isDefined(self.stunnedcallback)) {
    self[[self.stunnedcallback]]();
  }

  self.var_d888f8cc0358318f = 1;
  stunnedanim = asm::asm_getanim(asmname, statename, params);
  self aisetanim(statename, stunnedanim);
  asm::asm_donotetracks(asmname, statename);
}

function function_e09ef8a07ef18ef1(asmname, statename, params) {
  stunnedanim = asm::asm_getanim(asmname, statename, params);
  self aisetanim(statename, stunnedanim);
  asm::asm_donotetracks(asmname, statename);
}

function function_74061ab7d5ea5c91(asmname, statename, params) {
  if(utility::isstunned()) {
    return false;
  }

  cleanuppainanim(asmname, statename, params);
  return true;
}

function playanim_flashed(asmname, statename, params) {
  self endon(statename + "\x1b\xe0K\x01;P\xfdf\x98");
  playanim_flashed_internal(asmname, statename);
  thread playanim_monitorflashrestart(asmname, statename);
  asm::asm_donotetracks(asmname, statename);
}

function playanim_flashed_internal(asmname, statename) {
  flashanim = asm::asm_getanim(asmname, statename);
  self.var_d888f8cc0358318f = 1;
  rate = 1;

  if(isDefined(self.flashendtime)) {
    flashlength = self.flashendtime - gettime();
    xanim = asm::asm_getxanim(statename, flashanim);
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
  self endon(statename + "\x1b\xe0K\x01;P\xfdf\x98");
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
  utility::flashbangstop();
}

function playanim_burning(asmname, statename, params) {
  self endon(statename + "\x1b\xe0K\x01;P\xfdf\x98");

  if(isDefined(level.battlechatter)) {
    bcs_subcategory = battlechatter_events::function_db79b24109949121(self.damageweapon);

    if(isDefined(bcs_subcategory)) {
      function_99e8e66d1969d7cb(self, undefined, "\x9d\xd1\xde\xa4", bcs_subcategory);
    }
  }

  self.var_d888f8cc0358318f = 1;
  burninganim = asm::asm_getanim(asmname, statename, params);
  playrate = randomfloatrange(0.8, 1.2);
  self orientmode("u\x9fP\x1a\xbe4oa\xd5\xd9", self.angles[1]);
  self aisetanim(statename, burninganim, playrate);
  asm::asm_donotetracks(asmname, statename, &burn_notetrack_handler);
}

function burn_notetrack_handler(note) {
  if(isDefined(self.semtexstuckto)) {
    return;
  }

  switch (note) {
    case #"hash_b3c1b4729e0c6d1a":
      playFXOnTag(level.g_effect["\x03b\x0f\xcf?k\x175.G\x99H\xd7\x1b\xc0.\xbd\xe4\xcb\xa9$"], self, "\xf8\xe6^\xd1\x93\a.\xe3");
      break;
    case #"hash_91b66b1e7d9268f1":
      playFXOnTag(level.g_effect["\xf6\xd2\xc6\xa9\xb8\xf7\xdf\xd6\xce\\\x16\x95\xbd\x90\xba\xf6"], self, "\x8e*\xf05\xc0\x01R\xbeu\x06");
      break;
    case #"hash_91b6751e7d9278af":
      playFXOnTag(level.g_effect["\xf6\xd2\xc6\xa9\xb8\xf7\xdf\xd6\xce\\\x16\x95\xbd\x90\xba\xf6"], self, "\x96\xbd\x11i\xfb|\xe1G\x8f\xafQnO");
      break;
    case #"hash_72c435d66be93437":
      playFXOnTag(level.g_effect["myG\xc5\x89\xc1\x05\xc8\x18\xfe\x18[\x88v\xa3i"], self, "\xc1F\"to\x9c\xd8\x9c\x1c");
      break;
    case #"hash_72c43bd66be93da9":
      playFXOnTag(level.g_effect["myG\xc5\x89\xc1\x05\xc8\x18\xfe\x18[\x88v\xa3i"], self, "\xb0\xe1)\x0e\xbe\xf5\x9c\xed\xb4");
      break;
  }
}

function painanimfaceenemy(asmname, statename, animid, xanim) {
  self endon(statename + "\x1b\xe0K\x01;P\xfdf\x98");
  enemy = self.enemy;
  animlength = getanimlength(xanim);
  endtime = animlength * 0.8;
  startaimtime = animlength;
  var_d72e9e109272aec5 = getnotetracktimes(xanim, "\x99A\xde\xe5}\xf9\xc0s\x91\xb4")[0];

  if(isDefined(var_d72e9e109272aec5)) {
    endtime = var_d72e9e109272aec5 * animlength;
  } else {
    if(asm::asm_currentstatehasflag(asmname, "\x1e\x97\x86\xd0\xf5\xda\xaf\xf9\xdb\xb7\xc5'")) {
      startaimfrac = getnotetracktimes(xanim, "\x93{\xdf\xe6\x03#\v-\xc7")[0];

      if(isDefined(startaimfrac)) {
        endtime = min(endtime, max(0, startaimfrac - 0.3) * animlength);
        startaimtime = startaimfrac * animlength;
      }
    }

    endtime = min(endtime, max(0, animlength - 0.5));
  }

  wait endtime;

  if(isalive(enemy)) {
    var_ddb78c30cdc9a2b0 = getnotetracktimes(xanim, ")\xdf\x8dG\xf0\x95(\xdeS\xa1\x89\xd2\x93\x13")[0];
    var_2ea370bbcbe29c0b = 1;

    if(isDefined(var_ddb78c30cdc9a2b0)) {
      var_2ea370bbcbe29c0b = var_ddb78c30cdc9a2b0;
    }

    turnduration = getanimlength(xanim) * var_2ea370bbcbe29c0b - endtime;
    var_6a5900dd678ef982 = gettime() + turnduration * 1000;

    while(gettime() < var_6a5900dd678ef982 && isalive(enemy)) {
      metoenemy = enemy.origin - self.origin;
      angletoenemy = vectortoyaw(metoenemy);
      anglediff = angleclamp180(angletoenemy - self.angles[1]);
      curt = self getanimtime(xanim);
      remainingrot = getangledelta(xanim, curt, var_2ea370bbcbe29c0b);
      delta = anglediff - remainingrot;
      self orientmode("u\x9fP\x1a\xbe4oa\xd5\xd9", self.angles[1] + delta);
      waitframe();
    }
  }
}

function playpainanim_faceplayer(asmname, statename, params) {
  self endon(statename + "\x1b\xe0K\x01;P\xfdf\x98");
  fnthread = undefined;

  if(isalive(self.enemy) && isDefined(self.lastattacker) && self.enemy == self.lastattacker) {
    fnthread = &painanimfaceenemy;
  }

  playpainaniminternal(asmname, statename, params, 0, 1, undefined, 1, fnthread);
}

function playpainanim_exposedstand(asmname, statename, params) {
  self endon(statename + "\x1b\xe0K\x01;P\xfdf\x98");
  fnthread = undefined;

  if(isalive(self.enemy) && isDefined(self.lastattacker) && self.enemy == self.lastattacker) {
    fnthread = &painanimfaceenemy;
  }

  playpainaniminternal(asmname, statename, params, 0, 1, undefined, 0, fnthread);
}

function playpainanim_exposedcrouch(asmname, statename, params) {
  self endon(statename + "\x1b\xe0K\x01;P\xfdf\x98");
  self.painattacker = self.lastattacker;
  playpainaniminternal(asmname, statename, params, 0, 1);
}

function playpainanim_exposedcrouchtransition(asmname, statename, params) {
  self endon(statename + "\x1b\xe0K\x01;P\xfdf\x98");
  animid = asm::asm_getanim(asmname, statename);
  self aisetanim(statename, animid);
  asm::asm_playfacialanim(asmname, statename, asm::asm_getxanim(statename, animid));

  if(isalive(self.enemy) && isDefined(self.painattacker) && self.enemy == self.painattacker) {
    thread painanimfaceenemy(asmname, statename, animid, asm::asm_getxanim(statename, animid));
  }

  self.painattacker = undefined;
  asm::asm_donotetracks(asmname, statename, asm::asm_getnotehandler(asmname, statename));
}

function clearpainturnrate(asmname, statename, params) {
  if(isDefined(self.painoldturnrate)) {
    self.turnrate = self.painoldturnrate;
    self.painoldturnrate = undefined;
  }
}

function function_6558fcce4b5836a1(asmname, statename, params) {
  animaliasparam = undefined;

  if(isDefined(params) && isstring(params)) {
    animaliasparam = params;
  }

  self endon(statename + "\x1b\xe0K\x01;P\xfdf\x98");
  self orientmode("\x99\xc2l\xb2\x806\xbaNN\x95\xb9\xa3");
  self animmode("\xeb\xb7\x1b\x10\xf0r\x1e.\x80\xcf\xd6~");

  if(isDefined(animaliasparam)) {
    animid = asm::asm_getanim(asmname, statename, animaliasparam);
  } else {
    animid = asm::asm_getanim(asmname, statename);
  }

  thread function_c248ce55578bc203();
  self aisetanim(statename, animid);
  endnote = asm::asm_donotetracks(asmname, statename, asm::asm_getnotehandler(asmname, statename));

  if(endnote == "f\x97\xb9`\xd1~\x80(\xca") {
    endnote = asm::asm_donotetracks(asmname, statename, asm::asm_getnotehandler(asmname, statename));
  }
}

function function_a3e402ae7ea5a9f2(asmname, statename, blendtime, params) {
  self endon(statename + "\x1b\xe0K\x01;P\xfdf\x98");
  animid = asm::asm_getanim(asmname, statename);
  animname = asm::asm_getxanim(statename, animid);
  thread function_afe308fa30384334();
  self aisetanim(statename, animid);
  asm::asm_playfacialanim(asmname, statename, animname);
  self function_d2d44081828aa353(animname);
  endnote = asm::asm_donotetracks(asmname, statename, asm::asm_getnotehandler(asmname, statename));

  if(endnote == "f\x97\xb9`\xd1~\x80(\xca") {
    endnote = asm::asm_donotetracks(asmname, statename, asm::asm_getnotehandler(asmname, statename));
  }
}

function function_c248ce55578bc203() {
  if(!isDefined(self.weapon)) {
    return;
  }

  self endon("\x1e\xfd\xd1\xa2\a");
  self waittillmatch("\xe0W\xd2\xd7K\x14\xc8\xac8 \x81\xfe\xbc\xa8\xba\xd2\xf5", "\x98\x92\x03=G\xd2\x98MG|k\xc5\xd9\xfa\x85\xf8");
  shared::placeweaponon(self.weapon, "\xd8\r\xb2\x9b\x1d");
}

function function_afe308fa30384334() {
  if(!isDefined(self.weapon)) {
    return;
  }

  self endon("\x1e\xfd\xd1\xa2\a");
  self waittillmatch("wA\xa9ab\x8e9\x92Z\xfe\x18\xb9r\x89R\x1a\xc5z\x85g", "5\xdcs\xe7$,\x1b\x91'0\xaf\x86u\xeb\xbf\xce&\xbf");
  shared::placeweaponon(self.weapon, "o0\xee\xc1\x8c");
}

function disablerunpain(asmname, statename, tostatename, params) {
  return istrue(self.disablerunpain);
}

function function_9cf321be63a08b92(asmname, statename, params) {
  painalias = "\xe6\xbd\x13\xc4?\xfc.\x80\x8a\x10" + getpaindirectiontoactor();
  painanim = asm::asm_lookupanimfromalias(statename, painalias);
  return painanim;
}

function function_fdafe7f6a54c8e96(asmname, statename, params) {
  painalias = "\xe0Mf\x99e\x01\xd1\rw\x8aP\xa5\x1d\xe6o\xe6K\xa9" + getpaindirectiontoactor();
  painanim = asm::asm_lookupanimfromalias(statename, painalias);
  return painanim;
}