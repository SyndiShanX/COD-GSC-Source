/**************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\anim\exit_node.gsc
**************************************/

func_10DCA() {
  if(isDefined(self.custommovetransition)) {
    custommovetransition();
    return;
  }

  self endon("killanimscript");
  if(!func_3E57()) {
    return;
  }

  var_00 = self.origin;
  var_01 = self.angles[1];
  var_02 = "exposed";
  var_03 = 0;
  var_04 = func_7EA3();
  if(isDefined(var_04)) {
    var_05 = func_53C7(var_04);
    if(isDefined(var_05)) {
      var_02 = var_05;
      var_03 = 1;
      if(isDefined(self.heat)) {
        var_02 = func_53C5(var_04, var_02);
      }

      if(!isDefined(level.var_6A1B[var_02]) && var_02 != "stand_saw" && var_02 != "crouch_saw") {
        var_06 = scripts\engine\utility::absangleclamp180(self.angles[1] - scripts\asm\shared_utility::getnodeforwardyaw(var_04));
        if(var_06 < 5) {
          if(!isDefined(self.heat)) {
            var_00 = var_04.origin;
          }

          var_01 = scripts\asm\shared_utility::getnodeforwardyaw(var_04);
        }
      }
    }
  }

  if(!func_3E56(var_02, var_04)) {
    return;
  }

  var_07 = isDefined(level.var_6A1B[var_02]);
  if(!var_03) {
    var_02 = func_53C8();
  }

  var_08 = (-1 * self.setocclusionpreset[0], -1 * self.setocclusionpreset[1], 0);
  var_09 = getmaxdamage(var_04);
  var_0A = var_09.var_B490;
  var_0B = var_09.var_68CA;
  var_0C = spawnStruct();
  func_371A(var_0C, var_02, 0, var_01, var_08, var_0A, var_0B);
  func_1043F(var_0C, var_0A);
  var_0D = -1;
  var_0E = 3;
  if(var_07) {
    var_0E = 1;
  }

  for(var_0F = 1; var_0F <= var_0E; var_0F++) {
    var_0D = var_0C.var_12654[var_0F];
    if(func_3E2C(var_00, var_01, var_02, var_07, var_0D)) {
      break;
    }
  }

  if(var_0F > var_0E) {
    return;
  }

  var_10 = distancesquared(self.origin, self.var_471C) * 1.25 * 1.25;
  if(distancesquared(self.origin, self.vehicle_getspawnerarray) < var_10) {
    return;
  }

  func_5926(var_02, var_0D);
}

func_53C7(param_00) {
  if(scripts\anim\cover_arrival::func_393C(param_00)) {
    if(param_00.type == "Cover Stand") {
      return "stand_saw";
    }

    if(param_00.type == "Cover Crouch") {
      return "crouch_saw";
    } else if(param_00.type == "Cover Prone") {
      return "prone_saw";
    }
  }

  if(!isDefined(level.var_20EB[param_00.type])) {
    return;
  }

  if(isDefined(level.var_E1B7[param_00.type]) && level.var_E1B7[param_00.type] != self.a.pose) {
    return;
  }

  var_01 = self.a.pose;
  if(var_01 == "prone") {
    var_01 = "crouch";
  }

  var_02 = level.var_20EB[param_00.type][var_01];
  if(scripts\anim\cover_arrival::func_130C9() && var_02 == "exposed") {
    var_02 = "exposed_ready";
  }

  if(scripts\anim\utility::func_FFDB()) {
    var_03 = var_02 + "_cqb";
    if(isDefined(level.archetypes["soldier"]["cover_exit"][var_03])) {
      var_02 = var_03;
    }
  }

  return var_02;
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

  if(distancesquared(self.origin, self.vehicle_getspawnerarray) < 10000) {
    return 0;
  }

  return 1;
}

func_3E56(param_00, param_01) {
  if(!isDefined(param_00)) {
    return 0;
  }

  if(param_00 == "exposed" || isDefined(self.heat)) {
    if(self.a.pose != "stand" && self.a.pose != "crouch") {
      return 0;
    }

    if(self.a.movement != "stop") {
      return 0;
    }
  }

  if(!isDefined(self.heat) && isDefined(self.isnodeoccupied) && vectordot(self.setocclusionpreset, self.isnodeoccupied.origin - self.origin) < 0) {
    if(scripts\anim\utility_common::canseeenemyfromexposed() && distancesquared(self.origin, self.isnodeoccupied.origin) < 90000) {
      return 0;
    }
  }

  return 1;
}

func_53C8(param_00) {
  if(self.a.pose == "stand") {
    param_00 = "exposed";
  } else {
    param_00 = "exposed_crouch";
  }

  if(scripts\anim\cover_arrival::func_130C9()) {
    param_00 = "exposed_ready";
  }

  if(scripts\anim\utility::func_FFDB()) {
    param_00 = param_00 + "_cqb";
  } else if(isDefined(self.heat)) {
    param_00 = "heat";
  }

  return param_00;
}

getmaxdamage(param_00) {
  var_01 = spawnStruct();
  if(isDefined(param_00) && isDefined(level.var_B490[param_00.type])) {
    var_01.var_B490 = level.var_B490[param_00.type];
    var_01.var_68CA = level.var_68CA[param_00.type];
  } else {
    var_01.var_B490 = 9;
    var_01.var_68CA = -1;
  }

  return var_01;
}

func_371A(param_00, param_01, param_02, param_03, param_04, param_05, param_06) {
  param_00.transitions = [];
  param_00.var_12654 = [];
  var_07 = undefined;
  var_08 = 1;
  var_09 = 0;
  if(param_02) {
    var_07 = scripts\anim\utility::func_B027("cover_trans_angles", param_01);
    var_08 = -1;
    var_09 = 0;
  } else {
    var_07 = scripts\anim\utility::func_B027("cover_exit_angles", param_01);
    var_08 = 1;
    var_09 = 180;
  }

  for(var_0A = 1; var_0A <= param_05; var_0A++) {
    param_00.var_12654[var_0A] = var_0A;
    if(var_0A == 5 || var_0A == param_06 || !isDefined(var_07[var_0A])) {
      param_00.transitions[var_0A] = -1.0003;
      continue;
    }

    var_0B = (0, param_03 + var_08 * var_07[var_0A] + var_09, 0);
    var_0C = vectornormalize(anglesToForward(var_0B));
    param_00.transitions[var_0A] = vectordot(param_04, var_0C);
  }
}

func_1043F(param_00, param_01) {
  for(var_02 = 2; var_02 <= param_01; var_02++) {
    var_03 = param_00.transitions[param_00.var_12654[var_02]];
    var_04 = param_00.var_12654[var_02];
    for(var_05 = var_02 - 1; var_05 >= 1; var_05--) {
      if(var_03 < param_00.transitions[param_00.var_12654[var_05]]) {
        break;
      }

      param_00.var_12654[var_05 + 1] = param_00.var_12654[var_05];
    }

    param_00.var_12654[var_05 + 1] = var_04;
  }
}

func_3E2C(param_00, param_01, param_02, param_03, param_04) {
  var_05 = (0, param_01, 0);
  var_06 = anglesToForward(var_05);
  var_07 = anglestoright(var_05);
  var_08 = scripts\anim\utility::func_B031("cover_exit_dist", param_02, param_04);
  var_09 = var_06 * var_08[0];
  var_0A = var_07 * var_08[1];
  var_0B = param_00 + var_09 - var_0A;
  self.var_471C = var_0B;
  if(!param_03 && !self _meth_8068(var_0B)) {
    return 0;
  }

  if(!self maymovefrompointtopoint(self.origin, var_0B)) {
    return 0;
  }

  if(param_04 <= 6 || param_03) {
    return 1;
  }

  var_0C = scripts\anim\utility::func_B031("cover_exit_postdist", param_02, param_04);
  var_09 = var_06 * var_0C[0];
  var_0A = var_07 * var_0C[1];
  var_0D = var_0B + var_09 - var_0A;
  self.var_471C = var_0D;
  return self maymovefrompointtopoint(var_0B, var_0D);
}

func_5926(param_00, param_01) {
  var_02 = scripts\anim\utility::func_B031("cover_exit", param_00, param_01);
  var_03 = vectortoangles(self.setocclusionpreset);
  if(self.a.pose == "prone") {
    return;
  }

  var_05 = 0.2;
  if(scripts\engine\utility::actor_is3d()) {
    self animmode("nogravity", 0);
  } else {
    self animmode("zonly_physics", 0);
  }

  self orientmode("face angle", self.angles[1]);
  self _meth_82E4("coverexit", var_02, % body, 1, var_05, self.var_BD22);
  scripts\anim\shared::donotetracks("coverexit");
  self.a.pose = "stand";
  self.a.movement = "run";
  self.var_932E = undefined;
  self orientmode("face motion");
  self animmode("none", 0);
  func_6CD5("coverexit");
  self clearanim( % root, 0.2);
  self orientmode("face default");
  self animmode("normal", 0);
}

func_6CD5(param_00) {
  self endon("move_loop_restart");
  scripts\anim\shared::donotetracks(param_00);
}

func_53C5(param_00, param_01) {
  if(param_00.type == "Cover Right") {
    param_01 = "heat_right";
  } else if(param_00.type == "Cover Left") {
    param_01 = "heat_left";
  }

  return param_01;
}

func_7EA3() {
  var_00 = undefined;
  var_01 = 400;
  if(scripts\engine\utility::actor_is3d()) {
    var_01 = 1024;
  } else if(isDefined(self.heat)) {
    var_01 = 4096;
  }

  if(isDefined(self.target_getindexoftarget) && distancesquared(self.origin, self.target_getindexoftarget.origin) < var_01) {
    var_00 = self.target_getindexoftarget;
  } else if(isDefined(self.weaponmaxdist) && distancesquared(self.origin, self.weaponmaxdist.origin) < var_01) {
    var_00 = self.weaponmaxdist;
  }

  if(isDefined(self.heat) && !scripts\engine\utility::actor_is3d()) {
    if(isDefined(var_00) && scripts\engine\utility::absangleclamp180(self.angles[1] - var_00.angles[1]) > 30) {
      return undefined;
    }
  }

  return var_00;
}

custommovetransition() {
  var_00 = self.custommovetransition;
  if(!isDefined(self.perm_on)) {
    self.custommovetransition = undefined;
  }

  var_01 = [[var_00]]();
  if(!isDefined(self.perm_on)) {
    self.var_10DCB = undefined;
  }

  if(!isDefined(var_01)) {
    var_01 = 0.2;
  }

  self clearanim( % root, var_01);
  self orientmode("face default");
  self animmode("none", 0);
}

func_4EAB(param_00) {
  if(!scripts\anim\cover_arrival::func_4EAC()) {}
}