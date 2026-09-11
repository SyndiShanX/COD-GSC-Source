/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\stealth\callbacks.gsc
***********************************************/

function init_callbacks() {
  level.global_callbacks = [];

  foreach(var1 in ["_autosave_stealthcheck", "_patrol_endon_spotted_flag", "_spawner_stealth_default", "_idle_call_idle_func"]) {
    level.global_callbacks[var1] = &global_empty_callback;
  }

  scripts\engine\utility::flag_init("stealth_spotted");
  scripts\engine\utility::flag_init("stealth_enabled");
  scripts\engine\utility::flag_init("stealth_music_pause");
}

function global_empty_callback(var0, var1, var2, var3, var4) {}

function stealth_get_func(var0) {
  if(isDefined(self.stealth) && isDefined(self.stealth.funcs) && isDefined(self.stealth.funcs[var0])) {
    return self.stealth.funcs[var0];
  }

  if(isDefined(level.stealth) && isDefined(level.stealth.funcs)) {
    return level.stealth.funcs[var0];
  }

  return undefined;
}

function stealth_call(var0, var1, var2, var3) {
  var4 = stealth_get_func(var0);

  if(isDefined(var4)) {
    if(isDefined(var3)) {
      return self[[var4]](var1, var2, var3);
    } else if(isDefined(var2)) {
      return self[[var4]](var1, var2);
    } else if(isDefined(var1)) {
      return self[[var4]](var1);
    } else {
      return self[[var4]]();
    }
  }

  return undefined;
}

function stealth_call_thread(var0, var1, var2, var3) {
  var4 = stealth_get_func(var0);

  if(isDefined(var4)) {
    if(isDefined(var3)) {
      return self thread[[var4]](var1, var2, var3);
    } else if(isDefined(var2)) {
      return self thread[[var4]](var1, var2);
    } else if(isDefined(var1)) {
      return self thread[[var4]](var1);
    } else {
      return self thread[[var4]]();
    }
  }

  return undefined;
}