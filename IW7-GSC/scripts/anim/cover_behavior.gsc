/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\anim\cover_behavior.gsc
*********************************************/

main(var_0) {
  self.var_46A6 = self.origin;
  var_1 = gettime();
  var_2 = spawnStruct();
  var_2.var_BF6E = var_1 - 1;
  var_2.var_BF6F = var_1 - 1;
  func_E257();
  func_E267();
  self.var_F17F = gettime();
  self.a.var_A97A = var_1;
  self.a.var_9302 = 0;
  self.a.movement = "stop";
  self.var_B600 = var_1 + 3000;
  thread func_13B72();
  var_3 = gettime() > 2500;
  for(;;) {
    if(isDefined(self.var_C2) && isDefined(self.var_C2.var_71C6)) {
      var_4 = gettime();
      thread func_6335();
      [
        [self.var_C2.var_71C6]
      ]();
      if(gettime() == var_4) {
        self notify("dont_end_idle");
      }
    }

    if(scripts\anim\combat_utility::func_10026()) {
      if(scripts\anim\combat_utility::func_128AA(1)) {
        wait(0.05);
        continue;
      }
    }

    if(isDefined(var_0.var_B24A)) {
      var_4 = gettime();
      thread func_6335();
      [
        [var_0.var_B24A]
      ]();
      if(gettime() == var_4) {
        self notify("dont_end_idle");
      }
    }

    if(isDefined(var_0.var_BD1C)) {
      if([[var_0.var_BD1C]]()) {
        continue;
      }
    }

    if(scripts\engine\utility::actor_is3d()) {
      self ghost_target_position(self.covernode.origin);
    } else {
      self ghost_target_position(self.covernode.origin, func_7E3D());
    }

    if(!var_3) {
      func_92CC(var_0, 0.05 + randomfloat(1.5));
      var_3 = 1;
      continue;
    }

    if(func_5927(var_0)) {
      continue;
    }

    if(isDefined(level.var_11813) && isalive(level.player)) {
      if(func_128AF(var_0, level.player)) {
        continue;
      }
    }

    if(func_E29E()) {
      return;
    }

    var_5 = 0;
    var_6 = 0;
    if(isalive(self.isnodeoccupied)) {
      var_5 = func_9DDA();
      var_6 = scripts\anim\utility_common::cansuppressenemyfromexposed();
    }

    if(var_5) {
      if(self.a.var_7E0C < gettime()) {
        if(scripts\anim\combat_utility::func_B019()) {
          return;
        }
      }

      func_2538(var_0);
      continue;
    }

    if(isDefined(self.var_190C) || scripts\anim\utility_common::enemyishiding()) {
      if(func_18D4()) {
        return;
      }
    }

    if(var_6) {
      func_2533(var_0, var_2);
      continue;
    }

    if(func_252A(var_0, var_2)) {
      return;
    }
  }
}

end_script(var_0) {
  if(getdvarint("ai_iw7", 0) == 1) {
    return;
  }

  self.var_129B3 = undefined;
  self.a.var_D892 = undefined;
  if(isDefined(self.var_B600) && self.var_B600 <= gettime()) {
    self.var_B5FF = gettime() + 5000;
    self.var_B600 = undefined;
  }

  self clearanim( % head, 0.2);
  self.facialidx = undefined;
}

func_7E3D() {
  if(scripts\engine\utility::actor_is3d()) {
    return self.covernode.angles;
  }

  var_0 = (self.covernode.angles[0], scripts\asm\shared_utility::getnodeforwardyaw(self.covernode), self.covernode.angles[2]);
  return var_0;
}

func_E29E() {
  if(self getobjectivescoretext() && self.a.var_E29F < gettime()) {
    if(scripts\anim\combat_utility::func_B019()) {
      return 1;
    }

    self.a.var_E29F = gettime() + 30000;
  }

  return 0;
}

func_5927(var_0) {
  if(func_112C9(var_0)) {
    if(func_9DDA()) {
      func_E26B();
    }

    self.a.var_A97A = gettime();
    return 1;
  }

  if(func_4742(var_0, 0)) {
    return 1;
  }

  return 0;
}

func_2538(var_0) {
  if(distancesquared(self.origin, self.isnodeoccupied.origin) > 562500) {
    if(func_128AF(var_0, self.isnodeoccupied)) {
      return;
    }
  }

  if(func_AB2D(var_0, "normal")) {
    func_E26B();
    self.a.var_A97A = gettime();
    return;
  }

  func_92CC(var_0);
}

func_2533(var_0, var_1) {
  if(self.var_FC) {
    if(func_AB2D(var_0, "ambush")) {
      return;
    }
  } else if(self.assertmsg || gettime() >= var_1.var_BF6F) {
    var_2 = "suppress";
    if(!self.assertmsg && gettime() - self.var_AA22 > 5000 && randomint(3) < 2) {
      var_2 = "ambush";
    } else if(!scripts\anim\shoot_behavior::func_100A4()) {
      var_2 = "ambush";
    }

    if(func_AB2D(var_0, var_2)) {
      var_1.var_BF6F = gettime() + randomintrange(3000, 20000);
      if(func_9DDA()) {
        self.a.var_A97A = gettime();
      }

      return;
    }
  }

  if(func_128AF(var_0, self.isnodeoccupied)) {
    return;
  }

  func_92CC(var_0);
}

func_252A(var_0, var_1) {
  if(func_4742(var_0, 0.1)) {
    return 0;
  }

  if(isDefined(self.isnodeoccupied)) {
    if(func_128AF(var_0, self.isnodeoccupied)) {
      return 0;
    }
  }

  if(!self.var_FC && gettime() >= var_1.var_BF6E) {
    if(func_B01C(var_0)) {
      var_1.var_BF6E = gettime() + randomintrange(4000, 15000);
      return 0;
    }
  }

  if(gettime() > self.a.var_7E0C) {
    if(func_3926()) {
      return 1;
    }
  }

  if(self.var_FC || gettime() >= var_1.var_BF6F && isDefined(self.isnodeoccupied)) {
    if(func_AB2D(var_0, "ambush")) {
      if(func_9DDA()) {
        func_E26B();
      }

      self.a.var_A97A = gettime();
      var_1.var_BF6F = gettime() + randomintrange(6000, 20000);
      return 0;
    }
  }

  func_92CC(var_0);
  return 0;
}

func_9DDA() {
  if(!isDefined(self.isnodeoccupied)) {
    return 0;
  }

  if(distancesquared(self.isnodeoccupied.origin, self.var_46A6) < 256) {
    return 0;
  }

  return scripts\anim\utility_common::canseeenemyfromexposed();
}

func_112C9(var_0) {
  if(!scripts\anim\utility_common::issuppressedwrapper()) {
    return 0;
  }

  var_1 = gettime();
  var_2 = 1;
  while(scripts\anim\utility_common::issuppressedwrapper()) {
    var_2 = 0;
    self ghost_target_position(self.covernode.origin);
    var_3 = 1;
    if(isDefined(self.var_6BAB)) {
      var_3 = scripts\engine\utility::cointoss();
    }

    if(var_3) {
      if(func_128B1(var_0)) {
        self notify("killanimscript");
        return 1;
      }
    }

    if(self.a.var_2411 && scripts\anim\utility_common::canseeenemy()) {
      return 0;
    }

    if(func_9DDA() || scripts\anim\utility_common::cansuppressenemyfromexposed()) {
      if(isDefined(level.var_11813) && isalive(level.player)) {
        if(func_128AF(var_0, level.player)) {
          continue;
        }
      }

      if(func_4742(var_0, 0)) {
        continue;
      }

      if(self.team != "allies" && gettime() >= var_1) {
        if(func_2B99(var_0)) {
          var_1 = gettime();
          if(!isDefined(self.var_6BAB)) {
            var_1 = var_1 + randomintrange(3000, 12000);
          }

          continue;
        }
      }

      if(func_128AF(var_0, self.isnodeoccupied)) {
        var_2 = 1;
        continue;
      }
    }

    if(func_4742(var_0, 0.1)) {
      continue;
    }

    func_92CC(var_0);
  }

  if(!var_2 && randomint(2) == 0) {
    func_B018(var_0);
  }

  return 1;
}

_meth_805E(var_0) {
  var_1 = [];
  if(var_0 == 1) {
    var_1[0] = 0;
  } else if(var_0 == 2) {
    var_1[0] = randomint(2);
    var_1[1] = 1 - var_1[0];
  } else {
    for(var_2 = 0; var_2 < var_0; var_2++) {
      var_1[var_2] = var_2;
    }

    for(var_2 = 0; var_2 < var_0; var_2++) {
      var_3 = var_2 + randomint(var_0 - var_2);
      var_4 = var_1[var_3];
      var_1[var_3] = var_1[var_2];
      var_1[var_2] = var_4;
    }
  }

  return var_1;
}

func_3773(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_0)) {
    return 0;
  }

  thread func_6335();
  var_4 = gettime();
  var_5 = undefined;
  if(isDefined(var_3)) {
    var_5 = [[var_0]](var_1, var_2, var_3);
  } else if(isDefined(var_2)) {
    var_5 = [[var_0]](var_1, var_2);
  } else if(isDefined(var_1)) {
    var_5 = [[var_0]](var_1);
  } else {
    var_5 = [[var_0]]();
  }

  if(!var_5) {
    self notify("dont_end_idle");
  }

  return var_5;
}

func_13B72() {
  self endon("killanimscript");
  self.var_AA22 = gettime() - 100000;
  self.suppressionstart = self.var_AA22;
  for(;;) {
    self waittill("suppression");
    var_0 = gettime();
    if(self.var_AA22 < var_0 - 700) {
      self.suppressionstart = var_0;
    }

    self.var_AA22 = var_0;
  }
}

func_4742(var_0, var_1) {
  if(self.bulletsinclip > weaponclipsize(self.var_394) * var_1) {
    return 0;
  }

  self.isreloading = 1;
  var_2 = func_3773(var_0.openfile);
  self.isreloading = 0;
  return var_2;
}

func_AB2D(var_0, var_1) {
  thread scripts\anim\shoot_behavior::func_4F69(var_1);
  if(!self.logstring && !self.var_FC) {
    thread func_2FBF();
  }

  var_2 = func_3773(var_0.var_AB2D);
  self notify("stop_deciding_how_to_shoot");
  return var_2;
}

func_B01C(var_0) {
  if(self.a.var_2411 && scripts\anim\utility_common::canseeenemy()) {
    return 0;
  }

  if(self.a.var_A97A + 6000 > gettime()) {
    return func_B018(var_0);
  }

  var_1 = func_3773(var_0.setnojipscore, 2 + randomfloat(2));
  if(var_1) {
    return 1;
  }

  return func_3773(var_0.var_6B9B);
}

func_B018(var_0) {
  var_1 = func_3773(var_0.var_6B9B);
  if(var_1) {
    return 1;
  }

  return func_3773(var_0.setnojipscore, 0);
}

func_92CC(var_0, var_1) {
  self.var_6F28 = 0;
  if(isDefined(var_0.var_6F27)) {
    if(!self.a.var_9302 && gettime() - self.suppressionstart < 600) {
      if([[var_0.var_6F27]]()) {
        return 1;
      }
    } else {
      thread func_6F29(var_0);
    }
  }

  if(!self.a.var_9302) {
    thread func_92FF(var_0.var_92CC);
    self.a.var_9302 = 1;
  }

  if(isDefined(var_1)) {
    func_9300(var_1);
  } else {
    func_9301();
  }

  if(self.var_6F28) {
    self waittill("flinch_done");
  }

  self notify("stop_waiting_to_flinch");
}

func_9300(var_0) {
  self endon("end_idle");
  wait(var_0);
}

func_9301() {
  self endon("end_idle");
  wait(0.3 + randomfloat(0.1));
  self waittill("do_slow_things");
}

func_92FF(var_0) {
  self endon("killanimscript");
  self[[var_0]]();
}

func_6F29(var_0) {
  self endon("killanimscript");
  self endon("stop_waiting_to_flinch");
  var_1 = self.var_AA22;
  for(;;) {
    self waittill("suppression");
    var_2 = gettime();
    if(var_1 < var_2 - 2000) {
      break;
    }

    var_1 = var_2;
  }

  self.var_6F28 = 1;
  thread func_6335();
  var_3 = [[var_0.var_6F27]]();
  if(!var_3) {
    self notify("dont_end_idle");
  }

  self.var_6F28 = 0;
  self notify("flinch_done");
}

func_6335() {
  self endon("killanimscript");
  self endon("dont_end_idle");
  waittillframeend;
  if(!isDefined(self)) {
    return;
  }

  self notify("end_idle");
  self.a.var_9302 = 0;
}

func_128AF(var_0, var_1) {
  var_2 = anglesToForward(self.angles);
  var_3 = vectornormalize(var_1.origin - self.origin);
  if(vectordot(var_2, var_3) < 0) {
    return 0;
  }

  if(self.var_FC && !scripts\anim\utility_common::recentlysawenemy()) {
    return 0;
  }

  if(scripts\anim\utility::func_9ED4()) {
    return func_3773(var_0._meth_85BF, var_1);
  }

  return func_3773(var_0.objective_position, var_1);
}

func_2B99(var_0) {
  if(!scripts\anim\utility::func_3875()) {
    return 0;
  }

  return func_3773(var_0.var_2B99);
}

func_2FBF() {
  self endon("killanimscript");
  self endon("stop_deciding_how_to_shoot");
  for(;;) {
    if(self.logstring || self.var_FC) {
      return;
    }

    wait(0.5 + randomfloat(0.75));
    if(!isDefined(self.isnodeoccupied)) {
      continue;
    }

    if(scripts\anim\utility_common::enemyishiding()) {
      if(func_18D4()) {
        return;
      }
    }

    if(!scripts\anim\utility_common::recentlysawenemy() && !scripts\anim\utility_common::cansuppressenemy()) {
      if(gettime() > self.a.var_7E0C) {
        if(func_3926()) {
          return;
        }
      }
    }
  }
}

func_E267() {
  self.a.var_E29F = 0;
}

func_E257() {
  var_0 = gettime();
  if(isDefined(self.var_54C3) && var_0 > self.a.var_7E0C) {
    self.a.var_7E0C = var_0 + randomintrange(2000, 5000);
    return;
  }

  if(isDefined(self.isnodeoccupied)) {
    var_1 = distance2d(self.origin, self.isnodeoccupied.origin);
    if(var_1 < self.issentient) {
      self.a.var_7E0C = var_0 + randomintrange(5000, 10000);
      return;
    }

    if(var_1 > self.issaverecentlyloaded && var_1 < self.objective_playermask_showto) {
      self.a.var_7E0C = var_0 + randomintrange(2000, 5000);
      return;
    }

    self.a.var_7E0C = var_0 + randomintrange(10000, 15000);
    return;
  }

  self.a.var_7E0C = var_0 + randomintrange(5000, 15000);
}

func_E26B() {
  if(isDefined(self.var_190C)) {
    self.var_F17F = gettime() + randomintrange(500, 1000);
    return;
  }

  self.var_F17F = gettime() + randomintrange(3000, 5000);
}

func_3926() {
  return func_18D4();
}

func_18D4() {
  if(self.logstring || self.var_FC) {
    return 0;
  }

  if(isDefined(self.var_190C) && gettime() >= self.var_F17F) {
    return scripts\anim\combat_utility::func_128AA(0);
  }

  var_0 = 0;
  if(!isDefined(self.isnodeoccupied) || !self.isnodeoccupied scripts\engine\utility::isflashed()) {
    var_0 = scripts\anim\combat_utility::func_B019();
  }

  if(!var_0 && isDefined(self.isnodeoccupied) && !scripts\anim\utility_common::canseeenemyfromexposed()) {
    if(gettime() >= self.var_F17F) {
      return scripts\anim\combat_utility::func_128AA(0);
    }
  }

  return var_0;
}

func_128B1(var_0) {
  if(isDefined(var_0.var_BD1C)) {
    if([
        [var_0.var_BD1C]
      ]()) {
      return 1;
    }
  }

  return scripts\anim\combat_utility::func_B019();
}

func_F5AE() {
  var_0 = scripts\anim\utility::func_B028("exposed_turn");
  foreach(var_3, var_2 in var_0) {
    self.a.var_2274[var_3] = var_2;
  }
}

func_F318() {
  var_0 = scripts\anim\utility::func_B028("exposed_turn_crouch");
  foreach(var_3, var_2 in var_0) {
    self.a.var_2274[var_3] = var_2;
  }
}

func_129B4(var_0) {}

func_BD1C() {
  if(!isDefined(self.isnodeoccupied)) {
    return 0;
  }

  if(isDefined(self.var_54C3)) {
    self.var_54C3 = undefined;
    return 0;
  }

  if(!isDefined(self.target_getindexoftarget)) {
    return 0;
  }

  if(scripts\engine\utility::isnodecover3d(self.target_getindexoftarget)) {
    return 0;
  }

  if(randomint(3) == 0) {
    return 0;
  }

  if(self.logstring || self.var_FC || self.sendclientmatchdata || self.sendmatchdata) {
    return 0;
  }

  if(distancesquared(self.origin, self.target_getindexoftarget.origin) > 256) {
    return 0;
  }

  var_0 = self _meth_80E8();
  if(isDefined(var_0) && var_0 != self.target_getindexoftarget && self _meth_83D4(var_0)) {
    self.var_1016F = 1;
    self.shufflenode = var_0;
    self.var_54C3 = 1;
    wait(0.5);
    return 1;
  }

  return 0;
}