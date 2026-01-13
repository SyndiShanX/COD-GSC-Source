/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: 3173.gsc
*********************************************/

func_CEB5(var_0, var_1, var_2, var_3) {
  var_4 = lib_0A1E::asm_getallanimsforstate(var_0, var_1);
  self.asm.var_4C86.var_697F = undefined;
  if(isDefined(self.var_28CF) && self.var_28CF) {
    var_5 = issubstr(var_1, "cover");
    func_BCF9(var_5);
  }

  if(!isDefined(var_4)) {
    scripts\asm\asm::asm_fireevent(var_1, "abort");
    scripts\asm\asm::asm_fireevent(var_1, "code_move", undefined);
    scripts\asm\asm::asm_fireevent(var_1, "end", undefined);
    scripts\asm\asm::asm_fireevent(var_1, "finish", undefined);
    return;
  }

  var_6 = 0;
  if(isDefined(var_3)) {
    var_6 = var_3;
  }

  func_D53A(var_0, var_1, var_4, var_2, var_6);
}

func_3E9F(var_0, var_1, var_2) {
  if(!func_3E57()) {
    return undefined;
  }

  var_3 = undefined;
  var_4 = 0;
  if(isarray(var_2) && isDefined(var_2[1])) {
    var_4 = var_2[1];
  }

  if(isDefined(var_2) && isarray(var_2) && isDefined(var_2[0])) {
    var_3 = func_53CA(var_1, scripts\asm\asm_bb::func_2928(var_2[0]), var_4);
  } else if(isDefined(var_2) && !isarray(var_2)) {
    var_3 = func_53CA(var_1, scripts\asm\asm_bb::func_2928(var_2), var_4);
  } else {
    var_3 = func_53CA(var_1, undefined, var_4);
  }

  return var_3;
}

_meth_8162(var_0, var_1) {
  var_2 = [];
  var_3 = "";
  if(isDefined(var_1)) {
    var_3 = var_1;
  }

  var_4 = "";
  if(isDefined(self.asm.var_13CAF) && self.asm.var_13CAF) {
    if(scripts\asm\asm::asm_hasalias(var_0, var_3 + "2_2h")) {
      var_4 = "_2h";
    }
  }

  if(scripts\asm\asm::asm_hasalias(var_0, var_3 + "1" + var_4)) {
    var_2[7] = ::scripts\asm\asm::asm_lookupanimfromalias(var_0, var_3 + "1" + var_4);
  }

  if(scripts\asm\asm::asm_hasalias(var_0, var_3 + "2" + var_4)) {
    var_2[0] = ::scripts\asm\asm::asm_lookupanimfromalias(var_0, var_3 + "2" + var_4);
    var_2[8] = var_2[0];
  }

  if(scripts\asm\asm::asm_hasalias(var_0, var_3 + "3" + var_4)) {
    var_2[1] = ::scripts\asm\asm::asm_lookupanimfromalias(var_0, var_3 + "3" + var_4);
  }

  if(scripts\asm\asm::asm_hasalias(var_0, var_3 + "4" + var_4)) {
    var_2[6] = ::scripts\asm\asm::asm_lookupanimfromalias(var_0, var_3 + "4" + var_4);
  }

  if(scripts\asm\asm::asm_hasalias(var_0, var_3 + "6" + var_4)) {
    var_2[2] = ::scripts\asm\asm::asm_lookupanimfromalias(var_0, var_3 + "6" + var_4);
  }

  if(scripts\asm\asm::asm_hasalias(var_0, var_3 + "7" + var_4)) {
    var_2[5] = ::scripts\asm\asm::asm_lookupanimfromalias(var_0, var_3 + "7" + var_4);
  }

  if(scripts\asm\asm::asm_hasalias(var_0, var_3 + "8" + var_4)) {
    var_2[4] = ::scripts\asm\asm::asm_lookupanimfromalias(var_0, var_3 + "8" + var_4);
  }

  if(scripts\asm\asm::asm_hasalias(var_0, var_3 + "9" + var_4)) {
    var_2[3] = ::scripts\asm\asm::asm_lookupanimfromalias(var_0, var_3 + "9" + var_4);
  }

  return var_2;
}

getthreatbiasgroup() {
  var_0 = scripts\asm\asm::asm_getdemeanor();
  if(var_0 == "casual" || var_0 == "casual_gun") {
    return 75;
  }

  return 100;
}

func_53CA(var_0, var_1, var_2) {
  var_3 = self getspectatepoint();
  if(isDefined(var_3)) {
    var_4 = var_3.origin;
  } else {
    var_4 = self.vehicle_getspawnerarray;
  }

  var_5 = scripts\anim\exit_node::func_7EA3();
  if(self.var_36F) {
    if(var_2) {
      var_6 = self.origin + self.setocclusionpreset * self.setomnvar;
    } else {
      var_6 = self _meth_845C(128);
    }

    var_7 = vectortoangles(var_6 - self.origin);
  } else {
    var_7 = vectortoangles(self.setocclusionpreset);
  }

  if(lib_0F3D::func_C057(var_5) && !var_2) {
    var_8 = var_5.angles;
  } else {
    var_8 = self.angles;
  }

  var_9 = angleclamp180(var_7[1] - var_8[1]);
  if(length2dsquared(self.var_381) > 16) {
    var_0A = vectortoangles(self.var_381);
    if(abs(angleclamp180(var_0A[1] - var_7[1])) < 45) {
      return;
    }
  }

  var_0B = getthreatbiasgroup();
  if(distancesquared(var_4, self.origin) < var_0B * var_0B) {
    return;
  }

  if(isDefined(self.asm.var_4C86.var_697F)) {
    var_0C = _meth_8162(self.asm.var_4C86.var_697F, var_1);
  } else {
    var_0C = _meth_8162(var_1, var_2);
  }

  var_0D = getangleindices(var_9);
  var_0E = self _meth_84AC();
  var_0F = undefined;
  var_10 = 0;
  for(var_10 = 0; var_10 < var_0D.size; var_10++) {
    var_11 = var_0D[var_10];
    if(!isDefined(var_0C[var_11])) {
      continue;
    }

    var_0F = var_0C[var_11];
    var_12 = 1;
    var_13 = getnotetracktimes(var_0F, "code_move");
    if(var_13.size > 0) {
      var_12 = var_13[0];
    }

    var_14 = getmovedelta(var_0F, 0, var_12);
    var_15 = rotatevector(var_14, self.angles) + var_0E;
    var_16 = getnotetracktimes(var_0F, "corner");
    if(var_16.size == 0) {
      var_16 = getnotetracktimes(var_0F, "exit_align");
    }

    if(var_16.size > 0) {
      var_17 = getmovedelta(var_0F, 0, var_16[0]);
      var_18 = rotatevector(var_17, self.angles) + var_0E;
      var_19 = self maymovefrompointtopoint(var_18, var_15, 1, 1);
      if(var_19) {
        break;
      }

      continue;
    }

    if(self maymovefrompointtopoint(var_0E, var_15, 1, 1)) {
      break;
    }
  }

  if(var_10 == var_0D.size) {
    return undefined;
  }

  return var_0F;
}

func_D53A(var_0, var_1, var_2, var_3, var_4) {
  self endon(var_1 + "_finished");
  if(self.var_36F) {
    var_5 = self _meth_845C(128);
    var_6 = vectortoangles(var_5 - self.origin);
  } else {
    var_6 = vectortoangles(self.setocclusionpreset);
  }

  var_7 = angleclamp180(var_6[1] - self.angles[1]);
  var_8 = getnotetracktimes(var_2, "code_move");
  var_9 = 1;
  if(var_8.size > 0) {
    thread lib_0F3D::func_136B4(var_0, var_1, undefined);
    thread lib_0F3D::func_136E7(var_0, var_1, undefined);
    var_9 = var_8[0];
  }

  var_0A = getangledelta3d(var_2, 0, var_9);
  self animmode("zonly_physics", 0);
  childthread scripts\asm\shared_utility::setuseanimgoalweight(var_1, var_3);
  thread lib_0F3D::func_444B(var_1);
  lib_0A1E::func_2369(var_0, var_1, var_2);
  if(isDefined(self.var_22EE)) {
    self _meth_82E4(var_1, var_2, lib_0A1E::asm_getbodyknob(), 1, var_3, self.moveplaybackrate * self.var_22EE);
  } else {
    self _meth_82E4(var_1, var_2, lib_0A1E::asm_getbodyknob(), 1, var_3, self.moveplaybackrate);
  }

  lib_0A1E::func_231F(var_0, var_1, ::func_899E, var_2, undefined, 1);
  if(var_4) {
    lib_0F3D::func_11065();
    self animmode("normal", 0);
    self orientmode("face motion");
    lib_0A1E::func_231F(var_0, var_1);
  }
}

func_899E(var_0, var_1) {
  if(var_0 == "exit_align" || var_0 == "corner") {
    var_2 = var_1;
    var_3 = self _meth_845C(36);
    var_4 = vectortoangles(var_3 - self.origin);
    var_5 = self getscoreinfocategory(var_2);
    var_6 = getangledelta3d(var_2, var_5, 1);
    self orientmode("face angle", angleclamp180(var_4[1] - var_6[1]));
  }
}

func_3E57() {
  if(!isDefined(self.vehicle_getspawnerarray)) {
    return 0;
  }

  if(!self givemidmatchaward()) {
    return 0;
  }

  if(self.a.pose == "prone") {
    return 0;
  }

  if(isDefined(self.var_55ED) && self.var_55ED) {
    return 0;
  }

  if(self.getcsplinepointtargetname != "none") {
    return 0;
  }

  if(!self getteleportlonertargetplayer("stand") && !isDefined(self.heat)) {
    return 0;
  }

  var_0 = 10000;
  var_1 = scripts\asm\asm::asm_getdemeanor();
  if(scripts\asm\asm::asm_getdemeanor() == "casual" || scripts\asm\asm::asm_getdemeanor() == "casual_gun") {
    var_0 = 2500;
  }

  if(distancesquared(self.origin, self.vehicle_getspawnerarray) < var_0) {
    return 0;
  }

  return 1;
}

func_3B1F(var_0, var_1, var_2, var_3) {
  var_4 = scripts\asm\asm::asm_getdemeanor();
  if(!isDefined(var_3[2]) || var_3[2] != var_4) {
    return 0;
  }

  if(!func_FFF8(var_0, var_1, var_2, var_3)) {
    return 0;
  }

  var_5 = self.a.var_FC62;
  return var_5 < 2 || var_5 > 6;
}

func_FFF8(var_0, var_1, var_2, var_3) {
  if(isDefined(self.noturnanims) && self.noturnanims) {
    return 0;
  }

  if(isDefined(self.var_932E) && self.var_932E) {
    return 0;
  }

  var_4 = self.var_164D[var_0].var_4BC0;
  var_5 = scripts\asm\asm::func_233F(var_4, "sharp_turn");
  if(!isDefined(var_5)) {
    return 0;
  }

  var_6 = 50;
  var_7 = gettime();
  if(var_7 - var_5.var_7686 > var_6) {
    return 0;
  }

  var_8 = var_5.params[1];
  var_9 = var_5.params[2];
  var_0A = 0;
  var_0B = undefined;
  if(!isarray(var_3)) {
    var_0C = var_3;
  } else {
    var_0C = var_4[0];
    if(var_3.size > 1 && var_3[1] == 1) {
      var_0A = 1;
    }

    if(var_3.size > 2) {
      var_0B = scripts\asm\asm_bb::func_2928(var_3[2]);
    }
  }

  var_0D = func_371C(var_1, var_0C, var_8, var_9, var_0A, var_0B);
  if(!isDefined(var_0D)) {
    return 0;
  }

  self.a.var_FC61 = var_0D;
  return 1;
}

func_371C(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = 10;
  if(var_3 || self.setomnvar > self.nodetoentitysighttest * 2) {
    var_6 = 30;
  }

  if(!isDefined(var_5)) {
    var_5 = "";
  }

  if(var_4) {
    if(scripts\asm\asm::func_232C(var_0, "pass_left")) {
      var_7 = var_5 + "left";
    } else if(scripts\asm\asm::func_232C(var_1, "pass_right")) {
      var_7 = var_6 + "right";
    } else if(self.asm.footsteps.foot == "right") {
      var_7 = var_6 + "right";
    } else {
      var_7 = var_6 + "left";
    }
  } else {
    var_7 = var_6;
  }

  if(isDefined(self.var_22F0)) {
    var_8 = self.var_22F0;
  } else {
    var_8 = -1;
  }

  var_9 = self _meth_8546(self.asm.archetype, var_1, scripts\asm\asm::asm_getdemeanor(), var_2, var_3, var_6, var_8, var_7, var_5);
  var_0A = var_9[0];
  var_0B = var_9[1];
  if(isDefined(self.asm.var_13CAF) && self.asm.var_13CAF && isDefined(var_0B)) {
    var_0C = var_0B;
    if(var_0B == 0 || var_0B == 8) {
      var_0C = 2;
    }

    if(var_0B == 1) {
      var_0C = 3;
    }

    if(var_0B == 2) {
      var_0C = 6;
    }

    if(var_0B == 3) {
      var_0C = 9;
    }

    if(var_0B == 4) {
      var_0C = 8;
    }

    if(var_0B == 5) {
      var_0C = 7;
    }

    if(var_0B == 6) {
      var_0C = 4;
    }

    if(var_0B == 7) {
      var_0C = 1;
    }

    var_0D = var_7 + var_0C + "_2h";
    if(lib_0A1E::func_2305(self.asm.archetype, var_1, var_0D)) {
      var_0A = lib_0A1E::func_2359(self.asm.archetype, var_1, var_0D);
    }
  }

  self.a.var_FC62 = var_0B;
  return var_0A;
}

func_3EF5(var_0, var_1, var_2, var_3) {
  return self.a.var_FC61;
}

func_8989(var_0) {
  if(var_0 == "corner") {
    self orientmode("face motion");
  }
}

func_D514(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  var_4 = lib_0A1E::asm_getallanimsforstate(var_0, var_1);
  self.a.var_FC61 = undefined;
  self animmode("zonly_physics", 0);
  self orientmode("face angle", self.angles[1]);
  self clearanim(lib_0A1E::asm_getbodyknob(), var_2);
  lib_0A1E::func_2369(var_0, var_1, var_4);
  thread lib_0F3D::func_444B(var_1);
  self _meth_82EA(var_1, var_4, 1, var_2, self.moveplaybackrate);
  var_5 = lib_0A1E::func_231F(var_0, var_1, ::func_8989, undefined, undefined, 0);
  self orientmode("face motion");
  self animmode("normal", 0);
  if(var_5 == "code_move") {
    lib_0F3D::func_11065();
    thread lib_0F3D::func_136B4(var_0, var_1, var_3);
    thread lib_0F3D::func_136E7(var_0, var_1, var_3);
    var_6 = getnotetracktimes(var_4, "finish");
    if(var_6.size > 0) {
      lib_0A1E::func_231F(var_0, var_1);
    }
  }
}

func_98C6(var_0, var_1, var_2, var_3) {
  if(!isDefined(self.var_E873)) {
    self notify("stop_move_anim_update");
    self.var_12DEF = undefined;
    thread lib_0F3D::func_136B4(var_0, var_1, var_3);
    thread lib_0F3D::func_136E7(var_0, var_1, var_3);
    self clearanim(lib_0A1E::asm_getbodyknob(), var_2);
    self.var_E879 = 0;
    self.var_E873 = 1;
  }
}

func_11088(var_0, var_1, var_2) {
  if(isDefined(self.var_E873)) {
    self clearanim(scripts\asm\asm::asm_lookupanimfromalias(var_1, "run_n_gun"), 0.2);
    self.var_E873 = undefined;
  }

  return 0;
}

func_D50D(var_0, var_1, var_2, var_3) {
  func_98C6(var_0, var_1, var_2, var_3);
  func_E877(var_0, var_1, var_2, var_3);
}

func_E875() {
  if(isalive(self.isnodeoccupied) && self getpersstat(self.isnodeoccupied)) {
    return self.isnodeoccupied;
  }
}

func_1006E(var_0, var_1, var_2, var_3) {
  if(self.team == "allies" && func_9EC3(var_0, var_1, var_2, var_3)) {
    return 0;
  }

  if(self pathdisttogoal() < 200) {
    return 0;
  }

  var_4 = func_E875();
  return self.livestreamingenable && isDefined(var_4) && scripts\anim\move::func_B4EC() && scripts\asm\asm_bb::bb_movetyperequested("combat");
}

func_10070(var_0, var_1, var_2, var_3) {
  return canshoottargetfrompos();
}

func_1006F(var_0, var_1, var_2, var_3) {
  return canshoottarget();
}

func_1009F(var_0, var_1, var_2, var_3) {
  return !func_1006E(var_0, var_1, var_3) || !func_10070(var_0, var_1, var_2, var_3);
}

func_1009E(var_0, var_1, var_2, var_3) {
  return !func_1006E(var_0, var_1, var_3) || !func_1006F(var_0, var_1, var_2, var_3);
}

canshoottargetfrompos() {
  if((!isDefined(self.var_E879) || self.var_E879 == 0) && abs(self getspawnpoint_searchandrescue()) > self.var_B4C3) {
    return 0;
  }

  return 1;
}

canshoottarget() {
  if(!isDefined(self.var_E879) || self.var_E879 == 0) {
    return 0;
  }

  if(180 - abs(self getspawnpoint_searchandrescue()) >= 45) {
    return 0;
  }

  var_0 = detach(0.2);
  if(abs(var_0) > 30) {
    return 0;
  }

  return 1;
}

canshootinvehicle() {
  return scripts\anim\move::func_B4EC() && isDefined(self.isnodeoccupied) && canshoottargetfrompos() || canshoottarget();
}

detach(var_0) {
  var_1 = self.origin;
  var_2 = self.angles[1] + self getspawnpoint_searchandrescue();
  var_1 = var_1 + (cos(var_2), sin(var_2), 0) * length(self.var_381) * var_0;
  var_3 = self.angles[1] - vectortoyaw(self.isnodeoccupied.origin - var_1);
  var_3 = angleclamp180(var_3);
  return var_3;
}

func_E877(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  var_4 = scripts\asm\asm::asm_lookupanimfromalias(var_1, "F");
  var_5 = scripts\asm\asm::asm_lookupanimfromalias(var_1, "L");
  var_6 = scripts\asm\asm::asm_lookupanimfromalias(var_1, "R");
  var_7 = scripts\asm\asm::asm_lookupanimfromalias(var_1, "LB");
  var_8 = scripts\asm\asm::asm_lookupanimfromalias(var_1, "RB");
  var_9 = scripts\asm\asm::asm_lookupanimfromalias(var_1, "run_n_gun");
  var_0A = self.var_B4C3;
  var_0B = self.var_E878;
  var_0C = self.var_E876;
  for(;;) {
    var_0D = func_E875();
    if(isDefined(var_0D)) {
      var_0E = detach(0.2);
      var_0F = var_0E < 0;
    } else {
      var_0E = 0;
      var_0F = self.var_E879 < 0;
    }

    var_10 = 1 - var_0F;
    var_11 = var_0E / var_0A;
    var_12 = var_11 - self.var_E879;
    if(abs(var_12) < var_0B * 0.7) {
      self.var_E879 = var_11;
    } else if(var_12 > 0) {
      self.var_E879 = self.var_E879 + var_0C;
    } else {
      self.var_E879 = self.var_E879 - var_0C;
    }

    var_13 = abs(self.var_E879);
    if(var_13 > var_0B) {
      var_14 = var_13 - var_0B / var_0B;
      var_14 = clamp(var_14, 0, 1);
      self clearanim(var_4, 0.2);
      self _meth_82AC(var_5, 1 - var_14 * var_0F, 0.2);
      self _meth_82AC(var_6, 1 - var_14 * var_10, 0.2);
      self _meth_82AC(var_7, var_14 * var_0F, 0.2);
      self _meth_82AC(var_8, var_14 * var_10, 0.2);
    } else {
      var_14 = clamp(var_13 / var_0B, 0, 1);
      self _meth_82AC(var_4, 1 - var_14, 0.2);
      self _meth_82AC(var_5, var_14 * var_0F, 0.2);
      self _meth_82AC(var_6, var_14 * var_10, 0.2);
      if(var_0B < 1) {
        self clearanim(var_7, 0.2);
        self clearanim(var_8, 0.2);
      }
    }

    self setanimknob(var_9, 1, 0.3, 0.8);
    self.a.var_1C8D = gettime() + 500;
    if(isDefined(var_0D) && isplayer(var_0D)) {
      self _meth_83CE();
    }

    wait(0.2);
  }
}

func_D50E(var_0, var_1, var_2, var_3) {
  func_98C6(var_0, var_1, var_2, var_3);
  func_E874(var_0, var_1, var_2, var_3);
}

func_E874(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  for(;;) {
    if(isplayer(self.isnodeoccupied)) {
      self _meth_83CE();
    }

    var_4 = lib_0A1E::asm_getallanimsforstate(var_0, var_1);
    self give_left_powers(var_1, var_4, 1, var_2, 1);
    lib_0A1E::func_2369(var_0, var_1, var_4);
    wait(0.2);
  }
}

func_D4E6(var_0, var_1, var_2, var_3) {
  if(getdvarint("ai_usefullstrafe", 0) == 0) {
    func_D4E5(var_0, var_1, var_2, var_3);
    return;
  }

  self clearanim(lib_0A1E::asm_getbodyknob(), var_2);
  func_98A3(var_0, var_1, var_2, var_3);
  thread func_BCFD(var_0, var_1, var_2, var_3);
}

func_98A3(var_0, var_1, var_2, var_3) {
  var_4 = 1;
  if(isDefined(var_3)) {
    var_4 = var_3;
  }

  var_5 = lib_0A1E::asm_getallanimsforstate(var_0, var_1);
  self setanimknob(var_5[0], 1, 0.2, var_4, 1);
}

giveachievement(var_0) {
  var_1 = [];
  for(var_2 = 0; var_2 < 9; var_2++) {
    var_1[var_2] = 0;
  }

  var_3 = [-180, -135, -90, -45, 0, 45, 90, 135, 180];
  for(var_2 = 0; var_0 >= var_3[var_2]; var_2++) {}

  var_4 = var_2 - 1;
  var_5 = var_2;
  var_6 = var_0 - var_3[var_4] / var_3[var_5] - var_3[var_4];
  var_7 = 1 - var_6;
  var_1[var_4] = var_7;
  var_1[var_5] = var_6;
  if(var_1[0] > var_1[8]) {
    var_1[8] = var_1[0];
  } else {
    var_1[0] = var_1[8];
  }

  return var_1;
}

func_3F03(var_0, var_1, var_2) {
  var_3 = [];
  var_3[0] = ::scripts\asm\asm::asm_lookupanimfromalias(var_1, "0");
  var_3[1] = ::scripts\asm\asm::asm_lookupanimfromalias(var_1, "1");
  var_3[2] = ::scripts\asm\asm::asm_lookupanimfromalias(var_1, "2");
  var_3[3] = ::scripts\asm\asm::asm_lookupanimfromalias(var_1, "3");
  var_3[4] = ::scripts\asm\asm::asm_lookupanimfromalias(var_1, "4");
  var_3[5] = ::scripts\asm\asm::asm_lookupanimfromalias(var_1, "5");
  var_3[6] = ::scripts\asm\asm::asm_lookupanimfromalias(var_1, "6");
  var_3[7] = ::scripts\asm\asm::asm_lookupanimfromalias(var_1, "7");
  var_3[8] = ::scripts\asm\asm::asm_lookupanimfromalias(var_1, "8");
  return var_3;
}

func_3F0C(var_0, var_1, var_2) {
  var_3 = spawnStruct();
  var_4 = [];
  var_4[0] = ::scripts\asm\asm::asm_lookupanimfromalias(var_1, "0");
  var_4[1] = ::scripts\asm\asm::asm_lookupanimfromalias(var_1, "1");
  var_4[2] = ::scripts\asm\asm::asm_lookupanimfromalias(var_1, "2");
  var_3.var_47 = var_4;
  var_3.var_7332 = scripts\asm\asm::asm_lookupanimfromalias(var_1, "forward");
  return var_3;
}

func_100BD() {
  return scripts\asm\asm_bb::bb_moverequested() && isDefined(self._blackboard.var_13863) && self._blackboard.var_13863;
}

func_13874(var_0, var_1) {
  self endon(var_1 + "_finished");
  lib_0A1E::func_231F(var_0, var_1);
}

func_BD2C(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  thread lib_0F3D::func_136B4(var_0, var_1, var_3);
  thread lib_0F3D::func_136E7(var_0, var_1, var_3);
  var_4 = scripts\asm\asm::asm_getmoveplaybackrate();
  scripts\asm\asm::asm_updatefrantic();
  self _meth_84F1(var_4);
  scripts\asm\asm::asm_updatefrantic();
  var_5 = lib_0A1E::asm_getallanimsforstate(var_0, var_1);
  var_6 = var_5.var_47;
  var_7 = var_5.var_7332;
  self clearanim(lib_0A1E::asm_getbodyknob(), 0.2);
  self _meth_82E1(var_1, var_7, 1, 0.2, 1);
  thread func_13874(var_0, var_1);
  var_8 = 0;
  var_9 = 20;
  for(;;) {
    var_0A = scripts\asm\asm::func_232B(var_1, "cover_approach");
    var_0B = self pathdisttogoal();
    if(var_0A && var_0B < 150) {
      var_0C = func_1E80();
      var_0D = 1;
      while(var_0D <= var_9) {
        var_0E = var_0D / var_9;
        var_0F = var_0E * var_0E * 3 - 2 * var_0E;
        var_10 = var_0C;
        var_11 = var_10 * var_0F;
        var_12 = var_10 - var_11;
        var_13 = mountvehicle(var_12);
        for(var_14 = 0; var_14 < var_13.size; var_14++) {
          self give_attacker_kill_rewards(var_6[var_14], var_13[var_14], 0.2, 1, 1);
        }

        var_0D++;
        wait(0.05);
        waittillframeend;
      }

      while(var_0A) {
        var_13 = mountvehicle(0);
        for(var_0D = 0; var_0D < var_13.size; var_0D++) {
          if(isDefined(var_6[var_0D])) {
            self give_attacker_kill_rewards(var_6[var_0D], var_13[var_0D], 0.2, 1, 1);
          }
        }

        wait(0.05);
        waittillframeend;
      }

      continue;
    }

    var_0C = func_1E80();
    var_15 = var_8 - var_0C;
    if(var_15 < 0) {
      var_15 = var_15 * -1;
    }

    if(var_15 >= 60) {
      var_16 = var_8;
      var_17 = var_8;
      var_0D = 1;
      while(var_0D <= var_9) {
        var_0C = func_1E80();
        var_18 = var_16 - var_0C;
        if(var_18 < 0) {
          var_18 = var_18 * -1;
        }

        if(var_18 >= 60) {
          if(var_0D == 1) {
            var_0D = 1;
          } else {
            var_0D = var_0D - 1;
          }

          var_19 = var_16 - var_8;
          var_0E = var_0D / var_9;
          var_0F = var_0E * var_0E * 3 - 2 * var_0E;
          var_1A = var_19 * var_0F;
          var_17 = var_1A + var_8;
          var_0D = 1;
          var_8 = var_17;
        }

        var_0E = var_0D / var_9;
        var_0F = var_0E * var_0E * 3 - 2 * var_0E;
        var_10 = var_0C - var_17;
        var_11 = var_10 * var_0F;
        var_12 = var_11 + var_8;
        var_13 = mountvehicle(var_12);
        for(var_14 = 0; var_14 < var_13.size; var_14++) {
          self give_attacker_kill_rewards(var_6[var_14], var_13[var_14], 0.2, 1, 1);
        }

        var_0D++;
        var_16 = var_0C;
        wait(0.05);
        waittillframeend;
      }
    } else {
      var_13 = mountvehicle(var_0C);
      for(var_0D = 0; var_0D < var_13.size; var_0D++) {
        if(isDefined(var_6[var_0D])) {
          self give_attacker_kill_rewards(var_6[var_0D], var_13[var_0D], 0.2, 1, 1);
        }
      }

      wait(0.05);
      waittillframeend;
    }

    var_8 = var_0C;
  }
}

func_1E80() {
  var_0 = self.var_13864.origin;
  var_1 = self.origin;
  var_2 = var_0 - var_1;
  var_3 = anglesToForward(self.angles);
  var_4 = vectorcross(var_3, var_2);
  var_5 = vectornormalize(var_4);
  var_6 = vectornormalize(var_2);
  var_7 = vectornormalize(var_3);
  var_8 = vectordot(var_6, var_7);
  if(isDefined(self.var_13862)) {
    var_9 = scripts\engine\utility::anglebetweenvectors(var_2, var_3);
    if(self.var_13862 == "right") {
      if(var_8 <= -1) {
        return -180;
      }

      return var_9 * -1;
    }

    if(var_8 >= 1) {
      return 180;
    }

    return var_9;
  }

  if(var_8 >= 1) {
    return 180;
  }

  if(var_8 <= -1) {
    return -180;
  }

  var_9 = scripts\engine\utility::anglebetweenvectors(var_2, var_3);
  if(var_5[2] == -1) {
    var_9 = var_9 * -1;
  }

  return var_9;
}

mountvehicle(var_0) {
  var_1 = [];
  for(var_2 = 0; var_2 < 3; var_2++) {
    var_1[var_2] = 0;
  }

  var_3 = [-180, 0, 180];
  for(var_2 = 0; var_0 >= var_3[var_2]; var_2++) {}

  var_4 = var_2 - 1;
  var_5 = var_2;
  var_6 = var_0 - var_3[var_4] / var_3[var_5] - var_3[var_4];
  var_7 = 1 - var_6;
  var_1[var_4] = var_7;
  var_1[var_5] = var_6;
  var_1[1] = max(0.01, var_1[1]);
  return var_1;
}

func_BCFD(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  var_4 = 1;
  if(isDefined(var_3)) {
    var_4 = var_3;
  }

  var_5 = lib_0A1E::asm_getallanimsforstate(var_0, var_1);
  self.var_110D5 = 0;
  var_6 = self getspawnpoint_searchandrescue();
  for(;;) {
    if(length(self.var_381) > 1) {
      var_6 = self getspawnpoint_searchandrescue();
    }

    self.var_110D5 = var_6;
    var_7 = giveachievement(self.var_110D5);
    for(var_8 = 0; var_8 < var_7.size; var_8++) {
      if(isDefined(var_5[var_8])) {
        self _meth_82AC(var_5[var_8], var_7[var_8], 0.1, var_4, 1);
      }
    }

    wait(0.1);
  }
}

func_D4E5(var_0, var_1, var_2, var_3) {
  func_98A2(var_0, var_1, var_2, var_3);
  thread func_BCFC(var_0, var_1, var_2, var_3);
}

func_98A2(var_0, var_1, var_2, var_3) {
  var_4 = 1;
  if(isDefined(var_3) && scripts\asm\asm::asm_getdemeanor() != "frantic") {
    var_4 = var_3;
  }

  var_5 = scripts\asm\asm::asm_lookupanimfromalias(var_1, "F");
  var_6 = scripts\asm\asm::asm_lookupanimfromalias(var_1, "L");
  var_7 = scripts\asm\asm::asm_lookupanimfromalias(var_1, "R");
  var_8 = scripts\asm\asm::asm_lookupanimfromalias(var_1, "B");
  self _meth_82A9(var_5, 1, 0.1, var_4, 1);
  self _meth_82A9(var_8, 1, 0.1, var_4, 1);
  self _meth_82A9(var_7, 1, 0.1, var_4, 1);
  self _meth_82A9(var_6, 1, 0.1, var_4, 1);
}

func_BCFC(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  var_4 = 1;
  if(isDefined(var_3)) {
    var_4 = var_3;
  }

  self _meth_84F1(var_4);
  var_5 = scripts\asm\asm::asm_lookupanimfromalias(var_1, "f_knob");
  var_6 = scripts\asm\asm::asm_lookupanimfromalias(var_1, "l_knob");
  var_7 = scripts\asm\asm::asm_lookupanimfromalias(var_1, "r_knob");
  var_8 = scripts\asm\asm::asm_lookupanimfromalias(var_1, "b_knob");
  for(;;) {
    var_9 = scripts\anim\utility_common::quadrantanimweights(self getspawnpoint_searchandrescue());
    self give_attacker_kill_rewards(var_5, var_9["front"], 0.2, 1, 1);
    self give_attacker_kill_rewards(var_8, var_9["back"], 0.2, 1, 1);
    self give_attacker_kill_rewards(var_6, var_9["left"], 0.2, 1, 1);
    self give_attacker_kill_rewards(var_7, var_9["right"], 0.2, 1, 1);
    wait(0.05);
    waittillframeend;
  }
}

func_3EFF(var_0, var_1, var_2) {
  if(isDefined(self.objective_position)) {
    return scripts\asm\asm::asm_lookupanimfromalias(var_1, "sprint_short");
  }

  if(scripts\asm\asm::asm_hasdemeanoranimoverride("sprint", "move")) {
    var_3 = scripts\asm\asm::asm_getdemeanoranimoverride("sprint", "move");
    if(isarray(var_3)) {
      return var_3[randomint(var_3.size)];
    }

    return var_3;
  }

  return scripts\asm\asm::asm_lookupanimfromalias(var_2, "sprint");
}

func_FFF5(var_0, var_1, var_2, var_3) {
  if(isDefined(self.disablebulletwhizbyreaction)) {
    return 0;
  }

  var_4 = scripts\asm\asm_bb::bb_getrequestedwhizby();
  if(!isDefined(var_4)) {
    return 0;
  }

  if(self.setomnvar < 100) {
    return 0;
  }

  if(!isDefined(self.vehicle_getspawnerarray) || distancesquared(self.vehicle_getspawnerarray, self.origin) < 160000) {
    return 0;
  }

  return 1;
}

func_BCF9(var_0) {
  var_1 = scripts\asm\asm::asm_getdemeanor();
  if(var_1 == "frantic" || var_1 == "combat" || var_1 == "sprint") {
    scripts\anim\battlechatter_ai::func_67D2(var_0);
  }
}

shouldreload(var_0, var_1, var_2, var_3) {
  if(!scripts\asm\asm_bb::bb_reloadrequested()) {
    return 0;
  }

  if(scripts\asm\asm::asm_getdemeanor()) {
    var_4 = 400;
  } else if(scripts\asm\asm_bb::bb_movetyperequested("cqb")) {
    var_4 = 500;
  } else {
    var_4 = 600;
  }

  var_5 = self pathdisttogoal();
  return var_4 < var_5;
}

func_D506(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  thread lib_0F3D::func_136B4(var_0, var_1, var_3);
  thread lib_0F3D::func_136E7(var_0, var_1, var_3);
  var_4 = lib_0A1E::asm_getallanimsforstate(var_0, var_1);
  self _meth_82E7(var_1, var_4, 1, var_2, self.moveplaybackrate);
  lib_0A1E::func_2369(var_0, var_1, var_4);
  lib_0A1E::func_231F(var_0, var_1);
}

func_116FE(var_0, var_1, var_2) {
  if(!scripts\asm\asm::func_232B(var_1, "reload done")) {
    scripts\anim\weaponlist::refillclip();
  }

  lib_0C68::func_DF4F(var_0, var_1, var_2);
}

func_10B4F(var_0, var_1, var_2) {
  if(isDefined(var_2)) {
    var_3 = scripts\asm\asm_bb::func_2928(var_2);
    if(isDefined(var_3)) {
      var_1 = var_3 + var_1;
    }
  }

  return scripts\engine\utility::istrue(scripts\asm\asm::asm_hasalias(var_0, var_1));
}

func_9EC3(var_0, var_1, var_2, var_3) {
  return isDefined(self.vehicle_getspawnerarray) && self.getcsplinepointtargetname != "none";
}

func_9EC9(var_0, var_1, var_2, var_3) {
  if(!isDefined(self.vehicle_getspawnerarray)) {
    return 0;
  }

  if(isarray(var_3)) {
    var_4 = var_3[0];
  } else {
    var_4 = var_4;
  }

  return self.getcsplinepointtargetname == var_4;
}

_meth_8157() {
  var_0 = scripts\asm\asm::asm_getdemeanor();
  switch (var_0) {
    case "casual":
      return 23;

    case "casual_gun":
      return 17;

    case "cqb":
      return 20;

    default:
      return 36;
  }
}

func_10006(var_0, var_1, var_2, var_3) {
  var_4 = undefined;
  if(isarray(var_3)) {
    var_4 = var_3[0];
  } else {
    var_4 = var_3;
  }

  if(self.getcsplinepointtargetname == var_4) {
    return 1;
  }

  var_5 = _meth_8157();
  var_6 = self _meth_84D7(var_5);
  if(var_6 == var_4) {
    return 1;
  }

  return 0;
}

func_10005(var_0, var_1, var_2, var_3) {
  var_4 = undefined;
  if(isarray(var_3)) {
    var_4 = var_3[0];
  } else {
    var_4 = var_3;
  }

  if(self.getcsplinepointtargetname == var_4) {
    var_5 = undefined;
    if(isarray(var_3)) {
      var_5 = var_3[1];
    }

    return func_10B4F(var_2, "left", var_5);
  }

  var_6 = _meth_8157();
  var_7 = self _meth_84D7(var_6);
  if(var_7 == var_5) {
    var_5 = undefined;
    if(isarray(var_3)) {
      var_7 = var_3[1];
    }

    return func_10B4F(var_2, "left", var_7);
  }

  return 0;
}

_meth_8158() {
  var_0 = scripts\asm\asm::asm_getdemeanor();
  switch (var_0) {
    case "casual":
      return 13;

    case "casual_gun":
      return 10;

    case "cqb":
      return 13;

    case "combat":
      return 10;

    case "frantic":
      return 10;

    default:
      return 28;
  }
}

getpointinbounds() {
  var_0 = scripts\asm\asm::asm_getdemeanor();
  switch (var_0) {
    case "casual":
      return 24;

    case "casual_gun":
      return 24;

    case "cqb":
      return 15;

    default:
      return 28;
  }
}

func_7EEA() {
  var_0 = self _meth_8552();
  if(abs(var_0) > 0.99) {
    return 0;
  }

  var_1 = acos(var_0);
  return var_1;
}

func_10030(var_0, var_1, var_2, var_3) {
  return self.getcsplinepointtargetname != "none" && func_1000E(var_0, var_1, var_2, var_3);
}

func_1000E(var_0, var_1, var_2, var_3) {
  if(isDefined(self._blackboard.disablestairsexits) && self._blackboard.disablestairsexits) {
    return 0;
  }

  if(self.getcsplinepointtargetname == "none") {
    return 1;
  }

  var_4 = var_3;
  var_5 = _meth_8158();
  if(isDefined(var_3) && var_3 == "up") {
    var_5 = getpointinbounds();
  }

  if(self.getcsplinepointtargetname != var_4) {
    return 1;
  }

  var_6 = self _meth_84D7(var_5);
  return var_6 != self.getcsplinepointtargetname;
}

func_3EA5(var_0, var_1, var_2) {
  if(self.asm.footsteps.foot == "left") {
    var_3 = "right";
  } else {
    var_3 = "left";
  }

  if(isDefined(var_2)) {
    var_4 = scripts\asm\asm_bb::func_2928(var_2);
    if(isDefined(var_4)) {
      var_3 = var_4 + var_3;
    }
  }

  var_5 = lib_0A1E::func_2356(var_1, var_3);
  return var_5;
}

func_3EA6(var_0, var_1, var_2) {
  var_3 = "8x10";
  var_4 = func_7EEA();
  if(var_4 < 27.75) {
    var_3 = "8x20";
  }

  if(var_4 >= 27.75 && var_4 < 36.2) {
    var_3 = "8x12";
  }

  if(var_4 >= 36.2 && var_4 < 41.85) {
    var_3 = "8x10";
  }

  if(var_4 >= 41.85) {
    var_3 = "8x8";
  }

  var_5 = lib_0A1E::func_2356(var_1, var_3);
  return var_5;
}