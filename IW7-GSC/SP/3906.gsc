/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: SP\3906.gsc
*********************************************/

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

func_D4D9(var_0, var_1, var_2, var_3) {
  func_D4DA();
  lib_0A1E::func_235F(var_0, var_1, var_2, self.moveplaybackrate);
}

func_D4CC(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  var_4 = lib_0A1E::asm_getallanimsforstate(var_0, var_1);
  self clearanim(lib_0A1E::asm_getbodyknob(), var_2);
  self func_82EA(var_1, var_4, 1, var_2, 1);
  lib_0A1E::func_2369(var_0, var_1, var_4);
  thread lib_0C64::func_D4CD(var_1);
  lib_0A1E::func_231F(var_0, var_1);
}

func_D4D7(var_0, var_1, var_2, var_3) {
  func_D4D8();
  var_4 = scripts\asm\asm_bb::bb_getmeleetarget();
  if(!isDefined(var_4)) {
    self orientmode("face current");
  } else if(var_4 == self.isnodeoccupied) {
    self orientmode("face enemy");
  } else {
    self orientmode("face point", var_4.origin);
  }

  var_5 = lib_0A1E::asm_getallanimsforstate(var_0, var_1);
  scripts\asm\asm::asm_fireephemeralevent("melee_attack", "begin");
  self clearanim(lib_0A1E::asm_getbodyknob(), var_2);
  if(isDefined(var_3)) {
    self playSound(var_3);
  }

  self func_82EA(var_1, var_5, 1, var_2, 1);
  self endon(var_1 + "_finished");
  lib_0C64::donotetracks_vsplayer(var_0, var_1);
  scripts\asm\asm::asm_fireevent(var_1, "end");
}

func_B5CB(var_0, var_1) {
  self.var_B647 = var_0;
  self.melee.var_9904 = 1;
  self.melee.var_394 = self.var_394;
  self.melee.var_13CCC = scripts\anim\utility::func_7E52();
  self.melee.var_71D3 = ::func_B5D2;
  if(var_1) {
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

func_D4D1(var_0, var_1, var_2, var_3) {
  self.melee.var_312F = 1;
  var_4 = self.melee.target;
  var_5 = self[[self.var_7191]](var_0, var_1);
  scripts\asm\asm::asm_fireephemeralevent("melee_attack", "begin");
  func_B5CB(var_1, 1);
  var_6 = getnotetracktimes(var_5, "melee_stop");
  if(var_6.size > 0) {
    self.melee.var_11095 = var_6;
  }

  thread lib_0C64::func_B5D7(var_1);
  var_7 = [self];
  var_4 scripts\asm\asm::asm_setstate(var_1 + "_victim", var_7);
  self animmode("zonly_physics");
  self orientmode("face angle", self.melee.var_10D6D[1]);
  self clearanim(lib_0A1E::asm_getbodyknob(), var_2);
  self func_82EA(var_1, var_5, 1, var_2, 1);
  lib_0A1E::func_2369(var_0, var_1, var_5);
  thread lib_0C64::func_D4D6(var_1);
  self endon(var_1 + "_finished");
  var_8 = lib_0A1E::func_231F(var_0, var_1, lib_0C64::func_B590);
  if((var_8 == "melee_death" || !self.melee.var_13D8A) && !isDefined(self.melee.var_112E2)) {
    self.a.nodeath = 0;
    if(isDefined(self.melee.target) && isDefined(self.melee.target.melee)) {
      self.melee.target.melee.var_2BE6 = 1;
    }

    self func_81D0();
  }
}

func_D4D5(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  self.melee.var_312F = 1;
  self animmode("zonly_physics");
  if(isDefined(self.melee.var_10E0E)) {
    self orientmode("face angle", self.melee.var_10E0E);
  } else if(isDefined(self.melee.var_10D6D)) {
    self orientmode("face angle", self.melee.var_10D6D[1]);
  } else {
    self orientmode("face current");
  }

  func_B5CB(var_1, 0);
  thread lib_0C64::func_B5D7(var_1);
  var_4 = self[[self.var_7191]](var_0, var_1);
  self clearanim(lib_0A1E::asm_getbodyknob(), var_2);
  self func_82EA(var_1, var_4, 1, var_2, 1);
  lib_0A1E::func_2369(var_0, var_1, var_4);
  var_5 = getnotetracktimes(var_4, "melee_stop");
  if(var_5.size > 0) {
    self.melee.var_11095 = var_5;
  }

  var_6 = getnotetracktimes(var_4, "melee_interact");
  if(var_6.size > 0) {
    self.melee.var_9A53 = var_6;
  }

  var_7 = getnotetracktimes(var_4, "drop");
  if(var_7.size > 0) {
    self.melee.var_9A08 = var_7;
  }

  thread lib_0C64::func_D4D6(var_1);
  var_8 = lib_0A1E::func_231F(var_0, var_1, lib_0C64::func_B590);
  if((var_8 == "melee_death" || !self.melee.var_13D8A) && !isDefined(self.melee.var_112E2)) {
    self.a.nodeath = 0;
    if(isDefined(self.melee.partner) && isDefined(self.melee.partner.melee)) {
      self.melee.partner.melee.var_2BE6 = 1;
    }

    self func_81D0();
  }
}

func_D4D4(var_0, var_1, var_2, var_3) {
  lib_0F3D::func_444B(var_1);
  var_4 = self[[self.var_7191]](var_0, var_1);
  self clearanim(lib_0A1E::asm_getbodyknob(), var_2);
  self func_82EA(var_1, var_4, 1, var_2, 1);
  lib_0A1E::func_2369(var_0, var_1, var_4);
  lib_0A1E::func_231F(var_0, var_1, lib_0C64::func_B590);
}

func_D4D3(var_0, var_1, var_2) {
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

func_D4CA(var_0, var_1, var_2, var_3) {
  self unlink();
  lib_0A1E::func_2364(var_0, var_1, var_2);
}