/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2216.gsc
*************************************************/

_id_7F16() {
  level._id_7039 = [];

  foreach(var_1 in ["_autosave_stealthcheck", "_patrol_endon_spotted_flag", "_spawner_stealth_default", "_idle_call_idle_func"]) {
    level._id_7039[var_1] = ::_id_703D;
  }

  scripts\engine\utility::_id_5C11("stealth_spotted");
  scripts\engine\utility::_id_5C11("stealth_enabled");
  scripts\engine\utility::_id_5C11("stealth_music_pause");
}

_id_703D(var_0, var_1, var_2, var_3, var_4) {}

_id_E7AD(var_0) {
  if(isDefined(self._id_0408) && isDefined(self._id_0408._id_6035) && isDefined(self._id_0408._id_6035[var_0])) {
    return self._id_0408._id_6035[var_0];
  }

  if(isDefined(level._id_0408) && isDefined(level._id_0408._id_6035)) {
    return level._id_0408._id_6035[var_0];
  }

  return undefined;
}

_id_E79C(var_0, var_1, var_2, var_3) {
  var_4 = _id_E7AD(var_0);

  if(isDefined(var_4)) {
    if(isDefined(var_3)) {
      return self[[var_4]](var_1, var_2, var_3);
    } else if(isDefined(var_2)) {
      return self[[var_4]](var_1, var_2);
    } else if(isDefined(var_1)) {
      return self[[var_4]](var_1);
    } else {
      return self[[var_4]]();
    }
  }

  return undefined;
}

_id_E79D(var_0, var_1, var_2, var_3) {
  var_4 = _id_E7AD(var_0);

  if(isDefined(var_4)) {
    if(isDefined(var_3)) {
      return self thread[[var_4]](var_1, var_2, var_3);
    } else if(isDefined(var_2)) {
      return self thread[[var_4]](var_1, var_2);
    } else if(isDefined(var_1)) {
      return self thread[[var_4]](var_1);
    } else {
      return self thread[[var_4]]();
    }
  }

  return undefined;
}