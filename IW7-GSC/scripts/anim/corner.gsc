/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\anim\corner.gsc
**************************************/

_id_4661(var_0, var_1) {
  self endon("killanimscript");
  self._id_1F66["exposed"]["stand"] = ::_id_F5AD;
  self._id_1F66["exposed"]["crouch"] = ::_id_F317;
  self.covernode = self.node;
  self._id_4664 = var_0;
  self.a._id_4667 = "unknown";
  self.a._id_1A3E = undefined;
  scripts\anim\cover_behavior::_id_129B4(var_1);
  _id_F30C();
  self._id_9F4D = 0;
  self._id_11AE0 = 0;
  self._id_4662 = 0;
  scripts\anim\track::_id_F641(0);
  self._id_8C4B = 0;
  var_2 = spawnStruct();

  if(!self.fixednode) {
    var_2._id_BD1C = scripts\anim\cover_behavior::_id_BD1C;
  }

  var_2._id_B24A = ::_id_B24A;
  var_2.reload = ::_id_4668;
  var_2._id_AB2D = ::_id_10F8B;
  var_2.look = ::_id_B01C;
  var_2._id_6B9B = ::_id_6B9B;
  var_2._id_92CC = ::_id_92CC;
  var_2.grenade = ::_id_128AF;
  var_2._id_85BF = ::_id_128B0;
  var_2._id_2B99 = ::_id_2B99;
  scripts\anim\cover_behavior::main(var_2);
}

_id_62F3() {
  self._id_10F8C = undefined;
  self.a._id_AAF2 = undefined;
}

_id_F30C() {
  if(self.a.pose == "crouch") {
    _id_F2AE("crouch");
  } else if(self.a.pose == "stand") {
    _id_F2AE("stand");
  } else {
    scripts\anim\utility::exitpronewrapper(1);
    self.a.pose = "crouch";
    _id_F2AE("crouch");
  }
}

_id_FFD1() {
  if(!isDefined(self.enemy)) {
    return 0;
  }

  if(!isDefined(self._id_3C5B)) {
    self._id_3C5B = gettime() + randomintrange(5000, 20000);
  }

  if(gettime() > self._id_3C5B) {
    self._id_3C5B = gettime() + randomintrange(5000, 20000);

    if(isDefined(self._id_DC5C) && self.a.pose == "stand") {
      return 0;
    }

    self.a._id_D892 = undefined;
    return 1;
  }

  return 0;
}

_id_B24A() {
  var_0 = "stand";

  if(self.a.pose == "crouch") {
    var_0 = "crouch";

    if(self.covernode doesnodeallowstance("stand")) {
      if(!self.covernode doesnodeallowstance("crouch") || _id_FFD1()) {
        var_0 = "stand";
      }
    }
  } else if(self.covernode doesnodeallowstance("crouch")) {
    if(!self.covernode doesnodeallowstance("stand") || _id_FFD1()) {
      var_0 = "crouch";
    }
  }

  if(self._id_8C4B) {
    transitiontostance(var_0);
  } else {
    if(self.a.pose == var_0) {
      if(isDefined(self.cover) && isDefined(self.cover._id_8ED9) && self.cover._id_8ED9 == "back") {
        var_1 = scripts\anim\utility::_id_1F64("alert_idle_back");
      } else {
        var_1 = scripts\anim\utility::_id_1F64("alert_idle");
      }

      _id_846D(var_1, 0.3, 0.4);
    } else {
      var_2 = scripts\anim\utility::_id_1F64("stance_change");
      _id_846D(var_2, 0.3, getanimlength(var_2));
      _id_F2AE(var_0);
    }

    self._id_8C4B = 1;
  }
}

_id_D921() {
  wait 2;

  for(;;) {
    _id_D922();
    wait 0.05;
  }
}

shootposwrapper_func() {
  if(!isDefined(self._id_FECF)) {
    return 0;
  }

  var_0 = self.covernode scripts\anim\utility_common::getyawtoorigin(self._id_FECF);

  if(self.a._id_4667 == "over") {
    return var_0 > self.leftaimlimit || self.rightaimlimit > var_0;
  }

  if(self._id_4664 == "up") {
    return var_0 < -50 || var_0 > 50;
  } else if(self._id_4664 == "left") {
    if(self.a._id_4667 == "B") {
      return var_0 > self._id_1513 || var_0 < -14;
    } else if(self.a._id_4667 == "A") {
      return var_0 < self._id_1513;
    } else {
      return var_0 > 50 || var_0 < -8;
    }
  } else if(self.a._id_4667 == "B")
    return var_0 < -1 * self._id_1513 || var_0 > 12;
  else if(self.a._id_4667 == "A") {
    return var_0 > -1 * self._id_1513;
  } else {
    return var_0 < -50 || var_0 > 8;
  }
}

_id_7E3C(var_0, var_1) {
  var_2 = 0;
  var_3 = 0;

  if(isDefined(var_1)) {
    var_3 = var_0 scripts\anim\utility_common::getyawtoorigin(var_1);
  }

  var_4 = [];

  if(isDefined(var_0) && self.a.pose == "crouch" && (var_3 < self.leftaimlimit && self.rightaimlimit < var_3)) {
    var_4 = var_0 _meth_8169();
  }

  if(self._id_4664 == "up") {
    if(scripts\engine\utility::actor_is3d()) {
      var_5 = 0;

      if(isDefined(var_1)) {
        var_6 = anglestoup(self.angles);
        var_5 = scripts\anim\combat_utility::_id_8063(var_1, self getEye() + (var_6[0] * 12, var_6[1] * 12, var_6[2] * 12));
      }

      if(_id_38C5(var_5, -80, 5)) {
        var_2 = _id_10032();
        var_4[var_4.size] = "lean";
        var_4[var_4.size] = "lean";
      }

      if(!var_2) {
        var_4[var_4.size] = "A";
      }
    } else
      var_4[var_4.size] = "A";
  } else if(self._id_4664 == "left") {
    if(_id_38C5(var_3, 0, 40)) {
      var_2 = _id_10032();
      var_4[var_4.size] = "lean";
    }

    if(!var_2 && var_3 > -14) {
      if(var_3 > self._id_1513) {
        var_4[var_4.size] = "A";
      } else {
        var_4[var_4.size] = "B";
      }
    }
  } else {
    if(_id_38C5(var_3, -40, 0)) {
      var_2 = _id_10032();
      var_4[var_4.size] = "lean";
    }

    if(!var_2 && var_3 < 12) {
      if(var_3 > -1 * self._id_1513) {
        var_4[var_4.size] = "A";
      } else {
        var_4[var_4.size] = "B";
      }
    }
  }

  return scripts\anim\combat_utility::_id_80B5(var_4);
}

_id_7E03() {
  var_0 = 0;

  if(scripts\anim\utility_common::cansuppressenemy()) {
    var_0 = self.covernode scripts\anim\utility_common::getyawtoorigin(scripts\anim\utility::_id_7E90());
  } else if(self.doingambush && isDefined(self._id_FECF)) {
    var_0 = self.covernode scripts\anim\utility_common::getyawtoorigin(self._id_FECF);
  }

  if(self.a._id_4667 == "lean") {
    return "lean";
  }

  if(self.a._id_4667 == "over") {
    return "over";
  } else if(self.a._id_4667 == "B") {
    if(self._id_4664 == "left") {
      if(var_0 > self._id_1513) {
        return "A";
      }
    } else if(self._id_4664 == "right") {
      if(var_0 < -1 * self._id_1513) {
        return "A";
      }
    }

    return "B";
  } else if(self.a._id_4667 == "A") {
    if(self._id_4664 == "up") {
      return "A";
    } else if(self._id_4664 == "left") {
      if(var_0 < self._id_1513) {
        return "B";
      }
    } else if(self._id_4664 == "right") {
      if(var_0 > -1 * self._id_1513) {
        return "B";
      }
    }

    return "A";
  }
}

_id_3C5D() {
  self endon("killanimscript");
  var_0 = _id_7E03();

  if(var_0 == self.a._id_4667) {
    return 0;
  }

  self._id_3C60 = 1;
  self notify("done_changing_cover_pos");
  var_1 = self.a._id_4667 + "_to_" + var_0;
  var_2 = scripts\anim\utility::_id_1F67(var_1);

  if(scripts\engine\utility::actor_is3d() && (var_1 == "A_to_B" || var_1 == "B_to_A")) {
    return 0;
  }

  var_3 = !scripts\engine\utility::actor_is3d();
  var_4 = _id_8095();

  if(!self maymovetopoint(var_4, var_3)) {
    return 0;
  }

  if(!self maymovefrompointtopoint(var_4, scripts\anim\utility::_id_7DC6(var_2), var_3)) {
    return 0;
  }

  scripts\anim\combat_utility::_id_6309();
  _id_1105C(0.3);
  var_5 = self.a.pose;
  self _meth_82AC(scripts\anim\utility::_id_1F64("straight_level"), 0, 0.2);
  self _meth_82E2("changeStepOutPos", var_2, 1, 0.2, 1.2);
  _id_465E(var_2);
  thread donotetrackswithendon("changeStepOutPos");
  var_6 = animhasnotetrack(var_2, "start_aim");

  if(var_6) {
    self waittillmatch("changeStepOutPos", "start_aim");
  } else {
    self waittillmatch("changeStepOutPos", "end");
  }

  thread _id_10D6A(undefined, 0, 0.3);

  if(var_6) {
    self waittillmatch("changeStepOutPos", "end");
  }

  self clearanim(var_2, 0.1);
  self.a._id_4667 = var_0;
  self._id_3C60 = 0;
  self._id_4740 = gettime();

  if(self.a.pose != var_5) {
    _id_F2AE(self.a.pose);
  }

  thread _id_3C50(undefined, 1, 0.3);
  return 1;
}

_id_38C5(var_0, var_1, var_2) {
  if(self.a._id_BEF9) {
    return 0;
  }

  return var_1 <= var_0 && var_0 <= var_2;
}

_id_10032() {
  if(self.team == "allies") {
    return 1;
  }

  if(scripts\anim\utility::_id_9ED4()) {
    return 1;
  }

  return 0;
}

donotetrackswithendon(var_0) {
  self endon("killanimscript");
  scripts\anim\shared::donotetracks(var_0);
}

_id_10D6A(var_0, var_1, var_2) {
  self._id_4662 = 1;

  if(self.a._id_4667 == "lean") {
    self.a._id_AAF2 = 1;
  } else {
    self.a._id_AAF2 = undefined;
  }

  _id_F637(var_0, var_1, var_2);
}

_id_3C50(var_0, var_1, var_2) {
  if(self.a._id_4667 == "lean") {
    self.a._id_AAF2 = 1;
  } else {
    self.a._id_AAF2 = undefined;
  }

  _id_F637(var_0, var_1, var_2);
}

#using_animtree("generic_human");

_id_1105C(var_0) {
  self._id_4662 = 0;
  self clearanim(%add_fire, var_0);
  scripts\anim\track::_id_F641(0, var_0);
  self.facialidx = undefined;
  self clearanim(%head, 0.2);
}

_id_F637(var_0, var_1, var_2) {
  self._id_10A5A = var_0;
  self _meth_82AC(%exposed_modern, 1, var_2);
  self _meth_82AC(%exposed_aiming, 1, var_2);
  self _meth_82AC(%add_idle, 1, var_2);
  scripts\anim\track::_id_F641(1, var_2);
  _id_465D(undefined);
  var_3 = undefined;

  if(isDefined(self.a._id_2274["lean_aim_straight"])) {
    var_3 = self.a._id_2274["lean_aim_straight"];
  }

  thread scripts\anim\combat_utility::_id_1A3E();

  if(isDefined(self.a._id_AAF2)) {
    self _meth_82AC(var_3, 1, var_2);
    self _meth_82AC(scripts\anim\utility::_id_1F64("straight_level"), 0, 0);
    self _meth_82A9(scripts\anim\utility::_id_1F64("lean_aim_left"), 1, var_2);
    self _meth_82A9(scripts\anim\utility::_id_1F64("lean_aim_right"), 1, var_2);
    self _meth_82A9(scripts\anim\utility::_id_1F64("lean_aim_up"), 1, var_2);
    self _meth_82A9(scripts\anim\utility::_id_1F64("lean_aim_down"), 1, var_2);
  } else if(var_1) {
    self _meth_82AC(scripts\anim\utility::_id_1F64("straight_level"), 1, var_2);

    if(isDefined(var_3)) {
      self _meth_82AC(var_3, 0, 0);
    }

    self _meth_82A9(scripts\anim\utility::_id_1F64("add_aim_up"), 1, var_2);
    self _meth_82A9(scripts\anim\utility::_id_1F64("add_aim_down"), 1, var_2);
    self _meth_82A9(scripts\anim\utility::_id_1F64("add_aim_left"), 1, var_2);
    self _meth_82A9(scripts\anim\utility::_id_1F64("add_aim_right"), 1, var_2);
  } else {
    self _meth_82AC(scripts\anim\utility::_id_1F64("straight_level"), 0, var_2);

    if(isDefined(var_3)) {
      self _meth_82AC(var_3, 0, 0);
    }

    self _meth_82A9(scripts\anim\utility::_id_1F64("add_turn_aim_up"), 1, var_2);
    self _meth_82A9(scripts\anim\utility::_id_1F64("add_turn_aim_down"), 1, var_2);
    self _meth_82A9(scripts\anim\utility::_id_1F64("add_turn_aim_left"), 1, var_2);
    self _meth_82A9(scripts\anim\utility::_id_1F64("add_turn_aim_right"), 1, var_2);
  }
}

_id_10F8A() {
  if(self.a._id_4667 == "over") {
    return 1;
  }

  return scripts\anim\combat_utility::_id_DCAD();
}

_id_10F89() {
  self.a._id_4667 = "alert";

  if(self.goalradius < 64) {
    self.goalradius = 64;
  }

  _id_F6B9();

  if(self.a.pose == "stand") {
    self._id_1513 = 38;
  } else {
    self._id_1513 = 31;
  }

  var_0 = self.a.pose;
  _id_F2AE(var_0);
  scripts\anim\combat::_id_F337();
  var_1 = "none";

  if(scripts\anim\utility::_id_8BED()) {
    var_1 = _id_7E3C(self.covernode, scripts\anim\utility::_id_7E90());
  } else {
    var_1 = _id_7E3C(self.covernode);
  }

  if(!isDefined(var_1)) {
    return 0;
  }

  var_2 = "alert_to_" + var_1;

  if(!scripts\anim\utility::_id_1F65(var_2)) {
    return 0;
  }

  var_3 = scripts\anim\utility::_id_1F67(var_2);

  if(var_1 == "lean" && !_id_9EDA()) {
    return 0;
  }

  if(var_1 != "over" && !_id_9ED6(var_3, var_1 != "lean")) {
    return 0;
  }

  self.a._id_4667 = var_1;
  self.a._id_D892 = var_1;

  if(self.a._id_4667 == "lean") {
    scripts\anim\combat::_id_F337(self.covernode);
  }

  if(var_1 == "A" || var_1 == "B") {
    self.a._id_10930 = "cover_" + self._id_4664 + "_" + self.a.pose + "_" + var_1;
  } else if(var_1 == "over") {
    self.a._id_10930 = "cover_crouch_aim";
  } else {
    self.a._id_10930 = "none";
  }

  self.keepclaimednodeifvalid = 1;
  var_4 = 0;
  self._id_3C60 = 1;
  self notify("done_changing_cover_pos");
  var_5 = _id_10F8A();
  self.pushable = 0;
  self _meth_82E4("stepout", var_3, %root, 1, 0.2, var_5);
  _id_465E(var_3);
  thread donotetrackswithendon("stepout");
  var_4 = animhasnotetrack(var_3, "start_aim");

  if(var_4) {
    self._id_10F8C = self.angles[1] + getangledelta(var_3, 0, 1);
    self waittillmatch("stepout", "start_aim");
  } else
    self waittillmatch("stepout", "end");

  if(var_1 == "B" && scripts\engine\utility::cointoss() && self._id_4664 == "right") {
    self.a._id_10930 = "corner_right_martyrdom";
  }

  _id_F2AF(var_0);
  var_6 = var_1 == "over" || scripts\engine\utility::actor_is3d();
  _id_10D6A(undefined, var_6, 0.3);
  thread scripts\anim\track::_id_11B07();

  if(var_4) {
    self waittillmatch("stepout", "end");
    self._id_10F8C = undefined;
  }

  _id_3C50(undefined, 1, 0.2);
  self clearanim(%cover, 0.1);
  self clearanim(%corner, 0.1);
  self._id_3C60 = 0;
  self._id_4740 = gettime();
  self.pushable = 1;
  return 1;
}

_id_10F8B() {
  self.keepclaimednodeifvalid = 1;

  if(isDefined(self._id_DC5C) && randomfloat(1) < self._id_DC5C) {
    if(_id_DC57()) {
      return 1;
    }
  }

  if(!_id_10F89()) {
    return 0;
  }

  shootastold();

  if(isDefined(self._id_FECF)) {
    var_0 = lengthsquared(self.origin - self._id_FECF);

    if(scripts\anim\utility_common::usingrocketlauncher() && scripts\anim\utility::_id_10000(var_0)) {
      if(self.a.pose == "stand") {
        scripts\anim\shared::_id_1180E(scripts\anim\utility::_id_B027("combat", "drop_rpg_stand"));
      } else {
        scripts\anim\shared::_id_1180E(scripts\anim\utility::_id_B027("combat", "drop_rpg_crouch"));
      }

      thread _id_E841();
      return;
    }
  }

  _id_E47A();
  self.keepclaimednodeifvalid = 0;
  return 1;
}

_id_8C4E(var_0) {
  if(!isDefined(self._id_A9D8)) {
    return 1;
  }

  return gettime() - self._id_A9D8 > var_0 * 1000;
}

_id_DC57() {
  if(!scripts\anim\utility::_id_8BED()) {
    return 0;
  }

  var_0 = 0;
  var_1 = 90;
  var_2 = self.covernode scripts\anim\utility_common::getyawtoorigin(scripts\anim\utility::_id_7E90());

  if(self._id_4664 == "right") {
    var_2 = 0 - var_2;
  }

  if(var_2 < -30) {
    var_1 = 45;

    if(self._id_4664 == "left") {
      var_0 = -45;
    } else {
      var_0 = 45;
    }
  }

  var_3 = "rambo" + var_1;

  if(!scripts\anim\utility::_id_1F65(var_3)) {
    return 0;
  }

  var_4 = scripts\anim\utility::_id_1F67(var_3);
  var_5 = _id_8095(48);

  if(!self maymovetopoint(var_5, !scripts\engine\utility::actor_is3d())) {
    return 0;
  }

  self._id_4740 = gettime();
  _id_F6B9();
  self.keepclaimednodeifvalid = 1;
  self._id_9F15 = 1;
  self.a._id_D892 = "rambo";
  self._id_3C60 = 1;
  thread scripts\anim\shared::_id_DC59(var_0);
  self _meth_82E4("rambo", var_4, %body, 1, 0, 1);
  _id_465E(var_4);
  scripts\anim\shared::donotetracks("rambo");
  self notify("rambo_aim_end");
  self._id_3C60 = 0;
  self.keepclaimednodeifvalid = 0;
  self._id_A9D8 = gettime();
  self._id_3C60 = 0;
  self._id_9F15 = undefined;
  return 1;
}

shootastold() {
  scripts\sp\gameskill::_id_54C4();

  for(;;) {
    for(;;) {
      if(isDefined(self._id_1006D)) {
        break;
      }

      if(!isDefined(self._id_FECF)) {
        self waittill("do_slow_things");
        waittillframeend;

        if(isDefined(self._id_FECF)) {
          continue;
        }
        break;
      }

      if(!self.bulletsinclip) {
        break;
      }

      if(shootposwrapper_func()) {
        if(!_id_3C5D()) {
          if(_id_7E03() == self.a._id_4667) {
            break;
          }

          _id_FEE2(0.2);
          continue;
        }

        if(shootposwrapper_func()) {
          break;
        }
      } else {
        _id_FEE0(1);
        self clearanim(%add_fire, 0.2);
      }
    }

    if(canreturntocover(self.a._id_4667 != "lean")) {
      break;
    }

    if(shootposwrapper_func() && _id_3C5D()) {
      continue;
    }
    _id_FEE2(0.2);
  }
}

_id_FEE2(var_0) {
  thread _id_C173(var_0);
  var_1 = gettime();
  _id_FEE0(0);
  self notify("stopNotifyStopShootingAfterTime");
  var_2 = (gettime() - var_1) / 1000;

  if(var_2 < var_0) {
    wait(var_0 - var_2);
  }
}

_id_C173(var_0) {
  self endon("killanimscript");
  self endon("stopNotifyStopShootingAfterTime");
  wait(var_0);
  self notify("stopShooting");
}

_id_FEE0(var_0) {
  self endon("return_to_cover");

  if(var_0) {
    thread _id_1E82();
  }

  thread scripts\anim\combat_utility::_id_1A3E();
  scripts\anim\combat_utility::_id_FEDF();
}

_id_1E82() {
  self endon("killanimscript");
  self notify("newAngleRangeCheck");
  self endon("newAngleRangeCheck");
  self endon("take_cover_at_corner");

  for(;;) {
    if(shootposwrapper_func()) {
      break;
    }

    wait 0.1;
  }

  self notify("stopShooting");
}

_id_10154() {
  self.enemy endon("death");
  self endon("enemy");
  self endon("stopshowstate");

  for(;;) {
    wait 0.05;
  }
}

canreturntocover(var_0) {
  var_1 = !scripts\engine\utility::actor_is3d();

  if(var_0) {
    var_2 = _id_8095();

    if(!self maymovetopoint(var_2, var_1)) {
      return 0;
    }

    return self maymovefrompointtopoint(var_2, self.covernode.origin, var_1);
  } else
    return self maymovetopoint(self.covernode.origin, var_1);
}

_id_E47A() {
  scripts\anim\combat_utility::_id_631A();
  var_0 = scripts\anim\utility_common::issuppressedwrapper();
  self notify("take_cover_at_corner");
  self._id_3C60 = 1;
  self notify("done_changing_cover_pos");
  var_1 = self.a._id_4667 + "_to_alert";
  var_2 = scripts\anim\utility::_id_1F67(var_1);
  _id_1105C(0.3);
  var_3 = 0;

  if(self.a._id_4667 != "lean" && var_0 && scripts\anim\utility::_id_1F65(var_1 + "_reload") && randomfloat(100) < 75) {
    var_2 = scripts\anim\utility::_id_1F67(var_1 + "_reload");
    var_3 = 1;
  }

  var_4 = _id_10F8A();

  if(scripts\engine\utility::actor_is3d()) {
    self clearanim(%exposed_modern, 0.2);
  } else {
    self clearanim(%body, 0.1);
  }

  self _meth_82EA("hide", var_2, 1, 0.1, var_4);
  _id_465E(var_2);
  scripts\anim\shared::donotetracks("hide");

  if(var_3) {
    scripts\anim\weaponlist::refillclip();
  }

  self._id_3C60 = 0;

  if(self._id_4664 == "up") {
    self.a._id_10930 = "cover_up";
  } else if(self._id_4664 == "left") {
    self.a._id_10930 = "cover_left";
  } else {
    self.a._id_10930 = "cover_right";
  }

  self.keepclaimednodeifvalid = 0;
  self clearanim(var_2, 0.2);
}

_id_2B99() {
  if(!scripts\anim\utility::_id_1F65("blind_fire")) {
    return 0;
  }

  _id_F6B9();
  self.keepclaimednodeifvalid = 1;
  var_0 = scripts\anim\utility::_id_1F67("blind_fire");
  self _meth_82E4("blindfire", var_0, %body, 1, 0, 1);
  _id_465E(var_0);
  scripts\anim\shared::donotetracks("blindfire");
  self.keepclaimednodeifvalid = 0;
  return 1;
}

_id_ACF4(var_0, var_1, var_2) {
  if(!isDefined(var_2)) {
    var_2 = (1, 1, 1);
  }

  for(var_3 = 0; var_3 < 100; var_3++) {
    wait 0.05;
  }
}

_id_128B0(var_0) {
  return _id_128AF(var_0, 1);
}

_id_128AF(var_0, var_1) {
  if(!self maymovetopoint(_id_8095())) {
    return 0;
  }

  if(isDefined(self.dontevershoot) || isDefined(var_0._id_5951)) {
    return 0;
  }

  var_2 = undefined;

  if(isDefined(self._id_DC5C) && randomfloat(1) < self._id_DC5C) {
    if(isDefined(self.a._id_2274["grenade_rambo"])) {
      var_2 = scripts\anim\utility::_id_1F64("grenade_rambo");
    }
  }

  if(!isDefined(var_2)) {
    if(isDefined(var_1) && var_1) {
      if(!isDefined(self.a._id_2274["grenade_safe"])) {
        return 0;
      }

      var_2 = scripts\anim\utility::_id_1F64("grenade_safe");
    } else {
      if(!isDefined(self.a._id_2274["grenade_exposed"])) {
        return 0;
      }

      var_2 = scripts\anim\utility::_id_1F64("grenade_exposed");
    }
  }

  _id_F6B9();
  self.keepclaimednodeifvalid = 1;
  var_3 = scripts\anim\combat_utility::_id_128A0(var_0, var_2);
  self.keepclaimednodeifvalid = 0;
  return var_3;
}

_id_D922() {}

_id_B01C(var_0) {
  if(!isDefined(self.a._id_2274["alert_to_look"])) {
    return 0;
  }

  _id_F6B9();
  self.keepclaimednodeifvalid = 1;

  if(!_id_C9FC()) {
    return 0;
  }

  scripts\anim\shared::_id_D4C2(scripts\anim\utility::_id_1F64("look_idle"), var_0, ::_id_3915);
  var_1 = undefined;

  if(scripts\anim\utility_common::issuppressedwrapper()) {
    var_1 = scripts\anim\utility::_id_1F64("look_to_alert_fast");
  } else {
    var_1 = scripts\anim\utility::_id_1F64("look_to_alert");
  }

  self _meth_82E4("looking_end", var_1, %body, 1, 0.1, 1.0);
  _id_465E(var_1);
  scripts\anim\shared::donotetracks("looking_end");
  _id_F6B9();
  self.keepclaimednodeifvalid = 0;
  return 1;
}

_id_9EDA() {
  var_0 = self.covernode.angles;

  if(scripts\engine\utility::actor_is3d()) {
    var_0 = scripts\anim\utility_common::gettruenodeangles(self.covernode);
  }

  var_1 = self getEye();
  var_2 = anglestoright(var_0);
  var_3 = anglestoup(var_0);

  if(self._id_4664 == "right") {
    var_1 = var_1 + var_2 * 30;
  } else if(self._id_4664 == "left") {
    var_1 = var_1 - var_2 * 30;
  } else {
    var_1 = var_1 + var_3 * 30;
  }

  var_4 = var_1 + anglesToForward(var_0) * 30;
  return sighttracepassed(var_1, var_4, 1, self);
}

_id_C9FC() {
  if(isDefined(self.covernode._id_ED6A)) {
    return 0;
  }

  if(isDefined(self._id_BFA3) && gettime() < self._id_BFA3) {
    return 0;
  }

  if(!_id_9EDA()) {
    self._id_BFA3 = gettime() + 3000;
    return 0;
  }

  var_0 = scripts\anim\utility::_id_1F64("alert_to_look");
  self _meth_82E3("looking_start", var_0, %body, 1, 0.2, 1);
  _id_465E(var_0);
  scripts\anim\shared::donotetracks("looking_start");
  return 1;
}

_id_3915() {
  return self maymovetopoint(self.covernode.origin, !scripts\engine\utility::actor_is3d());
}

_id_6B9B() {
  return 0;
}

_id_4668() {
  var_0 = scripts\anim\utility::_id_1F67("reload");
  self _meth_82E7("cornerReload", var_0, 1, 0.2);
  _id_465E(var_0);
  scripts\anim\shared::donotetracks("cornerReload");
  self notify("abort_reload");
  scripts\anim\weaponlist::refillclip();
  self _meth_82AE(scripts\anim\utility::_id_1F64("alert_idle"), 1, 0.2);
  self clearanim(var_0, 0.2);
  return 1;
}

_id_9ED6(var_0, var_1) {
  var_2 = !scripts\engine\utility::actor_is3d();

  if(var_1) {
    var_3 = _id_8095();

    if(!self maymovetopoint(var_3, var_2)) {
      return 0;
    }

    if(scripts\engine\utility::actor_is3d()) {
      return 1;
    }

    return self maymovefrompointtopoint(var_3, scripts\anim\utility::_id_7DC6(var_0), var_2);
  } else {
    if(scripts\engine\utility::actor_is3d()) {
      return 1;
    }

    return self maymovetopoint(scripts\anim\utility::_id_7DC6(var_0), var_2);
  }
}

_id_8095(var_0) {
  var_1 = self.covernode.angles;
  var_2 = anglestoright(var_1);

  if(!isDefined(var_0)) {
    var_0 = 36;
  }

  var_3 = self.script;

  switch (var_3) {
    case "cover_left":
      var_2 = var_2 * (0 - var_0);
      break;
    case "cover_right":
      var_2 = var_2 * var_0;
      break;
    default:
  }

  return self.covernode.origin + (var_2[0], var_2[1], 0);
}

_id_92CC() {
  self endon("end_idle");

  for(;;) {
    var_0 = randomint(2) == 0 && isDefined(self.a._id_2274["alert_idle_twitch"]) && scripts\anim\utility::_id_1F65("alert_idle_twitch");

    if(var_0) {
      var_1 = scripts\anim\utility::_id_1F67("alert_idle_twitch");
    } else {
      var_1 = scripts\anim\utility::_id_1F64("alert_idle");
    }

    _id_D49E(var_1, var_0);
  }
}

_id_6F27() {
  if(!scripts\anim\utility::_id_1F65("alert_idle_flinch")) {
    return 0;
  }

  _id_D49E(scripts\anim\utility::_id_1F67("alert_idle_flinch"), 1);
  return 1;
}

_id_D49E(var_0, var_1) {
  if(var_1) {
    self _meth_82E4("idle", var_0, %body, 1, 0.1, 1);
  } else {
    self _meth_82E3("idle", var_0, %body, 1, 0.1, 1);
  }

  _id_465E(var_0);
  scripts\anim\shared::donotetracks("idle");
}

_id_F2AE(var_0) {
  [[self._id_1F66["hiding"][var_0]]]();
  [[self._id_1F66["exposed"][var_0]]]();
}

_id_F2AF(var_0) {
  [[self._id_1F66["exposed"][var_0]]]();
}

transitiontostance(var_0) {
  if(self.a.pose == var_0) {
    _id_F2AE(var_0);
    return;
  }

  var_1 = scripts\anim\utility::_id_1F64("stance_change");
  self _meth_82E4("changeStance", var_1, %body);
  _id_465E(var_1);
  _id_F2AE(var_0);
  scripts\anim\shared::donotetracks("changeStance");
  wait 0.2;
}

_id_846D(var_0, var_1, var_2) {
  var_3 = scripts\anim\utility_common::getnodedirection();
  var_4 = scripts\anim\utility_common::_id_7E28();
  var_5 = var_3 + self._id_8EDF;

  if(scripts\engine\utility::actor_is3d()) {
    self notify("force_space_rotation_update", 0, 0);
  } else {
    self orientmode("face angle", var_5);
  }

  self animmode("normal");

  if(isDefined(var_4)) {
    thread scripts\anim\shared::_id_BD1D(var_4, var_1);
  }

  self _meth_82E4("coveranim", var_0, %body, 1, var_1);
  _id_465E(var_0);
  scripts\anim\notetracks::donotetracksfortime(var_2, "coveranim");

  while(scripts\engine\utility::absangleclamp180(self.angles[1] - var_5) > 1) {
    scripts\anim\notetracks::donotetracksfortime(0.1, "coveranim");
    var_3 = scripts\anim\utility_common::getnodedirection();
    var_5 = var_3 + self._id_8EDF;
  }

  _id_F6B9();

  if(self._id_4664 == "left") {
    self.a._id_10930 = "cover_left";
  } else if(self._id_4664 == "right") {
    self.a._id_10930 = "cover_right";
  } else {
    self.a._id_10930 = "cover_up";
  }
}

drawoffset() {
  self endon("killanimscript");

  for(;;) {
    wait 0.05;
  }
}

_id_F5AD() {
  if(!isDefined(self.a._id_2274)) {}

  var_0 = scripts\anim\utility::_id_B028("default_stand");
  self.a._id_2274["add_aim_up"] = var_0["add_aim_up"];
  self.a._id_2274["add_aim_down"] = var_0["add_aim_down"];
  self.a._id_2274["add_aim_left"] = var_0["add_aim_left"];
  self.a._id_2274["add_aim_right"] = var_0["add_aim_right"];
  self.a._id_2274["add_turn_aim_up"] = var_0["add_turn_aim_up"];
  self.a._id_2274["add_turn_aim_down"] = var_0["add_turn_aim_down"];
  self.a._id_2274["add_turn_aim_left"] = var_0["add_turn_aim_left"];
  self.a._id_2274["add_turn_aim_right"] = var_0["add_turn_aim_right"];
  self.a._id_2274["straight_level"] = var_0["straight_level"];

  if(self.a._id_4667 == "lean") {
    var_1 = self.a._id_2274["lean_fire"];
    var_2 = self.a._id_2274["lean_single"];
    self.a._id_2274["fire"] = var_1;
    self.a._id_2274["single"] = ::scripts\anim\utility::_id_2274(var_2);
    self.a._id_2274["semi2"] = var_2;
    self.a._id_2274["semi3"] = var_2;
    self.a._id_2274["semi4"] = var_2;
    self.a._id_2274["semi5"] = var_2;
    self.a._id_2274["burst2"] = var_1;
    self.a._id_2274["burst3"] = var_1;
    self.a._id_2274["burst4"] = var_1;
    self.a._id_2274["burst5"] = var_1;
    self.a._id_2274["burst6"] = var_1;
  } else {
    self.a._id_2274["fire"] = var_0["fire_corner"];
    self.a._id_2274["semi2"] = var_0["semi2"];
    self.a._id_2274["semi3"] = var_0["semi3"];
    self.a._id_2274["semi4"] = var_0["semi4"];
    self.a._id_2274["semi5"] = var_0["semi5"];

    if(scripts\anim\utility_common::weapon_pump_action_shotgun()) {
      self.a._id_2274["single"] = ::scripts\anim\utility::_id_B027("shotgun_stand", "single");
    } else {
      self.a._id_2274["single"] = var_0["single"];
    }

    self.a._id_2274["burst2"] = var_0["burst2"];
    self.a._id_2274["burst3"] = var_0["burst3"];
    self.a._id_2274["burst4"] = var_0["burst4"];
    self.a._id_2274["burst5"] = var_0["burst5"];
    self.a._id_2274["burst6"] = var_0["burst6"];
  }

  self.a._id_2274["exposed_idle"] = var_0["exposed_idle"];
}

_id_F317() {
  if(!isDefined(self.a._id_2274)) {}

  var_0 = scripts\anim\utility::_id_B028("default_crouch");
  var_1["add_aim_up"] = ::scripts\anim\utility::_id_B027("cover_crouch", "add_aim_up");
  var_2["add_aim_up"] = ::scripts\anim\utility::_id_B027("cover_crouch", "add_aim_up");
  var_3[0] = ::scripts\anim\utility::_id_B027("cover_crouch", "add_aim_up");

  if(self.a._id_4667 == "over") {
    self.a._id_2274["add_aim_up"] = ::scripts\anim\utility::_id_B027("cover_crouch", "add_aim_up");
    self.a._id_2274["add_aim_down"] = ::scripts\anim\utility::_id_B027("cover_crouch", "add_aim_down");
    self.a._id_2274["add_aim_left"] = ::scripts\anim\utility::_id_B027("cover_crouch", "add_aim_left");
    self.a._id_2274["add_aim_right"] = ::scripts\anim\utility::_id_B027("cover_crouch", "add_aim_right");
    self.a._id_2274["straight_level"] = ::scripts\anim\utility::_id_B027("cover_crouch", "straight_level");
    self.a._id_2274["exposed_idle"] = ::scripts\anim\utility::_id_B027("default_stand", "exposed_idle");
    return;
  }

  if(self.a._id_4667 == "lean") {
    var_4 = self.a._id_2274["lean_fire"];
    var_5 = self.a._id_2274["lean_single"];
    self.a._id_2274["fire"] = var_4;
    self.a._id_2274["single"] = ::scripts\anim\utility::_id_2274(var_5);
    self.a._id_2274["semi2"] = var_5;
    self.a._id_2274["semi3"] = var_5;
    self.a._id_2274["semi4"] = var_5;
    self.a._id_2274["semi5"] = var_5;
    self.a._id_2274["burst2"] = var_4;
    self.a._id_2274["burst3"] = var_4;
    self.a._id_2274["burst4"] = var_4;
    self.a._id_2274["burst5"] = var_4;
    self.a._id_2274["burst6"] = var_4;
  } else {
    self.a._id_2274["fire"] = var_0["fire"];
    self.a._id_2274["semi2"] = var_0["semi2"];
    self.a._id_2274["semi3"] = var_0["semi3"];
    self.a._id_2274["semi4"] = var_0["semi4"];
    self.a._id_2274["semi5"] = var_0["semi5"];

    if(scripts\anim\utility_common::weapon_pump_action_shotgun()) {
      self.a._id_2274["single"] = ::scripts\anim\utility::_id_B027("shotgun_crouch", "single");
    } else {
      self.a._id_2274["single"] = var_0["single"];
    }

    self.a._id_2274["burst2"] = var_0["burst2"];
    self.a._id_2274["burst3"] = var_0["burst3"];
    self.a._id_2274["burst4"] = var_0["burst4"];
    self.a._id_2274["burst5"] = var_0["burst5"];
    self.a._id_2274["burst6"] = var_0["burst6"];
  }

  self.a._id_2274["add_aim_up"] = var_0["add_aim_up"];
  self.a._id_2274["add_aim_down"] = var_0["add_aim_down"];
  self.a._id_2274["add_aim_left"] = var_0["add_aim_left"];
  self.a._id_2274["add_aim_right"] = var_0["add_aim_right"];
  self.a._id_2274["add_turn_aim_up"] = var_0["add_turn_aim_up"];
  self.a._id_2274["add_turn_aim_down"] = var_0["add_turn_aim_down"];
  self.a._id_2274["add_turn_aim_left"] = var_0["add_turn_aim_left"];
  self.a._id_2274["add_turn_aim_right"] = var_0["add_turn_aim_right"];
  self.a._id_2274["straight_level"] = var_0["straight_level"];
  self.a._id_2274["exposed_idle"] = var_0["exposed_idle"];
}

_id_E841() {
  self notify("killanimscript");
  thread scripts\anim\combat::main();
}

_id_F6B9() {
  if(scripts\engine\utility::actor_is3d()) {
    self animmode("nogravity");
  } else {
    self animmode("zonly_physics");
  }
}

_id_465E(var_0) {
  if(self._id_4664 == "left") {
    var_1 = "corner_stand_L";
  } else {
    var_1 = "corner_stand_R";
  }

  self.facialidx = scripts\anim\face::playfacialanim(var_0, var_1, self.facialidx);
}

_id_465D(var_0) {
  self.facialidx = scripts\anim\face::playfacialanim(var_0, "aim", self.facialidx);
}

_id_465B() {
  self.facialidx = undefined;
  self clearanim(%head, 0.2);
}