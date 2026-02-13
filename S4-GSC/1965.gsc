/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 1965.gsc
*************************************************/

_id_8138() {
  if(isDefined(level._id_1A2F)) {
    return;
  }
  level._id_1A2F = [];
  level._id_1A30 = [];

  if(scripts\cp_mp\utility\game_utility::_id_6B2D() == "mp_junk") {
    var_0 = getEntArray("mag_up", "targetname");

    if(!isDefined(var_0) || var_0.size == 0) {
      return;
    }
    level._id_1A2F = var_0;

    foreach(var_2 in var_0) {
      var_3 = var_2 getentitynumber();
      var_4 = spawnStruct();
      var_4.trigger = var_2;
      var_4._id_2299 = undefined;
      var_4._id_5528 = [];

      if(isDefined(var_2.target)) {
        var_4._id_2299 = getent(var_2.target, "targetname");
        var_4._id_257F = var_4._id_2299.origin + (0, 0, -175);
      }

      level._id_1A30[var_3] = var_4;
      thread _id_10A8D(var_4);
      thread _id_10A8E(var_4);
    }
  }
}

_id_10A8D(var_0) {
  for(;;) {
    var_0.trigger waittill("trigger", var_1);

    if(!isDefined(var_1)) {
      continue;
    }
    if(!_id_DAF7(var_0, var_1)) {
      continue;
    }
    var_2 = var_1 getentitynumber();
    var_0._id_5528[var_2] = var_1;
    var_1._id_1A31 = var_0;
  }
}

_id_10A8E(var_0) {
  for(;;) {
    foreach(var_2 in var_0._id_5528) {
      if(!isDefined(var_2)) {
        continue;
      }
      if(!_id_DBC7(var_0, var_2)) {
        continue;
      }
      var_3 = var_2 getentitynumber();
      var_0._id_5528[var_3] = undefined;

      if(isDefined(var_2._id_1A31) && var_2._id_1A31 == var_0) {
        var_2._id_1A31 = undefined;
      }
    }

    waitframe();
  }
}

_id_DAF7(var_0, var_1) {
  if(!isPlayer(var_1)) {
    return 0;
  }

  var_2 = var_1 getentitynumber();

  if(isDefined(var_0._id_5528[var_2])) {
    return 0;
  }

  return 1;
}

_id_DBC7(var_0, var_1) {
  if(!var_1 istouching(var_0.trigger)) {
    return 1;
  }

  return 0;
}

_id_68CA() {
  if(!isDefined(self._id_1A31)) {
    return undefined;
  }

  return self._id_1A31.trigger;
}

_id_68CB() {
  if(!isDefined(self._id_1A31)) {
    return undefined;
  }

  return self._id_1A31._id_2299;
}

_id_68CC() {
  if(!isDefined(self._id_1A31)) {
    return undefined;
  }

  return self._id_1A31._id_257F;
}

_id_88B6() {
  if(isPlayer(self)) {
    if(self _meth_8541() != (0, 0, 0)) {
      return 1;
    }
  }

  return 0;
}