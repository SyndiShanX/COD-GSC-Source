/***************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\agents\humanoid\_humanoid_melee.gsc
***************************************************************/

main() {
  self endon("death");
  self endon("killanimscript");
  self._id_28D2 endon("disconnect");
  var_0 = maps\mp\agents\humanoid\_humanoid::_id_457E(self._id_28D2);

  if(_id_5753(self._id_28D2))
    return _id_60E7(self._id_28D2);

  if(common_scripts\utility::_id_562E(self._id_5F4C) && var_0._id_A266) {
    if(!isDefined(self._id_5F48))
      self._id_5F48 = 0;

    if(isDefined(self._id_60ED)) {
      var_1 = gettime() - self._id_5F48 > self._id_5F46;
      var_2 = maps\mp\agents\humanoid\_humanoid_util::_id_1F51(self.origin, var_0.origin);
      var_3 = distancesquared(self._id_28D2.origin, self.origin) > self._id_5F50;

      if(var_1 && var_2 && var_3) {
        self._id_5F48 = gettime();
        _id_3108(self._id_28D2, var_0.origin);
        return;
      }
    }

    if(!maps\mp\agents\humanoid\_humanoid_util::_id_AA52(self._id_28D2)) {
      _id_5F4D(self._id_28D2);
      return;
    }
  }

  _id_3109(self._id_28D2, var_0.origin);
}

_id_5753(var_0) {
  if(!isDefined(var_0))
    var_0 = self._id_28D2;

  var_1 = self.origin + (0, 0, self._id_60E1);
  var_2 = var_0.origin + (0, 0, self._id_60E1);
  var_3 = undefined;

  if(isDefined(var_0.classname) && var_0.classname == "misc_turret" && isDefined(var_0._id_0B40))
    var_3 = _physicstrace(var_1, var_2, var_0._id_0B40);
  else
    var_3 = _physicstrace(var_1, var_2);

  return distancesquared(var_3, var_2) > 1;
}

_id_0085() {
  self scragentsetanimscale(1, 1);
}

_id_3107(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  self._id_5BBE = undefined;
  self._id_5BBF = undefined;

  if(!isDefined(var_6))
    var_6 = 0;

  var_8 = maps\mp\agents\_scripted_agent_anim_util::_id_7A35(var_2);
  var_9 = self getanimentry(var_2, var_8);
  var_10 = _getanimlength(var_9);
  var_11 = [];

  foreach(var_13 in ["hit", "attack", "zombie_melee"])
  var_11 = common_scripts\utility::_id_0F73(var_11, _getnotetracktimes(var_9, var_13));

  if(var_11.size == 0)
    var_11 = [0.33];
  else if(var_11.size >= 2)
    var_11 = common_scripts\utility::_id_7897(var_11);

  self scragentsetphysicsmode("gravity");

  if(common_scripts\utility::_id_562E(var_7))
    self scragentsetorientmode("face angle abs", self.angles);
  else if(var_4)
    self scragentsetorientmode("face enemy");
  else
    self scragentsetorientmode("face angle abs", (0, _vectortoyaw(var_0.origin - self.origin), 0));

  self scragentsetanimmode("anim deltas");
  maps\mp\agents\_scripted_agent_anim_util::isenemyaware(var_2, var_8, var_5);
  var_15 = 0;

  for(var_16 = 0; var_16 < var_11.size; var_16++) {
    var_17 = var_11[var_16];
    var_18 = var_15;
    var_19 = var_5;

    if(var_16 == 0 && var_6) {
      var_20 = _getnotetracktimes(var_9, "lunge_start");

      if(var_20.size > 0 && var_20[0] < var_17)
        var_18 = var_20[0];

      var_21 = (var_18 - var_15) * var_10 / var_5;
      wait(var_21);
      maps\mp\agents\humanoid\_humanoid_util::_id_70C9(self._id_5F47);

      if(self._id_5F44) {
        var_22 = var_1 - self.origin;
        var_23 = _getmovedelta(var_9, var_18, var_17);
        var_24 = maps\mp\agents\_scripted_agent_anim_util::_id_441C(var_22, var_23);
        var_19 = var_5 * clamp(1 / var_24._id_AAE3, 0.5, 1);
        maps\mp\agents\_scripted_agent_anim_util::isenemyaware(var_2 + "_norestart", var_8, var_19);
      }
    }

    var_25 = (var_17 - var_18) * var_10 / var_5;
    var_26 = "";
    var_27 = "";
    var_28 = 30;
    var_29 = -1.8;
    var_30 = self.origin;

    if(var_3) {
      childthread _id_A12D(var_0, var_25, 1, self._id_5F49);
      maps\mp\agents\_scripted_agent_anim_util::_id_8732(1, "DoAttack");
    } else
      self scragentsetanimscale(1, 1);

    wait(var_25);
    self _meth_85D4(var_5);
    self notify("cancel_updatelerppos");
    self scragentsetanimmode("anim deltas");
    self scragentsetanimscale(1, 1);

    if(var_3)
      maps\mp\agents\_scripted_agent_anim_util::_id_8732(0, "DoAttack");

    var_33 = _id_11AF(var_0);

    if(var_33) {
      var_34 = 0;

      if(isDefined(var_0))
        var_34 = var_0.health;

      if(isDefined(self._id_60E2))
        var_34 = self._id_60E2;

      if(isalive(var_0))
        _id_3210(var_0, var_34, "MOD_IMPACT");
    }

    var_35 = common_scripts\utility::_id_98E7(var_33, "attack_hit", "attack_miss");

    if(!isDefined(var_0.shield_hit_blocked) || gettime() != var_0.shield_hit_blocked)
      self notify(var_35, var_0, var_1);

    self._id_5BC1 = self.origin;
    var_15 = var_17;
  }

  var_36 = (1.0 - var_15) * var_10 / var_5;

  if(var_36 > 0)
    maps\mp\agents\_scripted_agent_anim_util::_id_A79F("attack_anim", "end", var_36);

  self._id_5BC0 = gettime();
}

_id_11AF(var_0) {
  if(!isalive(var_0))
    return 0;

  if(!_id_AA50(var_0))
    return 0;

  if(_id_56DA(var_0, self._id_60E5))
    return 1;

  if(maps\mp\agents\humanoid\_humanoid_util::_id_56DD(var_0))
    return 1;

  return 0;
}

_id_56DA(var_0, var_1) {
  var_2 = vectorNormalize((var_0.origin - self.origin) * (1, 1, 0));
  var_3 = anglesToForward(self.angles);
  var_4 = vectordot(var_2, var_3);
  return var_4 > var_1;
}

_id_AA50(var_0) {
  if(!maps\mp\agents\humanoid\_humanoid::_id_7AC0("normal", var_0))
    return 0;

  if(maps\mp\agents\humanoid\_humanoid_util::_id_4580() > self._id_60F0 && !maps\mp\agents\humanoid\_humanoid_util::_id_AA52(var_0))
    return 0;

  return 1;
}

_id_3109(var_0, var_1) {
  var_2 = "attack_stand";
  var_3 = self._id_672D;
  var_4 = 0;

  if(isDefined(self._id_60ED)) {
    var_2 = "attack_" + self._id_60ED;
    var_4 = 1;
    self._id_60ED = undefined;
  }

  var_5 = maps\mp\agents\_scripted_agent_anim_util::_id_434D(var_2);
  _id_3107(var_0, var_1, var_5, 0, var_4, var_3);
}

_id_3108(var_0, var_1) {
  _id_3107(var_0, var_1, self._id_5F45, 1, 1, self._id_672D, 1);
}

_id_A12D(var_0, var_1, var_2, var_3) {
  self endon("killanimscript");
  self endon("death");
  self endon("cancel_updatelerppos");
  var_0 endon("disconnect");
  var_0 endon("death");
  var_4 = self.origin;
  var_5 = var_1;
  var_6 = 0.05;
  self scragentsetanimscale(0, 1);

  for(;;) {
    if(var_5 <= 0) {
      break;
    }

    var_7 = _id_4707(var_0, var_2);

    if(!isDefined(var_7)) {
      break;
    }

    if(isDefined(var_3))
      var_8 = var_3;
    else
      var_8 = maps\mp\agents\humanoid\_humanoid_util::_id_4580() - self.radius;

    var_9 = var_7 - var_4;

    if(_lengthsquared(var_9) > var_8 * var_8)
      var_7 = var_4 + vectorNormalize(var_9) * var_8;

    if(self _meth_85DF()) {
      var_10 = common_scripts\utility::_id_3D5D(var_7 - self.origin);
      var_11 = length(var_10);

      if(var_11 > 1) {
        var_12 = vectorNormalize(common_scripts\utility::_id_3D5D(anglesToForward(self.angles)));
        var_13 = var_10 / var_11;
        var_14 = _acos(clamp(vectordot(var_13, var_12), -1, 1));
        var_15 = self _meth_85DD();
        var_16 = _id_0547::_id_9A6C(var_15);

        if(var_14 > var_16) {
          var_17 = self.origin + var_12 * var_11 * max(0, vectordot(var_12, var_13));

          if(distance(var_4, var_17) > var_8)
            var_17 = var_4 + vectorNormalize(var_17 - var_4) * var_8;

          var_7 = var_17;
        }
      }
    }

    self scragentsetorientmode("face enemy");
    self scragentdoanimlerp(self.origin, var_7, var_5);
    wait(var_6);
    var_5 = var_5 - var_6;
  }
}

_id_4707(var_0, var_1) {
  if(!var_1) {
    var_2 = _id_0547::_id_34A6(var_0.origin);
    return var_2;
  } else {
    var_3 = var_0.origin - self.origin;
    var_4 = length(var_3);

    if(var_4 < self._id_11AB)
      return self.origin;
    else {
      var_3 = var_3 / var_4;
      var_5 = maps\mp\agents\humanoid\_humanoid::_id_457E(var_0);

      if(maps\mp\agents\humanoid\_humanoid_util::_id_1F51(self.origin, var_5.origin))
        return var_5.origin;
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

_id_60E7(var_0) {
  if(!isDefined(var_0))
    var_0 = self._id_28D2;

  self._id_5BBE = self.origin;
  self._id_5BBF = var_0.origin;
}

_id_5F4D(var_0) {
  if(!isDefined(var_0))
    var_0 = self._id_28D2;

  self._id_5BBB = self.origin;
  self._id_5BBC = var_0.origin;
}