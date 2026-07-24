/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3171.gsc
**************************************/

_id_D899() {
  self endon("kill_long_death");
  self endon("death");
  self._id_6EC4 = 1;
  self._id_AFE7 = 1;
  self.a._id_58DA = 1;
  self notify("long_death");
  self.health = 10000;
  self.threatbias = self.threatbias - 2000;
  anim._id_BF77 = gettime() + 3000;
  anim._id_BF78 = gettime() + 3000;
  wait 0.75;

  if(self.health > 1) {
    self.health = 1;
  }

  wait 0.05;
  self._id_AFE7 = undefined;
  self.a._id_B4E7 = 1;
  wait 1.0;

  if(isDefined(level.player) && distancesquared(self.origin, level.player.origin) < 1048576) {
    anim._id_C222 = randomintrange(10, 30);
    anim._id_BF77 = gettime() + randomintrange(15000, 60000);
  } else {
    anim._id_C222 = randomintrange(5, 12);
    anim._id_BF77 = gettime() + randomintrange(5000, 25000);
  }

  anim._id_BF78 = gettime() + randomintrange(7000, 13000);
}

_id_5F73(var_0) {
  self endon("death");
  self notify("end_dying_crawl_back_aim");
  self endon("end_dying_crawl_back_aim");
  var_1 = _id_0A1E::_id_2356(var_0, "aim_4");
  var_2 = _id_0A1E::_id_2356(var_0, "aim_6");
  var_3 = _id_0A1E::_id_2356(var_0, "aim_4_knob");
  var_4 = _id_0A1E::_id_2356(var_0, "aim_6_knob");
  wait 0.05;
  self _meth_82AC(var_1, 1, 0);
  self _meth_82AC(var_2, 1, 0);
  var_5 = 0;

  for(;;) {
    var_6 = scripts\anim\utility_common::getyawtoenemy();
    var_7 = angleclamp180(var_6 - var_5);

    if(abs(var_7) > 3) {
      var_7 = scripts\engine\utility::sign(var_7) * 3;
    }

    var_6 = angleclamp180(var_5 + var_7);

    if(var_6 < 0) {
      if(var_6 < -45.0) {
        var_6 = -45.0;
      }

      var_8 = var_6 / -45.0;
      self _meth_82A2(var_3, var_8, 0.05);
      self _meth_82A2(var_4, 0, 0.05);
    } else {
      if(var_6 > 45.0) {
        var_6 = 45.0;
      }

      var_8 = var_6 / 45.0;
      self _meth_82A2(var_4, var_8, 0.05);
      self _meth_82A2(var_3, 0, 0.05);
    }

    var_5 = var_6;
    wait 0.05;
  }
}

_id_FA8D(var_0, var_1) {
  var_2 = _id_0A1E::_id_2356(var_0, "clear_knob");
  self clearanim(var_2, var_1);

  if(isDefined(self.a._id_29D4)) {
    return;
  }
  thread _id_5F73(var_0);
  self.a._id_29D4 = 1;
}

_id_9D2F() {
  var_0 = self.enemy getshootatpos();
  var_1 = self getmuzzleangle();
  var_2 = vectortoangles(var_0 - self getmuzzlepos());
  var_3 = scripts\engine\utility::absangleclamp180(var_1[1] - var_2[1]);

  if(var_3 > anim._id_C88B) {
    if(distancesquared(self getEye(), var_0) > anim._id_C889 || var_3 > anim._id_C88A) {
      return 0;
    }
  }

  return scripts\engine\utility::absangleclamp180(var_1[0] - var_2[0]) <= anim._id_C87D;
}

_id_5822() {
  self endon("death");
  var_0 = "J_SpineLower";
  var_1 = "tag_origin";
  var_2 = 6;
  var_3 = level._effect["crawling_death_blood_smear"];

  if(isDefined(self.a._id_486A)) {
    var_2 = self.a._id_486A;
  }

  if(isDefined(self.a._id_4869)) {
    var_3 = level._effect[self.a._id_4869];
  }

  while(var_2) {
    var_4 = self gettagorigin(var_0);
    var_5 = self gettagangles(var_1);
    var_6 = anglestoright(var_5);
    var_7 = anglesToForward((270, 0, 0));
    playFX(var_3, var_4, var_7, var_6);
    wait(var_2);
  }
}

_id_9D9D(var_0) {
  if(isDefined(self.a._id_7280)) {
    return 1;
  }

  var_1 = getmovedelta(var_0, 0, 1);
  var_2 = self localtoworldcoords(var_1);
  return self maymovetopoint(var_2);
}

_id_9DD8(var_0) {
  if(isDefined(self._id_72CC) && self._id_72CC == 4) {
    return 1;
  }

  if(!isDefined(self.enemy)) {
    return 0;
  }

  var_1 = vectorNormalize(self.enemy getshootatpos() - self getEye());
  return vectordot(var_1, var_0) > 0.5;
}

_id_AFE5(var_0, var_1, var_2, var_3) {
  _id_A669();
}

_id_A669() {
  if(isDefined(self._id_A8AA)) {
    self _meth_81D0(self.origin, self._id_A8AA);
  } else {
    self _meth_81D0();
  }
}

_id_10D8E(var_0) {
  self endon(var_0 + "_finished");
  wait 0.1;

  if(isDefined(self.a._id_29D4)) {
    return;
  }
  thread _id_5F73(var_0);
  self.a._id_29D4 = 1;
}

_id_8977(var_0, var_1, var_2) {
  var_3 = 0;

  if(!isDefined(self._id_29D0) && issubstr(var_1, "bodyfall")) {
    thread _id_5822();
  } else if(var_1 == "fire_spray") {
    if(!scripts\anim\utility_common::canseeenemy()) {
      return 1;
    }

    if(!_id_9D2F()) {
      return 1;
    }

    scripts\anim\utility_common::shootenemywrapper();
    return 1;
  } else if(var_1 == "pistol_pickup") {
    thread _id_10D8E(var_0);
    return 0;
  } else if(var_1 == "fire") {
    scripts\anim\utility_common::shootenemywrapper();
    return 1;
  }

  return 0;
}

_id_3EC8(var_0, var_1, var_2) {
  if(!isDefined(self.a._id_4876)) {
    var_3 = self.a.pose;

    if(!scripts\asm\asm::asm_hasalias(var_1, var_3)) {
      self.a._id_4876 = undefined;
      return self.a._id_4876;
    }

    var_4 = _id_0A1E::_id_2356(var_1, var_3);

    if(isarray(var_4)) {
      self.a._id_4876 = var_4[randomint(var_4.size)];
    } else {
      self.a._id_4876 = var_4;
    }
  }

  return self.a._id_4876;
}

_id_3F05(var_0, var_1, var_2) {
  if(!isDefined(self.a._id_11186)) {
    var_3 = "leg";
    var_4 = "b";

    if(!self._id_AB5A) {
      var_3 = "gut";

      if(45 < self.damageyaw && self.damageyaw < 135) {
        var_4 = "l";
      } else if(-135 < self.damageyaw && self.damageyaw < -45) {
        var_4 = "r";
      } else if(-45 < self.damageyaw && self.damageyaw < 45) {}
    }

    self.a._id_11186 = var_3 + "_" + var_4;
  }

  var_5 = _id_0A1E::_id_2356(var_1, self.a._id_11186);

  if(isarray(var_5)) {
    if(!isDefined(self.a._id_11187)) {
      self.a._id_11187 = randomint(var_5.size);
    }

    var_5 = var_5[self.a._id_11187];
  }

  return var_5;
}

_id_CF2A(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");

  if(isDefined(self.a._id_7280)) {
    var_4 = self.a._id_7280;
  } else {
    var_4 = randomintrange(1, 5);
  }

  var_5 = _id_0A1E::asm_getallanimsforstate(var_0, var_1);
  self clearanim(_id_0A1E::asm_getbodyknob(), var_2);
  self _meth_82E7(var_1, var_5, 1.0, var_2, 1.0);
  _id_0A1E::_id_2369(var_0, var_1, var_5);

  for(var_6 = 0; var_6 < var_4; var_6++) {
    if(!_id_9D9D(var_5)) {
      break;
    }

    if(isDefined(self._id_4C41)) {
      self playSound(self._id_4C41);
    }

    for(;;) {
      var_7 = _id_0A1E::_id_231F(var_0, var_1, scripts\asm\asm::_id_2341(var_0, var_1));

      if(var_7 == "code_move") {
        break;
      }
    }
  }

  scripts\asm\asm::asm_fireevent(var_1, "dying_crawl_done");
}

_id_CF2B(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");

  if(isDefined(self.enemy)) {
    self _meth_8306(self.enemy);
  }

  if(isDefined(self.a._id_7280)) {
    var_4 = self.a._id_7280;
  } else {
    var_4 = randomintrange(1, 5);
  }

  _id_FA8D(var_1, var_2);
  var_5 = _id_0A1E::asm_getallanimsforstate(var_0, var_1);
  _id_0A1E::_id_2369(var_0, var_1, var_5);
  self _meth_82E7(var_1, var_5, 1.0, var_2, 1.0);

  for(var_6 = 0; var_6 < var_4; var_6++) {
    if(!_id_9D9D(var_5)) {
      break;
    }

    for(;;) {
      var_7 = _id_0A1E::_id_2322(var_0, var_1, ::_id_8977);

      if(var_7 == "code_move") {
        break;
      }
    }
  }

  self._id_527E = gettime() + randomintrange(4000, 20000);
  scripts\asm\asm::asm_fireevent(var_1, "dying_back_crawl_done");
}

_id_CF06(var_0, var_1, var_2, var_3) {
  self _meth_8306();
  _id_0A1E::_id_2368(var_0, var_1, var_2, ::_id_8977);
}

_id_CF07(var_0, var_1, var_2, var_3) {
  thread _id_D899();
  self _meth_8306();
  _id_0A1E::_id_2368(var_0, var_1, var_2, ::_id_8977);
}

_id_CF29(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  _id_FA8D(var_1, var_2);

  for(;;) {
    var_4 = _id_0A1E::asm_getallanimsforstate(var_0, var_1);
    _id_0A1E::_id_2369(var_0, var_1, var_4);
    self _meth_82E7(var_1, var_4, 1.0, var_2, 1.0);
    var_5 = var_4;
    var_6 = _id_0A1E::_id_2322(var_0, var_1, ::_id_8977);

    if(var_6 == "end") {
      if(!scripts\asm\asm::_id_232B(var_1, "end")) {
        scripts\asm\asm::asm_fireevent(var_1, "end");
      }

      thread scripts\asm\asm::_id_2310(var_0, var_1, 0);
    }
  }
}

_id_CF28(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  self.a._id_BF88 = gettime() + randomintrange(500, 1000);
  _id_FA8D(var_1, var_2);
  var_4 = undefined;

  for(;;) {
    var_5 = _id_0A1E::asm_getallanimsforstate(var_0, var_1);

    if(!isDefined(var_4) || var_5 != var_4) {
      self _meth_82E7(var_1, var_5, 1.0, var_2, 1.0);
      var_4 = var_5;
    }

    _id_0A1E::_id_2369(var_0, var_1, var_5);
    var_4 = var_5;
    _id_0A1E::_id_2320(var_0, var_1, var_5, scripts\asm\asm::_id_2341(var_0, var_1));
  }
}

_id_D540(var_0, var_1, var_2, var_3) {
  thread _id_D899();
  self _meth_8306();
  _id_0A1E::_id_2364(var_0, var_1, var_2);
}

_id_D541(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  var_4 = _id_0A1E::asm_getallanimsforstate(var_0, var_1);
  var_5 = "stumbling_pain_collapse_death";
  var_6 = _id_0A1E::asm_getallanimsforstate(var_0, var_5);

  if(!isDefined(var_4)) {
    var_4 = _id_0A1E::asm_getallanimsforstate(var_0, var_1);
  }

  var_7 = getmovedelta(var_6);
  var_8 = randomintrange(1, 3);
  self clearanim(_id_0A1E::asm_getbodyknob(), var_2);
  self _meth_82E7(var_1, var_4, 1.0, var_2, 1.0);
  _id_0A1E::_id_2369(var_0, var_1, var_4);

  while(var_8 > 0) {
    var_9 = self localtoworldcoords(var_7);

    if(!self maymovetopoint(var_9)) {
      break;
    }

    for(;;) {
      var_10 = _id_0A1E::_id_231F(var_0, var_1, scripts\asm\asm::_id_2341(var_0, var_1));

      if(var_10 == "code_move") {
        break;
      }
    }

    var_8--;
  }

  scripts\asm\asm::asm_fireevent(var_1, "pain_wander_done");
}

_id_8BD5(var_0, var_1, var_2, var_3) {
  if(isDefined(self._id_9DD2) && self._id_9DD2) {
    return 1;
  }

  return 0;
}

_id_10013(var_0, var_1, var_2, var_3) {
  if(isDefined(self._id_9DD2) && self._id_9DD2) {
    return 0;
  }

  if(_id_9DD8(anglesToForward(self.angles) * -1)) {
    return 1;
  }

  return 0;
}

_id_10001(var_0, var_1, var_2, var_3) {
  if(!_id_9DD8(anglesToForward(self.angles))) {
    return 1;
  }

  if(isDefined(self._id_9DD2) && self._id_9DD2) {
    return 1;
  }

  if(isDefined(self._id_527E)) {
    return gettime() > self._id_527E;
  }

  return 0;
}

_id_FFC1(var_0, var_1, var_2, var_3) {
  _id_0A1E::asm_getallanimsforstate(var_0, var_2);

  if(!isDefined(self.a._id_4876)) {
    return 0;
  }

  if(!_id_9D9D(self.a._id_4876)) {
    self.a._id_4876 = undefined;
    return 0;
  }

  return 1;
}

_id_FFE5(var_0, var_1, var_2, var_3) {
  if(self.a.disablelongdeath || self.diequietly || self.damageshield) {
    return 0;
  }

  if(self.stairsstate != "none") {
    return 0;
  }

  if(isDefined(self.a.onback)) {
    return 0;
  }

  if(isDefined(self._id_4E46)) {
    return 0;
  }

  if(scripts\anim\utility_common::isusingsidearm()) {
    return 0;
  }

  if(scripts\engine\utility::damagelocationisany("head", "helmet", "gun", "right_hand", "left_hand")) {
    return 0;
  }

  self._id_AB5A = scripts\engine\utility::damagelocationisany("left_leg_upper", "left_leg_lower", "right_leg_upper", "right_leg_lower", "left_foot", "right_foot");
  var_4 = getdvarint("scr_forceLongDeath", 0);

  if(var_4 != 0) {
    self._id_72CC = var_4;
  }

  if(isDefined(self._id_72CC) && self._id_72CC > 1) {
    return 1;
  }

  if(self._id_AB5A && self.health < self.maxhealth * 0.4) {
    if(gettime() < anim._id_BF78) {
      return 0;
    }
  } else {
    if(anim._id_C222 > 0) {
      return 0;
    }

    if(gettime() < anim._id_BF77) {
      return 0;
    }
  }

  foreach(var_6 in level.players) {
    if(distancesquared(self.origin, var_6.origin) < 30625) {
      return 0;
    }
  }

  return 1;
}

_id_FFC3(var_0) {
  if(self.a.pose != "stand") {
    return 0;
  }

  var_1 = 20;

  if(isDefined(self._id_72CC)) {
    switch (self._id_72CC) {
      case 2:
        var_1 = 100;
        break;
      case 4:
      case 3:
        return 0;
    }
  }

  if(randomint(100) > var_1) {
    return 0;
  }

  var_2 = 0;

  if(!var_0) {
    var_2 = scripts\engine\utility::damagelocationisany("torso_upper", "torso_lower");

    if(!var_2) {
      return 0;
    }
  }

  var_3 = 0;
  var_4 = "leg";
  var_5 = "b";

  if(var_0) {
    var_3 = 200;
  } else {
    var_4 = "gut";
    var_3 = 128;

    if(45 < self.damageyaw && self.damageyaw < 135) {
      var_5 = "l";
    } else if(-135 < self.damageyaw && self.damageyaw < -45) {
      var_5 = "r";
    } else if(-45 < self.damageyaw && self.damageyaw < 45) {
      return 0;
    }
  }

  switch (var_5) {
    case "b":
      var_6 = anglesToForward(self.angles);
      var_7 = self.origin - var_6 * var_3;
      break;
    case "l":
      var_8 = anglestoright(self.angles);
      var_7 = self.origin - var_8 * var_3;
      break;
    case "r":
      var_8 = anglestoright(self.angles);
      var_7 = self.origin + var_8 * var_3;
      break;
    default:
      return 0;
  }

  if(!isDefined(self._id_72CC) || self._id_72CC != 2) {
    if(!self maymovetopoint(var_7)) {
      return 0;
    }
  }

  return 1;
}

_id_FFFB(var_0, var_1, var_2, var_3) {
  if(_id_FFC3(self._id_AB5A)) {
    return 1;
  }

  return 0;
}

_id_FFE9(var_0, var_1, var_2, var_3) {
  if(!_id_9DD8(anglesToForward(self.angles))) {
    return 0;
  }

  if(_id_FFC1(var_0, var_1, var_2, var_3)) {
    return 1;
  }

  return 0;
}

_id_FFEA(var_0, var_1, var_2, var_3) {
  if(self.a.pose == "prone") {
    return 0;
  }

  if(isDefined(self._id_72CC)) {
    if(self._id_72CC == 2 || self._id_72CC == 3) {
      return 1;
    }

    if(self._id_72CC > 3) {
      return 0;
    }
  }

  if(self.a.movement == "stop") {
    if(randomint(100) > 20) {
      return 0;
    } else if(abs(self.damageyaw) > 90) {
      return 0;
    }
  } else if(abs(self _meth_813E()) > 90)
    return 0;

  return _id_FFC1(var_0, var_1, var_2, var_3);
}

_id_FFEC(var_0, var_1, var_2, var_3) {
  if(isDefined(self._id_72CC) && self._id_72CC == 4) {
    return 1;
  }

  if(self.a.pose == "prone") {
    return 1;
  }

  if(self.a.movement == "stop") {
    if(randomint(100) <= 20) {
      return 1;
    } else if(abs(self.damageyaw) > 90) {
      return 1;
    }
  } else if(abs(self _meth_813E()) > 90)
    return 1;

  if(self.a.pose != "prone") {
    var_4 = _id_0A1E::asm_getallanimsforstate(var_0, var_2);

    if(!_id_9D9D(var_4)) {
      return 0;
    }
  }

  return 1;
}

_id_AFE6(var_0, var_1, var_2, var_3) {
  if(isDefined(self.a._id_BF88)) {
    if(gettime() < self.a._id_BF88) {
      return 0;
    }
  }

  if(!isDefined(self.enemy)) {
    return 0;
  }

  if(!scripts\anim\utility_common::canseeenemy()) {
    return 0;
  }

  if(!_id_9D2F()) {
    return 0;
  }

  return 1;
}

_id_582C(var_0, var_1, var_2, var_3) {
  if(!scripts\asm\asm::asm_hasalias(var_2, self.a._id_11186)) {
    return 0;
  }

  var_4 = _id_0A1E::_id_2356(var_2, self.a._id_11186);

  if(!isDefined(var_4) || !isarray(var_4)) {
    return 0;
  }

  if(var_4.size <= self.a._id_11187) {
    return 0;
  }

  return 1;
}