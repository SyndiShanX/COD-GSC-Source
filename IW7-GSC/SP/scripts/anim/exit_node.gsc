/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\anim\exit_node.gsc
**************************************/

_id_10DCA() {
  if(isDefined(self.custommovetransition)) {
    custommovetransition();
    return;
  }

  self endon("killanimscript");

  if(!_id_3E57()) {
    return;
  }
  var_0 = self.origin;
  var_1 = self.angles[1];
  var_2 = "exposed";
  var_3 = 0;
  var_4 = _id_7EA3();

  if(isDefined(var_4)) {
    var_5 = _id_53C7(var_4);

    if(isDefined(var_5)) {
      var_2 = var_5;
      var_3 = 1;

      if(isDefined(self.heat))
        var_2 = _id_53C5(var_4, var_2);

      if(!isDefined(anim._id_6A1B[var_2]) && var_2 != "stand_saw" && var_2 != "crouch_saw") {
        var_6 = scripts\engine\utility::absangleclamp180(self.angles[1] - scripts\asm\shared\utility::getnodeforwardyaw(var_4));

        if(var_6 < 5) {
          if(!isDefined(self.heat))
            var_0 = var_4.origin;

          var_1 = scripts\asm\shared\utility::getnodeforwardyaw(var_4);
        }
      }
    }
  }

  if(!_id_3E56(var_2, var_4)) {
    return;
  }
  var_7 = isDefined(anim._id_6A1B[var_2]);

  if(!var_3)
    var_2 = _id_53C8();

  var_8 = (-1 * self.lookaheaddir[0], -1 * self.lookaheaddir[1], 0);
  var_9 = getmaxdamage(var_4);
  var_10 = var_9._id_B490;
  var_11 = var_9._id_68CA;
  var_12 = spawnStruct();
  _id_371A(var_12, var_2, 0, var_1, var_8, var_10, var_11);
  _id_1043F(var_12, var_10);
  var_13 = -1;
  var_14 = 3;

  if(var_7)
    var_14 = 1;

  for(var_15 = 1; var_15 <= var_14; var_15++) {
    var_13 = var_12._id_12654[var_15];

    if(_id_3E2C(var_0, var_1, var_2, var_7, var_13)) {
      break;
    }
  }

  if(var_15 > var_14) {
    return;
  }
  var_16 = distancesquared(self.origin, self._id_471C) * 1.25 * 1.25;

  if(distancesquared(self.origin, self.pathgoalpos) < var_16) {
    return;
  }
  _id_5926(var_2, var_13);
}

_id_53C7(var_0) {
  if(scripts\anim\cover_arrival::_id_393C(var_0)) {
    if(var_0.type == "Cover Stand")
      return "stand_saw";

    if(var_0.type == "Cover Crouch")
      return "crouch_saw";
    else if(var_0.type == "Cover Prone")
      return "prone_saw";
  }

  if(!isDefined(anim._id_20EB[var_0.type])) {
    return;
  }
  if(isDefined(anim._id_E1B7[var_0.type]) && anim._id_E1B7[var_0.type] != self.a.pose) {
    return;
  }
  var_1 = self.a.pose;

  if(var_1 == "prone")
    var_1 = "crouch";

  var_2 = anim._id_20EB[var_0.type][var_1];

  if(scripts\anim\cover_arrival::_id_130C9() && var_2 == "exposed")
    var_2 = "exposed_ready";

  if(scripts\anim\utility::_id_FFDB()) {
    var_3 = var_2 + "_cqb";

    if(isDefined(anim.archetypes["soldier"]["cover_exit"][var_3]))
      var_2 = var_3;
  }

  return var_2;
}

_id_3E57() {
  if(!isDefined(self.pathgoalpos))
    return 0;

  if(!self _meth_8380())
    return 0;

  if(self.a.pose == "prone")
    return 0;

  if(isDefined(self._id_55ED) && self._id_55ED)
    return 0;

  if(self.stairsstate != "none")
    return 0;

  if(!self _meth_81BF("stand") && !isDefined(self.heat))
    return 0;

  if(distancesquared(self.origin, self.pathgoalpos) < 10000)
    return 0;

  return 1;
}

_id_3E56(var_0, var_1) {
  if(!isDefined(var_0))
    return 0;

  if(var_0 == "exposed" || isDefined(self.heat)) {
    if(self.a.pose != "stand" && self.a.pose != "crouch")
      return 0;

    if(self.a.movement != "stop")
      return 0;
  }

  if(!isDefined(self.heat) && isDefined(self.enemy) && vectordot(self.lookaheaddir, self.enemy.origin - self.origin) < 0) {
    if(scripts\anim\utility_common::canseeenemyfromexposed() && distancesquared(self.origin, self.enemy.origin) < 90000)
      return 0;
  }

  return 1;
}

_id_53C8(var_0) {
  if(self.a.pose == "stand")
    var_0 = "exposed";
  else
    var_0 = "exposed_crouch";

  if(scripts\anim\cover_arrival::_id_130C9())
    var_0 = "exposed_ready";

  if(scripts\anim\utility::_id_FFDB())
    var_0 = var_0 + "_cqb";
  else if(isDefined(self.heat))
    var_0 = "heat";

  return var_0;
}

getmaxdamage(var_0) {
  var_1 = spawnStruct();

  if(isDefined(var_0) && isDefined(anim._id_B490[var_0.type])) {
    var_1._id_B490 = anim._id_B490[var_0.type];
    var_1._id_68CA = anim._id_68CA[var_0.type];
  } else {
    var_1._id_B490 = 9;
    var_1._id_68CA = -1;
  }

  return var_1;
}

_id_371A(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_0.transitions = [];
  var_0._id_12654 = [];
  var_7 = undefined;
  var_8 = 1;
  var_9 = 0;

  if(var_2) {
    var_7 = scripts\anim\utility::_id_B027("cover_trans_angles", var_1);
    var_8 = -1;
    var_9 = 0;
  } else {
    var_7 = scripts\anim\utility::_id_B027("cover_exit_angles", var_1);
    var_8 = 1;
    var_9 = 180;
  }

  for(var_10 = 1; var_10 <= var_5; var_10++) {
    var_0._id_12654[var_10] = var_10;

    if(var_10 == 5 || var_10 == var_6 || !isDefined(var_7[var_10])) {
      var_0.transitions[var_10] = -1.0003;
      continue;
    }

    var_11 = (0, var_3 + var_8 * var_7[var_10] + var_9, 0);
    var_12 = vectorNormalize(anglesToForward(var_11));
    var_0.transitions[var_10] = vectordot(var_4, var_12);
  }
}

_id_1043F(var_0, var_1) {
  for(var_2 = 2; var_2 <= var_1; var_2++) {
    var_3 = var_0.transitions[var_0._id_12654[var_2]];
    var_4 = var_0._id_12654[var_2];

    for(var_5 = var_2 - 1; var_5 >= 1; var_5--) {
      if(var_3 < var_0.transitions[var_0._id_12654[var_5]]) {
        break;
      }

      var_0._id_12654[var_5 + 1] = var_0._id_12654[var_5];
    }

    var_0._id_12654[var_5 + 1] = var_4;
  }
}

_id_3E2C(var_0, var_1, var_2, var_3, var_4) {
  var_5 = (0, var_1, 0);
  var_6 = anglesToForward(var_5);
  var_7 = anglestoright(var_5);
  var_8 = scripts\anim\utility::_id_B031("cover_exit_dist", var_2, var_4);
  var_9 = var_6 * var_8[0];
  var_10 = var_7 * var_8[1];
  var_11 = var_0 + var_9 - var_10;
  self._id_471C = var_11;

  if(!var_3 && !self _meth_8068(var_11))
    return 0;

  if(!self maymovefrompointtopoint(self.origin, var_11))
    return 0;

  if(var_4 <= 6 || var_3)
    return 1;

  var_12 = scripts\anim\utility::_id_B031("cover_exit_postdist", var_2, var_4);
  var_9 = var_6 * var_12[0];
  var_10 = var_7 * var_12[1];
  var_13 = var_11 + var_9 - var_10;
  self._id_471C = var_13;
  return self maymovefrompointtopoint(var_11, var_13);
}

#using_animtree("generic_human");

_id_5926(var_0, var_1) {
  var_2 = scripts\anim\utility::_id_B031("cover_exit", var_0, var_1);
  var_3 = vectortoangles(self.lookaheaddir);

  if(self.a.pose == "prone") {
    return;
  }
  var_5 = 0.2;

  if(scripts\engine\utility::actor_is3d())
    self animmode("nogravity", 0);
  else
    self animmode("zonly_physics", 0);

  self orientmode("face angle", self.angles[1]);
  self _meth_82E4("coverexit", var_2, %body, 1, var_5, self._id_BD22);
  scripts\anim\shared::donotetracks("coverexit");
  self.a.pose = "stand";
  self.a.movement = "run";
  self._id_932E = undefined;
  self orientmode("face motion");
  self animmode("none", 0);
  _id_6CD5("coverexit");
  self clearanim(%root, 0.2);
  self orientmode("face default");
  self animmode("normal", 0);
}

_id_6CD5(var_0) {
  self endon("move_loop_restart");
  scripts\anim\shared::donotetracks(var_0);
}

_id_53C5(var_0, var_1) {
  if(var_0.type == "Cover Right")
    var_1 = "heat_right";
  else if(var_0.type == "Cover Left")
    var_1 = "heat_left";

  return var_1;
}

_id_7EA3() {
  var_0 = undefined;
  var_1 = 400;

  if(scripts\engine\utility::actor_is3d())
    var_1 = 1024;
  else if(isDefined(self.heat))
    var_1 = 4096;

  if(isDefined(self.node) && distancesquared(self.origin, self.node.origin) < var_1)
    var_0 = self.node;
  else if(isDefined(self.prevnode) && distancesquared(self.origin, self.prevnode.origin) < var_1)
    var_0 = self.prevnode;

  if(isDefined(self.heat) && !scripts\engine\utility::actor_is3d()) {
    if(isDefined(var_0) && scripts\engine\utility::absangleclamp180(self.angles[1] - var_0.angles[1]) > 30)
      return undefined;
  }

  return var_0;
}

custommovetransition() {
  var_0 = self.custommovetransition;

  if(!isDefined(self.perm_on))
    self.custommovetransition = undefined;

  var_1 = [[var_0]]();

  if(!isDefined(self.perm_on))
    self._id_10DCB = undefined;

  if(!isDefined(var_1))
    var_1 = 0.2;

  self clearanim(%root, var_1);
  self orientmode("face default");
  self animmode("none", 0);
}

_id_4EAB(var_0) {
  if(!scripts\anim\cover_arrival::_id_4EAC())
    return;
}