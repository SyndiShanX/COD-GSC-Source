/*****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\engine\scriptable.gsc
*****************************************/

#namespace scriptable;

function scriptable_setinitcallback(initcallback) {
  if(!isDefined(level.scriptable_init)) {
    level.scriptable_init = [];
  }

  level.scriptable_init[level.scriptable_init.size] = initcallback;
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

  level.scriptable_postinit[level.scriptable_postinit.size] = callback;
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

  level.scriptable_used_funcs[level.scriptable_used_funcs.size] = usedcallback;
}

function function_ecfda6e42bbe0ddc(usedcallback) {
  if(!isDefined(level.scriptable_used_funcs)) {
    return;
  }

  level.scriptable_used_funcs = arrayremove(level.scriptable_used_funcs, usedcallback);
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

function function_369a834929711390(part, usedcallback) {
  if(!isDefined(level.scriptable_used_by_part_funcs)) {
    return;
  }

  if(!isDefined(level.scriptable_used_by_part_funcs[part])) {
    return;
  }

  level.scriptable_used_by_part_funcs[part] = arrayremove(level.scriptable_used_by_part_funcs[part], usedcallback);
}

function scriptable_addautousecallback(usecallback) {
  if(!isDefined(level.scriptable_autouse_funcs)) {
    level.scriptable_autouse_funcs = [];
  }

  level.scriptable_autouse_funcs[level.scriptable_autouse_funcs.size] = usecallback;
}

function function_956535bbfd32b7d6(var_18ebde099939503b) {
  if(!isDefined(level.var_c600434e0043e180)) {
    level.var_c600434e0043e180 = [];
  }

  level.var_c600434e0043e180[level.var_c600434e0043e180.size] = var_18ebde099939503b;
}

function function_e72d5d504ed90c6f(var_18ebde099939503b) {
  if(!isDefined(level.var_c600434e0043e180)) {
    return;
  }

  level.var_c600434e0043e180 = arrayremove(level.var_c600434e0043e180, var_18ebde099939503b);
}

function scriptable_engineused(instance, part, state, player, bautouse, usestring) {
  if(bautouse) {
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

function function_904787b1a7ed4f61(instance, part, state, player) {
  result = 1;

  if(isDefined(level.var_c600434e0043e180)) {
    foreach(var_2ce9a48a48414e2b in level.var_c600434e0043e180) {
      result = result && [[var_2ce9a48a48414e2b]](instance, part, state, player);
    }
  }

  return result;
}

function function_190abcbcb4f3a47c(instance, part, state, player, useduration) {
  if(isDefined(level.var_dc7848b4278e9d43)) {
    foreach(func in level.var_dc7848b4278e9d43) {
      [[func]](instance, part, state, player, useduration);
    }
  }

  if(isDefined(level.var_4e9ab6c139c9bf3b) && isDefined(level.var_4e9ab6c139c9bf3b[part])) {
    foreach(func in level.var_4e9ab6c139c9bf3b[part]) {
      [[func]](instance, part, state, player, useduration);
    }
  }
}

function function_b49bec4b67c1221e(part, usedcallback) {
  if(!isDefined(level.var_4e9ab6c139c9bf3b)) {
    level.var_4e9ab6c139c9bf3b = [];
  }

  if(!isDefined(level.var_4e9ab6c139c9bf3b[part])) {
    level.var_4e9ab6c139c9bf3b[part] = [];
  }

  level.var_4e9ab6c139c9bf3b[part][level.var_4e9ab6c139c9bf3b[part].size] = usedcallback;
}

function function_9a667ada3074523a(callback) {
  if(!isDefined(level.var_dc7848b4278e9d43)) {
    level.var_dc7848b4278e9d43 = [];
  }

  level.var_dc7848b4278e9d43[level.var_dc7848b4278e9d43.size] = callback;
}

function function_1e33a4f0f19aa3a(instance, player) {
  result = 0;

  if(isDefined(level.var_2f0a93f86990f4d4)) {
    result = [[level.var_2f0a93f86990f4d4]](instance, player);
  }

  return result;
}

function scriptable_addtouchedcallback(touchedcallback) {
  if(!isDefined(level.scriptable_touched_funcs)) {
    level.scriptable_touched_funcs = [];
  }

  level.scriptable_touched_funcs[level.scriptable_touched_funcs.size] = touchedcallback;
}

function function_c1b772bddb62be66(var_1be521526c5ef145) {
  if(!isDefined(level.var_27e161a3bcab8269)) {
    level.var_27e161a3bcab8269 = [];
  }

  level.var_27e161a3bcab8269[level.var_27e161a3bcab8269.size] = var_1be521526c5ef145;
}

function function_be440da6d723d8e8(var_56e0bbdb3bc87831) {
  if(!isDefined(level.var_2f3d3eb6b16bc8b2)) {
    level.var_2f3d3eb6b16bc8b2 = [];
  }

  level.var_2f3d3eb6b16bc8b2[level.var_2f3d3eb6b16bc8b2.size] = var_56e0bbdb3bc87831;
}

function scriptable_enginetouched(instance, part, state, player) {
  if(isDefined(level.scriptable_touched_funcs)) {
    foreach(touched_func in level.scriptable_touched_funcs) {
      [[touched_func]](instance, part, state, player);
    }
  }
}

function function_ce0492ba57130ca4(id, scriptables) {
  if(isDefined(level.var_27e161a3bcab8269)) {
    foreach(runtime_trigger_func in level.var_27e161a3bcab8269) {
      [[runtime_trigger_func]](id, scriptables);
    }
  }
}

function function_f9851d1984d0205c(event, scriptables) {
  if(isDefined(level.var_2f3d3eb6b16bc8b2)) {
    foreach(var_729fa13d338b2289 in level.var_2f3d3eb6b16bc8b2) {
      [[var_729fa13d338b2289]](event, scriptables);
    }
  }
}

function scriptable_adddamagedcallback(damagedcallback) {
  if(!isDefined(level.scriptable_damaged_funcs)) {
    level.scriptable_damaged_funcs = [];
  }

  level.scriptable_damaged_funcs[level.scriptable_damaged_funcs.size] = damagedcallback;
}

function function_dc174fecebb79952(damagedcallback) {
  if(!isDefined(level.scriptable_damaged_funcs)) {
    return;
  }

  level.scriptable_damaged_funcs = arrayremove(level.scriptable_damaged_funcs, damagedcallback);
}

function scriptable_enginedamaged(einflictor, eattacker, instance, idamage, idflags, smeansofdeath, objweapon, vdir, shitloc, modelindex, partname) {
  if(isDefined(level.scriptable_damaged_funcs)) {
    if(function_f9c7d74d26bf4d0f() && level.var_e6d6d55c30c55761) {
      idamage = [[level.var_e6d6d55c30c55761]](einflictor, eattacker, instance, idamage, idflags, smeansofdeath, objweapon, vdir, shitloc, modelindex, partname);
    }

    foreach(used_func in level.scriptable_damaged_funcs) {
      [[used_func]](einflictor, eattacker, instance, idamage, idflags, smeansofdeath, objweapon, vdir, shitloc, modelindex, partname);
    }
  }

  instance notify("scriptable_engine_damaged", einflictor, eattacker, instance, idamage, idflags, smeansofdeath, objweapon, vdir, shitloc, modelindex, partname);
}

function function_f9c7d74d26bf4d0f() {
  return level.gamemodebundle.var_92fbf9f74ca4163d;
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

function function_65c9f35ffd4310f8(funckey, func) {
  if(!isDefined(level.scriptable_notify_callback_funcs[funckey])) {
    return;
  }

  level.scriptable_notify_callback_funcs[funckey] = arrayremove(level.scriptable_notify_callback_funcs[funckey], func);
}

function scriptable_enginenotifycallback(instance, note, param, ent, var_64ffacba090c91be) {
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
      ent[[func]](instance, note, param, var_64ffacba090c91be);
      continue;
    }

    level[[func]](instance, note, param, var_64ffacba090c91be);
  }
}