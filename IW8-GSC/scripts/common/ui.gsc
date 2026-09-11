/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\common\ui.gsc
***********************************************/

function lui_registercallback(var0, var1) {
  if(!isDefined(level.lui_callbacks)) {
    level.lui_callbacks = [];
  }

  if(!isDefined(level.lui_callbacks[var0]) || !scripts\engine\utility::array_contains(level.lui_callbacks[var0], var1)) {
    level.lui_callbacks[var0] = scripts\engine\utility::array_add_safe(level.lui_callbacks[var0], var1);
    return;
  }
}

function lui_notify_callback(var0, var1, var2) {
  if(isDefined(self)) {
    if(isDefined(level.lui_callbacks) && isDefined(level.lui_callbacks[var0])) {
      foreach(var4 in level.lui_callbacks[var0]) {
        if(isDefined(var2)) {
          self thread[[var4]](var1, var2);
          continue;
        }

        self thread[[var4]](var1);
      }
    }

    if(isDefined(var2)) {
      self notify("luinotifyserver", var0, var1, var2);
      return;
    }

    self notify("luinotifyserver", var0, var1);
    return;
  }
}