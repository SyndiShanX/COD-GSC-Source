/*******************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\anim\cover_behavior.gsc
*******************************************/

main(param_00) {
  self.var_46A6 = self.origin;
  var_01 = gettime();
  var_02 = spawnStruct();
  var_02.var_BF6E = var_01 - 1;
  var_02.var_BF6F = var_01 - 1;
  func_E257();
  func_E267();
  self.var_F17F = gettime();
  self.a.var_A97A = var_01;
  self.a.var_9302 = 0;
  self.a.movement = "stop";
  self.var_B600 = var_01 + 3000;
  thread func_13B72();
  var_03 = gettime() > 2500;
  for(;;) {
    if(isDefined(self.var_C2) && isDefined(self.var_C2.var_71C6)) {
      var_04 = gettime();
      thread func_6335();
      [
        [self.var_C2.var_71C6]
      ]();
      if(gettime() == var_04) {
        self notify("dont_end_idle");
      }
    }

    if(scripts\anim\combat_utility::func_10026()) {
      if(scripts\anim\combat_utility::func_128AA(1)) {
        wait(0.05);
        continue;
      }
    }

    if(isDefined(param_00.var_B24A)) {
      var_04 = gettime();
      thread func_6335();
      [
        [param_00.var_B24A]
      ]();
      if(gettime() == var_04) {
        self notify("dont_end_idle");
      }
    }

    if(isDefined(param_00.var_BD1C)) {
      if([
          [param_00.var_BD1C]
        ]()) {
        continue;
      }
    }

    if(scripts\engine\utility::actor_is3d()) {
      self ghost_target_position(self.covernode.origin);
    } else {
      self ghost_target_position(self.covernode.origin, func_7E3D());
    }

    if(!var_03) {
      func_92CC(param_00, 0.05 + randomfloat(1.5));
      var_03 = 1;
      continue;
    }

    if(func_5927(param_00)) {
      continue;
    }

    if(isDefined(level.var_11813) && isalive(level.player)) {
      if(func_128AF(param_00, level.player)) {
        continue;
      }
    }

    if(func_E29E()) {
      return;
    }

    var_05 = 0;
    var_06 = 0;
    if(isalive(self.isnodeoccupied)) {
      var_05 = func_9DDA();
      var_06 = scripts\anim\utility_common::cansuppressenemyfromexposed();
    }

    if(var_05) {
      if(self.a.var_7E0C < gettime()) {
        if(scripts\anim\combat_utility::func_B019()) {
          return;
        }
      }

      func_2538(param_00);
      continue;
    }

    if(isDefined(self.var_190C) || scripts\anim\utility_common::enemyishiding()) {
      if(func_18D4()) {
        return;
      }
    }

    if(var_06) {
      func_2533(param_00, var_02);
      continue;
    }

    if(func_252A(param_00, var_02)) {
      return;
    }
  }
}

end_script(param_00) {
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

  var_00 = (self.covernode.angles[0], scripts\asm\shared_utility::getnodeforwardyaw(self.covernode), self.covernode.angles[2]);
  return var_00;
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

func_5927(param_00) {
  if(func_112C9(param_00)) {
    if(func_9DDA()) {
      func_E26B();
    }

    self.a.var_A97A = gettime();
    return 1;
  }

  if(func_4742(param_00, 0)) {
    return 1;
  }

  return 0;
}

func_2538(param_00) {
  if(distancesquared(self.origin, self.isnodeoccupied.origin) > 562500) {
    if(func_128AF(param_00, self.isnodeoccupied)) {
      return;
    }
  }

  if(func_AB2D(param_00, "normal")) {
    func_E26B();
    self.a.var_A97A = gettime();
    return;
  }

  func_92CC(param_00);
}

func_2533(param_00, param_01) {
  if(self.var_FC) {
    if(func_AB2D(param_00, "ambush")) {
      return;
    }
  } else if(self.assertmsg || gettime() >= param_01.var_BF6F) {
    var_02 = "suppress";
    if(!self.assertmsg && gettime() - self.var_AA22 > 5000 && randomint(3) < 2) {
      var_02 = "ambush";
    } else if(!scripts\anim\shoot_behavior::func_100A4()) {
      var_02 = "ambush";
    }

    if(func_AB2D(param_00, var_02)) {
      param_01.var_BF6F = gettime() + randomintrange(3000, 20000);
      if(func_9DDA()) {
        self.a.var_A97A = gettime();
      }

      return;
    }
  }

  if(func_128AF(param_00, self.isnodeoccupied)) {
    return;
  }

  func_92CC(param_00);
}

func_252A(param_00, param_01) {
  if(func_4742(param_00, 0.1)) {
    return 0;
  }

  if(isDefined(self.isnodeoccupied)) {
    if(func_128AF(param_00, self.isnodeoccupied)) {
      return 0;
    }
  }

  if(!self.var_FC && gettime() >= param_01.var_BF6E) {
    if(func_B01C(param_00)) {
      param_01.var_BF6E = gettime() + randomintrange(4000, 15000);
      return 0;
    }
  }

  if(gettime() > self.a.var_7E0C) {
    if(func_3926()) {
      return 1;
    }
  }

  if(self.var_FC || gettime() >= param_01.var_BF6F && isDefined(self.isnodeoccupied)) {
    if(func_AB2D(param_00, "ambush")) {
      if(func_9DDA()) {
        func_E26B();
      }

      self.a.var_A97A = gettime();
      param_01.var_BF6F = gettime() + randomintrange(6000, 20000);
      return 0;
    }
  }

  func_92CC(param_00);
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

func_112C9(param_00) {
  if(!scripts\anim\utility_common::issuppressedwrapper()) {
    return 0;
  }

  var_01 = gettime();
  var_02 = 1;
  while(scripts\anim\utility_common::issuppressedwrapper()) {
    var_02 = 0;
    self ghost_target_position(self.covernode.origin);
    var_03 = 1;
    if(isDefined(self.var_6BAB)) {
      var_03 = scripts\engine\utility::cointoss();
    }

    if(var_03) {
      if(func_128B1(param_00)) {
        self notify("killanimscript");
        return 1;
      }
    }

    if(self.a.var_2411 && scripts\anim\utility_common::canseeenemy()) {
      return 0;
    }

    if(func_9DDA() || scripts\anim\utility_common::cansuppressenemyfromexposed()) {
      if(isDefined(level.var_11813) && isalive(level.player)) {
        if(func_128AF(param_00, level.player)) {
          continue;
        }
      }

      if(func_4742(param_00, 0)) {
        continue;
      }

      if(self.team != "allies" && gettime() >= var_01) {
        if(func_2B99(param_00)) {
          var_01 = gettime();
          if(!isDefined(self.var_6BAB)) {
            var_01 = var_01 + randomintrange(3000, 12000);
          }

          continue;
        }
      }

      if(func_128AF(param_00, self.isnodeoccupied)) {
        var_02 = 1;
        continue;
      }
    }

    if(func_4742(param_00, 0.1)) {
      continue;
    }

    func_92CC(param_00);
  }

  if(!var_02 && randomint(2) == 0) {
    func_B018(param_00);
  }

  return 1;
}

_meth_805E(param_00) {
  var_01 = [];
  if(param_00 == 1) {
    var_01[0] = 0;
  } else if(param_00 == 2) {
    var_01[0] = randomint(2);
    var_01[1] = 1 - var_01[0];
  } else {
    for(var_02 = 0; var_02 < param_00; var_02++) {
      var_01[var_02] = var_02;
    }

    for(var_02 = 0; var_02 < param_00; var_02++) {
      var_03 = var_02 + randomint(param_00 - var_02);
      var_04 = var_01[var_03];
      var_01[var_03] = var_01[var_02];
      var_01[var_02] = var_04;
    }
  }

  return var_01;
}

func_3773(param_00, param_01, param_02, param_03) {
  if(!isDefined(param_00)) {
    return 0;
  }

  thread func_6335();
  var_04 = gettime();
  var_05 = undefined;
  if(isDefined(param_03)) {
    var_05 = [[param_00]](param_01, param_02, param_03);
  } else if(isDefined(param_02)) {
    var_05 = [[param_00]](param_01, param_02);
  } else if(isDefined(param_01)) {
    var_05 = [[param_00]](param_01);
  } else {
    var_05 = [[param_00]]();
  }

  if(!var_05) {
    self notify("dont_end_idle");
  }

  return var_05;
}

func_13B72() {
  self endon("killanimscript");
  self.var_AA22 = gettime() - 100000;
  self.suppressionstart = self.var_AA22;
  for(;;) {
    self waittill("suppression");
    var_00 = gettime();
    if(self.var_AA22 < var_00 - 700) {
      self.suppressionstart = var_00;
    }

    self.var_AA22 = var_00;
  }
}

func_4742(param_00, param_01) {
  if(self.bulletsinclip > weaponclipsize(self.var_394) * param_01) {
    return 0;
  }

  self.isreloading = 1;
  var_02 = func_3773(param_00.openfile);
  self.isreloading = 0;
  return var_02;
}

func_AB2D(param_00, param_01) {
  thread scripts\anim\shoot_behavior::func_4F69(param_01);
  if(!self.logstring && !self.var_FC) {
    thread func_2FBF();
  }

  var_02 = func_3773(param_00.var_AB2D);
  self notify("stop_deciding_how_to_shoot");
  return var_02;
}

func_B01C(param_00) {
  if(self.a.var_2411 && scripts\anim\utility_common::canseeenemy()) {
    return 0;
  }

  if(self.a.var_A97A + 6000 > gettime()) {
    return func_B018(param_00);
  }

  var_01 = func_3773(param_00.setnojipscore, 2 + randomfloat(2));
  if(var_01) {
    return 1;
  }

  return func_3773(param_00.var_6B9B);
}

func_B018(param_00) {
  var_01 = func_3773(param_00.var_6B9B);
  if(var_01) {
    return 1;
  }

  return func_3773(param_00.setnojipscore, 0);
}

func_92CC(param_00, param_01) {
  self.var_6F28 = 0;
  if(isDefined(param_00.var_6F27)) {
    if(!self.a.var_9302 && gettime() - self.suppressionstart < 600) {
      if([
          [param_00.var_6F27]
        ]()) {
        return 1;
      }
    } else {
      thread func_6F29(param_00);
    }
  }

  if(!self.a.var_9302) {
    thread func_92FF(param_00.var_92CC);
    self.a.var_9302 = 1;
  }

  if(isDefined(param_01)) {
    func_9300(param_01);
  } else {
    func_9301();
  }

  if(self.var_6F28) {
    self waittill("flinch_done");
  }

  self notify("stop_waiting_to_flinch");
}

func_9300(param_00) {
  self endon("end_idle");
  wait(param_00);
}

func_9301() {
  self endon("end_idle");
  wait(0.3 + randomfloat(0.1));
  self waittill("do_slow_things");
}

func_92FF(param_00) {
  self endon("killanimscript");
  self[[param_00]]();
}

func_6F29(param_00) {
  self endon("killanimscript");
  self endon("stop_waiting_to_flinch");
  var_01 = self.var_AA22;
  for(;;) {
    self waittill("suppression");
    var_02 = gettime();
    if(var_01 < var_02 - 2000) {
      break;
    }

    var_01 = var_02;
  }

  self.var_6F28 = 1;
  thread func_6335();
  var_03 = [
    [param_00.var_6F27]
  ]();
  if(!var_03) {
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

func_128AF(param_00, param_01) {
  var_02 = anglesToForward(self.angles);
  var_03 = vectornormalize(param_01.origin - self.origin);
  if(vectordot(var_02, var_03) < 0) {
    return 0;
  }

  if(self.var_FC && !scripts\anim\utility_common::recentlysawenemy()) {
    return 0;
  }

  if(scripts\anim\utility::func_9ED4()) {
    return func_3773(param_00._meth_85BF, param_01);
  }

  return func_3773(param_00.objective_position, param_01);
}

func_2B99(param_00) {
  if(!scripts\anim\utility::func_3875()) {
    return 0;
  }

  return func_3773(param_00.var_2B99);
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
  var_00 = gettime();
  if(isDefined(self.var_54C3) && var_00 > self.a.var_7E0C) {
    self.a.var_7E0C = var_00 + randomintrange(2000, 5000);
    return;
  }

  if(isDefined(self.isnodeoccupied)) {
    var_01 = distance2d(self.origin, self.isnodeoccupied.origin);
    if(var_01 < self.issentient) {
      self.a.var_7E0C = var_00 + randomintrange(5000, 10000);
      return;
    }

    if(var_01 > self.issaverecentlyloaded && var_01 < self.objective_playermask_showto) {
      self.a.var_7E0C = var_00 + randomintrange(2000, 5000);
      return;
    }

    self.a.var_7E0C = var_00 + randomintrange(10000, 15000);
    return;
  }

  self.a.var_7E0C = var_00 + randomintrange(5000, 15000);
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

  var_00 = 0;
  if(!isDefined(self.isnodeoccupied) || !self.isnodeoccupied scripts\engine\utility::isflashed()) {
    var_00 = scripts\anim\combat_utility::func_B019();
  }

  if(!var_00 && isDefined(self.isnodeoccupied) && !scripts\anim\utility_common::canseeenemyfromexposed()) {
    if(gettime() >= self.var_F17F) {
      return scripts\anim\combat_utility::func_128AA(0);
    }
  }

  return var_00;
}

func_128B1(param_00) {
  if(isDefined(param_00.var_BD1C)) {
    if([
        [param_00.var_BD1C]
      ]()) {
      return 1;
    }
  }

  return scripts\anim\combat_utility::func_B019();
}

func_F5AE() {
  var_00 = scripts\anim\utility::func_B028("exposed_turn");
  foreach(var_03, var_02 in var_00) {
    self.a.var_2274[var_03] = var_02;
  }
}

func_F318() {
  var_00 = scripts\anim\utility::func_B028("exposed_turn_crouch");
  foreach(var_03, var_02 in var_00) {
    self.a.var_2274[var_03] = var_02;
  }
}

func_129B4(param_00) {}

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

  var_00 = self _meth_80E8();
  if(isDefined(var_00) && var_00 != self.target_getindexoftarget && self _meth_83D4(var_00)) {
    self.var_1016F = 1;
    self.shufflenode = var_00;
    self.var_54C3 = 1;
    wait(0.5);
    return 1;
  }

  return 0;
}