/****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\asm\soldier\grenade_response.gsc
****************************************************/

#using scripts\anim\shared;
#using scripts\asm\asm;
#namespace grenade_response;

function playgrenadereturnthrowanim(asmname, statename, params) {
  self endon(statename + "\x1b\xe0K\x01;P\xfdf\x98");
  throwanim = asm::asm_getanim(asmname, statename);
  throwxanim = asm::asm_getxanim(statename, throwanim);
  self animmode("\xee\xedc\xfb\xfa}f\x11y\xb9>\x9f\xaa");

  if(isDefined(self.grenade) && distancesquared(self.grenade.origin, self.origin) > 36) {
    self orientmode("u\x9fP\x1a\xbe4oa\xd5\xd9", vectortoyaw(self.grenade.origin - self.origin));
  }

  self aisetanim(statename, throwanim);
  var_63155b97250c005 = animhasnotetrack(throwxanim, "_\x8fQv\x1b\xfdi\\n\xe8\x15n");
  var_46a0af063b077d64 = animhasnotetrack(throwxanim, "\xfe-\xc5[\x81\n\xef\xe7\xed\x0fD`\xcb");
  var_149d172337de4622 = var_63155b97250c005 || var_46a0af063b077d64;

  if(var_149d172337de4622) {
    shared::placeweaponon(self.weapon, "=\xff0b");
    thread asm::asm_donotetracks(asmname, statename);

    if(var_63155b97250c005) {
      self waittillmatch(statename, "_\x8fQv\x1b\xfdi\\n\xe8\x15n");
    } else {
      self waittillmatch(statename, "\xfe-\xc5[\x81\n\xef\xe7\xed\x0fD`\xcb");
    }

    self pickupgrenade();
    function_99e8e66d1969d7cb(self, undefined, "`>\x02", "RJ\xc2#.Er\xd0/\xccw\xa2");
    grenadevel = self getgrenadetossvel();

    if(isDefined(grenadevel)) {
      grenadeangle = vectortoyaw(grenadevel);
      self orientmode("u\x9fP\x1a\xbe4oa\xd5\xd9", grenadeangle);
    }

    self waittillmatch(statename, "\x9e\x19\xa8K\xf6\xfc3<R\xc1\xd4\xbay");
  } else {
    thread asm::asm_donotetracks(asmname, statename);
    self waittillmatch(statename, "\x9e\x19\xa8K\xf6\xfc3<R\xc1\xd4\xbay");
    self pickupgrenade();
    function_99e8e66d1969d7cb(self, undefined, "`>\x02", "RJ\xc2#.Er\xd0/\xccw\xa2");
  }

  if(isDefined(self.grenade)) {
    self throwgrenade();
  }

  wait 1;
  self notify("\xbb\x91a^\xe9\x1dr\x1e\x1cks\xf5y@");
}

function terminategrenadereturnthrowanim(asmname, statename, params) {
  asm::asm_fireephemeralevent("<\xae\x15\x7f\xd0y\xc5'\xbddU\xadxL@\xbc", "\xf1eb\xb2}\x19\x9f\xef{]\xce\x9d\xad3\x86,t\x9a\b\xb3I");
  shared::placeweaponon(self.weapon, "o0\xee\xc1\x8c");

  if(isDefined(self.oldgrenadeweapon)) {
    self.grenadeweapon = self.oldgrenadeweapon;
    self.oldgrenadeweapon = undefined;
  }
}

function islowthrowsafe() {
  start = (self.origin[0], self.origin[1], self.origin[2] + 20);
  end = start + anglesToForward(self.angles) * 50;
  return sighttracepassed(start, end, 0, undefined);
}

function choosegrenadereturnthrowanim(asmname, statename, params) {
  throwanim = undefined;
  throwdist = 1000;

  if(isDefined(self.enemy)) {
    throwdist = distance(self.origin, self.enemy.origin);
  }

  animarray = [];

  if(throwdist < 600 && islowthrowsafe()) {
    if(throwdist < 300) {
      return asm::asm_lookupanimfromalias(statename, "\xf9qv,\xde\x87&\xc8\xda\xd9\xeb");
    } else {
      return asm::asm_lookupanimfromalias(statename, "\x9d\x95\x14\xabW\xae\xdb\vK\xf8");
    }
  }

  return asm::asm_lookupanimfromalias(statename, "\r\xb5\x17\xed\xe0\x87A0\xdc#M0\x83");
}

function playgrenadeavoidanim(asmname, statename, params) {
  self.asm.bshouldattemptdive = randomint(100) > 50;
}

function shouldgrenadedive(asmname, statename, tostatename, params) {
  if(!self.asm.bshouldattemptdive) {
    return false;
  }

  if(self.currentpose != "\x8b\x90\xb5\xc4W") {
    return false;
  }

  if(!isDefined(self.grenade)) {
    return false;
  }

  var_604da5259944947a = 0;
  var_604da5259944947a = angleclamp180(vectortoangles(self.grenade.origin - self.origin)[1] - self.angles[1]);

  if(abs(var_604da5259944947a) < 90 && params == "\x1e2^mI\xd2\x14V") {
    return false;
  }

  diveanim = asm::asm_getanim(asmname, tostatename);
  divexanim = asm::asm_getxanim(tostatename, diveanim);
  moveby = getmovedelta(divexanim, 0, 0.5);
  divetopos = self localtoworldcoords(moveby);

  if(!self maymovetopoint(divetopos)) {
    return false;
  }

  return true;
}

function grenadeavoid_terminate(asmname, statename, params) {
  self.asm.bshouldattemptdive = undefined;
}