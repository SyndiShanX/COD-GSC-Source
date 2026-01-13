/************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: 3169.gsc
************************/

func_D490(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  var_4 = lib_0A1E::asm_getallanimsforstate(var_0, var_1);
  self clearanim(lib_0A1E::asm_getbodyknob(), var_2);
  self animmode("zonly_physics");
  if(isDefined(self.objective_position) && distancesquared(self.objective_position.origin, self.origin) > 36) {
    self orientmode("face angle", vectortoyaw(self.objective_position.origin - self.origin));
  }

  self _meth_82EA(var_1, var_4, 1, var_2, 1);
  var_5 = animhasnotetrack(var_4, "grenade_left");
  var_6 = animhasnotetrack(var_4, "grenade_right");
  var_7 = var_5 || var_6;
  if(var_7) {
    scripts\anim\shared::placeweaponon(self.var_394, "left");
    thread lib_0A1E::func_231F(var_0, var_1);
    if(var_5) {
      self waittillmatch("grenade_left", var_1);
    } else {
      self waittillmatch("grenade_right", var_1);
    }

    self _meth_8228();
    scripts\anim\battlechatter_ai::func_67CF("frag");
    var_8 = self _meth_84F3();
    if(isDefined(var_8)) {
      var_9 = vectortoyaw(var_8);
      self orientmode("face angle", var_9);
    }

    self waittillmatch("grenade_throw", var_1);
  } else {
    thread lib_0A1E::func_231F(var_0, var_1);
    self waittillmatch("grenade_throw", var_1);
    self _meth_8228();
    scripts\anim\battlechatter_ai::func_67CF("frag");
  }

  if(isDefined(self.objective_position)) {
    self _meth_83C2();
  }

  wait(1);
  self notify("killanimscript");
}

func_116F6(var_0, var_1, var_2) {
  scripts\asm\asm::asm_fireephemeralevent("grenade response", "return throw complete");
  scripts\anim\shared::placeweaponon(self.var_394, "right");
  if(isDefined(self.var_C3F2)) {
    self.objective_team = self.var_C3F2;
    self.var_C3F2 = undefined;
  }
}

func_9E8C() {
  var_0 = (self.origin[0], self.origin[1], self.origin[2] + 20);
  var_1 = var_0 + anglesToForward(self.angles) * 50;
  return sighttracepassed(var_0, var_1, 0, undefined);
}

func_3EDB(var_0, var_1, var_2) {
  var_3 = undefined;
  var_4 = 1000;
  if(isDefined(self.isnodeoccupied)) {
    var_4 = distance(self.origin, self.isnodeoccupied.origin);
  }

  var_5 = [];
  if(var_4 < 600 && func_9E8C()) {
    if(var_4 < 300) {
      return scripts\asm\asm::asm_lookupanimfromalias(var_1, "throw_short");
    } else {
      return scripts\asm\asm::asm_lookupanimfromalias(var_1, "throw_long");
    }
  }

  return scripts\asm\asm::asm_lookupanimfromalias(var_1, "throw_default");
}

func_D48F(var_0, var_1, var_2, var_3) {
  self.asm.var_312B = randomint(100) > 50;
}

func_1001F(var_0, var_1, var_2, var_3) {
  if(!self.asm.var_312B) {
    return 0;
  }

  if(self.a.pose != "stand") {
    return 0;
  }

  if(!isDefined(self.objective_position)) {
    return 0;
  }

  var_4 = 0;
  var_4 = angleclamp180(vectortoangles(self.objective_position.origin - self.origin)[1] - self.angles[1]);
  if(abs(var_4) < 90 && var_3 == "backward") {
    return 0;
  }

  var_5 = lib_0A1E::asm_getallanimsforstate(var_0, var_2);
  var_6 = getmovedelta(var_5, 0, 0.5);
  var_7 = self gettweakablevalue(var_6);
  if(!self maymovetopoint(var_7)) {
    return 0;
  }

  return 1;
}

_meth_85B1(var_0, var_1, var_2) {
  self.asm.var_312B = undefined;
}