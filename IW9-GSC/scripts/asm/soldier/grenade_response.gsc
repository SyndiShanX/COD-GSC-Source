/****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\asm\soldier\grenade_response.gsc
****************************************************/

playgrenadereturnthrowanim(asmname, statename, params) {
  self endon(statename + "_finished");
  _id_D21FBD6DD45D4D02 = scripts\asm\asm::asm_getanim(asmname, statename);
  _id_7775DF8E768C0EB4 = scripts\asm\asm::asm_getxanim(statename, _id_D21FBD6DD45D4D02);
  self animmode("zonly_physics");

  if(isDefined(self.grenade) && distancesquared(self.grenade.origin, self.origin) > 36)
    self orientmode("face angle", vectortoyaw(self.grenade.origin - self.origin));

  self aisetanim(statename, _id_D21FBD6DD45D4D02);
  _id_03BB16BE1E3F07AC = animhasnotetrack(_id_7775DF8E768C0EB4, "grenade_left");
  _id_E8F68117B9BB4F99 = animhasnotetrack(_id_7775DF8E768C0EB4, "grenade_right");
  _id_CF41362C42B790CF = _id_03BB16BE1E3F07AC || _id_E8F68117B9BB4F99;

  if(_id_CF41362C42B790CF) {
    _id_3433EE6B63C7E243::placeweaponon(self.weapon, "left");
    thread scripts\asm\asm::asm_donotetracks(asmname, statename);

    if(_id_03BB16BE1E3F07AC)
      self waittillmatch(statename, "grenade_left");
    else
      self waittillmatch(statename, "grenade_right");

    self pickupgrenade();
    _id_2CFBD51B20C32D37::evaluateattackevent("frag");
    _id_2280F90002D7A99C = self getgrenadetossvel();

    if(isDefined(_id_2280F90002D7A99C)) {
      _id_0085D69E32359B24 = vectortoyaw(_id_2280F90002D7A99C);
      self orientmode("face angle", _id_0085D69E32359B24);
    }

    self waittillmatch(statename, "grenade_throw");
  } else {
    thread scripts\asm\asm::asm_donotetracks(asmname, statename);
    self waittillmatch(statename, "grenade_throw");
    self pickupgrenade();
    _id_2CFBD51B20C32D37::evaluateattackevent("frag");
  }

  if(isDefined(self.grenade))
    self throwgrenade();

  wait 1;
  self notify("killanimscript");
}

terminategrenadereturnthrowanim(asmname, statename, params) {
  scripts\asm\asm::asm_fireephemeralevent("grenade_response", "return throw complete");
  _id_3433EE6B63C7E243::placeweaponon(self.weapon, "right");

  if(isDefined(self.oldgrenadeweapon)) {
    self.grenadeweapon = self.oldgrenadeweapon;
    self.oldgrenadeweapon = undefined;
  }
}

islowthrowsafe() {
  start = (self.origin[0], self.origin[1], self.origin[2] + 20);
  end = start + anglesToForward(self.angles) * 50;
  return sighttracepassed(start, end, 0, undefined);
}

choosegrenadereturnthrowanim(asmname, statename, params) {
  _id_D21FBD6DD45D4D02 = undefined;
  _id_D3CB2DE2FCE8602B = 1000;

  if(isDefined(self.enemy))
    _id_D3CB2DE2FCE8602B = distance(self.origin, self.enemy.origin);

  animarray = [];

  if(_id_D3CB2DE2FCE8602B < 600 && islowthrowsafe()) {
    if(_id_D3CB2DE2FCE8602B < 300)
      return scripts\asm\asm::asm_lookupanimfromalias(statename, "throw_short");
    else
      return scripts\asm\asm::asm_lookupanimfromalias(statename, "throw_long");
  }

  return scripts\asm\asm::asm_lookupanimfromalias(statename, "throw_default");
}

playgrenadeavoidanim(asmname, statename, params) {
  self.asm.bshouldattemptdive = randomint(100) > 50;
}

shouldgrenadedive(asmname, statename, _id_F2B19B25D457C2A6, params) {
  if(!self.asm.bshouldattemptdive)
    return 0;

  if(self.currentpose != "stand")
    return 0;

  if(!isDefined(self.grenade))
    return 0;

  _id_E44254F1152CC64F = 0;
  _id_E44254F1152CC64F = angleclamp180(vectortoangles(self.grenade.origin - self.origin)[1] - self.angles[1]);

  if(abs(_id_E44254F1152CC64F) < 90 && params == "backward")
    return 0;

  _id_BBE5D95734E18B42 = scripts\asm\asm::asm_getanim(asmname, _id_F2B19B25D457C2A6);
  _id_B097EA73F09F9EF4 = scripts\asm\asm::asm_getxanim(_id_F2B19B25D457C2A6, _id_BBE5D95734E18B42);
  _id_97AB28057148C1FD = getmovedelta(_id_B097EA73F09F9EF4, 0, 0.5);
  _id_597D30B536CFF2CC = self localtoworldcoords(_id_97AB28057148C1FD);

  if(!self maymovetopoint(_id_597D30B536CFF2CC))
    return 0;

  return 1;
}

grenadeavoid_terminate(asmname, statename, params) {
  self.asm.bshouldattemptdive = undefined;
}