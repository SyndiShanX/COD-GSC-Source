/************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: 3864.gsc
************************/

func_956A() {
  level._meth_83D2 = [];
  foreach(var_01 in ["_autosave_stealthcheck", "_patrol_endon_spotted_flag", "_spawner_stealth_default", "_idle_call_idle_func"]) {
    level._meth_83D2[var_01] = ::usetriggerrequirelookat;
  }

  scripts\engine\utility::flag_init("stealth_spotted");
  scripts\engine\utility::flag_init("stealth_enabled");
  scripts\engine\utility::flag_init("stealth_music_pause");
}

usetriggerrequirelookat(param_00, param_01, param_02, param_03, param_04) {}

func_10EBB(param_00) {
  if(isDefined(self.var_10E6D) && isDefined(self.var_10E6D.var_74D5) && isDefined(self.var_10E6D.var_74D5[param_00])) {
    return self.var_10E6D.var_74D5[param_00];
  }

  if(isDefined(level.var_10E6D) && isDefined(level.var_10E6D.var_74D5)) {
    return level.var_10E6D.var_74D5[param_00];
  }

  return undefined;
}

func_10E8A(param_00, param_01, param_02, param_03) {
  var_04 = func_10EBB(param_00);
  if(isDefined(var_04)) {
    if(isDefined(param_03)) {
      return self[[var_04]](param_01, param_02, param_03);
    } else if(isDefined(param_02)) {
      return self[[var_04]](param_01, param_02);
    } else if(isDefined(param_01)) {
      return self[[var_04]](param_01);
    } else {
      return self[[var_04]]();
    }
  }

  return undefined;
}

func_10E8B(param_00, param_01, param_02, param_03) {
  var_04 = func_10EBB(param_00);
  if(isDefined(var_04)) {
    if(isDefined(param_03)) {
      return self thread[[var_04]](param_01, param_02, param_03);
    } else if(isDefined(param_02)) {
      return self thread[[var_04]](param_01, param_02);
    } else if(isDefined(param_01)) {
      return self thread[[var_04]](param_01);
    } else {
      return self thread[[var_04]]();
    }
  }

  return undefined;
}