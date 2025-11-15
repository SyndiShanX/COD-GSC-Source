/************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: SP\3906.gsc
************************/

func_D4DA() {
  if(!isDefined(self.a.var_BF8C)) {
    self.a.var_BF8C = 0;
  }

  if((isDefined(self.isnodeoccupied) && isplayer(self.isnodeoccupied)) || randomint(3) == 0) {
    if(gettime() > self.a.var_BF8C) {
      scripts\anim\face::saygenericdialogue("meleecharge");
      self.a.var_BF8C = gettime() + 8000;
    }
  }
}

func_D4D8() {
  if(!isDefined(self.a.var_BF8B)) {
    self.a.var_BF8B = 0;
  }

  if((isDefined(self.isnodeoccupied) && isplayer(self.isnodeoccupied)) || randomint(3) == 0) {
    if(gettime() > self.a.var_BF8B) {
      scripts\anim\face::saygenericdialogue("meleeattack");
      self.a.var_BF8B = gettime() + 8000;
    }
  }
}

func_D4D9(param_00, param_01, param_02, param_03) {
  func_D4DA();
  lib_0A1E::func_235F(param_00, param_01, param_02, self.moveplaybackrate);
}

func_D4CC(param_00, param_01, param_02, param_03) {
  self endon(param_01 + "_finished");
  var_04 = lib_0A1E::asm_getallanimsforstate(param_00, param_01);
  self clearanim(lib_0A1E::asm_getbodyknob(), param_02);
  self _meth_82EA(param_01, var_04, 1, param_02, 1);
  lib_0A1E::func_2369(param_00, param_01, var_04);
  thread lib_0C64::func_D4CD(param_01);
  lib_0A1E::func_231F(param_00, param_01);
}

func_D4D7(param_00, param_01, param_02, param_03) {
  func_D4D8();
  var_04 = scripts\asm\asm_bb::bb_getmeleetarget();
  if(!isDefined(var_04)) {
    self orientmode("face current");
  } else if(var_04 == self.isnodeoccupied) {
    self orientmode("face enemy");
  } else {
    self orientmode("face point", var_04.origin);
  }

  var_05 = lib_0A1E::asm_getallanimsforstate(param_00, param_01);
  scripts\asm\asm::asm_fireephemeralevent("melee_attack", "begin");
  self clearanim(lib_0A1E::asm_getbodyknob(), param_02);
  if(isDefined(param_03)) {
    self playSound(param_03);
  }

  self _meth_82EA(param_01, var_05, 1, param_02, 1);
  self endon(param_01 + "_finished");
  lib_0C64::donotetracks_vsplayer(param_00, param_01);
  scripts\asm\asm::asm_fireevent(param_01, "end");
}

func_B5CB(param_00, param_01) {
  self.var_B647 = param_00;
  self.melee.var_9904 = 1;
  self.melee.var_394 = self.var_394;
  self.melee.var_13CCC = scripts\anim\utility::func_7E52();
  self.melee.var_71D3 = ::func_B5D2;
  if(param_01) {
    scripts\aitypes\melee::func_B5B4(self.unittype);
    self.physics_setgravityragdollscalar = self.melee.target;
  } else {
    self.physics_setgravityragdollscalar = self.melee.partner;
  }

  if(self.unittype == "c6") {
    self.var_87F6 = 0;
    self.ignoreme = 1;
  }
}

func_D4D1(param_00, param_01, param_02, param_03) {
  self.melee.var_312F = 1;
  var_04 = self.melee.target;
  var_05 = self[[self.var_7191]](param_00, param_01);
  scripts\asm\asm::asm_fireephemeralevent("melee_attack", "begin");
  func_B5CB(param_01, 1);
  var_06 = getnotetracktimes(var_05, "melee_stop");
  if(var_06.size > 0) {
    self.melee.var_11095 = var_06;
  }

  thread lib_0C64::func_B5D7(param_01);
  var_07 = [self];
  var_04 scripts\asm\asm::asm_setstate(param_01 + "_victim", var_07);
  self animmode("zonly_physics");
  self orientmode("face angle", self.melee.var_10D6D[1]);
  self clearanim(lib_0A1E::asm_getbodyknob(), param_02);
  self _meth_82EA(param_01, var_05, 1, param_02, 1);
  lib_0A1E::func_2369(param_00, param_01, var_05);
  thread lib_0C64::func_D4D6(param_01);
  self endon(param_01 + "_finished");
  var_08 = lib_0A1E::func_231F(param_00, param_01, ::lib_0C64::func_B590);
  if((var_08 == "melee_death" || !self.melee.var_13D8A) && !isDefined(self.melee.var_112E2)) {
    self.a.nodeath = 0;
    if(isDefined(self.melee.target) && isDefined(self.melee.target.melee)) {
      self.melee.target.melee.var_2BE6 = 1;
    }

    self _meth_81D0();
  }
}

func_D4D5(param_00, param_01, param_02, param_03) {
  self endon(param_01 + "_finished");
  self.melee.var_312F = 1;
  self animmode("zonly_physics");
  if(isDefined(self.melee.var_10E0E)) {
    self orientmode("face angle", self.melee.var_10E0E);
  } else if(isDefined(self.melee.var_10D6D)) {
    self orientmode("face angle", self.melee.var_10D6D[1]);
  } else {
    self orientmode("face current");
  }

  func_B5CB(param_01, 0);
  thread lib_0C64::func_B5D7(param_01);
  var_04 = self[[self.var_7191]](param_00, param_01);
  self clearanim(lib_0A1E::asm_getbodyknob(), param_02);
  self _meth_82EA(param_01, var_04, 1, param_02, 1);
  lib_0A1E::func_2369(param_00, param_01, var_04);
  var_05 = getnotetracktimes(var_04, "melee_stop");
  if(var_05.size > 0) {
    self.melee.var_11095 = var_05;
  }

  var_06 = getnotetracktimes(var_04, "melee_interact");
  if(var_06.size > 0) {
    self.melee.var_9A53 = var_06;
  }

  var_07 = getnotetracktimes(var_04, "drop");
  if(var_07.size > 0) {
    self.melee.var_9A08 = var_07;
  }

  thread lib_0C64::func_D4D6(param_01);
  var_08 = lib_0A1E::func_231F(param_00, param_01, ::lib_0C64::func_B590);
  if((var_08 == "melee_death" || !self.melee.var_13D8A) && !isDefined(self.melee.var_112E2)) {
    self.a.nodeath = 0;
    if(isDefined(self.melee.partner) && isDefined(self.melee.partner.melee)) {
      self.melee.partner.melee.var_2BE6 = 1;
    }

    self _meth_81D0();
  }
}

func_D4D4(param_00, param_01, param_02, param_03) {
  lib_0F3D::func_444B(param_01);
  var_04 = self[[self.var_7191]](param_00, param_01);
  self clearanim(lib_0A1E::asm_getbodyknob(), param_02);
  self _meth_82EA(param_01, var_04, 1, param_02, 1);
  lib_0A1E::func_2369(param_00, param_01, var_04);
  lib_0A1E::func_231F(param_00, param_01, ::lib_0C64::func_B590);
}

func_D4D3(param_00, param_01, param_02) {
  if(isDefined(self.melee) && isDefined(self.melee.partner)) {
    self.melee.partner notify("melee_exit");
  }

  if(isalive(self) && isDefined(self.melee)) {
    func_B585();
  }

  self unlink();
  if(self.unittype == "c6") {
    self.var_87F6 = 1;
    self.ignoreme = 0;
  }

  lib_0C64::func_B58E();
}

func_B585() {
  if(self.var_394 != "none" && self.lastweapon != "none") {
    return;
  }

  if(!isDefined(self.melee.var_394) || self.melee.var_394 == "none") {
    return;
  }

  scripts\sp\utility::func_72EC(self.melee.var_394, self.melee.var_13CCC);
  if(isDefined(self.melee.var_5D3E)) {
    self.melee.var_5D3E delete();
    self.melee.var_5D3E = undefined;
  }
}

func_B5D2() {
  self unlink();
  if(isDefined(self.melee.partner)) {
    self.melee.partner animmode("zonly_physics");
    self.melee.partner orientmode("face angle", self.melee.partner.angles[1]);
  }

  self animmode("zonly_physics");
  self orientmode("face angle", self.angles[1]);
}

func_D4CA(param_00, param_01, param_02, param_03) {
  self unlink();
  lib_0A1E::func_2364(param_00, param_01, param_02);
}