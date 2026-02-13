/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\cp\zombies\zombie_slow.gsc
*************************************************/

is_slowed() {
  return isDefined(self.activeslows) && self.activeslows.size > 0;
}

slow(var_0, var_1, var_2, var_3, var_4) {
  if(_id_06FE::is_zm_elite()) {
    return;
  }
  if(!isDefined(self.activeslows)) {
    self.activeslows = [];
  }

  if(self.activeslows.size == 0) {
    self.cachedplaybackrate = _id_0009::_id_1C69();
  }

  var_5 = self.activeslows[var_0];

  if(!isDefined(var_5)) {
    var_5 = spawnStruct();
    self.activeslows[var_0] = var_5;
  }

  var_6 = gettime() + var_2 * 1000;
  var_5._id_534E = var_6;
  var_5._id_C047 = var_1;
  var_5.endcallback = var_4;
  var_5.applier = var_3;
  thread _slow_monitor();
}

has_slow(var_0) {
  return isDefined(self.activeslows) && isDefined(self.activeslows[var_0]);
}

has_applied_slow(var_0, var_1) {
  if(isDefined(self.activeslows) && isDefined(self.activeslows[var_1]) && isDefined(var_0) && isDefined(self.activeslows[var_1].applier)) {
    return self.activeslows[var_1].applier == var_0;
  }

  return 0;
}

end_slow(var_0) {
  if(!isDefined(self.activeslows) || !isDefined(self.activeslows[var_0])) {
    return;
  }
  self.activeslows[var_0]._id_534E = -1;
  self notify("end_slow_zombie");
}

end_all_slows() {
  if(!isDefined(self.activeslows)) {
    return;
  }
  foreach(var_1 in self.activeslows) {
    var_1._id_534E = -1;
  }

  self notify("end_slow_zombie");
}

_slow_monitor() {
  self notify("start_slow_zombie");
  self endon("start_slow_zombie");
  self endon("death");
  _remove_expired_slows();

  for(var_0 = self.activeslows.size; var_0; var_0 = self.activeslows.size) {
    var_1 = gettime();
    var_2 = undefined;
    var_3 = undefined;

    foreach(var_5 in self.activeslows) {
      if(!isDefined(var_3) || var_5._id_C047 < var_3._id_C047) {
        var_3 = var_5;
      }

      if(!isDefined(var_2) || var_5._id_534E < var_2) {
        var_2 = var_5._id_534E;
      }
    }

    if(isDefined(var_3) && var_1 < var_2) {
      _update_animation_rate_scale(var_3._id_C047);
      var_7 = (var_2 - var_1) / 1000.0;
      scripts\engine\utility::_id_108A8(var_7, "end_slow_zombie");
    }

    _remove_expired_slows();
  }

  var_8 = scripts\cp\utility::_id_459B(self.cachedplaybackrate, 1.0);
  _update_animation_rate_scale(var_8);
}

_remove_expired_slows() {
  var_0 = self.activeslows;
  self.activeslows = [];
  var_1 = gettime();

  foreach(var_4, var_3 in var_0) {
    if(var_3._id_534E > var_1) {
      self.activeslows[var_4] = var_3;
      var_0[var_4] = undefined;
    }
  }

  foreach(var_3 in var_0) {
    if(!isDefined(var_3)) {
      continue;
    }
    if(isDefined(var_3.endcallback)) {
      self thread[[var_3.endcallback]]();
    }
  }
}

_update_animation_rate_scale(var_0) {
  if(!isagent(self)) {
    return;
  }
  _id_0909::setmoveratescale(var_0);
  _id_0909::setnonmoveratescale(var_0);

  if(!istrue(self._id_86ED) && !istrue(self.is_dying) && isDefined(self._id_1CB8) && gettime() > self._id_0094) {
    var_1 = _id_0009::_id_1C5F(self._id_1CB8);
    var_2 = self _meth_810D();

    if(var_2 >= self _meth_810F(var_1)) {
      var_2 = undefined;
    }

    self _meth_82E6(var_1, var_2, var_0);
  }
}