/********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\agents\dog\_dog_idle.gsc
********************************************/

main() {
  self.animsubstate = "none";
  settimeofnextsound();
  self.timeofnextsound = self.timeofnextsound + 2000;
  self.bidlehitreaction = 0;
  self scragentsetgoalpos(self.origin);
  self scragentsetorientmode("face angle abs", self.angles);
  self scragentsetanimmode("anim deltas");
  self scragentsetphysicsmode("gravity");
  updatestate();
}

end_script() {
  if(isDefined(self.prevturnrate)) {
    self scragentsetmaxturnspeed(self.prevturnrate);
    self.prevturnrate = undefined;
  }
}

updatestate() {
  self endon("killanimscript");
  self endon("cancelidleloop");

  for(;;) {
    var_0 = self.animsubstate;
    var_1 = determinestate();

    if(var_1 != self.animsubstate) {
      enterstate(var_1);
    }

    updateangle();

    switch (self.animsubstate) {
      case "idle_combat":
        wait 0.2;
        break;
      case "idle_noncombat":
        if(var_0 == "none") {} else if(gettime() > self.timeofnextsound) {
          settimeofnextsound();
        }

        wait 0.5;
        break;
      default:
        wait 1;
        break;
    }
  }
}

determinestate() {
  if(shouldattackidle()) {
    return "idle_combat";
  } else {
    return "idle_noncombat";
  }
}

enterstate(var_0) {
  exitstate(self.animsubstate);
  self.animsubstate = var_0;
  playidleanim();
}

exitstate(var_0) {
  if(isDefined(self.prevturnrate)) {
    self scragentsetmaxturnspeed(self.prevturnrate);
    self.prevturnrate = undefined;
  }
}

playidleanim() {
  if(self.animsubstate == "idle_combat") {
    self setanimstate("attack_idle");
  } else {
    self setanimstate("casual_idle");
  }
}

updateangle() {
  var_0 = undefined;

  if(isDefined(self.enemy) && distancesquared(self.enemy.origin, self.origin) < 1048576) {
    var_0 = self.enemy;
  } else if(isDefined(self.owner) && distancesquared(self.owner.origin, self.origin) > 576) {
    var_0 = self.owner;
  }

  if(isDefined(var_0)) {
    var_1 = var_0.origin - self.origin;
    var_2 = vectortoangles(var_1);

    if(abs(angleclamp180(var_2[1] - self.angles[1])) > 1) {
      turntoangle(var_2[1]);
    }
  }
}

shouldattackidle() {
  return isDefined(self.enemy) && maps\mp\_utility::isreallyalive(self.enemy) && distancesquared(self.origin, self.enemy.origin) < 1000000;
}

getturnanimstate(var_0) {
  if(shouldattackidle()) {
    if(var_0 < -135 || var_0 > 135) {
      return "attack_turn_180";
    } else if(var_0 < 0) {
      return "attack_turn_right_90";
    } else {
      return "attack_turn_left_90";
    }
  } else if(var_0 < -135 || var_0 > 135) {
    return "casual_turn_180";
  } else if(var_0 < 0) {
    return "casual_turn_right_90";
  } else {
    return "casual_turn_left_90";
  }
}

turntoangle(var_0) {
  var_1 = self.angles[1];
  var_2 = angleclamp180(var_0 - var_1);

  if(-0.5 < var_2 && var_2 < 0.5) {
    return;
  }
  if(-10 < var_2 && var_2 < 10) {
    rotatetoangle(var_0, 2);
    return;
  }

  var_3 = getturnanimstate(var_2);
  var_4 = self getanimentry(var_3, 0);
  var_5 = getanimlength(var_4);
  var_6 = getangledelta3d(var_4);
  self scragentsetanimmode("anim angle delta");

  if(animhasnotetrack(var_4, "turn_begin") && animhasnotetrack(var_4, "turn_end")) {
    maps\mp\agents\_scriptedagents::playanimnuntilnotetrack(var_3, 0, "turn_in_place");
    var_7 = getnotetracktimes(var_4, "turn_begin");
    var_8 = getnotetracktimes(var_4, "turn_end");
    var_9 = (var_8[0] - var_7[0]) * var_5;
    var_10 = angleclamp180(var_2 - var_6[1]);
    var_11 = abs(var_10) / var_9 / 20;
    var_11 = var_11 * 3.14159 / 180;
    var_12 = (0, angleclamp180(self.angles[1] + var_10), 0);
    self.prevturnrate = self scragentgetmaxturnspeed();
    self scragentsetmaxturnspeed(var_11);
    self scragentsetorientmode("face angle abs", var_12);
    maps\mp\agents\_scriptedagents::waituntilnotetrack("turn_in_place", "turn_end");
    self scragentsetmaxturnspeed(self.prevturnrate);
    self.prevturnrate = undefined;
    maps\mp\agents\_scriptedagents::waituntilnotetrack("turn_in_place", "end");
  } else {
    self.prevturnrate = self scragentgetmaxturnspeed();
    var_11 = abs(angleclamp180(var_2 - var_6[1])) / var_5 / 20;
    var_11 = var_11 * 3.14159 / 180;
    self scragentsetmaxturnspeed(var_11);
    var_12 = (0, angleclamp180(var_0 - var_6[1]), 0);
    self scragentsetorientmode("face angle abs", var_12);
    maps\mp\agents\_scriptedagents::playanimnuntilnotetrack(var_3, 0, "turn_in_place");
    self scragentsetmaxturnspeed(self.prevturnrate);
    self.prevturnrate = undefined;
  }

  self scragentsetanimmode("anim deltas");
  playidleanim();
}

rotatetoangle(var_0, var_1) {
  if(abs(angleclamp180(var_0 - self.angles[1])) <= var_1) {
    return;
  }
  var_2 = (0, var_0, 0);
  self scragentsetorientmode("face angle abs", var_2);

  while(angleclamp180(var_0 - self.angles[1]) > var_1) {
    wait 0.1;
  }
}

settimeofnextsound() {
  self.timeofnextsound = gettime() + 8000 + randomint(5000);
}

dohitreaction(var_0) {
  self.blockgoalpos = 1;
  self.statelocked = 1;
  self.bidlehitreaction = 1;
  var_1 = angleclamp180(var_0 - self.angles[1]);

  if(var_1 > 0) {
    var_2 = 1;
  } else {
    var_2 = 0;
  }

  self notify("cancelidleloop");
  self scragentsetanimmode("anim deltas");
  self scragentsetorientmode("face angle abs", self.angles);
  maps\mp\agents\_scriptedagents::playanimnuntilnotetrack("stand_pain", var_2, "stand_pain");
  self.blockgoalpos = 0;
  self.statelocked = 0;
  self.bidlehitreaction = 0;
  self scragentsetorientmode("face angle abs", self.angles);
  self.animsubstate = "none";
  thread updatestate();
}

ondamage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(self.bidlehitreaction) {
    return;
  }
  var_10 = vectortoangles(var_7);
  var_11 = var_10[1] - 180;
  dohitreaction(var_11);
}

onflashbanged(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(self.bidlehitreaction) {
    return;
  }
  dohitreaction(self.angles[1] + 180);
}