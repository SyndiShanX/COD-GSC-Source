/**************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\agents\humanoid\_humanoid_idle.gsc
**************************************************************/

main() {
  self._id_0EEA = "none";
  self scragentsetgoalpos(self.origin);
  self scragentsetorientmode("face angle abs", self.angles);
  self scragentsetanimmode("anim deltas");
  self scragentsetphysicsmode("gravity");
  updatestate();
}

_id_0085() {
  if(isDefined(self.prevturnrate)) {
    self scragentsetmaxturnspeed(self.prevturnrate);
    self.prevturnrate = undefined;
  }
}

updatestate() {
  self endon("killanimscript");
  self endon("UpdateState");
  wait 0;

  for(;;) {
    var_0 = determinestate();

    if(var_0 != self._id_0EEA) {
      exitstate(self._id_0EEA);
      enterstate(var_0);
    }

    updateangle();

    switch (self._id_0EEA) {
      case "idle_combat":
        wait 0.2;
        break;
      case "idle_noncombat":
        wait 0.5;
        break;
      default:
        wait 1;
        break;
    }
  }
}

determinestate() {
  if(isDefined(self.idlestateoverridefunc)) {
    return [[self.idlestateoverridefunc]]();
  } else if(shouldattackidle()) {
    return "idle_combat";
  } else {
    return "idle_noncombat";
  }
}

enterstate(var_0) {
  self._id_0EEA = var_0;
  playidleanim();
}

exitstate(var_0) {
  if(isDefined(self.prevturnrate)) {
    self scragentsetmaxturnspeed(self.prevturnrate);
    self.prevturnrate = undefined;
  }
}

playidleanim() {
  maps\mp\agents\_scripted_agent_anim_util::_id_8410(self._id_0EEA);
}

updateangle() {
  var_0 = undefined;

  if(isDefined(self.targetofinterest) && distancesquared(self.targetofinterest.origin, self.origin) < 262144) {
    var_0 = self.targetofinterest;
  } else if(isDefined(self.distractiondrone) && distancesquared(self.distractiondrone.groundpos, self.origin) < 16384) {
    var_0 = self.distractiondrone;
  } else if(isDefined(self._id_0088) && distancesquared(self._id_0088.origin, self.origin) < 1048576) {
    var_0 = self._id_0088;
  } else if(isDefined(self._id_0117) && distancesquared(self._id_0117.origin, self.origin) > 576) {
    var_0 = self._id_0117;
  }

  if(isDefined(var_0)) {
    var_1 = var_0.origin - self.origin;
    var_2 = vectortoangles(var_1);

    if(_abs(_angleclamp180(var_2[1] - self.angles[1])) > 1) {
      turntoangle(var_2[1]);
    }
  }
}

shouldattackidle() {
  if(!isDefined(self._id_0088)) {
    return 0;
  }

  if(!maps\mp\_utility::isreallyalive(self._id_0088)) {
    return 0;
  }

  if(distancesquared(self.origin, self._id_0088.origin) >= 1000000) {
    return 0;
  }

  return 1;
}

getturnanimstate(var_0) {
  var_1 = "idle_noncombat_turn";

  if(shouldattackidle()) {
    var_1 = "idle_combat_turn";
  }

  var_2 = maps\mp\agents\_scripted_agent_anim_util::_id_434D(var_1);
  var_3 = self getanimentrycount(var_2);
  var_4 = 0;

  if(var_3 == 3) {
    if(var_0 < -135 || var_0 > 135) {
      var_4 = 0;
    } else if(var_0 < 0) {
      var_4 = 1;
    } else {
      var_4 = 2;
    }
  }

  return [var_2, var_4];
}

turntoangle(var_0) {
  var_1 = self.angles[1];
  var_2 = _angleclamp180(var_0 - var_1);

  if(-0.5 < var_2 && var_2 < 0.5) {
    return;
  }
  if(-10 < var_2 && var_2 < 10) {
    rotatetoangle(var_0, 2);
    return;
  }

  var_3 = getturnanimstate(var_2);
  var_4 = var_3[0];
  var_5 = var_3[1];
  var_6 = self getanimentry(var_4, var_5);
  var_7 = _getanimlength(var_6);
  var_8 = _getangledelta3d(var_6);
  self scragentsetanimmode("anim angle delta");

  if(_animhasnotetrack(var_6, "turn_begin") && _animhasnotetrack(var_6, "turn_end")) {
    maps\mp\agents\_scripted_agent_anim_util::playanimnatrateuntilnotetrack_safe(var_4, var_5, self.generalspeedratescale, "turn_in_place");
    var_9 = _getnotetracktimes(var_6, "turn_begin");
    var_10 = _getnotetracktimes(var_6, "turn_end");
    var_11 = (var_10[0] - var_9[0]) * var_7;
    var_12 = _angleclamp180(var_2 - var_8[1]);
    var_13 = _abs(var_12) / var_11 / 20;
    var_13 = var_13 * 3.14159 / 180;
    var_14 = (0, _angleclamp180(self.angles[1] + var_12), 0);
    self.prevturnrate = self scragentgetmaxturnspeed();
    self scragentsetmaxturnspeed(var_13);
    self scragentsetorientmode("face angle abs", var_14);
    var_7 = _getanimlength(self getanimentry(var_4, var_5));
    maps\mp\agents\_scripted_agent_anim_util::waituntilnotetrack_safe("turn_in_place", "turn_end", var_7);
    self scragentsetmaxturnspeed(self.prevturnrate);
    self.prevturnrate = undefined;
    maps\mp\agents\_scripted_agent_anim_util::waituntilnotetrack_safe("turn_in_place", "end", var_7);
  } else {
    self.prevturnrate = self scragentgetmaxturnspeed();
    var_13 = _abs(_angleclamp180(var_2 - var_8[1])) / var_7 / 20;
    var_13 = var_13 * 3.14159 / 180;
    self scragentsetmaxturnspeed(var_13);
    var_14 = (0, _angleclamp180(var_0 - var_8[1]), 0);
    self scragentsetorientmode("face angle abs", var_14);
    maps\mp\agents\_scripted_agent_anim_util::playanimnatrateuntilnotetrack_safe(var_4, var_5, self.generalspeedratescale, "turn_in_place");
    self scragentsetmaxturnspeed(self.prevturnrate);
    self.prevturnrate = undefined;
  }

  self scragentsetanimmode("anim deltas");
  playidleanim();
}

rotatetoangle(var_0, var_1) {
  if(_abs(_angleclamp180(var_0 - self.angles[1])) <= var_1) {
    return;
  }
  var_2 = (0, var_0, 0);
  self scragentsetorientmode("face angle abs", var_2);

  while(_angleclamp180(var_0 - self.angles[1]) > var_1) {
    wait 0.1;
  }
}