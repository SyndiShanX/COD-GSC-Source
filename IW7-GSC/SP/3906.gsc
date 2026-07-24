/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3906.gsc
**************************************/

_id_D4DA() {
  if(!isDefined(self.a._id_BF8C)) {
    self.a._id_BF8C = 0;
  }

  if(isDefined(self.enemy) && isPlayer(self.enemy) || randomint(3) == 0) {
    if(gettime() > self.a._id_BF8C) {
      scripts\anim\face::saygenericdialogue("meleecharge");
      self.a._id_BF8C = gettime() + 8000;
    }
  }
}

_id_D4D8() {
  if(!isDefined(self.a._id_BF8B)) {
    self.a._id_BF8B = 0;
  }

  if(isDefined(self.enemy) && isPlayer(self.enemy) || randomint(3) == 0) {
    if(gettime() > self.a._id_BF8B) {
      scripts\anim\face::saygenericdialogue("meleeattack");
      self.a._id_BF8B = gettime() + 8000;
    }
  }
}

_id_D4D9(var_0, var_1, var_2, var_3) {
  _id_D4DA();
  _id_0A1E::_id_235F(var_0, var_1, var_2, self.moveplaybackrate);
}

_id_D4CC(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  var_4 = _id_0A1E::asm_getallanimsforstate(var_0, var_1);
  self clearanim(_id_0A1E::asm_getbodyknob(), var_2);
  self _meth_82EA(var_1, var_4, 1, var_2, 1);
  _id_0A1E::_id_2369(var_0, var_1, var_4);
  thread _id_0C64::_id_D4CD(var_1);
  _id_0A1E::_id_231F(var_0, var_1);
}

_id_D4D7(var_0, var_1, var_2, var_3) {
  _id_D4D8();
  var_4 = scripts\asm\asm_bb::bb_getmeleetarget();

  if(!isDefined(var_4)) {
    self orientmode("face current");
  } else if(var_4 == self.enemy) {
    self orientmode("face enemy");
  } else {
    self orientmode("face point", var_4.origin);
  }

  var_5 = _id_0A1E::asm_getallanimsforstate(var_0, var_1);
  scripts\asm\asm::asm_fireephemeralevent("melee_attack", "begin");
  self clearanim(_id_0A1E::asm_getbodyknob(), var_2);

  if(isDefined(var_3)) {
    self playSound(var_3);
  }

  self _meth_82EA(var_1, var_5, 1.0, var_2, 1.0);
  self endon(var_1 + "_finished");
  _id_0C64::donotetracks_vsplayer(var_0, var_1);
  scripts\asm\asm::asm_fireevent(var_1, "end");
}

_id_B5CB(var_0, var_1) {
  self._id_B647 = var_0;
  self.melee._id_9904 = 1;
  self.melee.weapon = self.weapon;
  self.melee._id_13CCC = scripts\anim\utility::_id_7E52();
  self.melee._id_71D3 = ::_id_B5D2;

  if(var_1) {
    scripts\aitypes\melee::_id_B5B4(self.unittype);
    self.syncedmeleetarget = self.melee.target;
  } else
    self.syncedmeleetarget = self.melee.partner;

  if(self.unittype == "c6") {
    self._id_87F6 = 0;
    self.ignoreme = 1;
  }
}

_id_D4D1(var_0, var_1, var_2, var_3) {
  self.melee._id_312F = 1;
  var_4 = self.melee.target;
  var_5 = self[[self._id_7191]](var_0, var_1);
  scripts\asm\asm::asm_fireephemeralevent("melee_attack", "begin");
  _id_B5CB(var_1, 1);
  var_6 = getnotetracktimes(var_5, "melee_stop");

  if(var_6.size > 0) {
    self.melee._id_11095 = var_6;
  }

  thread _id_0C64::_id_B5D7(var_1);
  var_7 = [self];
  var_4 scripts\asm\asm::asm_setstate(var_1 + "_victim", var_7);
  self animmode("zonly_physics");
  self orientmode("face angle", self.melee._id_10D6D[1]);
  self clearanim(_id_0A1E::asm_getbodyknob(), var_2);
  self _meth_82EA(var_1, var_5, 1, var_2, 1);
  _id_0A1E::_id_2369(var_0, var_1, var_5);
  thread _id_0C64::_id_D4D6(var_1);
  self endon(var_1 + "_finished");
  var_8 = _id_0A1E::_id_231F(var_0, var_1, _id_0C64::_id_B590);

  if((var_8 == "melee_death" || !self.melee._id_13D8A) && !isDefined(self.melee._id_112E2)) {
    self.a.nodeath = 0;

    if(isDefined(self.melee.target) && isDefined(self.melee.target.melee)) {
      self.melee.target.melee._id_2BE6 = 1;
    }

    self _meth_81D0();
  }
}

_id_D4D5(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  self.melee._id_312F = 1;
  self animmode("zonly_physics");

  if(isDefined(self.melee._id_10E0E)) {
    self orientmode("face angle", self.melee._id_10E0E);
  } else if(isDefined(self.melee._id_10D6D)) {
    self orientmode("face angle", self.melee._id_10D6D[1]);
  } else {
    self orientmode("face current");
  }

  _id_B5CB(var_1, 0);
  thread _id_0C64::_id_B5D7(var_1);
  var_4 = self[[self._id_7191]](var_0, var_1);
  self clearanim(_id_0A1E::asm_getbodyknob(), var_2);
  self _meth_82EA(var_1, var_4, 1, var_2, 1);
  _id_0A1E::_id_2369(var_0, var_1, var_4);
  var_5 = getnotetracktimes(var_4, "melee_stop");

  if(var_5.size > 0) {
    self.melee._id_11095 = var_5;
  }

  var_6 = getnotetracktimes(var_4, "melee_interact");

  if(var_6.size > 0) {
    self.melee._id_9A53 = var_6;
  }

  var_7 = getnotetracktimes(var_4, "drop");

  if(var_7.size > 0) {
    self.melee._id_9A08 = var_7;
  }

  thread _id_0C64::_id_D4D6(var_1);
  var_8 = _id_0A1E::_id_231F(var_0, var_1, _id_0C64::_id_B590);

  if((var_8 == "melee_death" || !self.melee._id_13D8A) && !isDefined(self.melee._id_112E2)) {
    self.a.nodeath = 0;

    if(isDefined(self.melee.partner) && isDefined(self.melee.partner.melee)) {
      self.melee.partner.melee._id_2BE6 = 1;
    }

    self _meth_81D0();
  }
}

_id_D4D4(var_0, var_1, var_2, var_3) {
  _id_0F3D::_id_444B(var_1);
  var_4 = self[[self._id_7191]](var_0, var_1);
  self clearanim(_id_0A1E::asm_getbodyknob(), var_2);
  self _meth_82EA(var_1, var_4, 1, var_2, 1);
  _id_0A1E::_id_2369(var_0, var_1, var_4);
  _id_0A1E::_id_231F(var_0, var_1, _id_0C64::_id_B590);
}

_id_D4D3(var_0, var_1, var_2) {
  if(isDefined(self.melee) && isDefined(self.melee.partner)) {
    self.melee.partner notify("melee_exit");
  }

  if(isalive(self) && isDefined(self.melee)) {
    _id_B585();
  }

  self unlink();

  if(self.unittype == "c6") {
    self._id_87F6 = 1;
    self.ignoreme = 0;
  }

  _id_0C64::_id_B58E();
}

_id_B585() {
  if(self.weapon != "none" && self.lastweapon != "none") {
    return;
  }
  if(!isDefined(self.melee.weapon) || self.melee.weapon == "none") {
    return;
  }
  scripts\sp\utility::_id_72EC(self.melee.weapon, self.melee._id_13CCC);

  if(isDefined(self.melee._id_5D3E)) {
    self.melee._id_5D3E delete();
    self.melee._id_5D3E = undefined;
  }
}

_id_B5D2() {
  self unlink();

  if(isDefined(self.melee.partner)) {
    self.melee.partner animmode("zonly_physics");
    self.melee.partner orientmode("face angle", self.melee.partner.angles[1]);
  }

  self animmode("zonly_physics");
  self orientmode("face angle", self.angles[1]);
}

_id_D4CA(var_0, var_1, var_2, var_3) {
  self unlink();
  _id_0A1E::_id_2364(var_0, var_1, var_2);
}