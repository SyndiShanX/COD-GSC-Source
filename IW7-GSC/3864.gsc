/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: 3864.gsc
*********************************************/

func_956A() {
  level._meth_83D2 = [];
  foreach(var_1 in ["_autosave_stealthcheck", "_patrol_endon_spotted_flag", "_spawner_stealth_default", "_idle_call_idle_func"]) {
    level._meth_83D2[var_1] = ::usetriggerrequirelookat;
  }

  scripts\engine\utility::flag_init("stealth_spotted");
  scripts\engine\utility::flag_init("stealth_enabled");
  scripts\engine\utility::flag_init("stealth_music_pause");
}

usetriggerrequirelookat(var_0, var_1, var_2, var_3, var_4) {}

func_10EBB(var_0) {
  if(isDefined(self.var_10E6D) && isDefined(self.var_10E6D.var_74D5) && isDefined(self.var_10E6D.var_74D5[var_0])) {
    return self.var_10E6D.var_74D5[var_0];
  }

  if(isDefined(level.var_10E6D) && isDefined(level.var_10E6D.var_74D5)) {
    return level.var_10E6D.var_74D5[var_0];
  }

  return undefined;
}

func_10E8A(var_0, var_1, var_2, var_3) {
  var_4 = func_10EBB(var_0);
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

func_10E8B(var_0, var_1, var_2, var_3) {
  var_4 = func_10EBB(var_0);
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