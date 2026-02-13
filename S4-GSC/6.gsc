/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 6.gsc
*************************************************/

_id_D501() {
  level.callbackplayerspawned = ::playerspawnedcallbackhandler;
  level.callbackomnvarschanged = scripts\common\omnvars_shared::callbackomnvarschanged;
  level.callbackweaponchanged = ::weaponchangedcallbackhandler;
}

_id_00F8(var_0, var_1, var_2) {
  if(isDefined(level.callbackomnvarschanged)) {
    [[level.callbackomnvarschanged]](var_0, var_1, var_2);
  }
}

_id_0102(var_0) {
  if(isDefined(level.callbackplayerspawned)) {
    self[[level.callbackplayerspawned]](var_0);
  }
}

_id_0106() {
  if(isDefined(level._id_2F59) && (!isDefined(level._id_60F6) || !level._id_60F6)) {
    [[level._id_2F59]]();
    level._id_60F6 = 1;
  }
}

_id_110F5(var_0, var_1, var_2) {
  if(isDefined(level.callbackweaponchanged)) {
    self[[level.callbackweaponchanged]](var_0, var_1, var_2);
  }
}

addlocalplayerspawnedcallback(var_0) {
  addcallback("on_localplayer_spawned", var_0);
}

removelocalplayerspawnedcallback(var_0) {
  removecallback("on_localplayer_spawned", var_0);
}

addplayerspawnedcallback(var_0) {
  addcallback("on_player_spawned", var_0);
}

removeplayerspawnedcallback(var_0) {
  removecallback("on_player_spawned", var_0);
}

addweaponchangedcallback(var_0) {
  addcallback("on_weapon_changed", var_0);
}

removeweaponchangedcallback(var_0) {
  removecallback("on_weapon_changed", var_0);
}

_id_2F23(var_0, var_1, var_2) {
  if(isDefined(level._id_0B78) && isDefined(level._id_0B78[var_0])) {
    for(var_3 = 0; var_3 < level._id_0B78[var_0].size; var_3++) {
      var_4 = level._id_0B78[var_0][var_3];

      if(!isDefined(var_4)) {
        continue;
      }
      if(isDefined(var_2)) {
        self thread[[var_4]](var_1, var_2);
        continue;
      }

      self thread[[var_4]](var_1);
    }
  }
}

addcallback(var_0, var_1) {
  if(!isDefined(level._id_0B78) || !isDefined(level._id_0B78[var_0])) {
    level._id_0B78[var_0] = [];
  }

  var_2 = level._id_0B78[var_0];

  for(var_4 = _func_0022(var_2); isDefined(var_4); var_4 = _func_0024(var_2, var_4)) {
    var_3 = var_2[var_4];

    if(var_3 == var_1) {
      return;
    }
  }

  __asm_var_clear(2)
  __asm_var_clear(0)
  level._id_0B78[var_0] = _id_0510::array_add(level._id_0B78[var_0], var_1);
}

removecallback(var_0, var_1) {
  var_2 = level._id_0B78[var_0];

  for(var_4 = _func_0022(var_2); isDefined(var_4); var_4 = _func_0024(var_2, var_4)) {
    var_3 = var_2[var_4];

    if(var_3 == var_1) {
      level._id_0B78[var_0] = _id_0510::array_remove_index(level._id_0B78[var_0], var_4, 0);
      return;
    }
  }

  __asm_var_clear(2)
}

playerspawnedcallbackhandler(var_0) {
  var_1 = self _meth_802D();

  if(var_0 == var_1) {
    thread _id_2F23("on_localplayer_spawned", var_0);
  }

  thread _id_2F23("on_player_spawned", var_0);
}

weaponchangedcallbackhandler(var_0, var_1, var_2) {
  var_3 = _func_008C();
  var_3.prevweaponname = var_1;
  var_3.currweaponname = var_2;
  thread _id_2F23("on_weapon_changed", var_0, var_3);
}