/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: asm\soldier\grenade_response.gsc
***********************************************/

playgrenadereturnthrowanim(var_0, var_1, var_2) {
  self endon(var_1 + "_finished");
  var_3 = scripts\asm\asm::asm_getanim(var_0, var_1);
  var_4 = scripts\asm\asm::asm_getxanim(var_1, var_3);
  self animmode("zonly_physics");

  if(isDefined(self.grenade) && distancesquared(self.grenade.origin, self.origin) > 36)
    self orientmode("face angle", vectortoyaw(self.grenade.origin - self.origin));

  self aisetanim(var_1, var_3);
  var_5 = animhasnotetrack(var_4, "grenade_left");
  var_6 = animhasnotetrack(var_4, "grenade_right");
  var_7 = var_5 || var_6;

  if(var_7) {
    scripts\anim\shared.gsc::placeweaponon(self.weapon, "left");
    thread scripts\asm\asm::asm_donotetracks(var_0, var_1);

    if(var_5)
      self waittillmatch(var_1, "grenade_left");
    else
      self waittillmatch(var_1, "grenade_right");

    self pickupgrenade();
    scripts\anim\battlechatter_wrapper.gsc::evaluateattackevent("frag");
    var_8 = self getgrenadetossvel();

    if(isDefined(var_8)) {
      var_9 = vectortoyaw(var_8);
      self orientmode("face angle", var_9);
    }

    self waittillmatch(var_1, "grenade_throw");
  } else {
    thread scripts\asm\asm::asm_donotetracks(var_0, var_1);
    self waittillmatch(var_1, "grenade_throw");
    self pickupgrenade();
    scripts\anim\battlechatter_wrapper.gsc::evaluateattackevent("frag");
  }

  if(isDefined(self.grenade))
    self throwgrenade();

  wait 1;
  self notify("killanimscript");
}

terminategrenadereturnthrowanim(var_0, var_1, var_2) {
  scripts\asm\asm::asm_fireephemeralevent("grenade_response", "return throw complete");
  scripts\anim\shared.gsc::placeweaponon(self.weapon, "right");

  if(isDefined(self.oldgrenadeweapon)) {
    self.grenadeweapon = self.oldgrenadeweapon;
    self.oldgrenadeweapon = undefined;
  }
}

islowthrowsafe() {
  var_0 = (self.origin[0], self.origin[1], self.origin[2] + 20);
  var_1 = var_0 + anglesToForward(self.angles) * 50;
  return sighttracepassed(var_0, var_1, 0, undefined);
}

choosegrenadereturnthrowanim(var_0, var_1, var_2) {
  var_3 = undefined;
  var_4 = 1000;

  if(isDefined(self.enemy))
    var_4 = distance(self.origin, self.enemy.origin);

  var_5 = [];

  if(var_4 < 600 && islowthrowsafe()) {
    if(var_4 < 300)
      return scripts\asm\asm::asm_lookupanimfromalias(var_1, "throw_short");
    else
      return scripts\asm\asm::asm_lookupanimfromalias(var_1, "throw_long");
  }

  return scripts\asm\asm::asm_lookupanimfromalias(var_1, "throw_default");
}

playgrenadeavoidanim(var_0, var_1, var_2) {
  self.asm.bshouldattemptdive = randomint(100) > 50;
}

shouldgrenadedive(var_0, var_1, var_2, var_3) {
  if(!self.asm.bshouldattemptdive)
    return 0;

  if(self.currentpose != "stand")
    return 0;

  if(!isDefined(self.grenade))
    return 0;

  var_4 = 0;
  var_4 = angleclamp180(vectortoangles(self.grenade.origin - self.origin)[1] - self.angles[1]);

  if(abs(var_4) < 90 && var_3 == "backward")
    return 0;

  var_5 = scripts\asm\asm::asm_getanim(var_0, var_2);
  var_6 = scripts\asm\asm::asm_getxanim(var_2, var_5);
  var_7 = getmovedelta(var_6, 0, 0.5);
  var_8 = self localtoworldcoords(var_7);

  if(!self maymovetopoint(var_8))
    return 0;

  return 1;
}

grenadeavoid_terminate(var_0, var_1, var_2) {
  self.asm.bshouldattemptdive = undefined;
}