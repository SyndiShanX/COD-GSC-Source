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

function ref_12F5B(var_0, var_1) {
  if(!isDefined(level.ref_12F6D)) {
    level.ref_12F6D = [];
  }

  if(!isDefined(level.ref_12F6D[var_0])) {
    level.ref_12F6D[var_0] = [];
  }

  level.ref_12F6D[var_0][level.ref_12F6D[var_0].size] = var_1;
}

function ref_12F57(var_0) {
  if(!isDefined(level.ref_12F5C)) {
    level.ref_12F5C = [];
  }

  level.ref_12F5C = scripts\engine\utility::array_add(level.ref_12F5C, var_0);
}

function ref_12F58(var_0) {
  if(!isDefined(level.ref_12F5F)) {
    level.ref_12F5F = [];
  }

  level.ref_12F5F = scripts\engine\utility::array_add(level.ref_12F5F, var_0);
}

function ref_12F59(var_0, var_1) {
  if(!isDefined(level.ref_12F5E)) {
    level.ref_12F5E = [];
  }

  if(!isDefined(level.ref_12F5E[var_0])) {
    level.ref_12F5E[var_0] = [];
  }

  level.ref_12F5E[var_0][level.ref_12F5E[var_0].size] = var_1;
}

function scriptable_engineused(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(istrue(var_5)) {
    if(isDefined(level.ref_12F5F)) {
      foreach(var_7 in level.ref_12F5F) {
        [[var_7]](var_0, var_1, var_2, var_3, 0);
      }
    }

    if(isDefined(level.ref_12F5E) && isDefined(level.ref_12F5E[var_1])) {
      foreach(var_7 in level.ref_12F5E[var_1]) {
        [[var_7]](var_0, var_1, var_2, var_3, 1);
      }
    }

    return;
  }

  if(istrue(var_4)) {
    if(isDefined(level.ref_12F5C)) {
      foreach(var_7 in level.ref_12F5C) {
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

  if(isDefined(level.ref_12F6D) && isDefined(level.ref_12F6D[var_1])) {
    foreach(var_7 in level.ref_12F6D[var_1]) {
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

function ref_12F5A(var_0) {
  if(!isDefined(level.ref_12F65)) {
    level.ref_12F65 = [];
  }

  level.ref_12F65 = scripts\engine\utility::array_add(level.ref_12F65, var_0);
}

function ref_12F69(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  if(isDefined(level.ref_12F65)) {
    foreach(var_12 in level.ref_12F65) {
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