/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\engine\scriptable.gsc
***********************************************/

function scriptable_setinitcallback(var0) {
  if(!isDefined(level.scriptable_init)) {
    level.scriptable_init = [];
  }

  level.scriptable_init = scripts\engine\utility::array_add(level.scriptable_init, var0);
}

function scriptable_engineinitialize() {
  if(isDefined(level.scriptable_init)) {
    foreach(var1 in level.scriptable_init) {
      [[var1]]();
    }

    return;
  }
}

function scriptable_addpostinitcallback(var0) {
  if(!isDefined(level.scriptable_postinit)) {
    level.scriptable_postinit = [];
  }

  level.scriptable_postinit = scripts\engine\utility::array_add(level.scriptable_postinit, var0);
}

function scriptable_enginepostinitialize() {
  if(isDefined(level.scriptable_postinit)) {
    foreach(var1 in level.scriptable_postinit) {
      [[var1]]();
    }

    return;
  }
}

function scriptable_addusedcallback(var0) {
  if(!isDefined(level.scriptable_used_funcs)) {
    level.scriptable_used_funcs = [];
  }

  level.scriptable_used_funcs = scripts\engine\utility::array_add(level.scriptable_used_funcs, var0);
}

function ref_12f5b(var0, var1) {
  if(!isDefined(level.ref_12f6d)) {
    level.ref_12f6d = [];
  }

  if(!isDefined(level.ref_12f6d[var0])) {
    level.ref_12f6d[var0] = [];
  }

  level.ref_12f6d[var0][level.ref_12f6d[var0].size] = var1;
}

function ref_12f57(var0) {
  if(!isDefined(level.ref_12f5c)) {
    level.ref_12f5c = [];
  }

  level.ref_12f5c = scripts\engine\utility::array_add(level.ref_12f5c, var0);
}

function ref_12f58(var0) {
  if(!isDefined(level.ref_12f5f)) {
    level.ref_12f5f = [];
  }

  level.ref_12f5f = scripts\engine\utility::array_add(level.ref_12f5f, var0);
}

function ref_12f59(var0, var1) {
  if(!isDefined(level.ref_12f5e)) {
    level.ref_12f5e = [];
  }

  if(!isDefined(level.ref_12f5e[var0])) {
    level.ref_12f5e[var0] = [];
  }

  level.ref_12f5e[var0][level.ref_12f5e[var0].size] = var1;
}

function scriptable_engineused(var0, var1, var2, var3, var4, var5) {
  if(istrue(var5)) {
    if(isDefined(level.ref_12f5f)) {
      foreach(var7 in level.ref_12f5f) {
        [[var7]](var0, var1, var2, var3, 0);
      }
    }

    if(isDefined(level.ref_12f5e) && isDefined(level.ref_12f5e[var1])) {
      foreach(var7 in level.ref_12f5e[var1]) {
        [[var7]](var0, var1, var2, var3, 1);
      }
    }

    return;
  }

  if(istrue(var4)) {
    if(isDefined(level.ref_12f5c)) {
      foreach(var7 in level.ref_12f5c) {
        [[var7]](var0, var1, var2, var3, 1);
      }
    }

    return;
  }

  if(isDefined(level.scriptable_used_funcs)) {
    foreach(var7 in level.scriptable_used_funcs) {
      [[var7]](var0, var1, var2, var3, 0);
    }
  }

  if(isDefined(level.ref_12f6d) && isDefined(level.ref_12f6d[var1])) {
    foreach(var7 in level.ref_12f6d[var1]) {
      [[var7]](var0, var1, var2, var3, 1);
    }
  }
}

function scriptable_addtouchedcallback(var0) {
  if(!isDefined(level.scriptable_touched_funcs)) {
    level.scriptable_touched_funcs = [];
  }

  level.scriptable_touched_funcs = scripts\engine\utility::array_add(level.scriptable_touched_funcs, var0);
}

function scriptable_enginetouched(var0, var1, var2, var3) {
  if(isDefined(level.scriptable_touched_funcs)) {
    foreach(var5 in level.scriptable_touched_funcs) {
      [[var5]](var0, var1, var2, var3);
    }

    return;
  }
}

function ref_12f5a(var0) {
  if(!isDefined(level.ref_12f65)) {
    level.ref_12f65 = [];
  }

  level.ref_12f65 = scripts\engine\utility::array_add(level.ref_12f65, var0);
}

function ref_12f69(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10) {
  if(isDefined(level.ref_12f65)) {
    foreach(var12 in level.ref_12f65) {
      [[var12]](var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10);
    }

    return;
  }
}

function scriptable_addnotifycallback(var0, var1) {
  if(!isDefined(level.scriptable_notify_callback_funcs)) {
    level.scriptable_notify_callback_funcs = [];
  }

  if(!isDefined(level.scriptable_notify_callback_funcs[var0])) {
    level.scriptable_notify_callback_funcs[var0] = [];
  }

  level.scriptable_notify_callback_funcs[var0][level.scriptable_notify_callback_funcs.size] = var1;
}

function scriptable_enginenotifycallback(var0, var1, var2) {
  var3 = var0;

  if(!isDefined(level.scriptable_notify_callback_funcs)) {
    return;
  }

  var4 = level.scriptable_notify_callback_funcs[var3];

  if(!isDefined(var4) || var4.size == 0) {
    return;
  }

  foreach(var6 in var4) {
    if(isDefined(var2)) {
      var2[[var6]](var0, var1);
      continue;
    }

    level[[var6]](var0, var1);
  }
}