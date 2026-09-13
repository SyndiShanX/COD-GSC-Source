/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\engine\scriptable.gsc
***********************************************/

scriptable_setinitcallback(_id_DAD9B8459425C9D8) {
  if(!isDefined(level.scriptable_init))
    level.scriptable_init = [];

  level.scriptable_init = scripts\engine\utility::array_add(level.scriptable_init, _id_DAD9B8459425C9D8);
}

scriptable_engineinitialize() {
  if(isDefined(level.scriptable_init)) {
    foreach(init_func in level.scriptable_init)[[init_func]]();
  }
}

scriptable_addpostinitcallback(callback) {
  if(!isDefined(level.scriptable_postinit))
    level.scriptable_postinit = [];

  level.scriptable_postinit = scripts\engine\utility::array_add(level.scriptable_postinit, callback);
}

scriptable_enginepostinitialize() {
  if(isDefined(level.scriptable_postinit)) {
    foreach(func in level.scriptable_postinit)[[func]]();
  }
}

scriptable_addusedcallback(_id_055AA0066A9F3E9F) {
  if(!isDefined(level.scriptable_used_funcs))
    level.scriptable_used_funcs = [];

  level.scriptable_used_funcs = scripts\engine\utility::array_add(level.scriptable_used_funcs, _id_055AA0066A9F3E9F);
}

scriptable_addusedcallbackbypart(part, _id_055AA0066A9F3E9F) {
  if(!isDefined(level.scriptable_used_by_part_funcs))
    level.scriptable_used_by_part_funcs = [];

  if(!isDefined(level.scriptable_used_by_part_funcs[part]))
    level.scriptable_used_by_part_funcs[part] = [];

  level.scriptable_used_by_part_funcs[part][level.scriptable_used_by_part_funcs[part].size] = _id_055AA0066A9F3E9F;
}

scriptable_addautousecallback(usecallback) {
  if(!isDefined(level.scriptable_autouse_funcs))
    level.scriptable_autouse_funcs = [];

  level.scriptable_autouse_funcs = scripts\engine\utility::array_add(level.scriptable_autouse_funcs, usecallback);
}

scriptable_engineused(instance, part, state, player, _id_A5B2C541413AA895, _id_CC38472E36BE1B61) {
  if(istrue(_id_A5B2C541413AA895)) {
    if(isDefined(level.scriptable_autouse_funcs)) {
      foreach(_id_58F77E58A4EC14CB in level.scriptable_autouse_funcs)[[_id_58F77E58A4EC14CB]](instance, part, state, player, 1, _id_CC38472E36BE1B61);
    }
  } else {
    if(isDefined(level.scriptable_used_funcs)) {
      foreach(_id_58F77E58A4EC14CB in level.scriptable_used_funcs)[[_id_58F77E58A4EC14CB]](instance, part, state, player, 0, _id_CC38472E36BE1B61);
    }

    if(isDefined(level.scriptable_used_by_part_funcs) && isDefined(level.scriptable_used_by_part_funcs[part])) {
      foreach(_id_58F77E58A4EC14CB in level.scriptable_used_by_part_funcs[part])[[_id_58F77E58A4EC14CB]](instance, part, state, player, 1, _id_CC38472E36BE1B61);
    }
  }
}

_id_43F2DE646836802D(instance, player) {
  result = 0;

  if(isDefined(level._id_B8E67F48A1D47883))
    result = [[level._id_B8E67F48A1D47883]](instance, player);

  return result;
}

scriptable_addtouchedcallback(_id_702AAE5D8EBC0626) {
  if(!isDefined(level.scriptable_touched_funcs))
    level.scriptable_touched_funcs = [];

  level.scriptable_touched_funcs = scripts\engine\utility::array_add(level.scriptable_touched_funcs, _id_702AAE5D8EBC0626);
}

scriptable_enginetouched(instance, part, state, player) {
  if(isDefined(level.scriptable_touched_funcs)) {
    foreach(_id_4CE7B25E56E36048 in level.scriptable_touched_funcs)[[_id_4CE7B25E56E36048]](instance, part, state, player);
  }
}

scriptable_adddamagedcallback(_id_5032486BBDDB00D3) {
  if(!isDefined(level.scriptable_damaged_funcs))
    level.scriptable_damaged_funcs = [];

  level.scriptable_damaged_funcs = scripts\engine\utility::array_add(level.scriptable_damaged_funcs, _id_5032486BBDDB00D3);
}

scriptable_enginedamaged(einflictor, eattacker, instance, idamage, idflags, smeansofdeath, objweapon, vdir, shitloc, modelindex, partname) {
  if(isDefined(level.scriptable_damaged_funcs)) {
    foreach(_id_58F77E58A4EC14CB in level.scriptable_damaged_funcs)[[_id_58F77E58A4EC14CB]](einflictor, eattacker, instance, idamage, idflags, smeansofdeath, objweapon, vdir, shitloc, modelindex, partname);
  }

  instance notify("scriptable_engine_damaged", einflictor, eattacker, instance, idamage, idflags, smeansofdeath, objweapon, vdir, shitloc, modelindex, partname);
}

scriptable_addnotifycallback(_id_6BC01EC47BEC43B2, func) {
  if(!isDefined(level.scriptable_notify_callback_funcs))
    level.scriptable_notify_callback_funcs = [];

  if(!isDefined(level.scriptable_notify_callback_funcs[_id_6BC01EC47BEC43B2]))
    level.scriptable_notify_callback_funcs[_id_6BC01EC47BEC43B2] = [];

  level.scriptable_notify_callback_funcs[_id_6BC01EC47BEC43B2][level.scriptable_notify_callback_funcs.size] = func;
}

scriptable_enginenotifycallback(_id_A234A65C378F3289, param, ent) {
  _id_6BC01EC47BEC43B2 = _id_A234A65C378F3289;

  if(!isDefined(level.scriptable_notify_callback_funcs)) {
    return;
  }
  _id_FE7E82F6D37CDA80 = level.scriptable_notify_callback_funcs[_id_6BC01EC47BEC43B2];

  if(!isDefined(_id_FE7E82F6D37CDA80) || _id_FE7E82F6D37CDA80.size == 0) {
    return;
  }
  foreach(func in _id_FE7E82F6D37CDA80) {
    if(isDefined(ent)) {
      ent[[func]](_id_A234A65C378F3289, param);
      continue;
    }

    level[[func]](_id_A234A65C378F3289, param);
  }
}