/****************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: animscripts\dog\dog_stop.gsc
****************************************/

#using_animtree("dog");

main() {
  self endon("killanimscript");
  self clearanim( % root, 0.1);
  self clearanim( % german_shepherd_idle, 0.2);
  self clearanim( % german_shepherd_attackidle_knob, 0.2);
  thread lookattarget("attackIdle");

  for (;;) {
    if(shouldattackidle()) {
      self clearanim( % german_shepherd_idle, 0.2);
      randomattackidle();
    } else {
      self orientmode("face current");
      self clearanim( % german_shepherd_attackidle_knob, 0.2);
      self setflaggedanimrestart("dog_idle", % german_shepherd_idle, 1, 0.2, self.animplaybackrate);
    }

    animscripts\shared::donotetracks("dog_idle");

    if(isdefined(self.prevturnrate)) {
      self.turnrate = self.prevturnrate;
      self.prevturnrate = undefined;
    }
  }
}

isfacingenemy(var_0) {
  var_1 = self.enemy.origin - self.origin;
  var_2 = length(var_1);

  if(var_2 < 1)
    return 1;

  var_3 = anglestoforward(self.angles);
  return (var_3[0] * var_1[0] + var_3[1] * var_1[1]) / var_2 > var_0;
}

randomattackidle() {
  self clearanim( % german_shepherd_attackidle_knob, 0.1);

  if(isfacingenemy(0.866))
    self orientmode("face angle", self.angles[1]);
  else {
    if(isdefined(self.enemy)) {
      var_0 = vectortoyaw(self.enemy.origin - self.origin);
      var_1 = angleclamp180(var_0 - self.angles[1]);

      if(abs(var_1) > 10) {
        self orientmode("face enemy");
        self.prevturnrate = self.turnrate;
        self.turnrate = 0.3;

        if(var_1 > 0)
          var_2 = % german_shepherd_rotate_ccw;
        else
          var_2 = % german_shepherd_rotate_cw;

        self setflaggedanimrestart("dog_turn", var_2, 1, 0.2, 1.0);
        animscripts\shared::donotetracks("dog_turn");
        self.turnrate = self.prevturnrate;
        self.prevturnrate = undefined;
        self clearanim( % german_shepherd_rotate_cw, 0.2);
        self clearanim( % german_shepherd_rotate_ccw, 0.2);
      }
    }

    self orientmode("face angle", self.angles[1]);
  }

  if(should_growl())
    self setflaggedanimrestart("dog_idle", % german_shepherd_attackidle_growl, 1, 0.2, 1);
  else {
    var_3 = 33;
    var_4 = 66;

    if(isdefined(self.mode)) {
      if(self.mode == "growl") {
        var_3 = 15;
        var_4 = 30;
      } else if(self.mode == "bark") {
        var_3 = 15;
        var_4 = 85;
      }
    }

    var_5 = randomint(100);

    if(var_5 < var_3)
      self setflaggedanimrestart("dog_idle", % german_shepherd_attackidle_b, 1, 0.2, self.animplaybackrate);
    else {
      if(var_5 < var_4) {
        self setflaggedanimrestart("dog_idle", % german_shepherd_attackidle_bark, 1, 0.2, self.animplaybackrate);
        return;
      }

      self setflaggedanimrestart("dog_idle", % german_shepherd_attackidle_growl, 1, 0.2, self.animplaybackrate);
    }
  }
}

shouldattackidle() {
  return isdefined(self.enemy) && isalive(self.enemy) && distancesquared(self.origin, self.enemy.origin) < 1000000;
}

should_growl() {
  if(isdefined(self.script_growl))
    return 1;

  if(!isalive(self.enemy))
    return 1;

  return !self cansee(self.enemy);
}

lookattarget(var_0) {
  self endon("killanimscript");
  self endon("stop tracking");
  self clearanim( % german_shepherd_look_2, 0);
  self clearanim( % german_shepherd_look_4, 0);
  self clearanim( % german_shepherd_look_6, 0);
  self clearanim( % german_shepherd_look_8, 0);
  self setdefaultaimlimits();
  self.rightaimlimit = 90;
  self.leftaimlimit = -90;
  self setanimlimited(anim.doglookpose[var_0][2], 1, 0);
  self setanimlimited(anim.doglookpose[var_0][4], 1, 0);
  self setanimlimited(anim.doglookpose[var_0][6], 1, 0);
  self setanimlimited(anim.doglookpose[var_0][8], 1, 0);
  animscripts\track::setanimaimweight(1, 0.2);
  animscripts\track::trackloop( % german_shepherd_look_2, % german_shepherd_look_4, % german_shepherd_look_6, % german_shepherd_look_8);
}