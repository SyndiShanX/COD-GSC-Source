/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\26800.gsc
**************************************/

_id_6873() {
  var_0 = self getentitynumber();
  var_1 = "zodiac_idle" + var_0;
  var_2 = 160;

  if(isDefined(level._id_6874)) {
    var_2 = level._id_6874 + 20;
    level._id_6874 = var_2;
  } else {
    level._id_6874 = var_2;

  }
  maps\_shg_common::_id_1685(var_1, 20, var_2, (1, 1, 1));
  self._id_6875 = 1.0;
  self._id_6876 = 1;
  thread _id_6877();
}

_id_6877() {
  self endon("death");
  var_0 = self getentitynumber();
  var_1 = "zodiac_idle" + var_0;
  var_2 = self._id_0AB5;

  if(!isDefined(var_2)) {
    var_2 = self.script_noteworthy;

  }
  if(!isDefined(var_2)) {
    var_2 = "" + var_0;

  }
  for(;;) {
    waittillframeend;

    if(!self._id_6876) {
      self._id_6875 = self._id_6875 - 0.05;
      var_3 = self._id_6875;

      if(self._id_6875 <= 0) {
        self._id_6875 = 0.0;
        maps\_shg_common::_id_1688(var_1, var_2 + ":");
        var_3 = 1.0;
      }

      maps\_shg_common::_id_1689(var_1, (var_3, var_3, var_3));
    }

    self._id_6876 = 0;
    wait 0.05;
  }
}

_id_6878(var_0) {}

#using_animtree("generic_human");

main() {
  anim._id_6879 = [];
  anim._id_6879["left"] = spawnStruct();
  anim._id_6879["left"]._id_143A = % zodiac_aim_left;
  anim._id_6879["left"]._id_687A = % zodiac_harbor_trans_r2l;
  anim._id_6879["left"]._id_687B = spawnStruct();
  anim._id_6879["left"]._id_687B._id_5C80 = % zodiac_harbor_rightside_aim4;
  anim._id_6879["left"]._id_687B._id_687C = % zodiac_harbor_rightside_aim5;
  anim._id_6879["left"]._id_687B.right = % zodiac_harbor_rightside_aim6;
  anim._id_6879["left"]._id_0F54 = animscripts\utility::_id_0C6D( % zodiac_harbor_rightside_reload);
  anim._id_6879["left"].leftaimlimit = -49;
  anim._id_6879["left"].rightaimlimit = 48;
  anim._id_6879["left"]._id_687D = % zodiac_harbor_rightside_idle;
  anim._id_6879["left"]._id_0F59 = % zodiac_harbor_rightside_bump_idle;
  anim._id_6879["left"]._id_687E = % zodiac_harbor_rightside_idle_short;
  anim._id_6879["left"]._id_687F = % zodiac_harbor_rightside_react;
  anim._id_6879["left"]._id_6880 = animscripts\utility::_id_0C6D( % zodiac_harbor_rightside_shift, % zodiac_harbor_rightside_react);
  anim._id_6879["right"] = spawnStruct();
  anim._id_6879["right"]._id_143A = % zodiac_aim_right;
  anim._id_6879["right"]._id_687A = % zodiac_harbor_trans_l2r;
  anim._id_6879["right"]._id_687B = spawnStruct();
  anim._id_6879["right"]._id_687B._id_5C80 = % zodiac_harbor_leftside_aim4;
  anim._id_6879["right"]._id_687B._id_687C = % zodiac_harbor_leftside_aim5;
  anim._id_6879["right"]._id_687B.right = % zodiac_harbor_leftside_aim6;
  anim._id_6879["right"]._id_0F54 = animscripts\utility::_id_0C6D( % zodiac_harbor_leftside_reload, % zodiac_harbor_leftside_reloadb);
  anim._id_6879["right"]._id_687D = % zodiac_harbor_leftside_idle;
  anim._id_6879["right"]._id_0F59 = % zodiac_harbor_leftside_bump_idle;
  anim._id_6879["right"]._id_687E = % zodiac_harbor_leftside_idle_short;
  anim._id_6879["right"]._id_6880 = animscripts\utility::_id_0C6D( % zodiac_harbor_leftside_duck);
  anim._id_6879["right"]._id_687F = % zodiac_harbor_leftside_react;
  anim._id_6879["right"].leftaimlimit = -51;
  anim._id_6879["right"].rightaimlimit = 51;
}

_id_6881() {
  for(;;) {
    if(isDefined(self._id_0CB1)) {}

    if(isDefined(self.favoriteenemy)) {}

    if(isDefined(self._id_6882)) {}

    wait 0.05;
  }
}

_id_6883() {
  self.a._id_0CE6 = undefined;
}

_id_6884() {
  self endon("killanimscript");

  if(!maps\_utility::_id_133C("transitioning_positions")) {
    maps\_utility::_id_1402("transitioning_positions");
  } else {
    maps\_utility::_id_13DE("transitioning_positions");

  }
  animscripts\utility::_id_0D15("zodiac");
  self._id_6885 = 0;
  self.a._id_6886 = 0;

  if(!isDefined(self.a._id_6887)) {
    self.a._id_6887 = "right";

  }
  self.a._id_6888 = gettime() + 1000;
  self.a._id_6889 = gettime() + randomintrange(3000, 6000);
  self.a._id_688A = gettime() + 1000;
  childthread animscripts\shoot_behavior::_id_0CD7("normal");
  self._id_688B = gettime() + 1000;
  self._id_688C = 1.0;
  self._id_688D = gettime() + 2000;
  self._id_688E = 0.1;

  if(isDefined(self._id_688F)) {
    self._id_688E = self._id_688F;

  }
  _id_68AF();
  self.a._id_6890 = undefined;
  self.a._id_0CE6 = ::_id_68A0;
  childthread _id_5E8B();
  childthread _id_68A2();

  for(;;) {
    if(!_id_6896()) {
      thread _id_6893();

      if(_id_6891()) {
        _id_6892();
        continue;
      }

      var_0 = _id_68AC();

      if(var_0 != "none") {
        var_1 = anim._id_6879[self.a._id_6887]._id_687A;
        self.a._id_6887 = var_0;
        maps\_utility::_id_13DC("transitioning_positions");
        self setflaggedanimknoballrestart("trans", var_1, % body, 1, 0.2);
        animscripts\notetracks::_id_0D4F(getanimlength(var_1) - 0.3, "trans");
        self.a._id_6888 = gettime();
        self.a._id_6889 = gettime() + randomintrange(3000, 6000);
        maps\_utility::_id_13DE("transitioning_positions");
        var_2 = anim._id_6879[self.a._id_6887]._id_687B._id_687C;
        self setanimknoballrestart(var_2, % body, 1, 0.2);
        self notify("boat_pose_change");
        self.a._id_6886 = 0;
        _id_68AF();
        continue;
      }

      if(_id_689B()) {
        _id_689D();
        continue;
      }
    }

    thread _id_6897();

    if(animscripts\combat_utility::_id_10E4()) {
      _id_68A9();
      continue;
    } else {
      _id_68A7();

    }
    wait 0.1;
  }

  self waittill("forever");
}

_id_6891() {
  if(animscripts\combat_utility::_id_0F08(0)) {
    if(!isDefined(self.a._id_6890)) {
      self.a._id_6890 = gettime();

    }
    animscripts\weaponlist::_id_0CD0();
  }

  if(isDefined(self.a._id_6890)) {
    if(gettime() - self.a._id_6890 > 2500) {
      return 1;

    }
    if(!_id_68A5()) {
      return 1;

    }
    if(self.a._id_0AA7 < gettime() - 1500) {
      return 1;
    }
  }

  return 0;
}

_id_6892() {
  var_0 = anim._id_6879[self.a._id_6887]._id_0F54;
  var_1 = var_0[randomint(var_0.size)];
  self.a._id_6890 = undefined;
  self setflaggedanimknoballrestart("reload", var_1, % body, 1, 0.2);
  _id_689C(var_1);
  animscripts\weaponlist::_id_0CD0();
}

_id_6893() {
  if(!isDefined(self.a._id_6894)) {
    return;
  }
  self endon("killanimscript");
  self endon("want_boat_idle");
  wait 0.05;
  self notify("end_boat_idle");
  self.a._id_6894 = undefined;
  self clearanim( % zodiac_idle, 0.2);
}

_id_6895(var_0, var_1, var_2) {
  self endon("starting_altidle");
  wait(var_0);
  self setanim(var_1, 0, 0.2);
  self setanim(var_2, 1, 0.2);
}

_id_6896() {
  var_0 = self._id_6885;

  if(isDefined(self.vehicle) && isDefined(self.vehicle._id_0EFE)) {
    if(self.vehicle._id_0EFE["bump_big"]["passenger"]) {
      var_0 = 1;

    }
    if(self.vehicle._id_0EFE["jump"]["passenger"]) {
      var_0 = 1;
    }
  }

  return var_0;
}

_id_6897() {
  self notify("want_boat_idle");
  var_0 = "normal";
  var_1 = length(self._id_6898);

  if(var_1 > 170) {
    var_0 = "alt";

  }
  if(isDefined(self._id_6899) && self._id_6899) {
    if(isDefined(self.vehicle) && isDefined(self.vehicle._id_0EFE)) {
      self.vehicle._id_0EFE["jump"]["passenger"] = 0;
      self.vehicle._id_0EFE["bump_big"]["passenger"] = 0;
      self.vehicle._id_0EFE["bump"]["passenger"] = 0;
      var_1 = 0;
      var_0 = "normal";
    }
  }

  if(isDefined(self.a._id_6894) && self.a._id_6894 == var_0 && var_0 == "normal") {
    return;
  }
  self.a._id_6894 = var_0;
  self endon("end_boat_idle");
  var_2 = "";
  var_3 = undefined;
  var_4 = 1;

  if(var_0 == "alt") {
    var_5 = anim._id_6879[self.a._id_6887]._id_0F59;
    var_3 = anim._id_6879[self.a._id_6887]._id_687E;
    var_4 = (var_1 - 170) / 500;
    var_6 = 0;
    var_7 = 0;

    if(isDefined(self.vehicle) && isDefined(self.vehicle._id_0EFE)) {
      if(self.vehicle._id_0EFE["jump"]["passenger"]) {
        var_2 = var_2 + "jump ";
        self._id_6885 = 1;
        self.vehicle._id_0EFE["jump"]["passenger"] = 0;
        var_4 = var_4 + 1.0;
        var_7 = 1;
        var_6 = 1;
      } else if(self.vehicle._id_0EFE["bump_big"]["passenger"]) {
        var_2 = var_2 + "big ";
        self._id_6885 = 0;
        self.vehicle._id_0EFE["bump_big"]["passenger"] = 0;
        var_4 = var_4 + 1.0;
        var_6 = 1;
      } else if(self.vehicle._id_0EFE["bump"]["passenger"]) {
        var_2 = var_2 + "small ";
        self._id_6885 = 0;
        self.vehicle._id_0EFE["bump"]["passenger"] = 0;
        var_4 = var_4 + 0.5;
        var_6 = 1;
      }
    }

    if(var_7) {
      var_2 = var_2 + "react ";
      var_8 = anim._id_6879[self.a._id_6887]._id_687F;
      self setflaggedanimknoballrestart("twitch", var_8, % body, 1, 0.2);
      var_9 = getanimlength(var_8);

      if(var_9 > 0.5) {
        var_9 = 0.5;

      }
      self._id_688B = gettime() + 1000 * var_9;
      self._id_688C = 2.0;
      thread _id_6878(var_2);
      return;
    } else if(self._id_6885) {
      if(self._id_688B < gettime()) {
        self._id_6885 = 0;

      }
      var_9 = self._id_688B - gettime();
      var_2 = var_2 + "react " + var_9 + " ";
      thread _id_6878(var_2);
      return;
    } else {
      if(var_4 < 0) {
        var_4 = 0;

      }
      if(var_4 > 1.0) {
        var_4 = 1.0;

      }
      if(isDefined(var_3) && var_4 > 0) {
        if(self._id_688B < gettime() || var_6 && var_4 > self._id_688C) {
          var_2 = var_2 + "restart " + var_4 + " ";
          self notify("starting_altidle");
          var_9 = getanimlength(var_3);
          self._id_688B = gettime() + 1000 * var_9;
          self._id_688C = var_4;
          self setanimrestart(var_3, var_4, 0.2);
          self setanim(var_5, 1 - var_4, 0.2);
          thread _id_6895(var_9, var_3, var_5);
        } else if(var_4 > self._id_688C) {
          var_2 = var_2 + "bigger " + var_4 + " ";
          self._id_688C = var_4;
          self setanim(var_3, var_4, 0.2);
          self setanim(var_5, 1 - var_4, 0.2);
        }

        thread _id_6878(var_2);
        return;
      }
    }
  }

  if(var_0 == "normal" || !isDefined(var_3)) {
    var_3 = anim._id_6879[self.a._id_6887]._id_0F59;

  }
  if(isDefined(var_3)) {
    var_10 = anim._id_6879[self.a._id_6887]._id_687D;

    if(var_1 > 85) {
      var_4 = 1.0;
    } else {
      var_4 = var_1 / 85;

    }
    var_2 = var_2 + "idle " + var_4 + " ";
    self._id_688B = gettime();
    self._id_688C = 0;
    var_11 = 0.2;

    if(isDefined(self._id_689A)) {
      var_11 = 0.0;

    }
    self setanimknob(var_10, 1 - var_4, var_11);
    self setanimknob(var_3, var_4, var_11);
  }

  thread _id_6878(var_2);
}

_id_689B() {
  if(isDefined(self._id_6899) && self._id_6899) {
    return 0;

  }
  if(self.a._id_0AA7 > gettime() - 2000) {
    return 0;

  }
  if(gettime() < self.a._id_688A + 1500) {
    return 0;

  }
  if(_id_689F()) {
    return 0;

  }
  if(!isDefined(anim._id_6879[self.a._id_6887]._id_6880)) {
    return 0;

  }
  return 1;
}

_id_689C(var_0) {
  var_1 = getanimlength(var_0);

  while(var_1 > 0) {
    if(_id_6896()) {
      break;
    }

    var_1 = var_1 - 0.05;
    wait 0.05;
  }
}

_id_689D() {
  var_0 = anim._id_6879[self.a._id_6887]._id_6880;
  var_1 = var_0[randomint(var_0.size)];

  for(var_2 = 0; var_2 < 5; var_2++) {
    if(!isDefined(self.a._id_689E) || var_1 != self.a._id_689E) {
      break;
    }

    var_1 = var_0[randomint(var_0.size)];
  }

  self setflaggedanimknoballrestart("twitch", var_1, % body, 1, 0.2);
  _id_689C(var_1);
  self.a._id_689E = var_1;
  self.a._id_688A = gettime();
}

_id_689F() {
  if(!isDefined(self.enemy)) {
    return 0;

  }
  var_0 = bulletTrace(self getEye(), self.enemy.origin + (0, 0, 60), 1, self);

  if(var_0["fraction"] <= 0.99) {
    if(isDefined(var_0["entity"])) {
      if(var_0["entity"] == self.enemy) {
        return 1;
      }
    }
  }

  if(var_0["fraction"] > 0.99) {
    return 1;

  }
  return 0;
}

_id_68A0() {
  if(!_id_689F()) {
    self._id_0CAB = undefined;
    self._id_0CB1 = undefined;
    self._id_0CDA = "none";
  } else {
    self._id_0CAB = self.enemy;
    self._id_0CB1 = self.enemy getshootatpos();
    var_0 = distancesquared(self.origin, self.enemy.origin);

    if(var_0 < 16000000) {
      self._id_0CDA = "burst";
      return;
    }

    self._id_0CDA = "single";
  }
}

_id_5E8B() {
  self endon("killanimscript");
  self.prevpos = self.origin;
  self._id_6898 = (0, 0, 0);

  for(;;) {
    wait 0.05;
    self._id_6898 = (self.origin - self.prevpos) / 0.05;
    self.prevpos = self.origin;
  }
}

_id_68A1() {
  self endon("boat_pose_change");
  wait(randomfloatrange(0.5, 3.5));
}

_id_68A2() {
  self endon("killanimscript");

  for(;;) {
    if(self.a._id_6887 == "left") {
      self._id_68A3 = randomfloatrange(-20, 40);
    } else {
      self._id_68A3 = randomfloatrange(-40, 20);

    }
    _id_68A1();
  }
}

_id_68A4(var_0) {
  if(!isDefined(self._id_0CB1)) {
    return 0;

  }
  var_1 = self._id_0CB1 - self._id_6898 * var_0;
  var_2 = animscripts\shared::_id_23CE(var_1);
  return var_2;
}

_id_68A5() {
  if(!isDefined(self._id_0CB1)) {
    return 0;

  }
  var_0 = _id_68A6();
  var_1 = anim._id_6879[self.a._id_6887];
  return var_0 >= var_1.leftaimlimit && var_0 <= var_1.rightaimlimit;
}

_id_68A6() {
  var_0 = 0;

  if(isDefined(self._id_0CB1)) {
    var_0 = _id_68A4(0.1);

    if(self.a._id_6887 == "left") {
      var_0 = angleclamp180(var_0 + 40.5);
    } else {
      var_0 = angleclamp180(var_0 - 36);
    }
  } else {
    var_0 = self._id_68A3;

  }
  return var_0;
}

_id_68A7() {
  var_0 = 15;

  if(!isDefined(self._id_0CB1)) {
    var_0 = 5;

  }
  var_1 = _id_68A6();

  if(abs(var_1 - self.a._id_6886) > var_0) {
    if(var_1 < self.a._id_6886) {
      var_1 = self.a._id_6886 - var_0;
    } else {
      var_1 = self.a._id_6886 + var_0;
    }
  }

  var_2 = anim._id_6879[self.a._id_6887];
  var_3 = 0.1;

  if(isDefined(self._id_689A)) {
    var_3 = 0.0;
    var_1 = 0;
  }

  if(var_1 < 0) {
    var_4 = var_1 / var_2.leftaimlimit;

    if(var_4 > 1) {
      var_4 = 1;

    }
    self setanimknob(var_2._id_687B._id_687C, 1 - var_4, var_3);
    self setanim(var_2._id_687B._id_5C80, var_4, var_3);
  } else {
    var_4 = var_1 / var_2.rightaimlimit;

    if(var_4 > 1) {
      var_4 = 1;

    }
    self setanimknob(var_2._id_687B._id_687C, 1 - var_4, var_3);
    self setanim(var_2._id_687B.right, var_4, var_3);
  }

  self setanimknoball(var_2._id_143A, % zodiac_actions, 1, 0.2);
  self.a._id_6886 = var_1;
}

_id_68A8() {
  self endon("killanimscript");
  self endon("end_shootUntilNeedToChangePose");

  for(;;) {
    _id_68A7();
    wait 0.1;
  }
}

_id_68A9() {
  thread _id_68AA();
  self endon("end_shootUntilNeedToChangePose");
  thread _id_68A8();
  animscripts\combat_utility::_id_0F06();
  self notify("end_shootUntilNeedToChangePose");
}

_id_68AA() {
  self endon("killanimscript");
  self endon("end_shootUntilNeedToChangePose");
  var_0 = gettime() + 4000 + randomint(2000);
  wait 0.05;

  for(;;) {
    if(gettime() > var_0 || _id_68AC() != "none") {
      break;
    }

    if(_id_6891()) {
      break;
    }

    if(_id_6896()) {
      break;
    }

    wait 0.1;
  }

  self notify("end_shootUntilNeedToChangePose");
}

_id_68AB() {
  if(isDefined(self._id_6899) && self._id_6899) {
    return "none";

  }
  if(self.a._id_6888 > gettime() - 2000) {
    return "none";

  }
  if(self.a._id_0AA7 > gettime() - 2000) {
    return "none";

  }
  if(!isDefined(self._id_0CB1)) {
    if(self.a._id_6889 < gettime()) {
      if(self.a._id_6887 == "left") {
        return "right";
      } else {
        return "left";
      }
    }

    return "none";
  }

  var_0 = _id_68A4(0.5);

  if(self.a._id_6887 == "left") {
    if(var_0 > 15 && var_0 < 160) {
      return "right";
    }
  } else if(self.a._id_6887 == "right") {
    if(var_0 < -15 && var_0 > -160) {
      return "left";
    }
  }

  return "none";
}

_id_68AC() {
  if(isDefined(self._id_68AD)) {
    return _id_68AB();

  }
  if(isDefined(self._id_68AE)) {
    if(self.a._id_6887 == self._id_68AE) {
      return "none";

    }
    return self._id_68AE;
  }

  if(self.a._id_6887 == "right") {
    return "left";

  }
  return "none";
}

_id_68AF() {
  self.a._id_0C6D = [];
  self.a._id_0C6D["fire"] = % exposed_shoot_auto_v3;

  if(self.a._id_6887 == "left") {
    self.a._id_0C6D["single"] = animscripts\utility::_id_0C6D( % zodiac_harbor_rightside_fire_single);
    self.a._id_0C6D["burst2"] = % zodiac_harbor_rightside_fire_burst;
    self.a._id_0C6D["burst3"] = % zodiac_harbor_rightside_fire_burst;
    self.a._id_0C6D["burst4"] = % zodiac_harbor_rightside_fire_burst;
    self.a._id_0C6D["burst5"] = % zodiac_harbor_rightside_fire_burst;
    self.a._id_0C6D["burst6"] = % zodiac_harbor_rightside_fire_burst;
    self.a._id_0C6D["semi2"] = % zodiac_harbor_rightside_fire_burst;
    self.a._id_0C6D["semi3"] = % zodiac_harbor_rightside_fire_burst;
    self.a._id_0C6D["semi4"] = % zodiac_harbor_rightside_fire_burst;
    self.a._id_0C6D["semi5"] = % zodiac_harbor_rightside_fire_burst;
    self.a._id_0C6D["semi6"] = % zodiac_harbor_rightside_fire_burst;
  } else {
    self.a._id_0C6D["single"] = animscripts\utility::_id_0C6D( % zodiac_harbor_leftside_fire_single);
    self.a._id_0C6D["burst2"] = % zodiac_harbor_leftside_fire_burst;
    self.a._id_0C6D["burst3"] = % zodiac_harbor_leftside_fire_burst;
    self.a._id_0C6D["burst4"] = % zodiac_harbor_leftside_fire_burst;
    self.a._id_0C6D["burst5"] = % zodiac_harbor_leftside_fire_burst;
    self.a._id_0C6D["burst6"] = % zodiac_harbor_leftside_fire_burst;
    self.a._id_0C6D["semi2"] = % zodiac_harbor_leftside_fire_burst;
    self.a._id_0C6D["semi3"] = % zodiac_harbor_leftside_fire_burst;
    self.a._id_0C6D["semi4"] = % zodiac_harbor_leftside_fire_burst;
    self.a._id_0C6D["semi5"] = % zodiac_harbor_leftside_fire_burst;
    self.a._id_0C6D["semi6"] = % zodiac_harbor_leftside_fire_burst;
  }
}