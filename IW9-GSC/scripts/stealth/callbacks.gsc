/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\stealth\callbacks.gsc
***********************************************/

init_callbacks() {
  level.global_callbacks = [];

  foreach(callback in ["_autosave_stealthcheck", "_patrol_endon_spotted_flag", "_spawner_stealth_default", "_idle_call_idle_func"])
  level.global_callbacks[callback] = ::global_empty_callback;

  if(!scripts\engine\utility::flag_exist("stealth_spotted"))
    scripts\engine\utility::flag_init("stealth_spotted");

  if(!scripts\engine\utility::flag_exist("stealth_enabled"))
    scripts\engine\utility::flag_init("stealth_enabled");

  if(!scripts\engine\utility::flag_exist("stealth_music_pause"))
    scripts\engine\utility::flag_init("stealth_music_pause");
}

global_empty_callback(_id_C925170BA48D0111, _id_C925140BA48CFA78, _id_C925150BA48CFCAB, _id_C9251A0BA48D07AA, _id_C9251B0BA48D09DD) {}

stealth_get_func(type) {
  if(isDefined(self.stealth) && isDefined(self.stealth.funcs) && isDefined(self.stealth.funcs[type]))
    return self.stealth.funcs[type];

  if(isDefined(level.stealth) && isDefined(level.stealth.funcs))
    return level.stealth.funcs[type];

  return undefined;
}

stealth_call(type, parm1, parm2, parm3, parm4) {
  func = stealth_get_func(type);

  if(isDefined(func)) {
    if(isDefined(parm4))
      return self[[func]](parm1, parm2, parm3, parm4);
    else if(isDefined(parm3))
      return self[[func]](parm1, parm2, parm3);
    else if(isDefined(parm2))
      return self[[func]](parm1, parm2);
    else if(isDefined(parm1))
      return self[[func]](parm1);
    else
      return self[[func]]();
  }

  return undefined;
}

stealth_call_thread(type, parm1, parm2, parm3, parm4) {
  func = stealth_get_func(type);

  if(isDefined(func)) {
    if(isDefined(parm4))
      return self thread[[func]](parm1, parm2, parm3, parm4);
    else if(isDefined(parm3))
      return self thread[[func]](parm1, parm2, parm3);
    else if(isDefined(parm2))
      return self thread[[func]](parm1, parm2);
    else if(isDefined(parm1))
      return self thread[[func]](parm1);
    else
      return self thread[[func]]();
  }

  return undefined;
}