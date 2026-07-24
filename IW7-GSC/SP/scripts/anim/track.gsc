/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\anim\track.gsc
**************************************/

#using_animtree("generic_human");

_id_11B07() {
  self endon("killanimscript");
  self endon("stop tracking");
  self endon("melee");
  _id_11AF8(%aim_2, %aim_4, %aim_6, %aim_8);
}

_id_11AF8(var_0, var_1, var_2, var_3, var_4) {
  var_5 = 0;
  var_6 = 0;
  var_7 = (0, 0, 0);
  var_8 = 1;
  var_9 = 0;
  var_10 = 0;
  var_11 = 10;
  var_12 = (0, 0, 0);

  if(self.type == "dog") {
    var_13 = 0;
    self._id_FE9E = self.enemy;
  } else {
    var_13 = 1;
    var_14 = 0;
    var_15 = 0;

    if(isDefined(self._id_4716))
      var_14 = anim.covercrouchleanpitch;

    var_16 = self.script;

    if((var_16 == "cover_left" || var_16 == "cover_right") && isDefined(self.a._id_4667) && self.a._id_4667 == "lean")
      var_15 = self.covernode.angles[1] - self.angles[1];

    var_12 = (var_14, var_15, 0);
  }

  for(;;) {
    _id_93E2();
    var_17 = scripts\anim\shared::_id_811C();
    var_18 = self._id_FECF;

    if(isDefined(self._id_FE9E))
      var_18 = self._id_FE9E getshootatpos();

    if(!isDefined(var_18) && scripts\anim\utility::_id_FFDB())
      var_18 = _id_11AFB(var_17);

    var_19 = isDefined(self._id_C59B) || isDefined(self.onatv);
    var_20 = isDefined(var_18);
    var_21 = (0, 0, 0);

    if(var_20)
      var_21 = var_18;

    var_22 = 0;
    var_23 = isDefined(self._id_10F8C);

    if(var_23)
      var_22 = self._id_10F8C;

    var_7 = self _meth_80FA(var_17, var_21, var_20, var_12, var_22, var_23, var_19);
    var_24 = var_7[0];
    var_25 = var_7[1];
    var_7 = undefined;

    if(scripts\engine\utility::actor_is3d()) {
      var_26 = self.angles[2] * -1;
      var_27 = var_24 * cos(var_26) - var_25 * sin(var_26);
      var_28 = var_24 * sin(var_26) + var_25 * cos(var_26);
      var_24 = var_27;
      var_25 = var_28;
      var_24 = clamp(var_24, self.upaimlimit, self.downaimlimit);
      var_25 = clamp(var_25, self.rightaimlimit, self.leftaimlimit);
    }

    if(var_10 > 0) {
      var_10 = var_10 - 1;
      var_11 = max(10, var_11 - 5);
    } else if(self.relativedir && self.relativedir != var_9) {
      var_10 = 2;
      var_11 = 30;
    } else
      var_11 = 10;

    var_29 = squared(var_11);
    var_9 = self.relativedir;
    var_30 = self.movemode != "stop" || !var_8;

    if(var_30) {
      var_31 = var_25 - var_5;

      if(squared(var_31) > var_29) {
        var_25 = var_5 + clamp(var_31, -1 * var_11, var_11);
        var_25 = clamp(var_25, self.rightaimlimit, self.leftaimlimit);
      }

      var_32 = var_24 - var_6;

      if(squared(var_32) > var_29) {
        var_24 = var_6 + clamp(var_32, -1 * var_11, var_11);
        var_24 = clamp(var_24, self.upaimlimit, self.downaimlimit);
      }
    }

    var_8 = 0;
    var_5 = var_25;
    var_6 = var_24;
    _id_11AFE(var_0, var_1, var_2, var_3, var_4, var_24, var_25);
    wait 0.05;
  }
}

_id_11AFB(var_0) {
  var_1 = undefined;
  var_2 = anglesToForward(self.angles);

  if(isDefined(self._id_4792)) {
    var_1 = self._id_4792 getshootatpos();

    if(isDefined(self._id_4796)) {
      if(vectordot(vectorNormalize(var_1 - var_0), var_2) < 0.177)
        var_1 = undefined;
    } else if(vectordot(vectorNormalize(var_1 - var_0), var_2) < 0.643)
      var_1 = undefined;
  }

  if(!isDefined(var_1) && isDefined(self._id_478F)) {
    var_1 = self._id_478F;

    if(isDefined(self._id_4795)) {
      if(vectordot(vectorNormalize(var_1 - var_0), var_2) < 0.177)
        var_1 = undefined;
    } else if(vectordot(vectorNormalize(var_1 - var_0), var_2) < 0.643)
      var_1 = undefined;
  }

  return var_1;
}

_id_11AF9(var_0, var_1) {
  if(scripts\anim\utility_common::recentlysawenemy()) {
    var_2 = self.enemy getshootatpos() - self.enemy.origin;
    var_3 = self lastknownpos(self.enemy) + var_2;
    return _id_11AFC(var_3 - var_0, var_1);
  }

  var_4 = 0;
  var_5 = 0;

  if(isDefined(self.node) && isDefined(anim._id_9D8E[self.node.type]) && distancesquared(self.origin, self.node.origin) < 16)
    var_5 = angleclamp180(self.node.angles[1] - self.angles[1]);
  else {
    var_6 = self _meth_80FC();

    if(isDefined(var_6)) {
      var_5 = angleclamp180(var_6[1] - self.angles[1]);
      var_4 = angleclamp180(var_6[0]);
    }
  }

  return (var_4, var_5, 0);
}

_id_11AFC(var_0, var_1) {
  var_2 = vectortoangles(var_0);
  var_3 = 0;
  var_4 = 0;

  if(self.stairsstate == "up")
    var_3 = 40;
  else if(self.stairsstate == "down") {
    var_3 = -40;
    var_4 = -12;
  }

  var_5 = var_2[0];
  var_5 = angleclamp180(var_5 + var_1[0] + var_3);

  if(isDefined(self._id_10F8C))
    var_6 = var_2[1] - self._id_10F8C;
  else {
    var_7 = angleclamp180(self.desiredangle - self.angles[1]) * 0.5;
    var_6 = var_2[1] - (var_7 + self.angles[1]);
  }

  var_6 = angleclamp180(var_6 + var_1[1] + var_4);
  return (var_5, var_6, 0);
}

_id_11AFA(var_0, var_1, var_2) {
  if(isDefined(self._id_C59B) || isDefined(self.onatv)) {
    if(var_1 > self.leftaimlimit || var_1 < self.rightaimlimit)
      var_1 = 0;

    if(var_0 > self.downaimlimit || var_0 < self.upaimlimit)
      var_0 = 0;
  } else if(var_2 && (abs(var_1) > anim._id_B480 || abs(var_0) > anim._id_B47F)) {
    var_1 = 0;
    var_0 = 0;
  } else {
    if(self.gunblockedbywall)
      var_1 = clamp(var_1, -10, 10);
    else
      var_1 = clamp(var_1, self.rightaimlimit, self.leftaimlimit);

    var_0 = clamp(var_0, self.upaimlimit, self.downaimlimit);
  }

  return (var_0, var_1, 0);
}

_id_11AFE(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = 0;
  var_8 = 0;
  var_9 = 0;
  var_10 = 0;
  var_11 = 0;

  if(var_6 < 0) {
    var_10 = var_6 / self.rightaimlimit * self.a._id_1A4B;
    var_9 = 1;
  } else if(var_6 > 0) {
    var_8 = var_6 / self.leftaimlimit * self.a._id_1A4B;
    var_9 = 1;
  }

  if(var_5 < 0) {
    var_11 = var_5 / self.upaimlimit * self.a._id_1A4B;
    var_9 = 1;
  } else if(var_5 > 0) {
    var_7 = var_5 / self.downaimlimit * self.a._id_1A4B;
    var_9 = 1;
  }

  self _meth_82AC(var_0, var_7, 0.1, 1, 1);
  self _meth_82AC(var_1, var_8, 0.1, 1, 1);
  self _meth_82AC(var_2, var_10, 0.1, 1, 1);
  self _meth_82AC(var_3, var_11, 0.1, 1, 1);

  if(isDefined(var_4))
    self _meth_82AC(var_4, var_9, 0.1, 1, 1);
}

_id_F641(var_0, var_1) {
  if(!isDefined(var_1) || var_1 <= 0) {
    self.a._id_1A4B = var_0;
    self.a._id_1A4D = var_0;
    self.a._id_1A4C = var_0;
    self.a._id_1A4F = 0;
  } else {
    if(!isDefined(self.a._id_1A4B))
      self.a._id_1A4B = 0;

    self.a._id_1A4D = self.a._id_1A4B;
    self.a._id_1A4C = var_0;
    self.a._id_1A4F = int(var_1 * 20);
  }

  self.a._id_1A4E = 0;
}

_id_93E2() {
  if(self.a._id_1A4E < self.a._id_1A4F) {
    self.a._id_1A4E++;
    var_0 = 1.0 * self.a._id_1A4E / self.a._id_1A4F;
    self.a._id_1A4B = self.a._id_1A4D * (1 - var_0) + self.a._id_1A4C * var_0;
  }
}