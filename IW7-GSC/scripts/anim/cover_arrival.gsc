/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\anim\cover_arrival.gsc
*********************************************/

main() {
  self endon("killanimscript");
  self endon("abort_approach");
  if(isDefined(self.var_4C7E)) {
    [[self.var_4C7E]]();
    return;
  }

  var_0 = self.var_20F0;
  var_1 = scripts\anim\utility::func_B027("cover_trans", self.var_20F2)[var_0];
  if(!isDefined(self.heat)) {
    thread func_1524();
  }

  self clearanim(%body, 0.2);
  self func_82EA("coverArrival", var_1, 1, 0.2, self.var_BD22);
  scripts\anim\face::playfacialanim(var_1, "run");
  scripts\anim\shared::donotetracks("coverArrival", ::func_89EA);
  var_2 = level.var_22E7[self.var_20F2];
  if(isDefined(var_2)) {
    self.a.pose = var_2;
  }

  self.a.movement = "stop";
  self.a.var_22F5 = self.var_20F2;
  self clearanim(%root, 0.3);
  self.var_A93C = undefined;
}

func_89EA(var_0) {
  if(var_0 == "start_aim") {
    if(self.a.pose == "stand") {
      scripts\anim\animset::func_F2BE();
    } else if(self.a.pose == "crouch") {
      scripts\anim\animset::func_F2B6();
    }

    scripts\anim\combat::func_F296();
    self.var_D8AF = 0;
    scripts\anim\combat_utility::func_FA8C(0);
    thread scripts\anim\track::func_11B07();
  }
}

func_9FA5() {
  if(!isDefined(self.node)) {
    return 0;
  }

  if(isDefined(self.enemy) && self seerecently(self.enemy, 1.5) && distancesquared(self.origin, self.enemy.origin) < 250000) {
    return !self func_8199();
  }

  return 0;
}

func_1524() {
  self endon("killanimscript");
  for(;;) {
    if(!isDefined(self.node)) {
      return;
    }

    if(func_9FA5()) {
      self clearanim(%root, 0.3);
      self notify("abort_approach");
      self.var_A93C = gettime();
      return;
    }

    wait(0.1);
  }
}

func_393C(var_0) {
  if(!scripts\anim\utility_common::usingmg()) {
    return 0;
  }

  if(!isDefined(var_0.var_12A72)) {
    return 0;
  }

  if(var_0.type != "Cover Stand" && var_0.type != "Cover Prone" && var_0.type != "Cover Crouch") {
    return 0;
  }

  if(isDefined(self.enemy) && distancesquared(self.enemy.origin, var_0.origin) < 65536) {
    return 0;
  }

  if(scripts\anim\utility_common::getnodeyawtoenemy() > 40 || scripts\anim\utility_common::getnodeyawtoenemy() < -40) {
    return 0;
  }

  return 1;
}

func_53C6(var_0) {
  var_1 = var_0.type;
  if(func_393C(var_0)) {
    if(var_1 == "Cover Stand") {
      return "stand_saw";
    }

    if(var_1 == "Cover Crouch") {
      return "crouch_saw";
    } else if(var_1 == "Cover Prone") {
      return "prone_saw";
    }
  }

  if(!isDefined(level.var_20EB[var_1])) {
    return;
  }

  if(isDefined(var_0.var_22EF)) {
    var_2 = var_0.var_22EF;
  } else {
    var_2 = var_1 gethighestnodestance();
  }

  if(var_2 == "prone") {
    var_2 = "crouch";
  }

  var_3 = level.var_20EB[var_1][var_2];
  if(func_130C9() && var_3 == "exposed") {
    var_3 = "exposed_ready";
  }

  if(scripts\anim\utility::func_FFDB()) {
    var_4 = var_3 + "_cqb";
    if(isDefined(level.archetypes["soldier"]["cover_trans"][var_4])) {
      var_3 = var_4;
    }
  }

  return var_3;
}

func_53C4(var_0) {
  if(isDefined(self.heat)) {
    return "heat";
  }

  if(isDefined(var_0.var_22EF)) {
    var_1 = var_0.var_22EF;
  } else {
    var_1 = var_1 gethighestnodestance();
  }

  if(var_1 == "prone") {
    var_1 = "crouch";
  }

  if(var_1 == "crouch") {
    var_2 = "exposed_crouch";
  } else {
    var_2 = "exposed";
  }

  if(var_2 == "exposed" && func_130C9()) {
    var_2 = var_2 + "_ready";
  }

  if(scripts\anim\utility::func_FFDB()) {
    return var_2 + "_cqb";
  }

  return var_2;
}

func_3719(var_0, var_1) {
  var_2 = anglestoright(var_0);
  var_3 = anglesToForward(var_0);
  return var_3 * var_1[0] + var_2 * 0 - var_1[1];
}

func_7DCB() {
  if(isDefined(self.physics_querypoint)) {
    return self.physics_querypoint;
  }

  if(isDefined(self.node)) {
    return self.node;
  }

  return undefined;
}

func_7DCC(var_0, var_1) {
  if(var_1 == "stand_saw") {
    var_2 = (var_0.var_12A72.origin[0], var_0.var_12A72.origin[1], var_0.origin[2]);
    var_3 = anglesToForward((0, var_0.var_12A72.angles[1], 0));
    var_4 = anglestoright((0, var_0.var_12A72.angles[1], 0));
    var_2 = var_2 + var_3 * -32.545 - var_4 * 6.899;
  } else if(var_2 == "crouch_saw") {
    var_2 = (var_1.var_12A72.origin[0], var_1.var_12A72.origin[1], var_1.origin[2]);
    var_3 = anglesToForward((0, var_0.var_12A72.angles[1], 0));
    var_4 = anglestoright((0, var_0.var_12A72.angles[1], 0));
    var_2 = var_2 + var_3 * -32.545 - var_4 * 6.899;
  } else if(var_2 == "prone_saw") {
    var_2 = (var_1.var_12A72.origin[0], var_1.var_12A72.origin[1], var_1.origin[2]);
    var_3 = anglesToForward((0, var_0.var_12A72.angles[1], 0));
    var_4 = anglestoright((0, var_0.var_12A72.angles[1], 0));
    var_2 = var_2 + var_3 * -37.36 - var_4 * 13.279;
  } else if(isDefined(self.physics_querypoint)) {
    var_2 = self.objective_playermask_hidefromall;
  } else {
    var_2 = var_1.origin;
  }

  return var_2;
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

func_3DEC(var_0, var_1, var_2) {
  if(isDefined(level.var_6A1B[var_0])) {
    return 0;
  }

  if(var_0 == "stand" || var_0 == "crouch") {
    if(scripts\engine\utility::absangleclamp180(vectortoyaw(var_1) - var_2.angles[1] + 180) < 60) {
      return 0;
    }
  }

  if(func_9FA5() || isDefined(self.var_A93C) && self.var_A93C + 500 > gettime()) {
    return 0;
  }

  return 1;
}

func_FA90(var_0) {
  self endon("killanimscript");
  if(isDefined(self.heat)) {
    thread func_58E7();
    return;
  }

  if(var_0) {
    self.print3d = 1;
  }

  self.a.var_22F5 = undefined;
  thread func_58E7();
  self waittill("cover_approach", var_1);
  if(!func_3DED()) {
    return;
  }

  thread func_FA90(0);
  var_2 = "exposed";
  var_3 = self.vehicle_getspawnerarray;
  var_4 = vectortoyaw(var_1);
  var_5 = var_4;
  var_6 = func_7DCB();
  if(isDefined(var_6)) {
    var_2 = func_53C6(var_6);
    if(isDefined(var_2) && var_2 != "exposed") {
      var_3 = func_7DCC(var_6, var_2);
      var_4 = var_6.angles[1];
      var_5 = scripts\asm\shared_utility::getnodeforwardyaw(var_6);
    }
  } else if(func_130C9()) {
    if(scripts\anim\utility::func_FFDB()) {
      var_2 = "exposed_ready_cqb";
    } else {
      var_2 = "exposed_ready";
    }
  }

  if(!isDefined(var_2)) {
    return;
  }

  if(!func_3DEC(var_2, var_1, var_6)) {
    return;
  }

  func_10D80(var_2, var_3, var_4, var_5, var_1);
}

func_4710(var_0, var_1, var_2, var_3, var_4) {
  if(isDefined(self.disablearrivals) && self.disablearrivals) {
    return 0;
  }

  if(abs(self getspawnpoint_searchandrescue()) > 45 && isDefined(self.enemy) && vectordot(anglesToForward(self.angles), vectornormalize(self.enemy.origin - self.origin)) > 0.8) {
    return 0;
  }

  if(self.a.pose != "stand" || self.a.movement != "run" && !scripts\anim\utility::func_9D9C()) {
    return 0;
  }

  if(scripts\engine\utility::absangleclamp180(var_4 - self.angles[1]) > 30) {
    if(isDefined(self.enemy) && self cansee(self.enemy) && distancesquared(self.origin, self.enemy.origin) < 65536) {
      if(vectordot(anglesToForward(self.angles), self.enemy.origin - self.origin) > 0) {
        return 0;
      }
    }
  }

  if(!func_3E00(var_0, var_1, var_2, var_3, 0)) {
    return 0;
  }

  return 1;
}

func_20F4(var_0, var_1) {
  if(!isDefined(var_0)) {
    return;
  }

  for(;;) {
    if(!isDefined(self.vehicle_getspawnerarray)) {
      func_136CD();
    }

    var_2 = distance(self.origin, self.vehicle_getspawnerarray);
    if(var_2 <= var_1 + 8) {
      break;
    }

    var_3 = var_2 - var_1 / 250 - 0.1;
    if(var_3 < 0.05) {
      var_3 = 0.05;
    }

    wait(var_3);
  }
}

func_10D80(var_0, var_1, var_2, var_3, var_4) {
  self endon("killanimscript");
  self endon("cover_approach");
  var_5 = func_7DCB();
  var_6 = scripts\anim\exit_node::getmaxdamage(var_5);
  var_7 = var_6.var_B490;
  var_8 = var_6.var_68CA;
  var_9 = vectordot(var_4, anglesToForward(var_5.angles)) >= 0;
  var_6 = func_3DEE(var_1, var_3, var_0, var_4, var_7, var_8, var_9);
  if(var_6.var_20F0 < 0) {
    return;
  }

  var_10 = var_6.var_20F0;
  if(var_10 <= 6 && var_9) {
    self endon("goal_changed");
    self.var_22F0 = level.var_4754[var_0];
    func_20F4(var_5, self.var_22F0);
    var_11 = vectornormalize(var_1 - self.origin);
    var_6 = func_3DEE(var_1, var_3, var_0, var_11, var_7, var_8, var_9);
    self.var_22F0 = length(scripts\anim\utility::func_B031("cover_trans_dist", var_0, var_10));
    func_20F4(var_5, self.var_22F0);
    if(!self maymovetopoint(var_1)) {
      self.var_22F0 = undefined;
      return;
    }

    if(var_6.var_20F0 < 0) {
      self.var_22F0 = undefined;
      return;
    }

    var_10 = var_6.var_20F0;
    var_12 = var_3 - scripts\anim\utility::func_B031("cover_trans_angles", var_0, var_10);
  } else {
    self give_smack_perk(self.var_4718);
    self waittill("runto_arrived");
    var_12 = var_4 - scripts\anim\utility::func_B031("cover_trans_angles", var_1, var_12);
    if(!func_4710(var_1, var_3, var_0, var_10, var_12)) {
      return;
    }
  }

  self.var_20F0 = var_10;
  self.var_20F2 = var_0;
  self.var_22F0 = undefined;
  self func_8396(self.var_4718, var_12);
}

func_3DEE(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = spawnStruct();
  scripts\anim\exit_node::func_371A(var_7, var_2, 1, var_1, var_3, var_4, var_5);
  scripts\anim\exit_node::func_1043F(var_7, var_4);
  var_8 = spawnStruct();
  var_9 = (0, 0, 0);
  var_8.var_20F0 = -1;
  var_10 = 2;
  for(var_11 = 1; var_11 <= var_10; var_11++) {
    var_8.var_20F0 = var_7.var_12654[var_11];
    if(!func_3E00(var_0, var_1, var_2, var_8.var_20F0, var_6)) {
      continue;
    }

    break;
  }

  if(var_11 > var_10) {
    var_8.var_20F0 = -1;
    return var_8;
  }

  var_12 = distancesquared(var_0, self.origin);
  var_13 = distancesquared(var_0, self.var_4718);
  if(var_12 < var_13 * 2 * 2) {
    if(var_12 < var_13) {
      var_8.var_20F0 = -1;
      return var_8;
    }

    if(!var_6) {
      var_14 = vectornormalize(self.var_4718 - self.origin);
      var_15 = var_1 - scripts\anim\utility::func_B031("cover_trans_angles", var_2, var_8.var_20F0);
      var_10 = anglesToForward((0, var_15, 0));
      var_11 = vectordot(var_14, var_10);
      if(var_11 < 0.707) {
        var_8.var_20F0 = -1;
        return var_8;
      }
    }
  }

  return var_8;
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
      scripts\engine\utility::waittill_any("goal_changed", "goal_changed_previous_frame");
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

func_6A0E(var_0, var_1) {
  if(!isDefined(self.vehicle_getspawnerarray)) {
    return 0;
  }

  if(isDefined(self.disablearrivals) && self.disablearrivals) {
    return 0;
  }

  if(isDefined(self.var_20ED)) {
    if(!self[[self.var_20ED]](var_0)) {
      return 0;
    }
  } else {
    if(!self.livestreamingenable && !isDefined(var_0) || var_0.type == "Path" || var_0.type == "Path 3D") {
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

    var_0 = func_7DCB();
    if(isDefined(var_0) && !isDefined(self.heat)) {
      var_1 = var_0.origin;
    } else {
      var_1 = self.vehicle_getspawnerarray;
    }

    var_2 = distance(self.origin, var_1);
    var_3 = level.var_AFE8;
    if(var_2 <= var_3 + 8) {
      break;
    }

    var_4 = var_2 - level.var_AFE8 / 250 - 0.1;
    if(var_4 < 0) {
      break;
    }

    if(var_4 < 0.05) {
      var_4 = 0.05;
    }

    wait(var_4);
  }
}

func_6A6D(var_0) {
  if(!isDefined(self.enemy)) {
    return 0;
  }

  if(isDefined(self.heat) && isDefined(var_0)) {
    return 0;
  }

  if(self.var_BC == "cover" && issentient(self.enemy) && gettime() - self lastknowntime(self.enemy) > 15000) {
    return 0;
  }

  return sighttracepassed(self.enemy getshootatpos(), self.vehicle_getspawnerarray + (0, 0, 60), 0, undefined);
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

  var_0 = "exposed";
  var_1 = 1;
  if(isDefined(self.var_20F3)) {
    var_0 = self[[self.var_20F3]]();
  } else if(func_130C9()) {
    if(scripts\anim\utility::func_FFDB()) {
      var_0 = "exposed_ready_cqb";
    } else {
      var_0 = "exposed_ready";
    }
  } else if(scripts\anim\utility::func_FFDB()) {
    var_0 = "exposed_cqb";
  } else if(isDefined(self.heat)) {
    var_0 = "heat";
    var_1 = 4096;
  }

  var_2 = func_7DCB();
  if(isDefined(var_2) && isDefined(self.vehicle_getspawnerarray) && !isDefined(self.disablecollision)) {
    var_3 = distancesquared(self.vehicle_getspawnerarray, var_2.origin) < var_1;
  } else {
    var_3 = 0;
  }

  if(var_3) {
    var_0 = func_53C4(var_2);
  }

  var_4 = vectornormalize(self.vehicle_getspawnerarray - self.origin);
  var_5 = vectortoyaw(var_4);
  if(isDefined(self.var_6A6C)) {
    var_5 = self.angles[1];
  } else if(func_6A6D(var_2)) {
    var_5 = vectortoyaw(self.enemy.origin - self.vehicle_getspawnerarray);
  } else {
    var_6 = isDefined(var_2) && var_3;
    var_6 = var_6 && var_2.type != "Path" && var_2.type != "Path 3D" && var_2.type != "Ambush" || !scripts\anim\utility_common::recentlysawenemy();
    if(var_6) {
      var_5 = scripts\asm\shared_utility::getnodeforwardyaw(var_2);
    } else {
      var_7 = self getsafeanimmovedeltapercentage();
      if(isDefined(var_7)) {
        var_5 = var_7[1];
      }
    }
  }

  var_8 = spawnStruct();
  scripts\anim\exit_node::func_371A(var_8, var_0, 1, var_5, var_4, 9, -1);
  var_9 = 1;
  for(var_10 = 2; var_10 <= 9; var_10++) {
    if(var_8.transitions[var_10] > var_8.transitions[var_9]) {
      var_9 = var_10;
    }
  }

  self.var_20F0 = var_8.var_12654[var_9];
  self.var_20F2 = var_0;
  var_11 = scripts\anim\utility::func_B031("cover_trans", var_0, self.var_20F0);
  var_12 = length(scripts\anim\utility::func_B031("cover_trans_dist", var_0, self.var_20F0));
  var_13 = var_12 + 8;
  var_13 = var_13 * var_13;
  while(isDefined(self.vehicle_getspawnerarray) && distancesquared(self.origin, self.vehicle_getspawnerarray) > var_13) {
    wait(0.05);
  }

  if(isDefined(self.var_22F0) && self.var_22F0 < var_12 + 8) {
    return;
  }

  if(!func_6A0E(var_2, var_3)) {
    return;
  }

  var_14 = distance(self.origin, self.vehicle_getspawnerarray);
  if(abs(var_14 - var_12) > 8) {
    return;
  }

  var_15 = vectortoyaw(self.vehicle_getspawnerarray - self.origin);
  if(isDefined(self.heat) && var_3) {
    var_10 = var_5 - scripts\anim\utility::func_B031("cover_trans_angles", var_0, self.var_20F0);
    var_11 = func_7DD9(self.vehicle_getspawnerarray, var_5, var_0, self.var_20F0);
  } else if(var_14 > 0) {
    var_12 = scripts\anim\utility::func_B031("cover_trans_dist", var_2, self.var_20F0);
    var_13 = atan(var_12[1] / var_12[0]);
    if(!isDefined(self.var_6A6C) || self.livestreamingenable) {
      var_10 = var_15 - var_13;
      if(scripts\engine\utility::absangleclamp180(var_10 - self.angles[1]) > 30) {
        return;
      }
    } else {
      var_10 = self.angles[1];
    }

    var_14 = var_14 - var_12;
    var_11 = self.origin + vectornormalize(self.vehicle_getspawnerarray - self.origin) * var_14;
  } else {
    var_10 = self.angles[1];
    var_11 = self.origin;
  }

  self func_8396(var_11, var_10);
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
  self func_82E4("move", self.var_10DCB, %root, 1);
  scripts\anim\face::playfacialanim(self.var_10DCB, "run");
  if(animhasnotetrack(self.var_10DCB, "code_move")) {
    scripts\anim\shared::donotetracks("move");
    self orientmode("face motion");
    self animmode("none", 0);
  }

  scripts\anim\shared::donotetracks("move");
}

func_110CC(var_0) {
  if(!isDefined(var_0)) {
    return "{undefined}";
  }

  return var_0;
}

func_5B8D(var_0, var_1, var_2, var_3) {
  for(var_4 = 0; var_4 < var_2 * 100; var_4++) {
    wait(0.05);
  }
}

func_5B6C(var_0) {
  self endon("killanimscript");
  for(;;) {
    if(!isDefined(self.node)) {
      break;
    }

    wait(0.05);
  }
}

func_7DD9(var_0, var_1, var_2, var_3) {
  var_4 = (0, var_1 - scripts\anim\utility::func_B031("cover_trans_angles", var_2, var_3), 0);
  var_5 = anglesToForward(var_4);
  var_6 = anglestoright(var_4);
  var_7 = scripts\anim\utility::func_B031("cover_trans_dist", var_2, var_3);
  var_8 = var_5 * var_7[0];
  var_9 = var_6 * var_7[1];
  return var_0 - var_8 + var_9;
}

func_7DD8(var_0, var_1, var_2, var_3) {
  var_4 = (0, var_1 - scripts\anim\utility::func_B031("cover_trans_angles", var_2, var_3), 0);
  var_5 = anglesToForward(var_4);
  var_6 = anglestoright(var_4);
  var_7 = scripts\anim\utility::func_B031("cover_trans_predist", var_2, var_3);
  var_8 = var_5 * var_7[0];
  var_9 = var_6 * var_7[1];
  return var_0 - var_8 + var_9;
}

func_3E00(var_0, var_1, var_2, var_3, var_4) {
  var_5 = func_7DD9(var_0, var_1, var_2, var_3);
  self.var_4718 = var_5;
  if(var_3 <= 6 && var_4) {
    return 1;
  }

  if(!self maymovefrompointtopoint(var_5, var_0)) {
    return 0;
  }

  if(var_3 <= 6 || isDefined(level.var_6A1B[var_2])) {
    return 1;
  }

  var_6 = func_7DD8(var_5, var_1, var_2, var_3);
  self.var_4718 = var_6;
  return self maymovefrompointtopoint(var_6, var_5);
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

func_4EAB(var_0) {
  if(!func_4EAC()) {}
}