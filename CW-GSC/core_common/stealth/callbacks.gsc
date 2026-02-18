/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\stealth\callbacks.gsc
***********************************************/

#using scripts\core_common\flag_shared;
#namespace namespace_b2b86d39;

function init_callbacks() {
  level.global_callbacks = [];

  foreach(callback in ["_autosave_stealthcheck", "_patrol_endon_spotted_flag", "_spawner_stealth_default", "_idle_call_idle_func"]) {
    level.global_callbacks[callback] = &global_empty_callback;
  }

  level flag::init("stealth_spotted");
  level flag::init("stealth_enabled");
  level flag::init("stealth_meter_combat_alerted");
  level flag::init("stealth_music_pause");
}

function global_empty_callback(empty1, empty2, empty3, empty4, empty5) {
  assertmsg("<dev string:x38>");
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

function stealth_call(type, parm1, parm2, parm3) {
  func = stealth_get_func(type);

  if(isDefined(func)) {
    if(isDefined(parm3)) {
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

function stealth_call_thread(type, parm1, parm2, parm3) {
  func = stealth_get_func(type);

  if(isDefined(func)) {
    if(isDefined(parm3)) {
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