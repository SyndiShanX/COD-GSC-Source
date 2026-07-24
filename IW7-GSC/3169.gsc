/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3169.gsc
**************************************/

_id_D490(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  var_4 = _id_0A1E::asm_getallanimsforstate(var_0, var_1);
  self clearanim(_id_0A1E::asm_getbodyknob(), var_2);
  self animmode("zonly_physics");

  if(isDefined(self.grenade) && distancesquared(self.grenade.origin, self.origin) > 36) {
    self orientmode("face angle", vectortoyaw(self.grenade.origin - self.origin));
  }

  self _meth_82EA(var_1, var_4, 1.0, var_2, 1.0);
  var_5 = animhasnotetrack(var_4, "grenade_left");
  var_6 = animhasnotetrack(var_4, "grenade_right");
  var_7 = var_5 || var_6;

  if(var_7) {
    scripts\anim\shared::placeweaponon(self.weapon, "left");
    thread _id_0A1E::_id_231F(var_0, var_1);

    if(var_5) {
      self waittillmatch(var_1, "grenade_left");
    } else {
      self waittillmatch(var_1, "grenade_right");
    }

    self _meth_8228();
    scripts\anim\battlechatter_ai::_id_67CF("frag");
    var_8 = self _meth_84F3();

    if(isDefined(var_8)) {
      var_9 = vectortoyaw(var_8);
      self orientmode("face angle", var_9);
    }

    self waittillmatch(var_1, "grenade_throw");
  } else {
    thread _id_0A1E::_id_231F(var_0, var_1);
    self waittillmatch(var_1, "grenade_throw");
    self _meth_8228();
    scripts\anim\battlechatter_ai::_id_67CF("frag");
  }

  if(isDefined(self.grenade)) {
    self _meth_83C2();
  }

  wait 1;
  self notify("killanimscript");
}

_id_116F6(var_0, var_1, var_2) {
  scripts\asm\asm::asm_fireephemeralevent("grenade response", "return throw complete");
  scripts\anim\shared::placeweaponon(self.weapon, "right");

  if(isDefined(self._id_C3F2)) {
    self.grenadeweapon = self._id_C3F2;
    self._id_C3F2 = undefined;
  }
}

_id_9E8C() {
  var_0 = (self.origin[0], self.origin[1], self.origin[2] + 20);
  var_1 = var_0 + anglesToForward(self.angles) * 50;
  return sighttracepassed(var_0, var_1, 0, undefined);
}

_id_3EDB(var_0, var_1, var_2) {
  var_3 = undefined;
  var_4 = 1000;

  if(isDefined(self.enemy)) {
    var_4 = distance(self.origin, self.enemy.origin);
  }

  var_5 = [];

  if(var_4 < 600 && _id_9E8C()) {
    if(var_4 < 300) {
      return scripts\asm\asm::asm_lookupanimfromalias(var_1, "throw_short");
    } else {
      return scripts\asm\asm::asm_lookupanimfromalias(var_1, "throw_long");
    }
  }

  return scripts\asm\asm::asm_lookupanimfromalias(var_1, "throw_default");
}

_id_D48F(var_0, var_1, var_2, var_3) {
  self.asm._id_312B = randomint(100) > 50;
}

_id_1001F(var_0, var_1, var_2, var_3) {
  if(!self.asm._id_312B) {
    return 0;
  }

  if(self.a.pose != "stand") {
    return 0;
  }

  if(!isDefined(self.grenade)) {
    return 0;
  }

  var_4 = 0;
  var_4 = angleclamp180(vectortoangles(self.grenade.origin - self.origin)[1] - self.angles[1]);

  if(abs(var_4) < 90 && var_3 == "backward") {
    return 0;
  }

  var_5 = _id_0A1E::asm_getallanimsforstate(var_0, var_2);
  var_6 = getmovedelta(var_5, 0, 0.5);
  var_7 = self localtoworldcoords(var_6);

  if(!self maymovetopoint(var_7)) {
    return 0;
  }

  return 1;
}

_id_85B1(var_0, var_1, var_2) {
  self.asm._id_312B = undefined;
}