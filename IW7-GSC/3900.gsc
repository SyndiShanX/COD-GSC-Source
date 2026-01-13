/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: 3900.gsc
*********************************************/

func_5AC0() {
  self endon("killanimscript");
  var_0 = self getspectatepoint();
  var_1 = var_0.var_48;
  self notify("traverse_begin", var_1, var_0);
  self waittill("traverse_end");
}

func_3E96(var_0, var_1, var_2) {
  if(!isDefined(var_2)) {
    return func_3EF4(var_0, var_1, var_2);
  }

  return scripts\asm\asm::asm_lookupanimfromalias(var_1, var_2);
}

func_3EB8(var_0, var_1, var_2) {
  return 0;
}

func_3EF4(var_0, var_1, var_2) {
  var_3 = self getanimentrycount(var_1);
  if(var_3 == 1) {
    return 0;
  }

  return randomint(var_3);
}

func_3EB6(var_0, var_1, var_2) {
  return func_3E96(var_0, var_1, var_2);
}

func_CEA8(var_0, var_1, var_2, var_3) {
  scripts\asm\asm_mp::func_2364(var_0, var_1, var_2, var_3);
}

func_B050(var_0, var_1, var_2, var_3) {
  scripts\asm\asm_mp::func_235F(var_0, var_1, var_2, 1);
}

func_136B4(var_0, var_1, var_2) {
  self endon(var_1 + "_finished");
  self _meth_84BD();
  self waittill("stop_soon");
  self.var_20EE = self _meth_813A();
  scripts\asm\asm::asm_fireevent(var_1, "cover_approach", self.var_20EE);
}

func_136CC(var_0, var_1, var_2) {
  self endon(var_1 + "_finished");
  self waittill("path_set");
  var_3 = self _meth_813A();
  var_4 = [var_3, 1];
  scripts\asm\asm::asm_fireevent(var_1, "sharp_turn", var_4);
  thread func_136CC(var_0, var_1, var_2);
}

func_136E7(var_0, var_1, var_2) {
  self endon(var_1 + "_finished");
  self waittill("path_dir_change", var_3);
  var_4 = [var_3, 1];
  scripts\asm\asm::asm_fireevent(var_1, "sharp_turn", var_4);
  thread func_136E7(var_0, var_1, var_2);
}

func_D4DD(var_0, var_1, var_2, var_3) {
  thread func_136B4(var_0, var_1, var_3);
  thread func_136E7(var_0, var_1, var_3);
  thread func_136CC(var_0, var_1, var_3);
  var_4 = 1;
  if(isDefined(self.asm.moveplaybackrate)) {
    var_4 = self.asm.moveplaybackrate;
  } else if(isDefined(self.moveplaybackrate)) {
    var_4 = self.moveplaybackrate;
  }

  scripts\asm\asm_mp::func_235F(var_0, var_1, var_2, var_4);
}

func_FFB6(var_0, var_1, var_2, var_3) {
  if(!func_100A3(var_0, var_1, var_2, var_3)) {
    return 1;
  }

  if(!scripts\asm\asm_bb::bb_movetyperequested("combat")) {
    return 1;
  }

  if(scripts\asm\asm_bb::bb_meleechargerequested(var_0, var_1, var_2, var_3)) {
    return 1;
  }

  return 0;
}

func_100A3(var_0, var_1, var_2, var_3) {
  if(isDefined(var_3)) {
    if(!scripts\asm\asm_bb::func_2949(var_0, var_1, var_2, var_3)) {
      return 0;
    }
  }

  if(self._blackboard.alwaysrunforward) {
    return 0;
  }

  if(!scripts\asm\asm_bb::bb_movetyperequested("combat")) {
    return 0;
  }

  if(!scripts\asm\asm_bb::bb_wantstostrafe()) {
    return 0;
  }

  if(!isDefined(self.isnodeoccupied)) {
    if(!isDefined(self.var_6571)) {
      return 0;
    }
  }

  return 1;
}

isfacingenemy(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 0.5;
  }

  var_1 = anglesToForward(self.angles);
  var_2 = vectornormalize(self.isnodeoccupied.origin - self.origin);
  var_3 = vectordot(var_1, var_2);
  if(var_3 < var_0) {
    return 0;
  }

  return 1;
}

func_9FFF() {
  if(isaimedataimtarget()) {
    return 1;
  }

  return 0;
}

shouldshoot(var_0, var_1, var_2, var_3) {
  if(!scripts\asm\asm_bb::func_291C()) {
    return 0;
  }

  if(isDefined(self.isnodeoccupied)) {
    if(!isfacingenemy() && !func_9FFF()) {
      return 0;
    }

    if(!self getpersstat(self.isnodeoccupied)) {
      return 0;
    }
  }

  return 1;
}

func_3EB3(var_0, var_1, var_2) {
  var_3 = scripts\asm\asm::asm_getdemeanor();
  if(scripts\asm\asm::asm_hasdemeanoranimoverride(var_3, "idle")) {
    var_4 = scripts\asm\asm::asm_getdemeanoranimoverride(var_3, "idle");
    if(isarray(var_4)) {
      return var_4[randomint(var_4.size)];
    }

    return var_4;
  }

  return func_3EAB(var_1, var_2, var_3);
}

func_3EAB(var_0, var_1, var_2) {
  if(isDefined(self.var_394)) {
    var_3 = weaponclass(self.var_394);
  } else {
    var_3 = "none";
  }

  if(!scripts\asm\asm::asm_hasalias(var_1, var_3 + var_2)) {
    var_3 = "rifle";
  }

  return scripts\asm\asm::asm_lookupanimfromalias(var_1, var_3 + var_2);
}

func_138E2() {
  if(scripts\asm\asm_bb::func_292C() == "crouch") {
    return 1;
  }

  return 0;
}

_meth_811E(var_0) {
  if(!isDefined(self._blackboard.shootparams)) {
    return undefined;
  } else if(isDefined(self._blackboard.shootparams.ent)) {
    return self._blackboard.shootparams.ent getshootatpos();
  } else if(isDefined(self._blackboard.shootparams.pos)) {
    return self._blackboard.shootparams.pos;
  } else if(isDefined(self.isnodeoccupied)) {
    return self.isnodeoccupied getshootatpos();
  }

  return undefined;
}

_meth_811C() {
  if(isDefined(self.var_130A9)) {
    var_0 = self getspawnteam();
    return (var_0[0], var_0[1], self getEye()[2]);
  }

  return (self.origin[0], self.origin[1], self getEye()[2]);
}

isaimedataimtarget() {
  if(!isDefined(self._blackboard.shootparams.pos) && !isDefined(self._blackboard.shootparams.ent)) {
    return 1;
  }

  var_0 = self getspawnpointdist();
  var_1 = _meth_811C();
  var_2 = _meth_811E(var_1);
  if(!isDefined(var_2)) {
    return 0;
  }

  var_3 = vectortoangles(var_2 - var_1);
  var_4 = scripts\engine\utility::absangleclamp180(var_0[1] - var_3[1]);
  if(var_4 > level.var_1A52) {
    if(distancesquared(self getEye(), var_2) > level.var_1A50 || var_4 > level.var_1A51) {}
  }

  var_5 = func_7DA3();
  return scripts\engine\utility::absangleclamp180(var_0[0] - var_3[0]) <= var_5;
}

func_7DA3() {
  if(isDefined(self.var_1A44)) {
    return self.var_1A44;
  }

  return level.var_1A44;
}

func_CEC0(var_0, var_1, var_2) {}

func_CEC1(var_0, var_1, var_2) {}