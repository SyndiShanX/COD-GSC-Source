/*******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\anim\cover_behavior.gsc
*******************************************/

main(var_0) {
  self._id_46A6 = self.origin;
  var_1 = gettime();
  var_2 = spawnStruct();
  var_2._id_BF6E = var_1 - 1;
  var_2._id_BF6F = var_1 - 1;
  _id_E257();
  _id_E267();
  self._id_F17F = gettime();
  self.a._id_A97A = var_1;
  self.a._id_9302 = 0;
  self.a.movement = "stop";
  self._id_B600 = var_1 + 3000;
  thread _id_13B72();
  var_3 = gettime() > 2500;

  for(;;) {
    if(isDefined(self.cover) && isDefined(self.cover._id_71C6)) {
      var_4 = gettime();
      thread _id_6335();
      [[self.cover._id_71C6]]();

      if(gettime() == var_4)
        self notify("dont_end_idle");
    }

    if(scripts\anim\combat_utility::_id_10026()) {
      if(scripts\anim\combat_utility::_id_128AA(1)) {
        wait 0.05;
        continue;
      }
    }

    if(isDefined(var_0._id_B24A)) {
      var_4 = gettime();
      thread _id_6335();
      [[var_0._id_B24A]]();

      if(gettime() == var_4)
        self notify("dont_end_idle");
    }

    if(isDefined(var_0._id_BD1C)) {
      if([[var_0._id_BD1C]]())
        continue;
    }

    if(scripts\engine\utility::actor_is3d())
      self _meth_8272(self.covernode.origin);
    else
      self _meth_8272(self.covernode.origin, _id_7E3D());

    if(!var_3) {
      _id_92CC(var_0, 0.05 + randomfloat(1.5));
      var_3 = 1;
      continue;
    }

    if(_id_5927(var_0)) {
      continue;
    }
    if(isDefined(anim._id_11813) && isalive(level.player)) {
      if(_id_128AF(var_0, level.player))
        continue;
    }

    if(_id_E29E()) {
      return;
    }
    var_5 = 0;
    var_6 = 0;

    if(isalive(self.enemy)) {
      var_5 = _id_9DDA();
      var_6 = scripts\anim\utility_common::cansuppressenemyfromexposed();
    }

    if(var_5) {
      if(self.a._id_7E0C < gettime()) {
        if(scripts\anim\combat_utility::_id_B019())
          return;
      }

      _id_2538(var_0);
      continue;
    }

    if(isDefined(self._id_190C) || scripts\anim\utility_common::enemyishiding()) {
      if(_id_18D4())
        return;
    }

    if(var_6) {
      _id_2533(var_0, var_2);
      continue;
    }

    if(_id_252A(var_0, var_2))
      return;
  }
}

#using_animtree("generic_human");

end_script(var_0) {
  if(getdvarint("ai_iw7", 0) == 1) {
    return;
  }
  self._id_129B3 = undefined;
  self.a._id_D892 = undefined;

  if(isDefined(self._id_B600) && self._id_B600 <= gettime()) {
    self._id_B5FF = gettime() + 5000;
    self._id_B600 = undefined;
  }

  self clearanim(%head, 0.2);
  self.facialidx = undefined;
}

_id_7E3D() {
  if(scripts\engine\utility::actor_is3d())
    return self.covernode.angles;

  var_0 = (self.covernode.angles[0], scripts\asm\shared\utility::getnodeforwardyaw(self.covernode), self.covernode.angles[2]);
  return var_0;
}

_id_E29E() {
  if(self atdangerousnode() && self.a._id_E29F < gettime()) {
    if(scripts\anim\combat_utility::_id_B019())
      return 1;

    self.a._id_E29F = gettime() + 30000;
  }

  return 0;
}

_id_5927(var_0) {
  if(_id_112C9(var_0)) {
    if(_id_9DDA())
      _id_E26B();

    self.a._id_A97A = gettime();
    return 1;
  }

  if(_id_4742(var_0, 0))
    return 1;

  return 0;
}

_id_2538(var_0) {
  if(distancesquared(self.origin, self.enemy.origin) > 562500) {
    if(_id_128AF(var_0, self.enemy))
      return;
  }

  if(_id_AB2D(var_0, "normal")) {
    _id_E26B();
    self.a._id_A97A = gettime();
  } else
    _id_92CC(var_0);
}

_id_2533(var_0, var_1) {
  if(self.doingambush) {
    if(_id_AB2D(var_0, "ambush"))
      return;
  } else if(self.providecoveringfire || gettime() >= var_1._id_BF6F) {
    var_2 = "suppress";

    if(!self.providecoveringfire && gettime() - self._id_AA22 > 5000 && randomint(3) < 2)
      var_2 = "ambush";
    else if(!scripts\anim\shoot_behavior::_id_100A4())
      var_2 = "ambush";

    if(_id_AB2D(var_0, var_2)) {
      var_1._id_BF6F = gettime() + randomintrange(3000, 20000);

      if(_id_9DDA())
        self.a._id_A97A = gettime();

      return;
    }
  }

  if(_id_128AF(var_0, self.enemy)) {
    return;
  }
  _id_92CC(var_0);
}

_id_252A(var_0, var_1) {
  if(_id_4742(var_0, 0.1))
    return 0;

  if(isDefined(self.enemy)) {
    if(_id_128AF(var_0, self.enemy))
      return 0;
  }

  if(!self.doingambush && gettime() >= var_1._id_BF6E) {
    if(_id_B01C(var_0)) {
      var_1._id_BF6E = gettime() + randomintrange(4000, 15000);
      return 0;
    }
  }

  if(gettime() > self.a._id_7E0C) {
    if(_id_3926())
      return 1;
  }

  if(self.doingambush || gettime() >= var_1._id_BF6F && isDefined(self.enemy)) {
    if(_id_AB2D(var_0, "ambush")) {
      if(_id_9DDA())
        _id_E26B();

      self.a._id_A97A = gettime();
      var_1._id_BF6F = gettime() + randomintrange(6000, 20000);
      return 0;
    }
  }

  _id_92CC(var_0);
  return 0;
}

_id_9DDA() {
  if(!isDefined(self.enemy))
    return 0;

  if(distancesquared(self.enemy.origin, self._id_46A6) < 256)
    return 0;
  else
    return scripts\anim\utility_common::canseeenemyfromexposed();
}

_id_112C9(var_0) {
  if(!scripts\anim\utility_common::issuppressedwrapper())
    return 0;

  var_1 = gettime();
  var_2 = 1;

  while(scripts\anim\utility_common::issuppressedwrapper()) {
    var_2 = 0;
    self _meth_8272(self.covernode.origin);
    var_3 = 1;

    if(isDefined(self._id_6BAB))
      var_3 = scripts\engine\utility::cointoss();

    if(var_3) {
      if(_id_128B1(var_0)) {
        self notify("killanimscript");
        return 1;
      }
    }

    if(self.a._id_2411 && scripts\anim\utility_common::canseeenemy())
      return 0;

    if(_id_9DDA() || scripts\anim\utility_common::cansuppressenemyfromexposed()) {
      if(isDefined(anim._id_11813) && isalive(level.player)) {
        if(_id_128AF(var_0, level.player))
          continue;
      }

      if(_id_4742(var_0, 0)) {
        continue;
      }
      if(self.team != "allies" && gettime() >= var_1) {
        if(_id_2B99(var_0)) {
          var_1 = gettime();

          if(!isDefined(self._id_6BAB))
            var_1 = var_1 + randomintrange(3000, 12000);

          continue;
        }
      }

      if(_id_128AF(var_0, self.enemy)) {
        var_2 = 1;
        continue;
      }
    }

    if(_id_4742(var_0, 0.1)) {
      continue;
    }
    _id_92CC(var_0);
  }

  if(!var_2 && randomint(2) == 0)
    _id_B018(var_0);

  return 1;
}

_id_805E(var_0) {
  var_1 = [];

  if(var_0 == 1)
    var_1[0] = 0;
  else if(var_0 == 2) {
    var_1[0] = randomint(2);
    var_1[1] = 1 - var_1[0];
  } else {
    for(var_2 = 0; var_2 < var_0; var_2++)
      var_1[var_2] = var_2;

    for(var_2 = 0; var_2 < var_0; var_2++) {
      var_3 = var_2 + randomint(var_0 - var_2);
      var_4 = var_1[var_3];
      var_1[var_3] = var_1[var_2];
      var_1[var_2] = var_4;
    }
  }

  return var_1;
}

_id_3773(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_0))
    return 0;

  thread _id_6335();
  var_4 = gettime();
  var_5 = undefined;

  if(isDefined(var_3))
    var_5 = [[var_0]](var_1, var_2, var_3);
  else if(isDefined(var_2))
    var_5 = [[var_0]](var_1, var_2);
  else if(isDefined(var_1))
    var_5 = [[var_0]](var_1);
  else
    var_5 = [[var_0]]();

  if(!var_5)
    self notify("dont_end_idle");

  return var_5;
}

_id_13B72() {
  self endon("killanimscript");
  self._id_AA22 = gettime() - 100000;
  self.suppressionstart = self._id_AA22;

  for(;;) {
    self waittill("suppression");
    var_0 = gettime();

    if(self._id_AA22 < var_0 - 700)
      self.suppressionstart = var_0;

    self._id_AA22 = var_0;
  }
}

_id_4742(var_0, var_1) {
  if(self.bulletsinclip > weaponclipsize(self.weapon) * var_1)
    return 0;

  self.isreloading = 1;
  var_2 = _id_3773(var_0.reload);
  self.isreloading = 0;
  return var_2;
}

_id_AB2D(var_0, var_1) {
  thread scripts\anim\shoot_behavior::_id_4F69(var_1);

  if(!self.fixednode && !self.doingambush)
    thread _id_2FBF();

  var_2 = _id_3773(var_0._id_AB2D);
  self notify("stop_deciding_how_to_shoot");
  return var_2;
}

_id_B01C(var_0) {
  if(self.a._id_2411 && scripts\anim\utility_common::canseeenemy())
    return 0;

  if(self.a._id_A97A + 6000 > gettime())
    return _id_B018(var_0);
  else {
    var_1 = _id_3773(var_0.look, 2 + randomfloat(2));

    if(var_1)
      return 1;

    return _id_3773(var_0._id_6B9B);
  }
}

_id_B018(var_0) {
  var_1 = _id_3773(var_0._id_6B9B);

  if(var_1)
    return 1;

  return _id_3773(var_0.look, 0);
}

_id_92CC(var_0, var_1) {
  self._id_6F28 = 0;

  if(isDefined(var_0._id_6F27)) {
    if(!self.a._id_9302 && gettime() - self.suppressionstart < 600) {
      if([[var_0._id_6F27]]())
        return 1;
    } else
      thread _id_6F29(var_0);
  }

  if(!self.a._id_9302) {
    thread _id_92FF(var_0._id_92CC);
    self.a._id_9302 = 1;
  }

  if(isDefined(var_1))
    _id_9300(var_1);
  else
    _id_9301();

  if(self._id_6F28)
    self waittill("flinch_done");

  self notify("stop_waiting_to_flinch");
}

_id_9300(var_0) {
  self endon("end_idle");
  wait(var_0);
}

_id_9301() {
  self endon("end_idle");
  wait(0.3 + randomfloat(0.1));
  self waittill("do_slow_things");
}

_id_92FF(var_0) {
  self endon("killanimscript");
  self[[var_0]]();
}

_id_6F29(var_0) {
  self endon("killanimscript");
  self endon("stop_waiting_to_flinch");
  var_1 = self._id_AA22;

  for(;;) {
    self waittill("suppression");
    var_2 = gettime();

    if(var_1 < var_2 - 2000) {
      break;
    }

    var_1 = var_2;
  }

  self._id_6F28 = 1;
  thread _id_6335();
  var_3 = [[var_0._id_6F27]]();

  if(!var_3)
    self notify("dont_end_idle");

  self._id_6F28 = 0;
  self notify("flinch_done");
}

_id_6335() {
  self endon("killanimscript");
  self endon("dont_end_idle");
  waittillframeend;

  if(!isDefined(self)) {
    return;
  }
  self notify("end_idle");
  self.a._id_9302 = 0;
}

_id_128AF(var_0, var_1) {
  var_2 = anglesToForward(self.angles);
  var_3 = vectorNormalize(var_1.origin - self.origin);

  if(vectordot(var_2, var_3) < 0)
    return 0;

  if(self.doingambush && !scripts\anim\utility_common::recentlysawenemy())
    return 0;

  if(scripts\anim\utility::_id_9ED4())
    return _id_3773(var_0._id_85BF, var_1);
  else
    return _id_3773(var_0.grenade, var_1);
}

_id_2B99(var_0) {
  if(!scripts\anim\utility::_id_3875())
    return 0;

  return _id_3773(var_0._id_2B99);
}

_id_2FBF() {
  self endon("killanimscript");
  self endon("stop_deciding_how_to_shoot");

  for(;;) {
    if(self.fixednode || self.doingambush) {
      return;
    }
    wait(0.5 + randomfloat(0.75));

    if(!isDefined(self.enemy)) {
      continue;
    }
    if(scripts\anim\utility_common::enemyishiding()) {
      if(_id_18D4())
        return;
    }

    if(!scripts\anim\utility_common::recentlysawenemy() && !scripts\anim\utility_common::cansuppressenemy()) {
      if(gettime() > self.a._id_7E0C) {
        if(_id_3926())
          return;
      }
    }
  }
}

_id_E267() {
  self.a._id_E29F = 0;
}

_id_E257() {
  var_0 = gettime();

  if(isDefined(self._id_54C3) && var_0 > self.a._id_7E0C)
    self.a._id_7E0C = var_0 + randomintrange(2000, 5000);
  else if(isDefined(self.enemy)) {
    var_1 = distance2d(self.origin, self.enemy.origin);

    if(var_1 < self.engagemindist) {
      self.a._id_7E0C = var_0 + randomintrange(5000, 10000);
      return;
    }

    if(var_1 > self.engagemaxdist && var_1 < self.goalradius) {
      self.a._id_7E0C = var_0 + randomintrange(2000, 5000);
      return;
    }

    self.a._id_7E0C = var_0 + randomintrange(10000, 15000);
    return;
    return;
  } else
    self.a._id_7E0C = var_0 + randomintrange(5000, 15000);
}

_id_E26B() {
  if(isDefined(self._id_190C))
    self._id_F17F = gettime() + randomintrange(500, 1000);
  else
    self._id_F17F = gettime() + randomintrange(3000, 5000);
}

_id_3926() {
  return _id_18D4();
}

_id_18D4() {
  if(self.fixednode || self.doingambush)
    return 0;

  if(isDefined(self._id_190C) && gettime() >= self._id_F17F)
    return scripts\anim\combat_utility::_id_128AA(0);

  var_0 = 0;

  if(!isDefined(self.enemy) || !self.enemy scripts\engine\utility::isflashed())
    var_0 = scripts\anim\combat_utility::_id_B019();

  if(!var_0 && isDefined(self.enemy) && !scripts\anim\utility_common::canseeenemyfromexposed()) {
    if(gettime() >= self._id_F17F)
      return scripts\anim\combat_utility::_id_128AA(0);
  }

  return var_0;
}

_id_128B1(var_0) {
  if(isDefined(var_0._id_BD1C)) {
    if([[var_0._id_BD1C]]())
      return 1;
  }

  return scripts\anim\combat_utility::_id_B019();
}

_id_F5AE() {
  var_0 = scripts\anim\utility::_id_B028("exposed_turn");

  foreach(var_3, var_2 in var_0)
  self.a._id_2274[var_3] = var_2;
}

_id_F318() {
  var_0 = scripts\anim\utility::_id_B028("exposed_turn_crouch");

  foreach(var_3, var_2 in var_0)
  self.a._id_2274[var_3] = var_2;
}

_id_129B4(var_0) {}

_id_BD1C() {
  if(!isDefined(self.enemy))
    return 0;

  if(isDefined(self._id_54C3)) {
    self._id_54C3 = undefined;
    return 0;
  }

  if(!isDefined(self.node))
    return 0;

  if(scripts\engine\utility::isnodecover3d(self.node))
    return 0;

  if(randomint(3) == 0)
    return 0;

  if(self.fixednode || self.doingambush || self.keepclaimednode || self.keepclaimednodeifvalid)
    return 0;

  if(distancesquared(self.origin, self.node.origin) > 256)
    return 0;

  var_0 = self _meth_80E8();

  if(isDefined(var_0) && var_0 != self.node && self _meth_83D4(var_0)) {
    self._id_1016F = 1;
    self.shufflenode = var_0;
    self._id_54C3 = 1;
    wait 0.5;
    return 1;
  }

  return 0;
}