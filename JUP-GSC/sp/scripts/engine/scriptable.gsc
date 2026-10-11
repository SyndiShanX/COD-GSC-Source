/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\engine\scriptable.gsc
***********************************************/

#using scripts\engine\utility;
#namespace scriptable;

function scriptable_setinitcallback(initcallback) {
  if(!isDefined(level.scriptable_init)) {
    level.scriptable_init = [];
  }

  level.scriptable_init = array_add(level.scriptable_init, initcallback);
}

function scriptable_engineinitialize() {
  if(isDefined(level.scriptable_init)) {
    foreach(init_func in level.scriptable_init) {
      [[init_func]]();
    }
  }
}

function scriptable_addpostinitcallback(callback) {
  if(!isDefined(level.scriptable_postinit)) {
    level.scriptable_postinit = [];
  }

  level.scriptable_postinit = array_add(level.scriptable_postinit, callback);
}

function scriptable_enginepostinitialize() {
  if(isDefined(level.scriptable_postinit)) {
    foreach(func in level.scriptable_postinit) {
      [[func]]();
    }
  }
}

function scriptable_addusedcallback(usedcallback) {
  if(!isDefined(level.scriptable_used_funcs)) {
    level.scriptable_used_funcs = [];
  }

  level.scriptable_used_funcs = array_add(level.scriptable_used_funcs, usedcallback);
}

function scriptable_addusedcallbackbypart(part, usedcallback) {
  if(!isDefined(level.scriptable_used_by_part_funcs)) {
    level.scriptable_used_by_part_funcs = [];
  }

  if(!isDefined(level.scriptable_used_by_part_funcs[part])) {
    level.scriptable_used_by_part_funcs[part] = [];
  }

  level.scriptable_used_by_part_funcs[part][level.scriptable_used_by_part_funcs[part].size] = usedcallback;
}

function scriptable_addautousecallback(usecallback) {
  if(!isDefined(level.scriptable_autouse_funcs)) {
    level.scriptable_autouse_funcs = [];
  }

  level.scriptable_autouse_funcs = array_add(level.scriptable_autouse_funcs, usecallback);
}

function scriptable_engineused(instance, part, state, player, bautouse, usestring) {
  if(istrue(bautouse)) {
    if(isDefined(level.scriptable_autouse_funcs)) {
      foreach(used_func in level.scriptable_autouse_funcs) {
        [[used_func]](instance, part, state, player, 1, usestring);
      }
    }

    return;
  }

  if(isDefined(level.scriptable_used_funcs)) {
    foreach(used_func in level.scriptable_used_funcs) {
      [[used_func]](instance, part, state, player, 0, usestring);
    }
  }

  if(isDefined(level.scriptable_used_by_part_funcs) && isDefined(level.scriptable_used_by_part_funcs[part])) {
    foreach(used_func in level.scriptable_used_by_part_funcs[part]) {
      [[used_func]](instance, part, state, player, 1, usestring);
    }
  }
}

function function_2cdeacfad7141a8d(instance, part, state, player, useduration) {
  if(isDefined(level.var_b80c82a60480a43c)) {
    foreach(func in level.var_b80c82a60480a43c) {
      [[func]](instance, part, state, player, useduration);
    }
  }

  if(isDefined(level.var_5aa42233dc7bddcc) && isDefined(level.var_5aa42233dc7bddcc[part])) {
    foreach(func in level.var_5aa42233dc7bddcc[part]) {
      [[func]](instance, part, state, player, useduration);
    }
  }
}

function function_9a0a13a69553c5a5(part, usedcallback) {
  if(!isDefined(level.var_5aa42233dc7bddcc)) {
    level.var_5aa42233dc7bddcc = [];
  }

  if(!isDefined(level.var_5aa42233dc7bddcc[part])) {
    level.var_5aa42233dc7bddcc[part] = [];
  }

  level.var_5aa42233dc7bddcc[part] = array_add(level.var_5aa42233dc7bddcc[part], usedcallback);
}

function function_8daea885ec058271(callback) {
  if(!isDefined(level.var_b80c82a60480a43c)) {
    level.var_b80c82a60480a43c = [];
  }

  level.var_b80c82a60480a43c = array_add(level.var_b80c82a60480a43c, callback);
}

function function_43f2de646836802d(instance, player) {
  result = 0;

  if(isDefined(level.var_b8e67f48a1d47883)) {
    result = [[level.var_b8e67f48a1d47883]](instance, player);
  }

  return result;
}

function scriptable_addtouchedcallback(touchedcallback) {
  if(!isDefined(level.scriptable_touched_funcs)) {
    level.scriptable_touched_funcs = [];
  }

  level.scriptable_touched_funcs = array_add(level.scriptable_touched_funcs, touchedcallback);
}

function scriptable_enginetouched(instance, part, state, player) {
  if(isDefined(level.scriptable_touched_funcs)) {
    foreach(touched_func in level.scriptable_touched_funcs) {
      [[touched_func]](instance, part, state, player);
    }
  }
}

function scriptable_adddamagedcallback(damagedcallback) {
  if(!isDefined(level.scriptable_damaged_funcs)) {
    level.scriptable_damaged_funcs = [];
  }

  level.scriptable_damaged_funcs = array_add(level.scriptable_damaged_funcs, damagedcallback);
}

function scriptable_enginedamaged(einflictor, eattacker, instance, idamage, idflags, smeansofdeath, objweapon, vdir, shitloc, modelindex, partname) {
  if(isDefined(level.scriptable_damaged_funcs)) {
    foreach(used_func in level.scriptable_damaged_funcs) {
      [[used_func]](einflictor, eattacker, instance, idamage, idflags, smeansofdeath, objweapon, vdir, shitloc, modelindex, partname);
    }
  }
}

function scriptable_addnotifycallback(funckey, func) {
  if(!isDefined(level.scriptable_notify_callback_funcs)) {
    level.scriptable_notify_callback_funcs = [];
  }

  if(!isDefined(level.scriptable_notify_callback_funcs[funckey])) {
    level.scriptable_notify_callback_funcs[funckey] = [];
  }

  level.scriptable_notify_callback_funcs[funckey][level.scriptable_notify_callback_funcs[funckey].size] = func;
}

function scriptable_enginenotifycallback(instance, note, param, ent, instigator) {
  funckey = note;

  if(!isDefined(level.scriptable_notify_callback_funcs)) {
    return;
  }

  funcarray = level.scriptable_notify_callback_funcs[funckey];

  if(!isDefined(funcarray) || funcarray.size == 0) {
    return;
  }

  foreach(func in funcarray) {
    if(isDefined(ent)) {
      ent[[func]](instance, note, param, instigator);
      continue;
    }

    level[[func]](instance, note, param, instigator);
  }
}