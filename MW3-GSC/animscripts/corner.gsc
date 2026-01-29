/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\corner.gsc
**************************************/

_id_2442(var_0, var_1) {
  self endon("killanimscript");
  self._id_2443["exposed"]["stand"] = ::_id_2476;
  self._id_2443["exposed"]["crouch"] = ::_id_2477;
  self._id_0CAF = self.node;
  self._id_2444 = var_0;
  self.a._id_0CAE = "unknown";
  self.a._id_0F78 = undefined;
  animscripts\cover_behavior::_id_0F71(var_1);
  _id_244A();
  self._id_2445 = 0;
  self._id_2446 = 0;
  self._id_2447 = 0;
  animscripts\track::_id_0CC4(0);
  self._id_2448 = 0;
  var_2 = spawnStruct();

  if(!self.fixednode) {
    var_2._id_0F37 = animscripts\cover_behavior::_id_0F37;

  }
  var_2._id_0F36 = ::_id_0F36;
  var_2._id_0F54 = ::_id_246B;
  var_2._id_0F55 = ::_id_245E;
  var_2.look = ::_id_0F56;
  var_2._id_0F57 = ::_id_0F57;
  var_2._id_0F59 = ::_id_0F59;
  var_2.grenade = ::_id_0F61;
  var_2._id_0F63 = ::_id_0F9E;
  var_2._id_0F64 = ::_id_0F64;
  animscripts\cover_behavior::main(var_2);
}

_id_2449() {
  self._id_0CB5 = undefined;
  self.a._id_237C = undefined;
}

_id_244A() {
  if(self.a._id_0D26 == "crouch") {
    _id_246E("crouch");
  } else if(self.a._id_0D26 == "stand") {
    _id_246E("stand");
  } else {
    animscripts\utility::_id_0F7D(1);
    self.a._id_0D26 = "crouch";
    _id_246E("crouch");
  }
}

_id_244B() {
  if(!isDefined(self.enemy)) {
    return 0;

  }
  if(!isDefined(self._id_244C)) {
    self._id_244C = gettime() + randomintrange(5000, 20000);

  }
  if(gettime() > self._id_244C) {
    self._id_244C = gettime() + randomintrange(5000, 20000);

    if(isDefined(self._id_0F84) && self.a._id_0D26 == "stand") {
      return 0;

    }
    self.a._id_0F3E = undefined;
    return 1;
  }

  return 0;
}

_id_0F36() {
  var_0 = "stand";

  if(self.a._id_0D26 == "crouch") {
    var_0 = "crouch";

    if(self._id_0CAF doesnodeallowstance("stand")) {
      if(!self._id_0CAF doesnodeallowstance("crouch") || _id_244B()) {
        var_0 = "stand";
      }
    }
  } else if(self._id_0CAF doesnodeallowstance("crouch")) {
    if(!self._id_0CAF doesnodeallowstance("stand") || _id_244B()) {
      var_0 = "crouch";
    }
  }

  if(self._id_2448) {
    _id_2470(var_0);
  } else {
    if(self.a._id_0D26 == var_0) {
      _id_2471(animscripts\utility::_id_0D4D("alert_idle"), 0.3, 0.4);
    } else {
      var_1 = animscripts\utility::_id_0D4D("stance_change");
      _id_2471(var_1, 0.3, getanimlength(var_1));
      _id_246E(var_0);
    }

    self._id_2448 = 1;
  }
}

_id_244D() {
  wait 2;

  for(;;) {
    _id_2467();
    wait 0.05;
  }
}

_id_244E(var_0, var_1) {
  var_2 = var_1 animscripts\utility::_id_244F(var_0);

  if(var_2 > 60 || var_2 < -60) {
    return 0;

  }
  if(var_1.type == "Cover Left" && var_2 > 14) {
    return 0;

  }
  if(var_1.type == "Cover Right" && var_2 < -12) {
    return 0;

  }
  return 1;
}

_id_2450() {
  if(!isDefined(self._id_0CB1)) {
    return 0;

  }
  var_0 = self._id_0CAF animscripts\utility::_id_244F(self._id_0CB1);

  if(self.a._id_0CAE == "over") {
    return var_0 < self.leftaimlimit || self.rightaimlimit < var_0;

  }
  if(self._id_2444 == "left") {
    if(self.a._id_0CAE == "B") {
      return var_0 < 0 - self._id_2451 || var_0 > 14;
    } else if(self.a._id_0CAE == "A") {
      return var_0 > 0 - self._id_2451;
    } else {
      return var_0 < -50 || var_0 > 8;
    }
  } else if(self.a._id_0CAE == "B") {
    return var_0 > self._id_2451 || var_0 < -12;
  } else if(self.a._id_0CAE == "A") {
    return var_0 < self._id_2451;
  } else {
    return var_0 > 50 || var_0 < -8;
  }
}

_id_2452(var_0, var_1) {
  var_2 = 0;
  var_3 = 0;

  if(isDefined(var_1)) {
    var_3 = var_0 animscripts\utility::_id_244F(var_1);

  }
  var_4 = [];

  if(isDefined(var_0) && self.a._id_0D26 == "crouch" && (var_3 > self.leftaimlimit && self.rightaimlimit > var_3)) {
    var_4 = var_0 getvalidcoverpeekouts();

  }
  if(self._id_2444 == "left") {
    if(_id_2455(var_3, -40, 0)) {
      var_2 = _id_2456();
      var_4[var_4.size] = "lean";
    }

    if(!var_2 && var_3 < 14) {
      if(var_3 < 0 - self._id_2451) {
        var_4[var_4.size] = "A";
      } else {
        var_4[var_4.size] = "B";
      }
    }
  } else {
    if(_id_2455(var_3, 0, 40)) {
      var_2 = _id_2456();
      var_4[var_4.size] = "lean";
    }

    if(!var_2 && var_3 > -12) {
      if(var_3 > self._id_2451) {
        var_4[var_4.size] = "A";
      } else {
        var_4[var_4.size] = "B";
      }
    }
  }

  return animscripts\combat_utility::_id_0FB6(var_4);
}

_id_2453() {
  var_0 = 0;

  if(animscripts\utility::_id_0CF3()) {
    var_0 = self._id_0CAF animscripts\utility::_id_244F(animscripts\utility::_id_0CEE());
  } else if(self.doingambush && isDefined(self._id_0CB1)) {
    var_0 = self._id_0CAF animscripts\utility::_id_244F(self._id_0CB1);

  }
  if(self.a._id_0CAE == "lean") {
    return "lean";

  }
  if(self.a._id_0CAE == "over") {
    return "over";
  } else if(self.a._id_0CAE == "B") {
    if(self._id_2444 == "left") {
      if(var_0 < 0 - self._id_2451) {
        return "A";
      }
    } else if(self._id_2444 == "right") {
      if(var_0 > self._id_2451) {
        return "A";
      }
    }

    return "B";
  } else if(self.a._id_0CAE == "A") {
    var_2 = "B";

    if(self._id_2444 == "left") {
      if(var_0 > 0 - self._id_2451) {
        return "B";
      }
    } else if(self._id_2444 == "right") {
      if(var_0 < self._id_2451) {
        return "B";
      }
    }

    return "A";
  }
}

_id_2454() {
  self endon("killanimscript");
  var_0 = _id_2453();

  if(var_0 == self.a._id_0CAE) {
    return 0;

  }
  self._id_0CDD = 1;
  self notify("done_changing_cover_pos");
  var_1 = self.a._id_0CAE + "_to_" + var_0;
  var_2 = animscripts\utility::_id_0CA8(var_1);
  var_3 = _id_246D();

  if(!self maymovetopoint(var_3)) {
    return 0;

  }
  if(!self maymovefrompointtopoint(var_3, animscripts\utility::_id_0F99(var_2))) {
    return 0;

  }
  animscripts\combat_utility::_id_0F9D();
  _id_2459(0.3);
  var_4 = self.a._id_0D26;
  self setanimlimited(animscripts\utility::_id_0D4D("straight_level"), 0, 0.2);
  self setflaggedanimknob("changeStepOutPos", var_2, 1, 0.2, 1.2);
  thread _id_112A("changeStepOutPos");

  if(animhasnotetrack(var_2, "start_aim")) {
    self waittillmatch("changeStepOutPos", "start_aim");
  } else {
    self waittillmatch("changeStepOutPos", "end");

  }
  thread _id_2457(undefined, 0, 0.3);
  self waittillmatch("changeStepOutPos", "end");
  self clearanim(var_2, 0.1);
  self.a._id_0CAE = var_0;
  self._id_0CDD = 0;
  self._id_0CFD = gettime();

  if(self.a._id_0D26 != var_4) {
    _id_246E(self.a._id_0D26);

  }
  thread _id_2458(undefined, 1, 0.3);
  return 1;
}

_id_2455(var_0, var_1, var_2) {
  if(self.a._id_20A5) {
    return 0;

  }
  return var_1 <= var_0 && var_0 <= var_2;
}

_id_2456() {
  if(self.team == "allies") {
    return 1;

  }
  if(animscripts\utility::_id_0F62()) {
    return 1;

  }
  return 0;
}

_id_112A(var_0) {
  self endon("killanimscript");
  animscripts\shared::_id_0C51(var_0);
}

_id_2457(var_0, var_1, var_2) {
  self._id_2447 = 1;

  if(self.a._id_0CAE == "lean") {
    self.a._id_237C = 1;
  } else {
    self.a._id_237C = undefined;

  }
  _id_245A(var_0, var_1, var_2);
}

_id_2458(var_0, var_1, var_2) {
  if(self.a._id_0CAE == "lean") {
    self.a._id_237C = 1;
  } else {
    self.a._id_237C = undefined;

  }
  _id_245A(var_0, var_1, var_2);
}

#using_animtree("generic_human");

_id_2459(var_0) {
  self._id_2447 = 0;
  self clearanim( % add_fire, var_0);
  animscripts\track::_id_0CC4(0, var_0);
}

_id_245A(var_0, var_1, var_2) {
  self._id_245B = var_0;
  self setanimlimited( % exposed_modern, 1, var_2);
  self setanimlimited( % exposed_aiming, 1, var_2);
  self setanimlimited( % add_idle, 1, var_2);
  animscripts\track::_id_0CC4(1, var_2);
  var_3 = undefined;

  if(isDefined(self.a._id_0C6D["lean_aim_straight"])) {
    var_3 = self.a._id_0C6D["lean_aim_straight"];

  }
  thread animscripts\combat_utility::_id_0F78();

  if(isDefined(self.a._id_237C)) {
    self setanimlimited(var_3, 1, var_2);
    self setanimlimited(animscripts\utility::_id_0D4D("straight_level"), 0, 0);
    self setanimknoblimited(animscripts\utility::_id_0D4D("lean_aim_left"), 1, var_2);
    self setanimknoblimited(animscripts\utility::_id_0D4D("lean_aim_right"), 1, var_2);
    self setanimknoblimited(animscripts\utility::_id_0D4D("lean_aim_up"), 1, var_2);
    self setanimknoblimited(animscripts\utility::_id_0D4D("lean_aim_down"), 1, var_2);
  } else if(var_1) {
    self setanimlimited(animscripts\utility::_id_0D4D("straight_level"), 1, var_2);

    if(isDefined(var_3)) {
      self setanimlimited(var_3, 0, 0);

    }
    self setanimknoblimited(animscripts\utility::_id_0D4D("add_aim_up"), 1, var_2);
    self setanimknoblimited(animscripts\utility::_id_0D4D("add_aim_down"), 1, var_2);
    self setanimknoblimited(animscripts\utility::_id_0D4D("add_aim_left"), 1, var_2);
    self setanimknoblimited(animscripts\utility::_id_0D4D("add_aim_right"), 1, var_2);
  } else {
    self setanimlimited(animscripts\utility::_id_0D4D("straight_level"), 0, var_2);

    if(isDefined(var_3)) {
      self setanimlimited(var_3, 0, 0);

    }
    self setanimknoblimited(animscripts\utility::_id_0D4D("add_turn_aim_up"), 1, var_2);
    self setanimknoblimited(animscripts\utility::_id_0D4D("add_turn_aim_down"), 1, var_2);
    self setanimknoblimited(animscripts\utility::_id_0D4D("add_turn_aim_left"), 1, var_2);
    self setanimknoblimited(animscripts\utility::_id_0D4D("add_turn_aim_right"), 1, var_2);
  }
}

_id_245C() {
  if(self.a._id_0CAE == "over") {
    return 1;

  }
  return animscripts\combat_utility::_id_0F97();
}

_id_245D() {
  self.a._id_0CAE = "alert";

  if(self.goalradius < 64) {
    self.goalradius = 64;

  }
  self animmode("zonly_physics");

  if(self.a._id_0D26 == "stand") {
    self._id_2451 = 38;
  } else {
    self._id_2451 = 31;

  }
  var_0 = self.a._id_0D26;
  _id_246E(var_0);
  self setdefaultaimlimits();
  var_1 = "none";

  if(animscripts\utility::_id_0F8C()) {
    var_1 = _id_2452(self._id_0CAF, animscripts\utility::_id_0CEE());
  } else {
    var_1 = _id_2452(self._id_0CAF);

  }
  if(!isDefined(var_1)) {
    return 0;

  }
  var_2 = "alert_to_" + var_1;
  var_3 = animscripts\utility::_id_0CA8(var_2);

  if(var_1 == "lean" && !_id_2468()) {
    return 0;

  }
  if(var_1 != "over" && !_id_246C(var_3, var_1 != "lean")) {
    return 0;

  }
  self.a._id_0CAE = var_1;
  self.a._id_0F3E = var_1;

  if(self.a._id_0CAE == "lean") {
    self setdefaultaimlimits(self._id_0CAF);

  }
  if(var_1 == "A" || var_1 == "B") {
    self.a._id_0D19 = "cover_" + self._id_2444 + "_" + self.a._id_0D26 + "_" + var_1;
  } else if(var_1 == "over") {
    self.a._id_0D19 = "cover_crouch_aim";
  } else {
    self.a._id_0D19 = "none";

  }
  self.keepclaimednodeifvalid = 1;
  var_4 = 0;
  self._id_0CDD = 1;
  self notify("done_changing_cover_pos");
  var_5 = _id_245C();
  self.pushable = 0;
  self setflaggedanimknoballrestart("stepout", var_3, % root, 1, 0.2, var_5);
  thread _id_112A("stepout");
  var_4 = animhasnotetrack(var_3, "start_aim");

  if(var_4) {
    self._id_0CB5 = self.angles[1] + getangledelta(var_3, 0, 1);
    self waittillmatch("stepout", "start_aim");
  } else {
    self waittillmatch("stepout", "end");

  }
  if(var_1 == "B" && common_scripts\utility::cointoss() && self._id_2444 == "right") {
    self.a._id_0D19 = "corner_right_martyrdom";

  }
  _id_246F(var_0);
  var_6 = var_1 == "over";
  _id_2457(undefined, var_6, 0.3);
  thread animscripts\track::_id_0CA9();

  if(var_4) {
    self waittillmatch("stepout", "end");
    self._id_0CB5 = undefined;
  }

  _id_2458(undefined, 1, 0.2);
  self clearanim( % cover, 0.1);
  self clearanim( % corner, 0.1);
  self._id_0CDD = 0;
  self._id_0CFD = gettime();
  self.pushable = 1;
  return 1;
}

_id_245E() {
  self.keepclaimednodeifvalid = 1;

  if(isDefined(self._id_0F84) && randomfloat(1) < self._id_0F84) {
    if(_id_0F8B()) {
      return 1;
    }
  }

  if(!_id_245D()) {
    return 0;

  }
  _id_0F88();

  if(isDefined(self._id_0CB1)) {
    var_0 = lengthsquared(self.origin - self._id_0CB1);

    if(animscripts\utility::_id_0BB6() && (var_0 < squared(512) || self.a.rockets < 1)) {
      if(self.a._id_0D26 == "stand") {
        animscripts\shared::_id_0F87( % rpg_stand_throw);
      } else {
        animscripts\shared::_id_0F87( % rpg_crouch_throw);

      }
      thread _id_2478();
      return;
    }
  }

  _id_2465();
  self.keepclaimednodeifvalid = 0;
  return 1;
}

_id_245F(var_0) {
  if(!isDefined(self._id_0F91)) {
    return 1;

  }
  return gettime() - self._id_0F91 > var_0 * 1000;
}

_id_0F8B() {
  if(!animscripts\utility::_id_0F8C()) {
    return 0;

  }
  var_0 = 0;
  var_1 = 90;
  var_2 = self._id_0CAF animscripts\utility::_id_244F(animscripts\utility::_id_0CEE());

  if(self._id_2444 == "left") {
    var_2 = 0 - var_2;

  }
  if(var_2 > 30) {
    var_1 = 45;

    if(self._id_2444 == "left") {
      var_0 = 45;
    } else {
      var_0 = -45;
    }
  }

  var_3 = "rambo" + var_1;

  if(!animscripts\utility::_id_0F8D(var_3)) {
    return 0;

  }
  var_4 = animscripts\utility::_id_0CA8(var_3);
  var_5 = _id_246D(48);

  if(!self maymovetopoint(var_5)) {
    return 0;

  }
  self._id_0CFD = gettime();
  self animmode("zonly_physics");
  self.keepclaimednodeifvalid = 1;
  self._id_0F8F = 1;
  self.a._id_0F3E = "rambo";
  self._id_0CDD = 1;
  thread animscripts\shared::_id_0F90(var_0);
  self setflaggedanimknoballrestart("rambo", var_4, % body, 1, 0, 1);
  animscripts\shared::_id_0C51("rambo");
  self notify("rambo_aim_end");
  self._id_0CDD = 0;
  self.keepclaimednodeifvalid = 0;
  self._id_0F91 = gettime();
  self._id_0CDD = 0;
  self._id_0F8F = undefined;
  return 1;
}

_id_0F88() {
  maps\_gameskill::_id_0F89();

  for(;;) {
    for(;;) {
      if(isDefined(self._id_0CDC)) {
        break;
      }

      if(!isDefined(self._id_0CB1)) {
        self waittill("do_slow_things");
        waittillframeend;

        if(isDefined(self._id_0CB1)) {
          continue;
        }
        break;
      }

      if(!self._id_0CD1) {
        break;
      }

      if(_id_2450()) {
        if(!_id_2454()) {
          if(_id_2453() == self.a._id_0CAE) {
            break;
          }

          _id_2460(0.2);
          continue;
        }

        if(_id_2450()) {
          break;
        }
      } else {
        _id_2462(1);
        self clearanim( % add_fire, 0.2);
      }
    }

    if(_id_2464(self.a._id_0CAE != "lean")) {
      break;
    }

    if(_id_2450() && _id_2454()) {
      continue;
    }
    _id_2460(0.2);
  }
}

_id_2460(var_0) {
  thread _id_2461(var_0);
  var_1 = gettime();
  _id_2462(0);
  self notify("stopNotifyStopShootingAfterTime");
  var_2 = (gettime() - var_1) / 1000;

  if(var_2 < var_0) {
    wait(var_0 - var_2);
  }
}

_id_2461(var_0) {
  self endon("killanimscript");
  self endon("stopNotifyStopShootingAfterTime");
  wait(var_0);
  self notify("stopShooting");
}

_id_2462(var_0) {
  self endon("return_to_cover");

  if(var_0) {
    thread _id_0FB3();

  }
  thread animscripts\combat_utility::_id_0F78();
  animscripts\combat_utility::_id_0F06();
}

_id_0FB3() {
  self endon("killanimscript");
  self notify("newAngleRangeCheck");
  self endon("newAngleRangeCheck");
  self endon("take_cover_at_corner");

  for(;;) {
    if(_id_2450()) {
      break;
    }

    wait 0.1;
  }

  self notify("stopShooting");
}

_id_2463() {
  self.enemy endon("death");
  self endon("enemy");
  self endon("stopshowstate");

  for(;;) {
    wait 0.05;
  }
}

_id_2464(var_0) {
  if(var_0) {
    var_1 = _id_246D();

    if(!self maymovetopoint(var_1)) {
      return 0;

    }
    return self maymovefrompointtopoint(var_1, self._id_0CAF.origin);
  } else {
    return self maymovetopoint(self._id_0CAF.origin);
  }
}

_id_2465() {
  animscripts\combat_utility::_id_0F85();
  var_0 = animscripts\utility::_id_0F4C();
  self notify("take_cover_at_corner");
  self._id_0CDD = 1;
  self notify("done_changing_cover_pos");
  var_1 = self.a._id_0CAE + "_to_alert";
  var_2 = animscripts\utility::_id_0CA8(var_1);
  _id_2459(0.3);
  var_3 = 0;

  if(self.a._id_0CAE != "lean" && var_0 && animscripts\utility::_id_0F8D(var_1 + "_reload") && randomfloat(100) < 75) {
    var_2 = animscripts\utility::_id_0CA8(var_1 + "_reload");
    var_3 = 1;
  }

  var_4 = _id_245C();
  self clearanim( % body, 0.1);
  self setflaggedanimrestart("hide", var_2, 1, 0.1, var_4);
  animscripts\shared::_id_0C51("hide");

  if(var_3) {
    animscripts\weaponlist::_id_0CD0();

  }
  self._id_0CDD = 0;

  if(self._id_2444 == "left") {
    self.a._id_0D19 = "cover_left";
  } else {
    self.a._id_0D19 = "cover_right";

  }
  self.keepclaimednodeifvalid = 0;
  self clearanim(var_2, 0.2);
}

_id_0F64() {
  if(!animscripts\utility::_id_0F8D("blind_fire")) {
    return 0;

  }
  self animmode("zonly_physics");
  self.keepclaimednodeifvalid = 1;
  self setflaggedanimknoballrestart("blindfire", animscripts\utility::_id_0CA8("blind_fire"), % body, 1, 0, 1);
  animscripts\shared::_id_0C51("blindfire");
  self.keepclaimednodeifvalid = 0;
  return 1;
}

_id_2466(var_0, var_1, var_2) {
  if(!isDefined(var_2)) {
    var_2 = (1, 1, 1);

  }
  for(var_3 = 0; var_3 < 100; var_3++) {
    wait 0.05;
  }
}

_id_0F9E(var_0) {
  return _id_0F61(var_0, 1);
}

_id_0F61(var_0, var_1) {
  if(!self maymovetopoint(_id_246D())) {
    return 0;

  }
  if(isDefined(self._id_0F9F) || isDefined(var_0._id_0FA0)) {
    return 0;

  }
  var_2 = undefined;

  if(isDefined(self._id_0F84) && randomfloat(1) < self._id_0F84) {
    if(isDefined(self.a._id_0C6D["grenade_rambo"])) {
      var_2 = animscripts\utility::_id_0D4D("grenade_rambo");
    }
  }

  if(!isDefined(var_2)) {
    if(isDefined(var_1) && var_1) {
      if(!isDefined(self.a._id_0C6D["grenade_safe"])) {
        return 0;

      }
      var_2 = animscripts\utility::_id_0D4D("grenade_safe");
    } else {
      if(!isDefined(self.a._id_0C6D["grenade_exposed"])) {
        return 0;

      }
      var_2 = animscripts\utility::_id_0D4D("grenade_exposed");
    }
  }

  self animmode("zonly_physics");
  self.keepclaimednodeifvalid = 1;
  var_3 = animscripts\combat_utility::_id_0FA1(var_0, var_2);
  self.keepclaimednodeifvalid = 0;
  return var_3;
}

_id_2467() {}

_id_0F56(var_0) {
  if(!isDefined(self.a._id_0C6D["alert_to_look"])) {
    return 0;

  }
  self animmode("zonly_physics");
  self.keepclaimednodeifvalid = 1;

  if(!_id_0F94()) {
    return 0;

  }
  animscripts\shared::_id_0F93(animscripts\utility::_id_0D4D("look_idle"), var_0, ::_id_246A);
  var_1 = undefined;

  if(animscripts\utility::_id_0F4C()) {
    var_1 = animscripts\utility::_id_0D4D("look_to_alert_fast");
  } else {
    var_1 = animscripts\utility::_id_0D4D("look_to_alert");

  }
  self setflaggedanimknoballrestart("looking_end", var_1, % body, 1, 0.1, 1.0);
  animscripts\shared::_id_0C51("looking_end");
  self animmode("zonly_physics");
  self.keepclaimednodeifvalid = 0;
  return 1;
}

_id_2468() {
  var_0 = self getEye();
  var_1 = anglestoright(self._id_0CAF.angles);

  if(self._id_2444 == "right") {
    var_0 = var_0 + var_1 * 30;
  } else {
    var_0 = var_0 - var_1 * 30;

  }
  var_2 = var_0 + anglesToForward(self._id_0CAF.angles) * 30;
  return sighttracepassed(var_0, var_2, 1, self);
}

_id_0F94() {
  if(isDefined(self._id_0CAF._id_0F95)) {
    return 0;

  }
  if(isDefined(self._id_2469) && gettime() < self._id_2469) {
    return 0;

  }
  if(!_id_2468()) {
    self._id_2469 = gettime() + 3000;
    return 0;
  }

  var_0 = animscripts\utility::_id_0D4D("alert_to_look");
  self setflaggedanimknoball("looking_start", var_0, % body, 1, 0.2, 1);
  animscripts\shared::_id_0C51("looking_start");
  return 1;
}

_id_246A() {
  return self maymovetopoint(self._id_0CAF.origin);
}

_id_0F57() {
  return 0;
}

_id_246B() {
  var_0 = animscripts\utility::_id_0CA8("reload");
  self setflaggedanimknobrestart("cornerReload", var_0, 1, 0.2);
  animscripts\shared::_id_0C51("cornerReload");
  animscripts\weaponlist::_id_0CD0();
  self setanimrestart(animscripts\utility::_id_0D4D("alert_idle"), 1, 0.2);
  self clearanim(var_0, 0.2);
  return 1;
}

_id_246C(var_0, var_1) {
  if(var_1) {
    var_2 = _id_246D();

    if(!self maymovetopoint(var_2)) {
      return 0;

    }
    return self maymovefrompointtopoint(var_2, animscripts\utility::_id_0F99(var_0));
  } else {
    return self maymovetopoint(animscripts\utility::_id_0F99(var_0));
  }
}

_id_246D(var_0) {
  var_1 = self._id_0CAF.angles;
  var_2 = anglestoright(var_1);

  if(!isDefined(var_0)) {
    var_0 = 36;

  }
  switch (self.script) {
    case "cover_left":
      var_2 = var_2 * (0 - var_0);
      break;
    case "cover_right":
      var_2 = var_2 * var_0;
      break;
    default:
  }

  return self._id_0CAF.origin + (var_2[0], var_2[1], 0);
}

_id_0F59() {
  self endon("end_idle");

  for(;;) {
    var_0 = randomint(2) == 0 && animscripts\utility::_id_0F8D("alert_idle_twitch");

    if(var_0) {
      var_1 = animscripts\utility::_id_0CA8("alert_idle_twitch");
    } else {
      var_1 = animscripts\utility::_id_0D4D("alert_idle");

    }
    _id_0F92(var_1, var_0);
  }
}

_id_0F5B() {
  if(!animscripts\utility::_id_0F8D("alert_idle_flinch")) {
    return 0;

  }
  _id_0F92(animscripts\utility::_id_0CA8("alert_idle_flinch"), 1);
  return 1;
}

_id_0F92(var_0, var_1) {
  if(var_1) {
    self setflaggedanimknoballrestart("idle", var_0, % body, 1, 0.1, 1);
  } else {
    self setflaggedanimknoball("idle", var_0, % body, 1, 0.1, 1);

  }
  animscripts\shared::_id_0C51("idle");
}

_id_246E(var_0) {
  [[self._id_2443["hiding"][var_0]]]();
  [[self._id_2443["exposed"][var_0]]]();
}

_id_246F(var_0) {
  [[self._id_2443["exposed"][var_0]]]();
}

_id_2470(var_0) {
  if(self.a._id_0D26 == var_0) {
    _id_246E(var_0);
    return;
  }

  self setflaggedanimknoballrestart("changeStance", animscripts\utility::_id_0D4D("stance_change"), % body);
  _id_246E(var_0);
  animscripts\shared::_id_0C51("changeStance");
  wait 0.2;
}

_id_2471(var_0, var_1, var_2) {
  var_3 = animscripts\utility::_id_2472();
  var_4 = animscripts\utility::_id_2473();
  var_5 = var_3 + self._id_2474;
  self orientmode("face angle", var_5);
  self animmode("normal");
  thread animscripts\shared::_id_0F7C(var_4, var_1);
  self setflaggedanimknoballrestart("coveranim", var_0, % body, 1, var_1);
  animscripts\notetracks::_id_0D4F(var_2, "coveranim");

  while(animscripts\utility::_id_0D61(self.angles[1] - var_5) > 1) {
    animscripts\notetracks::_id_0D4F(0.1, "coveranim");

  }
  self animmode("zonly_physics");

  if(self._id_2444 == "left") {
    self.a._id_0D19 = "cover_left";
  } else {
    self.a._id_0D19 = "cover_right";
  }
}

_id_2475() {
  self endon("killanimscript");

  for(;;) {
    wait 0.05;
  }
}

_id_2476() {
  if(!isDefined(self.a._id_0C6D)) {}

  self.a._id_0C6D["add_aim_up"] = % exposed_aim_8;
  self.a._id_0C6D["add_aim_down"] = % exposed_aim_2;
  self.a._id_0C6D["add_aim_left"] = % exposed_aim_4;
  self.a._id_0C6D["add_aim_right"] = % exposed_aim_6;
  self.a._id_0C6D["add_turn_aim_up"] = % exposed_turn_aim_8;
  self.a._id_0C6D["add_turn_aim_down"] = % exposed_turn_aim_2;
  self.a._id_0C6D["add_turn_aim_left"] = % exposed_turn_aim_4;
  self.a._id_0C6D["add_turn_aim_right"] = % exposed_turn_aim_6;
  self.a._id_0C6D["straight_level"] = % exposed_aim_5;

  if(self.a._id_0CAE == "lean") {
    var_0 = self.a._id_0C6D["lean_fire"];
    var_1 = self.a._id_0C6D["lean_single"];
    self.a._id_0C6D["fire"] = var_0;
    self.a._id_0C6D["single"] = animscripts\utility::_id_0C6D(var_1);
    self.a._id_0C6D["semi2"] = var_1;
    self.a._id_0C6D["semi3"] = var_1;
    self.a._id_0C6D["semi4"] = var_1;
    self.a._id_0C6D["semi5"] = var_1;
    self.a._id_0C6D["burst2"] = var_0;
    self.a._id_0C6D["burst3"] = var_0;
    self.a._id_0C6D["burst4"] = var_0;
    self.a._id_0C6D["burst5"] = var_0;
    self.a._id_0C6D["burst6"] = var_0;
  } else {
    self.a._id_0C6D["fire"] = % exposed_shoot_auto_v2;
    self.a._id_0C6D["semi2"] = % exposed_shoot_semi2;
    self.a._id_0C6D["semi3"] = % exposed_shoot_semi3;
    self.a._id_0C6D["semi4"] = % exposed_shoot_semi4;
    self.a._id_0C6D["semi5"] = % exposed_shoot_semi5;

    if(animscripts\utility::_id_0C97()) {
      self.a._id_0C6D["single"] = animscripts\utility::_id_0C6D( % shotgun_stand_fire_1a);
    } else {
      self.a._id_0C6D["single"] = animscripts\utility::_id_0C6D( % exposed_shoot_semi1);

    }
    self.a._id_0C6D["burst2"] = % exposed_shoot_burst3;
    self.a._id_0C6D["burst3"] = % exposed_shoot_burst3;
    self.a._id_0C6D["burst4"] = % exposed_shoot_burst4;
    self.a._id_0C6D["burst5"] = % exposed_shoot_burst5;
    self.a._id_0C6D["burst6"] = % exposed_shoot_burst6;
  }

  self.a._id_0C6D["exposed_idle"] = animscripts\utility::_id_0C6D( % exposed_idle_alert_v1, % exposed_idle_alert_v2, % exposed_idle_alert_v3);
}

_id_2477() {
  if(!isDefined(self.a._id_0C6D)) {}

  if(self.a._id_0CAE == "over") {
    self.a._id_0C6D["add_aim_up"] = % covercrouch_aim8_add;
    self.a._id_0C6D["add_aim_down"] = % covercrouch_aim2_add;
    self.a._id_0C6D["add_aim_left"] = % covercrouch_aim4_add;
    self.a._id_0C6D["add_aim_right"] = % covercrouch_aim6_add;
    self.a._id_0C6D["straight_level"] = % covercrouch_aim5;
    var_0["fire"] = % exposed_shoot_auto_v2;
    var_0["semi2"] = % exposed_shoot_semi2;
    var_0["semi3"] = % exposed_shoot_semi3;
    var_0["semi4"] = % exposed_shoot_semi4;
    var_0["semi5"] = % exposed_shoot_semi5;
    var_0["burst2"] = % exposed_shoot_burst3;
    var_0["burst3"] = % exposed_shoot_burst3;
    var_0["burst4"] = % exposed_shoot_burst4;
    var_0["burst5"] = % exposed_shoot_burst5;
    var_0["burst6"] = % exposed_shoot_burst6;

    if(animscripts\utility::_id_0C97()) {
      var_0["single"] = animscripts\utility::_id_0C6D( % shotgun_crouch_fire);
    } else {
      var_0["single"] = animscripts\utility::_id_0C6D( % exposed_shoot_semi1);

    }
    self.a._id_0C6D["exposed_idle"] = animscripts\utility::_id_0C6D( % exposed_idle_alert_v1, % exposed_idle_alert_v2, % exposed_idle_alert_v3);
    return;
  }

  if(self.a._id_0CAE == "lean") {
    var_1 = self.a._id_0C6D["lean_fire"];
    var_2 = self.a._id_0C6D["lean_single"];
    self.a._id_0C6D["fire"] = var_1;
    self.a._id_0C6D["single"] = animscripts\utility::_id_0C6D(var_2);
    self.a._id_0C6D["semi2"] = var_2;
    self.a._id_0C6D["semi3"] = var_2;
    self.a._id_0C6D["semi4"] = var_2;
    self.a._id_0C6D["semi5"] = var_2;
    self.a._id_0C6D["burst2"] = var_1;
    self.a._id_0C6D["burst3"] = var_1;
    self.a._id_0C6D["burst4"] = var_1;
    self.a._id_0C6D["burst5"] = var_1;
    self.a._id_0C6D["burst6"] = var_1;
  } else {
    self.a._id_0C6D["fire"] = % exposed_crouch_shoot_auto_v2;
    self.a._id_0C6D["semi2"] = % exposed_crouch_shoot_semi2;
    self.a._id_0C6D["semi3"] = % exposed_crouch_shoot_semi3;
    self.a._id_0C6D["semi4"] = % exposed_crouch_shoot_semi4;
    self.a._id_0C6D["semi5"] = % exposed_crouch_shoot_semi5;

    if(animscripts\utility::_id_0C97()) {
      self.a._id_0C6D["single"] = animscripts\utility::_id_0C6D( % shotgun_crouch_fire);
    } else {
      self.a._id_0C6D["single"] = animscripts\utility::_id_0C6D( % exposed_crouch_shoot_semi1);

    }
    self.a._id_0C6D["burst2"] = % exposed_crouch_shoot_burst3;
    self.a._id_0C6D["burst3"] = % exposed_crouch_shoot_burst3;
    self.a._id_0C6D["burst4"] = % exposed_crouch_shoot_burst4;
    self.a._id_0C6D["burst5"] = % exposed_crouch_shoot_burst5;
    self.a._id_0C6D["burst6"] = % exposed_crouch_shoot_burst6;
  }

  self.a._id_0C6D["add_aim_up"] = % exposed_crouch_aim_8;
  self.a._id_0C6D["add_aim_down"] = % exposed_crouch_aim_2;
  self.a._id_0C6D["add_aim_left"] = % exposed_crouch_aim_4;
  self.a._id_0C6D["add_aim_right"] = % exposed_crouch_aim_6;
  self.a._id_0C6D["add_turn_aim_up"] = % exposed_crouch_turn_aim_8;
  self.a._id_0C6D["add_turn_aim_down"] = % exposed_crouch_turn_aim_2;
  self.a._id_0C6D["add_turn_aim_left"] = % exposed_crouch_turn_aim_4;
  self.a._id_0C6D["add_turn_aim_right"] = % exposed_crouch_turn_aim_6;
  self.a._id_0C6D["straight_level"] = % exposed_crouch_aim_5;
  self.a._id_0C6D["exposed_idle"] = animscripts\utility::_id_0C6D( % exposed_crouch_idle_alert_v1, % exposed_crouch_idle_alert_v2, % exposed_crouch_idle_alert_v3);
}

_id_2478() {
  self notify("killanimscript");
  thread animscripts\combat::main();
}