/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: common\ui.gsc
***********************************************/

lui_registercallback(var_0, var_1) {
  if(!isDefined(level.lui_callbacks))
    level.lui_callbacks = [];

  if(!isDefined(level.lui_callbacks[var_0]) || !scripts\engine\utility::array_contains(level.lui_callbacks[var_0], var_1))
    level.lui_callbacks[var_0] = scripts\engine\utility::array_add_safe(level.lui_callbacks[var_0], var_1);
}

lui_notify_callback(var_0, var_1, var_2) {
  if(isDefined(self)) {
    if(isDefined(level.lui_callbacks) && isDefined(level.lui_callbacks[var_0])) {
      foreach(var_4 in level.lui_callbacks[var_0]) {
        if(isDefined(var_2)) {
          self thread[[var_4]](var_1, var_2);
          continue;
        }

        self thread[[var_4]](var_1);
      }
    }

    if(isDefined(var_2))
      self notify("_encstr_8DEB10B1FD2F404F8B0A906083E72D1B7782", var_0, var_1, var_2);
    else
      self notify("_encstr_8DEB10B1FD2F404F8B0A906083E72D1B7782", var_0, var_1);
  }
}