/****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\dog\dog_move.gsc
****************************************/

#using_animtree("dog");

main() {
  self endon("killanimscript");
  self clearanim(%root, 0.2);
  self clearanim(%german_shepherd_run_stop, 0);

  if(!isDefined(self._id_3B58) && !isDefined(self._id_3B0C) && self.a._id_0D2B == "run" && (!isDefined(self._id_1199) || self._id_1199 == 0)) {
    _id_3B61();
  }
  thread _id_3B64();
  self._id_3B58 = undefined;
  self._id_3B0C = undefined;

  if(self.a._id_0D2B == "run") {
    var_0 = undefined;
    var_0 = _id_3B65();
    self setanimrestart(%german_shepherd_run, var_0["center"], 0.2, 1);
    self setanimrestart(%german_shepherd_run_lean_l, var_0["left"], 0.1, 1);
    self setanimrestart(%german_shepherd_run_lean_r, var_0["right"], 0.1, 1);
    self setflaggedanimknob("dog_run", %german_shepherd_run_knob, 1, 0.2, self._id_0FC6);
    animscripts\notetracks::_id_0D4F(0.1, "dog_run");
  } else {
    self setflaggedanimrestart("dog_walk", %german_shepherd_walk, 1, 0.2, self._id_0FC6);
  }
  thread animscripts\dog\dog_stop::_id_3B01("normal");

  for(;;) {
    _id_3B59();

    if(self.a._id_0D2B == "run") {
      if(self._id_117F == 0) {
        thread _id_3B62();
      }
      self waittill("run");
      self clearanim(%german_shepherd_run_stop, 0.1);
    }
  }
}

_id_3B59() {
  self endon("killanimscript");
  self endon("stop_soon");
  self._id_10B7 = undefined;

  for(;;) {
    if(self._id_117F) {
      self.stopanimdistsq = 0;
    } else {
      self.stopanimdistsq = anim._id_3AEE;
    }
    if(isDefined(self._id_10B7)) {
      self[[self._id_10B7]]();
      self._id_10B7 = undefined;
    }

    if(isDefined(self._id_10AB)) {
      self[[self._id_10AB]]();
      continue;
    }

    _id_3B5A();
  }
}

_id_3B5A() {
  self endon("move_loop_restart");

  if(self.a._id_0D2B == "run") {
    var_0 = _id_3B65();
    self clearanim(%german_shepherd_walk, 0.3);
    self setanim(%german_shepherd_run, var_0["center"], 0.2, 1);
    self setanim(%german_shepherd_run_lean_l, var_0["left"], 0.1, 1);
    self setanim(%german_shepherd_run_lean_r, var_0["right"], 0.1, 1);
    self setflaggedanimknob("dog_run", %german_shepherd_run_knob, 1, 0.2, self._id_0FC6);
    animscripts\notetracks::_id_0D4F(0.2, "dog_run");
  } else {
    self clearanim(%german_shepherd_run_knob, 0.3);
    self setflaggedanim("dog_walk", %german_shepherd_walk, 1, 0.2, self._id_0FC6);
    animscripts\notetracks::_id_0D4F(0.2, "dog_walk");
  }
}

_id_1090() {
  self endon("killanimscript");
  self._id_10A8 = undefined;

  for(;;) {
    self waittill("path_changed", var_0, var_1);

    if(isDefined(self._id_10A8) || isDefined(self._id_10BF)) {
      continue;
    }
    if(self.a._id_0D2B != "run") {
      continue;
    }
    var_2 = angleclamp180(self.angles[1] - vectortoyaw(var_1));
    var_3 = _id_3B5C(var_2);

    if(isDefined(var_3)) {
      self._id_10C0 = var_3;
      self._id_10C1 = gettime();
      self._id_10AB = ::_id_3B5D;
      self notify("move_loop_restart");
    }
  }
}

_id_3B5B() {
  self endon("killanimscript");
  self._id_10A8 = undefined;

  for(;;) {
    if(self.lookaheaddist > 40 && !isDefined(self._id_10AB) && !isDefined(self._id_10A8) && !isDefined(self._id_10BF) && self.a._id_0D2B == "run") {
      var_0 = vectortoyaw(self.lookaheaddir);
      var_1 = angleclamp180(self.angles[1] - var_0);
      var_2 = _id_3B5C(var_1);

      if(isDefined(var_2)) {
        self._id_10C0 = var_2;
        self._id_10C1 = gettime();
        self._id_10AB = ::_id_3B5D;
        self notify("move_loop_restart");
      }
    }

    wait 0.05;
  }
}

_id_3B5C(var_0) {
  var_1 = undefined;

  if(var_0 < -135) {
    var_1 = % german_shepherd_run_start_180_l;
  } else if(var_0 > 135) {
    var_1 = % german_shepherd_run_start_180_r;
  } else if(var_0 < -60) {
    var_1 = % german_shepherd_run_start_l;
  } else if(var_0 > 60) {
    var_1 = % german_shepherd_run_start_r;
  }
  return var_1;
}

_id_3B5D() {
  self endon("killanimscript");
  self._id_10AB = undefined;
  var_0 = self._id_10C0;

  if(gettime() > self._id_10C1 + 50) {
    return;
  }
  self animmode("zonly_physics", 0);
  self clearanim(%root, 0.2);
  self._id_10B7 = ::_id_3B5E;
  self._id_10A8 = 1;
  self setflaggedanimrestart("turnAnim", var_0, 1, 0.2, self._id_0FC6);
  self orientmode("face current");
  var_1 = getanimlength(var_0) * self._id_0FC6;
  animscripts\notetracks::_id_0D4F(var_1 * 0.2, "turnAnim");
  self orientmode("face motion");
  self animmode("none", 0);
  var_2 = self.turnrate;
  self.turnrate = 0.4;
  animscripts\notetracks::_id_0D4F(var_1 * 0.65, "turnAnim");
  self.turnrate = var_2;
  self._id_10A8 = undefined;
}

_id_3B5E() {
  self._id_10A8 = undefined;
  self orientmode("face default");
  self clearanim(%root, 0.2);
  self animmode("none", 0);
}

_id_3B5F() {
  self endon("killanimscript");

  for(var_0 = 0; var_0 < 2; var_0++) {
    var_1 = vectortoangles(self.lookaheaddir);
    self orientmode("face angle", var_1);
  }
}

_id_3B60() {
  self endon("move_loop_restart");

  if(self.lookaheaddist == 0) {
    thread _id_3B5B();
  } else {
    var_0 = self.origin;
    var_1 = anim._id_3AF5 * 0.6;
    var_0 = var_0 + self.lookaheaddir * var_1;
    var_2 = distancesquared(self.origin, self.pathgoalpos) < var_1 * var_1;
    var_3 = vectortoangles(self.lookaheaddir);

    if(!var_2 && self maymovetopoint(var_0)) {
      var_4 = angleclamp180(var_3[1] - self.angles[1]);

      if(var_4 >= 0) {
        if(var_4 < 45) {
          var_5 = 8;
        } else if(var_4 < 135) {
          var_5 = 6;
        } else {
          var_5 = 3;
        }
      } else if(var_4 > -45) {
        var_5 = 8;
      } else if(var_4 > -135) {
        var_5 = 4;
      } else {
        var_5 = 1;
      }
      self setanimrestart(anim._id_3AF8[var_5], 1, 0.2, 1);
      var_6 = self.angles[1] + anim._id_3AF7[var_5];
      var_7 = angleclamp180(var_3[1] - var_6);
      self orientmode("face angle", self.angles[1] + var_7);
      self animmode("zonly_physics", 0);
      var_8 = getanimlength(anim._id_3AF8[var_5]) * self._id_0FC6;
      animscripts\notetracks::_id_0D4F(var_8 * 0.6, "turnAnim");
      self orientmode("face motion");
      self animmode("none", 0);
      thread _id_3B5B();
      animscripts\notetracks::_id_0D4F(var_8 * 0.25, "turnAnim");
      return;
    }

    self orientmode("face angle", var_3[1]);
    self animmode("none");
    self._id_3AFC = self.turnrate;
    self.turnrate = 0.5;
    var_9 = angleclamp180(var_3[1] - self.angles[1]);

    if(abs(var_9) > 20) {
      if(var_9 > 0) {
        var_10 = % german_shepherd_rotate_ccw;
      } else {
        var_10 = % german_shepherd_rotate_cw;
      }
      self setflaggedanimrestart("dog_turn", var_10, 1, 0.2, 1.0);
      animscripts\shared::_id_0C51("dog_turn");
      self clearanim(%german_shepherd_rotate_cw, 0.2);
      self clearanim(%german_shepherd_rotate_ccw, 0.2);
    }

    thread _id_3B5B();
    self.turnrate = self._id_3AFC;
    self._id_3AFC = undefined;
    self orientmode("face motion");
  }
}

_id_3B61() {
  if(isDefined(self.pathgoalpos)) {
    if(isDefined(self.pathgoalpos)) {
      _id_3B60();
      self clearanim(%root, 0.2);
      return;
    }
  }

  self orientmode("face default");
  self setflaggedanimknobrestart("dog_prerun", %german_shepherd_run_start, 1, 0.2, self._id_0FC6);
  animscripts\shared::_id_0C51("dog_prerun");
  self animmode("none", 0);
  self clearanim(%root, 0.2);
}

_id_3B62() {
  self endon("killanimscript");
  self endon("run");
  self clearanim(%german_shepherd_run_knob, 0.1);
  self setflaggedanimrestart("stop_anim", %german_shepherd_run_stop, 1, 0.2, 1);
  animscripts\shared::_id_0C51("stop_anim");
}

_id_3B63(var_0, var_1) {
  maps\_utility::_id_23D9(var_0, "tag_eye");

  if(isalive(self)) {
    self notify(var_1);
  }
}

_id_3B64() {
  self endon("killanimscript");
  wait 0.2;

  for(;;) {
    var_0 = undefined;

    if(isDefined(self._id_23DB)) {
      var_0 = "anml_dog_growl";
    } else if(!isDefined(self._id_206F)) {
      var_0 = "anml_dog_bark";
    }
    if(!isDefined(var_0)) {
      break;
    }

    thread _id_3B63(var_0, "randomRunSound");
    self waittill("randomRunSound");
    wait(randomfloatrange(0.1, 0.3));
  }
}

_id_3B65() {
  var_0 = [];
  var_0["center"] = 0;
  var_0["left"] = 0;
  var_0["right"] = 0;

  if(self.leanamount > 0) {
    if(self.leanamount < 0.95) {
      self.leanamount = 0.95;
    }
    var_0["left"] = 0;
    var_0["right"] = (1 - self.leanamount) * 20;

    if(var_0["right"] > 1) {
      var_0["right"] = 1;
    } else if(var_0["right"] < 0) {
      var_0["right"] = 0;
    }
    var_0["center"] = 1 - var_0["right"];
  } else if(self.leanamount < 0) {
    if(self.leanamount > -0.95) {
      self.leanamount = -0.95;
    }
    var_0["right"] = 0;
    var_0["left"] = (1 + self.leanamount) * 20;

    if(var_0["left"] > 1) {
      var_0["left"] = 1;
    }
    if(var_0["left"] < 0) {
      var_0["left"] = 0;
    }
    var_0["center"] = 1 - var_0["left"];
  } else {
    var_0["left"] = 0;
    var_0["right"] = 0;
    var_0["center"] = 1;
  }

  return var_0;
}