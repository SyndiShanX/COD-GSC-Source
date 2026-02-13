/*******************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\aitypes\zombie_common\awareness.gsc
*******************************************************/

is_aware() {
  return scripts\cp\utility::_id_459B(self.isaware, 1);
}

set_aware() {
  if(is_aware()) {
    return;
  }
  self.isaware = 1;
  self notify("made_aware");

  if(isDefined(self._id_106A1)) {
    aware_zone(self._id_106A1);
  }
}

set_unaware() {
  if(!is_aware()) {
    return;
  }
  self.isaware = 0;
  thread _awareness_monitor();
}

aware_zone(var_0) {
  var_1 = _func_0070("axis");

  foreach(var_3 in var_1) {
    if(!var_3 is_aware() && isDefined(var_3._id_106A1) && var_0 == var_3._id_106A1) {
      var_3.isaware = 1;
      var_3 notify("made_aware");
    }
  }
}

isaware(var_0) {
  return scripts\engine\utility::ter_op(is_aware(), anim._id_EACB, anim._id_58E3);
}

wanderinit(var_0) {
  var_1 = spawnStruct();
  var_1.v_previousposition = self.origin;
  var_1.n_lastmovetime = gettime();
  var_1.v_wanderposition = _generate_wander_position();

  if(isDefined(var_1.v_wanderposition)) {
    self _meth_84BC(0, var_1.v_wanderposition);
    self._id_24F8 = 0;
  }

  _id_06BD::_id_23F3("wander");
  self._id_2C5E._id_82FD[var_0] = var_1;
}

wander(var_0) {
  var_1 = self._id_2C5E._id_82FD[var_0];

  if(!isDefined(var_1.v_wanderposition)) {
    return anim._id_58E3;
  }

  if(var_1.v_previousposition != self.origin) {
    var_1.v_previousposition = self.origin;
    var_1.n_lastmovetime = gettime();
  } else if(gettime() - var_1.n_lastmovetime > 1000)
    return anim._id_58E3;

  var_2 = 16;
  var_3 = distancesquared(var_1.v_wanderposition, self.origin);
  var_4 = var_3 <= var_2 * var_2;
  return scripts\engine\utility::ter_op(var_4, anim._id_EACB, anim._id_CA5F);
}

wanderterminate(var_0) {
  self._id_2C5E._id_82FD[var_0] = undefined;
  _id_06BD::_id_23F3(self._id_91A3._id_02D6);
  self _meth_84C0(0);
}

idleinit(var_0) {
  var_1 = spawnStruct();
  var_1.n_endtime = gettime() + randomfloatrange(3, 7) * 1000;
  self._id_2C5E._id_82FD[var_0] = var_1;
}

_id_7CA9(var_0) {
  var_1 = self._id_2C5E._id_82FD[var_0];
  self _meth_84BC(0, self.origin);
  self._id_24F8 = 0;
  var_3 = gettime() >= var_1.n_endtime;
  return scripts\engine\utility::ter_op(var_3, anim._id_EACB, anim._id_CA5F);
}

idleterminate(var_0) {
  self._id_2C5E._id_82FD[var_0] = undefined;
}

_awareness_monitor() {
  self endon("disconnect");
  self endon("made_aware");
  var_0 = self._id_106A1;

  if(isDefined(var_0)) {
    childthread _awareness_zone_active_monitor();
    childthread scripts\engine\utility::_id_F127("death", ::aware_zone, var_0);
  }

  childthread _awareness_damage_monitor();
}

_awareness_zone_active_monitor() {
  self endon("death");

  for(;;) {
    var_0 = self._id_106A1;

    if(istrue(var_0.contains_player)) {
      thread set_aware();
    }

    wait 0.5;
  }
}

_awareness_damage_monitor() {
  self endon("death");
  self waittill("damage", var_0, var_1);
  thread set_aware();
}

_generate_wander_position() {
  var_0 = self._id_106A1;

  if(isDefined(var_0)) {
    var_1 = var_0.origin + var_0 _meth_86AE();
    var_2 = var_0 _meth_86AD();
    var_3 = var_1 - var_2;
    var_4 = var_1 + var_2;
    var_5 = _func_0133(var_2);
    var_6 = _func_02AA(var_1, var_5, 5);
    var_7 = 16384;

    foreach(var_9 in var_6) {
      var_10 = distancesquared(var_9, self.origin);

      if(var_10 > var_7) {
        if(var_9[0] > var_3[0] && var_9[0] < var_4[0] && var_9[1] > var_3[1] && var_9[1] < var_4[1]) {
          var_11 = !_func_02A6(self.origin, var_9);

          if(var_11) {
            return var_9;
          }
        }
      }
    }
  } else {
    var_6 = _func_02AA(self._id_03E9._id_11081, 500, 5);
    var_7 = 16384;

    foreach(var_9 in var_6) {
      var_10 = distancesquared(var_9, self.origin);

      if(var_10 > var_7) {
        var_11 = !_func_02A6(self.origin, var_9);

        if(var_11) {
          return var_9;
        }
      }
    }
  }

  return undefined;
}