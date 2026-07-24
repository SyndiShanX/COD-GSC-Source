/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3881.gsc
**************************************/

_id_863C() {
  self waittill("death");
  self.cleanup = scripts\engine\utility::array_removeundefined(self.cleanup);

  foreach(var_1 in self.cleanup)
  var_1 delete();

  level._id_864B[self.classname].turrets = scripts\engine\utility::array_remove(level._id_864B[self.classname].turrets, self);
}

_id_8646(var_0, var_1) {
  if(!isDefined(var_0)) {
    return;
  }
  if(!isDefined(self)) {
    return;
  }
  if(!isDefined(var_1))
    var_2 = 1;

  var_0._id_8644 = var_1;
  self.targets = scripts\engine\utility::array_add(self.targets, var_0);
  self notify("new_target_added");
}

_id_863D(var_0) {
  if(!isDefined(self)) {
    return;
  }
  self.targets = scripts\engine\utility::array_remove(self.targets, var_0);

  if(self._id_4BC7 == var_0)
    self notify("force_target_update");
}

_id_DFEA() {
  self.targets = scripts\engine\utility::array_removeundefined(self.targets);
  self.targets = scripts\sp\utility::_id_22B9(self.targets);
}

_id_8641() {
  var_0 = level._id_864B[self.classname]._id_6D86[self._id_6D85];
  self._id_6D85++;

  if(self._id_6D85 >= level._id_864B[self.classname]._id_6D86.size)
    self._id_6D85 = 0;

  return var_0;
}

_id_863A() {
  for(var_0 = randomintrange(level._id_864B[self.classname]._id_32B1, level._id_864B[self.classname]._id_32B0); var_0 > 0; var_0--) {
    var_1 = _id_8641();
    self thread[[level._id_864B[self.classname]._id_6D6E]](var_1);
    wait(level._id_864B[self.classname]._id_6D7E);
  }
}

_id_8647() {
  self notify("stop_firing");
  self._id_9BE2 = 0;
}

_id_8640() {
  self endon("death");
  self endon("stop_firing");
  self._id_4BC7 endon("death");
  self._id_9BE2 = 1;

  for(;;) {
    if(!isDefined(self._id_4BC7)) {
      return;
    }
    _id_13638(3);
    _id_863A();
    wait(randomfloatrange(level._id_864B[self.classname]._id_32B4, level._id_864B[self.classname]._id_32B3));
  }
}

_id_13638(var_0) {
  var_1 = 10000000;
  self._id_4BC7 endon("death");

  for(;;) {
    wait(randomfloatrange(0.05, 0.2));

    if(!isDefined(self._id_4BC7)) {
      return;
    }
    if(!scripts\engine\utility::within_fov(self gettagorigin("tag_barrel"), self gettagangles("tag_barrel"), self._id_4BC7.origin, cos(level._id_864B[self.classname]._id_C4BA))) {
      continue;
    }
    if(level._id_864B[self.classname]._id_B436 > 0)
      var_1 = distance(self.origin, self._id_4BC7.origin);
    else
      var_1 = -1;

    if(var_1 > level._id_864B[self.classname]._id_B436) {
      continue;
    }
    var_2 = self gettagorigin(level._id_864B[self.classname]._id_6D86[self._id_6D85]);
    var_3 = self gettagangles(level._id_864B[self.classname]._id_6D86[self._id_6D85]);
    var_4 = var_2 + anglesToForward(var_3) * level._id_864B[self.classname]._id_B744;
    var_5 = bulletTrace(var_2, var_4, 1, self);

    if(var_5["fraction"] < 1) {
      continue;
    }
    break;
  }
}

_id_8649() {
  self endon("death");
  self endon("stop_forever");

  for(;;) {
    _id_8648();
    self notify("new_target_selected");
    thread _id_864A();

    if(!self._id_9BE2)
      thread _id_8640();

    self settargetentity(self._id_4BC7);
  }
}

_id_8645() {
  self endon("death");
  _id_8647();
  self._id_4BC7 = undefined;
  var_0 = scripts\engine\utility::spawn_tag_origin();
  var_0.origin = self.origin + anglesToForward(self.angles) * 1000;
  self.cleanup = scripts\engine\utility::array_add(self.cleanup, var_0);
  self settargetentity(var_0);
  self waittill("new_target_added");
  self.cleanup = scripts\engine\utility::array_remove(self.cleanup, var_0);
  var_0 delete();
}

_id_864A() {
  self endon("death");
  self endon("new_target_selected");
  self._id_4BC7 waittill("death");
  self notify("force_target_update");
}

_id_863B(var_0) {
  return 1;
}

_id_8643() {
  var_0 = (0, 1, 0);
  var_1 = _id_8642();
  var_2 = !isDefined(self._id_C013) && isDefined(self._id_102A9) && self._id_102A9.size > 0;

  if(var_2 && isDefined(self._id_102A7) && randomfloat(1.0) <= self._id_102A7) {
    var_0 = (1, 1, 1);
    var_1 = self._id_102A9;
  }

  if(isDefined(self._id_1152C) && self._id_1152C == "random")
    var_1 = scripts\engine\utility::array_randomize(var_1);
  else
    var_1 = sortbydistance(var_1, self.origin);

  var_3 = var_1[0];

  if(isDefined(var_3))
    var_4 = distancesquared(self.origin, var_3.origin);
  else
    var_4 = 99999999;

  var_5 = level._id_864B[self.classname]._id_B436 * level._id_864B[self.classname]._id_B436;

  if(!isDefined(var_3) || !self _meth_8540(var_3.origin) || var_4 > var_5) {
    var_0 = (1, 0, 0);

    if(var_2) {
      var_0 = (0, 0, 1);
      var_3 = scripts\engine\utility::random(self._id_102A9);
    }
  }

  var_6 = level._id_864B[self.classname]._id_E31C;
  var_7 = level._id_864B[self.classname]._id_E31B;
  self._id_BF56 = gettime() / 1000 + randomfloatrange(var_6, var_7);
  return var_3;
}

_id_8642() {
  var_0 = self.targets;

  foreach(var_2 in var_0) {
    if(isDefined(var_2) && isDefined(var_2._blackboard) && var_2._blackboard.animscriptedactive)
      var_0 = scripts\engine\utility::array_remove(var_0, var_2);

    if(isDefined(var_2.ignoreme) && var_2.ignoreme)
      var_0 = scripts\engine\utility::array_remove(var_0, var_2);
  }

  return var_0;
}

_id_8648() {
  for(;;) {
    _id_DFEA();

    if(self.targets.size == 0)
      _id_8645();

    var_0 = undefined;

    if(!isDefined(self._id_BF56) || gettime() / 1000 >= self._id_BF56)
      var_0 = _id_8643();

    if(isDefined(var_0)) {
      if(!isDefined(self._id_4BC7) || var_0 != self._id_4BC7) {
        break;
      }
    }

    _id_13645();
  }

  self._id_4BC7 = var_0;
}

_id_13645() {
  self endon("force_target_update");
  wait(self._id_1151C);
}

_id_863F() {
  self waittill("death");

  if(isDefined(self) && isDefined(level._id_864B[self.classname]._id_4E48))
    playFX(level._id_864B[self.classname]._id_4E48, self.origin, anglesToForward(self.angles), anglestoup(self.angles));

  if(isDefined(self) && isDefined(level._id_864B[self.classname]._id_4E63))
    playworldsound(level._id_864B[self.classname]._id_4E63, self.origin);

  if(isDefined(self) && isDefined(level._id_864B[self.classname]._id_4E66)) {
    self._id_10382 = spawnfx(level._id_864B[self.classname]._id_4E66, self.origin, anglesToForward(self.angles), anglestoup(self.angles));
    triggerfx(self._id_10382);
  }

  if(isDefined(self) && isDefined(level._id_864B[self.classname]._id_4E56)) {
    if(!isDefined(level._id_864B[self.classname]._id_4E57))
      var_0 = 5000;
    else
      var_0 = level._id_864B[self.classname]._id_4E57;

    if(!isDefined(level._id_864B[self.classname]._id_4E58))
      var_1 = 0.4;
    else
      var_1 = level._id_864B[self.classname]._id_4E58;

    earthquake(level._id_864B[self.classname]._id_4E56, var_1, self.origin, var_0);
  }

  self hide();
}

_id_863E() {
  self endon("death");
  var_0 = self.origin;
  var_1 = self.angles;

  for(;;) {
    self waittill("damage", var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11);

    if(isDefined(self._id_843F) && self._id_843F)
      self.health = self.health + var_2;

    if(self.health < level._id_86AC)
      self notify("death");
  }
}