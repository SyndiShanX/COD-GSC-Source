/*******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\asm\soldier\grenade_response.gsc
*******************************************************/

#using scripts\anim\shared;
#using scripts\asm\asm;
#namespace grenade_response;

function playgrenadereturnthrowanim(asmname, statename, params) {
  self endon(statename + "_finished");
  throwanim = asm_getanim(asmname, statename);
  throwxanim = asm_getxanim(statename, throwanim);
  self animmode("zonly_physics");

  if(isDefined(self.grenade) && distancesquared(self.grenade.origin, self.origin) > 36) {
    self orientmode("face angle", vectortoyaw(self.grenade.origin - self.origin));
  }

  self aisetanim(statename, throwanim);
  var_3bb16be1e3f07ac = animhasnotetrack(throwxanim, "grenade_left");
  var_e8f68117b9bb4f99 = animhasnotetrack(throwxanim, "grenade_right");
  var_cf41362c42b790cf = var_3bb16be1e3f07ac || var_e8f68117b9bb4f99;

  if(var_cf41362c42b790cf) {
    scripts\anim\shared::placeweaponon(self.weapon, "left");
    thread asm_donotetracks(asmname, statename);

    if(var_3bb16be1e3f07ac) {
      self waittillmatch(statename, "grenade_left");
    } else {
      self waittillmatch(statename, "grenade_right");
    }

    self pickupgrenade();
    function_216c67ab6749137a(self, undefined, "use", "frag_grenade");
    grenadevel = self getgrenadetossvel();

    if(isDefined(grenadevel)) {
      grenadeangle = vectortoyaw(grenadevel);
      self orientmode("face angle", grenadeangle);
    }

    self waittillmatch(statename, "grenade_throw");
  } else {
    thread asm_donotetracks(asmname, statename);
    self waittillmatch(statename, "grenade_throw");
    self pickupgrenade();
    function_216c67ab6749137a(self, undefined, "use", "frag_grenade");
  }

  if(isDefined(self.grenade)) {
    self throwgrenade();
  }

  wait 1;
  self notify("killanimscript");
}

function terminategrenadereturnthrowanim(asmname, statename, params) {
  asm_fireephemeralevent("grenade_response", "return throw complete");
  scripts\anim\shared::placeweaponon(self.weapon, "right");

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
      return asm_lookupanimfromalias(statename, "throw_short");
    } else {
      return asm_lookupanimfromalias(statename, "throw_long");
    }
  }

  return asm_lookupanimfromalias(statename, "throw_default");
}

function playgrenadeavoidanim(asmname, statename, params) {
  self.asm.bshouldattemptdive = randomint(100) > 50;
}

function shouldgrenadedive(asmname, statename, tostatename, params) {
  if(!self.asm.bshouldattemptdive) {
    return false;
  }

  if(self.currentpose != "stand") {
    return false;
  }

  if(!isDefined(self.grenade)) {
    return false;
  }

  var_e44254f1152cc64f = 0;
  var_e44254f1152cc64f = angleclamp180(vectortoangles(self.grenade.origin - self.origin)[1] - self.angles[1]);

  if(abs(var_e44254f1152cc64f) < 90 && params == "backward") {
    return false;
  }

  diveanim = asm_getanim(asmname, tostatename);
  divexanim = asm_getxanim(tostatename, diveanim);
  moveby = getmovedelta(divexanim, 0, 0.5);
  var_597d30b536cff2cc = self localtoworldcoords(moveby);

  if(!self maymovetopoint(var_597d30b536cff2cc)) {
    return false;
  }

  return true;
}

function grenadeavoid_terminate(asmname, statename, params) {
  self.asm.bshouldattemptdive = undefined;
}