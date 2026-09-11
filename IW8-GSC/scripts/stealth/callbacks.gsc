/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\stealth\callbacks.gsc
***********************************************/

function init_callbacks() {
  level.global_callbacks = [];

  foreach(var_1 in ["_autosave_stealthcheck", "_patrol_endon_spotted_flag", "_spawner_stealth_default", "_idle_call_idle_func"]) {
    level.global_callbacks[var_1] = &global_empty_callback;
  }

  scripts\engine\utility::flag_init("stealth_spotted");
  scripts\engine\utility::flag_init("stealth_enabled");
  scripts\engine\utility::flag_init("stealth_music_pause");
}

function global_empty_callback(var_0, var_1, var_2, var_3, var_4) {}

function stealth_get_func(var_0) {
  if(isDefined(self.stealth) && isDefined(self.stealth.funcs) && isDefined(self.stealth.funcs[var_0])) {
    return self.stealth.funcs[var_0];
  }

  if(isDefined(level.stealth) && isDefined(level.stealth.funcs)) {
    return level.stealth.funcs[var_0];
  }

  return undefined;
}

function stealth_call(var_0, var_1, var_2, var_3) {
  var_4 = stealth_get_func(var_0);

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

function stealth_call_thread(var_0, var_1, var_2, var_3) {
  var_4 = stealth_get_func(var_0);

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