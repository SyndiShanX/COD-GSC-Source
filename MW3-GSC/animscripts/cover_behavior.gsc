/******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\cover_behavior.gsc
******************************************/

main(var_0) {
  self._id_0CF9 = self.origin;
  var_1 = gettime();
  var_2 = spawnStruct();
  var_2._id_0F2E = var_1 - 1;
  var_2._id_0F2F = var_1 - 1;
  _id_0F69();
  _id_0F68();
  self._id_0F30 = gettime();
  self.a._id_0F31 = var_1;
  self.a._id_0F32 = 0;
  self.a._id_0D2B = "stop";
  self._id_0F33 = var_1 + 3000;
  thread _id_0F50();
  var_3 = gettime() > 2500;
  var_4 = _id_0F40();

  for(;;) {
    if(animscripts\combat_utility::_id_0F34()) {
      if(animscripts\combat_utility::_id_0F35(1)) {
        wait 0.05;
        continue;
      }
    }

    if(isDefined(var_0._id_0F36)) {
      var_5 = gettime();
      thread _id_0F60();
      [[var_0._id_0F36]]();

      if(gettime() == var_5) {
        self notify("dont_end_idle");
      }
    }

    if(isDefined(var_0._id_0F37)) {
      if([[var_0._id_0F37]]()) {
        continue;
      }
    }

    self safeteleport(self._id_0CAF.origin, var_4);

    if(!var_3) {
      _id_0F59(var_0, 0.05 + randomfloat(1.5));
      var_3 = 1;
      continue;
    }

    if(_id_0F44(var_0)) {
      continue;
    }
    if(isDefined(anim._id_0F38) && isalive(level.player)) {
      if(_id_0F61(var_0, level.player)) {
        continue;
      }
    }

    if(_id_0F42()) {
      return;
    }
    var_6 = 0;
    var_7 = 0;

    if(isalive(self.enemy)) {
      var_6 = _id_0F49();
      var_7 = animscripts\utility::_id_0F39();
    }

    if(var_6) {
      if(self.a._id_0F3A < gettime()) {
        if(animscripts\combat_utility::_id_0F3B()) {
          return;
        }
      }

      _id_0F45(var_0);
      continue;
    }

    if(isDefined(self._id_0F3C) || _id_0F67()) {
      if(_id_0F6D()) {
        return;
      }
    }

    if(var_7) {
      _id_0F46(var_0, var_2);
      continue;
    }

    if(_id_0F48(var_0, var_2)) {
      return;
    }
  }
}

end_script(var_0) {
  self._id_0F3D = undefined;
  self.a._id_0F3E = undefined;

  if(isDefined(self._id_0F33) && self._id_0F33 <= gettime()) {
    self._id_0F3F = gettime() + 5000;
    self._id_0F33 = undefined;
  }
}

_id_0F40() {
  var_0 = (self._id_0CAF.angles[0], animscripts\utility::_id_0F41(self._id_0CAF), self._id_0CAF.angles[2]);
  return var_0;
}

_id_0F42() {
  if(self atdangerousnode() && self.a._id_0F43 < gettime()) {
    if(animscripts\combat_utility::_id_0F3B()) {
      return 1;

    }
    self.a._id_0F43 = gettime() + 30000;
  }

  return 0;
}

_id_0F44(var_0) {
  if(_id_0F4B(var_0)) {
    if(_id_0F49()) {
      _id_0F6B();

    }
    self.a._id_0F31 = gettime();
    return 1;
  }

  if(_id_0F52(var_0, 0)) {
    return 1;

  }
  return 0;
}

_id_0F45(var_0) {
  if(distancesquared(self.origin, self.enemy.origin) > 562500) {
    if(_id_0F61(var_0, self.enemy)) {
      return;
    }
  }

  if(_id_0F55(var_0, "normal")) {
    _id_0F6B();
    self.a._id_0F31 = gettime();
  } else {
    _id_0F59(var_0);
  }
}

_id_0F46(var_0, var_1) {
  if(self.doingambush) {
    if(_id_0F55(var_0, "ambush")) {
      return;
    }
  } else if(self.providecoveringfire || gettime() >= var_1._id_0F2F) {
    var_2 = "suppress";

    if(!self.providecoveringfire && gettime() - self._id_0F47 > 5000 && randomint(3) < 2) {
      var_2 = "ambush";
    } else if(!animscripts\shoot_behavior::_id_0CE9()) {
      var_2 = "ambush";

    }
    if(_id_0F55(var_0, var_2)) {
      var_1._id_0F2F = gettime() + randomintrange(3000, 20000);

      if(_id_0F49()) {
        self.a._id_0F31 = gettime();

      }
      return;
    }
  }

  if(_id_0F61(var_0, self.enemy)) {
    return;
  }
  _id_0F59(var_0);
}

_id_0F48(var_0, var_1) {
  if(_id_0F52(var_0, 0.1)) {
    return 0;

  }
  if(isDefined(self.enemy)) {
    if(_id_0F61(var_0, self.enemy)) {
      return 0;
    }
  }

  if(!self.doingambush && gettime() >= var_1._id_0F2E) {
    if(_id_0F56(var_0)) {
      var_1._id_0F2E = gettime() + randomintrange(4000, 15000);
      return 0;
    }
  }

  if(gettime() > self.a._id_0F3A) {
    if(_id_0F6C()) {
      return 1;
    }
  }

  if(self.doingambush || gettime() >= var_1._id_0F2F && isDefined(self.enemy)) {
    if(_id_0F55(var_0, "ambush")) {
      if(_id_0F49()) {
        _id_0F6B();

      }
      self.a._id_0F31 = gettime();
      var_1._id_0F2F = gettime() + randomintrange(6000, 20000);
      return 0;
    }
  }

  _id_0F59(var_0);
  return 0;
}

_id_0F49() {
  if(!isDefined(self.enemy)) {
    return 0;

  }
  if(distancesquared(self.enemy.origin, self._id_0CF9) < 256) {
    return 0;
  } else {
    return animscripts\utility::_id_0F4A();
  }
}

_id_0F4B(var_0) {
  if(!animscripts\utility::_id_0F4C()) {
    return 0;

  }
  var_1 = gettime();
  var_2 = 1;

  while(animscripts\utility::_id_0F4C()) {
    var_2 = 0;
    self safeteleport(self._id_0CAF.origin);
    var_3 = 1;

    if(isDefined(self._id_0F4D)) {
      var_3 = common_scripts\utility::cointoss();

    }
    if(var_3) {
      if(_id_0F6E(var_0)) {
        self notify("killanimscript");
        return 1;
      }
    }

    if(self.a._id_0CE2 && animscripts\utility::_id_0CE3()) {
      return 0;

    }
    if(_id_0F49() || animscripts\utility::_id_0F39()) {
      if(isDefined(anim._id_0F38) && isalive(level.player)) {
        if(_id_0F61(var_0, level.player)) {
          continue;
        }
      }

      if(_id_0F52(var_0, 0)) {
        continue;
      }
      if(self.team != "allies" && gettime() >= var_1) {
        if(_id_0F64(var_0)) {
          var_1 = gettime();

          if(!isDefined(self._id_0F4D)) {
            var_1 = var_1 + randomintrange(3000, 12000);

          }
          continue;
        }
      }

      if(_id_0F61(var_0, self.enemy)) {
        var_2 = 1;
        continue;
      }
    }

    if(_id_0F52(var_0, 0.1)) {
      continue;
    }
    _id_0F59(var_0);
  }

  if(!var_2 && randomint(2) == 0) {
    _id_0F58(var_0);

  }
  return 1;
}

_id_0F4E(var_0) {
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

_id_0F4F(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_0)) {
    return 0;

  }
  thread _id_0F60();
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

_id_0F50() {
  self endon("killanimscript");
  self._id_0F47 = gettime() - 100000;
  self._id_0F51 = self._id_0F47;

  for(;;) {
    self waittill("suppression");
    var_0 = gettime();

    if(self._id_0F47 < var_0 - 700) {
      self._id_0F51 = var_0;

    }
    self._id_0F47 = var_0;
  }
}

_id_0F52(var_0, var_1) {
  if(self._id_0CD1 > weaponclipsize(self.weapon) * var_1) {
    return 0;

  }
  self._id_0F53 = 1;
  var_2 = _id_0F4F(var_0._id_0F54);
  self._id_0F53 = 0;
  return var_2;
}

_id_0F55(var_0, var_1) {
  thread animscripts\shoot_behavior::_id_0CD7(var_1);

  if(!self.fixednode && !self.doingambush) {
    thread _id_0F66();

  }
  var_2 = _id_0F4F(var_0._id_0F55);
  self notify("stop_deciding_how_to_shoot");
  return var_2;
}

_id_0F56(var_0) {
  if(self.a._id_0CE2 && animscripts\utility::_id_0CE3()) {
    return 0;

  }
  if(self.a._id_0F31 + 6000 > gettime()) {
    return _id_0F58(var_0);
  } else {
    var_1 = _id_0F4F(var_0.look, 2 + randomfloat(2));

    if(var_1) {
      return 1;

    }
    return _id_0F4F(var_0._id_0F57);
  }
}

_id_0F58(var_0) {
  var_1 = _id_0F4F(var_0._id_0F57);

  if(var_1) {
    return 1;

  }
  return _id_0F4F(var_0.look, 0);
}

_id_0F59(var_0, var_1) {
  self._id_0F5A = 0;

  if(isDefined(var_0._id_0F5B)) {
    if(!self.a._id_0F32 && gettime() - self._id_0F51 < 600) {
      if([[var_0._id_0F5B]]()) {
        return 1;
      }
    } else {
      thread _id_0F5F(var_0);
    }
  }

  if(!self.a._id_0F32) {
    thread _id_0F5E(var_0._id_0F59);
    self.a._id_0F32 = 1;
  }

  if(isDefined(var_1)) {
    _id_0F5C(var_1);
  } else {
    _id_0F5D();

  }
  if(self._id_0F5A) {
    self waittill("flinch_done");

  }
  self notify("stop_waiting_to_flinch");
}

_id_0F5C(var_0) {
  self endon("end_idle");
  wait(var_0);
}

_id_0F5D() {
  self endon("end_idle");
  wait(0.3 + randomfloat(0.1));
  self waittill("do_slow_things");
}

_id_0F5E(var_0) {
  self endon("killanimscript");
  self[[var_0]]();
}

_id_0F5F(var_0) {
  self endon("killanimscript");
  self endon("stop_waiting_to_flinch");
  var_1 = self._id_0F47;

  for(;;) {
    self waittill("suppression");
    var_2 = gettime();

    if(var_1 < var_2 - 2000) {
      break;
    }

    var_1 = var_2;
  }

  self._id_0F5A = 1;
  thread _id_0F60();
  var_3 = [[var_0._id_0F5B]]();

  if(!var_3) {
    self notify("dont_end_idle");

  }
  self._id_0F5A = 0;
  self notify("flinch_done");
}

_id_0F60() {
  self endon("killanimscript");
  self endon("dont_end_idle");
  waittillframeend;

  if(!isDefined(self)) {
    return;
  }
  self notify("end_idle");
  self.a._id_0F32 = 0;
}

_id_0F61(var_0, var_1) {
  var_2 = anglesToForward(self.angles);
  var_3 = vectornormalize(var_1.origin - self.origin);

  if(vectordot(var_2, var_3) < 0) {
    return 0;

  }
  if(self.doingambush && !animscripts\utility::_id_0CBC()) {
    return 0;

  }
  if(animscripts\utility::_id_0F62()) {
    return _id_0F4F(var_0._id_0F63, var_1);
  } else {
    return _id_0F4F(var_0.grenade, var_1);
  }
}

_id_0F64(var_0) {
  if(!animscripts\utility::_id_0F65()) {
    return 0;

  }
  return _id_0F4F(var_0._id_0F64);
}

_id_0F66() {
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
    if(_id_0F67()) {
      if(_id_0F6D()) {
        return;
      }
    }

    if(!animscripts\utility::_id_0CBC() && !animscripts\utility::_id_0CF3()) {
      if(gettime() > self.a._id_0F3A) {
        if(_id_0F6C()) {
          return;
        }
      }
    }
  }
}

_id_0F67() {
  if(!isDefined(self.enemy)) {
    return 0;

  }
  if(self.enemy common_scripts\utility::isflashed()) {
    return 1;

  }
  if(isplayer(self.enemy)) {
    if(isDefined(self.enemy.health) && self.enemy.health < self.enemy.maxhealth) {
      return 1;
    }
  } else if(isai(self.enemy) && self.enemy animscripts\utility::_id_0F4C()) {
    return 1;

  }
  if(isDefined(self.enemy._id_0F53) && self.enemy._id_0F53) {
    return 1;

  }
  return 0;
}

_id_0F68() {
  self.a._id_0F43 = 0;
}

_id_0F69() {
  var_0 = gettime();

  if(isDefined(self._id_0F6A) && var_0 > self.a._id_0F3A) {
    self.a._id_0F3A = var_0 + randomintrange(2000, 5000);
  } else if(isDefined(self.enemy)) {
    var_1 = distance2d(self.origin, self.enemy.origin);

    if(var_1 < self.engagemindist) {
      self.a._id_0F3A = var_0 + randomintrange(5000, 10000);
      return;
    }

    if(var_1 > self.engagemaxdist && var_1 < self.goalradius) {
      self.a._id_0F3A = var_0 + randomintrange(2000, 5000);
      return;
    }

    self.a._id_0F3A = var_0 + randomintrange(10000, 15000);
    return;
    return;
  } else {
    self.a._id_0F3A = var_0 + randomintrange(5000, 15000);
  }
}

_id_0F6B() {
  if(isDefined(self._id_0F3C)) {
    self._id_0F30 = gettime() + randomintrange(500, 1000);
  } else {
    self._id_0F30 = gettime() + randomintrange(3000, 5000);
  }
}

_id_0F6C() {
  return _id_0F6D();
}

_id_0F6D() {
  if(self.fixednode || self.doingambush) {
    return 0;

  }
  if(isDefined(self._id_0F3C) && gettime() >= self._id_0F30) {
    return animscripts\combat_utility::_id_0F35(0);

  }
  var_0 = 0;

  if(!isDefined(self.enemy) || !self.enemy common_scripts\utility::isflashed()) {
    var_0 = animscripts\combat_utility::_id_0F3B();

  }
  if(!var_0 && isDefined(self.enemy) && !animscripts\utility::_id_0F4A()) {
    if(gettime() >= self._id_0F30) {
      return animscripts\combat_utility::_id_0F35(0);
    }
  }

  return var_0;
}

_id_0F6E(var_0) {
  if(isDefined(var_0._id_0F37)) {
    if([[var_0._id_0F37]]()) {
      return 1;
    }
  }

  return animscripts\combat_utility::_id_0F3B();
}

#using_animtree("generic_human");

_id_0F6F() {
  self.a._id_0C6D["turn_left_45"] = % exposed_tracking_turn45l;
  self.a._id_0C6D["turn_left_90"] = % exposed_tracking_turn90l;
  self.a._id_0C6D["turn_left_135"] = % exposed_tracking_turn135l;
  self.a._id_0C6D["turn_left_180"] = % exposed_tracking_turn180l;
  self.a._id_0C6D["turn_right_45"] = % exposed_tracking_turn45r;
  self.a._id_0C6D["turn_right_90"] = % exposed_tracking_turn90r;
  self.a._id_0C6D["turn_right_135"] = % exposed_tracking_turn135r;
  self.a._id_0C6D["turn_right_180"] = % exposed_tracking_turn180r;
}

_id_0F70() {
  self.a._id_0C6D["turn_left_45"] = % exposed_crouch_turn_90_left;
  self.a._id_0C6D["turn_left_90"] = % exposed_crouch_turn_90_left;
  self.a._id_0C6D["turn_left_135"] = % exposed_crouch_turn_180_left;
  self.a._id_0C6D["turn_left_180"] = % exposed_crouch_turn_180_left;
  self.a._id_0C6D["turn_right_45"] = % exposed_crouch_turn_90_right;
  self.a._id_0C6D["turn_right_90"] = % exposed_crouch_turn_90_right;
  self.a._id_0C6D["turn_right_135"] = % exposed_crouch_turn_180_right;
  self.a._id_0C6D["turn_right_180"] = % exposed_crouch_turn_180_right;
}

_id_0F71(var_0) {
  if(isDefined(self.node)) {
    var_1 = self.node;
    var_2 = abs(angleclamp180(self.angles[1] - (var_1.angles[1] + var_0)));

    if(self.a._id_0D26 == "stand" && var_1 gethighestnodestance() != "stand") {
      if(var_2 > 45 && var_2 < 90) {
        self orientmode("face angle", self.angles[1]);
      } else {
        self orientmode("face current");

      }
      var_3 = 1.5;
      var_4 = getnotetracktimes( % exposed_stand_2_crouch, "anim_pose = \"crouch\"")[0];
      var_4 = min(1, var_4 * 1.1);
      var_5 = var_4 * getanimlength( % exposed_stand_2_crouch) / var_3;
      self setflaggedanimknoballrestart("crouchanim", % exposed_stand_2_crouch, % body, 1, 0.2, var_3);
      animscripts\notetracks::_id_0D4F(var_5, "crouchanim");
      self clearanim( % body, 0.2);
    }

    self orientmode("face angle", self.angles[1]);
    var_6 = angleclamp180(self.angles[1] - (var_1.angles[1] + var_0));

    if(abs(var_6) > 45) {
      if(self.a._id_0D26 == "stand") {
        _id_0F6F();
      } else {
        _id_0F70();

      }
      self._id_0F72 = 45;
      self._id_0F3D = 1;
      animscripts\combat::_id_0F73(var_6);
      self._id_0F3D = undefined;
    }
  }
}

_id_0F37() {
  if(!isDefined(self.enemy)) {
    return 0;

  }
  if(isDefined(self._id_0F6A)) {
    self._id_0F6A = undefined;
    return 0;
  }

  if(!isDefined(self.node)) {
    return 0;

  }
  if(randomint(3) == 0) {
    return 0;

  }
  if(self.fixednode || self.doingambush || self.keepclaimednode || self.keepclaimednodeifvalid) {
    return 0;

  }
  if(distancesquared(self.origin, self.node.origin) > 256) {
    return 0;

  }
  var_0 = self findshufflecovernode();

  if(isDefined(var_0) && var_0 != self.node && self usecovernode(var_0)) {
    self._id_0F74 = 1;
    self._id_0F75 = var_0;
    self._id_0F6A = 1;
    wait 0.5;
    return 1;
  }

  return 0;
}