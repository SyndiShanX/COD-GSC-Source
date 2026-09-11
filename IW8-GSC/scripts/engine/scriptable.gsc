/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\engine\scriptable.gsc
***********************************************/

function scriptable_setinitcallback(var_0) {
  if(!isDefined(level.scriptable_init)) {
    level.scriptable_init = [];
  }

  level.scriptable_init = scripts\engine\utility::array_add(level.scriptable_init, var_0);
}

function scriptable_engineinitialize() {
  if(isDefined(level.scriptable_init)) {
    foreach(var_1 in level.scriptable_init) {
      [[var_1]]();
    }

    return;
  }
}

function scriptable_addpostinitcallback(var_0) {
  if(!isDefined(level.scriptable_postinit)) {
    level.scriptable_postinit = [];
  }

  level.scriptable_postinit = scripts\engine\utility::array_add(level.scriptable_postinit, var_0);
}

function scriptable_enginepostinitialize() {
  if(isDefined(level.scriptable_postinit)) {
    foreach(var_1 in level.scriptable_postinit) {
      [[var_1]]();
    }

    return;
  }
}

function scriptable_addusedcallback(var_0) {
  if(!isDefined(level.scriptable_used_funcs)) {
    level.scriptable_used_funcs = [];
  }

  level.scriptable_used_funcs = scripts\engine\utility::array_add(level.scriptable_used_funcs, var_0);
}

function ref_12f5b(var_0, var_1) {
  if(!isDefined(level.ref_12f6d)) {
    level.ref_12f6d = [];
  }

  if(!isDefined(level.ref_12f6d[var_0])) {
    level.ref_12f6d[var_0] = [];
  }

  level.ref_12f6d[var_0][level.ref_12f6d[var_0].size] = var_1;
}

function ref_12f57(var_0) {
  if(!isDefined(level.ref_12f5c)) {
    level.ref_12f5c = [];
  }

  level.ref_12f5c = scripts\engine\utility::array_add(level.ref_12f5c, var_0);
}

function ref_12f58(var_0) {
  if(!isDefined(level.ref_12f5f)) {
    level.ref_12f5f = [];
  }

  level.ref_12f5f = scripts\engine\utility::array_add(level.ref_12f5f, var_0);
}

function ref_12f59(var_0, var_1) {
  if(!isDefined(level.ref_12f5e)) {
    level.ref_12f5e = [];
  }

  if(!isDefined(level.ref_12f5e[var_0])) {
    level.ref_12f5e[var_0] = [];
  }

  level.ref_12f5e[var_0][level.ref_12f5e[var_0].size] = var_1;
}

function scriptable_engineused(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(istrue(var_5)) {
    if(isDefined(level.ref_12f5f)) {
      foreach(var_7 in level.ref_12f5f) {
        [[var_7]](var_0, var_1, var_2, var_3, 0);
      }
    }

    if(isDefined(level.ref_12f5e) && isDefined(level.ref_12f5e[var_1])) {
      foreach(var_7 in level.ref_12f5e[var_1]) {
        [[var_7]](var_0, var_1, var_2, var_3, 1);
      }
    }

    return;
  }

  if(istrue(var_4)) {
    if(isDefined(level.ref_12f5c)) {
      foreach(var_7 in level.ref_12f5c) {
        [[var_7]](var_0, var_1, var_2, var_3, 1);
      }
    }

    return;
  }

  if(isDefined(level.scriptable_used_funcs)) {
    foreach(var_7 in level.scriptable_used_funcs) {
      [[var_7]](var_0, var_1, var_2, var_3, 0);
    }
  }

  if(isDefined(level.ref_12f6d) && isDefined(level.ref_12f6d[var_1])) {
    foreach(var_7 in level.ref_12f6d[var_1]) {
      [[var_7]](var_0, var_1, var_2, var_3, 1);
    }
  }
}

function scriptable_addtouchedcallback(var_0) {
  if(!isDefined(level.scriptable_touched_funcs)) {
    level.scriptable_touched_funcs = [];
  }

  level.scriptable_touched_funcs = scripts\engine\utility::array_add(level.scriptable_touched_funcs, var_0);
}

function scriptable_enginetouched(var_0, var_1, var_2, var_3) {
  if(isDefined(level.scriptable_touched_funcs)) {
    foreach(var_5 in level.scriptable_touched_funcs) {
      [[var_5]](var_0, var_1, var_2, var_3);
    }

    return;
  }
}

function ref_12f5a(var_0) {
  if(!isDefined(level.ref_12f65)) {
    level.ref_12f65 = [];
  }

  level.ref_12f65 = scripts\engine\utility::array_add(level.ref_12f65, var_0);
}

function ref_12f69(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  if(isDefined(level.ref_12f65)) {
    foreach(var_12 in level.ref_12f65) {
      [[var_12]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);
    }

    return;
  }
}

function scriptable_addnotifycallback(var_0, var_1) {
  if(!isDefined(level.scriptable_notify_callback_funcs)) {
    level.scriptable_notify_callback_funcs = [];
  }

  if(!isDefined(level.scriptable_notify_callback_funcs[var_0])) {
    level.scriptable_notify_callback_funcs[var_0] = [];
  }

  level.scriptable_notify_callback_funcs[var_0][level.scriptable_notify_callback_funcs.size] = var_1;
}

function scriptable_enginenotifycallback(var_0, var_1, var_2) {
  var_3 = var_0;

  if(!isDefined(level.scriptable_notify_callback_funcs)) {
    return;
  }

  var_4 = level.scriptable_notify_callback_funcs[var_3];

  if(!isDefined(var_4) || var_4.size == 0) {
    return;
  }

  foreach(var_6 in var_4) {
    if(isDefined(var_2)) {
      var_2[[var_6]](var_0, var_1);
      continue;
    }

    level[[var_6]](var_0, var_1);
  }
}