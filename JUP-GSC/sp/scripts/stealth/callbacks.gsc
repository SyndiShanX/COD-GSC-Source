/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\stealth\callbacks.gsc
***********************************************/

#using scripts\common\utility;
#using scripts\engine\utility;
#namespace callbacks;

function init_callbacks() {
  level.global_callbacks = [];

  foreach(callback in ["_autosave_stealthcheck", "_patrol_endon_spotted_flag", "_spawner_stealth_default", "_idle_call_idle_func"]) {
    level.global_callbacks[callback] = &global_empty_callback;
  }

  if(!flag_exist("stealth_spotted")) {
    flag_init("stealth_spotted");
  }

  if(!flag_exist("stealth_enabled")) {
    flag_init("stealth_enabled");
  }

  if(!flag_exist("stealth_music_pause")) {
    flag_init("stealth_music_pause");
  }
}

function global_empty_callback(empty1, empty2, empty3, empty4, empty5) {
  assertmsg("a _stealth or _idle related function was called in a global script without being initilized by the stealth system.If you've already initilized those scripts, then this is a bug for Mo.");
}

function stealth_get_func(type) {
  if(isDefined(self.stealth) && isDefined(self.stealth.funcs) && isDefined(self.stealth.funcs[type])) {
    return self.stealth.funcs[type];
  }

  if(isDefined(level.stealth) && isDefined(level.stealth.funcs)) {
    return level.stealth.funcs[type];
  }

  return undefined;
}

function stealth_call(type, parm1, parm2, parm3, parm4) {
  func = stealth_get_func(type);

  if(isDefined(func)) {
    if(isDefined(parm4)) {
      return self[[func]](parm1, parm2, parm3, parm4);
    } else if(isDefined(parm3)) {
      return self[[func]](parm1, parm2, parm3);
    } else if(isDefined(parm2)) {
      return self[[func]](parm1, parm2);
    } else if(isDefined(parm1)) {
      return self[[func]](parm1);
    } else {
      return self[[func]]();
    }
  }

  return undefined;
}

function stealth_call_thread(type, parm1, parm2, parm3, parm4) {
  func = stealth_get_func(type);

  if(isDefined(func)) {
    if(isDefined(parm4)) {
      return self thread[[func]](parm1, parm2, parm3, parm4);
    } else if(isDefined(parm3)) {
      return self thread[[func]](parm1, parm2, parm3);
    } else if(isDefined(parm2)) {
      return self thread[[func]](parm1, parm2);
    } else if(isDefined(parm1)) {
      return self thread[[func]](parm1);
    } else {
      return self thread[[func]]();
    }
  }

  return undefined;
}