/******************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\anim\cover_arrival.gsc
******************************************/

main() {
  self endon("killanimscript");
  self endon("abort_approach");
  if(isDefined(self.var_4C7E)) {
    [[self.var_4C7E]]();
    return;
  }

  var_00 = self.var_20F0;
  var_01 = scripts\anim\utility::func_B027("cover_trans", self.var_20F2)[var_00];
  if(!isDefined(self.heat)) {
    thread func_1524();
  }

  self clearanim( % body, 0.2);
  self _meth_82EA("coverArrival", var_01, 1, 0.2, self.var_BD22);
  scripts\anim\face::playfacialanim(var_01, "run");
  scripts\anim\shared::donotetracks("coverArrival", ::func_89EA);
  var_02 = level.var_22E7[self.var_20F2];
  if(isDefined(var_02)) {
    self.a.pose = var_02;
  }

  self.a.movement = "stop";
  self.a.var_22F5 = self.var_20F2;
  self clearanim( % root, 0.3);
  self.var_A93C = undefined;
}

func_89EA(param_00) {
  if(param_00 == "start_aim") {
    if(self.a.pose == "stand") {
      scripts\anim\animset::func_F2BE();
    } else if(self.a.pose == "crouch") {
      scripts\anim\animset::func_F2B6();
    } else {}

    scripts\anim\combat::func_F296();
    self.var_D8AF = 0;
    scripts\anim\combat_utility::func_FA8C(0);
    thread scripts\anim\track::func_11B07();
  }
}

func_9FA5() {
  if(!isDefined(self.target_getindexoftarget)) {
    return 0;
  }

  if(isDefined(self.isnodeoccupied) && self seerecently(self.isnodeoccupied, 1.5) && distancesquared(self.origin, self.isnodeoccupied.origin) < 250000) {
    return !self _meth_8199();
  }

  return 0;
}

func_1524() {
  self endon("killanimscript");
  for(;;) {
    if(!isDefined(self.target_getindexoftarget)) {
      return;
    }

    if(func_9FA5()) {
      self clearanim( % root, 0.3);
      self notify("abort_approach");
      self.var_A93C = gettime();
      return;
    }

    wait(0.1);
  }
}

func_393C(param_00) {
  if(!scripts\anim\utility_common::usingmg()) {
    return 0;
  }

  if(!isDefined(param_00.var_12A72)) {
    return 0;
  }

  if(param_00.type != "Cover Stand" && param_00.type != "Cover Prone" && param_00.type != "Cover Crouch") {
    return 0;
  }

  if(isDefined(self.isnodeoccupied) && distancesquared(self.isnodeoccupied.origin, param_00.origin) < 65536) {
    return 0;
  }

  if(scripts\anim\utility_common::getnodeyawtoenemy() > 40 || scripts\anim\utility_common::getnodeyawtoenemy() < -40) {
    return 0;
  }

  return 1;
}

func_53C6(param_00) {
  var_01 = param_00.type;
  if(func_393C(param_00)) {
    if(var_01 == "Cover Stand") {
      return "stand_saw";
    }

    if(var_01 == "Cover Crouch") {
      return "crouch_saw";
    } else if(var_01 == "Cover Prone") {
      return "prone_saw";
    }
  }

  if(!isDefined(level.var_20EB[var_01])) {
    return;
  }

  if(isDefined(param_00.var_22EF)) {
    var_02 = param_00.var_22EF;
  } else {
    var_02 = var_01 gethighestnodestance();
  }

  if(var_02 == "prone") {
    var_02 = "crouch";
  }

  var_03 = level.var_20EB[var_01][var_02];
  if(func_130C9() && var_03 == "exposed") {
    var_03 = "exposed_ready";
  }

  if(scripts\anim\utility::func_FFDB()) {
    var_04 = var_03 + "_cqb";
    if(isDefined(level.archetypes["soldier"]["cover_trans"][var_04])) {
      var_03 = var_04;
    }
  }

  return var_03;
}

func_53C4(param_00) {
  if(isDefined(self.heat)) {
    return "heat";
  }

  if(isDefined(param_00.var_22EF)) {
    var_01 = param_00.var_22EF;
  } else {
    var_01 = var_01 gethighestnodestance();
  }

  if(var_01 == "prone") {
    var_01 = "crouch";
  }

  if(var_01 == "crouch") {
    var_02 = "exposed_crouch";
  } else {
    var_02 = "exposed";
  }

  if(var_02 == "exposed" && func_130C9()) {
    var_02 = var_02 + "_ready";
  }

  if(scripts\anim\utility::func_FFDB()) {
    return var_02 + "_cqb";
  }

  return var_02;
}

func_3719(param_00, param_01) {
  var_02 = anglestoright(param_00);
  var_03 = anglesToForward(param_00);
  return var_03 * param_01[0] + var_02 * 0 - param_01[1];
}

func_7DCB() {
  if(isDefined(self.physics_querypoint)) {
    return self.physics_querypoint;
  }

  if(isDefined(self.target_getindexoftarget)) {
    return self.target_getindexoftarget;
  }

  return undefined;
}

func_7DCC(param_00, param_01) {
  if(param_01 == "stand_saw") {
    var_02 = (param_00.var_12A72.origin[0], param_00.var_12A72.origin[1], param_00.origin[2]);
    var_03 = anglesToForward((0, param_00.var_12A72.angles[1], 0));
    var_04 = anglestoright((0, param_00.var_12A72.angles[1], 0));
    var_02 = var_02 + var_03 * -32.545 - var_04 * 6.899;
  } else if(var_02 == "crouch_saw") {
    var_02 = (param_01.var_12A72.origin[0], param_01.var_12A72.origin[1], param_01.origin[2]);
    var_03 = anglesToForward((0, param_00.var_12A72.angles[1], 0));
    var_04 = anglestoright((0, param_00.var_12A72.angles[1], 0));
    var_02 = var_02 + var_03 * -32.545 - var_04 * 6.899;
  } else if(var_02 == "prone_saw") {
    var_02 = (param_01.var_12A72.origin[0], param_01.var_12A72.origin[1], param_01.origin[2]);
    var_03 = anglesToForward((0, param_00.var_12A72.angles[1], 0));
    var_04 = anglestoright((0, param_00.var_12A72.angles[1], 0));
    var_02 = var_02 + var_03 * -37.36 - var_04 * 13.279;
  } else if(isDefined(self.physics_querypoint)) {
    var_02 = self.objective_playermask_hidefromall;
  } else {
    var_02 = param_01.origin;
  }

  return var_02;
}

func_3DED() {
  if(isDefined(self getspectatepoint())) {
    return 0;
  }

  if(isDefined(self.disablearrivals) && self.disablearrivals) {
    return 0;
  }

  return 1;
}

func_3DEC(param_00, param_01, param_02) {
  if(isDefined(level.var_6A1B[param_00])) {
    return 0;
  }

  if(param_00 == "stand" || param_00 == "crouch") {
    if(scripts\engine\utility::absangleclamp180(vectortoyaw(param_01) - param_02.angles[1] + 180) < 60) {
      return 0;
    }
  }

  if(func_9FA5() || isDefined(self.var_A93C) && self.var_A93C + 500 > gettime()) {
    return 0;
  }

  return 1;
}

func_FA90(param_00) {
  self endon("killanimscript");
  if(isDefined(self.heat)) {
    thread func_58E7();
    return;
  }

  if(param_00) {
    self.print3d = 1;
  }

  self.a.var_22F5 = undefined;
  thread func_58E7();
  self waittill("cover_approach", var_01);
  if(!func_3DED()) {
    return;
  }

  thread func_FA90(0);
  var_02 = "exposed";
  var_03 = self.vehicle_getspawnerarray;
  var_04 = vectortoyaw(var_01);
  var_05 = var_04;
  var_06 = func_7DCB();
  if(isDefined(var_06)) {
    var_02 = func_53C6(var_06);
    if(isDefined(var_02) && var_02 != "exposed") {
      var_03 = func_7DCC(var_06, var_02);
      var_04 = var_06.angles[1];
      var_05 = scripts\asm\shared_utility::getnodeforwardyaw(var_06);
    }
  } else if(func_130C9()) {
    if(scripts\anim\utility::func_FFDB()) {
      var_02 = "exposed_ready_cqb";
    } else {
      var_02 = "exposed_ready";
    }
  }

  if(!isDefined(var_02)) {
    return;
  }

  if(!func_3DEC(var_02, var_01, var_06)) {
    return;
  }

  func_10D80(var_02, var_03, var_04, var_05, var_01);
}

func_4710(param_00, param_01, param_02, param_03, param_04) {
  if(isDefined(self.disablearrivals) && self.disablearrivals) {
    return 0;
  }

  if(abs(self getspawnpoint_searchandrescue()) > 45 && isDefined(self.isnodeoccupied) && vectordot(anglesToForward(self.angles), vectornormalize(self.isnodeoccupied.origin - self.origin)) > 0.8) {
    return 0;
  }

  if(self.a.pose != "stand" || self.a.movement != "run" && !scripts\anim\utility::func_9D9C()) {
    return 0;
  }

  if(scripts\engine\utility::absangleclamp180(param_04 - self.angles[1]) > 30) {
    if(isDefined(self.isnodeoccupied) && self getpersstat(self.isnodeoccupied) && distancesquared(self.origin, self.isnodeoccupied.origin) < 65536) {
      if(vectordot(anglesToForward(self.angles), self.isnodeoccupied.origin - self.origin) > 0) {
        return 0;
      }
    }
  }

  if(!func_3E00(param_00, param_01, param_02, param_03, 0)) {
    return 0;
  }

  return 1;
}

func_20F4(param_00, param_01) {
  if(!isDefined(param_00)) {
    return;
  }

  for(;;) {
    if(!isDefined(self.vehicle_getspawnerarray)) {
      func_136CD();
    }

    var_02 = distance(self.origin, self.vehicle_getspawnerarray);
    if(var_02 <= param_01 + 8) {
      break;
    }

    var_03 = var_02 - param_01 / 250 - 0.1;
    if(var_03 < 0.05) {
      var_03 = 0.05;
    }

    wait(var_03);
  }
}

func_10D80(param_00, param_01, param_02, param_03, param_04) {
  self endon("killanimscript");
  self endon("cover_approach");
  var_05 = func_7DCB();
  var_06 = scripts\anim\exit_node::getmaxdamage(var_05);
  var_07 = var_06.var_B490;
  var_08 = var_06.var_68CA;
  var_09 = vectordot(param_04, anglesToForward(var_05.angles)) >= 0;
  var_06 = func_3DEE(param_01, param_03, param_00, param_04, var_07, var_08, var_09);
  if(var_06.var_20F0 < 0) {
    return;
  }

  var_0A = var_06.var_20F0;
  if(var_0A <= 6 && var_09) {
    self endon("goal_changed");
    self.var_22F0 = level.var_4754[param_00];
    func_20F4(var_05, self.var_22F0);
    var_0B = vectornormalize(param_01 - self.origin);
    var_06 = func_3DEE(param_01, param_03, param_00, var_0B, var_07, var_08, var_09);
    self.var_22F0 = length(scripts\anim\utility::func_B031("cover_trans_dist", param_00, var_0A));
    func_20F4(var_05, self.var_22F0);
    if(!self maymovetopoint(param_01)) {
      self.var_22F0 = undefined;
      return;
    }

    if(var_06.var_20F0 < 0) {
      self.var_22F0 = undefined;
      return;
    }

    var_0A = var_06.var_20F0;
    var_0C = param_03 - scripts\anim\utility::func_B031("cover_trans_angles", param_00, var_0A);
  } else {
    self give_smack_perk(self.var_4718);
    self waittill("runto_arrived");
    var_0C = param_04 - scripts\anim\utility::func_B031("cover_trans_angles", param_01, var_0C);
    if(!func_4710(param_01, param_03, param_00, var_0A, var_0C)) {
      return;
    }
  }

  self.var_20F0 = var_0A;
  self.var_20F2 = param_00;
  self.var_22F0 = undefined;
  self _meth_8396(self.var_4718, var_0C);
}

func_3DEE(param_00, param_01, param_02, param_03, param_04, param_05, param_06) {
  var_07 = spawnStruct();
  scripts\anim\exit_node::func_371A(var_07, param_02, 1, param_01, param_03, param_04, param_05);
  scripts\anim\exit_node::func_1043F(var_07, param_04);
  var_08 = spawnStruct();
  var_09 = (0, 0, 0);
  var_08.var_20F0 = -1;
  var_0A = 2;
  for(var_0B = 1; var_0B <= var_0A; var_0B++) {
    var_08.var_20F0 = var_07.var_12654[var_0B];
    if(!func_3E00(param_00, param_01, param_02, var_08.var_20F0, param_06)) {
      continue;
    }

    break;
  }

  if(var_0B > var_0A) {
    var_08.var_20F0 = -1;
    return var_08;
  }

  var_0C = distancesquared(param_00, self.origin);
  var_0D = distancesquared(param_00, self.var_4718);
  if(var_0C < var_0D * 2 * 2) {
    if(var_0C < var_0D) {
      var_08.var_20F0 = -1;
      return var_08;
    }

    if(!param_06) {
      var_0E = vectornormalize(self.var_4718 - self.origin);
      var_0F = param_01 - scripts\anim\utility::func_B031("cover_trans_angles", param_02, var_08.var_20F0);
      var_10 = anglesToForward((0, var_0F, 0));
      var_11 = vectordot(var_0E, var_10);
      if(var_11 < 0.707) {
        var_08.var_20F0 = -1;
        return var_08;
      }
    }
  }

  return var_08;
}

func_58E7() {
  self endon("killanimscript");
  self endon("move_interrupt");
  self notify("doing_last_minute_exposed_approach");
  self endon("doing_last_minute_exposed_approach");
  thread func_13A8F();
  for(;;) {
    func_58E6();
    for(;;) {
      scripts\engine\utility::waittill_any_3("goal_changed", "goal_changed_previous_frame");
      if(isDefined(self.var_4718) && isDefined(self.vehicle_getspawnerarray) && distance2d(self.var_4718, self.vehicle_getspawnerarray) < 1) {
        continue;
      }

      break;
    }
  }
}

func_13A8F() {
  self endon("killanimscript");
  self endon("doing_last_minute_exposed_approach");
  for(;;) {
    self waittill("goal_changed");
    wait(0.05);
    self notify("goal_changed_previous_frame");
  }
}

func_6A0E(param_00, param_01) {
  if(!isDefined(self.vehicle_getspawnerarray)) {
    return 0;
  }

  if(isDefined(self.disablearrivals) && self.disablearrivals) {
    return 0;
  }

  if(isDefined(self.var_20ED)) {
    if(!self[[self.var_20ED]](param_00)) {
      return 0;
    }
  } else {
    if(!self.livestreamingenable && !isDefined(param_00) || param_00.type == "Path" || param_00.type == "Path 3D") {
      return 0;
    }

    if(self.a.pose != "stand") {
      return 0;
    }
  }

  if(func_9FA5() || isDefined(self.var_A93C) && self.var_A93C + 500 > gettime()) {
    return 0;
  }

  if(!self maymovetopoint(self.vehicle_getspawnerarray)) {
    return 0;
  }

  return 1;
}

func_6A0F() {
  for(;;) {
    if(!isDefined(self.vehicle_getspawnerarray)) {
      func_136CD();
    }

    var_00 = func_7DCB();
    if(isDefined(var_00) && !isDefined(self.heat)) {
      var_01 = var_00.origin;
    } else {
      var_01 = self.vehicle_getspawnerarray;
    }

    var_02 = distance(self.origin, var_01);
    var_03 = level.var_AFE8;
    if(var_02 <= var_03 + 8) {
      break;
    }

    var_04 = var_02 - level.var_AFE8 / 250 - 0.1;
    if(var_04 < 0) {
      break;
    }

    if(var_04 < 0.05) {
      var_04 = 0.05;
    }

    wait(var_04);
  }
}

func_6A6D(param_00) {
  if(!isDefined(self.isnodeoccupied)) {
    return 0;
  }

  if(isDefined(self.heat) && isDefined(param_00)) {
    return 0;
  }

  if(self.var_BC == "cover" && issentient(self.isnodeoccupied) && gettime() - self lastknowntime(self.isnodeoccupied) > 15000) {
    return 0;
  }

  return sighttracepassed(self.isnodeoccupied getshootatpos(), self.vehicle_getspawnerarray + (0, 0, 60), 0, undefined);
}

func_58E6() {
  self endon("goal_changed");
  self endon("move_interrupt");
  if(isDefined(self getspectatepoint())) {
    return;
  }

  func_6A0F();
  if(isDefined(self.objective_position) && isDefined(self.objective_position.opcode::OP_EvalSelfFieldVariable) && self.objective_position.opcode::OP_EvalSelfFieldVariable == self) {
    return;
  }

  var_00 = "exposed";
  var_01 = 1;
  if(isDefined(self.var_20F3)) {
    var_00 = self[[self.var_20F3]]();
  } else if(func_130C9()) {
    if(scripts\anim\utility::func_FFDB()) {
      var_00 = "exposed_ready_cqb";
    } else {
      var_00 = "exposed_ready";
    }
  } else if(scripts\anim\utility::func_FFDB()) {
    var_00 = "exposed_cqb";
  } else if(isDefined(self.heat)) {
    var_00 = "heat";
    var_01 = 4096;
  }

  var_02 = func_7DCB();
  if(isDefined(var_02) && isDefined(self.vehicle_getspawnerarray) && !isDefined(self.disablecollision)) {
    var_03 = distancesquared(self.vehicle_getspawnerarray, var_02.origin) < var_01;
  } else {
    var_03 = 0;
  }

  if(var_03) {
    var_00 = func_53C4(var_02);
  }

  var_04 = vectornormalize(self.vehicle_getspawnerarray - self.origin);
  var_05 = vectortoyaw(var_04);
  if(isDefined(self.var_6A6C)) {
    var_05 = self.angles[1];
  } else if(func_6A6D(var_02)) {
    var_05 = vectortoyaw(self.isnodeoccupied.origin - self.vehicle_getspawnerarray);
  } else {
    var_06 = isDefined(var_02) && var_03;
    var_06 = var_06 && var_02.type != "Path" && var_02.type != "Path 3D" && var_02.type != "Ambush" || !scripts\anim\utility_common::recentlysawenemy();
    if(var_06) {
      var_05 = scripts\asm\shared_utility::getnodeforwardyaw(var_02);
    } else {
      var_07 = self getsafeanimmovedeltapercentage();
      if(isDefined(var_07)) {
        var_05 = var_07[1];
      }
    }
  }

  var_08 = spawnStruct();
  scripts\anim\exit_node::func_371A(var_08, var_00, 1, var_05, var_04, 9, -1);
  var_09 = 1;
  for(var_0A = 2; var_0A <= 9; var_0A++) {
    if(var_08.transitions[var_0A] > var_08.transitions[var_09]) {
      var_09 = var_0A;
    }
  }

  self.var_20F0 = var_08.var_12654[var_09];
  self.var_20F2 = var_00;
  var_0B = scripts\anim\utility::func_B031("cover_trans", var_00, self.var_20F0);
  var_0C = length(scripts\anim\utility::func_B031("cover_trans_dist", var_00, self.var_20F0));
  var_0D = var_0C + 8;
  var_0D = var_0D * var_0D;
  while(isDefined(self.vehicle_getspawnerarray) && distancesquared(self.origin, self.vehicle_getspawnerarray) > var_0D) {
    wait(0.05);
  }

  if(isDefined(self.var_22F0) && self.var_22F0 < var_0C + 8) {
    return;
  }

  if(!func_6A0E(var_02, var_03)) {
    return;
  }

  var_0E = distance(self.origin, self.vehicle_getspawnerarray);
  if(abs(var_0E - var_0C) > 8) {
    return;
  }

  var_0F = vectortoyaw(self.vehicle_getspawnerarray - self.origin);
  if(isDefined(self.heat) && var_03) {
    var_10 = var_05 - scripts\anim\utility::func_B031("cover_trans_angles", var_00, self.var_20F0);
    var_11 = func_7DD9(self.vehicle_getspawnerarray, var_05, var_00, self.var_20F0);
  } else if(var_0E > 0) {
    var_12 = scripts\anim\utility::func_B031("cover_trans_dist", var_02, self.var_20F0);
    var_13 = atan(var_12[1] / var_12[0]);
    if(!isDefined(self.var_6A6C) || self.livestreamingenable) {
      var_10 = var_0F - var_13;
      if(scripts\engine\utility::absangleclamp180(var_10 - self.angles[1]) > 30) {
        return;
      }
    } else {
      var_10 = self.angles[1];
    }

    var_14 = var_0E - var_0C;
    var_11 = self.origin + vectornormalize(self.vehicle_getspawnerarray - self.origin) * var_14;
  } else {
    var_10 = self.angles[1];
    var_11 = self.origin;
  }

  self _meth_8396(var_11, var_10);
}

func_136CD() {
  for(;;) {
    if(isDefined(self.vehicle_getspawnerarray)) {
      return;
    }

    wait(0.1);
  }
}

custommovetransitionfunc() {
  if(!isDefined(self.var_10DCB)) {
    return;
  }

  self animmode("zonly_physics", 0);
  self orientmode("face current");
  self _meth_82E4("move", self.var_10DCB, % root, 1);
  scripts\anim\face::playfacialanim(self.var_10DCB, "run");
  if(animhasnotetrack(self.var_10DCB, "code_move")) {
    scripts\anim\shared::donotetracks("move");
    self orientmode("face motion");
    self animmode("none", 0);
  }

  scripts\anim\shared::donotetracks("move");
}

func_110CC(param_00) {
  if(!isDefined(param_00)) {
    return "{undefined}";
  }

  return param_00;
}

func_5B8D(param_00, param_01, param_02, param_03) {
  for(var_04 = 0; var_04 < param_02 * 100; var_04++) {
    wait(0.05);
  }
}

func_5B6C(param_00) {
  self endon("killanimscript");
  for(;;) {
    if(!isDefined(self.target_getindexoftarget)) {
      break;
    }

    wait(0.05);
  }
}

func_7DD9(param_00, param_01, param_02, param_03) {
  var_04 = (0, param_01 - scripts\anim\utility::func_B031("cover_trans_angles", param_02, param_03), 0);
  var_05 = anglesToForward(var_04);
  var_06 = anglestoright(var_04);
  var_07 = scripts\anim\utility::func_B031("cover_trans_dist", param_02, param_03);
  var_08 = var_05 * var_07[0];
  var_09 = var_06 * var_07[1];
  return param_00 - var_08 + var_09;
}

func_7DD8(param_00, param_01, param_02, param_03) {
  var_04 = (0, param_01 - scripts\anim\utility::func_B031("cover_trans_angles", param_02, param_03), 0);
  var_05 = anglesToForward(var_04);
  var_06 = anglestoright(var_04);
  var_07 = scripts\anim\utility::func_B031("cover_trans_predist", param_02, param_03);
  var_08 = var_05 * var_07[0];
  var_09 = var_06 * var_07[1];
  return param_00 - var_08 + var_09;
}

func_3E00(param_00, param_01, param_02, param_03, param_04) {
  var_05 = func_7DD9(param_00, param_01, param_02, param_03);
  self.var_4718 = var_05;
  if(param_03 <= 6 && param_04) {
    return 1;
  }

  if(!self maymovefrompointtopoint(var_05, param_00)) {
    return 0;
  }

  if(param_03 <= 6 || isDefined(level.var_6A1B[param_02])) {
    return 1;
  }

  var_06 = func_7DD8(var_05, param_01, param_02, param_03);
  self.var_4718 = var_06;
  return self maymovefrompointtopoint(var_06, var_05);
}

func_130C9() {
  if(!isDefined(level.var_DD79)) {
    return 0;
  }

  if(!level.var_DD79) {
    return 0;
  }

  if(!isDefined(self.var_32D4)) {
    return 0;
  }

  if(!self.var_32D4) {
    return 0;
  }

  return 1;
}

func_4EAC() {
  return 0;
}

func_4EAB(param_00) {
  if(!func_4EAC()) {}
}