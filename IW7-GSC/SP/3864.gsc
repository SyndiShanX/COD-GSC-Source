/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3864.gsc
**************************************/

_id_956A() {
  level._id_83D2 = [];

  foreach(var_1 in ["_autosave_stealthcheck", "_patrol_endon_spotted_flag", "_spawner_stealth_default", "_idle_call_idle_func"])
  level._id_83D2[var_1] = ::_id_83D6;

  scripts\engine\utility::flag_init("stealth_spotted");
  scripts\engine\utility::flag_init("stealth_enabled");
  scripts\engine\utility::flag_init("stealth_music_pause");
}

_id_83D6(var_0, var_1, var_2, var_3, var_4) {}

_id_10EBB(var_0) {
  if(isDefined(self._id_10E6D) && isDefined(self._id_10E6D._id_74D5) && isDefined(self._id_10E6D._id_74D5[var_0]))
    return self._id_10E6D._id_74D5[var_0];

  if(isDefined(level._id_10E6D) && isDefined(level._id_10E6D._id_74D5))
    return level._id_10E6D._id_74D5[var_0];

  return undefined;
}

_id_10E8A(var_0, var_1, var_2, var_3) {
  var_4 = _id_10EBB(var_0);

  if(isDefined(var_4)) {
    if(isDefined(var_3))
      return self[[var_4]](var_1, var_2, var_3);
    else if(isDefined(var_2))
      return self[[var_4]](var_1, var_2);
    else if(isDefined(var_1))
      return self[[var_4]](var_1);
    else
      return self[[var_4]]();
  }

  return undefined;
}

_id_10E8B(var_0, var_1, var_2, var_3) {
  var_4 = _id_10EBB(var_0);

  if(isDefined(var_4)) {
    if(isDefined(var_3))
      return self thread[[var_4]](var_1, var_2, var_3);
    else if(isDefined(var_2))
      return self thread[[var_4]](var_1, var_2);
    else if(isDefined(var_1))
      return self thread[[var_4]](var_1);
    else
      return self thread[[var_4]]();
  }

  return undefined;
}