/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\anim\exit_node.gsc
*********************************************/

func_10DCA() {
  if(isDefined(self.custommovetransition)) {
    custommovetransition();
    return;
  }

  self endon("killanimscript");
  if(!func_3E57()) {
    return;
  }

  var_0 = self.origin;
  var_1 = self.angles[1];
  var_2 = "exposed";
  var_3 = 0;
  var_4 = func_7EA3();
  if(isDefined(var_4)) {
    var_5 = func_53C7(var_4);
    if(isDefined(var_5)) {
      var_2 = var_5;
      var_3 = 1;
      if(isDefined(self.heat)) {
        var_2 = func_53C5(var_4, var_2);
      }

      if(!isDefined(level.var_6A1B[var_2]) && var_2 != "stand_saw" && var_2 != "crouch_saw") {
        var_6 = scripts\engine\utility::absangleclamp180(self.angles[1] - scripts\asm\shared_utility::getnodeforwardyaw(var_4));
        if(var_6 < 5) {
          if(!isDefined(self.heat)) {
            var_0 = var_4.origin;
          }

          var_1 = scripts\asm\shared_utility::getnodeforwardyaw(var_4);
        }
      }
    }
  }

  if(!func_3E56(var_2, var_4)) {
    return;
  }

  var_7 = isDefined(level.var_6A1B[var_2]);
  if(!var_3) {
    var_2 = func_53C8();
  }

  var_8 = (-1 * self.setocclusionpreset[0], -1 * self.setocclusionpreset[1], 0);
  var_9 = getmaxdamage(var_4);
  var_10 = var_9.var_B490;
  var_11 = var_9.var_68CA;
  var_12 = spawnStruct();
  func_371A(var_12, var_2, 0, var_1, var_8, var_10, var_11);
  func_1043F(var_12, var_10);
  var_13 = -1;
  var_14 = 3;
  if(var_7) {
    var_14 = 1;
  }

  for(var_15 = 1; var_15 <= var_14; var_15++) {
    var_13 = var_12.var_12654[var_15];
    if(func_3E2C(var_0, var_1, var_2, var_7, var_13)) {
      break;
    }
  }

  if(var_15 > var_14) {
    return;
  }

  var_10 = distancesquared(self.origin, self.var_471C) * 1.25 * 1.25;
  if(distancesquared(self.origin, self.vehicle_getspawnerarray) < var_10) {
    return;
  }

  func_5926(var_2, var_13);
}

func_53C7(var_0) {
  if(scripts\anim\cover_arrival::func_393C(var_0)) {
    if(var_0.type == "Cover Stand") {
      return "stand_saw";
    }

    if(var_0.type == "Cover Crouch") {
      return "crouch_saw";
    } else if(var_0.type == "Cover Prone") {
      return "prone_saw";
    }
  }

  if(!isDefined(level.var_20EB[var_0.type])) {
    return;
  }

  if(isDefined(level.var_E1B7[var_0.type]) && level.var_E1B7[var_0.type] != self.a.pose) {
    return;
  }

  var_1 = self.a.pose;
  if(var_1 == "prone") {
    var_1 = "crouch";
  }

  var_2 = level.var_20EB[var_0.type][var_1];
  if(scripts\anim\cover_arrival::func_130C9() && var_2 == "exposed") {
    var_2 = "exposed_ready";
  }

  if(scripts\anim\utility::func_FFDB()) {
    var_3 = var_2 + "_cqb";
    if(isDefined(level.archetypes["soldier"]["cover_exit"][var_3])) {
      var_2 = var_3;
    }
  }

  return var_2;
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

func_3E56(var_0, var_1) {
  if(!isDefined(var_0)) {
    return 0;
  }

  if(var_0 == "exposed" || isDefined(self.heat)) {
    if(self.a.pose != "stand" && self.a.pose != "crouch") {
      return 0;
    }

    if(self.a.movement != "stop") {
      return 0;
    }
  }

  if(!isDefined(self.heat) && isDefined(self.enemy) && vectordot(self.setocclusionpreset, self.enemy.origin - self.origin) < 0) {
    if(scripts\anim\utility_common::canseeenemyfromexposed() && distancesquared(self.origin, self.enemy.origin) < 90000) {
      return 0;
    }
  }

  return 1;
}

func_53C8(var_0) {
  if(self.a.pose == "stand") {
    var_0 = "exposed";
  } else {
    var_0 = "exposed_crouch";
  }

  if(scripts\anim\cover_arrival::func_130C9()) {
    var_0 = "exposed_ready";
  }

  if(scripts\anim\utility::func_FFDB()) {
    var_0 = var_0 + "_cqb";
  } else if(isDefined(self.heat)) {
    var_0 = "heat";
  }

  return var_0;
}

getmaxdamage(var_0) {
  var_1 = spawnStruct();
  if(isDefined(var_0) && isDefined(level.var_B490[var_0.type])) {
    var_1.var_B490 = level.var_B490[var_0.type];
    var_1.var_68CA = level.var_68CA[var_0.type];
  } else {
    var_1.var_B490 = 9;
    var_1.var_68CA = -1;
  }

  return var_1;
}

func_371A(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_0.transitions = [];
  var_0.var_12654 = [];
  var_7 = undefined;
  var_8 = 1;
  var_9 = 0;
  if(var_2) {
    var_7 = scripts\anim\utility::func_B027("cover_trans_angles", var_1);
    var_8 = -1;
    var_9 = 0;
  } else {
    var_7 = scripts\anim\utility::func_B027("cover_exit_angles", var_1);
    var_8 = 1;
    var_9 = 180;
  }

  for(var_10 = 1; var_10 <= var_5; var_10++) {
    var_0.var_12654[var_10] = var_10;
    if(var_10 == 5 || var_10 == var_6 || !isDefined(var_7[var_10])) {
      var_0.transitions[var_10] = -1.0003;
      continue;
    }

    var_11 = (0, var_3 + var_8 * var_7[var_10] + var_9, 0);
    var_12 = vectornormalize(anglesToForward(var_11));
    var_0.transitions[var_10] = vectordot(var_4, var_12);
  }
}

func_1043F(var_0, var_1) {
  for(var_2 = 2; var_2 <= var_1; var_2++) {
    var_3 = var_0.transitions[var_0.var_12654[var_2]];
    var_4 = var_0.var_12654[var_2];
    for(var_5 = var_2 - 1; var_5 >= 1; var_5--) {
      if(var_3 < var_0.transitions[var_0.var_12654[var_5]]) {
        break;
      }

      var_0.var_12654[var_5 + 1] = var_0.var_12654[var_5];
    }

    var_0.var_12654[var_5 + 1] = var_4;
  }
}

func_3E2C(var_0, var_1, var_2, var_3, var_4) {
  var_5 = (0, var_1, 0);
  var_6 = anglesToForward(var_5);
  var_7 = anglestoright(var_5);
  var_8 = scripts\anim\utility::func_B031("cover_exit_dist", var_2, var_4);
  var_9 = var_6 * var_8[0];
  var_10 = var_7 * var_8[1];
  var_11 = var_0 + var_9 - var_10;
  self.var_471C = var_11;
  if(!var_3 && !self func_8068(var_11)) {
    return 0;
  }

  if(!self maymovefrompointtopoint(self.origin, var_11)) {
    return 0;
  }

  if(var_4 <= 6 || var_3) {
    return 1;
  }

  var_12 = scripts\anim\utility::func_B031("cover_exit_postdist", var_2, var_4);
  var_9 = var_6 * var_12[0];
  var_10 = var_7 * var_12[1];
  var_13 = var_11 + var_9 - var_10;
  self.var_471C = var_13;
  return self maymovefrompointtopoint(var_11, var_13);
}

func_5926(var_0, var_1) {
  var_2 = scripts\anim\utility::func_B031("cover_exit", var_0, var_1);
  var_3 = vectortoangles(self.setocclusionpreset);
  if(self.a.pose == "prone") {
    return;
  }

  var_5 = 0.2;
  if(scripts\engine\utility::actor_is3d()) {
    self animmode("nogravity", 0);
  } else {
    self animmode("zonly_physics", 0);
  }

  self orientmode("face angle", self.angles[1]);
  self func_82E4("coverexit", var_2, %body, 1, var_5, self.var_BD22);
  scripts\anim\shared::donotetracks("coverexit");
  self.a.pose = "stand";
  self.a.movement = "run";
  self.var_932E = undefined;
  self orientmode("face motion");
  self animmode("none", 0);
  func_6CD5("coverexit");
  self clearanim(%root, 0.2);
  self orientmode("face default");
  self animmode("normal", 0);
}

func_6CD5(var_0) {
  self endon("move_loop_restart");
  scripts\anim\shared::donotetracks(var_0);
}

func_53C5(var_0, var_1) {
  if(var_0.type == "Cover Right") {
    var_1 = "heat_right";
  } else if(var_0.type == "Cover Left") {
    var_1 = "heat_left";
  }

  return var_1;
}

func_7EA3() {
  var_0 = undefined;
  var_1 = 400;
  if(scripts\engine\utility::actor_is3d()) {
    var_1 = 1024;
  } else if(isDefined(self.heat)) {
    var_1 = 4096;
  }

  if(isDefined(self.node) && distancesquared(self.origin, self.node.origin) < var_1) {
    var_0 = self.node;
  } else if(isDefined(self.weaponmaxdist) && distancesquared(self.origin, self.weaponmaxdist.origin) < var_1) {
    var_0 = self.weaponmaxdist;
  }

  if(isDefined(self.heat) && !scripts\engine\utility::actor_is3d()) {
    if(isDefined(var_0) && scripts\engine\utility::absangleclamp180(self.angles[1] - var_0.angles[1]) > 30) {
      return undefined;
    }
  }

  return var_0;
}

custommovetransition() {
  var_0 = self.custommovetransition;
  if(!isDefined(self.perm_on)) {
    self.custommovetransition = undefined;
  }

  var_1 = [[var_0]]();
  if(!isDefined(self.perm_on)) {
    self.var_10DCB = undefined;
  }

  if(!isDefined(var_1)) {
    var_1 = 0.2;
  }

  self clearanim(%root, var_1);
  self orientmode("face default");
  self animmode("none", 0);
}

func_4EAB(var_0) {
  if(!scripts\anim\cover_arrival::func_4EAC()) {}
}