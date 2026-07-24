/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3080.gsc
**************************************/

_id_7FD3() {
  if(isDefined(self._id_10AB7) && self._id_10AB7)
    return "sprint";

  if(isDefined(self._id_527B))
    return self._id_527B;

  return scripts\aitypes\bt_util::bt_getdemeanor();
}

_id_12E90(var_0) {
  if(!isalive(self))
    return anim.failure;

  scripts\asm\asm_bb::bb_requestmovetype(_id_7FD3());
  return anim.success;
}

_id_9D5B(var_0) {
  if(self._id_290A)
    return anim.success;

  return anim.failure;
}

_id_3596() {
  return ["left", "right"];
}

_id_351D(var_0, var_1) {
  if(!isDefined(var_1))
    var_1 = 1;

  self.bt._id_13C83[var_0] = var_1;
}

_id_357A() {
  var_0 = [];
  var_1 = _id_3596();

  foreach(var_3 in var_1) {
    if(_id_8C3C(var_3))
      var_0[var_0.size] = var_3;
  }

  return var_0;
}

_id_357C() {
  var_0 = [];
  var_1 = _id_3596();

  foreach(var_3 in var_1) {
    if(_id_8C3C(var_3) && _id_9F5B(var_3))
      var_0[var_0.size] = var_3;
  }

  return var_0;
}

_id_357D() {
  var_0 = [];
  var_1 = _id_3596();

  foreach(var_3 in var_1) {
    if(_id_8C3C(var_3) && _id_9F5B(var_3)) {
      var_4 = self._blackboard.shootparams._id_13CC3[var_3];

      if(isDefined(var_4) && isDefined(var_4._id_3124) && var_4._id_3124 && isDefined(var_4._id_2AB9) && var_4._id_2AB9)
        var_0[var_0.size] = var_3;
    }
  }

  return var_0;
}

_id_8C3C(var_0) {
  return isDefined(self._id_13CC3[var_0]);
}

_id_9F5B(var_0) {
  if(!self.bt._id_13C83[var_0])
    return 0;

  return self._id_13C83[var_0];
}

_id_B2AB(var_0, var_1) {
  var_2 = spawnStruct();
  var_2.state = 0;
  var_2._id_1158D = var_1;

  if(self._id_13CC3[var_0] == "minigun") {
    var_2._id_71A2 = ::_id_FEE5;
    var_2._id_DCE8 = 100;
  } else {
    var_2._id_71A2 = ::_id_FEE9;
    var_2._id_DCE8 = 250;

    if(!isDefined(var_2._id_C241))
      var_2._id_C241 = randomintrange(1, 3);
  }

  var_2._id_29A9 = 1;
  var_2._id_29A1 = 1;
  var_2._id_3124 = 1;
  var_2._id_2AB9 = 1;
  var_2._id_312A = 1;
  var_2._id_3139 = 0;
  return var_2;
}

_id_97EB(var_0) {
  var_1 = spawnStruct();
  var_1._id_11590 = [];
  var_2 = _id_357A();

  foreach(var_4 in var_2) {
    var_5 = _id_B2AB(var_4, undefined);
    var_1._id_13CC3[var_4] = var_5;
  }

  var_1._id_A98F = gettime();
  var_1._id_A993 = gettime();
  self._blackboard.shootparams = var_1;
  self.maxfaceenemydist = 1024;

  if(!isDefined(self.bt.lasttimefired))
    self.bt.lasttimefired = 0;

  return anim.success;
}

_id_40E9(var_0) {
  if(isDefined(self._blackboard.shootparams) && isDefined(self._blackboard.shootparams._id_13CC3) && !isDefined(self._id_EF6D)) {
    var_1 = _id_3596();

    foreach(var_3 in var_1)
    self._blackboard.shootparams._id_13CC3[var_3] = undefined;

    self._blackboard.shootparams = undefined;
  }

  return anim.success;
}

_id_12E77(var_0) {
  if(isDefined(self.pathgoalpos))
    self.bt.lasttimefired = gettime();

  return anim.success;
}

_id_FB1E(var_0, var_1) {
  if(!isDefined(self._blackboard.shootparams))
    return anim.failure;

  self._blackboard.shootparams._id_12F1C = var_1;
  return anim.success;
}

_id_7E30(var_0) {
  if(!isDefined(self._blackboard.shootparams))
    return undefined;

  var_1 = gettime();
  var_2 = undefined;
  var_3 = 999999999;

  foreach(var_5 in _id_357A()) {
    var_6 = self._blackboard.shootparams._id_13CC3[var_5];

    if(isDefined(var_6.ent)) {
      if(var_6._id_3124 || isDefined(var_0) && var_1 - var_6._id_A9AB <= var_0) {
        var_7 = distancesquared(self.origin, var_6.ent.origin);

        if(var_7 < var_3) {
          var_3 = var_7;
          var_2 = var_6.ent;
        }
      }

      continue;
    }

    if(isDefined(var_6._id_EF76) && var_6._id_EF76.size > 0) {
      foreach(var_9 in var_6._id_EF76) {
        if(isDefined(var_9)) {
          var_7 = distancesquared(self.origin, var_9.origin);

          if(var_7 < var_3) {
            var_3 = var_7;
            var_2 = var_9;
          }
        }
      }
    }
  }

  return var_2;
}

_id_FE5F(var_0, var_1) {
  self[[var_0._id_71A2]](var_0, var_1);
}

canseetarget(var_0) {
  var_1 = self._blackboard.shootparams;
  var_2 = var_1._id_13CC3[var_0];

  if(!isDefined(var_2))
    return 0;

  var_3 = undefined;

  if(isDefined(var_2._id_EF76) && var_2._id_EF76.size > 0)
    var_3 = var_2._id_EF76[0];
  else if(isDefined(var_2.ent))
    var_3 = var_2.ent;

  if(isDefined(var_3))
    return self cansee(var_3);

  return 1;
}

_id_8C27(var_0, var_1) {
  if(!isDefined(var_1))
    return 1;

  var_2 = self._blackboard.shootparams;
  var_3 = var_2._id_13CC3[var_0];

  if(!isDefined(var_3))
    return 0;

  var_4 = undefined;

  if(self._id_13CC3[var_0] == "minigun")
    var_4 = _id_0C41::_id_3587(var_0);
  else if(self._id_13CC3[var_0] == "rocket")
    var_4 = _id_0C41::_id_3593(var_0, "top");

  var_5 = 256;
  var_6 = var_1 - var_4;
  var_7 = length(var_6);

  if(var_7 > var_5)
    var_8 = var_4 + var_6 / var_7 * 256;
  else
    var_8 = var_1;

  return sighttracepassed(var_4, var_8, 0, self);
}

_id_8BEC(var_0) {
  if(!isDefined(var_0))
    return 0;

  if(!isDefined(var_0.ent) && !isDefined(var_0._id_EF76) && !isDefined(var_0.pos))
    return 0;

  return 1;
}

shouldshoot(var_0) {
  if(isDefined(self.dontevershoot))
    return anim.failure;

  if(!isDefined(self.enemy))
    return anim.failure;

  return anim.success;
}

_id_FE7B(var_0, var_1) {
  var_2 = self._blackboard.shootparams;

  if(!isDefined(var_2._id_13CC3[var_0])) {
    return;
  }
  if(!isDefined(var_1) || !isDefined(var_2._id_13CC3[var_0].ent) || var_2._id_13CC3[var_0].ent != var_1) {
    var_3 = _id_B2AB(var_0, var_2._id_13CC3[var_0]._id_1158D);
    var_2._id_13CC3[var_0].state = -1;
    var_3._id_C249 = var_2._id_13CC3[var_0]._id_C249;
    var_2._id_13CC3[var_0] = var_3;
    var_4 = gettime();
    var_3._id_656E = var_4;

    if(isDefined(var_1)) {
      var_3.lastenemypos = var_1.origin;
      var_3._id_A97D = var_4;
    }
  }

  var_5 = var_2._id_13CC3[var_0];
  var_5.ent = var_1;
}

_id_FE8B(var_0) {
  var_1 = _id_3596();
  var_2 = undefined;

  foreach(var_4 in var_1) {
    if(self._blackboard.shootparams._id_13CC3[var_4] == var_0) {
      var_2 = var_4;
      break;
    }
  }

  var_6 = gettime();

  if(isDefined(var_0.ent)) {
    var_0._id_29A1 = self cansee(var_0.ent);
    var_0._id_3124 = self seerecently(var_0.ent, 1);

    if(issentient(var_0.ent))
      var_0._id_A9AB = self lastknowntime(var_0.ent);
    else
      var_0._id_A9AB = var_6;

    var_7 = 1024;
    var_8 = 500;

    if(var_6 > var_0._id_A97D + var_8) {
      if(distancesquared(var_0.ent.origin, var_0.lastenemypos) > var_7)
        var_0._id_3139 = 0;
      else
        var_0._id_3139 = 1;

      var_0.lastenemypos = var_0.ent.origin;
      var_0._id_A97D = var_6;
    }
  } else {
    var_0._id_29A1 = 1;
    var_0._id_3124 = 1;
    var_0._id_A9AB = var_6;
  }

  var_9 = self._id_13CC3[var_2] == "rocket";
  var_0._id_1A46 = _id_FE67(var_0, var_9);
  var_0._id_1A47 = var_6;
  var_0._id_312A = var_0._id_3124;
  var_0._id_2AB9 = _id_8C27(var_2, var_0._id_1A46);
}

_id_FE8C(var_0) {
  var_1 = self._blackboard.shootparams;

  if(isDefined(self._id_7212) && gettime() < self._id_7212) {
    if(_id_9F5B("left"))
      var_2 = level.player;
    else
      var_2 = undefined;

    if(_id_9F5B("right"))
      var_3 = level.player;
    else
      var_3 = undefined;
  } else {
    var_2 = self.enemy;
    var_3 = self.enemy;

    if(self._id_27F7) {
      if(_id_8C3C("left") && _id_9F5B("left") && _id_8C3C("right") && _id_9F5B("right")) {
        var_4 = self _meth_848B();

        if(isDefined(var_4) && var_4.size > 0) {
          var_5 = var_4[0];
          var_6 = self.enemy.origin - self.origin;
          var_7 = var_5.origin - self.origin;
          var_8 = vectorNormalize(var_7);
          var_9 = (self.enemy.origin + var_5.origin) * 0.5;
          var_10 = vectorNormalize(var_9 - self.origin);
          var_11 = vectortoangles(var_10);
          var_12 = anglesToForward(self.angles);

          if(vectordot(var_10, var_12) > 0) {
            var_13 = anglestoright(var_11);

            if(vectordot(var_8, var_10) > 0) {
              var_14 = vectordot(var_13, var_6);
              var_15 = vectordot(var_13, var_7);

              if(var_15 > var_14)
                var_3 = var_5;
              else
                var_2 = var_5;
            }
          }
        }
      }
    }

    if(!_id_9F5B("left"))
      var_2 = undefined;
    else if(isDefined(var_1._id_13CC3["left"]) && isDefined(var_1._id_13CC3["left"]._id_313A) && isDefined(var_1._id_13CC3["left"].ent))
      var_2 = var_1._id_13CC3["left"].ent;

    if(!_id_9F5B("right"))
      var_3 = undefined;
    else if(isDefined(var_1._id_13CC3["right"]) && isDefined(var_1._id_13CC3["right"]._id_313A) && isDefined(var_1._id_13CC3["right"].ent))
      var_3 = var_1._id_13CC3["right"].ent;
  }

  _id_FE7B("left", var_2);
  _id_FE7B("right", var_3);
  _id_FE8B(var_1._id_13CC3["left"]);
  _id_FE8B(var_1._id_13CC3["right"]);
  return anim.success;
}

_id_FE7A(var_0) {
  if(isDefined(var_0))
    self._blackboard.shootparams._id_BFB6 = var_0;
  else
    self._blackboard.shootparams._id_BFB6 = gettime() + randomintrange(1000, 1500);
}

_id_3873(var_0) {
  setdvarifuninitialized("enable_c12_berserk", 0);

  if(!getdvarint("enable_c12_berserk"))
    return 0;

  if(!isDefined(var_0.ent))
    return 0;

  var_1 = self._blackboard.shootparams;
  var_2 = ["left", "right"];
  var_3 = undefined;

  foreach(var_5 in var_2) {
    if(var_1._id_13CC3[var_5] == var_0) {
      if(self._id_13CC3[var_5] != "minigun")
        return 0;

      var_3 = var_5;
      break;
    }
  }

  var_7 = "left";

  if(var_7 == var_3)
    var_7 = "right";

  if(!scripts\asm\asm_bb::ispartdismembered(var_7 + "_arm"))
    return 0;

  var_8 = gettime();

  if(!isDefined(var_1._id_BF71))
    var_1._id_BF71 = var_8;

  return var_8 >= var_1._id_BF71;
}

_id_FE79() {
  var_0 = self._blackboard.shootparams;

  if(isDefined(var_0))
    var_0._id_BF71 = gettime() + randomintrange(10000, 20000);
}

_id_FE78(var_0) {
  var_0._id_2763 = gettime() + 2000;
}

_id_FE63() {
  var_0 = _id_357A();

  foreach(var_2 in var_0) {
    if(self._id_13CC3[var_2] == "minigun")
      return var_2;
  }

  return undefined;
}

_id_FE65() {
  var_0 = _id_357A();

  foreach(var_2 in var_0) {
    if(self._id_13CC3[var_2] == "rocket")
      return var_2;
  }

  return undefined;
}

_id_FE68(var_0) {
  if(isDefined(var_0.unittype) && var_0.unittype == "c12")
    return 1000;

  if(scripts\sp\vehicle::_id_9FEF(var_0))
    return 500;

  return 10;
}

_id_FE62() {
  var_0 = self._blackboard.shootparams;
  var_1 = 0;
  var_2 = undefined;
  var_3 = _id_357C();

  foreach(var_5 in var_3) {
    var_6 = var_0._id_13CC3[var_5];

    if(isDefined(var_6) && isDefined(var_6.ent)) {
      var_7 = _id_FE68(var_6.ent);

      if(var_7 > var_1) {
        var_2 = var_5;
        var_1 = var_7;
      }
    }
  }

  return var_2;
}

_id_41EC(var_0) {
  return anim.failure;
}

_id_FE8E(var_0) {
  _id_FE8C(var_0);
  var_1 = _id_FE8D(var_0);
  _id_FE8A(var_1);
  return anim.success;
}

_id_FE8D(var_0) {
  var_1 = self._blackboard.shootparams;

  if(isDefined(self._id_9DD2) && self._id_9DD2)
    return _id_FE63();

  if(isDefined(var_1._id_1675) && _id_9F5B(var_1._id_1675)) {
    var_2 = var_1._id_13CC3[var_1._id_1675];

    if(var_2.state != 0)
      return var_1._id_1675;
  }

  var_3 = _id_357D();

  if(var_3.size == 0)
    return undefined;

  var_4 = var_3;

  foreach(var_6 in var_3) {
    var_2 = var_1._id_13CC3[var_6];

    if(self._id_13CC3[var_6] == "rocket") {
      var_7 = var_2.ent;

      if(isDefined(var_7)) {
        if(distancesquared(var_7.origin, self.origin) < 40000)
          var_4 = scripts\engine\utility::array_remove(var_4, var_6);
        else if(!var_2._id_3139)
          var_4 = scripts\engine\utility::array_remove(var_4, var_6);
      }

      continue;
    }

    if(isDefined(var_1._id_1675) && var_1._id_1675 == var_6) {
      if(var_2._id_3124 && var_1._id_C24A >= 3)
        var_4 = scripts\engine\utility::array_remove(var_4, var_6);
    }
  }

  if(var_4.size == 0) {
    var_3 = _id_357D();

    if(var_3.size > 0)
      return var_3[randomint(var_3.size)];
  } else if(var_4.size == 1)
    return var_4[0];
  else
    return var_4[randomint(var_4.size)];
}

_id_FE8A(var_0) {
  var_1 = self._blackboard.shootparams;
  var_2 = _id_357A();

  foreach(var_4 in var_2) {
    if(!_id_9F5B(var_4) && isDefined(var_1._id_13CC3[var_4]))
      _id_FE5F(var_1._id_13CC3[var_4], 0);
  }

  if(!isDefined(var_1._id_1675))
    _id_FE7A(gettime());

  var_6 = isDefined(var_0);

  if(var_6 && isDefined(var_1._id_1675) && var_0 == var_1._id_1675) {
    if(var_1._id_13CC3[var_0]._id_29A9 && !var_1._id_13CC3[var_0]._id_29A1)
      _id_FE5F(var_1._id_13CC3[var_0], 0);
    else {
      if(var_1._id_13CC3[var_0].state == 0) {
        if(!isDefined(var_1._id_BFB6))
          _id_FE7A();

        if(gettime() > var_1._id_BFB6) {
          var_1._id_BFB6 = undefined;
          var_1._id_C24A++;
          _id_FE5F(var_1._id_13CC3[var_0], 1);
        }
      }

      return;
    }
  }

  var_2 = _id_357A();

  foreach(var_8 in var_2) {
    if(!var_6 || var_8 != var_0) {
      var_9 = var_1._id_13CC3[var_8];
      _id_FE5F(var_9, 0);
    }
  }

  var_1._id_1675 = var_0;
  var_1._id_C24A = 0;

  if(var_6 && var_1._id_13CC3[var_0]._id_29A1) {
    if(!isDefined(var_1._id_BFB6))
      _id_FE7A();

    if(gettime() > var_1._id_BFB6) {
      var_9 = var_1._id_13CC3[var_0];
      var_1._id_C24A = 1;
      var_1._id_BFB6 = undefined;
      _id_FE5F(var_9, 1);
    }
  }
}

_id_10079(var_0) {
  var_1 = self._blackboard.shootparams._id_13CC3[var_0];

  if(!isDefined(var_1))
    return 0;

  return var_1.state == 2 || var_1.state == 3;
}

_id_9F7B(var_0) {
  var_1 = self._blackboard.shootparams._id_13CC3[var_0];

  if(!isDefined(var_1))
    return 0;

  return var_1.state == 3;
}

_id_1391C(var_0) {
  return var_0.state == 3;
}

_id_A004(var_0) {
  var_1 = self._blackboard.shootparams._id_13CC3[var_0];

  if(!isDefined(var_1))
    return 0;

  return var_1.state == 4;
}

_id_A005(var_0) {
  var_1 = self._blackboard.shootparams._id_12F1C;
  var_2 = self._blackboard.shootparams._id_13CC3[var_1];

  if(!isDefined(var_2))
    return anim.failure;

  if(var_2.state == 0)
    return anim.failure;

  return anim.success;
}

_id_A006(var_0, var_1) {
  var_2 = self._blackboard.shootparams._id_12F1C;

  if(_id_A007(var_2, var_1))
    return anim.success;

  return anim.failure;
}

_id_A007(var_0, var_1) {
  if(!_id_8C3C(var_0))
    return 0;

  if(self._id_13CC3[var_0] == var_1)
    return 1;

  return 0;
}

_id_FE66(var_0) {
  if(!_id_8C3C(var_0))
    return undefined;

  var_1 = self._blackboard.shootparams;
  var_2 = var_1._id_13CC3[var_0];
  var_3 = self._id_13CC3[var_0] == "rocket";
  return _id_FE67(var_2, var_3);
}

_id_FE67(var_0, var_1) {
  if(var_0.state == 4)
    return self.origin + anglesToForward(self.angles) * 192;

  if(isDefined(var_0._id_E5E0))
    return var_0._id_E5E0;

  if(isDefined(var_0._id_EF76)) {
    var_2 = (0, 0, 0);
    var_3 = 0;

    foreach(var_5 in var_0._id_EF76) {
      if(isDefined(var_5)) {
        if(var_1)
          var_6 = var_5.origin;
        else
          var_6 = var_5 getshootatpos();

        var_2 = var_2 + var_6;
        var_3++;
      }
    }

    if(var_3 == 0)
      return undefined;

    var_8 = var_2 / var_3;
    return var_8 + _id_FE69(var_0, var_8);
  }

  if(isDefined(var_0.ent)) {
    var_9 = _id_3596();
    var_10 = undefined;

    foreach(var_12 in var_9) {
      if(self._blackboard.shootparams._id_13CC3[var_12] == var_0) {
        var_10 = var_12;
        break;
      }
    }

    if(self cansee(var_0.ent)) {
      if(var_1)
        return var_0.ent.origin;

      var_14 = var_0.ent getshootatpos();
      return var_14 + _id_FE69(var_0, var_14);
    } else {
      var_14 = self lastknownpos(var_0.ent) + (0, 0, 60);
      return var_14 + _id_FE69(var_0, var_14);
    }
  }

  if(isDefined(var_0.pos))
    return var_0.pos + _id_FE69(var_0, var_0.pos);

  return undefined;
}

_id_FE69(var_0, var_1) {
  if(!_id_1391C(var_0))
    return (0, 0, 0);

  var_2 = (gettime() - var_0._id_110D8) / 1000;
  var_3 = int(var_2 * 256);
  var_4 = var_3 % 256;

  if(var_4 > 128.0)
    var_4 = 256 - var_4;

  if(int(var_3 / 256) % 2)
    var_4 = var_4 * -1;

  return rotatevector((0, var_4, 0), vectortoangles(self.origin - var_1));
}

_id_FEE6(var_0) {
  var_1 = self._blackboard.shootparams;
  var_2 = self._blackboard.shootparams._id_12F1C;
  var_1._id_11590[var_0] = var_2;
  var_3 = var_1._id_13CC3[var_2];
  var_3._id_1158D = var_0;
  _id_FEE5(var_3, 1);
}

_id_FEE5(var_0, var_1) {
  var_2 = -999;
  var_3 = var_0.state;

  if(!isDefined(var_3))
    var_3 = var_2;

  if(var_3 == var_1) {
    return;
  }
  var_0.state = var_1;

  switch (var_1) {
    case 0:
      break;
    case 1:
      if(var_3 == 0) {
        var_0._id_DCE8 = 100;
        var_0._id_C21B = randomintrange(2, 4);
        var_0._id_BF72 = gettime();
        var_0._id_927E = 0;
      } else if(var_3 == 2)
        var_0._id_BF72 = gettime() + 1000;

      _id_FE78(var_0);
      break;
    case 2:
      var_0._id_927E++;
      var_0._id_32BC = gettime() + randomintrange(2000, 4000);
      scripts\sp\gameskill::_id_F288();
      break;
    case 3:
      var_0._id_DCE8 = 33.3333;
      var_0._id_110D8 = gettime();
      var_0._id_32BC = gettime() + 12000;
      var_0._id_313A = 1;
      break;
  }
}

_id_FEE3(var_0) {
  var_1 = self._blackboard.shootparams;
  var_2 = var_1._id_12F1C;
  var_3 = var_1._id_13CC3[var_2];

  if(!_id_8BEC(var_3)) {
    _id_FEE5(var_3, 0);
    return anim.success;
  }

  var_4 = gettime();

  if(var_4 > var_1._id_A993 + 30000)
    _id_128AE(var_2, var_3);

  switch (var_3.state) {
    case 1:
      if(!isDefined(var_3._id_2763))
        _id_FE78(var_3);

      if(var_4 > var_3._id_2763) {
        _id_128AE(var_2, var_3);
        _id_FEE5(var_3, 0);
        return anim.failure;
      }

      if(var_4 >= var_3._id_BF72 && _id_9EA0(var_2, var_3._id_1A46)) {
        var_5 = 1;

        if(var_3._id_29A9)
          var_5 = canseetarget(var_2);

        if(var_5) {
          if(isDefined(self._id_3131))
            _id_FEE5(var_3, 3);
          else
            _id_FEE5(var_3, 2);
        }
      }

      break;
    case 2:
      if(var_4 >= var_3._id_32BC) {
        if(var_3._id_927E >= var_3._id_C21B) {
          _id_FEE5(var_3, 0);
          _id_FE7A();
          return anim.success;
        } else
          _id_FEE5(var_3, 1);
      }

      break;
    case 3:
      if(var_4 >= var_3._id_32BC) {
        _id_FEE5(var_3, 0);
        _id_FE7A();
        return anim.success;
      }

      break;
    case 0:
      return anim.failure;
  }

  return anim.running;
}

_id_FEE4(var_0) {
  var_1 = self._blackboard.shootparams;

  if(!isDefined(var_1)) {
    return;
  }
  var_2 = var_1._id_11590[var_0];
  var_3 = var_1._id_13CC3[var_2];

  if(var_3._id_1158D == var_0)
    _id_FEE5(var_3, 0);
}

_id_FEE9(var_0, var_1) {
  var_2 = var_0.state;

  if(var_2 == var_1) {
    return;
  }
  var_0.state = var_1;

  if(var_1 == 1)
    _id_FE78(var_0);

  if(var_1 == 2) {
    var_0._id_313A = 1;
    var_0._id_29A9 = 0;
  } else {
    var_0._id_313A = undefined;
    var_0._id_29A9 = 1;
  }
}

_id_FEEA(var_0) {
  var_1 = self._blackboard.shootparams;
  var_2 = var_1._id_12F1C;
  var_1._id_11590[var_0] = var_2;
  var_3 = var_1._id_13CC3[var_2];
  var_3._id_1158D = var_0;
  var_3.state = 1;

  if(isDefined(var_3._id_EF76))
    var_3._id_C241 = var_3._id_EF76.size;
  else
    var_3._id_C241 = randomintrange(1, 3);

  var_3._id_DCE8 = 250;
  scripts\sp\gameskill::_id_F288();
  _id_FE78(var_3);
}

_id_FEE7(var_0) {
  var_1 = self._blackboard.shootparams;
  var_2 = var_1._id_12F1C;
  var_3 = self._blackboard.shootparams._id_13CC3[var_2];

  if(scripts\asm\asm::asm_ephemeraleventfired("rocket_shoot_complete", var_2)) {
    _id_FE7A();

    if(isDefined(var_3))
      var_3._id_2720 = undefined;

    return anim.success;
  }

  var_4 = var_3._id_1A46;

  if(!isDefined(var_4))
    return anim.failure;

  var_5 = gettime();

  if(var_5 > var_1._id_A993 + 30000)
    _id_128AE(var_2, var_3);

  if(var_3.state == 1) {
    if(!isDefined(var_3._id_2763))
      _id_FE78(var_3);

    if(var_5 > var_3._id_2763) {
      _id_128AE(var_2, var_3);
      _id_FE5F(var_3, 0);
      return anim.failure;
    }
  }

  if(var_3.state != 2) {
    if(distancesquared(self.origin, var_4) > 65536) {
      if(_id_9F30(var_2, var_4)) {
        var_6 = 1;

        if(var_3._id_29A9)
          var_6 = var_3._id_2AB9;

        if(var_6)
          _id_FE5F(var_3, 2);
      }
    }
  }

  return anim.running;
}

_id_FEE8(var_0) {
  var_1 = self._blackboard.shootparams;

  if(!isDefined(var_1)) {
    return;
  }
  var_2 = var_1._id_11590[var_0];

  if(!isDefined(var_2)) {
    return;
  }
  var_3 = self._blackboard.shootparams._id_13CC3[var_2];

  if(var_3._id_1158D == var_0)
    var_3.state = 0;
}

_id_9F30(var_0, var_1) {
  var_2 = _id_0C41::_id_3593(var_0, "top");
  var_3 = _id_0C41::_id_3592(var_0, "top");

  if(isDefined(self._id_E5C4)) {
    var_4 = anglesToForward(var_3);
    var_4 = rotatevector(var_4, (self._id_E5C4, 0, 0));
    var_3 = vectortoangles(var_4);
  }

  var_5 = 15;
  var_6 = _id_9FFA(var_2, var_3, var_1, var_5);

  if(var_6)
    return 1;

  if(isDefined(self._id_E5C4)) {
    var_7 = _id_0C41::_id_3628(var_0, "pitch", "min");
    var_8 = _id_0C41::_id_3628(var_0, "pitch", "max");

    if(var_3[0] > var_7 - 3 || var_3[0] < var_8 + 3)
      return 1;
  }

  return 0;
}

_id_9EA0(var_0, var_1) {
  var_2 = _id_0C41::_id_3587(var_0);
  var_3 = _id_0C41::_id_3585(var_0);
  var_4 = 15;
  return _id_9FFA(var_2, var_3, var_1, var_4);
}

_id_9FFA(var_0, var_1, var_2, var_3) {
  var_4 = vectorNormalize(var_2 - var_0);
  var_5 = anglesToForward(var_1);
  var_6 = cos(var_3);
  return vectordot(var_4, var_5) >= var_6;
}

_id_8C23(var_0) {
  if(isDefined(self._id_EF6D)) {
    foreach(var_2 in self._id_EF6D) {
      var_3 = var_2.size;

      if(var_3 > 0) {
        for(var_4 = 0; var_4 < var_3; var_4++) {
          if(isDefined(var_2[var_4]))
            return anim.success;
        }
      }
    }
  }

  return anim.failure;
}

_id_FE90(var_0) {
  var_1 = self._blackboard.shootparams;
  var_2 = var_1._id_13CC3[var_0];
  _id_FE8B(var_2);

  if(isDefined(var_1._id_BFB6)) {
    if(gettime() < var_1._id_BFB6)
      return;
  }

  var_3 = 1;

  if(isDefined(var_2._id_EF76))
    var_3 = !scripts\sp\utility::array_compare(self._id_EF6D[var_0], var_2._id_EF76);

  if(var_3) {
    var_4 = var_2._id_1158D;
    var_2.state = -1;
    var_2 = _id_B2AB(var_0, var_4);
    var_1._id_13CC3[var_0] = var_2;
  }

  var_2._id_EF76 = self._id_EF6D[var_0];
  var_2._id_EF77 = self._id_EF70[var_0];
  var_2._id_29A9 = self._id_EF6E[var_0];
  var_2._id_C241 = self._id_EF6D[var_0].size;

  if(!isDefined(var_2._id_656E))
    var_2._id_656E = gettime();

  _id_FE8B(var_2);

  if(var_2.state == 0)
    _id_FE5F(var_2, 1);
}

_id_FE8F(var_0) {
  var_1 = self._blackboard.shootparams;

  if(!isDefined(var_1)) {
    _id_97EB(undefined);
    var_1 = self._blackboard.shootparams;
  }

  var_2 = _id_357A();

  foreach(var_4 in var_2) {
    if(_id_9F5B(var_4) && isDefined(self._id_EF6D[var_4])) {
      _id_FE90(var_4);
      continue;
    }

    var_5 = self._blackboard.shootparams._id_13CC3[var_4];

    if(isDefined(var_5))
      _id_FE5F(var_5, 0);
  }

  return anim.success;
}

_id_F811(var_0) {
  var_1 = getrandomnavpoint(self.origin, 2048, self);
  self _meth_8481(var_1);
  self setgoalpos((0, 0, 0));
  return anim.success;
}

_id_1383A(var_0) {
  if(isDefined(self.pathgoalpos))
    return anim.running;

  self _meth_8484();
  return anim.success;
}

_id_3906(var_0) {
  var_1 = self._blackboard.shootparams;
  var_2 = _id_357C();

  foreach(var_4 in var_2) {
    var_5 = var_1._id_13CC3[var_4];

    if(isDefined(var_5)) {
      if(isDefined(var_5.ent)) {
        if(self cansee(var_5.ent))
          return anim.success;
      } else if(isDefined(var_5._id_EF76)) {
        foreach(var_7 in var_5._id_EF76) {
          if(self cansee(var_7))
            return anim.success;
        }
      }
    }
  }

  return anim.failure;
}

_id_8C25(var_0, var_1) {
  var_2 = self._blackboard.shootparams;
  var_3 = _id_357C();

  foreach(var_5 in var_3) {
    var_6 = var_2._id_13CC3[var_5];

    if(isDefined(var_6)) {
      if(isDefined(var_6.ent)) {
        if(self seerecently(var_6.ent, var_1))
          return anim.success;
      } else if(isDefined(var_6._id_EF76)) {
        foreach(var_8 in var_6._id_EF76) {
          if(!isent(var_6.ent) || self seerecently(var_8, var_1))
            return anim.success;
        }
      }
    }
  }

  return anim.failure;
}

_id_2CD6(var_0) {
  var_1 = 6000;
  var_2 = gettime();

  if(var_2 - self.bt.lasttimefired > var_1)
    return anim.success;

  return anim.failure;
}

_id_7FCB() {
  var_0 = self._blackboard.shootparams;
  var_1 = [];
  var_2 = _id_357C();

  foreach(var_4 in var_2) {
    var_5 = var_0._id_13CC3[var_4];

    if(isDefined(var_5)) {
      if(isDefined(var_5.ent)) {
        var_1[var_1.size] = var_5.ent;
        continue;
      }

      if(isDefined(var_5._id_EF76)) {
        foreach(var_7 in var_5._id_EF76)
        var_1[var_1.size] = var_7;
      }
    }
  }

  var_10 = undefined;
  var_11 = undefined;
  var_12 = 0;

  foreach(var_14 in var_1) {
    var_15 = self lastknowntime(var_14);

    if(var_15 > var_12) {
      var_12 = var_15;
      var_10 = var_14;
    }
  }

  return var_10;
}

_id_B4EA(var_0) {
  if(isDefined(self.pathgoalpos))
    return anim.failure;

  if(self.script == "cover_arrival")
    return anim.failure;

  if(gettime() - self.bt.lasttimefired < 1000)
    return anim.failure;

  return anim.success;
}

_id_80DC(var_0) {
  if(isDefined(var_0)) {
    var_1 = 24;

    if(!isDefined(self._id_DD25))
      self._id_DD25 = 0;

    var_2 = self lastknownpos(var_0);
    var_3 = 256 + self._id_DD25 * var_1;
    var_4 = getrandomnavpoints(var_2, var_3, 1, self);

    if(!isDefined(var_4) || var_4.size == 0)
      return undefined;

    return var_4[0];
  }

  return undefined;
}

_id_4459(var_0, var_1, var_2) {
  var_3 = distance2dsquared(var_2, var_0.origin);
  var_4 = distance2dsquared(var_2, var_1.origin);
  return var_3 < var_4;
}

_id_1043E(var_0, var_1) {
  var_2 = var_1.origin;

  for(var_3 = 1; var_3 < var_0.size; var_3++) {
    var_4 = var_0[var_3];

    for(var_5 = var_3 - 1; var_5 >= 0; var_5--) {
      if(_id_4459(var_0[var_5], var_4, var_2)) {
        break;
      }

      var_0[var_5 + 1] = var_0[var_5];
    }

    var_0[var_5 + 1] = var_4;
  }

  return var_0;
}

_id_80DD(var_0) {
  if(isDefined(var_0)) {
    var_1 = var_0.node;

    if(!isDefined(var_1))
      var_1 = getclosestnodeinsight(var_0.origin);

    if(isDefined(var_1)) {
      var_2 = getnodesinradius(self.origin, 512, 72, 72);
      var_3 = [];
      var_4 = var_2.size;

      for(var_5 = 0; var_5 < var_4; var_5++) {
        var_6 = var_2[var_5];

        if(nodesvisible(var_6, var_1) && distance2dsquared(var_6.origin, var_0.origin) >= squared(256))
          var_3[var_3.size] = var_6;
      }

      if(var_3.size > 0) {
        var_7 = _id_1043E(var_3, var_0);
        var_8 = var_7[0];
        var_9 = getclosestpointonnavmesh(var_8.origin, self);

        if(distance2dsquared(var_9, self.origin) > 16384)
          return var_9;
      }
    }
  }

  return undefined;
}

_id_F814(var_0) {
  var_1 = _id_7FCB();

  if(!self _meth_84BA() && (!isDefined(var_1) || !self _meth_84BA(var_1.origin)))
    return anim.failure;

  if(isDefined(var_1)) {
    var_2 = _id_80DD(var_1);

    if(!isDefined(var_2))
      var_2 = _id_80DC(var_1);

    if(isDefined(var_2)) {
      self.btgoalradius = 128;
      self _meth_8481(var_2);
      self._blackboard._id_C974 = var_1;
      return anim.success;
    }
  }

  return anim.failure;
}

_id_12845(var_0) {
  if(!isDefined(self.pathgoalpos))
    return anim.failure;

  var_1 = self _meth_84B6();

  if(!isDefined(var_1) || distancesquared(var_1, self.origin) < 1296) {
    self clearpath();
    self _meth_8484();
    return anim.failure;
  }

  self _meth_8481(var_1);
  return anim.success;
}

_id_41D4(var_0) {
  self._id_DD25 = undefined;
}

_id_9E1B(var_0) {
  if(!isDefined(var_0))
    return 0;

  var_1 = self._blackboard.shootparams;
  var_2 = _id_357C();

  foreach(var_4 in var_2) {
    var_5 = var_1._id_13CC3[var_4];

    if(isDefined(var_5)) {
      if(isDefined(var_5.ent) && var_5.ent == var_0)
        return 1;
    }
  }

  return 0;
}

_id_213A() {
  var_0 = self._blackboard.shootparams;
  var_1 = 0;
  var_2 = anglesToForward(self.angles);
  var_3 = _id_357C();

  foreach(var_5 in var_3) {
    var_6 = var_0._id_13CC3[var_5];

    if(isDefined(var_6) && isDefined(var_6.ent)) {
      var_7 = var_6.ent.origin - self.origin;

      if(vectordot(var_7, var_2) < 0) {
        var_1 = 1;
        break;
      }
    }
  }

  return var_1;
}

_id_1382A(var_0) {
  if(!isDefined(self.pathgoalpos))
    return anim.success;

  if(_id_3906(var_0) == anim.success)
    return anim.success;

  if(!isDefined(self._blackboard._id_C974))
    return anim.success;

  if(!_id_9E1B(self._blackboard._id_C974))
    return anim.success;

  var_1 = self pathdisttogoal();

  if(var_1 < 175 && _id_213A())
    return anim.success;

  return anim.running;
}

_id_41B3(var_0) {
  if(isDefined(self.pathgoalpos)) {
    var_1 = 84;
    var_2 = self getposonpath(var_1);
    self _meth_8481(var_2);
  }

  return anim.success;
}

_id_128A9(var_0) {
  if(!self.bt._id_E5FA)
    return anim.failure;

  if(scripts\asm\asm_bb::bb_isrodeorequested())
    return anim.success;

  if(isDefined(self._id_30E7) && self._id_30E7)
    return anim.failure;

  if(!isDefined(level.player))
    return anim.failure;

  if(!isalive(level.player))
    return anim.failure;

  if(self.team == level.player.team)
    return anim.failure;

  if(distancesquared(level.player.origin, self.origin) > 90000)
    return anim.failure;

  var_1 = undefined;

  if(scripts\asm\asm_bb::bb_canrodeo("left"))
    var_1 = "left";
  else if(scripts\asm\asm_bb::bb_canrodeo("right"))
    var_1 = "right";

  if(!isDefined(var_1))
    return anim.failure;

  var_2 = anglestoright(self gettagangles("j_spineupper"));
  var_3 = level.player.origin - self gettagorigin("j_spineupper");
  var_4 = angleclamp180(vectortoyaw(var_3) - vectortoyaw(var_2));
  var_5 = 1;

  if(var_1 == "right")
    var_5 = var_5 * -1;

  var_6 = 0;

  if(_id_1E76(var_4, var_5 * -60, var_5 * 60)) {
    var_6 = 1;
    self._id_E5F8 = "front";
  } else if(_id_1E76(var_4, var_5 * 60, var_5 * 120))
    self._id_E5F8 = var_1;
  else if(_id_1E76(var_4, var_5 * -60, var_5 * -160)) {
    var_6 = 1;

    if(var_1 == "left")
      self._id_E5F8 = "right";
    else
      self._id_E5F8 = "left";
  } else
    self._id_E5F8 = "rear";

  if(!isplayerusing(var_6))
    return anim.failure;

  if(isDefined(self.melee))
    self notify("asm_stop_grabtargetthread");

  scripts\asm\asm_bb::bb_setrodeorequest(var_1);
  return anim.success;
}

_id_1E76(var_0, var_1, var_2) {
  return var_0 >= var_1 && var_0 <= var_2 || var_0 <= var_1 && var_0 >= var_2;
}

isplayerusing(var_0) {
  var_1 = self gettagorigin("j_spineupper");
  var_2 = vectortoangles(anglestoright(self gettagangles("j_spineupper")));
  var_3 = var_1 + rotatevector((-20, 0, 30), var_2);
  var_4 = level.player getEye();

  if(var_4[2] < var_3[2] - 90)
    return 0;

  if(var_4[2] < var_3[2] && (var_0 || level.player getvelocity()[2] < 1))
    return 0;

  if(var_4[2] > var_3[2] + 90)
    return 0;

  if(distance2dsquared(var_4, var_3) > 12000)
    return 0;

  if(!level.player scripts\common\trace::player_trace_passed(level.player.origin, var_1, level.player.angles, [self, level.player]))
    return 0;

  return 1;
}

_id_4F40() {}

_id_4F3E() {}

_id_4F3D(var_0) {}

_id_4F3F(var_0, var_1, var_2) {}

_id_4F43() {}

_id_E602(var_0) {
  if(isDefined(self._blackboard._id_E5FD) && !self._blackboard._id_E5FD) {
    if(isDefined(self.bt._id_E5FB)) {
      self.bt._id_E5FB = undefined;
      self.btgoalradius = 32;
      self _meth_8481(self.origin);
    }

    if(isDefined(self._id_30EA))
      scripts\asm\asm_bb::bb_setcanrodeo(self._blackboard.rodeorequested, 0);

    self._blackboard.rodeorequested = undefined;
    self._blackboard._id_E5FD = undefined;
    return anim.failure;
  }

  if(!isDefined(self.bt._id_E5FB)) {
    var_1 = scripts\engine\utility::getStructArray("c12_rodeo_struct", "targetname");

    if(var_1.size == 0) {
      self.bt._id_E5FB = self.origin;
      self.btgoalradius = 32;
    } else {
      var_2 = sortbydistance(var_1, self.origin)[0];
      self.bt._id_E5FB = getclosestpointonnavmesh(var_2.origin, self);
      self.btgoalradius = max(var_2.radius - 180, 32);
    }

    self _meth_8481(self.bt._id_E5FB);
  }

  return anim.running;
}

_id_12F13(var_0) {
  if(isDefined(self.bt._id_F1F8))
    return anim.running;

  self notify("self_destruct");
  thread _id_F1F8();
  thread _id_F1FA();
  return anim.running;
}

_id_F1F8() {
  self endon("death");
  createnavrepulsor("c12_selfdestruct", -1, self, 1024, 1);
  self.ignoreme = 1;
  self.bt._id_F1F8 = 1;
  wait 0.2;
  playFXOnTag(level._id_7649["c12_selfdestruct_buildup"], self, "j_spineupper");
  self playSound("c12_selfdestruct_1beep", "beep_done", 1);
  self waittill("beep_done");
  _id_F1FB();
  self.asm._id_F1FD = 1;
  self _meth_81D0(self.origin, level.player);
}

_id_F1FA() {
  self endon("death");
  self.btgoalradius = 128;
  var_0 = self.origin;

  for(;;) {
    if(distance2dsquared(var_0, level.player.origin) > squared(self.btgoalradius)) {
      var_0 = getclosestpointonnavmesh(level.player.origin, self);
      self _meth_8481(var_0);
    }

    wait 1;
  }
}

_id_F1FB() {
  self endon("death");
  var_0 = 1;

  for(var_1 = 0; var_1 < 4; var_1++) {
    if(soundexists("c12_selfdestruct_beep")) {
      self playSound("c12_selfdestruct_beep");
      wait 0.8;
    } else
      wait 1;

    var_0 = var_0 - 0.2;
    var_0 = max(0, var_0);

    if(var_0 > 0)
      wait(var_0);
  }
}

_id_35AD(var_0, var_1) {
  if(scripts\asm\asm_bb::ispartdismembered("right_arm") || scripts\asm\asm_bb::ispartdismembered("right_leg") || scripts\asm\asm_bb::ispartdismembered("left_leg"))
    return 0;

  if(scripts\asm\asm_bb::bb_isrodeorequested())
    return 0;

  var_2 = self.enemy;

  if(isDefined(var_0))
    var_2 = var_0;

  if(!isPlayer(var_2))
    return 0;

  var_3 = vectortoyaw(var_2.origin - self.origin);

  if(abs(angleclamp180(var_3 - self.angles[1])) > 90)
    return anim.failure;

  return _id_0A10::ismeleevalid(var_0, var_1);
}

_id_128AE(var_0, var_1) {
  var_2 = self._blackboard.shootparams;
  var_3 = gettime();

  if(isDefined(self.asm._id_2AD2)) {
    var_2._id_A993 = var_3;
    return;
  }

  if(var_3 - var_2._id_A98F < 500) {
    return;
  }
  if(var_3 - var_2._id_A993 < 10000) {
    return;
  }
  if(!isDefined(var_1.ent)) {
    return;
  }
  var_4 = var_1.ent;
  var_5 = var_4.origin - self.origin;
  var_6 = lengthsquared(var_5);

  if(var_6 < 40000) {
    return;
  }
  var_2._id_A98F = var_3;
  var_7 = 128;
  var_8 = sqrt(var_6);

  if(var_8 < 800)
    var_7 = var_7 * (1 - (800 - var_8) / 800);

  var_7 = randomfloat(var_7);
  var_9 = randomfloat(360);
  var_10 = var_4.origin + (var_7 * cos(var_9), var_7 * sin(var_9), 0);

  if(var_0 == "left")
    var_11 = "tag_brass_le";
  else
    var_11 = "tag_brass_ri";

  var_12 = self gettagangles(var_11);
  var_13 = self gettagorigin(var_11) + rotatevector((0, -10, 0), var_12);
  var_14 = self _meth_81ED(var_13, var_10);

  if(isDefined(var_14)) {
    self playSound("c12_grenade_launch");
    var_14 makeunusable();
    var_2._id_A993 = var_3;
  }
}