/****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\dog\dog_stop.gsc
****************************************/

#using_animtree("dog");

main() {
  self endon("killanimscript");
  self clearanim(%root, 0.1);
  self clearanim(%german_shepherd_idle, 0.2);
  self clearanim(%german_shepherd_attackidle_knob, 0.2);
  thread _id_3B01("attackIdle");

  for(;;) {
    if(_id_3AFF()) {
      self clearanim(%german_shepherd_idle, 0.2);
      _id_3AFE();
    } else {
      self orientmode("face current");
      self clearanim(%german_shepherd_attackidle_knob, 0.2);
      self setflaggedanimrestart("dog_idle", %german_shepherd_idle, 1, 0.2, self._id_10F7);
    }

    animscripts\shared::_id_0C51("dog_idle");

    if(isDefined(self._id_3AFC)) {
      self.turnrate = self._id_3AFC;
      self._id_3AFC = undefined;
    }
  }
}

_id_3AFD(var_0) {
  var_1 = self.enemy.origin - self.origin;
  var_2 = length(var_1);

  if(var_2 < 1) {
    return 1;
  }
  var_3 = anglesToForward(self.angles);
  return (var_3[0] * var_1[0] + var_3[1] * var_1[1]) / var_2 > var_0;
}

_id_3AFE() {
  self clearanim(%german_shepherd_attackidle_knob, 0.1);

  if(_id_3AFD(0.866)) {
    self orientmode("face angle", self.angles[1]);
  } else {
    if(isDefined(self.enemy)) {
      var_0 = vectortoyaw(self.enemy.origin - self.origin);
      var_1 = angleclamp180(var_0 - self.angles[1]);

      if(abs(var_1) > 10) {
        self orientmode("face enemy");
        self._id_3AFC = self.turnrate;
        self.turnrate = 0.3;

        if(var_1 > 0) {
          var_2 = % german_shepherd_rotate_ccw;
        } else {
          var_2 = % german_shepherd_rotate_cw;
        }
        self setflaggedanimrestart("dog_turn", var_2, 1, 0.2, 1.0);
        animscripts\shared::_id_0C51("dog_turn");
        self.turnrate = self._id_3AFC;
        self._id_3AFC = undefined;
        self clearanim(%german_shepherd_rotate_cw, 0.2);
        self clearanim(%german_shepherd_rotate_ccw, 0.2);
      }
    }

    self orientmode("face angle", self.angles[1]);
  }

  if(_id_3B00()) {
    self setflaggedanimrestart("dog_idle", %german_shepherd_attackidle_growl, 1, 0.2, 1);
  } else {
    var_3 = 33;
    var_4 = 66;

    if(isDefined(self.mode)) {
      if(self.mode == "growl") {
        var_3 = 15;
        var_4 = 30;
      } else if(self.mode == "bark") {
        var_3 = 15;
        var_4 = 85;
      }
    }

    var_5 = randomint(100);

    if(var_5 < var_3) {
      self setflaggedanimrestart("dog_idle", %german_shepherd_attackidle_b, 1, 0.2, self._id_10F7);
    } else {
      if(var_5 < var_4) {
        self setflaggedanimrestart("dog_idle", %german_shepherd_attackidle_bark, 1, 0.2, self._id_10F7);
        return;
      }

      self setflaggedanimrestart("dog_idle", %german_shepherd_attackidle_growl, 1, 0.2, self._id_10F7);
    }
  }
}

_id_3AFF() {
  return isDefined(self.enemy) && isalive(self.enemy) && distancesquared(self.origin, self.enemy.origin) < 1000000;
}

_id_3B00() {
  if(isDefined(self._id_23DB)) {
    return 1;
  }
  if(!isalive(self.enemy)) {
    return 1;
  }
  return !self cansee(self.enemy);
}

_id_3B01(var_0) {
  self endon("killanimscript");
  self endon("stop tracking");
  self clearanim(%german_shepherd_look_2, 0);
  self clearanim(%german_shepherd_look_4, 0);
  self clearanim(%german_shepherd_look_6, 0);
  self clearanim(%german_shepherd_look_8, 0);
  self setdefaultaimlimits();
  self.rightaimlimit = 90;
  self.leftaimlimit = -90;
  self setanimlimited(anim._id_3AF9[var_0][2], 1, 0);
  self setanimlimited(anim._id_3AF9[var_0][4], 1, 0);
  self setanimlimited(anim._id_3AF9[var_0][6], 1, 0);
  self setanimlimited(anim._id_3AF9[var_0][8], 1, 0);
  animscripts\track::_id_0CC4(1, 0.2);
  animscripts\track::_id_0CAA(%german_shepherd_look_2, %german_shepherd_look_4, %german_shepherd_look_6, %german_shepherd_look_8);
}