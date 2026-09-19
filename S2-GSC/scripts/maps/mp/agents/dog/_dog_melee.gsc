/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\agents\dog\_dog_melee.gsc
*****************************************************/

main() {
  self endon("death");
  self endon("killanimscript");
  self._id_28D2 endon("disconnect");
  var_0 = self._id_28D2.origin - self.origin;
  var_1 = length(var_0);
  var_2 = 1;

  if(var_1 < self._id_11AB) {
    var_3 = self.origin;
    var_2 = 0;
  } else {
    var_0 = var_0 / var_1;
    var_3 = self._id_28D2.origin - var_0 * self._id_11AB;
  }

  var_4 = 0;
  var_5 = self.origin + (0, 0, 30);
  var_6 = self._id_28D2.origin + (0, 0, 30);
  var_7 = _physicstrace(var_5, var_6);

  if(distancesquared(var_7, var_6) > 1) {
    _id_60E7();
    return;
  }

  if(var_2)
    var_8 = maps\mp\agents\_scriptedagents::_id_1F5B(self.origin, var_3);
  else
    var_8 = 1;

  var_9 = undefined;

  if(!var_8)
    var_10 = 0;
  else {
    var_9 = _id_8B8E(self._id_28D2);
    var_10 = isDefined(var_9);
  }

  self._id_17E8 = 1;
  _id_32AF(var_3, var_8);
}

_id_0085() {
  self scragentsetanimscale(1, 1);
  self._id_17E8 = 0;
}

_id_457D() {
  return "attack_run_and_jump";
}

_id_8B8E(var_0) {
  if(!self._id_3658)
    return undefined;

  var_1 = 4;

  if(!maps\mp\_utility::_id_56FF(var_0))
    return undefined;

  if(_id_5797(var_0))
    return undefined;

  var_2 = self.origin - var_0.origin;

  if(_abs(var_2[2]) > var_1)
    return undefined;

  var_3 = vectorNormalize((var_2[0], var_2[1], 0));
  var_4 = anglesToForward(var_0.angles);
  var_5 = vectordot(var_4, var_3);

  if(var_5 > 0.707) {
    var_6 = 0;
    var_7 = _rotatevector((1, 0, 0), var_0.angles);
  } else if(var_5 < -0.707) {
    var_6 = 1;
    var_7 = _rotatevector((-1, 0, 0), var_0.angles);
  } else {
    var_8 = maps\mp\agents\dog\_dog_think::_id_285C(var_2, var_4);

    if(var_8 > 0) {
      var_6 = 3;
      var_7 = _rotatevector((0, -1, 0), var_0.angles);
    } else {
      var_6 = 2;
      var_7 = _rotatevector((0, 1, 0), var_0.angles);
    }
  }

  if(var_6 == 1)
    var_9 = 128;
  else
    var_9 = 96;

  var_10 = var_0.origin - var_9 * var_7;
  var_11 = maps\mp\agents\_scriptedagents::_id_34A6(var_10);

  if(!isDefined(var_11))
    return undefined;

  if(_abs(var_11[2] - var_10[2]) > var_1)
    return undefined;

  if(!self aiphysicstracepassed(var_0.origin + (0, 0, 4), var_11 + (0, 0, 4), self.radius, self._id_00BD))
    return undefined;

  return var_6;
}

_id_3156(var_0) {
  var_1 = "attack_extended";
  _id_3210(self._id_28D2, self._id_28D2.health, "MOD_MELEE_DOG");
  var_2 = self getanimentry(var_1, var_0);
  thread _id_397B(var_2, self._id_28D2.origin, self._id_28D2.angles);
  maps\mp\agents\_scriptedagents::_id_71FC(var_1, var_0, "attack", "end");
  self notify("kill_stick");
  self._id_28D2 = undefined;
  self scragentsetanimmode("anim deltas");
  self unlink();
}

_id_397B(var_0, var_1, var_2) {
  self endon("death");
  self endon("killanimscript");
  self endon("kill_stick");
  waitframe();

  if(isalive(self._id_28D2)) {
    return;
  }
  var_3 = self._id_28D2 getcorpseentity();

  if(!isDefined(var_3)) {
    return;
  }
  self linkto(var_3);
  self scragentdoanimrelative(var_0, var_1, var_2);
}

_id_32AF(var_0, var_1) {
  var_2 = _id_457D();
  var_3 = 0;

  if(!var_1) {
    if(self agentcanseesentient(self._id_28D2)) {
      var_4 = maps\mp\agents\_scriptedagents::_id_34A6(self._id_28D2.origin);

      if(isDefined(var_4)) {
        var_3 = 1;
        var_0 = var_4;
      } else {
        _id_60E7();
        return;
      }
    } else {
      _id_60E7();
      return;
    }
  }

  self._id_5BBE = undefined;
  self._id_5BBF = undefined;
  var_5 = self getanimentry(var_2, 0);
  var_6 = _getanimlength(var_5);
  var_7 = _getnotetracktimes(var_5, "dog_melee");

  if(var_7.size > 0)
    var_8 = var_7[0] * var_6;
  else
    var_8 = var_6;

  self scragentdoanimlerp(self.origin, var_0, var_8);
  thread _id_A12D(self._id_28D2, var_8, var_1);
  maps\mp\agents\_scriptedagents::_id_71FC(var_2, 0, "attack", "dog_melee");
  self notify("cancel_updatelerppos");
  var_9 = 0;

  if(isDefined(self._id_28D2))
    var_9 = 50;

  if(isDefined(self._id_60E2))
    var_9 = self._id_60E2;

  if(isDefined(self._id_28D2))
    _id_3210(self._id_28D2, var_9, "MOD_IMPACT");

  self._id_28D2 = undefined;

  if(var_3)
    self scragentsetanimscale(0, 1);
  else
    self scragentsetanimscale(1, 1);

  self scragentsetphysicsmode("gravity");
  self scragentsetanimmode("anim deltas");
  maps\mp\agents\_scriptedagents::_id_A79E("attack", "end");
}

_id_A12D(var_0, var_1, var_2) {
  self endon("killanimscript");
  self endon("death");
  self endon("cancel_updatelerppos");
  var_0 endon("disconnect");
  var_0 endon("death");
  var_3 = var_1;
  var_4 = 0.05;

  for(;;) {
    wait(var_4);
    var_3 = var_3 - var_4;

    if(var_3 <= 0) {
      break;
    }

    var_5 = _id_4707(var_0, var_2);

    if(!isDefined(var_5)) {
      break;
    }

    self scragentdoanimlerp(self.origin, var_5, var_3);
  }
}

_id_4707(var_0, var_1) {
  if(!var_1) {
    var_2 = maps\mp\agents\_scriptedagents::_id_34A6(var_0.origin);
    return var_2;
  } else {
    var_3 = var_0.origin - self.origin;
    var_4 = length(var_3);

    if(var_4 < self._id_11AB)
      return self.origin;
    else {
      var_3 = var_3 / var_4;
      var_5 = var_0.origin - var_3 * self._id_11AB;

      if(maps\mp\agents\_scriptedagents::_id_1F5B(self.origin, var_5))
        return var_5;
      else
        return undefined;
    }
  }
}

_id_5797(var_0) {
  if(var_0 _id_048A::_id_4B8C()) {
    var_1 = self.origin - var_0.origin;
    var_2 = vectorNormalize((var_1[0], var_1[1], 0));
    var_3 = anglesToForward(var_0.angles);
    var_4 = vectordot(var_3, var_1);

    if(var_0 _id_048A::_id_4B8D()) {
      if(var_4 > 0.766)
        return 1;
    } else if(var_4 < -0.766)
      return 1;
  }

  return 0;
}

_id_3210(var_0, var_1, var_2) {
  if(_id_5797(var_0)) {
    return;
  }
  var_0 dodamage(var_1, self.origin, self, self, var_2);
}

_id_60E7() {
  self._id_5BBE = self.origin;
  self._id_5BBF = self._id_28D2.origin;
}