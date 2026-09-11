/****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\asm\soldier\grenade_response.gsc
****************************************************/

function playgrenadereturnthrowanim(var0, var1, var2) {
  self endon(var1 + "_finished");
  var3 = scripts\asm\asm::asm_getanim(var0, var1);
  var4 = scripts\asm\asm::asm_getxanim(var1, var3);
  self animmode("zonly_physics");

  if(isDefined(self.grenade) && distancesquared(self.grenade.origin, self.origin) > 36) {
    self orientmode("face angle", vectortoyaw(self.grenade.origin - self.origin));
  }

  self aisetanim(var1, var3);
  var5 = animhasnotetrack(var4, "grenade_left");
  var6 = animhasnotetrack(var4, "grenade_right");
  var7 = var5 || var6;

  if(var7) {
    scripts\anim\shared::placeweaponon(self.weapon, "left");
    thread scripts\asm\asm::asm_donotetracks(var0, var1);

    if(var5) {
      self waittillmatch(var1, "grenade_left");
    } else {
      self waittillmatch(var1, "grenade_right");
    }

    self pickupgrenade();
    scripts\anim\battlechatter_wrapper::evaluateattackevent("frag");
    var8 = self getgrenadetossvel();

    if(isDefined(var8)) {
      var9 = vectortoyaw(var8);
      self orientmode("face angle", var9);
    }

    self waittillmatch(var1, "grenade_throw");
  } else {
    thread scripts\asm\asm::asm_donotetracks(var0, var1);
    self waittillmatch(var1, "grenade_throw");
    self pickupgrenade();
    scripts\anim\battlechatter_wrapper::evaluateattackevent("frag");
  }

  if(isDefined(self.grenade)) {
    self throwgrenade();
  }

  wait 1;
  self notify("killanimscript");
}

function terminategrenadereturnthrowanim(var0, var1, var2) {
  scripts\asm\asm::asm_fireephemeralevent("grenade_response", "return throw complete");
  scripts\anim\shared::placeweaponon(self.weapon, "right");

  if(isDefined(self.oldgrenadeweapon)) {
    self.grenadeweapon = self.oldgrenadeweapon;
    self.oldgrenadeweapon = undefined;
    return;
  }
}

function islowthrowsafe() {
  var0 = (self.origin[0], self.origin[1], self.origin[2] + 20);
  var1 = var0 + anglesToForward(self.angles) * 50;
  return sighttracepassed(var0, var1, 0, undefined);
}

function choosegrenadereturnthrowanim(var0, var1, var2) {
  var3 = undefined;
  var4 = 1000;

  if(isDefined(self.enemy)) {
    var4 = distance(self.origin, self.enemy.origin);
  }

  var5 = [];

  if(var4 < 600 && islowthrowsafe()) {
    if(var4 < 300) {
      return scripts\asm\asm::asm_lookupanimfromalias(var1, "throw_short");
    } else {
      return scripts\asm\asm::asm_lookupanimfromalias(var1, "throw_long");
    }
  }

  return scripts\asm\asm::asm_lookupanimfromalias(var1, "throw_default");
}

function playgrenadeavoidanim(var0, var1, var2) {
  self.asm.bshouldattemptdive = randomint(100) > 50;
}

function shouldgrenadedive(var0, var1, var2, var3) {
  if(!self.asm.bshouldattemptdive) {
    return false;
  }

  if(self.currentpose != "stand") {
    return false;
  }

  if(!isDefined(self.grenade)) {
    return false;
  }

  var4 = 0;
  var4 = angleclamp180(vectortoangles(self.grenade.origin - self.origin)[1] - self.angles[1]);

  if(abs(var4) < 90 && var3 == "backward") {
    return false;
  }

  var5 = scripts\asm\asm::asm_getanim(var0, var2);
  var6 = scripts\asm\asm::asm_getxanim(var2, var5);
  var7 = getmovedelta(var6, 0, 0.5);
  var8 = self localtoworldcoords(var7);

  if(!self maymovetopoint(var8)) {
    return false;
  }

  return true;
}

function grenadeavoid_terminate(var0, var1, var2) {
  self.asm.bshouldattemptdive = undefined;
}